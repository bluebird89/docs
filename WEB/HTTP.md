# [HTTP协议（HyperText Transfer Protocol，超文本传输协议）](https://developer.mozilla.org/zh-CN/docs/Web/HTTP)

因特网上应用最为广泛的一种基于 TCP/IP 通信协议来传递数据的网络传输应用层协议。以 ASCII 码传输，建立在 TCP/IP 协议之上的应用层规范

* TCP/IP协议是传输层协议，主要解决数据如何在网络中传输
* HTTP是应用层协议，主要解决如何包装数据。详细规定了浏览器与服务器之间相互通信的规则，是万维网交换信息的基础
    - 超文本就是不单单只是本文，还可以传输图片、音频、视频，甚至点击文字或图片能够进行超链接的跳转
    - 传输就是数据需要经过一系列的物理介质从一个端系统传送到另外一个端系统的过程。通常把传输数据包的一方称为请求方，把接到二进制数据包的一方称为应答方
    - 协议指的就是是网络中(包括互联网)传递、管理信息的一些规范。如同人与人之间相互交流是需要遵循一定的规矩一样，计算机之间的相互通信需要共同遵守一定的规则，这些规则就称为协议，只不过是网络协议
    - 无状态协议(Stateless Protocol)
        + 无状态是指浏览器对于事务的处理没有记忆能力
        + 缺少状态意味着如果后续处理需要前面的信息，则必须重传，可能导致每次连接传送的数据量增大
        + 在服务器不需要先前信息时它的应答就较快
        + 在实际应用中又需要有状态的形式，因此一般会通过session/cookie技术来解决此问题
    - HTTP 是媒体独立的：只要客户端和服务器知道如何处理的数据内容，任何类型的数据都可以通过 HTTP 发送。客户端以及服务器指定使用适合的 MIME-type 内容类型。
    - 基于请求-响应形式并且是短连接，客户端发送的每次请求都需要服务器回送响应，在请求结束后，会主动释放连接（无连接）
        - 从建立连接到关闭连接的过程称为"一次连接"。在HTTP 1.1中则可以在一次连接中处理多个请求，并且多个请求可以重叠进行，不需要等待一个请求结束后再发送下一个请求。
        - 由于HTTP在每次请求结束后都会主动释放连接，因此HTTP连接是一种"短连接"，要保持客户端程序的在线状态，需要不断地向服务器发起连接请求。
        - 通常的做法是即时不需要获得任何数据，客户端也保持每隔一段固定的时间向服务器发送一次"保持连接"的请求，服务器在收到该请求后对客户端进行回复，表明知道客户端"在线"。
        - 若服务器长时间无法收到客户端的请求，则认为客户端"下线"，若客户端长时间无法收到服务器的回复，则认为网络已经断开。

## 概念

* Web 服务器会为每种要通过 MIME（Multipurpose Internet Mail Extension，多用途互联网邮件扩展） 传输的资源对象都打上了 MIME 类型的数据格式标签
* Web 浏览器从服务器取回一个对象时，会去查看相关的 MIME 类型(响应头的 Content-Type 字段)，看看它能否处理
* 连接(Connection)：一个传输层的实际环流，它是建立在两个相互通讯的应用程序之间
    - 长连接：只需一次建立就可以传输多次数据，传输完成后，只需要一次切断连接即可。在连接保持期间，如果没有数据包发送，需要双方发链路检测包。长连接的连接时长可以通过请求头中的 keep-alive 来设置
        + 用于操作频繁，点对点的通讯，而且连接数不能太多情况。数据库的连接用长连接， 如果用短连接频繁的通信会造成socket错误，而且频繁的socket 创建也是对资源的浪费
    - 短连接（short connnection）：指的是在数据传送过程中，只在需要发送数据时，才去建立一个连接，数据发送完成后，则断开此连接，即每次连接只完成一项业务的发送
        + 像WEB网站这么频繁的成千上万甚至上亿客户端的连接用短连接会更省一些资源
        + 优点：管理起来比较简单，存在的连接都是有用的连接，不需要额外的控制手段
* 消息(Message)：HTTP通讯的基本单位，包括一个结构化的八元组序列并通过连接传输
* 请求(Request)：一个从客户端到服务器的请求信息包括应用于资源的方法、资源的标识符和协议的版本号
* 响应(Response)：一个从服务器返回的信息包括HTTP协议的版本号、请求的状态(例如“成功”或“没找到”)和文档的MIME类型
* 资源(Resource)：由URI标识的网络数据对象或服务
* 实体(Entity)：数据资源或来自服务资源的回映的一种特殊表示方法，它可能被包围在一个请求或响应信息中。一个实体包括实体头信息和实体的本身内容
* 客户机(Client)：一个为发送请求目的而建立连接的应用程序
* 用户代理(Useragent)：初始化一个请求的客户机。它们是浏览器、编辑器或其它用户工具
* 服务器(Server)：一个接受连接并对请求返回信息的应用程序
* RTT（Round-Trip Time 往返时延）：数据从网络一端传送到另一端所需的时间，也就是包的往返时间
* RTO （Retransmission Timeout 超时重传时间）：较大，等待时间过长，影响效率，较短：没有正常返回就重发。应该略大于报文往返  RTT 的值
* 源服务器(Originserver)：是一个给定资源可以在其上驻留或被创建的服务器
* 代理(Proxy)：一个中间程序，它可以充当一个服务器，也可以充当一个客户机，为其它客户机建立请求。请求是通过可能的翻译在内部或经过传递到其它的服务器中
    - 一个代理在发送请求信息之前，必须解释并且如果可能重写它
    - 经常作为通过防火墙的客户机端的门户，代理还可以作为一个帮助应用来通过协议处理没有被用户代理完成的请求
* 网关(Gateway)：一个作为其它服务器中间媒介的服务器
    - 与代理不同的是，网关接受请求就好象对被请求的资源来说它就是源服务器；发出请求的客户机并没有意识到它在同网关打交道
    - 网关经常作为通过防火墙的服务器端的门户，网关还可以作为一个协议翻译器以便存取那些存储在非HTTP系统中的资源
* 通道(Tunnel)：是作为两个连接中继的中介程序
    - 一旦激活，通道便被认为不属于HTTP通讯，尽管通道可能是被一个HTTP请求初始化的
    - 当被中继的连接两端关闭时，通道便消失。当一个门户(Portal)必须存在或中介(Intermediary)不能解释中继的通讯时通道被经常使用。
* 缓存(Cache)：反应信息的局域存储
* URL（Uniform Resource Locator，统一资源定位符）也就是俗称的网址，表示某一网络资源存在于所在计算机网络上的位置，同时也是用于检索该资源的机制 `<scheme>://<user>:<password>@<host>:<port>/<path>;<params>?<query>#<frag>`
    - 第一部分称为方案（scheme），说明了访问资源所使用的协议类型，通常是 http:// 或 https://
    - 第二部分给出了服务器的域名/IP地址和端口号（不指定默认为80）
    - 其余部分指定的是 URI 的路径信息，比如 /wp-statics/images/carousel/LaravelAcademy.jpg
    - 使用 ASCII 字符集，对于不安全的字符则使用「%+两个ASCII码的十六进制数」进行编码
* URI 格式:router+search+hash `https://www.baidu.com?key1=vvalue1&key2=value2#test`
    - hash，哈希值或者称为锚，是#后面的字符串，一般作为单页应用的路由地址，或者文档的锚

## [CORS（cross-origin resource sharing）跨源资源共享（俗称『跨域请求』）](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Access_control_CORS)

* 允许浏览器向跨源服务器，发出XMLHttpRequest请求，克服了AJAX只能同源使用的限制.浏览器一旦发现AJAX请求跨源，就会自动添加一些附加的头信息，有时还会多出一次附加的请求，但用户不会有感觉
* 限制获取cookie，用iframe的方式放置了一个淘宝网页到真实页面中，获取淘宝密码信息
* 同源策略/SOP（Same origin policy）：从一个域上加载的脚本不允许访问另外一个域的文档属性，只要协议、域名、端口有任何一个不同，都被当作是不同的域.除非两个网页是来自于统一‘源头’，否则不允许一个网页的JavaScript访问另外一个网页的内容，像Cookie，DOM，LocalStorage统统禁止访问
    - `<script>、<img>、<iframe>、<link>、<script>`等标签都可以加载跨域资源，而不受同源限制
    - 浏览器会限制脚本中发起的跨域请求。比如，使用 XMLHttpRequest 对象和Fetch发起 HTTP 请求就必须遵守同源策略
    - 开个口子，对于使用`<script src='//static.store.com/jquery.js'>` 加载的JavaScript，我们认为它的源属于www.store.com， 而不属于static.store.com，这样就可以操作www.store.com的页面了
    - 两个网页的一级域名是相同的，可以共享cookie, 不过cookie的domain一定要设置为那个一级域名才可以，例如：`document.cookie = 'test=true;path=/;domain=store.com'`
    - 对XMLHttpReqeust对象施加同源策略
        - 代理模式：通过服务器端中转，例如你是来自book.com的， 现在想访问movie.com，那可以让那个book.com把请求转发给movie.com嘛！人类好像给这种方式起了个名字
        - 服务器(domain)可以设置一个白名单，里边列出它允许哪些服务器(domain)的AJAX请求
* 简单请求（simple request）:普通 HTML Form 在不依赖脚本的情况下可以发出的请求，比如表单的 method 如果指定为 POST ，可以用 enctype 属性指定用什么方式对表单内容进行编码
    - 自动在头信息之中，添加一个Origin字段
    - 请求方法是以下三种方法之一：
        + GET
        + HEAD
        + POST
    - HTTP的头信息不超出以下几种字段：
        + Accept
        + Accept-Language
        + Content-Language
        + Last-Event-ID
        + Content-Type (仅当POST方法)的值仅限于下列三者之一：
            * text/plain
            * multipart/form-data
            * application/x-www-form-urlencoded
    - 请求中的任意XMLHttpRequestUpload 对象均没有注册任何事件监听器；XMLHttpRequestUpload 对象可以使用 XMLHttpRequest.upload 属性访问。
    - 请求中没有使用 ReadableStream 对象
* 非简单请求（not-so-simple request）:普通 HTML Form 无法实现的请求,比如 PUT 方法、需要其他的内容编码方式、自定义头之类的
    - 浏览器先单独用 HTTP 的 OPTION 方法去另外一个域发起一个预检请求（preflight request），请求方法是OPTIONS，询问服务器某个资源是否可以跨源，如果不允许的话就不发实际的请求
    - 服务器确认允许之后，才发起实际的 HTTP 请求。在预检请求的返回中，服务器端也可以通知客户端，是否需要携带身份凭证（包括 Cookies 和 HTTP 认证相关数据）
    - 服务器通过了"预检"请求，以后每次浏览器正常的CORS请求，就都跟简单请求一样，会有一个Origin头信息字段。服务器的回应，也都会有一个Access-Control-Allow-Origin头信息字段
    - 新增了一组 HTTP 首部字段，允许服务器声明哪些源站有权限访问哪些资源规范要求，对那些可能对服务器数据产生副作用的HTTP 请求方法（特别是 GET 以外的 HTTP 请求，或者搭配某些 MIME 类型的 POST 请求）
    - 满足下述任一条件时，即应首先发送预检请求,"预检"请求会带上头部信息 Access-Control-Request-Headers: Content-Type
        + 使用了下面任一 HTTP 方法：
            * PUT:资源更新
            * DELETE
            * CONNECT:建立隧道通信
            * OPTIONS:获取支持的method
            * TRACE:追踪，返回请求回环信息
            * PATCH
        + 人为设置了对 CORS 安全的首部字段集合之外的其他首部字段。该集合为：
            * Accept
            * Accept-Language
            * Content-Language
            * Content-Type (需要注意额外的限制)
            * DPR
            * Downlink
            * Save-Data
            * Viewport-Width
            * Width
        + Content-Type 的值不属于下列之一:
            * application/x-www-form-urlencoded
            * multipart/form-data
            * text/plain
        + 请求中的XMLHttpRequestUpload 对象注册了任意多个事件监听器。
        + 请求中使用了ReadableStream对象
* 解决
    - JSONP （无状态连接，不能获悉连接状态和错误事件，而且只能走GET的形式）通过script标签引入一个js文件，这个js文件载入成功后会执行在url参数中指定的函数，并且会把需要的json数据作为参数传入，有种回调
        + 优点
            * 不像XMLHttpRequest对象实现的Ajax请求那样受到同源策略的限制
            * 兼容性更好，在更加古老的浏览器中都可以运行，不需要XMLHttpRequest或ActiveX的支持
            * 在请求完毕后可以通过调用callback的方式回传结果
        + 缺点
            * 只支持GET请求而不支持POST等其它类型的HTTP请求
            * 只支持跨域HTTP请求这种情况，不能解决不同域的两个页面之间如何进行JavaScript调用的问题
    - iframe形式
    - 服务器代理：页面直接向同域的服务端发请求，服务端进行跨域处理或爬虫后，再把数据返回给客户端页
    - 服务器设置
        + `Access-Control-Allow-Origin:<origin> | *` 允许哪个域的请求
            * `*` 不允许携带认证头和cookies,即使XHR设置了withCredentials
            * 指定域
            * 动态设置
        + `Access-Control-Allow-Credentials` 否允许发送Cookie
            * 设置为true 表示服务器明确许可，Cookie可以包含在请求中，一起发给服务器
            * 当用在对preflight预检测请求的响应中时，指定了实际的请求是否可以使用credentials
            * 简单 GET 请求不会被预检；如果对此类请求的响应中不包含该字段，这个响应将被忽略掉，并且浏览器也不会将相应内容返回给网页 Access-Control-Allow-Credentials: true
        + 如果想跨域传输cookies
            * 需要Access-Control-Allow-Credentials与XMLHttpRequest.withCredentials 或Fetch API中的Request() 构造器中的credentials 选项结合使用
            * Credentials必须在前后端都被配置（即the Access-Control-Allow-Credentials header 和 XHR 或Fetch request中都要配置）才能使带credentials的CORS请求成功。
        + `Access-Control-Request-Method: <method>` 指明了实际请求所允许使用的 HTTP 方法
        + `Access-Control-Request-Headers: <field-name>[, <field-name>]`  用于 preflight request （即会在实际请求发送之前先发送一个option请求）中，列出了将会在正式请求的 Access-Control-Expose-Headers 字段中出现的首部信息
            * XMLHttpRequest对象的getResponseHeader()方法只能拿到6个基本字段：Cache-Control、Content-Language、Content-Type、Expires、Last-Modified、Pragma。如果想拿到其他字段，就必须在Access-Control-Expose-Headers里面指定
        + `Access-Control-Expose-Headers` 让服务器把允许浏览器访问的头放入白名单，例如：Access-Control-Expose-Headers: X-My-Custom-Header, X-Another-Custom-Header
        + `Access-Control-Max-Age` 指定了preflight请求的结果能够被缓存多久 Access-Control-Max-Age: <delta-seconds>

