#  [kubernetes/kubernetes](https://github.com/kubernetes/kubernetes)

Production-Grade Container Scheduling and Management http://kubernetes.io

* Kubernetes 作为Docker生态圈中重要一员，是Google多年大规模容器管理技术的开源版本，是产线实践经验的最佳表现。如Urs Hölzle所说，无论是公有云还是私有云甚至混合云，Kubernetes将作为一个为任何应用，任何环境的容器管理框架无处不在
* 使用Golang开发，其提供应用部署、维护、扩展机制等功能，利用Kubernetes能方便地管理跨机器运行容器化的应用，其主要功能如下：
    + 使用Docker对应用程序包装(package)、实例化(instantiate)、运行(run)。
    + 以集群的方式运行、管理跨机器的容器。
    + 解决Docker跨机器容器之间的通讯问题。
    + Kubernetes的自我修复机制使得容器集群总是运行在用户期望的状态。
* 支持GCE、vShpere、CoreOS、OpenShift、Azure等平台

## 原理

* K8s很多的抽象概念非常契合分布式调度系统，可以做到描述集群架构，定义服务状态，并维持，其实现了分布式集群的配置管理和维护包括动态伸缩及故障迁移。
* Kubernetes 是自动化编排容器应用的开源平台，这些操作不仅包括部署、调度和节点集群间扩展，还包括服务发现和配置服务等架构支持的基础能力。Kubernetes 对应用层面的关注、对微服务、云原生的支持及其生态，
* 服务治理范围覆盖了服务的整个生命周期，从服务建模开始，到开发、测试、审批、发布、运行时管理，以及最后的下线。我们通常说的服务治理主要是指服务运行时的治理，一个好的服务治理框架要遵循"在线治理，实时生效"原则，只有这样才能真正保障服务整体质量
* 服务越来越多，配置项越来越多，利用统一注册中心解决服务发现和配置管P理问题。
* 服务之间存在多级依赖，靠人工已经无法理清，还要避免潜在的循环依赖问题，我们需要依赖管理机制，支持导出依赖关系图。
* 服务的性能数据和健康状态数据是服务治理的重要依据，比如访问量、响应时间、并发数等，因此需要有监控、健康检查和统计服务。
* 当一个服务的访问量越来越大，需要对服务进行扩容，然后在客户端进行流量引导和优先级调度。
* 面对突发流量，已经无法通过扩容解决问题时，要启用流量控制，甚至服务降级。
* 随着业务持续发展，要提前进行容量规划，结合服务监控数据，以确认当前系统容量能否支撑更高水位的压力。
* 等越来越多的微服务上线之后，从安全角度看，我们需要实施明确的权限控制策略和服务上下线流程。
* 通过一系列的服务治理策略，最终通过数据证明系统对外承诺的 SLA。
* 基于负载均衡的应用弹性伸缩方案，只要将应用系统设计成无状态，在需要伸缩的时候修改负载均衡代理配置，就可以方便地水平扩容应用系统，提高系统承载能力。
* Horizontal Pod Autoscaler （HPA）组件专门设计用于应用弹性扩容的控制器，它通过定期轮询 Pod 的状态（CPU、内存、磁盘、网络，或者自定义的应用指标），当 Pod 的状态连续达到提前设置的阈值时，就会触发副本控制器，修改其应用副本数量，使得 Pod 的负载重新回归到正常范围之内。

![架构](../_static/kubernates_architect.png)

## 概念

* Pods:调度的最小颗粒不是单纯的容器，而是抽象成一个Pod，Pod是一个可以被创建、销毁、调度、管理的最小的部署单元
    - 把相关的一个或多个容器（Container）构成一个Pod，通常Pod里的容器运行相同的应用
    - Pod包含的容器运行在同一个Minion(Host)上，看作一个统一管理单元，共享相同的volumes和network namespace/IP和Port空间
