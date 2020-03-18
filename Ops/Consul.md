# [hashicorp / consul](https://github.com/hashicorp/consul)

Consul is a distributed, highly available, and data center aware solution to connect and configure applications across dynamic, distributed infrastructure. https://www.consul.io

* service discovery：consul通过DNS或者HTTP接口使服务注册和服务发现变的很容易，一些外部服务，例如saas提供的也可以一样注册。
* health checking：健康检测使consul可以快速的告警在集群中的操作。和服务发现的集成，可以防止服务转发到故障的服务上面。
* key/value storage：一个用来存储动态配置的系统。提供简单的HTTP接口，可以在任何地方操作。
* multi-datacenter：无需复杂的配置，即可支持任意数量的区域。

## 概念

* 集群是由N个SERVER，加上M个CLIENT组成的。而不管是SERVER还是CLIENT，都是consul的一个节点，所有的服务都可以注册到这些节点上，正是通过这些节点实现服务注册信息的共享
* CLIENT表示consul的client模式，就是客户端模式。是consul节点的一种模式，这种模式下，所有注册到当前节点的服务会被转发到SERVER，本身是不持久化这些信息。
* SERVER表示consul的server模式，表明这个consul是个server，这种模式下，功能和CLIENT都一样，唯一不同的是，它会把所有的信息持久化的本地，这样遇到故障，信息是可以被保留的。
* SERVER是它们的老大，它和其它SERVER不一样的一点是，它需要负责同步注册的信息给其它的SERVER，同时也要负责各个节点的健康监测。
* 节点异常consul的处理
    - leader挂了，consul会重新选取出新的leader，只要超过一半的SERVER还活着，集群是可以正常工作的

```
./consul agent -dev # 启动一个Agent的开发模式
./consul members

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
```

## docker

* 

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