```
# 简单请求
GET /cors HTTP/1.1
Origin: http://api.bob.com
Host: api.alice.com
Accept-Language: en-US
Connection: keep-alive
User-Agent: Mozilla/5.0...

## Origin指定的域名在许可范围内，服务器返回的响应，会多出几个头信息字段
Access-Control-Allow-Origin: http://api.bob.com
Access-Control-Allow-Credentials: true
Access-Control-Expose-Headers: FooBar
Content-Type: text/html; charset=utf-8

# 预检请求
OPTIONS /cors HTTP/1.1
Origin: http://api.bob.com
Access-Control-Request-Method: PUT
Access-Control-Request-Headers: X-Custom-Header # 该次请求的自定义请求头字段
Host: api.alice.com
Accept-Language: en-US
Connection: keep-alive
User-Agent: Mozilla/5.0

# 预检请求的响应
HTTP/1.1 200 OK
Date: Mon, 01 Dec 2008 01:15:39 GMT
Server: Apache/2.0.61 (Unix)
Access-Control-Allow-Origin: http://api.bob.com
Access-Control-Allow-Methods: GET, POST, PUT // 必需，值是逗号分隔的一个字符串，表明服务器支持的所有跨域请求的方法
Access-Control-Allow-Headers: X-Custom-Header
Content-Type: text/html; charset=utf-8
Content-TypeAccess-Control-Max-Age: 86400 // 预检结果缓存时间
Access-Control-Allow-Credentials:true //是否允许后续请求携带认证信息（cookies）,该值只能是true,否则不返回
Content-Encoding: gzip
Content-Length: 0
Keep-Alive: timeout=2, max=100
Connection: Keep-Alive
Content-Type: text/plain
```

```php
// 后端返回代码中增加三个字段
header(“Access-Control-Allow-Origin”:“”);           // 必选 允许所有来源访问
header(“Access-Control-Allow-Credentials”:“true”);  //可选 是否允许发送cookie
header(“Access-Control-Allow-Method”:“POST,GET”);   //可选 允许访问的方式

// server
$origin = isset($_SERVER['HTTP_ORIGIN'])? $_SERVER['HTTP_ORIGIN'] : '';
if(in_array($origin, [
    'http://client1.runoob.com',
    'http://client2.runoob.com'
])){
    header('Access-Control-Allow-Origin:' . $origin);
}

if($_SERVER['REQUEST_METHOD'] == "GET") {
    header('Content-Type: text/plain');
    echo "This HTTP resource is designed to handle POSTed XML input from arunranga.com and not be retrieved with GET";
} elseif ($_SERVER['REQUEST_METHOD'] == "OPTIONS") {
    // 告诉客户端我们支持来自 arunranga.com 的请求并且预请求有效期将仅有20天
    if($_SERVER['HTTP_ORIGIN'] == "http://arunranga.com")
    {
        header('Access-Control-Allow-Origin: http://arunranga.com');
        header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
        header('Access-Control-Allow-Headers: X-PINGARUNER');
        header('Access-Control-Max-Age: 1728000');
        header("Content-Length: 0");
        header("Content-Type: text/plain");
        //exit(0);
    } else {
    header("HTTP/1.1 403 Access Forbidden");
    header("Content-Type: text/plain");
    echo "You cannot repeat this request";

    }
} elseif($_SERVER['REQUEST_METHOD'] == "POST"){
    /* 通过首先获得XML传送过来的blob来处理POST请求，然后做一些处理, 最后将结果返回客户端
    */
    if($_SERVER['HTTP_ORIGIN'] == "http://arunranga.com")
    {
            $postData = file_get_contents('php://input');
            $document = simplexml_load_string($postData);

            // 对POST过来的数据进行一些处理
            $ping = $_SERVER['HTTP_X_PINGARUNER'];

            header('Access-Control-Allow-Origin: http://arunranga.com');
            header('Content-Type: text/plain');
            echo // 处理之后的一些响应
    } else {
        die("POSTing Only Allowed from arunranga.com");
    }
} else{
    die("No Other Methods Allowed");
}
```

## 地址栏输入 URL

* 浏览器从 URL 中解析出服务器的域名
    + 根据输入 URL 地址，去查找域名是否被本地 DNS 缓存，不同浏览器对 DNS 的设置不同，如果浏览器缓存了 URL 地址，那就直接返回 ip
    - 如果没有缓存 URL 地址，浏览器就会发起系统调用来查询本机 hosts 文件是否有配置 ip 地址，如果找到，直接返回
    - 如果找不到，就向网络中发起一个 DNS 查询
* 浏览器将服务器的域名替换为服务器的 IP 地址（通过 DNS 获取）
* 浏览器将端口号从 URL 中解析出来（默认是 80）
* 浏览器需要和目标服务器建立 TCP 连接:TCP连接被用来发送一条或多条请求，以及接受响应消息。客户端可能打开一条新的连接，或重用一个已经存在的连接，或者也可能开几个新的TCP连接连向服务端
* 浏览器向服务器发送一条 HTTP 请求报文:HTTP报文（在HTTP/2之前）是语义可读的。在HTTP/2中，这些简单的消息被封装在了帧中，这使得报文不能被直接读取，但是原理仍是相同的
* 服务器收到浏览器请求后进行处理并回送一条 HTTP 响应报文
* 浏览器收到响应后将其显示出来
* 关闭连接或者为后续请求重用连接

* 报文:用于 HTTP 协议交互的信息,本身是由多行（用CR+LF作换行符，即\r\n）数据构成的字符串文本
    - HTTP/1.1以及更早的HTTP协议报文都是语义可读的
    - HTTP/2中，报文被嵌入到了一个新的二进制结构帧,帧允许实现很多优化，比如报文头部的压缩和复用。即使只有原始HTTP报文的一部分以HTTP/2发送出来，每条报文的语义依旧不变，客户端会重组原始HTTP/1.1请求。因此用HTTP/1.1格式来理解HTTP/2报文仍旧有效
    - 分为报文首部和报文主体两块，两者由首次出现的空行来分隔
* 请求报文
    - 状态行(request line)
        + 方法（method）:由一个动词像GET, POST 或者一个名词像OPTIONS，HEAD 来定义客户端的动作行为。通常客户端操作都是获取资源（GET方法）或者发送HTML form表单值（POST方法），在一些情况下也会有其他操作
        + 请求 URL（request-URL）:通常是上下文中元素资源的URL
        + HTTP 协议版本号
    - 请求头 HTTP Request Header
    - 空行
    - 消息主体（entity-body）请求数据
    - HTTP 1.1 后默认使用长连接，只需要一次握手即可多次传输数据
* 响应报文
    - 状态行(request line)
        + HTTP协议版本号
        + 状态码（status code）:来告知对应请求执行成功或失败，以及失败的原因
        + 状态信息:非权威的状态码描述信息，可以由服务端自行设定
    - 响应头
* 格式
    - 起始行：报文的第一行,在请求报文中用来说明要做什么，在响应报文中说明出现了什么情况
    - 首部字段：起始行后面有零个或多个首部字段，每个首部字段包含一个名字和对应的值，为了便于解析，两者之间用冒号分隔,最后是一个 CR+LF（即\r\n）.在请求报文中将其称作请求头，在响应报文中将其称作响应头
        + 请求首部字段
        + 响应首部字段
        + 通用首部字段
        + 实体首部字段
        + 扩展首部字段：非 HTTP 协议标准规定的首部字段，通常由开发者创建，用于某些特殊用途，比如 Cookie、Set-Cookie
    - 报文主体和首部字段之间通过一个空行分隔
    - 字段可以有多个值，不同值之间通过逗号分隔
    - 主体：请求主体中包含了要发送给 Web 服务器的数据（一般 POST 请求都会包含请求主体，GET 请求参数都在 URL 里面，请求主体一般为空），响应主体中包含了服务器返回给客户端的数据，一般是 HTML 文档或者 JSON 格式数据

```
// 源生的form提交可设置enctype="multipart/form-data"，一般表单中有文件会自动设为该值
<form action="post" enctype="multipart/form-data"></form>

// ajax请求,通过formdata对象来达成此目的
const formdata = new new FormData();
formdata.append("key","value")
$.ajax({
...
data: formdata,
processData: false,    // 取消对数据的预处理，因为formdata不需要预处理
headers: {
   "Content-Type": undefined    // 客户端会自动给它设置正确的值，不要设为multipart/form-data，这样设的后果会导致分隔符不正确
},
...
})

## 请求报文
<method> <request-URL> <version>（请求行）
<headers>

<entity-body>

GET / HTTP/1.1
Host: developer.mozilla.org
Accept-Language: fr

POST http://www.example.com HTTP/1.1
Content-Type: application/x-www-form-urlencoded;charset=utf-8

title=test&sub%5B%5D=1&sub%5B%5D=2&sub%5B%5D=3

POST http://www.example.com HTTP/1.1
Content-Type: application/json;charset=utf-8

## 响应报文
HTTP/1.1 200 OK
Date: Sat, 09 Oct 2010 14:28:02 GMT
Server: Apache
Last-Modified: Tue, 01 Dec 2009 20:18:22 GMT
ETag: "51142bc1-7449-479b075b2891b"
Accept-Ranges: bytes
Content-Length: 29769
Content-Type: text/html
```

![ HTTP 请求处理流程](../_static/http_request.jpg "Optional title")

## 标头

* 通用标头
    - Date:报文创建日期 `Date: Wed, 21 Oct 2015 07:28:00 GMT` 格林威治标准时间，这个时间要比北京时间慢八个小
    - Cache-Control：控制缓存具体的行为 有一些特性是请求标头具有的，有一些是响应标头才有的。主要大类有 可缓存性、阈值性、重新验证并重新加载 和其他特性
    - Connection 决定当前事务（一次三次握手和四次挥手）完成后，是否会关闭网络连接
        + 持久性连接:一次事务完成后不关闭网络连接 `Connection: keep-alive`
        + 非持久性连接:即一次事务完成后关闭网络连接 `Connection: close`
    - HTTP1.1 其他通用标头
        + Pragma: no-cache HTTP/1.1 之前版本的历史遗留字段，仅作为与 HTTP/1.0 的向后兼容而定义,HTTP/1.1 中使用 Cache-Control: no-cache 来替代该字段的功能
        + Trailer:事先说明在报文主体后记录了哪些首部字段，可应用于 HTTP/1.1 版本的分块传输编码
        + `Transfer-Encoding: chunked`:规定了传输报文主体时采用的编码方式,HTTP/1.1 版本的传输编码方式仅对分块传输编码有效
        + Upgrade:用于检测 HTTP 协议及其他协议是否可使用更高的版本进行通信，其参数值可以用来指定一个完全不同的通信协议
        + Via:用于追踪客户端与服务器之间的请求和响应报文的传输路径,报文经过代理或网关时，会先在首部字段 Via 中附加该服务器的信息，然后再进行转发
        + Warning:从 HTTP/1.0 的响应首部字段 Retry-After 演变而来，通常会告知用户一些与缓存相关的问题的警告
