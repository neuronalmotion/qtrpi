#!/bin/bash

source ${0%/*}/common.sh
cd_root

OUTPUT_DIR=$ROOT/raspi/qt5pi

function build_module() {
	$ROOT/raspi/qt5/bin/qmake -r

	make -j 10
	make install
}

function build_qtbase() {
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

    ./configure -release -opengl es2 -device linux-rasp-pi2-g++ \
        -device-option CROSS_COMPILE=$CROSS_COMPILE \
        -sysroot $SYSROOT \
        -opensource -confirm-license -make libs \
        -prefix /usr/local/qt5pi \
        -extprefix $OUTPUT_DIR \
        -hostprefix $ROOT/raspi/qt5

    make -j 10
    make install
}

message 'Building qtbase...'
pushd $ROOT/modules/qtbase
build_qtbase
popd

for MODULE in qtdeclarative qt3d qtquickcontrols qtquickcontrols2; do
    message "Building $MODULE..."
    pushd $ROOT/modules/$MODULE
    build_module
    popd
done

