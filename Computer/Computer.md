# Computer

* 最原始的部件——晶体管。晶体管是一种半导体材料，其最重要的作用就是半导：可以通过电流的变化，实现电路的切换。比如计算机最基础的与或非运算，都可以通过晶体管组成的电子元件实现。而通过晶体管的电位差不同，就可以体现"二进制数据"，即0和1。再加上电容和电阻，就能把这种二进制数据临时保存起来。综合这些特性，大牛们发现把晶体管用作精密的数学计算，可以极大的提高运算的效率。比如我有2个电容，分别是充满电和没有电，对他们同时释放电信号，电容就会把其中的电子放出来，经过特定的逻辑电路，如与门，得到了0的结果。要计算1+1，实际上也是类似的原理。我先设计一个加法电路，把若干电容组合成的"数字"流过这个电路，把结果存入目标电容，就得到了结果。大规模的复杂运算以此类推。最早期的计算机真的就是用许多结晶体管实现的复杂电路结构，通过控制输入电流得到希望的输出结果。后来人们发现，这种计算可以用某些形式抽象成多种指令，不用针对每次计算设计复杂的电路，只要调用指令就可以实现任何一种计算组合，于是诞生了cpu。只有cpu，每次都要自己配置输入信号，实在太痛苦，就做了纸带输入给计算机。后来又发现纸带还是很麻烦，于是发明了输入终端和对应的存储设备。后来又发现很多数据要临时保存起来，供连续计算使用，于是发明了内存

* 设计模式
* 两门以上编程语言（强类型+弱类型)
* 形式语言与自动机

## 组成原理

* 理解冯诺依曼体系的结构，CPU和内存，硬盘，各种外设之间的关系，寄存器、缓存等知识
* CPU有哪些指令，如何执行这些指令，如果实现数组，结构体，函数调用，这就涉及到汇编的知识。像原码，反码，补码，定点数、浮点数的表示和运算也是编程中必备的知识，几乎每种语言都要涉及。
* CPU中的缓存，缓存一致性协议，DMA的异步思想都会在应用层中有所体现
* 磁道 扇区
* CPU即处理器，是计算机中控制数据操控的电路
    - 物理 CPU 核心数指的是真正插在物理插槽上 CPU 的核心数
    - 逻辑 CPU 核心数指的是结合 CPU 多核以及超线程技术得到的 CPU 核心数，最终核心数以逻辑 CPU 核心数为准
    - 算术/逻辑单元:执行运算
    - 控制单元:协调机器活动
    - 寄存器单元:临时存储,分为通用寄存器和专用寄存器
        + 通用寄存器用于临时存放CPU正在使用的数据
        + 专用寄存器用于CPU专有用途，比如指令寄存器和程序计数器
    - 通过控制单元能够操作主存中的数据
    - CPU将主存的指令加载进来解码并执行，其中涉及两个重要寄存器：指令寄存器与程序计数器。指令寄存器用于存储正在执行的指令，而程序计数器则保持下一个待执行的指令地址。
    - CPU向主存请求加载程序计数器指定的地址的指令，将其存放到指令寄存器中，加载后将程序计数器的值加2（假如指令长度为2个字节）。
    - 与其他设备的通信一般通过控制器来实现，控制器可能在主板上，也可能以电路板形式插到主板.现在随着通用串行总线（USB）成为通用的标准，很多外设都可以直接用USB控制器作为通信接口。每个控制器都连接在总线上，通过总线进行通信。
    - 直接存储器存取（DMA）是一种提升外设通信性能的措施，CPU并非总是需要使用总线，在总线空闲的时间里控制器能够充分利用起来。因为控制器都与总线相连接，而控制器又有执行指令的能力，所以可以将CPU的一些工作分给控制器来完成。比如在磁盘中检索数据时，CPU可以将告知控制器，然后由控制器找到数据并放到主存上，期间CPU可以去执行其他任务。这样能节省CPU资源。不过DMA会使总线通信更加复杂，而且会导致总线竞争问题。总线瓶颈源自冯诺依曼体系结构
    - CPU缓存:新的CPU会有三级内存（L1，L2，L3）

## CPU

* 不同的 CPU 设计实现，就称为" CPU 架构"（CPU architecture）.不同的 CPU 架构有不同的指令集，彼此不通用，这导致运行在上面的软件也不兼容，必须重新编译
* x86:性能好，但是耗电多、电压高，主要用于桌面电脑和服务器，生产厂商为 Intel 公司和 AMD 公司
* ARM:耗电小、电压低，但是单核性能不如 x86，主要用于移动设备
    - 商业模式是授权制。英国的 ARM 公司出售指令集的授权，购买授权的公司可以基于公版的设计，开发自己的 ARM 芯片。高通、三星、华为、苹果等公司的芯片，都属于这个模式

## 内存

