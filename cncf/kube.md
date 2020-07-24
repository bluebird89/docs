# Kube

* Kubernetes 名字源于希腊语，是舵手的意思
* 源自Google内部大规模集群管理系统——Borg，也是CNCF（Cloud Native Computing Foundation，今属Linux基金会）最重要的解决方案之一，旨在让部署容器化的应用简单并且高效
* 用于管理容器化应用程序集群的工具,自动执行应用程序部署的系统。在计算机领域中，此过程通常称为编排
* 具备完善的集群管理能力，包括多层次的安全防护和准入机制、多租户应用支撑能力、透明的服务注册和服务发现机制、内建负载均衡器、故障发现和自我修复能力、服务滚动升级和线上扩容、可扩充套件的资源自动调度机制、多粒度的资源配额管理能力。还提供完善的管理工具，涵盖开发、部署测试、运维监控等各个环节
* 将虚拟机和物理机转换为统一的API切面。然后，开发人员可以使用Kubernetes API来部署，扩展和管理容器化的应用程序
* 集群采用Master/Node 结构,可以通过命令列或者Web页面的方式来操作集群
* Master（主节点）控制整个集群
	- etcd： 由CoreOS开发，是一个高可用、强一致性的服务发现储存仓库，为Kubernetes集群提供储存服务.用来备份所有集群数据的数据库。它存储集群的整个配置和状态。主节点查询etcd以检索节点，容器和容器的状态参数
	- API Server： 控制程序的前端，也是用户唯一可以直接进行交互的Kubernetes组件，内部系统组件以及外部用户组件均通过相同的API进行通信.提供资源操作的唯一入口（其他模组通过API Server查询或修改资料，只有API Server才能直接操作etcd），并提供认证、授权、访问控制、API注册和发现等机制
	- Scheduler： 负责资源的调度，按照预定的调度策略将Pod（k8s中调度的基本单位）调度到相应的Node上.会监视来自API Server的新请求，并将其分配给运行状况良好的节点。对节点的质量进行排名，并将Pod部署到最适合的节点。如果没有合适的节点，则将Pod置于挂起状态，直到出现合适的节点
	- Controller： 从API Server获得所需状态。检查要控制的节点的当前状态，确定是否与所需状态存在任何差异，确保集群处于预期的工作状态，比如故障检测、自动扩充套件、滚动更新等
* Node（从节点）为集群提供计算能力.可以是物理机也可以是虚拟机器。监听API Server发送过来的新的工作分配；他们会执行分配给他们的工作，然后将结果报告给Kubernetes主节点
	- kubelet： 维护容器的生命周期，同时也负责Volume（CVI）和网络（CNI）的管理。每个节点上都会执行一个kubelet服务程序，接收并执行Master发来的指令，管理Pod及Pod中的容器。每个kubelet程序会在API Server上注册节点自身的信息，定期向Master节点汇报自身节点的资源使用情况，并通过cAdvisor监控节点和容器的资源
		+ 在群集中的每个节点上运行。是Kubernetes内部的主要代理。
		+ 通过安装kubelet，节点的CPU，RAM和存储成为所处集群的一部分。
		+ 监视从API  Server发送来的任务，执行任务，并报告给主节点。
		+ 会监视Pod，如果Pod不能完全正常运行，则会向控制程序报告。然后，基于该信息，主服务器可以决定如何分配任务和资源以达到所需状态
	- kube-proxy： 为Service提供集群内部的服务发现和负载均衡，监听API Server中service和endpoint的变化情况，确保每个节点都获得其IP地址，实现本地iptables和规则以处理路由和流量负载均衡
	- Container Runtime:从容器镜像库中拉取镜像，然后启动和停止容器。容器运行时由第三方软件或插件（例如Docker）担当

## 过程

* 管理员创建应用程序的所需状态并将其放入清单文件manifest.yml中
* 使用CLI或提供的用户界面将清单文件提供给Kubernetes API Server。Kubernetes的默认命令行工具称为kubectl
* Kubernetes将清单文件（描述了应用程序的期望状态）存储在称为键值存储（etcd）的数据库中
* Kubernetes随后在集群内的所有相关应用程序上实现所需的状态
* Kubernetes持续监控集群的元素，以确保应用程序的当前状态不会与所需状态有所不同

## Pod

* 一个抽象化概念，由一个或多个容器组合在一起的共享资源。根据资源的可用性，主节点会把Pod调度到特定工作节点上，并与容器运行时协调以启动容器
* 业务型别可以分为长期伺服型（long-running）、批处理型（batch）、节点后台支撑型（node-daemon）和有状态应用型（stateful application）这四种类型.可以由不同类别的Pod控制器来完成，分别为：Deployment、Job、DaemonSet和StatefulSet。
* Deployment: 复制控制器（Replication Controller，RC）是集群中最早的保证Pod高可用的API物件，副本集（Replica Set，RS）是它的升级，能支援更多种类的匹配模式。部署(Deployment)又是比RS应用模式更广的API物件，以Kubernetes的发展方向，未来对所有长期伺服型的的业务的管理，都会通过Deployment来管理。
	- Service： Deployment保证了Pod的数量，但是没有解决如何访问Pod的问题，一个Pod只是一个执行服务的选项，随时可能在一个节点上停止，在另一个节点以一个新的IP启动一个新的Pod ，因此不能以确定的IP和端口号提供服务。要稳定地提供服务需要服务发现和负载均衡能力，Service可以稳定为使用者提供服务。
