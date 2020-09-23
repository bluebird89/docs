# [mysql / mysql-server](https://github.com/mysql/mysql-server)

MySQL Server, the world's most popular open source database, and MySQL Cluster, a real-time, open source transactional database. http://www.mysql.com/

## 版本

* MySQL 最初由瑞典 MySQL AB 公司开发，MySQL 的创始人是乌尔夫·米卡埃尔·维德纽斯，常用昵称蒙提（Monty）
  - 在被甲骨文公司收购后，现在属于甲骨文公司（Oracle） 旗下产品。Oracle 大幅调涨MySQL商业版的售价，因此导致自由软件社区们对于Oracle是否还会持续支持MySQL社区版有所隐忧
* MariaDB
  - 以 Monty 的小女儿Maria命名的，就像MySQL是以他另一个女儿 My 命名的一样
  - MySQL 的创始人就是之前那个叫 Monty 的大佬以 MySQL为基础成立分支计划 MariaDB。
  - MariaDB打算保持与MySQL的高度兼容性，确保具有库二进制奇偶校验的直接替换功能，以及与MySQL API 应用程序接口)和命令的精确匹配。而原先一些使用 MySQL 的开源软件逐渐转向 MariaDB 或其它的数据库。
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
sudo mysql_ssl_rsa_setup --uid=mysql
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
brew services start mysql@5.7
mysql.server start|stop

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

mysql_config --include
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
    + MySQL 8.0 版本开始将不再支持查询缓存功能
    + `show variables like '%query_cache%';`
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
  - 分析器:词法分析,通过关键字将SQL语句进行解析，并生成一颗对应的解析树,预处理器会校验“解析树”是否合法(主要校验数据列和表明是否存在，别名是否有歧义等)，
    + 检查单词是否拼写错误
    + 检查要查询的表或字段是否存在。检测出有错误就会返回类似 "You have an error in your sql" 这样的错误信息，并结束查询操作
  - 优化器：对于一个 sql 语句，mysql 内部可能存在多种执行方案，结果都一样，但效率不一样，在执行之前需要尝试找出一个最优的执行计划.在表里面有多个索引的时候，决定使用哪个索引；或者在一个语句有多表关联（join）的时候，决定各个表的连接顺序。
    + 基于成本的优化器:尝试预测一个查询使用某种执行计划时的成本，并选择其中成本最小的一个。成本的最小单位是读取一个4K数据页的成本
    + 在MySQL可以通过查询当前会话的 last_query_cost的值来得到其计算当前查询的成本 `show status like 'last_query_cost';` 结果为数据页的数量
    + 有非常多原因会导致MySQL选择错误的执行计划
      * 比如统计信息不准确、不会考虑不受其控制的操作成本（用户自定义函数、存储过程）
      * MySQL认为的最优跟我们想的不一样（我们希望执行时间尽可能短，但MySQL值选择它认为成本小的，但成本小并不意味着执行时间短）
    + 优化策略
      * 多表关联的查询（INTER JOIN）:优化器会根据数据的选择性来重新决定关联的顺序，选择性高的会被置前。如果关联设计到N张表，优化器会尝试N！种的关联顺序，从中选出一种最优的排列顺序
      * 提前终止查询（比如：使用Limit时，查找到满足数量的结果集后会立即终止查询）
      * 将外连接转化成内连接
      * 覆盖索引：索引包含 (或覆盖) 所有需要查询的字段的值
        - 索引条目通常远小于数据行大小，只需要读取索引，则mysql会极大地减少数据访问量
        - 索引是按照列值顺序存储的，所以对于IO密集的范围查找会比随机从磁盘读取每一行数据的IO少很多
        - 一些存储引擎如myisam在内存中只缓存索引，数据则依赖于操作系统来缓存，因此要访问数据需要一次系统调用
        - innodb的聚簇索引，覆盖索引对innodb表特别有用
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
* 存储层：负责数据的存储和提取，其架构模式是插件式的，支持 InnoDB、MyISAM、Memory 等多个存储引擎
  - 各个数据页可以组成一个双向链表
  - 记录都存在页里边,每个数据页中的记录又可以组成一个单向链表
  - 每个数据页都会为存储在它里边儿的记录生成一个页目录，在通过主键查找某条记录的时候可以在页目录中使用二分法快速定位到对应的槽，然后再遍历该槽对应分组中的记录即可快速找到指定的记录
  - 以其他列(非主键)作为搜索条件：只能从最小记录开始依次遍历单链表中的每条记录。
  - 计算机在读写文件时会以页为单位将数据加载到内存中
  - 需要在数据库中查询数据时，CPU 会发现当前数据位于磁盘而不是内存中，这时就会触发 I/O 操作将数据加载到内存中进行访问，数据的加载都是以页的维度进行加载的，然而将数据从磁盘读取到内存中所需要的成本是非常大的，普通磁盘（非 SSD）加载数据需要经过队列、寻道、旋转以及传输的这些过程，大概要花费 10ms 左右的时间

[MySQL查询](../_static/mysql_query.png)
[MySQL查询](../_static/innodb_log.png)

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
  - max_connection 最大连接数:MySQL实例的最大连接数，上限值是16384.增加该值增加文件描述符的数量。
    + 如果服务器的并发连接请求量比较大，建议调高此值，以增加并行连接数量，当然这建立在机器能支撑的情况下，因为如果连接数越多，介于MySQL会为每个连接提供连接缓冲区，就会开销越多的内存，所以要适当调整该值，不能盲目提高设值。
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
  - innodb_flush_log_at_trx_commit: 控制事务提交时，刷redo log的策略,控制innodb将log buffer中的数据写入日志文件并flush磁盘
    + 0:表示当事务提交时，不做日志写入操作，而是每秒钟将log buffer中的数据写入日志文件并flush磁盘一次，同时MySQL主动fsync
    + 1(默认配置):每秒钟或是每次事务的提交都会引起日志文件写入、flush磁盘的操作，同时MySQL主动fsync，确保了事务的ACID,可以获得强一致性
    + 2:每次事务提交引起写入日志文件的动作，每秒钟完成一次flush磁盘操作. 建议：不仅可以保证性能，也相对可以保障安全性
    + 实测发现，该值对插入数据的速度影响非常大，设置为2时插入10000条记录只需要2秒，设置为0时只需要1秒，而设置为1时则需要229秒，MySQL手册也建议尽量将插入操作合并成一个事务，这样可以大幅提高速度。根据MySQL手册，在允许丢失最近部分事务的危险的前提下，可以把该值设为0或2
  - innodb_log_buffer_size:log缓存大小，一般为1-8M，默认为1M，对于较大的事务，可以增大缓存大小。可设置为4M或8M。
  - innodb_additional_mem_pool_size:该参数指定InnoDB用来存储数据字典和其他内部数据结构的内存池大小。缺省值是1M。通常不用太大，只要够用就行，应该与表结构的复杂度有关系。如果不够用，MySQL会在错误日志中写入一条警告信息。根据MySQL手册，对于2G内存的机器，推荐值是20M，可适当增加。
  - innodb_thread_concurrency=8:推荐设置为 2*(NumCPUs+NumDisks)，默认一般为8
  - INNODB_LOG_FILE_SIZE
* 模式
  - 严格模式
* 长连接是指连接成功后，如果客户端持续有请求，则一直使用同一个连接
  - 有效减少建立连接过程带来的损耗，进而提升性能
  - MySQL 在执行过程中临时使用的内存是管理在连接对象里面的，这些资源只有在连接断开的时候才会释放
    + 定期断开长连接：使用一段时间，或者程序里判断执行过一个占用较大内存的查询后，主动断开连接
    + MySQL 5.7 或者更高版本，可以在每次执行一个比较大的操作后，通过执行 mysql_reset_connection 来重新初始化连接资源
* 短连接则是指每次执行完很少的几次查询就断开连接，下次查询再重新建立一个
* mysql 代表客户端命令，- u 表示后面需要连接的用户，-p 表示需要输入此用户的密码
  - 每一行的结束符，这里用 ; 或者 \g 来表示每一行的结束
  - 「Your MySQL connection id is 4」，这个记录了 MySQL 服务到目前为止的连接数，每个新链接都会自动增加 1 ，上面显示的连接次数是 4 ，说明连接了四次
  - MySQL 的版本，我们使用的是 5.7
  - 通过 help 或者 \h 命令来显示帮助内容，通过 \c 命令来清除命令行 buffer

```sh
\s|status
chmod 644 /etc/my.cnf # 文件 /etc/my.conf 只能由 root 用户修改
cat /dev/null > ~/.mysql_history # 删除 MySQL shell 历史

# mysqladmin
mysqld --initialize

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
show variables like 'datadir';

select now();
select curtime();
```

### 权限控制

* 账户信息保存在 mysql.user
* GRANT 和 REVOKE 可在几个层次上控制访问权限：
  - 整个服务器，使用 GRANT ALL 和 REVOKE ALL；
  - 整个数据库，使用 ON database.*；
  - 特定的表，使用 ON database.table；
  - 特定的列；
  - 特定的存储过程。
* 新创建的账户没有任何权限
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
UPDATE user SET user='newuser' WHERE user='myuser';
FLUSH PRIVILEGES;

select user(); # 当前连接数据库的用户

show grants for 'testuser'@'localhost';
SHOW GRANTS FOR CURRENT_USER();
revoke select |delete|insert|update on test.* from 'jack'@'localhost';
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

* 整型 INTEGER
  - tinyint       0-255 或 -2^7~2^7-1 1个字节
  - smallint      -2^15~2^15-1        2个字节
  - mediumint     -2^23~2^23-1        3个字节
  - int           0-2^32-1            4个字节 默认 int(11)
  - bigint        0-2^64-1            8个字节
  - 数据的显示宽度,不决定数据大小
    + bigint 默认宽度是 20 ，int默认宽度 11
    + 显示宽度指明Mysql最大可能显示的数字个数，数值的位数小于指定的宽度时数字左边会用空格填充，空格不容易看出
    + 如果插入了大于显示宽度的值，只要该值不超过该类型的取值范围，数值依然可以插入且能够显示出来
    + 默认存在符号位，unsigned 无符号数
    + 指定 zerofill 选项，会自动为该列添加 UNSIGNED 属性，则不足显示宽度的部分用 0 填充，如果是 1 会显示成 0000000001。
* 定点数:decimal(M,D)，M的最大值是65，D的最大值是30
  - 如果不写精度和标度，按照 decimal(10,0) 来进行操作，如果数据超过了精度和标题，MySQL 会报错
  - 使用二进制格式将9个十进制(基于10)数压缩为4个字节来表示DECIMAL列值
  - M整数与小数部分的总长度， D指的是小数部分的长度
  - 注意:定点数的值是精确的数值，浮点数会失去精度
  - 支持显示宽度，支持无符号
* 浮点型:  M 表示的就是 「整数位 + 小数位」 的数字，D 表示位于 . 后面的小数。M 也被称为精度 ，D 被称为标度
  - 单精度 float(M,D)  (论上可以保留7位小数) 3.4E+38~3.4E+38     4个字节
  - 双精度 double(M,D) (理论上保留15位小数) -1.8E+308~1.8E+308  8个字节
  - 浮点数如果不写精度和标度，会按照实际的精度值进行显示
  - 表示近似值，精度会丢失,不要作比较
  - 浮点数的执行效率要高于定点数
  - 支持符号位 unsigned 属性，也支持显示宽度 zerofill 属性
* 位类型
  - 存放字段值，BIT(M) 可以用来存放多位二进制数
  - M 的范围是 1 - 64，如果不写的话默认为 1 位
  - 查询 `SELECT HEX(id),bin(id) from test`
* **字符**
  - char(M) 定长字符串，速度快，但浪费空间
    + 固定长度，最多可以**存储 255 个字符 (注意不是字节)**，字符有不同的编码集，比如 UTF8 编码 (3字节)、GBK 编码 (2字节) 等
    + 对于 CHAR(M) 如果实际存储的数据长度小于M，则 MySQL 会自动会在它的右边用空格字符补足，但是在检索操作中那些填补出来的空格字符会被去掉
    + 存取速度比varchar要快得多，因为其长度固定，方便程序的存储与查找
    + 付出的是空间的代价，因为其长度固定，所以会有多余的空格占位符占据空间，可谓是以空间换取时间效率
  - varchar(M) 变长字符串，速度慢，但节省空间
    + **最大长度为 65535 个字节**
      * 英文字符（ASCII）占用1个字节，汉字占用两个字节
      * utf-8状态下，每个字符最多占3个字节，汉字最多可以存 21844个字符,英文也为 21844个字符
      * gbk状态下，每个字符最多占2个字节，汉字最多可以存 32766个字符，英文也为 32766个字符
      * latin1 最大为65532个字符
    + 存储的是实际的字符串加1或2个字节用来记录字符串实际长度，字符串长度小于255字节用1字节记录，超过255就需要2字节记录
    + 最大有效长度由最大行大小和使用的字符集确定
    + 最大有效长度是65532字节，因为在varchar存字符串时，第一个字节是空的，不存在任何数据，然后还需两个字节来存放字符串的长度，所以有效长度是64432-1-2=65532字节
    + 在5.0.3以下的版本中的最大长度限制为255，而在5.0.3及以上的版本中
    + mysql 4.0以下版本，varchar(50) 指的是 50 字节，如果存放 UTF8 格式编码的汉字时（每个汉字3字节），只能存放16 个。
    + mysql 5.0以上版本，varchar(50) 指的是 50 字符，无论存放的是数字、字母还是 UTF8 编码的汉字，都可以存放 50 个。
    + 值保存和检索时尾部空格保留
  - CHAR vs VARCHAR
    + 共同点:**CHAR(M) 和 VARCHAR(M) 都表示该列能存储 M 个字符，注意不是字节**
  - 分配给CHAR或VARCHAR列的值超过列的最大长度，则对值进行裁剪以使其适合。如果被裁掉的字符不是空格，则会产生一条警告
  - 超过255字符的只能用varchar或者text
  - blob 二进制字符串（字节字符串）
    + tinyblob
    + blob
    + mediumblob
    + longblob
  - text 非二进制字符串（字符字符串）
    + tinytext: 2^8-1
    + text 2^16-1 不可以有默认值，能用varchar的地方不用text，占用字节比varchar大太多
    + mediumtext 中型文本型 2^24-1 0－1677个字符
    + longtext 大型文本 2^32-1 0-42亿个字符
  - blob和text唯一区别就是blob保存二进制数据、没有字符集和排序规则
  - BINARY 和 VARBINARY 与 CHAR 和 VARCHAR 非常类似，不同的是它们包含二进制字符串而不包含非二进制字符串。BINARY 与 VARBINARY 的最大长度和 CHAR 与 VARCHAR 是一样的，只不过是**定义字节长度**，而 CHAR 和 VARCHAR 对应的是**字符长度**
* 日期时间
  - date 3字节 1000-01-01 - 9999-12-31 current_date
    + `insert into test5 values ('2020-06-13'),('20200613'),(20200613);`
  - year 1字节
    + 用 4 位的数字或者字符串表示，两者效果相同，表示范围 1901 - 2155，插入超出范围的数据会报错。
    + 以 2 位字符串格式表示，范围为 ‘00’~‘99’。‘00’~‘69’ 表示 2000~2069，‘70’~‘99’ 表示1970~1999。‘0’ 和 ‘00’ 都会被识别为 2000，超出范围的数据也会被识别为 2000。
    + 以 2 位数字格式表示，范围为 1~99。1~69 表示 2001~2069, 70~99 表示 1970~1999。但 0 值会被识别为0000，这和 2 位字符串被识别为 2000 有所不同
    + `insert into test4 values ('0'),('00'),('11'),('88'),('20'),('21');`
    + `insert into test4 values (0),(00),(11),(88),(20),(21);`
  - time 3字节 -838:59:59 - 838:59:59 10:09:08  CURRENT_TIME()
    + ADDTIME(CURRENT_TIME(), 023000),  SUBTIME(CURRENT_TIME(), 023000);
    + TIMEDIFF(end_at, start_at)
    + TIME_FORMAT(start_at, '%h:%i %p') start_at
    + UTC_TIME()
  - datetime 8字节 '1000-01-01 00:00:00' - '9999-12-31 23:59:59'，精度是秒
    + 默认值建议 CURRENT_TIMESTAMP
    + `insert into test4 values ('2020-06-13 11:11:11'),(20200613111111),('20200613111111'),(20200613080808);`
  - timestamp：4字节 自 1970年1月1日午夜以来的秒数，和unix时间戳相同，19700101000000 到 2038-01-19 03:14:07。默认timestamp值 为 NOT NULL， current_timestamp 取值范围比 DATETIME 小
    + 返回后显示为 YYYY-MM-DD HH:MM:SS 格式的字符串
    + 默认值建议 CURRENT_TIMESTAMP
  - 每种日期类型都有一个范围，如果超出这个范围，在默认的 SQLMode 下，系统会提示错误，并进行零值存储
    * Strict mode (and more specifically NO_ZERO_DATE which is part of strict mode) usually sets off that error if the table was created with an all zero default date
    + 查看 SELECT @@sql_mode，使用1970-01-01 00:00:01
* enum(val1, val2, val3...)
  - 范围需要在创建表时显示指定，对 1 - 255 的枚举需要 1 个字节存储；对于 255 - 65535 的枚举需要 2 个字节存储
  - 在已知的值中进行单选。最大数量为65535
  - 枚举值在保存时，以2个字节的整型(smallint)保存。每个枚举值，按保存的位置顺序，从1开始逐一递增
  - 表现为字符串类型，存储却是整型
  - NULL值的索引是NULL
  - 空字符串错误值的索引值是0
* set(val1, val2, val3...)
  - 最多可以有64个不同的成员。以bigint存储，共8个字节。采取位运算的形式
  - 当创建表时，SET成员值的尾部空格将自动被删除
  - SET 对于每 0 - 8 个成员，分别占用 1 个字节，最大到 64 ，占用 8 个字节
  - Set 类型一次可以选取多个成员，而 ENUM 则只能选一个
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
INSERT INTO user(username) SELECT name FROM account;
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

## 算术运算符

* + 加法
* - 减法
* * 乘法
* /, DIV  除法，返回商
* %, MOD  除法，返回余数

## 比较运算符

* =   等于
* <> 或者是 !=   不等于
* <=> NULL 安全的等于，也就是 NULL-safe，与 = 号最大的区别在于可以比较 NULL 值
* <   小于
* <=  小于等于
  - select 'a' <= 'b';  /* 返回 1 */
* >   大于
* > =  大于等于
  - select 'a' >= 'b'; /* 返回 0 呢*/
* BETWEEN 在指定范围内
* IS NULL 是否为 NULL
* IS NOT NULL 是否为 NULL
* IN  存在于指定集合
* LIKE    通配符匹配
* REGEXP 或 RLIKE  正则表达式匹配 ‘abcd’ REGEXP ‘ab’

## 逻辑运算符

* NOT 或 ！ 逻辑非
* AND 或者是 &&  逻辑与
* OR 或者是 ||   逻辑或
* XOR 逻辑异或

## 位运算符

* &   位与
* |   位或
* ^   位异或
* ～   位取反 select bin(~1)
* > >  位右移 除法 2^n
* <<  位左移 乘法 2^n

## 函数

* 数值函数
  - abs(x)            -- 绝对值 abs(-10.9) = 10
  - format(x, d)    -- 格式化千分位数值 format(1234567.456, 2) = 1,234,567.46
  - ceil(x)            -- 向上取整 ceil(10.1) = 11
  - floor(x)        -- 向下取整 floor (10.1) = 10
  - ROUND(x,y) 返回 x 四舍五入后保留 y 位小数的值；如果是整数，那么 y 位就是 0 ；如果不指定 y ，那么 y 默认也是 0 。
  - mod(m, n)        -- m%n m mod n 求余 10%3=1
  - pi()            -- 获得圆周率
  - pow(m, n)        -- m^n
  - sqrt(x)            -- 算术平方根
  - RAND() ：返回 0 到 1 的随机值
  - TRUNCATE(x,y): 返回数字 x 截断为 y 位小数的结果
* 时间日期函数
  - now(), current_timestamp();     -- 当前日期时间
  - WEEK(DATE) 一年中的第几周
  - YEAR(DATE) 给定日期的哪一年
  - HOUR(time) 和 MINUTE(time) : 返回给定时间的小时，后者返回给定时间的分钟
  - MONTHNAME(date) 函数：返回 date 的英文月份
  - CURDATE()|current_date() 函数：返回当前日期，只包含年月日
  - CURTIME()|current_time() 函数：返回当前时间，只包含时分秒
  - date('yyyy-mm-dd hh:ii:ss');    -- 获取日期部分
  - DATE_FORMAT('yyyy-mm-dd hh:ii:ss', '%d %y %a %d %m %b %j');  按照字符串 fmt 对 date 进行格式化，格式化后按照指定日期格式显示
  - DATE_ADD(date, interval, expr type) 函数：返回与所给日期 date 相差 interval 时间段的日期,间隔类型的关键字，expr 是表达式,13 种时间间隔类型
    + YEAR  年   YY
    + MONTH   月   MM
    + DAY 日   DD
    + HOUR    小时  hh
    + MINUTE  分   mm
    + SECOND  秒   ss
    + YEAR_MONTH  年和月 YY-MM
    + DAY_HOUR    日和小时    DD hh
    + DAY_MINUTE  日和分钟    DD hh : mm
    + DAY_SECOND  日和秒 DD hh ：mm ：ss
    + HOUR_MINUTE 小时和分    hh:mm
    + HOUR_SECOND 小时和秒    hh:ss
    + MINUTE_SECOND   分钟和秒    mm:ss
  - DATE_DIFF(date1, date2) 用来计算两个日期之间相差的天数
  - time('yyyy-mm-dd hh:ii:ss');    -- 获取时间部分
  - UNIX_TIMESTAMP(date) : 返回 UNIX 的时间戳
  - `FROM_UNIXTIME(date)`  返回 UNIXTIME 时间戳的日期值，和 UNIX_TIMESTAMP 相反
* 字符串函数
  - length(string)            -- string长度，字节
  - char_length(string)        -- string的字符个数
  - substring(str, position [,length])        -- 从str的position开始,取length个字符
  - REPLACE(str,a,b) : 用字符串 b 替换字符串 str 种所有出现的字符串 a
  - instr(string ,substring)    -- 返回substring首次在string中出现的位置
  - SUBSTRING(str,x,y) 函数：返回从字符串 str 中第 x 位置起 y 个字符长度的字符串
  - STRCMP(s1,s2) 用于比较字符串 s1 和 s2 的 ASCII 值大小。如果 s1 < s2，则返回 -1；如果 s1 = s2 ，返回 0 ；如果 s1 > s2 ，返回 1。
  - INSERT(str,x,y,instr) ：将字符串 str 从指定 x 的位置开始， 取 y 个长度的字串替换为 instr
  - CONCAT(s1,s2 ... sn)    -- 连接字串
    + 任何和 NULL 进行字符串拼接的结果都是 NULL
  - charset(str)            -- 返回字串字符集
  - lcase(string)            -- 转换成小写
  - LEFT(str,x)    返回字符串最左边的 x 个字符
  - RIGHT(str,x)   返回最右边的 x 个字符。如果第二个参数是 NULL，那么将不会返回任何字符串
  - load_file(file_name)    -- 从文件读取内容
  - locate(substring, string [,start_position])    -- 同instr,但可指定开始位置
  - LPAD(str,n,pad) 用字符串 pad 对 str 左边，直到长度为 n 个字符长度
  - RPAD(str,n,pad) 用字符串 pad 对 str 右边进行填充，直到长度为 n 个字符长度
  - TRIM(str) 函数：用于去掉目标字符串的空格
  - LTRIM(str)  去掉字符串左边的空格
  - RTRIM   去掉字符串右边的空格
  - REPEAT(str,x) 函数：返回 str 重复 x 次的结果
  - rpad(string, length, pad)    --在str后用pad补充,直到长度为length
  - strcmp(string1 ,string2)    -- 逐字符比较两字串大小
  - LOWER(str) 将字符串所有字符变为小写
  - UPPER(str)   将字符串所有字符变为大写
