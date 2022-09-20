#!/bin/bash

USER=${USERNAME:-user}
USER_ID=${LOCAL_UID:-9001}
GROUP_ID=${LOCAL_GID:-9001}

sudo usermod -u $USER_ID -o $USER
sudo groupmod -g $GROUP_ID $USER

# exec /usr/sbin/gosu $USER "$@"
