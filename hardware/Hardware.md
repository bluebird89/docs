# Hardware

* 自带操作系统的智能家电，我都建议不要购买，比如可以上网的互联网冰箱

## IOE

* 存储使用EMC阵列（容量大，数据安全），IBM服务器，即IOE组合，这三个组合很强大（高可用，高性能）

## 硬盘

* 机械硬盘（HDD）：即传统普通硬盘
    - 主要由：盘片，磁头，盘片转轴及控制电机，磁头控制器，数据转换器，接口，缓存等几个部分组成
    - 机械硬盘中所有的盘片都装在一个旋转轴上，每张盘片之间是平行的，在每个盘片的存储面上有一个磁头，磁头与盘片之间的距离比头发丝的直径还小，所有的磁头联在一个磁头控制器上，由磁头控制器负责各个磁头的运动
    - 磁头可沿盘片的半径方向运动，加上盘片每分钟几千转的高速旋转，磁头就可以定位在盘片的指定位置上进行数据的读写操作
    - 数据通过磁头由电磁流来改变极性方式被电磁流写到磁盘上，也可以通过相反方式读取。硬盘为精密设备，进入硬盘的空气必须过滤
    - HDD 在价格、容量、使用寿命上占有绝对优势
* 固态硬盘（SSD）:用固态电子存储芯片阵列而制成的硬盘，由控制单元和存储单元（FLASH 芯片、DRAM 芯片）组成。固态硬盘在接口的规范和定义、功能及使用方法上与普通硬盘的完全相同
    - 在乱序写时，性能表现比机械硬盘会好很多，特别是多线程同时进行写操作时，性能也会比单线程顺序写强
    - 在防震抗摔、传输速率、功耗、重量、噪音上有明显优势，SSD 传输速率性能是HDD 的2倍

## 耳机

* B&O PLAY by BANG & OLUFSEN - BeoPlay H6 Over-Ear Headphones, Natural (1642003)
* Libratone小鸟音响

* Computer（大尺寸屏幕,甚至两块屏幕）

* 耳机

## 显示器

* 明基 EW2780
* 明基 E540 投影仪
* 明基 EW2775ZH
* 明基 PD2710QC

## 电脑

