#!/bin/bash

function message() {
    echo
    echo '--------------------------------------------------------------------'
    echo $1
    echo '--------------------------------------------------------------------'
}

message 'Create destination folders...'
ROOT=${QTRPI_COMPILE_ROOT:-$(pwd)/cross-compile}
mkdir -p $ROOT ; cd $ROOT
mkdir modules ; pushd modules

message 'Cloning qtdeclarative...'
git clone git://code.qt.io/qt/qtdeclarative.git -b 5.7

message 'Cloning qt3d...'
git clone git://code.qt.io/qt/qt3d.git -b 5.7

message 'Cloning qtquickcontrols...'
git clone git://code.qt.io/qt/qtquickcontrols.git -b 5.7

message 'Cloning qtquickcontrols2...'
git clone git://code.qt.io/qt/qtquickcontrols2.git -b 5.7