* Job：用来控制批处理型任务，Job管理的Pod根据使用者的设定把任务成功完成就自动退出了。
* DaemonSet：后台支撑型服务的核心关注点在集群中的Node，要保证每个Node上都有一个此类Pod在运行。比如用来收集日志的Pod。
* StatefulSet： 不同于RC和RS，StatefulSet主要提供有状态的服务，StatefulSet中Pod的名字都是事先确定的，不能更改，每个Pod挂载自己独立的储存，如果一个Pod出现故障，从其他节点启动一个同样名字的Pod，要挂载上原来Pod的储存继续以它的状态提供服务。比如数据库服务MySQL，我们不希望一个Pod故障后，MySQL中的数据即丢失。

* Pod:最小编排单位,里的所有容器，共享的是同一个 Network Namespace，并且可以声明共享同一个 Volume
	- 应用，哪怕再简单，也是被管理在 systemd 或者 supervisord 之下的一组进程，而不是一个进程
	- 一个容器，就是一个进程
	- Pod，实际上是在扮演传统基础设施里“虚拟机”的角色；容器，则是这个虚拟机里运行的用户程序
		+ 让它里面的容器尽可能多地共享 Linux Namespace，仅保留必要的隔离和限制能力
		+ 凡是调度、网络、存储，以及安全相关的属性，基本上是 Pod 级别
		+ 凡是 Pod 中的容器要共享宿主机的 Namespace，也一定是 Pod 级别的定
	- 在一个容器里跑多个功能并不相关的应用时，应该优先考虑它们是不是更应该被描述成一个 Pod 里的多个容器
	- sidecar:可以在一个 Pod 中，启动一个辅助容器，来完成一些独立于主进程（主容器）之外的工作
	- 有顺序关系的容器，定义为 Init Container
	- 属性
		+ NodeSelector：是一个供用户将 Pod 与 Node 进行绑定的字段
		+ NodeName：一旦 Pod 的这个字段被赋值，Kubernetes 项目就会被认为这个 Pod 已经经过了调度，调度的结果就是赋值的节点名字
		+ HostAliases：定义了 Pod 的 hosts 文件（比如 /etc/hosts）里的内容


## Service

* 将稳定的IP地址和DNS名称引入到不稳定的Pod世界中,提供可靠的网络连接
* 通过控制进出Pod的流量，Service提供了稳定的网络终结点-固定的IP，DNS和端口。有了Service，可以添加或删除任何Pod，而不必担心基本网络信息会改变
* Pod通过称为标签（Label）和选择器（Selector）的键值对与Service相关联。Service会自动发现带有与选择器匹配的标签的新Pod
* Service ：来将一组 Pod 暴露给外界访问的一种机制
	- 访问
		+ 以 Service 的 VIP（Virtual IP，即：虚拟 IP）方式
		+ 以 Service 的 DNS 方式
			* Normal Servic：访问“my-svc.my-namespace.svc.cluster.local”解析到的正是 my-svc 这个 Service 的 VIP，后面的流程就跟 VIP 方式一致了
			* Headless Service：访问“my-svc.my-namespace.svc.cluster.local”解析到的，直接就是 my-svc 代理的某一个 Pod 的 IP 地址。不需要分配一个 VIP，而是可以直接以 DNS 记录的方式解析出被代理 Pod 的 IP 地址
	- Headless Service 所代理的所有 Pod 的 IP 地址，都会被绑定一个格式 `<pod-name>.<svc-name>.<namespace>.svc.cluster.local>` DNS


## Deployment

* 虚拟化部署:允许在单个物理服务器上创建隔离的虚拟环境，即虚拟机（VM）。该解决方案隔离了VM中的应用程序，限制了资源的使用并提高了安全性。一个应用程序不能再自由访问另一个应用程序处理的信息.快速扩展并分散单个物理服务器的资源，随意更新并控制硬件成本。每个VM都有其操作系统，并且可以在虚拟化硬件之上运行所有必要的系统
* 容器化部署:多个应用程序可以共享相同的基础操作系统,
* Deployment
	- 操纵 ReplicaSet 对象，而不是 Pod,实现版本更新,两层控制器
		+ 通过 ReplicaSet 的个数来描述应用的版本
		+ 通过 ReplicaSet 的属性（比如 replicas 的值），来保证 Pod 的副本数量
	- 一个 ReplicaSet 对象，由副本数目的定义和一个 Pod 模板组成的
	- 滚动更新
	- template :PodTemplate（Pod 模板）
	- 怎么多版本共存

