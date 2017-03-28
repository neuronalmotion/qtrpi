#!/bin/bash

QTRPI_BASE_URL='http://www.qtrpi.com/downloads'

source ${0%/*}/utils/common.sh

export QTRPI_CURL_OPT="--user $CI_AUTH_USER:$CI_AUTH_PASSWORD"
export QTRPI_BASE_URL="$CI_BASE_URL/job/qtrpi/QT_VERSION=$QTRPI_QT_VERSION,TARGET_DEVICE=$QTRPI_TARGET_DEVICE/lastSuccessfulBuild/artifact/dist"

pushd $ROOT
download_qtrpi_binaries
curl $QTRPI_CURL_OPT \
    -o raspi/qt5pi/qopenglwidget \
    $QTRPI_BASE_URL/qopenglwidget 
popd

./deploy-qtrpi.sh --prepare-rpi

