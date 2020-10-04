# DevOps

* 追求愿景:“让业务所要求的那些变化能随时上线可用”
* 起源
  - 比利时独立咨询师Patrick Debois:2007年他在比利以咨询师的身份，参与了一个政府数据中心迁移中的测试工作。他在做测试时，需要频繁往返于Dev团队和Ops团队之间。Dev团队已经实践了敏捷，而Ops团队还是传统运维的工作方式。看到Ops团队每天忙于救火和疲于奔命的状态，他在想：能否把敏捷的实践引入Ops团队呢？
  - 雅虎旗下的图片分享网站Flickr:运维部门经理John Allspaw和工程师Paul Hammond，于2009年6月23日在美国圣荷西举办的Velocity 2009大会上，发表了一个引燃DevOps的演讲。这个演讲的题目在当时很抢眼－－《每天部署10次以上：Flickr公司的Dev与Ops的合作》
  - Debois。他在“推特”上发帖：“可惜没法去现场参加。”朋友Paul Nasrat回帖说：“为什么不在比利时搞一个你自己的Velocity大会？”
  - 2009年10月30至31日，在比利时的第二大城市根特，以社区自发的形式举办了一个名为DevOpsDays的大会.会议结束还不过瘾，回去继续在“推特”上聊。限于推特140个字符的制约，Debois把DevOpsDays中的Days去掉，而创建了#DevOps#这个“推特”聊天主题标签，DevOps诞生了。
* Damon Edwards所定义并被Jez Humble所修订的CALMS
  - Culture – 文化：公司各个角色一起担当业务变化，实现有效协作和沟通；
  - Automation – 自动化：在价值链中尽量除去手工步骤；
  - Lean – 精益：运用精益原则更频繁地交付价值；
  - Metrics – 度量：度量并使用数据来优化交付周期；
  - Sharing – 分享：分享成功和失败的经验来相互学习
* Gene Kim所定义的The Three Ways
  - The First Way： System Thinking （系统思考：强调全局优化，避免局部优化）；
  - The Second Way： Amplify Feedback Loops （经过放大的反馈回路：创建从开发过程下游至上游的反馈环）；
  - The Third Way： Culture of Continual Experimentation And Learning（持续做试验和学习的文化：持续做试验，承担风险、从失败中学习；通过反复实践来达到精通）
* 优势
  - 稳定的运行环境
  - 超快速的交付
  - 坚实的合作
  - 时间优化（特别是在修复/维护阶段）
  - 持续创新
* 生命周期
  - 持续开发
  - 持续集成
  - 持续测试
  - 持续反馈
  - 持续监测
  - 持续部署
  - 持续运维
* 一套完全开源工具链：Gitlab + Maven + Jenkins + TestNg + SonarQuebe + Allure

## 原则

* 人
  - 领导者身体力行持续改进 高于 关注工具和基础设施
  - 试验并改进流程 而非 指责人的过失
  - 产品思维 高于 项目思维
* 产品
  - 质量和安全内建 而非 晚期度量和检查,一次就根据最佳流程或实践把事情做对，并持续改进这些流程和实践，使其一直保持最佳
  - 客户反馈 高于 按期交付
  - 基于不可变容器的微服务 高于 单块应用
* 流程
  - 管理层实践Improvement Kata和Coaching Kata进行流程持续改进 高于 用结果导向进行管理
    + Improvement Kata是通过一系列“确定目标—>考察现状—>识别困难—>制定方案—>观察成效”的PDCA反馈环来做持续改进
    + Coaching Kata是通过导师“一对一带学徒”的方式来让企业全员掌握持续改进的方法
  - 全局优化 而非 局部优化
  - 单件流 高于 库存
* 工具
  - 自动化 高于 手工
  - 基础设施及代码 高于 手工配置
  - 部署流水线 而非 每日构建

## 持续开发

* 第一个阶段是开发应用程序源代码的第一步是从不同的编程语言中进行选择。 JavaScript，C / C ++，Ruby和Python在DevOps中主要用于编码应用程序。
* 维护代码的过程称为源代码管理（SCM），其中使用了诸如Git、TFS、GitLab、Subversion等版本控制工具。在SCM过程中，Git是支持分布式版本控制的首选工具。它通过循环的非线性工作流对数据保证做出贡献。对于涉及大量合作者参与开发活动的大型项目，Git通过提交消息在团队之间建立可靠的通信。
* 借助版本控制工具，可以在连续开发阶段构建应用程序代码的稳定版本。 开发人员还可以使用Garden，Maven和类似工具将代码打包为.exe（可执行）文件。
* 开发工具：版本控制&协作开发
  - 版本控制系统 Git：Git是一个开源的分布式版本控制系统，用以有效、高速的处理从很小到非常大的项目版本管理。
  - 代码托管平台 GitLab：GitLab是一个利用Ruby on Rails开发的开源应用程序，实现一个自托管的Git项目仓库，可通过Web界面进行访问公开的或者私人项目。
  - 代码评审工具 Gerrit：Gerrit是一个免费、开放源代码的代码审查软件，使用网页界面。利用网页浏览器，同一个团队的软件程序员，可以相互审阅彼此修改后的程序代码，决定是否能够提交，退回或者继续修改。它使用Git作为底层版本控制系统。
  - Mercurial：Mercurial是一种轻量级分布式版本控制系统，采用 Python 语言实现，易于学习和使用，扩展性强
  - Subversion：Subversion是一个版本控制系统，相对于的RCS、CVS，采用了分支管理系统，它的设计目标就是取代CVS。互联网上免费的版本控制服务多基于Subversion
  - Bazaar：Bazaar 是一个分布式的版本控制系统，它发布在 GPL 许可协议之下，并可用于 Windows、GNU/Linux、Unix 以及 Mac OS 系统。

