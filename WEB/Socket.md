# Socket 套接字

Socket不属于协议范畴，而是一个调用接口（API），Socket是对TCP/IP协议的封装，通过调用Socket，才能使用TCP/IP协议。Socket连接是长连接，理论上客户端和服务器端一旦建立连接将不会主动断开此连接。Socket连接属于请求-响应形式，服务端可主动将消息推送给客户端。 网络上的两个程序通过一个双向的通信连接实现数据的交换，这个连接的一端称为一个socket。 建立网络通信连接至少要一对端口号(socket)。socket本质是编程接口(API)，对TCP/IP的封装，TCP/IP也要提供可供程序员做网络开发所用的接口，这就是Socket编程接口；HTTP是轿车，提供了封装或者显示数据的具体形式；Socket是发动机，提供了网络通信的能力。

Socket利用网间网通信设施实现进程通信，但它对通信设施的细节毫不关心，只要通信设施能提供足够的通信能力.Socket实质上提供了进程通信的端点。进程通信之前，双方首先必须各自创建一个端点，否则是没有办法建立联系并相互通信的 它是网络通信过程中端点的抽象表示，包含进行网络通信必须的五种信息：连接使用的协议，本地主机的IP地址，本地进程的协议端口，远地主机的IP地址，远地进程的协议端口。 应用层通过传输层进行数据通信时，TCP会遇到同时为多个应用程序进程提供并发服务的问题。多个TCP连接或多个应用程序进程可能需要通过同一个 TCP协议端口传输数据。为了区别不同的应用程序进程和连接，许多计算机操作系统为应用程序与TCP／IP协议交互提供了套接字(Socket)接口。应用层可以和传输层通过Socket接口，区分来自不同应用程序进程或网络连接的通信，实现数据传输的并发服务。

应用层通过传输层进行数据通信时，TCP会遇到同时为多个应用程序进程提供并发服务的问题。
多个TCP连接或多个应用程序进程可能需要通过同一个 TCP协议端口传输数据。
为了区别不同的应用程序进程和连接，许多计算机操作系统为应用程序与TCP／IP协议交互提供了套接字(Socket)接口。应 用层可以和传输层通过Socket接口，区分来自不同应用程序进程或网络连接的通信，实现数据传输的并发服务。

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

## 资源

<http://blog.csdn.net/hguisu/article/details/7445768/>

<http://blog.csdn.net/hguisu/article/details/7444092> <http://blog.csdn.net/hguisu/article/details/7448528> <http://blog.csdn.net/tongdoudpj/article/details/1750045> <https://www.zhihu.com/question/20215561> <http://www.cnblogs.com/JohnTsai/p/5197646.html>

http://blog.csdn.net/dragonyangang/article/details/77937042


服务在连接前监听，客户端主动发起连接，就着点区别。连接上后，两者对等


# WebSocket

WebSocket是HTML5出的东西（协议），也就是说HTTP协议没有变化，或者说没关系，但HTTP是不支持持久连接的（长连接，循环连接的不算）首先HTTP有1.1和1.0之说，也就是所谓的keep-alive，把多个HTTP请求合并为一个，但是Websocket其实是一个新协议，跟HTTP协议基本没有关系，只是为了兼容现有浏览器的握手规范而已，也就是说它是HTTP协议上的一种补充

Websocket是一个持久化的协议，相对于HTTP这种非持久的协议来说。简单的举个例子吧，用目前应用比较广泛的PHP生命周期来解释。1) HTTP的生命周期通过Request来界定，也就是一个Request 一个Response，那么在HTTP1.0中，这次HTTP请求就结束了。在HTTP1.1中进行了改进，使得有一个keep-alive，也就是说，在一个HTTP连接中，可以发送多个Request，接收多个Response。但是请记住 Request = Response ， 在HTTP中永远是这样，也就是说一个request只能有一个response。而且这个response也是被动的，不能主动发起。

首先Websocket是基于HTTP协议的，或者说借用了HTTP的协议来完成一部分握手。

```
GET /chat HTTP/1.1
Host: server.example.com
Upgrade: websocket
Connection: Upgrade
Sec-WebSocket-Key: x3JJHMbDL1EzLkh9GBhXDw==
Sec-WebSocket-Protocol: chat, superchat
Sec-WebSocket-Version: 13
Origin: http://example.com
```

