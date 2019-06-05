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

## 协程

多线程或多进程是并行的基本条件，但单线程也可以用协程(coroutine)做到并发。简单将Goroutine归纳为协程并不合适，因为它运行时会创建多个线程来执行并发任务，且任务单元可被调度到其它线程执行。这更像是多线程和协程的结合体，能最大限度提升执行效率，发挥多核处理器能力。

```go
// Go编写一个并发编程程序很简单，只需要在函数之前使用一个Go关键字就可以实现并发编程。
func main() {
  go func(){
        fmt.Println("Hello,World!")
    }()
}
```

### sublime

* 安装gosublime插件
* 在GoSublime，再往下找到 Settings - Default修改`"env": { "GOPATH":"$HOME/go","PATH": "$HOME/bin:$GOPATH/bin:$PATH" },` `"shell": [“$zsh"],`

## 文档


* 离线文档
  - `go get golang.org/x/tools/cmd/godoc`
  - `godoc -http=:6060` 访问`http://localhost:6060/`
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

## 编程的利与弊

* 利
  - Go 语言速度非常快：Go 语言是一门非常快速的编程语言。因为 Go 语言是编译成机器码的，因此，它的表现自然会优于那些解释性或具有虚拟运行时的编程语言。Go 程序的编译速度也非常快，并且生成的二进制文件非常小。我们的 API 在短短几秒钟内就编译完毕，生成的可执行文件区区只有 11.5MB 这么小。
  - 易于掌握 与其他语言相比，Go 语言的语法很简单，很容易掌握。你完全可以把 Go 语言的大部分语法记在脑子里，这意味着你并不需要花很多时间来查找东西。Go 语言也非常干净易读。非 Go 语言的程序员，尤其是那些习惯于 C 风格语法的程序员，就可以阅读 Go 程序代码，并且能够理解发生什么事。
  - 静态类型定义语言 Go 语言是一种强大的静态类型定义语言。有基本类型，如 int、byte 和 string。也有结构类型。与任何强类型语言一样，类型系统允许编译器帮助捕获整个类的错误。Go 语言还具有内置的列表和映射类型，而且它们也易于使用。
  - 有编译器
  - 接口类型 Go 语言有接口类型，任何结构都可以简单地通过实现接口的方法来满足接口。这允许你解耦代码中的依赖项。然后，你可以在测试中模拟你的依赖项。通过使用接口，你可以编写更加模块化的可测试代码。Go 语言还具有头等函数，这使得开发人员以更实用的方式编写代码成为可能。
  - 标准库 Go 语言有一个相当不错的标准库。它提供了方便的内置函数，用于处理基本类型。有些包可以让你轻松构建一个 Web 服务器、处理 I/O、使用加密技术以及操作原始字节。标准库提供的 JSON 序列化和反序列化非常简单。通过使用“tags”，你可以在 struct 字段旁边指定 JSON 字段名。
  - 测试支持 测试支持内置在标准库中，不需要额外的依赖。如果你有个名为 thing.go 的文件，请在另一个名为 thing_test.go 的文件中编写测试，并运行“go test”。Go 就将快速执行这些测试。
  - 静态分析工具 Go 语言的静态分析工具众多且强大。一种特别的工具是 gofmt，它根据 Go 的建议风格对代码进行格式化。这可以规范项目的许多意见，让团队奖经理集中在代码所做的工作上。我们对每个构建运行 gofmt、golint 和 vet，如果发现任何警告的话，则构建将会失败。
  - 垃圾收集 在设计 Go 语言时，有意将内存管理设计得比 C 和 C++ 更容易。动态分配的对象是垃圾收集。Go 语言使指针的使用更加安全，因为它不允许指针运算。还提供了使用值类型的选项。
  - 更容易的并发模型 虽然并发编程从来就不是一件易事，但 Go 语言在并发编程要比其他语言更容易。创建一个名为“goroutine”的轻量级线程，并通过“channel”与它进行通信几乎是非常简单的事情，至于更为复杂的模型，也是有可能能够实现的。
