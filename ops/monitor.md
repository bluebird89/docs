# 监控

* 目标
  - 对系统不间断实时监控:实际上是对系统不间断的实时监控(这就是监控)
  - 实时反馈系统当前状态:监控某个硬件、或者某个系统，都是需要能实时看到当前系统的状态，是正常、异常、或者故障
  - 保证服务可靠性安全性:监控的目的就是要保证系统、服务、业务正常运行
  - 保证业务持续稳定运行:如果监控做得很完善，即使出现故障，能第一时间接收到故障报警，在第一时间处理解决，从而保证业务持续性的稳定运行。

## 方法

* 了解监控对象:我们要监控的对象你是否了解呢？比如CPU到底是如何工作的？
* 性能基准指标:我们要监控这个东西的什么属性？比如CPU的使用率、负载、用户态、内核态、上下文切换。
* 报警阈值定义:怎么样才算是故障，要报警呢？比如CPU的负载到底多少算高，用户态、内核态分别跑多少算高？
* 故障处理流程:收到了故障报警，那么我们怎么处理呢？有什么更高效的处理流程吗？

## 核心

* 发现问题:当系统发生故障报警，我们会收到故障报警的信息
* 定位问题:故障邮件一般都会写某某主机故障、具体故障的内容，我们需要对报警内容进行分析，比如一台服务器连不上:我们就需要考虑是网络问题、还是负载太高导致长时间无法连接，又或者某开发触发了防火墙禁止的相关策略等等，我们就需要去分析故障具体原因。
* 解决问题:当然我们了解到故障的原因后，就需要通过故障解决的优先级去解决该故障。
* 总结问题:当我们解决完重大故障后，需要对故障原因以及防范进行总结归纳，避免以后重复出现。

## 工具

* MRTG（Multi Route Trffic Grapher）是一套可用来绘制网络流量图的软件，由瑞士奥尔滕的Tobias  Oetiker与Dave Rand所开发，以GPL授权。
  - MRTG最好的版本是1995年推出的，用perl语言写成，可跨平台使用，数据采集用SNMP协议，MRTG将手机到的数据通过Web页面以GIF或者PNG格式绘制出图像。
* Grnglia是一个跨平台的、可扩展的、高性能的分布式监控系统，如集群和网格。它基于分层设计，使用广泛的技术，用RRDtool存储数据。具有可视化界面，适合对集群系统的自动化监控。其精心设计的数据结构和算法使得监控端到被监控端的连接开销非常低。目前已经有成千上万的集群正在使用这个监控系统，可以轻松的处理2000个节点的集群环境。
* Cacti（英文含义为仙人掌）是一套基于PHP、MySQL、SNMP和RRDtool开发的网络流量监测图形分析工具，它通过snmpget来获取数据使用RRDtool绘图，但使用者无须了解RRDtool复杂的参数。提供了非常强大的数据和用户管理功能，可以指定每一个用户能查看树状结构、主机设备以及任何一张图，还可以与LDAP结合进行用户认证，同时也能自定义模板。在历史数据展示监控方面，其功能相当不错。
  - Cacti通过添加模板，使不同设备的监控添加具有可复用性，并且具备可自定义绘图的功能，具有强大的运算能力（数据的叠加功能）
* Nagios是一个企业级监控系统，可监控服务的运行状态和网络信息等，并能监视所指定的本地或远程主机状态以及服务，同时提供异常告警通知功能等。
  - Nagios可运行在Linux和UNIX平台上。同时提供Web界面，以方便系统管理人员查看网络状态、各种系统问题、以及系统相关日志等
  - Nagios的功能侧重于监控服务的可用性，能根据监控指标状态触发告警。
  - 目前Nagios也占领了一定的市场份额，不过Nagios并没有与时俱进，已经不能满足于多变的监控需求，架构的扩展性和使用的便捷性有待增强，其高级功能集成在商业版Nagios XI中。
