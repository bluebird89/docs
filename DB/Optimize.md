# MySQL optimize

不同的语句，根据你选择的引擎、表中数据的分布情况、索引情况、数据库优化策略、查询中的锁策略等因素，最终查询的效率相差很大。除了纯技术面优化，还要根据业务面去优化sql语句

## 指标

MySQL  客户端和服务端通信协议是“半双工”的，这就意味着，客户端发送给服务器和服务器发给客户端是不能同时发生，这种协议让MySQL通信简单快速，但也就无法进行流量控制，一旦一端开始了，另一端是能等它结束。所以查询语句很长的时候，参数max_allowed_packet就特别重要了。

* 响应时间包括服务时间和等待时间，但这两个时间并不能细分出来，所以响应时间受影响比较大。我们可以通过估计查询的响应时间来做最初步的判断。
* 扫描的行数
* 返回的行数

## 低效原因

* 检索大量不需要的数据。
    - 查询不需要的记录：一个常见的错误是误以为MySQL会只返回需要的数据，实际上MySQL是先返回全部结果集再进行运算。 加limit，需要字段
    - 返回多余的列：取出全部列，会让优化器无法完成索引覆盖扫描这类优化，而且给服务器带来额外的I/O，内存，CPU的消耗。
    - 重复数据：如用户头像需多次取出，此时应将数据缓存起来
* MySQL服务层在分析大量超过需要的数据行

### 瓶颈

* CPU在饱和的时候一般发生在数据装入内存或从磁盘上读取数据时候。
* 磁盘I/O瓶颈发生在装入数据远大于内存容量的时候
* 如果应用分布在网络上，那么查询量相当大的时候那么平瓶颈就会出现在网络上，我们可以用mpstat, iostat, sar和vmstat来查看系统的性能状态。

## 硬件优化

### CPU相关

服务器的BIOS设置中，可调整下面的几个配置，目的是发挥CPU最大性能，或者避免经典的NUMA问题：
* 选择Performance Per Watt Optimized(DAPC)模式，发挥CPU最大性能，跑DB这种通常需要高运算量的服务就不要考虑节电了；
* 关闭C1E和C States等选项，目的也是为了提升CPU效率；
* Memory Frequency（内存频率）选择Maximum Performance（最佳性能）；
* 内存设置菜单中，启用Node Interleaving，避免NUMA问题；

### 磁盘I/O相关

* 使用SSD或者PCIe SSD设备，至少获得数百倍甚至万倍的IOPS提升；
* 购置阵列卡同时配备CACHE及BBU模块，可明显提升IOPS（主要是指机械盘，SSD或PCIe SSD除外。同时需要定期检查CACHE及BBU模块的健康状况，确保意外时不至于丢失数据）；
* 有阵列卡时，设置阵列写策略为WB，甚至FORCE WB（若有双电保护，或对数据安全性要求不是特别高的话），严禁使用WT策略。并且闭阵列预读策略，基本上是鸡肋，用处不大；
* 尽可能选用RAID-10，而非RAID-5；
* 使用机械盘的话，尽可能选择高转速的，例如选用15KRPM，而不是7.2KRPM的盘，不差几个钱的；

