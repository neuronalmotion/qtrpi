#!/bin/bash

source ${0%/*}/utils/common.sh
OUTPUT_DIR=$ROOT/raspi/qt5pi

cd_root

function usage() {
    cat <<EOF
Usage: $0 [options]

-h| --help                      Display help text.
-p| --prepare-rpi               Prepare the Raspberry Pi device by:
                                - Installing package dependencies for Qt
                                - Add /usr/local/qt5pi/lib to the ldd list of directories
                                - Fix libEGL and libGLESv2 links
EOF
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    KEY="$1"
    case $KEY in
        -h|--help)
            DISPLAY_HELP=true
        ;;
        -p|--prepare-rpi)
            PREPARE_RPI=true
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

if [[ $PREPARE_RPI ]]; then
    ssh $TARGET_HOST 'sudo mkdir /usr/local/qt5pi ; sudo chown -R pi:pi /usr/local/qt5pi'
    ssh $TARGET_HOST 'sudo apt-get install -y apt-transport-https'
    ssh $TARGET_HOST 'sudo apt-get install -y libts-0.0-0 libinput5'
    ssh $TARGET_HOST "sudo sh -c 'echo /usr/local/qt5pi/lib > /etc/ld.so.conf.d/qt5pi.conf'"

    # to fix which version of libEGL should be picked by Qt applications (/opt/vc rather than /usr/lib/....)
    ssh $TARGET_HOST "sudo sh -c 'rm /usr/lib/arm-linux-gnueabihf/libEGL.so.1.0.0 /usr/lib/arm-linux-gnueabihf/libGLESv2.so.2.0.0'"
    ssh $TARGET_HOST "sudo sh -c 'ln -sf /opt/vc/lib/libEGL.so /usr/lib/arm-linux-gnueabihf/libEGL.so.1.0.0'"
    ssh $TARGET_HOST "sudo sh -c 'ln -sf /opt/vc/lib/libGLESv2.so /usr/lib/arm-linux-gnueabihf/libGLESv2.so.2.0.0'"
fi

rsync -avz $OUTPUT_DIR $TARGET_HOST:/usr/local/
ssh $TARGET_HOST 'sudo ldconfig'

