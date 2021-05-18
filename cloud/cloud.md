# 云服务

## 过程

* PaaS (Platform as a Service)
  - Google App Engine（简称GAE）：允许用自己喜欢的语言如Java, Python来开发应用程序，然后部署到GAE上运行，完全不用考虑应用程序的伸缩问题，GAE可以帮助你从0扩展到全球规模。
* [IaaS Infrastructure as a Service](./iaas.md)：计算，存储，数据库，队列，或者是虚拟机， AWS
* 微服务
  - Netflix不但在生产环境大规模使用微服务， 还为Spring Cloud贡献了大量的、著名的开源组件，包括Eureka， Hystrix， Zuul ，Ribbon 等，可以说是功勋卓著。
* Service Mesh 说：现在在微服务的执行过程中，需要一个依赖库，实现微服务的发现，监控和保护， 这个依赖库和和业务密切绑定,把依赖库和业务剥离开.Google趁机落子，和IBM等大佬提出了一个Service Mesh的框架，叫做Istio
* Google还有gRPC来进行微服务之间的调用，支持多语言，多种平台，并且面向HTTP/2.
* Google提出的序列化协议是Protocol Buffers，这个序列化机制也是语言中立，平台中立的，性能高，数据传输过程中压缩得比较小。

## 本地优先（local-first）

* 云应用（Cloud apps），也可以将它们称为“ SaaS ”或“基于 Web 的应用程序”。它们的共同点是，通常通过 Web 浏览器或移动应用访问它们，将数据存储在服务器上。
  - 投入了大量的创造力和努力去做某件事时，往往对它会有深刻的情感依恋。通常会生成文件和数据：文档、演示文稿、电子表格、代码、注释、绘图等。我们会保留这些数据作为参考和灵感包含在将来的产品组合中，或者只是因为感到自豪而进行归档。感受到数据的所有权非常重要，因为创造性的表达是非常个人化的。
  - 没有什么云，它只是别人的电脑：所有数据访问都必须通过服务器进行，并且只能执行服务器允许的操作。从某种意义上说，我们并不拥有数据的完全所有权，云提供商也是如此。
  - 云应用作为服务被提供，如果服务不可用，则无法使用该软件，并且无法再访问使用该软件创建的数据。如果服务关闭，即使可以导出数据，但没有服务器，通常也无法继续运行自己的软件副本。
* 老式的应用程序中，数据保存在本地磁盘上的文件中，因此我们对这些数据拥有完全的代理权和所有权：可以做任何自己喜欢的事情，包括长期存档、备份、使用其他程序操作文件，或者删除不再需要的文件。不需要任何人的许可来访问文件，因为它们是你的，不必依赖由其他公司操作的服务器
* 云应用中，服务器上的数据被视为数据的主要可信副本；如果客户端有数据的副本，则它仅仅是从属于服务器的高速缓存。任何数据修改都必须发送到服务器，否则“没有发生”。
* 在本地优先的应用中，我们互换了这些角色：将本地设备（笔记本电脑、平板电脑或手机）上的数据视为主要副本。服务器仍然存在，但它们保存数据的辅助副本，来帮助从多个设备进行访问。

## 理念

