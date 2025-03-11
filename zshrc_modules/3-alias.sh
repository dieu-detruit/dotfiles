# override command with option
alias ls='ls --color=auto'
alias la='ls -a --color=auto'
alias ll='ls -l --color=auto'
alias lla='ls -la --color=auto'

alias vi='nvim -O'
alias vim='nvim -O'
alias v='nvim -O'
alias vimm='nvim -O'

alias clang++='clang++-10'

# directory shortcut
alias lab='cd ~/inamilab'

# useful alias
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | uv run --no-project python -"

jpt () {
    uv run --no-project --with jupyterlab jupyter lab --notebook-dir=$(pwd)
}

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

alias clear_cache='sudo sysctl -w vm.drop_caches=3'

alias copy='xsel --clipboard'

alias repo='cd $(git rev-parse --show-toplevel)'

alias clipcd='cd $(xsel --clipboard --output)'

inkscape () {
    nohup /bin/env inkscape $* > /dev/null &
}

alias mnt_win='sudo mount /dev/sda3 /mnt/windows'

xmlformat () {
    for i
    do
        mv "$i" "$i.bak" || exit 1
        if xmllint --format "$i.bak" > "$i"; then
            rm "$i.bak"
        else
            mv "$i.bak" "$i"
        fi
    done
}

uuid () {
  uv run --no-project python3 -c "import uuid; print(uuid.uuid4())"
}