## 概念

* PodPreset 里定义的内容，只会在 Pod API 对象被创建之前追加在这个对象本身上，而不会影响任何 Pod 的控制器的定义
	- 多个 PodPreset:合并（Merge）这两个 PodPreset 要做的修改。而如果它们要做的修改有冲突的话，这些冲突字段就不会被修改

* StatefulSet
	- 一种特殊的 Deployment，而其独特之处在于，它的每个 Pod 都被编号了。而且，这个编号会体现在 Pod 的名字和 hostname 等标识信息上，这不仅代表了 Pod 的创建顺序，也是 Pod 的重要网络标识（即：在整个集群里唯一的、可被访问的身份
* PV 持久化存储数据卷
	-  Volume，其实就是将一个宿主机上的目录，跟一个容器里的目录绑定挂载在了一起
	-  持久化 Volume”，指的就是这个宿主机上的目录，具备“持久性”
	- PVC: Pod 所希望使用的持久化存储属性
	- PVC 和 PV 的设计，实际上类似于“接口”和“实现”的思想。开发者只要知道并会使用“接口”，即：PVC；而运维人员则负责给“接口”绑定具体的实现，即：PV
	- PVC 其实就是一种特殊的 Volume。只不过一个 PVC 具体是什么类型的 Volume，要在跟某个 PV 绑定之后才知道
	- 用户创建的 PVC 要真正被容器使用起来，就必须先和某个符合条件的 PV 进行绑定。这里要检查的条件，包括两部分
		+ PV 和 PVC 的 spec 字段。比如，PV 的存储（storage）大小，就必须满足 PVC 的要求
		+ PV 和 PVC 的 storageClassName 字段必须一样
	- 过程
		+ Attach：虚拟机挂载远程磁盘的操作。由 Volume Controller 负责维护的，这个控制循环的名字叫作：AttachDetachController。而它的作用，就是不断地检查每一个 Pod 对应的 PV，和这个 Pod 所在宿主机之间挂载情况。从而决定，是否需要对这个 PV 进行 Attach（或者 Dettach）操作
		+ Mount：格式化这个磁盘设备，然后将它挂载到宿主机指定的挂载点上，挂载点，正是提到的 Volume 的宿主机目录。必须发生在 Pod 对应的宿主机上，所以它必须是 kubelet 组件的一部分。这个控制循环的名字，叫作：VolumeManagerReconciler，它运行起来之后，是一个独立于 kubelet 主循环的 Goroutine
		+ 对于“第一阶段”（Attach），Kubernetes 提供的可用参数是 nodeName，即宿主机的名字
		+ 对于“第二阶段”（Mount），Kubernetes 提供的可用参数是 dir，即 Volume 的宿主机目录
	- kubelet 只要把这个 Volume 目录通过 CRI 里的 Mounts 参数，传递给 Docker，然后就可以为 Pod 里的容器挂载这个“持久化”的 Volume 了
	-  PV 的“两阶段处理”流程，是靠独立于 kubelet 主控制循环（Kubelet Sync Loop）之外的两个控制循环来实现的
	-  自动创建 PV 的机制，即：Dynamic Provisioning，核心，在于一个名叫 StorageClass 的 API 对象。作用，其实就是创建 PV 的模板
		+  StorageClass 对象会定义如下两个部分内容
			*  PV 的属性。比如，存储类型、Volume 的大小等等
			*  创建这种 PV 需要用到的存储插件。比如，Ceph 等等
	-   StorageClass 的作用，则是充当 PV 的模板。并且，只有同属于一个 StorageClass 的 PV 和 PVC，才可以绑定在一起
	-   StorageClass 的另一个重要作用，是指定 PV 的 Provisioner（存储插件）。这时候，如果存储插件支持 Dynamic Provisioning 的话，Kubernetes 就可以自动为你创建 PV 了
* DaemonSet
	- 在 Kubernetes 集群里，运行一个 Daemon Pod。这个 Pod 有如下三个特征：
		+ 这个 Pod 运行在 Kubernetes 集群里的每一个节点（Node）上
		+ 每个节点上只有一个这样的 Pod 实例
		+ 当有新的节点加入 Kubernetes 集群后，该 Pod 会自动地在新节点上被创建出来；而当旧节点被删除后，它上面的 Pod 也相应地会被回收掉
	- 实例：网络插件、存储插件 监控组件和日志组件
	- 保证每个 Node 上有且只有一个被管理的 Pod
	- DaemonSet Controller 会在创建 Pod 的时候，自动在这个 Pod 的 API 对象里，加上这样一个 nodeAffinity 定义
	- 并不需要修改用户提交的 YAML 文件里的 Pod 模板，而是在向 Kubernetes 发起请求之前，直接修改根据模板生成的 Pod 对象
	- 会给这个 Pod 自动加上另外一个与调度相关的字段，叫作 tolerations。这个字段意味着这个 Pod，会“容忍”（Toleration）某些 Node 的“污点”（Taint）
