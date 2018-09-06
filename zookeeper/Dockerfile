FROM zookeeper
MAINTAINER Marion "trboyspace@126.com"

WORKDIR /
COPY ./zookeeper/zk_data_clean.sh .
RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.8/main/" > /etc/apk/repositories \
    && echo -ne "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.8/community/" >> /etc/apk/repositories \
    && apk --update add tzdata \
    && cp -rf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && chmod +x ./zk_data_clean.sh \
    && echo -ne "1       0       *       *       *       /zk_data_clean.sh" >> /var/spool/cron/crontabs/root \
    && crond

ENTRYPOINT ["/bin/bash"]

# zookeeper image default env values:
# ZOO_DATA_LOG_DIR = /datalog
# ZOO_DATA_DIR     = /data       (myid file is here)
# ZOO_CONF_DIR     = /conf       (default config file name is zoo.cfg)
# ZOO_USER         = zookeeper
# ZOO_PORT         = 2181
# ZOO_TICK_TIME    = 2000
# ZOO_INIT_LIMIT   = 5
# ZOO_SYNC_LIMIT   = 2
# ZOO_AUTOPURGE_SNAPRETAINCOUNT = 3
# ZOO_AUTOPURGE_PURGEINTERVAL   = 0
# ZOO_MAX_CLIENT_CNXNS          = 60