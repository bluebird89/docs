# WebSocket

* HTML5出的东西（协议），也就是说HTTP协议没有变化，或者说没关系，但HTTP是不支持持久连接的（长连接，循环连接的不算）首先HTTP有1.1和1.0之说，也就是所谓的keep-alive，把多个HTTP请求合并为一个
* Websocket其实是一个新协议，跟HTTP协议基本没有关系，只是为了兼容现有浏览器的握手规范而已，也就是说它是HTTP协议上的一种补充
* Websocket是一个持久化的协议，相对于HTTP这种非持久的协议来说。简单的举个例子吧，用目前应用比较广泛的PHP生命周期来解释。1) HTTP的生命周期通过Request来界定，也就是一个Request 一个Response，那么在HTTP1.0中，这次HTTP请求就结束了。在HTTP1.1中进行了改进，使得有一个keep-alive，也就是说，在一个HTTP连接中，可以发送多个Request，接收多个Response。但是请记住 Request = Response，在HTTP中永远是这样，也就是说一个request只能有一个response。而且这个response也是被动的，不能主动发起。
    - 基于HTTP协议的，或者说借用了HTTP的协议来完成一部分握手。
* Websocket只需要一次HTTP握手，所以说整个通讯过程是建立在一次连接/状态中，也就避免了HTTP的非状态性，服务端会一直知道你的信息，直到你关闭请求，这样就解决了接线员要反复解析HTTP协议，还要查看identity info的信息。

* keep-alive，也就是说，在一个HTTP连接中，可以发送多个Request，接收多个Response。但是请记住 Request = Response ， 在HTTP中永远是这样，也就是说一个request只能有一个response。而且这个response也是被动的，不能主动发起。
* Sec-WebSocket-Key 是一个Base64 encode的值，这个是浏览器随机生成的，告诉服务器：泥煤，不要忽悠窝，我要验证尼是不是真的是Websocket助理。
* Sec_WebSocket-Protocol 是一个用户定义的字符串，用来区分同URL下，不同的服务所需要的协议。
* Sec-WebSocket-Version 是告诉服务器所使用的Websocket Draft（协议版本），在最初的时候，Websocket协议还在 Draft 阶段，各种奇奇怪怪的协议都有，而且还有很多期奇奇怪怪不同的东西，现在定为13
* 在一个单独的持久连接上提供全双工、双向通信。在Javascript创建了Web Socket之后，会有一个HTTP请求发送到浏览器以发起连接。在取得服务器响应后，建立的连接会将HTTP升级从HTTP协议交换为WebSocket协议。
* 原理： 在TCP连接第一次握手的时候，升级为ws协议。后面的数据交互都复用这个TCP通道
* 报文格式
    - 客户端：将消息切割成多个帧，并发送给服务端。
    - 服务端：接收消息帧，并将关联的帧重新组装成完整的消息。
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
* polling :是指从客户端（一般就是浏览器）不断主动的向服务器发 HTTP 请求查询是否有新数据

一种连接模式，实现通信协议的通信过程而建立成来的通信管道，其真实的代表是客户端和服务器端的一个通信进程，双方进程通过socket进行通信，而通信的规则采用指定的协议。可以创建任何协议的连接，因为其它协议都是基于此的

* 应用层与TCP/IP协议族通信的中间软件抽象层，它是一组接口。在设计模式中，Socket其实就是一个门面模式，对TCP/IP协议的封装，它把复杂的TCP/IP协议族隐藏在Socket接口后面，对用户来说，一组简单的接口就是全部，让Socket去组织数据，以符合指定的协议。
* socket就是一个 五元组 [180.172.35.150:45678, tcp, 180.97.33.108:80] ，包括：
    - 源IP
    - 源端口
    - 目的IP
    - 目的端口
    - 类型：TCP or UDP
