export PATH="/usr/local/opt/llvm/bin:$PATH"
export PATH="$HOME/.local/bin/:$PATH"
export PATH="/usr/local/cuda/bin:$PATH"
export PATH="$HOME/tools/bin:$PATH"
export PATH="$HOME/tools/android-studio/bin:$PATH"
export PATH="/usr/local/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin:$PATH"
export PATH="$HOME/tools/flutter/bin:$PATH"

export DYLD_LIBRARY_PATH="/usr/local/cuda/lib64:$DYLD_LIBRARY_PATH"
export LD_LIBRARY_PATH="/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH"

#export ROS_MASTER_URI=http://192.168.1.10:11311
#export ROS_HOSTNAME=192.168.1.10
export ROS_MASTER_URI=http://localhost:11311
export ROS_HOSTNAME=localhost

export TVM_HOME=$HOME/tools/tvm
export PYTHONPATH=$TVM_HOME/python:${PYTHONPATH}
