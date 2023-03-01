#!/bin/bash -eu

apt-get update -y \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    curl wget tmux software-properties-common python3-pip tzdata build-essential \
  && add-apt-repository -y ppa:git-core/ppa \
  && add-apt-repository -y ppa:fish-shell/release-3 \
  && apt-get update -y \
  && apt-get install -y --no-install-recommends fish git
  # && chsh -s fish

