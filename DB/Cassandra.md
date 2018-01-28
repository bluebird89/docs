# Cassandra

Apache Cassandra is a highly-scalable partitioned row store. Rows are organized into tables with a required primary key.

Partitioning means that Cassandra can distribute your data across multiple machines in an application-transparent matter. Cassandra will automatically repartition as machines are added and removed from the cluster.

Row store means that like relational databases, Cassandra organizes data by rows and columns. The Cassandra Query Language (CQL) is a close relative of SQL.

Cassandra is based on Google Bigtable, you’ll use column families /tables to store data.

支持多个平台，在日常开发中可以用来查询、管理数据库.Cassandra是一套开源分布式NoSQL数据库系统。它最初由Facebook开发，用于储存收件箱等简单格式数据，集GoogleBigTable的数据模型与Amazon Dynamo的完全分布式的架构于一身Facebook于2008将 Cassandra 开源，此后，由于Cassandra良好的可扩展性，被Digg、Twitter等知名Web 2.0网站所采纳，成为了一种流行的分布式结构化数据存储方案。
Cassandra是一个混合型的非关系的数据库，类似于Google的BigTable。其主要功能比Dynamo （分布式的Key-Value存储系统）更丰富，但支持度却不如文档存储MongoDB（介于关系数据库和非关系数据库之间的开源产品，是非关系数据库当中功能最丰富，最像关系数据库的。支持的数据结构非常松散，是类似json的bjson格式，因此可以存储比较复杂的数据类型）。Cassandra最初由Facebook开发，后转变成了开源项目。它是一个网络社交云计算方面理想的数据库。以Amazon专有的完全分布式的Dynamo为基础，结合了Google BigTable基于列族（Column Family）的数据模型。P2P去中心化的存储。很多方面都可以称之为Dynamo 2.0。[1] 
Cassandra的主要特点就是它不是一个数据库，而是由一堆数据库节点共同构成的一个分布式网络服务，对Cassandra 的一个写操作，会被复制到其他节点上去，对Cassandra的读操作，也会被路由到某个节点上面去读取。对于一个Cassandra群集来说，扩展性能是比较简单的事情，只管在群集里面添加节点就可以了。

模式灵活:使用Cassandra，像文档存储，你不必提前解决记录中的字段。你可以在系统运行时随意的添加或移除字段。
可扩展性:Cassandra是纯粹意义上的水平扩展。为给集群添加更多容量，可以指向另一台电脑。你不必重启任何进程，改变应用查询，或手动迁移任何数据。
多数据中心:可以调整你的节点布局来避免某一个数据中心起火，一个备用的数据中心将至少有每条记录的完全复制。
范围查询:如果你不喜欢全部的键值查询，则可以设置键的范围来查询。
列表数据结构:在混合模式可以将超级列添加到5维。
分布式写操作:有可以在任何地方任何时间集中读或写任何数据。并且不会有任何单点失败。

## 安装

### Mac

```sh
brew install cassandra

brew services start cassandra

# add ~/.bash_profile
if [ -d "$HOME" ]; then
    PATH="$PATH:/usr/local/Cellar/cassandra/3.11.1/bin"
fi

source ~/.bash_profile

cassandra -f # Start Cassandra. Cassandra should run with a long log record. use -f to start Cassandra in the foreground

nodetool status # 执行工具进行检查

cqlsh 
```

## 使用

```sql
create keyspace dev with replication = {'class':'SimpleStrategy','replication_factor':1};

use dev;

create table emp (empid int primary key, emp_first varchar, emp_last varchar, emp_dept varchar);

insert into emp (empid, emp_first, emp_last, emp_dept) values (1,'fred','smith','eng');

update emp set emp_dept = 'fin' where empid = 1;

select * from emp where empid = 1;

create index idx_dept on emp(emp_dept);
```
## 工具

* RazorSQL

## 参考

* [apache/cassandra](https://github.com/apache/cassandra)
* [官网](http://cassandra.apache.org/)
