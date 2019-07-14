# MySQL optimize

* 不同的语句，根据选择的引擎、表中数据的分布情况、索引情况、数据库优化策略、查询中的锁策略等因素，最终查询的效率相差很大
* 不要听信看到的关于优化的“绝对真理”，而应该是在实际的业务场景下通过测试来验证关于执行计划以及响应时间的假设

## 指标

MySQL 客户端和服务端通信协议是“半双工”的，这就意味着，客户端发送给服务器和服务器发给客户端是不能同时发生，这种协议让MySQL通信简单快速，但也就无法进行流量控制，一旦一端开始了，另一端是能等它结束。所以查询语句很长的时候，参数max_allowed_packet就特别重要了。

* 响应时间包括服务时间和等待时间，但这两个时间并不能细分出来，所以响应时间受影响比较大。我们可以通过估计查询的响应时间来做最初步的判断。
* 扫描的行数
* 返回的行数
* 延时（响应时间）：表示硬件的突发处理能力；
* 带宽（吞吐量）：代表硬件持续处理能力。
    - QPS（Queries Per Second，每秒查询书）
    - TPS（Transactions Per Second）
* CPU——Cache(L1-L2-L3)——内存——SSD硬盘——网络——硬盘
* 法制
    - 减少数据访问（减少磁盘访问）
    - 返回更少数据（减少网络传输或磁盘访问）
    - 减少交互次数（减少网络传输）
    - 减少服务器CPU开销（减少CPU及内存开销）
    - 利用更多资源（增加资源）

```sql
show global status like 'Questions';
show global status like 'Uptime'; # QPS = Questions / Uptime

show global status like 'Com_commit';
show global status like 'Com_rollback';
show global status like 'Uptime'; # TPS = (Com_commit + Com_rollback) / Uptime

vmstat 1 3 #  pay attentin to cpu
iostat -d -k 1 3
```

## 问题处理

- top 查看进程消耗
- 进入mysql show processlist
- threads_running/QPS/TPS
- 慢查询
- MySQL profile工具
- orzdba

## 低效原因

* 硬件问题。如网络速度慢，内存不足，I/O吞吐量小，磁盘空间满了等。
* 检索大量不需要的数据,MySQL服务层在分析大量超过需要的数据行
    - 查询不需要的记录：一个常见的错误是误以为MySQL会只返回需要的数据，实际上MySQL是先返回全部结果集再进行运算。 加limit，需要字段
    - 返回多余的列：取出全部列，会让优化器无法完成索引覆盖扫描这类优化，而且给服务器带来额外的I/O，内存，CPU的消耗。
    - 重复数据：如用户头像需多次取出，此时应将数据缓存起来
* 没有索引或者索引失效。（一般在互联网公司，DBA会在半夜把表锁了，重新建立一遍索引，因为当你删除某个数据的时候，索引的树结构就不完整了。所以互联网公司的数据做的是假删除.一是为了做数据分析,二是为了不破坏索引 ）
* 数据过多（分库分表）
* 服务器调优及各个参数设置（调整my.cnf）
* 瓶颈
    - CPU在饱和的时候一般发生在数据装入内存或从磁盘上读取数据时候。
    - 磁盘I/O瓶颈发生在装入数据远大于内存容量的时候
    - 如果应用分布在网络上，那么查询量相当大的时候那么平瓶颈就会出现在网络上，我们可以用mpstat, iostat, sar和vmstat来查看系统的性能状态。

## 硬件优化

* CPU相关：服务器的BIOS设置中，可调整下面的几个配置，目的是发挥CPU最大性能，或者避免经典的NUMA问题：
    - 选择Performance Per Watt Optimized(DAPC)模式，发挥CPU最大性能，跑DB这种通常需要高运算量的服务就不要考虑节电了；
    - 关闭C1E和C States等选项，目的也是为了提升CPU效率；
    - Memory Frequency（内存频率）选择Maximum Performance（最佳性能）；
    - 内存设置菜单中，启用Node Interleaving，避免NUMA问题；
    - 重点往往是吞吐量，性能优先:解放数据库CPU，把复杂逻辑计算放到服务层
* 磁盘I/O
    - 使用SSD或者PCIe SSD设备，至少获得数百倍甚至万倍的IOPS提升；
    - 购置阵列卡同时配备CACHE及BBU模块，可明显提升IOPS（主要是指机械盘，SSD或PCIe SSD除外。同时需要定期检查CACHE及BBU模块的健康状况，确保意外时不至于丢失数据）；
    - 有阵列卡时，设置阵列写策略为WB，甚至FORCE WB（若有双电保护，或对数据安全性要求不是特别高的话），严禁使用WT策略。并且闭阵列预读策略，基本上是鸡肋，用处不大；
    - 尽可能选用RAID-10，而非RAID-5；
    - 使用机械盘的话，尽可能选择高转速的，例如选用15KRPM，而不是7.2KRPM的盘
    - 有足够的物理内存，能将整个InnoDB文件加载到内存里 —— 如果访问的文件在内存里，而不是在磁盘上，InnoDB会快很多。
    - 全力避免 Swap 操作 — 交换（swapping）是从磁盘读取数据，所以会很慢。
    - 使用电池供电的RAM（Battery-Backed RAM）。
    - 使用一个高级磁盘阵列 — 最好是 RAID10 或者更高。
    - 避免使用RAID5 — 和校验需要确保完整性，开销很高。
    - 将你的操作系统和数据分开，不仅仅是逻辑上要分开，物理上也要分开 — 操作系统的读写开销会影响数据库的性能。
    - 将临时文件和复制日志与数据文件分开 — 后台的写操作影响数据库从磁盘文件的读写操作。
    - 更多的磁盘空间等于更高的速度。
    - 磁盘速度越快越好。
    - SAS优于SATA。
    - 小磁盘的速度比大磁盘的更快，尤其是在 RAID 中。
    - 使用电池供电的缓存 RAID（Battery-Backed Cache RAID）控制器。
    - 避免使用软磁盘阵列。
    - 考虑使用固态IO卡（不是磁盘）来作为数据分区 — 几乎对所有量级数据，这种卡能够支持 2 GBps 的写操作。
    - 在 Linux 系统上，设置 swappiness 的值为0 — 没有理由在数据库服务器上缓存文件，这种方式在Web服务器或桌面应用中用的更多。
    - 尽可能使用 noatime 和 nodirtime 来挂载文件系统 — 没有必要为每次访问来更新文件的修改时间。
    - 使用 XFS 文件系统 — 一个比ext3更快的、更小的文件系统，拥有更多的日志选项，同时，MySQL在ext3上存在双缓冲区的问题。
    - 优化你的 XFS 文件系统日志和缓冲区参数 – -为了获取最大的性能基准。
    - 在Linux系统中，使用 NOOP 或 DEADLINE IO 调度器 — CFQ 和 ANTICIPATORY 调度器已经被证明比 NOOP 和 DEADLINE 慢。
    - 使用 64 位操作系统 — 有更多的内存能用于寻址和 MySQL 使用。
    - 将不用的包和后台程序从服务器上删除 — 减少资源占用。
    - 将使用 MySQL 的 host 和 MySQL自身的 host 都配置在一个 host 文件中 — 这样没有 DNS 查找。
    - 永远不要强制杀死一个MySQL进程 — 你将损坏数据库，并运行备份。
    - 让你的服务器只服务于MySQL — 后台处理程序和其他服务会占用数据库的 CPU 时间。

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
* 只允许使用内网域名，而不是ip连接数据库.不只是数据库，缓存（memcache、redis）的连接，服务（service）的连接都必须使用内网域名，机器迁移/平滑升级/运维管理…太多太多的好处

