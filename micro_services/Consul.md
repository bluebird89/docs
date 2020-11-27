# [consul](https://github.com/hashicorp/consul)

Consul is a distributed, highly available, and data center aware solution to connect and configure applications across dynamic, distributed infrastructure. <https://www.consul.io>

* 用于实现分布式系统的服务发现与配置
* service discovery：consul通过DNS或者HTTP接口使服务注册和服务发现变的很容易，一些外部服务，例如saas提供的也可以一样注册
* health checking：健康检测使consul可以快速的告警在集群中的操作。和服务发现的集成，可以防止服务转发到故障的服务上面
* key/value storage：一个用来存储动态配置的系统。提供简单的HTTP接口，可以在任何地方操作
* multi-datacenter：无需复杂的配置，即可支持任意数量的区域
* 优势
  - 使用 Raft 算法来保证一致性, 比复杂的 Paxos 算法更直接. 相比较而言, zookeeper 采用的是 Paxos, 而 etcd 使用的则是 Raft
  - 支持多数据中心，内外网的服务采用不同的端口进行监听。 多数据中心集群可以避免单数据中心的单点故障,而其部署则需要考虑网络延迟, 分片等情况等. zookeeper 和 etcd 均不提供多数据中心功能的支持.
  - 支持健康检查. etcd 不提供此功能.
  - 支持 http 和 dns 协议接口. zookeeper 的集成较为复杂, etcd 只支持 http 协议.
  - 官方提供web管理界面, etcd 无此功能.

## 场景

* docker 实例的注册与配置共享
* coreos 实例的注册与配置共享
* vitess 集群
* SaaS 应用的配置共享
* 与 confd 服务集成，动态生成 nginx 和 haproxy 配置文件

## 安装

```sh
wget https://releases.hashicorp.com/consul/1.2.0/consul_1.2.0_linux_amd64.zip
unzip consul_1.2.0_linux_amd64.zip
mv consul /usr/local/bin/

export MICRO_REGISTRY=consul
export PATH="/Users/sunqiang/go/tools:$PATH"
```

## 服务

* 集群是由N个SERVER，加上M个CLIENT组成的。不管是SERVER还是CLIENT，都是consul的一个节点，所有的服务都可以注册到这些节点上，实现服务注册信息的共享
* CLIENT:客户端, 无状态, 将 HTTP 和 DNS 接口请求转发给局域网内的服务端集群
* SERVER:保存配置信息, 高可用集群, 在局域网内与本地客户端通讯, 通过广域网与其他数据中心通讯. 每个数据中心的 server 数量推荐为 3 个或是 5 个.
* 组件
  - Agent: 在consul集群上每个节点运行的后台进程，在服务端模式和客户端模式都需要运行该进程。
  - client: 客户端是无状态的，负责把RPC请求转发给服务端， 占用资源和带宽比较少
  - server: 维持集群状态， 相应rpc请求， 选举算法
  - Datacenter：数据中心，支持多个数据中心
  - Consensus：一致性协议
  - Gossip protocol： consul是基于Serf, Serf为成员规则， 失败检测， 节点通信提供了一套协议，
  - LAN Gossip： 在同一个局域网或者数据中心中所有的节点
  - Refers to the LAN gossip pool which contains nodes that are all located on the same local area network or datacenter.
  - Server和Client。客户端不存储配置数据，官方建议每个Consul Cluster至少有3个或5个运行在Server模式的Agent，Client节点不限
* 一个集群中的所有节点都添加到 gossip protocol（通过这个协议进行成员管理和信息广播）中
  - 客户端不用知道服务地址
  - 节点失败检测是分布式的， 不用只在服务端完成
* 数据中心的所有服务端节点组成一个raft集合
  - 会选举出一个leader，leader服务所有的请求和事务， 如果非leader收到请求， 会转发给leader.
  - leader通过一致性协议（consensus protocol），把所有的改变同步(复制)给非leader
  - 所有数据中心的服务器组成了一个WAN gossip pool，他存在目的就是使数据中心可以相互交流，增加一个数据中心就是加入一个WAN gossip pool
  - 当一个服务端节点收到其他数据中心的请求， 会转发给对应数据中心的服务端
* 参数
  - -server ： 定义agent运行在server模式
  - -bootstrap-expect ：在一个datacenter中期望提供的server节点数目，当该值提供的时候，consul一直 等到达到指定sever数目的时候才会引导整个集群，该标记不能和bootstrap共用
  - -data-dir：提供一个目录用来存放agent的状态，所有的agent允许都需要该目录，该目录必须是稳定的，系统 重启后都继续存在 -node：节点在集群中的名称，在一个集群中必须是唯一的，默认是该节点的主机名 -bind：该地址用来在集群内部的通讯，集群内的所有节点到地址都必须是可达的，默认是0.0.0.0
  - -ui： 启动web界面
  - -config-dir：：配置文件目录，里面所有以.json结尾的文件都会被加载 -rejoin：使consul忽略先前的离开，在再次启动后仍旧尝试加入集群中。 -client：consul服务侦听地址，这个地址提供HTTP、DNS、RPC等服务，默认是127.0.0.1所以不对外提供服 务，如果你要对外提供服务改成0.0.0.0
* SERVER是它们的老大，它和其它SERVER不一样的一点是，它需要负责同步注册的信息给其它的SERVER，同时也要负责各个节点的健康监测
* 节点异常consul的处理
  - leader挂了，consul会重新选取出新的leader，只要超过一半的SERVER还活着，集群是可以正常工作的
