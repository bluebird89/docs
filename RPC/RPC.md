# RPC（Remote Procedure Call Protocol）-- 远程过程调用协议

* 一种通过网络从远程计算机程序上请求服务，而不需要了解底层网络协议的协议
* RPC协议假定某些传输协议的存在，如TCP或UDP，为通信程序之间携带信息数据
* 在OSI网络通信模型中，RPC跨越了传输层和应用层
* RPC使得开发包括网络分布式多程序在内的应用程序更加容易

## HTTP 与 RPC 的区别

* 传输协议：
    - HTTP 基于 HTTP 协议。
    - RPC 即可以 HTTP 协议，也可以 TCP 协议。
    - HTTP 也是 RPC 实现的一种方式。
* 性能消耗：
    - HTTP 大部分基于 JSON 实现的，序列化需要时间和性能。
    - RPC 可以基于二进制进行传输，消耗性能少一点。
    - 推荐一个像 JSON ，但比 JSON 传输更快占用更少的新型序列化类库 [MessagePack](https://msgpack.org/)
    - 还有一些服务治理、负载均衡配置的区别。
* 使用场景：
    - 比如浏览器接口、APP接口、第三方接口，推荐使用 HTTP。
    - 比如集团内部的服务调用，推荐使用 RPC。
    - RPC 比 HTTP 性能消耗低，传输效率高，服务治理也方便

##  [brpc/brpc](https://github.com/brpc/brpc)

Brpc 是百度开源的一个基于 protobuf 接口的 RPC 框架，它囊括了百度内部所有 RPC 协议，并支持多种第三方协议，到现在为止，brpc 在 GitHub 上已经拥有 6000 多个关注、17 个代码贡献者。

### [braft](link)

braft 是基于 brpc 的 Raft 协议工业级 C++ 实现，设计之初就考虑高性能和低延迟。由百度云分布式存储团队打造，在百度内部大概有十几个应用场景，部署了 3000 多个服务器，有做 Master 模块 HA 的，也有用作存储节点复制修复的。其中百度云的块存储、NewSQL 存储以及即将推出的 NAS 存储、强一致性 MySQL 都是原生基于 braft 构建的。

对于 braft 和 brpc 之间的关系，braft 是解决复制状态机的问题，而 brpc 是解决模块间 RPC 通信的问题。braft 中 Raft 协议的互通直接使用 brpc 实现，runtime 使用了 bthread，因此 braft 编译需要依赖 brpc，从这点来看 braft 和 brpc 有一定的绑定关系。

## 框架

* [grpc/grpc](https://github.com/grpc/grpc)The C based gRPC (C++, Node.js, Python, Ruby, Objective-C, PHP, C#)
* [apache/thrift](https://github.com/apache/thrift)a lightweight, language-independent software stack with an associated code generation mechanism for RPC
* [alibaba/dubbo](https://github.com/alibaba/dubbo)Dubbo is a high-performance, java based, open source RPC framework
* [weibocom/motan](https://github.com/weibocom/motan)A remote procedure call(RPC) framework for rapid development of high performance distributed services.
* [dangdangdotcom/dubbox](https://github.com/dangdangdotcom/dubbox)Dubbox now means Dubbo eXtensions, and it adds features like RESTful remoting, Kyro/FST serialization, etc to the Dubbo service framework.
* phprpc
* yar
* hprose

## 工具

* [uber/prototool](https://github.com/uber/prototool):Your Swiss Army Knife for Protocol Buffers
* [grpc/grpc-web](https://github.com/grpc/grpc-web):gRPC for Web Clients https://grpc.io
* [improbable-eng/grpc-web](https://github.com/improbable-eng/grpc-web):gRPC Web implementation for Golang and TypeScript
* [Tencent/Tars](https://github.com/Tencent/Tars):Tars is a highly performance rpc framework based on naming service using tars protocol and provides a semi-automatic operation platform.
