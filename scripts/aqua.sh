#!/bin/bash -eu
pushd $(dirname ${BASH_SOURCE:-$0})

. ./env.sh

# requirements: curl

curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v1.0.0/aqua-installer | bash

aqua i -a

popd
