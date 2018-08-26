# WEB开发中需要了解的东西

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
## 性能

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


## 参考

* [WEB开发中需要了解的东西](https://coolshell.cn/articles/6043.html): [What technical details should a programmer of a web application consider before making the site public?](https://softwareengineering.stackexchange.com/questions/46716/what-technical-details-should-a-programmer-of-a-web-application-consider-before/46738#46738)
