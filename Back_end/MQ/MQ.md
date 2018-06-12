# 消息队列

消息队列作为成熟的异步通信模式，对比常用的同步通信模式，有如下优势：

- 解耦：防止引入过多的 API 给系统的稳定性带来风险；调用方使用不当会给被调用方系统造成压力，被调用方处理不当会降低调用方系统的响应能力。如果一个系统挂了，则不会影响另外个系统的继续运行。
- 削峰和流控：消息生产者不会堵塞，突发消息缓存在队列中，消费者按照实际能力读取消息。业务系统往往要求响应能力特别强，能够起到削峰填谷的作用。
- 复用：一次发布多方订阅。
- 业务系统往往有对消息的高可靠要求，以及有对复杂功能如 Ack 的要求。
- 增强业务系统的异步处理能力，减少甚至几乎不可能出现并发现象：

双11的时候，当我们凌晨大量的秒杀和抢购商品，然后去结算的时候，就会发现，界面会提醒我们，让我们稍等，以及一些友好的图片文字提醒。而不是像前几年的时代，动不动就页面卡死，报错等来呈现给用户。

    在这业务场景中，我们就可以采用队列的机制来处理，因为同时结算就只能达到这么多。

AMQP，即Advanced Message Queuing Protocol，高级消息队列协议，是应用层协议的一个开放标准，为面向消息的中间件设计。消息中间件主要用于组件之间的解耦，消息的发送者无需知道消息使用者的存在，反之亦然。 AMQP的主要特征是面向消息、队列、路由（包括点对点和发布/订阅）、可靠性、安全。 RabbitMQ是一个开源的AMQP实现，服务器端用Erlang语言编写，支持多种客户端

