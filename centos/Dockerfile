FROM centos:8.1.1911
MAINTAINER marion "marion@aionnect.com"

ADD https://github.com/krallin/tini/releases/download/v0.18.0/tini /sbin/tini
RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm \
    && yum update -y \
    && yum -y install tcpdump strace tree \
    && chmod +x /sbin/tini \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
ENV LANG zh_CN.UTF-8
ENV PATH $PATH:/sbin

CMD ["systemctl", "start", "nscd;", "bash"]
