# Nginx

NGINX Application Platform.

- NGINX Plus，流行的开源 NGINX Web 服务器的商业版本。
- NGINX Web 应用防火墙（WAF）。
- NGINX Unit，可运行 PHP、Python 和 Go 的新型开源应用服务器。
- NGINX Controller NGINX Plus 的中央控制面板 ![](../_static/nignx.png)

# 配置

## main（全局设置）

PHP7默认的用户和组是www-data

这部分的指令将会影响其他部分的设置

- worker_processes 2 在配置文件的顶级main部分，worker角色的工作进程的个数，master进程是接收并分配给worker处理。一般情况下这个值可以设置为CPU的核数，如果开启了ssl和gzip一般设置为CPU数量的2倍，可以减少I/O操作。如果Nginx服务器还有其它服务，可以考虑适当减少。
- worker_connections 2048 这个写在events部分，每一个worker进程能并发处理（发起）的最大连接数。Nginx作为反向代理服务器，计算公式最大连接数 = worker_processes * worker_connections / 4，所以这里客户端最大连接数是1024，这个可以增到8192，但不能超过worker_rlimit_nofile。当Nginx作为http服务器时，计算公式里面是除以2.
- worker rlimit nofile 10240 写在main部分，默认没有设置，可以限制为操作系统最大的限制65535。
- use epoll 写在events部分，在Linux操作系统下，Nginx默认使用epoll事件模型，得益于此，Nginx在Linux操作系统下效率相当高。同时Nginx在OpenBSD或FreeBSD操作系统上采用类似于epoll的高效事件模型kqueue。

## http（服务器设置）

提供http服务相关的一些配置参数，如：是否使用keepalive，是否使用gzip进行压缩

- sendfile on 开启高效文件传输模式，sendfile指令指定Nginx是否调用sendfile函数来输出文件，减少用户空间到内核空间的上下文切换。对于普通应用设为on，如果用来进行下载等磁盘IO重负载应用，可设置为off，以平衡磁盘与网络I/O处理速度，降低系统的负载。
- keepalive_timeout 65 长连接超时时间，单位是秒，涉及到浏览器的种类、后端服务器的超时设置、操作系统的设置，相对比较敏感。
- send_timeout 指定相应客户端的超时时间，这个超时仅限于两个连接活动之间的时间，如果超过这个时间，客户端没有任何活动，Nginx将会关系连接。
- client max body_ size 10m 允许客户端请求的最大单文件字节数，一般在上传较大文件时设置限制值
- client body buffer_ size 128k 缓冲区代理缓冲用户用户端请求的最大字节数

  ### server（主机设置）

  http服务上支持若干虚拟主机，每个虚拟主机对应一个server配置项

- listen 监听端口，Mac下默认为8080，小于1024的要以root启动。可以为listen:*:8080、listen:127.0.0.1:8080等形式

- server_name 服务器名，如localhost、www.jd.com，可以通过正则匹配

- location（URL匹配特定位置配置） http服务中，某些特定的URL对应的一系列配置项

- root html 定义服务器的默认网站根目录。如果locationURL匹配的是子目录或文件，root没什么作用，一般放在server指令里面或/下。

- index index.php index.shtml index.html index.htm 定义路径下默认访问的文件名，一般跟着root放

下面提供一份相对简单的配置文件示例：

