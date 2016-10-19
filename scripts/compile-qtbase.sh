#!/bin/bash

# Crosscompile qtbase
CURRENT_DIR=$(pwd)
export CROSS_COMPILE=$CURRENT_DIR/raspi/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin/arm-linux-gnueabihf-
export DIRROOT=$CURRENT_DIR
export SYSROOT=$DIRROOT/raspbian/sysroot

ROOT=${QTRPI_COMPILE_ROOT:-cross-compile}
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
