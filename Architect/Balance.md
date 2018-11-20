# balance

将请求/数据均匀分摊到多个操作单元上执行，负载均衡的关键在于均匀

## load balancing

对集群的负载均衡设计是作为高性能系统优化环节中必不可少的方案。负载均衡本质上是用于将用户流量进行均衡减压的.

负载均衡（Load Balancer）是指把用户访问的流量，通过「负载均衡器」，根据某种转发的策略，均匀的分发到后端多台服务器上，后端的服务器可以独立的响应和处理请求，从而实现分散负载的效果。负载均衡技术提高了系统的服务能力，增强了应用的可用性。

一组计算机节点（或者一组进程）提供相同的（同质的）服务，那么对服务的请求就应该均匀的分摊到这些节点上。
负载均衡的前提一定是“provide a single Internet service from multiple servers”， 这些提供服务的节点被称之为server farm、server pool或者backend servers。在分布式系统中，负载均衡更是无处不在

### 意义

* 让所有节点以最小的代价、最好的状态对外提供服务，这样系统吞吐量最大，性能更高，对于用户而言请求的时间也更小。
* 增强了系统的可靠性，最大化降低了单个节点过载、甚至crash的概率。

### 结构

每一个上游都均匀访问每一个下游，就能实现“将请求/数据【均匀】分摊到多个操作单元上执行”。

*【客户端层】到【反向代理层】的负载均衡，是通过“DNS轮询”实现的
*【反向代理层】到【站点层】的负载均衡，是通过“nginx”实现的
    - 请求轮询：和DNS轮询类似，请求依次路由到各个web-server；
    - 最少连接路由：哪个web-server的连接少，路由到哪个web-server；
    - ip哈希：按照访问用户的ip哈希值来路由web-server，只要用户的ip分布是均匀的，请求理论上也是均匀的，ip哈希均衡方法可以做到，同一个用户的请求固定落到同一台web-server上，此策略适合有状态服务，例如session；
*【站点层】到【服务层】的负载均衡，是通过“服务连接池”实现的
*【数据层】的负载均衡，要考虑“数据的均衡”与“请求的均衡”两个点
    - 按照范围水平切分:每一个数据服务，存储一定范围的数据： user0服务：存储uid范围1-1kw ser1服务：存储uid范围1kw-2kw
        - 这个方案的好处是：
            + 规则简单，service只需判断一下uid范围就能路由到对应的存储服务
            + 数据均衡性较好
            + 比较容易扩展，可以随时加一个uid[2kw,3kw]的数据服务
        + 不足：请求的负载不一定均衡，一般来说，新注册的用户会比老用户更活跃，大range的服务请求压力会更大
    - hash水平切分每一个数据服务，存储某个key值hash后的部分数据： user0服务：存储偶数uid数据 user1服务：存储奇数uid数据
        - 这个方案的好处是：
            + 规则简单，service只需对uid进行hash能路由到对应的存储服务
            + 数据均衡性较好
            + 请求均匀性较好
        - 不足是：不容易扩展，扩展一个数据服务，hash方法改变时候，可能需要进行数据迁移

### 方案

* 基于DNS负载均衡：可以实现在地域上的流量均衡
    - 让DNS服务器根据不同地理位置的用户返回不同的IP
    - 相当于实现了按照「就近原则」将请求分流了，既减轻了单个集群的负载压力，也提升了用户的访问速度。
    - 配置简单，实现成本非常低，无需额外的开发和维护工作。
    - 当配置修改后，生效不及时。这个是由于DNS的特性导致的，DNS一般会有多级缓存，所以当我们修改了DNS配置之后，由于缓存的原因，会导致IP变更不及时，从而影响负载均衡的效果。
    - 大多是基于地域或者干脆直接做IP轮询，没有更高级的路由策略，所以这也是DNS方案的局限所在。
* 基于硬件负载均衡：用于大型服务器集群中的负载需求，F5 Network Big-IP。完全通过硬件来抗压力，性能是非常的好。用在大型互联网公司的流量入口最前端
* 基于软件负载均衡：基于机器层面的流量均衡
    - 基于第四层传输层来做流量分发的方案称为4层负载均衡，例如 LVS。性能要高一些
    - 基于第七层应用层来做流量分发的称为7层负载均衡

### 算法

衡量标准

* 是否意识到不同节点的服务能力是不一样的，比如CPU、内存、网络、地理位置
* 是否意识到节点的服务能力是动态变化的，高配的机器也有可能由于一些突发原因导致处理速度变得很慢
* 是否考虑将同一个客户端，或者说同样的请求分发到同一个处理节点，这对于“有状态”的服务非常重要，比如session，比如分布式存储
* 谁来负责负载均衡，即谁充当负载均衡器（load balancer），balancer本身是否会成为瓶颈

算法

* 轮询算法（round-robin）：提供同质服务的节点逐个对外提供服务，这样能做到绝对的均衡.
    * 没有考虑到节点的差异
* 加权轮询算法（weight round-robin）:在轮训算法的基础上，考虑到机器的差异性，分配给机器不同的权重.依赖于请求的类型，比如计算密集型，那就考虑CPU、内存；如果是IO密集型，那就考虑磁盘性能
* 随机算法（random）:随机选择一个节点服务，按照概率，只要请求数量足够多，那么也能达到绝对均衡的效果
* 加权随机算法（random）:在随机的时候引入不同节点的权重
* 哈希法（hash）：根据客户端的IP，或者请求的“Key”，计算出一个hash值，然后对节点数目取模。好处就是，同一个请求能够分配到同样的服务节点，这对于“有状态”的服务很有必要
    - 当节点的数目发生变化的时候，请求会大概率分配到其他的节点，引发到一系列问题