* 优点
    - 传输数据为字节级，传输数据可自定义，数据量小（对于手机应用讲：费用低）
    - 传输数据时间短，性能高
    - 适合于客户端和服务器端之间信息实时交互
    - 可以加密,数据安全性强
* 缺点
    - 需对传输的数据进行解析，转化成应用级的数据
    - 对开发人员的开发水平要求高
    - 相对于Http协议传输，增加了开发量

```C
SOCKET SocketListen =socket(AF_INET,SOCK_STREAM, IPPROTO_TCP);
SOCKET_ERROR = bind(SocketListen,(const sockaddr*)&addr,sizeof(addr))
SOCKET_ERROR == listen(SocketListen,2)
SOCKET SocketWaiter = accept(SocketListen, _Out_    struct sockaddr *addr _Inout_  int *addrlen);
closesocket(SocketListen);closesocket(SocketWaiter);

socket(PF_INET, SOCK_DGRAM, 0)
```

## 头信息

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

```
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

# 服务端
const express = require('express')
const { Server } = require("ws");
const app = express()
const wsServer = new Server({ port: 8080 })
wsServer.on('connection', (ws) => {
    ws.onopen = function () {
        console.log('open')
    }
    ws.onmessage = function (data) {
        console.log(data)
        ws.send('234')
        console.log('onmessage' + data)
    }
    ws.onerror = function () {
        console.log('onerror')
    }
    ws.onclose = function () {
        console.log('onclose')
    }
});

app.listen(8000, (err) => {
    if (!err) { console.log('监听OK') } else {
        console.log('监听失败')
    }
})

# 客户端
const express = require('express')
const { Server } = require("ws");
const app = express()
const wsServer = new Server({ port: 8080 })
wsServer.on('connection', (ws) => {
    ws.onopen = function () {
        console.log('open')
    }
    ws.onmessage = function (data) {
        console.log(data)
        ws.send('234')
        console.log('onmessage' + data)
    }
    ws.onerror = function () {
        console.log('onerror')
    }
    ws.onclose = function () {
        console.log('onclose')
    }
});

app.listen(8000, (err) => {
    if (!err) { console.log('监听OK') } else {
        console.log('监听失败')
    }
})

this.heartTimer = setInterval(() => {
      if (this.heartbeatLoss < MAXLOSSTIMES) {
        events.emit('network', 'sendHeart');
        this.heartbeatLoss += 1;
        this.phoneLoss += 1;
      } else {
        events.emit('network', 'offline');
        this.stop();
      }
      if (this.phoneLoss > MAXLOSSTIMES) {
        this.PhoneLive = false;
        events.emit('network', 'phoneDisconnect');
      }
    }, 5000);
```

## 心跳检测

```go
package main

import (
    "net/http"
    "time"

    "github.com/gorilla/websocket"
)

var (
    //完成握手操作
    upgrade = websocket.Upgrader{
       //允许跨域(一般来讲,websocket都是独立部署的)
       CheckOrigin:func(r *http.Request) bool {
            return true
       },
    }
)

func wsHandler(w http.ResponseWriter, r *http.Request) {
   var (
         conn *websocket.Conn
         err error
         data []byte
   )
   //服务端对客户端的http请求(升级为websocket协议)进行应答，应答之后，协议升级为websocket，http建立连接时的tcp三次握手将保持。
   if conn, err = upgrade.Upgrade(w, r, nil); err != nil {
        return
   }

    //启动一个协程，每隔5s向客户端发送一次心跳消息
    go func() {
        var (
            err error
        )
        for {
            if err = conn.WriteMessage(websocket.TextMessage, []byte("heartbeat")); err != nil {
                return
            }
            time.Sleep(5 * time.Second)
        }
    }()

   //得到websocket的长链接之后,就可以对客户端传递的数据进行操作了
   for {
         //通过websocket长链接读到的数据可以是text文本数据，也可以是二进制Binary
        if _, data, err = conn.ReadMessage(); err != nil {
            goto ERR
     }
     if err = conn.WriteMessage(websocket.TextMessage, data); err != nil {
         goto ERR
     }
   }
ERR:
    //出错之后，关闭socket连接
    conn.Close()
}

func main() {
    http.HandleFunc("/ws", wsHandler)
    http.ListenAndServe("0.0.0.0:7777", nil)
}

# 客户端的心跳检测(Node.js实现)：
this.heartTimer = setInterval(() => {
      if (this.heartbeatLoss < MAXLOSSTIMES) {
        events.emit('network', 'sendHeart');
        this.heartbeatLoss += 1;
        this.phoneLoss += 1;
      } else {
        events.emit('network', 'offline');
        this.stop();
      }
      if (this.phoneLoss > MAXLOSSTIMES) {
        this.PhoneLive = false;
        events.emit('network', 'phoneDisconnect');
      }
    }, 5000);
```

