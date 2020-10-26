# Database

* 数据存储
* 数据检索

## CAP 理论

* Consistency（强一致性）：系统在执行某项操作后仍然处于一致的状态
  - 强一致性：更新操作执行成功之后，所有的用户都能读取到最新的值，这样的系统被认为具有
  - 最终一致性：更新操作完成之后，用户最终会读取到数据更新之后的值，但是会存在一定的时间窗口，用户仍会读取到更新之前的旧数据；在一定的时间延迟之后，数据达到一致性
* Availability（可用性）：用户执行的操作在一定时间内，必须返回结果。如果超时，那么操作回滚，跟操作没有发生一样
* Partition Tolerance（分区容错）：分布式系统是由多个分区节点组成的，每个分区节点都是一个独立的Server，P属性表明系统能够处理分区节点的动态加入和离开

## 数据库

* 传统的关系型DB，注重的是CA特性，数据一般存储在一台Server上
  - 在多表查询的时候并且数据量很大的时候效率很低
* 处理海量数据的分布式存储和处理系统更注重AP，AP的优先级要高于C
* NoSQL并不是完全放弃一致性（Consistency），保留数据的最终一致性（Eventually Consistency）
* 在分布式数据库环境中，为了保持构架的扩展性，在分区容错性不变的前提下，必须从一致性和可用性中取其一
  - HBase选择了一致性与分区可容忍性
  - Cassandra选择了可用性与分区可容忍性
* 国际标准化组织 ISO 将图形数据库查询语言 GQL 通过为国际标准，这是继 SQL 以后第二种成为国际标准的数据库查询语言。

## 关系型数据库管理系统(RDBMS Relational Database Management System)

* 采用了关系模型来组织数据的数据库，其以行和列的形式存储数据，以便于用户理解
* 行和列被称为表，一组表组成了数据库
* 用户通过查询来检索数据库中的数据，而查询是一个用于限定数据库中某些区域的执行代码
* 优势
  - 易于理解
  - 关系型二维表的结构非常贴近现实世界，二维表格，容易理解。
  - 支持复杂查询 可以用 SQL 语句方便的在一个表以及多个表之间做非常复杂的数据查询。
  - 支持事务 可靠的处理事务并且保持事务的完整性，使得对于安全性能很高的数据访问要求得以实现。

## 类型

* OLTP（Online Transaction Processing）：传统的关系型数据库，主要用于处理基本的、日常的事务处理
  - 通过 INSERT、UPDATE 和 DELETE 语句对表中的数据进行增加、修改和删除；
  - 通过 UPDATE 和 DELETE 语句对符合条件的数据进行批量的删除；
  - 通过 SELECT 语句和主键查询某条记录的全部列；
  - 通过 SELECT 语句在表中查询符合某些条件的记录并根据某些字段排序；
  - 通过 SELECT 语句查询表中数据的行数；
  - 通过唯一索引保证表中某个字段或者某几个字段的唯一性；
* OLAP（Online Analytical Processing）：主要在数据仓库中使用，用于支持一些复杂的分析和决策

## NoSQL

* 场景
  - 少量数据存储，高速读写访问。此类产品通过数据全部in-momery 的方式来保证高速访问，同时提供数据落地的功能，实际这正是Redis最主要的适用场景。
  - 海量数据存储，分布式系统支持，数据一致性保证，方便的集群节点添加/删除。
  - 这方面最具代表性的是dynamo和bigtable 2篇论文所阐述的思路。前者是一个完全无中心的设计，节点之间通过gossip方式传递集群信息，数据保证最终一致性，后者是一个中心化的方案设计，通过类似一个分布式锁服务来保证强一致性,数据写入先写内存和redo log，然后定期compat归并到磁盘上，将随机写优化为顺序写，提高写入性能。
  - Schema free，auto-sharding等。比如目前常见的一些文档数据库都是支持schema-free的，直接存储json格式数据，并且支持auto-sharding等功能，比如mongodb

## 时间序列数据库 Time Series Database (TSDB)

