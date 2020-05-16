# [kubernetes/kubernetes](https://github.com/kubernetes/kubernetes)

Production-Grade Container Scheduling and Management http://kubernetes.io

* 作为Docker生态圈中重要一员，是Google多年大规模容器管理技术的开源版本，是产线实践经验的最佳表现。如Urs Hölzle所说，无论是公有云还是私有云甚至混合云，Kubernetes将作为一个为任何应用，任何环境的容器管理框架无处不在
* 自动化编排容器应用的开源平台，包括部署、调度和节点集群间扩展、服务发现和配置服务等架构支持的基础能力
* 服务治理范围覆盖了服务的整个生命周期，从服务建模开始，到开发、测试、审批、发布、运行时管理，以及最后的下线。通常说的服务治理主要是指服务运行时的治理，一个好的服务治理框架要遵循"在线治理，实时生效"原则，只有这样才能真正保障服务整体质量
    - 服务越来越多，配置项越来越多，利用统一注册中心解决服务发现和配置管P理问题
    - 服务之间存在多级依赖，靠人工已经无法理清，还要避免潜在的循环依赖问题，需要依赖管理机制，支持导出依赖关系图
    - 服务的性能数据和健康状态数据是服务治理的重要依据，比如访问量、响应时间、并发数等，因此需要有监控、健康检查和统计服务
    - 当一个服务的访问量越来越大，需要对服务进行扩容，然后在客户端进行流量引导和优先级调度
    - 面对突发流量，已经无法通过扩容解决问题时，要启用流量控制，甚至服务降级
    - 随着业务持续发展，要提前进行容量规划，结合服务监控数据，以确认当前系统容量能否支撑更高水位的压力
    - 通过一系列的服务治理策略，最终通过数据证明系统对外承诺的 SLA
* 使用Golang开发，其提供应用部署、维护、扩展机制等功能，利用Kubernetes能方便地管理跨机器运行容器化的应用，主要功能如下：
    - 使用Docker对应用程序包装(package)、实例化(instantiate)、运行(run)
    - 以集群的方式运行、管理跨机器的容器
    - 解决Docker跨机器容器之间的通讯问题
    - 服务发现和负载均衡：使用 DNS 名称或自己的 IP 地址公开容器，如果到容器的流量很大，Kubernetes 可以负载均衡并分配网络流量，从而使部署稳定
    - 存储编排：允许自动挂载选择的存储系统，例如本地存储、公共云提供商等
    - 自动部署和回滚：可以使用 Kubernetes 描述已部署容器的所需状态，可以以受控的速率将实际状态更改为所需状态。例如，可以自动化 Kubernetes 来为您的部署创建新容器，删除现有容器并将它们的所有资源用于新容器
    - 容器资源配额：允许指定每个容器所需 CPU 和内存（RAM）。当容器指定了资源请求时，Kubernetes 可以做出更好的决策来管理容器的资源
    - 自我修复：重新启动失败的容器、替换容器、杀死不响应用户定义的运行状况检查的容器，并且在准备好服务之前不将其通告给客户端
    - 密钥与配置管理：存储和管理敏感信息，例如密码、OAuth 令牌和 ssh 密钥。可以在不重建容器镜像的情况下部署和更新密钥和应用程序配置，也无需在堆栈配置中暴露密钥
    - 配置文件：可以通过 ConfigMap 来存储配置
* 方便
    - 快速部署应用
    - 容易实现 水平伸缩 或 垂直伸缩
    - 无缝发布新应用版本
    - 资源使用最大化
    - 应用停止自动重启
* 特点
    - 可移植：支持公有云(GCE、vShpere、CoreOS、OpenShift、Azure)、私有云、混合云、多重云（multi-cloud）
    - 可扩展：模块化、插件化、可挂载、可组合
    - 自动化：自动部署、自动重启、自动复制、自动伸缩/扩展
* K8s很多的抽象概念非常契合分布式调度系统，可以做到描述集群架构，定义服务状态，并维持，实现了分布式集群的配置管理和维护包括动态伸缩及故障迁移

* 基于负载均衡的应用弹性伸缩方案，只要将应用系统设计成无状态，在需要伸缩的时候修改负载均衡代理配置，就可以方便地水平扩容应用系统，提高系统承载能力

## 架构

* 一切皆为资源，一切即可描述，一切皆可管理
* Master节点组件:提供集群的管理控制中心，通常在一台VM/机器上启动所有Master组件，并且不会在此VM/机器上运行用户容器  kubecfg、Minion(Host)以及Proxy
    - 定义了Kubernetes 集群Master/API Server的主要声明  RESTStorage以及Client
    - client(Kubecfg)调用Kubernetes API，管理Kubernetes主要构件Pods、Services、Minions、容器的入口
    - Etcd
        + 用来存储所有Kubernetes集群状态
        + 事件监听和订阅：其他组件各个通信并不是互相调用API来完成的，而是把状态写入Etcd（相当于写入一个消息），其他组件通过监听Etcd的状态的的变化（相当于订阅消息），然后做后续的处理，然后再一次把更新的数据写入Etcd
        + Leader选举：其它一些组件比如 Scheduler，为了做实现高可用，通过Etcd从多个（通常是3个）实例里面选举出来一个做Master，其他都是Standby
    - API Server: 所有组件之间通信都需要通过Etcd。组件并不是直接访问Etcd，而是访问 API Server 这个代理，通过标准的RESTFul API（重新封装了对Etcd接口调用），除此之外，这个代理还实现了一些附加功能，比如身份的认证、缓存等
        + 根据请求的类型，比如创建Pod时storage类型是pods，然后依此选择何种 REST Storage API 对请求作出处理
        + 提供了k8s各类资源对象（pod,RC,Service等）的增删改查及watch等HTTP Rest接口，是整个系统的数据总线和数据中心
        + 只有API Server与存储通信，其他模块通过API Server访问集群状态
        + 为了隔离集群状态访问的方式和后端存储实现的方式：API Server是状态访问的方式，不会因为后端存储技术etcd的改变而改变
        + 作为kubernetes系统的入口，封装了核心对象的增删改查操作，以RESTFul接口方式提供给外部客户和内部组件调用。对相关的资源数据"全量查询"+"变化监听"，实时完成相关的业务功能
            * 提供了集群管理的REST API接口(包括认证授权、数据校验以及集群状态变更)
            * 提供其他模块之间的数据交互和通信的枢纽（其他模块通过API Server查询或修改数据，只有API Server才直接操作etcd）
            * 是资源配额控制的入口
            * 拥有完备的集群安全机制
    - Controller manager: 负责任务调度，简单说直接请求Kubernetes做调度的都是任务，例如Deployment 、DeamonSet、Pod等等
        + 每一个任务请求发送给Kubernetes之后，都是由Controller Manager来处理的，每一种任务类型对应一个Controller Manager，比如Deployment对应一个叫做Deployment Controller，DaemonSet对应一个DaemonSet Controller
        + 实现集群故障检测和恢复的自动化工作，负责执行各种控制器，主要有： endpoint-controller：定期关联service和pod(关联信息由endpoint对象维护)，保证service到pod的映射总是最新的
    - replication-controller：定期关联replicationController和pod，保证replicationController定义的复制数量与实际运行pod的数量总是一致的
    - Scheduler: 负责资源调度
        + Controller Manager 会把Pod对资源要求写入到Etcd里面，Scheduler监听到有新的Pod需要调度，就会根据整个集群的状态，把Pod分配到具体的worker节点上
        + 由于一旦Minion节点的资源被分配给Pod，那这些资源就不能再分配给其他Pod， 除非这些Pod被删除或者退出， 因此，Kubernetes需要分析集群中所有Minion的资源使用情况，保证分发的工作负载不会超出当前该Minion节点的可用资源范围
        + 收集和分析当前Kubernetes集群中所有Minion节点的资源(内存、CPU)负载情况，然后依此分发新建的Pod到Kubernetes集群中可用的节点
        + 实时监测Kubernetes集群中所有运行的Pod，Scheduler需要根据这些Pod的资源状况安全地将未分发的Pod分发到指定的Minion节点上
        + 实时监测Kubernetes集群中未分发和已分发的所有运行的Pod
        + 监测Minion节点信息，由于会频繁查找Minion节点，Scheduler会缓存一份最新的信息在本地
        + 在分发Pod到指定的Minion节点后，会把Pod相关的信息Binding写回API Server
        + 在API Server响应Kubecfg的请求后，Scheduler会根据Kubernetes Client获取集群中运行Pod及Minion信息
        + 依据从Kubernetes Client获取的信息，Scheduler将未分发的Pod分发到可用的Minion节点上
    - Kubectl: 一个命令行工具，调用 API Server 发送请求写入状态到Etcd，或者查询Etcd状态
    - Minion Registry 负责跟踪Kubernetes 集群中有多少Minion(Host)。Kubernetes封装Minion Registry成实现Kubernetes API Server的RESTful API接口REST，通过这些API，我们可以对Minion Registry做Create、Get、List、Delete操作，由于Minon只能被创建或删除，所以不支持Update操作，并把Minion的相关配置信息存储到etcd。除此之外，Scheduler算法根据Minion的资源容量来确定是否将新建Pod分发到该Minion节点。可以通过`curl http://{master-apiserver-ip}:4001/v2/keys/registry/minions/`来验证etcd中存储的内容。
    - Pod Registry 负责跟踪Kubernetes集群中有多少Pod在运行，以及这些Pod跟Minion是如何的映射关系。将Pod Registry和Cloud Provider信息及其他相关信息封装成实现Kubernetes API Server的RESTful API接口REST。通过这些API，我们可以对Pod进行Create、Get、List、Update、Delete操作，并将Pod的信息存储到etcd中，而且可以通过Watch接口监视Pod的变化情况，比如一个Pod被新建、删除或者更新。
    - Service Registry 负责跟踪Kubernetes集群中运行的所有服务。根据提供的Cloud Provider及Minion Registry信息把Service Registry封装成实现Kubernetes API Server需要的RESTful API接口REST。利用这些接口，我们可以对Service进行Create、Get、List、Update、Delete操作，以及监视Service变化情况的watch操作，并把Service信息存储到etcd。
    - Controller Registry 负责跟踪Kubernetes集群中所有的Replication Controller，Replication Controller维护着指定数量的pod 副本(replicas)拷贝，如果其中的一个容器死掉，Replication Controller会自动启动一个新的容器，如果死掉的容器恢复，其会杀死多出的容器以保证指定的拷贝不变。通过封装Controller Registry为实现Kubernetes API Server的RESTful API接口REST， 利用这些接口，我们可以对Replication Controller进行Create、Get、List、Update、Delete操作，以及监视Replication Controller变化情况的watch操作，并把Replication Controller信息存储到etcd。
    - Endpoints Registry 负责收集Service的endpoint，比如Name："mysql"，Endpoints: ["10.10.1.1:1909"，"10.10.2.2:8834"]，同Pod Registry，Controller Registry也实现了Kubernetes API Server的RESTful API接口，可以做Create、Get、List、Update、Delete以及watch操作。
    - Binding Registry 包括一个需要绑定Pod的ID和Pod被绑定的Host，Scheduler写Binding Registry后，需绑定的Pod被绑定到一个host。也实现了Kubernetes API Server的RESTful API接口，但Binding Registry是一个write-only对象，所有只有Create操作可以使用， 否则会引起错误。

        + Kubecfg将特定的请求，比如创建Pod，发送给Kubernetes Client
        + Kubernetes Client将请求发送给API server

