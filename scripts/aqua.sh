#!/bin/bash -eu
. ./env.sh

# requirements: curl
command -v aqua \
  || curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v1.0.0/aqua-installer | bash

AQUA_GLOBAL_CONFIG=$DOTFILES/aqua.yaml
aqua i

