# Kube

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
		+ kube-controller-manager
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
	-  Deployment
	- DaemonSet
	- StatefulSet
	- ReplicaSet
	- Job


```sh
kubectl apply -f https://k8s.io/examples/application/deployment.yaml --record

kubectl run nginx --image nginx
kubectl create deployment nginx --image nginx

kubectl create -f nginx.yaml
kubectl delete -f nginx.yaml -f redis.yaml
kubectl replace -f nginx.yaml

kubectl diff -R -f configs/
kubectl apply -R -f configs/
```

## [k8s](https://rollout.io/blog/getting-started-with-kubernetes/)

```sh
curl https://get.k8s.io > kubernetes_install.sh
bash kubernetes_install.sh

kubectl
export KUBECONFIG=~/.kube/config
```

## kubeadm

```sh
kubeadmin init

kubeadm reset
```


```
# The connection to the server localhost:8080 was refused - did you specify the right host or port?

sudo mkdir ~/.kube
sudo cp /etc/kubernetes/admin.conf ~/.kube/
cd ~/.kube
sudo mv admin.conf config
sudo service kubelet restart
```
