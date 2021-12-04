FROM centos:centos7
ENV TINI_VERSION v0.19.0

ADD /tools/jdk-8u291-linux-x64.tar.gz /opt/java/
ADD /tools/dockerize /usr/bin/
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini

COPY /tools/simsun.ttc /usr/share/fonts/

RUN cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && mv ./tini /sbin/ \
    && chmod u+x /usr/bin/dockerize \
    && chmod a+x /sbin/tini \
    && yum install zip unzip wget -y \
    && yum install -y fontconfig && fc-cache -fv \
    && yum clean all

ENV LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    JAVA_HOME=/opt/java/jdk1.8.0_291
ENV PATH=$PATH:$JAVA_HOME/bin \
    CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

CMD ["bash"]