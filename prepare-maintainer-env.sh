#!/bin/bash

cd utils
./init.sh
./prepare-sysroot-full.sh
./prepare-sysroot-minimal.sh
./switch-sysroot.sh full
./clone-qt-modules.sh
./compile-qt-modules.sh

