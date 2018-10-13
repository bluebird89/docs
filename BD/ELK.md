# ELK(Elasticsearch ,Logstash和Kibana)

* 标准化:
    - 路径规划: /data/logs/,/data/logs/access,/data/logs/error,/data/logs/run
    - 格式要求: 严格要求使用json
    - 命名规则: access_log error_log runtime_log system_log
    - 日志切割: 按天，按小时。访问,错误，程序日志按小时，系统日志按天收集。
    - 原始文本: rsync推送NAS，后删除最近三天前。
    - 消息队列: 访问日志,写入Redis_DB6，错误日志Redis_DB7,程序日志Redis_DB8
* 工具化:
    - 访问日志  Apache、Nginx、Tomcat       (使用file插件)
    - 错误日志  java日志、异常日志          (使用mulitline多行插件)
    - 系统日志  /var/log/*、rsyslog         (使用syslog)
    - 运行日志  程序写入的日志文件          (可使用file插件或json插件)
    - 网络日志  防火墙、交换机、路由器      (syslog插件)
* 集群化:
    - 每台ES上面都启动一个Kibana
    - Kibana都连自己的ES
    - 前端Nginx负载均衡+验证,代理至后端Kibana
    - 通过消息队列来实现程序解耦以及高可用等扩展
* 监控化:
    - 对ES以及Kibana、进行监控。如果服务DOWN及时处理。
    - 使用Redis的list作为ELKstack消息队列。
    - Redis的List Key长度进行监控(llen key_name)。例:超过"10万"即报警(根据实际情况以及业务情况)
* 迭代化:
    - 开源日志分析平台:ELK、EFK、EHK
    - 数据收集处理:Flume、heka
    - 消息队列:Redis、Rabbitmq、Kafka、Hadoop、webhdfs