* Job
	- 对象在创建后，Pod 模板，被自动加上了一个 controller-uid=< 一个随机字符串 > 这样的 Label。而这个 Job 对象本身，则被自动加上了这个 Label 对应的 Selector，从而 保证了 Job 与它所管理的 Pod 之间的匹配关系
	- 定义的 restartPolicy=OnFailure，那么离线作业失败后，Job Controller 就不会去尝试创建新的 Pod。但是，会不断地尝试重启 Pod 里的容器
	- spec.backoffLimit 字段里定义了重试次数为 4，而这个字段的默认值是 6,重新创建 Pod 的间隔是呈指数增加的，即下一次重新创建 Pod 的动作会分别发生在 10 s、20 s、40 s …后
	- spec.activeDeadlineSeconds 字段可以设置最长运行时间
	- spec.parallelism，定义的是一个 Job 在任意时间最多可以启动多少个 Pod 同时运行
	- spec.completions，定义的是 Job 至少要完成的 Pod 数目，即 Job 的最小完成数
	- 用法
		+ 外部管理器 +Job 模板
		+ 拥有固定任务数目的并行 Job
		+ 指定并行度（parallelism），但不设置固定的 completions 的值

```sh
kubectl get rs
echo "source <(kubectl completion bash)" >> ~/.bash_profile
```

## API 对象

* 基于声明性模型运行并实现"所需状态"的概念
* API物件是Kubernetes集群中的管理操作单元。集群中的众多技术概念分别对应着API物件，每个API物件都有3大类属性：
	- metadata（元资料）：用来标识API物件，包含namespace、name、uid等
	- spec（规范）：描述使用者期望达到的理想状态，所有的操作都是宣告式（Declarative）的而不是命令式（Imperative），在分布式系统中的好处是稳定，不怕丢操作或执行多次。比如设定期望3个执行Nginx的Pod，执行多次也还是一个结果，而给副本数加1的操作就不是宣告式的，执行多次结果就错了。
	- status（状态）：描述系统当前实际达到的状态，比如期望3个Pod，现在实际建立好了2个。
* 声明式 API
	- 所谓“声明式”，指的就是只需要提交一个定义好的 API 对象来“声明”，所期望的状态是什么样子
	- “声明式 API”允许有多个 API 写端，以 PATCH 的方式对 API 对象进行修改，而无需关心本地原始 YAML 文件的内容
	- 最重要的，有了上述两个能力，Kubernetes 项目才可以基于对 API 对象的增、删、改、查，在完全无需外界干预的情况下，完成对“实际状态”和“期望状态”的调谐（Reconcile）过程。
	- controller通过解读结构化的resource数据，获得期望状态，从而不断的调协期望状态和实际状态
* kubectl replace 的执行过程，是使用新的 YAML 文件中的 API 对象，替换原有的 API 对象
	- kube-apiserver 在响应命令式请求（比如，kubectl replace）的时候，一次只能处理一个写请求，否则会有产生冲突的可能
* kubectl apply，则是执行了一个对原有 API 对象的 PATCH 操作
	- 一次能处理多个写操作，并且具备 Merge 能力
* 在 Etcd 里的完整资源路径，是由：Group（API 组）、Version（API 版本）和 Resource（API 资源类型）三个部分组成
	-  会匹配 API 对象的组
		+  对于 Kubernetes 里的核心 API 对象，比如：Pod、Node 等，是不需要 Group 的（即：它们的 Group 是“”）。所以，对于这些 API 对象来说，Kubernetes 会直接在 /api 这个层级进行下一步的匹配过程
		+  对于 CronJob 等非核心 API 对象来说，Kubernetes 就必须在 /apis 这个层级里查找它对应的 Group，进而根据“batch”这个 Group 的名字，找到 /apis/batch
	-  进一步匹配到 API 对象的版本号
	-  会匹配 API 对象的资源类型
*  创建 CronJob 对象
	-  发起了创建 CronJob 的 POST 请求之后，编写的 YAML 的信息就被提交给了 APIServer。而 APIServer 的第一个功能，就是过滤这个请求，并完成一些前置性的工作，比如授权、超时处理、审计等
	-  请求会进入 MUX 和 Routes 流程。如果你编写过 Web Server 的话就会知道，MUX 和 Routes 是 APIServer 完成 URL 和 Handler 绑定的场所。而 APIServer 的 Handler 要做的事情，就是按照我刚刚介绍的匹配过程，找到对应的 CronJob 类型定义
	-  根据这个 CronJob 类型定义，使用用户提交的 YAML 文件里的字段，创建一个 CronJob 对象.进行一个 Convert 工作，即：把用户提交的 YAML 文件，转换成一个叫作 Super Version 的对象，它正是该 API 资源类型所有版本的字段全集。这样用户提交的不同版本的 YAML 文件，就都可以用这个 Super Version 对象来进行处理了
	-  APIServer 会先后进行 Admission() 和 Validation() 操作.Validation，则负责验证这个对象里的各个字段是否合法。这个被验证过的 API 对象，都保存在了 APIServer 里一个叫作 Registry 的数据结构中。也就是说，只要一个 API 对象的定义能在 Registry 里查到，它就是一个有效的 Kubernetes API 对象
	-  APIServer 会把验证过的 API 对象转换成用户最初提交的版本，进行序列化操作，并调用 Etcd 的 API 把它保存起来

