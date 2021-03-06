# [istio](https://github.com/istio/istio)

Connect, secure, control, and observe services. <https://istio.io>

* Istio 实现的服务网格将控制平面（Control Plane）与数据平面（Data Plane）解耦。核心能力：
  - 流量控制（Traffic Management）
  - 安全（Security）Citadel 组件做密钥和证书管理
  - 策略控制（Policy）通过 Mixer 组件和各种适配器来实现，实现访问控制系统、遥测捕获、配额管理和计费等
    + 可以扩展和定制，同时也是可拔插
  - 可观测能力（Observability）通过 Mixer 来实现
* Istio 在控制平面上主要解决流量管理、安全、可观测性三个方面的问题，也就是前面提到的东西流量相关的问题。类似一个有配置中心的微服务集群架构
* 通过独立的控制平面可以对 Mesh 获得全局性的可观测性（Observability）和可控制性（Controllability），从而让 Service Mesh 有机会上升到平台的高度，这对于对于希望提供面向微服务架构基础设施的厂商，或是企业内部需要赋能业务团队的平台部门都具有相当大的吸引力。
* Envoy 面向数据平面，也就是服务之间调用的代理
  - 一个由 C++ 实现的高性能代理，与其等价的，还有 Nginx、Traefik
  - Envoy 是 Istio Service Mesh 中默认的 Sidecar 方案
  - Istio 在 Enovy 的基础上按照 Envoy 的 xDS 协议扩展了其控制平面
* Envoy 是 Istio Service Mesh 中默认的 Sidecar 方案,在 Enovy 的基础上按照 Envoy 的 xDS 协议扩展了其控制平面

## 版本

* 1.5：回归单体 - 自我救赎
  - 把控制平面的所有组件组合并成一个单体结构叫 istiod
  - Mixer 组件被移除，新版本的 HTTP 遥测默认基于 in-proxy Stats filter
  - 同时可使用 WebAssembly 开发 in-proxy 扩展
  - 进程外的扩展替换为为Envoy WASM，删除了很多不必要的CRD，简化了用户用户使用体验
  - 合并控制平面组件到单体应用 istiod 内部，降低了安装、配置和问题诊断的复杂度
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
#  ~/.bashrc
PATH="$PATH:/usr/local/src/istio-1.5.1/bin"
source /usr/local/src/istio-1.5.1/tools/istioctl.bash # 参数自动补全
source ~/.bashrc

