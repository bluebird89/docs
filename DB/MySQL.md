# MySQL

Open source relational database management system

## 版本

Percona分支版本，它是一个相对比较成熟的、优秀的MySQL分支版本，在性能提升、可靠性、管理型方面做了不少改善。它和官方ORACLE MySQL版本基本完全兼容，并且性能大约有20%以上的提升。

## 客户端

- MySQLWorkbench
- SQLyog   `ttrar`  `59adfdfe-bcb0-4762-8267-d7fccf16beda`
- phpAdmin
- 命令行

## 安装

### MAC

```shell
brew install mysql
brew services start mysql # /usr/local/Cellar/mysql/5.7.20
mysql_secure_installation # 没有设置 root 帐户的密码，马上设置它;通过删除可从本地主机外部访问的 root 帐户来禁用远程 root 用户登录;删除匿名用户帐户和测试数据库

unset TMPDIR
mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp
mysql.server start  # Mac服务管理
net start/stop mysql # win平台

sudo apt remove mysql-server
sudo apt autoremove mysql-server
sudo apt remove mysql-common

sudo rm /var/lib/mysql/ -R
sudo rm /etc/mysql/ -R

dpkg -l | grep mysql  # 
dpkg -l |grep ^rc|awk '{print $2}' |sudo xargs dpkg -P  # 

brew cask install mysqlworkbench
```

### linux

```sh
sudo apt install mysql

# 源码安装
groupadd mysql 
useradd -g mysql mysql
cd /usr/local/mysql-5.5.44-linux2.6-i686/
chown -R msyql.mysql .
scripts/mysql_install_db --basedir=/usr/local/mysql chown -R root .
cp support-files/mysql.server /etc/init.d/mysqld
chkconfig --add mysqld
chkconfig mysqld on
cp support-files/my-medium.cnf /etc/my.cnf
service mysqld start 
ps aux | grep mysqld
# 注意:/usr/local/mysql/bin/mysqld: error while loading shared libraries: libaio.so.1: cannot open shared object fil 134
# 解决方案:yum install libaio
sestatus -v
getenforce
#修改/etc/selinux/config 文件
#将SELINUX=enforcing改为SELINUX=disabled
#重启机器即可

# 服务管理
service mysql start
service mysql stop
service mysql status
service mysql restart
```

## 概念

- 支持sql语言，指结构化查询语言，全称是 Structured Query Language.
- RDBMS 指关系型数据库管理系统，全称 Relational Database Management System。
- DBMS:关联表公共字段的名字可以不一样，但是数据类型必须一样
- 索引
- 数据库操作
- 表操作
- 数据操作
- 子查询
- 存储过程
- 触发器
- 视图
- 事务
- 锁
- 外键约束
- 影像复制

### 配置

配置文件：/usr/local/etc/my.cnf  或者 my.ini

* 数据库文件路径 `datadir="F:/wamp/mysql/data"` 
* 字符集: 客户端向MySQL服务器端请求和返加的数据的字符集，在选择数据库后使用:`set names gbk`;默认使用utf8mb4字符集,utf8mb4是utf8的超集，emoji表情以及部分不常见汉字在utf8下会表现为乱码，故需要升级至utf8mb4。
    + 数据库存储:一个汉字utf8下为两个长度,gbk下为一个长度
    + 正常一个汉字utf8下为三个字节,gbk下为两个字节
* 保证客户端使用字符集与服务端返回数据字符集编码一致(以适应客户端为主,修改服务器服务器端配置) 查询系统变量:
* 校对集: 
    - _bin：按二进制编码比较 
    - _ci：不区分大小写比较
* 连接变量
    - max_connection # 最大连接数:增加该值增加mysqld 要求的文件描述符的数量。如果服务器的并发连接请求量比较大，建议调高此值，以增加并行连接数量，当然这建立在机器能支撑的情况下，因为如果连接数越多，介于MySQL会为每个连接提供连接缓冲区，就会开销越多的内存，所以要适当调整该值，不能盲目提高设值。
        + max_used_connections / max_connections * 100% （理想值≈ 85%）
        + max_used_connections跟max_connections相同 那么就是max_connections设置过低或者超过服务器负载上限了，低于10%则设置过大。
    - back_log: MySQL能暂存的连接数量。当主要MySQL线程在一个很短时间内得到非常多的连接请求，这就起作用。如果MySQL的连接数据达到max_connections时，新来的请求将会被存在堆栈中，以等待某一连接释放资源，该堆栈的数量即back_log，如果等待连接的数量超过back_log，将不被授予连接资源。
        + back_log值指出在MySQL暂时停止回答新请求之前的短时间内有多少个请求可以被存在堆栈中。只有如果期望在一个短时间内有很多连接，你需要增加它，换句话说，这值对到来的TCP/IP连接的侦听队列的大小。
        + 默认数值是50，可调优为128，对于Linux系统设置范围为小于512的整数。 
* 缓冲区变量
    - key_buffer_size指定索引缓冲区的大小，它决定索引处理的速度，尤其是索引读的速度。通过检查状态值Key_read_requests和Key_reads，可以知道key_buffer_size设置是否合理。比例key_reads / key_read_requests应该尽可能的低，至少是1:100，1:1000更好（上述状态值可以使用SHOW STATUS LIKE ‘key_read%’获得）。
        + key_buffer_size只对MyISAM表起作用。即使你不使用MyISAM表，但是内部的临时磁盘表是MyISAM表，也要使用该值。可以使用检查状态值created_tmp_disk_tables得知详情。
        + 计算索引未命中缓存的概率：`key_cache_miss_rate ＝Key_reads / Key_read_requests * 100%`，设置在1/1000左右较好
    - query_cache_size:使用查询缓冲，MySQL将查询结果存放在缓冲区中，今后对于同样的SELECT语句（区分大小写），将直接从缓冲区中读取结果。
        + 如果Qcache_lowmem_prunes的值非常大，则表明经常出现缓冲不够的情况
        + 如果Qcache_hits的值也非常大，则表明查询缓冲使用非常频繁，此时需要增加缓冲大小
        + 如果Qcache_hits的值不大，则表明你的查询重复率很低，这种情况下使用查询缓冲反而会影响效率，那么可以考虑不用查询缓冲。
        + query_cache_type指定是否使用查询缓冲，可以设置为0、1、2，该变量是SESSION级的变量。
        + query_cache_limit指定单个查询能够使用的缓冲区大小，缺省为1M。
        + query_cache_min_res_unit是在4.1版本以后引入的，它指定分配缓冲区空间的最小单位，缺省为4K。检查状态值Qcache_free_blocks，如果该值非常大，则表明缓冲区中碎片很多，这就表明查询结果都比较小，此时需要减小query_cache_min_res_unit。
        + 查询缓存碎片率= Qcache_free_blocks / Qcache_total_blocks * 100%,如果查询缓存碎片率超过20%，可以用FLUSH QUERY CACHE整理缓存碎片，或者试试减小query_cache_min_res_unit，如果你的查询都是小数据量的话。
        + 查询缓存利用率= (query_cache_size – Qcache_free_memory) / query_cache_size * 100%,查询缓存利用率在25%以下的话说明query_cache_size设置的过大，可适当减小；查询缓存利用率在80％以上而且Qcache_lowmem_prunes > 50的话说明query_cache_size可能有点小，要不就是碎片太多。
        + 查询缓存命中率= (Qcache_hits – Qcache_inserts) / Qcache_hits * 100%,示例服务器查询缓存碎片率＝20.46％，查询缓存利用率＝62.26％，查询缓存命中率＝1.94％，命中率很差，可能写操作比较频繁吧，而且可能有些碎片。
    - record_buffer_size:每个进行一个顺序扫描的线程为其扫描的每张表分配这个大小的一个缓冲区。如果你做很多顺序扫描，你可能想要增加该值。默认数值是131072(128K)，可改为16773120 (16M)
    - read_rnd_buffer_size:随机读缓冲区大小。当按任意顺序读取行时(例如，按照排序顺序)，将分配一个随机读缓存区。进行排序查询时，MySQL会首先扫描一遍该缓冲，以避免磁盘搜索，提高查询速度，如果需要排序大量数据，可适当调高该值。但MySQL会为每个客户连接发放该缓冲空间，所以应尽量适当设置该值，以避免内存开销过大。一般可设置为16M.
    - sort_buffer_size:每个需要进行排序的线程分配该大小的一个缓冲区。增加这值加速ORDER BY或GROUP BY操作。默认数值是2097144(2M)，可改为16777208 (16M)。
    - join_buffer_size:联合查询操作所能使用的缓冲区大小.
    - record_buffer_size，read_rnd_buffer_size，sort_buffer_size，join_buffer_size为每个线程独占，也就是说，如果有100个线程连接，则占用为16M*100
    - table_cache:表高速缓存的大小。每当MySQL访问一个表时，如果在表缓冲区中还有空间，该表就被打开并放入其中，这样可以更快地访问表内容。通过检查峰值时间的状态值Open_tables和Opened_tables，可以决定是否需要增加table_cache的值。如果你发现open_tables等于table_cache，并且opened_tables在不断增长，那么你就需要增加table_cache的值了（上述状态值可以使用SHOW STATUS LIKE ‘Open%tables’获得）。注意，不能盲目地把table_cache设置成很大的值。如果设置得太高，可能会造成文件描述符不足，从而造成性能不稳定或者连接失败。1G内存机器，推荐值是128－256。内存在4GB左右的服务器该参数可设置为256M或384M。
    - max_heap_table_size:临时表分配足够的内存.用户可以创建的内存表(memory table)的大小。这个值用来计算内存表的最大行数值。这个变量支持动态改变，即set @max_heap_table_size=#,这个变量和tmp_table_size一起限制了内部内存表的大小。如果某个内部heap（堆积）表大小超过tmp_table_size，MySQL可以根据需要自动将内存中的heap表改为基于硬盘的MyISAM表。
        + 临时表用于内部操作如GROUP BY和distinct，还有一些ORDER BY查询以及UNION和FROM子句（派生表）中的子查询。这些都是在内存中创建的内存表。内存中临时表的最大大小由tmp_table_size和max_heap_table_size中较小的值确定。如果临时表的大小超过这个阈值，则将其转换为磁盘上的InnoDB或MyISAM表。此外，如果查询涉及BLOB或TEXT列，而这些列不能存储在内存表中，临时表总是直接指向磁盘。
        + 一定要监视服务器的内存使用情况，因为内存中的临时表可能会增加达到服务器内存容量的风险.一般来说，32M到64M是建议值，从这两个变量开始并根据需要进行调优
        + 允许的最大值：显示tmp_table_size服务器变量的值，它定义了在内存中创建的临时表的最大大小。与max_heap_table_size一起，这个值定义了可以在内存中创建的临时表的最大大小。如果内存临时表大于此大小，则将其存储在磁盘上。
        + 内存表的最大大小：显示max_heap_table_size服务器变量的值，该值定义了显式创建的MEMORY存储引擎表的最大大小。          
        + 创建的临时表总数：显示created_tmp_tables服务器变量的值，它定义了在内存中创建的临时表的数量。          
        + 在磁盘上创建的临时表：显示created_tmp_disk_tables服务器变量的值，该变量定义了在磁盘上创建的临时表的数量。如果这个值很高，则应该考虑增加tmp_table_size和max_heap_table_size的值，以便增加创建内存临时表的数量，从而减少在磁盘上创建临时表的数量。          
        + 磁盘：总比率：基于created_tmp_disk_tables除以created_tmp_tables的计算值。由于tmp_table_size或max_heap_table_size不足而在磁盘上创建的临时表的百分比。Monyog将这个数字显示为一个进度条和百分比，以便快速确定有多少磁盘用于临时表，而不是内存。
        + 通过设置tmp_table_size选项来增加一张临时表的大小，例如做高级GROUP BY操作生成的临时表。如果调高该值，MySQL同时将增加heap表的大小，可达到提高联接查询速度的效果，建议尽量优化查询，要确保查询过程中生成的临时表在内存中，避免临时表过大导致生成基于硬盘的MyISAM表。理想的配置是：Created_tmp_disk_tables / Created_tmp_tables * 100% <= 25%.默认为16M，可调到64-256最佳，线程独占，太大可能内存不够I/O堵塞
        + thread_cache_size:可以复用的保存在中的线程的数量。如果有，新的线程从缓存中取得，当断开连接的时候如果有空间，客户的线置在缓存中。如果有很多新的线程，为了提高性能可以这个变量值。通过比较 Connections和Threads_created状态的变量，可以看到这个变量的作用。默认值为110，可调优为80。
            * 线程缓存大小由thread_cache_size系统变量决定。默认值为0（无缓存），这将导致为每个新连接设置一个线程，并在连接终止时需要处理该线程。如果希望服务器每秒接收数百个连接请求，那么应该将thread_cache_size设置的足够高，以便大多数新连接可以使用缓存线程。可以在服务器启动或运行时设置max_connections的值。
            * 还应该监视缓存中的线程数（Threads_cached）以及创建了多少个线程，因为无法从缓存中获取线程（Threads_created）。关于后者，如果Threads_created继续以每分钟多于几个线程的增加，请考虑增加thread_cache_size的值。
            * thread_cache_size：可以缓存的线程数。
            * Threads_cached：缓存中的线程数。
            * Threads_created：创建用于处理连接的线程。
        + 线程和当前连接的客户端之间是一对一的比例。确保线程缓存足够大以容纳所有传入请求是非常重要的。
        + thread_concurrency:推荐设置为服务器 CPU核数的2倍，例如双核的CPU, 那么thread_concurrency的应该为4；2个双核的cpu, thread_concurrency的值应为8。默认为8
