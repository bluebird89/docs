## [Enovy](https://www.envoyproxy.io/)

ENVOY IS AN OPEN SOURCE EDGE AND SERVICE PROXY, DESIGNED FOR CLOUD-NATIVE APPLICATIONS

* 任务：
  - 服务发现：探测所有可用的上游或后端服务实例
  - 健康检测：探测上游或后端服务实例是否健康，是否准备好接收网络流量
  - 流量路由：将网络请求路由到正确的上游或后端服务
  - 负载均衡：在对上游或后端服务进行请求时，选择合适的服务实例接收请求，同时负责处理超时、断路、重试等情况
  - 身份验证和授权：对网络请求进行身份验证、权限验证，以决定是否响应以及如何响应，使用 mTLS 或其他机制对链路进行加密等
  - 链路追踪：对于每个请求，生成详细的统计信息、日志记录和分布式追踪数据，以便操作人员能够理解调用路径并在出现问题时进行调试
  - 典型的数据平面实现有：Linkerd、NGINX、HAProxy、Envoy、TraefikEnvoy
* Enovy 术语
  - Host：能够进行网络通信的实体（在手机或服务器等上的应用程序）。在 Envoy 中主机是指逻辑网络应用程序。只要每台主机都可以独立寻址，一块物理硬件上就运行多个主机
  - Downstream：下游（downstream）主机连接到 Envoy，发送请求并获得响应
  - Upstream：上游（upstream）主机获取来自 Envoy 的连接接请求和响应
  - Cluster: 集群（cluster）是 Envoy 连接到的一组逻辑上相似的上游主机。Envoy 通过服务发现发现集群中的成员。Envoy 可以通过主动运行状况检查来确定集群成员的健康状况。Envoy 如何将请求路由到集群成员由负载均衡策略确定
  - Mesh：一组互相协调以提供一致网络拓扑的主机。Envoy mesh 是指一组 Envoy 代理，它们构成了由多种不同服务和应用程序平台组成的分布式系统的消息传递基础
  - 运行时配置：与 Envoy 一起部署的带外实时配置系统。可以在无需重启 Envoy 或更改 Envoy 主配置的情况下，通过更改设置来影响操作
  - Listener: 监听器（listener）是可以由下游客户端连接的命名网络位置（例如，端口、unix域套接字等）。Envoy 公开一个或多个下游主机连接的监听器。一般是每台主机运行一个 Envoy，使用单进程运行，但是每个进程中可以启动任意数量的 Listener（监听器），目前只监听 TCP，每个监听器都独立配置一定数量的（L3/L4）网络过滤器。Listenter 也可以通过 Listener Discovery Service（LDS）动态获取
  - Listener filter：Listener 使用 listener filter（监听器过滤器）来操作连接的元数据。它的作用是在不更改 Envoy 的核心功能的情况下添加更多的集成功能。Listener filter 的 API 相对简单，因为这些过滤器最终是在新接受的套接字上运行。在链中可以互相衔接以支持更复杂的场景，例如调用速率限制。Envoy 已经包含了多个监听器过滤器
  - Http Route Table：HTTP 的路由规则，例如请求的域名，Path 符合什么规则，转发给哪个 Cluster
  - Health checking：健康检查会与SDS服务发现配合使用。但是，即使使用其他服务发现方式，也有相应需要进行主动健康检查的情况

## 配置

* 为 Service Mesh 中的每个 Pod 注入 Sidecar 的时候同时为 Envoy 注入 Bootstrap 配置，其余的配置是通过 Pilot 下发的，注意整个数据平面即 Service Mesh 中的 Envoy 的动态配置应该是相同的
* Envoy proxy 配置
  - bootstrap：Envoy proxy 启动时候加载的静态配置
  - listeners：监听器配置，使用 LDS 下发
    + 每个 Envoy 进程中可以有多个 Listener，Envoy 与 Listener 之间是一对多的关系
    + 每个 Listener 中可以配置一条 filter 链表（filter_chains），Envoy 会根据 filter 顺序执行过滤
    + Listener 可以监听下游的端口，也可以接收来自其他 listener 的数据，形成链式处理
    + filter 是可扩展的
    + 可以静态配置，也可以使用 LDS 动态配置
    + 目前只能监听 TCP，UDP 还未支持
  - clusters：集群配置，静态配置中包括 xds-grpc 和 zipkin 地址，动态配置使用 CDS 下发
    + Cluster 是指 Envoy 连接的一组逻辑相同的上游主机
      * 一组逻辑上相同的主机构成一个 cluster。
      * 可以在 cluster 中定义各种负载均衡策略。
      * 新加入的 cluster 需要一个热身的过程才可以给路由引用，该过程是原子的，即在 cluster 热身之前对于 Envoy 及 Service Mesh 的其余部分来说是不可见的。
      * 可以通过多种方式来配置 cluster，例如静态类型、严格限定 DNS、逻辑 DNS、EDS 等。
    + Envoy 通过服务发现来发现 cluster 的成员。可以选择通过主动健康检查来确定集群成员的健康状态
    + Envoy 通过负载均衡策略决定将请求路由到 cluster 的哪个成员
  - routes：路由配置，静态配置中包括了本地监听的服务的集群信息，其中引用了 cluster，动态配置使用 RDS 下发
    + HTTP 路由转发是通过路由过滤器实现的。该过滤器的主要职能就是执行路由表中的指令。除了可以做重定向和转发，路由过滤器还需要处理重试、统计之类的任务
    + 特点
      * 前缀和精确路径匹配规则
      * 可跨越多个上游集群进行基于权重/百分比的路由
      * 基于优先级的路由
      * 基于哈希策略的路由
