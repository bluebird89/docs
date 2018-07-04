# [apache/kafka](https://github.com/apache/kafka)

大数据领域常用的消息队列，最初由 LinkedIn 采用 Scala 语言开发，用作 LinkedIn 的活动流追踪和运营系统数据处理管道的基础。 其高吞吐、自动容灾、出入队有序等特性.分布式流式处理平台，用于发布和订阅、存储及实时地处理大规模流数据

## 安装

```sh
# Mac 会自动安装依赖zookeeper
brew install kafka
brew services start kafka

# 启动 zookeeper
zookeeper-server-start /usr/local/etc/kafka/zookeeper.properties
# 启动kafka服务
kafka-server-start /usr/local/etc/kafka/server.properties

# 创建topic
kafka-topics --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic test
# 查看创建的topic
kafka-topics --list --zookeeper localhost:2181
# 生产者生产数据
kafka-console-producer --broker-list localhost:9092 --topic test
# 消费者
kafka-console-consumer --bootstrap-server localhost:9092 --topic test --from-beginning
```

## 项目

* [weiboad/kafka-php](https://github.com/weiboad/kafka-php):kafka php client
* [dpkp/kafka-python](https://github.com/dpkp/kafka-python):Python client for Apache Kafka http://kafka-python.readthedocs.io/
* [Shopify/sarama](https://github.com/Shopify/sarama):Sarama is a Go library for Apache Kafka 0.8, and up. https://shopify.github.io/sarama

## 参考

* [Documentation](http://kafka.apache.org/documentation.html)
- [重磅开源KSQL：用于Apache Kafka的流数据SQL引擎](http://www.infoq.com/cn/news/2017/08/KSQL-open-source-apache-kafka):一个基于流的SQL。推出KSQL是为了降低流式处理的门槛，为处理Kafka数据提供简单而完整的可交互式SQL接口。
- [Cruise Control](http://www.infoq.com/cn/news/2017/09/LinkedIn-open-Cruise-Control-Kaf):一个Kafka集群自动化运维新利器
* <https://www.confluent.io/blog/publishing-apache-kafka-new-york-times/>
* [在生产环境使用Kafka构建和部署大规模机器学习](https://juejin.im/entry/5a02660b6fb9a0452a3bbe53)
