# zplug (zsh plugin manager)
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

source ~/.zshrc_modules/python.sh

# locale setting
export LANG=en_US.UTF-8

# powerline setting module
source ~/.zshrc_modules/powerline.sh

# alias setting module
source ~/.zshrc_modules/alias.sh

# zsh completion setting module
source ~/.zshrc_modules/zsh-completions.sh

# PATH setting module
source ~/.zshrc_modules/path.sh