## 对比

* ajax轮询：在一个定时器中不停向服务端发送请求
* long poll：发送请求给服务端，直到服务端觉得可以返回数据了再返回响应，否则这个请求一直挂起
* 服务端就可以主动推送信息给客户端啦。只需要经过一次HTTP请求，就可以做到源源不断的信息传送了（在程序设计中，这种设计叫做回调，即：你有信息了再来通知我，而不是我傻乎乎的每次跑来问你）。

## 安全

* 在建立websocket连接的时候，一定要去检查 HTTP请求中的Origin,确保这个Origin在自己的白名单中。
    - 这个Origin是在HTTP Header中， 是由浏览器自动加上的，不能通过编程的方式（如JavaScript）来改变它。
    - 通过抓包的方式，来修改Origin，需要用Https，和wss来防范了。
* 通过token
    - 服务器端给每个websocket客户端分配一个随机的，唯一的token
    - 浏览器在建立websocket连接的时候，把token也发过来。
    - 服务器端验证token， 如果有效，才建立连接，并且废弃掉这个token

### [scaledrone](https://www.scaledrone.com/):实时聊天系统

```shell
curl -H "Content-Type: application/json" \
   -X POST \
   -d 'Hello from Scaledrone' \
   https://api2.scaledrone.com/KtJ2qzn3CF3svSFe/notifications/publish
```

### [joewalnes/websocketd](https://github.com/joewalnes/websocketd)

Turn any program that uses STDIN/STDOUT into a WebSocket server. Like inetd, but for WebSockets. http://websocketd.com/

```sh
#!/bin/bash
# count.sh:
for ((COUNT = 1; COUNT <= 10; COUNT++)); do
  echo $COUNT
  sleep 1
done

chmod +x count.sh
./count.sh

websocketd --port=8080 ./count.sh // 建立server

# client side
<!DOCTYPE html>
<pre id="log"></pre>
<script>
  // helper function: log message to screen
  function log(msg) {
    document.getElementById('log').textContent += msg + '\n';
  }

  // setup websocket with callbacks
  var ws = new WebSocket('ws://localhost:8080/');
  ws.onopen = function() {
    log('CONNECT');
  };
  ws.onclose = function() {
    log('DISCONNECT');
  };
  ws.onmessage = function(event) {
    log('MESSAGE: ' + event.data);
  };
</script>
```

## 工具

* [uNetworking/uWebSockets](https://github.com/uNetworking/uWebSockets):Tiny WebSockets
* [gorilla/websocket](https://github.com/gorilla/websocket):A WebSocket implementation for Go.
* [websockets/ws](https://github.com/websockets/ws):Simple to use, blazing fast and thoroughly tested WebSocket client and server for Node.js
* [NGINX as a WebSocket Proxy](https://www.nginx.com/blog/websocket-nginx/)

## 参考

* [Web 实时推送技术的总结](https://juejin.im/post/5c20e5766fb9a049b13e387b)
* [细说WebSocket - Node篇](https://juejin.im/entry/5a012eab518825297a0e27f0)
