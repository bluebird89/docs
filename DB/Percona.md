# Percona

数据库审计功能:需要使用MySQL企业版，或者Percona/MariaDB分支版本，MySQL社区版本不支持该功能。

启用thread pool特性，可使得在高并发的情况下，性能不会发生大幅下降
extra_port功能，非常实用， 关键时刻能救命的。
QUERY_RESPONSE_TIME 功能，也能使我们对整体的SQL响应时间分布有直观感受

percona提供了高性能XtraDB引擎，还提供了PXC高可用解决方案，并且附带了percona-toolkit等DBA管理工具箱
MariaDB在10.0.9版本起使用XtraDB（名称代号Aria）来代替MySQL的InnoDB.

## 安装

安装不要制定版本,会有合适版本安装.下载

```sh
wget https://www.percona.com/downloads/Percona-Server-LATEST/Percona-Server-5.7.18-14/binary/tarball/Percona-Server-5.7.18-14-Linux.x86_64.ssl100.tar.gz

wget https://www.percona.com/downloads/Percona-Server-LATEST/Percona-Server-5.7.18-14/source/tarball/percona-server-5.7.18-14.tar.gz
tar xfz percona-server-5.7.18-14.tar.gz

mysql-common, libjemalloc1, libaio1 and libmecab2

wget https://repo.percona.com/apt/percona-release_0.1-4.$(lsb_release -sc)_all.deb
dpkg -i percona-release_0.1-4.$(lsb_release -sc)_all.deb
sudo apt update
sudo apt install percona-server-server-5.7

wget https://www.percona.com/downloads/Percona-Server-5.6/Percona-Server-5.6.25-73.1/binary/debian/jessie/x86_64/Percona-Server-5.6.25-73.1-r07b797f-jessie-x86_64-bundle.tar
tar xvf Percona-Server-5.6.25-73.1-r07b797f-jessie-x86_64-bundle.tar

sudo dpkg -i *.deb

sudo apt install libfile-fnmatch-perl
sudo apt install debsums
sudo dpkg -i percona-server-common-5.7_5.7.21-21-3.bionic_amd64.deb
sudo apt install zlib1g-dev
sudo dpkg -i percona-server-server-5.7_5.7.21-21-3.bionic_amd64.deb
sudo dpkg -i percona-server-client-5.7_5.7.21-21-3.bionic_amd64.deb
sudo apt intall libaio1 libmecab2
sudo apt --fix-broken install
```

```sh
service mysql stop
apt-get purge -y mysql-*

service mysql stop
mkdir /usr/local/src/mysql_backup
cp -R /var/lib/mysql /usr/local/src/mysql_backup

service mysql stop
apt-get purge -y mysql-*

cd /usr/local/src
wget https://repo.percona.com/apt/percona-release_0.1-3.$(lsb_release -sc)_all.deb
`dpkg -i percona-release_0.1-3.$(lsb_release -sc)_all.deb `
apt-get update

apt-get install -y percona-server-server-5.5

mysql -e "CREATE FUNCTION fnv1a_64 RETURNS INTEGER SONAME 'libfnv1a_udf.so'"
mysql -e "CREATE FUNCTION fnv_64 RETURNS INTEGER SONAME 'libfnv_udf.so'"
mysql -e "CREATE FUNCTION murmur_hash RETURNS INTEGER SONAME 'libmurm'"

mysql -u USER -pPASSWORD -e "CREATE FUNCTION fnv1a_64 RETURNS INTEGER SONAME 'libfnv1a_udf.so'"
mysql -u USER -pPASSWORD -e "CREATE FUNCTION fnv_64 RETURNS INTEGER SONAME 'libfnv_udf.so'"
mysql -u USER -pPASSWORD -e "CREATE FUNCTION murmur_hash RETURNS INTEGER SONAME 'libmurmur_udf.so'"

# install has problem

sudo apt-get install -y mysql-server

service mysql stop && sudo apt-get purge -y mysql-*

sudo apt-get purge -y mysql-server
sudo apt-get update && sudo apt-get upgrade -y
```

编译安装
```sh
cmake . -DCMAKE_BUILD_TYPE=RelWithDebInfo -DBUILD_CONFIG=mysql_release -DFEATURE_SET=community -DWITH_EMBEDDED_SERVER=OFF
make
make install

```

配置文件 /etc/mysql/my.cnf

```shell
sudo service mysql start
service mysql status
sudo service mysql stop
sudo service mysql restart

systemctl unmask mysql.service
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

## problem

Errors were encountered while processing:
 percona-server-server-5.6
E: Sub-process /usr/bin/dpkg returned an error code (1)

```language
dpkg --get-selections | grep -i percona
percona-server-client-5.6            deinstall -- this one

# purge all old entries (deinstall) from the dpkg list
sudo dpkg --purge percona-server-server-5.6

sudo apt-get autoremove
sudo apt-get autoclean

sudo apt-get -f install

The following packages have unmet dependencies:
 percona-server-server-5.7 : PreDepends: percona-server-common-5.7 (= 5.7.20-18-1.xenial)
                             Depends: percona-server-client-5.7 (= 5.7.20-18-1.xenial) but it is not going to be installed
E: Unable to correct problems, you have held broken packages.

apt-get install percona-server-server
```

## 参考

* [Percona Toolkit Documentation](https://www.percona.com/doc/percona-toolkit/2.1/index.html)
* [downloads](https://www.percona.com/downloads/Percona-Server-5.7/)
