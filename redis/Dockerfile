FROM redis
MAINTAINER Marion "trboyspace@126.com"

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
WORKDIR /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh", "redis-server"]