# [Kong/kong](https://github.com/Kong/kong)

gorilla The Cloud-Native API Gateway & Service Mesh https://konghq.com

* 由 Mashape 开发的并于2015年开源的一款API 网关，它是基于OpenResty（Nginx + Lua模块）和 Apache Cassandra/PostgreSQL 构建的，能提供易于使用的RESTful API来操作和配置API管理系统
* 可以水平扩展多个 Kong Server，通过前置的负载均衡配置把请求均匀地分发到各个Server，来应对大批量的网络请求
* 扩展是通过插件机制进行的，并且也提供了插件的定制示例方法
* 插件定义了一个请求从进入到最后反馈到客户端的整个生命周期，所以可以满足大部分的定制需求，本身 Kong 也已经集成了相当多的插件，包括密钥认证、CORS、文件日志、API 请求限流、请求转发、健康检查、熔断等
* Nginx、Openresty和Kong三者紧密相连：
  - Nginx = Http Server + Reversed Proxy + Load Balancer
  - Openresty = Nginx + Lua-nginx-module，Openresty是寄生在 Nginx 上，暴露 Nginx 处理的各个阶段的钩子， 使用 Lua 扩展 Nginx
  - Kong = Openresty + Customized Framework，Kong作为 OpenResty 的一个应用程序
* 特性：
  - 可扩展性: 通过简单地添加更多的服务器，可以轻松地进行横向扩展，这意味着您的平台可以在一个较低负载的情况下处理任何请求。
  - 模块化: 可以通过添加新的插件进行扩展，这些插件可以通过RESTful Admin API轻松配置。
  - 在任何基础架构上运行: Kong 网关可以在任何地方都能运行。可以在云或内部网络环境中部署 Kong，包括单个或多个数据中心设置，以及 public，private 或 invite-only APIs

## 安装

