# Web/Application Servers

* WebServers服务器：Web服务器，使用 http协议向Web提供内容。
* ApplicationServers：应用程序服务器，托管并公开业务逻辑和进程。
* 服务器端语言
    - PHP：
        + 使用者多，算是最普及的后端语言。
        + 简单易学，但因一些古老的设计饱受批评。
        + 网站范例：Facebook、 Wordpress、新浪微博。
   - Java：
       + 老牌语言，开发统治者。国内外工作需求稳定，应用层面广。
       + 开发相较起来较慢，没那麽适合新手。
       + 网站范例：Linkedin、 Amazon、淘宝。
   - Ruby：
       + 开发快速，国内外很多 bootcamp 都以此语言教后端。
       + 适不适合新手学饱受争议。
       + 网站范例：Airbnb、 Twitter。
   - Python:
       + 语法简单易学，数据分析与资料探勘相关应用多。
       + 单独使用 Python 相较起来运行性能较差。
       + 网站范例：Instagram、 Reddit、知乎。
   - JavaScript(Node.js):
       + 前端后端都可用 JS，高并发的情况执行效率极高
       + 不适合 CPU 密集的应用
       + 初创型企业首选
       + 网站范例：Yahoo、 Walmart
   - Go:
       + Google力推，有很完善的标准库，效能强大堪比C系列。
       + 目前学习资源较少（感谢伟大B站的付出，真香）
       + 网站范例：Google、 Youtube、哔哩哔哩、头条、腾讯云
* 静态内容服务器:在80端口上监听，解析客户端发过来的HTTP的请求， 然后把相对应的HTML文件、Image等返回给客户端
* 动态:用一个动态内容服务器（wsgi server，Tomcat等）来接受并且封装HTTP 请求，降低程序员的负担
    - CGI
        + Web服务器是个进程，解释器也是个进程
        + 参数传递：Web服务器进程创建一个解释器进程，通过环境变量把参数传递过去
        + 结果返回
            * 程序都有所谓的标准输出（STDOUT），解释器只要调用printf这个函数，数据就会输出到STDOUT
            * 每个浏览器和服务器的连接都是一个Socket， 每个socket都有一个文件描述符fd， 如果把解释器的STDOUT重定向到那个fd
        + 只要遵循CGI协议， 可以用任何语言来实现动态的网站
        + 缺点
            * 对每个请求，都得创建一个子进程去执行，这是个非常大的开销
            * 要操作环境变量，还需要直接在编程语言中输出HTML
    - Java: Tomcat
        + Servlet:会用一个线程来创建HttpRequest对象和HttpResponse对象
        + 从HttpRequest中获得Header, Cookie, QueryString 等信息， 从HttpResponse中获得输出流，直接向浏览器输出结果
    - WSGI （Web Service Gateway Interface）
* Apache拥有丰富的模块组件支持，稳定性强，BUG少，动态内容处理强
  + 运行数以万计的并发访问，会导致服务器消耗大量内存
  + 操作系统对其进行进程或线程间的切换也消耗了大量的 CPU 资源，导致 HTTP 请求的平均响应速度降低
* Nginx轻量级，占用资源少，负载均衡，高并发处理强，静态内容处理高效。 Apache 是同步多进程模型，一个连接对应一个进程；Nginx是异步的，多个连接（万级别）可以对应一个进程。

## TCP/IP

网络通讯大部分是基于TCP/IP的，而TCP/IP是基于IP地址

* 用户主机上运行着DNS的客户端
* 浏览器将接收到的url中抽取出域名字段，就是访问的主机名
* DNS客户机端向DNS服务器端发送一份查询报文，报文中包含着要访问的主机名字段（中间包括一些列缓存查询以及分布式DNS集群的工作）
* 该DNS客户机最终会收到一份回答报文，其中包含有该主机名对应的IP地址
* 一旦该浏览器收到来自DNS的IP地址，就可以向该IP地址定位的HTTP服务器发起TCP连接

### IP

网卡有唯一的MAC编号，网路分配唯一的IP地址

* 127.0.0.1 绑定本机的IP
* localhost

```sh
ipconfig # windows
nslookup www.baidu.com

ifconfig # linux mac
```

## CGI(common gateway interface) 通用网关协议

保证web server传递过来的数据是标准格式的
* FastCGI则是一种常住进程的CGI模式程序

## PATH_INFO

