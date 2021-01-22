#!/bin/bash

source ${0%/*}/common.sh

function usage() {
    cat <<EOF
Usage: $0 [options]

-h| --help                      Display help text.
-n| --no-download               If the Raspbian image is present, do not download it again.
-d| --directory                 Destination directory where Raspbian image is downloaded.
EOF
}

while [[ $# -gt 0 ]]; do
    KEY="$1"
    case $KEY in
        -h|--help)
            DISPLAY_HELP=true
        ;;
        -n|--no-download)
            NO_DOWNLOAD=true
        ;;
        -d|--directory)
            DIRECTORY_ARG="$2"
        ;;

        *)
        ;;
    esac
    shift
done

if [[ $DISPLAY_HELP ]]; then
    usage
    exit 0
fi

if [[ -z $DIRECTORY_ARG ]]; then
    cd_root
else
    BASE_DIRECTORY=$DIRECTORY_ARG
    mkdir -p $BASE_DIRECTORY/raspbian
    cd $BASE_DIRECTORY
fi

cd raspbian

message 'Download Raspbian image'

function download_raspbian() {
    # Download and unzip the latest raspbian image (~1.4Go zipped)
    message 'Downloading Raspbian latest image'
    wget --output-document=${RASPBIAN_BASENAME}.zip \
        --content-disposition \
        https://downloads.raspberrypi.org/raspios_full_armhf/images/raspios_full_armhf-2021-01-12/2021-01-11-raspios-buster-armhf-full.zip

#        https://downloads.raspberrypi.org/raspbian/images/raspbian-2017-03-03/2017-03-02-raspbian-jessie.zip


    unzip -p ${RASPBIAN_BASENAME}.zip > ${RASPBIAN_BASENAME}.img
}

if [[ -f ${RASPBIAN_BASENAME}.img ]]; then
    if [[ ! $NO_DOWNLOAD ]]; then
        while  true; do
            read -p "You already have a raspbian image, do you want to download the lastest version [y/n]? " yn
            case $yn in
                [Yy]* ) download_raspbian; break;;
                [Nn]* ) break;;
            esac
        done
    else
        echo "Using cached raspbian image"
    fi
else
    download_raspbian;
fi

