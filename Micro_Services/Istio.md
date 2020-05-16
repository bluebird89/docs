# [istio/istio](https://github.com/istio/istio)

Connect, secure, control, and observe services. https://istio.io

* Istio 实现的服务网格分为数据平面和控制平面。核心能力包括4大块：
    - 流量控制（Traffic Management）
    - 安全（Security）Citadel 组件做密钥和证书管理
    - 策略控制（Policy）通过 Mixer 组件和各种适配器来实现，实现访问控制系统、遥测捕获、配额管理和计费等
        + 可以扩展和定制，同时也是可拔插
    - 可观测能力（Observability）通过 Mixer 来实现
* Istio 在控制平面上主要解决流量管理、安全、可观测性三个方面的问题，也就是前面提到的东西流量相关的问题。类似一个有配置中心的微服务集群架构
* Envoy 面向数据平面，也就是服务之间调用的代理
    - 一个由 C++ 实现的高性能代理，与其等价的，还有 Nginx、Traefik
    - Envoy 是 Istio Service Mesh 中默认的 Sidecar 方案
    - Istio 在 Enovy 的基础上按照 Envoy 的 xDS 协议扩展了其控制平面

## 版本

* 1.5
    - 把控制平面的所有组件组合并成一个单体结构叫 istiod
    - Mixer 组件被移除，新版本的 HTTP 遥测默认基于 in-proxy Stats filter
    - 同时可使用 WebAssembly 开发 in-proxy 扩展
    - 已在以下 Kubernetes 发布版本测试过：1.14, 1.15, 1.16

## 安装

* 作为 Istio 服务网格中的一部分，Kubernetes 集群中的 Pod 和 Service 必须满足以下要求：
    - 命名的服务端口: Service 的端口必须命名。端口名键值对必须按以下格式：name: <protocol>[-<suffix>]。更多说明请参看协议选择
    - Service 关联: 每个 Pod 必须至少属于一个 Kubernetes Service，不管这个 Pod 是否对外暴露端口。如果一个 Pod 同时属于多个 Kubernetes Service， 那么这些 Service 不能同时在一个端口号上使用不同的协议（比如：HTTP 和 TCP）
    - 带有 app 和 version 标签（label） 的 Deployment: 建议显式地给 Deployment 加上 app 和 version 标签。给使用 Kubernetes Deployment 部署的 Pod 部署配置中增加这些标签，可以给 Istio 收集的指标和遥测信息中增加上下文信息
        + app 标签：每个部署配置应该有一个不同的 app 标签并且该标签的值应该有一定意义。app label 用于在分布式追踪中添加上下文信息
        + version 标签：这个标签用于在特定方式部署的应用中表示版本。
    - 应用 UID: 确保 Pod 不会以用户 ID（UID）为 1337 的用户运行应用
    - NET_ADMIN 功能: 如果的集群执行 Pod 安全策略，必须给 Pod 配置 NET_ADMIN 功能。如果你使用 Istio CNI 插件 可以不配置。要了解更多 NET_ADMIN 功能的知识，请查看所需的 Pod 功能
* 安装目录
    - install/kubernetes:Kubernetes 相关的 YAML 安装文件
    - samples/ :示例应用程序
    - bin/ :istioctl 的客户端文件。istioctl 工具用于手动注入 Envoy sidecar 代理

```sh
cd /usr/local/src/
wget https://github.com/istio/istio/releases/download/1.5.1/istio-1.5.1-linux.tar.gz
tar xf istio-1.5.1-linux.tar.gz

cd istio-1.5.1

#  ~/.bashrc
PATH="$PATH:/usr/local/src/istio-1.5.1/bin" # 将 istioctl 命令添加到环境变量中
source /usr/local/src/istio-1.5.1/tools/istioctl.bash # 参数自动补全

source ~/.bashrc
```

## 原理

* Sidecar 注入与流量劫持
    - 启动时会首先执行一个init 容器 istio-init ，容器只做一件事情，通过 iptables 命令配置 Pod 的网络路由规则，让 Envoy 代理可以拦截所有的进出 Pod 的流量
