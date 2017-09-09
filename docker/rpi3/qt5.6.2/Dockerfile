FROM debian:stable-slim
LABEL maintainer="Alexander Rose <alex@rose-a.de>" 

# install necessary packages
RUN apt-get update -q && apt-get install -yq --no-install-recommends \
    build-essential \
    ca-certificates \
    curl \
    git \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Clone Qtrpi and additional scripts
RUN git clone https://github.com/rose-a/qtrpi.git -b docker-compatibility

# Setup Qtrpi environment
ENV QTRPI_QT_VERSION='5.6.2' \
    QTRPI_TARGET_DEVICE='linux-rpi3-g++' \
    QTRPI_TARGET_HOST='pi@localhost' \
    QTRPI_DOCKER='True'

# Change workdir
WORKDIR /qtrpi

# Execute init script and clean up after it
RUN ./init-qtrpi-minimal.sh && \
    rm /opt/qtrpi/*.zip && \
    rm -rf /opt/qtrpi/raspi/tools/.git && \
    rm -rf /opt/qtrpi/raspi/tools/arm-bcm2708/arm-* && \
    rm -rf /opt/qtrpi/raspi/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian   

# Extend path
ENV PATH=/opt/qtrpi/bin:$PATH

# Create path for source files
RUN mkdir /source
WORKDIR /source

# Execute build commands on run
CMD /qtrpi/docker/scripts/build.sh
