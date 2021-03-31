### 镜像生成命令

其中 ":1.15.6" 和 "git.aionnect.com" 是可改动的参数

>  docker build -t ccr.ccs.tencentyun.com/aionnect/golang:1.15.6 --build-arg tag=:1.15.6 --build-arg goprivate=git.aionnect.com .