# PHP-FPM (PHP-FastCGI Process Manager)

* 多进程 FastCGI 管理程序
* 常驻内存启动一些PHP进程待命，当请求进入时分配一个进程进行处理，PHP进程处理完毕后回收进程，并不销毁进程，让PHP也能应对高流量的访问请求
* PHP-FPM 是 FastCGI 的实现，提供了进程管理功能
  - master 进程负责与 Web 服务器进行通信，接收 HTTP 请求，再将请求转发给 worker 进程进行处理
  - worker 进程负责动态执行 PHP 代码，处理完成后，将处理结果返回给 Web 服务器，再由 Web 服务器将结果发送给客户端
* Nginx 通过 FastCGI 协议将请求转发给 PHP-FPM 处理，PHP-FPM 的 Worker 进程会抢占式的获得 CGI 请求进行处理，整个的过程是阻塞等待的，也就意味着 PHP-FPM 的进程数有多少能处理的请求也就是多少
* 高并发的场景下，异步非阻塞就显得优势明显
  - Worker 进程 不再同步阻塞的去处理一个请求，而是可以同时处理多个请求，无需 I/O 等待，并发能力极强，可以同时发起或维护大量的请求
  - 缺点大家可能也都知道，就是永无止境的回调

## 安装

* 约定目录
  - bin: /usr/local/php/sbin/php-fpm
* 配置文件路径
  - /usr/local/php/etc/php.ini
  - /usr/local/php/etc/php-fpm.conf
  - /private/etc/php-fpm.conf
  - /private/etc/php-fpm.d/www.conf.default
  - /usr/local/etc/php/7.3/php-fpm.d/www.conf

```sh
brew install php --without-apache --with-fpm
brew services start php
```

## 原理

* socket 是Nginx 与 PHP 的通信载体
  - fastcgi_pass所配置的内容，是告诉Nginx接收到用户请求以后该往哪里转发
  - fastcgi 是实现 webserver 协议的一种实现
* 运作模式
  - 使用 Nginx 提供 HTTP 服务（Apache 同理），所有客户端发起的请求最先抵达的都是 Nginx
  - Nginx 通过 FastCGI 协议将请求转发给 PHP-FPM 处理
  - PHP-FPM 的 Master进程 会为每个请求分配一个 Worker进程来处理
    + 在启动阶段设置 HTTP 环境变量，然后通过 PHP 核心代码初始化所有已经启用的 PHP 模块（即扩展），并对此次请求上下文进行初始化，完成，这些操作后再调用 Zend 引擎来编译并执行业务逻辑代码
    + 等待 PHP 脚本的解析，等待业务处理的结果返回，完成后回收子进程，这整个的过程是阻塞等待的，也就意味着 PHP-FPM 的进程数有多少能处理的请求也就是多少，假设 PHP-FPM 有 200 个 Worker进程，一个请求将耗费 1 秒的时间，那么简单的来说整个服务器理论上最多可以处理的请求也就是 200 个，QPS 即为 200/s，
    + 在高并发的场景下，这样的性能是不够的，尽管可以利用 Nginx 作为负载均衡配合多台 PHP-FPM 服务器来提供服务，但由于 PHP-FPM 的阻塞等待的工作模型，一个请求会占用至少一个 MySQL 连接，多节点高并发下会产生大量的 MySQL 连接，而 MySQL 的最大连接数默认值为 100，尽管可以修改，但显而易见该模式没法很好的应对高并发的场景
  - Zend 引擎会检查 OpCode 缓存，如果代码片段已经缓存，则从缓存中读取并执行，否则还要编译成 OpCode 并缓存后才能执行
  - 代码执行完成后，会将处理结果打印或着发送 HTTP 响应给客户端，然后 PHP 底层代码会执行请求关闭及模块关闭函数进行后续清理工作，最后再回到 SAPI 层，调用 PHP-FPM 对应的关闭函数，从而完成此次请求的所有流程
  - 过程周而复始，每次用户有新请求过来都会从头执行一遍，所有的环境初始化、模块初始化、请求初始化以及 Laravel 应用的启动过程，乃至后续请求关闭、模块关闭、PHP-FPM 关闭
* 在 Nginx + PHP-Fpm 模式下开发非常简单 不用担心内存泄露
  - nginx基于epoll事件模型，一个worker同时可处理多个请求
  - fpm-worker在同一时刻可处理一个请求
  - fpm-worker每次处理请求前需要重新初始化mvc框架，然后再释放资源
  - 高并发请求时，fpm-worker不够用，nginx直接响应502
  - fpm-worker进程间切换消耗大
* php的fastcgi进程管理器php-fpm和nginx的配合已经运行得足够好，但是由于php-fpm本身是同步阻塞进程模型，在请求结束后释放所有的资源（包括框架初始化创建的一系列对象，导致PHP进程空转（创建<-->销毁<-->创建）消耗大量的CPU资源，从而导致单机的吞吐能力有限。请求夯住，会导致 CPU 不能释放资源， 大大浪费了 CPU 使用率。
* php-fpm进程模型非常简单，属于预派生子进程模式。Apache 就是采用该模式来一个请求就 fork 一个进程，进程的开销是非常大的。这会大大降低吞吐率，并发数由进程数决定。
  - 程序启动后就会创建N个进程。每个子进程进入Accept，等待新的连接进入
  - 当客户端连接到服务器时，其中一个子进程会被唤醒，开始处理客户端请求，并且不再接受新的TCP连接
  - 当此连接关闭时，子进程会释放，重新进入Accept，参与处理新的连接