* 两种方式:一种是没有数据库依赖的DB-less 模式，另一种是with a Database 模式
* [Docker](https://docs.konghq.com/install/docker/)
* 端口
  - 8000：用来接收客户端的 HTTP 请求，并转发到 upstream
  - 8443：用来接收客户端的 HTTPS 请求，并转发到 upstream
  - 8001：HTTP 监听的 API 管理接口
  - 8444：HTTPS 监听的 API 管理接口

```sh
docker network create kong-net

# 使用Cassandra
docker run -d --name kong-database --network=kong-net -p 9042:9042 cassandra:3
# 使用 PostgreSQL
docker run -d --name kong-database --network=kong-net -p 5432:5432 -e "POSTGRES_USER=kong" -e "POSTGRES_DB=kong" -e "POSTGRES_PASSWORD=kong" postgres:9.6
# 初始化或迁移数据
docker run --rm --network=kong-net -e "KONG_DATABASE=postgres" -e "KONG_PG_HOST=kong-database" -e "KONG_PG_PASSWORD=kong" -e "KONG_CASSANDRA_CONTACT_POINTS=kong-database" kong:1.5.1 kong migrations bootstrap
# 启动容器
docker run -d --name kong --network=kong-net -e "KONG_DATABASE=postgres" -e "KONG_PG_HOST=kong-database" -e "KONG_PG_PASSWORD=kong" -e "KONG_CASSANDRA_CONTACT_POINTS=kong-database" -e "KONG_PROXY_ACCESS_LOG=/dev/stdout" -e "KONG_ADMIN_ACCESS_LOG=/dev/stdout" -e "KONG_PROXY_ERROR_LOG=/dev/stderr" -e "KONG_ADMIN_ERROR_LOG=/dev/stderr" -e "KONG_ADMIN_LISTEN=0.0.0.0:8001, 0.0.0.0:8444 ssl" -p 8000:8000 -p 8443:8443 -p 8001:8001 -p 8444:8444 kong:1.5.1

curl -i http://localhost:8001/
```

## 原理

* 架构
  - Kong Restful 管理API：提供了API、API消费者、插件、upstreams、证书等管理
  - Kong 插件：拦截请求/响应，相当于 Servlet中的拦截器，实现请求的AOP处理
  - 数据中心：用于存储 Kong 集群节点信息、API、消费者、插件等信息，目前提供了PostgreSQL和Cassandra支持，如果需要高可用建议使用Cassandra
  - Kong 集群中的节点通过 Gossip 协议自动发现其他节点，当通过一个 Kong 节点的管理 API 进行一些变更时也会通知其他节点。每个 Kong 节点的配置信息是会缓存的，如插件，那么当在某一个 Kong 节点修改了插件配置时，需要通知其他节点配置的变更。
  - Kong 核心基于 OpenResty，实现了请求/响应的 Lua 处理化
* Service:抽象层面的服务，可以直接映射到一个物理服务，也可以指向一个Upstream（同Nginx中的Upstream，是对上游服务器的抽象）
* Route是路由的抽象，负责将实际的请求映射到 Service
* Tag
* Consumer
* Plugin
* Certificate
* SNI
* Upstream
* Target 代表了一个物理服务（IP地址/hostname + port的抽象），一个Upstream可以包含多个Targets

```sh
# 添加 name为 hello-upstream 的 Upstream
curl -i -X POST http://localhost:8001/upstreams  --data name=hello-upstream

# 为 mock-upstream 添加 Target
curl -i -X POST http://localhost:8001/upstreams/hello-upstream/targets --data target="xxx.xxx.xxx.xxx:8081"

# 修改  hello-service，为其配置
curl -i -X PATCH http://localhost:8001/services/hello-service --data url='http://hello-upstream/hello'
```

## Kong Plugins

* key-auth
  - 接收config.key_names定义参数，默认参数名称 ['apikey']。在HTTP请求中 header和params参数中包含apikey参数，参数值必须apikey密钥，Kong网关将检查密钥，验证通过才可以访问后续服务
  - 为Service添加服务消费者（Consumer）定义消费者访问 API Key, 让他拥有访问hello-service的权限
* [Kong Hub](https://docs.konghq.com/hub/）
* 身份认证插件：Kong提供了Basic Authentication、Key authentication、OAuth2.0 authentication、HMAC authentication、JWT、LDAP authentication认证实现。
* 安全控制插件：ACL（访问控制）、CORS（跨域资源共享）、动态SSL、IP限制、爬虫检测实现。
* 流量控制插件：请求限流（基于请求计数限流）、上游响应限流（根据upstream响应计数限流）、请求大小限制。限流支持本地、Redis和集群限流模式。
* 分析监控插件：Galileo（记录请求和响应数据，实现API分析）、Datadog（记录API Metric如请求次数、请求大小、响应状态和延迟，可视化API Metric）、Runscope（记录请求和响应数据，实现API性能测试和监控）
* 协议转换插件：请求转换（在转发到upstream之前修改请求）、响应转换（在upstream响应返回给客户端之前修改响应）。
* 日志应用插件：TCP、UDP、HTTP、File、Syslog、StatsD、Loggly等

```sh
# 配置 key-auth 插件
curl -i -X POST http://localhost:8001/routes/hello-route/plugins --data name=key-auth
# 创建消费者 Hidden：
curl -i -X POST http://localhost:8001/consumers/ --data username=Hidden
# 创建一个 api key
curl -i -X POST http://localhost:8001/consumers/Hidden/key-auth/ --data key=ENTER_KEY_HERE
```

## 工具

* Admin
  - Kong 企业版提供了管理UI
  - [PGBI/kong-dashboard](https://github.com/PGBI/kong-dashboard):Dashboard for managing Kong gateway 当前最新版本（3.6.x）并不支持最新版本的 Kong，最后一次更新也要追溯到1年多以前了
    + `docker run --rm --network=kong-net -p 8080:8080  pgbi/kong-dashboard start --kong-url http://kong:8001`
  - [pantsel/konga](https://github.com/pantsel/konga): More than just another GUI to Kong Admin API <https://pantsel.github.io/konga/> 观察到现在 Kong 的所有的配置，并且可以对于管理 Kong 节点情况进行查看、监控和预警。Konga 主要是用 AngularJS 写的，运行于nodejs服务端
    + 特点
      * 管理所有Kong Admin API对象。
      * 支持从远程源（数据库，文件，API等）导入使用者。
      * 管理多个Kong节点。使用快照备份，还原和迁移Kong节点。
      * 使用运行状况检查监视节点和API状态。
      * 支持电子邮件和闲置通知。
      * 支持多用户。
      * 易于数据库集成（MySQL，PostgresSQL，MongoDB，SQL Server
    + 安装：`docker run  -d -p 1337:1337 --network kong-net --name konga -e "DB_ADAPTER=postgres" -e "DB_URI=postgresql://kong:kong@kong-database/kong" pantsel/konga`
    + 通过 <http://localhost:1337/> 访问管理界面
    + 在 CONNECTIONS 中添加 Kong 服务的管理路径 `http://xxx.xxx.xxx.xxx:8001`

## 参考

* [RESTful API](https://docs.konghq.com/2.0.x/admin-api/):管理API的端口是8001
  - 添加一个Service:`curl -i -X POST http://localhost:8001/services  --data name=hello-service  --data url='http://xxx.xxx.xxx.xxx:8081/hello'`
  - Service 添加一个 Route:`curl -i -X POST --url http://localhost:8001/services/hello-service/routes --data 'paths[]=/hello' --data name=hello-route`
  - 验证:`http://localhost:8000/hello`
