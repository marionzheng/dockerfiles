# Java项目发布用基础镜像

### 先把 jdk-8u291-linux-x64.tar.gz 拷贝到tools目录下

### 构建镜像
> docker build -t registry.cn-shenzhen.aliyuncs.com/szcttech/centos7-java8:291 .

### 构建上传
> docker push registry.cn-shenzhen.aliyuncs.com/szcttech/centos7-java8:291
