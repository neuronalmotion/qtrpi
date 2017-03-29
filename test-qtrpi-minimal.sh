#!/bin/bash

source ${0%/*}/utils/common.sh

$UTILS_DIR/init-common.sh

QTRPI_CURL_OPT="--user $CI_AUTH_USER:$CI_AUTH_PASSWORD"
QTRPI_BASE_URL="$CI_BASE_URL/job/qtrpi/QT_VERSION=$QTRPI_QT_VERSION,TARGET_DEVICE=$QTRPI_TARGET_DEVICE/lastSuccessfulBuild/artifact/dist"
QTRPI_MINIMAL_URL="$QTRPI_BASE_URL/qtrpi/$DEVICE_NAME/$QTRPI_ZIP"

pushd $ROOT

rm -rf raspi/{qt5,qt5pi}
download_qtrpi_binaries

EXAMPLE_BIN='qopenglwidget'
message "Download $EXAMPLE_BIN from $QTRPI_BASE_URL/$EXAMPLE_BIN"
curl $QTRPI_CURL_OPT \
    -o raspi/qt5pi/$EXAMPLE_BIN \
    $QTRPI_BASE_URL/$EXAMPLE_BIN 

chmod +x raspi/qt5pi/$EXAMPLE_BIN
popd

./deploy-qtrpi.sh --prepare-rpi

