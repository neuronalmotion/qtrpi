#!/bin/bash

source ${0%/*}/common.sh
cd_root
cd raspbian

message 'Download Raspbian image'

function download_raspbian() {
    # Download and unzip the latest raspbian image (~1.4Go zipped)
    message 'Downloading Raspbian latest image'
    wget --output-document=${RASPBIAN_BASENAME}.zip \
        --content-disposition \
        https://downloads.raspberrypi.org/raspbian_latest

    unzip -p ${RASPBIAN_BASENAME}.zip > ${RASPBIAN_BASENAME}.img
}

if [[ -f ${RASPBIAN_BASENAME}.img ]]; then
    while  true; do
        read -p "You already have a raspbian image, do you want to download the lastest version [y/n]? " yn
            case $yn in
                [Yy]* ) download_raspbian; break;;
                [Nn]* ) break;;
            esac
    done
else
    download_raspbian;
fi

