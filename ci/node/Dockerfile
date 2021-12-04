FROM node:lts-alpine3.10

ENV LANG zh_CN.UTF-8 \
    LC_ALL=en_US.UTF-8

RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.13/main/" > /etc/apk/repositories \
    && echo -ne "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.13/community/" >> /etc/apk/repositories \
    && apk --update --no-cache add git curl bash tree tzdata wget vim \
#    && npm install -g npm@7.11.1 \
    && cp -r -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && git config --global credential.helper store

WORKDIR /workspace

CMD ["bash"]