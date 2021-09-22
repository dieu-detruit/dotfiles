# zplug (zsh plugin manager)
export ZPLUG_HOME=~/.zplug
source $ZPLUG_HOME/init.zsh

source ~/.zshrc_modules/python.sh

# locale setting
export LANG=en_US.UTF-8

# powerline setting module
source ~/.zshrc_modules/powerline.sh

# alias setting module
source ~/.zshrc_modules/alias.sh

# zsh completion setting module
#source ~/.zshrc_modules/zsh-completions.sh

# PATH setting module
source ~/.zshrc_modules/path.sh

# ROS Settings
source ~/.zshrc_modules/ros.sh

# conda settings
#source ~/.zshrc_modules/conda.sh

# vulcan sdk
source ~/tools/libs/vulkan/1.2.176.1/setup-env.sh
