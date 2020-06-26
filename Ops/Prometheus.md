# [prometheus/prometheus](https://github.com/prometheus/prometheus)

The Prometheus monitoring system and time series database. https://prometheus.io/

* SoundCloud开源的监控告警系统，使用Golang开发。2012年开始编码，2015年在Github上开源，2016年加入CNCF成为继K8s之后第二名成员
* 一套开源的监控&报警&时间序列数据库的组合
* 多维数据模型，时序数据由Metric和多个Label组成
* PromQL灵活的查询语法
* 无依赖存储，支持本地和远程存储
* 通过HTTP协议采用PULL的方式拉取数据
* 可以采用服务发现或者静态配置方式，来发现目标服务
* 支持多种统计数据模型，UI优化，Grafana也支持Prometheus

## 安装

```sh
wget https://github.com/prometheus/prometheus/releases/download/v2.14.0/prometheus-2.14.0.linux-amd64.tar.gz
tar xvfz prometheus-*.tar.gz
cd prometheus-*

docker run -p 9090:9090 -v /tmp/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus

#
FROM prom/prometheus
ADD prometheus.yml /etc/prometheus/

docker build -t my-prometheus .
docker run -p 9090:9090 my-prometheus

# prometheus.yml
# 全局设置可以被覆盖
global:
  # 默认值为15s，用于设置每次数据拉取的间隔
  scrape_interval: 15s
  # 所有时间序列和告警与外部通信时用的外部标签
  external_labels:
    monitor: 'prometheue-monitor'

# scrape配置
scrape_configs:
# The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
# jon_name一定要全局唯一
- job_name: 'prometheus'
  # 覆盖全局的 scrape_interval
  scrape_interval: 5s
  # 静态目标的配置 192.168.0.91为本地物理机IP
  static_configs:
  - targets: ['192.168.0.91:9090']

# 校验
./promtool check config prometheus.yml
./prometheus --config.file=prometheus.yml

http://localhost:9090/metrics.
http://localhost:9090/graph.

docker pull prom/prometheus

# Reload配置
kill -HUP {pid}
curl -X POST http://localhost:9090/-/reload
```

## 架构

* Prometheus Server: 负责采集和存储监控数据，并且对外提供PromQL实现监控数据的查询、聚合分析，以及告警规则管理。
    - Retrieval: 负责定时去暴露的目标服务上去拉取监控Metrics指标数据
    - TSDB: Prometheus 2.0版本起使用的底层存储, 它的数据块编码使用了facebook的gorilla，具备了完整的持久化方案
    - HTTP Server: 提供HTTP API接口查询监控Metrics数据
* Service discovery: Prometheus支持多种服务发现机制，文件、DNS、Consul、Kubernetes、OpenStack、EC2等等。前提是这些服务需要开放/metrics接口提供数据查询。
* Prometheus targets: Prometheus监控目标服务，Prometheus通过轮询这些目标服务拉取监控Metrics数据。
* Push gateway: 某些场景Prometheus无法直接拉取监控数据，Pushgateway的作用在于提供了中间代理。我们可以在应用程序中定时将监控Metrics数据提交到Pushgateway，Prometheus Server定时从Pushgateway的/metrics接口采集数据。
* Prometheus alerting: Prometheus告警，Alertmanager用于管理告警，支持告警通知。
* Data visualization: 数据可视化展示，通过PromQL对时间序列数据进行查询、聚合以及逻辑运算。除了Prometheus自带的UI，Grafana对Prometheus也提供了非常好的支持。

## 对比其它方案

* Prometheus属于一站式监控告警平台，依赖少，功能齐全。
* Prometheus支持对云或容器的监控，其他系统主要对传统物理机监控。
* Prometheus数据查询语句表现力更强大，内置更强大的统计函数。
* Prometheus在数据存储扩展性以及持久性上没有InfluxDB，OpenTSDB，Sensu好。

## 数据模型

