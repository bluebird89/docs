# [nginx/nginx](https://github.com/nginx/nginx)

解决基于进程模型产生的C10k问题，请求时即使无状态连接如web服务都无法达到并发响应量级一万现状。2006年俄罗斯编写。全称为engine X，缩减合并称为nginx。

## 版本

* Nginx 从 1.7.11 开始实现了线程池机制，大部分场景中可以避免使用阻塞，整体性能有了数倍提升。https://www.nginx.com/blog/thread-pools-boost-performance-9x/

## 特性

* 模块化设计、较好扩展性；早期不支持模块的动态装卸载
* 高可靠性：基于master/worker模式
    - master：负责启动服务，分析配置文件，父子启动子进程和worker进程
    - worker：真正响应用户请求进程
* 支持热部署(平滑迁移)：不停机更新配置文件、更换日志、更新服务器程序版本；
* 内存消耗低：10000个keep-alive连接模式下的非活动连接仅消耗2.5M内存；
* 支持event-driven事件驱动模型, aio一步驱动机制, mmap内存映射；

## 功能

* 静态资源的web服务器；
* http协议的反向代理服务器；
* pop3, smpt,imap4等邮件协议的反向代理；
* 能缓存打开的文件（元数据：文件的描述符等等信息）
* 支持FastCGI（php-fpm）, uWSGI（Python WebFramwork）等协议机制，实现代理后端应用程序交互
* 高度模块化（非DSO机制）
    - core module：核心公用模块
    - Standard HTTP  modules：标准(核心)HTTP模块；自动编译进程序不止一个
    - Optional HTTP  modules：可选HTTP模块
    - Mail modules：邮件模块
    - 3rd party modules：第三方模块，在编译时需手动指明加载方式加载
* 支持过滤器，例如zip，SSI
 * 支持SSL加密机制；
 * web服务相关的功能：虚拟主机（server）、keepalive、访问日志（支持基于日志缓冲提高其性能）、urlrewirte、路径别名、基于IP及用户的访问控制、支持速率限制及并发数限制

## 架构

![](../../_static/nginx_archetect.png "Optional title")
* master/worker模型：一个master进程可生成一个或多个worker进程；每个worker基于时间驱动机制可以并行响应多个请求
    - master:加载配置文件、管理worker进程、平滑升级，...
    - worker：http服务，http代理，fastcgi代理，...
* 事件驱动：epoll(Linux),kqueue（FreeBSD）, /dev/poll(Solaris)
* 消息通知：select,poll, rt signals
    - 支持sendfile,  sendfile64
    - 支持AIO，mmap

## 模块

- NGINX Plus 由 Web 服务器、内容缓存和负载均衡器组成。流行的开源 NGINX Web 服务器的商业版本。NGINX Web 应用程序防火墙（WAF）是一款基于开源 ModSecurity 研发的商业软件，为针对七层的攻击提供保护，例如 SQL 注入或跨站脚本攻击，并根据如 IP 地址或者报头之类的规则阻止或放行， NGNX WAF 作为 NGINX Plus 的动态模块运行，部署在网络的边缘，以保护内部的 Web 服务和应用程序免受 DDoS 攻击和骇客入侵。
- NGINX Unit 是 Igor Sysoev 设计的新型开源应用服务器，由核心 NGINX 软件开发团队实施。可运行 PHP、Python 和 Go 的新型开源应用服务器。Unit 是"完全动态的"，并允许以蓝绿部署的方式无缝重启新版本的应用程序，而无需重启任何进程。所有的 Unit 配置都通过使用 JSON 配置语法的内置 REST API 进行处理，并没有配置文件。目前 Unit 可运行由最近版本的 PHP、Python 和 Go 编写的代码。在同一台服务器上可以支持多语言的不同版本混合运行。即将推出更多语言的支持，包括 Java 和 Node.JS。
- NGINX Controller 是 NGINX Plus 的中央集中式监控和管理平台。Controller 充当控制面板，并允许用户通过使用图形用户界面"在单一位置管理数百个 NGINX Plus 服务器"。该界面可以创建 NGINX Plus 服务器的新实例，并实现负载平衡、 URL 路由和 SSL 终端的中央集中配置。Controller 还具备监控功能，可观察应用程序的健壮性和性能。
- NGINX Plus（Kubernetes）Ingress Controller 解决方案基于开源的 NGINX kubernetes-ingress 项目，经过测试、认证和支持，为 Red Hat OpenShift 容器平台提供负载平衡。该解决方案增加了对 NGINX Plus 中高级功能的支持，包括高级负载平衡算法、第7层路由、端到端认证、request/rate 限制以及内容缓存和 Web 服务器。
- NGINX 还发布了 nginmesh，这是 NGINX 的开源预览版本，作为 Istio Service Mesh 平台中第7层负载平衡和代理的服务代理。它旨在作为挎斗容器（sidecar container）时，能提供与 Istio 集成的关键功能，并以"标准、可靠和安全的方式"促进服务之间的通信能力。此外，NGINX 将通过加入 Istio 网络特别兴趣小组，与 Istio 社区合作。
- NGINX Web 应用防火墙（WAF）
- NGINX Controller NGINX Plus 的中央控制面板 ![](../_static/nignx.png)

