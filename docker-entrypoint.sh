#!/bin/bash

USER=${USERNAME:-user}
USER_ID=${LOCAL_UID:-9001}
GROUP_ID=${LOCAL_GID:-9001}

usermod -u $USER_ID -o $USER
groupmod -g $GROUP_ID user

exec /usr/sbin/gosu $USER "$@"
