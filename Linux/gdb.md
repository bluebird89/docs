# gdb

* 功能
  - Start your program, specifying anything that might affect its behavior.
  - Make your program stop on specified conditions.
  - Examine what has happened, when your program has stopped.
  - Change things in your program, so you can experiment with correcting the effects of one bug and go on to learn about another.
* 参数
  - info threads：查看全部线程
  - thread n：指定某个线程
  - b：在某处打断点
  - c：继续往下走
  - s：执行一行代码，如果代码函数调用，则进入函数
  - n：执行一行代码，函数调用不进入
  - p：打印某个变量值
  - list：打印代码的文本信息
  - bt：查看某个线程的栈帧
  - info b：查看当前所有断点信

```sh
yum install -y cmake make gcc gcc-c++ ncurses-devel bison gdb

wget https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-boost-5.7.25.tar.gz

tar zxvf mysql-boost-5.7.25.tar.gz
mkdir -p /gdb/mysql/
mkdir -p /gdb/data/

# DWITH_DEBUG=1 是最关键的，作用是开启DBUG
cmake -DCMAKE_INSTALL_PREFIX=/gdb/mysql/ -DMYSQL_DATADIR=/gdb/data/ -DSYSCONFDIR=/gdb/mysql/ -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_ARCHIVE_STORAGE_ENGINE=1 -DWITH_BLACKHOLE_STORAGE_ENGINE=1 -DWITH_FEDERATED_STORAGE_ENGINE=1 -DWITH_PARTITION_STORAGE_ENGINE=1 -DMYSQL_UNIX_ADDR=/gdb/mysql/mysql3.sock -DMYSQL_TCP_PORT=3306 -DENABLED_LOCAL_INFILE=1 -DEXTRA_CHARSETS=all -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DMYSQL_USER=mysql -DWITH_BINLOG_PREALLOC=ON -DWITH_BOOST=/gdb/mysql-5.7.25/boost/boost_1_59_0 -DWITH_DEBUG=1

make&&make install
```
