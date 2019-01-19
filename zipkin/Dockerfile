FROM openzipkin/zipkin
MAINTAINER marion "zhengyi@wanpinghui.com"

RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.8/main/" > /etc/apk/repositories \
    && echo -ne "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.8/community/" >> /etc/apk/repositories \
    && apk --update add tzdata \
    && rm -rf /var/cache/apk/* \
    && cp -r -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo -ne "openzipkin latest image." >> /root/.built
WORKDIR /zipkin
ENV LANG C.UTF-8
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk/jre
ENV JAVA_VERSION 8u171
ENV JAVA_ALPINE_VERSION 8.171.11-r0
ENV ZIPKIN_REPO https://jcenter.bintray.com
ENV ZIPKIN_VERSION 2.11.12
ENV JAVA_OPTS -Djava.security.egd=file:/dev/./urandom
EXPOSE 9410
EXPOSE 9411

CMD ["/bin/bash",  "-c", "test -n \"$STORAGE_TYPE\" && source .${STORAGE_TYPE}_profile; test -n \"$SCRIBE_ENABLED\" && JAVA_OPTS=\"${JAVA_OPTS} -Dloader.path=scribe -Dspring.profiles.active=scribe\"; test -n \"$KAFKA_ZOOKEEPER\" && JAVA_OPTS=\"${JAVA_OPTS} -Dloader.path=kafka08 -Dspring.profiles.active=kafka08\"; exec java ${JAVA_OPTS} -cp . org.springframework.boot.loader.PropertiesLauncher"]