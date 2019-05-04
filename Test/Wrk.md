# [Wrk](https://github.com/wg/wrk)

一款针对 Http 协议的基准测试工具，它能够在单机多核 CPU 的条件下，使用系统自带的高性能 I/O 机制，如 epoll，kqueue 等，通过多线程和事件模式，对目标机器产生大量的负载。

* 轻量级性能测试工具;
* 安装简单（相对 Apache ab 来说）;
* 学习曲线基本为零，几分钟就能学会咋用了；
* 基于系统自带的高性能 I/O 机制，如 epoll, kqueue, 利用异步的事件驱动框架，通过很少的线程就可以压出很大的并发量；
* 仅支持单机压测

## 安装

只能被安装在类 Unix 系统上

```sh
sudo apt-get install build-essential libssl-dev git -y
git clone https://github.com/wg/wrk.git wrk
cd wrk
make
# 将可执行文件移动到 /usr/local/bin 位置
sudo cp wrk /usr/local/bin

sudo yum groupinstall 'Development Tools'
sudo yum install -y openssl-devel git
git clone https://github.com/wg/wrk.git wrk
cd wrk
make
# 将可执行文件移动到 /usr/local/bin 位置
sudo cp wrk /usr/local/bin

brew install wrk
```

## 使用

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
```
