# minikube

* 可以在本地电脑上运行Kubernetes的工具
* 安装Minikubne前需要先安装kubectl，它是Kubernetes的命令行工具，可以使用kubectl部署应用程序，检查和管理集群资源以及查看日志

```sh
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/darwin/amd64/kubectl"
chmod +x ./kubectl && sudo mv ./kubectl /usr/local/bin/kubectl

curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && chmod +x minikube

sudo install minikube /usr/local/bin/

minikube start --vm-driver=virtualbox
minikube start  --image-mirror-country='cn' --image-repository='registry.cn-hangzhou.aliyuncs.com/google_containers'

minikube stop|delete|status|
kubectl get pods -A

# t ofix sudo /sbin/vboxconfig
```
