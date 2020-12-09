# [grpc](https://github.com/grpc/grpc)

The C based gRPC (C++, Node.js, Python, Ruby, Objective-C, PHP, C#)

* 一个高性能、通用的开源RPC框架
* 基于HTTP/2协议标准和Protobuf序列化协议开发，支持多种开发语言（Golang、Python、Java、C/C++等）,带来诸如双向流、流控、头部压缩、单 TCP 连接上的多复用请求等特性。这些特性使得其在移动设备上表现更好，更省电和节省空间占用。
* gRPC 提供了一种简单的方法来定义服务，同时客户端可以充分利用 HTTP/2 stream 的特性，从而有助于节省带宽、降低 TCP 的连接次数、节省CPU的使用等。
* 服务端，实现了所定义的服务和可供远程调用的方法，运行一个gRPC server来处理客户端的请求
* 客户端可以像调用本地对象一样直接调用位于不同机器的服务端方法，可以非常方便的创建一些分布式的应用服务
* 使用protocol buffers作为接口描述语言（IDL）以及底层的信息交换格式，来描述服务接口和有效负载消息的结构

## install

* 下载[Protocol Buffers v3.8.0](https://github.com/protocolbuffers/protobuf/releases)

```sh
./configure --prefix=your_pb_install_path

brew install protobuf
protoc --version

brew install grpc
```

## 概念

* service定义了一个server,接口可以是四种类型
  - 一元RPC:`rpc GetFeature(Point) returns (Feature) {}`：类似普通的函数调用，客户端发送请求Point到服务器，服务器返回相应Feature
    + 一旦客户端调用了存根/客户端对象上的方法，服务器会被通知RPC已经被调用了，同样会接收到调用时客户端的元数据、调用的方法名称以及制定的截止时间(如果适用的话)。
    + 服务器可以立即发送自己的初始元数据（必须在发送任何响应之前发送），也可以等待客户端的请求消息-哪个先发生应用程序指定的。
    + 服务器收到客户的请求消息后，它将完成创建和填充其响应所需的必要工作。然后将响应（如果成功）连同状态详细信息（状态代码和可选状态消息）以及可选尾随元数据一起返回。
    + 如果状态是OK，客户端将获得响应，从而在客户端完成并终结整个调用过程
  - 服务器流式RPC:`rpc ListFeatures(Rectangle) returns (stream Feature) {}`：客户端发起一次请求，服务器端获取流以读取回一系列消息，比如一个数组中的逐个元素,gRPC保证单个RPC调用中的消息顺序
    + 与简单的一元RPC类似，不同的是服务器在接收到客户端的请求消息后会发回一个响应流。在发送回所有的响应后，服务器的状态详情（状态码和可选的状态信息）和可选的尾随元数据会被发回以完成服务端的工作。客户端在接收到所有的服务器响应后即完成操作
  - 客户端流式RPC:`rpc RecordRoute(stream Point) returns (RouteSummary) {}`：客户端使用提供的流写入消息序列然后将它们发送到服务器，比如数组中的逐个元素，服务器返回一个响应,gRPC保证了在单个RPC调用中的消息顺序
    + 也类似于一元PRC，不同之处在于客户端向服务器发送请求流而不是单个请求。服务器通常在收到客户端的所有请求后（但不一定）发送单个响应，以及其状态详细信息和可选的尾随元数据。
  - 双向流式RPC:`rpc RouteChat(stream RouteNote) returns (stream RouteNote) {}`：双方都使用读写流发送一系列消息。这两个流是独立运行的，因此客户端和服务器可以按照自己喜欢的顺序进行读写
    + 调用由客户端调用方法发起，服务器接收客户端元数据，方法名称和期限。同样，服务器可以选择发回其初始元数据，或等待客户端开始发送请求。
    + 接下来发生的情况取决于应用程序，因为客户端和服务器可以按任何顺序进行读取和写入-流操作完全是独立地运行。例如，服务器可以等到收到所有客户端的消息后再写响应，或者服务器和客户端可以玩“乒乓”：服务器收到请求，然后发回响应，然后客户端发送基于响应的另一个请求，依此类推。
* 客户端调用这些API，服务器端实现相应的API
  - 服务侧，服务器实现服务中声明的方法并运行一个gRPC服务器来处理客户端的调用。gRPC的基础设施解码传入的请求，执行服务的方法，编码服务的响应
  - 客户端，客户端拥有一个名为stub(存根)的本地对象（在有些语言中更倾向于把stub叫做客户端）该对象同样实现了服务中的方法。客户端可以只在本地对象上调用这些方法，将调用参数包装在适当的protocol buffer消息类型中，gRPC会负责将请求发送给服务器并且返回服务端的protocol buffer响应
* 同步vs异步
  - 同步RPC调用会阻塞当前线程直到服务器收到响应为止，这是最接近RPC所追求的过程调用抽象的近似方法
  - 网络本质上是异步的，并且在许多情况下能够启动RPC而不阻塞当前线程很有用。
* 截止时间/超时时间：gRPC允许客户端指定在RPC被 DEADLINE_EXCEEDED错误终结前愿意等待多长时间来让RPC完成工作。在服务器端，服务器可以查看一个特定的RPC是否超时或者还有多长时间剩余来完成RPC
* 终止:在gRPC中，客户端和服务端对调用是否成功做出独立的基于本地的决定，而且两端的结论有可能不匹配
* 元数据:以键值对列表形式提供的关于特定RPC调用的信息（比如说身份验证详情），其中键是字符串，值通常来说是字符串（但是也可以是二进制数据）
* 取消:客户端或服务器都可以随时取消RPC。取消操作将立即终止RPC，因此不再进行任何工作。这不是“撤消”：取消之前所做的更改不会回滚
* 通道:一个gRPC通道提供了一个到指定主机和端口号的gRPC服务器的连接，它在创建客户端存根（或者对某些语言来说就是“客户端”）时被使用。客户端可以指定通道参数来更改gRPC的默认行为.每个通道都有状态，状态包括 connected和 idle(闲置)

## 认证方式

* 基于SSL/TLS认证方式
* 远程调用认证方式
* 两种方式可以混合使用

## example

* 在.proto 文件中定义好接口:可以确保客户端发送或服务器端接收到的数据是遵循规范的，这样非常有助于调试
* 使用 protoc 编译器编译这个文件，生成客户端和服务器端代码
* 可以开始编写调用这个 API 或提供 API 服务的代码

```python
pip install grpcio
pip install grpcio-tools

## receiver.proto 定义一个数据接收服务Receiver，用来接收客户端传递给服务器端的数据
syntax = "proto3";
import "google/protobuf/struct.proto";

// 服务定义
service Receiver {
  rpc receive (Event) returns (Reply) {}
}

// 接收消息定义
message Event {
  string appid = 1;
  int32 xwhen = 2;
  string xwho = 3;
  string xwhat = 4;
  google.protobuf.Struct xcontext = 5;
}

// 返回消息定义
message Reply {
  int32 status = 1;
  string message = 2;
}

python -m grpc_tools.protoc -I. --python_out=. --grpc_python_out=. ./receiver.proto

# server.py
# _*_ coding: utf-8 _*_

import grpc
import receiver_pb2
import receiver_pb2_grpc

import time
from concurrent import futures

_ONE_DAY_IN_SECONDS = 60 * 60 * 24


class Receiver(receiver_pb2_grpc.ReceiverServicer):

    # 重写父类方法，返回消息
    def receive(self, request, context):
        print('request:', request)
        return receiver_pb2.Reply(message='Hello, %s!' % request.xwho)


if __name__ == '__main__':
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    receiver_pb2_grpc.add_ReceiverServicer_to_server(Receiver(), server)
    server.add_insecure_port('[::]:50051')
    server.start()
    print('server start...')
    try:
        while True:
            time.sleep(_ONE_DAY_IN_SECONDS)
    except KeyboardInterrupt:
        server.stop(0)

# client.py
# _*_ coding: utf-8 _*_

import grpc
import receiver_pb2
import receiver_pb2_grpc
from google.protobuf import struct_pb2


def run():
    channel = grpc.insecure_channel('localhost:50051')
    stub = receiver_pb2_grpc.ReceiverStub(channel)

    # 自定义struct结构
    struct = struct_pb2.Struct()
    struct['idfa'] = 'idfa1'
    struct['amount'] = 123

    response = stub.receive(receiver_pb2.Event(xwhat='install', appid='fuckgod', xwhen=123, xwho='jerry', xcontext=struct))
    print("client status: %s received: %s" % (response.status, response.message))


if __name__ == '__main__':
    run()
```

```go
go get -u -v google.golang.org/grpc
go get -u github.com/golang/protobuf/proto // golang protobuf 库
go get -u github.com/golang/protobuf/protoc-gen-go //protoc --go_out 工具
protoc -I. --go_out=plugins=grpc:. helloworld.proto

// server.go
package main

import (
    "log"
    "net"

    "golang.org/x/net/context"
    "google.golang.org/grpc"
    pb "google.golang.org/grpc/examples/helloworld/helloworld"
    "google.golang.org/grpc/reflection"
)

const (
    port = ":50051"
)

// server is used to implement helloworld.GreeterServer.
type server struct{}

// SayHello implements helloworld.GreeterServer
func (s *server) SayHello(ctx context.Context, in *pb.HelloRequest) (*pb.HelloReply, error) {
    return &pb.HelloReply{Message: "Hello " + in.Name}, nil
}

func main() {
    lis, err := net.Listen("tcp", port)
    if err != nil {
        log.Fatalf("failed to listen: %v", err)
    }
    s := grpc.NewServer()
    pb.RegisterGreeterServer(s, &server{})
    // Register reflection service on gRPC server.
    reflection.Register(s)
    if err := s.Serve(lis); err != nil {
        log.Fatalf("failed to serve: %v", err)
    }
}

// client.go
package main

import (
    "log"
    "os"
    "time"

    "golang.org/x/net/context"
    "google.golang.org/grpc"
    pb "google.golang.org/grpc/examples/helloworld/helloworld"
)

const (
    address     = "localhost:50051"
    defaultName = "world"
)

func main() {
    // Set up a connection to the server.
    conn, err := grpc.Dial(address, grpc.WithInsecure())
    if err != nil {
        log.Fatalf("did not connect: %v", err)
    }
    defer conn.Close()
    c := pb.NewGreeterClient(conn)

    // Contact the server and print out its response.
    name := defaultName
    if len(os.Args) > 1 {
        name = os.Args[1]
    }
    ctx, cancel := context.WithTimeout(context.Background(), time.Second)
    defer cancel()
    r, err := c.SayHello(ctx, &pb.HelloRequest{Name: name})
    if err != nil {
        log.Fatalf("could not greet: %v", err)
    }
    log.Printf("Greeting: %s", r.Message)
}
```

## 服务

```sh
# 查看所有的服务
grpc_cli ls localhost:50051
# 查看 Greeter 服务的详细信息
grpc_cli ls localhost:50051 helloworld.Greeter -l
# 查看 Greeter.SayHello 方法的详细信息
grpc_cli ls localhost:50051 helloworld.Greeter.SayHello -l
# 远程调用
grpc_cli call localhost:50051 SayHello "name: 'gRPC CLI'"

# 问题
Received an error when querying services endpoint.
Reflection request not implemented; is the ServerReflection service enabled?
```

## grpc-gateway

* 提供了很好地扩展 protobuf/gRPC，用代码生成代码的方向和蓝图。这也是 protobuf 这样的语言的魅力所在：它足够简单，可以很容易被解析，从而生成不同角度的工具

## 工具

* [Linkerd](https://kubernetes.io/blog/2018/11/07/grpc-load-balancing-on-kubernetes-without-tears/)
* [uw-labs/bloomrpc](https://github.com/uw-labs/bloomrpc):GUI Client for GRPC Services
* [grpc/grpc-web](https://github.com/grpc/grpc-web):gRPC for Web Clients <https://grpc.io>
* [improbable-eng/grpc-web](https://github.com/improbable-eng/grpc-web):gRPC Web implementation for Golang and TypeScript

## 参考

* [gRpc docs](https://grpc.io/docs/guides/)
* [grpc/grpc-java](https://github.com/grpc/grpc-java):The Java gRPC implementation. HTTP/2 based RPC <https://grpc.io>
* [examples](google.golang.org/grpc/examples )