### Schema优化

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
    - 整数类型：尽量使用TINYINT、SMALLINT、MEDIUM_INT作为整数类型而非INT，如果非负则加上UNSIGNED
        * 整数通常是标识列最好的选择， 因为它们很快并且可以使用AUTO_INCREMENT
        + 整数 (whole number)
            * 可以使用这几种整数类型：TINYINT, SMALLINT, MEDIUMINT, INT, BIGINT。分别使用8,16, 24, 32, 64位存储空间
            * UNSIGNED:表示不允许负值，这大致可以使正数的上限提高一倍。 例如 TINYINT. UNSIGNED 可以存储的范围是 0 - 255, 而 TINYINT 的存储范围是 -128 -127
            * 整数计算一般使用64 位的 BIGINT 整数， 即使在 32 位环境也是如此。（ 一些聚合函数是例外， 它们使用DECIMAL 或 DOUBLE 进行计算）
            * 可以为整数类型指定宽度， 例如 INT(11), 对大多数应用这是没有意义的, INT使用32位（4个字节）存储空间，那么它的表示范围已经确定
                - 它不会限制值的合法范围，只是规定了MySQL 的一些交互工具（例如 MySQL 命令行客户端）用来显示字符的个数
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
            * 和整数类型一样，能选择的只是存储类型； MySQL使用DOUBLE作为内部浮点计算的类型。 因为需要额外的空间和计算开销，所以应该尽扯只在对小数进行精确计算时才使用DECIMAL。
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
    - 禁止使用ENUM，可使用TINYINT代替
        + 缺点是枚举的字符串列表是固定的:添加和删除字符串（枚举选项）必须使用 ALTER TABLE（如果只是在列表末尾追加元素，不需要重建表）
        + ENUM的内部实际存储就是整数(保存的是 TINYINT),但其外表上显示为字符串。如果有一个字段，比如“性别”，“国家”，“民族”，“状态”或“部门”，知道这些字段的取值是有限而且固定的，那么应该使用 ENUM 而不是 VARCHAR
        + 使用ENUM、CHAR 而不是VARCHAR，使用合理的字段属性长度
        + ENUM和SET类型 对于标识列来说，EMUM和SET类型通常是一个糟糕的选择， 尽管对某些只包含固定状态或者类型的静态 "定义表" 来说可能是没有问题的。
        * ENUM和SET列适合存储固定信息， 例如有序的状态、 产品类型、 人的性别
    + 对千完全 "随机" 的字符串也需要多加注意， 例如 MDS() 、 SHAl() 或者 UUID() 产生的字符串。 这些函数生成的新值会任意分布在很大的空间内， 这会导致 INSERT 以及一些SELECT语句变得很慢。
    + 如果存储 UUID 值， 则应该移除 "-"符号。
    + 特殊类型数据 某些类型的数据井不直接与内置类型一致
        * 低千秒级精度的时间戳
        * 整型来存IPv4地址:实际上是32位无符号整数，不是字符串。用小数点将地址分成四段的表示方法只是为了让人们阅读容易。所以应该用无符号整数存储IP地址。MySQL提供INET_ATON()和INET_NTOA()函数在这两种表示方法之间转换
* 分离频繁更新和频繁读取的数据，新增字段时分析使用链接表还是扩展行
* 规范
    - 控制单表数据量:单表1G体积 500W⾏,控制在千万级
    - 单表不超过50个INT字段 不超过20个CHAR(10)字段:存储引擎的API工作时需要在服务器层和存储引擎层之间通过行缓冲格式拷贝数据，然后在服务器层将缓冲内容解码成各个列，这个转换过程的代价是非常高的。如果列太多而实际使用的列又很少的话，有可能会导致CPU占用过高。
    - 单行不超过200Byte
* 禁止使用外键，如果有外键完整性约束，需要应用程序控制：外键会导致表与表之间耦合，update与delete操作都会涉及相关联的表，十分影响sql 的性能，甚至会造成死锁。高并发情况下容易造成数据库性能，大数据高并发业务场景数据库使用以性能优先
* 多表联接查询时，关联字段类型尽量一致，并且都要有索引
* 所有的InnoDB表都设计一个无业务用途的自增列做主键，对于绝大多数场景都是如此，真正纯只读用InnoDB表的并不多，真如此的话还不如用TokuDB来得划算
* 类似分页功能的SQL，建议先用主键关联，然后返回结果集，效率会高很多；

