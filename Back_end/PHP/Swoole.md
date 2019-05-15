# [swoole/swoole-src](https://github.com/swoole/swoole-src)

Event-driven asynchronous & concurrent & coroutine networking engine with high performance for PHP. <http://www.swoole.com/>

* 常驻内存，避免重复加载带来的性能损耗，提升海量性能，
* 协程异步，提高对 I/O 密集型场景并发处理能力
* 方便地开发Http、WebSocket、TCP、UDP 等应用，可以与硬件通信

## 安装

```sh
wget https://github.com/swoole/swoole-src/archive/v1.10.2.zip
tar zxvf v1.10.2.zip
cd swoole
phpize
./configure  --enable-openssl --enable-async-redis --with-php-config=/Applications/MAMP/bin/php/php7.1.0/bin/php-config    --prefix=/usr/local   CPPFLAGS="-I/usr/local/opt/openssl/include"  LDFLAGS="-L/usr/local/opt/openssl/lib" --enable-swoole-debug
make
sudo make install # 编译后的模块在 /modules 中，将swoole.so添加到php.ini中
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
```

## 基础

* 多线程编程
* 进程间通信
* 网络协议TCP/UDP的认知
* PHP的各项基本技能

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

## 扩展

* [eaglewu/swoole-ide-helper](Auto completion, trigger suggest and view docs for Swoole in editor):Put the source code path into Include Path in IDE.
* [swlib/saber](https://github.com/swlib/saber):Saber, 高性能高可用HTTP客户端 - Swoole人性化组件库 | High performance and high availability HTTP client - Swoole Humanization Component Library 
- [matyhtf/framework](https://github.com/matyhtf/framework)PHP advanced Web development framework. The built-in application server based on the development of swoole extension
- [LinkedDestiny/swoole-yaf](https://github.com/LinkedDestiny/swoole-yaf)
- [LinkedDestiny/swoole-thinkphp](https://github.com/LinkedDestiny/swoole-thinkphp)
- [shenzhe/zphp](https://github.com/shenzhe/zphp)ZPHP是一个极轻的的，定位于后置SOA服务的框架，可开发独立高效的长驻服务，并能适应多端的变化。
- [youzan/yz_swoole](https://github.com/youzan/yz_swoole)youzan swoole branch
- [matyhtf/webim](https://github.com/matyhtf/webim):使用PHP+Swoole实现的网页即时聊天工具
- [xcl3721/Dora-RPC](https://github.com/xcl3721/Dora-RPC):DoraRPC is an RPC For the PHP MicroService by The Swoole
- [bingcool/swoolefy](https://github.com/bingcool/swoolefy):swoolefy是一个基于swoole扩展实现的轻量级高性能的API和MVC应用服务框架

## 框架

* [Tencent/tsf](https://github.com/Tencent/tsf):coroutine and Swoole based php server framework in tencent
* [bixuehujin/blink](https://github.com/bixuehujin/blink):A high performance web framework and application server in PHP. https://docs.rethinkphp.com/blink-framework/v0.4/zh-CN/
* [SwooleDistributed/SwooleDistributed](https://github.com/SwooleDistributed/SwooleDistributed):swoole 分布式全栈框架
* [EasySwoole](https://www.easyswoole.com/Manual/3.x/Cn/_book/)
* [Swoft](https://doc.swoft.org/)
* [One](https://www.kancloud.cn/vic-one/php-one/826876)

## 项目

* [wh469012917/swoole-vue-webim](https://github.com/wh469012917/swoole-vue-webim):一个Web聊天应用，基于Vue和Swoole构建

## 参考

- [Concise Guide to Swoole文档](https://linkeddestiny.gitbooks.io/easy-swoole/content/)
- [源码分析](https://github.com/LinkedDestiny/swoole-src-analysis)
- [官方文档](https://github.com/cloes/swoole-doc)
- [官方Wiki](https://wiki.swoole.com/)
