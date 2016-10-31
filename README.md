# qtrpi

## Purpose
Offer an easy-to-use environment to cross-compile Qt application on a Raspberry Pi. This repo contains all the scripts necessary to prepare a sysroot, cross-compile Qt and deploy Qt libraries to your Raspberry.

For more information, go to http://www.qtrpi.com/.

## Cross-compilation
### Environment variables
* The root directory of the scripts is `/opt/qtrpi`. If you want the root to be somewhere else, just export the environment the variable `QTRPI_ROOT`.
Note that if you do so, you have to rebuild everything from scratch. Some Qt paths are defined at compile time and cannot be updated afterwards.
* **`QTRPI_QT_VERSION`**: version of Qt you want to work on `export QTRPI_QT_VERSION=5.7.0`. Default is *5.7.0*
* **`QTRPI_TARGET_VERSION`**: target raspberry device of compilate. Default is *linux-rasp-pi2-g++* Today we support 3 values:
  * `linux-rasp-pi-g++`
  * `linux-rasp-pi2-g++`
  * `linux-rpi3-g++`
* **`QTRPI_TARGET_HOST`**: IP address of your Raspberry Pi (`export QTRPI_TARGET_HOST=pi@1.2.3.4`)

### Compiled modules
* qtbase ((bin/qmake, bin/rcc, bin/uic, bin/moc, libQt5Core, libQt5Gui, ...)
* qt3d (libQt53DCore, libQt53DInput, libQt53DQuick, ...)
* qtcanvas3d (qml/QtCanvas3D, ...)
* qtdeclarative (bin/qml, bin/qmlscene, libQt5Qml, libQt5Quick, libQt5QuickParticles, libQt5QuickWidgets, ...)
* qtquickcontrols (qml/QtQuick)
* qtquickcontrols2 (libQt5LabsControls, qml/Qt/labs)

