# RabbitMQ

RabbitMQ 是基于 AMQP 实现的一个开源消息组件，主要用于在分布式系统中存储转发消息，由因高性能、高可用以及高扩展而出名的 Erlang 语言写成。
其中，AMQP（Advanced Message Queuing Protocol，即高级消息队列协议），是一个异步消息传递所使用的应用层协议规范，为面向消息的中间件设计。

* 高可靠：RabbitMQ 提供了多种多样的特性让你在可靠性和性能之间做出权衡，包括持久化、发送应答、发布确认以及高可用性。
* 高可用队列：支持跨机器集群，支持队列安全镜像备份，消息的生产者与消费者不论哪一方出现问题，均不会影响消息的正常发出与接收。
* 灵活的路由：所有的消息都会通过路由器转发到各个消息队列中，RabbitMQ 内建了几个常用的路由器，并且可以通过路由器的组合以及自定义路由器插件来完成复杂的路由功能。
* 支持多客户端：对主流开发语言（如：Python、Ruby、.NET、Java、C、PHP、ActionScript 等）都有客户端实现。
* 集群：本地网络内的多个 Server 可以聚合在一起，共同组成一个逻辑上的 broker。
* 扩展性：支持负载均衡，动态增减服务器简单方便。
* 权限管理：灵活的用户角色权限管理，Virtual Host 是权限控制的最小粒度。
* 插件系统：支持各种丰富的插件扩展，同时也支持自定义插件，其中最常用的插件是 Web 管理工具 RabbitMQ_Management

![](../>>?_static/rabbitmq.png)

## 安装

```sh
brew install rabbitmq
brew services start rabbitmq # /usr/local/Cellar/rabbitmq/3.6.6/sbin/rabbitmq-server
# 访问 http://localhost:15672/  默认账号密码为guest

rabbitmqctl status
sudo rabbitmqctl list_queues # 查看队列状态
```

## 使用

* 单对单
* 单对多
* 发布订阅模式：Exchange Type 为 topic，发送消息时需要指定交换机及 Routing Key，消费者的消息队列绑定到该交换机并匹配到 Routing Key 实现消息的订阅，订阅后则可接收消息。只有消费者将队列绑定到该交换机且指定的 Routing Key 符合匹配规则，才能收到消息。Routing Key 可以设置成通配符，如：*或 #（*表示匹配 Routing Key 中的某个单词，# 表示任意的 Routing Key 的消息都能被收到）。如果 Routing Key 由多个单词组成，则单词之间用. 来分隔。
* 按路由规则发送接收
* 主题
* RPC（即远程存储调用）

## 参考

* [文档](http://www.rabbitmq.com/tutorials/tutorial-one-php.html)
* [rabbitmq/rabbitmq-server](https://github.com/rabbitmq/rabbitmq-server):Open source multi-protocol messaging broker https://www.rabbitmq.com/
* [rabbitmq/rabbitmq-tutorials](https://github.com/rabbitmq/rabbitmq-tutorials):Tutorials for using RabbitMQ in various ways http://www.rabbitmq.com/getstarted.html
* [rabbitmq](http://blog.csdn.net/column/details/rabbitmq.html)