## 安装

* 网站能否访问（nginx）
* 能否解析PHP

### Mac

- 程序文件 /usr/local/Cellar/nginx
- 配置文件 /usr/local/etc/nginx/nginx.conf   /usr/local/nginx/conf/nginx.conf
- 日志与服务器文件 /usr/local/var/log/nginx/
- Severs config:/usr/local/etc/nginx/servers/
- Docroot is: /usr/local/Cellar/nginx/1.12.2_1/html /usr/local/var/www, 软件更新后版本号会发生变化，默认也会失效

```sh
brew info nginx

sudo chown root:wheel /usr/local/Cellar/nginx/1.12.2_1/bin/nginx
sudo chmod u+s /usr/local/Cellar/nginx/1.12.2_1/bin/nginx

brew services start nginx
brew edit nginx

sudo nginx # 启动命令
sudo ngixn -c /usr/local/etc/nginx/nginx.conf
sudo nginx -s reload|reload|reopen|stop|quit # 重新配置后都需要进行重启操作
sudo nginx -t -c /usr/local/etc/nginx/nginx.conf
```
## 配置

全局变量

```sh
$args # 请求中的参数
$content_length # 请求 HEAD 中的 Content-length
$content_type # 请求 HEAD 中的 Content_type
$document_root # 当前请求中 root 的值
$host # 主机头
$http_user_agent # 客户端 agent
$http_cookie # 客户端 cookie
$limit_rate # 限制连接速率
$request_method # 客户端请求方式，GET/POST
$remote_addr # 客户端 IP
$remote_port # 客户端端口
$remote_user # 验证的用户名
$request_filename # 请求的文件绝对路径
$scheme # http/http
$server_protocol # 协议，HTTP/1.0 OR HTTP/1.1
$server_addr # 服务器地址
$server_name # 服务器名称
$server_port # 服务器端口
$request_uri # 包含请求参数的 URI
$uri # 不带请求参数的 URI
$document_uri # 同 $uri

-f/!-f # 判断文件是否存在
-d/!-d # 判断目录是否存在
-e/!-e # 判断文件或目录是否存在
-x/!-x # 判断文件是否可以执行
```

### main（全局设置）

PHP7默认的用户和组是www-data。The main configuration file is: /etc/nginx/nginx.conf.

```
# nginx.conf
# 运行用户，linux系统尤其重要，如出现403 forbidden错误，很有可能是这个没有设置正确
#user  www-data;

# 启动进程数量，通常和cpu的数量相同.在配置文件的顶级main部分，worker角色的工作进程的个数，master进程是接收并分配给worker处理。一般情况下这个值可以设置为CPU的核数，如果开启了ssl和gzip一般设置为CPU数量的2倍，可以减少I/O操作。如果Nginx服务器还有其它服务，可以考虑适当减少。
worker_processes  1;
#  写在main部分，默认没有设置，可以限制为操作系统最大的限制65535。
worker rlimit nofile 10240

# 全局错误日志及pid
error_log   /var/log/nginx/error.log;
#error_log  logs/error.log  notice;
#error_log  logs/error.log  info;
pid        /var/run/nginx.pid;

# 工作模式及链接数上限
events {
    # 在Linux操作系统下，Nginx默认使用epoll事件模型，得益于此，Nginx在Linux操作系统下效率相当高。同时Nginx在OpenBSD或FreeBSD操作系统上采用类似于epoll的高效事件模型kqueue。epoll是多路复用IO(I/O Multiplexing)中的一种方式
    use epoll;
    #单个后台worker process进程的最大并发链接数 每一个worker进程能并发处理（发起）的最大连接数。Nginx作为反向代理服务器，计算公式最大连接数 = worker_processes * worker_connections / 4，所以这里客户端最大连接数是1024，这个可以增到8192，但不能超过worker_rlimit_nofile。当Nginx作为http服务器时，计算公式里面是除以2.
    worker_connections  1024;
}
```

### http（服务器设置）

* windows调用php-cgi启动服务
* linux通过转交服务给php-fpm处理:配置www.conf服务转交TCP socket或Unix Socket
    - Unix Sockets
        + Nginx is run as user/group www-data. PHP-FPM's unix socket therefore needs to be readable/writable by this user.
        + If we change the Unix socket owner to user/group ubuntu, Nginx will then return a bad gateway error, as it can no longer communicate to the socket file. We would have to change Nginx to run as user "ubuntu" as well, or set the socket file to allow "other" (non user nor group) to be read/written to, which is insecure.
    - TCP Sockets
        + This makes PHP-FPM able to be listened to by remote servers
        + listen.allowed_clients = 127.0.0.1

