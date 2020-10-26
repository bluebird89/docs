# [spring-projects/spring-boot](https://github.com/spring-projects/spring-boot)

Spring Boot http://projects.spring.io/spring-boot

* Spring Boot 执行器提供 restful 服务，以访问在生产环境中运行程序的当前状态。在执行器的帮助下，你可以检查各种指标并监控自己的程序。

* Spring Cloud 为开发人员提供了一些快速构建分布式系统常见模式的工具（例如配置管理、服务发现、断路器、智能路由、领导选举、分布式会话、集群状态）。

* Spring Boot 开发分布式微服务时，我们面临的一些问题可以由 Spring Cloud 解决。

  - **与分布式系统相关的复杂性 -  **这包括网络问题、延迟开销、带宽问题、安全问题。
  - **处理服务发现的能力 -  **服务发现允许群集中的进程和服务找到彼此并进行通信。
  - **解决了冗余问题 -  **冗余问题经常发生在分布式系统中。
  - 负载平衡  - 改进跨多种计算资源（如计算机集群、网络链接、中央处理单元）的工作负载分配。
  - **减少性能问题 -  **减少因各种操作开销导致的性能问题。

## install

```sh
sdk install springboot
sdk ls springboot

brew tap pivotal/tap
brew install springboot

spring --version
```

## 初始化