* 每种动态语言（ PHP,Python 等）的代码文件需要通过对应的解析器才能被服务器识别，而 CGI 协议就是用来使解释器与服务器可以互相通信。通过标准输入（STDIN）和标准输出（STDOUT）和环境变量来与CGI程序间传递数据
* fork-and-execute:每当客户请求CGI的时候，WEB服务器就请求操作系统生成一个新的CGI解释器进程(如php-cgi.exe)，CGI 的一个进程则处理完一个请求后退出，下一个请求来时再创建新进程。
    - 有多少连接请求就会有多少cgi子进程，每个子进程都需要启动CGI解释器、加载配置等初始化工作，这是性能低下的原因。比如重新解析php.ini、重新载入全部扩展并重初始化全部数据结构
* 操作系统提供了许多环境变量，定义了程序的执行环境，应用程序可以存取它们
* Web服务器和CGI接口又另外设置了一些环境变量，PATHINFO是一个CGI 1.1的标准，经常用来做为传参载体，用来向CGI程序传递一些重要的参数 URL、查询字符串、POST数据、HTTP header
    - CONTENT_TYPE    这个环境变量的值指示所传递来的信息的MIME类型。目前，环境变量CONTENT_TYPE一般都是：application/x-www-form-urlencoded,他表示数据来自于HTML表单。
    - CONTENT_LENGTH  如果服务器与CGI程序信息的传递方式是POST，这个环境变量即使从标准输入STDIN中可以读到的有效数据的字节数。这个环境变量在读取所输入的数据时必须使用。
    - HTTP_COOKIE 客户机内的 COOKIE 内容。
    - HTTP_USER_AGENT 提供包含了版本数或其他专有数据的客户浏览器信息。
    - PATH_INFO   这个环境变量的值表示紧接在CGI程序名之后的其他路径信息。它常常作为CGI程序的参数出现。
    - QUERY_STRING    如果服务器与CGI程序信息的传递方式是GET，这个环境变量的值即使所传递的信息。这个信息经跟在CGI程序名的后面，两者中间用一个问号'?'分隔。
    - REMOTE_ADDR 这个环境变量的值是发送请求的客户机的IP地址，例如上面的192.168.1.67。这个值总是存在的。而且它是Web客户机需要提供给Web服务器的唯一标识，可以在CGI程序中用它来区分不同的Web客户机。
    - REMOTE_HOST 这个环境变量的值包含发送CGI请求的客户机的主机名。如果不支持你想查询，则无需定义此环境变量。
    - REQUEST_METHOD  提供脚本被调用的方法。对于使用 HTTP/1.0 协议的脚本，仅 GET 和 POST 有意义。
    - SCRIPT_FILENAME CGI脚本的完整路径
    - SCRIPT_NAME CGI脚本的的名称
    - SERVER_NAME 这是你的 WEB 服务器的主机名、别名或IP地址。
    - SERVER_SOFTWARE 这个环境变量的值包含了调用CGI程序的HTTP服务器的名称和版本号。例如，上面的值为Apache/2.2.14(Unix)
* PHP-CGI是PHP自带的FastCGI管理器
    - php-cgi变更php.ini配置后需重启php-cgi才能让新的php-ini生效，不可以平滑重启。
    - 直接杀死php-cgi进程，php就不能运行了。(PHP-FPM和Spawn-FCGI就没有这个问题，守护进程会平滑从新生成新的子进程）

## FastCGI

* 用来提高CGI程序性能的,是CGI开放扩展,其主要行为是将CGI解释器进程保持在内存中并因此获得较高的性能
* 一个与平台无关，与语言无关，任何语言只要按照它的接口来实现，就能实现自己语言的fastcgi能力和web server 通讯
  - 先启一个master，解析配置文件，初始化执行环境,再启动多个worker
  - 当请求过来时，master会传递给一个worker，然后立即可以接受下一个请求。这样就避免了重复的劳动，效率自然是高
  - 当worker不够用时，master可以根据配置预先启动几个worker等着
  - 空闲worker太多时，也会停掉一些，这样就提高了性能，也节约了资源
* 一个常驻(long-live)型的CGI，可以一直执行着，只要激活后，不会每次都要花费时间去fork一次，整个工作流程是这样：
    - Web Server启动时载入FastCGI进程管理器（IIS ISAPI或Apache Module)
    - FastCGI进程管理器自身初始化，启动多个CGI解释器进程(可见多个php-cgi)并等待来自Web Server的连接。
    - 当客户端请求到达Web Server时，FastCGI进程管理器选择并连接到一个CGI解释器。 Web server将CGI环境变量和标准输入发送到FastCGI子进程php-cgi。
    - FastCGI 子进程完成处理后将标准输出和错误信息从同一连接返回Web Server。当FastCGI子进程关闭连接时， 请求便告处理完成。FastCGI子进程接着等待并处理来自FastCGI进程管理器(运行在Web Server中)的下一个连接。 在CGI模式中，php-cgi在此便退出了。
    - 先启一个master，解析配置文件，初始化执行环境，然后再启动多个worker。当请求过来时，master会传递给一个worker，然后立即可以接受下一个请求