提供http服务相关的一些配置参数，如：是否使用keepalive，是否使用gzip进行压缩

```sh
touch php7.0-fpm.sock
chown www-data:www-data php7.0-fpm.sock
chmod 777 php7.0-fpm.sock

# 设定http服务器，利用它的反向代理功能实现负载均衡支持
http {
    # 设定负载均衡的服务器列表 weigth参数表示权值，权值越高被分配到的几率越大
    upstream phpbackend {
      server unix:/var/run/php5-fpm.sock1 weight=100 max_fails=5 fail_timeout=5;
      server unix:/var/run/php5-fpm.sock2 weight=100 max_fails=5 fail_timeout=5;
      server unix:/var/run/php5-fpm.sock3 weight=100 max_fails=5 fail_timeout=5;
      server unix:/var/run/php5-fpm.sock4 weight=100 max_fails=5 fail_timeout=5;
      server 192.168.8.3:80  weight=6;
    }

    # Stop Displaying Server Version in Configuration
    server_tokens off;

    # Let NGINX get the real client IP for its access logs
    set_real_ip_from 127.0.0.1;
    real_ip_header X-Forwarded-For;

    # 文件扩展名与文件类型映射表 设定mime类型,类型由mime.type文件定义
    include mime.types;
    # 设定默认文件类型
    default_type application/octet-stream;

    # 为Nginx服务器设置详细的日志格式
    log_format  main   $remote_addr - $remote_user [$time_local] "$request"
                      $status $body_bytes_sent "$http_referer"
                      "$http_user_agent" "$http_x_forwarded_for";

    access_log      /usr/local/var/log/nginx/access.log main;
    # 开启高效文件传输模式，sendfile指令指定nginx是否调用sendfile函数来输出文件，对于普通应用设为 on，如果用来进行下载等应用磁盘IO重负载应用，可设置为off，以平衡磁盘与网络I/O处理速度，降低系统的负载。注意：如果图片显示不正常把这个改成off。
    sendfile on;

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

    # Client Timeouts 设定请求缓冲
    client_max_body_size 500M;
    # 缓冲区代理缓冲用户用户端请求的最大字节数
    client_body_buffer_size 1m;
    client_body_timeout 15;
    client_header_timeout 15;
    # 允许客户端请求的最大单文件字节数，一般在上传较大文件时设置限制值
    client max body_ size 10m

    # 连接超时时间
    # 长连接超时时间，单位是秒，涉及到浏览器的种类、后端服务器的超时设置、操作系统的设置，相对比较敏感
    keepalive_timeout 2 2;
    # 指定相应客户端的超时时间，这个超时仅限于两个连接活动之间的时间，如果超过这个时间，客户端没有任何活动，Nginx将会关系连接。
    send_timeout 15;
    # sendfile 指令指定 nginx 是否调用 sendfile 函数（zero copy 方式）来输出文件，对于普通应用，必须设为 on,如果用来进行下载等应用磁盘IO重负载应用，可设置为 off，以平衡磁盘与网络I/O处理速度，降低系统的uptime.
    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;

    include servers/*;

    # 加载配的本地虚拟机
    include vhost/*.conf;
}
```

### server

http服务上支持若干虚拟主机，每个虚拟主机对应一个server配置项

* First, the incoming URI will be normalized even before any of the location matching takes place. For example, First it will decode the “%XX” values in the URL.
* It will also resolve the appropriate relative path components in the URL, if there are multiple slashes / in the URL, it will compress them into single slash etc. Only after this initial normalization of the URL, the location matching will come into play.
* When there is no location modifier, it will just be treated as a prefix string to be matched in the URL.
* Nginx will first check the matching locations that are defined using the prefix strings.
* If the URL has multiple location prefix string match, then Nginx will use the longest matching prefix location.
* After the prefix match, nginx will then check for the regular expression location match in the order in which they are defined in the nginx configuration file.
* So, the order in which you define the regular expression match in your configuration file is important. The moment nginx matches a regular expression location configuration, it will not look any further. So, use your important critical regular expression location match at the top of your configuration.
* If there is no regular expression matching location is found, then Nginx will use the previously matched prefix location configuration.

* 匹配优先级:一次请求只能匹配一个location，一旦匹配成功后，便不再继续匹配其余location;
    - =：URI的精确匹配，其后多一个字符都不可以，精确匹配。match only the following EXACT URL
    - ^~：URI的左半部分匹配，不区分字符大小写；this configuration will be used as the prefix match, but this will not perform any further regular expression match even if one is available.等同无标志符号，多了不会匹配后面对应规则
    - ~：做正则表达式匹配，区分字符大小写；case sensitive regular expression match modifier
    - ~*：做正则表达式匹配，不区分字符大小写；

URL重写时所用的正则表达式需要使用PCRE格式。PCRE正则表达式元字符：

* 字符匹配：.,[ ], [^]
* 次数匹配：*,+, ?, {m}, {m,}, {m,n}
* 位置锚定：^,$
  * $ at the end means that the specified keyword should be at the end of the URL.
