# Serverless

* FaaS (function as a service).
* 一个“函数”真的只做一件事情，并且不保持状态。 这样一来它可以轻松地被扩展到任意多的服务器/虚拟机/docker容器中去。服务器对用户来说是透明的。 应用的装载、启动、卸载，路由是需要平台来搞定
* 适合那些无状态的应用，例如图像和视频的加工，转换， 物联网设备状态的信息处理等等
* 想持久化的东西必须得保存到外部的系统或者存储中，例如Redis，MySQL等。 很明显，这些东西也应该以“服务”的方式来呈现，即Backend as a Service (BaaS)。
* 公认的 Serverless 的定义，是 Serverless = FaaS + BaaS,FaaS 则让我们能够在云端编写、运行函数，并由这些云函数组成应用程序。
* FaaS 本身提供的只有运行函数的功能，并且每个函数的执行都是孤立和短暂的。但我们的应用程序，往往还需要持久存储和临时存储，以及在存储中进行数据管理，所以我们需要 BaaS。BaaS 就是一些列后端的功能的集合，比如云数据库、对象存储、消息队列、通知服务。没有这些 BaaS，函数的能力是非常有限的。整个 BaaS 也都由云供应商厂商提供，开发者不需要关心具体细节、实现，只需要在 FaaS 中使用 BaaS，这样才能构建整个应用。
* 优点
    - 按需提供无限计算资源
    - 消除云用户的前期承诺
    - 根据需要在短期内支付使用计算资源的能力
    - 由于许多非常大的数据中心，大规模降低成本的规模经济
    - 通过资源虚拟化简化操作并提高利用率
    - 通过复用来自不同组织的工作负载来提高硬件利用率
    - 无需运维：Serverless 架构的核心思想就是，构建和运行程序不需要管理服务器等底层资源。基于 Serverless 架构，应用的部署、扩容、备份、容灾、监控、日志等都不需要开发者关心，这些功能全都由云供应商提供。开发者就可以从以往繁琐的运维工作中解脱出来，专心实现自己的产品。
    - 低成本：传统的 Serverfull 架构，我们需要为资源付费。很多时候我们的云服务器等资源都是空闲的，但也需要计算费用，这就造成了不必要的浪费。但 Serverless 架构，我们只需要为计算付费。函数每执行一次，付一次的费用。比如阿里云函数计算、AWS Lambda、微软 Azure Function 等产品，定价几乎都是 1.33 元 / 百万次 的执行次数，0.00011108/GB-s 的运行时间，如果你的应用比较轻量，每个月的成本是非常低的。
    - 更简单：相比传统架构下的开发，基于 Serverless 架构的开发将变得更简单。云计算平台已经为我们提供了一系列的基础设施，我们只需要在此之上进行应用开发。传统架构，就犹如编程语言中的底层语言，如汇编，我们需要关心每一个细节，细致到 CPU 寄存器这样的级别。而基于 Serverless 的开发，就犹如 Node.js、Python 等高级语言，我们只需要专注于业务逻辑的实现，可以很高效地构建一个应用，并且这个应用天然就是弹性可伸缩的。
* 缺点
    - 函数的测试，因为 Serverless 函数往往依赖于第三方服务，如 FaaS 和 BaaS，我们很难对使用了这些服务器的函数进行测试。同时函数是事件驱动的，触发函数执行的事件，在本地也很难模拟。所以要能够方便地对 Serverless 函数进行测试，就需要我们在开发过程中，将函数的业务逻辑和所依赖的第三方服务分离，这样就可以编写单元测试对函数进行测试
    - 基于 Serverless 的应用严重依赖云服务。云服务的稳定性直接决定了业务的稳定性
    - 应用的多云部署或应用的迁移，也会比较麻烦。因为目前 Serverless 还没有一个统一标准，各个云供应商的 FaaS 和 BaaS 实现也不一样。所以当我们想要把 Serverless 应用从一个云服务迁移到另一个云服务，就会变得很困难。解决这个问题的方法，就是尽量让我们的业务代码和所依赖的云服务分离。这样迁移的时候，就只需要修改依赖云服务的相关代码。
    - 底层硬件资源的不确定性。由于云供应商可以灵活的选择底层服务器的规格和型号，这就导致了每个云函数运行的物理环境性能不尽相同。这种不确定性其实暴露了云供应商的背后的目的：他们想要最大化的平衡资源的使用和预算。
    - Warm startup

