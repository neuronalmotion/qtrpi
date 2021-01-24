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
RUN git clone https://github.com/MoJo2600/qtrpi.git -b 5.12.9

# Setup Qtrpi environment
ENV QTRPI_QT_VERSION='5.12.9' \
    QTRPI_TARGET_DEVICE='linux-rasp-pi3-g++' \
    QTRPI_TARGET_HOST='pi@localhost' \
    QTRPI_DOCKER='True'

# Change workdir
WORKDIR /qtrpi

# Execute init script and clean up after it
RUN ./init-qtrpi-full.sh && \
    rm /opt/qtrpi/*.img && \
    rm -rf /opt/qtrpi/raspi/*.tar.xz

# Extend path
ENV PATH=/opt/qtrpi/bin:$PATH

# Create path for source files
RUN mkdir /source
WORKDIR /source

# Execute build commands on run
CMD /qtrpi/docker/scripts/build.sh