* 流程函数
  - IF(value,t f) 如果 value 是真，返回 t；否则返回 f
  - IFNULL(value1,value2)   如果 value1 不为 NULL，返回 value1，否则返回 value2。
  - CASE WHEN[value1] THEN[result1] ...ELSE[default] END    如果 value1 是真，返回 result1，否则返回 default
  - CASE[expr] WHEN[value1] THEN [result1]... ELSE[default] END 如果 expr 等于 value1， 返回 result1， 否则返回 default
  - case when [condition] then result [when [condition] then result ...] [else result] end   多分支
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
  - default();
  - VERSION()   返回当前数据库的版本
  - DATABASE()   返回当前数据库名
  - USER()   返回当前登陆用户名
  - PASSWORD(str) : 返回字符串的加密版本
  - MD5(str) 返回字符串 str 的 MD5 值
  - INET_ATON(192.168.1.11)   返回 IP 地址的数字表示
  - INET_NTOA(3232235777)  返回数字代表的 IP 地址
  - COALESCE 返回参数中的第一个非空表达式

```sql
set @currenttime=(select UNIX_TIMESTAMP(current_timestamp()));

# 展示结果的时候不想展示 null，而想展示 'N/A'
SELECT
    COALESCE(city, 'N/A')
  FROM
    customers;
```

## SQL Structure Query Language

* 数据定义语言 DDL (Data Definition Language):定义数据库对象:数据库、表、列等；
* 数据操作语言 DML (Data Manipulation Language):对数据库中表的记录进行更新。关键字：insert、update、delete等
* 数据控制语言 DCL(Data Control Language):定义数据库访问权限和安全级别，创建用户等。关键字：grant等
* 数据查询语言 DQL(Data Query Language):查询数据库中表的记录，关键字：select from where等

```sh
? contents; # 查询所有可供查询的分类
? Account Management
? Data Types
? VARCHAR
? show
```

### DDL

* 数据库
  - informationn_schema：主要存储一些数据库对象信息，比如用户表信息、权限信息、分区信息等
  - performannce_schema：MySQL 5.5 之后新增加的数据库，主要用于收集数据库服务器性能参数。
  - sys: MySQL 5.7 提供的数据库，sys 数据库里面包含了一系列的存储过程、自定义函数以及视图来帮助我们快速的了解系统的元数据信息。
- 主键
  + 能唯一标识记录的字段，可以作为主键
  + 一个表只能有一个主键
  + 具有唯一性
  + 值不能为null
  + 声明字段时，用 primary key 标识，也可以在字段列表之后声明
    - `create table tab ( id int, stu varchar(10), primary key (id));`
    * 复合主键（联合主键）`create table tab ( id int, stu varchar(10), age int, primary key (stu, age));`每一条新增都需要判断是否重复，而数据量一旦增大，每次新增都需要全表筛查
* 约束:SQL 约束用于规定表中的数据规则
  - 如果存在违反约束的数据行为，行为会被约束终止。
  - 约束可以在创建表时规定（通过 CREATE TABLE 语句），或者在表创建之后规定（通过 ALTER TABLE 语句）
  - 类型
    * unique 唯一索引（唯一约束） 使得某字段的值也不能重复
    * NOT NULL | NULL(默认)：字段值是否可以为空
    * PRIMARY KEY - NOT NULL 和 UNIQUE 的结合。确保某列（或两个列多个列的结合）有唯一标识，有助于更容易更快速地找到表中的一个特定的记录。
    * FOREIGN KEY - 保证一个表中的数据匹配另一个表中的值的参照完整性。
    * CHECK - 保证列中的值符合指定的条件。
    * DEFAULT - 规定没有给列赋值时的默认值。
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
- foreign key 外键约束：限制主表与从表数据完整性
  + `foreign key (外键字段） references 主表名 (关联字段) [主表记录删除时的动作] [主表记录更新时的动作]`
  + `alter table t1 add constraint `t1_t2_fk` foreign key (t1_id) references t2(id);`
  + t1 依赖t2,存在外键的表，称之为从表（子表），外键指向的表，称之为主表（父表）
  + 只被InnoDB存储引擎所支持。其他引擎是不支持
  + 作用：保持数据一致性，完整性，主要目的是控制存储在外键表（从表）中的数据
    * 主表数据无法被删除，必须先删从表
    * 从表新增数据必须与主表某行关联
  + 定了 on update 或 on delete：删除或更新时操作：
    - cascade：级联操作。主表数据更新（主键值更新），从表也被更新（外键值更新）。主表记录被删除，从表相关记录也被删除
    - set null：设置为null。主表数据被更新（主键值更新），从表的外键被设置为null。主表记录被删除，从表相关记录外键被设置成null。注意，要求该外键列，没有not null属性约束
    - restrict，拒绝父表删除和更新
  + 不可滥用，没有合适的理由支撑它的使用的话，将导致业务强制耦合。另外对开发人员不够友好。使用外键一定不能超过3表相互。否则将引出很多的麻烦而不得不取消外键

```sql
select now(), user(), version();

SHOW DATABASES[ like 'pattern'];
CREATE DATABASE [IF NOT EXISTS] db_name [CHARACTER SET utf8 COLLATE utf8_unicode_ci];

# 特殊符号、关键字表名加``
ALTER DATABASE db_name charset=utf8;
DROP DATABASE [IF EXISTS] db_name;
SHOW CREATE DATABASE db_name;
USE db_name;
select database();  # 查看当前使用的数据库

SHOW TABLE STATUS [FROM db_name] [LIKE 'pattern'] # 查看数据库状态
SHOW TABLE STATUS from 'your_db_name' where name='your_table_name';
SHOW TABLES [ LIKE 'pattern'];
DESCRIBE|DESC|EXPLAIN news;
SHOW CREATE TABELE news\G;
SHOW columns|index|keys from table_name;

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

CREATE TABLE Users (
  Id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  Username VARCHAR(64) NOT NULL UNIQUE DEFAULT 'default' COMMENT '用户名',
  Password VARCHAR(64) NOT NULL DEFAULT 'default' COMMENT '密码',
  Email VARCHAR(64) NOT NULL DEFAULT 'default' COMMENT '邮箱地址',
  Enabled TINYINT(4) DEFAULT NULL COMMENT '是否有效',
  PRIMARY KEY (Id)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

CREATE TABLE table_name SELECT column1,cloumn2 FROM another_table: # 复制数据不复制主键
CREATE TABLE table_name like another_table；  #  复制表结构 数据不复制，主键复制
CREATE TABLE vip_user AS SELECT * FROM user;
INSERT office_dup SELECT * FROM offices; # 一定要确保table offices后面的where，order或者其他条件，都需要有对应的索引，来避免出现table offices 全部记录被锁定的情况

ALTER TABLE table_name ADD address varchar(30) first| after name;
ALTER TABLE table_name CHANGE address add varchar(100) after id;
ALTER TABLE table_name MODIFY COLUMN address varchar(100);
ALTER TABLE table_name change wage salary decimal(10,2);
ALTER TABLE table_name DROP column address;
ALTER TABLE table_name ENGINE=MYISAM;
ALTER TABLE table_name rename[ to] new_table_name;
RENAME table table_name to new_table_name, tb3 TO tb4;
ALTER TABLE table_name rename to another_DB.new_table_name; # 移动表

CREATE [UNIQUE|FULLTEXT]  INDEX index_name on tbl_name (col_name [(length)] [ASC | DESC] , …..);
ALTER TABLE 'table_name' ADD PRIMARY KEY'index_name' ('column');
ALTER TABLE table_name ADD INDEX index_name (index_column(length));
ALTER TABLE 'table_name' ADD INDEX 'index_name' ('column1', 'column2', ...);
ALTER TABLE 'table_name' ADD INDEX idx_user(name(10) , city , age); # 因为一般情况下名字的长度不会超过10，这样会加速索引查询速度，还会减少索引文件的大小，提高INSERT的更新速度。
ALTER TABLE 'table_name' ADD FULLTEXT 'index_name' ('column');

ALTER TABLE 'table_name' DROP PRIMARY KEY;    # 删除主键(删除主键前需删除其AUTO_INCREMENT属性)
ALTER TABLE 'table_name' DROP INDEX 索引名;   # 删除索引
ALTER TABLE 'table_name' DROP FOREIGN KEY 外键;  # 删除外键
DROP INDEX index_name ON tbl_name;

INSERT INTO table_name values (null,值,default,....); # 全字段插入，自动增长列用null
INSERT INTO table_name values (null,值,....),(null,值,....),(null,值,....); # 插入多条数据
INSERT INTO table_name (字段1,字段2,字段3,…) VALUES (值1,值2,值3,…),(值1,值2,值3,…); # 记录操作：添加 更新与删除数据(新增与修改不用添加TABLE关键字)
INSERT INTO table_name set volumn1=value1,volumn3=value3,volumn3=value3;
insert into tbl_name select ...;
insert into tbl_name values/set/select on duplicate key update 字段=值, …; # 可以指定在插入的值出现主键（或唯一索引）冲突时，更新其他非主键列的信息

UPDATE table_name SET 字段1 = 新值1, 字段2 = 新值2  [WHERE条件]; # 更新
UPDATE base SET `count` = `count` + 1；

DROP TABLE [IF EXISTS] db_name; # 不再需要该表
TRUNCATE TABLE table_name;  # 仍要保留该表，但要删除所有记录时,删除表,重建同结构;重置auto_increment的值。而delete不会 不知道删除了几条，而delete知道;当被用于带分区的表时，truncate 会保留分区
DELETE FROM tbl_name [WHERE where_definition] [ORDER BY ...] [LIMIT row_count] # 删除部分记录时（一般来说有 WHERE 子句约束） 用 delete来删除表中部分记录
DELETE FROM 表1，表2 using 表连接操作 条件

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

## DQL

* `select [all|distinct] select_expr from -> where -> group by [合计函数] -> having -> order by -> limit`
* distinct|all:distinct去除重复记录,默认为 all 全部记录
  - `SELECT DISTINCT number, name FROM table tamb` 多参数 DISTINCT 去重规则是：把 DISTINCT  之后的所有参数当做一个过滤条件，也就是说会对 (number, name)整体去重处理，只有当这个组合不同才会去重
* 字段列表：要显示指定列数据
  - 多个字段之间用逗号隔开，各字段之间没有顺序
  - `*` 显示所有字段数据
  - 使用表达式（计算公式、函数调用、字段也是个表达式）
  - 为每个列使用别名。适用于简化列标识，避免多个列标识符重复
* from 子句:用于标识查询来源
  - 为表起别名。使用as关键字`select * from tb1 as tt, tb2 as bb;`
  - 后面可以同时出现多个表，多个表会横向叠加到一起，而数据会形成一个笛卡尔积 `select * from tb1, tb2;`
* where 子句
  - Index Key：用于确定SQL查询在索引中的连续范围(起始范围+结束范围)的查询条件，被称之为Index Key。由于一个范围，至少包含一个起始与一个终止，因此Index Key也被拆分为Index First Key和Index Last Key，分别用于定位索引查找的起始，以及索引查询的终止条件
    + Index First Key：用于确定索引查询的起始范围。提取规则：从索引的第一个键值开始，检查其在where条件中是否存在，若存在并且条件是=、>=，则将对应的条件加入Index First Key之中，继续读取索引的下一个键值，使用同样的提取规则；若存在并且条件是>，则将对应的条件加入Index First Key中，同时终止Index First Key的提取；若不存在，同样终止Index First Key的提取。
    + Index Last Key：Index Last Key的功能与Index First Key正好相反，用于确定索引查询的终止范围。提取规则：从索引的第一个键值开始，检查其在where条件中是否存在，若存在并且条件是=、<=，则将对应条件加入到Index Last Key中，继续提取索引的下一个键值，使用同样的提取规则；若存在并且条件是 < ，则将条件加入到Index Last Key中，同时终止提取；若不存在，同样终止Index Last Key的提取。
  - Index Filter：根据where条件固定了索引的查询范围，但是此范围中的项，并不都是满足查询条件的项。提取规则：同样从索引列的第一列开始，检查其在where条件中是否存在：若存在并且where条件仅为 =，则跳过第一列继续检查索引下一列，下一索引列采取与索引第一列同样的提取规则；若where条件为 >=、>、<、<= 其中的几种，则跳过索引第一列，将其余where条件中索引相关列全部加入到Index Filter之中；若索引第一列的where条件包含 =、>=、>、<、<= 之外的条件，则将此条件以及其余where条件中索引相关列全部加入到Index Filter之中；若第一列不包含查询条件，则将所有索引相关条件均加入到Index Filter之中。
  - Table Filter:提取规则：所有不属于索引列的查询条件，均归为Table Filter之中。
  - 运算数：变量（字段）、值、函数返回值
  - 运算符：!＝ =, <=>, <>, !=, <=, <, >=, >, !, &&, ||, in (not) null, (not) like, (not) in, (not) between and, is (not), and, or, not, xor is/is not 加上 true/false/unknown，检验某个值的真假 <=>与<>功能相同，<=>可用于null比较
  - LIKE('name%') NOT LIKE('name%') 匹配
    + % :0 个或多个字符
    + _ :一个字符
    + [charlist] 字符列中的任何单一字符
    + [^charlist]或[!charlist] 不在字符列中的任何单一字符 WHERE name REGEXP '^[GFs]'；name REGEXP '^[^A-H]'
* ORDER BY `order by 排序字段/别名 ASC|DESC [,排序字段/别名 排序方式] ...` 用于对结果集进行排序
  - DESC 会按照字段进行降序排列
  - ASC 会按照字段进行升序排列，默认会使用升序排列
  - 以按多个列进行排序，并且为每个列指定不同的排序方式
  - ORDER BY 联合指的是如果 ORDER BY 后面的字段是联合索引覆盖 where 条件之后的一个字段，由于索引已经处于有序状态，MySQL 就会直接从索引上读取有序的数据，然后在磁盘上读取数据之后按照该顺序组织数据，从而减少了对磁盘数据进行排序的操作。
  - 对于未覆盖 ORDER BY 的查询，其有一项 Creating sort index，即为磁盘数据进行排序的耗时最高；对于覆盖 ORDER BY 的查询，其就不需要进行排序，而其耗时主要体现在从磁盘上拉取数据的过程
* limit 子句，限制结果数量子句 `imit 起始位置, 获取条数` 从表记录的指定位置开始取
  - 仅对处理好的结果进行数量限制。将处理好的结果的看作是一个集合，按照记录出现的顺序，索引从0开始。
  - 省略第一个参数，表示从索引0开始
* having 子句：对汇总的 GROUP BY 结果进行过滤
  - 与 where 功能、用法相同，执行时机不同
    + WHERE 和 HAVING 都是用于过滤
    + HAVING 适用于汇总的组记录；而 WHERE 适用于单个记录
    + where 在开始时执行检测数据，对原数据进行过滤;having 对筛选出的结果再次进行过滤
    + having 字段必须是查询出来的，where 字段必须是数据表存在的
    + where 不可以使用字段别名，having 可以。因为执行WHERE代码时，可能尚未确定列值
    + where 不可以使用合计函数。一般需用合计函数才会用 having
  - 要求存在一个 GROUP BY 子句中的列或用于合计函数中的列
* GROUP BY 子句:分组子句 表示对分类聚合的字段进行分组 `group by 字段/别名 ASC|DESC`,
  - GROUP BY 子句将记录分组到汇总行中。
  - GROUP BY 为每个组返回一个记录。
  - 聚合
    + count 返回不同的非NULL值数目，count(*)、count(字段)
    + sum 求和
    + max 求最大值
    + min 求最小值
    + avg 求平均值
  - GROUP BY 可以按一列或多列进行分组。
  - GROUP BY 按分组字段进行排序后，ORDER BY 可以以汇总字段来进行排序
  - group_concat 返回带有来自一个组的连接的非NULL值的字符串结果。组内字符串连接
  - [合计函数]配合 group by 使用
* with：表示对汇总之后的记录进行再次汇总

```sql
SELECT [DISTINCT] 字段列表|* FROM table_name [WHERE条件][ORDER BY 排序(默认是按id升序排列)][LIMIT (startrow ,) pagesize];

SELECT id,title,author,hits,addate from news ORDER BY id DESC LIMIT 10 * $p,10; # limit [offset,]rowcount:offset 为偏移量，而非主键id 分页实现

SELECT column_name AS alias_name FROM table_name;
SELECT column_name(s) FROM table_name AS alias_name;

SELECT w.name, w.url, a.count, a.date FROM Websites AS w, access_log AS a WHERE a.site_id=w.id and w.name="菜鸟教程";

SELECT concat('a', 'b') # ab
SELECT concat_ws(',', 'a', 'b') # e,t
SELECT GROUP_CONCAT(c_name) FROM categories WHERE school_id =1 # 字符拼接

## 索引选择性计算
SELECT COUNT(DISTINCT index_column)/COUNT(*) FROM table_name; -- index_column代表要添加前缀索引的列，前缀索引的选择性比值，比值越高说明索引的效率也就越高效。
SELECT COUNT(DISTINCT LEFT(index_column,1))/COUNT(*),COUNT(DISTINCT LEFT(index_column,2))/COUNT(*),COUNT(DISTINCT LEFT(index_column,3))/COUNT(*) FROM table_name;

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

select age,count(1) from job group by age with rollup;
select age,count(1) from job group by age with rollup having count(1) > 1;

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
# delete join 同上

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

SELECT * FROM products ORDER BY prod_price DESC, prod_name ASC;
SELECT cust_name, COUNT(cust_address) AS addr_num FROM Customers GROUP BY cust_name;
SELECT cust_name, COUNT(cust_address) AS addr_num FROM Customers GROUP BY cust_name ORDER BY cust_name DESC;

SELECT cust_name, COUNT(*) AS num FROM Customers WHERE cust_email IS NOT NULL GROUP BY cust_name HAVING COUNT(*) >= 1;
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

## 子查询

* 嵌套在较大查询中的 SQL 查询.查询也称为内部查询或内部选择，而包含子查询的语句也称为外部查询或外部选择
  
  - 可以嵌套在 SELECT，INSERT，UPDATE 或 DELETE 语句内或另一个子查询中。
  - 通常会在另一个 SELECT 语句的 WHERE 子句中添加。
  - 可以使用比较运算符，如 >，<，或 =。比较运算符也可以是多行运算符，如 IN，BETWEEN,ANY 或 ALL。
  - 必须被圆括号 () 括起来
  - 内部查询首先在其父查询之前执行，以便可以将内部查询的结果传递给外部查询

* from型:from后要求是一个表，必须给子查询结果取个别名 `select * from (select * from tb where id>0) as subfrom where id>1;`
  
  - 简化每个查询内的条件
  - from型需将结果生成一个临时表格，可用以原表的锁定的释放
  - 子查询返回一个表，表型子查询

* where型 `select * from tb where money = (select max(money) from tb);`
  
  - 用于过滤记录，即缩小访问数据的范围。
  
  - 跟一个返回 true 或 false 的条件。
  
  - 与 SELECT，UPDATE 和 DELETE 一起使用。
  
  - 逻辑处理指令
    
    + AND 优先级高于 OR，为了明确处理顺序，可以使用 ()。
    + AND 操作符表示左右条件都要满足。
    + OR 操作符表示左右条件满足任意一个即可。
    + NOT 操作符用于否定一个条件。
  
  - 运算符
    
    + != all()    相当于 not in
    + = some()    相当于 in。any 是 some 的别名
    + != some()    不等同于 not in，不等于其中某一个
    + all, some 可以配合其他运算符一起使用
  
  - LIKE：确定字符串是否匹配模式
    
    + 只有字段是文本值时才使用 LIKE。
    + 支持两个通配符匹配选项：% 和 _。
    + 不要滥用通配符，通配符位于开头处匹配会非常慢。
    + % 表示任何字符出现任意次数。`WHERE prod_name LIKE '%bean bag%';`
    + _ 表示任何字符出现一次 `WHERE prod_name LIKE '__ inch teddy bear';`
  
  - 不需要给子查询取别名
  
  - where子查询内的表，不能直接用以更新
  
  - 标量子查询:子查询返回一个值
  
  - 列子查询
    
    + 如果子查询结果返回的是一列,使用 in 或 not in 完成查询
    + exists 和 not exists 条件 如果子查询返回数据，则返回1或0。常用于判断条件。`select column1 from t1 where exists (select * from t2);`
    + in｜not in：在指定的几个特定值中任选一个值
    + BETWEEN 选取介于某个范围内的值
  
  - 行子查询:用于与对能返回两个或两个以上列的子查询进行比较
    
    + 查询条件是一个行`select * from t1 where (id, gender) in (select id, gender from t2);`
    + 行构造符：(col1, col2, ...) 或 ROW(col1, col2, ...)

## 连接

* 连接查询：将多个表的字段通过指定连接条件进行连接
  - 公共字段名字可以不一样，数据类型必须一样
  - 联表查询降低查询速度
  - 数据冗余与查询速度的平衡
* 内连接 (inner)join（默认）：等值连接 两个表交集，只有数据存在时才能连接,不会出现空行,on 表示连接条件。其条件表达式与where类似。也可以省略条件（表示条件永远为真）
  - `SELECT vend_name, prod_name, prod_price FROM vendors INNER JOIN products ON vendors.vend_id = products.vend_id;`
  - 自然连接(natural join):把同名列通过 = 测试连接起来的，同名列可以有多个,自动判断连接条件完成连接, 相当于省略了using，会自动查找相同字段名
    + `SELECT * FROM Products NATURAL JOIN Customers;`
  - 自连接查询就是当前表与自身的连接查询，内连接的一种，只是连接的表是自身而已.关键点在于虚拟化出一张表给一个别名
    + `SELECT e.empName,b.empName from t_employee e LEFT JOIN t_employee b ON e.bossId = b.id`
    + `SELECT c1.cust_id, c1.cust_name, c1.cust_contact FROM customers c1, customers c2 WHERE c1.cust_name = c2.cust_name AND c2.cust_contact = 'Jim Jones';`
  - 交叉连接 -- 笛卡尔乘积  cross join  n*n `select * from tch_teacher cross join tch_contact`,在没有条件语句的情况下返回笛卡尔积
  - 内连接 vs 自然连接:内连接提供连接的列，而自然连接自动连接所有同名列。
  - where表示连接条件 `select info.id, info.name, info.stu_num, extra_info.hobby, extra_info.sex from info, extra_info where info.stu_num = extra_info.stu_id;`
  - `using(字段名)`:需字段名相同
  - 交叉连接 cross join：没有条件的内连接  `select * from tb1 cross join tb2;`