* 实体标头:含在请求报文和响应报文中实体部分所使用的首部，用于补充内容的更新时间等与实体相关的信息
    - Allow:用于通知客户端能够服务器针对 Request URL 指定资源能够支持的所有 HTTP 请求方法，当服务器接收到不支持的 HTTP 方法时，会以状态码 405 Method Not Allowed 作为响应返回，与此同时还会把所有能支持的 HTTP 方法写入首部字段 Allow 后返回
    - Content-Length:表明实体主体部分的大小（单位是字节），对实体主体进行分块内容编码传输时，不能再使用 Content-Length 首部字段，即使用了 Transfer-Encoding: chunked 编码，否则其他情况下必须在响应首部中包含此字段
    - Content-Language:用于告知客户端实体主体使用的自然语言
    - Content-Encoding:用于告知客户端服务器对实体的主体部分选用的内容编码方式（一般都是数据压缩方式）。主要有以下几种内容编码方式
        +  gzip
        +  compress
        +  deflate
        +  identity
        +  br
        + Accept-Encoding: gzip, deflate //请求头
        + Content-Encoding: gzip  //响应头
        + 服务器端并不强制要求一定使用哪种内容编码方式。具体采用哪种内容编码方式高度依赖于服务器端的设置，及其所采用的模块
        + Transfer-Encoding 与 Content-Encoding 之间的区别
            * Transfer-Encoding 也是用于指定报文主体传输编码方式，但是逐跳首部，即只在两个相邻节点间有效，跟前面介绍的 TE 首部字段是一对，TE 也是逐跳首部，用于告知服务器客户端能够处理的编码方式和相对优先级
            * Content-Encoding 和 Accept-Encoding 是一对，都是端到端首部，在整个传输过程中有效
    - Content-Location 该字段用于给出与报文主体部分相对应的 URL，和首部字段 Location 不同，Content-Location 表示的是报文主体返回资源对应的 URL
    - Content-MD5 该字段用于检查报文主体在传输过程中是否保持完整，以及确认传输到达。 其实现过程如下：对报文主体执行 MD5 算法得到 128 位二进制数，再通过普通 Base64 编码后将结果写入 Content-MD5 字段值（由于 HTTP 首部无法记录二进制值，所以要通过 Base64 编码处理）
    - `Content-Range: bytes 5001-10000/10000` 针对范围请求，在响应首部中使用该字段能告知客户端作为响应返回的实体的哪个部分符合范围请求，字段值以字节为单位，表示当前发送部分及整个实体大小
    - Content-Type 该字段表示实体主体内对象的媒体类型，和首部字段 Accept 一样，字段值用 type/subtype 形式赋值
    - Expires:该字段将资源失效日期告知客户端，缓存服务器在接收到含有首部字段 Expires 的响应后，会以缓存来应答请求，在 Expires 字段值指定的时间之前，响应的副本会一直保存。当超过指定时间后，缓存服务器在请求发送过来时，会转向源服务器请求资源
        + 当首部字段 Cache-Control 有指定 max-age 指令时，比起首部字段 Expires，会优先处理 max-age 指令
    - Last-Modified:该字段指明资源最新修改的时间，一般来说，这个值就是请求 URL 指定资源被修改的时间。常常与 If-Modified-Since 字段结合使用
* 请求标头
    - Host 请求头指明了服务器的域名（对于虚拟主机来说），以及（可选的）服务器监听的 TCP 端口号。如果没有给定端口号，会自动使用被请求服务的默认端口（比如请求一个 HTTP 的 URL 会自动使用 80 作为端口）`Host: developer.mozilla.org`
    - Accpet、 Accept-Language、Accept-Encoding 都是属于内容协商的请求标头
    - Accept:  会通告客户端其能够理解的 MIME 类型
        + 文本文件：text/html、text/plain、text/css、application/json...
          + 图片文件：image/jpeg、image/gif、image/png...
          + 视频文件：video/mpeg、video/quicktime...
          + 应用程序使用的二进制文件：application/octet-stream、application/zip...
    - `Accept-Charset: utf-8,iso-8859-1;q=0.5`:用来告知服务器用户代理支持的字符集及字符集的相对优先顺序,常用的字符集有：UTF-8 - Unicode 字符编码 ；ISO-8859-1 - 拉丁字母表的字符编码
    - `Accept-Language: zh-CN,zh;q=0.9,en;q=0.8,zh-TW;q=0.7`:告知服务器用户代理能够处理的自然语言集（指中文或英文等），以及自然语言集的相对优先级。可一次指定多种自然语言集
    - `Accept-Encoding: gzip, deflate, br`:告知服务器用户代理支持的内容编码及内容编码的优先级顺序。常见的内容编码如下
        +  gzip：由文件压缩程序 gzip（GNU zip）生成的编码格式（RFC1952），采用 Lempel-Ziv 算法及 32 位循环冗余校验（CRC）；
        +  compress：由 UNIX 文件压缩程序 compress 生成的编码格式，采用 Lempel-Ziv-Welch 算法；
        +  deflate：组合使用 zlib 格式（RFC1950）及由 deflate 压缩算法（RFC1951）生成的编码格式；
        +  br：表示采用 Brotli 算法的编码方式；
        +  identify：不执行压缩或不会变化的默认编码格式
    - Authorization 用来告知服务器用户代理的认证信息。通常，想要通过服务器认证的用户代理会在接收到返回的 401 状态码响应后，把首部字段 Authorization 加入请求
    - Referer: 请求从哪发起的原始资源URI `Referer: https://developer.mozilla.org/testpage.html`
    - Cache-Control 控制缓存具体的行为
        + no-cache    无   强制源服务器再次验证
        + no-store    无   不缓存请求或是响应的任何内容
        + max-age=[秒] 缓存时长，单位是秒   缓存的时长，也是响应的最大的Age值
        + min-fresh=[秒]   必需  期望在指定时间内响应仍然有效
        + no-transform    无   代理不可更改媒体类型
        + only-if-cached  无   从缓存获取
        + cache-extension 无   新的指令标记(token)
    - Pragma HTTP1.0时的遗留字段，当值为"no-cache"时强制验证缓存,优先级高于Cache-Control和Expires `<meta http-equiv="Pragma" content="no-cache">`
        + 仅有IE才能识别这段meta标签含义
        + 服务端响应添加'Pragma': 'no-cache'，浏览器表现行为和强制刷新类似
    - Cookie: cookie信息
    - Content-Encoding：
        + 文档的编码(Encode)方法。只有在解码之后才可以得到 Content-Type 头指定的内容类型
        + 利用gzip压缩文档能够显著地减少HTML文档的下载时间
    - Content-Length：表示内容长度。只有当浏览器使用持久 HTTP 连接时才需要这个数据
    - Content-Type： 用来向浏览器和服务器提供信息，表示该 URL 对应的资源类型。服务端通常是根据请求头（headers）中的 Content-Type 字段来获知请求中的消息主体是用何种方式编码，再对主体进行解析。表示后面的文档属于什么 MIME 类型
        + application/x-www-form-urlencoded：以键值对的字符串传输，但不能传输文件
        + multipart/form-data：以键值对的形式通过分隔符链接，以字符串给后台，可以传输文件，也可以传输普通数据
        + text/plain：普通文本，可以是任意数据，除了文件。
        + binary：二进制流，仅限一个文件
        + Data-Type：希望返回什么类型的数据
        + 类型
            * .css    text/css
            * .gif    image/gif
            * .htm|.html   text/html
            * .jpeg|.jpg    image/jpeg
            * .js application/x-javascript
            * .ico    image/x-icon
            * .mp3    audio/mp3
            * .mp4    video/mpeg4
            * .mpeg|.mpg    video/mpg
            * .pdf    application/pdf
            * .png    image/png
            * .tif|.tiff   image/tiff
            * .torrent    application/x-bittorrent
            * .wav    audio/wav
            * .xhtml  text/html
    - Date：创建报文的日期时间(启发式缓存阶段会用到这个字段)
    - Expires：告知客户端资源缓存失效的绝对时间
    - Expect 该字段用于告知服务器期望出现的某种特定行为，因服务器无法理解客户端的期望作出回应而发生错误时，会返回状态码 417 Expectation Failed
    - Last-Modified：文档的最后改动时间。客户可以通过 If-Modified-Since 请求头提供一个日期，服务器端的资源没有变化,只有改动时间迟于指定时间的文档才会返回，否则返回一个 304(Not Modified) 状态
    - If-Match  条件请求，服务器收到携带上一次请求中资源的ETag，只有判断指定条件为真时，才会执行请求，常用于实现缓存相关功能
        + 首部字段 If-Match 属于附带条件之一，会告知服务器匹配资源所用的实体标记（ETag）值，这时的服务器无法使用弱 ETag 值（以 W/ 开头）
        + 服务器会对比 If-Match 字段值和资源的 ETag 值，仅当两者一致时，才会执行请求，反之，则返回状态码 412 Precondition Failed 响应。
        + 可以使用星号 * 指定 If-Match 的字段值，针对这种情况，服务器将会忽略 ETag 的值，只要资源存在就处理请求
    - If-None-Match   和If-Match作用相反，服务器根据这个字段判断文件是否有新的修改.使请求成为条件请求。对于 GET 和 HEAD 方法，仅当服务器没有与给定资源匹配的 ETag 时，服务器才会以 200 状态发送回请求的资源。对于其他方法，仅当最终现有资源的ETag与列出的任何值都不匹配时，才会处理请求。`If-None-Match: "c561c68d0ba92bbeb8b0fff2a9199f722e3a621a"`
    - If-Modified-Since:该字段会告知服务器若 If-Modified-Since 字段值早于资源的更新时间，则希望能够处理该请求。反之则返回状态码 304 Not Modified 响应.比较资源前后两次访问最后的修改时间是否一致 通常会与 If-None-Match 搭配使用，用于确认代理或客户端拥有的本地资源的有效性。获取资源的更新日期时间，可通过确认首部字段 Last-Modified 来确定 `If-Modified-Since: Mon, 18 Jul 2016 02:36:04 GMT`
        + 如果在 Last-Modified 之后更新了服务器资源，那么服务器会响应 200，如果在 Last-Modified 之后没有更新过资源，则返回 304
    - If-Unmodified-Since 比较资源前后两次访问最后的修改时间是否一致
    - If-Range:该字段用于告知告知服务器若指定的 If-Range 字段值（ETag 值或时间）和请求资源的 ETag 值或时间相一致，则作为范围请求处理，否则返回全体资源
    - Max-Forwards:通过 TRACE 方法或 OPTIONS 方法发送包含首部字段 Max-Forwards 的请求时，该字段以十进制整数形式指定可经过的服务器最大数目。服务器在往下一个服务器转发请求之前，Max-Forwards 的值减1后重新赋值。当服务器接收到 Max-Forwards 值为 0 的请求时，不再进行转发，而是直接返回响应
    - Proxy-Authorization:接收到从代理服务器发来的认证质询时，客户端会发送包含首部字段 Proxy-Authorization 的请求，以告知服务器认证所需要的信息。该行为和客户端与服务器之间的 HTTP 访问认证相似（对应的首部字段是 Authorization），不过认证行为是发生在客户端与代理之间
    - Location：表示客户应当到哪里去提取文档
    - Refresh：表示浏览器应该在多少时间之后刷新文档，以秒计
        + 通过设置 HTML 页面 HEAD 区的 `＜META HTTP-EQUIV=”Refresh” CONTENT=”5;URL=http://host/path"＞`实现
        + 意义是”N秒之后刷新本页面或访问指定页面”，而不是”每隔N秒刷新本页面或访问指定页面”。因此，连续刷新要求每次都发送一个Refresh头，而发送204状态代码则可以阻止浏览器继续刷新，不管是使用Refresh头还是`＜META HTTP-EQUIV=”Refresh” …＞`
        + 不属于 HTTP 1.1 正式规范的一部分，而是一个扩展
    - Range 对于只需要获取部分资源的范围请求，包含首部字段 Range 即可告知服务器资源的指定范围。 接收到附带 Range 首部字段请求的服务器，会在处理请求之后返回状态码 206 Partial Content 的响应。无法处理该范围请求时，则会返回状态码 200 OK 的响应及全部资源
    - Referer 该字段用于告知服务器当前请求的上一个请求对应资源的 URL
    - Server：服务器名字
    - Set-Cookie：设置和页面关联的 Cookie
    - 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36': 会将创建请求的浏览器和用户代理名称等信息传达给服务器
    - WWW-Authenticate：客户应该在 Authorization 头中提供什么类型的授权信息？在包含401(Unauthorized) 状态行的应答中这个头是必需的
* 响应标头
    - Accept-Ranges 该字段用来告知客户端服务器是否能处理范围请求，以指定获取服务器端某个部分的资源。可指定的字段值有两种，可处理范围请求时指定其为 bytes，反之指定其为 none
    - Access-Control-Allow-Origin:指定一个来源，告诉浏览器允许该来源进行资源访问
    - Keep-Alive: Connection 非持续连接的存活时间，可以进行指定
    - Server:用于告知客户端当前服务器上安装的 HTTP 服务器应用程序的信息，字段值中不仅会标出 HTTP 服务器软件应用名称，还会包含版本号和安装时启用的可选项
    - Proxy-Authenticate 该字段会把由代理服务器所要求的认证信息发送给客户端。它与客户端和服务器之间的 HTTP 访问认证的行为相似，不同之处在于其认证行为是在客户端与代理之间进行的，而客户端与服务器之间进行认证时，首部字段 WWW-Authorization 有着相同的作用
    - Retry-After:该字段用于告知客户端应该在多久之后再次发送请求，主要配合状态码 503 Service Unavailable 响应，或 3XX Redirect 响应一起使用。字段值可以是具体的日期时间，也就是创建响应后的秒数
    - Cache-Control 控制缓存具体的行为
        + public    无   任意一方都能缓存该资源(客户端、代理服务器等)
        + private 可省略 只能特定用户缓存该资源
        + no-cache    可省略 缓存前必须先确认其有效性
        + no-store    无   不缓存请求或响应的任何内容
        + no-transform    无   代理不可更改媒体类型
        + must-revalidate 无   可缓存但必须再向源服务器进确认
        + proxy-revalidate    无   要求中间缓存服务器对缓存的响应有效性再进行确认
        + max-age=[秒] 缓存时长，单位是秒   缓存的时长，也是响应的最大的Age值
        + s-maxage=[秒]    必需  公共缓存服务器响应的最大Age值
        + cache-extension -   新指令标记(token)
    - Location: 可以将响应接收方引导至某个与请求 URL 位置不同的资源,会配合 3XX：Redirection 响应，提供重定向的 URL
    - Server: 被请求的服务web server的信息,含有关原始服务器用来处理请求的软件的信息,含有关原始服务器用来处理请求的软件的信息 `Server: Apache/2.4.1 (Unix)`
    - Set-Cookie: 服务器向客户端发送 sessionID
    - Transfer-Encoding 规定了传输报文主体时采用的编码方式,HTTP /1.1 的传输编码方式仅对分块传输编码有效
    - X-Frame-Options:HTTP 首部字段是可以自行扩展的。所以在 Web 服务器和浏览器的应用上，会出现各种非标准的首部字段. 用于控制网站内容在其他 Web 网站的 Frame 标签内的显示问题。其主要目的是为了防止点击劫持（clickjacking）攻击
    - NAME: 要设置的键值对
    - WWW-Authenticate:该字段用于 HTTP 访问认证，它会告知客户端适用于访问请求 URL 所指定资源的认证方案（Basic 或 Digest）和带参数提示的质询。状态码 401 Unauthorized 响应中，肯定带有首部字段 WWW-Authenticate
    - ETag:用于告知客户端服务器资源的实体标识，它是一种可将资源以字符串做唯一性标识的方式。服务器会为每份资源分配对应的 ETag 值
        + 当资源更新时，ETag 值也需要更新，生成 ETag 值时，并没有统一的算法规则，而仅仅是由服务器来分配
        + 字段值有强弱之分：
            * 强 ETag 值：不论实体发生多么细微的变化都会改变其值；
           * 弱 ETag 值：只用于提示资源是否相同，只有资源发生了根本变化，产生差异时才会改变 ETag 值，这时，会在字段值开头附加 W/，例如：ETag: W/"usagi-1234"
    - Vary :可对缓存进行控制，源服务器会向代理服务器传达关于本地缓存使用方法的命令。从代理服务器接收到源服务器返回包含 Vary 指定项的响应之后，若再要进行缓存，仅对请求中含有相同 Vary 指定首部字段的请求返回缓存
    - Age 资源在缓存代理中存贮的时长(取决于max-age和s-maxage的大小) 用于告知客户端源服务器在多久前创建了响应，字段值的单位为秒。若创建该响应的服务器是缓存服务器，Age 值是指缓存后的响应再次发起认证到认证完成的时间值，代理创建响应时必须加上首部字段 Age
    - Allow：服务器支持哪些请求方法（如GET、POST等）
