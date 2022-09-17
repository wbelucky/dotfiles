#!/bin/bash -eu

# requirements: curl
command -v aqua \
  || curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v1.0.0/aqua-installer | bash
aqua i
