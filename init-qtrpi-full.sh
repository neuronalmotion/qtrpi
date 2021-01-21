#!/bin/bash

source ${0%/*}/utils/common.sh

function usage() {
    cat <<EOF
Usage: $0 [options]

-h| --help                      Display help text.
-n| --no-questions              No interactive mode (default behavior by default: raspbian image cache is not re-downloaded).
EOF
}

while [[ $# -gt 0 ]]; do
    KEY="$1"
    case $KEY in
        -h|--help)
            DISPLAY_HELP=true
        ;;
        -n|--no-questions)
            NO_QUESTIONS=true
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

RASPBIAN_ARG=''
if [[ $NO_QUESTIONS ]]; then
    RASPBIAN_ARG='--no-download'
fi

check_env_vars

cd utils
./init-common.sh
./synchronize-toolchain.sh
# ./download-raspbian.sh $RASPBIAN_ARG
# ./prepare-sysroot-full.sh
# ./prepare-sysroot-minimal.sh
./switch-sysroot.sh full
./synchronize-qt-modules.sh
./compile-qt-modules.sh --clean-output --clean-modules-repo

