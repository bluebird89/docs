## MySQL optimize

* 在实际的业务场景下通过测试来验证关于执行计划以及响应时间的假设，找出系统瓶颈,提高MySQL数据库的整体性能。不要听信看到的关于优化的“绝对真理”
* 合理的结构设计和参数调整,以提高用户的相应速度,同时还要尽可能的节约系统资源,以便让系统提供更大的负荷
* 不同的语句，根据选择的引擎、表中数据的分布情况、索引情况、数据库优化策略、查询中的锁策略等因素，最终查询的效率相差很大
* 效果：SQL及索引 > 数据库表结构 > 系统配置 > 硬件，成本则相反
    - 软优化一般是操作数据库即可
    - 硬优化则是操作服务器硬件及参数设置：CPU——Cache(L1-L2-L3)——内存——SSD硬盘——网络——硬盘
* 原则：
    - 减少数据访问（减少磁盘访问）：设置合理的字段类型，启用压缩，通过索引访问等减少磁盘 IO。**尽可能避免全表扫描**
    - 返回更少的数据（减少网络传输或磁盘访问）：只返回需要的字段和数据分页处理，减少磁盘 IO 及网络 IO。**减少无效数据的查询**
    - 减少交互次数（减少网络传输）：批量 DML 操作，函数存储等减少数据连接次数。**最大化利用索引**
    - 减少服务器 CPU 开销：尽量减少数据库排序操作以及全表查询，减少 CPU 内存占用。
    - 利用更多资源：使用表分区，可以增加并行操作，更大限度利用 CPU 资源

* 优先考虑通过缓存降低对数据库的读操作（如：redis）
* 考虑读写分离，降低数据库写操作
* 开始数据拆分
    - 首先考虑按照业务垂直拆分
    - 再考虑水平拆分：先分库（设置数据路由规则，把数据分配到不同的库中）
    - 最后再考虑分表，单表拆分到数据1000万以内
* 只要一行数据时使用limit 1，MySQL数据库引擎会在找到一条数据后停止搜索，而不是继续往后查少下一条符合记录的数据

## 指标

* 响应时间:包括服务时间和等待时间，这两个时间并不能细分出来，所以响应时间受影响比较大。可以通过估计查询的响应时间来做最初步的判断
* 返回行数
* 延时（响应时间）：硬件的突发处理能力
* 带宽（吞吐量）：硬件持续处理能力
    - QPS（Queries Per Second，每秒查询书）
    - TPS（Transactions Per Second）
* 低效原因
    - 硬件问题:如网络速度慢，内存不足，I/O吞吐量小，磁盘空间满了等
    - 检索大量不需要的数据,MySQL服务层在分析大量超过需要的数据行
        + 查询不需要的记录：一个常见的错误是误以为MySQL会只返回需要的数据，实际上MySQL是先返回全部结果集再进行运算。 加limit，需要字段
        + 返回多余的列：取出全部列，会让优化器无法完成索引覆盖扫描这类优化，而且给服务器带来额外的I/O，内存，CPU的消耗。
        + 重复数据：如用户头像需多次取出，此时应将数据缓存起来
    - 没有索引或者索引失效:（一般在互联网公司，DBA会在半夜把表锁了，重新建立一遍索引，因为删除某个数据的时候，索引的树结构就不完整了。所以互联网公司的数据做的是假删除.一是为了做数据分析,二是为了不破坏索引 ）
    - 数据过多（分库分表）
    - 服务器调优及各个参数设置（调整my.cnf）
    - 瓶颈
        + CPU在饱和的时候一般发生在数据装入内存或从磁盘上读取数据时候。
        + 磁盘I/O瓶颈发生在装入数据远大于内存容量的时候
        + 如果应用分布在网络上，那么查询量相当大的时候那么平瓶颈就会出现在网络上，我们可以用mpstat, iostat, sar和vmstat来查看系统的性能状态

## SQL 执行顺序

```
SELECT
DISTINCT <select_list>
FROM <left_table>
<join_type> JOIN <right_table>
ON <join_condition>
WHERE <where_condition>
GROUP BY <group_by_list>
HAVING <having_condition>
ORDER BY <order_by_condition>
LIMIT <limit_number>

FROM
<表名> # 选取表，将多个表数据通过笛卡尔积变成一个表。
ON
<筛选条件> # 对笛卡尔积的虚表进行筛选
JOIN <join, left join, right join...>
<join表> # 指定join，用于添加数据到on之后的虚表中，例如left join会将左表的剩余数据添加到虚表中
WHERE
<where条件> # 对上述虚表进行筛选
GROUP BY
<分组条件> # 分组
<SUM()等聚合函数> # 用于having子句进行判断，在书写上这类聚合函数是写在having判断里面的
HAVING
<分组筛选> # 对分组后的结果进行聚合筛选
SELECT
<返回数据列表> # 返回的单列必须在group by子句中，聚合函数除外
DISTINCT
# 数据除重
ORDER BY
<排序条件> # 排序
LIMIT
<行数限制>
```

## 检测

### [EXPLAIN](https://mp.weixin.qq.com/s/YkichgBT7TGNraus1sRO-w)

* 获取查询语句的执行计划，索引使用、扫描范围
* id：该语句的唯一标识。如果explain的结果包括多个id值，则数字越大越先执行；而对于相同id的行，则表示从上往下依次执行
- select_type:查询类型
    + SIMPLE： 简单查询，不包含 UNION 查询或子查询
    + PRIMARY： 主查询，或者最外层的查询
    + SUBQUERY：子查询中的第一个 SELECT
    + UNION：在UNION中的第二个和随后的SELECT被标记为UNION。如果UNION被FROM子句中的子查询包含，那么它的第一个SELECT会被标记为DERIVED
    + DEPENDENT UNION：UNION中的第二个或后面的查询，依赖了外面的查询
    + UNION RESULT：UNION 的结果
    + DEPENDENT SUBQUERY: 子查询中的第一个 SELECT，依赖了外面的查询. 即子查询依赖于外层查询的结果.
    + DERIVED：表示包含在FROM子句的子查询中的SELECT，MySQL会递归执行并将结果放到一个临时表中。MySQL内部将其称为是Derived table（派生表），因为该临时表是从子查询派生出来的
    + DEPENDENT DERIVED 派生表，依赖了其他的表
    + MATERIALIZED  物化子查询
    + UNCACHEABLE SUBQUERY  子查询，结果无法缓存，必须针对外部查询的每一行重新评估
    + UNCACHEABLE UNION：UNION属于UNCACHEABLE SUBQUERY的第二个或后面的查询
- table:表示当前这一行正在访问哪张表，如果SQL定义了别名，则展示表的别名
- partitions 当前查询匹配记录的分区。对于未分区的表，返回null
- type:在表中找到所需行的方式，或者叫访问类型. 从下到上，性能越来越差
    + system：该表只有一行（相当于系统表），system是const类型的特例
    + const：针对主键或唯一索引的等值查询扫描, 最多只返回一行数据. const 查询速度非常快, 因为它仅仅读取一次即可。例如：explain select * from user_info where id = 2；
    + eq_ref
        * 唯一性索引扫描，对于每个索引键，表中只有一条记录与之匹配,此类型通常出现在多表的 join 查询，表示对于前表的每一个结果，都只能匹配到后表的一行结果。并且查询的比较操作通常是 =，查询效率较高.(通常在联接时出现，查询使用索引为主键或惟一键)
        * 当使用了索引的全部组成部分，并且索引是PRIMARY KEY或UNIQUE NOT NULL 才会使用该类型
    + ref：非唯一性索引扫描，返回匹配某个单独值的所有行，本质上也是一种索引访问，返回所有匹配某个单独值的行，可能会找到多个符合条件的行，属于查找和扫描的混合体。当满足索引的最左前缀规则，或者索引不是主键也不是唯一索引时才会发生
    + fulltext：全文索引
    + `ref_or_null`：该类型类似于ref，但是MySQL会额外搜索哪些行包含了NULL。常见于解析子查询
    + index_merge：此类型表示使用了索引合并优化，表示一个查询里面用到了多个索引
    + `unique_subquery`：该类型和eq_ref类似，但是使用了IN查询，且子查询是主键或者唯一索引
    + `index_subquery`：和unique_subquery类似，只是子查询使用的是非唯一索引
    + range：范围扫描，表示检索了指定范围的行，主要用于有限制的索引扫描。比较常见的范围扫描是带有BETWEEN子句或WHERE子句里有>、>=、<、<=、IS NULL、<=>、BETWEEN、LIKE、IN()等操作符.key列显示使用了哪个索引
        * 比全表扫描要好，因为只需要开始于索引的某一点，而结束于另一点，不用扫描全部索引
    + index 全索引扫描(full index scan):只遍历索引树.和ALL类似，只不过index是全盘扫描了索引的数据。当查询仅使用索引中的一部分列时，可使用此类型。有两种场景会触发
        * 索引是查询的覆盖索引，并且索引查询的数据就可以满足查询中所需的所有数据，则只扫描索引树。此时，explain的Extra 列的结果是Using index。index通常比ALL快，因为索引的大小通常小于表数据。
        * 按索引的顺序来查找数据行，执行了全表扫描。此时，explain的Extra列的结果不会出现Uses index。
        * 优点：比ALL快、不用排序
        * 缺点:全表扫描
    + ALL：全表扫描，从内存读取整张表，增加I/O的速度并在CPU上加载
- possible_keys:当前查询可以使用哪些索引，这一列的数据是在优化过程的早期创建的，因此有些索引可能对于后续优化过程是没用的
- key:表示实际使用的索引
- `key_len`:表示查询优化器使用了索引的字节数，这个字段可以评估组合索引是否完全被使用.由于存储格式，当字段允许为NULL时，key_len比不允许为空时大1字节。
- ref:表示将哪个字段或常量和key列所使用的字段进行比较.如果ref是一个函数，则使用的值是函数的结果。要想查看是哪个函数，可在EXPLAIN语句之后紧跟一个SHOW WARNING语句
- rows:估算会扫描的行数，数值越小越好
- filtered:表示符合查询条件的数据百分比，最大100。用rows × filtered可获得和下一张表连接的行数
- Extra:执行情况的描述和说明
    + using index：使用了覆盖索引，避免访问了表的数据行，效率不错
        * 仅使用索引树中的信息从表中检索列信息，而不必进行其他查找以读取实际行。当查询仅使用属于单个索引的列时，可以使用此策略
    + 同时出现using where，表明索引被用来执行索引键值的查找；没有出现using where，表明索引用来读取数据而非执行查找动作
    + Using index condition 表示先按条件过滤索引，过滤完索引后找到所有符合索引条件的数据行，随后用 WHERE 子句中的其他条件去过滤这些数据行。通过这种方式，除非有必要，否则索引信息将可以延迟“下推(下推指的是将请求交给引擎层处理)”读取整个行的数据
    + Using index for group-by 数据访问和 Using index 一样，所需数据只须要读取索引，当Query 中使用GROUP BY或DISTINCT 子句时，如果分组字段也在索引中
    + using tmporary：创建一个临时表来保存结果。如果查询包含不同列的GROUP BY和 ORDER BY子句，通常会发生这种情况
    + using filesort：对数据使用一个外部的索引排序，而不是按照表内的索引顺序进行读取. (当使用order by v1,而没用到索引时,就会使用额外的排序)
        * 当Query 中包含 ORDER BY 操作，而且无法利用索引完成排序操作的时候，MySQL Query Optimizer 不得不选择相应的排序算法来实现。数据较少时从内存排序，否则从磁盘排序。Explain不会显示的告诉客户端用哪种排序。官方解释：“MySQL需要额外的一次传递，以找出如何按排序顺序检索行。通过根据联接类型浏览所有行并为所有匹配WHERE子句的行保存排序关键字和行的指针来完成排序。然后关键字被排序，并按排序顺序检索行”
* EXPLAIN可产生额外的扩展信息，可通过在EXPLAIN语句后紧跟一条SHOW WARNING语句查看扩展信息
    - 在MySQL 8.0.12及更高版本，扩展信息可用于SELECT、DELETE、INSERT、REPLACE、UPDATE语句；在MySQL 8.0.12之前，扩展信息仅适用于SELECT语句；
    - 在MySQL 5.6及更低版本，需使用EXPLAIN EXTENDED xxx语句；而从MySQL 5.7开始，无需添加EXTENDED关键词。
* 估计查询性能:通过计算磁盘的搜索次数来估算查询性能 `log(row_count) / log(index_block_length / 3 * 2 / (index_length + data_pointer_length)) + 1`
    - index_block_length通常是1024字节，数据指针一般是4字节
    - 对于写操作，需要四个搜索请求来查找在何处放置新的索引值，然后通常需要2次搜索来更新索引并写入行

