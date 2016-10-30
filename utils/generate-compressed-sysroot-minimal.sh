#!/bin/bash

source ${0%/*}/common.sh

cd_root

mkdir dist

IMG=$(ls raspbian/*raspbian*.img)
FILENAME=$(basename "$IMG")
BASENAME=${FILENAME%%.*}

message 'Compressing sysroot-minimal...'
zip -r -q $ROOT/dist/qtrpi-sysroot-minimal-$BASENAME.zip raspbian/sysroot-minimal