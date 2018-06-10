# SRE

站点可靠性工程(Site Reliability Engineering)：

## 黄金指标

称为“黄金”指标，最重要的原因之一在于其直接衡量的事物会对系统的最终用户及工作生产环节产生影响——换言之，其是在直接衡量最关键的对象。

* 来自谷歌 SRE 书: 延迟、流量、错误以及饱和度；
* USE 方法(来自 Brendan Gregg): 利用率、饱和度与错误；
* RED 方法(来自 Tom Wilkie): 速率、错误与持续时间。

### 指标

* 速率：请求速率，请每秒请求数量。
* 错误： — 错误率，即每秒错误数量。
* 延迟：— 响应时间，包括队列 / 等待时间，以毫秒为单位。
* 饱和度：—即过载程度，这项指标与资源利用率相关，但也可通过队列深度（或者并发水平）等方式进行直接衡量。从队列深度的角度来理解，当系统逐渐趋于饱和时，队列深度将由零变为非零。饱和度指标通常体现为计数器形式。
* 利用率： — 资源或系统的繁忙程度。通常表示为 0% 至 100%，这项指标对预测而言非常重要（同样重要的还有饱和度指标）。请注意，这里我们并没有使用“利用率法则”的定义，即速率 x 服务时间 / 工作程序，而是选择了大家更为熟悉的直接衡量指标。

### 判断标准

* 警报：当问题出现时，及时向我们上报。
    - 警报机制利用静态阈值对我们的 Nagios、Zabbix 以及 DataDog 等系统进行监控。在设定方面难度较大，且往往会产生大量噪声
    - 不要忘记设置下限警报，例如每秒近零请求或延迟等，这些通常都意味着问题的存在（包括凌晨 3 点这类低流量时段）。
    - 中位值通常不会受到过大 / 过小偏离值的影响。
    - 百分位数。举例来说，大家可以对位于第 95 百分位上的延迟值进行追踪，这将更好地衡量用户的实际体验。如果第 95 百分位延迟较为理想，则可认定绝大多数用户都具备良好的使用体验。
    - 异常检测非常适用于捕捉非峰值期间或引发低指标值的问题。此外，异常检测还能够提供更为密集的警报提醒，从而降低问题发现难度（但不要介入太早，否则大家可能遭遇误报困境）。Datadog 以及 SignalFX 等新一代 SaaS/ 云监控解决方案能够实现上述目标，而 Prometheus 以及 InfluxDB 等内部系统也拥有这样的检测能力。
    - Weave Works 就拥有一套包含两个图形列的良好格式，Splunk 则提供出色的视图。界面左侧为请求与错误率堆叠图，右侧则为延迟图。
    - 工程师必须把所有线索连接起来，并对警报信息进行全面挖掘——即使其单纯体现为高 CPU 占用率或低内存余量。然而，黄金指标的抽象程度通常更高，且往往会一次性出现大量此类指标——具体来讲，来自某一低级别服务的单一高延迟问题，亦可能导致系统层面的大范围延迟及错误警报。
* 故障排查：帮助我们发现并解决问题。
* 调整与容量规划：帮助我们让运行状态更加顺畅。

## 负载均衡器

* HAProxy: 人人喜爱的非云负载均衡器，HAProxy 亦拥有强大的日志记录功能以及一套不错的用户界面
    - 注意
        + 大多数（甚至全部）HAProxy 版本只面向单一进程报告统计数据，这种方法对于 99% 的用例都没有问题，但极少数高性能系统会使用多进程模式，这意味着其监控难度将直线提升。因为统计数据将随机提取自某一进程，这可能引发混乱，因此大家必须尽可能避免多进程监控情况。
        + HAProxy 当中的实用统计信息包括 PER 监听程序、后端或者服务器几种，虽然这些指标都很重要，但却会给整体评估带来复杂性挑战。简单的网站或应用程序通常只有一个（www.）监听程序与后端，但更为复杂的系统却通常包含多个监听程序与后端。这意味着我们会很快收集到数百项指标并陷入混乱。
    - 使用
        + 从内置网页当中提取 CSV 数据
        + 使用 CLI 工具
        + 使用 Unix Socket
    - 指标
        + 请求率：即每秒请求数量，我们可以使用以下两种方式：
            - 请求 Count REQ_TOT 不适用于每服务器，而仅计算全部服务器的总体请求率（虽然仅限于最后一秒）。
            - 你也可以使用 REQ_RATE (每秒请求)，但其仅限于最后一秒，因此大家可能会错过数据峰值时段——特别是你的监控时长在一分钟以下时。
        + 错误率：响应错误（简称 ERESP），代表来自后端的错误数量。这是一个计数器，因此你必须对其进行增量计算。不过需要注意的是，相关文档指出其中包含“客户端套接上的写入错误”，所以我们很难搞清这一数值中包含哪些客户端错误类型（特别是在移动设备上）。大家也可以使用这种方法获取每后端服务器信号。关于更多细节信息以及纯 HTTP 错误，大家通常会得到 4xx 及 5xx 错误计数，用户对这类提示也表现得最为敏感。其中 4xx 错误通常不属于客户自身的问题，但如果其突然出现，则通常源自代码错误或者某种形式的攻击。而监控 5xx 错误对于所有系统都非常重要。   你可能还希望查看请求错误（简称 EREQ），但请注意，这类错误中包括可能带来大量噪声的客户端关闭（特别是在低速或移动网络情况下）。仅限于前端。
        + 延迟：即每后端响应时间（简称 RTIME），代表过去 1024 条请求的平均延迟（在繁忙系统上，1024 条请求周期可能太短并导致错失峰值状况 ; 但在新启动的系统上，1024 条请求周期可能太长而混入大量噪声）。此项信号适用于每服务器。
        + 饱和度：队列请求的数量（简称 QCUR）。这一信号适用于后端（代表未被分配至服务器的请求）以及每服务器（代表未被发送至目标服务器的请求）。你可能需要将各项数值相加以计算整体饱和度，或追踪每服务器信号以了解单服务器饱和度（详见 Web 服务器章节）。如果使用每服务器监控方式，则应追踪每套后端服务器的饱和度（但请注意，该服务器自身可能同样在排队，因此负载均衡器中的任何队列都代表着一项严重问题）。
        + 利用率：HAProxy 通常不会耗尽全部容量，除非 CPU 资源已经被全部占用，但你也可以监控实际会话 SCUR/SLIM。
