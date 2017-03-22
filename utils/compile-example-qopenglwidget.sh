#!/bin/bash

source ${0%/*}/common.sh
cd_root

MODULE='qopenglwidget'

message "Building module $MODULE"

cd modules/qtbase/examples/opengl/$MODULE

qmake_cmd $MODULE

make clean
make_cmd $MODULE
make install
