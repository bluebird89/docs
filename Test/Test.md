# 测试

自动化包括一切通过工具（程序）的方式来代替或辅助手工测试的行为都可以看做自动化，包括性能测试工具（loadrunner、jmeter）,或自己所写的一段程序，用于生成1到100个测试数据。
分层的自动化测试倡导产品的不同阶段（层次）都需要自动化测试。从单元测试->集成/接口测试->UI测试的金字塔结构。为了表示不同阶段所投入自动化测试的比例。如果一个产品从没有做单元测试与接口测试，只做UI层的自动化测试是不科学的，从而很难从本质上保证产品的质量。如果你妄图实现全面的UI层的自动化测试，那更是一个劳民伤财的举动，投入了大量人力时间，最终获得的收益可能会远远低于所支付的成本。因为越往上层，其维护成本越高。尤其是UI层的元素会时常的发生改变。所以，我们应该把更多的自动化测试放在单元测试与接口测试阶段进行。在《google 测试之道》一书，对于google产品，70%的投入为单元测试，20%为集成、接口测试，10% 为UI层的自动化测试。

- 单元测试关注代码的实现逻辑
- 集成、接口测试关注的一是个函数、类（方法）所提供的接口是否可靠
- UI测试：

## 什么项目适合做自动化测试

- 软件需求变动不频繁
- 项目周期较长
- 自动化测试脚本可重复使用
## 工具选择
- 桌面程序的工具有：QTP、 AutoRunner
- web应用的工具有：QTP、AutoRunner、Robot Framework、watir、selenium

## 压力测试

[来源](http://www.techug.com/post/stress-testing-in-a-programmer-eyes.html)

### 目的

压力测试其实有两个目的，一是测试应用在高并发情况下是否会报错，进程是否会挂掉；二是测试应用的抗压能力，预估应用的承载能力，为运维同学提供扩容的依据。所以通常是在满足第一点的前提下，再根据可能到来的高并发压力来计算需要多少实例来承载，而这就需要我们压出极限。

### 过程

#### 第一次压力测试

接口开发完成之后就可以进行第一次压力测试。这一次压力测试可以简单压一下，在本机进行就可以。压力测试的目的是检查代码在高并发下是否会报错。另外，编译型语言要观察是否存在内存泄漏，比如golang。因为本机性能有限，一般来说按照100、200、300、500进程数进行压力测试，压到500如果没有报错就可以进行疲劳测试，观察内存占用。

#### 第二次压力测试

所以这就对仿真环境提出了更高的要求，有条件的要保证仿真和线上配置一致。次之也要和线上成比例，这样可以方便后续评估计算。

这一次压力测试重点是压极限。需要特别要注意，这里的极限不是数据库极限，不是Redis极限，而是是指应用服务器的极限承受能力。上面已经说了，压极限是为了给运维同学提供扩容的参考，所以我们要做的是压到服务器的承受极限，看下到底能够承受多大的并发。假设现在线上是双实例8C8G，仿真双实例4C4G。

比如说我们我们压出仿真的极限承受能力是1000，那么我们就可以预估线上能够承受2000并发。比如我们预估接下来我们会迎来一次5000并发的冲击，那么运维同学就可以根据这些数据来评估出相应的扩容方案。

### 步骤

比如第一次压500的时候就出现了一些报错，这时候就是遇到了第一个瓶颈。当解决第一个之后再继续压500，确认解决了第一个瓶颈就可以继续往上加，如此循环直到压到服务器极限。在这个过程中我们会遇到很多瓶颈，冲破这一路瓶颈就像过关斩将一样。

### 常见的瓶颈

- php-fpm进程数。一般php-fpm的进程数是dynamic模式，也就是说动态调整。这种模式下无法应对瞬时的高并发情况，因为他的进程数有个逐渐增加的过程。所以需要调整成static模式然后再根据服务器性能配置合理的进程数。
- 负载均衡限额。比如阿里云的SLB最近就增加了配额限制，免费版的实例只有5000的最大连接数，3000的CPS和1000的QPS。
- 压力测试机性能限制。这是一个比较容易忽略限制，所以我们在压力测试的过程中也要注意观察压力测试机的负载。如果达到这个瓶颈，就要考虑采用多机压力测试。
- 应用服务器、Redis、MySQL的最大连接数、CPU和内存等等。这些都是比较严重的限制，所以一定要在压力测试之前就搞清楚。
- Redis带宽。阿里云的Redis带宽限制大概是200M+，如果数据量比较大，在高并发情况下很容易把带宽打满。目前的解决方案有两个，一是在存入Redis之前进行数据压缩，在读取Redis之后再进行解压。二是采用pb进行存储，当然这两种方案我都还没有真正使用过，等我解决了这个瓶颈再来更新。

### 现象

- 503 -- 服务不可用，一般是负载均衡、nginx达到限制。
- 502 -- Bad Gateway，通常是应用进程挂掉了，或者进程不够用处理不过来。
- 500 -- 应用故障，一般是应用抛出了异常没有正常响应，比如达到Redis和MySQL的瓶颈。
- 压力测试不出来的坑：现在大多数正式的项目都是前后端分离的，所以上述说的其实都是压后端接口，而有一种情况是压根压不出来的，那就是接口调用数。作为后端开发，一定要搞清楚承受冲击的前端页面在加载的过程中会调用几个接口，调用几次。如果不搞清楚这些，在真实环境中后端服务器就可能承受比前端服务器还高的压力，从而影响之前针对压力测试数据做出的评估。针对这种情况，其实最好的方案就是在开发之时就跟前端约定好接口调用规则，在接口设计和交互上进行避免。

```
ab -c 100 -n 100000 http://127.0.0.1:8888/hello/index/
This is ApacheBench, Version 2.3 <$Revision: 655654 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking 127.0.0.1 (be patient)
Completed 10000 requests
Completed 20000 requests
Completed 30000 requests
Completed 40000 requests
Completed 50000 requests
Completed 60000 requests
Completed 70000 requests
Completed 80000 requests
Completed 90000 requests
Completed 100000 requests
Finished 100000 requests


Server Software:        Swoole
Server Hostname:        127.0.0.1
Server Port:            8888

Document Path:          /hello/index/
Document Length:        11 bytes

Concurrency Level:      100
Time taken for tests:   10.717 seconds
Complete requests:      100000
Failed requests:        0
Write errors:           0
Total transferred:      27500000 bytes
HTML transferred:       1100000 bytes
Requests per second:    9330.83 [#/sec] (mean)
Time per request:       10.717 [ms] (mean)
Time per request:       0.107 [ms] (mean, across all concurrent requests)
Transfer rate:          2505.84 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    1   1.0      1       9
Processing:     1   10   5.6      8      63
Waiting:        0    7   5.4      6      62
Total:          1   11   5.5      9      63

Percentage of the requests served within a certain time (ms)
  50%      9
  66%     11
  75%     12
  80%     13
  90%     17
  95%     22
  98%     28
  99%     32
 100%     63 (longest request)
```
