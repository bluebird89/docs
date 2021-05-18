# Database

* 数据存储
* 数据检索
* 传统关系型DB，注重CA特性，数据一般存储在一台Server上
  - 在多表查询时候并且数据量很大的时候效率很低
* 分布式数据库环境中，为了保持构架扩展性，在分区容错性不变前提下，更注重AP，AP的优先级要高于C,必须从一致性和可用性中取其一
  - HBase选择了一致性与分区可容忍性
  - Cassandra选择了可用性与分区可容忍性
* NoSQL 并不是完全放弃一致性（Consistency），保留数据最终一致性（Eventually Consistency）
* 国际标准化组织 ISO 将图形数据库查询语言 GQL 通过为国际标准，这是继 SQL 以后第二种成为国际标准的数据库查询语言。

## [CAP 理论 CAP Theorem](https://sites.cs.ucsb.edu/~rich/class/cs293b-cloud/papers/Brewer_podc_keynote_2000.pdf)

* Consistency（一致性）：系统在执行某项操作后仍然处于一致的状态 确保分布式群集中的每个节点都返回相同的最近更新的数据
  - 每个客户端具有相同的数据视图
  - 强一致性：更新操作执行成功之后，所有的用户都能读取到最新的值
  - 最终一致性：更新操作完成之后，用户最终会读取到数据更新之后的值，但是会存在一定的时间窗口，用户仍会读取到更新之前的旧数据；在一定的时间延迟之后，数据达到一致性
    +  “In a steady state, the system will eventually return the last written value”. Clients therefore may face an inconsistent state of data as updates are in progress.
  - Read Your Own Writes Consistency: Clients will see their updates immediately after they are written. The reads can hit nodes other than the one where it was written. However they might not see updates by other clients immediately.
  - Session Consistency: Clients will see the updates to their data within a session scope. This generally indicates that reads & writes occur on the same server. Other clients using the same nodes will receive the same updates.
  - Casual Consistency:A system provides causal consistency if the following condition holds: write operations that are related by potential causality are seen by each process of the system in order. Different processes may observe concurrent writes in different orders
* Availability（可用性）：用户执行的操作在一定时间内，必须返回结果。如果超时，那么操作回滚，跟操作没有发生一样
  - 每个非失败节点在合理的时间内返回所有读取和写入请求的响应。为了可用，网络分区两侧的每个节点必须能够在合理的时间内做出响应。
* Partition Tolerance（分区容错）：分布式系统是由多个分区节点组成的，每个分区节点都是一个独立的Server，P属性表明系统能够处理分区节点的动态加入和离开
  - 尽管存在网络分区，系统仍可继续运行并 保证 一致性。网络分区已成事实。保证分区容忍度的分布式系统可以在分区修复后从分区进行适当的恢复。
* 一个分布式系统不可能同时满足 一致性( Consistency ) 、可用性 ( Availability ) 、分区容 忍 性 ( Partition tolerance ) 这三个基本需求，最多只能同时满足其中的两项，分区容错性是不能放弃的，因此架构师通常是在可用性和一致性之间权衡。这里的权衡不是简单的完全抛弃，而是考虑业务情况作出的牺牲，或者用互联网的一个术语“降级”来描述。

## BASE 理论

* BASE 是 Basically Available(基本可用)、Soft state(软状态)和 Eventually consistent(最终一致性)三个短语的缩写
  - BA：Basically Available 基本可用，分布式系统在出现故障的时候，允许损失部分可用性，即保证核心可用
  - S：Soft state 软状态，允许系统存在中间状态，而该中间状态不会影响系统整体可用性
  - E：Consistency 最终一致性，系统中的所有数据副本经过一定时间后，最终能够达到一致的状态
* 核心思想：即使无法做到强一致性，但每个应用都可以根据自身业务特点，采用适当的方式来使系统达到最终一致性。
* BASE 理论本质上是对 CAP 理论的延伸，是对 CAP 中 AP 方案的一个补充。

## 类型

