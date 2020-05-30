# 分布式系统

理论基础有CAP、BASE等。针对一致性，有特别多的算法，其中Raft作为易懂的新贵

## 指标

1998年，加州大学的计算机科学家 Eric Brewer 提出，分布式系统有三个指标。Eric Brewer 说，这三个指标不可能同时做到。这个结论就叫做 CAP 定理。

* 可用性Consistency：只要收到用户的请求，服务器就必须给出回应
* 一致性Availability：写操作之后的读操作，必须返回该值
* 分区容错Partition tolerance：大多数分布式系统都分布在多个子网络。每个子网络就叫做一个区（partition）。区间通信可能失败。
* 无法同时做到一致性和可用性。系统设计时只能选择一个目标。如果追求一致性，那么无法保证所有节点的可用性；如果追求所有节点的可用性，那就没法做到一致性

## 概念

eter Deutsch 提出的分布式系统八大谬论概括了程序员新手可能对分布式系统做出的错误假设：

* 网络是可靠的
* 延迟是零
* 带宽是无限的
* 网络是安全的
* 拓扑结构不会变
* 存在管理员这样的角色
* 传输成本是零
* 网络是同质的

## CAP/BASE


## 一致性 Paxos

## Raft

## Gosslp

## Zookeeper

## 两阶段提交 2PC

严重影响性能，并不适合高并发的场景，而且其实现复杂，牺牲了一部分可用性

## TCC

## 分片

* 对资料的切割，也就是一套主从已经装不下了.分片的逻辑可以放在客户端，比如驱动层的数据库中间件，Memcache等；也可以放在服务端，比如ES、Mongo等
* 分片的信息组成了一组元数据，存放了切割的规则。这些信息可以借助外部的存储比如KAFKA；也有的直接同步在集群每个节点的内存中，比如ES。比
* Round-Robin  资料轮流落进不同的机器，数据比较平均，适合弱相关性的数据存储。坏处是聚合查询可能会非常慢，扩容、缩容难。
* Hash 使用某些信息的Hash进行寻路，客户端依照同样的规则可以方便的找到服务端数据。问题与轮询类似，数据过于分散且扩容、缩容难。Hash同样适合弱相关的数据，并可通过一致性哈希来解决数据的迁移问题。
* Range 根据范围来分片数据，比如日期范围。可以将一类数据归档到特定的节点，以增加查询速度。此类分片会遇到热点问题，会冷落很多机器。
* 自定义 自定义一些分片规则。比如通过用户的年龄，区域等进行切分。你需要维护大量的路由表，然后自己控制数据和访问的倾斜问题。
* 嵌套 属于自定义的一种，路由规则可以嵌套。比如首先使用Range进行虚拟分片，然后再使用Hash进行实际分片。在实际操作中，这很有用，需要客户端和服务端的结合才能完成。
* 切分字段的选择非常重要，如果几个维度都很必要，解决的方式就是冗余—-按照每个切分维度，都写一份数据。

## 副本

* 副本越多，可用性越高,延迟越大
* 既要保证数据的增量迁移，又要保证集群的正确服务
* master选举通常都是投票机制，所以最小组集群的台数一般都设置成n/2+1

## 分区

* 节点取余：新增或者删除节点会造成大量的数据迁移
* 一致性哈希：用环形结构来标识范围。通过哈希函数，每个节点都会被分配到环上的一个位置，每个键值也会被映射到环上的一个位置，然后顺时针找到相邻的节点。新增或者删除节点会造成数据分布不均匀
* 虚拟槽：在redis cluster中使用槽来存储一定范围内的数据集。每个redis节点上有一定数量的槽。当客户端提交数据时，要先根据CRC16(key)&16383来计算出数据要落到哪个虚拟槽内

## Quorum/NWR

## 幂等

## 分布式事务

* 写多个分片的协调
* 并发读写某一个值
* 最终一致性
    - 采用了BASE（Basically Available（基本可用）， Soft state（软状态），Eventually consistent（最终一致性）） 的系统，选择的是弱一致性，高度依赖业务监控组件


## 一致性哈希

## ID生成器

## 高可用HA（High Availability）

通过设计减少系统不能提供服务的时间

* 客户端层：典型调用方是浏览器browser或者手机应用APP
    - 通过反向代理层的冗余实现的，常见实践是keepalived + virtual IP自动故障转移
