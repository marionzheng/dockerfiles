FROM alpine
MAINTAINER marion "zhengyi@wanpinghui.com"

RUN mkdir -p /root/.pip \
    && echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.8/main/" > /etc/apk/repositories \
    && echo -ne "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.8/community/" >> /etc/apk/repositories \
    && apk --update add curl tcpdump strace bash tree tzdata musl-dev gcc g++ python3 python3-dev vim supervisor \
    && echo "alias python='python3'" >  /root/.bash_profile \
    && echo "alias pip='pip3'" >>  /root/.bash_profile \
    && source /root/.bash_profile \
    && echo "[list]" > /root/.pip/pip.conf \
    && echo "format=columns" >> /root/.pip/pip.conf \
    && echo "" >> /root/.pip/pip.conf \
    && echo "[global]" >> /root/.pip/pip.conf \
    && echo "index-url = https://pypi.tuna.tsinghua.edu.cn/simple" >> /root/.pip/pip.conf \
    && pip3 install -U pip pbr virtualenvwrapper \
    && apk --update add supervisor \
    && cp -r -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo -ne "Python project latest image." >> /root/.built
WORKDIR /root/

CMD ["/bin/bash"]