* 无需等待：立即工作
  - 网络延时：一些用户输入（例如，点击按钮或按键）和显示器上出现相应结果之间经常存在明显的延迟。全球各地 AWS 数据中心之间的服务器到服务器往返时间， [高可用的事务：优点和局限性](https://arxiv.org/pdf/1302.0309.pdf)
  - 云应用，由于数据的主要副本在服务器上，因此所有数据修改和许多数据查找都需要往返于服务器,光速就限制了软件的速度
  - 即使请求仍在进行中，用户界面可能会试图通过将操作显示为已完成来隐藏该延迟（一种称为乐观 UI的模式），但在请求完成之前，始终存在失败的可能性（例如，由于不稳定的 Internet 连接）。因此，乐观的 UI 有时仍然会在发生错误时暴露网络往返的延迟。
  - 本地优先的软件是不同的：因为它将数据的主副本保存在本地设备上，所以用户永远不需要等待对服务器的请求的完成。所有操作都可以通过在本地磁盘上读写文件来处理，与其他设备的数据同步在后台安静地进行。
* 工作不会被困在一台设备上
  - 有必要在用户进行工作的所有设备上同步这些数据
* 多选的网络
  - 本地优先的应用将数据的主副本保存在每个设备的本地文件系统中的文件中，因此用户可以随时读取和写入这些数据，即使在离线时也是如此。然后，当网络连接可用时，数据将与其他设备同步。数据同步不一定需要通过互联网：本地优先的应用也可以使用蓝牙或本地 WiFi 将数据同步到附近的设备。
* 与同事无缝协同
  - 处理冲突
    + Google Docs 通过建议模式支持这种工作流，并且在 Git 中通过拉取请求实现此目的
* 永远是最新
  - 数据所有权的重要性之一，是将来可以长时间继续访问数据
  - 即使是长期使用的软件，也存在价格或功能以我们不喜欢的方式发生变化的风险。并且对于云应用来说，继续使用旧版本不是一种选择 – 无论喜欢与否，都会被升级
    + 我们的一个博客就是让人难以置信的旅程，记录了创业产品在收购后被关闭的情况
* 默认的安全和隐私
  - Google 云端服务条款：“我们的自动系统会分析您的内容，为您提供个人相关的产品功能，如自定义搜索结果、垃圾邮件和恶意软件检测。”
  - 本地优先的应用在内核中具有更好的隐私和安全性。本地设备只存储自己的数据，避免了集中的云数据库来保存每个人的数据。本地优先应用可以使用 *端到端加密，* 这样存储文件副本的任何服务器都只能保存而无法读取的加密数据。
    + iMessage，WhatsApp和Signal等现代消息传递应用已经使用端到端加密，Keybase提供加密文件共享和消息传递，Tarsnap采用这种方法进行备份。我们希望看到这种趋势也扩展到其他类型的软件。
* 保留最终控制权
  - 通过云应用程序，服务提供商（而非个人）对个人可以做的事情有最终发言权。
  - 在本地优先应用中，我们可以做的只受物理定律的约束，而不受任何服务条款的约束。
  - 根据欧洲人权公约，自由的思想和观点是无条件的 — 国家永远不会干扰它，因为它是你自己的 — 而表达自由（包括言论自由），可以在某些方面受到限制，因为它影响到其他人。社交网络这样的传播服务传递着表达方式，但创意人的原始笔记和未发表的作品是一种发展思想和观点的方式，因此需要无条件的保护。

## 块存储

## 对象存储

## [Facebook、谷歌、微软和亚马逊的网络架构](https://mp.weixin.qq.com/s/MPBk9wdYsE48H7OXWAd5bA)

* Facebook Network
  - 针对不同任务划分成不同层次并采用不同的技术：遍布在用户密集区的数量庞大的PoP/LB/cache通过骨干网作为偏远地区、低成本、数量可控的超大型数据中心的延伸
    + 边缘（edge）
    + 骨干（backbone）
    + 数据中心（data centers）
  - 流量模型
    + 外部流量：到互联网的流量（Machine-to-User）
    + 内部流量：数据中心内部的流量（Machine-to-Machine）
  - 将跨数据中心与面向 Internet 的流量分离到不同的网络中，并分别进行优化
  - 骨干网 EBB（Express Backbone）
    + 理念
      * 快速演进、模块化、便于部署
      * 避免分布式流量工程（基于 RSVP-TE 带宽控制）的问题，例如带宽利用率低，路由收敛速度慢。
      * 在网络的边缘利用 MPLS Segment Routing 保证网络的精确性。
    + 架构
      * BGP 注入器：集中式的 BGP 注入路由的控制方式。
      * sFlow 收集器：采集设备的状态传递给流量工程控制器。
      * Open / R：运行在网络设备上，提供 IGP 和消息传递功能。
      * LSP 代理（agent）：运行在网络设备上，代表中央控制器与设备转发表对接。
    + 流量工程控制平面（Traffic Engineering Controller）
      * NetworkStateSnapshot module：网络状态快照模块，负责构建活动的网络状态和流量矩阵
      * PathAllocation module：路径分配模块，负责基于活动流量矩阵并满足某些最优性标准来计算抽象源路由。
      * Drivermodule：驱动程序模块，负责将路径分配模块计算出的源路由以 MPLS 段路由的形式推送到网络设备。
  - 面向互联网出口的边缘网络架构Edge Fabric:A PoP has Peering Routers, Aggregation SWitches, and servers.A private WAN connects to datacenters and other PoPs。
    + Edge Fabric 有一个 SDN/BGP 控制器。
    + SDN 控制器采用多重方式搜集网络信息，如 BMP 采集器、流量采集器等。
    + 控制器基于实时流量等相关信息，来产生针对某个 Prefix 的最优下一跳，指导不同 Prefix 在多个设备之间负载均衡。
    + 控制器和每个 Peering Router 建立另一个 BGP 控制 session，每隔特定时间用来改写 Prefix，通过调整 Local Preference 来改变下一跳地址。
    + BGP 不能感知网络质量，Edge Server 对特定流量做 eBPF 标记 DSCP，并动态随机选一小部分流量来测量主用和备用 BGP 路径的端到端性能。调度发生在 PR 上，出向拥塞的 PR 上做 SR Tunnel 重定向到非拥塞的 PR 上
    + 限制：
      - SDN 控制器单点控制 PR 设备。如果 PR 设备已经 Overload，需要通过 PBR 和 ISIS SR Tunnel 转移到另一个没有拥塞的 PR，流量路径不够全局优化。
      - 控制器只能通过 Prefix 来控制流量，但是同一个 prefix，可能承载视频和 Voice 流量，带宽和时延要求不同，Edge Fabric 没有 Espresso 那么灵活。
  - 在骨干网、边缘网络都是使用 BGP 路由协议进行分布式控制，控制通道简单，避免多协议导致的复杂性，而对于流量工程采用集中的处理。
* Google Network
  - 从 Google 数据中心信息大致经过 Data Center-POP-Cache 三级网络发送到最终用户
  - 广域网实际上分为 B2 全球骨干网和 B4 数据中心互联网
    + B2：面向用户的骨干网，用于连接 DC、CDN、POP、ISPs 等。B2 主要承载了面向用户的流量，和少部分内部流量（10%），带宽昂贵，整体可用性要求很高，利用率在 30%~40%之间。B2 采用商用路由器设备，并且运行 MPLS RSVP-TE 进行流量工程调节。
      * PR：Peering Router，对等路由器，类似 PE 设备，主要是其他运营商网络进行对接。
      * BR：Backbone Router，骨干网路由器，类似 P 设备。
      * LSR：Label Switch Router，标签交互路由器。
      * DR：Datacenter Route：数据中心路由器。
    + B4：数据中心内部数据交换的网络，网络节点数量可控，带宽庞大，承载的 Google 数据中心间的大部分流量。B4 承载的业务容错能力强，带宽廉价，整体利用率超过 90%。使用自研交换机设备，为 Google SDN 等新技术的试验田。
      * 交换机硬件是 Google 定制的，负责转发流量，不运行复杂的控制软件。
      * OpenFlow Controller (OFC) 根据网络控制应用的指令和交换机事件，维护网络状态。
      * Central TE Server 是整个网络逻辑上的中心控制器。
      * Central TE (Traffic Engineering) Server：进行流量工程。
     * Network Control Server (NCS)：数据中心（Site）的控制器，其上运行着 OpenFlow Controller (OFC) 集群，使用 Paxos 协议选出一个 master，其他都是热备。
     * 交换机（switch）：运行着 OpenFlow Agent (OFA)，接受 OFC 的指令并将 TE 规则写到硬件 flow-table 里。
  - 边缘网络是 Espresso，数据中心内部则是 Jupiter
    + Espresso：边缘网络或者互联网出口网络，将 SDN 扩展到 Google 网络的对等边缘，连接到全球其他网络，使得 Google 根据网络连接实时性的测量动态智能化地为个人用户提供服务。
    + 为了更好进行流量调度，Espresso 引入了全球 TE 控制器和本地控制器（Location Controller）来指导主机（host）发出流量选择更好的外部 Peering 路由器/链路，进行 per flow Host 到 Peer 的控制，并且解耦了传统 Peering 路由器，演进为 Peering Fabric 和服务器集群（提供反向 Web 代理）
    + 控制和转发流程：
      - 外部系统请求进入 Espresso Metro，在 Peering Fabric 上被封装成 GRE，送到负载均衡和反向 web 代理主机处理。如果可以返回高速缓存上的内容以供用户访问，则该数据包将直接从此处发回。如果 CDN 没有缓存，就发送报文通过 B2 去访问远端数据中心。
      - 主机把实时带宽需求发送给全局控制器（Global Controller）。
      - 全局控制器根据搜集到的全球 Internet Prefix 情况，Service 类型和带宽需求来计算调整不同应用采用不同的 Peering 路由器和端口进行转发，实现全局出向负载均衡。
      - 全局控制器通知本地控制器来对 host 进行转发表更改。同时在 Peering Fabric 交换机上也配置相应的 MPLSoGRE 解封装。
      - 数据报文从主机出发，根据全局控制器指定的策略，首先找到 GRE 的目的地址，Peering Fabric 收到报文之后，解除 GRE 报文头。根据预先分配给不同外部 Peering 的 MPLS 标签进行转发。
* Amazon Global Network
  - 构成 AWS Global Infrastructure 组件
    + Availability Zones (AZs)
      * 每个 AZ 至少会有一个位于同一区域内的其他 AZ，通常是一个城市，他们之间由高弹性和极低延迟的专用光纤连接相连。
      * 但是，每个 AZ 将使用单独的电源和网络连接，这使得 AZ 之间相互隔离，以便在单个 AZ 发生故障时最大限度地减少对其他 AZ 的影响。
    + Regions
      * 由 Availability Zone 组成。可用区(Availability Zones)实质上是 AWS 的物理数据中心。在 VPC 中创建的计算资源、存储资源、网络资源和数据库资源都是托管在 AWS 的物理数据中心。
      * 每个 Region 有两个 Transit Center，每个 Transit Center 和下面的每个 Datacenter 都有网络互联，同样 Datacenter 之间也有网络互联，这样可以确保 AWS 网络的可用性，部分网络基础设施故障也不会影响整个 Region 的可用性。
      * Region 数据中心: 采用蜂窝式的网络架构
        - 每个模块都有不同的一些功能
        - 每个 Cell 都肩负着不同的功能，Cell 和 Cell 之间都进行互联，在每一层，都可以通过平行扩展 Cell 来扩展整个网络的承载量，达到一个可伸展的网络。
        - 每个 Cell 是一个单核路由器，端口比较少，可以控制故障域，转发架构更简单。
    + Edge PoPs
      * 部署在全球主要城市和人口稠密地区的 AWS 站点。它们远远超过可用区域的数量。
      * 对外就是连接的一张张 ISP 的网络。运营商接入 AWS 的骨干网络两个地方，一个是 Edge PoPs，另外一个 AWS 区域的网络中转中心（Transit Centers）
      * Edge PoP 很大的一个作用就是对外扩充 AWS 的网络，同一个 Edge PoP 可以和运营商进行多次互联，获得至外网网络最优的互联。
      * 边缘站点也是采用了蜂窝式的架构，Backbone Cell 连接 AWS 骨干网络，External Internet Cell 连接外部的 Internet 网络，同时还包括一些 AWS Edge 服务网的一些 Cell，如连接 CloudFront、Route 53、Direct Connect 和 AWS Shield，这些服务都存在于 AWS Edge PoPs 中。
      * Regional Edge Caches
  - 理念
    + 安全性：安全是云网络的生命线。
    + 可用性：需要保证当某条线路出现故障的时候，不会影响整个网络的可用性。
    + 故障强隔离：当网络发生故障的时候，尽量把故障限制在某个区域内。
    + 蜂窝架构：一个个网络模块构成的蜂窝式网络架构。
    + 规模：支撑上百万客户的应用网络需求。
    + 性能：对网络的吞吐量、延迟要求较高。
  - 流量首先进入 Edge PoP，这个也是 CDN 的站点，流量进来之后到骨干网络 Backbone，然后再进入 AWS Region，经过 Transit Center 进入 AZ
  - AWS 全球骨干网（Global Backbone）
    + AWS Direct Connect、互联网连接、区域到区域传播和 Amazon CloudFront 到 AWS 服务的连接都是需要 AWS 骨干网
    + 也是采用了蜂窝式的一个网络架构，中间是大量的光纤连接，外层是负责一些网络功能的 Cell。
      * Transit Center Cell 用来连接 Region 内部的数据中心
      * Edge Pop Cell 用来连接 PoP 节点
      * Backbone Cell 用来连接远端的 PoP 节点进而连接到远端 Region 的数据中心
  - AWS 在网络的各部分都采用了蜂窝式的架构，让这个网络的扩展性大大提升。并且通过采用主动式数据信道监控，从 AWS 服务日志采集互联网性能数据，以及互联网流量工程管理来达到互联网边缘的监控与自我修复。
* Microsoft Network
  - 微软 SWAN 广域网 DCI 控制器也是一个典型的 SDN 网络，从最早的静态单层 MPLS Label 构造的端到端隧道，到最新的基于 BGP-TE SR 的全球 DCI 互联解决方案，可以实现 95%的跨数据中心链路利用率。
  - RSVP-TE/SR-TE。
  - 集中式 TE 资源分配算法。
  - 服务间通过资源分配模块协作。
  - 每个 Host 上都有代理，负责带宽请求和限流。

## 工具

* [capstone](https://www.inkandswitch.com/capstone-manuscript.html):an experimental tool for creative professionals to develop their ideas
* [softwarelibrary](https://archive.org/details/softwarelibrary)

## 服务商

* [aliyun](https://www.aliyun.com/)
  - 如果在意 “节点数量” 可选择安全宝。
  - 如果在意 “节点稳定性及 SEO 优化” 可选择百度云加速。
  - 如果在意 “是否免费” 可选择 360 卫士。
  - 如果在意 “功能均衡” 可选择加速乐。
* [Azure](https://www.azure.cn/en-us/)
  - [azure-auth-go](https://github.com/feiskyer/azure-auth-go):Go library for authorizing with Azure
  - [azure-docs](https://github.com/MicrosoftDocs/azure-docs):Open source documentation of Microsoft Azure <https://docs.microsoft.com/azure>
* Google Cloud Platform
  - [google-cloud-python](https://github.com/googleapis/google-cloud-python):Google Cloud Client Library for Python <https://googleapis.github.io/google-cloud-python/>
* [腾讯云](https://cloud.tencent.com/) `ssh -q -l ubuntu -p 22 IP`
* [搬瓦工](https://bandwagonhost.cn/)
* [Vultr](https://www.vultr.com/)
* [CloudCone](https://app.cloudcone.com/)
* [Oracle cloud](https://www.oraclecloud.com):免费资源 <https://51.ruyo.net/14138.html>
  - 登录有传统 与 [cloud]() 用户
  - centos  默认登录账户是 opc,支持以 sudo 执行,不要密码
  - ubuntu 默认登录账户是 ubuntu
  - 与搬瓦工的CN2 GIA-E不分上下
* [awesome-saas-services](https://github.com/GetStream/awesome-saas-services):A curated list of the best in class SaaS services for developers and business owners.
* [LeanCLoud](https://leancloud.cn/)
  - [leancloud/ticket](https://github.com/leancloud/ticket)
* [QiNiu](https://www.qiniu.com/)
* [Pivotal](http://pivotal.io):建立在VMware Cloud Foundry上，可以在本地运行，也可以在云端运行。应用程序可以扩展到几百个实例，它随带诸多服务，比如负载均衡、自动化健康管理、日志及审计以及自动化配置。
* [ibm](https://cloud.ibm.com)
* [华为云](https://www.huaweicloud.com/)

## 参考

* [](https://chengpengzhao.com/2020-08-03-vps-neng-yong-lai-zuo-shi-me/)
