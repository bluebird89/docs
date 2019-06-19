# Socket 套接字

* Socket不属于协议范畴，而是一个调用接口（API），Socket是对TCP/IP协议的封装，通过调用Socket，才能使用TCP/IP协议
* Socket连接是长连接，理论上客户端和服务器端一旦建立连接将不会主动断开此连接
* Socket连接属于请求-响应形式，服务端可主动将消息推送给客户端
* 网络上的两个程序通过一个双向的通信连接实现数据的交换，这个连接的一端称为一个socket
* 建立网络通信连接至少要一对端口号(socket)
* socket本质是编程接口(API)，对TCP/IP的封装，TCP/IP也要提供可供程序员做网络开发所用的接口，这就是Socket编程接口；HTTP是轿车，提供了封装或者显示数据的具体形式；Socket是发动机，提供了网络通信的能力。
* Socket利用网间网通信设施实现进程通信，但它对通信设施的细节毫不关心，只要通信设施能提供足够的通信能力
* Socket实质上提供了进程通信的端点
* 进程通信之前，双方首先必须各自创建一个端点，否则是没有办法建立联系并相互通信的
* 它是网络通信过程中端点的抽象表示，包含进行网络通信必须的五种信息：连接使用的协议，本地主机的IP地址，本地进程的协议端口，远地主机的IP地址，远地进程的协议端口
* 应用层通过传输层进行数据通信时，TCP会遇到同时为多个应用程序进程提供并发服务的问题
* 多个TCP连接或多个应用程序进程可能需要通过同一个 TCP协议端口传输数据
* 为了区别不同的应用程序进程和连接，许多计算机操作系统为应用程序与TCP／IP协议交互提供了套接字(Socket)接口
* 应用层可以和传输层通过Socket接口，区分来自不同应用程序进程或网络连接的通信，实现数据传输的并发服务。

应用层通过传输层进行数据通信时，TCP会遇到同时为多个应用程序进程提供并发服务的问题。
多个TCP连接或多个应用程序进程可能需要通过同一个 TCP协议端口传输数据。
为了区别不同的应用程序进程和连接，许多计算机操作系统为应用程序与TCP／IP协议交互提供了套接字(Socket)接口。应 用层可以和传输层通过Socket接口，区分来自不同应用程序进程或网络连接的通信，实现数据传输的并发服务。
Socket 可以被定义描述为两个应用通信通道的端点。一个 Socket 端点可以用 Socket 地址来描述， Socket 地址结构由 IP 地址，端口和使用协议组成（ TCP or UDP ）。http协议可以通过socket实现，socket在传输层上实现。从这个角度来说，socket介于应用层和传输层之间。但是socket作为一种进程通信机制，操作系统分配唯一一个socket号，是依赖于通信协议的，但是这个通信协议不仅仅是 tcp或udp，也可以是其它协议。

## 原理

* 域Socket：“Unix domain socket 或者 IPCsocket 是一种终端，可以使同一台操作系统上的两个或多个进程进行数据通信。
* 与管道相比，Unix domain sockets 既可以使用字节流数和数据队列，而管道通信则只能通过字节流。
* Unix domain sockets的接口和Internet socket很像，但它不使用网络底层协议来通信。
* Unix domain socket 的功能是POSIX操作系统里的一种组件。
* Unix domain sockets 使用系统文件的地址来作为自己的身份。它可以被系统进程引用。所以两个进程可以同时打开一个Unix domain sockets来进行通信。不过这种通信方式是发生在系统内核里而不会在网络里传播。
* These are secure in that they are file-based and can't be read by remote servers. We can further use linux permission to set who can read and write to this socket file.

## Unix Socket vs Tcp Socket

* 不会走到TCP 那层，直接以文件形式，以stream socket通讯。
* unix socket减少了不必要的tcp开销，而tcp需要经过loopback，还要申请临时端口和tcp相关资源。
* unix socket高并发时候不稳定，连接数爆发时，会产生大量的长时缓存，在没有面向连接协议的支撑下，大数据包可能会直接出错不返回异常。
* tcp这样的面向连接的协议，多少可以保证通信的正确性和完整性。
* TCP socket,则需要走到IP层

![Unix_Socket_Tcp_Socket](../static/tcp-socket-or-unix-domain-socket1.png "Unix_Socket_Tcp_Socket")
![socket2](../static/socket2.png "socket2")

## 过程

建立Socket连接至少需要一对套接字，其中一个运行于客户端，称为ClientSocket ，另一个运行于服务器端，称为ServerSocket 。

- 服务器监听：是服务器端套接字并不定位具体的客户端套接字，而是处于等待连接的状态，实时监控网络状态。
- 客户端请求：是指由客户端的套接字提出连接请求，要连接的目标是服务器端的套接字。为此，客户端的套接字必须首先描述它要连接的服务器的套接字，指出服务器端套接字的地址和端口号，然后就向服务器端套接字提出连接请求。
- 连接确认：是指当服务器端套接字监听到或者说接收到客户端套接字的连接请求，它就响应客户端套接字的请求，建立一个新的线程，把服务器端套接字的描述发给客户端，一旦客户端确认了此描述，连接就建立好了。而服务器端套接字继续处于监听状态，继续接收其他客户端套接字的连接请求。

创建Socket连接时，可以指定使用的传输层协议，Socket可以支持不同的传输层协议（TCP或UDP）。

