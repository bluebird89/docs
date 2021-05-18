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
* 配置文件 /etc/mysql/my.cnf

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

## [Percona Toolkit](https://www.percona.com/doc/percona-toolkit)

* 任务
  - 检查master和slave数据的一致性
  - 有效地对记录进行归档
  - 查找重复的索引
  - 对服务器信息进行汇总
  - 分析来自日志和tcpdump的查询
  - 当系统出问题的时候收集重要的系统信息
* 工具列表
  - pt-variable-advisor:分析MySQL变量并就可能出现的问题提出建议
    + `wget https://www.percona.com/downloads/percona-toolkit/3.0.13/binary/redhat/7/x86_64/percona-toolkit-3.0.13-re85ce15-el7-x86_64-bundle.tar`
    + `pt-variable-advisor localhost --socket /var/lib/mysql/mysql.sock`
    + 重点关注有WARN的信息的条目
  - pt-query-digest 主要功能是从日志、进程列表和tcpdump分析MySQL查询.用来分析mysql的慢日志，与mysqldumpshow工具相比，py-query_digest 工具的分析结果更具体，更完善
    + 分析指含有select语句的慢查询:`pt-query-digest --filter '$event-&gt;{fingerprint} =~ m/^select/i' /var/lib/mysql/slowtest-slow.log&gt; slow_report4.log`
    + 分析指定时间范围内的查询:`pt-query-digest /var/lib/mysql/slowtest-slow.log --since '2017-01-07 09:30:00' --until '2017-01-07 10:00:00'&gt; &gt; slow_report3.log`
    + 查询所有所有的全表扫描或full join的慢查询 `pt-query-digest --filter '(($event-&gt;{Full_scan} || "") eq "yes") ||(($event-&gt;{Full_join} || "") eq "yes")' /var/lib/mysql/slowtest-slow.log&gt; slow_report6.log`
  - pt-align
  - pt-archiver
  - pt-config-diff
  - pt-deadlock-logger
  - pt-diskstats
  - pt-duplicate-key-checker
  - pt-fifo-split
  - pt-find
  - pt-fingerprint
  - pt-fk-error-logger
  - pt-heartbeat
  - pt-index-usage
  - pt-align
  - pt-archiver
  - pt-config-diff
  - pt-deadlock-logger
  - pt-diskstats
  - pt-duplicate-key-checker
  - pt-fifo-split
  - pt-find
  - pt-fingerprint
  - pt-fk-error-logger
  - pt-heartbeat
  - pt-index-usage
  - pt-ioprofile
  - pt-kill
  - pt-mext
  - pt-mongodb-query-digest
  - pt-mongodb-summary
  - pt-mysql-summary
  - pt-online-schema-change
  - pt-pmp
  - pt-secure-collect
  - pt-show-grants
  - pt-sift
  - pt-slave-delay
  - pt-slave-find
  - pt-slave-restart
  - pt-stalk
  - pt-summary
  - pt-table-checksum
  - pt-table-sync
  - pt-table-usage
  - pt-upgrade
  - pt-variable-advisor
  - pt-visual-explain
  - pt-slave-find
  - pt-slave-restart
  - pt-stalk
  - pt-summary
  - pt-table-checksum
  - pt-table-sync
  - pt-table-usage
  - pt-upgrade
  - pt-visual-explain
  - tpcc-mysql

```sh
sudo apt install percona-toolkit

pt-mysql-summary --host localhost --user root --ask-pass

wget https://www.percona.com/downloads/percona-toolkit/2.2.20/deb/percona-toolkit_2.2.20-1.tar.gz
tar zxvf percona-toolkit_2.2.20-1.tar.gz
# 安装
perl Makefile.PL
make && make install

./pt-query-digest  slow.log
pt-query-digest --since=148h mysql-slow.log | less

tcpdump -i bond0 -s 0 -l -w - dst port 3316 | strings | grep select | egrep -i 'arrival_record' >/tmp/select_arri.log
```

## Percona Monitoring and Management PMM

```sh
docker pull percona/pmm-server:lates
mkdir -p /opt/prometheus/data
mkdir -p /opt/consul-data
mkdir -p /var/lib/mysql
mkdir -p /var/lib/grafana
docker create -v /opt/prometheus/data -v /opt/consul-data -v /var/lib/mysql -v /var/lib/grafana --name pmm-data percona/pmm-server:1.2.0 /bin/true
docker run -d -p 8881:80 --volumes-from pmm-data --name pmm-server --restart always percona/pmm-server:1.2.0

yum install https://www.percona.com/redir/downloads/percona-release/redhat/percona-release-0.1-4.noarch.rpm
yum install pmm-client -y
pmm-admin config --server 47.92.131.xxx:80
vim /usr/local/percona/pmm-client/pmm.yml 修改hostnane
pmm-admin check-network 检查域服务端的链接
pmm-admin config --server 47.92.131.xxx:80
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