* 或者：|  OR operator
* 分组：(),后向引用, $1, $2, ...
* ( ) – all the values inside this regular expression will be considered as keywords in the URL

```
# 客户端请求限制
imit_except  GET {
    allow  172.16.0.0/16;
    denyall;
}

imit_rate  # 限制客户端每秒钟所能够传输的字节数，默认为0表示无限制

rewrite^(/download/.*)/media/(.*)\..*$ $1/mp3/$2.mp3 last;
rewrite^(/download/.*)/audio/(.*)\..*$ $1/mp3/$2.ra last;
return  403; # last和break请求处理是在服务器内部完成，客户端仅请求一次。redirect和permanent需要客户端再次请求

ssl_certificate  FILE; # 证书文件路径
ssl_certificate_key  FILE; # 证书对应的私钥文件
ssl_ciphers  CIPHERS; # 指明由nginx使用的加密算法，可以是OpenSSL库中所支持各加密套件
ssl_protocols  # ; # 指明支持的ssl协议版本，[SSLv2]  [SSLv3] [TLSv1] [TLSv1.1] [TLSv1.2]默认为后三个
ssl_session_timeout  #; # ssl会话超时时长；即ssl  session cache中的缓存有效时长
ssl_session_cache # ; # 指明ssl会话缓存机制；off | none | [builtin[:size]] [shared:name:size]，默认使用shared

location /admin/ {
    auth_basic"Admin Area";
    auth_basic_user_file/etc/nginx/.ngxhtpasswd;
}

server {
    # nginx监听的端口，Mac下默认为8080，小于1024的要以root启动。可以为listen:*:8080、listen:127.0.0.1:8080等形式
    #listen       8080;
    listen       80;

    # 定义使用www.exam.com访问， 记得一定要配Host 服务器名，如localhost、www.jd.com，可以通过正则匹配
    server_name  www.exam.com;

    #charset koi8-r;

    # 设定本虚拟机的访问日志,使用“main”日志格式
    access_log  logs/host.access.log  main;
    rewrite_log on; # 开启重写日志
    # location（URL匹配特定位置配置） http服务中，某些特定的URL对应的一系列配置项。
    location / {
        # 定义服务器默认网站根目录，如果locationURL匹配的是子目录或文件，root没什么作用，一般放在server指令里面或/下。
        root   html;

        # 定义首页索引文件的名称，默认访问的文件名
        index  index.html index.htm;
    }

    # 定义
    error_page  404              /404.html;
    location = /404.html {
        root   /var/www/html/errors;
    }

    # redirect server error pages to the static page /50x.html
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

    location /img/ {
        root /custom/images;
    }

    # deny access to .htaccess files, if Apache"s document root
    # concurs with nginx"s one
    #
    #location ~ /\.ht {
    #    deny  all;
    #}

    # URL/db – Will look for index.html file under /data/db
    # URL/db/index.html – Will look for index.html file under /data/db
    # URL/db/connect/index.html – Will look for index.html file under /data/db/connect
     location /db {
        root   /data;
        ...
    }

    # URL/db – Will work.
    # URL/db/index.html – Will not work.
    # URL/db/connect/index.html – Will not work.
    location = /db {
        root   /data;
    }

    location ~ .(png|gif|ico|jpg|jpe?g)$ {

    }

    location / {
      try_files $uri $uri/ @custom;
    }

    location @custom {
        rewrite ^/(.+)$ /index.php?_route_=$1 last;
    }

    location ~ .*\.(?:jpg|jpeg|gif|png|ico|cur|gz|svg|svgz|mp4|ogg|ogv|webm)$
    {
        expires      7d;
    }

    location ~ .*\.(?:js|css)$
    {
        expires      7d;
    }

// html 不缓存
    location ~ .*\.(?:htm|html)$
    {
        add_header Cache-Control "private, no-store, no-cache, must-revalidate, proxy-revalidate";
    }

}

# another virtual host using mix of IP-, name-, and port-based configuration
#
#server {
    #listen       8000;
#    listen       80;
#    server_name  some.stage.com;

#    location / {
#        root   html;
#        index  index.html index.htm;
#    }
#}

server {
        listen       80;
        server_name  local.ciie.com ;
        root   "D:/Workspace/ciie/trunk/web";
        location / {
            index  index.html index.htm index.php;
            #autoindex  on;
        }
        location ~ \.php(.*)$ {
            fastcgi_pass   127.0.0.1:9000;
            fastcgi_index  index.php;
            fastcgi_split_path_info  ^((?U).+\.php)(/?.+)$;
            fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
            fastcgi_param  PATH_INFO  $fastcgi_path_info;
            fastcgi_param  PATH_TRANSLATED  $document_root$fastcgi_path_info;
            include        fastcgi_params;
        }
}

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
    listen 8080;  #监听端口号
    server_name localhost;  # 主机名

    root /Users/www/test/; # 该项要修改为你准备存放相关网页的路径

    index index.php;     # 定义路径下默认访问的文件名
    charset utf-8;

    access_log logs/host.access.log main;

    ssl_client_certificate  /etc/ssl/nginx/intermediate.crt;
    ssl_certificate  /etc/ssl/nginx/certificate.crt;
    ssl_certificate_key  /etc/ssl/nginx/private.key;

    # location 配置
    location / {
      root   html;
      index  index.php index.shtml index.html index.htm;

      autoindex on;       # 打开目录浏览功能，可以列出整个目录
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

location  /images/ {
    alias/data/imgs/;
}

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

# example
upstream app_weapp {
    server localhost:5757;
    keepalive 8;
}

server {
    listen      80;
    server_name wx.ijason.cc;

    rewrite ^(.*)$ https://$server_name$1 permanent;
}

server {
    listen      443;
    server_name wx.ijason.cc;

    ssl on;

    ssl_certificate           /data/release/nginx/1_wx.ijason.cc_bundle.crt;
    ssl_certificate_key       /data/release/nginx/2_wx.ijason.cc.key;
    ssl_session_timeout       5m;
    ssl_protocols             TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers               ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA256:ECDHE-RSA-AES256-SHA:ECDHE-RSA-AES128-SHA:DHE-RSA-AES256-SHA:DHE-RSA-AES128-SHA;
    ssl_session_cache         shared:SSL:50m;
    ssl_prefer_server_ciphers on;

    location / {
        proxy_pass http://app_weapp;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}

# windows 配置
server {
        listen       80;
        server_name  local.ciie.com;
        root   "D:/Workspace/ciie/trunk/web";

    access_log logs/ciie_access.log;
    error_log logs/ciie_error.log;

        location / {
            index  index.html index.htm index.php;
            #autoindex  on;
        }

        location ~ \.php(.*)$ {
            fastcgi_pass   127.0.0.1:9000;
            fastcgi_index  index.php;
            fastcgi_split_path_info  ^((?U).+\.php)(/?.+)$;
            fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
            fastcgi_param  PATH_INFO  $fastcgi_path_info;
            fastcgi_param  PATH_TRANSLATED  $document_root$fastcgi_path_info;
            include        fastcgi_params;
        }
}
# 配置跨域请求
add_header Access-Control-Allow-Origin *;
add_header Access-Control-Allow-Headers "Origin, X-Requested-With, Content-Type, Accept"; # Request header field Content-Type is not allowed by Access-Control-Allow-Headers in preflight response.
add_header Access-Control-Allow-Methods "GET, POST, OPTIONS"; # Content-Type is not allowed by Access-Control-Allow-Headers in preflight response.

# Nginx 反向代理 Https 实际的后端服务器直接 http 启动，证书配置在 Nginx 上。
server
    {
        listen 80;
        server_name domain.com;
        rewrite ^(.*)$ https://domain.com$1 permanent;
    }

server
    {
        listen 443 ssl http2;
        server_name domain.com ;

        ssl on;
        ssl_certificate path;
        ssl_certificate_key path;
        ssl_session_timeout 5m;
        ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
        ssl_prefer_server_ciphers on;
        ssl_ciphers "YOUR";
        ssl_session_cache builtin:1000 shared:SSL:10m;
        ssl_dhparam path;
        location /
        {
            # 注意这里是http
            proxy_pass http://127.0.0.1:8081;
            proxy_set_header Host domain.com;
            proxy_set_header X-Forwarded-Proto https;
        }
    }
```

