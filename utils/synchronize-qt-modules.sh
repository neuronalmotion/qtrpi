#!/bin/bash

source ${0%/*}/common.sh

MODULES_DIR='modules'
TAG_NAME=$QT_VERSION

function usage() {
    cat <<EOF
Usage: $0 [options]

-h| --help                      Display help text.
-c| --clean-all                 Delete all repositories and output data.
-d| --directory                 Destination directory where Qt modules are cloned.
EOF
}


while [[ $# -gt 0 ]]; do
    KEY="$1"
    case $KEY in
        -h|--help)
            DISPLAY_HELP=true
        ;;
        -c|--clean-all)
            CLEAN_ALL=true
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
    MODULES_DIR=$DIRECTORY_ARG
fi

if [[ $CLEAN_ALL ]]; then
    message 'Clean all repositories and output...'
    rm -rf $MODULES_DIR
    rm -rf raspi/qt5 raspi/qt5pi
fi


if [ ! -d $MODULES_DIR ] ; then
    message "Create $MODULES_DIR directory..."
    mkdir $MODULES_DIR
fi

cd $MODULES_DIR
message 'Synchronize all modules...'
for MODULE in "${QT_MODULES[@]}" ; do
    if [[ $MODULE == \#* ]]; then
        continue
    fi

    if [[ ! -d $MODULE ]]; then
        git clone git://code.qt.io/qt/$MODULE.git
    fi
    pushd $MODULE
    git fetch origin
    git checkout tags/v$TAG_NAME
    popd
done

