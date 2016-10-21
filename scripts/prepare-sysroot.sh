#!/bin/bash


# DO NOT START IT, COPY-PASTE ONLY WITH CAREFUL !
exit


sudo apt-get install qemu-user-static
sudo cp /usr/bin/qemu-arm-static sysroot/usr/bin

# Mount sysroot part
sudo mount -o bind /proc sysroot/proc
sudo mount -o bind /dev sysroot/dev
sudo mount -o bind /sys sysroot/sys

# TODO: comment line in file sysroot/etc/ld.so.preload

# TODO: remove comment on deb-src on file /etc/apt/sources.list

# Enter the Matrix
sudo chroot sysroot

# Global update
apt-get update
apt-get dist-upgrade
# Care with changelog and chromium waiting a key pres...

# Install Qt depnedencies
apt-get install apt-transport-https
apt-get build-dep qt4-x11
apt-get build-dep qtbase-opensource-src
apt-get install libudev-dev libinput-dev libts-dev libxcb-xinerama0-dev libxcb-xinerama0

exit
sudo umount sysroot/sys
sudo umount sysroot/dev
sudo umount sysroot/proc


sudo chown -R guillaume:guillaume sysroot


# TODO on Rpi device:

# Create /usr/local/qt5pi
# sudo apt-get install libts-0.0-0
# sudo apt-get install libinput5
