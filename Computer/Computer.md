# Computer

计算机分解成最原始的部件——晶体管。晶体管是一种半导体材料，其最重要的作用就是半导：可以通过电流的变化，实现电路的切换。比如计算机最基础的与或非运算，都可以通过晶体管组成的电子元件实现。而通过晶体管的电位差不同，就可以体现"二进制数据"，即0和1。再加上电容和电阻，就能把这种二进制数据临时保存起来。综合这些特性，大牛们发现把晶体管用作精密的数学计算，可以极大的提高运算的效率。比如我有2个电容，分别是充满电和没有电，对他们同时释放电信号，电容就会把其中的电子放出来，经过特定的逻辑电路，如与门，得到了0的结果。要计算1+1，实际上也是类似的原理。我先设计一个加法电路，把若干电容组合成的"数字"流过这个电路，把结果存入目标电容，就得到了结果。大规模的复杂运算以此类推。最早期的计算机真的就是用许多结晶体管实现的复杂电路结构，通过控制输入电流得到希望的输出结果。后来人们发现，这种计算可以用某些形式抽象成多种指令，不用针对每次计算设计复杂的电路，只要调用指令就可以实现任何一种计算组合，于是诞生了cpu。只有cpu，每次都要自己配置输入信号，实在太痛苦，就做了纸带输入给计算机。后来又发现纸带还是很麻烦，于是发明了输入终端和对应的存储设备。后来又发现很多数据要临时保存起来，供连续计算使用，于是发明了内存。再后来pc的发展经历了无数次的变革，让计算机一步步到了今天的地步，也就是你现在看到的这样。

## 组成原理

* 理解冯诺依曼体系的结构，CPU和内存，硬盘，各种外设之间的关系，寄存器、缓存等知识。
* CPU有哪些指令，如何执行这些指令，如果实现数组，结构体，函数调用，这就涉及到汇编的知识。像原码，反码，补码，定点数、浮点数的表示和运算也是编程中必备的知识，几乎每种语言都要涉及。
* CPU中的缓存，缓存一致性协议，DMA的异步思想都会在应用层中有所体现
* 《深入理解计算机系统》
* 磁道 扇区

## 操作系统

* 掌握操作系统对外提供的抽象，包括进程、线程，文件，虚拟内存，以及进程间的通信问题
* 多线程的并发编程
* 线程都有哪些实现方式
* 进程是资源分配的最小单位，线程是调度的最小单位
* 锁和死锁
* 虚拟内存和物理内存直接的关系，分段和分页，文件系统的基本原理。
* 对于进程的调度，页面分配/置换算法，磁盘的调度算法，I/O系统，我认为优先级比较低。

## 数据库

基本的SQL，各种范式，事务及其隔离级别，事务的实现方式，索引及其实现方式，B+树

## 编译原理

利用现成的工具去生成/操作一个抽象语法树（AST），甚至可以会写一个DSL（领域特定语言）。 所以你得理解词法分析、语法分析、语义分析，中间代码生成，代码优化这个基本编译的过程。
学习了编译与原理，会对语言的一些设计有更深的理解，比如LISP。

## 计算机网络

* 分组交换
* TCP可靠性传输原理，TCP/IP的协议细节， 三次握手，四次挥手，TCP状态转换。
* 协议DHCP，UDP, ARP, DNS。：能够说出一个客户端如何在接入网络以后，通过这些协议，跨域网络和服务器通信的。
* 和应用层结合非常紧密的Socket知识和网络安全（对称加密，非对称加密，Hash, 数字签名，以及集大成者Https）
* 至于网络层的路由选择算法，链路层的各种协议，我认为优先级比较低。
* I/O多路复用，涉及到同步/异步，阻塞/非阻塞，select/epoll ，这个是很多软件的基础，在《Unix网络编程》，《深入理解计算机系统》中有讲述

## 数据结构


## 分布式

数据复制与一致性:
CAP理论， BASE原则，幂等性, 2PC, TCC
Paxos , Raft , Gossip

数据分片和路由:
Hash分片：Hash取模（实际中非常常见的算法）， 虚拟桶（Redis使用），一致性Hash（memcached使用）
范围分片

## 进程与线程