```sql
{EXPLAIN | DESCRIBE | DESC}
    tbl_name [col_name | wild]

{EXPLAIN | DESCRIBE | DESC}
    [explain_type]
    {explainable_stmt | FOR CONNECTION connection_id}

{EXPLAIN | DESCRIBE | DESC} ANALYZE select_statement

explain_type: {
    FORMAT = format_name
}

format_name: {
    TRADITIONAL
  | JSON
  | TREE
}

explainable_stmt: {
    SELECT statement
  | TABLE statement
  | DELETE statement
  | INSERT statement
  | REPLACE statement
  | UPDATE statement
}

EXPLAIN format = TRADITIONAL json SELECT tt.TicketNumber, tt.TimeIn,
               tt.ProjectReference, tt.EstimatedShipDate,
               tt.ActualShipDate, tt.ClientID,
               tt.ServiceCodes, tt.RepetitiveID,
               tt.CurrentProcess, tt.CurrentDPPerson,
               tt.RecordVolume, tt.DPPrinted, et.COUNTRY,
               et_1.COUNTRY, do.CUSTNAME
        FROM tt, et, et AS et_1, do
        WHERE tt.SubmitTime IS NULL
          AND tt.ActualPC = et.EMPLOYID
          AND tt.AssignedPC = et_1.EMPLOYID
          AND tt.ClientID = do.CUSTNMBR;

## 结果
id  select_id   该语句的唯一标识
select_type 无   查询类型
table   table_name  表名
partitions  partitions  匹配的分区
type    access_type 联接类型
possible_keys   possible_keys   可能的索引选择
key key 实际选择的索引
key_len key_length  索引的长度
ref ref 索引的哪一列被引用了
rows    rows    估计要扫描的行
filtered    filtered    表示符合查询条件的数据百分比
Extra   没有  附加信息

EXPLAIN SELECT t1.a, t1.a IN (SELECT t2.a FROM t2) FROM t1\G
SHOW WARNINGS\G

EXPLAIN SELECT * FROM order_copy WHERE id=12345\G; # 给id添加了索引，才使得rows的结果为1
```

### PROCEDURE ANALYSE() 分析字段和其实际的数据，并会给一些有用的建议。只有表中有实际的数据，这些建议才会变得有用，因为要做一些大的决定是需要有数据作为基础的

### profiling:准确的SQL执行消耗系统资源的信息

### DESCRIBE：可以放在SELECT, INSERT, UPDATE, REPLACE 和 DELETE语句前边使用

### [`OPTIMIZER_TRACE`](https://mp.weixin.qq.com/s/QO_EVtpvCiYPdtDFOWWXhg)

一个跟踪功能，跟踪执行的语句的解析优化执行的过程，并将跟踪到的信息记录到`INFORMATION_SCHEMA.OPTIMIZER_TRACE`表中

- 从5.6开始提供了相关的功能，但是MySQL默认是关闭它的,在需要使用的时候才会手动去开启
- 通过optimizer_trace系统变量启停跟踪功能
- 可跟踪语句对象：
    + SELECT/INSERT/REPLACE/UPDATE/DELETE
    + EXPLAIN
    + SET
    + DO
    + DECLARE/CASE/IF/RETURN
    + CALL
- `show variables like '%optimizer_trace%';`
    + enabled：启用/禁用optimizer_trace功能。
    + one_line：决定了跟踪信息的存储方式，为on表示使用单行存储，否则以JSON树的标准展示形式存储。单行存储中跟踪结果中没有空格，造成可读性极差，但对于JSON解析器来说是可以解析的，将该参数打开唯一的优势就是节省空间，一般不建议开启。
    + `optimizer_trace_features`：该变量中存储了跟踪信息中可控的打印项，可以通过调整该变量，控制在INFORMATION_SCHEMA.OPTIMIZER_TRACE表中的trace列需要打印的JSON项和不需要打印的JSON项。默认打开该参数下的所有项。
    + optimizer_trace_max_mem_size ：optimizer_trace内存的大小，如果跟踪信息超过这个大小，信息将会被截断。
    + optimizer_trace_limit  & optimizer_trace_offset 这两个参数神似于SELECT语句中的“LIMIT offset, row_count”，optimizer_trace_limit 约束的是跟踪信息存储的个数，optimizer_trace_offset 则是约束偏移量。和 LIMIT 一样，optimizer_trace_offset 从0开始计算（最老的一个查询记录的偏移量为0）。
    + optimizer_trace_offset 的正负值，不需要太过于去纠结，如下表所示，其实offset 0 = offset -5 ，它们是一个等价的关系，仅仅是表述方式不同。这样的表述方式和python中的切片的表述是一致的，了解python的童鞋们都知道，切片的时候经常用到-1取列表中最后一个数值或者是反向取值。
- 使用
    + 打开optimizer_trace参数
    + 执行要分析的查询
    + 查看INFORMATION_SCHEMA.OPTIMIZER_TRACE表中跟踪结果
    + 循环2、3步骤
    + 当不再需要分析的时候，关闭参数
- SELECT * FROM INFORMATION_SCHEMA.OPTIMIZER_TRACE;三个步骤构成
    + join_preparation（准备阶段）
    + join_optimization（优化阶段）
    + join_execution（执行阶段）

![优化策略](../_static/index.jpeg "Optional title")

```sql
show [SESSION | GLOBAL] variables         # 查看数据库参数信息
SHOW [SESSION | GLOBAL] STATUS            # 查看数据库的状态信息

show global status like 'Questions';
show global status like 'Uptime'; # QPS = Questions / Uptime

show global status like 'Com_commit';
show global status like 'Com_rollback';
show global status like 'Uptime'; # TPS = (Com_commit + Com_rollback) / Uptime

vmstat 1 3 #  pay attentin to cpu
iostat -d -k 1 3

ALTER TABLE order_copy ADD PRIMARY KEY(id); # 给1千万的数据添加primary key 需要耗时： 428秒（7分钟）

show session status like 'Com%'; # 显示当前的连接的统计结果
show global status like 'Com%';  # 显示自数据库上次启动至今的统计结果

show status; # 显示当前MySQL服务器连接的会话状态变量信息
show status like 'Connections'; #  试图连接MySQL服务器的次数
show status like 'Uptime'; # 服务器工作的时间（单位秒）
show status like 'Slow_queries'; # 慢查询的次数
show status like 'Last_query_cost'; # 查看最后一条查询的成本
show innodb status；# 显示InnoDB存储引擎的状态
show processlist # 查看当前SQL执行，包括执行状态、是否锁表等
show variables; # 用来显示MySQL 服务实例的各种系统变量(如:全局系统变量，会话系统变量，静态变量)，这些变量包含MySQL编译时参数的默认值，或者是my.cnf中设置的参数值。系统变量或者参数是一个静态的概念，默认情况下系统变量名都是小写字母
Show variables like 'long_query_time'; # 查询mysql的慢查询时间
set long_query_time=2； # 如果查询时间超过2秒就算作是慢查询
set  global long_query_time = on; # 开启慢查询

select @@profiling;
set profiling=1;
show profiles\G;
show profile for query 1; # 采取针对性的优化措施
set profiling=0

show processlist;

SHOW VARIABLES LIKE 'slow_query%';
SHOW VARIABLES LIKE 'long_query_time%';

SET GLOABL SLOW_QUERY_LOG=on; # 临时设置
set long_query_time=1;

SET optimizer_trace="enabled=on";
show variables like '%optimizer_trace%';

SELECT * FROM INFORMATION_SCHEMA.OPTIMIZER_TRACE;
SET optimizer_trace="enabled=off";

top #  查看进程消耗
threads_running/QPS/TPS
MySQL profile 工具
orzdba
msyqladmin                                 mysql客户端，可进行管理操作
mysqlshow                                  功能强大的查看shell命令

information_schema                         获取元数据的方法
SHOW ENGINE INNODB STATUS                  Innodb引擎的所有状态
SHOW PROCESSLIST                           查看当前所有连接session状态
show index                                 查看表的索引信息
slow-log                                   记录慢查询语句
mysqldumpslow                              分析slowlog文件的
zabbix                  监控主机、系统、数据库（部署zabbix监控平台）
mysqlslap               分析慢日志
sysbench                压力测试工具
mysql profiling         统计数据库整体状态工具
Performance Schema      mysql性能状态统计的数据
workbench               管理、备份、监控、分析、优化工具（比较费资源）
show status  like '%lock%';    # 查询锁状态
kill SESSION_ID;   # 杀掉有问题的session
```

## 硬件优化

* 配置多核心和频率高的cpu,多核心可以执行多个线程
* 配置大内存,提高内存,即可提高缓存区容量,因此能减少磁盘I/O时间,从而提高响应速度
* 配置高速磁盘或合理分布磁盘:高速磁盘提高I/O,分布磁盘能提高并行操作的能力
* 专门用于数据库的服务器，并采用ssd
* CPU：服务器的BIOS设置中，可调整下面的几个配置，目的是发挥CPU最大性能，或者避免经典的NUMA问题：
    - 选择Performance Per Watt Optimized(DAPC)模式，发挥CPU最大性能，跑DB这种通常需要高运算量的服务就不要考虑节电了
    - 关闭C1E和C States等选项，目的也是为了提升CPU效率
    - Memory Frequency（内存频率）选择Maximum Performance（最佳性能）
    - 内存设置菜单中，启用Node Interleaving，避免NUMA问题
    - 重点往往是吞吐量，性能优先:解放数据库CPU，把复杂逻辑计算放到服务层
* 内存
* 磁盘I/O
    - 使用SSD或者PCIe SSD设备，至少获得数百倍甚至万倍的IOPS提升
    - 购置阵列卡同时配备CACHE及BBU模块，可明显提升IOPS（主要是指机械盘，SSD或PCIe SSD除外。同时需要定期检查CACHE及BBU模块的健康状况，确保意外时不至于丢失数据）
    - 有阵列卡时，设置阵列写策略为WB，甚至FORCE WB（若有双电保护，或对数据安全性要求不是特别高的话），严禁使用WT策略。并且闭阵列预读策略，基本上是鸡肋，用处不大
    - 尽可能选用RAID-10，而非RAID-5
    - 使用机械盘的话，尽可能选择高转速的，例如选用15KRPM，而不是7.2KRPM的盘
    - 有足够的物理内存，能将整个InnoDB文件加载到内存里 —— 如果访问的文件在内存里，而不是在磁盘上，InnoDB会快很多
    - 全力避免 Swap 操作 — 交换（swapping）是从磁盘读取数据，所以会很慢
    - 使用电池供电的RAM（Battery-Backed RAM）
    - 使用一个高级磁盘阵列 — 最好是 RAID10 或者更高
    - 避免使用RAID5 — 和校验需要确保完整性，开销很高
    - 将你的操作系统和数据分开，不仅仅是逻辑上要分开，物理上也要分开 — 操作系统的读写开销会影响数据库的性能
    - 将临时文件和复制日志与数据文件分开 — 后台的写操作影响数据库从磁盘文件的读写操作
    - 更多的磁盘空间等于更高的速度
    - 磁盘速度越快越好
    - SAS优于SATA
    - 小磁盘的速度比大磁盘的更快，尤其是在 RAID 中
    - 使用电池供电的缓存 RAID（Battery-Backed Cache RAID）控制器
    - 避免使用软磁盘阵列
    - 考虑使用固态IO卡（不是磁盘）来作为数据分区 — 几乎对所有量级数据，这种卡能够支持 2 GBps 的写操作
    - 在 Linux 系统上，设置 swappiness 的值为0 — 没有理由在数据库服务器上缓存文件，这种方式在Web服务器或桌面应用中用的更多
    - 尽可能使用 noatime 和 nodirtime 来挂载文件系统 — 没有必要为每次访问来更新文件的修改时间
    - 使用 XFS 文件系统 — 一个比ext3更快的、更小的文件系统，拥有更多的日志选项，同时，MySQL在ext3上存在双缓冲区的问题
    - 优化你的 XFS 文件系统日志和缓冲区参数 – -为了获取最大的性能基准
    - 在Linux系统中，使用 NOOP 或 DEADLINE IO 调度器 — CFQ 和 ANTICIPATORY 调度器已经被证明比 NOOP 和 DEADLINE 慢
    - 使用 64 位操作系统 — 有更多的内存能用于寻址和 MySQL 使用
    - 将不用的包和后台程序从服务器上删除 — 减少资源占用
    - 将使用 MySQL 的 host 和 MySQL自身的 host 都配置在一个 host 文件中 — 这样没有 DNS 查找
    - 永远不要强制杀死一个MySQL进程 — 你将损坏数据库，并运行备份
    - 让你的服务器只服务于MySQL — 后台处理程序和其他服务会占用数据库的 CPU 时间
