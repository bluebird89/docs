# [astaxie/beego](https://github.com/astaxie/beego)

beego is an open-source, high-performance web framework for the Go programming language. http://beego.me

## 安装

```go
go get -u github.com/astaxie/beego
go get -u github.com/beego/bee

cd $GOPATH/src
bee new hello
cd hello
bee run hello # 打开 http://localhost:8080/
```

## 问题

> import path does not begin with hostname

export GOROOT=/usr/local/opt/go/libexec

## 参考

* [Beego Framework](https://beego.me/):一个使用 Go 的思维来帮助您构建并开发 Go 应用程序的开源框架
