# [apache/rocketmq](https://github.com/apache/rocketmq)

 a unified messaging engine, lightweight data processing platform. https://rocketmq.apache.org/

* 用了顺序写盘、mmap。并没有用到 sendfile ，还有一步页缓存到 SocketBuffer 的拷贝
* 顺序写盘，整体来看是顺序读盘，并且使用了 mmap，不是真正的零拷贝。又因为页缓存的不确定性和 mmap 惰性加载(访问时缺页中断才会真正加载数据)，用了文件预先分配和文件预热即每页写入一个0字节，然后再调用mlock 和 madvise(MADV_WILLNEED)

## CommitLog

* Topic混合追加方式:一个 CommitLog 文件中会包含分给此 Broker 的所有消息，不论消息属于哪个 Topic 的哪个 Queue
* 所有的消息过来都是顺序追加写入到 CommitLog 中，并且建立消息对应的 CosumerQueue ，然后消费者是通过 CosumerQueue 得到消息的真实物理地址再去 CommitLog 获取消息的
* 可以将 CosumerQueue 理解为消息的索引
* 不论是 CommitLog 还是 CosumerQueue 都采用了 mmap
* 发消息的时候默认用的是将数据拷贝到堆内存中，然后再发送
* RocketMQ 默认把消息拷贝到堆内 Buffer 中，再塞到响应体里面发送。但是可以通过参数配置不经过堆，不过也并没有用到真正的零拷贝，而是通过mapedBuffer 发送到 SocketBuffer
* 拉消息的时候严格的说对于 CommitLog 来说读取是随机的，因为 CommitLog 的消息是混合的存储的，但是从整体上看，消息还是从 CommitLog 顺序读的，都是从旧数据到新数据有序的读取。并且一般而言消息存进去马上就会被消费，因此消息这时候应该还在页缓存中，所以不需要读盘
* 页缓存会定时刷盘，这刷盘不可控，并且内存是有限的，会有swap等情况.mmap其实只是做了映射，当真正读取页面的时候产生缺页中断，才会将数据真正加载到内存中，这对于消息队列来说可能会产生监控上的毛刺
* 文件预分配
	- CommitLog 的大小默认是1G，当超过大小限制的时候需要准备新的文件，而 RocketMQ 就起了一个后台线程 AllocateMappedFileService，不断的处理 AllocateRequest，AllocateRequest其实就是预分配的请求，会提前准备好下一个文件的分配，防止在消息写入的过程中分配文件，产生抖动
* 文件预热
	- 有一个warmMappedFile方法，它会把当前映射的文件，每一页遍历多去，写入一个0字节，然后再调用mlock 和 madvise(MADV_WILLNEED)
