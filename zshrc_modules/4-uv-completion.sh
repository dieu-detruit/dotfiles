if command -v uv >/dev/null 2>&1; then
  #compdef uv

  eval "$(uv generate-shell-completion zsh)"

  _uv_run_mod() {
      if [[ "$words[2]" == "run" && "$words[CURRENT]" != -* ]]; then
          _arguments '*:filename:_files'
      else
          _uv "$@"
      fi
  }
  compdef _uv_run_mod uv
fi
