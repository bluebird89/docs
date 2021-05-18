# [haproxy](https://github.com/haproxy/haproxy)

HAProxy Load Balancer's development branch <http://www.haproxy.org>

* 拥有强大日志记录功能以及一套不错用户界面
* 提供高可用性、负载均衡以及基于TCP (第四层)和HTTP (第七层)应用的代理软件,支持虚拟主机，它是免费、快速并且可靠的一种解决方案
* 适用于那些负载特大的web站点，这些站点通常又需要会话保持或七层处理。HAProxy运行在时下的硬件上，完全可以支持数以万计的 并发连接。并且它的运行模式使得它可以很简单安全的整合进您当前的架构中
同时可以保护你的web服务器不被暴露到网络上
* 优点
  - 单进程、事件驱动模型显著降低了.上下文切换的开销及内存占用
  - 在任何可用的情况下，单缓冲(single buffering)机制能以不复制任何数据的方式完成读写操作，这会节约大量的CPU时钟周期及内存带宽
  - 借助于Linux 2.6 (>= 2.6.27.19). 上的splice()系统调用，HAProxy可以实现零复制转发(Zero-copy forwarding),在Linux 3.5及以上的OS中还可以实现心零复制启动(zero-starting)
  - 内存分配器在固定大小的内存池中可实现即时内存分配，这能够显著减少创建一个会话的时长
  - 树型存储:侧重于使用作者多年前开发的弹性二叉树，实现了以O(log(N))的低开销来保持计时器命令、保持运行队列命令及管理轮询及最少连接队列
  * HAProxy 是工作在网络 7 层之上
  * 支持 Session 的保持，Cookie 的引导等
  * 支持 url 检测后端的服务器出问题的检测会有很好的帮助
  * 支持的负载均衡算法：动态加权轮循(Dynamic Round Robin)，加权源地址哈希(Weighted Source Hash)，加权 URL 哈希和加权参数哈希(Weighted Parameter Hash)
  * 单纯从效率上来讲 HAProxy 更会比 Nginx 有更出色的负载均衡速度
+ HAProxy 可以对 Mysql 进行负载均衡，对后端的 DB 节点进行检测和负载均衡
  - 优点能够补充 Nginx 的一些缺点，比如支持 Session 的保持，Cookie 的引导；同时支持通过获取指定的 url 来检测后端服务器的状态
  - 本身就只是一款负载均衡软件；单纯从效率上来讲 HAProxy 会比 Nginx 有更出色的负载均衡速度，在并发处理上也是优于 Nginx 的
  - 支持 TCP 协议的负载均衡转发，可以对 MySQL 读进行负载均衡，对后端的 MySQL 节点进行检测和负载均衡，大家可以用 LVS+Keepalived 对 MySQL 主从做负载均衡
  - 均衡策略非常多：Round-robin（轮循）、Weight-round-robin（带权轮循）、source（原地址保持）、RI（请求URL）、rdp-cookie（根据cookie）

## 使用

* 从内置网页当中提取 CSV 数据
* 使用 CLI 工具
* 使用 Unix Socket

## 指标

* 请求率：即每秒请求数量
  - 请求 Count REQ_TOT 不适用于每服务器，而仅计算全部服务器的总体请求率（虽然仅限于最后一秒）
  - 使用 REQ_RATE (每秒请求)，但其仅限于最后一秒，因此大家可能会错过数据峰值时段——特别是监控时长在一分钟以下时
