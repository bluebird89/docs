# [thrift](https://github.com/apache/thrift)

* a lightweight, language-independent software stack with an associated code generation mechanism for RPC http://thrift.apache.org
* for scalable cross-language services development, combines a software stack with a code generation engine to build services that work efficiently and seamlessly between C++, Java, Python, PHP, Ruby, Erlang, Perl, Haskell, C#, Cocoa, JavaScript, Node.js, Smalltalk, OCaml and Delphi and other languages.
* 由一个软件库和一系列的代码生成工具组成，由 Facebook开发。目的是为了加快软件开发和实现高效和可扩展的后台服务。主要目标是不同程序开语言之间实现高效和可靠的通信，这需要将不同语言之间抽象出一个通用层，然后由不同语言来实现这个通用层。在这里要特别指出的是，Thrift允许开发人员定义数据类型和服务接口（定义在一个中性语言文件里），并通过这个文件生成构建RPC客户端和服务端所需的代码
* 通过代码生成工具将接口定义文件生成服务器端和客户端代码（可以为不同语言），从而实现服务端和客户端跨语言的支持
* 传输层定义了数据的传输方式，可以为TCP/IP传输，内存共享或者文件共享等形式
    - 原始 TCP 比 HTTP 更高效，然而 HTTP 对于防火墙、浏览器和使用者来说更友好
    - 当前互联网OpenAPI平台和微服务架构实现中仍然是大量以采用Rest API接口为主
    - 对于消息格式的选择，可以看到在使用RestAPI接口的时候，更多的是采用了Json消息格式而非XML，对于SOAP WebService则更多采用了XML消息格式
    - Thrift则还可以采用二进制消息格式以提升性能
* 协议层定义了数据的传输格式，可以为二进制流或者XML等形式。
* 当服务器端使用socket协议时，可以用simple|thread-pool|threaded|nonblocking等方式运行，从而获得更好的性能

## 原理

* 在多种不同的语言之间通信thrift可以作为二进制的高性能的通讯中间件，支持数据(对象)序列化和多种类型的RPC服务。
* Thrift适用于程序对程 序静态的数据交换，需要先确定好他的数据结构，他是完全静态化的，当数据结构发生变化时，必须重新编辑IDL文件，代码生成，再编译载入的流程，跟其他IDL工具相比较可以视为是Thrift的弱项，Thrift适用于搭建大型数据交换及存储的通用工具，对于大型系统中的内部数据传输相对于JSON和xml无论在性能、传输大小上有明显的优势
* Thrift是IDL(interface definition language)描述性语言的一个具体实现
* Thrift是一个服务端和客户端的架构体系
* 具有自己内部定义的传输协议规范(TProtocol)和传输数据标准(TTransports)，通过IDL脚本对传输数据的数据结构(struct) 和传输数据的业务逻辑(service)根据不同的运行环境快速的构建相应的代码，并且通过自己内部的序列化机制对传输的数据进行简化和压缩提高高并发、大型系统中数据交互的成本

## 协议

* 选择客户端与服务端之间传输通信协议的类别，在传输协议上总体上划分为文本(text)和二进制(binary)传输协议, 为节约带宽，提供传输效率，一般情况下使用二进制类型的传输协议为多数，但有时会还是会使用基于文本类型的协议，这需要根据项目/产品中的实际需求：
    - TBinaryProtocol – 二进制编码格式进行数据传输。
    - TCompactProtocol – 这种协议非常有效的，使用Variable-Length Quantity (VLQ) 编码对数据进行压缩
    - TJSONProtocol – 使用JSON的数据编码协议进行数据传输。
    - TSimpleJSONProtocol – 这种节约只提供JSON只写的协议，适用于通过脚本语言解析
    - TDebugProtocol – 在开发的过程中帮助开发人员调试用的，以文本的形式展现方便阅读

## 传输层

* TSocket- 使用堵塞式I/O进行传输，也是最常见的模式。
* TFramedTransport- 使用非阻塞方式，按块的大小，进行传输，类似于Java中的NIO。
* TFileTransport- 顾名思义按照文件的方式进程传输，虽然这种方式不提供Java的实现，但是实现起来非常简单。
* TMemoryTransport- 使用内存I/O，就好比Java中的ByteArrayOutputStream实现。
* TZlibTransport- 使用执行zlib压缩，不提供Java的实现

## 服务端类型

* TSimpleServer -  单线程服务器端使用标准的堵塞式I/O。
* TThreadPoolServer -  多线程服务器端使用标准的堵塞式I/O。
* TNonblockingServer – 多线程服务器端使用非堵塞式I/O，并且实现了Java中的NIO通道

## 服务管理

* 服务注册和服务目录库管理
    - 在结合了云端PaaS和Docker容器部署后，对于微服务模块部署完成后提供出来的IP地址是动态在变化的，包括模块在进行动态集群扩展的时候也需要动态接入新的服务提供IP地址。
* 服务客户端发现模式:使用客户端发现模式时，客户端决定相应服务实例的网络位置，并且对请求实现负载均衡
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
* 服务端发现模式 客户端通过负载均衡器向某个服务提出请求，负载均衡器查询服务注册表，并将请求转发到可用的服务实例。如同客户端发现，服务实例在服务注册表中注册或注销。在原文中有图示，基本看图就清楚了，即在服务注册库前新增加了一个Load Balancer节点。注：这两个节点感觉是可以合并到API GateWay的能力中去的
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

* Base Types：基本类型
    - bool: 布尔类型(true / false)
    - byte: 8位带符号整数
    - i16: 16位带符号整数
    - i32: 32位带符号整数
    - i64: 64位带符号整数
    - binary 字符数组
    - double: 64位浮点数
    - string: 采用UTF-8编码的字符串
    - map<t1,t2> 键值对
    - list<t1> 有序元素列表
    - set<t1> 无序不重复元素集
    - map key-value型的映射
* Struct：结构体类型
* Container：容器类型，即List、Set、Map
* Exception：异常类型
    - 继承于本地语言的exception基类
* Service： 定义对象的接口，和一系列方法

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


## 与其他传输方式的比较

* xml与JSON相比体积太大，但是xml传统，也不算复杂。
* json 体积较小，新颖，但不够完善。
* thrift 体积超小，使用起来比较麻烦，不如前两者轻便，但是对于1.高并发、2.数据传输量大、3.多语言环境， 满足其中2点使用 thrift还是值得的
