#!/bin/bash -eu
# install prerequirements

# curl wget tmux git aqua ${HOME}/.config

sudo sh -c 'apt-get update -y \
  && apt-get upgrade -y \
  && apt-get autoremove -y'


command -v apt-add-repository || sudo apt-get install -y software-properties-common

sudo apt-get install -y curl wget tmux


sudo DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata

command -v git || sudo sh -c 'add-apt-repository -y ppa:git-core/ppa \
  && apt-get update -y \
  && apt-get install -y git'


