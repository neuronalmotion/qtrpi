#!/bin/bash

# Get the toolchain (~600Mo)
mkdir raspi
pushd raspi
git clone https://github.com/raspberrypi/tools
popd

# Download and unzip the latest wheezy image (~1.4Go zipped)
mkdir raspbian
pushd raspbian 
wget --content-disposition https://downloads.raspberrypi.org/raspbian_latest
unzip *raspbian*.zip

# Mount and extract the raspbian sysroot 
sudo losetup -P /dev/loop0 *raspbian*.img
sudo mount /dev/loop0p2 /mnt
mkdir sysroot

# We do not really need all this stuff
# FIXME: root permission problem
# sudo rsync -a /mnt/ sysroot/

# Cherry-pick copy
mkdir -p sysroot/lib sysroot/opt sysroot/usr/include sysroot/usr/lib
cp -r /mnt/lib/ sysroot/
cp -r /mnt/usr/include sysroot/usr/
cp -r /mnt/usr/lib sysroot/usr/
cp -r /mnt/opt/vc sysroot/opt/

sudo umount /mnt
sudo losetup -d /dev/loop0
popd

# Turn all the abolute symlinks and turn them into relative ones 
./sysroot-relativelinks.py raspbian/sysroot

# Retrieve qtbase source code (~440 Mo)
mkdir modules
pushd modules
git clone git://code.qt.io/qt/qtbase.git -b 5.7
popd