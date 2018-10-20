FROM alpine
MAINTAINER Marion "trboyspace@126.com"

WORKDIR /
COPY ./kafka/docker-entrypoint.sh .
RUN mkdir -p /opt /data/kafka /conf \
    && chmod a+x /docker-entrypoint.sh \
    && wget http://mirrors.shu.edu.cn/apache/kafka/2.0.0/kafka_2.11-2.0.0.tgz \
    && tar -zxvf ./kafka_2.11-2.0.0.tgz \
    && mv -f ./kafka_2.11-2.0.0 /opt/ \
    && ln -sf /opt/kafka_2.11-2.0.0 /opt/kafka \
    && rm -rf ./kafka_2.11-2.0.0.tgz \
    && echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.8/main/" > /etc/apk/repositories \
    && echo -ne "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.8/community/" >> /etc/apk/repositories \
    && apk update \
    && apk --update --no-cache add openjdk8-jre bash tzdata tini \
    && rm -rf /var/cache/apk/* \
    && cp -rf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
WORKDIR /opt/kafka/bin/
ENV LANG C.UTF-8
ENV PATH $PATH:/opt/kafka/bin:/sbin
ENV KAFKA_HOME /opt/kafka
ENV KAFKA_CONF_DIR /conf
ENV KAFKA_LOG_DIRS /data/kafka
ENV KAFKA_BROKER_ID -1
ENV KAFKA_ZOOKEEPER_CONNECT localhost:2181
EXPOSE 9092

ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]
CMD ["kafka-server-start.sh", "/opt/kafka/config/server.properties"]