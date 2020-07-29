## [wireguard](https://www.wireguard.com/)

一个易于配置、快速且安全的开源 VPN，利用了最新的加密技术。目的是提供一种更快、更简单、更精简的通用 VPN，可以轻松地在树莓派这类低端设备到高端服务器上部署

* 由 Jason Donenfeld 等人用 C 语言编写的一个开源 VPN 协议，被视为下一代 VPN 协议，旨在解决许多困扰 IPSec/IKEv2、OpenVPN 或 L2TP 等其他 VPN 协议的问题。它与 Tinc 和 MeshBird 等现代 VPN 产品有一些相似之处，即加密技术先进、配置简单。从 2020 年 1 月开始，它已经并入了 Linux 内核的 5.6 版本
* 运行在内核空间(可以将 WireGuard 作为内核模块安装在 Linux 中)，因此可以高速提供安全的网络。碾压其他 VPN 协议。再来说说 OpenVPN，大约有 10 万行代码，而 WireGuard  只有大概 4000 行代码
* 优点：
	- 配置精简，可直接使用默认值
	- 只需最少的密钥管理工作，每个主机只需要 1 个公钥和 1 个私钥。
	- 就像普通的以太网接口一样，以 Linux 内核模块的形式运行，资源占用小。
	- 能够将部分流量或所有流量通过 VPN 传送到局域网内的任意主机。
	- 能够在网络故障恢复之后自动重连，戳到了其他 VPN 的痛处。
	- 比目前主流的 VPN 协议，连接速度要更快，延迟更低（见上图）。
	- 使用了更先进的加密技术，具有前向加密和抗降级攻击的能力。
	- 支持任何类型的二层网络通信，例如 ARP、DHCP 和 ICMP，而不仅仅是 TCP/HTTP。
	- 可以运行在主机中为容器之间提供通信，也可以运行在容器中为主机之间提供通信
* 不能做的事：
	- 类似 gossip 协议实现网络自愈。
	- 通过信令服务器突破双重 NAT。
	- 通过中央服务器自动分配和撤销密钥。
	- 发送原始的二层以太网帧。


## 安装

```
sudo add-apt-repository ppa:wireguard/wireguard
sudo apt-get update
sudo apt-get install wireguard

sudo -s
wg # for configuring WireGuard interfaces.
wg-quick # for starting and stopping WireGuard VPN tunnels.

mkdir /etc/wireguard/keys
cd /etc/wireguard/keys
umask 077 #  Set the directory user mask to 077 by running umask 077. A umask of 077 allows read, write, and execute permissions for the file’s owner (root in this case), but prohibits read, write, and execute permissions for everyone else and makes sure credentials don’t leak in a race condition
wg genkey | tee privatekey | wg pubkey > publickey

vim /etc/wireguard/wg0.conf
[Interface]
PrivateKey = <server private key>
Address = 10.0.0.1/24
ListenPort = 51820
PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -A FORWARD -o %i -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -D FORWARD -o %i -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE

# EC2 instance → Security groups → Click on security group → Edit inbound rules → Add rules → Custom UDP → Port range: 51820 → Source: Anywhere → Save rules

# If your server is behind a NAT then all traffic needs to be forwarded from the default interface to the WireGuard interface. To find out the name of the default interface run ip route
ip route | grep default | awk '{print $5}'

# Enabling IP forwarding on server
vim /etc/sysctl.conf
net.ipv4.ip_forward=1

sysctl -p # the changes to take effect without requiring a reboot

## client
sudo pacman -S wireguard-tools wireguard-dkms
sudo -s
mkdir /etc/wireguard/keys
cd /etc/wireguard/keys
umask 077
wg genkey | tee privatekey | wg pubkey > publickey

vim /etc/wireguard/wg0.conf
[Interface]
Address = 10.0.0.2/32
PrivateKey = <client private key>
DNS = 1.1.1.1

[Peer]
PublicKey = <server public key>
Endpoint = <server public ip>:51820
AllowedIPs = 0.0.0.0/0
PersistentKeepalive = 25 # If your server is behind a NAT and not accessible via a public IP, then under the peer section you’ll need to set PersistentKeepalive to keep the connection alive

dig +short myip.opendns.com @resolver1.opendns.com # your server’s public address

## server
vim /etc/wireguard/wg0.conf
[Peer]
PublicKey = vi4TCAo8TNRkpf4ZpiMsp3YHaOLrcouSDkrm4wJxezw=
AllowedIPs = 10.0.0.2/32

wg-quick up wg0
systemctl enable wg-quick@wg0.service
systemctl status wg-quick@wg0.service

ptables -L -n

## client
dig +short myip.opendns.com @resolver1.opendns.com # your current public IP address
wg-quick up wg0

## Connecting a mobile client to server Download the WireGuard app for iOS or Android on your device
## wg genkey but specify different filenames this time to distinguish them from the server keys:
wg genkey | tee iphone_privatekey | wg pubkey > iphone_publickey

vim /etc/wireguard/wg0.conf # Add the second peer section and include the client’s public key and IP address
[Peer]
PublicKey = cKIxzfp5ESpdM34vT2Qk/S7yvprOff6Le4YnyOTI4B8=
AllowedIPs = 10.0.0.3/32

vim /etc/wireguard/wg0-iphone.conf

[Peer]
PublicKey = H6StMJOYIjfqhDvG9v46DSX9UlQl52hOoUm7F3COxC4=
Endpoint = 54.225.123.18:51820
AllowedIPs = 0.0.0.0/0
```