* IDEA 中 Spring Initalizr 模版
* [Spring Initalizr](https://start.spring.io/):bootstrap your application

## 使用

```sh
gradlew bootRun --debug-jvm # 调试
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
  - 考虑以下几点
    + 向客户端提供格式统一的异常返回
    + 异常信息中应该包含足够多的上下文信息，最好是结构化的数据以便于客户端解析
    + 不同类型的异常应该包含唯一标识，以便客户端精确识别
  - 形式
    + 层级式的，即每种具体的异常都对应了一个异常类，这些类最终继承自某个父异常.能够显式化异常含义，但是如果层级设计不好可能导致整个程序中充斥着大量的异常类
    + 单一式的，即整个程序中只有一个异常类，再以一个字段来区分不同的异常场景.好处是简单，而其缺点在于表意性不够
* 后台任务与分布式锁
  - Spring原生提供了任务处理(TaskExecutor)和任务计划(TaskSchedulor)机制
  - 在分布式场景下，还需要引入分布式锁来解决并发冲突，为此我们引入一个轻量级的分布式锁框架ShedLock
* 统一代码风格
  - 客户端的请求数据类统一使用相同后缀，比如Command
  - 返回给客户端的数据统一使用相同后缀，比如Represetation
  - 统一对请求处理的流程框架，比如采用传统的3层架构或者DDD战术模式
  - 提供一致的异常返回（请参考“异常处理”小节）
  - 提供统一的分页结构类
  - 明确测试分类以及统一的测试基础类
* 静态代码检查
  - Checkstyle：用于检查代码格式，规范编码风格
  - Spotbugs：Findbugs的继承者
  - Dependency check：OWASP提供的Java类库安全性检查
  - Sonar：用于代码持续改进的跟踪
* API文档
* 数据库迁移：采用了Flyway作为数据库迁移工具，加入了Flyway依赖后，在src/main/sources/db/migration目录下创建迁移脚本文件
* 多环境构建
  - local：用于开发者本地开发
  - ci：用于持续集成
  - dev：用于前端开发联调
  - qa：用于测试人员
  - uat：类生产环境，用于功能验收(有时也称为staging环境)
  - prod：正式的生产环境
* CORS：采用CORS机制

```java
//request id in header may come from Gateway, eg. Nginx
String headerRequestId = request.getHeader(HEADER_X_REQUEST_ID);
MDC.put(REQUEST_ID, isNullOrEmpty(headerRequestId) ? newUuid() : headerRequestId);

// 层级实例
## AppException
public abstract class AppException extends RuntimeException {
    private final ErrorCode code;
    private final Map<String, Object> data = newHashMap();
}

public class OrderNotFoundException extends AppException {
    public OrderNotFoundException(OrderId orderId) {
        super(ErrorCode.ORDER_NOT_FOUND, ImmutableMap.of("orderId", orderId.toString()));
    }
}

// 客户端 统一异常格式
public final class ErrorDetail {
    private final ErrorCode code;
    private final int status;
    private final String message;
    private final String path;
    private final Instant timestamp;
    private final Map<String, Object> data = newHashMap();
}

// 最终返回客户端的数据
{
  requestId: "d008ef46bb4f4cf19c9081ad50df33bd",
  error: {
    code: "ORDER_NOT_FOUND",
    status: 404,
    message: "没有找到订单",
    path: "/order",
    timestamp: 1555031270087,
    data: {
      orderId: "123456789"
    }
  }
}

## 任务配置
@Configuration
@EnableAsync
@EnableScheduling
public class SchedulingConfiguration implements SchedulingConfigurer {

    @Override
    public void configureTasks(ScheduledTaskRegistrar taskRegistrar) {
        taskRegistrar.setScheduler(newScheduledThreadPool(10));
    }

    @Bean(destroyMethod = "shutdown")
    @Primary
    public TaskExecutor taskExecutor() {
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
        executor.setCorePoolSize(2);
        executor.setMaxPoolSize(5);
        executor.setQueueCapacity(10);
        executor.setTaskDecorator(new LogbackMdcTaskDecorator());
        executor.initialize();
        return executor;
    }

}
// 实现
@Scheduled(cron = "0 0/1 * * * ?")
@SchedulerLock(name = "scheduledTask", lockAtMostFor = THIRTY_MIN, lockAtLeastFor = ONE_MIN)
public void run() {
    logger.info("Run scheduled task.");
}

## 配置Shedlock：
@Configuration
@EnableSchedulerLock(defaultLockAtMostFor = "PT30S")
public class DistributedLockConfiguration {

    @Bean
    public LockProvider lockProvider(DataSource dataSource) {
        return new JdbcTemplateLockProvider(dataSource);
    }

    @Bean
    public DistributedLockExecutor distributedLockExecutor(LockProvider lockProvider) {
        return new DistributedLockExecutor(lockProvider);
    }
}

// 基于Shedlock的LockProvider创建DistributedLockExecutor：
public class DistributedLockExecutor {
    private final LockProvider lockProvider;

    public DistributedLockExecutor(LockProvider lockProvider) {
        this.lockProvider = lockProvider;
    }

    public <T> T executeWithLock(Supplier<T> supplier, LockConfiguration configuration) {
        Optional<SimpleLock> lock = lockProvider.lock(configuration);
        if (!lock.isPresent()) {
            throw new LockAlreadyOccupiedException(configuration.getName());
        }

        try {
            return supplier.get();
        } finally {
            lock.get().unlock();
        }
    }

}
// 使用
public String doBusiness() {
    return distributedLockExecutor.executeWithLock(() -> "Hello World.",
            new LockConfiguration("key", Instant.now().plusSeconds(60)));
}

## CORS配置
@Configuration
public class CorsConfiguration {
    @Bean
    public WebMvcConfigurer corsConfigurer() {
        return new WebMvcConfigurer() {
            @Override
            public void addCorsMappings(CorsRegistry registry) {
                registry.addMapping("/**");
            }
        };
    }
}
```

## Flyway

* 独立于数据库的应用、管理并跟踪数据库变更的数据库版本管理工具,实现自动化的数据库版本管理，并且能够记录数据库版本更新记录
* resources/db/migration 目录下创建需要执行的 SQL 脚本即可。SQL 脚本命名规范
  - Prefix 前缀：V 代表版本迁移，U 代表撤销迁移，R 代表可重复迁移
  - Version 版本号：版本号通常 . 和整数组成
  - Separator 分隔符：固定由两个下划线 __ 组成
  - Description 描述：由下划线分隔的单词组成，用于描述本次迁移的目的
  - Suffix 后缀：如果是 SQL 文件那么固定由 .sql 组成，如果是基于 Java 类则默认不需要后缀

```
# pom.xml 加入如下依赖集成 Flyway：
<dependency>
    <groupId>org.flywaydb</groupId>
    <artifactId>flyway-core</artifactId>
    <version>5.2.4</version>
</dependency>

# 在 application.yml 中写入 mysql 的配置及 Flyway 的相关配置(Flyway locations 默认读取当前项目下的 resources/db/migration 目录)
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.datasource.url=jdbc:mysql://localhost:3306/test?serverTimezone=UTC
spring.datasource.username=root
spring.datasource.password=123

spring.flyway.locations=classpath:/db/migration/
```

## Spring Cloud

* 基于Spring Boot实现的微服务架构开发工具。它为微服务架构中设计的配置管理，服务治理，断路器，智能路由，微代理，控制总线，全局锁，决策竞选，分布式会话和集群状态管理等操作提供了一种简单的开发方式
* 子项目
  - Spring Cloud Config：配置管理工具，支持使用Git存储配置内容，可以使用它实现应用配置的外部化存储，并支持客户端配置信息刷新，加密/解密配置内容等。
  - Spring Cloud Netflix：核心组件，对多个Netflix OSS开源套件进行整合
    + Eureka：服务治理组件，包含服务注册中心、服务注册与发现机制的实现
    + Hystrix：容错管理组件，实现断路器模式，帮助服务依赖中出现的延迟和为故障提供强大的容错能力
    + Ribbon：客户端负载均衡的服务调用组件
    + Feign：基于Ribbon和Hystrix的声明式服务调用组件
    + Zuul：网关组件，提供智能路由、访问过滤等功能
    + Archaius：外部化配置组件
  - Spring Cloud Bus：事件、消息总线，用于传播集群中的状态变化或事件，以触发后续的处理，比如用来动态刷新配置。
  - Spring Cloud Cluster：针对ZooKeeper、Redis、Hazelcast、Consul的选举算法和通用状态模式的实现。
  - Spring Cloud Consul：服务发现与配置管理工具。
  - Spring Cloud Stream：通过Redis、Rabbit或者Kafka实现的消费微服务，可以通过简单的声明式模型来发送和接收消息。
  - Spring Cloud Security：安全工具包，提供在Zuul代理中对OAuth2客户端请求的中继器。
  - Spring Cloud Sleuth：Spring Cloud 应用的分布式跟踪实现，可以完美整合 Zipkin。
  - Spring Cloud ZooKeeper：基于ZooKeeper 的服务发现与配置管理组件。
  - Spring Cloud Starters：Spring Cloud 的基础组件，它是基于Spring Boot 风格项目的基础依赖模块。

## 问题

```
javax.net.ssl.SSLException
MESSAGE: closing inbound before receiving peer's close_notify

在spring配置文件中 src/main/resources/application.yaml url前添加一句话：useSSL=false
url: jdbc:mysql://localhost:13306/ecommerce_order_mysql?allowMultiQueries=true&useUnicode=true&characterEncoding=UTF-8&connectionCollation=utf8mb4_bin&useServerPrepStmts=false&rewriteBatchedStatements=true&useSSL=false
```

## 教程

* [JeffLi1993/springboot-learning-example](https://github.com/JeffLi1993/springboot-learning-example):spring boot 实践学习案例，是 spring boot 初学者及核心技术巩固的最佳实践。
* [ityouknow/spring-boot-examples](https://github.com/ityouknow/spring-boot-examples):about learning Spring Boot via examples. Spring Boot 技术栈示例代码，快速简单上手教程。 http://www.ityouknow.com/
* [Spring Boot中文文档](http://cwiki.apachecn.org/display/SpringBoot)
* [eugenp/tutorials](https://github.com/eugenp/tutorials):The "REST With Spring" Course: http://bit.ly/restwithspring
* [spring-boot-demo](https://github.com/xkcoding/spring-boot-demo)
* [SpringBoot-Labs](https://github.com/YunaiV/SpringBoot-Labs)

## 项目

* [ityouknow/spring-boot-examples](https://github.com/ityouknow/spring-boot-examples):about learning Spring Boot via examples. Spring Boot 教程、技术栈示例代码，快速简单上手教程。 http://www.ityouknow.com/
* admin
  - [codecentric/spring-boot-admin](https://github.com/codecentric/spring-boot-admin):Admin UI for administration of spring boot applications
* [macrozheng/mall](https://github.com/macrozheng/mall):mall项目是一套电商系统，包括前台商城系统及后台管理系统，基于SpringBoot+MyBatis实现。 前台商城系统包含首页门户、商品推荐、商品搜索、商品展示、购物车、订单流程、会员中心、客户服务、帮助中心等模块。 后台管理系统包含商品管理、订单管理、会员管理、促销管理、运营管理、内容管理、统计报表、财务管理、权限管理、设置等模块。 http://39.98.69.210/index.html
* [vhr](https://github.com/lenve/vhr)

## 工具

* JaCoCo 一款代码测试覆盖率统计工具
* [JApiDocs](https://github.com/YeDaxia/JApiDocs):无需额外注解、开箱即用的SpringBoot接口文档生成工具 https://japidocs.agilestudio.cn/#/zh-cn/
* admin
  - [eladmin](https://github.com/elunez/eladmin)

## 参考

* [葬爱家族丶冷少](https://jiangyongkang.gitee.io)
* [qibaoguang / Spring-Boot-Reference-Guide](https://github.com/qibaoguang/Spring-Boot-Reference-Guide):Spring Boot Reference Guide 中文翻译 -《Spring Boot 参考指南》
* [Spring Boot 系列教程](https://www.cnblogs.com/vipstone/p/9967649.html)
* [最棒 Spring Boot 干货总结](https://mp.weixin.qq.com/s/tWV8lUznOIJwSUPPQlKJUg)
* https://blog.csdn.net/weixin_39800144/category_9271492.html
