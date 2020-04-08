# 云服务

## 过程

* PaaS (Platform as a Service)
    - Google App Engine（简称GAE）：允许用自己喜欢的语言如Java, Python来开发应用程序，然后部署到GAE上运行，完全不用考虑应用程序的伸缩问题，GAE可以帮助你从0扩展到全球规模。
* IaaS（Infrastructure as a Service）：计算，存储，数据库，队列，或者是虚拟机， AWS
* 微服务
    - Netflix不但在生产环境大规模使用微服务， 还为Spring Cloud贡献了大量的、著名的开源组件，包括Eureka， Hystrix， Zuul ，Ribbon 等，可以说是功勋卓著。
* Service Mesh 说：现在在微服务的执行过程中，需要一个依赖库，实现微服务的发现，监控和保护， 这个依赖库和和业务密切绑定,把依赖库和业务剥离开.Google趁机落子，和IBM等大佬提出了一个Service Mesh的框架，叫做Istio
* Google还有gRPC来进行微服务之间的调用，支持多语言，多种平台，并且面向HTTP/2.
* Google提出的序列化协议是Protocol Buffers，这个序列化机制也是语言中立，平台中立的，性能高，数据传输过程中压缩得比较小。

# 本地优先（local-first）

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
    - 本地优先的应用在内核中具有更好的隐私和安全性。本地设备只存储自己的数据，避免了集中的云数据库来保存每个人的数据。本地优先应用可以使用 * 端到端加密，* 这样存储文件副本的任何服务器都只能保存而无法读取的加密数据。
        + iMessage，WhatsApp和Signal等现代消息传递应用已经使用端到端加密，Keybase提供加密文件共享和消息传递，Tarsnap采用这种方法进行备份。我们希望看到这种趋势也扩展到其他类型的软件。
* 保留最终控制权
    - 通过云应用程序，服务提供商（而非个人）对个人可以做的事情有最终发言权。
    - 在本地优先应用中，我们可以做的只受物理定律的约束，而不受任何服务条款的约束。
    - 根据欧洲人权公约，自由的思想和观点是无条件的 — 国家永远不会干扰它，因为它是你自己的 — 而表达自由（包括言论自由），可以在某些方面受到限制，因为它影响到其他人。社交网络这样的传播服务传递着表达方式，但创意人的原始笔记和未发表的作品是一种发展思想和观点的方式，因此需要无条件的保护。

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
    - [feiskyer/azure-auth-go](https://github.com/feiskyer/azure-auth-go):Go library for authorizing with Azure
    - [MicrosoftDocs/azure-docs](https://github.com/MicrosoftDocs/azure-docs):Open source documentation of Microsoft Azure https://docs.microsoft.com/azure
* Google Cloud Platform
    - [googleapis/google-cloud-python](https://github.com/googleapis/google-cloud-python):Google Cloud Client Library for Python https://googleapis.github.io/google-cloud-python/
* [腾讯云](https://cloud.tencent.com/) `ssh -q -l ubuntu -p 22 IP`

* [GetStream/awesome-saas-services](https://github.com/GetStream/awesome-saas-services):A curated list of the best in class SaaS services for developers and business owners.
* [LeanCLoud](https://leancloud.cn/)
    - [leancloud/ticket](https://github.com/leancloud/ticket)
* [QiNiu](https://www.qiniu.com/)
* [Pivotal](http://pivotal.io):建立在VMware Cloud Foundry上，可以在本地运行，也可以在云端运行。应用程序可以扩展到几百个实例，它随带诸多服务，比如负载均衡、自动化健康管理、日志及审计以及自动化配置。
* [ibm](https://cloud.ibm.com)
* [华为云](https://www.huaweicloud.com/)
