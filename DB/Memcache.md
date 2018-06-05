# [memcached/memcached](https://github.com/memcached/memcached)

Memcached是一个自由开源的，高性能，分布式内存对象缓存系统。Memcached是一种基于内存的key-value存储，用来存储小块的任意数据（字符串、对象）。这些数据可以是数据库调用、API调用或者是页面渲染的结果。

使用目的是，通过缓存数据库查询结果，减少数据库访问次数，以提高动态Web应用的速度、提高可扩展性。

* 协议简单
* 基于libevent的事件处理
* 内置内存存储方式
* memcached不互相通信的分布式

## 安装

依赖libevent库

```sh
## memcache
memcached.exe -d install|start|stop

## Mac
brew install memcached
brew install libmemcached php71-memcached# 安装客户端库

# ubuntu
yum install memcached
sudo apt-get install memcached php-memcached

wget http://memcached.org/latest
tar -zxvf memcached-1.x.x.tar.gz
cd memcached-1.x.x
./configure --prefix=/usr/local/memcached
make && make test && sudo make install

# 启动服务:
# -d是启动一个守护进程
# -m是分配给Memcache使用的内存数量，单位是MB
# -l是监听的服务器IP地址，可以有多个地址
# -p是设置Memcache监听的端口
/usr/local/bin/memcached -d
brew services start memcached -d
memcached -d -m 2048 -l 10.0.0.40 -p 11211
memcached -p 11211 -m 64m -vv # 显示了调试信息
```

### 客户端

telnet
* set:将 value(数据值) 存储在指定的 key(键) 中:set key flags exptime bytes [noreply]
    - key：键值 key-value 结构中的 key，用于查找缓存值。
    - flags：可以包括键值对的整型参数，客户机使用它存储关于键值对的额外信息 。
    - exptime：在缓存中保存键值对的时间长度（以秒为单位，0 表示永远）
    - bytes：在缓存中存储的字节数
    - noreply（可选）： 该参数告知服务器不需要返回数据
    - value：存储的值（始终位于第二行）（可直接理解为key-value结构中的value）
* add 命令用于将 value(数据值) 存储在指定的 key(键) 中:key 已经存在，则不会更新数据(过期的 key 会更新)，之前的值将仍然保持相同，并且您将获得响应 NOT_STORED。
* replace 命令用于替换已存在的 key(键) 的 value(数据值)。如果 key 不存在，则替换失败，并且您将获得响应 NOT_STORED。
* append 命令用于向已存在 key(键) 的 value(数据值) 后面追加数据
* prepend 命令用于向已存在 key(键) 的 value(数据值) 前面追加数据
* CAS（Check-And-Set 或 Compare-And-Swap） 命令用于执行一个"检查并设置"的操作.它仅在当前客户端最后一次取值后，该key 对应的值没有被其他客户端修改的情况下， 才能够将值写入。.检查是通过cas_token参数进行的， 这个参数是Memcach指定给已经存在的元素的一个唯一的64位值。
    - 从 Memcached 服务商通过 gets 命令获取令牌（token）
    - gets 命令获取带有 CAS 令牌存 的 value
* get key1 key2 key3
* delete key
* incr|decr key increment_value:数据必须是十进制的32位无符号整数
* stats 命令用于返回统计信息例如 PID(进程号)、版本号、连接数
* 

```
telnet HOST PORT

set key flags exptime bytes [noreply]
value

cas key flags exptime bytes unique_cas_token [noreply]
value
```

## 参考

* [Site](https://memcached.org)
* [Memcached 教程](http://www.runoob.com/memcached/memcached-tutorial.html)

## 问题

通过Memcached将热点数据加载到cache，加速访问。随着业务数据量的不断增加，和访问量的持续增长

* MySQL需要不断进行拆库拆表，Memcached也需不断跟着扩容，扩容和维护工作占据大量开发时间。
* Memcached与MySQL数据库数据一致性问题。
* Memcached数据命中率低或down机，大量访问直接穿透到DB，MySQL无法支撑。
* 跨机房cache同步问题。
