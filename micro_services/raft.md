## [Raft](https://raft.github.io/raft.pdf)

* 一个来自Stanford的新的一致性算法，适用于分布式系统的日志复制，Raft通过选举的方式来实现一致性，在Raft中，任何一个节点都可能成为Leader
* a protocol for implementing distributed consensus
* 分布式一致性算法的主流，业界的 TiDB、CockroachDB、etcd、consul 等一系列流行的组件和服务都在使用它
* 基于日志的连续提交的设定，和 multi-paxos 的乱序提交相比，在写入性能上相比会有些差距。这对于 Raft 协议来讲没有太多的改进空间，但是如果 braft 要做一个理想的 Raft 库实现的话，依然需要不断的改进和优化。
* Consensus一致性:指多个服务器在状态达成一致，但是在一个分布式系统中，因为各种意外可能，有的服务器可能会崩溃或变得不可靠，它就不能和其他服务器达成一致状态。这样就需要一种Consensus协议，一致性协议是为了确保容错性，也就是即使系统中有一两个服务器当机，也不会影响其处理过程。
* foller 有自计时机制,收取 leader 心跳.心跳信号会重置计时
* 强依赖 Leader 节点的可用性来确保集群数据的一致性。
* 数据的流向只能从 Leader 节点向 Follower 节点转移
  - Client 向集群 Leader 节点提交数据后，Leader 节点接收到的数据处于未提交状态（Uncommitted）
  - Leader 节点会并发向所有 Follower 节点复制数据并等待接收响应，确保至少集群中超过半数节点已接收到数据后再向 Client 确认数据已接收
  - 一旦向 Client 发出数据接收 Ack 响应后，表明此时数据状态进入已提交（Committed）
  - Leader 节点再向 Follower 节点发通知告知该数据状态已提交
* 不同阶段Leader 挂掉的影响
  - 数据到达 Leader 节点前：不影响一致性
  - 数据到达 Leader 节点，但未复制到 Follower 节点：Follower 节点上没有该数据，重新选主后 Client 重试重新提交可成功。原来的 Leader 节点恢复后作为 Follower 加入集群重新从当前任期的新 Leader 处同步数据，强制保持和 Leader 数据一致
  - 到达 Leader 节点，成功复制到 Follower 所有节点，但还未向 Leader 响应接收
    + Follower 节点一致：Raft 要求 RPC 请求实现幂等性，也就是要实现内部去重机制
    + Follower 节点不一致：Raft 协议要求投票只能投给拥有最新数据的节点。所以拥有最新数据的节点会被选为 Leader 再强制同步数据到 Follower，数据不会丢失并最终一致
  - 数据到达 Leader 节点，成功复制到 Follower 所有或多数节点，数据在 Leader 处于已提交状态，但在 Follower 处于未提交状态
  - 数据到达 Leader 节点，成功复制到 Follower 所有或多数节点，数据在所有节点都处于已提交状态，但还未响应 Client
  - 网络分区导致的脑裂情况，出现双 Leader
    + 原先的 Leader 独自在一个区，向它提交数据不可能复制到多数节点所以永远提交不成功
    + 向新的 Leader 提交数据可以提交成功
    + 网络恢复后旧的 Leader 发现集群中有更新任期（Term）的新 Leader 则自动降级为 Follower 并从新 Leader 处同步数据达成集群数据一致。

## paxos vs raft

* paxos 和 raft 的区别
* paxos/raft 属于什么协议，分布式共识协议和分布式一致性协议有什么区别？
* paxos/raft 有哪些表示时间的方式，分别是什么？
* raft 为什么需要 preVote，没有 preVote 会怎么样？
* 一致性有哪些级别，分别是什么，有什么区别？追问：如何验证这些一致性？
* TLA+ 是什么？会使用 TLA+ 验证分布式协议的正确性吗？为什么用 TLA+ 可以验证分布式问题，如果不使用 TLA+还有别的方法验证吗？
* paxos 和 raft 是 write wait(写等待) 协议，那么有没有 read wait(读等待) 协议，写等待和读等待分别适合什么场景？
* 什么场景不适合用 raft 而只适合用 paxos？
* paxos 的常见优化有哪些？为什么优化后的 paxos 依然可以保证正确性，优化牺牲了什么？

## Leader Election

* In Raft there are two timeout settings which control elections
* First is the election timeout:The election timeout is the amount of time a follower waits until becoming a candidate
  - The election timeout is randomized to be between 150ms and 300ms
* After the election timeout the follower becomes a candidate and starts a new election terminate
* sends out Request Vote messages to other nodes
  - and the node resets its election timeout.
  - Once a candidate has a majority of votes it becomes leader.
* The leader begins sending out Append Entries messages to its followers
  - These messages are sent in intervals specified by the heartbeat timeout
  - Followers then respond to each Append Entries message.
* This election term will continue until a follower stops receiving heartbeats and becomes a candidate.
* Requiring a majority of votes guarantees that only one leader can be elected per term.
* If two nodes become candidates at the same time then a split vote can occur.
  - Two nodes both start an election for the same term and each reaches a single follower node before the other
  - Now each candidate has 2 votes and can receive no more for this term
  - The nodes will wait for a new election and try again.

## Log Replication

* Once we have a leader elected we need to replicate all changes to our system to all nodes.
* All changes to the system now go through the leader.
* Each change is added as an entry in the node's log.  the change is sent to the followers on the next heartbeat.
* To commit the entry the node first replicates it to the follower nodes,the leader waits until a majority of nodes have written the entry,An entry is committed once a majority of followers acknowledge it.and a response is sent to the client.
* The entry is now committed on the leader node and the node state is "5".
* The leader then notifies the followers that the entry is committed

## partition

* have two leaders in different terms: 3->2
* another client and try to update both leaders
  - 2 Node:a client senf a messages,but cannot replicate to a majority so its log entry stays uncommitted
  - 3 node:because it can replicate to a majority
* heal
  - 2 Node nodes A & B will roll back their uncommitted entries and match the new leader's log.

## 参考

* [Understandable Distributed Consensus](http://thesecretlivesofdata.com/raft/)
* [maemual / raft-zh_cn](https://github.com/maemual/raft-zh_cn):Raft一致性算法论文的中文翻译
