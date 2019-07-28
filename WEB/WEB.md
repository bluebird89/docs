# Web

系统的健壮性、 可用性：原则是要保护系统，不能让所有用户都失败。直接抛弃一半请求

## 结构

* 应用程序层
* 数据库层
* UI 层

## 压力测试

* 首先说一下如何产生压力，产生压力的方法有很多，通常可以写脚本产生压力机器人对服务器进行发包和收包操作，也可以使用现有的工具(像jmeter、LoadRunner这些），所以说产生压力其实并不难，难点在于产生的压力是不是真实地反映了实际用户的操作场景。举个例子来说，对游戏来说单纯的并发登陆场景在整个线上环境中的占比可能并不大(新开服等特殊情况除外)，相反"登陆-开始战斗-结束战斗"、不同用户执行不同动作这种"混合模式"占了更大的比重。所以如何从实际环境中提炼出具体的场景比重，并且把这种比重转化成实际压力是一个重要的关注点。
* 产生压力之后，通常我们可以拿到TPS、响应时延等性能数据，那么如何定位性能问题呢？TPS、响应时延只能告诉你服务器是否存在问题，但不能帮助你定位问题。这些表面背后是整个后台处理逻辑综合作用的结果，这时候可以先关注系统的CPU、内存、IO、网络，对比在tps、时延达到瓶颈时这些系统数据的情况，确定性能问题是系统哪一部分造成的，然后再回到代码的逻辑中逐个优化这些点。
* 当服务器的整体性能就可以相对稳定下来，这时候就需要对自己服务器的承载能力有一个预估，通过产生真实压力、对比系统数据，大致可以对单套系统的处理能力有个真实的评价，然后结合业务规模配置服务器数量。

- 单机的压力测试(包括functional test)，我平时都用python的FunkLoad
- 遇到大的压力测试，使用erlang开发的tsung会比较好，可以分布式测试，他们都是open source的
- 压力测试的目标，是搞死服务器，从而找到瓶颈点，如果搞不死，意义就不大

## 大流量

- 对常用功能建立缓存模块
- 网页尽量静态化
- 使用单独的图片服务器，降低服务器压力，使其不会因为图片加载造成崩溃
- 使用镜像解决不同网络接入商和不同地域用户访问差异
- 数据库集群图表散列
- 加强网络层硬件配置，硬的不行来软的。
- 终极办法：负载均衡

servlet其实并不底层，http报文本质上就是一个字符串，容器承担了解析这个字符串的功能，解的快不快，解的好不好你也不知道，而struts，spring等都是基于这个字符串解析之上的外围打杂框架。

要想达到要非常少的机器扛住大规模的并发，可能需要抛弃servlet，直接用netty或者nio参考v8，nodejs，tornado等直接构建非阻塞的异步协程socket服务器

## 性能

* 网页中代码真实的运行速度
* 用户在使用时感受到的速度

### 秒杀系统

问题：读写冲突，锁非常严重，这是秒杀业务难的地方。

#### 方案

- 将请求尽量拦截在系统上游（不要让锁冲突落到数据库上去）
- 充分利用缓存（缓存抗读压力），典型的读多些少的应用场景，大部分请求是车次查询，票查询，下单和支付才是写请求。

#### 方法

##### 浏览器层（限速）

- 客户端：产品层面，用户点击"查询"或者"购票"后，按钮置灰，禁止用户重复提交请求；
- JS层面，限制用户在x秒之内只能提交一次请求；

##### 站点层（按照uid做限速，做页面缓存）

- 防止程序员写for循环调用:对uid进行请求计数和去重,5s只透过一个请求，其余的请求怎么办？缓存，页面缓存，同一个uid，限制访问频度，做页面缓存，x秒内到达站点层的请求，均返回同一页面。同一个item的查询，例如车次，做页面缓存，x秒内到达站点层的请求，均返回同一页面。如此限流，既能保证用户有良好的用户体验（没有返回404）又能保证系统的健壮性（利用页面缓存，把请求拦截在站点层了）。

##### 服务层

- 对于写请求，做请求队列，每次只透有限的写请求去数据层（下订单，支付这样的写业务）
- 读请求，怎么优化？cache抗，不管是memcached还是redis，单机抗个每秒10w应该都是没什么问题的。
- 分时分段售票：将流量摊匀
- 数据粒度的优化：你去购票，对于余票查询这个业务，票剩了58张，还是26张，你真的关注么，其实我们只关心有票和无票？流量大的时候，做一个粗粒度的"有票""无票"缓存即可。
- 一些业务逻辑的异步：例如下单业务与 支付业务的分离

给我们抢票的启示是，开动秒杀后，45分钟之后再试试看，说不定又有票哟~ [秒杀系统架构优化思路](https://mp.weixin.qq.com/s?__biz=MjM5ODYxMDA5OQ==&mid=2651959391&idx=1&sn=fb28fd5e5f0895ddb167406d8a735548)

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
* LVS集群采用三层结构，负载调度器、服务器池、共享存储主要组成。
* 构架师来运营一家公司的网站必须考虑的三个问题
    *网络构架
    *服务器构架
    *应用程序开发

## 大数据存储

* 目前有四种主流的数据库：
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

## 网站加速技术

* Squid 代理缓存技术（Squid：乌鱼）反向缓存-动静分离:Squid是一款用来做代理服务器的软件。作用是动静分离，将数据保存在缓存池中Squid cache，能够代理服务器执行。代理服务器就如同买火车票，去火车票代理售票点，买票，而不是去火车站，这样就减少了火车站的压力，提高了速度。
* 页面静态化缓存
* Memcache,Redis:Memcache 是一个高性能的分布式的内存对象缓存系统，目前全世界不少人使用这个缓存项目来构建自己大负载的网站，来分担数据库的压力，通过在内存里维护一个统一的巨大的hash表，它能够用来存储各种格式的数据，包括图像、视频、文件以及数据库检索的结果等。简单的说就是将数据调用到内存中，然后从内存中读取，从而大大提高读取速度。(注: 摘自百度全科)
* Sphinx 搜索加速:phinx全文索引,Sphinx 是一个基于SQL的全文检索引擎，可以结合MySQL，PostgreSQL作全文搜索，它可以提供比数据库本身更专业的搜索功能，使得应用程序更容易实现专业化的全文检索。

## 网站服务监控

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

## XSS

* 对用户所有提交的文本进行htmlspecialchars函数处理

## SSO

用户自动登出可能是因为网站的登录cookie过期且SSO上的登录cookie也过期，这时当某个请求到达后台时，会清空所有与认证有关的cookie并重定向到SSO的登录页面。登录cookie的有效期是20分钟，但用户抱怨的是刚登录不久就被自动踢出，从日志上看也的确如此。所以“登录cookie过期”的不在场证明相当完美。

另外的可能就是缓存挂了。每个请求到达后台时，都会到服务器缓存中取出在用户登录时存储的一个token，将之与请求所携带的cookie中的token比较，如果不相符就自动登出。之所以这样做是考虑用户的安全，将伪造或窃取cookie登录的黑客拒之门外。如果存储或读取缓存失败，自然也会自动登出。齐识以前在读写缓存的地方加了很详细的日志，并没看到任何错误发生。“缓存”作案的可能性也不大。

网站前端每隔2分钟会自动向后台发一个心跳请求，如果服务器发现本次心跳与上一次心跳间隔时间超过3分钟，就认为用户已处于不活跃状态，自动将其登出。这么做也是为了用户安全，比如将所有网站页面关闭，3分钟后再次打开，将会自动跳转到登录页面。如果心跳请求没有发送成功，下次请求到来时很可能已经超过了3分钟，就会把用户踢出去

## WEB开发中需要了解的东西

* 接口和用户体验
    - 小心浏览器的实现标准上的不一致，确信让你的网站能够适当地跨浏览器。至少，你的网站需要测试一下下面的浏览器：
        - 最新的 Gecko 引擎 (Firefox)，
        - 一个 Webkit 引擎 (Safari, Chrome, 或是其它的移动设备上的浏览器)
        -  IE 浏览器 (测试IE的兼容性你可以使用微软IE的 Application Compatibility VPC Images)
        -  Opera 浏览器
        -  使用一下[browsershots](http://browsershots.org/) 来看看你的网页在不同的浏览器下是怎么被显示出来的
    - 考虑一下人们是怎么来访问你的网站而不是那些主流的浏览器：手机，读屏软件和搜索引擎，例如：一些Accessibility的东西： [WAI](https://www.w3.org/WAI/) 和  [Section508](https://www.section508.gov/), 移动设备开发：[MobiForge](https://mobiforge.com/).
    - 部署Staging：怎么部署网站的更新而不会影响用户的访问。 Ed Lucas的答案 可以让你了解一些（陈皓注：Ed说了一些如版本控制，自动化build，备份，回滚等机制）。
    * 千万不要直接给用户显示不友好的错误信息。
    * 千万不要把用户的邮件地址以明文显示出来，这样会被爬虫爬走并被让用户的邮箱被垃圾邮件搞死。
    * 为用户的链接加上 rel="nofollow" 的属性以 避免垃圾网站的干扰。（陈皓注：nofollow是HTML的一个属性，用于通知搜索引擎“这个链接所指向的网页非我所能控制，对其内容不予置评”，或者简单地说，该链接不是对目标网站或网页的“投票”，这样搜索引擎不会再访问这个链接。这个是用来减少一些特定垃圾页面对原网站的影响，从而可以改善搜索结果的质量，并且防止垃圾链接的蔓延。）
    * 为网站建立[一些的限制](https://blog.codinghorror.com/rate-limiting-and-velocity-checking/) – 这个属于安全性的范畴。（陈皓注：比如你在Google注册邮箱时，你一口气注册超过两个以上的邮箱，gmail要求给你发短信或是给你打电话认证，比如Discuz论坛的会限制你发贴或是搜索的间隔时间等等，更多的网站会用CAPTCHA来确认是人为的操作。 这些限制都是为了防止垃圾和恶意攻击）
    * 学习如何做 Progressive Enhancement. Progressive Enhancement是一个Web Design的理念，
        * 基础的内容和功能应该可以被所有的浏览器存取
        * 页面布局的应该使用外部的CSS链接
        * Javascript也应该是外部链接还应该是 unobtrusive 的
        * 应该让用户可以设置他们的偏好
    * 如果POST成功，要在POST方法后重定向网址，这样可以阻止用户通过刷新页面重复提交。
    * 严重关注Accessibility。因为这是法律上的需求（陈皓注：Section 508是美国的508法案，其是美国劳工复健法的改进，它是一部联邦法律，这个法律要求所有技术要考虑到残障人士的应用，如果某个大众信息传播网站，如果某些用户群体（如残疾人）浏览该网站获取信息时，如果他们无法正常获得所期望的信息（如无法正常浏览），那可以依据相关法规，可以对该网站依法起诉）。 [WAI-ARIA](https://www.w3.org/WAI/standards-guidelines/aria/) 为这方面的事提供很不错的资源.
* 安全
    * 在网上有很多关于安全的文章，但是 [OWASP 开发指导](https://www.owasp.org/index.php/OWASP_Guide_Project) 涵盖了几乎所有关于Web站点安全的东西。（陈皓注：OWASP(开放Web应用安全项目- Open Web Application Security Project)是一个开放的非营利性组织，目前全球有130个分会近万名会员，其主要目标是研议协助解决Web软体安全之标准、工具与技术文件，长期 致力于协助政府或企业了解并改善网页应用程式与网页服务的安全性。OWASP被视为Web应用安全领域的权威参考。2009年下列发布的美国国家和国际立法、标准、准则、委员会和行业实务守则参考引用了OWASP。美国联邦贸易委员会(FTC)强烈建议所有企业需遵循OWASP十大WEB弱点防护守则）
    * 了解什么是 SQL 注入攻击 并知道怎么阻止这种攻击。
    * 永远不要相信用户的输入（包括Cookies，因为那也是用户的输入）
    * 对用户的口令进行Hash，并使用salt，以防止Rainbow 攻击（陈皓注：Hash算法可用MD5或SHA1等，对口令使用salt的意思是，user 在设定密码时，system 产生另外一个random string(salt)。在datbase 存的​​是与salt + passwd 产的md5sum 及salt。 当要验证密码时就把user 输入的string 加上使用者的salt，产生md5s​​um 来比对。 理论上用salt 可以大幅度让密码更难破解，相同的密码除非刚好salt 相同，最后​​存在database 上的内容是不一样的。google一下md5+salt你可以看到很多文章。关于Rainbow 攻击，其意思是很像密码字典表，但不同的是，Rainbow Table存的是已经被Hash过的密码了，而且其查找密码的速度更快，这样可以让攻击非常快）。使用慢一点的Hash算法来保存口令，如 bcrypt (被时间检证过了) 或是 scrypt (更强，但是也更新一些) (1, 2)。你可以阅读一下 How To Safely Store A Password（陈皓注：酷壳以前曾介绍过bcrypt这个算法，这里，我更建议我们应该让用户输入比较强的口令，比如Apple ID注册的过程需要用户输入超过8位，需要有大小写和数字的口令，或是做出类似于这样的用户体验的东西）。
    * 不要试图自己去发明或创造一个自己的[fancy的认证系统](https://stackoverflow.com/questions/1581610/how-can-i-store-my-users-passwords-safely/1581919#1581919)，你可能会忽略到一些不容易让你查觉的东西而导致你的站点被hack了。（陈皓注：我在腾讯那坑爹的申诉系统中说过这个事了，我说过这句话——“真正的安全系统是协同整个社会的安全系统做出来的一道安全长城，而不是什么都要自己搞”，当然，很遗憾不是所有的人都能看懂这个事，包括一些资深的人）
    * 了解 [处理信用卡的一些规则](https://www.pcisecuritystandards.org/) . ([这里也有一个问题你可以查看一下](https://stackoverflow.com/questions/51094/payment-processors-what-do-i-need-to-know-if-i-want-to-accept-credit-cards-on)) （有两上vendor可以帮助你，一个是 Authorize.Net 另一个是 PayFlow Pro）
    * 使用 SSL/HTTPS 来加密传输登录页面或是任可有敏感信息的页面，比如信用卡号等。
    * 知道如何对付session 劫持。（陈皓注：请参看wikipedia的这[Session Hijacking](https://en.wikipedia.org/wiki/Session_hijacking)，）
    * 避免 跨站脚本攻击(XSS)。（陈皓注：参看酷壳站前几天发的《新浪微博的XSS攻击事件》）
    * 避免 跨站伪造请求攻击 cross site request forgeries (XSRF).
    * 保持你的系统里的所有软件更新到最新的patch。
    * 确保你的数据库连接是安全的。
    * 确保你能了解最新的攻击技术，以及你系统的脆弱处。
    * 请读一下 [The Google Browser Security Handbook](https://code.google.com/p/browsersec/wiki/Main).
    * 请读一下 [The Web Application Hacker’s Handbook](https://www.amazon.com/dp/0470170778/?tag=stackoverflow17-20).
    * [Mozilla的安全编程规范](https://wiki.mozilla.org/WebAppSec/Secure_Coding_Guidelines)
    * [Ruby on Rails的Web安全的开发教程](https://guides.rubyonrails.org/security.html)
* 性能
    - 只要需要，请实现cache机制，了解并合理地使用 HTTP caching 以及 HTML5 Manifest.
    - 优化页面 —— 不要使用20KB图片来平铺网页背景。（陈皓注：还有很多网页页面优化性的文章，你可以STFG – Search The Fucking Google一下。如果你要调试的话，你可以使用firebug或是chrome内置的开发人员的工具来查看网页装载的性能）
    - 学习如何 gzip/deflate 网页 (deflate 更好).
    - 把多个CSS文件和Javascript文件合并成一个，这样可以减少浏览器的网络连数，并且使用gzip压缩被反复用到的文件。
    - 学习一下 Yahoo Exceptional Performance 这个网站上的东西，上面有很多非常不错的改善前端性能的指导，以及 YSlow 这个工具。 Google page speed 是另一个用来做性能采样的工具。这两个工具都需要安装 Firebug 。
    - 为那些小的图片使用 CSS Image Sprites，就像工具条一样。 (参看 “最小化 HTTP 请求” ) （陈皓注：把所有的小图片合并成一个图片，然后用CSS把显示其中的一块，这样，这些小图片只用传输一次，酷壳的Wordpress样式的那个RSS订阅列表中的小图标就是这样做的）
    - 繁忙的网络应该考虑把网页的内容分开存放在不同的域名下。（陈皓注：比如有专门的图片服务器——图片相当耗带宽，或是专门的Ajax服务器）
    - 静态网页 (如，图片，CSS，JavaScript，以及一些不需要访问cookies的网页) 应该放在一个不使用cookies的独立的域名下，因为所有在同一个域名或子域名下的cookie会被这个域名下的请求一同发送。另一个好的选择是使用 Content Delivery Network (CDN).
    - 使用单个页面的HTTP请求数最小化。
    - 为Javascript使用 Google Closure Compiler 或是 其它压缩工具（陈皓注：压缩Javascript代码可以让你的页面减少网络传输从而可以得到很快的喧染。注意，并不是所有的工具都可以正确压缩Javascript的，Google的这个工具甚至还可以帮你优化你的代码）
    - 确认你的网站有一个 favicon.ico 文件放在网站的根下，如 /favicon.ico. 浏览器会自动请求这个文件，就算这个图标文件没有在你的网页中明显说明，浏览器也会请求。如果你没有这个文件，就会出大量的404错误，这会消耗你的服务器带宽。（陈皓注：服务器返回404页面会比这个ico文件可能还大）

## 趋势

* PWA
* 客服聊天机器人
* 静态网页的再流行原因有很多，他们更快、更安全，也更便宜
* 单页应用。这项技术可以将所有内容放入一个长长的滚动页中，移除不需要的冗余内容
* 网页消息推送
* Flash的一个致命弱点是他无法在移动设备中使用，HTML播放器Chimee

## 工具

* [CompuIves/codesandbox-client](https://github.com/CompuIves/codesandbox-client):An online code editor tailored for web application development 🏖️ https://codesandbox.io
* [inconshreveable/ngrok](https://github.com/inconshreveable/ngrok):Introspected tunnels to localhost
* [pod4g/hiper](https://github.com/pod4g/hiper):🚀 A statistical analysis tool for performance testing
* [raviqqe/muffet](https://github.com/raviqqe/muffet):Fast website link checker in Go
* [coturn/coturn](https://github.com/coturn/coturn):coturn TURN server project
* [codesandbox](https://codesandbox.io):The online code editor for Preact
* [acaudwell/Logstalgia](https://github.com/acaudwell/Logstalgia):replay or stream website access logs as a retro arcade game https://logstalgia.io
* 压力测试
    - apache AB
    + webbench
- record and replay
    + [rrweb-io/rrweb](https://github.com/rrweb-io/rrweb):record and replay the web https://www.rrweb.io/
    + [sindresorhus/pageres](https://github.com/sindresorhus/pageres):Capture website screenshots
- [缩短网址](http://suo.im/)
- [google/pprof](https://github.com/google/pprof):pprof is a tool for visualization and analysis of profiling data
* [GoogleChromeLabs/quicklink](https://github.com/GoogleChromeLabs/quicklink):⚡️Faster subsequent page-loads by prefetching in-viewport links during idle time
* 分析
    - [matomo-org/matomo](https://github.com/matomo-org/matomo):Liberating Web Analytics. Star us on Github? +1. Matomo is the leading open alternative to Google Analytics that gives you full control over your data. Matomo lets you easily collect data from websites, apps & the IoT and visualise this data and extract insights. Privacy is built-in. We love Pull Requests! https://matomo.org/

## 监控

* [davidkpiano/xstate](https://github.com/davidkpiano/xstate):State machines and statecharts for the modern web. https://xstate.js.org/docs
* [etsy/statsd](https://github.com/etsy/statsd):Daemon for easy but powerful stats aggregation
* [brendangregg/FlameGraph](https://github.com/brendangregg/FlameGraph):Stack trace visualizer http://www.brendangregg.com/flamegraphs.html

## 参考

* [wx-chevalier/Web-Series](https://github.com/wx-chevalier/Web-Series):📚 现代 Web 开发，现代 Web 开发导论 | 基础篇 | 进阶篇 | 架构优化篇 | React 篇 | Vue 篇 https://parg.co/bMe
* [Web](https://developers.google.com/web/)
* [Web](https://developer.mozilla.org/zh-CN/docs/Web)
* [MDN Web Docs](https://developer.mozilla.org):Data and tools related to MDN Web Docs (formerly Mozilla Developer Network, formerly Mozilla Developer Center...)
- [Web 开发](https://www.ibm.com/developerworks/cn/web/)
* [Design Issues](https://www.w3.org/DesignIssues/)
* [solid/solid](https://github.com/solid/solid):Solid - Re-decentralizing the web (project directory) https://solid.mit.edu/

* [5 Tips on Concurrency](https://dzone.com/articles/7-tips-about-concurrency)
* [mdn/learning-area](https://github.com/mdn/learning-area):Github repo for the MDN Learning Area. https://developer.mozilla.org/en-US/docs/Learn
* [WEB开发中需要了解的东西](https://coolshell.cn/articles/6043.html): [What technical details should a programmer of a web application consider before making the site public?](https://softwareengineering.stackexchange.com/questions/46716/what-technical-details-should-a-programmer-of-a-web-application-consider-before/46738#46738)
* [关于大型网站技术演进的思考](http://blog.jobbole.com/84761/)
* [A Beginner’s Guide to Website Speed Optimization](https://kinsta.com/learn/page-speed/)
* [大型WEB架构设计](https://mp.weixin.qq.com/s?__biz=MzAwNzY4OTgyNA==&mid=2651826002&idx=1&sn=237e6c340626171cf1f4eb6e0f19f182&chksm=8081445db7f6cd4bea29330141ac28228f09c024dd5671cb945171bf41a20d6f1386c455e330)
- [PHP 进阶之路 - 亿级 pv 网站架构实战之性能压榨](https://segmentfault.com/a/1190000010455076)
- [全站缓存](https://segmentfault.com/a/1190000005808789)
- 《构建高性能Web站点》第12章 web负载均衡
- 《大型网站技术架构：核心原理与案例分析》 6.2 应用服务器集群的伸缩性设计

<https://zhuanlan.zhihu.com/p/22360384>

<http://tips.codekiller.cn/2017/05/17/maglev_describe/>
<http://developer.51cto.com/art/200807/83518.htm>
<https://help.aliyun.com/document_detail/29322.html>
<http://geek.csdn.net/news/detail/237188>

