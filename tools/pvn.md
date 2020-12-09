# PVN Virtual Private Network 虚拟专用网络

## 概念

* 中继/中转/落地：两个或多个服务器之间通过端口进行流量转发
* IPLC 中继/中转：IPLC（点对点的内网专线），一台服务器在国外一台服务器在国内，所有的数据都是通过这两台服务器内网传输的
  - 优势不过GFW（所以不会存在被封的情况），因为是内网，防火墙检测不到，所以在国内访问的就是国内的服务器，然后国内的服务器走内网传输到国外的服务器帮我们上网，所以其就是就是快，稳定，不会受高峰期影响
  - 成本高，基本上是按照流量去卖的，所以这种是限制用户流量的
* BGP 中继/中转：国内一台服务器，国外一台服务器，但是与IPLC不同的是走的是公网。使用了BGP一后对线路的优化是特别明显的，但给线路增加BGP服务器是花钱的，这也就增加了成本，所以一般不会给香港这么近的节点增加BGP服务器
* BGP 协议/技术：通过BGP可以实现一个IP对应电信、联通、移动、长城、教育网等不同线路的带宽，而不需要服务器端配置多个IP
  - BGP（边界网关协议）主要用于互联网AS（自治系统）之间的互联，BGP最主要的功能在于控制路由的传播和选择最好的路由。
  - 中国网通、中国电信、中国铁通和一些大的民营IDC运营商都具有AS号，全国各大网络运营商多数都是通过BGP协议与自身的AS号来实现多线互联的
  - 使用此方案来实现多线路互联，IDC需要在CNNIC（中国互联网信息中心）或APNIC（亚太网络信息中心）申请自己的IP地址段和AS号，然后通过BGP协议将此段IP地址广播到其它网络运营商的网络中。使用BGP协议互联后，网络运营商的所有骨干路由设备将会判断到IDC机房IP段的最佳路由，以保证不同网络运营商用户的高速访问。所以说BGP是目前全球最好的双线技术
  - BGP 线路
    + 消除南北访问障碍。由于BGP可以将联通、电信、移动等运营商的线路“合并”，使得中国南北无障碍通讯成为可能。对接入层来说，可使“联通、电信”这类区别消失，更能使一个网站资源无限制的在全国范围内无障碍访问，而不需要在异地部署VPN或者异地加速站来实现异地无障碍访问
    + 高速互联互通:原来一条线路访问另一线路往往要经过很多层路由，但实现BGP以后就像进入了高速公路,带宽的利用率由40%左右达到80%以上
  - 用于BGP路由中的每个自治系统都被分配一个唯一的自治系统编号（ASN），通常以AS开头。对BGP来说，因为ASN是区别整个相互连接的网络中的各个网络的唯一标识，所以这个自治系统编号非常重要。 互联网地址分派机构将64512到65535的ASN编号保留给（私有）专用网络使用
* CN2 GIA 全称 China telecom Next Carrier Network- Global Internet Access 电信国际精品网络
* NCP New Cross Pacific（新跨太平洋海底光缆系统）。2018年11月底，中国到美国之间的海底光缆新开通了NCP线路，并且容量更大（系统设计容量超过80Tbps），路由更少（中国上海到美国中间路由节点只有11个，ping值110ms）。全长13,000公里，连接美国俄勒冈州希尔斯伯勒，连接崇明（中国大陆），南汇（中国大陆），临港（中国大陆），釜山（韩国），头城（台湾），和丸山（日本）
  - 相对于第二条中美直达海底光缆系统（跨太平洋快线，TPE），现阶段NCP线路的网络流量更少更稳定。特征是华东/中地区流量会经过NCP直达路由节点，IP地址为202.97.95.201/202
* 用VPN，SS，SSR，都有可能被识别，只有使用 HTTP over TLS 的样子，才会跟正常的流量混在一起，很难被识别，所以，目前来说，V2Ray客户端 + Nginx + V2Ray服务端的方式，或是gost的HTTPS的方式，基本上来说，在网络四层上看到的都是TLS的包，很难被识别。这种代理服务觉得只能做探测，或是得到更多的算力来做统计学分析。所以，V2Ray 和 gost 的服务器端用 nginx 再挡一道，那么就很难被发现了
* 分流规则（或出站模式）:即配置哪些网站走
  - 代理模式（Proxy）国外网站（例如Twitter/YouTube/Pornhub/..）与打不开（被墙）网站
  - 直连模式Direct: 国内网站
  - 拒绝访问（Reject）