* 支持分布式的运算，即 FastCGI 程序可以在网站服务器以外的主机上执行并且接受来自其它网站服务器来的请求。
* 语言无关的、可伸缩架构的CGI开放扩展，其主要行为是将CGI解释器进程保持在内存中并因此获得较高的性能。众所周知，CGI解释器的反复加载是CGI性能低下的主要原因，如果CGI解释器保持在内存中并接受FastCGI进程管理器调度，则可以提供良好的性能、伸缩性、Fail- Over特性等等。
* 独立于核心web服务器运行，提供了一个比API更安全的环境。APIs把应用程序的代码与核心的web服务器链接在一起，这意味着在一个错误的API的应用程序可能会损坏其他应用程序或核心服务器。 恶意的API的应用程序代码甚至可以窃取另一个应用程序或核心服务器的密钥。
* 不依赖于任何Web服务器的内部架构，因此即使服务器技术的变化, FastCGI依然稳定不变。
* 多进程，所以比CGI多线程消耗更多的服务器内存，PHP-CGI解释器每进程消耗7至25兆内存，将这个数字乘以50或100就是很大的内存数。
    - Nginx 0.8.46+PHP 5.2.14(FastCGI)服务器在3万并发连接下，开启的10个Nginx进程消耗150M内存（15M*10=150M），开启的64个php-cgi进程消耗1280M内存（20M*64=1280M），加上系统自身消耗的内存，总共消耗不到2GB内存。如果服务器内存较小，完全可以只开启25个php-cgi进程，这样php-cgi消耗的总内存数才500M。
* fastCGI是nginx和php之间的一个通信接口，该接口实际处理过程通过启动php-fpm进程来解析php脚本，即php-fpm相当于一个动态应用服务器，从而实现nginx动态解析php。因此，如果nginx服务器需要支持php解析
    - 需要在nginx.conf中增加php的配置：将php脚本转发到fastCGI进程监听的IP地址和端口（php-fpm.conf中指定）。
    - php安装的时候，需要开启支持fastCGI选项，并且编译安装php-fpm补丁/扩展，
    - 需要启动php-fpm进程，才可以解析nginx通过fastCGI转发过来的php脚本。

## PHP-FPM

* php-cgi是php提供给web serve也就是http前端服务器的cgi协议接口程序,自己本身只能解析请求，返回结果，不会进程管理
* PHP-FPM是一个实现了FastCGI（协议）的程序，负责管理一个进程池，来处理来自Web服务器的请求 是php提供给web serve也就是http前端服务器的fastcgi协议接口程序，管理对象是php-cg
* 提供了更好的PHP进程管理方式，可以有效控制内存和进程、可以平滑重载PHP配置
    - 配置都是在PHP-FPM.ini的文件内，而启动、重启都可以从php/sbin/PHP-FPM中进行。更方便的是修改php.ini后可以直接使用PHP-FPM reload进行加载，无需杀掉进程就可以完成php.ini的修改加载
    - 控制的进程cpu回收的速度比较慢,内存分配的很均匀。
* 当PHP需要在Apache服务器下运行时，一般来说，它可以模块的形式集成，此时模块的作用是接收Apache传递过来的PHP文件请求，并处理这些请求， 然后将处理后的结果返回给Apache。如果在Apache启动前在其配置文件中配置好了PHP模块， PHP模块通过注册apache2的ap_hook_post_config挂钩，在Apache启动的时候启动此模块以接受PHP文件的请求。
* Apache的Hook机制
    - 把php作为apache的一个子模块来运行。php5_module通过sapi将数据传给php解析器来解析php代码
    - Apache 允许模块(包括内部模块和外部模块，例如mod_php5.so，mod_perl.so等)将自定义的函数注入到请求处理循环中。 换句话说，模块可以在Apache的任何一个处理阶段中挂接(Hook)上自己的处理函数，从而参与Apache的请求处理过程。
    - mod_php5.so/ php5apache2.dll就是将所包含的自定义函数，通过Hook机制注入到Apache中，在Apache处理流程的各个阶段负责处理php请 求。