文件 B配置会根据url/documents 去 root/doucuments/去匹配文件

### 伪静态

用 rewrite 来实现，通过 Nginx 提供的变量或自己设置的变量，配合正则与标志位来进行 URL 重写。从请求参数中获取全局变量，

标识位
* last：标志完成，This flag will stop the processing of the rewrite directives in the current set, and will start at the new location that matches the changed URL.
* break：停止后续 rewrite This flag will stop the processing of the rewrite directives in the current set.
* redirect：302临时重定向 This flag will do a temporary redirection using 302 HTTP code. This is mainly used when the replacement string is not http, or https, or $scheme
* permanent：301 永久重定向  This flag will do a permanent redirection using 301 HTTP code

```
location / {
  try_files $uri $uri/ /index.php?q=$uri&$args;
}

location / {
  if ( $args ~ "mosConfig_[a-zA-Z_]{1,21}(=|\%3d)" ) {
    set $args "";
    rewrite ^.*$ http://$host/index.php last;
  return 403;}
  if ( $args ~ "base64_encode.*\(.*\)") {
    set $args "";
    rewrite ^.*$ http://$host/index.php last;
  return 403;}
  if ( $args ~ "(\<|%3C).*script.*(\>|%3E)") {
    set $args "";
    rewrite ^.*$ http://$host/index.php last;
  return 403;}
  if ( $args ~ "GLOBALS(=|\[|\%[0-9A-Z]{0,2})") {
   set $args "";
    rewrite ^.*$ http://$host/index.php last;
  return 403;}
  if ( $args ~ "_REQUEST(=|\[|\%[0-9A-Z]{0,2})") {
    set $args "";
    rewrite ^.*$ http://$host/index.php last;
  return 403;}
  if (!-e $request_filename) {
    rewrite (/|\.php|\.html|\.htm|\.feed|\.pdf|\.raw|/[^.]*)$ /index.php last;
    break;}
}

location / {
  rewrite ^/(space|network)\-(.+)\.html$ /$1.php?rewrite=$2 last;
  rewrite ^/(space|network)\.html$ /$1.php last;
  rewrite ^/([0-9]+)$ /space.php?uid=$1 last;
}

rewrite ^(/data/.*)/geek/(\w+)\.?.*$ $1/linux/$2.html last;
rewrite ^/linux/(.*)$ /linux.php?distro=$1 last;
location /data/ {
    rewrite ^(/data/.*)/geek/(\w+)\.?.*$ $1/linux/$2.html break;
    return  403;
}

if ($scheme = "http") {
  rewrite ^ https://www.thegeekstuff.com$uri permanent;
}
if ($http_host = thegeekstuff.com) {
  rewrite  (.*)  https://www.thegeekstuff.com$1;
}
if ($http_user_agent = MSIE) {
    rewrite ^(.*)$ /pdf/$1 break;
}

rewrite ^/linux/(.*)$ /linux.php?distro=$1 last;
```