## CRD Custom Resource Definition。

* 允许用户在 Kubernetes 中添加一个跟 Pod、Node 类似的、新的 API 资源类型，即：自定义 API 资源
* 通过创建CRDs, 主API server可以处理 CRDs 的 REST 请求（CRUD）和持久性存储。简单，不需要其他的编程。更适用于声明式的API，和kubernetes高度集成统一。
* API Aggregation, 一个独立的API server。主API server委托此独立的API server处理自定义resource。 需要编程，但能够更加灵活的控制API的行为，更加灵活的自定义存储，以及与API不同版本之间的转换。一般更适用于命令模式，或者复用已经存在REST API代码，不直接支持kubectl 和 k8s UI, 不支持scope resource in a cluster/namespace.
* 自定义控制器工作原理
	- 控制器要做的第一件事，是从 Kubernetes 的 APIServer 里获取它所关心的对象，也就是我定义的 Network 对象.依靠的是一个叫作 Informer（可以翻译为：通知器）的代码库完成的。Informer 与 API 对象是一一对应的，所以传递给自定义控制器的，正是一个 Network 对象的 Informer（Network Informer）
	- Network Informer 正是使用这个 networkClient，跟 APIServer 建立了连接。不过，真正负责维护这个连接的，则是 Informer 所使用的 Reflector 包.Reflector 使用的是一种叫作 ListAndWatch 的方法，来“获取”并“监听”这些 Network 对象实例的变化
	- 在 ListAndWatch 机制下，一旦 APIServer 端有新的 Network 实例被创建、删除或者更新，Reflector 都会收到“事件通知”。这时，该事件及它对应的 API 对象这个组合，就被称为增量（Delta），它会被放进一个 Delta FIFO Queue（即：增量先进先出队列）中
	- Informe 会不断地从这个 Delta FIFO Queue 里读取（Pop）增量。每拿到一个增量，Informer 就会判断这个增量里的事件类型，然后创建或者更新本地对象的缓存。这个缓存，在 Kubernetes 里一般被叫作 Store
	- Informer 的第二个职责，则是根据这些事件的类型，触发事先注册好的 ResourceEventHandler
*  Informer，其实就是一个带有本地缓存和索引机制的、可以注册 EventHandler 的 client。通过一种叫作 ListAndWatch 的方法，把 APIServer 中的 API 对象缓存在了本地，并负责更新和维护这个缓存
	-  通过 APIServer 的 LIST API“获取”所有最新版本的 API 对象；然后，再通过 WATCH API 来“监听”所有这些 API 对象的变化
	-  通过监听到的事件变化，Informer 就可以实时地更新本地缓存，并且调用这些事件对应的 EventHandler 了
	-  每经过 resyncPeriod 指定的时间，Informer 维护的本地缓存，都会使用最近一次 LIST 返回的结果强制更新一次，从而保证缓存的有效性。在 Kubernetes 中，这个缓存强制更新的操作就叫作：resync
	-  这个定时 resync 操作，也会触发 Informer 注册的“更新”事件。但此时，这个“更新”事件对应的 Network 对象实际上并没有发生变化，即：新、旧两个 Network 对象的 ResourceVersion 是一样的。在这种情况下，Informer 就不需要对这个更新事件再做进一步的处理了
* 参考
	- [](https://github.com/resouer/k8s-controller-custom-resource)；Base sample for a custom controller in Kubernetes working with custom resources

```
# 代码生成的工作目录，也就是我们的项目路径
$ ROOT_PACKAGE="github.com/resouer/k8s-controller-custom-resource"
# API Group
$ CUSTOM_RESOURCE_NAME="samplecrd"
# API Version
$ CUSTOM_RESOURCE_VERSION="v1"

# 安装k8s.io/code-generator
$ go get -u k8s.io/code-generator/...
$ cd $GOPATH/src/k8s.io/code-generator

# 执行代码自动生成，其中pkg/client是生成目标目录，pkg/apis是类型定义目录
$ ./generate-groups.sh all "$ROOT_PACKAGE/pkg/client" "$ROOT_PACKAGE/pkg/apis" "$CUSTOM_RESOURCE_NAME:$CUSTOM_RESOURCE_VERSION"
```

## 有状态应用”（Stateful Application)

* 痛点
	- 拓扑状态
		+ 必须按照某些顺序启动
		+ 网络标识
	- 存储状态：多个实例分别绑定了不同的存储数据
* StatefulSet 的核心功能，就是通过某种方式记录这些状态，然后在 Pod 被重新创建时，能够为新 Pod 恢复这些状态
* 滚动更新”（rolling update): kubectl patch 会按照与 Pod 编号相反的顺序，从最后一个 Pod 开始，逐一更新这个 StatefulSet 管理的每个 Pod

