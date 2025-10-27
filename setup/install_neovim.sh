#!/bin/bash

mkdir -p $HOME/tools/sources
cd $HOME/tools/sources

git clone https://github.com/neovim/neovim.git
cd neovim

INSTALL_PREFIX="$(realpath $HOME/tools)"

make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=${INSTALL_PREFIX}
make install
