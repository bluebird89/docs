# HTTP

HTTP协议（HyperText Transfer Protocol，超文本传输协议）是因特网上应用最为广泛的一种基于 TCP/IP 通信协议来传递数据的网络传输应用层协议。以 ASCII 码传输，建立在 TCP/IP 协议之上的应用层规范

* TCP/IP协议是传输层协议，主要解决数据如何在网络中传输
* HTTP是应用层协议，主要解决如何包装数据。HTTP协议详细规定了浏览器与服务器之间相互通信的规则，是万维网交换信息的基础。
* 无状态的协议。针对其无状态特性，在实际应用中又需要有状态的形式，因此一般会通过session/cookie技术来解决此问题。无状态是指协议对于事务处理没有记忆能力。缺少状态意味着如果后续处理需要前面的信息，则它必须重传，这样可能导致每次连接传送的数据量增大。另一方面，在服务器不需要先前信息时它的应答就较快。
* HTTP 是媒体独立的：只要客户端和服务器知道如何处理的数据内容，任何类型的数据都可以通过 HTTP 发送。客户端以及服务器指定使用适合的 MIME-type 内容类型。
* HTTP是基于请求-响应形式并且是短连接，客户端发送的每次请求都需要服务器回送响应，在请求结束后，会主动释放连接（无连接）
    * 从建立连接到关闭连接的过程称为"一次连接"。在HTTP 1.1中则可以在一次连接中处理多个请求，并且多个请求可以重叠进行，不需要等待一个请求结束后再发送下一个请求。
    * 由于HTTP在每次请求结束后都会主动释放连接，因此HTTP连接是一种"短连接"，要保持客户端程序的在线状态，需要不断地向服务器发起连接请求。
    * 通常的做法是即时不需要获得任何数据，客户端也保持每隔一段固定的时间向服务器发送一次"保持连接"的请求，服务器在收到该请求后对客户端进行回复，表明知道客户端"在线"。
    * 若服务器长时间无法收到客户端的请求，则认为客户端"下线"，若客户端长时间无法收到服务器的回复，则认为网络已经断开。

## URI

URL（Uniform Resource Locator，统一资源定位符）也就是俗称的网址，它表示某一网络资源存在于所在计算机网络上的位置，同时也是用于检索该资源的机制。

## 说明

服务端通常是根据请求头（headers）中的 Content-Type 字段来获知请求中的消息主体是用何种方式编码，再对主体进行解析。

* 请求
    - 状态行
    - 请求头
    - 消息主体（entity-body）

### 请求方式 POST

* application/x-www-form-urlencoded：原生 form 表单，如果不设置 enctype 属性
* multipart/form-data：用表单上传文件
    - 生成了一个 boundary 用于分割不同的字段，为了避免与正文内容重复，boundary 很长很复杂
