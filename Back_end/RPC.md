# RPC


##  [brpc/brpc](https://github.com/brpc/brpc)

Brpc 是百度开源的一个基于 protobuf 接口的 RPC 框架，它囊括了百度内部所有 RPC 协议，并支持多种第三方协议，到现在为止，brpc 在 GitHub 上已经拥有 6000 多个关注、17 个代码贡献者。

### [braft](link)

braft 是基于 brpc 的 Raft 协议工业级 C++ 实现，设计之初就考虑高性能和低延迟。由百度云分布式存储团队打造，在百度内部大概有十几个应用场景，部署了 3000 多个服务器，有做 Master 模块 HA 的，也有用作存储节点复制修复的。其中百度云的块存储、NewSQL 存储以及即将推出的 NAS 存储、强一致性 MySQL 都是原生基于 braft 构建的。

对于 braft 和 brpc 之间的关系，王耀表示，braft 是解决复制状态机的问题，而 brpc 是解决模块间 RPC 通信的问题。braft 中 Raft 协议的互通直接使用 brpc 实现，runtime 使用了 bthread，因此 braft 编译需要依赖 brpc，从这点来看 braft 和 brpc 有一定的绑定关系。

## 框架

* [grpc/grpc](https://github.com/grpc/grpc)The C based gRPC (C++, Node.js, Python, Ruby, Objective-C, PHP, C#)
* [apache/thrift](https://github.com/apache/thrift)a lightweight, language-independent software stack with an associated code generation mechanism for RPC
* [alibaba/dubbo](https://github.com/alibaba/dubbo)Dubbo is a high-performance, java based, open source RPC framework
* [weibocom/motan](https://github.com/weibocom/motan)A remote procedure call(RPC) framework for rapid development of high performance distributed services.
* [dangdangdotcom/dubbox](https://github.com/dangdangdotcom/dubbox)Dubbox now means Dubbo eXtensions, and it adds features like RESTful remoting, Kyro/FST serialization, etc to the Dubbo service framework.
* [Tencent/Tars](https://github.com/Tencent/Tars):Tars is a highly performance rpc framework based on naming service using tars protocol and provides a semi-automatic operation platform.
* [gRpc docs](https://grpc.io/docs/guides/)
* [grpc/grpc-java](https://github.com/grpc/grpc-java):The Java gRPC implementation. HTTP/2 based RPC https://grpc.io

## 工具

* [uber/prototool](https://github.com/uber/prototool):Your Swiss Army Knife for Protocol Buffers
