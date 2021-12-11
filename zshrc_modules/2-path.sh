# pyenv settings
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

export PYTHON_COMMAND="$PYENV_ROOT/shims/python"

export PATH="/usr/local/opt/llvm/bin:$PATH"
export PATH="$HOME/.local/bin/:$PATH"
export PATH="/usr/local/cuda/bin:$PATH"
export PATH="$HOME/tools/bin:$PATH"

export DYLD_LIBRARY_PATH="/usr/local/cuda/lib64:$DYLD_LIBRARY_PATH"
export LD_LIBRARY_PATH="/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH"

export PATH="$HOME/.poetry/bin:$PATH"
