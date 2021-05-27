# [Inter Planetary File System IPFS](https://github.com/ipfs/ipfs)

Peer-to-peer hypermedia protocol <https://ipfs.io>

* 一个面向全球的、点对点的分布式版本文件系统，目标是为了补充（甚至是取代）目前统治互联网的超文本传输协议（HTTP），将所有具有相同文件系统的计算设备连接在一起
* 原理用基于内容的地址替代基于域名的地址，也就是用户寻找的不是某个地址而是储存在某个地方的内容，不需要验证发送者的身份，而只需要验证内容的哈希，通过这样可以让网页的速度更快、更安全、更健壮、更持久。

## p2p 网络

* 和 client/server 网络区别：
    - p2p 网络的每一个节点既是客户端，又是服务器
    - p2p 网络的每个节点，都（潜在）是数据的发起者和存储者（对比：c/s 网络中，server 拥有数据）
    - p2p 网络很不稳定，节点可能进进出出（对比：c/s 网络，服务器非常稳定，一般 SLA 都有几个9）
    - p2p 网络需要某种机制来实现节点的发现和查找（对比：c/s 网络，客户端知道服务器在哪，如何访问）
    - p2p 网络（往往）需要 NAT traversal / Hole punching 等技术来允许两个节点之间通讯。这是因为很多节点（比如说家庭网络）往往藏在运营商的 NAT 服务器之后。
    - p2p 网络需要投入额外的精力来保证公平(反吸血)
    - p2p 网络需要更好的安全和验证机制。这是因为节点是对等的，保证数据的安全性比 c/s 网络难度更大。

## [libp2p](https://crates.io/crates/libp2p)

* 主要被用来构建狭义的区块链项目，比如 substrate，filecoin 等，还可以有更广阔的天地，比如在社交软件，工具软件，通讯软件，甚至电子商务等领域找到自己的位置
* 包含一系列协议的实现，这些协议共同作用，完成：
    - p2p 网络传输层：支持几乎所有的主流传输协议，甚至允许不同节点间使用不同的传输层，比如 native 节点间优先使用 QUIC，而 native 和 web 节点间使用 websocket。
    - 节点发现（黄色，注意这里 PKI 是指基于 PKI 的节点身份）：一般本地网络可以使用 mDNS，大规模 p2p 网络一般使用 bootstrap 来连接初始节点，然后通过 gossip 获取更多节点信息，并通过 Kad DHT 来查找节点。
    - 节点路由（蓝色）：主要使用 Kad DHT 通过多跳来路由到网络中任意一个节点
    - 内容路由（紫色）：如果点对点发送消息，可以通过 Kad DHT，如果在网络中 flood，可以通过 floodsub 和 gossipsub 来对某个 topic 的内容进行广播
    - NAT traversal（红色）：包括主流的 hole punching 解决方案
* 网络身份：Network identity
    - 对于一个 p2p 网络，一个节点想让别人认识它并接受它的一个前提是它要有可以被识别的节点身份。这个就是 network identity。libp2p 使用公钥/私钥对来产生 network identity：私钥用于数据的签名，公钥作为 PeerId。一般来说，一个节点在初始化之后，应该产生一个配置文件，保存节点的公钥私钥，以便节点以后反复运行时能够使用相同的身份。
* 传输协议：Transport
    - 在 p2p 网络中，节点间传输协议的选择需要非常多样，这是因为网络中有可能运行着各种版本，甚至不同实现的节点，因而，支持一个范围广泛的传输协议供节点连接时协商，便变得非常必要。此外，p2p 网络需要额外的安全性，不仅仅是消息的加密，还有消息发送者的身份验证,将其类比成使能了 mutual auth 的 TLS：客户端验证服务器的证书来确保连接的是合法的服务器，而服务器同时也验证客户端的证书确保访问的是合法的客户端。
    - 为了实现这一目的，libp2p 抽象出了 Transport 层，负责传输协议的协商，包括使用什么样的传输协议，使用什么样的安全机制，以及如果做多路复用（stream multiplexing）。
    - 基本上，对应了 ISO/OSI 模型的：传输层（比如用 TCP）和会话层（比如用 Noise + Yamux）。如果使用过 websocket，对一个 HTTP 连接 "upgrade" 成 websocket 并不陌生，libp2p 在这些层之间也是一层层 upgrade 的。
* 网络行为：Network behaviour
    - 定义了在网络中要传输什么样的数据，或者说, p2p 协议本身。只需要专注于数据本身而不必考虑最终数据是如何加密，使用什么协议发送出去。清晰地像我们展示了什么是 Separation of Concerns。
    - libp2p 自带一系列 Network behaviour
        + Ping：节点和其 peer 之间 keepalive，以及网络诊断的工具。
        + mDNS：本地节点发现协议。
        + floodsub：floodsub protocol 实现。它是 libp2p 几种 pubsub 方案之一。适用于小型网络中消息的广播。我会单开一篇讲 pubsub 的。
        + kad：Kademlia 协议的实现。   
    - 也可以创建新的 Network behaviour，并且把你的协议和已有的 behaviour 组合在一起。要实现你自己的 Network behaviour，你需要：
        + 实现 UpgradeInfo：这告诉 libp2p 你的协议的唯一标识符，比如：/ipfs/ping/1.0.0。
        + 实现 InboundUpgrade 和 OutboundUpgrade：这是协议输入输出数据的处理。
        + 实现 ProtocolsHandler 和  NetworkBehaviour：协议的主要处理流程。
* Swarm 把 NetworkBehaviour 要发送的数据交给 Network 发送出去，并且把 Network 收到的数据交给 NetworkBehaviour 处理

## 工具

* [js-ipfs](https://github.com/ipfs/js-ipfs):IPFS implementation in JavaScript <https://ipfs.io>
* [go-ipfs](https://github.com/ipfs/go-ipfs):IPFS implementation in Go <https://ipfs.io>

## 参考

* [awesome-ipfs](https://github.com/ipfs/awesome-ipfs):Useful resources for using IPFS and building things on top of it <https://awesome.ipfs.io/>
* [](https://simpleaswater.com/ipfs/tutorials/hosting_website_on_ipfs_ipns_dnslink)
