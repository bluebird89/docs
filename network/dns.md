# DNS Domain Name System 域名系统

* DNS is an application layer protocol that runs on top of UDP(most of the times).
* DNS servers usually listen on port number 53. When a client makes a DNS request, after filling the necessary application payload, it passes the payload to the kernel via sendto system call.
* The kernel picks a random port number(>1024) as source port number and puts 53 as destination port number and sends the packet to lower layers. When the kernel on server side receives the packet, it checks the port number and queues the packet to the application buffer of the DNS server process which makes a recvfrom system call and reads the packet.
* This process by the kernel is called multiplexing(combining packets from multiple applications to same lower layers) and demultiplexing(segregating packets from single lower layer to multiple applications). Multiplexing and Demultiplexing is done by the Transport layer.
* 由分层 DNS 服务器实现的分布式数据库。运行在 UDP 上，使用 53 端口
* DNS服务器:因特网上存储域名和IP地址相互映射的一个分布式数据库，能够使用户更方便的访问互联网，而不用去记住能够被机器直接读取的IP数串。通过主机名，最终得到该主机名对应的IP地址的过程叫做域名解析（或主机名解析）
* 应用层协议，为其他应用层协议工作的，包括不限于HTTP和SMTP以及FTP，用于将用户提供的主机名解析为ip地址
* 域名中，越靠右的位置表示其层级越高
* 任何 DNS 服务器就都可以找到并访问根域 DNS 服务器,客户端只要能够找到任意一台 DNS 服务器，就可以通过它找到根域 DNS 服务器，然后再一路顺藤摸瓜找到位于下层的某台目标 DNS 服务器
* 流程
  - look up first in file (/etc/hosts)
    + `C:\Windows\System32\drivers\etc\hosts`隐藏文件没有扩展名
    + `/etc/hosts`
  - use DNS protocol to do the resolution if there is no match in /etc/hosts.The linux system makes a DNS request to the first IP in /etc/resolv.conf. If there is no response, requests are sent to subsequent servers in resolv.conf. These servers in resolv.conf are called DNS resolvers. The DNS resolvers are populated by DHCP or statically configured by an administrator.
  - first looks at its cache
  - The DNS server breaks “linkedin.com” to “.”, “com.” and “linkedin.com.” and starts DNS resolution from “.”.
  - The “.” is called root domain and those IPs are known to the DNS resolver software.
  - DNS resolver queries the root domain Nameservers to find the right nameservers which could respond regarding details for "com.". The address of the authoritative nameserver of “com.” is returned.
  - Now the DNS resolution service contacts the authoritative nameserver for “com.” to fetch the authoritative nameserver for “linkedin.com”.
  - Once an authoritative nameserver of “linkedin.com” is known, the resolver contacts Linkedin’s nameserver to provide the IP address of “linkedin.com”.
