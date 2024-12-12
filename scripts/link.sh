#!/bin/bash -eu
pushd $(dirname ${BASH_SOURCE:-$0})

. ./env.sh

mkdir -p ${HOME}/.config

fish_config_dir="${HOME}/.config/fish"
if [[ -d fish_config_dir ]]; then
	fish_default="$HOME/.config/fish_default/"
	echo "mv $fish_config_dir $fish_default"
	mv $fish_config_dir $fish_default
fi

ln -snfv ${DOTFILES}/.config/fish ${HOME}/.config/fish
ln -snfv ${DOTFILES}/.config/aquaproj-aqua ${HOME}/.config/aquaproj-aqua
ln -snfv ${DOTFILES}/kickstart-modular.nvim ${HOME}/.config/nvim
ln -snfv ${DOTFILES}/.config/lazyvim ${HOME}/.config/lazyvim
ln -snfv ${DOTFILES}/.config/pypoetry ${HOME}/.config/pypoetry
ln -snfv ${DOTFILES}/.tmux.conf ${HOME}/.tmux.conf
ln -snfv ${DOTFILES}/.myconf.bashrc ${HOME}/.myconf.bashrc
ln -snfv ${DOTFILES}/.ripgreprc ${HOME}/.ripgreprc
ln -snfv ${DOTFILES}/.config/alacritty ${HOME}/.config/alacritty
ln -snfv ${DOTFILES}/.git_template ${HOME}/.git_template
ln -snfv ${DOTFILES}/.config/zk ${HOME}/.config/zk

# bashrcにmyconfをロードするスクリプトが読み込まれていなければ追加.

if [[ ! -v "WB_MYCONF_LOADED" ]]; then
	echo "fix ~/.bashrc to load ~/.myconf.bashrc"
	cat <<HERE >>~/.bashrc
. "\$HOME/.myconf.bashrc"
HERE

fi

popd
