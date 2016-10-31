#!/bin/bash

source ${0%/*}/common.sh

sudo mkdir -p $ROOT
sudo chown -R $USER:$USER $ROOT
cd_root

mkdir raspi raspbian bin

# Get the toolchain (~600Mo)
message 'Downloading Raspberry Pi toolchain'
pushd raspi
git clone https://github.com/raspberrypi/tools
popd