* 程序只能在内存中运行
* 一个个电容所代表的0和1 ，由于这些电容不能持久地保持电荷，得定期地去刷新，如果不及时刷新，那些0和1的数据就会丢失
* 最小的一个格子就是一个bit ，只能存储0和1。8个bit 称为一个字节(Byte) 0～255 4个byte= 1 word
* 次序：大端（从左到右） 小端（从右到左）
* 编译器：允许用变量的方式来表达程序，可以把这些变量转换成地址
* 信息=位+上下文
* 指针
* 局部性原理
    - CPU 与内存之间往往集成了挺多层级的缓存，这些缓存越接近CPU，速度越快，所以如果能提前把内存中的数据加载到如下图中的 L1, L2, L3 缓存中，那么下一次 CPU 取数的话直接从这些缓存里取即可，能让CPU执行速度加快
    - 当某个元素被用到的时候，那么这个元素地址附近的的元素会被提前加载到 L1,L2,L3 缓存中呢
    - 无论是内存还是磁盘，操作系统都是按页的大小进行读取的（页大小通常为 4 kb），磁盘每次读取都会预读，会提前将连续的数据读入内存中，这样就避免了多次 IO

* Linux内存管理中通过MMU的硬件实现虚拟地址到物理地址的转换，但是每次都这样转换势必造成性能的损耗，所以采用了缓存组件TLB来缓存最近使用的虚拟地址到物理地址的映射

```c++
int i  = 300;
int *p = &i
total = *p + 200;
```

## 操作系统

* 掌握操作系统对外提供的抽象，包括进程、线程，文件，虚拟内存，以及进程间的通信问题
* 多线程的并发编程
* 线程都有哪些实现方式
* 进程是资源分配的最小单位，线程是调度的最小单位
* 锁和死锁
* 调度算法
* 虚拟内存和物理内存直接的关系，分段和分页，文件系统的基本原理。
* 对于进程的调度，页面分配/置换算法，磁盘的调度算法，I/O系统，我认为优先级比较低。
* 搞清楚CPU、内存、网络、I/O设备之间的交互和速度差别
    - 对于计算密集型应用，就需要关注程序执行的效率
    - 对于I/O密集型，要关注进程（线程）之间的切换以及I/O设备的优化以及调度
* 脚本编程

## 数据库

* InnoDB B+树
* MyISAM
* 字符集
* 索引
* 数据库范式
* 事务及其隔离级别
* MVCC
* 数据库锁

## 编译原理

利用现成的工具去生成/操作一个抽象语法树（AST），甚至可以会写一个DSL（领域特定语言）。 所以得理解词法分析、语法分析、语义分析，中间代码生成，代码优化这个基本编译的过程。学习了编译与原理，会对语言的一些设计有更深的理解，比如LISP。

* 指令系统
    - 精简指令集计算机（RISC）:供了最小的机器指令集，计算机效率高速度快且制造成本低
    - 复杂指令集计算机(CISC):提供了强大丰富的指令集，能更方便实现复杂的软件
    - 三类
        + 数据传输类指令用于将数据从一个地方移动到另一个地方。比如将主存单元的内容加载到寄存器的LOAD指令，反之将寄存器的内容保存到主存的STORE指令。此外，CPU与其它设备（键盘、鼠标、打印机、显示器、磁盘等）进行通信的指令被称为I/O指令。
        + 算术/逻辑类指令用于让控制单元请求在算术/逻辑单元内执行运算。这些运算包括算术、与、或、异或和位移等。
        + 控制类指令用于指导程序执行。比如转移（JUMP）指令，它包括无条件转移和条件转移
* Compilers: Principles,Techniques,and Tools 编译原理技术和工具 Alfred V.Aho,Ravi Sethi,Jeffrey D.Ullman
* Modern Compiler Implementation in C  Andrew W.Appel,with Jens Palsberg  现代编译原理-C语言描述
* Advanced Compiler Design and Implementation  Steven S.Muchnick  高级编译器设计与实现

## 计算机网络

* 网络协议
    - DHCP，UDP, ARP, DNS
    - 一个客户端如何在接入网络以后，通过这些协议，跨域网络和服务器通信的
* HTTP/S
    - TCP可靠性传输原理，TCP/IP的协议细节， 三次握手，四次挥手，TCP状态转换
* 网络状态
* 长连接
* 网络握手
* 滑动窗口
* 网络参数
    - 和应用层结合非常紧密的Socket知识和网络安全（对称加密，非对称加密，Hash, 数字签名，以及集大成者Https）
* 通信模型
* 序列化
* 分组交换
* 网络层的路由选择算法，链路层的各种协议
* I/O多路复用，涉及到同步/异步，阻塞/非阻塞，select/epoll

## 分布式

* 数据复制与一致性
* CAP理论， BASE原则，幂等性, 2PC, TCC
* Paxos , Raft , Gossip
* 数据分片和路由
* Hash分片：Hash取模（实际中非常常见的算法）， 虚拟桶（Redis使用），一致性Hash（memcached使用）
* 范围分片


