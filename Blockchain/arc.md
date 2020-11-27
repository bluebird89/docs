# [ArcBlock](https://www.arcblock.io/)

## 配置

* 创建出来每一条链都会有自己对应的 forge_release.toml，里面是这条链的配置信息

```sh
npm install -g @arcblock/forge-cli

forge install --mirror https://releases.arcblockio.cn
forge download v0.38.7 --mirror https://releases.arcblockio.cn
# 发链
forge chain:create
forge chain:reset test-chain
forge chain:remove test-chain
forge chain:ls

forge start｜stop bluebird89
forge web open

# 检查链状态
forge status
forge ps
forge logs [-c test-chain]

# 检查币状态
forge status core
```

## 概念

* 资产 用于将数据保存一种更易于操作、控制和记录变化的形式
* 多重签名 一条交易可以需要多重签名验证查看详情
* 账户（Account）是用户在银行的户头+密码的组合，在区块链世界中也是如此，不论是比特币还是以太坊的账户都由地址、公钥、私钥 3 部分构成
  - 其中地址相当于用户名
  - 公钥+私钥相当于密码，尤其是私钥，丢失或者泄露就意味着失去账户（敏感信息、资金）的控制权
* 交易（Transaction）是账本中的任意一条收支记录，在区块链世界中可以指两个账户之间的转账交易、或者智能合约调用请求
* 区块（Block）是账本中的一页，账本的每页可能包含多笔收入和支出，同样，区块链中的每个区块都可能包含多笔交易
  - 本身可以用区块高度来标识
* 区块链（Blockchain）是装订成册的多页账本，账本不同页按照记录时间先后顺序组织，区块链中不同区块按被矿工打包的时间先后组织。
* 钱包：用户用工具、或随机生成的公私钥对，钱包仅仅包含公私钥对，可以用来签名交易或验证别人的签名
  - 不仅仅包含私钥、公钥对，还包含地址，这三者之间的推算关系是：私钥 --> 公钥 --> 地址
* 账户：在链上注册过，可以和其他账户发生交易，也可以通过地址从链上查到账户状态的钱包，账户隐含了跟他有关的各种其他状态和属性

```sh
forge wallet:create

# 查询账户
forge account <address>

# 查看单笔交易
forge tx <hash>
# 按照发生的时间倒序列出最新的 10 条 Transaction
forge tx:ls

# 查询块高为 12 的区块信息
forge block 12 --show-txs
forge block 1...4
forge block -f

# 查看资产
forge asset <address>

# 查看合约
forge contract:ls
```

## Forge CLI

* 区块链应用开发的瑞士军刀，用端到端的方式为开发者交付区块链应用的过程赋能，包含如下这些开箱即用的功能：
  - 管理你的链节点：包括开发环境、生产环境
  - 进行链上数据读写：区块、交易、账户、合约、资产等
  - 操作钱包和账户（Wallet 和 Account）
  - 完成智能合约的编译、部署和管理
  - 使用基石程序（Blocklet）进行快速开发
  - 使用区块浏览器、模拟器及 dApps Workshop
* [Blocklet](https://github.com/ArcBlock/blocklets)
  - ArcBlock 开放链访问协议让 Blocklet 可以和区块链通信
  - 分布式订阅网关则让基石程序可以和植根于用户浏览器或移动 App 的客户端代码通信
  - 类型
    + dApp
    + Stater
    + 智能合约（Contract）

```sh
forge blocklet:init

```

## 框架

* Core
  - coreo
  - TX layer
  - API layer
* Forge SDK
  - Forge Simulator：流量模拟器
  - Froge WEB
  - Forge API
  - dApp Workshop：dApp 原型工坊
  - Forge Desktop
  - Forge Patron：集成测试工具
  - Foege CLi
  - Forge Deploy：生产环境大规模部署的工具内部使用 Ansible，目前只支持部署私链
  - Forge Compiler：智能合约编译工具

```sh
# 查看本地已经安装版本
forge ls
forge ls：remote
```

## Forge 原理

* 数据类型
* 交易类型

*

##

* [区块链食品溯源 | 茶链](https://www.youtube.com/watch?v=rWH0WWYVUIs) 徐咏忻(娜娜)
