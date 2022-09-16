#!/bin/bash -eu
# install prerequirements

# curl wget tmux git aqua ${HOME}/.config

apt-get update -y \
  && apt-get upgrade -y \
  && apt-get autoremove -y


command -v apt-add-repository || apt-get install -y software-properties-common

apt-get install -y curl wget tmux


DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata

command -v git || add-apt-repository -y ppa:git-core/ppa \
  && apt-get update -y \
  && apt-get install -y git


