#! /bin/bash

# Assign the directory of this script to SCRIPT_DIR
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# Assign the directory of the parent of this script to DIR
DIR="$(dirname "$SCRIPT_DIR")"

cd "$DIR"

# If the build directory doesn't exist, create it
if [ ! -d "$DIR/build" ]; then
  mkdir "$DIR/build"
fi
# If the nvim directory doesn't exist, create it
if [ ! -d "$DIR/build/nvim" ]; then
  mkdir "$DIR/build/nvim"
fi

cd into neovim
git clone https://github.com/neovim/neovim.git && \
cd neovim && \
git checkout stable && \
rm -r build/ ;
make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$DIR/build/nvim/" && \
make install && \
cd .. && \
rm -rf neovim

# cd into kitty
curl -L https://sw.kovidgoyal.net/kitty/installer.sh \
  | sh /dev/stdin \
    launch=n \
    dest=$DIR/build/ && \
  cd ..

# OS Integration
cd "$SCRIPT_DIR"
cp ./resources/ZetoVim.desktop $HOME/.local/share/applications/ZetoVim.desktop
cp ./logo.png $HOME/.local/share/icons/ZetoVim.png
