if command -v uv >/dev/null 2>&1; then
  #compdef uv

  # uv の補完は 552 KB あり、毎回 eval するとパースだけで 75 ms かかる。
  # zcompile 済みのキャッシュを読めば 2.7 ms。隣に .zwc があれば source が自動で使う。
  if [[ -f $HOME/.cache/zsh/uv-comp.zsh ]]; then
    source $HOME/.cache/zsh/uv-comp.zsh
  else
    eval "$(uv generate-shell-completion zsh)"
  fi

  _uv_run_mod() {
      if [[ "$words[2]" == "run" && "$words[CURRENT]" != -* ]]; then
          _arguments '*:filename:_files'
      else
          _uv "$@"
      fi
  }
  compdef _uv_run_mod uv
fi
