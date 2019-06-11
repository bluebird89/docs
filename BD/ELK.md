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

## 安装

* Logstash:采集数据导入
* Elasticsearch:存储数据
* Kibana:数据的展示

```sh
# JDK  放在路径/usr/local/java 编辑配置文件 /etc/profile
export JAVA_HOME=/usr/local/java/jdk1.8.0_77
export PATH=$JAVA_HOME/bin:$PATH
java -version

# 搭建 ElasticSearch
wget https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/2.1.0/elasticsearch-2.1.0.tar.gz
tar xf elasticsearch-2.1.0.tar.gz
cd /usr/local/elasticsearch-2.1.0/bin
./plugin  -install mobz/elasticsearch-head  # web集群管理插件  安装好了以后可以在plugin文件发现多了一个head
./elasticsearch  -Des.insecure.allow.root=true  #加这个参数才可以root启动

curl -X GET 192.168.88.250:9200   #curl 测试
{
 "name" : "Reeva Payge",
 "cluster_name" : "elasticsearch",
 "version" : {
   "number" : "2.1.0",
   "build_hash" : "72cd1f1a3eee09505e036106146dc1949dc5dc87",
   "build_timestamp" : "2015-11-18T22:40:03Z",
   "build_snapshot" : false,
   "lucene_version" : "5.3.1"
 },
 "tagline" : "You Know, for Search"
}
# web地址  http://192.168.88.250:9200/_plugin/head/

# nginx
# 搭建nginx之前需要安装 pcre
tar xf nginx-1.7.8.tar.gz
cd /usr/local/nginx
vim /usr/local/nginx/conf/nginx.conf

#user  nobody;
worker_processes  1;

#error_log  logs/error.log  notice;
#error_log  logs/error.log  info;

#pid        logs/nginx.pid;

events {
  worker_connections  1024;
}

http {

    upstream kibana4 {  #对Kibana做代理
           server 127.0.0.1:5601 fail_timeout=0;
    }
   include       mime.types;
   default_type  application/octet-stream;

   #log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
   #                  '$status $body_bytes_sent "$http_referer" '
   #                  '"$http_user_agent" "$http_x_forwarded_for"';

    log_format json '{"@timestamp":"$time_iso8601",'   #配置NGINX的日志格式 json
                       '"host":"$server_addr",'
                       '"clientip":"$remote_addr",'
                       '"size":$body_bytes_sent,'
                       '"responsetime":$request_time,'
                       '"upstreamtime":"$upstream_response_time",'
                       '"upstreamhost":"$upstream_addr",'
                       '"http_host":"$host",'
                       '"url":"$uri",'
                       '"xff":"$http_x_forwarded_for",'
                       '"referer":"$http_referer",'
                       '"agent":"$http_user_agent",'
                       '"status":"$status"}';
    access_log /var/log/nginx/access.log_json json;   #配置日志路径 json格式
    error_log /var/log/nginx/error.log;

   sendfile        on;
   #tcp_nopush     on;

   #keepalive_timeout  0;
   keepalive_timeout  65;

   #gzip  on;

server {
   listen               *:80;
   server_name          kibana_server;
   access_log           /var/log/nginx/kibana.srv-log-dev.log;
   error_log            /var/log/nginx/kibana.srv-log-dev.error.log;

   location / {
       root   /var/www/kibana;
       index  index.html  index.htm;
   }

   location ~ ^/kibana4/.* {
       proxy_pass           http://kibana4;
       rewrite             ^/kibana4/(.*)  /$1 break;
       proxy_set_header     X-Forwarded-For $proxy_add_x_forwarded_for;
       proxy_set_header     Host            $host;
       auth_basic           "Restricted";
       auth_basic_user_file /etc/nginx/conf.d/kibana.myhost.org.htpasswd;
   }

}
}

## 搭建 Logstash
wget https://download.elastic.co/logstash/logstash/logstash-2.1.1.tar.gz
tar xf logstash-2.1.1.tar.gz
cd /usr/local/logstash-2.1.1/bin
vim stdin.conf #编写配置文件
input{
       file {
               path => "/var/log/nginx/access.log_json"  #NGINX日志地址 json格式
              codec => "json"  # json编码
       }
}
filter {
       mutate {
               split => ["upstreamtime", ","]
       }
       mutate {
               convert => ["upstreamtime", "float"]
       }
}
output{
       elasticsearch {
               hosts => ["192.168.88.250:9200"]   #elasticsearch地址
               index => "logstash-%{type}-%{+YYYY.MM.dd}"   #索引
               document_type => "%{type}"
               workers => 1
               flush_size => 20000        #传输数量 默认500
               idle_flush_time => 10      #传输秒数  默认1秒
               template_overwrite => true
       }
}
./logstash -f stdin.conf &  #后台启动
# 启动成功以后 打开刚才搭建的web服务器  es就能看到数据

# 搭建Kibana
wget https://download.elastic.co/kibana/kibana/kibana-4.3.1-linux-x64.tar.gz
tar xf kibana-4.3.1-linux-x64.tar.gz
cd /usr/local/kibana-4.3.1-linux-x64/

# ./config/kibana.yml
elasticsearch.url: #   只需要修改URL为ElasticSearch的IP地址

./kibana& # 后台启动
# 启动成功以后 会监听 5601端口

# 可以用Kibana查看 地址 : 192.168.88.250:5601
# create灰色的 说明没有创建索引  打开你的nginx服务器 刷新几下 采集一下数据 然后  选择 左上角的 Discover
# 数据可能会出不来 那是因为 Kibana 是根据时间来匹配的 并且 因为 Logstash的采集时间使用的UTC  永远早8个小时 所以设置时间 要设置晚8个小时以后


echo "kibanaadmin:`openssl passwd -apr1`" | sudo tee -a /etc/nginx/htpasswd.users
kibanaadmin:$apr1$M2kx248q$TRbbkejn8bxFsdztudF6Z0

brew install elasticsearch # http://localhost:9200
brew install logstash # http://localhost:9600

# logstash-sample.conf
input { stdin { } }
output {
  elasticsearch { hosts => ["localhost:9200"]  index => "my_blog"
        user => "elastic"
        password => "json"
  }
  stdout { codec => rubydebug }
}

./bin/logstash -f logstash-sample.conf

wget https://artifacts.elastic.co/downloads/kibana/kibana-7.1.1-darwin-x86_64.tar.gz # http://localhost:5601
```

## metrics

* logstash:日志收集、分析、过滤。部署在客户端比较重
* 轻量级的filebeat

```sh
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.1.1-darwin-x86_64.tar.gz
tar xzvf filebeat-7.1.1-darwin-x86_64.tar.gz
cd filebeat-7.1.1-darwin-x86_64/

# filebeat.yml
Copy snippet
output.elasticsearch:
  hosts: ["<es_url>"]
  username: "elastic"
  password: "<password>"
setup.kibana:
  host: "<kibana_url>"
./filebeat modules enable redis

./filebeat setup
./filebeat -e # ./filebeat -e -c /home/elk/filebeat/filebeat.yml

```

## 图书

* [ELK Stack权威指南](http://product.china-pub.com/64005)

## 参考

* [Kibana User Guide](https://www.elastic.co/guide/en/kibana/current/index.html)
