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
ln -snfv ${DOTFILES}/.config/nvim ${HOME}/.config/nvim
ln -snfv ${DOTFILES}/.tmux.conf ${HOME}/.tmux.conf
ln -snfv ${DOTFILES}/.gitconfig ${HOME}/.gitconfig
ln -snfv ${DOTFILES}/.myconf.bashrc ${HOME}/.myconf.bashrc

# bashrcにmyconfをロードするスクリプトが読み込まれていなければ追加.

WBCONFIG="$HOME/.wbconfig"
touch "$WBCONFIG"
yq -i ".environment.DOTFILES=\"$DOTFILES\"" "$WBCONFIG"

if [[ ! -v "WB_MYCONF_LOADED" ]]; then
  echo "fix ~/.bashrc to load ~/.myconf.bashrc"
  cat << HERE >> ~/.bashrc
. "\$HOME/.myconf.bashrc"
HERE

fi

popd
