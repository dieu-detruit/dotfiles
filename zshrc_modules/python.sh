# pyenv settings
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"

export PYTHON_COMMAND="$PYENV_ROOT/shims/python"
