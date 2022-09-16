#!/bin/bash -eu

# installs vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-${HOME}/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' \
  && nvim --headless -S ${DOTFILES}/.config/nvim/plug.vim +'PlugInstall --sync' +qall ;

# install pip
apt-get install -y python3-pip

# install python driver for neovim and install plugins
pip3 install neovim \
  && nvim --headless -S ${DOTFILES}/.config/nvim/plug.vim +UpdateRemotePlugins +qall
