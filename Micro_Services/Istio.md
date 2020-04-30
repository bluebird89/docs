# [istio/istio](https://github.com/istio/istio)

Connect, secure, control, and observe services. https://istio.io

* Istio 实现的服务网格分为数据平面和控制平面。核心能力包括4大块：
    - 流量控制（Traffic Management）
    - 安全（Security）
    - 动态规则（Policy）
    - 可观测能力（Observability）
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

* Sidecar 模式启动时会首先执行一个init 容器 istio-init ，容器只做一件事情，通过  iptables 命令配置 Pod 的网络路由规则，让 Envoy 代理可以拦截所有的进出 Pod 的流量
* 微服务应用通过 Pod 中共享的网络命名空间内的 loopback ( localhost )与 Sidecar 通讯。而外部流量也会通过 Sidecar 处理后，传入到微服务
    - 共享一个 Pod ，对其他 Pod 和节点代理都是不可见的，可以理解为两个容器共享存储、网络等资源，可以广义的将这个注入了 Sidecar 容器的 Pod 理解为一台主机，两个容器共享主机资源

## 图书

* 《云原生服务网格 Istio：原理、实践、架构与源码解析》
* 深入浅出Istio：Service Mesh快速入门与实践
* Service Mesh实战：用Istio软负载实现服务网格
* Istio 入门与实战

## 工具

* [jukylin/istio-ui](https://github.com/jukylin/istio-ui)：istio配置文件管理后台

## 参考

* [servicemesher/istio-handbook](https://github.com/servicemesher/istio-handbook):Istio Service Mesh Advanced Practical - Istio服务网格进阶实战 by ServiceMesher community https://www.servicemesher.com/istio-handbook/
* [实例](https://istiobyexample.dev/)