* 时序数据:以时间维度存储连续的数据集合,用以下表达式标识 `<metric name>{<label name>=<label value>, ...}``
    - Metric name: 统计指标名称，名称应该具有语义化，例如”fluentd_flowcounter_out_bytes”。Metric name必须满足正则表达式[a-zA-Z_:][a-zA-Z0-9_:]*
      + metrics名称必须满足 [a-zA-Z_:][a-zA-Z0-9_:]* 这个正则表达式，label名称必须满足 [a-zA-Z_][a-zA-Z0-9_]* 这个正则表达式
      + metrics名称需要使用前缀来表示特定的服务，例如prometheus_notifications_total表示Prometheus服务，http_request_duration_seconds表示HTTP服务
      + metrics名称需要使用后缀来表示监控数值的单位，例如http_request_duration_seconds和node_memory_usage_bytes，http_requests_total total则是用来表示次数
      + metrics名称应该使用基本单位，例如seconds，bytes，meters
      + metrics名称最好使用单个单位，不要使用多个单位，例如不要混淆seconds 和 bytes
      + 不应该把label名称放在metrics名称上
    - Metrics类型
        + Counter是一个计数器指标，它是一个只能递增的数值（服务重启的时候会被reset为0）。 Counter主要用于统计服务的请求数、任务完成数、错误出现的次数等
        + Gauge是一个仪表盘指标，它表示一个既可以递增, 又可以递减的值。主要用于统计类似于温度、当前内存使用量等会上下浮动的指标
        + histogram是柱状图，定义一个Histogram类型Metric，则Prometheus系统会自动生成三个对应的指标
            * 对每个采样点进行统计，打到各个分类桶中(bucket)
            * 对每个采样点值累计和(sum)
            * 对采样点的次数累计和(count)
        + summary是采样点分位图统计(通常的使用场景：请求持续时间和响应大小)，定义一个Summary类型Metric，则Prometheus系统会自动生成三个对应的指标
            * 对于每个采样点进行统计，并形成分位图。
            * 统计所有采样点的和
            * 统计所有采样点总数
    - Labels: 标签是一组Key-Value，labels让Prometheus数据具有多个维度。例如我们可以用{hostname=”…”, type=”…“}这个标签来区分不同的时序数据。标签的命名应该具有语义化，同时必须满足正则表达式[a-zA-Z_][a-zA-Z0-9_]*，所有_开头的标签名被Prometheus内部保留使用。
    - Value: 实际的时序数据值，包括一个float64值和一个毫秒级时间戳
* 拉取的每一个目标服务实例称为instance，所有相同服务实例称为Job，Prometheus拉取目标服务监控Metric数据的时候，会自动添加job和instance两个标签。
    - job: 值为prometheus.yml配置的job名称
    - instance: 值为服务实例的host:port
    - 自动生成以下4个Metrics数据
        + `up{job="{job-name}", instance="{host:port}"}`: 用来反馈目标服务监控状态，值为1表示服务健康，否则表示服务不通。
        + `scrape_duration_seconds{job="{job-name}", instance="{host:port}"}`: 拉取监控Metrics数据时间开销。
        + `scrape_samples_post_metric_relabeling{job="{job-name}", instance="{host:port}"}`: labels变化后，仍然剩余的监控数据条数。
        + `scrape_samples_scraped{job="{job-name}", instance="{host:port}"}`: 拉取监控Metrics数据的条数。

```
# 总请求
sum(http_requests_total{label1=value1, label2=value2 ...})
# 每秒请求量
sum(rate(http_requests_total{label1=value1, label2=value2 ...}[5m]))
# 请求量Top 10的URI
topk(10, sum(http_requests_total{label1=value1, label2=value2 ...}) by (path))

# 总的buffer
sum(buffer_total_bytes{label1=value1, label2=value2 ...})
# buffer按label分类
sum(buffer_total_bytes{label1=value1, label2=value2 ...}) by (label)

# 总次数
http_requests_latency_seconds_histogram_count{label1=value1, label2=value2 ...}
# 总和
http_requests_latency_seconds_histogram_sum{label1=value1, label2=value2 ...}
分类桶的数据
# http请求响应时间 <=0.005 秒的请求次数
http_requests_latency_seconds_histogram_bucket{le="0.005", label1=value1, label2=value2 ...}
# http请求响应时间 <=0.01 秒的请求次数
http_requests_latency_seconds_histogram_bucket{le="0.01", label1=value1, label2=value2 ...}