* 参数设置
    - 文件系统层
        + 使用deadline/noop这两种I/O调度器，千万别用cfq（它不适合跑DB类服务）
        + 使用xfs文件系统，千万别用ext3；ext4勉强可用，但业务量很大的话，则一定要用xfs
        + 文件系统mount参数中增加：noatime, nodiratime, nobarrier几个选项（nobarrier是xfs文件系统特有的）
    - 内核参数优化：关键内核参数设定合适的值，目的是为了减少swap的倾向，并且让内存和磁盘I/O不会出现大幅波动，导致瞬间波峰负载
        + 将vm.swappiness设置为5-10左右即可，甚至设置为0（RHEL 7以上则慎重设置为0，除非你允许OOM kill发生），以降低使用SWAP的机会
        + 将vm.dirty_background_ratio设置为5-10，将vm.dirty_ratio设置为它的两倍左右，以确保能持续将脏数据刷新到磁盘，避免瞬间I/O写，产生严重等待（和MySQL中的innodb_max_dirty_pages_pct类似）
        + 将net.ipv4.tcp_tw_recycle、net.ipv4.tcp_tw_reuse都设置为1，减少TIME_WAIT，提高TCP效率
        + 至于网传的read_ahead_kb、nr_requests这两个参数，我经过测试后，发现对读写混合为主的OLTP环境影响并不大（应该是对读敏感的场景更有效果），不过没准是我测试方法有问题，可自行斟酌是否调整
* 分库分表+读写分离

```
# cpu方面
vmstat、sar top、htop、nmon、mpstat
# 内存
free 、ps -aux 、
# IO设备（磁盘、网络）
iostat 、 ss  、 netstat 、 iptraf、iftop、lsof、

vmstat 命令说明：
Procs：r显示有多少进程正在等待CPU时间。b显示处于不可中断的休眠的进程数量。在等待I/O
Memory：swpd显示被交换到磁盘的数据块的数量。未被使用的数据块，用户缓冲数据块，用于操作系统的数据块的数量
Swap：操作系统每秒从磁盘上交换到内存和从内存交换到磁盘的数据块的数量。s1和s0最好是0
Io：每秒从设备中读入b1的写入到设备b0的数据块的数量。反映了磁盘I/O
System：显示了每秒发生中断的数量(in)和上下文交换(cs)的数量
Cpu：显示用于运行用户代码，系统代码，空闲，等待I/O的CPU时间

iostat命令说明
实例命令：iostat -dk 1 5
　　　　    iostat -d -k -x 5 （查看设备使用率（%util）和响应时间（await））
tps：该设备每秒的传输次数。“一次传输”意思是“一次I/O请求”。多个逻辑请求可能会被合并为“一次I/O请求”。
iops ：硬件出厂的时候，厂家定义的一个每秒最大的IO次数

"一次传输"请求的大小是未知的。
kB_read/s：每秒从设备（drive expressed）读取的数据量；
KB_wrtn/s：每秒向设备（drive expressed）写入的数据量；
kB_read：读取的总数据量；
kB_wrtn：写入的总数量数据量；这些单位都为Kilobytes。
```

### MySQL 配置

* MySQL 客户端和服务端通信协议是“半双工”的，客户端发送给服务器和服务器发给客户端是不能同时发生，这种协议让MySQL通信简单快速，但也就无法进行流量控制，一旦一端开始了，另一端是能等它结束。所以查询语句很长的时候，参数max_allowed_packet就特别重要了
* 使用 innodb_flush_method=O_DIRECT 来避免写的时候出现双缓冲区
* 避免使用 O_DIRECT 和 EXT3 文件系统 — 会把所有写入的东西序列化
* innodb_buffer_pool_size:保存索引和原始数据，来将整个InnoDB 文件加载到内存 — 减少从磁盘上读
    - InnoDB严重依赖缓冲池，必须为它分配了足够的内存
    - 可以减少磁盘访问，内存读写速度比磁盘的读写速度快很多，所以这个参数对mysql性能有很大提升。当然，这里不是越大越好，也要考虑实际的服务器情况
    - 更大的缓冲池会使得mysql服务在重启和关闭的时候花费很长时间
    - 独立使用的mysql服务器：设置为服务器内存的约75%~80%
    - 还有其他服务也在运行：需要减去这部分程序占用的内存、mysql自身需要的内存以及减去足够让操作系统缓存InnoDB日志文件的内存，至少是足够缓存最近经常访问的部分
* innodb_log_file_size 不要太大，这样能够更快，也有更多的磁盘空间 — 经常刷新有利降低发生故障时的恢复时间
    - InnoDB使用日志来减少提交事务时的开销
    - InnoDB用日志把随机I/O变成顺序I/O
    - innodb_log_files_in_group：控制日志文件数，一般默认为2。mysql事务日志文件是循环覆写的
    - 当一个日志文件写满后，innodb会自动切换到另一个日志文件，而且会触发数据库的checkpoint，这回导致innodb缓存脏页的小批量刷新，会明显降低innodb的性能
    - 如果innodb_log_file_size设置太小，就会导致innodb频繁地checkpoint，导致性能降低
    - 如果设置太大，由于事务日志是顺序I/O，大大提高了I/O性能，但是在崩溃恢复InnoDB时，会导致恢复时间变长
    - 如果InnoDB数据表有频繁的写操作，那么选择合适的innodb_log_file_size值对提升MySQL性能很重要
    - 日志文件的全部大小，应该足够容纳服务器一个小时的活动内容
        + 在业务高峰期，计算出1分钟写入事务日志（redo log）的量，然后评估出一个小时的redo log量
        + Log sequence number是写入事务日志的总字节数，通过1分钟内两个值的差值，可以看到每分钟有多少KB日志写入到MySQL中
* innodb_log_buffer_size：控制日志缓冲区的大小，不需要把日志缓冲区设置得非常大。推荐的范围是1MB~8MB
* innodb_flush_log_at_trx_commit 控制commit动作是否刷新log buffer到磁盘中
    - = 0 把日志缓冲写到日志文件中，并且每秒钟刷新一次，但是事务提交时不做任何事，该设置是3者中性能最好的。也就是说设置为0时是(大约)每秒刷新写入到磁盘中的，当系统崩溃，会丢失1秒钟的数据
    - 保持默认值（1）的话，能保证数据的完整性，也能保证复制不会滞后
* 不要同时使用 innodb_thread_concurrency 和 thread_concurrency 变量 — 这两个值不能兼容
* 为 max_connections 指定一个小的值 — 太多的连接将耗尽你的RAM，导致整个MySQL服务器被锁定
* 保持 thread_cache 在一个相对较高的数值，大约是 16 — 防止打开连接时候速度下降
* 使用 skip-name-resolve — 移除 DNS 查找
* 如果查询重复率比较高，并且数据不是经常改变，请使用查询缓存, 在经常改变的数据上使用查询缓存会对性能有负面影响
* 增加 temp_table_size — 防止磁盘写
* 增加 max_heap_table_size — 防止磁盘写
* 不要将 sort_buffer_size 的值设置的太高 — 可能导致连接很快耗尽所有内存
* 监控 key_read_requests 和 key_reads，以便确定 key_buffer 的值 — key 的读需求应该比 key_reads 的值更高，否则使用 key_buffer 就没有效率了
* 有一个测试配置的环境，可以经常重启，不会影响生产环境
* 只允许使用内网域名，而不是ip连接数据库.不只是数据库，缓存（memcache、redis）的连接，服务（service）的连接都必须使用内网域名，机器迁移/平滑升级/运维管理…太多太多的好处
* key_buffer_size:索引缓冲区大小
* table_cache:能同时打开表的个数
* query_cache_size和query_cache_type:前者是查询缓冲区大小,后者是前面参数的开关,0表示不使用缓冲区,1表示使用缓冲区,但可以在查询中使用SQL_NO_CACHE表示不要使用缓冲区,2表示在查询中明确指出使用缓冲区才用缓冲区,即SQL_CACHE.
* sort_buffer_size:排序缓冲区

```
pager grep Log
show engine innodb status\G select sleep(60); show engine innodb status\G;
```

![InnoDB-cache 缓存与文件](../_static/InnoDB-cache.jpg "Optional title")

## Prepared Statements

* 很像存储过程，是一种运行在后台的SQL语句集合
* 可以检查一些绑定好的变量，保护程序不会受到“SQL注入式”攻击
* 性能方面，当一个相同的查询被使用多次的时候，带来可观的性能优势。可以给这些Prepared Statements定义一些参数，而MySQL只会解析一次
* 最新版本的MySQL在传输Prepared Statements是使用二进制形势，所以这会使得网络传输非常有效率

### Schema优化

* 字段名及字段配制合理性
    - 剔除关系不密切的字段
    - 字段命名要有规则及相对应的含义（不要一部分英文，一部分拼音，还有类似a.b.c这样不明含义的字段）
    - 字段命名尽量不要使用缩写（大多数缩写都不能明确字段含义）
    - 字段不要大小写混用（想要具有可读性，多个英文单词可使用下划线形式连接）
    - 字段名不要使用保留字或者关键字
    - 保持字段名和类型的一致性
    - 慎重选择数字类型
    - 给文本字段留足余量
* 系统特殊字段处理及建成后建议
    - 添加删除标记（例如操作人、删除时间）
    - 建立版本机制
* 表结构合理性配置
    - 多型字段的处理，就是表中是否存在字段能够分解成更小独立的几部分（例如：人可以分为男人和女人）
    - 多值字段的处理，可以将表分为三张表，这样使得检索和排序更加有调理，且保证数据的完整性！
* 其它建议
    - 对于大数据字段，独立表进行存储，以便影响性能（例如：简介字段）
    - 使用varchar类型代替char，因为varchar会动态分配长度，char指定长度是固定的
    - 给表创建主键，对于没有主键的表，在查询和索引定义上有一定的影响
    - 避免表字段运行为null，建议设置默认值（例如：int类型设置默认值为0）在索引查询上，效率立显
    - 建立索引，最好建立在唯一和非空的字段上，建立太多的索引对后期插入、更新都存在一定的影响（考虑实际情况来创建）
* 为不同的需求选择不同的存储引擎
    - 日志表或审计表使用ARCHIVE存储引擎：写的效率更高
* 保证数据库的整洁性:移除不必要的表
* 归档老数据 — 删除查询中检索或返回的多余的行
* UTF 8 和 UTF16 比 latin1 慢
* 有节制的使用触发器
* 修改表结构
    - 大表 ALTER TABLE非常耗时,大部分修改表结果操作的方法:建一个张空表，从旧表中查出所有的数据插入新表，然后再删除旧表。尤其当内存不足而表又很大，而且还有很大索引的情况下，耗时更久
    - 逐步对 schema 做修改 — 一个小的变化将产生的巨大的影响
    - 在开发环境测试所有 schema 变动，而不是在生产环境的镜像上去做
    - 增加列时，先删除索引，之后在加上索引会更快
* 配置
    - 不要随意改变配置文件，这可能产生非常大的影响
    - 有时候，少量的配置会更好
    - 质疑使用通用的MySQL配置文件
    - 调优数据库参数和缓冲区大小
    - 调优数据库连接池大小或者线程池大小
    - 调整数据库事务隔离级别
* 分析表:分析表中关键字的分布 `ANALYZE TABLE user`
    - Op:表示执行的操作
    - Msg_type:信息类型,有status,info,note,warning,error
    - Msg_text:显示信息
* 检查表:检查表中是否存在错误 `CHECK TABLE user [option]`,option 只对MyISAM有效,共五个参数值
    - QUICK:不扫描行,不检查错误的连接
    - FAST:只检查没有正确关闭的表
    - CHANGED:只检查上次检查后被更改的表和没被正确关闭的表
    - MEDIUM:扫描行,以验证被删除的连接是有效的,也可以计算各行关键字校验和
    - EXTENDED:最全面的的检查,对每行关键字全面查找
* 优化表:消除删除或更新造成的表空间浪费 `OPTIMIZE [LOCAL|NO_WRITE_TO_BINLOG] TABLE user`
    - LOCAL|NO_WRITE_TO_BINLOG都是表示不写入日志.,优化表只对VARCHAR,BLOB和TEXT有效
    - 通过OPTIMIZE TABLE语句可以消除文件碎片,在执行过程中会加上只读锁
* 在夜间安排批量删除，避免不必要的锁表
* 客户必须使用业务、领域特定的知识，预估预期将处理的数据库中的数据量
* 对重量级、更新少的数据考虑使用应用级别的缓存
* 不在数据库做计算，cpu计算务必移至业务层
* 禁止使用小数存储国币,尽量少的使用除法
* 硬盘操作可能是最重大的瓶颈：把数据变得紧凑会对这种情况非常有帮助，因为这减少了对硬盘的访问。需要留够足够的扩展空间
* 固定长度的表会更快：固定长度的表会提高性能，因为MySQL搜寻得会更快一些，因为这些固定的长度是很容易计算下一个数据的偏移量的，所以读取的自然也会很快。固定长度的表也更容易被缓存和重建。不过，唯一的副作用是，固定长度的字段会浪费一些空间，因为定长的字段无论用不用，都是要分配那么多的空间
* 拆分大的DELETE 或INSERT 语句
* 平衡范式与冗余，为提高效率可以牺牲范式设计，冗余数据.保持数据最小量的冗余 — 不要复制没必要的数据
* 尽量避免NULL并且提供默认值:把可为 NULL的列改为 NOT NULL不会对性能提升有多少帮助，只是如果计划在列上创建索引，就应该将该列设置为 NOT NULL
    - 如果查询中包含可为NULL 的列， 对MySQL来说更难优化
        + 使得索引、 索引统计和值比较都更复杂
        - null 这种类型MySQL内部需要进行特殊处理，增加数据库处理记录的复杂性；同等条件下，表中有较多空字段的时候，数据库的处理性能会降低很多
        + null值需要更多的存储空，无论是表还是索引中每行中的null的列都需要额外的空间来标识
        + 对null 的处理时候，只能采用is null或is not null，而不能采用=、in、<、<>、!=、not in这些操作符号
        + 在MySQL里也需要特殊处理
        + 当可为NULL的列被索引时， 每个索引记录需要一个额外的字节， 在MyISAM 里甚至还可能导致固定大小的索引（例如只有一个整数列的索引）变成可变大小的索引
    - 例外：lnnoDB 使用单独的位 (bit) 存储NULL值， 所以对于稀疏数据有很好的空间效率
