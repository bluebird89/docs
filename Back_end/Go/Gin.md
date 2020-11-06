# [gin](https://github.com/gin-gonic/gin)

Gin is a HTTP web framework written in Go (Golang). It features a Martini-like API with much better performance -- up to 40 times faster. If you need smashing performance, get yourself some Gin. https://gin-gonic.github.io/gin/

* 快速
  - 基于 Radix 树（一种更节省空间的 Trie 树结构）的路由，占用内存更少；
  - 没有反射；
  - 可预测的 API 性能。
* 内置路由器:开箱即用的路由器功能，不需要做任何配置即可使用
* 支持中间件:传入的 HTTP 请求可以经由一系列中间件和最终操作来处理，例如 Logger、Authorization、GZIP 以及最终的 DB 操作
* Crash 处理 :Gin 框架可以捕获一个发生在 HTTP 请求中的 panic 并 recover 它，从而保证服务器始终可用。此外，你还可以向 Sentry 报告这个 panic！
* JSON 验证:Gin 框架可以解析并验证 JSON 格式的请求数据，例如检查某个必须值是否存在。
* 路由群组 :支持通过路由群组来更好地组织路由，例如是否需要授权、设置 API 的版本等，此外，这些群组可以无限制地嵌套而不会降低性能。
* API 冻结:支持 API 冻结，新版本的发布不会破坏已有的旧代码。
* 错误管理:Gin 框架提供了一种方便的机制来收集 HTTP 请求期间发生的所有错误，并且最终通过中间件将它们写入日志文件、数据库或者通过网络发送到其它系统。
* 内置渲染: Gin 框架提供了简单易上手的 API 来返回 JSON、XML 或者 HTML 格式响应。
* 可扩展性: 我们将会在后续示例代码中看到 Gin 框架非常容易扩展。
* 易于测试: Gin 框架提供了完整的单元测试套件
