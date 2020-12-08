## [tomcat](https://github.com/apache/tomcat)

an open source implementation of the Java Servlet, JavaServer Pages, Java Expression Language and Java WebSocket technologies. <http://tomcat.apache.org/>

## 安装

* 配置
  - CATALINA_HOME:/usr/share/tomcat8
    + 默认根目录：/usr/share/tomcat8-root/default_root
* `http://localhost:8080`
* `http://localhost:8080/docs/`
* `http://localhost:8080/examples/`
* Web Manager App:`http://localhost:8080/manager/html/` `/usr/share/tomcat8-admin/manager/META-INF/context.xml`
* Host Manager:`http://server_domain_or_IP:8080/host-manager/html/` `/usr/share/tomcat8-admin/host-manager/META-INF/context.xml`
* CATALINA_BASE:/var/lib/tomcat8, 应用程序、配置与日志
  - 用户帐号信息都保存在 /var/lib/tomcat8/conf/tomcat-users.xml 的文件中
  * 服务器配置server.xml
  * 用户配置：tomcat-users.xml

```sh
sudo add-apt-repository ppa:linuxuprising/java
sudo apt update
sudo apt install oracle-java10-installer
sudo apt install oracle-java10-set-default
sudo apt-get install default-jdk| openjdk-11-jdk
sudo update-java-alternatives -l #  find JAVA_HOME location

sudo groupadd tomcat
sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat   # a home directory of /opt/tomcat (where we will install Tomcat)  with a shell of /bin/false (so nobody can log into the account)
sudo useradd -M -s /bin/nologin -g tomcat -d /opt/tomcat tomcat
sudo useradd -m -U -d /opt/tomcat -s /bin/false tomcat

## 下载安装
curl -O https://www-eu.apache.org/dist/tomcat/tomcat-9/v9.0.30/bin/apache-tomcat-9.0.30.tar.gz
sudo mkdir /opt/tomcat
sudo tar xzvf apache-tomcat-9*tar.gz -C /opt/tomcat --strip-components=1
sudo ln -s /opt/tomcat/apache-tomcat-${VERSION} /opt/tomcat/latest
sudo chgrp -R tomcat /opt/tomcat
sudo sh -c 'chmod +x /opt/tomcat/latest/bin/*.sh'

# ubuntu
sudo apt-get install tomcat8 tomcat8-docs tomcat8-admin tomcat8-examples
# centos
sudo yum install tomcat

# /etc/systemd/system/tomcat.service
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking

User=tomcat
Group=tomcat
UMask=0007

Environment="JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64"
Environment="JAVA_OPTS=-Djava.security.egd=file:///dev/urandom -Djava.awt.headless=true"

Environment="CATALINA_BASE=/opt/tomcat/latest"
Environment="CATALINA_HOME=/opt/tomcat/latest"
Environment="CATALINA_PID=/opt/tomcat/latest/temp/tomcat.pid"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"

ExecStart=/opt/tomcat/latest/bin/startup.sh
ExecStop=/opt/tomcat/latest/bin/shutdown.sh

# RestartSec=10
# Restart=always

[Install]
WantedBy=multi-user.target

sudo systemctl daemon-reload
sudo systemctl start|enable|status tomcat
sudo /etc/init.d/tomcat8 start
sudo ufw allow 8080/tcp

# /etc/default/tomcat8  修改内存使用
JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom -Djava.awt.headless=true -Xmx512m -XX:MaxPermSize=256m -XX:+UseConcMarkSweepGC"

# 配置管理后台 /opt/tomcat/conf/tomcat-users.xml
<tomcat-users . . .>
    <user username="admin" password="password" roles="manager-gui,admin-gui"/>
</tomcat-users>

# /opt/tomcat/webapps/manager/META-INF/context.xml
<Context antiResourceLocking="false" privileged="true" >
  <!--<Valve className="org.apache.catalina.valves.RemoteAddrValve"
         allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" />-->
</Context>

# Host Manager app: /opt/tomcat/latest/webapps/host-manager/META-INF/context.xml  public IP is 41.41.41.41 and you want to allow access only from that IP
<Context antiResourceLocking="false" privileged="true" >
 <Valve className="org.apache.catalina.valves.RemoteAddrValve"
         allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1|41.41.41.41" />
</Context>
```

## Catalina

## 图书

* Tomcat架构解析

## 参考

* [Tomcat 内核设计剖析](link)
* [Tomcat学习四步走：内核、集群、参数及性能](https://mp.weixin.qq.com/s?__biz=MzI4NTA1MDEwNg==&mid=2650765045&idx=1&sn=344349247fab0e45a0d319e6917a307e&chksm=f3f9c360c48e4a763a6e21c9ec07b1fa839e997661c851f6d72ec6560f3d872fb6065c15f2cb)
