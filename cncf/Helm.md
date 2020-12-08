# [Helm](https://github.com/helm/helm)

The package manager for Kubernetes <https://helm.sh/>

## 概念

* chart：包含了创建Kubernetes的一个应用实例的必要信息
* config：包含了应用发布配置信息
* release：是一个chart及其配置的一个运行实例

## 功能

* 创建新的chart
* chart打包成tgz格式
* 上传chart到chart仓库或从仓库中下载chart
* 在Kubernetes集群中安装或卸载chart
* 管理用Helm安装的chart的发布周期

## 组件

* Helm Client是用户命令行工具，采用go语言编写，采用gRPC协议与Tiller server交互
    - 本地chart开发
    - 仓库管理
    - 与Tiller sever交互
    - 发送预安装的chart
    - 查询release信息
    - 要求升级或卸载已存在的release
* Tiller Server是一个部署在Kubernetes集群内部的server，其与Helm client、Kubernetes API server进行交互。采用go语言编写，提供了gRPC server与client进行交互，利用Kubernetes client 库与Kubernetes进行通信，当前库使用了REST+JSON格式。
    - 监听来自Helm client的请求
    - 通过chart及其配置构建一次发布
    - 安装chart到Kubernetes集群，并跟踪随后的发布
    - 通过与Kubernetes交互升级或卸载chart

## 原理

* 使用的是一种叫做charts的yaml文件
* charts被设计的便于创建和维护，它们可以互相共享并用于发布Kubernetes。charts包含说明文件以及至少一个模板，其中模板包含了Kubernetes清单文件。它们可以多次部署重复使用。如果多次安装同一个charts，则将创建一个新的版本
* install A release name that you pick, and the name of the chart you want to install.

## 部署及其应用

* 部署efk日志收集系统

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

## 配置

| Linux            | $HOME/.cache/helm         | $HOME/.config/helm             | $HOME/.local/share/helm |
| macOS            | $HOME/Library/Caches/helm | $HOME/Library/Preferences/helm | $HOME/Library/helm      |
| Windows          | %TEMP%\helm               | %APPDATA%\helm                 | %APPDATA%\helm

* [helm/charts](https://github.com/helm/charts):Curated applications for Kubernetes

## 参考

* [](https://hub.kubeapps.com/)
* [Helm Hub ](https://hub.helm.sh/):Discover & launch great Kubernetes-ready apps
