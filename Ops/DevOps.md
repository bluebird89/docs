# Ops

## 服务优化

```sh
ps auxw|head -1;ps auxw|sort -rn -k4|head -40
```

## 问题

* top、iostat查看cpu、内存及io占用情况：内核、程序参数设置不合理。查看有没有报内核错误，连接数用户打开文件数这些有没有达到上限等等
* 链路本身慢：是否跨运营商、用户上下行带宽不够、dns解析慢、服务器内网广播风暴什么的
* 程序设计不合理：是否程序本身算法设计太差，数据库语句太过复杂或者刚上线了什么功能引起的
* 其它关联的程序引起的：如果要访问数据库，检查一下是否数据库访问慢
* 是否被攻击了：看服务器是否被DDos了等等
* 硬件故障：这个一般直接服务器就挂了，而不是访问慢

## 堡垒机

* 接入方式：
    - 透明桥方式接入网络
    - 旁路接入模式：请求通过堡垒机的权限检查后，堡垒机的应用代理模块将代替用户连接到目标设备完成该操作，之后目标设备将操作结果返回给堡垒机，最后堡垒机再将操作结果返回给运维操作人员。
        + 运维人员->堡垒机用户账号->授权->目标设备账号->目标设备
        + 管理员最重要的职责是根据相应的安全策略和运维人员应有的操作权限来配置堡垒机的安全策略。堡垒机管理员登录堡垒机后，在堡垒机内部，“策略管理”组件负责与管理员进行交互，并将管理员输入的安全策略存储到堡垒机内部的策略配置库中。
        + “应用代理”组件是堡垒机的核心，负责中转运维操作用户的操作并与堡垒机内部其他组件进行交互。“应用代理”组件收到运维人员的操作请求后调用“策略管理”组件对该操作行为进行核查，核查依据便是管理员已经配置好的策略配置库，如此次操作不符合安全策略“应用代理”组件将拒绝该操作行为的执行。
        + 运维人员的操作行为通过“策略管理”组件的核查之后“应用代理”组件则代替运维人员连接目标设备完成相应操作，并将操作返回结果返回给对应的运维操作人员；同时此次操作过程被提交给堡垒机内部的“审计模块”，然后此次操作过程被记录到审计日志数据库中。
        + 最后当需要调查运维人员的历史操作记录时，由审计员登录堡垒机进行查询，然后“审计模块”从审计日志数据库中读取相应日志记录并展示在审计员交互界面上。

## 开发工具

版本控制&协作开发

* 版本控制系统 Git：Git是一个开源的分布式版本控制系统，用以有效、高速的处理从很小到非常大的项目版本管理。
* 代码托管平台 GitLab：GitLab是一个利用Ruby on Rails开发的开源应用程序，实现一个自托管的Git项目仓库，可通过Web界面进行访问公开的或者私人项目。
* 代码评审工具 Gerrit：Gerrit是一个免费、开放源代码的代码审查软件，使用网页界面。利用网页浏览器，同一个团队的软件程序员，可以相互审阅彼此修改后的程序代码，决定是否能够提交，退回或者继续修改。它使用Git作为底层版本控制系统。
* 版本控制系统 Mercurial：Mercurial是一种轻量级分布式版本控制系统，采用 Python 语言实现，易于学习和使用，扩展性强。
* 版本控制系统 Subversion：Subversion 是一个版本控制系统，相对于的RCS、CVS，采用了分支管理系统，它的设计目标就是取代CVS。互联网上免费的版本控制服务多基于Subversion。
* 版本控制系统 Bazaar：Bazaar 是一个分布式的版本控制系统，它发布在 GPL 许可协议之下，并可用于 Windows、GNU/Linux、Unix 以及 Mac OS 系统。

## 自动化构建和测试

