# override command with option
alias ls='ls --color=auto'
alias la='ls -a --color=auto'
alias ll='ls -a --color=auto'

alias vi='nvim -O'
alias vim='nvim -O'
alias v='nvim -O'
alias vimm='nvim -O'

alias clang++='clang++-10'

# directory shortcut
alias lab='cd ~/inamilab'

# useful alias
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"

alias json_pretty="python -c 'import sys,json;print(json.dumps(json.loads(sys.stdin.read()),indent=4,ensure_ascii=False))'"

alias jpt=jupyter-lab --notebook-dir=$(pwd)

alias :q='exit'

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

alias mnt_win='sudo mount /dev/sda3 /mnt/windows'
