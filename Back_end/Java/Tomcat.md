## [apache/tomcat](https://github.com/apache/tomcat)

an open source implementation of the Java Servlet, JavaServer Pages, Java Expression Language and Java WebSocket technologies. http://tomcat.apache.org/

## 安装

* 配置
    - CATALINA_HOME:/usr/share/tomcat8
        + 默认根目录：/usr/share/tomcat8-root/default_root
        + Manager app:/usr/share/tomcat8-admin/manager/META-INF/context.xml
        + Host Manager app:/usr/share/tomcat8-admin/host-manager/META-INF/context.xml
        + `http://localhost:8080`
        + `http://localhost:8080/docs/` 
        + `http://localhost:8080/examples/` 
        + Manager App:`http://localhost:8080/manager/html/`
        + Host Manager:`http://server_domain_or_IP:8080/host-manager/html/`
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
curl -O https://www-eu.apache.org/dist/tomcat/tomcat-9/v9.0.30/bin/apache-tomcat-9.0.30.tar.gz
sudo mkdir /opt/tomcat
sudo tar xzvf apache-tomcat-9*tar.gz -C /opt/tomcat --strip-components=1
sudo chgrp -R tomcat /opt/tomcat
sudo chmod -R g+r conf
sudo chmod g+x conf
sudo chown -R tomcat webapps/ work/ temp/ logs/

# ubuntu
sudo apt-get install tomcat8 tomcat8-docs tomcat8-admin tomcat8-examples
# centos
sudo yum install tomcat

sudo update-java-alternatives -l #  find JAVA_HOME location

# /etc/systemd/system/tomcat.service
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking

Environment=JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64
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
sudo systemctl start|enable|status tomcat
sudo /etc/init.d/tomcat8 start
sudo ufw allow 8080/tcp

# /etc/default/tomcat8
JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom -Djava.awt.headless=true -Xmx512m -XX:MaxPermSize=256m -XX:+UseConcMarkSweepGC" // 修改内存使用

sudo vim /etc/tomcat7/tomcat-users.xml # 配置管理后台

<tomcat-users>
  <user username="admin" password="password" roles="manager-gui,admin-gui"/>
</tomcat-users>

sudo service tomcat8 restart

# /opt/tomcat/conf/tomcat-users.xml
<tomcat-users . . .>
    <user username="admin" password="password" roles="manager-gui,admin-gui"/>
</tomcat-users>

# /opt/tomcat/webapps/manager/META-INF/context.xml
<Context antiResourceLocking="false" privileged="true" >
  <!--<Valve className="org.apache.catalina.valves.RemoteAddrValve"
         allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" />-->
</Context>
```

## Catalina

## 参考

* [Tomcat 内核设计剖析](link)
