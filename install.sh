#!/bin/bash -eu

# . ./scripts/prerequirements.sh

DOTFILES=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
PATH="$HOME/.local/share/aquaproj-aqua/bin:$PATH"
. ./scripts/aqua.sh
. ./scripts/vim-plug.sh
. ./scripts/link.sh

