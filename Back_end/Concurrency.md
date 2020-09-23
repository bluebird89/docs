# 并发

* [C10K 瓶颈(同时连接到服务器的客户达到了一万个)](http://www.kegel.com/c10k.html):很多代码跑崩了，进程上下文切换占用了大量的资源，线程也顶不住如此巨大的压力. NGINX 带着事件循环出来拯救世界了
* 一台服务器在单位时间里能处理的请求越多，服务器的能力越高，也就是服务器并发处理能力越强
* 基于机械磁盘或SSD的数据库系统，读写的速度远慢于内存，因此单纯磁盘介质的数据库无法支撑C50K
* 当今无数的 Web 服务和互联网服务，本质上大部分都是 IO 密集型服务:任务大多是和网络连接或读写相关的高耗时(相对 CPU)任务,瓶颈在于尽可能快速的完成高并发、多连接下的数据读写
  - 多线程，高并发场景的大量 IO 等待会导致多线程被频繁挂起和切换，非常消耗系统资源，同时多线程访问共享资源存在竞争问题。
  - 多进程，不仅存在频繁调度切换问题，同时还会存在每个进程资源不共享的问题，需要额外引入进程间通信机制来解决。
* 思想
  - 关注平衡：达到平衡的架构，才可能是高性能、高并发架构。任何性能问题都会由某个点引起。甚至泛指业务需求与复杂度也要平衡。
  - 拆分之道：合适的事情，让合适的技术、合适的中间件解决。具体：如何横向、纵向拆分还需分析场景。
  - 了解业务场景、问题本质&&了解常用场景下解决方案： 按照发现问题、分析问题、解决问题思路来看，我们把弹药库备齐，解决问题的过程，就是个匹配的过程
* C10M问题
  - 不要让OS内核执行所有繁重的任务：将数据包处理、内存管理、处理器调度等任务从内核转移到应用程序高效地完成，让诸如Linux这样的OS只处理控制层，数据层完全交给应用程序来处理。
  - 现在流行的协处理器+CPU的架构

## 高并发

* 高并发（High Concurrency）是互联网分布式系统架构设计中必须考虑的因素之一，通过设计保证系统能够单位时间内系统能够同时处理的请求数
* 指标
  - 响应时间（Response Time）：系统对请求做出响应的时间。例如系统处理一个HTTP请求需要200ms，这个200ms就是系统的响应时间
  - 吞吐量（Throughput）：单位时间里服务器处理的最大请求数，单位req/s.从服务器角度，实际并发用户数的可以理解为服务器当前维护的代表不同用户的文件描述符总数，也就是并发连接数
  - 每秒查询率QPS（Query Per Second）：每秒响应请求数。在互联网领域，这个指标和吞吐量区分的没有这么明显
  - 并发用户数：同时承载正常使用系统功能的用户数量。例如一个即时通讯系统，同时在线量一定程度上代表了系统的并发用户数
  - * QPS: Queries per second 每秒的请求数目
    - PPS：Packets per second 每秒数据包数目
* 瓶颈：CPU不是也不应该是系统的瓶颈，系统的大部分时间的状况都是CPU在等I/O (硬盘/内存/网络) 的读/写操作完成
* 类型
  - 计算密集:进行大量的计算，消耗 CPU 资源
    + 逻辑
    + 数值比较和计算
    + 比如计算圆周率、视频编解码这些靠的是 CPU 的运算能力
    + 虽然也可以用多任务完成，但是任务越多，任务之间切换的时间就越多，CPU 执行效率反而更低，所以要最高效地利用 CPU，任务并行数应当等于 CPU 的核心数，避免任务在 CPU 核之间频繁切换
  - IO密集:及到大量网络、磁盘等比较耗时的输入输出任务
    + 任务的大部分时间都在等待 IO 操作完成（因为 IO 的速度远远低于 CPU 和内存的速度，不是一个数量级的）
    + 任务越多 CPU 效率越高，但也不是无限的开启多任务，如果任务过多频繁切换的开销也不可忽视
    + MySQL：吞吐
    + Web 服务
* 需要链路层的高可用、高性能的支撑
* 服务模型选择要结合自身服务处理的任务类型
* 理论最大并发数 = 服务端唯一五元组数{source_ip:source_port.destination_ip,destination_port, protocol no}
  - 可用端口：2^16
  - 理论上服务端可以接受的客户端IP是2^32(按照IPv4计算）,端口数是2^16，目前端口号仍然是16bit的，所有这个理论最大值是2^48
* 客户端的理论最大连接数是2^16，含系统占用端口
  - 一个公网出口NAT服务设备最多可同时支持多少内网IP并发访问外网服务

## 并发与并行

* 并发(Concurrent):逻辑上具有处理多个同时性任务的能力
  - 系统只有一个CPU,则根本不可能真正同时进行一个以上的线程，只能把CPU运行时间划分成若干个时间段,再将时间段分配给各个线程执行，在一个时间段的线程代码运行时，其它线程处于挂起状
  - 往往在场景中有公用的资源，那么针对这个公用的资源往往产生瓶颈，会用TPS或者QPS来反应这个系统的处理能力
  - 某个作业在时间片结束之前,整个任务还没有完成，那么该作业就被暂停下来，放弃CPU，等待下一轮循环再继续做。此时CPU又分配给另一个作业去使用
* 并行(Parallel):物理上同一时刻执行多个并发任务
  - 当系统有一个以上CPU时,当一个CPU执行一个线程时，另一个CPU可以执行另一个线程，两个线程互不抢占CPU资源，可以同时进行
* 区别
  - 并行是指两个或者多个事件在同一时刻发生；而并发是指两个或多个事件在同一时间间隔内发生。
  * 并发性是指在一段时间内宏观上有多个程序在同时运行
  * 在单处理机系统中，每一时刻却仅能有一道程序执行，故微观上这些程序只能是分时地交替执行
  * 有多个处理机，则这些可以并发执行的程序便可被分配到多个处理机上，实现并行执行，即利用每个处理机来处理一个可并发执行的程序

## 死锁

* 两个或两个以上的进程在执行过程中，因争夺资源而造成的一种互相等待的现象，若无外力作用，它们都将无法推进下去
* 原因
  - 因为系统资源不足
  - 进程运行推进的顺序不合适
  - 资源分配不当
  - 因为多线程访问共享资源，由于访问的顺序不当所造成的。两个线程都想得到对方的资源，而不愿释放自己的资源，造成两个线程都在等待，而无法执行的情况。
* 条件：
  - 互斥条件：所谓互斥就是进程在某一时间内独占资源。
  - 请求与保持条件：一个进程因请求资源而阻塞时，对已获得的资源保持不放。
  - 不剥夺条件:进程已获得资源，在末使用完之前，不能强行剥夺。
  - 循环等待条件:若干进程之间形成一种头尾相接的循环等待资源关系。

## 异步IO

* 每次异步传输的信息都以一个起始位开头，它通知接收方数据已经到达了，这就给了接收方响应、接收和缓存数据比特的时间；
* 在传输结束时，一个停止位表示该次传输信息的终止。按照惯例，空闲（没有传送数据）的线路实际携带着一个代表二进制1的信号，异步传输的开始位使信号变成0，其他的比特位使信号随传输的数据信息而变化。
* 最后，停止位使信号重新变回1，该信号一直保持到下一个开始位到达。

## 并发控制

* 保证一个用户的工作不会对另一个用户的工作产生不合理的影响。通过一定的手段来保证在并发情况下数据的准确性，保证当用户和其他用户一起操作时得到的结果和他单独操作时的结果一样
* 悲观并发控制（Pessimistic Concurrency Control）：先取锁再访问
  - 方法
    + 在对记录进行修改前，先尝试为该记录加上排他锁（exclusive locking）。
    + 如果加锁失败，说明该记录正在被修改，那么当前查询可能要等待或者抛出异常。
    + 具体响应方式由开发者根据实际需要决定。如果成功加锁，那么就可以对记录做修改，事务完成后就会解锁了。其间如果有其他对该记录做修改或加排他锁的操作，都会等待我们解锁或直接抛出异常。
  - 常用的MySql Innodb引擎举例
    + 关闭mysql数据库的自动提交属性，因为MySQL默认使用autocommit模式，set autocommit=0;
  - 处理加锁的机制会让数据库产生额外的开销，还有增加产生死锁的机会；
  - 还会降低并行性，一个事务如果锁定了某行数据，其他事务就必须等待该事务处理完才可以处理那行数据。
  - 悲观锁依赖数据库锁，效率低。更新失败的概率比较低。
  - 随着互联网三高架构（高并发、高性能、高可用）的提出，悲观锁已经越来越少的被使用到生产环境中了，尤其是并发量比较大的业务场景。
* 乐观锁（ Optimistic Locking）：数据进行提交更新的时候，才会正式对数据的冲突与否进行检测，如果发现冲突了，则让返回用户错误的信息，让用户决定如何去做。
  - 在对数据库进行处理的时候，乐观锁并不会使用数据库提供的锁机制。一般的实现乐观锁的方式就是记录数据版本。
  - 乐观锁并未真正加锁，效率高。一旦锁的粒度掌握不好，更新失败的概率就会比较高，容易发生业务失败。
* ABA问题：另一个进程处理后结果与当前进程值一致
  - 乐观锁每次在执行数据的修改操作时，都会带上一个版本号，一旦版本号和数据的版本号一致就可以执行修改操作并对版本号执行+1操作，否则就执行失败。因为每次操作的版本号都会随之增加，所以不会出现ABA问题，因为版本号只会增加不会减少。
  - 使用时间戳
* 锁竞争:当一个任务占用资源时，锁住资源，其它任务都在等待锁的释放
  - 尽量减少并发请求对于共享资源的竞争
  - 一旦发上高并发的时候，就只有一个线程可以修改成功，那么就会存在大量的失败
    + 减小乐观锁力度，最大程度的提升吞吐率，提高并发能力
    + 锁粒度把控是一门重要的学问，选择一个好的锁，在保证数据安全的情况下，可以大大提升吞吐率，进而提升性能
* 无锁编程：由内核完成这个锁机制，主要是使用原子操作替代锁来实现对共享资源的访问保护.子操作速度比锁快，一般要快一倍以上
* 架构演进
  - 电商的促销：警惕流量
  - 最初单体数据库-》用户超过 100 万，日访问量超过 20 万，峰值并发 2 万，而数据库的表会趋近于亿级的量。撑不住的
  - 一个大库拆成若干小库，保持数据库对象都一致，这样每个小库分摊掉一部分流量，-》一系列的事情来满足和留住用户。比如促销、打折、团购等等。会大量查询他们的数据，带来的是读请求远远大于写入请求
    + 通过中间件
    + 现在的硬件服务 4000 个并发，对于不复杂的商用没有问题。具体能负责多少看系统上线后的 baseline （基线）监测，这里我们假定 4000 并发。所以分成 5 个相同的库，来做分库。这样同时写入 4000 并发够用。
    + 分库路由：依据地理位置分成 5 个库，根据用户身份证哈希成 5 个散列值，分别对应了这 5 台数据库，用户就被分流了。
    + 读请求耗尽服务器的 CPU\IO\Network 资源
  - 读写分离

```sql
# 0.开始事务
begin;
# 1.查询出商品库存信息， for update的方式进行加锁
select quantity from items where id=1 for update;
# 2.修改商品库存为2
update items set quantity=2 where id = 1;
# 3.提交事务
commit;

# 乐观锁
# 查询出商品库存信息，quantity = 3
select quantity from items where id=1
# 修改商品库存为2，
update items set quantity=2 where id=1 and quantity = 3;

# 处理ABA
# 查询出商品信息，version = 1
select version from items where id=1
# 修改商品库存为2
update items set quantity=2,version = 3 where id=1 and version = 2;

# 修改商品库存
update item  set quantity=quantity - 1  where id = 1 and quantity - 1 > 0
```

## 压力测试

* 考虑条件
  - 并发用户数: 指在某一时刻同时向服务器发送请求的用户总数(HttpWatch)
  - 总请求数
  - 请求资源描述
  - 请求等待时间(用户等待时间)
  - 用户平均请求等待时间（这里暂不把数据在网络的传输时间，还有用户PC本地的计算时间计算入内）：用于衡量服务器在一定并发用户数下，单个用户的服务质量,用户平均请求等待时间 = 服务器平均请求处理时间 * 并发用户数
  - 服务器平均请求处理的时间:吞吐率的倒数
  - 硬件环境
* 工具
  - [wrk](https://github.com/wg/wrk): Modern HTTP benchmarking tool
  - [gatling](https://github.com/gatling/gatling) Async Scala-Akka-Netty based Load Test Tool http://gatling.io
  - [sniper](https://github.com/btfak/sniper): A powerful & high-performance http load tester
  - [hey](https://github.com/rakyll/hey): HTTP load generator, ApacheBench (ab) replacement, formerly known as rakyll/boom
  - [Siege](https://github.com/JoeDog/siege): Siege is an http load tester and benchmarking utility
  - [http_load](http://www.acme.com/software/http_load/): http_load runs multiple http fetches in parallel, to test the throughput of a web server.
  - [vegeta](https://github.com/tsenart/vegeta/): HTTP load testing tool and library. It’s over 9000!
  - [t50](https://github.com/fredericopissarra/t50): mixed packet injector tool
  - [GoReplay](https://github.com/buger/goreplay): GoReplay is an open-source tool for capturing and replaying live HTTP traffic into a test environment in order to continuously test your system with real data. It can be used to increase confidence in code deployments, configuration changes and infrastructure changes. https://goreplay.org
  - [tcpcopy](https://github.com/session-replay-tools/tcpcopy): An online request replication tool, also a tcp stream replay tool, fit for real testing, performance testing, stability testing, stress testing, load testing, smoke testing, etc
  - [gryphon](https://github.com/wslfa/gryphon): Gryphon是由网易自主研发的能够模拟千万级别并发用户的一个软件，目的是能够用较少的资源来模拟出大量并发用户，并且能够更加真实地进行压力测试， 以解决网络消息推送服务方面的压力测试的问题和传统压力测试的问题。Gryphon分为两个程序，一个运行gryphon，用来模拟用户，一个是 intercept，用来截获响应包信息给gryphon。Gryphon模拟用户的本质是用一个连接来模拟一个用户，所以有多少个连接，就有多少个用户，而用户的素材则取自于pcap抓包文件。值得注意的是，Gryphon架构类似于tcpcopy，也可以采用传统使用方式和高级使用方式。
  - [locust.io](http://locust.io/): An open source load testing tool. Define user behaviour with Python code, and swarm your system with millions of simultaneous users.

## [Apache Benchmarking tool](https://httpd.apache.org/docs/2.4/programs/ab.html)

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
* -i     Do HEAD requests instead of GET.
* -k     Enable the HTTP KeepAlive feature, i.e., perform multiple requests within one HTTP session. Default is no KeepAlive.
* -l     Do not report errors if the length of the responses is not constant. This can be useful for dynamic pages. Available in 2.4.7 and later.
* -m HTTP-method Custom HTTP method for the requests. Available in 2.4.10 and later.
* -n requests Number of requests to perform for the benchmarking session. The default is to just  perform  a  single  request  which  usually leads to non-representative benchmarking results.
* -p POST-file File containing data to POST. Remember to also set -T.
* -P proxy-auth-username:password Supply BASIC Authentication credentials to a proxy en-route. The username and password are separated by a single : and sent on the wire base64 encoded. The string is sent regardless of whether the proxy needs it (i.e.,  has  sent  an 407 proxy authentication needed).
* -q     When processing more than 150 requests, ab outputs a progress count on stderr every 10% or 100 requests or so. The -q flag will suppress these messages.
* -r     Don't exit on socket receive errors.
* -s timeout
* -S Do  not  display  the  median  and standard deviation values, nor display the warning/error messages when the average and median are more than one  or  two times  the  standard  deviation apart. And default to the min/avg/max values. (legacy support).
* -t timelimit Maximum number of seconds to spend for benchmarking. This implies a -n  50000 internally.  Use  this to benchmark the server within a fixed total amount of time. Per default there is no timelimit.
* -T content-type Content-type header to use for POST/PUT data, eg.  application/x-www-form-ur‐ lencoded. Default is text/plain.
* -u PUT-file File containing data to PUT. Remember to also set -T.
* -v verbosity Set  verbosity level - 4 and above prints information on headers, 3 and above prints response codes (404, 200, etc.), 2 and above prints warnings and info.
* -V     Display version number and exit.
* -w     Print out results in HTML tables. Default table is two columns wide,  with  a white background.
* -x <table>-attributes String  to use as attributes for <table>. Attributes are inserted <table here >.
* -X proxy[:port] Use a proxy server for the requests.
* -y <tr>-attributes String to use as attributes for <tr>.
* -z <td>-attributes String to use as attributes for <td>.
* -Z ciphersuite Specify SSL/TLS cipher suite (See openssl ciphers)

```
ab -n 5000 -c 50 https://www.baodu.com
```

## 思路

* 实现高并发:操作系统通过多执行流体系设计使得多个任务可以轮流使用系统资源,资源包括CPU，内存以及I/O. 这里的I/O主要指磁盘I/O, 和网络I/O
  - 服务化：扩展单机限制
    + 服务拆分：将整个项目拆分成多个子项目或者模块，分而治之，将项目进行水平扩展
    + 解决服务调用复杂之后服务的注册发现问题
    + 使用集群
  - 消息队列：解耦，非核心流程异步化
  - 缓存：各种缓存带来的并发
    + 使用进程绑定CPU技术，增加CPU缓存的命中率。若进程不断在各CPU上切换，这样旧的CPU缓存就会失效
  - 数据库
    + 业务和应用或者功能模块将数据库进行分离，不同的模块对应不同的数据库或者表，再按照一定的策略对某个页面或者功能进行更小的数据库散列
    + 分库分表
    + 读写分离
    + 优化数据库（范式、SQL语句、索引、配置、读写分离）
  - 高性能的Web容器
  - 客户端
    + HTML静态化
    + 资源服务器分离:降低提供页面访问请求的服务器系统压力，并且可以保证系统不会因为图片问题而崩溃，动态内容静态化+CDN
    + 减少http请求（比如使用雪碧图）
    + 禁止外部盗链（refer、图片添加水印）
    + 控制大文　件下载
  - 镜像：大型网站常采用的提高性能和数据安全性方式，解决不同网络接入商和地域带来的用户访问速度差异
  - 负载均衡
    + 软件四层交换可以使用Linux上常用的LVS(Linux Virtual Server)，提供了基于心跳线heartbeat的实时灾难应对解决方案，提高系统的鲁棒性，同时可供了灵活的虚拟VIP配置和管理功能，可以同时满足多种应用需求，这对于分布式的系统来说必不可少。一个典型的使用负载均衡的策略就是，在软件或者硬件四层交换的基础上搭建squid集群，这种思路在很多大型网站包括搜索引擎上被采用，这样的架构低成本、高性能还有很强的扩张性，随时往架构里面增减节点都非常容易。
    + 硬件四层交换：第四层交换使用第三层和第四层信息包的报头信息，根据应用区间识别业务流，将整个区间段的业务流分配到合适的应用服务器进行处理。　第四层交换功能就象是虚IP，指向物理服务器。它传输的业务服从的协议多种多样，有HTTP、FTP、NFS、Telnet或其他协议。这些业务在物理服务器基础上，需要复杂的载量平衡算法。在IP世界，业务类型由终端TCP或UDP端口地址来决定，在第四层交换中的应用区间则由源端和终端IP地址、TCP和UDP端口共同决定。在硬件四层交换产品领域，有一些知名的产品可以选择，比如Alteon、F5等
  - ElasticSearch:分布式的，可以随便扩容，分布式天然就可以支撑高并发
* 实现高可用
  - 缓存
    + 不单单能够提升系统访问速度、提高并发访问量，也是保护数据库、保护系统的有效方式。大型网站一般主要是“读”
    + “写”系统:累积一些数据批量写入，内存里面的缓存队列（生产消费），以及HBase写数据的机制等等也都是通过缓存提升系统的吞吐量或者实现系统的保护措施
  - 集群
  - 限流：通过对并发访问/请求进行限速或者一个时间窗口内的请求进行限速来保护系统的可用性，一旦达到限制速率就可以拒绝服务
    + 限制瞬时并发数：比如在入口层（nginx添加nginx_｀http_limit_conn_module｀）来限制同一个ip来源的连接数，防止恶意攻击访问的情况
    + 限制总并发数：通过配置数据库连接池、线程池大小来约束总并发数
    + 限制时间窗口内的平均速率：在接口层面，通过限制访问速率来控制接口的并发请求
    + 其他方式：限制远程接口的调用速率、限制MQ的消费速率
    + 算法
      * 滑动窗口协议：一种常见的流量控制技术，用来改善吞吐量的技术。滑动窗口协议的由来：
        - 滑动窗口（sliding window）是一种流量控制技术。早期的网络通讯中，通信双方不会考虑网络的拥挤情况直接发送数据。由于大家不知道网络拥塞状况，同时发送数据，导致中间节点阻塞掉包，谁也发送不了数据，所以就有了滑动窗口机制来解决此问题。发送和接收方都会维护一个数据帧的序列，这个序列被称为窗口。
        - 定义：滑动窗口协议（Sliding Window Protocol），属于TCP协议的一种应用，用于网络数据传输时的流量控制，以避免拥塞的发生。该协议允许发送方在停止并等待确认前发送多个数据分组。由于发送方不必每发一个分组就停下来等待确认，因此该协议可以加速数据的传输，提高网络吞吐量。
        - 发送窗口：发送端允许连续发送的帧的序号表。发送端可以不等待应答而连续发送数据（可以通过设置窗口的尺寸来控制）
        - 接收窗口：接收方允许接收的帧的序列表，凡是落在接收窗口内的帧，接收方都必须处理，落在接收窗口外的帧将被丢弃。接收方每次允许接收的帧数称为接收窗口的尺寸
      * 漏桶（leaky bucket）：能强行限制数据的传输速率 实现流量整形（Traffic Shaping）和流量控制（Traffic Policing）
        - 思路：请求先进入到漏桶里，漏桶以一定的速度出水。当水请求过大会直接溢出，可以看出能强行限制数据的传输速率。进入端无需考虑出水端的速率，就像mq消息队列一样，provider只需要将消息传入队列中，而不需要关心Consumer是否接收到了消息。
          + 一个固定容量的漏桶，按照常量固定速率流出水滴；
          + 如果桶是空的，则不需流出水滴；
          + 可以以任意速率流入水滴到漏桶；
          + 如果流入水滴超出了桶的容量，则流入的水滴溢出了（被丢弃），而漏桶容量是不变的。
        - 对于溢出的水，就是被过滤的数据，可以直接被丢弃，也可以通过某种方式暂时保存，如加入队列之中，像线程池里对溢出数据的4种处理机制一样
        - 单机系统中可以使用队列来实现，在分布式环境中消息中间件或者Redis都是可选的方案
      * 令牌桶：一个存放固定容量令牌（token）的桶，按照固定速率往桶里添加令牌
        - 原理：系统会以一个恒定的速度往桶里放入令牌，而如果请求需要被处理，则需要先从桶里获取一个令牌，当桶里没有令牌可取时，则拒绝服务。
        - 令牌将按照固定的速率被放入令牌桶中。比如每秒放10个。
        - 桶中最多存放b个令牌，当桶满时，新添加的令牌被丢弃或拒绝。
        - 当一个n个字节大小的数据包到达，将从桶中删除n个令牌，接着数据包被发送到网络上。
        - 如果桶中的令牌不足n个，则不会删除令牌，且该数据包将被限流（要么丢弃，要么缓冲区等待）。
      * 固定的缓存容量：令牌痛 平滑服务端，漏桶：平滑消费端
        - 处理某时的突发流量：放令牌的频率改变可以改变整体数据处理的速度，漏桶算法可能就不合适
      * 计数器：通过控制时间段内的请求次数.可以设置一个1秒钟的滑动窗口，窗口中有10个格子，每个格子100毫秒，每100毫秒移动一次，每次移动都需要记录当前服务请求的次数。 内存中需要保存10次的次数。可以用数据结构LinkedList来实现。格子每次移动的时候判断一次，当前访问次数和LinkedList中最后一个相差是否超过100，如果超过就需要限流了
        - 指定时间段内（10个）定时检测，没100ms检测一次
        - 请求去实时更新请求次数
    + 工具
      * Guava是一个Google开源项目，包含了若干被Google的Java项目广泛依赖的核心库，其中的RateLimiter提供了令牌桶算法实现：平滑突发限流(SmoothBursty)和平滑预热限流(SmoothWarmingUp)实现。
        - 常规速率、突发流量 使用的RateLimiter的子类SmoothBursty
        - 有一定缓冲的流量输出方案：SmoothWarmingUp 设置了缓冲时间 形成一个平滑线性下降的坡度，频率越来越高，在缓冲时间之内达到原本设置的频率，以后就以固定的频率输出
    + 降级:当服务器压力剧增的情况下，根据当前业务情况及流量对一些服务和页面有策略的降级，以此释放服务器资源以保证核心任务的正常运行，需要根据不同的业务需求采用不同的降级策略。主要的目的就是服务虽然有损但是总比没有好
      * 指定级别：面临不同的异常等级执行不同的服务方式：拒接服务、延迟服务、随机服务
      * 根据服务范围砍掉某个功能或模块
* 业务设计
  - 幂等：就是用户对于同一操作发起的一次请求或者多次请求的结果是一致的，不会因为多次点击而产生了副作用，就像数学里的数字1，多少次幂的结果都是1。举个最简单的例子，那就是支付，用户购买商品后支付，支付扣款成功，但是返回结果的时候网络异常，此时钱已经扣了，用户再次点击按钮，此时会进行第二次扣款，返回结果成功，用户查询余额发现多扣钱了，流水记录也变成了两条。
  - 防重：防止同样的数据同时提交
  - 除了在业务方向判断和按钮点击之后不能继续点击的限制以外，在服务器端也可以做到防重：
  - 在服务器端生成一个唯一的随机标识号(Token<令牌>)同事在当前用户的Session域中保存这个令牌，然后将令牌发送到客户端的form表单中，在form表单中使用隐藏域来存储这个Token，表单提交的时候联通这个Token一起提交到服务器，然后在服务器端判断客户提交上来的Token与服务器端生成的Token是否一致，如果不一致，那就重复提交了，此时服务器端就可以不处理重复提交的表单，如果相同则处理表单，处理完后清楚当前用户的Session域中存储的标识号。高可用高并发架构参考：高可用高并发的 9 种技术架构。
  - 在下列情况中，服务器程序将拒绝处理用户提交的表单请求：
    + 存储Session域中的Token与表单提交的Token不一致
    + 当前用户的Session中不存在Token
    + 用户提交的表单数据中没有Token
* 状态机：软件设计中的状态机概念，一般是指有限状态机（英语：finite-state machine，缩写：FSM）又称有限状态自动机，简称状态机，是表示有限个状态以及在这些状态之间的转移和动作等行为的数学模型。

```
// 令牌桶
public class TokenDemo {

  //qps:每秒钟处理完请求的次数；tps:每秒钟处理完的事务次数
  //代表qps是10；
  RateLimiter rateLimiter = RateLimiter.create(10);

  public void doSomething(){
      if (rateLimiter.tryAcquire()){
          //尝试获得令牌.为true则获取令牌成功
          System.out.println("正常处理");
      }else{
          System.out.println("处理失败");
      }

  }

  public static void main(String args[]) throws IOException{
      /*
      * CountDownLatch是通过一个计数器来实现的，计数器的初始值为线程的数量，此值是线程将要等待的操作数（线程的数量）。
      * 当某个线程为了想要执行这些操作而等待时， 它要使用 await()方法。
      * 此方法让线程进入休眠直到操作完成。
      * 当某个操作结束，它使用countDown() 方法来减少CountDownLatch类的内部计数器，计数器的值就会减1。
      * 当计数器到达0时，它表示所有的线程已经完成了任务，这个类会唤醒全部使用await() 方法休眠的线程们恢复执行任务。
      *
      * */
      CountDownLatch latch = new CountDownLatch(1);
      Random random = new Random(10);
      TokenDemo tokenDemo = new TokenDemo();
      for (int i=0;i<20;i++){
          new Thread(()->{
              try {
                  latch.await();
                  Thread.sleep(random.nextInt(1000));
                  tokenDemo.doSomething();
              }catch (InterruptedException e){
                  e.printStackTrace();
              }
          }).start();
      }
      latch.countDown();
      System.in.read();
  }

// 计数器
//服务访问次数，可以放在Redis中，实现分布式系统的访问计数
Long counter = 0L;
//使用LinkedList来记录滑动窗口的10个格子。
LinkedList<Long> ll = new LinkedList<Long>();

public static void main(String[] args)
{
    Counter counter = new Counter();
    counter.doCheck();
}

private void doCheck()
{
    while (true)
    {
        ll.addLast(counter);

        if (ll.size() > 10)
        {
            ll.removeFirst();
        }

        //比较最后一个和第一个，两者相差一秒
        if ((ll.peekLast() - ll.peekFirst()) > 100)
        {
            //To limit rate
        }

        Thread.sleep(100);
    }
}
```

## 提高服务器并发处理能力

* 提高CPU并发计算能力
  - 减少进程切换: 当硬件上下文频繁装入和移出时，所消耗的时间是非常可观的。可用Nmon工具监视服务器每秒的上下文切换次数.为了尽量减少上下文切换次数，最简单的做法就是减少进程数，尽量使用线程并配合其它I/O模型来设计并发策略
  - 减少使用不必要的锁:服务器处理大量并发请求时，多个请求处理任务时存在一些资源抢占竞争，这时一般采用“锁”机制来控制资源的占用
  - 考虑进程优先级 进程调度器会动态调整运行队列中进程的优先级，通过top观察进程的PR值
  - 考虑系统负载: 可在任何时刻查看/proc/loadavg, top中的load average也可看出
  - 考虑CPU使用率: 除了用户空间和内核空间的CPU使用率以外，还要关注I/O wait,它是指CPU空闲并且等待I/O操作完成的时间比例（top中查看wa的值）
* 考虑减少内存分配和释放
  - 通过改善数据结构和算法复制度来适当减少中间临时变量的内存分配及数据复制时间，而服务器本身也使用了各自的策略来提高效率
    + Apache,在运行开始时一次申请大片的内存作为内存池，若随后需要时就在内存池中直接获取，不需要再次分配，避免了频繁的内存分配和释放引起的内存整理时间
    + Nginx使用多线程来处理请求，使得多个线程之间可以共享内存资源，从而令它的内存总体使用量大大减少
    + Nginx分阶段的内存分配策略，按需分配，及时释放，使得内存使用量保持在很小的数量范围
  - 共享内存:在多处理器的计算机系统中，可以被不同中央处理器（CPU）访问的大容量内存，也可以由不同进程共享，是非常快的进程通信方式
    + shell命令ipcs可用来显示系统下共享内存的状态
    + 函数shmget可以创建或打开一块共享内存区
    + 函数shmat将一个存在的共享内存段连接到本进程空间
    + 函数shmctl可以对共享内存段进行多种操作，函数shmdt函数分离该共享内存
* 考虑使用持久连接(长连接):在一次TCP连接中持续发送多分数据而不断开连接,短连接是建立连接后发送一份数据就断开，然后再次建立连接发送下一份数据.是否采用持久连接，完全取决于应用特点。
  - 从性能角度看，建立TCP连接的操作本身是一项不小的开销，在允许的情况下，连接次数越少，越有利于性能的提升;尤其对于密集型的图片或网页等小数据请求处理有明显的加速所用
  - 长连接的有效使用，还有关键一点在于长连接超时时间的设置，即长连接在什么时候关闭吗？ Apache的默认设置为5s, 若这个时间设置过长，则可能导致资源无效占有，维持大量空闲进程，影响服务器性能
* 改进I/O 模型:
  - 网络I/O和磁盘I/O:速度要慢很多，尽管使用RAID磁盘阵列可通过并行磁盘磁盘来加快磁盘I/O速度，购买大连独享网络带宽以及使用高带宽网络适配器可以提高网络I/O的速度. 但这些I/O操作需要内核系统调用来完成，这些需要CPU来调度，这使得CPU不得不浪费宝贵的时间来等待慢速I/O操作
  - 希望让CPU足够少的时间在i/O操作的调度上，如何让高速的CPU和慢速的I/O设备更好地协调工作，是现代计算机一直探讨的话题。各种I/O模型的本质区别在于CPU的参与方式
  - DMA技术: I/O设备和内存之间的数据传输方式由DMA控制器完成。在DMA模式下，CPU只需向DMA下达命令，让DMA控制器来处理数据的传送，这样可以大大节省系统资源。
  - 异步I/O指主动请求数据后便可以继续处理其它任务，随后等待I/O操作的通知，这样进程在数据读写时不发生阻塞.是非阻塞的，当函数返回时，真正的I/O传输已经完成，这让CPU处理和I/O操作达到很好的重叠。
  - I/O多路复用
    + epoll服务器同时处理大量的文件描述符是必不可少的，若采用同步非阻塞I/O模型，若同时接收TCP连接的数据，就必须轮流对每个socket调用接收数据的方法，不管这些socket有没有可接收的数据，都要询问一次。假如大部分socket并没有数据可以接收，那么进程便会浪费很多CPU时间用于检查这些socket有没有可以接收的数据。
    + 多路I/O就绪通知的出现，提供了对大量文件描述符就绪检查的高性能方案，它允许进程通过一种方法同时监视所有文件描述符，并可以快速获得所有就绪的文件描述符，然后只针对这些文件描述符进行数据访问
    + epoll可以同时支持水平触发和边缘触发，理论上边缘触发性能更高，但是代码实现复杂，因为任何意外的丢失事件都会造成请求处理错误。
    + epoll主要有2大改进：
      * epoll只告知就绪的文件描述符，而且当调用epoll_wait()获得文件描述符时，返回并不是实际的描述符，而是一个代表就绪描述符数量的值，然后只需去epoll指定的一个数组中依次取得相应数量的文件描述符即可。 这里使用了内存映射(mmap)技术，这样彻底省掉了这些文件描述符在系统调用时复制的开销。
      * epoll采用基于事件的就绪通知方式。其事先通过epoll_ctrl()注册每一个文件描述符，一旦某个文件描述符就绪时，内核会采用类似callback的回调机制，当进程调用epoll_wait()时得到通知
  - Sendfile
    + 处理这些请求时，磁盘文件的数据先经过内核缓冲区，然后到用户内存空间，不需经过任何处理，其又被送到网卡对应的内核缓冲区，接着再被送入网卡进行发送.Linux提供sendfile()系统调用，可以讲磁盘文件的特定部分直接传送到代表客户端的socket描述符，加快了静态文件的请求速度，同时减少CPU和内存的开销
    + 适用场景：对于请求较小的静态文件，sendfile发挥的作用不那么明显，因发送数据的环节在整个过程中所占时间的比例相比于大文件请求时小很多
  - 内存映射
    + Linux内核提供一种访问磁盘文件的特殊方式，它可以将内存中某块地址空间和我们指定的磁盘文件相关联，从而对这块内存的访问转换为对磁盘文件的访问。这种技术称为内存映射。
    + 多数情况下，内存映射可以提高磁盘I/O的性能，无须使用read()或write()等系统调用来访问文件，而是通过mmap()系统调用来建立内存和磁盘文件的关联，然后像访问内存一样自由访问文件。
    + 缺点：在处理较大文件时，内存映射会导致较大的内存开销，得不偿失。
  - 直接I/O
    + 在linux 2.6中，内存映射和直接访问文件没有本质差异，因为数据需要经过2次复制，即在磁盘与内核缓冲区之间以及在内核缓冲区与用户态内存空间。
    + 引入内核缓冲区的目的在于提高磁盘文件的访问性能，然而对于一些复杂的应用，比如数据库服务器，它们为了进一步提高性能，希望绕过内核缓冲区，由自己在用户态空间实现并管理I/O缓冲区，比如数据库可根据更加合理的策略来提高查询缓存命中率。
    + 另一方面，绕过内核缓冲区也可以减少系统内存的开销，因内核缓冲区本身就在使用系统内存。
    + Linux在open()系统调用中增加参数选项O_DIRECT,即可绕过内核缓冲区直接访问文件,实现直接I/O。
    + 在Mysql中，对于Innodb存储引擎，自身进行数据和索引的缓存管理，可在my.cnf配置中分配raw分区跳过内核缓冲区，实现直接I/O
* 改进服务器并发策略:并发策略的目的，是让I/O操作和CPU计算尽量重叠进行，一方面让CPU在I/O等待时不要空闲，另一方面让CPU在I/O调度上尽量花最少的时间
  - 一个进程处理一个连接，非阻塞I/O:这样会存在多个并发请求同时到达时，服务器必然要准备多个进程来处理请求。其进程的开销限制了它的并发连接数。 但从稳定性和兼容性的角度，则其相对安全，任何一个子进程的崩溃不会影响服务器本身，父进程可以创建新的子进程；这种策略典型的例子就是Apache的fork和prefork模式。 对于并发数不高（如150以内）的站点同时依赖Apache其它功能时的应用选择Apache还是可以的。
  - 一个线程处理一个连接，非阻塞IO 这种方式允许在一个进程中通过多个线程来处理多个连接，一个线程处理一个连接。Apache的worker模式就是这种典型例子，使其可支持更多的并发连接。不过这种模式的总体性能还不如prefork，所以一般不选用worker模式。推荐阅读：14个Java并发容器。
  - 一个进程处理多个连接，异步I/O 一个线程同时处理多个连接，潜在的前提条件就是使用IO多路复用就绪通知。这种情况下，将处理多个连接的进程叫做worker进程或服务进程。worker的数量可以配置，如Nginx中的worker_processes 4。
  - 一个线程处理多个连接，异步IO 即使有高性能的IO多路复用就绪通知，但磁盘IO的等待还是无法避免的。更加高效的方法是对磁盘文件使用异步IO，目前很少有Web服务器真正意义上支持这种异步IO

## 方法

IO多路复用：管理更多的连接

* 线程池技术：挖掘多核cpu的潜力
* zero-copy：减少用户态和内核态交互次数。如java中transferTo，linux中sendfile系统接口；
* 磁盘顺序写：降低寻址开销。消息队列或数据库日志，都会采用此技术。
* 压缩更好的协议：网络传输上减少开支，如：自定义或二进制传输协议；
* 分区：在存储系统中，分库分表都算分区；而微服务中，设计服务无状态，本身也可以理解为分区。
* 批量传输：典型数据库 batch技术。很多网络中间件也可以使用，如消息队列中。
* 索引技术：这里不是特指数据库的索引技术。而是我们设计切合业务场景的索引，提供效率。例如：kafka针对文件的存储，采用一些hack的索引技巧。
* 缓存设计：当数据生命修改不频繁、变更规律性很强、生成一次成本太高时，可以考虑缓存
* 空间换时间：其实分区、索引技术、缓存技术都可归为这类。例如：我们使用倒排索引存储数据、使用多份数据多份节点提供服务等。
* 网络连接的选型：长短连接，可靠、非可靠协议等。
* 拆包粘包：batch、协议选型于此有些关系。
* 高性能分布式锁：并发编程中，锁不可避免。尽量使用高性能的分布式锁，能cas乐观锁，尽量避免悲观锁。如果业务允许，尽量异步锁，不要同步阻塞锁，减少锁竞争。
* 柔性事务代替刚性事务：有些异常或者故障，试图通过重试是恢复不了的。
* 最终一致性：如果业务场景允许，尽量保证数据最终一致性。
* 非核心业务异步化：把某些任务转化为另外一个队列（消息队列），消费端可以批量、多消费者处理。
* direct IO：例如数据库等自己构建缓存机制的应用程序，直接使用directIO，放弃操作系统提供的缓存

## 硬件提升性能

* 增加机器核心数:CPU 晶体管密度工作频率很难再提高，转而通过增加 CPU 核心数目的方式提高处理器性能
  - 查看 cpu 核心数:`cat /proc/cpuinfo`
  - CPU 亲和性:绑定某一进程或线程到特定的 CPU 或 CPU 集合，从而使得该进程或线程只能被调度运行在绑定的 CPU或 CPU 集合上
    + 进程上一次运行后的上下文信息会保留在 CPU 的缓存中，如果下一次仍然将该进程调度到同一个 CPU 上，就能避免缓存未命中对 CPU 处理性能的影响，从而使得进程的运行更加高效
  - 绑定进程： `sched_setaffinity`
  - 绑定线程 `pthread_setaffinity_np`

## 数据

* 2019天猫双11交易峰值创下新纪录，达54.4万笔/秒

## 工具

* [Siege](https://www.joedog.org/siege-home/) <https://www.sitepoint.com/web-app-performance-testing-siege-plan-test-learn/>
* [locust](https://locust.io/)
* [mcollina/autocannon](https://github.com/mcollina/autocannon):fast HTTP/1.1 benchmarking tool written in Node.js

```sh
#apache ab
yum install apr-util

#webench
wget http://blog.zyan.cc/soft/linux/webbench/webbench-1.5.tar.gz
tar zxvf webbench-1.5.tar.gz
cd webbench-1.5
make && make install
```

## 参考

* [libevent/libevent](https://github.com/libevent/libevent) :Event notification library https://libevent.org
