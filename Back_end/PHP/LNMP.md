# LNMP

* 编译安装
  - 软件源代码包存放位置：/usr/local/src
  - 源码包编译安装位置：.configure 参数

## Nginx

* Ubuntu
  - Server Configuration:/etc/nginx
    + /etc/nginx: The Nginx configuration directory. All of the Nginx configuration files reside here.
    + /etc/nginx/nginx.conf: The main Nginx configuration file. This can be modified to make changes to the Nginx global configuration.
    + /etc/nginx/sites-available/: The directory where per-site "server blocks" can be stored. Nginx will not use the configuration files found in this directory unless they are linked to the sites-enabled directory (see below). Typically, all server block configuration is done in this directory, and then enabled by linking to the other directory.
    + /etc/nginx/sites-enabled/: The directory where enabled per-site "server blocks" are stored. Typically, these are created by linking to configuration files found in the sites-available directory.
    + /etc/nginx/snippets: This directory contains configuration fragments that can be included elsewhere in the Nginx configuration. Potentially repeatable configuration segments are good candidates for refactoring into snippets.
  - Content:/var/www/html
  - Server Logs
    + /var/log/nginx/access.log: Every request to your web server is recorded in this log file unless Nginx is configured to do otherwise.
    + /var/log/nginx/error.log: Any Nginx errors will be recorded in this log.