### 查询优化

对查询进行优化，要尽量避免全表扫描

* 索引并不是越多越好：索引固然可以提高相应的 select 的效率，但同时也降低了 insert 及 update 的效率，因为 insert 或 update 时有可能会重建索引
* 主键：每张表都设置一个ID做为其主键。使用UNSIGNED，并设置上自动增加的AUTO_INCREMENT标志
* 保证索引简单：不要在同一列上加多个索引
* 监测
    - 使用 EXPLAIN 和慢SQL分析 来决定查询功能是否合适
    - 经常测试你的查询，看是否需要做性能优化 — 性能可能会随着时间的变化而变化
    - Show Profile是比Explain更近一步的执行细节，可以查询到执行每一个SQL都干了什么事，这些事分别花了多少秒
    - 基准查询，包括服务器的负载，有时一个简单的查询会影响其他的查询。
    - 当服务器的负载增加时，使用SHOW PROCESSLIST来查看慢的/有问题的查询
    - 在存有生产环境数据副本的开发环境中，测试所有可疑的查询
* 如果合适，用 GROUP BY 代替 DISTINCT
* 使用索引字段和 ORDER BY 来代替 MAX
* 有时，MySQL 会选择错误的索引，这种情况使用 USE INDEX。
* 使用 SQL_MODE=STRICT 来检查问题
* 索引字段少于5个时，UNION 操作用 LIMIT，而不是 OR。
* 使用 INSERT ON DUPLICATE KEY 或 INSERT IGNORE 来代替 UPDATE，避免 UPDATE 前需要先 SELECT
* 缓存优化
    - 保持查询一致，这样后续类似的查询就能使用查询缓存了
    - `$r = mysql_query("SELECT username FROM user WHERE signup_date >= CURDATE()");`
    - CURDATE()、NOW() 和 RAND() 或是其它的诸如此类的SQL函数都不会开启查询缓存
    - 避免在 where 子句或ORDER BY中对字段进行表达式操作或者函数操作
* UNION
    - UNION的策略是先创建临时表，然后再把各个查询结果插入到临时表中，最后再来做查询
    - 尽量用union all代替union：union和union all的差异主要是前者需要将结果集合并后再进行唯一性过滤操作，这就会涉及到排序，增加大量的CPU运算，加大资源消耗及延迟。当然，union all的前提条件是两个结果集没有重复数据。
    - 使用 UNION 来代替 WHERE 子句中的子查询
    - 子查询的效率不如连接查询（join）
        + 因为MySQL不需要在内存中创建临时表来完成这个在逻辑上需要两个步骤的查询工作
* 对 UPDATE 来说，使用 SHARE MODE 来防止排他锁。
* 重启 MySQL 时，记得预热数据库，确保将数据加载到内存，提高查询效率。
* 删除表中所有数据:使用 DROP TABLE ，然后再 CREATE TABLE ，而不是 DELETE FROM
* 考虑持久连接，而不是多次建立连接，已减少资源的消耗
    - 持久连接意味着减少重建连接到MySQL的成本
    - 当持久连接被创建时，它将保持打开状态直到脚本完成运行
    - 因为Apache重用它的子进程，下一次进程运行一个新的脚本时，它将重用相同的MySQL连接。`mysql_pconnect()`,可能会出现连接数限制问题、内存问题等等
* 禁止使用存储过程、视图、触发器、Event
* 尽量避免使用游标，因为游标的效率较差，如果游标操作的数据超过1万行，那么就应该考虑改写
* 禁止使用外键，如果有外键完整性约束，需要应用程序控制
* 避免频繁创建和删除临时表，以减少系统表资源的消耗。临时表并不是不可使用，适当地使用它们可以使某些例程更有效，例如，当需要重复引用大型表或常用表中的某个数据集时。但是，对于一次性事件， 最好使用导出表。
* 移除外部连接查询
    - 在两个表的行中放置占位符（空数据）来删除OUTER JOINS操作
* 返回结果
    - 禁止使用`SELECT *`，只获取必要的字段，避免产生严重的随机读问题,读取不需要的列会增加CPU、IO、NET消耗；不能有效的利用覆盖索引
    - 限制工作数据集的大小：查询语句带有子查询时，注意在子查询的内部语句上使用过滤
    - 尽量避免向客户端返回大数据量，若数据量过大，应该考虑相应需求是否合理
    - 当只要一行数据时使用 LIMIT 1，找到一条数据后停止搜索，而不是继续往后查少下一条符合记录的数据
    * `select *` 和 select 字段 区别
        + 如果某些不需要的字段数据量特别大，还是写清楚字段比较好，因为这样可以减少网络传输。
        + index coverage：有一个常用查询，只需要用到表中的某两列，user_id和post_id，而且有一个多列索引已经覆盖了这两个列，那么这个索引就是这个查询的覆盖索引了。可以不用读data，直接使用index里面的值就返回结果的。但是一旦用了select*，就会有其他列需要读取，这时在读完index以后还需要去读data才会返回结果。
    * `Select count(*)`和 `Select Count（1）`
        + 统计某个列值的数量:列值是非空的，它不会统计NULL,如果确认括号中的表达式不可能为空时，实际上就是在统计行数
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
    - LIMIT分页
        + LIMIT M,N:全表扫描,速度会很慢且结果集返回不稳定
        + LIMIT 10000，20这样的查询，MySQL需要查询10020条记录然后只返回20条记录，前面的10000条都将被抛弃，这样的代价非常高。避免使用 OFFSET `SELECT id FROM t WHERE id > 10000 LIMIT 10 ;`
        + WHERE id_pk > (pageNum*10) ORDER BY id_pk ASC LIMIT M:ORDER BY后的列对象是主键或唯一所以,使得ORDERBY操作能利用索引被消除但结果集是稳定的
            * 排序操作:只有ASC 没有DESC
        + `PREPARE stmt_name FROM SELECT * FROM 表名称 WHERE id_pk > (？* ？) ORDER BY id_pk ASC LIMIT M`
        + 尽可能的使用覆盖索引扫描，而不是查询所有的列。然后根据需要做一次关联查询再返回所有的列
