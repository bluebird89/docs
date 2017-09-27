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

## 扩展

- [Let's Build a Simple Database](https://cstack.github.io/db_tutorial/)

## 原理

<http://blog.jobbole.com/100349/>

## 工具

- [getredash/redash](https://github.com/getredash/redash) Make Your Company Data Driven. Connect to any data source, easily visualize and share your data. <http://redash.io/>
- [pingcap/tidb](https://github.com/pingcap/tidb)TiDB is a distributed NewSQL database compatible with MySQL protocol
- [alibaba/druid](https://github.com/alibaba/druid) Druid是一个JDBC组件库，包括数据库连接池、SQL Parser等组件 为监控而生的数据库连接池！阿里云DRDS(<https://www.aliyun.com/product/drds> )、阿里巴巴TDDL 连接池powered by Druid <https://github.com/alibaba/druid/wiki>
- [apache/incubator-superset](https://github.com/apache/incubator-superset): a modern, enterprise-ready business intelligence web application. a data exploration and visualization web application.
- [Meituan-Dianping/SQLAdvisor](https://github.com/Meituan-Dianping/SQLAdvisor)输入SQL，输出索引优化建议

### [HVF/franchise](https://github.com/HVF/franchise)

```
git clone git@github.com:HVF/franchise.git
cd franchise
yarn install
yarn start
browse http://localhost:3000
```