* 有足够的物理内存，能将整个InnoDB文件加载到内存里 —— 如果访问的文件在内存里，而不是在磁盘上，InnoDB会快很多。
* 全力避免 Swap 操作 — 交换（swapping）是从磁盘读取数据，所以会很慢。
* 使用电池供电的RAM（Battery-Backed RAM）。
* 使用一个高级磁盘阵列 — 最好是 RAID10 或者更高。
* 避免使用RAID5 — 和校验需要确保完整性，开销很高。
* 将你的操作系统和数据分开，不仅仅是逻辑上要分开，物理上也要分开 — 操作系统的读写开销会影响数据库的性能。
* 将临时文件和复制日志与数据文件分开 — 后台的写操作影响数据库从磁盘文件的读写操作。
* 更多的磁盘空间等于更高的速度。
* 磁盘速度越快越好。
* SAS优于SATA。
* 小磁盘的速度比大磁盘的更快，尤其是在 RAID 中。
* 使用电池供电的缓存 RAID（Battery-Backed Cache RAID）控制器。
* 避免使用软磁盘阵列。
* 考虑使用固态IO卡（不是磁盘）来作为数据分区 — 几乎对所有量级数据，这种卡能够支持 2 GBps 的写操作。
* 在 Linux 系统上，设置 swappiness 的值为0 — 没有理由在数据库服务器上缓存文件，这种方式在Web服务器或桌面应用中用的更多。
* 尽可能使用 noatime 和 nodirtime 来挂载文件系统 — 没有必要为每次访问来更新文件的修改时间。
* 使用 XFS 文件系统 — 一个比ext3更快的、更小的文件系统，拥有更多的日志选项，同时，MySQL在ext3上存在双缓冲区的问题。
* 优化你的 XFS 文件系统日志和缓冲区参数 – -为了获取最大的性能基准。
* 在Linux系统中，使用 NOOP 或 DEADLINE IO 调度器 — CFQ 和 ANTICIPATORY 调度器已经被证明比 NOOP 和 DEADLINE 慢。
* 使用 64 位操作系统 — 有更多的内存能用于寻址和 MySQL 使用。
* 将不用的包和后台程序从服务器上删除 — 减少资源占用。
* 将使用 MySQL 的 host 和 MySQL自身的 host 都配置在一个 host 文件中 — 这样没有 DNS 查找。
* 永远不要强制杀死一个MySQL进程 — 你将损坏数据库，并运行备份。
* 让你的服务器只服务于MySQL — 后台处理程序和其他服务会占用数据库的 CPU 时间。

## 系统层相关优化

[](../_static/mysql_query.png)

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


### MySQL 配置

* 使用 innodb_flush_method=O_DIRECT 来避免写的时候出现双缓冲区。
* 避免使用 O_DIRECT 和 EXT3 文件系统 — 这会把所有写入的东西序列化。
* 分配足够 innodb_buffer_pool_size ，来将整个InnoDB 文件加载到内存 — 减少从磁盘上读。
* 不要让 innodb_log_file_size 太大，这样能够更快，也有更多的磁盘空间 — 经常刷新有利降低发生故障时的恢复时间。
* 不要同时使用 innodb_thread_concurrency 和 thread_concurrency 变量 — 这两个值不能兼容。
* 为 max_connections 指定一个小的值 — 太多的连接将耗尽你的RAM，导致整个MySQL服务器被锁定。
* 保持 thread_cache 在一个相对较高的数值，大约是 16 — 防止打开连接时候速度下降。
* 使用 skip-name-resolve — 移除 DNS 查找。
* 如果你的查询重复率比较高，并且你的数据不是经常改变，请使用查询缓存 — 但是，在经常改变的数据上使用查询缓存会对性能有负面影响。
* 增加 temp_table_size — 防止磁盘写。
* 增加 max_heap_table_size — 防止磁盘写。
* 不要将 sort_buffer_size 的值设置的太高 — 可能导致连接很快耗尽所有内存。
* 监控 key_read_requests 和 key_reads，以便确定 key_buffer 的值 — key 的读需求应该比 key_reads 的值更高，否则使用 key_buffer 就没有效率了。
* 设置 innodb_flush_log_at_trx_commit = 0 可以提高性能，但是保持默认值（1）的话，能保证数据的完整性，也能保证复制不会滞后。
* 有一个测试环境，便于测试你的配置，可以经常重启，不会影响生产环境。

### Schema 优化

* 保证你的数据库的整洁性。
* 归档老数据 — 删除查询中检索或返回的多余的行
* 在数据上加上索引。
* 不要过度使用索引，评估你的查询。
* 压缩 text 和 blob 数据类型 — 为了节省空间，减少从磁盘读数据。
* UTF 8 和 UTF16 比 latin1 慢。
* 有节制的使用触发器。
* 保持数据最小量的冗余 — 不要复制没必要的数据.
* 使用链接表，而不是扩展行。
* 注意你的数据类型，尽可能的使用最小的。
* 如果其他数据需要经常需要查询，而 blob/text 不需要，则将 blob/text 数据域其他数据分离。
* 经常检查和优化表。
* 经常做重写 InnoDB 表的优化。
* 有时，增加列时，先删除索引，之后在加上索引会更快。
* 为不同的需求选择不同的存储引擎。
* 日志表或审计表使用ARCHIVE存储引擎 — 写的效率更高。
* 将 session 数据存储在 memcache 中，而不是 MySQL 中 — memcache 可以设置自动过期，防止MySQL对临时数据高成本的读写操作。
* 如果字符串的长度是可变的，则使用VARCHAR代替CHAR — 节约空间，因为CHAR是固定长度，而VARCHAR不是（utf8 不受这个影响）。
* 逐步对 schema 做修改 — 一个小的变化将产生的巨大的影响。
* 在开发环境测试所有 schema 变动，而不是在生产环境的镜像上去做。
* 不要随意改变你的配置文件，这可能产生非常大的影响。
* 有时候，少量的配置会更好。
* 质疑使用通用的MySQL配置文件。

