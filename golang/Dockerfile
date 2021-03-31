FROM golang${tag}
MAINTAINER marion "marion@aionnect.com"

ENV GOPATH /go
ENV GOROOT /usr/local/go
ENV GO111MODULE auto
ENV GOPROXY https://goproxy.cn
ENV GOPRIVATE ${goprivate}

RUN export GOPROXY=https://goproxy.cn \
    && git clone --recursive https://github.com/golang/net.git $GOPATH/src/golang.org/x/net \
    && git clone --recursive https://github.com/golang/text.git $GOPATH/src/golang.org/x/text \
    && git clone --recursive https://github.com/golang/mod.git $GOPATH/src/golang.org/x/mod \
    && git clone --recursive https://github.com/golang/xerrors.git $GOPATH/src/golang.org/x/xerrors \
    && git clone --recursive https://github.com/golang/tools.git $GOPATH/src/golang.org/x/tools \
    && git clone --recursive https://github.com/golang/sys.git $GOPATH/src/golang.org/x/sys \
    && git clone --recursive https://github.com/golang/crypto.git $GOPATH/src/golang.org/x/crypto \
    && git clone --recursive https://github.com/golang/time.git $GOPATH/src/golang.org/x/time \
    && git clone --recursive https://gopkg.in/yaml.v2.git $GOPATH/src/gopkg.in/yaml.v2 \
    && go get -v -u github.com/google/wire/cmd/wire \
    && go get -v -u github.com/swaggo/swag/cmd/swag

WORKDIR /go

CMD ["/bin/bash"]