* 优点
  - 完全可以复用进程，不需要太多的上下文切换
* 缺点
  - 严重依赖进程的数量解决并发问题，一个客户端连接就需要占用一个进程，工作进程的数量有多少，并发处理能力就有多少。操作系统可以创建的进程数量是有限的。
  - PHP框架初始化会占用大量的计算资源，每个请求都需要初始化
  - 启动大量进程会带来额外的进程调度消耗。数百个进程时可能进程上下文切换调度消耗占CPU不到1%可以忽略不计，如果启动数千甚至数万个进程，消耗就会直线上升。调度消耗可能占到 CPU 的百分之几十甚至 100%。
  - 如果请求一个第三方请求非常慢，请求过程中会一直占用 CPU 资源，浪费了昂贵的硬件资源
* 解决
  - IO密集性业务：频繁的上下文切换
    + 提高IO复用的能力
    + 将php-fpm同步阻塞模式替换为异步非阻塞模式，异步开启模式比较复杂不易维护，当然不一定使用php-fpm
  - 线程模式开发太过复杂
    + 一个进程中能开的线程数也有限，线程太多也会增加 CPU 的负荷和内存资源，线程没有阻塞态，IO 阻塞也不能主动让出 CPU资源，属于抢占式调度模型。不太适合 php 开发。
  - swoole 4.+开启了全协程模式，让同步代码异步执行

![php-fpm工作模式](../../_static/php-fpm-struct.png "Optional title")

## 服务

```
# 测试php-fpm配置
/usr/local/php/sbin/php-fpm -t
/usr/local/php/sbin/php-fpm -c /usr/local/php/etc/php.ini -y /usr/local/php/etc/php-fpm.conf -t

#启动php-fpm
/usr/local/php/sbin/php-fpm -c /usr/local/php/etc/php.ini -y /usr/local/php/etc/php-fpm.conf
/usr/local/Cellar/php71/7.1.10_21/sbin/php-fpm --daemonize --fpm-config /usr/local/etc/php/7.1/php-fpm.conf --pid /usr/local/var/run/php-fpm.pid`

ps aux | grep -c php-fpm # 查看php-fpm进程数
ps aux | grep php-fpm 查看php-fpm的master进程号

## Mac
php-fpm -D # 启动
kill -INT `cat /usr/local/php/var/run/php-fpm.pid`
kill -USR2 `cat /usr/local/php/var/run/php-fpm.pid` # 平滑重启
pkill php-fpm # 强制关闭
killall php-fpm # 关闭进程

## linux 进程管理
sudo service php7.0-fpm {start|stop|status|restart|reload|force-reload}
sudo systemctl status php7.3-fpm