* 外连接(outer join):返回一个表中的所有行，并且仅返回来自次表中满足连接条件的那些行，即两个表中的列是相等的
  - 左连接 left join：以左边的表的数据为基准，去匹配右边的表的数据，如果匹配到就显示，匹配不到就显示为null，保留左表没有关联的行
    + `SELECT customers.cust_id, orders.order_num FROM customers LEFT JOIN orders ON customers.cust_id = orders.cust_id;`
  - 右连接 right join：以右边的表的数据为基准，去匹配左边的表的数据，如果匹配到就显示，匹配不到就显示为null，保留右表没有关联的行
    + `SELECT customers.cust_id, orders.order_num FROM customers RIGHT JOIN orders ON customers.cust_id = orders.cust_id;`
* 连接 vs 子查询:连接可以替换子查询，并且比子查询的效率一般会更快

```sql
# 删除重复行
DELETE FROM Products P1
 WHERE id < ( SELECT MAX(P2.id)
                   FROM Products P2
                  WHERE P1.name = P2.name
                    AND P1.price = P2.price );

-- 排序-- 排序从 1 开始。如果已出现相同位次，则跳过之后的位次
SELECT P1.name,
       P1.price,
       (SELECT COUNT(P2.price)
          FROM Products P2
         WHERE P2.price > P1.price) + 1 AS rank_1
  FROM Products P1
  ORDER BY rank_1;
```

## 组合（UNION）

* 将两个或更多查询的结果组合起来，并生成一个结果集，其中包含来自 UNION 中参与查询的提取行
* 规则
  - 所有查询的列数和列顺序必须相同。
  - 每个查询中涉及表的列的数据类型必须相同或兼容
  - 通常返回的列名取自第一个查询。
* 默认会去除相同行，如果需要保留相同行，使用 UNION ALL
* 默认 DISTINCT 方式，即所有返回行都是唯一的
* 建议，对每个SELECT查询加上小括号包裹
* ORDER BY 排序时，需加上 LIMIT 进行结合
* 只能包含一个 ORDER BY 子句，并且必须位于语句的最后
* 场景
  - 在一个查询中从不同的表返回结构数据。
  - 对一个表执行多个查询，按一个查询返回数据
* JOIN vs UNION
  - JOIN 中连接表的列可能不同，但在 UNION 中，所有查询的列数和列顺序必须相同。
  - UNION 将查询之后的行放在一起（垂直放置），但 JOIN 将查询之后的列放在一起（水平放置），即它构成一个笛卡尔积。

```sql
SELECT cust_name, cust_contact, cust_email
FROM customers
WHERE cust_state IN ('IL', 'IN', 'MI')
UNION
SELECT cust_name, cust_contact, cust_email
FROM customers
WHERE cust_name = 'Fun4All';
```

## [日志](https://mp.weixin.qq.com/s/SVbLDtr0lGGwfKcj4O6XFg)

* 类型
  - 逻辑日志：简单理解为记录的就是sql语句
  - 物理日志：mysql 数据最终是保存在数据页中的，物理日志记录的就是数据页变更
* binlog
  - 记录数据库执行的写入性操作(不包括查询)信息，以二进制的形式保存在磁盘中
  - mysql的逻辑日志，并且由 Server 层进行记录，使用任何存储引擎的 mysql 数据库都会记录 binlog 日志
  - 通过追加的方式进行写入的，可以通过max_binlog_size 参数设置每个 binlog文件的大小，当文件大小达到给定值之后，会生成新的文件来保存日志
  - 场景
    + 主从复制 ：在 Master 端开启 binlog ，然后将 binlog发送到各个 Slave 端， Slave 端重放 binlog 从而达到主从数据一致。
    + 数据恢复 ：通过使用 mysqlbinlog 工具来恢复数据
  - 刷盘
    + 对于 InnoDB 存储引擎而言，只有在事务提交时才会记录biglog. 通过 sync_binlog 参数控制 biglog 的刷盘时机，取值范围是 0-N
      * 0：不去强制要求，由系统自行判断何时写入磁盘
      * 1：每次 commit 的时候都要将 binlog 写入磁盘
      * N：每N个事务，才会将 binlog 写入磁盘
  - 格式
    + STATMENT：基于SQL 语句的复制( statement-based replication, SBR )，每一条会修改数据的sql语句会记录到binlog 中
      * 优点：不需要记录每一行的变化，减少了 binlog 日志量，节约了 IO  , 从而提高了性能；
      * 缺点：在某些情况下会导致主从数据不一致，比如执行sysdate() 、  slepp()  等 。
    + ROW：基于行的复制(row-based replication, RBR )，不记录每条sql语句的上下文信息，仅需记录哪条数据被修改了 。
      * 优点：不会出现某些特定情况下的存储过程、或function、或trigger的调用和触发无法被正确复制的问题 ；
      * 缺点：会产生大量的日志，尤其是` alter table ` 的时候会让日志暴涨
    + MIXED：基于STATMENT 和 ROW 两种模式的混合复制(mixed-based replication, MBR )，一般的复制使用STATEMENT 模式保存 binlog ，对于 STATEMENT 模式无法复制的操作使用 ROW 模式保存 binlog
  - binlog的最大序号 pow(2,31)-1 = 2147483647
  - 隐患
    + 生成新binlog时，会扫描当前已存在binlog文件，取得最大序号值。因此，如果binlog文件数目特别多的话，会影响MySQL的启动及日志切换效率
    + 当序号接近这个值，且差距小于 1000 时（序号大于 2147482647 时），就开始向error log中写入警告
    + 当序号达到最大值时，mysqld 进程直接退出
    + 除了要监控binlog文件数目、最大序号外，还应该再error log的内容，都予以足够重视
- redo log
  + InnoDB 引擎提供的日志系统，最开始 MySQL 里并没有 InnoDB 引擎。MySQL 自带引擎是 MyISAM，但是 MyISAM 没有 crash-safe 的能力，binlog 日志只能用于归档，不具备数据库崩溃重启后的数据恢复功能。
  + InnoDB 是另一个公司以插件形式引入 MySQL 的，既然只依靠 binlog 是没有 crash-safe 能力的，所以 InnoDB 使用另外一套日志系统——也就是 redo log 来实现 crash-safe 能力
  + crash-safe：保证即使数据库发生异常崩溃或者重启，之前提交的记录都不会丢失，可以根据这个日志记录的步骤完成未持久化到磁盘的数据更新操作，从而**保证数据一致性**
  + 事务**保证一致性**
    * 最简单的做法是在每次事务提交的时候，将该事务涉及修改的数据页全部刷新到磁盘中。但是这么做会有严重的性能问题
      - 因为 Innodb 是以 页 为单位进行磁盘交互的，而一个事务很可能只修改一个数据页里面的几个字节，这个时候将完整的数据页刷到磁盘的话，太浪费资源了！
      - 一个事务可能涉及修改多个数据页，并且这些数据页在物理上并不连续，使用随机IO写入性能太差
    * redo log：只记录事务对数据页做了哪些修改
  + redo log buffer
    * `show VARIABLES like 'innodb_log_buffer_size'`
    * 什么时候刷新到硬盘
      - log buffer空间不足：上面有指定缓冲区的内存大小，MySQL认为日志量已经占了总容量的一半左右，就需要将这些日志刷新到磁盘上
      - 事务提交时：redo日志目的就是将未刷新到磁盘的记录保存起来，防止丢失
      - 后台线程不同的刷新：后台有一个线程，大概每秒都会将log buffer里面的redo日志刷新到硬盘上
      - checkpoint
  + redo logfile
    * redo log buffer（user space）写入 redo logfile：先写入 OS Buffer ，然后再通过系统调用 fsync() 将其刷到 redo log file
    * 通过 innodb_flush_log_at_trx_commit 参数配置
    * 存在的意义主要就是降低对 数据页 刷盘的要求
    * write pos 表示 redo log 当前记录的 LSN (逻辑序列号)位置，一边写一边后移，写到第 3 号文件末尾后就回到 0 号文件开头
    * check point 表示数据页更改记录刷盘后对应 redo log 所处的 LSN(逻辑序列号)位置，当前要擦除的位置，也是往后推移并且循环的，擦除记录前要把记录更新到数据文件
    * write pos 和 checkpoint 之间的是“粉板”上还空着的部分，可以用来记录新的操作。如果 write pos 追上 checkpoint，表示“粉板”满了，这时候不能再执行新的更新，得停下来先擦掉一些记录，把 checkpoint 推进一下。
    * 做一次checkpoint分为两步
      - 计算当前系统可以被覆盖的redo日志对应的lsn最大值是多少。redo日志可以被覆盖，意味着他对应的脏页被刷新到磁盘上，只要我们计算出当前系统中最早被修改的oldest_modification, 只要系统中lsn小于该节点的oldest_modification值磁盘的redo日志都是可以被覆盖的。
      - 将lsn过程中的一些数据统计
  + WAL（Write-Ahead Logging）：先写日志，再写磁盘
    * 每执行一条 DML 语句，先将记录写入 redo log buffer，这个时候更新就算完成了
    * 在适当的时候，一次性将多个操作记录写到 redo logfile，而这个更新往往是在系统比较空闲的时候做
  + redo log 实际上记录数据页的变更，而这种变更记录是没必要全部保存，因此 redo log实现上采用了大小固定，循环写入的方式，比如可以配置为一组 4 个文件，每个文件的大小是 1GB，那么总共就可以记录 4GB 的操作。当写到结尾时，会回到开头循环写日志
    * 通过日志组来管理日志文件，是一个逻辑定义，包含若干个日志文件，一个组中的日志文件大小相等，大小通过参数来设置。现在 InnoDB 只⽀持一个日志组。在 MySQL5.5 及之前的版本中，整个日志组的容量不能大于 4GB（实际上是 3.9GB 多，因为还有一些文件头信息等），到了 MySQL 5.6.3 版本之后，整个日志组的容量可以设置得很大，最大可以达到 512GB
    * show variables like 'datadir'
    * 将缓冲区log buffer里面的redo日志刷新到这个两个文件里面，写入方式是循环写入
    * 在 InnoDB 存储引擎中，一般默认包括 2 个日志文件，新建数据库之后，会有名为 ib_logfile0 和 ib_logfile1 的两个文件，如果在启动数据库时，这两个文件不存在，则 InnoDB 会根据配置参数或默认值，重新创建日志文件
  + LSN Log Sequence Number:用来精确记录日志位置信息，且是连续增长的。在 InnoDB 中，大小为 8 个字节的值，它的增长量是根据一个 MTR（mini-transaction）写入的日志量来计算的，写多少日志（单位字节），LSN 就增长多少。日志文件轮循一圈（所有日志文件是以循环方式使用的），那么 LSN 的增长量大约就是整个日志文件的大小（日志文件存在文件头等会占用一部分空间）。它是一个集逻辑意义与物理意义于一身的概念。而在有些数据库中，LSN 是一个完全逻辑的概念，每提交一个物理事务，LSN 就加 1
  + REDO 日志的写入，都是字节连续的，虽然看上去是多个日志文件，但理解的时候，完全可以把它想象成一个文件，对每一文件掐头去尾，把剩下的空间连接起来，就是总的日志空间了。
  + 日志组中的每一个日志文件，都有自己的格式，内部也是按照大小相等的页面切割，但这里的页面大小是 512 个字节，由于历史的原因，考虑到机械硬盘的块大小是 512 字节，日志块大小也如此设计。这是因为写日志其实就是为了提高数据库写入吞吐量，如果每次写入是磁盘块大小的倍数，效率才是最高的，并且日志将逻辑事务对数据库的分散随机写入转化成了顺序的 512 字节整数倍数据的写入，这样就大大提高了数据库的效率。正是因为这个原因，REDO 日志才可以说是数据库管理系统与通过直接写文件来管理数据的最根本的区别之一。
  + 普通页面中，都会有 12 个字节用来存储页面头信息，这些信息主要用于管理这个页面本身的数据存储方式。
    - LOG_BLOCK_HDR_NO：4 个字节，一个与 LSN 有关系的块号。
    - LOG_BLOCK_HDR_DATA_LEN：2 个字节，表示当前页面中存储的日志长度，这个值一般都等于 512-12（12 为页面头的大小），因为日志在相连的块中是连续存储的，中间不会存在空闲空间，所以如果这个长度不为 500，表示此时日志已经扫描完成（Crash Recovery 的工作）。
    - LOG_BLOCK_FIRST_REC_GROUP：2 个字节，表示在当前块中是不是有一个 MTR（关于这个概念的意义，会在下一节中专门介绍）的开始位置。因为一个 MTR 所产生的日志量有可能是超过一个块大小的，那么如果一个 MTR 跨多个块时，这个值就表示了这个 MTR 的开始位置究竟是在哪一个块中。如果为 0，则表示当前块的日志都属于同一个 MTR；而如果其值大于 0 并且小于上面 LOG_BLOCK_HDR_DATA_LEN 所表示的值，则说明当前块中的日志是属于两个 MTR 的，后面 MTR 的开始位置就是 LOG_BLOCK_FIRST_REC_GROUP 所表示的位置。
    - LOG_BLOCK_CHECKPOINT_NO：4 个字节，存储的是检查点的序号。具体什么是检查点，后面会详细介绍。
  * MTR Mini-transaction: MTR，是因为它的意义相当于一个 Mini-transaction，用来保证物理页面写入操作完整性及持久性的机制
    - 不管读还是写，只要使用到底层 Buffer Pool 的页面，都会使用到 MTR，它是上面逻辑层与下面物理层的交互窗口，同时也是用来保证下层物理数据正确性、完整性及持久性的机制。
    - 在访问一个文件页面的时候，系统都会将要访问的页面载入到 Buffer Pool 中，然后才可以访问这个页面，此时可以读取或更新这个页面。在这个页面不断更新变化的过程中，有一个系统一直扮演着很重要的角色，那就是日志系统。因为 InnoDB 采用的也是 LOGWRITE-AHEAD，所以所有的写操作，都会有日志记录，这样才能保证数据库事务的 ACID 特性。
    * redo log 的写入拆成了两个步骤：prepare 和 commit，这就是两阶段提交
      - 提交主要是将所有这个物理事务产生的日志写入到 InnoDB 日志系统的日志缓冲区中，然后等待 srvmasterthread 线程定时将日志系统的日志缓冲区中的日志数据刷到日志文件中，这会涉及日志刷盘时机的问题
      - 日志产生的作用，是将随机页面的写入变成顺序日志的写入，从而用一个速度更快的写入来保证速度较慢的写入的完整性，以提高整体数据库的性能。其根本目的是要将随机变成顺序，所以日志的量才是一个相对固定循环使用的空间
      - 不使用两阶段提交，会导致两份日志恢复的数据不一致：比如先写 redo log，binlog 还没有写入，数据库崩溃重启；或者先写 binlog，redo 还没有写入数据库崩溃重启，都将造成恢复数据的不一致
      - 使用两阶段提交后，就可以保证两份日志恢复的数据一致：只有 binlog 写入成功的情况下，才会提交 redo log，否则 redo log 处于 prepare 状态，事务会回滚，这样一来，就保证了数据的一致性
  + 启动 innodb 的时候，不管上次是正常关闭还是异常关闭，总是会进行恢复操作。因为 redo log记录的是数据页的物理变化，因此恢复的时候速度比逻辑日志(如 binlog )要快很多。重启innodb 时，首先会检查磁盘中数据页的 LSN ，如果数据页的LSN 小于日志中的 LSN ，则会从 checkpoint 开始恢复。
  + 有一种情况，在宕机前正处于checkpoint 的刷盘过程，且数据页的刷盘进度超过了日志页的刷盘进度，此时会出现数据页中记录的 LSN 大于日志中的 LSN，这时超出日志进度的部分将不会重做，因为这本身就表示已经做过的事情，无需再重做。
- undo log：原子性是指对数据库的一系列操作，要么全部成功，要么全部失败，不可能出现部分成功的情况
  + 记录了数据的逻辑变化，比如一条 INSERT 语句，对应一条DELETE 的 undo log ，对于每个 UPDATE 语句，对应一条相反的 UPDATE 的 undo log ，这样在发生错误时，就能回滚到事务之前的数据状态。
  + 是 MVCC(多版本并发控制)实现的关键
* 区别
  - redo log 是 InnoDB 引擎特有的；binlog 是 MySQL 的 Server 层实现的，所有引擎都可以使用。
  - redo log 是物理日志，记录的是“在某个数据页上做了什么修改”；binlog 是逻辑日志，记录的是这个语句的原始逻辑，比如“给 ID=2 这一行的 c 字段加 1 ”
  - redo log 是循环写的（后面的记录会覆盖前面的），不能持久保存全量日志，空间固定会用完；binlog 是可以追加写入的。“追加写”是指 binlog 文件写到一定大小后会切换到下一个，并不会覆盖以前的日志，可以保存全部归档日志
  + redo log 主要适用于数据库崩溃后重启的数据恢复，而 binlog 可用于全量备份，以及创建「数据库分身」，实现主从同步
  + 需要 binlog和 redo log二者同时记录，才能保证当数据库发生宕机重启时，数据不会丢失
- 两个日志是如何写入 `update T set c=c+1 where ID=2;`
  + 执行器先找引擎取 ID=2 这一行。ID 是主键，引擎直接用树搜索找到这一行。
  + 如果 ID=2 这一行所在的数据页本来就在内存中，就直接返回给执行器；否则，需要先从磁盘读入内存，然后再返回。
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
* [基于日志还原数据](https://mp.weixin.qq.com/s/juX32qyu-k_vX6YrPt5bMA)
  - 传统二进制文件
  - GTID二进制文件
    + --include-gtids:包含事务
    + --exclude-gtids:排除事务
    + --skip-gtids:跳过事务
* 参考
  - [三大日志-binlog、redo log和undo log](https://mp.weixin.qq.com/s/_nK9pXOYfmqktZO36PeuAA)

```sh
svi /etc/my.cnf
[server]
server-id=1
log-bin=binlog

systemctl restart mysqld
create database mydb charset utf8mb4;
use mydb;
create table test(id int)engine=innodb charset=utf8mb4;
insert into test values(1),(2),(3),(4);

show master status\G;
# 查找起始点
show binlog events in 'binlog.000001';

mysqlbinlog --start-position=219 --stop-position=1868 /var/lib/mysql/binlog.000001 > /tmp/binlog.sql
set sql_log_bin=0;
source /tmp/binlog.sql
set sql_log_bin=1;

# 基于GTID
server-id=1
log-bin=binlog
gtid_mode=ON
enforce_gtid_consistency=true
log_slave_updates=1

insert into test values(1),(2),(3),(4),(11),(12);
mysqlbinlog --skip-gtids --include-gtids='51d3db57-bf69-11ea-976c-000c2911a022:1-7' /var/lib/mysql/binlog.000003 >  /tmp/gtid.sql
```

## transaction 事务

* MySQL中InnoDB和NDB Cluster存储引擎提供了事务处理能力，以及其他支持事务的第三引擎
* ACID
  - 原子性（atomicity) 一个事务必须被视为一个不可分割的最小工作单元，整个事务中的所有操作要么全部提交成功，要么全部失败回滚，对于一个事务来说，不可能只执行其中的一部分操作。
  - 一致性（consistency) 数据库总是从一个一致性的状态转换到另外一个一致性的状态。
  - 隔离性（isolation) 通常来说，一个事务所做的修改在最终提交以前，对其他事务是不可见的。
  - 持久性（durability) 一旦事务提交，则其所做的修改就会永久保存到数据库中。此时即使系统崩溃，修改的数据也不会丢失。持久性是个有点模糊的概念，因为实际上持久性也分很多不同的级别。有些持久性策略能够提供非常强的安全保障，而有些则未必。而且「不可能有能做到100%的持久性保证的策略」否则还需要备份做什么。
* 脏读 Dirty Read
  - 事务A修改数据之后提交数据之前
  - 另一个事务B来读取数据，如果不加控制，事务B读取到A修改过数据
  - 之后A又对数据做了修改再提交，则B读到的数据是脏数据
* 不可重复读（Nonrepeatable Read）：一个事务内在读取某些数据后的某个时间，再次读取以前读过的数据，却发现其读出的数据已经发生了变更或删除
  - 在这个事务还没有结束时，另外一个事务也访问该同一数据
  - 在第一个事务中的两次读数据之间，由于第二个事务的修改，那么第一个事务两次读到的的数据可能是不一样的
* 幻读（Phantom Read）
  - 事务A在按查询条件读取某个范围的记录时，事务B又在该范围内插入了新的满足条件的记录
  - 事务A再次按条件查询记录时，会产生新的满足条件的记录（幻行 Phantom Row）
* 不可重复读与幻读区别
  - 不可重复读的重点是修改中间有其他事务提交了修改
  - 幻读的重点在于新增或者删除因为中间有其他事务提交了插入/删除
* 隔离级别:对于读数据的定义。四个级别逐渐增强，每个级别解决一个问题。事务级别越高,性能越差
  - 读未提交(Read Uncommitted)：允许脏读，也就是可能读取到其他会话中未提交事务修改的数据
    + 事务一可以获取事务二中未提交的修改
    + 事务一中未提交的修改事务（添加共享锁），事务二同样数据修改会被挂起，等待事务一commit
  - 读已提交(Read Committed)：只能读取到已经提交的数据，Oracle等多数数据库默认都是该级别。造成事务一在同一个transaction中两次读取到的数据不同，这就是不可重复读问题。并且在对表进行修改时，会对表数据行加上行共享锁
    + 数据的读取都是不加锁的，但是数据的写入、修改和删除是需要加锁的
  - 可重复读(Repeated Read)：在同一个事务内的查询都是事务开始时刻一致的，InnoDB默认级别。在SQL标准中，该隔离级别消除了不可重复读，存在幻读
    + 概念是一事务的多个实例在并发读取数据时，会看到同样的数据行
    + 当两个事务同时进行时，其中一个事务修改数据对另一个事务不会造成影响，即使修改的事务已经提交也不会对另一个事务造成影响。
    + 两个事务：事务二修改提交后，事务一不提交无法获取事务二的更新；事务一的修改未提交，事务二的修改无法成功等待事务一提交或者超时
    + 读到的数据可能是历史数据，是不及时的数据，不是数据库当前的数据
    + 对于这种读取历史数据的方式叫快照读 (snapshot read)，而读取数据库当前版本数据的方式，叫当前读 (current read)
      * 每行数据的最后加两个隐藏列,一个保存行的创建事务id，一个保存行的删除事务id.事务id，在mysql内部是全局唯一递增的
      * 始终都是查找的之前的那个快照
    + 只会查询创建时间的事务id小于等于当前事务id的行，这样可以确保这个行是在当前事务中创建，或者是之前创建的
    + 如果某个事务执行期间，别的事务更新了一条数据:插入了一行记录，然后将新插入的记录的创建时间设置为新的事务的id，同时将这条记录之前的那个版本的删除时间设置为新的事务的id
  - 串行读(Serializable)：完全串行化的读，每次读都需要获得表级共享锁，读写相互都会阻塞。
    + 读加共享锁，写加排他锁，读写互斥。使用的悲观锁的理论，实现简单，数据更加安全，但是并发能力非常差。如果你的业务并发的特别少或者没有并发，同时又要求数据及时可靠的话，可以使用这种模式。
    + 不要看到select就说不会加锁了，在Serializable这个级别，还是会加锁的
  - 当隔离级别是可重复读，且禁用`innodb_locks_unsafe_for_binlog`的情况下，在搜索和扫描index的时候使用的 `next-key locks`可以避免幻读。在默认的可重复读的隔离级别里，可以使用加锁读去查询最新的数据（提交读）
    + Next-Key锁是行锁和GAP（间隙锁）的合并：行锁可以防止不同事务版本的数据修改提交时造成数据冲突的情况。但如何避免别的事务插入数据就成了问题
    + 行锁防止别的事务修改或删除，GAP锁防止别的事务新增，行锁和GAP锁结合形成的的Next-Key锁共同解决了RR级别在写数据时的幻读问题
