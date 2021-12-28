// Jenkinsfile示例，注意，仅为示例
// 实际每个项目中放置Jenkinsfile，每个项目根据自身情况配置
// DevOps发布流水线：
// 1. 在Jenkins中新建多分支流水线，如："科技驾培/micro-user"
// 2. 在git服务器需要发布的项目上配置对应的Webhooks钩子，如："http://8.135.115.160:8040/project/%E7%A7%91%E6%8A%80%E9%A9%BE%E5%9F%B9/micro-user"
//    其中hostname是jenkins服务地址，project是固定路径，project之后的路况即项目路径的urlEncode
// 3. 项目push触发钩子 -> 钩子调用Jenkins多分支流水线启动新Job -> Job中从git获取当前触发分支最新代码
// 4. 根据各个项目中的Jenkinsfile脚本中的步骤具体进行构建、打包、部署、测试
// 参考下面的示例，再次重申 -- 本文件仅为示例
pipeline {
    options {
        buildDiscarder(logRotator(numToKeepStr: "7", artifactNumToKeepStr: "10", daysToKeepStr: "5"))
        timeout(time: 12, unit: "MINUTES")
        disableConcurrentBuilds()
    }

    agent {
        label "master"
    }

    // Jenkinsfile环境变量配置
    environment {
        // ---- 手动设置变量
        SERVICE_NAME = ""               // 微服务名
        PROGRAMMING_LANGUAGE = "go"     // 微服务语言
        HTTP_PORT=9999                  // HTTP端口
        GRPC_PORT=59999                 // GRPC端口

        // ---- 固定不变变量
        // 在CI部署服务器（jenkins宿主机）上的jenkins_home目录
        JENKINS_HOME_ON_HOST = "/docker_data/jenkins"
        // 当前发布项目的jenkins workspace目录，/var/jenkins_home是docker jenkins中的jenkins_home目录
        WORKSPACE_ON_HOST = env.WORKSPACE.replace("/var/jenkins_home", env.JENKINS_HOME_ON_HOST)
        // 在CI部署服务器kubectl config中配置的K8S Context连接前缀，约定好context名字配置为：此前缀+发布环境名（=K8S namespace 且在下面的pre-build处理中对应git上分支名）
        K8S_CONTEXT_PREFIX = "tech-"
        // Docker镜像服务器地址和镜像名称
        REGISTRY_HOST = "harbor-internal.aicar365.com:8443"
        IMAGE_NAME = "${env.REGISTRY_HOST}/szcttech/${env.SERVICE_NAME}"
        // common-ci-process项目作为DevOps模版项目，也在Jenkins中配置了对应多分支流水线，但项目中没有放置Jenkinsfile
        // 故提交common-ci-process项目变更时，会触发多分支流水线把最新DevOps模版获取到Jenkins服务器上
        // 当其它项目发布流程中需要用到DevOps模版时，即可访问CI_PATH获取需要使用到的部分，此示例只用到整个DevOps模版中的go子目录中的内容
        CI_PATH = "/var/jenkins_home/workspace/common-ci-procress/go"
    }

    // 发布流水线步骤
    stages {
        // 发布前准备
        stage("pre-build") {
            steps {
                script {
                    // 将CI_PATH复制当前目录以便引用
                    sh "cp -a ${env.CI_PATH}/* ."
                    // 给一些非固定发布变量赋值，包括识别发布环境
                    load "Jenkinsfile_dem/pre-build.jenkinsfile"
                }
            }
        }

        // 项目编译构建
        stage("build") {
            steps {
                script {
                    echo "-------------------------------------开始构建------------------------------------------------"
                    // 通过Jenkins调用宿主机docker，docker启动一个该语言构建专用镜像进行项目构建
                    // 该语言依赖缓存目录挂载宿主机目录，以免每次构建都重新下载依赖包
                    // 当前workspace目录也挂载进去，以便访问CI构建脚本，以及输出构建结果
                    load "Jenkinsfile_dem/build.jenkinsfile"
                }
            }
        }

        // Docker打包
        stage("package") {
            steps {
                script {
                    echo "-------------------------------------开始打包------------------------------------------------"

                    sh "chmod +x ./pack.sh && ./pack.sh"
                }
            }
        }

        // 发布
        stage("deploy") {
            steps {
                script {
                    echo "-------------------------------------开始发布------------------------------------------------"
                    
                    sh "chmod +x ./deploy.sh && ./deploy.sh"
                }
            }
        }

        // 代码扫描
        stage("sonar-scan") {
            steps {
                script {
                   load "Jenkinsfile_dem/sonar-scan.jenkinsfile"
                }
            }
        }
    }
}