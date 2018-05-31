# Centos


## 配置

```sh
yum install vim
yum install git
yum provides ifconfig
yum install net-tools
sudo yum install epel-release # add the CentOS 7 EPEL repository
```

## 软件源管理

```sh
# 配置本地yum源
cd /etc/yum.repos.d/   #进入yum配置目录
touch  rhel-media.repo   #建立yum配置文件
vi  rhel-media.repo   #编辑配置文件，添加以下内容

[rhel-media]
name=Red Hat Enterprise Linux 7.0   #自定义名称
baseurl=file:///media/cdrom #本地光盘挂载路径
enabled=1   #启用yum源，0为不启用，1为启用
gpgcheck=1  #检查GPG-KEY，0为不检查，1为检查
gpgkey=file:///media/cdrom/RPM-GPG-KEY-redhat-release   #GPG-KEY路径

yum clean all   #清除yum缓存
yum makecache  #缓存本地yum源中的软件包信息

yum install httpd   #安装apache
rpm -ql httpd  #查询所有安装httpd的目录和文件

systemctl start httpd.service  #启动apache
systemctl stop httpd.service  #停止apache
systemctl restart httpd.service  #重启apache
systemctl enable httpd.service  #设置开机启动
```

## nginx

```
//  编译后的说明
nginx path prefix: "/usr/local/nginx"
nginx binary file: "/usr/local/nginx/sbin/nginx"
nginx modules path: "/usr/local/nginx/modules"
nginx configuration prefix: "/usr/local/nginx/conf"
nginx configuration file: "/usr/local/nginx/conf/nginx.conf"
nginx pid file: "/usr/local/nginx/logs/nginx.pid"
nginx error log file: "/usr/local/nginx/logs/error.log"
nginx http access log file: "/usr/local/nginx/logs/access.log"
nginx http client request body temporary files: "client_body_temp"
nginx http proxy temporary files: "proxy_temp"
nginx http fastcgi temporary files: "fastcgi_temp"
nginx http uwsgi temporary files: "uwsgi_temp"
nginx http scgi temporary files: "scgi_temp"
```


```sh
sudo su
yum install wget
yum install gcc-c++
yum -y install pcre pcre-devel # 用pcre来解析正则表达式
yum -y install zlib zlib-devel
yum install -y openssl openssl-devel

wget -c https://nginx.org/download/nginx-1.12.2.tar.gz # 下载到/usr/local/src
tar -zxvf nginx-1.12.2.tar.gz # 解压文件，获得源码

./configure  # creating objs/Makefile
make
make install # 将译安装完的软件都会放在/usr/local下面
whereis nginx

cd /usr/local/nginx/sbin
./nginx 
./nginx -s stop
./nginx -s quit
./nginx -s reload

ps aux|grep nginx

# 访问测试

# 防火墙设置
firewall-cmd --state # 查看状态
systemctl stop firewalld.service # 停止fireball
systemctl disable firewalld.service  # 禁止firewall开机启动

yum install iptables-services # 安装iptables服务

vim /etc/sysconfig/iptables # 防火墙配置文件

-A INPUT -p tcp -m state --state NEW -m tcp --dport 80 -jACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp --dport 8080-j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp --dport 443 -j ACCEPT

systemctl restart iptables.service # 重启服务
systemctl enable iptables.service # 设置防火墙开机启动

# 手动添加开机自启
vim /lib/systemd/system/nginx.service

[Unit]
Description=nginx
After=network.target
 
[Service]
Type=forking
ExecStart=/usr/local/nginx/sbin/nginx
ExecReload=/usr/local/nginx/sbin/nginx -s reload
ExecStop=/usr/local/nginx/sbin/nginx -s quit
PrivateTmp=true
 
[Install]
WantedBy=multi-user.target

chmod 745 /lib/systemd/system/nginx.service
systemctl enable nginx.service

vim /etc/init.d/nginx # 配置脚本

#!/bin/bash
# nginx Startup script for the Nginx HTTP Server
# it is v.0.0.2 version.
# chkconfig: - 85 15
# description: Nginx is a high-performance web and proxy server.
#              It has a lot of features, but it's not for everyone.
# processname: nginx
# pidfile: /var/run/nginx.pid
# config: /usr/local/nginx/conf/nginx.conf
nginxd=/usr/local/nginx/sbin/nginx
nginx_config=/usr/local/nginx/conf/nginx.conf
nginx_pid=/var/run/nginx.pid
RETVAL=0
prog="nginx"
# Source function library.
. /etc/rc.d/init.d/functions
# Source networking configuration.
. /etc/sysconfig/network
# Check that networking is up.
[ ${NETWORKING} = "no" ] && exit 0
[ -x $nginxd ] || exit 0
# Start nginx daemons functions.
start() {
if [ -e $nginx_pid ];then
   echo "nginx already running...."
   exit 1
fi
   echo -n $"Starting $prog: "
   daemon $nginxd -c ${nginx_config}
   RETVAL=$?
   echo
   [ $RETVAL = 0 ] && touch /var/lock/subsys/nginx
   return $RETVAL
}
# Stop nginx daemons functions.
stop() {
        echo -n $"Stopping $prog: "
        killproc $nginxd
        RETVAL=$?
        echo
        [ $RETVAL = 0 ] && rm -f /var/lock/subsys/nginx /var/run/nginx.pid
}
# reload nginx service functions.
reload() {
    echo -n $"Reloading $prog: "
    #kill -HUP `cat ${nginx_pid}`
    killproc $nginxd -HUP
    RETVAL=$?
    echo
}
# See how we were called.
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
        stop
        start
        ;;
status)
        status $prog
        RETVAL=$?
        ;;
*)
        echo $"Usage: $prog {start|stop|restart|reload|status|help}"
        exit 1
esac
exit $RETVAL

chmod a+x /etc/init.d/nginx

sudo yum install nginx
sudo systemctl start nginx
```

