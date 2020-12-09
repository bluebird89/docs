## [grafana](https://github.com/grafana/grafana)

The tool for beautiful monitoring and metric analytics & dashboards for Graphite, InfluxDB & Prometheus & More <https://grafana.com>

* `http://monitor_host:3000` 默认帐号/密码为admin/admin
* Configuration->Data Resources
* 导入[Dashboards](https://grafana.com/grafana/dashboards)
  - [System_Overview](https://github.com/percona/grafana-dashboards/blob/master/dashboards/System_Overview.json)
  - [MySQL_Overview](https://github.com/percona/grafana-dashboards/blob/master/dashboards/MySQL_Overview.json)
  - `https://grafana.com/dashboards/928` ID 复制 load
* metric
  - $__timeGroup是聚合函数 以10分钟一组，group by求和
  - $__timeFilter(inserttime)是时间区间函数，右上角时间选择筛选的是inserttime
* 变量

```sh
wget https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana-5.0.1-1.x86_64.rpm
sudo yum localinstall grafana-5.0.1-1.x86_64.rpm -y

brew update
brew install grafana

wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -

sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
apt-cache policy grafana
sudo apt install grafana

sudo systemctl status grafana-server

select $__timeGroup(inserttime, '10m') as time_sec,
      count(1) as call_num,
      sum(status=0) as success_num
from credit_log where $__timeFilter(inserttime)
group by time_sec
```

## 插件

* `/var/lib/grafana/plugins/` `/usr/local/var/lib/grafana/plugins`

```sh
grafana-cli plugins install percona-percona-app
```

## 工具

* [grafana/loki](https://github.com/grafana/loki):Like Prometheus, but for logs
