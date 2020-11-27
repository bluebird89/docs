# [micro/go-micro](https://github.com/micro/go-micro):A distributed systems development framework <https://go-micro.dev>

```sh
go run main.go --registry=etcd

micro --registry=etcd api --namespace='' --handler=rpc

# WEb dashboard
micro web # http://localhost:8082/

# 启动 API 网关
micro api --handler=api

curl -H 'Content-Type: application/json' \
    -d '{"service": "go.micro.srv.greeter", "method": "Greeter.Hello", "request": {"name": "学院君"}}' \
    http://localhost:8080/rpc

go run client.go

micro proxy go.micro.srv.greeter
curl \
-H 'Content-Type: application/json' \
-H 'Micro-Service: go.micro.srv.greeter' \
-H 'Micro-Endpoint: Greeter.Hello' \
-d '{"name": "学院君"}' \
http://localhost:8081

micro cli
micro list services
micro get service  go.micro.srv.greeter
micro status|health go.micro.srv.greeter
micro call go.micro.srv.greeter Greeter.Hello '{"name":"henry"}'
micro logs example-service

micro bot --inputs=slack --slack_token=SLACK_TOKEN
```

## 问题

* `etcd@v3.XXXX+incompatible\clientv3\balancer\resolver\endpoint\endpoint.go:114:78: undefined: resolver.BuildOption`：`go mod edit -require=google.golang.org/grpc@v1.26.0`　`go get -u -x google.golang.org/grpc@v1.26.0` `replace google.golang.org/grpc => google.golang.org/grpc v1.26.0` `go mod edit -replace google.golang.org/grpc@v1.29.1=google.golang.org/grpc@v1.26.0`
* `Account not issued by ''`:

## 工具

* [micro / micro](https://github.com/micro/micro):Micro is a cloud native development platform
