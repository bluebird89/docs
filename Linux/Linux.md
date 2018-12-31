# [torvalds/linux](https://github.com/torvalds/linux): Linux kernel source tree

以Ubuntu为主要使用系统，不用修改hosts can access google

UNIX/Linux 本身是没有图形界面的，我们通常在 UNIX/Linux 发行版上看到的图形界面实际都只是运行在 Linux 系统之上的一套软件,而 Linux 上的这套软件以前是 XFree86，现在则是 xorg（X.Org），而这套软件又是通过 X 窗口系统（X Window System，也常被称为 X11 或 X）实现的，X 本身只是工具包及架构协议，而 xorg 便是 X 架构规范的一个实现体，也就是说它是实现了 X 协议规范的一个提供图形界面服务的服务器，就像实现了 http 协议提供 web 服务的 Apache 。如果只有服务器也是不能实现一个完整的桌面环境的，当然还需要一个客户端，我们称为 X Client，像如下几个大家熟知也最流行的实现了客户端功能的桌面环境 KDE，GNOME，XFCE，LXDE 。

Linux 是一个可以实现多用户登陆的操作系统，多用户可以同时登陆同一台主机，共享主机的一些资源，不同的用户也分别有自己的用户空间，可用于存放各自的文件。虽然不同用户的文件是放在同一个物理磁盘上的甚至同一个逻辑分区或者目录里，但是由于 Linux 的用户管理和 文件权限机制，不同用户不可以轻易地查看、修改彼此的文件。

## Linux vs Unix

### Unix

> Unix的历史起始于二十世纪六十年代的AT&T贝尔实验室，在那时，一小组程序员正在为PDP-7编写多任务、多用户操作系统。在贝尔实验室研究机构的这个小组里有两位最知名的人物，ken Thompson和Dennis Ritchie。
> 尽管Unix的许多概念继承于它的先驱Multics，但在二十世纪八十代早期Unix小组用C语言重写这个小型操作系统的决定使得Unix与其它的系统区别开来。那个时候的操作系统很少是可移植的。相反，由于先天的设计和底层源语言，那些操作系统和所被授权运行的硬件平台紧密地联系在一起。
> 通过使用C语言重构Unix，现在Unix可以被移植到许多硬件平台。

> 除了这个新的可移植移能力，有几个对于用户和程序员来说很有吸引力的操作系统设计的关键点使得Unix扩张到除贝尔实验室以外的其它领域，如研究、学术甚至商业用途。
> 关键点一，Ken Thompson的Unix哲学成为了模块化软件设计和计算的强有力的典范。
> Unix哲学建议使用小规模的为特定目的构建的程序的结合体来处理复杂的总体任务。由于Unix是围绕着文件和管道设计的，这个"piping（管道)“模型至今仍然很流行，它把程序的输入和输出链接在一起作为一系列的线性输入操作。实际上，当今的函数即服务（FaaS）/无服务器计算模型要更多地归功于对Unix哲学的继承。

> 在20世纪70和80年代末，Unix成为了族谱的根，族谱扩展到研究届、学术届和不断增长的商业Unix操作系统业务。Unix不是开源软件，Unix源码可以与它的拥有者AT&T通过协议获得许可证。第一个已知的软件许可证在1975年卖给了伊利诺伊大学。
>
> Unix在学术界发展迅速，随着伯克利成为重要的活动中心，在70年代给了Ken Thompson一个学术休假。通过在伯克利的Unix的所有活动，一个新的Unix软件支付诞生了：伯克利软件发行版，或者叫BSD。最初，BSD并不是AT&T的Unix的代替品，而是附加软件和功能附加品。直到1979年的2BSD（第二Berkeley软件发型版），伯克利研究生Bill Joy已经添加了现在知名的程序，例如vi和C shell（/bin/csh）。
>
> 除了BSD，它成为了Unix家族中最受欢迎的分支之一，Unix的商业产品在20世纪80年代和90年代激增，包括HP-UX、IBM的AIX、Sun的Solaris、Sequent和Xenix。随着分支从最初的根开始增长，“Unix战争”开始了，标准化成为了社区的一个新焦点。POSIX标准诞生于1988年，以及其他开源工作组的标准化工作一直进行到到20世纪90年代。
>
> BSD可能是当今所有现代Unix系统中最大的安装基础。此外，在最近的历史中，每一个苹果Mac硬件单元搭载的系统都可以被称为BSD，因为它的OS X（现在的macOS）操作系统是一个BSD-派生。
>

### Linux

> Linux操作系统实际上是90年代初期的两个成果的组合。
>
> Richard Stallman希望创建一个作为替代私有Unix系统的真正免费的和开源的系统。他正在以GNU的名义开发实用工具和程序，这是一种递归算法，意思是“GNU不是Unix！” 虽然它有一个内核项目正在进行，但结果证实开展起来很困难，这样没有内核，免费并开源操作系统的梦想就无法实现。
>
> Linus Torvald的工作 - 编写出一种可工作的和可行的内核，被他称为Linux--整个操作系统因此而诞生。鉴于Linus使用的是多种GNU工具（例如GNU编译器集合或GCC），GNU工具和Linux内核的结合是天生的绝配。
>
> Linux发行版使用GNU提供的组件、Linux内核，MIT的X-Windows GUI以及其他可以在开源BSD许可下使用的BSD组件来实现。像Slackware和Red Hat这样的发行版的早期流行给了上世纪90年代的“普通PC用户”使用Linux操作系统的机会，以及他们在工作或学术生活中使用的许多专有的Unix系统功能和实用工具。
>
> 在免费和开源组件之上提供支持的商业Linux产品变得可行，因为包括IBM在内的许多企业都从专有的Unix迁移到在Linux上提供中间件和软件解决方案。Red Hat在Red Hat Enterprise Linux周围建立了一个商业支持模型，德国供应商SUSE Linux Enterprise Server（SLES）也是如此。

### 对比

* 相似
  - 用户体验角度来讲，没有太多区别！Linux的大部分优点包括操作系统可跨多硬件架构（包括现代PC）特性，以及能够让Unix系统的管理员和用户使用他们熟悉的工具的能力。
  - 在Unix上编写的软件可以在Linux操作系统上编译，而在移植方面不用花费太多的功夫。
  - 作为把Linux作为主要目标的开发平台，macOS设备和操作系统的普及，可能归功于类BSD的macOS操作系统。很多Linux系统工具和脚本可以简单地在macOS终端运行。很多在Linux上可用的开源软件组件也可以在macOS上使用，如Homebrew。
* 区别
  - 开源vs私有，授权软件
    + Unix发行版中缺少通用内核对软件和硬件供应商都有影响。由于Unix家族的商业和学术分支，供应商可能不得不为不同版本的Unix开发不同的驱动，而且作为很多不同版本的Unix的二进制设备驱动，对这些软件的SDK或者发行版本的访问，也会让他们有授权和其他方面的担忧。
    + 对于Linux，供应商可以为特定硬件设备创建设备驱动，并有理由预计，它可以在大多数发行版中运行。
* Unix树的BSD分支是开源的，而NetBSD、OpenBSD和FreeBSD都有强大的用户群和开源社区
* Linux 已经显示出超越专有 Unix 的显著优势在于其在大量硬件平台和设备上的可用性。 Raspberry Pi 受到业余爱好者和发烧友的欢迎，它是 Linux 驱动的，为运行 Linux 的各种物联网设备打开了大门。 我们已经提到了 Android 设备，汽车（包括Automotive Grade Linux）和智能电视，其中Linux占有很大的市场份额。 这个星球上的每个云提供商都提供运行Linux的虚拟服务器，而且当今许多最受欢迎的云本地堆栈都是基于 Linux 的，无论您是在谈论容器运行时还是Kubernetes，还是许多无服务器的平台都越来越受欢迎。
* 最显着的趋势是近年来微软的转变。 如果你十年前告诉软件开发人员，Windows操作系统将在2016年“运行Linux”，他们中的大多数人会歇斯底里地笑了。 但是Windows Linux子系统（WSL）的存在和普及，以及最近宣布的诸如Docker的Windows端口（包括Windows上的Linux容器）支持等功能都证明了Linux具有的影响

### 版本

* 入门：类似Windows的体验；安装简单；可靠；“类似Linux”，且不自成一派；“恰好管用”；
  - Linux Mint Download
  - Debian Download
