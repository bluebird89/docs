## [etcd](https://github.com/etcd-io/etcd)

Distributed reliable key-value store for the most critical data of a distributed system https://coreos.com/etcd/docs/latest/

* 一个高可用的键值存储系统，分布式一致性k-v存储系统,主要用于共享配置和服务发现
* 由CoreOS开发并维护的，灵感来自于 ZooKeeper 和 Doozer，使用Go语言编写，并通过Raft一致性算法处理日志复制以保证强一致性
* 提供了数据 TTL 失效、数据改变监视、多值、目录监听、分布式锁原子操作等功能，可以方便的跟踪并管理集群节点的状态
* Kubernetes、开源PaaS平台Cloud Foundry和CoreOS的Fleet都广泛使用了etcd
* 基于 raft 共识算法 (The Raft Consensus Algorithm)
    - 在 0.5.0 版本中重新实现了 raft 算法，而非像之前那样依赖于第三方库 go-raft
    - raft 共识算法的优点在于可以在高效的解决分布式系统中各个节点日志内容一致性问题的同时，也使得集群具备一定的容错能力
    - 即使集群中出现部分节点故障、网络故障等问题，仍可保证其余大多数节点正确的步进
    - 甚至当更多的节点（一般来说超过集群节点总数的一半）出现故障而导致集群不可用时，依然可以保证节点中的数据不会出现错误的结果
* 特点
    - 简单：安装配置简单，基于 HTTP+JSON 的 API
    - 安全：可选 SSL 客户认证机制
    - 快速：根据官方提供的benchmark数据，单实例支持每秒2k+读操作
    - 可靠：采用raft算法，实现分布式系统数据的可用性和一致性
* 默认处理的数据都是系统中的控制数据。所以etcd在系统中的角色不是其他NoSQL产品的替代品，更不能作为应用的主要数据存储
* 尽量只存储系统中服务的配置信息，对于应用数据只推荐把数据量很小，但是更新和访问频次都很高的数据存储在etcd中

## Install

```sh
brew install etcd

go get -v go.etcd.io/etcd
# 下载到 $GOPATH/src/github.com/coreos/etcd/clientv3
go get github . com / coreos / etcd / clientv3
go get -v go.etcd.io/etcd/etcdctl

./etcd --version
```

## 概念

* Raft：etcd所采用的保证分布式系统强一致性的算法。
* Node：一个Raft状态机实例。
* Member：一个etcd实例。它管理着一个Node，并且可以为客户端请求提供服务。
* Cluster：由多个Member构成可以协同工作的etcd集群。
* Peer：对同一个etcd集群中另外一个Member的称呼。
* Client：向etcd集群发送HTTP请求的客户端。
* WAL：预写式日志，etcd用于持久化存储的日志格式。
* snapshot：etcd防止WAL文件过多而设置的快照，存储etcd数据状态。
* Proxy：etcd的一种模式，为etcd集群提供反向代理服务。
* Leader：Raft算法中通过竞选而产生的处理所有数据提交的节点。
* Follower：竞选失败的节点作为Raft中的从属节点，为算法提供强一致性保证。
* Candidate：当Follower超过一定时间接收不到Leader的心跳时转变为Candidate开始竞选。
* Term：某个节点成为Leader到下一次竞选时间，称为一个Term。
* Index：数据项编号。Raft中通过Term和Index来定位数据
* Lease提供以下功能：
    - Grant：分配一个租约。
    - Revoke：释放一个租约。
    - TimeToLive：获取剩余TTL时间。
    - Leases：列举所有etcd中的租约。
    - KeepAlive：自动定时的续约某个租约。
    - KeepAliveOnce：为某个租约续约一次。
    - Close：释放当前客户端建立的所有租约。

## 组件

