FROM jenkins/jenkins

ENV LANG zh_CN.UTF-8 \
    LC_ALL=en_US.UTF-8

USER root
RUN echo 'deb http://mirrors.ustc.edu.cn/debian stable main contrib non-free' > /etc/apt/sources.list \
    && echo '# deb-src http://mirrors.ustc.edu.cn/debian stable main contrib non-free' >> /etc/apt/sources.list \
    && echo 'deb http://mirrors.ustc.edu.cn/debian stable-updates main contrib non-free' >> /etc/apt/sources.list \
    && echo '# deb-src http://mirrors.ustc.edu.cn/debian stable-updates main contrib non-free' >> /etc/apt/sources.list \
    && echo '# deb http://mirrors.ustc.edu.cn/debian stable-proposed-updates main contrib non-free' >> /etc/apt/sources.list \
    && echo '# deb-src http://mirrors.ustc.edu.cn/debian stable-proposed-updates main contrib non-free' >> /etc/apt/sources.list \
    && apt-get update && apt-get install -y libltdl7 apt-transport-https ca-certificates curl \
    && curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && chmod 777 ./kubectl && mv ./kubectl /usr/local/bin/kubectl
USER jenkins
# 使用完root特权后立即关闭，即使运行jenkins（Docker in Docker）容器挂载宿主机docker需要特权，也应在运行时申请

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/usr/local/bin/jenkins.sh"]