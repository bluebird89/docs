# Centos



## 自启服务

* `/etc/rc.d/rc.local`
* `/etc/rc.d/init.d/`

## 防火墙

* 默认使用的是firewall作为防火墙，使用iptables必须重新设置一下
* iptables 设置端口暴露
* 参数
  - –zone #作用域
    + drop: 丢弃所有进入的包，而不给出任何响应
    + block: 拒绝所有外部发起的连接，允许内部发起的连接
    + public: 允许指定的进入连接
    + external: 同上，对伪装的进入连接，一般用于路由转发
    + dmz: 允许受限制的进入连接
    + work: 允许受信任的计算机被限制的进入连接，类似 workgroup
    + home: 同上，类似 homegroup
    + internal: 同上，范围针对所有互联网用户
    + trusted: 信任所有连接
  - –add-port=80/tcp #添加端口，格式为：端口/通讯协议
  - –permanent #永久生效，没有此参数重启后失效

```sh
# Centos 7 firewall 命令
systemctl status|start｜stop|enable|disable firewalld.service # 停止|禁止firewall开机启动

firewall-cmd --list-ports|state # 查看
firewall-cmd --zone=public --add-port=80/tcp --permanent # 永久生效(没有此参数重启后失效)
firewall-cmd --add-port=8181/tcp --permanent # 追加一个8181端口，永久有效
firewall-cmd --add-port=6000-6600/tcp # 追加一段端口范围
firewall-cmd --add-service=ftp # 开放 ftp 服务
firewall-cmd --zone=public --add-interface=eth0 --permanent # 添加eth0 接口至 public 信任等级，永久有效
# 配置 public zone 的端口转发
firewall-cmd --zone=public --add-masquerade
# 然后转发 tcp 22 端口至 9527
firewall-cmd --zone=public --add-forward-port=port=22:proto=tcp:toport=9527
# 转发 22 端口数据至另一个 ip 的相同端口上
firewall-cmd --zone=public --add-forward-port=port=22:proto=tcp:toaddr=192.168.1.123
# 转发 22 端口数据至另一 ip 的 9527 端口上
firewall-cmd --zone=public --add-forward-port=port=22:proto=tcp:toport=9527:toaddr=192.168.1.100

firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='192.168.1.123' reject" # IP 封禁
firewall-cmd --permanent --zone=public --new-ipset=blacklist --type=hash:ip # 通过 ipset 来封禁 ip
firewall-cmd --permanent --zone=public --ipset=blacklist --add-entry=192.168.1.123
firewall-cmd --permanent --zone=public --new-ipset=blacklist --type=hash:net # 封禁网段
firewall-cmd --permanent --zone=public --ipset=blacklist --add-entry=192.168.1.0/24
firewall-cmd --permanent --zone=public --new-ipset-from-file=/path/blacklist.xml # 倒入 ipset 规则 blacklist，然后封禁 blacklist
firewall-cmd --permanent --zone=public --add-rich-rule='rule source ipset=blacklist drop'

firewall-cmd --reload #重启firewall

# CentOS 7 以下版本 iptables 命令
yum -y install iptables-services  #安装iptables
systemctl  start|stop|restart|status|enable iptables.service

# 开放80，22，8080 端口
/sbin/iptables -I INPUT -p tcp --dport 80 -j ACCEPT
/sbin/iptables -I INPUT -p tcp --dport 22 -j ACCEPT
/sbin/iptables -I INPUT -p tcp --dport 8080 -j ACCEPT
# 保存
/etc/rc.d/init.d/iptables save
# 查看打开的端口
/etc/init.d/iptables status|restart|stop
## 永久性生效，重启后不会复原
# 开启
chkconfig iptables on| off

## 即时生效，重启后复原
# 查看|开启|关闭防火墙状态
service iptables status|start|stop

vi /etc/sysconfig/iptables  #编辑防火墙配置文件
# Firewall configuration written by system-config-firewall
# Manual customization of this file is not recommended.
*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
-A INPUT -p icmp -j ACCEPT
-A INPUT -i lo -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 3306 -j ACCEPT
-A INPUT -j REJECT --reject-with icmp-host-prohibited
-A FORWARD -j REJECT --reject-with icmp-host-prohibited
COMMIT

systemctl restart|enbale|start|stop iptables.service

vi /etc/selinux/config

#SELINUX=enforcing #注释掉
#SELINUXTYPE=targeted #注释掉
SELINUX=disabled #增加

:wq! #保存退出

setenforce 0 #使配置立即生效

# 查看端口是否正常开启
netstat -antlp | grep 8080
# 查看是否有iptables策略
iptables -L
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

yum clean all   # 清除yum缓存
yum makecache  #缓存本地yum源中的软件包信息

yum install httpd   #安装apache
rpm -ql httpd  #查询所有安装httpd的目录和文件

systemctl start|stop|restart|enable httpd.service  #设置开机启动
```

