#!/bin/bash

function message() {
    echo
    echo '--------------------------------------------------------------------'
    echo $1
    echo '--------------------------------------------------------------------'
}

# Get absolute path of script dir for later execution
# /!\ has to be executed *before* any "cd" command
SCRIPT=$( readlink -m $( type -p $0 ))
SCRIPT_DIR=`dirname ${SCRIPT}`

ROOT=${QTRPI_COMPILE_ROOT:-$(pwd)/cross-compile}
mkdir -p $ROOT ; cd $ROOT

# Get the toolchain (~600Mo)
message 'Downloading Raspberry Pi toolchain'
mkdir raspi
pushd raspi
git clone https://github.com/raspberrypi/tools
popd

# Download and unzip the latest wheezy image (~1.4Go zipped)
message 'Downloading Raspbian latest image'
mkdir raspbian
pushd raspbian
wget --content-disposition https://downloads.raspberrypi.org/raspbian_latest
unzip *raspbian*.zip

# Mount and extract the raspbian sysroot
message 'Creating sysroot'
sudo losetup -P /dev/loop0 *raspbian*.img
sudo mkdir /mnt/raspbian
sudo mount /dev/loop0p2 /mnt/raspbian
mkdir sysroot

# Copy all sysroot from .img
sudo rsync -a /mnt/raspbian/ sysroot/

# Cherry-pick copy
# mkdir -p sysroot/lib sysroot/opt sysroot/usr/include sysroot/usr/lib
# cp -r /mnt/raspbian/lib/ sysroot/
# cp -r /mnt/raspbian/usr/include sysroot/usr/
# cp -r /mnt/raspbian/usr/lib sysroot/usr/
# cp -r /mnt/raspbian/opt/vc sysroot/opt/

sudo umount /mnt/raspbian
sudo losetup -d /dev/loop0
popd

# Turn all the abolute symlinks and turn them into relative ones
message 'Updating symlinks to be relative'
$SCRIPT_DIR/sysroot-relativelinks.py raspbian/sysroot

# Retrieve qtbase source code (~440 Mo)
message 'Retrieving Qt source code'
mkdir modules
pushd modules
git clone git://code.qt.io/qt/qtbase.git -b 5.7
popd
