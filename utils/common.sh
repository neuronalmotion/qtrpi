###############################################################################
# DO NOT EXECUTE THIS FILE
# IT IS INTENDED TO BE INCLUDED WITH THE FOLLOWING SYNTAX:
# source ${0%/*}/common.sh
# (the directory of the calling script is assumed to be the same as common.sh)
###############################################################################

VERSION='1.2.3'

function message() {
    echo
    echo '--------------------------------------------------------------------'
    echo $1
    echo '--------------------------------------------------------------------'
}

function exit_error() {
    echo -e $1
    exit -1
}

function device_name() {
    case $1 in
        'linux-rasp-pi-g++') NAME='rpi1' ;;
        'linux-rasp-pi2-g++') NAME='rpi2' ;;
        'linux-rpi3-g++') NAME='rpi3' ;;
    esac
    echo $NAME
}

validate_var_qtrpi_qt_version() {
    for VERSION in '5.6.2' '5.7.0'; do
        if [[ "$QTRPI_QT_VERSION" == "$VERSION" ]]; then
            VALID=true
        fi
    done

    if [[ ! $VALID ]]; then
        exit_error "Invalid QTRPI_QT_VERSION value ($QTRPI_QT_VERSION). Supported values: \n- 5.6.2 \n- 5.7.0"
    fi
}

validate_var_qtrpi_target_device() {
    NAME=$(device_name $QTRPI_TARGET_DEVICE)

    if [[ ! $NAME ]]; then
        exit_error "Invalid QTRPI_TARGET_DEVICE value ($QTRPI_TARGET_DEVICE). Supported values: \n- linux-rasp-pi-g++ \n- linux-rasp-pi2-g++ \n- linux-rpi3-g++"
    fi
}

validate_var_qtrpi_target_host() {
    TARGET_USER=$(echo $QTRPI_TARGET_HOST | cut -d@ -f1)

    if [[ "$TARGET_USER" == "$QTRPI_TARGET_HOST" ]] ; then
        exit_error "Invalid QTRPI_TARGET_HOST value ($QTRPI_TARGET_HOST). Supported value should have the format 'user@ip-address' (e.g. pi@192.168.0.42)."
    fi
}

check_env_vars() {
    : "${QTRPI_QT_VERSION:?Invalid environment variable, please export QTRPI_QT_VERSION.}"
    : "${QTRPI_TARGET_DEVICE:?Invalid environment variable: please export QTRPI_TARGET_DEVICE.}"
    : "${QTRPI_TARGET_HOST:?Invalid environment variable: please export QTRPI_TARGET_HOST.}"

    validate_var_qtrpi_qt_version
    validate_var_qtrpi_target_device
    validate_var_qtrpi_target_host
    
}


ROOT=${QTRPI_ROOT-/opt/qtrpi}
TARGET_DEVICE=${QTRPI_TARGET_DEVICE-'linux-rasp-pi2-g++'}
QT_VERSION=${QTRPI_QT_VERSION-'5.7.0'}
TARGET_HOST=$QTRPI_TARGET_HOST
RASPBIAN_BASENAME='raspbian_latest'

DEVICE_NAME=$(device_name $TARGET_DEVICE)

QTRPI_ZIP="qtrpi-${DEVICE_NAME}_qt-${QT_VERSION}.zip"
QTRPI_BASE_URL='http://www.qtrpi.com/downloads'
QTRPI_SYSROOT_URL="$QTRPI_BASE_URL/sysroot/qtrpi-sysroot-minimal-latest.zip"
QTRPI_MINIMAL_URL="$QTRPI_BASE_URL/qtrpi/$DEVICE_NAME/$QTRPI_ZIP"
QTRPI_CURL_OPT=''

# evaluate docker usage
if [[ $QTRPI_DOCKER ]]; then
    echo "docker detected"
    DOCKER_BUILD=$QTRPI_DOCKER
fi

# Get absolute path of script dir for later execution
# /!\ has to be executed *before* any "cd" command
SCRIPT=$( readlink -m $( type -p $0 ))
UTILS_DIR=`dirname ${SCRIPT}`

if [[ "$UTILS_DIR" != *utils ]]; then
    UTILS_DIR="$UTILS_DIR/utils"
fi

# exclude new lines from array
readarray -t QT_MODULES < $(realpath $UTILS_DIR/../)/qt-modules.txt

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
    make distclean -j 10
}

function qmake_cmd() {
    LOG_FILE=${1:-'default'}
    $ROOT/raspi/qt5/bin/qmake -r |& tee $ROOT/logs/$LOG_FILE.log
}

function make_cmd() {
    LOG_FILE=${1:-'default'}
    make -j 10 |& tee --append $ROOT/logs/$LOG_FILE.log
}

function download_sysroot_minimal() {
    INSTALL=${1:-true}
    message "Download sysroot-minimal from $QTRPI_SYSROOT_URL"
    SYSROOT_ZIP='sysroot-minimal-latest.zip'
    curl $QTRPI_CURL_OPT -o $SYSROOT_ZIP $QTRPI_SYSROOT_URL
    if [[ "$INSTALL" = true ]]; then
        unzip -o $SYSROOT_ZIP
        $UTILS_DIR/switch-sysroot.sh minimal
    fi
}

function download_qtrpi_binaries() {
    INSTALL=${1:-true}
    message "Download qtrpi binaries from $QTRPI_MINIMAL_URL"
    curl $QTRPI_CURL_OPT -o $QTRPI_ZIP $QTRPI_MINIMAL_URL
    if [[ "$INSTALL" = true ]]; then
        unzip -o $QTRPI_ZIP
        ln -sf $ROOT/raspi/qt5/bin/qmake $ROOT/bin/qmake-qtrpi
    fi
}

