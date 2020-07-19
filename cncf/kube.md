# Kube

## 概念

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
* PodPreset 里定义的内容，只会在 Pod API 对象被创建之前追加在这个对象本身上，而不会影响任何 Pod 的控制器的定义
	- 多个 PodPreset:合并（Merge）这两个 PodPreset 要做的修改。而如果它们要做的修改有冲突的话，这些冲突字段就不会被修改
* Deployment
	- 操纵 ReplicaSet 对象，而不是 Pod,实现版本更新,两层控制器
		+ 通过 ReplicaSet 的个数来描述应用的版本
		+ 通过 ReplicaSet 的属性（比如 replicas 的值），来保证 Pod 的副本数量
	- 一个 ReplicaSet 对象，由副本数目的定义和一个 Pod 模板组成的
	- 滚动更新
	- template :PodTemplate（Pod 模板）
	- 怎么多版本共存
* Service ：来将一组 Pod 暴露给外界访问的一种机制
	- 访问
		+ 以 Service 的 VIP（Virtual IP，即：虚拟 IP）方式
		+ 以 Service 的 DNS 方式
			* Normal Servic：访问“my-svc.my-namespace.svc.cluster.local”解析到的正是 my-svc 这个 Service 的 VIP，后面的流程就跟 VIP 方式一致了
			* Headless Service：访问“my-svc.my-namespace.svc.cluster.local”解析到的，直接就是 my-svc 代理的某一个 Pod 的 IP 地址。不需要分配一个 VIP，而是可以直接以 DNS 记录的方式解析出被代理 Pod 的 IP 地址
	- Headless Service 所代理的所有 Pod 的 IP 地址，都会被绑定一个格式 `<pod-name>.<svc-name>.<namespace>.svc.cluster.local>` DNS
* StatefulSet
	- 一种特殊的 Deployment，而其独特之处在于，它的每个 Pod 都被编号了。而且，这个编号会体现在 Pod 的名字和 hostname 等标识信息上，这不仅代表了 Pod 的创建顺序，也是 Pod 的重要网络标识（即：在整个集群里唯一的、可被访问的身份
* PV
	- PVC 和 PV 的设计，实际上类似于“接口”和“实现”的思想。开发者只要知道并会使用“接口”，即：PVC；而运维人员则负责给“接口”绑定具体的实现，即：PV
	- PVC 其实就是一种特殊的 Volume。只不过一个 PVC 具体是什么类型的 Volume，要在跟某个 PV 绑定之后才知道
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
* Dynamic Admission Control

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
kubeadm join 192.168.0.103:6443 --token ydcgf6.fe17yltme8a2tw9o   --discovery-token-ca-cert-hash sha256:d982f8d13c5f110edbd16716c5b3b2c406b9c1b8c91676a1647b432c3e0454c7

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

```
# The connection to the server localhost:8080 was refused - did you specify the right host or port?

sudo mkdir ~/.kube
sudo cp /etc/kubernetes/admin.conf ~/.kube/
cd ~/.kube
sudo mv admin.conf config
sudo service kubelet restart
```
## 插件

