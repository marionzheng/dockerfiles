FROM registry.cn-shenzhen.aliyuncs.com/szcttech/alpine:3.13

ENV     GIN_MODE release
RUN     mkdir -p /opt/{service-name} /log/{service-name}
WORKDIR /opt/{service-name}
COPY    ./bin/ ./
RUN     ls -l
RUN     chmod +x ./{service-name}

EXPOSE {http-port}
EXPOSE {grpc-port}
ENV PATH $PATH:/sbin:/opt/{service-name}

ENTRYPOINT ["tini", "--"]
CMD ["{service-name}", "web", "-c", "config.toml", ">>", "/log/{service-name}/log.log", "2>&1", "&"]