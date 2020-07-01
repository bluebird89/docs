# optimization

## [Percona Toolkit](https://www.percona.com/doc/percona-toolkit)

* 检查master和slave数据的一致性
* 有效地对记录进行归档
* 查找重复的索引
* 对服务器信息进行汇总
* 分析来自日志和tcpdump的查询
* 当系统出问题的时候收集重要的系统信息
* pt-query-digest
* pt-online-schema-change

```sh
sudo apt install percona-toolkit
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

## Perfermace Schema
