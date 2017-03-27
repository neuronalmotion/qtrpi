#!/bin/bash

source ${0%/*}/common.sh

CACHE_ROOT='cache'
MODULES_DIR=$CACHE_ROOT/modules

message "Creating cache directory $CACHE_DIR"
mkdir -p $MODULES_DIR

./utils/synchronize-toolchain.sh --directory $CACHE_ROOT
./utils/download-raspbian.sh --no-download --directory $CACHE_ROOT
./utils/synchronize-qt-modules.sh --directory $MODULES_DIR