* 微服务应用通过 Pod 中共享的网络命名空间内的 loopback ( localhost )与 Sidecar 通讯。而外部流量也会通过 Sidecar 处理后，传入到微服务
    - 共享一个 Pod ，对其他 Pod 和节点代理都是不可见的，可以理解为两个容器共享存储、网络等资源，可以广义的将这个注入了 Sidecar 容器的 Pod 理解为一台主机，两个容器共享主机资源
* 独立于平台的，可以在 Kubernetes 、 Consul 、虚拟机上部署的服务
* 服务网格如何在 Kubernetes 中工作
    - Istio 将服务请求路由到目的地址，根据其中的参数判断是到生产环境、测试环境还是 staging 环境中的服务（服务可能同时部署在这三个环境中），是路由到本地环境还是公有云环境？所有的这些路由信息可以动态配置，可以是全局配置也可以为某些服务单独配置。
    - 当 Istio 确认了目的地址后，将流量发送到相应服务发现端点，在 Kubernetes 中是 service，然后 service 会将服务转发给后端的实例。
    - Istio 根据它观测到最近请求的延迟时间，选择出所有应用程序的实例中响应最快的实例。
    - Istio 将请求发送给该实例，同时记录响应类型和延迟数据。
    - 如果该实例挂了、不响应了或者进程不工作了，Istio 将把请求发送到其他实例上重试。
    - 如果该实例持续返回 error，Istio 会将该实例从负载均衡池中移除，稍后再周期性的重试。
    - 如果请求的截止时间已过，Istio 主动以失败的方式结束该请求，而不是再次尝试添加负载。
    - Istio 以 metric 和分布式追踪的形式捕获上述行为的各个方面，这些追踪信息将发送到集中 metric 系统
* 组成
    - Envoy：智能代理、流量控制
    - Pilot：服务发现、流量管理
    - Mixer：访问控制、遥测
    - Citadel：终端用户认证、流量加密
    - Galley（1.1新增）：验证、处理和分配配置
* 在数据平面为每个服务中注入一个 Envoy 代理以 Sidecar 形式运行来劫持所有进出服务的流量，同时对流量加以控制，通俗的讲就是应用程序只管处理业务逻辑，其他的事情 Sidecar 会汇报给 Istio 控制平面处理
* 架构设计关键目标
    - 最大化透明度：若想 Istio 被采纳，应该让运维和开发人员只需付出很少的代价就可以从中受益。为此，Istio 将自身自动注入到服务间所有的网络路径中。Istio 使用 sidecar 代理来捕获流量，并且在尽可能的地方自动编程网络层，以路由流量通过这些代理，而无需对已部署的应用程序代码进行任何改动。在 Kubernetes中，代理被注入到 pod 中，通过编写 iptables 规则来捕获流量。注入 sidecar 代理到 pod 中并且修改路由规则后，Istio 就能够调解所有流量。这个原则也适用于性能。当将 Istio 应用于部署时，运维人员可以发现，为提供这些功能而增加的资源开销是很小的。所有组件和 API 在设计时都必须考虑性能和规模。
    - 可扩展性：随着运维人员和开发人员越来越依赖 Istio 提供的功能，系统必然和他们的需求一起成长。虽然我们期望继续自己添加新功能，但是我们预计最大的需求是扩展策略系统，集成其他策略和控制来源，并将网格行为信号传播到其他系统进行分析。策略运行时支持标准扩展机制以便插入到其他服务中。此外，它允许扩展词汇表，以允许基于网格生成的新信号来执行策略。
    - 可移植性：使用 Istio 的生态系统将在很多维度上有差异。Istio 必须能够以最少的代价运行在任何云或预置环境中。将基于 Istio 的服务移植到新环境应该是轻而易举的，而使用 Istio 将一个服务同时部署到多个环境中也是可行的（例如，在多个云上进行冗余部署）。
    - 策略一致性：在服务间的 API 调用中，策略的应用使得可以对网格间行为进行全面的控制，但对于无需在 API 级别表达的资源来说，对资源应用策略也同样重要。例如，将配额应用到 ML 训练任务消耗的 CPU 数量上，比将配额应用到启动这个工作的调用上更为有用。因此，策略系统作为独特的服务来维护，具有自己的 API，而不是将其放到代理/sidecar 中，这容许服务根据需要直接与其集成。