* where子句
    - 应尽量避免字段进行 null 值判断，否则将导致引擎放弃使用索引而进行全表扫描.最好不要给数据库留NULL，尽可能的使用 NOT NULL填充数据库
    - 避免在where子句中对字段进行表达式操作
    - 避免隐式类型转换
    - 应尽量避免使用负向查询NOT、!=、<>、!<、!>、NOT IN、NOT LIKE等，否则将引擎放弃使用索引而进行全表扫描。
    - 应尽量避免使用 or 来连接条件，如果一个字段有索引，一个字段没有索引，将导致引擎放弃使用索引而进行全表扫描。含有or的查询子句，如果要利用索引，则or之间的每个条件列都必须使用索引；如果没有索引，可以考虑增加索引。
    - in 和 not in 也要慎用，否则会导致全表扫描
    - 区分in和exists， not in和not exists
        + exists，那么以外层表为驱动表，先被访问，如果是IN，那么先执行子查询。所以IN适合于外表大而内表小的情况；EXISTS适合于外表小而内表大的情况。
        + 关于not in和not exists，推荐使用not exists，不仅仅是效率问题，not in可能存在逻辑问题。如何高效的写出一个替代not exists的sql语句？
    - 对于连续的数值，能用 between 就不要用 in 了
    - select id from t where name like '%abc%' 全表扫描
    - 在 where 子句中使用参数，也会导致全表扫描 select id from t where num = @num
    - 在 WHERE、GROUP BY 和 ORDER BY 的列上加上索引
    - 在查询中存在常量相等where条件字段（索引中的字段），且该字段在group by指定的字段的前面或者中间。来自于相等条件的常量能够填充搜索keys中的gaps，因而可以构成一个索引的完整前缀。索引前缀能够用于索引查找。如果要求对group by的结果进行排序，并且查找字段组成一个索引前缀，那么MySQL同样可以避免额外的排序操作。 c2在c1,c3之前，c2='a'填充这个坑，组成一个索引前缀，因而能够使用紧凑索引扫描。 select c1,c2,c3 from t1 where c2 = 'a' group by c1,c3 c1在索引的最前面，c1=a和group by c2,c3组成一个索引前缀，因而能够使用紧凑索引扫描。 select c1,c2,c3 from t1 where c1 = 'a' group by c2,c3 使用紧凑索引扫描，执行计划Extra一般显示"using index"，相当于使用了覆盖索引。
    - 通过索引 MySQL建立的索引（B+Tree）通常是有序的，如果通过读取索引就完成group by操作，那么就可避免创建临时表和排序。因而使用索引进行group by的最重要的前提条件是所有group by的参照列（分组依据的列）来自于同一个索引，且索引按照顺序存储所有的keys（即BTREE index，而HASH index没有顺序的概念）。松散索引扫描和紧凑索引扫描的最大区别是是否需要扫描整个索引或者整个范围扫描。
    + 正常流程 group by操作在没有合适的索引可用的时候，通常先扫描整个表提取数据并创建一个临时表，然后按照group by指定的列进行排序。在这个临时表里面，对于每一个group的数据行来说是连续在一起的。完成排序之后，就可以发现所有的groups，并可以执行聚集函数（aggregate function）。可以看到，在没有使用索引的时候，需要创建临时表和排序。在执行计划中通常可以看到"Using temporary; Using filesort"。
    - order by：尽量通过索引直接返回有序数据，减少额外的排序。MySQL中有两种排序方式：
        + 在 where 及 order by 涉及的列上建立索引
        + 通过有序索引顺序扫描直接返回有效数据，不需要额外的排序，操作效率较高
        + 对返回的数据进行排序，也就是常说的Filesort排序，所有不是通过索引直接返回排序结果的排序都是filesort排序
        + filesort有两种排序算法
            * 一种是一次扫描算法（较快）
            * 二种是两次扫描算法
            * 适当加大系统变量max_length_for_sort_data的值，能够让MySQL选择更优化的filesort排序算法；适当加大sort_buffer_size排序区，尽量让排序在内存中完成，而不是通过创建临时表放在文件中进行。
* 关联查询:表与表之间通过一个冗余字段来关联，要比直接使用 JOIN有更好的性能。如果确实需要使用关联查询的情况下，需要特别注意的是
    - 确保 ON和 USING字句中的列上有索引。在创建索引的时候就要考虑到关联的顺序。当表A和表B用列c关联的时候，如果优化器关联的顺序是A、B，那么就不需要在A表的对应列上创建索引。没有用到的索引会带来额外的负担，一般来说，除非有其他理由，只需要在关联顺序中的第二张表的相应列上创建索引
    - 确保任何的 GROUP BY和 ORDER BY中的表达式只涉及到一个表中的列，这样MySQL才有可能使用索引来优化。
    - 任何的关联都执行嵌套循环关联操作，即先在一个表中循环取出单条数据，然后在嵌套循环到下一个表中寻找匹配的行，依次下去，直到找到所有表中匹配的行为为止。然后根据各个表匹配的行，返回查询中需要的各个列
* ORM（Object Relational Mapper）
    - 最重要的是“Lazy Loading”：只有在需要的去取值的时候才会去真正的去做
    - 需要小心处理他们，否则可能最终创建了许多微型查询，这会降低数据库性能
    - 可以将多个查询批处理到事务中，其操作速度比向数据库发送单个查询快得多
