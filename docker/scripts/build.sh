#!/bin/bash

source ${0%/*}/utils/common.sh

# Run qmake
message 'running qmake...'
qmake_cmd

# Run make
message 'running make...'
make_cmd