/etc/init.d/php7.2-fpm start
/usr/local/php/sbin/php-fpm # 启动
killall php-fpm
```

## 配置

* nginx 一般是把请求根据请求类型，加载 对应的 fast-cgi 模块，fascgi管理进程选择cgi 子进程处理结果，并返回给nginx
* 静态：直接开启指定数量的php-fpm进程，不再增加或者减少
* 动态：开始的时候开启一定数量的php-fpm进程，当请求量变大的时候，动态的增加php-fpm进程数到上限，当空闲的时候自动释放空闲的进程数到一个下限。
* 通信方式
  - Unix socket:又叫 IPC(inter-process communication 进程间通信) socket，用于实现同一主机上的进程间通信，这种方式需要在 nginx配置文件中填写 php-fpm 的 socket 文件位置。
    + 与管道相比，Unix domain sockets 既可以使用字节流和数据队列，而管道通信则只能通过字节流
    + Unix domain socket 的功能是POSIX操作系统里的一种组件。Unix domain sockets 使用系统文件的地址来作为自己的身份。可以被系统进程引用。所以两个进程可以同时打开一个Unix domain sockets来进行通信。不过这种通信方式是发生在系统内核里而不会在网络里传播。压力比较满的时候，用套接字方式，效果确实比较好
    - Unix domain sockets的接口和Internet socket很像，但不使用网络底层协议来通信,不需要经过网络协议栈，不需要打包拆包、计算校验和、维护序号和应答等，只是将应用层数据从一个进程拷贝到另一个进程。所以其效率比 tcp socket 的方式要高，可减少不必要的 tcp 开销。
    - unix socket 高并发时不稳定，连接数爆发时，会产生大量的长时缓存，在没有面向连接协议的支撑下，大数据包可能会直接出错不返回异常。而 tcp 这样的面向连接的协议，可以更好的保证通信的正确性和完整性。
    - 由于 socket 文件本质上是一个文件，存在权限控制的问题，所以需要注意 nginx 进程的权限与 php-fpm 的权限问题，不然会提示无权限访问
  - TCP sockets:使用TCP端口连接127.0.0.1:9000，可以跨服务器，当 nginx 和 php-fpm 不在同一台机器上时，只能使用这种方式

用到一些 PHP 的第三方库，这些第三方库经常存在内存泄漏问题，如果不定期重启 PHP-CGI 进程，势必造成内存使用量不断增长。因此 PHP-FPM 作为 PHP-CGI 的管理器，提供了这么一项监控功能，对请求达到指定次数的 PHP-CGI 进程进行重启，保证内存使用量不增长。

## 连接方式

与CPU 频率缩放问题一样？（CPUFreq governor）这些设置在类 Unix 系统和 Windows 上是有效的，可以通过修改 CPU governor，将其从 ondemand 修改为 performance 来提高性能并加快系统的响应。

* Governor = ondemand：根据当前负荷动态调整 CPU 频率。先将 CPU 频率调整至最大，然后随着空闲时间的增加而缩小频率。
* Governor = conservative：根据当前负荷动态调整频率。比设置成 ondemand 更加缓慢。
* Governor = performance：始终以最大频率运行 CPU。

CPU Governor 的 performance 设置是一个非常安全的性能提升方式，因为它能完美的使用你服务器 CPU 的全部性能。唯一需要考虑的因素就是一些诸如散热、电池寿命（笔记本电脑）和一些由 CPU 始终保持 100% 所带来的一些副作用。一旦设置为 performance，那么它确实是你 CPU 最快的设置。

static 设置取决于你服务器有多少闲置内存。大多数情况下，如果你服务器的内存不足，那么 PM 设置成 ondemand 或 dynamic 将是更好的选择。
但是，一旦你有可用的闲置内存，那么把 PM 设置成 static 的最大值将减少许多 PHP 进程管理器（PM）所带来的开销。
换句话说，你应该在没有内存不足和缓存压力的情况下使用 pm.static 来设置 PHP-FPM 进程的最大数量。此外，也不能影响到 CUP 的使用和其他待处理的 PHP-FPM 操作。

当流量波动比较大的时候，，PHP-FPM 的 ondemand 和 dynamic 会因为固有开销而限制吞吐量。 您需要了解您的系统并设置 PHP-FPM 进程数，以匹配服务器的最大容量。

从 pm.max_children 开始，根据 pm dynamic 或 ondemand 的最大使用情况去设置

在 pm static 模式下，因为您将所有内容都保存在内存中，所以随着时间的推移，流量峰值会对 CPU 造成比较小的峰值，并且您的服务器负载和 CPU 平均值将变得更加平滑。 每个需要手动调整的 PHP-FPM 进程数的平均大小会有所不同

* pm = dynamic
  - 子进程的数量是根据以下指令来动态生成的：pm.max_children, pm.start_servers, pm.min_spare_servers, pm.max_spare_servers.
  - dynamic模式，可能会出现mysql连接数被占满的情况，这也跟mysql服务的连接超时时间有关
* pm = ondemand：在服务启动的时候根据 pm.start_servers 指令生成进程，而非动态生成。
* pm = static：子进程的数量是由 pm.max_children 指令来确定的。
  - static 设置取决于你服务器有多少闲置内存
* 短连接：应对并发消耗过多的资源开销
* 长连接：不同请求会使用同一个连接句柄

## 状态查看

* 在server配置中添加
* 开启缓存

```
location ~ ^/status$ {
    include fastcgi_params;
    fastcgi_split_path_info ^(.+\.php)(/.+)$; # NOTE: You should have "cgi.fix_pathinfo = 0;" in php.ini
    fastcgi_pass unix:/usr/local/var/run/php-fpm.sock;
    fastcgi_param SCRIPT_FILENAME $fastcgi_script_name;
}

pm.status_path = /status # php-fpm.conf里面打开选项
# 访问 http://域名/status
```

## 问题

* FPM's security.limit_extension setting is used to limit the extensions of the main script it will be allowed to parse. It prevents malicious code from being executed. The default value is simply .php It can be configured in /etc/php5/fpm/pool.d/www.conf
* 解决：cgi.fix_pathinfo=1
* 待测试： fastcgi_param PATH_TRANSLATED $document_root$fastcgi_path_info; 屏蔽掉

```
2018/09/02 23:26:10 [error] 37283#0: *69 FastCGI sent in stderr: "Access to the script '/Users/henry/Workspace/Code/PHP' has been denied (see security.limit_extensions)" while reading response header from upstream, client: 127.0.0.1, server: localhost, request: "GET / HTTP/1.1", upstream: "fastcgi://unix:/usr/local/var/run/php-fpm.sock:", host: "localhost:8080"
#  www.conf
security.limit_extensions = .php .php3 .php4 .php5

ERROR: failed to open error_log (/usr/var/log/php-fpm.log): No such file or directory

vim /usr/local/etc/php-fpm.conf
error_log = /usr/local/var/log/php-fpm.log
pid = /usr/local/var/run/php-fpm.pid
```