```sh
wget http://nginx.org/keys/nginx_signing.key
sudo apt-key add nginx_signing.key
// 或者
echo "deb http://nginx.org/packages/mainline/ubuntu/ trusty nginx" >> /etc/apt/sources.list  // Nginx1.9以上的版本可以在packages后添加/mainline，这是主线版本
echo "deb-src http://nginx.org/packages/mainline/ubuntu/ trusty nginx" >> /etc/apt/sources.listen

apt-get install python-software-properties
add-apt-repository ppa:nginx/stable

apt-get update
apt-get install nginx

sudo systemctl stop|start|restart|reload|disable|enable nginx.service

# 编译
groupadd www
useradd -g www www -s /bin/false
cd /usr/local/src
tar zxvf nginx-1.6.0.tar.gz
cd nginx-1.6.0
./configure --prefix=/usr/local/nginx --without-http_memcached_module --user=www --group=www --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module --with-openssl=/usr/local/src/openssl-1.0.1h --with-zlib=/usr/local/src/zlib-1.2.8 --with-pcre=/usr/local/src/pcre-8.35
# 注意：--with-openssl=/usr/local/src/openssl-1.0.1h --with-zlib=/usr/local/src/zlib-1.2.8 --with-pcre=/usr/local/src/pcre-8.35 # 指向的是源码包解压的路径，而不是安装的路径，否则会报错
make && make install

# (服务管理脚本)[../../Ops/nginx.service]
chmod 775 /etc/rc.d/init.d/nginx #赋予文件执行权限
##  /etc/init.d/nginx
#!/bin/bash
# chkconfig: - 30 21
# description: http service.
# Source Function Library
. /etc/init.d/functions
# Nginx Settings

NGINX_SBIN="/usr/local/nginx/sbin/nginx"
NGINX_CONF="/usr/local/nginx/conf/nginx.conf"
NGINX_PID="/usr/local/nginx/logs/nginx.pid"
RETVAL=0
prog="Nginx"

start() {
        echo -n $"Starting $prog: "
        mkdir -p /dev/shm/nginx_temp
        daemon $NGINX_SBIN -c $NGINX_CONF
        RETVAL=$?
        echo
        return $RETVAL
}

stop() {
        echo -n $"Stopping $prog: "
        killproc -p $NGINX_PID $NGINX_SBIN -TERM
        rm -rf /dev/shm/nginx_temp
        RETVAL=$?
        echo
        return $RETVAL
}

reload(){
        echo -n $"Reloading $prog: "
        killproc -p $NGINX_PID $NGINX_SBIN -HUP
        RETVAL=$?
        echo
        return $RETVAL
}

restart(){
        stop
        start
}

configtest(){
    $NGINX_SBIN -c $NGINX_CONF -t
    return 0
}

case "$1" in
  start)
        start
        ;;
  stop)
        stop
        ;;
  reload)
        reload
        ;;
  restart)
        restart
        ;;
  configtest)
        configtest
        ;;
  *)
        echo $"Usage: $0 {start|stop|reload|restart|configtest}"
        RETVAL=1
esac

exit $RETVAL

chkconfig nginx on #设置开机启动
sudo /sbin/chkconfig --list nginx
/etc/rc.d/init.d/nginx restart # 重启

/usr/local/nginx/sbin/nginx

#  /usr/local/nginx/conf/nginx.conf
user nobody nobody;
worker_processes 2;
error_log /usr/local/nginx/logs/nginx_error.log crit;
pid /usr/local/nginx/logs/nginx.pid;
worker_rlimit_nofile 51200;

events
{
    use epoll;
    worker_connections 6000;
}

http
{
    include mime.types;
    default_type application/octet-stream;
    server_names_hash_bucket_size 3526;
    server_names_hash_max_size 4096;
    log_format combined_realip '$remote_addr $http_x_forwarded_for [$time_local]'
    '$host "$request_uri" $status'
    '"$http_referer" "$http_user_agent"';
    sendfile on;
    tcp_nopush on;
    keepalive_timeout 30;
    client_header_timeout 3m;
    client_body_timeout 3m;
    send_timeout 3m;
    connection_pool_size 256;
    client_header_buffer_size 1k;
    large_client_header_buffers 8 4k;
    request_pool_size 4k;
    output_buffers 4 32k;
    postpone_output 1460;
    client_max_body_size 10m;
    client_body_buffer_size 256k;
    client_body_temp_path /usr/local/nginx/client_body_temp;
    proxy_temp_path /usr/local/nginx/proxy_temp;
    fastcgi_temp_path /usr/local/nginx/fastcgi_temp;
    fastcgi_intercept_errors on;
    tcp_nodelay on;
    gzip on;
    gzip_min_length 1k;
    gzip_buffers 4 8k;
    gzip_comp_level 5;
    gzip_http_version 1.1;
    gzip_types text/plain application/x-javascript text/css text/htm application/xml;

server
{
    listen 80;
    server_name localhost;
    index index.html index.htm index.php;
    root /usr/local/nginx/html;

    location ~ \.php$ {
        include fastcgi_params;
        fastcgi_pass unix:/tmp/php-fcgi.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME /usr/local/nginx/html$fastcgi_script_name;
    }

}

}

# /usr/local/nginx/conf/nginx.conf
user www www; # 首行user去掉注释,修改Nginx运行组为www www；必须与/usr/local/php/etc/php-fpm.conf中的user,group配置相同，否则php运行出错
index index.html index.htm index.php; # 添加index.php

# /usr/local/nginx/conf/servers/
# pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
location ~ \.php$ {
    root html;
    fastcgi_pass 127.0.0.1:9000;
    fastcgi_index index.php;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    include fastcgi_params;
}

# 取消FastCGI server部分location的注释,注意fastcgi_param行的参数,改为$document_root$fastcgi_script_name,或者使用绝对路径
/etc/init.d/nginx restart # 重启nginx
service php-fpm start # 启动php-fpm
```

## MySQL

