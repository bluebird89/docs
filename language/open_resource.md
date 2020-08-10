# open resource

The Open Organization

## 源码

* 一种方法、手段，而不是目的
* 方法
    - 先看文档，整体把握
    - 理解代码组织，文件名，类名
    - 关注一个问题，从问题追踪代码
    - 解决一个issue
    - 调试
    - 加注释，做笔记

## LISCENSE

* 开源许可证是一种法律许可。通过它，版权拥有人明确允许，用户可以免费地使用、修改、共享版权软件。
* 版权法默认禁止共享，也就是说，没有许可证的软件，就等同于保留版权，虽然开源了，用户只能看看源码，不能用，一用就会侵犯版权。所以软件开源的话，必须明确地授予用户开源许可证。
* 宽松式（permissive）许可证
    - 没有使用限制 用户可以使用代码，做任何想做的事情。
    - 没有担保 不保证代码质量，用户自担风险。
    - 披露要求（notice requirement） 用户必须披露原始作者。
    - 常见:允许用户任意使用代码，区别在于要求用户遵守的条件不同。
        + BSD（ Berkeley Software Distribution 二条款版） 分发软件时，必须保留原始的许可证声明。
        + BSD（3-clause license） 分发软件时，必须保留原始的许可证声明。不得使用原始作者的名字为软件促销。
            * 如果再发布的产品中包含源代码，则在源代码中必须带有原来代码中的BSD协议。
            * 如果再发布的只是二进制类库/软件，则需要在类库/软件的文档和版权声明中包含原来代码中的BSD协议。
            * 不可以用开源代码的作者/机构名字和原来产品的名字做市场推广。
            * BSD 代码鼓励代码共享，但需要尊重代码作者的著作权。BSD由于允许使用者修改和重新发
        + MIT 分发软件时，必须保留原始的许可证声明，与 BSD（二条款版）基本一致。
            * 作者只想保留版权,而无任何其他了限制。MIT与BSD类似，但是比BSD协议更加宽松，是目前最少限制的协议
            * 这个协议唯一的条件就是在修改后的代码或者发行包包含原作者的许可信息。适用商业软件。使用MIT的软件项目有：jquery、Node.js。
        + Apache 2 分发软件时，必须保留原始的许可证声明。那些涉及专利内容的开发者而言，该协议最适合 凡是修改过的文件，必须向用户说明该文件修改过；没有修改过的文件，必须保持许可证不变。
            * 永久权利: 一旦被授权，永久拥有。
            * 全球范围的权利: 在一个国家获得授权，适用于所有国家。
            * 授权免费，且无版税: 前期，后期均无任何费用。
            * 授权无排他性: 任何人都可以获得授权
            * 授权不可撤消: 一旦获得授权，没有任何人可以取消。比如，你基于该产品代码开发了衍生产品
        + EPL (Eclipse Public License 1.0)
            * EPL允许Recipients任意使用、复制、分发、传播、展示、修改以及改后闭源的二次商业发布。
            * 使用EPL协议，需要遵守以下规则：
            * 当一个Contributors将源码的整体或部分再次开源发布的时候,必须继续遵循EPL开源协议来发布,而不能改用其他协议发布.除非你得到了原"源码"Owner 的授权；
            * EPL协议下,你可以将源码不做任何修改来商业发布.但如果你要发布修改后的源码,或者当你再发布的是Object Code的时候,你必须声明它的Source Code是可以获取的,而且要告知获取方法；
            * 当你需要将EPL下的源码作为一部分跟其他私有的源码混和着成为一个Project发布的时候,你可以将整个Project/Product以私人的协议发布,但要声明哪一部分代码是EPL下的,而且声明那部分代码继续遵循EPL；
            * 独立的模块(Separate Module),不需要开源。
* Copyleft 许可证:
    - 如果分发二进制格式，必须提供源码
    - 修改后的源码，必须与修改前保持许可证一致
    - 不得在原始许可证以外，附加其他限制
    - 常见
        + Affero GPL (AGPL) 如果云服务（即 SAAS）用到的代码是该许可证，那么云服务的代码也必须开源。
        + GPL（GNU General Public License） 如果项目包含了 GPL 许可证的代码，那么整个项目都必须使用 GPL 许可证。Linux 采用了 GPL
            * 出发点是代码的开源/免费使用和引用/修改/衍生代码的开源/免费使用，但不允许修改后和衍生的代码做为闭源的商业软件发布和销售。
        + LGPL 如果项目采用动态链接调用该许可证的库，项目可以不用开源。
        + Mozilla（MPL） 只要该许可证的代码在单独的文件中，新增的其他文件可以不用开源。
            * MPL协议允许免费重发布、免费修改，但要求修改后的代码版权归软件的发起者 。这种授权维护了商业软件的利益，它要求基于这种软件的修改无偿贡献版权给该软件。这样，围绕该软件的所有代码的版权都集中在发起开发人的手中。但MPL是允许修改，无偿使用得。MPL软件对链接没有要求

## 镜像源 Mirror Source

* [USTC Mirror](http://mirrors.ustc.edu.cn/help/index.html#)
* [阿里巴巴开源软件站](https://opsx.alibaba.com/)
* [facebook/watchman](https://github.com/facebook/watchman):Watches files and records, or triggers actions, when they change. https://facebook.github.io/watchman/
* [腾讯软件源](https://mirrors.cloud.tencent.com)
* [](https://bitnami.com)
* 国内
    + 清华大学  mirrors.tuna.tsinghua.edu.cn
    + 中国科学技术大学    mirrors.ustc.edu.cn
    + 上海交通大学  ftp.sjtu.edu.cn
    + 上海大学    mirrors.shu.edu.cn
- 企业开源镜像站：
    + 阿里云 mirrors.aliyun.com
    + 腾讯云 mirrors.cloud.tencent.com
    + 华为云 mirrors.huaweicloud.com
    + 网易  mirrors.cn99.com
    + 首都在线    mirrors.yun-idc.com
- 国外高校开源镜像站：
    + [The Chinese University of Hong Kong ](ftp.cuhk.edu.hk)
    + [元智大學](ftp.yzu.edu.tw)
    + [Massachusetts Institute of Technology](mirrors.mit.edu)
- 国外云服务商开源镜像站：
    + Digital Ocean   mirrors.digitalocean.com
    + Linode  mirrors.linode.com
    + Cat Networks    mirrors.cat.net
- 国外公益开源镜像站：
    + Kernel ORG  mirrors.kernel.org
    + Yandex  mirror.yandex.ru

## 工具

* [ odoo / odoo ](https://github.com/odoo/odoo):Odoo. Open Source Apps To Grow Your Business.
* [freedesktop.org](https://www.freedesktop.org/wiki/):hosts the development of free and open source software, focused on interoperability and shared technology for open-source graphical and desktop systems.
* [Huawei](https://code.opensource.huaweicloud.com/home)
* https://github.com/uber/makisu
* https://github.com/uber/prototool#quick-start
* https://github.com/uber/RIBs
* https://github.com/zhangdaiscott/jeecg-boot
* https://github.com/didi/DoraemonKit
* https://github.com/didi/chameleon
* https://github.com/uber/deck.gl
* https://github.com/uber/react-vis
* https://github.com/uber/kraken
* https://github.com/uber/ludwig
