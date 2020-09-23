# [Traefik](https://github.com/containous/traefik)

云原生的新型的 HTTP 反向代理、负载均衡软件。负责接收系统的请求，然后使用合适的组件来对这些请求进行处理。 兼容所有主流的集群技术，比如 Kubernetes，Docker，Docker Swarm，AWS，Mesos，Marathon，等等；并且可以同时处理多种方式  https://docs.traefik.io/

* 也称之为边缘路由器（Edge Router），是整个平台的大门，拦截并路由每个传入的请求
* 知道所有的逻辑和规则，这些规则确定哪些服务处理哪些请求；传统的反向代理需要一个配置文件，其中包含路由到服务的所有可能路由，而 Traefik 会实时检测服务并自动更新路由规则，可以自动服务发现
* 启动 Traefik 时，需要定义 Entrypoints（入口点），然后根据连接到这些 Entrypoints 的路由（Routes）来分析传入的请求，来查看他们是否与一组规则（Rules）相匹配，如果匹配，则路由可能会将请求通过一系列中间件（Middlewares，相当于Java中的拦截器Interceptor/过滤器Filter的概念）转换过后再转发到你的服务上去
* 特点：
  - 支持动态加载配置文件和优雅重启
  - 自动的服务发现与负载均衡
  - 自动配置ACME(Let's Encrypt)证书功能
  - 支持熔断、重试
  - 内置Web UI，管理相对方便
  - 支持WebSocket、HTTP/2、gRPC
  - metrics 的支持（Rest、Prometheus、Datalog、Statsd、InfluxDB）
  - 支持K8S、docker swarm等，和容器结合比较紧密

## 概念

* Providers：用来自动发现平台上的服务，可以是编排工具、容器引擎或者 key-value 存储等，比如 Docker、Kubernetes、File
* Entrypoints：监听传入的流量（端口等…），是网络入口点，它们定义了接收请求的端口（HTTP 或者 TCP）。
* Routers：分析请求（host, path, headers, SSL, …），负责将传入请求连接到可以处理这些请求的服务上去。
* Services：将请求转发给你的应用（load balancing, …），负责配置如何获取最终将处理传入请求的实际服务。
* Middlewares：中间件，用来修改请求或者根据请求来做出一些判断（authentication, rate limiting, headers, …），中间件被附件到路由上，是一种在请求发送到你的服务之前（或者在服务的响应发送到客户端之前）调整请求的一种方法。

## 使用

* 配置
  - 动态配置：包含定义系统如何处理请求的所有配置内容，这些配置是可以改变的，而且是无缝热更新的，没有任何请求中断或连接损耗
  - 静态配置：静态配置中的元素（这些元素不会经常更改）连接到 Providers 并定义 Treafik 将要监听的 Entrypoints。在 Traefik 中有三种方式定义静态配置：在配置文件中、在命令行参数中、通过环境变量传递
* 官方Dashboard `http://localhost:8080/`
* 路由规则
  - Headers(key, value)   检查 headers 中是否有一个键为 key值为value`的键值对
  - HeadersRegexp(key, regexp)  检查 headers 中是否有一个键为 key，值匹配正则表达式 regexp的键值对
  - Host(example.com, ...)  检查请求的域名是否包含在给定的 domains 域名中
  - HostRegexp(example.com, {subdomain:[a-z]+}.example.com, ...)    检查请求的域名是否匹配给定的 regexp正则表达式
  - Method(GET, ...)    检查请求的方法是否包含在给定的 methods (GET, POST, PUT, DELETE, PATCH) 中
  - Path(/path, /articles/{cat:[a-z]+}/{id:[0-9]+}, ...)    匹配确定的请求路径，它接受一系列文字和正则表达式路径
  - PathPrefix(/products/, /articles/{cat:[a-z]+}/{id:[0-9]+})  匹配请求前缀路径，它接受一系列文字和正则表达式前缀路径
  - Query(foo=bar, bar=baz) 匹配查询字符串参数，接受key=value的键值对序列

```sh
# 开启 Traefik 服务
docker-compose -f traefik-v2.2.0.yaml up -d reverse-proxy
# 查看使用 docker-compose启动的应用
docker-compose -f traefik-v2.2.0.yaml ps

docker-compose -f test-service.yaml up -d whoami
docker-compose -f test-service.yaml ps
curl -H Host:whoami.docker.localhost http://localhost # 配置域名才可以注册，不设置 Host，访问会失败

docker-compose -f test-service.yaml up -d --scale whoami=2
curl http://localhost -H Host:whoami.docker.localhost # 自动负载均衡到2个不同的实例上去
```
