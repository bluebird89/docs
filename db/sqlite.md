# SQLite3

```sql
# 连接
sqlite3

insert into mysql.user(Host,User,Password) values("localhost","test",password("1234"));

grant all privileges on testDB.* to test@localhost identified by '1234';

grant select,update on testDB.* to test@"%" identified by '1234';
# 删除用户
Delete FROM user Where User='test' and Host='localhost';
# 修改密码
update mysql.user set password=password('1234456') where User="test" and Host="localhost";
# 刷新系统权限
flush privileges;
# 退出
.exit
```

## 工具

* [sql.js](https://github.com/kripken/sql.js):SQLite compiled to JavaScript through Emscripten

## 参考

* [Let's Build a Simple Database](https://cstack.github.io/db_tutorial/)
