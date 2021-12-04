# 适配Docker in Docker处理的Jenkins镜像

### 构建镜像

> docker build -t registry.cn-shenzhen.aliyuncs.com/szcttech/jenkins .

### 测试

可执行一下命令测试，进入临时容器后可执行 docker，如 docker ps -a

```shell
docker run -it --rm -u root --privileged=true \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /usr/bin/docker:/usr/bin/docker \
-v /root/.kube:/root/.kube \
registry.cn-shenzhen.aliyuncs.com/szcttech/jenkins bash
```

### 构建上传
> docker push registry.cn-shenzhen.aliyuncs.com/szcttech/jenkins

### 修改显示时区

Manage Jenkins -> Script Console，执行以下内容：

```shell
System.setProperty('org.apache.commons.jelly.tags.fmt.timeZone', 'Asia/Shanghai')
```

https://www.jenkins.io/doc/book/managing/change-system-timezone/

### 解决测试报告样式问题

Manage Jenkins -> Script Console，执行以下内容：

```shell
System.setProperty("hudson.model.DirectoryBrowserSupport.CSP", "script-src 'unsafe-inline'")
```

https://www.jenkins.io/doc/book/security/configuring-content-security-policy/#html-publisher-plugin