* php-fpm是一个完全独立的程序,不依赖php-cgi,也不依赖php.因为php-fpm是一个内置了php解释器的FastCGI服务,启动时能够自行读取php.ini配置和php-fpm.conf配置.
    - 一个master进程,支持多个pool,每个pool由master进程监听不同的端口,pool中有多个worker进程.
        + 每个worker进程都内置PHP解释器,并且进程常驻后台,支持prefork动态增加.
        + 每个worker进程支持在运行时编译脚本并在内存中缓存生成的opcode来提升性能.
        + 每个worker进程支持配置响应指定请求数后自动重启,master进程会重启挂掉的worker进程.
        + 每个worker进程能保持一个到MySQL/Memcached/Redis的持久连接,实现"连接池",避免重复建立连接,对程序透明.
    - master进程采用epoll模型异步接收和分发请求,listen监听端口,epoll_wait等待连接,
        + 然后分发给对应pool里的worker进程,worker进程accpet请求后poll处理连接,
        + 如果worker进程不够用,master进程会prefork更多进程,
        + 如果prefork达到了pm.max_children上限,worker进程又全都繁忙,
        + 这时master进程会把请求挂起到连接队列backlog里(默认值是511).
* PHP中cgi.fix_pathinfo配置项打开
    - PHP会去根据CGI规范来检查SCRIPT_FILENAME中那部分是访问脚本和PATH_INFO(ini配置解释)
    - 并根据SCRIPT_NAME来修改PATH_INFO(和PATH_TRANSLATED)为正确的值然后, 就只要添加一个FASTCGI_PARAM项就好了
* Nignx 与 PHP 通过Socket通信，fastcgi_pass所配置的内容，便是告诉Nginx接收到用户请求以后，该往哪里转发
    - ngx_http_fastcgi_module：实现了FastCGI的Client，fastcgi_param所声明的内容，将会被传递给“FastCGI server”
    - fastcgi_param配置 REMOTE_ADDR ，这不正是我们在PHP中用 `$_SERVER[‘REMOTE_ADDR’]` 取到的用户IP

```
LoadModule php5_module C:/php/php5apache2_2.dll

location ~ \.php {
    fastcgi_pass   127.0.0.1:9000;
    fastcgi_index  index.php;
    #先加载默认后解析赋值
    include        fastcgi_params;
    #正则解析路径
    fastcgi_split_path_info ^((?U).+\.php)(/?.+)$;
    fastcgi_param  PATH_INFO        $fastcgi_path_info;
    fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
}
```

### 域名(Domain Name)

* DNS（Domain Name System）域名解析系统是应用层协议，为其他应用层协议工作的，包括不限于HTTP和SMTP以及FTP，用于将用户提供的主机名解析为ip地址
* DNS服务器,存储了IP地址和域名对应关系，是一台数据库服务器
* 流程
    - 当用户在浏览器中输入网址域名时，首先就会访问系统设置的DNS域名解析服务器（通常由ISP运营商如电信、联通提供）
    - 如果该服务器内保存着该域名对应的IP信息，则直接返回该信息供用户访问网站
    - 否则，就会向上级DNS逐层查找该域名的对应数据。
    - www.baidu.com 通过dig +trace 查看域名解析过程
* 本机DNS
    - `C:\Windows\System32\drivers\etc\hosts`隐藏文件没有扩展名
    - `/etc/hosts`
* 公共DNS服务
    - 设计为分布式集群的工作方式：使用分布式的层次数据库模式以及缓存方法来解决单点集中式的问题。
    - 可通过修改网络连接的DNS server 地址
* 权威dns
    - Google的8.8.8.8：主8.8.8.8 备 8.8.4.4
    - 114DNS
        + 纯净无劫持，无需再忍受被强扭去看广告或粗俗网站之痛苦： 114.114.114.114  114.114.115.115
        + 拦截钓鱼病毒木马网站，增强网银、证券、购物、游戏、隐私信息安全：114.114.114.119 114.114.115.119
        + 学校或家长可选，拦截色情网站，保护少年儿童免受网络色情内容的毒害 114.114.114.110 114.114.115.110
    - 阿里DNS（`http://www.alidns.com/`）DNS递归解析系统，面向互联网用户提供快速、稳定、智能的免费DNS递归解析服务:223.5.5.5  223.6.6.6
    - SDNS（`http://www.sdns.cn/`）1.2.4.8  210.2.4.8
    - 中科大的DNS:202.38.64.1 202.112.20.131 202.141.160.95 202.141.160.99 202.141.176.95 202.141.176.99
    - OneDNS: 112.124.47.27 南方首选/北方备用  114.215.126.16 北方首选/南方备用
* 国内用户普遍使用的是ISP运营商提供的DNS服务器，这样有着一个巨大的风险，就是DNS劫持,目前国内ISP运营商普遍采用DNS劫持的方法，干扰用户正常上网，例如，当用户访问一个不存在（或者被封）的网站，电信运营商就会把用户劫持到一个满屏都是广告的页面，以帮助自己盈利！
    - 劫持广告：原来的网页被放置到一个iframe里，并注入了flash广告。
    - 面地址后面是不是有后缀