* 拒绝3B(big)，大sql，大事务，大批量
* sub_select
* 查询松散索引扫描（Loose Index Scan）与紧凑索引扫描（Tight Index Scan）
    + 松散索引扫描方式下，分组操作和范围预测（如果有的话）一起执行完成的。不需要连续的扫描索引中得每一个元组，扫描时仅考虑索引中得一部分。当查询中没有where条件的时候，松散索引扫描读取的索引元组的个数和groups的数量相同。如果where条件包含范围预测，松散索引扫描查找每个group中第一个满足范围条件，然后再读取最少可能数的keys。松散索引扫描只需要读取很少量的数据就可以完成group by操作，因而执行效率非常高，执行计划中Etra中提示" using index for group-by"。松散索引扫描可以作用于在select list中其它形式的聚集函数，除了min()和max()之外，还支持：
        + AVG(DISTINCT), SUM(DISTINCT)和COUNT(DISTINCT)可以使用松散索引扫描。AVG(DISTINCT), SUM(DISTINCT)只能使用单一列作为参数。而COUNT(DISTINCT)可以使用多列参数。
        + 在查询中没有group by和distinct条件
        + 之前声明的松散扫描限制条件同样起作用
    - 符合一下条件
        + 查询在单一表上。
        + group by指定的所有列是索引的一个最左前缀，并且没有其它的列。比如表t1（ c1,c2,c3,c4）上建立了索引（c1,c2,c3）。如果查询包含"group by c1,c2"，那么可以使用松散索引扫描。但是"group by c2,c3"(不是索引最左前缀)和"group by c1,c2,c4"(c4字段不在索引中)。
        + 如果在选择列表select list中存在聚集函数，只能使用 min()和max()两个聚集函数，并且指定的是同一列（如果min()和max()同时存在）。这一列必须在索引中，且紧跟着group by指定的列。比如，select t1,t2,min(t3),max(t3) from t1 group by c1,c2。
        + 如果查询中存在除了group by指定的列之外的索引其他部分，那么必须以常量的形式出现（除了min()和max()两个聚集函数）。比如，select c1,c3 from t1 group by c1,c2不能使用松散索引扫描。而select c1,c3 from t1 where c3 = 3 group by c1,c2可以使用松散索引扫描。
        + 索引中的列必须索引整个数据列的值(full column values must be indexed)，而不是一个前缀索引。比如，c1 varchar(20), INDEX (c1(10)),这个索引没发用作松散索引扫描。
        + 紧凑索引扫描方式下，先对索引执行范围扫描（range scan），再对结果元组进行分组。可能是全索引扫描或者范围索引扫描，取决于查询条件。当松散索引扫描条件没有满足的时候，group by仍然有可能避免创建临时表。如果在where条件有范围扫描，那么紧凑索引扫描仅读取满足这些条件的keys（索引元组），否则执行全索引扫描。这种方式读取所有where条件定义的范围内的keys，或者扫描整个索引。紧凑索引扫描，只有在所有满足范围条件的keys被找到之后才会执行分组操作。
* 连表
    - 禁止大表使用JOIN查询、子查询
    - A join B:LEFT JOIN A表为驱动表INNER JOIN MySQL会自动找出那个数据少的表作用驱动表RIGHT JOIN B表为驱动表
    - 尽量使用inner join，避免left join
    - 被驱动表的索引字段作为on的限制字段
    - 利用小表去驱动大表
    - 删除JOIN和WHERE子句中的计算字段
    - JOIN 查询:确认两个表中Join的字段是被建过索引的。这样，MySQL内部会启动优化Join的SQL语句的机制。
    - 多表连接查询时，把结果集小的表（注意，这里是指过滤后的结果集，不一定是全表数据量小的）作为驱动表
    - 多表联接并且有排序时，排序字段必须是驱动表里的，否则排序列无法用到索引

```sql
SELECT A.xx , B.yy FROM A INNER JOIN B USING (c) WHERE A.xx IN (5 , 6)

SELECT film_id , description FROM film ORDER BY title LIMIT 50 , 5;
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
```

##  索引优化

查询速度的提高是以插入、更新、删除的速度为代价的，这些写操作，增加了大量的I/O

* 不要过度使用索引，过多的索引可能会导致过高的磁盘使用率以及过高的内存占用.评估你的查询
* 单列索引：一些基数（Cardinality）太小（比如说，该列的唯一值总数少于255）的列就不要创建独立索引了
* 尽量避免事后添加索引：可能需要监控大量的SQL才能定位到问题所在，而且添加索引的时间肯定是远大于初始添加索引所需要的时间
* 不会使用索引的情况：非独立的列（索引列不能是表达式的一部分，也不能是函数的参数）
* 前缀索引：对字符串列进行索引，如果可能应该指定一个前缀长度。 例如，如果有一个CHAR(255)的列，如果在前10个或20个字符内，多数值是惟一的，那么就不要对整个列进行索引。短索引不仅可以提高查询速度而且可以节省磁盘空间和I/O操作
* 多列索引
    - 在多个列上建立独立的索引并不能提高查询性能。理由非常简单，MySQL不知道选择哪个索引的查询效率更好
        + 在老版本，比如MySQL5.0之前就会随便选择一个列的索引
        + 新的版本会采用合并索引的策略
        + 当出现多个索引做相交操作时（多个AND条件），通常来说一个包含所有相关列的索引要优于多个独立索引。
        + 当出现多个索引做联合操作时（多个OR条件），对结果集的合并、排序等操作需要耗费大量的CPU和内存资源，特别是当其中的某些索引的选择性不高，需要返回合并大量数据时，查询成本更高。所以这种情况下还不如走全表扫描。
        + explain时如果发现有索引合并（Extra字段出现 Usingunion），应该好好检查一下查询和表结构是不是已经是最优的，如果查询和表都没有问题，那只能说明索引建的非常糟糕，应当慎重考虑索引是否合适，有可能一个包含所有相关列的多列索引更适合
    - 索引顺序:顺序对于查询是至关重要的，很明显应该把选择性更高的字段放到索引的前面，这样通过第一个字段就可以过滤掉大多数不符合条件的数据。
        + 如果索引字段赋予了一个默认的值，通过索引扫描的行数跟全表扫描基本没什么区别，索引也就起不到任何作用。
    - 多用复合索引，少用多个独立索引
