# Computer

* 最原始的部件——晶体管。晶体管是一种半导体材料，其最重要的作用就是半导：可以通过电流的变化，实现电路的切换。比如计算机最基础的与或非运算，都可以通过晶体管组成的电子元件实现。而通过晶体管的电位差不同，就可以体现"二进制数据"，即0和1。再加上电容和电阻，就能把这种二进制数据临时保存起来。综合这些特性，大牛们发现把晶体管用作精密的数学计算，可以极大的提高运算的效率。比如有2个电容，分别是充满电和没有电，对他们同时释放电信号，电容就会把其中的电子放出来，经过特定的逻辑电路，如与门，得到了0的结果。要计算1+1，实际上也是类似的原理。先设计一个加法电路，把若干电容组合成的"数字"流过这个电路，把结果存入目标电容，就得到了结果。大规模的复杂运算以此类推。最早期的计算机真的就是用许多结晶体管实现的复杂电路结构，通过控制输入电流得到希望的输出结果。后来人们发现，这种计算可以用某些形式抽象成多种指令，不用针对每次计算设计复杂的电路，只要调用指令就可以实现任何一种计算组合，于是诞生了cpu。只有cpu，每次都要自己配置输入信号，实在太痛苦，就做了纸带输入给计算机。后来又发现纸带还是很麻烦，于是发明了输入终端和对应的存储设备。后来又发现很多数据要临时保存起来，供连续计算使用，于是发明了内存

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
* CPU内部封装了1个或者多个物理核，物理核有独立的各级缓存和电路结构，如果只有1个物理核心就是单核CPU，有多个物理核心就是多核CPU `物理核心数=总CPU数*单CPU中物理核心数`
* 超线程是intel于2002年发布的一种技术，全名为Hyper-Threading，简写为HT技术，超线程技术最初只是应用于至强系列处理器中，之后陆续应用在奔腾系列中并将技术主流化，业界对于HT的评价不一，但是官方并未放弃超线程技术
    - HT技术可使处理器中的1颗物理核，如同2颗物理核那样发挥作用，从而提高了系统的整体性能，但是肯定也不会真的像2颗物理核那样，要不然就违背物理规律了，只是说借助于某些技术将1颗物理核的性能发挥地更好而已
    - `开启HT: 逻辑核心数=总CPU数*单CPU中物理核心数*2`
* 多处理器架构
    - 对称多处理器结构 SMP Symmetric Multi-Processor:指多个CPU对称平等，共享相同的物理内存/IO等资源，因此SMP结构属于一致存储器访问结构 UMA
        + 共享模式下所有CPU平等地使用资源，模式简单，在CPU数量不多时效率很不错，但是优点也可能变为拦路虎。
        + 试想一种场景如果在SMP模式下为了提高服务器的处理能力，水平扩展了CPU数量，这些CPU通过相同的总线访问内存。随着CPU数量的增加，相同内存地址访问冲突将明显增加，间接造成了CPU资源浪费，相关实验证明，SMP服务器最好的情况是2-4个CPU
    - 非一致存储访问结构 NUMA Non-Uniform Memory Access:
        + 和SMP架构的显著区别在于是否是一致对等访问内存
        + 有多个 CPU 模块，每个 CPU 模块由多个 CPU组成，每个CPU模块具有独立的本地内存Local-Memory、 I/O等资源，可以将CPU模块称为Node
        + Node之间可以通过互联模块进行数据交互，因此每个 CPU 模块仍然可以访问整个系统的内存，但是此时的内存有本地和外部之分了，访问速度自然也就不一样
        + 访问CPU模块的本地内存将远远快于访问其他CPU模块内存，在明确这种架构带来的内存访问差异后，我们在实际开发应用程序时需要尽量减少不同 CPU 模块之间的信息交互
        + 缺陷，由于访问远地内存的延时远远超过本地内存，当 CPU 数量增加时，系统性能无法线性增加，换句话说增加1倍的CPU数量并不能获得1倍的性能提升，因此仍然存在扩展限制区
    - 海量并行处理结构 MPP Massive Parallel Processing:由多个 SMP 服务器通过一定的节点互联网络进行连接，完成相同的任务，可以看作是SMP的水平扩展
        + 多个 SMP 服务器是一种完全无共享Share Nothing)结构，因而扩展能力最好，典型的就是刀片服务器
* x86:性能好，但是耗电多、电压高，主要用于桌面电脑和服务器，生产厂商为 Intel 公司和 AMD 公司
* ARM:耗电小、电压低，但是单核性能不如 x86，主要用于移动设备
    - 商业模式是授权制。英国的 ARM 公司出售指令集的授权，购买授权的公司可以基于公版的设计，开发自己的 ARM 芯片。高通、三星、华为、苹果等公司的芯片，都属于这个模式
