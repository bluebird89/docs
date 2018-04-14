# Swoole

Event-driven asynchronous & concurrent & coroutine networking engine with high performance for PHP.

- [swoole/swoole-src](https://github.com/swoole/swoole-src):Event-driven asynchronous & concurrent & coroutine networking engine with high performance for PHP. <http://www.swoole.com/>
- [官方文档](https://github.com/cloes/swoole-doc)

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

pecl install swoole

cp -R /usr/local/Cellar/openssl/1.0.2o_1/include/openssl /usr/local/include # fatal error: 'openssl/ssl.h' file not found #include <openssl/ssl.h>
    # Enable http2 support, require nghttp2 library.
brew install hiredis # fatal error: 'hiredis/hiredis.h'

brew install swoole
```

## 基础

多线程编程

进程间通信

网络协议TCP/UDP的认知

PHP的各项基本技能

## 资料

- [Concise Guide to Swoole文档](https://linkeddestiny.gitbooks.io/easy-swoole/content/)
- [源码分析](https://github.com/LinkedDestiny/swoole-src-analysis)

## 框架扩展

- [matyhtf/framework](https://github.com/matyhtf/framework)PHP advanced Web development framework. The built-in application server based on the development of swoole extension
- [LinkedDestiny/swoole-yaf](https://github.com/LinkedDestiny/swoole-yaf)
- [LinkedDestiny/swoole-thinkphp](https://github.com/LinkedDestiny/swoole-thinkphp)
- [shenzhe/zphp](https://github.com/shenzhe/zphp)ZPHP是一个极轻的的，定位于后置SOA服务的框架，可开发独立高效的长驻服务，并能适应多端的变化。
- [youzan/yz_swoole](https://github.com/youzan/yz_swoole)youzan swoole branch
- [matyhtf/webim](https://github.com/matyhtf/webim):使用PHP+Swoole实现的网页即时聊天工具
