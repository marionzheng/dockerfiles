FROM centos
MAINTAINER marion "zhengyi@wanpinghui.com"

WORKDIR /root/
RUN rpm -Uvh https://mirrors.ustc.edu.cn/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm \
    && yum update -y \
    && yum -y install vim git wget \
    && git clone https://github.com/libra/libra.git /usr/local/libra \
    && wget https://studygolang.com/dl/golang/go1.12.9.linux-amd64.tar.gz \
    && tar -xvf go1.12.9.linux-amd64.tar.gz \
    && mv ./go /usr/local/ \
    && curl https://sh.rustup.rs -sSf > rust.sh \
    && sh ./rust.sh -y \
    && source /root/.cargo/env \
    && rustup toolchain install nightly-$(date +20%y-%m-%d)-x86_64-unknown-linux-gnu \
    && rustup override set nightly-$(date +20%y-%m-%d) \
    && wget https://github.com/Kitware/CMake/releases/download/v3.15.2/cmake-3.15.2.tar.gz \
    && tar -xvzf cmake-3.15.2.tar.gz \
    && cd cmake-3.15.2/ \
    && ./bootstrap \
    && gmake && gmake install \
    && wget https://github.com/protocolbuffers/protobuf/releases/download/v3.6.1/protobuf-all-3.6.1.tar.gz \
    && echo -ne "centos linux based libra development environment image." >> /root/.built
ENV LANG zh_CN.UTF-8
ENV GOROOT /usr/local/go
ENV GOPATH /go
ENV PATH $PATH:/sbin:$GOROOT/bin:$GOPATH/bin:/root/.cargo/bin

CMD ["/bin/bash"]
