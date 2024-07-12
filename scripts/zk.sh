#!/bin/bash -eu
pushd $(dirname ${BASH_SOURCE:-$0})

. ./env.sh

ghq get -b draft-tag github.com/wbelucky/zk
cd $GHQ_ROOT/github.com/wbelucky/zk
make
sudo mv zk /usr/local/bin/

popd