```
user www www;
worker_processes 2;
error_log logs/error.log;
pid logs/nginx.pid;
events {
  use epoll;
  worker_connections 2048;
}
# http服务器设置
http {
    upstream phpbackend { 
        server unix:/var/run/php5-fpm.sock1 weight=100 max_fails=5 fail_timeout=5; 
        server unix:/var/run/php5-fpm.sock2 weight=100 max_fails=5 fail_timeout=5; 
        server unix:/var/run/php5-fpm.sock3 weight=100 max_fails=5 fail_timeout=5; 
        server unix:/var/run/php5-fpm.sock4 weight=100 max_fails=5 fail_timeout=5; 
    }
    # Stop Displaying Server Version in Configuration
    server_tokens off;

    # Let NGINX get the real client IP for its access logs
    set_real_ip_from 127.0.0.1;
    real_ip_header X-Forwarded-For;


  # 文件扩展名与文件类型映射表
  include mime.types;
  # 设定默认文件类型
  default_type application/octet-stream;
    
    # 为Nginx服务器设置详细的日志格式
    log_format  main    '$remote_addr - $remote_user [$time_local] "$request" '
                        '$status $body_bytes_sent "$http_referer" '
                        '"$http_user_agent" "$http_x_forwarded_for"';  

    access_log      /usr/local/var/log/nginx/access.log main;
      # 开启高效文件传输模式，sendfile指令指定nginx是否调用sendfile函数来输出文件，对于普通应用设为 on，如果用来进行下载等应用磁盘IO重负载应用，可设置为off，以平衡磁盘与网络I/O处理速度，降低系统的负载。注意：如果图片显示不正常把这个改成off。
      sendfile on;

  keepalive_timeout 65;
     include /usr/local/etc/nginx/conf.d/*.conf;
    # Gzip Settings
    gzip on;
    gzip_static on;
    gzip_disable "msie6";
    gzip_vary on;
    gzip_proxied any;
    gzip_comp_level 6;
    gzip_min_length 1100;
    gzip_buffers 16 8k;
    gzip_http_version 1.1;
    gzip_types text/css text/javascript text/xml text/plain text/x-component 
    application/javascript application/x-javascript application/json 
    application/xml  application/rss+xml font/truetype application/x-font-ttf 
    font/opentype application/vnd.ms-fontobject image/svg+xml;

    # Cache
    open_file_cache max=200000 inactive=20s; 
    open_file_cache_valid 30s; 
    open_file_cache_min_uses 2; 
    open_file_cache_errors on;


    # Client Timeouts
    client_max_body_size 500M; 
    client_body_buffer_size 1m; 
    client_body_timeout 15; 
    client_header_timeout 15; 
    keepalive_timeout 2 2; 
    send_timeout 15; 
    sendfile on; 
    tcp_nopush on; 
    tcp_nodelay on;


  # server主机配置
  server {
    listen 8080;  #监听端口号
    server_name localhost;  #主机名
    root /Users/www/test/; # 该项要修改为你准备存放相关网页的路径
    # 定义路径下默认访问的文件名
    index index.php;
    charset utf-8;
    access_log logs/host.access.log main;

    ssl_client_certificate  /etc/ssl/nginx/intermediate.crt;
    ssl_certificate  /etc/ssl/nginx/certificate.crt;
    ssl_certificate_key  /etc/ssl/nginx/private.key;

    # location 配置
    location / {
      root   html;
      index  index.php index.shtml index.html index.htm;
      # 打开目录浏览功能，可以列出整个目录
      autoindex on;
    }       

    error_page 500 502 503 504 /50x.html;
    location = /50x.html {
      root html;
    }
    #proxy the php scripts to php-fpm
    location ~ \.php$ {
        # fastcgi配置
        include /usr/local/etc/nginx/fastcgi.conf;
        # 指定是否传递4xx和5xx错误信息到客户端
        fastcgi_intercept_errors on;
        # 指定FastCGI服务器监听端口与地址，可以是本机或者其它
        fastcgi_pass   127.0.0.1:9000;
    }
}

server {
  listen       80;
  server_name  localhost;
  #access_log  logs/host.access.log  main;
  location / {
      root   html;
      index  index.html index.htm;
  }
}
```

## Mac

- brew install nginx
- 程序文件 /usr/local/etc/nginx/
- 安装路径 /usr/local/Cellar/nginx
- 日志与服务器文件/usr/local/var

## 模块

- NGINX Plus 由 Web 服务器、内容缓存和负载均衡器组成。NGINX Web 应用程序防火墙（WAF）是一款基于开源 ModSecurity 研发的商业软件，为针对七层的攻击提供保护，例如 SQL 注入或跨站脚本攻击，并根据如 IP 地址或者报头之类的规则阻止或放行， NGNX WAF 作为 NGINX Plus 的动态模块运行，部署在网络的边缘，以保护内部的 Web 服务和应用程序免受 DDoS 攻击和骇客入侵。
- NGINX Unit 是 Igor Sysoev 设计的新型开源应用服务器，由核心 NGINX 软件开发团队实施。Unit 是"完全动态的"，并允许以蓝绿部署的方式无缝重启新版本的应用程序，而无需重启任何进程。所有的 Unit 配置都通过使用 JSON 配置语法的内置 REST API 进行处理，并没有配置文件。目前 Unit 可运行由最近版本的 PHP、Python 和 Go 编写的代码。在同一台服务器上可以支持多语言的不同版本混合运行。即将推出更多语言的支持，包括 Java 和 Node.JS。
- NGINX Controller 是 NGINX Plus 的中央集中式监控和管理平台。Controller 充当控制面板，并允许用户通过使用图形用户界面"在单一位置管理数百个 NGINX Plus 服务器"。该界面可以创建 NGINX Plus 服务器的新实例，并实现负载平衡、 URL 路由和 SSL 终端的中央集中配置。Controller 还具备监控功能，可观察应用程序的健壮性和性能。
- 新发布的 NGINX Plus（Kubernetes）Ingress Controller 解决方案基于开源的 NGINX kubernetes-ingress 项目，经过测试、认证和支持，为 Red Hat OpenShift 容器平台提供负载平衡。该解决方案增加了对 NGINX Plus 中高级功能的支持，包括高级负载平衡算法、第7层路由、端到端认证、request/rate 限制以及内容缓存和 Web 服务器。
- NGINX 还发布了 nginmesh，这是 NGINX 的开源预览版本，作为 Istio Service Mesh 平台中第7层负载平衡和代理的服务代理。它旨在作为挎斗容器（sidecar container）时，能提供与 Istio 集成的关键功能，并以"标准、可靠和安全的方式"促进服务之间的通信能力。此外，NGINX 将通过加入 Istio 网络特别兴趣小组，与 Istio 社区合作。

## Server 配置

