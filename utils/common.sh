###############################################################################
# DO NOT EXECUTE THIS FILE
# IT IS INTENDED TO BE INCLUDED WITH THE FOLLOWING SYNTAX:
# source ${0%/*}/common.sh
# (the directory of the calling script is assumed to be the same as common.sh)
###############################################################################

ROOT=${QTRPI_ROOT-/opt/qtrpi}
TARGET_DEVICE=${QTRPI_TARGET_DEVICE-'linux-rasp-pi2-g++'}
QT_VERSION=${QTRPI_QT_VERSION-'5.7.0'}
TARGET_HOST=$QTRPI_TARGET_HOST
RASPBIAN_BASENAME='raspbian_latest'
VERSION='1.1.0'

case $TARGET_DEVICE in
    'linux-rasp-pi-g++') DEVICE_NAME='rpi1' ;;
    'linux-rasp-pi2-g++') DEVICE_NAME='rpi2' ;;
    'linux-rpi3-g++') DEVICE_NAME='rpi3' ;;
esac

# Get absolute path of script dir for later execution
# /!\ has to be executed *before* any "cd" command
SCRIPT=$( readlink -m $( type -p $0 ))
UTILS_DIR=`dirname ${SCRIPT}`

# exclude new lines from array
readarray -t QT_MODULES < $(realpath $UTILS_DIR/../)/qt-modules.txt

function message() {
    echo
    echo '--------------------------------------------------------------------'
    echo $1
    echo '--------------------------------------------------------------------'
}

function exit_error() {
    echo $1
    exit -1
}

function cd_root() {
    if [[ ! -d $ROOT ]]; then
        exit_error "$ROOT directory does not exist. Please initialize it."
    fi
    cd $ROOT
}

function clean_git_and_compilation() {
    git reset --hard HEAD
    git clean -fd
    make clean -j 10
}

