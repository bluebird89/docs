# Go


## Install

Go 编译器支持交叉编译，也就是说你可以在一台机器上构建运行在具有不同操作系统和处理器架构上运行的应用程序，也就是说编写源代码的机器可以和目标机器有完全不同的特性

* 设置环境变量
  - GOROOT：(std lib)golang安装路径
  - $GOARCH 表示目标机器的处理器架构，它的值可以是 386、amd64 或 arm。
  - $GOOS 表示目标机器的操作系统，它的值可以是 darwin、freebsd、linux 或 windows。
  - $GOBIN 表示编译器和链接器的安装位置，默认是 $GOROOT/bin
  - $GOPATH：(external libs)项目路径。go命令常常需要用到的，如go run，go install， go get等。允许设置多个路径，和各个系统环境多路径设置一样，windows用“;”，linux（mac）用“:”分隔。GOPATH是作为编译后二进制的存放目的地和import包时的搜索路径。不要把GOPATH设置成go的安装路径,可以自己在用户目录下面创建一个目录, 如gopath.$GOPATH 默认采用和 $GOROOT 一样的值，但从 Go 1.1 版本开始，你必须修改为其它路径。它可以包含多个包含 Go 语言源码文件、包文件和可执行文件的路径
    + bin目录主要存放可执行文件：需要把GOPATH中的可执行目录也配置到环境变量中, 否则你自行下载的第三方go工具就无法使用了
    + pkg目录存放编译好的库文件, 主要是*.a文件
    + src目录下主要存放go的源文件

```sh
### linux
wget  https://redirector.gvt1.com/edgedl/go/go$VERSION.$OS-$ARCH.tar.gz
sudo tar -C /usr/local -xzf go$VERSION.$OS-$ARCH.tar.gz
export PATH=$PATH:/usr/local/go/bin # 默认安装路径 /usr/local/go (c:\Go under Windows)添加到/etc/profile (for a system-wide installation) or $HOME/.profile

export GOROOT=/usr/local/go # Installing to a custom location.install the Go tools to a different location. In this case you must set the GOROOT environment variable to point to the directory in which it was installed.
export GOPATH=$HOME/go #默认安装包的路径
export PATH=$PATH:$GOPATH/bin

### Mac
brew install golang

export GOPATH=$HOME/go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin:$GOROOT/bin

mkdir -p $GOPATH $GOPATH/src $GOPATH/pkg $GOPATH/bin

source .bash_profile # 使修改立刻生效

go env
```

### 插件安装

go get 用来动态获取远程代码包的，fetch libraries from remote and put them in your $GOPATH.目前支持的有BitBucket、GitHub、Google Code和Launchpad。这个命令在内部实际上分成了两步操作：第一步是下载源码包，第二步是执行go install。下载源码包的go工具会自动根据不同的域名调用不同的源码工具,参数说明：

-d 只下载不安装
-f 只有在你包含了-u参数的时候才有效，不让-u去验证import中的每一个都已经获取了，这对于本地fork的包特别有用
-fix 在获取源码之后先运行fix，然后再去做其他的事情
-t 同时也下载需要为运行测试所需要的包
-u 强制使用网络去更新包和它的依赖包:存在unrecognized import path "golang.org/x问题，需要添加代理
-v 显示执行的命令

```go
go get github.com/yudai/gotty  // ok的

go get -u -v github.com/labstack/echo
// unrecognized import path "golang.org/x/crypto/acme/autocert" (https fetch: Get https://golang.org/x/crypto/acme/autocert?go-get=1: dial tcp 172.217.6.127:443: i/o timeout) // bin配置错误

gofmt -w yourcode.go // Format your code
godoc fmt                // documentation for package fmt
godoc fmt Printf         // documentation for fmt.Printf
godoc -src fmt // fmt package interface in Go source form
```

## Build&Run

```go
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

## 学习

- [pathbox/learning-go](https://github.com/pathbox/learning-go):learning golang-Don't stop learning Golang https://github.com/pathbox/learning-go
- [iris-contrib/examples](https://github.com/iris-contrib/examples)This repository contains small and practical examples for the Iris Web Framework. https://iris-go.com
- [https://songjiayang.gitbooks.io](https://songjiayang.gitbooks.io)
- [Go语言入门](https://www.yiibai.com/go/go_start.html)

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
- [deanishe/awgo](https://github.com/deanishe/awgo):Go library for Alfred 3 workflows

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

## 工具

* [bettercap/bettercap](https://github.com/bettercap/bettercap):The state of the art network attack and monitoring framework. https://www.bettercap.org/
* [google/gxui](https://github.com/google/gxui):An experimental Go cross platform UI library.
* [shiyanhui/dht](https://github.com/shiyanhui/dht):BitTorrent DHT Protocol && DHT Spider. http://bthub.io

## 教程

* [roth1002/go-basic](https://github.com/roth1002/go-basic):The golang basic syntax example
* [chai2010/advanced-go-programming-book](https://github.com/chai2010/advanced-go-programming-book):📚 《Go语言高级编程》开源免费图书(开发中...)https://github.com/chai2010/advanced-go-programming-book

## 参考

- [avelino/awesome-go](https://github.com/avelino/awesome-go)A curated list of awesome Go frameworks, libraries and software https://awesome-go.com/
- [mailru/easyjson](https://github.com/mailru/easyjson):Fast JSON serializer for golang.
- [golang/go](https://github.com/golang/go):The Go programming language https://golang.org
- [gocn/knowledge](https://github.com/gocn/knowledge):Go社区的知识图谱，Knowledge Graph
<https://juejin.im/post/59c384fa5188257e9349707e>
<http://www.infoq.com/cn/articles/history-go-package-management>
