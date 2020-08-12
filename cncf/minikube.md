# [kubernetes/minikube](https://github.com/kubernetes/minikube)

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

curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/darwin/amd64/kubectl"
chmod +x ./kubectl && sudo mv ./kubectl /usr/local/bin/kubectl

curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64
chmod +x minikube
sudo mv minikube /usr/local/bin
sudo install minikube /usr/local/bin/

brew install minikube

# t ofix sudo /sbin/vboxconfig

minikube start --registry-mirror=https://registry.docker-cn.com
minikube start --vm-driver=virtualbox|parallels|vmwarefusion|hyperkit|vmware --disk-size='10g'  --image-mirror-country='cn' --image-repository='registry.cn-hangzhou.aliyuncs.com/google_containers'
minikube start --registry-mirror=https://registry.docker-cn.com --kubernetes-version v1.12.1
minikube start --memory=8192 --cpus=4 --disk-size=20g  --registry-mirror=https://docker.mirrors.ustc.edu.cn --kubernetes-version=v1.12.5 --docker-env http_proxy=http://192.168.0.40:8123 --docker-env https_proxy=http://192.168.0.40:8123 --docker-env no_proxy=localhost,127.0.0.1,::1,192.168.0.0/24,192.168.99.0/24
minikube start --vm-driver=virtualbox --registry-mirror=https://registry.docker-cn.com --image-mirror-country=cn --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers
minikube start --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers

minikube start --vm-driver=virtualbox
minikube start  --image-mirror-country='cn' --image-repository='registry.cn-hangzhou.aliyuncs.com/google_containers'

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
kubectl get pods -A

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
