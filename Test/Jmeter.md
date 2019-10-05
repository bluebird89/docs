# JMeter

Apache JMeter是Apache组织开发的基于Java的压力测试工具。用于对软件做压力测试，它最初被设计用于Web应用测试，但后来扩展到其他测试领域。 

* 用于测试静态和动态资源，例如静态文件、Java小服务程序、CGI 脚本、Java 对象、数据库、FTP 服务器等,测试数据库
* JMeter 可以用于对服务器、网络或对象模拟巨大的负载，来自不同压力类别下测试它们的强度和分析整体性能
* JMeter能够对应用程序做功能/回归测试，通过创建带有断言的脚本来验证你的程序返回了你期望的结果
* 为了最大限度的灵活性，JMeter允许使用正则表达式创建断言

## 安装

* 下载[链接](http://jmeter.apache.org/download_jmeter.cgi)
* 解压文件
* 运行：'sh bin/jmeter'(linux) 或 运行 bin/jmeter.bat(windows)

```sh
# Mac
brew install jmeter
jmeter
```

## 结构

* JMETER_HOME/lib:用来放使用的 jar 文件
* JMETER_HOME/lib/ext:用来放 JMeter 组件和扩展

## 使用

配置 测试计划

## 组件

* 配置元件（Config Element）：影响其作用范围内的所有元件。收集其作用范围的每一个sampler元件的信息并呈现。元件的作用域是靠测试计划的的树型结构中元件的父子关系来确定的
* 前置处理器（Pre Processors）：在其作用范围内的每一个sampler元件之前执行。
* 定时器（Timer）：对其作用范围内的每一个sampler 有效
* 取样器（sampler）：性能测试中向服务器发送请求，记录响应信息，记录响应时间的最小单元.不与其它元件发生交互作用的元件
* 后置处理器（Post Processors，只在有结果可用情况下执行）：在其作用范围内的每一个sampler元件之后执行。
* 断言（Assertions，只在有结果可用情况下执行）：对其作用范围内的每一个sampler 元件执行后的结果执行校验。
* 监听器（Listener，只在有结果可用情况下执行）：收集其作用范围的每一个sampler元件的信息并呈现。

### 作用域



## 流程

* 添加线程组（thread groups）:并发线程数量、间隔与循环次数
* 添加sampler请求：http访问实例
* 添加结果监听方式以及结果记录保存方式：添加动态参数用与不同测试

### 指标

* 数据库指标
    - User Connections：用户连接数，也就是数据库的连接数量；
    - Number of Deadlocks：数据库死锁；
    - Butter Cache Hit：数据库Cache的命中情况。

## 参考

* [User's Manual](http://jmeter.apache.org/usermanual/)
