#!/bin/bash

ROOT=${QTRPI_COMPILE_ROOT:-$(pwd)/cross-compile}
cd $ROOT

IMG=$(ls raspbian/*raspbian*.img)
TARGET=/dev/sdd

echo "Copying $IMG to $TARGET..."

# Copy raspbian on the target
sudo dd bs=4M if=$IMG of=$TARGET status=progress

# Ensure the cache is flushed
sudo sync

echo "Done! You can eject the SD card."
