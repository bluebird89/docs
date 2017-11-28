# Database

NoSQL 数据库的理论基础是CAP 理论，分别代表 Consistency（强一致性），Availability（可用性），Partition Tolerance（分区容错），分布式数据系统只能满足其中两个特性：

- C：系统在执行某项操作后仍然处于一致的状态。在分布式系统中，更新操作执行成功之后，所有的用户都能读取到最新的值，这样的系统被认为具有强一致性。
- A：用户执行的操作在一定时间内，必须返回结果。如果超时，那么操作回滚，跟操作没有发生一样。
- P：分布式系统是由多个分区节点组成的，每个分区节点都是一个独立的Server，P属性表明系统能够处理分区节点的动态加入和离开。

在构建分布式系统时，必须考虑CAP特性。传统的关系型DB，注重的是CA特性，数据一般存储在一台Server上。而处理海量数据的分布式存储和处理系统更注重AP，AP的优先级要高于C，但NoSQL并不是完全放弃一致性（Consistency），NoSQL保留数据的最终一致性（Eventually Consistency）。最终一致性是指更新操作完成之后，用户最终会读取到数据更新之后的值，但是会存在一定的时间窗口，用户仍会读取到更新之前的旧数据；在一定的时间延迟之后，数据达到一致性。

## 关系型数据库与非关系型数据库

关系模型在多表查询的时候并且数据量很大的时候效率很低，项目中我们通过非关系型数据库来解决此问题

## 索引

Laravel 也支持查询 JSON 类型的字段：仅支持，MySQL 5.7+ 和 Postgres数据库

### 主键

主键的本质是保证唯一记录，并不要求主键是连续的。用一个UUID作为主键，即varchar(32)，除了占用的存储空间较多外，字符串主键具有不可预测性。

- 主键不可修改:主键的第二个作用是让其他表的外键引用自己，从而实现关系结构
- 业务字段不可用于主键:主键必须使用单独的，完全没有业务含义的字段，也就是主键本身除了唯一标识和不可修改这两个责任外，主键没有任何业务含义。
- 主键应该使用字符串:自增主键最大的问题是把公司业务的关键运营数据完全暴露给了竞争对手和VC -

## 扩展

- [Let's Build a Simple Database](https://cstack.github.io/db_tutorial/)

## 原理

[如果有人问你数据库的原理，叫他看这篇文章](http://blog.jobbole.com/100349/)

## 工具

- [getredash/redash](https://github.com/getredash/redash) Make Your Company Data Driven. Connect to any data source, easily visualize and share your data. <http://redash.io/>
- [pingcap/tidb](https://github.com/pingcap/tidb)TiDB is a distributed NewSQL database compatible with MySQL protocol
- [alibaba/druid](https://github.com/alibaba/druid) Druid是一个JDBC组件库，包括数据库连接池、SQL Parser等组件 为监控而生的数据库连接池！阿里云DRDS(<https://www.aliyun.com/product/drds> )、阿里巴巴TDDL 连接池powered by Druid <https://github.com/alibaba/druid/wiki>
- [apache/incubator-superset](https://github.com/apache/incubator-superset): a modern, enterprise-ready business intelligence web application. a data exploration and visualization web application.
- [Meituan-Dianping/SQLAdvisor](https://github.com/Meituan-Dianping/SQLAdvisor)输入SQL，输出索引优化建议

### [HVF/franchise](https://github.com/HVF/franchise)

```sh
git clone git@github.com:HVF/franchise.git
cd franchise
yarn install
yarn start
browse http://localhost:3000
```

## Sharding

把一个 Database 切分成几个部分放到不同的服务器上，以分布式的手段增强数据库的性能。Sharding 又有水平切分和垂直切分的区别，如果数据库中 table 较多，可以把不同的表放在不同的服务器上，这便是垂直切分。如果某些 table 的数据量特别大，需要对其进行水平切分，将这个表的数据分发到多个服务器上。在互联网应用场景，一般以水平切分为主，实现上以数据库中间件（Database middleware）为主

## NoSQL

NoSQL主要用于解决以下几种问题

1.少量数据存储，高速读写访问。此类产品通过数据全部in-momery 的方式来保证高速访问，同时提供数据落地的功能，实际这正是Redis最主要的适用场景。
2.海量数据存储，分布式系统支持，数据一致性保证，方便的集群节点添加/删除。
3.这方面最具代表性的是dynamo和bigtable 2篇论文所阐述的思路。前者是一个完全无中心的设计，节点之间通过gossip方式传递集群信息，数据保证最终一致性，后者是一个中心化的方案设计，通过类似一个分布式锁服务来保证强一致性,数据写入先写内存和redo log，然后定期compat归并到磁盘上，将随机写优化为顺序写，提高写入性能。
4.Schema free，auto-sharding等。比如目前常见的一些文档数据库都是支持schema-free的，直接存储json格式数据，并且支持auto-sharding等功能，比如mongodb。