## 代理

正向代理:正向代理发生在 client 端，用户能感知到的，并且是用户主动发起的代理。vpn
反向代理:发生在 server端，从用户角度看是不知道发生了代理的

```
#将请求"http:127.0.0.1:80/helloworld" 转向服务器 "http://127.0.0.1:8081"
server {
        listen       80;
        server_name  127.0.0.1;

        location /helloworld {
             proxy_pass     http://127.0.0.1:8081; # 表明了所代理的服务器
}

# websocket的反向代理配置
server {
    listen 9000; # 监听9000端口
    server_name   websocket_server;

    # 允许跨域
    add_header Access-Control-Allow-Origin *;
    add_header Access-Control-Allow-Methods 'GET, POST, OPTIONS';
    add_header Access-Control-Allow-Headers 'DNT,X-Mx-ReqToken,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Authorization';
    if ($request_method = 'OPTIONS') {
        return 204;
    }

    location / {
        #添加wensocket代理
        proxy_pass http://127.0.0.1:9093;  # websocket服务器。不用管 ws://
        // proxy_pass https://www.baidu.com;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
}
```

## 缓存

* 利用客户访问的时间局部性原理，对客户已经访问过的内容在Nginx服务器本地建立副本，这样在一段时间内再次访问该数据，就不需要通过Ｎginx服务器再次向后端服务器发出请求，所以能够减少Ｎginx服务器与后端服务器之间的网络流量，减轻网络拥塞，同时还能减小数据传输延迟，提高用户访问速度。
* 当后端服务器宕机时，Nginx服务器上的副本资源还能够回应相关的用户请求
* 基于Proxy Store:只能缓存200状态下的响应数据，同时不支持动态链接请求。比如:getsource?id=1和getsource?id=2这两个请求，返回的是相同的资源。所以实际上，一般是采用Nginx搭配Squid服务器架构实现方案。
    - 404错误驱动：服务器能够捕捉404错误，进一步转向后端服务器请求相关数据，最后将后端请求到的数据传回客户端，并在服务器本地缓存
    - 资源不存在驱动:通过location块的location if条件判断直接驱动Nginx服务器和后端服务器的通信和Ｗeb缓存，而不对资源不存在产生404错误
* 基于memcached的缓存机制:memcached在内存中开辟一块空间，然后建立一个Ｈash表，将缓存数据通过键/值存储在Hash表中进行管理。memcached由服务端和客户端两个核心模块组成，服务端通过计算“键”的Hash值来确定键/值对在服务端所处的位置。当位置确定后，客户端就会向对应的服务端发送一个查询请求，让服务端查找并返回所需数据。

```
location /{
    root /web/server/;
    #将404错误定向到/error_page目录下
    error_page 404 =200 /error_page$request_uri;
}

// 捕获404错误的重定向
location /error_page/{
    internal;
    alias /home/html;
    proxy_pass http://backend/;  #后端upstream地址或者源地址
    proxy_store on;   #指定Ｎginx将后端服务器返回的文件保存
    proxy_store_access user:rw group:rw all:r;
    #配置临时目录，目录需要和/web/server/在同一个硬盘分区内
    proxy_temp_path /web/server/tmp;
}

location /{
    root /web/server/;
    internal;
    alias /home/html;
    proxy_store on;   #指定Ｎginx将后端服务器返回的文件保存
    proxy_store_access user:rw group:rw all:r;
    #配置临时目录，目录需要和/web/server/在同一个硬盘分区内
    proxy_temp_path /web/server/tmp;

    #判断请求文件是否存在，不存在则执行代理，向后端服务器发出请求
    if( !-f $request_filename)
    {
    proxy_pass http://backend/;  #后端upstream地址或者源地址
    }
}

```

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

