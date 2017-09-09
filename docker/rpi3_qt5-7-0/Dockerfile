FROM ubuntu:latest
LABEL maintainer="Alexander Rose <alex@rose-a.de>" 

# install necessary packages
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    unzip

# Clone Qtrpi
RUN git clone https://github.com/neuronalmotion/qtrpi.git

# Clone additional scripts
RUN git clone https://github.com/rose-a/qtrpi-docker-image.git

# Copy scripts
RUN cp /qtrpi-docker-image/scripts/docker-build.sh /qtrpi/ && \
    cp /qtrpi-docker-image/scripts/init-common.sh /qtrpi/utils/

# Setup Qtrpi environment
ENV QTRPI_QT_VERSION='5.7.0' \
    QTRPI_TARGET_DEVICE='linux-rpi3-g++' \
    QTRPI_TARGET_HOST='pi@localhost' \
    QTRPI_DOCKER='True'

# Change workdir
WORKDIR /qtrpi

# Execute init script
RUN ./init-qtrpi-minimal.sh

# Extend path
ENV PATH=/opt/qtrpi/bin:$PATH

# Create path for source files
RUN mkdir /source
WORKDIR /source

# Execute build commands on run
CMD /qtrpi/docker-build.sh