job: api-server
  instance 1：1.2.3.4:5670
  instance 2：1.2.3.4:5671
  instance 3：5.6.7.8:5670
  instance 4：5.6.7.8:5671
```

## 配置

* 配置文件是YAML格式，启动的时候可以加载运行参数-config.file指定配置文件，默认为prometheus.yml
* 不同占位符含义
    - <boolean>: 布尔值，值为true或false
    - <duration>: 时间字段，必须匹配正则表达式[0-9]+(ms|[smhdwy])
    - <labelname>: 标签名称，值为字符串必须匹配正则表达式[a-zA-Z_][a-zA-Z0-9_]*
    - <labelvalue>: 标签值，值为Unicode字符串
    - <filename>: 文件路径
    - <host>: 主机名
    - <path>: URL路径
    - <scheme>: HTTP或HTTPS
    - <string>: 常规字符串值
    - <secret>: 密码字符串
    - <tmpl_string>: template扩展的字符串
* 属性
    - global用于Prometheus全局默认配置，它主要包含以下4个配置项
        + scrape_interval: 拉取目标服务Metrics监控数据时间间隔
        + scrape_timeout: 拉取目标服务Metrics监控数据超时时间
        + evaluation_interval: 执行rules时间间隔。
        + external_labels: 额外的labels，会被添加到每条时序数据上
    - rule_files用于配置Alert Rules文件列表，支持配置多个文件以及文件目录
    - scrape_configs用于配置拉取目标服务Metrics监控数据，每一个拉取配置包含以下配置项
       + job_name: 拉取任务名称
       + scrape_interval: 拉取时间间隔，没有配置使用global scrape_interval配置
       + scrape_timeout: 拉取超时时间，没有配置使用global scrape_timeout配置
       + metrics_path: 拉取目标服务Metrics数据的path，默认为/metrics
       + honor_labels: 是否要解决labels冲突问题，设置为true以拉取数据为准，否则以配置为准
       + scheme: 请求协议，默认为HTTP
       + params: 拉取Metrics数据请求参数
       + basic_auth: 请求鉴权配置
       + kubernetes_sd_configs: K8s服务发现配置
       + static_configs: 静态配置目标服务
       + metric_relabel_configs: 重置Metrics标签
   - alerting用于告警配置，主要有以下2个配置项
       + alert_relabel_configs: 动态修改alert的配置规则
       + alertmanagers: 动态发现Alertmanager的配置

```yaml
global:
   # How frequently to scrape targets by default.
   [ scrape_interval: <duration> | default = 1m ]
   # How long until a scrape request times out.
   [ scrape_timeout: <duration> | default = 10s ]
   # How frequently to evaluate rules.
   [ evaluation_interval: <duration> | default = 1m ]
   # The labels to add to any time series or alerts when communicating with
   # external systems (federation, remote storage, Alertmanager).
   external_labels:
     [ <labelname>: <labelvalue> ... ]

# Rule files specifies a list of globs. Rules and alerts are read from
# all matching files.
rule_files:
   [ - <filepath_glob> ... ]

