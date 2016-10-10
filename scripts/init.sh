#!/bin/bash

# Get the toolchain (~600Mo)
mkdir raspi
pushd raspi
git clone https://github.com/raspberrypi/tools
popd

# Download and unzip the latest wheezy image
mkdir raspbian
pushd raspbian 
wget --content-disposition https://downloads.raspberrypi.org/raspbian_latest
unzip *raspbian*.zip

# Mount and extract sysroot 
sudo losetup -P /dev/loop0 *raspbian*.img
sudo mount /dev/loop0p2 /mnt
mkdir sysroot
sudo rsync -a /mnt/ sysroot/
sudo umount /mnt
sudo losetup -d /dev/loop0
popd

# Retrieve qtbase source code
mkdir modules
pushd modules
git clone git://code.qt.io/qt/qtbase.git -b 5.7
popd