```sh
sudo apt-get install mysql-server(mariadb-server mariadb-client)  mysql-client
sudo mysql_secure_installation

# There are three levels of password validation policy:
# LOW    Length >= 8
# MEDIUM Length >= 8, numeric, mixed case, and special characters
# STRONG Length >= 8, numeric, mixed case, special characters and dictionary

sudo service mysql status
sudo mysqladmin -p -u root version

# 编译
wget http://www.lishiming.net/data/at ... -icc-glibc23.tar.gz
tar zxvf mysql-5.1.40-linux-i686-icc-glibc23.tar.gz
mv mysql-5.1.40-linux-i686-icc-glibc23.tar.gz /usr/local/mysql
groupadd mysql #添加mysql组
useradd -g mysql mysql -s /bin/false #创建用户mysql并加入到mysql组，不允许mysql用户直接登录系统
useradd -s /sbin/nologin mysql   # -s /sbin/nologin 表示mysql账号不能登陆linux

mkdir -p /data/mysql #创建MySQL数据库存放目录
chown -R mysql:mysql /data/mysql #设置MySQL数据库存放目录权限
mkdir -p /usr/local/mysql #创建MySQL安装目录

cmake . -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DMYSQL_DATADIR=/data/mysql -DSYSCONFDIR=/etc # 配置
make && make install

rm -rf /etc/my.cnf #删除系统默认的配置文件（如果默认没有就不用删除）
cd /usr/local/mysql #进入MySQL安装目录
./scripts/mysql_install_db --user=mysql --basedir=/usr/local/mysql --datadir=/data/mysql #--user定义所属主，datadir 为数据库存放路径；这一步若出现两个OK就说明进行正确。
ln -s /usr/local/mysql/my.cnf  /etc/my.cnf # 添加到/etc目录的软连接
cp ./support-files/mysql.server  /etc/rc.d/init.d/mysqld #把Mysql加入系统启动
chmod 755 /etc/init.d/mysqld # 增加执行权限
# /etc/init.d/mysqld /etc/rc.d/init.d/mysqld 找到“datadir=”改过 
datadir=/data/mysql
basedir=/usr/local/mysql #MySQL程序安装路径
datadir=/data/mysql #MySQl数据库存放目录

chkconfig -add mysqld
chkconfig mysqld on # 加入开机启动

# /etc/profile
export PATH=$PATH:/usr/local/mysql/bin
source /etc/profil

service mysqld start # 启动

# 下面这两行把myslq的库文件链接到系统默认的位置，这样在编译类似PHP等软件时可以不用指定mysql的库文件地址
ln -s /usr/local/mysql/lib/mysql /usr/lib/mysql
ln -s /usr/local/mysql/include/mysql /usr/include/mysql
mkdir /var/lib/mysql # 创建目录
ln -s /tmp/mysql.sock /var/lib/mysql/mysql.sock #添加软链接
mysql_secure_installation #设置Mysql密码，根据提示按Y 回车输入2次密码
```

## PHP

* 把PHP请求都发送到同一个文件上，然后在此文件里通过解析「REQUEST_URI」实现路由
* Modules
  - curl
  - GD
  - pear
  - mcrypt
  - mbstring:php7.1-mbstring
  - intl
  - dom:php7.1-dom
* 启用 mcrypt `sudo phpenmod mcrypt`

