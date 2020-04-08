# [istio/istio](https://github.com/istio/istio)

Connect, secure, control, and observe services. https://istio.io

## 版本

* 1.5
    - 把控制平面的所有组件组合并成一个单体结构叫 istiod
    - Mixer 组件被移除，新版本的 HTTP 遥测默认基于 in-proxy Stats filter
    - 同时可使用 WebAssembly 开发 in-proxy 扩展

## 安装

* Istio 1.5 已在以下 Kubernetes 发布版本测试过：1.14, 1.15, 1.16
* 作为 Istio 服务网格中的一部分，Kubernetes 集群中的 Pod 和 Service 必须满足以下要求：
    - 命名的服务端口: Service 的端口必须命名。端口名键值对必须按以下格式：name: <protocol>[-<suffix>]。更多说明请参看协议选择。
    - Service 关联: 每个 Pod 必须至少属于一个 Kubernetes Service，不管这个 Pod 是否对外暴露端口。如果一个 Pod 同时属于多个 Kubernetes Service， 那么这些 Service 不能同时在一个端口号上使用不同的协议（比如：HTTP 和 TCP）。
    - 带有 app 和 version 标签（label） 的 Deployment: 我们建议显式地给 Deployment 加上 app 和 version 标签。给使用 Kubernetes Deployment 部署的 Pod 部署配置中增加这些标签，可以给 Istio 收集的指标和遥测信息中增加上下文信息。
        + app 标签：每个部署配置应该有一个不同的 app 标签并且该标签的值应该有一定意义。app label 用于在分布式追踪中添加上下文信息。
        + version 标签：这个标签用于在特定方式部署的应用中表示版本。
    - 应用 UID: 确保 Pod 不会以用户 ID（UID）为 1337 的用户运行应用
    - NET_ADMIN 功能: 如果你的集群执行 Pod 安全策略，必须给 Pod 配置 NET_ADMIN 功能。如果你使用 Istio CNI 插件 可以不配置。要了解更多 NET_ADMIN 功能的知识，请查看所需的 Pod 功能。
* 安装目录
    - install/kubernetes 目录下，有 Kubernetes 相关的 YAML 安装文件
    - samples/ 目录下，有示例应用程序
    - bin/ 目录下，包含 istioctl 的客户端文件。istioctl 工具用于手动注入 Envoy sidecar 代理

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

## 工具

* [jukylin/istio-ui](https://github.com/jukylin/istio-ui)：istio配置文件管理后台

## 参考

* [servicemesher/istio-handbook](https://github.com/servicemesher/istio-handbook):Istio Service Mesh Advanced Practical - Istio服务网格进阶实战 by ServiceMesher community https://www.servicemesher.com/istio-handbook/
* [实例](https://istiobyexample.dev/)
