# load test  压力测试

* 考虑条件
  - 并发用户数: 指在某一时刻同时向服务器发送请求的用户总数(HttpWatch)
  - 总请求数
  - 请求资源描述
  - 请求等待时间(用户等待时间)
  - 用户平均请求等待时间（这里暂不把数据在网络的传输时间，还有用户PC本地的计算时间计算入内）：用于衡量服务器在一定并发用户数下，单个用户的服务质量,用户平均请求等待时间 = 服务器平均请求处理时间 * 并发用户数
  - 服务器平均请求处理的时间:吞吐率的倒数
  - 硬件环境

## 全链路压测

压测优化过程就是一个不断优化不断改进的过程，事先通过测试不断发现问题，优化系统，避免问题，指定应急方案

* 分析需压测业务场景涉及系统
* 协调各个压测系统资源并搭建压测环境
* 压测数据隔离以及监控(响应时间、吞吐量、错误率等数据以图表形式实时显示)
* 压测结果统计(平均响应时间、平均吞吐量等数据以图表形式在测试结束后显示)
* 优化单个系统性能、关联流程以及整个业务流程

```sh
yum -y install httpd-tools
ab -v
ab --help

ab -n 1000 -c 100 http://127.0.0.1/
```

## 工具

### [Apache Benchmarking tool](https://httpd.apache.org/docs/2.4/programs/ab.html)

The simplest tool to perform a load testing.

* -A auth-username:password
* -b windowsize Size of TCP send/receive buffer, in bytes.
* -B local-address Address to bind to when making outgoing connections.
* -c concurrency Number of multiple requests to perform at a time. Default is one request at a time.
* -C cookie-name=value Add a Cookie: line to the request. The argument is typically in the form of a name=value pair. This field is repeatable.
* -d     Do not display the "percentage served within XX  [ms]  table".  (legacy  sup‐ port).
* -e csv-file Write  a  Comma separated value (CSV) file which contains for each percentage (from 1% to 100%) the time (in milliseconds) it took to serve that percentage of  the requests. This is usually more useful than the 'gnuplot' file; as the results are already 'binned'.
* -E client-certificate-file When connecting to an SSL website, use the provided client certificate in PEM format  to  authenticate with the server. The file is expected to contain the client certificate, followed by intermediate certificates,  followed  by  the private key. Available in 2.4.36 and later.
* -f protocol Specify  SSL/TLS  protocol (SSL2, SSL3, TLS1, TLS1.1, TLS1.2, or ALL). TLS1.1 and TLS1.2 support available in 2.4.4 and later.
* -g gnuplot-file Write all measured values out as a 'gnuplot' or  TSV  (Tab  separate  values) file. This file can easily be imported into packages like Gnuplot, IDL, Math‐ ematica, Igor or even Excel. The labels are on the first line of the file.
* -h     Display usage information.
* -H custom-header Append extra headers to the request. The argument is typically in the form of a  valid  header  line,  containing a colon-separated field-value pair (i.e., "Accept-Encoding: zip/zop;8bit").
* -i  Do HEAD requests instead of GET.
* -k Enable the HTTP KeepAlive feature, i.e., perform multiple requests within one HTTP session. Default is no KeepAlive.
* -l  Do not report errors if the length of the responses is not constant. This can be useful for dynamic pages. Available in 2.4.7 and later.
* -m HTTP-method Custom HTTP method for the requests. Available in 2.4.10 and later.
* -n requests Number of requests to perform for the benchmarking session. The default is to just  perform  a  single  request  which  usually leads to non-representative benchmarking results.
* -p POST-file File containing data to POST. Remember to also set -T.
* -P proxy-auth-username:password Supply BASIC Authentication credentials to a proxy en-route. The username and password are separated by a single : and sent on the wire base64 encoded. The string is sent regardless of whether the proxy needs it (i.e.,  has  sent  an 407 proxy authentication needed).
* -q     When processing more than 150 requests, ab outputs a progress count on stderr every 10% or 100 requests or so. The -q flag will suppress these messages.
* -r  Don't exit on socket receive errors.
* -s timeout
* -S Do  not  display  the  median  and standard deviation values, nor display the warning/error messages when the average and median are more than one  or  two times  the  standard  deviation apart. And default to the min/avg/max values. (legacy support).
* -t timelimit Maximum number of seconds to spend for benchmarking. This implies a -n  50000 internally.  Use  this to benchmark the server within a fixed total amount of time. Per default there is no timelimit.
* -T content-type Content-type header to use for POST/PUT data, eg.  application/x-www-form-ur‐ lencoded. Default is text/plain.
* -u PUT-file File containing data to PUT. Remember to also set -T.
* -v verbosity Set  verbosity level - 4 and above prints information on headers, 3 and above prints response codes (404, 200, etc.), 2 and above prints warnings and info.
* -V     Display version number and exit.
* -w     Print out results in HTML tables. Default table is two columns wide,  with  a white background.
* -x `<table>`-attributes String  to use as attributes for `<table>.` Attributes are inserted `<table here >`.
* -X proxy`[:port] `Use a proxy server for the requests.
* -y` <tr>`-attributes String to use as attributes for `<tr>`.
* -z `<td>`-attributes String to use as attributes for `<td>`.
* -Z ciphersuite Specify SSL/TLS cipher suite (See openssl ciphers)

