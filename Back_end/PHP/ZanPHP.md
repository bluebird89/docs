# [Zan PHP Framework](https://github.com/youzan/zanphp)

<http://zanphp.io/> PHP开发面向C10K+的高并发SOA服务和RPC服务首选框架

* 核心特性
    - 基于 `yield` 实现了独立堆栈的协程
    - 类似于 Golang 的并发编程模型实现
    - 基于 [zan](https://github.com/youzan/zan) 提供异步非阻塞I/O服务
    - 连接池支持（内置 MySQL、Redis、syslog 等多种组件）
    - 类似 Golang 的 defer 机制解决由于异常导致的资源未释放、锁未释放的问题
    - 可继承的View布局及组件化支持，方便完成 bigPipe/bigRender/首屏加载优化等不同的渲染方式
    - 基于模型驱动的 SQLMap，实现了 SQL 的快速定位及方便的 sharding、cache 支持
    - 提供类似于 [Laravel](https://github.com/laravel/laravel) 的 middleware(Filters & Terminators) 机制
    - Di及单元测试的良好支持
    - 完整的RPC远程服务调用方案
* 定位
    - ZanPHP 的定位是高并发 Web 服务或业务中间件。
    - ZanPHP既可以满足创业公司或者个人建站的需求，也可以满足服务化架构下的框架需求。
    - ZanPHP 参考了很多 Golang 特性，不过目的绝不是为了替换掉 Golang。
    - PHP 在业务系统开发上的优势明显，而 Golang 相信会是将来系统编程的霸主。
* ZanPHP 和 Golang 的边界是：ZanPHP做业务系统；Golang 做平台系统（中间件或基础服务组件）,而 ZanPHP 和 Golang 编程模型的驱近，是希望能给PHP程序员一个更好的桥梁到Golang。理想的技术栈是：ZanPHP + Go + 少量的C/C++。当然对于致力于终身coding的码农来说：Java依然是很难跨过去的坎。

## 参考

* [zan-doc](https://github.com/youzan/zanphp-doc) - Zan PHP 开发者文档 <http://zanphpdoc.zanphp.io/>
* [zan-installer](https://github.com/youzan/zan-installer) - Zan PHP 脚手架工具
* [zanhttp](https://github.com/youzan/zanhttpdemo) - Zan PHP HTTP demo
* [zantcp](https://github.com/youzan/zantcpdemo) - Zan PHP TCP demo
* [PHP异步编程: 手把手教你实现co与Koa](https://github.com/youzan/php-co-koa)
