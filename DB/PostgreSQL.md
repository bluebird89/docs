# PostgreSQL

PostgreSQL是一个功能强大的开源对象关系数据库管理系统(ORDBMS)。 用于安全地存储数据; 支持最佳做法，并允许在处理请求时检索它们。PostgreSQL(也称为Post-gress-Q-L)全球志愿者团队)开发。 它不受任何公司或其他私人实体控制。 它是开源的，其源代码是免费提供的。 [官网](https://www.postgresql.org/)

## 安装

```sh
# mac
brew install postgres

brew services start/stop/restart postgresql
initdb /usr/local/var/postgres -E utf8 # 初始化数据库 ，配置数据存放目录

ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents # 配置自启动
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist

pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start #  启动 deamon
pg_ctl -D /usr/local/var/postgres stop -s -m fast #  关闭
```

## 使用

数据库跟当前系统管理员对应的数据库
Postgres uses an authentication scheme called "peer authentication" for local connections. Basically, this means that if the user's operating system username matches a valid Postgres username, that user can login with no further authentication.

```sql
sudo -u postgres psql # 登录

CREATE DATABASE myproject;
CREATE USER myprojectuser WITH PASSWORD 'password';

ALTER ROLE myprojectuser SET client_encoding TO 'utf8';
ALTER ROLE myprojectuser SET default_transaction_isolation TO 'read committed';
ALTER ROLE myprojectuser SET timezone TO 'UTC';

GRANT ALL PRIVILEGES ON DATABASE myproject TO myprojectuser;

createuser username -P # 创建用户，输入两次密码 passport
createdb dbname -O username -E UTF8 -e #  创建数据库  owner encoding
DROP DATABASE dbname;

psql -U username -d dbname -h 127.0.0.1   #  连接数据库

psql -d template1 # 创建属于自己的数据库

\q # exit

sudo systemctl status postgresql
sudo systemctl start postgresql
sudo systemctl enable postgresql
```

## 表操作

```postgresql
\l   # 显示已创建的数据库
psql \l  # 在不连接进 PostgreSQL 数据库的情况下，也可以在终端上查看显示已创建的列表：
\c dbname   # 连接数据库
\d  # 显示数据表
CREATE TABLE test(id int, text VARCHAR(50)); #  创建数据表
DROP TABLE test;

INSERT INTO test(id, text) VALUES(1, 'sdfsfsfsdfsdfdf');
SELECT * FROM test WHERE id = 1;
UPDATE test SET text = 'aaaaaaaaaaaaa' WHERE id = 1;
DELETE FROM test WHERE id = 1;
```

## 数据库升级

```sh
pg_ctl -D /usr/local/var/postgres stop # 数据迁移前，记得先关闭 PostgreSQL 的 postmaster 服务
launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist # Mac 下也可以这样关闭：

mv /usr/local/var/postgres /usr/local/var/postgres.old # 首先备份就版本的数据（默认是在 /usr/local/var/postgres 目录)

initdb /usr/local/var/postgres -E utf8 --locale=zh_CN.UTF-8 # 利用 initdb 命令再初始一个数据库文件：

pg_upgrade -b /usr/local/Cellar/postgresql/9.2.4/bin/ -B /usr/local/Cellar/postgresql/9.3.1/bin/ -d /usr/local/var/postgres.old -D /usr/local/var/postgres -v
```

## 封装

```php
define("HOST", "127.0.0.1");
define("PORT", 5432);
define("DBNAME", "dbname");
define("USER", "user");
define("PASSWORD", "password");

class Ext_Pgsql {

    # 单例
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
```

## 工具

* [PostgREST/postgrest](https://github.com/PostgREST/postgrest):REST API for any Postgres database https://postgrest.org
* [brianc/node-postgres](https://github.com/brianc/node-postgres):PostgreSQL client for node.js. https://node-postgres.com
* [dbcli/pgcli](https://github.com/dbcli/pgcli):Postgres CLI with autocompletion and syntax highlighting http://pgcli.com
* [timescale/timescaledb](https://github.com/timescale/timescaledb):An open-source time-series database optimized for fast ingest and complex queries. Engineered up from PostgreSQL, packaged as an extension. http://www.timescale.com/

## 客户端

- psql
- PgAdmin
- pgFouine
- [sosedoff/pgweb](https://github.com/sosedoff/pgweb):Cross-platform client for PostgreSQL databases http://sosedoff.github.io/pgweb

## 参考

* [digoal/blog](https://github.com/digoal/blog):Everything about database,bussiness. http://blog.163.com/digoal@126
* [bitemyapp/learnhaskell](https://github.com/bitemyapp/learnhaskell):Learn Haskell
* [dhamaniasad/awesome-postgres](https://github.com/dhamaniasad/awesome-postgres):A curated list of awesome PostgreSQL software, libraries, tools and resources, inspired by awesome-mysql
* [PostgreSQL Tutorial](http://www.postgresqltutorial.com/)
* [PostgreSQL 10.1 手册](http://www.postgres.cn/docs/10/)