* OLTP（Online Transaction Processing）：传统关系型数据库，主要用于基本、日常事务处理
  - 通过 INSERT、UPDATE 和 DELETE 语句对表中的数据进行增加、修改和删除；
  - 通过 UPDATE 和 DELETE 语句对符合条件的数据进行批量的删除；
  - 通过 SELECT 语句和主键查询某条记录的全部列；
  - 通过 SELECT 语句在表中查询符合某些条件的记录并根据某些字段排序；
  - 通过 SELECT 语句查询表中数据的行数；
  - 通过唯一索引保证表中某个字段或者某几个字段的唯一性；
* OLAP（Online Analytical Processing）：主要在数据仓库中使用，用于支持一些复杂分析和决策

## 关系型数据库管理系统 Relational Database Management System RDBMS

* 采用了关系模型来组织数据的数据库，其以行和列的形式存储数据，以便于用户理解
* 行和列被称为表，一组表组成了数据库
* 用户通过查询来检索数据库中的数据，而查询是一个用于限定数据库中某些区域的执行代码
* Advantages
  - Flexible Data Models:Most NoSQL systems feature flexible schemas. A flexible schema means you can easily modify your database schema to add or remove fields to support for evolving application requirements. This facilitates with continuous application development of new features without database operation overhead.
  - Horizontal Scaling:Most NoSQL systems allow you to scale horizontally, which means you can add in cheaper & commodity hardware, whenever you want to scale a system. On the other hand SQL systems generally scale Vertically (a more powerful server). NoSQL systems can also host huge data sets when compared to traditional SQL systems.
  - Fast Queries:NoSQL can generally be a lot faster than traditional SQL systems due to data denormalization and horizontal scaling. Most NoSQL systems also tend to store similar data together facilitating faster query responses.
  - Developer productivity:NoSQL systems tend to map data based on the programming data structures. As a result developers need to perform fewer data transformations leading to increased productivity & fewer bugs.
  - 易于理解
  - 关系型二维表的结构非常贴近现实世界，二维表格，容易理解。
  - 支持复杂查询 可以用 SQL 语句方便的在一个表以及多个表之间做非常复杂的数据查询。
  - 支持事务 可靠的处理事务并且保持事务的完整性，使得对于安全性能很高的数据访问要求得以实现。
* 类型
  - Document databases: They store data in documents similar to JSON (JavaScript Object Notation) objects. Each document contains pairs of fields and values. The values can typically be a variety of types including things like strings, numbers, booleans, arrays, or objects, and their structures typically align with objects developers are working with in code. The advantages include intuitive data model & flexible schemas. Because of their variety of field value types and powerful query languages, document databases are great for a wide variety of use cases and can be used as a general purpose database. They can horizontally scale-out to accomodate large data volumes. Ex: MongoDB, Couchbase
  - Key-Value databases: These are a simpler type of databases where each item contains keys and values. A value can typically only be retrieved by referencing its value, so learning how to query for a specific key-value pair is typically simple. Key-value databases are great for use cases where you need to store large amounts of data but you don’t need to perform complex queries to retrieve it. Common use cases include storing user preferences or caching. Ex: Redis, DynamoDB, Voldemort/Venice (Linkedin),
  - Wide-Column stores: They store data in tables, rows, and dynamic columns. Wide-column stores provide a lot of flexibility over relational databases because each row is not required to have the same columns. Many consider wide-column stores to be two-dimensional key-value databases. Wide-column stores are great for when you need to store large amounts of data and you can predict what your query patterns will be. Wide-column stores are commonly used for storing Internet of Things data and user profile data. Cassandra and HBase are two of the most popular wide-column stores.
  - Graph Databases: These databases store data in nodes and edges. Nodes typically store information about people, places, and things while edges store information about the relationships between the nodes. The underlying storage mechanism of graph databases can vary. Some depend on a relational engine and “store” the graph data in a table (although a table is a logical element, therefore this approach imposes another level of abstraction between the graph database, the graph database management system and the physical devices where the data is actually stored). Others use a key-value store or document-oriented database for storage, making them inherently NoSQL structures. Graph databases excel in use cases where you need to traverse relationships to look for patterns such as social networks, fraud detection, and recommendation engines. Ex: Neo4j