* 数据类型
    - 遵循小而简单：满足值的范围的需求前提下，井且预留未来增长空间的前提下，尽可能选择长度小的，更小的数据类型通常更快，占用更少的磁盘、内存和CPU缓存，I/O高效 并且处理时需要的CPU周期也更少
    - 尽量使用数字型字段（如性别，男：1 女：2），若只含数值信息的字段尽量不要设计为字符型，这会降低查询和连接的性能，并会增加存储开销。引擎在处理查询和连接时会 逐个比较字符串中每一个字符，而对于数字型而言只需要比较一次就够了
    - 整数类型：尽量使用TINYINT、SMALLINT、MEDIUM_INT作为整数类型而非INT，如果非负则加上UNSIGNED
        * 整数通常是标识列最好的选择， 因为它们很快并且可以使用AUTO_INCREMENT
        + 整数 (whole number)
            * 可以使用这几种整数类型：TINYINT, SMALLINT, MEDIUMINT, INT, BIGINT。分别使用8,16, 24, 32, 64位存储空间
            * UNSIGNED:表示不允许负值，这大致可以使正数的上限提高一倍。 例如 TINYINT. UNSIGNED 可以存储的范围是 0 - 255, 而 TINYINT 的存储范围是 -128 -127
            * 整数计算一般使用64 位的 BIGINT 整数， 即使在 32 位环境也是如此。（ 一些聚合函数是例外， 它们使用DECIMAL 或 DOUBLE 进行计算）
            * 可以为整数类型指定宽度， 例如 INT(11), 对大多数应用这是没有意义的, INT使用32位（4个字节）存储空间，那么它的表示范围已经确定
                - 不会限制值的合法范围，只是规定了MySQL 的一些交互工具（例如 MySQL 命令行客户端）用来显示字符的个数
                - 对于存储和计算来说， INT(1) 和 INT(20) 是相同的
        + 实数 (real number)：实数是带有小数部分的数字
            * 不只是为了存储小数部分，也可以使用DECIMAL 存储比 BIGINT 还大的整数
            * FLOAT和DOUBLE类型支持使用标准的浮点运算进行近似计算
            * DECIMAL:用于存储精确的小数
                - 没有太大的必要使用 DECIMAL数据类型。即使是在需要存储财务数据时，仍然可以使用 BIGINT。比如需要精确到万分之一，那么可以将数据乘以一百万然后使用 BIGINT存储。这样可以避免浮点数计算不准确和 DECIMAL精确计算代价高的问题
            * 浮点和DECIMAL类型都可以指定精度
            * DECIMAL：可以指定小数点前后所允许的 最大位数。这会影响列的空间消耗。 有多种方法可以指定浮点列所需要的精度， 这会使得MySQL悄悄选择不同的数据类型，或者在存储时对值进行取舍。 这些精度定义是非标准
            * 建议只指定数据类型，不指定精度。 浮点类型在存储同样范围的值时， 通常比DECIMAL使用更少的空间。
                - FLOAT使用4个字节存储。DOUBLE占用8个字节，相比FLOAT有更高的精度和更大的范围。
            * 和整数类型一样，能选择的只是存储类型； MySQL使用DOUBLE作为内部浮点计算的类型。 因为需要额外的空间和计算开销，所以应该尽扯只在对小数进行精确计算时才使用DECIMAL
            * 在数据最比较大的时候， 可以考虑使用BIGINT代替DECIMAL, 将需要存储的货币单位根据小数的位数乘以相应的倍数即可。
        + 整型比字符操作代价更低：因为字符集和校对规则（排序规则 ）使字符比较比整型比较更复杂,会使用整型来存储ip地址，使用 DATETIME来存储时间，而不是使用字符串
    - 字符串类型：只分配真正需要的空间
        + VARCHAR 用于存储可变⻓字符串，长度支持到 65535 需要使用1或2个额外字节记录字符串的长度
            * 适合：字符串的最大⻓度比平均⻓度⼤很多；更新很少
            * 节约空间，因为CHAR是固定长度，而VARCHAR不是（utf8 不受这个影响）
            * 使用varchar(20)存储手机号：涉及到区号或者国家代号，可能出现+-()，varchar可以支持模糊查询，例如：like“138%”
        + CHAR 定⻓，⻓度范围是1~255
            * 适合：存储很短的字符串，或者所有值接近同一个长度，经常变更字段
        + 长度慷慨是不明智的 使用VARCHAR(5)和VARCHAR(200)存储'hello'的空间开销是一样的，但是更短的列有很大的优势
            * 更长的列会消耗更多的内存， 因为MySQL通常会分配固定大小的内存块来保存内部值。 尤其是使用内存临时表进行排序或操作时会特别糟糕。 在利用磁盘临时表进行排序时也同样糟糕。
            * 最好的策略是只分配真正需要的空间
        + SELECT uid FROM t_user WHERE phone=13812345678 用 SELECT uid FROM t_user WHERE phone=’13812345678’ phone 为varchar
        + 字符串类型 如果可能， 应该避免使用字符串类型作为标识列， 因为它们很消耗空间， 并且通常比数字类型慢
        + 使用枚举或整数代替字符串类型
    - 日期和时间类型：尽量使用TIMESTAMP而非DATETIME
        + TIMESTAMP使用4个字节存储空间， DATETIME使用8个字节存储空间
        + TIMESTAMP只能表示1970 - 2038年，比 DATETIME表示的范围小得多，而且 TIMESTAMP的值因时区不同而不同
    - 尽可能不使用TEXT/BLOB类型
        + 确实需要的话，建议拆分到子表中，不要和主表放在一起，避免SELECT * 的时候读性能太差。
        + 非必要的大量的大字段查询会淘汰掉热数据，导致内存命中率急剧降低，影响数据库性能
        + 其他数据需要经常需要查询，而 blob/text 不需要,拆分TEXT/BLOB:TEXT类型处理性能远低于VARCHAR，强制生成硬盘临时表浪费更多空间
        + 压缩 text 和 blob 数据类型 — 为了节省空间，减少从磁盘读数据
        + BLOB和TEXT类型 BLOB和 TEXT都是为存储很大的数据而设计的字符串数据类型， 分别采用二进制和字符方式存储
        + 与其他类型不同， MySQL把每个BLOB和TEXT值当作一个独立的对象处理。 存储引擎在存储时通常会做特殊处理。
            * 当BLOB和TEXT值太大时，InnoDB会使用专门的 "外部"存储区域来进行存储，此时每个值在行内需要1 - 4个字节存储 存储区域存储实际的值
        + BLOB 和 TEXT 之间仅有的不同是 BLOB 类型存储的是二进制数据， 没有排序规则或字符集， 而 TEXT类型有字符集和排序规则
    - ENUM
        + ENUM的内部实际存储就是整数(保存的是 TINYINT),但其外表上显示为字符串。如果有一个字段，比如“性别”，“国家”，“民族”，“状态”或“部门”，知道这些字段的取值是有限而且固定的，那么应该使用 ENUM 而不是 VARCHAR
        + 缺点是枚举的字符串列表是固定的:添加和删除字符串（枚举选项）必须使用 ALTER TABLE（如果只是在列表末尾追加元素，不需要重建表）
        + 使用ENUM、CHAR 而不是VARCHAR，使用合理的字段属性长度
        + ENUM和SET类型对于标识列来说，EMUM和SET类型通常是一个糟糕的选择，尽管对某些只包含固定状态或者类型的静态 "定义表" 来说可能是没有问题的
        * ENUM和SET列适合存储固定信息， 例如有序的状态、 产品类型、 人的性别
    + 对千完全 "随机" 的字符串也需要多加注意， 例如 MDS() 、 SHAl() 或者 UUID() 产生的字符串。 这些函数生成的新值会任意分布在很大的空间内， 这会导致 INSERT 以及一些SELECT语句变得很慢
    + 如果存储 UUID 值， 则应该移除 "-"符号
    + 特殊类型数据 某些类型的数据井不直接与内置类型一致
        * 低千秒级精度的时间戳
        * 整型来存IPv4地址:实际上是32位无符号整数，不是字符串。用小数点将地址分成四段的表示方法只是为了让人们阅读容易。所以应该用无符号整数存储IP地址。MySQL提供INET_ATON()和INET_NTOA()函数在这两种表示方法之间转换
* 分离频繁更新和频繁读取的数据，新增字段时分析使用链接表还是扩展行
* 用 varchar/nvarchar 代替 char/nchar
* 规范
    - 控制单表数据量:单表1G体积 500W⾏,控制在千万级
    - 单表不超过50个INT字段 不超过20个CHAR(10)字段:存储引擎的API工作时需要在服务器层和存储引擎层之间通过行缓冲格式拷贝数据，然后在服务器层将缓冲内容解码成各个列，这个转换过程的代价是非常高的。如果列太多而实际使用的列又很少的话，有可能会导致CPU占用过高
    - 单行不超过200Byte
* 禁止使用外键，如果有外键完整性约束，需要应用程序控制：外键会导致表与表之间耦合，update与delete操作都会涉及相关联的表，十分影响sql 的性能，甚至会造成死锁。高并发情况下容易造成数据库性能，大数据高并发业务场景数据库使用以性能优先
* 多表联接查询时，关联字段类型尽量一致，并且都要有索引
* 所有的InnoDB表都设计一个无业务用途的自增列做主键，对于绝大多数场景都是如此，真正纯只读用InnoDB表的并不多，真如此的话还不如用TokuDB来得划算
* 类似分页功能的SQL，建议先用主键关联，然后返回结果集，效率会高很多
* 分解表：对于字段较多的表,如果某些字段使用频率较低,此时应当,将其分离出来从而形成新的表
* 对于将大量连接查询的表可以创建中间表,从而减少在查询时造成的连接耗时
* 增加冗余字段：类似于创建中间表,增加冗余也是为了减少连接查询
* 使用 ENUM 而不是 VARCHAR。如果有一个字段，比如“性别”，“国家”，“民族”，“状态”或“部门”，你知道这些字段的取值是有限而且固定的，那么，应该使用 ENUM 而不是VARCHAR
* 不用外键，由程序保证约束
* 尽量不用 UNIQUE ，由程序保证约束

## 索引优化

* 单表索引建议控制在5个以内,不允许超过5个：字段超过5个时，实际已经起不到有效过滤数据的作用
* 数据量小的表最好不要使用索引，因为由于数据较少，可能查询全部数据花费的时间比遍历索引的时间还要短，索引就可能不会产生优化效果
* 保证索引简单：不要在同一列上加多个索引
* 更新频繁字段不适合创建索引,频繁查询条件字段应创建索引`select * from order_copy where id = $id`
* 唯一性太差、基数（Cardinality）太小（比如说，该列的唯一值总数少于255、字段不适合单独创建索引，区分度不高，字段值离散度低 `select * from order_copy where sex=’女’`
* 优先考虑 where、order by、GROUP BY 、JOIN 使用到的字段，对<，<=，=，>，>=，BETWEEN，IN，以及某些时候的LIKE才会使用索引
* 尽量避免使用 or，会导致数据库引擎放弃索引进行全表扫描
    - 用 union 代替 or
* 尽量避免进行 null 值判断，会导致数据库引擎放弃索引进行全表扫描
    - 可以给字段添加默认值 0，对 0 值进行判断
* 避免使用 in 和 not in，会导致引擎走全表扫描
    - 如果是连续数值，可以用 between 代替
    - 如果是子查询，可以用 exists 代替
* 查询条件不能用 <> 或者 !=
* 不要过度使用索引:会导致过高的磁盘使用率以及过高的内存占用
    - 索引固然可以提高相应 select 效率，但同时也降低了 insert 及 update 的效率，因为 insert 或 update 时写操作有可能会重建索引,增加了大量I/O
    - 降低更新表速度：被索引的表上INSERT和DELETE会变慢，因为更新表时，MySQL不仅要保存数据，还要保存索引文件
    - 占用磁盘空间的索引文件。一般情况这个问题不太严重，但如果在一个大表上创建了多种组合索引，索引文件的会膨胀很快