# A list of scrape configurations.
scrape_configs:
# The job name assigned to scraped metrics by default.
- job_name: <job_name>
  # How frequently to scrape targets from this job.
  [ scrape_interval: <duration> | default = <global_config.scrape_interval> ]

  # Per-scrape timeout when scraping this job.
  [ scrape_timeout: <duration> | default = <global_config.scrape_timeout> ]

  # The HTTP resource path on which to fetch metrics from targets.
  [ metrics_path: <path> | default = /metrics ]

  # honor_labels controls how Prometheus handles conflicts between labels that are
  # already present in scraped data and labels that Prometheus would attach
  # server-side ("job" and "instance" labels, manually configured target
  # labels, and labels generated by service discovery implementations).

  # If honor_labels is set to "true", label conflicts are resolved by keeping label
  # values from the scraped data and ignoring the conflicting server-side labels.

  # If honor_labels is set to "false", label conflicts are resolved by renaming
  # conflicting labels in the scraped data to "exported_<original-label>" (for
  # example "exported_instance", "exported_job") and then attaching server-side
  # labels. This is useful for use cases such as federation, where all labels
  # specified in the target should be preserved.

  # Note that any globally configured "external_labels" are unaffected by this
  # setting. In communication with external systems, they are always applied only
  # when a time series does not have a given label yet and are ignored otherwise.
    [ honor_labels: <boolean> | default = false ]

  # Configures the protocol scheme used for requests.
  [ scheme: <scheme> | default = http ]

  # Optional HTTP URL parameters.
  params:
    [ <string>: [<string>, ...] ]

  # Sets the `Authorization` header on every scrape request with the
  # configured username and password.
  basic_auth:
    [ username: <string> ]
    [ password: <string> ]

  # Sets the `Authorization` header on every scrape request with
  # the configured bearer token. It is mutually exclusive with `bearer_token_file`.
  [ bearer_token: <string> ]

  # Sets the `Authorization` header on every scrape request with the bearer token
  # read from the configured file. It is mutually exclusive with `bearer_token`.
  [ bearer_token_file: /path/to/bearer/token/file ]

  # Configures the scrape request's TLS settings.
  tls_config:
    [ <tls_config> ]

  # Optional proxy URL.
  [ proxy_url: <string> ]

  # List of Kubernetes service discovery configurations.
  # you can set oterh sd configs
  kubernetes_sd_configs:
    [ - <kubernetes_sd_config> ... ]

  # List of labeled statically configured targets for this job.
  static_configs:
    [ - <static_config> ... ]

  # List of target relabel configurations.
  relabel_configs:
    [ - <relabel_config> ... ]

  # List of metric relabel configurations.
  metric_relabel_configs:
    [ - <relabel_config> ... ]

  # Per-scrape limit on number of scraped samples that will be accepted.
  # If more than this number of samples are present after metric relabelling
  # the entire scrape will be treated as failed. 0 means no limit.
  [ sample_limit: <int> | default = 0 ]

# Alerting specifies settings related to the Alertmanager.
alerting:
   alert_relabel_configs:
      [ - <relabel_config> ... ]
   alertmanagers:
      [ - <alertmanager_config> ... ]

# Settings related to the experimental remote write feature.
remote_write:
   [ - <remote_write> ... ]

# Settings related to the experimental remote read feature.
remote_read:
   [ - <remote_read> ... ]
```

```yaml
# 实例
global:
   scrape_interval:     15s
   evaluation_interval: 30s
   # scrape_timeout is set to the global default (10s).

   external_labels:
     monitor: codelab
     foo:     bar

rule_files:
    - "rules/node.rules"
    - "rules2/*.rules"

scrape_configs:
    - job_name: 'prometheus'
      scrape_interval: 5s
      static_configs:
      - targets: ['127.0.0.1:9090']

    - job_name: 'node'
      scrape_interval: 8s
      static_configs:
      - targets: ['127.0.0.1:9100', '127.0.0.12:9100']

    - job_name: 'mysqld'
      static_configs:
      - targets: ['127.0.0.1:9104']

    - job_name: 'memcached'
      static_configs:
      - targets: ['127.0.0.1:9150']
alerting:
  alertmanagers:
  - scheme: https
    static_configs:
    - targets:
      - "1.2.3.4:9093"
      - "1.2.3.5:9093"
      - "1.2.3.6:9093"
