# [micro/go-micro](https://github.com/micro/go-micro):A distributed systems development framework https://go-micro.dev

```sh
micro --registry=etcd api --namespace='' --handler=rpc
```


## [ micro / micro ](https://github.com/micro/micro):Micro is a cloud native development platform


```sh
micro --registry=etcd api --namespace=' ' --handler=rpc

micro web
```

## 问题

* `etcd@v3.XXXX+incompatible\clientv3\balancer\resolver\endpoint\endpoint.go:114:78: undefined: resolver.BuildOption`：`go mod edit -require=google.golang.org/grpc@v1.26.0`　`go get -u -x google.golang.org/grpc@v1.26.0` `replace google.golang.org/grpc => google.golang.org/grpc v1.26.0` `go mod edit -replace google.golang.org/grpc@v1.29.1=google.golang.org/grpc@v1.26.0`
* `Account not issued by ''`:
