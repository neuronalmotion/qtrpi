#!/bin/bash
source ${0%/*}/common.sh

CACHE_ROOT='cache'

rsync -av --delete $CACHE_ROOT/raspi/tools $ROOT/raspi/tools
rsync -av --delete $CACHE_ROOT/raspbian/raspbian_latest.img $ROOT/raspbian/raspbian_latest.img
rsync -av --delete $CACHE_ROOT/modules $ROOT/modules