* Services:基本操作单元，是真实应用服务的抽象，每一个服务后面都有很多对应的容器来支持，通过Proxy的port和服务selector决定服务请求传递给后端提供服务的容器，对外表现为一个单一访问地址，外部不需要了解后端如何运行，这给扩展或维护后端带来很大的好处
* Replication Controllers:理解成更复杂形式的pods，它确保任何时候Kubernetes集群中有指定数量的pod副本(replicas)在运行，如果少于指定数量的pod副本(replicas)，Replication Controller会启动新的Container，反之会杀死多余的以保证数量不变
    - 使用预先定义的pod模板创建pods，一旦创建成功，pod 模板和创建的pods没有任何关联，可以修改 pod 模板而不会对已创建pods有任何影响，也可以直接更新通过Replication Controller创建的pods。对于利用 pod 模板创建的pods，Replication Controller根据 label selector 来关联，通过修改pods的label可以删除对应的pods。Replication Controller主要有如下用法：
    - Rescheduling:Replication Controller会确保Kubernetes集群中指定的pod副本(replicas)在运行， 即使在节点出错时
    - Scaling:通过修改Replication Controller的副本(replicas)数量来水平扩展或者缩小运行的pods。
    - Rolling updates:Replication Controller的设计原则使得可以一个一个地替换pods来滚动更新（rolling updates）服务。
    - Multiple release tracks:如果需要在系统中运行multiple release的服务，Replication Controller使用labels来区分multiple release tracks。
    - 以上三个概念便是用户可操作的REST对象。Kubernetes以RESTfull API形式开放的接口来处理
* Labels：service和replicationController只是建立在pod之上的抽象，最终是要作用于pod的，那么它们如何跟pod联系起来呢？这就引入了label的概念：label其实很好理解，就是为pod加上可用于搜索或关联的一组key/value标签，而service和replicationController正是通过label来与pod关联的。为了将访问Service的请求转发给后端提供服务的多个容器，正是通过标识容器的labels来选择正确的容器；Replication Controller也使用labels来管理通过 pod 模板创建的一组容器，这样Replication Controller可以更加容易，方便地管理多个容器。
* 如下图所示，有三个pod都有label为"app=backend"，创建service和replicationController时可以指定同样的label:"app=backend"，再通过label selector机制，就将它们与这三个pod关联起来了。例如，当有其他frontend pod访问该service时，自动会转发到其中的一个backend pod

![](../_static/labels.png)

## 知识结构

* Kubernetes集群架构
    - Kubernetes集群架构概述
    - Master及各组件
    - Node及相关组件
    - 核心附件CoreDNS、HeapSter（Prometheus）、Dashboard及Ingress Controller概述
    - 核心资源类型：Pod、Deployment、Service
* Kubernetes快速入门
    - Kubernetes集群的部署方法及部署要点
    - 部署Kubernetes分布式集群
    - kubectl使用基础
    - 命令式应用部署、扩缩容、服务暴露
* 资源配置清单及Pod资源
    - Kubernetes API中的资源配置格式
    - 资源类型 API群组及其版本介绍
    - Pod资源及其配置格式
    - 使用配置清单创建自主式Pod资源
    - 标签及标签选择器
    - Pod的节点选择器
    - 容器存活状态探测及就绪状态探测
* Pod控制器
    - Pod控制器及其功用
    - 通过配置清单管理ReplicaSet控制器，包括扩缩容及更新机制
    - Deployment控制器基础应用及滚动更新：灰度部署、金丝雀部署、蓝绿部署的实现；
    - DaemonSet控制器基础应用及使用案例
* Service资源对象
    - Service及其实现模型
    - Service的类型及其功用
    - 各Service类型的创建及应用方式
    - Headless Service
    - 基于DNS的服务发现简介
    - Ingress类型及实现方式
    - Ingress Controller及部署
    - Ingress使用案例：发布http及https的tomcat服务
* K8S-存储卷
    - 存储卷及其功用
    - 常见的存储卷类型及应用：emptyDir、hostPath、nfs、glusterfs等
    - PV及PVC
    - StorageClass及PV的动态供给
    - ConfigMap
    - Secret
* StatefulSet
    - 有状态及无状态应用对比
    - 有状态应用的容器难题
    - StatefulSet及其应用
*  网络模型及网络策略
    - flannel工作原理及host-gw等实现方式
    - calico及其应用
    - 网络策略及其工作机制
    - 基于calico的网络策略的实现
* 认证、授权及准入控制
    - Kubernetes的认证、授权及准入控制机制
    - ServiceAccount
    - 令牌认证及证书认证
    - RBAC及其实现机制
    - Role和RoleBinding
    - ClusterRole和ClusterRoleBinding
