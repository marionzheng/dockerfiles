FROM alpine:3.11
MAINTAINER marion "marion@aionnect.com"

ADD ./glibc-2.31-r0.apk /
RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.11/main/" > /etc/apk/repositories \
    && echo -ne "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.11/community/" >> /etc/apk/repositories \
    && apk --update add curl tcpdump strace bash tree tzdata tini \
    && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
    #&& wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.31-r0/glibc-2.31-r0.apk \
    && apk add glibc-2.31-r0.apk \
    && rm -rf /var/cache/apk/* glibc-2.31-r0.apk \
    && cp -r -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
ENV LANG zh_CN.UTF-8
ENV PATH $PATH:/sbin

CMD ["bash"]
