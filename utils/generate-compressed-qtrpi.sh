#!/bin/bash

source ${0%/*}/common.sh

cd_root

mkdir dist

message 'Compressing qtrpi...'
zip -r -q $ROOT/dist/qtrpi-$TARGET_DEVICE-qt-$QT_VERSION.zip raspi/qt5 raspi/qt5pi