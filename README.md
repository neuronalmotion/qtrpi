# qtrpi

## Purpose
Offer an easy-to-use environment to cross-compile Qt application on a Raspberry Pi. This repo contains all the scripts necessary to prepare a sysroot, cross-compile Qt and deploy Qt libraries to your Raspberry.

For more information, go to http://www.qtrpi.com/.

## Cross-compilation
### Environment prepararation
* The root directory of the scripts is `/opt/qtrpi`. If you want the root to be somewhere else, just export the environment the variable `QTRPI_ROOT`.
Note that if you do so, you have to rebuild everything from scratch. Some Qt paths are defined at compile time and cannot be updated afterwards.
* export `QTRPI_HOST` with the IP address of your Raspberry Pi like so: `export QTRPI_HOST=pi@1.2.3.4`.

### Compiled modules
* qtbase ((bin/qmake, bin/rcc, bin/uic, bin/moc, libQt5Core, libQt5Gui, ...)
* qt3d (libQt53DCore, libQt53DInput, libQt53DQuick, ...)
* qtcanvas3d (qml/QtCanvas3D, ...)
* qtdeclarative (bin/qml, bin/qmlscene, libQt5Qml, libQt5Quick, libQt5QuickParticles, libQt5QuickWidgets, ...)
* qtquickcontrols (qml/QtQuick)
* qtquickcontrols2 (libQt5LabsControls, qml/Qt/labs)

