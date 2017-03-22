#!/bin/bash

source ${0%/*}/common.sh

cd_root

BASE_DIR=dist/sysroot
mkdir -p $BASE_DIR

message 'Compressing sysroot-minimal'
zip --symlinks -r -q $ROOT/$BASE_DIR/qtrpi-sysroot-minimal-$RASPBIAN_BASENAME.zip raspbian/sysroot-minimal
