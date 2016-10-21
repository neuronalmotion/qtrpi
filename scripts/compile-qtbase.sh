#!/bin/bash

# TODO: Edit qmake.conf with INCLUDEPATH... or qmake compilation will fail

ROOT=${QTRPI_COMPILE_ROOT:-$(pwd)/cross-compile}

# Crosscompile qtbase
export CROSS_COMPILE=$ROOT/raspi/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin/arm-linux-gnueabihf-
export DIRROOT=$ROOT
export SYSROOT=$ROOT/raspbian/sysroot

cd $ROOT/modules/qtbase

./configure -release -opengl es2 -device linux-rasp-pi2-g++ \
    -device-option CROSS_COMPILE=$CROSS_COMPILE \
    -sysroot $SYSROOT \
    -opensource -confirm-license -make libs \
    -prefix /usr/local/qt5pi \
    -extprefix $DIRROOT/raspi/qt5pi \
    -hostprefix $DIRROOT/raspi/qt5 \
    -v

# Build the host tools
make -j 10

# Install the build files in the target folder
make install
