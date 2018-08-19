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

## 堡垒机

* 接入方式：
    - 透明桥方式接入网络
    - 旁路接入模式：请求通过堡垒机的权限检查后，堡垒机的应用代理模块将代替用户连接到目标设备完成该操作，之后目标设备将操作结果返回给堡垒机，最后堡垒机再将操作结果返回给运维操作人员。
        + 运维人员->堡垒机用户账号->授权->目标设备账号->目标设备
        + 管理员最重要的职责是根据相应的安全策略和运维人员应有的操作权限来配置堡垒机的安全策略。堡垒机管理员登录堡垒机后，在堡垒机内部，“策略管理”组件负责与管理员进行交互，并将管理员输入的安全策略存储到堡垒机内部的策略配置库中。
        + “应用代理”组件是堡垒机的核心，负责中转运维操作用户的操作并与堡垒机内部其他组件进行交互。“应用代理”组件收到运维人员的操作请求后调用“策略管理”组件对该操作行为进行核查，核查依据便是管理员已经配置好的策略配置库，如此次操作不符合安全策略“应用代理”组件将拒绝该操作行为的执行。
        + 运维人员的操作行为通过“策略管理”组件的核查之后“应用代理”组件则代替运维人员连接目标设备完成相应操作，并将操作返回结果返回给对应的运维操作人员；同时此次操作过程被提交给堡垒机内部的“审计模块”，然后此次操作过程被记录到审计日志数据库中。
        + 最后当需要调查运维人员的历史操作记录时，由审计员登录堡垒机进行查询，然后“审计模块”从审计日志数据库中读取相应日志记录并展示在审计员交互界面上。

## 工具

- [apex/up](https://github.com/apex/up):Deploy infinitely scalable serverless apps, apis, and sites in seconds. https://apex.github.io/up/
- [apex/apex](https://github.com/apex/apex):Build, deploy, and manage AWS Lambda functions with ease (with Go support!). http://apex.run
- [spinnaker/spinnaker](https://github.com/spinnaker/spinnaker):Spinnaker is an open source, multi-cloud continuous delivery platform for releasing software changes with high velocity and confidence. http://www.spinnaker.io/
* [gaia-pipeline/gaia](https://github.com/gaia-pipeline/gaia):Build powerful pipelines in any programming language.

## 参考

* [liquanzhou/ops_doc](https://github.com/liquanzhou/ops_doc):运维简洁实用手册
