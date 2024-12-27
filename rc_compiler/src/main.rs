use dirs;
use regex::Regex;
use std::collections::VecDeque;
use std::env;
use std::fs::{self, File};
use std::io::{BufRead, BufReader, Write};
use std::path::PathBuf;
use std::process::Command;

fn get_binary_path() -> PathBuf {
    env::current_exe()
        .expect("Failed to get current executable path")
        .parent()
        .expect("Failed to get binary directory")
        .to_path_buf()
}

struct RcCompiler {
    is_comment_re: Regex,
    is_empty_re: Regex,
    path_export_top_re: Regex,
    path_export_bottom_re: Regex,
    var_export_re: Regex,
    binary_path: PathBuf,
}

impl RcCompiler {
    fn new() -> Self {
        Self {
            is_comment_re: Regex::new(r"^\s*#").unwrap(),
            is_empty_re: Regex::new(r"^\s*$").unwrap(),
            path_export_top_re: Regex::new(r#"^export PATH="(\S+):\$PATH"\s*$"#).unwrap(),
            path_export_bottom_re: Regex::new(r#"^export PATH="\$PATH:(\S+)"\s*$"#).unwrap(),
            var_export_re: Regex::new(r#"^export (\S+)=(\S+)\s*$"#).unwrap(),
            binary_path: get_binary_path(),
        }
    }

    fn compile(&self, rc_lines: VecDeque<String>) -> VecDeque<String> {
        let mut compiled_rc = VecDeque::new();
        let mut export_paths = VecDeque::new();
        let mut export_vars = VecDeque::new();

        for line in rc_lines {
            if self.is_comment_re.is_match(&line) || self.is_empty_re.is_match(&line) {
                continue;
            }

            let line_comment_removed = line;

            if let Some(caps) = self.path_export_top_re.captures(&line_comment_removed) {
                export_paths.push_front(caps[1].to_string());
                continue;
            }

            if let Some(caps) = self.path_export_bottom_re.captures(&line_comment_removed) {
                export_paths.push_back(caps[1].to_string());
                continue;
            }

            if let Some(caps) = self.var_export_re.captures(&line_comment_removed) {
                export_vars.push_back((caps[1].trim_matches('"').to_string(), caps[2].to_string()));
                continue;
            }

            compiled_rc.push_back(line_comment_removed);
        }

        // add HOME to var export
        if let Some(home) = dirs::home_dir() {
            export_vars.push_back(("HOME".to_string(), home.to_string_lossy().to_string()));
        }

        // add path to rc_compiler to path export
        export_paths.push_back(self.binary_path.to_string_lossy().to_string());

        // compile path export
        let mut compiled_path_export = format!(
            r#"export PATH="{}:${{PATH}}""#,
            export_paths
                .iter()
                .map(|s| s.to_string())
                .collect::<Vec<_>>()
                .join(":")
        );

        // expand exported variables in path
        for (varname, content) in &export_vars {
            if varname == "PATH" {
                continue;
            }

            let var_re = Regex::new(&format!(r"\${}", varname)).unwrap();
            compiled_path_export = var_re
                .replace_all(&compiled_path_export, content)
                .to_string();

            for line in &mut compiled_rc {
                *line = var_re.replace_all(line, content).to_string();
            }
        }

        compiled_rc.push_front(compiled_path_export);
        compiled_rc
    }

    fn run_zcompile(&self, zshrc_path: &PathBuf, zplug_init_path: &PathBuf) {
        let status = Command::new("zsh")
            .args([
                "-c",
                &format!(
                    "source {} && zcompile {}",
                    zplug_init_path.to_string_lossy(),
                    zshrc_path.to_string_lossy()
                ),
            ])
            .status()
            .expect("failed to run zsh");

        assert!(
            status.success(),
            "failed to run zcompile: {}",
            zshrc_path.display()
        );
    }

    fn run_compile(
        &self,
        modules_path: &PathBuf,
        zshrc_path: &PathBuf,
        zplug_init_path: &PathBuf,
    ) -> std::io::Result<()> {
        let mut rc_lines = VecDeque::new();

        // get all the shell files in the modules path
        let is_shell_file_re = Regex::new(r"\.sh$").unwrap();
        let is_shell_file =
            |path: &PathBuf| is_shell_file_re.is_match(path.to_str().unwrap_or_default());

        let mut module_path_list: Vec<PathBuf> = fs::read_dir(&modules_path)?
            .filter_map(|entry| entry.ok())
            .filter(|entry| entry.file_type().unwrap().is_file())
            .map(|entry| entry.path())
            .filter(|path| is_shell_file(path))
            .collect();
        module_path_list.sort_by(|a, b| a.to_str().cmp(&b.to_str()));

        for module_path in &module_path_list {
            let file = File::open(module_path)?;
            let reader = BufReader::new(file);
            for line in reader.lines() {
                if let Ok(line) = line {
                    rc_lines.push_back(line);
                }
            }
        }

        let rc_lines = self.compile(rc_lines);

        let mut zshrc = File::create(&zshrc_path)?;

        for line in rc_lines {
            writeln!(zshrc, "{}", line)?;
        }

        self.run_zcompile(&zshrc_path, &zplug_init_path);

        Ok(())
    }
}

fn main() -> std::io::Result<()> {
    let home_path = dirs::home_dir().expect("Failed to get home directory");
    let modules_path = home_path.join(".zshrc_modules");
    let zshrc_path = home_path.join(".zshrc");
    let zplug_init_path = home_path.join(".zplug").join("init.zsh");

    let rc_compiler = RcCompiler::new();
    rc_compiler
        .run_compile(&modules_path, &zshrc_path, &zplug_init_path)
        .unwrap();

    Ok(())
}
