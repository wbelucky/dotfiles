#!/bin/bash -eu
command -v fish || sudo sh -c 'apt-add-repository -y ppa:fish-shell/release-3 \
  && apt-get update -y \
  && apt-get install -y fish \
  && chsh -s fish'
