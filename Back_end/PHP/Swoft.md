# [swoft-cloud/framework](https://github.com/swoft-cloud/framework)

Modern High performance AOP and Coroutine PHP Framework, base on Swoole 2 https://www.swoft.org

* 基于 Swoole 扩展
* 内置协程网络服务器(Http/Websocket/RPC)
* 高性能路由
* 强大的 AOP (面向切面编程)
* 灵活的注解功能
* 全局的依赖注入容器
* 基于 PSR-7 的 HTTP 消息实现
* 基于 PSR-11 的容器规范实现
* 基于 PSR-14 的事件管理器
* 基于 PSR-15 的中间件
* 基于 PSR-16 的缓存设计
* 可扩展的高性能 RPC
* RESTful 支持
* 国际化(i18n)支持
* 快速灵活的参数验证器
* 配置中心
* 完善的服务治理，熔断、降级、限流负载、注册与发现
    - 服务注册与发现，需要用到 Swoft 官方提供的 swoft-consul 组件
        + 注册与取消服务:监听 SwooleEvent::START 事件，注册服务
* 通用连接池 Mysql、Redis、RPC
* 数据库 ORM
* 协程、异步任务投递
* 自定义用户进程
* 强大的日志系统

## 安装

```sh
composer create-project swoft/swoft swoft

cp .env.example .env
vim .env # 根据需要调整启动参数

php bin/swoft start

php bin/swoft rpc|ws|http:start|restart|reload|stop
php bin/swoft rpc|ws|http:start -d # 守护进程启动
```

## 参考

* [docs](http://doc.swoft.org/)
* [wujunze/awesome-swoft](https://github.com/wujunze/awesome-swoft):A curated list of bookmarks, packages, tutorials, videos and other cool resources from the Swoft ecosystem
