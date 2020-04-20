# [Jenkins](https://jenkins.io/)

The leading open source automation server, Jenkins provides hundreds of plugins to support building, deploying and automating any project. 集成GitLab, Jenkins, Docker and Slack

* 把软件开发过程形成工作流
* 对项目进行进程守护：私自覆盖文件会进还原
* Master-Slave的架构，可以把任务发布到不同的节点上执行.要保证Master和Slave之间是内网通信的，否则公网环境延迟较大，经常会出现Slave掉线情况
    - 所有节点都需要把jenkins用户设置为sudo用户

## install

* war包自带Jetty服务器 `java -jar jenkins.war`访问<http://localhost:8080>，
* 将jenkins.war放到tomcat/webapps目录下，重启tomcat服务，<http://localhost:8080/jenkins>
* 安装包自动完成的工作包含
    - 设置Jenkins开机自启动，设置内容见/etc/init.d/Jenkins 文件
    - 创建了jenkins用户用来运行服务
    - 输出安装日志文件到  /var/log/jenkins/jenkins.log，检查日志文件可定位安装过程遇到的问题
    - 输出配置文件到/etc/default/Jenkins可修改相关配置
    - 设置Jenkins监听的端口为8081，通过浏览器可用该端口进行访问

```sh
# ubuntu
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install jenkins

ufw status
ufw allow 8081

sudo ufw allow OpenSSH
sudo ufw enable

# centos
yum install -y java git
# 添加Jenkins库到yum库，Jenkins将从这里下载安装。
wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
yum install -y jenkins

# 不能安装就到官网下载jenkis的rmp包，官网地址（http://pkg.jenkins-ci.org/redhat-stable/）
wget http://pkg.jenkins-ci.org/redhat-stable/jenkins-2.7.3-1.1.noarch.rpm
wget https://mirrors.tuna.tsinghua.edu.cn/jenkins/redhat/jenkins-2.173-1.1.noarch.rpm
rpm -ivh jenkins-2.7.3-1.1.noarch.rpm

sudo chkconfig jenkins on  # 允许开机启动

systemctl status|start|stop jenkins

# 访问ip：8081，进行安装以及配置用户
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

pip install fabric

## docker
docker pull jenkins/jenkins
docker run -d -p 49001:8080 -v $PWD/jenkins:/var/jenkins_home --name jenkins -t jenkins/jenkins
docker exec jenkins tail /var/jenkins_home/secrets/initialAdminPassword
```

## 配置

* 设置Slave:Manage jenkins->New Node
    - Labels是环境设置
    - 设置Master到Node间的授信方式：add Credentials

```
#  /etc/sysconfig/jenkins
JENKINS_PORT="8081"

ssh jenkins@host 'mkdir -p .ssh && cat >> .ssh/authorized_keys' < ~/.ssh/id_rsa.pub
```

## Pipeline(工作流)

* 运行行为由用户自己定义，定义的内容存放在一个Jenkinsfile文件中，并将该文件存放在git仓库的根目录，大致的流程如下
    - 用户将代码提交到git
    - Jenkins从git拉取最新代码
    - 读取根目录下的Jenkinsfile文件，并依次执行文件中定义的任务
* 概念
    - agent - 指定在哪台机器上执行任务，还记得上面配置Node时候填的Label吗，如果这两个label匹配得上，就在该Node中执行
    - stage - 组成工作流的大的步骤，这些步骤是串行的，例如build，test，deploy等
    - steps - 描述stage中的小步骤，同一个stage中的steps可以并行
    - sh - 执行shell命令
    - input - 需要你手动点击确定，Pipeline才会进入后续环节，常用于部署环节，因为很多时候部署都需要人为的进行一些确认
    - post - 所有pipeline执行完成后，会进入post环节，该环节一般做一些清理工作，同时还可以判断pipeline的执行状态
* 执行计划 scheme
    - 让Jenkins对git进行轮询，每分钟检查git仓库有没有更新
    - 使用git提供的hook，该方式原理是git一旦提交，便会触发hook中的脚本，让脚本给Jenkins发送执行pipeline的指令
* 需要设置git的地址，其中的授信设置，和上面说的Master到Node的授信设置一致
* 设置完毕后，一旦你的git仓库收到新的提交，就会触发这个pipeline的运行

```
pipeline {
    agent {
        label 'Production'
    }
    stages {
        stage('Build') {            
            steps {                
                echo 'Building'            
            }        
        }        
        stage('Test') {            
            steps {                
                echo 'Testing'            
            }        
        }
        stage('Deploy - Staging') {            
            steps {                
                sh './deploy staging'                
                sh './run-smoke-tests'            
            }        
        }        
        stage('Sanity check') {            
            steps {                
                input "Does the staging environment look ok?"            
            }        
        }        
        stage('Deploy - Production') {            
            steps {                
                sh './deploy production'            
            }        
        }    
    }

    post {        
        always {            
            echo 'One way or another, I have finished'            
            deleteDir() /* clean up our workspace */        
        }        
        success {            
            echo 'I succeeeded!'        
        }        
        unstable {            
            echo 'I am unstable :/'        
        }        
        failure {            
            echo 'I failed :('        
        }        
        changed {            
            echo 'Things were different before...'        
        }    
    }
}
```

## 参考

* [插件](https://plugins.jenkins.io/)
* [Jenkins文档](https://jenkins.io/zh/doc/)
* <https://www.centos.bz/2017/07/jenkins-ansible-docker-swarm/>
* https://www.digitalocean.com/community/tutorials/how-to-set-up-continuous-integration-pipelines-in-jenkins-on-ubuntu-16-04：构建出错，docker权限不足
