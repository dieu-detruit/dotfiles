#include <cassert>
#include <cstdlib>
#include <deque>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <regex>
#include <sstream>

template <class Arg>
inline void make_command_impl(std::ostream& os, Arg arg)
{
    os << arg;
}

template <class Arg0, class... Args>
inline void make_command_impl(std::ostream& os, Arg0 arg0, Args... args)
{
    os << arg0 << ' ';
    make_command_impl(os, args...);
}

template <class... Args>
std::string make_command(Args... args)
{
    std::ostringstream oss;
    make_command_impl(oss, args...);
    return oss.str();
}

void shell(std::string command)
{
    int command_result = std::system(command.c_str());
    if (command_result != 0) {
        std::cerr << '"' << command << '"' << " failed" << std::endl;
    }
    assert(command_result == 0);
}


std::deque<std::string> compile(std::deque<std::string> rc_lines)
{
    std::deque<std::string> compiled_rc;
    std::deque<std::string> export_paths;
    std::deque<std::tuple<std::string, std::string>> export_vars;

    std::regex is_comment_re{R"(^\s*#)"};
    std::regex is_empty_re{R"(^\s*$)"};
    //std::regex replace_comment_re{R"esc(\s+#[^'"]*$)esc", std::regex_constants::ECMAScript};
    std::regex path_export_re{R"(^export PATH="(\S+):\$PATH"\s*$)"};
    std::regex var_export_re{R"esc(^export (\S+)="(\S+)"\s*$)esc"};

    for (auto line : rc_lines) {
        if (std::regex_search(line, is_comment_re)) continue;
        if (std::regex_search(line, is_empty_re)) continue;

        //std::string line_comment_removed = std::regex_replace(line, replace_comment_re, "");
        std::string line_comment_removed = line;

        {
            std::smatch match_result;
            if (std::regex_search(line_comment_removed, match_result, path_export_re)) {
                export_paths.emplace_back(match_result[1].str());
                continue;
            }
        }

        {
            std::smatch match_result;
            if (std::regex_search(line_comment_removed, match_result, var_export_re)) {
                export_vars.emplace_back(std::make_tuple(match_result[1].str(), match_result[2].str()));
                continue;
            }
        }

        compiled_rc.emplace_back(line_comment_removed);
    }
    export_vars.emplace_back(std::make_tuple("HOME", std::getenv("HOME")));

    export_paths.emplace_back(BINARY_PATH);
    std::string compiled_path_export;
    {
        std::ostringstream export_path_oss;
        export_path_oss << "export PATH=\"";

        for (const auto& export_path : export_paths) {
            export_path_oss << export_path << ':';
        }
        export_path_oss << "$PATH\"";
        compiled_path_export = export_path_oss.str();
    }

    for (auto [varname, content] : export_vars) {
        std::regex var_re{std::string(R"(\$)") + varname};
        compiled_path_export = std::regex_replace(compiled_path_export, var_re, content);
        for (std::string& line : compiled_rc) {
            line = std::regex_replace(line, var_re, content);
        }
    }

    compiled_rc.push_front(compiled_path_export);

    return compiled_rc;
}

int main()
{
    namespace fs = std::filesystem;

    const fs::path home_path = std::getenv("HOME");
    const fs::path modules_path = home_path / ".zshrc_modules";

    std::deque<std::string> rc_lines;

    std::regex is_shellfile_re{".sh$"};
    std::vector<fs::path> modules_path_sorted;
    for (const fs::directory_entry& entry : fs::directory_iterator(modules_path)) {
        if (not std::regex_search(entry.path().generic_string(), is_shellfile_re)) {
            continue;
        }
        modules_path_sorted.emplace_back(entry.path());
    }
    std::sort(modules_path_sorted.begin(), modules_path_sorted.end(),
        [](const fs::path& a, const fs::path& b) { return a.generic_string() < b.generic_string(); });

    char buffer[1024];
    for (auto module_path : modules_path_sorted) {
        std::ifstream shell_file(module_path);
        while (true) {
            shell_file.getline(buffer, sizeof(buffer));
            if (shell_file.bad() || shell_file.eof()) {
                break;
            }
            rc_lines.emplace_back(buffer);
        }
    }

    rc_lines = compile(rc_lines);

    const fs::path zshrc_path = home_path / ".zshrc";
    std::ofstream zshrc(zshrc_path);
    for (auto line : rc_lines) {
        zshrc << line << std::endl;
    }

    auto zcompile_command = make_command(
        "source", (home_path / ".zplug" / "init.zsh").generic_string(), "&&",
        "zcompile", zshrc_path.generic_string());

    shell(make_command("zsh", "-c", '"', zcompile_command, '"'));

    return 0;
}