* MySQL默认采用自动提交AUTOCOMMIT模式（autocommit参数默认是on），作用是每一条单独的查询都是一个事务，并且自动开始，自动提交（执行完以后就自动结束了，如果要适用select for update，而不手动调用 start transaction，这个for update的行锁机制等于没用，因为行锁在自动提交后就释放了）
* 事务隔离级别和锁机制即使不显式调用start transaction，这种机制在单独的一条查询语句中也是适用的
* 通过 set autocommit=0 可以取消自动提交，直到 set autocommit=1 才会提交；autocommit 标记是针对每个连接而不是针对服务器的。
* 数据定义语言（DDL）语句不能被回滚，比如创建或取消数据库的语句，和创建、取消或更改表或存储的子程序的语句
* 两段锁协议可以保证事务的并发调度是串行化（串行化很重要，尤其是在数据恢复和备份的时候）
  - 加锁阶段
    + 读操作之前要申请并获得S锁（共享锁，其它事务可以继续加共享锁，但不能加排它锁）
    + 写操作之前要申请并获得X锁（排它锁，其它事务不能再获得任何锁）
    + 加锁不成功，则事务进入等待状态，直到加锁成功才继续执行
  - 解锁阶段：当事务释放了一个封锁以后，事务进入解锁阶段
* 尽量不要在同一个事务中使用多种存储引擎，MySQL服务器层不管理事务，事务是由下层的存储引擎实现的。如果在事务中混合使用了事务型和非事务型的表。需要回滚，非事务型的表上的变更就无法撤销，这会导致数据库处于不一致的状态，这种情况很难修复，事务的最终结果将无法确定
* 指令
  - START TRANSACTION - 指令用于标记事务的起始点。
  - SAVEPOINT - 指令用于创建保留点。
  - ROLLBACK TO - 指令用于回滚到指定的保留点；如果没有设置保留点，则回退到 START TRANSACTION 语句处。
  - COMMIT - 提交事务
* 实现原理
  - redo log和undo log来保证事务的原子性、一致性和持久性，同时采用预写日志（WAL）方式将随机写入变成顺序追加写入，提升事务性能。而隔离性是通过锁技术来保证的。
    + 原子性：使用 undo log来实现，如果事务执行过程中出错或者用户执行了rollback，系统通过undo log日志返回事务开始的状态。
    + 持久性：使用 redo log来实现，只要redo log日志持久化了，当系统崩溃，即可通过redo log把数据恢复。
    + 隔离性：通过锁以及MVCC来实现。
    + 一致性：通过回滚、恢复以及并发情况下的隔离性，从而实现一致性
  - redo log是重做日志，提供前滚操作
    + redo log通常是物理日志，记录的是数据页的物理修改，而不是某一行或某几行修改成怎样怎样，用来恢复提交后的物理数据页(恢复数据页，且只能恢复到最后一次提交的位置)
    + 包含两部分
      * 内存中的日志缓冲(redo log buffer)，该部分日志是易失性的
      * 磁盘上的重做日志文件(redo log file)，该部分日志是持久的。
    + 当需要修改事务中的数据时，先将对应的redo log写入到redo log buffer中，然后才在内存中执行相关的数据修改操作。InnoDB通过“force log at commit”机制实现事务的持久性，即在事务提交的时候，必须先将该事务的所有redo log都写入到磁盘上的redo log file中，然后待事务的commit操作完成才算整个事务操作完成。
    + 每次将redo log buffer中的内容写入redo log file时，都需要调用一次fsync操作，以此确保redo log成功写入到磁盘上（内容的流向为：用户态的内存->操作系统的页缓存->物理磁盘）。因此，磁盘的性能在一定程度上也决定了事务提交的性能。这里还可以通过innodb_flush_log_at_trx_commit来控制redo log刷磁盘的策略
  - undo log是回滚日志，提供回滚操作
    + 用来回滚行记录到某个版本。undo log一般是逻辑日志，根据每行记录进行记录。可以认为当delete一条记录时，undo log中会记录一条对应的insert记录，反之亦然，当update一条记录时，它记录一条对应相反的update记录。
    + 实现回滚和多版本并发控制（MVCC, Multi-Version Concurrency Control）
    + 在数据修改的时候，不仅记录了redo log，还记录了相对应的undo log，如果因为某些原因导致事务失败或回滚了，可以借助该undo log进行回滚。
    + 当执行rollback时，就可以从undo log中的逻辑记录读取到相应的内容并进行回滚。有时候应用到行版本控制的时候，也是通过undo log来实现的：当读取的某一行被其他事务锁定时，它可以从undo log中分析出该行记录以前的数据是什么，从而提供该行版本信息，让用户实现非锁定一致性读取。
* MVCC 多版本并发控制
  - 依赖了undo log、隐藏字段（DB_TRX_ID,DB_ROLL_PTR,DB_ROW_ID）、Read View等。
  - 在使用READ COMMITTD、REPEATABLE READ这两种隔离级别的事务下执行一致性读操作有了保证；为了查询一些正在被另一个事务更新的行，并且可以看到它们被更新之前的值。这是一个可以用来增强并发性的强大技术，因为这样的一来的话查询就不用等待另一个事务释放锁，使不同事务的读-写、写-读操作并发执行，从而提升系统性能。
  - 这里的读指的是“快照读”。普通的SELECT操作就是快照读，有的地方也称之为“一致性读”或者“一致性无锁读”。
    + 不会对表中的任何记录做加锁动作，即不加锁的非阻塞读。快照读的前提是隔离级别不是串行化级别，串行化级别下的快照读会退化成当前读。
    + 之所以出现快照读的情况，是基于提高并发性能的考虑，这里可以认为MVCC是行锁的一个变种，但它在很多情况下，避免了加锁操作，降低了开销。
    + 既然是基于多版本，即快照读可能读到的并不一定是数据的最新版本，而有可能是之前的历史版本。
  - 对应的还有“当前读”。类似UPDATE、DELETE、INSERT、SELECT...LOCK IN SHARE MODE、SELECT...FOR UPDATE这些操作就是当前读。为什么叫当前读？就是它读取的是记录的最新版本，读取时还要保证其他并发事务不能修改当前记录，会对读取的记录进行加锁。

```sql
BEGIN | START TRANSACTION #显式地开启一个事务；
COMMIT / COMMIT WORK # 二者是等价的。提交事务，并使已对数据库进行的所有修改成为永久性的；
ROLLBACK / ROLLBACK WORK #回滚会结束用户的事务，并撤销正在进行的所有未提交的修改；
SAVEPOINT identifier # 在事务中创建一个保存点，一个事务中可以有多个 SAVEPOINT；
RELEASE SAVEPOINT identifier # 删除一个事务的保存点；
ROLLBACK TO identifier # 把事务回滚到标记点；
SET TRANSACTION # 用来设置事务的隔离级别。InnoDB 存储引擎提供事务的隔离级别有READ UNCOMMITTED、READ COMMITTED、REPEATABLE READ 和 SERIALIZABLE

CREATE TABLE user (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `name` varchar(255) NOT NULL,
 PRIMARY KEY (`id`),
 UNIQUE `uniq_name` USING BTREE (name)
) ENGINE=`InnoDB` AUTO_INCREMENT=10 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

set autocommit=0; # 关闭事务自动提交
# 设置事务隔离级别与查看
set session transaction isolation level read uncommitted;
select @@global.tx_isolation;
select @@session.tx_isolation;
select @@tx_isolation;

start transaction; # 事务一
insert into user(name) values('ziwenxie');

set session transaction isolation level read uncommitted;
# Read Uncommitted：事务二中会读取到事务一中没有commit的数据，这就是脏读。
# Read Committed：事务一提交后影响到事务二的查询结果，前后查询的结果不一致
# REPEATABLE-READ：事务二中无法读取到事务一中没有commit的数据
start transaction; # 事务二
select * from user;

set session transaction isolation level repeatable read;

# RC级别：
select id,class_name,teacher_id from class_teacher where teacher_id=30; # 2 初三二班 30
begin;
update class_teacher set class_name='初三四班' where teacher_id=30;  # 事务一更新

insert into class_teacher values (null,'初三二班',30); # 事务二插入
commit;
select id,class_name,teacher_id from class_teacher where teacher_id=30; #  2 初三四班 30   10 初三二班 30
# RR级别：事务A在update后加锁，事务B无法插入新数据，这样事务A在update前后读的数据保持一致，避免了幻读。这个锁，就是Gap锁。

START TRANSACTION;
SELECT balance FROM CMBC WHERE username='lemon';
UPDATE CMBC SET balance = balance - 1000000.00 WHERE username = 'lemon';
UPDATE ICBC SET balance = balance + 1000000.00 WHERE username = 'lemon';
COMMIT;

-- 开始事务
START TRANSACTION;
-- 插入操作 A
INSERT INTO `user` VALUES (1, 'root1', 'root1', 'xxxx@163.com');
-- 创建保留点 updateA
SAVEPOINT updateA;
-- 插入操作 B
INSERT INTO `user` VALUES (2, 'root2', 'root2', 'xxxx@163.com');
-- 回滚到保留点 updateA
ROLLBACK TO updateA;
-- 提交事务，只有操作 A 生效
COMMIT;
```

## 锁

并发控制:确保在多个事务同时存取数据库中同一数据时不破坏事务的隔离性和统一性

* 类型
  
  - 共享锁 Shared Locks（S锁，MyISAM 叫做读锁）：由读表操作加上的锁，加锁后其他用户只能获取该表或行的共享锁，不能获取排它锁，也就是说只能读不能写
  - 排它锁 Exclusive Locks（X锁，MyISAM 叫做写锁）：由写表操作加上的锁，加锁后其他用户不能获取该表或行的任何锁，允许事务删除或更新一行数据
  - 事务A首先获取了一条记录的S锁之后，如果事务B想要再获取一个记录的X锁，那么此操作会被阻塞，直到事务A提交之后将S锁释放掉。
  - 如果事务A首先获取了一条记录的X锁之后，那么不管事务B接着想获取该记录的S锁还是X锁都会被阻塞，直到事务A提交。

* 颗粒度
  
  - 表锁（table-level locking）开销小，加锁快；不会出现死锁；锁定力度大，发生锁冲突概率高，并发度最低。MyISAM InnoDB 和 MEMORY
    + 通过总是一次性同时获取所有需要的锁以及总是按相同的顺序获取表锁来避免死锁
    + 表级锁更适合于以查询为主，并发用户少，只有少量按索引条件更新数据的应用，如Web 应用
  - 行锁（page-level locking）开销大，加锁慢；会出现死锁；锁定粒度小，发生锁冲突的概率低，并发度高；BDB
    + 最大程度支持并发，同时也带来了大的锁开销
    + 在 InnoDB 中，除单个 SQL 组成的事务外，锁是逐步获得的，这就决定了在 InnoDB 中发生死锁是可能的
    + 行级锁只在存储引擎层实现，而Mysql服务器层没有实现
    + 适合于有大量按索引条件并发更新少量不同数据，同时又有并发查询的应用，如一些在线事务处理（OLTP）系统
    + 优点
      * 回滚时只有少量的更改
      * 可以长时间锁定单一的行
    + 缺点
      * 比页级或表级锁定占用更多的内存
      * 当在表的大部分中使用时，比页级或表级锁定速度慢，因为你必须获取更多的锁。
      * 如果你在大部分数据上经常进行GROUP BY操作或者必须经常扫描整个表，比其它锁定明显慢很多。
      * 用高级别锁定，通过支持不同的类型锁定，你也可以很容易地调节应用程序，因为其锁成本小于行级锁定。
  - 页锁开销和加锁速度介于表锁和行锁之间；会出现死锁；锁定粒度介于表锁和行锁之间，并发度一般

* 意向锁（表级别锁）
  
  - InnoDB存储引擎还支持多粒度锁定，这种锁定允许事务在行级上的锁和表级上的锁同时存在
  - 意向共享锁（IS 锁）：事务想要获取一张表的几行数据的共享锁，事务在给一个数据行加共享锁前必须先取得该表的 IS 锁。
  - 意向排他锁（IX 锁）：事务想要获取一张表中几行数据的排它锁，事务在给一个数据行加排它锁前必须先取得该表的 IX 锁。
  - IS锁和IX锁的使命只是为了后续在加表级别的S锁和X锁时判断表中是否有已经被加锁的记录，以避免用遍历的方式来查看表中有没有上锁的记录

* 抽象锁(不真实存在)
  
  - 悲观锁 Pessimistic Concurrency Control PCC：一种并发控制的方法。在整个数据处理过程中，将数据处于锁定状态，阻止一个事务以影响其他用户的方式来修改数据
    + 先获取锁，再操作修改，数据库级别
    + 如果一个事务执行的操作都某行数据应用了锁，那只有当这个事务把锁释放，其他事务才能够执行与该锁冲突的操作
    + 条件
      * 要使用悲观锁，必须关闭mysql数据库自动提交属性，因为MySQL默认使用autocommit模式 `set autocommit=0`
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
  - 乐观锁 Optimistic Concurrency Control OCC：假设多用户并发的事务在处理时不会彼此互相影响，各事务能够在不产生锁的情况下处理各自影响的那部分数据
    + 先修改，保存时判断是够被更新过，应用级别
    + 实现
      - 当读取数据时，将版本标识的值一同读出，数据每更新一次，同时对版本标识进行更新
      - 当提交更新的时候，判断数据库表对应记录的当前版本信息与第一次取出来的版本标识进行比对
      - 如果数据库表当前版本号与第一次取出来的版本标识值相等，则予以更新
      - 如果不一致，即可认为老版本的数据已经被并发修改掉而不存在了，此时认为获取锁失败，需要回滚整个业务操作并可根据需要重试整个过程
    + 方法
      * 使用版本号version：为数据增加一个版本标识
        - SELECT时，读取创建版本号<=当前事务版本号，删除版本号为空或>当前事务版本号
        - INSERT时，保存当前事务版本号为行的创建版本号
        - DELETE时，保存当前事务版本号为行的删除版本号
        - UPDATE时，插入一条新纪录，保存当前事务版本号为行创建版本号，同时保存当前事务版本号到原来删除的行
      * `update total_amount = total_amount - amount where total_amount > amount`
      * 使用时间戳timestamp
      * 通过CAS算法实现
    + 适合
      * 在取锁失败概率比较小的场景，可以提升系统并发性能
      * 写比较少的情况下
    + MVCC并发控制
      * MVCC可以实现事务中的查询不用加锁，优化事务性能
      * 只在COMMITTED READ（读提交）和REPEATABLE READ（可重复读）两种隔离级别下工作
    + CAS compare and swap
      * 需要读写的内存值 V
      * 进行比较的值 A
      * 拟写入的新值 B
    + 优缺点
      * 通过MVCC (Multi-Version Concurrency Control) ，虽然每行记录都需要额外的存储空间，更多的行检查工作以及一些额外的维护工作，但可以减少锁的使用，大多数读操作都不用加锁，读数据操作很简单，性能很好，并且也能保证只会读取到符合标准的行，也只锁住必要行。
        - 读不加锁，读写不冲突。在读多写少的OLTP应用中，读写不冲突是非常重要的，极大的增加了系统的并发性能
      + 加大了系统的整个吞吐量。上层应用会不断的进行retry，这样反倒是降低了性能，所以这种情况下用悲观锁就比较合适
+ InnoDB行锁算法
  
  - Record lock：单个行记录上的锁
  - Gap lock 间隙锁：在记录之间加锁，或者在第一个记录之前加锁，亦或者在最后一个记录之后加锁，即锁定一个范围，而非记录本身
    + 目的是为了阻止多个事务将记录插入到同一范围内，而这会导致幻读问题的产生
    + 显式关闭gap锁：（除了外键约束和唯一性检查外，其余情况仅使用record lock）
      * 将事务隔离级别设置为RC
      * 将参数innodb_locks_unsafe_for_binlog设置为1
  - Next-key lock：record+gap 锁定一个范围，包含记录本身
    + Innodb对于行的查询使用next-key lock
    + Next-locking keying为了解决Phantom Problem幻读问题
    + 当查询的索引含有唯一属性时，将next-key lock降级为record key
  - SELECT ... LOCK IN SHARE MODE：在读取到的行上设置共享锁。其他会话可以读取行，也可以继续给行加共享锁，但是在当前事务提交之前其他会话不能修改加了共享锁的行。如果这些行中的任何一个被尚未提交的另一个事务更改，则当前查询将等待直到该事务结束，然后使用最新值。
  - SELECT ... FOR UPDATE 用排他锁锁定行和任何关联的索引条目，就像在这些行上执行UPDATE语句一样。禁止其他事务在这些加了锁的行上进行UPDATE、执行LOCK IN SHARE MODE或者读取某些事务隔离级别的数据。
* LOCK TABLES 和 UNLOCK TABLES:服务器层（MySQL Server层）实现
  
  - LOCK TABLES 可以锁定用于当前线程的表。如果表被其他线程锁定，则当前线程会等待，直到可以获取所有锁定为止
  - UNLOCK TABLES 可以释放当前线程获得的任何锁定。当前线程执行另一个 LOCK TABLES 时，或当与服务器的连接被关闭时，所有由当前线程锁定的表被隐含地解锁
  - 语法
    + 对 InnoDB 表加锁时要注意，要将 AUTOCOMMIT 设为 0
    + 事务结束前，不要用 UNLOCK TABLES 释放表锁，因为 UNLOCK TABLES会隐含地提交事务；
    + COMMIT 或 ROLLBACK 并不能释放用 LOCK TABLES 加的表级锁，必须用UNLOCK TABLES 释放表锁
  - 场景
    + 同时取得所有涉及到表的锁，并且 MySQL 不支持锁升级

* 读取方式
  
  - 快照读 (snapshot read)：读取的是记录的可见版本 (有可能是历史版本)，不用加锁（共享读锁s锁也不加，所以不会阻塞其他事务的写）,执行select的时候，innodb默认会执行
    
    + 数据虽然是一致的，但是数据是历史数据
    + 只是简单的 select ，不包括 select … lock in share mode, select … for update
    + 事务commit未完成时，会利用行锁锁住满足where条件的行，并且对满足where条件的行的两边数据加上间隙锁。
    + 这时候另一个事务操作前面已经上了间隙锁的行就会Lock wait timeout exceeded
  
  - 当前读 (current read)：读取的是记录的最新版本，并且，当前读返回的记录，都会加上锁，保证其他事务不会再并发修改这条记录
    
    + 默认会执行当前读会加锁，也就是会读取最新的记录，也就是别的事务提交的数据也可以看到
    
    + select … lock in share mode
    
    + select … for update
    
    + insert
    
    + update：执行当前读，然后把返回的数据加锁
    
    + delete
    
    + 当select for update中的where条件无法筛选出记录时，这时在有多个线程执行上面的acquire方法时是可能会出现死锁
    
    + LOCK_GAP类型的锁只要不带有插入意向标识，不必等待其它锁（表锁除外）
    
    + 两个 session同时更新已存在数据，事务238434 事务(238435)
    
    + `show engine innodb status`
    
    + 事务238434 在尝试插入'ddd',1时，由于发现其他事务(238435)已经有这个区间的gap锁，因此innodb给事务238434上了插入意向锁，锁的模式为`LOCK_X | LOCK_GAP | LOCK_INSERT_`INTENTION，等待事务238435释放掉gap锁
    
    + 事务238435在插入时也发现了事务238434的gap锁，同样加上了插入意向锁，等待事务238434释放掉gap锁。因此出现死锁的情况
    
    + 在死锁检测时，被探测到形成等待环。因此InnoDB会选择一个事务作为victim进行回滚。其过程大致如下：
      
      * session2尝试获取插入意向锁，需要等待session1的gap锁
      * session1事务的插入意向锁处于等待中
      * session1事务插入意向锁在等待session2的gap锁
      * 形成环路，检测到死锁
    
    + 解决办法:将事务隔离级别降低到Read Committed

* 建议
  
  - 尽量使用较低隔离级别
  - 精心设计索引，并尽量使用索引访问数据，使加锁更精确，减少锁冲突机会
  - 选择合理的事务大小，小事务发生锁冲突的几率也更小
  - 给记录集显示加锁时，最好一次性请求足够级别的锁。比如要修改数据的话，最好直接申请排他锁，而不是先申请共享锁，修改时再请求排他锁，这样容易产生死锁
  - 不同的程序访问一组表时，应尽量约定以相同的顺序访问各表，对一个表而言，尽可能以固定的顺序存取表中的行。这样可以大大减少死锁的机会
  - 尽量用相等条件访问数据，这样可以避免间隙锁对并发插入的影响
  - 不要申请超过实际需要的锁级别
  - 除非必须，查询时不要显示加锁
  - 对于一些特定的事务，可以使用表锁来提高处理速度或减少死锁的可能