## 持续集成 Continuous integration CI

* 每次团队成员提交版本控制更改时自动构建和测试代码的过程。这鼓励开发人员通过在每个小任务完成后将更改合并到共享版本控制存储库来共享代码和单元测试
* 代码仓库更新后，通过在 GitLab 设置的 CI-CD 配置，自动打包镜像，然后触发 WebHook 自动更新
* 一种软件开发实践，即团队开发成员经常集成它们的工作，通常每个成员每天至少集成一次，也就意味着每天可能会发生多次集成。每次集成都通过自动化的构建（包括编译，发布，自动化测试)来验证，从而尽快地发现集成错误。许多团队发现这个过程可以大大减少集成的问题，让团队能够更快的开发内聚的软件
* 优点
  - 快速发现错误。每完成一点更新，就集成到主干，可以快速发现错误，定位错误也比较容易。
  - 防止分支大幅偏离主干。如果不是经常集成，主干又在不断更新，会导致以后集成的难度变大，甚至难以集成。
* 原则
  - 所有的开发人员需要在本地机器上做本地构建，然后再提交的版本控制库中，从而确保他们的变更不会导致持续集成失败。
  - 开发人员每天至少向版本控制库中提交一次代码。
  - 开发人员每天至少需要从版本控制库中更新一次代码到本地机器。
  - 需要有专门的集成服务器来执行集成构建,每天要执行多次构建。
  - 每次构建都要100%通过。
  - 每次构建都可以生成可发布的产品
  - 修复失败的构建是优先级最高的事情。
* 源代码会被修改多次，这些频繁的更改每周甚至每天都在发生着。下一阶段的代码集成是整个DevOps生命周期的核心。在持续集成中，将构建支持附加功能的新代码，并将其集成到现有代码中。
* 在这个阶段，源代码中的错误会在早期就被检测到。为了生成为应用程序带来更多功能的新代码，开发人员运行用于单元测试、代码评审、集成测试、编译和打包的工具。 将新代码持续集成到现有源代码中有助于反映最终用户在使用更新后的代码时所经历的更改。
* Jenkins是被广泛应用的可靠的DevOps工具，用于获取更新的源代码并将构建构建为.exe格式。这些转换是无缝进行的，更新的代码将打包并进入下一阶段，即生产服务器或测试服务器
* CI/CD
  - CI 持续集成主要是在代码更改时自动分支合并、构建并执行一系列的测试（包括单元测试、集成测试、端到端测试等），确保这些变更不会破坏原来的应用。
  - CD 持续交付和部署则是 CI 测试通过之后把构建结果存档、发布到预布环境和生产环境、最后再进行验收测试的过程。
  - CI/CD 是 DevOps 的基础，CI/CD 侧重于软件开发过程中的自动化，而 Devops 则是侧重于文化构建，旨在减少开发、运维、QA之间的沟通鸿沟，促进快速可靠发布的同时还保证产品质量。
  - CI/CD 一系列流程通常会组成一个流水线，docker和Kubernetes则可以简化这些流水线中的很多流程，比如Docker容器可以很容易把有冲突的环境隔离开来，而Kubernetes则更进一步简化整个流水线的构建、执行和维护工作
  - 机制
    + 持续集成工具的对比和选择 Jenkins， GoCD， ConsourseCI, TravisCI, etc
    + Jenkins搭建持续集成服务器
    + 基于Jenkins搭建持续集成流水线
* 实践：
  - 小步提交
  - 每日构建成功
  - 单元测试在本地提交前通过
  - 自动化功能测试
  - 构建失败，优先级最高
  - 代码风格问题也让构建失败