* application/json:支持比键值对复杂得多的结构化数据:php 就无法通过 $_POST 对象从上面的请求中获得内容,从 php://input 里获得原始输入流，再 json_decode 成对象
* text/xml:XML 作为编码方式的远程调用规范。

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
```

#### GET与POST的区别

* GET请求会被浏览器主动cache，而POST不会，除非手动设置。
* GET请求只能进行url编码，而POST支持多种编码方式。
* GET请求参数会被完整保留在浏览器历史记录里，而POST中的参数不会被保留。
* GET请求在URL中传送的参数是有长度限制的，而POST么有。
* 对参数的数据类型，GET只接受ASCII字符，而POST没有限制。
* GET比POST更不安全，因为参数直接暴露在URL上，所以不能用来传递敏感信息。
* GET参数通过URL传递，POST放在Request body中。
* HTTP是基于TCP/IP的关于数据如何在万维网中如何通信的协议。HTTP的底层是TCP/IP。所以GET和POST的底层也是TCP/IP，也就是说，GET/POST都是TCP链接。GET和POST能做的事情是一样一样的。你要给GET加上request body，给POST带上url参数
* HTTP只是个行为准则(GET, POST, PUT, DELETE)，而TCP才是GET和POST怎么实现的基本。
* 浏览器限制单次运输量来控制风险，数据量太大对浏览器和服务器都是很大负担。GET和POST本质上就是TCP链接，并无差别。但是由于HTTP的规定和浏览器/服务器的限制，导致他们在应用过程中体现出一些不同。
* GET产生一个TCP数据包；POST产生两个TCP数据包。
    - 对于GET方式的请求，浏览器会把http header和data一并发送出去，服务器响应200（返回数据）；
    - 对于POST，浏览器先发送header，服务器响应100 continue，浏览器再发送data，服务器响应200 ok

## TCP/IP传输控制协议/网际协议 (Transmission Control Protocol / Internet Protocol)一个实现的应用模型

TCP/IP 是供已连接因特网的计算机进行通信的通信协议,定义了电子设备（比如计算机）如何连入因特网，以及数据如何在它们之间传输的标准。包含了一系列构成互联网基础的网络协议，是Internet的核心协议。TCP 负责将数据分割并装入 IP 包，然后在它们到达的时候重新组合它们。IP 负责将包发送至接受者。

```
HTTP/1.1 200 OK
    Content-Type: application/json;charset=UTF-8
    Cache-Control: no-store
    Pragma: no-cache
