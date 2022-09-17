#!/bin/bash -eu
# install prerequirements

# curl wget tmux git pip3 fish

sudo sh -c 'apt-get update -y \
  && apt-get upgrade -y \
  && apt-get autoremove -y'


command -v apt-add-repository || sudo apt-get install -y software-properties-common

sudo apt-get install -y curl wget tmux

# install git
command -v git || sudo sh -c 'DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata \
  && add-apt-repository -y ppa:git-core/ppa \
  && apt-get update -y \
  && apt-get install -y git'


# install pip
command -v pip3 || sudo apt-get install -y python3-pip

# install fish
command -v fish || sudo sh -c 'apt-add-repository -y ppa:fish-shell/release-3 \
  && apt-get update -y \
  && apt-get install -y fish \
  && chsh -s fish'
