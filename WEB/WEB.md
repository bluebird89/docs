# [Web](https://developer.mozilla.org/zh-CN/docs/Learn/Getting_started_with_the_web)

系统的健壮性、 可用性：原则是要保护系统，不能让所有用户都失败。直接抛弃一半请求

* 性能
  - 网页中代码真实的运行速度
  - 用户在使用时感受到的速度
* HTML 语言定义网页的结构和内容，CSS 样式表定义网页的样式，JavaScript 语言定义网页与用户的互动行为

## 架构

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

* 产生压力的方法有很多
  - 写脚本产生压力机器人对服务器进行发包和收包操作
  - 使用现有的工具(像jmeter、LoadRunner这些python的FunkLoad）大的压力测试用 erlang开发的tsung
  - 难点在于产生的压力是不是真实地反映了实际用户的操作场景。举个例子来说，对游戏来说单纯的并发登陆场景在整个线上环境中的占比可能并不大(新开服等特殊情况除外)，相反"登陆-开始战斗-结束战斗"、不同用户执行不同动作这种"混合模式"占了更大的比重。所以如何从实际环境中提炼出具体的场景比重，并且把这种比重转化成实际压力是一个重要的关注点。
* 产生压力之后，通常我们可以拿到TPS、响应时延等性能数据，那么如何定位性能问题呢？
  - TPS、响应时延只能告诉你服务器是否存在问题，但不能帮助你定位问题。这些表面背后是整个后台处理逻辑综合作用的结果，这时候可以先关注系统的CPU、内存、IO、网络，对比在tps、时延达到瓶颈时这些系统数据的情况，确定性能问题是系统哪一部分造成的，然后再回到代码的逻辑中逐个优化这些点。
* 当服务器的整体性能就可以相对稳定下来，这时候就需要对自己服务器的承载能力有一个预估，通过产生真实压力、对比系统数据，大致可以对单套系统的处理能力有个真实的评价，然后结合业务规模配置服务器数量。
* 压力测试的目标：是搞死服务器，从而找到瓶颈点，如果搞不死，意义就不大

## 大流量

* 对常用功能建立缓存模块
* 网页尽量静态化
* 使用单独的图片服务器，降低服务器压力，使其不会因为图片加载造成崩溃
* 使用镜像解决不同网络接入商和不同地域用户访问差异
* 数据库集群图表散列
* 加强网络层硬件配置，硬的不行来软的。
* 终极办法：负载均衡

servlet其实并不底层，http报文本质上就是一个字符串，容器承担了解析这个字符串的功能，解的快不快，解的好不好你也不知道，而struts，spring等都是基于这个字符串解析之上的外围打杂框架。

要想达到要非常少的机器扛住大规模的并发，可能需要抛弃servlet，直接用netty或者nio参考v8，nodejs，tornado等直接构建非阻塞的异步协程socket服务器

## 大访问量

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
* 网络界最核心最重要的为数据的积累。这里我们先明确三个概念：
  + 负载均衡：服务器都是激活的，并且是轮循的。
  + 冗余技术：一个激活，其它的备份处于休眠状态。
  + Mysql主从：依赖于Binary Log日志（记载CRUD，作用是恢复数据），主服务器的所有增删改的操作同时会备份复制一份给从服务器，让服务器同时执行，达到和主服务器的数据的同步和完整，它的重点是主服务器和从服务器都可以同时活动，即操作Mysql数据库时，增删改走都是主服务器，而查询走的是从服务器。所以，主从为负载的技术。
* MySQL相关操作
  - Mysql 分库分表
    + 垂直分表（字段不要太多，把一张大表竖切为许多小表）
    + 水平分表（把一张大表横切为若干小表）
  - Mysql 分区技术:分区技术将一个表拆成多个表，比较常用的方式是将表中的记录按照某种Hash算法进行拆分，简单的拆分方法如取模方式。在一定的层面表名不变，在真正的磁盘存储时存储在不同的分区
  - Mysql 集群;单点故障时，冗余备份

## 加速技术

* Squid 代理缓存技术（Squid：乌鱼）反向缓存-动静分离:Squid是一款用来做代理服务器的软件。作用是动静分离，将数据保存在缓存池中Squid cache，能够代理服务器执行。代理服务器就如同买火车票，去火车票代理售票点，买票，而不是去火车站，这样就减少了火车站的压力，提高了速度。
* 页面静态化缓存
* Memcache,Redis:Memcache 是一个高性能的分布式的内存对象缓存系统，目前全世界不少人使用这个缓存项目来构建自己大负载的网站，来分担数据库的压力，通过在内存里维护一个统一的巨大的hash表，它能够用来存储各种格式的数据，包括图像、视频、文件以及数据库检索的结果等。简单的说就是将数据调用到内存中，然后从内存中读取，从而大大提高读取速度。(注: 摘自百度全科)
* Sphinx 搜索加速:phinx全文索引,Sphinx 是一个基于SQL的全文检索引擎，可以结合MySQL，PostgreSQL作全文搜索，它可以提供比数据库本身更专业的搜索功能，使得应用程序更容易实现专业化的全文检索。

## 监控

* 服务监控
  - apache web 服务监控
  - mysql 数据库监控
  - 磁盘空间监控
* 流量监控:网站流量监控（网卡进入的数据量和网卡流出的数据量成比例）
  - 监控的好处：只有监控才知道问题，有了问题才能改进
  - 要监管，先要建立网络管理协议，被监控的服务器全部开放smp，161端口，
  - 监控者监控被监控者，mrtg监控图。
  - cacti监控原理
  - Cacti 监测系统的工作原理

## 安全

* 常见的比如数据库安全，主要是 SQL 注入，前端 XSS 注入攻击，以及提交请求时 CSRF 攻击  DDoS 攻击、恶意爬取页面如何防护（限制 IP 等）、用户认证/授权安全如何保证（密码、令牌安全等）
* 永远不要相信用户的输入（包括Cookies，因为那也是用户的输入）
* 对用户的口令进行Hash，并使用salt，以防止Rainbow 攻击
  - Hash算法可用MD5或SHA1等
  - 对口令使用salt的意思是，user 在设定密码时，system 产生另外一个random string(salt)。在datbase 存的​​是与salt + passwd 产的md5sum 及salt
  - 当要验证密码时就把user 输入的string 加上使用者的salt，产生md5s​​um 来比对。 理论上用salt 可以大幅度让密码更难破解，相同的密码除非刚好salt 相同，最后​​存在database 上的内容是不一样的。google一下md5+salt你可以看到很多文章
  - 关于Rainbow 攻击，其意思是很像密码字典表，但不同的是，Rainbow Table存的是已经被Hash过的密码了，而且其查找密码的速度更快，这样可以让攻击非常快）。使用慢一点的Hash算法来保存口令，如 bcrypt (被时间检证过了) 或是 scrypt (更强，但是也更新一些) (1, 2)。你可以阅读一下 How To Safely Store A Password（陈皓注：酷壳以前曾介绍过bcrypt这个算法，这里，我更建议我们应该让用户输入比较强的口令，比如Apple ID注册的过程需要用户输入超过8位，需要有大小写和数字的口令，或是做出类似于这样的用户体验的东西）。
* 不要试图自己去发明或创造一个自己的[fancy的认证系统](https://stackoverflow.com/questions/1581610/how-can-i-store-my-users-passwords-safely/1581919#1581919)，你可能会忽略到一些不容易让你查觉的东西而导致你的站点被hack了。（陈皓注：我在腾讯那坑爹的申诉系统中说过这个事了，我说过这句话——“真正的安全系统是协同整个社会的安全系统做出来的一道安全长城，而不是什么都要自己搞”，当然，很遗憾不是所有的人都能看懂这个事，包括一些资深的人）
* 了解 [处理信用卡的一些规则](https://www.pcisecuritystandards.org/) . ([这里也有一个问题你可以查看一下](https://stackoverflow.com/questions/51094/payment-processors-what-do-i-need-to-know-if-i-want-to-accept-credit-cards-on)) （有两上vendor可以帮助你，一个是 Authorize.Net 另一个是 PayFlow Pro）
* 使用 SSL/HTTPS 来加密传输登录页面或是任可有敏感信息的页面，比如信用卡号等
* [Session Hijacking](https://en.wikipedia.org/wiki/Session_hijacking)
* 保持系统里所有软件更新到最新的patch
* 确保数据库连接是安全的
* 确保了解最新的攻击技术，以及系统的脆弱处
* XSS 跨站脚本攻击（Cross-Site Scripting）：浏览器错误的将攻击者提供的用户输入数据（表单提交或URL参数）当做JavaScript脚本给执行了
  - 看见输入框就输入：` /><script>alert("xss")</script> ` 进行提交
  - JS 代码被执行后果
    + 偷走用户浏览器里的 Cookie；
    + 通过浏览器的记住密码功能获取到你的站点登录账号和密码；
    + 盗取用户的机密信息；
    + 你的用户在站点上能做到的事情，有了 JS 权限执行权限就都能做，也就是说 A 用户可以模拟成为任何用户；
    + 在网页中嵌入恶意代码；
  - 解决
    + 对数据进行严格的输出编码，使得攻击者提供的数据不再被浏览器认为是脚本而被误执行
    + 编码需要根据输出数据所在的上下文来进行相应的编码，HTML编码 URL编码 JavaScript编码、CSS编码、HTML属性编码、JSON编码
    + 对style、script、image、src、a等等不安全的因素进行过滤或转义(htmlentities htmlspecialchars  strip_tags() 函数来去除 HTML 标签或者使用 htmlentities() 或是 htmlspecialchars())，smarty twig 都会默认为输出加上 htmlentities 防范
    + 将cookie设置成HTTP-only:禁止客户端操作cookie
    + [BeEF](https://beefproject.com/)
* SQL 注入 Injection：通过把SQL命令插入到Web表单提交或输入域名或页面请求的查询字符串，最终达到欺骗服务器执行恶意的SQL命令。 `SELECT * FROM users WHERE username = 'peter' OR '1' = '1'`
  - 解决
    + 转义用户输入的数据 addslashes 和 mysql_real_escape_string 这种转义是不安全的
    + 使用封装好的语句,使用PDO 或 MySQLi 的数据库扩展
    + 工具 [SQLmap](http://sqlmap.org/)
* iframe带来的风险：需要用到第三方提供的页面组件，通常会以iframe的方式引入：添加第三方提供的广告、天气预报、社交分享插件等等。可以在iframe中运行JavaScirpt脚本、Flash插件、弹出对话框等等，这可能会破坏前端用户体验
  - 如果iframe中的域名因为过期而被恶意攻击者抢注，或者第三方被黑客攻破，iframe中的内容被替换掉了，从而利用用户浏览器中的安全漏洞下载安装木马、恶意勒索软件等等
  - 解决
    + 在HTML5中，iframe有了一个叫做sandbox的安全属性，通过它可以对iframe的行为进行各种限制，充分实现“最小权限“原则。使用sandbox的最简单的方式就是只在iframe元素中添加上这个关键词就好 `<iframe sandbox src="..."> ... </iframe>`
    + sandbox还忠实的实现了“Secure By Default”原则，也就是说，如果你只是添加上这个属性而保持属性值为空，那么浏览器将会对iframe实施史上最严厉的调控限制，基本上来讲就是除了允许显示静态资源以外，其他什么都做不了。比如不准提交表单、不准弹窗、不准执行脚本等等，连Origin都会被强制重新分配一个唯一的值，换句话讲就是iframe中的页面访问它自己的服务器都会被算作跨域请求。
    + sandbox也提供了丰富的配置参数，我们可以进行较为细粒度的控制。一些典型的参数如下：
      * allow-forms：允许iframe中提交form表单
      * allow-popups：允许iframe中弹出新的窗口或者标签页（例如，window.open()，showModalDialog()，target=”_blank”等等）
      * allow-scripts：允许iframe中执行JavaScript
      * allow-same-origin：允许iframe中的网页开启同源策略
* ClickJacking（点击劫持）：在通过iframe使用别人提供的内容时，自己的页面也可能正在被不法分子放到他们精心构造的iframe或者frame当中，进行点击劫持攻击，攻击利用了受害者的用户身份，在其不知情的情况下进行一些操作，删除某个重要文件记录，或者窃取敏感信息
  - 步骤
    + 攻击者精心构造一个诱导用户点击的内容，比如Web页面小游戏
    + 将我们的页面放入到iframe当中
    + 利用z-index等CSS样式将这个iframe叠加到小游戏的垂直方向的正上方
    + 把iframe设置为100%透明度
    + 受害者访问到这个页面后，肉眼看到的是一个小游戏，如果受到诱导进行了点击的话，实际上点击到的却是iframe中的我们的页面
  - 解决
    + Frame Breaking方案
    + 使用X-Frame-Options：DENY这个HTTP Header来明确的告知浏览器，不要把当前HTTP响应中的内容在HTML Frame中显示出来
* 错误的内容推断
  - 攻击者在上传图片的时候，看似提交的是个图片文件，实则是个含有JavaScript的脚本文件
  - 后端服务器在返回的响应中设置的Content-Type Header仅仅只是给浏览器提供当前响应内容类型的建议，而浏览器有可能会自作主张的根据响应中的实际内容去推断内容的类型。
  - 解决
    + 通过设置X-Content-Type-Options参数值为nosniff 这个HTTP Header明确禁止浏览器去推断响应类
* SSRF（Server-Side Request Forgery：服务器端请求伪造）：通过注入恶意代码从服务端发起，通过服务端就再访问内网的系统，然后获取不该获取的数据
  - 产生在包含这些方法的代码中，比如 curl、file_get_contents、fsockopen
    + curl 中 `http://www.xxx.com/demo.php?url=file:///etc/passwd`
  - 解决
    + LFI （本地文件包含） 是一个用户未经验证从磁盘读取文件的漏洞 include
    + 对 curl、file_get_contents、fsockopen、这些方法中的参数进行严格验证！
    + 限制协议只能为HTTP或HTTPS，禁止进行跳转。
    + 如果有白名单，解析参数中的URL，判断是否在白名单内。
    + 如果没有白名单，解析参数中的URL，判断是否为内网IP。
* CSRF（Cross-site request forgery：跨站请求伪造）：攻击者通过伪装成受信任的用户，盗用受信任用户的身份，用受信任用户的身份发送恶意请求
  - 解决
    + 服务端生成一个 CSRF 令牌加密安全字符串Token传递给用户，并将 Token 存储于 Cookie 或者 Session 中,在网页构造表单时，将 Token 令牌放在表单中的隐藏字段，表单请求服务器以后会根据用户的 Cookie 或者 Session 里的 Token 令牌比对，校验成功才给予通过
    + 对于不确定是否有csrf风险的请求，可以使用验证码（尽管体验会变差）
    + 对于一些重要的操作（修改密码、修改邮箱），必须使用二次验证
    + 利用HTTP头中的Referer判断请求来源是否合法
* 文件上传：上传了一个可执行的文件到服务器上执行
  - 解决
    + 文件扩展名检测
    + 文件 MIME 验证
    + 文件重命名
    + 文件目录设置不可执行权限
    + 设置单独域名的文件服务器
* HTTPS也可能掉坑里：浏览器发出去第一次请求就被攻击者拦截了下来并做了修改，根本不给浏览器和服务器进行HTTPS通信的机会
  - 用户在浏览器里输入URL的时候往往不是从https://开始的，而是直接从域名开始输入，随后浏览器向服务器发起HTTP通信，然而由于攻击者的存在，它把服务器端返回的跳转到HTTPS页面的响应拦截了，并且代替客户端和服务器端进行后续的通信
  - 解决
    + 使用HSTS（HTTP Strict Transport Security），它通过HTTP Header以及一个预加载的清单，来告知浏览器在和网站进行通信的时候强制性的使用HTTPS，而不是通过明文的HTTP进行通信 `Strict-Transport-Security: max-age=<seconds>; includeSubDomains; preload`
* 信息泄露：敏感数据泄露
  - 本地存储数据泄露:前端存储敏感、机密信息始终都是一件危险的事情，推荐的做法是尽可能不在前端存这些数据
  - 解决
    + 敏感数据脱敏（比如手机号、身份证、邮箱、地址）
    + 服务器上不允许提交包含打印 phpinfo 、$_SERVER 和 调试信息等代码。
    + 定期从开源平台扫描关于企业相关的源码项目
    + 密码加密
      * 哈希（Hash）是将目标文本转换成具有相同长度的、不可逆的杂凑字符串（或叫做消息摘要)
      * 加密（Encrypt）是将目标文本转换成具有不同长度的、可逆的密文
      * 加盐处理避免了两个同样的密码会产生同样哈希的问题， bcrypt
* 中间人攻击：MITM （中间人） 攻击不是针对服务器直接攻击，而是针对用户进行，攻击者作为中间人欺骗服务器他是用户，欺骗用户他是服务器，从而来拦截用户与网站的流量，并从中注入恶意内容或者读取私密信息，通常发生在公共 WiFi 网络中，也有可能发生在其他流量通过的地方，例如ISP运营商。
  - 解决
    + 使用 HTTPS，使用 HTTPS 可以将你的连接加密，并且无法读取或者篡改流量。
    + WEB 服务器配置加上 Strict-Transport-Security 标示头，此头部信息告诉浏览器，你的网站始终通过 HTTPS 访问，如果未通过 HTTPS 将返回错误报告提示浏览器不应显示该页面。 需要到 https://hstspreload.org 注册网站，
* 不安全的第三方依赖包
  - 自动化的工具可以使用，比如NSP(Node Security Platform)，Snyk等等
  - 静态资源完整性校验
    + 每个资源文件都可以有一个SRI值。它由两部分组成，减号（-）左侧是生成SRI值用到的哈希算法名，右侧是经过Base64编码后的该资源文件的Hash值。 <script src=“https://example.js” integrity=“sha384-eivAQsRgJIi2KsTdSnfoEGIRTo25NCAqjNJNZalV63WKX3Y51adIzLT4So1pk5tX”></script>
* DDoS 分布式拒绝服务，Distributed Denial of Service，其原理就是利用大量的请求造成资源过载，导致服务不可用
  - 网络层 DDoS
    + SYN Flood：当攻击方随意构造源 IP 去发送 SYN 包时，服务器返回的 SYN + ACK 就不能得到应答（因为 IP 是随意构造的），此时服务器就会尝试重新发送，并且会有至少 30s 的等待时间，导致资源饱和服务不可用，此攻击属于慢型 DDoS 攻击
    + ACK Flood：在 TCP 连接建立之后，所有的数据传输 TCP 报文都是带有 ACK 标志位的，主机在接收到一个带有 ACK 标志位的数据包的时候，需要检查该数据包所表示的连接四元组是否存在，如果存在则检查该数据包所表示的状态是否合法，然后再向应用层传递该数据包
    + UDP Flood：攻击者可以伪造大量的源 IP 地址去发送 UDP 包，UDP 包双向流量会基本相等，因此发起这种攻击的攻击者在消耗对方资源的时候也在消耗自己的资源。 此种攻击属于大流量攻击
    + ICMP Flood：不断发送不正常的 ICMP 包（所谓不正常就是 ICMP 包内容很大），导致目标带宽被占用，但其本身资源也会被消耗
    + 防御
      * 网络架构上做好优化，采用负载均衡分流。
      * 确保服务器的系统文件是最新的版本，并及时更新系统补丁。
      * 添加抗 DDos 设备，进行流量清洗。
      * 限制同时打开的 SYN 半连接数目，缩短 SYN 半连接的 Timeout 时间。
      * 限制单 IP 请求频率。
      * 防火墙等防护设置禁止 ICMP 包等。
      * 严格限制对外开放的服务器的向外访问。
      * 运行端口映射程序或端口扫描程序，要认真检查特权端口和非特权端口。
      * 关闭不必要的服务。
      * 认真检查网络设备和主机/服务器系统的日志。只要日志出现漏洞或是时间变更,那这台机器就可能遭到了攻击。
      * 限制在防火墙外与网络文件共享。这样会给黑客截取系统文件的机会，主机的信息暴露给黑客，无疑是给了对方入侵的机会。
  - 应用层 DDoS:在网络应用层耗尽你的带宽
    + CC 攻击(Challenge Collapasar):针对消耗资源比较大的页面不断发起不正常的请求，导致资源耗尽
    + DNS Flood 攻击采用的方法是向被攻击的服务器发送大量的域名解析请求，通常请求解析的域名是随机生成或者是网络世界上根本不存在的域名，被攻击的DNS 服务器在接收到域名解析请求的时候首先会在服务器上查找是否有对应的缓存，如果查找不到并且该域名无法直接由服务器解析的时候，DNS 服务器会向其上层 DNS 服务器递归查询域名信息。域名解析的过程给服务器带来了很大的负载，每秒钟域名解析请求超过一定的数量就会造成 DNS 服务器解析域名超时。一台 DNS 服务器所能承受的动态域名查询的上限是每秒钟 9000 个请求
    + HTTP 慢速连接攻击:建立起 HTTP 连接，设置一个较大的 Conetnt-Length，每次只发送很少的字节，让服务器一直以为 HTTP 头部没有传输完成，这样连接一多就很快会出现连接耗尽。
    + 防御
      * 判断 User-Agent 字段（不可靠，因为可以随意构造）
      * 针对 IP + cookie，限制访问频率（由于 cookie 可以更改，IP 可以使用代理，或者肉鸡，也不可靠)
      * 关闭服务器最大连接数等，合理配置中间件，缓解 DDoS 攻击。
      * 请求中添加验证码，比如请求中有数据库操作的时候。
      * 编写代码时，尽量实现优化，并合理使用缓存技术，减少数据库的读取操作。

* 流量劫持

  - DNS 劫持:如果当用户通过某一个域名访问一个站点的时候，被篡改的 DNS 服务器返回的是一个恶意的钓鱼站点的 IP，用户就被劫持到了恶意钓鱼站点
    + 要不就是网络运营商搞的鬼，一般小的网络运营商与黑产勾结会劫持 DNS，要不就是电脑中毒，被恶意篡改了路由器的 DNS 配置
    + 应对
      * 取证很重要，时间、地点、IP、拨号账户、截屏、URL 地址等一定要有。
      * 可以跟劫持区域的电信运营商进行投诉反馈。
      * 如果投诉反馈无效，直接去工信部投诉，一般来说会加白你的域名。
  - HTTP 劫持：当用户访问某个站点的时候会经过运营商网络，而不法运营商和黑产勾结能够截获 HTTP 请求返回内容，并且能够篡改内容，然后再返回给用户，从而实现劫持页面，轻则插入小广告，重则直接篡改成钓鱼网站页面骗用户隐私。
    + 根本原因，是 HTTP 协议没有办法对通信对方的身份进行校验以及对数据完整性进行校验

* 服务器漏洞

  - 越权操作：涉及到数据库的操作都需要先进行严格的验证
  - 目录遍历漏洞：通过在 URL 或参数中构造 ../，./ 和类似的跨父目录字符串的 ASCII 编码、unicode 编码等，完成目录跳转，读取操作系统各个目录下的敏感文件
    + 需要对 URL 或者参数进行 ../，./ 等字符的转义过滤
  - 源码暴露漏洞：

* 设计缺陷

  - 返回信息过多：不要返回 用户已被禁用，统一返回 用户名或密码错误
  - 短信接口
    + 设置同一手机号短信发送间隔
    + 设置每个IP地址每日最大发送量
    + 设置每个手机号每日最大发送量
    + 升级验证码，采用滑动拼图、文字点选、图表点选...
    + 升级短信接口的验证方法

```php
$username = $_GET['username'];
$query = $pdo->prepare('SELECT * FROM users WHERE username = :username');
$query->execute(['username' => $username]);
$data = $query->fetch();

//user signup
$password = $_POST['password'];
$hashedPassword = password_hash($password, PASSWORD_DEFAULT);

//login
$password = $_POST['password'];
$hash = '1234'; //load this value from your db

if(password_verify($password, $hash)) {
  echo 'Password is valid!';
} else {
  echo 'Invalid password.';
}
```

## SSO（Single Sign On，单点登录）

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

简单的浏览器 F12查看 Network 标签页就可以进行简单分析

如果是加载前端资源太慢 比如图片、样式文件、脚本文件 可以考虑加带宽或者用 CDN 来加载这些静态资源 CDN 效果杠杠的 但是图片的压缩和缩略图还是要做 针对不同场景显示不同尺寸图片 不然 CDN 按流量收费 能省则省 样式文件或者脚本文件如果过大 则该拆分拆分 反之如果都是分散的小文件 则该合并合并 更深入点还可以通过设置请求头/响应头字段设置浏览器缓存

如果是后端接口问题，则需要借助工具进行细分，基础设施方面，是否是 DNS 域名解析慢 网络请求时间长，通常这在服务器放在国外的情况下比较常见，排除了这个问题，还要看看服务器负载，CPU、内存、带宽、磁盘空间是否充沛，这些资源的不足或者打满都会造成服务器响应慢，这些东西不足则要补足，要查明原因，是否有异常或恶意攻击，如果是这种原因则要处理掉这些异常流量和问题，如果确实是用户请求量大，则要对服务器扩容，设置集群，当然这个服务器涉及多种应用，后面我们再细谈

基础设施没有问题，再往下看，需要从应用入口开始分析，是什么原因导致响应慢，代码问题？数据库问题？还是系统资源问题？如果是代码问题修复代码，数据库层面分析是否存在慢查询，慢查询可以通过优化索引解决，并且合理设置缓存来减少对数据库的IO 操作，或者引入搜索引擎实现宽表查询，如果数据库压力还是大，可以考虑读写分离、分库分表之类的后续分布式数据库解决方案，如果并发量大，缓存服务也扛不住，则把缓存拆分出去通过独立服务器进行操作，甚至构建分布式缓存，诸如此类，如果是单机 php-fpm 进程跑满，可以对 web 应用服务器进行扩容，然后做负载均衡，如果是单线程 IO 问题，考虑通过队列异步处理，或者引入 Swoole 提高系统并发性，等等。

* 只要需要，请实现cache机制，了解并合理地使用 HTTP caching 以及 HTML5 Manifest.
* 优化页面 —— 不要使用20KB图片来平铺网页背景。（陈皓注：还有很多网页页面优化性的文章，你可以STFG – Search The Fucking Google一下。如果你要调试的话，你可以使用firebug或是chrome内置的开发人员的工具来查看网页装载的性能）
* 学习如何 gzip/deflate 网页 (deflate 更好).
* 把多个CSS文件和Javascript文件合并成一个，这样可以减少浏览器的网络连数，并且使用gzip压缩被反复用到的文件。
* 学习一下 Yahoo Exceptional Performance 这个网站上的东西，上面有很多非常不错的改善前端性能的指导，以及 YSlow 这个工具。 Google page speed 是另一个用来做性能采样的工具。这两个工具都需要安装 Firebug 。
* 为那些小的图片使用 CSS Image Sprites，就像工具条一样。 (参看 “最小化 HTTP 请求” ) （陈皓注：把所有的小图片合并成一个图片，然后用CSS把显示其中的一块，这样，这些小图片只用传输一次，酷壳的Wordpress样式的那个RSS订阅列表中的小图标就是这样做的）
* 繁忙的网络应该考虑把网页的内容分开存放在不同的域名下。（陈皓注：比如有专门的图片服务器——图片相当耗带宽，或是专门的Ajax服务器）
* 静态网页 (如，图片，CSS，JavaScript，以及一些不需要访问cookies的网页) 应该放在一个不使用cookies的独立的域名下，因为所有在同一个域名或子域名下的cookie会被这个域名下的请求一同发送。另一个好的选择是使用 Content Delivery Network (CDN).
* 使用单个页面的HTTP请求数最小化。
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
  - 理解网页上的JavaScript文件、样式表文件和其他资源是如何装载及运行的，考虑它们对页面性能有何影响。在某些情况下，可能应该将脚本文件放置在网页的尾部。
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

## 趋势

* PWA
* 客服聊天机器人
* 静态网页的再流行原因有很多，他们更快、更安全，也更便宜
* 单页应用。这项技术可以将所有内容放入一个长长的滚动页中，移除不需要的冗余内容
* 网页消息推送
* Flash的一个致命弱点是他无法在移动设备中使用，HTML播放器Chimee

## 课程

* [深入浅出现代Web编程](https://fullstackopen.com/zh)

## 工具

* [CompuIves/codesandbox-client](https://github.com/CompuIves/codesandbox-client):An online code editor tailored for web application development 🏖️ https://codesandbox.io
* [pod4g/hiper](https://github.com/pod4g/hiper):🚀 A statistical analysis tool for performance testing
* [raviqqe/muffet](https://github.com/raviqqe/muffet):Fast website link checker in Go
* [coturn/coturn](https://github.com/coturn/coturn):coturn TURN server project
* [codesandbox](https://codesandbox.io):The online code editor for Preact
* [acaudwell/Logstalgia](https://github.com/acaudwell/Logstalgia):replay or stream website access logs as a retro arcade game https://logstalgia.io
* 压力测试
  - apache AB
  - webbench
* record and replay
  - [rrweb-io/rrweb](https://github.com/rrweb-io/rrweb):record and replay the web https://www.rrweb.io/
  - [sindresorhus/pageres](https://github.com/sindresorhus/pageres):Capture website screenshots
* [缩短网址](http://suo.im/)
* [google/pprof](https://github.com/google/pprof):pprof is a tool for visualization and analysis of profiling data
* [GoogleChromeLabs/quicklink](https://github.com/GoogleChromeLabs/quicklink):⚡️Faster subsequent page-loads by prefetching in-viewport links during idle time
* 分析
  - [matomo-org/matomo](https://github.com/matomo-org/matomo):Liberating Web Analytics. Star us on Github? +1. Matomo is the leading open alternative to Google Analytics that gives you full control over your data. Matomo lets you easily collect data from websites, apps & the IoT and visualise this data and extract insights. Privacy is built-in. We love Pull Requests! https://matomo.org/
  - [YSlow](http://yslow.org):analyzes web pages and why they're slow based on Yahoo!'s rules for high performance web sites
* 监控
  - [davidkpiano/xstate](https://github.com/davidkpiano/xstate):State machines and statecharts for the modern web. https://xstate.js.org/docs
  - [etsy/statsd](https://github.com/etsy/statsd):Daemon for easy but powerful stats aggregation
  - [brendangregg/FlameGraph](https://github.com/brendangregg/FlameGraph):Stack trace visualizer http://www.brendangregg.com/flamegraphs.html
  - [Raileo](https://raileo.com/):makes it easy to monitor your website downtime, SSL expiry, website performance, SEO and a lot more
* [the-benchmarker/web-frameworks](https://github.com/the-benchmarker/web-frameworks):Which is the fastest web framework?
* [chaitin/xray](https://github.com/chaitin/xray):一款完善的安全评估工具，支持常见 web 安全问题扫描和自定义 poc | 使用之前务必先阅读文档 https://xray.cool
* [zeit](https://zeit.co/)

## 参考

* [wx-chevalier/Web-Series](https://github.com/wx-chevalier/Web-Series):📚 现代 Web 开发，现代 Web 开发导论 | 基础篇 | 进阶篇 | 架构优化篇 | React 篇 | Vue 篇 https://parg.co/bMe
* [Web](https://developers.google.com/web/)
* [Web](https://developer.mozilla.org/zh-CN/docs/Web)
* [MDN Web Docs](https://developer.mozilla.org):Data and tools related to MDN Web Docs (formerly Mozilla Developer Network, formerly Mozilla Developer Center...)
* [Web 开发](https://www.ibm.com/developerworks/cn/web/)
* [W3C](https://www.w3.org/)
* [solid/solid](https://github.com/solid/solid):Solid - Re-decentralizing the web (project directory) https://solid.mit.edu/
* [mdn/learning-area](https://github.com/mdn/learning-area):Github repo for the MDN Learning Area. https://developer.mozilla.org/en-US/docs/Learn
* [WEB开发中需要了解的东西](https://coolshell.cn/articles/6043.html)
* [What technical details should a programmer of a web application consider before making the site public?](https://softwareengineering.stackexchange.com/questions/46716/what-technical-details-should-a-programmer-of-a-web-application-consider-before/46738#46738)
* [5 Tips on Concurrency](https://dzone.com/articles/7-tips-about-concurrency)
* [A Beginner’s Guide to Website Speed Optimization](https://kinsta.com/learn/page-speed/)

* [关于大型网站技术演进的思考](http://blog.jobbole.com/84761/)
* [大型WEB架构设计](https://mp.weixin.qq.com/s?__biz=MzAwNzY4OTgyNA==&mid=2651826002&idx=1&sn=237e6c340626171cf1f4eb6e0f19f182&chksm=8081445db7f6cd4bea29330141ac28228f09c024dd5671cb945171bf41a20d6f1386c455e330)
* [PHP 进阶之路 - 亿级 pv 网站架构实战之性能压榨](https://segmentfault.com/a/1190000010455076)
* [全站缓存](https://segmentfault.com/a/1190000005808789)
* 《构建高性能Web站点》第12章 web负载均衡
* 《大型网站技术架构：核心原理与案例分析》 6.2 应用服务器集群的伸缩性设计
<https://zhuanlan.zhihu.com/p/22360384>
<http://tips.codekiller.cn/2017/05/17/maglev_describe/>
<http://developer.51cto.com/art/200807/83518.htm>
<https://help.aliyun.com/document_detail/29322.html>
<http://geek.csdn.net/news/detail/237188>