## 概念

* Peer/Node/Device: 连接到 VPN 并为自己注册一个 VPN 子网地址（如 192.0.2.3）的主机。还可以通过使用逗号分隔的 CIDR 指定子网范围，为其自身地址以外的 IP 地址选择路由
* 中继服务器（Bounce Server）: 一个公网可达的对等节点，可以将流量中继到 NAT 后面的其他对等节点。Bounce Server 并不是特殊的节点，它和其他对等节点一样，唯一的区别是它有公网 IP，并且开启了内核级别的 IP 转发，可以将 VPN 的流量转发到其他客户端
* 子网（Subnet）: 一组私有 IP，例如 192.0.2.1-255 或 192.168.1.1/24，一般在 NAT 后面，例如办公室局域网或家庭网络
* CIDR 表示法: 这是一种使用掩码表示子网大小的方式
* NAT: 子网的私有 IP 地址由路由器提供，通过公网无法直接访问私有子网设备，需要通过 NAT 做网络地址转换。路由器会跟踪发出的连接，并将响应转发到正确的内部 IP
* 公开端点（Public Endpoint）: 节点的公网 IP 地址：端口，例如 123.124.125.126:1234，或者直接使用域名 some.domain.tld:1234。如果对等节点不在同一子网中，那么节点的公开端点必须使用公网 IP 地址
* 私钥（Private key） 单个节点的 WireGuard 私钥，生成方法是：wg genkey > example.key
* 公钥（Public key） 单个节点的 WireGuard 公钥，生成方式为：wg pubkey < example.key > example.key.pub

## 原理

* 中继服务器工作原理
	- 中继服务器（Bounce Server）和普通的对等节点一样，能够在 NAT 后面的 VPN 客户端之间充当中继服务器，可以将收到的任何 VPN 子网流量转发到正确的对等节点。事实上 WireGuard 并不关心流量是如何转发的，这个由系统内核和 iptables 规则处理。如果所有的对等节点都是公网可达的，则不需要考虑中继服务器，只有当有对等节点位于 NAT 后面时才需要考虑。
	- 客户端和服务端基本是平等的，差别只是谁主动连接谁而已。双方都会监听一个 UDP 端口，谁主动连接，谁就是客户端。主动连接的客户端需要指定对端的公网地址和端口，被动连接的服务端不需要指定其他对等节点的地址和端口。如果客户端和服务端都位于 NAT 后面，需要加一个中继服务器，客户端和服务端都指定中继服务器作为对等节点，它们的通信流量会先进入中继服务器，然后再转发到对端。
	- WireGuard 是支持漫游的，也就是说，双方不管谁的地址变动了，WireGuard 在看到对方从新地址说话的时候，就会记住它的新地址（跟  mosh 一样，不过是双向的）。所以双方要是一直保持在线，并且通信足够频繁的话（比如配置 persistent-keepalive），两边的 IP 都不固定也不影响的
