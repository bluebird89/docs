# [swoole/swoole-src](https://github.com/swoole/swoole-src)

Event-driven asynchronous & concurrent & coroutine networking engine with high performance for PHP. <http://www.swoole.com/>

* 一个异步并行的通信引擎，作为 PHP 的扩展来运行
* 常驻内存，避免重复加载带来的性能损耗，提升海量性能，
* 协程异步，提高对 I/O 密集型场景并发处理能力
* 方便地开发Http、WebSocket、TCP、UDP 等应用，可以与硬件通信
* 优点
    - Node.js 的异步回调 Swoole 有
    - Go语言的协程 Swoole 也有
    - 这完全颠覆了对 PHP 的认知
    - 使用 Swoole PHP 可以实现常驻内存的 Server 程序，可以实现 TCP 、 UDP 异步网络通信的编程开发
* 场景：WebSocket 即使通信、聊天、推送服务器、RPC 远程调用服务、网关、代理、游戏服务器等
* 异步redis

## 安装

```sh
wget https://github.com/swoole/swoole-src/archive/v1.10.2.zip
tar zxvf v1.10.2.zip
cd swoole
phpize
./configure  --enable-openssl --enable-async-redis --with-php-config=/Applications/MAMP/bin/php/php7.1.0/bin/php-config    --prefix=/usr/local   CPPFLAGS="-I/usr/local/opt/openssl/include"  LDFLAGS="-L/usr/local/opt/openssl/lib" --enable-swoole-debug
make
sudo make install # 编译后的模块在 /modules 中，将swoole.so添加到php.ini中

# php.ini
extension=swoole.so

# ubuntu
sudo apt install php-pear
sudo pecl channel-update pecl.php.net
sudo pecl install swoole

cp -R /usr/local/Cellar/openssl/1.0.2o_1/include/openssl /usr/local/include # fatal error: 'openssl/ssl.h' file not found #include <openssl/ssl.h>
    # Enable http2 support, require nghttp2 library.
brew install hiredis # fatal error: 'hiredis/hiredis.h'

brew install swoole
pecl install swoole

pecl install swoole

# add swoole.ini
sudo ln -s  /etc/php/7.2/mods-available/swoole.ini 20-swoole.ini

# check
php -m | grep swoole
# 查看是否有 async_redis => enabled
php --ri swoole
```

## 基础

* 多线程编程
* 进程间通信
* 网络协议TCP/UDP的认知
* PHP的各项基本技能

## Server

```php
# tcp/udp server,可封装rpc
$s = new \Swoole\Server();

//http server,替代fpm
$s = new \Swoole\Http\Server()

// 开启http2 支持,实现基于http2 的grpc
$s = new \Swoole\Http\Server()
$s->set(['open_http2_protocol' => true]);

// websocket
$s = new \Swoole\WebScoket\Server();
```

## Timer

* swoole_timer_tick 间隔的时钟控制器
* swoole_timer_after 指定的时间后执行
* swoole_timer_clear 删除定时器

## 异步task

进程结构

* master
* manager
* task
	- 运行多进程
* worker

## 协程

* 使用go函数可以让一个函数并发地去执行。在编程过程中，如果某一段逻辑可以并发执行，就可以将它放置到go协程中执行
* 使用
    - 使用 go()(\Swoole\Coroutine::create() 的简写) 创建一个协程
    - 在 go() 的回调函数中, 加入协程需要执行的代码(非阻塞代码)
        + 区分哪些是阻塞的, 哪些是非阻塞的: 可以参考 官方wiki - runtime
* 支持的列表:
    - redis扩展
    - 使用mysqlnd模式的pdo、mysqli扩展，如果未启用mysqlnd将不支持协程化
    - soap扩展
    - file_get_contents、fopen
    - stream_socket_client (predis)
    - stream_socket_server
    - stream_select(需要4.3.2以上版本)
    - fsockopen
    - 文件操作 底层使用 AIO 线程池模拟实现
    - fopen / fclose
    - fread / fwrite
    - fgets / fputs
    - file_get_contents / file_put_contents
    - unlink / mkdir / rmdir
    - sleep系列函数
    - sleep / usleep
    - time_nanosleep / time_sleep_until
* 不支持的列表:
    - mysql：底层使用libmysqlclient
    - curl：底层使用libcurl （即不能使用CURL驱动的Guzzle）
    - mongo：底层使用mongo-c-client
    - pdo_pgsql / pdo_ori / pdo_odbc / pdo_firebird
* 协程通信
    - 通道（Channel）:在Swoole4协程中使用new chan就可以创建一个通道。通道可以理解为自带协程调度的队列。它有两个接口push和pop
        + push：向通道中写入内容，如果已满，它会进入等待状态，有空间时自动恢复
        + pop：从通道中读取内容，如果为空，它会进入等待状态，有数据时自动恢复
* 延时任务：用defer实现
* 需要的功能协程 runtime 下还没支持
    - 官方和社区已经贡献了很多协程版 API 可供使用
    - 可以使用 swoole 提供的协程版 client 进行封装, 可以参考 官方 amqp client 封装, 将 socket() 函数实现的 tcp client, 使用 swoole 协程版 tcp client 实现即可
