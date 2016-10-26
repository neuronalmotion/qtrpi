# Rename 'sysroot' to 'sysroot-full'
# create a 'sysroot-minimal' and a 'sysroot' symbolic link on it
mv /opt/qtrpi/raspbian/sysroot /opt/qtrpi/raspbian/sysroot-full
mkdir /opt/qtrpi/raspbian/sysroot-minimal
ln -s /opt/qtrpi/raspbian/sysroot-minimal /opt/qtrpi/raspbian/sysroot

# Copy /lib
mkdir -p /opt/qtrpi/raspbian/sysroot-minimal/lib
rsync -a /opt/qtrpi/raspbian/sysroot-full/lib /opt/qtrpi/raspbian/sysroot-minimal

# Copy /usr/include and /usr/lib
mkdir -p /opt/qtrpi/raspbian/sysroot-minimal/usr
rsync -a /opt/qtrpi/raspbian/sysroot-full/usr/include /opt/qtrpi/raspbian/sysroot-minimal/usr
rsync -a /opt/qtrpi/raspbian/sysroot-full/usr/lib /opt/qtrpi/raspbian/sysroot-minimal/usr

# Copy /opt/vc
mkdir -p /opt/qtrpi/raspbian/sysroot-minimal/opt/vc/
rsync -a /opt/qtrpi/raspbian/sysroot-full/opt/vc/ /opt/qtrpi/raspbian/sysroot-minimal/opt/vc/
