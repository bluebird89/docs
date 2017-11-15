# Go

- [golang/go](https://github.com/golang/go):The Go programming language https://golang.org
- Docker

## Install

### 卸载旧版本

### linux

GOROOT must be set only when installing to a custom location.install

```
wget  https://redirector.gvt1.com/edgedl/go/go$VERSION.$OS-$ARCH.tar.gz
sudo tar -C /usr/local -xzf go$VERSION.$OS-$ARCH.tar.gz
export PATH=$PATH:/usr/local/go/bin // 默认安装路径`/usr/local/go`(c:\Go under Windows)添加到/etc/profile (for a system-wide installation) or $HOME/.profile

export GOROOT=$HOME/go1.X  // Installing to a custom location.install the Go tools to a different location. In this case you must set the GOROOT environment variable to point to the directory in which it was installed.
export PATH=$PATH:$GOROOT/bin
```

### Mac

* `brew install go`
* `go env` 查看配置环境
* 设置GOPATH ,GOBIN

```shell
// bash中配置.bash_profile中添加 在zsh配置`.zshrc`添加
GOROOT="/usr/local/Cellar/go/1.9.2/libexec"  // 已配置好的
export GOPATH=/usr/local/Cellar/go/1.9.2 // 默认配置
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

export GOPATH=$HOME/go   // 另一种做法配置到home下面
export PATH=$HOME/bin:$GOPATH/bin:$PATH
export GOPATH=/Users/henry/Workspace/go

export PATH=$PATH:/usr/local/go/bin  // 通过文件包安装

source .bash_profile // 使修改立刻生效
```

### 插件安装

go get 用来动态获取远程代码包的，目前支持的有BitBucket、GitHub、Google Code和Launchpad。这个命令在内部实际上分成了两步操作：第一步是下载源码包，第二步是执行go install。下载源码包的go工具会自动根据不同的域名调用不同的源码工具,参数说明：

-d 只下载不安装 
-f 只有在你包含了-u参数的时候才有效，不让-u去验证import中的每一个都已经获取了，这对于本地fork的包特别有用 
-fix 在获取源码之后先运行fix，然后再去做其他的事情 
-t 同时也下载需要为运行测试所需要的包 
-u 强制使用网络去更新包和它的依赖包 
-v 显示执行的命令 
```sh
go get github.com/yudai/gotty  // ok的

go get -u -v github.com/labstack/echo
package golang.org/x/crypto/acme/autocert: unrecognized import path "golang.org/x/crypto/acme/autocert" (https fetch: Get https://golang.org/x/crypto/acme/autocert?go-get=1: dial tcp 172.217.6.127:443: i/o timeout) // 仓库被屏蔽

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

### 工具

### sublime
* 安装gosublime插件
* 在GoSublime，再往下找到 Settings - Default修改`"env": { "GOPATH":"$HOME/go","PATH": "$HOME/bin:$GOPATH/bin:$PATH" },` `"shell": [“$zsh"],`

## 文档

* 离线文档：`godoc -http=:6060` 访问`http://localhost:6060/`
* 
## 学习

- [pathbox/learning-go](https://github.com/pathbox/learning-go):learning golang-Don't stop learning Golang https://github.com/pathbox/learning-go
- [iris-contrib/examples](https://github.com/iris-contrib/examples)This repository contains small and practical examples for the Iris Web Framework. https://iris-go.com

## 框架

- [go-macaron/macaron](https://github.com/go-macaron/macaron):Package macaron is a high productive and modular web framework in Go.
- [astaxie/beego](https://github.com/astaxie/beego):beego is an open-source, high-performance web framework for the Go programming language. http://beego.me

### [labstack/echo](https://github.com/labstack/echo)

High performance, minimalist Go web framework https://echo.labstack.com


## 扩展

- [zihuxinyu/youzan](https://github.com/zihuxinyu/youzan)有赞API的golang实现
- [grafana/grafana](https://github.com/grafana/grafana)The tool for beautiful monitoring and metric analytics & dashboards for Graphite, InfluxDB & Prometheus & More
- [syncthing/syncthing](https://github.com/syncthing/syncthing)Open Source Continuous File Synchronization http://forum.syncthing.net/
- [divan/gobenchui](https://github.com/divan/gobenchui):UI for overview of your Golang package benchmarks progress.

### [joewalnes/websocketd](https://github.com/joewalnes/websocketd)

Turn any program that uses STDIN/STDOUT into a WebSocket server. Like inetd, but for WebSockets. http://websocketd.com/

```sh
#!/bin/bash
# count.sh:
for ((COUNT = 1; COUNT <= 10; COUNT++)); do
  echo $COUNT
  sleep 1
done

chmod +x count.sh
./count.sh

websocketd --port=8080 ./count.sh // 建立server

# client side
<!DOCTYPE html>
<pre id="log"></pre>
<script>
  // helper function: log message to screen
  function log(msg) {
    document.getElementById('log').textContent += msg + '\n';
  }

  // setup websocket with callbacks
  var ws = new WebSocket('ws://localhost:8080/');
  ws.onopen = function() {
    log('CONNECT');
  };
  ws.onclose = function() {
    log('DISCONNECT');
  };
  ws.onmessage = function(event) {
    log('MESSAGE: ' + event.data);
  };
</script>
```
## 资源

- [avelino/awesome-go](https://github.com/avelino/awesome-go)A curated list of awesome Go frameworks, libraries and software https://awesome-go.com/
- [mailru/easyjson](https://github.com/mailru/easyjson):Fast JSON serializer for golang.

## 教程

* [roth1002/go-basic](https://github.com/roth1002/go-basic):The golang basic syntax example


<https://juejin.im/post/59c384fa5188257e9349707e>

<http://www.infoq.com/cn/articles/history-go-package-management>
