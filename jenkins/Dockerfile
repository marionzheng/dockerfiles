FROM alpine
MAINTAINER Marion "trboyspace@126.com"

# COPY ./jenkins/apache-maven-3.5.4-bin.zip /
# COPY ./jenkins/gradle-3.5.1-bin.zip /
# COPY ./jenkins/gradle-4.10.2-bin.zip /
COPY ./jenkins/glibc-2.28-r0.apk /
COPY ./jenkins/sgerrand.rsa.pub /etc/apk/keys/
RUN wget http://mirrors.jenkins.io/war/latest/jenkins.war \
    && wget http://mirrors.hust.edu.cn/apache/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.zip \
    && wget https://downloads.gradle.org/distributions/gradle-3.5.1-bin.zip \
    && wget https://downloads.gradle.org/distributions/gradle-4.10.2-bin.zip \
    && mkdir -p /var/jenkins_home/logs/jenkins \
    && cp "./jenkins.war" -d /var/jenkins_home/ \
    && unzip "./apache-maven-3.5.4-bin.zip" -d /var/jenkins_home/ \
    && unzip "./gradle-3.5.1-bin.zip" -d /var/jenkins_home/ \
    && unzip "./gradle-4.10.2-bin.zip" -d /var/jenkins_home/ \
    && echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.8/main/" > /etc/apk/repositories \
    && echo -ne "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.8/community/" >> /etc/apk/repositories \
    && apk update \
    && apk --update --no-cache add curl tcpdump strace bash bash-completion tree tzdata libxslt libxslt-dev gd gd-dev \
    musl-dev make gcc g++ libffi-dev openssl openssl-dev build-base jpeg-dev zlib-dev geoip geoip-dev pcre pcre-dev \
    linux-headers libstdc++ libgcc patch logrotate inotify-tools vim tini go nodejs nodejs-npm ca-certificates wget \
    openjdk8-jre font-adobe-100dpi ttf-dejavu fontconfig python python-dev git \
    && apk add /glibc-2.28-r0.apk \
    && rm -rf ./jenkins.war /etc/apk/repositories /glibc-2.28-r0.apk ./apache-maven-3.5.4-bin.zip ./gradle-3.5.1-bin.zip ./gradle-4.10.2-bin.zip \
    # && npm config set registry http://registry.npm.taobao.org/ \
    # && npm install cnpm -g --registry=https://registry.npm.taobao.org \
    # && cnpm install -g gulp webpack vue-cli \
    # && echo > echo > echo > ssh-keygen -t rsa -C "CI" \
    # && cp /root/.ssh/id_rsa -d /var/jenkins_home/ \
    # && cp /root/.ssh/id_rsa.pub -d /var/jenkins_home/ \
    && export GOPATH=/var/jenkins_home/go \
    && git clone https://github.com/golang/net.git /var/jenkins_home/go/src/golang.org/x/net \
    && git clone https://github.com/golang/text.git /var/jenkins_home/go/src/golang.org/x/text \
    && git clone https://github.com/golang/tools.git /var/jenkins_home/go/src/golang.org/x/tools \
    && git clone https://github.com/golang/sys.git /var/jenkins_home/go/src/golang.org/x/sys \
    && git clone https://github.com/golang/crypto.git /var/jenkins_home/go/src/golang.org/x/crypto \
    && git clone https://github.com/grpc/grpc-go.git /var/jenkins_home/go/src/google.golang.org/grpc \
    && go get -u github.com/golang/protobuf/protoc-gen-go \
    && go get -u github.com/golang/protobuf/proto \
    && git clone https://github.com/google/go-genproto.git /var/jenkins_home/go/src/google.golang.org/genproto \
    && cd /var/jenkins_home/go/src/ \
    && go install golang.org/x/text \
    && go install google.golang.org/grpc \
    && cp -r -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
WORKDIR /var/jenkins_home
ENV LANG zh_CN.UTF-8
ENV NODE_HOME /usr
ENV NODE_PATH /usr/lib/node_modules
ENV GOOS linux
ENV GOARCH amd64
ENV GIN_MODE release
ENV GOROOT /usr/bin
ENV GOPATH /var/jenkins_home/go
EXPOSE 8080

ENTRYPOINT ["tini", "--"]
CMD ["java","-jar","/var/jenkins_home/jenkins.war", "--httpPort=8080"]
#docker build -f jenkins/Dockerfile -t jenkins/alpine:v1 .
