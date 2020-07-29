# 分布式系统

理论基础有CAP、BASE等。针对一致性，有特别多的算法，其中Raft作为易懂的新贵

* 连接管理与业务处理拆分
* 业务处理从功能角度拆分

## 指标

1998年，加州大学的计算机科学家 Eric Brewer 提出，分布式系统有三个指标。Eric Brewer 说，这三个指标不可能同时做到。这个结论就叫做 CAP 定理。

* 可用性Consistency：只要收到用户的请求，服务器就必须给出回应
* 一致性Availability：写操作之后的读操作，必须返回该值
* 分区容错Partition tolerance：大多数分布式系统都分布在多个子网络。每个子网络就叫做一个区（partition）。区间通信可能失败。
* 无法同时做到一致性和可用性。系统设计时只能选择一个目标。如果追求一致性，那么无法保证所有节点的可用性；如果追求所有节点的可用性，那就没法做到一致性

## 分层

* 反向代理层（关联https连接）
	- 可以通过nginx集群实现，也可以通过lvs,f5实现。
	- 通过上层nginx实现，可以知道该层应对的是大量http或https请求。
	- 核心指标是：并发连接数、活跃连接数、出入流量、出入包数、吞吐量等。
	- 内部关于协议解析模块、压缩模块、包处理模块优化等。关键方向代理出去的请求吞吐量，也就是nginx转发到后端应用服务器的处理能力，决定整体吞吐量。
	- 静态文件都走cdn。
	- 关于https认证比较费时，建议使用http2.0，或保持连接时间长点。但这也与业务情况有关。如：每个app与后端交互是否频繁。毕竟维护太多连接，成本也很高，影响多路复用性能。
* 网关层(通用无业务的操作)：反向代理层通过http协议连接网关层，二者之间通过内网ip通信，效率高很多。我们假定网关层往下游都使用tcp长连接，java语言中dobbo等rpc框架都可以实现。
	- 网关层主要做几个事情：
	- 鉴权
	- 数据包完整性检查
	- http json 传输协议转化为java对象
	- 路由转义（转化为微服务调用）
	- 服务治理相关（限流、降级、熔断等）功能
	- 负载均衡
	- 网关层可以由：有开源的Zuul，spring cloud gateway,nodejs等实现。nginx也可以做网关需要定制开发，与反向代理层物理上合并。
* 业务逻辑层（业务层面的操作）：考虑按照业务逻辑垂直分层。例如：用户逻辑层、订单逻辑层等。如果这样拆分，可能会抽象一层通过的业务逻辑层。我们尽量保证业务逻辑层不横向调用，只上游调用下游。
	- 业务逻辑判断
	- 业务逻辑处理（组合）
	- 分布式事务实现
	- 分布式锁实现
	- 业务缓存
* 数据访问层（数据库存储相关的操作）；专注数据增删改查操作。
	- orm封装
	- 隐藏分库分表的细节。
	- 缓存设计
	- 屏蔽存储层差异
	- 数据存储幂等实现
* 网关层以下，数据库以上，RPC中间件技术选型及技术指标如下（来源dubbo官网）：
	- 核心指标是：并发量、TQps、Rt响应时间。
	- 选择协议因素：dubbo、rmi、hesssion、webservice、thrift、memached、redis、rest
	- 连接个数：长连接一般单个；短连接需要多个
	- 是否长连接：长短连接
	- 传输协议：TCP、http
	- 传输方式：：同步、NIO非阻塞
	- 序列化：二进制（hessian）
	- 使用范围：大文件、超大字符串、短字符串等

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

## 高可用

* 拆分：目的在于“扩展”处理能力，提升性能
	- 计算任务拆分方式
		+ 相同任务平行部署：引来负载均衡路由问题；
		+ 横向水平分解：功能性解耦合，引来远程调用问题；
		+ 纵向业务分解：业务性解耦，引来业务关联业务的复杂性、分布式事务、分布式锁问题；引来更复杂的调用路由问题；
	- 存储拆分问题
		+ 相同存储冗余部署：引来数据不一致、状态同步问题。系统可用性和数据一致性如何取舍，是CAP定理的论证点。
		+ 一份数据拆分成N份：数据库分库分表、数据分区分片，带来数据分区规则、合并使用、关联使用等复杂性问题。
	- 拆分后分配问题
		+ 服务间的分配：调用关系元数据管理（如：服务注册、发现、调用关系）；通过元数据来决策；
		+ 存储间的分配：通过元数据管理数据分片、分区；元数据独立管理，通过元数据决策；
 	- 多副本数据复制同步问题：分布式存储系统中，一般叫法有：主从、主备、master/slave、lead/follow、主分片/副本分片。代表相同数据，多份存储，如何同步这些数据呢？同步性能压力；异步性能提升，但数据不一致。
	- 故障甄别、失效转移（高可用决策）
		+ 谁来决策：决策者必须有拆分、冗余 节点的状态信息。
		+ 决策者的高可用：决策者需要冗余，防止决策者故障；
		+ 多个决策者的选举：避免多个决策者；
		+ 故障甄别：决策者通过什么来确定节点有故障；
		+ 失效故障自动解决：发现故障后，把故障停机，转移到正常节点。
* 冗余：目的在于“备用”处理单元，提升高可用

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