```sh
# apache ab
yum install apr-util
ab -n 5000 -c 50 https://www.baodu.com
```

###  [jmeter](https://github.com/apache/jmeter)

a 100% pure Java application designed to test and measure performance. It may be used as a highly portable server benchmark as well as multi-client load generator. Apache JMeter是Apache组织开发的基于Java的压力测试工具。用于对软件做压力测试，最初被设计用于Web应用测试，但后来扩展到其他测试领域。

* 用于测试静态和动态资源，例如静态文件、Java小服务程序、CGI 脚本、Java 对象、数据库、FTP 服务器等,测试数据库
* JMeter 可以用于对服务器、网络或对象模拟巨大的负载，来自不同压力类别下测试它们的强度和分析整体性能
* JMeter能够对应用程序做功能/回归测试，通过创建带有断言的脚本来验证你的程序返回了你期望的结果
* 为了最大限度的灵活性，JMeter允许使用正则表达式创建断言
* 安装
    - [下载](http://jmeter.apache.org/download_jmeter.cgi)
    - 解压文件
    - 运行：'sh bin/jmeter'(linux) 或 运行 bin/jmeter.bat(windows)
* 结构
    - JMETER_HOME/lib:用来放使用的 jar 文件
    - JMETER_HOME/lib/ext:用来放 JMeter 组件和扩展
* 配置 测试计划
* 组件
    - 配置元件（Config Element）：影响其作用范围内的所有元件。收集其作用范围的每一个sampler元件的信息并呈现。元件的作用域是靠测试计划的的树型结构中元件的父子关系来确定的
    - 前置处理器（Pre Processors）：在其作用范围内的每一个sampler元件之前执行。
    - 定时器（Timer）：对其作用范围内的每一个sampler 有效
    - 取样器（sampler）：性能测试中向服务器发送请求，记录响应信息，记录响应时间的最小单元.不与其它元件发生交互作用的元件
    - 后置处理器（Post Processors，只在有结果可用情况下执行）：在其作用范围内的每一个sampler元件之后执行。
    - 断言（Assertions，只在有结果可用情况下执行）：对其作用范围内的每一个sampler 元件执行后的结果执行校验。
    - 监听器（Listener，只在有结果可用情况下执行）：收集其作用范围的每一个sampler元件的信息并呈现。
* 流程
    - 添加线程组（thread groups）:并发线程数量、间隔与循环次数
    - 添加sampler请求：http访问实例
    - 添加结果监听方式以及结果记录保存方式：添加动态参数用与不同测试
* 作用域
* 指标
    - 数据库指标
      + User Connections：用户连接数，也就是数据库的连接数量；
      + Number of Deadlocks：数据库死锁；
      + Butter Cache Hit：数据库Cache的命中情况。
* [User's Manual](http://jmeter.apache.org/usermanual/)

```sh
# Mac
brew install jmeter
jmeter
```

###  iperf

###  wrk

* 线程数，并不是设置的越大，压测效果越好，线程设置过大，反而会导致线程切换过于频繁，效果降低，一般来说，推荐设置成压测机器 CPU 核心数的 2 倍到 4 倍就行了
* 用来模拟用户使用的实际场景:编写 Lua 脚本

```sh
wrk -v
wrk --help

-c, --connections <N>  Connections to keep open
-d, --duration    <T>  Duration of test
-t, --threads     <N>  Number of threads to use
-s, --script      <S>  Load Lua script file
-H, --header      <H>  Add header to request
    --latency          Print latency statistics
    --timeout     <T>  Socket/request timeout
-v, --version          Print version details
Numeric arguments may include a SI unit (1k, 1M, 1G)
Time arguments may include a time unit (2s, 2m, 2h)

wrk -t12 -c400 -d30s http://www.baidu.com # 线程数为 12，模拟 400 个并发请求，持续 30 秒
wrk -t12 -c400 -d30s --latency http://www.baidu.com # 生成如下压测报告


wrk -t5 -c5 -d30s http://www.baidu.com
```

###  http_load

###  webench

```sh
# webench
wget http://blog.zyan.cc/soft/linux/webbench/webbench-1.5.tar.gz
tar zxvf webbench-1.5.tar.gz
cd webbench-1.5
make && make install
```

###  [hyperfine](https://github.com/sharkdp/hyperfine)

A command-line benchmarking tool

###  [Siege](https://github.com/JoeDog/siege)

Siege is an http load tester and benchmarking utility

## 并发模型

* JMeter使用多线程模型
  - 多线程模型（Threads）和Java语言来开发
  - 重度依赖于开发语言和操作系统对于多线程的支持，如果语言和操作系统层面对于多线程的支持不好，就会导致这种并发模型出现问题
  - 多线程切换的时候资源消耗比较多，所以和另外两个轻量级的并发模型相比，在同等资源的情况下，产生的有效并发数量会小很多
  - 线程也相对容易产生错误，比如死锁，共享数据错乱等，所以JMeter使用界面的方式也是尽可能地减少了由于二次开发导致的这类错误
  - 优势:可以在操作系统支持的情况下，使用到多核处理器的多个核。但是随着性能测试需求的增多，JMeter为了能满足更多的需求，也在不停地更新功能和增加其插件，比如支持分布式来解决性能不足的问题，支持更多的扩展脚本来满足自定义需求等等。但是其基础并发模型一直沿用多线程模型，导致并发性能没有办法进一步提升，估计在未来可以预见的很长一段时间之内是不会改变的。
* Locust使用事件循环模型
  - 选择了消息循环模型（EventLoop）和Python语言来开发。
  - EventLoop模型最大的优势就是在一个线程里面可以完成大量的并发，从而避免了多线程带来的各种问题。与此同时它带来的问题就是无法同时使用多核处理器的多个核，从而无法充分使用硬件资源。不过可以通过Locust提供了分布式的方法来使用多核。
  - Locust的并发模型里面并发用户的数据只能配置一个固定值，并且在Locust运行的过程中是不能改变的。这个特性与JMeter和Gatling都不一样，因为JMeter和Gatling都是可以在运行的过程中改变并发用户数量。
* Gatling使用Actor模型
  - 选择Akka(Actor)模型和Scala语言来开发。由于Actor模型的轻量和高并发性，再加上Scala语言基于JVM，所以Gatling的并发模型结合了JMeter和Locust的优势，其尽可能地避免了多线程存在的一些问题，并可以充分使用硬件资源：多核。
  - Actor模型核心是基于消息传递的，并且使用每个虚拟用户基于一个Actor就可以做到相对独立，并通过消息传递进行通信。
  - 具有和消息循环模型同样在单线程里面进行高并发的能力。并且它还可以在运行时轻松地动态增加和减少并发虚拟用户数（Actor）。虽然其并发模型十分优秀，但是需要使用Scala语言来进行开发，使得很多测试人员望而却步，导致Gatling的使用量并不是很广泛。
* 后起之秀K6，使用CSP模型

## 工具

* LoadRunner
* [k6](https://k6.io/):The best developer experience for load testing
* [wrk](https://github.com/wg/wrk): Modern HTTP benchmarking tool
* [gatling](https://github.com/gatling/gatling) Async Scala-Akka-Netty based Load Test Tool <http://gatling.io>
* [sniper](https://github.com/btfak/sniper): A powerful & high-performance http load tester
* [hey](https://github.com/rakyll/hey): HTTP load generator, ApacheBench (ab) replacement, formerly known as rakyll/boom
    - <https://www.sitepoint.com/web-app-performance-testing-siege-plan-test-learn/>
* [http_load](http://www.acme.com/software/http_load/): http_load runs multiple http fetches in parallel, to test the throughput of a web server.
* [t50](https://github.com/fredericopissarra/t50): mixed packet injector tool
* [GoReplay](https://github.com/buger/goreplay): GoReplay is an open-source tool for capturing and replaying live HTTP traffic into a test environment in order to continuously test your system with real data. It can be used to increase confidence in code deployments, configuration changes and infrastructure changes. <https://goreplay.org>
* [tcpcopy](https://github.com/session-replay-tools/tcpcopy): An online request replication tool, also a tcp stream replay tool, fit for real testing, performance testing, stability testing, stress testing, load testing, smoke testing, etc
* [gryphon](https://github.com/wslfa/gryphon): Gryphon是由网易自主研发的能够模拟千万级别并发用户的一个软件，目的是能够用较少的资源来模拟出大量并发用户，并且能够更加真实地进行压力测试， 以解决网络消息推送服务方面的压力测试的问题和传统压力测试的问题。Gryphon分为两个程序，一个运行gryphon，用来模拟用户，一个是 intercept，用来截获响应包信息给gryphon。Gryphon模拟用户的本质是用一个连接来模拟一个用户，所以有多少个连接，就有多少个用户，而用户的素材则取自于pcap抓包文件。值得注意的是，Gryphon架构类似于tcpcopy，也可以采用传统使用方式和高级使用方式。
* [locust.io](http://locust.io/): An open source load testing tool. Define user behaviour with Python code, and swarm your system with millions of simultaneous users.
* [vegeta](https://github.com/tsenart/vegeta):HTTP load testing tool and library. <https://godoc.org/github.com/tsenart/vegeta/lib>
* [k6](https://github.com/loadimpact/k6)A modern load testing tool, using Go and JavaScript -<https://k6.io/>
* [autocannon](https://github.com/mcollina/autocannon):fast HTTP/1.1 benchmarking tool written in Node.js
