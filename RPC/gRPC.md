# [grpc/grpc](https://github.com/grpc/grpc)

The C based gRPC (C++, Node.js, Python, Ruby, Objective-C, PHP, C#)

* 一个高性能、通用的开源RPC框架
* 基于HTTP/2协议标准和Protobuf序列化协议开发，支持多种开发语言（Golang、Python、Java、C/C++等）
* gRPC 提供了一种简单的方法来定义服务，同时客户端可以充分利用 HTTP/2 stream 的特性，从而有助于节省带宽、降低 TCP 的连接次数、节省CPU的使用等。
* 服务端，实现了所定义的服务和可供远程调用的方法，运行一个gRPC server来处理客户端的请求
* 客户端可以像调用本地对象一样直接调用位于不同机器的服务端方法，可以非常方便的创建一些分布式的应用服务。
* gRPC使用protocol buffers作为接口描述语言（IDL）以及底层的信息交换格式，一般情况下推荐使用 proto3因为其能够支持更多的语言

## install

* 下载[Protocol Buffers v3.8.0](https://github.com/protocolbuffers/protobuf/releases)


```
./configure --prefix=your_pb_install_path

brew install protobuf
protoc --version

brew install grpc
```

## 概念

* service定义了一个server。其中的接口可以是四种类型
    - `rpc GetFeature(Point) returns (Feature) {}`：类似普通的函数调用，客户端发送请求Point到服务器，服务器返回相应Feature.
    - `rpc ListFeatures(Rectangle) returns (stream Feature) {}`：客户端发起一次请求，服务器端返回一个流式数据，比如一个数组中的逐个元素
    - `rpc RecordRoute(stream Point) returns (RouteSummary) {}`：客户端发起的请求是一个流式的数据，比如数组中的逐个元素，服务器返回一个相应
    - `rpc RouteChat(stream RouteNote) returns (stream RouteNote) {}`：客户端发起的请求是一个流式数据，比如数组中的逐个元素，二服务器返回的也是一个类似的数据结构


## 认证方式

* 基于SSL/TLS认证方式
* 远程调用认证方式
* 两种方式可以混合使用

## example

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

## 参考

* [gRpc docs](https://grpc.io/docs/guides/)
* [grpc/grpc-java](https://github.com/grpc/grpc-java):The Java gRPC implementation. HTTP/2 based RPC https://grpc.io
