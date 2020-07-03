# [percona/percona-server](https://github.com/percona/percona-server)

Percona Server https://www.percona.com/software/mysql-database/percona-server

* 数据库审计功能:需要使用MySQL企业版，或者Percona/MariaDB分支版本，MySQL社区版本不支持该功能。
* 启用thread pool特性，可使得在高并发的情况下，性能不会发生大幅下降
* extra_port功能，非常实用， 关键时刻能救命的。
* QUERY_RESPONSE_TIME 功能，也能使我们对整体的SQL响应时间分布有直观感受
* percona提供了高性能XtraDB引擎，还提供了PXC高可用解决方案，并且附带了percona-toolkit等DBA管理工具箱
* MariaDB在10.0.9版本起使用XtraDB（名称代号Aria）来代替MySQL的InnoDB.

## 安装

* 安装不要制定版本,会有合适版本安装.下载
*
配置文件 /etc/mysql/my.cnf

```sh
wget https://www.percona.com/downloads/Percona-Server-LATEST/Percona-Server-5.7.18-14/binary/tarball/Percona-Server-5.7.18-14-Linux.x86_64.ssl100.tar.gz

wget https://www.percona.com/downloads/Percona-Server-LATEST/Percona-Server-5.7.18-14/source/tarball/percona-server-5.7.18-14.tar.gz
tar xfz percona-server-5.7.18-14.tar.gz

wget https://repo.percona.com/apt/percona-release_0.1-4.$(lsb_release -sc)_all.deb
dpkg -i percona-release_0.1-4.$(lsb_release -sc)_all.deb
sudo apt update

sudo apt install libfile-fnmatch-perl debsums  zlib1g-dev libaio1 libmecab2
sudo dpkg -i *.deb\

sudo apt --fix-broken install

mysql -e "CREATE FUNCTION fnv1a_64 RETURNS INTEGER SONAME 'libfnv1a_udf.so'" -u USER -pPASSWORD
mysql -e "CREATE FUNCTION fnv_64 RETURNS INTEGER SONAME 'libfnv_udf.so'" -u USER -pPASSWORD
mysql -e "CREATE FUNCTION murmur_hash RETURNS INTEGER SONAME 'libmurmur_udf.so'" -u USER -pPASSWORD

ps-admin --enable-rocksdb -u <mysql_admin_user> -p[mysql_admin_pass] [-S <socket>] [-h
 <host> -P <port>]

service mysql stop
mkdir /usr/local/src/mysql_backup
cp -R /var/lib/mysql /usr/local/src/mysql_backup
apt-get purge -y mysql-*

#编译安装
cmake . -DCMAKE_BUILD_TYPE=RelWithDebInfo -DBUILD_CONFIG=mysql_release -DFEATURE_SET=community -DWITH_EMBEDDED_SERVER=OFF
make
make install
```

## 重置root密码

```sh
sudo service mysql stop

vim /etc/mysql/my.cnf
skip-grant-tables # 忽略mysql权限问题，直接登录

sudo service mysql start

use mysql;
update user set password=password("123456") where user="root";  ## 更新密码
update mysql.user set authentication_string=password('123456') where user='root' ;  # 5.7以后以前的password字段改成了authentication_string
flush privileges;

ps -ef |grep mysql  ##显示mysql现有的进程
kill pid  ##删除mysql现有进程
```

## innobackupex

```sh
sudo yum install http://www.percona.com/downloads/percona-release/redhat/0.1-4/percona-release-0.1-4.noarch.rpm
sudo yum install percona-xtrabackup-24
# Debian / Ubuntu
wget https://repo.percona.com/apt/percona-release_0.1-4.$(lsb_release -sc)_all.deb
sudo dpkg -i percona-release_0.1-4.$(lsb_release -sc)_all.deb
sudo apt-get update
sudo apt-get install percona-xtrabackup-24

innobackupex --user=root --password='Passw0rd!' /backups/
innobackupex --user=root --password='Passw0rd!' --parallel=8 /backups/
innobackupex --user=root --password='Passw0rd!' --parallel=8 --compress --compress-threads=8 /backups/
innobackupex --decompress /backups/2017-04-29_21-18-04/
innobackupex --apply-log --use-memory=4G /backups/2017-04-29_21-18-04
```

## 参考

* [Percona Toolkit Documentation](https://www.percona.com/doc/percona-toolkit/2.1/index.html)
* [downloads](https://www.percona.com/downloads/Percona-Server-5.7/)

## 扩展

* [xelabs/tokudb](https://github.com/XeLabs/tokudb):Next Generation DBMS TokuDB, based on Percona Server 5.7 with more features https://github.com/xelabs/tokudb/wiki
