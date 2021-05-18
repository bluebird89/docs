# [KubeSphere](https://github.com/kubesphere/kubesphere)

Easy-to-use Production Ready Container Platform <https://kubesphere.io>  <https://fuckcloudnative.io/posts/kubesphere/>

* 边缘节点管理:支持 KubeEdge 边缘节点纳管、KubeEdge 云端组件的安装部署、以及边缘节点的日志和监控数据采集与展示。结合 KubeEdge 的边缘自治功能和 KubeSphere 的多云与多集群管理功能，可以实现云-边-端一体化管控，解决在海量边、端设备上统一完成应用交付、运维、管控的需求
* 强化微服务治理能力
    - 基于 Istio[2] 提供了金丝雀发布、蓝绿部署、熔断等流量治理功能，同时还支持可视化呈现微服务之间的拓扑关系，并提供细粒度的监控数据。
    - 在分布式链路追踪方面，KubeSphere 基于 Jaeger 让用户快速追踪微服务之间的通讯情况，从而更易于了解微服务的请求延迟、性能瓶颈、序列化和并行调用等。
* 多云与多集群管理:移除依赖组件，使 member 集群管理服务更加轻量化，并重构了集群控制器，支持以高可用方式运行 Tower 代理服务。
* 更强大的可观测性
    - 监控：支持图形化方式配置 ServiceMonitor，添加集群层级的自定义监控，同时还实现了类似于 Grafana 的 PromQL 语法高亮。
    - 告警：在 v3.1.0 进行了架构调整，不再使用 MySQL、Redis 和 etcd 等组件以及旧版告警规则格式，改为使用 Thanos Ruler 配合 Prometheus 内置告警规则进行告警管理，兼容 Prometheus 告警规则。
    - 通知管理：完成架构调整，与自研 Notification Manager v1.0.0 的全面集成，实现了以图形化界面的方式对接邮件、钉钉、企业微信、Slack、Webhook 等通知渠道。
    - 日志：新增了对 Loki 的支持，可以将日志输出到 Loki[3]。还新增了对 kubelet/docker/containerd 的日志收集。
* 更易用的 DevOps：新增了 GitLab 多分支流水线和流水线克隆等功能，并内置了常用的流水线模板，帮助 DevOps 工程师提升 CI/CD 流水线的创建与运维效率。大部分场景下可基于流水线模板进行修改，不再需要从头开始创建，实现了真正的开箱即用
* 灵活可插拔的集群安装工具：不仅支持 Kubernetes 1.17 ~ 1.20 在 AMD 64 与 ARM 64 的安装，还支持了 K3s。并且，Kubekey 还新增支持 Cilium、Kube-OVN 等网络插件。鉴于 Dockershim 在 K8s 1.20 中被废弃，Kubekey 可用于部署 containerd、CRI-O、iSula 等容器运行时，让用户按需快速创建集群。
* 网络管理：新增了网络可视化拓扑图，你可以通过拓扑图洞悉各个服务之间的网络调用关系。鉴于 Calico 是目前最常用的 Kubernetes CNI 插件之一，v3.1.0 现已支持 Calico IP 池管理，也可以为 Deployment 指定静态 IP。此外，v3.1.0 还新增了对 Kube-OVN[4] 插件的支持。
*

## [KubeEdge](https://github.com/kubeedge/kubeedge)

一个开源的边缘计算平台，它在 Kubernetes 原生的容器编排和调度能力之上，实现了 云边协同、计算下沉、海量边缘设备管理、边缘自治 等能力。但 KubeEdge 缺少云端控制层面的支持，如果将 KubeSphere 与 KubeEdge 相结合，可以很好解决这一问题，实现应用与工作负载在云端与边缘节点进行统一分发与管理。
