# [memcached](https://github.com/memcached/memcached)

Memcached是一个自由开源的，高性能，分布式内存对象缓存系统,基于内存的key-value存储，用来存储小块的任意数据（字符串、对象）<https://memcached.org>

* 目的:通过缓存数据库查询结果，减少数据库访问次数，以提高动态Web应用的速度、提高可扩展性
* 协议简单
* 基于libevent的事件处理
* 内置内存存储方式
* memcached不互相通信的分布式

## 安装

* 依赖libevent库
* igbinary is a faster and more compact binary serializer for PHP data structures
* msgpack is a faster and more compact data structure representation that is interoperable with msgpack implementations for other languages

```sh
## window
memcached.exe -d install|start|stop

## Mac
brew install libmemcached memcached
brew install zlib
brew services start memcached -d

yum install libmemcached libmemcached-devel
yum install zlib zlib-devel # 压缩
yum install memcached

# ubuntu
sudo apt-get install memcached libmemcached-tools php-memcached
sudo pecl install memcache

wget http://memcached.org/latest
tar -zxvf memcached-1.x.x.tar.gz
cd memcached-1.x.x
./configure --prefix=/usr/local/memcached
make && make test && sudo make install

# 启动服务
# -d是启动一个守护进程
# -m是分配给Memcache使用的内存数量，单位是MB
# -l是监听的服务器IP地址，可以有多个地址
# -p是设置Memcache监听的端口
/usr/local/bin/memcached -d
memcached -d -m 2048 -l 10.0.0.40 -p 11211
memcached -p 11211 -m 64m -vv # 显示了调试信息

# 安装客户端
sudo pecl install memcached

sudo systemctl restart|status memcached

echo "stats settings" | nc localhost 11211
```

## 概念

* 指定给已经存在的元素的一个唯一的64位值,全局唯一自增
* 冷热数据

## 客户端

