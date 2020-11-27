# [Web technology for developers](https://developer.mozilla.org/en-US/docs/Web)

系统的健壮性、可用性：原则是要保护系统，不能让所有用户都失败。直接抛弃一半请求

* 性能
  - 网页中代码真实的运行速度
  - 用户在使用时感受到的速度
* HTML 语言定义网页的结构和内容，CSS 样式表定义网页的样式，JavaScript 语言定义网页与用户的互动行为

## Web开发

* 软件开始主要运行在桌面上，而数据库这样的软件运行在服务器端，这种Client/Server模式简称CS架构
* CS架构不适合Web，最大的原因是Web应用程序的修改和升级非常迅速，而CS架构需要每个客户端逐个升级桌面App，因此，Browser/Server模式开始流行，简称BS架构
* 客户端只需要浏览器，应用程序的逻辑和数据都存储在服务器端。浏览器只需要请求服务器，获取Web页面，并把Web页面展示给用户即可。
* Web页面也具有极强的交互性。由于Web页面是用HTML编写的，而HTML具备超强的表现力，并且，服务器端升级后，客户端无需任何部署就可以使用到新的版本

## 发展阶段

* 静态Web页面：由文本编辑器直接编辑并生成静态的HTML页面，如果要修改Web页面的内容，就需要再次编辑HTML源文件，早期的互联网Web页面就是静态的
* CGI：由于静态Web页面无法与用户交互，比如用户填写了一个注册表单，静态Web页面就无法处理。要处理用户发送的动态数据，出现了Common Gateway Interface，简称CGI，用C/C++编写
* ASP/JSP/PHP：由于Web应用特点是修改频繁，用C/C++这样的低级语言非常不适合Web开发，而脚本语言由于开发效率高，与HTML结合紧密，因此，迅速取代了CGI模式。ASP是微软推出的用VBScript脚本编程的Web开发技术，而JSP用Java来编写脚本，PHP本身则是开源的脚本语言
* MVC：为了解决直接用脚本语言嵌入HTML导致的可维护性差的问题，Web应用也引入了Model-View-Controller的模式，来简化Web开发。ASP发展为ASP.Net，JSP和PHP也有一大堆MVC框架
* 技术栈
  - 常见的Web框架包括：Express，Sails.js，koa，Meteor，DerbyJS，Total.js，restify
  - ORM框架比Web框架要少一些：Sequelize，ORM2，Bookshelf.js，Objection.js
  - 模版引擎PK：Jade，EJS，Swig，Nunjucks，doT.js
  - 测试框架包括：Mocha，Expresso，Unit.js，Karma
  - 构建工具有：Grunt，Gulp，Webpack

### 服务器

* nginx作为反向代理服务器，可以做负载均衡和静态资源服务器优势
* 后面两台nodejs应用服务器集群
* nginx 负载均衡是用在多机器环境下的，单机负载均衡还是要靠cluster 这类模块来做
* nginx与node应用服务器的对比：
  - nginx是一个高性能的反向代理服务器，要大量并且快速的转发请求，所以不能采用上面第三种方法，原因是仅有一个进程去accept，然后通过消息队列等同步方式使其他子进程处理这些新建的连接，效率会低一些
  - nginx采用第二种方法，依然可能会产生负载不完全均衡和惊群问题。nginx是怎么解决的呢：
    + nginx中使用mutex互斥锁解决这个问题，具体措施有使用全局互斥锁，每个子进程在epoll_wait()之前先去申请锁，申请到则继续处理，获取不到则等待，并设置了一个负载均衡的算法（当某一个子进程的任务量达到总设置量的7/8时，则不会再尝试去申请锁）来均衡各个进程的任务量。具体的nginx如何解决惊群，看这篇文章: <http://blog.csdn.net/russell_tao/article/details/7204260>
  - node应用服务器采用方案三：node作为具体的应该服务器负责实际处理用户的请求，处理可能包含数据库等操作，不是必须快速的接收大量请求，而且转发到某具体的node单台服务器上的请求较之nginx也少了很多

## 流程

* Make Fewer HTTP Requests
* Use a Content Delivery Network
* Add an Expires Header
* Gzip Components
* Put CSS at the Top
* Move Scripts to the Bottom
* Avoid CSS Expressions
* Make JavaScript and CSS External
* Reduce DNS Lookups
* Minify JavaScript
* Avoid Redirects
* Remove Duplicate Scripts
* Configure ETags
* Make Ajax Cacheable

## URL 统一资源定位符 Uniform Resource Locator

* 资源，可以简单理解成各种可以通过互联网访问的文件
  - 只有知道了它们的 URL，才可能在互联网上获取它们
  - 只要资源可以通过互联网访问，它就必然有对应的 URL