## [Shadowsocks](https://wiki.archlinux.org/index.php/Shadowsocks)

* 轻量级 SOCKS5 代理
* [wiki](https://github.com/shadowsocks/shadowsocks/wiki)
* [](https://github.com/ToyoDAdoubiBackup/doubi)
* [](https://github.com/shadowsocks/go-shadowsocks2)
* [iMeiji/shadowsocks_install](https://github.com/iMeiji/shadowsocks_install)
* [teddysun/shadowsocks_install](https://github.com/teddysun/shadowsocks_install):Auto Install Shadowsocks Server for CentOS/Debian/Ubuntu <https://shadowsocks.be>

```shell
apt-get install python-pip
wget https://bootstrap.pypa.io/ez_setup.py -O - | python

ssserver -p 443 -k password -m rc4-md5
sudo ssserver -p 443 -k password -m rc4-md5 --user nobody -d start // 后台运行
sudo ssserver -d stop // 停止
sudo less /var/log/shadowsocks.log // 日志

ssserver -c /etc/shadowsocks.json
ssserver -c /etc/shadowsocks.json -d start
ssserver -c /etc/shadowsocks.json -d stop

brew cask install shadowsocksx

# https://raw.githubusercontent.com/ToyoDAdoubi/doubi/master/ssrmu.sh
wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks.sh
chmod +x shadowsocks.sh
./shadowsocks.sh 2>&1 | tee shadowsocks.log

/bin/python /usr/local/bin/ssserver -c /etc/shadowsocks.json -d start
### 配置
{
    "server":"my_server_ip",  # 服务器监听ip the address your server listens
    "server_port":8388,  #  对外服务端口 server port
    "local_address": "127.0.0.1",  #  本地ip the address your local listens
    "local_port":1080,   #  local port
    "password":"mypassword",
    "timeout":300,
    "method":"aes-256-cfb",
    "fast_open": false
}
```

## [v2ray-core](https://github.com/v2ray/v2ray-core)

A platform for building proxies to bypass network restrictions. <https://www.v2ray.com/> 通过nginx的负载均衡功能，来自web访问的流量就直接访问到网站，而通过v2ray来的流量就通过v2ray的服务端转发，实现KX代理的功能

* 服务器端
  - usr/bin/v2ray/v2ray：V2Ray 程序；
  - /usr/bin/v2ray/v2ctl：V2Ray 工具；
  - /etc/v2ray/config.json：配置文件；
  - /usr/bin/v2ray/geoip.dat：IP 数据文件
  - /usr/bin/v2ray/geosite.dat：域名数据文件 此脚本会配置自动运行脚本。自动运行脚本会在系统重启之后，自动运行 V2Ray。目前自动运行脚本只支持带有 Systemd 的系统，以及 Debian / Ubuntu 全系列
  - 运行脚本位置
    + /etc/systemd/system/v2ray.service: Systemd
    + /etc/init.d/v2ray: SysV
* [v2rayL](https://github.com/jiangxufeng/v2rayL):v2ray linux GUI客户端，支持订阅、vemss、ss等协议，自动更新订阅、检查版本更新

```sh
# 安装v2ray
bash <(curl -L -s https://install.direct/go.sh) # 直接使用脚本
service v2ray start # 启动
vim /etc/v2ray/config.json # 修改配置文件
```

## [brook](https://github.com/txthinking/brook)

Brook is a cross-platform(Linux/MacOS/Windows/Android/iOS) proxy/vpn software

## [openvpn](https://help.ubuntu.com/lts/serverguide/openvpn.html)

* 服务端配置,提供两种认证方法：
  * 基于用户名/密码的认证与SSL证书认证。用户名/密码的认证方法无法（或较难）限制一个账号同时连接多个客户端
  * 采用证书，则可保证同一证书同一时间只能有一个客户端连接
* [How To Set Up an OpenVPN Server on Ubuntu 16.04](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-ubuntu-16-04)
* [Nyr/openvpn-install](https://github.com/Nyr/openvpn-install):OpenVPN road warrior installer for Debian, Ubuntu and CentOS

```sh
### Ubunutu
sudo apt install openvpn easy-rsa # 服务端
make-cadir ~/openvpn-ca

mkdir /etc/openvpn/easy-rsa/
cp -r /usr/share/easy-rsa/* /etc/openvpn/easy-rsa/

export KEY_COUNTRY="US" # 编辑/etc/openvpn/easy-rsa/vars调整到适合您的环境
export KEY_PROVINCE="NC"
export KEY_CITY="Winston-Salem"
export KEY_ORG="Example Company"
export KEY_EMAIL="steve@example.com"
export KEY_CN=MyVPN
export KEY_NAME=MyVPN
export KEY_OU=MyVPN

cd /etc/openvpn/easy-rsa/
./clean-all
./build-ca # generate the master Certificate Authority (CA) certificate and key

./build-key-server myservername # 为服务器生成一个证书和私钥
cd keys/
cp myservername.crt myservername.key ca.crt dh2048.pem /etc/openvpn/ # copy them to /etc/openvpn

cd /etc/openvpn/easy-rsa/ # 创建客户端证书
./build-key client1

/etc/openvpn/ca.crt
/etc/openvpn/easy-rsa/keys/client1.crt
/etc/openvpn/easy-rsa/keys/client1.key  # 客户端文件

sudo cp /usr/share/doc/openvpn/examples/sample-config-files/server.conf.gz /etc/openvpn/
sudo gzip -d /etc/openvpn/server.conf.gz

ca ca.crt   # Edit /etc/openvpn/server.conf to make sure the following lines are pointing to the certificates and keys you created in the section above.
cert myservername.crt
key myservername.key
dh dh2048.pem
net.ipv4.ip_forward=1

sudo sysctl -p /etc/sysctl.conf

sudo systemctl start openvpn@server
sudo systemctl status openvpn@server

ifconfig tun0

apt-get install openvpn # 客户端

# 客户端默认配置文件放置服务端配置文件
sudo cp /usr/share/doc/openvpn/examples/sample-config-files/client.conf /etc/openvpn/

openvpn /etc/openvpn/client.ovpn # 连接
openvpn /etc/openvpn/client.ovpn > /dev/null & # 如果希望开机即自动连接OpenVPN，或者是VPN常年在线，可以加入到/etc/rc.local

client
dev tap
proto tcp-client
remote vpnserver.example.com 1194
resolv-retry infinite
nobind
mute-replay-warnings
redirect-gateway

ca /etc/openvpn/ca.crt
cert /etc/openvpn/client.crt
key /etc/openvpn/client.key

comp-lzo
verb 4

sudo systemctl start openvpn@client
sudo systemctl status  openvpn@client
```

## Client

```sh
sudo add-apt-repository ppa:hzwhuang/ss-qt5
sudo apt-get update
sudo apt-get install shadowsocks-qt5

# Ubuntu
apt-get install python-pip
pip install shadowsocks
```

## [trojan](https://github.com/trojan-gfw/trojan)

An unidentifiable mechanism that helps you bypass GFW. <https://trojan-gfw.github.io/trojan/>

* 模仿了互联网上最常见的HTTPS协议，以诱骗GFW认为它就是HTTPS，从而不被识别
* 需要一个域名用来做伪装 [freenom](linhttps://www.freenom.comk)

```sh
sudo useradd -m -s /bin/bash trojanuser
sudo passwd trojanuser
sudo usermod -G sudo trojanuser
su -l trojanuser

sudo groupadd certusers
sudo useradd -r -M -G certusers trojan
sudo useradd -r -m -G certusers acme

sudo su -l -s /bin/bash acme
curl  https://get.acme.sh | sh
exit
sudo su -l -s /bin/bash acme

export CF_Key="<Your Global API Key>"
export CF_Email="<Your cloudflare account Email>"

acme.sh --issue --dns dns_cf -d <tdom.ml>
acme.sh --install-cert -d <tdom.ml> --key-file /usr/local/etc/certfiles/private.key --fullchain-file /usr/local/etc/certfiles/certificate.crt
acme.sh  --upgrade  --auto-upgrade

chown -R acme:certusers /usr/local/etc/certfiles
chmod -R 750 /usr/local/etc/certfiles
exit

sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/trojan-gfw/trojan-quickstart/master/trojan-quickstart.sh)"
sudo chown -R trojan:trojan /usr/local/etc/trojan
sudo cp /usr/local/etc/trojan/config.json /usr/local/etc/trojan/config.json.bak
sudo nano /usr/local/etc/trojan/config.json
password
cert
key

# 配置Nginx
# CentOS反向代理需要配置SELinux允许httpd模块可以联网，否则服务器会返回502错误
sudo setsebool -P httpd_can_network_connect true

# 接收来自Trojan的流量，与上面Trojan配置文件对应
server {
    listen 127.0.0.1:80 default_server;

    server_name <tdom.ml>;

    location / {
        proxy_pass https://www.ietf.org;
    }

}
# 接收来自Trojan的流量，但是这个流量尝试使用IP而不是域名访问服务器，所以将其认为是异常流量，并重定向到域名
server {
    listen 127.0.0.1:80;

    server_name <10.10.10.10>;

    return 301 https://<tdom.ml>$request_uri;
}
# 接收除127.0.0.1:80外的所有80端口的流量并重定向到443端口，这样便开启了全站https，可有效的防止恶意探测
server {
    listen 0.0.0.0:80;
    listen [::]:80;

    server_name _;

    return 301 https://$host$request_uri;
}

cd /usr/src && wget https://github.com/trojan-gfw/trojan/releases/download/v1.15.1/trojan-1.15.1-linux-amd64.tar.xz
tar xvf trojan-1.15.1-linux-amd64.tar.xz

# 配置

# trojan service
cat > /etc/systemd/system/trojan.service <<-EOF
[Unit]
Description=trojan
After=network.target

[Service]
Type=simple
PIDFile=/usr/src/trojan/trojan.pid
ExecStart=/usr/src/trojan/trojan -c "/usr/src/trojan/config.json"
ExecReload=/bin/kill -HUP \$MAINPID
Restart=on-failure
RestartSec=1s

[Install]
WantedBy=multi-user.target

EOF

systemctl start|enable trojan

# 开启转发
echo net.ipv4.ip_forward=1 >> /etc/sysctl.conf
sysctl -p

# 配置本地地址不被代理
# iptables -t nat -N trojan
iptables -t nat -A trojan -d 0.0.0.0/8 -j RETURN
iptables -t nat -A trojan -d 10.0.0.0/8 -j RETURN
iptables -t nat -A trojan -d 127.0.0.0/8 -j RETURN
iptables -t nat -A trojan -d 169.254.0.0/16 -j RETURN
iptables -t nat -A trojan -d 172.16.0.0/12 -j RETURN
iptables -t nat -A trojan -d 192.168.0.0/16 -j RETURN
iptables -t nat -A trojan -d 224.0.0.0/4 -j RETURN
iptables -t nat -A trojan -d 240.0.0.0/4 -j RETURN

# 配置tcp和udp流量转发到trojan客户端
iptables -t nat -A trojan -p tcp -j REDIRECT --to-ports 1080
iptables -t nat -A trojan -p udp -j REDIRECT --to-ports 1080
# 配置tcp和udp使用trojan chain规则
iptables -t nat -A OUTPUT -p tcp -j trojan
iptables -t nat -A OUTPUT -p udp -j trojan

iptables-save > /etc/iptables-rules
iptables-restore < /etc/iptables-rules # 手动加载
```

## [clash](https://github.com/Dreamacro/clash):A rule-based tunnel in Go

* `go get -u -v github.com/Dreamacro/clash`
* 配置:｀/home/当前用户ID/.config/clash/config.yml`
* 访问：<http://clash.razord.top/#/settings>` 端口和口令按yml文件中的external-controller内容输入即可

```sh
mv clash-linux-amd64-vx.xx.x clash
chmod +x clash
Country.mmdb # https://github.com/Dreamacro/maxmind-geoip
config.yaml
icon https://raw.githubusercontent.com/Dreamacro/clash/master/docs/logo.png
# /usr/local/clash/

# clash_startup.sh
#!/bin/bash
CLASH_APP_NAME="clash"
CLASH_APP_PATH="/usr/local/clash"
CLASH_CONFIG_PATH="/usr/local/clash"
CLASH_LOG_PATH="/usr/local/clash/log"
LOG_DATE=$(date +'%Y%m%d')
CHECK_CLASH_PID=$(ps aux | grep "./$CLASH_APP_NAME -d $CLASH_CONFIG_PATH" | grep -v grep | awk '{print $2}')

mkdir -p $CLASH_LOG_PATH

LOG_NUM=$(ls -lR $CLASH_LOG_PATH | wc -l)
LOG_NUM_MAX=15

if [ -n "$CHECK_CLASH_PID" ]; then
    for clash_pid in $CHECK_CLASH_PID; do
        kill -9 $clash_pid
    done
fi

cd $CLASH_APP_PATH && nohup ./$CLASH_APP_NAME -d $CLASH_CONFIG_PATH 2>&1 >>$CLASH_LOG_PATH/$CLASH_APP_NAME-$LOG_DATE.log &

if [ $LOG_NUM -gt $LOG_NUM_MAX ]; then
    for i in $(seq 1 $(($LOG_NUM-$LOG_NUM_MAX))); do
        log_old=$(ls $CLASH_LOG_PATH | sort -n | head -1)
        rm -f $CLASH_LOG_PATH/$log_old
    done
fi

chmod +x clash_startup.sh

# /usr/share/applications/clash.desktop
[Desktop Entry]
Version=1.0
Name=Clash
GenericName=Clash
Comment=A rule-based tunnel in Go
Exec=/usr/local/clash/clash_startup.sh
Terminal=false
Icon=/usr/local/clash/logo.png
Type=Application
Categories=Network

# 系统设置 -> 网络 -> 网络代理 -> 手动 ，设置为如下值
HTTP 代理 127.0.0.1 7890
HTTPS 代理 127.0.0.1 7890
Socks 主机 127.0.0.1 7891
```

## [WireGuard](../network/WireGuard.md)

## 服务

* [streisand](https://github.com/StreisandEffect/streisand):Streisand sets up a new server running L2TP/IPsec, OpenConnect, OpenSSH, OpenVPN, Shadowsocks, sslh, Stunnel, a Tor bridge, and WireGuard. It also generates custom instructions for all of these services. At the end of the run you are given an HTML file with instructions that can be shared with friends, family members, and fellow activists.
* [trailofbits/algo](https://github.com/trailofbits/algo):Set up a personal IPSEC VPN in the cloud
* 三方
  - blinkload
  - 快连

## 工具

* [Lantern](https://github.com/getlantern/lantern)
* [firefly-proxy](https://github.com/yinghuocho/firefly-proxy):A proxy software to help circumventing the Great Firewall.
* [XX-Net](https://github.com/XX-net/XX-Net):A proxy tool to bypass GFW.
  - [中文文档](https://github.com/XX-net/XX-Net/wiki/%E4%B8%AD%E6%96%87%E6%96%87%E6%A1%A3)
* [googlehosts](https://github.com/googlehosts/hosts) <https://scaffrey.coding.net/p/hosts/git> / <https://git.qvq.network/googlehosts/hosts>
* [new-pac](https://github.com/Alvin9999/new-pac)
* BT sync
* [shadowsocksr-native](https://github.com/ShadowsocksR-Live/shadowsocksr-native):从容翻越党国敏感日 ShadowsocksR (SSR) native implementation for all platforms powered by libuv, GFW terminator
* [Diode](https://support.diode.io/article/ss32engxlq)以将本机（localhost）的网站公开到互联网上，提供一个二级域名，使得外部用户可以访问

## 客户端

* [electron-ssr](https://github.com/erguotou520/electron-ssr)
* [Qv2ray](https://github.com/Qv2ray/Qv2ray):🌟 V2Ray/Trojan-GFW/SSR Linux/Windows/macOS 跨平台 GUI 🔨 使用 C++17/Qt5 ，支持订阅，扫描二维码，自定义路由编辑 🌟 <https://qv2ray.github.io>
  - `snap install qv2ray`
* [mellow](https://github.com/mellow-io/mellow):Mellow is a rule-based global transparent proxy client for Windows, macOS and Linux.
* [Surge](https://www.nssurge.com/) <https://www.newlearner.site/2018/08/29/surge-for-mac.html>
* V2rayNG
* [V2rayU](https://github.com/yanue/V2rayU) 基于v2ray核心的mac版客户端,用于科学上网,使用swift编写,支持vmess,shadowsocks,socks5等服务协议,支持订阅,支持二维码,剪贴板导入,手动配置,二维码分享等 <https://github.com/yanue/V2rayU>
* [Trojan-Qt5](https://github.com/TheWanderingCoel/Trojan-Qt5)
* app
  - shadowrocket
  - [Potatso lite](https://itunes.apple.com/us/app/potatso-lite/id1239860606)
  - Quantumult
    + 分流
      * `https://raw.githubusercontent.com/limbopro/Profiles/master/Quantumult/Pro.conf`
      * 链接阻止 `https://raw.githubusercontent.com/limbopro/Profiles/master/Quantumult/Rejection.conf`
      * `HOST-SUFFIX,apoll.m.taobao.com,REJECT` 这是一条分流规则示例：即包含关键字为apoll.m.taobao.com的域名均拒绝；分流规则是要配合策略使用的；可以指定任意网站如apoll.m.taobao.com是走直连（Ddirect）还是走代理（Proxy）或者干脆拒绝（Reject）连接网络
    + 匹配规则
      * HOST （完整域名匹配，举例limbopro.xyz）
      * HOST-SUFFIX（域名后缀匹配）
      * HOST-KEYWORD（域名关键字匹配，举例limboppro）
      * USER-AGENT（浏览器用户代理匹配，举例*abc?）
      * IP-CIDR（无类别域间路由例如192.168.xx）
      * GEOIP（GeoIP数据库IP匹配，参数填US，则为美国 ip 数据库匹配，所有美国IP匹配该规则则执行）

## [科学网上](https://github.com/haoel/haoel.github.io)

* CN2 GIA + 香港机房
* [gost](https://github.com/ginuerzh/gost):GO Simple Tunnel - a simple tunnel written in golang
  - 可以设置成 HTTPS 代理，然后把你的服务伪装成一个Web服务器，比其它的流量伪装更好，也更隐蔽。这也是这里强烈推荐的一个方式
  - [wiki](https://docs.ginuerzh.xyz/gost/)

```sh
gost -L=:8080 -F=quic://192.168.1.1:8081 -F=socks5+wss://192.168.1.2:8082 -F=http2://192.168.1.3:8083

curl -v "https://www.google.com" --proxy "https://arsenal.bluebird89.online:19007" --proxy-user 'bluebird89:2007006018aC&'
```

## 参考

* [love-gfw](https://github.com/yangchuansheng/love-gfw):🔥以社会主义核心价值观为指导思想，实现 Linux 和 MacOS 设备的全局智能分流 <https://fuckcloudnative.io/posts/linux-circumvent/>
* [gfwlist](https://github.com/gfwlist/gfwlist):The one and only one gfwlist here
* [trojan-gfw](https://github.com/trojan-gfw/trojan):An unidentifiable mechanism that helps you bypass GFW. <https://trojan-gfw.github.io/trojan/>
* [](https://github.com/freefq/free)
* [freess](https://github.com/max2max/freess)
* [ShadowsocksBio](https://github.com/JadaGates/ShadowsocksBio):SS的前世今生
* [w3-goto-world](https://github.com/hoochanlon/w3-goto-world):tomatoGit/AWS/Google 镜像 ,SS/SSR/VMESS节点,WireGuard,IPFS,DeepWeb,Capitalism 知识储备库
* [Linux全局智能分流方案](https://fuckcloudnative.io/posts/linux-circumvent/)
* [](https://git.zx2c4.com/)
