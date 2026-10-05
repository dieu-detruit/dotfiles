# zplug (zsh plugin manager)
export ZPLUG_HOME=$HOME/.zplug

# locale setting
export LANG=en_US.UTF-8

# init.zsh がやっていた fpath の重複排除を引き継ぐ。
typeset -U fpath

# zplug のローダーは git/awk/mkdir/touch/diff を起動し、compinit をもう一度回す。
# インストール済みプラグインを直接読めばそれらは要らない。
source $ZPLUG_HOME/repos/zsh-users/zsh-completions/zsh-completions.plugin.zsh
source $ZPLUG_HOME/repos/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zsh-notify は長いコマンドの終了を通知する。このマシンには必要な外部コマンドが無いので
# 動かない。揃ったときだけ読む。
if [[ "$DISPLAY" != '' ]] && command -v xdotool >/dev/null 2>&1 && command -v wmctrl >/dev/null 2>&1; then
  source $ZPLUG_HOME/repos/marzocchi/zsh-notify/notify.plugin.zsh
fi

# zplug の CLI を残す。起動時には何も読まない。初回の zplug 呼び出しで
# init.zsh を読み込み、その場で本物の関数に置き換わる。
zplug() { unfunction zplug; source $ZPLUG_HOME/init.zsh && zplug "$@"; }
