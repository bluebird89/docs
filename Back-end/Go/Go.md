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

## 扩展

- [zihuxinyu/youzan](https://github.com/zihuxinyu/youzan)有赞API的golang实现

<http://www.infoq.com/cn/articles/history-go-package-management>
- [avelino/awesome-go](https://github.com/avelino/awesome-go)

https://juejin.im/post/59c384fa5188257e9349707e