* 低延迟说明全国各地（至少在省内或者附近，不会南方跨到北方）直接返回被劫持的IP；
* TCP查询同样中枪，排除黑阔采用全国发UDP包方式进行劫持；
* 同网段有那啥网站
* 利用DNS实现DNS的负载均衡，并且在配置运营商CDN机房时也是重要的一部分。DNS技术属于前端架构甚至更前的一部分，不难看出一个大型网站在提供好扎实的应用层和数据层服务后亟待解决的是访问的问题，访问安全问题也是伴随着要解决的问题之一。
    - 出于资源消耗和响应速度的综合考虑，一般来说从主机到本地DNS服务器是递归查询，从本地DNS到其他DNS服务器是迭代查询。

## Web 服务器

* Apache提供一系列多重处理模块，通过这些多重处理模块来使用操作系统的资源，对进程和线程池进行管理，控制处理用户请求
    - apache是同步多进程模型，一个连接对应一个进程
    - 三种多重处理模块：mpm_prefork、mpm_worker、mpm_envent，
        + mpm_prefork：模块产生众多子进程，每个子进程是单线程的，每个线程链接一个请求，如此一对一的关系。所以如果请求数大于进程数时，服务器的性能就表现得差强人意了。
        + mpm_worker：worker中子进程是多线程的，每个线程管理一个用户连接。线程数要多于进程数量，这也就意味着新的连接能立刻得到一个空闲的线程，而不用等待进程空闲。
        + mpm_event：该模块与worker相似，区别在于event可以处理长连接(keep-alive)，以避免线程被请求长期占用而造成资源浪费，同时也增强了高并发场景下的请求处理能力。
    - apache适合处理动态请求
* Nginx是通过异步的、非阻塞的、事件驱动的方式在实现的
    - 异步的，多个连接（万级别）可以对应一个进程 。
    - 工作进程是单线程的，每个线程可以异步的处理大量的用户请求
    - epoll and kqueue 作为开发模型
* 对比
    - Nginx 使用更少的资源，支持更多的并发连接，体现更高的效率
    - 在高连接并发的情况下，Nginx是Apache服务器不错的替代品
    - Nginx 静态处理性能比 Apache 高 3倍以上
        + cpu内存使用率低
    - Apache 对 PHP 支持比较简单，Nginx 需要配合其他后端来使用,Apache 的组件比 Nginx 多
    - Apache具有内置的解析和执行各种动态脚本语言（包括PHP，Python和Perl）的功能，无需借助外部处理器
    - Nginx处理动态内容的效率并不高,且需借助外部的处理器
* 现在一般前端用nginx作为反向代理抗住压力，apache作为后端处理动态请求

## 架构

网站的架构逐渐从单机服务演进

* 前端是各地的CDN服务器集群，连接各反向代理服务器集群，连接负载均衡服务器集群
* 接下来将访问请求转到按照业务划分的应用服务器集群上，通过消息队列集群传到分布式服务集群上
* 然后通过缓存或一致性数据访问模块连接到数据源：分布式缓存、分布式数据库、分布式文件集群，外加NoSQL和搜索引擎服务器等等。
* 分层化与分布化
* BS：browser-Server  浏览器和服务器，通过浏览器来访问服务器，比如：百度，新浪等等
* CS：client-server  客户端和服务器，通过客户端软件去访问服务器

## 提高服务器的并发处理能力

