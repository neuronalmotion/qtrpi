###############################################################################
# DO NOT EXECUTE THIS FILE
# IT IS INTENDED TO BE INCLUDED WITH THE FOLLOWING SYNTAX:
# source ${0%/*}/common.sh
# (the directory of the calling script is assumed to be the same as common.sh)
###############################################################################

ROOT=${QTRPI_ROOT-/opt/qtrpi}
TARGET_DEVICE=${QTRPI_TARGET_DEVICE-"linux-rasp-pi2-g++"}
RPI_HOST=$QTRPI_HOST

# Get absolute path of script dir for later execution
# /!\ has to be executed *before* any "cd" command
SCRIPT=$( readlink -m $( type -p $0 ))
UTILS_DIR=`dirname ${SCRIPT}`

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