* 戴尔27英寸XPS旗舰一体机
* GPD p2 max 8.9英寸
* MateBook X Pro 2020
* 荣耀笔记本Pro 锐龙版16.1英寸笔记本电脑 Ryzen 5 3550H 8GB 512GB（冰河银）MagicBook Pro
    - [AMD Ryzen™ 5 Mobile Processors with Radeon™ Vega Graphics驱动](https://www.amd.com/zh-hans/support/apu/amd-ryzen-processors/amd-ryzen-5-mobile-processors-radeon-vega-graphics/amd-ryzen-5-2)
        + 8核心16线程
    - 3月21日，AMD在游戏开发者大会上正式公布自家的实时光线追踪技术，说白了就是和N卡旗下RTX显卡抗衡的自家技术。该解决方案是基于Raden Rays构建的，是一个开源的GPU光追引擎，支持OpenCL等技术
* Manjaro InfinityBook S 14 v5
* Intel® NUC Mini PC
* MacBook Pro:15 寸，16G
* Acer Chromebook R11
* Chromebook


```sh
sudo lshw -c video
lsmod | grep amd

tar -xJvf amdgpu-pro_*.tar.xz
./amdgpu-pro-install -y
amdgpu-pro-uninstall

sudo add-apt-repository ppa:oibaf/graphics-drivers
sudo apt-get update

sudo apt install ppa-purge
sudo ppa-purge ppa:oibaf/graphics-drivers

# /etc/X11/xorg.conf
Section "Device"
    Identifier "AMDGPU"
    Driver "amdgpu"
    Option "AccelMethod" "glamor"
    Option "DRI" "3"
EndSection
```

## TV

* 国内的智能电视机，现在都自带系统，一打开就是各种菜单，有直播、影视、游戏、应用等等。为电视机的使用年限很长，可能达到10年。内置的操作系统不可能跟着更新这么久，事实上很多电视机自从出厂，就再也不更新系统了。以后，一打开电视，就会看到过时的系统
* 为了压低成本，智能电视使用的 CPU、内存和储存，都是很差的配置，不可能有好的性能和体验。只要一两年，系统就会变得很卡，动不动就提醒没有剩余空间了
* 电视机和系统是分开的两个硬件，不集成在一起。电视机最好就是一个单纯的显示设备，操作系统由机顶盒来承担.国内电视机的操作系统，很大的目的是播放开机广告，他们舍不得这一块的利益

## 键盘

* Das Keyboard Professional Model S for Mac (DASK3PROMS1MACCLI)
* MX Board Silent基于经典的G80-3000打造，内部采用樱桃自家的MX静音轴，轴体内部拥有独特形状的橡胶垫来降低敲击时产生的噪音，目前，MX Board Silent键盘提供了MX红轴和MX黑轴两种轴体供用户选择，轴体寿命5000万次。售价149美元（约合1030元人民币）。
* FILCO 斐尔可 87 圣手忍者 FILCO Majestouch2 87
* 斐尔可（FILCO） FKBN87MRL/EB2 Majestouch 2「87 圣手二代」
* HHKB Professional ~~2~~
* Kinesis KB600 Advantage2
* Das Keyboard Model S Professional for Mac Clicky MX Blue Mechanical Keyboard (DASK3PROMS1MACCLI)
* IKBC C87 F87 红轴最好
* cherry mx8.0
* 腕托

## 触摸板

* 选择项目：点击触摸板。
* 滚动：将两个手指放在触摸板上，然后以水平或垂直方向滑动。
* 放大或缩小：将两个手指放在触摸板上，然后收缩或拉伸。
* 显示更多命令（类似于右键单击）：使用两根手指点击触摸板，或按右下角。
* 查看所有打开的窗口：将三根手指放在触摸板上，然后朝外轻扫。
* 显示桌面：将三根手指放在触摸板上，然后朝里轻扫。
* 在打开的窗口之间切换：将三根手指放在触摸板上，然后向右或向左轻扫。
* 打开 Cortana：用三根手指点击触摸板。
* 打开操作中心：用四根手指点击触摸板。
* 切换虚拟桌面：将四根手指放在触摸板上，然后向右或向左轻扫。
* 三指
    - 上：多任务视图
    - 下：显示桌面
    - 左：切换应用
    - 右：切换应用
* 四指
    - 上：多任务视图
    - 下：显示桌面
    - 左：切换桌面
    - 右：切换桌面
* 三指屏幕大小控制与分屏位置
* 两指滚动控制

## 手机

* 乐视
    * 为了拿下市场份额，他们将采用比零成本更激进的策略，用户每买一款手机乐视都要亏损一两百元，然后再通过其他方式将这些亏损的钱赚回来。
    - 贾跃亭希望通过LePar打造出类似小米之家那样的模式来，
    - 冯幸认可LePar的理念，但是在各个业务线都还很弱的时候，不应该强行捏在一起，应该等乐视移动在现有渠道真正站稳脚跟之后再考虑新的渠道。
    - 乐视整个体系的财务状况
        - 刘江峰曾经向老贾建议过乐视花钱应该谨慎，但是老贾根本不听，他说刘的想法是传统思维，乐视是生态思维，要站在未来看未来，站在未来看现在。刘江峰说你这讲的都是玄学了，两人只好结束这一话题。
        - 贾跃亭于11月6日发布的一封全员信将此事放大，加速了乐视“帝国”的坍塌。
        - 第一次亲眼目睹资本市场如此现实的一面，想不到他们翻脸比翻书还快。
        - 贾跃亭全员信发出的第一时间，时任酷派CEO的刘江峰知道事态不对，马上去找融资，当时包括建银、华融等二三十家投资者都表示有投资意向，且投资规模能在几亿美金，完全有希望盘活酷派。
        - 当与这些机构谈得差不多之后，刘江峰去找贾跃亭谈，却遭到拒绝，后者不愿意稀释股权。而另一边，酷派本身有土地可以卖，刘江峰想借此筹到资金，但酷派创始人郭德英又不同意。两个老板相互之间“踢皮球”，延误了融资的最佳时期。到2017年3月，那些原本有意要投的机构早已闭门谢客了。5个月后，刘江峰从酷派离职。
* 锤子
    - 钱晨表示股份多少无所谓，但现金不能少，而雷军认为对股权不在乎的人不会有创业精神，更不可能all-in，于是双方只好放弃。
    - 以前罗永浩去挖人，都会告诉钱晨以及核心高管，但这一次去找吴德周，钱晨并不知情，罗永浩有意瞒着他。当吴德周要入职时，钱晨显得很慌乱。
    - 吴德周来了以后，罗永浩让他直接接管了陈某负责的业务，然后接管了钱晨负责的业务。6月底，钱晨从锤子离职，官方对外说法是“退休”，又过了一个月，陈某也从锤子离职。罗永浩此举背后，显示出对钱晨和陈某工作的不满。
* 魅族
    - 2015年拿到阿里巴巴投资之后，魅族开启“大跃进”模式，魅族和魅蓝两大品牌全年销售2000万台，比上一年增长数倍。
    - 白永祥是Pro 7这款产品最大的责任人，那么黄章无疑是魅族这家公司最大的责任人。腾讯《深网》接触到的多位魅族在职或离职员工均表示，黄章丝毫没意识到一个团队的稳定性有多重要，不顾及频繁换人的后果。“本身产品定位就有问题，加上魅族Pro 7上市前销售和市场的人全换了，完全没有按照正确的节奏去卖。
* 一加
    - 只做旗舰机
* iphoneSE
* 中兴
    - ZTE BLADE 20 smart
* pixel4a

## 平板

* Boox
    - Android 9.0 系统，囊括各商店 app，当然也包括 Kindle、微信读书、豆瓣阅读等，基本上是一个安卓平板
    - 优化过的电子墨水书写体验，延迟很小，除了写玻璃瓶面手感不一样之外几乎可以代替草稿纸
    - DPI 较高，跟除了 Oasis 之外的 Kindle 比起来看漫画、有图的 PDF 等体验更好
    - 支持书写
    - 系列
        + Poke，跟 Kindle 对标的 6 寸屏，注重便携和阅读，没有书写功能，现在出到 Poke 2。当然，也是系列最便宜的产品。MSRP $189.99
        + Nova 2，7.8 寸屏跟 iPad Mini 和实体 32 开书相近，之前分为支持书写（Pro）和纯阅读（相对便宜）两款产品，现在新出的 Nova 2 也支持书写替代了 pro，不知道还会不会有这个大小的纯阅读器产品线。MSRP $339.99
        + Note，10.3 寸跟 iPad 大小相近。现在出到 Note 2. $549.99
        + Max，13.3 寸，各项硬件最强大，适合演算、乐谱等专业用户场景，当然价格也对标了专业价格。现在出到 max 3，MSRP $859.99.
* SuperNote
* reMarkable

## 智慧屏

## 路由

* PHICOMM 斐讯K2p A2

## 工具

* [Krog](https://www.korg.com)
* [XOD](https://xod.io/):A VISUAL PROGRAMMING LANGUAGE FOR MICROCONTROLLERS
* [Phoronix Test Suite](http://phoronix-test-suite.com/)：Open-Source, Automated Benchmarking

## 资源

* [装备前线](https://www.zfrontier.com/app/)
* 渠道
    - [Lenovo](https://www.corporateperks.com/)
