#!/bin/bash

source ${0%/*}/common.sh
cd_root

mkdir -p raspbian/sysroot-minimal
SYSROOT_FULL_DIR=$ROOT/raspbian/sysroot-full
SYSROOT_MINIMAL_DIR=$ROOT/raspbian/sysroot-minimal

for DIR in 'lib' 'usr/include' 'usr/lib' 'opt/vc'; do
    mkdir -p $SYSROOT_MINIMAL_DIR/$DIR
    rsync -av $SYSROOT_FULL_DIR/$DIR/ $SYSROOT_MINIMAL_DIR/$DIR
done

