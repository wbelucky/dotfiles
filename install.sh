#!/bin/bash -eu

sudo ./scripts/prerequirements.sh

command -v aqua \
  || curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v1.0.0/aqua-installer | bash

source ./scripts/link.sh
sudo ./scripts/fish.sh
aqua i
source ./scripts/vim-plug.sh
