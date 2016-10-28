#!/bin/bash

source ${0%/*}/common.sh
OUTPUT_DIR=$ROOT/raspi/qt5pi

cd_root

# sync the host folder with the target
rsync -avz $OUTPUT_DIR $RPI_HOST:/usr/local/

ssh $RPI_HOST "sudo sh -c 'echo /usr/local/qt5pi/lib > /etc/ld.so.conf.d/qt5pi.conf'"
ssh $RPI_HOST sudo ldconfig