```

- 实现跨域
- 线程与进程区别
- session共享
- 403、304含义
- 不缓存cache-control设置

* TCP (传输控制协议):应用程序之间通信,当应用程序希望通过 TCP 与另一个应用程序通信时，它会发送一个通信请求。这个请求必须被送到一个确切的地址。在双方“握手”之后，TCP 将在两个应用程序之间建立一个全双工 (full-duplex) 的通信。在数据传送之前将它们分割为 IP 包，然后在它们到达的时候将它们重组。
* UDP (用户数据包协议) - 应用程序之间的简单通信
* IP (网际协议) - 计算机之间的通信,无连接的通信协议。它不会占用两个正在通信的计算机之间的通信线路。这样，IP 就降低了对网络线路的需求。每条线可以同时满足许多不同的计算机之间的通信需要。通过 IP，消息（或者其他数据）被分割为小的独立的包，并通过因特网在计算机之间传送。IP 负责将每个包路由至它的目的地.责在因特网上发送和接收数据包。
* ICMP (因特网消息控制协议) - 针对错误和状态
* DHCP (动态主机配置协议) - 针对动态寻址

TCP/IP协议通信的过程其实就对应着数据入栈与出栈的过程。入栈的过程，数据发送方每层不断地封装首部与尾部，添加一些传输的信息，确保能传输到目的地。出栈的过程，数据接收方每层不断地拆除首部与尾部，得到最终传输的数据。

* 应用层：应用层 表示层 会话层
* 传输层
* 互联网层：网络层
* 网络访问层：数据链路层 物理层

握手过程中传送的包里不包含数据，三次握手完毕后，客户端与服务器才正式开始传送数据。理想状态下，TCP连接一旦建立，在通信双方中的任何一方主动关闭连接之前，TCP 连接都将被一直保持下去。断开连接时服务器和客户端均可以主动发起断开TCP连接的请求，断开过程需要经过"四次握手"

### 建立连接

* 第一次握手：客户端发送syn包(syn=j)到服务器，并进入SYN_SEND状态，等待服务器确认；
* 第二次握手：服务器收到syn包，必须确认客户的SYN（ack=j+1），同时自己也发送一个SYN包（syn=k），即SYN+ACK包，此时服务器进入SYN_RECV状态；
* 第三次握手：客户端收到服务器的SYN＋ACK包，向服务器发送确认包ACK(ack=k+1)，此包发送完毕，客户端和服务器进入ESTABLISHED状态，完成三次握手。

在传输数据时，可以只使用（传输层）TCP/IP协议，但是那样的话，如果没有应用层，便无法识别数据内容，如果想要使传输的数据有意义，则必须使用到应用层协议，应用层协议有很多，比如HTTP、FTP、TELNET等，也可以自己定义应用层协议。WEB使用HTTP协议作应用层协议，以封装HTTP文本信息，然后使用TCP/IP做传输层协议将它发到网络上。

### 网络层

#### IP协议

IP协议是TCP/IP协议的核心，所有的TCP，UDP，IMCP，IGMP的数据都以IP数据格式传输。要注意的是，IP不是可靠的协议，这是说，IP协议没有提供一种数据未传达以后的处理机制，这被认为是上层协议：TCP或UDP要做的事情。

数据链路层中我们一般通过MAC地址来识别不同的节点，而在IP层我们也要有一个类似的地址标识，这就是IP地址。32位IP地址分为网络位和地址位，这样做可以减少路由器中路由表记录的数目，有了网络地址，就可以限定拥有相同网络地址的终端都在同一个范围内，那么路由表只需要维护一条这个网络地址的方向，就可以找到相应的这些终端了。

* A类IP地址: 0.0.0.0~127.0.0.0
* B类IP地址:128.0.0.1~191.255.0.0
* C类IP地址:192.168.0.0~239.255.255.0

IP协议头：八位的TTL字段。这个字段规定该数据包在穿过多少个路由之后才会被抛弃。某个IP数据包每穿过一个路由器，该数据包的TTL数值就会减少1，当该数据包的TTL成为零，它就会被自动抛弃。这个字段的最大值也就是255，也就是说一个协议包也就在路由器里面穿行255次就会被抛弃了，根据系统的不同，这个数字也不一样，一般是32或者是64。

#### ARP及RARP协议

ARP：是根据IP地址获取MAC地址的一种协议。ARP（地址解析）协议是一种解析协议，本来主机是完全不知道这个IP对应的是哪个主机的哪个接口，当主机要发送一个IP包的时候，会首先查一下自己的ARP高速缓存（就是一个IP-MAC地址对应表缓存）。如果查询的IP－MAC值对不存在，那么主机就向网络发送一个ARP协议广播包，这个广播包里面就有待查询的IP地址，而直接收到这份广播的包的所有主机都会查询自己的IP地址，如果收到广播包的某一个主机发现自己符合条件，那么就准备好一个包含自己的MAC地址的ARP包传送给发送ARP广播的主机。而广播主机拿到ARP包后会更新自己的ARP缓存（就是存放IP-MAC对应表的地方）。发送广播的主机就会用新的ARP缓存数据准备好数据链路层的的数据包发送工作。RARP协议的工作与此相反，不做赘述。

### TCP与UDP区别

TCP/UDP都是是传输层协议，但是两者具有不同的特性，同时也具有不同的应用场景， ![TCP与UDP对比](../_static/TCPvsUDP.png)

- 面向报文：面向报文的传输方式是应用层交给UDP多长的报文，UDP就照样发送，即一次发送一个报文。因此，应用程序必须选择合适大小的报文。若报文太长，则IP层需要分片，降低效率。若太短，会是IP太小。
- 面向字节流的话，虽然应用程序和TCP的交互是一次一个数据块（大小不等），但TCP把应用程序看成是一连串的无结构的字节流。TCP有一个缓冲，当应用程序传送的数据块太长，TCP就可以把它划分短一些再传送。
- TCP：当对网络通讯质量有要求的时候，传输过程中都有一个ack，接收方通过ack告诉发送方收到那些包了。这样发送方能知道有没有丢包，进而确定重传.比如：整个数据要准确无误的传递给对方，这往往用于一些要求可靠的应用，比如HTTP、HTTPS、FTP等传输文件的协议，POP、SMTP等邮件传输的协议。 TELENT：远程终端接入
- UDP：当对网络通讯质量要求不高的时候，要求网络通讯速度能尽量的快，这时就可以使用UDP。DNS（域名转换）TFTP SNMP NFS（远程文件服务器）

## OSI（Open Systems Interconnection Model）TCP/IP ，从上往下的，越底层越接近硬件，越往上越接近软件，是一个标准

* 应用层：HTTP,解决如何包装数据。各种应用软件，包括 Web 应用。
* 表示层：数据格式标识，基本压缩加密功能。
* 会话层：控制应用程序之间会话能力；如不同软件数据分发给不同软件。_软件_
* 传输层：端到端传输数据的基本功能；如 TCP、UDP。 数据被称作段（Segments）
* 网络层：定义IP编址，定义路由功能；如不同设备的数据转发。 数据被称做包（Packages）
* 数据链路层：定义数据的基本格式，如何传输，如何标识；如网卡MAC地址。责将0、1序列划分为数据帧从一个节点传输到临近的另一个节点,这些节点是通过MAC来唯一标识的(MAC,物理地址，一个主机会有一个MAC地址)。数据被称为帧（Frames） _操作系统_
  - 封装成帧: 把网络层数据报加头和尾，封装成帧,帧头中包括源MAC地址和目的MAC地址。
  - 透明传输:零比特填充、转义字符。
  - 可靠传输: 在出错率很低的链路上很少用，但是无线链路WLAN会保证可靠传输。
  - 差错检测(CRC):接收者检测错误,如果发现差错，丢弃该帧。
* 物理层：数据被称为比特流（Bits）负责0、1比特流与物理设备电压高低、光的闪灭之间的互换。 _物理设备_

计算机与网络传输：每层进行层层解包和附加自己所要传递的信息，术语叫做报头。

### DNS（Domain Name System，域名系统）

因特网上作为域名和IP地址相互映射的一个分布式数据库，能够使用户更方便的访问互联网，而不用去记住能够被机器直接读取的IP数串。通过主机名，最终得到该主机名对应的IP地址的过程叫做域名解析（或主机名解析）。DNS协议运行在UDP协议之上，使用端口号53。

* 本机一定要知道DNS服务器的IP地址，否则上不了网。通过DNS服务器，才能知道某个域名的IP地址到底是什么。
    - DNS服务器的IP地址，有可能是动态的，每次上网时由网关分配，这叫做DHCP机制；也有可能是事先指定的固定地址。Linux系统里面，DNS服务器的IP地址保存在/etc/resolv.conf文件。
* 分级查询：每个域名的IP地址：math.stackexchange.com.。这不是疏忽，而是所有域名的尾部，实际上都有一个根域名。DNS服务器根据域名的层级，进行分级查询。
    - 根域名.root。从"根域名服务器"查到"顶级域名服务器"的NS记录和A记录（IP地址）。根域名服务器"的NS记录和IP地址一般是不会变化的，所以内置在DNS服务器里面。
    - 顶级域名"（top-level domain，缩写为TLD），比如.com、.net。从"根域名服务器"查到"顶级域名服务器"的NS记录和A记录（IP地址）
    - 次级域名"（second-level domain，缩写为SLD），比如www.example.com里面的.example，这一级域名是用户可以注册的。从"次级域名服务器"查出"主机名"的IP地址
    - 再下一级是主机名（host），比如www.example.com里面的www。用户在自己的域里面为服务器分配的名称，是用户可以任意分配的

域名与IP之间的对应关系，称为"记录"（record）。根据使用场景，"记录"可以分成不同的类型（type）

* A：地址记录（Address），返回域名指向的IP地址。
* NS：域名服务器记录（Name Server），返回保存下一级域名信息的服务器地址。该记录只能设置为域名，不能设置为IP地址。为了服务的安全可靠，至少应该有两条NS记录
* MX：邮件记录（Mail eXchange），返回接收电子邮件的服务器地址。
* CNAME：规范名称记录（Canonical Name），返回另一个域名，即当前查询的域名是另一个域名的跳转。用于域名的内部跳转，为服务器配置提供灵活性，用户感知不到。一旦设置CNAME记录以后，就不能再设置其他记录了（比如A记录和MX记录），这是为了防止产生冲突
* PTR：逆向查询记录（Pointer Record），只用于从IP地址查询域名

### 状态码 Status Code

HTTP 状态码包含三个十进制数字，第一个数字是类别，后俩是编号

* 1XX 信息：服务器收到请求，需要请求者继续执行操作
    - 100 Continue：继续。客户端应继续其请求
    - 101 Switching Protocols：切换协议。服务器根据客户端的请求切换协议。只能切换到更高级的协议，例如，切换到 HTTP 的新版本协议
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
    - 302 Found：临时移动。与 301 类似。但资源只是临时被移动。客户端应继续使用原有 URI
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

### HTTP Request Header

* Allow：服务器支持哪些请求方法（如GET、POST等）。
* Content-Encoding：
    - 文档的编码(Encode)方法。只有在解码之后才可以得到 Content-Type 头指定的内容类型
    - 利用gzip压缩文档能够显著地减少HTML文档的下载时间
* Content-Length：表示内容长度。只有当浏览器使用持久 HTTP 连接时才需要这个数据
* Content-Type：表示后面的文档属于什么 MIME 类型
* Date：当前的 GMT 时间
* Expires：应该在什么时候认为文档已经过期，从而不再缓存它.
* Last-Modified：文档的最后改动时间。客户可以通过 If-Modified-Since 请求头提供一个日期，该请求将被视为一个条件 GET，服务器端的资源没有变化,只有改动时间迟于指定时间的文档才会返回，否则返回一个 304(Not Modified) 状态
* Location：表示客户应当到哪里去提取文档
* Refresh：表示浏览器应该在多少时间之后刷新文档，以秒计
    - 注意：这种功能通常是通过设置 HTML 页面 HEAD 区的 ＜META HTTP-EQUIV=”Refresh” CONTENT=”5;URL=http://host/path"＞实现
    - 注意：Refresh 的意义是”N秒之后刷新本页面或访问指定页面”，而不是”每隔N秒刷新本页面或访问指定页面”。因此，连续刷新要求每次都发送一个Refresh头，而发送204状态代码则可以阻止浏览器继续刷新，不管是使用Refresh头还是＜META HTTP-EQUIV=”Refresh” …＞。
    - 注意 Refresh 头不属于 HTTP 1.1 正式规范的一部分，而是一个扩展
* Server：服务器名字
* Set-Cookie：设置和页面关联的 Cookie
* WWW-Authenticate：客户应该在 Authorization 头中提供什么类型的授权信息？在包含401(Unauthorized) 状态行的应答中这个头是必需的

### 预检请求（preflight request）

CROS,全称是跨域资源共享 (Cross-origin resource sharing)，它的提出就是为了解决跨域请求的。

跨域资源共享(CORS)标准新增了一组 HTTP 首部字段，允许服务器声明哪些源站有权限访问哪些资源。
规范要求，对那些可能对服务器数据产生副作用的HTTP 请求方法（特别是 GET 以外的 HTTP 请求，或者搭配某些 MIME 类型的 POST 请求），浏览器必须首先使用 OPTIONS 方法发起一个预检请求（preflight request），从而获知服务端是否允许该跨域请求。服务器确认允许之后，才发起实际的 HTTP 请求。在预检请求的返回中，服务器端也可以通知客户端，是否需要携带身份凭证（包括 Cookies 和 HTTP 认证相关数据）。

Content-Type不属于以下MIME类型的，都属于预检请求,"预检"请求会带上头部信息 Access-Control-Request-Headers: Content-Type:

application/x-www-form-urlencoded
multipart/form-data
text/plain

### Content Type

用来向浏览器和服务器提供信息，表示该 URL 对应的资源类型。服务端通常是根据请求头（headers）中的 Content-Type 字段来获知请求中的消息主体是用何种方式编码，再对主体进行解析。

```
文件后缀    Content-Type(Mime-Type)
.css    text/css
.gif    image/gif
.htm    text/html
.html   text/html
.jpeg   image/jpeg
.jpg    image/jpeg
.js application/x-javascript
.ico    image/x-icon
.mp3    audio/mp3
.mp4    video/mpeg4
.mpeg   video/mpg
.mpg    video/mpg
.pdf    application/pdf
.png    image/png
.tif    image/tiff
.tiff   image/tiff
.torrent    application/x-bittorrent
.wav    audio/wav
.xhtml  text/html
```

dig可以显示整个查询过程

```sh
dig math.stackexchange.com

