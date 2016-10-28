#!/bin/bash

ROOT=${QTRPI_COMPILE_ROOT:-$(pwd)/cross-compile}
OUTPUT_DIR=$ROOT/raspi/qt5pi

function message() {
    echo
    echo '--------------------------------------------------------------------'
    echo $1
    echo '--------------------------------------------------------------------'
}

function build_module() {
	$ROOT/raspi/qt5/bin/qmake -r

	# Build the host tools
	make -j 10

	# Install the build files in the target folder
	make install
}

cd $ROOT

message 'Building qtdeclarative...'
pushd $ROOT/modules/qtdeclarative
build_module
popd

message 'Building qt3d...'
pushd $ROOT/modules/qt3d
build_module
popd

message 'Building qtquickcontrols...'
pushd $ROOT/modules/qtquickcontrols
build_module
popd

message 'Building qtquickcontrols2...'
pushd $ROOT/modules/qtquickcontrols2
build_module
popd