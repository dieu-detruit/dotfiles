# override command with option
alias ls='ls --color=auto'
alias la='ls -a --color=auto'
alias ll='ls -a --color=auto'

alias vi='nvim -O'
alias vim='nvim -O'
alias v='nvim -O'
alias vimm='nvim -O'

alias g++='g++-10 -std=c++20'

# directory shortcut
alias tcd='cd ~/Documents/main'
alias rcd='cd ~/RoboTech'
alias lab='cd ~/mimuralab'

# useful alias
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"

alias json_pretty="python -c 'import sys,json;print(json.dumps(json.loads(sys.stdin.read()),indent=4,ensure_ascii=False))'"

jpt () {
    jupyter-lab --notebook-dir=$(pwd)
}

alias :q='cd ..'

alias ssh_hyperkit="screen ~/Library/Containers/com.docker.docker/Data/vms/0/tty"

## unzip file zipped in defected OS
unzip_win () {
    set argc (count $argv)
    if [ $ARGC -ne 2 ]; then
        echo invalid arguments. Usage: unzip_win [zipfile_path] [dest]
    else
        ditto -V -x -k --sequesterRsrc --rsrc $argv[1] $argv[2]
    fi
}

alias uefi_open='sudo systemctl reboot --firmware-setup'

alias open='xdg-open'

inkscape () {
    nohup /bin/env inkscape $* > /dev/null &
}

alias noetic='source /opt/ros/noetic/setup.zsh'

alias mnt_win='sudo mount /dev/sda3 /mnt/windows'

rosenv () {
    if [ $1 = "noetic" ]; then
        echo "source /opt/ros/noetic/setup.zsh" > $HOME/.zshrc_modules/ros.sh
    elif [ $1 = "foxy" ]; then
        echo "source $HOME/tools/ros2_foxy/ros2-linux/setup.zsh" > $HOME/.zshrc_modules/ros.sh
    else
        echo "Usage: rosenv [noetic | foxy]"
    fi
}
