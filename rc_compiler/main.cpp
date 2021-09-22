#include <cstdlib>
#include <deque>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <regex>
#include <sstream>

std::deque<std::string> compile(std::deque<std::string> rc_lines)
{
    std::deque<std::string> compiled_rc;
    std::deque<std::string> export_paths;
    std::deque<std::tuple<std::string, std::string>> export_vars;

    std::regex is_comment_re{R"(^\s*#)"};
    std::regex is_empty_re{R"(^\s*$)"};
    std::regex replace_comment_re{R"(#[^'"]*$)"};
    std::regex path_export_re{R"(^export PATH="(\S+):\$PATH"\s*$)"};
    std::regex var_export_re{R"esc(^export (\S+)="(\S+)"\s*$)esc"};

    for (auto line : rc_lines) {
        if (std::regex_search(line, is_comment_re)) continue;
        if (std::regex_search(line, is_empty_re)) continue;

        std::string line_comment_removed = std::regex_replace(line, replace_comment_re, "");

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
    char buffer[1024];
    for (const fs::directory_entry& entry : fs::directory_iterator(modules_path)) {
        if (not std::regex_search(entry.path().generic_string(), is_shellfile_re)) {
            continue;
        }
        std::ifstream shell_file(entry.path());
        while (true) {
            shell_file.getline(buffer, sizeof(buffer));
            if (shell_file.bad() || shell_file.eof()) {
                break;
            }
            rc_lines.emplace_back(buffer);
        }
    }

    rc_lines = compile(rc_lines);

    std::ofstream zshrc(home_path / ".zshrc");
    for (auto line : rc_lines) {
        zshrc << line << std::endl;
    }

    return 0;
}