* HTTP Server：用于处理用户发送的 API 请求以及其它 etcd 节点的同步与心跳信息请求
* Store：用于处理 etcd 支持的各类功能的事务，包括数据索引、节点状态变更、监控与反馈、事件处理与执行等等，是 etcd 对用户提供的大多数 API 功能的具体实现
* Raft：Raft 强一致性算法的具体实现，是 etcd 的核心
* WAL：Write Ahead Log（预写式日志），是 etcd 的数据存储方式。除了在内存中存有所有数据的状态以及节点的索引以外，etcd 就通过 WAL 进行持久化存储。WAL 中，所有的数据提交前都会事先记录日志。Snapshot 是为了防止数据过多而进行的状态快照；Entry 表示存储的具体日志内容。

## 原理

* 读写数据
    - 为了保证数据的强一致性，集群中所有的数据流向都是一个方向，从 Leader （主节点）流向 Follower，也就是所有 Follower 的数据必须与 Leader 保持一致，如果不一致会被覆盖
    - 写入来说，etcd集群中的节点会选举出Leader节点，如果写入请求来自Leader节点即可直接写入然后Leader节点会把写入分发给所有Follower，如果写入请求来自其他Follower节点那么写入请求会给转发给Leader节点，由Leader节点写入之后再分发给集群上的所有其他节点
* 选举Leader节点
    - 集群启动之初节点中并没有被选举出的Leader
    - Raft算法使用随机Timer来初始化Leader选举流程。比如说在三个节点上都运行了Timer（每个Timer的持续时间是随机的），第一个节点率先完成了Timer，随后它就会向其他两个节点发送成为Leader的请求，其他节点接收到请求后会以投票回应然后第一个节点被选举为Leader
    - 成为Leader后，该节点会以固定时间间隔向其他节点发送通知，确保自己仍是Leader。有些情况下当Follower们收不到Leader的通知后，比如说Leader节点宕机或者失去了连接，其他节点会重复之前选举过程选举出新的Leader
* 写入是否成功
    - 成功写入：写入请求被Leader节点处理并分发给了多数节点
    - 界定多数节点：假设总结点数是N，那么多数节点公式是 Quorum=N/2+1
* 强烈推荐奇数数量的节点：6个节点的集群它的容错能力并没有比5个节点的好，他们的容错节点数一样

## 应用

* options：
    - -name 节点名称，默认是UUID
    - -data-dir 保存日志和快照的目录，默认为当前工作目录
    - -addr 公布的ip地址和端口。默认为127.0.0.1:2379
    - -bind-addr 用于客户端连接的监听地址，默认为-addr配置
    - -peers 集群成员逗号分隔的列表，例如 127.0.0.1:2380,127.0.0.1:2381
    - -peer-addr 集群服务通讯的公布的IP地址，默认为 127.0.0.1:2380.
    - -peer-bind-addr 集群服务通讯的监听地址，默认为-peer-addr配置
* 配置文件：`/etc/etcd/etcd.conf`
* set
    - -- ttl '0'该键值的超时时间（单位为秒），不配置（默认为 0 ）则永不超时
    - -- swap - with - value value 若该键现在的值是 value ，则进行设置操作
    - -- swap - with - index '0'若该键现在的索引值是指定索引，则进行设置操作
* get
    - --sort 对结果进行排序
    - --consistent 将请求发给主节点，保证获取内容的一致性
* rm
    - -- dir 如果键是个空目录或者键值对则删除
    - -- recursive 删除目录和所有子键
    - -- with - value 检查现有的值是否匹配
    - -- with - index '0'检查现有的 index 是否匹配
* exec-watch 监测一个键值的变化，一旦键值发生更新，就执行给定命令。

```sh
etcd # 启动服务

ETCDCTL_API=3 etcdctl version
./etcdctl ls
./etcdctl put /root/test/keyOne "Hello etcd"
./etcdctl update /root/test/keyOne "Hello etcd"
./etcdctl get /root/test/keyOne --print-value-only
./etcdctl del /root/test/keyOne
./etcdctl watch /root/test/keyOne --forever
./etcdctl backup --data-dir --backup-dir

./etcdctl exec -watch testkey --sh -c 'ls'
./etcdctl member list
```

