#!/bin/bash
source ${0%/*}/common.sh

function usage() {
    cat <<EOF
Usage: $0 [options]

-h| --help                      Display help text.
-n| --no-download               If the toolchain file is present, do not download it again.
-d| --directory                 Destination directory where the toolchain is downloaded.
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
    mkdir -p $BASE_DIRECTORY/raspi
    cd $BASE_DIRECTORY
fi

cd raspi

export LINARO_RELEASE="gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf"

message 'Downloading Raspberry Pi toolchain'

function download_toolchain() {
    # Download and unzip the latest raspbian image (~1.4Go zipped)
    message "Downloading linaro ${LINARO_RELEASE}"
    wget --output-document=${LINARO_BASENAME}.tar.xz \
        --content-disposition \
        https://releases.linaro.org/components/toolchain/binaries/latest-7/arm-linux-gnueabihf/${LINARO_RELEASE}.tar.xz
    mkdir ${LINARO_BASENAME} && tar xfv ${LINARO_BASENAME}.tar.xz -C ${LINARO_BASENAME} --strip-components 1
}

if [[ -d "./${LINARO_BASENAME}" ]]; then
    if [[ ! $NO_DOWNLOAD ]]; then
        while  true; do
            read -p "You already have the current toolchain, do you want to download the lastest version [y/n]? " yn
            case $yn in
                [Yy]* ) download_toolchain; break;;
                [Nn]* ) break;;
            esac
        done
    else
        echo "Using existing toolchain"
    fi
else
    download_toolchain;
fi

