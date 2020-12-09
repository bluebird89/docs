# [openresty](https://github.com/openresty/openresty)

Turning Nginx into a Full-Fledged Scriptable Web Platform <https://openresty.org>

* 一个基于 Nginx 与 Lua 的高性能 Web 平台，内部集成了大量精良的 Lua 库、第三方模块以及大多数的依赖项。用于方便地搭建能够处理超高并发、扩展性极高的动态 Web 应用、Web 服务和动态网关
* 包含技术
  - Nginx: 一个免费的、开源的、高性能的 HTTP 服务器和反向代理，也是一个电子邮件（IMAP/POP3/SMTP）代理服务器
  - Lua: 一种轻量、小巧、可移植、快速的脚本语言；LuaJIT即时编译器会将频繁执行的Lua代码编译成本地机器码交给CPU直接执行，执行效率更高，OpenResty会默认启用LuaJIT
* 基于 Nginx 的一个 C 模块（lua-nginx-module）,将 LuaJIT 嵌入到 Nginx 服务器中，并对外提供一套完整的 Lua API，透明地支持非阻塞 I/O，提供了轻量级线程、定时器等高级抽象。
* 围绕这个模块，OpenResty 构建了一套完备的测试框架、调试技术和由 Lua 实现的周边功能库
* 通过汇聚各种设计精良的 Nginx 模块（主要由 OpenResty 团队自主开发），从而将 Nginx 有效地变成一个强大的通用 Web 应用平台。Web 开发人员和系统工程师可以使用 Lua 脚本语言调动 Nginx 支持的各种 C 以及 Lua 模块，快速构造出足以胜任 10K 乃至 1000K 以上单机并发连接的高性能 Web 应用系统
* 目标是让Web服务直接跑在 Nginx 服务内部，充分利用 Nginx 的非阻塞 I/O 模型，不仅仅对 HTTP 客户端请求,甚至于对远程后端诸如 MySQL、PostgreSQL、Memcached 以及 Redis 等都进行一致的高性能响应

## 历史

* 最早是雅虎中国的一个公司项目，起步于 2007 年 10 月。当时兴起了 OpenAPI 的热潮，用于满足各种 Web Service 的需求，就诞生了 OpenResty。在公司领导的支持下，最早的 OpenResty 实现从一开始就开源了
* 最初的定位是服务于公司外的开发者，像其他的 OpenAPI 那样，但后来越来越多地是为雅虎中国的搜索产品提供内部服务
  - 应用的重点是为公司内部的其他团队提供 Web Service
* 第二代的 OpenResty ngx_openresty
  - 章亦春在加入淘宝数据部门的量子团队之后，决定对 OpenResty 进行重新设计和彻底重写，并把应用重点放在支持像量子统计这样的 web 产品上面，所以量子统计 3.0 开始也几乎完全是 Web Service 驱动的纯 AJAX 应用

## install

```sh
brew install openresty/brew/openresty

tar -xzvf openresty-VERSION.tar.gz
cd openresty-VERSION/
./configure --prefix=/opt/openresty \
            --with-luajit \
            --without-http_redis2_module \
            --with-http_iconv_module \
            --with-http_postgres_module

./configure --prefix=/usr/local/openresty \
--sbin-path=/usr/local/openresty/nginx/sbin/nginx \
--conf-path=/usr/local/openresty/nginx/conf/nginx.conf \
--pid-path=/usr/local/openresty/nginx/run/nginx.pid \
--error-log-path=/usr/local/openresty/nginx/logs/error.log \
--http-log-path=/usr/local/openresty/nginx/logs/access.log \
--user=nginx \
--group=nginx \
--with-pcre \
--with-stream \
--with-threads \
--with-file-aio \
--with-http_v2_module \
--with-http_ssl_module \
--with-http_realip_module \
--with-http_gzip_static_module \
--with-http_stub_status_module

make
sudo make install

resty -e 'print("hello, world")'

nginx -p `pwd`/ -c conf/nginx.conf
openresty -p `pwd` -c conf/nginx.conf

ab -c10 -n50000 http://localhost:8080/

# install some prerequisites needed by adding GPG public keys (could be removed later)
sudo apt-get -y install --no-install-recommends wget gnupg ca-certificates
# import our GPG key:
wget -O - https://openresty.org/package/pubkey.gpg | sudo apt-key add -
# add the our official APT repository:
echo "deb http://openresty.org/package/ubuntu $(lsb_release -sc) main" \
    | sudo tee /etc/apt/sources.list.d/openresty.list
# to update the APT index:
sudo apt-get update

sudo netstat -ntlp | grep 80
sudo killall -9 nginx
```