## NoSQL Not Only SQL

* NASA used a NoSQL database to track inventory for the Apollo mission.
* 场景
  - 少量数据存储，高速读写访问。此类产品通过数据全部in-momery 的方式来保证高速访问，同时提供数据落地的功能，实际这正是Redis最主要的适用场景。
  - 海量数据存储，分布式系统支持，数据一致性保证，方便的集群节点添加/删除。
  - 这方面最具代表性的是dynamo和bigtable 2篇论文所阐述的思路。前者是一个完全无中心的设计，节点之间通过gossip方式传递集群信息，数据保证最终一致性，后者是一个中心化的方案设计，通过类似一个分布式锁服务来保证强一致性,数据写入先写内存和redo log，然后定期compat归并到磁盘上，将随机写优化为顺序写，提高写入性能。
  - Schema free，auto-sharding等。比如目前常见的一些文档数据库都是支持schema-free的，直接存储json格式数据，并且支持auto-sharding等功能，比如mongodb

## 时间序列数据库 Time Series Database TSDB

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
  - [rethinkdb](https://github.com/rethinkdb/rethinkdb) The open-source database for the realtime web. <https://rethinkdb.com>
  - [VividCortex](https://www.vividcortex.com)
  - [Graphite](https://graphiteapp.org/)
    + [文档](https://graphite.readthedocs.io/en/latest/index.html)
  - [InfluxDB](https://github.com/influxdata/influxdb)：高频度低保留期用Influxdb，低频度高保留期用ES
    + Time Structured Merge Tree
  - [DolphinDB](https://www.dolphindb.cn/):自带金融基因，内置并优化了很多与金融分析相关的函数，譬如各种sliding window function, correlation/covariance/beta/percentile, 处理panel data的分组计算功能 context by， 用于数据透视的pivot by、用于数据聚合的group by， 用于时间序列数据分段处理的segment by， 以及时间序列数据特有的asof join和window join， 也包括常用的分类和拟合算法
    + [文档](dolphindb/Tutorials_CN)
  - Informix TimeSeries

## 事务 Transaction

* a unit of work that can comprise multiple statements, executed together
* 原子性 atomicity 一个事务被视为一个不可分割最小工作单元，整个事务中所有操作要么全部提交成功，要么全部失败回滚，对于一个事务来说，不可能只执行其中的一部分操作
  - ensures this partially failed transaction is rolled back
* 一致性 consistency 数据库总是从一个一致性的状态转换到另外一个一致性的状态
* 隔离性 isolation 一个事务所做修改在最终提交以前，对其他事务是不可见的
* 持久性 durability 一旦事务提交，则其所做修改就会永久保存到数据库中。此时即使系统崩溃，修改的数据也不会丢失
  - 是个有点模糊的概念，因为实际上持久性也分很多不同的级别。有些持久性策略能够提供非常强的安全保障，而有些则未必。而且「不可能有能做到100%的持久性保证的策略」否则还需要备份做什么

## 命名

* 尽可能短
* 直观，尽可能正确和具有描述性
* 保持一致性
* 避免使用SQL和数据库引擎特定的关键字作为名字
* 建立命名约定

## 结构化查询语言 SQL Structured Query Language

一种特殊目的的编程语言，是一种数据库查询和程序设计语言程序设计语言，用于存取数据以及查询、更新和管理关系数据库系统

## 索引 Index

* 用来快速检索出具有特定值记录。没有索引，数据库就必须从第一条记录开始进行全表扫描，直到找出相关的行。数据越多，检索代价就越高，检索时如果表的列存在索引，那么MySQL就能快速到达指定位置去搜索数据文件，而不必查看所有数据。Most indexes use B+ tree structure.
  - Speeds up queries (in large tables that fetch only a few rows, min/max queries, by eliminating rows from consideration etc)
* 主键 Primary key
  - 本质是保证唯一记录，并不要求主键是连续的。用一个UUID作为主键，即varchar(32)，除了占用的存储空间较多外，字符串主键具有不可预测性。
  - 主键不可修改:主键的第二个作用是让其他表的外键引用自己，从而实现关系结构
  - 业务字段不可用于主键:主键必须使用单独的，完全没有业务含义的字段，也就是主键本身除了唯一标识和不可修改这两个责任外，主键没有任何业务含义。
  - 主键应该使用字符串:自增主键最大的问题是把公司业务的关键运营数据完全暴露给了竞争对手和VC
  - one or more columns that contain UNIQUE values, and cannot contain NULL values.
  - A table can have only ONE primary key.
  - An index on it is created by default.
* Foreign key
  - links two tables together.
  - Its value(s) match a primary key in a different table
  - Not null: Does not allow null values
  - Unique: Value of column must be unique across all rows
  - Default: Provides a default value for a column if none is specified during insert
* unique
* fulltext

## 连接 Join

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

* 在部署数据库的时候，不用于以前的单体应用，分布式下数据库部署包括多点部署，一套业务应用数据库被分布在多台数据库服务器上，分主从服务器。主服务器处理日常业务请求，从服务器在运行时不断的对主服务器进行备份，当主服务器出现宕机、或者运行不稳定的情况时，从服务器会立刻替换成主服务器，继续对外提供服务。此时，开发运维人员会对出现问题的服务器进行抢修、恢复，之后再把它投入到生产环境中。这样的构架也被称作为高可用构架，它支持了灾难恢复，为业务世界提供了可靠的支持，也是很多企业级应用采用的主流构架之一。
* 从数据库常常被设计成只读，主数据库支持读写操作
* 一般会有一台主数据库连接若干台从数据库
* 互联网产品的应用中，人们大多数情况下会对应用服务器请求读操作，这样应用服务器可以把读操作请求分发到若干个从数据库中，这样就避免了主数据库的并发请求次数过高的问题
* 从数据库的内容基本上可以说是主数据库的一份全拷贝，这样的技术称之为Replication。Replication在实现主从数据同步时，通常采用Transaction Log的方式，比如，当一条数据插入到主数据库的时候，主数据库会像Trasaction Log中插入一条记录来声明这次数据库写纪录的操作。之后，一个Replication Process会被触发，这个进程会把Transaction Log中的内容同步到从数据库中

## 扩展

* 水平扩展：通过增加服务器数量来对系统扩容。在这样的构架下，单台服务器的配置并不会很高，可能是配置比较低、很廉价的 PC，每台机器承载着系统的一个子集，所有机器服务器组成的集群会比单体服务器提供更强大、高效的系统容载量。这样的问题是系统构架会比单体服务器复杂，搭建、维护都要求更高的技术背景。
* 垂直扩展：是针对一台服务器进行硬件升级。仅限于单台服务器的扩容，尽可能的增加单台服务器的硬件配置。优点是构架简单，只需要维护单台服务器。

## [ClickHouse](https://github.com/yandex/ClickHouse)

* ClickHouse is a free analytic DBMS for big data. <https://clickhouse.tech>
* Yandex（俄罗斯最大的搜索引擎）开源的一个用于实时数据分析的基于列存储的数据库

## 分层数据库

* IMS基于层次模型工作。将数据视为树。以第一次构建数据库时预期的方式访问数据（先访问Customer，再访问Account），就可以非常快速地进行数据访问。但由于缺少灵活性。
* E. F. Codd（埃德加·弗兰克·科德）在1970年的论文“大型共享数据库的数据关系模型”中提出了关系模型
* 分层模型是一种自下而上的模型，是对具体现实的表示。而关系模型是基于关系代数的抽象模型，并且是自上而下的

## 中间件 Proxy

* 在电商系统中，随着业务量的增大，读写 QPS 越来越高，单节点 MySQL 实例压力也变得越来越大，单纯的对服务器硬件升级已经无法满足生产环境的需要。对数据分片增加多个节点，降低单节点 MySQL 实例的压力成了必然选择。
* [Atlas](https://github.com/Qihoo360/Atlas):A high-performance and stable proxy for MySQL, it is developed by Qihoo's DBA and infrastructure team
* [Mycat](link)
* [TDDL](link)
* [Vitess](https://github.com/youtube/vitess):Vitess is a database clustering system for horizontal scaling of MySQL. <http://vitess.io>
* [OneProxy](link)
* [Gaea](https://mp.weixin.qq.com/s?__biz=MzI4NTA1MDEwNg==&mid=2650779105&idx=1&sn=ed5093ab25a2b002cded6485fde97562&chksm=f3f91874c48e916252f7b46cccf5e4d6473feccaa4c078a84bbe24495317c6bdc59a59dbe699)

## 数据中心 Internet Data Center IDC

## [Cetus](https://github.com/Lede-Inc/cetus)

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
  - 复制流量（Replication）：当发生数据中心级别故障时，可能需要修改或者管理存储系统的复制流量，我们可能需要在其他数据中心创建副本来处理读请求，而副本的创建需要占用数据中心内部或者跨数据中心的网络资源
  - 有状态流量（Stateful）：主从复制的系统在主节点发生故障时，我们需要将主节点的状态拷贝至健康数据中心中的从节点，并将从节点进程成主节点以服务请求

## MySQL vs PG

* ACID
  - PostgreSQL支持事务的强一致性，事务保证性好，完全支持ACID特性。
  - MySQL只有innodb引擎支持事务，事务一致性保证上可根据实际需求调整，为了最大限度的保护数据，MySQL可配置双一模式，对ACID的支持上比PG稍弱弱。
* 复制
  - MySQL的复制是基于binlog的逻辑异步复制，无法实现同步复制
    + 通过canal增量数据的订阅和消费，可以同步数据到kafka，通过kafka做数据流转。
  - MySQL所有的高可用方案都是基于binlog做的同步，以及基于MySQL的分布式数据也是基于MySQL的binlog实现，binlog是MySQL生态圈最基本技术实现。
  - PostgreSQL可以做到同步，异步，半同步复制，以及基于日志逻辑复制，可以实现表级别的订阅和发布。
* 并发控制
  - PostgreSQL通过其MVCC实现有效地解决了并发问题，从而实现了非常高的并发性。PG新老数据一起存放的基于XID的MVCC机制,新老数据一起存放，需要定时触 发VACUUM，会带来多余的IO和数据库对象加锁开销，引起数据库整体的并发能力下降。而且VACUUM清理不及时，还可能会引发数据膨胀。当然PostgreSQL还有一点影响比较，为了保证事务的强一致性，未决事务会影响所有表VACUUM清理，导致表膨胀。
* 性能
  - PostgreSQL
   + PostgreSQL广泛用于读写速度高和数据一致性高的大型系统。此外，它还支持各种性能优化，当然这些优化仅在商业解决方案中可用，例如地理空间数据支持，没有读锁定的并发性等等。
   + PostgreSQL性能最适用于需要执行复杂查询的系统。
   + PostgreSQL在OLTP/ OLAP系统中表现良好，读写速度以及大数据分析方面表现良好，基于PG的GP数据库，在数据仓库领域表现良好。
   + PostgreSQL也适用于商业智能应用程序，但更适合需要快速读/写速度的数据仓库和数据分析应用程序。
  - MySQL
   + MySQL是广泛选择的基于Web的项目，需要数据库只是为了简单的数据事务。 但是，当遇到重负载或尝试完成复杂查询时，MySQL通常会表现不佳。
   + MySQL的读取速度，在OLTP系统中表现良好。
   + MySQL + InnoDB为OLTP场景提供了非常好的读/写速度。总体而言，MySQL在高并发场景下表现良好。
   + MySQL是可靠的，并且与商业智能应用程序配合良好，因为商业智能应用程序通常读取很多。
* 高可用技术
  + PostgreSQL
    + 基于流复制的异步、同步主从
    + 基于流复制的–keepalive
    + 基于流复制的 –repmgr
    + 基于流复制的 –patroni+etcd
    + 共享存储HA（corosync+pacemaker）
    + Postgres-XC
    + Postgres-XL
    + 中间件实现：pgpool、pgcluster、slony、plploxy
  - MySQL
    + 主从复制
    + 主主复制
    + MHA
    + LVS+KEEPALIVE
    + MGR分布式数据库，多点写入[不建议]，基于paxos协议
    + PXC分布式数据库，多点写入[不建议]，基于令牌环协议。
    + INNODB CLUSTER[8.0新技术，基于MGR实现，上层封装命令],基于paxos协议。
    + 中间件实现：mycat
* 数据存储和数据类型
  - PG主表采用堆表存放，存放的数据量较大，数据访问方式类似于Oracle的堆表。
  - MySQL采用索引组织表，MySQL必须有主键索引，所有的数据访问都是通过主键实现，二级索引访问时，需要扫描两遍索引（主键和二级索引
* PostgreSQL相对于MySQL的优势
  - 在SQL的标准实现上要比MySQL完善，而且功能实现比较严谨；
  - 存储过程的功能支持要比MySQL好，具备本地缓存执行计划的能力；
  - 对表连接支持较完整，优化器的功能较完整，支持的索引类型很多，复杂查询能力较强；
  - PG主表采用堆表存放，MySQL采用索引组织表，能够支持比MySQL更大的数据量。
  - PG的主备复制属于物理复制，相对于MySQL基于binlog的逻辑复制，数据的一致性更加可靠，复制性能更高，对主机性能的影响也更小。
  - MySQL的存储引擎插件化机制，存在锁机制复杂影响并发的问题，而PG不存在。
  - PG对可以实现外部数据源查询，数据源的支持类型丰富。
  - PG原生的逻辑复制可以实现表级别的订阅发布，可以实现数据通过kafka流转，而不需要其他的组件。
  - PG支持三种表连接方式，嵌套循环，哈希连接，排序合并，而MySQL只支持嵌套循环。
  - PostgreSQL源代码写的很清晰，易读性比MySQL强太多了。
  - PostgreSQL通过PostGIS扩展支持地理空间数据。 地理空间数据有专用的类型和功能，可直接在数据库级别使用，使开发人员更容易进行分析和编码。
  - 可扩展型系统，有丰富可扩展组件，作为contribute发布。
  - PostgreSQL支持JSON和其他NoSQL功能，如本机XML支持和使用HSTORE的键值对。 它还支持索引JSON数据以加快访问速度，特别是10版本JSONB更是强大。
  - PostgreSQL完全免费，而且是BSD协议，如果你把PostgreSQL改一改，然后再拿去卖钱，也没有人管你，这一点很重要，这表明了PostgreSQL数据库不会被其它公司控制。 相反，MySQL现在主要是被Oracle公司控制。
* MySQL相对于PG的优势
  - innodb的基于回滚段实现的MVCC机制，相对PG新老数据一起存放的基于XID的MVCC机制，是占优的。新老数据一起存放，需要定时触 发VACUUM，会带来多余的IO和数据库对象加锁开销，引起数据库整体的并发能力下降。而且VACUUM清理不及时，还可能会引发数据膨胀；
  - MySQL采用索引组织表，这种存储方式非常适合基于主键匹配的查询、删改操作，但是对表结构设计存在约束；
  - MySQL的优化器较简单，系统表、运算符、数据类型的实现都很精简，非常适合简单的查询操作；
  - MySQL相对于PG在国内的流行度更高，PG在国内显得就有些落寞了。
  - MySQL的存储引擎插件化机制，使得它的应用场景更加广泛，比如除了innodb适合事务处理场景外，myisam适合静态数据的查询场景。

## 分布式数据库

* 一群分布在计算机网络上、逻辑上相互关联的数据库,在物理上一群逻辑上相互关联的数据库可以分布式在一个或多个物理节点上
* CAP 理论
  - 分布式数据库的技术理论是基于单节点关系数据库的基本特性的继承，主要涉及事务的 ACID 特性、事务日志的容灾恢复性、数据冗余的高可用性几个要点。
  - 分布式数据的设计要遵循 CAP 定理
* BASE 理论
* 架构演变
  - Shard-everting：共享数据库引擎和数据库存储，无数据存储问题。一般是针对单个主机，完全透明共享 CPU/MEMORY/IO，并行处理能力是最差的，典型的代表 SQLServer；
  - Shared-storage：引擎集群部署，分摊接入压力，无数据存储问题；
  - Shard-noting：引擎集群部署，分摊接入压力，存储分布式部署，存在数据存储问题。各个处理单元都有自己私有的 CPU/内存/硬盘等，不存在共享资源，类似于 MPP（大规模并行处理）模式，各处理单元之间通过协议通信，并行处理和扩展能力更好。典型代表 DB2 DPF 和 hadoop ，各节点相互独立，各自处理自己的数据，处理后的结果可能向上层汇总或在节点间流转。

## 数据库

* [dbeaver](https://github.com/dbeaver/dbeaver):Free universal database tool and SQL client <http://dbeaver.jkiss.org>
* [knex](https://github.com/tgriesser/knex):A query builder for PostgreSQL, MySQL and SQLite3, designed to be flexible, portable, and fun to use. <http://knexjs.org>
* [otter](https://github.com/alibaba/otter)：阿里巴巴分布式数据库同步系统(解决中美异地机房)
* [WatermelonDB](https://github.com/Nozbe/WatermelonDB):🍉 Next-gen database for powerful React and React Native apps that scales to 10,000s of records and remains fast ⚡️
* [SQLAdvisor](https://github.com/Meituan-Dianping/SQLAdvisor)输入SQL，输出索引优化建议
* [gpdb](https://github.com/greenplum-db/gpdb):Greenplum Database <http://greenplum.org>
* [realm-js](https://github.com/realm/realm-js):Realm is a mobile database: an alternative to SQLite & key-value stores <https://realm.io>
* [orbit-db](https://github.com/orbitdb/orbit-db):Peer-to-Peer Databases for the Decentralized Web
* [arangodb](https://github.com/arangodb/arangodb):🥑 ArangoDB is a native multi-model database with flexible data models for documents, graphs, and key-values. Build high performance applications using a convenient SQL-like query language or JavaScript extensions. <https://www.arangodb.com>
* [gun](https://github.com/amark/gun):A realtime, decentralized, offline-first, graph database engine. <https://gun.eco/docs>
* [Introspected-REST](https://github.com/vasilakisfil/Introspected-REST):An alternative to REST and GraphQL <https://introspected.rest>
* [tair](https://github.com/alibaba/tair):A distributed key-value storage system developed by Alibaba Group
* [TDengine](https://github.com/taosdata/TDengine):An open-source big data platform designed and optimized for the Internet of Things (IoT). <https://www.taosdata.com>
* [foundationdb](https://github.com/apple/foundationdb):FoundationDB - the open source, distributed, transactional key-value store <https://www.foundationdb.org>
* [tinydb](https://github.com/msiemens/tinydb):TinyDB is a lightweight document oriented database optimized for your happiness :) <https://tinydb.readthedocs.org>
* [ImmortalDB](https://github.com/gruns/ImmortalDB):🔩 A relentless key-value store for the browser.
* [cockroach](https://github.com/cockroachdb/cockroach):CockroachDB - the open source, cloud-native SQL database. <https://www.cockroachlabs.com>
* [dgraph](https://github.com/dgraph-io/dgraph):Fast, Distributed Graph DB <https://dgraph.io>
* [pouchdb](https://github.com/pouchdb/pouchdb):🐨 - PouchDB is a pocket-sized database. <https://pouchdb.com/>
* [hive](https://github.com/apache/hive) Mirror of Apache Hive
* [leveldb](https://github.com/google/leveldb) LevelDB is a fast key-value storage library written at Google that provides an ordered mapping from string keys to string values.
* [DCache](https://github.com/tencent/dcache):分布式 NoSQL 存储系统,基于 TARS 微服务治理方案，支持 k-v、k-k-row、list、set 与 zset 多种数据结构，数据基于内存存储，同时支持后接 DB 实现数据持久化。DCache 具备快速水平扩展能力，同时配套有 Web 运维平台实现高效的运维操作。
  - 对外提供服务的粒度是 group，一个 group 负责一部分的数据分片，至于每个 group 服务哪些数据，是根据数据的 key 做 hash 映射后所处的范围来确定的。
  - 自身会处理缓存与DB之间的数据一致性问题
* [MemSQL](link)
* [Pivotal Greenplum](https://pivotal.io/pivotal-greenplum):Parallel Postgres for enterprise analytics at scale

## 课程

* [CMU 15-721 Advanced Database Systems](https://15721.courses.cs.cmu.edu/spring2020/)
* [《数据库系统概念》](https://www.bilibili.com/video/av52007695)

## 图书

* 数据库系统概念
* 数据库系统实现
* SQL基础教程
* [SQL应用重构](https://www.amazon.cn/gp/product/B00H6X6M1A)
* [SQL Cookbook](https://www.amazon.cn/gp/product/0596009763)
* SQL必知必会(第4版)
* SQL 反模式
* [高性能MySQL](https://www.amazon.cn/gp/product/B00C1W58DE)
* [MySQL技术内幕: InnoDB存储引擎（第2版）](https://www.amazon.cn/gp/product/B00ETOV48K)
* [深入浅出MySQL : 数据库开发、优化与管理维护](https://www.amazon.cn/gp/product/B00KR87J8G)
* 收获，不止Oracle（第2版）
* Readings in Database Systems
  - Joe Hellerstein’s Berkeley CS 186

## 工具

* [harelba/q](https://github.com/harelba/q):Run SQL directly on CSV or TSV files <http://harelba.github.io/q/>
* [osquery](https://github.com/facebook/osquery):SQL powered operating system instrumentation, monitoring, and analytics. <https://osquery.io>
  - [Docs](https://osquery.readthedocs.io)
* [adminer](https://github.com/vrana/adminer):Database management in a single PHP file <https://www.adminer.org/>
* [redash](https://github.com/getredash/redash):Make Your Company Data Driven. Connect to any data source, easily visualize and share your data. <http://redash.io/>
* [soar](https://github.com/XiaoMi/soar):SQL Optimizer And Rewriter
* [prisma](https://github.com/prisma/prisma)Next-generation ORM for Node.js & TypeScript | PostgreSQL, MySQL, MariaDB, SQL Server & SQLite <https://www.prisma.io/>
* [twemproxy](https://github.com/twitter/twemproxy):A fast, light-weight proxy for memcached and redis
* [druid](https://github.com/alibaba/druid):阿里巴巴数据库事业部出品，为监控而生的数据库连接池。阿里云Data Lake Analytics(<https://www.aliyun.com/product/datalakeanalytics> )、DRDS、TDDL 连接池powered by Druid <https://github.com/alibaba/druid/wiki>
* [hue](https://github.com/cloudera/hue):Hue is an open source SQL Cloud Assistant for developing and accessing SQL/Data Apps. <http://gethue.com>
* [usql](https://github.com/xo/usql):Universal command-line interface for SQL databases
* [franchise](https://github.com/HVF/franchise)：🍟 a notebook sql client. what you get when have a lot of sequels. <https://franchise.cloud>
* [Debezium](link)
  - 一个变更数据捕获（Change Data Capture, CDC） 平台，可以将数据库变更流式传输到Kafka 的 topics
  - 对数据库日志文件中的变更做出反应，并具有多个CDC连接器，适用于多种数据库，其中包括Postgres、MySQL、Oracle 和 MongoDB
* [textql](https://github.com/dinedal/textql) Execute SQL against structured text like CSV or TSV
* [TablePlus](https://tableplus.com/) Database management made easy
* [OtterTune](https://ottertune.com/)Database optimization. On autopilot.

## 参考

* [SQL Server Tutorial](https://www.sqlservertutorial.net/)
* [数据库原理](http://blog.jobbole.com/100349/)
* [Let's Build a Simple Database](https://cstack.github.io/db_tutorial/)
* [quick-SQL-cheatsheet](https://github.com/enochtangg/quick-SQL-cheatsheet):A quick reminder of all SQL queries and examples on how to use them.
* [Pool-Sizing](https://github.com/brettwooldridge/HikariCP/wiki/About-Pool-Sizing)
