#!/bin/bash

source ${0%/*}/utils/common.sh
OUTPUT_DIR=$ROOT/raspi/qt5pi

cd_root

ssh $TARGET_HOST 'sudo mkdir /usr/local/qt5pi ; sudo chown -R pi:pi /usr/local/qt5pi'
ssh $TARGET_HOST 'sudo apt-get install -y libts-0.0-0 libinput5'
ssh $TARGET_HOST "sudo sh -c 'echo /usr/local/qt5pi/lib > /etc/ld.so.conf.d/qt5pi.conf'"

rsync -avz $OUTPUT_DIR $TARGET_HOST:/usr/local/

ssh $TARGET_HOST 'sudo ldconfig'