* [memcache](http://pecl.php.net/package/memcache)    memcached extension
  - 独立用php实现，是老客户端，从实践中已发现有多个问题，而且功能少，属性也可设置的少
* [memcached](http://pecl.php.net/package/memcached)   PHP extension for interfacing with memcached via libmemcached library
  - 需要 libmemcached 客户端库
  - 基于原生的c的libmemcached的扩展，更加完善，建议替换为php memcached

## 配置

* -p Specifies on which port Memcached should listen. The default port is 11211
* -l 监听的ip地址，127.0.0.1是本机，当然也可以写上你的服务器IP，如：10.0.0.10，这是服务器的IP地址，如果需要多个服务器都能够读取这台memcached的缓存数据，那么就必须设定这个ip
* -d 以daemon方式运行，将程序放入后台
* -u  Specifies with which user the service will use to run. By default, the service will run as root
* -P 的pid文件路径
* -m 可以使用的最大内存数量 Caps the amount of memory available to Memcached
* -c Caps the number of concurrent connections. The default is 1024.
* -s socket文件路径

```
# /etc/memcached.conf
-l 127.0.0.1 # bind Memcached to the local interface to avoid potential DDOS attacks
-U 0 # restrict UDP  sudo netstat -plunt

memcstat --servers="localhost"
```

## 方法

* `set key flags exptime bytes [noreply]`:新增或更新
  - key：键值 key-value 结构中的 key
  - flags：可以包括键值对的**整型参数**，存储关于键值对的额外信息
  - exptime：在缓存中保存键值对的时间长度（以秒为单位，0 表示永远）
  - bytes：在缓存中存储的字节数
  - noreply（可选）： 该参数告知服务器不需要返回数据
  - value：存储的值（始终位于第二行）
  - key已存在，更新该key数据（更新）
* `add key flags exptime bytes [noreply]`：新增不存在或失效
  - key 不存在或失效情况添加成功，返回STORED
  - key 已存在且未失效则添加失败，响应 NOT_STORED
* `replace key flags exptime bytes [noreply]` 更新
  - 如果 key 不存在，则替换失败，响应 NOT_STORED
* `append key flags exptime bytes [noreply]` 向已存在 key(键) 的 value(数据值) 后面追加数据
  - STORED：保存成功后输出
  - NOT_STORED：该键在 Memcached 上不存在
  - CLIENT_ERROR：执行错误
* `prepend key flags exptime bytes [noreply]` 命令用于向已存在 key(键) 的 value(数据值) 前面追加数据
  - STORED：保存成功后输出。
  - NOT_STORED：该键在 Memcached 上不存在。
  - CLIENT_ERROR：执行错误。
* `gets key1 [key2 key3]` 获取带有 CAS 令牌存 的 value(数据值)
  - 如果 key 不存在，则返回空

  - 输出结果中最后一列的数字 值 代表了该 key  的 CAS 令牌，值更新后令牌会更新
* `cas key flags exptime bytes unique_cas_token [noreply]`（Check-And-Set 或 Compare-And-Swap）: 用于执行一个"检查并设置"的操作 锁机制
  - 仅在当前客户端最后一次取值后，该 key 对应的值没有被其他客户端修改的情况下， 才能够将值写入
  - 通过cas_token参数进行检查值有没有被其他客户端修改的情况下，带有原来值的验证
  - STORED：保存成功后输出。
  + ERROR：保存出错或语法错误。
  + EXISTS：在最后一次取值后另外一个用户也在更新该数据。
  + NOT_FOUND：Memcached 服务上不存在该键值
* `get key1 [key2 key3]` 获取存储在 key(键) 中的 value(数据值)
  - key 不存在，则返回空
* `delete key`:删除已存在的 key
  - DELETED：删除成功
  - ERROR：语法错误或删除失败
  - NOT_FOUND：key 不存在
* `incr|decr key increment_value`:对已存在的 key(键) 的数字值进行自增或自减操作
  - 数据必须是十进制的32位无符号整数
  - 返回操作后的结果
  - NOT_FOUND：key 不存在
  - CLIENT_ERROR：自增值不是对象
  - ERROR 其他错误，如语法错误等
* `flush_all [time] [noreply]`: 清理缓存中的所有 key=>value(键=>值) 对
  - 可选参数 time，用于在指定时间后执行清理缓存操作
* `stats`: 查看统计信息
  - pid：  memcache服务器进程ID
  - uptime：服务器已运行秒数
  - time：服务器当前Unix时间戳
  - version：memcache版本
  - pointer_size：操作系统指针大小
  - rusage_user：进程累计用户时间
  - rusage_system：进程累计系统时间
  - curr_connections：当前连接数量
  - total_connections：Memcached运行以来连接总数
  - connection_structures：Memcached分配的连接结构数量
  - cmd_get：get命令请求次数
  - cmd_set：set命令请求次数
  - cmd_flush：flush命令请求次数
  - get_hits：get命令命中次数
  - get_misses：get命令未命中次数
  - delete_misses：delete命令未命中次数
  - delete_hits：delete命令命中次数
  - incr_misses：incr命令未命中次数
  - incr_hits：incr命令命中次数
  - decr_misses：decr命令未命中次数
  - decr_hits：decr命令命中次数
  - cas_misses：cas命令未命中次数
  - cas_hits：cas命令命中次数
  - cas_badval：使用擦拭次数
  - auth_cmds：认证命令处理的次数
  - auth_errors：认证失败数目
  - bytes_read：读取总字节数
  - bytes_written：发送总字节数
  - limit_maxbytes：分配的内存总大小（字节）
  - accepting_conns：服务器是否达到过最大连接（0/1）
  - listen_disabled_num：失效的监听数
  - threads：当前线程数
  - conn_yields：连接操作主动放弃数目
  - bytes：当前存储占用的字节数
  - curr_items：当前存储的数据总数
  - total_items：启动以来存储的数据总数
  - evictions：LRU释放的对象数目
  - reclaimed：已过期的数据条目来存储新数据的数目
* `stats items`: 显示各个 slab 中 item 的数目和存储时长(最后一次访问距离现在的秒数)
* `stats slabs`: 显示各个slab的信息，包括chunk的大小、数目、使用情况等
* `stats sizes`: 显示所有item的大小和个数
  - 第一列是 item 的大小，第二列是 item 的个数
* `stats settings`: Inspecting Running Configuration

```
telnet 127.0.0.1 11211 # 登陆
quit # 退出

set runoob 0 900 9 # set 添加
memcached
STORED

set runoob 0 900 5 # set 更新
redis
STORED
get runoob
VALUE runoob 0 5
redis
END

add runoob 0 900 9 # add 添加不成功
memcached
NOT_STORED | STORED

replace runoob 0 60 5 # replace 更新数据
redis
STORED | NOT_STORED

append runoob 0 900 5
redis # _test 没响应
STORED
get runoob
VALUE runoob 0 14
memcachedredis
END

gets runoob
VALUE runoob 0 9 1
memcached
END

cas key flags exptime bytes unique_cas_token [noreply]
value

# 输入没响应
# 报错
CLIENT_ERROR bad data chunk
ERROR
```

## 问题

* MySQL需要不断进行拆库拆表，Memcached也需不断跟着扩容，扩容和维护工作
* Memcached与MySQL数据库数据一致性问题
* Memcached数据命中率低或down机，大量访问直接穿透到DB，MySQL无法支撑
* 跨机房cache同步问题
