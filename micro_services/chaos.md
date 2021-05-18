# Chaos

* 各类故障可能会随时随地的发生，其中有很多故障无法避免.更方便地验证系统对于各种故障的容忍能力，Netflix 创造了一只名为 Chaos 的猴子，并且将它放到 AWS 云上，用于向基础设施以及业务系统中注入各类故障类型。这只 “猴子” 就是混沌工程起源
* 类型
  - pod-kill：模拟 Kubernetes Pod 被 kill。
  - pod-failure：模拟 Kubernetes Pod 持续不可用，可以用来模拟节点宕机不可用场景。
  - network-delay：模拟网络延迟。
  - network-loss：模拟网络丢包。
  - network-duplication: 模拟网络包重复。
  - network-corrupt: 模拟网络包损坏。
  - network-partition：模拟网络分区。
  - I/O delay : 模拟文件系统 I/O 延迟。
  - I/O errno：模拟文件系统 I/O 错误

## 工具

* [chaosblade](https://github.com/chaosblade-io/chaosblade):An easy to use and powerful chaos engineering experiment toolkit.（阿里巴巴开源的一款简单易用、功能强大的混沌实验注入工具）
* [chaos-mesh](https://github.com/pingcap/chaos-mesh):A Chaos Engineering Platform for Kubernetes

## 参考

* [微服务架构下的质量迷思——混沌工程](https://www.infoq.cn/article/GQYkuMBWOF00CR_VxgDg)
* [](https://mp.weixin.qq.com/s/e436JWyPxgf3bdDPeddkRA)