* Apache Ant：Apache Ant是一个将软件编译、测试、部署等步骤联系在一起加以自动化的一个工具，大多用于Java环境中的软件开发。
* Maven：Maven 除了以程序构建能力为特色之外，还提供 Ant 所缺少的高级项目管理工具。由于 Maven 的缺省构建规则有较高的可重用性，所以常常用两三行 Maven 构建脚本就可以构建简单的项目，而使用 Ant 则需要十几行。事实上，由于 Maven 的面向项目的方法，许多 Apache Jakarta 项目现在使用 Maven，而且公司项目采用 Maven 的比例在持续增长。
* Selenium (SeleniumHQ)：thoughtworks公司的一个集成测试的强大工具。
* PyUnit：Python单元测试框架(The Python unit testing framework)，简称为PyUnit， 是Kent Beck和Erich Gamma这两位聪明的家伙所设计的 JUnit 的Python版本。
* QUnit：QUnit 是 jQuery 的单元测试框架。
* JMeter：JMeter 是 Apache 组织的开放源代码项目，它是功能和性能测试的工具，100% 的用 java 实现。
* Gradle：Gradle 就是可以使用 Groovy 来书写构建脚本的构建系统，支持依赖管理和多项目，类似 Maven，但比之简单轻便。
* PHPUnit：PHPUnit 是一个轻量级的PHP测试框架。它是在PHP5下面对JUnit3系列版本的完整移植，是xUnit测试框架家族的一员(它们都基于模式先锋Kent Beck的设计)。

## 持续集成&交付

* Jenkins：Jnkins 的前身是 Hudson，它是一个可扩展的持续集成引擎。
* Capistrano：Cpistrano 是一个用来并行的在多台机器上执行相同命令的工具，使用用来安装一整批机器。它最初是被开发用来发布 Rails 应用的。
* BuildBot：BildBot 是一个系统的自动化编译/测试周期最需要的软件，以验证代码的变化。通过自动重建和测试每次发生了变化的东西，在建设迅速查明之前，减少不必要的失败。
* Fabric：fabric8 是开源 Java Containers(JVMs) 深度管理集成平台。有了 fabric8 可以非常方便的从 UI 和 UX 一致的中央位置进行自动操作，配置和管理。fabric8 同时提供一些非功能性需求，比如配置管理，服务发现故障转移，集中化监控，自动化等等。：Tnderbox
* Travis CI：Tavis CI 是一个基于云的持续集成项目， 目前已经支持大部分主流语言了，比如：C，PHP，Ruby，Python，Nodejs等等。
* Continuum：Aache Continuum 是最新的 CI 服务器之一，也是值得关注的一个新进入者。基于 Web 的界面使得配置项目很容易。而且，还不需要安装 Web 服务器，因为 Continuum 内置了 Jetty Web 服务器。并且，Continuum 可以作为 Windows 服务运行，还在应用程序的某些部分嵌入了上下文敏感的文档，从而提供了很多帮助。
* LuntBuild：LntBuild 是一个强大自动构建的工具。通过一个简洁的web接口就可以很容易地进行系统的持续构建。
* CruiseControl：CuiseControl 是一个针对持续构建程序(项目持续集成)的框架，它包括一个email通知的插件，Ant和各种各样的CVS工具。CruiseControl提供了一个Web接口，可随时查看当前的编译状况和历史状况。
* Integrity：Integrity 是 Ruby 开发的持续集成服务器。
* Gump：Gump 是 Apache 的整合工具。它以 Python 写成、完全支持 Apache Ant、Apache Maven 等等软件组建工具。
* Go：Go 是 Google 开发的一种编译型，并发型，并具有垃圾回收功能的编程语言。

## 部署工具

* 容器平台
    - Docker：Docker 是一个开源的应用容器引擎，让开发者可以打包他们的应用以及依赖包到一个可移植的容器中，然后发布到任何流行的 Linux 机器上，也可以实现虚拟化。
    - Rocket：Rocket (也叫 rkt)是 CoreOS 推出的一款容器引擎，和 Docker 类似，帮助开发者打包应用和依赖包到可移植容器中，简化搭环境等部署工作。
    - Ubuntu(LXC)：LXD 是 ubuntu 基于 LXC 技术的重构，容器天然支持非特权和分布式。LXD 与 Docker 的思路不同，Docker 是 PAAS，LXD 是 IAAS。LXC 项目由一个 Linux 内核补丁和一些 userspace 工具组成。这些 userspace 工具使用由补丁增加的内核新特性，提供一套简化的工具来维护容器。