* 调度器
    - 资源需求、资源限额及其应用
    - Pod优选级类别
    - Pod调度器工作原理
    - 预选及预选策略
    - 优选及优选算法
    - 高级调度方法
* 资源监控及HPA
    - HeapSter、InfluxDB及Grafana实现资源监控
    - HPA v1
    - Prometheus及Grafana实现资源监控
    - Metrics-Server
    - HPA v2
* helm及日志收集系统
    - helm工作原理
    - helm部署及其应用
    - 部署efk日志收集系统

## 构件

Kubenetes整体框架如下图，主要包括kubecfg、Master API Server、Kubelet、Minion(Host)以及Proxy

* Master 控制节点:定义了Kubernetes 集群Master/API Server的主要声明，包括Pod Registry、Controller Registry、Service Registry、Endpoint Registry、Minion Registry、Binding Registry、RESTStorage以及Client, 是client(Kubecfg)调用Kubernetes API，管理Kubernetes主要构件Pods、Services、Minions、容器的入口。Master由API Server、Scheduler以及Registry等组成。从下图可知Master的工作流主要分以下步骤：
    - Kubecfg将特定的请求，比如创建Pod，发送给Kubernetes Client。
    - Kubernetes Client将请求发送给API server。
    - API Server根据请求的类型，比如创建Pod时storage类型是pods，然后依此选择何种REST Storage API对请求作出处理。
    - REST Storage API对的请求作相应的处理。
    - 将处理的结果存入高可用键值存储系统Etcd中。
    - 在API Server响应Kubecfg的请求后，Scheduler会根据Kubernetes Client获取集群中运行Pod及Minion信息。
    - 依据从Kubernetes Client获取的信息，Scheduler将未分发的Pod分发到可用的Minion节点上。 ![](../_static/master.png)
* API Server(资源操作入口):提供了k8s各类资源对象（pod,RC,Service等）的增删改查及watch等HTTP Rest接口，是整个系统的数据总线和数据中心。只有API Server与存储通信，其他模块通过API Server访问集群状态。
    - 是为了保证集群状态访问的安全。
    - 是为了隔离集群状态访问的方式和后端存储实现的方式：API Server是状态访问的方式，不会因为后端存储技术etcd的改变而改变。
    - 作为kubernetes系统的入口，封装了核心对象的增删改查操作，以RESTFul接口方式提供给外部客户和内部组件调用。对相关的资源数据"全量查询"+"变化监听"，实时完成相关的业务功能。
        + 提供了集群管理的REST API接口(包括认证授权、数据校验以及集群状态变更)；
        + 提供其他模块之间的数据交互和通信的枢纽（其他模块通过API Server查询或修改数据，只有API Server才直接操作etcd）;
        + 是资源配额控制的入口；
        + 拥有完备的集群安全机制.
* Controller Manager(内部管理控制中心)
    - 实现集群故障检测和恢复的自动化工作，负责执行各种控制器，主要有： endpoint-controller：定期关联service和pod(关联信息由endpoint对象维护)，保证service到pod的映射总是最新的。
    - replication-controller：定期关联replicationController和pod，保证replicationController定义的复制数量与实际运行pod的数量总是一致的。
* Scheduler(集群分发调度器)
    - Scheduler收集和分析当前Kubernetes集群中所有Minion节点的资源(内存、CPU)负载情况，然后依此分发新建的Pod到Kubernetes集群中可用的节点。 实时监测Kubernetes集群中未分发和已分发的所有运行的Pod。
    - Scheduler也监测Minion节点信息，由于会频繁查找Minion节点，Scheduler会缓存一份最新的信息在本地。
    - Scheduler在分发Pod到指定的Minion节点后，会把Pod相关的信息Binding写回API Server
