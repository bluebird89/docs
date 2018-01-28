# Memcache

memcached 前，先安装了其所依赖的 libevent 库

## 安装

## Mac

```sh
brew search memcache

brew install memcached
brew install libmemcached # 继续安装客户端库

/usr/local/bin/memcached -d
brew services start memcached -d

./memcached -d -m 2048 -l 10.0.0.40 -p 11211

telnet localhost 11211

brew install php71-memcached
```

```
telnet 127.0.0.1 11211


```

## 问题

通过Memcached将热点数据加载到cache，加速访问。随着业务数据量的不断增加，和访问量的持续增长

* MySQL需要不断进行拆库拆表，Memcached也需不断跟着扩容，扩容和维护工作占据大量开发时间。
* Memcached与MySQL数据库数据一致性问题。
* Memcached数据命中率低或down机，大量访问直接穿透到DB，MySQL无法支撑。
* 跨机房cache同步问题。
