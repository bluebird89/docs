# [thrift](https://github.com/apache/thrift)

* a lightweight, language-independent software stack with an associated code generation mechanism for RPC http://thrift.apache.org
* for scalable cross-language services development, combines a software stack with a code generation engine to build services that work efficiently and seamlessly between C++, Java, Python, PHP, Ruby, Erlang, Perl, Haskell, C#, Cocoa, JavaScript, Node.js, Smalltalk, OCaml and Delphi and other languages.

* 能够选择传输协议，包括原始 TCP 和 HTTP
    - 原始 TCP 比 HTTP 更高效，然而 HTTP 对于防火墙、浏览器和使用者来说更友好
    - 当前互联网OpenAPI平台和微服务架构实现中仍然是大量以采用Rest API接口为主
    - 对于消息格式的选择，可以看到在使用RestAPI接口的时候，更多的是采用了Json消息格式而非XML，对于SOAP WebService则更多采用了XML消息格式
    - Thrift则还可以采用二进制消息格式以提升性能
* 服务注册和服务目录库管理
    - 在结合了云端PaaS和Docker容器部署后，对于微服务模块部署完成后提供出来的IP地址是动态在变化的，包括模块在进行动态集群扩展的时候也需要动态接入新的服务提供IP地址。
* 服务客户端发现模式 使用客户端发现模式时，客户端决定相应服务实例的网络位置，并且对请求实现负载均衡
* 客户端查询服务注册表
    - 一个可用服务实例的数据库；然后使用负载均衡算法从中选择一个实例，并发出请求。客户端从服务注册服务中查询，其中是所有可用服务实例的库
    - 客户端使用负载均衡算法从多个服务实例中选择出一 个，然后发出请求。 注：这是类似Dubbo实现机制一样的两阶段模式，即任何一个服务的消费都需要分两个步骤进行
        + 首先访问服务注册库（更多是API GateWay提供的一个能力）返回一个已经动态均衡后的服务可用地址
        + 即客户端和该地址直接建立连接进行服务消费和访问
    -  这种模式的实现中有两个重点
        +  动态负载均衡算法
        +  服务网关需要能够对原始服务提供点进行实时的心跳检测以确定服务提供的可用性
    -  Netflix OSS 是客户端发现模式的绝佳范例
        +  Netflix Eureka 是一个服务注册表，为服务实例注册管理和查询可用实例提供了 REST API 接口
        +  Netflix Ribbon 是 IPC 客户端，与 Eureka 一起实现对请求的负载均衡
        +  缺点：底层的IP虽然动态提供出去了，但是最终仍然暴露给了服务消费方，再需要进一步做安全和防火墙隔离的场景下显然是不能满足要求的
*  服务端发现模式 客户端通过负载均衡器向某个服务提出请求，负载均衡器查询服务注册表，并将请求转发到可用的服务实例。如同客户端发现，服务实例在服务注册表中注册或注销。在原文中有图示，基本看图就清楚了，即在服务注册库前新增加了一个Load Balancer节点。注：这两个节点感觉是可以合并到API GateWay的能力中去的
    -  优点:客户端无需关注发现的细节，只需要简单地向负载均衡器发送请求，这减少了编程语言框架需要完成的发现逻辑
    -  缺点:除非负载均衡器由部署环境提供，否则会成为一个需要配置和管理的高可用系统组件
* 服务注册表
    - 需要高可用而且随时更新。客户端能够缓存从服务注册表中获取的网络地址，然而，这些信息最终会过时，客户端也就无法发现服务实例。因此，服务注册表会包含若干服务端，使用复制协议保持一致性
    - 首先可以看到服务注册表本身不能是单点，否则存在单点故障，当服务注册表有多台服务器的时候同时需要考虑服务注册库信息在多台机器上的实时同步和一致。我们操作和配置服务注册信息的时候往往只会在一个统一的服务管控端完成
    - 其次如果服务注册服务器宕机是否一定影响到服务本身的消费和调用，如果考虑更高的整体架构可用性，还可以设计对于服务注册库信息在客户端本地进行缓存，当服务注册表无法访问的时候可以临时读取本地缓存的服务注册库信息并发起服务访问请求
    - 选择
        + Etcd – 高可用、分布式、一致性的键值存储，用于共享配置和服务发现。
        + Consul – 发现和配置的服务，提供 API 实现客户端注册和发现服务。
        + Apache ZooKeeper – 被分布式应用广泛使用的高性能协调服务。
* 服务实例必须在注册表中注册和注销。注册和注销有两种不同的方法
    - 服务实例自己注册，也叫自注册模式（self-registration pattern）
    - 采用管理服务实例注册的其它系统组件，即第三方注册模式
    - 方法一把服务实例和服务注册表耦合，必须在每个编程语言和框架内实现注册代码。但是在自己实现完整微服务架构中，考虑到PaaS平台下微服务模块的动态部署和扩展，采用方法1相当来说更加容易实现。但是方法1仍然不能代替服务注册库本身应该具备的服务节点的心跳检测能力

## Install

* [Boost](https://dl.bintray.com/boostorg/release/1.70.0/source/boost_1_70_0.7z)
* [libevent](https://github.com/libevent/libevent/releases/download/release-2.1.10-stable/libevent-2.1.10-stable.tar.gz)
* [Trift](http://mirrors.tuna.tsinghua.edu.cn/apache/thrift/0.12.0/thrift-0.12.0.tar.gz )

```sh
## Mac
#  Install Boost
./bootstrap.sh
sudo ./b2 threading=multi address-model=64 variant=release stage install

# Install libevent
./configure --prefix=/usr/local
make
sudo make install

# Building Apache Thrift
./configure --prefix=/usr/local/ --with-boost=/usr/local --with-libevent=/usr/local
```

## 数据类型

* 基本
    - bool: 布尔类型(true / false)
    - byte: 8位带符号整数
    - i16: 16位带符号整数
    - i32: 32位带符号整数
    - i64: 64位带符号整数
    - double: 64位浮点数
    - string: 采用UTF-8编码的字符串
    - map<t1,t2> 键值对
    - list<t1> 列表
    - set<t1> 集合

```
# 结构：
struct User {
1: i32 uid,
2: string name,
3: string age,
4: string sex
}

# service，对外扩展的接口：
service UserStorage {
void addUser(1: User user),
User getUser(1: i32 uid)
}

# 使用 thrift 命令生成相应的接口文件：
thrift -out ../python --gen py test.thrift
thrift -out 存储路径 --gen 接口语言 thrift 文件名
```

