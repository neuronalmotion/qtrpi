#!/bin/bash

source ${0%/*}/common.sh
cd_root

TARGET_SYSROOT=$1

ln -sf $ROOT/raspbian/sysroot-$TARGET_SYSROOT $ROOT/raspbian/sysroot