* Node Name 是代理的唯一名称，默认情况下是主机名称，可以通过 -node 选项进行指定；
* Datacenter 是代理被配置运行的数据中心，默认值是 dc1，可以通过 -datacenter 选项指定；
* Server 表明代理以 server 还是 client 模式运行，true 表示 server 模式；
* Client Addr 表示提供给客户端接口的代理地址，默认是本地 IP 地址，可以通过 -http-addr 选项进行指定；
* Cluster Addr 用于集群中 Consul 代理间通信的地址和端口集

```sh
consul agent -server -bootstrap-expect 2 -data-dir /tmp/consul -node=S2 - bind=192.168.110.123 -ui -config-dir /etc/consul.d -rejoin -join 192.168.110.123 - client 0.0.0.0
consul agent -server -bootstrap-expect 2 -data-dir /tmp/consul -node=n1 - bind=192.168.110.7 -ui -rejoin -join 192.168.110.123

consul agent -data-dir /tmp/consul -node=n3 -bind=192.168.110.124 -config-dir /etc/consul.d -rejoin -join 192.168.110.123

./consul members

./consul agent -dev # 启动一个Agent的开发模式

curl 'http://localhost:8500/v1/health/service/web?passing'

./consul agent -server -bootstrap-expect=1  \
-data-dir=/tmp/consul \
-node=agent-one -bind=192.168.56.112 \
-enable-script-checks=true -config-dir=/etc/consul.d \
-client 0.0.0.0 -ui

./consul agent -data-dir=/tmp/consul \
-node=agent-two   \
-bind=192.168.56.113 -enable-script-checks=true \
-config-dir=/etc/consul.d \
-ui

./consul join 192.168.56.112

dig @127.0.0.1 -p 8600 agent-two.node.consul # 查询节点

consul kv put redis/config/minconns 1
consul kv put redis/config/minconns 2 # 更新
consul kv get redis/config/minconns
consul kv delete redis/config/minconns
consul kv delete -recurse redis # 批量删除

http://192.168.56.112:8500/ui # Web UI

consul leave
```

## 使用

```go
// 注册
import (
    "fmt"
    "log"

    "net/http"

    consulapi "github.com/hashicorp/consul/api"
)

func consulCheck(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintln(w, "consulCheck")
}

func registerServer() {

    config := consulapi.DefaultConfig()
    client, err := consulapi.NewClient(config)

    if err != nil {
        log.Fatal("consul client error : ", err)
    }

    checkPort := 8080

    registration := new(consulapi.AgentServiceRegistration)
    registration.ID = "serverNode_1"
    registration.Name = "serverNode"
    registration.Port = 9527
    registration.Tags = []string{"serverNode"}
    registration.Address = "127.0.0.1"
    registration.Check = &consulapi.AgentServiceCheck{
        HTTP:                           fmt.Sprintf("http://%s:%d%s", registration.Address, checkPort, "/check"),
        Timeout:                        "3s",
        Interval:                       "5s",
        DeregisterCriticalServiceAfter: "30s", //check失败后30秒删除本服务
    }

    err = client.Agent().ServiceRegister(registration)

    if err != nil {
        log.Fatal("register server error : ", err)
    }

    http.HandleFunc("/check", consulCheck)
    http.ListenAndServe(fmt.Sprintf(":%d", checkPort), nil)

}

// 使用
client, err := consulapi.NewClient(consulapi.DefaultConfig())//非默认情况下需要设置实际的参数
...
services, err = client.Agent().Services()
...
if _, found := services["serverNode_1"]; !found {
            log.Println("serverNode_1 not found")
            continue
}

consul members
```

## docker

```sh
docker pull consul

docker run -d -e 'CONSUL_LOCAL_CONFIG={"skip_leave_on_interrupt": true}' --name=node1 consul agent -server -bind=172.17.0.2  -bootstrap-expect=3 -node=node1
docker run -d -e 'CONSUL_LOCAL_CONFIG={"skip_leave_on_interrupt": true}' --name=node2 consul agent -server -bind=172.17.0.3  -join=172.17.0.2 -node-id=$(uuidgen | awk '{print tolower($0)}')  -node=node2
docker run -d -e 'CONSUL_LOCAL_CONFIG={"skip_leave_on_interrupt": true}' --name=node3 consul agent -server -bind=172.17.0.4  -join=172.17.0.2 -node-id=$(uuidgen | awk '{print tolower($0)}')  -node=node3 -client=172.17.0.4
docker run -d -e 'CONSUL_LOCAL_CONFIG={"leave_on_terminate": true}' --name=node4 consul agent -bind=172.17.0.5 -retry-join=172.17.0.2 -node-id=$(uuidgen | awk '{print tolower($0)}')  -node=node4

docker stop node1 # 停掉leader
curl http://172.17.0.4:8500/v1/status/leader # 查看现在leader

# 注册服务
curl http://172.17.0.4:8500/v1/agent/service/register -X PUT -i -H "Content-Type:application/json" -d '{
  "ID": "userServiceId",
  "Name": "userService",
  "Tags": [
    "primary",
    "v1"
  ],
  "Address": "127.0.0.1",
  "Port": 8000,
  "EnableTagOverride": false,
  "Check": {
    "DeregisterCriticalServiceAfter": "90m",
    "HTTP": "http://www.baidu.com",
    "Interval": "10s"
  }
}'

curl http://172.17.0.4:8500/v1/catalog/service/userService # 发现

docker exec -t node1 consul kv put user/config/connections 5
docker exec -t node1 consul kv get -detailed user/config/connections
```