socket则是对TCP/IP协议的封装和应用。也可以说，TPC/IP协议是传输层协议，主要解决数据 如何在网络中传输，而HTTP是应用层协议，主要解决如何包装数据。
Socket编程接口在设计的时候，就希望也能适应其他的网络协议。 TCP/IP也要提供可供程序员做网络开发所用的接口，这就是Socket编程接口。

![socket连接](../_static/tcp.png "Optional title")

## 方法

* 把一个地址族中的特定地址赋给socket
    - sockfd：即socket描述字，它是通过socket()函数创建了，唯一标识一个socket。bind()函数就是将给这个描述字绑定一个名字。
    - addr：一个const struct sockaddr *指针，指向要绑定给sockfd的协议地址。这个地址结构根据地址创建socket时的地址协议族的不同而不同

```c++
int bind(int sockfd, const struct sockaddr *addr, socklen_t addrlen);

int listen(int sockfd, int backlog);
int connect(int sockfd, const struct sockaddr *addr, socklen_t addrlen);

int accept(int sockfd, struct sockaddr *addr, socklen_t *addrlen);

#include <unistd.h>

ssize_t read(int fd, void *buf, size_t count);
ssize_t write(int fd, const void *buf, size_t count);

#include <sys/types.h>
#include <sys/socket.h>

ssize_t send(int sockfd, const void *buf, size_t len, int flags);
ssize_t recv(int sockfd, void *buf, size_t len, int flags);

ssize_t sendto(int sockfd, const void *buf, size_t len, int flags,
              const struct sockaddr *dest_addr, socklen_t addrlen);
ssize_t recvfrom(int sockfd, void *buf, size_t len, int flags,
                struct sockaddr *src_addr, socklen_t *addrlen);

ssize_t sendmsg(int sockfd, const struct msghdr *msg, int flags);
ssize_t recvmsg(int sockfd, struct msghdr *msg, int flags);

int close(int fd);
```

## IO

* 阻塞IO
    - 你去甜在心馒头店买太极馒头，阿梅说：＂暂时没，正在蒸呢，你自己看着点儿！＂．于是你就站在旁边只等馒头．此时的你，是阻塞的，是同步的．阻塞表现在你除了等馒头，别的什么都不做了．同步表现在等馒头的过程中，阿梅不提供通知服务，你不得不自己要等到＂馒头出炉＂的消息
        + 典型PHP开发，基于LNMP
    - 你去甜在心馒头店买太极馒头，阿梅说：＂暂时没，正在蒸呢，蒸好了我打电话告诉你！＂．但你依然站在旁边只等馒头，此时的你，是阻塞的，是异步的．阻塞表现在你除了等馒头，别的什么都不做了．异步表现在等馒头的过程中，阿梅提供电话通知＂馒头出炉＂的消息，你只需要等阿梅的电话．
* 非阻塞IO
    - 你去甜在心馒头店买太极馒头，阿梅说：＂暂时没，正在蒸呢，你自己看着点儿！＂．于是你就站在旁边发微信，然后问一句：＂好了没？＂，然后发QQ，然后再问一句：＂好了没？＂．此时的你，是非阻塞的，是同步的．非阻塞表现在你除了等馒头，自己还干干别的时不时会主动问问馒头好没好．同步表现在等馒头的过程中，阿梅不提供通知服务，你不得不自己要等到＂馒头出炉＂的消息．
    - 你去甜在心馒头店买太极馒头，阿梅说：＂暂时没，正在蒸呢，蒸好了我打电话告诉你！＂．于是你就走了，去买了双新球鞋，看了看武馆，总之，从此不再过问馒头的事情，一心只等阿梅电话．此时的你，是非阻塞的，是异步的．非阻塞表现在你除了等馒头，自己还干干别的时不时会主动问问馒头好没好．异步表现在等馒头的过程中，阿梅提供电话通知＂馒头出炉＂的消息，你只需要等阿梅的电话．
* 阻塞和非阻塞关注的是：在等馒头的过程中，你在干啥
* 同步和异步关注的是：等馒头这件事，你是一直等到＂馒头出炉＂的结果，还是立即跑路等阿梅告诉你的＂馒头出炉＂．
* 最傻的人才会采用异步阻塞的IO方式去写程序
* IO多路复用
    - select
    - poll
    - epoll
        + 在epoll出世前，QQ用户量剧增，但是select以及select的高配版本poll都无法解决他们的问题，于是乎QQ当年的服务器就不得不用UDP协议来避规这个问题，一直到后来有了epoll，QQ开始逐步在PC客户端中的配置项中允许用户选择UDP服务器或TCP服务器
* 信号驱动IO

## 资源

<http://blog.csdn.net/hguisu/article/details/7445768/>

<http://blog.csdn.net/hguisu/article/details/7444092>
<http://blog.csdn.net/hguisu/article/details/7448528>
<http://blog.csdn.net/tongdoudpj/article/details/1750045>
<https://www.zhihu.com/question/20215561>
<http://www.cnblogs.com/JohnTsai/p/5197646.html>

http://blog.csdn.net/dragonyangang/article/details/77937042

## 工具

* [henrylee2cn/teleport](https://github.com/henrylee2cn/teleport):Teleport is a versatile, high-performance and flexible socket framework. It can be used for RPC, micro services, peer-peer, push services, game services and so on. https://github.com/henrylee2cn/tpdoc
