#!/bin/bash

source ${0%/*}/common.sh
cd_root ; cd raspbian

sudo apt-get install qemu-user-static
sudo cp /usr/bin/qemu-arm-static sysroot/usr/bin/

# Mount sysroot part
sudo mount -o bind /proc sysroot/proc
sudo mount -o bind /dev sysroot/dev
sudo mount -o bind /sys sysroot/sys

# comment preload conf to avoid the following error during apt-get build-dep command
# qemu: uncaught target signal 4 (Illegal instruction) - core dumped
# Illegal instruction
sudo sed -i '/./s/^/#/g' sysroot/etc/ld.so.preload

# Uncomment deb-src to have access to dev packages
sudo sed -i '/deb-src/s/^#//g' sysroot/etc/apt/sources.list

# Install Qt dependencies
sudo chroot sysroot /bin/bash -c 'apt-get update'
sudo chroot sysroot /bin/bash -c 'apt-get install -y apt-transport-https'
sudo chroot sysroot /bin/bash -c 'apt-get build-dep -y qt4-x11 qtbase-opensource-src'
sudo chroot sysroot /bin/bash -c 'apt-get install -y libudev-dev libinput-dev libts-dev libxcb-xinerama0-dev libxcb-xinerama0'

sudo umount sysroot/sys
sudo umount sysroot/dev
sudo umount sysroot/proc

sudo chown -R $USER:$USER sysroot

$UTILS_DIR/sysroot-relativelinks.py sysroot