* ConnectionFactory、Connection、Channel都是RabbitMQ对外提供的API中最基本的对象。
* Connection是RabbitMQ的socket链接，它封装了socket协议相关部分逻辑。
* ConnectionFactory为Connection的制造工厂。
* Channel是我们与RabbitMQ打交道的最重要的一个接口，我们大部分的业务操作是在Channel这个接口中完成的，包括定义Queue、定义Exchange、绑定Queue与Exchange、发布消息等。
* Queue（队列）是RabbitMQ的内部对象，用于存储消息。消息都只能存储在Queue中，生产者生产消息并最终投递到Queue中，消费者可以从Queue中获取消息并消费。多个消费者可以订阅同一个Queue，这时Queue中的消息会被平均分摊给多个消费者进行处理，而不是每个消费者都收到所有的消息并处理。
* Message acknowledgment:要求消费者在消费完消息后发送一个回执给RabbitMQ，RabbitMQ收到消息回执（Message acknowledgment）后才将该消息从Queue中移除；如果RabbitMQ没有收到回执并检测到消费者的RabbitMQ连接断开，则RabbitMQ会将该消息发送给其他消费者（如果存在多个消费者）进行处理
* Message durability:在RabbitMQ服务重启的情况下，也不会丢失消息，我们可以将Queue与Message都设置为可持久化的
* Prefetch count:通过设置prefetchCount来限制Queue每次发送给每个消费者的消息数，比如我们设置prefetchCount=1，则Queue每次给每个消费者发送一条消息；消费者处理完这条消息后Queue会再给该消费者发送一条消息。
* Exchange:生产者将消息发送到Exchange，由Exchange将消息路由到一个或多个Queue中
* routing key:*生产者在将消息发送给Exchange的时候，一般会指定一个routing key*，来指定这个消息的路由规则，而这个routing key需要与Exchange Type及binding key联合使用才能最终生效。 在Exchange Type与binding key固定的情况下（在正常使用时一般这些内容都是固定配置好的），我们的生产者就可以在发送消息给Exchange时，通过指定routing key来决定消息流向哪里。 RabbitMQ为routing key设定的长度限制为255 bytes。
* Binding:RabbitMQ中通过Binding将Exchange与Queue关联起来，这样RabbitMQ就知道如何正确地将消息路由到指定的Queue了
* Binding key:在绑定（Binding）Exchange与Queue的同时，一般会指定一个binding key；消费者将消息发送给Exchange时，一般会指定一个routing key；*当binding key与routing key相匹配时，消息将会被路由到对应的Queue中*。这个将在Exchange Types章节会列举实际的例子加以说明。 在绑定多个Queue到同一个Exchange的时候，这些Binding允许使用相同的binding key。 binding key 并不是在所有情况下都生效，它依赖于Exchange Type，比如fanout类型的Exchange就会无视binding key，而是将消息路由到所有绑定到该Exchange的Queue。
* Exchange Types:RabbitMQ常用的Exchange Type有fanout、direct、topic、headers这四种
    - fanout类型的Exchange路由规则非常简单，它会把所有发送到该Exchange的消息路由到所有与它绑定的Queue中。
    - direct类型的Exchange路由规则也很简单，它会把消息路由到那些binding key与routing key完全匹配的Queue中。
    - topic类型的Exchange在匹配规则上进行了扩展，它与direct类型的Exchage相似，也是将消息路由到binding key与routing key相匹配的Queue中，但这里的匹配规则有些不同，它约定：
        * routing key为一个句点号“. ”分隔的字符串（我们将被句点号“. ”分隔开的每一段独立的字符串称为一个单词），如“stock.usd.nyse”、“nyse.vmw”、“quick.orange.rabbit”
        * binding key与routing key一样也是句点号“. ”分隔的字符串，binding key中可以存在两种特殊字符“*”与“#”，用于做模糊匹配，其中“*”用于匹配一个单词，“#”用于匹配多个单词（可以是零个）
    - headers类型的Exchange不依赖于routing key与binding key的匹配规则来路由消息，而是根据发送的消息内容中的headers属性进行匹配。 在绑定Queue与Exchange时指定一组键值对；当消息发送到Exchange时，RabbitMQ会取到该消息的headers（也是一个键值对的形式），对比其中的键值对是否完全匹配Queue与Exchange绑定时指定的键值对；如果完全匹配则消息会路由到该Queue，否则不会路由到该Queue。 该类型的Exchange没有用到过（不过也应该很有用武之地）
    - MQ本身是基于异步的消息处理，前面的示例中所有的生产者（P）将消息发送到RabbitMQ后不会知道消费者（C）处理成功或者失败（甚至连有没有消费者来处理这条消息都不知道）。 但实际的应用场景中，我们很可能需要一些同步处理，需要同步等待服务端将我的消息处理完成后再进行下一步处理。这相当于RPC（Remote Procedure Call，远程过程调用）。在RabbitMQ中也支持RPC。
        + 客户端发送请求（消息）时，在消息的属性（MessageProperties ，在AMQP 协议中定义了14中properties ，这些属性会随着消息一起发送）中设置两个值replyTo （一个Queue 名称，用于告诉服务器处理完成后将通知我的消息发送到这个Queue 中）和correlationId （此次请求的标识号，服务器处理完成后需要将此属性返还，客户端将根据这个id了解哪条请求被成功执行了或执行失败）
        + 服务器端收到消息并处理
        + 服务器端处理完消息后，将生成一条应答消息到replyTo 指定的Queue ，同时带上correlationId 属性
        + 客户端之前已订阅replyTo 指定的Queue ，从中收到服务器的应答消息后，根据其中的correlationId 属性分析哪条请求被执行了，根据执行结果进行后续业务处理

## 产品

- [PhxQueue](https://github.com/Tencent/phxqueue):[介绍](https://mp.weixin.qq.com/s?__biz=MjM5MDE0Mjc4MA==&mid=2650997820&idx=1&sn=c21021580f5474e6f570d1a1eada22bd&chksm=bdbefc6f8ac975791c85d2e9e8cb58a2c384d3daf29c4ac808789aa2281d2dd53c4d2baaf33d&mpshare=1&scene=1&srcid=09141b12nitpm39kMwTLxSIg&pass_ticket=T61h6XjBkARmtNGuhNVdyhTXYAlGFU%2Brx%2FhZrUNp8OOKx9ul0UwejPXkjaJ%2F3yFI#rd)
- [nsqio/nsq](https://github.com/nsqio/nsq) [文档](http://nsq.io/overview/quick_start.html)
- [apache/incubator-rocketmq](https://github.com/apache/incubator-rocketmq) a distributed messaging and streaming platform with low latency, high performance and reliability, trillion-level capacity and flexible scalability.
- [RocketMQ]()
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

## 概念

- Push:生产
- pull：消费
- Hybrid：根据消费者状态

## 使用

- 弹幕