```sh
sudo apt-get install python-software-properties software-properties-common

sudo add-apt-repository ppa:ondrej/php
sudo apt-get update

sudo apt-cache search php7.1*

sudo apt-get install php7.2 
php7.2-fpm  php7.2-mysql php7.2-common php7.2-curl php7.2-cli php7.2-mbstring php7.2-xml php7.2-bcmath php7.2-mcrypt php7.2-json php7.2-cgi php7.2-gd php-pear php7.2-intl php7.2-soap php7.2-xdebug php7.2-xsl php7.2-zip php7.2-xmlrpc php7.2-imagick php7.2-dev php7.2-imap php7.2-opcache -y

## 编译
wegt https://www.php.net/distributions/php-7.3.5.tar.gz
cd /usr/local/src
tar -zvxf php-7.3.5.tar.gz
cd php-7.3.5

sudo apt install gcc make openssl curl libbz2-dev libxml2-dev libjpeg-dev libpng-dev libfreetype6-dev pkg-config libzip-dev bison autoconf build-essential pkg-config git-core libltdl-dev libbz2-dev libxml2-dev libxslt1-dev libssl-dev libicu-dev libpspell-dev libenchant-dev libmcrypt-dev libpng-dev libjpeg8-dev libfreetype6-dev libmysqlclient-dev libreadline-dev libcurl4-openssl-dev librecode-dev libsqlite3-dev libonig-dev libicu-dev

# No package ‘oniguruma’ found
git clone https://github.com/kkos/oniguruma.git oniguruma
cd oniguruma
./autogen.sh
./configure
make
make install

./configure --prefix=/usr/local/php7 --enable-fpm --with-fpm-user=www-data --with-fpm-group=www-data --with-pdo-mysql --with-zlib --enable-xml --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --with-curl --enable-mbstring --with-openssl --enable-pcntl --enable-sockets --with-xmlrpc --enable-soap --without-pear --with-gettext --enable-intl --enable-maintainer-zts --enable-exif --enable-calendar --enable-opcache --enable-session --with-iconv --with-pdo-mysql=mysqlnd

export LD_LIBRARY_PATH=/usr/local/libgd/lib

make && make install

cp php.ini-production /usr/local/php/etc/php.ini  # 复制php配置文件
rm -rf /etc/php.ini  # 删除系统自带配置文件
ln -s /usr/local/php/etc/php.ini /etc/php.ini   #添加软链接到 /etc目录

cp /usr/local/php/etc/php-fpm.d/www.conf.default /usr/local/php/etc/php-fpm.d/www.conf
cp -R ./sapi/fpm/php-fpm /etc/init.d/php-fpm  || cp ./sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm # 启动脚本
cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf  # 拷贝模板文件为php-fpm配置文件
ln -s /usr/local/php/etc/php-fpm.conf  /etc/php-fpm.conf  #添加软连接到 /etc目录

# /usr/local/php/etc/php-fpm.conf  或者 /usr/local/php/etc/php-fpm.d/www.conf
user = www #设置php-fpm运行账号为www
group = www #设置php-fpm运行组为www
pid = run/php-fpm.pid #取消前面的分号

# 设置 php-fpm开机启动
chmod +x /etc/rc.d/init.d/php-fpm # 添加执行权限
chkconfig php-fpm on  #设置开机启动

## /usr/local/php/php.ini
# 如果文件不存在，则阻止 Nginx 将请求发送到后端的 PHP-FPM 模块， 以避免遭受恶意脚本注入的攻击
disable_functions = passthru,exec,system,chroot,scandir,chgrp,chown,shell_exec,proc_open,proc_get_status,ini_alter,ini_alter,ini_restore,dl,openlog,syslog,readlink,symlink,popepassthru,stream_socket_server,escapeshellcmd,dll,popen,disk_free_space,checkdnsrr,checkdnsrr,getservbyname,getservbyport,disk_total_space,posix_ctermid,posix_get_last_error,posix_getcwd, posix_getegid,posix_geteuid,posix_getgid, posix_getgrgid,posix_getgrnam,posix_getgroups,posix_getlogin,posix_getpgid,posix_getpgrp,posix_getpid, posix_getppid,posix_getpwnam,posix_getpwuid, posix_getrlimit, posix_getsid,posix_getuid,posix_isatty, posix_kill,posix_mkfifo,posix_setegid,posix_seteuid,posix_setgid, posix_setpgid,posix_setsid,posix_setuid,posix_strerror,posix_times,posix_ttyname,posix_uname
date.timezone = PRC #设置时区
expose_php = Off #禁止显示php版本的信息
short_open_tag = ON #支持php短标签
opcache.enable=1 #php支持opcode缓存
opcache.enable_cli=0
zend_extension=opcache.so #开启opcode缓存功能
cgi.fix_pathinfo=0

#  /usr/local/php/etc/php-fpm/conf
[global]
pid = /usr/local/php/var/run/php-fpm.pid
error_log = /usr/local/php/var/log/php-fpm.log
[www]
listen = /tmp/php-fcgi.sock
user = php-fpm
group = php-fpm
pm = dynamic
pm.max_children = 50
pm.start_servers = 20
pm.min_spare_servers = 5
pm.max_spare_servers = 35
pm.max_requests = 500
rlimit_files = 1024

useradd -s /sbin/nologin php-fpm
cp /usr/local/src/php-5.3.27/sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm
chmod 755 /etc/init.d/php-fpm
/usr/local/bin/php-fpm
chkconfig php-fpm on 
sudo service php7.1-fpm restart
```

