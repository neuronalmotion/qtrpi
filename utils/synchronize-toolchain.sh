#!/bin/bash
source ${0%/*}/common.sh

function usage() {
    cat <<EOF
Usage: $0 [options]

-h| --help                      Display help text.
-d| --directory                 Destination directory where the toolchain is downloaded.
EOF
}

while [[ $# -gt 0 ]]; do
    KEY="$1"
    case $KEY in
        -h|--help)
            DISPLAY_HELP=true
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

message 'Downloading Raspberry Pi toolchain'

if [[ ! $DOCKER_BUILD ]]; then
    if [[ ! -d 'tools' ]]; then
        git clone https://github.com/raspberrypi/tools
    fi

    pushd tools
    git pull origin master
    popd
else
    # create shallow copy, which is a lot faster
    git clone --depth=1 -b master https://github.com/raspberrypi/tools
fi
