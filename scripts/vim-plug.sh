#!/bin/bash -eu
pushd $(dirname ${BASH_SOURCE:-$0})

. ./env.sh

# requirements: pip3

# # installs vim-plug
# sh -c 'curl -fLo "${XDG_DATA_HOME:-${HOME}/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
#   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' \
#   && nvim --headless -S ${DOTFILES}/.config/nvim/plug.vim +'PlugInstall --sync' +qall ;
# 
# # install python driver for neovim and install plugins
# pip3 install neovim \
#   && nvim --headless -S ${DOTFILES}/.config/nvim/plug.vim +UpdateRemotePlugins +qall
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim
XDG_CONFIG_HOME=${DOTFILES}/.config nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

popd
