# [tidb](https://github.com/pingcap/tidb)

TiDB is a distributed HTAP database compatible with the MySQL protocol <https://pingcap.com>

* 开源分布式数据库，结合了传统的 RDBMS 和NoSQL 的最佳特性。TiDB 兼容 MySQL，支持无限的水平扩展，具备强一致性和高可用性。TiDB 的目标是为 OLTP(Online Transactional Processing) 和 OLAP (Online Analytical Processing) 场景提供一站式的解决方案
* 特点
  - 支持 MySQL 协议（开发接入成本低）
  - 100% 支持事务（数据一致性实现简单、可靠）
  - 无限水平拓展（不必考虑分库分表），不停服务
  - 支持和 MySQL 的互备
  - 遵循jdbc原则，学习成本低，强关系型，强一致性，不用担心主从配置，不用考虑分库分表，还可以无缝动态扩展
* 适合：
  - 原业务的 MySQL 的业务遇到单机容量或者性能瓶颈时，可以考虑使用 TiDB 无缝替换 MySQL
  - 大数据量下，MySQL 复杂查询很慢
  - 大数据量下，数据增长很快，接近单机处理的极限，不想分库分表或者使用数据库中间件等对业务侵入性较大、对业务有约束的 Sharding 方案
  - 大数据量下，有高并发实时写入、实时查询、实时统计分析的需求。5、有分布式事务、多数据中心的数据 100% 强一致性、auto-failover 的高可用的需求
* 不适合：
  - 单机 MySQL 能满足的场景也用不到 TiDB
  - 数据条数少于 5000w 的场景下通常用不到 TiDB，TiDB 是为大规模的数据场景设计的
  - 如果你的应用数据量小（所有数据千万级别行以下），且没有高可用、强一致性或者多数据中心复制等要求，那么就不适合使用 TiDB

## 工具

* [tikv](https://github.com/tikv/tikv):Distributed transactional key-value database, originally created to complement TiDB