* 错误率：响应错误（简称 ERESP），代表来自后端的错误数量。这是一个计数器，因此必须对其进行增量计算。不过需要注意的是，相关文档指出其中包含“客户端套接上的写入错误”，所以很难搞清这一数值中包含哪些客户端错误类型（特别是在移动设备上）。大家也可以使用这种方法获取每后端服务器信号。关于更多细节信息以及纯 HTTP 错误，大家通常会得到 4xx 及 5xx 错误计数，用户对这类提示也表现得最为敏感。其中 4xx 错误通常不属于客户自身的问题，但如果其突然出现，则通常源自代码错误或者某种形式的攻击。而监控 5xx 错误对于所有系统都非常重要。可能还希望查看请求错误（简称 EREQ），但请注意，这类错误中包括可能带来大量噪声的客户端关闭（特别是在低速或移动网络情况下）。仅限于前端
* 延迟：即每后端响应时间（简称 RTIME），代表过去 1024 条请求的平均延迟（在繁忙系统上，1024 条请求周期可能太短并导致错失峰值状况;但在新启动的系统上，1024 条请求周期可能太长而混入大量噪声）。此项信号适用于每服务器
* 饱和度：队列请求的数量（简称 QCUR）。这一信号适用于后端（代表未被分配至服务器的请求）以及每服务器（代表未被发送至目标服务器的请求）。你可能需要将各项数值相加以计算整体饱和度，或追踪每服务器信号以了解单服务器饱和度（详见 Web 服务器章节）。如果使用每服务器监控方式，则应追踪每套后端服务器的饱和度（但请注意，该服务器自身可能同样在排队，因此负载均衡器中的任何队列都代表着一项严重问题）
* 利用率：HAProxy 通常不会耗尽全部容量，除非 CPU 资源已经被全部占用，但也可以监控实际会话 SCUR/SLIM

## docker

```
# haproxy.cfg
/dev/log    local0
    log /dev/log    local1 notice

defaults
        mode    tcp
        option  dontlognull
        timeout connect 5s
        timeout client 50s
        timeout server 50s
        timeout tunnel 1h
        timeout client-fin 50s
### frontends
# Optional HAProxy Stats Page accessible at http://<host-ip>:8181/haproxy?stats
frontend dtr_stats
        mode http
        bind 0.0.0.0:8181
        default_backend dtr_stats
frontend dtr_80
        mode tcp
        bind 0.0.0.0:80
        default_backend dtr_upstream_servers_80
frontend dtr_443
        mode tcp
        bind 0.0.0.0:443
        default_backend dtr_upstream_servers_443
### backends
backend dtr_stats
        mode http
        option httplog
        stats enable
        stats admin if TRUE
        stats refresh 5m
backend dtr_upstream_servers_80
        mode tcp
        option httpchk GET /_ping HTTP/1.1\r\nHost:\ <DTR_FQDN>
        server node01 <DTR_REPLICA_1_IP>:80 check weight 100
        server node02 <DTR_REPLICA_2_IP>:80 check weight 100
        server node03 <DTR_REPLICA_N_IP>:80 check weight 100
backend dtr_upstream_servers_443
        mode tcp
        option httpchk GET /_ping HTTP/1.1\r\nHost:\ <DTR_FQDN>
        server node01 <DTR_REPLICA_1_IP>:443 weight 100 check check-ssl verify none
        server node02 <DTR_REPLICA_2_IP>:443 weight 100 check check-ssl verify none
        server node03 <DTR_REPLICA_N_IP>:443 weight 100 check check-ssl verify none

docker run --detach \
  --name dtr-lb \
  --publish 443:443 \
  --publish 80:80 \
  --publish 8181:8181 \
  --restart=unless-stopped \
  --volume ${PWD}/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg:ro \
  haproxy:1.7-alpine haproxy -d -f /usr/local/etc/haproxy/haproxy.cfg
```

## 注意

* 大多数（甚至全部）HAProxy 版本只面向单一进程报告统计数据，这种方法对于 99% 的用例都没有问题，但极少数高性能系统会使用多进程模式，这意味着其监控难度将直线提升。因为统计数据将随机提取自某一进程，这可能引发混乱，因此大家必须尽可能避免多进程监控情况。
* HAProxy 当中的实用统计信息包括 PER 监听程序、后端或者服务器几种，虽然这些指标都很重要，但却会给整体评估带来复杂性挑战。简单的网站或应用程序通常只有一个（www.）监听程序与后端，但更为复杂的系统却通常包含多个监听程序与后端。这意味着我们会很快收集到数百项指标并陷入混乱。

## 参考

* [docker-library/haproxy](https://github.com/docker-library/haproxy):Docker Official Image packaging for HAProxy <http://www.haproxy.org/>
