#!/bin/bash

source ${0%/*}/common.sh
cd_root

BRANCH='5.7'

message 'Create destination directory...'
mkdir modules ; pushd modules

message 'Clone all modules...'
for MODULE in qtbase qtdeclarative qt3d qtquickcontrols qtquickcontrols2; do
    git clone git://code.qt.io/qt/$MODULE.git -b $BRANCH
done

