# Socket 套接字

Socket不属于协议范畴，而是一个调用接口（API），Socket是对TCP/IP协议的封装，通过调用Socket，才能使用TCP/IP协议。Socket连接是长连接，理论上客户端和服务器端一旦建立连接将不会主动断开此连接。Socket连接属于请求-响应形式，服务端可主动将消息推送给客户端。 网络上的两个程序通过一个双向的通信连接实现数据的交换，这个连接的一端称为一个socket。 建立网络通信连接至少要一对端口号(socket)。socket本质是编程接口(API)，对TCP/IP的封装，TCP/IP也要提供可供程序员做网络开发所用的接口，这就是Socket编程接口；HTTP是轿车，提供了封装或者显示数据的具体形式；Socket是发动机，提供了网络通信的能力。

Socket利用网间网通信设施实现进程通信，但它对通信设施的细节毫不关心，只要通信设施能提供足够的通信能力.Socket实质上提供了进程通信的端点。进程通信之前，双方首先必须各自创建一个端点，否则是没有办法建立联系并相互通信的 它是网络通信过程中端点的抽象表示，包含进行网络通信必须的五种信息：连接使用的协议，本地主机的IP地址，本地进程的协议端口，远地主机的IP地址，远地进程的协议端口。 应用层通过传输层进行数据通信时，TCP会遇到同时为多个应用程序进程提供并发服务的问题。多个TCP连接或多个应用程序进程可能需要通过同一个 TCP协议端口传输数据。为了区别不同的应用程序进程和连接，许多计算机操作系统为应用程序与TCP／IP协议交互提供了套接字(Socket)接口。应用层可以和传输层通过Socket接口，区分来自不同应用程序进程或网络连接的通信，实现数据传输的并发服务。

## 过程

建立Socket连接至少需要一对套接字，其中一个运行于客户端，称为ClientSocket ，另一个运行于服务器端，称为ServerSocket 。

- 服务器监听：是服务器端套接字并不定位具体的客户端套接字，而是处于等待连接的状态，实时监控网络状态。
- 客户端请求：是指由客户端的套接字提出连接请求，要连接的目标是服务器端的套接字。为此，客户端的套接字必须首先描述它要连接的服务器的套接字，指出服务器端套接字的地址和端口号，然后就向服务器端套接字提出连接请求。
- 连接确认：是指当服务器端套接字监听到或者说接收到客户端套接字的连接请求，它就响应客户端套接字的请求，建立一个新的线程，把服务器端套接字的描述发给客户端，一旦客户端确认了此描述，连接就建立好了。而服务器端套接字继续处于监听状态，继续接收其他客户端套接字的连接请求。

创建Socket连接时，可以指定使用的传输层协议，Socket可以支持不同的传输层协议（TCP或UDP）。

socket则是对TCP/IP协议的封装和应用。也可以说，TPC/IP协议是传输层协议，主要解决数据 如何在网络中传输，而HTTP是应用层协议，主要解决如何包装数据。ocket编程接口在设计的时候，就希望也能适应其他的网络协议。 TCP/IP也要提供可供程序员做网络开发所用的接口，这就是Socket编程接口。

## 资源

[Workerman](https://github.com/walkor/Workerman)An asynchronous event driven PHP framework for easily building fast, scalable network applications. Supports HTTP, Websocket, SSL and other custom protocols. Supports libevent, HHVM, ReactPHP.

<http://blog.csdn.net/hguisu/article/details/7445768/>

<http://blog.csdn.net/hguisu/article/details/7444092> <http://blog.csdn.net/hguisu/article/details/7448528> <http://blog.csdn.net/tongdoudpj/article/details/1750045> <https://www.zhihu.com/question/20215561> <http://www.cnblogs.com/JohnTsai/p/5197646.html>

http://blog.csdn.net/dragonyangang/article/details/77937042
