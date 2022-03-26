FROM registry-vpc.cn-shenzhen.aliyuncs.com/szcttech/openjdk-alpine:8

WORKDIR /app

ARG JAR_FILE
COPY ${JAR_FILE} /app/app.jar


ENTRYPOINT ["/sbin/tini", "--"]
CMD ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app/app.jar","--spring.config.location=/app/"]
