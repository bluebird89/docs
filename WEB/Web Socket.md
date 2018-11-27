# WebSocket

WebSocket是HTML5出的东西（协议），也就是说HTTP协议没有变化，或者说没关系，但HTTP是不支持持久连接的（长连接，循环连接的不算）首先HTTP有1.1和1.0之说，也就是所谓的keep-alive，把多个HTTP请求合并为一个，但是Websocket其实是一个新协议，跟HTTP协议基本没有关系，只是为了兼容现有浏览器的握手规范而已，也就是说它是HTTP协议上的一种补充

Websocket是一个持久化的协议，相对于HTTP这种非持久的协议来说。简单的举个例子吧，用目前应用比较广泛的PHP生命周期来解释。1) HTTP的生命周期通过Request来界定，也就是一个Request 一个Response，那么在HTTP1.0中，这次HTTP请求就结束了。在HTTP1.1中进行了改进，使得有一个keep-alive，也就是说，在一个HTTP连接中，可以发送多个Request，接收多个Response。但是请记住 Request = Response ， 在HTTP中永远是这样，也就是说一个request只能有一个response。而且这个response也是被动的，不能主动发起。

首先Websocket是基于HTTP协议的，或者说借用了HTTP的协议来完成一部分握手。

Websocket是一个持久化的协议.Websocket只需要一次HTTP握手，所以说整个通讯过程是建立在一次连接/状态中，也就避免了HTTP的非状态性，服务端会一直知道你的信息，直到你关闭请求，这样就解决了接线员要反复解析HTTP协议，还要查看identity info的信息。

keep-alive，也就是说，在一个HTTP连接中，可以发送多个Request，接收多个Response。但是请记住 Request = Response ， 在HTTP中永远是这样，也就是说一个request只能有一个response。而且这个response也是被动的，不能主动发起。

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
* [gorilla/websocket](https://github.com/gorilla/websocket):A WebSocket implementation for Go.