* 一系列数据点按照时间顺序排列，具有不变性,、唯一性、时间排序性。需要展现其历史趋势、周期规律、异常性的，进一步对未来做出预测分析的，都是时序数据库适合的场景。
* 原理
  - 时序数据的写入：如何支持每秒钟上千万上亿数据点的写入。
  - 时序数据的读取：又如何支持在秒级对上亿数据的分组聚合运算。
  - 成本敏感：由海量数据存储带来的是成本问题。如何更低成本的存储这些数据，将成为时序数据库需要解决的重中之重。
  - 处理带时间标签（按照时间的顺序变化，即时间序列化）的数据
  - 特性分为两类
    + 高频率低保留期（数据采集，实时展示）
    + 低频率高保留期（数据展现、分析）
  - 按频度
    + 规则间隔（数据采集）
    + 不规则间隔（事件驱动）
  - 时间序列数据的几个前提
    + 单条数据并不重要
    + 数据几乎不被更新，或者删除（只有删除过期数据时），新增数据是按时间来说最近的数据
    + 同样的数据出现多次，则认为是同一条数据
  - 使用
    + Influxdb与ES都是REST API风格接口
    + 通常ES搭配Logstash使用，Influxdb搭配telegraf使用
* 概念
  - metric: 度量，相当于关系型数据库中的table。
  - data point: 数据点，相当于关系型数据库中的row。
  - timestamp：时间戳，代表数据点产生的时间。
  - field: 度量下的不同字段。比如位置这个度量具有经度和纬度两个field。一般情况下存放的是会随着时间戳的变化而变化的数据。
  - tag: 标签，或者附加信息。一般存放的是并不随着时间戳变化的属性信息。timestamp加上所有的tags可以认为是table的primary key。
* 数据
  - 行存：一个数组包含多个点，如 [{t: 2017-09-03-21:24:44, v: 0.1002}, {t: 2017-09-03-21:24:45, v: 0.1012}]
  - 列存：两个数组，一个存时间戳，一个存数值，如[ 2017-09-03-21:24:44, 2017-09-03-21:24:45], [0.1002,  0.1012]，一般情况下：列存能有更好的压缩率和查询性能
