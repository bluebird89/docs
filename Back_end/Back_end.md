# 后端

服务器端

## 职能

* web项目开发
* 底层API封装与开发:为前端操作提供服务
* 线上系统的优化
* 线上服务器的运维，常见问题的诊断与解决。
* 存储：文件 信息 信息之间的关系（数据库）

## 技能

* 后端语言
    - PHP内核
* 语言生态：apache+php 常用的PHP和apache模块
* 框架：LN(A)MP架构
* 项目扩展
    - restful
    - MQ
        + RabbitMQ
    - solr
* OOP
* 前端：Javascript、XHTML、CSS、DIV ，Javascript 框架
* HTTP协议
* 数据库：Mysql 优化、能创建高效的索引
* nosql
* 消息中间件
* 模版引擎
* Linux与应用部署，Shell脚本
* 缓存：
    * Memcache
    * Redis
* 服务化

## 业务

* 设计、实现相关业务上的服务
* 底层框架代码以及线上系统优化

## 进阶

* 了解大容量、高性能的分布式系统开发原理
* 在开放平台，分布式存储，分布式Cache

## 趋势

* 异步模式：Go Dubbo.异步非阻塞的 Nginx，而不是同步阻塞的 Apache。就是因为 Nginx 这样的异步程序，它的适应性更好、并发能力更强。现在在后端业务开发编程方面，技术力量强的团队已经开始将技术栈从同步模式切换为异步了。
    - 同步阻塞模式存在较多缺陷，并发能力弱、适应性差、慢速请求导致服务不可用。如：后台接口中调用第三方 API 的场景，同步模式效果极差。过去那些使用 Java、PHP、C++、Python、Ruby 语言开发的同步阻塞模式框架，用的人越来越少。
* Node.js:很少见到企业将 Node.js 作为公司后端方面的主要编程语言.
    - 异步回调的技术方案，以及在它之上所做的一些优化方案，包括 Promise、Future、Yield/Generator、Async/Await 等，改变了程序开发的风格和习惯。使用这些技术方案是无法兼容已有程序的
* 协程模式，兼顾了同步阻塞的可维护性和异步非阻塞的高并发能力。将会成为未来后端开发领域的主流技术方案。
    - 协程模式只需要对已有项目代码进行少量调整就可以运行起来，甚至可以完全兼容老项目。只需要框架层进行兼容即可。
    - GO 是最耀眼的那一个。协程、通道、静态语言、性能、富编译、标准库丰富、生态完整、Google 等
    - PHP + Swoole 的技术栈，更适合快速开发、快速迭代、业务驱动的场景。毕竟动态语言比静态语言还是要更加灵活、开发效率更高。而 Go 更适合编写系统级软件、核心业务。

## 资源

* [Kickball/awesome-selfhosted](https://github.com/Kickball/awesome-selfhosted):This is a list of Free Software network services and web applications which can be hosted locally. Selfhosting is the process of locally hosting and managing applications instead of renting from SaaS providers. https://reddit.com/r/selfhosted
* [arialdomartini/Back-End-Developer-Interview-Questions](https://github.com/arialdomartini/Back-End-Developer-Interview-Questions):A list of back-end related questions you can be inspired from to interview potential candidates, test yourself or completely ignore
* [wx-chevalier/Backend-Series](https://github.com/wx-chevalier/Backend-Series):📚 服务端应用程序开发与系统架构/微服务架构与实践，服务端基础篇 | 微服务与云原生篇 | Spring 篇 | Node.js 篇 | DevOps 篇 | 信息安全与渗透测试篇
