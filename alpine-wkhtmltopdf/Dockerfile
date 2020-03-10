FROM alpine:3.11
MAINTAINER marion "zhengyi@wanpinghui.com"

RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.11/main/" > /etc/apk/repositories \
    && echo -ne "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.11/community/" >> /etc/apk/repositories \
    && apk --update add curl tcpdump strace bash tree tzdata tini wkhtmltopdf fontconfig \
    && rm -rf /var/cache/apk/* \
    && cp -r -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && wget http://ftp-idc.pconline.com.cn/e9d38baa49fd8c4d3fd9c70e4a49842c/pub/download/201010/simsun.zip \
    && mkdir -p /usr/share/fonts/ \
    && unzip -o -d /usr/share/fonts/ simsun.zip \
    && rm -rf simsun.zip \
    && chmod -R 755 /usr/share/fonts/ \
    && rm -rf /var/cache/apk/* \
    && fc-cache -f -v
ENV LANG zh_CN.UTF-8
ENV PATH $PATH:/sbin

CMD ["/bin/bash"]
