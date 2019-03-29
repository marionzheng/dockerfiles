FROM ubuntu:14.04
MAINTAINER marion "zhengyi@wanpinghui.com"

RUN dpkg --add-architecture i386 \
    && apt-get -qq update \
    && apt-get install -y make unrar-free autoconf automake libtool gcc g++ gperf libncurses-dev flex bison texinfo gawk ncurses-dev libexpat-dev python-dev python python-pip python-setuptools python-serial python-pyparsing libxml2-dev libxslt1-dev zlib1g-dev libffi-dev libssl-dev sed git unzip bash help2man wget bzip2 vim picocom libc6:i386 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add a user because we can't build the toolchain with root
RUN useradd -d /home/esp -m esp && \
    usermod -a -G dialout,staff esp && \
    mkdir -p /etc/sudoers.d && \
    echo "esp ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/esp && \
    chmod 0440 /etc/sudoers.d/esp

USER esp

COPY ./esp-toolchain-all-in-one/xtensa-lx106-elf.tar.bz2 /home/esp/
COPY ./esp-toolchain-all-in-one/xtensa-esp32-elf-linux64-1.22.0-80-g6c4433a-5.2.0.tar.gz /home/esp/
RUN cd /home/esp/ && \
    tar -jxvf xtensa-lx106-elf.tar.bz2 && \
    tar -zxvf xtensa-esp32-elf-linux64-1.22.0-80-g6c4433a-5.2.0.tar.gz && \
    rm -rf xtensa-lx106-elf.tar.bz2 && \
    rm -rf xtensa-esp32-elf-linux64-1.22.0-80-g6c4433a-5.2.0.tar.gz

ENV PATH "/home/esp/xtensa-lx106-elf/bin:/home/esp/xtensa-esp32-elf/bin:$PATH"

# Get the esp-open-sdk
#RUN git clone --recursive https://github.com/pfalcon/esp-open-sdk.git /home/esp/esp-open-sdk

# Build the esp-open-sdk
#RUN cd /home/esp/esp-open-sdk && make toolchain esptool libhal STANDALONE=n

# Add the esp-open-sdk bin folder to PATH
#ENV PATH /home/esp/esp-open-sdk/xtensa-lx106-elf/bin:$PATH

# Get the esp-open-rtos SDK
#RUN git clone --recursive https://github.com/Superhouse/esp-open-rtos.git /home/esp/esp-open-rtos

#RUN mkdir -p /home/esp/project && \
#    cp -rf /home/esp/esp-open-rtos/examples/Makefile /home/esp/ && \
#    cp -rf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

WORKDIR /home/esp/project