* `nslookup google.com`
* [WHOIS ](https://whois.icann.org/en/lookup?name=bluebird89.cyou) 确定注册机构

* 国内用户普遍使用的是ISP运营商提供的DNS服务器，这样有着一个巨大的风险，就是DNS劫持,目前国内ISP运营商普遍采用DNS劫持的方法，干扰用户正常上网，例如，当用户访问一个不存在（或者被封）的网站，电信运营商就会把用户劫持到一个满屏都是广告的页面，以帮助自己盈利
  - 劫持广告：原来的网页被放置到一个iframe里，并注入了flash广告
  - 面地址后面是不是有后缀
* 低延迟说明全国各地（至少在省内或者附近，不会南方跨到北方）直接返回被劫持的IP
* TCP查询同样中枪，排除黑阔采用全国发UDP包方式进行劫持
* 利用DNS实现负载均衡，并且在配置运营商CDN机房时也是重要的一部分。DNS技术属于前端架构甚至更前的一部分，不难看出一个大型网站在提供好扎实的应用层和数据层服务后亟待解决的是访问的问题，访问安全问题也是伴随着要解决的问题之一。
  - 出于资源消耗和响应速度的综合考虑，一般来说从主机到本地DNS服务器是递归查询，从本地DNS到其他DNS服务器是迭代查询
* 互联网上几乎一切活动都以 DNS 请求开始。DNS 是 Internet 的目录,您的 ISP (Internet Service Provider) 以及在 Internet 上进行监听的其他任何人，都能够看到访问的站点以及您使用的每个应用.一些 DNS 提供商会出售个人 Internet 活动相关数据，或是利用这些数据向您发送有针对性的广告

```sh
sudo tcpdump -s 0 -A -i any port 53
```

## 记录 record 域名与IP之间的对应关系

* Domain_name：适用于哪个域名
* TTl `Time_to_live`：表明记录生存周期，最多可以缓存该记录多长时间
  - 任何一条 DNS 缓存，在超过过期时间后都必须丢弃！ 另外在没超时的时候，DNS 缓存也可以被主动或者被动地刷新。
* Class：一般总是IN
* Type 类型
  - A：IPv4地址记录（Address），返回域名指向的IP地址
  - AAAA:IPv6地址记录
  - NS：域名服务器记录（Name Server），返回保存下一级域名信息的服务器地址。该记录只能设置为域名，不能设置为IP地址。为了服务的安全可靠，至少应该有两条NS记录
    + 记录 DNS 域对应的权威服务器域名，权威服务器域名必须要有对应的 A 记录。
    + 通过这个记录，可以将子域名的解析分配给别的 DNS 服务器
  - MX：邮件记录（Mail eXchange），返回接收电子邮件的服务器地址。邮件服务器的域名必须要有对应的 A 记录
  - CNAME：规范名称记录（Canonical Name），返回另一个域名，即当前查询的域名是另一个域名的跳转。用于域名的内部跳转，为服务器配置提供灵活性，用户感知不到。一旦设置CNAME记录以后，就不能再设置其他记录了（比如A记录和MX记录），这是为了防止产生冲突
  - PTR：逆向查询记录（Pointer Record），只用于从IP地址查询域名
* Value：记录的值，如果是A记录，则value是一个IPv4地址

## 层次

* 根域名服务器 Root DNS Server ：保存所有顶级区域的权威域名服务器记录
  - 根域名服务器负责解析顶级域名，给出顶级域名的 DNS 服务器地址。
  - 全世界仅有十三组根域名服务器，这些服务器的 ip 地址基本不会变动。
  - 它的域名是 “"，空字符串。而它的**全限定域名（FQDN）**是 .，因为 FQDN 总是以 . 结尾
* 顶级域名服务器 Top-level DNS Server TLDs .com .cn 等国际、国家级的域名
  - 由ICANN（互联网名称与数字地址分配机构）负责管理。目前已经有超过250个顶级域名，每个顶级域名可以进一步划为一些子域（二级域名），这些子域可被再次划分（三级域名）
  - 顶级域名服务器负责解析次级域名，给出次级域名的 DNS 服务器地址。
  - 每个顶级域名都对应各自的服务器，它们之间是完全独立的。.cn 的域名解析仅由 .cn 顶级域名服务器提供。
  - 目前国际 DNS 系统中已有上千个 TLD，包括中文「.我爱你」甚至藏文域名，详细列表参见 IANA TLD 数据库
  - 除了国际可用的 TLD，还有一类类似「内网 IP 地址」的“私有 TLD”，最常见的比如 xxx.local xxx.lan，被广泛用在集群通信中
* 权威 DNS 服务器 Authoritative DNS Server
* 次级域（Second Level Domains）：这个才是个人/企业能够买到的域名，比如 baidu.com
  - 每个次级域名都有一到多个权威 DNS 服务器，这些 DNS 服务器会以 NS 记录的形式保存在对应的顶级域名（TLD）服务器中。
  - 权威域名服务器则负责给出最终的解析结果：ip 地址(A 记录 )，另一个域名（CNAME 记录）、另一个 DNS 服务器（NS 记录）等。
* 子域（Sub Domians）：*.baidu.com 统统都是 baidu.com 的子域
  - 每一个子域都可以有自己独立的权威 DNS 服务器，这通过在子域中添加 NS 记录实现
* 本地 DNS 服务器(local DNS server)：每个 ISP(Internet Service Provider) 都有一台本地 DNS 服务器，起着代理的作用，并将该请求转发到 DNS 服务器层次系统中

* 域名空间划分为A, B, C, D, E, F, G七个DNS区域，每个DNS区域都有多个权威域名服务器，这些域名服务器里面保存了许多域名解析记录
  - A 类：1.0.0.0-1226.255.255.255，默认子网掩码/8，即255.0.0.0。
  - B 类：128.0.0.0-191.255.255.255，默认子网掩码/16，即255.255.0.0。
  - C 类：192.0.0.0-223.255.255.255，默认子网掩码/24，即255.255.255.0。
  - D 类：224.0.0.0-239.255.255.255，一般用于组播。
  - E 类：240.0.0.0-255.255.255.255(其中255.255.255.255为全网广播地址)。E 类地址一般用于研究用途。
  - 0.0.0.0 严格来说，0.0.0.0 已经不是一个真正意义上的 IP 地址了。它表示的是这样一个集合：所有不清楚的主机和目的网络。这里的不清楚是指在本机的路由表里没有特定条目指明如何到达。作为缺省路由。 127.0.0.1 本机地址。
  - 224.0.0.1 组播地址。如果你的主机开启了IRDP（internet路由发现，使用组播功能），那么你的主机路由表中应该有这样一条路由。
  - 169.254.x.x 使用了 DHCP 功能自动获取了 IP 的主机，DHCP 服务器发生故障，或响应时间太长而超出了一个系统规定的时间，系统会为你分配这样一个 IP，代表网络不能正常运行。
  - 10.xxx、172.16.x.x~172.31.x.x、192.168.x.x 私有地址。大量用于企业内部。保留这样的地址是为了避免亦或是哪个接入公网时引起地址混乱。

## 本地 DNS 服务器与私有 DNS 域

* 通过 DHCP 或者手动配置的方式，使内网的服务器都默认使用局域网 DNS 服务器进行解析。该服务器可以只解析自己的私有 DNS 域，而将其他 DNS 域的解析 forward 到公网 DNS 解析器去
* 会覆盖掉公网的同名域(如果公网上有这个域的话)。
* 私有 dns 域也可使用公网不存在的 TLD

* 传统基于 UDP 协议的公共 DNS 服务极易发生 DNS 劫持，从而造成安全问题
* HTTPDNS
  - 通过 HTTP 协议直接向权威 DNS 服务器发起请求，绕过了一堆中间的 DNS 递归解析器，代替传统基于 UDP 协议的 DNS 交互，绕开了运营商的 Local DNS，有效防止了域名劫持，提高域名解析效率
  - 由于 DNS 服务器端获取的是真实客户端 IP 而非 Local DNS 的 IP，能够精确定位客户端地理位置、运营商信息，从而有效改进调度精确性。
  - 解决问题
    + Local DNS 劫持：由于 HttpDns 是通过 IP 直接请求 HTTP 获取服务器 A 记录地址，不存在向本地运营商询问 domain 解析过程，所以从根本避免了劫持问题。
    + 平均访问延迟下降：由于是 IP 直接访问省掉了一次 domain 解析过程，通过智能算法排序后找到最快节点进行访问。
    + 用户连接失败率下降：通过算法降低以往失败率过高的服务器排序，通过时间近期访问过的数据提高服务器排序，通过历史访问成功记录提高服务器排序。
    + 权威 DNS 服务器能直接获取到客户端的真实 IP（而不是某个中间 DNS 递归解析器的 IP），能实现就近调度。
    + 因为是直接与权威 DNS 服务器连接，避免了 DNS 缓存污染的问题
  - 如何进行改造支持 HttpDns
    + 阿里云的 HttpDNS 服务 `http://203.107.1.1/d?host=www.linkedkeeper.com`

* DNS 请求是可以被抢答 `dig www.bennythink.com +short`

```
## `/etc/resolv.conf`
ns3.dnsowl.com # name silo default name server
ns3.dnsowl.com
ns3.dnsowl.com

host -a baidu.com  # host 基本就是 dig 的弱化版，不过 host 有个有点就是能打印出它测试过的所有 FQDN

nslookup baidu.com # 和 host 没啥大差别，多个交互式查询不过一般用不到
whois baidu.com # 查询域名注册信息，内网诊断用不到
```

## [dnsperftest](https://github.com/cleanbrowsing/dnsperftest)

DNS Performance test

```sh
sudo apt-get install bc dnsutils

git clone --depth=1 https://github.com/cleanbrowsing/dnsperftest/
cd dnsperftest

bash ./dnstest.sh
bash ./dnstest.sh |sort -k 22 -n
```

## dig 查看域名解析过程


* 正向解析:将域名解析为 IP 地址
* 反向解析
  - 记录类型：PTR 记录，提供将 IP 地址反向解析为域名的功能
  - 因为域名是从右往左读的（最右侧是根, www.baidu.com.），而 IP 的网段（如 192.168.0.0/16）刚好相反，是左边优先。 因此 PTR 记录的“域名”必须将 IP 地址反着写，末尾再加上 .in-addr.arpa. 表示这是一个反向解析的域名。（ipv6 使用 ip6.arpa.）
* 查询方式
  - 递归查询(Recursive query)：如果主机所询问的本地域名服务器不知道被查询域名的 IP 地址，那么本地域名服务器就以 DNS 客户的身份，向其他根域名服务器继续发出查询请求报文，而不是让该主机自己进行下一步的查询。
  - 迭代查询(Iteration query)：当根域名服务器收到本地域名服务器发出的迭代查询请求报文时，要么给出所要查询的 IP 地址，要么告诉本地域名服务器：你下一步应当向哪一个域名服务器进行查询。然后让本地域名服务器进行后续的查询，而不是替本地域名服务器进行后续的查询。
  - 客户端到 Local DNS 服务器，Local DNS 与上级 DNS 服务器之间属于递归查询；DNS 服务器与根 DNS 服务器之前属于迭代查询
* `dig` a userspace DNS system which creates and sends request to DNS resolvers and prints the response it receives to the console.显示整个查询过程
* DNS服务器的IP地址
  - DHCP机制:动态的，每次上网时由网关分配
  - 事先指定的固定地址。Linux系统保存在/etc/resolv.conf文件
* DNS服务器通过分级查询每个域名的IP地址，域名math.stackexchange.com显示为math.stackexchange.com.。这不是疏忽，而是所有域名的尾部，实际上都有一个根域名
  - www.example.com真正的域名是www.example.com.root，简写为www.example.com.。因为，根域名.root对于所有域名都是一样的，所以平时是省略的
  - 根域名的下一级，叫做”顶级域名”（top-level domain，缩写为TLD），比如.com、.net
  - 再下一级叫做”次级域名”（second-level domain，缩写为SLD），比如www.example.com里面的.example，这一级域名是用户可以注册的
  - 再下一级是主机名（host），比如www.example.com里面的www，又称为”三级域名”，这是用户在自己的域里面为服务器分配的名称，是用户可以任意分配的
  - 每一级域名都有自己的NS记录，NS记录指向该级域名的域名服务器。这些服务器知道下一级域名的各种记录。所谓”分级查询”，就是从根域名开始，依次查询每一级域名的NS记录，直到查到最终的IP地址，过程大致如下
    + 根域名服务器”的NS记录和IP地址一般是不会变化的，所以内置在DNS服务器里面。世界上一共有十三组根域名服务器，从A.ROOT-SERVERS.NET一直到M.ROOT-SERVERS.NET
    + 从”根域名服务器”查到”顶级域名服务器”的NS记录和A记录（IP地址）
    + 从”顶级域名服务器”查到”次级域名服务器”的NS记录和A记录（IP地址）
    + 从”次级域名服务器”查出”主机名”的IP地址
* [ipaddress](https://www.ipaddress.com/)

```sh
dig linkedin.com
dig +trace linkedin.com
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

# NS记录（Name Server的缩写），即哪些服务器负责管理stackexchange.com的DNS记录。 四个域名服务器的IP地址，这是随着前一段一起返回的。
;; Query time: 119 msec
;; SERVER: 223.5.5.5#53(223.5.5.5) # 本机的DNS服务器是223.5.5.5，查询端口是53
;; WHEN: Sun Apr 08 23:54:53 CST 2018
;; MSG SIZE  rcvd: 104

dig @4.2.2.2 math.stackexchange.com # 显示向其他DNS服务器查询的结果

# 主机名.次级域名.顶级域名.根域名，即
host.sld.tld.root

dig +trace math.stackexchange.com
# 第一段列出根域名.的所有NS记录，即所有根域名服务器 根据内置的根域名服务器IP地址，DNS服务器向所有这些IP地址发出查询请求，询问math.stackexchange.com的顶级域名服务器com.的NS记录。最先回复的根域名服务器将被缓存，以后只向这台服务器发请求。
# 第二段显示.com域名的13条NS记录，同时返回的还有每一条记录对应的IP地址。 然后，DNS服务器向这些顶级域名服务器发出查询请求，询问math.stackexchange.com的次级域名stackexchange.com的NS记录
# 显示stackexchange.com有四条NS记录，同时返回的还有每一条NS记录对应的IP地址。 然后，DNS服务器向上面这四台NS服务器查询math.stackexchange.com的主机名
# 这四个IP地址都可以访问到网站。并且还显示，最先返回结果的NS服务器

# dig ns com
# dig ns stackexchange.com

dig +short ns stackexchange.com # 显示简化的结果
dig -x 192.30.252.153 # 查询PTR记录

# 可以查看指定的记录类型
dig a github.com
dig ns github.com
dig mx github.com

host github.com # host命令可以看作dig命令的简化版本。返回当前请求域名的各种记录
host 192.30.252.153
nslookup #  命令用于互动式地查询域名记录
whois github.com # 用来查看域名的注册情况

sudo killall -HUP mDNSResponder
sudo killall mDNSResponderHelper
sudo dscacheutil -flushcache

ifconfig /flushdns # 刷新DNS
```

## Public DNS 公共 DNS 服务

* DNS Resolver 域名解析器
* 公共 DNS 服务
  - 设计为分布式集群的工作方式：使用分布式层次数据库模式以及缓存方法来解决单点集中式的问题
  - 可通过修改网络连接的DNS server 地址
* 用户量大，缓存了大量的 DNS 记录，有效地降低了上游 DNS 服务器的压力，也加快了网络上的 DNS 查询速度

```
# Google Public DNS IP addresses
8.8.8.8
8.8.4.4
2001:4860:4860::8888
2001:4860:4860::8844

# SDNS（`http://www.sdns.cn/`）
1.2.4.8
210.2.4.8

# OneDNS
112.124.47.27 # 南方首选/北方备用
114.215.126.16 # 北方首选/南方备用
42.236.82.22 # 共用

# Public DNS+
119.29.29.29
182.254.116.116

# 114
114.114.114.114
114.114.114.115
## 拦截钓鱼病毒木马网站，增强网银、证券、购物、游戏、隐私信息安全
114.114.114.119
114.114.115.119
## 学校或家长可选，拦截色情网站，保护少年儿童免受网络色情内容的毒害
114.114.114.110
114.114.115.110

# Cloudflare
1.1.1.1
1.0.0.1
2606:4700:4700::1111
2606:4700:4700::1001

# BaiduDNS
180.76.76.76
2400:da00::6666

# alidns
223.5.5.5
223.6.6.6
2400:3200::1
2400:3200:baba::1

# OpenDNS
208.67.222.222
208.67.220.220
2620:0:ccc::2
2620:0:ccd::2

# 台湾中华电讯的 DNS：
168.95.192.1
168.95.192.2

# 香港宽频的 DNS：
203.80.96.9
203.80.96.10

# DNSPod DNS+
119.29.29.29
182.254.116.116

# Neustar UltraDNS IPv6
2610:a1:1018::1
2610:a1:1019::1
2610:a1:1018::5

# tsinghua
101.6.6.6
2001:da8:ff:305:20c:29ff:fe1f:a92a
# 清华大学 TUNA 协会 IPv6 DNS 服务器
2001:da8::666

# 中科大DNS
202.38.64.1
202.112.20.131
202.141.160.95
202.141.160.99

202.141.176.95
202.141.176.99

# 北京邮电大学 IPv6 DNS 服务器
2001:da8:202:10::36
2001:da8:202:10::37

# 上海交通大学 IPv6 DNS 服务器
2001:da8:8000:1:202:120:2:100
2001:da8:8000:1:202:120:2:101

# 中科院网络信息中心 IPv6 DNS 服务器
2001:cc0:2fff:1::6666

# 北京交通大学 IPv6 DNS 服务器
2001:da8:205:2060::188

# 北京科技大学 IPv6 DNS 服务器
2001:da8:208:10::6
# 科技网 IPv6 DNS 服务器
2001:cc0:2fff:2::6

# 下一代互联网北京研究中心
240C::6666
240C::6644

# CNNIC IPv6 DNS 服务器
1.2.4.8
210.2.4.8
2001:dc7:1000::1

# Quad9 DNS IBM 发起的 Quad9 提供的公共免费 DNS 上海
9.9.9.9
149.112.112.112
```


## DNS 缓存污染 DNS cache pollution

* 不是指域名被墙。域名仍能被解析到正确的IP地址，只是客户端（指用户浏览器/服务请求端）不能与网站服务器握手，或通过技术阻断或干扰的方式阻止握手成功，以至达到超时、屏蔽、连接重置、服务中断的现象
* 对所有经过防火长城（英语：Great Firewall，常用简称：GFW）的在UDP的53端口上的域名查询进行IDS入侵检测，一经发现与黑名单关键词相匹配的域名查询请求，会马上伪装成目标域名的解析服务器返回虚假的查询结果。由于通常的域名查询没有任何认证机制，而且域名查询通常基于无连接不可靠的UDP协议，查询者只能接受最先到达的格式正确结果，并丢弃之后的结果。[1]
  - 对于不了解相关知识的网民来说，由于系统默认从使用的ISP所提供的域名查询服务器去查询国外的权威服务器时，即被防火长城污染，进而使其缓存受到污染，因此默认情况下查询ISP的服务器就会获得虚假IP地址；而用户直接查询境外域名查询服务器（比如 Google Public DNS）时有可能会直接被防火长城污染，从而在没有任何防范机制的情况下仍然不能获得目标网站正确的IP地址。[1]
  - 因为TCP连接的机制可靠，防火长城理论上未对TCP协议下的域名查询进行污染，故现在能透过强制使用TCP协议查询真实的IP地址。而现实的情况是，防火长城对于真实的IP地址也可能会采取其它的手段进行封锁，或者对查询行为使用TCP重置攻击的方法进行拦截，故能否真正访问可能还需要其它翻墙的手段。
  - 通常情况下无论使用设置在中国大陆的DNS服务还是使用设置在海外的DNS服务，因为解析结果都需要穿过GFW，所以都会被GFW污染。但是仍有一些设置在中国大陆的小型DNS使用技术手段回避GFW的污染并提供不受污染的结果，通常使用这些小型DNS也能够访问其他被封锁的网站。
  - DNS污染的污染IP不是一成不变的，污染的无效IP在一段时间后会更新。
* [检测](https://www.checkgfw.com/)

## Dnsmasq

* 提供 DNS 缓存和 DHCP 服务功能。作为域名解析服务器(DNS)，dnsmasq可以通过缓存 DNS 请求来提高对访问过的网址的连接速度。作为DHCP 服务器，dnsmasq 可以用于为局域网电脑分配内网ip地址和提供路由。DNS和DHCP两个功能可以同时或分别单独实现。dnsmasq轻量且易配置，适用于个人用户或少于50台主机的网络。此外它还自带了一个 PXE 服务器
* 将Dnsmasq作为本地DNS服务器使用，直接修改电脑的本地DNS的IP地址即可
* 应对ISP的DNS劫持（反DNS劫持），输入一个不存在的域名，正常的情况下浏览器是显示无法连接，DNS劫持会跳转到一个广告页面。先随便nslookup 一个不存在的域名，看看ISP商劫持的IP地址
* 智能DNS加快解析速度，打开/etc/dnsmasq.conf文件，server=后面可以添加指定的DNS，例如国内外不同的网站使用不同的DNS
* 配置 /etc/dnsmasq.conf
  - resolv-file 定义dnsmasq从哪里获取上游DNS服务器的地址， 默认从/etc/resolv.conf获取。
  - strict-order 表示严格按照resolv-file文件中的顺序从上到下进行DNS解析，直到第一个解析成功为止。
  - listen-address 定义dnsmasq监听的地址，默认是监控本机的所有网卡上。
  - address 启用泛域名解析，即自定义解析a记录，例如：address=/long.com/192.168.115.10 访问long.com时的所有域名都会被解析成192.168.115.10
  - bogus-nxdomain 对于任何被解析到此 IP 的域名，将响应 NXDOMAIN 使其解析失效，可以多次指定,通常用于对于访问不存在的域名，禁止其跳转到运营商的广告站点
  - server 指定使用哪个DNS服务器进行解析，对于不同的网站可以使用不同的域名对应解析。例如：server=/google.com/8.8.8.8#表示对于google的服务，使用谷歌的DNS解析
* 解析流程
  - 先去解析hosts文件， 再去解析/etc/dnsmasq.d/下的*.conf文件，并且这些文件的优先级要高于dnsmasq.conf
  - 自定义的resolv.dnsmasq.conf中的DNS也被称为上游DNS，这是最后去查询解析的
  - 不想用hosts文件做解析:在/etc/dnsmasq.conf中加入no-hosts
* dnsmasq dnscrypt 加上国内外分流
* [dnsmasq-china-list](https://github.com/felixonmars/dnsmasq-china-list):Chinese-specific configuration to improve your favorite DNS server. Best partner for chnroutes.

## 服务

* [ChinaDNS](https://github.com/shadowsocks/ChinaDNS):Protect yourself against DNS poisoning in China.
* [dnscrypt-proxy](https://github.com/jedisct1/dnscrypt-proxy):dnscrypt-proxy 2 - A flexible DNS proxy, with support for encrypted DNS protocols. <https://dnscrypt.info>
* [googlehosts/hosts](https://github.com/googlehosts/hosts):镜像：<https://coding.net/u/scaffrey/p/hosts/git>
* [tenta-dns](https://github.com/tenta-browser/tenta-dns):Recursive and authoritative DNS server in go, including DNSSEC and DNS-over-TLS <https://tenta.com/test>
* [Cloudflare](https://www.cloudflare.com):域名注册服务,解析加速
* onedns   117.50.10.10    52.80.52.52纯净版
* [nextdns](https://nextdns.io/zh)
* [DNSpod](https://console.dnspod.cn/)
* [NextDNS](https://nextdns.io/):Block ads, trackers and malicious websites on all your devices. Get in-depth analytics about your Internet traffic. Protect your privacy and bypass censorship. Shield your kids from adult content.

## [NameSilo](https://www.namesilo.com/)

* 域名注册
* 二级域名解析
  - 登录后点击右上角  Manage My Domains
  - 已经购买的域名。然后点击右边的 蓝色小球 编辑 DNS
  - 点击上方的A，在hostname里填www，ipv4 address填你服务器的ip，TTL改成3600
* 便宜域名生效慢
* [godaddy](https://www.godaddy.com/)