## 创建与修改

* 用 Kubernetes API 对象 来描述集群的 预期状态（desired state） ：包括需要运行的应用或者负载，使用的镜像、副本数，以及所需网络和磁盘资源等等
* 用命令行工具 kubectl 来调用 Kubernetes API 创建对象，通过所创建的这些对象来配置预期状态
* 直接调用 Kubernetes API 和集群进行交互，设置或者修改预期状态

## 原理

* 一旦设置了所需目标状态,Kubernetes 控制面（control plane） 会通过 Pod 生命周期事件生成器(PLEG)，促成集群的当前状态符合其预期状态.Kubernetes 会自动执行各类任务，比如运行或者重启容器、调整给定应用的副本数等等.Kubernetes 控制面由一组运行在集群上的进程组成
* Kubernetes 控制平面
	- 管理着 Kubernetes 如何与集群进行通信
	- 维护着系统中所有的 Kubernetes 对象的状态记录，并且通过连续的控制循环来管理这些对象的状态
	- 在任意的给定时间点，控制面的控制环都能响应集群中的变化，并且让系统中所有对象的实际状态与提供的预期状态相匹配
* Kubernetes master 节点:负责维护集群目标状态。当要与 Kubernetes 通信时，使用如 kubectl 的命令行工具，就可以直接与 Kubernetes master 节点进行通信
	- 包含以下三个进程,都运行在集群中的某个节点上，主控组件所在节点通常被称为 master 节点
		+ kube-apiserver
		+ kube-controller-manager:`kubernetes/pkg/controller/`每一个控制器，都以独有的方式负责某种编排功能,控制循环（control loop）
		+ kube-scheduler
* Kubernetes Node 节点 :集群中的 node 节点（虚拟机、物理机等等）都是用来运行应用和云工作流的机器。Kubernetes master 节点控制所有 node 节点
	- 集群中每个非 master 节点都运行两个进程：
		+ kubelet，和 master 节点进行通信
		+ kube-proxy：一种网络代理，将 Kubernetes 的网络服务代理到每个节点上

## [对象](https://kubernetes.io/docs/concepts/overview/working-with-objects/kubernetes-objects/)

* Kubernetes 包含若干用来表示系统状态的抽象层，包括：已部署的容器化应用和负载、与它们相关的网络和磁盘资源以及有关集群正在运行的其他操作的信息。这些抽象使用 Kubernetes API 对象来表示
* 基本对象
	- Pod
	- Service
	- Volume
	- Namespace
*  Controller 高级抽象:基于基本对象构建并提供额外的功能和方便使用的特性
	- Deployment
	- DaemonSet
	- StatefulSet
	- ReplicaSet
	- Job

```sh
kubrctl get namespaces
kubectl create|delete namespace xxx

kubectl get pods --all-namespaces
kubectl get service|pod|secret|namespace|node|csr
kubectl describe service|pod|secret|namespace|nodes|csr rs_name -n namespace_name

kubectl edit service service_name

kubectl apply -f https://k8s.io/examples/application/deployment.yaml --record

kubectl get nodes
kubectl describe node maste

kubectl get pods -n kube-system
kubectl exec -it pod_name -c container_name bash -n namespace_name
kubectl delete pod pod_name -n namespace_name

kubectl run nginx --image nginx
kubectl create deployment nginx --image nginx
kubectl explain deployment
kubectl get deployment -n namespace_name

kubectl create -f nginx.yaml
kubectl delete -f nginx.yaml -f redis.yaml
kubectl replace -f nginx.yaml
kubectl delete deployment deployment_name -n namespace_name

kubectl diff -R -f configs/
kubectl apply -R -f configs/

kubectl logs -f pod_name

kubectl create serviceaccount user_name -n namespace_name
kubectl get serviceaccount -A
kubectl get role -n namespace_name

kubectl exec -it pod_name bash -n namespace_name

kubectl get secret -A     #查看k8s集群所有的秘钥
kubectl describe secret token_name -n namespace_name #查看指定namespace里的指定token的详细信息

kubectl describe service service_name   #查看指定service的详细信息

kubectl get ep -n namespace_name #列出指定namespace中所有service与endpoint的对应关系

kubectl get hpa -n namespace_name #查看指定namespace中的hpa控制器

kubectl get pv                     #查看pv状态

kubectl get pvc -n namespace_name
```

## cluster