```

## 查询

* 提供了内置的PromQL，用户可以实时的查询和聚合时序数据，计算结果可以通过Expression Browser、Grafana展示，也可以通过HTTP API请求获取
* 结果有4种类型
    - Instant vector: 即时向量，同一时间点的一组时序数据
    - Range vector: 范围向量，一个时间段内的一组时序数据
    - Scalar: 标量，一个浮点数值
    - String: 一个字符串，目前未使用
* 查询
    - 查询http_requests_total所有数据: http_requests_total
    - 条件查询
        + =: 等于条件，例如 http_requests_total{environment="test",method="Get"}
        + !=: 不等于条件，例如 http_requests_total{environment!=”test”}
        + =~: 匹配正则表达式条件，例如 http_requests_total{environment=~”t.”}
        + !~: 不匹配正则表达式条件，例如 http_requests_total{environment!=~”t.”}
    - 模糊查询
        + 查询http_requests_total environment label值匹配`t.*`正则的时序数据  http_requests_total{environment=~"t.*"}
        + 查询http_requests_total environment label值不匹配`t.*`正则的时序数据 http_requests_total{environment!~"t.*"}
    - 区间查询
        + http_requests_total{environment="test", method="Get"}[10s]
        + s: 秒 m: 分 h: 时 d: 天 w: 周 y: 年
    - 聚合查询： Prometheus内置支持以下几种类型的聚合函数，用于即时向量聚合操作
        + sum: 求和 sum(http_requests_total){environment="test"}
        + min: 求最小值
        + max: 求最大值
        + avg: 求平均值
        + stddev: 求标准差
        + stdvar: 求标准差异
        + count: 计数 count(http_requests_total{environment="test"})
        + count_values: 相同数据值计数 count_values("total_request",http_requests_total{environment="test"})
        + bottomk: 最小k个数
        + topk: 最大k个数 topk(3, http_requests_total)
        + quantile: 分布统计
    - 函数计算
        + rate(range vector): 用于计算过去一段时间每秒平均值，取指定时间范围内所有数据点，算出一组速率，然后取平均值作为结果。仅适用于counter类型数据，适合缓慢变化的数据分析。`sum(rate(http_requests_total{environment="release"}[2m]))`
        + irate(range vector): 用于计算过去一段时间每秒平均值，取指定时间范围内最近两个数据点来算速率，然后作为结果。仅适用于counter类型数据，适合快速变化的数据分析。 `sum(rate(http_requests_total{environment="release"}[2m])) by (method)`

## Storage

* 支持把时序数据存储在本地存储和远程存储介质
* 本地存储:每2个小时数据放在同一个block，一个block包含一个或多个chunk文件，当前block数据是在内存里面 这里存在一个问题: 如果当前2个小时数据很多，会导致Prometheus server服务性能变差，在Grafana上查询的时候会很慢很卡

## 监控K8S

* Prometheus和Kubernets都属于CNCF成员项目，推荐使用Prometheus来监控Kubernets集群。传统的监控系统需要集群所有服务器将监控数据发往监控系统，Prometheus则可以通过服务发现来发现K8s集群内部已经暴露的监控点，然后主动拉取数据。
* 只需要在K8s集群中部署一份Prometheus实例，它就可以通过向Apiserver查询集群状态，然后向所有已经支持Prometheus metrics的kubelet 获取所有Pod的运行数据。这种动态发现的架构，非常适合服务器和程序都不固定的K8s集群环境。
* Prometheus和K8s集成目前支持5种服务发现的模式
    - Node 从K8s集群各节点kubelet组件，获取节点kubelet的基本运行状态的监控指标 从K8s集群各节点kubelet内置的cAdvisor，获取节点中运行的容器的监控指标 从K8s集群各节点Node Exporter，获取节点运行资源相关的监控指标
    - Pod 从Pod实例中采集业务应用自定义监控指标
    - Endpoints 从K8s集群API Server组件，获取K8s集群相关的运行监控指标
    - Service 从K8s集群Service的访问地址，通过Blackbox Exporter获取网络探测指标
    - Ingress 从K8s集群Ingress的访问信息，通过Blackbox Exporter获取网络探测指标
* 配置
    - __address__ label将会被设置为instance
    - __meta__开头的label是由Prometheus服务发现设置的，在relabel过程都可以使用
    - relabel结束后__开头的所有label都会被删除
    - role: 服务发现的模式
    - ca_file: CA证书路径
    - tls_config: SSL/TLS配置
    - bearer_token_file: token文件路径
    - kubernetes_sd_configs: 服务发现配置
    - relabel_configs: labels重写配置，比较重要的配置
* 部署K8s prometheus configmap
    - 创建kube-prometheus ns:`kubectl create namespace kube-prometheus`
    - 创建configmap:`kubectl apply -f prometheus-configmap-v1.0.0.yml`
    - 查看configmap:`kubectl get cm -n kube-prometheus`
* 把Prometheus Deployment相关的Pod抽象成Service，方便其它Pod访问，同时为了外网也能够访问Prometheus服务我们在Service之上加一层Ingress。
    - Service配置文件详解
        + metadata.name: service名称为prometheus-service
        + spec.selector: 选择label为app=prometheus-deployment相关的Pod
        + spec.ports.port: 开放9090端口，默认和targetPort一样
        + spec.ports.targetPort: 后端Prometheus Pod对应的端口为9090
    - Ingress配置文件详解
        + metadata.name: ingress名称为prometheus-ingress
        + spec.rules.host: k8s.prometheus.com 配置访问域名 (需要本地配置hosts绑定到nginx-ingress-controller任一节点上)
        + spec.rules.http.paths.backend.serviceName: 后端对应的service名称
        + spec.rules.http.paths.backend.servicePort: 后端对应的service端口
    - 部署Service和Ingress
        + kubectl apply -f prometheus-service-v1.0.0.yml
    - 直接访问http://k8s.prometheus.com/graph即可访问Prometheus web UI界面

```yaml
# prometheus-kubernetes.yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: prometheus-config-v1.0.0
  namespace: kube-prometheus
  labels:
    k8s-app: prometheus-config
