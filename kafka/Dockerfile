FROM alpine
MAINTAINER Marion "trboyspace@126.com"

WORKDIR /
RUN mkdir -p /opt /data/kafka/log \
    && wget http://mirrors.shu.edu.cn/apache/kafka/2.0.0/kafka_2.11-2.0.0.tgz \
    && tar -zxvf ./kafka_2.11-2.0.0.tgz \
    && mv -f ./kafka_2.11-2.0.0 /opt/ \
    && ln -sf /opt/kafka_2.11-2.0.0 /opt/kafka \
    && rm -rf ./kafka_2.11-2.0.0.tgz \
    && echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.8/main/" > /etc/apk/repositories \
    && echo -ne "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.8/community/" >> /etc/apk/repositories \
    && apk --update add openjdk8-jre bash tzdata \
    && cp -rf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
WORKDIR /opt/kafka/bin/
ENV LANG C.UTF-8
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/kafka/bin
ENV KAFKA_HOME /opt/kafka
ENV KAFKA_DATA_DIR /data/kafka
ENV KAFKA_CONF_DIR /opt/kafka/config

ENTRYPOINT ["nohup", "/opt/kafka/bin/kafka-server-start.sh", "-daemon", "$KAFKA_CONF_DIR/server.properties", ">", "$KAFKA_DATA_DIR/log/kafka.log", "2>&1", "&"]