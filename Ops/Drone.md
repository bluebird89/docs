# [Drone](https://drone.io)

Automate Software Testing and Delivery

## 插件

drone中提供了三个kube-helm插件，用来配合drone，实现k8s的cicd

* [rone-kube](http://plugins.drone.io/vallard/drone-kube/)
* [drone-kubernetes](http://plugins.drone.io/mactynow/drone-kubernetes/)
* [helm](http://plugins.drone.io/ipedrazas/drone-helm/)

### 流程

* 编写自己的.drone.yaml,放置到项目根目录下。主要就是引用各种pipeline插件，例如默认添加的git拉取代码的插件，项目编译环境的插件，此处针对不同语言，可以定制不同的镜像，例如我们之前的项目会把common这种基础库也做到docker镜像里，可以提高构建速度。以及telegram，line，mail等通知插件。
* 提交代码到github或是gogs等版本控制工具里，触发webhook钩子，通知drone执行整个设计的构建流程。该项目中，需要另外两个插件，一个是docker镜像，用于将编译好的程序做成镜像，并推到自己的docker registry中。所以需要在根目录下，编写自己的DockerFile文件。另外一个是上面提到的helm插件。
* docker hub由于墙的原因，这边一般是使用harbor，vmware中国团队基于docker registry做出来的私有镜像仓库。
* helm可以选用k8s官方的公共仓库(https://github.com/kubernetes/charts)，一般都会搭建一个自己私仓，结合起来使用。
* 新的镜像推到harbor之后，helm插件就可以执行部署步骤了。
* 最后一般都会引用通知插件，将构建结果通知部署人员。