- Minion Registry负责跟踪Kubernetes 集群中有多少Minion(Host)。Kubernetes封装Minion Registry成实现Kubernetes API Server的RESTful API接口REST，通过这些API，我们可以对Minion Registry做Create、Get、List、Delete操作，由于Minon只能被创建或删除，所以不支持Update操作，并把Minion的相关配置信息存储到etcd。除此之外，Scheduler算法根据Minion的资源容量来确定是否将新建Pod分发到该Minion节点。可以通过`curl http://{master-apiserver-ip}:4001/v2/keys/registry/minions/`来验证etcd中存储的内容。
- Pod Registry负责跟踪Kubernetes集群中有多少Pod在运行，以及这些Pod跟Minion是如何的映射关系。将Pod Registry和Cloud Provider信息及其他相关信息封装成实现Kubernetes API Server的RESTful API接口REST。通过这些API，我们可以对Pod进行Create、Get、List、Update、Delete操作，并将Pod的信息存储到etcd中，而且可以通过Watch接口监视Pod的变化情况，比如一个Pod被新建、删除或者更新。
- Service Registry负责跟踪Kubernetes集群中运行的所有服务。根据提供的Cloud Provider及Minion Registry信息把Service Registry封装成实现Kubernetes API Server需要的RESTful API接口REST。利用这些接口，我们可以对Service进行Create、Get、List、Update、Delete操作，以及监视Service变化情况的watch操作，并把Service信息存储到etcd。
- Controller Registry负责跟踪Kubernetes集群中所有的Replication Controller，Replication Controller维护着指定数量的pod 副本(replicas)拷贝，如果其中的一个容器死掉，Replication Controller会自动启动一个新的容器，如果死掉的容器恢复，其会杀死多出的容器以保证指定的拷贝不变。通过封装Controller Registry为实现Kubernetes API Server的RESTful API接口REST， 利用这些接口，我们可以对Replication Controller进行Create、Get、List、Update、Delete操作，以及监视Replication Controller变化情况的watch操作，并把Replication Controller信息存储到etcd。
- Endpoints Registry负责收集Service的endpoint，比如Name："mysql"，Endpoints: ["10.10.1.1:1909"，"10.10.2.2:8834"]，同Pod Registry，Controller Registry也实现了Kubernetes API Server的RESTful API接口，可以做Create、Get、List、Update、Delete以及watch操作。
- Binding包括一个需要绑定Pod的ID和Pod被绑定的Host，Scheduler写Binding Registry后，需绑定的Pod被绑定到一个host。Binding Registry也实现了Kubernetes API Server的RESTful API接口，但Binding Registry是一个write-only对象，所有只有Create操作可以使用， 否则会引起错误。
- Scheduler收集和分析当前Kubernetes集群中所有Minion节点的资源(内存、CPU)负载情况，然后依此分发新建的Pod到Kubernetes集群中可用的节点。由于一旦Minion节点的资源被分配给Pod，那这些资源就不能再分配给其他Pod， 除非这些Pod被删除或者退出， 因此，Kubernetes需要分析集群中所有Minion的资源使用情况，保证分发的工作负载不会超出当前该Minion节点的可用资源范围。具体来说，Scheduler做以下工作：
  - 实时监测Kubernetes集群中未分发的Pod。
  - 实时监测Kubernetes集群中所有运行的Pod，Scheduler需要根据这些Pod的资源状况安全地将未分发的Pod分发到指定的Minion节点上。
  - Scheduler也监测Minion节点信息，由于会频繁查找Minion节点，Scheduler会缓存一份最新的信息在本地。
  - 最后，Scheduler在分发Pod到指定的Minion节点后，会把Pod相关的信息Binding写回API Server。
* Kubelet:Kubelet是Kubernetes集群中每个Minion和Master API Server的连接点，Kubelet运行在每个Minion上，是Master API Server和Minion之间的桥梁，接收Master API Server分配给它的commands和work，与持久性键值存储etcd、file、server和http进行交互，读取配置信息
    - 主要工作是管理Pod和容器的生命周期，其包括Docker Client、Root Directory、Pod Workers、Etcd Client、Cadvisor Client以及Health Checker组件，
    - 具体工作如下：
        + 通过Worker给Pod异步运行特定的Action
        + 设置容器的环境变量
        + 给容器绑定Volume
        + 给容器绑定Port
        + 根据指定的Pod运行一个单一容器
        + 杀死容器
        + 给指定的Pod创建network 容器
        + 删除Pod的所有容器
        + 同步Pod的状态
        + 从cAdvisor获取container info、 pod info、 root info、 machine info
        + 检测Pod的容器健康状态信息
        + 在容器中运行命令。
