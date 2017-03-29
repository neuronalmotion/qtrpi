#!/bin/bash

source ${0%/*}/common.sh

cd_root

mkdir -p dist
cd dist

for VERSION in '5.6.2' '5.7.0'; do
    for DEVICE in 'linux-rasp-pi-g++' 'linux-rasp-pi2-g++' 'linux-rpi3-g++'; do
        NAME=$(device_name $DEVICE)
        QTRPI_CURL_OPT="--user $CI_AUTH_USER:$CI_AUTH_PASSWORD"
        QTRPI_BASE_URL="$CI_BASE_URL/job/qtrpi/QT_VERSION=$VERSION,TARGET_DEVICE=$DEVICE/lastSuccessfulBuild/artifact/dist"
        QTRPI_ZIP="qtrpi-${NAME}_qt-${VERSION}.zip"
        QTRPI_MINIMAL_URL="$QTRPI_BASE_URL/qtrpi/$NAME/$QTRPI_ZIP"

        DIR="qtrpi/$NAME"
        mkdir -p $DIR
        pushd $DIR
        download_qtrpi_binaries false
        popd
    done
done

QTRPI_SYSROOT_URL="$QTRPI_BASE_URL/sysroot/qtrpi-sysroot-minimal-latest.zip"
DIR="sysroot"
mkdir -p $DIR
pushd $DIR
download_sysroot_minimal false
popd
