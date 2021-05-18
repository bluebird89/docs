## [Tcpdump](http://www.tcpdump.org/)

* 在命令行中通过指定表达式输出匹配捕获到的数据包的信息
* 采用底层库winpcap/libpcap实现。采用了bpf过滤机制
* 参数
  - -a 将网络地址和广播地址转变成名字
  - -A 打印ascii
  - -c 在收到指定包的数目后，tcpdump就会停止 Only get x number of packets and then stop.
  - -d 将匹配信息包的代码以人们能够理解的汇编格式给出
  - -D Show the list of available interfaces
  - -dd 将匹配信息包的代码以c语言程序段的格式给出
  - -ddd 将匹配信息包的代码以十进制的形式给出
  - -e 在输出行打印出数据链路层的头部信息 Get the ethernet header as well.
  - -E Decrypt IPSEC traffic by providing an encryption key.
  - -f 将外部的Internet地址以数字的形式打印出来
  - -F 从指定的文件中读取表达式,忽略其它的表达式
  - `-i eth0` 指定网卡
    + -i any get all interfaces
  - -l 使标准输出变为缓冲行形式 Line-readable output (for viewing as you save, or sending to other commands)
  - -n 不解析域名
  - -nn 表示端口也是数字，否则解析成服务名,不解析IP地址和端口的名称
  - -q Show less protocol information.
  - -r 从指定的文件中读取包(这些包一般通过-w选项产生)
  - -s 设置抓包长度，0表示不限制 Define the snaplength (size) of the capture in bytes. Use -s0 to get everything, unless you are intentionally capturing less.
  - -S Print absolute sequence numbers.
  - -t 在输出的每一行不打印时间戳 Give human-readable timestamp output.
  - -tttt Give maximally human-readable timestamp output.
  - -T 将监听到的包直接解释为指定的类型的报文，常见的类型有rpc（远程过程调用）和snmp（简单网络管理协议）
  - -v 输出一个稍微详细的信息，例如在ip包中可以包括ttl和服务类型的信息
  - -vv 输出详细的报文信息
  - -w 将抓取的包写入到某个文件中
  - -X 打印hex码 Show the packet’s contents in both hex and ascii.
  - -XX Same as -X, but also shows the ethernet header.
* Combinations
  - 非 : ! or "not" (去掉双引号)
  - 且 : && or "and"
  - 或 : || or "or"