* 进程（Process）是计算机中的程序关于某数据集合上的一次运行活动，是系统进行资源分配和调度的基本单位，是操作系统结构的基础。
* 线程(thread)，有时被称为轻量级进程(Lightweight Process，LWP），是程序执行流的最小单元。
* 区别
    - 地址空间和其它资源（如打开文件）：进程间相互独立，同一进程的各线程间共享。某进程内的线程在其它进程不可见。
    - 通信：进程间通信IPC，线程间可以直接读写进程数据段（如全局变量）来进行通信——需要进程同步和互斥手段的辅助，以保证数据的一致性。
    - 调度和切换：线程上下文切换比进程上下文切换要快得多。
    - 在多线程OS中，进程不是一个可执行的实体。

## cache vs buffer

* cache
    - cache 是为了弥补高速设备和低速设备的鸿沟而引入的中间层，最终起到**加快访问速度**的作用
    - Cache（缓存）则是系统两端处理速度不匹配时的一种折衷策略。因为CPU和memory之间的速度差异越来越大，所以人们充分利用数据的局部性（locality）特征，通过使用存储系统分级（memory hierarchy）的策略来减小这种差异带来的影响。3、假定以后存储器访问变得跟CPU做计算一样快，cache就可以消失，但是buffer依然存在。比如从网络上下载东西，瞬时速率可能会有较大变化，但从长期来看却是稳定的，这样就能通过引入一个buffer使得OS接收数据的速率更稳定，进一步减少对磁盘的伤害。4、TLB（Translation Lookaside Buffer，翻译后备缓冲器）名字起错了，其实它是一个cache.
* buffer
    - buffer 的主要目的进行流量整形，把突发的大数量较小规模的 I/O 整理成平稳的小数量较大规模的 I/O，以**减少响应次数**（比如从网上下电影，你不能下一点点数据就写一下硬盘，而是积攒一定量的数据以后一整块一起写，不然硬盘都要被你玩坏了
    - Buffer（缓冲区）是系统两端处理速度平衡（从长时间尺度上看）时使用的。它的引入是为了减小短期内突发I/O的影响，起到流量整形的作用。比如生产者——消费者问题，他们产生和消耗资源的速度大体接近，加一个buffer可以抵消掉资源刚产生/消耗时的突然变化。
    - Buffer的核心作用是用来缓冲，缓和冲击。比如你每秒要写100次硬盘，对系统冲击很大，浪费了大量时间在忙着处理开始写和结束写这两件事嘛。用个buffer暂存起来，变成每10秒写一次硬盘，对系统的冲击就很小，写入效率高了，日子过得爽了。极大缓和了冲击。Cache的核心作用是加快取用的速度。比如你一个很复杂的计算做完了，下次还要用结果，就把结果放手边一个好拿的地方存着，下次不用再算了。加快了数据取用的速度。所以，如果你注意关心过存储系统的话，你会发现硬盘的读写缓冲/缓存名称是不一样的，叫write-buffer和read-cache。

操作系统
编译原理
形式语言与自动机
人工智能导论
数据结构与算法
软件理论基础

## 内存

* 程序只能在内存中运行
* 一个个电容所代表的0和1 ，由于这些电容不能持久地保持电荷，得定期地去刷新，如果不及时刷新，那些0和1的数据就会丢失
* 最小的一个格子就是一个bit ，只能存储0和1。8个bit 称为一个字节(Byte) 0～255 4个byte= 1 word
* 次序：大端（从左到右） 小端（从右到左）
* 编译器：允许用变量的方式来表达程序，可以把这些变量转换成地址
* 信息=位+上下文
* 指针

```c++
int i  = 300;
int *p = &i
total = *p + 200;
```

## 研究生方向

* 模式识别
* 软件工程技术和设计
* 人工智能
* 微型计算机系统接口技术
* 高等计算机网络
* 高性能计算实验
* 大数据分析(B)
* 大数据平台核心技术
* 大数据算法基础
* 随机信号的统计处理
* 大数据系统基础(B)
* 数字图像处理学
* 高等计算机系统结构
* 计算机网络体系结构
* 人工智能原理
* 计算机控制理论及应用
* 计算语言学
* 分布式数据库系统
* 智能控制
* 计算机视觉
* 数据安全
* 知识工程
* VLSI设计基础
* 语音信号数字处理
* 多媒体计算机技术
* 计算机辅助几何设计技术
* 超大规模集成电路布图理论与算法
* 数字系统自动设计
* 分布式多媒体系统与技术
* 工程数据库设计与应用
* 计算机支持的协同工作 CSCW
* 微计算机系统设计
* 计算机图形学
* 计算机网络和计算机系统的性能评价
* 并行计算
* 高级编译及优化技术
* 高等数值算法与应用
* 统计学习理论与应用
* 计算机视觉专题
* 计算智能及机器人学
* 面向对象技术与应用
* 计算机网络中的形式化方法与协议工程学
* 现代优化算法――设计与实践
* 高性能路由器体系结构与高速信息网络技术
* 计算科学与工程中的并行编程技术
* 下一代互联网
* 网格计算
* 计算机网络前沿研究 软件项目管理
* 宽带交换网与 QoS
* 算法分析与设计
* 计算理论导论
* 计算机系统性能测试
* 信息检索的前沿研究
* 网络系统的建模与分析
* 流媒体技术
* 网络存储技术
* 小波分析及其工程应用
* 人工智能基础理论选讲
* 无线网络和移动计算
* 计算生物学
* 计算机网络安全技术
* 计算机网络管理
* 数据挖掘:理论与算法
* 信息隐藏和数字水印技术
* 可信计算平台与可信网络连接
* 计算机专业英文论文写作与投稿
* 网络测量与分析技术
* 高等理论计算机科学(上)
* 高级操作系统
* 互联网路由算法和协议
* 高等理论计算机科学(下)
* 高级机器学习
* 分布式系统导论
* 计算广告学
* 大数据分析与处理
* 神经与认知计算
* 网络科学与策略机制
* 数据可视化
* 高级算法设计与分析
* 高等理论计算机科学(上)
* 高等理论计算机科学(下)
* 算法分析与设计
* 计算理论导论
* 高等计算经济学
* 计算生物学热门课题
* 随机网络优化理论
* 大规模数据分析专题
* 大数据平台系统
* 凸规划

## 学校

* 清华信息科学技术学院

## 课程

* [DeathKing/Learning-SICP](https://github.com/DeathKing/Learning-SICP):MIT视频公开课《计算机程序的构造和解释》中文化项目及课程学习资料搜集。 https://learningsicp.github.io
* [【计算机-合集】哈佛大学计算机核心课程](https://www.bilibili.com/video/av19302731)
* [Teach Yourself Computer Science](https://teachyourselfcs.com/)
* [Composing Programs](http://www.composingprograms.com/): a free online introduction to programming and computer science.
* [CyC2018/CS-Notes](https://github.com/CyC2018/CS-Notes):📚 Computer Science Learning Notes
* [sjtu-se-courseware/sjtu-se-courseware](https://github.com/sjtu-se-courseware/sjtu-se-courseware):上海交大软件学院课件
* [mbinary/USTC-CS-Courses-Resource](https://github.com/mbinary/USTC-CS-Courses-Resource):❤️中国科学技术大学计算机学院课程资源 https://mbinary.coding.me/ustc-cs/
* [InterviewMap/CS-Interview-Knowledge-Map](https://github.com/InterviewMap/CS-Interview-Knowledge-Map):Build the best interview map. The current content includes JS, network, browser related, performance optimization, security, framework, Git, data structure, algorithm, etc. https://yuchengkai.cn/docs/zh/frontend/
* [CS50's Introduction to Computer Science](https://www.edx.org/course/cs50s-introduction-computer-science-harvardx-cs50x)
* [数据结构(上)(自主模式)](http://www.xuetangx.com/courses/course-v1:TsinghuaX+30240184+sp/about)
* [数据结构(下)](http://www.xuetangx.com/courses/course-v1:TsinghuaX+30240184_2X+sp)
* [1c7/crash-course-computer-science-chinese](https://github.com/1c7/crash-course-computer-science-chinese):💻 计算机速成课 | Crash Course 字幕组 (全40集 2018-5-1 精校完成) https://www.bilibili.com/video/av21376839/
* [Berkeley CS61B](http://datastructur.es/sp17/)
* [Yorgey's cis194](https://www.seas.upenn.edu/~cis194/spring13/lectures.html)
* [Udacity](https://www.udacity.com/)
* [edX](https://www.edx.org/)
* [LeetCode](http://leetcode.com/):[中文](https://leetcode-cn.com/)
* [ossu/computer-science](https://github.com/ossu/computer-science):Path to a free self-taught education in Computer Science!
* [卡梅隆大学CS课件](http://www.cs.cmu.edu/~aada/courses/15251f16/www/schedule.html)
*   Apple Developer Site — 学习开发 IOS、Mac OS、Safari 环境下的 app。
*   Google Code — 学习开发安卓 app。
*   Code.org — 编程一小时活动的大本营。想学编程？就从这里起步吧。
*   Mozilla Developer Network — 不要被名字骗了，不是教你开发火狐插件。你可以学习 HTML, CSS 和 JavaScript。
*   Learnable — 也是学编程，超过 5000 个视频。
*   Pluralsight — 学编程。
*   CodeHS — 在学校、在家学编程！
*   Aquent Gymnasium — 学编程。
* [Parallel & Distributed Operating Systems Group ](https://pdos.csail.mit.edu/)
*   [Treehouse](https://teamtreehouse.com/):学习编程等互联网技能
*   [Playground](https://www.apple.com/swift/playgrounds/):ipad 上学习 swift 的游戏
*   [freecodecamp](https://www.freecodecamp.org/):Learn to code for free.
*   [scratch](https://scratch.mit.edu/)
*   [codecademy](https://www.codecademy.com/)
*   [wxwmd/HIT-Computer-Courses](https://github.com/wxwmd/HIT-Computer-Courses):哈工大计算机课程资料，包含计算机系统等多个科目