* 配置管理
    - Chef：Chef 是一个系统集成框架，为整个架构提供配置管理功能。
    - Puppet：Puppet，您可以集中管理每一个重要方面，您的系统使用的是跨平台的规范语言，管理所有的单独的元素通常聚集在不同的文件，如用户， CRON作业，和主机一起显然离散元素，如包装，服务和文件。
    - CFengine：Cfengine(配置引擎)是一种 Unix 管理工具，其目的是使简单的管理的任务自动化，使困难的任务变得较容易。Cfengine 适用于管理各种环境，从一台主机到上万台主机的机群均可使用。
    - Bash：Bash 是大多数Linux系统以及Mac OS X v10.4默认的shell，它能运行于大多数Unix风格的操作系统之上，甚至被移植到了Microsoft Windows上的Cygwin系统中，以实现windows的POSIX虚拟接口。此外，它也被DJGPP项目移植到了MS-DOS上。
    - Rudder：Rudder 已改名为Flannel，为每个使用 Kubernetes 的机器提供一个子网。也就是说 Kubernetes 集群中的每个主机都有自己一个完整的子网，例如机器 A 和 B 可以有 10.0.1.0/24 和 10.0.2.0/24 子网。
    - RunDeck：RunDeck 是用 Java/Grails 写的开源工具，帮助用户在数据中心或者云环境中自动化各种操作和流程。通过命令行或者web界面，用户可以对任意数量的服务器进行操作，大大降低了对服务器自动化的门槛。
    - Saltstack：Saltstack 可以看做是func的增强版+Puppet的弱化版。使用Python编写。非常好用，快速可以基于EPEL部署。Salt 是一个开源的工具用来管理你的基础架构，可轻松管理成千上万台服务器。
    - Ansible：Ansible 提供一种最简单的方式用于发布、管理和编排计算机系统的工具，你可在数分钟内搞定。Ansible 是一个模型驱动的配置管理器，支持多节点发布、远程任务执行。默认使用 SSH 进行远程连接。无需在被管理节点上安装附加软件，可使用各种编程语言进行扩展。
* 微服务平台
    * OpenShift：OpenShift 是由红帽推出的一款面向开源开发人员开放的平台即服务(PaaS)。 OpenShift通过为开发人员提供在语言、框架和云上的更多的选择，使开发人员可以构建、测试、运行和管理他们的应用。
    * Cloud Foundry：Cloud Foundry 是VMware于2011年4月12日推出的业界第一个开源PaaS云平台，它支持多种框架、语言、运行时环境、云平台及应用服务，使开发人员能够在几秒钟内进行应用程序的部署和扩展，无需担心任何基础架构的问题。
    * Kubernetes：Kubernetes 是来自 Google 云平台的开源容器集群管理系统。基于 Docker 构建一个容器的调度服务。该系统可以自动在一个容器集群中选择一个工作容器供使用。其核心概念是 Container Pod。
    * Mesosphere：Apache Mesos 是一个集群管理器，提供了有效的、跨分布式应用或框架的资源隔离和共享，可以运行Hadoop、MPI、Hypertable、Spark。
* 服务开通

* Puppet：Puppet，您可以集中管理每一个重要方面，您的系统使用的是跨平台的规范语言，管理所有的单独的元素通常聚集在不同的文件，如用户， CRON作业，和主机一起显然离散元素，如包装，服务和文件。
* Docker Swarm：Docker Swarm 是一个Dockerized化的分布式应用程序的本地集群，它是在Machine所提供的功能的基础上优化主机资源的利用率和容错服务。具体来说，Docker Swarm支持用户创建可运行Docker Daemon的主机资源池，然后在资源池中运行Docker容器。Docker Swarm可以管理工作负载并维护集群状态。
* Vagrant：Vagrant 是一个基于 Ruby 的工具，用于创建和部署虚拟化开发环境。它使用 Oracle 的开源 VirtualBox 虚拟化系统，使用 Chef 创建自动化虚拟环境。
* Powershell
* OpenStack Heat

## 维护

日志记录