```
location  = / {
  # matches the query / only.
  [ configuration A ]
}
location  / {
  # matches any query, since all queries begin with /, but regular
  # expressions and any longer conventional blocks will be
  # matched first.
  [ configuration B ]
}
location /documents/ {
  # matches any query beginning with /documents/ and continues searching,
  # so regular expressions will be checked. This will be matched only if
  # regular expressions don't find a match.
  [ configuration C ]
}
location ^~ /images/ {
  # matches any query beginning with /images/ and halts searching,
  # so regular expressions will not be checked.
  [ configuration D ]
}
location ~* \.(gif|jpg|jpeg)$ {
  # matches any request ending in gif, jpg, or jpeg. However, all
  # requests to the /images/ directory will be handled by
  # Configuration D.
  [ configuration E ]
}
```

文件 B配置会根据url/documents 去 root/doucuments/去匹配文件

### 伪静态

用 rewrite 来实现，通过 Nginx 提供的变量或自己设置的变量，配合正则与标志位来进行 URL 重写。

标识位
* last：标志完成
* break：停止后续 rewrite
* redirect：302临时重定向
* permanent：301 永久重定向


## docker 配置

### 构建镜像

- www目录将映射为nginx容器配置的虚拟目录
- logs目录将映射为nginx容器的日志目录
- conf目录里的配置文件将映射为nginx容器的配置文件

  ```
  mkdir -p ~/nginx/www ~/nginx/logs ~/nginx/conf
  ```

进入创建的nginx目录，创建Dockerfile

```
FROM debian:jessie

MAINTAINER NGINX Docker Maintainers "docker-maint@nginx.com"

ENV NGINX_VERSION 1.10.1-1~jessie

RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 \
        && echo "deb http://nginx.org/packages/debian/ jessie nginx" >> /etc/apt/sources.list \
        && apt-get update \
        && apt-get install --no-install-recommends --no-install-suggests -y \
                                                ca-certificates \
                                                nginx=${NGINX_VERSION} \
                                                nginx-module-xslt \
                                                nginx-module-geoip \
                                                nginx-module-image-filter \
                                                nginx-module-perl \
                                                nginx-module-njs \
                                                gettext-base \
        && rm -rf /var/lib/apt/lists/*

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
        && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
```

- `docker build -t nginx .`
- `docker images nginx`

  ### 拉取镜像

```
docker pull nginx
docker run -p 80:80 --name mynginx -v $PWD/www:/www -v $PWD/conf/nginx.conf:/etc/nginx/nginx.conf -v $PWD/logs:/wwwlogs  -d nginx
```


## Mac

先调试nginx，再看php是否生效

```
brew info nginx

Docroot is: /usr/local/Cellar/nginx/1.12.2_1/html // 软件更新后版本号会发生变化，默认也会失效
The default:/usr/local/etc/nginx/nginx.conf  // 配置文件
Severs config:/usr/local/etc/nginx/servers/
local config:/usr/local/var/log/nginx/

sudo chown root:wheel /usr/local/Cellar/nginx/1.10.0/sbin/nginx
sudo chmod u+s /usr/local/Cellar/nginx/1.10.0/sbin/nginx

brew services start nginx
brew edit nginx
```

## 使用
```
sudo nginx // 启动命令
sudo ngixn -c /usr/local/etc/nginx/nginx.conf
sudo nginx -s reload|reload|reopen|stop|quit // 重新配置后都需要进行重启操作
sudo nginx -t -c /usr/local/etc/nginx/nginx.conf
```

## 配置

### 跳转

rewrite、return、error_page

```
server {
    listen 80;
    server_name domain.com;
    rewrite ^(.*) https://$server_name$1 permanent;
}
server {
    listen 443 ssl;
    server_name domain.com;
    ssl on;
    # other
}

server {
    listen 80;
    server_name domain.com;
    return 301 https://$server_name$request_uri;
}
server {
    listen 443 ssl;
    server_name domain.com;
    ssl on;
    # other
}
server {
    listen 443 ssl;
    listen 80;
    server_name domain.com;
    ssl on;
    # other
    error_page 497 https://$server_name$request_uri;
}
```

## 日志分析

```
awk '{print $11}' access.log | sort | uniq -c | sort -rn // Processing log file group by HTTP Status Code
awk '($11 ~ /502/)' access.log | awk '{print $4, $9}' | sort | uniq -c | sort -rn // Getting All URL's in log file of specific Status Code, below example 502
awk '($11 ~ /502/)' access.log | awk '{print $9}' | sed '/^$/d' | sed 's/\?.*//g' | sort | uniq -c | sort -rn  // To group by request_uri's excluding query string params below is the command
awk -F\" '{print $2}' access.log | awk '{print $2}' | sort | uniq -c | sort -r // Most Requested URL
awk -F\" '($2 ~ "xyz"){print $2}' access.log | awk '{print $2}' | sort | uniq -c | sort -r // Most Requested URL containing xyz
```


## 参考

- [git-mirror/nginx](https://github.com/git-mirror/nginx)：A mirror of the nginx SVN repository. <http://nginx.org/>
- [《Nginx官方文档》使用nginx作为HTTP负载均衡](http://ifeve.com/nginx-http/)
- [并发](https://baike.baidu.com/item/%E5%B9%B6%E5%8F%91)
