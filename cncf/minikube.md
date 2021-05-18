# [minikube](https://github.com/kubernetes/minikube)

* Run Kubernetes locally <https://minikube.sigs.k8s.io/>
* Minikube is a small setup by Kubernetes guys, which will spawn a virtual machine and have a tiny (but fully functional) Kubernetes cluster inside the VM.
* kubectl is the command line client you’ll use to connect to the Kubernetes cluster

## 配置

* config file: `~/.kube/`
  -  registry.cn-hangzhou.aliyuncs.com/google_containers
* all the virtual machine bits:`~/.minikube/`
* 启动参数
  - export http_proxy 添加命令行代理，让minikube可以在命令行通过proxy去下载相关文件
  - `--docker-env http_proxy...` 设置虚拟机中docker daemon的环境变量，这里的环境变量http_proxy表示虚拟机中docker daemon使用的代理
  - --docker-env no_proxy，设置虚拟机中docker daemon不使用代理的地址段
  - --log_dir=tmp，设置minikube的日志存储位置，这里是当前目录下的tmp文件夹。该目录下会出现INFO和ERROR的日志，INFO是一定会有，ERROR是出错的时候才有。比如
  - --cpus 4，设置虚拟机的cpu核数
  - --memory 8192 设置虚拟机的内存大小，单位为M
  - --driver=*** 从1.5.0版本开始，Minikube缺省使用本地最好的驱动来创建Kubernetes本地环境，测试过的版本 docker, kvm
  - --image-mirror-country cn 将缺省利用 registry.cn-hangzhou.aliyuncs.com/google_containers 作为安装Kubernetes的容器镜像仓库 （阿里云版本可选）
  - --iso-url=*** 利用阿里云的镜像地址下载相应的 .iso 文件 （阿里云版本可选）
  - --registry-mirror=https://xxxxxx.mirror.aliyuncs.com 为拉取Docker Hub镜像，需要为 Docker daemon 配置镜像加速，参考阿里云镜像服务
  - --cpus=2: 为minikube虚拟机分配CPU核数
  - --memory=2048mb: 为minikube虚拟机分配内存数
  - --kubernetes-version=***: minikube 虚拟机将使用的 kubernetes 版本
  - --vm-driver
* start 功能
  - 创建 minikube的虚拟机，并在虚拟机中安装Docker容器运行时
  - 下载Kubeadm与Kubelet工具
  - 通过Kubeadm部署Kubernetes集群
  - 进行各组件间访问授权、健康检查等工作
  - 在用户操作系统安装并配置kubectl
* Environment variables
  - Exclusive environment tunings
    + MINIKUBE_HOME - (string) sets the path for the .minikube directory that minikube uses for state/configuration. Please note: this is used only by minikube and does not affect anything related to Kubernetes tools such as kubectl.
    + MINIKUBE_IN_STYLE - (bool) manually sets whether or not emoji and colors should appear in minikube. Set to false or 0 to disable this feature, true or 1 to force it to be turned on.
    + MINIKUBE_WANTUPDATENOTIFICATION - (bool) sets whether the user wants an update notification for new minikube versions
    + MINIKUBE_REMINDERWAITPERIODINHOURS - (int) sets the number of hours to check for an update notification
    + CHANGE_MINIKUBE_NONE_USER - (bool) automatically change ownership of ~/.minikube to the value of $SUDO_USER
    + MINIKUBE_ENABLE_PROFILING - (int, 1 enables it) enables trace profiling to be generated for minikube
  - Making environment values persistent:Add these declarations to ~/.bashrc

```sh
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew cask install virtualbox
# To check if virtualization is supported on macOS, run the following command on your terminal
sysctl -a | grep -E --color 'machdep.cpu.features|VMX'

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

brew install minikube

# to fix sudo /sbin/vboxconfig
minikube start --help
minikube config set driver hyperkit
minikube config --help
minikube config view

# Modifying Kubernetes defaults
minikube start --extra-config=apiserver.v=10 --extra-config=kubelet.max-pods=100
minikube start --extra-config=kubeadm.ignore-preflight-errors=SystemVerification

# Runtime configuration
minikube start --container-runtime=docker|containerd|cri-o

minikube start --registry-mirror=https://registry.docker-cn.com
minikube start --vm-driver=virtualbox|parallels|vmwarefusion|hyperkit|vmware --disk-size='10g'  --image-mirror-country='cn' --image-repository='registry.cn-hangzhou.aliyuncs.com/google_containers'
minikube start --registry-mirror=https://registry.docker-cn.com --kubernetes-version v1.12.1
minikube start --memory=8192 --cpus=4 --disk-size=20g  --registry-mirror=https://docker.mirrors.ustc.edu.cn --kubernetes-version=v1.12.5 --docker-env http_proxy=http://192.168.0.40:8123 --docker-env https_proxy=http://192.168.0.40:8123 --docker-env no_proxy=localhost,127.0.0.1,::1,192.168.0.0/24,192.168.99.0/24
minikube start --vm-driver=virtualbox --registry-mirror=https://registry.docker-cn.com --image-mirror-country=cn --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers
minikube start --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers
minikube.exe start --image-mirror-country cn \
    --iso-url=https://kubernetes.oss-cn-hangzhou.aliyuncs.com/minikube/iso/minikube-v1.5.0.iso \
    --registry-mirror=https://xxxxxx.mirror.aliyuncs.com \
    --vm-driver="hyperv" \
    --hyperv-virtual-switch="MinikubeSwitch" \
    --memory=4096
minikube start --image-mirror-country='cn' --image-repository='registry.cn-hangzhou.aliyuncs.com/google_containers'

minikube start --vm-driver=virtualbox
minikube start  --image-mirror-country='cn' --image-repository='registry.cn-hangzhou.aliyuncs.com/google_containers'
 minikube start --vm-driver=none --registry-mirror=https://registry.docker-cn.com

# 更新集群
minikube start --kubernetes-version=latest

minikube docker-env|stop|status
# 删除现有虚机，删除 ~/.minikube 目录缓存的文件
minikube delete
rm -rf  ~/.minikube

# E1211 16:50:42.913765   43824 cache_images.go:80] CacheImage k8s.gcr.io/k8s-dns-sidecar-amd64:1.14.13 -> /Users/henry/.minikube/cache/images/k8s.gcr.io/k8s-dns-sidecar-amd64_1.14.13 failed: fetching image: Get https://k8s.gcr.io/v2/: dial tcp [2404:6800:4008:c01::52]:443: i/o timeout
# Unable to load cached images: loading cached images: loading image /Users/henry/.minikube/cache/images/k8s.gcr.io/kube-scheduler_v1.16.2: stat /Users/henry/.minikube/cache/images/k8s.gcr.io/kube-scheduler_v1.16.2

# goole服务器，只能拉取国内的镜像
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/etcd:3.2.24
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/etcd:3.2.24 k8s.gcr.io/etcd:3.2.24


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
```