## 数据平面 [Enovy](https://www.envoyproxy.io/) ENVOY IS AN OPEN SOURCE EDGE AND SERVICE PROXY, DESIGNED FOR CLOUD-NATIVE APPLICATIONS

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
* Enovy 配置
    - 为 Service Mesh 中的每个 Pod 注入 Sidecar 的时候同时为 Envoy 注入 Bootstrap 配置，其余的配置是通过 Pilot 下发的，注意整个数据平面即 Service Mesh 中的 Envoy 的动态配置应该是相同的
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

## 控制平面

* 本身就是一个复杂的微服务系统, 该系统包含多个组件 Pod, 每个组件各司其职, 既有单容器 Pod, 也有多容器 Pod, 既有单进程容器, 也有多进程容器, 每个组件会调用不同的命令, 各组件之间会通过 RPC 进行协作, 共同完成对数据面用户服务的管控
* 组件
    - [istio/istioctl](https://github.com/istio/istio):包含 istio 控制面的大部分组件: pilot, mixer, citadel, galley, sidecar-injector 等
    - [istio/proxy](https://github.com/istio/proxy):本身不会产出镜像, 它可以编译出一个 name = "Envoy" 的二进制程序, 该二进制程序会被加入到 istio 的边车容器镜像 istio/proxyv2 中
        + 使用的编译方式是 Google 出品的 bazel , bazel 可以直接在编译中引入第三方库，加载第三方源码
        + 包含了对 Envoy 源码的引用，还在此基础上进行了扩展，这些扩展是通过 Envoy filter（过滤器）的形式来提供，这样做的目的是让边车代理将策略执行决策委托给 Mixer，因此可以理解为 istio proxy 这个项目有两大功能模块
            * Envoy: 使用到 Envoy 的全部功能
            * mixer client: 策略和遥测相关的客户端实现, 基于 Envoy 做扩展，通过 RPC 与 Mixer server 进行交互, 实现策略管控和遥测
    - [istio/api](https://github.com/istio/api):使用 protobuf 对 Istio API 和资源进行定义
        + 组件之间的 API, 如 Mesh Configuration Protocol (MCP) 等
        + 所有的 Istio CRD, 如 VirtualService、DestinationRule 等
* Sidecar Injector
    - 注入：本质上就是修改 Pod 的资源定义, 添加相应的 sidecar 容器定义, 内容包括 2 个新容器:
       + 名为istio-init的 initContainer: 通过配置 iptables 来劫持 Pod 中的流量
       + 名为istio-proxy的 sidecar 容器: 两个进程 pilot-agent 和 envoy, pilot-agent 进行初始化并启动 envoy
    - 实现注入 sidecar 容器
        + 自动注入: 利用 Kubernetes Dynamic Admission Webhooks 对 新建的 pod 进行注入: initContainer + sidecar
        + 手动注入: 使用命令istioctl kube-inject

## 流量管理

## Enovy

* [Envoy 中文指南 ](https://fuckcloudnative.io/envoy-handbook/)

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

## 图书

* [Istio 服务网格进阶实战](https://www.bookstack.cn/books/istio-handbook)
* 《云原生服务网格 Istio：原理、实践、架构与源码解析》
* 深入浅出Istio：Service Mesh快速入门与实践
* Service Mesh实战：用Istio软负载实现服务网格
* Istio 入门与实战
* [servicemesher/istio-handbook](https://github.com/servicemesher/istio-handbook):Istio Service Mesh Advanced Practical - Istio服务网格进阶实战 by ServiceMesher community https://www.servicemesher.com/istio-handbook/

## 工具

* [jukylin/istio-ui](https://github.com/jukylin/istio-ui)：istio配置文件管理后台

## 参考

* [Envoy documentation](https://www.envoyproxy.io/docs/envoy/latest/)
* [servicemesher / awesome-servicemesh](https://github.com/servicemesher/awesome-servicemesh/):Awesome service mesh - https://servicemesher.github.io/awesome-servicemesh/
* [实例](https://istiobyexample.dev/)
