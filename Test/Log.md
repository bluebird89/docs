# log

## 原理

* 写日志方式，文件
* 分类
* 控制开关

## ELK(ElasticSearch, Logstash, Kibana)


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
wget   搭建nginx之前需要安装 pcre
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
       listen       80;
       server_name  localhost;

       #charset koi8-r;

       #access_log  logs/host.access.log  main;

       location / {
           root   html;
           index  index.html index.htm;
       }

       #error_page  404              /404.html;

       # redirect server error pages to the static page /50x.html
       #
       error_page   500 502 503 504  /50x.html;
       location = /50x.html {
           root   html;
       }

       # proxy the PHP scripts to Apache listening on 127.0.0.1:80
       #
       #location ~ \.php$ {
       #    proxy_pass   http://127.0.0.1;
       #}

       # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
       #
       #location ~ \.php$ {
       #    root           html;
       #    fastcgi_pass   127.0.0.1:9000;
       #    fastcgi_index  index.php;
       #    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
       #    include        fastcgi_params;
       #}

       # deny access to .htaccess files, if Apache's document root
       # concurs with nginx's one
       #
       #location ~ /\.ht {
       #    deny  all;
       #}
   }



   # another virtual host using mix of IP-, name-, and port-based configuration
   #
   #server {
   #    listen       8000;
   #    listen       somename:8080;
   #    server_name  somename  alias  another.alias;

   #    location / {
   #        root   html;
   #        index  index.html index.htm;
   #    }
   #}


   # HTTPS server
   #
   #server {
   #    listen       443 ssl;
   #    server_name  localhost;

   #    ssl_certificate      cert.pem;
   #    ssl_certificate_key  cert.key;

   #    ssl_session_cache    shared:SSL:1m;
   #    ssl_session_timeout  5m;

   #    ssl_ciphers  HIGH:!aNULL:!MD5;
   #    ssl_prefer_server_ciphers  on;

   #    location / {
   #        root   html;
   #        index  index.html index.htm;
   #    }
   #}

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
              codec => "json"  json编码
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
vim ./config/kibana.yml

elasticsearch.url: #   只需要修改URL为ElasticSearch的IP地址
./kibana& 后台启动
# 启动成功以后 会监听 5601端口

# 可以用Kibana查看 地址 : 192.168.88.250:5601
# create灰色的 说明没有创建索引  打开你的nginx服务器 刷新几下 采集一下数据 然后  选择 左上角的 Discover
# 数据可能会出不来 那是因为 Kibana 是根据时间来匹配的 并且 因为 Logstash的采集时间使用的UTC  永远早8个小时 所以设置时间 要设置晚8个小时以后
```

## 工具

* [Graylog2/graylog2-server](https://github.com/Graylog2/graylog2-server):Free and open source log management https://www.graylog.org/
* [klaussinani/signale](https://github.com/klaussinani/signale):👋 Hackable console logger