* [8.0行锁观测方式](https://mp.weixin.qq.com/s/p3vYV7sXvKGU_A689txnbQ)
  
  - 8.0新增了全新的锁观测方式，在performance_schema下新增了data_locks表和data_lock_waits表
  - data_locks
    + ENGINE：持有或请求锁定的存储引擎
    + ENGINE_LOCK_ID：存储引擎持有或请求的锁的ID，锁ID格式是内部的，随时可能更改。
    + ENGINE_TRANSACTION_ID：请求锁定的事务存储引擎内部ID，可以将其视为锁的所有者
    + THREAD_ID：对应事务的线程ID，如果需要获取更详细的信息，需要关联threads表的THREAD_ID
    + EVENT_ID：指明造成锁的EVENT_ID，THREAD_ID+EVENT_ID对应parent EVENT，可以在以下几张表内获得信息
      * events_waits_xx表查看等待事件
      * events_stages_xxx查看到了哪个阶段
      * events_statements_xx表查看对应的SQL语句
      * events_transactions_current对应查看事务信息
    + OBJECT_SCHEMA：对应锁表的schema名称
    + OBJECT_NAME：对应锁的表名
    + PARTITION_NAME：对应锁的分区名
    + SUBPARTITION_NAME：对应锁的子分区名
    + INDEX_NAME：锁对应的索引名称，InnoDB表不会为NULL
    + OBJECT_INSTANCE_BEGIN：锁对应的内存地址
    + LOCK_TYPE：对应的锁类型，对InnoDB而言，可为表锁或者行锁
    + LOCK_MODE：锁模式，对应值可能为S[,GAP], X[, GAP], IS[,GAP], IX[,GAP], AUTO_INC和UNKNOWN
    + LOCK_STATUS：锁状态，可能为GRANTED或者WAITING
    + LOCK_DATA：锁对应的数据，例如如果锁定的是主键，那么该列对应的就是加锁的主键值
  - data_lock_waits
    + ENGINE：请求的锁的引擎
    + REQUESTING_ENGINE_LOCK_ID：请求的锁在存储引擎中的锁ID
    + REQUESTING_ENGINE_TRANSACTION_ID：请求锁的事务对应的事务ID
    + REQUESTING_THREAD_ID：请求锁的线程ID
    + REQUESTING_EVENT_ID：请求锁的EVENT ID
    + REQUESTING_OBJECT_INSTANCE_BEGIN：请求的锁的内存地址
    + BLOCKING_ENGINE_LOCK_ID：阻塞的锁的ID，对应data_locks表的ENGINE_LOCK_ID列
    + BLOCKING_ENGINE_TRANSACTION_ID：锁阻塞的事务ID
    + BLOCKING_THREAD_ID：锁阻塞的线程ID
    + BLOCKING_EVENT_ID：锁阻塞的EVENT ID
    + BLOCKING_OBJECT_INSTANCE_BEGIN：阻塞的锁内存地址

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

## 分块索引

* 减少索引项个数，对数据集进行分块，并使其分块有序，然后再给每个分块建立一个索引项（索引值是分块中最大关键码），至于分块内部，则不管其有序性，从而减少索引项的个数。
* 在查找的时候在索引项中通过二分查找找到指定索引项，然后根据该索引项中的关键码去相应分块遍历查找指定元素
* 先决条件
  - 块内无序。即每一块内的记录不要求有序。当然，有序更理想，只不过要花费大量时间和空间的代价。
  - 块间有序。即要求后一块的所有关键字都大于前一块的所有关键字。只有块间有序，才能给查找带来效率
* 索引项数据项：
  - 最大关键码：存储每一块中的最大关键字。这样做的好处是在它之后的下一块中最小的关键字也能比这一块最大的关键字要大。
  - 块长：存储块中的记录个数，以便于循环时使用。
  - 块首指针：用于指向块首数据元素的指针，便于开始对这一块的记录开始遍历。
* 查找
  - 在分块索引表中查找要查找关键字所在的块。由于块间有序，所以可以通过二分查找快速定位（通过不小于给定值的第一个元素，不大于给定值的最后一个元素确定区间）。
  - 根据块首指针找到相应的块，并在块中顺序查找指定值（即关键码，块中无序所以只能顺序查找）

### B-Tree

* 定义：一种多路搜索树（并不是二叉的），一颗M阶的B-树
  
  - 定义任意非叶子结点最多只有M个儿子,且M>2；
  
  - 根结点的儿子数为[2, M]；
  
  - 除根结点以外的非叶子结点的儿子数为[M/2, M]；
  
  - 每个结点存放至少M/2-1（取上整）和至多M-1个关键字；（至少2个关键字）
  
  - 非叶子结点的关键字个数=指向儿子的指针个数-1；
  
  - 非叶子结点的关键字：K[1], K[2], …, K[M-1]；且K[i] < K[i+1]；
  
  - 非叶子结点的指针：P[1], P[2], …, P[M]；其中P[1]指向关键字小于K[1]的子树，P[M]指向关键字大于K[M-1]的子树，其它P[i]指向关键字属于(K[i-1], K[i])的子树；
  
  - 所有叶子结点位于同一层
  
  - 每个中间节点都包含 k-1 个元素和 k 个孩子，其中 m/2 ≥ k ≤ m；
  
  - 每个叶子节点都包含 k-1 个元素，其中 m/2 ≥ k ≤ m；
  
  - 每个节点中存放的元素都是按照从小到大升序排序

* B-tree数据存储是有序的，按照顺序保存了索引的列，加速了数据访问
  
  - 所有键值分布在整个树中
  - 任何关键字出现且只出现在一个节点中
  - 搜索有可能在非叶子节点结束
  - 在关键字全集内做一次查找，性能逼近二分查找算法

* 结构
  
  - 物理结构：分块索引->数据页目录索引页->数据库记录所在页->叶子节点
  - 最外层浅蓝色磁盘块1里有数据17、35（深蓝色）和指针P1、P2、P3（黄色）。P1指针表示小于17的磁盘块，P2是在17-35之间，P3指向大于35的磁盘块。真实数据存在于子叶节点也就是最底下的一层3、5、9、10、13……非叶子节点不存储真实的数据，只存储指引搜索方向的数据项
  - 查找过程：例如搜索28数据项，首先加载磁盘块1到内存中，发生一次I/O，用二分查找确定在P2指针。接着发现28在26和30之间，通过P2指针的地址加载磁盘块3到内存，发生第二次I/O。用同样的方式找到磁盘块8，发生第三次I/O。降低时间复杂度

* 多路自平衡的搜索树,允许每个节点有更多的子节点

* 根节点一般存储在内存中，普通节点和叶子结点保存在硬盘中

* 使用B-tree索引的查询类型，很好用于全键值、键值范围或键前缀查找
  
  - 只有在使用了索引的最左前缀的时候才有用
  - 查找没有从索引列的最左边开始,没有什么用处;不能跳过索引的列

* B+tree,是 B 树的变体，也是一种多路平衡查找树
  
  - 从根节点到每个叶子节点的高度差值不超过1，而且同层级的节点间有指针相互链接，是有序的
  - 与 B 树的不同在于
    + B树：每个节点都存储key和data，所有节点组成这棵树，并且叶子节点指针为nul，叶子结点不包含任何关键字信息
    + B+树：所有的叶子结点中包含了全部关键字信息，及指向含有这些关键字记录的指针，且叶子结点本身依关键字的大小自小而大的顺序链接 **内部节点不保存数据，只用于索引，所有数据记录都保存在叶子节点中**
      * 所有的非终端结点可以看成是索引部分，结点中仅含有其子树根结点中最大（或最小）关键字。(而B 树的非终节点也包含需要查找的有效信息)
    + 所有关键字存储在叶子节点，非叶子节点不存储真正的 data
    + 为所有叶子节点增加了一个链指针
  - 索引不是数据库索引，而是数据页索引。数据库索引和数据都是作为数据记录存储在叶子节点的
  - 数据页：将一张表的数据记录划分成若干个数据页，然后以页为单位在磁盘和内存之间进行数据交换（不管是写入还是读取，都是以页为单位，以 InnoDB 为例，一个数据页的大小默认是 16 KB，即每次都是一次性从磁盘读取 16 KB 大小的数据，写入亦然）
  - 虽然所有的节点对应的都是数据页结构，但是 MySQL 底层会通过一个 record_type 来标识不同的数据页类型，值为 0 表示这个数据页存放的是普通的数据记录（包含数据表索引和数据），值为 1 表示这个数据页存放的是数据页目录索引，在这些数据页节点中不包含数据记录。
  - 所有关键字存储在叶子节点,内部节点(非叶子节点并不存储真正的 data)
  - 为所有叶子结点增加了一个链指针
  - 这么设计的原因是：为了简化查询和维护逻辑，避免在不同节点之间来回访问，另外，这种设计也方便进行带有范围的区间查询
  - 每个节点对应一个数据页结构，对于非叶子节点由于不包含用户记录，只存放数据页索引，所以可以存放非常大的索引范围，这也进一步优化了 B+ 树的查询，减少磁盘 IO
  - 叶子节点而言，每个数据页中存放的记录都以索引字段为标识进行升序排序，这样，一旦通过索引定位到数据记录所在的数据页，就可以在数据页内部通过二分查找快速找到对应的数据记录，效率非常高
  - 一个层高为 2 的 B+ 树，可以存放 10 万条记录，如果层高是 3 的话，则可以存放 1 亿条记录
  - 所有类型的B+树都有一个称为根节点的入口点,根页包含了索引ID、INodes数量等信息。INode页包含关于页本身、值的范围等信息。
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
    + 磁盘存储数据最小单元是扇区，大小是512字节，而文件系统（例如XFS/EXT4）最小单元是块，一个块的大小是4k,存储引擎最小储存单元——页（Page），InnoDB存储引擎也有自己的最小储存单元——页（Page），一个页的大小是16K（可以通过配置参数 innodb_page_size 调整），所有数据文件（后缀为ibd的文件），始终都是16384（16k）的整数倍 `show variables like 'innodb_page_size'`
    + 还有存放键值+指针的页，如图中page number=3的页，该页存放键值和指向数据页的指针，这样的页由N个键值+指针组成。当然它也是排好序的。这样的数据组织形式，称为索引组织表
    + InnoDB主键索引B+树的高度:
      * 根页偏移量为64的地方存放了该B+树的page level，B+树的高度=page level+1
    + 每张表的根页位置在表空间文件中是固定（约定page number为3的代表主键索引的根页），通过二分查找法，查找到目标页的指针，在目标页中查找
    + 总记录数为：根节点指针数*单个叶子节点记录行数。单个叶子节点（页）中的记录数=16K/1K=16
    + 非叶子节点能存放多少指针
      * 主键ID为bigint类型，长度为8字节，而指针大小在InnoDB源码中设置为6字节，这样一共14字节。一个页中能存放16384/14=1170的单元
      * 数据记录大小通常就是1K左右，高度为2的B+树，能存放1170*16=18720。高度为3的B+树可以存放：1170*1170*16=21902400条这样的记录
      * 在InnoDB中B+树高度一般为1-3层，就能满足千万级的数据存储
    - 一次页的查找代表一次IO，所以通过主键索引查询通常只需要1-3次IO操作即可查找到数据
  - B树不管叶子节点还是非叶子节点，都会保存数据，这样导致在非叶子节点中能保存的指针数量变少，要保存大量数据，只能增加树的高度，导致IO操作变多，查询性能变低
  - 包含主键索引的数据表，当插入记录到数据表时（对于自增字段，不指定 ID 字段值的情况下，系统会自动获取当前 ID 最大值加 1 作为插入记录的 ID 值），会先在当前主键索引对应 B+ 树叶子节点最后一个数据页中查看是否还有剩余空间，如果有的话，则插入到对应数据页最后一条数据的后面（B+ 树叶子节点中的数据记录会按照索引字段值升序排列，而主键 ID 是自增的，所以肯定是已存在记录中最大的，前面数据页定位的逻辑也是这样），否则的话，需要新创建一个数据页来存储数据。
  - 如果插入的记录指定了 id 字段值，并且这个 id 值不是当前数据记录中最大的（数据表由于删除过记录存在空洞），则需要定位到要插入的数据页和插入位置进行插入，如果对应数据页没有剩余空间，则需要开辟新的数据页，插入位置之后的数据记录也要调整以便可以顺利将待插入记录插入进来（这个过程叫做页分裂，显然，页分裂性能损耗较大，有页分裂就有与之相对的页合并，当删除记录较多，数据页存在较多空洞时，就会进行页合并操作），从而确保叶子节点里的数据记录是按照主键索引升序排列的。另外，存储在叶子节点数据页中的数据记录显然是一个单链表结构，这样设计的好处是避免每次插入、删除记录需要移动该位置之后的所有记录。

* 每次 IO 只读取一个数据页大小的数据，如果要读取的数据大于一个数据页，则会导致多次IO。因此要尽量让每个节点的数据大小刚好等于一个数据页大小，即每访问一个节点只需一次 IO。

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

* 参考
  
  - [为什么 MySQL 使用 B+ 树](https://draveness.me/whys-the-design-mysql-b-plus-tree/)
  - [B+树算法在mysql中能存多少行数据](https://blog.csdn.net/luoyang_java/article/details/92781164)

![索引结构](../_static/b tree.jpeg "Optional title")
![index](../_static/index.jpg "index")
![B+tree](../_static/B+tree.jpg "B+tree")
![B+tree_insert](../_static/B+tree_insert.jpg "B+tree_insert")
![B+tree_insert_1](../_static/B+tree_insert_1.jpg "B+tree_insert_1")
![B+tree_rorate](../_static/B+tree_rorate.jpg "B+tree_rorate.jpg")
![B+tree_storage](../_static/B+tree_storage.jpg "B+tree_storage.jpg")

```sql
CREATE TABLE  People (
    last_name varchar (50) not null,
    first_name varchar (50) not null,
    dob date not null,
    gender enum (`m` , `f`) not null,
    key (last_name , first_name , dob)
);

SELECT b.name,a.name,index_id,type,a.space,a.PAGE_NO from information_schema.INNODB_SYS_INDEXES a,information_schema.INNODB_SYS_INDEXES a
where a.table_id=b.table_id and a.space <> 0;
```

### 存储引擎

不同数据引擎数据的存储格式,数据结构的实现,数据行并不是存储引擎管理的最小存储单位，索引只能够帮助定位到某个数据页，每一次磁盘读写的最小单位为也是数据页，而一个数据页内存储了多个数据行，需要了解数据页的内部结构才能知道存储引擎怎么定位到某一个数据行

* InnoDB 选择 B+ 树原因
  - InnoDB 需要支持的场景和功能需要在特定查询上拥有较强的性能；
  - CPU 将磁盘上的数据加载到内存中需要花费大量的时间，这使得 B+ 树成为了非常好的选择
* 存储格式
  - 堆表(所有的记录无序存储)
  - 聚簇索引表(所有的记录，按照记录主键进行排序存储)
* MEMORY
  - 存储在Memory数据表里数据用的是长度不变的格式，意味着不能用BLOB和TEXT这样的长度可变的数据类型，VARCHAR是种长度可变的类型，但因为在MySQL内部当做长度固定不变的CHAR类型，所以可以使用
  - 特性
    + 数据都保存在内存中，不需要进行磁盘I/O
    + 支持 Hash 索引和B树索引
    + 支持表级锁，不支持行级锁
    + 服务重启后，表结构还会保留，但是数据会丢失
    + 不支持 TEXT 和 BLOB 类型的列
  - 场景
    + 需要快速地访问数据，并且这些数据不会被修改，重启以后丢失也没有关系。
    + 用于查找（lookup）或者映射（mapping）表，例如将邮编和地址映射的表。
    + 用于保存数据分析中产生的中间数据。
    + 用于缓存周期性聚合数据的结果。
* MyISAM
  - 数据结构：数据和索引分开，一表一个文件，使用 B+Tree 作为索引结构，叶节点的 data 域存放的是数据记录的地址,称为非聚集索引
    + frm 创建表的语句
    + MYD 表里面的数据文件（myisam data）：以主键作为 KEY 来建立主索引 B+树，树的叶子节点存的是对应数据的物理地址
    + MYI 表里面的索引文件（myisam index）：为某个字段添加索引时，同样会生成对应字段的索引树，该字段的索引树的叶子节点同样是记录了对应数据的物理地址
  - 存储格式，根据表的定义自动选择存储格式
    + 静态表：如果数据表中的各数据列的长度都是预先固定好的，服务器将自动选择这种表类型。因为数据表中每一条记录所占用的空间都是一样的，所以这种表存取和更新的效率非常高。当数据受损时，恢复工作也比较容易做。
    + 动态表：如果数据表中出现 varchar 、*text 或 *BLOB 字段时，服务器将自动选择这种表类型。相对于静态MyISAM，这种表存储空间比较小，但由于每条记录的长度不一，所以多次修改数据后，数据表中的数据就可能离散的存储在内存中，进而导致执行效率下降。同时，内存中也可能会出现很多碎片。因此，这种类型的表要经常用 optimize table 命令或优化工具来进行碎片整理。
    + 压缩表：以上说到的两种类型的表都可以用myisamchk工具压缩。如果表在创建并导入数据后，不在进行修改操作，这样的表适合采用 MyISAM 压缩表。这种类型的表进一步减小了占用的存储，但是这种表压缩之后不能再被修改。另外，因为是压缩数据，所以这种表在读取的时候要先时行解压缩。
  - 优点
    + 存储了表数据总条数
    + 在表有读取查询的同时，支持往表中插入新纪录
    + 即使是BLOB和TEXT等长字段，也可以基于其前 500 个字符创建索引，MyISAM 也支持「全文索引」，这是一种基于分词创建的索引，可以支持复杂的查询
    + 支持延迟更新索引，极大提升写入性能
    + 对于不会进行修改的表，支持压缩表，极大减少磁盘空间占用
    + 空间函数（GIS）
    + 只有索引缓存在内存中
    + 读的效果好，写的效率差
      * 和数据存储格式，索引的指针和锁的策略有关
      * 数据是顺序存储，索引btree上的节点是一个指向数据物理位置的指针，所以查找起来很快
      * 适合于一些需要大量查询的应用，但其对于有大量写操作并不是很好。甚至只是需要update一个字段，整个表都会被锁起来，而别的进程就算是读进程都无法操作直到读操作完成
  - 缺点
    + 不支持崩溃后的安全恢复：断电之后 使用之前检查和执行可能的修复
    + 不支持事务：不保证单个命令会完成, 多行update会有错误，只有一些行会被更新
    + 不支持外键
  - 主键索引和辅助索引（Secondary key）在结构上没有任何区别(使用 B+ 树来存储数据)，只是主索引要求 key 是唯一的，而辅助索引的 key 可以重复
    + 主键索引以 <primary_key, row> 的方式存储，能够通过 `primary_key` 找到该行
    + 辅助索引以 <index, primary_key> 的方式进行存储，索引中的几个列构成了键,可能有很多个索引，通过主键索引节省空间
  - 表锁
    + 不支持行级锁而是对整张表加锁」。读取时会对需要读到的所有表加共享锁，写入时则对表加排它锁。但在表有读取操作的同时，也可以往表中插入新的记录，这被称为并发插入
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
  - 可以手工或者自动执行检查和修复操作。但是和事务恢复以及崩溃恢复不同，可能导致一些「数据丢失」，而且修复操作是非常慢的
  - 指定了DELAY_KEY_WRITE选项，在每次修改执行完成时，不会立即将修改的索引数据写入磁盘，而是会写到内存中的键缓冲区，只有在清理键缓冲区或者关闭表的时候才会将对应的索引块写入磁盘。这种方式可以极大的提升写入性能，但是在数据库或者主机崩溃时会造成「索引损坏」，需要执行修复操作
  - 场景
    + 查询密集型表：在筛选大量数据时非常快，是它最突出的优点
    + 插入密集型表：MyISAM 的并发插入特性允许同时选择、插入数据。例如：MyISAM存储引擎非常适合管理邮件或Web服务器日志数据。
    + MySQL 5.1 及之前的版本的默认的存储引擎。MyISAM 提供了大量的特性，包括全文索引、压缩、空间函数（GIS)等，但MyISAM 不「支持事务和行级锁」，对于只读数据，或者表比较小、可以容忍修复操作，依然可以使用它
    + 大项目总量约几个亿的rows的某一类型（如日志等）业务表会使用MyISAM
    + 绝大多数都只是读查询，可以考虑MyISAM，如果既有读写也挺频繁，请使用InnoDB
* InnoDB：默认「事务引擎」，被设置用来处理大量短期（short-lived）事务，短期事务大部分情况是正常提交的，很少会回滚
  - 历史上叫InnoDB plugin，这个MySQL插件在2008年被开发出来，直到2010在Oracle收购了Sun公司后，发布的MySQL5.5才正式使用InnoDB plugin替代了旧版本的InnoDB
  - 数据结构：综合一个文件,写满后递增文件，聚集索引方式（数据和索引都存储在同一个文件里）
    + 共享表空间存储
      * 表结构保存在 .frm 文件中
      * 数据和索引在 `innodb_data_home_dir` 和 ` innodb_data_file_path`定义的表空间中，可以是多个文件
    + 多表空间存储：段-》区（1M，最多可包含64页）->页（16k）
      * 表结构保存在 .frm 文件中。
      * `innodb_file_per_table` 从MySQL5.6开始已经设置为1。这样设置，schema中每个表都是一个文件（如果是分区表，则有多个文件），每个表的数据和索引单独保存在 .ibd 中,这个文件被分为N个段。每个段都与一个索引相关联
        - 文件不会因删除数据而收缩，段本身会增长或收缩
        - 一个页可以包含2到N行。一个页可以容纳的行数与行大小有关，这是表结构设计时定义的。InnoDB中有一个规则，至少要在一个页中容纳两行。因此，行大小限制为8000字节。
    + InnoDB 会根据主键 ID 作为 KEY 建立索引 B+树，B+树的叶子节点存储的是主键 ID 对应的数据。建表的时候 InnoDB 就会自动建立好主键 ID 索引树。是为什么 Mysql 在建表时要求必须指定主键的原因
  - 特点
    + 插入缓冲（Insert buffer): Insert Buffer 用于非聚集索引的插入和更新操作。先判断插入的非聚集索引是否在缓存池中，如果在则直接插入，否则插入到 Insert Buffer 对象里。再以一定的频率进行 Insert Buffer 和辅助索引叶子节点的 merge 操作，将多次插入合并到一个操作中，提高对非聚集索引的插入性能
    + 二次写 (Double write): Double Write由两部分组成，一部分是内存中的double write buffer，大小为2MB，另一部分是物理磁盘上共享表空间连续的128个页，大小也为 2MB。在对缓冲池的脏页进行刷新时，并不直接写磁盘，而是通过 memcpy 函数将脏页先复制到内存中的该区域，之后通过doublewrite buffer再分两次，每次1MB顺序地写入共享表空间的物理磁盘上，然后马上调用fsync函数，同步磁盘，避免操作系统缓冲写带来的问题。
    + 自适应哈希索引 (Adaptive Hash Index):InnoDB会根据访问的频率和模式，为热点页建立哈希索引，来提高查询效率。索引通过缓存池的 B+ 树页构造而来，因此建立速度很快，InnoDB存储引擎会监控对表上各个索引页的查询，如果观察到建立哈希索引可以带来速度上的提升，则建立哈希索引，所以叫做自适应哈希索引。
      * 默认开启自适应哈希索引：如果认为建立哈希索引可以提高查询效率，则自动在内存中的“自适应哈希索引缓冲区”建立哈希索引.优化的缓存：Innodb把数据和内存缓存到缓冲池 自动构建哈希索引
      * 通过观察搜索模式，MySQL会利用index key的前缀建立哈希索引，如果一个表几乎大部分都在缓冲池中，那么建立一个哈希索引能够加快等值查询
      * 在负载高的情况下，自适应哈希索引中添加的read/write锁也会带来竞争，比如高并发的join操作。like操作和%的通配符操作也不适用于自适应哈希索引，可能要关闭自适应哈希索引
    + 缓存池: 为了提高数据库的性能，引入缓存池的概念，通过参数 innodb_buffer_pool_size 可以设置缓存池的大小，参数 innodb_buffer_pool_instances 可以设置缓存池的实例个数。缓存池主要用于存储以下内容：
      * 缓存数据页类型有：索引页、数据页、undo页、插入缓冲 (insert buffer)、自适应哈希索引(adaptive hash index)、InnoDB存储的锁信息 (lock info)和数据字典信息 (data dictionary)。
    + 支持事务和四种事务隔离级别
    + 支持崩溃后的安全恢复:Innodb在做任何操作时，会做一个日志操作，便于恢复
    + 外键：Innodb唯一支持外键的存储引擎 create table 命令接受外键
  - 用于在写操作比较多
  - CPU及内存缓存页优化使得资源利用率更高（推荐）索引节点存的则是数据的主键，所以需要根据主键二次查找
  - 行级锁
    + 默认行级锁,通过给索引上的索引项加锁来实现的
      * 只有通过索引条件检索数据才使用行级锁，否则使用表锁
      * 当 for update 的记录不存在会导致锁住全表
      * 当表有多个索引的时候，不同的事务可以使用不同的索引锁定不同的行
      * 不论是使用主键索引、唯一索引或普通索引，InnoDB 都会使用行锁来对数据加锁
    - mysql的读写之间是可以并发的，普通的select是不需要锁的，当查询的记录遇到锁时，用的是一致性的非锁定快照读，也就是根据数据库隔离级别策略，会去读被锁定行的快照，其它更新或加锁读语句用的是当前读，读取原始行；因为普通读与写不冲突，所以innodb不会出现读写饿死的情况，又因为在使用索引的时候用的是行锁，锁的粒度小，竞争相同锁的情况就少，就增加了并发处理，所以并发读写的效率还是很优秀的，问题在于索引查询后的根据主键的二次查找导致效率低
    - 所有扫描到的记录都加锁，范围查询会加间隙锁，保证数据无法添加,然后加锁过程按照两阶段锁 2PL 来实现
      + 也就是先加锁，然后所有的锁在事务提交的时候释放
      + 加锁的策略会和数据库的隔离级别有关，在默认的可重复读的隔离级别的情况下，加锁的流程还会和查询条件中是否包含索引，是主键索引还是普通索引，是否是唯一索引等有关
  - 采用多版本并发控制（MVCC，MultiVersion Concurrency Control）来支持高并发
  - 通过间隙锁next-key locking策略防止幻读的出现
  - 引擎的表基于聚簇索引建立，聚簇索引对主键查询有很高的性能。不过它的二级索引secondary index非主键索引中必须包含主键列，所以如果主键列很大的话，其他的所有索引都会很大。因此，若表上的索引较多的话，主键应当尽可能的小
  - 分析系统上的行锁的争夺情况:`show status like 'innodb_row_lock%';`
  - 间隙锁next-key locking策略防止幻读的出现
    + 防止幻读，以满足相关隔离级别的要求
    + 满足恢复和复制的需要
  - 在聚集索引（主键索引）中，如果有唯一性约束，InnoDB会将默认的next-key lock降级为record lock。
  - 磁盘读取数据方式采用的可预测性预读、自动在内存中创建hash索引以加速读操作的自适应哈希索引（adaptive hash index)，以及能够加速插入操作的插入缓冲区（insert buffer)等
  - 通过一些机制和工具支持真正的热备份，MySQL 的其他存储引擎不支持热备份，要获取一致性视图需要停止对所有表的写入，而在读写混合场景中，停止写入可能也意味着停止读取。备份方式稍微复杂一点。xtradb是innodb存储引擎的增强版本，更高性能环境下的新特性。
  - 不能以单行基础上工作(合并的基础)。InnoDB总是在页上操作。一旦页被加载，它就会扫描页以寻找所请求的行/记录
  - [页合并和页分裂](https://mp.weixin.qq.com/s/uCtEqI9woo1_urdz9lxGCg)
    + 删除数据时，相应的数据是先打上删除标签（deleted mark），而后再由purge线程执行清理工作。这个工作是InnoDB后台线程自动完成的，无需人为干预、控制。
    + 页可以是空，也可以是被填充满（100%）。行记录由主键组织
    + 页合并阈值 MERGE_THRESHOLD (默认值是页的50%)
      * 辅助索引页：能在创建索引时一次性指定，不能中途修改
      * 聚集索引页：表级别的合并阈值则可以在运行时修改
      * 阈值 MERGE_THRESHOLD 无法全局设定
    + 合并数据页
      * 经过多次长度变小的UPDATE操作后（将varchar列长度更新变短）
      * 如果两个相邻数据页存储填充率低于合并阈值，就会尝试合并页，以降低碎片率，提高存储效率
      * 空出来的页就会被标记为空闲页，等待再分配
      * 页合并的统计情况，通过查询 INNODB_METRICS 表获取到
        - 启用metric：`set global innodb_monitor_enable="module_index";`
        - 页合并之后查询：`SELECT NAME,COUNT,STATUS,COMMENT from INFORMATION_SCHEMA.INNODB_METRICS WHERE NAME LIKE 'index_page%merge%';`
        - 通过监控这个metric，如果发现页合并非常频繁的话，可以考虑把 MERGE_THRESHOLD 阈值调低。但是设置太低也有风险，因为合并频率降低了，结果会导致更高的数据页碎片率
        - 通过 INNODB_METRICS 也无法监控到具体是哪些表上的合并操作最多。因此当发现有很高合并频率时，可能需要扫描所有表，找到那些碎片率较高的表，其产生合并的"嫌疑"应该也较高。
    + 页分裂
      * 如果插入的记录可以容纳在该页内，则按顺序填充该页。当页已经满时，下一条记录将插入到下一页
      * 发生在插入或者更新，并导致页错位.在INFORMATION_SCHEMA.INNODB_METRICS表中记录了页分裂的次数。查看index_page_splits和index_page_reorg_attempts/successful指标
      * 一旦分裂的页创建，将其回收的唯一方法是将创建的页降至合并阈值下。当这发生时，InnoDB通过合并操作将数据从分裂页迁移走。
    + 参考
      * [InnoDB数据页什么时候合并](https://mp.weixin.qq.com/s/jcjwWwTrRbhb-mv8D2NPKg)
  - 未压缩的索引：索引没有使用前缀压缩，阻塞auto_increment:Innodb使用表级锁产生新的auto_increment
  - 没有缓存count()
  - 不支持全文索引
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
    + 区是由连续的页组成，任何情况下一个区都是 1MB，一个区中可以有多个页，每个页默认为 16KB ，所以默认情况下一个区中最多可以包含 64 个连续的页，页的大小是可以通过 innodb_page_size 设置，页中存储的是具体的行记录。一行记录最终以二进制的方式存储在文件里。
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
      * 从所在的页内中查找相应的记录：由于不是根据主键查询，只能遍历所在页的单链表了，在数据量很大的情况下这样查找会很慢！这样的时间复杂度为O（n）
    + 索引
      * 通过 “目录” 就可以很快地定位到对应的页上了！（二分查找，时间复杂度近似为O(logn)）
* 对比
  - InnoDB支持事务，而MyISAM不支持事务,查询的速度比 InnoDB 类型更快
  - InnoDB支持行级锁，而MyISAM支持表级锁
    + InnoDB：支持行级锁和表级锁，默认是行级锁，行锁大幅度提高了多用户并发操作的性能。InnoDB 比较适合于插入和更新操作比较多的情况，而 MyISAM 则适用于频繁的查询的情况
    + InnoDB 表的行锁也不是绝对的，如果在执行一个 SQL 语句时， MySQL 不能确定要扫描的范围，InnoDB 表同样会锁全表，例如： update table set num=1 where name like '%aaa%';
  - InnoDB支持MVCC, 而MyISAM不支持
  - InnoDB支持外键，而MyISAM不支持
  - InnoDB不支持全文索引，而MyISAM支持
  - 表主键
    + MyISAM：允许没有主键的表存在。
    + InnoDB：如果没有主键，则会自动生成一个 6 字节的主键（用户不可见）
  - 系统奔溃后，MyISAM恢复起来更困难，能否接受
    + MyISAM最大的缺陷就是崩溃后无法安全恢复
    + 不小心update一个表的where语句写的范围不对，导致整张表都不能正常使用，这是MyISAM的优越性就体现出来了，随便从当天拷贝的压缩包中取出对应表的文件，随便放到一个数据库目录下，然后dump成SQL文件导回主库，并把对应的binlog补上
    + 如果是InnoDB就没有这么快的速度了。通常情况下一个数据库实例最小也有几个G大小
  - myiam索引按照行存储物理位置引用被索引的行，Innodb按照主键值引用行，通过主键索引效率很高。
  - InnoDB 的数据文件本身就是索引文件。MyISAM 索引文件和数据文件是分离开的，索引文件仅保存数据记录的地址
    + MyISAM 的索引文件中仅保存了数据的地址，所以在 MyISAM 中主索引和辅助索引在结构上没有本质的区别，只是主索引要求 key 的唯一性，而辅助索引的 key 是可以重复的
    + MyISAM 的 data 域中保存的是数据记录的地址，所以 MyISAM 索引检索的算法为首先按照 B+Tree 搜索算法搜索索引，如果指定的 key 存在，则取出 data 域的值，然后以 data 域的值为地址，读取相应的数据记录
    + MyISAM 主键索引和辅助索引是独立的，并且索引是有压缩的，这样内存使用率就提高了不少。能加载更多索引，而InnoDB是索引和数据紧密捆绑的，没有使用压缩从而会造成InnoDB比MyISAM的体积庞大不少
  - 定期导某些表的数据，用MyISAM的话会很方便，只需要发给他们对应表的frm、MYI、MYD文件，然后在对应版本的数据库中启动即可，而InnoDB则需要导出xxx.sql文件来执行
  - 对于AUTO_INCREMENT类型的字段，InnoDB中必须包含只有该字段的索引，而在MyISAM中可以和其他字段一起建立联合索引
  - DELETE FROM table时，InnoDB不会重新建立表，而是一行行删除
  - LOAD TABLE FROM MASTER操作对于InnoDB是不起作用的，解决方法是首先把InnoDB转换成MyISAM表，导入数据后再转成InnoDB表，但是对于额外的InnoDB特性（如外键）的表是不适用的
  - 和MyISAM比Insert操作的话，InnoDB还达不到MyISAM的写性能，如果是基于索引的update操作，虽然MyISAM会逊色与InnoDB，但是那么多高并发的写，从库能否追的上也是一个大问题。通常情况下会实现多实例分库分表架构来解决
  - MyISAM 查询性能更好，从索引文件数据文件的设计来看也可以看出原因：MyISAM 直接找到物理地址后就可以直接定位到数据记录，但是 InnoDB 查询到叶子节点后，还需要再查询一次主键索引树，才可以定位到具体数据
  - SELECT COUNT(*) from table 常用于统计表的总行数，在 MyISAM  存储引擎中执行更快，前提是不能加有任何WHERE条件。包含where条件时两种表的操作是一致的
    + 因为 MyISAM 对于表的行数做了优化，内部用一个变量存储了表的行数，如果查询条件没有 WHERE 条件则是查询表中一共有多少条数据，MyISAM 可以迅速返回结果，如果加 WHERE 条件就不行。只要简单的读出保存好的行数。因为 MyISAM 内置了一个计数器， count(*) 时它直接从计数器中读
    + InnoDB 的表也有一个存储了表行数的变量，但这个值是一个估计值，所以并没有太大实际意义。会扫描一遍整张表来计算有多少行
* 通过记录头信息里面的nextRecord串成一条链表
* 一页里面的很多条行记录，拆分成若干组，然后将每一组里面最后一条记录（也就是这一组内最大的那条记录）的在该页内的偏移量抽出来作为一个槽（slot），按顺序存储到当前页里面靠后的位置，作为一个页目录（page directory）
* 页与页之间是通过双链表串起来，File header：里面有三个很重要的属性，FIL_PAGE_PREV(上一页的页号)，FIL_PAGE_NEXT(下一页的页号)，FIL_PAGE_OFFSET(页号)
* 批量插入失败或者回滚时带来的MySQL表碎片
  - 使用DELETE语句会产生表碎片。在大多数情况下，当执行大量的删除时，DBA总会重新构建表以回收磁盘空间
  - 碎片：
    + 在表中的InnoDB页完全空闲引起的碎片。
    + InnoDB页未填充满（页中还有一些空闲空间）引起的碎片。
  - 插入引起的碎片场景：
    + 插入，然后回滚,回收：alter table ins_frag engine=innodb;
    + 插入语句失败
    + 页分裂引起的碎片

```sql
show engines; # 显示当前数据库支持的存储引擎情况
show variables like '%storage_engine%';
show variables like 'innodb_data%'; #  ibdata1:12M:autoextend 第一部分 ibdata1 就是系统表空间的路径（相对于 MySQL 数据目录根目录，这里是 /usr/local/var/mysql），第二部分表示初识空间大小是 12M，最后的 autoextend 表示表空间会自动扩展

select * from o_order where order_sn = '201912102322' for update;
# order_sn 是主键索引，这种情况将在主键索引上的 order_sn = 201912102322 这条记录上加排他锁。
# order_sn 是普通索引，并且是唯一索引，将会对普通索引上对应的一条记录加排他锁，对主键索引上对应的记录加排他锁。
# order_sn 是普通索引，并且不是唯一索引，将会对普通索引上 order_sn = 201912102322 一条或者多条记录加锁，并且对这些记录对应的主键索引上的记录加锁。这里除了加上行锁外，还会加上间隙锁，防止其他事务插入 order_sn = 201912102322 的记录，然而如果是唯一索引就不需要间隙锁，行锁就可以。
# order_sn 上没有索引，innoDB 将会在主键索引上全表扫描，这里并没有加表锁，而是将所有的记录都会加上行级排他锁，而实际上 innoDB 内部做了优化，当扫描到一行记录后发现不匹配就会把锁给释放，当然这个违背了 2PL 原则在事务提交的时候释放。这里除了对记录进行加锁，还会对每两个记录之间的间隙加锁，所以最终将会保存所有的间隙锁和 order_sn = 201912102322 的行锁。
# order_sn = 201912102322 这条记录不存在的情况下，如果 order_sn 是主键索引，则会加一个间隙锁，而这个间隙是主键索引中 order_sn 小于 201912102322 的第一条记录到大于 201912102322 的第一条记录。试想一下如果不加间隙锁，如果其他事务插入了一条 order_sn = 201912102322 的记录，由于 select for update 是当前读，即使上面那个事务没有提交，如果在该事务中重新查询一次就会发生幻读。
# 如果没有索引，则对扫描到的所有记录和间隙都加锁，如果不匹配行锁将会释放只剩下间隙锁。回忆一下上面讲的数据页的结果中又一个最大记录和最小记录，Infimum 和 Supremum Record，这两个记录在加间隙锁的时候就会用到。

show engine innodb status # 存储引擎的运行状态
set global innodb_print_all_deadlocks=1; # 错误日志中查看历史发生过的死锁
select * from information_schema.innodb_lock_waits; # 查看等待中的锁
select * from information_schema.innodb_trx; # 查看已开启的事务

ROOT NODE #3: 4 records, 68 bytes
 NODE POINTER RECORD ≥ (id=2) → #197
 INTERNAL NODE #197: 464 records, 7888 bytes
 NODE POINTER RECORD ≥ (id=2) → #5
 LEAF NODE #5: 57 records, 7524 bytes
 RECORD: (id=2) → (uuid="884e471c-0e82-11e7-8bf6-08002734ed50", millid=139, kwatts_s=1956, date="2017-05-01", location="For beauty's pattern to succeeding men.Yet do thy", active=1, time="2017-03-21 22:05:45", strrecordtype="Wit")

# 聚集索引页设置合并阈值
ALTER TABLE t_sk COMMENT 'MERGE_THRESHOLD=40';
# 辅助索引页指定合并阈值
ALTER TABLE t_sk ADD INDEX k1(c1) COMMENT 'MERGE_THRESHOLD=20';
# 查看合并阈值
SELECT * FROM INFORMATION_SCHEMA.INNODB_SYS_INDEXES WHERE select * from information_schema.innodb_sys_Indexes where TABLE_ID = 66\G
SHOW INDEX FROM t_sk\G；

# 测试页合并
mysql_random_data_load # 灌入一些测试数据
# 让填充率低于30%，删除数据
# 用 innodb_ruby 工具扫描这两个page中的数据
innodb_space -s ibdata1 -T test/t_sk -p 7 page-records > recs-no7.txt
Record 128: (id=252)...
...
Record 15143: (id=351) # 共有100条记录，其ID值从 252 ~ 351

innodb_space -s ibdata1 -T test/t_sk -p 7 page-dump > dump-no7.txt
sizes:
  header           120
  trailer            8
  directory         52
  free            1054
  used           15330
  record         15150
  per record     151.00
# 当前的数据所占字节数是：15150
# 只剩30%填充率的字节数是：16384 * 0.3
# 每条记录平均长度字节数是：151
ceil((15150 - 16384 * 0.3) / 151) = 68

innblock test/t_sk.ibd 7 16 | grep n_rows; innblock test/t_sk.ibd 8 16 | grep n_rows
# 每页再删除一条，合并，8号page因为已经被合并了，被标记为空闲page，从索引树里被摘掉了
innodb_space -s ibdata1 -T test/t_sk -I PRIMARY -l 0 index-level-summary

# 看看碎片空间
SELECT
table_schema as 'DATABASE',
table_name as 'TABLE',
CONCAT(ROUND(( data_length + index_length ) / ( 1024 * 1024 * 1024 ), 2), 'G') 'TOTAL',
CONCAT(ROUND(data_free / ( 1024 * 1024 * 1024 ), 2), 'G') 'DATAFREE'
FROM information_schema.TABLES
where table_schema='percona' and table_name='ins_frag';

SET GLOBAL innodb_monitor_enable=all;
# 查看也分裂
select name,count,type,status,comment from information_schema.innodb_metrics where name like '%index_page_spl%'G
```

## 索引

* 定义：存储引擎用于快速定位到数据的一种数据结构

* 缺点
  
  - 创建索引和维护索引要耗费时间，并且随着数据量的增加所耗费的时间也会增加
  - 需要占空间
  - 表中数据进行增加、删除、修改时，索引也需要动态的维护，降低了数据的维护速度

* 优点：用于提升数据检索效率
  
  - 合理使用数据库索引可以提高系统访问性能
  - 大大减轻了服务器需要扫描的数据量
  - 从而提高了数据的检索速度
  - 帮助服务器避免排序和临时表
  - 可以将随机 I/O 变为顺序 I/O

* 目标
  
  - 减少存储引擎扫描数据量
  - 随机IO变成顺序IO
  - 在进行分组、排序等操作时，避免使用临时表

* 原理
  
  - 数据索引存储是有序的
  - 在有序的情况下，通过索引查询一个数据是无需遍历索引记录
  - 极端情况下，数据索引的查询效率为二分法查询效率，趋近于 log2(N)

* 大多数MySQL索引组织形式使用B树存储。空间列类型的索引使用R-树，MEMORY表支持hash索引
  
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
  - UNIQUE 索引:强唯一限制
    + 插入和修改的时候会校验该索引对应的列的值是否已经存在
    + 唯一索引可以为空，但是空值只能有一个，主键不能为空
    + 可以在数据库层面进行兜底避免有重复记录出现
  - FULLTEXT索引:只在MYISAM 存储引擎支持,目的是全文索引，在VARCHAR或者TEXT类型的列上创建，在内容系统中用的多， 在全英文网站用多(英文词独立). 中文数据不常用，意义不大 国内全文索引通常使用 sphinx 来完成.全文索引:fulltext是Myisam表特殊索引，从文本中找关键字不是直接和索引中的值进行比较
    + MySQL 自带的全文索引只能用于 InnoDB、MyISAM ，并且只能对英文进行全文检索，一般使用 ES，Solr 这样的全文索引引擎

* 索引选择性
  
  - 对索引列和字符串前缀长度，参考选择性（Selectivity）这个指标来确定
  - 选择性定义:不重复的索引值和数据总记录条数的比值，其选择性越高，那么索引的查询效率也越高。唯一索引的选择性是1，这时最好的索引选择性，性能也是最好的.譬如对于性别这种参数，建立索引根本没有意义
  - Index Selectivity = Cardinality / #T 取值范围为 (0, 1]
  - `SELECT count(DISTINCT(title))/count(*) AS Selectivity FROM titles;`

* 不适用场景
  
  - 表记录太少
  - 经常插入、删除、修改的表
  - 数据重复且分布平均的表字段，假如一个表有10万行记录，有一个字段A只有T和F两种值，且每个值的分布概率大约为50%，那么对这种表A字段建索引一般不会提高数据库的查询速度。
  - 经常和主字段一块查询但主字段索引值比较多的表字段

* 聚簇索引(Clustered Index)
  
  - 聚集索引不是一种单独的索引类型，而是一种存储数据的方式."聚簇" 是指实际的数据行和相关的键值保存在一起
  - Innodb的数据文件本身就是索引文件,按 B+Tree 组织的一个索引结构，这棵树的叶节点 data 域保存了完整的数据记录,key 是数据表的主键，因此 InnoDB 表数据文件本身就是主索引
  - 每个表只能有一个聚集索引，因此不能一次把行保存在两个地方
    + 定义了主键:通过主键来聚集数据
    + 没有定义主键:非空的唯一索引（Unique NOT NULL）
    + 没有唯一的非空索引:自动创建一个 6 个字节大小的指针，用户不能查看或访问
  - 聚集索引可以很大程度的提高访问速度:找到了索引也就相应的找到了对应的行数据
  - 主键选择
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

* 覆盖索引(Covering Index)：索引包含查询需要的数据
  
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

* 联合索引：两个或更多个列上的索引
  
  - 以索引 (name, city, gender) 为例，其首先是按照 name 字段顺序组织的，当 name 字段的值相同时（如 Bush），其按照 city 字段顺序组织，当 city 字段值相同时，其按照 gender 字段组织
  - 创建索引列的顺序非常重要:正确的索引顺序依赖于使用该索引的查询方式.对于联合索引的索引顺序可以通过经验法则来帮助我们完成：将选择性最高的列放到索引最前列，该法则与前缀索引的选择性方法一致，但并不是说所有的组合索引的顺序都使用该法则就能确定，还需要根据具体的查询场景来确定具体的索引顺序。
  - index[b,c,d]:idx_t1_bcd索引，首先按照b字段排序，b字段相同，则按照c字段排序，以此类推。记录在索引中按照[b,c,d]排序
  - 利用索引中的附加列，可以缩小搜索的范围，但使用一个具有两列的索引不同于使用两个单独的索引。
  - 在建立多列索引的时候，必须按照从左到右的顺序使用全部或部分的索引列，才能充分的使用联合索引，比如：(col1, col2, col3) 使用 (col1)、(col1, col2)、(col1, col2, col3) 有效。在查询语句中会一直向右匹配直到遇到范围查询 (>,<,BETWEEN,LIKE) 就停止匹配，其后的索引列将不会使用索引来优化查找了
  - 以 (name, city, interest) 三个字段联合的索引为例，如果查询条件为 where name='Bush'; 那么就只需要根据 B+树定位到 name 字段第一个 Bush 所在的值，然后顺序扫描后续数据，直到找到第一个不为 Bush 的数据即可，扫描过程中将该索引片的数据 id 记录下来，最后根据 id 查询聚簇索引获取结果集
  - 查询条件为 where name='Bush' and city='Chicago'; 的查询，MySQL 可以根据联合索引直接定位到中间灰色部分的索引片，然后获取该索引片的数据 id，最后根据 id 查询聚簇索引获取结果集。
  - 无法跨越字段使用联合索引，如 where name='Bush' and interest='baseball';，对于该查询，name 字段是可以使用联合索引的第一个字段过滤大部分数据的，但是对于 interest 字段，其无法通过 B+ 树的特性直接定位第三个字段的索引片数据，比如这里的 baseball 可能分散在了第二条和第七条数据之中。最终，interest 字段其实进行的是覆盖索引扫描。
  - 对于非等值条件，如 >、<、!= 等，联合索引前缀对于索引片的过滤只能到第一个使用非等值条件的字段为止，后续字段虽然在联合索引上也无法参与索引片的过滤。这里比如 where name='Bush' and city>'Chicago' and interest='baseball';，对于该查询条件，首先可以根据 name 字段过滤索引片中第一个字段的非 Bush 的数据，然后根据联合索引的第二个字段定位到索引片的 Chicago 位置，由于其是非等值条件，这里 MySQL 就会从定位的 Chicago 往下顺序扫描，由于 interest 字段是可能分散在索引第三个字段的任何位置的，因而第三个字段无法参与索引片的过滤。
  - 满足最左前缀，就可以利用索引来加速检索。
    + 最左前缀可以是联合索引的最左N个字段
    + 也可以是字符串索引的最左M个字符
  - 使用索引对结果进行排序，需要索引的顺序和 ORDER BY 子句中的顺序一致，并且所有列的升降序一致(ASC/DESC)。如果查询连接了多个表，只有在 ORDER BY 的列引用的是第一个表才可以(需要按序 JOIN)。
  - 索引字段的顺序需要考虑字段值去重之后的个数，较多的放前面。ORDER BY子句也遵循此规则
  - 实例
    + create table `geek` (`a` int(11) not null, `b` int(11) not null, `c` int(11) not null, `d` int(11) not null, primary key (`a`, `b`), key `c` (`c`), key `ca` (`c`, `a`), key `cb` (`c`, `b`), ) engine=InnoDB;
    + 业务里面有这样的两种语句：select * from geek where c=N order by a limit 1;select * from geek where c=N order by b limit 1;
    + 索引ca 的组织是先按 c 排序，再按 a 排序，同时记录主键，主键部分只有b，这个跟索引c的排序结果是一样的
    + 索引cb 的组织是先按 c 排序，再按 b 排序，同时记录主键，主键部分只有a
    + 所以，ca 可以去掉，cb 需要保留

* 索引下推（index condition pushdown）
  
  - 在索引遍历的过程中，对索引中包含的字段先做判断，直接过滤掉不满足条件的记录，从而减少了回表的次数
  - 表中有（name,age）索引，select * from tuser where name like '张%' and age=10 and ismale=1;
  - 直接在索引中，直接过滤不满足条件

* 三星索引：是对于一个查询，设立了三个通用的索引条件满足的条件，建立的索引对于特定的查询每满足一个条件就表示该索引得到一颗星，当该索引得到三颗星时
  
  - 取出所有的等值谓词的列 （WHERE COL=…） 作为索引开头的列；
  - 将 ORDER BY 中的列加入到索引中；
  - 将查询语句中剩余的列加入到索引中，将易变得列放到最后以降低更新成本。

* 前缀索引：一个索引可以包括15个列
  
  - 索引很长的字符列，这会增加索引的存储空间以及降低索引的效率。选择字符列的前n个字符作为索引，这样可以大大节约索引空间，从而提高索引效率。
  
  - 要选择足够长的前缀以保证高的选择性，同时又不能太长。
  
  - 无法使用前缀索引做ORDER BY 和 GROUP BY以及使用前缀索引做覆盖扫描
  
  - 索引选择性是不重复的索引值和全部行数的比值。高选择性的索引有好处，查找匹配过滤更多的行，唯一索引选择性为1最佳状态。
  
  - blob列、text列及很长的varchar列，必须定义前缀索引，mysql不允许索引他们的全文
  
  - 两个列的值按照申明时候的顺序进行拼接后再构建索引
  
  - 建立多个单列索引，查询时和上述的组合索引效率也会大不一样，远远低于我们的组合索引。虽然此时有了三个索引，但MySQL只能用到其中的那个它认为似乎是最有效率的单列索引
  
  - 最左前缀（Leftmost Prefixing）。假如有一个多列索引为key(firstname lastname age)，当搜索条件是以下各种列的组合和顺序时，MySQL将使用该多列索引：firstname，lastname，age  firstname，lastname firstname
  
  - (a,b,c)复合索引， ac 可以使用到索引a
  
  - like 前缀:用的表达式为 `first_name like 'rMq%';`那么其是可以用到 first_name 字段的索引的
    
    + 底层实际上是使用了一个补全策略来使用索引的，比如这里 first_name like 'rMq%';，MySQL 会将其补全为两条数据：rMqAAAAA 和 rMqzzzzz，后面补全部分的长度为当前字段的最大长度。在使用索引查询时，MySQL 就使用这两条数据进行索引定位，最后需要的结果集就是这两个定位点的中间部分的数据
  
  - 字符串前缀:只取字符串前几个字符建立的索引。在进行查询时，如果一个字段值较长，那么为其建立索引的成本将非常高，并且查询效率也比较低，字符串前缀索引就是为了解决这一问题而存在的。字符串前缀索引主要应用在两个方面：
    
    + 字段前缀部分的选择性比较高；
    + 字段整体的选择性不太大（如果字段整体选择性比较大则可以使用哈希索引）
    + 如何选择前缀的长度，长度选择合适时，前缀索引的过滤性将和对整个字段建立索引的选择性几乎相等。这里需要用到前面讲解的关于字段选择性的概念
  
  - 如果是CHAR，VARCHAR类型，length可以小于字段实际长度；如果是BLOB和TEXT类型，必须指定 length

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

* 不可见索引
  
  - 不可见是针对优化器而言的，优化器在做执行计划分析的时候(默认情况下)是会忽略设置了不可见属性的索引
  - 可以继续使用不可见索引：optimizer_switch use_invisible_indexes=ON
  - 作用
    + 可以一边设置索引为不可见，一边观察数据库的慢查询记录和thread running 状态。如果数据库长时间没有相关慢查询 ，thread_running比较稳定，就可以下线该索引
    + 反之，则可以迅速将索引设置为可见，恢复业务访问
  - 注意
    + 针对非主键索引的。主键不能设置为不可见，这里的 主键 包括显式的主键或者隐式主键(不存在主键时，被提升为主键的唯一索引)
    + force /ignore index(index_name) 不能访问不可见索引，否则报错
    + 设置索引为不可见需要获取MDL锁，遇到长事务会引发数据库抖动
    + 唯一索引被设置为不可见，不代表索引本身唯一性的约束失效

* 一千万条数据 插入统计数据
  
  - 无主键|无索引 test_primary_b 数据长度  960MB 65分钟插入 平均一万条数据插入 4.2秒
  - 自增主键:test_primary_a 数据长度  960MB 62分钟插入 平均一万条数据插入 4秒
  - 自增主键/有索引 test_primary_d  数据长度  1GB  索引长度 1.36GB 75分钟插入 平均一万条数据插入 4.5秒
  - 复合主键 无索引 test_primary_c 数据长度  1.54GB 219分钟插入 平均一万条数据插入 8秒

* 参考
  
  - [MySQL实战45讲 索引部分整理](https://www.cnblogs.com/Jacian/p/12145696.html)

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


create table t1 (i int,
    j int,
    k int,
    index i_idx (i) invisible
) engine=innodb;
create index j_idx on t1 (j) invisible;
alter table t1 add index k_idx (k) invisible;
select index_name,is_visible from information_schema.statistics where table_schema='test'  and table_name='t1';
alter table t1 alter index i_idx visible;

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
select * from tba1 FORCE INDEX('idx_end_time') # 强制使用索引
## 三星索引
SELECT first_name, last_name, email FROM user WHERE first_name = 'aa' ORDER BY last_name;

# 最左列为常数，索引：(date,staff_id,customer_id)
select staff_id , customer_id from demo where date = '2015-06-01'order by staff_id , customer_id
```

## 慢日志 slow log

* 知道哪些SQL语句执行效率低下.在MySQL中响应时间超过`long_query_time`阀值的语句，会被记录到慢查询日志中
  - `long_query_time`默认值为10，意思运行10s以上的语句
* 使用:设置相应的阈值（比如超过3秒就是慢SQL），在生产环境跑上个一天过后，看看哪些SQL比较慢
* 备份：先用mv重命名文件（不要跨分区），然后执行flush logs（必须的）
* 删除：执行flush logs（必须的）
* 工具
  - percona公司的pt-query-digest工具，日志分析功能全面，具体逻辑可以看SlowLogParser这个函数。可分析slow log、binlog、general log
  - 开源工具：mysqlsla
  - MySQL自带mysqldumpslow命令可以非常明确的得到各种需要查询语句，对MySQL查询语句的监控、分析、优化是MySQL优化非常重要的一步。
    + 开启慢查询日志后，由于日志记录操作，在一定程度上会占用CPU资源影响mysql的性能，可以阶段性开启来定位性能瓶颈。
    + -s, 是表示按照何种方式排序，c、t、l、r分别是按照记录次数、时间、查询时间、返回的记录数来排序，ac、at、al、ar，表示相应的倒序
    + -t, 是top n的意思，即为返回前面多少条的数据
    + -g, 后边可以写一个正则匹配模式，大小写不敏感的

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

* 对一系列 SQL 操作的批处理,一种在数据库中存储复杂程序，以便外部程序调用的一种数据库对象. 数据库 SQL 语言层面的代码封装与重用
* 为了完成特定功能的SQL语句集，经编译创建并保存在数据库中，用户可通过指定存储过程的名字并给定参数(需要时)来调用执行
* 存储过程和默认数据库相关联，如果想指定存储过程创建在某个特定的数据库下，那么在过程名前面加数据库名做前缀
* 创建的存储过程保存在数据库的数据字典中
* 好处
  - 代码封装，保证了一定的安全性；
  - 代码复用；
  - 由于是预先编译，因此具有很高的性能。
  - 能实现较快的执行速度。
  - 可以用流程控制语句编写，有很强的灵活性，可以完成复杂的判断和较复杂的运算。
  - 可被作为一种安全机制来充分利用。
  - 能够减少网络流量
* 过程
  - 命令行中创建存储过程需要自定义分隔符，因为命令行是以 ; 为结束符，而存储过程中也包含了分号，因此会错误把这部分分号当成是结束符，造成语法错误。
  - 包含 in、out 和 inout 三种参数。
  - 给变量赋值都需要用 select into 语句。
  - 每次只能给一个变量赋值，不支持集合的操作
* 过程体
  - dml、ddl语句，if-then-else和while-do语句、声明变量的declare语句
  - begin开始，以end结束(可嵌套)
  - 表示过程体结束的begin-end块，则不需要分号
* 变量
  - 用户变量名一般以@开头
  - 可以读写用户变量，全局可以读取到
  - 全局变量的值作为参数传入存储过程，修改的局部作用域的副本
  - 内部的变量在其作用域范围内享有更高的优先权
* 参数 `IN|OUT|INOUT 参数名 数据类型`
  - IN       输入：在调用过程中，将数据输入到过程体内部的参数
  - OUT      输出：在调用过程中，将过程体处理完的结果返回到客户端
  - INOUT    输入输出：既可输入，也可输出,in/out参数尽量少用
* 注释：--：该风格一般用于单行注释
* 更改用 CREATE PROCEDURE 建立的预先指定的存储过程，其不会影响相关存储过程或存储功能
* 存储函数
* vs 函数
  - 存储过程和函数是事先经过编译并存储在数据库中的一段 SQL 语句的集合，调用存储过程和函数可以简化应用开发人员的很多工作，减少数据在数据库和应用服务器之间的传输，对于提高数据处理的效率是有好处的。
  - 相同点
    + 存储过程和函数都是为了可重复的执行操作数据库的 SQL 语句的集合。
    + 存储过程和函数都是一次编译后缓存起来，下次使用就直接命中已经编译好的 sql 语句，减少网络交互提高了效率。
  - 不同点
    + 标识符不同，函数的标识符是 function，存储过程是 procedure。
    + 函数返回单个值或者表对象，而存储过程没有返回值，但是可以通过OUT参数返回多个值。
    + 函数限制比较多，比如不能用临时表，只能用表变量，一些函数都不可用等，而存储过程的限制相对就比较少。
    + 一般来说，存储过程实现的功能要复杂一点，而函数的实现的功能针对性比较强
    + 函数的参数只能是 IN 类型，存储过程的参数可以是IN OUT INOUT三种类型。
    + 存储函数使用 select 调用，存储过程需要使用 call 调用。

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

DROP PROCEDURE IF EXISTS `proc_adder`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_adder`(IN a int, IN b int, OUT sum int)
BEGIN
    DECLARE c int;
    if a is null then set a = 0;
    end if;

    if b is null then set b = 0;
    end if;

    set sum  = a + b;
END
;;
DELIMITER ;
# 使用
set @b=5;
call proc_adder(2,@b,@s);
select @s as sum;
```

## 触发器

* 一种与表操作有关的数据库对象，当触发器所在表上出现指定事件时，将调用该对象，即表的操作事件触发表上的触发器的执行
* 使用触发器来进行审计跟踪，把修改记录到另外一张表中。
* 不允许在触发器中使用 CALL 语句 ，也就是不能调用存储过程
* 当触发器的触发条件满足时，将会执行 BEGIN 和 END 之间的触发器执行动作。
  - MySQL 中，分号 ; 是语句结束的标识符，遇到分号表示该段语句已经结束，MySQL 可以开始执行了。因此，解释器遇到触发器执行动作中的分号后就开始执行，然后会报错，因为没有找到和 BEGIN 匹配的 END。
  - 这时就会用到 DELIMITER 命令（DELIMITER 是定界符，分隔符的意思）。它是一条命令，不需要语句结束标识，语法为：DELIMITER new_delemiter。new_delemiter 可以设为 1 个或多个长度的符号，默认的是分号 ;，我们可以把它修改为其他符号，如 $ - DELIMITER $ 。在这之后的语句，以分号结束，解释器不会有什么反应，只有遇到了 $，才认为是语句结束。注意，使用完之后，我们还应该记得把它给修改回来。
* NEW 和 OLD
  - MySQL 中定义了 NEW 和 OLD 关键字，用来表示触发器的所在表中，触发了触发器的那一行数据。
  - 在 INSERT 型触发器中，NEW 用来表示将要（BEFORE）或已经（AFTER）插入的新数据；
  - 在 UPDATE 型触发器中，OLD 用来表示将要或已经被修改的原数据，NEW 用来表示将要或已经修改为的新数据；
  - 在 DELETE 型触发器中，OLD 用来表示将要或已经被删除的原数据；
  - 使用方法： NEW.columnName （columnName 为相应数据表某一列名）
* 参数
  - trigger_name：触发器名
  - trigger_time是触发程序的动作时间,before| after，指明触发程序是在激活它的语句之前或之后触发
  - trigger_event指明了激活触发程序的语句类型
    + INSERT：将新行插入表时激活触发程序
    + UPDATE：更改某一行时激活触发程序
    + DELETE：从表中删除某一行时激活触发程序
  - tbl_name：监听的表，必须是永久性的表，不能将触发程序与TEMPORARY表或视图关联起来
  - FOR EACH ROW: 行级监视，Mysql 固定写法，其他 DBMS 不同。
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
SHOW TRIGGERS;
CREATE TRIGGER trigger_name trigger_time trigger_event ON tbl_name FOR EACH ROW trigger_stmt

DROP TRIGGER [schema_name.]trigger_name

CREATE TRIGGER trigger_name
trigger_time
trigger_event
ON table_name
FOR EACH ROW
BEGIN
  trigger_statements
END;
```

## 视图

* 定义
  - 视图是基于 SQL 语句的结果集的可视化的表。
  - 视图是虚拟的表，本身不包含数据，也就不能对其进行索引操作。对视图的操作和对普通表的操作一样。
* 视图是一个虚拟表，其内容由查询定义。同真实的表一样，视图包含一系列带有名称的列和行数据,有表结构文件，并不储存数据，只包含定义时的语句的动态数据
* 视图并不在数据库中以存储的数据值集形式存在。行和列数据来自由定义视图的查询所引用的表，并且在引用视图时动态生成
* 对其中所引用的基础表来说，视图的作用类似于筛选。定义视图的筛选可以来自当前或其它数据库的一个或多个表，或者其它视图
* 作用
  - 简化复杂的 SQL 操作，比如复杂的联结；
  - 只使用实际表的一部分数据；
  - 通过只给用户访问视图的权限，保证数据的安全性；
  - 更改数据格式和表示。
* 通过视图进行查询没有任何限制，通过它们进行数据修改时的限制也很少
* 视图是存储在数据库中的查询的sql语句，主要出于两种原因
  - 安全原因，视图可以隐藏一些数据，如：社会保险基金表，可以用视图只显示姓名，地址，而不显示社会保险号和工资数等
  - 可使复杂的查询易于理解和使用
* 一般不修改视图，因为不是所有的更新视图都会映射到表上
* 删除视图后，数据依然存在
* 语法
  - 视图名必须唯一，同时不能与表重名
  - 视图可以使用select语句查询到的列名，也可以自己指定相应的列名
  - 可以指定视图执行的算法，通过ALGORITHM指定
  - column_list如果存在，则数目必须等于SELECT语句检索的列数
* 参数
  - OR REPLACE：如果视图存在，则替换已有视图。
  - ALGORITHM：视图选择算法，默认算法是 UNDEFINED(未定义的)由 MySQL自动选择要使用的算法。
    + MERGE        合并 将视图的查询语句，与外部查询需要先合并再执行
    + TEMPTABLE    临时表 将视图执行完毕后，形成临时表，再做外层查询
    + UNDEFINED    未定义(默认)，指的是MySQL自主去选择相应的算法
  - DEFINER：指定视图创建者或定义者，如果不指定该选项，则创建视图的用户就是定义者。
  - SQL SECURITY：SQL安全性，默认为DEFINER。
  - select_statement：创建视图的 SELECT语句，可以从基表或其他视图中选择数据。
  - WITH CHECK OPTION：表示视图在更新时保证约束，默认是 CASCADED
* 优点
  - 操作简单方便。视图用户完全不需要关心视图对应的表的结构、关联条件和筛选条件，对用户来说已经是过滤好的复合条件的结果集。
  - 数据更加安全。视图用户只能访问视图中的结果集，通过视图可以把对表的访问权限限制在某些行和列上面。
  - 数据隔离。屏蔽了源表结构变化对用户带来的影响，源表结构变化视图结构不变

```sh
CREATE
    [OR REPLACE]
    [ALGORITHM = {UNDEFINED | MERGE | TEMPTABLE}]
    [DEFINER = user]
    [SQL SECURITY { DEFINER | INVOKER }]
    VIEW view_name [(column_list)]
    AS select_statement
    [WITH [CASCADED | LOCAL] CHECK OPTION]

CREATE VIEW top_10_user_view AS
SELECT id, username
FROM user
WHERE id < 10;

SHOW CREATE VIEW view_name；

ALTER VIEW view_name [(column_list)] AS select_statement
DROP VIEW [IF EXISTS] view_name
```

## 游标（cursor）

* 一个存储在 DBMS 服务器上的数据库查询，它不是一条 SELECT 语句，而是被该语句检索出来的结果集
* 在存储过程中使用游标可以对一个结果集进行移动遍历。
* 游标主要用于交互式应用，其中用户需要对数据集中的任意行进行浏览和修改。
* 步骤：
  - 声明游标，这个过程没有实际检索出数据；
  - 打开游标；
  - 取出数据；
  - 关闭游标；

```sql
DELIMITER $
CREATE  PROCEDURE getTotal()
BEGIN
    DECLARE total INT;
    -- 创建接收游标数据的变量
    DECLARE sid INT;
    DECLARE sname VARCHAR(10);
    -- 创建总数变量
    DECLARE sage INT;
    -- 创建结束标志变量
    DECLARE done INT DEFAULT false;
    -- 创建游标
    DECLARE cur CURSOR FOR SELECT id,name,age from cursor_table where age>30;
    -- 指定游标循环结束时的返回值
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = true;
    SET total = 0;
    OPEN cur;
    FETCH cur INTO sid, sname, sage;
    WHILE(NOT done)
    DO
        SET total = total + 1;
        FETCH cur INTO sid, sname, sage;
    END WHILE;

    CLOSE cur;
    SELECT total;
END $
DELIMITER ;

-- 调用存储过程
call getTotal();

delimiter ;;
create procedure insertdata()
begin
  declare i int;
  set i=1;
  while(i<=1000000)do
      insert into demo values(i, i, i);
      set i=i+1;
  end while;
end;;
delimiter ;
call insertdata();
```

## mysqldump

* 一致性热备
  - 热备的一个关键点是保证数据的一致性，即在备份进行时发生的数据更改，不会在备份结果中出现。
* 执行完成后可以得到mysqld生成的general log，里面记录了mysqldump在备份过程中传给server的指令
* 流程
  - 连接server
  - 两次关闭所有表，第二次关表同时加读锁
    + 通过--lock-all-tables选项显式要求给所有表加锁。对MyISAM的表备份
    + 通过--master-data选项要求dump出来的结果中包含binlog位置。
    + 通过--single-transaction指定了进行单事务的一致性备份，同时通过--flush-logs要求刷新log文件。
    + 在Percona发行版的mysqldump中，执行时可以传入一个--lock-for-backup选项，这个选项会使得mysqldump在dump之前，执行一个LOCK TABLES FOR BACKUP语句，这是一个Percona独有的query，其主要做以下几件事情：
      * 阻塞对MyISAM, MEMORY, CSV, ARCHIVE表的更新操作；
      * 阻塞对任何表的DDL操作；
      * 不阻塞对临时表与log表的更新操作。
  - 设置隔离级别为“可重复读”，开始事务并创建快照
  - 获取当前binlog位置
  - 解锁所有表
  - 对指定的库与表进行dump
* 从库mysqldump会导致复制中断
  - 分析
    + mysqldump 不加任何参数去执行，会对备份的表加表级锁。
    + 从库需要执行从主库同步过来的 update 语句，因为 mysqldump 表锁的存在，该语句会处理等待状态。
    + update 等待超时，这个错误我们在上面的 error log 里可以看到（Lock wait timeout exceeded）。
    + 因为在5.6.26版本下，在使用 MTS 的情况下，slave_transaction_retries 是不生效的。所以当 update 语句超时后，它没有重试机制，导致整个 SQL threads 都停掉了（这也就是为什么 Slave_IO_Running 显示YES，而 Slave_SQL_Running 显示NO）
  - 总结
    + mysqldump 即使在从库中执行，也必须加上 --single-transcation 等参数，直接执行会上表锁，成本大大。
    + 部分mysql工具，如 navicat 直接使用它自带的导出功能，也会锁住全表。所以尽量不要使用工具去处理导出工作。
    + 5.6 的主从的坑已经踩了很多了，大多是由于自身的bug，而且在 5.6 下根本体现不出 MTS 的优势。把 5.6 升级至 5.7 或 8.0 是非常有必要的，之前测试的 8.0 的复制稳定性和性能的提升非常大，推荐直接升级至 8.0 版本。

```sh
mysqldump -uXXX -p osdc osdc_XXX > /tmp/osdc_info.sql；
show variables like '%slave_parallel_workers%';
show variables like '%innodb_lock_wait_timeout%';
show variables like '%slave_transaction_retries%';

#
mysqldump -uroot -p --skip-opt --default-character-set=utf8  --single-transaction --master-data=2 --no-autocommit -B d1> backup.sql
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
  - Master binlog 输出线程：Master为每一个复制连接请求创建一个binlog输出线程，将数据变更写入二进制日志(binary log,记录叫做二进制日志事件binary log events，可以通过show binlog events进行查看）
    + MySQL 主从同步 Binlog，是一个单线程的同步过程，原因很简单，为了确保数据一致性，Binlog 的顺序很重要，是绝对不能乱序的
  - Slave I/O线程：在start slave之后，负责从Master上拉取binlog内容放进自己的 Relay Log 中
  - Slave SQL线程：负责执行Relay Log中的语句
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

* Sharding Key

## 中间件

* 优劣
  - 一些通用指标
  - 要结合业务特点，包括业务的读写 qps ，涉及的库表结构和SQL语句，来进行综合的判断
* 中间件产品发展至今，分为两代
  - 传统中间件软件，如mysql proxy， mycat， oneproxy，atlas，kingshard等.使用这些中间件，你还是需要部署中间件模块，做各种配置，系统扩容是还需要停服做数据迁移，需要比较多的时间投入
  - 和公有云结合的，基于中间件的分布式数据库，如阿里DRDS、UCloud UDDB，腾讯云DCDB For TDSQL等,对用户呈现的，是一个类似单机数据库一样的操作和管理界面，管理简单，使用方便
    + 以UCloud 的UDDB为例
      * 在Web控制台上，一步即可创建并配置好中间件和数据库节点，搭建出一个完整的分布式数据库；
      * 通过特殊的建表语句， 即可以配置表的水平划分方式。
  - 中间件复杂水平扩容问题，可以通过一个按钮即可完成水平扩容操作，期间不停服，只是每隔一段时间有几毫秒到零点几秒的访问中断
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
* 选择考虑
  - 产品的成熟度、用户的使用情况和社区（商业公司）支持程度。
    + 数据库中间件虽然本身不做存储，但是每条数据都是要从中经过的，一旦出错，可能对业务造成灾难性的影响，所以软件的正确性和稳定性非常重要。
    + 中间件的成熟度、已经使用的客户的使用情况、数量、用户的口碑，以及开源社区或者商业公司对该产品的支持程度，就非常重要。一般来说，发布时间越长而且在持续迭代、用户使用数量众多，且有大规模业务使用，社区（包括 QQ 群）比较活跃，文档完善，bug 解决及时的产品，更值得信赖。
  - 产品的易用性，是否配置方便，部署容易，系统管理不会有太大负担。
    + 有些中间件模块众多，配置复杂，虽然表面上看起来功能丰富，但业务用到的可能还是最基本的几个功能。选择这样的中间件，即显得不够划算，不仅加重运维负担，同时后续系统的扩展，新业务的支持，也不够敏捷。
  - 是否满足自身业务目前的需求，和潜在的需求:必须根据自己业务的库表结构，分库分表/读写分离需求，业务的SQL语句，读写qps，来判断中间件产品的优劣。 比如，绝大部分中间件，目前都不能支持分布式事务和多表join，但是除了对这两种sql不支持，不少中间件，其实在一些基本的sql，比如带系统函数的sql、聚合类sql上，也支持不够好。
* 选择:
  - 需要根据业务的库表结构，sql语句，以及业务特点，去检查中间件是否对业务的目前sql和潜在sql，能够做到比较好的支持。
  - 选择中间件时，一定要自己做性能测试和压力测试，实事求是地自身业务特点来测定中间件的性能和稳定性情况，不要轻信官方或者第三方发布的一些性能数据
* 中间件产品的最高境界:不需要特别关注中间件，从而可以把精力放在数据库架构、优化和数据库本身的管理上

## 编程

```sh
select a into @a from t1 where a=2;
```

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
* parser过程
  - Connection获取上一次解析成功的位置（如果第一次启动，则获取初始制定的位置或者是当前数据库的binlog位点）
  - Connection建立连接，发生BINLOG_DUMP命令
  - Mysql开始推送Binary Log
  - 接收到的Binary Log通过Binlog parser进行协议解析，补充一些特定信息
  - 传递给EventSink模块进行数据存储，是一个阻塞操作，直到存储成功
  - 存储成功后，定时记录Binary Log位置
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
    + 分区表的数据还可以分布在不同的物理设备上，从而高效利用多个硬件设备
    + 避免某些特殊的瓶颈，例如InnoDB的单个索引的互斥访问，ext3问价你系统的inode锁竞争等
    + 可以备份和恢复单个分区
  - 限制
    + 一个表最多只能有1024个分区
    + MySQL5.1中，分区表达式必须是整数，或者返回整数的表达式。在MySQL5.5中提供了非整数表达式分区的支持
    + 如果分区字段中有主键或者唯一索引的列，那么多有主键列和唯一索引列都必须包含进来。即：分区字段要么不包含主键或者索引列，要么包含全部主键和索引列
    + 分区表中无法使用外键约束
    + NULL值会使分区过滤无效
    + MySQL的分区适用于一个表的所有数据和索引，不能只对表数据分区而不对索引分区，也不能只对索引分区而不对表分区，也不能只对表的一部分数据分区
    + 所有分区必须使用相同的存储引擎
  - 配置 `show variables like '%partition%'` have_partintioning 的值为YES，表示支持分区
  - 合的场景数据的时间序列性比较强，则可以按时间来分区
* 分表与分区区别：分区从逻辑上来讲只有一张表，分表则是将一张表分解成多张表
* 分库分表
  - 水平拆分:以字段为依据，按照一定策略（hash、range等），将一个库（表）中的数据拆分到多个库（表）中。分库内分表和分库两部分，每片数据会分散到不同的MySQL表或库，达到分布式的效果，能够支持非常大的数据量。前面的表分区本质上也是一种特殊的库内分表
    + 库内分表，仅仅是单纯的解决了单一表数据过大的问题，由于没有把表的数据分布到不同的机器上，因此对于减轻MySQL服务器的压力来说，并没有太大的作用，大家还是竞争同一个物理机上的IO、CPU、网络，这个就要通过分库来解决
    + 每个库（表）结构都一样
    + 每个库（表）数据都不一样，没有交集
    + 所有库（表）并集是全量数据
    + 水平分表场景：系统绝对并发量并没有上来，只是单表的数据量太多，影响了SQL效率，加重了CPU负担，以至于成为瓶颈 => 表的数据量少了，单次SQL执行效率高，自然减轻了CPU的负担
    + 水平分库场景：系统绝对并发量上来了，分表难以根本上解决问题，并且还没有明显的业务归属来垂直分库 => 库多了，io和cpu的压力自然可以成倍缓解
    + 优点:
      * 不存在单库大数据和高并发的性能瓶颈
      * 应用端改造较少
      * 提高了系统的稳定性和负载能力
    + 缺点：
      * 分片事务一致性难以解决
      * 跨节点Join性能差，逻辑复杂
      * 数据多次扩展难度跟维护量极大
    + 原则
      * 能不分就不分，参考  单表优化
      * 分片数量尽量少，分片尽量均匀分布在多个数据结点上，因为一个查询SQL跨分片越多，则总体性能越差，虽然要好于所有数据在一个分片的结果，只在必要的时候进行扩容，增加分片数量
      * 分片规则需要慎重选择做好提前规划，分片规则的选择，需要考虑数据的增长模式，数据的访问模式，分片关联性问题，以及分片扩容问题，最近的分片策略为范围分片，枚举分片，一致性Hash分片，这几种分片都有利于扩容
      * 尽量不要在一个事务中的SQL跨越多个分片，分布式事务一直是个不好处理的问题
      * 查询条件尽量优化，尽量避免Select * 的方式，大量数据结果集下，会消耗大量带宽和CPU资源，查询尽量避免返回大量结果集，并且尽量为频繁使用的查询语句建立索引。
      * 通过数据冗余和表分区赖降低跨库Join的可能
    + 分片的选择是取决于最频繁的查询SQL的条件，因为不带任何Where语句的查询SQL，会遍历所有的分片，性能相对最差，因此这种SQL越多，对系统的影响越大，所以我们要尽量避免这种SQL的产生
  - 垂直拆分：按照业务类型对存放在一个数据库中的表进行分类变成几张表的方法，降低表的复杂度和字段的数目。
    + 优点：
      * 可以使得行数据变小，一个数据块(Block)就能存放更多的数据，在查询时就会减少I/O次数(每次查询时读取的Block 就少)
      * 可以达到最大化利用Cache的目的，具体在垂直拆分的时候可以将不常变的字段放一起，将经常改变的放一起
      * 数据维护简单
    + 缺点：
      * 主键出现冗余，需要管理冗余列
      * 会引起表连接JOIN操作（增加CPU开销）可以通过在业务服务器上进行join来减少数据库压力
      * 依然存在单表数据量过大的问题（需要水平拆分）
      * 事务处理复杂
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

SELECT CASE pref_name
      WHEN '长沙' THEN '湖南'
      WHEN '衡阳' THEN '湖南'
      WHEN '海口' THEN '海南'
      WHEN '三亚' THEN '海南'
    ELSE '其他' END AS district,
    SUM(population)
FROM PopTbl
GROUP BY district;

UPDATE Salaries
SET salary = CASE WHEN salary >= 10000 THEN salary * 0.9
WHEN salary < 10000 THEN salary * 1.2
ELSE salary END;

SELECT '存在缺失的编号' AS post FROM post HAVING COUNT(*) <> MAX(id);
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

## mysqladmin

## 压力测试工具 mysqlslap

Mysql 自带的压力测试工具，可以模拟出大量客户端同时操作数据库的情况，通过结果信息来了解数据库的性能状况。一个主要工作场景就是对数据库服务器做基准测试

```sh
mysqlslap –user=root –password=111111 –auto-generate-sql # 自动生成测试SQL
mysqlslap –user=root –password=111111 –concurrency=100 –number-of-queries=1000 –auto-generate-sql # 添加并发 客户端连接 总查询次数
mysqlslap –user=root –password=111111 –concurrency=50 –number-int-cols=5 –number-char-cols=20 –auto-generate-sql # 自动生成复杂表
mysqlslap –user=root –password=111111 –concurrency=50 –create-schema=employees –query="SELECT _FROM dept_emp;" # 使用自己的测试库和测试语句 `echo "SELECT_ FROM employees;SELECT _FROM titles;SELECT_ FROM dept_emp;SELECT _FROM dept_manager;SELECT_ FROM departments;" > ~/select_query.sql`
```

## Group Replication

* 组复制以插件的形式提供给MySQL Server使用，MGR 是MySQL Server 8.0提供的内置MySQL插件，因此不需要额外安装
* 配置
  - 数据必须存储在InnoDB事务引擎中 `disabled_storage_engines="MyISAM,BLACKHOLE,FEDERATED,ARCHIVE,MEMORY"`
  - 基于主从复制的基础架构实现
  - 组复制参数简介
    + plugin_load_add='group_replication.so'：用于在MySQL Server启动时加载相应的插件（这里使用plugin_load_add插件在启动MySQL Server时，自动加载MGR插件，配合后续的一些组复制系统变量，可以省去繁琐的手工配置组复制的步骤）。
    + group_replication_group_name="aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"：给定一个组的组名称（必须是有效的UUID格式，因为在组复制中，binlog中记录的GTID是使用这个UUID来进行构造的，如果不知道如何制定，可以使用select uuid();语句来生成）。
    + group_replication_start_on_boot=off：是否需要随着MySQL Server一并启动MGR插件，在你想手工配置组复制时，就将该系统变量的值设置为off即可。但要注意，一旦将组成功初始化安装完成之后，就需要将该系统变量设置为on（默认为on），以便让MGR插件每次都可以随着MySQL Server自动启动。
    + group_replication_local_address= "s1:33061"：组复制中该成员用于与其他成员之间通讯的地址和端口（s1可以使用IP代替），组会将此地址用于与组内其他成员之间为组通讯引擎（XCom，Paxos变体）建立远程连接，要注意，该系统变量中涉及的端口不能与MySQL Server的运行端口冲突，也不能将此端口它用，它只能用于组成员之间的内部通信。另外，如果不使用IP而是使用的主机名，该主机名需要让组内的所有成员都能够正常解析，以便找到有效的IP地址（可以通过DNS或者所有成员上配置相同的hosts解析记录），从MySQL 8.0.14开始，可以使用IPV6地址，一个组中可以包含使用IPv6和IPv4的成员的组合，更多有关对IPv6网络和混合IPv4和IPv6的信息，请参见"4.5. 配置支持IPv6和混合IPv6与IPv4地址的组"。
    + group_replication_group_seeds= "s1:33061,s2:33061,s3:33061"
      * 指定组复制中有效组成员的地址集合，多个成员地址之间使用逗号分隔。这些成员称为种子成员，其作用只是让joiner节点能够使用这些地址和端口与组建立连接，因此，不需要把所有的成员地址都列出，但要求至少有一个地址有效（可以将组中所有成员的地址和端口都列出，但这不是必须的，如果要列出组中所有成员的地址和端口信息，则建议按照组中成员的启动顺序列出）。一旦joiner节点与组成功建立了连接，则在组内所有成员的performance_schema.replication_group_members表中都会列出组成员的信息。
      * 组内第一个启动的成员，需要负责引导组启动，由于是第一个组成员，所以，在引导组启动时会忽略该系统变量的值。引导组的成员中的任何现有数据都将作用于下一个加入组的成员。即，第二个加入组的成员中任何缺失的数据都将以第一个成员作为数据的提供者（donor节点）执行数据复制（因为此时第一个启动的组成员是唯一一个可以提供差异数据的节点）。后续第三个加入组的成员中任何缺失的数据可以选择第一个成员或者第二个成员作为数据的提供者，以此类推，后续joiner节点都可以在之前已经成功加入组内的成员中任意选择一个作为数据的提供者。
    + 注：通常，组成员之间内部通讯的端口建议设置为33061，但是，如果所有的组成员都部署在同一台主机中，则为了避免端口冲突，需要配置为其他端口。
    + group_replication_bootstrap_group=off：
      * 设置是否使用这个Server来引导组，对于该系统变量的设置，建议在所有Server中都设置为off（默认为off），然后，根据需要人工选择一个Server来引导组，以便确保始终只有一个Server来引导组启动。
      * 在任何时候，该系统变量都只能在一个Server上启用，通常是在第一个启动的Server上启用，且是在第一次引导组时启用（或者在整个组被关闭，然后需要重新引导组时启用，就算是第一个启动的Server，在第一次引导组完成之后，也需要及时关闭该参数），如果多个Server同时启用了这个系统变量，将会造成人为的脑裂场景。
  - 尽管组复制的组成员之间相互通信使用的本地地址和端口与MySQL Server用于SQL访问的地址和端口不同，但是如果MySQL Server不能够正确识别其他组成员的SQL访问地址和端口，则组复制中有Server加入组时的分布式恢复过程可能会失败。因此，建议运行MySQL的主机操作系统配置正确的且唯一的主机名(可以为组复制的所有成员统一配置DNS或统一配置本地hosts解析记录)。主机名信息可以通过performance_schema.replication_group_members表的Member_host列查看。如果组中存在多个成员的操作系统都使用了默认的主机名，则成员有可能因为无法解析到正确的成员地址而无法成功加入组。在这种情况下，建议在每个成员的数据库my.cnf配置文件中使用report_host系统变量各自配置一个惟一的主机名。
  - group_replication_group_seeds系统变量中列出的是组内种子成员的内部网络通讯地址和端口，该地址和端口由每个组成员的系统变量group_replication_local_address指定，而不是客户端用于MySQL Server的SQL访问的地址和端口，另外，要注意，在performance_schema.replication_group_members表中MEMBER_PORT列的值，是SQL访问的端口（而不是组成员之间内部通讯的端口），它来自于组成员的port系统变量。
  - 启动组复制，需要先使用一个Server引导组启动完成，然后将第一个组成员作为种子成员，其余Server依次串行申请加入组（一个组复制集群中，不支持在没有任何活跃节点的情况下，将第一个引导组启动的Server和其他申请加入组的Server同时启动，这可能导致所有申请加入组的Server都失败），如果有特殊需求需要在同一时刻申请加入组，则group_replication_group_seeds系统变量中不要列出还未成功加入组的Server作为种子成员，否则可能导致某些Server申请加入组失败。
  - joiner节点在其group_replication_group_seeds系统变量中指定的种子成员的地址（IPV6或IPV4），必须与该变量所指向的种子成员中的group_replication_local_address系统变量指定的地址相匹配（IPV6或IPV4），即种子成员中group_replication_local_address指定的是IPV4地址，那么，在joiner节点中的group_replication_group_seeds系统变量中也要指定IPV4地址，不能使用IPV6地址，否则地址协议不匹配会导致joiner节点申请加入组失败。另外，所有成员（包括已加入组的成员和待加入组的成员）中的白名单必须允许相互之间的访问，否则将会拒绝白名单之外的网络地址的连接尝试。有关更多白名单的信息，请参见"5.1. 组复制的IP地址白名单"。
* 参考
  - [全方位认识 MySQL 8.0 Group Replication](https://mp.weixin.qq.com/s/sydu0alXDECcHm5GNMvtdA)

```
# Server 实例级别的唯一标志
server_id=1
# 启用GTID
gtid_mode=ON
# 只允许执行GTID模式下被认为安全的语句
enforce_gtid_consistency=ON
# 禁用二进制日志中的事件数据校验
binlog_checksum=NONE
# 启用二进制日志记录功能
log_bin=binlog
# 启用SQL线程回放之后将二进制写入自身的binlog中，在组复制中，依赖于每个成员持久化的binlog来实现一些数据自动平衡的特性
log_slave_updates=ON
# 启用ROW格式复制，增强数据一致性
binlog_format=ROW
# 启用双TABLE，使用InnoDB引擎表来保存IO和SQL线程的位置信息（复制元数据），以增强复制状态的安全性
master_info_repository=TABLE
relay_log_info_repository=TABLE

plugin_load_add='group_replication.so'
group_replication_group_name="aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
group_replication_start_on_boot=off
group_replication_local_address= "s1:33061"
group_replication_group_seeds= "s1:33061,s2:33061,s3:33061"
group_replication_bootstrap_group=off

## /etc/hosts
10.10.30.162 s1 mysql1
10.10.30.163 s2 mysql2
10.10.30.164 s3 mysql3
```

## 监控

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

## 迁移

* [ github / gh-ost ](https://github.com/github/gh-ost):GitHub's Online Schema Migrations for MySQL

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

## [SQL审核利器-goinception](https://mp.weixin.qq.com/s/-fGPsqH8D93KZKqH52t0kg)

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

```
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

## [phpmyadmin/phpmyadmin](https://github.com/phpmyadmin/phpmyadmin)

A web interface for MySQL and MariaDB https://www.phpmyadmin.net/

```
sudo add-apt-repository ppa:phpmyadmin/ppa
export DEBIAN_FRONTEND=noninteractive`
sudo apt-get -yq install phpmyadmin
# no select server
CREATE USER 'padmin'@'localhost' IDENTIFIED BY 'change-with-your-secure-password';
GRANT ALL PRIVILEGES ON *.* TO 'padmin'@'localhost' WITH GRANT OPTION;

# /etc/nginx/snippets/phpmyadmin.conf
location /phpmyadmin {
    root /usr/share/;
    index index.php index.html index.htm;
    location ~ ^/phpmyadmin/(.+\.php)$ {
        try_files $uri =404;
        root /usr/share/;
        fastcgi_pass unix:/run/php/php7.4-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include /etc/nginx/fastcgi_params;
    }

    location ~* ^/phpmyadmin/(.+\.(jpg|jpeg|gif|css|png|js|ico|html|xml|txt))$ {
        root /usr/share/;
    }
}

include snippets/phpmyadmin.conf; # add to one domain
```

## 图书

* 《[高性能 MySQL（第3版）](https://book.douban.com/subject/23008813/)》
* [数据库索引设计与优化](https://book.douban.com/subject/26419771/)》
* 《[数据库系统概念（第6版）](https://book.douban.com/subject/10548379/)》
* MySQL技术内幕

## 工具

* 客户端
  + 命令行
  + [MySQL Workbench](https://www.mysql.com/products/workbench/)
    * 会显示执行计划
  + SQLyog:`ttrar`  `59adfdfe-bcb0-4762-8267-d7fccf16beda`
  + [Sequel Pro](https://github.com/sequelpro/sequelpro):MySQL/MariaDB database management for macOS https://sequelpro.com/
  + navicat
    * [DoubleLabyrinth/navicat-keygen](https://github.com/DoubleLabyrinth/navicat-keygen):A keygen for Navicat
    * Navicat Premium for Mac
  + [TablePlus](https://tableplus.com/)
* ER图
  - PowerDesigner
* [dbcli/mycli](https://github.com/dbcli/mycli):A Terminal Client for MySQL with AutoCompletion and Syntax Highlighting. http://mycli.net `sudo apt install mycli`
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

* [mysql-system-schema](https://github.com/xiaoboluo768/mysql-system-schema):基于MySQL 5.7的ps,is,sys,mysql库的明细文档

* [HOW TO INSTALL MYSQL NDB CLUSTER ON LINUX](https://clusterengine.me/how-to-install-mysql-ndb-cluster-on-linux/)

* [索引性能分析](http://draveness.me/sql-index-performance.html)

* [MySQL主从同步](http://geek.csdn.net/news/detail/236754)

* [MySQL数据库事务隔离级别介绍](http://www.jb51.net/article/49596.htm)

* [使用 Docker 完成 MySQL 数据库主从配置](https://juejin.im/post/59fd71c25188254dfa1287a9)

* [MySQL 学习笔记](https://notes.diguage.com/mysql/)

* [学 SQL 就看这些了](https://mp.weixin.qq.com/s/GZW7RZTLEVGBCRS4b66kig)

* [jaywcjlove/mysql-tutorial](https://github.com/jaywcjlove/mysql-tutorial):MySQL入门教程（MySQL tutorial book）

* [SQL语句百万数据量优化方案](https://juejin.im/post/5a01257a6fb9a045211e1bdc)

* [GDB调试 MSQL](https://mp.weixin.qq.com/s/lLfbUpd_SMCpFm1vNQlHRQ)
