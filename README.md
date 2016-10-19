# WebappQtRpi

## Cross-compilation
### Environment prepararation
You should export the environment variable `QTRPI_COMPILE_ROOT` to where you want to store the Qt RPi compile artefact. By default it will be expanded to `cross-compile` in the current directory.

TODO Add the procedure to prepare the cross-compile environment (using Ansible?)

### Compiled modules
* qtbase ((bin/qmake, bin/rcc, bin/uic, bin/moc, libQt5Core, libQt5Gui, ...)
* qt3d (libQt53DCore, libQt53DInput, libQt53DQuick, ...)
* qtcanvas3d (qml/QtCanvas3D, ...)
* qtdeclarative (bin/qml, bin/qmlscene, libQt5Qml, libQt5Quick, libQt5QuickParticles, libQt5QuickWidgets, ...)
* qtquickcontrols (qml/QtQuick)
* qtquickcontrols2 (libQt5LabsControls, qml/Qt/labs)

## Getting started on your development machine
Start by installing Ansible on your development machine:
```bash
sudo pip install ansible
```

After that, execute the following fab task to prepare your dev environment:
```bash
fab prepare_dev_environment
```

You should now be able to execute:
```bash
ng serve
```
And navigate to `http://localhost:42000
```

### Code scaffolding
Run `ng generate component component-name` to generate a new component. You can also use `ng generate directive/pipe/service/class`.