* 提高CPU并发计算能力：操作系统通过多执行流体系设计使得多个任务可以轮流使用系统资源。包括CPU，内存以及I/O. 这里的I/O主要指磁盘I/O, 和网络I/O。
  + 多进程
    * 多执行流的一般实现便是进程，多进程的好处可以对CPU时间的轮流使用，对CPU计算和IO操作重叠利用。这里的IO主要是指磁盘IO和网络IO，相对CPU而言，它们慢的可怜。实际上，大多数进程的时间主要消耗在I/O操作上。
    * 现代计算机的DMA技术可以让CPU不参与I/O操作的全过程，比如进程通过系统调用，使得CPU向网卡或者磁盘等I/O设备发出指令，然后进程被挂起，释放出CPU资源，等待I/O设备完成工作后通过中断来通知进程重新就绪。 对于单任务而言，CPU大部分时间空闲，这时候多进程的作用尤为重要。
    * 多进程不仅能够提高CPU的并发度。其优越性还体现在独立的内存地址空间和生命周期所带来的稳定性和健壮性，其中一个进程崩溃不会影响到另一个进程。
    * 缺点：
      - fork()系统调用开销很大: prefork
      - 进程间调度和上下文切换成本: 减少进程数量
      - 庞大的内存重复：共享内存
      - IPC编程相对比较麻烦
  + 减少进程切换
    * 当硬件上下文频繁装入和移出时，所消耗的时间是非常可观的。可用Nmon工具监视服务器每秒的上下文切换次数。
    * 为了尽量减少上下文切换次数，最简单的做法就是减少进程数，尽量使用线程并配合其它I/O模型来设计并发策略。
    * 还可以考虑使用进程绑定CPU技术，增加CPU缓存的命中率。若进程不断在各CPU上切换，这样旧的CPU缓存就会失效。
  + 减少使用不必要的锁
    * 服务器处理大量并发请求时，多个请求处理任务时存在一些资源抢占竞争，这时一般采用“锁”机制来控制资源的占用。
    * 当一个任务占用资源时，我们锁住资源，这时其它任务都在等待锁的释放，这个现象称为锁竞争。 通过锁竞争的本质，我们要意识到尽量减少并发请求对于共享资源的竞争。
    * 无锁编程，就是由内核完成这个锁机制，主要是使用原子操作替代锁来实现对共享资源的访问保护。 使用原子操作时，在进行实际的写操作时，使用了lock指令，这样就可以阻止其他任务写这块内存，避免出现数据竞争现象。原子操作速度比锁快，一般要快一倍以上。
  + 考虑进程优先级：进程调度器会动态调整运行队列中进程的优先级，通过top观察进程的PR值
  + 考虑系统负载： 可在任何时刻查看/proc/loadavg, top中的load average也可看出
  + 考虑CPU使用率： 除了用户空间和内核空间的CPU使用率以外，还要关注I/O wait,它是指CPU空闲并且等待I/O操作完成的时间比例（top中查看wa的值）。
- 考虑减少内存分配和释放
  + Apache,在运行开始时一次申请大片的内存作为内存池，若随后需要时就在内存池中直接获取，不需要再次分配，避免了频繁的内存分配和释放引起的内存整理时间。
  + Nginx使用多线程来处理请求，使得多个线程之间可以共享内存资源，从而令它的内存总体使用量大大减少。分阶段的内存分配策略，按需分配，及时释放，使得内存使用量保持在很小的数量范围。
  + 共享内存:多处理器的计算机系统中，可以被不同中央处理器（CPU）访问的大容量内存，也可以由不同进程共享，是非常快的进程通信方式。不好的地方，就是对于多机器时数据不好统一
- 考虑使用持久连接
  + 持久连接也为长连接，它本身是TCP通信的一种普通方式，即在一次TCP连接中持续发送多分数据而不断开连接。
  + 是否采用持久连接，完全取决于应用特点。 从性能角度看，建立TCP连接的操作本身是一项不小的开销，在允许的情况下，连接次数越少，越有利于性能的提升; 尤其对于密集型的图片或网页等小数据请求处理有明显的加速所用。
  + HTTP长连接需要浏览器和web服务器的共同协作，目前浏览器普遍支持长连接，表现在其发出的HTTP请求数据头中包含关于长连接的声明，如下：Connection: Keep-Alive
  + 关键一点在于长连接超时时间的设置:Apache的默认设置为5s, 若这个时间设置过长，则可能导致资源无效占有，维持大量空闲进程，影响服务器性能。
