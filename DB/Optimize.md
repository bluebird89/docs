
# MySQL optimize

不同的语句，根据你选择的引擎、表中数据的分布情况、索引情况、数据库优化策略、查询中的锁策略等因素，最终查询的效率相差很大。除了纯技术面优化，还要根据业务面去优化sql语句

## 硬件优化

### CPU相关

服务器的BIOS设置中，可调整下面的几个配置，目的是发挥CPU最大性能，或者避免经典的NUMA问题：
* 选择Performance Per Watt Optimized(DAPC)模式，发挥CPU最大性能，跑DB这种通常需要高运算量的服务就不要考虑节电了；
* 关闭C1E和C States等选项，目的也是为了提升CPU效率；
* Memory Frequency（内存频率）选择Maximum Performance（最佳性能）；
* 内存设置菜单中，启用Node Interleaving，避免NUMA问题；
* 
### 磁盘I/O相关

* 使用SSD或者PCIe SSD设备，至少获得数百倍甚至万倍的IOPS提升；
* 购置阵列卡同时配备CACHE及BBU模块，可明显提升IOPS（主要是指机械盘，SSD或PCIe SSD除外。同时需要定期检查CACHE及BBU模块的健康状况，确保意外时不至于丢失数据）；
* 有阵列卡时，设置阵列写策略为WB，甚至FORCE WB（若有双电保护，或对数据安全性要求不是特别高的话），严禁使用WT策略。并且闭阵列预读策略，基本上是鸡肋，用处不大；
* 尽可能选用RAID-10，而非RAID-5；
* 使用机械盘的话，尽可能选择高转速的，例如选用15KRPM，而不是7.2KRPM的盘，不差几个钱的；

## 系统层相关优化

### 文件系统层优化

* 使用deadline/noop这两种I/O调度器，千万别用cfq（它不适合跑DB类服务）；
* 使用xfs文件系统，千万别用ext3；ext4勉强可用，但业务量很大的话，则一定要用xfs；
* 文件系统mount参数中增加：noatime, nodiratime, nobarrier几个选项（nobarrier是xfs文件系统特有的）；

### 其他内核参数优化

关键内核参数设定合适的值，目的是为了减少swap的倾向，并且让内存和磁盘I/O不会出现大幅波动，导致瞬间波峰负载

* 将vm.swappiness设置为5-10左右即可，甚至设置为0（RHEL 7以上则慎重设置为0，除非你允许OOM kill发生），以降低使用SWAP的机会；
* 将vm.dirty_background_ratio设置为5-10，将vm.dirty_ratio设置为它的两倍左右，以确保能持续将脏数据刷新到磁盘，避免瞬间I/O写，产生严重等待（和MySQL中的innodb_max_dirty_pages_pct类似）；
* 将net.ipv4.tcp_tw_recycle、net.ipv4.tcp_tw_reuse都设置为1，减少TIME_WAIT，提高TCP效率；
* 至于网传的read_ahead_kb、nr_requests这两个参数，我经过测试后，发现对读写混合为主的OLTP环境影响并不大（应该是对读敏感的场景更有效果），不过没准是我测试方法有问题，可自行斟酌是否调整；

## 流程

* MYSQL 收到一条查询请求时，会首先通过关键字对SQL语句进行解析，生成一颗“解析树”，
* 然后预处理器会校验“解析树”是否合法(主要校验数据列和表明是否存在，别名是否有歧义等)，
* 当“解析树”被认为合法后，查询优化器会对这颗“解析树”进行优化，并确定它认为最完美的执行计划。

## 步骤

* 添加索引：查询速度的提高是以插入、更新、删除的速度为代价的，这些写操作，增加了大量的I/O
    - 较频繁的作为查询条件字段应该创建索引`select * from order_copy where id = $id`
    - 唯一性太差的字段不适合单独创建索引，即使频繁作为查询条件`select * from order_copy where sex=’女’`
    - 更新非常频繁的字段不适合创建索引`select * from order_copy where order_state=’未付款’`
    - 不会出现在WHERE子句中字段不该创建索引
* 优化sql
* 加缓存，memcached,redis；
* 做主从复制或主主复制，读写分离，可以在应用层做
* mysql自带分区表，先试试这个，对你的应用是透明的，无需更改代码,但是sql语句是需要针对分区表做优化的，sql条件中要带上分区条件的列，从而使查询定位到少量的分区上，否则就会扫描全部分区
* 垂直拆分，其实就是根据你模块的耦合度，将一个大的系统分为多个小的系统，也就是分布式系统
* 水平切分，针对数据量大的表，这一步最麻烦，最能考验技术水平，要选择一个合理的sharding key,为了有好的查询效率，表结构也要改动，做一定的冗余，应用也要改，sql中尽量带sharding key，将数据定位到限定的表上去查，而不是扫描全部的表；

### 表结构设置

