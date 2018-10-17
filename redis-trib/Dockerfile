FROM ruby
MAINTAINER Marion "trboyspace@126.com"

WORKDIR /root/
COPY ./redis-trib/redis-3.3.5.gem .
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && mkdir -p /opt \
    && wget http://download.redis.io/releases/redis-4.0.11.tar.gz \
    && tar -zxvf ./redis-4.0.11.tar.gz \
    && mv -f ./redis-4.0.11 /opt/ \
    && ln -sf /opt/redis-4.0.11 /opt/redis \
    && gem install -l ./redis-3.3.5.gem \
    && rm -rf ./redis-4.0.11.tar.gz ./redis-3.3.5.gem
WORKDIR /opt/redis/src/

ENTRYPOINT ["/bin/bash"]