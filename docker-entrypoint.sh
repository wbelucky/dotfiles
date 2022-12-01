#!/bin/bash

# ref: https://qiita.com/yohm/items/047b2e68d008ebb0f001
USER=${USERNAME:-user}
USER_ID=${LOCAL_UID:-1000}
GROUP_ID=${LOCAL_GID:-1000}
echo $USERNAME
echo $USER

usermod -u $USER_ID -o $USER
groupmod -g $GROUP_ID $USER

exec /usr/sbin/gosu $USER "$@"
