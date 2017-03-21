#!/bin/bash

source ${0%/*}/common.sh

message 'Creating qtrpi directory structure'

# sanity check for mounted image
sudo umount /mnt/raspbian
sudo umount $ROOT/raspbian/sysroot-full/sys
sudo umount $ROOT/raspbian/sysroot-full/dev
sudo umount $ROOT/raspbian/sysroot-full/proc

sudo mkdir -p $ROOT
sudo chown -R $USER:$USER $ROOT
cd_root

mkdir raspi raspbian bin

# Get the toolchain (~600Mo)
message 'Downloading Raspberry Pi toolchain'
pushd raspi
git clone https://github.com/raspberrypi/tools

pushd tools
git pull origin master
popd

popd

