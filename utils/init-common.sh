#!/bin/bash

source ${0%/*}/common.sh

message 'Creating qtrpi directory structure'

if [[ ! $DOCKER_BUILD ]]; then
    # sanity check for mounted image
    sudo umount /mnt/raspbian
    sudo umount $ROOT/raspbian/sysroot-full/sys
    sudo umount $ROOT/raspbian/sysroot-full/dev
    sudo umount $ROOT/raspbian/sysroot-full/proc
    
    sudo mkdir -p $ROOT
    sudo chown -R $USER:$USER $ROOT
else
    # === Docker-Mode ===
    # umount is not allowed in a docker image, besides we use a fresh linux image => skipping sanity checks
    # sudo is also not needed/installed by default => creating directory structure without use of sudo
    mkdir -p $ROOT
    chown -R $USER:$USER $ROOT
fi

cd_root

mkdir raspi raspbian bin logs
