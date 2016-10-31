#!/bin/bash

source ${0%/*}/common.sh
cd_root

# Download and unzip the latest wheezy image (~1.4Go zipped)
message 'Downloading Raspbian latest image'
cd raspbian
wget --content-disposition https://downloads.raspberrypi.org/raspbian_latest
unzip *raspbian*.zip

# Mount and extract the raspbian sysroot
message 'Creating sysroot'
sudo losetup -P /dev/loop0 *raspbian*.img
sudo mkdir /mnt/raspbian
sudo mount /dev/loop0p2 /mnt/raspbian

# Copy all sysroot from .img
mkdir sysroot-full sysroot-minimal
sudo rsync -a /mnt/raspbian/ sysroot-full/

# Cherry-pick copy
# mkdir -p sysroot/lib sysroot/opt sysroot/usr/include sysroot/usr/lib
# cp -r /mnt/raspbian/lib/ sysroot/
# cp -r /mnt/raspbian/usr/include sysroot/usr/
# cp -r /mnt/raspbian/usr/lib sysroot/usr/
# cp -r /mnt/raspbian/opt/vc sysroot/opt/

sudo umount /mnt/raspbian
sudo losetup -d /dev/loop0