### Configure Nginx to Use the PHP Processor

* 语法检测：`sudo nginx -t`
* 配置server
* 服务重启：`sudo nginx -s reload`
* 添加域名

```
# /etc/php/7.0/fpm/pool.d
# listen = [::]:9000
#fastcgi_pass 127.0.0.1:9000;
listen = unix:/run/php/php7.2-fpm.sock

# default
server {
  listen 80 default_server;
  listen [::]:80 default_server;

  root /var/www/html;
  index index.php index.html index.htm index.nginx-debian.html;

  server_name \_;

  location / {
      try_files $uri $uri/ =404;
  }

  location ~* \.php$ {
    fastcgi_index   index.php;
    # fastcgi_pass    127.0.0.1:9000;
    fastcgi_pass unix:/var/run/php-fpm.sock;

    include         fastcgi_params;
    fastcgi_param   SCRIPT_FILENAME    $document_root$fastcgi_script_name;
    fastcgi_param   SCRIPT_NAME        $fastcgi_script_name;
  }
}

# 自定义server
 server {
  listen   80;
  root /home/vagrant/www/example.local;
  index index.php index.html index.htm;
  server_name example.local;

  location / {
      try_files $uri $uri/ /index.php?$args;
  }

  location ~ \.php$ {
      try_files $uri =404;
      fastcgi_split_path_info ^(.+\.php)(/.+)$;
      fastcgi_pass unix:/var/run/php/php5.6-fpm.sock;
      fastcgi_index index.php;
      include fastcgi_params;
      fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
  }
}

## 前后端分离
server {
    listen      8082;
    server_name localhost;
    root        /Users/henry/Workspace/ShareFolder/Front/dist;
    index       index.html index.htm
    charset     utf-8;

    access_log      /usr/local/var/log/nginx/front-test.access.log;
    error_log       /usr/local/var/log/nginx/front-test.error.log;

    location / {
        try_files $uri $uri/ /index.html;
    }

    location ~ /api/ {
        proxy_pass  http://tp5.app.local:8080;
    }
}

sudo ln -s /etc/nginx/sites-available/example.com /etc/nginx/sites-enabled/
```

## 准备

