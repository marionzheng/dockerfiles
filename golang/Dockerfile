FROM golang:1.15.6
MAINTAINER marion "marion@aionnect.com"

ENV GOPATH /go
ENV GOROOT /usr/local/go
ENV GO111MODULE auto
ENV GOPROXY https://goproxy.cn

RUN go get -u github.com/google/wire/cmd/wire \
    && go get -u github.com/swaggo/swag/cmd/swag

WORKDIR /go

CMD ["/bin/bash"]
