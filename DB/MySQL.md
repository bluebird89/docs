# [mysql / mysql-server](https://github.com/mysql/mysql-server)

MySQL Server, the world's most popular open source database, and MySQL Cluster, a real-time, open source transactional database. http://www.mysql.com/

## 版本

* MariaDB
* Percona:一个相对比较成熟的、优秀的MySQL分支版本，在性能提升、可靠性、管理型方面做了不少改善。与MySQL版本基本完全兼容，并且性能大约有20%以上的提升
* 5.7.8
    - 对 JSON 的支持
* [8.0](https://www.mysql.com/why-mysql/white-papers/whats-new-mysql-8-0/)
    - 更好的性能：读/写工作负载、IO 密集型工作负载、以及高竞争（"hot spot"热点竞争问题）工作负载。
    - 文档存储:为 schema-less 模式的 JSON 文档提供了多文档事务支持和完整的 ACID 合规性
    - SQL角色：可以在单个的会话中创建、授予、删除和应用 MySQL 角色
        + ROLES_GRAPHML()
        + 增强了对密码重用的限制：之前支持密码过期策略，新版会检测密码是否有效
    - 基于现有的 GIS 支持，引入了地理和空间参考
    - 窗口函数(Window Functions)
    - 索引可以被“隐藏”和“显示”。当对索引进行隐藏时，它不会被查询优化器所使用。
    - 降序索引
    - 通用表表达式(Common Table Expressions CTE)：在复杂的查询中使用嵌入式表时，使用 CTE 使得查询语句更清晰。
    - UTF-8 编码：用 utf8mb4 作为 MySQL 的默认字符集。
    - 对 JSON 的支持，添加了基于路径查询参数从 JSON 字段中抽取数据的 JSON_EXTRACT() 函数，以及用于将数据分别组合到 JSON 数组和对象中的 JSON_ARRAYAGG() 和 JSON_OBJECTAGG() 聚合函数。
    - InnoDB 现在支持表 DDL 的原子性，也就是 InnoDB 表上的 DDL 也可以实现事务完整性，要么失败回滚，要么成功提交，不至于出现 DDL 时部分成功的问题，此外还支持 crash-safe 特性，元数据存储在单个事务数据字典中。
    - InnoDB 集群提供集成的原生 HA 解决方案
    - validate_password:默认为caching_sha2_password,客户端不支持

## 安装

```sh
## MAC
brew install mysql

/usr/local/Cellar/mysql/8.0.11/bin/mysqld
--initialize-insecure
--user=henry
--basedir=/usr/local/Cellar/mysql/8.0.11
--datadir=/usr/local/var/mysql
--tmpdir=/tmp

brew services start mysql
mysql.server start|stop|restart|status

brew cask install mysqlworkbench|sequel-pro # 客户端

mysql_secure_installation # 没有设置 root 帐户的密码，马上设置它;通过删除可从本地主机外部访问的 root 帐户来禁用远程 root 用户登录;删除匿名用户帐户和测试数据库

unset TMPDIR
mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp

## ubuntu
sudo apt install mysql-server
## 卸载
sudo apt remove mysql-server mysql-common
sudo apt autoremove mysql-server
sudo mysql_ssl_rsa_setup --uid=mysql #
sudo rm /var/lib/mysql/ -R
sudo rm /etc/mysql/ -R

## MariaDB
yum -y install mariadb-server mariadb
systemctl start mariadb && systemctl enable mariadb

dpkg -l | grep mysql
dpkg -l |grep ^rc|awk '{print $2}' |sudo xargs dpkg -P

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
service mysql status|start|stop|restart
systemctl status|start|stop|restart mysql.service

## docker
docker pull mysql
docker run --name master -p 3306:3307 -e MYSQL_ROOT_PASSWORD=root -d mysql

docker run -d --name mysql8 -p 3306:3306 --restart=always -v /Users/henry/Container/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 -e MYSQL_DATABASE=user_center mysql --sql_mode=NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci
docker exec -it mysql8 bash  #进入doccker
mysql -uroot -p123456 #连接mysql
alter user 'root'@'%' identified with mysql_native_password by '123456'; #更改身份验证插件

# Windows,管理员权限执行
net start|stop mysql # win平台

## 多实例
mkdir -p /data/{3306,3307}
# 配置
cp support-files/my-small.cnf /data/3306/my.cnf
cp support-files/mysql.server /data/3306/mysql

cp support-files/my-small.cnf /data/3307/my.cnf
cp support-files/mysql.server /data/3307/mysql

# dpkg: error processing package mariadb-server-10.0 (--configure):subprocess installed post-installation script returned error exit status 1
sudo apt-get remove --purge mysql*
sudo apt-get remove --purge mysql
sudo apt-get remove --purge mariadb
sudo apt-get remove --purge mariadb*
sudo apt-get --purge remove mariadb-server
```

## 原理

* server 层
    - 连接器:通信协议是“半双工”:在任一时刻，要么是服务器向客户端发送数据，要么是客户端向服务器发送数据，这两个动作不能同时发生
        + 连接处理：负责将 mysql 客户端和服务端建立连接，连接成功后，会获取当前连接用户的权限
        + 授权认证：获取到的权限对整个连接都有效，一旦连接成功后，如果使用管理员账号对该用户更改权限，当前连接中的拥有的权限保持不变，只有等到下次重新连接才会更新权限
        + 客户端用一个单独的数据包将查询请求发送给服务器，所以当查询语句很长的时候，需要设置 max_allowed_packet参数。但是需要注意的是，如果查询实在是太大，服务端会拒绝接收更多数据并抛出异常。
        + 服务器响应给用户的数据通常会很多，由多个数据包组成。但是当服务器响应客户端请求时，客户端必须完整的接收整个返回结果，而不能简单的只取前面几条结果，然后让服务器停止发送。因而在实际开发中，尽量保持查询简单且只返回必需的数据，减小通信间数据包的大小和数量
        + 客户端如果太长时间没动静，连接器就会自动将它断开。这个时间是由参数 wait_timeout 控制的，默认值是 8 小时。
        + 长连接是指连接成功后，如果客户端持续有请求，则一直使用同一个连接。短连接则是指每次执行完很少的几次查询就断开连接，下次查询再重新建立一个。
        + 全部使用长连接后，占用内存涨得特别快，因为 MySQL 在执行过程中临时使用的内存是管理在连接对象里面的。这些资源会在连接断开的时候才释放。所以如果长连接累积下来，可能导致内存占用太大，被系统强行杀掉（OOM）
            * 定期断开长连接。使用一段时间或者程序里面判断执行过一个占用内存的大查询后，断开连接，之后要查询再重连
            * 如果你用的是 MySQL 5.7 或更新版本，可以在每次执行一个比较大的操作后，通过执行 mysql_reset_connection 来重新初始化连接资源。这个过程不需要重连和重新做权限验证，但是会将连接恢复到刚刚创建完时的状态。
    - 查询缓存
        + 在执行查询之前，如果查询缓存是打开的，会检查这个查询语句是否命中查询缓存中的数据，之前执行过的语句及其结果可能会以 key-value 对的形式，被直接缓存在内存中。key 是查询的语句，value 是查询的结果。如果有缓存直接从缓存中读取并返回数据，不再执行后面的步骤了，结束查询操作
        + 如果没有缓存则继续往后执行，并将执行结果和语句保存在缓存中
        + 将缓存存放在一个引用表（不要理解成 table，可以认为是类似于 HashMap的数据结构）
            * 通过一个哈希值索引，这个哈希值通过查询本身、当前要查询的数据库、客户端协议版本号等一些可能影响结果的信息计算得来
            * 两个查询在任何字符上的不同（例如：空格、注释），都会导致缓存不会命中
        + 查询中包含任何用户自定义函数、存储函数、用户变量、临时表、mysql库中的系统表，其查询结果都不会被缓存
            * 比如函数 NOW()或者 CURRENT_DATE()会因为不同的查询时间，返回不同的查询结果
            * 包含 CURRENT_USER或者 CONNECION_ID()的查询语句会因为不同的用户而返回不同的结果
        + 查询缓存系统会跟踪查询中涉及的每个表，如果这些表（数据或结构）发生变化，那么和这张表相关的所有缓存数据都将失效
            * 在任何的写操作时，MySQL将对应表的所有缓存都设置为失效
            * 如果查询缓存非常大或者碎片很多，这个操作就可能带来很大的系统消耗，甚至导致系统僵死一会儿
        + 查询缓存对系统的额外消耗也不仅仅在写操作，读操作也不例外
            * 任何的查询语句在开始之前都必须经过检查，即使这条SQL语句永远不会命中缓存
            * 如果查询结果可以被缓存，那么执行完成后，会将结果存入缓存，也会带来额外的系统消耗
            * 缓存和失效都会带来额外消耗，只有当缓存带来的资源节约大于其本身消耗的资源时，才会给系统带来性能提升
        + 建议
            * 用多个小表代替一个大表，注意不要过度设计
            * 批量插入代替循环单条插入
            * 合理控制缓存空间大小，一般来说其大小设置为几十兆比较合适
            * 可以通过 SQL_CACHE和 SQL_NO_CACHE来控制某个查询语句是否需要进行缓存
            * 不要轻易打开查询缓存，特别是写密集型应用。如果想用，可以将 query_cache_type设置为 DEMAND，这时只有加入 SQL_CACHE 的查询才会走缓存
        + 注意:在 mysql8 后已经没有这个功能了，因为这个缓存非常容易被清空掉，命中率比较低。只要对表有一个更新，这个表上的所有缓存就会被清空，因此刚缓存下来的内容，还没来得及用就被另一个更新给清空了
        + 按需使用：可以将参数 query_cache_type 设置成 DEMAND，这样对于默认的 SQL 语句都不使用查询缓存。而对于确定要使用查询缓存的语句，可以用 SQL_CACHE 显式指定
    - 分析器
        + 词法分析：通过关键字将SQL语句进行解析，并生成一颗对应的解析树,预处理器会校验“解析树”是否合法(主要校验数据列和表明是否存在，别名是否有歧义等)，
            * 检查单词是否拼写错误
            * 检查要查询的表或字段是否存在。检测出有错误就会返回类似 "You have an error in your sql" 这样的错误信息，并结束查询操作
    - 优化器：对于一个 sql 语句，mysql 内部可能存在多种执行方案，结果都一样，但效率不一样，在执行之前需要尝试找出一个最优的执行计划.在表里面有多个索引的时候，决定使用哪个索引；或者在一个语句有多表关联（join）的时候，决定各个表的连接顺序。
        + 基于成本的优化器:尝试预测一个查询使用某种执行计划时的成本，并选择其中成本最小的一个。成本的最小单位是读取一个4K数据页的成本
        + 在MySQL可以通过查询当前会话的 last_query_cost的值来得到其计算当前查询的成本 `show status like 'last_query_cost';` 结果为数据页的数量
        + 有非常多的原因会导致MySQL选择错误的执行计划
            * 比如统计信息不准确、不会考虑不受其控制的操作成本（用户自定义函数、存储过程）
            * MySQL认为的最优跟我们想的不一样（我们希望执行时间尽可能短，但MySQL值选择它认为成本小的，但成本小并不意味着执行时间短）
        + 优化策略
            * 多表关联的查询（INTER JOIN）:优化器会根据数据的选择性来重新决定关联的顺序，选择性高的会被置前。如果关联设计到N张表，优化器会尝试N！种的关联顺序，从中选出一种最优的排列顺序
            * 提前终止查询（比如：使用Limit时，查找到满足数量的结果集后会立即终止查询）
            * 将外连接转化成内连接
            * 覆盖索引：索引中的列包含所有查询中需要的列的时候，只需要使用索引返回数据，不需要搜索数据行
            * 优化排序
                - 在老版本MySQL会使用两次传输排序，即先读取行指针和需要排序的字段在内存中对其排序，然后再根据排序结果去读取数据行
                - 新版本采用的是单次传输排序，也就是一次读取所有的数据行，然后根据给定的列排序,对于I/O密集型应用，效率会高很多）
            * 结果集进行排序，会采取两种策略
                - 如果结果集的容量小于“排序缓冲区”的容量，在内存中进行排序
                - 如果查询的结果大于“排序缓冲区”，则先将结果集拆分成多个“排序缓冲区”可以容纳的子集，然后把各个子集排序的结果存放在磁盘上，最后对各个子集进行合并
            * 等价规则:如 出现 where 5=5 and a>5 会转化成where a>5
            * COUNT(),MIN(),MAX()：在EXTRA中会出现 “Selecttables optimized away”的字样
                - 对于B-Tree索引而言，Max()/Min()的结果分别返回的是二叉树中最左边以及最右边的值，所以不需要进行表的访问就可以直接取到对应的值
                - 当执行 `select max(id) from table1 where name=’sun’` 时,如果name没有建立相应的索引,MYSQL会进行全表扫描,将SQL等同的转化为 `select id from table1 use index(PRIMARY) where name=’sun’ limit 1`
                - 对于Count()函数而言，在MYISAM引擎中维护了一个对应的常量值，也不需要对表进行访问就可以直接取到Count的值
            * 提前终止，在下列几种情况中，查询会提前终止，并不再对表进行扫描
                - 当优化器发现查询的结果已经满足查询需求的时候。比如查询中用到了LIMIT
                - Where的条件不成立的时候。例如 where id>100 and id <10
            * 列表IN()的比较
                - where id in(2,4,1,3,8,6) 这种类型的限制条件在很多的RDBMS中等同于`where id=2 or id=4 or id=3 or id=8 or id=6` 这种算法的复杂度是O(n)
                - 在MYSQL中,首先会对In列表进行排序，然后通过二分查找的方式进行比较，该方式的算法复杂度是O(log n).如果IN列表中的数据量非常的大，则效果会非常的明显
            * 关联子查询
                - 因为`select …from table1 t1 where t1.id in(select t2.fk from table2 t2 wheret2.id=’…’)` 类型的语句往往会被优化成 `select …. From table1 t1 where exists (select* from table2 t2 where t2.id=’…’ and t2.fk=t1.id)`, 由于在进行tabl2查询时, table1的值还无法确定, 所以会对table1进行全表扫描
                - 尽量用 INNER JOIN 替代 IN(),重写成 `select * from table1 t1 inner join table2 t2 using (id) where t2.id=’…’`,表链接用到索引
            * UNION的限制：UNION操作不会把UNION外的操作推送到每个子集
                - 为每个子操作单独的添加限制条件，例如  学生表有10000条记录,会员表有10000表记录,如果想按照姓名排序取两个表的前20条记录,如果在各个子查询中添加limit的话,则最外层的limit操作将会从40条记录中取20条,否则是从20000条中取20条
    - 执行器
        + 在执行语句之前会判断权限，如果没有对应的权限则会直接返回并提示没有相关权限
        + 如果是在前面的查询缓存中查到缓存之后，也会在返回结果前做权限校验的
        + 按照选定的方案执行 sql 语句，打开表，调用存储引擎提供的接口（handler API）去查询并返回结果集数据
        + 在查询优化阶段就为每一张表创建了一个 handler 实例，优化器可以根据这些实例的接口来获取表的相关信息，包括表的所有列名、索引统计信息等
        + 存储引擎接口提供了非常丰富的功能，但其底层仅有几十个接口，这些接口像搭积木一样完成了一次查询的大部分操作
        + 在数据库的慢查询日志中看到一个 rows_examined 的字段，表示这个语句执行过程中扫描了多少行,这个值是在执行器每次调用引擎获取数据行的时候累加的
* 存储层：用来存储和查询数据
* 更新流程
    - 物理日志 redo log（重做日志）
        + WAL（Write-Ahead Logging）：关键点就是先写日志，再写磁盘。当有一条记录需要更新的时候，InnoDB 引擎就会先把记录写到 redo log 里面，并更新内存，这个时候更新就算完成了。同时，InnoDB 引擎会在适当的时候，将这个操作记录更新到磁盘里面，而这个更新往往是在系统比较空闲的时候做
        + 有固定大小的，比如可以配置为一组 4 个文件，每个文件的大小是 1GB，那么总共就可以记录 4GB 的操作。从头开始写，写到末尾就又回到开头循环写
        + write pos 是当前记录的位置，一边写一边后移，写到第 3 号文件末尾后就回到 0 号文件开头。checkpoint 是当前要擦除的位置，也是往后推移并且循环的，擦除记录前要把记录更新到数据文件。
        + write pos 和 checkpoint 之间的是“粉板”上还空着的部分，可以用来记录新的操作。如果 write pos 追上 checkpoint，表示“粉板”满了，这时候不能再执行新的更新，得停下来先擦掉一些记录，把 checkpoint 推进一下。
        + 可以保证即使数据库发生异常重启，之前提交的记录都不会丢失，这个能力称为 crash-safe
    - 逻辑日志 binlog（归档日志）
        + 最开始 MySQL 里并没有 InnoDB 引擎。MySQL 自带的引擎是 MyISAM，但是 MyISAM 没有 crash-safe 的能力，binlog 日志只能用于归档。而 InnoDB 是另一个公司以插件形式引入 MySQL 的，既然只依靠 binlog 是没有 crash-safe 能力的，所以 InnoDB 使用另外一套日志系统——也就是 redo log 来实现 crash-safe 能力。
        + 区别
            * redo log 是 InnoDB 引擎特有的；binlog 是 MySQL 的 Server 层实现的，所有引擎都可以使用。
            * redo log 是物理日志，记录的是“在某个数据页上做了什么修改”；binlog 是逻辑日志，记录的是这个语句的原始逻辑，比如“给 ID=2 这一行的 c 字段加 1 ”。
            * redo log 是循环写的，空间固定会用完；binlog 是可以追加写入的。“追加写”是指 binlog 文件写到一定大小后会切换到下一个，并不会覆盖以前的日志
    - `update T set c=c+1 where ID=2;`
        + 执行器先找引擎取 ID=2 这一行。ID 是主键，引擎直接用树搜索找到这一行。如果 ID=2 这一行所在的数据页本来就在内存中，就直接返回给执行器；否则，需要先从磁盘读入内存，然后再返回。
        + 执行器拿到引擎给的行数据，把这个值加上 1，比如原来是 N，现在就是 N+1，得到新的一行数据，再调用引擎接口写入这行新数据。
        + 引擎将这行新数据更新到内存中，同时将这个更新操作记录到 redo log 里面，此时 redo log 处于 prepare 状态。然后告知执行器执行完成了，随时可以提交事务
        + 执行器生成这个操作的 binlog，并把 binlog 写入磁盘
        + 执行器调用引擎的提交事务接口，引擎把刚刚写入的 redo log 改成提交（commit）状态，更新完成
    - 让数据库恢复到半个月内任意一秒的状态
        + binlog 会记录所有的逻辑操作，并且是采用“追加写”的形式。如果你的 DBA 承诺说半个月内可以恢复，那么备份系统中一定会保存最近半个月的所有 binlog
        + 系统会定期做整库备份。这里的“定期”取决于系统的重要性，可以是一天一备，也可以是一周一备
        + 恢复过程
            * 找到最近的一次全量备份，如果运气好，可能就是昨天晚上的一个备份，从这个备份恢复到临时库
            * 从备份的时间点开始，将备份的 binlog 依次取出来，重放到中午误删表之前的那个时刻
            * 临时库就跟误删之前的线上库一样了，然后你可以把表数据从临时库取出来，按需要恢复到线上库去
        + 如果不使用“两阶段提交”，那么数据库的状态就有可能和用它的日志恢复出来的库的状态不一致

[MySQL查询](../_static/mysql_query.png)

```sh
show variables like '%query_cache%'
```

### 配置

* 配置文件：/usr/local/etc/my.cnf或者 my.ini
* 字符集: 客户端向MySQL服务器端请求和返加的数据的字符集
    - 在选择数据库后使用:`set names gbk`,相当于 client server connection 都设置;
    - 默认使用utf8mb4字符集,utf8mb4是utf8的超集，emoji表情以及部分不常见汉字在utf8下会表现为乱码，故需要升级至utf8mb4
    + 数据库存储:一个汉字utf8下为两个长度,gbk下为一个长度
    + 正常一个汉字utf8下为三个字节,gbk下为两个字节
    + 系统变量 `SHOW VARIABLES LIKE 'character_set_%'`
        + character_set_server：默认的内部操作字符集
        + character_set_client：客户端向服务器发送数据时使用的编码
        + character_set_connection：连接层字符集
        + character_set_results：服务器端将结果返回给客户端所使用的编码
        + character_set_database：当前选中数据库的默认字符集
        + character_set_system：系统元数据(字段名等)字符集
* 保证客户端使用字符集与服务端返回数据字符集编码一致(以适应客户端为主,修改服务器服务器端配置)
* 校对：规则属于PADSPACE类。这说明在MySQL中的所有CHAR和VARCHAR值比较时不需要考虑任何尾部空格
    - _bin：按二进制编码比较
    - _ci：不区分大小写比较
* 连接变量
    - max_connection # 最大连接数:增加该值增加mysqld 要求的文件描述符的数量。如果服务器的并发连接请求量比较大，建议调高此值，以增加并行连接数量，当然这建立在机器能支撑的情况下，因为如果连接数越多，介于MySQL会为每个连接提供连接缓冲区，就会开销越多的内存，所以要适当调整该值，不能盲目提高设值。
        + max_used_connections / max_connections * 100% （理想值≈ 85%）
        + max_used_connections跟max_connections相同 那么就是max_connections设置过低或者超过服务器负载上限了，低于10%则设置过大
    - back_log: MySQL能暂存的连接数量。当主要MySQL线程在一个很短时间内得到非常多的连接请求，这就起作用。如果MySQL的连接数据达到max_connections时，新来的请求将会被存在堆栈中，以等待某一连接释放资源，该堆栈的数量即back_log，如果等待连接的数量超过back_log，将不被授予连接资源。
        + back_log值指出在MySQL暂时停止回答新请求之前的短时间内有多少个请求可以被存在堆栈中。只有如果期望在一个短时间内有很多连接，你需要增加它，换句话说，这值对到来的TCP/IP连接的侦听队列的大小。
        + 默认数值是50，可调优为128，对于Linux系统设置范围为小于512的整数
* 缓冲区变量
    - key_buffer_size指定索引缓冲区的大小，它决定索引处理的速度，尤其是索引读的速度。通过检查状态值Key_read_requests和Key_reads，可以知道key_buffer_size设置是否合理。比例key_reads / key_read_requests应该尽可能的低，至少是1:100，1:1000更好（上述状态值可以使用SHOW STATUS LIKE ‘key_read%’获得）。
        + key_buffer_size只对MyISAM表起作用。即使不使用MyISAM表，但是内部的临时磁盘表是MyISAM表，也要使用该值。可以使用检查状态值created_tmp_disk_tables得知详情。
        + 计算索引未命中缓存的概率：`key_cache_miss_rate ＝Key_reads / Key_read_requests * 100%`，设置在1/1000左右较好
    - query_cache_size:使用查询缓冲，MySQL将查询结果存放在缓冲区中，今后对于同样的SELECT语句（区分大小写），将直接从缓冲区中读取结果
        + 如果Qcache_lowmem_prunes的值非常大，则表明经常出现缓冲不够的情况
        + 如果Qcache_hits的值也非常大，则表明查询缓冲使用非常频繁，此时需要增加缓冲大小
        + 如果Qcache_hits的值不大，则表明你的查询重复率很低，这种情况下使用查询缓冲反而会影响效率，那么可以考虑不用查询缓冲
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
    - INNODB_LOG_FILE_SIZE
* 模式
    - 严格模式

```sh
\s|status
chmod 644 /etc/my.cnf # 文件 /etc/my.conf 只能由 root 用户修改
cat /dev/null > ~/.mysql_history # 删除 MySQL shell 历史

bind-address = 127.0.0.1 # 将限制来自远程机器的访问，只接受来自本地主机的连接
local-infile=0 # 使用下面的指令以防止在 [mysqld] 部分从 MySQL 中访问底层文件系统。

[client]
datadir="F:/wamp/mysql/data"
default-character-set = utf8
default-collation=utf8_general_ci
port = 3306
socket = /data/3306/mysql.sock

[mysql]
no-auto-rehash

[mysqld]
user = mysql
port = 3306
socket = /data/3306/mysql.sock
basedir = /usr/local/mysql
datadir = /data/3306/data # 数据库文件路径
open_files_limit = 1024
default-time-zone = '+8:00' # 重启mysql使新时区生效
back_log = 600 #在MYSQL暂时停止响应新请求之前，短时间内的多少个请求可以被存在堆栈中。如果系统在短时间内有很多连接，则需要增大该参数的值，该参数值指定到来的TCP/IP连接的监听队列的大小。默认值50。
max_connections = 3000 #MySQL允许最大的进程连接数，如果经常出现Too Many Connections的错误提示，则需要增大此值。

default-storage-engine = INNODB
character-set-server = utf8
collation-server = utf8_general_ci
Port=5000 # 修改端口号
log=/var/log/mysql.log # 了解服务运行过程中发生了什么的最好的方法之一

log-slow-queries=/data/mysqldata/slow-query.log # 慢查询日志存放的位置，一般这个目录要有mysql的运行帐号的可写权限，一般都将这个目录设置为mysql的数据存放目录；
long_query_time=2     # 表示查询超过两秒才记录
log-queries-not-using-indexes  # 表示记录下没有使用索引的查询

table_cache = 614 #指示表调整缓冲区大小。table_cache 参数设置表高速缓存的数目。每个连接进来，都会至少打开一个表缓存。#因 此， table_cache 的大小应与 max_connections 的设置有关。例如，对于 200 个#并行运行的连接，应该让表的缓存至少 有 200 × N ，
external-locking = FALSE #使用–skip-external-locking MySQL选项以避免外部锁定。该选项默认开启
max_allowed_packet = 32M #设置在网络传输中一次消息传输量的最大值。系统默认值 为1MB，最大值是1GB，必须设置1024的倍数。
sort_buffer_size = 2M # Sort_Buffer_Size 是一个connection级参数，在每个connection（session）第一次需要使用这个buffer的时候，一次性分配设置的内存。Sort_Buffer_Size 并不是越大越好，由于是connection级的参数，过大的设置+高并发可能会耗尽系统内存资源。例如：500个连接将会消耗 500*sort_buffer_size(8M)=4G内存
join_buffer_size = 2M #用于表间关联缓存的大小，和sort_buffer_size一样，该参数对应的分配内存也是每个连接独享。
thread_cache_size = 300 # 服务器线程缓存这个值表示可以重新利用保存在缓存中线程的数量,当断开连接时如果缓存中还有空间,那么客户端的线程将被放到缓存中,如果线程重新被请 求，那么请求将从缓存中读取,如果缓存中是空的或者是新的请求，那么这个线程将被重新创建,如果有很多新的线程，增加这个值可以改善系统性能.通过比 较 Connections 和 Threads_created 状态的变量，可以看到这个变量的作用。设置规则如下：1GB 内存配置为8，2GB配 置为16，3GB配置为32，4GB或更高内存，可配置更大。
thread_concurrency = 8 # 设置thread_concurrency的值的正确与否, 对mysql的性能影响很大, 在多个cpu(或 多核)的情况下，错误设置了thread_concurrency的值, 会导致mysql不能充分利用多cpu(或多核), 出现同一时刻只能一个 cpu(或核)在工作的情况。thread_concurrency应设为CPU核数的2倍. 比如有一个双核的CPU, 那么 thread_concurrency的应该为4; 2个双核的cpu, thread_concurrency的值应为8
query_cache_size = 64M # 对于使用MySQL的用户，对于这个变量大家一定不会陌生。前几年的MyISAM引擎优化中，这个参数也是一个重要的优化参数。但随着发展，这个参 数也爆露出来一些问题。机器的内存越来越大，人们也都习惯性的把以前有用的参数分配的值越来越大。这个参数加大后也引发了一系列问题。我们首先分析一 下 query_cache_size的工作原理：一个SELECT查询在DB中工作后，DB会把该语句缓存下来，当同样的一个SQL再次来到DB里调用 时，DB在该表没发生变化的情况下把结果从缓存中返回给Client。这里有一个关建点，就是DB在利用Query_cache工作时，要求该语句涉及的 表在这段时间内没有发生变更。那如果该表在发生变更时，Query_cache里的数据又怎么处理呢？首先要把Query_cache和该表相关的语句全 部置为失效，然后在写入更新。那么如果Query_cache非常大，该表的查询结构又比较多，查询语句失效也慢，一个更新或是Insert就会很慢，这 样看到的就是Update或是Insert怎么这么慢了。所以在数据库写入量或是更新量也比较大的系统，该参数不适合分配过大。而且在高并发，写入量大的 系统，建议把该功能禁掉。
query_cache_limit = 4M #指定单个查询能够使用的缓冲区大小，缺省为1M
transaction_isolation = READ-COMMITTED
tmp_table_size = 256M # tmp_table_size 的默认大小是 32M。如果一张临时表超出该大小，

myisam_sort_buffer_size = 128M # MyISAM表发生变化时重新排序所需的缓冲
myisam_max_sort_file_size = 10G # MySQL重建索引时所允许的最大临时文件的大小 (当 REPAIR, ALTER TABLE 或者 LOAD DATA INFILE).如果文件大小比此值更大,索引会通过键值缓冲创建(更慢)
myisam_max_extra_sort_file_size = 10G
myisam_repair_threads = 1 # 如果一个表拥有超过一个索引, MyISAM 可以通过并行排序使用超过一个线程去修复他们.这对于拥有多个CPU以及大量内存情况的用户,是一个很好的选择.

server-id = 1 # 开启binlog日志
log_bin=/var/log/mysql/mysql-bin.log
binlog_rows_query_log_events=on # 记录SQL

innodb_file_io_threads = 4 #文件IO的线程数，一般为 4，但是在 Windows 下，可以设置得较大。
innodb_thread_concurrency = 8 #服务器有几个CPU就设置为几，建议用默认设置，一般为8.
innodb_buffer_pool_size= 2048M # 如果是单实例且绝大多数是InnoDB引擎表的话，可考虑设置为物理内存的50% ~ 70%左右.Innodb相比MyISAM表对缓冲更为敏感。MyISAM可以在默认的 key_buffer_size 设置 下运行的可以，然而Innodb在默认的 innodb_buffer_pool_size 设置下却跟蜗牛似的。由于Innodb把数据和索引都缓存起 来，无需留给操作系统太多的内存，因此如果只需要用Innodb的话则可以设置它高达 70-80% 的可用内存。
innodb_data_file_path = ibdata1:1G:autoextend # 表空间文件 重要数据 千万不要用默认的10M，否则在有高并发事务时，会受到不小的影响
innodb_flush_log_at_trx_commit = 2 # 如果将此参数设置为1，将在每次提交事务后将日志写入磁盘。为提供性能，可以设置为0或2，但要承担在发生故障时丢失数据的风险。设置为0表示事务日 志写入日志文件，而日志文件每秒刷新到磁盘一次。设置为2表示事务日志将在提交时写入日志，但日志文件每次刷新到磁盘一次。
innodb_log_file_size=256M # 此参数确定数据日志文件的大小，以M为单位，更大的设置可以提高性能，但也会增加恢复故障数据库所需的时间
innodb_log_buffer_size = 16M #此参数确定些日志文件所用的内存大小，以M为单位。缓冲区更大能提高性能，但意外的故障将会丢失数据.MySQL开发人员建议设置为1－8M之间
innodb_log_files_in_group=3 # MySQL可以以循环方式将日志文件写到多个文件。推荐设置为3M
innodb_file_per_table = 0 #独享表空间（关闭）
innodb_lock_wait_timeout = 120 # InnoDB 有其内置的死锁检测机制，能导致未完成的事务回滚。但是，如果结合InnoDB使用MyISAM的lock tables 语句或第三 方事务引擎,则InnoDB无法识别死锁。为消除这种可能性，可以将innodb_lock_wait_timeout设置为一个整数值，指 示 MySQL在允许其他事务修改那些最终受事务回滚的数据之前要等待多长时间(秒数)
innodb_max_dirty_pages_pct = 90 # Buffer_Pool中Dirty_Page所占的数量，直接影响InnoDB的关闭时间。

transaction-isolation = REPEATABLE-READ # 全局事物隔离级别
max_connection_error = 6000 #（最大错误数，建议设置为10万以上，而open_files_limit、innodb_open_files、table_open_cache、table_definition_cache这几个参数则可设为约10倍于max_connection的大小

[mysqldump]
quick
max_allowed_packet = 32M

[mysqld_safe]
log-error=/data/3306/mysql_oldboy.err
pid-file=/data/3306/mysqld
```

```sql
status # 查看连接信息
select version();
SHOW VARIABLES LIKE "character_set%"; # character_set_client  接受的客户端编码  character_set_result # 返回结果集的编码
SET character_set_client=GBK; # 不一致的话,修改
set names gbk # 修改client connection results字符集

SHOW CHARACTER SET [LIKE 'pattern']/SHOW CHARSET [LIKE 'pattern']    # 查看所有字符集
SHOW COLLATION [LIKE 'pattern']        # 查看所有校对集

# 出现ERROR 1040: Too many connections错误,修正max_connections的值
show variables like 'max_connections';  # 最大连接数
show status like 'max_used_connections'; # 响应的连接数

show full processlist;

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

show variables like '%time_zone%';

# 仅修改当前会话的时区，停止会话失效
set time_zone = '+8:00';
# 修改全局的时区配置
set global time_zone = '+8:00';
flush privileges;
# 8.0 GA版本开始支持将参数写入并且持久化：
set persist time_zone='+0:00';

select now();
select curtime();
```

```sh
# mysqladmin
mysqld --initialize
```

### 权限管理

* 权限列表
    - ALL [PRIVILEGES]    -- 设置除GRANT OPTION之外的所有简单权限
    - ALTER    -- 允许使用ALTER TABLE
    - ALTER ROUTINE    -- 更改或取消已存储的子程序
    - CREATE    -- 允许使用CREATE TABLE
    - CREATE ROUTINE    -- 创建已存储的子程序
    - CREATE TEMPORARY TABLES        -- 允许使用CREATE TEMPORARY TABLE
    - CREATE USER        -- 允许使用CREATE USER, DROP USER, RENAME USER和REVOKE ALL PRIVILEGES。
    - CREATE VIEW        -- 允许使用CREATE VIEW
    - DELETE    -- 允许使用DELETE
    - DROP    -- 允许使用DROP TABLE
    - EXECUTE        -- 允许用户运行已存储的子程序
    - FILE    -- 允许使用SELECT...INTO OUTFILE和LOAD DATA INFILE
    - INDEX     -- 允许使用CREATE INDEX和DROP INDEX
    - INSERT    -- 允许使用INSERT
    - LOCK TABLES        -- 允许对您拥有SELECT权限的表使用LOCK TABLES
    - PROCESS     -- 允许使用SHOW FULL PROCESSLIST
    - REFERENCES    -- 未被实施
    - RELOAD    -- 允许使用FLUSH
    - REPLICATION CLIENT    -- 允许用户询问从属服务器或主服务器的地址
    - REPLICATION SLAVE    -- 用于复制型从属服务器（从主服务器中读取二进制日志事件）
    - SELECT    -- 允许使用SELECT
    - SHOW DATABASES    -- 显示所有数据库
    - SHOW VIEW    -- 允许使用SHOW CREATE VIEW
    - SHUTDOWN    -- 允许使用mysqladmin shutdown
    - SUPER    -- 允许使用CHANGE MASTER, KILL, PURGE MASTER LOGS和SET GLOBAL语句，mysqladmin debug命令；允许您连接（一次），即使已达到max_connections。
    - UPDATE    -- 允许使用UPDATE
    - USAGE    -- “无权限”的同义词
    - GRANT OPTION    -- 允许授予权限
* 插件
    - auth_socket plugin：　`sudo mysql` 直接登录

```sql
mysql -hlocalhost  -P 3306 -u root -p  # 生成用户root与空密码登陆,第一次登陆mysql的时候是没有密码的

exit|quit| \q

mysqld --skip-grant-tables /* 跳过权限验证登录MySQL */

SELECT user,authentication_string,plugin,host FROM mysql.user;
CREATE USER 'lee'@'localhost' IDENTIFIED [WITH mysql_native_password] BY '123456Ac&' # 添加用户
GRANT ALL PRIVILEGES ON test.*/user.*/ TO lee@'localhost' [IDENTIFIED BY 'root密码' WITH GRANT OPTION];
FLUSH PRIVILEGES;

ALTER USER `root`@`localhost` IDENTIFIED WITH caching_sha2_password BY 'password';
RENAME USER old_user TO new_user;

select user(); # 当前连接数据库的用户

show grants for 'testuser'@'localhost';
SHOW GRANTS FOR CURRENT_USER();

# 更新密码
SET PASSWORD = PASSWORD('密码')    -- 为当前用户设置密码
SET PASSWORD FOR 用户名 = PASSWORD('密码')    -- 为指定用户设置密码
update mysql.user SET Password = PASSWORD('密码') where User = 'root';
FLUSH PRIVILEGES;

DROP USER 'user'@'localhost'
REVOKE CREATE,DROP,INSERT,UPDATE,SELECT,DELETE ON database_name.table_name FROM ‘username’@‘localhost’;

## 重置root密码 获取临时密码
grep 'temporary password' /var/log/mysqld.log

# mariadb 重置root密码
sudo systemctl stop mysqlsudo systemctl set-environment MYSQLD_OPTS="--skip-grant-tables --skip-networking"
sudo systemctl start mariadb
sudo mysql -u rootUPDATE mysql.user SET password = PASSWORD('new_password') WHERE user = 'root';
UPDATE mysql.user SET authentication_string = '' WHERE user = 'root';
UPDATE mysql.user SET plugin = '' WHERE user = 'root';s
sudo systemctl restart mariadb

SHOW PROCESSLIST # 显示哪些线程正在运行
SHOW VARIABLES
```

### 数据类型

* 整型
    - tinyint       0-255 或 -2^7~2^7-1 1个字节
    - smallint      -2^15~2^15-1        2个字节
    - mediumint     -2^23~2^23-1        3个字节
    - int           0-2^32-1            4个字节
    - bigint        0-2^64-1            8个字节
    - 显示宽度int(11):最小显示位数(默认不起作用),zerofill会用0填充,不决定数据大小
        + 默认存在符号位，unsigned 修改无符号数
        + 如果某个数不够定义字段时设置的位数，则前面以0补填，zerofill 属性修改 例：int(5)    插入一个数'123'，补填后为'00123'
* 浮点型:
    - 单精度 float(M,D)  (论上可以保留7位小数) 3.4E+38~3.4E+38     4个字节
    - 双精度 double(M,D) (理论上保留15位小数) -1.8E+308~1.8E+308  8个字节
    - M表示总位数，D表示小数位数。M和D的大小会决定浮点数的范围,不同于整型的固定范围
    - M既表示总位数（不包括小数点和正负号），也表示显示宽度（所有显示符号均包括）
    - 表示近似值，精度会丢失,不要作比较
    - 浮点数的执行效率要高于定点数
    - 支持符号位 unsigned 属性，也支持显示宽度 zerofill 属性
* 定点数:decimal(M,D)，M的最大值是65，D的最大值是30，默认是（10,0）
    - 使用二进制格式将9个十进制(基于10)数压缩为4个字节来表示DECIMAL列值
    - M整数与小数部分的总长度， D指的是小数部分的长度
    - 注意:定点数的值是精确的数值，浮点数会失去精度
    - 支持显示宽度，支持无符号
* **字符**
    - char(M) 定长字符串，速度快，但浪费空间
        + 固定长度，范围0-255个字符，与编码无关
        + 不足的话右边填充空格以达到指定的长度
        + 存取速度比varchar要快得多，因为其长度固定，方便程序的存储与查找
        + 当检索/读取到CHAR值时，尾部的空格被删除掉
        + 付出的是空间的代价，因为其长度固定，所以会有多余的空格占位符占据空间，可谓是以空间换取时间效率
    - varchar(M) 自动伸缩型 变长字符串，速度慢，但节省空间
        + 长度支持到了65535字节，与编码有关，M为最大字符个数
            * 英文字符（ASCII）占用1个字节，汉字占用两个字节
            * utf-8状态下，每个字符最多占3个字节，汉字最多可以存 21844个字符串,英文也为 21844个字符串
            * 在gbk状态下，每个字符最多占2个字节，汉字最多可以存 32766个字符串，英文也为 32766个字符串
            * latin1 最大为65532个字符
        + 占用需要的空间
        + 使用额外的1到2字节存储长度，列小于255使用1字节保存长度，大于255使用2字节保存
        + 最大有效长度由最大行大小和使用的字符集确定
        + 最大有效长度是65532字节，因为在varchar存字符串时，第一个字节是空的，不存在任何数据，然后还需两个字节来存放字符串的长度，所以有效长度是64432-1-2=65532字节
        + 在5.0.3以下的版本中的最大长度限制为255，而在5.0.3及以上的版本中
        + 值保存和检索时尾部的空格仍保留
    - M表示能存储的最大长度，此长度是字符数，非字节数
    - 分配给CHAR或VARCHAR列的值超过列的最大长度，则对值进行裁剪以使其适合。如果被裁掉的字符不是空格，则会产生一条警告
    - 超过255字符的只能用varchar或者text
    - blob 二进制字符串（字节字符串）
        +  tinyblob
        +  blob
        +  mediumblob
        +  longblob
    - text 非二进制字符串（字符字符串）
        + tinytext: 2^8-1
        + text 2^16-1 不可以有默认值，能用varchar的地方不用text，占用字节比varchar大太多
        + mediumtext 中型文本型 2^24-1 0－1677个字符
        + longtext 大型文本 2^32-1 0-42亿个字符
    - blob和text唯一区别就是blob保存二进制数据、没有字符集和排序规则
* 日期时间
    - date 3字节 1000-01-01 - 9999-12-31 current_date
    - year 1字节 1901 - 2155
    - time 3字节 -838:59:59 - 838:59:59 10:09:08  CURRENT_TIME()
        +  ADDTIME(CURRENT_TIME(), 023000),  SUBTIME(CURRENT_TIME(), 023000);
        +  TIMEDIFF(end_at, start_at)
        +  TIME_FORMAT(start_at, '%h:%i %p') start_at
        +  UTC_TIME()
    - datetime 8字节 '1000-01-01 00:00:00' - '9999-12-31 23:59:59'，精度是秒
        + Strict mode (and more specifically NO_ZERO_DATE which is part of strict mode) usually sets off that error if the table was created with an all zero default date
        + 查看 SELECT @@sql_mode，使用1970-01-01 00:00:01
    - timestamp：4字节 自 1970年1月1日午夜以来的秒数，和unix时间戳相同，19700101000000 到 2038-01-19 03:14:07。默认timestamp值 为 NOT NULL， current_timestamp
    - 默认值：datetime or timestrap 默认值 CURRENT_TIMESTAMP
* enum(val1, val2, val3...)
    - 在已知的值中进行单选。最大数量为65535
    - 枚举值在保存时，以2个字节的整型(smallint)保存。每个枚举值，按保存的位置顺序，从1开始逐一递增
    - 表现为字符串类型，存储却是整型
    - NULL值的索引是NULL
    - 空字符串错误值的索引值是0
* set(val1, val2, val3...)
    - 最多可以有64个不同的成员。以bigint存储，共8个字节。采取位运算的形式
    - 当创建表时，SET成员值的尾部空格将自动被删除
* ip:通常使用varchar(15)保存IP地址
    * INET_ATON('127.0.0.1') 将IP转为整型
    * INET_NTOA(2130706433) 将整型转为IP
    * ip2long可转换为整型，但会出现携带符号问题。需格式化为无符号的整型 `sprintf("%u", ip2long('192.168.3.134'));`
    * long2ip将整型转回IP字符串
* json
    - 不能有默认值
    - 添加
        + 可以是对象的形式，也可以是数组的形式
        + 用函数 JSON_OBJECT，JSON_ARRAY 生成 json 格式的数据
    - 查询
        + JSON_UNQUOTE 函数将双引号去掉，与操作符 ->> 等价
        + 对象类型 path 这样表示 column->$.path, 而数组类型则是 column->$[index]
    - 搜索
        + 用字符串和 JSON 字段比较，是不会相等的
        + CAST 将字符串转成 JSON
        + column->path 形式从 select 中查询出来的字符串是包含双引号的，但作为条件这里其实没什么影响，-> 和 ->> 结果是一样的
        + 严格区分变量类型的，比如说整型和字符串是严格区分
        + JSON_CONTAINS 第二个参数是不接受整数的，必须字符串
        + JSON_INSERT() 插入新值，但不会覆盖已经存在的值
        + JSON_SET() 插入新值，并覆盖已经存在的值

```sql
`last_opt_time` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后操作时间'; # 创建、修改记录的时候都刷新
`create_time` TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'; # 创建的时候把这个字段设置为当前时间，但以后修改时，不再刷新
`update_time` TIMESTAMP DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'; # 创建的时候把这个字段设置为空或定值，以后修改时刷新

CREATE TABLE lnmp (
    `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
    `category` JSON,
    `tags` JSON,
    PRIMARY KEY (`id`)
);
INSERT INTO `lnmp` (category, tags) VALUES ('{"id": 1, "name": "lnmp.cn"}', '[1, 2, 3]');
INSERT INTO `lnmp` (category, tags) VALUES (JSON_OBJECT("id", 2, "name", "php.net"), JSON_ARRAY(1, 3, 5));
SELECT id, category->'$.id', category->'$.name', tags->'$[0]', tags->'$[2]' FROM lnmp;
SELECT id, JSON_UNQUOTE(category->'$.name'), category->>'$.name' FROM lnmp;