```sh
# 基础
yum install -y apr* autoconf automake bison cloog-ppl compat* cpp curl curl-devel fontconfig fontconfig-devel freetype freetype* freetype-devel gcc gcc-c++ gtk+-devel gd gettext gettext-devel glibc kernel kernel-headers keyutils keyutils-libs-devel krb5-devel libcom_err-devel libpng* libjpeg* libsepol-devel libselinux-devel libstdc++-devel libtool* libgomp libxml2 libxml2-devel libXpm* libtiff libtiff* make mpfr ncurses* ntp openssl openssl-devel patch pcre-devel perl php-common php-gd policycoreutils telnet nasm nasm* wget zlib-devel

# 安装cmake
cd /usr/local/src
tar zxvf cmake-2.8.11.2.tar.gz
cd cmake-2.8.11.2
./configure
make && make install

# Nginx准备
# 安装pcre
cd /usr/local/src
mkdir /usr/local/pcre
tar zxvf pcre-8.35.tar.gz
cd pcre-8.35
./configure --prefix=/usr/local/pcre
make && make install

# 安装openssl
cd /usr/local/src
mkdir /usr/local/openssl
tar zxvf openssl-1.0.1h.tar.gz
cd openssl-1.0.1h
./config --prefix=/usr/local/openssl
make && make install

vi /etc/profile #把openssl服务加入系统环境变量：在最后添加下面这一行
export PATH=$PATH:/usr/local/openssl/bin
source /etc/profile #使配置立即生效

# 安装zlib
cd /usr/local/src
mkdir /usr/local/zlib
tar zxvf zlib-1.2.8.tar.gz
cd zlib-1.2.8
./configure --prefix=/usr/local/zlib
make && make install

# php 安装准备
# 安装yasm
cd /usr/local/src
tar zxvf yasm-1.2.0.tar.gz
cd yasm-1.2.0
./configure
make && make install

# 安装libmcrypt
cd /usr/local/src
tar zxvf libmcrypt-2.5.8.tar.gz
cd libmcrypt-2.5.8
./configure
make && make install

# 安装libvpx
cd /usr/local/src
tar xvf libvpx-v1.3.0.tar.bz2
cd libvpx-v1.3.0
./configure --prefix=/usr/local/libvpx --enable-shared --enable-vp9
make && make install

# 安装tiff
cd /usr/local/src
tar zxvf tiff-4.0.3.tar.gz
cd tiff-4.0.3
./configure --prefix=/usr/local/tiff --enable-shared
make && make install

# 安装libpng
cd /usr/local/src
tar zxvf libpng-1.6.12.tar.gz
cd libpng-1.6.12
./configure --prefix=/usr/local/libpng --enable-shared
make && make install

# 安装freetype
cd /usr/local/src
tar zxvf freetype-2.5.3.tar.gz
cd freetype-2.5.3
./configure --prefix=/usr/local/freetype --enable-shared
make && make install

# 安装jpeg
cd /usr/local/src
tar zxvf jpegsrc.v9a.tar.gz
cd jpeg-9a
./configure --prefix=/usr/local/jpeg --enable-shared
make && make install

# 安装libgd
cd /usr/local/src
tar zxvf libgd-2.1.0.tar.gz #解压
cd libgd-2.1.0 #进入目录
./configure --prefix=/usr/local/libgd --enable-shared --with-jpeg=/usr/local/jpeg --with-png=/usr/local/libpng --with-freetype=/usr/local/freetype --with-fontconfig=/usr/local/freetype --with-xpm=/usr/ --with-tiff=/usr/local/tiff --with-vpx=/usr/local/libvpx #配置
make && make install

# 安装t1lib
cd /usr/local/src
tar zxvf t1lib-5.1.2.tar.gz
cd t1lib-5.1.2
./configure --prefix=/usr/local/t1lib --enable-shared
make without_doc
make install

# 安装php
# 注意：如果系统是64位，请执行以下两条命令，否则安装php会出错（32位系统不需要执行）
ln -s /usr/lib64/libltdl.so /usr/lib/libltdl.so cp -frp /usr/lib64/libXpm.so* /usr/lib/
```

## Mac环境搭建

```sh
# 系统默认apache 与php5
httpd -v
php -v

# 停止httpd服务
sudo apachectl stop

# 卸载apache 与PHP56
sudo rm /usr/sbin/apachectl
sudo rm /usr/sbin/httpd
sudo rm -r /etc/apache2/  sudo rm -r /usr/bin/php

# 开启启动
$ cp /usr/local/opt/php71/homebrew.mxcl.php71.plist ~/Library/LaunchAgents/
$ launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.php70.plist

# 配置nginx
$ cp /usr/local/Cellar/nginx/1.10.2_1/homebrew.mxcl.nginx.plist ~/Library/LaunchAgents/
$ launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.nginx.plist

sudo chown root:wheel /usr/local/Cellar/nginx/1.10.2_1/bin/nginx
sudo chmod u+s /usr/local/Cellar/nginx/1.10.2_1/bin/nginx
sudo nginx -s reload/reopen/stop/quit

/usr/local/etc/nginx/nginx.conf
sudo brew services start nginx
curl -IL http://127.0.0.1:8080
sudo brew services stop nginx

mkdir -p /usr/local/etc/nginx/sites-available && \
mkdir -p /usr/local/etc/nginx/sites-enabled && \
mkdir -p /usr/local/etc/nginx/conf.d && \
mkdir -p /usr/local/etc/nginx/ssl

# mysql
brew install mysql

cd /usr/local/opt/mysql/
sudo vim my.cnf

./bin/mysql_install_db #初始化
mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql
/usr/local/bin/mysqladmin -u root password 'new-password' # 设置密码
/usr/local/bin/mysql_secure_installation  # 安全脚本
mysql -u root -p

# PHP配置
brew install php71 --with-imap --with-tidy --with-debug --with-pgsql --with-mysql --with-fpm

/usr/local/etc/php/7.1/php-fpm.conf

;pid = run/php-fpm.log
;error_log = log/php-fpm.log
修改为
pid = /usr/local/var/run/php-fpm.pid
error_log = /usr/local/var/log/php-fpm.log

# php配置
/usr/local/etc/php/7.1/php.ini  # 错误级别定义

/usr/local/etc/php/7.1/php-fpm.d/www.conf

brew services start php70
lsof -Pni4 | grep LISTEN | grep php

alias nginx.start='launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.nginx.plist'
alias nginx.stop='launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.nginx.plist'
alias nginx.restart='nginx.stop && nginx.start'
alias php-fpm.start="launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.php54.plist"
alias php-fpm.stop="launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.php54.plist"
alias php-fpm.restart='php-fpm.stop && php-fpm.start'
alias mysql.start="launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.mariadb.plist"
alias mysql.stop="launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.mariadb.plist"
alias mysql.restart='mysql.stop && mysql.start'

openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=US/ST=State/L=Town/O=Office/CN=localhost" -keyout /usr/local/etc/nginx/ssl/localhost.key -out /usr/local/etc/nginx/ssl/localhost.crt
openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=US/ST=State/L=Town/O=Office/CN=phpmyadmin" -keyout /usr/local/etc/nginx/ssl/phpmyadmin.key -out /usr/local/etc/nginx/ssl/phpmyadmin.crt
```