data:
  prometheus.yml: |
    global:
      # 数据拉取时间间隔，默认15s
      scrape_interval: 15s
      # 数据拉取超时时间，默认15s
      scrape_timeout: 15s

    scrape_configs:
    # Scrape config for prometheus
    - job_name: 'prometheus'
      static_configs:
        - targets: ['localhost:9090']

    # Scrape config for API servers
    - job_name: 'kubernetes-apiservers'
      scheme: https
      tls_config:
        ca_file: /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
      bearer_token_file: /var/run/secrets/kubernetes.io/serviceaccount/token
      kubernetes_sd_configs:
      - role: endpoints
      relabel_configs:
      - source_labels: [__meta_kubernetes_namespace, __meta_kubernetes_service_name, __meta_kubernetes_endpoint_port_name]
        action: keep
        regex: default;kubernetes;https

    # Scrape config for nodes (kubelet)
    - job_name: 'kubernetes-nodes'
      scrape_interval: 30s
      scrape_timeout: 10s
      metrics_path: /metrics
      scheme: https
      tls_config:
        ca_file: /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
      bearer_token_file: /var/run/secrets/kubernetes.io/serviceaccount/token
      kubernetes_sd_configs:
      - api_server: https://localhost:6443
        role: node
        tls_config:
          cert_file: /etc/kubernetes/ssl/xxxx.pem   #根据实际做替换
          key_file: /etc/kubernetes/ssl/xxxx.pem    #根据实际做替换
          insecure_skip_verify: true
      relabel_configs:
      - separator: ;
        regex: __meta_kubernetes_node_label_(.+)
        replacement: $1
        action: labelmap
      - separator: ;
        regex: (.*)
        target_label: __address__
        replacement: pre.kubernetes.m.com:6443
        action: replace
      - source_labels: [__meta_kubernetes_node_name]
        separator: ;
        regex: (.+)
        target_label: __metrics_path__
        replacement: /api/v1/nodes/${1}/proxy/metrics
        action: replace

    # Scrape config for Kubelet cAdvisor
    - job_name: kubernetes-cadvisor
      scrape_interval: 30s
      scrape_timeout: 10s
      metrics_path: /metrics
      scheme: http
      kubernetes_sd_configs:
      - api_server: https://localhost:6443
        role: node
        tls_config:
          cert_file: /etc/kubernetes/ssl/xxxx.pem     #根据实际做替换
          key_file: /etc/kubernetes/ssl/xxxx-key.pem  #根据实际做替换
          insecure_skip_verify: true
      tls_config:
        cert_file: /etc/kubernetes/ssl/xxxx.pem   #根据实际做替换
        key_file: /etc/kubernetes/ssl/xxxx.pem    #根据实际做替换
        insecure_skip_verify: true
      relabel_configs:
      - source_labels: [__address__]
        separator: ;
        regex: (.*):10250
        target_label: __address__
        replacement: ${1}:4194
        action: replace
      - source_labels: [__meta_kubernetes_node_address_InternalIP]
        separator: ;
        regex: (.*)
        target_label: ip
        replacement: $1
        action: replace

    # Scrape config for service endpoints
    - job_name: kubernetes-service-endpoints
      scrape_interval: 30s
      scrape_timeout: 10s
      metrics_path: /metrics
      scheme: http
      kubernetes_sd_configs:
      - api_server: https://localhost:6443
        role: endpoints
        tls_config:
          cert_file: /etc/kubernetes/ssl/xxxx.pem     #根据实际做替换
          key_file: /etc/kubernetes/ssl/xxxx.pem      #根据实际做替换
          insecure_skip_verify: true
      tls_config:
        cert_file: /etc/kubernetes/ssl/xxxx.pem     #根据实际做替换
        key_file: /etc/kubernetes/ssl/xxxx.pem      #根据实际做替换
        insecure_skip_verify: true
      relabel_configs:
      - source_labels: [__meta_kubernetes_service_annotation_prometheus_io_scrape]
        separator: ;
        regex: "true"
        replacement: $1
        action: keep
      - source_labels: [__meta_kubernetes_service_annotation_prometheus_io_scheme]
        separator: ;
        regex: (https?)
        target_label: __scheme__
        replacement: $1
        action: replace
      - source_labels: [__meta_kubernetes_service_annotation_prometheus_io_path]
        separator: ;
        regex: (.+)
        target_label: __metrics_path__
        replacement: $1
        action: replace
      - source_labels: [__address__, __meta_kubernetes_service_annotation_prometheus_io_port]
        separator: ;
        regex: ([^:]+)(?::\d+)?;(\d+)
        target_label: __address__
        replacement: $1:$2
        action: replace
      - separator: ;
        regex: __meta_kubernetes_service_label_prometheus_(.+)
        replacement: $1
        action: labelmap
      - separator: ;
        regex: prometheus_(.+)
        replacement: $1
        action: labelmap
      - source_labels: [__meta_kubernetes_namespace]
        separator: ;
        regex: (.*)
        target_label: namespace
        replacement: $1
        action: replace

    # Scrape config for probing services via the Blackbox Exporter
    - job_name: 'kubernetes-services'
      metrics_path: /probe
      params:
        module: [http_2xx]
      kubernetes_sd_configs:
      - role: service
      relabel_configs:
      - source_labels: [__meta_kubernetes_service_annotation_prometheus_io_probe]
        action: keep
        regex: true
      - source_labels: [__address__]
        target_label: __param_target
      - target_label: __address__
        replacement: blackbox
      - source_labels: [__param_target]
        target_label: instance
      - action: labelmap
        regex: __meta_kubernetes_service_label_(.+)
      - source_labels: [__meta_kubernetes_service_namespace]
        target_label: kubernetes_namespace
      - source_labels: [__meta_kubernetes_service_name]
        target_label: kubernetes_name

    # Scrape config for Pod
    - job_name: kubernetes-pods
      scrape_interval: 30s
      scrape_timeout: 10s
      metrics_path: /metrics
      scheme: http
      kubernetes_sd_configs:
      - api_server: https://localhost:6443
        role: pod
        tls_config:
          cert_file: /etc/kubernetes/ssl/xxxx.pem
          key_file: /etc/kubernetes/ssl/xxxx.pem
          insecure_skip_verify: true
      tls_config:
        cert_file: /etc/kubernetes/ssl/xxxx.pem
        key_file: /etc/kubernetes/ssl/xxxx.pem
        insecure_skip_verify: true
      relabel_configs:
      - source_labels: [__meta_kubernetes_pod_annotation_prometheus_io_scrape]
        separator: ;
        regex: "true"
        replacement: $1
        action: keep
      - source_labels: [__meta_kubernetes_pod_annotation_prometheus_io_scheme]
        separator: ;
        regex: (https?)
        target_label: __scheme__
        replacement: $1
        action: replace
      - source_labels: [__meta_kubernetes_pod_annotation_prometheus_io_path]
        separator: ;
        regex: (.+)
        target_label: __metrics_path__
        replacement: $1
        action: replace
      - source_labels: [__address__, __meta_kubernetes_pod_annotation_prometheus_io_port]
        separator: ;
        regex: ([^:]+)(?::\d+)?;(\d+)
        target_label: __address__
        replacement: $1:$2
        action: replace
      - separator: ;
        regex: __meta_kubernetes_pod_label_(.+)
        replacement: $1
        action: labelmap
      - source_labels: [__meta_kubernetes_namespace]
        separator: ;
        regex: (.*)
        target_label: kubernetes_namespace
        replacement: $1
        action: replace
      - source_labels: [__meta_kubernetes_pod_name]
        separator: ;
        regex: (.*)
        target_label: kubernetes_pod_name
        replacement: $1
        action: replace
      - separator: ;
        regex: prometheus_(.+)
        replacement: $1
        action: labelmap