* 前缀索引：对字符串列进行索引，如果可能应该指定一个前缀长度。 例如，如果有一个CHAR(255)的列，如果在前10个或20个字符内，多数值是惟一的，那么就不要对整个列进行索引
    - 对一个VARCHAR(N)列创建索引时，通常取其50%（甚至更小）左右长度创建前缀索引就足以满足80%以上的查询需求了，没必要创建整列的全长度索引
    - 短索引不仅可以提高查询速度而且可以节省磁盘空间和I/O操作
* 复合（联合）索引:满足最左匹配
    - 多个列上建立独立的索引并不能提高查询性能。理由非常简单，MySQL不知道选择哪个索引的查询效率更好
        + 在老版本，比如MySQL5.0之前就会随便选择一个列的索引
        + 新的版本会采用合并索引的策略
            * 当出现多个索引做相交操作时（多个AND条件），通常来说一个包含所有相关列索引要优于多个独立索引
            * 当出现多个索引做联合操作时（多个OR条件），对结果集的合并、排序等操作需要耗费大量的CPU和内存资源，特别是当其中的某些索引的选择性不高，需要返回合并大量数据时，查询成本更高。所以这种情况下还不如走全表扫描。
        + explain时如果发现有索引合并（Extra字段出现 Usingunion），应该好好检查一下查询和表结构是不是已经是最优的，如果查询和表都没有问题，那只能说明索引建的非常糟糕，应当慎重考虑索引是否合适，有可能一个包含所有相关列的多列索引更适合
        + 多用复合索引，少用多个独立索引
    - 索引顺序:把选择性更高字段放到索引的前面，这样通过第一个字段就可以过滤掉大多数不符合条件的数据
        + 仅包含复合索引非前置列，不会走联合索引
* 数据库如果计算出使用索引所耗费的时间长于全表扫描或其它操作时，将不会使用索引
* 数据量大时，避免使用 where 1=1 的条件
    - 拼装 SQL 时进行判断，没 where 条件就去掉 where，有 where 条件就加 and
* 避免在 where 条件 ORDER BY 中等号的左侧进行表达式、函数操作（是表达式的一部分，或者函数参数），会导致数据库引擎放弃索引进行全表扫描`select * from users where YEAR(adddate)<2007;`
* 模糊查询:避免在字段开头使用，导致数据库引擎放弃索引进行全表扫描 like “%aaa%”, like “aaa%”可以使用索引
    - 使用 MySQL 内置函数 INSTR（str，substr）来匹配，作用类似于 Java 中的 indexOf()，查询字符串出现的角标位置
    - 使用 FullText 全文索引，用 match against 检索
    - 数据量较大的情况，建议引用 ElasticSearch、Solr，亿级数据量检索速度秒级。
    - 当表数据量较少（几千条儿那种），别整花里胡哨的，直接用 like '%xx%'
* 隐式类型转换造成不使用索引：索引对列类型为 varchar，但给定的值为数值，涉及隐式类型转换，造成不能正确走索引
* 索引列排序
    - order by 条件要与 where 中条件一致，否则 order by 不会利用索引进行排序，对其他需要排序的操作也有效。比如 group by 、union 、distinct 等
    - 不走age索引：`SELECT * FROM t order by age;` 走age索引：`SELECT * FROM t where age > 0 order by age;`
        + 根据 where 条件和统计信息生成执行计划，得到数据
        + 将得到的数据排序。当执行处理数据（order by）时，数据库会先查看第一步的执行计划，看 order by 的字段是否在执行计划中利用了索引。如果是，则可以利用索引顺序而直接取得已经排好序的数据。如果不是，则重新进行排序操作。
        + 返回排序后的数据
    - 尽量不要包含多个列的排序，如果需要最好给这些列创建复合索引
    - 先过滤再排序：会用到过滤条件中的索引参数，但是排序会使用较慢的外部排序。因为这个结果集是经过过滤的，并没有什么索引参与
    - 先排序再过滤：使用同一个索引，排序的优先级高于过滤的优先级。选择合适索引，在过滤的同时就排序了。扫描的行数会增加
* 正确使用 hint 优化语句：数据库系统的查询优化器并不一定总是能使用最优索引,使用 hint 指定优化器在执行时排除其他索引干扰而指定更优的执行计划：
    - USE INDEX 在查询语句中表名的后面，添加 USE INDEX 来提供希望 MySQL 去参考索引列表，不再考虑其他可用的索引。 `SELECT col1 FROM table USE INDEX (mod_time, name)...`
    - IGNORE INDEX 如果只是单纯的想让 MySQL 忽略一个或者多个索引  `SELECT col1 FROM table IGNORE INDEX (priority) ...`
    - FORCE INDEX 为强制 MySQL 使用一个特定的索引 `SELECT col1 FROM table FORCE INDEX (mod_time) ...`
* 尽量避免事后添加索引：可能需要监控大量的SQL才能定位到问题所在，而且添加索引的时间肯定是远大于初始添加索引所需要的时间

```sql
# actorid和filmid两个列上都建立了独立的索引,如下查询
select film_id , actor_id from film_actor where actor_id = 1 or film_id = 1
# 老版本的MySQL会随机选择一个索引，但新版本做如下的优化
select film_id , actor_id from film_actor where actor_id = 1 union all select film_id , actor_id from film_actor where film_id = 1 and actor_id <> 1

CREATE TABLE `test` (
  `id` int(11) NOT NULL,
  `a` int(11) DEFAULT NULL,
  `b` int(11) DEFAULT NULL,
  `c` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

DROP PROCEDURE IF EXISTS test_initData;
DELIMITER $
CREATE PROCEDURE test_initData()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i<=100000 DO
        INSERT INTO test(id,a,b,c) VALUES(i,i*2,i*3,i*4);
        SET i = i+1;
    END WHILE;
END $

DELIMITER ;
CALL test_initData();

explain select * from test where a>10 and b >10  order by c # idx_a_b_c  extra 则用到了filesort
explain select * from test where c>10 and b >10   order by a # idx_b_a_c，但依然使用的filesort
explain select * from test FORCE INDEX(idx_c_b_a) where a>10 and b >10  order by c # 使用了index，使用了where，只在索引上就完成了操作。但扫描的行数却增加了。
```

### 查询优化

对查询进行优化，要尽量避免全表扫描

* 用EXPLAIN或DESCRIBE(DESC)命令分析一条查询语句执行信息，分析查询语句或是表结构的性能瓶颈。EXPLAIN 的查询结果会说明索引主键被如何利用，数据表是如何被搜索和排序
    - 使用 EXPLAIN 和慢SQL分析来决定查询功能是否合适
    - 经常测试你的查询，看是否需要做性能优化，性能可能会随着时间的变化而变化
    - Show Profile是比Explain更近一步的执行细节，可以查询到执行每一个SQL都干了什么事，这些事分别花了多少秒
    - 基准查询，包括服务器的负载，有时一个简单的查询会影响其他的查询
    - 当服务器的负载增加时，使用SHOW PROCESSLIST来查看慢的/有问题的查询
    - 在存有生产环境数据副本的开发环境中，测试所有可疑的查询
* 主键：每张表都设置一个ID做为其主键。`UNSIGNED AUTO_INCREMENT PRIMARY KEY`
* 如果合适，用 GROUP BY 代替 DISTINCT
* 使用索引字段和 ORDER BY 来代替 MAX
* 使用 SQL_MODE=STRICT 来检查问题
* 使用 INSERT ON DUPLICATE KEY 或 INSERT IGNORE 来代替 UPDATE，避免 UPDATE 前需要先 SELECT
* 缓存优化
    - 保持查询一致，后续类似的查询就能使用查询缓存
    - CURDATE()、NOW() 和 RAND() 或是其它的诸如此类的SQL函数都不会开启查询缓存:`$r = mysql_query("SELECT username FROM user WHERE signup_date >= CURDATE()");`
* 对 UPDATE 来说，使用 SHARE MODE 来防止排他锁
* 重启 MySQL 时，记得预热数据库，确保将数据加载到内存，提高查询效率
* 删除表中所有数据:使用 DROP TABLE ，然后再 CREATE TABLE ，而不是 DELETE FROM
* 使用 truncate 代替 delete
	- 当删除全表中记录时，使用 delete 语句的操作会被记录到 undo 块中，删除记录也记录 binlog。
	- 当确认需要删除全表时，会产生很大量的 binlog 并占用大量的 undo 数据块，此时既没有很好的效率也占用了大量的资源。
	- 使用 truncate 替代，不会记录可恢复的信息，数据不能被恢复。也因此使用 truncate 操作有其极少的资源占用与极快的时间。另外，使用 truncate 可以回收表的水位，使自增字段值归零。
* 考虑持久连接，而不是多次建立连接，已减少资源的消耗
    - 持久连接意味着减少重建连接到MySQL的成本
    - 当持久连接被创建时，它将保持打开状态直到脚本完成运行
    - 因为Apache重用它的子进程，下一次进程运行一个新的脚本时，它将重用相同的MySQL连接。`mysql_pconnect()`,可能会出现连接数限制问题、内存问题等等
* 禁止使用存储过程、视图、触发器、Event
* 尽量避免使用游标，因为游标的效率较差，如果游标操作的数据超过1万行，那么就应该考虑改写
* 禁止使用外键，如果有外键完整性约束，需要应用程序控制
* 查询数据量大的表 会造成查询缓慢。主要的原因是扫描行数过多。这个时候可以通过程序，分段分页进行查询，循环遍历，将结果合并处理进行展示
* 避免频繁创建和删除临时表，以减少系统表资源的消耗。临时表并不是不可使用，适当地使用它们可以使某些例程更有效，例如，当需要重复引用大型表或常用表中的某个数据集时。但是，对于一次性事件， 最好使用导出表。
* 多表关联查询
	- 小表在前，大表在后。第一张表会涉及到全表扫描，在扫描后面的大表，或许只扫描大表的前 100 行就符合返回条件并 return 了
	- 连接多个表时，请使用表的别名并把别名前缀于每个列名上。这样就可以减少解析的时间并减少哪些友列名歧义引起的语法错误
	- 将过滤数据多的条件往前放，最快速度缩小结果集
    - 多表联接并且有排序时，排序字段必须是驱动表里的，否则排序列无法用到索引
* 关联查询:表与表之间通过一个冗余字段来关联，要比直接使用 JOIN有更好的性能。如果确实需要使用关联查询的情况下，需要特别注意的是
    - 确保 ON 和 USING字句中的列上有索引。在创建索引的时候就要考虑到关联的顺序。当表A和表B用列c关联的时候，如果优化器关联的顺序是A、B，那么就不需要在A表的对应列上创建索引。没有用到的索引会带来额外的负担，一般来说，除非有其他理由，只需要在关联顺序中的第二张表的相应列上创建索引
    - 确保任何的 GROUP BY和 ORDER BY中的表达式只涉及到一个表中的列，这样MySQL才有可能使用索引来优化
    - 任何的关联都执行嵌套循环关联操作，即先在一个表中循环取出单条数据，然后在嵌套循环到下一个表中寻找匹配的行，依次下去，直到找到所有表中匹配的行为为止。然后根据各个表匹配的行，返回查询中需要的各个列
* UNION
    - UNION策略是先创建临时表，然后再把各个查询结果插入到临时表中，最后再来做查询
    - 创建并填充临时表的方式来执行 union 查询。除非确实要消除重复的行，否则建议使用 union all
    - 尽量用union all代替union：union和union all的差异主要是前者需要将结果集合并后再进行唯一性过滤操作，这就会涉及到排序，增加大量的CPU运算，加大资源消耗及延迟。当然，union all的前提条件是两个结果集没有重复数据。
    - 如果没有 all 这个关键词，MySQL 会给临时表加上 distinct 选项，这会导致对整个临时表的数据做唯一性校验，这样做的消耗相当高
    - 使用 UNION 来代替 WHERE 子句中的子查询
    - 子查询的效率不如连接查询（join）:因为MySQL不需要在内存中创建临时表来完成这个在逻辑上需要两个步骤的查询工作
    - 索引字段少于5个时，UNION 操作用 LIMIT，而不是 OR
* 用 where 字句替换 HAVING 字句：避免使用 HAVING 字句，因为 HAVING 只会在检索出所有记录之后才对结果集进行过滤，而 where 则是在聚合前刷选记录，如果能通过 where 字句限制记录的数目，那就能减少这方面的开销。
	- HAVING 中的条件一般用于聚合函数的过滤，除此之外，应该将条件写在 where 字句中。
	- where 和 having 的区别：where 后面不能使用组函数。
* 移除外部连接查询
    - 在两个表的行中放置占位符（空数据）来删除OUTER JOINS操作