## 权限

```sh
etcdctl user list
etcdctl user add myusername
etcdctl user passwd myusername
etcdctl user grant-role myusername foo
etcdctl user revoke-role myusername bar
etcdctl user get myusername
etcdctl user delete myusername

etcdctl role list
etcdctl role add myrolename
etcdctl role get myrolename
etcdctl role delete myrolename

etcdctl role grant-permission myrolename read /foo
# Give read access to keys with a prefix /foo/. The prefix is equal to the range [/foo/, /foo0)
etcdctl role grant-permission myrolename --prefix=true read /foo/
# Give write-only access to the key at /foo/bar
etcdctl role grant-permission myrolename write /foo/bar
# Give full access to keys in a range of [key1, key5)
etcdctl role grant-permission myrolename readwrite key1 key5
# Give full access to keys with a prefix /pub/
etcdctl role grant-permission myrolename --prefix=true readwrite /pub/
etcdctl role revoke-permission myrolename /foo/bar

etcdctl auth enable
etcdctl --user root:rootpw auth disable
etcdctl --user user:password get foo
etcdctl --user user get foo
etcdctl --user user --password password get foo
```

## cluster

```
# On each etcd node, specify the cluster members:
TOKEN=token-01
CLUSTER_STATE=new
NAME_1=machine-1
NAME_2=machine-2
NAME_3=machine-3
HOST_1=10.240.0.17
HOST_2=10.240.0.18
HOST_3=10.240.0.19
CLUSTER=${NAME_1}=http://${HOST_1}:2380,${NAME_2}=http://${HOST_2}:2380,${NAME_3}=http://${HOST_3}:2380

# Run this on each machine:

# For machine 1
THIS_NAME=${NAME_1}
THIS_IP=${HOST_1}
etcd --data-dir=data.etcd --name ${THIS_NAME} \
    --initial-advertise-peer-urls http://${THIS_IP}:2380 --listen-peer-urls http://${THIS_IP}:2380 \
    --advertise-client-urls http://${THIS_IP}:2379 --listen-client-urls http://${THIS_IP}:2379 \
    --initial-cluster ${CLUSTER} \
    --initial-cluster-state ${CLUSTER_STATE} --initial-cluster-token ${TOKEN}

# For machine 2
THIS_NAME=${NAME_2}
THIS_IP=${HOST_2}
etcd --data-dir=data.etcd --name ${THIS_NAME} \
    --initial-advertise-peer-urls http://${THIS_IP}:2380 --listen-peer-urls http://${THIS_IP}:2380 \
    --advertise-client-urls http://${THIS_IP}:2379 --listen-client-urls http://${THIS_IP}:2379 \
    --initial-cluster ${CLUSTER} \
    --initial-cluster-state ${CLUSTER_STATE} --initial-cluster-token ${TOKEN}

# For machine 3
THIS_NAME=${NAME_3}
THIS_IP=${HOST_3}
etcd --data-dir=data.etcd --name ${THIS_NAME} \
    --initial-advertise-peer-urls http://${THIS_IP}:2380 --listen-peer-urls http://${THIS_IP}:2380 \
    --advertise-client-urls http://${THIS_IP}:2379 --listen-client-urls http://${THIS_IP}:2379 \
    --initial-cluster ${CLUSTER} \
    --initial-cluster-state ${CLUSTER_STATE} --initial-cluster-token ${TOKEN}

# Or use our public discovery service:
curl https://discovery.etcd.io/new?size=3
https://discovery.etcd.io/a81b5818e67a6ea83e9d4daea5ecbc92

# grab this token
TOKEN=token-01
CLUSTER_STATE=new
NAME_1=machine-1
NAME_2=machine-2
NAME_3=machine-3
HOST_1=10.240.0.17
HOST_2=10.240.0.18
HOST_3=10.240.0.19
DISCOVERY=https://discovery.etcd.io/a81b5818e67a6ea83e9d4daea5ecbc92

THIS_NAME=${NAME_1}
THIS_IP=${HOST_1}
etcd --data-dir=data.etcd --name ${THIS_NAME} \
    --initial-advertise-peer-urls http://${THIS_IP}:2380 --listen-peer-urls http://${THIS_IP}:2380 \
    --advertise-client-urls http://${THIS_IP}:2379 --listen-client-urls http://${THIS_IP}:2379 \
    --discovery ${DISCOVERY} \
    --initial-cluster-state ${CLUSTER_STATE} --initial-cluster-token ${TOKEN}

THIS_NAME=${NAME_2}
THIS_IP=${HOST_2}
etcd --data-dir=data.etcd --name ${THIS_NAME} \
    --initial-advertise-peer-urls http://${THIS_IP}:2380 --listen-peer-urls http://${THIS_IP}:2380 \
    --advertise-client-urls http://${THIS_IP}:2379 --listen-client-urls http://${THIS_IP}:2379 \
    --discovery ${DISCOVERY} \
    --initial-cluster-state ${CLUSTER_STATE} --initial-cluster-token ${TOKEN}

THIS_NAME=${NAME_3}
THIS_IP=${HOST_3}
etcd --data-dir=data.etcd --name ${THIS_NAME} \
    --initial-advertise-peer-urls http://${THIS_IP}:2380 --listen-peer-urls http://${THIS_IP}:2380 \
    --advertise-client-urls http://${THIS_IP}:2379 --listen-client-urls http://${THIS_IP}:2379 \
    --discovery ${DISCOVERY} \
    --initial-cluster-state ${CLUSTER_STATE} --initial-cluster-token ${TOKEN}

## Now etcd is ready! To connect to etcd with etcdctl:
export ETCDCTL_API=3
HOST_1=10.240.0.17
HOST_2=10.240.0.18
HOST_3=10.240.0.19
ENDPOINTS=$HOST_1:2379,$HOST_2:2379,$HOST_3:2379

etcdctl --endpoints=$ENDPOINTS member list
```

