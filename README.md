# qtrpi

## Purpose
Offer an easy-to-use environment to cross-compile Qt application on a Raspberry Pi. This repo contains all the scripts necessary to prepare a sysroot, cross-compile Qt and deploy Qt libraries to your Raspberry.

For more information, go to http://www.qtrpi.com/faq.

## How to add a new Qt module in QtRpi?
* All the modules are cloned from the official Qt website (http://code.qt.io/)
* If you want to add a module, just add the repository name in the file [utils/synchronize-qt-modules.sh] (https://github.com/neuronalmotion/qtrpi/blob/develop/utils/synchronize-qt-modules.sh)
* You might have to add some packages in the sysroot, this can be done in [utils/prepare-sysroot-full.sh] (https://github.com/neuronalmotion/qtrpi/blob/develop/utils/prepare-sysroot-full.sh)
* Once you have modified these scripts, you should be able to re-execute [init-qtrpi-full.sh](https://github.com/neuronalmotion/qtrpi/blob/develop/init-qtrpi-full.sh) and see the magic happen.