- Sec-WebSocket-Key 是一个Base64 encode的值，这个是浏览器随机生成的，告诉服务器：泥煤，不要忽悠窝，我要验证尼是不是真的是Websocket助理。
- Sec_WebSocket-Protocol 是一个用户定义的字符串，用来区分同URL下，不同的服务所需要的协议。
- Sec-WebSocket-Version 是告诉服务器所使用的Websocket Draft（协议版本），在最初的时候，Websocket协议还在 Draft 阶段，各种奇奇怪怪的协议都有，而且还有很多期奇奇怪怪不同的东西，现在定为13

## 对比

- ajax轮询 的原理非常简单，让浏览器隔个几秒就发送一次请求，询问服务器是否有新信息。需要服务器有很快的处理速度和资源。
- long poll 其实原理跟 ajax轮询 差不多，都是采用轮询的方式，不过采取的是阻塞模型。需要有很高的并发，

- 服务端就可以主动推送信息给客户端啦。只需要经过一次HTTP请求，就可以做到源源不断的信息传送了（在程序设计中，这种设计叫做回调，即：你有信息了再来通知我，而不是我傻乎乎的每次跑来问你）。
-

## 扩展框架

### [scaledrone](https://www.scaledrone.com/):实时聊天系统

```shell
curl -H "Content-Type: application/json" \
   -X POST \
   -d 'Hello from Scaledrone' \
   https://api2.scaledrone.com/KtJ2qzn3CF3svSFe/notifications/publish
```

## 扩展

* [websockets/ws](https://github.com/websockets/ws):Simple to use, blazing fast and thoroughly tested WebSocket client and server for Node.js
* [NGINX as a WebSocket Proxy](https://www.nginx.com/blog/websocket-nginx/)
* [细说WebSocket - Node篇](https://juejin.im/entry/5a012eab518825297a0e27f0)

# Websocket

websocket通信协议实现的是基于浏览器的原生socket，这样原先只有在c/s模式下的大量开发模式都可以搬到web上来了，基本就是通过浏览器的支持在web上实现了与服务器端的socket通信。

* HTTP1.0：生命周期通过Request来界定
* HTTP1.1：keep-alive，在一个HTTP连接中，可以发送多个Request，接收多个Response
    非持久性
    同步有延迟
    消耗资源
    无状态协议。
    被动性
* HTML5的新规范
    * Websocket是一个持久化网络通信的协议
    * 一次HTTP握手，所以说整个通讯过程是建立在一次连接/状态中.有更加轻量级的头，减少数据传送量
    * 可以用于绕过大多数防火墙的限制
    * 服务器主动推送信息
    * 实现实时信息传递
    * 双通道
    * multiplexing



```
GET /chat HTTP/1.1
Host: server.example.com
Upgrade: websocket  # 协议类型
Connection: Upgrade
Sec-WebSocket-Key: x3JJHMbDL1EzLkh9GBhXDw== # 浏览器随机生成Base64 encode的值
Sec-WebSocket-Protocol: chat, superchat # 用户定义的字符串，用来区分同URL下，不同的服务所需要的协议
Sec-WebSocket-Version: 13
Origin: http://example.com
```

```
HTTP/1.1 101 Switching Protocols
Upgrade: websocket
Connection: Upgrade
Sec-WebSocket-Accept: HSmrc0sMlYUkAGmm5OPpG2HaGWk=
Sec-WebSocket-Protocol: chat
```


```js
if('WebSocket' in window){
    // 创建websocket实例
    var socket = new WebSocket('ws://localhost:8080');

    //打开
    socket.onopen = function(event)
    {
    // 发送
    socket.send('I am the client and I\'m listening!');

    // 监听
    socket.onmessage = function(event) {
    console.log('Client received a message',event);
    };

    // 关闭监听
    socket.onclose = function(event) {
    console.log('Client notified socket has closed',event);
    };

    // 关闭
    //socket.close() };
}else{
    alert('本浏览器不支持WebSocket哦~');
}
```

* polling :是指从客户端（一般就是浏览器）不断主动的向服务器发 HTTP 请求查询是否有新数据 。

## 工具

* [uNetworking/uWebSockets](https://github.com/uNetworking/uWebSockets):Tiny WebSockets

