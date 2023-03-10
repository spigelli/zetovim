#! /bin/bash

# Neovim build dependencies
apt install \
  cmake \
  ninja-build \
  gettext \
  libtool-bin \
  cmake \
  g++ \
  pkg-config \
  unzip \
  curl \
  libluajit-5.1-dev
  
# Kitt runtime dependencies
apt install \
  harfbuzz \
  zlib \
  libpng \
  liblcms2 \
  librsync \
  openssl \
  freetype \
  fontconfig \
  libcanberra

# Kitty build dependencies
apt install 
  golang-go \
  pkg-config \
  gcc \
  libdbus-1-dev \
  libxcursor-dev \
  libxrandr-dev \
  libxi-dev \
  libxinerama-dev \
  libgl1-mesa-dev \
  libxkbcommon-x11-dev \
  libfontconfig-dev \
  libx11-xcb-dev \
  liblcms2-dev \
  libpython3-dev \
  librsync-dev

# Install Nerd font
git clone https://github.com/epk/SF-Mono-Nerd-Font $HOME/.local/share/fonts/SF-Mono-Nerd-Font
cp $HOME/.local/share/fonts/SF-Mono-Nerd-Font/*.otf $HOME/.local/share/fonts/
rm -rf $HOME/.local/share/fonts/SF-Mono-Nerd-Font
fc-cache -f -v

# Install ripgrep
apt install ripgrep

# Install lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
install lazygit /usr/local/bin

# Install fd
apt install fd-find
