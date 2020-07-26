# optimization

## 基准测试

* 对数据库的性能指标进行定量的、可复现的、可对比的测试
* 作用
	- 由于数据一致性的要求，无法通过增加机器来分散向数据库写数据带来的压力；虽然可以通过前置缓存（Redis 等）、读写分离、分库分表来减轻压力，但是与系统其它组件的水平扩展相比，受到了太多的限制
	- 分析在当前的配置下（包括硬件配置、OS、数据库设置等），数据库的性能表现，从而找出 MySQL 的性能阈值，并根据实际系统的要求调整配置
* 指标
	- TPS/QPS：衡量吞吐量
	- 响应时间：包括平均响应时间、最小响应时间、最大响应时间、时间百分比等，其中时间百分比参考意义较大，如前 95% 的请求的最大响应时间。
	- 并发量：同时处理的查询请求的数量
* 分类
	- 对整个系统的基准测试：通过 http 请求进行测试，如通过浏览器、APP 或 postman 等测试工具。该方案的优点是能够更好的针对整个系统，测试结果更加准确；缺点是设计复杂实现困难
	- 针对 MySQL 的基准测试

## [sysbench](https://github.com/akopytov/sysbench)

* 跨平台的基准测试工具，支持多线程，支持多种数据库；主要包括以下几种测试：
	- cpu 性能
	- 磁盘 io 性能
	- 调度程序性能
	- 内存分配及传输速度
	- POSIX 线程性能
	- 数据库性能 (OLTP 基准测试)
* 语法 `sysbench [options]... [testname] [command]`
	- testname 指定了要进行的测试，在老版本的 sysbench 中，可以通过 --test 参数指定测试的脚本；而在新版本中，--test 参数已经声明为废弃直接指定脚本
	-  command 是 sysbench 要执行的命令
		+  prepare 是为测试提前准备数据
		+  run 是执行正式的测试
		+  cleanup 是在测试完成后对数据库进行清理
	- options
		+ -mysql-host：MySQL 服务器主机名，默认 localhost；如果在本机上使用 localhost 报错，提示无法连接 MySQL 服务器，改成本机的 IP 地址应该就可以了。
		+ --mysql-port：MySQL 服务器端口，默认 3306
		+ --mysql-user：用户名
		+ --mysql-password：密码
		+ --oltp-test-mode：执行模式，包括 simple、nontrx 和 complex，默认是 complex。simple 模式下只测试简单的查询；nontrx 不仅测试查询，还测试插入更新等，但是不使用事务；complex 模式下测试最全面，会测试增删改查，而且会使用事务。可以根据自己的需要选择测试模式。
		+ --oltp-tables-count：测试的表数量，根据实际情况选择
		+ --oltp-table-size：测试的表的大小，根据实际情况选择
		+ --threads：客户端的并发连接数
		+ --time：测试执行的时间，单位是秒，该值不要太短，可以选择 120
		+ --report-interval：生成报告的时间间隔，单位是秒，如 10
* 注意
	- 尽量不要在 MySQL 服务器运行的机器上进行测试，一方面可能无法体现网络（哪怕是局域网）的影响，另一方面，sysbench 的运行（尤其是设置的并发数较高时）会影响 MySQL 服务器的表现。
	- 可以逐步增加客户端的并发连接数（--thread 参数），观察在连接数不同情况下，MySQL 服务器的表现；如分别设置为 10,20,50,100 等。
	- 一般执行模式选择 complex 即可，如果需要特别测试服务器只读性能，或不使用事务时的性能，可以选择 simple 模式或 nontrx 模式。
	- 如果连续进行多次测试，注意确保之前测试的数据已经被清理干净
	- 在开始测试之前，应该首先明确：应采用针对整个系统的基准测试，还是针对 MySQL 的基准测试，还是二者都需要。
	- 如果需要针对 MySQL 的基准测试，那么还需要明确精度方面的要求：是否需要使用生产环境的真实数据，还是使用工具生成也可以；前者实施起来更加繁琐。如果要使用真实数据，尽量使用全部数据，而不是部分数据。
	- 基准测试要进行多次才有意义。
	- 测试时需要注意主从同步的状态。
	- 测试必须模拟多线程的情况，单线程情况不但无法模拟真实的效率，也无法模拟阻塞甚至死锁情况。
* 结果
	- queries：查询总数
	- qps transactions：事务总数
	- tps Latency-95th percentile：前 95% 的请求的最大响应时间

```sh
wget https://github.com/akopytov/sysbench/archive/1.0.20.zip -O "sysbench-1.0.20.zip"
unzip sysbench-1.0.20.zip
cd sysbench-1.0.20
apt install automake libtool –y

./autogen.sh
./configure
export LD_LIBRARY_PATH=/usr/include/mysql # mysql_config --include
make
make install
sysbench --version

sysbench ./tests/include/oltp_legacy/oltp.lua --mysql-host=192.168.10.10 --mysql-port=3306 --mysql-user=root --mysql-password=123456 --oltp-test-mode=complex --oltp-tables-count=10 --oltp-table-size=100000 --threads=10 --time=120 --report-interval=10 prepare
sysbench ./tests/include/oltp_legacy/oltp.lua --mysql-host=192.168.10.10 --mysql-port=3306 --mysql-user=root --mysql-password=123456 --oltp-test-mode=complex --oltp-tables-count=10 --oltp-table-size=100000 --threads=10 --time=120 --report-interval=10 run >> /home/test/mysysbench.log
sysbench ./tests/include/oltp_legacy/oltp.lua --mysql-host=192.168.10.10 --mysql-port=3306 --mysql-user=root --mysql-password=123456 cleanup
```

## [Percona Toolkit](https://www.percona.com/doc/percona-toolkit)

* 检查master和slave数据的一致性
* 有效地对记录进行归档
* 查找重复的索引
* 对服务器信息进行汇总
* 分析来自日志和tcpdump的查询
* 当系统出问题的时候收集重要的系统信息
* 工具列表
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
	- pt-query-digest
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
	- pt-variable-advisor
	- pt-visual-explain

```sh
sudo apt install percona-toolkit

pt-mysql-summary --host localhost --user root --ask-pass
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

* 单表数据量尽量控制在千万级别
* 关系型数据库在TPS上的瓶颈往往会比其他瓶颈更容易暴露出来,常用的MySQL数据库为例，常规情况下的TPS大概只有1500左右