### percona

```sh
wget https://www.percona.com/downloads/Percona-Server-LATEST/Percona-Server-5.7.18-14/source/tarball/percona-server-5.7.18-14.tar.gz --no-check-certificate
tar xfz percona-server-5.7.18-14.tar.gz

# CMake 安装
yum install libaio-devel 
```

### php

```sh
sudo wget http://php.net/distributions/php-7.2.3.tar.bz2
bzip2 -d php-7.2.3.tar.bz2
tar xvf php-7.2.3.tar
yum -y install libxml2 libxml2-devel openssl openssl-devel curl-devel libjpeg-devel libpng-devel freetype-devel libmcrypt-devel

./configure \
--prefix=/usr/local/php7 \
--exec-prefix=/usr/local/php7 \
--bindir=/usr/local/php7/bin \
--sbindir=/usr/local/php7/sbin \
--includedir=/usr/local/php7/include \
--libdir=/usr/local/php7/lib/php \
--mandir=/usr/local/php7/php/man \
--with-config-file-path=/usr/local/php7/etc \
--with-mysql-sock=/var/lib/mysql/mysql.sock \
--with-mcrypt=/usr/include \
--with-mhash \
--with-openssl \
--with-mysql=shared,mysqlnd \
--with-mysqli=shared,mysqlnd \
--with-pdo-mysql=shared,mysqlnd \
--with-gd \
--with-iconv \
--with-zlib \
--enable-zip \
--enable-inline-optimization \
--disable-debug \
--disable-rpath \
--enable-shared \
--enable-xml \
--enable-bcmath \
--enable-shmop \
--enable-sysvsem \
--enable-mbregex \
--enable-mbstring \
--enable-ftp \
--enable-gd-native-ttf \
--enable-pcntl \
--enable-sockets \
--with-xmlrpc \
--enable-soap \
--without-pear \
--with-gettext \
--enable-session \
--with-curl \
--with-jpeg-dir \
--with-freetype-dir \
--enable-opcache \
--enable-redis \
--enable-fpm \
--enable-fastcgi \
--with-fpm-user=www \
--with-fpm-group=www \
--without-gdbm \
--disable-fileinfo

make && make install
make test

cp /usr/local/src/php-7.2.3/php.ini-production /usr/local/php7/etc/php.ini
cp /usr/local/php7/etc/php-fpm.conf.default /usr/local/php7/etc/php-fpm.conf
cp /usr/local/php7/etc/php-fpm.d/www.conf.default /usr/local/php7/etc/php-fpm.d/www.conf
cp /usr/local/src/php-7.2.3/sapi/fpm/php-fpm.service /lib/systemd/system/php-fpm.service
```

### Swoole

```sh
cd /usr/local/src
wget https://github.com/swoole/swoole-src/archive/v2.1.1.tar.gz
tar zxvf v2.1.1.tar.gz
cd swoole-src-2.1.1　　#文件夹名称可能不一样
/usr/local/php7/bin/phpize #用phpize生成configure配置文件
./configure --with-php-config=/usr/local/php7/bin/php-config
make && make install
```

### Percona

```sh
yum install https://www.percona.com/redir/downloads/percona-release/redhat/percona-release-0.1-4.noarch.rpm

yum install Percona-Server-client-57 Percona-Server-server-57
/usr/bin/mysql_secure_installation
```

