# [Loki](link)

* 使用了和prometheus一样的标签来作为索引
* 将使用与prometheus相同的服务发现和标签重新标记库,编写了pormtail, 在k8s中promtail以daemonset方式运行在每个节点中，通过kubernetes api等到日志的正确元数据，并将它们发送到Loki
* 日志数据的写主要依托的是Distributor和Ingester两个组件
	- Distributor:第一个接收日志的组件。由于日志的写入量可能很大，所以不能在它们传入时将它们写入数据库,需要批处理和压缩数据
		+ 通过一致性哈希分配　logstream to an ingester
	- ingester接收到日志并开始构建chunk:将日志进行压缩并附加到chunk上面。一旦chunk“填满”（数据达到一定数量或者过了一定期限），ingester将其刷新到数据库。对块和索引使用单独的数据库，因为存储的数据类型不同
		+ 通过构建压缩数据块来实现这一点，方法是在日志进入时对其进行gzip操作，组件ingester是一个有状态的组件，负责构建和刷新chunck，当chunk达到一定的数量或者时间后，刷新到存储中去。每个流的日志对应一个ingester,当日志到达Distributor后，根据元数据和hash算法计算出应该到哪个ingester上面
		+ 为了冗余和弹性，将其复制n（默认情况下为3）次
		+ 刷新一个chunk之后，ingester然后创建一个新的空chunk并将新条目添加到该chunk中
	- Querier:负责给定一个时间范围和标签选择器，Querier查看索引以确定哪些块匹配，并通过greps将结果显示出来。还从Ingester获取尚未刷新的最新数据
		+ 对于每个查询，一个查询器将为您显示所有相关日志。实现了查询并行化，提供分布式grep，使即使是大型查询也是足够的
* 索引存储可以是cassandra/bigtable/dynamodb，而chuncks可以是各种对象存储，Querier和Distributor都是无状态的组件。对于ingester他虽然是有状态的但是，当新的节点加入或者减少，整节点间的chunk会重新分配，已适应新的散列环。而Loki底层存储的实现Cortex已经 在实际的生产中投入使用多年了
