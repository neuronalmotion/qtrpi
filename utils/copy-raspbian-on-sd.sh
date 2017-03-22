#!/bin/bash

source ${0%/*}/common.sh
cd_root

IMG="raspbian/${RASPBIAN_BASENAME}.img"
TARGET=$1

echo "Copying $IMG to $TARGET..."

# Copy raspbian on the target
sudo dd bs=4M if=$IMG of=$TARGET status=progress

# Ensure the cache is flushed
sudo sync

echo "Done! You can eject the SD card."