* 返回结果
    - 避免出现 select *:只获取必要的字段，避免产生严重的随机读问题,读取不需要的列会让优化器无法完成索引覆盖扫描这类优化，会影响优化器对执行计划的选择，也会增加网络带宽消耗，更会带来额外的 I/O，内存和 CPU 消耗
    - 限制工作数据集大小：查询语句带有子查询时，注意在子查询的内部语句上使用过滤
    - 尽量避免向客户端返回大数据量，若数据量过大，应该考虑相应需求是否合理
    - 避免出现不确定结果的函数
        + 主从复制这类业务场景，使用如 now()、rand()、sysdate()、current_user() 等不确定结果的函数很容易导致主库与从库相应的数据不一致
        + 产生的 SQL 语句无法利用 query cache
    - 只要一行数据时使用 `LIMIT 1`，找到一条数据后停止搜索，而不是继续往后查少下一条符合记录的数据
    * `select *` 和 `select 字段`
        + 如果某些不需要字段数据量特别大，还是写清楚字段比较好，因为这样可以减少网络传输
        + index coverage 覆盖索引：不用回表
    * `Select count(*)`和 `Select Count(1)`
        + 统计某个列值的数量:列值是非空的，不会统计NULL,如果确认括号中的表达式不可能为空时，实际上就是在统计行数
        + 统计行数
        + `count(*)`和`count(1)`的执行效率是完全一样的，误解也就在这儿，在括号内指定了一列却希望统计结果是行数，而且还常常误以为前者的性能会更好。但实际并非这样，如果要统计行数，直接使用 COUNT(*)，意义清晰，且性能更好。根本不存在所谓的单列扫描和多列扫描的问题
        + 有时候某些业务场景并不需要完全精确的 COUNT值，可以用近似值来代替，EXPLAIN出来的行数就是一个不错的近似值，而且执行EXPLAIN并不需要真正地去执行查询，所以成本非常低。
        + 执行 COUNT()都需要扫描大量的行才能获取到精确的数据，因此很难优化，MySQL层面还能做得也就只有覆盖索引了
        + 如果不还能解决问题，只有从架构层面解决了，比如添加汇总表，或者使用redis这样的外部缓存系统。
        + `COUNT(*)`:忽略所有的列而直接统计所有的行数。可能会将整个表锁住
        + 假如表沒有主键(Primary key), 那么count(1)比count(*)快，都包括对NULL的统计，而count(column) 是不包括NULL的统计
        + 如果有主键的話，那主键作为count的条件时候count(主键)最快
        + InnoDB 中COUNT( * )操作的时间复杂度为 O(N)，其中 N 为表的行数，循环: 读取 + 计数
        + MyISAM 表中可以快速取到表的行数
        + 如果的表只有一个字段的话那count(*)就是最快的
        + `count(*)`只是返回表中行数，因此SQL Server在处理`count(*)`的时候只需要找到属于表的数据块块头，然后计算一下行数就行了，而不用去读取里面数据列的数据。而对于count(col)就不一样了，为了去除col列中包含的NULL行，SQL Server必须读取该col的每一行的值，然后确认下是否为NULL，然后在进行计数。
    - 分页
        + `LIMIT M,N`:全表扫描,速度会很慢且结果集返回不稳定,`LIMIT 10000，20`需要查询10020条记录然后只返回20条记录，前面的10000条都将被抛弃，这样的代价非常高
        + limit 语句的查询时间与起始记录的位置成正比
        + 避免使用 OFFSET `SELECT id FROM t WHERE id > 10000 LIMIT 10 ;`
        + `WHERE id_pk > (pageNum*10) ORDER BY id_pk ASC LIMIT M`:ORDER BY后的列对象是主键或唯一所以,使得ORDERBY操作能利用索引被消除但结果集是稳定的
            * 排序操作:只有ASC 没有DESC
        + `PREPARE stmt_name FROM SELECT * FROM 表名称 WHERE id_pk > (？* ？) ORDER BY id_pk ASC LIMIT M`
        + 尽可能的使用覆盖索引扫描，而不是查询所有的列。然后根据需要做一次关联查询再返回所有的列
        + 利用表的覆盖索引来加速分页查询
* 对于复杂的查询，可以使用中间临时表暂存数据
* 拆分复杂 SQL 为多个小 SQL，避免大事务
	- 简单的 SQL 容易使用到 MySQL 的 QUERY CACHE。
	- 减少锁表时间特别是使用 MyISAM 存储引擎的表。
	- 可以使用多核 CPU
* where子句
    - 尽量避免使用负向查询NOT、!=、<>、!<、!>、NOT IN、NOT LIKE等，否则将引擎放弃使用索引而进行全表扫描。
    - 尽量避免使用 or 来连接条件，如果一个字段有索引，一个字段没有索引，将导致引擎放弃使用索引而进行全表扫描。含有or的查询子句，如果要利用索引，则or之间的每个条件列都必须使用索引；如果没有索引，可以考虑增加索引。
    - 区分in和exists， not in和not exists，造成了驱动顺序的改变
        + exists，那么以外层表为驱动表，先被访问，如果是IN，那么先执行子查询。所以IN适合于外表大而内表小的情况；EXISTS适合于外表小而内表大的情况。
        + 关于not in和not exists，推荐使用not exists，不仅仅是效率问题，not in可能存在逻辑问题。如何高效的写出一个替代not exists的sql语句？
    - 对于 IN 做了相应的优化，即将 IN 中的常量全部存储在一个数组里面，而且这个数组是排好序的。对于连续的数值，能用 between 就不要用 in 了
    - 在 where 子句中使用参数，也会导致全表扫描 select id from t where num = @num
    - 在查询中存在常量相等where条件字段（索引中的字段），且该字段在group by指定的字段的前面或者中间。来自于相等条件的常量能够填充搜索keys中的gaps，因而可以构成一个索引的完整前缀。索引前缀能够用于索引查找。如果要求对group by的结果进行排序，并且查找字段组成一个索引前缀，那么MySQL同样可以避免额外的排序操作。 c2在c1,c3之前，c2='a'填充这个坑，组成一个索引前缀，因而能够使用紧凑索引扫描。 select c1,c2,c3 from t1 where c2 = 'a' group by c1,c3 c1在索引的最前面，c1=a和group by c2,c3组成一个索引前缀，因而能够使用紧凑索引扫描。 select c1,c2,c3 from t1 where c1 = 'a' group by c2,c3 使用紧凑索引扫描，执行计划Extra一般显示"using index"，相当于使用了覆盖索引。
    - 通过索引 MySQL建立的索引（B+Tree）通常是有序的，如果通过读取索引就完成group by操作，那么就可避免创建临时表和排序。因而使用索引进行group by的最重要的前提条件是所有group by的参照列（分组依据的列）来自于同一个索引，且索引按照顺序存储所有的keys（即BTREE index，而HASH index没有顺序的概念）。松散索引扫描和紧凑索引扫描的最大区别是是否需要扫描整个索引或者整个范围扫描。
    + 正常流程 group by操作在没有合适的索引可用的时候，通常先扫描整个表提取数据并创建一个临时表，然后按照group by指定的列进行排序。在这个临时表里面，对于每一个group的数据行来说是连续在一起的。完成排序之后，就可以发现所有的groups，并可以执行聚集函数（aggregate function）。可以看到，在没有使用索引的时候，需要创建临时表和排序。在执行计划中通常可以看到"Using temporary; Using filesort"。
    - order by：尽量通过索引直接返回有序数据，减少额外的排序。MySQL中有两种排序方式：
        + 在 where 及 order by 涉及的列上建立索引
        + 通过有序索引顺序扫描直接返回有效数据，不需要额外的排序，操作效率较高
        + filesort排序：对返回的数据进行排序，不是通过索引直接返回排序结果，有两种排序算法
            * 一次扫描算法（较快）
            * 两次扫描算法
            * 适当加大系统变量`max_length_for_sort_data`的值，能够让MySQL选择更优化的filesort排序算法；适当加大`sort_buffer_size`排序区，尽量让排序在内存中完成，而不是通过创建临时表放在文件中进行。
	- 优化 group by 语句
		+ 默认情况下，MySQL 会对 GROUP BY 分组的所有值进行排序。如果显式包括一个包含相同的列的 ORDER BY 子句，MySQL 可以毫不减速地对它进行优化，尽管仍然进行排序
		+ 如果查询包括 GROUP BY 但并不想对分组的值进行排序，可以指定 ORDER BY NULL 禁止排序 `SELECT col1, col2, COUNT(*) FROM table GROUP BY col1, col2 ORDER BY NULL ;`
* ORM（Object Relational Mapper）
    - 最重要的是“Lazy Loading”：只有在需要的去取值的时候才会去真正的去做
    - 需要小心处理他们，否则可能最终创建了许多微型查询，这会降低数据库性能
    - 可以将多个查询批处理到事务中，其操作速度比向数据库发送单个查询快得多
* 排序
    - 如果排序字段没有用到索引，就尽量少排序
    - 如果限制条件中其他字段没有索引，尽量少用 or，有一个不是索引字段，会造成该查询不走索引的情况。 使用 union all 或者是 union(必要的时候)的方式来代替“or”会得到更好的效果
    - 不使用ORDER BY RAND()
* 拒绝3B(big)：大sql，大事务，大批量
* 子查询：尽量使用JOIN来代替子查询.因为子查询需要嵌套查询,嵌套查询时会建立一张临时表,临时表的建立和删除都会有较大的系统开销,而连接查询不会创建临时表,因此效率比嵌套子查询高
	- 可以一次性的完成很多逻辑上需要多个步骤才能完成的 SQL 操作，同时也可以避免事务或者表锁死，并且写起来也很容易
	- 连接（JOIN）..之所以更有效率一些，是因为 MySQL 不需要在内存中创建临时表来完成这个逻辑上的需要两个步骤的查询工作
    - union 和 union all 的差异：前者需要将结果集合并后再进行唯一性过滤操作，这就会涉及到排序，增加大量的 CPU 运算，加大资源消耗及延迟。
    - 禁止大表使用JOIN查询、子查询
    - 尽量使用inner join，避免left join
    - 删除JOIN和WHERE子句中的计算字段
* 查询松散索引扫描（Loose Index Scan）与紧凑索引扫描（Tight Index Scan）
    + 松散索引扫描方式:分组操作和范围预测（如果有的话）一起执行完成的。不需要连续的扫描索引中得每一个元组，扫描时仅考虑索引中得一部分。当查询中没有where条件的时候，松散索引扫描读取的索引元组的个数和groups的数量相同。如果where条件包含范围预测，松散索引扫描查找每个group中第一个满足范围条件，然后再读取最少可能数的keys。松散索引扫描只需要读取很少量的数据就可以完成group by操作，因而执行效率非常高，执行计划中Etra中提示" using index for group-by"。松散索引扫描可以作用于在select list中其它形式的聚集函数，除了min()和max()之外，还支持：
        + AVG(DISTINCT), SUM(DISTINCT)和COUNT(DISTINCT)可以使用松散索引扫描。AVG(DISTINCT), SUM(DISTINCT)只能使用单一列作为参数。而COUNT(DISTINCT)可以使用多列参数。
        + 在查询中没有group by和distinct条件
        + 之前声明的松散扫描限制条件同样起作用
    - 符合一下条件
        + 查询在单一表上
        + group by指定的所有列是索引的一个最左前缀，并且没有其它的列。比如表t1（ c1,c2,c3,c4）上建立了索引（c1,c2,c3）。如果查询包含"group by c1,c2"，那么可以使用松散索引扫描。但是"group by c2,c3"(不是索引最左前缀)和"group by c1,c2,c4"(c4字段不在索引中)
        + 如果在选择列表select list中存在聚集函数，只能使用 min()和max()两个聚集函数，并且指定的是同一列（如果min()和max()同时存在）。这一列必须在索引中，且紧跟着group by指定的列。比如，select t1,t2,min(t3),max(t3) from t1 group by c1,c2
        + 如果查询中存在除了group by指定的列之外的索引其他部分，那么必须以常量的形式出现（除了min()和max()两个聚集函数）。比如，select c1,c3 from t1 group by c1,c2不能使用松散索引扫描。而select c1,c3 from t1 where c3 = 3 group by c1,c2可以使用松散索引扫描
        + 索引中的列必须索引整个数据列的值(full column values must be indexed)，而不是一个前缀索引。比如，c1 varchar(20), INDEX (c1(10)),这个索引没发用作松散索引扫描
        + 紧凑索引扫描方式下，先对索引执行范围扫描（range scan），再对结果元组进行分组。可能是全索引扫描或者范围索引扫描，取决于查询条件。当松散索引扫描条件没有满足的时候，group by仍然有可能避免创建临时表。如果在where条件有范围扫描，那么紧凑索引扫描仅读取满足这些条件的keys（索引元组），否则执行全索引扫描。这种方式读取所有where条件定义的范围内的keys，或者扫描整个索引。紧凑索引扫描，只有在所有满足范围条件的keys被找到之后才会执行分组操作