# prometheus-service-v1.0.0.yml
apiVersion: v1
kind: Service
metadata:
  name: prometheus-service
  namespace: kube-prometheus
  labels:
    k8s-app: prometheus-service
spec:
  selector:
    app: prometheus-deployment
  ports:
    - protocol: TCP
      port: 9090
      targetPort: 9090

---
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: prometheus-ingress
  namespace: kube-prometheus
  labels:
    k8s-app: prometheus-ingress
spec:
  rules:
  - host: k8s.prometheus.com
    http:
      paths:
      - path: /
        backend:
          serviceName: prometheus-service
          servicePort: 9090
```

## exporter

* 服务状态：Status->Targets

```sh
wget https://github.com/prometheus/node_exporter/releases/download/v0.14.0/node_exporter-0.14.0.linux-amd64.tar.gz
tar xvf node_exporter-0.14.0.linux-amd64.tar.gz /usr/local/
nohup /usr/local/node_exporter-0.14.0.linux-amd64/node_exporter &

wget https://github.com/prometheus/mysqld_exporter/releases/download/v0.10.0/mysqld_exporter-0.10.0.linux-amd64.tar.gz
tar xvf mysqld_exporter-0.10.0.linux-amd64.tar.gz /usr/local/

GRANT REPLICATION CLIENT,PROCESS ON *.* TO 'mysql_monitor'@'localhost' identified by 'mysql_monitor';
GRANT SELECT ON *.* TO 'mysql_monitor'@'localhost';