* WHERE和JOIN部分中用到的所有字段上，都应该加上索引
* 较频繁的作为查询条件字段应该创建索引`select * from order_copy where id = $id`
* 唯一性太差的字段不适合单独创建索引，即使频繁作为查询条件`select * from order_copy where sex=’女’`
* 更新非常频繁的字段不适合创建索引`select * from order_copy where order_state=’未付款’`
* 不会出现在WHERE子句中字段不该创建索引
* 记住它们不会一直被用到；数据库如果计算出使用索引所耗费的时间长于全表扫描或其它操作时，将不会使用索引；
* 索引代价
    - 降低更新表的速度,被索引的表上INSERT和DELETE会变慢，因为更新表时，MySQL不仅要保存数据，还要保存一下索引文件。
    - 会占用磁盘空间的索引文件。一般情况这个问题不太严重，但如果在一个大表上创建了多种组合索引，索引文件的会膨胀很快
* 如果需要索引请考虑非默认类型的索引
* 在WHERE和JOIN中出现的列需要建立索引，但也不完全如此，因为MySQL只对<，<=，=，>，>=，BETWEEN，IN，以及某些时候的LIKE才会使用索引
* 不使用NOT IN和<>操作
* 不要在列上进行运算
    - ` select * from users where YEAR(adddate)<2007;` 将在每个行上进行运算，这将导致索引失效而进行全表扫描，因此我们可以改成
* like语句操作
    - like “%aaa%” 不会使用索引
    - like “aaa%”可以使用索引。
* 索引列排序  MySQL查询只使用一个索引，因此如果where子句中已经使用了索引的话，那么order by中的列是不会使用索引的。因此数据库默认排序可以符合要求的情况下不要使用排序操作；尽量不要包含多个列的排序，如果需要最好给这些列创建复合索引。
* 单表索引建议控制在5个以内,不允许超过5个：字段超过5个时，实际已经起不到有效过滤数据的作用了
* 禁止在更新十分频繁、区分度不高的属性上建立索引，字段值离散度这么低,没必要加索引，比如性别
* 对一个VARCHAR(N)列创建索引时，通常取其50%（甚至更小）左右长度创建前缀索引就足以满足80%以上的查询需求了，没必要创建整列的全长度索引；


```sql
# actorid和filmid两个列上都建立了独立的索引,如下查询
select film_id , actor_id from film_actor where actor_id = 1 or film_id = 1
# 老版本的MySQL会随机选择一个索引，但新版本做如下的优化
select film_id , actor_id from film_actor where actor_id = 1 union all select film_id , actor_id from film_actor where film_id = 1 and actor_id <> 1
```

## 存储优化

* 将 session 数据存储在 memcache 中，而不是 MySQL 中 — memcache 可以设置自动过期，防止MySQL对临时数据高成本的读写操作

## 高并发或大数据

* 主从复制或主主复制
    - mysql自带分区表，先试试这个，对你的应用是透明的，无需更改代码,但是sql语句是需要针对分区表做优化的，sql条件中要带上分区条件的列，从而使查询定位到少量的分区上，否则就会扫描全部分区
* 垂直拆分：根据模块的耦合度，将一个大的系统分为多个小的系统，也就是分布式系统
* 水平切分：针对数据量大的表
    - 这一步最麻烦，最能考验技术水平，要选择一个合理的sharding key,为了有好的查询效率，表结构也要改动，做一定的冗余，应用也要改，sql中尽量带sharding key，将数据定位到限定的表上去查，而不是扫描全部的表；

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

* EXPLAIN：可以知道MySQL是如何处理SQL语句的,分析SQL语句的执行情况，索引使用、扫描范围
    - select_type:表示查询的类型
        - SIMPLE： 简单查询:不包含 UNION 查询或子查询
        * PRIMARY： 主查询，或者是最外面的查询语句
        * SUBQUERY： 子查询中的第一个 SELECT
        * UNION： 表示此查询是 UNION 的第二或随后的查询
        * DEPENDENT UNION： UNION 中的第二个或后面的查询语句, 取决于外面的查询
        * UNION RESULT, UNION 的结果
        * DEPENDENT SUBQUERY: 子查询中的第一个 SELECT, 取决于外面的查询. 即子查询依赖于外层查询的结果.
        * DERIVED：衍生，表示导出表的SELECT（FROM子句的子查询）
    - table:查询的表
    - type:表的连接类型(system和const为佳),从最好到最差的连接类型为system、const、eq_reg、ref、range、index和ALL
        + system、const：可以将查询的变量转为常量.  如id=1; id为 主键或唯一键. 表中只有一条数据， 这个类型是特殊的 const 类型。
        + const: 针对主键或唯一索引的等值查询扫描，最多只返回一行数据。 const 查询速度非常快， 因为它仅仅读取一次即可。例如下面的这个查询，它使用了主键索引，因此 type 就是 const 类型的：explain select * from user_info where id = 2；
        + eq_ref：此类型通常出现在多表的 join 查询，表示对于前表的每一个结果，都只能匹配到后表的一行结果。并且查询的比较操作通常是 =，查询效率较高.访问索引,返回某单一行的数据.(通常在联接时出现，查询使用的索引为主键或惟一键)
        + ref：访问索引,返回某个值的数据.(可以返回多行) 通常使用=时发生
        + range：这个连接类型使用索引返回一个范围中的行，比如使用>或<查找东西，并且该字段上建有索引时发生的情况(注:不一定好于index)
        + index：表示全索引扫描(full index scan),以索引的顺序进行全表扫描，优点是不用排序,缺点是还要全表扫描
        + ALL：全表扫描，从内存读取整张表，增加I/O的速度并在CPU上加载
    - possible_keys:表示查询时，可能使用的索引
    - key:表示实际使用的索引
    - key_len:表示查询优化器使用了索引的字节数，这个字段可以评估组合索引是否完全被使用。
    - ref:这个表示显示索引的哪一列被使用了，如果可能的话,是一个常量
    - rows:扫描的行数
    - Extra:执行情况的描述和说明
        + using index：只用到索引,可以避免访问表.
        + using where：使用到where来过虑数据. 不是所有的where clause都要显示using where. 如以=方式访问索引.
        + using tmporary：用到临时表
        + using filesort：用到额外的排序. (当使用order by v1,而没用到索引时,就会使用额外的排序)
        + range checked for eache record(index map:N)：没有好的索引.
    - mysql workbeach会显示执行计划
