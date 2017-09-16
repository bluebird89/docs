# 数据库测试

## Mysql 压力测试工具 mysqlslap

mysqlslap 是 Mysql 自带的压力测试工具，可以模拟出大量客户端同时操作数据库的情况，通过结果信息来了解数据库的性能状况。mysqlslap 的一个主要工作场景就是对数据库服务器做基准测试

### 使用

- `mysqlslap –user=root –password=111111 –auto-generate-sql`:自动生成测试SQL
- mysqlslap –user=root –password=111111 –concurrency=100 –number-of-queries=1000 –auto-generate-sql:添加并发 客户端连接 总查询次数
- mysqlslap –user=root –password=111111 –concurrency=50 –number-int-cols=5 –number-char-cols=20 –auto-generate-sql：自动生成复杂表
- mysqlslap –user=root –password=111111 –concurrency=50 –create-schema=employees –query="SELECT _FROM dept_emp;"：使用自己的测试库和测试语句 `echo "SELECT_ FROM employees;SELECT _FROM titles;SELECT_ FROM dept_emp;SELECT _FROM dept_manager;SELECT_ FROM departments;" > ~/select_query.sql`
