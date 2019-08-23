FROM ccr.ccs.tencentyun.com/wanpinghui/alpine

WORKDIR /root/
RUN wget https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz \
&& mkdir ./ffmpeg-linux \
&& tar -xvJf ffmpeg-release-amd64-static.tar.xz --strip-components 1 -C ./ffmpeg-linux \
&& mv ./ffmpeg-linux/ffmpeg /usr/local/bin/ \
&& rm -rf ./ffmpeg*
ENV LANG zh_CN.UTF-8
ENV PATH $PATH:/sbin

CMD ["/bin/bash"]
