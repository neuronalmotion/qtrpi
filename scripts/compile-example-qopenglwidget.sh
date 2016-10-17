#!/bin/bash

# Crosscompile qtbase
export CROSS_COMPILE=`pwd`/raspi/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin/arm-linux-gnueabihf-
export DIRROOT=$(pwd)
export SYSROOT=$DIRROOT/raspbian/sysroot

cd modules/qtbase/examples/opengl/qopenglwidget

# Generate the Makefile with qmake (from the host)
$DIRROOT/raspi/qt5/bin/qmake

# Build the host tools
make -j 10

# Install the build files in the target folder
make install