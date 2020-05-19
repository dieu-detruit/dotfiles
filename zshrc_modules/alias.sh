# override command with option
alias ls='ls -G'
alias la='ls -a -G'
alias ll='ls -a -G'

alias vi='nvim -O'
alias vim='nvim -O'

alias g++='g++ -std=c++17'

alias eagle='open -n -a EAGLE'

# directory shortcut
alias tcd='cd ~/Documents/main'
alias rcd='cd ~/RoboTech'
alias lab='cd ~/lab'

# useful alias
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"

alias jpt="jupyter notebook --notebook-dir=$(pwd)"

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

# salvation for typo
alias mak=make
alias mke=make
alias maek=make
alias mkae=make
alias makke=make
alias makek=make
alias makee=make

alias v='nvim -O'
alias vimm='nvim -O'