SELECT * FROM lnmp WHERE category = CAST('{"id": 1, "name": "lnmp.cn"}' as JSON);
SELECT * FROM lnmp WHERE category->'$.name' = 'lnmp.cn'; # category->>'$.name' = 'lnmp.cn';
SELECT * FROM lnmp WHERE category->'$.id' = 1; # 不能 ‘1’
SELECT * FROM lnmp WHERE JSON_CONTAINS(category, '1', '$.id');
SELECT * FROM lnmp WHERE JSON_CONTAINS(tags, '2');
UPDATE lnmp SET tags = '[1, 3, 4]' WHERE id = 1;
UPDATE lnmp SET category = JSON_INSERT(category, '$.name', 'lnmp', '$.url', 'www.lnmp.cn') WHERE id = 1;
UPDATE lnmp SET category = JSON_SET(category, '$.host', 'www.lnmp.cn', '$.url','http://www.lnmp.cn') WHERE id = 1;
UPDATE lnmp SET category = JSON_REPLACE(category, '$.name', 'php', '$.url', 'http://www.php.net') WHERE id = 2;
UPDATE lnmp SET category = JSON_REMOVE(category, '$.url', '$.host') WHERE id = 1;

select max(created_at) begin, min(created_at) end,max(created_at)-min(created_at) as time from tmo_loyalty_customersync_log where created_at > '2019-09-12 08:00:00' and created_at < '2019-09-12 09:00:00'
selECT * FROM cron_schedule  where job_code='tmo_sync_jde_customers';

select day(timestamp) as Day, hour(timestamp) as Hour, count(*) as Count from MyTable where timestamp between :date1 and :date2 group by day(timestamp), hour(timestamp)