### 查询优化

* 使用慢查询日志，找出执行慢的查询。
* 使用 EXPLAIN 来决定查询功能是否合适。
* 经常测试你的查询，看是否需要做性能优化 — 性能可能会随着时间的变化而变化。
* 避免在整个表上使用count(*) ，它可能会将整个表锁住。
* 保持查询一致，这样后续类似的查询就能使用查询缓存了。
* 如果合适，用 GROUP BY 代替 DISTINCT。
* 在 WHERE、GROUP BY 和 ORDER BY 的列上加上索引。
* 保证索引简单，不要在同一列上加多个索引。
* 有时，MySQL 会选择错误的索引，这种情况使用 USE INDEX。
* 使用 SQL_MODE=STRICT 来检查问题。
* 索引字段少于5个时，UNION 操作用 LIMIT，而不是 OR。
* 使用 INSERT ON DUPLICATE KEY 或 INSERT IGNORE 来代替 UPDATE，避免 UPDATE 前需要先 SELECT。
* 使用索引字段和 ORDER BY 来代替 MAX。
* 避免使用 ORDER BY RAND()。
* LIMIT M,N 在特定场景下会降低查询效率，有节制使用。
* 使用 UNION 来代替 WHERE 子句中的子查询。
* 对 UPDATE 来说，使用 SHARE MODE 来防止排他锁。
* 重启 MySQL 时，记得预热数据库，确保将数据加载到内存，提高查询效率。
* 使用 DROP TABLE ，然后再 CREATE TABLE ，而不是 DELETE FROM ，以删除表中所有数据。
* 最小化你要查询的数据，只获取你需要的数据，通常来说不要使用 *。
* 考虑持久连接，而不是多次建立连接，已减少资源的消耗。
* 基准查询，包括服务器的负载，有时一个简单的查询会影响其他的查询。
* 当服务器的负载增加时，使用SHOW PROCESSLIST来查看慢的/有问题的查询。
* 在存有生产环境数据副本的开发环境中，测试所有可疑的查询。

## 查询优化器流程

* MYSQL 收到一条查询请求时，会首先通过关键字对SQL语句进行解析，生成一颗“解析树”，
* 然后预处理器会校验“解析树”是否合法(主要校验数据列和表明是否存在，别名是否有歧义等)，
* 当“解析树”被认为合法后，查询优化器会对这颗“解析树”进行优化，并确定它认为最完美的执行计划。

## 步骤

* 索引优化：查询速度的提高是以插入、更新、删除的速度为代价的，这些写操作，增加了大量的I/O
    - 较频繁的作为查询条件字段应该创建索引`select * from order_copy where id = $id`
    - 唯一性太差的字段不适合单独创建索引，即使频繁作为查询条件`select * from order_copy where sex=’女’`
    - 更新非常频繁的字段不适合创建索引`select * from order_copy where order_state=’未付款’`
    - 不会出现在WHERE子句中字段不该创建索引
* 查询优化
* 存储优化
* 加缓存，memcached,redis；
* 做主从复制或主主复制，读写分离，可以在应用层做
* mysql自带分区表，先试试这个，对你的应用是透明的，无需更改代码,但是sql语句是需要针对分区表做优化的，sql条件中要带上分区条件的列，从而使查询定位到少量的分区上，否则就会扫描全部分区
* 垂直拆分，其实就是根据你模块的耦合度，将一个大的系统分为多个小的系统，也就是分布式系统
* 水平切分，针对数据量大的表，这一步最麻烦，最能考验技术水平，要选择一个合理的sharding key,为了有好的查询效率，表结构也要改动，做一定的冗余，应用也要改，sql中尽量带sharding key，将数据定位到限定的表上去查，而不是扫描全部的表；

### 表结构设置

