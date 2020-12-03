# [haproxy](https://github.com/haproxy/haproxy)

HAProxy Load Balancer's development branch <http://www.haproxy.org>

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

## 参考

* [docker-library/haproxy](https://github.com/docker-library/haproxy):Docker Official Image packaging for HAProxy <http://www.haproxy.org/>