# /usr/local/mysqld_exporter-0.10.0.linux-amd64/.my.cnf
[client]
user=mysql_monitor
password=mysql_monitor

nohup /usr/local/mysqld_exporter-0.10.0.linux-amd64/mysqld_exporter --config.my-cnf="/usr/local/mysqld_exporter-0.10.0.linux-amd64/.my.cnf" &
./mysqld_exporter --config.my-cnf=/usr/local/prometheus-2.17.2.linux-amd64/exporters/mysqld_exporter-0.12.1.linux-amd64/.my.conf

# /etc/systemd/system/mysql_exporter.service
[Unit]
Description=mysql Monitoring System
Documentation=mysql Monitoring System

[Service]
ExecStart=/opt/mysqld_exporter-0.10.0.linux-amd64/mysqld_exporter \
         -collect.info_schema.processlist \
         -collect.info_schema.innodb_tablespaces \
         -collect.info_schema.innodb_metrics  \
         -collect.perf_schema.tableiowaits \
         -collect.perf_schema.indexiowaits \
         -collect.perf_schema.tablelocks \
         -collect.engine_innodb_status \
         -collect.perf_schema.file_events \
         -collect.info_schema.processlist \
         -collect.binlog_size \
         -collect.info_schema.clientstats \
         -collect.perf_schema.eventswaits \
         -config.my-cnf=/opt/mysqld_exporter-0.10.0.linux-amd64/.my.cnf

[Install]
WantedBy=multi-user.target
```

## 工具

* [improbable-eng/thanos](https://github.com/improbable-eng/thanos):Highly available Prometheus setup with long term storage capabilities.
* [coreos/prometheus-operator](https://github.com/coreos/prometheus-operator):Prometheus Operator creates/configures/manages Prometheus clusters atop Kubernetes
* [ cortexproject / cortex ](https://github.com/cortexproject/cortex):A horizontally scalable, highly available, multi-tenant, long term Prometheus. https://cortexmetrics.io/

## 参考

* [yunlzheng/prometheus-book](https://github.com/yunlzheng/prometheus-book):Prometheus操作指南  <https://yunlzheng.gitbook.io/prometheus-book/>
* [Prometheus 中文文档](https://fuckcloudnative.io/prometheus/)
* [Prometheus 入门与实践](https://www.ibm.com/developerworks/cn/cloud/library/cl-lo-prometheus-getting-started-and-practice/index.html)
