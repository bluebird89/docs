# Computer

计算机分解成最原始的部件——晶体管。晶体管是一种半导体材料，其最重要的作用就是半导：可以通过电流的变化，实现电路的切换。比如计算机最基础的与或非运算，都可以通过晶体管组成的电子元件实现。而通过晶体管的电位差不同，就可以体现"二进制数据"，即0和1。再加上电容和电阻，就能把这种二进制数据临时保存起来。综合这些特性，大牛们发现把晶体管用作精密的数学计算，可以极大的提高运算的效率。比如我有2个电容，分别是充满电和没有电，对他们同时释放电信号，电容就会把其中的电子放出来，经过特定的逻辑电路，如与门，得到了0的结果。要计算1+1，实际上也是类似的原理。我先设计一个加法电路，把若干电容组合成的"数字"流过这个电路，把结果存入目标电容，就得到了结果。大规模的复杂运算以此类推。最早期的计算机真的就是用许多结晶体管实现的复杂电路结构，通过控制输入电流得到希望的输出结果。后来人们发现，这种计算可以用某些形式抽象成多种指令，不用针对每次计算设计复杂的电路，只要调用指令就可以实现任何一种计算组合，于是诞生了cpu。只有cpu，每次都要自己配置输入信号，实在太痛苦，就做了纸带输入给计算机。后来又发现纸带还是很麻烦，于是发明了输入终端和对应的存储设备。后来又发现很多数据要临时保存起来，供连续计算使用，于是发明了内存。再后来pc的发展经历了无数次的变革，让计算机一步步到了今天的地步，也就是你现在看到的这样。

* 设计模式
* 两门以上编程语言（强类型+弱类型)
* 形式语言与自动机

## 组成原理

* 理解冯诺依曼体系的结构，CPU和内存，硬盘，各种外设之间的关系，寄存器、缓存等知识。
* CPU有哪些指令，如何执行这些指令，如果实现数组，结构体，函数调用，这就涉及到汇编的知识。像原码，反码，补码，定点数、浮点数的表示和运算也是编程中必备的知识，几乎每种语言都要涉及。
* CPU中的缓存，缓存一致性协议，DMA的异步思想都会在应用层中有所体现
* 磁道 扇区
* CPU即处理器，是计算机中控制数据操控的电路
    - 算术/逻辑单元:执行运算
    - 控制单元:协调机器活动
    - 寄存器单元:临时存储,分为通用寄存器和专用寄存器
        + 通用寄存器用于临时存放CPU正在使用的数据
        + 专用寄存器用于CPU专有用途，比如指令寄存器和程序计数器
    - 通过控制单元能够操作主存中的数据
    - CPU将主存的指令加载进来解码并执行，其中涉及两个重要寄存器：指令寄存器与程序计数器。指令寄存器用于存储正在执行的指令，而程序计数器则保持下一个待执行的指令地址。
    - CPU向主存请求加载程序计数器指定的地址的指令，将其存放到指令寄存器中，加载后将程序计数器的值加2（假如指令长度为2个字节）。
    - 与其他设备的通信一般通过控制器来实现，控制器可能在主板上，也可能以电路板形式插到主板.现在随着通用串行总线（USB）成为通用的标准，很多外设都可以直接用USB控制器作为通信接口。每个控制器都连接在总线上，通过总线进行通信。
    - 直接存储器存取（DMA）是一种提升外设通信性能的措施，CPU并非总是需要使用总线，在总线空闲的时间里控制器能够充分利用起来。因为控制器都与总线相连接，而控制器又有执行指令的能力，所以可以将CPU的一些工作分给控制器来完成。比如在磁盘中检索数据时，CPU可以将告知控制器，然后由控制器找到数据并放到主存上，期间CPU可以去执行其他任务。这样能节省CPU资源。不过DMA会使总线通信更加复杂，而且会导致总线竞争问题。总线瓶颈源自冯诺依曼体系结构。

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
    - TCP可靠性传输原理，TCP/IP的协议细节， 三次握手，四次挥手，TCP状态转换。
* 网络状态
* 长连接
* 网络握手
* 滑动窗口
* 网络参数
    - 和应用层结合非常紧密的Socket知识和网络安全（对称加密，非对称加密，Hash, 数字签名，以及集大成者Https）
* 通信模型
* 序列化
* 分组交换

* 至于网络层的路由选择算法，链路层的各种协议
* I/O多路复用，涉及到同步/异步，阻塞/非阻塞，select/epoll

## 分布式

* 数据复制与一致性:
* CAP理论， BASE原则，幂等性, 2PC, TCC
* Paxos , Raft , Gossip
* 数据分片和路由:
* Hash分片：Hash取模（实际中非常常见的算法）， 虚拟桶（Redis使用），一致性Hash（memcached使用）
* 范围分片

## CPU缓存

* 新的CPU会有三级内存（L1，L2，L3 ）

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

```c++
int i  = 300;
int *p = &i
total = *p + 200;
```

## 图书

* 《深入理解计算机系统》
* 《Unix网络编程》

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

## 资源

* [Udacity](https://www.udacity.com/)
* [edX](https://www.edx.org/)
* [codecademy](https://www.codecademy.com/)
* [LeetCode](http://leetcode.com/):[中文](https://leetcode-cn.com/)
* [ossu/computer-science](https://github.com/ossu/computer-science):Path to a free self-taught education in Computer Science!
* [卡梅隆大学CS课件](http://www.cs.cmu.edu/~aada/courses/15251f16/www/schedule.html)
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

## 参考

* [wolverinn / Waking-Up](https://github.com/wolverinn/Waking-Up):计算机基础（计算机网络/操作系统/数据库/Git...）面试问题全面总结，包含详细的follow-up question以及答案