* 进阶：完全掌控你的电脑和操作系统；了解Linux内部；精简的优化系统
  - Slackware Linux
  - [Arch Linux](https://www.archlinux.org/)
  - Gentoo Linux
  - FreeBSD
* 安全与稳定：为学习最新的东西而甘冒风险；最新和最伟大的功能；有趣的配置以便于处理重大更改
  - Arch Linux
  - OpenSuse Tumbleweed
  - Fedora Rawhide
  - Gentoo Unstable
* 正常：运行平稳，维护量低；最小配置；大部分事情可以自动完成；兼容硬件和软件
  - Debian Download
  - Fedora
  - openSuse Leap
  - Ubuntu Studio
* 服务器：稳定性；安全；支持其他出于同样原因的程序员使用
  - CentOS
  - Red Hat Enterprise Linux (RHEL)
  - Debian 9 Download
  - FreeBSD
* 性能：显著的性能提升；高负载计算
  - Clear Linux  (For Intel CPUS, by Intel)
  - Gentoo Linux
  - Arch Linux
  - FreeBSD
* 桌面：安全性；匿名性
  - TAILS Linux
  - Alpine Linux
  - CoreOS
  - TENS Linux (DOD Project)
  - Tin Hat Linux
  - OpenBSD
* 最小化：将在旧的硬件上运行；尽可能最小化
  - ArchBang
  - Lubuntu
  - Puppy Linux
  - Tiny Core Linux
  - Bodhi Linux
* Canonical的Ubuntu、Debian
* SUSE Linux Enterprise Server

## 组成

Linux内核处于用户进程和硬件之间，包括系统调用接口和Linux内核子系统。除系统调用外，由五个主要的子系统组成：

* 进程调度：它控制着进程对CPU的访问，当需要选择一个进程开始运行时，由调度程序选择最应该运行的进程；
* 内存管理：它允许多个进程安全地共享主内存区域，支持虚拟内存；从逻辑上可以分为硬件无关的部分和硬件相关的部分；
* 虚拟文件系统(VFS)：它隐藏了各种不同硬件的具体细节，为所有设备提供统一的接口，支持多达数十种不同的文件系统，分为逻辑文件系统和设备驱动程序；
* 网络：它提供了对各种网络标准协议的存取和各种网络硬件的支持，分为网络协议和网络驱动程序两部分；
* 进程间通信：支持进程间各种通信机制，包括共享内存、消息队列和管道等。

## 内存

* 地址概念
  * 将主板上的物理内存条所提供的内存空间定义为物理内存空间，其中每个内存单元的实际地址就是物理地址；
  * 将应用程序员看到的内存空间定义为虚拟地址空间(或地址空间)，其中的地址就叫做虚拟地址(或虚地址)，一般用“段:偏移量”的形式来描述，如A815:CF2D；
  * 线性地址空间是指一段连续的、不分段的、范围为0~4GB的地址空间，一个线性地址就是线性地址空间的一个绝对地址。
* 虚地址转换为物理地址：在保护模式下，内存管理单元(MMU)由一个或一组芯片组成，其功能是指虚拟地址映射为物理地址，即进行地址转换；MMU是一种硬件电路，它包含分段部件和分页部件两个部件，分别叫做分段机制和分页机制
  - 分段机制是把一个虚拟地址转换为线性地址
  - 分页机制是把一个线性地址转换为物理地址。
  - 32位线性地址空间要采用两级页表：页表是把线性地址映射到物理地址的一种数据结构，4GB的线性空间可以被划分为1M个4KB大小的页，每个页表项占4字节，则1M个页表项的页表就需要占用4MB空间，而且还要求是连续的，于是采用两级页表来实现；两级页表就是对页表再进行分页，第一级称为页目录，其中存放关于页表的信息；4MB的页表再次分页，可以分为1K个4KB大小的页
* 页面高速缓存自动保留处理器最近使用的32项页表项，因此可以覆盖128KB范围的内存；
* Linux主要采用分页机制来实现虚拟存储器管理，原因为：
  - Linux的分段机制使得所有的进程都使用相同的段寄存器，这使得内存管理变得简单；
  - Linux的设计目标之一就是能够被移植到绝大多数流行的处理平台上，但许多RISC处理器支持的分段功能非常有限；为了保证可移植性，Linux采用三级分页模式，因为许多处理器都采用64位结构；Linux定义了三种类型的页表：页目录(PGD)、中间目录(PMD)和页表(PT)。
* 请求调页
  - 如果被访问的页不在内存，也就是说，这个页还没有被存放在任何一个物理页面中，那么，内核分配一个新的页面并将其适当地初始化，这种技术称为“请求调页”；
  - “请求调页”是一种动态内存分配技术，它将页面的分配推迟到不能再推迟为止，也就是说，一直推迟到进程要访问的页不在物理内存时为止，由此引起一个缺页异常；该技术的引入主要是因为进程开始运行时并不访问其地址空间中的全部地址。
* `free -m`: 可用的memory=free memory+buffers+cached

## 进程

* 程序是一个普通文件，是机器代码指令和数据的集合，这些指令和数据存储在磁盘上的一个可执行映像中，可执行映像(executable image)就是一个可执行文件的内容；
* 进程代表程序的执行过程，它是一个动态的实体，随着程序中指令的执行而不断地变化，在某个时刻进程的内容被称为进程映像(process image)；
* 程序的执行过程可以说是一个执行环境的总和，这个执行环境除了包括程序中各种指令和数据外，还有一些额外数据；而执行环境的动态变化体现了程序的运行，为了对动态变化的过程进行描述，就引入了“进程”概念。
* 进程控制块：对进程的描述结构叫做task_struct，将这样的数据结构称作进程控制块(PCB)
  - PCB是一个其域多达80多项的相当庞大的数据结构，按其功能将所有域划分为：状态信息，链接信息、各种标识符、进程间通信信息、时间和定时器信息、调度信息、文件系统信息、虚拟内存信息和处理器环境信息
  - 组织方式有：进程链表、散列表、可运行队列和等待队列
* 内核状态
  - 运行态、就绪态和阻塞态(或等待态)
  - 四种可能的转换关系：运行态->阻塞态、运行态->就绪态、就绪态->运行态和阻塞态->就绪态
  - 将就绪态和运行态合并为一个状态—可运行态，再包括其它方面的一些改变，将进程状态划分为：可运行态、睡眠(或等待)态(分为深度睡眠态和浅度睡眠态)、暂停状态和僵死状态。
* 调度算法
  - 时间片轮转调度算法、优先级调度算法(非抢占式优先级算法和抢占式优先级算法)、多级反馈队列调度算法和实时调度算法；
  - 考虑因素：考虑五个方面：公平、高效、响应时间、周转时间和吞吐量
* 进程的地址空间划分为“内核空间”和“用户空间”
  - Linux的虚拟地址空间的大小为4GB，内核将这4GB的空间分为两部分，较高的1GB(虚地址0xC0000000到0xFFFFFFFF)供内核使用，称为“内核空间”；
  - 而较低的3GB(虚地址0x00000000到0xBFFFFFFF)供各个进程使用，称为“用户空间”；
  - 因为每个进程可以通过系统调用进入内核，因此，内核空间由系统内的所有进程共享；
  - 于是，从具体进程的角度来看，每个进程都可以拥有4GB的虚拟地址空间(也叫做虚拟内存)。

## 中断

* 中断控制是为克服对I/O接口采用程序查询控制服务方式所带来的处理器低效率而产生的，它的主要优点是只有在I/O接口需要服务时才能得到处理器的响应，而不需要处理器不断地进行查询；因此，最初的中断全部是对外部设备而言的，称为外部中断(或硬件中断)；
* 中断分为外部可屏蔽中断(INTR)和外部非屏蔽中断(NMI)
  - 所有I/O设备产生的中断请求(IRQ)均引起可屏蔽中断
  - 紧急事件(如硬件故障)引起的故障则产生非屏蔽中断；
* 异常也叫做内部中断，它是为解决机器运行时所出现的某些随机事件及编程的方便而出现的；
* 异常又分为故障(fault)和陷阱(trap)，它们的共同特点是既不使用中断控制器，又不能被屏蔽(异常其实是CPU发出的终端信号)。
* 为使处理器可以容易地识别每种中断源，将256种向量中断从0到255进行编号，即赋以一个中断类型码n，把这个8位的无符号整数叫做向量，即中断向量。256个中断向量的分配如下
  - 编号为0~31的向量对应于异常和非屏蔽中断；
  - 编号为32~47的向量(即由I/O设备引起的中断)分配给可屏蔽中断；
  - 剩余的、编号为48~255的向量用来标识软中断；Linux只用其中的一个(即128或0x80向量)来实现系统调用
* 中断描述符表：在实地址模式下，CPU将内存中从0开始的1KB空间作为一个中断向量表，表中每个表项占4个字节；但在保护模式，由4个字节的表项构成的中断向量表满足不了要求；因此在保护模式下，中断向量表中的表项由8个字节组成，中断向量表也改称为中断描述符表(IDT)；
* IDT中的每个表项叫做一个门描述符(gate descriptor)。门描述符中类型码占3位，表示门描述符的类型，主要分为以下几类：
  - 中断门(interrupt gate)：其类型码为110，包含了一个中断或异常处理程序所在段的选择符和段内偏移量；
  - 陷阱门(trap gate)：其类型码为111；
  - 系统门(system gate)：是Linux内核特别设置的，用来让用户态的进程访问陷阱门。

## 系统调用

* 操作系统为用户态的进程与硬件设备(如CPU、磁盘和打印机等)之间的交互提供了一组接口，这些接口使得程序更具有可移植性，因为不同的操作系统只要所提供的一组接口相同，那么在这些操作系统之上就可以正确地编译和执行相同的程序，这组接口就是所谓的“系统调用”；
* 引入系统调用的原因有：
  - 这使得编程更加容易；
  - 这极大地提高了系统的安全性；
  - 最重要的一点，这些接口使得操作系统更具有可移植性。

## 内核同步

- 临界区(critical regions)就是访问和操作共享数据的代码段，多个内核任务并发访问同一个资源通常是不安全的；
- 如果两个内核任务可能处于同一个临界区，就是一种错误现象；如果确实发生了这种情况，就称它为竞争状态；
- 避免并发和防止竞争状态称为同步(synchronization)。
- 死锁
  - 包括自死锁和ABBA死锁，
  - 产生死锁有四个原因：互斥使用、不可抢占、请求和保持，以及循环等待；
  - 避免死锁的方法有：破坏“不可剥夺”条件、破坏“请求和保持”条件、破坏“循环等待”条件。
- 并发执行：“伪并发”和“真并发”
  - 中断：它可能随时打断当前正在执行的代码；
  - 内核抢占：内核中的任务可能会被另一个任务抢占；
  - 睡眠及其与用户空间的同步：在内核执行的进程可能会睡眠，这就会唤醒调度程序，调度一个新的用户进程执行；
  - 对称多处理：两个或多个处理器可以同时执行代码。
- 信号量：是一种睡眠锁，它是1968年由Dijkstra提出的，如果一个任务试图获得一个已被持有的信号量，信号量会将其推入等待队列，然后让其睡眠；当持有信号量的进程将信号量释放后，在等待队列中的一个任务将被唤醒，从而可以获得这个信号量；
  - 信号量支持两个原子操作P()和V()，前者叫做测试操作，后者叫做增加操作；后来的系统把这两种操作分别叫做down()和up()；
  - down()操作通过对信号量计数减1来请求获得一个信号量；up()操作用来释放信号量，该操作也被称作“提升”(upping)信号量，因为它会增加信号量的计数值。

## 文件系统

文件是一个抽象的概念，它是存放一切数据或信息的仓库；Linux的目录树结构为：根目录(/)在上，其它的平行在下；
Windows操作系统也是采用树型结构，但其树型结构的根是磁盘分区的盘符，有几个分区就有几个树型结构，它们之间的关系式并列的；而在Linux中，无论操作系统管理几个磁盘分区，这样的目录树只有一个；
原因是：Linux是一个多用户系统，制定这样一个固定的目录规划有助于对系统文件和不同的用户文件进行统一管理；
Linux 文件系统是一个目录树的结构，文件系统结构从一个根目录开始，根文件系统所占空间一般应该比较小，因为其中的绝大部分文件都不需要经常改动，而且包括严格的文件和一个小的 不经常改变的文件系统不容易损坏。除了可能的一个叫/vmlinuz标准的系统引导映像之外，根目录一般不含任何文 件

* /：每台机器都有根文件系统，它包含系统引导和使其他文件系统得以mount所必要的文件，根文件系统应该有单用户状态所必须的足够的内容。还应该包括修复损坏 系统、恢复备份等的工具。
* /bin：包含了引导启动所需的命令或普通用户可能用的命令(可能在引导启动后),都是二进制可执行命令。多是系统中重要的系统文件
* /boot：目录存放引导加载器(bootstrap loader)使用的文件，如lilo，核心映像也经常放在这里，而不是放在根目录中。但是如果有许多核心映像，这个目录就可能变得很大，这时使用单独的 文件系统会更好一些。还有一点要注意的是，要确保核心映像必须在ide硬盘的前1024柱面内。
* /dev：存放了设备文件，即设备驱动程序，用户通过这些文件访问外部设备。比如，用户可 以通过访问/dev/mouse来访问鼠标的输入，就像访问其他文件一样。
  - /dev/console：系统控制台，也就是直接和系统连接的监视器。
  - /dev/hd：ide硬盘驱动程序接口。如：/dev/hda指的是第一个硬 盘，had1则是指/dev/hda的第一个分区。如系统中有其他的硬盘，则依次为/dev /hdb、/dev/hdc、. . . . . .；如有多个分区则依次为hda1、hda2 . . . . . .
  - /dev/sd：scsi磁盘驱动程序接口。如系统有scsi硬盘，就不会访问/dev/had， 而会访问/dev/sda。
  - /dev/fd：软驱设备驱动程序。如：/dev/fd0指 系统的第一个软盘，也就是通常所说的a盘，/dev/fd1指第二个软盘，. . . . . .而/dev/fd1 h1440则表示访问驱动器1中的4.5高密盘。
  - /dev/st：scsi磁带驱动器驱动程序。
  - /dev/tty：提供虚拟控制台支持。如：/dev/tty1指 的是系统的第一个虚拟控制台，/dev/tty2则是系统的第二个虚拟控制台。
  - /dev/pty：提供远程登陆伪终端支持。在进行telnet登录时就要用到/dev/pty设 备。
  - /dev/ttys：计算机串行接口，对于dos来说就是“com1”口。
  - /dev/cua：计算机串行接口，与调制解调器一起使用的设备。
  - /dev/null：“黑洞”，所有写入该设备的信息都将消失。例如：当想要将屏幕 上的输出信息隐藏起来时，只要将输出信息输入到/dev/null中即可。
* /etc：系统管理和配置文件。
  * /etc/rc或者/etc/rc.d：启动、或改变运行级时运行的脚本或脚本的目录。系统初始化文件
  * /etc/passwd：用户数据库，其中的域给出了用户名、真实姓名、用户起始目 录、加密口令和用户的其他信息。
  - /etc/fdprm：软盘参数表，用以说明不同的软盘格式。可用setfdprm进 行设置。更多的信息见setfdprm的帮助页。
  - /etc/fstab：指定启动时需要自动安装的文件系统列表。也包括用swapon -a启用的swap区的信息。
  - /etc/group：类似/etc/passwd ，但说明的不是用户信息而是组的信息。包括组的各种数据。
  - /etc/inittab：init 的配置文件。
  - /etc/issue：包括用户在登录提示符前的输出信息。通常包括系统的一段短说明 或欢迎信息。具体内容由系统管理员确定。
  - /etc/magic：“file”的配置文件。包含不同文件格式的说 明，“file”基于它猜测文件类型。
  - /etc/motd：motd是message of the day的缩写，用户成功登录后自动输出。内容由系统管理员确定。常用于通告信息，如计划关机时间的警告等。
  - /etc/mtab：当前安装的文件系统列表。由脚本(scritp)初始化，并由 mount命令自动更新。当需要一个当前安装的文件系统的列表时使用(例如df命令)。
  - /etc/shadow：在安装了影子(shadow)口令软件的系统上的影子口令 文件。影子口令文件将/etc/passwd文件中的加密口令移动到/etc/shadow中，而后者只对超级用户(root)可读。这使破译口令更困 难，以此增加系统的安全性。
  - /etc/login.defs：login命令的配置文件。
  - /etc/printcap：类似/etc/termcap ，但针对打印机。语法不同。
  - /etc/profile 、/etc/csh.login、/etc/csh.cshrc：登 录或启动时bourne或cshells执行的文件。这允许系统管理员为所有用户建立全局缺省环境。
  - /etc/securetty：确认安全终端，即哪个终端允许超级用户(root) 登录。一般只列出虚拟控制台，这样就不可能(至少很困难)通过调制解调器(modem)或网络闯入系统并得到超级用户特权。
  - /etc/shells：列出可以使用的shell。chsh命令允许用户在本文件 指定范围内改变登录的shell。提供一台机器ftp服务的服务进程ftpd检查用户shell是否列在/etc/shells文件 中，如果不是，将不允许该用户登录。
  - /etc/termcap：终端性能数据库。说明不同的终端用什么“转义序列”控 制。写程序时不直接输出转义序列(这样只能工作于特定品牌的终端)，而是从/etc/termcap中查找要做的工作的 正确序列。这样，多数的程序可以在多数终端上运行。
  - /etc/apt/sources.list：软件源管理
* /home：用户主目录的基点
  * 比如用户user的主目录就是/home/user，可以用~user表示。
  * /root：系统管理员的主目录。
* /lib：标准程序设计库，又叫动态链接共享库及内核模块，作用类似windows里的.dll文件。根文件系统上的程序所需的共享库，这些文件包含了可被许多程序共享的代码，以避免每个程序都包含有相同的子程序的副本，故可以使得可执行文件变得更小，节省空间。
  - /lib/modules目录包含系统核心可加载各种模块，尤其是那些在恢复损坏的系统时重 新引导系统所需的模块(例如网络和文件系统驱动)。
* /mnt：系统管理员临时安装(mount)文件系统的安装点。程序并不自动支持安装到/mnt 。/mnt下面可以分为许多子目录，例如/mnt/dosa可能是使用 msdos文件系统的软驱，而/mnt/exta可能是使用ext2文件系统的软驱，/mnt/cdrom光 驱等等。
* opt：额外安装的可选应用程序包所放置的位置，刚才装的测试版firefox，就可以装到/opt/firefox_beta目录下，/opt/firefox_beta目录下面就包含了运 行firefox所需要的所有文件、库、数据等等。要删除firefox的时候，你只需删除/opt/firefox_beta目录即可，非常简单。
  - /proc：虚拟的目录，是系统内存的映射。可直接访问这个目录来获取系统信息。
  - /proc/x：关于进程x的信息目录，这x是这一进程的标识号。每个进程在 /proc下有一个名为自己进程号的目录。
  - /proc/cpuinfo：存放处理器(cpu)的信息，如cpu的类型、制造商、 型号和性能等。
  - /proc/devices：当前运行的核心配置的设备驱动的列表。
  - /proc/dma：显示当前使用的dma通道。
  - /proc/filesystems：核心配置的文件系统信息。
  - /proc/interrupts：显示被占用的中断信息和占用者的信息，以及被占用 的数量。
  - /proc/ioports：当前使用的i/o端口。
  - /proc/kcore：系统物理内存映像。与物理内存大小完全一样，然而实际上没有 占用这么多内存；它仅仅是在程序访问它时才被创建。(注意：除非你把它拷贝到什么地方，否则/proc下没有任何东西占用任何磁盘空间。)
  - /proc/kmsg：核心输出的消息。也会被送到syslog。
  -  /proc/ksyms：核心符号表。
  -  /proc/loadavg：系统“平均负载”；3个没有意义的指示器指出系统当前 的工作量。
  -  /proc/meminfo：各种存储器使用信息，包括物理内存和交换分区 (swap)。
  -  /proc/modules：存放当前加载了哪些核心模块信息。
  -  /proc/net：网络协议状态信息。
  -  /proc/self：存放到查看/proc的 程序的进程目录的符号连接。当2个进程查看/proc时，这将会是不同的连接。这主要便于程序得到它自己的进程目录。
  -  /proc/stat：系统的不同状态，例如，系统启动后页面发生错误的次数。
  -  /proc/uptime：系统启动的时间长度。
  -  /proc/version：核心版本。
* /sbin：系统管理命令，也用于存储二进制文件。这里存放的是系统管理员使用的管理程序，只有root才能访问
* /tmp：存放程序在运行时产生的信息和数据。但在引导启动后，运行的程序最好使用/var/tmp来 代替/tmp，因为前者可能拥有一个更大的磁盘空间。
* /usr：最庞大的目录，要用到的应用程序和文件几乎都在这个目录，所有命令、库、man页和其他一般操作中所需的不改变的文件（节省了磁盘空间，且易于管理）。
  * 比较重要的目录/usr/local 本地管理员软件安装目录
  * /usr/x11r6：存放x window的目录。
  * /usr/bin：众多的应用程序。
  * /usr/sbin：超级用户的一些管理程序。
  * /usr/doc：linux文档。
  * /usr/include：linux下开发和编译应用程序所需要的头文件。
  * /usr/lib：常用的动态链接库和软件包的配置文件。
  * /usr/man：帮助文档。
  * /usr/src：源代码，linux内核的源代码就放在/usr/src/linux 里。
  * /usr/local下一般是你安装软件的目录，这个目录就相当于在windows下的programefiles这个目录
  * /usr/local/bin：本地增加的命令。
  * /usr/local/lib：本地增加的库根文件系统。
* /var：某些大文件的溢出区，包含会改变的文件，比如spool目录(mail、news、打印机等用的)， log文件、 formatted manual pages和暂存文件。传统上/var 的所有东西曾在 /usr 下的某个地方，但这样/usr 就不可能只读安装了。
  - /var/catman：包括了格式化过的帮助(man)页。帮助页的源文件一般存在 /usr/man/catman中；有些man页可能有预格式化的版本，存在/usr/man/cat中。而其他的man页在第一次看时都需要格式化，格 式化完的版本存在/var/man中，这样其他人再看相同的页时就无须等待格式化了。(/var/catman经常被 清除，就像清除临时目录一样。)
  - /var/lib：存放系统正常运行时要改变的文件。
  - /var/local：存放/usr/local中 安装的程序的可变数据(即系统管理员安装的程序)。注意，如果必要，即使本地安装的程序也会使用其他/var目录，例如/var/lock 。
  - /var/lock：锁定文件。许多程序遵循在/var/lock中 产生一个锁定文件的约定，以用来支持他们正在使用某个特定的设备或文件。其他程序注意到这个锁定文件时，就不会再使用这个设备或文件。
  - /var/log：各种程序的日志(log)文件，尤其是login (/var/log/wtmplog纪 录所有到系统的登录和注销) 和syslog (/var/log/messages 纪录存储所有核心和系统程序信息)。/var/log 里的文件经常不确定地增长，应该定期清除。
  - /var/run：保存在下一次系统引导前有效的关于系统的信息文件。例如，/var/run/utmp包 含当前登录的用户的信息。
  - /var/spool：放置“假脱机(spool)”程序的目录，如mail、 news、打印队列和其他队列工作的目录。每个不同的spool在/var/spool下有自己的子目录，例如，用户的邮箱就存放在/var/spool/mail 中。
  - /var/tmp：比/tmp允许更大的或需要存在较长时间的临时文件。注意系统管理 员可能不允许/var/tmp有很旧的文件。
* /lost+found：这个 目录平时是空的，系统非正常关机而留下“无家可归”的文件就在这里。

## GNU

* GNU是GNU is Not Unix的递归缩写，是自由软件基金会(Free Software Foundation，FSF)的一个项目，该项目已经开发了许多高质量的编程工具，包括emacs编辑器、著名的GNU C和C++编译器(gcc和g++)；
* Linux的开发使用了许多GNU工具，Linux系统上用于实现POSIX.2标准的工具几乎都是由GNU项目开发的；Linux内核、GNU工具以及其它一些自由软件组成了人们常说的Linux系统或Linux发布版。

## 环境变量

每个进程都有其各自的环境变量设置，且默认情况下，当一个进程被创建时，处理创建过程中明确指定的话，它将继承其父进程的绝大部分环境设置。Shell 程序也作为一个进程运行在操作系统之上，而我们在 Shell 中运行的大部分命令都将以 Shell 的子进程的方式运行。

* 永久的：需要修改配置文件，变量永久生效； /etc/bashrc 存放的是 shell 变量 `echo "PATH=$PATH:/home/shiyanlou/mybin" >> .zshrc`
* .profile（不是/etc/profile） 只对当前用户永久生效，所以如果想要添加一个永久生效的环境变量，只需要打开 /etc/profile
* 环境变量理解生效 `source .zshrc` `. ./.zshrc`
* 临时的：使用 export 命令行声明即可，变量在关闭 shell 时失效。`PATH=$PATH:/home/zhangwang/mybin`给 PATH 环境变量追加了一个路径，它也只是在当前 Shell 有效，一旦退出终端，再打开就会发现又失效了。
* 当前 Shell 进程私有用户自定义变量，如上面我们创建的 tmp 变量，只在当前 Shell 中有效。
* ${变量名#匹配字串}: 从头向后开始匹配，删除符合匹配字串的最短数据
* ${变量名##匹配字串}: 从头向后开始匹配，删除符合匹配字串的最长数据
* ${变量名%匹配字串}: 从尾向前开始匹配，删除符合匹配字串的最短数据
* ${变量名%%匹配字串}: 从尾向前开始匹配，删除符合匹配字串的最长数据
* ${变量名/旧的字串/新的字串}:将符合旧字串的第一个字串替换为新的字串
* ${变量名//旧的字串/新的字串}: 将符合旧字串的全部字串替换为新的字串

```sh
declare tmp # 使用 declare 命令创建一个变量名为 tmp 的变量
tmp=God # 使用 = 号赋值运算符，将变量 tmp 赋值为 God
echo $tmp # 读取变量的值：使用 echo 命令和 $ 符号（$ 符号用于表示引用一个变量的值）
set # 显示当前 Shell 所有变量，包括其内建环境变量（与 Shell 外观等相关），用户自定义变量及导出的环境变量。
env # 显示与当前用户相关的环境变量，还可以让命令在指定环境中运行
export # 显示从 Shell 中导出成环境变量的变量
unset temp # 删除变量temp
```

## 概念

* Linux系统默认的字符编码是 UTF-8。Windows 是 GBK 编码，不支持UTF8. 所以 Linux下 的中文文件名到 Windwos下就成了乱码。

## 虚拟机安装

* 用WinSCP.exe等工具上传系统镜像文件rhel-server-7.0-x86_64-dvd.iso到/usr/local/src目录
* 使用Putty.exe工具远程连接到RHEL服务器
* 挂载系统镜像文件
* 内存一定不能低于4g，因为你给虚拟机分配的内存在虚拟机启动之后会1:1的从你的物理内存中划走

### 分区

win10 && UBUNTU 双系统

* 磁盘压缩出30G分区，空闲不做盘符与格式化
* 制作UBUNTU启动U盘
  - 通过UltraISO打开UBUNUT镜像文件
  - 启动：写入硬盘映像，写入U盘文件
* 启动通过U盘
  - 安装类型：其他选项
  - 对之前分配的未使用磁盘空间分区：
      + /：存储系统文件，建议10GB ~ 15GB； 主分区 挂载点 /
      + swap：交换分区，即Linux系统的虚拟内存，建议是物理内存的2倍； 逻辑分区 用于交换空间
      + /home：home目录，存放音乐、图片及下载等文件的空间，建议最后分配所有剩下的空间； 逻辑分区 挂载点 /home
      + /boot：包含系统内核和系统启动所需的文件，实现双系统的关键所在，建议500M。 逻辑分区 挂载点 /boot 安装启动引导器的设备： 选择/boot对应的盘符
      + 生产服务器建议单独再划分一个/data分区存放数据
  - 安装系统
* 通过EASYCD配置启动
  - 添加新条目 linux/BSD选项
  - 选中分区boot分区
* 重启运行

### 设置IP地址、网关DNS

```sh
cd  /etc/sysconfig/network-scripts/
vi  ifcfg-eno16777736  #编辑配置文件，添加修改以下内容

TYPE="Ethernet"
BOOTPROTO="static"  #启用静态IP地址
DEFROUTE="yes"
IPV4_FAILURE_FATAL="no"
IPV6INIT="yes"
IPV6_AUTOCONF="yes"
IPV6_DEFROUTE="yes"
IPV6_FAILURE_FATAL="no"
NAME="eno16777736"
UUID="8071cc7b-d407-4dea-a41e-16f7d2e75ee9"
ONBOOT="yes"  #开启自动启用网络连接
IPADDR0="192.168.21.128"  #设置IP地址
PREFIX0="24"  #设置子网掩码
GATEWAY0="192.168.21.2"  #设置网关
DNS1="8.8.8.8"  #设置主DNS
DNS2="8.8.4.4"  #设置备DNS
HWADDR="00:0C:29:EB:F2:B3"
IPV6_PEERDNS="yes"
IPV6_PEERROUTES="yes"

service network restart   #重启网络
```

### 镜像挂载

所有存储设备都必须挂载使用，包括硬盘

* /dev/sda1      第一个scsi硬盘的第一分区
* /dev/cdrom     光盘
* /dev/hdc       IDE硬盘   centos 5.5
* /dev/sr0       光盘      centos 6.x

```sh
mkdir /media/cdrom  # 新建镜像文件挂载目录
cd /usr/local/src  #进入系统镜像文件存放目录
ls  # 列出目录文件，可以看到刚刚上传的系统镜像文件

mount -t 文件系统 设备描述文件 挂载点（已经存在空目录） # 挂载系统镜像
mount -t iso9660 -o loop /usr/local/src/rhel-server-7.0-x86_64-dvd.iso  /media/cdrom
cd  /media/cdrom  # 进入挂载目录，使用ls命令可以看到已经有文件存在了

umount  /media/cdrom  # 卸载系统镜像 退出挂载目录，才能卸载

vi /etc/fstab   # 添加以下代码。实现开机自动挂载
/usr/local/src/rhel-server-7.0-x86_64-dvd.iso  /media/cdrom   iso9660    defaults,ro,loop  0 0
```

## 硬件

```sh
fdisk -l # 查看设备名

# 统计数据块使用情况
df -T # 可以用来查看分区的文件系统
df -h # Human-readable 显示目前所有文件系统的可用空间及使用情形
df -k

du -h --max-depth=1 /home  # 文件大小相加
du -h --max-depth=1 /home/*
du -sm * | sort -n //统计当前目录大小 并安大小 排序
du -sk * | sort -n
du -sk * | grep guojf //看一个人的大小

grep “model name” /proc/cpuinfo | cut -f2 -d: # 查看CPU

# 关机（必须用root用户）
shutdown -h now  ## 立刻关机
shutdown -h 10  ##  10分钟以后关机
shutdown -h 12:00:00  ##12点整的时候关机
shutdown -h # 关机后关闭电源
shutdown -r now  # 关机/重启 -h:关机 -r:重启
halt   #  等于立刻关机
reboot   # 等于立刻重启
```

### 设备驱动

* 设备分为“块设备”和“字符设备”
  - Linux将设备看成文件，具有三方面的含义
    + 第一，每个设备都对应一个文件名，在内核中也就对应一个索引节点
    + 第二，对文件操作的系统调用大都适用于设备文件；
    + 第三，从应用程序的角度看，设备文件的逻辑空间是一个线性空间；
    + 对于同一个具体的设备而言，文件操作和设备驱动是同一个事物的不同层次，概念上可以将一个系统划分为应用、文件系统和设备驱动三个层次；
  - Linux将设备分为两大类，
    + 一类是像磁盘那样的以块或扇区为单位、成块进行输入/输出的设备，称为块设备；
    + 另一类是像键盘那样以字符(字节)为单位，逐个字符进行输入/输出的设备，称为字符设备；文件系统通常都建立在块设备上。
* 设备驱动程序：处理和管理硬件控制器的软件就是设备驱动程序
* I/O端口包括控制寄存器、状态寄存器和数据寄存器三大类
* 根据访问外设寄存器的不同方式，将CPU分为两大类：一类是“内存映射”(memory-mapped)方式，另一类是“I/O映射”(I/O- mapped)方式。

## 软件

* 包管理管理：apt yum
  - 原理
    + 在本地的一个数据库中搜索关于 cowsay 软件的相关信息
    + 根据这些信息在相关的服务器上下载软件安装
    + 安装某个软件时，如果该软件有其它依赖程序，系统会为我们自动安装所以来的程序；
    + 如果本地的数据库不够新，可能就会发生搜索不到的情况，这时候需要我们更新本地的数据库，使用命令sudo apt-get update可执行更新；
    + 软件源镜像服务器可能会有多个，有时候某些特定的软件需要我们添加特定的源；
  - 参数
    + install 其后加上软件包名，用于安装一个软件包
    + update 从软件源镜像服务器上下载/更新用于更新本地软件源的软件包列表
    + upgrade 升级本地可更新的全部软件包，但存在依赖问题时将不会升级，通常会在更新之前执行一次update
    + dist-upgrade 解决依赖关系并升级(存在一定危险性)
    + remove 移除已安装的软件包，包括与被移除软件包有依赖关系的软件包，但不包含软件包的配置文件
    + autoremove 移除之前被其他软件包依赖，但现在不再被使用的软件包
    + purge 与remove相同，但会完全移除软件包，包含其配置文件
    + clean 移除下载到本地的已经安装的软件包，默认保存在/var/cache/apt/archives/
    + autoclean 移除已安装的软件的旧版本软件包
    + -y 自动回应是否安装软件包的选项，在一些自动化安装脚本中使用这个参数将十分有用
    + -q 静默安装方式，指定多个q或者-q=#,#表示数字，用于设定静默级别，这在你不想要在安装软件包时屏幕输出过多时很有用
    + -f 修复损坏的依赖关系
    + -d 只下载不安装
    + --reinstall 重新安装已经安装但可能存在问题的软件包
    + --install-suggests 同时安装APT给出的建议安装的软件包
    + sudo apt-cache search softname1 softname2 softname3...... 针对本地数据进行相关操作的工具，search 顾名思义在本地的数据库中寻找有关 softname1 softname2 ...... 相关软件的信息
* 编译安装
* 本地文件安装，下载相应deb软件包，使用dpkg命令来安装
  - 参数
    + -i 安装指定deb包,之后修复依赖关系的安装`sudo apt-get -f install`
    + -R 后面加上目录名，用于安装该目录下的所有deb安装包
    + -r remove，移除某个已安装的软件包
    + -I 显示deb包文件的信息
    + -s 显示已安装软件的信息
    + -S 搜索已安装的软件包
    + -L 显示已安装软件包的目录信息
* 从二进制软件包安装：需要做的只是将从网络上下载的二进制包解压后放到合适的目录，然后将包含可执行的主程序文件的目录添加进PATH环境变量即可

```sh
sudo apt-get install cowsay
source ~/.zshrc

sudo add-apt-repository --remove ppa:finalterm/daily

# 配置本地yum源
cd /etc/yum.repos.d/   #进入yum配置目录
touch  rhel-media.repo   #建立yum配置文件
vi  rhel-media.repo   #编辑配置文件，添加以下内容

[rhel-media]
name=Red Hat Enterprise Linux 7.0   #自定义名称
baseurl=file:///media/cdrom #本地光盘挂载路径
enabled=1   #启用yum源，0为不启用，1为启用
gpgcheck=1  #检查GPG-KEY，0为不检查，1为检查
gpgkey=file:///media/cdrom/RPM-GPG-KEY-redhat-release   #GPG-KEY路径

yum clean all   #清除yum缓存
yum makecache  #缓存本地yum源中的软件包信息

yum install httpd   #安装apache
rpm -ql httpd  #查询所有安装httpd的目录和文件

sudo apt-get autoclean
sudo apt-get autoremove
sudo apt-get clean
```

### web设置

```sh
hostname  www  #设置主机名为www

vi /etc/hostname #编辑配置文件
www   localhost.localdomain  #修改localhost.localdomain为www
```

### 列表

* 云笔记:simplenote
* video: VLC
* editor: atom
* oh my zsh 而非 zsh fish
* KchmViewer:阅读CHM
* LaTeX
* Chromium
* Nylas N1：超好用的跨平台电子邮件客户端  Thunderbird
* sougou
* Spotify for Linux：音乐流媒体服务
* Lightworks Free：专业的非线视频编辑器
* Viber：跨平台的 Skype 替代品
* Vivaldi：功能强大的 web 浏览器
* BleachBit: cleaner(softer center)
* albert
* 听播客: Vocal
* PDF 阅读：Foxit Reader
* gimp
* Gtile:分屏工具
* MySQL Workbench
* Cloud music
* shadowshocks
* Jitsy:通讯工具
* Synaptic：软件管理
* thunderbird mail: can  add addon to manage rss
* xchm:`sudo apt-get install xchm`
* [wechat](https://github.com/geeeeeeeeek/electronic-wechat/releases)
* [cherrytree](www.giuspen.com/cherrytree/):note
* [seamonkey](https://www.seamonkey-project.org/):develop the SeaMonkey all-in-one internet application suite
* [Sayonara Player](https://sayonara-player.com/index.php)
* Disk Usage Analyzer

## terminal终端

终端本质上是对应着 Linux 上的 /dev/tty 设备，Linux 的多用户登陆就是通过不同的 /dev/tty 设备完成的

Ubuntu具体说来，它默认提供七个终端，其中第一个到第六个虚拟控制台是全屏的字符终端，第七个虚拟控制台是图形终端，用来运行GUI程序，按快捷键CTRL+ALT+F1，或CTRL+ALT+F2.......CTRL+ALT+F6，CTRL+ALT+F7可完成对应的切换

```sh
dialog --title "Oh hey" --inputbox "Howdy?" 8 55 # interact with the user on command-line
```

* cmmand + d:新开同框分屏
* Ctrl+d:键盘输入结束或退出终端
* Ctrl+s:暂停当前程序，暂停后按下任意键恢复运行
* Ctrl+z:将当前程序放到后台运行，恢复到前台为命令fg
* Ctrl+a:将光标移至输入行头，相当于Home键
* Ctrl+e:将光标移至输入行末，相当于End键
* Ctrl + K :删除从光标所在位置到行末,常配合ctrl+a使用
* Alt+Backspace:向前删除一个单词，常配合ctrl+e使用
* Shift+PgUp:将终端显示向上滚动
* Shift+PgDn:将终端显示向下滚动
* clear|ctrl+l :清屏
* Ctrl + U 删除光标之前的全部内容
* Ctrl + Y 撤销之前的删除操作
* Ctrl + W 删除之前的一个参数

## 指令

/usr/bin/  /bin/ /sbin/

```sh
# 查看linux系统信息
uname -a # 显示电脑以及操作系统的相关信息
cat /proc/version # 说明正在运行的内核版本
cat /etc/issue # 显示的是发行版本信息
lsb_release -a

date # 获取当前时间
date +%Y-%m-%d
date +%Y-%m-%d  --date="-1 day" #加减也可以 month | year
date -s "2016-07-28 16:12:00" ## 修改时间

--version/-V # 查看某个程序的版本
history # 显示历史
--help # 用于显示 shell 内建命令的简要帮助信息 help exit
man # 查看命令的帮助
info ls

cal # 日历
bc # 支持任意精度的交互执行的计算器语言

# 修改时区
sudo tzselect
sudo cp /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime
sudo vi /etc/timezone # 改为Asia/Shanghai

# 搜索
whereis |  who  # 查找命令的命令，同时看到帮助文档位置 只能搜索二进制文件(-b)，man 帮助文件(-m)和源代码文件(-s)
where||type composer
locate /etc/sh(查找 /etc 下所有以 sh 开头的文件)  # 通过/var/lib/mlocate/mlocate.db数据库查找，不过这个数据库也不是实时更新的，系统会使用定时任务每天自动执行 updatedb 命令更新一次，所以有时候你刚添加的文件，它可能会找不到
locate /usr/share/\*.jpg # 注意要添加 * 号前面的反斜杠转义，否则会无法找到。
which man # 使用 which 来确定是否安装了某个指定的软件，因为它只从 PATH 环境变量指定的路径中去搜索命令

sudo find /etc/ -name interfaces/ 格式find [path] [option] [action] # 可以通过文件类型、文件名进行查找而且可以根据文件的属性（如文件的时间戳，文件的权限等）进行搜索 -name 文件名:按照文件名查找 -user 用户名:按照属主用户名查找文件 -group 组名:按照属组组名查找文件 -nouser:找没有属主的文件 (除了这三个文件：/proc、/sys、/mnt/cdrom) -size:按照文件大小k M  如：find / -size +50k -type:按照文件类型查找(f=普通  d=目录  l=链接) -perm:按照权限查找  如：find /root -perm 644 -iname:按照文件名查找，不区分大小写

grep -i "root" /etc/passwd # 查找符合条件的字串   -v:反向选择 -i:忽略大小写

命令1 | 命令2   # 管道符:命令1的执行结果，作为命令2的执行条件

sudo !! # 将之前的命令加上sudo

screen # 固定屏

diff -Naur sources-orig/ sources-fixed/ >myfixes.patch # 参数 -N 代表如果比较的文件不存在，则认为是个空文件， -a 代表将所有文件都作为文本文件对待，-u 代表使用合并格式并输出上下文，-r 代表递归比较目录
```

### 服务、进程、端口管理

```sh
sudo systemctl enable|start|restart|status|reload nginx | httpd.service # enable 设置开机启动 start 启动 stop 停止 restart 重启

# pidof prints out the process id of a running program. For example, below command will output the process ID of nginx
pidof nginx

ps -ef | grep nginx # 进程查看
ps aux | grep nginx

kill -9 pid # 关闭进程
kill pid
kill -USR2 $(pidof nginx)
pkill -f nginx

ctrl+c   ## 有些程序也可以用q键退出

ctrl+z   ## 进程会挂起到后台
bg jobid  ## 让进程在后台继续执行
fg jobid   ## 让进程回到前台

iotop # Sorts processes by disk writes, and show how much and how frequently programs are writing to the disk.
powertop # Lists processes by their energy consume. It\'s a vital command when you\'re outside, somewhere you can\'t charge your laptop.
nethogs # Lists processes by their network traffic.

top
top -bn1 | grep php-fpm

htop # Famous process monitor. It has a nice, colorful command-line UI. Some useful keybindings:
# \ Filter
# / Search
# , Choose sorting criteria
# k Send kill signal
# u Filter results by user
# t Open/close tree mode
# - and + Collabse / uncollapse selected process tree
# H Turn off displaying threads
```

### Network

* 网络分内网与外网
* 端口提供服务：
  - 是否暴漏
  - 修改防火墙规则
* 端口扫描

```sh
hostname # 返回系统的主机名称
host xx.xxx.com # 显示某域名相关托管服务器/邮件服务器

curl http://icanhazip.com # 查看本机IP
curl https://github.com/racaljk/hosts/blob/master/hosts -L >> /etc/hosts

ping -c 次数 ip # 测试网络畅通性
ping 8.8.8.8 # 检测连接
ip addr # 查看IP地址

ifconfig # 查询本机网络信息

sudo gedit /etc/modprobe.d/iwlwifi.config add `options iwlwifi 11n_disable=1`

# iptables
service iptables status
service iptables stop # tempory
chkconfig optables off # always

# firewall as default
firewall-cmd --state
firewall-cmd --reload # restart
systemctl status firewalld.service
systemctl stop firewalld.service # stop
systemctl disable firewalld.service # cancle start with system

/etc/init.d/iptables status|save
chkconfig iptables on|off # forever
chkconfig iptables start|stop # recover with restart
iptables -F # 删除所有现有规则

iptables -P INPUT DROP # 设置默认的 chain 策略
iptables -P FORWORD DROP
iptables -P OUTPUT DROP
iptables -I INPUT -p tcp --dport 80 -j ACCEPT # open port

## port test
yum install telnet.x86_64
telnet 10.0.3.69 2020  # 测试端口能否访问

lsof -i: (port) # 查看端口的占用情况
lsof -Pni4 | grep LISTEN | grep php

netstat -tunlp # 显示tcp，udp的端口和进程等相关
netstat -tln | grep 8000
netstat -tunlp|grep (port)  # // 指定端口号进程情况
```

### 身份

* owner
* group
* others
* nobody:nogroup

### 目录

```sh
du # 命令可以查看目录的容量，-h #同--human-readable 以K，M，G为单位，提高信息的可读性；-a #同--all 显示目录中所有文件的大小 -d:指定查看目录的深度 `du -h -d 1 ~`

ls -a|l|h|d directory # list 列出某文件夹下的文件，添加参数可实现更细致的功能  -a:列出所有文件，包括隐藏文件 -l:列出文件及其详细信息 -h:文件大小 -d:显示目录本身
# -rw-------    1   root    root    1190    08-10 23:37     anaconda-ks.cfg 长格式实例： 权限位 引用计数 属主、组 大小 最后修改时间
tree # 查看文件列表

cd /home/henry|~|..|../.. # change directory 通过相对路径、绝对路径切换目录,cd到不存在的目录时会报错
cd   # 进入用户主目录
cd -  # 返回进入此目录之前所在的目录

touch # 创建空文件 或 修改文件时间 touch file{1..5}.txt 使用通配符批量创建 5 个文件
touch  somefile.1  ## 创建一个空文件

echo "hi,boy" > somefile.2  ## 利用重定向“>”的功能，将一条指令的输出结果写入到一个文件中，会覆盖原文件内容，如果指定的文件不存在，则会创建出来
echo "hi baby" >> somefile.2  ## 将一条指令的输出结果追加到一个文件中，不会覆盖原文件内容

rename # 批量重命名,需要用到正则表达式
rename 's/.txt/.c/' *.txt 批量将这 5 个后缀为 .txt 的文本文件重命名为以 .c 为后缀的文件:
rename 'y/a-z/A-Z/' *.c 批量将这 5 个文件，文件名改为大写

pwd # print working directory 打印当前目录
mkdir # make directories 创建目录
mkdir -p father/son/grandson # 递归创建

mv  sourcefile  destinationDirectory|desalinationFile  #  移动文件、文件重命名 将当前目录下的install.log 移动到aaa文件夹中去

rmdir # remove empty directories 删除目录
rm -rf directory # r递归删除，f参数表示强制
rm -rf log/* # 方法二：删除logs文件夹下的所有文件，而不删除文件夹本身

# 生产环境把rm -rf 命令替换为mv，再写个定时shell定期清理
# 帐号权限的分离，线上分配work帐号，只能够删除/home/work/logs/目录，无法删除根目录。
# cd ${log_path} && rm -rf *
# 制定编码规范，对目录进行操作之前，要先判断目录是否存在。
```

### 文件

Linux 的磁盘是"挂在"（挂载在）目录上的，每一个目录不仅能使用本地磁盘分区的文件系统，也可以使用网络上的文件系统。Linux的大部分目录结构是依据FHS标准（英文：Filesystem Hierarchy Standard 中文：文件系统层次结构标准）规定好的，多数 Linux 版本采用这种文件组织形式，FHS 定义了系统中每个区域的用途、所需要的最小构成的文件和目录同时还给出了例外处理与矛盾处理。

FHS包含两层规范：

* / 下面的各个目录应该要放什么文件数据，例如 /etc 应该放置设置文件，/bin 与 /sbin 则应该放置可执行文件等等。
* 针对 /usr 及 /var 这两个目录的子目录来定义。例如 /var/log 放置系统登录文件，/usr/share 放置共享数据等等。
* 文件类型
  * `-` 普通文件：一般是用一些相关的应用程序创建的（如图像工具、文档工具、归档工具... 或 cp工具等),这类文件的删除方式是用rm 命令,而创建使用touch命令,用符号-表示；
  * `d` 目录：目录在Linux是一个比较特殊的文件，用字符d表示，删除用rm 或rmdir命令；
  * 块设备文件：存在于/dev目录下，如硬盘，光驱等设备，用字符d表示;
  * 设备文件：（ /dev 目录下有各种设备文件，大都跟具体的硬件设备相关），如猫的串口设备，用字符c表示；
  * socket文件;用字符s表示，比如启动MySQL服务器时，产生的mysql.sock的文件;
  * pipe 管道文件：可以实现两个程序（可以从不同机器上telnet）实时交互，用字符p表示；
  * `l` 链接文件:软链接等同于 Windows 上的快捷方式；用字符l表示； 软硬链接文件的共同点和区别：无论是修改软链接，硬链接生成的文件还是直接修改源文件，相应的文件都会改变，但是如果删除了源文件，硬链接生成的文件依旧存在而软链接生成的文件就不再有效了。
* 虚拟文件系统
  * 将各种不同文件系统的操作和管理纳入到一个统一的框架中，使得用户程序可以通过同一个文件系统界面，也就是同一组系统调用，对各种不同的文件系统以及文件进行操作；用户程序可以不关心不同文件系统的实现细节，而使用系统提供的统一、抽象、虚拟的文件系统界面；这种统一的框架就是所谓的虚拟文件系统转换，一般简称虚拟文件系统(VFS)；
  * VFS的对象类型包括：超级块(superblock)对象、索引节点(inode)对象、目录项(dentry)对象和文件(file)对象；
  * 虚拟文件系统界面是虚拟文件系统所提供的抽象界面，它主要由一组标准的、抽象的操作构成，这些函数(操作)以系统调用的形式供用户调用。

```sh
file logo.png # Returns information for given file

wc  -l|-m|-w # 行 字符 字 获取某一个文件的行数和字数`wc package.json`
cp -r|p|d|a 源文件 目标位置/目标名称 # 复制文件或目录  r:复制目录 p:连带文件属性一起复制 -d:源文件是链接文件，则复制链接属性 a:相当于pdr

sort # 排序
diff # 比较两个文件的异同

cat -n file # 查看文件内容，从头到尾的内容 -n:列出行号
tac # 打印文件内容到标准输出(逆序)
more file # 分屏显示文件内容,终端底部显示当前阅读的进度。可以使用 Enter 键向下滚动一行，使用 Space 键向上滚动一屏，按下 h 显示帮助，q 退出。
file /bin/ls # 查看文件类型
head  -n 20|-20 file # 显示文件头几行(默认显示10行)
tail -n 1 /etc/passwd # 查看文件的尾几行（默认10行）
tail -f file

cat file >> another file # 文件追加

ln -s 源文件 目标文件 创建链接文件 # 链接文件相当于快捷方式 (文件名都必须写绝对路径)
ln -l /user/bin/java #  show link info

psketch

tee # It splits the output of a program, so we can both print & save it. For example, add a new entry to hosts file;
echo "127.0.0.1 foobar" | sudo tee -a /etc/hosts

tree -d # Lists contents of a directory in tree-like format

find . -type f -name "*.css"  # List all CSS files (including subdirectories)
find . -type f \( -name "*.css" -or -name "*.html" \) # List all CSS or HTML files:
```

* `dd if=/dev/zero of=virtual.img bs=1M count=256` 从/dev/zero设备创建一个容量为 256M 的空文件virtual.img
* `sudo mkfs.ext4 virtual.img` 格式化virtual.img为ext4格式
* dd：默认从标准输入中读取，并写入到标准输出中,但输入输出也可以用选项if（input file，输入文件）和of（output file，输出文件）改变。
* `dd if=/dev/stdin of=test bs=10 count=1 conv=ucase` 将输出的英文字符转换为大写再写入文件
* sudo mount 查看下主机已经挂载的文件系统，每一行代表一个设备或虚拟设备格式[设备名]on[挂载点]

### 权限

一个目录同时具有读权限和执行权限才可以打开并查看内部文件，而一个目录要有写权限才允许在其中创建其它文件，这是因为目录文件实际保存着该目录里面的文件的列表等信息。

* readable 读权限4：读取文件内容|查询目录下文件名 如：cat、more、head、tail ls
* writable 写权限2，编辑、新增、修改文件内容|修改目录结构的权限
* excutable执行权限1，通常指可以运行的二进制程序文件或者脚本文件(Linux 上不是通过文件后缀名来区分文件的类型)|可以进入目录
* 所有者权限，所属用户组权限，是指你所在的用户组中的所有其它用户对于该文件的权限

```sh
# -r-xr-x---
chmod 755 test # change the permissions mode of a file 修改权限  赋予一个shell文件test.sh可执行权限，拥有者可读、写、执行，群组账号和其他人可读、执行。
chmod  u g o a | +（加入） -（除去） =（设置） | r w x | 文档路径

chmod u=rwx,g+rwx,o-rwx test

sudo chown user1:user1 /etc/apt/sources.list # 修改文件的属主或属组 change file ownership
chown [-R] [帐号名称] [文件或目录]
chown [-R] [帐号名称]:[群组名称] [文件或目录]
```

### 压缩

* -r:表示递归打包包含子目录的全部内容
* -q:表示为安静模式，即不向屏幕输出信息
* -o:表示输出文件，需在其后紧跟打包输出文件名
* -[1-9]:设置压缩等级，1 表示最快压缩但体积大，9 表示体积最小但耗时最久。
* -x:排除我们上一次创建的 zip 文件，否则又会被打包进这一次的压缩文件中
* -e：创建加密压缩包
* -l:将 LF（换行） 转换为 CR+LF(windows 回车加换行)

```sh
zip -r -9 -q -o shiyanlou_9.zip /home/shiyanlou -x ~/*.zip # 设置不同压缩等级
zip -r -e -o shiyanlou_encryption.zip /home/shiyanlou  # 创建加密
zip -r -l -o shiyanlou.zip /home/shiyanlou   # 解决windows和linux对换行的不同处理问题

unzip -q shiyanlou.zip -d ziptest   # 静默且指定解压目录，目录不存在会自动创建
unzip -O GBK 中文压缩文件.zip # 使用 -O（英文字母，大写 o）参数指定编码类型

tar -zcvf 压缩文件名 源文件 # 压缩/解压 同时打包 -z:识别.gz格式  -c:压缩  -v:显示压缩过程  -f:指定压缩包名
tar -zxvf  压缩文件名   # 解压缩同时解打包

tar -jcvf 压缩文件名 源文件   # 压缩同时打包
tar -jxvf aa.tar.bz2  /tmp/ # 解打包同时解压缩

tar -ztvf aa.tar.gz  # 查看不解压
tar -jtvf aa.tar.bz2 # -t  只查看，不解压
```

### 用户管理

每次次新建用户如果不指定用户组的话，默认会自动创建一个与用户名相同的用户组； 默认情况下在 sudo 用户组里的可以使用 sudo 命令获得 root 权限。

```sh
who # 查看有谁在线
last # 查看最近的登陆历史记录
who am i # 只列出用户名
who mom likes/who am i # 列出用户名，所使用终端的编号和开启时间；
finger # 列出当前用户的详细信息，需使用apt-get提前安装；

su <user> # 切换到用户user,执行时需要输入目标用户的密码；
su - <user> # 切换用户，同时环境变量也会跟着改变成目标用户的环境变量。
su -l lilei # 切换登录用户;
sudo adduser lilei # 新建一个叫做lilei的用户，添加用户到系统，同时也会默认为新用户创建 home目录：
sudo useradd # 只创建用户，创建完了需要用 passwd lilei 去设置新用户的密码;
groups zhangwang # 查看用户属于那些组（groups）
cat /etc/group | sort 命令查看某组包含那些成员 # /etc/group文件中分行显示了用户组（Group）、用户组口令、GID 及该用户组所包含的用户（User）
sudo usermod -G sudo student # 不同的组对不同的文件可能具有不同的操作权限，比如说通过上述命令新建的用户默认是没有使用sudo的权限的，我们可以使用usermod命令把它加入sudo组用以具备相应的权限。
sudo deluser student --remove-home # 删除用户及用户相关文件；

etc/passwd
useradd 用户名 # 添加用户
passwd 用户名  # 设定用户密码

etc/group
chgrp [-options] [群组名] [文档路径]

choot
```

### 匹配符

- `*`：匹配 0 或多个字符，如`ls *.html`将匹配所有以html结尾的文件,`ls b*.png`将匹配所有以b开头，png结尾的文件；
- `?`：匹配任意一个字符,如`ls abc?.png` 可匹配abcd.png/abce.png
- `[list]` # 匹配 list 中的任意单一字符
- `[!list]`:匹配 除list 中的任意单一字符以外的字符
- `[c1-c2]`:匹配 c1-c2 中的任意单一字符 如：[0-9] [a-z]
- `{string1,string2,...}`:匹配 string1 或 string2 (或更多)其一字符串，如 `{css,html}`， `ls app.{html.css}`将匹配app.css 和app.html;
- `{c1..c2}`:匹配 c1-c2 中全部字符 如{1..10}
- 注意通配符大小写敏感

### ssh

基于密钥的验证是最安全的几个身份验证模式使用OpenSSH,如普通密码和Kerberos票据。 基于密钥的验证密码身份验证有几个优点,例如键值更难以蛮力,比普通密码或者猜测,提供充足的密钥长度。 其他身份验证方法仅在非常特殊的情况下使用。

SSH可以使用RSA(Rivest-Shamir-Adleman)或“DSA(数字签名算法)的钥匙。 这两个被认为是最先进的算法,当SSH发明,但DSA已经被视为近年来更不安全。 RSA是唯一推荐选择新钥匙,所以本指南使用RSA密钥”和“SSH密钥”可以互换使用。

基于密钥的验证使用两个密钥,一个“公共”键,任何人都可以看到,和另一个“私人”键,只有老板是允许的。 安全通信使用的基于密钥的认证,需要创建一个密钥对,安全地存储私钥在电脑人想从登录,并存储公钥在电脑上一个想登录。

使用基于密钥登录使用ssh通常被认为是比使用普通安全密码登录。 导的这个部分将解释的过程中生成的一组公共/私有RSA密钥,并将它们用于登录到你的Ubuntu电脑通过OpenSSH(s)。如果只有服务器也是不能实现一个完整的桌面环境的，当然还需要一个客户端，我们称为

```sh
sudo apt install sshd
service sshd restart

cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

# SSH配置文件 uncomment
authorizedKeyFile

service sshd restart

### 密钥生成
ssh-keygen -t rsa -b 4096
ssh-copy-id <username>@<host> # install your public key to any user that you have login credentials for.

chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys

scp ~/.ssh/id_rsa.pub hadoop@192.168.1.134:~/
cat ~/id_rsa.pub >> ~/.ssh/authorized_keys
cat ~/.ssh/id_rsa.pub | ssh demo@198.51.100.0 "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >>  ~/.ssh/authorized_keys"

# 传输文件通过ssh
scp id_rsa.pub git@172.26.186.117:/home/git/
scp -P 1101 username@servername:/remote_path/filename  ~/local_destination   // 源文件  目标文件
ssh -p 2222 user@host   # 登陆服务器

## 服务器登陆
ssh username@remote_host
ssh username@remote_host ls /var/www

# /etc/ssh/sshd_config
PasswordAuthentication no  # Disable Password Authentication
PubkeyAuthentication yes
ChallengeResponseAuthentication no

PermitRootLogin no|yes|without-password  ## restrict the root login to only be permitted via SSH keys, no:禁止root通过ssh登录

sudo systemctl reload sshd.service
```

### SFTP

stands for SSH File Transfer Protocol, or Secure File Transfer Protocol, is a separate protocol packaged with SSH that works in a similar way over a secure connection.

```sh
sftp [-oPort=custom_port] sammy@your_server_ip_or_remote_hostname

help | ?

# Local
lls
lcd Desktop

## Transferring Files
get -[r | P] remoteFile localFile # 下载重新命名 r:递归 P：维护权限与时间
put localFile # 上传文件

df -h # remote
! df -h # local

get /etc/group
!less group # 参看本地文件
```

### sougou pinyin

- command line
- package

  - get package: download sogou_pinyin_linux_1.0.0.0033_amd64.deb
  - install:

```sh
sudo dpkg  -i   sogou_pinyin_linux_1.0.0.0033_amd64.deb
```

- config:

  - system setting->language support
  - choose language,key input fcitx

### atom

```sh
sudo add-apt-repository ppa:webupd8team/atom
sudo apt-get update
sudo apt-get install atom

# ervernote
sudo add-apt-repository ppa:nixnote/nixnote2-daily
sudo apt update
sudo apt install nixnote2
File->Add Another User
Tools->Synchronize
```

## chrome(firefox 禁用console.log)

```sh
sudo wget http://www.linuxidc.com/files/repo/google-chrome.list -P /etc/apt/sources.list.d/
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub  | sudo apt-key add -
sudo apt-get update
sudo apt-get install google-chrome-stable
```

## 启动项

* /etc/init.d：查看系统引导时启动的服务项
* 启动目录： /etc/rc.d/rc[0~6].d
* 命令行脚本文件：/etc/init.d/
* 本地文件：/etc/rc.local
* 添加 /etc/init.d/nginx start

```sh
systemctl list-unit-files --type=service | grep enabled # 展示开机启动时的进程项

sudo systemctl stop bluetooth.service
sudo systemctl disable bluetooth.service
systemctl status bluetooth.service

sudo systemctl mask bluetooth.service # 完全阻止开机启动 把它掩盖起来

## 禁用服务列表
accounts-daemon.service # AccountsService 的一部分，AccountsService 允许程序获得或操作用户账户信息
avahi-daemon.service # 用于零配置网络发现，使电脑超容易发现网络中打印机或其他的主机
brltty.service # 提供布莱叶盲文设备支持，例如布莱叶盲文显示器。
debug-shell.service # 开放了一个巨大的安全漏洞（该服务提供了一个无密码的 root shell ，用于帮助 调试 systemd 问题），除非你正在使用该服务，否则永远不要启动服务。
ModemManager.service # 该服务是一个被 dbus 激活的守护进程，用于提供移动
pppd-dns.service # 是一个计算机发展的遗物，如果你使用拨号接入互联网的话，保留它，否则你不需要它。
rtkit-daemon.service # 一个 实时内核调度器real-time kernel scheduler
whoopsie.service # 是 Ubuntu 错误报告服务。它用于收集 Ubuntu 系统崩溃报告，并发送报告到 https://daisy.ubuntu.com 。 你可以放心地禁止其启动，或者永久的卸载它。
wpa_supplicant.service # 仅在你使用 Wi-Fi 连接时需要。

# 提高电池的寿命并且减少过热
sudo add-apt-repository ppa:linrunner/tlp
sudo apt-get update
sudo apt-get install tlp tlp-rdw
sudo tlp start
```

## 日志

```sh
journalctl -b -1 # 命令可以重现上一次启动时候的信息
journalctl -b -2 # 可以重现倒数第 2 次启动
systemd-analyze blame # 这个命令可以显示进程耗时
```

## Boot分区不足

```sh
# 查看已安装的linux-image各版本
dpkg --get-selections |grep linux-image
# 查看使用版本
uname -a
# 清除旧版本
sudo apt-get purge linux-image-3.5.0-27-generic
# 图中因使用remove命令而残留的deinstall的
sudo dpkg -P linux-image-extra-3.5.0-17-generic
```

chkconfig --list sshd

## 终端命令

* ssh:连接到一个远程主机，然后登录进入其 Unix shell。这就使得通过自己本地机器的终端在服务器上提交指令成为了可能。
* grep:用来在文本中查找字符串,从一个文件或者直接就是流的形式获取到输入, 通过一个正则表达式来分析内容，然后返回匹配的行。该命令在需要对大型文件进行内容过滤的时候非常趁手`grep "$(date +"%Y-%m-%d")" all-errors-ever.log > today-errors.log`
* 使用 alias 这个 bash 内置的命令来为它们创建一个短别名:alias server="python -m SimpleHTTPServer 9000"
* Curl 是一个命令行工具，用来通过 HTTP（s），FTP 等其它几十种你可能尚未听说过的协议来发起网络请求。
* Tree 用可视化的效果向你展示一个目录下的文件 tree -P '_.min._'
* Tmux 是一个终端复用器,它是一个可以将多个终端连接到单个终端会话的工具。可以在一个终端中进行程序之间的切换，添加分屏窗格，还有就是将多个终端连接到同一个会话，使它们保持同步。 当你在远程服务器上工作时，Tmux 特别有用，因为它可以让你创建新的选项卡，然后在选项卡之间切换
* du 命令会生成相关文件和有关目录的空间使用情况的报告。它很容易使用，也可以递归地运行，会遍历每个子目录并且返回每个文件的单个大小。`du -sh *`
* tar:用来处理文件压缩的默认 Unix 工具.
* md5sum:它们可以用来检查文件的完整性。`md5sum ubuntu-16.04.3-desktop-amd64.iso` 将生成的字符串与原作者提供的（比如 UbuntuHashes）进行比较
* Htop 是个比内置的 top 任务管理更强大的工具。它提供了带有诸多选项的高级接口用于监控系统进程。
* ln:unix 里面的链接同 Windows 中的快捷方式类似，允许你快速地访问到一个特定的文件。`sudo ln -s ~/Desktop/Scripts/git-scripts/git-cleanup /usr/local/bin/`

## Hypervisor

Linux的最重要创新之一，引入Hypervisor，运行其他操作系统的操作系统，它们为执行提供独立的虚拟硬件平台，同时硬件虚拟平台可以提供对底层机器的虚拟的完整访问.在解决软件架构设计问题时，通常做法是引入一个抽象层来解决，其实这种做法是有点普世原理，同样适用于硬件封装，Hypervisor正是这样一种虚拟抽象层。 只有5%的时间在全负荷工作，其他时间则处于休眠或者空闲状态，虚拟化技术可以大大提升服务器的利用率，从而间接减少服务器数量，即成本！ ![](../_static/Hypervisor.jpg) Hypervisor作为虚拟技术的核心，抽象虚拟化硬件平台.它支持给每一个虚拟机分配内存，CPU， 网络和磁盘，并加载虚拟机的客户操作系统。当然，在获取到这么优秀功能（对硬件的虚拟化，并搭载操作系统）的代价，自然牺牲了启动速度及在资源利用率，性能的开销等。

## LXC(Linux Container）

一种内核虚拟化技术，相比上述的Hypervisor技术则提供更轻量级的虚拟化，以隔离进程和资源，且无需提供指令解析机制及全虚拟化的复杂性，LXC或者容器将操作系统层面的资源分到孤立／隔离的组中，用来管理使用资源。LXC为Sourceforge上的开源项目，其实现是借助Linux的内核特性，（cgroups子系统+namespace）, 在OS层次上做整合为进程提供虚拟执行环境，即称之为容器，除了分配绑定cpu，内存，提供独立的namespace（网络，pid，ipc，mnt，uts）

## Samba

```sh
sudo apt-get install samba samba-common
sudo apt-get autoremove samba

mkdir /home/myshare
chmod 777 /home/myshare

sudo smbpasswd  -a  henry # add user

vim /etc/samba/smb.conf # 添加下列设定
[share]
comment=This is samba dir
browseable = yes
path=/home/myshare
create mask=0755
directory mask=0755
writeable=yes
valid users=henry
browseable=yes
public = yes
available = yes
writable = yes

sudo service samba status | start | stop | restart

# mac 链接 finder中com＋K
smb://192.168.100.106
# windows cmd
\\192.168.182.188

# windows access internet \\192.168.1.13 share
```

### [oguzhaninan/Stacer](https://github.com/oguzhaninan/Stacer)

Linux System Optimizer and Monitoring

```sh
sudo add-apt-repository ppa:oguzhaninan/stacer
sudo apt-get update
sudo apt-get install stacer
```

### grep：Global search REgrular expression and Print out the line

- --color=auto：对匹配到的文本着色显示
- -v：显示不被pattern 匹配到的行，反向选择 ,查找文件中不包含"test"内容的行 `grep -v test log.txt`
- -i：忽略字符大小写
- -n：显示匹配的行号
- -c：统计匹配的行数
- -o：仅显示匹配到的字符串
- -q：静默模式，不输出任何信息
- -A #：after，后#行 ,显示包含这行后续#行
- -B #：before，前#行
- -C #：context，前后各#行
- -e：实现多个选项间的成逻辑or关系，grep –e 'cat ' -e 'dog' file
- -w：匹配整个单词,（字母，数字，下划线不算单词边界）
- -E：使用ERE
- -r或--recursive 此参数的效果和指定"-d recurse"参数相同。

### sed

一种流编辑器，它一次处理一行内容。处理时，把当前处理的行存储在临时缓存区中，称为"模式空间"(patternspace)，接着用sed命令处理缓存区中的内容，处理完成后，把缓存区的内容送往屏幕。然后读入下一行，执行下一个循环。如果没有使用诸如'D'的特殊命令，那么会在两个循环之间清空模式空间，但不会清空保留空间。这样不断重复，直到文件末尾。文件内容并没有改变，除非你使用重定向存储输出。 sed的功能：主要用来自动编辑一个或多个文件，简化对文件的反复操作，编写转换程序等，且支持正则表达式！

### 地址定界：就是说明用来处理一行中的那个些部分的。

- 不给地址：对全文进行处理
- # ：指定的行/pattern/能够被模式匹配到的每一行
- # ,#：从第n行到第m行
- # ,+#：从第n行，加上其后面m行
- /pat1/,/pat2/：符合第一个模式和第二个模式的所有行
- # ,/pat1/：从第n行到符合 /pat1/ 这个模式的行
- 1~2 ：~ 这个符号表示步进，1~2 表示的是奇数行
- 2~2：表示的是偶数行

### 编辑命令

地址定界后，对范围内的内容进行相关编辑。

- d：删除模式空间匹配的行，并立即启用下一轮循环 `nl log.txt | sed '2,3d'`
- p：打印当前模式空间内容，追加到默认输出之后
- q：读取到指定行之后退出
- `a [\]text`：在指定行后面追加文本支持使用\n 实现多行行后追加 `sed -e 4a\newline log.txt`
- `i [\]text`：在行前面插入文本
- `c [\]text`：替换行为单行或多行文本 `nl log.txt | sed '2,3c No 2-3 number'`
- w /path/somefile：保存模式匹配的行至指定文件
- r /path/somefile：读取指定文件的文本至模式空间中匹配到的行后
- =：为模式空间中的行打印行号
- !：模式空间中匹配行取反处理
- s///：查找替换, 支持使用其它分隔符，s@@@ ，s### `nl log.txt | sed -e '3d' -e 's/test/TEST/'`
- ；：对一行进行多次操作的命令的分割
- &：配合s///使用，代表前面所查找到的字符等，&sm ；sm&。
- g：行内全局替换。也可以指定行内的第几个符合要求的进行替换：2g,就表示第2个替换。
- p：显示替换成功的行 `nl log.txt | sed -n '/is/p'` a替换A，多个用;分开`nl log.txt | sed -n '/is/{s/a/A/;p}'`
- w /PATH/TO/SOMEFILE：将替换成功的行保存至文件中
- -e


vim config
```
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 显示相关
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set shortmess=atI   " 启动的时候不显示那个援助乌干达儿童的提示
winpos 5 5         " 设定窗口位置
set lines=30 columns=85    " 设定窗口大小
set nu              " 显示行号
set go=             " 不要图形按钮
"color asmanian2     " 设置背景主题
set guifont=Courier_New:h10:cANSI   " 设置字体
syntax on           " 语法高亮
autocmd InsertLeave * se nocul  " 用浅色高亮当前行
autocmd InsertEnter * se cul    " 用浅色高亮当前行
set ruler           " 显示标尺
set showcmd         " 输入的命令显示出来，看的清楚些
set cmdheight=1     " 命令行（在状态行下）的高度，设置为1
"set whichwrap+=<,>,h,l   " 允许backspace和光标键跨越行边界(不建议)
set scrolloff=3     " 光标移动到buffer的顶部和底部时保持3行距离
set novisualbell    " 不要闪烁(不明白)
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   "状态行显示的内容
set laststatus=1    " 启动显示状态行(1),总是显示状态行(2)
set foldenable      " 允许折叠
set foldmethod=manual   " 手动折叠
set background=dark "背景使用黑色
set nocompatible  "去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限
" 显示中文帮助
if version >= 603
    set helplang=cn
    set encoding=utf-8
endif
" 设置配色方案
"colorscheme murphy
"字体
"if (has("gui_running"))
"   set guifont=Bitstream\ Vera\ Sans\ Mono\ 10
"endif


set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936
set fileencoding=utf-8

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""新文件标题""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新建.c,.h,.sh,.java文件，自动插入文件头
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java exec ":call SetTitle()"
""定义函数SetTitle，自动插入文件头
func SetTitle()
    "如果文件类型为.sh文件
    if &filetype == 'sh'
        call setline(1,"\#########################################################################")
        call append(line("."), "\# File Name     : ".expand("%"))
        call append(line(".")+1, "\# Author        : enjoy5512")
        call append(line(".")+2, "\# mail          : enjoy5512@163.com")
        call append(line(".")+3, "\# Created Time  : ".strftime("%c"))
        call append(line(".")+4, "\#########################################################################")
        call append(line(".")+5, "")
        call append(line(".")+6, "\#!/bin/bash")
    call append(line(".")+7, "")
    call append(line(".")+8, "")
    else
        call setline(1, "/*************************************************************************")
        call append(line("."), "    > File Name       : ".expand("%"))
        call append(line(".")+1, "    > Author          : enjoy5512")
        call append(line(".")+2, "    > Mail            : enjoy5512@163.com ")
        call append(line(".")+3, "    > Created Time    : ".strftime("%c"))
        call append(line(".")+4, " ************************************************************************/")
        call append(line(".")+5, "")
    endif
    if &filetype == 'cpp'
        call append(line(".")+6, "#include<iostream>")
    call append(line(".")+7, "")
        call append(line(".")+8, "using namespace std;")
        call append(line(".")+9, "")
        call append(line(".")+10, "int main(int argc,char *argv[])")
        call append(line(".")+11, "{")
        call append(line(".")+12, "     ")
        call append(line(".")+13, "    return 0;")
        call append(line(".")+14, "}")
    endif
    if &filetype == 'c'
        call append(line(".")+6, "#include<stdio.h>")
        call append(line(".")+7, "")
        call append(line(".")+8, "int main(int argc,char *argv[])")
        call append(line(".")+9, "{")
        call append(line(".")+10, "     ")
        call append(line(".")+11, "    return 0;")
        call append(line(".")+12, "}")
    autocmd BufNewFile * 12 j
    endif
endfunc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"键盘命令
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"C，C++ 按F5编译运行
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!gcc % -o %<"
        exec "! ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'sh'
        :!./%
    endif
endfunc
"C,C++的调试
map <C-F5> :call Rungdb()<CR>
func! Rungdb()
    exec "w"
    if &filetype == 'c'
        exec "!gcc % -g -o %<"
        exec "!gdb -tui ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -g -o %<"
        exec "!gdb -tui ./%<"
    endif
endfunc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""实用设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 设置当文件被改动时自动载入
set autoread
" quickfix模式
autocmd FileType c,cpp map <buffer> <leader><space> :w<cr>:make<cr>
"代码补全
set completeopt=preview,menu
"允许插件
filetype plugin on
"共享剪贴板
set clipboard+=unnamed
"从不备份
set nobackup
"自动保存
set autowrite
set ruler                   " 打开状态栏标尺
set cursorline              " 突出显示当前行
set magic                   " 设置魔术
set guioptions-=T           " 隐藏工具栏
set guioptions-=m           " 隐藏菜单栏
set foldcolumn=0
set foldmethod=indent
set foldlevel=3
set foldenable              " 开始折叠
" 不要使用vi的键盘模式，而是vim自己的
set nocompatible
" 语法高亮
set syntax=on
" 去掉输入错误的提示声音
set noeb
" 在处理未保存或只读文件的时候，弹出确认
set confirm
" 自动缩进
set autoindent
set cindent
" Tab键的宽度
set tabstop=4
" 统一缩进为4
set softtabstop=4
set shiftwidth=4
"禁止生成临时文件
set nobackup
set noswapfile
"搜索忽略大小写
set ignorecase
"搜索逐字符高亮
set hlsearch
set incsearch
"行内替换
set gdefault
"编码设置
set enc=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
"语言设置
set langmenu=zh_CN.UTF-8
set helplang=cn
" 我的状态行显示的内容（包括文件类型和解码）
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
"set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]
"set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\
" 总是显示状态行
set laststatus=2
" 命令行（在状态行下）的高度，默认为1，这里是2
set cmdheight=2
" 侦测文件类型
filetype on
" 载入文件类型插件
filetype plugin on
" 为特定文件类型载入相关缩进文件
filetype indent on
" 保存全局变量
set viminfo+=!
" 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\
" 高亮显示匹配的括号
set showmatch
" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=1
" 光标移动到buffer的顶部和底部时保持3行距离
set scrolloff=3
" 为C程序提供自动缩进
set smartindent
" 高亮显示普通txt文件（需要txt.vim脚本）
au BufRead,BufNewFile *  setfiletype txt
"自动补全
":inoremap ( ()<ESC>i
":inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {<CR>}<ESC>O
:inoremap } <c-r>=ClosePair('}')<CR>
":inoremap [ []<ESC>i
":inoremap ] <c-r>=ClosePair(']')<CR>
":inoremap " ""<ESC>i
":inoremap ' ''<ESC>i
function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction
filetype plugin indent on
"打开文件类型检测, 加了这句才可以用智能补全
set completeopt=longest,menu
```

## 系统

* [openwrt/openwrt](https://github.com/openwrt/openwrt)：This repository is a mirror of https://git.openwrt.org/openwrt/openwrt.git It is for reference only and is not active for check-ins or for reporting issues. We will continue to accept Pull Requests here. They will be merged via staging trees then into openwrt.git. All issues should be reported at: https://bugs.openwrt.org

## 参考

* [The Linux Kernel documentation](https://www.kernel.org/doc/html/latest/index.html)
* [LVS：跑在Linux内核上的负载均衡器](https://liangshuang.name/2017/11/19/lvs/)
* [Introduction to Linux](https://www.ibm.com/developerworks/linux/newto/) – 这是来自IBM的教程，用于给那些想学习Linux的人。
* [Linux Desktop 101](https://www.lifewire.com/learn-how-linux-4102755) – 这是一个 14周 课时的教程，主要用于学校里教学生如何在一个PC上运行一个Linux操作系统。
* [Hands-On Introduction to Linux](http://tldp.org/LDP/intro-linux/html/index.html) – Machtelt Garrels 的一个格式相当不错的教程。
* [Getting Started with Linux](https://www.linux.org/lessons/beginner/index.html) – 来自Linux Online 的20课时的用于新手的教程。
* [Advanced Linux Programming](http://www.advancedlinuxprogramming.com/) – 这是一本电子书可以免费下载。这本书主要教程序员们怎么在Linux下做软件和编程序。
* [IBM’s Technical Library](https://www.ibm.com/developerworks/views/linux/libraryview.jsp?type_by=Tutorials) – IBM’s Technical Library 提供的一组给高级Linux用户的教程。
* [HAPPY HACKING LINUX](https://azer.bike/happy-hacking-linux/)
* [linuxkit/linuxkit](https://github.com/linuxkit/linuxkit):A toolkit for building secure, portable and lean operating systems for containers
* [jaywcjlove/linux-command](https://github.com/jaywcjlove/linux-command):Linux命令大全搜索工具，内容包含Linux命令手册、详解、学习、搜集。https://git.io/linux https://git.io/linux
* [feiskyer/linux-perf-examples](https://github.com/feiskyer/linux-perf-examples):《Linux 性能优化实战》案例
* [trimstray/test-your-sysadmin-skills](https://github.com/trimstray/test-your-sysadmin-skills):A collection of *nix Sysadmin Test Questions and Answers. Test your knowledge and skills in different fields with these Q/A.
* [aleksandar-todorovic/awesome-linux](https://github.com/aleksandar-todorovic/awesome-linux):🐧 A list of awesome projects and resources that make Linux even more awesome. 🐧
* [learnbyexample/Command-line-text-processing](https://github.com/learnbyexample/Command-line-text-processing):From finding text to search and replace, from sorting to beautifying text and more
* [面向 Linux 程序员和系统管理员的技术资源](https://www.ibm.com/developerworks/cn/linux/)

## 工具

* [backup/backup](https://github.com/backup/backup):Easy full stack backup operations on UNIX-like systems. http://backup.github.io/backup/v4/
* [gopasspw/gopass](https://github.com/gopasspw/gopass):The slightly more awesome standard unix password manager for teams https://www.gopass.pw/
* [trimstray/iptables-essentials](https://github.com/trimstray/iptables-essentials):Iptables Essentials: Common Firewall Rules and Commands.
* [bat](link):A Cat Clone With Syntax Highlighting And Git Integration https://www.ostechnix.com/bat-a-cat-clone-with-syntax-highlighting-and-git-integration/
* [akavel/up](https://github.com/akavel/up):Ultimate Plumber is a tool for writing Linux pipes with instant live preview
* [iovisor/bcc](https://github.com/iovisor/bcc):BCC - Tools for BPF-based Linux IO analysis, networking, monitoring, and more
* [Monit](https://mmonit.com/monit/):功能异常强大的进程、文件、设备、系统监控软件，适用于Linux/Unix系统

systemctl unmask mysql.service
service mysql start

dpkg --get-selections | grep hold
sudo aptitude install <packagename>

sudo dpkg --configure -a # fixing broken dependencies
sudo apt-get install -f

sudo uname --m

Failed to start mysql.service: Unit mysql.service is masked.

systemctl unmask mysql.service
service mysql start