```sh
kubectl top #查看集群运行状态；可以指定node、pod等对象进行指标收集；需要安装好 Metrics 服务才能收集node节点的指标数据
kubectl top pod -n namespace_name #查看指定namespace下的pod的资源使用情况；需要k8s集群提前安装好metrics-server
kubectl top node #查看k8s集群中每个node节点的内存、CPU使用情况；需要k8s集群提前安装好metrics-server

kubectl version #查看kubectl命令版本，也可以看到 go 的版本
kubectl cluster-info #查看k8s集群中服务的访问方式

kubectl cordon node_name #创建pod时，被指定的节点将不会被scheduler进行调度
kubectl uncordon node_name #取消警戒标记为cordon的node

kubectl drain node_name #驱逐node上的pod(驱逐的是无状态服务，核心pod是不会被驱逐的)到其他节点上,用户node下线等场景
kubectl taint node_name #给node标记污点，实现pod与node反亲和性，pod不创建在有这个label标记的node节点上

kubectl api-resources #查看k8s的API的所有资源对象
kubectl api-versions #查看各个api分组的api版本
```

## [k8s](https://rollout.io/blog/getting-started-with-kubernetes/)

```sh
curl https://get.k8s.io > kubernetes_install.sh
bash kubernetes_install.sh

kubectl
export KUBECONFIG=~/.kube/config
```

## kubeadm

* weave

```sh

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF > /etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y docker.io kubeadm

sudo swapoff -a
sudo sed -i.bak '/swap/s/^/#/' /etc/fstab # forver

sudo kubeadm init --config kubeadm.yaml

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config


kubeadm config view
echo "export KUBECONFIG=/etc/kubernetes/admin.conf" >> ~/.bash_profile

kubectl apply -n kube-system -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

kubectl get nodes -n kue-system
kubectl describe node henry-honor

# NotReady message:docker: network plugin is not ready: cni config uninitialized
kubeadm token list

kubeadm token create    #重新生成token
kubeadm token list  | awk -F" " '{print $1}' |tail -n 1
openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed  's/^ .* //'

sudo kubeadm join 10.0.2.2:6443 --token iz45th.luzmgaiqz636dvpy   --discovery-token-ca-cert-hash sha256:6867dbd035d9ec227fec026d0e4c0dd492395efc741545d6965ec288203a1a1c
kubeadm join 192.168.0.103:6443 --token a6352o.h1j1pxf1kgdkyrie \
    --discovery-token-ca-cert-hash sha256:11a0f44f1989acd9cbb5f6124f623b3b7cdd5580c45063d12b83088918ec9358

kubectl taint nodes node1 foo=bar:NoSchedule
kubectl taint nodes --all node-role.kubernetes.io/master-

scp -P 2222  vagrant@10.0.2.15:/etc/kubernetes /etc/kubernetes/admin.conf
scp 10.0.2.2:/etc/kubernetes/admin.conf /etc/kubernetes/
kubeadm reset
```

## [ kubernetes / dashboard ](https://github.com/kubernetes/dashboard)

General-purpose web UI for Kubernetes clusters

```sh
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.3/aio/deploy/recommended.yaml
kubectl get pods -n kubernetes-dashboard
kubectl proxy
```

## [ rook / rook ](https://github.com/rook/rook)

Storage Orchestration for Kubernetes  https://rook.io

# Rook 项目是一个基于 Ceph 的 Kubernetes 存储插件  加入了水平扩展、迁移、灾难备份、监控等大量的企业级功能，使得这个项目变成了一个完整的、生产级别可用的容器存储插件

```sh

kubectl apply -f https://raw.githubusercontent.com/rook/rook/master/cluster/examples/kubernetes/ceph/common.yaml
kubectl apply -f https://raw.githubusercontent.com/rook/rook/master/cluster/examples/kubernetes/ceph/operator.yaml
kubectl apply -f https://raw.githubusercontent.com/rook/rook/master/cluster/examples/kubernetes/ceph/cluster.yaml
kubectl get pods -n rook-ceph-system
kubectl get pods -n rook-ceph
```

## Dynamic Admission Control （Initializer）

* 流程
	- Initializer 的控制器，不断获取到的“实际状态”，就是用户新创建的 Pod。而它的“期望状态”，则是：这个 Pod 里被添加了 Envoy 容器的定义
	- 如果这个 Pod 里面已经添加过 Envoy 容器，那么就“放过”这个 Pod，进入下一个检查周期。
	- 如果还没有添加过 Envoy 容器的话，就要进行 Initialize 操作了，即：修改该 Pod 的 API 对象
* 允许通过配置，来指定要对什么样的资源进行这个 Initialize 操作

## RABC

##  Operator

