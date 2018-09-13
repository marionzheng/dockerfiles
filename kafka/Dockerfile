FROM wurstmeister/kafka
MAINTAINER Marion "trboyspace@126.com"

WORKDIR /
RUN mkdir -p /data/kafka \
    && echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.8/main/" > /etc/apk/repositories \
    && echo -ne "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.8/community/" >> /etc/apk/repositories \
    && apk --update add openjdk8-jre tzdata \
    && cp -rf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
WORKDIR /opt/kafka/bin
ENV LANG C.UTF-8
ENV KAFKA_LOG_DIRS /data/kafka
EXPOSE 9092

CMD ["start-kafka.sh"]