* 扩展字段:引入 Cookie 的初衷就是实现客户端用户识别和状态管理
    - 调用 Cookie 时，由于可以校验 Cookie 的有效期，以及发送方的域（Domain）、路径（URL Path）、协议等信息，所以正规发布的 Cookie 内的数据不会因来自其它 Web 站点和攻击者的攻击而泄露
    - Set-Cookie:该字段用于响应首部，服务器通过该字段将需要设置的 Cookie 信息告知客户端，客户端接收到响应后将相应的 Cookie 信息存储到本地 `Set-Cookie: laravel_session=eyJpdiI6InpDTWIxczdmK2hJZ1hPcWVsRU9uRUE9PSIsInZhbHVlIjoib244YVppNWFWdU04K3kxT3pUM3FmTWVqNkYxQXo3QUJHRzV0OWZnOEE1TzZKZGxxNHlpaXZnNlwvYzRrZ0RcL1lrIiwibWFjIjoiODZlZDgzNzlmNmNkZTJhNGFmNThmYTE2NGYxMTIyM2EwNGY5ZThkZmQ5MDU0NWQ0ZTJlY2M1ZTJmNjJmNDIzMiJ9; expires=Wed, 24-Apr-2019 04:03:23 GMT; Max-Age=7200; path=/; httponly`
        + expires: 指定 Cookie 的有效期，省略的话默认在浏览器会话时间内有效（浏览器关闭失效），Cookie 一旦发送至客户端，就不能在服务器端显式删除，只能通过覆盖实现对客户端 Cookie 的「删除」
        + Max-Age：和 expires 作用类似，用于指定从现在开始该 Cookie 存在的秒数，如果同时指定了 expires 和 Max-Age，那么 Max-Age 的值将优先生效
        + path: 指定 Cookie 生效的路径，默认路径是根路径 /
        + domain: 指定 Cookie 所属的域名，省略的话默认是当前域名，Cookie 只有在所属域名下才能获取，不能跨域名获取 Cookie
        + Secure: 限制浏览器只有在页面启用 HTTPS 安全连接时才可以发送 Cookie
        + httponly: 指定之后javascript无法读取cookie,主要目的是为了防止跨站脚本攻击（XSS）对 Cookie 信息的窃取
    - Cookie 该字段用于请求首部，客户端通过该字段告知服务器当客户端想要获取 HTTP 状态管理支持时，就会在请求中包含从服务器接收到的 Cookie `Cookie: hello=eyJpdiI6IktlV2RlQUhnbDBJN2Z0UUhFSHl3bkE9PSIsInZhbHVlIjoieElBdFpOV3crNm5IZytnRzlJUW1LUT09IiwibWFjIjoiNzFiZGEzMzg1MzgyYTMyYjM0YzcyNTViZWU2NGI2MDM2NzJhMGEwNmFkYWE5ZGY4N2I5ZDA4ZWQ0NmVkZjcyOCJ9; XSRF-TOKEN=eyJpdiI6IndOeWNWVmxXVEdpZkdlWFFkMENtckE9PSIsInZhbHVlIjoiYWJNb28yMlROWE1YOEVyTnhrbmJwYjRpdHB3S2diUDBcLzI2d1ViNXpRYkxzb2pMZEZWVll0cVFoejhlNG1jdEwiLCJtYWMiOiI1NzUwMWRjYzhjMjAwMDkwMWI4NDY0ZTIzMzY2NDYwMDY1NmYzZmMyOTA3ZjM2YTRmN2FmM2U1OGU3MWQyNTVkIn0%3D; laravel_session=eyJpdiI6ImpwcWx6SGttbUlCU2dCREVyRWp1WFE9PSIsInZhbHVlIjoiU0djd0Vjc3JRZzNuWUgyUWlRSStiUURcL2RPWFpxdjBjdXRrdVRjZ1hzdDZpTGNzZWtKNXpVTTJlXC9Fbms3ZWpqIiwibWFjIjoiMmI0NmJiZWYyOGViOGI5ZDVhY2EwMjI4NjAwODYwMzg1ZGZlODY0NjExNzIzMjczMGRiMjdjNDIyMTdiNzQ1MCJ9`

### 请求方式

* GET：从服务器上获取指定的 URL 资源，只应当用于取回数据，查询字符串（名称/值对）是在请求 URL 中发送
    - 不会对服务器资源产生副作用（只是获取资源，不会对资源进行变更
    - 通过 GET 请求变更服务器资源有重大安全隐患，在开发过程中要避免
* POST: 向指定资源提交被处理数据，查询字符串（名称/值对）是在 POST 请求的 HTTP 消息主体中发送(对用户不可见)
    - application/x-www-form-urlencoded：原生 form 表单
    - multipart/form-data：用于上传文件,生成了一个 boundary 用于分割不同的字段，为了避免与正文内容重复，boundary 很长很复杂
    - application/json:支持比键值对复杂得多的结构化数据:php 就无法通过 `$_POST` 对象从上面的请求中获得内容,从 `php://input` 里获得原始输入流，再 json_decode 成对象
    - text/xml:XML 作为编码方式的远程调用规范
* GET vs POST
    - GET参数通过URL传递，POST放在Request body中
    - GET传送的参数是有长度限制，而POST没有
    - GET比POST更不安全，因为参数直接暴露在URL上，所以不能用来传递敏感信息
    - GET请求会被浏览器主动可被缓存，而POST不会，除非手动设置
    - GET请求只能进行url编码，而POST支持多种编码方式
    - GET请求参数会被完整保留在浏览器历史记录里(或者收藏为书签)，而POST中的参数不会被保留
    - GET请求在浏览器反复的 回退/前进 操作是无害的，而 post 操作会再次提交表单请求
    - 参数数据类型，GET只接受ASCII字符，而POST没有限制
    - 浏览器限制单次运输量来控制风险，数据量太大对浏览器和服务器都是很大负担:GET产生一个TCP数据包；POST产生两个TCP数据包
        + GET请求:浏览器会把http header和data一并发送出去，服务器响应200（返回数据）
        + POST请求:浏览器先发送header，服务器响应100 continue，浏览器再发送data，服务器响应200 ok
* HEAD  与 GET 相同，但只返回 HTTP 报头，不返回文档主体,用于确认 URL 的有效性及资源更新的日期时间
* PUT:设计的初衷是用来传输文件, 要求在报文的主体中包含文件内容，然后保存到请求 URI 指定的位置.由于 PUT 方法自身不带验证机制，任何人都可以上传文件，存在安全性问题.让服务器用请求主体部分来创建|更新一个由请求的 URL 命令的新文档
* PATCH 方法，用于对指定资源进行部分修改（PUT 方法用于整体覆盖）
* DELETE  删除指定资源
    - 200（OK）——删除成功，同时返回已经删除的资源
    - 202（Accepted）——删除请求已经接受，但没有被立即执行（资源也许已经被转移到了待删除区域）
    - 204（No Content）——删除请求已经被执行，但是没有返回资源（也许是请求删除不存在的资源造成的）
* OPTIONS 查询针对请求 URL 指定的资源支持的所有 HTTP 方法
* CONNECT 把请求连接转换到透明的 TCP/IP 通道
* TRACE 允许客户端在最终请求发送给服务器时，看看它变成了什么样子。主要用于 HTTP 通信的诊断和调试
    - 会在目标服务器端发起一个「环回」诊断，行程最后一站的服务器会返回一条 TRACE 响应，并在响应主体中携带它收到的原始请求报文，这样，客户端就可以查看在所有中间 HTTP 应用程序组成的请求/响应链上，原始报文是否以及如何被修改过

```
POST http://www.example.com HTTP/1.1
Content-Type:multipart/form-data; boundary=----WebKitFormBoundaryrGKCBY7qhFd3TrwA

------WebKitFormBoundaryrGKCBY7qhFd3TrwA
Content-Disposition: form-data; name="text"

title
------WebKitFormBoundaryrGKCBY7qhFd3TrwA
Content-Disposition: form-data; name="file"; filename="chrome.png"
Content-Type: image/png

PNG ... content of chrome.png ...
------WebKitFormBoundaryrGKCBY7qhFd3TrwA--

nc -z -v 127.0.0.1 8889
curl "http://127.0.0.1:8889/" -vv
```

## HTTP控制常见特性

* 缓存：文档如何缓存能通过HTTP来控制。服务端能告诉代理和客户端哪些文档需要被缓存，缓存多久，而客户端也能够命令中间的缓存代理来忽略存储的文档。
* 开放同源限制：为了防止网络窥听和其它隐私泄漏，浏览器强制对Web网站做了分割限制。只有来自于相同来源的网页才能够获取网站的全部信息。这样的限制有时反而成了负担，HTTP可以通过修改头部来开放这样的限制，因此Web文档可以是由不同域下的信息拼接成的（某些情况下，这样做还有安全因素考虑）
* 认证：一些页面能够被保护起来，仅让特定的用户进行访问。基本的认证功能可以直接通过HTTP提供，使用Authenticate相似的头部即可，或用HTTP Cookies来设置指定的会话。
* 代理和隧道：通常情况下，服务器和/或客户端是处于内网的，对外网隐藏真实 IP 地址。因此 HTTP 请求就要通过代理越过这个网络屏障。但并非所有的代理都是 HTTP 代理。例如，SOCKS协议的代理就运作在更底层，一些像 FTP 这样的协议也能够被它们处理。
* 会话：使用HTTP Cookies允许你用一个服务端的状态发起请求，这就创建了会话。虽然基本的HTTP是无状态协议。这很有用，不仅是因为这能应用到像购物车这样的电商业务上，更是因为这使得任何网站都能轻松为用户定制展示内容了。

### 状态码 Status Code

HTTP 状态码包含三个十进制数字，第一个数字是类别，后俩是编号

* 1XX 信息：服务器收到请求，需要请求者继续执行操作
    - 100 Continue：继续。客户端应继续其请求
    - 101 Switching Protocols：切换协议。服务器根据客户端的请求切换协议。只能切换到更高级的协议，例如，切换到 HTTP 的新版本协议
    -  102 服务器收到并处理请求，但无响应可用
* 2XX 成功：操作被成功接收并处理
    - 200 OK：请求成功。一般用于 GET 与 POST 请求
    - 201 Created：已创建。成功请求并创建了新的资源
    - 202 Accepted：已接受。已经接受请求，但未处理完成
    - 203 Non-Authoritative Information：非授权信息。请求成功。但返回的 meta 信息不在原始的服务器，而是一个副本
    - 204 No Content：无内容。服务器成功处理，但未返回内容。在未更新网页的情况下，可确保浏览器继续显示当前文档
    - 205 Reset Content：重置内容。服务器处理成功，用户终端（例如：浏览器）应重置文档视图。可通过此返回码清除浏览器的表单域
    - 206 Partial Content：部分内容。服务器成功处理了部分GET请求
    - 3XX 重定向：需要进一步的操作以完成请求
* 300 Multiple Choices：多种选择。请求的资源可包括多个位置，相应可返回一个资源特征与地址的列表用于用户终端（例如：浏览器）选择
    - 301 Moved Permanently：永久移动。请求的资源已被永久的移动到新 URI，返回信息会包括新的 URI，浏览器会自动定向到新URI。今后任何新的请求都应使用新的URI代替
    - 302 tempoery Permanently：临时移动。与 301 类似。但资源只是临时被移动。客户端应继续使用原有 URI
    - 303 See Other：查看其它地址。与 301 类似。使用 GET 和 POST 请求查看
    - 304 Not Modified：未修改。所请求的资源未修改，服务器返回此状态码时，不会返回任何资源。客户端通常会缓存访问过的资源，通过提供一个头信息指出客户端希望只返回在指定日期之后修改的资源
    - 305 Use Proxy：使用代理。所请求的资源必须通过代理访问
    - 306 Unused：已经被废弃的HTTP状态码
    - 307 Temporary Redirect：临时重定向。与 302 类似。使用 GET 请求重定向
