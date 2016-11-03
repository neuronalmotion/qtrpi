#!/bin/bash

source ${0%/*}/common.sh
cd_root

cd modules/qtbase/examples/opengl/qopenglwidget

$ROOT/bin/qmake-qtrpi

make -j 10
make install
