#!/bin/bash

source ${0%/*}/common.sh

cd_root

BASE_DIR=dist/qtrpi/$DEVICE_NAME
mkdir -p $BASE_DIR

DATE=$(date +%Y%m%d)

message 'Compressing qtrpi...'
zip -r -q $ROOT/$BASE_DIR/qtrpi-${DEVICE_NAME}_qt-${QT_VERSION}_${DATE}.zip raspi/qt5 raspi/qt5pi
