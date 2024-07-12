#!/bin/bash -eu

pushd $(dirname ${BASH_SOURCE:-$0})/..

DOTFILES=$(pwd)
PATH="$HOME/.cargo/bin:$PATH"
PATH="$HOME/.local/share/aquaproj-aqua/bin:$PATH"
export AQUA_GLOBAL_CONFIG="$DOTFILES/.config/aquaproj-aqua/aqua.yaml"

if [[ ! $(uname -m | grep -q aarch) ]]; then
	export AQUA_GLOBAL_CONFIG="$DOTFILES/.config/aquaproj-aqua/amd64.yaml:$AQUA_GLOBAL_CONFIG"
fi
export AQUA_POLICY_CONFIG="$DOTFILES/.config/aquaproj-aqua/aqua-policy.yaml"

export GHQ_ROOT="$HOME/ghq"

popd
