FROM alpine
MAINTAINER marion "zhengyi@wanpinghui.com"

RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.8/main/" > /etc/apk/repositories \
    && echo -ne "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.8/community/" >> /etc/apk/repositories \
    && apk --update add curl tcpdump strace bash tree tzdata tini \
    && rm -rf /var/cache/apk/* \
    && cp -r -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && wget https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz \
    && mkdir ./ffmpeg-linux \
    && tar -xvJf ffmpeg-release-amd64-static.tar.xz --strip-components 1 -C ./ffmpeg-linux \
    && mv ./ffmpeg-linux/ffmpeg /usr/local/bin/ \
    && rm -rf ./ffmpeg*
ENV LANG zh_CN.UTF-8
ENV PATH $PATH:/sbin

CMD ["/bin/bash"]