; <<>> DiG 9.10.6 <<>> math.stackexchange.com # 查询参数和统计
;; global options: +cmd
;; Got answer:

;; flags: qr rd ra; QUERY: 1, ANSWER: 4, AUTHORITY: 0, ADDITIONAL: 0

;; QUESTION SECTION: # 查询内容：域名的A记录
;math.stackexchange.com.        IN  A
;; ->>HEADER<< - opcode: QUERY, status: NOERROR, id: 14912
;; ANSWER SECTION: # 服务器答复:有四个A记录，即四个IP地址。600是TTL值（Time to live 的缩写），表示缓存时间，即600秒之内不用重新查询。
math.stackexchange.com. 300 IN  A   151.101.65.69
math.stackexchange.com. 300 IN  A   151.101.1.69
math.stackexchange.com. 300 IN  A   151.101.193.69
math.stackexchange.com. 300 IN  A   151.101.129.69

# NS记录（Name Server的缩写），即哪些服务器负责管理stackexchange.com的DNS记录。
# 四个域名服务器的IP地址，这是随着前一段一起返回的。
;; Query time: 119 msec
;; SERVER: 223.5.5.5#53(223.5.5.5) # 本机的DNS服务器是223.5.5.5，查询端口是53
;; WHEN: Sun Apr 08 23:54:53 CST 2018
;; MSG SIZE  rcvd: 104

