- 创建用户

  ```
    sudo adduser git
  ```

- 创建数据库：

  ```
    sudo apt-get update
    sudo apt-get -y install mysql-server
    CREATE DATABASE IF NOT EXISTS gogs CHARACTER SET utf8 COLLATE utf8_general_ci;
  ```

- 安装GO：

  ```
    vi ~/.bashrc  添加指令
    export GOPATH=/home/git/go    echo export GOROOT=/var/opt/go >> .bashrc
    export GOROOT=/usr/local/src/go
    export PATH=${PATH}:$GOROOT/bin

    echo 'export GOROOT=$HOME/local/go' >> $HOME/.bashrc
    echo 'export GOPATH=$HOME/go' >> $HOME/.bashrc
    echo 'export PATH=$PATH:$GOROOT/bin:$GOPATH/bin' >> $HOME/.bashrc
    source $HOME/.bashrc

    指令生效:source ~/.bashrc
    获取文件：wget https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz
    tar zxf go1.8.3.linux-amd64.tar.gz
    sudo mv go $GOROOT   可以测试  go
    go get -d github.com/gogits/gogs
    cd $GOPATH/src/github.com/goggits/gogs
    go build
  ```

- 安装 supervisor

  ```
        sudo mkdir -p /var/log/gogs
  ```

- 配置

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
  ```

  service supervisor restart

- 服务器配置 server {

  ```
    listen 80;
    server_name local.gogs.test;

    proxy_set_header X-Real-IP  $remote_addr; # pass on real client IP

    location / {
        proxy_pass http://local.gogs.test:3000;
    }
  ```

  }

  修改本地域名 sudo service nginx restart

- 初始化 <http://local.gogs.test/install> 配置数据库与ip地址

  ```
    echo 'I love Gogs!' >> README.md
    git add --all && git commit -m "init commit" && git push origin master
  ```

- 说明 代码提交通过