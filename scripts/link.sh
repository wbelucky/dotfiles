#!/bin/bash -eu
. ./env.sh

mkdir -p ${HOME}/.config
ln -snfv ${DOTFILES}/.config/fish ${HOME}/.config/fish
ln -snfv ${DOTFILES}/.config/nvim ${HOME}/.config/nvim
ln -snfv ${DOTFILES}/.tmux.conf ${HOME}/.tmux.conf
ln -snfv ${DOTFILES}/.gitconfig ${HOME}/.gitconfig
ln -snfv ${DOTFILES}/.myconf.bashrc ${HOME}/.myconf.bashrc

# bashrcにmyconfをロードするスクリプトが読み込まれていなければ追加.

if [[ ! -v "WB_MYCONF_LOADED" ]]; then

  echo "fix ~/.bashrc to load ~/.myconf.bashrc"
  cat << HERE >> ~/.bashrc
export DOTFILES="$DOTFILES"
. "\$HOME/.myconf.bashrc"
HERE

fi

