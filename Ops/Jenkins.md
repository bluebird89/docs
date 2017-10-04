# Jenkins

The leading open source automation server, Jenkins provides hundreds of plugins to support building, deploying and automating any project. 集成GitLab, Jenkins, Docker and Slack

## install

war包自带Jetty服务器 `java -jar jenkins.war`访问<http://localhost:8080>，

将jenkins.war放到tomcat/webapps目录下，重启tomcat服务，<http://localhost:8080/jenkins>

### ubuntu安装

```
# wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
# sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
# sudo apt-get update
# sudo apt-get install jenkins
访问ip：8080，进行安装以及配置用户
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

### 在线安装路径

## usage

<https://www.centos.bz/2017/07/jenkins-ansible-docker-swarm/>
