FROM alpine
MAINTAINER marion "zhengyi@wanpinghui.com"

COPY ./python36/py_requirements.txt /
RUN mkdir -p /root/.pip \
    && echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.8/main/" > /etc/apk/repositories \
    && echo -ne "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.8/community/" >> /etc/apk/repositories \
    && apk update \
    && apk --update --no-cache add curl tcpdump strace bash bash-completion tree tzdata libxslt libxslt-dev gd gd-dev \
    musl-dev make gcc g++ libffi-dev openssl openssl-dev build-base jpeg-dev zlib-dev geoip geoip-dev pcre pcre-dev \
    python3 python3-dev linux-headers libstdc++ libgcc patch logrotate inotify-tools vim supervisor \
    && rm -rf /var/cache/apk/* \
    && mv /usr/bin/pydoc /usr/bin/pydoc2.7 \
    && rm /usr/bin/python \
    && ln -s /usr/bin/pydoc3.6 /usr/bin/pydoc \
    && ln -s /usr/bin/python3.6 /usr/bin/python \
    && ln -s /usr/bin/python3.6m-config /usr/bin/python-config \
    && echo "[list]" > /root/.pip/pip.conf \
    && echo "format=columns" >> /root/.pip/pip.conf \
    && echo "" >> /root/.pip/pip.conf \
    && echo "[global]" >> /root/.pip/pip.conf \
    && echo "index-url = https://pypi.tuna.tsinghua.edu.cn/simple" >> /root/.pip/pip.conf \
    && pip3 install --upgrade pip \
    && pip3 install -U pbr setuptools virtualenv virtualenv-clone wheel \
    #python-debian python-systemd ssh-import-id stevedore \
    && pip3 install -r /py_requirements.txt \
    && rm -rf /py_requirements.txt \
    && cp -r -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo -ne "Python project latest image." >> /root/.built
WORKDIR /root/

CMD ["/bin/bash"]