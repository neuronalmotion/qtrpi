#!/bin/bash

cd utils
./init-common.sh
./init-full.sh
./prepare-sysroot-full.sh
./prepare-sysroot-minimal.sh
./switch-sysroot.sh full
./synchronize-qt-modules.sh
./compile-qt-modules.sh --clean-output --clean-modules-repo