* show:查看MySQL状态及变量
* PROCEDURE ANALYSE() 帮你去分析你的字段和其实际的数据，并会给你一些有用的建议。只有表中有实际的数据，这些建议才会变得有用，因为要做一些大的决定是需要有数据作为基础的。
* 慢查询:知道哪些SQL语句执行效率低下,mysql支持把慢查询语句记录到日志文件中.用来记录在MySQL中响应时间超过阀值的语句，具体指运行时间超过long_query_time值的SQL，则会被记录到慢查询日志中。long_query_time的默认值为10，意思是运行10s以上的语句。
    - 官方自带工具： mysqldumpslow
    - 开源工具：mysqlsla
    - percona-toolkit：工具包中的pt-query-digest工具可以分析汇总慢查询信息，具体逻辑可以看SlowLogParser这个函数。
    - 接删除慢日志文件，执行flush logs（必须的）。
    - 备份：先用mv重命名文件（不要跨分区），然后执行flush logs（必须的）
* profiling:更准确的SQL执行消耗系统资源的信息
* DESCRIBE语句可以放在SELECT, INSERT, UPDATE, REPLACE 和 DELETE语句前边使用。是EXPLAIN的同义词

![优化策略](../_static/index.jpeg "Optional title")

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

show processlist;

SHOW VARIABLES LIKE 'slow_query%';
SHOW VARIABLES LIKE 'long_query_time%';

SET GLOABL SLOW_QUERY_LOG=on; # 临时设置
set long_query_time=1;

# 永久设置 添加到配置文件
slow_query_log = ON
slow_query_log_file = /var/log/mysql/slow.log
long_query_time = 1

# 安装　percona-toolkit
wget https://www.percona.com/downloads/percona-toolkit/2.2.20/deb/percona-toolkit_2.2.20-1.tar.gz
tar zxvf percona-toolkit_2.2.20-1.tar.gz
# 安装
perl Makefile.PL
make && make install

./pt-query-digest  slow.log
```

### 优化策略

* 索引搜索字段：索引不仅仅是为了主键或唯一键。如果会在你的表中按照任何列搜索，你就都应该索引它们。
* Join表的时候使用相当类型的例，并将其索引：包含许多连接查询, 你需要确保连接的字段在两张表上都建立了索引，使用同样类型，相同的字符类型
* 永远为每张表设置一个ID:每个以id列为PRIMARY KEY的数据表中，优先选择AUTO_INCREMENT或者INT. VARCHAR字段作为主键（检索）速度较慢.一个可能的例外是"关联表"，用于两个表之间的多对多类型的关联。例如，"posts_tags"表中包含两列：post_id，tag_id，用于保存表名为"post"和"tags"的两个表之间的关系。这些表可以具有包含两个id字段的PRIMARY键。
* 相比VARCHAR优先使用ENUM:ENUM枚举类型是非常快速和紧凑的。在内部它们像TINYINT一样存储，但它们可以包含和显示字符串值。知道这些字段的取值是有限而且固定的，请使用ENUM而不是VARCHAR
* 通过PROCEDURE ANALYZE()获取建议：使用MySQL分析列结构和表中的实际数据，为你提供一些建议。它只有在数据表中有实际数据时才有用，因为这在分析决策时很重要。
* 如果可以的话使用NOT NULL：问一下你自己在空字符串值和NULL值之间（对应INT字段：0 vs. NULL）是否有任何的不同.如果没有理由一起使用这两个。NULL列需要额外的空间，他们增加了你的比较语句的复杂度。
* 预处理语句：预处理语句默认情况下会过滤绑定到它的变量，这对于避免SQL注入攻击极为有效。当然你也可以指定要过滤的变量。但这些方法更容易出现人为错误，也更容易被程序员遗忘。
* 无缓冲查询:通常当你从脚本执行一个查询，在它可以继续后面的任务之前将需要等待查询执行完成。你可以使用无缓冲的查询来改变这一情况。"mysql_unbuffered_query() 发送SQL查询语句到MySQL不会像 mysql_query()那样自动地取并缓冲结果行。这让产生大量结果集的查询节省了大量的内存，在第一行已经被取回时你就可以立即在结果集上继续工 作，而不用等到SQL查询被执行完成。"有一定的局限性。你必须在执行另一个查询之前读取所有的行或调用mysql_free_result() 。另外你不能在结果集上使用mysql_num_rows() 或 mysql_data_seek() 。
* 使用 UNSIGNED INT 存储IP地址：定长四个字段，还有查询优势（IP between ip1 and ip2）。在查询中可以使用 INET_ATON() 来把一个IP转换为整数，用 INET_NTOA() 来进行相反的操作。在 PHP 也有类似的函数，ip2long() 和 long2ip()。 `$r = "UPDATE users SET ip = INET_ATON('{$_SERVER['REMOTE_ADDR']}') WHERE user_id = $user_id`
* 固定长度（静态）的表会更快：所有列都是"固定长度"，那么这个表被认为是"静态"或"固定长度"的。不固定的列类型包括 VARCHAR、TEXT、BLOB等。即使表中只包含一个这些类型的列，这个表就不再是固定长度的，MySQL 引擎会以不同的方式来处理它。固定长度的表会提高性能，因为 MySQL 引擎在记录中检索的时候速度会更快。它们也易于缓存，崩溃后容易重建。不过它们也会占用更多空间
* 垂直分区是为了优化表结构而对其进行纵向拆分的行为。将低频信息放到另一个表中，这样你的主用户表就会更小。如你所知，表越小越快。例子：last_login" 字段，用户每次登录网站都会更新这个字段，而每次更新都会导致这个表缓存的查询数据被清空。这种情况下你可以将那个字段放到另一张表里，保持用户表更新量最小。
* 拆分大型DELETE或INSERT语句：执行大型DELETE或INSERT查询，则需要注意不要影响网络流量。当执行大型语句时，它会锁表并使你的Web应用程序停止。Apache运行许多并行进程/线程。 因此它执行脚本效率很高。所以服务器不期望打开过多的连接和进程，这很消耗资源，特别是内存。如果你锁表很长时间（如30秒或更长），在一个高流量的网站，会导致进程和查询堆积，处理这些进程和查询可能需要很长时间，最终甚至使你的网站崩溃。维护脚本需要删除大量的行，只需使用LIMIT子句，以避免阻塞。`while (1) { mysql_query("DELETE FROM logs WHERE log_date`
* 越少的列越快:对于数据库引擎，磁盘可能是最重要的瓶颈。更小更紧凑的数据、减少磁盘传输量，通常有助于性能提高。如果已知表具有很少的行，则没有理由是主键类型为INT，可以用MEDIUMINT、SMALLINT代替，甚至在某些情况下使用TINYINT。 如果不需要完整时间记录，请使用DATE而不是DATETIME。
* 选择正确的存储引擎
    * MyISAM适用于读取繁重的应用程序，但是当有很多写入时它不能很好地扩展。 即使你正在更新一行的一个字段，整个表也被锁定，并且在语句执行完成之前，其他进程甚至无法读取该字段。 MyISAM在计算SELECT COUNT（*）的查询时非常快。
    * InnoDB是一个更复杂的存储引擎，对于大多数小的应用程序，它比MyISAM慢。 但它支持基于行的锁定，使其更好地扩展。 它还支持一些更高级的功能，比如事务。

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

