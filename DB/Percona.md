
# Percona

数据库审计功能:需要使用MySQL企业版，或者Percona/MariaDB分支版本，MySQL社区版本不支持该功能。

启用thread pool特性，可使得在高并发的情况下，性能不会发生大幅下降
extra_port功能，非常实用， 关键时刻能救命的。
QUERY_RESPONSE_TIME 功能，也能使我们对整体的SQL响应时间分布有直观感受

## 安装

```shell
wget https://repo.percona.com/apt/percona-release_0.1-4.$(lsb_release -sc)_all.deb
dpkg -i percona-release_0.1-4.$(lsb_release -sc)_all.deb
sudo apt-get updatesudo apt-get install percona-server-server-5.6
sudo apt-get install percona-server-server-5.6

wget https://www.percona.com/downloads/Percona-Server-5.6/Percona-Server-5.6.25-73.1/binary/debian/jessie/x86_64/Percona-Server-5.6.25-73.1-r07b797f-jessie-x86_64-bundle.tar
tar xvf Percona-Server-5.6.25-73.1-r07b797f-jessie-x86_64-bundle.tar
sudo dpkg -i *.deb

wget https://repo.percona.com/apt/percona-release_0.1-4.xenial_all.deb
dpkg -i percona-release_0.1-4.xenial_all.deb
sudo apt-get update
sudo apt-get install percona-server-server-5.7 percona-server-client-5.7
```

/etc/mysql/my.cnf

```shell
sudo service mysql start
service mysql status
sudo service mysql stop
sudo service mysql restart

systemctl unmask mysql.service

```


percona-toolkit