## 用户

```sh
sudo -i
```

## 配置

```sh
yum-config-manager

yum install vim git net-tools  epel-release
yum provides ifconfig
```

## nginx

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

#  编译后的说明
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

yum install https://www.percona.com/redir/downloads/percona-release/redhat/percona-release-0.1-4.noarch.rpm
yum install Percona-Server-client-57 Percona-Server-server-57
/usr/bin/mysql_secure_installation
```

### php

```sh
yum install epel-release yum-utils -y
yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum-config-manager --enable remi-php74
yum install php php-fpm php-common php-opcache php-mcrypt php-cli php-gd php-curl php-mysql -y

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

# 文件有写入权限，但无法写入内容
getenforce #查看
setenforce 0 # 临时

# 永久
# etc/sysconfig/selinux
SELINUX=disabled
reboot

## php-fpm 与nginx 配合
## www.conf 用户与nginx配置一致
listen.owner=nginx
listen.group=nginx

chown nginx php-fpm.sock
chgrp nginx php-fpm.sock
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

## BBR

```sh
cat /etc/redhat-release # 大于7.3即可

# 自动脚本

wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh && chmod +x bbr.sh && ./bbr.sh
curl -O https://raw.githubusercontent.com/teddysun/across/master/bbr.sh && sh bbr.sh
wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh && chmod +x bbr.sh && ./bbr.sh

# 手动
# yum install curl wget vim net-tools iproute2 openssh-server openssh python3 python3-pip -y
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org # 导入公钥
rpm -Uvh https://www.elrepo.org/elrepo-release-7.0-4.el7.elrepo.noarch.rpm # 安装elrepo并升级内核
yum --enablerepo=elrepo-kernel install kernel-ml -y # 安装内核

rpm -qa | grep kernel # 查看已安装内核

# 删除旧内核版本
rpm -ev kernel-3.10.0-1062.el7.x86_64
rpm -ev kernel-3.10.0-1062.12.1.el7.x86_64
# rpm -ev kernel-3.10.0-1062.18.1.el7.x86_64
rpm -ev kernel-devel-3.10.0-1062.18.1.el7.x86_64

# /BOOT/GRUB/GRUB.CONF NOT FOUND   /BOOT/GRUB2/GRUB.CFG NOT FOUND
yum install -y grub # /boot/grub/grub.conf 缺失
grub-mkconfig -o /boot/grub/grub.conf

yum install -y grub2 # /boot/grub2/grub.cfg 缺失
grub2-mkconfig -o /boot/grub2/grub.cfg

egrep ^menuentry /etc/grub2.cfg | cut -f 2 -d \' 
awk -F\' '$1=="menuentry " {print i++ " : " $2}' /etc/grub2.cfg

0 : CentOS Linux (4.19.0-1.el7.elrepo.x86_64) 7 (Core)
1 : CentOS Linux 7 Rescue ee7953a3b5944053a26f29daf8c71e2f (3.10.0-862.14.4.el7.x86_64)
2 : CentOS Linux (3.10.0-862.14.4.el7.x86_64) 7 (Core)
3 : CentOS Linux (3.10.0-862.3.2.el7.x86_64) 7 (Core)
4 : CentOS Linux (3.10.0-862.el7.x86_64) 7 (Core)
5 : CentOS Linux (0-rescue-4bbda2095d924b72b05507b68bd509f0) 7 (Core)

grub2-set-default 0   # 更新grub文件并重启 由于序号从0开始，设置需要的内核为启动项
reboot

lsmod | grep bbr
modprobe tcp_bbr

uname -r # 是否已更换为4.9
echo "tcp_bbr" >> /etc/modules-load.d/modules.conf
echo 'net.core.default_qdisc=fq' >> /etc/sysctl.conf  
echo 'net.ipv4.tcp_congestion_control=bbr' >> /etc/sysctl.conf  
sysctl -p

# 验证
sysctl net.ipv4.tcp_available_congestion_control # net.ipv4.tcp_available_congestion_control = reno cubic bbr
sysctl net.ipv4.tcp_congestion_control # net.ipv4.tcp_congestion_control = bbr

dd if=/dev/zero of=500mb.zip bs=1024k count=500 # 访问 http://[your-server-IP]/500mb.zip 来测试下载速度
```