* 改进I/O 模型
  + 对于网络I/O和磁盘I/O, 它们的速度要慢很多，尽管使用RAID磁盘阵列可通过并行磁盘磁盘来加快磁盘I/O速度，购买大连独享网络带宽以及使用高带宽网络适配器可以提高网络I/O的速度。
  + I/O操作需要内核系统调用来完成，这些需要CPU来调度，这使得CPU不得不浪费宝贵的时间来等待慢速I/O操作。
  + DMA技术:I/O设备和内存之间的数据传输方式由DMA控制器完成。在DMA模式下，CPU只需向DMA下达命令，让DMA控制器来处理数据的传送，这样可以大大节省系统资源。
  + 异步I/O: 异步I/O指主动请求数据后便可以继续处理其它任务，随后等待I/O操作的通知，这样进程在数据读写时不发生阻塞。 异步I/O是非阻塞的，当函数返回时，真正的I/O传输已经完成，这让CPU处理和I/O操作达到很好的重叠。
  + I/O多路复用
    * epoll服务器同时处理大量的文件描述符是必不可少的，若采用同步非阻塞I/O模型，若同时接收TCP连接的数据，就必须轮流对每个socket调用接收数据的方法，不管这些socket有没有可接收的数据，都要询问一次。
    * 假如大部分socket并没有数据可以接收，那么进程便会浪费很多CPU时间用于检查这些socket有没有可以接收的数据。
    * 多路I/O就绪通知的出现，提供了对大量文件描述符就绪检查的高性能方案，它允许进程通过一种方法同时监视所有文件描述符，并可以快速获得所有就绪的文件描述符，然后只针对这些文件描述符进行数据访问。
    * epoll可以同时支持水平触发和边缘触发，理论上边缘触发性能更高，但是代码实现复杂，因为任何意外的丢失事件都会造成请求处理错误。
    * epoll主要有2大改进：
      - epoll只告知就绪的文件描述符，而且当调用epoll_wait()获得文件描述符时，返回并不是实际的描述符，而是一个代表就绪描述符数量的值，然后只需去epoll指定的一个数组中依次取得相应数量的文件描述符即可。 这里使用了内存映射(mmap)技术，这样彻底省掉了这些文件描述符在系统调用时复制的开销。
      - epoll采用基于事件的就绪通知方式。其事先通过epoll_ctrl()注册每一个文件描述符，一旦某个文件描述符就绪时，内核会采用类似callback的回调机制，当进程调用epoll_wait()时得到通知
  + Sendfile
    * 向服务器请求静态文件，比如图片，样式表等,在处理这些请求时，磁盘文件的数据先经过内核缓冲区，然后到用户内存空间，不需经过任何处理，其又被送到网卡对应的内核缓冲区，接着再被送入网卡进行发送。
    * Linux提供sendfile()系统调用，可以讲磁盘文件的特定部分直接传送到代表客户端的socket描述符，加快了静态文件的请求速度，同时减少CPU和内存的开销。
    * 适用场景：对于请求较小的静态文件，sendfile发挥的作用不那么明显，因发送数据的环节在整个过程中所占时间的比例相比于大文件请求时小很多。
  + 内存映射:Linux内核提供一种访问磁盘文件的特殊方式，它可以将内存中某块地址空间和指定的磁盘文件相关联，从而对这块内存的访问转换为对磁盘文件的访问
    * 多数情况下，内存映射可以提高磁盘I/O的性能，无须使用read()或write()等系统调用来访问文件，而是通过mmap()系统调用来建立内存和磁盘文件的关联，然后像访问内存一样自由访问文件。
    * 缺点：在处理较大文件时，内存映射会导致较大的内存开销，得不偿失。
  + 直接I/O
    * 在linux 2.6中，内存映射和直接访问文件没有本质差异，因为数据需要经过2次复制，即在磁盘与内核缓冲区之间以及在内核缓冲区与用户态内存空间。 引入内核缓冲区的目的在于提高磁盘文件的访问性能，然而对于一些复杂的应用，比如数据库服务器，它们为了进一步提高性能，希望绕过内核缓冲区，由自己在用户态空间实现并管理I/O缓冲区，比如数据库可根据更加合理的策略来提高查询缓存命中率。
    * 另一方面，绕过内核缓冲区也可以减少系统内存的开销，因内核缓冲区本身就在使用系统内存。
    * Linux在open()系统调用中增加参数选项O_DIRECT,即可绕过内核缓冲区直接访问文件,实现直接I/O。
* 改进服务器并发策略
  + 一个进程处理一个连接，非阻塞I/O:会存在多个并发请求同时到达时，服务器必然要准备多个进程来处理请求。其进程的开销限制了它的并发连接数。从稳定性和兼容性的角度，则其相对安全，任何一个子进程的崩溃不会影响服务器本身，父进程可以创建新的子进程；这种策略典型的例子就是Apache的fork和prefork模式。
  + 一个线程处理一个连接，非阻塞IO:在一个进程中通过多个线程来处理多个连接，一个线程处理一个连接。Apache的worker模式就是这种典型例子，使其可支持更多的并发连接。不过这种模式的总体性能还不如prefork，所以一般不选用worker模式
  + 一个进程处理多个连接，异步I/O:潜在的前提条件就是使用IO多路复用就绪通知。这种情况下，将处理多个连接的进程叫做worker进程或服务进程。worker的数量可以配置，如Nginx中的worker_processes 4。
  + 一个线程处理多个连接，异步IO:即使有高性能的IO多路复用就绪通知，但磁盘IO的等待还是无法避免的。更加高效的方法是对磁盘文件使用异步IO，目前很少有Web服务器真正意义上支持这种异步IO。

## [Lighttpd](https://www.lighttpd.net/)