* 参考
  - [](https://hackertarget.com/tcpdump-examples/)

```sh
# networking tool which displays the TCP/IP packets transmitted and received by your system
tcpdump -c 15
tcpdump --help

# 网络过滤
tcpdump net 1.2.3.0/24
# 协议过滤
tcpdump -nn icmp

tcpdump -nn host 192.168.1.100
tcpdump -nn port 80


# find traffic by ip tcpdump host|src｜dst 1.1.1.1`
tcpdump ip6
tcpdump dst 192.168.0.2 and src net and not icmp
tcpdump 'src 10.0.2.4 and (dst port 3389 or 22)'
# verbose output, with no resolution of hostnames or port numbers, using absolute sequence numbers, and showing human-readable timestamps
tcpdump -ttnnvvS
tcpdump -nnvvS src 10.5.2.3 and dst port 3389

tcpdump -nvX src net 192.168.0.0/16 and dst net 10.0.0.0/8 or 172.16.0.0/16

# 端口过滤
tcpdump portrange 21-23
# based on packet size
tcpdump less 32
tcpdump greater 64
tcpdump <= 128

# reading / writing captures to a file (pcap)
tcpdump port 80 -w capture_file
tcpdump -r capture_file

# 抓取所有经过网卡1，目的或源地址IP为172.16.7.206的网络数据
tcpdump -i eth1 [src|dst] host 172.16.7.206
# 抓取所有经过网卡1，目的或源端口为1234的网络数据
tcpdump -i eth1 [src|dst] port 1234
tcpdump -i eth0 host 10.10.1.1

tcpdump -i eth1 [src|dst] net 192.168
# 抓取所有经过网卡1，协议类型为UDP的网络数据
tcpdump -i eth1 udp|arp|ip|tcp|icmp
# 抓取本地环路数据包
tcpdump -i lo udp # 抓取UDP数据
tcpdump -i lo udp port 1234 # 抓取端口1234的UDP数据
tcpdump -i lo port 1234 # 抓取端口1234的数据


# 抓取所有经过网卡1的SYN类型数据包
tcpdump -i eth1 ‘tcp[tcpflags] = tcp-syn’
# 抓取经过网卡1的所有DNS数据包（默认端口）
tcpdump -i eth1 udp dst port 53

# 逻辑语句过滤：抓取所有经过网卡1，目的网络是172.16，但目的主机不是192.168.1.200的TCP数据
tcpdump -i eth1 ‘((tcp) and ((dst net 172.16) and (not dst host 192.168.1.200)))’
# 抓取所有经过 eth1，目标 MAC 地址是 00:01:02:03:04:05 的 ICMP 数据
tcpdump -i eth1 '((icmp) and ((ether dst host 00:01:02:03:04:05)))'
# 抓取所有经过网卡1，目的主机为172.16.7.206的端口80的网络数据并存储
tcpdump -i eth1 host 172.16.7.206 and port 80 -w /tmp/xxx.cap

# 只抓 SYN 包
tcpdump -i eth1 'tcp[tcpflags] = tcp-syn'
# 抓 SYN, ACK
tcpdump -i eth1 'tcp[tcpflags] & tcp-syn != 0 and tcp[tcpflags] & tcp-ack != 0'

# Isolate TCP RST flags.
tcpdump 'tcp[13] & 4!=0'
tcpdump 'tcp[tcpflags] == tcp-rst'

# Isolate TCP SYN flags.
tcpdump 'tcp[13] & 2!=0'
tcpdump 'tcp[tcpflags] == tcp-syn'

# Isolate packets that have both the SYN and ACK flags set.
tcpdump 'tcp[13]=18'

# Isolate TCP URG flags.
tcpdump 'tcp[13] & 32!=0'
tcpdump 'tcp[tcpflags] == tcp-urg'

# Isolate TCP ACK flags.
tcpdump 'tcp[13] & 16!=0'
tcpdump 'tcp[tcpflags] == tcp-ack'

# Isolate TCP PSH flags.
tcpdump 'tcp[13] & 8!=0'
tcpdump 'tcp[tcpflags] == tcp-push'

# Isolate TCP FIN flags.
tcpdump 'tcp[13] & 1!=0'
tcpdump 'tcp[tcpflags] == tcp-fin'

# both syn and rst set
tcpdump 'tcp[13] = 6'

# find http user agents
tcpdump -vvAls0 | grep 'User-Agent:'

# cleartext get requests
tcpdump -vvAls0 | grep 'GET'

# find http cookies
tcpdump -vvAls0 | grep 'Set-Cookie|Host:|Cookie:'

# find dns traffic
tcpdump -vvAs0 port 53

# find ftp traffic
tcpdump -vvAs0 port ftp or ftp-data

# find ntp traffic
tcpdump -vvAs0 port 123

# 抓 SMTP 数据
# 抓取数据区开始为"MAIL"的包，"MAIL"的十六进制为 0x4d41494c。
tcpdump -i eth1 '((port 25) and (tcp[(tcp[12]>>2):4] = 0x4d41494c))'

# 抓取所有经过1234端口的UDP网络数据
tcpdump udp port 1234

# 抓 HTTP GET 数据
tcpdump -i eth1 'tcp[(tcp[12]>>2):4] = 0x47455420' # "GET "的十六进制是 47455420
#抓 SSH 返回
tcpdump -i eth1 'tcp[(tcp[12]>>2):4] = 0x5353482D' # "SSH-"的十六进制是 0x5353482D

# 抓老版本的 SSH 返回信息，如"SSH-1.99.."
tcpdump -i eth1 '(tcp[(tcp[12]>>2):4] = 0x5353482D) and (tcp[((tcp[12]>>2)+4):2]= 0x312E)'
# 抓取端口号8000的GET包，然后写入GET.log
tcpdump -i eth0 '((port 8000) and (tcp[(tcp[12]>>2):4]=0x47455420))' -nnAl -w /tmp/GET.log

# 抓 DNS 请求数据
tcpdump -i eth1 udp dst port 53

# 抓取系统中的get,post请求（非https)
tcpdump -s 0 -v -n -l | egrep -i "POST /|GET /|Host:"

tcpdump -i any tcp and host 192.168.33.10 and port 80 -w http.pcap
tcpdump -i eth0 tcp and host 192.168.33.10 and port 80 -w tcp.sys_timeout.pcap
# 捕获特定网口数据包
tcpdump -i eth0
# 捕获特定个数(1000)的包
tcpdump -c 1000 -i eth0
# 将捕获的包保存到文件
tcpdump -w a.pcap -i eth0
# 读取pcap格式的包
tcpdump -r a.pcap
# 增加捕获包的时间戳
tcpdump -n -ttt -i eth0
# 指定捕获包的协议类型
tcpdump -i eth0 arp
# 捕获指定端口
tcpdump -i eth0 post 22
# 捕获特定目标ip+port的包
tcpdump -i eth0 dst address and port 22
# 捕获DNS请求和响应
tcpdump -i eth0 -s0 port 53
# 匹配Http请求头
tcpdump -s 0 -v -n -l | egrep -i "POST /|GET /|Host:"

# find ssh connections This one works regardless of what port the connection comes in on, because it’s getting the banner response.
tcpdump 'tcp[(tcp[12]>>2):4] = 0x5353482D'

# find cleartext passwords
tcpdump port http or port ftp or port smtp or port imap or port pop3 or port telnet -lA | egrep -i -B5 'pass=|pwd=|log=|login=|user=|username=|pw=|passw=|passwd= |password=|pass:|user:|username:|password:|login:|pass |user '

# find traffic with evil bit There’s a bit in the IP header that never gets set by legitimate applications, which we call the “Evil Bit”. Here’s a fun filter to find packets where it’s been toggled.
tcpdump 'ip[6] & 128 != 0'
```
