# ZooKeeper

ZooKeeper is a centralized service for maintaining configuration information, naming, providing distributed synchronization, and providing group services.
ZooKeeper 是一个开放源代码的分布式协调服务。它具有高性能、高可用的特点，同时也具有严格的顺序访问控制能力（主要是写操作的严格顺序性）。基于对 ZAB 协议（ZooKeeper Atomic Broadcast，ZooKeeper 原子消息广播协议）的实现，它能够很好地保证分布式环境中数据的一致性。也正是基于这样的特性，使得 ZooKeeper 成为了解决分布式数据一致性问题的利器。

## 原理

ZooKeeper 由两部分组成：ZooKeeper 服务端和客户端。

* ZooKeeper 服务器采用集群的形式。值得一提的是，只要集群中存在超过一半的、处于正常工作状态的服务器，那么整个集群就能够正常对外服务。组成 ZooKeeper 集群的每台服务器都会在内存中维护当前的 ZooKeeeper 服务状态，并且每台服务器之间都互相保持着通信。
* 客户端在连接 ZooKeeper 服务集群时，会按照一定的随机算法选择集群中的某台服务器，然后和它共同创建一个 TCP 连接，使客户端连上到那台服务器。而当那台服务器失效时，客户端自动会重新选择另一台服务器进行连接，从而保证服务的连续性。
* 当其中一个客户端修改数据时，ZooKeeper 会将修改同步到集群中所有的服务器上，从而使连接到集群中其它服务器上的客户端也能立即看到修改后的数据，很好地保证了分布式环境中数据的一致性。

## 参考

* [apache/zookeeper](https://github.com/apache/zookeeper)
* [Zookeeper: 分布式过程协同技术详解](http://www.dengshenyu.com/%E5%88%86%E5%B8%83%E5%BC%8F%E7%B3%BB%E7%BB%9F/2017/11/01/zookeeper.html)
