# [percona-server](https://github.com/percona/percona-server)

Percona Server <https://www.percona.com/software/mysql-database/percona-server>

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
sudo apt install libfile-fnmatch-perl debsums  zlib1g-dev libaio1 libmecab2

wget https://repo.percona.com/apt/percona-release_latest.$(lsb_release -sc)_all.deb
sudo dpkg -i percona-release_0.1-6.$(lsb_release -sc)_all.deb
sudo apt-get update
sudo apt-get install percona-xtrabackup

# 下载
wget https://www.percona.com/downloads/Percona-Server-LATEST/Percona-Server-8.0.19-10/binary/debian/focal/x86_64/Percona-Server-8.0.19-10-rf446c04-focal-x86_64-bundle.tar
wget https://www.percona.com/downloads/XtraBackup/Percona-XtraBackup-2.3.5/\
binary/debian/jessie/x86_64/percona-xtrabackup_2.3.5-1.jessie_amd64.deb
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

## 配置

```sh
echo ulimit -n 65535 >>/etc/profile
source /etc/profile

ulimit -n

# IO调度器
cat /sys/block/nvme0n1/queue/scheduler

# /etc/sysctl.conf
vm.swappiness = 0
sysctl -
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

## XtraBackup

* an open-source hot backup utility for MySQL that doesn't lock your database during the backup. It can back up data from InnoDB, XtraDB and MyISAM tables on MySQL/Percona Server/MariaDB servers, and has many advanced features.
* 一款基于MySQL的服务器的开源热备份实用程序，在备份过程中不会锁定数据库
* 可以备份来自MySQL5.1，5.5，5.6和5.7服务器上的InnoDB，XtraDB和MyISAM表的数据，以及带有XtraDB的Percona服务器
* /usr/share/percona-xtrabackup-test-24
* 功能：
  - 在不暂停数据库的情况下创建热的InnoDB备份
  - 进行MySQL的增量备份
  - 将压缩的MySQL备份传输到另一台服务器
  - 在MySQL服务器之间移动表格
  - 轻松创建新的MySQL复制从站
  - 在不增加服务器负载的情况下备份MySQL
* 包含工具：
  - xtrabackup：用于热备份innodb, xtradb表中数据的工具，不能备份其他类型的表(Myisam表)，也不能备份数据表结构。
  - innobackupex：是将xtrabackup进行封装的perl脚本，可以备份和恢复MyISAM表以及数据表结构
* 参考
  - [Xtrabackup 实现数据的备份与恢复](https://learnku.com/articles/27641)

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
innobackupex --defaults-file=/etc/my.cnf --user=root --password='password' /backup/20180423/
innobackupex --decompress /backups/2017-04-29_21-18-04/
innobackupex --apply-log --use-memory=4G /backups/2017-04-29_21-18-04
innobackupex --defaults-file=/etc/my.cnf  --apply-log /backup/20180423/2018-04-18_00-58-36/
innobackupex --defaults-file=/etc/my.cnf  --copy-back /backup/20180423/2018-04-18_00-58-36/
```

## 扩展

* [tokudb](https://github.com/XeLabs/tokudb):Next Generation DBMS TokuDB, based on Percona Server 5.7 with more features <https://github.com/xelabs/tokudb/wiki>