* 工具
  - 传统的 CI/CD 工具，典型的是 Jenkins 和 Gitlab，功能强大，配置灵活，使用场景没有限制。
  - Kubernetes native 工具，典型的是 Jenkins X 和 Argo，专为 Kubernetes 场景构建，跟 Kubernetes 生态紧密集成，但缺少灵活性
  - Apache Ant：Apache Ant是一个将软件编译、测试、部署等步骤联系在一起加以自动化的一个工具，大多用于Java环境中的软件开发。
  - Maven：Maven 除了以程序构建能力为特色之外，还提供 Ant 所缺少的高级项目管理工具。由于 Maven 的缺省构建规则有较高的可重用性，所以常常用两三行 Maven 构建脚本就可以构建简单的项目，而使用 Ant 则需要十几行。事实上，由于 Maven 的面向项目的方法，许多 Apache Jakarta 项目现在使用 Maven，而且公司项目采用 Maven 的比例在持续增长
  - Jenkins：Jnkins 的前身是 Hudson，它是一个可扩展的持续集成引擎。
  - Capistrano：Cpistrano 是一个用来并行的在多台机器上执行相同命令的工具，使用用来安装一整批机器。它最初是被开发用来发布 Rails 应用的。
  - BuildBot：BildBot 是一个系统的自动化编译/测试周期最需要的软件，以验证代码的变化。通过自动重建和测试每次发生了变化的东西，在建设迅速查明之前，减少不必要的失败。
  - Fabric：fabric8 是开源 Java Containers(JVMs) 深度管理集成平台。有了 fabric8 可以非常方便的从 UI 和 UX 一致的中央位置进行自动操作，配置和管理。fabric8 同时提供一些非功能性需求，比如配置管理，服务发现故障转移，集中化监控，自动化等等。：Tnderbox
  - Travis CI：Tavis CI 是一个基于云的持续集成项目， 目前已经支持大部分主流语言了，比如：C，PHP，Ruby，Python，Nodejs等等。
  - Continuum：Aache Continuum 是最新的 CI 服务器之一，也是值得关注的一个新进入者。基于 Web 的界面使得配置项目很容易。而且，还不需要安装 Web 服务器，因为 Continuum 内置了 Jetty Web 服务器。并且，Continuum 可以作为 Windows 服务运行，还在应用程序的某些部分嵌入了上下文敏感的文档，从而提供了很多帮助。
  - LuntBuild：LntBuild 是一个强大自动构建的工具。通过一个简洁的web接口就可以很容易地进行系统的持续构建。
  - CruiseControl：CuiseControl 是一个针对持续构建程序(项目持续集成)的框架，它包括一个email通知的插件，Ant和各种各样的CVS工具。CruiseControl提供了一个Web接口，可随时查看当前的编译状况和历史状况。
  - Integrity：Integrity 是 Ruby 开发的持续集成服务器。
  - Gump：Gump 是 Apache 的整合工具。它以 Python 写成、完全支持 Apache Ant、Apache Maven 等等软件组建工具
* 度量
  - 代码度量
  - 流水线度量
  - 团队交付速率度量
  - 持续改进
