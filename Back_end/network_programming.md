# 网络编程

## 阶段

* 原生php实现TCP Server -> 原生php实现http协议 -> 掌握tcpdump的使用 -> 深刻理解tcp连接过程
    - php解释器 能否处理tcp http,可以跳过之前的环节
    - client –(protocol:http)–> nginx –(protocol:fastcgi)–> php-fpm –(interface:sapi)–> php
* 原生php实现多进程webserver
    - 引入I/O多路复用
    - 引入php协程(yield)
    - 对比 I/O多路复用版本 和 协程版本的性能差异
* 实现简单的go web框架
* php c扩展实现简单的webserver

## 图书

* UNIX网络编程
* 《TCP/IP网络编程》
    - [chankeh/net-lenrning-reference](https://github.com/chankeh/net-lenrning-reference):TCP/IP网络编程笔记
