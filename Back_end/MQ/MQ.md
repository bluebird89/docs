# 消息队列

消息队列作为成熟的异步通信模式，对比常用的同步通信模式，有如下优势：

- 解耦：防止引入过多的 API 给系统的稳定性带来风险；调用方使用不当会给被调用方系统造成压力，被调用方处理不当会降低调用方系统的响应能力。如果一个系统挂了，则不会影响另外个系统的继续运行。
- 削峰和流控：消息生产者不会堵塞，突发消息缓存在队列中，消费者按照实际能力读取消息。业务系统往往要求响应能力特别强，能够起到削峰填谷的作用。
- 复用：一次发布多方订阅。
- 业务系统往往有对消息的高可靠要求，以及有对复杂功能如 Ack 的要求。
- 增强业务系统的异步处理能力，减少甚至几乎不可能出现并发现象：

## 概念

- Push:生产
- pull：消费
- Hybrid：根据消费者状态

## 产品

- [PhxQueue](https://github.com/Tencent/phxqueue):[介绍](https://mp.weixin.qq.com/s?__biz=MjM5MDE0Mjc4MA==&mid=2650997820&idx=1&sn=c21021580f5474e6f570d1a1eada22bd&chksm=bdbefc6f8ac975791c85d2e9e8cb58a2c384d3daf29c4ac808789aa2281d2dd53c4d2baaf33d&mpshare=1&scene=1&srcid=09141b12nitpm39kMwTLxSIg&pass_ticket=T61h6XjBkARmtNGuhNVdyhTXYAlGFU%2Brx%2FhZrUNp8OOKx9ul0UwejPXkjaJ%2F3yFI#rd)
- [nsqio/nsq](https://github.com/nsqio/nsq) [文档](http://nsq.io/overview/quick_start.html)
- [apache/incubator-rocketmq](https://github.com/apache/incubator-rocketmq) a distributed messaging and streaming platform with low latency, high performance and reliability, trillion-level capacity and flexible scalability.
- [Apache ActiveMQ](link)
- [kr/beanstalkd](https://github.com/kr/beanstalkd):Beanstalk is a simple, fast work queue. http://kr.github.io/beanstalkd/

* 从社区活跃度：按照目前网络上的资料，RabbitMQ 、activeM 、ZeroMQ 三者中，综合来看，RabbitMQ 是首选。
* 持久化消息比较：ZeroMq 不支持，ActiveMq 和RabbitMq 都支持。持久化消息主要是指我们机器在不可抗力因素等情况下挂掉了，消息不会丢失的机制。
* 综合技术实现：可靠性、灵活的路由、集群、事务、高可用的队列、消息排序、问题追踪、可视化管理工具、插件系统等等。RabbitMq / Kafka 最好，ActiveMq 次之，ZeroMq 最差。当然ZeroMq 也可以做到，不过自己必须手动写代码实现，代码量不小。尤其是可靠性中的：持久性、投递确认、发布者证实和高可用性。
* 高并发：毋庸置疑，RabbitMQ 最高，原因是它的实现语言是天生具备高并发高可用的erlang 语言。
* 比较关注的比较， RabbitMQ 和 Kafka
    - RabbitMq 比Kafka 成熟，在可用性上，稳定性上，可靠性上，  RabbitMq  胜于  Kafka  （理论上）。
    - Kafka 的定位主要在日志等方面， 因为Kafka 设计的初衷就是处理日志的，可以看做是一个日志（消息）系统一个重要组件，针对性很强，所以 如果业务方面还是建议选择 RabbitMq 。
    - Kafka 的性能（吞吐量、TPS ）比RabbitMq 要高出来很多。

## 使用

- 弹幕

## 工具

* [apache/pulsar](https://github.com/apache/pulsar):Apache Pulsar - distributed pub-sub messaging system https://pulsar.apache.org