* AWS ELB: 弹性负载均衡服务：各项指标将通过 Cloud Watch 与推送至 S3 的日志共同实现提取。其格式易于处理，但处理 S3 中的日志却稍有难度，因此我们会尽量避免这种处理方法（部分原因在于，我们无法立足 S3 中的日志进行实时处理，也无法借此实现警报机制
    - ELB 指标适用于 ELB 整体，但遗憾的是无法由后端组或服务器处提取。需要注意的是，若每个可用区内只有一套后端服务器，则可使用可用区维度过滤器。
    - 将信号映射至 ELB 后，我们可从 CloudWatch 处获取全部信号。请注意，指标当中的 sum() 部分为 CloudWatch 的统计函数。具体指标包括
        + 请求率：每秒请求数量，即我们从 sum(RequestCount) 得到的指标再除以配置 CloudWatch 采样时间（ 1 或 5 分钟）。其中包含请求错误。
        + 错误率：大家还应添加以下两项指标： sum(HTTPCode_Backend_5XX) 与 sum(HTTPCode_ELB_5XX)，二者分别负责捕捉服务器产生的错误与负载均衡器产生的错误（请务必计量因队列已满造成的后端不可用与拒绝情况）。你可能还需要添加 sum(HTTPCode_Backend_5XX)。
        + 延迟：即平均延迟值。就这么简单。
        + 饱和度—即在后端队列当中获取请求的 max(SurgeQueueLength)。需要注意的是，其仅关注后端饱和度，而非负载均衡器自身在 CPU 上的饱和度（在自动规模伸缩之前）——后者目前似乎尚无法监控。你也可以监控并警报 sum(SpilloverCount)，若其〉0 则代表负载均衡器已经饱和，且由于 Surge Queue 已满而拒绝后续请求。与 5xx 错误一样，这代表已经出现非常严重的问题。
        + 利用率：目前还没有比较好的 ELB 利用率数据获取办法，因为 ELB 会在内部容量不足以进行自动规模伸缩（但可以抢在规模扩展之前进行提取）。
    - 如果大家需要计算上述信号的百分位与统计指标，请务必阅读 CloudWatch 说明文档中“典型负载均衡器指标统计数据”部分提到的警告与问题。
* AWS ALB: 应用负载均衡器
    - 指标适用于 ALB 整体，且可由目标组（通过维度过滤器）提供，大家可以借此获取给定一组后端服务器的数据（而无需直接监控 Web/ 应用服务器）。ALB 不提供每服务器数据（不过你可以根据可用区进行过滤，这样若你在每个可用区内仅拥有一套目标后端服务器，即可实现每服务器监控）。
        + 请求率：每秒请求数量，即我们从 sum(RequestCount) 得到的指标再除以配置 CloudWatch 采样时间（ 1 或 5 分钟）。其中包含请求错误。
        + 错误率：大家还应添加以下两项指标： sum(HTTPCode_Backend_5XX) 与 sum(HTTPCode_ELB_5XX)，二者分别负责捕捉服务器产生的错误与负载均衡器产生的错误（请务必计量因队列已满造成的后端不可用与拒绝情况）。你可能还需要添加 sum(TargetConnectionErrorCount)。
        + 延迟：即平均延迟值。就这么简单。
        + 饱和度— 我们似乎无法从 ALB 处获取任何队列数据，因此这里我们只使用 sum（RejectedConnectionCount），其负责对 ALB 达到最大连接数量后的拒绝连接进行计数。
        + 利用率—目前还没有比较好的 ELB 利用率数据获取办法，因为 ELB 会在内部容量不足以进行自动规模伸缩（但可以抢在规模扩展之前进行提取）。需要注意的是，你可以监控 sum(ActiveConnectionCount) 与最大连接数量——需要以手动方式或者通过 AWS Config 方可获取。

通过两种方式审视负载均衡器信号，立足前端或立足后端。在前端方面，我们需要面向不同域或网站部分（例如 API 以及验证等）关注数种信号。

* 较关注负载均衡器的总体信号（OVERALL），即面向所有前端。当然，如果分别有不同系统对接 Web、应用、API 以及搜索等对象，我们也可能需要分别追踪与之对应的各前端。这意味着我们将独立处理功能各异的单独信号。
* 某些系统对于 HTTP 与 HTTPS 采用不同的监听程序 / 后端，但其支持几乎相同的 URL，因此大家完全可以将合并为统一视图并进行实际监控。


## WEB


## Linux

## 参考

* 《利用 USE 与 RED 方法实现监控与观察》：USE 方法主要着眼于资源内部，RED 方法则关注请求、实际工作以及外部视角（即来自服务消费方的视角）。各种方法既彼此相关，亦相辅相成，共同面向每一项服务实现自身效果所消耗的具体资源。
* 《利用异常检测进行监控》