## 服务发现（Service Discovery）

* 同一个分布式集群中的进程或服务，要如何才能找到对方并建立连接
    - 一个强一致性、高可用的服务存储目录。基于 Raft 算法的 etcd 就是一个强一致性高可用的服务存储目录。
    - 一种注册服务和监控服务健康状态的机制。用户可以在 etcd 中注册服务，并且对注册的服务设置 key TTL，定时保持服务的心跳以达到监控健康状态的效果。
    - 一种查找和连接服务的机制。通过在 etcd 指定的主题（由服务名称构成的服务目录）下注册的服务也能在对应的主题下查找到
* 基本功能
    - 服务注册：同一service的所有节点注册到相同目录下，节点启动后将自己的信息注册到所属服务的目录中。
    - 健康检查：服务节点定时发送心跳，注册到服务目录中的信息设置一个较短的TTL，运行正常的服务节点每隔一段时间会去更新信息的TTL。
    - 服务发现：通过名称能查询到服务提供外部访问的 IP 和端口号。比如网关代理服务时能够及时的发现服务中新增节点、丢弃不可用的服务节点，同时各个服务间也能感知对方的存在。
* 客户端从 etcd查询服务目录中的节点信息代理服务的请求，并且会在协程中实时监控服务目录中的变化，维护到自己的服务节点信息列表中
* 网关通过 etcd获取到服务目录下的所有节点的信息，将他们初始化到自身维护的可访问服务节点列表中。然后使用Watch机制监听etcd上服务对应的目录的更新，根据通道发送过来的PUT和DELETE事件来增加和删除服务的可用节点列表

## 参考

* [docs](https://etcd.io/docs/v3.4.0)

## 工具

* e3w