* 利用了 Kubernetes 的自定义 API 资源（CRD），来描述我们想要部署的“有状态应用”；然后在自定义控制器里，根据自定义 API 对象的变化，来完成具体的部署和运维工作
* Etcd Operator 部署 Etcd 集群，采用的是静态集群（Static）的方式
	- 静态集群的好处是，不必依赖于一个额外的服务发现机制来组建集群，非常适合本地容器化部署
	- 难点，则在于必须在部署的时候，就规划好这个集群的拓扑结构，并且能够知道这些节点固定的 IP 地址
	- 节点启动参数里的–initial-cluster 参数，非常值得关注。含义，正是当前节点启动时集群的拓扑结构。说得更详细一点，就是当前这个节点启动时，需要跟哪些节点通信来组成集群
	- 集群具体的组建过程，是逐个节点动态添加的方式
		+ Etcd Operator 会创建一个“种子节点”
		+ Etcd Operator 会不断创建新的 Etcd 节点，然后将它们逐一加入到这个集群当中，直到集群的节点数等于 size。
	- 种子节点与普通节点不同之处，就在于一个名叫–initial-cluster-state 的启动参数
		+ 当这个参数值设为 new 时，就代表了该节点是种子节点。种子节点还必须通过–initial-cluster-token 声明一个独一无二的 Token
		+ 如果这个参数值设为 existing，那就是说明这个节点是一个普通节点，Etcd Operator 需要把它加入到已有集群里。
	- 只在该 Cluster 对象第一次被创建的时候才会执行。就是我 Bootstrap，即：创建一个单节点的种子集群
		+ 每个 Cluster 对象，都会事先创建一个与该 EtcdCluster 同名的 Headless Service。这样，Etcd Operator 在接下来的所有创建 Pod 的步骤里，就都可以使用 Pod 的 DNS 记录来代替它的 IP 地址
	- 启动该集群所对应的控制循环
		+ 控制循环要获取到所有正在运行的、属于这个 Cluster 的 Pod 数量，也就是该 Etcd 集群的“实际状态
		+ 期望状态”，正是用户在 EtcdCluster 对象里定义的 size,对比这两个状态的差异

## Local Persistent Volume

* 适用范围非常固定
	- 高优先级的系统应用，需要在多个不同节点上存储数据，并且对 I/O 较为敏感
	- 典型的应用包括：分布式数据存储比如 MongoDB、Cassandra 等，分布式文件系统比如 GlusterFS、Ceph 等，以及需要在本地磁盘上进行大量数据缓存的分布式应用
* 相比于正常的 PV，一旦这些节点宕机且不能恢复时，Local Persistent Volume 的数据就可能丢失。这就要求使用 Local Persistent Volume 的应用必须具备数据备份和恢复的能力，允许把这些数据定时备份在其他位置
* 如何把本地磁盘抽象成 PV
	- 绝不应该把一个宿主机上的目录当作 PV 使用。这是因为，这种本地目录的存储行为完全不可控，它所在的磁盘随时都可能被应用写满，甚至造成整个宿主机宕机。而且，不同的本地目录之间也缺乏哪怕最基础的 I/O 隔离机制
	- 一个 Local Persistent Volume 对应的存储介质，一定是一块额外挂载在宿主机的磁盘或者块设备（“额外”的意思是，它不应该是宿主机根目录所使用的主硬盘）。这个原则，可以称为“一个 PV 一块盘”
* 调度器如何保证 Pod 始终能被正确地调度到它所请求的 Local Persistent Volume 所在的节点上呢
	-  Local PV 来说，节点上可供使用的磁盘（或者块设备），必须是运维人员提前准备好的。它们在不同节点上的挂载情况可以完全不同，甚至有的节点可以没这种磁盘
	-  在调度的时候考虑 Volume 分布”。在 Kubernetes 的调度器里，有一个叫作 VolumeBindingChecker 的过滤条件专门负责这个事情。在 Kubernetes v1.11 中，这个过滤条件已经默认开启了
*  延迟绑定:到调度的时候
*  手动创建 PV 的方式，即 Static 的 PV 管理方式，在删除 PV 时需要按如下流程执行操作
	-  删除使用这个 PV 的 Pod
	-  从宿主机移除本地磁盘（比如，umount 它）
	-  删除 PVC
	-  删除 PV。
*  Container Storage Interface（CSI） 插件体系的设计思想，就是把这个 Provision 阶段，以及 Kubernetes 里的一部分存储管理功能，从主干代码里剥离出来，做成了几个单独的组件。
	-  会以 gRPC 的方式对外提供三个服务（gRPC Service）
		+  CSI Identity
		+  CSI Controller
		+  CSI Nod


```sh
# 在node-1上执行
mkdir /mnt/disks
for vol in vol1 vol2 vol3; do
    mkdir /mnt/disks/$vol
    mount -t tmpfs $vol /mnt/disks/$vol
done
```
```
# The connection to the server localhost:8080 was refused - did you specify the right host or port?

sudo mkdir ~/.kube
sudo cp /etc/kubernetes/admin.conf ~/.kube/
cd ~/.kube
sudo mv admin.conf config
sudo service kubelet restart
```