* 反向代理层：系统入口，反向代理
    - 通过站点层的冗余实现的，常见实践是nginx与web-server之间的存活性探测与自动故障转移
* 站点应用层：实现核心应用逻辑，返回html或者json
    - 过服务层的冗余实现的，常见实践是通过service-connection-pool来保证自动故障转移，整个过程由连接池自动完成，对调用方是透明的（所以说RPC-client中的服务连接池是很重要的基础组件）
* 服务层：如果实现了服务化，就有这一层
    - 当redis主挂了的时候，sentinel能够探测到，会通知调用方访问新的redis，整个过程由sentinel和redis集群配合完成，对调用方是透明的
* 数据–缓存层：缓存加速访问存储
    - 过缓存数据的冗余实现的，常见实践是缓存客户端双读双写，或者利用缓存集群的主从数据同步与sentinel保活与自动故障转移；更多的业务场景，对缓存没有高可用要求，可以使用缓存服务化来对调用方屏蔽底层复杂性
* 数据–数据库层：数据库固化数据存储
    - 通过读库的冗余实现的，常见实践是通过db-connection-pool来保证自动故障转移
    - 通过写库的冗余实现的，常见实践是keepalived + virtual IP自动故障转移

## 课程

* [6.824: Distributed Systems](http://nil.csail.mit.edu/6.824/2018/)
* [brendandburns/designing-distributed-systems](https://github.com/brendandburns/designing-distributed-systems):Sample code and configuration files from the Designing Distributed Systems book.

## 工具

* [hashicorp/consul](https://github.com/hashicorp/consul):Consul is a distributed, highly available, and data center aware solution to connect and configure applications across dynamic, distributed infrastructure. https://www.consul.io/
* [dmlc/xgboost](https://github.com/dmlc/xgboost):Scalable, Portable and Distributed Gradient Boosting (GBDT, GBRT or GBM) Library, for Python, R, Java, Scala, C++ and more. Runs on single machine, Hadoop, Spark, Flink and DataFlow https://xgboost.ai/
* [firehol/netdata](https://github.com/firehol/netdata):Get control of your servers. Simple. Effective. Awesome! https://my-netdata.io/
* [facebookincubator/LogDevice](https://github.com/facebookincubator/LogDevice):Distributed storage for sequential data https://logdevice.io
* [meshbird/meshbird](https://github.com/meshbird/meshbird):Distributed private networking http://meshbird.com
* [dragonflyoss/Dragonfly](https://github.com/dragonflyoss/Dragonfly):Dragonfly is an intelligent P2P based image and file distribution system. https://d7y.io
* [etcd-io/etcd](https://github.com/etcd-io/etcd):Distributed reliable key-value store for the most critical data of a distributed system https://etcd.readthedocs.io/en/latest
* [PhxPaxos](https://github.com/Tencent/phxpaxos)腾讯公司微信后台团队自主研发的一套基于Paxos协议的多机状态拷贝类库。它以库函数的方式嵌入到开发者的代码当中， 使得一些单机状态服务可以扩展到多机器，从而获得强一致性的多副本以及自动容灾的特性。文章：<http://www.infoq.com/cn/articles/weinxin-open-source-paxos-phxpaxos>
* [busgo/forest](https://github.com/busgo/forest):分布式任务调度平台,分布式,任务调度,schedule,scheduler http://122.51.106.217:6579
* [ xuxueli / xxl-job ](https://github.com/xuxueli/xxl-job): A distributed task scheduling framework.（分布式任务调度平台XXL-JOB） http://www.xuxueli.com/xxl-job/

## 参考

* [rShetty/awesome-distributed-systems](https://github.com/rShetty/awesome-distributed-systems):Awesome list of distributed systems resources http://rajeevnb.com
* [gdamdam/awesome-decentralized-web](https://github.com/gdamdam/awesome-decentralized-web):an awesome list of decentralized services
* [wx-chevalier/Distributed-Infrastructure-Series](https://github.com/wx-chevalier/Distributed-Infrastructure-Series):📚 深入浅出分布式基础架构，Linux 与操作系统篇 | 分布式系统篇 | 分布式计算篇 | 数据库篇 | 网络篇 | 虚拟化与编排篇 | 大数据与云计算篇
* [分布式系统架构经典资料](https://www.infoq.cn/article/2018/05/distributed-system-architecture/)
* [MIT parallel and distributed Group](https://pdos.csail.mit.edu/)