* InnoDB的变量
    - innodb_buffer_pool_size:对于InnoDB表来说，innodb_buffer_pool_size的作用就相当于key_buffer_size对于MyISAM表的作用一样。InnoDB使用该参数指定大小的内存来缓冲数据和二级索引，脏数据(已经被更改但没有刷新到硬盘的数据)以及各种内部结构如自适应哈希索引。对于单独的MySQL数据库服务器，最大可以把该值设置成物理内存的80%。根据MySQL手册，对于2G内存的机器，推荐值是1G（50%）。
    - innodb_flush_log_at_trx_commit:主要控制了innodb将log buffer中的数据写入日志文件并flush磁盘的时间点，取值分别为0、1、2三个。0，表示当事务提交时，不做日志写入操作，而是每秒钟将log buffer中的数据写入日志文件并flush磁盘一次；1，则在每秒钟或是每次事物的提交都会引起日志文件写入、flush磁盘的操作，确保了事务的ACID；设置为2，每次事务提交引起写入日志文件的动作，但每秒钟完成一次flush磁盘操作。实际测试发现，该值对插入数据的速度影响非常大，设置为2时插入10000条记录只需要2秒，设置为0时只需要1秒，而设置为1时则需要229秒。因此，MySQL手册也建议尽量将插入操作合并成一个事务，这样可以大幅提高速度。根据MySQL手册，在允许丢失最近部分事务的危险的前提下，可以把该值设为0或2。
    - innodb_log_buffer_size:log缓存大小，一般为1-8M，默认为1M，对于较大的事务，可以增大缓存大小。可设置为4M或8M。
    - innodb_additional_mem_pool_size:该参数指定InnoDB用来存储数据字典和其他内部数据结构的内存池大小。缺省值是1M。通常不用太大，只要够用就行，应该与表结构的复杂度有关系。如果不够用，MySQL会在错误日志中写入一条警告信息。根据MySQL手册，对于2G内存的机器，推荐值是20M，可适当增加。
    - innodb_thread_concurrency=8:推荐设置为 2*(NumCPUs+NumDisks)，默认一般为8
    - INNODB_LOG_FILE_SIZE:
* 不要在命令行中输入密码 `mysql -u root -p`

```sh
chmod 644 /etc/my.cnf # 文件 /etc/my.conf 只能由 root 用户修改
cat /dev/null > ~/.mysql_history # 删除 MySQL shell 历史

bind-address = 127.0.0.1 # 将限制来自远程机器的访问，它告诉 MySQL 服务器只接受来自本地主机的连接
local-infile=0 # 使用下面的指令以防止在 [mysqld] 部分从 MySQL 中访问底层文件系统。

[client]
datadir="F:/wamp/mysql/data"
default-character-set = utf8
default-collation=utf8_general_ci

[mysqld]
default-storage-engine = INNODB
character-set-server = utf8
collation-server = utf8_general_ci
Port=5000 # 修改端口号
log=/var/log/mysql.log # 了解服务运行过程中发生了什么的最好的方法之一

log-slow-queries=/data/mysqldata/slow-query.log # 慢查询日志存放的位置，一般这个目录要有mysql的运行帐号的可写权限，一般都将这个目录设置为mysql的数据存放目录；
long_query_time=2     # 表示查询超过两秒才记录
log-queries-not-using-indexes  # 表示记录下没有使用索引的查询

innodb_buffer_pool_size # 如果是单实例且绝大多数是InnoDB引擎表的话，可考虑设置为物理内存的50% ~ 70%左右
innodb_data_file_path = ibdata1:1G:autoextend # 千万不要用默认的10M，否则在有高并发事务时，会受到不小的影响
innodb_log_file_size=256M
innodb_log_files_in_group=2，基本可满足90%以上的场景

transaction-isolation = REPEATABLE-READ # 全局事物隔离级别
max_connection_error（最大错误数，建议设置为10万以上，而open_files_limit、innodb_open_files、table_open_cache、table_definition_cache这几个参数则可设为约10倍于max_connection的大小
```

```sql
SHOW VARIABLES LIKE "character_%";
character_set_client # 接受的客户端编码
character_set_result # 返回结果集的编码
SET character_set_client=GBK; # 不一致的话,修改
set names gbk # 修改client connection results字符集

# 出现ERROR 1040: Too many connections错误,修正max_connections的值
show variables like 'max_connections';  # 最大连接数
show  status like 'max_used_connections'; # 响应的连接数

show full processlist; #

show variables like 'key_buffer_size'; 
show global status like 'key_read%'; # 请求在内存中没有找到直接从硬盘读取索引

SHOW GLOBAL STATUS LIKE '%Threads_connected%';
SHOW GLOBAL STATUS LIKE '%Threads_runing%';

SHOW STATUS LIKE 'Qcache%';
show global status like 'qcache%';
show variables like 'query_cache%';

show global status like 'created_tmp%';

show variables like "general_log%";  # 记录操作,pdo执行过程
set global general_log = on;
```

### 用户管理

命令行操作

```sql
mysql -h localhost  -P 3306 -u root -p  # 生成用户root与空密码登陆,第一次登陆mysql的时候是没有密码的
exit quit \q

use mysql;
update user SET Password = PASSWORD('密码') where User = 'root';
FLUSH PRIVILEGES;
exit;

CREATE USER 'www'@'localhost' IDENTIFIED BY '123456aC$'; # 添加用户
GRANT ALL PRIVILEGES ON blog.* TO 'jeff'@'localhost';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root密码' WITH GRANT OPTION;
FLUSH PRIVILEGES;
```

### 存储引擎

不同数据引擎数据的存储格式

* Myisam:表结构 数据 索引文件分离。适合于一些需要大量查询的应用，但其对于有大量写操作并不是很好。甚至你只是需要update一个字段，整个表都会被锁起来，而别的进程，就算是读进程都 无法操作直到读操作完成。

  - 表锁：myisam 表级锁 表锁，只有读读之间是并发的，写写之间和读写之间（读和插入之间是可以并发的，去设置concurrent_insert参数，定期执行表优化操作，更新操作就没有办法了）是串行的，所以写起来慢，并且默认的写优先级比读优先级高，高到写操作来了后，可以马上插入到读操作前面去，如果批量写，会导致读请求饿死，所以要设置读写优先级或设置多少写操作后执行读操作的策略;myisam不要使用查询时间太长的sql，如果策略使用不当，也会导致写饿死，所以尽量去拆分查询效率低的sql,
  - 读的效果好，写的效率差，这和它数据存储格式，索引的指针和锁的策略有关的，它的数据是顺序存储的.索引btree上的节点是一个指向数据物理位置的指针，所以查找起来很快
  - 对于 SELECT COUNT(*) 这类的计算是超快无比的(不含where条件)
  - 不支持自动恢复数据：断电之后 使用之前检查和执行可能的修复
  - 不支持事务：不保证单个命令会完成, 多行update 有错误 只有一些行会被更新
  - 只有索引缓存在内存中：mysiam只缓存进程内部的索引
  - 紧密存储：行被仅仅保存在一起

* Innodb:综合一个文件,写满后递增文件夹。用于在写操作比较多的时候
    - 支持事务、行级锁、并发性能更好、CPU及内存缓存页优化使得资源利用率更高（推荐）
    - 数据存储方式是聚簇索引,索引节点存的则是数据的主键，所以需要根据主键二次查找
    - 事务性：Innodb支持事务和四种事务隔离级别
    - 外键：Innodb唯一支持外键的存储引擎 create table 命令接受外键
    - 行级锁：锁设定于行一级 有很好的并发性。sql用到索引的时候，行锁是加在索引上的，不是加在数据记录上的，如果sql没有用到索引，仍然会锁定表,mysql的读写之间是可以并发的，普通的select是不需要锁的，当查询的记录遇到锁时，用的是一致性的非锁定快照读，也就是根据数据库隔离级别策略，会去读被锁定行的快照，其它更新或加锁读语句用的是当前读，读取原始行；因为普通读与写不冲突，所以innodb不会出现读写饿死的情况，又因为在使用索引的时候用的是行锁，锁的粒度小，竞争相同锁的情况就少，就增加了并发处理，所以并发读写的效率还是很优秀的，问题在于索引查询后的根据主键的二次查找导致效率低；
    - MySQL InnoDB默认行级锁。行级锁都是基于索引的，如果一条SQL语句用不到索引是不会使用行级锁的，会使用表级锁把整张表锁住
    - 多版本：多版本并发控制
    - 按照主键聚集：索引按照主键聚集
    - 所有的索引包含主键列：索引按照主键引用行 如果不把主键维持很短 索引就增长很大
    - 优化的缓存：Innodb把数据和内存缓存到缓冲池 自动构建哈希索引
    - 未压缩的索引：索引没有使用前缀压缩，阻塞auto_increment:Innodb使用表级锁产生新的auto_increment
    - 没有缓存的count():myisam 会把行数保存在表中 Innodb中的count()会全表或索引扫描
    - 实现的是基于多版本的并发控制协议——MVCC (Multi-Version Concurrency Control) 加上间隙锁（next-key locking）策略在Repeatable Read (RR)隔离级别下不存在幻读。如果测试幻读，在MyISAM下实验。
    - 在聚集索引（主键索引）中，如果有唯一性约束，InnoDB会将默认的next-key lock降级为record lock。
    - Innodb在做任何操作时，会做一个日志操作，便于恢复。
    - 备份方式稍微复杂一点，如果是innodb引擎如何去备份。xtradb是innodb存储引擎的增强版本，更高性能环境下的新特性。

```sql
show engines; # 显示当前数据库支持的存储引擎情况
```

### 数据类型

* 整型：
    - tinyint 0-255 或 -2^7~2^7-1 1个字节
    - smallint -2^15~2^15-1 2个字节
    - mediumint -2^23~2^23-1 3个字节
    - int 0-2^32-1 4个字节
    - bigint 0-2^64-1 8个字节
    - unsigned:无符号数
    - 显示宽度int(11):最小显示位数(默认不起作用),zerofill会用0填充,不决定数据大小
* 浮点型(M代表总长度(不含小数点)，D代表小数位数),精度会丢失,不要作比较：
    - float(M,D) (论上可以保留7位小数) 3.4E+38~3.4E+38 4个字节
    - double(M,D) (理论上保留15位小数) -1.8E+308~1.8E+308 8个字节
* 定点数:decimal(M,D)，M的最大值是65，D的最大值是30，默认是（10,0）,用于保存精确的小数
    - 注意:定点数的值是正确的，浮点数会失去精度。浮点数的执行效率要高于定点数。浮点数和定点数支持显示宽度，支持无符号
* **字符** 类型：
    - char(M) 固定长度 0-255个字符 char(11) //最多只能存储11个字节
    - varchar(M) 自动伸缩型:比固定长度类型占用更少的存储空间，只占用需要的空间,使用额外的1到2字节存储长度，列小于255使用1字节保存长度，大于255使用2字节保存，varchar保留字符串末尾的空格 0-65535个字节 M为字符个数，M为最大值
    - blob和text唯一区别就是blob保存二进制数据、没有字符集和排序规则。
    - tinytext: 2^8-1
    - text 2^16-1
    - mediumtext 中型文本型 2^24-1 0－1677个字符
    - longtext 大型文本 2^32-1 0-42亿个字符