* 表示某一网络资源存在于所在计算机网络上的位置 `<scheme>://<user>:<password>@<host>:<port>/<path>/[?query-string][#anchor]`
  - 协议（scheme）是浏览器请求服务器资源的方法，说明了访问资源所使用的协议类型，默认是 HTTP 协议
  - 主机（host）是资源所在的网站名或服务器的名字，又称为域名,或者 IP 地址（局域网）
  - 端口：默认80，紧跟在域名后面，两者之间使用冒号分隔
  - 路径（path）是资源在网站的位置，由于服务器可以模拟这些位置，所以路径只是虚拟位置
    + 默认跳转到该目录里面的index.html文件
  - 查询参数（parameter）是提供给服务器的额外信息。参数的位置是在路径后面，两者之间使用?分隔
    + 查询参数可以有一组或多组。每组参数都是键值对（key-value pair）的形式，同时具有键名(key)和键值(value)，它们之间使用等号（=）连接
  - 多组参数之间使用&连接
  - 锚点（anchor）是网页内部的定位点，使用#加上锚点名称，放在网址的最后
  - 字符
    + 26个英语字母（包括大写和小写）
    + 10个阿拉伯数字
    + 连词号（-）
    + 句点（.）
    + 下划线（_）
    + 保留字符
      * !：%21
      * #：%23
      * $：%24
      * &：%26
      * '：%27
      * (：%28
      * )：%29
      * *：%2A
      * +：%2B
      * ,：%2C
      * /：%2F
      * :：%3A
      * ;：%3B
      * =：%3D
      * ?：%3F
      * @：%40
      * [：%5B
      * ]：%5D
      * 空格：%20
    + 字符转义：使用 ASCII 字符集，对于不安全的字符则进行编码
    + 既不属于合法字符、也不属于保留字符的其他字符，浏览器会自动将它们转义，发给服务器
  - 绝对 URL 指的是，只靠 URL 本身就能确定资源的位置
  - 相对 URL 指的是，URL 不包含资源位置的全部信息，必须结合当前网页的位置，才能定位资源
  - .：表示当前目录
  - ..：表示上级目录

## 压力测试