* [Smokeping](http://tobi.oetiker.cn/hp)主要用于监视网络性能，包括常规的ping、www服务器性能、DNS查询性能、SSH性能等。底层也是用RRDtool做支持，特点是绘制图非常漂亮，网络丢包和延迟用颜色和阴影来标示，支持将多张图叠放在一起，其作者还开发了MRTG和RRDtll等工具。
* 开源监控系统OpenTSDB用Hbase存储所有时序（无须采样）的数据，来构建一个分布式、可伸缩的时间序列数据库。它支持秒级数据采集，支持永久存储，可以做容量规划，并很容易地接入到现有的告警系统里。
  - OpenTSDB可以从大规模的集群（包括集群中的网络设备、操作系统、应用程序）中获取相应的采集指标，并进行存储、索引和服务，从而使这些数据更容易让人理解，如Web化、图形化等。
* Zabbix是一个分布式监控系统，支持多种采集方式和采集客户端，有专用的Agent代理，也支持SNMP、IPMI、JMX、Telnet、SSH等多种协议，它将采集到的数据存放到数据库，然后对其进行分析整理，达到条件触发告警。其灵活的扩展性和丰富的功能是其他监控系统所不能比的。相对来说，它的总体功能做的非常优秀。
* 小米的监控系统：open-falcon。open-falcon的目标是做最开放、最好用的互联网企业级监控产品。
* [OWL](https://github.com/TalkingData/owl)是TalkingData公司推出的一款开源分布式监控系统OWLgithub地址
* 从以上各种监控系统的对比来看，Zabbix都是具有优势的，其丰富的功能、可扩展的能力、二次开发的能力和简单易用的特点，读者只要稍加学习，即可构建自己的监控系统。

## 流程

* 数据采集:Zabbix通过SNMP、Agent、ICMP、SSH、IPMI等对系统进行数据采集
* 数据存储:Zabbix存储在MySQL上，也可以存储在其他数据库服务
* 数据分析:当我们事后需要复盘分析故障时，zabbix能给我们提供图形以及时间等相关信息，方面我们确定故障所在。
* 数据展示:web界面展示、(移动APP、java_php开发一个web界面也可以)
* 监控报警:电话报警、邮件报警、微信报警、短信报警、报警升级机制等（无论什么报警都可以）
* 报警处理:当接收到报警，我们需要根据故障的级别进行处理，比如:重要紧急、重要不紧急，等。根据故障的级别，配合相关的人员进行快速处理

## 指标

* 硬件监控
  - 系统自带的IPMI模板只能监控，风扇，电源，和部分温度
  - IPMI工具无法获取到硬件的状态，可以借助MegaCli工具探测Raid磁盘队列状态
  - zabbix提供IPMI监控模板：Zabbix IPMI Interface
* 系统监控
  - CPU
    + 上下文切换
    + 运行队列 不要高于3
    + 使用率 用户态/内核态 比例维持在70/30，空闲状态维持在50%
    + 工具:htop、top、vmstat、mpstat、dstat、glances
    + zabbix提供系统监控模板：Zabbix Agent Interface
  - 内存：通常需要监控内存的使用率、SWAP使用率、同时可以通过zabbix描绘内存使用率的曲线图形发现某服务内存溢出等
    + free、top、vmstat、glances
  - IO分为磁盘IO和网络IO。除了在做性能调优我们要监控更详细的数据外，那么日常监控，只关注磁盘使用率、磁盘吞吐量、磁盘写入繁忙程度，网络也是监控网卡流量即可
    + 工具：iostat、iotop、df、iftop、sar、glances
* 应用监控
  - LVS、Haproxy、Docker、Nginx、PHP、Memcached、Redis、MySQL、Rabbitmq等等，相关的服务都需要使用zabbix监控起来。
  - apache web 服务监控
  - mysql 数据库监控
  - 磁盘空间监控
  - zabbix提供应用服务监控：Zabbix Agent UserParameter
  - zabbix提供的Java监控：Zabbix JMX Interface
  - percona提供MySQL数据库监控：percona-monitoring-plulgins
* 网络监控
  - Smokeping 是rrdtool的作者Tobi Oetiker的作品，是用Perl写的，主要是监视网络性能，www 服务器性能，dns查询性能等，使用rrdtool绘图，而且支持分布式，直接从多个agent进行数据的汇总。
  - 网卡进入的数据量和网卡流出的数据量成比例
  - 要监管，先要建立网络管理协议，被监控的服务器全部开放smp，161端口
  - 监控者监控被监控者，mrtg监控图
  - cacti监控原理
* 流量分析
  - google出一个叫piwik的开源分析工具
* 日志监控
  - ELK logstash（收集） + elasticsearch（存储+搜索） + kibana（展示）:做整体的监控基础组件，同时使用 Elastic 新推出的 beat 系列作为采集工具
* 安全监控
  - 开源的安全产品不少，比如四层iptables，七层WEB防护nginx+lua实现WAF
* API监控
  - 可用性、正确性、响应时间为三大重性能指标
* 性能监控
  - 监控网页性能，DNS响应时间、HTTP建立连接时间、页面性能指数、响应时间、可用率、元素大小等
  - zabbix提供URL监控：Zabbix Web 监控
* 业务监控
* 监控报警
* 报警处理

## 数据收集组件

* telegraf:用来收集监控项，influxdata家族的一员，是一个用Go编写的代理程序,可收集系统和服务的统计数据,并写入到多种数据库。支持的类型可谓非常广泛。
* flume 主要用来收集日志类数据，apache家族。Flume-og和Flume-ng版本相差很大，是一个高可用的，高可靠的，分布式的海量日志采集、聚合和传输的系统。 Flume支持在日志系统中定制各类数据发送方，用于收集数据；同时，Flume提供对数据进行简单处理，并写到各种数据接受方（可定制）的能力。
* Logstash Logstash是一个开源的日志收集管理工具，elastic家族成员。功能和flume类似，但占用资源非常的贪婪，建议使用时独立部署。功能丰富，支持ruby定义过滤条件。
* StatsD node开发，使用udp协议传输，专门用来收集数据，收集完数据就发送到其他服务器进行处理。与telegraf类似。
* CollectD collectd是一个守护(daemon)进程，用来定期收集系统和应用程序的性能指标，同时提供了机制，以不同的方式来存储这些指标值。

* 可视化:独立的可视化组件比较少，不过解决方案里一般都带一个web端，像grafana这么专注的，不太多。
  - Grafana 专注展示，颜值很高，集成了非常丰富的数据源。通过简单的配置，即可得到非常专业的监控图。
* 存储 Grafana Plugins - extend and customize your Grafana.
  - InfluxDB influx家族产品。Influxdb是一个开源的分布式时序、时间和指标数据库，使用go语言编写，无需外部依赖。支持的数据类型非常丰富，性能也很高。单节点使用时不收费的，但其集群要收费。
  - OpenTSDB OpenTSDB是一个时间序列数据库。它其实并不是一个db，单独一个OpenTSDB无法存储任何数据，它只是一层数据读写的服务，更准确的说它只是建立在Hbase上的一层数据读写服务。能够承受海量的分布式数据。
  - Elasticsearch 能够存储监控项，也能够存储log，trace的关系也能够存储。支持丰富的聚合函数，能够实现非常复杂的功能。但时间跨度太大的话，设计的索引和分片过多，ES容易懵逼。
* anglia:核心包含gmond、gmetad以及一个Web前端。主要是用来监控系统性能，如：cpu 、mem、硬盘利用率， I/O负载、网络流量情况等，通过曲线很容易见到每个节点的工作状态，对合理调整、分配系统资源，提高系统整体性能起到重要作用。
* [pyflame](https://github.com/uber/pyflame):非侵入式得对运行中的 python 进程做 snapshot, 输出成 svg
  - `pyflame -s 60 -r 0.01 ${pid} | flamegraph.pl > myprofile.svg`
* [newrelic](https://newrelic.com/)
* [netdata](https://github.com/netdata/netdata):Real-time performance monitoring, done right! <https://my-netdata.io/>
* [Monit](link)
* CAT:作为美团点评基础监控组件，已经在中间件框架（MVC框架，RPC框架，数据库框架，缓存框架等）中得到广泛应用，为美团点评各业务线提供系统的性能指标、健康状况、基础告警等。
* Grafana求，配合 Prometheus 以及 Prometheus 相关的 Exporter

![Alt text](../_static/monitor_tools.jpg "Optional title")

## TICK (Telegraph、InfluxDB、Chronograf、Kapacitor)

## [skywalking](https://github.com/apache/skywalking)

APM, Application Performance Monitoring System <https://skywalking.apache.org/>

## [Raygun](https://raygun.com/)

* 领先的错误监控以及崩溃报告的平台。应用程序性能监控（APM）是其最近的项目。Raygun的DevOps工具帮助用户分析性能问题，并且定位到代码的某一行，某个function或者API调用。APM工具和Raygun的错误管理工作流可以协同工作。比如，它自动定位最高优先级的问题，并创建issue。
* 应用程序性能监控： <https://raygun.com/platform/apm>

## [Nagios](https://www.nagios.org/)

* 最流行的免费并开源的DevOps监控工具
* 功能
  - 可以监控基础架构从而帮助用户发现并解决问题。
  - 记录事件，运行中断以及故障。
  - 通过Nagios的图表和报告监控趋势。
  - 预测运行中断和错误，并且发现安全攻击。
* 因为其丰富的插件生态而脱颖而出。提供了四中开源监控解决方案：
  - 插件生态： <https://exchange.nagios.org/>
  - 功能的比对： <https://www.nagios.org/downloads/nagios-core/>
  - Nagios Core：一个命令行工具，提供了所有基本功能
  - Nagios XI：提供了基于网页的GUI以及监控向导程序
  - Nagios Log Server
  - Nagios Fusion

## datadog

## catchpoint

## 工具

* [glances](https://github.com/nicolargo/glances):Glances an Eye on your system. A top/htop alternative for GNU/Linux, BSD, Mac OS and Windows operating systems. <http://nicolargo.github.io/glances/>
* [plausible](https://github.com/plausible-insights/plausible):Simple, lightweight analytics for your website <https://plausible.io>
* [fathom](https://github.com/usefathom/fathom):Fathom. Simple, trustworthy website analytics. Built with Golang & Preact. <https://usefathom.com/>
* [countly-server](https://github.com/Countly/countly-server):Countly helps you get insights from your application. Available self-hosted or on private cloud. <https://count.ly>
* [spug](https://github.com/openspug/spug):开源运维平台：面向中小型企业设计的轻量级无Agent的自动化运维平台，整合了主机管理、主机批量执行、主机在线终端、应用发布部署、在线任务计划、配置中心、监控、报警等一系列功能。 <https://spug.dev>
* [simpleops](https://simpleops.io/):Performance monitoring simplified
* htop:运行于 Linux 系统监控与进程管理软件，用于取代 Unix 下传统的 top。与 top 只提供最消耗资源的进程列表不同，htop 提供所有进程的列表，并且使用彩色标识出处理器、swap 和内存状态
* [psutil](https://github.com/giampaolo/psutil):Cross-platform lib for process and system monitoring in Python