* 弊
  - 没有泛型 首先，这个问题就像房间里的大象一样，是显而易见而又被忽略的事实。Go 语言没有泛型。对于来自使用 Java 这样的语言的开发者来说，要转向 Go 语言，这是一个需要克服的巨大障碍。这意味着代码的重用级别降低了。虽然 Go 语言有头等函数，但如果编写“map”、“reduce”和“filter”等函数，将这些函数设计为对一种类型的集合进行操作，就不能将这些函数重用于其他不同的类型集合。要解决这一问题有很多方法，但都最终都要涉及到编写更多的代码，如此一来，生产力和可维护性就降低了。
  - 接口是隐式的 虽然有接口这一点很好，但是结构却是隐式地而非显式地实现接口。这点被称为是 Go 语言的优势之一，但我们发现，很难从结构中看出它是否实现了接口。你只能通过尝试编译程序才能真正了解。如果程序很小，这当然没有什么问题。但如果这个程序是中大型规模，麻烦就大了。
  - 库支持不佳 Go 语言的库支持参差不齐。我们的 API 与 Contentful 集成，但后者并没有官方支持的 Go SDK。这意味着我们必须编写（并维护！）大量代码来请求和解析 Contentful 中的数据。我们还必须依赖第三方的 Elasticsearch 库。由厂商提供的 Go SDK 并不像他们的 Java、Ruby 或 JavaScript 同类产品那样受欢迎。
  - 社区沟通很难
    + Go 社区可能不会接受建议。在 golint 的 GitHub 存储库中考虑这个问题：https://github.com/golang/lint/issues/65 ，有用户请求 golint 在发现警告时，能够使构建失败（这就是我们在项目中所做的事情）。维护者立即否定了这一想法。但是，由于有太多的人就这个问题发表了评论，一年后，维护者最终不得不增加了所请求的特性。
    + Go 社区似乎也不喜欢 Web 框架。虽然 Go 语言的 HTTP 库涵盖了很多方面，但它并不支持路径参数、输入检查和验证，也不支持 Web 应用程序中常见的横切关注点。Ruby 开发人员有 Rails，Java 开发人员有 Spring MVC，Python 开发者有 Django。但许多 Go 开发人员选择了避免使用框架。然而现实是，并非没有框架，恰恰相反有很多。但是，一旦你开始将某个框架用于某个项目，要想避免被遗弃的命运几乎是不可能的。
  - 分裂的依赖关系管理：Go 语言没有一个稳定的、正式的包管理器。经过多年的社区乞求，Go 项目最近才发布 godep。在此之前，已经有许多工具填补了这个空白。我们在项目中使用了非常强大的 govendor，但这意味着社区是分裂的，对刚接触 Go 语言的开发人员来说，这可能是非常令人困惑的。此外，几乎所有的包管理器都由 Git 存储库提供支持，Git 存储库的历史可能随时会发生更改。将其与 Maven Central 相比，后者永远不会删除或更改项目所依赖的库。
* 决定是否使用 Go 语言
  - 需要考虑一下机器的情况。你发送和接受字节时。你管理数千个并发进程时。你也有可能正在编写操作系统、容器系统或区块链节点。在这些情况下，很可能你不会关心泛型。因为你忙着从芯片榨取每纳秒的性能。
  - 很多时候，你需要考虑人类。你需要处理的业务领域数据：客户、员工、产品、订单。你需要编写对这些域实体进行操作的业务逻辑，并且需要多年来维护此业务逻辑。并且需要处理不断变化的需求，还要做的越快越好。对于这些情况，开发人员的经验很重要。
  - Go 语言是一种编程语言，它更重视的是机器时间而不是人类时间。有时候，你的领域中，机器，或者程序性能是最关键的。在这些情况下，Go 可以成为一个很好的 C 或 C++ 替代品。但是，当你编写一个典型的 n 层应用程序时，性能瓶颈通常会出现在数据库中，更重要的是，你将如何对数据建模。
  - 处理的是字节，那么 Go 语言可能是一个不错的选择。 处理的是数据，那么 Go 语言可能不是一个好的选择

## 配置

