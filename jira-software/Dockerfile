FROM alpine
MAINTAINER Marion "trboyspace@126.com"

WORKDIR /
RUN mkdir -p /opt/atlassian/ /var/atlassian/application-data/jira/ /etc/apk/keys/ /usr/local/
ADD ./jira-software/server-jre-8u181-linux-x64.tar.gz /usr/local
COPY ./jira-software/sgerrand.rsa.pub /etc/apk/keys/
COPY ./jira-software/glibc-2.28-r0.apk .
RUN wget https://product-downloads.atlassian.com/software/jira/downloads/atlassian-jira-software-7.12.1.tar.gz \
    && tar -xzf ./atlassian-jira-software-7.12.1.tar.gz -C /opt/atlassian/ \
    && mv /opt/atlassian/atlassian-jira-software-7.12.1-standalone/ /opt/atlassian/jira \
    && rm -rf ./atlassian-jira-software-7.12.1.tar.gz \
    && chmod -R u=rwx,go-rwx /opt/atlassian/jira/ \
    && chmod -R u=rwx,go-rwx /var/atlassian/application-data/jira/ \
    && sed -i "s#^jira.home.*#jira.home=/var/atlassian/application-data/jira/#g" /opt/atlassian/jira/atlassian-jira/WEB-INF/classes/jira-application.properties \
    && echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.8/main/" > /etc/apk/repositories \
    && echo -ne "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.8/community/" >> /etc/apk/repositories \
    && apk --update add bash tzdata \
    && apk --no-cache add ca-certificates tini \
    && apk add glibc-2.28-r0.apk \
    && cp -rf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
COPY ./jira-software/mysql-connector-java-5.1.46.jar /opt/atlassian/jira/lib/
WORKDIR /opt/atlassian/jira/bin/
ENV LANG C.UTF-8
ENV JAVA_HOME /usr/local/jdk1.8.0_181
ENV JIRA_HOME /var/atlassian/application-data/jira/
ENV JVM_MINIMUM_MEMORY 1024m
ENV JVM_MAXIMUM_MEMORY 1024m
EXPOSE 8080
EXPOSE 8005

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/opt/atlassian/jira/bin/start-jira.sh", "-fg"]