* 如何路由流量:典型的拓扑
	-  端到端直接连接： 这是最简单的拓扑，所有的节点要么在同一个局域网，要么直接通过公网访问，这样 WireGuard 可以直接连接到对端，不需要中继跳转。
	-  一端位于 NAT 后面，另一端直接通过公网暴露： 最简单的方案是：通过公网暴露的一端作为服务端，另一端指定服务端的公网地址和端口，然后通过 persistent-keepalive 选项维持长连接，让 NAT 记得对应的映射关系。
	-  两端都位于 NAT 后面，通过中继服务器连接： 大多数情况下，当通信双方都在 NAT 后面的时候，NAT 会做源端口随机化处理，直接连接可能比较困难。可以加一个中继服务器，通信双方都将中继服务器作为对端，然后维持长连接，流量就会通过中继服务器进行转发。
	-  两端都位于 NAT 后面，通过 UDP NAT 打洞：直接连接不太现实，因为大多数 NAT 路由器对源端口的随机化相当严格，不可能提前为双方协调一个固定开放的端口。必须使用一个信令服务器（STUN），它会在中间沟通分配给对方哪些随机源端口。通信双方都会和公共信令服务器进行初始连接，然后它记录下随机的源端口，并将其返回给客户端。这其实就是现代 P2P 网络中 WebRTC 的工作原理。有时候，即使有了信令服务器和两端已知的源端口，也无法直接连接，因为 NAT 路由器严格规定只接受来自原始目的地址（信令服务器）的流量，会要求新开一个随机源端口来接受来自其他 IP 的流量（比如其他客户端试图使用原来的通信源端口）。运营商级别的 NAT 就是这么干的，比如蜂窝网络和一些企业网络，它们专门用这种方法来防止打洞连接
	-  如果某一端同时连接了多个对端，当它想访问某个 IP 时，如果有具体的路由可用，则优先使用具体的路由，否则就会将流量转发到中继服务器，然后中继服务器再根据系统路由表进行转发。你可以通过测量 ping 的时间来计算每一跳的长度，并通过检查对端的输出（wg show wg0）来找到 WireGuard 对一个给定地址的路由方式
* 报文格式：使用加密的 UDP 报文来封装所有的数据，UDP 不保证数据包一定能送达，也不保证按顺序到达，但隧道内的 TCP 连接可以保证数据有效交付

## 性能

* WireGuard 直接在内核层面处理路由，直接使用系统内核的加密模块来加密数据，和 Linux 原本内置的密码子系统共存，原有的子系统能通过 API 使用 WireGuard 的 Zinc 密码库。
* WireGuard 使用 UDP 协议传输数据，在不使用的情况下默认不会传输任何 UDP 数据包，所以比常规 VPN 省电很多，可以像 55 一样一直挂着使用，速度相比其他 VPN 也是压倒性优势

## 安全模型

* 加密技术：
	- 使用 ChaCha20 进行对称加密，使用 Poly1305 进行数据验证。
	- 利用 Curve25519 进行密钥交换。
	- 使用 BLAKE2 作为哈希函数。
	- 使用 HKDF 进行解密。
* 本质上是 Trevor Perrin 的 Noise 框架的实例化，它简单高效，其他的 VPN 都是通过一系列协商、握手和复杂的状态机来保障安全性。WireGuard 就相当于 VPN 协议中的 qmail，代码量比其他 VPN 协议少了好几个数量级

## 密钥管理

* 通过为每个对等节点提供简单的公钥和私钥来实现双向认证，每个对等节点在设置阶段生成密钥，且只在对等节点之间共享密钥。每个节点除了公钥和私钥，不再需要其他证书或预共享密钥
* 在更大规模的部署中，可以使用 Ansible 或 Kubernetes Secrets 等单独的服务来处理密钥的生成、分发和销毁

## 参考

* [部署](https://www.linode.com/docs/networking/vpn/set-up-wireguard-vpn-on-ubuntu/) <https://teddysun.com/554.html>
* [Getting Started with WireGuard](https://miguelmota.com/blog/getting-started-with-wireguard/)
* [WireGuard 的工作原理](https://fuckcloudnative.io/posts/wireguard-docs-theory/)
