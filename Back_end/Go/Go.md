# [golang/go](https://github.com/golang/go)

The Go programming language https://golang.org

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

mkdir -p ~/projects/{bin,pkg,src}
export GOROOT=/usr/local/go # Installing to a custom location.install the Go tools to a different location. In this case you must set the GOROOT environment variable to point to the directory in which it was installed.
export GOPATH=$HOME/projects #默认安装包的路径
export GOBIN="$HOME/projects/bin"
export PATH=$PATH:$GOPATH/bin
source ~/.zshrc

### Mac
brew install golang

export GOPATH=$HOME/go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin:$GOROOT/bin

mkdir -p $GOPATH $GOPATH/src $GOPATH/pkg $GOPATH/bin

source .bash_profile # 使修改立刻生效

go env
```

### 插件

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
vi ~/projects/src/hello.go
go install $GOPATH/hello.go
$GOBIN/hello

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

### sublime

* 安装gosublime插件
* 在GoSublime，再往下找到 Settings - Default修改`"env": { "GOPATH":"$HOME/go","PATH": "$HOME/bin:$GOPATH/bin:$PATH" },` `"shell": [“$zsh"],`

## 文档

* 离线文档：`godoc -http=:6060` 访问`http://localhost:6060/`

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

## 配置

* [kelseyhightower/envconfig](https://github.com/kelseyhightower/envconfig):Golang library for managing configuration data from environment variables

## 包管理

* [kardianos/govendor](https://github.com/kardianos/govendor):Go vendor tool that works with the standard vendor file.
* [Go Packages](https://godoc.org/)
* [moovweb/gvm](https://github.com/moovweb/gvm):Go Version Manager http://github.com/moovweb/gvm

## UI

* [andlabs/ui](https://github.com/andlabs/ui):Platform-native GUI library for Go.

## 框架

- [go-macaron/macaron](https://github.com/go-macaron/macaron):Package macaron is a high productive and modular web framework in Go.
* [gocolly/colly](https://github.com/gocolly/colly):Elegant Scraper and Crawler Framework for Golang http://go-colly.org/

## desktop apps

* [zserge/lorca](https://github.com/zserge/lorca):Build cross-platform modern desktop apps in Go + HTML5

## Cli

* [spf13/cobra](https://github.com/spf13/cobra):A Commander for modern Go CLI interactions

## 语法检测

* [mgechev/revive](https://github.com/mgechev/revive):🔥 ~6x faster, stricter, configurable, extensible, and beautiful drop-in replacement for golint. https://revive.run

## HTTP

* [valyala/fasthttp](https://github.com/valyala/fasthttp):Fast HTTP package for Go. Tuned for high performance. Zero memory allocations in hot paths. Up to 10x faster than net/http

## ORM

* [go-xorm/xorm](https://github.com/go-xorm/xorm):Simple and Powerful ORM for Go, support mysql,postgres,tidb,sqlite3,mssql,oracle http://xorm.io
* [gomods/athens](https://github.com/gomods/athens):A Go module datastore and proxy https://docs.gomods.io

## 路由

* [gorilla/mux](https://github.com/gorilla/mux):A powerful URL router and dispatcher for golang. http://www.gorillatoolkit.org/pkg/mux

## error

* [pkg/errors](https://github.com/pkg/errors):Simple error handling primitives https://godoc.org/github.com/pkg/errors

## 微服务

* [go-kit/kit](https://github.com/go-kit/kit):A standard library for microservices. https://gokit.io

## 测试

* [stretchr/testify](https://github.com/stretchr/testify):A toolkit with common assertions and mocks that plays nicely with the standard library
* [codegangsta/gin](https://github.com/codegangsta/gin):Live reload utility for Go web servers

## mock

* [golang/mock](https://github.com/golang/mock):GoMock is a mocking framework for the Go programming language.

## 模版

* [flosch/pongo2](https://github.com/flosch/pongo2):Django-syntax like template-engine for Go 

## logger

* [sirupsen/logrus](https://github.com/sirupsen/logrus):Structured, pluggable logging for Go.

## 数据库

* [dgraph-io/badger](https://github.com/dgraph-io/badger):Fast key-value DB in Go. https://open.dgraph.io/post/badger/
* [DATA-DOG/go-sqlmock](https://github.com/DATA-DOG/go-sqlmock):Sql mock driver for golang to test database interactions
* [mongodb/mongo-go-driver](https://github.com/mongodb/mongo-go-driver):The Go driver for MongoDB
* [upper/db](https://github.com/upper/db):Productive data access layer for Go. https://upper.io/db.v3
* [jmoiron/sqlx](https://github.com/jmoiron/sqlx):general purpose extensions to golang's database/sql http://jmoiron.github.io/sqlx/
* [globalsign/mgo](https://github.com/globalsign/mgo):The MongoDB driver for Go

## Http

* [xtaci/kcp-go](https://github.com/xtaci/kcp-go):A Production-Grade Reliable-UDP Library for golang

## 问题

```
package golang.org/x/crypto/acme/autocert: unrecognized import path "golang.org/x/crypto/acme/autocert" (https fetch: Get https://golang.org/x/crypto/acme/autocert?go-get=1: dial tcp 216.239.37.1:443: i/o timeout)

git clone git@github.com:golang/crypto.git $(GOROOT)/src/golang.org/x/crypto
```

## 项目

* [hajimehoshi/ebiten](https://github.com/hajimehoshi/ebiten):A dead simple 2D game library in Go https://hajimehoshi.github.io/ebiten/

## 教程

* [roth1002/go-basic](https://github.com/roth1002/go-basic):The golang basic syntax example
* [chai2010/advanced-go-programming-book](https://github.com/chai2010/advanced-go-programming-book):📚 《Go语言高级编程》开源免费图书(开发中...)https://github.com/chai2010/advanced-go-programming-book
* [astaxie/build-web-application-with-golang](https://github.com/astaxie/build-web-application-with-golang):A golang ebook intro how to build a web with golang
* [pathbox/learning-go](https://github.com/pathbox/learning-go):learning golang-Don't stop learning Golang https://github.com/pathbox/learning-go
- [iris-contrib/examples](https://github.com/iris-contrib/examples)This repository contains small and practical examples for the Iris Web Framework. https://iris-go.com
- [https://songjiayang.gitbooks.io](https://songjiayang.gitbooks.io)
- [Go语言入门](https://www.yiibai.com/go/go_start.html)
- [harlow/go-micro-services](https://github.com/harlow/go-micro-services):HTTP up front, Protobufs in the rear
- [astaxie/gopkg](https://github.com/astaxie/gopkg):example for the go pkg's function
* [astaxie/go-best-practice](https://github.com/astaxie/go-best-practice):Trying to complete over 100 projects in various categories in golang.
* [Unknwon/go-fundamental-programming](https://github.com/Unknwon/go-fundamental-programming):《Go 编程基础》是一套针对 Google 出品的 Go 语言的视频语音教程，主要面向新手级别的学习者。

## 扩展

- [zihuxinyu/youzan](https://github.com/zihuxinyu/youzan)有赞API的golang实现
- [grafana/grafana](https://github.com/grafana/grafana)The tool for beautiful monitoring and metric analytics & dashboards for Graphite, InfluxDB & Prometheus & More
- [syncthing/syncthing](https://github.com/syncthing/syncthing)Open Source Continuous File Synchronization http://forum.syncthing.net/
- [divan/gobenchui](https://github.com/divan/gobenchui):UI for overview of your Golang package benchmarks progress.
* [segmentio/kafka-go](https://github.com/segmentio/kafka-go):Kafka library in Go
* [google/go-github](https://github.com/google/go-github):Go library for accessing the GitHub API

## 工具

* [bettercap/bettercap](https://github.com/bettercap/bettercap):The state of the art network attack and monitoring framework. https://www.bettercap.org/
* [google/gxui](https://github.com/google/gxui):An experimental Go cross platform UI library.
* [shiyanhui/dht](https://github.com/shiyanhui/dht):BitTorrent DHT Protocol && DHT Spider. http://bthub.io
* [variadico/noti](https://github.com/variadico/noti):Monitor a process and trigger a notification.
* [fvbock/endless](https://github.com/fvbock/endless):Zero downtime restarts for go servers (Drop in replacement for http.ListenAndServe)
* [robfig/cron](https://github.com/robfig/cron):a cron library for go
* [golang/dep](https://github.com/golang/dep):Go dependency management tool https://golang.github.io/dep/
* [gorilla/mux](https://github.com/gorilla/mux):A powerful URL router and dispatcher for golang. http://www.gorillatoolkit.org/pkg/mux
* [murlokswarm/app](https://github.com/murlokswarm/app):Package to build GUI apps with Go, HTML and CSS.
* [justinas/alice](https://github.com/justinas/alice):Painless middleware chaining for Go https://godoc.org/github.com/justinas/alice
* [spf13/viper](https://github.com/spf13/viper):Go configuration with fangs
* [derekparker/delve](https://github.com/derekparker/delve):Delve is a debugger for the Go programming language.
* [sirupsen/logrus](https://github.com/sirupsen/logrus):Structured, pluggable logging for Go.
* [goreleaser/goreleaser](https://github.com/goreleaser/goreleaser)：Deliver Go binaries as fast and easily as possible https://goreleaser.com
* [hashicorp/go-plugin](https://github.com/hashicorp/go-plugin):Golang plugin system over RPC.
* [dominikh/go-tools](https://github.com/dominikh/go-tools):A collection of tools and libraries for working with Go code, including linters and static analysis https://staticcheck.iop
* [dgrijalva/jwt-go](https://github.com/dgrijalva/jwt-go):Golang implementation of JSON Web Tokens (JWT)
* [gomodule/redigo](https://github.com/gomodule/redigo):Go client for Redis
* [golang-standards/project-layout](https://github.com/golang-standards/project-layout):Standard Go Project Layout
* [go-yaml/yaml](https://github.com/go-yaml/yaml):YAML support for the Go language.
* [fsnotify/fsnotify](https://github.com/fsnotify/fsnotify):Cross-platform file system notifications for Go. https://fsnotify.org
* [deckarep/golang-set](https://github.com/deckarep/golang-set)：A simple set type for the Go language. Also used in Docker, Kubernetes, Ethereum.
* [fvbock/endless](https://github.com/fvbock/endless):Zero downtime restarts for go servers (Drop in replacement for http.ListenAndServe)
* [gonum/gonum](https://github.com/gonum/gonum):Gonum is a set of numeric libraries for the Go programming language. It contains libraries for matrices, statistics, optimization, and more https://www.gonum.org/
* [bitly/go-simplejson](https://github.com/bitly/go-simplejson):a Go package to interact with arbitrary JSON
* [golang/crypto](https://github.com/golang/crypto):Go supplementary cryptography libraries https://godoc.org/golang.org/x/crypto
* [takama/daemon](https://github.com/takama/daemon):A daemon package for use with Go (golang) services with no dependencies
* [golang/protobuf](https://github.com/golang/protobuf):Go support for Google's protocol buffers
* [TrueFurby/go-callvis](https://github.com/TrueFurby/go-callvis):Visualize call graph of a Go program using dot format. https://truefurby.github.io/go-callvis
* [dgryski/go-perfbook](https://github.com/dgryski/go-perfbook):Thoughts on Go performance optimization
* [Shopify/sarama](https://github.com/Shopify/sarama):Sarama is a Go library for Apache Kafka 0.8, and up. https://shopify.github.io/sarama
* [alecthomas/participle](https://github.com/alecthomas/participle):A parser library for Go
* [zserge/lorca](https://github.com/zserge/lorca):Build cross-platform modern desktop apps in Go + HTML5

## 参考

- [avelino/awesome-go](https://github.com/avelino/awesome-go)A curated list of awesome Go frameworks, libraries and software https://awesome-go.com/
- [mailru/easyjson](https://github.com/mailru/easyjson):Fast JSON serializer for golang.
- [gocn/knowledge](https://github.com/gocn/knowledge):Go社区的知识图谱，Knowledge Graph
- [GO语言中文网](https://studygolang.com/)
- [changkun/go-under-the-hood](https://github.com/changkun/go-under-the-hood):Go 源码研究 (1.11.1, WIP)
* [emirpasic/gods](https://github.com/emirpasic/gods):GoDS (Go Data Structures). Containers (Sets, Lists, Stacks, Maps, Trees), Sets (HashSet, TreeSet, LinkedHashSet), Lists (ArrayList, SinglyLinkedList, DoublyLinkedList), Stacks (LinkedListStack, ArrayStack), Maps (HashMap, TreeMap, HashBidiMap, TreeBidiMap, LinkedHashMap), Trees (RedBlackTree, AVLTree, BTree, BinaryHeap), Comparators, Iterators, …
* [EDDYCJY/blog](https://github.com/EDDYCJY/blog):煎鱼的博客，啊。

## 图书

* [chai2010/advanced-go-programming-book](https://github.com/chai2010/advanced-go-programming-book):📚 《Go语言高级编程》开源图书，涵盖CGO、Go汇编语言、RPC实现、Protobuf插件实现、Web框架实现、分布式系统等高阶主题 https://legacy.gitbook.com/book/chai2010/advanced-go-programming-book/details
* [Unknwon/the-way-to-go_ZH_CN](https://github.com/Unknwon/the-way-to-go_ZH_CN):《The Way to Go》中文译本，中文正式名《Go 入门指南》
<https://juejin.im/post/59c384fa5188257e9349707e>
<http://www.infoq.com/cn/articles/history-go-package-management>
