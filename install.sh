#!/bin/bash -eu

. ./scripts/prerequirements.sh

command -v aqua \
  || curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v1.0.0/aqua-installer | bash

. ./scripts/fish.sh
aqua i
. ./scripts/vim-plug.sh
. ./scripts/link.sh
