# [spring-framework](https://github.com/spring-projects/spring-framework)

Spring Framework <http://spring.io/projects/spring-framework>

* 仅仅通过POJO来构建软件，它来负责框架搭建，各对象间的依赖，而你仅仅需要描述每个对象的职责
* 包含一整套的软件构建工具，同时也是高度模块化的，可以只选择所需要的功能
* 为了帮助程序员更好地应用设计模式，并且不需要程序员在代码中重新实现这些模式

## 核心技术

* IOC
  - 一个对象描述自己的依赖，而容器通过注入依赖来构造对象。所谓依赖也就是类的属性，构造函数的参数，或者工厂方法的参数
  - 核心库：org.springframework.beans ， org.springframework.context
  - 核心类：
    + BeanFactory提供对框架配置和基本功能。
    + ApplicationContext扩展BeanFactory，加入了简单的AOP。
    + 更特殊的，与应用类型相关的，有WebApplicationContext。
  - bean就是对象，是那些已经构造好的，组装完成的，或者是由容器管理的对象
    + Beans以及它们的依赖，都能在配置信息元数据中找到
  - 容器:接口org.springframework.context.ApplicationContext代表的是IOC容器，并由它负责实例化，配置，组装beans
    + 需要获取信息，来指示它该如何操作众多beans。这些信息被称为配置元数据，以多种形式存在，如XML，java注解，java code。你用它们来组装你的应用，表示各个对象间的依赖
    + ApplicationContext的常用实现 : ClassPathXmlApplicationContext , FileSystemXmlApplicationContext
* AOP

## core-container

* core和beans构成了spring的最基础的部分,包括IOC和DI。BeanFactory实现了工厂模式，无需程序员自己实现单例模式，并且实现了对配置和依赖说明的解耦。
* Context构建在Core and Beans之上：它类似于JNDI registry，用于登记和访问对象。它延续了Beans的特征，在此之上，还支持了国际化，事件分发, 资源加载, 某些容器上下文的无痕创建.同时也支持了某些JAVA EE的特征。ApplicationContext是它的核心。spring-context-support提供了对集成常见第三方库的支持。
* spring-expression使得程序员可以在运行时查询和操控对象。有点类似于反射。他在JSP2.1的unified expression language (unified EL) 加以扩展。

## AOP and instrumentation

* spring-aop支持aop编程，它允许程序员定义拦截器和切入点（pointcut）来方便地实现功能代码的解耦。同时，与.NET相似的一点，它可以使用元数据（例如，注解）来向已有代码中附加功能。
* spring-aspects是为了支持与AspectJ的结合。
* spring-instrument提供类级别的注入和一些能够用于特定应用服务器的classloader。spring-instrument-tomcat包含了对Tomcat的注入代理（instrumentation agent）

## Messaging

* 从spring framework 4开始引进spring-messaging以及一些源自于Spring Integration project的关键元素（如Message,MessageChannel,MessageHandler）。由此来提供对基于消息的应用的支持。这个模块与Spring MVC一样，提供了注解来实现消息和方法的映射

## Data Access/Integration

* 包含了JDBC, ORM, OXM, JMS, and Transaction
  - spring-jdbc提供了对JDBC的封装抽象，不必再有繁琐的编码，也不用再理会那些各种不同数据库的错误码。
  - spring-tx支持程序化(programmatic)和声明式(declarative)的事务管理，用于那些实现特殊接口的类型，或是POJO。
  - spring-orm支持与流行的对象-关系映射框架的集成，例如JPA，Hibernate。在使用O/R映射的同时，还能获得其余spring模块所给予的便利。
  - spring-oxm提供一种抽象，用于支持那些具体实现了对象-XML映射的框架，如JAXB,Castor,Jibx,XStream.
  - spring-jms包含对消息的处理（产生和消费）。自Spring Framework 4.1始，它还提供与spring-message的集成

## Web

* 包含了spring-web,spring-webmvc,spring-websocket模块。
  - spring-web提供基本的web功能(如multipart文件上传)以及使用Servlet listener 和基于web的应用上下文来初始化IOC 容器。它还包含一个http 客户端，以及Spring remoting support的与web相关的部分。
  - spring-webmvc包含了对于MVC和REST web service的实现。它用于清晰地分离实际业务代码和前端展示代码，并能与Spring框架地其余部分完美融合。

## Test

利用这个模块，可以通过Junit和TestNG对spring组件进行单元测试和集成测试。它提供对于Spring ApplicationContext的持续载入和缓存。也提供mock object来帮助你独立地测试代码

## 教程

* [tutorials](https://github.com/eugenp/tutorials)：The "REST With Spring" Course: <http://bit.ly/restwithspring>
* [SpringAll](https://github.com/wuyouzhuguli/SpringAll):循序渐进，学习Spring Boot、Spring Boot & Shiro、Spring Cloud、Spring Security & Spring Security OAuth2，博客Spring系列源码
* [Spring Boot应用集成Docker并结合Log4j2、Kafka、ELK管理Docker日志](https://www.jianshu.com/p/580144e51b9f)

## 参考

* [Spring Framework Reference Documentation](https://docs.spring.io/spring-framework/docs/5.0.0.M2/spring-framework-reference/htmlsingle/))
* [Spring 5](https://www.zybuluo.com/zhongjianxin/note/1199347)
