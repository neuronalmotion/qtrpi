# qtrpi

## Cross-compilation
### Environment prepararation
You should export the **absolute path** of the Qt RPi compilation output directory in the variable `QTRPI_COMPILE_ROOT`. By default it will be expanded to `cross-compile` in the current directory.

TODO Add the procedure to prepare the cross-compile environment (using Ansible?)

### Compiled modules
* qtbase ((bin/qmake, bin/rcc, bin/uic, bin/moc, libQt5Core, libQt5Gui, ...)
* qt3d (libQt53DCore, libQt53DInput, libQt53DQuick, ...)
* qtcanvas3d (qml/QtCanvas3D, ...)
* qtdeclarative (bin/qml, bin/qmlscene, libQt5Qml, libQt5Quick, libQt5QuickParticles, libQt5QuickWidgets, ...)
* qtquickcontrols (qml/QtQuick)
* qtquickcontrols2 (libQt5LabsControls, qml/Qt/labs)

