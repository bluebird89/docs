# Go

- Go
- Docker

## Install

- download:

  ```
    sudo wget  https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz
    sudo tar -C /usr/local -xzf go1.8.3.linux-amd64.tar.gz
  ```

- Mac:brew install go:设置GOPATH ,GOBIN fishshell设置GOPATH：

set -gx GOPATH /usr/local/Cellar/go/1.7.6

在bash中设置： vim .bash_profile

```
export GOPATH=/usr/local/Cellar/go/1.7.6
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN
```

使修改立刻生效:

source .bash_profile

- Environment variable

  ```
     export PATH=$PATH:/usr/local/go/bin
  ```

## Build&Run

```
go build hello.go
./hello

go run hello.go

<<:1 << 100 2^100
>>:64 >> 4  4
```

包别名 可见性

数据类型： 布尔bool 整型inter 字节型byte float complex type 自定义 b := 1 _ 忽略 strconv iota

<< >> 左右移位

自己动手写 想清楚

LABLE标签 goto break continue

slice reslice

## 学习

- [pathbox/learning-go](https://github.com/pathbox/learning-go):learning golang-Don't stop learning Golang https://github.com/pathbox/learning-go
- [iris-contrib/examples](https://github.com/iris-contrib/examples)This repository contains small and practical examples for the Iris Web Framework. https://iris-go.com

## 框架

- [go-macaron/macaron](https://github.com/go-macaron/macaron):Package macaron is a high productive and modular web framework in Go.
- [astaxie/beego](https://github.com/astaxie/beego):beego is an open-source, high-performance web framework for the Go programming language. http://beego.me

## 扩展

- [zihuxinyu/youzan](https://github.com/zihuxinyu/youzan)有赞API的golang实现
- [grafana/grafana](https://github.com/grafana/grafana)The tool for beautiful monitoring and metric analytics & dashboards for Graphite, InfluxDB & Prometheus & More
- [syncthing/syncthing](https://github.com/syncthing/syncthing)Open Source Continuous File Synchronization http://forum.syncthing.net/
<http://www.infoq.com/cn/articles/history-go-package-management>

- [avelino/awesome-go](https://github.com/avelino/awesome-go)A curated list of awesome Go frameworks, libraries and software https://awesome-go.com/

<https://juejin.im/post/59c384fa5188257e9349707e>


## 教程

* [roth1002/go-basic](https://github.com/roth1002/go-basic):The golang basic syntax example 
