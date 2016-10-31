#!/bin/bash

source ${0%/*}/common.sh
cd_root

MODULES_DIR='modules'
TAG_NAME=$QT_VERSION

if [ ! -d $MODULES_DIR ] ; then
    message "Create $MODULES_DIR directory..."
    mkdir $MODULES_DIR
fi

cd $MODULES_DIR
message 'Synchronize all modules...'
for MODULE in qtbase qtdeclarative qt3d qtquickcontrols qtquickcontrols2; do
    if [[ ! -d $MODULE ]]; then
        git clone git://code.qt.io/qt/$MODULE.git
    fi
    pushd $MODULE
    git_reset_repo_hard
    git checkout tags/v$TAG_NAME
    popd
done

