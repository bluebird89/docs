## [apache/tomcat](https://github.com/apache/tomcat)

## 安装

```sh
sudo apt-get install tomcat8
sudo vim /etc/default/tomcat8
JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom -Djava.awt.headless=true -Xmx512m -XX:MaxPermSize=256m -XX:+UseConcMarkSweepGC" // 修改内存使用
sudo service tomcat8 restart

# 访问 http://localhost:8080
sudo apt-get install tomcat8-docs tomcat8-admin tomcat8-examples
sudo vim /etc/tomcat7/tomcat-users.xml # 配置管理后台

<tomcat-users>
  <user username="admin" password="password" roles="manager-gui,admin-gui"/>
</tomcat-users>
sudo service tomcat8 restart
# 访问 http://localhost:8080/docs/
# 访问 http://localhost:8080/examples/
Virtual Host Manager http://localhost:8080/manager/html/

# /etc/systemd/system/tomcat.service
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
sudo systemctl start tomcat
```

- /usr/share/tomcat8/：安装程序路径
- /var/lib/tomcat8/：应用程序、配置与日志
- /etc/tomcat8/：服务器配置server.xml 用户配置：tomcat-users.xml
- 命令行脚本：sudo /etc/init.d/tomcat8 start
- Tomcat 配置文件路径:Tomcat home directory : /usr/share/tomcat8 Tomcat base directory : /var/lib/tomcat8或/etc/tomcat8
- Tomcat的用户帐号信息都保存在 /var/lib/tomcat6/conf/tomcat-users.xml 的文件中
- 默认根目录：/usr/share/tomcat8-root