```sql
SELECT A.xx , B.yy FROM A INNER JOIN B USING (c) WHERE A.xx IN (5 , 6)

SELECT film_id , description FROM film ORDER BY title LIMIT 50, 5;
# 如果这张表非常大，那么这个查询最好改成下面的样子：
SELECT film.film_id , film.description
FROM film INNER JOIN (
    SELECT film_id FROM film ORDER BY title LIMIT 50 , 5
) AS tmp USING (film_id);

# 分页
SELECT * FROM your_table WHERE id <=
(SELECT id FROM your_table ORDER BY id desc LIMIT ($page-1)*$pagesize ORDER BY id desc
LIMIT $pagesize

SELECT * FROM your_table AS t1
JOIN (SELECT id FROM your_table ORDER BY id desc LIMIT ($page-1)*$pagesize AS t2
WHERE t1.id <= t2.id ORDER BY t1.id desc LIMIT $pagesize;

# 取出的结果集如下图表示，A 表不在 B 表中的数据
select colname from A Left join B on where a.id = b.id where b.id is null
```

## 增删改 DML 语句优化

* 大批量插入数据
    - 整体时间的分配是这样的：
        + 多链接耗时 （30%）
        + 多发送query到服务器 （20%）
        + 多解析query （20%）
        + 多插入操作 （10% * 词条数目）
        + 多插入index （10% * Index的数目）
        + 多关闭链接 （10%）
    - 多值 INSERT 语句 `Insert into T values(1,2),(1,3),(1,4);`
        + 减少 SQL 语句解析的操作，MySQL 没有类似 Oracle 的 share pool，采用方法二，只需要解析一次就能进行数据的插入操作
        + 在特定场景可以减少对 DB 连接次数
        + SQL 语句较短，可以减少网络传输的 IO
    - 多线程插入(单表)
    - 多线程插入(多表)
    - 预处理SQL:使用PreparedStatement接口执行SQL
    - 事务(N条提交一次)
* 适当使用 commit,释放事务占用的资源而减少消耗，commit 后能释放的资源如下：
	- 事务占用的 undo 数据块。
	- 事务在 redo log 中记录的数据块。
	- 释放事务施加的，减少锁争用影响性能。特别是在需要使用 delete 删除大量数据的时候，必须分解删除量并定期 commit
* 避免重复查询更新的数据 `Update t1 set time=now() where col1=1 and @now: = now (); Select @now; `
* 查询优先还是更新（insert、update、delete）优先
	- MySQL 还允许改变语句调度的优先级，它可以使来自多个客户端的查询更好地协作，这样单个客户端就不会由于锁定而等待很长时间。改变优先级还可以确保特定类型的查询被处理得更快。
	- 首先应该确定应用的类型，判断应用是以查询为主还是以更新为主的，是确保查询效率还是确保更新的效率，决定是查询优先还是更新优先
	- 默认调度策略：
		+ 写入操作优先于读取操作
		+ 对某张数据表的写入操作某一时刻只能发生一次，写入请求按照它们到达的次序来处理
		+ 对某张数据表的多个读取操作可以同时地进行
	- 修改它的调度策略：
		+ LOW_PRIORITY 关键字应用于 DELETE、INSERT、LOAD DATA、REPLACE 和 UPDATE。
		+ HIGH_PRIORITY 关键字应用于 SELECT 和 INSERT 语句。
		+ DELAYED 关键字应用于 INSERT 和 REPLACE 语句

## 存储优化

* 将 session 数据存储在 memcache 中，而不是 MySQL 中 — memcache 可以设置自动过期，防止MySQL对临时数据高成本的读写操作

## 高并发或大数据

* 读写分离
    - 主从复制或主主复制
* 分库分表
    - mysql自带分区表：对应用是透明的，无需更改代码,但是sql语句是需要针对分区表做优化的，sql条件中要带上分区条件的列，从而使查询定位到少量的分区上，否则就会扫描全部分区
    - 垂直拆分：根据模块的耦合度，将一个大的系统分为多个小的系统，也就是分布式系统
    - 水平切分：针对数据量大的表
        + 最麻烦而且最能考验技术水平，要选择一个合理的sharding key,为了有好的查询效率，表结构也要改动，做一定的冗余，应用也要改，sql中尽量带sharding key，将数据定位到限定的表上去查，而不是扫描全部的表
* 缓存集群：数据库其实本身不是用来承载高并发请求的，高并发架构里通常都有缓存这个环节，缓存系统的设计就是为了承载高并发而生
    - 在写数据库的时候同时写一份数据到缓存集群里，然后用缓存集群来承载大部分的读请求

### 优化策略

* 索引搜索字段：索引不仅仅是为了主键或唯一键。如果会在表中按照任何列搜索，就都应该索引它们
* Join表的时候使用相当类型的例，并将其索引：包含许多连接查询, 你需要确保连接的字段在两张表上都建立了索引，使用同样类型，相同的字符类型
* 永远为每张表设置一个ID:每个以id列为PRIMARY KEY的数据表中，优先选择AUTO_INCREMENT或者INT. VARCHAR字段作为主键（检索）速度较慢.一个可能的例外是"关联表"，用于两个表之间的多对多类型的关联。例如，"posts_tags"表中包含两列：post_id，tag_id，用于保存表名为"post"和"tags"的两个表之间的关系。这些表可以具有包含两个id字段的PRIMARY键
* 相比VARCHAR优先使用ENUM:ENUM枚举类型是非常快速和紧凑的。在内部它们像TINYINT一样存储，但它们可以包含和显示字符串值。知道这些字段的取值是有限而且固定的，请使用ENUM而不是VARCHAR
* 通过PROCEDURE ANALYZE()获取建议：使用MySQL分析列结构和表中的实际数据，为你提供一些建议。它只有在数据表中有实际数据时才有用，因为这在分析决策时很重要
* 如果可以的话使用NOT NULL：问一下你自己在空字符串值和NULL值之间（对应INT字段：0 vs. NULL）是否有任何的不同.如果没有理由一起使用这两个。NULL列需要额外的空间，他们增加了你的比较语句的复杂度
* 预处理语句：预处理语句默认情况下会过滤绑定到它的变量，这对于避免SQL注入攻击极为有效。当然你也可以指定要过滤的变量。但这些方法更容易出现人为错误，也更容易被程序员遗忘
* 使用 UNSIGNED INT 存储IP地址：定长四个字段，还有查询优势（IP between ip1 and ip2）。在查询中可以使用 INET_ATON() 来把一个IP转换为整数，用 INET_NTOA() 来进行相反的操作。在 PHP 也有类似的函数，ip2long() 和 long2ip()。 `$r = "UPDATE users SET ip = INET_ATON('{$_SERVER['REMOTE_ADDR']}') WHERE user_id = $user_id`
* 固定长度（静态）的表会更快：所有列都是"固定长度"，那么这个表被认为是"静态"或"固定长度"的。不固定的列类型包括 VARCHAR、TEXT、BLOB等。即使表中只包含一个这些类型的列，这个表就不再是固定长度的，MySQL 引擎会以不同的方式来处理它。固定长度的表会提高性能，因为 MySQL 引擎在记录中检索的时候速度会更快。它们也易于缓存，崩溃后容易重建。不过它们也会占用更多空间
* 垂直分区是为了优化表结构而对其进行纵向拆分的行为。将低频信息放到另一个表中，这样你的主用户表就会更小。如你所知，表越小越快。例子：last_login" 字段，用户每次登录网站都会更新这个字段，而每次更新都会导致这个表缓存的查询数据被清空。这种情况下你可以将那个字段放到另一张表里，保持用户表更新量最小
* 拆分大型DELETE或INSERT语句：执行大型DELETE或INSERT查询，则需要注意不要影响网络流量。当执行大型语句时，它会锁表并使你的Web应用程序停止。Apache运行许多并行进程/线程。 因此它执行脚本效率很高。所以服务器不期望打开过多的连接和进程，这很消耗资源，特别是内存。如果你锁表很长时间（如30秒或更长），在一个高流量的网站，会导致进程和查询堆积，处理这些进程和查询可能需要很长时间，最终甚至使你的网站崩溃。维护脚本需要删除大量的行，只需使用LIMIT子句，以避免阻塞。`while (1) { mysql_query("DELETE FROM logs WHERE log_date`
* 越少的列越快:对于数据库引擎，磁盘可能是最重要的瓶颈。更小更紧凑的数据、减少磁盘传输量，通常有助于性能提高。如果已知表具有很少的行，则没有理由是主键类型为INT，可以用MEDIUMINT、SMALLINT代替，甚至在某些情况下使用TINYINT。 如果不需要完整时间记录，请使用DATE而不是DATETIME
* 选择正确存储引擎
    * MyISAM适用于读取繁重的应用程序，但是当有很多写入时它不能很好地扩展。即使正在更新一行的一个字段，整个表也被锁定，并且在语句执行完成之前，其他进程甚至无法读取该字段。 MyISAM在计算SELECT COUNT（*）的查询时非常快
    * InnoDB是一个更复杂的存储引擎，对于大多数小的应用程序，它比MyISAM慢。但它支持基于行的锁定，使其更好地扩展。还支持一些更高级的功能，比如事务
+ 使用一个对象关系映射器（Object Relational Mapper）
    - 使用 ORM (Object Relational Mapper)，你能够获得可靠的性能增涨。一个ORM可以做的所有事情，也能被手动的编写出来。但是，这需要一个高级专家。ORM 的最重要的是“Lazy Loading”，也就是说，只有在需要的去取值的时候才会去真正的去做。但你也需要小心这种机制的副作用，因为这很有可能会因为要去创建很多很多小的查询反而会降低性能。ORM 还可以把你的SQL语句打包成一个事务，这会比单独执行他们快得多得多。
    - Doctrine

```php
// query cache does NOT work 因为功能返回的结果是可变的。MySQL决定禁用查询器的查询缓存
$r = mysql_query("SELECT username FROM user WHERE signup_date >= CURDATE()");
// query cache works!
$today = date("Y-m-d");
$r = mysql_query("SELECT username FROM user WHERE signup_date >= '$today'");

$r = mysql_query("SELECT count(*) FROM user");
$d = mysql_fetch_row($r);
$rand = mt_rand(0,$d[0] - 1);
$r = mysql_query("SELECT username FROM user LIMIT $rand, 1");

if ($stmt = $mysqli->prepare("SELECT username FROM user WHERE state=?")) {
    $stmt->bind_param("s", $state);
    $stmt->execute();
    $stmt->bind_result($username);
    $stmt->fetch();
    printf("%s is from %sn", $username, $state);
    $stmt->close();
}
```

## 批量操作

* 合并数据:合并后日志量（MySQL的binlog和innodb的事务让日志）减少了，降低日志刷盘的数据量和频率，同时也能减少SQL语句解析的次数，减少网络传输的IO
    - bulk_insert_buffer_size=120M 或者更大
    - 在同一SQL中务必不能超过SQL长度限制，通过max_allowed_packet配置可以修改，默认是1M，测试时修改为8M
* 事物
    - 有innodb_log_buffer_size配置项，超过这个值会把innodb的数据刷到磁盘中，这时，效率会有所下降
* 对于Innodb类型:数据有序插入,导入的数据按照主键的顺序排列
* MyISAM:禁用索引
* Load Data:将假设各数据列的值以制表符（t）分隔，各数据行以换行符（n）分隔，数据值的排列顺序与各数据列在数据表里的先后顺序一致
* 数据量较大时（1千万以上），性能会急剧下降，此时数据量超过了innodb_buffer的容量，每次定位索引涉及较多的磁盘读写操作，性能下降较快
* 预处理
* replace into 操作本质是对重复的记录先delete 后insert，如果更新的字段不全会将缺失的字段置为缺省值，用这个要悠着点！否则不小心清空大量数据可不是闹着玩的
* insert into 则是只update重复记录，不会改变其它字段
* 拆分大的 DELETE 或 INSERT 语句

```sql
INSERT INTO TBL_TEST (id) VALUES (1), (2), (3)

## Myisam类型:关闭MyISAM表非唯一索引的更新
ALTER TABLE tblname DISABLE KEYS;
loading the data
ALTER TABLE tblname ENABLE KEYS;

UPDATE categories
  SET display_order = CASE id
    WHEN 1 THEN 3
    WHEN 2 THEN 4
    WHEN 3 THEN 5
  END,
  title = CASE id
    WHEN 1 THEN 'New Title 1'
    WHEN 2 THEN 'New Title 2'
    WHEN 3 THEN 'New Title 3'
  END
WHERE id IN (1,2,3)

replace into test_tbl (id,dr) values (1,'2'),(2,'3'),...(x,'y');
insert into test_tbl (id,dr) values (1,'2'),(2,'3'),...(x,'y') on duplicate key update dr=values(dr);

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

## 维护优化

* 定期分析和检查表
* 定期优化表
* 经常做重写 InnoDB 表的优化

```sql
analyze table tbl_name;
check table tbl_name;

