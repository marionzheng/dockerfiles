FROM ubuntu:14.04
MAINTAINER marion "zhengyi@wanpinghui.com"

# Install build dependencies (and vim + picocom for editing/debugging)
RUN apt-get -qq update \
    && apt-get install -y make unrar-free autoconf automake libtool gcc g++ gperf flex bison texinfo gawk ncurses-dev libexpat-dev python-dev python python-serial sed git unzip bash help2man wget bzip2 vim picocom \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add a user because we can't build the toolchain with root
RUN useradd -d /esp -m esp && \
    usermod -a -G dialout,staff esp && \
    mkdir -p /etc/sudoers.d && \
    echo "esp ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/esp && \
    chmod 0440 /etc/sudoers.d/esp

USER esp

# Get the esp-open-sdk
RUN git clone --recursive https://github.com/pfalcon/esp-open-sdk.git /esp/esp-open-sdk

# Build the esp-open-sdk
RUN cd /esp/esp-open-sdk && make toolchain esptool libhal STANDALONE=n

# Add the esp-open-sdk bin folder to PATH
ENV PATH /esp/esp-open-sdk/xtensa-lx106-elf/bin:$PATH

# Get the esp-open-rtos SDK
RUN git clone --recursive https://github.com/Superhouse/esp-open-rtos.git /esp/esp-open-rtos

RUN mkdir -p /esp/project && \
    cp -rf /esp/esp-open-rtos/examples/Makefile /esp/

WORKDIR /esp/project