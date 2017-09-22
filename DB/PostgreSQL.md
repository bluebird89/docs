# PostgreSQL

PostgreSQL是一个功能强大的开源对象关系数据库管理系统(ORDBMS)。 用于安全地存储数据; 支持最佳做法，并允许在处理请求时检索它们。PostgreSQL(也称为Post-gress-Q-L)全球志愿者团队)开发。 它不受任何公司或其他私人实体控制。 它是开源的，其源代码是免费提供的。 [官网](https://www.postgresql.org/)

## 工具

- psql
- PgAdmin
- pgFouine

## 安装

- mac：`brew install postgres`

## 使用

```
brew services start/stop/restart postgresql
initdb /usr/local/var/postgres -E utf8 //初始化数据库 ，配置数据存放目录

ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents //配置自启动
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist

pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start // 启动 deamon
pg_ctl -D /usr/local/var/postgres stop -s -m fast // 关闭

createuser username -P //创建用户，输入两次密码 passport
createdb dbname -O username -E UTF8 -e // 创建数据库  owner encoding
DROP DATABASE dbname;

psql -U username -d dbname -h 127.0.0.1   // 连接数据库
\l   \\ 显示已创建的数据库 link
psql \l  \\在不连接进 PostgreSQL 数据库的情况下，也可以在终端上查看显示已创建的列表：
\c dbname   \\ 连接数据库
\d  \\ 显示数据表
CREATE TABLE test(id int, text VARCHAR(50)); \\ 创建数据表
DROP TABLE test;

INSERT INTO test(id, text) VALUES(1, 'sdfsfsfsdfsdfdf');
SELECT * FROM test WHERE id = 1;
UPDATE test SET text = 'aaaaaaaaaaaaa' WHERE id = 1;
DELETE FROM test WHERE id = 1;pg_upgrade -b 旧版本的bin目录 -B 新版本的bin目录 -d 旧版本的数据目录 -D 新版本的数据目录 [其他选项...]

数据迁移前，记得先关闭 PostgreSQL 的 postmaster 服务
pg_ctl -D /usr/local/var/postgres stop
Mac 下也可以这样关闭：
launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
首先备份就版本的数据（默认是在 /usr/local/var/postgres 目录）：
mv /usr/local/var/postgres /usr/local/var/postgres.old
利用 initdb 命令再初始一个数据库文件：
initdb /usr/local/var/postgres -E utf8 --locale=zh_CN.UTF-8

pg_upgrade -b /usr/local/Cellar/postgresql/9.2.4/bin/ -B /usr/local/Cellar/postgresql/9.3.1/bin/ -d /usr/local/var/postgres.old -D /usr/local/var/postgres -v
```

```
<?php

define("HOST", "127.0.0.1");
define("PORT", 5432);
define("DBNAME", "dbname");
define("USER", "user");
define("PASSWORD", "password");

class Ext_Pgsql {

    //单例
    private static $instance = null;

    private $conn = null;

    private function __construct()
    {
        $this->conn = pg_connect("host=" . HOST . " port=" . PORT . " dbname=" . DBNAME . " user=" . USER . " password=" . PASSWORD) or die('Connect Failed : '. pg_last_error());
    }

    public function __destruct()
    {
        @pg_close($this->conn);
    }

    /**
     * 单例模式
     * @param $name
     */
    public static function getInstance()
    {
        if ( ! self::$instance )
        {
            self::$instance = new self();
        }
        return self::$instance;
    }

    /**
     * 获取记录
     */
    public function fetchRow($sql)
    {
        $ret = array();
        $rs = pg_query($this->conn, $sql);
        $ret = pg_fetch_all($rs);
        if ( ! is_array($ret) )
        {
            return array();
        }
        return $ret;
    }

    /**
     * 执行指令
     * @param string $sql
     */
    public function query($sql)
    {
        $result = pg_query($this->conn, $sql);
        if ( ! $result )
            die("SQL : {$sql} " . pg_last_error());
    }

    /**
     * 获取一条记录
     */
    public function fetchOne($sql)
    {
        $ret = array();
        $rs = pg_query($this->conn, $sql);
        $ret = pg_fetch_all($rs);
        if ( ! is_array($ret) )
        {
            return array();
        }
        return current($ret);
    }

}

?>
```