### 下载资源

* 下载nginx：http://nginx.org/download/nginx-1.6.0.tar.gz
* 下载MySQL：http://cdn.mysql.com/Downloads/MySQL-5.6/mysql-5.6.19.tar.gz
* 下载php：http://cn2.php.net/distributions/php-5.5.14.tar.gz
* 下载pcre （支持nginx伪静态）：ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.35.tar.gz
* 下载openssl（nginx扩展）：http://www.openssl.org/source/openssl-1.0.1h.tar.gz
* 下载zlib（nginx扩展）：http://zlib.net/zlib-1.2.8.tar.gz
* 下载cmake（MySQL编译工具）：http://www.cmake.org/files/v2.8/cmake-2.8.11.2.tar.gz
* 下载libmcrypt（php扩展）：http://nchc.dl.sourceforge.net/project/mcrypt/Libmcrypt/2.5.8/libmcrypt-2.5.8.tar.gz
* 下载yasm（php扩展）：http://www.tortall.net/projects/yasm/releases/yasm-1.2.0.tar.gz：
* t1lib（php扩展）：ftp://sunsite.unc.edu/pub/Linux/libs/graphics/t1lib-5.1.2.tar.gz：
* 下载gd库安装包：https://bitbucket.org/libgd/gd-libgd/downloads/libgd-2.1.0.tar.gz：
* libvpx（gd库需要）：https://webm.googlecode.com/files/libvpx-v1.3.0.tar.bz2：
* tiff（gd库需要）：http://download.osgeo.org/libtiff/tiff-4.0.3.tar.gz：
* libpng（gd库需要）：ftp://ftp.simplesystems.org/pub/png/src/libpng16/libpng-1.6.12.tar.gz：
* freetype（gd库需要）：http://ring.u-toyama.ac.jp/archives/graphics/freetype/freetype2/freetype-2.5.3.tar.gz：
* jpegsrc（gd库需要）：http://www.ijg.org/files/jpegsrc.v9a.tar.gz

## 参考

* [Mac OS X LEMP Configuration](https://gist.github.com/petemcw/9265670)
* [lj2007331/oneinstack](https://github.com/lj2007331/oneinstack):OneinStack - A PHP/JAVA Deployment Tool https://oneinstack.com/
* [cytopia/devilbox](https://github.com/cytopia/devilbox):A modern dockerized LAMP and MEAN stack alternative to XAMPP http://devilbox.org
* [lj2007331/lnmp](https://github.com/lj2007331/lnmp):LEMP stack/LAMP stack/LNMP stack installation scripts for CentOS/Redhat Debian and Ubuntu https://blog.linuxeye.cn/31.html
