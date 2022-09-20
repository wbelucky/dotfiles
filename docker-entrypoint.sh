#!/bin/bash

USER=${USERNAME:-user}
USER_ID=${LOCAL_UID:-1000}
GROUP_ID=${LOCAL_GID:-1000}

usermod -u $USER_ID -o $USER
groupmod -g $GROUP_ID $USER

exec /usr/sbin/gosu $USER "$@"
