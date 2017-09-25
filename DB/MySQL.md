# MySQL

[mysqljs/mysql](https://github.com/mysqljs/mysql)

## 客户端

- workbeach
- SQLyog
- phpAdmin

## 安装

```
brew install mysql
brew services start mysql
unset TMPDIR
mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp
mysql.server start
配置文件：/usr/local/etc/my.cnf
生成用户root与空密码登陆
```

## 问题

- SQL注入与XSS攻击
- memcache内存分配机制
- 获取按年龄分组的，条数大于1的记录 -- 自我评价与职业规划

## 概念

- SQL，指结构化查询语言，全称是 Structured Query Language.
- RDBMS 指关系型数据库管理系统，全称 Relational Database Management System。
- DBMS:关联表公共字段的名字可以不一样，但是数据类型必须一样
- 索引：存储引擎用于快速查找记录的一种数据结构，通过合理的使用数据库索引可以大大提高系统的访问性能。大大减轻了服务器需要扫描的数据量，从而提高了数据的检索速度；帮助服务器避免排序和临时表；可以将随机 I/O 变为顺序 I/O
- 数据库操作：

  - CREATE DATABASE - 创建新数据库
  - ALTER DATABASE - 修改数据库

- 表操作：

  - CREATE TABLE - 创建新表
  - ALTER TABLE - 变更（改变）数据库表
  - DROP TABLE - 删除表

- 数据操作

  - SELECT - 从数据库中提取数据
  - UPDATE - 更新数据库中的数据
  - DELETE - 从数据库中删除数据
  - INSERT INTO - 向数据库中插入新数据

- 索引操作

```
ALTER TABLE 'table_name' ADD PRIMARY KEY'index_name' ('column');
ALTER TABLE 'table_name' ADD UNIQUE/INDEX/FULLTEXT 'index_name' ('column');
ALTER TABLE 'table_name' ADD INDEX 'index_name' ('column1', 'column2', ...);
```

# 主从复制

两台ubnutu

## notice

- 无法远程连接mysql(报错111)：注释掉my.cnf中的bind-address或绑定本地ip
- 添加server-id and log_bin=
- 主从服务器检查show variables like 'server%'
- 主服务器

  ```
  GRANT REPLICATION SLAVE ON *.* TO 'slave_user'@'%' IDENTIFIED BY 'slave_password';
  FLUSH PRIVILEGES
  SHOW MASTER STATUS
  ```

- 从服务器

  ```
  CHANGE MASTER TO MASTER_HOST='202.167.45.10',MASTER_USER='slave_user', MASTER_PASSWORD='slave_password', MASTER_LOG_FILE='mysql-bin.000001', MASTER_LOG_POS=  107;
  START slave;
  show slave status\G;
  ```

- Slave_IO_Running = NO：stop slave; reset slave;start slave;

# 读写分离

通过mysql-proxy调度：与主服务器在一台服务器上，用源代码安装含有lua脚本

```
sudo apt-get install mysql-proxy
```

## 客户端

- 命令行

  ```
  net start/stop mysql
  ```

## 配置文件my.ini

数据库路径

字符集: 客户端向MySQL服务器端请求和返加的数据的字符集，在选择数据库后使用:set names gbk;

- 数据库存储:一个汉字utf8下为两个长度,gbk下为一个长度
- 正常一个汉字utf8下为三个字节,gbk下为两个字节

保证客户端使用字符集与服务端返回数据字符集编码一致(以适应客户端为主,修改服务器服务器端配置) 查询系统变量:

```
  SHOW VARIABLES LIKE "character_%";
  character_set_client:接受的客户端编码
  character_set_result:返回结果集的编码
  不一致的话,修改SET character_set_client=GBK;
  set names 修改client connection results字符集
```

校对集: _bin：按二进制编码比较 _ci：不区分大小写比较

# 存储引擎

- Myisam:表结构 数据 索引文件分离

  - 表锁：myisam 表级锁
  - 不支持自动恢复数据：断电之后 使用之前检查和执行可能的修复
  - 不支持事务：不保证单个命令会完成, 多行update 有错误 只有一些行会被更新
  - 只有索引缓存在内存中：mysiam只缓存进程内部的索引
  - 紧密存储：行被仅仅保存在一起

- Innodb:综合一个文件

  - 事务性：Innodb支持事务和四种事务隔离级别
  - 外键：Innodb唯一支持外键的存储引擎 create table 命令接受外键
  - 行级锁：锁设定于行一级 有很好的并发性
  - 多版本：多版本并发控制
  - 按照主键聚集：索引按照主键聚集
  - 所有的索引包含主键列：索引按照主键引用行 如果不把主键维持很短 索引就增长很大
  - 优化的缓存：Innodb把数据和内存缓存到缓冲池 自动构建哈希索引
  - 未压缩的索引：索引没有使用前缀压缩，阻塞auto_increment:Innodb使用表级锁产生新的auto_increment
  - 没有缓存的count():myisam 会把行数保存在表中 Innodb中的count()会全表或索引扫描

- B-tree 索引:大多数谈及的索引类型就是B-tree类型, 可以在create table 和其他命令使用它 myisam使用前缀压缩以减小索引，Innodb不会压缩索引，myiam索引按照行存储物理位置引用被索引的行，Innodb按照主键值引用行，B-tree数据存储是有序的，按照顺序保存了索引的列，加速了数据访问，存储引擎不会扫描整个表得到需要的数据。

  - 使用B-tree索引的查询类型，很好用于全键值、键值范围或键前缀查找，只有在超找使用了索引的最左前缀的时候才有用。只访问索引的查询：B-tree支持只访问索引的查询，不会访问行
  - 查找没有送索引列的最左边开始,没有什么用处;不能跳过索引的列;

- 全文索引:fulltext是Myisam表特殊索引，从文本中找关键字不是直接和索引中的值进行比较。

- 前缀索引和索引选择性

  - 通常索引几个字符，而不是全部值，以节约空间并得到好的性能，同时也降低选择性。
  - 索引选择性是不重复的索引值和全部行数的比值。高选择性的索引有好处，查找匹配过滤更多的行，唯一索引选择率为1最佳状态。
  - blob列、text列及很长的varchar列，必须定义前缀索引，mysql不允许索引他们的全文。

- 聚集索引不是一种单独的索引类型，而是一种存储数据的方式。Innodb 的聚集索引实际上同样的结构保存了B-tree索引和数据行，"聚集" 是指实际的数据行和相关的键值保存在一起，每个表只能有一个聚集索引，因此不能一次把行保存在两个地方。

- 覆盖索引：索引支持高效查找行，mysql也能使用索引来接收列的数据。这样不用读取行数据，当发起一个被索引覆盖的查询，explain解释器的extra列看到 using index。

- 登录 退出

  ```
  mysql -h localhost  -P 3306 -u root -p
  exit;
  ```

- 数据库(DB):创建 切换 展示 修改 删除数据库

  ```
  SHOW DATABASES:
  USE db_name;
  CREATE DATABASE [IF NOT EXISTS] db_name [CHARSET utf8(gbk)] [COLLATE utf8_unicode_ci];  关键字表名加``
  ALTER DATABASE db_name DEFAULT  CHARACTER SET utf8
  DROP DATABASE [IF EXISTS] db_name;
  显示创建数据库时的语句:SHOW CREATE DATABASE db_name;
  ALTER DATABASE db_name DEFAULT  CHARACTER SET utf8
  ```

- 数据表(table)

  - 查看 创建 删除数据表

    ```
    SHOW TABLES;
    DROP TABLE [IF EXISTS] db_name;
    CREATE TABLE table_name(col_name  type  attribute , col_name  type  attribute,…… );
    create table news(
      id int NOT null AUTO_INCREMENT primary KEY,
      title varchar(100) not null comment '名称',
      author varchar(20) not null,
      source varchar(30) not null,
      hits int(5) not null DEFAULT 0,
      context text null,
      adddate int(16) not null
    )charset=utf8 collate=utf8_bin;
    ```

  - 修改数据表:

    ```
    ALTER TABLE table_name ADD address varchar(30) first| after name;
    ALTER TABLE table_name DROP address;
    ALTER TABLE table_name MODIFY address varchar(100);  修改属性
    ALTER TABLE table_name CHANGE address add varchar(100) after id; 修改字段名字
    ALTER TABLE table_name engine=myisam;
    ALTER TABLE table_name rename to new_table_name;
    ALTER TABLE table_name rename to another_DB.new_table_name; 移动表
    ```

  - 复制表

    ```
    CREATE TABLE table_name SELECT column1,cloumn2 FROM another_table:复制数据不复制主键
    CREATE TABLE table_name like another_table: 数据不复制，主键复制
    ```

  - 记录

    + 添加 更新与删除数据(新增与修改不用添加TABLE关键字)：

      ```
      INSERT INTO table_name (字段1,字段2,字段3,…) VALUES (值1,值2,值3,…);
      INSERT INTO table_name values (null,值,....);全字段插入，自动增长列用null
      INSERT INTO table_name values (null,值,....),(null,值,....),(null,值,....);插入多条数据
      INSERT INTO table_name set volumn1=value1,volumn3=value3,volumn3=value3;
      UPDATE table_name  SET 字段1 = 新值1, 字段2 = 新值2  [WHERE条件];
      SELECT [DISTINCT] 字段列表 |* FROM table_name [WHERE条件][ORDER BY排序(默认是按id升序排列)][LIMIT (startrow ,) pagesize];
      DELETE FROM table_name [WHERE条件];
      ```

  - 清空数据表:

    ```
    DELETE FROM table_name;数据一条条删除
    TRUNCATE TABLE table_name; 删除表,重建同结构
    ```

  - 展示数据表结构：

    ```
    显示表的结构定义:DESCRIBE|DESC table_name;
    查看创建表的语句:SHOW CREATE TABELE table_name\G;
    ```

- 数据类型

  - 整型：

    - tinyint 0-255 或 -2^7~2^7-1 1个字节
    - smallint -2^15~2^15-1 2个字节
    - mediumint -2^23~2^23-1 3个字节
    - int 0-2^32-1 4个字节
    - bigint 0-2^64-1 8个字节

    - unsigned:无符号数

    - 显示宽度int(11):最小显示位数(默认不起作用),zerofill会用0填充,不决定数据大小

  - 浮点型(M代表总长度(不含小数点)，D代表小数位数),精度会丢失,不要作比较：

    - float(M,D) (论上可以保留7位小数) 3.4E+38~3.4E+38 4个字节
    - double(M,D) (理论上保留15位小数) -1.8E+308~1.8E+308 8个字节

  - 定点数:decimal(M,D)，M的最大值是65，D的最大值是30，默认是（10,0）,用于保存精确的小数

  - 注意:定点数的值是正确的，浮点数会失去精度。浮点数的执行效率要高于定点数。浮点数和定点数支持显示宽度，支持无符号

  - **字符** 类型：

    - char(M) 固定长度 0-255个字符 char(11) //最多只能存储11个字节
    - varchar(M) 自动伸缩型:比固定长度类型占用更少的存储空间，只占用需要的空间,使用额外的1到2字节存储长度，列小于255使用1字节保存长度，大于255使用2字节保存，varchar保留字符串末尾的空格 0-65535个字节 M为字符个数，M为最大值
    - blob和text唯一区别就是blob保存二进制数据、没有字符集和排序规则。
    - tinytext: 2^8-1
    - text 2^16-1
    - mediumtext 中型文本型 2^24-1 0－1677个字符
    - longtext 大型文本 2^32-1 0-42亿个字符

  - 日期时间(发布日期"这样的数据时，请用时间戳来存)：

    - date 2015-10-20
    - time 10:09:08
    - datetime 保存是1001年到9999年，精度是秒，存储值为 2016-05-06 22:39:40。
    - timestamp保存自 1970年1月1日午夜以来的秒数，和unix时间戳相同，提供4字节存储 只能表示1970年到2038年。默认timestamp值 为 NOT NULL。

  - ip:通常使用varchar(15)保存IP地址.inet_aton() inet_ntoa()用于转换

- 字段属性

  - NOT NULL | NULL，该列在添加数据时，是否可以为空。
  - DEFAULT value，给该列定一个默认值。value的值只能是整型、字符型。
  - DEFAULT 1 ，默认值为整型
  - DEFAULT "男" ，默认值为字符型
  - PRIMARY KEY，指定该列主键，值是唯一的，不能重复。
  - AUTO_INCREMENT，指定列的值是自动增长型。 注意：一个数据表，只能有一个主键和一个自动增长型。 提示：数据表的id字段，必须要有 not null primary key auto_incremtn 这三个属性。
  - where结构：

    - 运算符：＝ ＜ ＞ ＜＝ ＞＝ !＝ ＜＞ is not null IS NULL
    - BETWEEN 1 AND 20:WHERE date BETWEEN '2016-05-10' AND '2016-05-14';
    - IN NOT IN：
    - LIKE('name%') NOT LIKE('name%')：

      - % 替代 0 个或多个字符
      - _ 替代一个字符
      - [charlist] 字符列中的任何单一字符
      - [^charlist]或[!charlist] 不在字符列中的任何单一字符 WHERE name REGEXP '^[GFs]'；name REGEXP '^[^A-H]';

    - 逻辑运算: AND & OR(可以混合使用)

  - 别名：涉及超过一个表；在查询中使用了函数；列名称很长或者可读性差；需要把两个列或者多个列结合在一起

    ```
    SELECT column_name AS alias_name FROM table_name;
    SELECT column_name(s) FROM table_name AS alias_name; SELECT w.name, w.url, a.count, a.date FROM Websites AS w, access_log AS a WHERE a.site_id=w.id and w.name="菜鸟教程";
    ```

- 联表：联表查询降低查询速度

## 索引：帮助mysql高效获取数据的数据结构，索引(mysql中叫"键(key)") 数据越大越重要。索引好比一本书，为了找到书中特定的话题，查看目录，获得页码。获取物理位置

聚簇索引与非聚簇索引

# 高性能表设计规范

良好的逻辑设计和物理设计是高性能的基石， 应该根据系统将要执行的查询语句来设计schema, 这往往需要权衡各种因素。

- 数据类型

  - 更小的通常更好：更小的数据类型通常更快，占用更少的磁盘、 内存和CPU缓存， 并且处理时需要的CPU周期也更少。
  - 简单就好： 简单数据类型的操作通常需要更少的CPU周期。 例如， 整型比字符操作代价更低， 因为字符集和校对规则（排序规则 ）使字符比较比整型比较更复杂。
  - 尽量避免NULL： 如果查询中包含可为NULL 的列， 对MySQL来说更难优化， 因为可为NULL 的列 使得索引、 索引统计和值比较都更复杂。 可为 N ULL的列会使用更多的存储空间， 在MySQL里也需要特殊处理。 当可为NULL的列被索引时， 每个索引记录需要一个额 外的字节， 在MyISAM 里甚至还可能导致固定大小的索引（例如只有一个整数列的索引）变成可变大小的索引。例外， lnnoDB 使用单独的位 (bit) 存储NULL 值， 所以对于稀疏数据有很好的空间效率。
  - 整数类型

    - 有两种类型的数字：整数 (whole number) 和实数 (real number) 。 如果存储整数， 可以使用这几种整数类型：TINYINT, SMALLINT, MEDIUMINT, INT, BIGINT。分别使用8,16, 24, 32, 64位存储空间。 整数类型有可选的 UNSIGNED 属性，表示不允许负值，这大致可以使正数的上限提高一倍。 例如 TINYINT. UNSIGNED 可以存储的范围是 0 - 255, 而 TINYINT 的存储范围是 -128 -127 。有符号和无符号类型使用相同的存储空间，并具有相同的性能 ， 因此可以根据实际情况选择合适的类型。 你的选择决定 MySQL 是怎么在内存和磁盘中保存数据的。 然而， 整数计算一般使用64 位的 BIGINT 整数， 即使在 32 位环境也是如此。（ 一些聚合函数是例外， 它们使用DECIMAL 或 DOUBLE 进行计算）。 MySQL 可以为整数类型指定宽度， 例如 INT(11), 对大多数应用这是没有意义的：它不会限制值的合法范围，只是规定了MySQL 的一些交互工具（例如 MySQL 命令行客户端）用来显示字符的个数。 对千存储和计算来说， INT(1) 和 INT(20) 是相同的。

  2.实数类型 实数是带有小数部分的数字。 然而， 它们不只是为了存储小数部分，也可以使用DECIMAL 存储比 BIGINT 还大的整数。 FLOAT和DOUBLE类型支持使用标准的浮点运算进行近似计算。 DECIMAL类型用于存储精确的小数。 浮点和DECIMAL类型都可以指定精度。 对千DECIMAL列， 可以指定小数点前后所允许的 最大位数。这会影响列的空间消耗。 有多种方法可以指定浮点列所需要的精度， 这会使得MySQL悄悄选择不同的数据类型，或者在存储时对值进行取舍。 这些精度定义是非标准的， 所以我们建议只指定数据类型，不指定精度。 浮点类型在存储同样范围的值时， 通常比DECIMAL使用更少的空间。FLOAT使用4个字节存储。DOUBLE占用8个字节，相比FLOAT有更高的精度和更大的范围。和整数类型一样， 能选择的只是存储类型； MySQL使用DOUBLE作为内部浮点计算的类型。 因为需要额外的空间和计算开销，所以应该尽扯只在对小数进行精确计算时才使用DECIMAL。 但在数据最比较大的时候， 可以考虑使用BIGINT代替DECIMAL, 将需要存储的货币单位根据小数的位数乘以 相应的倍数即可。

  3.字符串类型 VARCHAR 用于存储可变⻓字符串，长度支持到65535 需要使用1或2个额外字节记录字符串的长度 适合：字符串的最大⻓度比平均⻓度⼤很多；更新很少 CHAR 定⻓，⻓度范围是1~255 适合：存储很短的字符串，或者所有值接近同一个长度；经常变更 慷慨是不明智的 使用VARCHAR(5)和VARCHAR(200)存储'hello'的空间开销是一样的。 那么使用更 短的列有什么优势吗？ 事实证明有很大的优势。 更长的列会消耗更多的内存， 因为MySQL通常会分配固定大小的内存块来保存内部值。 尤其是使用内存临时表进行排序或操作时会特别糟糕。 在利用磁盘临时表进行排序时也同样糟糕。 所以最好的策略是只分配真正需要的空间。 4.BLOB和TEXT类型 BLOB和 TEXT都是为存储很大的数据而设计的字符串数据类型， 分别采用 二进制和字符方式存储 。 与其他类型不同， MySQL把每个BLOB和TEXT值当作一个独立的对象处理。 存储引擎 在存储时通常会做特殊处理。 当BLOB和TEXT值太大时，InnoDB会使用专门的 "外部"存储区域来进行存储， 此时每个值在行内需要1 - 4个字节存储 存储区域存储实际的值。 BLOB 和 TEXT 之间仅有的不同是 BLOB 类型存储的是二进制数据， 没有排序规则或字符集， 而 TEXT类型有字符集和排序规则

  5.日期和时间类型 大部分时间类型 都没有替代品， 因此没有什么是最佳选择的问题。 唯一的问题是保存日期和时间的时候需要做什么。 MySQL提供两种相似的日期类型： DATE TIME和 TIMESTAMP。 但是目前我们更建议存储时间戳的方式，因此该处不再对 DATE TIME和 TIMESTAMP做过多说明。

  5.其他类型 5.1选择标识符 在可以满足值的范围的需求， 井且预留未来增长空间的前提下， 应该选择最小的数据类型。 整数类型 整数通常是标识列最好的选择， 因为它们很快并且可以使用AUTO_INCREMENT。 ENUM和SET类型 对于标识列来说，EMUM和SET类型通常是一个糟糕的选择， 尽管对某些只包含固定状态或者类型的静态 "定义表" 来说可能是没有问题的。ENUM和SET列适合存储固定信息， 例如有序的状态、 产品类型、 人的性别。 字符串类型 如果可能， 应该避免使用字符串类型作为标识列， 因为它们很消耗空间， 并且通常比数字类型慢。 对千完全 "随机" 的字符串也需要多加注意， 例如 MDS() 、 SHAl() 或者 UUID() 产生的字符串。 这些函数生成的新值会任意分布在很大的空间内， 这会导致 INSERT 以及一些SELECT语句变得很慢。如果存储 UUID 值， 则应该移除 "-"符号。 5.2特殊类型数据 某些类型的数据井不直接与内置类型一致。 低千秒级精度的时间戳就是一个例子，另一个例子是以个1Pv4地址，人们经常使用VARCHAR(15)列来存储IP地址，然而， 它们实际上是32位无符号整数， 不是字符串。用小数点将地址分成四段的表示方法只是为了让人们阅读容易。所以应该用无符号整数存储IP地址。MySQL提供INET_ATON()和INET_NTOA()函数在这两种表示方法之间转换。

- 表结构设计

  - 范式和反范式：对千任何给定的数据通常都有很多种表示方法， 从完全的范式化到完全的反范式化， 以及两者的折中。 在范式化的数据库中， 每个事实数据会出现并且只出现一次。 相反， 在反范式化的数据库中， 信息是冗余的， 可能会存储在多个地方。

    - 范式的优点和缺点：为性能提升考虑时，经常会被建议对 schema 进行范式化设计，尤其是写密集的场景。
    - 范式化的更新操作通常比反范式化要快。
    - 当数据较好地范式化时，就只有很少或者没有重复数据，所以只需要修改更少的数据。
    - 范式化的表通常更小，可以更好地放在内存里，所以执行操作会更快。
    - 很少有多余的数据意味着检索列表数据时更少需要 DISTINCT 或者 GROUP BY语句。

    - 反范式的优点和缺点：不需要关联表，则对大部分查询最差的情况----即使表没有使用索引----是全表扫描。 当数据比内存大时这可能比关联要快得多，因为这样避免了随机I/0。 单独的表也能使用更有效的索引策略。 混用范式化和反范式化 在实际应用中经常需要混用，可能使用部分范式化的 schema 、 缓存表，以及其他技巧。 表适当增加冗余字段，如性能优先，但会增加复杂度。可避免表关联查询。

  简单熟悉数据库范式 第一范式(1NF)：字段值具有原子性,不能再分(所有关系型数据库系统都满足第一范式); 例如：姓名字段,其中姓和名是一个整体,如果区分姓和名那么必须设立两个独立字段; 第二范式(2NF)：一个表必须有主键,即每行数据都能被唯一的区分; 备注：必须先满足第一范式; 第三范式(3NF)：一个表中不能包涵其他相关表中非关键字段的信息,即数据表不能有沉余字段;备注：必须先满足第二范式;

  - 表字段少而精

    - I/O高效
    - 字段分开维护简单
    - 单表1G体积 500W⾏行评估
    - 单行不超过200Byte
    - 单表不超过50个INT字段
    - 单表不超过20个CHAR(10)字段
    - 建议单表字段数控制在20个以内
    - 拆分TEXT/BLOB，TEXT类型处理性能远低于VARCHAR，强制生成硬盘临时表浪费更多空间。

## group by查询松散索引扫描（Loose Index Scan）与紧凑索引扫描（Tight Index Scan）[链接]（<http://isky000.com/database/mysql_group_by_implement）>

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

```
//查询时间
$sql = "select date_format(create_time, '%Y-%m-%d') as day from table_name";
//int 时间戳类型
$sql = "select from_unixtime(create_time, '%Y-%m-%d') as day from table_name";

//一个sql返回多个总数
$sql = "select count(*) all, " ;
$sql .= " count(case when status = 1 then status end) status_1_num, ";
$sql .= " count(case when status = 2 then status end) status_2_num ";
$sql .= " from table_name";
//Update Join / Delete Join
$sql = "update table_name_1 ";
$sql .= " inner join table_name_2 on table_name_1.id = table_name_2.uid ";
$sql .= " inner join table_name_3 on table_name_3.id = table_name_1.tid ";
$sql .= " set *** = *** ";
$sql .= " where *** ";
//delete join 同上。

//替换某字段的内容的语句
$sql = "update table_name set content = REPLACE(content, 'aaa', 'bbb') ";
$sql .= " where (content like '%aaa%')";
//获取表中某字段包含某字符串的数据
$sql = "SELECT * FROM `表名` WHERE LOCATE('关键字', 字段名) ";
//获取字段中的前4位
$sql = "SELECT SUBSTRING(字段名,1,4) FROM 表名 ";
//查找表中多余的重复记录
//单个字段
$sql = "select * from 表名 where 字段名 in ";
$sql .= "(select 字段名 from 表名 group by 字段名 having count(字段名) > 1 )";
//多个字段
$sql = "select * from 表名 别名 where (别名.字段1,别名.字段2) in ";
$sql .= "(select 字段1,字段2 from 表名 group by 字段1,字段2 having count(*) > 1 )";
//删除表中多余的重复记录(留id最小)
//单个字段
$sql = "delete from 表名 where 字段名 in ";
$sql .= "(select 字段名 from 表名 group by 字段名 having count(字段名) > 1)  ";
$sql .= "and 主键ID not in ";
$sql .= "(select min(主键ID) from 表名 group by 字段名 having count(字段名 )>1) ";
//多个字段
$sql = "delete from 表名 别名 where (别名.字段1,别名.字段2) in ";
$sql .= "(select 字段1,字段2 from 表名 group by 字段1,字段2 having count(*) > 1) ";
$sql .= "and 主键ID not in ";
$sql .= "(select min(主键ID) from 表名 group by 字段1,字段2 having count(*)>1) ";
```

- 业务篇

```
//创建测试表
CREATE TABLE `test_number` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `number` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '数字',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

//创建测试数据
insert into test_number values(1,1);
insert into test_number values(2,2);
insert into test_number values(3,3);
insert into test_number values(4,5);
insert into test_number values(5,7);
insert into test_number values(6,8);
insert into test_number values(7,10);
insert into test_number values(8,11);


求数字的连续范围。

select min(number) start_range,max(number) end_range
from
(
    select number,rn,number-rn diff from
    (
        select number,@number:=@number+1 rn from test_number,(select @number:=0) as number
    ) b
) c group by diff;

签到问题

//创建参考表(模拟数据需要用到)
CREATE TABLE `test_nums` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='参考表';

//创建测试表
CREATE TABLE `test_sign_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '签到时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='签到历史表';

//创建测试数据
insert into test_sign_history(uid,create_time)
select ceil(rand()*10000),str_to_date('2016-12-11','%Y-%m-%d')+interval ceil(rand()*10000) minute
from test_nums where id<31;

//统计每天的每小时用户签到情况
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

//统计每天的每小时用户签到情况(当某个小时没有数据时，显示0)
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

//统计每天的用户签到数据和每天的增量数据
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

//模拟不同的用户签到了不同的天数
insert into test_sign_history(uid,create_time)
select uid,create_time + interval ceil(rand()*10) day from test_sign_history,test_nums
where test_nums.id <10 order by rand() limit 150;

//统计签到天数相同的用户数量
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

//统计每个用户的连续签到时间
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
```

### [优化策略](http://www.techug.com/post/mysql-20-plus-tips.html)

- 优化查询缓存

```
// query cache does NOT work 因为功能返回的结果是可变的。MySQL决定禁用查询器的查询缓存
$r = mysql_query("SELECT username FROM user WHERE signup_date >= CURDATE()");
// query cache works!
$today = date("Y-m-d");
$r = mysql_query("SELECT username FROM user WHERE signup_date >= '$today'");
```

- EXPLAIN你的选择查询:帮助了解MySQL是怎样运行你的查询的,索引、扫描范围
- 获取唯一行时使用LIMIT 1
- 索引搜索字段：索引不仅仅是为了主键或唯一键。如果会在你的表中按照任何列搜索，你就都应该索引它们。
- 索引并对连接使用同样的字段类型：包含许多连接查询, 你需要确保连接的字段在两张表上都建立了索引，使用同样类型，相同的字符类型
- 不要ORDER BY RAND()：

```
$r = mysql_query("SELECT count(*) FROM user");
$d = mysql_fetch_row($r);
$rand = mt_rand(0,$d[0] - 1);
$r = mysql_query("SELECT username FROM user LIMIT $rand, 1");
```

- 避免使用SELECT *:从数据表中读取的数据越多，查询操作速度就越慢。它增加了磁盘操作所需的时间。此外，当数据库服务器与Web服务器分开时，由于必须在服务器之间传输数据，将会有更长的网络延迟。指定你需要的列
- 几乎总是有一个id字段:每个以id列为PRIMARY KEY的数据表中，优先选择AUTO_INCREMENT或者INT. VARCHAR字段作为主键（检索）速度较慢.一个可能的例外是"关联表"，用于两个表之间的多对多类型的关联。例如，"posts_tags"表中包含两列：post_id，tag_id，用于保存表名为"post"和"tags"的两个表之间的关系。这些表可以具有包含两个id字段的PRIMARY键。
- 相比VARCHAR优先使用ENUM:ENUM枚举类型是非常快速和紧凑的。在内部它们像TINYINT一样存储，但它们可以包含和显示字符串值。一个字段只包含几种不同的值，请使用ENUM而不是VARCHAR
- 通过PROCEDURE ANALYZE()获取建议：使用MySQL分析列结构和表中的实际数据，为你提供一些建议。它只有在数据表中有实际数据时才有用，因为这在分析决策时很重要。
- 如果可以的话使用NOT NULL：问一下你自己在空字符串值和NULL值之间（对应INT字段：0 vs. NULL）是否有任何的不同.如果没有理由一起使用这两个。NULL列需要额外的空间，他们增加了你的比较语句的复杂度。
- 预处理语句：预处理语句默认情况下会过滤绑定到它的变量，这对于避免SQL注入攻击极为有效。当然你也可以指定要过滤的变量。但这些方法更容易出现人为错误，也更容易被程序员遗忘。

```
if ($stmt = $mysqli->prepare("SELECT username FROM user WHERE state=?")) {
$stmt->bind_param("s", $state);
$stmt->execute();
$stmt->bind_result($username);
$stmt->fetch();
printf("%s is from %sn", $username, $state);
$stmt->close();
}
```

- 无缓冲查询:通常当你从脚本执行一个查询，在它可以继续后面的任务之前将需要等待查询执行完成。你可以使用无缓冲的查询来改变这一情况。"mysql_unbuffered_query() 发送SQL查询语句到MySQL不会像 mysql_query()那样自动地取并缓冲结果行。这让产生大量结果集的查询节省了大量的内存，在第一行已经被取回时你就可以立即在结果集上继续工 作，而不用等到SQL查询被执行完成。"有一定的局限性。你必须在执行另一个查询之前读取所有的行或调用mysql_free_result() 。另外你不能在结果集上使用mysql_num_rows() 或 mysql_data_seek() 。
- 使用 UNSIGNED INT 存储IP地址：在查询中可以使用 INET_ATON() 来把一个IP转换为整数，用 INET_NTOA() 来进行相反的操作。在 PHP 也有类似的函数，ip2long() 和 long2ip()。 `$r = "UPDATE users SET ip = INET_ATON('{$_SERVER['REMOTE_ADDR']}') WHERE user_id = $user_id";`
- 固定长度（静态）的表会更快：所有列都是"固定长度"，那么这个表被认为是"静态"或"固定长度"的。不固定的列类型包括 VARCHAR、TEXT、BLOB等。即使表中只包含一个这些类型的列，这个表就不再是固定长度的，MySQL 引擎会以不同的方式来处理它。固定长度的表会提高性能，因为 MySQL 引擎在记录中检索的时候速度会更快。它们也易于缓存，崩溃后容易重建。不过它们也会占用更多空间
- 垂直分区是为了优化表结构而对其进行纵向拆分的行为。将低频信息放到另一个表中，这样你的主用户表就会更小。如你所知，表越小越快。例子：last_login" 字段，用户每次登录网站都会更新这个字段，而每次更新都会导致这个表缓存的查询数据被清空。这种情况下你可以将那个字段放到另一张表里，保持用户表更新量最小。
- 拆分大型DELETE或INSERT语句：执行大型DELETE或INSERT查询，则需要注意不要影响网络流量。当执行大型语句时，它会锁表并使你的Web应用程序停止。Apache运行许多并行进程/线程。 因此它执行脚本效率很高。所以服务器不期望打开过多的连接和进程，这很消耗资源，特别是内存。如果你锁表很长时间（如30秒或更长），在一个高流量的网站，会导致进程和查询堆积，处理这些进程和查询可能需要很长时间，最终甚至使你的网站崩溃。维护脚本需要删除大量的行，只需使用LIMIT子句，以避免阻塞。`while (1) { mysql_query("DELETE FROM logs WHERE log_date`
- 越少的列越快:对于数据库引擎，磁盘可能是最重要的瓶颈。更小更紧凑的数据、减少磁盘传输量，通常有助于性能提高。如果已知表具有很少的行，则没有理由是主键类型为INT，可以用MEDIUMINT、SMALLINT代替，甚至在某些情况下使用TINYINT。 如果不需要完整时间记录，请使用DATE而不是DATETIME。
- 选择正确的存储引擎:MyISAM适用于读取繁重的应用程序，但是当有很多写入时它不能很好地扩展。 即使你正在更新一行的一个字段，整个表也被锁定，并且在语句执行完成之前，其他进程甚至无法读取该字段。 MyISAM在计算SELECT COUNT（*）的查询时非常快。InnoDB是一个更复杂的存储引擎，对于大多数小的应用程序，它比MyISAM慢。 但它支持基于行的锁定，使其更好地扩展。 它还支持一些更高级的功能，比如事务。
- 使用对象关系映射器（ORM, Object Relational Mapper）:ORM以"延迟加载"著称。这意味着它们仅在需要时获取实际值。但是你需要小心处理他们，否则你可能最终创建了许多微型查询，这会降低数据库性能。ORM还可以将多个查询批处理到事务中，其操作速度比向数据库发送单个查询快得多。PHP-ORM是Doctrine
- 小心使用持久连接:持久连接意味着减少重建连接到MySQL的成本。 当持久连接被创建时，它将保持打开状态直到脚本完成运行。 因为Apache重用它的子进程，下一次进程运行一个新的脚本时，它将重用相同的MySQL连接。`mysql_pconnect()`,可能会出现连接数限制问题、内存问题等等。


### B+Tree树结构的索引规则

前缀索引：索引很长的字符列，这会增加索引的存储空间以及降低索引的效率。选择字符列的前n个字符作为索引，这样可以大大节约索引空间，从而提高索引效率。要选择足够长的前缀以保证高的选择性，同时又不能太长。无法使用前缀索引做ORDER BY 和 GROUP BY以及使用前缀索引做覆盖扫描。
```
CREATE TABLE user_test( 
  id int AUTO_INCREMENT PRIMARY KEY, 
  user_name varchar(30) NOT NULL,
  sex bit(1) NOT NULL DEFAULT b'1', 
  city varchar(50) NOT NULL,  
  age int NOT NULL
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
ALTER TABLE user_test ADD INDEX idx_user(user_name , city , age);
通过以下方法
SELECT COUNT(DISTINCT index_column)/COUNT(*) FROM table_name; -- index_column代表要添加前缀索引的列，前缀索引的选择性比值，比值越高说明索引的效率也就越高效。
SELECT COUNT(DISTINCT LEFT(index_column,1))/COUNT(*),COUNT(DISTINCT LEFT(index_column,2))/COUNT(*),COUNT(DISTINCT LEFT(index_column,3))/COUNT(*)
...FROM table_name;
ALTER TABLE table_name ADD INDEX index_name (index_column(length));
```
组合索引：创建索引列的顺序非常重要，正确的索引顺序依赖于使用该索引的查询方式.对于组合索引的索引顺序可以通过经验法则来帮助我们完成：将选择性最高的列放到索引最前列，该法则与前缀索引的选择性方法一致，但并不是说所有的组合索引的顺序都使用该法则就能确定，还需要根据具体的查询场景来确定具体的索引顺序。

聚簇索引：决定数据在物理磁盘上的物理排序，一个表只能有一个聚集索引，如果定义了主键，那么 InnoDB 会通过主键来聚集数据，如果没有定义主键，InnoDB 会选择一个唯一的非空索引代替，如果没有唯一的非空索引，InnoDB 会隐式定义一个主键来作为聚集索引。
聚集索引可以很大程度的提高访问速度，因为聚集索引将索引和行数据保存在了同一个 B-Tree 中，所以找到了索引也就相应的找到了对应的行数据，但在使用聚集索引的时候需注意避免随机的聚集索引（一般指主键值不连续，且分布范围不均匀）。如使用 UUID 来作为聚集索引性能会很差，因为 UUID 值的不连续会导致增加很多的索引碎片和随机I/O，最终导致查询的性能急剧下降。

非聚集索引：与聚集索引不同的是非聚集索引并不决定数据在磁盘上的物理排序，且在 B-Tree 中包含索引但不包含行数据，行数据只是通过保存在 B-Tree 中的索引对应的指针来指向行数据，如：上面在（user_name，city, age）上建立的索引就是非聚集索引。

覆盖索引：索引（如：组合索引）中包含所有要查询的字段的值，查看是否使用了覆盖索引可以通过执行计划中的Extra中的值为Using index

#### 有效索引

- 全值匹配：`SELECT * FROM user_test WHERE user_name = 'feinik' AND age = 26 AND city = '广州';`
- 匹配最左前缀:可用于查询条件为：（user_name ）、（user_name, city）、（user_name , city , age）,满足最左前缀查询条件的顺序与索引列的顺序无关
- 匹配范围值:`SELECT * FROM user_test WHERE user_name LIKE 'feinik%';`

#### 无效索引

```
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

```
SELECT user_name, city, age FROM user_test ORDER BY user_name;
SELECT user_name, city, age FROM user_test ORDER BY user_name, city;
SELECT user_name, city, age FROM user_test ORDER BY user_name DESC, city DESC;
SELECT user_name, city, age FROM user_test WHERE user_name = 'feinik' ORDER BY city;
```

[索引性能分析](http://draveness.me/sql-index-performance.html)
[MySQL主从同步](http://geek.csdn.net/news/detail/236754)
