#!/bin/bash

for DEVICE in 'linux-rasp-pi-g++' 'linux-rasp-pi2-g++' 'linux-rpi3-g++'; do
    for VERSION in '5.6.2' '5.7.0'; do
        export QTRPI_TARGET_DEVICE=$DEVICE
        export QTRPI_QT_VERSION=$VERSION
        echo "Compile $DEVICE $VERSION"
        ./utils/synchronize-qt-modules.sh -c \
            && ./utils/compile-qt-modules.sh \
            && ./utils/compile-example-qopenglwidget.sh \
            && ./utils/generate-compressed-qtrpi.sh 
    done
done

