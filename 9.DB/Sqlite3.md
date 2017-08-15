
### Sqlite3 ###
- 连接：sqlite3
- 退出命令行：.exit

- 用户管理：
- 创建用户：    
        insert into mysql.user(Host,User,Password) values("localhost","test",password("1234"));

	- 添加权限：
        grant all privileges on testDB.* to test@localhost identified by '1234';
			grant select,update on testDB.* to test@"%" identified by '1234';
	- 删除用户：Delete FROM user Where User='test' and Host='localhost';
	- 修改密码：update mysql.user set password=password('新密码') where User="test" and Host="localhost";
	- 刷新系统权限：flush privileges;