## 使用

```sh
kubectl cluster-info
kubectl config view
kubectl get node -o wide
minikube kubectl get po -A

minikube ssh|dashboard
minikube dashboard --url

docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/echoserver:1.10
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/echoserver:1.10 k8s.gcr.io/echoserver:1.10
docker rmi registry.cn-hangzhou.aliyuncs.com/google_containers/echoserver:1.10

# 创建部署
kubectl create deployment hello-minikube --image=k8s.gcr.io/echoserver:1.10
kubectl create deployment hello-minikube --image=registry.cn-hangzhou.aliyuncs.com/google_containers/echoserver:1.10
kubectl port-forward service/hello-minikube 7080:8080
# 将部署暴露为服务
kubectl expose deployment hello-minikube --type=NodePort --port=8080
# 查看服务
kubectl get pod
# 获取服务URL
minikube service list
kubectl get services hello-minikube
minikube service hello-minikube --url
kubectl get service <service-name> --output='jsonpath="{.spec.ports[0].nodePort}"'

# 删除服务
kubectl delete services hello-minikube
# 删除部署
kubectl delete deployment hello-minikube
kubectl delete -n default deployment hello-minikube
# 停止Minikube集群
minikube stop
# 删除Minikube集群
minikube delete
```

## addons

```sh
minikube addons list
minikube addons enable|disable heapster
minikube addons enable ingress
minikube start --addons <name1> --addons <name2>
minikube addons open <name>

# Config the Addon to Use Custom Registries and Images
minikube addons images efk
minikube cache add kibana/kibana:5.6.2-custom
minikube addons enable efk --images="Kibana=kibana/kibana:5.6.2-custom" --registries="Kibana=,Elasticsearch=192.168.10.2:5555,FluentdElasticsearch=192.168.10.2:5555"
```

## 集群

* containerd是一个行业标准的容器运行时，它强调简单性、健壮性和可移植性。它可以作为Linux和Windows的守护进程，以管理其主机系统的完整容器生命周期。
*

```sh
# 为了用containerd作为容器运行时
minikube start --network-plugin=cni \
  --enable-default-cni \
  --container-runtime=containerd \
  --bootstrapper=kubeadm
```
## LoadBalancer

```sh
minikube tunnel
kubectl create deployment hello-minikube1 --image=registry.cn-hangzhou.aliyuncs.com/google_containers/echoserver:1.10
kubectl expose deployment hello-minikube1 --type=LoadBalancer --port=8080
kubectl get svc
# Cleaning up orphaned routes
minikube tunnel --cleanup
```

## Dashboard


```sh
minikube dashboard
```

## Pushing images

*  Pushing directly to the in-cluster Docker daemon (docker-env)
  - `eval $(minikube docker-env)`
* Push images using ‘cache’ command，store the requested image to $MINIKUBE_HOME/cache/images, and load it into the minikube cluster’s container runtime environment automatically
  - `minikube cache list`
  - `minikube cache add|delete alpine:latest`
  - `minikube cache reload`
* Pushing directly to in-cluster CRI-O. (podman-env)
  - `eval $(minikube podman-env)`
  - `podman-remote build -t my_image .`
  - urn off the imagePullPolicy:Always (use imagePullPolicy:IfNotPresent or imagePullPolicy:Never), as otherwise Kubernetes won’t use images you built locally.
* Pushing to an in-cluster using Registry addon
  - `minikube addons enable registry`
  - `docker build --tag $(minikube ip):5000/test-img .`
  - `docker push $(minikube ip):5000/test-img`
* Building images inside of minikube using SSH
  - `docker|podman|buildctl build`
* Pushing directly to in-cluster containerd (buildkitd):This is similar to docker-env and podman-env but only for Containerd runtime.Currently it requires starting the daemon and setting up the tunnels manually.
  -  log in as root. This requires adding the ssh key to /root/authorized_keys
  - `minikube --alsologtostderr ssh --native-ssh=false`
  - `ssh -nNT -L ./containerd.sock:/run/containerd/containerd.sock ... &`

```sh
code
```

## 参考

* [Hello Minikube](https://kubernetes.io/docs/tutorials/hello-minikube/)
