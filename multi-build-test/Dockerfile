FROM registry.cn-beijing.aliyuncs.com/shyapp/golang AS builder

WORKDIR /root/
RUN mkdir -p ./src/git.wanpinghui/WPH \
    && mkdir -p ./src/git.wangyangming.org.cn/meeting20/service \
    && git clone -b meeting-master http://git.wanpinghui.com/WPH/go_common.git --depth=1 ./src/git.wanpinghui/WPH/go_common \
    && git clone -b master http://xuwc:blessing@git.wangyangming.org.cn/meeting20/entity.git --depth=1 ./src/git.wangyangming.org.cn/meeting20/entity \
    && git clone -b master_2.0_im http://xuwc:blessing@git.wangyangming.org.cn/meeting20/service/go_live.git --depth=1 ./src/git.wangyangming.org.cn/meeting20/service/go_live \
    && export GOPATH="$GOPATH:/root/" \
    && cd ./src/git.wangyangming.org.cn/meeting20/service/go_live \
    && go get -v \
    && mkdir -p ./bin \
    && m -rf ./bin/* \
    && cp -rf "./static" "./bin/static" \
    && GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -tags=jsoniter -ldflags "-s" -v -o ./bin/$project_name .

FROM registry.cn-beijing.aliyuncs.com/shyapp/alpine-ffmpeg

ENV GIN_MODE release
RUN mkdir -p /opt/go_live /log/go_live
WORKDIR /opt/go_live
COPY --from=builder /root/src/git.wangyangming.org.cn/meeting20/service/go_live/bin .
RUN chmod a+x ./go_live
EXPOSE 8083
EXPOSE 50053

ENV PATH $PATH:/sbin:/opt/go_live

ENTRYPOINT ["tini", "--"]
CMD ["go_live", "-c", "config", ">>", "/log/go_live/log.log", "2>&1", "&"]