dig @4.2.2.2 math.stackexchange.com # 显示向其他DNS服务器查询的结果
dig +trace math.stackexchange.com # 显示DNS的整个分级查询过程
dig ns com # 单独查看每一级域名的NS记录
dig ns stackexchange.com
dig +short ns stackexchange.com # 显示简化的结果
dig -x 192.30.252.153 # 查询PTR记录

host github.com # host命令可以看作dig命令的简化版本。返回当前请求域名的各种记录
host 192.30.252.153
 # nslookup命令用于互动式地查询域名记录
whois github.com # 用来查看域名的注册情况
```

## 缓存

* Expires：响应头，代表该资源的过期时间。服务端返回。时间是 GMT 格式的标准时间，如 Fri, 01 Jan 1990 00:00:00 GMT。单独的过期时间机制，浏览器端可以随意修改时间，导致缓存使用不精准
* Cache-Control：请求/响应头，缓存控制字段，精确控制缓存策略。对缓存的控制粒度更细，包括缓存代理服务器的缓存控制。
    - max-age=10秒。意思是在10秒以内，使用缓存到浏览器的 a.js 资源。果没有 Cache-Control，则以 Expires 为准。
    - public，资源允许被中间服务器缓存。
    - private，资源不允许被中间代理服务器缓存。
    - no-cache，浏览器不做缓存检查。
    - no-store，浏览器和中间代理服务器都不能缓存资源。
    - must-revalidate，可以缓存，但是使用之前必须先向源服务器确认。
    - proxy-revalidate，要求缓存服务器针对缓存资源向源服务器进行确认。
    - s-maxage：缓存服务器对资源缓存的最大时间。
* Etag：响应头，资源标识，由服务器告诉浏览器。内容变了，Etag 才变。内容不变，Etag 不变，可以理解为 Etag 是文件内容的唯一 ID。
* If-None-Match：请求头，缓存资源标识，由浏览器告诉服务器。发现有If-None-Match，则比较 If-None-Match 和文件的 Etag 值，忽略If-Modified-Since的比较。
* Last-Modified：响应头，资源最近修改时间，由服务器告诉浏览器。
* If-Modified-Since：请求头，资源最近修改时间，由浏览器告诉服务器。过期策略有效后，携带该字段（等于上一次请求的Last-Modified）发起请求，服务器比较请求头里的时间和服务器上文件的 Last-Modified，一致，返回304继续本地缓存，否则重新返回。只能精确到秒（妙极内变动，不会重新发）
* 主动通知
    - 添加版本号
    - 以 MD5hash 值来区分

### CORS

```php
// server
$origin = isset($_SERVER['HTTP_ORIGIN'])? $_SERVER['HTTP_ORIGIN'] : '';