* [wiki](http://redmine.lighttpd.net/projects/lighttpd/wiki)

## 部署

* 域名购买：GoDaddy
* "L2TP" 或者 "Shadowsocks" anyconnnect
* nginx 提供php python

## 生产环境

* 可用性
* 性能
* Backup
    - 备份数据
    - 备份策略
    - 数据留存期
* 恢复计划
* Load Balancing:应对单点失效
* Monitoring：Tracking the status of services and the trends of your server resource utilization, thus providing great visibility into your environment.
* Centralized Logging

![WEB生产环境架构](../_static/production.png "WEB生产环境架构")

## 网站搭建

* 域名申请
  - 获取一级域名 example.com，
  - 域名认证(身份证)
  - 添加域名解析记录，默认两条记录，自由配置二级域名
  - 修改域名解析服务器，最长需要72个小时
* 购买服务器:获取ip，搭建环境
* https配置
  - 申请证书，下载并放到服务器
  - 分配到域名（会添加一条新记录到域名解析）
  - 修改配置文件

```
  ssl on;
  ssl_certificate conf.d/1_www.example.com_bundle.crt;
  ssl_certificate_key conf.d/2_www.example.com.key;
  ssl_session_timeout 5m;
  ssl_protocols TLSv1 TLSv1.1 TLSv1.2; #按照这个协议配置
  ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:HIGH:!aNULL:!MD5:!RC4:!DHE;#按照这个套件配置
  ssl_prefer_server_ciphers on;
```

## 服务器初步配置

```sh
ssh root@128.199.209.242
passwd

addgroup admin
useradd -d /home/bill -s /bin/bash -m bill
passwd bill
usermod -a -G admin bill
apt-get update && apt-get upgrade
apt-get install sudo
visudo # 打开sudo设置文件/etc/sudoers
root    ALL=(ALL:ALL) ALL
bill    ALL=(ALL) NOPASSWD: ALL # 切换sudo的时候，不需要输入密码

# SSH
cat ~/.ssh/id_rsa.pub | ssh bill@128.199.209.242 'mkdir -p .ssh && cat - >> ~/.ssh/authorized_keys'
# 或者在服务器端，运行下面命令
echo "ssh-rsa [your public key]" > ~/.ssh/authorized_keys

sudo cp /etc/ssh/sshd_config ~
sudo nano /etc/ssh/sshd_config
Port 25000
Protocol 2

PermitRootLogin no
PermitEmptyPasswords no
PasswordAuthentication no

RSAAuthentication yes
PubkeyAuthentication yes
AuthorizedKeysFile .ssh/authorized_keys

UseDNS no
AllowUsers bill

sudo chmod 600 ~/.ssh/authorized_keys && chmod 700 ~/.ssh/
sudo service ssh restart
sudo /etc/init.d/ssh restart

# client
Host s1
HostName 128.199.209.242
User bill
Port 25000

ssh s1

locale
sudo locale-gen en_US en_US.UTF-8 en_CA.UTF-8
sudo dpkg-reconfigure locales
```

## 演化

* Everything On One Server：Web Application Database
* Separate Database Server:
* Load Balancer (Reverse Proxy)
* HTTP Accelerator (Caching Reverse Proxy)
* Master-Slave Database Replication:database Cache

## 工具

* [sullo/nikto](https://github.com/sullo/nikto):Nikto web server scanner
* [Neilpang/acme.sh](https://github.com/Neilpang/acme.sh):A pure Unix shell script implementing ACME client protocol https://acme.sh
* [Webmin](http://www.webmin.com)
* [Shorewall](http://shorewall.net):一种用于配置iptable的GUI
* [cPanel](http://cpanel.com/products/)
* [Cockpit](http://cockpit-project.org):由红帽公司开发，旨在让服务器管理起来更容易。借助这个基于Web的GUI，你就能处理众多任务，比如管理存储资源、检查日志、启动/终止服务以及监控多台服务器
* [snail007/goproxy](https://github.com/snail007/goproxy):Proxy is a high performance HTTP(S), websocket, TCP, UDP,Secure DNS, Socks5 proxy server implemented by golang. Now, it supports chain-style proxies,nat forwarding in different lan,TCP/UDP port forwarding, SSH forwarding.Proxy是golang实现的高性能http,https,websocket,tcp,防污染DNS,socks5代理服务器,支持内网穿透,链式代理,通讯加密,智能HTTP,SOCKS5代理,域名黑白名单,跨平台,KCP协议支持,集成外部API。
* [remoteinterview/zero](https://github.com/remoteinterview/zero):Zero is a web server to simplify web development. https://zeroserver.io/