* 硬盘操作可能是最重大的瓶颈。所以，把你的数据变得紧凑会对这种情况非常有帮助，因为这减少了对硬盘的访问。需要留够足够的扩展空间
* 使用ENUM、CHAR 而不是VARCHAR，使用合理的字段属性长度。ENUM 类型是非常快和紧凑的。在实际上，其保存的是 TINYINT，但其外表上显示为字符串。如果你有一个字段，比如“性别”，“国家”，“民族”，“状态”或“部门”，你知道这些字段的取值是有限而且固定的，那么，你应该使用 ENUM 而不是 VARCHAR。
* 固定长度的表会提高性能，因为MySQL搜寻得会更快一些，因为这些固定的长度是很容易计算下一个数据的偏移量的，所以读取的自然也会很快。固定长度的表也更容易被缓存和重建。不过，唯一的副作用是，固定长度的字段会浪费一些空间，因为定长的字段无论你用不用，他都是要分配那么多的空间。
* “垂直分割”是一种把数据库中的表按列变成几张表的方法，这样可以降低表的复杂度和字段的数目，从而达到优化的目的。
* 尽可能的使用NOT NULL
* 固定长度的表会更快
* 拆分大的DELETE 或INSERT 语句
* 查询的列越小越快

### 查询优化

对查询进行优化，要尽量避免全表扫描

* 在 where 及 order by 涉及的列上建立索引
* 应尽量避免在 where 子句中对字段进行 null 值判断，否则将导致引擎放弃使用索引而进行全表扫描.最好不要给数据库留NULL，尽可能的使用 NOT NULL填充数据库.
* 应尽量避免在 where 子句中使用 != 或 <> 操作符，否则将引擎放弃使用索引而进行全表扫描。
* 应尽量避免在 where 子句中使用 or 来连接条件，如果一个字段有索引，一个字段没有索引，将导致引擎放弃使用索引而进行全表扫描。含有or的查询子句，如果要利用索引，则or之间的每个条件列都必须使用索引；如果没有索引，可以考虑增加索引。
* in 和 not in 也要慎用，否则会导致全表扫描,对于连续的数值，能用 between 就不要用 in 了
* select id from t where name like '%abc%' 全表扫描
* 在 where 子句中使用参数，也会导致全表扫描 select id from t where num = @num
* 避免在 where 子句中对字段进行表达式操作或者函数操作
* 尽量避免向客户端返回大数据量，若数据量过大，应该考虑相应需求是否合理
* 当只要一行数据时使用 LIMIT 1，找到一条数据后停止搜索，而不是继续往后查少下一条符合记录的数据
* JOIN 查询，确认两个表中Join的字段是被建过索引的。这样，MySQL内部会启动为你优化Join的SQL语句的机制。
* 避免 SELECT *：读出越多的数据，那么查询就会变得越慢，需要什么就取什么。这样不带任何条件的count会引起全表扫描，并且没有任何业务意义，是一定要杜绝的。
* 主键：每张表都设置一个ID做为其主键。使用UNSIGNED，并设置上自动增加的AUTO_INCREMENT标志
* ORM 的最重要的是“Lazy Loading”，也就是说，只有在需要的去取值的时候才会去真正的去做。
* 索引并不是越多越好，索引固然可以提高相应的 select 的效率，但同时也降低了 insert 及 update 的效率，因为 insert 或 update 时有可能会重建索引
* 缓存优化：`$r = mysql_query("SELECT username FROM user WHERE signup_date >= CURDATE()");` CURDATE()、NOW() 和 RAND() 或是其它的诸如此类的SQL函数都不会开启查询缓存
* 子查询的效率不如连接查询（join），因为MySQL不需要在内存中创建临时表来完成这个在逻辑上需要两个步骤的查询工作。MySQL不需要在内存中创建临时表来完成这个逻辑上的需要两个步骤的查询工作。

#### order by

优化目标：尽量通过索引直接返回有序数据，减少额外的排序。MySQL中有两种排序方式：

* 通过有序索引顺序扫描直接返回有效数据，不需要额外的排序，操作效率较高；
* 对返回的数据进行排序，也就是常说的Filesort排序，所有不是通过索引直接返回排序结果的排序都是filesort排序。 

filesort有两种排序算法，一种是一次扫描算法（较快），二种是两次扫描算法。适当加大系统变量max_length_for_sort_data的值，能够让MySQL选择更优化的filesort排序算法；适当加大sort_buffer_size排序区，尽量让排序在内存中完成，而不是通过创建临时表放在文件中进行。

### 缓存机制

缓存之所以有效，主要是因为程序运行时对内存或者外存的访问呈现局部性特征，局部性特征为空间局部性和时间局部性两方面。

