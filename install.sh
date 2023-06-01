#!/bin/bash -eu


# FIXME aqua.sh is called before link.sh which needs yq

curl https://sh.rustup.rs -sSf | sh
. ./scripts/aqua.sh

. ./scripts/link.sh

. ./scripts/vim-plug.sh
. ./scripts/asdf.sh
. ./scripts/fisher.sh

ln -snfv ${DOTFILES}/.gitconfig ${HOME}/.gitconfig

