# Centos


## 配置

```sh
yum install vim
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
```

### percona

```sh
wget https://www.percona.com/downloads/Percona-Server-LATEST/Percona-Server-5.7.18-14/source/tarball/percona-server-5.7.18-14.tar.gz --no-check-certificate
tar xfz percona-server-5.7.18-14.tar.gz

# CMake 安装
yum install libaio-devel 
```

