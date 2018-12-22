FROM redis
MAINTAINER Marion "trboyspace@126.com"

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo 65535 > /proc/sys/net/core/somaxconn
WORKDIR /usr/local/bin/
EXPOSE 6379

ENTRYPOINT ["docker-entrypoint.sh", "redis-server"]