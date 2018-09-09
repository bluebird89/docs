# [saltstack/salt](https://github.com/saltstack/salt)

Software to automate the management and configuration of any infrastructure or application at scale. Get access to the Salt software package repository here: https://repo.saltstack.com/

## 工作原理

* 实时通信：所有的salt minions都是同时接收到命令的。那意味着更新10或10000个系统所花的时间非常相近，并且能够在数秒钟内查询数千个系统。saltstack获取关于你基础设施的信息方法是实时查询的，而不是依赖数据库。
* 各司其职：salt minions只做属于它们自己的工作。Salt master发送的是一组轻量级的指令，基本上是包含”如果你是一个带有这些属性的minion:运行这些带参数的命令”。当接收到命令时，由salt minions判断是否与属性匹配。每个salt minion已经有需要存储在本地的所有命令，所以命令能够被执行和其结果很快地返回给salt master。
* Saltstack设计用于高性能和可扩展性。saltstack的通信系统在salt master与minions之间使用ZeroMQ或原始TCP建立一条持久的数据通道，给予saltstack相对于竞争方案相当大的性能优势。消息使用MessagePack进行高效序列化。在内部，salt使用Python Tornado作为一个异步网络库，而且使用了多线程和并发这些前沿的技术来进一步优化salt性能。用户在生产环境中的单台master管理超过10000台minions并不是不常见，目前所知有越过35000台minions由单台salt master管理！salt已经证明了其在真实环境中的速度和可扩展性。
* 规范化：是saltstack跨平台管理功能的关键。不管你的目标机器是Linux, Windows, MacOS, FreeBSD, Solaris, AIX，物理硬件，云主机或容器，salt命令和状态都运行一致。salt抽象每个操作系统，硬件类型和系统工具的详细信息以便你能正确地管理你的基础设施。规范化一切还包括返回：salt命令返回以一致的数据结构的结果以方便解析和存储。
* salt几乎都能运行在安装有Python的所有设备。对于不支持Python的那些设备，你可以使用minion代理系统。这意味着能够被salt管理的唯一条件是支持任意的网络协议(甚至是你自己写的协议)。salt命令被发送到minion代理服务器，它将salt调用转换为本地协议，然后发送到设备。解析从设备返回的数据，然后放入数据结构并返回。
* salt的事件驱动基础设施不仅让你能够自动化初始系统配置，也让你能够自动化扩展，修复和完成持续管理。salt用户自动部署和维护复杂的分布式网络应用程序和数据库，自定义应用程序，文件，用户帐户，标准包，云资源等。
* salt的远程执行能力是CLI命令，状态系统使用YAML来描述系统的所需配置


## 参考

* [THE SALT OPEN SOURCE SOFTWARE PROJECT](https://saltstack.com/community/)
