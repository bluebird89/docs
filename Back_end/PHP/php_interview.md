# 面试

### 前端篇

#### HTML

HTML 由元素组成，可以被多个属性修饰。元素和属性是 HTML 里最重要的两个概念。

* （基础）HTML 元素的初级划分：[块级元素](https://developer.mozilla.org/en-US/docs/Web/HTML/Block-level_elements)和[行内元素](https://developer.mozilla.org/en-US/docs/Web/HTML/Inline_elements)，初学者必须非常了解这两则的区别，能够识别常用的元素到底是块级还是行内元素。
* （进阶）但是上述划分并没有从语义化上进行区分，所以可以从语义化、功能化上进行分类，见 [HTML 元素参考](https://developer.mozilla.org/en-US/docs/Web/HTML/Element) 章节。
* （进阶）再高级一点从 Content Model 上划分，见 Content categories 或 [HTML 规范](https://html.spec.whatwg.org/multipage/dom.html#kinds-of-content)。
* （Code Review）另外可以查缺补漏，看看 [HTML 属性参考](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes) 章节的内容，熟悉常用的属性，并且了解一些冷门的属性的使用技巧。
* （实战）结合上述参考，需要懂得 HTML 在段落、表格、表单、多媒体（视频、图片等）、SEO 上的应用。

#### CSS

* [选择器](https://developer.mozilla.org/en-US/docs/Learn/CSS/Introduction_to_CSS/Selectors)
* [数据类型](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Types)（单位）
* [文本](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Text) & [字体](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Fonts)
* 布局:前四点是 display 的概念，再后面两点是位移相关，最后两点是变种，懂得其中的概念，懂得根据项目情况灵活运用即为基础扎实。
    - [Table](https://developer.mozilla.org/zh-CN/docs/Web/CSS/CSS_Table)（ungrid 方案）
    - Inline Block（巧妙）
    - [Flexible Box](https://developer.mozilla.org/zh-CN/docs/Web/CSS/CSS_Flexible_Box_Layout)（主流）
    - [Grid](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Grid_Layout)（草案）
    - [Positioning](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Positioning)（位移）
    - [Transforms](https://developer.mozilla.org/zh-CN/docs/Web/CSS/CSS_Transforms)（位移）
    - [Float](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Positioning)（经典）
    - [Columns](https://developer.mozilla.org/zh-CN/docs/Web/CSS/CSS_Columns)（巧妙）
* [盒模型](https://developer.mozilla.org/en-US/docs/Learn/CSS/Styling_boxes/Box_model_recap):从里到外相关的属性有
    - width 和 height，包括 min 和 max
    - padding
    - border/box-sizing/box-shadow
    - margin
    - overflow
    - outline
* 动画，包括两方面 transition（过渡） 和 animation（时间轴和关键帧）

#### JavaScript

与 HTML 和 CSS 相关的 [DOM](https://developer.mozilla.org/en-US/docs/Web/API/Document_Object_Model) 和 [CSSOM](https://developer.mozilla.org/en-US/docs/Web/API/CSS_Object_Model) （重点研究对象）的相关 API 是初级开发需要掌握的。

#### 协议篇

WEB 是通过 HTTP 协议进行客户端和服务端间通信的，对于 WEB 应用开发，理解 HTTP 协议非常关键，其次要了解整个 TCP/IP 协议族，如果是游戏开发，理解 TCP 协议也非常关键，这部分建议看书：

* 首推《[图解HTTP](https://book.douban.com/subject/25863515/)》，初级开发来说
* 再看《[HTTP权威指南](https://book.douban.com/subject/10746113/)》，后面几个章节可以不用看。
* 对 SSL、TLS 感兴趣可以捎带看《[HTTPS权威指南 : 在服务器和Web应用上部署SSL/TLS和PKI](https://book.douban.com/subject/26869219/)》
* 如果想更进一步可以看《[TCP/IP详解](https://book.douban.com/series/12438)》系列。

#### HTTP 协议

* URL:URL 部分需要了解 URL 的结构组成部分，尤其需要知道如何处理编码的问题。
* 报文:报文的结构，包括请求报文和响应报文，重点考察的知识点包括：请求方法，响应状态码和首部字段。首部字段，考察重点主要在 Cookie、Authorization 还有 CORS 相关问题。
* SSL & TLS:HTTP + 加密 + 认证 + 完整性保护 = HTTPS.进阶看《[HTTPS权威指南 : 在服务器和Web应用上部署SSL/TLS和PKI](https://book.douban.com/subject/26869219/)》

#### HTTP/2.0

实战的重点在于 [HTTP](https://developer.mozilla.org/en-US/docs/Web/HTTP) 的实际应用，大致分两点：HTTP Server 和 HTTP Client。

HTTP 服务端其实就是 WEB 服务器，初步可以从 Nginx + php-fpm 和 Apache + mod_php 着手，后续的可以捣鼓 Socket 相关的扩展，国内比较推荐 swoole，小众的 reactphp、amphp 代码写的也非常优雅，这方面主要是 Socket，有时间可以重点看看 《[TCP/IP详解 卷1：协议](https://book.douban.com/subject/1088054/)》和《[UNIX网络编程 卷1：套接字联网API（第3版）](https://book.douban.com/subject/4859464/)》。

PHP 没有官方标准的 HTTP 类库，但是有个 PSR-7 标准，自己动手实践，实现这个标准的接口能大致理解 HTTP 的实战应用到底体现在哪里，这里会初步涉猎 I/O Streams 方面的知识，为以后进阶 Socket 编程奠定基础。

HTTP 客户端，PHP 只提供了 cURL 扩展，基本无敌，能搞定很多跨平台数据调用，进阶可以感受下 Socket 实现，不局限与应用层（HTTP），还可以直接走传输层（TCP/UDP），这方面重点考察 REST 的应用，进阶可以考察 RPC 之类。

另外 HTTP（还有一些相关协议） 应用，如果没有各种 SaaS 平台的使用和开发经验那是非常吃亏的，这方面的经验积累是长期的也是进阶的关键。

### PHP 篇

从编程语言的角度出发，考察更多的是编程语言的硬实力，而并非花哨的各种应用。

#### 基础

基础来说，翻阅 PHP 官方文档，翻两年就差不多了。如果是考察编程语言的硬实力主要体现在三方面：

* 数据结构
* 算法
* 设计模式

#### 数据结构与算法

数据结构与算法是密不可分的，初级开发熟悉 string 和 array 的各种增删改查排比操作是重点，感兴趣的还可以了解一下 PHP 的数据结构扩展库，除了 SPL 标准库还有个 ext-ds 扩展。

如果想学习数据结构与算法，首推《[算法（第4版）](https://book.douban.com/subject/19952400/)》一书，比《算法导论（原书第2版）》好理解多了，中高级 PHP 开发必读，可以针对性的写一些 PHP 实现。

另外，推荐一本刷算法的《[程序员代码面试指南：IT名企算法与数据结构题目最优解](https://book.douban.com/subject/26638586/)》，同样可以针对性的写一些 PHP 实现。

游戏应用算法会涉及的比较多，WEB 应用数据结构会涉及的比较多，尤其在各种解析器、编译器的实现上。感兴趣的可以自己去写一些模板引擎、编辑器的实现，个人比较推荐大家自己动手实现下 YAML 解析，YAML & JSON 在互联网跨平台上有广泛的应用。

#### 设计模式

对于初学者来说，先从面向对象开始着手，致力于写可读性、可维护性代码就行了，设计模式对于初级开发我的建议是忘了它吧。 实际一点，坚持 GitHub 上翻两年代码也差不多了，培养 Code Review 能力。实战可以自己去实现框架的方方面面，从这个过程中去理解设计模式，对于设计模式来说不要为了用而用。

#### 进阶

多进程、多线程相关，异步思维的培养。

* swoole 全套
* libev 和 libevent 之类的 PHP 扩展库（PHP 7 之后就剩 ext-event 扩展库了）
* PHP 的多线程 ext-pthreads 库，目前正在发展中，PHP 7.2+，需要开启 zts。

在这个过程中，势必会不断的了解 C/C++ 编写的扩展库，为以后进军高级开发带来很大帮助。

#### 高级

高级 PHP 开发不懂 C/C++ 是非常吃亏的，个人建议 PHP 开发也有必要学习 C/C++ 编程，不求精通，但是要有一定的理解和阅读 C/C++ 代码的能力。

初步可以从了解 PHP 内核着手，PHP 5 和 PHP 7 有很大的不同，建议直接看 7 的。盘古大叔的《[PHP7内核剖析](https://github.com/pangudashu/php7-internal)》总结还不错的，建议入门的人看看。

扩展库：国外的 PHP-CPP 和国内的 PHP-X，另外还有 phalcon 的 zephir。

### 框架篇

首先说个现在 PHP 里也流行起来的 IoC 容器，IoC 的概念简单的说来：

IoC（控制反转）目前比较流行的两种方式 DI（依赖注入模式，被动） 和 SL（服务器定位模式，主动），DI 是遵循 DIP（依赖反转原则）的，SL 是 anti-pattern（反模式）的，不遵循 DIP。因为注入的形式五花八门，为了代码复用性和扩展性出现了 IoC 容器这么个东西，它是遵循各自 DI/SL 模式实现的容器，IoC 容器会大量运用反射机制来实现。

Laravel 中 Container（illuminate/container）是 DI/SL 的混合体。关于这个概念，可以多读几遍下面这篇文章（Java 版）：

[Inversion of Control Containers and the Dependency Injection pattern](https://martinfowler.com/articles/injection.html) [[译文](http://files.cnblogs.com/files/dongbeifeng/DependencyInjection.pdf)]

#### 基础

说回到框架，核心主要有三部分：HTTP、Routing 和 MVC，推荐看 Slim 框架的底层代码。

* HTTP 的 Request、Response 是必备，其次还有 Cookie & Session，这些都是面试的考点。
* Routing 核心其实就是 Event Dispatching 的概念，Lumen 和 Slim 都用的 FastRoute，底层实现写的非常不错。不过，如果想规范化的学习 Routing，建议看 symfony/routing 的实现。
* MVC 方面：Model 是核心，View 和 Controller 有各种变形。Model 分 Active Record 和 Data Mapper，对于的有 Eloquent（AR）和 Doctrine 2（DM）两大阵营（其他框架的使用者不要喷我）。

#### 进阶

* 初步，可以从学习和阅读框架源码开始，symfony 的组件化思路是非常值得推荐和学习的。
* 其次，可以从 swoole 全套着手了解异步思维。
* 另外，ext-event 扩展库相关的 PHP 类库，如 reactphp、amphp、workerman 等等也是非常值得学习使用。

### MySQL

#### 初级

重点放在 SQL，用好相关 ORM 就可以了，在实践中出问题，面向 Google 编程来解决。另外的重点，表结构设计，从我个人浅薄的经验来总结，大致有：

* 文章类
* 评论类
* 日历相关，课程表、日历事件等
* 时刻表，运动健身相关，或者是一些小程序
* 票务相关，电影票、火车票、机票等等（与时刻表相关联）
* 订单类，只要有支付就有订单。
* 用户相关，尤其是涉及权限时的处理。

#### 高级

大型网站还可以从数据库读写分离下功夫，解决数据库高负载的问题。再高级一点把数据库抽象为数据访问的相关服务平台，那内容可以引申出多个方面：

* 数据库
* 文件存储
* NoSQL
* 缓存
* 搜索引擎

### Docker

Docker 的出现实在是太赞了，以前需要通过 VM 来捣鼓的东西，现在 Docker 就可以做了。非常有利于培养 Service 思维。

#### 初级

从实战着手，尤其是了解 Linux CLI 和 shell 编程，重点推荐《[Linux命令行与shell脚本编程大全 第3版](https://book.douban.com/subject/26854226/)》一书，入门首选。原理方面《[现代操作系统（第3版）](https://book.douban.com/subject/3852290/)》可以看看，重点看进程与线程、I/O、死锁三个章节。

#### 实战

英文不错直接上手官方文档就可以了，中文方面可以看书《[Docker — 从入门到实践](https://yeasy.gitbooks.io/docker_practice/content/)》

Docker 初级的重点在于 Dockerfile 镜像，Linux CLI 和 shell 编程在这里就非常有用了。会涉及到 Nginx、PHP、MySQL、Redis 等配置问题。

如果自己不知道怎么配，可以学习 [LaraDock](https://github.com/laradock/laradock)，不过 LaraDock 有点臃肿，但是用来学习和提高认知是非常有帮助的。