## 负载均衡

* 轮询(weight=1):每个请求按时间顺序逐一分配到不同的后端服务器，如果后端服务器down掉，能自动剔除。
* weight:指定轮询几率，weight和访问比率成正比，用于后端服务器性能不均的情况。
* ip_hash:每个请求按访问ip的hash结果分配，这样每个访客固定访问一个后端服务器，可以解决session不能跨服务器的问题。如果后端服务器down掉，要手工down掉。
    * 会出现session不落到同一台服务器上，设置只有一台服务器运行测试代码
* fair（第三方插件）:按后端服务器的响应时间来分配请求，响应时间短的优先分配。
* url_hash（第三方插件）:按访问url的hash结果来分配请求，使每个url定向到同一个后端服务器，后端服务器为缓存服务器时比较有效。在upstream中加入hash语句，hash_method是使用的hash算法。

```
upstream bakend {
    server 192.168.1.10;
    server 192.168.1.11;
}

upstream bakend {
    server 192.168.1.10 weight=1;
    server 192.168.1.11 weight=2;
}

upstream resinserver{
    ip_hash;
    server 192.168.1.10:8080;
    server 192.168.1.11:8080;
}

upstream resinserver{
    server 192.168.1.10:8080;
    server 192.168.1.11:8080;
    fair;
}

upstream resinserver{
    server 192.168.1.10:8080;
    server 192.168.1.11:8080;
    hash $request_uri;
    hash_method crc32;
}

# down 表示单前的server暂时不参与负载
# weight 权重,默认为1。 weight越大，负载的权重就越大。
# max_fails 允许请求失败的次数默认为1。当超过最大次数时，返回proxy_next_upstream 模块定义的错误
# fail_timeout max_fails次失败后，暂停的时间。
# backup 备用服务器, 其它所有的非backup机器down或者忙的时候，请求backup机器。所以这台机器压力会最轻。
# 当upstream中只有一个 server 时，max_fails 和 fail_timeout 参数可能不会起作用。weight\backup 不能和 ip_hash 关键字一起使用
upstream tel_img_stream {
    #ip_hash;
    server 192.168.11.68:20201;
    server 192.168.11.69:20201 weight=100 down;
    server 192.168.11.70:20201 weight=100;
    server 192.168.11.71:20201 weight=100 backup;
    server 192.168.11.72:20201 weight=100 max_fails=3 fail_timeout=30s;
}
```

### 拉取镜像

```
docker pull nginx
docker run -p 80:80 --name mynginx -v $PWD/www:/www -v $PWD/conf/nginx.conf:/etc/nginx/nginx.conf -v $PWD/logs:/wwwlogs  -d nginx
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

## [鉴权配置](https://docs.nginx.com/nginx/admin-guide/security-controls/configuring-http-basic-authentication/)

http basic auth

```sh
htpasswd -cb your/path/to/api_project_accounts.db admin password_for_admin
htpasswd -b your/path/to/api_project_accounts.db liuxu 123456
htpasswd your/path/to/api_project_accounts.db xiaoming

location /dist {
    deny  192.168.1.2;
    allow 192.168.1.1/24;
    allow 127.0.0.1;
    deny  all;

    auth_basic              "my api project login";
    auth_basic_user_file    your/path/to/api_project_accounts.db;
}
```

## faastcgi

include fastcgi_params;

## 日志分析

```
awk '{print $11}' access.log | sort | uniq -c | sort -rn // Processing log file group by HTTP Status Code
awk '($11 ~ /502/)' access.log | awk '{print $4, $9}' | sort | uniq -c | sort -rn // Getting All URL's in log file of specific Status Code, below example 502
awk '($11 ~ /502/)' access.log | awk '{print $9}' | sed '/^$/d' | sed 's/\?.*//g' | sort | uniq -c | sort -rn  // To group by request_uri's excluding query string params below is the command
awk -F\" '{print $2}' access.log | awk '{print $2}' | sort | uniq -c | sort -r // Most Requested URL
awk -F\" '($2 ~ "xyz"){print $2}' access.log | awk '{print $2}' | sort | uniq -c | sort -r // Most Requested URL containing xyz
```

## 日志

```sh
cp /var/log/nginx/access.log /var/log/nginx/test.log
cat /var/log/nginx/test.log
192.168.232.1 - - [14/Mar/2015:01:12:59 -0700] "GET / HTTP/1.1" 200 2230 "-" "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)" "-"

cat /var/log/nginx/test.log | awk ‘{print $1,$4,$7}’ # $1是ip地址 ，$4是时间 , $7是被访问地址

