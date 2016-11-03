#!/bin/bash

source ${0%/*}/common.sh
cd_root

# Download and unzip the latest wheezy image (~1.4Go zipped)
message 'Downloading Raspbian latest image'
cd raspbian
wget --content-disposition https://downloads.raspberrypi.org/raspbian_latest
unzip *raspbian*.zip

