# [helm/helm](https://github.com/helm/helm)

The Kubernetes Package Manager https://helm.sh

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