* Webhooks
  - [GitHub Developer](https://developer.github.com/webhooks/)
  - [adnanh/webhook](https://github.com/adnanh/webhook):webhook is a lightweight configurable tool written in Go, that allows you to easily create HTTP endpoints (hooks) on your server, which you can use to execute configured commands.
  - [NetEaseGame/git-webhook](https://github.com/NetEaseGame/git-webhook):使用 Python Flask + SQLAchemy + Celery + Redis + React 开发的用于迅速搭建并使用 WebHook 进行自动化部署和运维，支持 Github / GitLab / Gogs / GitOsc。
  - [sovereign/sovereign](https://github.com/sovereign/sovereign)

## 持续测试

* 一些开发人员在持续集成阶段之前执行持续测试阶段。根据应用程序代码中的更新，可以围绕DevOps生命周期中的持续集成阶段重新定位此阶段。
* 在这个阶段，对开发的软件进行不断的Bug测试。 使用Docker容器来模拟测试环境。通过自动化测试，开发人员可以节省往常在手动测试中浪费的精力和时间。自动化测试生成的报告可改善测试评估过程，分析失败的测试用例变得更加容易。经过UAT（用户接受测试）过程后，生成的测试套件更简单且没有Bug。
* TestNG，Selenium和JUnit是用于自动化测试的一些DevOps工具。这些工具还可以在预设的时间线上安排测试用例的执行。质量保证工程师（QA）可以使用这些工具对其他几个代码库进行并行测试。它确保了应用程序实现功能完美和网络互联。最后，被测试的代码被重新发送到持续集成阶段以更新源代码。
* 工具
  - Selenium (SeleniumHQ)：thoughtworks公司的一个集成测试的强大工具。
  - PyUnit：Python单元测试框架(The Python unit testing framework)，简称为PyUnit， 是Kent Beck和Erich Gamma这两位聪明的家伙所设计的 JUnit 的Python版本。
  - QUnit：QUnit 是 jQuery 的单元测试框架。
  - JMeter：JMeter 是 Apache 组织的开放源代码项目，它是功能和性能测试的工具，100% 的用 java 实现。
  - Gradle：Gradle 就是可以使用 Groovy 来书写构建脚本的构建系统，支持依赖管理和多项目，类似 Maven，但比之简单轻便。
  - PHPUnit：PHPUnit 是一个轻量级的PHP测试框架。它是在PHP5下面对JUnit3系列版本的完整移植，是xUnit测试框架家族的一员(它们都基于模式先锋Kent Beck的设计)

## 持续反馈

* 持续测试和持续集成是确保应用程序代码持续改进的两个关键阶段，而持续反馈是分析这些改进的阶段。
* 开发人员可以在最终产品上评估这些修改的结果。最重要的是，测试这些应用程序的客户可以在此阶段分享他们的经验。在大多数情况下，DevOps生命周期的这一阶段为应用程序开发过程提供了一个转折点
* 及时评估反馈，开发人员开始着手进行新更改。这样，客户反馈很快就能得到积极的回应，这为发布软件应用程序的新版本铺平了道路

## 持续监测

* 监测应用程序的性能对于应用程序开发人员至关重要。在此阶段，开发人员记录有关应用程序使用的数据，并持续监测着每个功能。“服务器无法访问”或“内存不足”是可以在这个阶段被解决的一些常见系统错误。
* 持续监测有助于保持应用程序中服务的可用性。它还能确认重复出现的系统错误的威胁和根本原因。在这个阶段，安全问题可以得到解决，还能自动检测和修复缺陷。
* 与软件开发团队相比，IT运维团队在这一阶段的参与程度更高。他们的角色在监视用户活动、检查系统是否有异常行为以及跟踪错误的存在方面至关重要。
* Sensu，ELK Stack，NewRelic，Splunk和Nagios是用于持续监视的关键DevOps工具。这些工具可实现对系统、生产服务器和应用程序性能的全面控制。在这些工具的帮助下，运维团队可以积极参与，以提高应用程序的可靠性和生产率。
* 当在此阶段检测到重大问题时，应用程序将在DevOps生命周期的所有早期阶段快速重新运行，这就是为何在这个阶段找到解决各种问题的方法会变得更快的原因。
* 工具
  - Nagios：Nagios 是一个监视系统运行状态和网络信息的监视系统。Nagios能监视所指定的本地或远程主机以及服务，同时提供异常通知功能等。
  - Ganglia：Ganglia 是一个跨平台可扩展的，高性能计算系统下的分布式监控系统，如集群和网格。它是基于分层设计，它使用广泛的技术，如XML数据代表，便携数据传输，RRDtool用于数据存储和可视化。
  - Sensu：Sensu 是开源的监控框架。主要特性：高度可组合;提供一个监控代理，一个事件处理器和文档 APIs;为云而设计;Sensu 的现代化架构允许监控大规模的动态基础设施，能够通过复杂的公共网络监控几千个全球分布式的机器和服务;热情的社区。
  - zabbix：zabbix 是一个基于Web界面的提供分布式系统监视以及网络监视功能的企业级的开源解决方案。
  - ICINGA：ICINGA 项目是 由Michael Luebben、HendrikB?cker和JoergLinge等人发起的，他们都是现有的Nagios项目社区委员会的成员，他们承诺，新的开源项目将完全兼容以前的Nagios应用程序及扩展功能。
  - Graphite：Graphite 是一个用于采集网站实时信息并进行统计的开源项目，可用于采集多种网站服务运行状态信息。Graphite服务平均每分钟有4800次更新操作。
  - Kibana：Kibana 是一个为 Logstash 和 ElasticSearch 提供的日志分析的 Web 接口。可使用它对日志进行高效的搜索、可视化、分析等各种操作。

## 持续部署 Continuous Deployment

* 通常来说，持续部署阶段发生在持续监视之前。但是，开发人员要确保这个阶段在DevOps生命周期中始终处于活动状态，尤其是在应用程序上线并开始接收大量流量之后。
* 在此阶段，最终确定的应用程序代码将被部署到生产服务器。配置管理是这一阶段的关键过程，它在所有服务器上执行应用程序代码的精确部署，建立并管理应用程序性能和功能条件的一致性。将代码发布到服务器，为所有服务器安排更新，并且这些配置在整个生产过程中保持一致。
* Ansible、Puppet和Chef是用于配置管理的一些有效的DevOps工具，它们经常执行新代码的快速和连续部署。
* 容器化工具用于通过配置管理过程实现连续部署。 Vagrant是一种容器化工具，可在从开发和测试到阶段和生产的不同环境中发展一致性。同样，连续部署的可伸缩性由Docker等工具处理。这些工具通过复制和打包来自测试，登台和开发阶段的软件耦合，消除了各种生产故障和系统错误。最终，该应用程序可以在不同的计算机上流畅运行
* 工具
  - 容器平台
    + Docker：一个开源的应用容器引擎，让开发者可以打包他们的应用以及依赖包到一个可移植的容器中，然后发布到任何流行的 Linux 机器上，也可以实现虚拟化
    + Rocket：Rocket (也叫 rkt)是 CoreOS 推出的一款容器引擎，和 Docker 类似，帮助开发者打包应用和依赖包到可移植容器中，简化搭环境等部署工作。
    + Ubuntu(LXC)：LXD 是 ubuntu 基于 LXC 技术的重构，容器天然支持非特权和分布式。LXD 与 Docker 的思路不同，Docker 是 PAAS，LXD 是 IAAS。LXC 项目由一个 Linux 内核补丁和一些 userspace 工具组成。这些 userspace 工具使用由补丁增加的内核新特性，提供一套简化的工具来维护容器。
  - 配置管理
    + Chef：Chef 是一个系统集成框架，为整个架构提供配置管理功能
    + Puppet：Puppet，您可以集中管理每一个重要方面，您的系统使用的是跨平台的规范语言，管理所有的单独的元素通常聚集在不同的文件，如用户， CRON作业，和主机一起显然离散元素，如包装，服务和文件。
    + CFengine：Cfengine(配置引擎)是一种 Unix 管理工具，其目的是使简单的管理的任务自动化，使困难的任务变得较容易。Cfengine 适用于管理各种环境，从一台主机到上万台主机的机群均可使用。
    + Bash：Bash 是大多数Linux系统以及Mac OS X v10.4默认的shell，它能运行于大多数Unix风格的操作系统之上，甚至被移植到了Microsoft Windows上的Cygwin系统中，以实现windows的POSIX虚拟接口。此外，它也被DJGPP项目移植到了MS-DOS上。
    + Rudder：Rudder 已改名为Flannel，为每个使用 Kubernetes 的机器提供一个子网。也就是说 Kubernetes 集群中的每个主机都有自己一个完整的子网，例如机器 A 和 B 可以有 10.0.1.0/24 和 10.0.2.0/24 子网。
    + RunDeck：RunDeck 是用 Java/Grails 写的开源工具，帮助用户在数据中心或者云环境中自动化各种操作和流程。通过命令行或者web界面，用户可以对任意数量的服务器进行操作，大大降低了对服务器自动化的门槛。
    + Saltstack：Saltstack 可以看做是func的增强版+Puppet的弱化版。使用Python编写。非常好用，快速可以基于EPEL部署。Salt 是一个开源的工具用来管理你的基础架构，可轻松管理成千上万台服务器。
    + Ansible：Ansible 提供一种最简单的方式用于发布、管理和编排计算机系统的工具，你可在数分钟内搞定。Ansible 是一个模型驱动的配置管理器，支持多节点发布、远程任务执行。默认使用 SSH 进行远程连接。无需在被管理节点上安装附加软件，可使用各种编程语言进行扩展。
  - 微服务平台
    - OpenShift：OpenShift 是由红帽推出的一款面向开源开发人员开放的平台即服务(PaaS)。OpenShift通过为开发人员提供在语言、框架和云上的更多的选择，使开发人员可以构建、测试、运行和管理他们的应用。
    - Cloud Foundry：Cloud Foundry 是VMware于2011年4月12日推出的业界第一个开源PaaS云平台，它支持多种框架、语言、运行时环境、云平台及应用服务，使开发人员能够在几秒钟内进行应用程序的部署和扩展，无需担心任何基础架构的问题。
    - Kubernetes：Kubernetes 是来自 Google 云平台的开源容器集群管理系统。基于 Docker 构建一个容器的调度服务。该系统可以自动在一个容器集群中选择一个工作容器供使用。其核心概念是 Container Pod。
    - Mesosphere：Apache Mesos 是一个集群管理器，提供了有效的、跨分布式应用或框架的资源隔离和共享，可以运行Hadoop、MPI、Hypertable、Spark。
  - 服务开通
  - Puppet：Puppet，您可以集中管理每一个重要方面，您的系统使用的是跨平台的规范语言，管理所有的单独的元素通常聚集在不同的文件，如用户， CRON作业，和主机一起显然离散元素，如包装，服务和文件。
  - Docker Swarm：Docker Swarm 是一个Dockerized化的分布式应用程序的本地集群，它是在Machine所提供的功能的基础上优化主机资源的利用率和容错服务。具体来说，Docker Swarm支持用户创建可运行Docker Daemon的主机资源池，然后在资源池中运行Docker容器。Docker Swarm可以管理工作负载并维护集群状态。
  - Vagrant：Vagrant 是一个基于 Ruby 的工具，用于创建和部署虚拟化开发环境。它使用 Oracle 的开源 VirtualBox 虚拟化系统，使用 Chef 创建自动化虚拟环境。
  - Powershell
  - OpenStack Heat

## 持续运维

* 目的是使发布的应用程序和后续更新的过程自动化。持续运维中的开发周期更短，从而使开发人员能够不断加快该应用程序的上市时间


* Configuration Management:统一使用 Kubernetes 提供的 configmap 和 secret 资源对象来实现，对于一般的应用配置使用 configmap 管理，对于敏感数据使用 secret 存储
  - [Vault](link):Manage Secrets and Protect Sensitive Data
    + [Get started](https://learn.hashicorp.com/vault)
  - [AWS Secrets Manager](link)
* Release Management:用 Helm 工具统一以 Chart 的方式打包并发布应用，维护每个微服务的历史版本，可以按需回滚。应用的镜像版本统一存储到一个 Docker 私服
* Infrastructure as Code:所有软件基础设施的管理维护都以代码的方式管理起来，对于基础设施资源的创建、销毁、变更，不再是人工通过界面化点触式管理，所有这些更改都基于代码的提交变更和一套自动化框架
* Test Automation:有三种类型的测试：单元测试、后端接口测试、UI 自动化测试。所有的这些测试都集成在 Jenkins pipeline 中。后端接口测试和 UI 测试除了在自动化 Pipeline 中运行，还会每天定时跑测试，最终的测试报告统一收集到 Reportportal 报表平台
* Application Performance Monitoring:Prometheus 监控栈

## 概念

* 全链路：用于端到端的调用访问范畴，一般是往网关到下游若干服务的链路拓扑结构。例如，网关 -> A服务 -> B服务 ->……的调用和访问
* 灰度发布又名金丝雀发布，指不停机旧版本，部署新版本，低比例流量（例如：5%）切换到新版本，高比例流量（例如：95%）仍走旧版本。通过监控观察确认无问题，逐步扩大范围，慢慢的把所有流量都迁移到新版本上来
  - 作用：支持白天向生产环境发布新服务，安全平滑的逐步切换流量，保证流量以最小代价实现无损
  - 全链路灰度发布是指流量在全链路权重分配。如下两条链路，流量必须走“链路1”或者“链路2”，不能出现交叉情形，例如，A服务（1.0版本）不允许去访问B服务（2.0版本），这样方式可以有效避免新旧版本不兼容的情况
* 蓝绿发布即不停机旧版本，部署新版本，将流量切到新版本，便于快速回滚，旧版本待流量为零，可以继续保留较长时间后下线
  - 作用：支持白天向生产环境发布新服务，通过条件方式，实现在两个部署环境快速切换，如果新服务存在问题，可以快速切换到老服务，保证流量以最小代价实现无损
  - 全链路灰度发布是指流量在全链路条件分配。如下两条链路，流量必须走“链路1”或者“链路2”，不能出现交叉情形，例如，A服务（1.0版本）不允许去访问B服务（2.0版本），这样方式可以有效避免新旧版本不兼容的情况

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

## [travis-ci/travis-ci](https://github.com/travis-ci/travis-ci)

Free continuous integration platform for GitHub projects. https://travis-ci.org

* 用来构建托管在GitHub上的代码，最主要工作是自动运行项目的单元测试并生成报告，同时根据的配置文件，生成一个Linux虚拟机来运行命令，通常这些命令用于测试，构建等。默认设置下，每次对项目进行Push时，都会触发Travis CI运行一次测试。同时提供了一个项目状态图标，可以放置在项目主页告知用户当前的测试情况.
* 配置文件.travis.yml
* 教程
  - [dwyl/learn-travis](https://github.com/dwyl/learn-travis):A quick Travis CI (Continuous Integration) Tutorial for Node.js developers

```yml
language: php
php:
  - 5.3
  - 5.4
before_script:
  - composer install
  - cd tests
script: phpunit -v
```

## circleci

## 维护

日志记录

* Logstash：Logstash 是一个应用程序日志、事件的传输、处理、管理和搜索的平台。你可以用它来统一对应用程序日志进行收集管理，提供 Web 接口用于查询和统计。
* CollectD：collectd 是一个守护(daemon)进程，用来收集系统性能和提供各种存储方式来存储不同值的机制。比如以RRD 文件形式。
* StatsD：StatsD 是一个简单的网络守护进程，基于 Node.js 平台，通过 UDP 或者 TCP 方式侦听各种统计信息，包括计数器和定时器，并发送聚合信息到后端服务，例如 Graphite。

## 工程能力

业务团队最主要的提高的能力是业务抽象和架构能力，通过业务场景，不断思考如何通过合理的架构和业务抽象能快速支持业务，降低运维成本。同时在这个过程中锻炼技术能力，比如写一些技术框架来快速支持业务，做到技术驱动业务。

* 可配置化的方式支持业务：设计业务的领域模型，把不随着业务逻辑变化的领域模型做成系统能力，把随着业务逻辑变化功能，做成可配置化，上一个新业务，通过配置的方式或少量开发就能支持。在做客户后台功能时，由于需要展示的数据种类非常多，每种数据展示可能需要花费几天的时间，所以设计了一个通用的技术框架，实现了通过配置化的方式展示各种数据。
* 写框架解决业务问题：我在上家公司经常做一些CRUD的业务功能，我就自己开发了一个快速做CRUD的框架jdbcutil,通过配置实体生成SQL语句，实现了子类只要继承父类，就自动拥有CRUD的能力。后面还写过生成CRUD页面代码的程序。目前我们团队在做的TITAN框架通过模块化开发的方式，解决易变的业务系统在多人开发时遇到的问题。
* 技术驱动业务：在业务团队，一定要不断的思考如何利用技术来支持快速支持业务，配置化是一种思路，但是有些功能配置复杂度比较高，配置加验证的工作量，可能需要一个星期的时间，那么能不能减少人工配置，实现系统自动化配置，于是可以研究下人工智能，通过人工智能的方式实现，系统告诉人需要配置哪些东西，然后交给人来进行确认，这样可以大大减少人工成本，更快的支持业务。
* 工程自动化，应该是所有开发者的一种基础追求，当你搭建建好工程体系，以后你将专注于产品功能的开发，而不会花大量不必要的时间去手动构建。作为前端，可能我们已经熟悉了 web 应用的构建和部署，但是客户端程序有其本身的特点，相比较 web 应用最大也是我认为最根本的一点区别在于「你的应用是被用户下载过去安装在用户本地再跑起来的」。

## 环境

* development
* staging
* production
* test

## 灰度发布

* 在发布新版本的时候，先切分部分流量给新版本，稳定了之后再切分所有流量到新版本
* 这样一旦有问题，马上修改切分的流量就可以，不需要重新发布，减少了发布风险
* 基于ABTest分流的灰度发布方式已经成为很多公司发布的一个必经流程
* 在灰度发布过程中，产品团队根据用户的反馈及时完善产品相关功能

## Web 前后端分离

* 前后端只通过 JSON 来交流，组件化、工程化不需要依赖后端去实现
* Facebook需要specialist，但是 senior 的人都应该了解整个 E2E (end-to-end) 过程的

在 Facebook 我们不分前端和后端，只分 product 和 infrastructure。做 product 的通常都是 full stack，不需要对特定的技术非常精通，但要求学习能力和灵活性足够好，不能只做自己 comfort zone 以内的事情，do whatever it takes to get your product shipped。通常聪明的应届生都会先进入 product，因为他们学什么都很快，也不会说浪费了在某个领域的积累。infrastructure 拥有更多各个领域的 specialist，前端只是其中之一。infrastructure 的客户就是 product，要做的事情就是让 product 开发实际产品时觉得爽，就这么简单。至于真正 senior 的人，必须了解整个 E2E 过程。这有点像那个「在浏览器地址栏按下回车后都发生了什么」的答案，也就是掌握大局同时了解细节。因为具体的问题可疑扔给 junior 的人去解决，所以 senior 的存在价值就是在众多问题当中寻找值得解决的问题。学过计算机体系结构的人都应该知道，性能优化只应该在瓶颈上做，因为做在非瓶颈上就是浪费资源。同理技术或产品的优化都应该是做在瓶颈上的，所以 senior 的人应该熟悉整套系统并且能够有效找到当前的瓶颈。这时候就不存在前端或者后端的概念了，因为 specialist 在特定领域再精通，不了解整个 E2E 的过程就没办法再往上提升。@winter 提到「联调」，我想说我很久没听说过这个词了，因为这个词没有对应的英语版本，美国公司的产品开发过程通常不包括联调。product 要做什么，就自己学习对应的技术，学习公司内部的 infrastructure，然后调用公司内部的 API 就可以了。一个产品的逻辑，要分前端和后端两个团队的人实现，然后还要协调实现的结果，这我只在中国公司见过。当然这不仅仅要求公司 infrastructure 好，还要求有开放的文化。我进 Facebook 之前只写 JS，在 Facebook 要用 PHP 我随便学学就开始写，反正写得不好 code review 时会有人指出。只要保持开放的学习心态，同一个错误不要一犯再犯，别人都乐意帮助你进步。现在我的 PHP/Hack 就仅仅是够用的程度，但这不妨碍我工作。我的工作当然要用到别人的 infrastructure，偶尔用起来有点小不爽，我就会想要改动一下。管它是 Python、Java 还是 C++，反正我不爽就必须亲自研究源代码弄懂了自己该。原本的作者不一定有时间处理我的小需求，我就按照我的理解去改，改好提交 code review，别人都会帮忙看然后提点建议。所谓联调，无非就是有些事情你自己做不了非要以来于别人帮你做，然后别人就会成为阻塞你的环节。（通常都是前端依赖后端，很少有说后端因为前端没完成就必须停下来等的。）这种做不了就停下来等的态度是不对的，不能说那是别人的问题就等别人解决。总之阻塞了产品发布的问题就是你的问题，无论需要你学习什么新技术，无论需要你编写和调试什么不熟悉的代码，do whatever it takes，just get the product launched。@齐泰然 那个木工和电工的比喻大致也是对的。在中国公司，这就是木工和电工的分离。在美国公司，有一帮人使用 3D 打印机、激光切割机、数控机床，外加 Arduino 或 Raspberry Pi，迅速把新一代电子产品的原型做出来；还有另外一帮人研究新一代的 3D 打印机，考虑如何让上述 maker 更快地把头脑中的产品原型变为现实。在中国公司，木工和电工整天吵架，木工说电工不把线路板面积确定下来他就没办法做木盒子，电工说他在电动机大小不确定的情况下线路板没办法定稿。

## 效率

* 生产力的差异是真实的、巨大的、重要的，而且可能被低估了。发现在各种职业中，如写作、足球、发明、警察的工作和其他职业，前 20% 的人产生了大约 50% 的产出，无论产出是触地得分、专利、破案还是软件
* 工作环境很重要，工程师是否有明确的目标和优先级？他们会买账吗？他们有动力吗？他们彼此信任吗？还有，他们信任管理层吗？他们可以集中注意力吗？他们会参加会议吗？还是在生产环境中扮演“救火员”的角色？他们有良好的基础设施和工具吗？等等
* 生产力是天赋和后天技能的结合
* 生产力与经验并没有很强的相关
* 招聘很重要。 努力吸引、发现和留住最优秀的人才
* 环境很重要。 努力营造一个良好的工作环境，如果你发现生产力方面的普遍问题，那可能就是环境的问题
* 奖励生产力。 一个人创造的越多，他就赚的越多
* 不要认为生产力是与生俱来的。在一个环境中生产力低下的人，可能在另一个项目中或在另一个团队或公司中，生产力更高。在解雇某个人之前，先要确认这个问题
* 培训工程师的生产技能。 我还不知道这样做能有多大的效果，但我认为，我们作为一个行业，甚至没有在这方面进行尝试（我也把自己包括在内）
* 生产力不能为不良行为开脱

## 转变

* 对大多数组织来说都是痛苦的
  - 人们抗拒转变
  - 团队不协调及精力有限
  - 对自动化不切实际的期待
  - 专注于上述因素，就可以逐步在组织中为DevOps营造一个建设性的氛围。
* 需要做的：
  - 确认DevOps的真正优势
  - 依靠“DevOps哲学”来带来文化变革
  - 为组织定义自动化和协作
  - 在进行下一步工作之前，注意整体基础设施
  - 确定目标和衡量标准
  - 不要害怕失败
  - 开发整个工具链并培训员工

## 图书

* 文化
  - 奈飞文化手册
  - 第五项修炼: 学习组织的技术和实践
  - 管理 3.0：培养和提升技术领导力
* 流程
  - 精益软件度量：实践者的观察与思考
* 实施
  - Java 持续交付
* 实践
  - [sre](https://landing.google.com/sre/books/)
* DevOps实践指南
* 构建高可用Linux服务器（第3版）

## 项目

* [1c7/chinese-independent-developer](1c7/chinese-independent-developer):👩🏿‍💻👨🏾‍💻👩🏼‍💻👨🏽‍💻👩🏻‍💻中国独立开发者项目列表 -- 分享大家都在做什么
* [testerSunshine/12306](https://github.com/testerSunshine/12306):12306智能刷票，订票

## 工具

* [apex/up](https://github.com/apex/up):Deploy infinitely scalable serverless apps, apis, and sites in seconds. https://apex.github.io/up/
* [apex/apex](https://github.com/apex/apex):Build, deploy, and manage AWS Lambda functions with ease (with Go support!). http://apex.run
* [spinnaker/spinnaker](https://github.com/spinnaker/spinnaker):Spinnaker is an open source, multi-cloud continuous delivery platform for releasing software changes with high velocity and confidence. http://www.spinnaker.io/
* [gaia-pipeline/gaia](https://github.com/gaia-pipeline/gaia):Build powerful pipelines in any programming language.
* [jumpserver/jumpserver](https://github.com/jumpserver/jumpserver):Jumpserver是全球首款完全开源的堡垒机，是符合 4A 的专业运维审计系统。 http://www.jumpserver.org
* [PERIODIC TABLE OF DEVOPS TOOLS](https://xebialabs.com/periodic-table-of-devops-tools/)
* [kelseyhightower/confd](https://github.com/kelseyhightower/confd):Manage local application configuration files using templates and data from etcd or consul
* [waylybaye/HyperApp-Guide](https://github.com/waylybaye/HyperApp-Guide):HyperApp user's manual
* [snipe/snipe-it](https://github.com/snipe/snipe-it):A free open source IT asset/license management system https://snipeitapp.com
* [pinterest/teletraan](https://github.com/pinterest/teletraan):Teletraan is Pinterest's deploy system.
* [NullArray/AutoSploit](https://github.com/NullArray/AutoSploit):Automated Mass Exploiter
* [TeaWeb/build](https://github.com/TeaWeb/build):TeaWeb是集静态资源、缓存、代理、统计、监控于一体的可视化智能WebServer。
* [Nethogs](http://sourceforge.net/projects/nethogs/files/nethogs/0.8/nethogs-0.8.0.tar.gz/download):终端下的网络流量监控工具可以直观的显示每个进程占用的带宽
* [IOZone](http://www.iozone.org/src/current/): Linux 文件系统性能测试工具 可以测试不同的操作系统中文件系统的读写性能 `./iozone -a -n 512m -g 16g -i 0 -i 1 -i 5 -f /mnt/iozone -Rb ./iozone.xls`
* [IOTop](link) 实时监控磁盘
* IPtraf 是一个运行在 Linux 下的简单的网络状况分析工具
* iftop 是类似于 linux 下面 top 的实时流量监控工具。比 iptraf 直观些
* HTop 是一个 Linux 下的交互式的进程浏览器可以用来替换 Linux 下的 top 命令
* [NMON](http://sourceforge.jp/projects/sfnet_nmon/releases/) 是一种在 AIX 与各种 Linux 操作系统上广泛使用的监控与分析工具
* MultiTail 是在控制台打开多个窗口用来实现同时监控多个日志文档、类似 tail 命令的功能的软件
* [Fail2ban](http://www.fail2ban.org/wiki/index.php/Downloads) 可以监视你的系统日志然后匹配日志的错误信息正则式匹配执行相应的屏蔽动作一般情况下是调用防火墙屏蔽
* Tmux 是一个优秀的终端复用软件类似 GNU Screen 比 Screen 更加方面、灵活和高效。为了确保连接 SSH 时掉线不影响任务运行
* [Agedu](http://www.chiark.greenend.org.uk/~sgtatham/agedu/):页面显示磁盘空间使用情况
* [NMap](http://nmap.org/download.html)是 Linux 下的网络连接扫描和嗅探工具包用来扫描网上电脑开放的网络连接端。
* [Httperf](http://code.google.com/p/httperf/downloads/list) 比 ab 更强大，能测试出 web 服务能承载的最大服务量及发现潜在问题；比如：内存使用、稳定性。最大优势：可以指定规律进行压力测试，模拟真实环境。
* [CODO](https://github.com/opendevops-cn):为用户提供企业多混合云、自动化运维、完全开源的云管理平台。前端基于Vue iview开发、为用户提供友好的操作界面，增强用户体验。 后端基于Python Tornado开发，其优势为轻量、简洁清晰、异步非阻塞 http://www.opendevops.cn
  - [demo](http://demo.opendevops.cn) 用户：demo 密码：2ZbFYNv9WibWcR7GB6kcEY
* [Tencent/bk-ci](https://github.com/Tencent/bk-ci):蓝鲸CI平台(BlueKing CI) https://bk.tencent.com
* [theonedev / onedev](https://github.com/theonedev/onedev):Super Easy All-In-One DevOps Platform
* [Semantic Versioning](https://semver.org/)
* [TeamCity](https://www.jetbrains.com/teamcity/)
* [danger/danger-js](https://github.com/danger/danger-js):⚠️ Stop saying "you forgot to …" in code review http://danger.systems/js/

## 参考

* [liquanzhou/ops_doc](https://github.com/liquanzhou/ops_doc):运维简洁实用手册
* [digitalocean tutorials](https://www.digitalocean.com/community/tutorials)
* [18F/development-guide](https://github.com/18F/development-guide):A set of guidelines and best practices for an awesome engineering team
