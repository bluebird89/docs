# [gogs](https://github.com/gogs/gogs)

Gogs is a painless self-hosted Git service. https://gogs.io

## 搭建服务

- Golang 安装配置
- git安装配置
- mysql安装配置
- nginx安装配置
- gogs安装配置
- gogs配置运维
- 安装 supervisor

```shell
sudo adduser git
su git             #以git用户登录
mkdir ~/.ssh       #建立.ssh目录

sudo apt-get -y install mysql-server
create user 'gogs'@'localhost' identified by '密码';
grant all privileges on gogs.* to 'gogs'@'localhost';
flush privileges;
exit;
CREATE DATABASE IF NOT EXISTS gogs CHARACTER SET utf8 COLLATE utf8_general_ci;

wget https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz  # 获取文件：
tar zxf go1.8.3.linux-amd64.tar.gz
sudo mv go $GOROOT   # 可以测试  go

vi ~/.bashrc  # 添加指令
export GOPATH=/home/git/go    echo export GOROOT=/var/opt/go >> .bashrc
export GOROOT=/usr/local/src/go
export PATH=${PATH}:$GOROOT/bin

echo 'export GOROOT=$HOME/local/go' >> $HOME/.bashrc
echo 'export GOPATH=$HOME/go' >> $HOME/.bashrc
echo 'export PATH=$PATH:$GOROOT/bin:$GOPATH/bin' >> $HOME/.bashrc
source ~/.bashrc # 指令生效

go get -d github.com/gogits/gogs

cd $GOPATH/src/github.com/goggits/gogs
go build

mysql -u root -p < scripts/mysql.sql

custom/conf/app.ini # INI格式的文本文件，关键配置如下。 详细的配置解释和默认值请参考配置文件手册
# RUN_USER默认为git，指定Gogs以哪个用户运行
# ROOT 所有仓库的存储根路径
# PROTOCOL用nginx反代的话使用http
# DOMAIN域名，会影响SSH clone地址
# ROOT_URL完整的根路径，会影响页面上链接指向，以及HTTP(s) clone的地址
# HTTP_ADDR监听地址，使用nginx建议127.0.0.1，否则localhost或0.0.0.0也可以
# HTTP_PORT监听端口，默认3000
# INSTALL_LOCK锁定安装页面
# Mailer相关的选项注意邮箱stmp地址要加端口号
./gogs web

sudo cp ~/gogs/scripts/gogs /etc/init.d/
sudo chmod +x /etc/init.d/gogs
sudo service gogs {start|stop|status|restart} # 对Gogs服务进行管理

sudo chkonfig gogs on|off # 添加开机启动

sudo mkdir -p /var/log/gogs

server {
    listen 80;
    server_name local.gogs.test;
    proxy_set_header X-Real-IP  $remote_addr; # pass on real client IP
    location / {
        proxy_pass http://local.gogs.test:3000;
    }
}

sudo service nginx restart|reload
```

### 配置

* 配置supervisor
* 配置服务器

```
sudo vi /etc/supervisor/supervisor.conf

[program:gogs]
directory=/home/git/go/src/github.com/gogits/gogs/
command=/home/git/go/src/github.com/gogits/gogs/gogs web
autostart=true
autorestart=true
startsecs=10
stdout_logfile=/var/log/gogs/stdout.log
stdout_logfile_maxbytes=1MB
stdout_logfile_backups=10
stdout_capture_maxbytes=1MB
stderr_logfile=/var/log/gogs/stderr.log
stderr_logfile_maxbytes=1MB
stderr_logfile_backups=10
stderr_capture_maxbytes=1MB
environment = HOME="/home/git", USER="git"
user = git

service supervisor restart
```

### 测试

- 初始化 <http://local.gogs.test/install> 配置数据库与ip地址

```sh
echo 'I love Gogs!' >> README.md
git add --all && git commit -m "init commit" && git push origin master
```