* 一致性哈希算法：一个物理节点与多个虚拟节点映射，在hash的时候，使用虚拟节点数目而不是物理节点数目。当物理节点变化的时候，虚拟节点的数目无需变化，只涉及到虚拟节点的重新分配。而且，调整每个物理节点对应的虚拟节点数目，也就相当于每个物理节点有不同的权重
* 最少连接算法（least connection）：根据节点的真实负载，动态地调整节点的权重就非常重要。当然，要获得接节点的真实负载也不是一概而论的事情，如何定义负载，负载的收集是否及时，
    - 每个节点当前的连接数目是一个非常容易收集的指标，因此lease connection是最常被人提到的算法
* 响应策略：将请求转发给当前时刻响应最快的后端服务器。
    - 不停的去统计每一台后端服务器对请求的处理速度了

```python
SERVER_LIST = [
      '10.246.10.1',
     '10.246.10.2',
     '10.246.10.3',
 ]
 def round_robin(server_lst, cur = [0]):
     length = len(server_lst)
     ret = server_lst[cur[0] % length]
     cur[0] = (cur[0] + 1) % length
     return ret

 WEIGHT_SERVER_LIST = {
     '10.246.10.1': 1,
     '10.246.10.2': 3,
     '10.246.10.3': 2,
 }
 def weight_round_robin(servers, cur = [0]):
     weighted_list = []
     for k, v in servers.iteritems():
         weighted_list.extend([k] * v)

     length = len(weighted_list)
     ret = weighted_list[cur[0] % length]
     cur[0] = (cur[0] + 1) % length
     return ret

def random_choose(server_lst):
    import random
    random.seed()
    return random.choice(server_lst)

def weight_random_choose(servers):
    import random
    random.seed()
    weighted_list = []
    for k, v in servers.iteritems():
        weighted_list.extend([k] * v)
    return random.choice(weighted_list)

# 如果节点列表以及权重变化不大，那么也可以对所有节点归一化，然后按概率区间选择
def normalize_servers(servers):
    normalized_servers = {}
    total = sum(servers.values())
    cur_sum = 0
    for k, v in servers.iteritems():
        normalized_servers[k] = 1.0 * (cur_sum + v) / total
        cur_sum += v
    return normalized_servers

def weight_random_choose_ex(normalized_servers):
    import random, operator
    random.seed()
    rand = random.random()
    for k, v in sorted(normalized_servers.iteritems(), key = operator.itemgetter(1)):
        if v >= rand:
            return k
    else:
        assert False, 'Error normalized_servers with rand %s ' % rand

def hash_choose(request_info, server_lst):
     hashed_request_info = hash(request_info)
     return server_lst[hashed_request_info % len(server_lst)]
```

### 有状态请求

有状态 — 请求依赖某些存在于内存或者磁盘的数据，比如web请求的session，比如分布式存储

请求分发的时候，保证同一个请求分发到同样的服务节点。一致性hash，以及分布式存储中的按范围分段（即记录哪些请求由哪个服务节点提供服务），代价是需要在load balancer中维护额外的数据。
状态数据在backend servers之间共享
状态数据维护在客户端：即cookie，不过要考虑安全性，需要加密

### 负载均衡位置

* 客户端，根据服务节点的信息自行选择，然后将请求直接发送到选中的服务节点；
    - 知道服务器列表，要么是静态配置，要么有简单接口查询，
    - 但backend server的详细负载信息，就不适用通过客户端来查询。
    - 算法要么是比较简单的，比如轮训（加权轮训）、随机（加权随机）、哈希这几种算法，只要每个客户端足够随机，按照大数定理，服务节点的负载也是均衡的
    - 使用较为复杂的算法，比如根据backend的实际负载，那么就需要去额外的负载均衡服务（external load balancing service）查询到这些信息，在grpc中，就是使用的这种办法
        + load balancer与grpc server通信，获得grpc server的负载等具体详细
        + grpc client从load balancer获取这些信息，最终grpc client直连到被选择的grpc server。
* 服务节点集群之前放一个集中式代理（proxy），由代理负责请求求分发。
    - 7层的Nginx:response经过Proxy
    - 四层的F5、LVS:response不经过proxy，如LVS
    - 在于方便控制，而且能容易实现一些更精密，更复杂的算法。
    - 但缺点也很明显，
        - 负载均衡器本身可能成为性能瓶颈
        - 可能引入额外的延迟，请求一定先发到达负载均衡器，然后到达真正的服务节点。
    * load balancer proxy不能成为单点故障（single point of failure），因此一般会设计为高可用的主从结构
    * response也是走load balancer proxy的话，那么整个服务过程对客户端而言就是完全透明的，也防止了客户端去尝试连接后台服务器，提供了一层安全保障！
* 哪一种，至少都需要知道当前的服务节点列表这一基础信息。

![grpc原理图](../_static/grpc.png "grpc原理图")
![proxy原理图](../_static/proxy.png "proxy原理图")

## 模型

* 负载均衡是一种推模型，一定会选出一个服务节点，然后把请求推送过来
* 消息队列，就变成了拉模型：空闲的服务节点主动去拉取请求进行处理，各个节点的负载自然也是均衡的。
    - 务节点不会被大量请求冲垮，同时增加服务节点更加容易
    - 缺点也很明显，请求不是事实处理的。

## 参考

- [dianping/camel](https://github.com/dianping/camel)软负载一体解决方案，承担了F5硬负载层后的软负载工作


负载均衡、分布式、集群：<https://www.zhihu.com/question/34184276>
<https://www.zhihu.com/question/22610352>
