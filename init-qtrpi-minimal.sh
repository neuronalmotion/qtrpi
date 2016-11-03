#!/bin/bash

QTRPI_BASE_URL='http://www.qtrpi.com/downloads'

source ${0%/*}/utils/common.sh

# prepare environment
$UTILS_DIR/utils/init-common.sh
cd_root

# download and unzip sysroot
message 'Download sysroot-minimal'
SYSROOT_ZIP=sysroot-minimal-latest.zip
curl -o $SYSROOT_ZIP $QTRPI_BASE_URL/sysroot/qtrpi-sysroot-minimal-latest.zip 
unzip $SYSROOT_ZIP
$UTILS_DIR/utils/switch-sysroot.sh minimal

# download qtrpi
message 'Download qtrpi binaries'
QTRPI_ZIP="qtrpi-${DEVICE_NAME}_qt-${QT_VERSION}.zip"
curl -o $QTRPI_ZIP $QTRPI_BASE_URL/qtrpi/$DEVICE_NAME/$QTRPI_ZIP
unzip $QTRPI_ZIP

# create symlink
ln -sf $ROOT/raspi/qt5/bin/qmake $ROOT/bin/qmake-qtrpi
