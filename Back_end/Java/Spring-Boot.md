# [spring-projects/spring-boot](https://github.com/spring-projects/spring-boot)

Spring Boot http://projects.spring.io/spring-boot

## install

```sh
sdk install springboot
sdk ls springboot

brew tap pivotal/tap
brew install springboot

spring --version
```

## 问题

```
javax.net.ssl.SSLException
MESSAGE: closing inbound before receiving peer's close_notify

在spring配置文件中 src/main/resources/application.yaml url前添加一句话：useSSL=false
url: jdbc:mysql://localhost:13306/ecommerce_order_mysql?allowMultiQueries=true&useUnicode=true&characterEncoding=UTF-8&connectionCollation=utf8mb4_bin&useServerPrepStmts=false&rewriteBatchedStatements=true&useSSL=false
```

## 结构

* 基于业务分包：再分别在包下创建与之相关的各个子包
* 自动化测试分类，通过Gradle提供的SourceSets对测试代码进行分类
    - 单元测试：src/test/java 核心的领域模型，包括领域对象(比如Order类)，Factory类，领域服务类等；
    - 组件测试：src/componentTest/java 不适合写单元测试但是又必须测试的类，比如Repository类，在有些项目中，这种类型测试也被称为集成测试；
    - API测试：src/apiTest/java 模拟客户端测试各个API接口，需要启动程序
* 日志处理
    - 日志中加入请求标识，便于链路追踪:一个请求的过程中的每条日志都共享统一的请求ID。使用Logback原生提供的MDC(Mapped Diagnostic Context)功能，创建一个RequestIdMdcFilter
    - 集中式日志管理：多节点部署的场景，引入诸如ELK之类的工具将日志统一输出到ElasticSearch中
* 异常处理
    - 向客户端提供格式统一的异常返回
    - 异常信息中应该包含足够多的上下文信息，最好是结构化的数据以便于客户端解析
    - 不同类型的异常应该包含唯一标识，以便客户端精确识别

```java
//request id in header may come from Gateway, eg. Nginx
String headerRequestId = request.getHeader(HEADER_X_REQUEST_ID);
MDC.put(REQUEST_ID, isNullOrEmpty(headerRequestId) ? newUuid() : headerRequestId);
```

## 项目

* [小柒2012 / spring-boot-seckill](https://gitee.com/52itstyle/spring-boot-seckill):从0到1构建分布式秒杀系统，脱离案例讲架构都是耍流氓 https://blog.52itstyle.vip/archives/2853/
* [ityouknow/spring-boot-examples](https://github.com/ityouknow/spring-boot-examples):about learning Spring Boot via examples. Spring Boot 教程、技术栈示例代码，快速简单上手教程。 http://www.ityouknow.com/
* admin
    - [codecentric/spring-boot-admin](https://github.com/codecentric/spring-boot-admin):Admin UI for administration of spring boot applications

## 教程

* [JeffLi1993/springboot-learning-example](https://github.com/JeffLi1993/springboot-learning-example):spring boot 实践学习案例，是 spring boot 初学者及核心技术巩固的最佳实践。
* [ityouknow/spring-boot-examples](https://github.com/ityouknow/spring-boot-examples):about learning Spring Boot via examples. Spring Boot 技术栈示例代码，快速简单上手教程。 http://www.ityouknow.com/
* [Spring Boot中文文档](http://cwiki.apachecn.org/display/SpringBoot)
* [eugenp/tutorials](https://github.com/eugenp/tutorials):The "REST With Spring" Course: http://bit.ly/restwithspring

## 工具

* [Spring Initalizr](https://start.spring.io/):bootstrap your application

## 参考

* [葬爱家族丶冷少](https://jiangyongkang.gitee.io)

* [Spring Boot 系列教程](https://www.cnblogs.com/vipstone/p/9967649.html)
* https://blog.csdn.net/weixin_39800144/category_9271492.html
