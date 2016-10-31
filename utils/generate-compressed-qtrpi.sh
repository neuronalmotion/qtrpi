#!/bin/bash

source ${0%/*}/common.sh

cd_root

mkdir dist
DATE=$(date +%Y%m%d)

message 'Compressing qtrpi...'
zip -r -q $ROOT/dist/qtrpi-${TARGET_DEVICE}_qt-${QT_VERSION}_${DATE}.zip raspi/qt5 raspi/qt5pi