## 图书

* 《深入理解计算机系统》
* 《Unix网络编程》

## 项目

* [ gto76 / comp-m2 ](https://github.com/gto76/comp-m2):Comp Mark II – Simple 4-bit virtual computer
* [Chip-8 Technical Reference v1.0](http://devernay.free.fr/hacks/chip8/C8TECH10.HTM)

## 课程

* [DeathKing/Learning-SICP](https://github.com/DeathKing/Learning-SICP):MIT视频公开课《计算机程序的构造和解释》中文化项目及课程学习资料搜集。 https://learningsicp.github.io
* [【计算机-合集】哈佛大学计算机核心课程](https://www.bilibili.com/video/av19302731)
* [Teach Yourself Computer Science](https://teachyourselfcs.com/)
* [Composing Programs](http://www.composingprograms.com/): a free online introduction to programming and computer science.
* [CyC2018/CS-Notes](https://github.com/CyC2018/CS-Notes):📚 Computer Science Learning Notes
* [CoolPhilChen / SJTU-Courses](https://github.com/CoolPhilChen/SJTU-Courses/):上海交通大学课程资料分享
* [sjtu-se-courseware/sjtu-se-courseware](https://github.com/sjtu-se-courseware/sjtu-se-courseware):上海交大软件学院课件
* [PKUanonym / REKCARC-TSC-UHT](https://github.com/PKUanonym/REKCARC-TSC-UHT):清华大学计算机系课程攻略 Guidance for courses in Department of Computer Science and Technology, Tsinghua University https://rekcarc-tsc-uht.readthedocs.io/
* [USTC-Resource/USTC-CS-Courses-Resource](https://github.com/USTC-Resource/USTC-Course):❤️中国科学技术大学计算机学院课程资源 https://mbinary.coding.me/ustc-cs/
* [tongtzeho / PKUCourse](https://github.com/tongtzeho/PKUCourse):北大计算机课程大作业
* [InterviewMap/CS-Interview-Knowledge-Map](https://github.com/InterviewMap/CS-Interview-Knowledge-Map):Build the best interview map. The current content includes JS, network, browser related, performance optimization, security, framework, Git, data structure, algorithm, etc. https://yuchengkai.cn/docs/zh/frontend/
* [CS50's Introduction to Computer Science](https://www.edx.org/course/cs50s-introduction-computer-science-harvardx-cs50x)
* [数据结构(上)(自主模式)](http://www.xuetangx.com/courses/course-v1:TsinghuaX+30240184+sp/about)
* [数据结构(下)](http://www.xuetangx.com/courses/course-v1:TsinghuaX+30240184_2X+sp)
* [1c7/crash-course-computer-science-chinese](https://github.com/1c7/crash-course-computer-science-chinese):💻 计算机速成课 | Crash Course 字幕组 (全40集 2018-5-1 精校完成) https://www.bilibili.com/video/av21376839/
* [Berkeley CS61B](http://datastructur.es/sp17/)
* [Yorgey's cis194](https://www.seas.upenn.edu/~cis194/spring13/lectures.html)
* [卡梅隆大学CS课件](http://www.cs.cmu.edu/~aada/courses/15251f16/www/schedule.html)

## 工具

* [giampaolo / psutil](https://github.com/giampaolo/psutil):Cross-platform lib for process and system monitoring in Python

## 参考

* [Udacity](https://www.udacity.com/)
* [edX](https://www.edx.org/)
* [codecademy](https://www.codecademy.com/)
* [LeetCode](http://leetcode.com/):[中文](https://leetcode-cn.com/)
* [ossu/computer-science](https://github.com/ossu/computer-science):Path to a free self-taught education in Computer Science!
* Apple Developer Site — 学习开发 IOS、Mac OS、Safari 环境下的 app
* Google Code — 学习开发安卓 app
* Code.org — 编程一小时活动的大本营
* Mozilla Developer Network
* Learnable
* Pluralsight
* CodeHS
* Aquent Gymnasium
* [Parallel & Distributed Operating Systems Group ](https://pdos.csail.mit.edu/)
* [Treehouse](https://teamtreehouse.com/):学习编程等互联网技能
* [Playground](https://www.apple.com/swift/playgrounds/):ipad 上学习 swift 的游戏
* [freecodecamp](https://www.freecodecamp.org/):Learn to code for free.
* [scratch](https://scratch.mit.edu/)
* [wxwmd/HIT-Computer-Courses](https://github.com/wxwmd/HIT-Computer-Courses):哈工大计算机课程资料，包含计算机系统等多个科目
* [ianw / bottomupcs](https://github.com/ianw/bottomupcs):Bottom Up Computer Science http://www.bottomupcs.com
* [wolverinn / Waking-Up](https://github.com/wolverinn/Waking-Up):计算机基础（计算机网络/操作系统/数据库/Git...）面试问题全面总结，包含详细的follow-up question以及答案
