# 部署工具

## Deployer

- 安装：

  - 通过 Phar 存档

    ```
    curl -LO https://deployer.org/deployer.phar
    mv deployer.phar /usr/local/bin/dep
    chmod +x /usr/local/bin/dep
    ```

  - 通过 composer

    ```
    composer require deployer/deployer --dev
    php vendor/bin/dep
    ```

  - 通过github

    ```
    git clone https://github.com/deployphp/deployer.git
    php ./build
    ```

- 使用：

  - 在项目目录下运行dep init
  - 配置deployer.php 文件

- 部署自动化：git push后的需要dep deploy才部署

  - 生成 git 用户公钥和部署公钥 -> 设置用户公钥到你帐户相关联的 SSH Keys -> 设置部署公钥到你项目的 Deploy keys -> 准备 hook 文件 -> 在项目上添加一个 Webhook 并设置 hook 的网址

### Jenkins

The leading open source automation server, Jenkins provides hundreds of plugins to support building, deploying and automating any project.

#### install

- ubuntu

  ```
  # wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
  # sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
  # sudo apt-get update
  # sudo apt-get install jenkins
  访问ip：8080，进行安装以及配置用户
  ```

#### usage

### walle - 瓦力部署

### 代码托管工具支持webhooks

## etcd

etcd是一个高可用的键值存储系统，分布式一致性k-v存储系统,主要用于共享配置和服务发现。etcd是由CoreOS开发并维护的，灵感来自于 ZooKeeper 和 Doozer，它使用Go语言编写，并通过Raft一致性算法处理日志复制以保证强一致性。Raft是一个来自Stanford的新的一致性算法，适用于分布式系统的日志复制，Raft通过选举的方式来实现一致性，在Raft中，任何一个节点都可能成为Leader。Google的容器集群管理系统Kubernetes、开源PaaS平台Cloud Foundry和CoreOS的Fleet都广泛使用了etcd。 etcd 集群的工作原理基于 raft 共识算法 (The Raft Consensus Algorithm)。etcd 在 0.5.0 版本中重新实现了 raft 算法，而非像之前那样依赖于第三方库 go-raft 。raft 共识算法的优点在于可以在高效的解决分布式系统中各个节点日志内容一致性问题的同时，也使得集群具备一定的容错能力。即使集群中出现部分节点故障、网络故障等问题，仍可保证其余大多数节点正确的步进。甚至当更多的节点（一般来说超过集群节点总数的一半）出现故障而导致集群不可用时，依然可以保证节点中的数据不会出现错误的结果。

## Zookeeper

## Travis CI

用来构建托管在GitHub上的代码，最主要工作是自动运行项目的单元测试并生成报告，同时根据的配置文件，生成一个Linux虚拟机来运行你的命令，通常这些命令用于测试，构建等。默认设置下，每次对项目进行Push时，都会触发Travis CI运行一次测试。同时提供了一个项目状态图标，可以放置在项目主页告知用户当前的测试情况.

-

- 配置文件.travis.yml

```
language: php
php:
  - 5.3
  - 5.4
before_script:
  - composer install
  - cd tests
script: phpunit -v
```

[sovereign/sovereign](https://github.com/sovereign/sovereign)