* API：
  - CDS（Cluster Discovery Service）：集群发现服务
  - EDS（Endpoint Discovery Service）：端点发现服务
  - HDS（Health Discovery Service）：健康发现服务
  - LDS（Listener Discovery Service）：监听器发现服务
  - MS（Metric Service）：将 metric 推送到远端服务器
  - RLS（Rate Limit Service）：速率限制服务
  - RDS（Route Discovery Service）：路由发现服务
  - SDS（Secret Discovery Service）：秘钥发现服务
  - 有 v1 和 v2 两个版本，从 Envoy 1.5.0 起 v2 API 就已经生产就绪了，为了能够让用户顺利的向 v2 版本的 API 过度，Envoy 启动的时候设置了一个 --v2-config-only 的标志
* Envoy xDS
  - 所有名称以 DS 结尾的服务统称为 xDS:Envoy 通过查询文件或管理服务器来动态发现资源。概括地讲，对应的发现服务及其相应的 API 被称作 xDS
  - Envoy 通过订阅（subscription）方式来获取资源
    + 文件订阅:监控指定路径下的文件,使用 inotify（Mac OS X 上为 kqueue）来监控文件的变化，在文件被更新时，Envoy 读取保存的 DiscoveryResponse 数据进行解析，数据格式可以为二进制 protobuf、JSON、YAML 和协议文本等
      * 可提供统计数据和日志信息，但是缺少 ACK/NACK 更新的机制。如果更新的配置被拒绝，xDS API 则继续使用最后一个的有效配置
    + gRPC 流式订阅
      * 单资源类型发现: 每个 xDS API 可以单独配置 ApiConfigSource，指向对应的上游管理服务器的集群地址。每个 xDS 资源类型会启动一个独立的双向 gRPC 流，可能对应不同的管理服务器。API 交付方式采用最终一致性
        - 每个 xDS API 都与给定的资源的类型存在 1:1 对应,采用 type.googleapis.com/<resource type> 的形式，例如 CDS 对应于 type.googleapis.com/envoy.api.v2.Cluster。在 Envoy 的请求和管理服务器的响应中，都包括了资源类型 URL
          + LDS： envoy.api.v2.Listener
          + RDS： envoy.api.v2.RouteConfiguration
          + CDS： envoy.api.v2.Cluster
          + EDS： envoy.api.v2.ClusterLoadAssignment
          + SDS：envoy.api.v2.Auth.Secret
        - ACK/NACK 和版本
          + 每个 Envoy 流以 DiscoveryRequest 开始，包括了列表订阅的资源、订阅资源对应的类型 URL、节点标识符和空的 version_info
          + 管理服务器可立刻或等待资源就绪时发送 DiscoveryResponse作为响应
          + Envoy 在处理 DiscoveryResponse 响应后，将通过流发送一个新的请求，请求包含应用成功的最后一个版本号和管理服务器提供的 nonce。如果本次更新已成功应用，则 version_info 的值设置为 X
        - 何时发送更新: 管理服务器应该只向 Envoy 客户端发送上次 DiscoveryResponse 后更新过的资源。Envoy 则会根据接受或拒绝 DiscoveryResponse 的情况，立即回复包含 ACK/NACK 的 DiscoveryRequest 请求。如果管理服务器每次发送相同的资源集结果，而不是根据其更新情况，则会导致 Envoy 和管理服务器通讯效率大打折扣。
    + REST-JSON 轮询订阅:单个 xDS API 可对 REST 端点进行同步（长）轮询。除了无持久流与管理服务器交互外，消息顺序与上述相似。在任何时间点，只存在一个未完成的请求，因此响应消息中的 nonce 在 REST-JSON 中是可选的。DiscoveryRequest 和 DiscoveryResponse 的消息编码遵循 JSON 变换 proto3 规范。ADS 不支持 REST-JSON 轮询
  - Envoy 是 Istio Service Mesh 中默认的 Sidecar，Istio 在 Enovy 的基础上按照 Envoy 的 xDS 协议扩展了其控制平面
  - Envoy xDS 为 Istio 控制平面与数据平面通信的基本协议，只要代理支持该协议表达形式就可以创建自己的 Sidecar 来替换 Envoy

## 安装

```sh
apt update
apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg2 \
  software-properties-common
curl -sL 'https://getenvoy.io/gpg' | sudo apt-key add -
apt-key fingerprint 6FF974DB

add-apt-repository \
  "deb [arch=amd64] https://dl.bintray.com/tetrate/getenvoy-deb \
  $(lsb_release -cs) \
  stable"
apt-get update && apt-get install -y getenvoy-envo

wget https://getenvoy.io/samples/basic-front-proxy.yaml
envoy -c ./basic-front-proxy.yaml
curl -s -o /dev/null -vvv -H 'Host: bing.com' localhost:15001
```

## 参考

* [Envoy 中文指南 ](https://fuckcloudnative.io/envoy-handbook/)
