#!/bin/bash

source ${0%/*}/common.sh
cd_root

cd modules/qtbase/examples/opengl/qopenglwidget

export CROSS_COMPILE=$ROOT/raspi/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin/arm-linux-gnueabihf-
export SYSROOT=$ROOT/raspbian/sysroot

$ROOT/bin/qmake-qtrpi

make -j 10
make install
