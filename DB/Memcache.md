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

### 客户端测试

```
telnet HOST PORT
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