create database test;
use test;
CREATE TABLE log (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
    `ip` varchar(15) NOT NULL DEFAULT '127.0.0.1' COMMENT '//客户端ip',
    `url` varchar(255) NOT NULL DEFAULT '' COMMENT '访问的url',
    `time` char(20) NOT NULL DEFAULT '' COMMENT '详细时间',
    `date` int(8) unsigned NOT NULL DEFAULT '0' COMMENT '年月日',
     PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

vim nginx_log_to_mysql.sh

#!/bin/bash
      #

      #处理时间[14/Mar/2015:01:12:59成2015-Mar-14 01:12:59
      function unixtime()
      {
            if [ -n "$!"] ;
            then
                TIME=`echo ${1:1} | awk -F'[:\b/]' '{print $3"-"$2"-"$1" "$4":"$5":"$6}'`
                echo $TIME
            fi
      }

      #存放日志的路径
      LOG_PATH='/var/log/nginx/'

      #有那些日志
      LOGS=('test')

      #处理昨天的日志
      YESTERDAY=`date -d "yesterday" +"%Y-%m-%d"`

      #连接数据库的账号密码及其数据库
      SQLCNT='/usr/local/mysql/bin/mysql -uroot -p123456 test'
      SQL="INSERT INTO log(ip,url,time,date)VALUES"

      #获取当前的时间
      DATE=`date -d "yesterday" +"%Y%m%d"`

      #循环读取所有的日志 ， 并进行读取
      for LOG in ${LOGS[@]} ;
      do
            #读取后缀为/ .或者.html 或php的访问文件
            DATA=`/bin/cat "$LOG_PATH$LOG-$YESTERDAY.log" | awk '$7 ~ /(\/$|\.html.*|\.php.*)/ {print $1"--"$4"--"$7}'  `
            #计算器 , 插入的数据超过1000条先提前插入
            I=1
            QRYSQL=''
            for D in ${DATA[@]} ;
            do
                  #将上面时间获取ip—时间—访问的url进行转化为数组
                  DD=(`echo ${D//--/ }`)
                  QRYSQL=$QRYSQL"('${DD[0]}','${DD[2]}','`unixtime ${DD[1]}`','$DATE'),"
                  #超过1000条先插入
                  if [ $I == 1000 ] ;
                  then
                        QRYSQL=$SQL${QRYSQL%%,}";"
                        echo $QRYSQL | $SQLCNT &> /dev/null
                        I=0
                        QRYSQL=''
                  fi
                  I=`expr $I+1`
            done
            if [ -n $WRYSQL ] ; then
                  QRYSQL=$SQL${QRYSQL%%,}";"
                  echo $QRYSQL | $SQLCNT &> /dev/null
            fi
      done

chmod +x /root/shell/nginx_log_to_mysql.sh
crontab –e
# 凌晨0时15分执行
15 0 * * * /root/shell/nginx_log_to_mysql.sh &> /var/log/nginx_sh.log
```

## 模块

* [winshining/nginx-http-flv-module](https://github.com/winshining/nginx-http-flv-module):Media streaming server based on nginx-rtmp-module, HTTP-FLV/RTMP/HLS/DASH supported.
* [arut/nginx-rtmp-module](https://github.com/arut/nginx-rtmp-module):NGINX-based Media Streaming Server http://nginx-rtmp.blogspot.com

## 工具

- [openresty/openresty](https://github.com/openresty/openresty):Turning Nginx into a Full-Fledged Scriptable Web Platform https://openresty.org
- [kubernetes/ingress-nginx](https://github.com/kubernetes/ingress-nginx):NGINX Ingress Controller for Kubernetes https://kubernetes.github.io/ingress-nginx/
* [valentinxxx/nginxconfig.io](https://github.com/valentinxxx/nginxconfig.io):⚙️ NGiИX config generator generator on steroids 💉 https://nginxconfig.io
* [lebinh/ngxtop](https://github.com/lebinh/ngxtop):Real-time metrics for nginx server

## 参考

- [git-mirror/nginx](https://github.com/git-mirror/nginx)：A mirror of the nginx SVN repository. <http://nginx.org/>
- [Nginx documentation](http://nginx.org/en/docs/)
- [《Nginx官方文档》使用nginx作为HTTP负载均衡](http://ifeve.com/nginx-http/)
- [xuexb/learn-nginx](https://github.com/xuexb/learn-nginx):学习nginx配置, 包括: 编译安装、反向代理、重定向、url重写、nginx缓存、跨域配置等
- [Nginx 配置简述](http://www.cnblogs.com/hustskyking/p/nginx-configuration-start.html)
- [Understanding the Nginx Configuration File Structure and Configuration Contexts](https://www.digitalocean.com/community/tutorials/understanding-the-nginx-configuration-file-structure-and-configuration-contexts)
* [jaywcjlove/nginx-tutorial](https://github.com/jaywcjlove/nginx-tutorial):Nginx安装维护入门学习笔记，以及各种实例。
* [chef-cookbooks/nginx](https://github.com/chef-cookbooks/nginx):Development repository for nginx cookbook https://supermarket.chef.io/cookbooks/nginx