* 硬盘操作可能是最重大的瓶颈。所以，把你的数据变得紧凑会对这种情况非常有帮助，因为这减少了对硬盘的访问。需要留够足够的扩展空间
* ENUM 类型是非常快和紧凑的。在实际上，其保存的是 TINYINT，但其外表上显示为字符串。如果你有一个字段，比如“性别”，“国家”，“民族”，“状态”或“部门”，你知道这些字段的取值是有限而且固定的，那么，你应该使用 ENUM 而不是 VARCHAR。
* 固定长度的表会提高性能，因为MySQL搜寻得会更快一些，因为这些固定的长度是很容易计算下一个数据的偏移量的，所以读取的自然也会很快。固定长度的表也更容易被缓存和重建。不过，唯一的副作用是，固定长度的字段会浪费一些空间，因为定长的字段无论你用不用，他都是要分配那么多的空间。
* “垂直分割”是一种把数据库中的表按列变成几张表的方法，这样可以降低表的复杂度和字段的数目，从而达到优化的目的。

### 查询优化

对查询进行优化，要尽量避免全表扫描

* 首先应考虑在 where 及 order by 涉及的列上建立索引
* 应尽量避免在 where 子句中对字段进行 null 值判断，否则将导致引擎放弃使用索引而进行全表扫描.最好不要给数据库留NULL，尽可能的使用 NOT NULL填充数据库.
* 应尽量避免在 where 子句中使用 != 或 <> 操作符，否则将引擎放弃使用索引而进行全表扫描。
* 应尽量避免在 where 子句中使用 or 来连接条件，如果一个字段有索引，一个字段没有索引，将导致引擎放弃使用索引而进行全表扫描
* in 和 not in 也要慎用，否则会导致全表扫描,对于连续的数值，能用 between 就不要用 in 了
* select id from t where name like '%abc%' 全表扫描
* 在 where 子句中使用参数，也会导致全表扫描 select id from t where num = @num
* 避免在 where 子句中对字段进行表达式操作或者函数操作
* 尽量避免向客户端返回大数据量，若数据量过大，应该考虑相应需求是否合理
* 当只要一行数据时使用 LIMIT 1，找到一条数据后停止搜索，而不是继续往后查少下一条符合记录的数据
* JOIN 查询，确认两个表中Join的字段是被建过索引的。这样，MySQL内部会启动为你优化Join的SQL语句的机制。
* 避免 SELECT *：读出越多的数据，那么查询就会变得越慢，需要什么就取什么。这样不带任何条件的count会引起全表扫描，并且没有任何业务意义，是一定要杜绝的。
* 主键：每张表都设置一个ID做为其主键。使用UNSIGNED)，并设置上自动增加的AUTO_INCREMENT标志
* ORM 的最重要的是“Lazy Loading”，也就是说，只有在需要的去取值的时候才会去真正的去做。
* 索引并不是越多越好，索引固然可以提高相应的 select 的效率，但同时也降低了 insert 及 update 的效率，因为 insert 或 update 时有可能会重建索引

### 缓存

* $r = mysql_query("SELECT username FROM user WHERE signup_date >= CURDATE()"); CURDATE()、NOW() 和 RAND() 或是其它的诸如此类的SQL函数都不会开启查询缓存

### 操作

* 拆分大的 DELETE 或 INSERT 语句
```php
while (1) { 
    //每次只做1000条 
    mysql_query("DELETE FROM logs WHERE log_date <= '2009-11-01' LIMIT 1000"); 
    if (mysql_affected_rows() == 0) { 
        // 没得可删了，退出！ 
        break; 
    } 
    // 每次都要休息一会儿 
    usleep(50000); 
 } 
```
### 检查

* EXPLAIN 关键字可以让你知道MySQL是如何处理你的SQL语句的,分析SQL语句的执行情况
    - select_type:表示查询的类型。
    - table:输出结果集的表
    - type:表示表的连接类型(system和const为佳)
        + 要尽量避免让type的结果为all
    - possible_keys:表示查询时，可能使用的索引
    - key:表示实际使用的索引
    - key_len:索引字段的长度
    - rows:扫描的行数
    - Extra:执行情况的描述和说明
        + extra的结果为：using filesort
        + 
* PROCEDURE ANALYSE() 帮你去分析你的字段和其实际的数据，并会给你一些有用的建议。只有表中有实际的数据，这些建议才会变得有用，因为要做一些大的决定是需要有数据作为基础的。
* mysql支持把慢查询语句记录到日志文件中。程序员需要修改php.ini的配置文件，默认情况下，慢查询记录是不开启的:
```sql
EXPLAIN SELECT * FROM order_copy WHERE id=12345
show session status like 'Com%'; # 显示当前的连接的统计结果
show global status like 'Com%';  # 显示自数据库上次启动至今的统计结果
show status like 'Connections'; #  试图连接MySQL服务器的次数
show status like 'Uptime'; # 服务器工作的时间（单位秒）
show status like 'Slow_queries'; # 慢查询的次数
Show variables like 'long_query_time'; # 查询mysql的慢查询时间
set long_query_time=2 # 如果查询时间超过2秒就算作是慢查询

ALTER TABLE order_copy ADD PRIMARY KEY(id); # 给1千万的数据添加primary key 需要耗时： 428秒（7分钟）
EXPLAIN SELECT * FROM order_copy WHERE id=12345\G; # 给id添加了索引，才使得rows的结果为1
```

```php
long_query_time = 2 # 设置把日志写在那里，可以为空，系统会给一个缺省的文件
log-slow-queries = D:/mysql/logs/slow.log 
```


索引覆盖


存储使用EMC阵列（容量大，数据安全），IBM服务器，即IOE组合，这三个组合很强大（高可用，高性能）


