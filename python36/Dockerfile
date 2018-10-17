FROM alpine
MAINTAINER marion "zhengyi@wanpinghui.com"

RUN mkdir -p /root/.pip /var/log/supervisor \
    && echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.8/main/" > /etc/apk/repositories \
    && echo -ne "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.8/community/" >> /etc/apk/repositories \
    && apk --update add curl tcpdump strace bash bash-completion tree tzdata musl-dev shadow gcc g++ alpine-sdk python3 python3-dev vim supervisor \
    && usermod -s /bin/bash root \
    && echo "export LS_OPTIONS='--color=auto'" >  /root/.bash_profile \
    && echo "alias ls='ls $LS_OPTIONS'" >>  /root/.bash_profile \
    && echo "alias ll='ls $LS_OPTIONS -l'" >>  /root/.bash_profile \
    && echo "alias l='ls $LS_OPTIONS -lA'" >>  /root/.bash_profile \
    && echo "alias python='python3'" >>  /root/.bash_profile \
    && echo "alias pip='pip3'" >>  /root/.bash_profile \
    && source /root/.bash_profile \
    && echo "[list]" > /root/.pip/pip.conf \
    && echo "format=columns" >> /root/.pip/pip.conf \
    && echo "" >> /root/.pip/pip.conf \
    && echo "[global]" >> /root/.pip/pip.conf \
    && echo "index-url = https://pypi.tuna.tsinghua.edu.cn/simple" >> /root/.pip/pip.conf \
    && pip3 install -U pip pbr \
    && cp -r -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo -ne "Python project latest image." >> /root/.built
WORKDIR /root/

CMD ["/bin/bash"]