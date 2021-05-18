# 中间件

## 分层

* 用户层
* 业务服务层
* 核心服务层
* 基础设施层

## 可观测性

* 作为中间件平台的核心能力，目的是帮助检测定位中间件服务的运行状态（例如：服务异常、错误、响应缓慢等）
* 日志
  - 标准输出、标准错误输出日志收集方案
    + 实时标准输出、标准错误输出日志，业务服务层日志查询服务通过调用Kubernetes API获取中间件容器的实时标准输出、标准错误输出日志，然后展示到用户层。
    + 日志存储及检索，Kubernetes中容器重启等场景会使得日志丢失，因此需要将中间件容器的标准输出、标准错误输出日志持久化的进行存储，并且支持日志检索等需求
    + 中间件服务容器的标准输出、标准错误输出的日志会以文件的形式存储在Pod所在宿主机上。通过Kubernetes DaemonSet方式在各个节点上部署Fluentd，并采用hostPath方式将宿主机上容器日志挂载到Fluentd的Pod中。Fluentd将中间件容器的日志发送到Kafka，最终存储到ElasticSearch中。
  - 容器内日志收集方案
    + 采用Sidecar模式中间件Pod中增加日志收集容器Filebeat，Filebeat容器与中间件容器的日志目录通过emptyDir挂载的方式实现目录共享。Filebeat根据ConfigMap定义的配置，将中间件日志发送到Kafka，最终存储到ElasticSearch中。
* 指标监控:exporter通过RESTful API的方式暴露指标数据，Prometheus从各个exporter中拉取指标数据，并进行持久化存储。Alertmanager则是Prometheus内置的告警模块
  - 节点监控，节点的指标收集通过node exporter实现。node exporter通过DaemonSet方式部署在Kubernetes的每个节点上，用于采集节点的运行指标，包括节点CPU，内存，文件系统等指标。
  - Kubernetes资源状态监控，kube-state-metrics采用Deployment方式部署，通过监听Kubernetes apiserver将Kubernetes资源的数据生成相应指标。在云原生游戏中间件平台场景下，我们需要对自定义游戏中间件资源状态进行监控。
  - 容器监控，cAdvisor对节点容器进行实时监控和性能数据采集，包括CPU使用情况、内存使用情况、网络吞吐量及文件系统使用情况。cAdvisor以及集成在kubelet中，当kubelet启动时会自动启动cAdvisor。
  - 中间件服务监控，上述监控从Kubernetes资源状态、节点、容器层进行，而更细粒度的就需要游戏中间件服务本身进行监控，不同游戏中间件需要监控的服务指标也不相同。游戏中间件平台层就需要针对各个中间件资源实现各自的exporter，从而达到服务级别的监控。

## CacheServer

* Unity的缓存服务器。网易基于Unity CacheServer v1协议，自研了CacheServer服务，CacheServer由Nginx作为入口，资源数据都存储在ARDB中。ARDB是一个类似Redis的KV存储，但相比Redis的优点就是数据都由底层的RocketsDB持久化存储在磁盘上，在Redis服务中只存储所有资源数据内容的key，以及在key上设置TTL，再由Cleaner Server负责清理
* CRD定义包含了三部分：
  - 基础信息：名称、Namepace、CacheServer镜像、Cleaner镜像、镜像拉取Secret等。
  - 资源配置：CPU、内存、持久化存储大小。
  - 调度：CacheServer Pod调度配置Tolerance、NodeSelector等。
* CacheServer Operator分为资源管理和状态管理两个部分：
  - 资源管理：管理CacheServer所包含的Pod、Service等子资源。Operator通过list、watch监听CacheServer事件（创建、更新、删除），发送到Resource Handler的队列中，由控制循环取出事件并处理。创建资源时将子资源的OwnerReference设置成父资源，可以在删除CacheServer时利用kubernetes级联删除有效删除子资源。
  - 状态管理：实时更新CacheServer的运行状态。Operator通过list、watch循环监听CacheServer Pod资源，根据Pod运行状态，更新CacheServer的状态。
* 优化
  - 存储优化:CacheServer使用场景下对数据的读写性能要求非常高，arbd数据的持久化存储需要重点考虑。以往常用的网络存储Ceph Rbd等方案无法达到我们的性能要求。因此我们采用宿主机存储的方案。Kubernetes提供了hostPath、emptyDir、local volume等。
    + hostPath：映射宿主机文件系统中的文件或者目录到Pod，需要数据清理等管理。local volume需要维护挂载点。本方案采用emptyDir的方式。
    + emptyDir：Pod分配到Node上时被创建，Kubernetes会在Node上自动分配一个目录，因此无需指定宿主机Node上对应的目录文件。
    + local volume：通过PVC方式访问宿主机的本地存储，但静态provisioner仅支持发现和管理挂载点，必须将它们通过bind-mounted的方式绑定到发现目录中。
    + 本方案采用emptyDir的方式，emptyDir数据生命周期与Pod的生命周期是一致的。并设置Pod的QoS等级避免被驱逐，从而高效的管理管理CacheServer数据存储。
  - 调度优化: CacheServer的资源数据上传下载会对网络、磁盘要求很高。为了避免多个CacheServer集中在一个节点上而相互影响，我们采用了Kubernetes的反亲和性特性，将CacheServer Pod进行节点维度的反亲和
  - 节点优化:针对CacheServer的特性，需要对宿主机的内核参数，以及硬件设备进行优化升级。
    + 内核参数优化：包括net.ipv4.tcp_sack，net.core.rmem_max，net.core.wmem_max，net.core.wmem_default，net.ipv4.tcp_mem，net.ipv4.tcp_rmem，net.ipv4.tcp_wmem等。
    + 硬件升级：磁盘使用SSD，提升ardb数据的读写能力。

```
type Cacheserver struct {
    metav1.TypeMeta   `json:",inline"`
    metav1.ObjectMeta `json:"metadata,omitempty"`

    Spec   CacheserverSpec   `json:"spec,omitempty"`
    Status CacheserverStatus `json:"status,omitempty"`
}

type CacheserverSpec struct {
    Storage int64 `json:"storage"`
    Image string `json:"image"`
    Resources corev1.ResourceRequirements `json:"resources"`
    Cleaner Cleaner `json:"cleaner"`
    Tolerations []corev1.Toleration `json:"tolerations"`
    NodeSelector map[string]string `json:"nodeSelector"`
    ImagePullSecrets []corev1.LocalObjectReference `json:"imagePullSecrets,omitempty"`
}

type CacheserverStatus struct {
    Phase string `json:"phase"`
}

type Cleaner struct {
    Webhook string `json:"webhook"`
    Image string `json:"image"`
}
```

``` yaml
# 设置CacheServer Pod反亲和性
affinity:
  podAntiAffinity:
    preferredDuringSchedulingIgnoredDuringExecution:
    - podAffinityTerm:
        labelSelector:
          matchLabels:
             app.kubernetes.io/managed-by: cacheserver-operator
        topologyKey: kubernetes.io/hostname
      weight: 100
```

## 参考

* [网易伏羲云原生游戏中间件平台实践](https://mp.weixin.qq.com/s/vI15rzHzRs_Z2n45BQX8oQ)