* 4XX 客户端错误：请求包含语法错误或无法完成请求
    - 400 Bad Request：客户端请求的语法错误，服务器无法理解
    - 401 Unauthorized：请求要求用户的身份认证
    - 402 Payment Required：保留，将来使用
    - 403 Forbidden：服务器理解请求客户端的请求，但是拒绝执行此请求
    - 404 Not Found：服务器无法根据客户端的请求找到资源（网页）。通过此代码，网站设计人员可设置”您所请求的资源无法找到”的个性页面
    - 405 Method Not Allowed：客户端请求中的方法被禁止
    - 406 Not Acceptable：服务器无法根据客户端请求的内容特性完成请求
    - 407 Proxy Authentication Required：请求要求代理的身份认证，与401类似，但请求者应当使用代理进行授权
    - 408 Request Time-out：服务器等待客户端发送的请求时间过长，超时
    - 409 Conflict：服务器完成客户端的PUT请求是可能返回此代码，服务器处理请求时发生了冲突
    - 410 Gone：客户端请求的资源已经不存在。410 不同于 404，如果资源以前有现在被永久删除了可使用 410 代码，网站设计人员可通过 301 代码指定资源的新位置
    - 411 Length Required：服务器无法处理客户端发送的不带 Content-Length 的请求信息
    - 412 Precondition Failed：客户端请求信息的先决条件错误
    - 413 Request Entity Too Large：由于请求的实体过大，服务器无法处理，因此拒绝请求。为防止客户端的连续请求，服务器可能会关闭连接。如果只是服务器暂时无法处理，则会包含一个 Retry-After 的响应信息
    - 414 Request-URI Too Large：请求的URI过长（URI通常为网址），服务器无法处理
    - 415 Unsupported Media Type：服务器无法处理请求附带的媒体格式
    - 416 Requested range not satisfiable：客户端请求的范围无效
    - 417 Expectation Failed
* 5XX 服务器端错误：服务器在处理请求的过程中发生了错误
    - 500 Internal Server Error：服务器内部错误，无法完成请求
    - 501 Not Implemented：服务器不支持请求的功能，无法完成请求
    - 502 Bad Gateway：充当网关或代理的服务器，从远端服务器接收到了一个无效的请求
    - 503 Service Unavailable：由于超载或系统维护，服务器暂时的无法处理客户端的请求。延时的长度可包含在服务器的Retry-After头信息中
    - 504 Gateway Time-out：充当网关或代理的服务器，未及时从远端服务器获取请求
    - 505 HTTP Version not supported：服务器不支持请求的HTTP协议的版本，无法完成处理

## 缓存

* 基于 HTTP 协议实现的缓存，存储在 HTTP 客户端，通过请求头或响应头来协商和标识
* 原因：同一个客户端发起多次请求返回的都是同一个文件，这样就会对服务器的带宽造成浪费，同时也会加重 Web 服务器的负载，降低 Web 服务器的性能
* 种类
    - 私有缓存：作用于单个用户，通常就是浏览器缓存；
    - 共享缓存：往往存放在可以被多个用户共享的代理之中，所以有时候也叫代理缓存
* 原理
    - 接收：读取请求报文
    - 解析：对请求报文进行解析，提取 URL 和各种首部字段
    - 查询：查看是否有本地缓存可用，如果没有，则从服务器获取相应的资源并存储到本地
    - 新鲜度检查：缓存不会一直有效，所谓的「新鲜度」指的是和食品的保质期类似，缓存是有有效期的，在有效期之内才可以使用，否则需要向服务器查询对应资源是否有更新
    - 创建响应：缓存会用新的首部和缓存的响应主体来构建响应报文
    - 发送：将响应发送给客户端
    - 日志：缓存可以创建一条日志来记录这个 HTTP 事务
* 通常只会对 GET 请求资源进行缓存，因为只有 GET 请求不会对资源实体的状态进行改变，OPTIONS 请求不返回响应实体没有缓存的意义，而其他诸如 POST、PUT、DELETE、PATCH 这些会改变资源状态的请求则不能进行缓存
* 策略
    - 强制缓存：Expires->Cache-Control
    - 对比缓存：如果响应头 Cache-Control 中设置了 no-cache，则需要客户端发送相应的请求协商头（If-Modified-Since/If-None-Match），与服务端对应字段（Last-Modified/Etag）对比验证缓存是否过期来实现 HTTP 缓存。返回的响应状态码是 304
* Expires：值为服务端返回的缓存资源到期时间（绝对时间），即下一次请求时，请求时间小于服务端返回的到期时间，直接使用缓存数据
    - 时间由服务端生成,是 GMT 格式的标准时间，如 Fri, 01 Jan 1990 00:00:00 GMT
    - 单独的过期时间机制，浏览器端可以随意修改时间，导致缓存使用不精准
    - 是 HTTP/1.0 的东西，现在浏览器均默认使用 HTTP/1.1，所以它的作用基本忽略
    - 客户端时间可能跟服务端时间有误差，这就会导致缓存命中的误差, HTTP/1.1 使用 Cache-Control 替代该字段
    - 如果在 Cache-Control 响应头设置了 max-age 或者 s-max-age 指令，那么 Expires 头也会被忽略
* Cache-Control：通用首部字段,可以设置多个属性值，不同属性值之间通过逗号分隔.缓存控制字段，精确控制缓存策略。对缓存的控制粒度更细，包括缓存代理服务器的缓存控制
    - no-store:浏览器和中间代理服务器禁止进行缓存，缓存中不得存储任何关于客户端请求和服务端响应的内容，每次由客户端发起的请求都会从服务端下载完整的响应内容
    - no-cache:强制确认缓存，每次有请求发出时，缓存会将此请求发到服务器（该请求应该会带有与本地缓存相关的验证字段），服务器端会验证请求中所描述的缓存是否过期，若未过期，则缓存才使用本地缓存副本。该属性和 HTTP/1.0 中的 Pragma: no-cache 等效。
    - public:用于共享缓存，任何中间代理都可以缓存响应
    - private:用于私有缓存，只有客户端浏览器才可以缓存响应，没有指定 public 时，默认为 private
    - must-revalidate:在考虑使用一个陈旧的资源时，必须先验证它的状态，已过期的缓存将不被使用
        + 与 no-cache 的区别在于，使用 no-cache 时，不管本地资源缓存副本是否过期，使用资源缓存副本前，一定要到源服务器进行副本有效性校验
        + must-revalidate 则不然，只有在本地资源缓存副本过期后，才去源服务器进行有效性检测
    - proxy-revalidate，要求缓存服务器针对缓存资源向源服务器进行确认
    - max-age=10秒:是距离请求发起时间的秒数，是一个相对值，从而可以避免客户端与服务端时间不一致导致的误差，如果在响应头中两者都存在，则以 max-age 为准，Expires 自动失效
    - s-maxage：缓存服务器对资源缓存的最大时间
* Last-Modified:响应头，告知客户端资源的最后修改时间
    - 客户端再次请求该资源时，会在 If-Modified-Since 请求头字段中带上上次请求返回的最后修改时间，服务器收到请求报文后发现请求头包含 If-Modified-Since 字段，则与被请求资源的最后修改时间进行对比
    - 如果资源的最后修改时间大于 If-Modified-Since 字段值，说明资源又被改动过，则返回完整的资源内容，对应响应状态码为 200
    - 如果资源的最后修改时间小于或等于 If-Modified-Since 字段值，说明资源没有做新的修改，则返回状态码 304，告知浏览器使用本地保存的缓存作为响应实体
* Etag：响应头，告知客户端资源在服务器的唯一标识（生成规则由服务器指定，每当资源发生修改后 Etag 值会变化），是文件内容的唯一 ID
    - 当客户端再次请求该资源时，通过 If-None-Match 字段通知服务器客户段缓存资源数据的唯一标识。服务器收到请求报文后发现请求头包含 If-None-Match 字段，则与被请求资源的唯一标识进行对比，如果不同，说明资源又被改动过，则返回完整的资源内容，对应响应状态码为 200；如果相同，说明资源没有做新的修改，则返回状态码 304，告知浏览器使用本地保存的缓存作为响应实体
    - Etag/If-None-Match 的优先级要高于 Last-Modified/If-Modified-Since
* 主动通知
    - 添加版本号
    - 以 MD5hash 值来区分
* 行为与缓存
    - Expires/Cache-Control: 有效：地址栏 页面链接跳转 新开窗口 前进后退;  无效：F5 ctrl+f5
    - Etag/Last-Modified: 有效：地址栏 页面链接跳转 新开窗口 前进后退 F5;  无效： ctrl+f5
* 无法缓存
    - HTTP信息头中包含Cache-Control:no-cache，pragma:no-cache（HTTP1.0），或Cache-Control:max-age=0等告诉浏览器不用缓存的请求
    - 需要根据Cookie，认证信息等决定输入内容的动态请求是不能被缓存的
    - 经过HTTPS安全加密的请求（有人也经过测试发现，ie其实在头部加入Cache-Control：max-age信息，firefox在头部加入Cache-Control:Public之后，能够对HTTPS的资源进行缓寸）
    - 经过HTTPS安全加密的请求（有人也经过测试发现，ie其实在头部加入Cache-Control：max-age信息，firefox在头部加入Cache-Control:Public之后，能够对HTTPS的资源进行缓存，参考《HTTPS的七个误解》）
    - POST请求无法被缓存
    - HTTP响应头中不包含Last-Modified/Etag，也不包含Cache-Control/Expires的请求无法被缓存
* 网关缓存：存放在服务器网关而非客户端浏览器或中间代理中，Cache-Control 响应头中需要设置 public 属性
    - 反向代理缓存：反向代理服务器有 Nginx、Squid、Varnish 等
    - [CDN 缓存](CDN.md)

![浏览器缓存](../_static/browser_cache.png "Optional title")

## 附带身份凭证的请求

需要设置 XMLHttpRequest 的某个特殊标志位

* 请求配置需添加 withCredentials 标志设置为 true
* 服务器端的响应中设置响应头 Access-Control-Allow-Credentials: true
* 服务器不得设置 Access-Control-Allow-Origin 的值为“*”。
    * 因为请求的首部中携带了 Cookie 信息，如果 Access-Control-Allow-Origin 的值为“*”，请求将会失败。而将 Access-Control-Allow-Origin 的值设置为 foo.example，则请求将成功执行
    * 响应首部中也携带了 Set-Cookie 字段，尝试对 Cookie 进行修改。如果操作失败，将会抛出异常。

## HTTPS（HyperText Transfer Protocol over Secure Socket Layer）

* HTTP缺点
    - 通信使用明文，内容可能会被窃听：HTTP 协议本身不具备加密功能，所以无法对通信整体（请求和响应的内容）进行加密，即 HTTP 报文使用明文方式发送。按照 TCP/IP 协议族的工作机制，通信内容在所有线路上都有可能被窃听。
    - 不验证通信方的身份，因此有可能遭遇伪装：HTTP 协议中的请求和响应不会对通信方进行确认，所以任何人都可以发起请求，另外，服务器只要接收到请求，不管对方是谁都会返回一个响应，即使是伪装的客户端。另外，即使是无意义的请求也会处理，无法阻止海量请求下的 DoS 攻击。
    - 无法证明报文的完整性，所以有可能已遭篡改：没有任何办法确认发出的请求/响应和接收到的请求/响应是前后相同的，请求或响应在传输途中，遭攻击者拦截并篡改内容的攻击称为中间人攻击（Main-in-the-Middle attack，MITM）
* HTTP下加入SSL(Secure Sockets Layer 安全套接层),将 HTTP 通信接口部分用 SSL 协议代替,身披 SSL 协议外壳的 HTTP 而已.SSL 会建立一个安全的通信线路，在此线路上传输的内容都会经过加密处理，此外 SSL 还通过证书的方式来确认通信双方的身份，这样就可以从源头上杜绝了通信方被伪装以及信息被窃听和篡改的可能性，从而确保 HTTP 通信的安全
* HTTPS = HTTP 协议(进行通信) + SSL/TLS 协议（加密数据包），增加的 S 代表 Secure
    - SSL（Secure Sockets Layer 安全套接字层）:一项标准技术，用于在客户端与服务器之间进行加密通信，可确保互联网连接安全，防止网络犯罪分子读取和修改任何传输信息，包括个人资料。使用40 位关键字作为RC4流加密算法
    - TSL（Transport Layer Security 传输层安全）:是 SSL 的继承协议，建立在 SSL 3.0 协议规范之上，是更为安全的升级版 SSL
    - 采用 SSL 后，HTTP 就拥有了 HTTPS 的加密、证书和完整性保护等功能
    - 其它运行在应用层的 SMTP 和 Telnet 等协议均可配合 SSL 协议使用
* 数字证书
    - 通过 OpenSSL 提供的命令就可以生成私钥和公钥，但是需要权威机构颁发证书（Certificate）才能被承认，否则无法判断通信中传递的公钥是否是目标服务器返回的
    - 生成证书需要发起一个证书请求，然后将这个请求发给一个权威机构（客户端和服务端都信任的第三方结构）去认证，这个权威机构称之为 CA（Certificate Authority）。权威机构会给证书敲一个章，也就是所谓的签名算法
    - 签名算法大概是这样工作的：一般是对信息做一个 Hash 计算，得到一个 Hash 值，这个过程是不可逆的，也就是说无法通过 Hash 值得出原来的信息内容。在把信息发送出去时，把这个 Hash 值通过 CA 的私钥加密后，作为一个签名和信息一起发出去
    - CA 用自己的私钥给网站的公钥签名，就相当于给网站背书，形成了网站的证书
    - CA 的公钥需要更牛的 CA 给它签名，形成 CA 的证书，要想看 CA 的证书是否可靠，要看 CA 的上级证书的公钥，能不能解开这个 CA 的签名。这样层层上去，直到全球皆知的几个著名大 CA，称为 root CA，做最后的背书。通过这种层层授信背书的方式，从而保证了非对称加密模式的正常运转
    - 服务器会将这份 CA 颁发的公钥证书（也可以叫做数字证书）发送给客户端，以进行非对称加密方式通信
    - 接到证书的客户端可使用 CA 提供的公钥，对那张证书上的数字签名进行验证，一旦验证通过，客户端便可明确两件事：
        + 认证服务器公钥的是真实有效的数字证书认证机构
        + 服务器的公钥是值得信赖的