* 产生压力方法
  - 写脚本：对服务器进行发包和收包操作
  - 现有工具(像jmeter、LoadRunner这些python的FunkLoad）压力测试用，erlang开发的tsung
  - 难点在于产生的压力是不是真实地反映了实际用户的操作场景
    + 举个例子来说，对游戏来说单纯并发登陆场景在整个线上环境中的占比可能并不大(新开服等特殊情况除外)，相反"登陆-开始战斗-结束战斗"、不同用户执行不同动作这种"混合模式"占了更大的比重
    + 如何从实际环境中提炼出具体的场景比重，并且把这种比重转化成实际压力是一个重要的关注点
* 产生压力之后，通常可以拿到TPS、响应时延等性能数据，那么如何定位性能问题呢？
  - TPS、响应时延只能告诉服务器是否存在问题，但不能帮助你定位问题
  - 这些表面背后是整个后台处理逻辑综合作用的结果，这时候可以先关注系统的CPU、内存、IO、网络，对比在tps、时延达到瓶颈时这些系统数据的情况，确定性能问题是系统哪一部分造成的，然后再回到代码逻辑中逐个优化这些点
* 当服务器整体性能就可以相对稳定下来，这时候就需要对自己服务器的承载能力有一个预估，通过产生真实压力、对比系统数据，大致可以对单套系统的处理能力有个真实的评价，然后结合业务规模配置服务器数量
* 目标：是搞死服务器，从而找到瓶颈点，如果搞不死，意义就不大
* 工具
  - apache AB
  - webbench

## 大流量

* 对常用功能建立缓存模块
* 网页尽量静态化
* 使用单独的图片服务器，降低服务器压力，使其不会因为图片加载造成崩溃
* 使用镜像解决不同网络接入商和不同地域用户访问差异
* 数据库集群图表散列
* 加强网络层硬件配置，硬的不行来软的
* 终极办法：负载均衡
* 负载均衡 把众多的访问量分担到其他的服务器上，让每个服务器的压力减少
  - Cisco 以太网通道 （网络层面的负载均衡设备和技术）
  - windows NLB技术 （服务器领域）
  - Linux LVS技术 （服务器领域）
  - F5等负载均衡器 （网络层面）
* 冗余技术 数据到达服务器，以防止出现宕机，备份服务器开始运行，防止单点故障，做一个备份。
* 集群技术：不是多台服务器加在一起形成的集群圈。而是在集群圈中，只有一台服务器在为客户服务即处于激活状态，其他的都处于休眠状态，当出现故障时，休眠状态的自动就会被激活。轮循。单点故障，有一个备份，就是集群
  - Cisco HSRP 热备份路由 ( hot standby route protel)
  - Windows集群技术
  - Linux HA 集群技术
  - IBM AIX 集群
* LVS集群采用三层结构，负载调度器、服务器池、共享存储主要组成
* 构架师来运营一家公司的网站必须考虑的三个问题
  - 网络构架
  - 服务器构架
  - 应用程序开发

servlet其实并不底层，http报文本质上就是一个字符串，容器承担了解析这个字符串的功能，解的快不快，解的好不好你也不知道，而struts，spring等都是基于这个字符串解析之上的外围打杂框架。

要想达到要非常少的机器扛住大规模的并发，可能需要抛弃servlet，直接用netty或者nio参考v8，nodejs，tornado等直接构建非阻塞的异步协程socket服务器

## 大数据存储

* 四种主流数据库
  - Mysql
  - Oracle
  - DB2（IBM）
  - Nosql (非关系型数据库)
* 淘宝数据存储分为三个阶段：
  - 主打mysql数据库
  - IBM AIX小型机 + Oracle数据库【成本】
  - Mysql主群+集群+分区技术（承担光棍节巨大访问量）
* 网络界最核心最重要的为数据的积累。这里先明确三个概念：
  + 负载均衡：服务器都是激活的，并且是轮循的
  + 冗余技术：一个激活，其它的备份处于休眠状态。
  + Mysql主从：依赖于Binary Log日志（记载CRUD，作用是恢复数据），主服务器的所有增删改的操作同时会备份复制一份给从服务器，让服务器同时执行，达到和主服务器的数据的同步和完整，它的重点是主服务器和从服务器都可以同时活动，即操作Mysql数据库时，增删改走都是主服务器，而查询走的是从服务器。所以，主从为负载的技术。
* MySQL
  - 分库分表
    + 垂直分表（字段不要太多，把一张大表竖切为许多小表）
    + 水平分表（把一张大表横切为若干小表）
  - 分区技术:将一个表拆成多个表，比较常用的方式是将表中的记录按照某种Hash算法进行拆分，简单的拆分方法如取模方式。在一定的层面表名不变，在真正的磁盘存储时存储在不同的分区
  - 集群：单点故障时，冗余备份

## 加速

* Squid 代理缓存技术（Squid：乌鱼）反向缓存-动静分离:Squid是一款用来做代理服务器的软件。作用是动静分离，将数据保存在缓存池中Squid cache，能够代理服务器执行。代理服务器就如同买火车票，去火车票代理售票点，买票，而不是去火车站，这样就减少了火车站的压力，提高了速度。
* 页面静态化缓存
* Memcache,Redis:Memcache 是一个高性能的分布式的内存对象缓存系统，目前全世界不少人使用这个缓存项目来构建自己大负载的网站，来分担数据库的压力，通过在内存里维护一个统一的巨大的hash表，它能够用来存储各种格式的数据，包括图像、视频、文件以及数据库检索的结果等。简单的说就是将数据调用到内存中，然后从内存中读取，从而大大提高读取速度。(注: 摘自百度全科)
* Sphinx 搜索加速:phinx全文索引,Sphinx 是一个基于SQL的全文检索引擎，可以结合MySQL，PostgreSQL作全文搜索，它可以提供比数据库本身更专业的搜索功能，使得应用程序更容易实现专业化的全文检索。

## SSO Single Sign On 单点登录

* 能够做到一次登录多次使用
  - 依赖项目为前后端分离项目
  - SSO认证中心不是前后端分离的，就是前端代码和后端代码部署在一个项目中
  - 前后端分离项目，登录使用token进行解决，前端每次请求接口时都必须传递token参数
* 用户自动登出可能是因为网站的登录cookie过期且SSO上的登录cookie也过期，这时当某个请求到达后台时，会清空所有与认证有关的cookie并重定向到SSO的登录页面。登录cookie的有效期是20分钟，但用户抱怨的是刚登录不久就被自动踢出，从日志上看也的确如此。所以“登录cookie过期”的不在场证明相当完美。
* 另外的可能就是缓存挂了。每个请求到达后台时，都会到服务器缓存中取出在用户登录时存储的一个token，将之与请求所携带的cookie中的token比较，如果不相符就自动登出。之所以这样做是考虑用户的安全，将伪造或窃取cookie登录的黑客拒之门外。如果存储或读取缓存失败，自然也会自动登出。齐识以前在读写缓存的地方加了很详细的日志，并没看到任何错误发生。“缓存”作案的可能性也不大。
* 自动登出
  - 前端每隔2分钟会自动向后台发一个心跳请求，如果服务器发现本次心跳与上一次心跳间隔时间超过3分钟，就认为用户已处于不活跃状态，自动将其登出
  - 这么做也是为了用户安全，比如将所有网站页面关闭，3分钟后再次打开，将会自动跳转到登录页面
  - 如果心跳请求没有发送成功，下次请求到来时很可能已经超过了3分钟，就会把用户踢出去

## 接口和用户体验

* 小心浏览器的实现标准上的不一致，确信让你的网站能够适当地跨浏览器 来看看网页在不同的浏览器下是怎么被显示出来的
* 考虑一下人们是怎么来访问你的网站而不是那些主流的浏览器：手机，读屏软件和搜索引擎，例如：一些Accessibility的东西： [WAI](https://www.w3.org/WAI/) 和  [Section508](https://www.section508.gov/), 移动设备开发：[MobiForge](https://mobiforge.com/).
* 部署Staging：怎么部署网站的更新而不会影响用户的访问。 Ed Lucas的答案 可以让你了解一些（陈皓注：Ed说了一些如版本控制，自动化build，备份，回滚等机制）。
* 千万不要直接给用户显示不友好的错误信息。
* 千万不要把用户的邮件地址以明文显示出来，这样会被爬虫爬走并被让用户的邮箱被垃圾邮件搞死。
* 为用户的链接加上 rel="nofollow" 的属性以 避免垃圾网站的干扰。（陈皓注：nofollow是HTML的一个属性，用于通知搜索引擎“这个链接所指向的网页非我所能控制，对其内容不予置评”，或者简单地说，该链接不是对目标网站或网页的“投票”，这样搜索引擎不会再访问这个链接。这个是用来减少一些特定垃圾页面对原网站的影响，从而可以改善搜索结果的质量，并且防止垃圾链接的蔓延。）
* 为网站建立[一些的限制](https://blog.codinghorror.com/rate-limiting-and-velocity-checking/) – 这个属于安全性的范畴。（陈皓注：比如你在Google注册邮箱时，你一口气注册超过两个以上的邮箱，gmail要求给你发短信或是给你打电话认证，比如Discuz论坛的会限制你发贴或是搜索的间隔时间等等，更多的网站会用CAPTCHA来确认是人为的操作。 这些限制都是为了防止垃圾和恶意攻击）
* 学习如何做 Progressive Enhancement. Progressive Enhancement是一个Web Design的理念
  - 基础的内容和功能应该可以被所有的浏览器存取
  - 页面布局的应该使用外部的CSS链接
  - Javascript也应该是外部链接还应该是 unobtrusive 的
  - 应该让用户可以设置他们的偏好
* 如果POST成功，要在POST方法后重定向网址，这样可以阻止用户通过刷新页面重复提交。
* 严重关注Accessibility。因为这是法律上的需求（陈皓注：Section 508是美国的508法案，其是美国劳工复健法的改进，它是一部联邦法律，这个法律要求所有技术要考虑到残障人士的应用，如果某个大众信息传播网站，如果某些用户群体（如残疾人）浏览该网站获取信息时，如果他们无法正常获得所期望的信息（如无法正常浏览），那可以依据相关法规，可以对该网站依法起诉）。 [WAI-ARIA](https://www.w3.org/WAI/standards-guidelines/aria/) 为这方面的事提供很不错的资源.

## 性能

* 简单的浏览器 F12查看 Network 标签页就可以进行简单分析
* 如果是加载前端资源太慢 比如图片、样式文件、脚本文件 可以考虑加带宽或者用 CDN 来加载这些静态资源 CDN 效果杠杠的 但是图片的压缩和缩略图还是要做 针对不同场景显示不同尺寸图片 不然 CDN 按流量收费能省则省 样式文件或者脚本文件如果过大 则该拆分拆分 反之如果都是分散的小文件 则该合并合并 更深入点还可以通过设置请求头/响应头字段设置浏览器缓存
* 如果是后端接口问题，则需要借助工具进行细分，基础设施方面，是否是 DNS 域名解析慢 网络请求时间长，通常这在服务器放在国外的情况下比较常见，排除了这个问题，还要看看服务器负载，CPU、内存、带宽、磁盘空间是否充沛，这些资源的不足或者打满都会造成服务器响应慢，这些东西不足则要补足，要查明原因，是否有异常或恶意攻击，如果是这种原因则要处理掉这些异常流量和问题，如果确实是用户请求量大，则要对服务器扩容，设置集群，当然这个服务器涉及多种应用，后面我们再细谈
* 基础设施没有问题，再往下看，需要从应用入口开始分析，是什么原因导致响应慢，代码问题？数据库问题？还是系统资源问题？如果是代码问题修复代码，数据库层面分析是否存在慢查询，慢查询可以通过优化索引解决，并且合理设置缓存来减少对数据库的IO 操作，或者引入搜索引擎实现宽表查询，如果数据库压力还是大，可以考虑读写分离、分库分表之类的后续分布式数据库解决方案，如果并发量大，缓存服务也扛不住，则把缓存拆分出去通过独立服务器进行操作，甚至构建分布式缓存，诸如此类，如果是单机 php-fpm 进程跑满，可以对 web 应用服务器进行扩容，然后做负载均衡，如果是单线程 IO 问题，考虑通过队列异步处理，或者引入 Swoole 提高系统并发性，等等。

* 只要需要，请实现cache机制，了解并合理地使用 HTTP caching 以及 HTML5 Manifest
* 优化页面 —— 不要使用20KB图片来平铺网页背景。（陈皓注：还有很多网页页面优化性的文章，你可以STFG – Search The Fucking Google一下。如果你要调试的话，你可以使用firebug或是chrome内置的开发人员的工具来查看网页装载的性能）
* 学习如何 gzip/deflate 网页 (deflate 更好)
* 把多个CSS文件和Javascript文件合并成一个，这样可以减少浏览器的网络连数，并且使用gzip压缩被反复用到的文件
* 学习一下 Yahoo Exceptional Performance 这个网站上的东西，上面有很多非常不错的改善前端性能的指导，以及 YSlow 这个工具。 Google page speed 是另一个用来做性能采样的工具。这两个工具都需要安装 Firebug
* 为那些小的图片使用 CSS Image Sprites，就像工具条一样。 (参看 “最小化 HTTP 请求” ) （陈皓注：把所有的小图片合并成一个图片，然后用CSS把显示其中的一块，这样，这些小图片只用传输一次，酷壳的Wordpress样式的那个RSS订阅列表中的小图标就是这样做的）
* 繁忙的网络应该考虑把网页的内容分开存放在不同的域名下。（陈皓注：比如有专门的图片服务器——图片相当耗带宽，或是专门的Ajax服务器）
* 静态网页 (如，图片，CSS，JavaScript，以及一些不需要访问cookies的网页)应该放在一个不使用cookies的独立的域名下，因为所有在同一个域名或子域名下的cookie会被这个域名下的请求一同发送。另一个好的选择是使用 Content Delivery Network (CDN)
* 使用单个页面的HTTP请求数最小化
* 为Javascript使用 Google Closure Compiler 或是 其它压缩工具（陈皓注：压缩Javascript代码可以让你的页面减少网络传输从而可以得到很快的喧染。注意，并不是所有的工具都可以正确压缩Javascript的，Google的这个工具甚至还可以帮你优化你的代码）
* 确认你的网站有一个 favicon.ico 文件放在网站的根下，如 /favicon.ico. 浏览器会自动请求这个文件，就算这个图标文件没有在你的网页中明显说明，浏览器也会请求。如果你没有这个文件，就会出大量的404错误，这会消耗你的服务器带宽。（陈皓注：服务器返回404页面会比这个ico文件可能还大）

## 建议

* 界面和用户体验（Interface and User Experience）
  - 知道各大浏览器执行Web标准的情况，保证你的站点在主要浏览器上都能正常运行。你至少要测试以下引擎：Gecko（用于Firefox）、Webkit（用于Safari、Chrome和一些手机浏览器）、IE（你可以利用微软发布的Application Compatibility VPC Images进行测试）和Opera。同时，不同的操作系统，可能也会影响浏览器如何呈现你的网站。
  - 除了浏览器，网站还有其他使用方式：手机、屏幕朗读器、搜索引擎等等。你应该知道在这些情况下，你的网站的运行状况。MobiForge提供了手机网站开发的一些相关知识。
  - 知道如何在基本不影响用户使用的情况下升级网站。通常来说，你必须有版本控制系统（CVS、Subversion、Git等等）和数据备份机制（backup）。
  - 不要让用户看到那些不友好的出错提示。
  - 不要直接显示用户的Email地址，至少不要用纯文本显示。
  - 为你的网站设置一些合理的使用限制，一旦超过门槛值，就自动停止服务。（这也与网站安全相关。）
  - 知道如何实现网页的渐进式增强（progressive enhancement）。
  - 用户发出POST请求后，总是将其重导向（redirect）至另外一个网页。
  - 不要忘记网站的可访问性（accessibility，即残疾人如何使用网站）。对于美国网站来说，有时这是法定要求。WAI-ARIA有一些这方面很好的参考资料。
* 安全性（Security）
  - 阅读《OWASP开发指南》，它提供了全面的网站安全指导。
  - 了解SQL注入（SQL injection）及其预防方法。
  - 永远不要信任用户提交的数据（cookie也是用户端提交的！）。
  - 不要明文（plain-text）储存用户的密码，要hash处理后再储存。
  - 不要对你的用户认证系统太自信，它可能很容易就被攻破，而你事先根本没意识到存在相关漏洞。
  - 了解如何处理信用卡。
  - 在登录页面及其他处理敏感信息的页面，使用SSL/HTTPS。
  - 知道如何对付session劫持（session hijacking）。
  - 避免"跨站点执行"（cross site scripting，XSS）。
  - 避免"跨域伪造请求"（cross site request forgeries，XSRF）。
  - 及时打上补丁，让你的系统始终跟上最新版本。
  - 确认你的数据库连接信息的安全性。
  - 跟踪攻击技术的最新发展，以及你使用的平台的最新安全漏洞。
  - 阅读Google的《浏览器安全手册》（Browser Security Handbook）。
  - 阅读《网络软件的黑客手册》（The Web Application Hackers Handbook）。
* 性能（Performance）
  - 只要有可能，就使用缓存（caching）。正确理解和使用HTTP caching与HTML5离线储存。
  - 优化图片。不要把一个20KB的图片文件，作为重复出现的网页背景图案。
  - 学习如何用gzip/deflate压缩内容（deflate方式更可取）。
  - 将多个样式表文件或脚本文件，合为一个文件，这样可以减少浏览器的http请求数，以及减小gzip压缩后的文件总体积。
  - 浏览Yahoo的Exceptional Performance网站，里面有大量提升前端性能的优秀建议，还有他们的YSlow工具。Google的page speed则是另一个用来分析网页性能的工具。两者都要求安装Firebug。
  - 如果你的网页用到大量的小体积图片（比如工具栏），就应该使用CSS Image Sprite，目的是减少http请求数。
  - 大流量的网站应该考虑将网页对象分散在多个域名（split components across domains）。
  - 静态内容（比如图片、CSS、JavaScript、以及其他cookie无关的网页内容）都应该放在一个不需要使用cookie的独立域名之上。因为域名之下如果有cookie，那么客户端向该域名发出的每次http请求，都会附上cookie内容。这里的一个好方法就是使用"内容分发网络"（Content Delivery Network，CDN）。
  - 将浏览器完成网页渲染所需要的http请求数最小化。
  - 使用Google的Closure Compiler压缩JavaScript文件，YUI Compressor亦可。
  - 确保网站根目录下有favicon.ico文件，因为即使网页中根本不包括这个文件，浏览器也会自动发出对它的请求。所以如果这个文件不存在，就会产生大量的404错误，消耗光你的服务器的带宽。
* 搜索引擎优化（Search Engine Optimization，SEO）
  - 使用"搜索引擎友好"的URL形式，比如example.com/pages/45-article-title，而不是example.com/index.php?page=45。
  - 不要使用"点击这里"之类的超级链接，因为这样等于浪费了一个SEO机会，而且降低了"屏幕朗读器"（screen reader）的使用效果。
  - 创建一个XML sitemap文件，它的缺省位置一般是/sitemap.xml（即放在网站根目录下）。
  - 当你有多个URL指向同一个内容时，在网页代码中使用<link rel="canonical" ... />。
  - 使用Google的Webmaster Tools和Yahoo的Site Explorer。
  - 从一开始就使用Google Analytics（或者开源的访问量分析工具Piwik）。
  - 知道robots.txt的作用，以及搜索引擎蜘蛛的工作原理。
  - 将www.example.com的访问请求导向example.com（使用301 Moved Permanently重定向），或者采用相反的做法，目的是防止Google把它们当做两个网站，分开计算排名。
  - 知道存在着恶意或行为不正当的网络蜘蛛。
  - 如果你的网站有非文本的内容（比如视频、音频等等），你应该参考Google的sitemap扩展协议。
* 技术（Technology）
  - 理解HTTP协议，以及诸如GET、POST、sessions、cookies之类的概念，包括"无状态"（stateless）是什么意思。
  - 确保你的XHTML/HTML和CSS符合W3C标准，使得它们能够通过检验。这可以使你的网页避免触发浏览器的古怪行为（quirk），而且使它在"屏幕朗读器"和手机上也能正常工作。
  - 理解浏览器如何处理JavaScript脚本。
  - 理解网页上的JavaScript文件、样式表文件和其他资源是如何装载及运行的，考虑它们对页面性能有何影响。在某些情况下，可能应该将脚本文件放置在网页的尾部
  - 理解JavaScript沙箱（Javascript sandbox）的工作原理，尤其是如果你打算使用iframe。
  - 知道JavaScript可能无法使用或被禁用，以及Ajax并不是一定会运行。记住，"不允许脚本运行"（NoScript）正在某些用户中变得流行，手机浏览器对脚本的支持千差万别，而Google索引网页时不运行大部分的脚本文件
  - 了解301重定向和302重定向之间的区别（这也是一个SEO相关问题）
  - 尽可能多得了解你的部署平台（deployment platform）
  - 考虑使用样式表重置（Reset Style Sheet）
  - 考虑使用JavaScript框架（比如jQuery、MooTools、Prototype），可以不用考虑浏览器之间的差异
* 解决bug
  - 理解程序员20%的时间用于编码，80%的时间用于维护，根据这一点相应安排时间。
  - 建立一个有效的错误报告机制。
  - 建立某些途径或系统，让用户可以与你接触，向你提出建议和批评。
  - 为将来的维护和客服人员撰写文档，解释清楚系统是怎么运行的。
  - 经常备份！（并且确保这些备份是有效的。）除了备份机制，你还必须有一个恢复机制。
  - 使用某种版本控制系统储存你的文件，比如Subversion或Git。
  - 不要忘记做单元测试（Unit Testing），Selenium之类的框架会对你有用。

## [性能优化](https://juejin.cn/post/6892994632968306702)

* 减少 HTTP 请求:将多个小文件合并为一个大文件，从而减少 HTTP 请求次数
* 使用 HTTP2
* 使用服务端渲染
  - 客户端渲染: 获取 HTML 文件，根据需要下载 JavaScript 文件，运行文件，生成 DOM，再渲染。
  - 服务端渲染：服务端返回 HTML 文件，客户端只需解析 HTML。
    + 优点：首屏渲染快，SEO 好。
    + 缺点：配置麻烦，增加了服务器的计算压力。
* 静态资源使用 CDN
* 将 CSS 放在文件头部，JavaScript 文件放在底部
  - 所有放在 head 标签里的 CSS 和 JS 文件都会堵塞渲染。如果这些 CSS 和 JS 需要加载和解析很久的话，那么页面就空白了。所以 JS 文件要放在底部，等 HTML 解析完了再加载 JS 文件
  - 先加载 HTML 再加载 CSS，会让用户第一时间看到的页面是没有样式的、“丑陋”的，为了避免这种情况发生，就要将 CSS 文件放在头部了
* 使用字体图标 iconfont 代替图片图标
* 善用缓存，不重复加载相同的资源：Expires 设置了一个时间，只要在这个时间之前，浏览器都不会请求文件，而是直接使用缓存。而 max-age 是一个相对时间，建议使用 max-age 代替 Expires
* 压缩文件
  - JavaScript：UglifyPlugin
  - CSS ：MiniCssExtractPlugin
  - HTML：HtmlWebpackPlugin
* 图片优化
  - 延迟加载：先不给图片设置路径，只有当图片出现在浏览器的可视区域时，才去加载真正的图片
  - 响应式图片：浏览器能够根据屏幕大小自动加载合适的图片
  - 调整图片大小
    + 用两张图片来实行优化。一开始，只加载缩略图，当用户悬停在图片上时，才加载大图
    + 对大图进行延迟加载，在所有元素都加载完成后手动更改大图的 src 进行下载
  - 降低图片质量
    + 通过 webpack 插件 image-webpack-loader
    + 通过在线网站进行压缩
  - 尽可能利用 CSS3 效果代替图片
  - 使用 webp 格式的图片：优势体现在它具有更优的图像数据压缩算法，能带来更小的图片体积，而且拥有肉眼识别无差异的图像质量；同时具备了无损和有损的压缩模式、Alpha 透明以及动画的特性，在 JPEG 和 PNG 上的转化效果都相当优秀、稳定和统一
* 通过 webpack 按需加载代码，提取第三库代码，减少 ES6 转为 ES5 的冗余代码
  - 根据文件内容生成文件名，结合 import 动态引入组件实现按需加载
  - 提取第三方库： splitChunk 插件 cacheGroups 选项
  - 减少 ES6 转为 ES5 的冗余代码
* 减少重绘重排
* 使用事件委托:事件委托利用了事件冒泡，只指定一个事件处理程序，就可以管理某一类型的所有事件。所有用到按钮的事件（多数鼠标事件和键盘事件）都适合采用事件委托技术， 使用事件委托可以节省内存
* 注意程序局部性
  - 重复引用相同变量的程序具有良好的时间局部性
  - 对于具有步长为 k 的引用模式的程序，步长越小，空间局部性越好；而在内存中以大步长跳来跳去的程序空间局部性会很差
* if-else 对比 switch:判断条件数量越来越多时，越倾向于使用 switch 而不是 if-else
  - 条件语句特别多时,试一下查找表。查找表可以使用数组和对象来构建
* 避免页面卡顿
  - 目前大多数设备的屏幕刷新率为 60 次/秒。因此，如果在页面中有一个动画或渐变效果，或者用户正在滚动页面，那么浏览器渲染动画或页面的每一帧的速率也需要跟设备屏幕的刷新率保持一致。
  - 每个帧的预算时间仅比 16 毫秒多一点 (1 秒/ 60 = 16.66 毫秒)。但实际上，浏览器有整理工作要做，因此您的所有工作需要在 10 毫秒内完成。如果无法符合此预算，帧率将下降，并且内容会在屏幕上抖动。 此现象通常称为卡顿，会对用户体验产生负面影响
* 使用 requestAnimationFrame 来实现视觉变化
* 使用 Web Workers
  - 使用其他工作线程从而独立于主线程之外，它可以执行任务而不干扰用户界面。一个 worker 可以将消息发送到创建它的 JavaScript 代码, 通过将消息发送到该代码指定的事件处理程序（反之亦然）
  - 适用于那些处理纯数据，或者与浏览器 UI 无关的长时间运行脚本
* 使用位操作
* 不要覆盖原生方法
* 降低 CSS 选择器的复杂性
  - 浏览器读取选择器，遵循的原则是从选择器的右边到左边读取
  - CSS 选择器优先级
    + 选择器越短越好。
    + 尽量使用高优先级的选择器，例如 ID 和类选择器。
    + 避免使用通配符 *
* 使用 flexbox 而不是较早的布局模型
* 使用 transform 和 opacity 属性更改来实现动画
* 合理使用规则，避免过度优化

## 工具

* [pod4g/hiper](https://github.com/pod4g/hiper):🚀 A statistical analysis tool for performance testing
* [raviqqe/muffet](https://github.com/raviqqe/muffet):Fast website link checker in Go
* [coturn/coturn](https://github.com/coturn/coturn):coturn TURN server project
* [codesandbox](https://codesandbox.io):The online code editor for Preact
* [CompuIves/codesandbox-client](https://github.com/CompuIves/codesandbox-client):An online code editor tailored for web application development 🏖️ <https://codesandbox.io>
* [acaudwell/Logstalgia](https://github.com/acaudwell/Logstalgia):replay or stream website access logs as a retro arcade game <https://logstalgia.io>
* record and replay
  - [rrweb-io/rrweb](https://github.com/rrweb-io/rrweb):record and replay the web <https://www.rrweb.io/>
  - [sindresorhus/pageres](https://github.com/sindresorhus/pageres):Capture website screenshots
* [短网址](http://suo.im/)
* [google/pprof](https://github.com/google/pprof):pprof is a tool for visualization and analysis of profiling data
* [GoogleChromeLabs/quicklink](https://github.com/GoogleChromeLabs/quicklink):⚡️Faster subsequent page-loads by prefetching in-viewport links during idle time
* 分析
  - [matomo-org/matomo](https://github.com/matomo-org/matomo):Liberating Web Analytics. Star us on Github? +1. Matomo is the leading open alternative to Google Analytics that gives you full control over your data. Matomo lets you easily collect data from websites, apps & the IoT and visualise this data and extract insights. Privacy is built-in. We love Pull Requests! <https://matomo.org/>
  - [YSlow](http://yslow.org):analyzes web pages and why they're slow based on Yahoo!'s rules for high performance web sites
* 监控
  - [davidkpiano/xstate](https://github.com/davidkpiano/xstate):State machines and statecharts for the modern web. <https://xstate.js.org/docs>
  - [etsy/statsd](https://github.com/etsy/statsd):Daemon for easy but powerful stats aggregation
  - [brendangregg/FlameGraph](https://github.com/brendangregg/FlameGraph):Stack trace visualizer <http://www.brendangregg.com/flamegraphs.html>
  - [Raileo](https://raileo.com/):makes it easy to monitor your website downtime, SSL expiry, website performance, SEO and a lot more
* [the-benchmarker/web-frameworks](https://github.com/the-benchmarker/web-frameworks):Which is the fastest web framework?
* [chaitin/xray](https://github.com/chaitin/xray):一款完善的安全评估工具，支持常见 web 安全问题扫描和自定义 poc | 使用之前务必先阅读文档 <https://xray.cool>
* [zeit](https://zeit.co/)
* [insights](https://developers.google.com/speed/pagespeed/insights/) Analyze with PageSpeed Insights
* [lighthouse](https://github.com/GoogleChrome/lighthouse) Automated auditing, performance metrics, and best practices for the web.<https://developers.google.com/web/tools/lighthouse/>
* [vite](https://github.com/vitejs/vite) Native-ESM powered web dev build tool. It's fast.

## 参考

* [Web-Series](https://github.com/wx-chevalier/Web-Series):📚 现代 Web 开发，现代 Web 开发导论 | 基础篇 | 进阶篇 | 架构优化篇 | React 篇 | Vue 篇 <https://parg.co/bMe>
* [Web](https://developers.google.com/web/)
* [MDN Web Docs](https://developer.mozilla.org):Data and tools related to MDN Web Docs (formerly Mozilla Developer Network, formerly Mozilla Developer Center...)
  - [mdn/learning-area](https://github.com/mdn/learning-area):Github repo for the MDN Learning
* [Web 开发](https://www.ibm.com/developerworks/cn/web/)
* [W3C](https://www.w3.org/)
* [solid/solid](https://github.com/solid/solid):Solid - Re-decentralizing the web (project directory) <https://solid.mit.edu/>

* [WEB开发中需要了解的东西](https://coolshell.cn/articles/6043.html)
* [What technical details should a programmer of a web application consider before making the site public?](https://softwareengineering.stackexchange.com/questions/46716/what-technical-details-should-a-programmer-of-a-web-application-consider-before/46738#46738)
* [5 Tips on Concurrency](https://dzone.com/articles/7-tips-about-concurrency)
* [A Beginner’s Guide to Website Speed Optimization](https://kinsta.com/learn/page-speed/)

* [关于大型网站技术演进的思考](http://blog.jobbole.com/84761/)
* [大型WEB架构设计](https://mp.weixin.qq.com/s?__biz=MzAwNzY4OTgyNA==&mid=2651826002&idx=1&sn=237e6c340626171cf1f4eb6e0f19f182&chksm=8081445db7f6cd4bea29330141ac28228f09c024dd5671cb945171bf41a20d6f1386c455e330)
* [PHP 进阶之路 - 亿级 pv 网站架构实战之性能压榨](https://segmentfault.com/a/1190000010455076)
* [全站缓存](https://segmentfault.com/a/1190000005808789)
<https://zhuanlan.zhihu.com/p/22360384>
<http://tips.codekiller.cn/2017/05/17/maglev_describe/>
<http://developer.51cto.com/art/200807/83518.htm>
<https://help.aliyun.com/document_detail/29322.html>
<http://geek.csdn.net/news/detail/237188>
