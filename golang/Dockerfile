FROM golang
MAINTAINER marion "zhengyi@wanpinghui.com"

RUN git clone https://github.com/golang/net.git $GOPATH/src/golang.org/x/net \
    && git clone https://github.com/golang/text.git $GOPATH/src/golang.org/x/text \
    && git clone https://github.com/golang/tools.git $GOPATH/src/golang.org/x/tools \
    && git clone https://github.com/golang/sys.git $GOPATH/src/golang.org/x/sys \
    && git clone https://github.com/golang/crypto.git $GOPATH/src/golang.org/x/crypto \
    && git clone https://github.com/golang/time.git $GOPATH/src/golang.org/x/time \
    && cd $GOPATH/src/ \
    && /usr/local/go/bin/go install golang.org/x/text \
    && git clone https://github.com/census-instrumentation/opencensus-go $GOPATH/src/go.opencensus.io \
    && /usr/local/go/bin/go get -v github.com/apache/thrift/lib/go/thrift github.com/fatih/color github.com/gogo/protobuf/proto github.com/hashicorp/go-multierror github.com/hashicorp/golang-lru github.com/influxdata/influxdb1-client github.com/juju/ratelimit github.com/julienschmidt/httprouter github.com/kavu/go_reuseport github.com/opentracing/opentracing-go github.com/opentracing/opentracing-go/ext github.com/opentracing/opentracing-go/log github.com/rubyist/circuitbreaker github.com/soheilhy/cmux github.com/valyala/fastrand github.com/vmihailenco/msgpack go.opencensus.io/trace \
    && /usr/local/go/bin/go get -u -v github.com/smallnest/rpcx/... \
    && mkdir -p /root/.ssh
COPY ./id_rsa /root/.ssh/
RUN chmod 600 /root/.ssh/id_rsa
ENV LANG zh_CN.UTF-8
ENV PATH $PATH:/sbin

CMD ["/bin/bash"]
