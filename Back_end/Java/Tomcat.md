## [apache/tomcat](https://github.com/apache/tomcat)

an open source implementation of the Java Servlet, JavaServer Pages, Java Expression Language and Java WebSocket technologies. http://tomcat.apache.org/

## 安装

* 配置
    - CATALINA_HOME:/usr/share/tomcat8
        + 默认根目录：/usr/share/tomcat8-root/default_root
        + Manager app:/usr/share/tomcat8-admin/manager/META-INF/context.xml
        + Host Manager app:/usr/share/tomcat8-admin/host-manager/META-INF/context.xml
    - CATALINA_BASE:/var/lib/tomcat8, 应用程序、配置与日志
        + 用户帐号信息都保存在 /var/lib/tomcat8/conf/tomcat-users.xml 的文件中
    - /etc/tomcat8/
        - 服务器配置server.xml
        - 用户配置：tomcat-users.xml

```sh
sudo add-apt-repository ppa:linuxuprising/java
sudo apt update
sudo apt install oracle-java10-installer
sudo apt install oracle-java10-set-default

sudo apt-get update
sudo apt-get install default-jdk

sudo groupadd tomcat
sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat   # a home directory of /opt/tomcat (where we will install Tomcat)  with a shell of /bin/false (so nobody can log into the account)
sudo useradd -M -s /bin/nologin -g tomcat -d /opt/tomcat tomcat

## 下载安装
cd /tmp  #  存放临时文件
curl -O http://apache.mirrors.ionfish.org/tomcat/tomcat-8/v8.5.5/bin/apache-tomcat-8.5.5.tar.gz
sudo mkdir /opt/tomcat
sudo tar xzvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1
sudo chgrp -R tomcat /opt/tomcat
sudo chmod -R g+r conf
sudo chmod g+x conf
sudo chown -R tomcat webapps/ work/ temp/ logs/

# ubuntu
sudo apt-get install tomcat8 tomcat8-docs tomcat8-admin tomcat8-examples
# centos
sudo yum install tomcat

sudo vim /etc/default/tomcat8
JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom -Djava.awt.headless=true -Xmx512m -XX:MaxPermSize=256m -XX:+UseConcMarkSweepGC" // 修改内存使用

sudo vim /etc/tomcat7/tomcat-users.xml # 配置管理后台

<tomcat-users>
  <user username="admin" password="password" roles="manager-gui,admin-gui"/>
</tomcat-users>

sudo service tomcat8 restart

# 访问 http://localhost:8080 http://localhost:8080/docs/ http://localhost:8080/examples/ http://localhost:8080/manager/html/

# create /etc/systemd/system/tomcat.service
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking

Environment=JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64/jre
Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat
Environment='CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'
Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

User=tomcat
Group=tomcat
UMask=0007
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target

sudo systemctl daemon-reload
sudo systemctl start|enable tomcat
sudo /etc/init.d/tomcat8 start
sudo ufw allow 8080/tcp
```

## Catalina

## 参考

* [Tomcat 内核设计剖析](link)