* 时间局部性是指刚刚访问过的数据近期可能再次被访问
* 空间局部性是指，某个位置被访问后，其相邻的位置的数据很可能被访问到
* 而MySQL的缓存机制就是把刚刚访问的数据（时间局部性）以及未来即将访问到的数据（空间局部性）保存到缓存中，甚至是高速缓存中。从而提高I/O效率。
* buffer缓存:由于硬盘的写入速度过慢，或者频繁的I/O，对于硬盘来说是极大的效率浪费。那么可以等到缓存中储存一定量的数据之后，一次性的写入到硬盘中。Buffer 缓存主要用于写数据，提升I/O性能。
* Cache 缓存:Cache 缓存一般是一些访问频繁但是变更较少的数据，如果Cache缓存已经存储满，则启用LRU算法，进行数据淘汰。淘汰掉最远未使用的数据，从而开辟新的存储空间。不过对于特大型的网站，依靠这种策略很难缓解高频率的读请求，一般会把访问非常频繁的数据静态化，直接由nginx返还给用户。程序和数据库I/O设备交互的越少，则效率越高。

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

## 查询优化器

### 衡量标准

查询优化器衡量某个执行计划是否完美的标准是“使用该执行计划时的成本”，该成本的最小单位是读取一个4K数据页的成本。

### 优化类型

* 对于多表关联的查询（INTER JOIN），优化器会根据数据的选择性来重新决定关联的顺序，选择性高的会被置前。如果关联设计到N张表，优化器会尝试N！种的关联顺序，从中选出一种最优的排列顺序
* 将外连接转化成内连接
* 覆盖索引扫描：索引中的列包含所有查询中需要的列的时候，只需要使用索引返回数据，不需要搜索数据行
* 对结果集进行排序，这时候会采取两种策略：
    - 如果结果集的容量小于“排序缓冲区”的容量，在内存中进行排序
    - 如果查询的结果大于“排序缓冲区”，则先将结果集拆分成多个“排序缓冲区”可以容纳的子集，然后把各个子集排序的结果存放在磁盘上，最后对各个子集进行合并
* 等价规则，如 出现 where 5=5 and a>5 会转化成where a>5
* COUNT(),MIN(),MAX()：在EXTRA中会出现 “Selecttables optimized away”的字样
    - 对于B-Tree索引而言，Max()/Min()的结果分别返回的是二叉树中最左边以及最右边的值，所以不需要进行表的访问就可以直接取到对应的值。
    - 对于Count()函数而言，在MYISAM引擎中维护了一个对应的常量值，也不需要对表进行访问就可以直接取到Count的值。
* 提前终止，在下列几种情况中，查询会提前终止，并不再对表进行扫描
    - 当优化器发现查询的结果已经满足查询需求的时候。比如查询中用到了LIMIT
    - Where的条件不成立的时候。例如 where id>100 and id <10
* 列表IN()的比较：where id in(2,4,1,3,8,6) 这种类型的限制条件在很多的RDBMS中等同于where id=2 or id=4 or id=3 or id=8 or id=6. 这种算法的复杂度是O(n).而在MYSQL中,首先会对In列表进行排序，然后通过二分查找的方式进行比较，该方式的算法复杂度是O(log n).如果IN列表中的数据量非常的大，则效果会非常的明显
* 关联子查询：因为select …from table1 t1 where t1.id in(select t2.fk from table2 t2 wheret2.id=’…’) 类型的语句往往会被优化成 select …. From table1 t1 where exists (select* from table2 t2 where t2.id=’…’ and t2.fk=t1.id), 由于在进行tabl2查询时, table1的值还无法确定, 所以会对table1进行全表扫描
    - 尽量用 INNER JOIN 替代 IN(),重写成 select * from table1 t1 inner jointable2 t2 using (id) where t2.id=’…’
* UNION的限制：UNION操作不会把UNION外的操作推送到每个子集
    - 为每个子操作单独的添加限制条件，例如  学生表有10000条记录,会员表有10000表记录,如果想按照姓名排序取两个表的前20条记录,如果在各个子查询中添加limit的话,则最外层的limit操作将会从40条记录中取20条,否则是从20000条中取20条
* Max()/MIN()：当执行 select max(id) from table1 where name=’sun’ 时,如果name没有建立相应的索引,MYSQL会进行全表扫描
    - 将SQL等同的转化为 select id from table1 use index(PRIMARY) wherename=’sun’ limit 1.  