* [kelseyhightower/envconfig](https://github.com/kelseyhightower/envconfig):Golang library for managing configuration data from environment variables

## 包管理

* [kardianos/govendor](https://github.com/kardianos/govendor):Go vendor tool that works with the standard vendor file.
* [Go Packages](https://godoc.org/)
* [moovweb/gvm](https://github.com/moovweb/gvm):Go Version Manager http://github.com/moovweb/gvm

## UI

* [andlabs/ui](https://github.com/andlabs/ui):Platform-native GUI library for Go.

## 扩展

* 框架
  + [go-macaron/macaron](https://github.com/go-macaron/macaron):Package macaron is a high productive and modular web framework in Go.
  - [gocolly/colly](https://github.com/gocolly/colly):Elegant Scraper and Crawler Framework for Golang http://go-colly.org/
* desktop apps
  - [zserge/lorca](https://github.com/zserge/lorca):Build cross-platform modern desktop apps in Go + HTML5
* Cli
  - [spf13/cobra](https://github.com/spf13/cobra):A Commander for modern Go CLI interactions
* 语法检测
  - [mgechev/revive](https://github.com/mgechev/revive):🔥 ~6x faster, stricter, configurable, extensible, and beautiful drop-in replacement for golint. https://revive.run
* ORM
  - [go-xorm/xorm](https://github.com/go-xorm/xorm):Simple and Powerful ORM for Go, support mysql,postgres,tidb,sqlite3,mssql,oracle http://xorm.io
  - [gomods/athens](https://github.com/gomods/athens):A Go module datastore and proxy https://docs.gomods.io
  - [jinzhu/gorm](https://github.com/jinzhu/gorm):The fantastic ORM library for Golang, aims to be developer friendly https://gorm.io
* 路由
  - [gorilla/mux](https://github.com/gorilla/mux):A powerful URL router and dispatcher for golang. http://www.gorillatoolkit.org/pkg/mux
* error
  - [pkg/errors](https://github.com/pkg/errors):Simple error handling primitives https://godoc.org/github.com/pkg/errors
* 微服务
  - [go-kit/kit](https://github.com/go-kit/kit):A standard library for microservices. https://gokit.io
* 测试
  - [stretchr/testify](https://github.com/stretchr/testify):A toolkit with common assertions and mocks that plays nicely with the standard library
  - [codegangsta/gin](https://github.com/codegangsta/gin):Live reload utility for Go web servers
  - [360EntSecGroup-Skylar/goreporter](https://github.com/360EntSecGroup-Skylar/goreporter):A Golang tool that does static analysis, unit testing, code review and generate code quality report.
* mock
  - [golang/mock](https://github.com/golang/mock):GoMock is a mocking framework for the Go programming language.
* 模版
  - [flosch/pongo2](https://github.com/flosch/pongo2):Django-syntax like template-engine for Go
* logger
  - [sirupsen/logrus](https://github.com/sirupsen/logrus):Structured, pluggable logging for Go.
* 缓存
  - [patrickmn/go-cache](https://github.com/patrickmn/go-cache):An in-memory key:value store/cache (similar to Memcached) library for Go, suitable for single-machine applications. https://patrickmn.com/projects/go-cache/
* 数据库
  - [dgraph-io/badger](https://github.com/dgraph-io/badger):Fast key-value DB in Go. https://open.dgraph.io/post/badger/
  - [DATA-DOG/go-sqlmock](https://github.com/DATA-DOG/go-sqlmock):Sql mock driver for golang to test database interactions
  - [mongodb/mongo-go-driver](https://github.com/mongodb/mongo-go-driver):The Go driver for MongoDB
  - [upper/db](https://github.com/upper/db):Productive data access layer for Go. https://upper.io/db.v3
  - [jmoiron/sqlx](https://github.com/jmoiron/sqlx):general purpose extensions to golang's database/sql http://jmoiron.github.io/sqlx/
  - [globalsign/mgo](https://github.com/globalsign/mgo):The MongoDB driver for Go
* Http
  - [xtaci/kcp-go](https://github.com/xtaci/kcp-go):A Production-Grade Reliable-UDP Library for golang
  * [valyala/fasthttp](https://github.com/valyala/fasthttp):Fast HTTP package for Go. Tuned for high performance. Zero memory allocations in hot paths. Up to 10x faster than net/http
* excel
  - [360EntSecGroup-Skylar/excelizes](https://github.com/360EntSecGroup-Skylar/excelize):Golang library for reading and writing Microsoft Excel™ (XLSX) files.
* event-loop
  - [tidwall/evio](https://github.com/tidwall/evio):Fast event-loop networking for Go
* mobile
  - [golang/mobile](https://github.com/golang/mobile):[mirror] Go on Mobile https://godoc.org/golang.org/x/mobile
* redis
  * [gomodule/redigo](https://github.com/gomodule/redigo):Go client for Redis
  * [go-redis/redis](https://github.com/go-redis/redis):Type-safe Redis client for Golang
* UI
  * [google/gxui](https://github.com/google/gxui):An experimental Go cross platform UI library.
* WEB
  - [go-martini/martini](https://github.com/go-martini/martini):Classy web framework for Go http://martini.codegangsta.io
* numeric
  * [gonum/gonum](https://github.com/gonum/gonum):Gonum is a set of numeric libraries for the Go programming language. It contains libraries for matrices, statistics, optimization, and more https://www.gonum.org/
* compiler
  - [aykevl/tinygo](https://github.com/aykevl/tinygo):Go compiler for small devices, based on LLVM.
* transfer
  - [divan/txqr](https://github.com/divan/txqr):Transfer data via animated QR codes
* 安全
  - [OWASP/Go-SCP](https://github.com/OWASP/Go-SCP):Go programming language secure coding practices guide
  - [Checkmarx/Go-SCP](https://github.com/Checkmarx/Go-SCP):Go programming language secure coding practices guide

## 问题

```
package golang.org/x/crypto/acme/autocert: unrecognized import path "golang.org/x/crypto/acme/autocert" (https fetch: Get https://golang.org/x/crypto/acme/autocert?go-get=1: dial tcp 216.239.37.1:443: i/o timeout)

git clone git@github.com:golang/crypto.git $(GOROOT)/src/golang.org/x/crypto
```

## 编辑器

* [visualfc/liteide](https://github.com/visualfc/liteide)：LiteIDE is a simple, open source, cross-platform Go IDE.

## 项目

* [hajimehoshi/ebiten](https://github.com/hajimehoshi/ebiten):A dead simple 2D game library in Go https://hajimehoshi.github.io/ebiten/

## 扩展

- [zihuxinyu/youzan](https://github.com/zihuxinyu/youzan)有赞API的golang实现
- [grafana/grafana](https://github.com/grafana/grafana)The tool for beautiful monitoring and metric analytics & dashboards for Graphite, InfluxDB & Prometheus & More
- [syncthing/syncthing](https://github.com/syncthing/syncthing)Open Source Continuous File Synchronization http://forum.syncthing.net/
- [divan/gobenchui](https://github.com/divan/gobenchui):UI for overview of your Golang package benchmarks progress.
* [segmentio/kafka-go](https://github.com/segmentio/kafka-go):Kafka library in Go
* [google/go-github](https://github.com/google/go-github):Go library for accessing the GitHub API

## 代码规范

* [Practical Go: Real world advice for writing maintainable Go programs](https://dave.cheney.net/practical-go/presentations/qcon-china.html)

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

## 工具

* [bettercap/bettercap](https://github.com/bettercap/bettercap):The state of the art network attack and monitoring framework. https://www.bettercap.org/
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
* [golang-standards/project-layout](https://github.com/golang-standards/project-layout):Standard Go Project Layout
* [go-yaml/yaml](https://github.com/go-yaml/yaml):YAML support for the Go language.
* [fsnotify/fsnotify](https://github.com/fsnotify/fsnotify):Cross-platform file system notifications for Go. https://fsnotify.org
* [deckarep/golang-set](https://github.com/deckarep/golang-set)：A simple set type for the Go language. Also used in Docker, Kubernetes, Ethereum.
* [fvbock/endless](https://github.com/fvbock/endless):Zero downtime restarts for go servers (Drop in replacement for http.ListenAndServe)
* [bitly/go-simplejson](https://github.com/bitly/go-simplejson):a Go package to interact with arbitrary JSON
* [golang/crypto](https://github.com/golang/crypto):Go supplementary cryptography libraries https://godoc.org/golang.org/x/crypto
* [takama/daemon](https://github.com/takama/daemon):A daemon package for use with Go (golang) services with no dependencies
* [golang/protobuf](https://github.com/golang/protobuf):Go support for Google's protocol buffers
* [TrueFurby/go-callvis](https://github.com/TrueFurby/go-callvis):Visualize call graph of a Go program using dot format. https://truefurby.github.io/go-callvis
* [dgryski/go-perfbook](https://github.com/dgryski/go-perfbook):Thoughts on Go performance optimization
* [Shopify/sarama](https://github.com/Shopify/sarama):Sarama is a Go library for Apache Kafka 0.8, and up. https://shopify.github.io/sarama
* [alecthomas/participle](https://github.com/alecthomas/participle):A parser library for Go
* [zserge/lorca](https://github.com/zserge/lorca):Build cross-platform modern desktop apps in Go + HTML5
* [ginuerzh/gost](https://github.com/ginuerzh/gost):GO Simple Tunnel - a simple tunnel written in golang
* [rakyll/statik](https://github.com/rakyll/statik):Embed files into a Go executable
* [ry/v8worker](https://github.com/ry/v8worker):Minimal golang binding to V8
* Raft
  - [lni/dragonboat](https://github.com/lni/dragonboat):A feature complete and high performance multi-group Raft library in Go.
* [go-swagger/go-swagger](https://github.com/go-swagger/go-swagger):Swagger 2.0 implementation for go https://goswagger.io

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
