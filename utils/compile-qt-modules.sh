#!/bin/bash

source ${0%/*}/common.sh
cd_root

OUTPUT_DIR=$ROOT/raspi/qt5pi
OUTPUT_HOST_DIR=$ROOT/raspi/qt5

function usage() {
    cat <<EOF
Usage: $0 [options]

-h| --help                      Display help text.
-c| --clean-output              Delete content of compilation output directories,
                                raspi/qt5 and raspi/qt5pi.
-m| --clean-modules-repo        Reset qt modules repository to their initial state,
                                this action is done before starting the compilation.
EOF
}

function build_module() {
    if [[ $CLEAN_MODULES_REPO ]]; then
        git_reset_repo_hard
    fi
	$ROOT/raspi/qt5/bin/qmake -r

	make -j 10
	make install
}

function build_qtbase() {
    export CROSS_COMPILE=$ROOT/raspi/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin/arm-linux-gnueabihf-
    export SYSROOT=$ROOT/raspbian/sysroot
    QMAKE_FILE=mkspecs/devices/$TARGET_DEVICE/qmake.conf

    if [[ $CLEAN_MODULES_REPO ]]; then
        git_reset_repo_hard
    fi

    # Add missing INCLUDEPATH in qmake conf
    grep -q 'INCLUDEPATH' $QMAKE_FILE || cat>>$QMAKE_FILE << EOL
    INCLUDEPATH += \$\$[QT_SYSROOT]/opt/vc/include
    INCLUDEPATH += \$\$[QT_SYSROOT]/opt/vc/include/interface/vcos
    INCLUDEPATH += \$\$[QT_SYSROOT]/opt/vc/include/interface/vcos/pthreads
    INCLUDEPATH += \$\$[QT_SYSROOT]/opt/vc/include/interface/vmcs_host/linux
EOL

    ./configure -release -opengl es2 -device $TARGET_DEVICE \
        -device-option CROSS_COMPILE=$CROSS_COMPILE \
        -sysroot $SYSROOT \
        -opensource -confirm-license -make libs \
        -prefix /usr/local/qt5pi \
        -extprefix $OUTPUT_DIR \
        -hostprefix $OUTPUT_HOST_DIR

    make -j 10
    make install
    ln -sf $OUTPUT_HOST_DIR/bin/qmake $ROOT/bin/qmake-qtrpi
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    KEY="$1"
    case $KEY in
        -h|--help)
            DISPLAY_HELP=true
        ;;
        -c|--clean-output)
            CLEAN_OUTPUT=true
        ;;

        -m|--clean-modules-repo)
            CLEAN_MODULES_REPO=true
        ;;

        *)
        ;;
    esac
    shift
done

if [[ $DISPLAY_HELP ]]; then
    usage
    exit 0
fi

echo $CLEAN_MODULES_REPO

if [[ $CLEAN_OUTPUT ]]; then
    message 'Clean output directory...'
    rm -rf $OUTPUT_HOST_DIR/*
    rm -rf $OUTPUT_DIR/*
fi

message 'Build qtbase...'
pushd $ROOT/modules/qtbase
build_qtbase
popd

for MODULE in qtdeclarative qt3d qtquickcontrols qtquickcontrols2; do
    message "Build $MODULE..."
    pushd $ROOT/modules/$MODULE
    build_module
    popd
done

