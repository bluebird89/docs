# [Zabbix](https://www.zabbix.com/)

## 结构

* zabbix-server-mysql-3.4.6-1.el7.x86_64 （zabbix server主安装程序）
* zabbix-agent-3.4.6-1.el7.x86_64 （zabbix agent 主安装程序）
* zabbix-web-3.4.6-1.el7.noarch（zabbix web安装程序）
* zabbix-get-3.4.6-1.el7.x86_64.rpm （zabbix server安装程序，用于获取监控数据）
* zabbix-web-mysql-3.4.6-1.el7.noarch.rpm （zabbix web连接数据库的安装程序）
* zabbix-release-3.4.2-1.el7.noarch.rpm （生成zabbix yum源配置文件）
* zabbix-sender-3.4.6-1.el7.x86_64.rpm （zabbix agent安装程序，用于发送监控数据）
* zabbix-get是安装在zabbix server端的，用于和zabbix agent端通信，用于从agent端主动拉取数据到server端；
* zabbix-sender是安装在zabbix agent端，用于和zabbix server端通信，用于主动把agent端的数据推送给server端。

## 安装

```sh
## Mac
# /usr/local/etc/zabbix
brew install zabbix

## centos
# 关闭防火墙
systemctl stop firewalld
# 防火墙开机不自启
systemctl disable firewalld

#关闭selinux：
#临时
setenforce 0
#永久
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
yum -y install mariadb-server mariadb
systemctl start mariadb && systemctl enable mariadb

rpm -i http://repo.zabbix.com/zabbix/3.4/rhel/7/x86_64/zabbix-release-3.4-2.el7.noarch.rpm
yum -y install zabbix-server-mysql zabbix-web-mysql zabbix-agent zabbix-get zabbix-sender

create database zabbix character set utf8 collate utf8_bin;
grant all privileges on zabbix.* to zabbix@localhost identified by 'zabbix';

# 导入初始模式和数据
zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql -uzabbix -p zabbix
# 服务器配置数据库
# /etc/zabbix/zabbix_server.conf
# DBName
# DBUSer
# DBPassword

systemctl start zabbix-server zabbix-agent httpd && systemctl enable zabbix-server zabbix-agent httpd
vim /etc/httpd/conf.d/zabbix.conf
php_value date.timezone Asia/Shanghai

#
systemctl stop iptables

reboot
http://your server ip/zabbix/

#页面配置

## 登陆
Admin zabbix
```

## 参考

* [Zabbix Documentation 3.4](https://www.zabbix.com/documentation/3.4)
