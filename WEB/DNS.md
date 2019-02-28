# DNS（Domain Name System，域名系统）

因特网上作为域名和IP地址相互映射的一个分布式数据库，能够使用户更方便的访问互联网，而不用去记住能够被机器直接读取的IP数串。通过主机名，最终得到该主机名对应的IP地址的过程叫做域名解析（或主机名解析）。DNS协议运行在UDP协议之上，使用端口号53。

域名与IP之间的对应关系，称为"记录"（record）。根据使用场景，"记录"可以分成不同的类型（type）

* A：地址记录（Address），返回域名指向的IP地址。
* NS：域名服务器记录（Name Server），返回保存下一级域名信息的服务器地址。该记录只能设置为域名，不能设置为IP地址。为了服务的安全可靠，至少应该有两条NS记录
* MX：邮件记录（Mail eXchange），返回接收电子邮件的服务器地址。
* CNAME：规范名称记录（Canonical Name），返回另一个域名，即当前查询的域名是另一个域名的跳转。用于域名的内部跳转，为服务器配置提供灵活性，用户感知不到。一旦设置CNAME记录以后，就不能再设置其他记录了（比如A记录和MX记录），这是为了防止产生冲突
* PTR：逆向查询记录（Pointer Record），只用于从IP地址查询域名

## 查询过程

dig可以显示整个查询过程

* 通过DNS服务器，才能知道某个域名的IP地址到底是什么。
* DNS服务器的IP地址，有可能是动态的，每次上网时由网关分配，这叫做DHCP机制；
* 也有可能是事先指定的固定地址。Linux系统里面，DNS服务器的IP地址保存在/etc/resolv.conf文件。
* 公网的DNS服务器：Google的8.8.8.8和Level 3的4.2.2.2
* DNS服务器通过分级查询每个域名的IP地址，域名math.stackexchange.com显示为math.stackexchange.com.。这不是疏忽，而是所有域名的尾部，实际上都有一个根域名
    - www.example.com真正的域名是www.example.com.root，简写为www.example.com.。因为，根域名.root对于所有域名都是一样的，所以平时是省略的。
    - 根域名的下一级，叫做”顶级域名”（top-level domain，缩写为TLD），比如.com、.net；
    - 再下一级叫做”次级域名”（second-level domain，缩写为SLD），比如www.example.com里面的.example，这一级域名是用户可以注册的；
    - 再下一级是主机名（host），比如www.example.com里面的www，又称为”三级域名”，这是用户在自己的域里面为服务器分配的名称，是用户可以任意分配的。
    - 每一级域名都有自己的NS记录，NS记录指向该级域名的域名服务器。这些服务器知道下一级域名的各种记录。所谓”分级查询”，就是从根域名开始，依次查询每一级域名的NS记录，直到查到最终的IP地址，过程大致如下
        + 根域名服务器”的NS记录和IP地址一般是不会变化的，所以内置在DNS服务器里面。世界上一共有十三组根域名服务器，从A.ROOT-SERVERS.NET一直到M.ROOT-SERVERS.NET。
        + 从”根域名服务器”查到”顶级域名服务器”的NS记录和A记录（IP地址）
        + 从”顶级域名服务器”查到”次级域名服务器”的NS记录和A记录（IP地址）
        + 从”次级域名服务器”查出”主机名”的IP地址

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
```

### 列表

```
8.8.8.8
8.8.4.4
```

### [cleanbrowsing/dnsperftest](https://github.com/cleanbrowsing/dnsperftest)

DNS Performance test

```sh
sudo apt-get install bc dnsutils

git clone --depth=1 https://github.com/cleanbrowsing/dnsperftest/
cd dnsperftest

bash ./dnstest.sh
bash ./dnstest.sh |sort -k 22 -n
```

## 工具

* [jedisct1/dnscrypt-proxy](https://github.com/jedisct1/dnscrypt-proxy):dnscrypt-proxy 2 - A flexible DNS proxy, with support for encrypted DNS protocols. https://dnscrypt.info
* [googlehosts/hosts](https://github.com/googlehosts/hosts):镜像：https://coding.net/u/scaffrey/p/hosts/git
* [tenta-browser/tenta-dns](https://github.com/tenta-browser/tenta-dns):Recursive and authoritative DNS server in go, including DNSSEC and DNS-over-TLS https://tenta.com/test
* [googlehosts/hosts](https://github.com/googlehosts/hosts)
* [Cloudflare](https://www.cloudflare.com):域名注册服务
* [coredns/coredns](https://github.com/coredns/coredns):CoreDNS is a DNS server that chains plugins https://coredns.io
