# 会话

由于HTTP协议是无状态的协议，所以服务端需要记录用户的状态时，就需要用某种机制来识具体的用户，这个机制就是Session.

典型的场景比如购物车，当你点击下单按钮时，由于HTTP协议无状态，所以并不知道是哪个用户操作的，所以服务端要为特定的用户创建了特定的Session，用用于标识这个用户，并且跟踪用户，这样才知道购物车里面有几本书。这个Session是保存在服务端的，有一个唯一标识。在服务端保存Session的方法很多，内存、数据库、文件都有。集群的时候也要考虑Session的转移，在大型的网站，一般会有专门的Session服务器集群，用来保存用户会话，这个时候 Session 信息都是放在内存的，使用一些缓存服务比如Memcached之类的来放 Session。

服务端如何识别特定的客户:这个时候Cookie就登场了。每次HTTP请求的时候，客户端都会发送相应的Cookie信息到服务端。实际上大多数的应用都是用 Cookie 来实现Session跟踪的，第一次创建Session的时候，服务端会在HTTP协议中告诉客户端，需要在 Cookie 里面记录一个Session ID，以后每次请求把这个会话ID发送到服务器，我就知道你是谁了。


## 实现

* 你第一次访问网站时，服务端脚本中开启了Sessionsession_start();，
* 服务器会生成一个不重复的 SESSIONID 的文件session_id();，比如在/var/lib/php/session目录
* 并将返回(Response)如下的HTTP头 Set-Cookie:PHPSESSIONID=xxxxxxx
* 客户端接收到Set-Cookie的头，将PHPSESSIONID写入cookie
* 当你第二次访问页面时，所有Cookie会附带的请求头(Request)发送给服务器端
* 服务器识别PHPSESSIONID这个cookie，然后去session目录查找对应session文件，
* 找到这个session文件后，检查是否过期，如果没有过期，去读取Session文件中的配置；如果已经过期，清空其中的配置

## session

* session 在服务器端，cookie 在客户端（浏览器）
* session 默认被存在在服务器的一个文件里（不是内存）
* session 的运行依赖 session id，而 session id 是存在 cookie 中的，也就是说，如果浏览器禁用了 cookie ，同时 session 也会失效（但是可以通过其它方式实现，比如在 url 中传递 session_id）
* session 可以放在 文件、数据库、或内存中都可以。
* 用户验证这种场合一般会用 session 因此，维持一个会话的核心就是客户端的唯一标识，即 session id

## 如果客户端的浏览器禁用了 Cookie 怎么办？

如果一个Cookie都没接收到，基本上可以预判客户端禁用了Cookie，那将session_id附带在每个网址后面(包括POST)，比如：

GET http://www.xx.com/index.php?session_id=xxxxx
POST http://www.xx.com/post.php?session_id=xxxxx

然后在每个页面的开头使用session_id($_GET['session_id'])，来强制指定当前session_id：

聪明的你肯定想到，那将这个网站发送给别人，那么他将会以你的身份登录并做所有的事情（目前很多订阅公众号就将openid附带在网址后面，这是同样的漏洞）。
其实不仅仅如此，cookie也可以被盗用，比如XSS注入，通过XSS漏洞获取大量的Cookie，也就是控制了大量的用户，腾讯有专门的XSS漏洞扫描机制，因为大量的QQ盗用，发广告就是因为XSS漏洞
所以Laravel等框架中，内部实现了Session的所有逻辑，并将PHPSESSIONID设置为httponly并加密，这样，前端JS就无法读取和修改这些敏感信息，降低了被盗用的风险。

* 会使用一种叫做URL重写的技术来进行会话跟踪，即每次HTTP交互，URL后面都会被附加上一个诸如 sid=xxxxx 这样的参数，服务端据此来识别用户。
* Cookie其实还可以用在一些方便用户的场景下，设想你某次登陆过一个网站，下次登录的时候不想再次输入账号了，怎么办？这个信息可以写到Cookie里面，访问网站的时候，网站页面的脚本可以读取这个信息，就自动帮你把用户名给填了，能够方便一下用户。这也是Cookie名称的由来，给用户的一点甜头。
* Session是在服务端保存的一个数据结构，用来跟踪用户的状态，这个数据可以保存在集群、数据库、文件中；
* Cookie是客户端保存用户信息的一种机制，用来记录用户的一些信息，也是实现Session的一种方式。

常见的session实现方式是基于cookie的， 所以禁用cookie，session随之时效

理论上只要在返回的页面里里能带上一个标识会话的令牌，在浏览器下一次提交的时候，能带上这个令牌，会话就可以被保持

因此，cookie只是最优雅的实现session的方式，因为cookie对用户来说不可见，同时会自动在HTTP报文中传输

但session也可以通过其他方式来保持， 比如放一个sessionId在URL的参数里