## 发展

* 最初的基于 JSP、PHP 等后端语言的模板渲染
* 基于 AJAX 的前后端分离
    - 前端的应用变得更加复杂，端也由 PC 端扩展到移动端、客户端甚至 IoT；
    - 后端应用也由单体应用转变为了微服务应用，接口变得更加原子化，前后端接口协调开始变得困难。
* BFF（Backend For Frontend）架构模式
* 前后端基于 Serverless 函数的协调

## 流程

* 程序员编写完成业务的函数代码
* 上传到支持Serverless的平台，设定触发的规则。
* 请求到来，Serverless平台根据触发规则加载函数，创建函数实例，运行
* 如果请求比较多，会进行实例的扩展，如果请求较少，就进行实例的收缩。
* 如果无人访问，卸载函数实例。

## 步骤

* 冷启动
    - 步骤
        + 下载代码
        + 启动容器
        + 启动运行环境
    - 优化
        - 选用合适的编程语言。因为 Java 等高级语言的冷启动时间大约是 Node.js、Python 等语言的 100 倍。
        - 为函数分配合适的内存。一般而言，内存越大，冷启动的时间越短。基于这点，开发者也可以为 Java 分配更大的内存，使其冷启动时间和 Node.js 一样短。但更大的内存意味着更多的支出。所以为函数选用合适的内存很重要
        - 重复利用函数的执行上下文。当一个事件来临，函数冷启动并执行之后，运行环境并不会立即被销毁，而是在一定时间内处于冷冻状态继续等待下一次函数执行。这也是 Serverless 服务平台的一个性能优化方案。基于这样的特点，我们就可以将数据库连接、临时文件等保存在执行上下文中，从而使函数无需在每次运行时都创建这些资源。
        - 对函数进行预热。可以通过定时对函数进行调用的方式，使函数一直处于“温暖”状态，从而避免真实请求到来时函数进行冷启动，进而达到提高性能的目的。
* 执行代码

## 选用nodejs

* Node.js 的足够简单、轻量
* Node.js 冷启动时间比 Java、C# 等编译型语言要低很多
* Serverless 对前端友好

## [Servessless framework](https://serverless.com)

Build apps with radically less overhead and cost

```sh
npm install serverless -g
serverless create --template hello-world

serverless deploy

http://xyz.amazonaws.com/hello-world
```

## 工具

* [openfaas/faas](https://github.com/openfaas/faas):OpenFaaS - Serverless Functions Made Simple https://docs.openfaas.com/
* [firecracker-microvm/firecracker](https://github.com/firecracker-microvm/firecracker):Secure and fast microVMs for serverless computing. http://firecracker-microvm.io
* [awslabs/serverless-application-model](https://github.com/awslabs/serverless-application-model):AWS Serverless Application Model (AWS SAM) prescribes rules for expressing Serverless applications on AWS.
* [Knative](https://knative.dev/)：
    - Build：在实现时，是表现为 Kubernetes 的 CRD，通过 yaml 文件来定义构建过程。这里引入了很多概念如：Build，Builder，Step，Template，Source等。另外支持用 Service Account 做身份验证
    - Serving：运行应用以对外提供服务，即提供服务、函数的运行时支撑
        + Kubernetes-based：基于k8s，也仅支持k8s，好处是可以充分利用k8s平台的能力
        + scale-to-zero：serverless 最重要的卖点之一，当然要强调
        + request-driven compute：请求驱动的计算
    - Eventing
    - [Knative ](https://www.ibm.com/developerworks/cn/opensource/os-knative-what-is-it-why-you-should-care/index.html)
    - [构建基于 Kubernetes 的现代化Serverless应用](https://www.servicemesher.com/getting-started-with-knative/knative-overview.html)
* [serverless/serverless](https://github.com/serverless/serverless):Serverless Framework – Build web, mobile and IoT applications with serverless architectures using AWS Lambda, Azure Functions, Google CloudFunctions & more! – https://serverless.com
* provider
    - AWS, Microsoft Azure, Google Cloud, IBM Cloud,

## 参考

* [phodal/serverless](https://github.com/phodal/serverless/):Serverless 架构应用开发指南 - Serverless Architecture Application Development Guide with Serverless Framework. https://serverless.ink
* [mnapoli/bref](https://github.com/mnapoli/bref):Serverless PHP on AWS Lambda https://bref.sh/
