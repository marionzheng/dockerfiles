FROM alpine
MAINTAINER marion "zhengyi@wanpinghui.com"

COPY ./ffmpeg /usr/local/bin/
RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.8/main/" > /etc/apk/repositories \
    && echo -ne "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.8/community/" >> /etc/apk/repositories \
    && apk --update add curl tcpdump strace bash tree tzdata tini \
    && rm -rf /var/cache/apk/* \
    && cp -r -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo -ne "alpine linux with ffmpeg latest image." >> /root/.built
ENV LANG zh_CN.UTF-8
ENV PATH $PATH:/sbin

CMD ["/bin/bash"]
