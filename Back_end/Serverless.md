# Serverless

* 一个“函数”真的只做一件事情，并且不保持状态。 这样一来它可以轻松地被扩展到任意多的服务器/虚拟机/docker容器中去。服务器对用户来说是透明的。 应用的装载、启动、卸载，路由是需要平台来搞定
* 适合那些无状态的应用，例如图像和视频的加工，转换， 物联网设备状态的信息处理等等
* 想持久化的东西必须得保存到外部的系统或者存储中，例如Redis，MySQL等。 很明显，这些东西也应该以“服务”的方式来呈现，即Backend as a Service (BaaS)。

## 特点

* 程序员编写完成业务的函数代码
* 上传到支持Serverless的平台，设定触发的规则。
* 请求到来，Serverless平台根据触发规则加载函数，创建函数实例，运行
* 如果请求比较多，会进行实例的扩展，如果请求较少，就进行实例的收缩。
* 如果无人访问，卸载函数实例。

## 工具

* [openfaas/faas](https://github.com/openfaas/faas):OpenFaaS - Serverless Functions Made Simple https://docs.openfaas.com/
* [firecracker-microvm/firecracker](https://github.com/firecracker-microvm/firecracker):Secure and fast microVMs for serverless computing. http://firecracker-microvm.io
* [awslabs/serverless-application-model](https://github.com/awslabs/serverless-application-model):AWS Serverless Application Model (AWS SAM) prescribes rules for expressing Serverless applications on AWS.
