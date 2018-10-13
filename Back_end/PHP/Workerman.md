# [Workerman](https://github.com/walkor/Workerman)

An asynchronous event driven PHP framework for easily building fast, scalable network applications. Supports HTTP, Websocket, SSL and other custom protocols. Supports libevent, HHVM, ReactPHP.

## 问题

* 端口曝露https:http端口提供服务，https端口无法服务(握手协议报错)，绑定内网可以提供服务
* 触发:还是由客户端触发响应，服务端不会主动推送，要不断请求
* 融进框架：框架代码的使用，需框架实例化

## 资源

* [workerman手册](http://doc.workerman.net/)
* [walkor/workerman-manual-zh](https://github.com/walkor/workerman-manual-zh):workerman中文手册

## 工具

* [walkor/phpsocket.io](https://github.com/walkor/phpsocket.io):A server side alternative implementation of socket.io in PHP based on workerman.

## 项目

* [walkor/workerman-todpole](https://github.com/walkor/workerman-todpole):HTLM5+WebSocket+PHP(Workerman) , rumpetroll server writen using php http://kedou.workerman.net