curl -L https://istio.io/downloadIstio | sh -
```

## 原理

* Sidecar 注入与流量劫持：启动时首先执行一个init 容器 istio-init ，只做一件事情，通过 iptables 命令配置 Pod 的网络路由规则，让 Envoy 代理可以拦截所有的进出 Pod 的流量
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
  - 数据平面：Envoy：智能代理、流量控制
  - 控制平面
    + Pilot：服务发现、流量管理
      * 提供服务发现功能，为智能路由（例如A/B测试、金丝雀部署等）和弹性（超时、重试、熔断器等）提供流量管理功能；
      * 将控制流量行为的高级路由规则转换为特定于 Envoy 的配置，并在运行时将它们传播到 sidecar
    + Mixer：访问控制、遥测
      * 在服务网格上执行访问控制和使用策略，并从 Envoy 代理和其他服务收集遥测数据
      * 代理提取请求级属性，发送到Mixer进行评估
      * 1.1 解耦为单独组件
    + Citadel：终端用户认证、流量加密
      * 通过内置身份和凭证管理赋能强大的服务间和最终用户身份验证
      * 可用于升级服务网格中未加密的流量，并为运维人员提供基于服务标识而不是网络控制的强制执行策略的能力
    + Galley（1.1新增）：验证、处理和分配配置
      * 验证用户编写的 Istio API 配置；
      * 未来的版本中 Galley 将接管获取配置、处理和分配组件的顶级责任，从而将其他的 Istio 组件与从底层平台（例如 k8s）获取用户配置的细节中隔离开来；
* 在数据平面为每个服务中注入一个 Envoy 代理以 Sidecar 形式运行来劫持所有进出服务的流量，同时对流量加以控制，通俗的讲就是应用程序只管处理业务逻辑，其他的事情 Sidecar 会汇报给 Istio 控制平面处理
* 架构设计关键目标
  - 最大化透明度：若想 Istio 被采纳，应该让运维和开发人员只需付出很少的代价就可以从中受益。为此，Istio 将自身自动注入到服务间所有的网络路径中。Istio 使用 sidecar 代理来捕获流量，并且在尽可能的地方自动编程网络层，以路由流量通过这些代理，而无需对已部署的应用程序代码进行任何改动。在 Kubernetes中，代理被注入到 pod 中，通过编写 iptables 规则来捕获流量。注入 sidecar 代理到 pod 中并且修改路由规则后，Istio 就能够调解所有流量。这个原则也适用于性能。当将 Istio 应用于部署时，运维人员可以发现，为提供这些功能而增加的资源开销是很小的。所有组件和 API 在设计时都必须考虑性能和规模。
  - 可扩展性：随着运维人员和开发人员越来越依赖 Istio 提供的功能，系统必然和他们的需求一起成长。虽然我们期望继续自己添加新功能，但是我们预计最大的需求是扩展策略系统，集成其他策略和控制来源，并将网格行为信号传播到其他系统进行分析。策略运行时支持标准扩展机制以便插入到其他服务中。此外，它允许扩展词汇表，以允许基于网格生成的新信号来执行策略。
  - 可移植性：使用 Istio 的生态系统将在很多维度上有差异。Istio 必须能够以最少的代价运行在任何云或预置环境中。将基于 Istio 的服务移植到新环境应该是轻而易举的，而使用 Istio 将一个服务同时部署到多个环境中也是可行的（例如，在多个云上进行冗余部署）。
  - 策略一致性：在服务间的 API 调用中，策略的应用使得可以对网格间行为进行全面的控制，但对于无需在 API 级别表达的资源来说，对资源应用策略也同样重要。例如，将配额应用到 ML 训练任务消耗的 CPU 数量上，比将配额应用到启动这个工作的调用上更为有用。因此，策略系统作为独特的服务来维护，具有自己的 API，而不是将其放到代理/sidecar 中，这容许服务根据需要直接与其集成。

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

* 功能
  - 路由、流量转移
  - 流量进出
  - 网络弹性能力
  - 测试相关
* 虚拟服务:将流量路由到给定目标地址
  - 请求地址与真实的工作负载解耦
  - 包含一组路由规则
  - 通常和目标规则(Destination Rule)成对出现
  - 丰富的路由匹配规则
* 目标规则(Destination Rule)
  - 定义虚拟服务路由目标地址的真实地址,即子集(subset)
  - 设置负载均衡的方式
    + 随机
    + 权重
    + 最少请求数
* 网关
  - 管理进出网格流量
  - 处在网格边界
* 服务发现
* 负载均衡
* 路由
* 限流
* 熔断
* 容错

## 可观测性

* 计量
* 监控指标(Metrics)：以聚合的方式监控和理解系统行为
  - Istio 中的指标分类:
    + 代理级别的指标(Proxy-level)
    + 服务级别的指标(Service-level)
    + 控制平面指标(Control plane)
* 日志聚合 访问日志(Access logs)： 通过应用产生的事件来了解系统 包括了完整的元数据信息(目标、源) 生成位置可选(本地、远端,如 filebeat)
  - 日志内容
    + 应用日志
    + Envoy 日志 $ kubectl logs -l app=demo -c istio-proxy
* 分布式追踪(Distributed tracing)：通过追踪请求,了解服务的调用关系，常用于调用链的问题排查、性能分析等。支持多种追踪系统(Jeager、Zipkin、Datadog)

## 安全

* 认证
  - 对等认证(Peer authentication)
    + 用于服务间身份认证
    + Mutual TLS(mTLS)
  - 请求认证(Request authentication)
    + 用于终端用户身份认证
    + JSON Web Token(JWT)
* 授权

```sh
istioctl manifest apply --set profile=demo
```

## 动态配置

## 故障注入

## 镜像流量

## [Istio 中的授权策略详解](https://mp.weixin.qq.com/s/xbGG9ZWc63Zce24dBYhvrQ)

## 图书

* [Istio 服务网格进阶实战](https://www.bookstack.cn/books/istio-handbook)
  - [servicemesher/istio-handbook](https://github.com/servicemesher/istio-handbook):Istio Service Mesh Advanced Practical
  - [Istio Handbook——Istio 服务网格进阶实战](https://www.servicemesher.com/istio-handbook/)
* 《云原生服务网格 Istio：原理、实践、架构与源码解析》
* 深入浅出Istio：Service Mesh快速入门与实践
* Service Mesh实战：用Istio软负载实现服务网格
* Istio 入门与实战

## 工具

* [istio-ui](https://github.com/jukylin/istio-ui)：istio配置文件管理后台

## 参考

* [实例](https://istiobyexample.dev/)

[深入实践 Istio](https://mp.weixin.qq.com/s/QIG71Z24__X-LJLRM-RRJA)
