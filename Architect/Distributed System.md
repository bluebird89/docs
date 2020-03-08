# 分布式系统

## 指标

1998年，加州大学的计算机科学家 Eric Brewer 提出，分布式系统有三个指标。Eric Brewer 说，这三个指标不可能同时做到。这个结论就叫做 CAP 定理。

* 可用性Consistency：只要收到用户的请求，服务器就必须给出回应
* 一致性Availability：写操作之后的读操作，必须返回该值
* 分区容错Partition tolerance：大多数分布式系统都分布在多个子网络。每个子网络就叫做一个区（partition）。区间通信可能失败。
* 无法同时做到一致性和可用性。系统设计时只能选择一个目标。如果追求一致性，那么无法保证所有节点的可用性；如果追求所有节点的可用性，那就没法做到一致性。

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

## 一致性 Paxos/Raft

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

## 参考

* [rShetty/awesome-distributed-systems](https://github.com/rShetty/awesome-distributed-systems):Awesome list of distributed systems resources http://rajeevnb.com
* [gdamdam/awesome-decentralized-web](https://github.com/gdamdam/awesome-decentralized-web):an awesome list of decentralized services
* [wx-chevalier/Distributed-Infrastructure-Series](https://github.com/wx-chevalier/Distributed-Infrastructure-Series):📚 深入浅出分布式基础架构，Linux 与操作系统篇 | 分布式系统篇 | 分布式计算篇 | 数据库篇 | 网络篇 | 虚拟化与编排篇 | 大数据与云计算篇