## 原理

* 实际上是Nginx+LuaJIT的完美组合
* 将 LuaJIT 的虚拟机嵌入到 Nginx 的管理进程和工作进程中，同一个进程内的所有协程都会共享这个虚拟机，并在虚拟机中执行Lua代码。在性能上，OpenResty接近或超过 Nginx 的C模块，而且开发效率更高
* 每个worker使用一个LuaVM，每个请求被分配到worker时，将在这个LuaVM中创建一个coroutine协程。协程之间数据隔离，每个协程具有独立的全局变量_G
* Lua中的协程和多线程下的线程类似，都有自己的堆栈、局部变量、指令指针...，但是和其他协程程序共享全局变量等信息。线程和协程主要不同在于：多处理器的情况下，概念上来说多线程是同时运行多个线程，而协程是通过代码来完成协程的切换，任何时刻只有一个协程程序在运行。并且这个在运行的协程只有明确被要求挂起时才会被挂起。
* 负载均衡 LVS+HAProxy将流量转发给核心Nginx1和Nginx2，即实现了流量的负载均衡。
* 单机闭环 所有想要的数据都能从本服务器直接获取，大多数时候无需通过网络或去其他服务器获取。
  - 数据不一致 例如没有主从架构导致不同服务器数据不一致
  - 遇到存储瓶颈 磁盘或内存遇到天花板
  - 解决数据不一致比较好的办法是采用主从或分布式集中存储，而遇到存储瓶颈就需要进行按业务键进行分片，将数据分散到多台服务器。
* 接入网关 接入网关又叫接入层，即接收流量的入口
* Lua协程
  - 协程是不被操作系统内核所管理的，而完全由程序控制（也就是用户态执行），这样带来的好处就是性能得到了极大地提升。
  - 进程和线程切换要经过用户态到内核态再到用户态的过程，而协程的切换可以直接在用户态完成，不需要陷入内核态，切换效率高，降低资源消耗。
  - Lua协程与线程类似，拥有独立的堆栈、独立的局部变量、独立的指令指针，同时又与其他协同程序共享全局变量和其他大部分东西。
* cosocoket
  - cosocket将 Lua 协程和 Nginx 的事件机制结合在一起，最终实现了非阻塞网络IO。不仅和HTTP客户端之间的网络通信是非阻塞的，与MySQL、Memcached以及Redis等众多后端之间的网络通信也是非阻塞的。
  - 在OpenResty中调用一个cosocket相关的网络函数
    + 用户的Lua脚本每触发一个网络操作，都会有协程的yield和resume。当遇到网络 I/O 时，Lua协程会交出控制权（yield），把网络事件注册到 Nginx 监听列表中，并把运行权限交给 Nginx 。
    + 当有 Nginx 注册网络事件到达触发条件时，便唤醒（resume）对应的协程继续处理。这样就可以实现全异步的 Nginx 机制，不会影响 Nginx 的高并发处理性能。
* 多阶段处理：在HTTP处理阶段基础上分别在Rewrite/Access阶段、Content阶段、Log阶段注册了自己的handler
  - init_by_lua*：Master进程加载 Nginx 配置文件时运行，一般用来注册全局变量或者预加载Lua模块。
  - init_worker_by_lua*：每个worker进程启动时执行，通常用于定时拉取配置/数据或者进行后端服务的健康检查。
  - set_by_lua*：变量初始化。
  - rewrite_by_lua*:可以实现复杂的转发、重定向逻辑。
  - access_by_lua*:IP准入、接口权限等情况集中处理。
  - content_by_lua*:内容处理器，接收请求处理并输出响应。
  - header_filter_by_lua*:响应头部或者cookie处理。
  - body_filter_by_lua*:对响应数据进行过滤，如截断或者替换。
  - log_by_lua*:会话完成后，本地异步完成日志记录

