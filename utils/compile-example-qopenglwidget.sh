#!/bin/bash

source ${0%/*}/common.sh
cd_root

# Crosscompile qtbase
CURRENT_DIR=$(pwd)
export CROSS_COMPILE=$ROOT/raspi/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin/arm-linux-gnueabihf-
export SYSROOT=$ROOT/raspbian/sysroot

cd modules/qtbase/examples/opengl/qopenglwidget

# Generate the Makefile with qmake (from the host)
$ROOT/bin/qmake-qtrpi

# Build the host tools
make -j 10

# Install the build files in the target folder
make install