select max(created_at) begin, min(created_at) end,max(created_at)-min(created_at) as time from tmo_loyalty_customersync_log  group by year(created_at),month(created_at),day(created_at),hour(created_at)  order by begin desc limit 10;
```

### 数据操作

* 列属性
    - 主键
        + 能唯一标识记录的字段，可以作为主键
        + 一个表只能有一个主键
        + 主键具有唯一性
        + 声明字段时，用 primary key 标识，也可以在字段列表之后声明`create table tab ( id int, stu varchar(10), primary key (id));`
        + 主键字段的值不能为null
        + 主键可以由多个字段共同组成。此时需要在字段列表后声明的方法 `create table tab ( id int, stu varchar(10), age int, primary key (stu, age));`
    - unique 唯一索引（唯一约束） 使得某字段的值也不能重复
    - NOT NULL | NULL(默认)：字段值是否可以为空
    - DEFAULT value：默认值属性
    - AUTO_INCREMENT，指定列的值是自动增长型
        + 一个数据表，只能有一个主键和一个自动增长型
        + 自动增长必须为索引（主键或unique）
        + 默认为1开始自动增长。可以通过表属性 auto_increment = x进行设置，或 alter table tbl auto_increment = x
        + 数据表的id字段，必须要有 not null primary key auto_incremtn 这三个属性
    - ALIAS:别名
        + 涉及超过一个表
        + 在查询中使用了函数
        + 列名称很长或者可读性差
        + 需要把两个列或者多个列结合在一起
    - COMMENT:注释
    - foreign key 外键约束： 用于限制主表与从表数据完整性 `alter table t1 add constraint `t1_t2_fk` foreign key (t1_id) references t2(id);`
        + 外键只被InnoDB存储引擎所支持。其他引擎是不支持的
        + 存在外键的表，称之为从表（子表），外键指向的表，称之为主表（父表）
        + 作用：保持数据一致性，完整性，主要目的是控制存储在外键表（从表）中的数据
        + `foreign key (外键字段） references 主表名 (关联字段) [主表记录删除时的动作] [主表记录更新时的动作]`
        + 定了 on update 或 on delete：在删除或更新时，有如下几个操作可以选择：
            - cascade，级联操作。主表数据被更新（主键值更新），从表也被更新（外键值更新）。主表记录被删除，从表相关记录也被删除。
            - set null，设置为null。主表数据被更新（主键值更新），从表的外键被设置为null。主表记录被删除，从表相关记录外键被设置成null。但注意，要求该外键列，没有not null属性约束。
            - restrict，拒绝父表删除和更新

```sql
SHOW DATABASES;
CREATE DATABASE IF NOT EXISTS db_name [CHARACTER SET utf8 COLLATE utf8_unicode_ci];  # 特殊符号、关键字表名加``
ALTER DATABASE db_name charset=utf8;
alter database 库名 选项信息
DROP DATABASE [IF EXISTS] db_name;
show databases[ like 'pattern']
SHOW CREATE DATABASE db_name;

USE db_name;
select database();  # 查看当前使用的数据库
SHOW TABLE STATUS [FROM db_name] [LIKE 'pattern'] # 查看数据库状态
select now(), user(), version();

SHOW TABLES [ LIKE 'pattern'];

DESCRIBE|DESC|EXPLAIN news;
show columns from news;
show index from table_name;
show keys from table_name;
SHOW CREATE TABELE news\G;

CREATE TABLE IF NOT EXISTS test.news(
  # 字段名 数据类型 [NOT NULL | NULL] [DEFAULT default_value] [AUTO_INCREMENT] [UNIQUE [KEY] | [PRIMARY] KEY] [COMMENT 'string']
  id int NOT null AUTO_INCREMENT primary KEY,
  title varchar(100) not null comment '名称',
  author varchar(20) not null comment '作者',
  sex bit(1) NOT NULL DEFAULT b'1',
  source varchar(30) not null comment '来源',
  hits int(5) not null DEFAULT 0 comment '点击率',
  context text null comment '内容',
  adddate int(16) not null comment '添加时间',
  PRIMARY KEY (Id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 collate=utf8_bin;
CREATE TABLE table_name SELECT column1,cloumn2 FROM another_table: # 复制数据不复制主键
CREATE TABLE table_name like another_table；  #  复制表结构 数据不复制，主键复制
INSERT office_dup SELECT * FROM offices;

ALTER TABLE table_name ADD address varchar(30) first| after name;
ALTER TABLE table_name DROP address;
ALTER TABLE table_name MODIFY address varchar(100);
ALTER TABLE table_name CHANGE address add varchar(100) after id;
ALTER TABLE table_name ENGINE=MYISAM;
ALTER TABLE table_name rename to new_table_name;
RENAME table table_name to new_table_name, tb3 TO tb4;
ALTER TABLE table_name rename to another_DB.new_table_name; # 移动表

CREATE [UNIQUE|FULLTEXT]  INDEX index_name on tbl_name (col_name [(length)] [ASC | DESC] , …..);
ALTER TABLE 'table_name' ADD PRIMARY KEY'index_name' ('column');
ALTER TABLE 'table_name' ADD UNIQUE 'index_name' ('column');
ALTER TABLE 'table_name' ADD INDEX idx_user(name(10) , city , age); # 因为一般情况下名字的长度不会超过10，这样会加速索引查询速度，还会减少索引文件的大小，提高INSERT的更新速度。

ALTER TABLE 'table_name' ADD FULLTEXT 'index_name' ('column');
ALTER TABLE 'table_name' ADD INDEX 'index_name' ('column1', 'column2', ...);
ALTER TABLE 'table_name' DROP PRIMARY KEY;    # 删除主键(删除主键前需删除其AUTO_INCREMENT属性)
ALTER TABLE 'table_name' DROP INDEX 索引名;   # 删除索引
ALTER TABLE 'table_name' DROP FOREIGN KEY 外键;  # 删除外键
DROP INDEX index_name ON tbl_name;

INSERT INTO table_name values (null,值,default,....); # 全字段插入，自动增长列用null
INSERT INTO table_name values (null,值,....),(null,值,....),(null,值,....); # 插入多条数据
INSERT INTO table_name (字段1,字段2,字段3,…) VALUES (值1,值2,值3,…),(值1,值2,值3,…);   # 记录操作：添加 更新与删除数据(新增与修改不用添加TABLE关键字)
INSERT INTO table_name set volumn1=value1,volumn3=value3,volumn3=value3;
insert into tbl_name select ...;
insert into tbl_name values/set/select on duplicate key update 字段=值, …; # 可以指定在插入的值出现主键（或唯一索引）冲突时，更新其他非主键列的信息

UPDATE table_name SET 字段1 = 新值1, 字段2 = 新值2  [WHERE条件]; # 更新记录
UPDATE base SET `count` = `count` + 1；

DROP TABLE [IF EXISTS] db_name;
DELETE FROM table_name;  # 清空数据表：逐条删除
TRUNCATE TABLE table_name;  # 删除表,重建同结构;重置auto_increment的值。而delete不会 不知道删除了几条，而delete知道;当被用于带分区的表时，truncate 会保留分区
DELETE FROM tbl_name [WHERE where_definition] [ORDER BY ...] [LIMIT row_count]
delete from 表1，表2 using 表连接操作 条件

CHECK TABLE tbl_name [, tbl_name] ... option = {QUICK | FAST | MEDIUM | EXTENDED | CHANGED} # 检查表是否有错误
OPTIMIZE [LOCAL | NO_WRITE_TO_BINLOG] TABLE tbl_name [, tbl_name] ... # 整理数据文件的碎片
REPAIR [LOCAL | NO_WRITE_TO_BINLOG] TABLE tbl_name [, tbl_name] ... [QUICK] [EXTENDED] [USE_FRM] #修复表
ANALYZE [LOCAL | NO_WRITE_TO_BINLOG] TABLE tbl_name [, tbl_name] ... # 分析和存储表的关键字分布
```

## 表设计规范

* 库名、表名、字段名：小写，下划线风格，不超过32个字符，必须见名知意，禁止拼音英文混用
* 表名t_xxx，非唯一索引名idx_xxx，唯一索引名uniq_xxx
* Normal Format, NF
    - 每个表保存一个实体信息
    - 每个具有一个ID字段作为主键
    - ID主键 + 原子表
* 数据库范式
    - 第一范式(1NF)：字段值具有原子性,不能再分(所有关系型数据库系统都满足第一范式); 例如：姓名字段,其中姓和名是一个整体,如果区分姓和名那么必须设立两个独立字段
    - 第二范式(2NF)：满足第一范式的前提下，不能出现部分依赖。 消除符合主键就可以避免部分依赖。增加单列关键字
    - 第三范式(3NF)：满足第二范式的前提下，不能出现传递依赖。 某个字段依赖于主键，而有其他字段依赖于该字段。这就是传递依赖。将一个实体信息的数据放在一个表内实现。
* 范式和反范式：对千任何给定的数据通常都有很多种表示方法， 从完全的范式化到完全的反范式化， 以及两者的折中。 在范式化的数据库中， 每个事实数据会出现并且只出现一次。 相反， 在反范式化的数据库中， 信息是冗余的， 可能会存储在多个地方
    - 范式的优点和缺点：为性能提升考虑时，经常会被建议对 schema 进行范式化设计，尤其是写密集的场
    - 范式化的更新操作通常比反范式化要快
    - 当数据较好地范式化时，就只有很少或者没有重复数据，所以只需要修改更少的数据
    - 范式化的表通常更小，可以更好地放在内存里，所以执行操作会更快
    - 很少有多余的数据意味着检索列表数据时更少需要 DISTINCT 或者 GROUP BY语句。
    - 反范式的优点和缺点
        + 不需要关联表，则对大部分查询最差的情况----即使表没有使用索引----是全表扫描
        + 当数据比内存大时这可能比关联要快得多，因为这样避免了随机I/0
        + 单独的表也能使用更有效的索引策略
    - 混用范式化和反范式化：在实际应用中经常需要混用，可能使用部分范式化的 schema 、 缓存表，以及其他技巧。 表适当增加冗余字段，如性能优先，但会增加复杂度。可避免表关联查询

## 查询

* `select [all|distinct] select_expr from -> where -> group by [合计函数] -> having -> order by -> limit`
* distinct, all 选项: distinct 去除重复记录 默认为 all, 全部记录
* 字段列表：指要显示指定列的数据
    - 多个字段之间用逗号隔开，各字段之间没有顺序
    - `*` 显示所有字段的数据
    - 可以使用表达式（计算公式、函数调用、字段也是个表达式）
    - 可以为每个列使用别名。适用于简化列标识，避免多个列标识符重复
* from 子句:用于标识查询来源
    - 可以为表起别名。使用as关键字`select * from tb1 as tt, tb2 as bb;`
    - from子句后，可以同时出现多个表。 多个表会横向叠加到一起，而数据会形成一个笛卡尔积 `select * from tb1, tb2;`
* where 子句
    - Index Key：用于确定SQL查询在索引中的连续范围(起始范围+结束范围)的查询条件，被称之为Index Key。由于一个范围，至少包含一个起始与一个终止，因此Index Key也被拆分为Index First Key和Index Last Key，分别用于定位索引查找的起始，以及索引查询的终止条件。
        + Index First Key：用于确定索引查询的起始范围。提取规则：从索引的第一个键值开始，检查其在where条件中是否存在，若存在并且条件是=、>=，则将对应的条件加入Index First Key之中，继续读取索引的下一个键值，使用同样的提取规则；若存在并且条件是>，则将对应的条件加入Index First Key中，同时终止Index First Key的提取；若不存在，同样终止Index First Key的提取。
        + Index Last Key：Index Last Key的功能与Index First Key正好相反，用于确定索引查询的终止范围。提取规则：从索引的第一个键值开始，检查其在where条件中是否存在，若存在并且条件是=、<=，则将对应条件加入到Index Last Key中，继续提取索引的下一个键值，使用同样的提取规则；若存在并且条件是 < ，则将条件加入到Index Last Key中，同时终止提取；若不存在，同样终止Index Last Key的提取。
    - Index Filter：根据where条件固定了索引的查询范围，但是此范围中的项，并不都是满足查询条件的项。提取规则：同样从索引列的第一列开始，检查其在where条件中是否存在：若存在并且where条件仅为 =，则跳过第一列继续检查索引下一列，下一索引列采取与索引第一列同样的提取规则；若where条件为 >=、>、<、<= 其中的几种，则跳过索引第一列，将其余where条件中索引相关列全部加入到Index Filter之中；若索引第一列的where条件包含 =、>=、>、<、<= 之外的条件，则将此条件以及其余where条件中索引相关列全部加入到Index Filter之中；若第一列不包含查询条件，则将所有索引相关条件均加入到Index Filter之中。
    - Table Filter:提取规则：所有不属于索引列的查询条件，均归为Table Filter之中。
    - 运算数：变量（字段）、值、函数返回值
    - 运算符：!＝ =, <=>, <>, !=, <=, <, >=, >, !, &&, ||, in (not) null, (not) like, (not) in, (not) between and, is (not), and, or, not, xor is/is not 加上ture/false/unknown，检验某个值的真假 <=>与<>功能相同，<=>可用于null比较
    - LIKE('name%') NOT LIKE('name%') 匹配
        + % :0 个或多个字符
        + _ :一个字符
        + [charlist] 字符列中的任何单一字符
        + [^charlist]或[!charlist] 不在字符列中的任何单一字符 WHERE name REGEXP '^[GFs]'；name REGEXP '^[^A-H]'
* group by 子句:分组子句 `group by 字段/别名 ASC|DESC`, 以下[合计函数]配合 group by 使用
    - count 返回不同的非NULL值数目    count(*)、count(字段)
    - sum 求和
    - max 求最大值
    - min 求最小值
    - avg 求平均值
    - group_concat 返回带有来自一个组的连接的非NULL值的字符串结果。组内字符串连接。
* having 子句，条件子句
    - 与 where 功能、用法相同，执行时机不同。
    - where 在开始时执行检测数据，对原数据进行过滤;having 对筛选出的结果再次进行过滤。
    - having 字段必须是查询出来的，where 字段必须是数据表存在的。
    - where 不可以使用字段的别名，having 可以。因为执行WHERE代码时，可能尚未确定列值。
    - where 不可以使用合计函数。一般需用合计函数才会用 having
    - SQL标准要求HAVING必须引用GROUP BY子句中的列或用于合计函数中的列。
* ORDER BY `order by 排序字段/别名 ASC|DESC [,排序字段/别名 排序方式] ...`
    - ORDER BY 联合指的是如果 ORDER BY 后面的字段是联合索引覆盖 where 条件之后的一个字段，由于索引已经处于有序状态，MySQL 就会直接从索引上读取有序的数据，然后在磁盘上读取数据之后按照该顺序组织数据，从而减少了对磁盘数据进行排序的操作。
    - 对于未覆盖 ORDER BY 的查询，其有一项 Creating sort index，即为磁盘数据进行排序的耗时最高；对于覆盖 ORDER BY 的查询，其就不需要进行排序，而其耗时主要体现在从磁盘上拉取数据的过程。
* limit 子句，限制结果数量子句 `imit 起始位置, 获取条数`
    - 仅对处理好的结果进行数量限制。将处理好的结果的看作是一个集合，按照记录出现的顺序，索引从0开始。
    - 省略第一个参数，表示从索引0开始
* UNION: 将多个select查询的结果组合成一个结果集合, `SELECT ... UNION [ALL|DISTINCT] SELECT ...`
    - 默认 DISTINCT 方式，即所有返回的行都是唯一的
    - 建议，对每个SELECT查询加上小括号包裹
    - ORDER BY 排序时，需加上 LIMIT 进行结合
    - 需要各select查询的字段数量一样
    - 每个select查询的字段列表(数量、类型)应一致，因为结果中的字段名以第一条select语句为准
* 连接查询(join)将多个表的字段通过指定连接条件进行连接
    - 公共字段名字可以不一样，但是数据类型必须一样
    - 联表查询降低查询速度
    - 数据冗余与查询速度的平衡
    - 内连接(inner join) 默认,可省略inner
        + 只有数据存在时才能发送连接。即连接结果不能出现空行
        + on 表示连接条件。其条件表达式与where类似。也可以省略条件（表示条件永远为真）
        + where表示连接条件 `select info.id, info.name, info.stu_num, extra_info.hobby, extra_info.sex from info, extra_info where info.stu_num = extra_info.stu_id;`
        + `using(字段名)`:需字段名相同。
        + 交叉连接 cross join 即没有条件的内连接  `select * from tb1 cross join tb2;`
    - 外连接(outer join)
        + 如果数据不存在，也会出现在连接结果中
        + 左外连接 left join 如果数据不存在，左表记录会出现，而右表为null填充
        + 右外连接 right join 如果数据不存在，右表记录会出现，而左表为null填充
    - 自然连接(natural join):自动判断连接条件完成连接, 相当于省略了using，会自动查找相同字段名
* 子查询:用括号包裹
    - from型:from后要求是一个表，必须给子查询结果取个别名 `select * from (select * from tb where id>0) as subfrom where id>1;`
        + 简化每个查询内的条件
        + from型需将结果生成一个临时表格，可用以原表的锁定的释放
        + 子查询返回一个表，表型子查询
    - where型 `select * from tb where money = (select max(money) from tb);`
        + 子查询返回一个值，标量子查询
        + 不需要给子查询取别名
        + where子查询内的表，不能直接用以更新
            * 列子查询
                - 如果子查询结果返回的是一列,使用 in 或 not in 完成查询
                - exists 和 not exists 条件 如果子查询返回数据，则返回1或0。常用于判断条件。`select column1 from t1 where exists (select * from t2);`
            * 行子查询:用于与对能返回两个或两个以上列的子查询进行比较
                - 查询条件是一个行。`select * from t1 where (id, gender) in (select id, gender from t2);`
                - 行构造符：(col1, col2, ...) 或 ROW(col1, col2, ...)
            * 特殊运算符
                - != all()    相当于 not in
                - = some()    相当于 in。any 是 some 的别名
                - != some()    不等同于 not in，不等于其中某一个
                - all, some 可以配合其他运算符一起使用

```sql
SELECT [DISTINCT] 字段列表|* FROM table_name [WHERE条件][ORDER BY排序(默认是按id升序排列)][LIMIT (startrow ,) pagesize];
SELECT id,title,author,hits,addate from news ORDER BY id DESC LIMIT 10,10; # limit [offset,]rowcount:offset 为偏移量，而非主键id
SELECT * FROM rp_evaluate LIMIT 500 * $i, 500
SELECT `rp_e_id`,`evaluate` FROM `rp_evaluate` WHERE `rp_e_id` > 0 LIMIT 500
SELECT column_name AS alias_name FROM table_name;
SELECT column_name(s) FROM table_name AS alias_name;
SELECT w.name, w.url, a.count, a.date FROM Websites AS w, access_log AS a WHERE a.site_id=w.id and w.name="菜鸟教程";
SELECT concat('a', 'b') # ab
SELECT concat_ws(',', 'a', 'b') # e,t
SELECT GROUP_CONCAT(c_name) FROM categories WHERE school_id =1 # 字符拼接

SELECT COUNT(DISTINCT index_column)/COUNT(*) FROM table_name; -- index_column代表要添加前缀索引的列，前缀索引的选择性比值，比值越高说明索引的效率也就越高效。
SELECT COUNT(DISTINCT LEFT(index_column,1))/COUNT(*),COUNT(DISTINCT LEFT(index_column,2))/COUNT(*),COUNT(DISTINCT LEFT(index_column,3))/COUNT(*) FROM table_name;
ALTER TABLE table_name ADD INDEX index_name (index_column(length));

#### 有效索引
SELECT * FROM user_test WHERE user_name = 'feinik' AND age = 26 AND city = '广州'; # 全值匹配
（user_name ）、（user_name, city）、（user_name , city , age）  # 匹配最左前缀 满足最左前缀查询条件的顺序与索引列的顺序无关
SELECT * FROM user_test WHERE user_name LIKE 'feinik%'; # 匹配范围值

#### 无效索引
SELECT * FROM user_test WHERE city = '广州';
SELECT * FROM user_test WHERE age= 26;
SELECT * FROM user_test WHERE user_name like '%feinik';
SELECT * FROM user_test WHERE user_name ='feinik' AND city LIKE'广州%' AND age = 26; # 有某个列的范围查询,则其右边的所有列都无法使用索引优化查询
SELECT * FROM user_test WHERE user_name = concat(user_name, 'fei');  #  索引列不能是表达式的一部分，也不能作为函数的参数
SELECT user_name, city, age FROM user_test ORDER BY user_name, sex;  #  不在索引列中
SELECT user_name, city, age FROM user_test ORDER BY user_name ASC, city DESC;  # 方向不一致
SELECT user_name, city, age, sex FROM user_test ORDER BY user_name;
SELECT user_name, city, age FROM user_test WHERE user_name LIKE 'feinik%' ORDER BY city;

# 使用索引排序：ORDER BY 子句后的列顺序要与组合索引的列顺序一致，且所有排序列的排序方向（正序/倒序）需一致；所查询的字段值需要包含在索引列中，及满足覆盖索引。
SELECT user_name, city, age FROM user_test ORDER BY user_name;
SELECT user_name, city, age FROM user_test ORDER BY user_name, city;
SELECT user_name, city, age FROM user_test ORDER BY user_name DESC, city DESC;
SELECT user_name, city, age FROM user_test WHERE user_name = 'feinik' ORDER BY city;

select a.FirstName,a.LastName, b.City, b.State from Person as a inner join address b on a.PersonId = b.PersonId

## [语句集锦](https://juejin.im/post/584e7b298d6d81005456eb53)
# 查询时间
select date_format(create_time, '%Y-%m-%d') as day from table_name
# int 时间戳类型
select from_unixtime(create_time, '%Y-%m-%d') as day from table_name

# 一个sql返回多个总数
select count(*) all
count(case when status = 1 then status end) status_1_num,
count(case when status = 2 then status end) status_2_num
from table_name
# Update Join / Delete Join
update table_name_1
inner join table_name_2 on table_name_1.id = table_name_2.uid
inner join table_name_3 on table_name_3.id = table_name_1.tid
set *** = ***
where ***
# delete join 同上。

# 替换某字段的内容的语句
update table_name set content = REPLACE(content, 'aaa', 'bbb') where (content like '%aaa%')
# 获取表中某字段包含某字符串的数据
SELECT * FROM `表名` WHERE LOCATE('关键字', 字段名)
# 获取字段中的前4位
SELECT SUBSTRING(字段名,1,4) FROM 表名
# 查找表中多余的重复记录
# 单个字段
select * from 表名 where 字段名 in (select 字段名 from 表名 group by 字段名 having count(字段名) > 1 )
# 多个字段
select * from 表名 别名 where (别名.字段1,别名.字段2) in (select 字段1,字段2 from 表名 group by 字段1,字段2 having count(*) > 1 )
# 删除表中多余的重复记录(留id最小)
# 单个字段
delete from 表名 where 字段名 in (select 字段名 from 表名 group by 字段名 having count(字段名) > 1)
and 主键ID not in (select min(主键ID) from 表名 group by 字段名 having count(字段名 )>1)
# 多个字段
delete from 表名 别名 where (别名.字段1,别名.字段2) in (select 字段1,字段2 from 表名 group by 字段1,字段2 having count(*) > 1)
and 主键ID not in (select min(主键ID) from 表名 group by 字段1,字段2 having count(*)>1)
```

```sql
# 创建测试表
CREATE TABLE `test_number` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `number` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '数字',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

# 创建测试数据
insert into test_number values(1,1),(2,2),(3,3),(4,5),(5,7),(6,8),(7,10),(8,11);

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

select date_format(create_time, '%Y-%m-%d') as day from table_name # timestamp 日期类型
select from_unixtime(create_time, '%Y-%m-%d') as day from table_name # int 时间戳类型

# 返回多个总数
select count(*) all,
    count(case when status = 1 then status end) status_1_num,
    count(case when status = 2 then status end) status_2_num
    from table_name;

# Update Join / Delete Join
update table_name_1
    inner join table_name_2 on table_name_1.id = table_name_2.uid
    inner join table_name_3 on table_name_3.id = table_name_1.tid
    set *** = ***  where ***;

update table_name set content = REPLACE(content, 'aaa', 'bbb')  where (content like '%aaa%')

SELECT * FROM `表名` WHERE LOCATE('关键字', 字段名) # 表中某字段包含某字符串的数据

# 表中多余的重复记录
# 单个字段
select * from 表名 where 字段名 in  (select 字段名 from 表名 group by 字段名 having count(字段名) > 1)
# 多个字段
select * from 表名 别名 where (别名.字段1,别名.字段2) in  (select 字段1,字段2 from 表名 group by 字段1,字段2 having count(*) > 1 )

# 删除表中多余的重复记录(留id最小)
# 单个字段
delete from 表名 where 字段名 in  (select 字段名 from 表名 group by 字段名 having count(字段名) > 1)   and 主键ID not in  (select min(主键ID) from 表名 group by 字段名 having count(字段名 )>1)
# 多个字段
delete from 表名 别名 where (别名.字段1,别名.字段2) in  (select 字段1,字段2 from 表名 group by 字段1,字段2 having count(*) > 1) and 主键ID not in (select min(主键ID) from 表名 group by 字段1,字段2 having count(*)>1)

UPDATE categories SET
    display_order = CASE id
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
```

## 事务

* mysql有一个autocommit参数，默认是on，作用是每一条单独的查询都是一个事务，并且自动开始，自动提交（执行完以后就自动结束了，如果要适用select for update，而不手动调用 start transaction，这个for update的行锁机制等于没用，因为行锁在自动提交后就释放了）
* 事务隔离级别和锁机制即使不显式调用start transaction，这种机制在单独的一条查询语句中也是适用的
* 数据定义语言（DDL）语句不能被回滚，比如创建或取消数据库的语句，和创建、取消或更改表或存储的子程序的语句。
* 加锁阶段
    - 读操作之前要申请并获得S锁（共享锁，其它事务可以继续加共享锁，但不能加排它锁）
    - 写操作之前要申请并获得X锁（排它锁，其它事务不能再获得任何锁）
    - 加锁不成功，则事务进入等待状态，直到加锁成功才继续执行
* 解锁阶段：当事务释放了一个封锁以后，事务进入解锁阶段
* 两段锁协议可以保证事务的并发调度是串行化（串行化很重要，尤其是在数据恢复和备份的时候）
* 事务的隔离级别对于读数据的定义。四个级别逐渐增强，每个级别解决一个问题。事务级别越高,性能越差,大多数环境read committed 可以用
    - 读未提交(Read Uncommitted)：允许脏读，也就是可能读取到其他会话中未提交事务修改的数据
        + 事物一可以获取事物二中未提交的修改
        + 事物一中未提交的修改事物（添加共享锁），事物二同样数据修改会被挂起，等待事物一commit
    - 读已提交(Read Committed)：只能读取到已经提交的数据，Oracle等多数数据库默认都是该级别。造成事务一在同一个transaction中两次读取到的数据不同，这就是不可重复读问题。并且在对表进行修改时，会对表数据行加上行共享锁
        + 数据的读取都是不加锁的，但是数据的写入、修改和删除是需要加锁的
    - 可重复读(Repeated Read)：在同一个事务内的查询都是事务开始时刻一致的，InnoDB默认级别。在SQL标准中，该隔离级别消除了不可重复读，但是还存在幻读。
        + 概念是一事务的多个实例在并发读取数据时，会看到同样的数据行
        + 当两个事务同时进行时，其中一个事务修改数据对另一个事务不会造成影响，即使修改的事务已经提交也不会对另一个事务造成影响。
        + 两个事物：事物二修改提交后，事物一不提交无法获取事物二的更新；事物一的修改未提交，事物二的修改无法成功等待事物一提交或者超时
        + 读到的数据可能是历史数据，是不及时的数据，不是数据库当前的数据
        + 对于这种读取历史数据的方式叫快照读 (snapshot read)，而读取数据库当前版本数据的方式，叫当前读 (current read)
            * 每行数据的最后加两个隐藏列,一个保存行的创建事务id，一个保存行的删除事务id.事务id，在mysql内部是全局唯一递增的
            * 始终都是查找的之前的那个快照
        + 只会查询创建时间的事务id小于等于当前事务id的行，这样可以确保这个行是在当前事务中创建，或者是之前创建的
        + 如果某个事务执行期间，别的事务更新了一条数据:插入了一行记录，然后将新插入的记录的创建时间设置为新的事务的id，同时将这条记录之前的那个版本的删除时间设置为新的事务的id
    - 串行读(Serializable)：完全串行化的读，每次读都需要获得表级共享锁，读写相互都会阻塞。
        + 读加共享锁，写加排他锁，读写互斥。使用的悲观锁的理论，实现简单，数据更加安全，但是并发能力非常差。如果你的业务并发的特别少或者没有并发，同时又要求数据及时可靠的话，可以使用这种模式。
        + 不要看到select就说不会加锁了，在Serializable这个级别，还是会加锁的
    - 当隔离级别是可重复读，且禁用innodb_locks_unsafe_for_binlog的情况下，在搜索和扫描index的时候使用的next-key locks可以避免幻读。在默认的可重复读的隔离级别里，可以使用加锁读去查询最新的数据（提交读）
        + Next-Key锁是行锁和GAP（间隙锁）的合并：行锁可以防止不同事务版本的数据修改提交时造成数据冲突的情况。但如何避免别的事务插入数据就成了问题
        + 行锁防止别的事务修改或删除，GAP锁防止别的事务新增，行锁和GAP锁结合形成的的Next-Key锁共同解决了RR级别在写数据时的幻读问题
* 数据可读性
    - 脏读：事务A读取了事务B未提交的数据
        + 当一个事务正在访问数据，并且对数据进行了修改，而这种修改还没有提交到数据库中
        + 另外一个事务也访问这个数据，然后使用了这个数据
    - 不可重复读（即不能读到相同的数据内容）：对于一条记录，事务A两次读取的数据变了
        + 在这个事务还没有结束时，另外一个事务也访问该同一数据
        + 在第一个事务中的两次读数据之间，由于第二个事务的修改，那么第一个事务两次读到的的数据可能是不一样的
    - 幻读:事务A按照相同的查询条件，读取到了新增的数据

```sql
START TRANSACTION; 或者 BEGIN;
COMMIT;
ROLLBACK;

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

并发控制:确保在多个事务同时存取数据库中同一数据时不破坏事务的隔离性和统一性以及数据库的统一性

* 类型
    - 共享锁（S锁，MyISAM 叫做读锁）：由读表操作加上的锁，加锁后其他用户只能获取该表或行的共享锁，不能获取排它锁，也就是说只能读不能写
    - 排它锁（X锁，MyISAM 叫做写锁）：由写表操作加上的锁，加锁后其他用户不能获取该表或行的任何锁，典型是mysql事务中
* 颗粒度
    - 表锁（table-level locking）开销小，加锁快；不会出现死锁；锁定力度大，发生锁冲突概率高，并发度最低。MyISAM InnoDB 和 MEMORY
        + 通过总是一次性同时获取所有需要的锁以及总是按相同的顺序获取表锁来避免死锁
        + 表级锁更适合于以查询为主，并发用户少，只有少量按索引条件更新数据的应用，如Web 应用
    - 行锁（page-level locking）开销大，加锁慢；会出现死锁；锁定粒度小，发生锁冲突的概率低，并发度高；BDB
        + 最大程度的支持并发，同时也带来了最大的锁开销
        + 在 InnoDB 中，除单个 SQL 组成的事务外， 锁是逐步获得的，这就决定了在 InnoDB 中发生死锁是可能的
        + 行级锁只在存储引擎层实现，而Mysql服务器层没有实现
        + 行级锁更适合于有大量按索引条件并发更新少量不同数据，同时又有并发查询的应用，如一些在线事务处理（OLTP）系统
        + 优点
            * 回滚时只有少量的更改
            * 可以长时间锁定单一的行
        + 缺点
            *  比页级或表级锁定占用更多的内存。
            *  当在表的大部分中使用时，比页级或表级锁定速度慢，因为你必须获取更多的锁。
            *  如果你在大部分数据上经常进行GROUP BY操作或者必须经常扫描整个表，比其它锁定明显慢很多。
            *  用高级别锁定，通过支持不同的类型锁定，你也可以很容易地调节应用程序，因为其锁成本小于行级锁定。
    - 页锁开销和加锁速度介于表锁和行锁之间；会出现死锁；锁定粒度介于表锁和行锁之间，并发度一般。InnoDB
* 抽象锁(不真实存在)
    - 悲观锁（又名“悲观锁”，Pessimistic Concurrency Control，缩写“PCC”）是一种并发控制的方法。在整个数据处理过程中，将数据处于锁定状态，阻止一个事务以影响其他用户的方式来修改数据
        + 先获取锁，再操作修改，数据库级别
        + 如果一个事务执行的操作都某行数据应用了锁，那只有当这个事务把锁释放，其他事务才能够执行与该锁冲突的操作
        + 条件
            * 要使用悲观锁，必须关闭mysql数据库的自动提交属性，因为MySQL默认使用autocommit模式 `set autocommit=0`
        + 实现
            * 依靠数据库的锁机制实现，以保证操作最大程度的独占性
            * 通过常用的select … for update操作来实现悲观锁，在当前事务结束时自动释放，因此必须在事务中使用
            * 确定走了索引，而不是全表扫描
            * 一锁二查三更新
                + 在对任意记录进行修改前，先尝试为该记录加上排他锁（exclusive locking）。
                - 如果加锁失败，说明该记录正在被修改，那么当前查询可能要等待或者抛出异常。 具体响应方式由开发者根据实际需要决定。
                - 如果成功加锁，那么就可以对记录做修改，事务完成后就会解锁了。
                - 其间如果有其他对该记录做修改或加排他锁的操作，都会等待我们解锁或直接抛出异常
        + 场景
            * 用于数据争用激烈的环境，以及发生并发冲突时使用锁保护数据的成本要低于回滚事务的成本的环境中。
            * 在只读型事务处理中由于不会产生冲突，也没必要使用锁，这样做只能增加系统负载；还有会降低了并行性，一个事务如果锁定了某行数据，其他事务就必须等待该事务处理完才可以处理那行数
    - 乐观锁（Optimistic Concurrency Control，缩写“OCC”），假设多用户并发的事务在处理时不会彼此互相影响，各事务能够在不产生锁的情况下处理各自影响的那部分数据
        + 先修改，保存时判断是够被更新过，应用级别
        + 实现
            - 当读取数据时，将版本标识的值一同读出，数据每更新一次，同时对版本标识进行更新
            - 当提交更新的时候，判断数据库表对应记录的当前版本信息与第一次取出来的版本标识进行比对
            - 如果数据库表当前版本号与第一次取出来的版本标识值相等，则予以更新
            - 如果不一致，即可认为老版本的数据已经被并发修改掉而不存在了，此时认为获取锁失败，需要回滚整个业务操作并可根据需要重试整个过程
        + 方法
            * 使用版本号version：为数据增加的一个版本标识
                - SELECT时，读取创建版本号<=当前事务版本号，删除版本号为空或>当前事务版本号
                - INSERT时，保存当前事务版本号为行的创建版本号
                - DELETE时，保存当前事务版本号为行的删除版本号
                - UPDATE时，插入一条新纪录，保存当前事务版本号为行创建版本号，同时保存当前事务版本号到原来删除的行
            * 使用时间戳timestamp
        + 适合
            * 用在取锁失败概率比较小的场景，可以提升系统并发性能
            * 用于写比较少的情况下
        + MVCC并发控制中，读操作可以分成两类：
            * 快照读 (snapshot read)：读取的是记录的可见版本 (有可能是历史版本)，不用加锁（共享读锁s锁也不加，所以不会阻塞其他事务的写）
            * 当前读 (current read)：读取的是记录的最新版本，并且，当前读返回的记录，都会加上锁，保证其他事务不会再并发修改这条记录
        + 优缺点
            * 通过MVCC (Multi-Version Concurrency Control) ，虽然每行记录都需要额外的存储空间，更多的行检查工作以及一些额外的维护工作，但可以减少锁的使用，大多数读操作都不用加锁，读数据操作很简单，性能很好，并且也能保证只会读取到符合标准的行，也只锁住必要行。
                - 读不加锁，读写不冲突。在读多写少的OLTP应用中，读写不冲突是非常重要的，极大的增加了系统的并发性能
            + 加大了系统的整个吞吐量。上层应用会不断的进行retry，这样反倒是降低了性能，所以这种情况下用悲观锁就比较合适
* LOCK TABLES 和 UNLOCK TABLES:服务器层（MySQL Server层）实现的
    - LOCK TABLES 可以锁定用于当前线程的表。如果表被其他线程锁定，则当前线程会等待，直到可以获取所有锁定为止
    - UNLOCK TABLES 可以释放当前线程获得的任何锁定。当前线程执行另一个 LOCK TABLES 时，或当与服务器的连接被关闭时，所有由当前线程锁定的表被隐含地解锁
    - 语法
        + 对 InnoDB 表加锁时要注意，要将 AUTOCOMMIT 设为 0
        + 事务结束前，不要用 UNLOCK TABLES 释放表锁，因为 UNLOCK TABLES会隐含地提交事务；
        + COMMIT 或 ROLLBACK 并不能释放用 LOCK TABLES 加的表级锁，必须用UNLOCK TABLES 释放表锁
    - 场景
        + 同时取得所有涉及到表的锁，并且 MySQL 不支持锁升级
* 建议
    - 尽量使用较低的隔离级别
    - 精心设计索引， 并尽量使用索引访问数据， 使加锁更精确， 从而减少锁冲突的机会
    - 选择合理的事务大小，小事务发生锁冲突的几率也更小
    - 给记录集显示加锁时，最好一次性请求足够级别的锁。比如要修改数据的话，最好直接申请排他锁，而不是先申请共享锁，修改时再请求排他锁，这样容易产生死锁
    - 不同的程序访问一组表时，应尽量约定以相同的顺序访问各表，对一个表而言，尽可能以固定的顺序存取表中的行。这样可以大大减少死锁的机会
    - 尽量用相等条件访问数据，这样可以避免间隙锁对并发插入的影响
    - 不要申请超过实际需要的锁级别
    - 除非必须，查询时不要显示加锁。 MySQL的MVCC可以实现事务中的查询不用加锁，优化事务性能；MVCC只在COMMITTED READ（读提交）和REPEATABLE READ（可重复读）两种隔离级别下工作
    - 对于一些特定的事务，可以使用表锁来提高处理速度或减少死锁的可能

```sql
show OPEN TABLES where In_use > 0; # 查询是否锁表
## Innodb 显性锁定
# 共享锁
select * from table lock in share mode
# 排它锁
select * from table for update --增删改自动加了排他锁

# 死锁产生，无法更新锁
begin transelect * from table lock in share mode
update table set column1='hello'

begin transelect * from table lock in share mode
update table set column1='world'

# 有机会产生死锁，但实际上要看情况
# id是主键 互不影响
# id是普通的一列，没有索引，第一条 一行加排他锁后，后一条为了找到id=20，需要对全表扫描
begin tranupdate table set column1='hello' where id=10
begin tranupdate table set column1='world' where id=20

# 悲观锁
begin|begin work|start transaction;  # 开始事务
select status from t_goods where id=1 for update; #  查询出商品信息
insert into t_orders (id,goods_id) values (null,1); #  根据商品信息生成订单
update t_goods set status=2; # 修改商品status为2
commit|commit work; # 提交事务

# 乐观锁
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

show status like 'innodb_row_lock%'; # 从系统启动到现在的数据

Innodb_row_lock_current_waits # 当前正在等待锁的数量；
Innodb_row_lock_time  # 锁定的总时间长度，单位ms；
Innodb_row_lock_time_avg  # 每次等待所花平均时间；
Innodb_row_lock_time_max # 从系统启动到现在等待最长的一次所花的时间；
Innodb_row_lock_waits  # 从系统启动到现在总共等待的次数。


SET AUTOCOMMIT=0;
LOCK TABLES t1 WRITE, t2 READ, ...;
[do something with tables t1 and t2 here];
COMMIT;
UNLOCK TABLES;

Lock tables orders read local, order_detail read local;
Select sum(total) from orders;
Select sum(subtotal) from order_detail;
Unlock tables;
```

### B-Tree树

* 定义：一种多路搜索树（并不是二叉的），一颗M阶的B-树，或为空树
    - 定义任意非叶子结点最多只有M个儿子,且M>2；
    - 根结点的儿子数为[2, M]；
    - 除根结点以外的非叶子结点的儿子数为[M/2, M]；
    - 每个结点存放至少M/2-1（取上整）和至多M-1个关键字；（至少2个关键字）
    - 非叶子结点的关键字个数=指向儿子的指针个数-1；
    - 非叶子结点的关键字：K[1], K[2], …, K[M-1]；且K[i] < K[i+1]；
    - 非叶子结点的指针：P[1], P[2], …, P[M]；其中P[1]指向关键字小于K[1]的子树，P[M]指向关键字大于K[M-1]的子树，其它P[i]指向关键字属于(K[i-1], K[i])的子树；
    - 所有叶子结点位于同一层
* B-tree数据存储是有序的，按照顺序保存了索引的列，加速了数据访问
    - 所有键值分布在整个树中
    - 任何关键字出现且只出现在一个节点中
    - 搜索有可能在非叶子节点结束
    - 在关键字全集内做一次查找，性能逼近二分查找算法
* 结构
    - 最外层浅蓝色磁盘块1里有数据17、35（深蓝色）和指针P1、P2、P3（黄色）。P1指针表示小于17的磁盘块，P2是在17-35之间，P3指向大于35的磁盘块。真实数据存在于子叶节点也就是最底下的一层3、5、9、10、13……非叶子节点不存储真实的数据，只存储指引搜索方向的数据项
    - 查找过程：例如搜索28数据项，首先加载磁盘块1到内存中，发生一次I/O，用二分查找确定在P2指针。接着发现28在26和30之间，通过P2指针的地址加载磁盘块3到内存，发生第二次I/O。用同样的方式找到磁盘块8，发生第三次I/O。降低时间复杂度
* 多路自平衡的搜索树,允许每个节点有更多的子节点
* 根节点一般存储在内存中，普通节点和叶子结点保存在硬盘中
* 使用B-tree索引的查询类型，很好用于全键值、键值范围或键前缀查找
    - 只有在使用了索引的最左前缀的时候才有用
    - 查找没有从索引列的最左边开始,没有什么用处;不能跳过索引的列
* 前缀索引
    - 索引很长的字符列，这会增加索引的存储空间以及降低索引的效率。选择字符列的前n个字符作为索引，这样可以大大节约索引空间，从而提高索引效率。
    - 要选择足够长的前缀以保证高的选择性，同时又不能太长。
    - 无法使用前缀索引做ORDER BY 和 GROUP BY以及使用前缀索引做覆盖扫描
    - 索引选择性是不重复的索引值和全部行数的比值。高选择性的索引有好处，查找匹配过滤更多的行，唯一索引选择性为1最佳状态。
    - blob列、text列及很长的varchar列，必须定义前缀索引，mysql不允许索引他们的全文
* 联合索引：两个或更多个列上的索引
    - 以索引 (name, city, gender) 为例，其首先是按照 name 字段顺序组织的，当 name 字段的值相同时（如 Bush），其按照 city 字段顺序组织，当 city 字段值相同时，其按照 gender 字段组织
    - 创建索引列的顺序非常重要:正确的索引顺序依赖于使用该索引的查询方式.对于联合索引的索引顺序可以通过经验法则来帮助我们完成：将选择性最高的列放到索引最前列，该法则与前缀索引的选择性方法一致，但并不是说所有的组合索引的顺序都使用该法则就能确定，还需要根据具体的查询场景来确定具体的索引顺序。
    - index[b,c,d]:idx_t1_bcd索引，首先按照b字段排序，b字段相同，则按照c字段排序，以此类推。记录在索引中按照[b,c,d]排序
    - 利用索引中的附加列，可以缩小搜索的范围，但使用一个具有两列的索引不同于使用两个单独的索引。
* B+tree,是 B 树的变体，也是一种多路平衡查找树
    - 从根节点到每个叶子节点的高度差值不超过1，而且同层级的节点间有指针相互链接，是有序的
    - 与 B 树的不同在于
        + B树：每个节点都存储key和data，所有节点组成这棵树，并且叶子节点指针为nul，叶子结点不包含任何关键字信息
        + B+树：所有的叶子结点中包含了全部关键字的信息，及指向含有这些关键字记录的指针，且叶子结点本身依关键字的大小自小而大的顺序链接
            * 所有的非终端结点可以看成是索引部分，结点中仅含有其子树根结点中最大（或最小）关键字。(而B 树的非终节点也包含需要查找的有效信息)
        + 所有关键字存储在叶子节点，非叶子节点不存储真正的 data
        + 为所有叶子节点增加了一个链指针
    - 所有关键字存储在叶子节点,内部节点(非叶子节点并不存储真正的 data)
    - 为所有叶子结点增加了一个链指针
    - B+树索引并不能找到一个给定键值的具体行，它找到的只是被查找数据行所在的页，接着数据库会把页读入到内存，再在内存中进行查找，最后得到要查找的数据。
    - 平衡二叉树的查找效率还不错，实现也非常简单，相应的维护成本还能接受，为什么MySQL索引不直接使用平衡二叉树？
        + 随着数据库中数据的增加，索引本身大小随之增加，不可能全部存储在内存中，因此索引往往以索引文件的形式存储的磁盘上。 这样的话，索引查找过程中就要产生磁盘I/O消耗，相对于内存存取，I/O存取的消耗要高几个数量级。
        + 可以想象一下一棵几百万节点的二叉树的深度是多少？如果将这么大深度的一颗二叉树放磁盘上，每读取一个节点，需要一次磁盘的I/O读取，整个查找的耗时显然是不能够接受的。那么如何减少查找过程中的I/O存取次数？行之有效的解决方法是减少树的深度，将二叉树变为m叉树（多路搜索树），而 B+Tree就是一种多路搜索树。理解 B+Tree时，只需要理解其最重要的两个特征即可
            * 所有的关键字（可以理解为数据）都存储在叶子节点（ LeafPage），非叶子节点（ IndexPage）并不存储真正的数据，所有记录节点都是按键值大小顺序存放在同一层叶子节点上
            * 所有的叶子节点由指针连接
        + 将每个节点的大小设置为一个页的整数倍，也就是在节点空间大小一定的情况下，每个节点可以存储更多的内结点，这样每个结点能索引的范围更大更精确。所有的叶子节点使用指针链接的好处是可以进行区间访问，比如图中，如果查找大于20而小于30的记录，只需要找到节点20，就可以遍历指针依次找到25、30。如果没有链接指针的话，就无法进行区间查找。这也是MySQL使用 B+Tree作为索引存储结构的重要原因。
        + 为何将节点大小设置为页的整数倍:这就需要理解磁盘的存储原理。磁盘本身存取就比主存慢很多，在加上机械运动损耗（特别是普通的机械硬盘），磁盘的存取速度往往是主存的几百万分之一，为了尽量减少磁盘I/O，磁盘往往不是严格按需读取，而是每次都会预读，即使只需要一个字节，磁盘也会从这个位置开始，顺序向后读取一定长度的数据放入内存，预读的长度一般为页的整数倍。
        + 将一个节点的大小设为等于一个页，这样每个节点只需要一次I/O就可以完全载入。为了达到这个目的，每次新建节点时，直接申请一个页的空间，这样就保证一个节点物理上也存储在一个页里，加之计算机存储分配都是按页对齐的，就实现了读取一个节点只需一次I/O。假设 B+Tree的高度为h，一次检索最多需要 h-1I/O（根节点常驻内存），复杂度`$O(h) = O(\log_{M}N)$`。实际应用场景中，M通常较大，常常超过100，因此树的高度一般都比较小，通常不超过3。
        + 以下面的树为例，假设每个节点只能存储4个内节点
            * 插入下一个节点70，在Index Page中查询后得知应该插入到50 - 70之间的叶子节点，但叶子节点已满，这时候就需要进行叶分裂的操作，当前的叶子节点起点为50，所以根据中间值来拆分叶子节点
            * 插入一个节点95，这时候Index Page和Leaf Page都满了，就需要做两次拆分，如下图所示
        + B+Tree为了保持平衡，对于新插入的值需要做大量的拆分页操作，而页的拆分需要I/O操作，为了尽可能的减少页的拆分操作， B+Tree也提供了类似于平衡二叉树的旋转功能。当Leaf Page已满但其左右兄弟节点没有满的情况下， B+Tree并不急于去做拆分操作，而是将记录移到当前所在页的兄弟节点上。通常情况下，左兄弟会被先检查用来做旋转操作。就比如上面第二个示例，当插入70的时候，并不会去做页拆分，而是左旋操作。
        + 通过旋转操作可以最大限度的减少页分裂，从而减少索引维护过程中的磁盘的I/O操作，也提高索引维护效率。需要注意的是，删除节点跟插入节点类型，仍然需要旋转和拆分操作
    - 索引是如何组织数据的存储,表中每一行数据，索引中包含了lastname、firstname、dob列的值，查看下图
    - 更适合外部存储,由于内节点无 data 域,一个结点可以存储更多的内结点,每个节点能索引的范围更大更精确,也意味着 B+树单次磁盘IO的信息量大于B-树,I/O效率更高。
    - 节点增加的链指针,加强了区间访问性，可使用在范围区间查询等，而B-树每个节点 key 和 data 在一起，则无法区间查找。
    - 一棵B+树可以存放多少行数据？这个问题的简单回答是：约2千万
        + 磁盘存储数据最小单元是扇区，大小是512字节，而文件系统（例如XFS/EXT4）最小单元是块，一个块的大小是4k 存储引擎最小储存单元——页（Page），一个页的大小是16K（可以通过配置参数 innodb_page_size 调整），所有数据文件（后缀为ibd的文件），始终都是16384（16k）的整数倍
        + 根页偏移量为64的地方存放了该B+树的page level，B+树的高度=page level+1
        + 索引组织表：存放排好序的键值+指针的非叶子节点页。以及存放按主键排序数据的页
        + 每张表的根页位置在表空间文件中是固定（约定page number为3的代表主键索引的根页），通过二分查找法，查找到目标页的指针，在目标页中查找
        + 非叶子节点能存放多少指针
            * 主键ID为bigint类型，长度为8字节，而指针大小在InnoDB源码中设置为6字节，这样一共14字节。一个页中能存放16384/14=1170的单元
            * 数据记录大小通常就是1K左右，高度为2的B+树，能存放1170*16=18720。高度为3的B+树可以存放：1170*1170*16=21902400条这样的记录
            * 在InnoDB中B+树高度一般为1-3层，它就能满足千万级的数据存储
        - 一次页的查找代表一次IO，所以通过主键索引查询通常只需要1-3次IO操作即可查找到数据
    - B树不管叶子节点还是非叶子节点，都会保存数据，这样导致在非叶子节点中能保存的指针数量变少，要保存大量数据，只能增加树的高度，导致IO操作变多，查询性能变低
* 每次 IO 只读取一个数据页大小的数据，如果要读取的数据大于一个数据页，则会导致多次 IO。因此要尽量让每个节点的数据大小刚好等于一个数据页大小，即每访问一个节点只需一次 IO。
* 为什么用 B/B+ 树这种结构来实现索引
    - MySQL 是基于磁盘的数据库，索引是以索引文件的形式存在于磁盘中的，索引的查找过程就会涉及到磁盘 IO 消耗，磁盘 IO 的消耗相比较于内存 IO 的消耗要高好几个数量级，所以索引的组织结构要设计得在查找关键字时要尽量减少磁盘 IO 的次数。
    - 局部性原理与磁盘预读
        + 为了提升效率，要尽量减少磁盘 IO 的次数。实际过程中，磁盘并不是每次严格按需读取，而是每次都会预读
        + 磁盘读取完需要的数据后，会按顺序再多读一部分数据到内存中，这样做的理论依据是计算机科学中注明的局部性原理：当一个数据被用到时，其附近的数据也通常会马上被使用
        + 程序运行期间所需要的数据通常比较集中
            * 由于磁盘顺序读取的效率很高(不需要寻道时间，只需很少的旋转时间)，因此对于具有局部性的程序来说，预读可以提高 I/O 效率.预读的长度一般为页(page)的整倍数
            * MySQL(默认使用InnoDB引擎),将记录按照页的方式进行管理,每页大小默认为16K(这个值可以修改)。Linux 默认页大小为4K。
    - 每次新建节点时，直接申请一个页的空间，这样就保证一个节点物理上也存储在一个页里，加之计算机存储分配都是按页对齐的，就实现了一个结点只需一次 I/O
    - 假设 B-Tree 的高度为 h, B-Tree 中一次检索最多需要 h-1 次 I/O（根节点常驻内存），渐进复杂度为 O(h)=O(logdN)O(h)=O(logdN)
    - 一般实际应用中，出度 d 是非常大的数字，通常超过 100，因此 h 非常小（通常不超过3，也即索引的 B+ 树层次一般不超过三层，所以查找效率很高）
    - 而红黑树这种结构，h 明显要深的多。由于逻辑上很近的节点（父子）物理上可能很远，无法利用局部性，所以红黑树的 I/O 渐进复杂度也为 O(h)，效率明显比 B-Tree 差很多。
* 为什么 MySQL 的索引使用 B+ 树而不是 B 树呢
    - B+ 树更适合外部存储(一般指磁盘存储),由于内节点(非叶子节点)不存储 data，所以一个节点可以存储更多的内节点，每个节点能索引的范围更大更精确。也就是说使用 B+ 树单次磁盘 IO 的信息量相比较 B 树更大，IO 效率更高
    - MySQL 是关系型数据库，经常会按照区间来访问某个索引列，B+ 树的叶子节点间按顺序建立了链指针，加强了区间访问性，所以B+树对索引列上的区间范围查询很友好。而 B 树每个节点的 key 和 data 在一起，无法进行区间查找。
    - B+比B树更适合实际应用中操作系统的文件索引和数据库索引
        + 磁盘读写代价更低:内部结点并没有指向关键字具体信息的指针，因此其内部结点相对B树更小.盘块所能容纳的关键字数量也越多。一次性读入内存中的需要查找的关键字也就越多。相对来说IO读写次数也就降低了
        + 查询效率更加稳定:非终结点并不是最终指向文件内容的结点，而只是叶子结点中关键字的索引.任何关键字的查找必须走一条从根结点到叶子结点的路。所有关键字查询的路径长度相同，导致每一个数据的查询效率相当。

![索引结构](../_static/b tree.jpeg "Optional title")
![index](../_static/index.jpg "index")
![B+tree](../_static/B+tree.jpg "B+tree")
![B+tree_insert](../_static/B+tree_insert.jpg "B+tree_insert")
![B+tree_insert_1](../_static/B+tree_insert_1.jpg "B+tree_insert_1")
![B+tree_rorate](../_static/B+tree_rorate.jpg "B+tree_rorate.jpg")

```sql
CREATE TABLE  People (
    last_name varchar (50) not null,
    first_name varchar (50) not null,
    dob date not null,
    gender enum (`m` , `f`) not null,
    key (last_name , first_name , dob)
);
```

![B+tree_storage](../_static/B+tree_storage.jpg "B+tree_storage.jpg")

### 存储引擎

不同数据引擎数据的存储格式,数据结构的实现,数据行并不是存储引擎管理的最小存储单位，索引只能够帮助我们定位到某个数据页，每一次磁盘读写的最小单位为也是数据页，而一个数据页内存储了多个数据行，我们需要了解数据页的内部结构才能知道存储引擎怎么定位到某一个数据行

* 存储格式
    - 堆表(所有的记录无序存储)
    - 聚簇索引表(所有的记录，按照记录主键进行排序存储)
* MEMORY
    - 要求存储在Memory数据表里的数据用的是长度不变的格式，这意味着不能用BLOB和TEXT这样的长度可变的数据类型，VARCHAR是种长度可变的类型，但因为它在MySQL内部当做长度固定不变的CHAR类型，所以可以使用。
    - 特性
        + 数据都保存在内存中，不需要进行磁盘I/O。
        + 支持 Hash 索引和B树索引。
        + 支持表级锁，不支持行级锁。
        + 服务重启后，表结构还会保留，但是数据会丢失。
        + 不支持 TEXT 和 BLOB 类型的列。
    - 场景
        + 需要快速地访问数据，并且这些数据不会被修改，重启以后丢失也没有关系。
        + 用于查找（lookup）或者映射（mapping）表，例如将邮编和地址映射的表。
        + 用于保存数据分析中产生的中间数据。
        + 用于缓存周期性聚合数据的结果。
* MyISAM
    - 数据结构：frm 表的定义，MYD文 表内容，MYI 表索引数据 三种存储格式分别为静态、动态和压缩。MyISAM 会根据表的定义自动选择存储格式。
        + 静态表：如果数据表中的各数据列的长度都是预先固定好的，服务器将自动选择这种表类型。因为数据表中每一条记录所占用的空间都是一样的，所以这种表存取和更新的效率非常高。当数据受损时，恢复工作也比较容易做。
        + 动态表：如果数据表中出现    varchar 、   *text 或 *BLOB 字段时，服务器将自动选择这种表类型。相对于静态MyISAM，这种表存储空间比较小，但由于每条记录的长度不一，所以多次修改数据后，数据表中的数据就可能离散的存储在内存中，进而导致执行效率下降。同时，内存中也可能会出现很多碎片。因此，这种类型的表要经常用 optimize table 命令或优化工具来进行碎片整理。
        + 压缩表：以上说到的两种类型的表都可以用myisamchk工具压缩。如果表在创建并导入数据后，不在进行修改操作，这样的表适合采用 MyISAM 压缩表。这种类型的表进一步减小了占用的存储，但是这种表压缩之后不能再被修改。另外，因为是压缩数据，所以这种表在读取的时候要先时行解压缩。
    - 使用 B+Tree 作为索引结构，叶节点的 data 域存放的是数据记录的地址,称为非聚集索引
    - 存储了表数据总条数
    - 主索引和辅助索引（Secondary key）在结构上没有任何区别，只是主索引要求 key 是唯一的，而辅助索引的 key 可以重复
    - 表锁
        + 只有读读之间是并发的
        + 写写之间和读写之间（读和插入之间是可以并发的，去设置concurrent_insert参数，定期执行表优化操作，更新操作就没有办法了）是串行的
        + 写锁比读锁具有更高的优先级：当一个锁释放时，这个锁会优先给写锁队列中等候的获取锁请求，然后再给读锁队列中等候的获取锁请求。
        + 不太适合于有大量更新操作和查询操作应用：大量的更新操作会造成查询操作很难获得读锁，从而可能永远阻塞。同时，一些需要长时间运行的查询操作，也会使写线程“饿死” ，应用中应尽量避免出现长时间运行的查询操作（在可能的情况下可以通过使用中间表等措施对SQL语句做一定的“分解” ，使每一步查询都能在较短时间完成，从而减少锁冲突。如果复杂查询不可避免，应尽量安排在数据库空闲时段执行，比如一些定期统计可以安排在夜间执行）
        + 设置改变读锁和写锁的优先级
            * 通过指定启动参数low-priority-updates，使MyISAM引擎默认给予读请求以优先的权利
            * 通过执行命令SET LOW_PRIORITY_UPDATES=1，使该连接发出的更新请求优先级降低
            * 通过指定INSERT、UPDATE、DELETE语句的LOW_PRIORITY属性，降低该语句的优先级
            * 给系统参数max_write_lock_count设置一个合适的值，当一个表的读锁达到这个值后，MySQL就暂时将写请求的优先级降低，给读进程一定获得锁的机会
        + 不会存在死锁（Deadlock Free）:一次获得 SQL 语句所需要的全部锁
        + 查询表级锁争用情况： 通过检查 table_locks_waited 和 table_locks_immediate 状态变量来分析系统上的表锁的争夺
    - myisam不要使用查询时间太长的sql，如果策略使用不当，也会导致写饿死，所以尽量去拆分查询效率低的sql,
    - 读的效果好，写的效率差
        + 和它数据存储格式，索引的指针和锁的策略有关的。
        + 数据是顺序存储，索引btree上的节点是一个指向数据物理位置的指针，所以查找起来很快
        + 适合于一些需要大量查询的应用，但其对于有大量写操作并不是很好。甚至只是需要update一个字段，整个表都会被锁起来，而别的进程就算是读进程都无法操作直到读操作完成
    - 不支持自动恢复数据：断电之后 使用之前检查和执行可能的修复
    - 不支持事务：不保证单个命令会完成, 多行update会有错误，只有一些行会被更新
    - 只有索引缓存在内存中
    * 提供了全文索引、压缩、空间函数（GIS）等特性
    - 场景
        + 查询密集型表：MyISAM 存储引擎在筛选大量数据时非常快，是它最突出的优点；
        + 插入密集型表：MyISAM 的并发插入特性允许同时选择、插入数据。例如：MyISAM存储引擎非常适合管理邮件或Web服务器日志数据。
* InnoDB
    - 综合一个文件,写满后递增文件
        + 使用共享表空间存储：表结构保存在 .frm 文件中，数据和索引在 innodb_data_home_dir 和  innodb_data_file_path 定义的表空间中，可以是多个文件。
        + 使用多表空间存储：表结构保存在 .frm 文件中，每个表的数据和索引单独保存在 .ibd 中。
    - 用于在写操作比较多的时候
    - CPU及内存缓存页优化使得资源利用率更高（推荐）索引节点存的则是数据的主键，所以需要根据主键二次查找
    - 事务：Innodb支持事务和四种事务隔离级别
    - 自动崩溃恢复特性
    - 外键：Innodb唯一支持外键的存储引擎 create table 命令接受外键
    - 行级锁
        + 默认行级锁,通过给索引上的索引项加锁来实现的
            * 只有通过索引条件检索数据才使用行级锁，否则使用表锁
            * 当 for update 的记录不存在会导致锁住全表
            * 当表有多个索引的时候，不同的事务可以使用不同的索引锁定不同的行
            * 不论是使用主键索引、唯一索引或普通索引，InnoDB 都会使用行锁来对数据加锁
        - mysql的读写之间是可以并发的，普通的select是不需要锁的，当查询的记录遇到锁时，用的是一致性的非锁定快照读，也就是根据数据库隔离级别策略，会去读被锁定行的快照，其它更新或加锁读语句用的是当前读，读取原始行；因为普通读与写不冲突，所以innodb不会出现读写饿死的情况，又因为在使用索引的时候用的是行锁，锁的粒度小，竞争相同锁的情况就少，就增加了并发处理，所以并发读写的效率还是很优秀的，问题在于索引查询后的根据主键的二次查找导致效率低；
        - 所有扫描到的记录都加锁，范围查询会加间隙锁，保证数据无法添加,然后加锁过程按照两阶段锁 2PL 来实现
            + 也就是先加锁，然后所有的锁在事物提交的时候释放
            + 加锁的策略会和数据库的隔离级别有关，在默认的可重复读的隔离级别的情况下，加锁的流程还会和查询条件中是否包含索引，是主键索引还是普通索引，是否是唯一索引等有关
    - 多版本：多版本并发控制
    - 所有的索引包含主键列：索引按照主键引用行,如果不把主键维持很短,索引就增长很大
    - 优化的缓存：Innodb把数据和内存缓存到缓冲池 自动构建哈希索引
    - 未压缩的索引：索引没有使用前缀压缩，阻塞auto_increment:Innodb使用表级锁产生新的auto_increment
    - 没有缓存的count()
    - 分析系统上的行锁的争夺情况:`show status like 'innodb_row_lock%';`
    - 间隙锁的目的：
        + 防止幻读，以满足相关隔离级别的要求
        + 满足恢复和复制的需要
    - 实现的是基于多版本的并发控制协议——MVCC (Multi-Version Concurrency Control) 加上间隙锁（next-key locking）策略在Repeatable Read (RR)隔离级别下不存在幻读。如果测试幻读，在MyISAM下实验。
    - 在聚集索引（主键索引）中，如果有唯一性约束，InnoDB会将默认的next-key lock降级为record lock。
    - Innodb在做任何操作时，会做一个日志操作，便于恢复
    - 在InnoDB中默认开启自适应哈希索引：如果认为建立哈希索引可以提高查询效率，则自动在内存中的“自适应哈希索引缓冲区”建立哈希索引
        + 通过观察搜索模式，MySQL会利用index key的前缀建立哈希索引，如果一个表几乎大部分都在缓冲池中，那么建立一个哈希索引能够加快等值查询
        + 在负载高的情况下，自适应哈希索引中添加的read/write锁也会带来竞争，比如高并发的join操作。like操作和%的通配符操作也不适用于自适应哈希索引，可能要关闭自适应哈希索引
    - 备份方式稍微复杂一点。xtradb是innodb存储引擎的增强版本，更高性能环境下的新特性。
    - 内存架构
        + 缓冲池 (buffer pool)：用来缓存各自数据，数据文件按页（每页 16K）读取到缓冲池，按最近最少使用算法（LRU）保留缓存数据
            * 数据类型有：数据页、索引页、插入缓冲、自适应哈希索引、锁信息、数据字典信息等
            * 数据页和索引页占了绝大部分内存
        + 重做日志缓冲池(redo log buffer）：重做日志信息先放入这个缓冲区，然后按一定频率（默认为 1s）将其刷新至重做日志文件
        + 额外的内存池（additional memory pool）
        + InnoDB 通过一些列后台线程将相关操作进行异步处理，同时借助缓冲池来减小 CPU 和磁盘速度上的差异。
            * 当查询的时候会先通过索引定位到对应的数据页，然后检测数据页是否在缓冲池内，如果在就直接返回，如果不在就去聚簇索引中通过磁盘 IO 读取对应的数据页并放入缓冲池。
            * 一个数据页会包含多个数据行。缓存池通过 LRU 算法对数据页进行管理，也就是最频繁使用的数据页排在列表前面，不经常使用的排在队尾，当缓冲池满了的时候会淘汰掉队尾的数据页。
            * 从磁盘新读取到的数据页并不会放在队列头部而是放在中间位置，这个中间位置可以通过参数进行修正
            * 缓冲池也可以设置多个实例，数据页根据哈希算法决定放在哪个缓冲池。
    - 存储架构
        + 所有数据都被逻辑地存放在一个空间中 表空间（tablespace），默认情况下用一个共享表空间 ibdata1 ，如果开启了 innodb_file_per_table 则每张表的数据将存储在单独的表空间中，也就是每张表都会有一个文件
        + 表空间（tablespace）=>段（segment）=>区（extent）=>页（page）
            * 叶子节点用来记录数据，存储在数据段
            * 叶子节点用来构建索引，存储在索引段
        + 区是由连续的页组成，任何情况下一个区都是 1MB，一个区中可以有多个页，每个页默认为 16KB ，所以默认情况下一个区中可以包含 64 个连续的页，页的大小是可以通过 innodb_page_size 设置，页中存储的是具体的行记录。一行记录最终以二进制的方式存储在文件里。
        + 各个数据页可以组成一个双向链表,每个数据页中的记录又可以组成一个单向链表
        + 每个数据页都会为存储在它里边儿的记录生成一个页目录，在通过主键查找某条记录的时候可以在页目录中使用二分法快速定位到对应的槽，然后再遍历该槽对应分组中的记录即可快速找到指定的记录
        + 以其他列(非主键)作为搜索条件：只能从最小记录开始依次遍历单链表中的每条记录。
        + 由共享表空间、日志文件组（更准确地说，应该是 Redo 文件组）、表结构定义文件组成
        + 若将 innodb_file_per_table 设置为 on，则每个表将独立地产生一个表空间文件，以 ibd 结尾，数据、索引、表的内部数据字典信息都将保存在这个单独的表空间文件中
        + 表结构定义文件以 frm 结尾，这个是与存储引擎无关的，任何存储引擎的表结构定义文件都一样，为 .frm 文件。
    - Process Architecture:后台线程有 7 个，其中 4 个 IO thread, 1 个 Master thread, 1 个 Lock monitor thread, 一个 Error monitor thread。InnoDB 的主要工作都是在一个单独的 Master 线程里完成的。
        + Master 线程的优先级最高，它主要分为以下几个循环：主循环（loop）、后台循环（background loop）、刷新循环（flush loop）、暂停循环（suspend loop）
            * 每秒一次的操作包括：刷新日志缓冲区（总是），合并插入缓冲（可能），至多刷新 100 个脏数据页（可能），如果没有当前用户活动，切换至 background loop （可能）。
            * 其中每 10 秒一次的操作包括：合并至多 5 个插入缓冲（总是），刷新日志缓冲（总是），刷新 100 个或 10 个脏页到磁盘（总是），产生一个检查点（总是），删除无用 Undo 页 （总是）。
            * 后台循环，若当前没有用户活动或数据库关闭时，会切换至该循环执行以下操作：删除无用的 undo 页（总是），合并 20 个插入缓冲（总是），跳回到主循环（总是），不断刷新 100 个页，直到符合条件跳转到 flush loop（可能）。
            * 如果 flush loop 中也没有什么事情可做，边切换到 suspend loop，将 master 线程挂起
    - 场景
        + 更新密集的表：InnoDB存储引擎特别适合处理多重并发的更新请求
        + 外键约束：MySQL支持外键的存储引擎只有InnoDB
    - 查询
        + 正常
            * 定位到记录所在的页：需要遍历双向链表，找到所在的页
            * 从所在的页内中查找相应的记录：由于不是根据主键查询，只能遍历所在页的单链表了，在数据量很大的情况下这样查找会很慢！这样的时间复杂度为O（n）。
        + 索引
            * 通过 “目录” 就可以很快地定位到对应的页上了！（二分查找，时间复杂度近似为O(logn)）
    - 数据（主键索引）还是辅助索引最终都会使用 B+ 树来存储数据
        + 主键索引中会以 <id, row> 的方式存储，id 是主键，能够通过 id 找到该行的全部列
        + 辅助索引会以 <index, id> 的方式进行存储，索引中的几个列构成了键
* 对比
    - MyISAM的索引和数据是分开的，索引保存的是数据文件的指针。主键索引和辅助索引是独立的。并且索引是有压缩的，这样内存使用率就提高了不少。能加载更多索引，而InnoDB是索引和数据紧密捆绑的，没有使用压缩从而会造成InnoDB比MyISAM的体积庞大不少
    - myiam索引按照行存储物理位置引用被索引的行，Innodb按照主键值引用行，通过主键索引效率很高。
    - 辅助索引需要两次查询，先查询到主键，然后再通过主键查询到数据。因此主键不应该过大，因为主键太大，其他索引也都会很大。
    - InnoDB支持外键，而MyISAM不支持。对一个包含外键的InnoDB表转为MYISAM会失败；
    - 恢复：不小心update一个表的where语句写的范围不对，导致整张表都不能正常使用，这是MyISAM的优越性就体现出来了，随便从当天拷贝的压缩包中取出对应表的文件，随便放到一个数据库目录下，然后dump成SQL文件导回主库，并把对应的binlog补上。如果是InnoDB就没有这么快的速度了。通常情况下一个数据库实例最小也有几个G大小
    - MyISAM最大的缺陷就是崩溃后无法安全恢复
    - InnoDB不支持FULLTEXT类型的索引
    - 系统奔溃后，MyISAM恢复起来更困难，能否接受
    - 定期导某些表的数据，用MyISAM的话会很方便，只需要发给他们对应表的frm、MYI、MYD文件，然后在对应版本的数据库中启动即可，而InnoDB则需要导出xxx.sql文件来执行
    - InnoDB中不保存表的具体行数，也就是说当执行`select count(*) from table`时，InnoDB会扫描一遍整张表来计算有多少行，但是MyISAM只需要简单地读出保存好的行数即可(用一个变量保存了整个表的行数，执行上述语句时只需要读出该变量即可)。需要注意的是count(*)语句中包含where条件时两种表的操作是一致的
    - 对于AUTO_INCREMENT类型的字段，InnoDB中必须包含只有该字段的索引，而在MyISAM中可以和其他字段一起建立联合索引
    - DELETE FROM table时，InnoDB不会重新建立表，而是一行行删除
    - LOAD TABLE FROM MASTER操作对于InnoDB是不起作用的，解决方法是首先把InnoDB转换成MyISAM表，导入数据后再转成InnoDB表，但是对于额外的InnoDB特性（如外键）的表是不适用的
    - InnoDB表的行锁也不是绝对的，假如在执行一个SQL语句时MySQL不能确定要扫描的范围，此时InnoDB依旧会锁全表，例如update table set num=1 where name like '%aaa%'
    - 和MyISAM比Insert操作的话，InnoDB还达不到MyISAM的写性能，如果是基于索引的update操作，虽然MyISAM会逊色与InnoDB，但是那么多高并发的写，从库能否追的上也是一个大问题。通常情况下会实现多实例分库分表架构来解决
    - InnoDB支持事务，MyISAM不支持。对于InnoDB每一条SQL语言都默认封装成事务，自动提交，这样会影响速度，所以最好把多条SQL语言放在begin和commit之间，组成一个事务
    - 大项目总量约几个亿的rows的某一类型（如日志等）业务表会使用MyISAM
    - 绝大多数都只是读查询，可以考虑MyISAM，如果既有读写也挺频繁，请使用InnoDB

```sql
show engines; # 显示当前数据库支持的存储引擎情况
show variables like '%storage_engine%';

select * from o_order where order_sn = '201912102322' for update;
# order_sn 是主键索引，这种情况将在主键索引上的 order_sn = 201912102322 这条记录上加排他锁。
# order_sn 是普通索引，并且是唯一索引，将会对普通索引上对应的一条记录加排他锁，对主键索引上对应的记录加排他锁。
# order_sn 是普通索引，并且不是唯一索引，将会对普通索引上 order_sn = 201912102322 一条或者多条记录加锁，并且对这些记录对应的主键索引上的记录加锁。这里除了加上行锁外，还会加上间隙锁，防止其他事务插入 order_sn = 201912102322 的记录，然而如果是唯一索引就不需要间隙锁，行锁就可以。
# order_sn 上没有索引，innoDB 将会在主键索引上全表扫描，这里并没有加表锁，而是将所有的记录都会加上行级排他锁，而实际上 innoDB 内部做了优化，当扫描到一行记录后发现不匹配就会把锁给释放，当然这个违背了 2PL 原则在事务提交的时候释放。这里除了对记录进行加锁，还会对每两个记录之间的间隙加锁，所以最终将会保存所有的间隙锁和 order_sn = 201912102322 的行锁。
# order_sn = 201912102322 这条记录不存在的情况下，如果 order_sn 是主键索引，则会加一个间隙锁，而这个间隙是主键索引中 order_sn 小于 201912102322 的第一条记录到大于 201912102322 的第一条记录。试想一下如果不加间隙锁，如果其他事物插入了一条 order_sn = 201912102322 的记录，由于 select for update 是当前读，即使上面那个事物没有提交，如果在该事物中重新查询一次就会发生幻读。
# 如果没有索引，则对扫描到的所有记录和间隙都加锁，如果不匹配行锁将会释放只剩下间隙锁。回忆一下上面讲的数据页的结果中又一个最大记录和最小记录，Infimum 和 Supremum Record，这两个记录在加间隙锁的时候就会用到。

show engine innodb status # 存储引擎的运行状态
set global innodb_print_all_deadlocks=1; # 错误日志中查看历史发生过的死锁
select * from information_schema.innodb_lock_waits; # 查看等待中的锁
select * from information_schema.innodb_trx; # 查看已开启的事务
```

## 索引

* 定义：存储引擎用于快速定位到数据的一种数据结构。本质上是以增加额外的写操作，与用于维护索引数据结构的存储空间为代价的，用于提升数据库中数据检索效率的数据结构
* 目标
    - 减少存储引擎需要扫描的数据量
    - 随机IO变成顺序IO
    - 在进行分组、排序等操作时，避免使用临时表
* 原理
    - 数据索引的存储是有序的
    - 在有序的情况下，通过索引查询一个数据是无需遍历索引记录的
    - 极端情况下，数据索引的查询效率为二分法查询效率，趋近于 log2(N)
* 大多数MySQL索引组织形式使用B树存储。 空间列类型的索引使用R-树，MEMORY表支持hash索引
    - 索引key排序
    - 值为存储位置
    - 索引不是建立的越多、越长越好，因为索引除了占用空间之外，对后续数据库的增加、删除、修改都有额外的操作来更新索引
* 小表使用全表扫描更快，中大表才使用索引，而超级大表索引基本无效,建立和维护索引的代价随之增长，可能需要借助独立的全文索引系统
* 类别
    - PRIMARY 索引
        + 创建
            * 定义了主键(PRIMARY KEY)，InnoDB会选择主键作为聚集索引
            * 没有显式定义主键，则InnoDB会选择第一个不包含有NULL值的唯一索引作为主键索引
            * 没有上面的唯一索引，则InnoDB会选择内置6字节长的ROWID作为隐含的聚集索引(ROWID随着行记录的写入而主键递增，这个ROWID不像ORACLE的ROWID那样可引用，是隐含的)
        + 在主键上自动创建，不允许有空值。一般是在建表的时候同时创建主键索引
        + 主键递增，数据行写入可以提高插入性能，可以避免page分裂，减少表碎片提升空间和内存的使用
            * 使用自增主键
                - 当有一条新的记录插入时，MySQL会根据其主键将其插入适当的节点和位置，如果页面达到装载因子（InnoDB默认为15/16），则开辟一个新的页（节点）
            * 使用非自增主键（如果身份证号或学号等），由于每次插入主键的值近似于随机，因此每次新纪录都要被插到现有索引页得中间某个位置
                - 移动数据，甚至目标页面可能已经被回写到磁盘上而从缓存中清掉，此时又要从磁盘上读回来，这增加了很多开销
                - 频繁的移动、分页操作造成了大量的碎片，得到了不够紧凑的索引结构，后续不得不通过OPTIMIZE TABLE来重建表并优化填充页面
        + 主键要选择较短的数据类型， Innodb引擎普通索引都会保存主键的值，较短的数据类型可以有效的减少索引的磁盘空间，提高索引的缓存效率
        + 数据记录本身被存于主索引（一颗B+Tree）的叶子节点上，这就要求同一个叶子节点内（大小为一个内存页或磁盘页）的各条数据记录按主键顺序存放
        + 无主键的表删除，在row模式的主从架构，会导致备库夯住
    - INDEX 索引:普通索引
        + 不是唯一的
    - UNIQUE 索引:会做强唯一限制
        + 插入和修改的时候会校验该索引对应的列的值是否已经存在
        + 唯一索引可以为空，但是空值只能有一个，主键不能为空
    - FULLTEXT索引:只在MYISAM 存储引擎支持, 目的是全文索引，在VARCHAR或者TEXT类型的列上创建，在内容系统中用的多， 在全英文网站用多(英文词独立). 中文数据不常用，意义不大 国内全文索引通常 使用 sphinx 来完成.全文索引:fulltext是Myisam表特殊索引，从文本中找关键字不是直接和索引中的值进行比较
        + MySQL 自带的全文索引只能用于 InnoDB、MyISAM ，并且只能对英文进行全文检索，一般使用 ES，Solr 这样的全文索引引擎
* 索引选择性
    - 对索引列和字符串前缀长度，参考选择性（Selectivity）这个指标来确定
    - 选择性定义:不重复的索引值和数据总记录条数的比值，其选择性越高，那么索引的查询效率也越高。唯一索引的选择性是1，这时最好的索引选择性，性能也是最好的.譬如对于性别这种参数，建立索引根本没有意义
    - Index Selectivity = Cardinality / #T 取值范围为 (0, 1]
    - `SELECT count(DISTINCT(title))/count(*) AS Selectivity FROM titles;`
* 优点
    - 通过合理的使用数据库索引可以大大提高系统的访问性能
    - 大大减轻了服务器需要扫描的数据量
    - 从而提高了数据的检索速度
    - 帮助服务器避免排序和临时表
    - 可以将随机 I/O 变为顺序 I/O
* 不适用场景
    - 表记录太少
    - 经常插入、删除、修改的表
    - 数据重复且分布平均的表字段，假如一个表有10万行记录，有一个字段A只有T和F两种值，且每个值的分布概率大约为50%，那么对这种表A字段建索引一般不会提高数据库的查询速度。
    - 经常和主字段一块查询但主字段索引值比较多的表字段
* 前缀索引：一个索引可以包括15个列
    - 两个列的值按照申明时候的顺序进行拼接后再构建索引
    - 建立多个单列索引，查询时和上述的组合索引效率也会大不一样，远远低于我们的组合索引。虽然此时有了三个索引，但MySQL只能用到其中的那个它认为似乎是最有效率的单列索引
    - 最左前缀（Leftmost Prefixing）。假如有一个多列索引为key(firstname lastname age)，当搜索条件是以下各种列的组合和顺序时，MySQL将使用该多列索引：firstname，lastname，age  firstname，lastname firstname
    - (a,b,c)复合索引， ac 可以使用到索引a
    - 联合索引前缀：在建立多列索引的时候，必须按照从左到右的顺序使用全部或部分的索引列，才能充分的使用联合索引，比如：(col1, col2, col3) 使用 (col1)、(col1, col2)、(col1, col2, col3) 有效。在查询语句中会一直向右匹配直到遇到范围查询 (>,<,BETWEEN,LIKE) 就停止匹配，其后的索引列将不会使用索引来优化查找了
        + 以 (name, city, interest) 三个字段联合的索引为例，如果查询条件为 where name='Bush'; 那么就只需要根据 B+树定位到 name 字段第一个 Bush 所在的值，然后顺序扫描后续数据，直到找到第一个不为 Bush 的数据即可，扫描过程中将该索引片的数据 id 记录下来，最后根据 id 查询聚簇索引获取结果集。同理对于查询条件为 where name='Bush' and city='Chicago'; 的查询，MySQL 可以根据联合索引直接定位到中间灰色部分的索引片，然后获取该索引片的数据 id，最后根据 id 查询聚簇索引获取结果集。
        + 无法跨越字段使用联合索引，如 where name='Bush' and interest='baseball';，对于该查询，name 字段是可以使用联合索引的第一个字段过滤大部分数据的，但是对于 interest 字段，其无法通过 B+ 树的特性直接定位第三个字段的索引片数据，比如这里的 baseball 可能分散在了第二条和第七条数据之中。最终，interest 字段其实进行的是覆盖索引扫描。
        + 对于非等值条件，如 >、<、!= 等，联合索引前缀对于索引片的过滤只能到第一个使用非等值条件的字段为止，后续字段虽然在联合索引上也无法参与索引片的过滤。这里比如 where name='Bush' and city>'Chicago' and interest='baseball';，对于该查询条件，首先可以根据 name 字段过滤索引片中第一个字段的非 Bush 的数据，然后根据联合索引的第二个字段定位到索引片的 Chicago 位置，由于其是非等值条件，这里 MySQL 就会从定位的 Chicago 往下顺序扫描，由于 interest 字段是可能分散在索引第三个字段的任何位置的，因而第三个字段无法参与索引片的过滤。
        + 使用索引对结果进行排序，需要索引的顺序和 ORDER BY 子句中的顺序一致，并且所有列的升降序一致(ASC/DESC)。如果查询连接了多个表，只有在 ORDER BY 的列引用的是第一个表才可以(需要按序 JOIN)。
    - like 前缀:用的表达式为 first_name like 'rMq%';那么其是可以用到 first_name 字段的索引的
        + 底层实际上是使用了一个补全策略来使用索引的，比如这里 first_name like 'rMq%';，MySQL 会将其补全为两条数据：rMqAAAAA 和 rMqzzzzz，后面补全部分的长度为当前字段的最大长度。在使用索引查询时，MySQL 就使用这两条数据进行索引定位，最后需要的结果集就是这两个定位点的中间部分的数据
    - 字符串前缀:只取字符串前几个字符建立的索引。在进行查询时，如果一个字段值较长，那么为其建立索引的成本将非常高，并且查询效率也比较低，字符串前缀索引就是为了解决这一问题而存在的。字符串前缀索引主要应用在两个方面：
        + 字段前缀部分的选择性比较高；
        + 字段整体的选择性不太大（如果字段整体选择性比较大则可以使用哈希索引）
        + 如何选择前缀的长度，长度选择合适时，前缀索引的过滤性将和对整个字段建立索引的选择性几乎相等。这里需要用到前面讲解的关于字段选择性的概念
    - 如果是CHAR，VARCHAR类型，length可以小于字段实际长度；如果是BLOB和TEXT类型，必须指定 length
* 聚簇索引(Clustered Index)
    - 聚集索引不是一种单独的索引类型，而是一种存储数据的方式."聚簇" 是指实际的数据行和相关的键值保存在一起
    - Innodb的数据文件本身就是索引文件,按 B+Tree 组织的一个索引结构，这棵树的叶节点 data 域保存了完整的数据记录,key 是数据表的主键，因此 InnoDB 表数据文件本身就是主索引
    - 每个表只能有一个聚集索引，因此不能一次把行保存在两个地方
        + 定义了主键:通过主键来聚集数据
        + 没有定义主键:非空的唯一索引（Unique NOT NULL）
        + 没有唯一的非空索引:自动创建一个 6 个字节大小的指针，用户不能查看或访问
    - 聚集索引可以很大程度的提高访问速度:找到了索引也就相应的找到了对应的行数据
    - 主键的选择
        + 最好是顺序递增
        + 注意避免随机的聚集索引（主键值不连续，且分布范围不均匀）
        + 如使用 UUID 来作为聚集索引性能会很差，因为 UUID 值的不连续会导致增加很多的索引碎片和随机I/O，最终导致查询的性能急剧下降。
        + 如果主键是一个很长的字符串并且建了很多普通索引，将造成普通索引占有很大的物理空间
    - 在叶子页(Leaf Page)中存储了完整的数据行，实际也是表的一种数据存储方式，这样的表也称索引组织表(Index Organized Table, IOT)
    - 一个InnoDB表中通常只能有一个聚簇索引，被定义在主键上。MYISAM 不支持该索引类型，其索引文件(.MYI)和数据文件(.MYD)是相互独立的
    - gap lcok 间隙锁。锁住的是索引的间隙,避免出现幻读
    - INNODB和MYISAM的主键索引与二级索引的对比：可以看出MYISAM的主键索引和二级索引没有任何区别，主键索引仅仅只是一个叫做PRIMARY KEY的唯一非空的索引，因此 MYISAM 可以不设主键
* 辅助索引(Secondary Index)：又叫二级索引，指除聚簇索引之外的所有索引,节点存的是数据的主键，需要根据主键二次查找
    - InnoDB的二级索引的叶子节点包含主键值而不是行指针(Row Pointer)，这减小了移动数据或者数据页面分裂时维护二级索引的开销，因为InnoDB不需要更新索引的行指针
    - 根据申明这个索引时候的列来构建，叶子节点存放的是这一行记录对应的主键的值，根据普通索引查询需要先在普通索引上找到对应的主键的值，然后根据主键值去聚簇索引上查找记录，俗称回表
    - data 域存储相应记录主键的值而不是地址
* 覆盖索引(Covering Index)：如果索引包含所有满足查询需要的数据
    - 不需要回表(读取行数据 回磁盘扫描相应的数据，从而避免了查询中最耗时的磁盘 I/O 读取)
    - InnoDB
        + 覆盖索引查询时除了索引本身的包含的列，还可以使用其默认的聚集索引列
        + 这跟INNOB的索引结构有关系，主索引是B+树索引存储，也即我们所说的数据行即索引，索引即数据
        + 对于INNODB的辅助索引，它的叶子节点存储的是索引值和指向主键索引的位置，然后需要通过主键在查询表的字段值，所以辅助索引存储了主键的值
        + 覆盖索引也可以用上INNODB 默认的聚集索引
        + innodb引擎的所有储存了主键ID，事务ID，回滚指针，非主键ID，查询就会是非主键ID也可覆盖来取得主键ID
        + InnoDB使用聚集索引组织数据，如果二级索引中包含查询所需的数据，就不再需要在聚集索引中查找
        + Innodb的辅助索引叶子节点包含的是主键列，所以主键一定是被索引覆盖
    - 优点
        + 索引项通常比记录要小，访问更少的数据
        + 索引都按值的大小顺序存储，相对于随机访问记录，需要更少的I/O
        + 大多数据引擎能更好的缓存索引，比如MyISAM只缓存索引
    - 查看是否使用了覆盖索引可以通过 explain 中的Extra中的值为 Using index
    - 如果查询只使用来自某个表的数字型并且构成某些关键字的最左面前缀的列，为了更快，可以从索引树检索出值。`SELECT key_part3 FROM tb WHERE key_part1=1`
    - 注意
        + 并不适用于任意的索引类型，索引必须存储列的值
        + Hash 和full-text索引不存储值，因此MySQL只能使用B-TREE
        + 不同的存储引擎实现覆盖索引不同
        + 并不是所有的存储引擎都支持它们
        + 如果要使用覆盖索引，一定要注意SELECT 列表值取出需要的列，不可以是SELECT *，因为如果将所有字段一起做索引会导致索引文件过大，查询性能下降，不能为了利用覆盖索引而这么做
* 三星索引：是对于一个查询，设立了三个通用的索引条件满足的条件，建立的索引对于特定的查询每满足一个条件就表示该索引得到一颗星，当该索引得到三颗星时
    - 取出所有的等值谓词的列 （WHERE COL=…） 作为索引开头的列；
    - 将 ORDER BY 中的列加入到索引中；
    - 将查询语句中剩余的列加入到索引中，将易变得列放到最后以降低更新成本。
* 排序：对结果集进行排序操作:每扫描一条索引记录就回表查询一次对应的行。读取操作基本上是随机I/O
    - 使用filesort
        + 排序算法
            * 两遍扫描算法(Two passes) 实现方式是先将需要排序的字段和可以直接定位到相关行数据的指针信息取出，然后在设定的内存（通过参数sort_buffer_size设定）中进行排序，完成排序之后再次通过行指针信息取出所需的Columns，该算法是4.1之前采用的算法，它需要两次访问数据，尤其是第二次读取操作会导致大量的随机I/O操作。另一方面，内存开销较小
            * 一次扫描算法(single pass) 该算法一次性将所需的Columns全部取出，在内存中排序后直接将结果输出，从 MySQL 4.1 版本开始使用该算法。它减少了I/O的次数，效率较高，但是内存开销也较大
        + 将并不需要的Columns也取出来，就会极大地浪费排序过程所需要的内存。在 MySQL 4.1 之后的版本中，可以通过设置 max_length_for_sort_data 参数来控制 MySQL 选择第一种排序算法还是第二种
        + 当取出的所有大字段总大小大于 max_length_for_sort_data 的设置时，MySQL 就会选择使用第一种排序算法，反之，则会选择第二种
        + 如果查询是连接多个表，仅当ORDER BY中的所有列都是第一个表的列时才会使用索引，其它情况都会使用filesort
        + MySQL必须将查询的结果集生成一个临时表，在连接完成之后进行filesort操作，此时，EXPLAIN输出 “Using temporary;Using filesort”
    - 按索引顺序扫描：可以利用同一索引同时进行查找和排序操作
        + 当索引的顺序与ORDER BY中的列顺序相同且所有的列是同一方向(全部升序或者全部降序)时，可以使用索引来排序
        + 按照索引顺序读取数据的速度通常要比顺序地全表扫描要慢
        + 按照索引顺序扫描得出的结果自然是有序的:只需要从一条索引记录移动到相邻的下一条记录
    - 如果explain的结果中 type 列的值为 index 表示使用了索引扫描来做排序
    - 如果查询需要关联多张表，则只有 ORDER BY子句引用的字段全部为第一张表时，才能使用索引做排序
    - 当MySQL不能使用索引进行排序时，就会利用自己的排序算法(快速排序算法)在内存(sort buffer)中对数据进行排序，如果内存装载不下，它会将磁盘上的数据进行分块，再对各个数据块进行排序，然后将各个块合并成有序的结果集（实际上就是外排序）
* 冗余和重复索引:在相同的列上按照相同的顺序创建的相同类型的索引，应当尽量避免这种索引，发现后立即删除
    - 冗余索引经常发生在为表添加新索引时
    - 大多数情况下都应该尽量扩展已有的索引而不是创建新索引
* 定期删除一些长时间未使用过的索引是一个非常好的习惯
* 一条sql 语句操作了主键索引，Mysql 就会锁定这条主键索引；如果一条语句操作了非主键索引，MySQL会先锁定该非主键索引，再锁定相关的主键索引
* 索引并不总是最好的工具，只有当索引帮助提高查询速度带来的好处大于其带来的额外工作时，索引才是有效的
* 对具体有索引的列key_col找出MAX()或MIN()值。由预处理器进行优化，检查是否对索引中在key_col之前发生所有关键字元素使用了WHERE key_part_# = constant。在这种情况下，MySQL为每个MIN()或MAX()表达式执行一次关键字查找，并用常数替换它。如果所有表达式替换为常量，查询立即返回。例如：SELECT MIN(key2), MAX (key2)  FROM tb WHERE key1=10;
* 如果对一个可用关键字的最左面的前缀进行了排序或分组(例如，ORDER BY key_part_1,key_part_2)，排序或分组一个表。如果所有关键字元素后面有DESC，关键字以倒序被读取。
* 最左前缀原则，在创建联合索引时，索引字段的顺序需要考虑字段值去重之后的个数，较多的放前面。ORDER BY子句也遵循此规则
    - 查询的时候如果两个条件都用上了，但是顺序不同，查询引擎会自动优化为匹配联合索引的顺序，这样是能够命中索引的
* 有时MySQL不使用索引，即使有可用的索引
    - 一种情形是当优化器估计到使用索引将需要MySQL访问表中的大部分行时。(在这种情况下，表扫描可能会更快些）
    - 然而，如果此类查询使用LIMIT只搜索部分行，MySQL则使用索引，因为它可以更快地找到几行并在结果中返回。
* 哈希索引
    - 基于散列表实现，采用一定的哈希算法，把键值换算成哈希值，散列表里的每个元素指向数据行的指针，索引自身只存储对应的哈希值，所以索引的结构十分紧凑，查找速度非常快
    - 检索时不需要类似B+树那样从根节点到叶子节点逐级查找，只需一次哈希算法即可
    - 等值查询（只有精确匹配索引所有列的查询才有效），哈希索引具有绝对优势（前提是：没有大量重复键值，如果大量重复键值时，哈希索引的效率很低，因为存在所谓的哈希碰撞问题）
    - 缺点
        + 只包含哈希值和行指针，不存储字段值，所以不能使用索引中的值来避免读取行
        + 不支持范围查询以及排序：并不是按照索引值顺序存存储的
        + 不支持联合索引的最左前缀匹配规则
    - InnoDB 引擎中，有一种特殊的功能叫「自适应哈希索引」，如果 InnoDB 注意到某些索引列值被频繁使用时，它会在内存基于 B+ 树索引之上再创建一个哈希索引，这样就能让 B+树也具有哈希索引的优点
    - HEAP表中，如果存储的数据重复度很低（也就是说基数很大），对该列数据以等值查询为主，没有范围查询、没有排序的时候，特别适合采用哈希索引
* Hash 和full-text索引不存储值，因此MySQL只能使用B-TREE

![clustered-index](../_static/clustered-index.jpg "clustered-index")

```sql
CREATE TABLE `inventory` (
  `inventory_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `film_id` smallint(5) unsigned NOT NULL,
  `store_id` tinyint(3) unsigned NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`inventory_id`),
  KEY `idx_fk_film_id` (`film_id`),
  KEY `idx_store_id_film_id` (`store_id`,`film_id`),
  CONSTRAINT `fk_inventory_film` FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_inventory_store` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4582 DEFAULT CHARSET=utf8 |

ALTER TABLE `table_name` ADD PRIMARY KEY ( `column` ) # 添加PRIMARY KEY（主键索引）
ALTER TABLE `table_name` ADD UNIQUE ( `column` ) # 添加UNIQUE(唯一索引)
ALTER TABLE `table_name` ADD INDEX index_name ( `column` ) # 添加INDEX(普通索引)
ALTER TABLE `table_name` ADD FULLTEXT ( `column`) # 添加FULLTEXT(全文索引)
ALTER TABLE `table_name` ADD INDEX index_name ( `A`, `B`, `C` ) # 添加多列索引

# 使用索引
A>5 AND A<10 # 最左前缀匹配
A=5 AND B>6 # 最左前缀匹配
A=5 AND B=6 AND C=7 # 全列匹配
A=5 AND B IN (2,3) AND C>5 # 最左前缀匹配，填坑

# 不能使用索引
B>5 # 没有包含最左前缀
B=6 AND C=7 # 没有包含最左前缀

# 使用部分索引
A>5 AND B=2 # 使用索引 A 列
A=5 AND B>6 AND C=2 # 使用索引的 A 和 B 列

# 使用索引排序
ORDER BY A # 最左前缀匹配
WHERE A=5 ORDER BY B,C # 最左前缀匹配
WHERE A=5 ORDER BY B DESC # 最左前缀匹配
WHERE A>5 ORDER BY A,B # 最左前缀匹配

# 不能使用索引排序
WHERE A=5 ORDER BY B DESC,C ASC # 升降序不一致
WHERE A=5 ORDER BY B,D # D 不在索引中
WHERE A=5 ORDER BY C # 没有包含最左前缀
WHERE A>5 ORDER BY B,C # 第一列是范围条件，无法使用 BC 排序
WHERE A=5 AND B IN(1, 2) ORDER BY C # B 也是范围条件，无法用 C 排序

select count(*) as cnt, first_name as perf from actor group by perf ORDER BY cnt desc limit 10;    -- 0
select count(*) as cnt, left(first_name, 2) as perf from actor group by perf ORDER BY cnt desc limit 10;    -- 2
select count(*) as cnt, left(first_name, 3) as perf from actor group by perf ORDER BY cnt desc limit 10;    -- 3
select count(*) as cnt, left(first_name, 4) as perf from actor group by perf ORDER BY cnt desc limit 10;    -- 4

# 覆盖索引：建立联合索引(a, b, c)
select a, b, c from t where a='a' and b='b';

## 三星索引
SELECT first_name, last_name, email FROM user WHERE first_name = 'aa' ORDER BY last_name;

# 最左列为常数，索引：(date,staff_id,customer_id)
select staff_id , customer_id from demo where date = '2015-06-01'order by staff_id , customer_id
```

## 慢日志 slow log

* 使用慢查询日志，设置相应的阈值（比如超过3秒就是慢SQL），在生产环境跑上个一天过后，看看哪些SQL比较慢
* 使用MySQL自带的mysqldumpslow命令可以非常明确的得到各种我们需要的查询语句，对MySQL查询语句的监控、分析、优化是MySQL优化非常重要的一步。
    - 开启慢查询日志后，由于日志记录操作，在一定程度上会占用CPU资源影响mysql的性能，但是可以阶段性开启来定位性能瓶颈。
    - -s, 是表示按照何种方式排序，c、t、l、r分别是按照记录次数、时间、查询时间、返回的记录数来排序，ac、at、al、ar，表示相应的倒序
    - -t, 是top n的意思，即为返回前面多少条的数据；
    - -g, 后边可以写一个正则匹配模式，大小写不敏感的；
* percona公司的pt-query-digest工具，日志分析功能全面，可分析slow log、binlog、general log

```sql
# 修改配置文件，服务重启
long_query_time = 2 # 设置把日志写在那里，可以为空，系统会给一个缺省的文件
log-slow-queries = D:/mysql/logs/slow.log

# 开启慢查询日志
set global slow-query-log=on
# 指定慢查询日志文件位置
set global slow_query_log_file='/var/log/mysql/mysql-slow.log';
# 记录没有使用索引的查询
set global log_queries_not_using_indexes=on;
# 只记录处理时间1s以上的慢查询
set global long_query_time=1;

# 查看最慢的前三个查询
mysqldumpslow -t 3 /var/log/mysql/mysql-slow.log
/path/mysqldumpslow -s r -t 10 /database/mysql/slow-log # 返回记录集最多的10个查询
/path/mysqldumpslow -s t -t 10 -g “left join” /database/mysql/slow-log # 得到按照时间排序的前10条里面含有左连接的查询语句。

# 分析慢查询日志
pt-query-digest /var/log/mysql/mysql-slow.log
# 分析binlog日志
mysqlbinlog mysql-bin.000001 >mysql-bin.000001.sql
pt-query-digest --type=binlog mysql-bin.000001.sql
#分析普通日志
pt-query-digest --type=genlog localhost.log
```

## 存储过程（Stored Procedure）

* 一种在数据库中存储复杂程序，以便外部程序调用的一种数据库对象. 数据库 SQL 语言层面的代码封装与重用
* 为了完成特定功能的SQL语句集，经编译创建并保存在数据库中，用户可通过指定存储过程的名字并给定参数(需要时)来调用执行
* 可以回传值，并可以接受参数
    - in/out参数尽量少用
* 存储过程和默认数据库相关联，如果想指定存储过程创建在某个特定的数据库下，那么在过程名前面加数据库名做前缀
* 创建的存储过程保存在数据库的数据字典中
* 过程体
    - dml、ddl语句，if-then-else和while-do语句、声明变量的declare语句
    - begin开始，以end结束(可嵌套)
    - 表示过程体结束的begin-end块，则不需要分号
* 变量
    - 用户变量名一般以@开头
    - 可以读写用户变量，全局可以读取到
    - 全局变量的值作为参数传入存储过程，修改的局部作用域的副本
    - 内部的变量在其作用域范围内享有更高的优先权
*  参数 `IN|OUT|INOUT 参数名 数据类型`
    - IN       输入：在调用过程中，将数据输入到过程体内部的参数
    - OUT      输出：在调用过程中，将过程体处理完的结果返回到客户端
    - INOUT    输入输出：既可输入，也可输出
* 注释：--：该风格一般用于单行注释
* 更改用 CREATE PROCEDURE 建立的预先指定的存储过程，其不会影响相关存储过程或存储功能
* 存储函数

```sql
SET @p_in=1

use ecommerce;
DROP PROCEDURE IF EXISTS BatchInser;
delimiter //   -- 把界定符改成双斜杠
CREATE PROCEDURE BatchInsert(IN init INT, IN loop_time INT)  -- 第一个参数为初始ID号（可自定义），第二个位生成MySQL记录个数
  BEGIN
      DECLARE Var INT;
      DECLARE ID INT;
      DECLARE l_int int unsigned default 4000000;
      SET Var = 0;
      SET ID = init;
      WHILE Var < loop_time DO
          insert into employees(id, fname, lname, birth, hired, separated, job_code, store_id) values (ID, CONCAT('chen', ID), CONCAT('haixiang', ID), Now(), Now(), Now(), 1, ID);
          SET ID = ID + 1;
          SET Var = Var + 1;
      END WHILE;
  END;
  //
delimiter ;  -- 界定符改回分号

CALL BatchInsert(30036, 200000);   -- 调用存储过程插入函数

label1: BEGIN
　　label2: BEGIN
　　　　label3: BEGIN
        declare var int;
        set var=parameter+1;

        if var=0 then
        insert into t values(17);
        end if;
        if parameter=0 then
        update t set s1=s1+1;
        else
        update t set s1=s1+2;
        end if;

        case var
        when 0 then
        insert into t values(17);
        when 1 then
        insert into t values(18);
        else
        insert into t values(19);
        end case;

        while var<6 do
        insert into t values(var);
        set var=var+1;
        end while;

        repeat
        insert into t values(v);
        set v=v+1;
        until v>=5
        end repeat;

        LOOP_LABLE:loop
        insert into t values(v);
        set v=v+1;
        if v >=5 then
        leave LOOP_LABLE;
        end if;
        end loop;

        LOOP_LABLE:loop
        if v=3 then
        set v=v+1;
        ITERATE LOOP_LABLE;
        end if;
        insert into t values(v);
        set v=v+1;
        if v>=5 then
        leave LOOP_LABLE;
        end if;
        end loop;
　　　　END label3 ;
　　END label2;
END label1

# 输出参数
delimiter //
create procedure out_param(out|inout p_out int)
    begin
      select p_out;
      set p_out=2;
      select p_out;
    end
    //
delimiter ;

set @p_out=1;
call out_param(@p_out);

DECLARE l_numeric number(8,2) DEFAULT 9.95;
DECLARE l_date date DEFAULT '1999-12-31';
DECLARE l_datetime datetime DEFAULT '1999-12-31 23:59:59';
DECLARE l_varchar varchar(255) DEFAULT 'This will not be padded';

SELECT 'Hello World' into @x;
SET @y='Goodbye Cruel World';

CREATE PROCEDURE GreetWorld( ) SELECT CONCAT(@greeting,' World');
SET @greeting='Hello';
CALL GreetWorld( );

select name from mysql.proc where db='数据库名';
select routine_name from information_schema.routines where routine_schema='数据库名';
showprocedure status where db='数据库名';
SHOWCREATE PROCEDURE 数据库.存储过程名;

SHOW FUNCTION STATUS LIKE 'partten'
SHOW CREATE FUNCTION function_name;
ALTER PROCEDURE
ALTER FUNCTION function_name 函数选项
```

## 触发器

* 触发程序是与表有关的命名数据库对象，当该表出现特定事件时，将激活该对象监听：记录的增加、修改、删除
* 参数
    - trigger_time是触发程序的动作时间。可以是 before 或 after，以指明触发程序是在激活它的语句之前或之后触发
    - trigger_event指明了激活触发程序的语句的类型
        + INSERT：将新行插入表时激活触发程序
        + UPDATE：更改某一行时激活触发程序
        + DELETE：从表中删除某一行时激活触发程序
    - tbl_name：监听的表，必须是永久性的表，不能将触发程序与TEMPORARY表或视图关联起来。
    - trigger_stmt：当触发程序激活时执行的语句。执行多个语句，可使用BEGIN...END复合语句结构
* 对于具有相同触发程序动作时间和事件的给定表，不能有两个触发程序
* 可以使用old和new代替旧的和新的数据
    - 更新操作，更新前是old，更新后是new
    - 删除操作，只有old
    - 增加操作，只有new
* Insert into on duplicate key update 语法会触发：
    - 如果没有重复记录，会触发 before insert, after insert;
    - 如果有重复记录并更新，会触发 before insert, before update, after update;
    - 如果有重复记录但是没有发生更新，则触发 before insert, before update
* Replace 语法 如果有记录，则执行 before insert, before delete, after delete, after insert

```sql
CREATE TRIGGER trigger_name trigger_time trigger_event ON tbl_name FOR EACH ROW trigger_stmt

DROP TRIGGER [schema_name.]trigger_name
```

## 视图

* 视图是一个虚拟表，其内容由查询定义。同真实的表一样，视图包含一系列带有名称的列和行数据
* 视图并不在数据库中以存储的数据值集形式存在。行和列数据来自由定义视图的查询所引用的表，并且在引用视图时动态生成
* 视图具有表结构文件，但不存在数据文件
* 对其中所引用的基础表来说，视图的作用类似于筛选。定义视图的筛选可以来自当前或其它数据库的一个或多个表，或者其它视图
* 通过视图进行查询没有任何限制，通过它们进行数据修改时的限制也很少
* 视图是存储在数据库中的查询的sql语句，它主要出于两种原因
    - 安全原因，视图可以隐藏一些数据，如：社会保险基金表，可以用视图只显示姓名，地址，而不显示社会保险号和工资数等
    - 可使复杂的查询易于理解和使用
* 一般不修改视图，因为不是所有的更新视图都会映射到表上
* 删除视图后，数据依然存在
* 语法
    - 视图名必须唯一，同时不能与表重名
    - 视图可以使用select语句查询到的列名，也可以自己指定相应的列名
    - 可以指定视图执行的算法，通过ALGORITHM指定
    - column_list如果存在，则数目必须等于SELECT语句检索的列数
* 作用
    - 简化业务逻辑
    - 对客户端隐藏真实的表结构
* 算法(ALGORITHM)
    - MERGE        合并 将视图的查询语句，与外部查询需要先合并再执行
    - TEMPTABLE    临时表 将视图执行完毕后，形成临时表，再做外层查询
    - UNDEFINED    未定义(默认)，指的是MySQL自主去选择相应的算法

```sh
CREATE [OR REPLACE] [ALGORITHM = {UNDEFINED | MERGE | TEMPTABLE}] VIEW view_name [(column_list)] AS select_statement

SHOW CREATE VIEW view_name；

ALTER VIEW view_name [(column_list)] AS select_statement
DROP VIEW [IF EXISTS] view_name
```

## 影像复制

## 主从复制

实现Data Distribution、Load Balancing、Backups、High Availability and Failover等特性

* Binlog 是按照事务提交的先后顺序记录的， 恢复也是按这个顺序进行
* 复制方式
    - 基于语句复制(默认)：在主服务器上执行的SQL语句，在从服务器上执行同样的语句，效率比较高
    - 基于行复制：MySQL5.0开始支持把改变的内容复制过去，而不是把命令在从服务器上执行一遍
    - 混合类型复制：默认采用基于语句的复制，一旦发现基于语句的无法精确的复制时，就会采用基于行的复制
* 流程
    - Master binlog 输出线程：Master为每一个复制连接请求创建一个binlog输出线程，用于输出日志内容到相应的 Slave
    - Slave I/O线程：在start slave之后，负责从Master上拉取binlog内容放进自己的Relay Log中
    - Slave SQL线程：负责执行Relay Log中的语句
    - Master实例将数据变更写入二进制日志(binary log,记录叫做二进制日志事件binary log events，可以通过show binlog events进行查看）
    - slave将master的binary log events拷贝到它的中继日志(relay log)
    - slave重做中继日志中的事件，将改变反映它自己的数据
* 问题
    - 无法远程连接mysql(报错111)：注释掉my.cnf中的bind-address或绑定本地ip
    - 添加server-id and log_bin=
    - 主从服务器检查show variables like 'server%'
    - 主服务器与从服务器

![master-slave](../_static/master-slave.gif "master-slave")

```sql
# 主从同步的关键点，从库上不需要开启
relay-log = /data/3306/relay-bin
relay-log-info-file = /data/3306/relay-log.info
binlog_cache_size = 1M
max_binlog_cache_size = 1M
max_binlog_size = 2M
expire_logs_days = 7
key_buffer_size = 16M
read_buffer_size = 1M
read_rnd_buffer_size = 1M
bulk_insert_buffer_size = 1M
lower_case_table_names = 1
skip-name-resolve
slave-skip-errors = 1032,1062
replicate-ignore-db=mysql
server-id = 1    #主库从库ID 不可相同

GRANT REPLICATION SLAVE ON *.* TO 'slave_user'@'%' IDENTIFIED BY 'slave_password';
FLUSH PRIVILEGES;
SHOW MASTER STATUS;

CHANGE MASTER TO MASTER_HOST='202.167.45.10',MASTER_USER='slave_user', MASTER_PASSWORD='slave_password', MASTER_LOG_FILE='mysql-bin.000001', MASTER_LOG_POS=  107;
START slave;
show slave status\G;

Slave_IO_Running = NO：stop slave; reset slave;start slave;

# 锁表
mysql -uroot -p123456 -S /data/3306/mysql.sock -e "flush table with read lock;"
# 备份
mysql -uroot -p123456 -S /data/3306/mysql.sock -e "show master status;" >/backup/mysql.log
mysqldump -uroot -p123456 -S /data/3306/mysql.sock -A -B |gzip >/backup/mysql.sql.gz
# 解锁
mysql -uroot -p123456 -S /data/3306/mysql.sock -e "unlock tables;"

# 主库的备份文件解压并恢复数据库
mysql -uroot -p123456 -S /data/3307/mysql.sock < mysql.sql
mysql -u username -p database_name < file.sql
mysql -u username –-password=your_password database_name < file.sql
```

## 读写分离

* 定义：主库进行事务性查询（插入、更新、删除）操作，从库进行 SELECT 查询操作
* 意义：
    - 对大部分 web 应用而言，都是读多写少，一主多从可以提高系统的并发处理能力
    - 增加冗余备份，一处写入（主），多处同步（从），可以提高系统的可用性
    - 读写分离，让主库专注于写，让读库专注于读，区分优化读库和写库，从而提升数据库性能
* 实现：
    - 在代码层级，需要将查询和写入操作区分开，通过不同的数据库连接实现，对于简单的读写分离，通过配置文件完成即可，对于多个主库/从库，从配置数组中随机选取一个建立连接即可，对于更复杂的数据库集群，可以通过数据库中间件来建立连接
        + 通过mysql-proxy调度：与主服务器在一台服务器上，用源代码安装含有lua脚本
    - 在数据库级别，要实现主库记录通过同步机制实时同步到从库，以便随时可以从从库查询到最新记录，关于这一块可以通过配置主库和从库通过 binlog 日志实现数据同步复制
        + 数据延迟:由于需要从库通过网络请求去主库拉取数据，对于高并发场景，可能会由于系统负载、网络延迟问题导致从库和主库短期内的数据不一致（毫秒级或者秒级），针对这种情况，对于简单的中小型系统，可以在写入操作完成后强制查询操作使用主库连接来解决，比如 Laravel 的数据库 sticky 配置项底层实现就是这么干的，此外还可以借助缓存层来解决这种不一致性，然后主从同步之后触发缓存更新
* 复制方法
    - 基于SQL语句
        + 对于存在随机数的字段会出现数据不一致
    - 基于行：记录SQL的所影响的行和相关的值
        + Insert，记录下所有列的新值。
        + Delete，记录下到底是哪一行被删除(用主键来标识)
        + Update，记录下哪一行被更新(用主键来标识)，以及被更新的列和新值
        + Update语句：会出现一条语句更新一半数据情况
* 数据延迟
    - 先写DB，再写缓存，等缓存过期的时候，数据同步已经完成
    - 同步做成提交（添加）与审核（同步）状态

## 中间件

* 优劣
    - 一些通用的指标
    - 要结合业务特点，包括业务的读写 qps ，涉及的库表结构和SQL语句，来进行综合的判断
* 中间件产品发展至今，分为两代
    - 传统的中间件软件，如mysql proxy， mycat， oneproxy，atlas，kingshard等.使用这些中间件，你还是需要部署中间件模块，做各种配置，系统扩容是还需要停服做数据迁移，需要比较多的时间投入
    - 和公有云结合的，基于中间件的分布式数据库，如阿里DRDS、UCloud UDDB，腾讯云DCDB For TDSQL等,对用户呈现的，是一个类似单机数据库一样的操作和管理界面，管理简单，使用方便
        + 以UCloud 的UDDB为例
            * 在Web控制台上，一步即可创建并配置好中间件和数据库节点，搭建出一个完整的分布式数据库；
            * 通过特殊的建表语句， 即可以配置表的水平划分方式。
    - 对于中间件复杂的水平扩容问题，可以通过一个按钮即可完成水平扩容操作，期间不停服，只是每隔一段时间有几毫秒到零点几秒的访问中断
- 功能
    + 分库分表
        * 能够做到一级划分（只根据一个字段来做分区），还是能够做到二级划分（能够根据两个字段来做分区）
        * 划分的形式是否多样（常见有 range、list、hash 方式）
        * 划分字段的类型是否能支持多种（比如是只支持根据数值类型字段做划分，还是可以根据数值、字符串、日期类型做划分）
        * 能否提供避免数据倾斜的分区方式等
    + 读写分离
        * 透明的读写分离，能够100%兼容 Mysql 或其他数据库的 SQL 语法，同时对于事务也能够正确处理（事务的 SQL 能够路由到主节点，而不是分散到主节点和只读节点）
        * 简单的读写分离，对 SQL 的支持范围，只限于数据库中间件内置的 SQL 解释器，有些复杂 SQL 是支持不了的，同时对于事务，也做不到很好的支持。简单的读写分离功能只是把写发往主节点，读都发往从节点
        * 读写分离功能做得细致的话，数据库中间件会能够提供对分流策略的自定义。比如设置为：把30%的读流量，分流到主节点，70%的读流量分流到只读节点
* 产品的成熟度、用户的使用情况和社区（商业公司）支持程度。 数据库中间件虽然本身不做存储，但是每条数据都是要从中经过的，一旦出错，可能对业务造成灾难性的影响，所以软件的正确性和稳定性非常重要。中间件的成熟度、已经使用的客户的使用情况、数量、用户的口碑，以及开源社区或者商业公司对该产品的支持程度，就非常重要。一般来说，发布时间越长而且在持续迭代、用户使用数量众多，且有大规模业务使用，社区（包括 QQ 群）比较活跃，文档完善，bug 解决及时的产品，更值得信赖。
* 产品的易用性，是否配置方便，部署容易，系统管理不会有太大负担。有些中间件模块众多，配置复杂，虽然表面上看起来功能丰富，但业务用到的可能还是最基本的几个功能。选择这样的中间件，即显得不够划算，不仅加重运维负担，同时后续系统的扩展，新业务的支持，也不够敏捷。
* 是否满足自身业务目前的需求，和潜在的需求:必须根据自己业务的库表结构，分库分表/读写分离需求，业务的SQL语句，读写qps，来判断中间件产品的优劣。 比如，绝大部分中间件，目前都不能支持分布式事务和多表join，但是除了对这两种sql不支持，不少中间件，其实在一些基本的sql，比如带系统函数的sql、聚合类sql上，也支持不够好。
* 选择:
    - 需要根据业务的库表结构，sql语句，以及业务特点，去检查中间件是否对业务的目前sql和潜在sql，能够做到比较好的支持。
    - 选择中间件时，一定要自己做性能测试和压力测试，实事求是地自身业务特点来测定中间件的性能和稳定性情况，不要轻信官方或者第三方发布的一些性能数据
* 中间件产品的最高境界:不需要特别关注中间件，从而可以把精力放在数据库架构、优化和数据库本身的管理上

### MySQL Proxy

LVS、HAProxy、Nginx

* 作用是用来做负载均衡，数据库读写分离的。但是需要注意的是，MySQL Proxy还有个强大的扩展功能就是支持Lua语言
* 启动MySQL Proxy的时候，加载一个Lua脚本，对每一个进入的query或者insert之类的语句做一次安全检查，甚至替换查询中的某些内容，这样在程序员的 程序中忘记了过滤参数的情况下，还有最后一道防线可用。而且由于是Lua这样的动态脚本语言，在开发，修正，部署方面都会有极大的灵活性。
    - connect_server() — 这个函数每次client连接的时候被调用，可以用这个函数来处理负载均衡，决定当前的请求发给那个后台的服务器，如果没有指定这个函数，那么就会采用简单的轮询机制。
    - read_handshake() — 这个函数在server返回初始握手信息时被调用，可以调用这个函数在验证信息发给服务器前进行额外的检查。
    - read_auth() — client发送验证信息给服务器的时候会调用这个函数。
    - read_auth_result() — 服务器验证信息返回后调用这个函数。
    - read_query() — 每次client发送查询请求函数的时候被调用，可以用这个函数进行查询语句的预处理，过滤掉非预期的查询等等，这个是最常用的函数。
    - read_query_result() — 查询结果返回是调用的函数，可以进行结果集处理。

## [alibaba/canal](https://github.com/alibaba/canal)

* 阿里巴巴mysql数据库binlog的增量订阅&消费组件 。阿里云DRDS( https://www.aliyun.com/product/drds)、阿里巴巴TDDL 二级索引、小表复制powerd by canal
* 基于MySQL数据库增量日志解析，提供增量数据订阅和消费
* 基于日志增量订阅和消费的业务包括：
    - 数据库镜像
    - 数据库实时备份
    - 索引构建和实时维护（拆分异构索引、倒排索引等）
    - 业务Cache刷新
    - 带业务逻辑的增量数据处理
* 原理
    - Canal模拟MySQL Slave的交互协议，伪装自己为MySQL Slave，向MySQL Master发送dump协议
    - MySQL Master收到dump请求，开始推送binary log给Slave（即Canal）
    - Canal解析binary log对象（原始为byte流），并且可以通过连接器发送到对应的消息队列等中间件中
* 版本
    - v1.1.4：添加了鉴权、监控的功能，并且做了一些列的性能优化，此版本集成的连接器是Tcp、Kafka和RockerMQ
* 部件：
    - canal-admin：后台管理模块，提供面向WebUI的Canal管理能力
    - canal-adapter：适配器，增加客户端数据落地的适配及启动功能，包括REST、日志适配器、关系型数据库的数据同步（表对表同步）、HBase数据同步、ES数据同步等等。
    - canal-deployer：发布器，核心功能所在，包括binlog解析、转换和发送报文到连接器中等等功能都由此模块提供
* 部署
    - MySQL
    - Zookeeper
    - Kafka
    - Canal

## 分区、分表、分库

* 瓶颈:数据放在一起量太大 或者 数据库的活跃连接数增加，进而逼近甚至达到数据库可承载活跃连接数的阈值，出现了磁盘、IO、网络、CPU等撑不住的情况
    - IO瓶颈
        + 磁盘读IO瓶颈:热点数据太多，数据库缓存放不下，每次查询时会产生大量的IO，降低查询速度 -> 分库和垂直分表
        + 网络IO瓶颈:请求的数据太多，网络带宽不够 -> 分库
    - CPU瓶颈
        + SQL问题，如SQL中包含join，group by，order by，非索引字段条件查询等，增加CPU运算的操作 -> SQL优化，建立合适的索引，在业务Service层进行业务计算
        + 单表数据量太大，查询时扫描的行太多，SQL效率低，CPU率先出现瓶颈 -> 水平分表
* 隔离：一类数据操作的时候，对其它类数据没有影响
* 分区、分表、分库满足的是不同的隔离级别，以及解决不同的瓶颈
* 分片 Sharding：一个 Database 切分成几个部分放到不同的服务器上，以分布式的手段增强数据库的性能
    - 垂直切分：不同的表放在不同的服务器上
    - 水平切分：table 的数据量特别大，将这个表的数据分发到多个服务器上
    - 事务（Transaction）：在分布式数据库的情况下，事务需要跨越多个数据库节点以保持数据的完整性
    - 一般以水平切分为主，实现上以数据库中间件（Database middleware）为主
* 分区 Partition：由DBMS来完成的分区，根据一定规则，将数据库中的一张表分解成多个更小的，容易管理的部分。从逻辑上看，只有一张表，底层却是由多个物理分区组成
    - 类型
        + RANGE：基于属于一个给定连续区间的列值，把多行分配给分区
        + LIST：类似于按RANGE分区，区别在于LIST分区是基于列值匹配一个离散值集合中的某个值来进行选择
        + HASH：基于用户定义的表达式的返回值来进行选择的分区，该表达式使用将要插入到表中的这些行的列值进行计算。这个函数可以包含MySQL中有效的、产生非负整数值的任何表达式
        + KEY：类似于按HASH分区，区别在于KEY分区只支持计算一列或多列，且MySQL服务器提供其自身的哈希函数。必须有一列或多列包含整数值
    - 优点
        + 存储更多数据。分区表的数据可以分布在不同的物理设备上，从而高效地利用多个硬件设备。和单个磁盘或者文件系统相比，可以存储更多数据
        + 优化查询。在where语句中包含分区条件时，可以只扫描一个或多个分区表来提高查询效率；涉及sum和count语句时，也可以在多个分区上并行处理，最后汇总结果
        + 分区表更容易维护。例如：想批量删除大量数据可以清除整个分区
        + 避免某些特殊的瓶颈，例如InnoDB的单个索引的互斥访问，ext3问价你系统的inode锁竞争等
    - 限制
        + 一个表最多只能有1024个分区
        + MySQL5.1中，分区表达式必须是整数，或者返回整数的表达式。在MySQL5.5中提供了非整数表达式分区的支持
        + 如果分区字段中有主键或者唯一索引的列，那么多有主键列和唯一索引列都必须包含进来。即：分区字段要么不包含主键或者索引列，要么包含全部主键和索引列
        + 分区表中无法使用外键约束
        + MySQL的分区适用于一个表的所有数据和索引，不能只对表数据分区而不对索引分区，也不能只对索引分区而不对表分区，也不能只对表的一部分数据分区
    - 配置 `show variables like '%partition%'` have_partintioning 的值为YES，表示支持分区
* 分表与分区区别：分区从逻辑上来讲只有一张表，分表则是将一张表分解成多张表
* 分库分表
    - 水平拆分:以字段为依据，按照一定策略（hash、range等），将一个库（表）中的数据拆分到多个库（表）中
        + 每个库（表）结构都一样
        + 每个库（表）数据都不一样，没有交集
        + 所有库（表）并集是全量数据
        + 水平分表场景：系统绝对并发量并没有上来，只是单表的数据量太多，影响了SQL效率，加重了CPU负担，以至于成为瓶颈 => 表的数据量少了，单次SQL执行效率高，自然减轻了CPU的负担
        + 水平分库场景：系统绝对并发量上来了，分表难以根本上解决问题，并且还没有明显的业务归属来垂直分库 => 库多了，io和cpu的压力自然可以成倍缓解
    - 垂直拆分：按照业务类型对存放在一个数据库中的表进行分类变成几张表的方法，降低表的复杂度和字段的数目
        + 垂直分库:以表为依据，按照业务归属不同，将不同的表拆分到不同的库中
            * 场景:系统绝对并发量上来了，并且可以抽象出单独的业务模块,可以服务化了
        + 垂直分表:以字段为依据，按照字段的活跃性，将表中字段拆到不同的表（主表和扩展表）中
            * 场景：系统绝对并发量并没有上来，表的记录并不多，但是字段多，并且热点数据和非热点数据在一起，单行数据所需的存储空间较大。以至于数据库缓存的数据行减少，查询时会去读磁盘数据产生大量的随机读IO，产生IO瓶颈
            * 将热点数据（可能会冗余经常一起查询的数据）放在一起作为主表，非热点数据放在一起作为扩展表
            * 千万别用join：join不仅会增加CPU负担并且会讲两个表耦合在一起（必须在一个数据库实例上）。关联数据，应该在业务Service层做文章，分别获取主表和扩展表数据然后用关联字段关联得到全部数据
        + 每个库（表）的结构都不一样
        + 每个库（表）的数据也不一样，没有交集;每个表的字段至少有一列交集，一般是主键，用于关联数据
        + 所有库（表）的并集是全量数据
    - 方法
        + 根据容量（当前容量和增长量）评估分库或分表个数 -> 选key（均匀）-> 分表规则（hash或range等）-> 执行（一般双写）-> 扩容问题（尽量减少数据的移动）
        + 比较常规的思路就是按照用户 ID 进行取模。而至于为什么是用户 ID，主要是为了避免同一个用户跨表查询，但是这样子做有一个问题就是扩容的时候所有数据需要重新分表，这个跟分布式缓存扩容是一样的问题
        + 基于范围，比如用户 ID 范围，但是这样可能会有分布不均导致的热点问题；再有就是基于省份、地区，这在系统存在多个数据中心时可以作为一种切分方案，并且对不同地区设计不同的容量和集群
        + 垂直拆分相对简单，需要先对系统业务进行分类，一般系统模块很好划分，比如用户、商品、交易、售后等，然后把相关表都拆分到对应子系统中，一般来说，垂直拆分可以伴随着服务拆分（微服务、服务化）改造同步进行，这样每一个服务子系统访问对应的子库即可，这样也有利于权责划分，商品系统没有访问用户系统数据库的权限，只能通过用户服务提供的接口对数据进行访问和修改。在代码层面我们需要做好数据库事务和跨库 join 代码的改造。
        + 水平拆分相对复杂，需要先规划好切分维度，比如范围、时间、取模、哈希等，然后一般规划拆分后单表数据在1000万以内，比如我们对一个预计容量在1亿的表进行水平拆分，按照对主键 ID 取模的维度分表，可以通过 ID % 10 去指定表查询数据，对于唯一主键不能再通过数据库自增的 ID 来解决，可以借助 UUID 之类的解决方案，对于聚合查询和分页查询，也要做限制，比如用户只能看多少页数据，或者必须按照切分维度进行查询，一定要排除全表扫描的可能，分库的话设计到数据库事务和跨库 join 的代码也要调整，比如我之前的公司不再使用数据库事务并在代码中杜绝使用 join 查询。
        + 具体实践中，可以借助数据库中间件来做分库分表，比如 Cobar 等，但是一定建立在对分库分表底层的东西非常熟悉，否则一旦出现问题，那是灾难性的
    - 问题：都是为了提高数据库负载和并发处理能力，但是也增加了系统的复杂度，垂直拆分还要好一些，尤其是水平拆分，如何拆分，拆分后如何查询
        + 非partition key的查询问题
            * 只有非partition key作为条件查询
                + 映射法：做一个 非partition key 与 partition key 的映射表
                    * 索引覆盖查询
                    * 分布式缓存映射比表更快，不要被穿透
                + 基因法：根据user_name查询时，先通过user_name_code生成函数生成user_name_code再对其取模路由到对应的分库或分表。id生成常用snowflake算法
                    * 写入时，基因法生成user_id。关于xbit基因，例如要分8张表，2^3=8，故x取3，即3bit基因。根据user_id查询时可直接取模路由到对应的分库或分表
            * 除了partition key不止一个非partition key作为条件查询
                + 冗余法：按照order_id或buyer_id查询时路由到db_o_buyer库中，按照seller_id查询时路由到db_o_seller库中
                + 映射法:多字段映射
        + 非partition key跨库跨表分页查询问题
        + 扩容
            * 水平扩容库（升级从库法）
            * 扩容是成倍的
            * 水平扩容表（双写迁移法）
                - （同步双写）修改应用配置和代码，加上双写，部署
                - （同步双写）将老库中的老数据复制到新库中
                - （同步双写）以老库为准校对新库中的老数据
                - （同步双写）修改应用配置和代码，去掉双写，部署
        + 共同问题
            * 分布式事务一致性如何解决
            * 跨库 join 查询如何处理
            * 分库分表后数据的扩展和维护难度增加
        + 水平拆分，还有一些更加棘手的问题
            * 主键 ID 唯一性在分布式数据表中如何保证
            * 数据拆分到不同表中聚合查询如何做
            * 垂直拆分遇到瓶颈还可以考虑水平拆分，水平拆分再度遇到瓶颈如何对数据进行扩容？
        + 这些问题都是需要在拆分前考虑好对应解决方案的。这些问题处理起来都不简单，所以数据库拆分一定要慎重，而不是一拍脑门下决定，它应该放到 SQL 语句优化、表结构优化（索引、分表）、引入缓存系统、读写分离之后，并且再细分的话，把水平拆分放到垂直拆分之后，因为它最复杂。
    - 场景
        + 单表行数超过 500 万行或者单表容量超过 2GB，导致内存限制
            * MySQL 为了提高性能，会将表的索引装载到内存中。InnoDB buffer size 足够的情况下，其能完成全加载进内存，查询不会有问题
            * 单表数据库到达某个量级的上限时，导致内存无法存储其索引，使得之后的 SQL 查询会产生磁盘 IO，从而导致性能下降
        + 不应该滥用分库分表,如果预计三年后的数据量根本达不到这个级别，请不要在创建表时就分库分表
        + 会遇到单体瓶颈，比如库存表，每次交易、下单、秒杀都会涉及到频繁修改库存表，当业务到达一定级别，可能导致库存表单体性能瓶颈，这个时候需要对其进行水平拆分
* 工具
    - sharding-sphere:前身是sharding-jdbc
    - TDDL(Taobao Distribute Data Layer)
    - Mycat：中间件
    - [vitessio / vitess](https://github.com/vitessio/vitess):Vitess is a database clustering system for horizontal scaling of MySQL. http://vitess.io

```sql
use ecommerce;
CREATE TABLE employees (
  id INT NOT NULL,
  fname VARCHAR(30),
  lname VARCHAR(30),
  birth TIMESTAMP,
  hired DATE NOT NULL DEFAULT '1970-01-01',
  separated DATE NOT NULL DEFAULT '9999-12-31',
  job_code INT NOT NULL,
  store_id INT NOT NULL
  )
  partition BY RANGE (store_id) (
      partition p0 VALUES LESS THAN (10000),
      partition p1 VALUES LESS THAN (50000),
      partition p2 VALUES LESS THAN (100000),
      partition p3 VALUES LESS THAN (150000),
      Partition p4 VALUES LESS THAN MAXVALUE
  );
```

## SQL编程

* 用户自定义变量在变量名前使用@作为开始符号
* 退出循环
    - 退出整个循环 leave
    - 退出当前循环 iterate
    - 通过退出的标签决定退出哪个循环

```sql
declare var_name[,...] type [default value]  # 局部变量声明
set @var = value; # 全局变量
select @var:=20;
select * from tbl_name where @var:=30;

# 控制结构
if search_condition then
    statement_list
[elseif search_condition then
    statement_list]
...
[else
    statement_list]
end if;

# case语句
CASE value WHEN [compare-value] THEN result
[WHEN [compare-value] THEN result ...]
[ELSE result]
END

# while循环
[begin_label:] while search_condition do
    statement_list
end while [end_label];
```

## 函数

* 数值函数
    - abs(x)            -- 绝对值 abs(-10.9) = 10
    - format(x, d)    -- 格式化千分位数值 format(1234567.456, 2) = 1,234,567.46
    - ceil(x)            -- 向上取整 ceil(10.1) = 11
    - floor(x)        -- 向下取整 floor (10.1) = 10
    - round(x)        -- 四舍五入去整
    - mod(m, n)        -- m%n m mod n 求余 10%3=1
    - pi()            -- 获得圆周率
    - pow(m, n)        -- m^n
    - sqrt(x)            -- 算术平方根
    - rand()            -- 随机数
    - truncate(x, d)    -- 截取d位小数
* 时间日期函数
    - now(), current_timestamp();     -- 当前日期时间
    - current_date();                    -- 当前日期
    - current_time();                    -- 当前时间
    - date('yyyy-mm-dd hh:ii:ss');    -- 获取日期部分
    - time('yyyy-mm-dd hh:ii:ss');    -- 获取时间部分
    - date_format('yyyy-mm-dd hh:ii:ss', '%d %y %a %d %m %b %j');    -- 格式化时间
    - unix_timestamp();                -- 获得unix时间戳
    - from_unixtime();                -- 从时间戳获得时间
* 字符串函数
    - length(string)            -- string长度，字节
    - char_length(string)        -- string的字符个数
    - substring(str, position [,length])        -- 从str的position开始,取length个字符
    - replace(str ,search_str ,replace_str)    -- 在str中用replace_str替换search_str
    - instr(string ,substring)    -- 返回substring首次在string中出现的位置
    - concat(string [,...])    -- 连接字串
    - charset(str)            -- 返回字串字符集
    - lcase(string)            -- 转换成小写
    - left(string, length)    -- 从string2中的左边起取length个字符
    - load_file(file_name)    -- 从文件读取内容
    - locate(substring, string [,start_position])    -- 同instr,但可指定开始位置
    - lpad(string, length, pad)    -- 重复用pad加在string开头,直到字串长度为length
    - ltrim(string)            -- 去除前端空格
    - repeat(string, count)    -- 重复count次
    - rpad(string, length, pad)    --在str后用pad补充,直到长度为length
    - rtrim(string)            -- 去除后端空格
    - strcmp(string1 ,string2)    -- 逐字符比较两字串大小
    - left()
    - right()
* 流程函数
    - case when [condition] then result [when [condition] then result ...] [else result] end   多分支
    - if(expr1,expr2,expr3)  双分支。
* 聚合函数
    - count()
        + SELECT COUNT(country)：如果有NULL值，在返回的结果中会被过滤掉
        + SELECT COUNT(*):会返回所有数据的数量，不会过滤其中的NULL值
        + count(distinct …)会返回彼此不同但是非NULL的数据的行数
    - sum();
    - max();
    - min();
    - avg();
    - group_concat()
* 其他常用函数
    - md5();
    - default();

```sql
set @currenttime=(select UNIX_TIMESTAMP(current_timestamp()));
```

## ShardingJDBC

* 切入层次
* 拆分流程
* 数据同步
* 不停机切换
* HA & FailOVer

## [10万连接](https://mp.weixin.qq.com/s?__biz=MzAwNzA5MzA0NQ==&mid=2652150991&idx=1&sn=d6df2a44544d61b5255d0cb5e4c97d12&chksm=80e35295b794db833fd4408a3d34096c66efdca5c4054a8e741b2ce3a759bde2b4875e164a10)

* Percona Server的线程池
* 正确的网络设置
* 为MySQL服务器配置多个IP地址（每个IP限制65535个连接）

```
[mysqld]
datadir {{ mysqldir }}
ssl=0
skip-log-bin
log-error=error.log
# Disabling symbolic-links is recommended to prevent assorted security risks
symbolic-links=0
character_set_server=latin1
collation_server=latin1_swedish_ci
skip-character-set-client-handshake
innodb_undo_log_truncate=off
# general
table_open_cache = 200000
table_open_cache_instances=64
back_log=3500
max_connections=110000
# files
innodb_file_per_table
innodb_log_file_size=15G
innodb_log_files_in_group=2
innodb_open_files=4000
# buffers
innodb_buffer_pool_size= 40G
innodb_buffer_pool_instances=8
innodb_log_buffer_size=64M
# tune
innodb_doublewrite= 1
innodb_thread_concurrency=0
innodb_flush_log_at_trx_commit= 0
innodb_flush_method=O_DIRECT_NO_FSYNC
innodb_max_dirty_pages_pct=90
innodb_max_dirty_pages_pct_lwm=10
innodb_lru_scan_depth=2048
innodb_page_cleaners=4
join_buffer_size=256K
sort_buffer_size=256K
innodb_use_native_aio=1
innodb_stats_persistent = 1
#innodb_spin_wait_delay=96
innodb_adaptive_flushing = 1
innodb_flush_neighbors = 0
innodb_read_io_threads = 16
innodb_write_io_threads = 16
innodb_io_capacity=1500
innodb_io_capacity_max=2500
innodb_purge_threads=4
innodb_adaptive_hash_index=0
max_prepared_stmt_count=1000000
innodb_monitor_enable = '%'
performance_schema = ON
```

## mysqladmin


## 压力测试工具 mysqlslap

Mysql 自带的压力测试工具，可以模拟出大量客户端同时操作数据库的情况，通过结果信息来了解数据库的性能状况。一个主要工作场景就是对数据库服务器做基准测试

```sh
mysqlslap –user=root –password=111111 –auto-generate-sql # 自动生成测试SQL
mysqlslap –user=root –password=111111 –concurrency=100 –number-of-queries=1000 –auto-generate-sql # 添加并发 客户端连接 总查询次数
mysqlslap –user=root –password=111111 –concurrency=50 –number-int-cols=5 –number-char-cols=20 –auto-generate-sql # 自动生成复杂表
mysqlslap –user=root –password=111111 –concurrency=50 –create-schema=employees –query="SELECT _FROM dept_emp;" # 使用自己的测试库和测试语句 `echo "SELECT_ FROM employees;SELECT _FROM titles;SELECT_ FROM dept_emp;SELECT _FROM dept_manager;SELECT_ FROM departments;" > ~/select_query.sql`
```

## 监控平台

* 安装 
    - 安装exporter
    - 配置prometheusgranafa
* 指标
    - 主从复制线程监控： show slave status\G  Slave_IO_Running、Slave_SQL_Running  mysql_slave_status_slave_sql_running{channel_name="",connection_name="",master_host="172.16.1.1",master_uuid=""} 1
    - 主从复制落后时间： show slave status 里面还有一个关键的参数Seconds_Behind_Master：表示slave上SQL thread与IO thread之间的延迟，表示本地relaylog中未被执行完的那部分的差值 mysql_slave_status_seconds_behind_master
    - 吞吐量：MySQL 有一个名为 Questions 的内部计数器，客户端每发送一个查询语句，其值就会加一。由 Questions 指标带来的以客户端为中心的视角常常比相关的Queries 计数器更容易解释 SHOW GLOBAL STATUS LIKE "Questions"; mysql_global_status_questions

```sh
wget https://github.com/prometheus/mysqld_exporter/releases/download/v0.10.0/mysqld_exporter-0.10.0.linux-amd64.tar.gz
tar -xf mysqld_exporter-0.10.0.linux-amd64.tar.gz

GRANT SELECT, PROCESS, SUPER, REPLICATION CLIENT, RELOAD ON *.* TO 'exporter'@'%' IDENTIFIED BY 'localhost';
flush privileges;

# /opt/mysqld_exporter-0.10.0.linux-amd64/.my.cnf
[client]
user=exporter
password=123456

# /etc/systemd/system/mysql_exporter.service
[Unit]
Description=mysql Monitoring System
Documentation=mysql Monitoring System

[Service]
ExecStart=/opt/mysqld_exporter-0.10.0.linux-amd64/mysqld_exporter \
         -collect.info_schema.processlist \
         -collect.info_schema.innodb_tablespaces \
         -collect.info_schema.innodb_metrics  \
         -collect.perf_schema.tableiowaits \
         -collect.perf_schema.indexiowaits \
         -collect.perf_schema.tablelocks \
         -collect.engine_innodb_status \
         -collect.perf_schema.file_events \
         -collect.info_schema.processlist \
         -collect.binlog_size \
         -collect.info_schema.clientstats \
         -collect.perf_schema.eventswaits \
         -config.my-cnf=/opt/mysqld_exporter-0.10.0.linux-amd64/.my.cnf

[Install]
WantedBy=multi-user.target

# prometheus server
  - job_name: 'mysql'
    static_configs:
     - targets: ['192.168.1.11:9104','192.168.1.12:9104']
# http://192.168.1.12:9104/metrics
```


## 维护

* 通常地，单表物理大小不超过10GB，单表行数不超过1亿条，行平均长度不超过8KB，如果机器性能足够，这些数据量MySQL是完全能处理的过来的，不用担心性能问题，这么建议主要是考虑ONLINE DDL的代价较高；
* 不用太担心mysqld进程占用太多内存，只要不发生OOM kill和用到大量的SWAP都还好；
* 在以往，单机上跑多实例的目的是能最大化利用计算资源，如果单实例已经能耗尽大部分计算资源的话，就没必要再跑多实例了；
* 定期使用pt-duplicate-key-checker检查并删除重复的索引。定期使用pt-index-usage工具检查并删除使用频率很低的索引；
* 定期采集slow query log，用pt-query-digest工具进行分析，可结合Anemometer系统进行slow query管理以便分析slow query并进行后续优化工作；
* 可使用pt-kill杀掉超长时间的SQL请求，Percona版本中有个选项 innodb_kill_idle_transaction 也可实现该功能；
* 使用pt-online-schema-change来完成大表的ONLINE DDL需求；
* 定期使用pt-table-checksum、pt-table-sync来检查并修复mysql主从复制的数据差异；

## 备份

* 语法
    - 生成的数据默认的分隔符是制表符
    - local未指定，则数据文件必须在服务器上
    - replace 和 ignore 关键词控制对现有的唯一键记录的重复的处理
    - 控制格式
        + fields    控制字段格式
            * 默认：fields terminated by '\t' enclosed by '' escaped by '\\'
            * terminated by 'string'    -- 终止
            * enclosed by 'char'        -- 包裹
            * escaped by 'char'        -- 转义
        + lines    控制行格式
            * 默认：lines terminated by '\n'
            * terminated by 'string'    -- 终止
* 备份策略：每天做一次增量备份，每周做一次全量备份，通过定时任务做
* 在二级复制服务器上进行备份
* 备份过程中停止数据的复制，以防止出现数据依赖和外键约束的不一致
* 彻底停止MySQL之后，再从数据文件进行备份
* 如果使用MySQL dump进行备份，请同时备份二进制日志 — 确保复制过程不被中断
* 不要信任 LVM 快照的备份 — 可能会创建不一致的数据，将来会因此产生问题
* 为每个表做一个备份，这样更容易实现单表的恢复 — 如果数据与其他表是相互独立的
* 使用 mysqldump 时，指定 -opt 参数
* 备份前检测和优化表
* 临时禁用外键约束，来提高导入的速度
* 临时禁用唯一性检查，来提高导入的速度
* 每次备份完后，计算数据库/表数据和索引的大小，监控其增长
* 使用定时任务（cron）脚本，来监控从库复制的错误和延迟
* 定期备份数据
* 定期测试备份的数据
* mysqlcheck

```sh
select * into outfile 文件地址 [控制格式] from 表名;   # 导出表数据
SELECT a,b,a+b INTO OUTFILE '/tmp/result.text' FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n' FROM test_table;
load data [local] infile 文件地址 [replace|ignore] into table 表名 [控制格式]; # 导入数据

mysqldump [-h 主机名] -u 用户名 -p --all-databases > dump.sql
mysqldump [-h 主机名] -u 用户名 -p --databases 库名1 [库名2 ...] > dump.sql
mysqldump [-h 主机名] -u 用户名 -p 库名 表名1 [表名2 ...] > dump.sql

mysqldump -u wcnc -p -d –add-drop-table smgp_apps_wcnc >d:wcnc_db.sql # 导出数据结构
mysqldump -uroot -p test > /download/testbak_$(date +%F).sql
mysqldump -uroot -p -B test mysql|gzip >/download/testbak_$(date +%F).sql.gz # 导出并压缩

# 全量备份
/usr/bin/mysqldump -uroot -p123456  --lock-all-tables --flush-logs test > /home/backup.sql # 参数 —flush-logs：使用一个新的日志文件来记录接下来的日志； —lock-all-tables：锁定所有数据库;

# 恢复全量备份
mysql -uroot -p < dump.sql # 不登录
source  dump.sql # 登录

## 增量备份
# 查看 log_bin 是否开启，因为要做增量备份要开启 log_bin
show variables like '%log_bin%';
# 修改配置文件，重启mysql服务，保证 sql_log_bin 开启
#/etc/mysql/mysql.conf.d/mysqld.cnf
log-bin=/var/lib/mysql/mysql-bin
server-id=123454

# 查看当前使用的 mysql_bin.000*** 日志文件
show master status;
# 添加数据
insert into `zone`.`users` ( `name`, `sex`, `id`) values ( 'zone3', '0', '4');

# 使用新的日志文件
mysqladmin -uroot -123456 flush-logs
# 将刚刚插入的数据删除
# 恢复
mysqlbinlog /var/lib/mysql/mysql-bin.000015 | mysql -uroot -p123456 zone;
```

## MySQL optimize

* 找出系统的瓶颈,提高MySQL数据库的整体性能
* 合理的结构设计和参数调整,以提高用户的相应速度,同时还要尽可能的节约系统资源,以便让系统提供更大的负荷
* 不同的语句，根据选择的引擎、表中数据的分布情况、索引情况、数据库优化策略、查询中的锁策略等因素，最终查询的效率相差很大
* 不要听信看到的关于优化的“绝对真理”，而应该是在实际的业务场景下通过测试来验证关于执行计划以及响应时间的假设
* 软优化一般是操作数据库即可
* 硬优化则是操作服务器硬件及参数设置
    - CPU——Cache(L1-L2-L3)——内存——SSD硬盘——网络——硬盘

## 指标

* 响应时间:包括服务时间和等待时间，这两个时间并不能细分出来，所以响应时间受影响比较大。可以通过估计查询的响应时间来做最初步的判断
* 返回行数
* 延时（响应时间）：硬件的突发处理能力
* 带宽（吞吐量）：硬件持续处理能力
    - QPS（Queries Per Second，每秒查询书）
    - TPS（Transactions Per Second）
* 法则
    - 减少数据访问（减少磁盘访问）
    - 返回更少数据（减少网络传输或磁盘访问）
    - 减少交互次数（减少网络传输）
    - 减少服务器CPU开销（减少CPU及内存开销）
    - 利用更多资源（增加资源）
* 低效原因
    - 硬件问题:如网络速度慢，内存不足，I/O吞吐量小，磁盘空间满了等
    - 检索大量不需要的数据,MySQL服务层在分析大量超过需要的数据行
        + 查询不需要的记录：一个常见的错误是误以为MySQL会只返回需要的数据，实际上MySQL是先返回全部结果集再进行运算。 加limit，需要字段
        + 返回多余的列：取出全部列，会让优化器无法完成索引覆盖扫描这类优化，而且给服务器带来额外的I/O，内存，CPU的消耗。
        + 重复数据：如用户头像需多次取出，此时应将数据缓存起来
    - 没有索引或者索引失效:（一般在互联网公司，DBA会在半夜把表锁了，重新建立一遍索引，因为当你删除某个数据的时候，索引的树结构就不完整了。所以互联网公司的数据做的是假删除.一是为了做数据分析,二是为了不破坏索引 ）
    - 数据过多（分库分表）
    - 服务器调优及各个参数设置（调整my.cnf）
    - 瓶颈
        + CPU在饱和的时候一般发生在数据装入内存或从磁盘上读取数据时候。
        + 磁盘I/O瓶颈发生在装入数据远大于内存容量的时候
        + 如果应用分布在网络上，那么查询量相当大的时候那么平瓶颈就会出现在网络上，我们可以用mpstat, iostat, sar和vmstat来查看系统的性能状态
* EXPLAIN：分析SQL语句的执行情况，索引使用、扫描范围
    - select_type:表示查询的类型
        + SIMPLE： 简单查询:不包含 UNION 查询或子查询
        + PRIMARY： 主查询，或者是最外面的查询语句
        + SUBQUERY： 子查询中的第一个
        + UNION： 表示此查询是 UNION 的第二或后面的查询语句
        + DEPENDENT UNION： UNION 中的第二个或后面的查询语句, 取决于外面的查询
        + UNION RESULT, UNION 的结果
        + DEPENDENT SUBQUERY: 子查询中的第一个 SELECT, 取决于外面的查询. 即子查询依赖于外层查询的结果.
        + DERIVED：衍生，表示导出表的SELECT（FROM子句的子查询）
    - table:查询的表
    - type:在表中找到所需行的方式，或者叫访问类型. 从下到上，性能越来越差
        + system,const：只有一行记录,可以将查询的变量转为常量. 如id=1; id为 主键或唯一键
        + const: 针对主键或唯一索引的等值查询扫描，最多只返回一行数据。 const 查询速度非常快， 因为它仅仅读取一次即可。例如下面的这个查询，它使用了主键索引，因此 type 就是 const 类型的：explain select * from user_info where id = 2；
        + eq_ref：唯一性索引扫描，对于每个索引键，表中只有一条记录与之匹配,此类型通常出现在多表的 join 查询，表示对于前表的每一个结果，都只能匹配到后表的一行结果。并且查询的比较操作通常是 =，查询效率较高.(通常在联接时出现，查询使用的索引为主键或惟一键)
        + ref：非唯一性索引扫描，返回匹配某个单独值的所有行，本质上也是一种索引访问，它返回所有匹配某个单独值的行，然而，它可能会找到多个符合条件的行，属于查找和扫描的混合体。
        + range：检索给定范围的行，使用一个索引来选择行，key列显示使用了哪个索引
            * 范围扫描索引比全表扫描要好，因为它只需要开始于索引的某一点，而结束于另一点，不用扫描全部索引
        + index 全索引扫描(full index scan):只遍历索引树. 优点：比ALL快、不用排序,缺点是还要全表扫描
        + ALL：全表扫描，从内存读取整张表，增加I/O的速度并在CPU上加载
    - possible_keys:表示查询时，可能使用的索引
    - key:表示实际使用的索引
    - key_len:表示查询优化器使用了索引的字节数，这个字段可以评估组合索引是否完全被使用
    - ref:这个表示显示索引的哪一列被使用了，如果可能的话,是一个常量
    - rows:扫描行数
    - Extra:执行情况的描述和说明
        + using index：使用了覆盖索引，避免访问了表的数据行，效率不错
        + 同时出现using where，表明索引被用来执行索引键值的查找；没有出现using where，表明索引用来读取数据而非执行查找动作
        + using tmporary：用到临时表
        + using filesort：对数据使用一个外部的索引排序，而不是按照表内的索引顺序进行读取. (当使用order by v1,而没用到索引时,就会使用额外的排序)
        + range checked for eache record(index map:N)：没有好的索引
* SHOW:查看MySQL状态及变量
* PROCEDURE ANALYSE() 分析字段和其实际的数据，并会给一些有用的建议。只有表中有实际的数据，这些建议才会变得有用，因为要做一些大的决定是需要有数据作为基础的
* 慢查询:知道哪些SQL语句执行效率低下,mysql支持把慢查询语句记录到日志文件中.用来记录在MySQL中响应时间超过阀值的语句，具体指运行时间超过long_query_time值的SQL，则会被记录到慢查询日志中。long_query_time的默认值为10，意思是运行10s以上的语句
    - 官方自带工具： mysqldumpslow
    - 开源工具：mysqlsla
    - percona-toolkit：工具包中的pt-query-digest工具可以分析汇总慢查询信息，具体逻辑可以看SlowLogParser这个函数
    - 接删除慢日志文件，执行flush logs（必须的）
    - 备份：先用mv重命名文件（不要跨分区），然后执行flush logs（必须的）
* profiling:准确的SQL执行消耗系统资源的信息
* DESCRIBE：可以放在SELECT, INSERT, UPDATE, REPLACE 和 DELETE语句前边使用

![优化策略](../_static/index.jpeg "Optional title")

```sql
show global status like 'Questions';
show global status like 'Uptime'; # QPS = Questions / Uptime

show global status like 'Com_commit';
show global status like 'Com_rollback';
show global status like 'Uptime'; # TPS = (Com_commit + Com_rollback) / Uptime

vmstat 1 3 #  pay attentin to cpu
iostat -d -k 1 3

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

## 优化

* 效果：SQL及索引 > 数据库表结构 > 系统配置 > 硬件，成本相反
* 优先考虑通过缓存降低对数据库的读操作（如：redis）
* 考虑读写分离，降低数据库写操作
* 开始数据拆分
    - 首先考虑按照业务垂直拆分
    - 再考虑水平拆分：先分库（设置数据路由规则，把数据分配到不同的库中）
    - 最后再考虑分表，单表拆分到数据1000万以内
* 开启查询缓存
* 当只要一行数据时使用limit 1，MySQL数据库引擎会在找到一条数据后停止搜索，而不是继续往后查少下一条符合记录的数据
* 为搜索字段建索引
* Prepared StatementsPrepared Statements很像存储过程，是一种运行在后台的SQL语句集合，我们可以从使用 prepared statements 获得很多好处，无论是性能问题还是安全问题。
* Prepared Statements 可以检查一些绑定好的变量，这样可以保护程序不会受到“SQL注入式”攻击

```
top 查看进程消耗
threads_running/QPS/TPS
MySQL profile工具
orzdba
msyqladmin                                 mysql客户端，可进行管理操作
mysqlshow                                  功能强大的查看shell命令
show [SESSION | GLOBAL] variables          查看数据库参数信息
SHOW [SESSION | GLOBAL] STATUS             查看数据库的状态信息
information_schema                         获取元数据的方法
SHOW ENGINE INNODB STATUS                  Innodb引擎的所有状态
SHOW PROCESSLIST                           查看当前所有连接session状态
explain                                    获取查询语句的执行计划
show index                                 查看表的索引信息
slow-log                                   记录慢查询语句,
mysqldumpslow                              分析slowlog文件的
zabbix                  监控主机、系统、数据库（部署zabbix监控平台）
pt-query-digest         分析慢日志
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
[client]
socket = /var/lib/mysql/mysql.sock
port = 3306

[mysqld]
# GENERAL
datadir = /var/lib/mysql
socket = /var/lib/mysql/mysql.sock
pid_file = /var/lib/mysql/mysql.pid
user = mysql
port = 3306

# INNODB
innodb_buffer_pool_size = <value>
innodb_log_file_size = <value>
innodb_file_per_table = 1

# LOGGING
slow_query_log = ON
slow_query_log = /var/lib/mysql/mysql-slow.log
log_error = /var/lib/mysql/mysql-error.log

# OTHER
tmp_table_size = 32M
max_heap_table_size = 32M
# 禁用缓存
query_cache_type = 0
query_cache_size = 0
max_connections = <value>
thread_cache_size = <value>
open_files_limit = 65535

pager grep Log
show engine innodb status\G select sleep(60); show engine innodb status\G;
```

![InnoDB-cache 缓存与文件](../_static/InnoDB-cache.jpg "Optional title")

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
    - 禁止使用ENUM，可使用TINYINT代替
        + 缺点是枚举的字符串列表是固定的:添加和删除字符串（枚举选项）必须使用 ALTER TABLE（如果只是在列表末尾追加元素，不需要重建表）
        + ENUM的内部实际存储就是整数(保存的是 TINYINT),但其外表上显示为字符串。如果有一个字段，比如“性别”，“国家”，“民族”，“状态”或“部门”，知道这些字段的取值是有限而且固定的，那么应该使用 ENUM 而不是 VARCHAR
        + 使用ENUM、CHAR 而不是VARCHAR，使用合理的字段属性长度
        + ENUM和SET类型 对于标识列来说，EMUM和SET类型通常是一个糟糕的选择， 尽管对某些只包含固定状态或者类型的静态 "定义表" 来说可能是没有问题的
        * ENUM和SET列适合存储固定信息， 例如有序的状态、 产品类型、 人的性别
    + 对千完全 "随机" 的字符串也需要多加注意， 例如 MDS() 、 SHAl() 或者 UUID() 产生的字符串。 这些函数生成的新值会任意分布在很大的空间内， 这会导致 INSERT 以及一些SELECT语句变得很慢
    + 如果存储 UUID 值， 则应该移除 "-"符号
    + 特殊类型数据 某些类型的数据井不直接与内置类型一致
        * 低千秒级精度的时间戳
        * 整型来存IPv4地址:实际上是32位无符号整数，不是字符串。用小数点将地址分成四段的表示方法只是为了让人们阅读容易。所以应该用无符号整数存储IP地址。MySQL提供INET_ATON()和INET_NTOA()函数在这两种表示方法之间转换
* 分离频繁更新和频繁读取的数据，新增字段时分析使用链接表还是扩展行
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
* 使用 ENUM 而不是 VARCHAR。如果有一个字段，比如“性别”，“国家”，“民族”，“状态”或“部门”，你知道这些字段的取值是有限而且固定的，那么，你应该使用 ENUM 而不是VARCHAR

### 查询优化

对查询进行优化，要尽量避免全表扫描

* 查询语句优化：用EXPLAIN或DESCRIBE(简写:DESC)命令分析一条查询语句的执行信息，分析查询语句或是表结构的性能瓶颈。EXPLAIN 的查询结果会说明索引主键被如何利用的，数据表是如何被搜索和排序
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
* 有时，MySQL 会选择错误的索引，这种情况使用 USE INDEX
* 使用 SQL_MODE=STRICT 来检查问题
* 索引字段少于5个时，UNION 操作用 LIMIT，而不是 OR
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
    - 子查询的效率不如连接查询（join）:因为MySQL不需要在内存中创建临时表来完成这个在逻辑上需要两个步骤的查询工作
* 对 UPDATE 来说，使用 SHARE MODE 来防止排他锁
* 重启 MySQL 时，记得预热数据库，确保将数据加载到内存，提高查询效率
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
    - 禁止使用`SELECT *`，只获取必要的字段，避免产生严重的随机读问题,读取不需要的列会增加CPU、IO、NET消耗,不能有效的利用覆盖索引
    - 限制工作数据集的大小：查询语句带有子查询时，注意在子查询的内部语句上使用过滤
    - 尽量避免向客户端返回大数据量，若数据量过大，应该考虑相应需求是否合理
    - 只要一行数据时使用 `LIMIT 1`，找到一条数据后停止搜索，而不是继续往后查少下一条符合记录的数据
    * `select *` 和 `select 字段` 区别
        + 如果某些不需要的字段数据量特别大，还是写清楚字段比较好，因为这样可以减少网络传输。
        + index coverage：有一个常用查询，只需要用到表中的某两列，user_id和post_id，而且有一个多列索引已经覆盖了这两个列，那么这个索引就是这个查询的覆盖索引了。可以不用读data，直接使用index里面的值就返回结果的。但是一旦用了select*，就会有其他列需要读取，这时在读完index以后还需要去读data才会返回结果。
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
        + `LIMIT M,N`:全表扫描,速度会很慢且结果集返回不稳定,`LIMIT 10000，20` 需要查询10020条记录然后只返回20条记录，前面的10000条都将被抛弃，这样的代价非常高
        + 避免使用 OFFSET `SELECT id FROM t WHERE id > 10000 LIMIT 10 ;`
        + `WHERE id_pk > (pageNum*10) ORDER BY id_pk ASC LIMIT M`:ORDER BY后的列对象是主键或唯一所以,使得ORDERBY操作能利用索引被消除但结果集是稳定的
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
    - 区分in和exists， not in和not exists，造成了驱动顺序的改变
        + exists，那么以外层表为驱动表，先被访问，如果是IN，那么先执行子查询。所以IN适合于外表大而内表小的情况；EXISTS适合于外表小而内表大的情况。
        + 关于not in和not exists，推荐使用not exists，不仅仅是效率问题，not in可能存在逻辑问题。如何高效的写出一个替代not exists的sql语句？
    - 对于 IN 做了相应的优化，即将 IN 中的常量全部存储在一个数组里面，而且这个数组是排好序的。 对于连续的数值，能用 between 就不要用 in 了
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
* 排序
    - 如果排序字段没有用到索引，就尽量少排序
    - 如果限制条件中其他字段没有索引，尽量少用 or，有一个不是索引字段，会造成该查询不走索引的情况。 使用 union all 或者是 union(必要的时候)的方式来代替“or”会得到更好的效果
    - 不使用ORDER BY RAND()
* 拒绝3B(big)：大sql，大事务，大批量
* 子查询：尽量使用JOIN来代替子查询.因为子查询需要嵌套查询,嵌套查询时会建立一张临时表,临时表的建立和删除都会有较大的系统开销,而连接查询不会创建临时表,因此效率比嵌套子查询高
    - union 和 union all 的差异：前者需要将结果集合并后再进行唯一性过滤操作，这就会涉及到排序，增加大量的 CPU 运算，加大资源消耗及延迟。
    - 禁止大表使用JOIN查询、子查询
    - A join B:LEFT JOIN A表为驱动表INNER JOIN MySQL会自动找出那个数据少的表作用驱动表RIGHT JOIN B表为驱动表
    - 尽量使用inner join，避免left join
    - 被驱动表的索引字段作为on的限制字段
    - 利用小表去驱动大表
    - 删除JOIN和WHERE子句中的计算字段
    - JOIN 查询:确认两个表中Join的字段是被建过索引的。这样，MySQL内部会启动优化Join的SQL语句的机制。
    - 多表连接查询时，把结果集小的表（注意，这里是指过滤后的结果集，不一定是全表数据量小的）作为驱动表
    - 多表联接并且有排序时，排序字段必须是驱动表里的，否则排序列无法用到索引
* 查询松散索引扫描（Loose Index Scan）与紧凑索引扫描（Tight Index Scan）
    + 松散索引扫描方式下，分组操作和范围预测（如果有的话）一起执行完成的。不需要连续的扫描索引中得每一个元组，扫描时仅考虑索引中得一部分。当查询中没有where条件的时候，松散索引扫描读取的索引元组的个数和groups的数量相同。如果where条件包含范围预测，松散索引扫描查找每个group中第一个满足范围条件，然后再读取最少可能数的keys。松散索引扫描只需要读取很少量的数据就可以完成group by操作，因而执行效率非常高，执行计划中Etra中提示" using index for group-by"。松散索引扫描可以作用于在select list中其它形式的聚集函数，除了min()和max()之外，还支持：
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

## 索引优化

查询速度的提高是以插入、更新、删除的速度为代价的，这些写操作增加了大量的I/O

* 用在where条件中和排序动作中
    - 先过滤，再排序，会用到过滤条件中的索引参数，但是排序会使用较慢的外部排序。因为这个结果集是经过过滤的，并没有什么索引参与。
    - 先排序，再过滤，可以使用同一个索引，排序的优先级高于过滤的优先级。选择合适的索引，在过滤的同时就把这个事给办了。但是扫描的行数会增加。
* 不要过度使用索引，过多的索引可能会导致过高的磁盘使用率以及过高的内存占用.评估你的查询
* 单列索引：一些基数（Cardinality）太小（比如说，该列的唯一值总数少于255）的列就不要创建独立索引了
* 尽量避免事后添加索引：可能需要监控大量的SQL才能定位到问题所在，而且添加索引的时间肯定是远大于初始添加索引所需要的时间
* 不会使用索引的情况：非独立的列（索引列不能是表达式的一部分，也不能是函数的参数）
* LIKE关键字匹配'%'开头的字符串,不会使用索引
* OR关键字的两个字段必须都是用了索引,该查询才会使用索引
* 使用多列索引必须满足最左匹配
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
* 无缓冲查询:通常当你从脚本执行一个查询，在它可以继续后面的任务之前将需要等待查询执行完成。你可以使用无缓冲的查询来改变这一情况。"mysql_unbuffered_query() 发送SQL查询语句到MySQL不会像 mysql_query()那样自动地取并缓冲结果行。这让产生大量结果集的查询节省了大量的内存，在第一行已经被取回时你就可以立即在结果集上继续工 作，而不用等到SQL查询被执行完成。"有一定的局限性。你必须在执行另一个查询之前读取所有的行或调用mysql_free_result() 。另外你不能在结果集上使用mysql_num_rows() 或 mysql_data_seek()
* 使用 UNSIGNED INT 存储IP地址：定长四个字段，还有查询优势（IP between ip1 and ip2）。在查询中可以使用 INET_ATON() 来把一个IP转换为整数，用 INET_NTOA() 来进行相反的操作。在 PHP 也有类似的函数，ip2long() 和 long2ip()。 `$r = "UPDATE users SET ip = INET_ATON('{$_SERVER['REMOTE_ADDR']}') WHERE user_id = $user_id`
* 固定长度（静态）的表会更快：所有列都是"固定长度"，那么这个表被认为是"静态"或"固定长度"的。不固定的列类型包括 VARCHAR、TEXT、BLOB等。即使表中只包含一个这些类型的列，这个表就不再是固定长度的，MySQL 引擎会以不同的方式来处理它。固定长度的表会提高性能，因为 MySQL 引擎在记录中检索的时候速度会更快。它们也易于缓存，崩溃后容易重建。不过它们也会占用更多空间
* 垂直分区是为了优化表结构而对其进行纵向拆分的行为。将低频信息放到另一个表中，这样你的主用户表就会更小。如你所知，表越小越快。例子：last_login" 字段，用户每次登录网站都会更新这个字段，而每次更新都会导致这个表缓存的查询数据被清空。这种情况下你可以将那个字段放到另一张表里，保持用户表更新量最小
* 拆分大型DELETE或INSERT语句：执行大型DELETE或INSERT查询，则需要注意不要影响网络流量。当执行大型语句时，它会锁表并使你的Web应用程序停止。Apache运行许多并行进程/线程。 因此它执行脚本效率很高。所以服务器不期望打开过多的连接和进程，这很消耗资源，特别是内存。如果你锁表很长时间（如30秒或更长），在一个高流量的网站，会导致进程和查询堆积，处理这些进程和查询可能需要很长时间，最终甚至使你的网站崩溃。维护脚本需要删除大量的行，只需使用LIMIT子句，以避免阻塞。`while (1) { mysql_query("DELETE FROM logs WHERE log_date`
* 越少的列越快:对于数据库引擎，磁盘可能是最重要的瓶颈。更小更紧凑的数据、减少磁盘传输量，通常有助于性能提高。如果已知表具有很少的行，则没有理由是主键类型为INT，可以用MEDIUMINT、SMALLINT代替，甚至在某些情况下使用TINYINT。 如果不需要完整时间记录，请使用DATE而不是DATETIME
* 选择正确的存储引擎
    * MyISAM适用于读取繁重的应用程序，但是当有很多写入时它不能很好地扩展。 即使你正在更新一行的一个字段，整个表也被锁定，并且在语句执行完成之前，其他进程甚至无法读取该字段。 MyISAM在计算SELECT COUNT（*）的查询时非常快
    * InnoDB是一个更复杂的存储引擎，对于大多数小的应用程序，它比MyISAM慢。 但它支持基于行的锁定，使其更好地扩展。 它还支持一些更高级的功能，比如事务

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
* 减少对MySQL的访问
    - 理清应用逻辑，能一次取出的数据不用两次
    - 使用查询缓存MySQL的查询缓存（MySQL query cache）是4.1版本之后新增的功能，作用是存储select的查询文本和相应结果
        + 如果随后收到一个相同的查询，服务器会从查询缓存中重新得到查询结果，而不再需要解析和执行查询
        + 查询缓存适用于更新不频繁的表，当表更改（包括表结构和数据）后，查询缓存会被清空
    - 在应用端增加cache层
    - 负载均衡

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

## sysbench

## Docker

```
mkdir -p ~/mysql/data ~/mysql/logs ~/mysql/conf`

docker build -t mysql .
docker run -p 3306:3306 --name mymysql -v $PWD/conf/my.cnf:/etc/mysql/my.cnf -v $PWD/logs:/logs -v $PWD/data:/mysql_data -e MYSQL_ROOT_PASSWORD=123456 -d mysql:5.6
```

### [o1lab/xmysql](https://github.com/o1lab/xmysql)

One command to generate REST APIs for any MySql Database.

* composite primary keys: `/api/payments/103___JM555205`
* _p indicates page and _size indicates size of response rows,By default 20 records and max of 100 are returned per GET request on a table.`/api/payments?_p=2&_size=50`
* Sorting: `/api/payments?_sort=column1` `/api/payments?_sort=-column1` `/api/payments?_sort=column1,-column2`
* Fields `/api/payments?_fields=customerNumber,checkNumber` `/api/payments?_fields=-checkNumber`

```shell
npm install -g xmysql
xmysql -h localhost -u mysqlUsername -p mysqlPassword -d databaseName
http://localhost:3000

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
```

## 图书

* 《[高性能 MySQL（第3版）](https://book.douban.com/subject/23008813/)》
* [数据库索引设计与优化](https://book.douban.com/subject/26419771/)》
* 《[数据库系统概念（第6版）](https://book.douban.com/subject/10548379/)》

## 工具

*  客户端
    + 命令行
    + [MySQL Workbench](https://www.mysql.com/products/workbench/)
        * 会显示执行计划
    + [phpmyadmin/phpmyadmin](https://github.com/phpmyadmin/phpmyadmin):A web interface for MySQL and MariaDB https://www.phpmyadmin.net/
        * `sudo add-apt-repository ppa:phpmyadmin/ppa`
        * `export DEBIAN_FRONTEND=noninteractive`
        * `sudo apt-get -yq install phpmyadmin`
    + SQLyog:`ttrar`  `59adfdfe-bcb0-4762-8267-d7fccf16beda`
    + Sequel Pro
    + navicat
        * [DoubleLabyrinth/navicat-keygen](https://github.com/DoubleLabyrinth/navicat-keygen):A keygen for Navicat
        * Navicat Premium for Mac
* ER图
    - PowerDesigner
* [dbcli/mycli](https://github.com/dbcli/mycli):A Terminal Client for MySQL with AutoCompletion and Syntax Highlighting. http://mycli.net
* [github/orchestrator](https://github.com/github/orchestrator):MySQL replication topology management and HA
* [mysqljs/mysql](https://github.com/mysqljs/mysql):A pure node.js JavaScript Client implementing the MySql protocol.
* [DBDiff/DBDiff](https://github.com/DBDiff/DBDiff):Compare MySQL databases & automatically create schema & data change scripts/migrations rapidly (up & down SQL supported) for database version control. Supports *some* migration tools. https://dbdiff.github.io/DBDiff/
* [alibaba/AliSQL](https://github.com/alibaba/AliSQL/wiki):AliSQL is a MySQL branch originated from Alibaba Group. Fetch document from Release Notes at bottom.
* [alibaba/cobar](https://github.com/alibaba/cobar):a proxy for sharding databases and tables
* [github/gh-ost](https://github.com/github/gh-ost):GitHub's Online Schema Migrations for MySQL
* [oracle/mysql-operator](https://github.com/oracle/mysql-operator):Create, operate and scale self-healing MySQL clusters in Kubernetes
* [mysqltuner.pl](https://github.com/major/MySQLTuner-perl):主要检查参数设置的合理性包括日志文件、存储引擎、安全建议及性能分析
    - `wget https://raw.githubusercontent.com/major/MySQLTuner-perl/master/mysqltuner.pl`
    - `./mysqltuner.pl --socket /var/lib/mysql/mysql.sock`
    - 重要关注[!!]（中括号有叹号的项）,关注最后给的建议 "Recommendations"
* [tuning-primer.sh](https://github.com/BMDan/tuning-primer.sh):针于mysql的整体进行一个体检，对潜在的问题，给出优化的建议
    - `wget https://launchpad.net/mysql-tuning-primer/trunk/1.6-r1/+download/tuning-primer.sh`
    - `./tuning-primer.sh`
    - 重点查看有红色告警的选项，根据建议结合自己系统的实际情况进行修改
* pt-variable-advisor:分析MySQL变量并就可能出现的问题提出建议
    - `wget https://www.percona.com/downloads/percona-toolkit/3.0.13/binary/redhat/7/x86_64/percona-toolkit-3.0.13-re85ce15-el7-x86_64-bundle.tar`
    - `pt-variable-advisor localhost --socket /var/lib/mysql/mysql.sock`
    - 重点关注有WARN的信息的条目
* pt-query-digest 主要功能是从日志、进程列表和tcpdump分析MySQL查询.用来分析mysql的慢日志，与mysqldumpshow工具相比，py-query_digest 工具的分析结果更具体，更完善
    - 分析指含有select语句的慢查询:`pt-query-digest --filter '$event-&gt;{fingerprint} =~ m/^select/i' /var/lib/mysql/slowtest-slow.log&gt; slow_report4.log`
    - 分析指定时间范围内的查询:`pt-query-digest /var/lib/mysql/slowtest-slow.log --since '2017-01-07 09:30:00' --until '2017-01-07 10:00:00'&gt; &gt; slow_report3.log`
    - 查询所有所有的全表扫描或full join的慢查询 `pt-query-digest --filter '(($event-&gt;{Full_scan} || "") eq "yes") ||(($event-&gt;{Full_join} || "") eq "yes")' /var/lib/mysql/slowtest-slow.log&gt; slow_report6.log`
* sysbench：一个模块化，跨平台以及多线程的性能测试工具
* iibench-mysql：基于 Java 的 MySQL/Percona/MariaDB 索引进行插入性能测试工具
* tpcc-mysql：Percona开发的TPC-C测试工具
* Query Monitor:数据库查询特性使其成为定位慢SQL查询工具。该插件会报告所有页面请求过程中的数据库请求，并且可以通过调用这些查询代码或者原件
* [Meituan-Dianping/SQLAdvisor](https://github.com/Meituan-Dianping/SQLAdvisor):输入SQL，输出索引优化建议

## 参考

* [shlomi-noach/awesome-mysql](https://github.com/shlomi-noach/awesome-mysql):A curated list of awesome MySQL software, libraries, tools and resources

* [HOW TO INSTALL MYSQL NDB CLUSTER ON LINUX](https://clusterengine.me/how-to-install-mysql-ndb-cluster-on-linux/)
* [索引性能分析](http://draveness.me/sql-index-performance.html)
* [MySQL主从同步](http://geek.csdn.net/news/detail/236754)
* [MySQL数据库事务隔离级别介绍](http://www.jb51.net/article/49596.htm)
* [使用 Docker 完成 MySQL 数据库主从配置](https://juejin.im/post/59fd71c25188254dfa1287a9)
* [MySQL 学习笔记](https://notes.diguage.com/mysql/)
* [jaywcjlove/mysql-tutorial](https://github.com/jaywcjlove/mysql-tutorial):MySQL入门教程（MySQL tutorial book）
* [SQL语句百万数据量优化方案](https://juejin.im/post/5a01257a6fb9a045211e1bdc)