* 日期时间(发布日期"这样的数据时，请用时间戳来存)：
    - date 2015-10-20
    - time 10:09:08
    - datetime 保存是1001年到9999年，精度是秒，存储值为 2016-05-06 22:39:40。
    - timestamp保存自 1970年1月1日午夜以来的秒数，和unix时间戳相同，提供4字节存储 只能表示1970年到2038年。默认timestamp值 为 NOT NULL。
    - 默认值：datetime or timestrap 默认值 CURRENT_TIMESTAMP
* ip:通常使用varchar(15)保存IP地址.inet_aton() inet_ntoa()用于转换

### 字段属性

* NOT NULL | NULL，该列在添加数据时，是否可以为空。
* DEFAULT value，给该列定一个默认值。value的值只能是整型、字符型。
* DEFAULT 1 ，默认值为整型
* DEFAULT "男" ，默认值为字符型
* PRIMARY KEY，指定该列主键，值是唯一的，不能重复。
* AUTO_INCREMENT，指定列的值是自动增长型。 注意：一个数据表，只能有一个主键和一个自动增长型。 提示：数据表的id字段，必须要有 not null primary key auto_incremtn 这三个属性。
* 查询条件
    - 字段列表：指要显示指定列的数据，多个字段之间用逗号隔开，各字段之间没有顺序。*：显示所有字段的数据
    - ORDER BY排序
    - LIMIT限制返回
    - 运算符：＝ ＜ ＞ ＜＝ ＞＝ !＝ ＜＞ is not null IS NULL
    - BETWEEN 1 AND 20:WHERE date BETWEEN '2016-05-10' AND '2016-05-14';
    - IN / NOT IN：
    - LIKE('name%') NOT LIKE('name%')：
    - % 替代 0 个或多个字符
    - _ 替代一个字符
    - [charlist] 字符列中的任何单一字符
    - [^charlist]或[!charlist] 不在字符列中的任何单一字符 WHERE name REGEXP '^[GFs]'；name REGEXP '^[^A-H]';
    - 逻辑运算: AND & OR(可以混合使用)
* 别名：涉及超过一个表；在查询中使用了函数；列名称很长或者可读性差；需要把两个列或者多个列结合在一起
* 添加注释

```sql
SHOW DATABASES;
USE db_name; # 可以不切换数据库的情况下操作数据表

CREATE DATABASE IF NOT EXISTS db_name CHARSET utf8 COLLATE utf8_unicode_ci;  # 特殊符号、关键字表名加``
ALTER DATABASE db_name charset=utf8;
DROP DATABASE [IF EXISTS] db_name;
SHOW CREATE DATABASE db_name;

SHOW TABLES;
# CREATE TABLE table_name(col_name  type  attribute , col_name  type  attribute,…… );
CREATE TABLE test.news(
  id int NOT null AUTO_INCREMENT primary KEY,
  title varchar(100) not null comment '名称',
  author varchar(20) not null comment '作者',
  source varchar(30) not null comment '来源',
  hits int(5) not null DEFAULT 0 comment '点击率',
  context text null comment '内容',
  adddate int(16) not null comment '添加时间',
  PRIMARY KEY (Id)
)charset=utf8 collate=utf8_bin;
CREATE TABLE table_name SELECT column1,cloumn2 FROM another_table: # 复制数据不复制主键
CREATE TABLE table_name like another_table；  #  数据不复制，主键复制
DESCRIBE news;
DESC news;
SHOW CREATE TABELE news\G;

ALTER TABLE table_name ADD address varchar(30) first| after name; #  修改数据表
ALTER TABLE table_name DROP address;
ALTER TABLE table_name MODIFY address varchar(100);  # 修改属性
ALTER TABLE table_name CHANGE address add varchar(100) after id; # 修改字段名字
ALTER TABLE table_name engine=myisam;
ALTER TABLE table_name rename to new_table_name;
ALTER TABLE table_name rename to another_DB.new_table_name; # 移动表
ALTER TABLE 'table_name' ADD PRIMARY KEY'index_name' ('column');
ALTER TABLE 'table_name' ADD UNIQUE 'index_name' ('column');
ALTER TABLE 'table_name' ADD INDEX'index_name' ('column');
ALTER TABLE 'table_name' ADD FULLTEXT 'index_name' ('column');
ALTER TABLE 'table_name' ADD INDEX 'index_name' ('column1', 'column2', ...);

SELECT [DISTINCT] 字段列表|* FROM table_name [WHERE条件][ORDER BY排序(默认是按id升序排列)][LIMIT (startrow ,) pagesize];

select id,title,author,hits,addate from news ORDER BY id DESC LIMIT 10,10; # limit [offset,]rowcount:offset 为偏移量，而非主键id
SELECT * FROM rp_evaluate LIMIT 500 *$i,500
SELECT `rp_e_id`,`evaluate` FROM `rp_evaluate` WHERE `rp_e_id` > 0 LIMIT 500
SELECT column_name AS alias_name FROM table_name;
SELECT column_name(s) FROM table_name AS alias_name; SELECT w.name, w.url, a.count, a.date FROM Websites AS w, access_log AS a WHERE a.site_id=w.id and w.name="菜鸟教程";
select conact('a', 'b')
select conact_ws(',', 'a', 'b')
SELECT GROUP_CONCAT(c_name) FROM categories WHERE school_id =1 # 字符拼接

INSERT INTO table_name (字段1,字段2,字段3,…) VALUES (值1,值2,值3,…);   # 记录操作：添加 更新与删除数据(新增与修改不用添加TABLE关键字)
INSERT INTO table_name values (null,值,....); # 全字段插入，自动增长列用null
INSERT INTO table_name values (null,值,....),(null,值,....),(null,值,....); # 插入多条数据
INSERT INTO table_name set volumn1=value1,volumn3=value3,volumn3=value3;
UPDATE table_name  SET 字段1 = 新值1, 字段2 = 新值2  [WHERE条件];
DELETE FROM table_name [WHERE条件];

DROP TABLE [IF EXISTS] db_name;
DELETE FROM table_name;  # 清空数据表：数据一条条删除
TRUNCATE TABLE table_name;  # 删除表,重建同结构
```

### 联表

表与表之间通过公共字段建立关系

* 公共字段名字可以不一样，但是数据类型必须一样
* 联表查询降低查询速度。
* 数据冗余与查询速度的平衡

## 高性能表设计规范

良好的逻辑设计和物理设计是高性能的基石， 应该根据系统将要执行的查询语句来设计schema, 这往往需要权衡各种因素。

* 库名、表名、字段名：小写，下划线风格，不超过32个字符，必须见名知意，禁止拼音英文混用
* 表名t_xxx，非唯一索引名idx_xxx，唯一索引名uniq_xxx
* 单实例表数目必须小于500
* 单表列数目必须小于30
* 表必须有主键，例如自增主键

### 数据类型

* 更小的通常更好：更小的数据类型通常更快，占用更少的磁盘、 内存和CPU缓存， 并且处理时需要的CPU周期也更少。
* 简单就好： 简单数据类型的操作通常需要更少的CPU周期。 例如， 整型比字符操作代价更低， 因为字符集和校对规则（排序规则 ）使字符比较比整型比较更复杂。
* 尽量避免NULL： 如果查询中包含可为NULL 的列， 对MySQL来说更难优化， 因为可为NULL 的列 使得索引、 索引统计和值比较都更复杂。 可为 N ULL的列会使用更多的存储空间， 在MySQL里也需要特殊处理。 当可为NULL的列被索引时， 每个索引记录需要一个额 外的字节， 在MyISAM 里甚至还可能导致固定大小的索引（例如只有一个整数列的索引）变成可变大小的索引。例外， lnnoDB 使用单独的位 (bit) 存储NULL 值， 所以对于稀疏数据有很好的空间效率。
* 整数类型
    - 有两种类型的数字：整数 (whole number) 和实数 (real number) 。 如果存储整数， 可以使用这几种整数类型：TINYINT, SMALLINT, MEDIUMINT, INT, BIGINT。分别使用8,16, 24, 32, 64位存储空间。 整数类型有可选的 UNSIGNED 属性，表示不允许负值，这大致可以使正数的上限提高一倍。 例如 TINYINT. UNSIGNED 可以存储的范围是 0 - 255, 而 TINYINT 的存储范围是 -128 -127 。有符号和无符号类型使用相同的存储空间，并具有相同的性能 ， 因此可以根据实际情况选择合适的类型。 你的选择决定 MySQL 是怎么在内存和磁盘中保存数据的。 然而， 整数计算一般使用64 位的 BIGINT 整数， 即使在 32 位环境也是如此。（ 一些聚合函数是例外， 它们使用DECIMAL 或 DOUBLE 进行计算）。 MySQL 可以为整数类型指定宽度， 例如 INT(11), 对大多数应用这是没有意义的：它不会限制值的合法范围，只是规定了MySQL 的一些交互工具（例如 MySQL 命令行客户端）用来显示字符的个数。 对千存储和计算来说， INT(1) 和 INT(20) 是相同的。
* 实数类型 实数是带有小数部分的数字。 然而， 它们不只是为了存储小数部分，也可以使用DECIMAL 存储比 BIGINT 还大的整数。 FLOAT和DOUBLE类型支持使用标准的浮点运算进行近似计算。 DECIMAL类型用于存储精确的小数。 浮点和DECIMAL类型都可以指定精度。 对千DECIMAL列， 可以指定小数点前后所允许的 最大位数。这会影响列的空间消耗。 有多种方法可以指定浮点列所需要的精度， 这会使得MySQL悄悄选择不同的数据类型，或者在存储时对值进行取舍。 这些精度定义是非标准的， 所以我们建议只指定数据类型，不指定精度。 浮点类型在存储同样范围的值时， 通常比DECIMAL使用更少的空间。FLOAT使用4个字节存储。DOUBLE占用8个字节，相比FLOAT有更高的精度和更大的范围。和整数类型一样， 能选择的只是存储类型； MySQL使用DOUBLE作为内部浮点计算的类型。 因为需要额外的空间和计算开销，所以应该尽扯只在对小数进行精确计算时才使用DECIMAL。 但在数据最比较大的时候， 可以考虑使用BIGINT代替DECIMAL, 将需要存储的货币单位根据小数的位数乘以 相应的倍数即可。
* 字符串类型 VARCHAR 用于存储可变⻓字符串，长度支持到65535 需要使用1或2个额外字节记录字符串的长度 适合：字符串的最大⻓度比平均⻓度⼤很多；更新很少 CHAR 定⻓，⻓度范围是1~255 适合：存储很短的字符串，或者所有值接近同一个长度；经常变更 慷慨是不明智的 使用VARCHAR(5)和VARCHAR(200)存储'hello'的空间开销是一样的。 那么使用更 短的列有什么优势吗？ 事实证明有很大的优势。 更长的列会消耗更多的内存， 因为MySQL通常会分配固定大小的内存块来保存内部值。 尤其是使用内存临时表进行排序或操作时会特别糟糕。 在利用磁盘临时表进行排序时也同样糟糕。 所以最好的策略是只分配真正需要的空间。 4.BLOB和TEXT类型 BLOB和 TEXT都是为存储很大的数据而设计的字符串数据类型， 分别采用 二进制和字符方式存储 。 与其他类型不同， MySQL把每个BLOB和TEXT值当作一个独立的对象处理。 存储引擎 在存储时通常会做特殊处理。 当BLOB和TEXT值太大时，InnoDB会使用专门的 "外部"存储区域来进行存储， 此时每个值在行内需要1 - 4个字节存储 存储区域存储实际的值。 BLOB 和 TEXT 之间仅有的不同是 BLOB 类型存储的是二进制数据， 没有排序规则或字符集， 而 TEXT类型有字符集和排序规则
* 日期和时间类型 大部分时间类型 都没有替代品， 因此没有什么是最佳选择的问题。 唯一的问题是保存日期和时间的时候需要做什么。 MySQL提供两种相似的日期类型： DATE TIME和 TIMESTAMP。 但是目前我们更建议存储时间戳的方式，因此该处不再对 DATE TIME和 TIMESTAMP做过多说明。
* 其他类型 5.1选择标识符 在可以满足值的范围的需求， 井且预留未来增长空间的前提下， 应该选择最小的数据类型。 整数类型 整数通常是标识列最好的选择， 因为它们很快并且可以使用AUTO_INCREMENT。 ENUM和SET类型 对于标识列来说，EMUM和SET类型通常是一个糟糕的选择， 尽管对某些只包含固定状态或者类型的静态 "定义表" 来说可能是没有问题的。ENUM和SET列适合存储固定信息， 例如有序的状态、 产品类型、 人的性别。 字符串类型 如果可能， 应该避免使用字符串类型作为标识列， 因为它们很消耗空间， 并且通常比数字类型慢。 对千完全 "随机" 的字符串也需要多加注意， 例如 MDS() 、 SHAl() 或者 UUID() 产生的字符串。 这些函数生成的新值会任意分布在很大的空间内， 这会导致 INSERT 以及一些SELECT语句变得很慢。如果存储 UUID 值， 则应该移除 "-"符号。 5.2特殊类型数据 某些类型的数据井不直接与内置类型一致。 低千秒级精度的时间戳就是一个例子，另一个例子是以个1Pv4地址，人们经常使用VARCHAR(15)列来存储IP地址，然而， 它们实际上是32位无符号整数， 不是字符串。用小数点将地址分成四段的表示方法只是为了让人们阅读容易。所以应该用无符号整数存储IP地址。MySQL提供INET_ATON()和INET_NTOA()函数在这两种表示方法之间转换。
* 必须把字段定义为NOT NULL并且提供默认值
    - ull的列使索引/索引统计/值比较都更加复杂，对MySQL来说更难优化
    - null 这种类型MySQL内部需要进行特殊处理，增加数据库处理记录的复杂性；同等条件下，表中有较多空字段的时候，数据库的处理性能会降低很多
    - null值需要更多的存储空，无论是表还是索引中每行中的null的列都需要额外的空间来标识
    - 对null 的处理时候，只能采用is null或is not null，而不能采用=、in、<、<>、!=、not in这些操作符号。
* 止使用TEXT、BLOB类型：会浪费更多的磁盘和内存空间，非必要的大量的大字段查询会淘汰掉热数据，导致内存命中率急剧降低，影响数据库性能
* 必须使用varchar(20)存储手机号：涉及到区号或者国家代号，可能出现+-()，varchar可以支持模糊查询，例如：like“138%”
* 禁止使用ENUM，可使用TINYINT代替：增加新的ENUM值要做DDL操作；ENUM的内部实际存储就是整数，你以为自己定义的是字符串？

### 表结构设计

* 范式和反范式：对千任何给定的数据通常都有很多种表示方法， 从完全的范式化到完全的反范式化， 以及两者的折中。 在范式化的数据库中， 每个事实数据会出现并且只出现一次。 相反， 在反范式化的数据库中， 信息是冗余的， 可能会存储在多个地方。
    - 范式的优点和缺点：为性能提升考虑时，经常会被建议对 schema 进行范式化设计，尤其是写密集的场景。
    - 范式化的更新操作通常比反范式化要快。
    - 当数据较好地范式化时，就只有很少或者没有重复数据，所以只需要修改更少的数据。
    - 范式化的表通常更小，可以更好地放在内存里，所以执行操作会更快。
    - 很少有多余的数据意味着检索列表数据时更少需要 DISTINCT 或者 GROUP BY语句。
    - 反范式的优点和缺点：不需要关联表，则对大部分查询最差的情况----即使表没有使用索引----是全表扫描。 当数据比内存大时这可能比关联要快得多，因为这样避免了随机I/0。 单独的表也能使用更有效的索引策略。 混用范式化和反范式化 在实际应用中经常需要混用，可能使用部分范式化的 schema 、 缓存表，以及其他技巧。 表适当增加冗余字段，如性能优先，但会增加复杂度。可避免表关联查询。

简单熟悉数据库范式 第一范式(1NF)：字段值具有原子性,不能再分(所有关系型数据库系统都满足第一范式); 例如：姓名字段,其中姓和名是一个整体,如果区分姓和名那么必须设立两个独立字段; 第二范式(2NF)：一个表必须有主键,即每行数据都能被唯一的区分; 备注：必须先满足第一范式; 第三范式(3NF)：一个表中不能包涵其他相关表中非关键字段的信息,即数据表不能有沉余字段;备注：必须先满足第二范式;

* 表字段少而精
    - I/O高效
    - 字段分开维护简单
    - 单表1G体积 500W⾏行评估
    - 单行不超过200Byte
    - 单表不超过50个INT字段
    - 单表不超过20个CHAR(10)字段
    - 建议单表字段数控制在20个以内
    - 拆分TEXT/BLOB，TEXT类型处理性能远低于VARCHAR，强制生成硬盘临时表浪费更多空间。
* 禁止使用外键，如果有外键完整性约束，需要应用程序控制：外键会导致表与表之间耦合，update与delete操作都会涉及相关联的表，十分影响sql 的性能，甚至会造成死锁。高并发情况下容易造成数据库性能，大数据高并发业务场景数据库使用以性能优先

### Schema设计规范及SQL使用建议 

* 所有的InnoDB表都设计一个无业务用途的自增列做主键，对于绝大多数场景都是如此，真正纯只读用InnoDB表的并不多，真如此的话还不如用TokuDB来得划算；
* 字段长度满足需求前提下，尽可能选择长度小的。此外，字段属性尽量都加上NOT NULL约束，可一定程度提高性能；
* 尽可能不使用TEXT/BLOB类型，确实需要的话，建议拆分到子表中，不要和主表放在一起，避免SELECT * 的时候读性能太差。
* 读取数据时，只选取所需要的列，不要每次都SELECT *，避免产生严重的随机读问题，尤其是读到一些TEXT/BLOB列；
* 对一个VARCHAR(N)列创建索引时，通常取其50%（甚至更小）左右长度创建前缀索引就足以满足80%以上的查询需求了，没必要创建整列的全长度索引；
* 通常情况下，子查询的性能比较差，建议改造成JOIN写法；
* 多表联接查询时，关联字段类型尽量一致，并且都要有索引；
* 多表连接查询时，把结果集小的表（注意，这里是指过滤后的结果集，不一定是全表数据量小的）作为驱动表；
* 多表联接并且有排序时，排序字段必须是驱动表里的，否则排序列无法用到索引；
* 多用复合索引，少用多个独立索引，尤其是一些基数（Cardinality）太小（比如说，该列的唯一值总数少于255）的列就不要创建独立索引了；
* 类似分页功能的SQL，建议先用主键关联，然后返回结果集，效率会高很多；

## group by

查询松散索引扫描（Loose Index Scan）与紧凑索引扫描（Tight Index Scan）[链接]（<http://isky000.com/database/mysql_group_by_implement）>

- 正常流程 group by操作在没有合适的索引可用的时候，通常先扫描整个表提取数据并创建一个临时表，然后按照group by指定的列进行排序。在这个临时表里面，对于每一个group的数据行来说是连续在一起的。完成排序之后，就可以发现所有的groups，并可以执行聚集函数（aggregate function）。可以看到，在没有使用索引的时候，需要创建临时表和排序。在执行计划中通常可以看到"Using temporary; Using filesort"。
- 通过索引 MySQL建立的索引（B+Tree）通常是有序的，如果通过读取索引就完成group by操作，那么就可避免创建临时表和排序。因而使用索引进行group by的最重要的前提条件是所有group by的参照列（分组依据的列）来自于同一个索引，且索引按照顺序存储所有的keys（即BTREE index，而HASH index没有顺序的概念）。松散索引扫描和紧凑索引扫描的最大区别是是否需要扫描整个索引或者整个范围扫描。
- 松散索引扫描方式下，分组操作和范围预测（如果有的话）一起执行完成的。不需要连续的扫描索引中得每一个元组，扫描时仅考虑索引中得一部分。当查询中没有where条件的时候，松散索引扫描读取的索引元组的个数和groups的数量相同。如果where条件包含范围预测，松散索引扫描查找每个group中第一个满足范围条件，然后再读取最少可能数的keys。松散索引扫描只需要读取很少量的数据就可以完成group by操作，因而执行效率非常高，执行计划中Etra中提示" using index for group-by"。松散索引扫描可以作用于在select list中其它形式的聚集函数，除了min()和max()之外，还支持：

1）AVG(DISTINCT), SUM(DISTINCT)和COUNT(DISTINCT)可以使用松散索引扫描。AVG(DISTINCT), SUM(DISTINCT)只能使用单一列作为参数。而COUNT(DISTINCT)可以使用多列参数。 2）在查询中没有group by和distinct条件。 3）之前声明的松散扫描限制条件同样起作用。

符合一下条件

- 查询在单一表上。
- group by指定的所有列是索引的一个最左前缀，并且没有其它的列。比如表t1（ c1,c2,c3,c4）上建立了索引（c1,c2,c3）。如果查询包含"group by c1,c2"，那么可以使用松散索引扫描。但是"group by c2,c3"(不是索引最左前缀)和"group by c1,c2,c4"(c4字段不在索引中)。
- 如果在选择列表select list中存在聚集函数，只能使用 min()和max()两个聚集函数，并且指定的是同一列（如果min()和max()同时存在）。这一列必须在索引中，且紧跟着group by指定的列。比如，select t1,t2,min(t3),max(t3) from t1 group by c1,c2。
- 如果查询中存在除了group by指定的列之外的索引其他部分，那么必须以常量的形式出现（除了min()和max()两个聚集函数）。比如，select c1,c3 from t1 group by c1,c2不能使用松散索引扫描。而select c1,c3 from t1 where c3 = 3 group by c1,c2可以使用松散索引扫描。
- 索引中的列必须索引整个数据列的值(full column values must be indexed)，而不是一个前缀索引。比如，c1 varchar(20), INDEX (c1(10)),这个索引没发用作松散索引扫描。

- 紧凑索引扫描方式下，先对索引执行范围扫描（range scan），再对结果元组进行分组。可能是全索引扫描或者范围索引扫描，取决于查询条件。当松散索引扫描条件没有满足的时候，group by仍然有可能避免创建临时表。如果在where条件有范围扫描，那么紧凑索引扫描仅读取满足这些条件的keys（索引元组），否则执行全索引扫描。这种方式读取所有where条件定义的范围内的keys，或者扫描整个索引。紧凑索引扫描，只有在所有满足范围条件的keys被找到之后才会执行分组操作。

在查询中存在常量相等where条件字段（索引中的字段），且该字段在group by指定的字段的前面或者中间。来自于相等条件的常量能够填充搜索keys中的gaps，因而可以构成一个索引的完整前缀。索引前缀能够用于索引查找。如果要求对group by的结果进行排序，并且查找字段组成一个索引前缀，那么MySQL同样可以避免额外的排序操作。 c2在c1,c3之前，c2='a'填充这个坑，组成一个索引前缀，因而能够使用紧凑索引扫描。 select c1,c2,c3 from t1 where c2 = 'a' group by c1,c3 c1在索引的最前面，c1=a和group by c2,c3组成一个索引前缀，因而能够使用紧凑索引扫描。 select c1,c2,c3 from t1 where c1 = 'a' group by c2,c3 使用紧凑索引扫描，执行计划Extra一般显示"using index"，相当于使用了覆盖索引。

## 方法

- 字符串方法

  - left()
  - right()
  - substr()
  - instr()

## 问题处理

- top 查看进程消耗
- 进入mysql show processlist
- threads_running/QPS/TPS
- 慢查询
- MySQL profile工具
- orzdba

## 中间件

数据库中间件的优劣，一方面有一些通用的指标，另一方面还是要结合业务特点，包括业务的读写 qps ， 涉及的库表结构和SQL语句，来进行综合的判断。综合来看，我认为应该包括这几个方面：

- 基本的功能是否完善。数据库中间件的两个主要功能是分库分表和读写分离，一般的数据库中间件，都满足。但是再进一步剖析，分库分表和读写分离，还是有不少细节需要去研究的。 比如，分库分表功能是能够做到一级划分（只根据一个字段来做分区），还是能够做到二级划分（能够根据两个字段来做分区），划分的形式是否多样（常见有 range、list、hash 方式），划分字段的类型是否能支持多种（比如是只支持根据数值类型字段做划分，还是可以根据数值、字符串、日期类型做划分）。能否提供避免数据倾斜的分区方式等。 对于读写分离功能，细分来看，也包括两种，一种是透明的读写分离，这种功能能够100%兼容 Mysql 或其他数据库的 SQL 语法，同时对于事务也能够正确处理（事务的 SQL 能够路由到主节点，而不是分散到主节点和只读节点）； 另一种是简单的读写分离，对 SQL 的支持范围，只限于数据库中间件内置的 SQL 解释器，有些复杂 SQL 是支持不了的，同时对于事务，也做不到很好的支持。 同时，对读请求的分流策略，也是读写分离功能一个考量点。简单的读写分离功能只是把写发往主节点，读都发往从节点； 而读写分离功能做得细致的话，数据库中间件会能够提供对分流策略的自定义。比如设置为：把30%的读流量，分流到主节点，70%的读流量分流到只读节点。
- 产品的成熟度、用户的使用情况和社区（商业公司）支持程度。 数据库中间件虽然本身不做存储，但是每条数据都是要从中经过的，一旦出错，可能对业务造成灾难性的影响，所以软件的正确性和稳定性非常重要。为此，中间件的成熟度、已经使用的客户的使用情况、数量、用户的口碑，以及开源社区或者商业公司对该产品的支持程度，就非常重要。一般来说，发布时间越长而且在持续迭代、用户使用数量众多，且有大规模业务使用，社区（包括 QQ 群）比较活跃，文档完善，bug 解决及时的产品，更值得信赖。
- 产品的易用性，是否配置方便，部署容易，系统管理不会有太大负担。有些中间件模块众多，配置复杂，虽然表面上看起来功能丰富，但业务用到的可能还是最基本的几个功能。选择这样的中间件，即显得不够划算，不仅加重运维负担，同时后续系统的扩展，新业务的支持，也不够敏捷。
- 是否满足自身业务目前的需求，和潜在的需求。 除了上述两个通用的指标，更重要的是必须根据自己业务的库表结构，分库分表/读写分离需求，业务的SQL语句，读写qps，来判断中间件产品的优劣。 比如，绝大部分中间件，目前都不能支持分布式事务和多表join，但是除了对这两种sql不支持，不少中间件，其实在一些基本的sql，比如带系统函数的sql、聚合类sql上，也支持不够好。

为此，在选择中间件时，就需要根据业务的库表结构，sql语句，以及业务特点，去检查中间件是否对业务的目前sql和潜在sql，能够做到比较好的支持。 另外，选择中间件时，一定要自己做性能测试和压力测试，实事求是地自身业务特点来测定中间件的性能和稳定性情况，不要轻信官方或者第三方发布的一些性能数据。中间件产品的最高境界，其实是不需要特别关注中间件，从而可以把精力放在数据库架构、优化和数据库本身的管理上。

中间件产品发展至今，也可以分为两代，第一代是传统的中间件软件，如mysql proxy， mycat， oneproxy，atlas，kingshard等；第二代则是和公有云结合的，基于中间件的分布式数据库，如阿里DRDS、UCloud UDDB，腾讯云DCDB For TDSQL等。目前一代的数据库中间件产品， 比如等，还做不到这一点，使用这些中间件，你还是需要部署中间件模块，做各种配置，系统扩容是还需要停服做数据迁移，需要比较多的时间投入。而二代的，基于中间件的分布式数据库， 对用户呈现的，是一个类似单机数据库一样的操作和管理界面，管理简单，使用方便。以UCloud 的UDDB为例， 在Web控制台上，一步即可创建并配置好中间件和数据库节点，搭建出一个完整的分布式数据库；通过特殊的建表语句， 即可以配置表的水平划分方式。对于中间件复杂的水平扩容问题，可以通过一个按钮即可完成水平扩容操作，期间不停服，只是每隔一段时间有几毫秒到零点几秒的访问中断。

## [语句集锦](https://juejin.im/post/584e7b298d6d81005456eb53)

```sql
# 查询时间
$sql = "select date_format(create_time, '%Y-%m-%d') as day from table_name";
# int 时间戳类型
$sql = "select from_unixtime(create_time, '%Y-%m-%d') as day from table_name";

# 一个sql返回多个总数
$sql = "select count(*) all, " ;
$sql .= " count(case when status = 1 then status end) status_1_num, ";
$sql .= " count(case when status = 2 then status end) status_2_num ";
$sql .= " from table_name";
# Update Join / Delete Join
$sql = "update table_name_1 ";
$sql .= " inner join table_name_2 on table_name_1.id = table_name_2.uid ";
$sql .= " inner join table_name_3 on table_name_3.id = table_name_1.tid ";
$sql .= " set *** = *** ";
$sql .= " where *** ";
# delete join 同上。

# 替换某字段的内容的语句
$sql = "update table_name set content = REPLACE(content, 'aaa', 'bbb') ";
$sql .= " where (content like '%aaa%')";
# 获取表中某字段包含某字符串的数据
$sql = "SELECT * FROM `表名` WHERE LOCATE('关键字', 字段名) ";
# 获取字段中的前4位
$sql = "SELECT SUBSTRING(字段名,1,4) FROM 表名 ";
# 查找表中多余的重复记录
# 单个字段
$sql = "select * from 表名 where 字段名 in ";
$sql .= "(select 字段名 from 表名 group by 字段名 having count(字段名) > 1 )";
# 多个字段
$sql = "select * from 表名 别名 where (别名.字段1,别名.字段2) in ";
$sql .= "(select 字段1,字段2 from 表名 group by 字段1,字段2 having count(*) > 1 )";
# 删除表中多余的重复记录(留id最小)
# 单个字段
$sql = "delete from 表名 where 字段名 in ";
$sql .= "(select 字段名 from 表名 group by 字段名 having count(字段名) > 1)  ";
$sql .= "and 主键ID not in ";
$sql .= "(select min(主键ID) from 表名 group by 字段名 having count(字段名 )>1) ";
# 多个字段
$sql = "delete from 表名 别名 where (别名.字段1,别名.字段2) in ";
$sql .= "(select 字段1,字段2 from 表名 group by 字段1,字段2 having count(*) > 1) ";
$sql .= "and 主键ID not in ";
$sql .= "(select min(主键ID) from 表名 group by 字段1,字段2 having count(*)>1) ";
```

- 业务篇

```sql
# 创建测试表
CREATE TABLE `test_number` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `number` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '数字',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

# 创建测试数据
insert into test_number values(1,1);
insert into test_number values(2,2);
insert into test_number values(3,3);
insert into test_number values(4,5);
insert into test_number values(5,7);
insert into test_number values(6,8);
insert into test_number values(7,10);
insert into test_number values(8,11);

# 求数字的连续范围。
select min(number) start_range,max(number) end_range
from
(
    select number,rn,number-rn diff from
    (
        select number,@number:=@number+1 rn from test_number,(select @number:=0) as number
    ) b
) c group by diff;

# 签到问题

# 创建参考表(模拟数据需要用到)
CREATE TABLE `test_nums` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='参考表';

# 创建测试表
CREATE TABLE `test_sign_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '签到时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='签到历史表';

# 创建测试数据
insert into test_sign_history(uid,create_time)
select ceil(rand()*10000),str_to_date('2016-12-11','%Y-%m-%d')+interval ceil(rand()*10000) minute
from test_nums where id<31;

# 统计每天的每小时用户签到情况
select
    h,
    sum(case when create_time='2016-12-11' then c else 0 end) 11Sign,
    sum(case when create_time='2016-12-12' then c else 0 end) 12Sign,
    sum(case when create_time='2016-12-13' then c else 0 end) 13Sign,
    sum(case when create_time='2016-12-14' then c else 0 end) 14Sign,
    sum(case when create_time='2016-12-15' then c else 0 end) 15Sign,
    sum(case when create_time='2016-12-16' then c else 0 end) 16Sign,
    sum(case when create_time='2016-12-17' then c else 0 end) 17Sign
from
(
    select
        date_format(create_time,'%Y-%m-%d') create_time,
        hour(create_time) h,
        count(*) c
    from test_sign_history
    group by
        date_format(create_time,'%Y-%m-%d'),
        hour(create_time)
) a
group by h with rollup;

# 统计每天的每小时用户签到情况(当某个小时没有数据时，显示0)
select
    h ,
    sum(case when create_time='2016-12-11' then c else 0 end) 11Sign,
    sum(case when create_time='2016-12-12' then c else 0 end) 12Sign,
    sum(case when create_time='2016-12-13' then c else 0 end) 13Sign,
    sum(case when create_time='2016-12-14' then c else 0 end) 14Sign,
    sum(case when create_time='2016-12-15' then c else 0 end) 15Sign,
    sum(case when create_time='2016-12-16' then c else 0 end) 16Sign,
    sum(case when create_time='2016-12-17' then c else 0 end) 17Sign
from
(
    select b.h h,c.create_time,c.c from
     (
        select id-1 h from test_nums where id<=24
     ) b
     left join
     (
        select
         date_format(create_time,'%Y-%m-%d') create_time,
         hour(create_time) h,
         count(*) c
        from test_sign_history
        group by
         date_format(create_time,'%Y-%m-%d'),
         hour(create_time)
      ) c on (b.h=c.h)
) a
group by h with rollup;

# 统计每天的用户签到数据和每天的增量数据
select
        type,
        sum(case when create_time='2016-12-11' then c else 0 end) 11Sign,
        sum(case when create_time='2016-12-12' then c else 0 end) 12Sign,
        sum(case when create_time='2016-12-13' then c else 0 end) 13Sign,
        sum(case when create_time='2016-12-14' then c else 0 end) 14Sign,
        sum(case when create_time='2016-12-15' then c else 0 end) 15Sign,
        sum(case when create_time='2016-12-16' then c else 0 end) 16Sign,
        sum(case when create_time='2016-12-17' then c else 0 end) 17Sign
from
(
        select b.create_time,ifnull(b.c-c.c,0) c,'Increment' type from
        (
            select
             date_format(create_time,'%Y-%m-%d') create_time,
             count(*) c
            from test_sign_history
            group by
             date_format(create_time,'%Y-%m-%d')
        ) b
        left join
        (
            select
             date_format(create_time,'%Y-%m-%d') create_time,
             count(*) c
            from test_sign_history
            group by
             date_format(create_time,'%Y-%m-%d')
        ) c on(b.create_time=c.create_time+ interval 1 day)
    union all
        select
         date_format(create_time,'%Y-%m-%d') create_time,
         count(*) c,
         'Current'
        from test_sign_history
        group by
         date_format(create_time,'%Y-%m-%d')
) a
group by type
order by case when type='Current' then 1 else 0 end desc;

# 模拟不同的用户签到了不同的天数
insert into test_sign_history(uid,create_time)
select uid,create_time + interval ceil(rand()*10) day from test_sign_history,test_nums
where test_nums.id <10 order by rand() limit 150;

# 统计签到天数相同的用户数量
select
    sum(case when day=1 then cn else 0 end) 1Day,
    sum(case when day=2 then cn else 0 end) 2Day,
    sum(case when day=3 then cn else 0 end) 3Day,
    sum(case when day=4 then cn else 0 end) 4Day,
    sum(case when day=5 then cn else 0 end) 5Day,
    sum(case when day=6 then cn else 0 end) 6Day,
    sum(case when day=7 then cn else 0 end) 7Day,
    sum(case when day=8 then cn else 0 end) 8Day,
    sum(case when day=9 then cn else 0 end) 9Day,
    sum(case when day=10 then cn else 0 end) 10Day
from
(
    select c day,count(*) cn
    from
    (
        select uid,count(*) c from test_sign_history group by uid
    ) a
    group by c
) b;

# 统计每个用户的连续签到时间
select * from (
    select d.*,
    @ggid := @cggid,
    @cggid := d.uid,
    if(@ggid = @cggid, @grank := @grank + 1, @grank := 1) grank
    from
    (
        select uid,min(c.create_time) begin_date ,max(c.create_time) end_date,count(*) count from
        (
            select
            b.*,
            @gid := @cgid,
            @cgid := b.uid,
            if(@gid = @cgid, @rank := @rank + 1, @rank := 1) rank,
            b.diff-@rank flag from (
                select
                distinct
                uid,
                date_format(create_time,'%Y-%m-%d') create_time,
                datediff(create_time,now()) diff
                from test_sign_history order by uid,create_time
            ) b, (SELECT @gid := 1, @cgid := 1, @rank := 1) as a
        ) c group by uid,flag
        order by uid,count(*) desc
    ) d,(SELECT @ggid := 1, @cggid := 1, @grank := 1) as e
)f
where grank=1;

# 模糊索引
SELECT nickname
FROM customer
WHERE nickname LIKE '%阳光%'
ORDER BY
  CASE
    WHEN nickname LIKE '阳光' THEN 0
    WHEN nickname LIKE '阳光%' THEN 1
    WHEN nickname LIKE '%阳光' THEN 3
    ELSE 2
  END
```

## 事物

mysql有一个autocommit参数，默认是on，他的作用是每一条单独的查询都是一个事务，并且自动开始，自动提交（执行完以后就自动结束了，如果你要适用select for update，而不手动调用 start transaction，这个for update的行锁机制等于没用，因为行锁在自动提交后就释放了），所以事务隔离级别和锁机制即使你不显式调用start transaction，这种机制在单独的一条查询语句中也是适用的

加锁阶段：在该阶段可以进行加锁操作。在对任何数据进行读操作之前要申请并获得S锁（共享锁，其它事务可以继续加共享锁，但不能加排它锁），在进行写操作之前要申请并获得X锁（排它锁，其它事务不能再获得任何锁）。加锁不成功，则事务进入等待状态，直到加锁成功才继续执行。
解锁阶段：当事务释放了一个封锁以后，事务进入解锁阶段，在该阶段只能进行解锁操作不能再进行加锁操作。

这种方式虽然无法避免死锁，但是两段锁协议可以保证事务的并发调度是串行化（串行化很重要，尤其是在数据恢复和备份的时候）的。

### 隔离

事务的隔离级别其实都是对于读数据的定义。四个级别逐渐增强，每个级别解决一个问题。事务级别越高,性能越差,大多数环境read committed 可以用，四种隔离级别：

* 未提交读(Read Uncommitted)：允许脏读，也就是可能读取到其他会话中未提交事务修改的数据。
    - 事物一可以获取事物二中未提交的修改。
    - 事物一中未提交的修改事物（添加共享锁），事物二同样数据修改会被挂起，等待事物一commit；
* 提交读(Read Committed)：只能读取到已经提交的数据，Oracle等多数数据库默认都是该级别。后会造成事务一在同一个transaction中两次读取到的数据不同，这就是不可重复读问题。并且在对表进行修改时，会对表数据行加上行共享锁
    - 数据的读取都是不加锁的，但是数据的写入、修改和删除是需要加锁的。
* 可重复读(Repeated Read)：可重复读。在同一个事务内的查询都是事务开始时刻一致的，InnoDB默认级别。在SQL标准中，该隔离级别消除了不可重复读，但是还存在幻读。
    - 可重读这个概念是一事务的多个实例在并发读取数据时，会看到同样的数据行
    - 当两个事务同时进行时，其中一个事务修改数据对另一个事务不会造成影响，即使修改的事务已经提交也不会对另一个事务造成影响。
    - 两个事物：事物二修改提交后，事物一不提交无法获取事物二的更新；事物一的修改未提交，事物二的修改无法成功等待事物一提交或者超时；
    - 读到的数据可能是历史数据，是不及时的数据，不是数据库当前的数据
    - 对于这种读取历史数据的方式，我们叫它快照读 (snapshot read)，而读取数据库当前版本数据的方式，叫当前读 (current read)
* 串行读(Serializable)：完全串行化的读，每次读都需要获得表级共享锁，读写相互都会阻塞。
    - 读加共享锁，写加排他锁，读写互斥。使用的悲观锁的理论，实现简单，数据更加安全，但是并发能力非常差。如果你的业务并发的特别少或者没有并发，同时又要求数据及时可靠的话，可以使用这种模式。
    - 不要看到select就说不会加锁了，在Serializable这个级别，还是会加锁的！

脏读：脏读就是指当一个事务正在访问数据，并且对数据进行了修改，而这种修改还没有提交到数据库中，这时，另外一个事务也访问这个数据，然后使用了这个数据。
不可重复读：是指在一个事务内，多次读同一数据。在这个事务还没有结束时，另外一个事务也访问该同一数据。那么，在第一个事务中的两次读数据之间，由于第二个事务的修改，那么第一个事务两次读到的的数据可能是不一样的。这样就发生了在一个事务内两次读到的数据是不一样的，因此称为是不可重复读。（即不能读到相同的数据内容）
幻读:是指当事务不是独立执行时发生的一种现象，例如第一个事务对一个表中的数据进行了修改，这种修改涉及到表中的全部数据行。同时，第二个事务也修改这个表中的数据，这种修改是向表中插入一行新数据。那么，以后就会发生操作第一个事务的用户发现表中还有没有修改的数据行，就好象发生了幻觉一样。

当隔离级别是可重复读，且禁用innodb_locks_unsafe_for_binlog的情况下，在搜索和扫描index的时候使用的next-key locks可以避免幻读。在默认的可重复读的隔离级别里，可以使用加锁读去查询最新的数据（提交读）。
- Next-Key锁是行锁和GAP（间隙锁）的合并：行锁可以防止不同事务版本的数据修改提交时造成数据冲突的情况。但如何避免别的事务插入数据就成了问题。
- 行锁防止别的事务修改或删除，GAP锁防止别的事务新增，行锁和GAP锁结合形成的的Next-Key锁共同解决了RR级别在写数据时的幻读问题。

```sql
CREATE TABLE user (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `name` varchar(255) NOT NULL,
 PRIMARY KEY (`id`),
 UNIQUE `uniq_name` USING BTREE (name)
) ENGINE=`InnoDB` AUTO_INCREMENT=10 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

set autocommit=0; # 关闭事物自动提交
# 设置事物隔离级别与查看
set session transaction isolation level read uncommitted;
select @@global.tx_isolation;
select @@session.tx_isolation;
select @@tx_isolation;

start transaction; # 事物一
insert into user(name) values('ziwenxie'); 

set session transaction isolation level read uncommitted;
# Read Uncommitted：事务二中会读取到事务一中没有commit的数据，这就是脏读。
# Read Committed：事物一提交后影响到事务二的查询结果，前后查询的结果不一致
# REPEATABLE-READ：事务二中无法读取到事务一中没有commit的数据
start transaction; # 事物二
select * from user; 

set session transaction isolation level repeatable read;

# RC级别：
select id,class_name,teacher_id from class_teacher where teacher_id=30; # 2 初三二班 30
begin;
update class_teacher set class_name='初三四班' where teacher_id=30;  # 事物一更新

insert into class_teacher values (null,'初三二班',30); # 事物二插入
commit;
select id,class_name,teacher_id from class_teacher where teacher_id=30; #  2 初三四班 30   10 初三二班 30
# RR级别：事务A在update后加锁，事务B无法插入新数据，这样事务A在update前后读的数据保持一致，避免了幻读。这个锁，就是Gap锁。
```

## 锁机制

数据库管理系统（DBMS）中的并发控制的任务是确保在多个事务同时存取数据库中同一数据时不破坏事务的隔离性和统一性以及数据库的统一性。

共享锁：由读表操作加上的锁，加锁后其他用户只能获取该表或行的共享锁，不能获取排它锁，也就是说只能读不能写
排它锁：由写表操作加上的锁，加锁后其他用户不能获取该表或行的任何锁，典型是mysql事务中

### 悲观锁

悲观并发控制（又名“悲观锁”，Pessimistic Concurrency Control，缩写“PCC”）是一种并发控制的方法。它可以阻止一个事务以影响其他用户的方式来修改数据。如果一个事务执行的操作都某行数据应用了锁，那只有当这个事务把锁释放，其他事务才能够执行与该锁冲突的操作。主要用于数据争用激烈的环境，以及发生并发冲突时使用锁保护数据的成本要低于回滚事务的成本的环境中。依靠数据库的锁机制实现，以保证操作最大程度的独占性

要使用悲观锁，我们必须关闭mysql数据库的自动提交属性，因为MySQL默认使用autocommit模式，也就是说，当你执行一个更新操作后，MySQL会立刻将结果进行提交。set autocommit=0; 一锁二查三更新，通过常用的select … for update操作来实现悲观锁，在当前事务结束时自动释放，因此必须在事务中使用。

对数据被外界（包括本系统当前的其他事务，以及来自外部系统的事务处理）修改持保守态度，因此，在整个数据处理过程中，将数据处于锁定状态。悲观锁的实现，往往依靠数据库提供的锁机制（也只有数据库层提供的锁机制才能真正保证数据访问的排他性，否则，即使在本系统中实现了加锁机制，也无法保证外部系统不会修改数据）。
在悲观锁的情况下，为了保证事务的隔离性，就需要一致性锁定读。读取数据时给加锁，其它事务无法修改这些数据。修改删除数据时也要加锁，其它事务无法读取这些数据。
select for update语句执行中所有扫描过的行都会被锁上，这一点很容易造成问题。因此如果在mysql中用悲观锁务必要确定走了索引，而不是全表扫描。

- 在对任意记录进行修改前，先尝试为该记录加上排他锁（exclusive locking）。
- 如果加锁失败，说明该记录正在被修改，那么当前查询可能要等待或者抛出异常。 具体响应方式由开发者根据实际需要决定。
- 如果成功加锁，那么就可以对记录做修改，事务完成后就会解锁了。
- 其间如果有其他对该记录做修改或加排他锁的操作，都会等待我们解锁或直接抛出异常。

* 悲观并发控制实际上是“先取锁再访问”的保守策略，为数据处理的安全提供了保证。
* 在效率方面，处理加锁的机制会让数据库产生额外的开销，还有增加产生死锁的机会；
* 在只读型事务处理中由于不会产生冲突，也没必要使用锁，这样做只能增加系统负载；还有会降低了并行性，一个事务如果锁定了某行数据，其他事务就必须等待该事务处理完才可以处理那行数

```sql
begin;/begin work;/start transaction; (三者选一就可以) # # 0.开始事务
select status from t_goods where id=1 for update; # //1.查询出商品信息
insert into t_orders (id,goods_id) values (null,1); # //2.根据商品信息生成订单
update t_goods set status=2; # //3.修改商品status为2
commit;/commit work; # //4.提交事务
```

### 乐观锁

乐观并发控制（又名“乐观锁”，Optimistic Concurrency Control，缩写“OCC”）是一种并发控制的方法。它假设多用户并发的事务在处理时不会彼此互相影响，各事务能够在不产生锁的情况下处理各自影响的那部分数据。在提交数据更新之前，每个事务会先检查在该事务读取数据后，有没有其他事务又修改了该数据。如果其他事务有更新的话，正在提交的事务会进行回滚。

在数据库内部update同一行的时候是不允许并发的，即数据库每次执行一条update语句时会获取被update行的写锁，直到这一行被成功更新后才释放。因此在业务操作进行前获取需要锁的数据的当前版本号，然后实际更新数据时再次对比版本号确认与之前获取的相同，并更新版本号，即可确认这之间没有发生并发的修改。如果更新失败即可认为老版本的数据已经被并发修改掉而不存在了，此时认为获取锁失败，需要回滚整个业务操作并可根据需要重试整个过程。

乐观锁假设认为数据一般情况下不会造成冲突，所以在数据进行提交更新的时候，才会正式对数据的冲突与否进行检测，如果发现冲突了，则让返回用户错误的信息，让用户决定如何去做。乐观锁并不会使用数据库提供的锁机制。一般的实现乐观锁的方式就是记录数据版本。

数据版本,为数据增加的一个版本标识。当读取数据时，将版本标识的值一同读出，数据每更新一次，同时对版本标识进行更新。当我们提交更新的时候，判断数据库表对应记录的当前版本信息与第一次取出来的版本标识进行比对，如果数据库表当前版本号与第一次取出来的版本标识值相等，则予以更新，否则认为是过期数据。

* 使用版本号
    - ELECT时，读取创建版本号<=当前事务版本号，删除版本号为空或>当前事务版本号。
    - INSERT时，保存当前事务版本号为行的创建版本号
    - DELETE时，保存当前事务版本号为行的删除版本号
    - UPDATE时，插入一条新纪录，保存当前事务版本号为行创建版本号，同时保存当前事务版本号到原来删除的行
    - 通过MVCC，虽然每行记录都需要额外的存储空间，更多的行检查工作以及一些额外的维护工作，但可以减少锁的使用，大多数读操作都不用加锁，读数据操作很简单，性能很好，并且也能保证只会读取到符合标准的行，也只锁住必要行。
* 是使用时间戳

```sql
select (status,status,version) from t_goods where id=#{id} # 1.查询出商品信息
update t_goods  # 2.根据商品信息生成订单
set status=2,version=version+1 # 3.修改商品status为2
where id=#{id} and version=#{version};

SELECT data AS old_data, version AS old_version FROM …; 
# 根据获取的数据进行业务操作，得到new_data和new_version
UPDATE SET data = new_data, version = new_version WHERE version = old_version 
if (updated row > 0) {
    // 乐观锁获取成功，操作完成
} else {
    // 乐观锁获取失败，回滚并重试
}
```

乐观并发控制相信事务之间的数据竞争(data race)的概率是比较小的，因此尽可能直接做下去，直到提交的时候才去锁定，所以不会产生任何锁和死锁。但如果直接简单这么做，还是有可能会遇到不可预期的结果，例如两个事务都读取了数据库的某一行，经过修改以后写回数据库，这时就遇到了问题。

适合用在取锁失败概率比较小的场景，可以提升系统并发性能。用于写比较少的情况下。可以省去了锁的开销，加大了系统的整个吞吐量。上层应用会不断的进行retry，这样反倒是降低了性能，所以这种情况下用悲观锁就比较合适。

### Gap锁

二级索引维护一套B+树与主键id的数据结构（树形结构），除了行锁，还会在行锁之间加gap锁，保证数据无法添加

### [优化策略](http://www.techug.com/post/mysql-20-plus-tips.html)

* 优化查询缓存
* EXPLAIN你的选择查询:帮助了解MySQL是怎样运行你的查询的,索引、扫描范围
* 获取唯一行时使用LIMIT 1
* 索引搜索字段：索引不仅仅是为了主键或唯一键。如果会在你的表中按照任何列搜索，你就都应该索引它们。
* 索引并对连接使用同样的字段类型：包含许多连接查询, 你需要确保连接的字段在两张表上都建立了索引，使用同样类型，相同的字符类型
* 不要ORDER BY RAND()：
* 避免使用SELECT *:从数据表中读取的数据越多，查询操作速度就越慢。它增加了磁盘操作所需的时间。此外，当数据库服务器与Web服务器分开时，由于必须在服务器之间传输数据，将会有更长的网络延迟。指定你需要的列
* 几乎总是有一个id字段:每个以id列为PRIMARY KEY的数据表中，优先选择AUTO_INCREMENT或者INT. VARCHAR字段作为主键（检索）速度较慢.一个可能的例外是"关联表"，用于两个表之间的多对多类型的关联。例如，"posts_tags"表中包含两列：post_id，tag_id，用于保存表名为"post"和"tags"的两个表之间的关系。这些表可以具有包含两个id字段的PRIMARY键。
* 相比VARCHAR优先使用ENUM:ENUM枚举类型是非常快速和紧凑的。在内部它们像TINYINT一样存储，但它们可以包含和显示字符串值。一个字段只包含几种不同的值，请使用ENUM而不是VARCHAR
* 通过PROCEDURE ANALYZE()获取建议：使用MySQL分析列结构和表中的实际数据，为你提供一些建议。它只有在数据表中有实际数据时才有用，因为这在分析决策时很重要。
* 如果可以的话使用NOT NULL：问一下你自己在空字符串值和NULL值之间（对应INT字段：0 vs. NULL）是否有任何的不同.如果没有理由一起使用这两个。NULL列需要额外的空间，他们增加了你的比较语句的复杂度。
* 预处理语句：预处理语句默认情况下会过滤绑定到它的变量，这对于避免SQL注入攻击极为有效。当然你也可以指定要过滤的变量。但这些方法更容易出现人为错误，也更容易被程序员遗忘。
* 无缓冲查询:通常当你从脚本执行一个查询，在它可以继续后面的任务之前将需要等待查询执行完成。你可以使用无缓冲的查询来改变这一情况。"mysql_unbuffered_query() 发送SQL查询语句到MySQL不会像 mysql_query()那样自动地取并缓冲结果行。这让产生大量结果集的查询节省了大量的内存，在第一行已经被取回时你就可以立即在结果集上继续工 作，而不用等到SQL查询被执行完成。"有一定的局限性。你必须在执行另一个查询之前读取所有的行或调用mysql_free_result() 。另外你不能在结果集上使用mysql_num_rows() 或 mysql_data_seek() 。
* 使用 UNSIGNED INT 存储IP地址：在查询中可以使用 INET_ATON() 来把一个IP转换为整数，用 INET_NTOA() 来进行相反的操作。在 PHP 也有类似的函数，ip2long() 和 long2ip()。 `$r = "UPDATE users SET ip = INET_ATON('{$_SERVER['REMOTE_ADDR']}') WHERE user_id = $user_id";`
* 固定长度（静态）的表会更快：所有列都是"固定长度"，那么这个表被认为是"静态"或"固定长度"的。不固定的列类型包括 VARCHAR、TEXT、BLOB等。即使表中只包含一个这些类型的列，这个表就不再是固定长度的，MySQL 引擎会以不同的方式来处理它。固定长度的表会提高性能，因为 MySQL 引擎在记录中检索的时候速度会更快。它们也易于缓存，崩溃后容易重建。不过它们也会占用更多空间
* 垂直分区是为了优化表结构而对其进行纵向拆分的行为。将低频信息放到另一个表中，这样你的主用户表就会更小。如你所知，表越小越快。例子：last_login" 字段，用户每次登录网站都会更新这个字段，而每次更新都会导致这个表缓存的查询数据被清空。这种情况下你可以将那个字段放到另一张表里，保持用户表更新量最小。
* 拆分大型DELETE或INSERT语句：执行大型DELETE或INSERT查询，则需要注意不要影响网络流量。当执行大型语句时，它会锁表并使你的Web应用程序停止。Apache运行许多并行进程/线程。 因此它执行脚本效率很高。所以服务器不期望打开过多的连接和进程，这很消耗资源，特别是内存。如果你锁表很长时间（如30秒或更长），在一个高流量的网站，会导致进程和查询堆积，处理这些进程和查询可能需要很长时间，最终甚至使你的网站崩溃。维护脚本需要删除大量的行，只需使用LIMIT子句，以避免阻塞。`while (1) { mysql_query("DELETE FROM logs WHERE log_date`
* 越少的列越快:对于数据库引擎，磁盘可能是最重要的瓶颈。更小更紧凑的数据、减少磁盘传输量，通常有助于性能提高。如果已知表具有很少的行，则没有理由是主键类型为INT，可以用MEDIUMINT、SMALLINT代替，甚至在某些情况下使用TINYINT。 如果不需要完整时间记录，请使用DATE而不是DATETIME。
* 选择正确的存储引擎:MyISAM适用于读取繁重的应用程序，但是当有很多写入时它不能很好地扩展。 即使你正在更新一行的一个字段，整个表也被锁定，并且在语句执行完成之前，其他进程甚至无法读取该字段。 MyISAM在计算SELECT COUNT（*）的查询时非常快。InnoDB是一个更复杂的存储引擎，对于大多数小的应用程序，它比MyISAM慢。 但它支持基于行的锁定，使其更好地扩展。 它还支持一些更高级的功能，比如事务。
* 使用对象关系映射器（ORM, Object Relational Mapper）:ORM以"延迟加载"著称。这意味着它们仅在需要时获取实际值。但是你需要小心处理他们，否则你可能最终创建了许多微型查询，这会降低数据库性能。ORM还可以将多个查询批处理到事务中，其操作速度比向数据库发送单个查询快得多。PHP-ORM是Doctrine
* 小心使用持久连接:持久连接意味着减少重建连接到MySQL的成本。 当持久连接被创建时，它将保持打开状态直到脚本完成运行。 因为Apache重用它的子进程，下一次进程运行一个新的脚本时，它将重用相同的MySQL连接。`mysql_pconnect()`,可能会出现连接数限制问题、内存问题等等。

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


### 索引

索引：帮助mysql高效获取数据的数据结构，索引(mysql中叫"键(key)") 数据越大越重要。索引好比一本书，为了找到书中特定的话题，查看目录，获得页码。获取物理位置。大多数MySQL索引(PRIMARY KEY、UNIQUE、INDEX和FULLTEXT)使用B树中存储。空间列类型的索引使用R-树，MEMORY表支持hash索引。存储引擎用于快速查找记录的一种数据结构，通过合理的使用数据库索引可以大大提高系统的访问性能。大大减轻了服务器需要扫描的数据量，从而提高了数据的检索速度；帮助服务器避免排序和临时表；可以将随机 I/O 变为顺序 I/O

* 快速找出匹配一个WHERE子句的行。
* 删除行。当执行联接时，从其它表检索行。
* 对具体有索引的列key_col找出MAX()或MIN()值。由预处理器进行优化，检查是否对索引中在key_col之前发生所有关键字元素使用了WHERE key_part_# = constant。在这种情况下，MySQL为每个MIN()或MAX()表达式执行一次关键字查找，并用常数替换它。如果所有表达式替换为常量，查询立即返回。例如：SELECT MIN(key2), MAX (key2)  FROM tb WHERE key1=10;
* 如果对一个可用关键字的最左面的前缀进行了排序或分组(例如，ORDER BY key_part_1,key_part_2)，排序或分组一个表。如果所有关键字元素后面有DESC，关键字以倒序被读取。
* 在一些情况中，可以对一个查询进行优化以便不用查询数据行即可以检索值。如果查询只使用来自某个表的数字型并且构成某些关键字的最左面前缀的列，为了更快，可以从索引树检索出值。`SELECT key_part3 FROM tb WHERE key_part1=1`
* 有时MySQL不使用索引，即使有可用的索引。一种情形是当优化器估计到使用索引将需要MySQL访问表中的大部分行时。(在这种情况下，表扫描可能会更快些）。然而，如果此类查询使用LIMIT只搜索部分行，MySQL则使用索引，因为它可以更快地找到几行并在结果中返回。

索引种类：

* PRIMARY 索引:在主键上自动创建，不允许有空值。一般是在建表的时候同时创建主键索引
    - 主键递增，数据行写入可以提高插入性能，可以避免page分裂，减少表碎片提升空间和内存的使用
    - 主键要选择较短的数据类型， Innodb引擎普通索引都会保存主键的值，较短的数据类型可以有效的减少索引的磁盘空间，提高索引的缓存效率
    - 无主键的表删除，在row模式的主从架构，会导致备库夯住
* INDEX 索引:就是普通索引
* UNIQUE 索引:相当于INDEX + Unique
* FULLTEXT索引:只在MYISAM 存储引擎支持, 目的是全文索引，在VARCHAR或者TEXT类型的列上创建，在内容系统中用的多， 在全英文网站用多(英文词独立). 中文数据不常用，意义不大 国内全文索引通常 使用 sphinx 来完成.全文索引:fulltext是Myisam表特殊索引，从文本中找关键字不是直接和索引中的值进行比较
* 组合索引：一个索引可以包括15个列。
    - 建立多个单列索引，查询时和上述的组合索引效率也会大不一样，远远低于我们的组合索引。虽然此时有了三个索引，但MySQL只能用到其中的那个它认为似乎是最有效率的单列索引。 
    - 最左前缀（Leftmost Prefixing）。假如有一个多列索引为key(firstname lastname age)，当搜索条件是以下各种列的组合和顺序时，MySQL将使用该多列索引：firstname，lastname，age  firstname，lastname firstname
* 如果是CHAR，VARCHAR类型，length可以小于字段实际长度；如果是BLOB和TEXT类型，必须指定 length

合理的建立索引的建议：

* 越小的数据类型通常更好：越小的数据类型通常在磁盘、内存和CPU缓存中都需要更少的空间，处理起来更快。
* 在WHERE和JOIN中出现的列需要建立索引，但也不完全如此，因为MySQL只对<，<=，=，>，>=，BETWEEN，IN，以及某些时候的LIKE才会使用索引 
* 简单的数据类型更好：整型数据比起字符，处理开销更小，因为字符串的比较更复杂。在MySQL中，应该用内置的日期和时间数据类型，而不是用字符串来存储时间；以及用整型数据类型存储IP地址。
* 尽量避免NULL：应该指定列为NOT NULL，除非你想存储NULL。在MySQL中，含有空值的列很难进行查询优化，因为它们使得索引、索引的统计信息以及比较运算更加复杂。你应该用0、一个特殊的值或者一个空串代替空值
* 不使用NOT IN和<>操作 
* 不要在列上进行运算  select * from users where YEAR(adddate)<2007; 将在每个行上进行运算，这将导致索引失效而进行全表扫描，因此我们可以改成 
* like语句操作  一般情况下不鼓励使用like操作，如果非使用不可，如何使用也是一个问题。like “%aaa%” 不会使用索引而like “aaa%”可以使用索引。 
* 索引列排序  MySQL查询只使用一个索引，因此如果where子句中已经使用了索引的话，那么order by中的列是不会使用索引的。因此数据库默认排序可以符合要求的情况下不要使用排序操作；尽量不要包含多个列的排序，如果需要最好给这些列创建复合索引。 
* 使用短索引  对串列进行索引，如果可能应该指定一个前缀长度。例如，如果有一个CHAR(255)的列，如果在前10个或20个字符内，多数值是惟一的，那么就不要对整个列进行索引。短索引不仅可以提高查询速度而且可以节省磁盘空间和I/O操作。 
* 单表索引建议控制在5个以内
* 单索引字段数不允许超过5个：字段超过5个时，实际已经起不到有效过滤数据的作用了
* 禁止在更新十分频繁、区分度不高的属性上建立索引

#### 索引缺点

* 虽然索引大大提高了查询速度，同时却会降低更新表的速度，如对表进行INSERT、UPDATE和DELETE。因为更新表时，MySQL不仅要保存数据，还要保存一下索引文件。
* 建立索引会占用磁盘空间的索引文件。一般情况这个问题不太严重，但如果你在一个大表上创建了多种组合索引，索引文件的会膨胀很快。 

#### B+Tree树结构的索引规则

B-tree 索引:大多数谈及的索引类型就是B-tree类型, 可以在create table 和其他命令使用它 myisam使用前缀压缩以减小索引，Innodb不会压缩索引，myiam索引按照行存储物理位置引用被索引的行，Innodb按照主键值引用行，B-tree数据存储是有序的，按照顺序保存了索引的列，加速了数据访问，存储引擎不会扫描整个表得到需要的数据。
  
* 使用B-tree索引的查询类型，很好用于全键值、键值范围或键前缀查找，只有在超找使用了索引的最左前缀的时候才有用。只访问索引的查询：B-tree支持只访问索引的查询，不会访问行
* 查找没有送索引列的最左边开始,没有什么用处;不能跳过索引的列;
* 前缀索引：索引很长的字符列，这会增加索引的存储空间以及降低索引的效率。选择字符列的前n个字符作为索引，这样可以大大节约索引空间，从而提高索引效率。要选择足够长的前缀以保证高的选择性，同时又不能太长。无法使用前缀索引做ORDER BY 和 GROUP BY以及使用前缀索引做覆盖扫描。
    - 通常索引几个字符，而不是全部值，以节约空间并得到好的性能，同时也降低选择性。
    - 索引选择性是不重复的索引值和全部行数的比值。高选择性的索引有好处，查找匹配过滤更多的行，唯一索引选择率为1最佳状态。
    - blob列、text列及很长的varchar列，必须定义前缀索引，mysql不允许索引他们的全文。
* 组合索引：创建索引列的顺序非常重要，正确的索引顺序依赖于使用该索引的查询方式.对于组合索引的索引顺序可以通过经验法则来帮助我们完成：将选择性最高的列放到索引最前列，该法则与前缀索引的选择性方法一致，但并不是说所有的组合索引的顺序都使用该法则就能确定，还需要根据具体的查询场景来确定具体的索引顺序。
* 聚簇索引(Clustered Index)：决定数据在物理磁盘上的物理排序，一个表只能有一个聚集索引，如果定义了主键，那么 InnoDB 会通过主键来聚集数据，如果没有定义主键，InnoDB 会选择一个唯一的非空索引代替，如果没有唯一的非空索引，InnoDB 会隐式定义一个主键来作为聚集索引。 聚集索引可以很大程度的提高访问速度，因为聚集索引将索引和行数据保存在了同一个 B-Tree 中，所以找到了索引也就相应的找到了对应的行数据，但在使用聚集索引的时候需注意避免随机的聚集索引（一般指主键值不连续，且分布范围不均匀）。如使用 UUID 来作为聚集索引性能会很差，因为 UUID 值的不连续会导致增加很多的索引碎片和随机I/O，最终导致查询的性能急剧下降。聚集索引不是一种单独的索引类型，而是一种存储数据的方式。Innodb 的聚集索引实际上同样的结构保存了B-tree索引和数据行，"聚集" 是指实际的数据行和相关的键值保存在一起，每个表只能有一个聚集索引，因此不能一次把行保存在两个地方。
    - 在叶子页(Leaf Page)中存储了完整的数据行，实际也是表的一种数据存储方式，这样的表也称索引组织表(Index Organized Table, IOT)。一个InnoDB表中通常只能有一个聚簇索引，被定义在主键上。MYISAM 不支持该索引类型，其索引文件(.MYI)和数据文件(.MYD)是相互独立的。
    - INNODB和MYISAM的主键索引与二级索引的对比：可以看出MYISAM的主键索引和二级索引没有任何区别，主键索引仅仅只是一个叫做PRIMARY KEY的唯一非空的索引，因此 MYISAM 可以不设主键。
* 非聚集索引：与聚集索引不同的是非聚集索引并不决定数据在磁盘上的物理排序，且在 B-Tree 中包含索引但不包含行数据，基于主键索引构建的树。行数据只是通过保存在 B-Tree 中的索引对应的指针来指向行数据，如：上面在（user_name，city, age）上建立的索引就是非聚集索引。
    - 辅助索引(Secondary Index)：又叫二级索引，指除聚簇索引之外的所有索引。InnoDB的二级索引的叶子节点包含主键值而不是行指针(Row Pointer)，这减小了移动数据或者数据页面分裂时维护二级索引的开销，因为InnoDB不需要更新索引的行指针。
* 覆盖索引：索引（如：组合索引）中包含所有要查询的字段的值，查看是否使用了覆盖索引可以通过执行计划中的Extra中的值为Using index。索引支持高效查找行，mysql也能使用索引来接收列的数据。这样不用读取行数据，当发起一个被索引覆盖的查询，explain解释器的extra列看到 using index。避免了读取磁盘数据文件中的行，Innodb的辅助索引叶子节点包含的是主键列，所以主键一定是被索引覆盖的。
![clustered-index](../_static/clustered-index.jpg "clustered-index")
![index](../_static/index.jpg "index")

```sql
CREATE [UNIQUE|FULLTEXT]  INDEX index_name on tbl_name (col_name [(length)] [ASC | DESC] , …..);
alter table table_name ADD INDEX [index_name] (index_col_name,...);

DROP INDEX index_name ON tbl_name;
alter table table_name drop index index_name;
alter table t_b drop primary key;

show index from table_name;
show keys from table_name;
desc table_Name;

CREATE TABLE user_test( 
  id int AUTO_INCREMENT PRIMARY KEY, 
  user_name varchar(30) NOT NULL,
  sex bit(1) NOT NULL DEFAULT b'1', 
  city varchar(50) NOT NULL,  
  age int NOT NULL,
  PRIMARY KEY(ID)  
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
ALTER TABLE user_test ADD INDEX idx_user(name(10) , city , age); # 因为一般情况下名字的长度不会超过10，这样会加速索引查询速度，还会减少索引文件的大小，提高INSERT的更新速度。

SELECT COUNT(DISTINCT index_column)/COUNT(*) FROM table_name; -- index_column代表要添加前缀索引的列，前缀索引的选择性比值，比值越高说明索引的效率也就越高效。
SELECT COUNT(DISTINCT LEFT(index_column,1))/COUNT(*),COUNT(DISTINCT LEFT(index_column,2))/COUNT(*),COUNT(DISTINCT LEFT(index_column,3))/COUNT(*)
...FROM table_name;
ALTER TABLE table_name ADD INDEX index_name (index_column(length));
```

#### 有效索引

- 全值匹配：`SELECT * FROM user_test WHERE user_name = 'feinik' AND age = 26 AND city = '广州';`
- 匹配最左前缀:可用于查询条件为：（user_name ）、（user_name, city）、（user_name , city , age）,满足最左前缀查询条件的顺序与索引列的顺序无关
- 匹配范围值:`SELECT * FROM user_test WHERE user_name LIKE 'feinik%';`

#### 无效索引

```sql
SELECT * FROM user_test WHERE city = '广州';
SELECT * FROM user_test WHERE age= 26;
SELECT * FROM user_test WHERE user_name like '%feinik';
SELECT * FROM user_test WHERE user_name ='feinik' AND city LIKE'广州%' AND age = 26;//有某个列的范围查询,则其右边的所有列都无法使用索引优化查询
SELECT * FROM user_test WHERE user_name = concat(user_name, 'fei'); // 索引列不能是表达式的一部分，也不能作为函数的参数
SELECT user_name, city, age FROM user_test ORDER BY user_name, sex; // 不在索引列中
SELECT user_name, city, age FROM user_test ORDER BY user_name ASC, city DESC; //方向不一致
SELECT user_name, city, age, sex FROM user_test ORDER BY user_name;
SELECT user_name, city, age FROM user_test WHERE user_name LIKE 'feinik%' ORDER BY city;
```

使用索引排序：ORDER BY 子句后的列顺序要与组合索引的列顺序一致，且所有排序列的排序方向（正序/倒序）需一致；所查询的字段值需要包含在索引列中，及满足覆盖索引。

```sql
SELECT user_name, city, age FROM user_test ORDER BY user_name;
SELECT user_name, city, age FROM user_test ORDER BY user_name, city;
SELECT user_name, city, age FROM user_test ORDER BY user_name DESC, city DESC;
SELECT user_name, city, age FROM user_test WHERE user_name = 'feinik' ORDER BY city;
```

## Docker

- mkdir -p ~/mysql/data ~/mysql/logs ~/mysql/conf
- 创建Dockerfile

```
FROM debian:jessie

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r mysql && useradd -r -g mysql mysql

# add gosu for easy step-down from root
ENV GOSU_VERSION 1.7
RUN set -x \
    && apt-get update && apt-get install -y --no-install-recommends ca-certificates wget && rm -rf /var/lib/apt/lists/* \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
    && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true \
    && apt-get purge -y --auto-remove ca-certificates wget

RUN mkdir /docker-entrypoint-initdb.d

# FATAL ERROR: please install the following Perl modules before executing /usr/local/mysql/scripts/mysql_install_db:
# File::Basename
# File::Copy
# Sys::Hostname
# Data::Dumper
RUN apt-get update && apt-get install -y perl pwgen --no-install-recommends && rm -rf /var/lib/apt/lists/*

# gpg: key 5072E1F5: public key "MySQL Release Engineering <mysql-build@oss.oracle.com>" imported
RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys A4A9406876FCBD3C456770C88C718D3B5072E1F5

ENV MYSQL_MAJOR 5.6
ENV MYSQL_VERSION 5.6.31-1debian8

RUN echo "deb http://repo.mysql.com/apt/debian/ jessie mysql-${MYSQL_MAJOR}" > /etc/apt/sources.list.d/mysql.list

# the "/var/lib/mysql" stuff here is because the mysql-server postinst doesn't have an explicit way to disable the mysql_install_db codepath besides having a database already "configured" (ie, stuff in /var/lib/mysql/mysql)
# also, we set debconf keys to make APT a little quieter
RUN { \
        echo mysql-community-server mysql-community-server/data-dir select ''; \
        echo mysql-community-server mysql-community-server/root-pass password ''; \
        echo mysql-community-server mysql-community-server/re-root-pass password ''; \
        echo mysql-community-server mysql-community-server/remove-test-db select false; \
    } | debconf-set-selections \
    && apt-get update && apt-get install -y mysql-server="${MYSQL_VERSION}" && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/lib/mysql && mkdir -p /var/lib/mysql /var/run/mysqld \
    && chown -R mysql:mysql /var/lib/mysql /var/run/mysqld \
# ensure that /var/run/mysqld (used for socket and lock files) is writable regardless of the UID our mysqld instance ends up having at runtime
    && chmod 777 /var/run/mysqld

# comment out a few problematic configuration values
# don't reverse lookup hostnames, they are usually another container
RUN sed -Ei 's/^(bind-address|log)/#&/' /etc/mysql/my.cnf \
    && echo 'skip-host-cache\nskip-name-resolve' | awk '{ print } $1 == "[mysqld]" && c == 0 { c = 1; system("cat") }' /etc/mysql/my.cnf > /tmp/my.cnf \
    && mv /tmp/my.cnf /etc/mysql/my.cnf

VOLUME /var/lib/mysql

COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/docker-entrypoint.sh /entrypoint.sh # backwards compat
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306
CMD ["mysqld"]
```

- docker build -t mysql .
- docker run -p 3306:3306 --name mymysql -v $PWD/conf/my.cnf:/etc/mysql/my.cnf -v $PWD/logs:/logs -v $PWD/data:/mysql_data -e MYSQL_ROOT_PASSWORD=123456 -d mysql:5.6

## 扩展

* [mysqljs/mysql](https://github.com/mysqljs/mysql):A pure node.js JavaScript Client implementing the MySql protocol.
* [o1lab/xmysql](https://github.com/o1lab/xmysql):One command to generate REST APIs for any MySql Database.

### xmysql

```shell
npm install -g xmysql 
xmysql -h localhost -u mysqlUsername -p mysqlPassword -d databaseName
http://localhost:3000
```

- GET       /api/tableName
- POST      /api/tableName
- GET       /api/tableName/:id
- PUT       /api/tableName/:id
- GET       /api/tableName/count
- GET       /api/tableName/exists
- GET       /api/parentTable/:id/childTable
- DELETE  /api/tableName/:id
- POST     /dynamic
- GET      /api/tableName/describe
- GET      /api/tables

* composite primary keys: `/api/payments/103___JM555205`
* _p indicates page and _size indicates size of response rows,By default 20 records and max of 100 are returned per GET request on a table.`/api/payments?_p=2&_size=50`
* Sorting: `/api/payments?_sort=column1` `/api/payments?_sort=-column1` `/api/payments?_sort=column1,-column2`
* Fields `/api/payments?_fields=customerNumber,checkNumber` `/api/payments?_fields=-checkNumber`

### MySQL Proxy

MySQL Proxy的主要作用是用来做负载均衡，数据库读写分离的。但是需要注意的是，MySQL Proxy还有个强大的扩展功能就是支持Lua语言.

启动MySQL Proxy的时候，加载一个Lua脚本，对每一个进入的query或者insert之类的语句做一次安全检查，甚至替换查询中的某些内容，这样在程序员的 程序中忘记了过滤参数的情况下，还有最后一道防线可用。而且由于是Lua这样的动态脚本语言，在开发，修正，部署方面都会有极大的灵活性。

* connect_server() — 这个函数每次client连接的时候被调用，可以用这个函数来处理负载均衡，决定当前的请求发给那个后台的服务器，如果没有指定这个函数，那么就会采用简单的轮询机制。 
* read_handshake() — 这个函数在server返回初始握手信息时被调用，可以调用这个函数在验证信息发给服务器前进行额外的检查。 
* read_auth() — client发送验证信息给服务器的时候会调用这个函数。 
* read_auth_result() — 服务器验证信息返回后调用这个函数。 
* read_query() — 每次client发送查询请求函数的时候被调用，可以用这个函数进行查询语句的预处理，过滤掉非预期的查询等等，这个是最常用的函数。 
* read_query_result() — 查询结果返回是调用的函数，可以进行结果集处理。

## 维护

* 通常地，单表物理大小不超过10GB，单表行数不超过1亿条，行平均长度不超过8KB，如果机器性能足够，这些数据量MySQL是完全能处理的过来的，不用担心性能问题，这么建议主要是考虑ONLINE DDL的代价较高；
* 不用太担心mysqld进程占用太多内存，只要不发生OOM kill和用到大量的SWAP都还好；
* 在以往，单机上跑多实例的目的是能最大化利用计算资源，如果单实例已经能耗尽大部分计算资源的话，就没必要再跑多实例了；
* 定期使用pt-duplicate-key-checker检查并删除重复的索引。定期使用pt-index-usage工具检查并删除使用频率很低的索引；
* 定期采集slow query log，用pt-query-digest工具进行分析，可结合Anemometer系统进行slow query管理以便分析slow query并进行后续优化工作；
* 可使用pt-kill杀掉超长时间的SQL请求，Percona版本中有个选项 innodb_kill_idle_transaction 也可实现该功能；
* 使用pt-online-schema-change来完成大表的ONLINE DDL需求；
* 定期使用pt-table-checksum、pt-table-sync来检查并修复mysql主从复制的数据差异；


## 扩展配置

### 主从复制

MySQL 在每个事务更新数据之前，由 Master 将事务串行的写入二进制日志，即使事务中的语句都是交叉执行的，之后通知存储引擎提交事务。MySQL支持三种复制方式，实现了Data Distribution、Load Balancing、Backups、High Availability and Failover等特性。 

* 基于语句复制：在主服务器上执行的SQL语句，在从服务器上执行同样的语句。MySQL默认采用基于语句的复制，效率比较高。
* 基于行复制：MySQL5.0开始支持把改变的内容复制过去，而不是把命令在从服务器上执行一遍。
* 混合类型复制：默认采用基于语句的复制，一旦发现基于语句的无法精确的复制时，就会采用基于行的复制。
![master-slave](../_static/master-slave.gif "master-slave")

* Master binlog输出线程：Master为每一个复制连接请求创建一个binlog输出线程，用于输出日志内容到相应的Slave；
* Slave I/O线程：在start slave之后，该线程负责从Master上拉取binlog内容放进自己的Relay Log中；
* Slave SQL线程：负责执行Relay Log中的语句。

#### notice

- 无法远程连接mysql(报错111)：注释掉my.cnf中的bind-address或绑定本地ip
- 添加server-id and log_bin=
- 主从服务器检查show variables like 'server%'
- 主服务器与从服务器

```sql
GRANT REPLICATION SLAVE ON *.* TO 'slave_user'@'%' IDENTIFIED BY 'slave_password';
FLUSH PRIVILEGES;
SHOW MASTER STATUS;

CHANGE MASTER TO MASTER_HOST='202.167.45.10',MASTER_USER='slave_user', MASTER_PASSWORD='slave_password', MASTER_LOG_FILE='mysql-bin.000001', MASTER_LOG_POS=  107;
START slave;
show slave status\G;

Slave_IO_Running = NO：stop slave; reset slave;start slave;
```

### 读写分离

通过mysql-proxy调度：与主服务器在一台服务器上，用源代码安装含有lua脚本

```shell
sudo apt-get install mysql-proxy
```

## 备份

* 在二级复制服务器上进行备份。
* 备份过程中停止数据的复制，以防止出现数据依赖和外键约束的不一致。
* 彻底停止MySQL之后，再从数据文件进行备份。
* 如果使用MySQL dump进行备份，请同时备份二进制日志 — 确保复制过程不被中断。
* 不要信任 LVM 快照的备份 — 可能会创建不一致的数据，将来会因此产生问题。
* 为每个表做一个备份，这样更容易实现单表的恢复 — 如果数据与其他表是相互独立的。
* 使用 mysqldump 时，指定 -opt 参数。
* 备份前检测和优化表。
* 临时禁用外键约束，来提高导入的速度。
* 临时禁用唯一性检查，来提高导入的速度。
* 每次备份完后，计算数据库/表数据和索引的大小，监控其增长。
* 使用定时任务（cron）脚本，来监控从库复制的错误和延迟。
* 定期备份数据。
* 定期测试备份的数据。

## 参考

* [HOW TO INSTALL MYSQL NDB CLUSTER ON LINUX](https://clusterengine.me/how-to-install-mysql-ndb-cluster-on-linux/)
* [索引性能分析](http://draveness.me/sql-index-performance.html) 
* [MySQL主从同步](http://geek.csdn.net/news/detail/236754)
* [MySQL数据库事务隔离级别介绍](http://www.jb51.net/article/49596.htm)
* 高性能mysql
* [使用 Docker 完成 MySQL 数据库主从配置](https://juejin.im/post/59fd71c25188254dfa1287a9)

## 工具

* [youtube/vitess](https://github.com/youtube/vitess):Vitess is a database clustering system for horizontal scaling of MySQL. http://vitess.io

您可以通过创建数据表来存储许可数据，以及所有许可用户标识和产品标识符来对数据进行非规范化（反规范化）处理，并针对特定客户进行查询。 您需要使用INSERT / UPDATE / DELETE上的MySQL触发器来重建表格（不过这要取决于数据来更改的表格），这会显着提高查询数据的性能。

类似地，如果一些连接在MySQL中减慢了查询速度，那么将查询分解为两个或更多语句并在PHP中单独执行它们可能会更快，然后可以在代码中收集和过滤结果。 Laravel 通过预加载在 Eloquent 中就做了类似的事情。

海量数据，高并发的公司

不同引擎数据结构的实现