* HTTPS 综合运用了这两种加密方式的优势:使用非对称加密传输对称加密需要用到的密钥，而真正的双方大数据量的通信都是通过对称加密进行的，结合数字证书（包含公钥信息）验证服务端公钥的真实性
    - 启动和使用 TLS 加密的通信会话的过程。在 TLS 握手期间，Internet 中的通信双方会彼此交换信息，验证密码套件，交换会话密钥,会根据所使用的密钥交换算法的类型和双方支持的密码套件而不同
    - ClientHello：客户端通过向服务器发送 hello 消息开始建立与服务器的 SSL 通信。报文中包含了 客户端支持的 TLS 版本号(TLS1.0 、TLS1.2、TLS1.3) 、客户端支持的密码套件、加密组件、压缩算法等信息，另外，还有一个随机数，用于后续对称加密密钥的协商
    - ServerHello：服务器可以进行 SSL 通信时，会以 Server Hello 报文作为应答，含 SSL 协议版本、加密组件、压缩算法等信息，同时还有一个随机数，用于后续对称加密密钥的协商
    - 服务器会以 Certificate 报文的形式给客户端发送服务端的数字证书，其中包含了非对称加密用到的公钥信息。最后，服务器还会发送 Server Hello Done 报文告知客户端，最初阶段的 SSL 握手协商部分结束
    - 认证(Authentication)：客户端的证书颁发机构会认证 SSL 证书，然后发送 Certificate 报文，报文中包含公开密钥证书。最后服务器发送 ServerHelloDone 作为 hello 请求的响应。第一部分握手阶段结束
    - 客户端从自己信任的 CA 仓库中，拿 CA 证书里面的公钥去解密 HTTPS 网站的数字证书（证书是通过 CA 私钥加密的，所以要用公钥解密），如果能够成功，则说明 HTTPS 网站是可信的
    - 证书验证完毕之后，觉得这个 HTTPS 网站可信，于是客户端计算产生随机数字 Pre-master，用服务器返回的数字证书中的公钥加密该随机数字，再通过 Client Key Exchange 报文发送给服务器，服务器可以通过对应的私钥解密出 Pre-master。到目前为止，无论是客户端还是服务器，都有了三个随机数，分别是：自己的、对端的，以及刚生成的 Pre-Master 随机数。通过这三个随机数，可以在客户端和服务器生成相同的对称加密密钥
    - 有了对称加密密钥，客户端就可以通过 Change Cipher Spec 报文告知服务器以后都采用该密钥和协商的加密算法进行加密通信了
    - 客户端还会发送一个 Encrypted Handshake Message 报文，将已经商定好的参数，采用对称加密密钥进行加密，发送给服务器用于数据与握手验证
    - 服务器也可以发送 Change Cipher Spec 报文，告知客户端以后都采用协商的对称加密密钥和加密算法进行加密通信了，并且也发送 Encrypted Handshake Message 报文进行测试。当双方握手结束之后，就可以通过对称加密密钥进行加密传输了
    - 加密阶段：在第一个阶段握手完成后，客户端会发送 ClientKeyExchange 作为响应，响应中包含了一种称为 The premaster secret 的密钥字符串，这个字符串就是使用上面公开密钥证书进行加密的字符串。随后客户端会发送 ChangeCipherSpec，告诉服务端使用私钥解密这个 premaster secret 的字符串，然后客户端发送 Finished 告诉服务端自己发送完成了
    - Session key 其实就是用公钥证书加密的公钥
    - 实现了安全的非对称加密：然后，服务器再发送 ChangeCipherSpec 和 Finished 告诉客户端解密完成，至此实现了 RSA 的非对称加密
* 作用
    - 内容加密：建立一个信息安全通道，来保证数据传输的安全
        + HTTPS 采用共享密钥加密和公开密钥加密两者并用的混合加密机制
        + 公开密钥加密与共享密钥加密相比，其处理速度要慢。所以应充分利用两者各自的优势，将多种方法组合起来用于通信。在交换密钥环节使用公开密钥加密方式，之后的建立通信交换报文阶段则使用共享密钥加密方式。
    - 身份认证：确认网站的真实性
    - 数据完整性：防止内容被第三方冒充或者篡改
* 缺点
    - 当使用 SSL 时，处理速度会变慢
        + 通信慢：和使用 HTTP 相比，网络负载可能会变慢 2 到 100 倍
        + 大量消耗 CPU 及内存等资源，导致处理速度变慢
        + ssl握手需要的9个包
* HTTP vs HTTPS
    - HTTP 在地址栏上的协议是以 http:// 开头，而 HTTPS 在地址栏上的协议是以 https:// 开头
    - HTTP 是未经安全加密的协议，传输过程容易被攻击者监听、数据容易被窃取、发送方和接收方容易被伪造；而 HTTPS 是安全的协议，它通过 密钥交换算法 - 签名算法 - 对称加密算法 - 摘要算法 能够解决上面这些问题
* HTTPS在HTTP的基础上加入了SSL协议，SSL依靠证书来验证服务器的身份，并为浏览器和服务器之间的通信加密
    - 需要到CA申请证书
    - 具有安全性的ssl加密传输协议
    - 端口也不一样，前者是80，后者是443
    - http的连接很简单，是无状态的；HTTPS协议是由SSL+HTTP协议构建的可进行加密传输、身份认证的网络协议，比http协议安全。