## 语法

* Lua 接口还提供了一种特殊的空值，即 ngx.null，用来表示不同于 nil 的“空值”
* 内部调用：为了保护对数据库、内部公共函数的统一接口，把这些接口设置为 internal，利用 ngx.location.capture_multi 函数，直接完成了两个子请求并行执行。当两个请求没有相互依赖，这种方法可以极大提高查询效率。这么做的最主要好处就是可以让这个内部接口相对独立，不受外界干扰
* 流水线方式跳转：ngx.exec 方法与 ngx.redirect 是完全不同的，前者是个纯粹的内部跳转并且没有引入任何额外 HTTP 信号。
* 外部重定向
* 异步输出:当调用 ngx.say 后并不会立刻输出响应体
* 响应体过大输出:输出内容本身体积很大，例如超过 2G 的文件下载;输出内容本身是由各种碎片拼凑的，碎片数量庞大，例如应答数据是某地区所有人的姓名
  - 没有必要一定连接成字符串后再进行输出。完全可以直接存放在 table 中，用数组的方式把这些碎片数据统一起来，直接调用 ngx.print(table) 即可

```
nginx -p `pwd`/ -c conf/nginx.conf
```

## 日志

* 主力作者对测试和调试代码
  - Luiz Henrique de Figueiredo：我主要是一块一块的构建，分块测试。我很少使用调试器。即使用调试器，也只是调试 C 代码。我从不用调试器调试 Lua 代码。对于 Lua 来说，在适当的位置放几条打印语句通常就可以胜任了
  - Roberto Ierusalimschy：差不多也是这样。使用调试器时，通常只是用来查找代码在哪里崩溃了。对于 C 代码，有个像 Valgrind 或者 Purify 这样的工具是必要
* 日志级别
  - ngx.STDERR     -- 标准输出
  - ngx.EMERG      -- 紧急报错
  - ngx.ALERT      -- 报警
  - ngx.CRIT       -- 严重，系统故障，触发运维告警系统
  - ngx.ERR        -- 错误，业务不可恢复性错误
  - ngx.WARN       -- 告警，业务中可忽略错误
  - ngx.NOTICE     -- 提醒，业务比较重要信息
  - ngx.INFO       -- 信息，业务琐碎日志信息，包含不同情况判断等
  - ngx.DEBUG      -- 调试
