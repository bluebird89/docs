# Ops

## 服务优化

```sh
ps auxw|head -1;ps auxw|sort -rn -k4|head -40
```

## 问题

* top、iostat查看cpu、内存及io占用情况：内核、程序参数设置不合理。查看有没有报内核错误，连接数用户打开文件数这些有没有达到上限等等
* 链路本身慢：是否跨运营商、用户上下行带宽不够、dns解析慢、服务器内网广播风暴什么的
* 程序设计不合理：是否程序本身算法设计太差，数据库语句太过复杂或者刚上线了什么功能引起的
* 其它关联的程序引起的：如果要访问数据库，检查一下是否数据库访问慢
* 是否被攻击了：看服务器是否被DDos了等等
* 硬件故障：这个一般直接服务器就挂了，而不是访问慢

## 工具

- [apex/up](https://github.com/apex/up):Deploy infinitely scalable serverless apps, apis, and sites in seconds. https://apex.github.io/up/
- [apex/apex](https://github.com/apex/apex):Build, deploy, and manage AWS Lambda functions with ease (with Go support!). http://apex.run
- [spinnaker/spinnaker](https://github.com/spinnaker/spinnaker):Spinnaker is an open source, multi-cloud continuous delivery platform for releasing software changes with high velocity and confidence. http://www.spinnaker.io/

## 参考

* [liquanzhou/ops_doc](https://github.com/liquanzhou/ops_doc):运维简洁实用手册
