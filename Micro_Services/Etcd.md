## [etcd](https://github.com/etcd-io/etcd)

Distributed reliable key-value store for the most critical data of a distributed system https://coreos.com/etcd/docs/latest/

* 一个高可用的键值存储系统，分布式一致性k-v存储系统,主要用于共享配置和服务发现
* 由CoreOS开发并维护的，目标是构建一个高可用的分布式键值(key-value)数据库.灵感来自于 ZooKeeper 和 Doozer，使用Go语言编写，并通过Raft一致性算法处理日志复制以保证强一致性
    - Raft是一个来自Stanford的新的一致性算法，适用于分布式系统的日志复制，Raft通过选举的方式来实现一致性，在Raft中，任何一个节点都可能成为Leader
    - Google的容器集群管理系统Kubernetes、开源PaaS平台Cloud Foundry和CoreOS的Fleet都广泛使用了etcd
    - 工作原理基于 raft 共识算法 (The Raft Consensus Algorithm)
        + 在 0.5.0 版本中重新实现了 raft 算法，而非像之前那样依赖于第三方库 go-raft
        + raft 共识算法的优点在于可以在高效的解决分布式系统中各个节点日志内容一致性问题的同时，也使得集群具备一定的容错能力
        + 即使集群中出现部分节点故障、网络故障等问题，仍可保证其余大多数节点正确的步进
        + 甚至当更多的节点（一般来说超过集群节点总数的一半）出现故障而导致集群不可用时，依然可以保证节点中的数据不会出现错误的结果。
* 特点
    - 简单：安装配置简单，而且提供了HTTP API进行交互，使用也很简单
    - 安全：支持SSL证书验证
    - 快速：根据官方提供的benchmark数据，单实例支持每秒2k+读操作
    - 可靠：采用raft算法，实现分布式系统数据的可用性和一致性

## Install

```sh
brew install etcd

go get -v go.etcd.io/etcd
go get -v go.etcd.io/etcd/etcdctl
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
* Index：数据项编号。Raft中通过Term和Index来定位数据。

```sh
etcd # 启动服务
etcdctl put foo bar
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

## 参考

* [docs](https://etcd.io/docs/v3.4.0)

## 工具

* e3w
