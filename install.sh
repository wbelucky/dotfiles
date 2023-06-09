#!/bin/bash -eu


# FIXME aqua.sh is called before link.sh which needs yq

. ./scripts/cargo.sh
. ./scripts/aqua.sh

. ./scripts/link.sh

. ./scripts/deno.sh
. ./scripts/packer.sh
. ./scripts/asdf.sh
. ./scripts/fisher.sh

ln -snfv ${DOTFILES}/.gitconfig ${HOME}/.gitconfig