## 批量插入

* 合并数据:合并后日志量（MySQL的binlog和innodb的事务让日志）减少了，降低日志刷盘的数据量和频率，同时也能减少SQL语句解析的次数，减少网络传输的IO。
    - bulk_insert_buffer_size=120M 或者更大
    - 在同一SQL中务必不能超过SQL长度限制，通过max_allowed_packet配置可以修改，默认是1M，测试时修改为8M
* 事物
    - 有innodb_log_buffer_size配置项，超过这个值会把innodb的数据刷到磁盘中，这时，效率会有所下降
* 对于Innodb类型:数据有序插入,导入的数据按照主键的顺序排列
* MyISAM:禁用索引
* Load Data:将假设各数据列的值以制表符（t）分隔，各数据行以换行符（n）分隔，数据值的排列顺序与各数据列在数据表里的先后顺序一致
* 数据量较大时（1千万以上），性能会急剧下降，这是由于此时数据量超过了innodb_buffer的容量，每次定位索引涉及较多的磁盘读写操作，性能下降较快
* 预处理

```sql
INSERT INTO TBL_TEST (id) VALUES (1), (2), (3)

## Myisam类型:关闭MyISAM表非唯一索引的更新
ALTER TABLE tblname DISABLE KEYS;
loading the data
ALTER TABLE tblname ENABLE KEYS;
```

## 批量更新

* replace into 操作本质是对重复的记录先delete 后insert，如果更新的字段不全会将缺失的字段置为缺省值，用这个要悠着点！否则不小心清空大量数据可不是闹着玩的！！！
* insert into 则是只update重复记录，不会改变其它字段。


```sql
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
```

#### 维护优化

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
* 减少对MySQL的访问
    - 理清应用逻辑，能一次取出的数据不用两次；
    - 使用查询缓存MySQL的查询缓存（MySQL query cache）是4.1版本之后新增的功能，作用是存储select的查询文本和相应结果
        + 如果随后收到一个相同的查询，服务器会从查询缓存中重新得到查询结果，而不再需要解析和执行查询
        + 查询缓存适用于更新不频繁的表，当表更改（包括表结构和数据）后，查询缓存会被清空
    - 在应用端增加cache层
    - 负载均衡

## 工具

* sysbench：一个模块化，跨平台以及多线程的性能测试工具
* iibench-mysql：基于 Java 的 MySQL/Percona/MariaDB 索引进行插入性能测试工具
* tpcc-mysql：Percona开发的TPC-C测试工具
* Query Monitor:数据库查询特性使其成为定位慢SQL查询工具。该插件会报告所有页面请求过程中的数据库请求，并且可以通过调用这些查询代码或者原件
* [Meituan-Dianping/SQLAdvisor](https://github.com/Meituan-Dianping/SQLAdvisor):输入SQL，输出索引优化建议

## 行为规范

* 禁止使用应用程序配置文件内的帐号手工访问线上数据库
* 禁止非DBA对线上数据库进行写操作，修改线上数据需要提交工单，由DBA执行，提交的SQL语句必须经过测试
* 分配非DBA以只读帐号，必须通过VPN+跳板机访问授权的从库
* 开发、测试、线上环境隔离
* 禁止使用INSERT INTO t_xxx VALUES(xxx)，必须显示指定插入的列属性
* 禁止使用属性隐式转换：SELECT uid FROM t_user WHERE phone=13812345678 会导致全表扫描，而不能命中phone索引，
* 禁止在WHERE条件的属性上使用函数或者表达式：SELECT uid FROM t_user WHERE from_unixtime(day)>='2017-02-15' 会导致全表扫描
* 禁止大表使用JOIN查询，禁止大表使用子查询
* 禁止使用OR条件，必须改为IN查询

## 参考

* [SQL语句百万数据量优化方案](https://juejin.im/post/5a01257a6fb9a045211e1bdc)