* worker节点组件：运行在每个k8s Node上，提供K8s运行时环境，以及管理Pod和容器的生命周期
    - [Kubelet](https://github.com/kubernetes/kubelet): 运行在每一个worker节点上的Agent，监听Etcd中的Pod信息，运行分配给它所在节点的Pod，并把状态更新回Etcd。通过docker部署
        + Kubelet是集群中每个Minion和Master API Server的连接点，运行在每个Minion上，接收Master API Server分配给它的commands和work，与持久性键值存储etcd、file、server和http进行交互，读取配置信息
        + 包括Docker Client、Root Directory、Pod Workers、Etcd Client、Cadvisor Client以及Health Checker组件
        + 具体工作如下：
            * 通过Worker给Pod异步运行特定的Action
            * 设置容器的环境变量
            * 给容器绑定Volume
            * 给容器绑定Port
            * 根据指定的Pod运行一个单一容器
            * 杀死容器
            * 给指定的Pod创建network 容器
            * 删除Pod的所有容器
            * 同步Pod的状态
            * 从cAdvisor获取container info、 pod info、 root info、 machine info
            * 检测Pod的容器健康状态信息
            * 在容器中运行命令
    - Kube-proxy: 负责为Service提供cluster内部的服务发现和负载均衡。通过k8s部署。为了解决外部网络能够访问跨机器集群中容器提供的应用服务而设计的，运行在每个Minion上
        + Proxy提供TCP/UDP sockets的proxy，每创建一种Service，Proxy主要从etcd获取Services和Endpoints的配置信息（也可以从file获取），然后根据配置信息在Minion上启动一个Proxy的进程并监听相应的服务端口，当外部请求发生时，Proxy会根据Load Balancer将请求分发到后端正确的容器处理
        + 解决了同一主宿机相同服务端口冲突的问题
        + 提供了Service转发服务端口对外提供服务的能力，Proxy后端使用了随机、轮循负载均衡算法 [kube-proxy 的内容 KUBERNETES代码走读之MINION NODE 组件 KUBE-PROXY](http://www.sel.zju.edu.cn/?spm=5176.100239.blogcont47308.8.2bn7P0&p=484)
    - Docker: Docker引擎，负责容器运行
    - Container: 负责镜像管理以及Pod和容器的真正运行（CRI）
* 实践
    - 创建一个nginx_deployment.yaml配置文件
    - 通过kubectl命令行创建一个包含Nginx的Deployment对象，kubectl会调用API Server往Etcd里面写入一个Deployment对象。
    - Deployment Controller监听到有新的Deployment对象被写入，获取到Deployment对象信息然后根据对象信息来做任务调度，创建对应的Replica Set对象。
    - Replica Set Controller监听到有新的对象被创建，获取到Replica Set对象信息然后根据对象信息来做任务调度，创建对应的Pod对象。
    - Scheduler监听到有新的Pod被创建，获取到Pod对象信息，根据集群状态将Pod调度到某一个worker节点上，然后更新Pod。
    - Kubelet监听到当前的节点被指定了的Pod，就根据对象信息运行Pod。

![架构](../_static/kubernates_architect.png)
![](../_static/constructor.png)
![kubelet](../_static/kubelet.png)
![Master](../_static/master.png)

## 核心概念

* Cluster 集群：由K8s使用一序列的物理机、虚拟机和其它基础资源来运行你的应用程序
* NameSpaces 命名空间：在集群中可以使用namespace创建多个“虚拟集群”，namespace之间可以完全隔离，也可以通过某种方式，让一个namespace中的service可以访问到其他的namespace中的服务
    - 一组资源和对象的抽象集合，比如可以用来将系统内部的对象划分为不同的项目组或用户组
    - 常见的Pods，Services，Replication Controllers和Deployments等都属于某一个Namespace，默认是default。而Node，PresistentVolumes等则不属于任何Namespace
    - Namespace常用于隔离不同的用户，比如K8s自带的服务一般运行在Kube-system Namespace中
    - 操作
        + 查询namespace `kubectl get namespaces` namespace包含两种状态Active和Terminating，删除namespace的过程中namespace状态被设置为Terminating
        + 创建namespace `kubectl create namespace new-namespace` namespace名称满足正则表达式[a-z0-9]([-a-z0-9]*[a-z0-9])?,最大长度为63位
        + 删除namespace `kubectl delete namespaces new-namespace`
            * 删除一个namespace会自动删除所有属于该namespace的资源
            * default和kube-system命名空间不可删除
* Deployment 为 Pod 和 ReplicaSet 提供了一个声明式定义(declarative)方法，用来替代以前的 ReplicationController 来方便的管理应用，应用场景
    - 定义Deployment来创建Pod和ReplicaSet
    - 滚动升级和回滚应用
    - 扩容和缩容
    - 暂停和继续Deployment
    - 状态
        + 无效的引用
        + 不可读的probe failure
        + 镜像拉取错误
        + 权限不够
        + 范围限制
        + 程序运行时配置错误
        + Deployment可用的Replica个数等于或者超过Deployment策略中期望的个数
        + 所有与该Deployment相关的Replica都更新完成
        + Deployment正在创建新的ReplicaSet
        + Deployment正在扩容一个已有的ReplicaSet
        + Deployment正在缩容一个已有的ReplicaSet
        + Progressing: 进行中
        + Complete: 完成
        + Failed: 失败
    - 使用
        + 查询: `kubectl get deployments -o wide`
        + 扩容: `kubectl scale deployment nginx-deployment –replicas 10`
        + 更新镜像: `kubectl set image deployment/nginx-deployment nginx=nginx:1.9.1`
        + 回滚: `kubectl rollout undo deployment/nginx-deployment`
* Service
    - 一个抽象的概念，定义了Pod的逻辑分组和一种可以访问它们的策略，这组Pod能被Service访问，使用YAML（优先）或JSON 来定义Service，Service所针对的一组Pod通常由LabelSelector实现
    - 一个抽象层，定义了一组逻辑的Pods，这些Pod提供了相同的功能，借助Service，应用可以方便的实现服务发现与负载均衡，可以把Service加上一组Pod称作是一个微服务
    - 默认情况Pod只能通过K8s集群内部IP访问，要使Pod允许从K8s虚拟网络外部访问，须要使用K8s Service暴露Pod
    - 创建一个Service的时候每个Service被分配一个唯一的IP地址，这个IP地址与一个Service的生命周期绑定在一起，当Service存在的时候它不会改变
        + 可以指定IP地址，将spec.clusterIP的值设置为想要的IP地址即可
    - 基本操作单元，是真实应用服务的抽象，每一个服务后面都有很多对应的容器来支持，通过Proxy的port和服务selector决定服务请求传递给后端提供服务的容器，对外表现为一个单一访问地址，外部不需要了解后端如何运行，给扩展或维护后端带来很大的好处
    - 每个节点都运行了一个kube-proxy，kube-proxy监控着K8s增加和删除Service，对于每个Service kube-proxy会随机开启一个本机端口，任何向这个端口的请求都会被转发到一个后台的Pod中，如何选择哪一个后台Pod是基于SessionAffnity进行的分配
    - 服务发现
        + 当一个Pod在一个Node上运行的时候，Kubelet会针对运行的Service增加一序列的环境变量，支持Docker links compatible和普通环境变量
        + 环境变量：所有想要被Pod访问的Service都需要在Pod创建之前创建，否则这个环境变量是没有的
        + DNS：云平台插件，DNS服务器监控着API Server，当有Service被创建的时候，DNS服务器会为之创建相应的记录
    - 假定有2个后台Pod，并且定义后台Service的名称为‘backend-service’，lable选择器为（tier=backend, app=myapp）。backend-service 的Service会完成如下两件重要的事情：
        + 会为Service创建一个本地集群的DNS入口，因此前端Pod只需要DNS查找主机名为 ‘backend-service’，就能够解析出前端应用程序可用的IP地址。
        + 现在前端已经得到了后台服务的IP地址，但是它应该访问2个后台Pod的哪一个呢？Service在这2个后台Pod之间提供透明的负载均衡，会将请求分发给其中的任意一个（如下面的动画所示）。通过每个Node上运行的代理（kube-proxy）完成
* Ingress ：从集群外部访问集群内部服务的入口。比如官方维护的 Ingress Nginx。ingress traefik、ingress haproxy等
* Node（节点）
    - K8s中的工作节点，可以是虚拟机或物理机。每个Node由K8s Master管理，Node上可以有多个Pod，K8s Master会自动处理Node的Pod调度，同时Master的自动调度会考虑每个Node上的可用资源，为了管理Pod，每个Node上至少要运行Docker、kubelet和kube-proxy
    - Node管理
        + 维护Node状态
        + 与Cloud Provider同步Node
        + 给Node分配容器CIDR
        + 删除带有NoExecute taint的Node上的Pods
        + Node本质不是由K8s来创建的，K8s只是管理Node上的资源，默认情况下kubelet在启动的时候会向master注册自己，并创建Node资源
        + Node Controller
    - Node状态信息
        + 基本信息: 包括内核版本、容器引擎版本、OS类型
        + 地址：包括hostname、内网IP和外网IP 或者Node ID
        + 运行状态
            * Pending
            * Running
            * Terminated
        + Condition（条件）：描述Running状态Node的运行条件
            * OutOfDisk
            * MemoryPressure
            * DiskPressure
            * Ready表示Node处于健康状态，可以接收从Master发来的创建Pod的指令
        + 容量：Node可用系统资源，包括CPU、内存数量、最大可调度Pod数量等
    - 管理：Node通常是物理机、虚拟机或者云服务商提供的资源，并不是由Kubernetes创建的。Kubernetes创建一个Node，仅仅表示Kubernetes在系统内部创建了一个Node对象
        + 创建后即会对其进行一系列健康检查，包括是否可以连通、服务是否正确启动、是否可以创建Pod等。如果检查未能通过，则该Node将会在集群中被标记为不可用（Not Ready）
        + Node Controller是Kubernetes Master中的一个组件，用于管理Node对象。两个主要功能包括
            * 集群范围内的Node信息同步，可以通过kube-controller-manager的启动参数--node-sync-period设置同步的时间周期
            * 单个Node的生命周期管理
    - 自注册:当Kubelet的--register-node参数被设置为true（默认值即为true）时，Kubelet会向apiserver注册自己。这也是Kubernetes推荐的Node管理方式。 Kubelet进行自注册的启动参数如下：
        + --apiservers=: apiserver地址；
        + --kubeconfig=: 登录apiserver所需凭据/证书的目录；
        + --cloud_provider=: 云服务商地址，用于获取自身的metadata；
        + --register-node=: 设置为true表示自动注册到apiserver。
    - 手动管理Node:将Kubelet启动参数中的--register-node参数的值设置为false
* Pod:创建和部署最小也是最简的单位，代表着集群中运行的进程，封装着应用的容器，存储、独立的网络IP，管理容器如何运行的策略选项
    - 调度最小颗粒不是容器，而是Pod
    - 一个可以被创建、销毁、调度、管理的最小的部署单元,一个Pod对应一个由相关容器和卷组成的容器组,通常Pod里的容器运行相同的应用
    - 运行在同一个Minion(Host)上，看作一个统一管理单元
    - 本身不具备自愈能力，一般情况下使用Deployment、ReplicaSet、Replication Controller等来创建和管理Pod，保证有足够的Pod副本在运行
    - 重启Pod中的容器和重启Pod不是一回事，Pod只提供容器的运行环境并保持容器的运行状态，重启容器不会造成Pod重启
    - Pod是一种相对短暂的存在，而不是持久存在的。每个Pod将被绑定调度到Node节点上，当一个Node节点销毁或挂掉之后，上面的所有Pod都会被删除
    - 运行方式
        + 运行一个容器:这是K8s中最常见的用法。可以将Pod视为单个封装的容器，只是K8s是直接管理Pod而不是容器
        + 运行多个容器:多个容器共享Pod资源。这些容器可以形成单一的内部Service
    - 共享资源
        + 网络: 每个Pod被分配一个独立的IP地址，Pod中的每个容器共享网络命名空间，包括IP地址和网络端口
            * Pod内的容器可以使用localhost相互通信
            * 与Pod外部通信时，必须协调如何使用共享网络资源
        + 存储: Pod可以指定一组共享存储Volumes，Pod中的所有容器都可以访问共享Volumes允许这些容器共享数据。Volumes还用于Pod中的数据持久化，以防其中一个容器需要重新启动而丢失数据
    - 状态
        + Pending: 挂起, Pod已经被K8s系统接受，但有一个或者多个容器镜像尚未创建，等待时间包括下载镜像时间和Pod调度时间
        + Running: 运行中，该Pod已经绑定到一个Node上，Pod中所有容器都已被创建，至少有一个容器正在运行，或者正处于启动或重启状态
        + Succeed: 成功，Pod中所有容器都被成功结束，并且不会再重启
        + Failed: 失败，Pod中所有容器都终止了，并且至少有一个容器因为失败而终止
        + Unknown: 未知，因为某些原因无法取得Pod的状态，通常是因为Pod与所在Node通信失败
    - 创建
        + 因为Pod不会自愈，如果Node节点有故障这个Pod就会被删除，或者Node节点缺少资源情况下Pod也会被删除
        + 建议采用相关Controller来创建Pod而不是直接创建Pod，因为单独的Pod没有办法自愈，而Controller却可以，可用的Controller
            * Job: 使用Job运行预期会结束的Pod，例如批量计算，Job仅适用于重启策略为OnFailure或Never的Pod。
            * Deployment、ReplicaSet、Replication Controller: 预期不会终止的Pod使用这3个Controller来创建，Replication Controller仅适用于具有restartPolicy为Always的Pod。
            * DaemonSet: 提供特定于机器的系统服务，DaemonSet为每台机器运行一个Pod
    - Pod容器重启：Pod YAML配置文件Spec中有一个restartPolicy字段，适用于Pod中的所有容器，restartPolicy仅指通过同一节点上的kubelet重新启动容器。
        + Always（默认）：失败的容器由kubelet以五分钟为上限的指数退避延迟（10秒，20秒，40秒…）重新启动，并在成功执行十分钟后重置
        + OnFailure
        + Never
* ConfigMap API 资源用来保存 key-value pair配置数据，这个数据可以在pods里使用，或者被用来为像controller一样的系统组件存储配置数据。虽然 ConfigMap 跟 Secrets 类似，但是ConfigMap更方便的处理不含敏感信息的字符串。注意：ConfigMaps不是属性配置文件的替代品。ConfigMaps只是作为多个properties文件的引用。你可以把它理解为Linux系统中的/etc目录，专门用来存储配置文件的目录。
* Secret 存储了敏感数据,解决了密码、token、密钥等敏感数据的配置问题，而不需要把这些敏感数据暴露到镜像或者Pod Spec中。Secret 可以以Volume或者环境变量的方式使用。 Secret有三种类型：
    - Service Account ：用来访问Kubernetes API，由Kubernetes自动创建，并且会自动挂载到Pod的/run/secrets/kubernetes.io/serviceaccount目录中
    - Opaque ：base64编码格式的Secret，用来存储密码、密钥等
    - kubernetes.io/dockerconfigjson ：用来存储私有docker registry的认证信息
* PV 和 PVC 用于数据持续存储，Pod中，容器销毁，所有数据都会被销毁，如果需要保留数据，这里就需要用到 PV存储卷，PVC存储卷申明
    - PVC 常用于 Deployment 做数据持久存储。实现持久化存储还需要理解 Volume 概念
* Volume
    - 构建在Docker Volumes之上，并且支持添加和配置Volume目录或者其他存储设备
    - 问题
        + 容器磁盘上的文件的生命周期是短暂的，容器崩溃时，kubelet 会重启，但是容器中文件将丢失——容器以干净的状态（镜像最初的状态）重新启动
        + 在 Pod 中同时运行多个容器时，这些容器之间通常需要共享文件
    - 特点
        + 一个Volume拥有明确的生命周期，与所在的Pod的生命周期相同，因此Volume的生命周期比Pod中运行的任何容器都要持久
        + Volume与Pod相关和容器无关，因此容器重启的时候数据还会保留，如果Pod被删除那么数据也会被删除
        + 内部实现中一个Volume就是一个目录，可能包含一些数据，这些数据对Pod中的容器都是可用的
        + 想要使用一个Volume，Pod必须指明Pod提供了哪些磁盘，并且说明如何挂载到容器中
    - 支持类型
       + emptyDir: 使用emptyDir，当Pod分配到Node上时将会创建emptyDir，并且只要Node上的Pod一直运行，Volume就会一直存在。当Pod从Node上被删除时，emptyDir也同时会删除，存储的数据也将永久删除，删除容器不影响emptyDir。
       + hostPath: hostPath允许挂载Node上的文件系统到Pod里面去。如果Pod需要使用Node上的文件，可以使用hostPath。
       + gcePersistentDisk
       + awsElasticBlockStore
       + nfs
       + iscsi
       + fc (fibre channel)
       + flocker
       + glusterfs
       + rbd
       + cephfs
       + gitRepo
       + secret
       + persistentVolumeClaim
       + downwardAPI
       + projected
       + azureFileVolume
       + azureDisk
       + vsphereVolume
       + Quobyte
       + PortworxVolume
       + ScaleIO
       + StorageOS
       + ilocal
* Label 标签
    - 一对key/value被关联到对象上比如Pod，标签的使用倾向于能够标识对象的特点，并且对用户而言是有意义的，但对内核系统是没有直接意义
    - 可以用来划分特定组的对象，标签可以在创建一个对象的时候直接给与 也可以在后期随时修改，每一个对象可以拥有多个标签，但是key值必须是唯一的
    - service和replicationController只是建立在pod之上的抽象,通过label来与pod关联
    - 可以被应用来组织和选择子网中的资源
    - 语法和字符集
        + label是一对key/value，有效的key=一个可选的前缀 + 名称组成，通过/来区分
        + 名称部分是必须的，最多63个字符，开始和结束的字符必须是字母或者数字，中间是字母或数字以及特殊的字符_,-,.，前缀是可有可无
        + 如果指定了前缀，必须是一个DNS子域，一序列的DNS label通过.来划分，长度不超过253个字符，/结尾
        + label的值必须小于或等于63个字符，允许为空。如果值不为空，那么首位字符必须为字母数字，中间必须是数字字母以及特殊字符-,_,.
    - Label Selector：通过匹配labels来定义资源之间关系的表达式，各个控制器通过 Selector 匹配容器并管理。比如 Deployment 或 Service 都是通过这种方式匹配相应的 Pod
        + 基于set的条件：in, notin 和 exists(仅针对key)
            * environment in (production, qa) (选择environment等于production或者qa的资源)
            * tier notin (frontend, backend) (选择tier不等于frontend和backend的资源)
            * partition (选择key为partition的资源，不care value是什么)
        - 基于运算符：=,==和!=，=和==是同一种意思
            * !partition (选择key不是partition的资源，不care value是什么)
            * environment = production （选择environment等于production的资源)
            * tier != frontend (选择tier不等于frontend的资源)
* Replication Controllers:确保任何时候集群中有指定数量的pod副本(replicas)在运行，如果少于指定数量的pod副本(replicas)，Replication Controller会启动新的Container，反之会杀死多余的以保证数量不变
    - 使用预先定义的pod模板创建pods，一旦创建成功，pod 模板和创建的pods没有任何关联，可以修改 pod 模板而不会对已创建pods有任何影响，也可以直接更新通过Replication Controller创建的pods
    - 为了保证Pod一定数量的复制品在任何时间都能正常工作，不仅允许复制的系统易于扩展，还会处理当Pod在机器重启或发生故障的时候再创建一个
    - Replication Controller使用labels来管理通过 pod 模板创建的一组容器可以更加容易，方便地管理多个容器
    - 创建Replication Controller时，需要指定两个东西：
        + Pod模板：用来创建Pod副本的模板
        + Label：Replication Controller需要监控的Pod的标签
    - 对于利用 pod 模板创建的pods，Replication Controller根据 label selector 来关联，通过修改pods的label可以删除对应的pods
    - 用法：
        + Rescheduling:保证足够数量的Pod运行，即使节点Node失败或者挂掉的情况
        + Scaling:通过修改Replication Controller的副本(replicas)数量来水平扩展或者缩小运行的pods
        + Rolling updates:可以一个一个地替换pods来滚动更新（rolling updates）服务
        + Multiple release tracks:如果需要在系统中运行multiple release的服务，Replication Controller使用labels来区分multiple release tracks
    - 以上三个概念便是用户可操作的REST对象。Kubernetes以RESTfull API形式开放的接口来处理
* ReplicaSet (RS):下一代Replication Controller，ReplicaSet和Replication Controller唯一的区别是现在的选择器支持不同，官方推荐使用ReplicaSet
    - 大多数kubectl支持Replication Controller的命令也支持ReplicaSet
    - ReplicaSet主要是被Deployment做为协调Pod创建、删除和更新的机制，当使用Deployment时，你不必担心创建Pod的ReplicaSets，因为可以通过Deployment实现管理ReplicaSets
    - Deployment是一个更高层次的概念，管理ReplicaSet，并提供对pod的声明性更新以及许多其他的功能。因此，建议使用Deployment而不是直接使用ReplicaSet。这实际上意味着可能永远不需要操作ReplicaSet对象，而是直接使用Deployment并在规范部分定义应用程序
* 如下图所示，有三个pod都有label为"app=backend"，创建service和replicationController时可以指定同样的label:"app=backend"，再通过label selector机制，就将它们与这三个pod关联起来了。例如，当有其他frontend pod访问该service时，自动会转发到其中的一个backend pod

* Horizontal Pod Autoscaler （HPA）组件专门设计用于应用弹性扩容的控制器，通过定期轮询 Pod 的状态（CPU、内存、磁盘、网络，或者自定义的应用指标），当 Pod 的状态连续达到提前设置的阈值时，就会触发副本控制器，修改其应用副本数量，使得 Pod 的负载重新回归到正常范围之内

* annotate命令：更新一个或多个资源的Annotations信息。也就是注解信息，可以方便的查看做了哪些操作
    - 相对于label来说可以容纳更大的键值对，它对我们来说是不可读的数据，只是为了存储不可识别的辅助数据，尤其是一些被工具或系统扩展用来操作的数据
    - 由key/value组成
    - 目的是存储辅助数据，特别是通过工具和系统扩展操作的数据
    - --overwrite为true，现有的annotations可以被覆盖，否则试图覆盖annotations将会报错
    - --resource-version，则更新将使用此resource version，否则将使用原有的resource version

![](../_static/labels.png)

```yaml
# 创建一个Service
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: hostnames
spec:
  selector:
    app: hostnames
  replicas: 3
  template:
    metadata:
      labels:
        app: hostnames
    spec:
      containers:
      - name: hostnames
        image: k8s.gcr.io/serve_hostname
        ports:
        - containerPort: 9376
          protocol: TCP
```
```sh
# 环境变量
REDIS_MASTER_SERVICE_HOST=10.0.0.11
REDIS_MASTER_SERVICE_PORT=6379
REDIS_MASTER_PORT=tcp://10.0.0.11:6379
REDIS_MASTER_PORT_6379_TCP=tcp://10.0.0.11:6379
REDIS_MASTER_PORT_6379_TCP_PROTO=tcp
REDIS_MASTER_PORT_6379_TCP_PORT=6379
REDIS_MASTER_PORT_6379_TCP_ADDR=10.0.0.11

kubectl apply -f deployment.yaml

# 等效
kubectl run hostnames --image=k8s.gcr.io/serve_hostname \
--labels=app=hostnames \
--port=9376 \
--replicas=3

# 确认Pod是否都是Running状态
kubectl get pods -l app=hostnames

# 曝露 Service
kubectl expose deployment myservice --port=80 --target-port=9376

# 确认Service是否存在
kubectl get svc myservice

# 测试DNS是否能够解析myservice
kubectl run curl --image=radial/busyboxplus:curl -i —tty
nslookup myservice

kubectl get pods -l environment=production,tier=frontend
kubectl get pods -l ‘environment in (production),tier in (frontend)’
```


## 结构

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

### kubectl（kubelet client）集群管理命令行工具集

通过客户端的kubectl命令集操作，API Server响应对应的命令结果，从而达到对kubernetes集群的管理

* 前提
    - 禁用防火墙
    - 禁用swap分区
    - 禁用SELinux
    - sysctl net.bridge.bridge-nf-call-iptables=1
* 通过~/.kube/config文件完成其自身的配置，比如默认操作的cluster，context，namespace等
* Cluster表示一个k8s集群，最重要的配置是集群中API server的URL，另外通常需要通过certificate-authority-data配置CA证书。
* Users表示用户，先配置顶层用户，再将用户与cluster进行关联。user可以的认证信息可以配置username/password，authentication token或者client key等。
* Context用于将cluster与user进行关联，多个context可以指向相同的user或者cluster，另外，context需要配置在cluster下的默认namespace。
* Current context配置项用于指定当前操作的context，进而指定当前是由谁操作的是哪个cluster。
* ~/.kube/config文件中有4个顶级配置项：clusters，users，contexts和current-context，需要注意的是users并不位于clusters之下。cluster和user关联行程context。可以直接对该文件进行修改，也可以通过kubectl config命令进行修改。
* master机器也需要安装kubelet，因为master机器上的kubelet会根据/etc/kubernetes/manifests文件内容启动control plane的各个组件，比如api server，scheduler等。
* master上的/etc/kubernetes/admin.conf文件可以直接拷贝成~/.kube/config文件以供kubectl使用
* 可以在~/.kube目录下创建多个config文件，而不用将所有cluster都糅合在一起，然后通过KUBECONFIG环境变量指定kubectl使用的配置文件：`export KUBECONFIG=~/.kube/config2`
* 默认使用default的namespace，也可以在命令行中通过--namespace指定.永久地修改namespace，可以通过context，context位于kubectl的配置文件中，通常位于$HOME/.kube/config文件中，该文件中也包含向cluster认证的信息

```sh
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.17.0/bin/linux/amd64/kubectl # download a specific version
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

brew install kubectl

# ubuntu
sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
EOF

sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl

# install centos
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

yum install -y kubectl

swapoff -a

# 在 bash 中设置当前 shell 的自动补全，要先安装 bash-completion 包
source <(kubectl completion bash)
echo"source <(kubectl completion bash)" >> ~/.bashrc # 在您的 bash shell 中永久的添加自动补全

# 在 zsh 中设置当前 shell 的自动补全
source <(kubectl completion zsh)
echo"if [ $commands[kubectl] ]; then source <(kubectl completion zsh); fi" >> ~/.zshrc # 在您的 zsh shell 中永久的添加自动补全

kubectl version|cluster-info

kubectl config view
kubectl config set-context my-context --namespace=mystuff --users xxx --clusters xxx
kubectl config set-cluster my-other-cluster --server=https://k8s.example.com:6443 --certificate-authority=path/to/the/cafile # 创建cluster
kubectl config set-credentials foo --username=foo --password=pass # 创建用户
kubectl config set-context some-context --cluster=my-other-cluster --user=foo --namespace=bar # 创建context
kubectl config current-context # 获取current context
kubectl config set-context --current --namespace [new namespace] # 切换namespace
kubectl config use-context my-other-context # 切换current context
kubectl config set-context minikube --namespace=another-namespace # 为context更改默认的namespace
kubectl config get-clusters # 获取所有cluster
kubectl config get-contexts # 查看所有context
kubectl config use-context my-context # 使用

KUBECONFIG=~/.kube/config:~/.kube/kubconfig2 kubectl config view # 同时使用多个 kubeconfig 文件并查看合并的配置


kubectl config view -o jsonpath='{.users[?(@.name == "e2e")].user.password}' # 获取 e2e 用户的密码
kubectl config current-context # 展示当前所处的上下文
kubectl config use-context my-cluster-name # 设置默认的上下文为 my-cluster-name
kubectl config set-credentials kubeuser/foo.kubernetes.com --username=kubeuser --password=kubepassword # 添加新的集群配置到 kubeconf 中，使用 basic auth 进行鉴权
kubectl config set-context gce --user=cluster-admin --namespace=foo \
  && kubectl config use-context gce # 使用特定的用户名和命名空间设置上下文。

kubectl get objecttyp # 获取某种obejct的列表
kubectl get objecttype object-name # 获取某个object详情
kubectl get all # 查看所有的资源信息
kubectl get --all-namespaces
kubectl get node # 查看node节点列表
kubectl get node --show-labels # 显示node节点的标签信息
kubectl get svc # 查看服务的详细信息，显示了服务名称，类型，集群ip，端口，时间等信息
kubectl get svc -n kube-system
kubectl get ns # 查看命名空间
kubectl get namespaces
kubectl get rs # 查看目前所有的replica set，显示了所有的pod的副本数，以及他们的可用数量以及状态等信息
kubectl get deploy -o wide # 查看已经部署了的所有应用，可以看到容器，以及容器所用的镜像，标签等信息
kubectl get deployments -o wide
kubectl get pods -A
kubectl get pod  # 查看pod列表
kubectl get pod --show-labels # 显示pod节点的标签信息
kubectl get pods -l app=example # 根据指定标签匹配到具体的pod
kubectl get pod -o wide # 查看pod详细信息，也就是可以查看pod具体运行在哪个节点上（ip地址信息）
kubectl get pod --all-namespaces # 查看所有pod所属的命名空间
kubectl get pod --all-namespaces  -o wide # 查看所有pod所属的命名空间并且查看都在哪些节点上运行
kubectl get deployments|events|services

# 设置资源的一些范围限制
kubectl set resources deployment nginx -c=nginx --limits=cpu=200m,memory=512Mi #  将deployment的nginx容器cpu限制为“200m”，将内存设置为“512Mi”
kubectl set resources deployment nginx --limits=cpu=200m,memory=512Mi --requests=cpu=100m,memory=256Mi # 设置所有nginx容器中 Requests和Limits
kubectl set resources deployment nginx --limits=cpu=0,memory=0 --requests=cpu=0,memory=0 # 删除nginx中容器的计算资源值

# 更新现有资源的容器镜像
kubectl set image deployment/nginx busybox=busybox nginx=nginx:1.9.1 # 将deployment中的nginx容器镜像设置为“nginx：1.9.1”
kubectl set image deployments,rc nginx=nginx:1.9.1 --all # 所有deployment和rc的nginx容器镜像更新为“nginx：1.9.1”
kubectl set image daemonset abc *=nginx:1.9.1 # 将daemonset abc的所有容器镜像更新为“nginx：1.9.1”
kubectl set image -f path/to/file.yaml nginx=nginx:1.9.1 --local -o yaml # 从本地文件中更新nginx容器镜像

kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=172.28.128.228 # 创建

# create 命令：根据文件或者输入来创建资源
kubectl create -f single-config-file.yaml
kubectl run nginx --replicas=3 --labels="app=example" --image=nginx:1.10 --port=80
kubectl expose deployment nginx --port=88 --type=NodePort --target-port=80 --name=nginx-service
# Expose the Pod to the public internet
kubectl create deployment hello-minikube --image=k8s.gcr.io/echoserver:1.10
kubectl expose deployment hello-minikube --type=NodePort --port=8080
kubectl describe pod kubernetes-dashboard -n kube-system

# 更新（增加、修改或删除）资源上的 label
kubectl label pods foo unhealthy=true # 给名为foo的Pod添加label unhealthy=true
kubectl label --overwrite pods foo status=unhealthy # 给名为foo的Pod修改label 为 'status' / value 'unhealthy'，且覆盖现有的value
kubectl label pods --all status=unhealthy # 给 namespace 中的所有 pod 添加 label
kubectl label pods foo status=unhealthy --resource-version=1 # 仅当resource-version=1时才更新 名为foo的Pod上的label
kubectl label pods foo bar- # 删除名为“bar”的label 。（使用“ - ”减号相连）

kubectl annotate pods foo description='my frontend' # 更新Pod“foo”，设置annotation “description”的value “my frontend”，如果同一个annotation多次设置，则只使用最后设置的value值
kubectl annotate -f pod.json description='my frontend' # 根据“pod.json”中的type和name更新pod的annotation
kubectl annotate --overwrite pods foo description='my frontend running nginx' # 更新Pod"foo"，设置annotation“description”的value“my frontend running nginx”，覆盖现有的值
kubectl annotate pods --all description='my frontend running nginx' # 更新 namespace中的所有pod
kubectl annotate pods foo description='my frontend running nginx' --resource-version=1 # 只有当resource-version为1时，才更新pod 'foo'
kubectl annotate pods foo description- # 通过删除名为“description”的annotations来更新pod 'foo'。 不需要 -overwrite flag。

# apply命令：通过文件名或者标准输入对资源应用配置
# 部署weave网络
sysctl net.bridge.bridge-nf-call-iptables=1 -w
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

# 删除资源
kubectl delete services hello-minikube
kubectl delete deployment hello-minikube
kubectl delete -f demo-deployment.yaml

# patch命令：使用补丁修改，更新资源的字段，也就是修改资源的部分内容 语法：kubectl patch (-f FILENAME | TYPE NAME) -p PATCH
kubectl patch node k8s-node-1 -p '{"spec":{"unschedulable":true}}' # Partially update a node using strategic merge patch
kubectl patch pod valid-pod -p '{"spec":{"containers":[{"name":"kubernetes-serve-hostname","image":"new image"}]}}' # Update a container's image; spec.containers[*].name is required because it's a merge key
# replace命令：通过文件或者标准输入替换原有资源
kubectl replace -f ./pod.json # Replace a pod using the data in pod.json.
cat pod.json | kubectl replace -f - # Replace a pod based on the JSON passed into stdin.
kubectl get pod mypod -o yaml | sed 's/\(image: myimage\):.*$/\1:v4/' | kubectl replace -f - # Update a single-container pod's image version (tag) to v4
kubectl replace --force -f ./pod.json # Force replace, delete and then re-create the resource

kubectl convert -f pod.yaml # Convert 'pod.yaml' to latest version and print to stdout.
kubectl convert -f pod.yaml --local -o json # Convert the live state of the resource specified by 'pod.yaml' to the latest version and print to stdout in json format.
kubectl convert -f . | kubectl create -f - # Convert all files under current directory to latest version and create them all.

alias kcd='kubectl config set-context $(kubectl config current-context) --namespace ' # # To easily switch between namespaces, define an alias like this

kubectl exec -it [pod-name] -- /bin/bash # 登录到pod中(pod只有一个container的情况)
kubectl exec -it [pod-name] --container [container-name] -- /bin/bash # 登录到pod中的某个container中（pod包含多个container）

## rollout 命令: 用于对资源进行管理
kubectl rollout undo deployment/abc # 回滚到之前的deployment
kubectl rollout status daemonset/foo # 查看daemonet的状态

# rolling-update命令: 执行指定ReplicationController的滚动更新
kubectl rolling-update frontend-v1 -f frontend-v2.json # 使用frontend-v2.json中的新RC数据更新frontend-v1的pod
cat frontend-v2.json | kubectl rolling-update frontend-v1 -f - # 使用JSON数据更新frontend-v1的pod
kubectl rolling-update frontend-v1 frontend-v2 --image=image:v2
kubectl rolling-update frontend --image=image:v2
kubectl rolling-update frontend-v1 frontend-v2 --rollback

# scale命令：扩容或缩容 Deployment、ReplicaSet、Replication Controller或 Job 中Pod数量

kubectl scale --replicas=3 rs/foo #  将名为foo中的pod副本数设置为3。
kubectl scale deploy/nginx --replicas=30
kubectl scale --replicas=3 -f foo.yaml # 将由“foo.yaml”配置文件中指定的资源对象和名称标识的Pod资源副本设为3
kubectl scale --current-replicas=2 --replicas=3 deployment/mysql # 如果当前副本数为2，则将其扩展至3。
kubectl scale --replicas=5 rc/foo rc/bar rc/baz # 设置多个RC中Pod副本数量

# autoscale命令：弹性伸缩策略 ，它是根据流量的多少来自动进行扩展或者缩容。
kubectl autoscale deployment foo --min=2 --max=10 # 使用 Deployment “foo”设定，使用默认的自动伸缩策略，指定目标CPU使用率，使其Pod数量在2到10之间
kubectl autoscale rc foo --max=5 --cpu-percent=80 # 使用RC“foo”设定，使其Pod的数量介于1和5之间，CPU使用率维持在80％

### 集群管理
# certificate命令：用于证书资源管理，授权等
kubectl certificate approve node-csr-81F5uBehyEyLWco5qavBsxc1GzFcZk3aFM3XW5rT3mw node-csr-Ed0kbFhc_q7qx14H3QpqLIUs0uKo036O2SnFpIheM18 # 例如，当有node节点要向master请求，那么是需要master节点授权的
kubectl cluster-info # cluster-info 命令：显示集群信息

# 以前需要heapster，后替换为metrics-server
kubectl top pod --all-namespaces # top 命令：用于查看资源的cpu，内存磁盘等资源的使用率
cordon命令：用于标记某个节点不可调度
uncordon命令：用于标签节点可以调度
drain命令：用于在维护期间排除节点。
taint命令：用于给某个Node节点设置污点


kubectl logs nginx # 返回仅包含一个容器的pod nginx的日志快照
kubectl logs -p -c ruby web-1 # 返回pod ruby中已经停止的容器web-1的日志快照
kubectl logs -f -c ruby web-1 # 持续输出pod ruby中的容器web-1的日志
kubectl logs --tail=20 nginx # 仅输出pod nginx中最近的20条日志
kubectl logs --since=1h nginx # 输出pod nginx中最近一小时内产生的所有日志

kubectl exec -it nginx-deployment-58d6d6ccb8-lc5fp bash # 进入nginx容器，执行一些命令操作
kubectl attach 123456-7890 #  获取正在运行中的pod 123456-7890的输出，默认连接到第一个容器
kubectl attach 123456-7890 -c ruby-container # 获取pod 123456-7890中ruby-container的输出
kubectl attach 123456-7890 -c ruby-container -i -t # 切换到终端模式，将控制台输入发送到pod 123456-7890的ruby-container的“bash”命令，并将其输出到控制台/

kubectl api-versions

sudo kubeadm reset
```

```sh
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# 用 kubeadm 部署一个单节点集群，默认情况下无法使用，请执行以下命令解除限制
kubectl taint nodes --all node-role.kubernetes.io/master-
# 恢复默认值
kubectl taint nodes NODE_NAME node-role.kubernetes.io/master=true:NoSchedule
```

## kubernets-dashbord

* 访问 `http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/`
* 需要使用Kubeconfig
* Token登录
    - 创建一个admin-role.yaml文件
    - 创建serviceaccount和角色绑定 `kubectl create -f admin-role.yaml`
    - 获取secret中的token `kubectl -n kube-system get secret |grep admin-token` `kubectl -n kube-system describe secret admin-token-2s8jh | grep token`

```sh
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/aio/deploy/recommended.yaml

kubectl proxy # 启动proxy

# token create
kubectl create sa dashboard-admin -n kube-system
kubectl create clusterrolebinding dashboard-admin --clusterrole=cluster-admin --serviceaccount=kube-system:dashboard-admin
ADMIN_SECRET=$(kubectl get secrets -n kube-system | grep dashboard-admin | awk '{print $1}')
DASHBOARD_LOGIN_TOKEN=$(kubectl describe secret -n kube-system {ADMIN_SECRET} | grep -E '^token' | awk '{print $2}')
echo ${DASHBOARD_LOGIN_TOKEN}

kubectl delete deployment kubernetes-dashboard --namespace=kube-system
kubectl delete service kubernetes-dashboard --namespace=kube-system
```

## [Helm](https://github.com/helm/helm)

* The package manager for Kubernetes <https://helm.sh/>
* [下载](https://github.com/helm/helm/releases)
* [helm/charts](https://github.com/helm/charts):Curated applications for Kubernetes
* 配置
* 工作原理
    - 使用的是一种叫做charts的yaml文件
    - charts被设计的便于创建和维护，它们可以互相共享并用于发布Kubernetes。charts包含说明文件以及至少一个模板，其中模板包含了Kubernetes清单文件。它们可以多次部署重复使用。如果多次安装同一个charts，则将创建一个新的版本
    - install A release name that you pick, and the name of the chart you want to install.
* helm部署及其应用
* 部署efk日志收集系统
* 资源
    - [Helm Hub ](https://hub.helm.sh/):Discover & launch great Kubernetes-ready apps

| Linux            | $HOME/.cache/helm         | $HOME/.config/helm             | $HOME/.local/share/helm |
| macOS            | $HOME/Library/Caches/helm | $HOME/Library/Preferences/helm | $HOME/Library/helm      |
| Windows          | %TEMP%\helm               | %APPDATA%\helm                 | %APPDATA%\helm

```sh
## install
tar -zxvf helm-v3.0.0-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin/helm
brew install helm
choco install kubernetes-helm
sudo snap install helm --classic

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

## config
helm repo list
helm repo add stable https://kubernetes-charts.storage.googleapis.com/
helm repo add stable http://mirror.azure.cn/kubernetes/charts/
helm repo remove
helm search repo stable
helm search hub
helm repo update

helm install happy-panda stable/mariadb
helm install stable/mysql --generate-name
helm show chart stable/mysql
helm ls # has been released using Helm
helm uninstall mysql-1588737754
helm status mysql-1588737754

# custom
helm show values stable/mariadb
echo '{mariadbUser: user0, mariadbDatabase: user0db}' > config.yaml
helm install -f config.yaml stable/mariadb --generate-name

helm show values stable/mariadb
helm get values key
helm upgrade -f panda.yaml happy-panda stable/mariadb
helm rollback happy-panda 1 # helm rollback [RELEASE] [REVISION]

helm delete --purge [release name] # helm删除release(release name 可用于新的release)
helm delete [release name] # helm删除release(release name将保留，即不能用于新的release)
```

### etcd

* 并不是kubernetes的一部分，它是 CoreOS 团队发起的一个管理配置信息和服务发现（service discovery）项目，目标是构建一个高可用的分布式键值（key-value）数据库
* 与kubernetes和docker一样还是在快速迭代开发中的产品，没有ZooKeeper那样成熟

### 熔断机制

* 微服务架构中，各服务通过服务发现的方式互相依赖，虽然从单个服务看来能获得非常好的隔离性，不会因为某个进程或者服务宕掉对其他服务造成直接影响，但是从业务角度来看，单个服务实例故障还是可能造成业务访问出现问题，轻则影响服务调用方出现延迟和负载上升，重则造成业务整体异常。微服务调用中很容易出现的级联失败。断路器是一个开关，本意是指电路系统上的一种保护线路电流过载的一种装置，当线路中电流太大或者发生短路时，断路器开关打开，电路切断，防止引起更加严重的后果。引申到微服务治理策略中，断路器的作用就是避免故障或者异常在微服务调用链中蔓延。
* 服务调用方在尝试调用远端服务时，同时提供一个 fallback 方法，就是当远端服务出现故障时，调用 fallback 方法，快速返回结果，避免级联效应，使故障隔离。同时，断路器应该需要提供一个阈值开关，当远端服务的调用连续失败次数超过某个阈值时，服务调用方直接调用 fallback 方法，不再请求远端服务。等远端服务恢复后，再恢复正常调用流程。

### 服务降级

服务降级也是服务治理策略中重要的一环。当业务出现流量峰值，或者系统中某个组成部分出现故障，保证系统整体功能仍然可用，我们可能需要停掉一些不太重要的周边系统，从而保证核心服务的 SLA。比如电商系统在进行大促时，往往会弃车保帅，优先选择停止"猜你喜欢"、"评论"等不那么重要的系统，保障购物车、支付系统可用。在微服务架构里，每个服务无论是服务提供方还是服务调用方，都应该围绕 SLA 制定不同的降级策略。按降级粒度粗细我们可以制定接口降级、功能降级、服务降级。

* 接口降级：对于非核心接口，设置为直接返回空或异常，可以在高峰期有效减少接口逻辑对资源（CPU、内存、网络 I/O、磁盘 I/O 等）的占用和消耗。
* 功能降级：对于非核心功能，可以设置该功能直接执行本地逻辑，不做跨服务、跨网络访问。也可以设置降级开关，一键关闭指定功能，保全系统稳定运行。
* 服务降级：对于非核心服务，可以通过服务治理框架根据错误率或者响应时间自动触发降级策略。
* 功能降级和服务降级可以通过熔断机制和断路器实现
    - 自动化容器的部署与复制
    - 服务与命名发现
    - 集群调度
    - 自动扩展及收缩服务器规模
    - 容器编排，负载均衡
    - 应用升级部署
    - 弹性容器及故障迁移
    - 集群监控

## ingress controller

* Ingress Controller是一个统称，并不是只有一个，有如下这些：
    - Ingress NGINX: Kubernetes 官方维护的方案，也是本次安装使用的 Controller
    - F5 BIG-IP Controller: F5 所开发的 Controller，它能够让管理员通过 CLI 或 API 让 Kubernetes 与 OpenShift 管理 F5 BIG-IP 设备
    - Ingress Kong: 著名的开源 API Gateway 方案所维护的 Kubernetes Ingress Controller
    - Traefik: 是一套开源的 HTTP 反向代理与负载均衡器，而它也支援了 Ingress
    - Voyager: 一套以 HAProxy 为底的 Ingress Controller
* 使用service或者pod的网络将它暴露在集群外，然后它反向代理集群内的七层服务，通过vhost子域名那样路由到后端的服务
* 流量从入口到Ingress Controller的pod有下面几种方式：
    - type为LoadBalancer的时候手写externalIPs很鸡肋，后面会再写文章去讲它
    - type为LoadBalancer的时候只有云厂商支持分配公网ip来负载均衡，LoadBalancer 公开的每项服务都将获得自己的 IP 地址，但是需要收费，且自己建立集群无法使用
    - 不创建service，pod直接用hostport，效率等同于hostNetwork，如果不代理四层端口还好，代理了需要修改pod的template来滚动更新来让nginx bind的四层端口能映射到宿主机上
    - Nodeport，端口不是web端口（但是可以修改Nodeport的范围改成web端口），如果进来流量负载到Nodeport上可能某个流量路线到某个node上的时候因为Ingress Controller的pod不在这个node上，会走这个node的kube-proxy转发到Ingress Controller的pod上，多走一趟路
    - 不创建service，效率最高，也能四层负载的时候不修改pod的template，唯一要注意的是hostNetwork下pod会继承宿主机的网络协议，也就是使用了主机的dns，会导致svc的请求直接走宿主机的上到公网的dns服务器而非集群里的dns server，需要设置pod的dnsPolicy: ClusterFirstWithHostNet即可解决

```sh
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/mandatory.yaml
```

### [kubernetes/minikube](https://github.com/kubernetes/minikube)

* Run Kubernetes locally https://minikube.sigs.k8s.io/
* Minikube is a small setup by Kubernetes guys, which will spawn a virtual machine and have a tiny (but fully functional) Kubernetes cluster inside the VM.
* kubectl is the command line client you’ll use to connect to the Kubernetes cluster
* config file: `~/.kube/`
* all the virtual machine bits:`~/.minikube/`
* 启动参数
    - export http_proxy命令是添加命令行代理，主要是为了让minikube可以在命令行通过proxy去下载相关文件
    - --docker-env http_proxy...，设置虚拟机中docker daemon的环境变量，这里的环境变量http_proxy表示虚拟机中docker daemon使用的代理
    - --docker-env no_proxy，设置虚拟机中docker daemon不使用代理的地址段
    - --log_dir=tmp，设置minikube的日志存储位置，这里是当前目录下的tmp文件夹。该目录下会出现INFO和ERROR的日志，INFO是一定会有，ERROR是出错的时候才有。比如
    - --cpus 4，设置虚拟机的cpu核数
    - --memory 8192，设置虚拟机的内存大小，单位为M
* start主要做了这些事：
    - 创建了名为minikube的虚拟机，并在虚拟机中安装了Docker容器运行时。（实际就是Docker-machine）
    - 下载了Kubeadm与Kubelet工具
    - 通过Kubeadm部署Kubernetes集群
    - 进行各组件间访问授权、健康检查等工作
    - 在用户操作系统安装并配置kubectl
* 参考
    - [Hello Minikube](https://kubernetes.io/docs/tutorials/hello-minikube/)

```shell
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew cask install virtualbox
# To check if virtualization is supported on macOS, run the following command on your terminal
sysctl -a | grep -E --color 'machdep.cpu.features|VMX'

brew install minikube

curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64
chmod +x minikube
sudo mv minikube /usr/local/bin

minikube start --registry-mirror=https://registry.docker-cn.com
minikube start --vm-driver=virtualbox|parallels|vmwarefusion|hyperkit|vmware --disk-size='10g'  --image-mirror-country='cn' --image-repository='registry.cn-hangzhou.aliyuncs.com/google_containers'
minikube start --registry-mirror=https://registry.docker-cn.com --kubernetes-version v1.12.1
minikube start --memory=8192 --cpus=4 --disk-size=20g  --registry-mirror=https://docker.mirrors.ustc.edu.cn --kubernetes-version=v1.12.5 --docker-env http_proxy=http://192.168.0.40:8123 --docker-env https_proxy=http://192.168.0.40:8123 --docker-env no_proxy=localhost,127.0.0.1,::1,192.168.0.0/24,192.168.99.0/24
minikube start --vm-driver=virtualbox --registry-mirror=https://registry.docker-cn.com --image-mirror-country=cn --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers
minikube start --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers

minikube docker-env|stop|status|delete
rm -rf  ~/.minikube

E1211 16:50:42.913765   43824 cache_images.go:80] CacheImage k8s.gcr.io/k8s-dns-sidecar-amd64:1.14.13 -> /Users/henry/.minikube/cache/images/k8s.gcr.io/k8s-dns-sidecar-amd64_1.14.13 failed: fetching image: Get https://k8s.gcr.io/v2/: dial tcp [2404:6800:4008:c01::52]:443: i/o timeout
Unable to load cached images: loading cached images: loading image /Users/henry/.minikube/cache/images/k8s.gcr.io/kube-scheduler_v1.16.2: stat /Users/henry/.minikube/cache/images/k8s.gcr.io/kube-scheduler_v1.16.2

# goole服务器，只能拉取国内的镜像
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/etcd:3.2.24
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/etcd:3.2.24 k8s.gcr.io/etcd:3.2.24

minikube ssh|dashboard
minikube dashboard --url
minikube service hello-minikube --url

minikube addons list
minikube addons enable|disable heapster
minikube addons enable ingress

kubectl cluster-info
kubectl config view
kubectl get node -o wide

kubectl delete service hello-node
kubectl delete deployment hello-node

minikube service list

#!/bin/bash
# download k8s 1.15.2 images
# get image-list by 'kubeadm config images list --kubernetes-version=v1.15.2'
# gcr.azk8s.cn/google-containers == k8s.gcr.io
images=(
    kube-apiserver:v1.17.3
    kube-controller-manager:v1.17.3
    kube-scheduler:v1.17.3
    kube-proxy:v1.17.3
    pause:3.1
    etcd:3.4.3-0
    coredns:1.6.5
)
for imageName in ${images[@]};do
#    docker pull gcr.azk8s.cn/google-containers/$imageName
#    docker tag  gcr.azk8s.cn/google-containers/$imageName k8s.gcr.io/$imageNam
#    docker rmi  gcr.azk8s.cn/google-containers/$imageName

    docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/$imageName
    docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/$imageName k8s.gcr.io/$imageName
    docker rmi registry.cn-hangzhou.aliyuncs.com/google_containers/$imageName
done

# create
kubectl create deployment hello-minikube --image=k8s.gcr.io/echoserver:1.10
# access
kubectl expose deployment hello-minikube --type=NodePort --port=8080

kubectl get pod
# Get the URL of the exposed Service to view the Service details
minikube service hello-minikube --url
kubectl delete services hello-minikube
kubectl delete deployment hello-minikube
```

```
kubectl get nodes
kubectl get pods -n kube-system | grep coredns

kubectl apply -f  kube-flannel.yml

kubectl create secret generic user --from-file=./username.txt
kubectl get secrets

kubectl describe pod test-liveness-exec

kubectl get pod test-liveness-exec -o yaml

kubectl get deployments
kubectl rollout status deployment/nginx-deployment
kubectl rollout history deployment/nginx-deployment
kubectl rollout undo deployment/nginx-deployment --to-revision=2
kubectl rollout pause deployment/nginx-deployment
kubectl rollout resume deploy/nginx-deployment

# 查看一下这个 Deployment 所控制的 ReplicaSet
kubectl get rs

kubectl edit deployment/nginx-deployment
kubectl set image deployment/nginx-deployment nginx=nginx:1.91

kubectl get service nginx

kubectl get statefulset web
kubectl get pods -w -l app=nginx
```

## [ coreos / flannel ](https://github.com/coreos/flannel)

flannel is a network fabric for containers, designed for Kubernetes

## 问题

* [gotok8s / k8s-docker-desktop-for-mac](https://github.com/gotok8s/k8s-docker-desktop-for-mac):Docker Desktop for Mac 开启并使用 Kubernetes https://github.com/gotok8s/gotok8s

```
The connection to the server localhost:8080 was refused - did you specify the right host or port?

# kubectl命令需要使用kubernetes-admin来运行
echo “export KUBECONFIG=/etc/kubernetes/admin.conf” >> ~/.bash_profile

source ~/.bash_profile
```

## 图书

* 《[Kubernetes权威指南 : 从Docker到Kubernetes实践全接触（第2版）](https://book.douban.com/subject/26902153/)》

## 实例

* [rootsongjc/kubernetes-vagrant-centos-cluster](https://github.com/rootsongjc/kubernetes-vagrant-centos-cluster):Setting up a distributed Kubernetes cluster along with Istio service mesh locally with Vagrant and VirtualBox, only PoC or Demo use. https://jimmysong.io
* [opsnull/follow-me-install-kubernetes-cluster](https://github.com/opsnull/follow-me-install-kubernetes-cluster)

## 工具

* 配置
    - [kubernetes-sigs/kustomize](https://github.com/kubernetes-sigs/kustomize):Customization of kubernetes YAML configurations
    - [AliyunContainerService / k8s-for-docker-desktop](https://github.com/AliyunContainerService/k8s-for-docker-desktop):为Docker Desktop for Mac/Windows开启Kubernetes和Istio - Enable Kubernetes/Istio on Docker Desktop in China https://yq.aliyun.com/articles/672675
* 部署
    - [kubernetes-incubator/kubespray](https://github.com/kubernetes-incubator/kubespray):Deploy a Production Ready Kubernetes Cluster
    - [kubernetes-sigs / kind](https://github.com/kubernetes-sigs/kind/):Kubernetes IN Docker - local clusters for testing Kubernetes https://kind.sigs.k8s.io/
    -  [fanux / sealos](https://github.com/fanux/sealos):只能用丝滑一词形容的kubernetes高可用安装（kubernetes install）工具，一条命令，离线安装，包含所有依赖，内核负载不依赖haproxy keepalived,纯golang开发,99年证书,支持v1.16.8 v1.15.11 v1.17.4 v1.18.0! https://sealyun.com
    -  [Apollo](https://github.com/logzio/apollo/wiki/Getting-Started-with-Apollo):提供自助UI，用于部署和创建Kubernetes服务，Apollo允许管理员单击一下即可查看日志并且可以将部署恢复到任何时间点
* UI
    - [Qihoo360/wayne](https://github.com/Qihoo360/wayne):Web UI for Kubernetes multi-clusters
    - [K9s](https://github.com/derailed/k9s)
    - [Tubectl](https://github.com/reconquest/tubekit)
    - [Web Kubectl](https://github.com/KubeOperator/webkubectl) `docker run --name='webkubectl' -p 8080:8080 -d --privileged kubeoperator/webkubectl`
    - [kube-prompt](https://github.com/c-bata/kube-prompt)
    - [kubectl-tree](https://github.com/ahmetb/kubectl-tree)
* Chaos
    -  [ChaosBlade](https://github.com/chaosblade-io/chaosblade)
*  监控
    -  [cAdvisor](https://github.com/google/cadvisor):开源的Kubernetes监控工具，由Google维护。主要用于监视资源使用情况和性能
*  安全
    -  [Twistlock](https://www.twistlock.com/):全生命周期的容器安全解决方案。它具有VMS，可持续扫描Kubernetes以及任何易受攻击的区域
    -  [Falco](https://falco.org/):行为活动监视器，用于检测应用程序异常。它源自Sysdig项目，目前已经成为一款商业产品。Falco通过跟踪内核系统调用来监控容器性能。Falco允许使用一组规则持续监视和检测容器、应用程序、主机和网络活动
    -  [Aqua Security](https://www.aquasec.com/):在部署之前扫描镜像，会把镜像设置成只读，这样一来镜像不容易受到威胁
*  Cli
    -  [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
    -  [kubectx](https://github.com/ahmetb/kubectx)
    -  [Kube-shell](https://github.com/cloudnativelabs/kube-shell)
*  Serverless
    -  [Kubeless](https://kubeless.io/):用于部署小型应用程序的本地Kubernetes工具。它使用Kubernetes资源来执行许多任务，这有利于自动扩容、路由API、监控以及故障排查
    -  [IronFunction：](https://open.iron.io/):用Golang编写的开源Serverless工具。它支持任何编程语言。支持AWS Lambda函数
* [kubesphere/kubesphere](https://github.com/kubesphere/kubesphere):Easy-to-use Production Ready Container Platform https://kubesphere.io
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
* [Kube-ops-view](link)
* [AHAS](https://www.aliyun.com/product/ahas): 为 K8s 等容器环境提供了架构可视化的功能，同时，具有故障注入式高可用能力评测和一键流控降级等功能，可以快速低成本的提升应用可用性
* [eon01/kubernetes-workshop](https://github.com/eon01/kubernetes-workshop): A Gentle introduction to Kubernetes with more than just the basics.
* [okd](https://docs.okd.io/)
* [ubuntu/microk8s](https://github.com/ubuntu/microk8s):MicroK8s is a small, fast, single-package Kubernetes for developers, IoT and edge. https://microk8s.io
* [kubernetes/ingress-nginx](https://github.com/kubernetes/ingress-nginx):NGINX Ingress Controller for Kubernetes  https://kubernetes.github.io/ingress-nginx/
* cabin:一个Kubernetes 的原生的手机App仪表盘
* Kubectx:Kubectx与kubens捆绑在一起，当你使用kubectl的时候，允许你在Kubernetes集群和命名空间之间切换
* Kube-shell:个和Kubernetes CLI集成的 Shell，它有一些非常漂亮的特性
* Kube-prompt
* Kail是一个 Kubernetes tail。作为一个Kubernetes日志查看器，kail允许使用选择器从匹配的pods流式的查看日志
* Weave Scope 是一个Docker 和 Kubernetes的排错&监控工具
* PowerfulSeal 的灵感来源于 Chaos Monkey，由 Bloomberg 工程师团队开发。它可以给你的Kubernetes集群添加混乱，如杀掉目标的pods或者是节点。它以两个模式操作：交互式和自治的。
    - 交互式模式被设计为允许你发现你的集群组件，并且人工的停止一些事情看会发生什么。它操作在节点，pods，部署，和命名空间上。
    - 自治模式读取一个策略文件，可以包含任意
* Marmot是一个来自于谷歌的工作流执行引擎，用于处理SRE和Ops需要的工作流。它被设计为处理基础架构变更的工具，但它可以和Kubernetes一起使用
* Ark 是一个用于管理从你的Kubernetes资源和卷做灾难恢复的工具。Ark提供一个简单并且鲁棒的方式来备份和从系列的检查点恢复Kubernetes资源和持久化的卷。备份文件被存储在一个对象存储服务
* Sysdig是一个容器排错工具，它可以捕获系统调用和来自于Linux内核的事件。简单的说，对于整个集群，Sysdig就是strace + tcpdump + htop + iftop + lsof + wireshark。

## 参考

* [Tutorials](https://kubernetes.io/docs/tutorials/)
* [Kubernetes 中文社区](https://www.kubernetes.org.cn)
* [Kubernetes中文文档](http://docs.kubernetes.org.cn/)
* [容器编排和部署](https://developer.ibm.com/cn/solutions/container-orchestration-and-deployment/)
* [hobby-kube/guide](https://github.com/hobby-kube/guide):Kubernetes clusters for the hobbyist
* [kelseyhightower/kubernetes-the-hard-way](https://github.com/kelseyhightower/kubernetes-the-hard-way):Bootstrap Kubernetes the hard way on Google Cloud Platform. No scripts
* [feiskyer/kubernetes-handbook](https://github.com/feiskyer/kubernetes-handbook):Kubernetes Handbook （Kubernetes指南） https://kubernetes.feisky.xyzs
* [rootsongjc/kubernetes-handbook](https://github.com/rootsongjc/kubernetes-handbook):Kubernetes中文指南/云原生应用架构实践手册 - https://jimmysong.io/kubernetes-handbook
* [opsnull/follow-me-install-kubernetes-cluster](https://github.com/opsnull/follow-me-install-kubernetes-cluster):和我一步步部署 kubernetes 集群
* [jamiehannaford/what-happens-when-k8s](https://github.com/jamiehannaford/what-happens-when-k8s):🤔 What happens when I type kubectl run?
* [ramitsurana/awesome-kubernetes](https://github.com/ramitsurana/awesome-kubernetes):A curated list for awesome kubernetes sources 🚢🎉 https://ramitsurana.github.io/awesome-kubernetes/
* [gjmzj/kubeasz](https://github.com/gjmzj/kubeasz):使用Ansible脚本安装K8S集群，介绍组件交互原理，方便直接，不受国内网络环境影响 https://github.com/gjmzj/kubeasz
* [kubernetes/community](https://github.com/kubernetes/community):Kubernetes community content
* [hjacobs/kubernetes-failure-stories](https://github.com/hjacobs/kubernetes-failure-stories):Compilation of public failure/horror stories related to Kubernetes https://k8s.af
* [ContainerSolutions/k8s-deployment-strategies](https://github.com/ContainerSolutions/k8s-deployment-strategies):Kubernetes deployment strategies explained https://blog.container-solutions.com/kubernetes-deployment-strategies
* [Kuboard for K8S](https://kuboard.cn/learning/)
* [opsnull / follow-me-install-kubernetes-cluster](https://github.com/opsnull/follow-me-install-kubernetes-cluster):和我一步步部署 kubernetes 集群

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