* 流程
    - 购买证书，获取证书文件
        + 证书其实就是公钥，只是包含了很多信息，如证书的颁发机构，过期时间等等
        + 自己颁发的证书需要客户端验证通过，才可以继续访问
        + 使用受信任的公司申请的证书则不会弹出提示页面
        + [Let’s Encrypt](https://letsencrypt.org/)
    - 配置域名信息,放到cert目录
    - 客户端
        + 客户端的TLS来完成的，首先会验证公钥是否有效
        + 生成一个随机值，然后用证书对该随机值进行加密
        + 传送的是用证书加密后的随机值，目的就是让服务端得到这个随机值，以后客户端和服务端的通信就可以通过这个随机值来进行加密解密了
    - 服务端
        + 服务端用私钥解密后，得到了客户端传过来的随机值(私钥)，然后把内容通过该值进行对称加密
        + 对称加密就是，将信息和私钥通过某种算法混合在一起，这样除非知道私钥，不然无法获取内容
    - 解决方案
        + [certbot](https://certbot.eff.org/lets-encrypt/ubuntuxenial-nginx) <https://certbot.eff.org/>
        + [FiloSottile/mkcert](https://github.com/FiloSottile/mkcert):A simple zero-config tool to make locally trusted development certificates with any names you'd like.
        + [acmesh-official / acme.sh](https://github.com/acmesh-official/acme.sh):A pure Unix shell script implementing ACME client protocol https://acme.sh
* 验证域名的所有权
    - http方式是将随机生成的验证文件放入网站的根目录,由机构扫描验证
    - DNS方式则是将随机生成的验证码创建域名的TXT记录由机构扫描验证.验证通过即可颁发证书
        + 通过使用域名服务商提供的 API 密钥,让acme.sh自动创建域名验证记录以申请域名证书. acme.sh 支持全球各种域名服务商的 API
* 优化SSL/TLS
    - 会话缓存。使用ssl_session_cache指令开启缓存，缓存每次SSL/STL连接时用到的参数。
    - 会话票或ID。把特定SSL/TLS会话的信息保存为一个会话票或ID，以便连接重用，而不必重新握手。
    - OCSP封套。通过缓存SSL/TLS证书信息减少握手时间。

![HTTPS签名和验证](../static/https-ac.png "HTTPS签名和验证")
![HTTP vs HTTPS](../static/https.png "HTTP与HTTPS区别")

```
                              发起请求
                     --------------------------->　　server
                              下发证书
                      <---------------------------   server
                      证书数字签名(用证书机构公钥加密)
                     --------------------------->　　证书机构
                          证书数字签名验证通过
client(内置证书机构证书) <---------------------------   证书机构
                      公钥加密随机密码串(未来的共享秘钥)
                     --------------------------->　　server私钥解密(非对称加密)
                        SSL协议结束　HTTP协议开始
                      <---------------------------   server(对称加密)
                            共享秘钥加密 HTTP
                     --------------------------->　　server(对称加密)

adduser letsencrypt
usermod -aG sudo letsencrypt
sudo add-apt-repository ppa:certbot/certbot
sudo apt-get update
sudo apt-get install python-certbot-apache
sudo certbot --apache -d packagist.domain.com


curl https://get.acme.sh | sh
alias acme.sh=~/.acme.sh/acme.sh

# 生成证书
acme.sh --issue -d mydomain.com -d www.mydomain.com --webroot /home/wwwroot/mydomain.com/
acme.sh --issue -d mydomain.com --apache|nginx

acme.sh --issue -d thinkphp.com -w /home/henry/Workspace/thinkphp/public
acme.sh --issue --debug -d thinkphp.com -d henry.thinkphp.com -w /home/henry/Workspace/thinkphp/public

## copy/安装 证书
acme.sh --installcert -d <domain>.com \
--key-file /etc/nginx/ssl/<domain>.key \
--fullchain-file /etc/nginx/ssl/fullchain.cer \
--reloadcmd "service nginx force-reload"

acme.sh --upgrade --auto-upgrade

sudo yum install certbot python2-certbot-nginx
sudo certbot --nginx
sudo certbot certonly --nginx
echo "0 0,12 * * * root python -c 'import random; import time; time.sleep(random.random() * 3600)' && certbot renew -q" | sudo tee -a /etc/crontab > /dev/null
```

## 认证

* 基本认证:返回 401 Unauthorized 响应,会在请求头中设置 Authorization 字段，字段值是认证方式和认证凭证：｀Authorization: Basic eWFvamluYnVAMTYzLmNvbTp0ZXN0MTIzNDU2`
    - 凭证信息是用户名和密码通过冒号拼接起来，然后通过 Base64 进行编码，可以通过 Base64 解码即可还原，所以基本等同于明文传输
* 摘要（Digest）认证
* SSL 客户端认证：借助 HTTPS 的客户端证书完成认证的方式，就像 HTTPS 的服务端证书可以确保服务器的合法性一样，HTTPS 的客户端证书可以确保登录设备是经过认证的合法设备
    - 需要先将客户端证书颁发给客户端，且客户端必须安装此证书才能进行认证，客户端认证虽然安全，但操作更加繁琐，一般用于对安全性要求比较高的系统认证
* 表单认证：客户端通过表单向服务器上的 Web 应用程序发送登录凭证（Credential），服务端按登录凭证的验证结果对用户进行认证

## 存储

* cookie:浏览器实现的一种数据存储功能
    - 向服务端发送请求时，服务端会发送一个认证信息，服务器第一次接收到请求时，开辟了一块 Session 空间（创建了Session对象），同时生成一个 sessionId ，并通过响应头的 Set-Cookie：JSESSIONID=XXXXXXX 命令，向客户端发送要求设置 Cookie 的响应；客户端收到响应后，在本机客户端设置了一个 JSESSIONID=XXXXXXX 的 Cookie 信息，该 Cookie 的过期时间为浏览器会话结束
    - 客户端每次向同一个网站发送请求时，请求头都会带上该 Cookie信息（包含 sessionId ）， 然后，服务器通过读取请求头中的 Cookie 信息，获取名称为 JSESSIONID 的值，得到此次请求的 sessionId
    - 存在客户端上的，所以浏览器加入了一些限制确保cookie不会被恶意使用，同时不会占据太多磁盘空间，所以每个域的cookie数量是有限的
    - 服务端Set-Cookie字段中新增httpOnly属性，当服务端在返回的Cookie信息中含有httpOnly字段时，开发者是不能通过JavaScript来操纵该条Cookie字符串的。这样做的好处主要在于面对XSS（Cross-site scripting）攻击时，黑客无法拿到设置httpOnly字段的Cookie信息
    - 场景
        + 身份识别
        + 广告追踪
* Session:由于HTTP协议是无状态的协议，所以服务端需要记录用户的状态时，就需要用某种机制来识具体的用户
    - Session是保存在服务端的，有一个唯一标识 会话标识(session id)
    - 在服务端保存Session的方法很多，内存、数据库、文件都有
    - 内存的开销 对服务器说是一个巨大的开销，严重的限制了服务器扩展能力
        + 做了负载均衡，那么下一个操作请求到了另一台服务器的时候session会丢失
            * 让某个用户的请求一直粘连在机器
            * session 的复制
        + 把session id 集中存储到一个地方 Memcache,增加了单点失败的可能性
    - 用户离开网站后session会被销毁
    - 典型的场景
        + 购物车，当你点击下单按钮时，由于HTTP协议无状态，所以并不知道是哪个用户操作的，标识这并且跟踪用户，这样才知道购物车里面有几本书
        + 用户验证
        + 免信息登陆：信息可以写到Cookie里面，访问网站的时候，网站页面的脚本可以读取这个信息，就自动帮你把用户名给填了，能够方便一下用户
* 服务端如何识别客户,需要cookie维护
    - 每次HTTP请求的时候，客户端都会发送相应的Cookie信息到服务端 Set-Cookie:PHPSESSIONID=xxxxxxx
    - 实际上大多数的应用都是用 Cookie 来实现Session跟踪的，第一次创建Session的时候，服务端会在HTTP协议中告诉客户端，需要在 Cookie 里面记录一个Session ID，以后每次请求把这个会话ID发送到服务器
    - 服务器识别PHPSESSIONID这个cookie，然后去session目录查找对应session文件，
    - 找到这个session文件后，检查是否过期，如果没有过期，去读取Session文件中的配置；如果已经过期，清空其中的配置
* token
    - 流程
        + 用户通过用户名和密码发送请求。
        + 程序验证。
        + 程序返回一个签名的token 给客户端。用HMAC-SHA256 算法，加上一个密钥， 对数据做一个签名， 把这个签名和数据一起作为token ， 由于密钥别人不知道， 就无法伪造token了。
        + 客户端储存token,并且每次用于每次发送请求。
        + 服务端验证token并返回数据。token 不保存， 当用户把这个token 给发过来的时候，再用同样的HMAC-SHA256 算法和同样的密钥，对数据再计算一次签名， 和token 中的签名做个比较
        + token是有时效的，一段时间之后用户需要重新验证
    - 特点
        + 无状态、可扩展：tokens自己保存住了用户的验证信息
        + 支持移动设备
        + 跨程序调用
        + 安全：不再是发送cookie能够防止CSRF(跨站请求伪造)
* 禁用了 Cookie
    - 理论上只要在返回的页面里里能带上一个标识会话的令牌，在浏览器下一次提交的时候，能带上这个令牌，会话就可以被保持
    - 如果一个Cookie都没接收到，基本上可以预判客户端禁用了Cookie，那将session_id附带在每个网址后面(包括POST)，比如：`http://www.xx.com/index.php?session_id=xxxxx`
    - 在每个页面的开头使用`session_id($_GET['session_id'])`，来强制指定当前session_id：
* 安全
    - PHPSESSIONID设置为httponly并加密，这样，前端JS就无法读取和修改这些敏感信息，降低了被盗用的风险
* JWT:保存在客户端的信息，它广泛的应用于单点登录的情况
    - JWT 的 Cookie 信息存储在客户端，而不是服务端内存中。也就是说，JWT 直接本地进行验证就可以，验证完毕后，这个 Token 就会在 Session 中随请求一起发送到服务器，通过这种方式，可以节省服务器资源，并且 token 可以进行多次验证。
    - JWT 支持跨域认证，Cookies 只能用在单个节点的域或者它的子域中有效。如果它们尝试通过第三个节点访问，就会被禁止。使用 JWT 可以解决这个问题，使用 JWT 能够通过多个节点进行用户认证，也就是我们常说的跨域认证

```
# 存储方式 N 表示多级目录，值为数字。 MODE 表示创建的 Session 文件权限。使用了 N 参数并且大于 0，那么将不会执行自动垃圾回收。双引号 "quotes" 括起来
session.save_handler = files
session.save_path = "N;MODE;/tmp"

# 生命周期：关闭后会直接清除所有session，或者程序实现
session_destory()方法清除所有session
unset(session['x'])来清除指定的session['x']

# 垃圾回收机制：session.gc_divisor 与 session.gc_probability 合起来定义了在每个会话初始化时启动 GC 进程的概率 gc_probability/gc_divisor
# 扫描所有的session信息， 用当前时间减去session的最后修改时间（modified date），同session.gc_maxlifetime参数进行比较，
session.gc_maxlifetime
session.gc_probability
session.gc_divisor

## 共享
//memcache Ip（127.0.0.1） Port（11211）
session.save_handler = memcache
session.save_path = "tcp://127.0.0.1:11211"
# 数据解析
function unserialize_php($session_data)
{
    $return_data = array();
    $offset = 0;

    while ($offset < strlen($session_data)) {
        if (!strstr(substr($session_data, $offset), "|")) {
            throw new Exception("invalid data, remaining: " .substr($session_data, $offset));
        }
        $pos = strpos($session_data, "|", $offset);
        $num = $pos - $offset;
        $varname = substr($session_data, $offset, $num);
        $offset += $num + 1;
        $data = unserialize(substr($session_data, $offset));
        $return_data[$varname] = $data;
        $offset += strlen(serialize($data));
    }
    return $return_data;
}
$un_data = unserialize_php($data);
```

## HTTP 1.0

* 1996 年引入
    - 仅仅提供了最基本的认证，用户名和密码还未经加密，因此很容易收到窥探
    - 被设计用来使用短连接，即每次发送数据都会经过 TCP 的三次握手和四次挥手，效率比较低
    - 只使用 header 中的 If-Modified-Since 和 Expires 作为缓存失效的标准
    - 不支持断点续传，也就是说，每次都会传送全部的页面和数据
    - 认为每台计算机只能绑定一个 IP，所以请求消息中的 URL 并没有传递主机名（hostname）

* 可以借助cookie/session机制来做身份认证和状态记录
    - 无连接的特性导致最大的性能缺陷就是无法复用连接。每次发送请求的时候，都需要进行一次TCP的连接，而TCP的连接释放过程又是比较费事的。这种无连接的特性会使得网络的利用率非常低
    - 队头阻塞（headoflineblocking）。由于HTTP1.0规定下一个请求必须在前一个请求响应到达之前才能发送。假设前一个请求响应一直不到达，那么下一个请求就不发送，同样的后面的请求也给阻塞了
* 无法复用TCP连接和并行发送请求
* TCP传输的单位是packet，HTTP则采用request-response的模型
* Chrome 最多允许对同一个 Host 建立六个 TCP 连接。不同的浏览器有一些区别

## HTTP 1.1

* 1999 年提出，做出以下变化
    - 使用了摘要算法来进行身份验证
    - 默认使用长连接
    - 中新增加了 E-tag，If-Unmodified-Since, If-Match, If-None-Match 等缓存控制标头来控制缓存失效
    - 支持断点续传，通过使用请求头中的 Range 来实现
    - 使用了虚拟网络，在一台物理服务器上可以存在多个虚拟主机（Multi-homed Web Servers），并且它们共享一个IP地址
* 把 Connection 头写进标准，并且默认开启持久连接,除非请求中写明 Connection: close，那么浏览器和服务器之间是会维持一段时间的 TCP 连接，不会一个请求结束就断掉
* 持久连接:`Connection: keep-alive` 头部字段 ，表示会在建立TCP连接后，完成首次的请求，并不会立刻断开TCP连接，而是保持这个连接状态进而可以复用
* 维持连接，SSL 的开销也可以避免
* 单个 TCP 连接在同一时刻只能处理一个请求
    - 任意两个 HTTP 请求从开始到结束的时间在同一个 TCP 连接里不能重叠
    - 支持请求管道化，“并行”发送请求，但是这个并行，也不是真正意义上的并行，而是可以把先进先出队列从客户端（请求队列）迁移到服务端（响应队列）,在浏览器中默认是关闭的
        + 一些代理服务器不能正确的处理 HTTP Pipelining
        + 正确的流水线实现是复杂的
        + Head-of-line Blocking 连接头阻塞：在建立起一个 TCP 连接之后，假设客户端在这个连接连续向服务器发送了几个请求，按照标准，服务器应该按照收到请求的顺序返回结果 假设服务器在处理首个请求时花费了大量时间，那么后面所有的请求都需要等着首个请求结束才能响应(堵塞)
* 浏览器客户端在同一时间，针对同一域名下的请求有一定数量限制。超过限制数目的请求会被阻塞 通常一次只能有 6 个连接。例如，如果其中一个请求由于服务器上的某些复杂逻辑而卡住，那么它们中的每一个都可以一次处理一个请求，整个连接就会冻结并等待响应。这个问题称为前端阻塞
    - 为何一些站点会有多个静态资源 CDN 域名的原因
* 缺点
    - 一条连接同时只能发送一个请求
    - 请求只能从客户端发起
    - 请求/响应首部未经压缩就直接发送，首部信息越多延迟越大

    - 明文传输
    - 没有解决无状态连接的
    - 当有多个请求同时被挂起的时候 就会拥塞请求通道，导致后面请求无法发送
    - 臃肿的消息首部:HTTP/1.1能压缩请求内容,但是消息首部不能压缩;在现今请求中,消息首部占请求绝大部分(甚至是全部)也较为常见,造成通信的浪费

## HTTP /2

* 2015 年开发出来的标准 基于Google的SPDY,从2012年诞生到2016停止维护
* 头部压缩（Header Compression）:由于 HTTP 1.1 经常会出现 User-Agent、Cookie、Accept、Server、Range 等字段可能会占用几百甚至几千字节，而 Body 却经常只有几十字节，所以导致头部偏重。HTTP 2.0 使用 HPACK 算法进行压缩
    - 头信息（键值对）在两端建立一个索引表，对相同的头只发送索引表中的索引
    - 在客户端和服务器端使用“首部表”来跟踪和存储之前发送的键-值对，对于相同的数据，不再通过每次请求和响应发送
    - 通信期间几乎不会改变的通用键-值对(用户代理、可接受的媒体类型,等等)只需发送一次
    - 如果请求中不包含首部(例如对同一资源的轮询请求),那么 首部开销就是零字节。此时所有首部都自动使用之前请求发送的首部。
    - 如果首部发生变化了，那么只需要发送变化了数据在Headers帧里面，新增或修改的首部帧会被追加到“首部表”。首部表在 HTTP 2.0 的连接存续期内始终存在,由客户端和服务器共同渐进地更新 。数据被称为帧（Frames）
    - 新的报头压缩算法,称之为 HPACK,不仅使整个过程更加安全，而且在某些情况下速度更快。gzip做header压缩有安全性隐患
        + HPACK粗略来说就是一张动态表（dynamic table），由request-response共同维护它，后续header中不会完整重复之前的条目，而是引用之前的条目，TCP的有序性保证了它一定是先修改再读取，也就是先编码再解码。
* 采用二进制帧（frame）封装，HTTP 2.0 使用了更加靠近 TCP/IP 的二进制格式，而抛弃了 ASCII 码，提升了解析效率
    - HTTP1.x的解析是基于文本的，基于文本协议的格式解析存在天然缺陷，文本的表现形式有多样性，要做到健壮性考虑的场景必然很多
    - HTTP1.x的头部信息会被封装到HEADER frame，而相应的RequestBody则封装到DATAframe里面
    - 在 应用层(HTTP/2)和传输层(TCP or UDP)之间增加一个二进制分帧层
        + 会将所有传输的信息分割为更小的消息和帧，然后采用二进制的格式进行编码
* 强化安全，由于安全已经成为重中之重，所以 HTTP2.0 一般都跑在 HTTPS 上
* 多路复用 (Multiplexing):即每一个请求都是是用作连接共享。一个请求对应一个id，这样一个连接上可以有多个请求
    - 同时通过单一的 HTTP/2 连接发起多重的请求-响应消息
    - HTTP/1.x 虽然通过 pipeline 也能并发请求，但是多个请求之间的响应会被阻塞的，所以 pipeline 至今也没有被普及应用，而 HTTP/2 做到了真正的并发请求
    - 把数据流分解为多个帧，多个数据流的帧混合之后以同一个TCP连接来发送
    - 流还支持优先级和流量控制。当流并发时，就会涉及到流的优先级和依赖。即：HTTP2.0对于同一域名下所有请求都是基于流的，不管对于同一域名访问多少文件，优先级高的流会被优先发送。图片请求的优先级要低于 CSS 和 SCRIPT，这个设计可以确保重要的东西可以被优先加载完
* 全双工通信
* 必须https：HTTP+ 加密 + 认证 + 完整性保护
* 将一个 TCP 连接切分成多个流，每个流都有自己的 ID，而且流可以是客户端发往服务端，也可以是服务端发往客户端，为了解决并发请求导致响应慢的问题，还可以为流设置优先级
* 将所有的传输信息分割为更小的消息和帧，并对它们采用二进制格式编码，常见的帧有 Header 帧，用于传输 HTTP 头信息，并且会开启一个新的流；再就是 Data 帧，用来传输 HTTP 报文实体，多个 Data 帧属于同一个流
* 通过这两种机制，HTTP/2.0 的客户端可以将多个请求分到不同的流中，以实现在一个 TCP 连接上处理所有请求，然后将请求内容拆分成帧，进行二进制传输，这些帧可以打散乱序发送，然后根据每个帧首部的流标识符重新组装，并且可以根据优先级，决定优先处理哪个流的数据。成功消除了 HTTP/1.1 的性能瓶颈和限制，减少了 TCP 连接数对服务器性能的影响，同时可以将页面的多个 css、js、 图片等资源通过一个数据链接进行传输，能够加快页面组件的传输速度
* 流量控制算法优化
    - TCP协议通过sliding window的算法来做流量控制。发送方有个sending window，接收方有receive window
    - http2.0的flow control是类似receive window的做法，数据的接收方通过告知对方自己的flow window大小表明自己还能接收多少数据。只有Data类型的frame才有flow control的功能
    - 对于flow control，如果接收方在flow window为零的情况下依然更多的frame，则会返回block类型的frame，这张场景一般表明http2.0的部署出了问题。
* 服务器端推送（Server Push）
    - 服务器可以对一个客户端请求发送多个响应。除了对最初请求的响应外，服务器还可以额外向客户端推送资源，而无需客户端明确地请求
* [HTTP2 vs HTTP1.1](https://http2.akamai.com/demo)
    - 性能优化的关键并不在于高带宽，而是低延迟.TCP 连接会随着时间进行自我「调谐」，起初会限制连接的最大速度，如果数据成功传输，会随着时间的推移提高传输的速度。这种调谐则被称为 TCP 慢启动
* 问题
    - TCP有一些问题，比如慢启动，如果拥塞窗口尺寸设置不合理，TCP的性能会急剧下降
    - 无法避免队头阻塞的情况出现
        + 因为TCP是需要保证有序的，假如单个TCP连接同时承载了四路逻辑连接，其中某个逻辑连接丢包了，则其它三路都会受影响，都必须从丢包的时刻开始重传，这无疑是极大的浪费
        + 测试表明，如果丢包率超过2%，那么HTTP/2甚至不如HTTP 1.1，因为HTTP 1.1中各连接物理隔离，不会互相影响。
* 参考
    - [静态资源递送优化：HTTP/2 和 Server Push](https://blog.skk.moe/post/http2-server-push/)

```sh
pear install HTTP2

openssl req -x509 -newkey rsa:4096 -keyout key.pem -out certificate.pem -days 365 -nodes
```

## QUIC

* 2018年11月，IETF正式宣布，HTTP-over-QUIC更名为HTTP/3，Google的QUIC有时候也写作gQUIC。Google已经宣布，会逐步把IETF的规范纳入自己的协议版本，实现相同的规范
* 基于UDP的HTTP：传统的HTTP/TCP/IP协议栈中的TCP换成UDP（当然需要加密），能通过加密的UDP传输HTTP/2的帧
* 优点
    - UDP建立连接的延迟会低很多，而且避免了队头阻塞
    - FEC（Forward Error Correction）。简单说 一旦有packet丢失，接收方可以根据之前和之后的packet推断出丢失packet的数据，这样就避免了重传。但是这样必然要求增加冗余载荷，或者说，这就是网络协议中的RAID 5。按照目前看到的资料，其冗余比例大概是10%，也就是说，每10个pakcet中的冗余信息，就可以重构一个packet
* 所有连接都是加密的，目前采用的是TLS 1.3。建立连接的握手过程当中就同时完成了加密握手。HTTP/3的握手很快，如果两台主机之间建立过连接，并且缓存了之前的secret，只要客户端验证之前缓存的server config就可以直接建立连接，相当于0-RTT，否则也只需要1-RTT就可以建立连接
* 容许在0-RTT的情况下从一开始就捎带数据，传统的“建立连接-加密握手-发送数据”如今可以三步并作一步
* 一个物理连接也可以承载多个逻辑连接（也就是数据流），逻辑连接是彼此独立的，所以避免了TCP上出现的“逻辑连接甲丢包导致逻辑连接乙、丙、丁都需要重传”的情况。
* 每个连接都有一组连接ID。连接各端可以设定自己的连接ID，同时认可对方的连接ID。连接ID的作用在于从逻辑上标识当前连接。所以，如果用户的IP发生变化而连接ID没有变化，因为packet包含了网络ID标识符，所以只需要继续发送数据包就可以重新建立连接
* QPACK：所有的header必须通过同一数据流来传输，而且必须严格有序。但是这样一来，从HTTP 1.1开始就困扰HTTP已久的队头阻塞又出现了
* [lucas-clemente/quic-go](https://github.com/lucas-clemente/quic-go):A QUIC implementation in pure go
* [cloudflare / quiche](https://github.com/cloudflare/quiche):pie Savoury implementation of the QUIC transport protocol and HTTP/3 https://docs.quic.tech/quiche/
* [HTTP/3：从 SPDY 到 QUIC](https://blog.skk.moe/post/http3-from-spdy-to-quic/)

## 长连接

* 应用在消息提醒、即时通讯、推送、直播弹幕、游戏、共享定位、股票行情等等场景
* 分开设计长连接会导致研发和维护成本陡增、浪费基础设施、增加客户端耗电、无法复用已有经验等等问题
* 共享长连接系统又需要协调好不同系统间的认证、鉴权、数据隔离、协议拓展、消息送达保证等等需求
* 系统主要由四个主要组件组成：
    - 接入层使用 OpenResty 实现
        + 负载均衡，保证各长连接 Broker 实例上连接数相对均衡
        + 会话保持，单个客户端每次连接到同一个 Broker，用来提供消息传输可靠性保证
    - 长连接 Broker，部署在容器中，负责协议解析、认证与鉴权、会话、发布订阅等逻辑
    - Redis 存储，持久化会话数据
    - Kafka 消息队列，分发消息给 Broker 或 业务方

## 短链

* 哈希
    -  Google 出品的 MurmurHash 算法:一种非加密型哈希函数，适用于一般的哈希检索操作。与其它流行的哈希函数相比，对于规律性较强的 key，MurmurHash 的随机分布特征表现更良好。非加密意味着着相比 MD5，SHA 这些函数它的性能肯定更高（实际上性能是 MD5 等加密算法的十倍以上）, 提供了两种长度的哈希值，32 bit，128 bit，为了让网址尽可通地短，选择 32 bit 的哈希值，32 bit 能表示的最大值近 43 亿，对于中小型公司的业务而言绰绰有余。对上文提到的极客长链做 MurmurHash 计算，得到的哈希值为 3002604296，于是现在得到的短链为 固定短链域名+哈希值 = http://gk.link/a/3002604296.3002604296 转为 62 进制可缩短它的长度
    - 哈希冲突
        + 将长链（lurl）经过 MurmurHash 后得到短链。
        + 再根据短链去 short_url_map 表中查找看是否存在相关记录，如果不存在，将长链与短链对应关系插入数据库中，存储。
        + 如果存在，说明已经有相关记录了，此时在长串上拼接一个自定义好的字段，比如「DUPLICATE」，然后再对接接的字段串「lurl + DUPLICATE」做第一步操作，如果最后还是重复呢，再拼一个字段串啊，只要到时根据短链取出长链的时候把这些自定义好的字符串移除即是原来的长链。
        + 需要给短链字段 surl 加上唯一索引
        + 当长链经过 MurmurHash 得到短链后，直接将长短链对应关系插入 db 中，如果 db 里不含有此短链的记录，则插入，如果包含了，说明违反了唯一性索引，此时只要给长链再加上上文说的自定义字段「DUPLICATE」,重新 hash 再插入即可，看起来在违反唯一性索引的情况下是多执行了步骤，但我们要知道 MurmurHash 发生冲突的概率是非常低的，基本上不太可能发生，所以这种方案是可以接受的。
* 自增序列算法
    - 类 uuid:用 UUID uuid = UUID.randomUUID(); 这种方式生成的 UUID(Universally Unique Identifier)全局唯一标识符,是指在一台机器上生成的数字，保证对在同一时空中的所有机器都是唯一的，但这种方式生成的 id 比较长，且无序，在插入 db 时可能会频繁导致页分裂，影响插入性能
    - Redis:布置 10 台机器，每台机器分别只生成尾号0，1，2，... 9 的 ID, 每次加 10 即可，只要设置一个 ID 生成器代理随机分配给发号器生成  ID 就行了。考虑持久化（短链 ID 总不能一样吧），灾备，成本有点高
    - Snowflake:不错的选择，不过 Snowflake 依赖于系统时钟的一致性。如果某台机器的系统时钟回拨，有可能造成 ID 冲突，或者 ID 乱序
    - Mysql 自增主键
        + 设计一个专门的发号表，每插入一条记录，为短链 id 预留（主键 id * 1000 - 999） 到  (主键 id  * 1000) 的号段
        + 当长链转短链的请求打到某台机器时，先看这台机器是否分配了短链号段，未分配就往发号表插入一条记录，则这台机器将为短链分配范围在 tmp_start_num 到 tmp_end_num 之间的 id。从 tmp_start_num 开始分配，一直分配到 tmp_end_num，如果发号 id 达到了 tmp_end_num，说明这个区间段的 id 已经分配完了，则再往发号表插入一条记录就又获取了一个发号 id 区间

## 端到端加密

## URL Schemes

## [Wireshark](https://www.wireshark.org)

* <https://github.com/dafang/notebook/issues/114>
* CTRL 按钮: 捕获多个网卡
* save 捕获数据

```sh
sudo apt install wireshark
# 是否允许非超级用户捕获数据包。选择“Yes”允许，选择“No”限制非超级用户捕获数据包
sudo dpkg-reconfigure wireshark-common
# 允许非超级用户捕获数据包，因此你必须将该用户添加到 wireshark 组
sudo usermod -aG wireshark $(whoami)
sudo wireshark
```

## 图书

* 《HTTP 权威指南》

## 实例

* [kjj6198/cors_example](https://github.com/kjj6198/cors_example)

## [jakubroztocil/httpie](https://github.com/jakubroztocil/httpie)

As easy as httpie /aitch-tee-tee-pie/ 🥧 Modern command line HTTP client – user-friendly curl alternative with intuitive UI, JSON support, syntax highlighting, wget-like downloads, extensions, https://httpie.org

* [eliangcs /http-prompt ](https://github.com/eliangcs/http-prompt):HTTPie + prompt_toolkit = an interactive command-line HTTP client featuring autocomplete and syntax highlighting http://http-prompt.com

```sh
# installed on any operating system.
<tool> install httpie

http PUT httpbin.org/put X-API-Token:123 name=John
http -f POST httpbin.org/post hello=World
http -v httpbin.org/get
http -a USERNAME POST https://api.github.com/repos/jakubroztocil/httpie/issues/83/comments body='HTTPie is awesome! :heart:'
http httpbin.org/post < files/data.json
http httpbin.org/image/png > image.png
http --download httpbin.org/image/png
http --session=logged-in -a username:password httpbin.org/get API-Key:123

http --session=logged-in httpbin.org/headers
http localhost:8000 Host:example.com
```

## 工具

* [snail007/goproxy](https://github.com/snail007/goproxy):Proxy is a high performance HTTP(S), websocket, TCP, UDP,Secure DNS, Socks5 proxy server implemented by golang. Now, it supports chain-style proxies,nat forwarding in different lan,TCP/UDP port forwarding, SSH forwarding.Proxy是golang实现的高性能http,https,websocket,tcp,防污染DNS,socks5代理服务器,支持内网穿透,链式代理,通讯加密,智能HTTP,SOCKS5代理,域名黑白名单,跨平台,KCP协议支持,集成外部API。
* [ProxymanApp / Proxyman](https://github.com/ProxymanApp/Proxyman):Modern and Delightful HTTP Debugging Proxy for macOS, iOS and Android ⚡️ https://proxyman.io
* [Netflix/pollyjs](https://github.com/Netflix/pollyjs):Record, Replay, and Stub HTTP Interactions. https://netflix.github.io/pollyjs
* [hazbo/httpu](https://github.com/hazbo/httpu):The terminal-first http client
* [fukamachi/woo](https://github.com/fukamachi/woo):A fast non-blocking HTTP server on top of libev http://ultra.wikia.com/wiki/Woo_(kaiju)
* [mitmproxy/mitmproxy](https://github.com/mitmproxy/mitmproxy):An interactive TLS-capable intercepting HTTP proxy for penetration testers and software developers. https://mitmproxy.org/
* [mholt/caddy](hhttps://github.com/caddyserver/caddy):Fast, cross-platform HTTP/2 web server with automatic HTTPS https://caddyserver.com
    - [phpple/caddy-cn-doc](https://github.com/phpple/caddy-cn-doc):Caddy中文文档 https://dengxiaolong.com/caddy/zh/
* [asciimoo/wuzz](https://github.com/asciimoo/wuzz):Interactive cli tool for HTTP inspection
* [square/okhttp](https://github.com/squpare/okhttp):An HTTP+HTTP/2 client for Android and Java applications. http://square.github.io/okhttp/
* [sindresorhus/ky](https://github.com/sindresorhus/ky):Tiny and elegant HTTP client based on the browser Fetch API
* [oldj/SwitchHosts](https://github.com/oldj/SwitchHosts):Switch hosts quickly! https://oldj.github.io/SwitchHosts/
* [coyove/goflyway](https://github.com/coyove/goflyway):An encrypted HTTP server
* [julienschmidt/httprouter](https://github.com/julienschmidt/httprouter):A high performance HTTP request router that scales well
* [buger/goreplay](https://github.com/buger/goreplay):GoReplay is an open-source tool for capturing and replaying live HTTP traffic into a test environment in order to continuously test your system with real data. It can be used to increase confidence in code deployments, configuration changes and infrastructure changes. https://goreplay.org
* [dannagle/PacketSender](https://github.com/dannagle/PacketSender):Network utility for sending / receiving TCP, UDP, SSL https://packetsender.com/
* flow-control
    - [alibaba/Sentinel](https://github.com/alibaba/Sentinel):A lightweight flow-control library providing high-available protection and monitoring (高可用防护的流量管理框架)
* Performance Measurement
    * [Microsoft/Ethr](https://github.com/Microsoft/Ethr):Ethr is a Network Performance Measurement Tool for TCP, UDP & HTTP.
* proxy
    - [avwo/whistle](https://github.com/avwo/whistle):HTTP, HTTPS, WebSocket debugging proxy https://wproxy.org/
* certificates
    - [FiloSottile/mkcert](https://github.com/FiloSottile/mkcert):A simple zero-config tool to make locally trusted development certificates with any names you'd like.
    - [Neilpang/acme.sh](https://github.com/Neilpang/acme.sh):A pure Unix shell script implementing ACME client protocol https://acme.sh
* 抓包
    - [httpwatch](https://www.httpwatch.com/)

## 参考

* [bolasblack/http-api-guide](https://github.com/bolasblack/http-api-guide)
* [HTTPS explained with carrier pigeons](https://medium.freecodecamp.org/https-explained-with-carrier-pigeons-7029d2193351)
* [HTTP API 认证授权术](https://coolshell.cn/articles/19395.html)
* [面试 HTTP](https://mp.weixin.qq.com/s/OE7wz7k9YEIF_Ivtt5Cu8A)