* [lua-resty-logger-socket](https://github.com/cloudflare/lua-resty-logger-socket):Raw-socket-based Logger Library for Nginx (based on ngx_lua)

## Nginx 内置绑定变量

* $arg_name     请求中的name参数
  - $args     请求中的参数
  - `$binary_remote_addr`     远程地址的二进制表示
  - `$body_bytes_sent`     已发送的消息体字节数
  - $content_length     HTTP请求信息里的"Content-Length"
  - $content_type     请求信息里的"Content-Type"
  - $document_root     针对当前请求的根路径设置值
  - $document_uri     与$uri相同; 比如 /test2/test.php
  - $host     请求信息中的"Host"，如果请求中没有Host行，则等于设置的服务器名
  - $hostname     机器名使用 gethostname系统调用的值
  - $http_cookie     cookie 信息
  - $http_referer     引用地址
  - $http_user_agent     客户端代理信息
  - $http_via     最后一个访问服务器的Ip地址。
  - $http_x_forwarded_for     相当于网络访问路径
  - $is_args     如果请求行带有参数，返回“?”，否则返回空字符串
  - $limit_rate     对连接速率的限制
  - $nginx_version     当前运行的nginx版本号
  - $pid     worker进程的PID
  - $query_string     与$args相同
  - $realpath_root 按root指令或alias指令算出的当前请求的绝对路径。其中的符号链接都会解析成真是文件路径
  - $remote_addr     客户端IP地址
  - $remote_port     客户端端口号
  - $remote_user     客户端用户名，认证用
  - $request     用户请求
  - `$request_body`    这个变量（0.7.58+）包含请求的主要信息。在使用proxy_pass或fastcgi_pass指令的location中比较有意义
  - `$request_body_file`     客户端请求主体信息的临时文件名
  - $request_completion     如果请求成功，设为"OK"；如果请求未完成或者不是一系列请求中最后一部分则设为空
  - $request_filename     当前请求的文件路径名，比如/opt/nginx/www/test.php
  - $request_method     请求的方法，比如"GET"、"POST"等
  - $request_uri     请求的URI，带参数
  - $scheme     所用的协议，比如http或者是https
  - $server_addr     服务器地址，如果没有用listen指明服务器地址，使用这个变量将发起一次系统调用以取得地址(造成资源浪费)
  - $server_name     请求到达的服务器名
  - $server_port     请求到达的服务器端口号
  - $server_protocol     请求的协议版本，"HTTP/1.0"或"HTTP/1.1"
  - $uri     请求的URI，可能和最初的值有不同，比如经过重定向之类的

## 子查询

* 可以发起非阻塞的内部请求访问目标 location。目标 location 可以是配置文件中其他文件目录，或 任何 其他 nginx C 模块，包括 ngx_proxy、ngx_fastcgi、ngx_memc、ngx_postgres、ngx_drizzle，甚至 ngx_lua 自身等等
* 只是模拟 HTTP 接口的形式， 没有 额外的 HTTP/TCP 流量，也 没有 IPC (进程间通信) 调用。所有工作在内部高效地在 C 语言级别完成
* 与 HTTP 301/302 重定向指令 (通过 ngx.redirect) 完全不同，也与内部重定向 ((通过 ngx.exec) 完全不同。
* 在发起子请求前，用户程序应总是读取完整的 HTTP 请求体 (通过调用 ngx.req.read_body 或设置 lua_need_request_body 指令为 on).
* 该 API 方法（ngx.location.capture_multi 也一样）总是缓冲整个请求体到内存中。因此，当需要处理一个大的子请求响应，用户程序应使用 cosockets 进行流式处理
* 通过 ngx.location.capture 创建的子请求默认继承当前请求的所有请求头信息，这有可能导致子请求响应中不可预测的副作用

## 不同阶段共享变量

* 可以通过共享内存的方式完成不同工作进程的数据共享，可以通过 Lua 模块方式完成单个进程内不同请求的数据共享.ngx.ctx 表就是为了解决这类问题而设计的
* ngx.ctx 是一个表，可以添加、修改。用来存储基于请求的 Lua 环境数据，其生存周期与当前请求相同 (类似 Nginx 变量)
* 一个最重要的特性：单个请求内的 rewrite (重写)，access (访问)，和 content (内容) 等各处理阶段是保持一致的
* 每个请求，包括子请求，都有一份自己的 ngx.ctx 表

## SQL 注入

* 对输入参数进行一层过滤:调用 ndk.set_var.set_quote_sql_str

```lua
local req_id = [[1'; drop table cats;--]]
res, err, errno, sqlstate =
    db:query(string.format([[select * from cats where id = %s]],
    ndk.set_var.set_quote_sql_str(req_id)))
if not res then
    ngx.say("bad result: ", err, ": ", errno, ": ", sqlstate, ".")
    return
end
```

## 发起新 HTTP 请求

* proxy_pass
* cosocket

## 工具

* [lua-resty-jwt](https://github.com/SkyLothar/lua-resty-jwt):JWT For The Great Openresty
* [lua-resty-validation](https://github.com/bungle/lua-resty-validation):Validation Library (Input Validation and Filtering) for Lua and OpenResty.
* [lua-nginx-module](https://github.com/openresty/lua-nginx-module):Embed the Power of Lua into NGINX HTTP servers <https://openresty.org/>
* [ngx_lua_waf](https://github.com/loveshell/ngx_lua_waf):一个基于lua-nginx-module(openresty)的web应用防火墙
* [lua-resty-limit-traffic](https://github.com/openresty/lua-resty-limit-traffic):Lua library for limiting and controlling traffic in OpenResty/ngx_lua

## 参考

* [openresty实践](https://openresty.net.cn/index.html)
* [OpenResty最佳实践](https://moonbingbing.gitbooks.io/openresty-best-practices/content/) todo:访问有授权验证的 Redis