### 检查

* EXPLAIN：可以让你知道MySQL是如何处理你的SQL语句的,分析SQL语句的执行情况
    - select_type:表示查询的类型。
    - table:输出结果集的表
    - type:表示表的连接类型(system和const为佳),从最好到最差的连接类型为system、const、eq_reg、ref、range、index和ALL
        + system、const：可以将查询的变量转为常量.  如id=1; id为 主键或唯一键.
        + eq_ref：访问索引,返回某单一行的数据.(通常在联接时出现，查询使用的索引为主键或惟一键)
        + ref：访问索引,返回某个值的数据.(可以返回多行) 通常使用=时发生
        + range：这个连接类型使用索引返回一个范围中的行，比如使用>或<查找东西，并且该字段上建有索引时发生的情况(注:不一定好于index)
        + index：以索引的顺序进行全表扫描，优点是不用排序,缺点是还要全表扫描
        + ALL：全表扫描，应该尽量避免
    - possible_keys:表示查询时，可能使用的索引
    - key:表示实际使用的索引
    - key_len:索引字段的长度
    - rows:扫描的行数
    - Extra:执行情况的描述和说明
        + using index：只用到索引,可以避免访问表. 
        + using where：使用到where来过虑数据. 不是所有的where clause都要显示using where. 如以=方式访问索引.
        + using tmporary：用到临时表
        + using filesort：用到额外的排序. (当使用order by v1,而没用到索引时,就会使用额外的排序)
        + range checked for eache record(index map:N)：没有好的索引.
* show:查看MySQL状态及变量
* PROCEDURE ANALYSE() 帮你去分析你的字段和其实际的数据，并会给你一些有用的建议。只有表中有实际的数据，这些建议才会变得有用，因为要做一些大的决定是需要有数据作为基础的。
* 慢查询:知道哪些SQL语句执行效率低下,mysql支持把慢查询语句记录到日志文件中
* profiling:更准确的SQL执行消耗系统资源的信息

```sql
ALTER TABLE order_copy ADD PRIMARY KEY(id); # 给1千万的数据添加primary key 需要耗时： 428秒（7分钟）
EXPLAIN SELECT * FROM order_copy WHERE id=12345\G; # 给id添加了索引，才使得rows的结果为1

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

show processlist
```

#### 慢日志

使用mysqldumpslow命令可以非常明确的得到各种我们需要的查询语句，对MySQL查询语句的监控、分析、优化是MySQL优化非常重要的一步。开启慢查询日志后，由于日志记录操作，在一定程度上会占用CPU资源影响mysql的性能，但是可以阶段性开启来定位性能瓶颈。

* -s, 是表示按照何种方式排序，c、t、l、r分别是按照记录次数、时间、查询时间、返回的记录数来排序，ac、at、al、ar，表示相应的倒叙；
* -t, 是top n的意思，即为返回前面多少条的数据；
* -g, 后边可以写一个正则匹配模式，大小写不敏感的；

```sql
long_query_time = 2 # 设置把日志写在那里，可以为空，系统会给一个缺省的文件
log-slow-queries = D:/mysql/logs/slow.log 

/path/mysqldumpslow -s r -t 10 /database/mysql/slow-log # 返回记录集最多的10个查询
/path/mysqldumpslow -s t -t 10 -g “left join” /database/mysql/slow-log # 得到按照时间排序的前10条里面含有左连接的查询语句。
```

#### 表优化

* 定期分析和检查表
* 定期优化表

```sql
analyze table tbl_name;
check table tbl_name;

optimize table tbl_name;
```

### 应用优化

* 使用连接池
* 减少对MySQL的访问
    - 理清应用逻辑，能一次取出的数据不用两次； 
    - 使用查询缓存MySQL的查询缓存（MySQL query cache）是4.1版本之后新增的功能，作用是存储select的查询文本和相应结果。如果随后收到一个相同的查询，服务器会从查询缓存中重新得到查询结果，而不再需要解析和执行查询。 查询缓存适用于更新不频繁的表，当表更改（包括表结构和数据）后，查询缓存会被清空。 
    - 在应用端增加cache层
    - 负载均衡 

## 参考

* [SQL语句百万数据量优化方案](https://juejin.im/post/5a01257a6fb9a045211e1bdc) 

索引覆盖


存储使用EMC阵列（容量大，数据安全），IBM服务器，即IOE组合，这三个组合很强大（高可用，高性能）