* Logstash：Logstash 是一个应用程序日志、事件的传输、处理、管理和搜索的平台。你可以用它来统一对应用程序日志进行收集管理，提供 Web 接口用于查询和统计。
* CollectD：collectd 是一个守护(daemon)进程，用来收集系统性能和提供各种存储方式来存储不同值的机制。比如以RRD 文件形式。
* StatsD：StatsD 是一个简单的网络守护进程，基于 Node.js 平台，通过 UDP 或者 TCP 方式侦听各种统计信息，包括计数器和定时器，并发送聚合信息到后端服务，例如 Graphite。

## 监控，警告&分析

* Nagios：Nagios 是一个监视系统运行状态和网络信息的监视系统。Nagios能监视所指定的本地或远程主机以及服务，同时提供异常通知功能等。
* Ganglia：Ganglia 是一个跨平台可扩展的，高性能计算系统下的分布式监控系统，如集群和网格。它是基于分层设计，它使用广泛的技术，如XML数据代表，便携数据传输，RRDtool用于数据存储和可视化。
* Sensu：Sensu 是开源的监控框架。主要特性：高度可组合;提供一个监控代理，一个事件处理器和文档 APIs;为云而设计;Sensu 的现代化架构允许监控大规模的动态基础设施，能够通过复杂的公共网络监控几千个全球分布式的机器和服务;热情的社区。
* zabbix：zabbix 是一个基于Web界面的提供分布式系统监视以及网络监视功能的企业级的开源解决方案。
* ICINGA：ICINGA 项目是 由Michael Luebben、HendrikB?cker和JoergLinge等人发起的，他们都是现有的Nagios项目社区委员会的成员，他们承诺，新的开源项目将完全兼容以前的Nagios应用程序及扩展功能。
* Graphite：Graphite 是一个用于采集网站实时信息并进行统计的开源项目，可用于采集多种网站服务运行状态信息。Graphite服务平均每分钟有4800次更新操作。
* Kibana：Kibana 是一个为 Logstash 和 ElasticSearch 提供的日志分析的 Web 接口。可使用它对日志进行高效的搜索、可视化、分析等各种操作。

## 管理

* [Vault](link):Manage Secrets and Protect Sensitive Data
    - [Get started](https://learn.hashicorp.com/vault)
* [AWS Secrets Manager](link)

## 工具

- [apex/up](https://github.com/apex/up):Deploy infinitely scalable serverless apps, apis, and sites in seconds. https://apex.github.io/up/
- [apex/apex](https://github.com/apex/apex):Build, deploy, and manage AWS Lambda functions with ease (with Go support!). http://apex.run
- [spinnaker/spinnaker](https://github.com/spinnaker/spinnaker):Spinnaker is an open source, multi-cloud continuous delivery platform for releasing software changes with high velocity and confidence. http://www.spinnaker.io/
* [gaia-pipeline/gaia](https://github.com/gaia-pipeline/gaia):Build powerful pipelines in any programming language.
* [jumpserver/jumpserver](https://github.com/jumpserver/jumpserver):Jumpserver是全球首款完全开源的堡垒机，是符合 4A 的专业运维审计系统。 http://www.jumpserver.org
* [PERIODIC TABLE OF DEVOPS TOOLS](https://xebialabs.com/periodic-table-of-devops-tools/)
* [kelseyhightower/confd](https://github.com/kelseyhightower/confd):Manage local application configuration files using templates and data from etcd or consul
* [waylybaye/HyperApp-Guide](https://github.com/waylybaye/HyperApp-Guide):HyperApp user's manual
* [snipe/snipe-it](https://github.com/snipe/snipe-it):A free open source IT asset/license management system https://snipeitapp.com
* [pinterest/teletraan](https://github.com/pinterest/teletraan):Teletraan is Pinterest's deploy system.
* [NullArray/AutoSploit](https://github.com/NullArray/AutoSploit):Automated Mass Exploiter
* [TeaWeb/build](https://github.com/TeaWeb/build):TeaWeb是集静态资源、缓存、代理、统计、监控于一体的可视化智能WebServer。


## 参考

* [liquanzhou/ops_doc](https://github.com/liquanzhou/ops_doc):运维简洁实用手册
* [ digitalocean tutorials](https://www.digitalocean.com/community/tutorials)
