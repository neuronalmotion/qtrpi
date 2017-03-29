# QtRpi

## Purpose
Offer an easy-to-use environment to cross-compile Qt application on a Raspberry Pi. This repo contains all the scripts necessary to prepare a sysroot, cross-compile Qt and deploy Qt libraries to your Raspberry.

For more information, go to http://www.qtrpi.com/faq.

## How to contact us?
You can fill a contact form from our [official website](https://www.neuronalmotion.com/contact/) or send us an email at contact [at] neuronalmotion [dot] com.

## Difference between init-qtrpi-minimal and init-qtrpi-full
* **init-qtrpi-minimal** the typical way: downloads ready-to-use Qt binaries for the Raspberry Pi and a minimal sysroot that we released on the [official website](http://www.qtrpi.com/download)
* **init-qtrpi-full** the custom way: compiles on your computer the Qt binaries for the Raspberry Pi. So you can tweak the configuration, enhance the compilation adding some missing Qt moudles to QtRpi or add some specific third-party depedencies

### Summary
|                     | init-qtrpi-minimal            | init-qtrpi-full                      |
| ------------------- | ----------------------------- | ------------------------------------ |
| Raspbian image      |                               | *from raspberrypi.org*               |
| Toochain            | *from github.com/raspberrypi* | *from from github.com/raspberrypi*   |
| Sysroot             | *from qtrpi.com*              | generated from raspbian image        |
| Qt binaries         | *from qtrpi.com*              | compiled                             |

## Tutorial of init-qtrpi-minimal.sh

This tutorial configure your host computer to be able to cross-compile Qt 5.7.0 applicaton for your Raspberry Pi 3. In this example, you already have a SSH access to your Raspberry Pi 3 at 192.168.1.12 with the user "pi".

### Requirements
* A 64-bit Linux host computer
* A Raspberry Pi 3

The script will use sudo several times to install the packages on the board. You should add your SSH key in your Raspberry Pi. For example with **ssh-copy-id**:
```
ssh-copy-id pi@192.168.1.12
```

### Installation 
Open a terminal follow the steps above:
```
git clone https://github.com/neuronalmotion/qtrpi.git
export QTRPI_QT_VERSION='5.7.0'
export QTRPI_TARGET_DEVICE='linux-rpi3-g++'
export QTRPI_TARGET_HOST='pi@192.168.1.12'
cd qtrpi
./init-qtrpi-minimal.sh
./deploy-qtrpi.sh --prepare-rpi
```

Note: You can also export the *environment variables* to your **.bashrc** and source it.

### Usage in CLI
```
cd myproject
/opt/qtrpi/bin/qmake-qtrpi
make
```

Note: You can also add **/opt/qtrpi/bin/** to your PATH in your .bashrc and call **qmake-qtrpi** without the full path.

### Usage in Qt Creator
*coming soon...*

## Tutorial of init-qtrpi-full.sh

### How to add a new Qt module in QtRpi?
* In this case, you must use [init-qtrpi-full.sh](https://github.com/neuronalmotion/qtrpi/blob/develop/init-qtrpi-full.sh), because you will have to recompile it on your computers
* All the modules are cloned from the official Qt website (http://code.qt.io/)
* If you want to add a module, just add the repository name in the file [qt-modules.txt](https://github.com/neuronalmotion/qtrpi/blob/develop/qt-modules.txt)
* You might have to add some packages in the sysroot, this can be done in [utils/prepare-sysroot-full.sh](https://github.com/neuronalmotion/qtrpi/blob/develop/utils/prepare-sysroot-full.sh)
* Once you have modified these scripts, you should be able to re-execute [init-qtrpi-full.sh](https://github.com/neuronalmotion/qtrpi/blob/develop/init-qtrpi-full.sh) and see the magic happen.