$allow_origin = array(
    'http://client1.runoob.com',
    'http://client2.runoob.com'
);

if(in_array($origin, $allow_origin)){
    header('Access-Control-Allow-Origin:'.$origin);
}

# 允许所有域名访问则只需在http://server.runoob.com/server.php文件头部添加如下代码：
header('Access-Control-Allow-Origin:*');
```

## HTTTPS

HTTPS（Hyper Text Transfer Protocol over Secure Socket Layer):HTTP下加入SSL层，HTTPS的安全基础是SSL(Secure Sockets Layer 安全套接层)，因此加密的详细内容就需要SSL。HTTPS = HTTP 协议(进行通信) + SSL/TLS 协议（加密数据包），增加的 S 代表 Secure

* HTTP协议以明文方式发送内容，不提供任何方式的数据加密，如果攻击者截取了Web浏览器和网站服务器之间的传输报文，就可以直接读懂其中的信息
* HTTPS在HTTP的基础上加入了SSL协议，SSL依靠证书来验证服务器的身份，并为浏览器和服务器之间的通信加密。
    - 需要申请证书
    - 具有安全性的ssl加密传输协议
    - 端口也不一样，前者是80，后者是443
    - http的连接很简单，是无状态的；HTTPS协议是由SSL+HTTP协议构建的可进行加密传输、身份认证的网络协议，比http协议安全。
* SSL（Secure Sockets Layer 安全套接字层），它是一项标准技术，用于在客户端与服务器之间进行加密通信，可确保互联网连接安全，防止网络犯罪分子读取和修改任何传输信息，包括个人资料。
* TSL（Transport Layer Security 传输层安全），是 SSL 的继承协议，它建立在 SSL 3.0 协议规范之上，是更为安全的升级版 SSL。

![HTTPS签名和验证](../static/https-ac.png "HTTPS签名和验证")
![HTTP vs HTTPS](../static/https.png "HTTP与HTTPS区别")

* 购买证书，配置域名信息
    - [Let’s Encrypt](https://letsencrypt.org/)
* 获取证书文件，配置nginx,放到cert目录
* 解决方案：[certbot](https://certbot.eff.org/lets-encrypt/ubuntuxenial-nginx)

## Token

访问令牌（Access token）表示访问控制操作主体的系统对象

## DNS

* [tenta-browser/tenta-dns](https://github.com/tenta-browser/tenta-dns):Recursive and authoritative DNS server in go, including DNSSEC and DNS-over-TLS https://tenta.com/test
* [googlehosts/hosts](https://github.com/googlehosts/hosts)
* [Cloudflare](https://www.cloudflare.com):域名注册服务
* [coredns/coredns](https://github.com/coredns/coredns):CoreDNS is a DNS server that chains plugins https://coredns.io

## 工具

* [snail007/goproxy](https://github.com/snail007/goproxy):Proxy is a high performance HTTP(S), websocket, TCP, UDP,Secure DNS, Socks5 proxy server implemented by golang. Now, it supports chain-style proxies,nat forwarding in different lan,TCP/UDP port forwarding, SSH forwarding.Proxy是golang实现的高性能http,https,websocket,tcp,防污染DNS,socks5代理服务器,支持内网穿透,链式代理,通讯加密,智能HTTP,SOCKS5代理,域名黑白名单,跨平台,KCP协议支持,集成外部API。
* [jakubroztocil/httpie](https://github.com/jakubroztocil/httpie):Modern command line HTTP client – user-friendly curl alternative with intuitive UI, JSON support, syntax highlighting, wget-like downloads, extensions, etc. https://httpie.org https://twitter.com/clihttp
* [Netflix/pollyjs](https://github.com/Netflix/pollyjs):Record, Replay, and Stub HTTP Interactions. https://netflix.github.io/pollyjs
* [hazbo/httpu](https://github.com/hazbo/httpu):The terminal-first http client
* [FiloSottile/mkcert](https://github.com/FiloSottile/mkcert):A simple zero-config tool to make locally trusted development certificates with any names you'd like.
* [fukamachi/woo](https://github.com/fukamachi/woo):A fast non-blocking HTTP server on top of libev http://ultra.wikia.com/wiki/Woo_(kaiju)
* [mitmproxy/mitmproxy](https://github.com/mitmproxy/mitmproxy):An interactive TLS-capable intercepting HTTP proxy for penetration testers and software developers. https://mitmproxy.org/
* [mholt/caddy](https://github.com/mholt/caddy):Fast, cross-platform HTTP/2 web server with automatic HTTPS https://caddyserver.com
* [Neilpang/acme.sh](https://github.com/Neilpang/acme.sh):A pure Unix shell script implementing ACME client protocol https://acme.sh
* [asciimoo/wuzz](https://github.com/asciimoo/wuzz):Interactive cli tool for HTTP inspection
* [square/okhttp](https://github.com/square/okhttp):An HTTP+HTTP/2 client for Android and Java applications. http://square.github.io/okhttp/
* [jakubroztocil/httpie](https://github.com/jakubroztocil/httpie)Modern command line HTTP client – user-friendly curl alternative with intuitive UI, JSON support, syntax highlighting, wget-like downloads, extensions, etc. <https://httpie.org> <https://twitter.com/clihttp>
* [sindresorhus/ky](https://github.com/sindresorhus/ky):Tiny and elegant HTTP client based on the browser Fetch API
* [oldj/SwitchHosts](https://github.com/oldj/SwitchHosts):Switch hosts quickly! https://oldj.github.io/SwitchHosts/
* [coyove/goflyway](https://github.com/coyove/goflyway):An encrypted HTTP server
* [chimurai/http-proxy-middleware](https://github.com/chimurai/http-proxy-middleware):⚡️ The one-liner node.js http-proxy middleware for connect, express and browser-sync
* [julienschmidt/httprouter](https://github.com/julienschmidt/httprouter):A high performance HTTP request router that scales well
* [buger/goreplay](https://github.com/buger/goreplay):GoReplay is an open-source tool for capturing and replaying live HTTP traffic into a test environment in order to continuously test your system with real data. It can be used to increase confidence in code deployments, configuration changes and infrastructure changes. https://goreplay.org
* [JoeDog/siege](https://github.com/JoeDog/siege):Siege is an http load tester and benchmarking utility
* [requests/httpbin](https://github.com/requests/httpbin):HTTP Request & Response Service, written in Python + Flask. https://httpbin.org
* [dannagle/PacketSender](https://github.com/dannagle/PacketSender):Network utility for sending / receiving TCP, UDP, SSL https://packetsender.com/
* [tsenart/vegeta](https://github.com/tsenart/vegeta):HTTP load testing tool and library. It's over 9000! https://godoc.org/github.com/tsenart/vegeta/lib

### [cleanbrowsing/dnsperftest](https://github.com/cleanbrowsing/dnsperftest)

DNS Performance test

```sh
sudo apt-get install bc dnsutils

git clone --depth=1 https://github.com/cleanbrowsing/dnsperftest/
cd dnsperftest

bash ./dnstest.sh
bash ./dnstest.sh |sort -k 22 -n
```

## 参考

* [HTTP 下午茶](http://book.haoduoshipin.com/tealeaf-http/)
* [关于 TCP/IP，必知必会的十个问题](https://juejin.im/post/598ba1d06fb9a03c4d6464ab)
* [面试 -- 网络 HTTP](https://juejin.im/post/5872309261ff4b005c4580d4)
* [bolasblack/http-api-guide](https://github.com/bolasblack/http-api-guide)
* [HTTPS explained with carrier pigeons](https://medium.freecodecamp.org/https-explained-with-carrier-pigeons-7029d2193351)