* 缓存
    - L3，多核共享
* 局部性原理
    - CPU 与内存之间往往集成了挺多层级的缓存，这些缓存越接近CPU，速度越快，所以如果能提前把内存中的数据加载到如下图中的 L1, L2, L3 缓存中，那么下一次 CPU 取数的话直接从这些缓存里取即可，能让CPU执行速度加快
    - 当某个元素被用到的时候，那么这个元素地址附近的的元素会被提前加载到 L1,L2,L3 缓存中,让内存一次性把目标区域附近的数据一起给cpu，存在这块区域，后面在需要用到的时候就先去这里找，找不到再去找内存要
    - 无论是内存还是磁盘，操作系统都是按页的大小进行读取的（页大小通常为 4 kb），磁盘每次读取都会预读，会提前将连续的数据读入内存中，这样就避免了多次 IO
* 乱序执行：在等待的时间里把后续指令需要的数据（或者不依赖前者的操作）提前处理到缓存中来
    - 分支预测：遇到分支跳转时，按照之前的经验，如果某个分支经常被执行，那后续再去这个分支的概率一定很大，那这样咱们预测后面会去到这个分支，就提前把这个分支后面指令能做的工作先做了

## 内存

* 程序只能在内存中运行
* 一个个电容所代表的0和1 ，由于这些电容不能持久地保持电荷，得定期地去刷新，如果不及时刷新，那些0和1的数据就会丢失
* 最小的一个格子就是一个bit ，只能存储0和1。8个bit 称为一个字节(Byte) 0～255 4个byte= 1 word
* 次序：大端（从左到右） 小端（从右到左）
* 编译器：允许用变量的方式来表达程序，可以把这些变量转换成地址
* 信息=位+上下文
* 指针
* Linux内存管理中通过MMU的硬件实现虚拟地址到物理地址的转换，但是每次都这样转换势必造成性能的损耗，所以采用了缓存组件TLB来缓存最近使用的虚拟地址到物理地址的映射

```c++
int i  = 300;
int *p = &i
total = *p + 200;
```

## 磁盘

* 页缓存：操作系统用来作为磁盘的一种缓存，减少磁盘的I/O操作
    - 写入磁盘：其实是写入页缓存中，使得对磁盘的写入变成对内存的写入。写入的页变成脏页，然后操作系统会在合适的时候将脏页写入磁盘中
        + 后写：写入的页缓存，这样存着可以将一些小的写入操作合并成大的写入，然后再刷盘
    - 读取：如果页缓存命中则直接返回，如果页缓存 miss 则产生缺页中断，从磁盘加载数据至页缓存中，然后返回数据
        + 读的时候会预读，根据局部性原理当读取的时候会把相邻的磁盘块读入页缓存中
* 顺序读写：磁头几乎不用换道，或者换道的时间很短
    - 顺序写盘的速度比随机写内存还要快
    - 当然这样的写入存在数据丢失的风险，例如机器突然断电，那些还未刷盘的脏页就丢失了。不过可以调用 fsync 强制刷盘，但是这样对于性能的损耗较大
    - 建议通过多副本机制来保证消息的可靠，而不是同步刷盘

## 图书

* 《深入理解计算机系统》

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
* 专业课代号 408 的计算机基础综合。这门专业课包含：数据结构、计算机组成原理、计算机网路、操作系统
    - 理论知识不一定马上能用于项目上，但当与人讨论起某个技术问题时能够知道它深层次的原因，看问题的角度会更加全面和系统
    - 数据结构 
        + 《数据结构》 清华大学出版社 
        + 《算法与数据结构考研试题精析（第二版）》
    - 计算机组成原理  
        + 《计算机组成原理》唐朔飞 高等教育出版社 
        + 《计算机组成原理考研指导》徐爱萍 清华大学出版社 
        + 《计算机组成原理--学习指导与习题解答》唐朔飞 高等教育出版社  
    - 操作系统 
        + 《计算机操作系统(修订版)》汤子瀛 西安电子科技大学出版社  
        + 《操作系统考研辅导教程(计算机专业研究生入学考试全真题解) 》电子科技大学出版社 
        + 《操作系统考研指导》清华大学出版社 
    - 计算机网络 
        + 《计算机网络(第五版)》谢希仁 电子工业出版社  
        + 《计算机网络知识要点与习题解析》哈尔滨工程大学出版社 
    - 视频
        + 武汉大学 —— 数据结构 MOOC 网络课程
        + 华中科技大学 —— 计算机组成原理
        + 电子科技大学 —— 计算机组成原理
        + 华中科技大学 —— 操作系统原理
        + 哈尔滨工业大学 —— 计算机网络

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
