#!/bin/bash -eu

pushd $(dirname ${BASH_SOURCE:-$0})/..

DOTFILES=$(pwd)
PATH="$HOME/.local/share/aquaproj-aqua/bin:$PATH"

popd