* Proxy:为了解决外部网络能够访问跨机器集群中容器提供的应用服务而设计的，运行在每个Minion上。Proxy提供TCP/UDP sockets的proxy，每创建一种Service，Proxy主要从etcd获取Services和Endpoints的配置信息（也可以从file获取），然后根据配置信息在Minion上启动一个Proxy的进程并监听相应的服务端口，当外部请求发生时，Proxy会根据Load Balancer将请求分发到后端正确的容器处理。
    -   所以Proxy不但解决了同一主宿机相同服务端口冲突的问题，还提供了Service转发服务端口对外提供服务的能力，Proxy后端使用了随机、轮循负载均衡算法。关于更多 [kube-proxy 的内容 KUBERNETES代码走读之MINION NODE 组件 KUBE-PROXY](http://www.sel.zju.edu.cn/?spm=5176.100239.blogcont47308.8.2bn7P0&p=484)
    -   Proxy是为了解决外部网络能够访问跨机器集群中容器提供的应用服务而设计的，运行在每个Node上。Proxy提供TCP/UDP sockets的proxy，每创建一种Service，Proxy主要从etcd获取Services和Endpoints的配置信息（也可以从file获取），然后根据配置信息在Minion上启动一个Proxy的进程并监听相应的服务端口，当外部请求发生时，Proxy会根据Load Balancer将请求分发到后端正确的容器处理。
    -   Proxy不但解决了同一主宿机相同服务端口冲突的问题，还提供了Service转发服务端口对外提供服务的能力，Proxy后端使用了随机、轮循负载均衡算法。

![](../_static/constructor.png)
![](../_static/kubelet.png)

### kubectl（kubelet client）集群管理命令行工具集

通过客户端的kubectl命令集操作，API Server响应对应的命令结果，从而达到对kubernetes集群的管理

```sh
kubectl delete deployments hello-minikube1
```

### etcd

它并不是kubernetes的一部分，它是 CoreOS 团队发起的一个管理配置信息和服务发现（service discovery）项目，目标是构建一个高可用的分布式键值（key-value）数据库。与kubernetes和docker一样还是在快速迭代开发中的产品，没有ZooKeeper那样成熟。

### 熔断机制

* 微服务架构中，各服务通过服务发现的方式互相依赖，虽然从单个服务看来能获得非常好的隔离性，不会因为某个进程或者服务宕掉对其他服务造成直接影响，但是从业务角度来看，单个服务实例故障还是可能造成业务访问出现问题，轻则影响服务调用方出现延迟和负载上升，重则造成业务整体异常。微服务调用中很容易出现的级联失败。断路器是一个开关，本意是指电路系统上的一种保护线路电流过载的一种装置，当线路中电流太大或者发生短路时，断路器开关打开，电路切断，防止引起更加严重的后果。引申到微服务治理策略中，断路器的作用就是避免故障或者异常在微服务调用链中蔓延。
* 服务调用方在尝试调用远端服务时，同时提供一个 fallback 方法，就是当远端服务出现故障时，调用 fallback 方法，快速返回结果，避免级联效应，使故障隔离。同时，断路器应该需要提供一个阈值开关，当远端服务的调用连续失败次数超过某个阈值时，服务调用方直接调用 fallback 方法，不再请求远端服务。等远端服务恢复后，再恢复正常调用流程。

### 服务降级

服务降级也是服务治理策略中重要的一环。当业务出现流量峰值，或者系统中某个组成部分出现故障，保证系统整体功能仍然可用，我们可能需要停掉一些不太重要的周边系统，从而保证核心服务的 SLA。比如电商系统在进行大促时，往往会弃车保帅，优先选择停止"猜你喜欢"、"评论"等不那么重要的系统，保障购物车、支付系统可用。在微服务架构里，每个服务无论是服务提供方还是服务调用方，都应该围绕 SLA 制定不同的降级策略。按降级粒度粗细我们可以制定接口降级、功能降级、服务降级。

- 接口降级：对于非核心接口，设置为直接返回空或异常，可以在高峰期有效减少接口逻辑对资源（CPU、内存、网络 I/O、磁盘 I/O 等）的占用和消耗。
- 功能降级：对于非核心功能，可以设置该功能直接执行本地逻辑，不做跨服务、跨网络访问。也可以设置降级开关，一键关闭指定功能，保全系统稳定运行。
- 服务降级：对于非核心服务，可以通过服务治理框架根据错误率或者响应时间自动触发降级策略。
* 功能降级和服务降级可以通过熔断机制和断路器实现
    + 自动化容器的部署与复制
    + 服务与命名发现
    + 集群调度
    + 自动扩展及收缩服务器规模
    + 容器编排，负载均衡
    + 应用升级部署
    + 弹性容器及故障迁移
    + 集群监控

### [kubernetes/minikube](https://github.com/kubernetes/minikube)

Run Kubernetes locally Minikube is a small setup by Kubernetes guys, which will spawn a virtual machine and have a tiny (but fully functional) Kubernetes cluster inside the VM.
kubectl is the command line client you’ll use to connect to the Kubernetes cluster

* config file: `~/.kube/`
* all the virtual machine bits:`~/.minikube/`

```shell
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew cask install virtualbox

curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.7.1/minikube-darwin-amd64
chmod +x minikube
sudo mv minikube /usr/local/bin/

minikube status

curl -Lo kubectl http://storage.googleapis.com/kubernetes-release/release/v1.3.0/bin/darwin/amd64/kubectl
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

kubectl get pods --all-namespaces  // list two pods, one an ‘addon-manager’ and another a ‘dashboard’
```

## 工具

* 配置
    - [kubernetes-sigs/kustomize](https://github.com/kubernetes-sigs/kustomize):Customization of kubernetes YAML configurations
* 部署
    - [kubernetes-incubator/kubespray](https://github.com/kubernetes-incubator/kubespray):Deploy a Production Ready Kubernetes Cluster
* UI
    - [Qihoo360/wayne](https://github.com/Qihoo360/wayne):Web UI for Kubernetes multi-clusters
*  Chaos
    -  [ChaosBlade](https://github.com/chaosblade-io/chaosblade):
* [openshift/origin](https://github.com/openshift/origin):Enterprise Kubernetes for Developers http://www.openshift.org
* [kubernetes/kops](https://github.com/kubernetes/kops):Kubernetes Operations (kops) - Production Grade K8s Installation, Upgrades, and Management
* [datawire/telepresence](https://github.com/datawire/telepresence):Local development against a remote Kubernetes or OpenShift cluster http://www.telepresence.io
* [runconduit/conduit](https://github.com/runconduit/conduit):Ultralight service mesh for Kubernetes https://conduit.io
* [kubernetes-sigs/kustomize](https://github.com/kubernetes-sigs/kustomize):Customization of kubernetes YAML configurations
* [weaveworks/flux](https://github.com/weaveworks/flux):The GitOps Kubernetes operator
* [kubernetes-client/javascript](https://github.com/kubernetes-client/javascript):Javascript client
* [coreos/flannel](https://github.com/coreos/flannel):flannel is a network fabric for containers, designed for Kubernetes
* [argoproj/argo](https://github.com/argoproj/argo):Container-native workflows for Kubernetes. https://argoproj.github.io
* [datawire/ambassador](https://github.com/datawire/ambassador):open source Kubernetes-native API gateway for microservices built on the Envoy Proxy https://www.getambassador.ios
* [helm/charts](https://github.com/helm/charts):Curated applications for Kubernetes
* [virtual-kubelet/virtual-kubelet](https://github.com/virtual-kubelet/virtual-kubelet):Virtual Kubelet is an open source Kubernetes kubelet implementation.
* [operator-framework/operator-sdk](https://github.com/operator-framework/operator-sdk):SDK for building Kubernetes applications. Provides high level APIs, useful abstractions, and project scaffolding. https://coreos.com/operators
* [kubeflow/kubeflow](https://github.com/kubeflow/kubeflow):Machine Learning Toolkit for Kubernetes
* [kubernetes/dashboard](https://github.com/kubernetes/dashboard):General-purpose web UI for Kubernetes clusters
* [genuinetools/binctr](https://github.com/genuinetools/binctr):Fully static, unprivileged, self-contained, containers as executable binaries. https://blog.jessfraz.com/post/getting-towards-real-sandbox-containers/
* [kubernetes/kompose](https://github.com/kubernetes/kompose):Go from Docker Compose to Kubernetes http://kompose.io
* [kubeless/kubeless](https://github.com/kubeless/kubeless):Kubernetes Native Serverless Framework https://kubeless.io
* [windmilleng/tilt](https://github.com/windmilleng/tilt):Local Kubernetes development with no stress https://tilt.build/
* [jetstack/cert-manager](https://github.com/jetstack/cert-manager):Automatically provision and manage TLS certificates in Kubernetes https://jetstack.io
* [appscode/voyager](https://github.com/appscode/voyager):🚀 Secure HAProxy Ingress Controller for Kubernetes https://appscode.com/products/voyager
* [openshift/origin](https://github.com/openshift/origin):The self-managing, auto-upgrading, Kubernetes distribution for everyone http://www.openshift.org
* [OpenKruise](https://github.com/openkruise/kruise):从不同维度解决 Kubernetes 之上应用的自动化问题，包括部署，升级，弹性扩缩容，Qos 调节，健康检查，迁移修复等
* [AHAS](https://www.aliyun.com/product/ahas): 为 K8s 等容器环境提供了架构可视化的功能，同时，具有故障注入式高可用能力评测和一键流控降级等功能，可以快速低成本的提升应用可用性

## 参考

* [Tutorials](https://kubernetes.io/docs/tutorials/)
* [Kubernetes 中文社区](https://www.kubernetes.org.cn)
* [容器编排和部署](https://developer.ibm.com/cn/solutions/container-orchestration-and-deployment/)
* [hobby-kube/guide](https://github.com/hobby-kube/guide):Kubernetes clusters for the hobbyist
* [kelseyhightower/kubernetes-the-hard-way](https://github.com/kelseyhightower/kubernetes-the-hard-way):Bootstrap Kubernetes the hard way on Google Cloud Platform. No scripts.
* [feiskyer/kubernetes-handbook](https://github.com/feiskyer/kubernetes-handbook):Kubernetes Handbook （Kubernetes指南） https://kubernetes.feisky.xyzs
* [rootsongjc/kubernetes-handbook](https://github.com/rootsongjc/kubernetes-handbook):Kubernetes中文指南/云原生应用架构实践手册 - https://jimmysong.io/kubernetes-handbook
* [opsnull/follow-me-install-kubernetes-cluster](https://github.com/opsnull/follow-me-install-kubernetes-cluster):和我一步步部署 kubernetes 集群
* [jamiehannaford/what-happens-when-k8s](https://github.com/jamiehannaford/what-happens-when-k8s):🤔 What happens when I type kubectl run?
* [ramitsurana/awesome-kubernetes](https://github.com/ramitsurana/awesome-kubernetes):A curated list for awesome kubernetes sources 🚢🎉 https://ramitsurana.github.io/awesome-kubernetes/
* [gjmzj/kubeasz](https://github.com/gjmzj/kubeasz):使用Ansible脚本安装K8S集群，介绍组件交互原理，方便直接，不受国内网络环境影响 https://github.com/gjmzj/kubeasz
* [kubernetes/community](https://github.com/kubernetes/community):Kubernetes community content
* [hjacobs/kubernetes-failure-stories](https://github.com/hjacobs/kubernetes-failure-stories):Compilation of public failure/horror stories related to Kubernetes https://k8s.af
* [手动一步步搭建k8s(Kubernetes)高可用集群](https://www.centos.bz/2017/07/k8s-kubernetes-ha-cluster/)
* [开源容器集群管理系统Kubernetes架构及组件介绍](https://yq.aliyun.com/articles/47308)
* [Kubernetes总架构图](http://blog.csdn.net/huwh_/article/details/71308171)
* [Kubernetes核心原理（一）之API Server](http://blog.csdn.net/huwh_/article/details/75675706)
* [Kubernetes核心原理（二）之Controller Manager](http://blog.csdn.net/huwh_/article/details/75675761)
* [Kubernetes核心原理（三）之Scheduler](http://blog.csdn.net/huwh_/article/details/77017353)
* [Kubernetes核心原理（四）之Kubelet](http://blog.csdn.net/huwh_/article/details/77922293)

<http://violetgo.com/blogs/>
<http://www.winseliu.com/>
<http://blog.csdn.net/qq1010885678/article/details/48832067>
[网易云原生架构实践w之服务治理](https://mp.weixin.qq.com/s/ixkFLfbr3kY8AF_3x-KfSA)
https://www.centos.bz/2017/07/kubernetes-pod-schedule-intro/
