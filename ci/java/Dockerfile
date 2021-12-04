FROM registry.cn-shenzhen.aliyuncs.com/szcttech/centos7-java8:291

ADD maven_settings.xml ./

RUN mkdir -p /m2/repository /gradle/repository \
    && wget https://mirrors.bfsu.edu.cn/apache/maven/maven-3/3.8.1/binaries/apache-maven-3.8.1-bin.zip \
    && wget https://services.gradle.org/distributions/gradle-7.0-bin.zip \
    && unzip apache-maven-3.8.1-bin.zip -d /usr/local/ \
    && unzip gradle-7.0-bin.zip -d /usr/local/ \
    && mv -f ./maven_settings.xml /usr/local/apache-maven-3.8.1/conf/settings.xml \
    && yum install git -y \
    && yum clean all

ENV LANG zh_CN.UTF-8 \
    LC_ALL=en_US.UTF-8
ENV MAVEN_HOME=/usr/local/apache-maven-3.8.1
ENV GRADLE_HOME=/usr/local/gradle-7.0
ENV PATH=$PATH:$MAVEN_HOME/bin:$GRADLE_HOME/bin
ENV GRADLE_USER_HOME=/gradle/repository

WORKDIR /workspace

CMD ["bash"]