* 数据库
  - beringei：Facebook
  - TimeScaleDB：PostgreSQL
  - [rethinkdb/rethinkdb](https://github.com/rethinkdb/rethinkdb) The open-source database for the realtime web. <https://rethinkdb.com>
  - [VividCortex](https://www.vividcortex.com)：MySQL
  - [Graphite](https://graphiteapp.org/)
    + [文档](https://graphite.readthedocs.io/en/latest/index.html)
  - [InfluxDB](https://github.com/influxdata/influxdb)：高频度低保留期用Influxdb，低频度高保留期用ES
    + Time Structured Merge Tree
  - [DolphinDB](https://www.dolphindb.cn/):自带金融基因，内置并优化了很多与金融分析相关的函数，譬如各种sliding window function, correlation/covariance/beta/percentile, 处理panel data的分组计算功能 context by， 用于数据透视的pivot by、用于数据聚合的group by， 用于时间序列数据分段处理的segment by， 以及时间序列数据特有的asof join和window join， 也包括常用的分类和拟合算法
    + [文档](dolphindb/Tutorials_CN)
  - Informix TimeSeries

## 事务 (ACID)

* 原子性 atomicity:一个事务必须被视为一个不可分割的最小工作单元，整个事务中的所有操作要么全部提交成功，要么全部失败回滚，对于一个事务来说，不可能只执行其中的一部分操作
* 一致性（consistency) 数据库总是从一个一致性的状态转换到另外一个一致性的状态
* 隔离性（isolation) 通常来说，一个事务所做的修改在最终提交以前，对其他事务是不可见的
* 持久性（durability) 一旦事务提交，则其所做的修改就会永久保存到数据库中。此时即使系统崩溃，修改的数据也不会丢失。持久性是个有点模糊的概念，因为实际上持久性也分很多不同的级别。有些持久性策略能够提供非常强的安全保障，而有些则未必。而且「不可能有能做到100%的持久性保证的策略」否则还需要备份做什么

## 命名

* 尽可能短
* 直观，尽可能正确和具有描述性
* 保持一致性
* 避免使用SQL和数据库引擎特定的关键字作为名字
* 建立命名约定

## 结构化查询语言 SQL Structured Query Language

一种特殊目的的编程语言，是一种数据库查询和程序设计语言程序设计语言，用于存取数据以及查询、更新和管理关系数据库系统

## 索引

索引是用来快速检索出具有特定值的记录。没有索引，数据库就必须从第一条记录开始进行全表扫描，直到找出相关的行。数据越多，检索的代价就越高，检索时如果表的列存在索引，那么MySQL就能快速到达指定位置去搜索数据文件，而不必查看所有数据。主要有两种结构：B+Tree索引和Hash索引。

* 主键:本质是保证唯一记录，并不要求主键是连续的。用一个UUID作为主键，即varchar(32)，除了占用的存储空间较多外，字符串主键具有不可预测性。
  - 主键不可修改:主键的第二个作用是让其他表的外键引用自己，从而实现关系结构
  - 业务字段不可用于主键:主键必须使用单独的，完全没有业务含义的字段，也就是主键本身除了唯一标识和不可修改这两个责任外，主键没有任何业务含义。
  - 主键应该使用字符串:自增主键最大的问题是把公司业务的关键运营数据完全暴露给了竞争对手和VC

## 连接

左边表A与右边表B

* 内连接（inner join）:只返回两张表匹配的记录
* 外连接（outer join）:还包含不匹配的记录
  - 左连接（left join）:返回匹配的记录，以及表 A 多余的记录
  - 右连接（right join）:返回匹配的记录，以及表 B 多余的记录
  - 全连接（full join）:返回匹配的记录，以及表 A 和表 B 各自的多余记录

```sql
SELECT * FROM A INNER JOIN B ON A.book_id=B.book_id;

SELECT * FROM A LEFT JOIN B ON A.book_id=B.book_id;
SELECT * FROM A RIGHT JOIN B ON A.book_id=B.book_id;
SELECT * FROM A FULL JOIN B ON A.book_id=B.book_id;

# 只返回表 A 里面不匹配表 B 的记录
SELECT * FROM A LEFT JOIN B ON A.book_id=B.book_id WHERE B.id IS null;

# 返回表 A 或表 B 所有不匹配的记录
SELECT * FROM A FULL JOIN B ON A.book_id=B.book_id WHERE A.id IS null OR B.id IS null;
```

## 备份

在部署数据库的时候，不用于以前的单体应用，分布式下数据库部署包括多点部署，一套业务应用数据库被分布在多台数据库服务器上，分主从服务器。主服务器处理日常业务请求，从服务器在运行时不断的对主服务器进行备份，当主服务器出现宕机、或者运行不稳定的情况时，从服务器会立刻替换成主服务器，继续对外提供服务。此时，开发运维人员会对出现问题的服务器进行抢修、恢复，之后再把它投入到生产环境中。这样的构架也被称作为高可用构架，它支持了灾难恢复，为业务世界提供了可靠的支持，也是很多企业级应用采用的主流构架之一。

* 从数据库常常被设计成只读，主数据库支持读写操作
* 一般会有一台主数据库连接若干台从数据库
* 互联网产品的应用中，人们大多数情况下会对应用服务器请求读操作，这样应用服务器可以把读操作请求分发到若干个从数据库中，这样就避免了主数据库的并发请求次数过高的问题
* 从数据库的内容基本上可以说是主数据库的一份全拷贝，这样的技术称之为Replication。Replication在实现主从数据同步时，通常采用Transaction Log的方式，比如，当一条数据插入到主数据库的时候，主数据库会像Trasaction Log中插入一条记录来声明这次数据库写纪录的操作。之后，一个Replication Process会被触发，这个进程会把Transaction Log中的内容同步到从数据库中

### 扩展

* 水平扩展：通过增加服务器数量来对系统扩容。在这样的构架下，单台服务器的配置并不会很高，可能是配置比较低、很廉价的 PC，每台机器承载着系统的一个子集，所有机器服务器组成的集群会比单体服务器提供更强大、高效的系统容载量。这样的问题是系统构架会比单体服务器复杂，搭建、维护都要求更高的技术背景。
* 垂直扩展：是针对一台服务器进行硬件升级。仅限于单台服务器的扩容，尽可能的增加单台服务器的硬件配置。优点是构架简单，只需要维护单台服务器。

## [clickhouse](https://github.com/ClickHouse/ClickHouse)

* a free analytics DBMS for big data [](https://clickhouse.tech/docs/zh/)
* Yandex（俄罗斯最大的搜索引擎）开源的一个用于实时数据分析的基于列存储的数据库

## 分层数据库

* IMS基于层次模型工作。将数据视为树。以第一次构建数据库时预期的方式访问数据（先访问Customer，再访问Account），就可以非常快速地进行数据访问。但由于缺少灵活性。
* E. F. Codd（埃德加·弗兰克·科德）在1970年的论文“大型共享数据库的数据关系模型”中提出了关系模型
* 分层模型是一种自下而上的模型，是对具体现实的表示。而关系模型是基于关系代数的抽象模型，并且是自上而下的

## 数据库中间件 Proxy

* 在电商系统中，随着业务量的增大，读写 QPS 越来越高，单节点 MySQL 实例压力也变得越来越大，单纯的对服务器硬件升级已经无法满足生产环境的需要。对数据分片增加多个节点，降低单节点 MySQL 实例的压力成了必然选择。
* [Qihoo360/Atlas](https://github.com/Qihoo360/Atlas):A high-performance and stable proxy for MySQL, it is developed by Qihoo's DBA and infrastructure team
* [Mycat](link)
* [TDDL](link)
* [Vitess](link)
* [OneProxy](link)
* [Gaea](https://mp.weixin.qq.com/s?__biz=MzI4NTA1MDEwNg==&mid=2650779105&idx=1&sn=ed5093ab25a2b002cded6485fde97562&chksm=f3f91874c48e916252f7b46cccf5e4d6473feccaa4c078a84bbe24495317c6bdc59a59dbe699)

## 数据中心 Internet Data Center IDC

## [Lede-Inc/Cetus](https://github.com/Lede-Inc/cetus)

专注于稳定、性能和分布式事务的MySQL数据库中间件,包括以下五个部分，分别是读写分离、分库、SQL 解析、连接池和管理功能。Cetus 的整体工作流程分为:

* Cetus 读取启动配置文件和其他配置并启动，监听客户端请求
* 收到客户端新建连接请求后，Cetus 经过用户鉴权和连接池，判断连接数是否达到上限，确定是否新建连接；
* 连接建立和认证通过后，Cetus 接收客户端发送来的 SQL 语句，并进行词法和语义分析，对 SQL 语句进行解析，分析 SQL 的请求类型，必要时改写 SQL，然后选取相应的 DB 并转发；
* 等待后端处理查询，接收处理查询结果集，进行合并和修改，然后转发给客户端；
* 如果收到客户端关闭连接的请求，Cetus 就会判断是否需要关闭后端连接，如果需要就关闭连接。

## Maelstrom

* Facebook 通过流量管理系统 Maelstrom 转发数据中心的流量，在出现一个或者多个数据中心故障时，减轻故障对业务造成的影响。减少飓风导致的断电和洪水、光缆断裂、软件故障和错误配置类似突发事件对线上服务和业务的影响成为了保障可用性的必须要做的事情
* 数据中心作为流量调度的维度，它有着非常粗的粒度，如果我们直接将数据中心的流量通过配置全部转发的其他数据中心可能会出现很多问题，所以在排出数据中心的流量时，需要根据服务内部的依赖和资源限制设计不同的策略。为了区分数据中心流量的特性，Maelstrom 将数据中心的流量分成四类
  - 无状态流量（Stateless）：绝大多数的网络流量都是无状态的，可以非常容易地将这些流量转发到其他的数据中心
    + 引入排出乘数（Drain Multiplier）并引入了几个不同的阶段防止流量转移的太过迅速影响其他数据中心的负载
  - 粘性流量（Sticky）：为了提升用户体验，在某些场景下系统会为每个用户会由特定的机器处理以维持用户会话，对于这种流量，可以将新的粘性流量转发到其他数据中心并强制断开已建立的会话触发客户端的重连；
  - 复制流量（Replication）：当发生数据中心级别故障时，我们可能需要修改或者管理存储系统的复制流量，我们可能需要在其他数据中心创建副本来处理读请求，而副本的创建需要占用数据中心内部或者跨数据中心的网络资源；
  - 有状态流量（Stateful）：主从复制的系统在主节点发生故障时，我们需要将主节点的状态拷贝至健康数据中心中的从节点，并将从节点进程成主节点以服务请求；

## 数据库

* [dbeaver/dbeaver](https://github.com/dbeaver/dbeaver):Free universal database tool and SQL client http://dbeaver.jkiss.org
* [tgriesser/knex](https://github.com/tgriesser/knex):A query builder for PostgreSQL, MySQL and SQLite3, designed to be flexible, portable, and fun to use. http://knexjs.org
* [alibaba/otter](https://github.com/alibaba/otter)：阿里巴巴分布式数据库同步系统(解决中美异地机房)
* [Nozbe/WatermelonDB](https://github.com/Nozbe/WatermelonDB):🍉 Next-gen database for powerful React and React Native apps that scales to 10,000s of records and remains fast ⚡️
* [getredash/redash](https://github.com/getredash/redash) Make Your Company Data Driven. Connect to any data source, easily visualize and share your data. <http://redash.io/>
* [pingcap/tidb](https://github.com/pingcap/tidb)TiDB is a distributed NewSQL database compatible with MySQL protocol
* [apache/incubator-superset](https://github.com/apache/incubator-superset): a modern, enterprise-ready business intelligence web application. a data exploration and visualization web application.
* [Meituan-Dianping/SQLAdvisor](https://github.com/Meituan-Dianping/SQLAdvisor)输入SQL，输出索引优化建议
* [greenplum-db/gpdb](https://github.com/greenplum-db/gpdb):Greenplum Database http://greenplum.org
* [realm/realm-js](https://github.com/realm/realm-js):Realm is a mobile database: an alternative to SQLite & key-value stores https://realm.io
* [orbitdb/orbit-db](https://github.com/orbitdb/orbit-db):Peer-to-Peer Databases for the Decentralized Web
* [prometheus/prometheus](https://github.com/prometheus/prometheus)：The Prometheus monitoring system and time series database. https://prometheus.io/
* [arangodb/arangodb](https://github.com/arangodb/arangodb):🥑 ArangoDB is a native multi-model database with flexible data models for documents, graphs, and key-values. Build high performance applications using a convenient SQL-like query language or JavaScript extensions. https://www.arangodb.com
* [amark/gun](https://github.com/amark/gun):A realtime, decentralized, offline-first, graph database engine. https://gun.eco/docs
* [vasilakisfil/Introspected-REST](https://github.com/vasilakisfil/Introspected-REST):An alternative to REST and GraphQL https://introspected.rest
* [alibaba/tair](https://github.com/alibaba/tair):A distributed key-value storage system developed by Alibaba Group
* [taosdata/TDengine](https://github.com/taosdata/TDengine):An open-source big data platform designed and optimized for the Internet of Things (IoT). https://www.taosdata.com
* [apple/foundationdb](https://github.com/apple/foundationdb):FoundationDB - the open source, distributed, transactional key-value store https://www.foundationdb.org
* [msiemens/tinydb](https://github.com/msiemens/tinydb):TinyDB is a lightweight document oriented database optimized for your happiness :) https://tinydb.readthedocs.org
* [gruns/ImmortalDB](https://github.com/gruns/ImmortalDB):🔩 A relentless key-value store for the browser.
* [cockroachdb/cockroach](https://github.com/cockroachdb/cockroach):CockroachDB - the open source, cloud-native SQL database. https://www.cockroachlabs.com
* [dgraph-io/dgraph](https://github.com/dgraph-io/dgraph):Fast, Distributed Graph DB https://dgraph.io
* [](https://github.com/pouchdb/pouchdb):🐨 - PouchDB is a pocket-sized database. https://pouchdb.com/
* [apache/hive](https://github.com/apache/hive) Mirror of Apache Hive
* [google/leveldb](https://github.com/google/leveldb) LevelDB is a fast key-value storage library written at Google that provides an ordered mapping from string keys to string values.
* [DCache](https://github.com/tencent/dcache):分布式 NoSQL 存储系统,基于 TARS 微服务治理方案，支持 k-v、k-k-row、list、set 与 zset 多种数据结构，数据基于内存存储，同时支持后接 DB 实现数据持久化。DCache 具备快速水平扩展能力，同时配套有 Web 运维平台实现高效的运维操作。
  - 对外提供服务的粒度是 group，一个 group 负责一部分的数据分片，至于每个 group 服务哪些数据，是根据数据的 key 做 hash 映射后所处的范围来确定的。
  - 自身会处理缓存与DB之间的数据一致性问题
* [MemSQL](link)
* [Pivotal Greenplum](https://pivotal.io/pivotal-greenplum):Parallel Postgres for enterprise analytics at scale

## 图书

* 《数据库系统实现》
* 《SQL基础教程》
* 《[SQL应用重构](https://www.amazon.cn/gp/product/B00H6X6M1A)》
* 《[SQL Cookbook](https://www.amazon.cn/gp/product/0596009763)》
* 《[高性能MySQL（第3版）](https://www.amazon.cn/gp/product/B00C1W58DE)》
* 《[MySQL技术内幕 : InnoDB存储引擎（第2版）](https://www.amazon.cn/gp/product/B00ETOV48K)》
* 《[深入浅出MySQL : 数据库开发、优化与管理维护](https://www.amazon.cn/gp/product/B00KR87J8G)》
* 《SQL必知必会(第4版)》
* 《SQL 反模式》
* 《数据库系统概念》
* 《收获，不止Oracle》（第2版）

## 工具

* [harelba/q](https://github.com/harelba/q):Run SQL directly on CSV or TSV files http://harelba.github.io/q/
* [ClickHouse / ClickHouse](https://github.com/yandex/ClickHouse):ClickHouse is a free analytic DBMS for big data. https://clickhouse.tech
* [facebook/osquery](https://github.com/facebook/osquery):SQL powered operating system instrumentation, monitoring, and analytics. https://osquery.io
  - [Docs](https://osquery.readthedocs.io)
* [vrana/adminer](https://github.com/vrana/adminer):Database management in a single PHP file https://www.adminer.org/
* [youtube/vitess](https://github.com/youtube/vitess):Vitess is a database clustering system for horizontal scaling of MySQL. http://vitess.io
* [getredash/redash](https://github.com/getredash/redash):Make Your Company Data Driven. Connect to any data source, easily visualize and share your data. http://redash.io/
* [XiaoMi/soar](https://github.com/XiaoMi/soar):SQL Optimizer And Rewriter
* [prisma/prisma](https://github.com/prisma/prisma):⚡️ Prisma makes working with databases easy https://www.prisma.io
* [twitter/twemproxy](https://github.com/twitter/twemproxy):A fast, light-weight proxy for memcached and redis
* [alibaba/druid](https://github.com/alibaba/druid):阿里巴巴数据库事业部出品，为监控而生的数据库连接池。阿里云Data Lake Analytics(https://www.aliyun.com/product/datalakeanalytics )、DRDS、TDDL 连接池powered by Druid https://github.com/alibaba/druid/wiki
* [cloudera/hue](https://github.com/cloudera/hue):Hue is an open source SQL Cloud Assistant for developing and accessing SQL/Data Apps. http://gethue.com
* [xo/usql](https://github.com/xo/usql):Universal command-line interface for SQL databases
* [ClickHouse](https://github.com/ClickHouse/ClickHouse):ClickHouse is a free analytics DBMS for big data https://clickhouse.tech
* [franchise](https://github.com/HVF/franchise)：🍟 a notebook sql client. what you get when have a lot of sequels. https://franchise.cloud

## 参考

* [数据库的原理](http://blog.jobbole.com/100349/)
* [Let's Build a Simple Database](https://cstack.github.io/db_tutorial/)
* [enochtangg/quick-SQL-cheatsheet](https://github.com/enochtangg/quick-SQL-cheatsheet):A quick reminder of all SQL queries and examples on how to use them.
* [Pool-Sizing](https://github.com/brettwooldridge/HikariCP/wiki/About-Pool-Sizing)
