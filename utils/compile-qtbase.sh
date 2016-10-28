#!/bin/bash

ROOT=${QTRPI_COMPILE_ROOT:-$(pwd)/cross-compile}
RPI_HOST=${1:-$QTRPI_HOST}
OUTPUT_DIR=$ROOT/raspi/qt5pi

# Crosscompile qtbase
export CROSS_COMPILE=$ROOT/raspi/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin/arm-linux-gnueabihf-
export SYSROOT=$ROOT/raspbian/sysroot

# Add missing INCLUDEPATH in qmake conf
QMAKE_FILE=mkspecs/devices/linux-rasp-pi2-g++/qmake.conf
grep -q 'INCLUDEPATH' $QMAKE_FILE || cat>>$QMAKE_FILE << EOL
INCLUDEPATH += \$\$[QT_SYSROOT]/opt/vc/include
INCLUDEPATH += \$\$[QT_SYSROOT]/opt/vc/include/interface/vcos
INCLUDEPATH += \$\$[QT_SYSROOT]/opt/vc/include/interface/vcos/pthreads
INCLUDEPATH += \$\$[QT_SYSROOT]/opt/vc/include/interface/vmcs_host/linux
EOL

pushd $ROOT/modules/qtbase

./configure -release -opengl es2 -device linux-rasp-pi2-g++ \
    -device-option CROSS_COMPILE=$CROSS_COMPILE \
    -sysroot $SYSROOT \
    -opensource -confirm-license -make libs \
    -prefix /usr/local/qt5pi \
    -extprefix $OUTPUT_DIR \
    -hostprefix $ROOT/raspi/qt5

# Build the host tools
make -j 10

# Install the build files in the target folder
make install
popd

# sync the host folder with the target
rsync -avz $OUTPUT_DIR $RPI_HOST:/usr/local/

ssh $RPI_HOST "sudo sh -c 'echo /usr/local/qt5pi/lib > /etc/ld.so.conf.d/qt5pi.conf'"
ssh $RPI_HOST sudo ldconfig
