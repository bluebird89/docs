# 消息队列

消息队列作为成熟的异步通信模式，对比常用的同步通信模式，有如下优势：

- 解耦：防止引入过多的 API 给系统的稳定性带来风险；调用方使用不当会给被调用方系统造成压力，被调用方处理不当会降低调用方系统的响应能力。
- 削峰和流控：消息生产者不会堵塞，突发消息缓存在队列中，消费者按照实际能力读取消息。
- 复用：一次发布多方订阅。

## 产品

- [PhxQueue](https://github.com/Tencent/phxqueue):[介绍](https://mp.weixin.qq.com/s?__biz=MjM5MDE0Mjc4MA==&mid=2650997820&idx=1&sn=c21021580f5474e6f570d1a1eada22bd&chksm=bdbefc6f8ac975791c85d2e9e8cb58a2c384d3daf29c4ac808789aa2281d2dd53c4d2baaf33d&mpshare=1&scene=1&srcid=09141b12nitpm39kMwTLxSIg&pass_ticket=T61h6XjBkARmtNGuhNVdyhTXYAlGFU%2Brx%2FhZrUNp8OOKx9ul0UwejPXkjaJ%2F3yFI#rd)
- [nsqio/nsq](https://github.com/nsqio/nsq) [文档](http://nsq.io/overview/quick_start.html)
- [apache/incubator-rocketmq](https://github.com/apache/incubator-rocketmq) a distributed messaging and streaming platform with low latency, high performance and reliability, trillion-level capacity and flexible scalability.

## 概念

- Push:生产
- pull：消费
- Hybrid：根据消费者状态


## 使用

- 弹幕
