# PVN （Virtual Private Network）

虚拟专用网络

## shadowsocks

[wiki](https://github.com/shadowsocks/shadowsocks/wiki)

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
```

### 配置

```json
{
    "server":"my_server_ip",  //服务器监听ip the address your server listens
    "server_port":8388,  // 对外服务端口 server port
    "local_address": "127.0.0.1",  // 本地ip the address your local listens
    "local_port":1080,   // local port
    "password":"mypassword",
    "timeout":300,
    "method":"aes-256-cfb",
    "fast_open": false
}
```

## V2ray

通过nginx的负载均衡功能，来自web访问的流量就直接访问到网站，而通过v2ray来的流量就通过v2ray的服务端转发，实现KX代理的功能

## OpenVPN

### Ubunutu

```shell
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
```

#### 服务端配置

OpenVPN提供了两种认证方法：

* 基于用户名/密码的认证与SSL证书认证。用户名/密码的认证方法无法（或较难）限制一个账号同时连接多个客户端，
* 采用证书，则可保证同一证书同一时间只能有一个客户端连接。

提供客户端配置文件 client.ovpn

```sh
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

## [wireguard](https://www.wireguard.com/)

一个易于配置、快速且安全的开源 VPN，利用了最新的加密技术。目的是提供一种更快、更简单、更精简的通用 VPN，可以轻松地在树莓派这类低端设备到高端服务器上部署

* 跨平台
* 易于[部署](https://www.linode.com/docs/networking/vpn/set-up-wireguard-vpn-on-ubuntu/) <https://teddysun.com/554.html>
* 运行在内核空间(可以将 WireGuard 作为内核模块安装在 Linux 中)，因此可以高速提供安全的网络

### 服务

* [StreisandEffect/streisand](https://github.com/StreisandEffect/streisand):Streisand sets up a new server running L2TP/IPsec, OpenConnect, OpenSSH, OpenVPN, Shadowsocks, sslh, Stunnel, a Tor bridge, and WireGuard. It also generates custom instructions for all of these services. At the end of the run you are given an HTML file with instructions that can be shared with friends, family members, and fellow activists.
* [Nyr/openvpn-install](https://github.com/Nyr/openvpn-install):OpenVPN road warrior installer for Debian, Ubuntu and CentOS
* [trailofbits/algo](https://github.com/trailofbits/algo):Set up a personal IPSEC VPN in the cloud

## 工具

* [Lantern](https://github.com/getlantern/lantern)
* [firefly-proxy](https://github.com/yinghuocho/firefly-proxy):A proxy software to help circumventing the Great Firewall.
* [XX-net/XX-Net](https://github.com/XX-net/XX-Net)a web proxy tool
* [googlehosts/hosts](https://github.com/googlehosts/hosts)
* [v2ray/v2ray-core](https://github.com/v2ray/v2ray-core):A platform for building proxies to bypass network restrictions. <https://www.v2ray.com/>
    - [yanue/V2rayU](https://github.com/yanue/V2rayU):V2rayU,基于v2ray核心的mac版客户端,用于科学上网,使用swift编写,支持vmess,shadowsocks,socks5等服务协议,支持订阅, 支持二维码,剪贴板导入,手动配置,二维码分享等 https://github.com/yanue/V2rayU
    - [jiangxufeng/v2rayL](https://github.com/jiangxufeng/v2rayL):v2ray linux GUI客户端，支持订阅、vemss、ss等协议，自动更新订阅、检查版本更新
* [felixonmars/dnsmasq-china-list](https://github.com/felixonmars/dnsmasq-china-list):Chinese-specific configuration to improve your favorite DNS server. Best partner for chnroutes.
* [iMeiji/shadowsocks_install](https://github.com/iMeiji/shadowsocks_install)
* [trojan-gfw](https://github.com/trojan-gfw/trojan):An unidentifiable mechanism that helps you bypass GFW. https://trojan-gfw.github.io/trojan/
* Perfect Privacy
* ExpressVPN
* NordVPN
* 私人互联网接入
* PureVPN
* 完美隐私
- [txthinking/brook](https://github.com/txthinking/brook):Brook is a cross-platform(Linux/MacOS/Windows/Android/iOS) proxy/vpn software
* [Alvin9999/new-pac](https://github.com/Alvin9999/new-pac)
* BT sync
* [ShadowsocksR-Live/shadowsocksr-native](https://github.com/ShadowsocksR-Live/shadowsocksr-native):从容翻越党国敏感日 ShadowsocksR (SSR) native implementation for all platforms powered by libuv, GFW terminator
* 客户端
  - freevpn
  - [Potatso lite](https://itunes.apple.com/us/app/potatso-lite/id1239860606)
  - [erguotou520/electron-ssr](https://github.com/erguotou520/electron-ssr)
  - [teddysun/shadowsocks_install](https://github.com/teddysun/shadowsocks_install):Auto Install Shadowsocks Server for CentOS/Debian/Ubuntu https://shadowsocks.be
  - [Qv2ray / Qv2ray](https://github.com/Qv2ray/Qv2ray):🌟 V2Ray/Trojan-GFW/SSR Linux/Windows/macOS 跨平台 GUI 🔨 使用 C++17/Qt5 ，支持订阅，扫描二维码，自定义路由编辑 🌟 https://qv2ray.github.io
  - [mellow-io / mellow](https://github.com/mellow-io/mellow):Mellow is a rule-based global transparent proxy client for Windows, macOS and Linux.
* [Dreamacro / clash](https://github.com/Dreamacro/clash):A rule-based tunnel in Go.
  - `go get -u -v github.com/Dreamacro/clash`

## 参考

* [Shadowsocks (简体中文)](https://wiki.archlinux.org/index.php/Shadowsocks_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))
* [openvpn](https://help.ubuntu.com/lts/serverguide/openvpn.html)
* [gfwlist/gfwlist](https://github.com/gfwlist/gfwlist):The one and only one gfwlist here
* [How To Set Up an OpenVPN Server on Ubuntu 16.04](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-ubuntu-16-04)
* [max2max/freess](https://github.com/max2max/freess)
* [haoel/haoel.github.io](https://github.com/haoel/haoel.github.io)
* [JadaGates/ShadowsocksBio](https://github.com/JadaGates/ShadowsocksBio):SS的前世今生
* [yangchuansheng / love-gfw](https://github.com/yangchuansheng/love-gfw):🔥以社会主义核心价值观为指导思想，实现 Linux 和 MacOS 设备的全局智能分流 https://fuckcloudnative.io/posts/linux-circumvent/
