#!/bin/bash
docker run -it \
  --rm \
  -v `pwd`/$1:/workspace \
  -v $(cd $(dirname $0); pwd):/home/user/dotfiles \
  ghcr.io/wbelucky/dotfiles-with-docker
