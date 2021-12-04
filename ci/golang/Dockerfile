FROM golang:1.16-alpine3.13

ENV LANG zh_CN.UTF-8 \
    LC_ALL=en_US.UTF-8
ENV GOROOT=/usr/local/go
ENV GOPATH=/go
ENV GO111MODULE=on
ENV GOPROXY=https://goproxy.cn
ENV GOPRIVATE=ctgit.szctjt.cn

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk --update --no-cache add git curl bash tree tzdata wget vim openssh \
    && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
    && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.33-r0/glibc-2.33-r0.apk \
    && apk add glibc-2.33-r0.apk \
    && rm -rf /var/cache/apk/* glibc-2.33-r0.apk \
    && cp -r -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && git config --global credential.helper store

RUN git config --global url."git@ctgit.szctjt.cn:".insteadOf "http://ctgit.szctjt.cn/"
RUN mkdir /root/.ssh && echo "StrictHostKeyChecking no " > /root/.ssh/config

WORKDIR /workspace

CMD ["bash"]