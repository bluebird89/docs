# [beego](https://github.com/astaxie/beego)

beego is an open-source, high-performance web framework for the Go programming language. http://beego.me

## 安装

```go
go get -u github.com/astaxie/beego
go get -u github.com/beego/bee

cd $GOPATH/src
bee new hello
cd hello
bee run hello // 打开 http://localhost:8080/
```

## 问题

> import path does not begin with hostname

export GOROOT=/usr/local/opt/go/libexec

## 工具

* [beego/admin](https://github.com/beego/admin):基于beego的后台管理系统

```go
go get github.com/beego/admin
bee new hello

// hello/routers/router.go
import (
    "hello/controllers"         //自身业务包
    "github.com/astaxie/beego"  //beego 包
    "github.com/beego/admin"  //admin 包
)

func init() {
    admin.Run()
    beego.Router("/", &controllers.MainController{})
}

// mysql
db_host = localhost
db_port = 3306
db_user = root
db_pass = root
db_name = admin
db_type = mysql
postgresql数据库链接信息

db_host = localhost
db_port = 5432
db_user = postgres
db_pass = postgres
db_name = admin
db_type = postgres
db_sslmode=disable
sqlite3数据库链接信息

// db_path 是指数据库保存的路径，默认是在项目的根目录
db_path = ./
db_name = admin
db_type = sqlite3

// 部分权限系统需要配置的信息

sessionon = true
rbac_role_table = role
rbac_node_table = node
rbac_group_table = group
rbac_user_table = user
#admin用户名 此用户登录不用认证
rbac_admin_user = admin

#默认不需要认证模块
not_auth_package = public,static
#默认认证类型 0 不认证 1 登录认证 2 实时认证
user_auth_type = 1
#默认登录网关
rbac_auth_gateway = /public/login
#默认模版
template_type=easyui

cd $GOPATH/src/hello
cp -R ../github.com/beego/admin/static ./
cp -R ../github.com/beego/admin/views ./

go build
./hello -syncdb
// 默认得用户名密码都是admin
```