*  swoole 的协程 vs go 的协程
    - 所需要的基础知识: 网络编程 + 协程, 不会因为你是用 swoole 还是 go 而有所减少, 基础不大好, 表现出来了就是学着学着就容易卡住, 效率上不来
    - 以为你写的是 swoole, 不不不, 写的是一个又一个功能的 API, go 也同样(要用到 redis/mysql/mq, 相应的 API 你还是得学得会), 区别在于, swoole 趋势是在底层实现支持(比如 协程runtime), 这样 PHPer 可以无缝切换过来, 而 Gopher 则需要学习一个又一个基于 go 协程封装好的 API. 当初在 PHP 中学习的这些 API, 到 go 里面, 一样需要再熟悉一遍
    - 最后来谈谈性能, 请允许我用一个傲娇一点的说, 用 swoole 达不到的性能, 换个语言, 呵呵呵. 难易程度排行: 加机器 < 加程序员 < 加语言.

```php
// 没有开启协程runtime,需要协程版 API
use Swoole\Coroutine as Co; // 常用的缩写方式

go(function () { // 创建协程, 回调函数中写需要在协程中执行的代码
    echo "daydaygo";
    Co::sleep(1); // 不能是阻塞代码
});

// 开启协程runtime
\Swoole\Runtime::enableCoRoutine();
go(function () { // 创建协程, 回调函数中写需要在协程中执行的代码
    echo "daydaygo";
    sleep(1); // 不能是阻塞代码
});

Swoole\Runtime::enableCoroutine();

go(function () {
    echo "a";
    defer(function () {
        echo "~a";
    });
    echo "b";
    defer(function () {
        echo "~b";
    });
    sleep(1);
    echo "c";
});
```


## HTTP

* Swoole 与 Nginx 结合使用

```
# enable-swoole-php.conf

location ~ [^ /]\.php(/ | $ ) {
	proxy_http_version 1.1 ;
    proxy_set_header Connection "keep-alive";
    proxy_set_header X - Real - IP $remote_addr ;
    proxy_pass http : //127.0.0.1:9501;
}

# list
ps - ef | grep 'swoole_process_server'| grep - v 'grep'
# worker reload
ps aux | grep swoole_process_server_master | awk '{print $2}'| xargs kill - USR1
```

## 项目

* [wh469012917/swoole-vue-webim](https://github.com/wh469012917/swoole-vue-webim):一个Web聊天应用，基于Vue和Swoole构建
* [brewlin/swoft-im](https://github.com/brewlin/swoft-im):基于swoft-cloud的微服务架构，最小化拆分粒度，PHP7、多进程、协程、异步任务、mysql连接池、redi连接池、rpc连接池、服务治理、服务注册与发现、Aop切面、全注解 http://chat.huido.site
* [matyhtf/webim](https://github.com/matyhtf/webim):使用PHP+Swoole实现的网页即时聊天工具

## 框架

* [Tencent/tsf](https://github.com/Tencent/tsf):coroutine and Swoole based php server framework in tencent
* [bixuehujin/blink](https://github.com/bixuehujin/blink):A high performance web framework and application server in PHP. https://docs.rethinkphp.com/blink-framework/v0.4/zh-CN/
* [SwooleDistributed/SwooleDistributed](https://github.com/SwooleDistributed/SwooleDistributed):swoole 分布式全栈框架
* [EasySwoole](https://www.easyswoole.com/Manual/3.x/Cn/_book/)
* [Swoft](https://doc.swoft.org/)
* [One](https://www.kancloud.cn/vic-one/php-one/826876)
* [MixPHP](link)
* [matyhtf/framework](https://github.com/matyhtf/framework)PHP advanced Web development framework. The built-in application server based on the development of swoole extension
* [shenzhe/zphp](https://github.com/shenzhe/zphp)ZPHP是一个极轻的的，定位于后置SOA服务的框架，可开发独立高效的长驻服务，并能适应多端的变化。
* [xcl3721/Dora-RPC](https://github.com/xcl3721/Dora-RPC):DoraRPC is an RPC For the PHP MicroService by The Swoole
* [bingcool/swoolefy](https://github.com/bingcool/swoolefy):swoolefy是一个基于swoole扩展实现的轻量级高性能的API和MVC应用服务框架

## 工具

* [eaglewu/swoole-ide-helper](Auto completion, trigger suggest and view docs for Swoole in editor):Put the source code path into Include Path in IDE.
* [swlib/saber](https://github.com/swlib/saber):Saber, 高性能高可用HTTP客户端 - Swoole人性化组件库 | High performance and high availability HTTP client - Swoole Humanization Component Library 
* [LinkedDestiny/swoole-yaf](https://github.com/LinkedDestiny/swoole-yaf)
* [LinkedDestiny/swoole-thinkphp](https://github.com/LinkedDestiny/swoole-thinkphp)
* [youzan/yz_swoole](https://github.com/youzan/yz_swoole)youzan swoole branch

## 参考

- [Concise Guide to Swoole文档](https://linkeddestiny.gitbooks.io/easy-swoole/content/)
- [源码分析](https://github.com/LinkedDestiny/swoole-src-analysis)
- [官方文档](https://github.com/cloes/swoole-doc)
- [官方Wiki](https://wiki.swoole.com/)