optimize table tbl_name;
```

## 应用优化

* 缓存：memcached,redis 缓存之所以有效，主要是因为程序运行时对内存或者外存的访问呈现局部性特征，局部性特征为空间局部性和时间局部性两方面
    - 时间局部性是指刚刚访问过的数据近期可能再次被访问
    - 空间局部性是指，某个位置被访问后，其相邻的位置的数据很可能被访问到
    - 而MySQL的缓存机制就是把刚刚访问的数据（时间局部性）以及未来即将访问到的数据（空间局部性）保存到缓存中，甚至是高速缓存中。从而提高I/O效率。
    - buffer缓存:由于硬盘的写入速度过慢，或者频繁的I/O，对于硬盘来说是极大的效率浪费。那么可以等到缓存中储存一定量的数据之后，一次性的写入到硬盘中。Buffer 缓存主要用于写数据，提升I/O性能。
    - Cache 缓存:Cache 缓存一般是一些访问频繁但是变更较少的数据，如果Cache缓存已经存储满，则启用LRU算法，进行数据淘汰。淘汰掉最远未使用的数据，从而开辟新的存储空间。不过对于特大型的网站，依靠这种策略很难缓解高频率的读请求，一般会把访问非常频繁的数据静态化，直接由nginx返还给用户。程序和数据库I/O设备交互的越少，则效率越高。
* 使用连接池
    - [数据库链接池终于搞对了，从100ms优化到3ms](https://mp.weixin.qq.com/s/HvfQFMZ4GmVMzmvC24XeEA)
    - 连接池中的连接数量应该等于你的数据库能够有效同时进行的查询任务数（通常不会高于 2*CPU 核心数）
* 减少对MySQL的访问
    - 理清应用逻辑，能一次取出的数据不用两次
    - 使用查询缓存MySQL的查询缓存（MySQL query cache）是4.1版本之后新增的功能，作用是存储select的查询文本和相应结果
        + 如果随后收到一个相同的查询，服务器会从查询缓存中重新得到查询结果，而不再需要解析和执行查询
        + 查询缓存适用于更新不频繁的表，当表更改（包括表结构和数据）后，查询缓存会被清空
    - 在应用端增加cache层
    - 负载均衡

## PHP 优化

* 无缓冲的查询：`mysql_unbuffered_query() `发送一个SQL语句到MySQL而并不像mysql_query()一样去自动fethch和缓存结果。这会相当节约很多可观的内存，尤其是那些会产生大量结果的查询语句，并且，不需要等到所有的结果都返回，只需要第一行数据返回的时候，就可以开始马上开始工作于查询结果了。然而，这会有一些限制。因为要么把所有行都读走，或是要在进行下一次的查询前调用 mysql_free_result() 清除结果。而且， mysql_num_rows() 或 mysql_data_seek() 将无法使用。所以，是否使用无缓冲的查询你需要仔细考虑。
* “永久链接”的目的是用来减少重新创建MySQL链接的次数。当一个链接被创建了，它会永远处在连接的状态，就算是数据库操作已经结束了。而且，自从我们的Apache开始重用它的子进程后——也就是说，下一次的HTTP请求会重用Apache的子进程，并重用相同的 MySQL 链接。 mysql_pconnect()
    - 这个功能制造出来的麻烦事更多。因为，你只有有限的链接数，内存问题，文件句柄数，等等。
    - Apache 运行在极端并行的环境中，会创建很多很多的了进程。这就是为什么这种“永久链接”的机制工作地不好的原因。在你决定要使用“永久链接”之前，你需要好好地考虑一下你的整个系统的架构。

## 基准测试

* 对数据库的性能指标进行定量的、可复现的、可对比的测试
* 作用:由于数据一致性的要求，无法通过增加机器来分散向数据库写数据带来的压力；可以通过前置缓存（Redis 等）、读写分离、分库分表来减轻压力，但是与系统其它组件的水平扩展相比，受到了太多的限制.分析在当前配置下（包括硬件配置、OS、数据库设置等），数据库的性能表现，从而找出 MySQL 的性能阈值，并根据实际系统的要求调整配置
* 指标
	- TPS/QPS：衡量吞吐量
	- 响应时间：包括平均响应时间、最小响应时间、最大响应时间、时间百分比等，其中时间百分比参考意义较大，如前 95% 的请求的最大响应时间。
	- 并发量：同时处理查询请求的数量
* 分类
	- 对整个系统基准测试：通过 http 请求进行测试，如通过浏览器、APP 或 postman 等测试工具
        + 优点是能够更好的针对整个系统，测试结果更加准确
        + 缺点是设计复杂实现困难
	- 针对 MySQL 基准测试:与针对整个系统的测试恰好相反

## [sysbench](https://github.com/akopytov/sysbench)

* 跨平台的基准测试工具，支持多线程，支持多种数据库；主要包括以下几种测试：
	- cpu 性能
	- 磁盘 io 性能
	- 调度程序性能
	- 内存分配及传输速度
	- POSIX 线程性能
	- 数据库性能 (OLTP 基准测试)
* 语法 `sysbench [options]... [testname] [command]`
	- testname 指定了要进行的测试，在老版本的 sysbench 中，可以通过 --test 参数指定测试的脚本；而在新版本中，--test 参数已经声明为废弃直接指定脚本
	-  command 是 sysbench 要执行的命令
		+  prepare 是为测试提前准备数据
		+  run 是执行正式的测试
		+  cleanup 是在测试完成后对数据库进行清理
	- options
		+ -mysql-host：MySQL 服务器主机名，默认 localhost；如果在本机上使用 localhost 报错，提示无法连接 MySQL 服务器，改成本机的 IP 地址应该就可以了。
		+ --mysql-port：MySQL 服务器端口，默认 3306
		+ --mysql-user：用户名
		+ --mysql-password：密码
		+ --oltp-test-mode：执行模式，包括 simple、nontrx 和 complex，默认是 complex。simple 模式下只测试简单的查询；nontrx 不仅测试查询，还测试插入更新等，但是不使用事务；complex 模式下测试最全面，会测试增删改查，而且会使用事务。可以根据自己的需要选择测试模式。
		+ --oltp-tables-count：测试的表数量，根据实际情况选择
		+ --oltp-table-size：测试的表的大小，根据实际情况选择
		+ --threads：客户端的并发连接数
		+ --time：测试执行的时间，单位是秒，该值不要太短，可以选择 120
		+ --report-interval：生成报告的时间间隔，单位是秒，如 10
* 注意
	- 尽量不要在 MySQL 服务器运行的机器上进行测试，一方面可能无法体现网络（哪怕是局域网）的影响，另一方面，sysbench 的运行（尤其是设置的并发数较高时）会影响 MySQL 服务器的表现。
	- 可以逐步增加客户端的并发连接数（--thread 参数），观察在连接数不同情况下，MySQL 服务器的表现；如分别设置为 10,20,50,100 等。
	- 一般执行模式选择 complex 即可，如果需要特别测试服务器只读性能，或不使用事务时的性能，可以选择 simple 模式或 nontrx 模式。
	- 如果连续进行多次测试，注意确保之前测试的数据已经被清理干净
	- 在开始测试之前，应该首先明确：应采用针对整个系统的基准测试，还是针对 MySQL 的基准测试，还是二者都需要。
	- 如果需要针对 MySQL 的基准测试，那么还需要明确精度方面的要求：是否需要使用生产环境的真实数据，还是使用工具生成也可以；前者实施起来更加繁琐。如果要使用真实数据，尽量使用全部数据，而不是部分数据。
	- 基准测试要进行多次才有意义。
	- 测试时需要注意主从同步的状态。
	- 测试必须模拟多线程的情况，单线程情况不但无法模拟真实的效率，也无法模拟阻塞甚至死锁情况。
* 结果
	- queries：查询总数
	- qps transactions：事务总数
	- tps Latency-95th percentile：前 95% 的请求的最大响应时间

```sh
wget https://github.com/akopytov/sysbench/archive/1.0.20.zip -O "sysbench-1.0.20.zip"
unzip sysbench-1.0.20.zip
cd sysbench-1.0.20
apt install automake libtool –y

./autogen.sh
./configure
export LD_LIBRARY_PATH=/usr/include/mysql # mysql_config --include
make
make install
sysbench --version

sysbench ./tests/include/oltp_legacy/oltp.lua --mysql-host=192.168.10.10 --mysql-port=3306 --mysql-user=root --mysql-password=123456 --oltp-test-mode=complex --oltp-tables-count=10 --oltp-table-size=100000 --threads=10 --time=120 --report-interval=10 prepare
sysbench ./tests/include/oltp_legacy/oltp.lua --mysql-host=192.168.10.10 --mysql-port=3306 --mysql-user=root --mysql-password=123456 --oltp-test-mode=complex --oltp-tables-count=10 --oltp-table-size=100000 --threads=10 --time=120 --report-interval=10 run >> /home/test/mysysbench.log
sysbench ./tests/include/oltp_legacy/oltp.lua --mysql-host=192.168.10.10 --mysql-port=3306 --mysql-user=root --mysql-password=123456 cleanup
```
## [Percona Toolkit](https://www.percona.com/doc/percona-toolkit)

* 检查master和slave数据的一致性
* 有效地对记录进行归档
* 查找重复的索引
* 对服务器信息进行汇总
* 分析来自日志和tcpdump的查询
* 当系统出问题的时候收集重要的系统信息
* 工具列表
	- pt-align
	- pt-archiver
	- pt-config-diff
	- pt-deadlock-logger
	- pt-diskstats
	- pt-duplicate-key-checker
	- pt-fifo-split
	- pt-find
	- pt-fingerprint
	- pt-fk-error-logger
	- pt-heartbeat
	- pt-index-usage
	- pt-align
	- pt-archiver
	- pt-config-diff
	- pt-deadlock-logger
	- pt-diskstats
	- pt-duplicate-key-checker
	- pt-fifo-split
	- pt-find
	- pt-fingerprint
	- pt-fk-error-logger
	- pt-heartbeat
	- pt-index-usage
	- pt-ioprofile
	- pt-kill
	- pt-mext
	- pt-mongodb-query-digest
	- pt-mongodb-summary
	- pt-mysql-summary
	- pt-online-schema-change
	- pt-pmp
	- pt-query-digest 分析慢日志
	- pt-secure-collect
	- pt-show-grants
	- pt-sift
	- pt-slave-delay
	- pt-slave-find
	- pt-slave-restart
	- pt-stalk
	- pt-summary
	- pt-table-checksum
	- pt-table-sync
	- pt-table-usage
	- pt-upgrade
	- pt-variable-advisor
	- pt-visual-explain
	- pt-slave-find
	- pt-slave-restart
	- pt-stalk
	- pt-summary
	- pt-table-checksum
	- pt-table-sync
	- pt-table-usage
	- pt-upgrade
	- pt-variable-advisor
	- pt-visual-explain
	- tpcc-mysql

```sh
sudo apt install percona-toolkit

pt-mysql-summary --host localhost --user root --ask-pass

wget https://www.percona.com/downloads/percona-toolkit/2.2.20/deb/percona-toolkit_2.2.20-1.tar.gz
tar zxvf percona-toolkit_2.2.20-1.tar.gz
# 安装
perl Makefile.PL
make && make install

./pt-query-digest  slow.log
```

## Percona Monitoring and Management PMM

```sh
docker pull percona/pmm-server:lates
mkdir -p /opt/prometheus/data
mkdir -p /opt/consul-data
mkdir -p /var/lib/mysql
mkdir -p /var/lib/grafana
docker create -v /opt/prometheus/data -v /opt/consul-data -v /var/lib/mysql -v /var/lib/grafana --name pmm-data percona/pmm-server:1.2.0 /bin/true
docker run -d -p 8881:80 --volumes-from pmm-data --name pmm-server --restart always percona/pmm-server:1.2.0

yum install https://www.percona.com/redir/downloads/percona-release/redhat/percona-release-0.1-4.noarch.rpm
yum install pmm-client -y
pmm-admin config --server 47.92.131.xxx:80
vim /usr/local/percona/pmm-client/pmm.yml 修改hostnane
pmm-admin check-network 检查域服务端的链接
pmm-admin config --server 47.92.131.xxx:80
```

## Perfermace Schema

* 单表数据量尽量控制在千万级别
* 关系型数据库在TPS上的瓶颈往往会比其他瓶颈更容易暴露出来,常用的MySQL数据库为例，常规情况下的TPS大概只有1500左右

## [MySQL 8.0 PFS histogram解析与优化](https://mp.weixin.qq.com/s/Bjv4rrSvDRQNEbjKgZdOjA)

## 参考

* [MySQL 设计总结](https://mp.weixin.qq.com/s?__biz=MzAwNzY4OTgyNA==&mid=2651827083&idx=1&sn=3f8b2a861f2d8df005e541600b276a20&chksm=80814884b7f6c192e1a3c6151b16129f936b3453eb7a6da3aee15815a763cf595cf0ccf9ff21)
* [MySQL优化原理](https://mp.weixin.qq.com/s?__biz=MzAwNzA5MzA0NQ==&mid=2652151595&idx=1&sn=cd9c3764ba981b8d06e9b79022442574&chksm=80e35171b794d86754de840c510562888d45961c131ff034b5ae37dde14851226d4e0cda3329)
