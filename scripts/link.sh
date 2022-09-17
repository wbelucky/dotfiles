#!/bin/bash -eu

mkdir -p ${HOME}/.config
ln -snfv ${DOTFILES}/.config/fish ${HOME}/.config/fish
ln -snfv ${DOTFILES}/.config/nvim ${HOME}/.config/nvim
ln -snfv ${DOTFILES}/.tmux.conf ${HOME}/.tmux.conf
ln -snfv ${DOTFILES}/.gitconfig ${HOME}/.gitconfig
ln -snfv ${DOTFILES}/.myconf.bashrc ${HOME}/.myconf.bashrc

# TODO: bashrcにmyconfをロードするスクリプトが読み込まれていなければ追加.
# load private configs
# if [ -f "$HOME/.myconf.bashrc" ]; then
#     . "$HOME/.myconf.bashrc"
# fi
