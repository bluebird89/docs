## etcd

etcd是一个高可用的键值存储系统，分布式一致性k-v存储系统,主要用于共享配置和服务发现。etcd是由CoreOS开发并维护的，灵感来自于 ZooKeeper 和 Doozer，它使用Go语言编写，并通过Raft一致性算法处理日志复制以保证强一致性。Raft是一个来自Stanford的新的一致性算法，适用于分布式系统的日志复制，Raft通过选举的方式来实现一致性，在Raft中，任何一个节点都可能成为Leader。Google的容器集群管理系统Kubernetes、开源PaaS平台Cloud Foundry和CoreOS的Fleet都广泛使用了etcd。 etcd 集群的工作原理基于 raft 共识算法 (The Raft Consensus Algorithm)。etcd 在 0.5.0 版本中重新实现了 raft 算法，而非像之前那样依赖于第三方库 go-raft 。raft 共识算法的优点在于可以在高效的解决分布式系统中各个节点日志内容一致性问题的同时，也使得集群具备一定的容错能力。即使集群中出现部分节点故障、网络故障等问题，仍可保证其余大多数节点正确的步进。甚至当更多的节点（一般来说超过集群节点总数的一半）出现故障而导致集群不可用时，依然可以保证节点中的数据不会出现错误的结果。


## 参考

- [coreos/etcd](https://github.com/coreos/etcd)Distributed reliable key-value store for the most critical data of a distributed system https://coreos.com/etcd/docs/latest/