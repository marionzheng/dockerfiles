FROM alpine:3.13
ENV TINI_VERSION v0.19.0-r0
ENV LANG zh_CN.UTF-8 \
    LC_ALL=en_US.UTF-8

COPY /tools/simsun.ttc /usr/share/fonts/
COPY /tools/nsswitch.conf /etc/

RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.13/main/" > /etc/apk/repositories \
    && echo -ne "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.13/community/" >> /etc/apk/repositories \
    && apk add --update --no-cache curl tcpdump strace bash tree tzdata tini \
    && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
    && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.33-r0/glibc-2.33-r0.apk \
    && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.33-r0/glibc-bin-2.33-r0.apk \
    && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.33-r0/glibc-i18n-2.33-r0.apk \
    && apk add glibc-2.33-r0.apk \
    && ln -sf /usr/glibc-compat/lib/ld-linux-x86-64.so.2 /usr/glibc-compat/lib/ld-2.33.so \
    && apk add glibc-bin-2.33-r0.apk glibc-i18n-2.33-r0.apk \
    && rm -rf /var/cache/apk/* glibc-2.33-r0.apk glibc-bin-2.33-r0.apk glibc-i18n-2.33-r0.apk  \
    && cp -rf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone

CMD ["bash"]