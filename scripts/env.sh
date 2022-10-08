#!/bin/bash -eu

DOTFILES=$(cd $(dirname ${BASH_SOURCE:-$0})/..; pwd)
PATH="$HOME/.local/share/aquaproj-aqua/bin:$PATH"
