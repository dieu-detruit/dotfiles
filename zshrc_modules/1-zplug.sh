# zplug (zsh plugin manager)
export ZPLUG_HOME=$HOME/.zplug
source $ZPLUG_HOME/init.zsh

# locale setting
export LANG=en_US.UTF-8

zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-completions"
zplug "marzocchi/zsh-notify"

zplug load
