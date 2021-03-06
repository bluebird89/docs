# [趣谈Linux操作系统](https://time.geekbang.org/column/intro/164)


* 综述
	*  Linux 内核结构
	* 上手 linux 命令
	* 学习系统调用
* 系统初始化
	* 8086->x86 架构演化
	* BIOS->bootloader
	* 内核初始化
		* 子系统创建
		* 用户态祖先进程创建
		* 内核态祖先进程创建
* 进程管理
	* 进程创建：编译、连接：.so
	* 创建线程，线程都有哪些数据，如何对线程数据进行保护
	* 进程数据结构：用户态函数栈与内核态函数栈
	* 调度：主动与抢占式
	* 进程线程创建
* 内存管理
	* 虚拟内存空间的管理、物理内存的管理以及内存映射
	* 进程虚拟内存的布局
	* 物理内存的组织+分配机制
	* 小内存分配+页面换出
	* 用户态内存映射

## 基础

* 汇编
* C语言
* 计算机组成与结构

## 结构发展

### 初创期:x86 体系结->系统的启动->实模式

* 角色切换成软件外包公司的老板，设身处地地去理解操作系统是如何协调各种资源，帮客户做成事情的。“用户”：指操作系统的用户，“客户”：外包公司的客户
* 输入设备驱动|客户对接员
	* 客户发送的需求就被称为中断事件（Interrupt Event）。
* 项目执行计划书：说明这个项目打算怎么做，一步一步如何执行，遇到什么情况应该怎么办等等，都已经作为程序逻辑写在程序里面，并且编译成为二进制
	* 文件管理子系统（File Management Subsystem
	* 程序（Program）二进制文件是静态的
	* 进程（Process）运行起来的 QQ，是不断进行的
	* 打印机的直接操作是放在操作系统内核里面的，进程不能随便操作。但是操作系统也提供一个办事大厅|系统调用（System Call）
		* 任何一个程序要想运行起来，就需要调用系统调用，创建进程。
	* 进程管理子系统（Process Management Subsystem）
		* 进程执行需要分配 CPU 进行执行，也就是按照程序里面的二进制代码一行一行地执行
		* 如果运行进程很多，则一个 CPU 会并发运行多个进程，也就需要 CPU 的调度能力了
	* 内存管理子系统（Memory Management Subsystem）
		* 统一的管理和分配：不同的进程有不同的内存空间
* 交付人员|输出设备驱动：显卡驱动

![操作系统内核体系结构图](../_static/os_kernal_arch.jpg)

#### 计算机构成

* 组成
	* CPU Central Processing Unit，中央处理器
		* 运算单元
			* 只管算，例如做加法、做位移等等。但是，它不知道应该算哪些数据，运算结果应该放在哪里。
			* 运算单元计算的数据如果每次都要经过总线，到内存里面现拿，这样就太慢了，所以就有了数据单元。
		* 数据单元包括 CPU 内部的缓存和寄存器组，空间很小，但是速度飞快，可以暂时存放数据和运算结果。有了放数据的地方，也有了算的地方，还需要有个指挥到底做什么运算的地方，这就是控制单元。
		* 控制单元是一个统一的指挥中心，可以获得下一条指令，然后执行这条指令。这个指令会指导运算单元取出数据单元中的某几个数据，计算出个结果，然后放在数据单元的某个地方。
	* 总线（Bus）CPU 和其他设备连接，就是主板上密密麻麻的集成电路，这些东西组成了 CPU 和其他设备的高速通道
		* 地址总线（Address Bus） 地址数据，也就是想拿内存中哪个位置的数据
		* 数据总线（Data Bus）真正的数据
		* 地址总线的位数，决定了能访问的地址范围到底有多广
		* 显卡会连接显示器、磁盘控制器会连接硬盘、USB 控制器会连接键盘和鼠标
	* 内存就相当于办公室，要看看方不方便租到办公室，有没有什么创新科技园之类的。有了共享的、便宜的办公位，公司就有注册地了
* CPU 和内存是完成计算任务的核心组件，重点介绍一下 CPU 和内存是如何配合工作的。
	* 每个进程都有一个程序放在硬盘上，是二进制的，再里面就是一行行的指令，会操作一些数据。
	* 运行进程 A 和 B，会有独立的内存空间，互相隔离，程序会分别加载到进程 A 和进程 B 的内存空间里面，形成各自的代码段。进程的内存虽然隔离但不连续，除了简单的区分代码段和数据段，还会分得更细。
	* 程序运行的过程中要操作的数据和产生的计算结果，都会放在数据段里面.
		* 控制单元里面，有一个指令指针寄存器，里面存放的是下一条指令在内存中的地址。控制单元会不停地将代码段的指令拿进来，先放入指令寄存器。指令分两部分，一部分是做什么操作，例如是加法还是位移；一部分是操作哪些数据。
		* 执行这条指:把第一部分交给运算单元，第二部分交给数据单元。
		* 数据单元根据数据的地址，从数据段里读到数据寄存器里，就可以参与运算了。
		* 运算单元做完运算，产生的结果会暂存在数据单元的数据寄存器里。最终，会有指令将数据写回内存中的数据段。
	* 进程切换（Process Switch）:两个寄存器，专门保存当前处理进程的代码段的起始地址，以及数据段的起始地址。这里面写的都是进程 A，那当前执行的就是进程 A 的指令，等切换成进程 B，就会执行 B 的指令了
	* CPU 和内存来来回回传数据，靠的都是总线

#### x86架构

* IBM 开始做 IBM PC 时，一开始并没有让最牛的华生实验室去研发，而是交给另一个团队。一年时间，软硬件全部自研根本不可能完成，于是他们采用了英特尔的 8088 芯片作为 CPU，使用微软的 MS-DOS 做操作系统。
* IBM PC 卖得超级好，好到因为垄断市场而被起诉。IBM 就在被逼的情况下公开了一些技术，使得后来无数 IBM-PC 兼容机公司的出现，也就有了后来占据市场的惠普、康柏、戴尔等等。
* 开放自己的技术是一件了不起的事。从技术和发展的层面来讲，使得一项技术大面积铺开，形成行业标准。就比如现在常用的 Android 手机，如果没有开放的 Android 系统，也没办法享受到这么多不同类型的手机。
* 英特尔的技术因此成为了行业的开放事实标准。由于这个系列开端于 8086，因此称为 x86 架构。
* 后来英特尔的 CPU 数据总线和地址总线越来越宽，处理能力越来越强。但是一直不能忘记三点，一是标准，二是开放，三是兼容。
* 8086 处理器|实模式（Real Pattern）
	* 8 个 16 位的通用寄存器|数据单元: AX、BX、CX、DX、SP、BP、SI、DI。这些寄存器主要用于在计算过程中暂存数据。
	* IP 寄存器|指令指针寄存器（Instruction Pointer Register):指向代码段中下一条指令的位置。CPU 会根据它来不断地将指令从内存的代码段中，加载到 CPU 的指令队列中，然后交给运算单元去执行。
	* 切换进程:每个进程都分代码段和数据段，为了指向不同进程的地址空间，有四个 16 位的段寄存器
		* CS |代码段寄存器（Code Segment Register），通过它可以找到代码在内存中的位置
		* DS |数据段寄存器，通过它可以找到数据在内存中的位置。
		* SS |栈寄存器（Stack Register）。栈是程序运行中一个特殊的数据结构，数据的存取只能从一端进行，秉承后进先出的原则，push 就是入栈，pop 就是出栈。
			* 凡是与函数调用相关的操作，都与栈紧密相关
		* 加载到通用寄存器:对于一个段，有一个起始的地址，而段内的具体位置，称为偏移量（Offset）
		* 在 CS 和 DS 中都存放着一个段的起始地址。代码段偏移量在 IP 寄存器中，数据段的偏移量会放在通用寄存器中
	* CS 和 DS 都是 16 位的，起始地址都是 16 位的，IP 寄存器和通用寄存器都是 16 位的，偏移量也是 16 位的，但是 8086 的地址总线地址是 20 位
		* 偏移量 16 位的，所以一个段最大的大小是 2^16=64k。
		* 最多只能访问 1M 的内存空间，还要分成多个段，每个段最多 64K。
		* 每次都要左移四位，也就意味着段的起始地址不能是任何一个地方，只是能整除 16 的地方。
* 32 位处理器|保护模式（Protected Pattern）
	* 有 32 根地址总线，可以访问 2^32=4G 的内存
	* 在开放架构的基础上，如何保持兼容
		* 通用寄存器有扩展，可以将 8 个 16 位的扩展到 8 个 32 位的，但是依然可以保留 16 位的和 8 位的使用方式。你可能会问，为什么高 16 位不分成两个 8 位使用呢？因为这样就不兼容了呀！
		* 指令指针寄存器 IP，就会扩展成 32 位的，同样也兼容 16 位的
		* 改动比较大，有点不兼容的就是段寄存器（Segment Register）
			* CS、SS、DS、ES 仍然是 16 位的，但是不再是段的起始地址。
			* 段的起始地址放在内存的某个地方。这个地方是一个表格，表格中的一项一项是段描述符（Segment Descriptor）。这里面才是真正的段的起始地址。而段寄存器里面保存的是在这个表格中的哪一项，称为选择子（Selector）。
			* 将一个从段寄存器直接拿到的段起始地址，就变成了先间接地从段寄存器找到表格中的一项，再从表格中的一项中拿到段起始地址。
			* 为了快速拿到段起始地址，段寄存器会从内存中拿到 CPU 的描述符高速缓存器中。
*  刚开机为实模式, 需要更多内存切换到保护模式
	
![8086 架构](../_static/8086_arch.jpg)
![x86_upgrade](../_static/x86_upgrade.jpg)

#### 汇编语言

* 《汇编从零开始到C语言》

```
move a b :把b值赋给a,使a=b  
add a b : 加法,a=a+b  
inc: 加1  
dec: 减1  
sub a b : a=a-b  
cmp: 减法比较，修改标志位

call和ret :call调用子程序，子程序以ret结尾 
jmp :无条件跳  
int :中断指令  

or :或运算  
xor :异或运算  
shl :算术左移  
ahr :算术右移  

push xxx :压xxx入栈  
pop xxx: xxx出栈  
```

### 发展期：保护模式、多进程->进程管理、内存管理、文件系统、输入输出设备管理

####  从BIOS到bootloader

* BIOS 时期
	* 主板上电
		* 做一些重置的工作，将 CS 设置为 0xFFFF，将 IP 设置为 0x0000，所以第一条指令就会指向 0xFFFF0（CS要左移四位），正是在 ROM 的范围内。
		* 有一个 JMP 命令会跳到 ROM 中做初始化工作的代码，于是，BIOS 开始进行初始化的工作
	* 主板 ROM（Read Only Memory，只读存储器）固化一些初始化的程序 BIOS（Basic Input and Output System，基本输入输出系统）
		* 在 x86 系统中，将 1M 空间最上面的 0xF0000 到 0xFFFFF 这 64K 映射给 ROM
	* 要检查系统硬件是不是都好着呢
		* 要建立一个中断向量表和中断服务程序，因为现在还要用键盘和鼠标，这些都要通过中断进行的
		* 在内存空间映射显存的空间，在显示器上显示一些字符。
* bootloader 时期
	* 操作系统一般都会在安装在硬盘上，在 BIOS 的界面上会看到一个启动盘的选项。
		* 启动盘：一般在第一个扇区，占 512 字节，而且以 0xAA55 结束。这是一个约定，当满足这个条件的时候，就说明这是一个启动盘，在 512 字节以内会启动相关的代码。
	* Grub2 Grand Unified Bootloader Version 2 搞系统启动的
		* `grub2-install /dev/sda` 将启动程序安装到相应位置
		* 第一个安装 boot.img。由 boot.S 编译而成，一共 512 字节，正式安装到启动盘的第一个扇区。这个扇区通常称为 MBR（Master Boot Record，主引导记录 / 扇区）。
	* BIOS 完成任务后，会将 boot.img 从硬盘加载到内存中的 0x7c00 来运行
		* 由于 512 个字节实在有限，boot.img 做不了太多的事情。能做的最重要的一个事情就是加载 grub2 的另一个镜像 core.img。
		* core.img 由 lzma_decompress.img、diskboot.img、kernel.img 和一系列的模块组成
		* boot.img 先加载的是 core.img 的第一个扇区。如果从硬盘启动的话，这个扇区里面是 diskboot.img，对应的代码是 diskboot.S
		* boot.img 将控制权交给 diskboot.img 后，diskboot.img 的任务就是将 core.img 的其他部分加载进来，先是解压缩程序 lzma_decompress.img，再往下是 kernel.img，最后是各个模块 module 对应的映像。这里需要注意，它不是 Linux 的内核，而是 grub 的内核。
			* lzma_decompress.img 对应的代码是 startup_raw.S
			* 本来 kernel.img 是压缩过的，现在执行的时候，需要解压缩。
			* 真正的解压缩之前，lzma_decompress.img 做了一个重要的决定，就是调用 real_to_prot，切换到保护模式，这样就能在更大的寻址空间里面，加载更多的东西。
		* kernel.img 解压缩后，然后跳转到 kernel.img 开始运行。
			* kernel.img 对应的代码是 startup.S 以及一堆 c 文件，在 startup.S 中会调用 grub_main，这是 grub kernel 的主函数。这个函数里面，grub_load_config() 开始解析  grub.conf 文件里的配置信息。
			* 正常启动，grub_main 最后会调用 grub_command_execute (“normal”, 0, 0)，最终会调用 grub_normal_execute() 函数。在这个函数里面，grub_show_menu() 会显示出让选择的那个操作系统的列表。
			* 选定启动某个操作系统，就要开始调用 grub_menu_execute_entry() ，开始解析并执行选择的那一项
			* grub_cmd_linux() 函数会被调用，会首先读取 Linux 内核镜像头部的一些数据结构，放到内存中的数据结构来，进行检查。如果检查通过，则会读取整个 Linux 内核镜像到内存
			* 有 initrd 命令，用于为即将启动的内核传递 init ramdisk 路径。于是 grub_cmd_initrd() 函数会被调用，将 initramfs 加载到内存中来。
			* 当这些事情做完之后，grub_command_execute (“boot”, 0, 0) 才开始真正地启动内核。
* 从实模式切换到保护模式
	* 启用分段:在内存里面建立段描述符表，将寄存器里面的段寄存器变成段选择子，指向某个段描述符，这样就能实现不同进程的切换了
	* 启动分页:能够管理的内存变大了，就需要将内存分成相等大小的块
	* 打开 Gate A20 第 21 根地址线的控制线:切换保护模式的函数 DATA32 call real_to_prot 会打开 Gate A20

```sh
# 配置系统启动的选项
grub2-mkconfig -o /boot/grub2/grub.cfg

menuentry 'CentOS Linux (3.10.0-862.el7.x86_64) 7 (Core)' --class centos --class gnu-linux --class gnu --class os --unrestricted $menuentry_id_option 'gnulinux-3.10.0-862.el7.x86_64-advanced-b1aceb95-6b9e-464a-a589-bed66220ebee' {
  load_video
  set gfxpayload=keep
  insmod gzio
  insmod part_msdos
  insmod ext2
  set root='hd0,msdos1'
  if [ x$feature_platform_search_hint = xy ]; then
    search --no-floppy --fs-uuid --set=root --hint='hd0,msdos1'  b1aceb95-6b9e-464a-a589-bed66220ebee
  else
    search --no-floppy --fs-uuid --set=root b1aceb95-6b9e-464a-a589-bed66220ebee
  fi
  linux16 /boot/vmlinuz-3.10.0-862.el7.x86_64 root=UUID=b1aceb95-6b9e-464a-a589-bed66220ebee ro console=tty0 console=ttyS0,115200 crashkernel=auto net.ifnames=0 biosdevname=0 rhgb quiet 
  initrd16 /boot/initramfs-3.10.0-862.el7.x86_64.img
}

```

#### 内核启动

* 《庖丁解牛Linux内核分析》

##### 子系统创建

* 从入口函数 start_kernel() 开始。在 init/main.c 文件中，start_kernel 相当于内核的 main 函数。里面是各种各样初始化函数 XXXX_init
* 进程管理
	* 0 号进程：先要有个创始进程，有一行指令 set_task_stack_end_magic(&init_task)
		* 参数 init_task，定义 struct task_struct init_task = INIT_TASK(init_task)
		* 系统创建的第一个进程，唯一一个没有通过 fork 或者 kernel_thread 产生的进程，是进程列表的第一个。
	* 进程列表（Process List）：列着所有运行进程
* 中断管理：对应函数 trap_init()，里面设置了很多中断门（Interrupt Gate），用于处理各种中断
	* 系统调用的中断门 set_system_intr_gate(IA32_SYSCALL_VECTOR, entry_INT80_32)
	* 系统调用也是通过发送中断的方式进行
* 内存管理
	* mm_init() 初始化内存管理模块
	* sched_init() 初始化调度模块
	* vfs_caches_init() 初始化基于内存的文件系统 rootfs
		* 调用 mnt_init()->init_rootfs()。
		* register_filesystem(&rootfs_fs_type)。在 VFS 虚拟文件系统里面注册了一种类型，定义为 struct file_system_type rootfs_fs_type。
* 文件系统 
	* VFS（Virtual File System），虚拟文件系统：为兼容各种各样的文件系统，将文件的相关数据结构和操作抽象出来，形成一个对上提供统一的接口的抽象层
* 调用 rest_init()，用来做其他方面的初始化

##### 初始化 1 号进程 ：形成用户态所有进程祖先

* rest_init 第一大工作 用 kernel_thread(kernel_init, NULL, CLONE_FS) 创建第二个进程  1 号进程。
* 1 号进程对于操作系统来讲，有“划时代”的意义。因为它将运行一个用户进程，这意味着这个公司把一个老板独立完成的制度，变成了可以交付他人完成的制度。这个 1 号进程就相当于老板带了一个大徒弟，有了第一个，就有第二个，后面大徒弟开枝散叶，带了很多徒弟，形成一棵进程树。
	* 1 号进程是 /sbin/init。在 centOS 7 里面，这个进程是被软链接到 systemd
	* init 进程会启动很多的 daemon 进程，为系统运行提供服务，然后启动 getty，让用户登录，登录后运行 shell，用户启动的进程都是通过 shell 运行的，从而形成了一棵进程树。
	* ps -ef 命令查看当前系统启动的进程
		* 用户态的不带中括号，内核态的带中括号
		* 内核态进程祖先是 2 号进程
		* 用户态进程祖先是 1 号进程
		* tty 那一列带问号的，说明不是前台启动的，一般都是后台的服务。
* 一旦有了用户进程，公司的运行模式就要发生一定的变化。因为原来你是老板，没有雇佣其他人，所有东西都是你的，无论多么关键的资源，第一，不会有人给你抢，第二，不会有人恶意破坏、恶意使用。有了其他人，就要开始做一定的区分，用户权限
* x86 提供了分层的权限机制，把区域分成了四个 Ring，越往里权限越高，越往外权限越低：Ring 0 内核->Ring 1 设备驱动->Ring 2设备驱动->Ring 3 应用
* 操作系统很好地利用这个机制，将能够访问关键资源的代码放在 Ring0，称为内核态（Kernel Mode）；将普通的程序代码放在 Ring3，称为用户态（User Mode）.保护模式中，处于用户态代码想要执行更高权限的指令行为是被禁止的，要防止他们为所欲为
* 从内核态到用户态
	* kernel_thread 在内核态，到用户态去运行一个程序
		* 参数 函数 kernel_init，1号进程会运行 kernel_init 函数（回调）
		* 在 kernel_init 里面，会调用 kernel_init_freeable()
	* run_init_process()->do_execve()（execve 系统调用实现）
		* 尝试运行 **ramdisk 的“/init”**，或者普通文件系统上的“/sbin/init”“/etc/init”“/bin/init”“/bin/sh”。不同版本的 Linux 会选择不同的文件启动，但是只要有一个起来了就可以
	* do_execve->do_execveat_common->exec_binprm->search_binary_handler
		* 要运行一个程序，需要加载二进制文件，它是有一定格式的。Linux 下常用格式 ELF（Executable and Linkable Format，可执行与可链接格式）
		* 先调用 load_elf_binary，最后调用 start_thread
	* start_thread
		* 保存寄存器：struct pt_regs 系统调用的时候，内核中保存用户态运行上下文
		* 最后的 iret：用于从系统调用中返回。恢复寄存器。从哪里恢复呢？按说是从进入系统调用的时候，保存的寄存器里面拿出。好在上面的函数补上了寄存器。CS 和指令指针寄存器 IP 恢复了，指向用户态下一个要执行的语句。DS 和函数栈指针 SP 也被恢复了，指向用户态函数栈的栈顶。所以，下一条指令，就从用户态开始运行了。
* ramdisk 作用
	* init 终于从内核到用户态了。一开始到用户态的是 ramdisk 的 init，后来会启动真正根文件系统上的 init，成为所有用户态进程的祖先
	* `initrd16 /boot/initramfs-3.10.0-862.el7.x86_64.img` 基于内存的文件系统
		* 上面 的 init 程序是在文件系统上的，文件系统一定是在一个存储设备上的，例如硬盘。Linux 访问存储设备，要有驱动才能访问。如果存储系统数目很有限，那驱动可以直接放到内核里面，前面加载过内核到内存里了，可以直接对存储系统进行访问。
		* 但是存储系统越来越多了，如果所有市面上的存储系统的驱动都默认放进内核，内核就太大了
		* 先弄一个基于内存的文件系统。内存访问是不需要驱动的，这个就是 ramdisk。这个时候，ramdisk 是根文件系统。
	* 运行 ramdisk 上的 /init。等它运行完就已经在用户态了。/init 这个程序会先根据存储系统的类型加载驱动，有了驱动就可以设置真正的根文件系统了。有了真正的根文件系统，ramdisk 上的 /init 会启动文件系统上的 init。

```c
# kernel_init
  if (ramdisk_execute_command) {
    ret = run_init_process(ramdisk_execute_command);
......
  }
......
  if (!try_to_run_init_process("/sbin/init") ||
      !try_to_run_init_process("/etc/init") ||
      !try_to_run_init_process("/bin/init") ||
      !try_to_run_init_process("/bin/sh"))
    return 0;

# kernel_init_freeable
if (!ramdisk_execute_command)
    ramdisk_execute_command = "/init";
	

static int run_init_process(const char *init_filename)
{
  argv_init[0] = init_filename;
  return do_execve(getname_kernel(init_filename),
    (const char __user *const __user *)argv_init,
    (const char __user *const __user *)envp_init);
}


int search_binary_handler(struct linux_binprm *bprm)
{
  ......
  struct linux_binfmt *fmt;
  ......
  retval = fmt->load_binary(bprm);
  ......
}


static struct linux_binfmt elf_format = {
.module  = THIS_MODULE,
.load_binary  = load_elf_binary,
.load_shlib  = load_elf_library,
.core_dump  = elf_core_dump,
.min_coredump  = ELF_EXEC_PAGESIZE,
};


void
start_thread(struct pt_regs *regs, unsigned long new_ip, unsigned long new_sp)
{
set_user_gs(regs, 0);
# 保存用户态寄存器
regs->fs  = 0;
regs->ds  = __USER_DS;
regs->es  = __USER_DS;
regs->ss  = __USER_DS;
regs->cs  = __USER_CS;
regs->ip  = new_ip;
regs->sp  = new_sp;
regs->flags  = X86_EFLAGS_IF;

force_iret();
}
EXPORT_SYMBOL_GPL(start_thread);
```

##### 创建 2 号进程

* rest_init 第二大事情就是第三个进程，就是 2 号进程
* kernel_thread(kthreadd, NULL, CLONE_FS | CLONE_FILES) 又一次使用 kernel_thread 函数创建进程。
	- 函数名 thread 可以翻译成“线程”
	- 从内核态来看，无论是进程，还是线程，可以统称为任务（Task），都使用相同的数据结构，平放在同一个链表中
	- kthreadd，负责所有内核态的线程的调度和管理，是内核态所有线程运行的祖先。

### 壮大期：进程间通信->网络通信

### 集团化：虚拟化->容器化->Linux 集群->从单机操作系统到数据中心操作系统


## 能力发展

### 熟练使用 Linux 命令行 Command Line

* 用户 `/etc/passwd` 
	* 主目录:用户登录进去后默认的路径
	* /bin/bash 位置:配置登录后默认交互命令行
	* `passwd [username]`
	* `useradd -h`
* 组 `/etc/groups`
* 图书
	* 《鸟哥的Linux私房菜》
	* 《Linux 系统管理技术手册》

### 使用 Linux 进行程序设计

* 直接使用 Linux 系统调用，也可以使用 glibc 的库
* 图书
	* 补充：优先《Unix/Linux编程实践教程》
	* 《UNIX环境高级编程》

### 了解 Linux 内核机制

* 了解一下 Linux 内核机制，知道基本的原理和流程
* 图书
	* 补充：《庖丁解牛Linux内核分析》
	* 《深入理解Linux内核》


### 阅读 Linux 内核代码，聚焦核心逻辑和场景

* 一开始阅读代码不要纠结一城一池的得失，不要每一行都一定要搞清楚它是干嘛的，而要聚焦于核心逻辑和使用场景。
* 图书
	* 《Linux内核源代码情景分析》


### 实验定制 Linux 组件

* 一旦代码有一个细微的 bug，都有可能导致实验失败。

### 生产实践

## 组件

### [系统调用](https://www.kernel.org)

* 系统调用的定义 unistd_64.h

#### Glibc

* Glibc 是 Linux 下使用的开源的标准 C 库，它是 GNU 发布的 libc 库。Glibc 为程序员提供丰富的 API，除了例如字符串处理、数学运算等用户态服务之外，最重要的是封装了操作系统提供的系统服务，即系统调用的封装。
	* 每个特定的系统调用对应了至少一个 Glibc 封装的库函数
	* 有时候，Glibc 一个单独的 API 可能调用多个系统调用，比如说，Glibc 提供的 printf 函数就会调用如 sys_open、sys_mmap、sys_write、sys_close 等等系统调用。
	* 也有时候，多个 API 也可能只对应同一个系统调用，如 Glibc 下实现的 malloc、calloc、free 等函数用来分配和释放内存，都利用了内核的 sys_brk 的系统调用。
* syscalls.lis 列着所有 glibc 的函数对应的系统调用
* 脚本 make-syscall.sh 可以根据上面的配置文件，对于每一个封装好的系统调用，生成一个文件。这个文件里面定义了一些宏，例如 `#define SYSCALL_NAME open`
* syscall-template.S，使用上面这个宏，定义了这个系统调用的调用方式。
* PSEUDO 也一个宏,对于任何一个系统调用，会调用 DO_CALL。
* DO_CALL也是一个宏，这个宏 32 位和 64 位的定义是不一样的。

##### 32 位系统调用

* ENTER_KERNEL:int $0x80 就是触发一个软中断，通过它就可以陷入（trap）内核
* 触发内核启动时 `set_system_intr_gate(IA32_SYSCALL_VECTOR, entry_INT80_32);`进入系统调用
* do_syscall_32_irqs_on
	* 将系统调用号从 eax 里面取出来，然后根据系统调用号，在系统调用表中找到相应的函数进行调用，并将寄存器中保存的参数取出来，作为函数参数。
	* 如果仔细比对，发现这些参数所对应的寄存器，和 Linux 的注释是一样的。
	* 根据宏定义，#define ia32_sys_call_table sys_call_table，系统调用就是放在这个表里面。
* 当系统调用结束之后，在 entry_INT80_32 之后，紧接着调用的是 INTERRUPT_RETURN，能够找到它的定义，也就是 iret
* iret 指令将原来用户态保存的现场恢复回来，包含代码段、指令指针寄存器等。这时候用户态进程恢复执行。

![32位系统调用](../_static/32_syscall.jpg)

```
# i386/sysdep.h
/* Linux takes system call arguments in registers:
  syscall number  %eax       call-clobbered
  arg 1    %ebx       call-saved
  arg 2    %ecx       call-clobbered
  arg 3    %edx       call-clobbered
  arg 4    %esi       call-saved
  arg 5    %edi       call-saved
  arg 6    %ebp       call-saved
......
*/
#define DO_CALL(syscall_name, args)                           \
    PUSHARGS_##args                               \
    DOARGS_##args                                 \
    movl $SYS_ify (syscall_name), %eax;                          \
    ENTER_KERNEL                                  \
    POPARGS_##args

# define ENTER_KERNEL int $0x80

# 内核启动的时候 trap_init()，软中断的陷入门。当接收到一个系统调用的时候，entry_INT80_32 就被调用了
set_system_intr_gate(IA32_SYSCALL_VECTOR, entry_INT80_32);


ENTRY(entry_INT80_32)
        ASM_CLAC
		# 将当前用户态的寄存器，保存在 pt_regs 结构里面
        pushl   %eax                    /* pt_regs->orig_ax */
        SAVE_ALL pt_regs_ax=$-ENOSYS    /* save rest */
        movl    %esp, %eax
        call    do_syscall_32_irqs_on
.Lsyscall_32_done:
......
.Lirq_return:
  INTERRUPT_RETURN
 

static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs)
{
  struct thread_info *ti = current_thread_info();
  unsigned int nr = (unsigned int)regs->orig_ax;
......
  if (likely(nr < IA32_NR_syscalls)) {
    regs->ax = ia32_sys_call_table[nr](
      (unsigned int)regs->bx, (unsigned int)regs->cx,
      (unsigned int)regs->dx, (unsigned int)regs->si,
      (unsigned int)regs->di, (unsigned int)regs->bp);
  }
  syscall_return_slowpath(regs);
}


#define INTERRUPT_RETURN                iret
```

##### 64 位系统调用

* 系统调用名称转换为系统调用号，放到寄存器 rax。这里不是用中断了，而是改用 syscall 指令真正进行调用
* 特殊模块寄存器（Model Specific Registers，简称 MSR）:CPU 为完成某些特殊控制功能为目的的寄存器.syscall 指令使用了这种特殊的寄存器.
* 系统初始化的时候，trap_init 除了初始化上面的中断模式，还会调用 cpu_init->syscall_init。`wrmsrl(MSR_LSTAR, (unsigned long)entry_SYSCALL_64);`
	* rdmsr 和 wrmsr 用来读写特殊模块寄存器的
	* MSR_LSTAR 就是这样一个特殊的寄存器，当 syscall 指令调用的时候，会从这个寄存器里面拿出函数地址来调用，就是调用 entry_SYSCALL_64。
		* 保存很多寄存器到 pt_regs 结构
		* 调用 entry_SYSCALL64_slow_pat->do_syscall_64
		* do_syscall_64 里面，从 rax 里面拿出系统调用号，然后根据系统调用号，在系统调用表 sys_call_table 中找到相应的函数进行调用，并将寄存器中保存的参数取出来，作为函数参数。如果仔细比对就能发现，这些参数所对应的寄存器，和 Linux 的注释又是一样的。
	* 系统调用返回的时候，执行的是 USERGS_SYSRET64
* 无论是 32 位，还是 64 位，都会到系统调用表 sys_call_table 这里来
	* 32 位系统调用表 arch/x86/entry/syscalls/syscall_32.tbl  
	* 64 位系统调用表  arch/x86/entry/syscalls/syscall_64.tbl
	* 声明 系统调用在内核中的实现函数 include/linux/syscalls.h
	* 实现系统调用，一般在一个.c 文件里面，例如 sys_open 的实现在 fs/open.c 里面
		* SYSCALL_DEFINE3 是一个宏系统调用最多六个参数，根据参数的数目选择宏。
		* 相当于模板函数
	* 编译 根据 syscall_32.tbl 和 syscall_64.tbl 生成自己的 unistd_32.h 和 unistd_64.h。生成方式在 arch/x86/entry/syscalls/Makefile 中，使用两个脚本
		* arch/x86/entry/syscalls/syscallhdr.sh，会在文件中生成 `#define __NR_open`
		* arch/x86/entry/syscalls/syscalltbl.sh，会在文件中生成` __SYSCALL(__NR_open, sys_open)`
	* unistd_32.h 和 unistd_64.h 是对应的系统调用号和系统调用实现函数之间的对应关系。
	* arch/x86/entry/syscall_32.c，定义了这样一个表，里面 include 这个头文件，从而所有的 sys_ 系统调用都在这个表里面了
	* 在文件 arch/x86/entry/syscall_64.c，定义了这样一个表，里面 include 了这个头文件，这样所有的 sys_ 系统调用就都在这个表里面了

![64位系统调用](../_static/64_syscall.jpg)

```c
# x86_64/sysdep.h 
/* The Linux/x86-64 kernel expects the system call parameters in
   registers according to the following table:
    syscall number  rax
    arg 1    rdi
    arg 2    rsi
    arg 3    rdx
    arg 4    r10
    arg 5    r8
    arg 6    r9
......
*/
#define DO_CALL(syscall_name, args)                \
  lea SYS_ify (syscall_name), %rax;                \
  syscall

wrmsrl(MSR_LSTAR, (unsigned long)entry_SYSCALL_64);

# arch/x86/entry/entry_64.S
ENTRY(entry_SYSCALL_64)
        /* Construct struct pt_regs on stack */
        pushq   $__USER_DS                      /* pt_regs->ss */
        pushq   PER_CPU_VAR(rsp_scratch)        /* pt_regs->sp */
        pushq   %r11                            /* pt_regs->flags */
        pushq   $__USER_CS                      /* pt_regs->cs */
        pushq   %rcx                            /* pt_regs->ip */
        pushq   %rax                            /* pt_regs->orig_ax */
        pushq   %rdi                            /* pt_regs->di */
        pushq   %rsi                            /* pt_regs->si */
        pushq   %rdx                            /* pt_regs->dx */
        pushq   %rcx                            /* pt_regs->cx */
        pushq   $-ENOSYS                        /* pt_regs->ax */
        pushq   %r8                             /* pt_regs->r8 */
        pushq   %r9                             /* pt_regs->r9 */
        pushq   %r10                            /* pt_regs->r10 */
        pushq   %r11                            /* pt_regs->r11 */
        sub     $(6*8), %rsp                    /* pt_regs->bp, bx, r12-15 not saved */
        movq    PER_CPU_VAR(current_task), %r11
        testl   $_TIF_WORK_SYSCALL_ENTRY|_TIF_ALLWORK_MASK, TASK_TI_flags(%r11)
        jnz     entry_SYSCALL64_slow_path
......
entry_SYSCALL64_slow_path:
        /* IRQs are off. */
        SAVE_EXTRA_REGS
        movq    %rsp, %rdi
        call    do_syscall_64           /* returns with IRQs disabled */
return_from_SYSCALL_64:
  RESTORE_EXTRA_REGS
  TRACE_IRQS_IRETQ
  movq  RCX(%rsp), %rcx
  movq  RIP(%rsp), %r11
    movq  R11(%rsp), %r11
......
syscall_return_via_sysret:
  /* rcx and r11 are already restored (see code above) */
  RESTORE_C_REGS_EXCEPT_RCX_R11
  movq  RSP(%rsp), %rsp
  USERGS_SYSRET64 
  

__visible void do_syscall_64(struct pt_regs *regs)
{
        struct thread_info *ti = current_thread_info();
        unsigned long nr = regs->orig_ax;
......
        if (likely((nr & __SYSCALL_MASK) < NR_syscalls)) {
                regs->ax = sys_call_table[nr & __SYSCALL_MASK](
                        regs->di, regs->si, regs->dx,
                        regs->r10, regs->r8, regs->r9);
        }
        syscall_return_slowpath(regs);
}
 
#define USERGS_SYSRET64        \
  swapgs;          \
  sysretq;
  
## 系统调用表
# 系统调用表定义 arch/x86/entry/syscalls/syscall_64.tbl
2 common open sys_open

# 系统调用在内核中的实现函数 声明 include/linux/syscalls.h
asmlinkage long sys_open(const char __user *filename,
                                int flags, umode_t mode);

# 系统调用 实现 fs/open.c
SYSCALL_DEFINE3(open, const char __user *, filename, int, flags, umode_t, mode)
{
        if (force_o_largefile())
                flags |= O_LARGEFILE;
        return do_sys_open(AT_FDCWD, filename, flags, mode);
}


#define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
#define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
#define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
#define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
#define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
#define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)


#define SYSCALL_DEFINEx(x, sname, ...)                          \
        SYSCALL_METADATA(sname, x, __VA_ARGS__)                 \
        __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)


#define __PROTECT(...) asmlinkage_protect(__VA_ARGS__)
#define __SYSCALL_DEFINEx(x, name, ...)                                 \
        asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       \
                __attribute__((alias(__stringify(SyS##name))));         \
        static inline long SYSC##name(__MAP(x,__SC_DECL,__VA_ARGS__));  \
        asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__));      \
        asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))       \
        {                                                               \
                long ret = SYSC##name(__MAP(x,__SC_CAST,__VA_ARGS__));  \
                __MAP(x,__SC_TEST,__VA_ARGS__);                         \
                __PROTECT(x, ret,__MAP(x,__SC_ARGS,__VA_ARGS__));       \
                return ret;                                             \
        }                                                               \
        static inline long SYSC##name(__MAP(x,__SC_DECL,__VA_ARGS__)


## arch/x86/entry/syscall_32.c
__visible const sys_call_ptr_t ia32_sys_call_table[__NR_syscall_compat_max+1] = {
        /*
         * Smells like a compiler bug -- it doesn't work
         * when the & below is removed.
         */
        [0 ... __NR_syscall_compat_max] = &sys_ni_syscall,
#include <asm/syscalls_32.h>
};

## arch/x86/entry/syscall_64.c
/* System call table for x86-64. */
asmlinkage const sys_call_ptr_t sys_call_table[__NR_syscall_max+1] = {
  /*
   * Smells like a compiler bug -- it doesn't work
   * when the & below is removed.
   */
  [0 ... __NR_syscall_max] = &sys_ni_syscall,
#include <asm/syscalls_64.h>
};
```

#### 进程

* fork 创建进程
	* 需要一个老的进程调用 fork 来实现，其中老进程叫作父进程（Parent Process），新进程叫作子进程（Child Process）
	* 子进程将各个子系统为父进程创建的数据结构全部拷贝了一份，甚至连程序代码也是拷贝过来的
	* 返回值
		* 如果当前进程是子进程，返回 0
		* 如果当前进程是父进程，返回子进程的进程号
		* 通过返回值做区分，使用 if-else 语句判断
			* 如果是父进程，接着做原来应该做的事情
			* 如果是子进程，请求另一个系统调用execve来执行另一个程序（运行一个执行文件），这个时候，子进程和父进程就彻底分道扬镳了，也就产生了一个分支（fork）了。
* exec 最终调用的 load_elf_binary，是一组函数
	* 含 p 函数（execvp, execlp）会在 PATH 路径下面寻找程序
	* 不含 p 函数需要输入程序的全路径
	* 含 v 函数（execv, execvp, execve）以数组形式接收参数
	* 含 l 函数（execl, execlp, execle）以列表形式接收参数
	* 含 e 函数（execve, execle）以数组形式接收环境变量
* waitpid 父进程调用，将子进程的进程号作为参数传给它，这样父进程就知道子进程运行完了没有，成功与否

#### 内存

*  堆里面分配内存的系统调用
* brk：当分配的内存数量比较小的时候使用，会和原来的堆的数据连在一起，这就像多分配两三个工位，在原来的区域旁边搬两把椅子就行了
* mmap：当分配的内存数量比较大的时候使用，会重新划分一块区域，也就是说，当办公空间需要太多的时候，索性来个一整块。

#### 文件操作

* 不存在文件 create 创建
* 已存在文件 open 打开，close关闭
* 打开文件后 lseek 跳到文件某个位置
* 读写内容:读 read，写 write

### 文件系统

* 属性
	* 第一个字段
		* 第一个字符：类型
			* “-” 表示普通文件
			* d 表示目录
		* 剩下的9 个字符 模式|权限位（access permission bits）
			- 3 个一组，每一组 rwx 表示“读（read）”“写（write）”“执行（execute）”
			- 如果是字母，就说明有这个权限
			- 如果是横线，就是没有这个权限
	- 第二个字段:硬链接（hard link）数目
	- 第三个字段是所属用户
	- 第四个字段是所属组
	- 第五个字段是文件的大小
	- 第六个字段是文件被修改的日期
	- 最后是文件名
* 一切皆文件
	* 二进制文件：启动一个进程，需要一个程序文件
	* 文本文件：启动的时候，要加载一些配置文件，例如 yml、properties 等，这是
	* 启动之后会打印一些日志，如果写到硬盘上，也是文本文件。但是如果想把日志打印到交互控制台上，在命令行上唰唰地打印出来，这其实也是一个文件，是标准输出 stdout 文件。
	* 管道:进程的输出可以作为另一个进程的输入，管道也是一个文件。
	* 进程可以通过网络和其他进程进行通信，建立的 Socket，也是一个文件。
	* 进程需要访问外部设备，设备也是一个文件。
	* 文件都被存储在文件夹里面，其实文件夹也是一个文件。
	* 进程运行起来，要想看到进程运行的情况，会在 /proc 下面有对应的进程号，还是一系列文件
* 每个文件，Linux 都会分配一个文件描述符（File Descriptor），这是一个整数。有了这个文件描述符，可以使用系统调用，查看或者干预进程运行的方方面面。
	* 文件操作是贯穿始终的，这也是“一切皆文件”的优势，就是统一了操作的入口，提供了极大的便利

#### 操作

* cd change directory 切换目录
	- cd .. 表示切换到上一级目录
* dir，可以列出当前目录下的文件
* ls list 列出当前目录下的文件 ``

![文件操作各个层的数据结构关联](../_static/linux_file_op.jpg)

```sh
# ls -l
drwxr-xr-x 6 root root 4096 Oct 20 2017 apt
-rw-r--r-- 1 root root 211 Oct 20 2017 hosts
```

#### 软件

* 流程
	* 主执行文件 /usr/bin| /usr/sbin
	* 其他库文件 /var
	* 配置文件 /etc
* 安装
	* 软件包
		* CentOS 体系 .rpm
		* Ubuntu 体系 .deb
	* 软件管家
		* CentOS  yum
			* `/etc/yum.repos.d/CentOS-Base.repo`
		* Ubuntu  apt-get
			* `/etc/apt/sources.list`
	* 二进制文件
		* `wget 链接`
		* 通过 tar 解压缩
		* 配置环境变量
			* 可以通过 export 命令来配置:仅在当前命令行的会话中管用，一旦退出重新登录进来，就不管用了
			* 默认工作目录 .bashrc 文件,每次登录的时候，这个文件都会运行，因而把它放在这里
			* 也可以通过 source .bashrc 手动执行
* 执行
	* Linux 不是根据后缀名来执行的。执行条件是这样的：只要文件有 x 执行权限，都能到文件所在的目录下，通过./filename运行这个程序。
	* 如果放在 PATH 里设置的路径下面，就不用./ 了，直接输入文件名就可以运行了，Linux 会帮你找
	* 通过 shell 在交互命令行里面运行
	* 后台运行 nohup no hang up
		* 最后加一个 &，就表示后台运行
	* 以服务方式运行
		* enable 开机启动:在 /lib/systemd/system 目录下会创建一个 XXX.service 的配置文件，里面定义了如何启动、如何关闭
	* 输出
		* “1”表示文件描述符 1，表示标准输出
		* “2”表示文件描述符 2，意思是标准错误输出
* awk '{print $2}'是指第二列的内容，是运行的程序 ID
* 通过 xargs 传递给 kill -9，也就是发给这个运行的程序一个信号，让它关闭

```sh
# centos
rpm -qa
rpm -i jdk-XXX_linux-x64_bin.rpm
rpm -e # erase

yum install java-11-openjdk.x86_64
yum erase java-11-openjdk.x86_64

# ubunut
dpkg -l
dpkg -i jdk-XXX_linux-x64_bin.deb
dpkg -r # remove

apt-get install openjdk-9-jdk
apt-get purge openjdk-9-jdk

# 标准输出和错误输出合并
nohup command >out.file 2>&1 &

# 关闭进程
ps -ef |grep 关键字 |awk '{print $2}'|xargs kill -9

systemctl start|enable mysql

shutdown -h now # 现在关机
reboot # 重启
```

### 内存管理

* 内存都被分成一块一块儿的，都编好了号
* 有一个实实在在的地址，通过地址就能够定位到物理内存的位置。
* 物理内存管理
	* 只有内存管理模块直接操作物理地址
* 虚拟地址管理
	* 每个进程看到的是独立的、互不干扰的虚拟地址空间
* 虚拟地址和物理地址映射
* 内存使用
	* 代码需要放在内存里面；全局变量，例如 max_length
	* 常量字符串"Input the string length : "
	* 函数栈，例如局部变量 num 是作为参数传给 generate 函数的，这里面涉及了函数调用，局部变量，函数参数等都是保存在函数栈上面的；
	* 堆，malloc 分配的内存在堆里面
	* 涉及对 glibc 的调用，glibc 的代码是以 so 文件的形式存在的，也需要放在内存里面。
	* 内核部分
		* 内核的代码要在内存里面；
		* 内核中也有全局变量；
		* 每个进程都要有一个 task_struct；
		* 每个进程还有一个内核栈；
		* 在内核里面也有动态分配的内存；
		* 虚拟地址到物理地址的映射表放在哪里？
* 对于内存的访问，用户态的进程与内核态的都是使用虚拟地址
* 工具
	* pmap $PID;  
	* cat /proc/$PID/maps;

#### 虚拟地址空间

* 寻址空间
	* 32 位，有 2^32 = 4G
	* 64 位，在 x86_64 只使用了 48 位，48 位地址长度也就是对应了 256TB 的地址空间
* 用户空间 用来放进程的东西，在下，在低地址
	* Text Segment 是存放二进制可执行代码的位置
	* Data Segment 存放静态常量
	* BSS Segment 存放未初始化的静态变量。
	* 堆（Heap）段 ：往高地址增长的，用来动态分配内存的区域，malloc 就是在这里面分配的
	* Memory Mapping Segment 用来把文件映射进内存用的，如果二进制的执行文件依赖于某个动态链接库，就是在这个区域里面将 so 文件映射到了内存中。
	* 栈（Stack）地址段 主线程的函数调用的函数栈就是用这里的
* 内核空间 用来放内核的东西
	* 无论从哪个进程进来的，看到的都是同一个内核空间，同一个进程列表。
	* 虽然内核栈是各用各的，但是如果想知道的话，还是能够知道每个进程的内核栈在哪里的。所以，如果要访问一些公共的数据结构，需要进行锁保护。
	* 内核的代码访问内核的数据结构，大部分的情况下都是使用虚拟地址的，虽然内核代码权限很大，但是能够使用的虚拟地址范围也只能在内核空间，也即内核代码访问内核数据结构。
	* 同样有 Text Segment、Data Segment 和 BSS Segment，别忘了咱们讲内核启动的时候，内核代码也是 ELF 格式的
* 分段机制
	* 虚拟地址
		- 段选择子：保存在段寄存器里面。最重要的是段号，用作段表的索引
		- 段内偏移量：应该位于 0 和段界限之间
	- 物理内存地址 = 段基地址+段内偏移量
	- 可以做权限审核，例如用户态 DPL 是 3，内核态 DPL 是 0。当用户态试图访问内核态的时候，会因为权限不足而报错。
	- 段表 段描述符表（segment descriptors）保存的是这个段的基地址、段的界限和特权等级等
		- 放在全局描述符表 GDT（Global Descriptor Table）里面，由下面的宏来初始化段描述符表里面的表项
		- 一个段表项由段基地址 base、段界限 limit，还有一些标识符组成。定义了内核代码段、内核数据段、用户代码段和用户数据段。
			- 所有的段的起始地址都是一样的，都是 0。这算哪门子分段嘛！所以，在 Linux 操作系统中，并没有使用到全部的分段功能。
		- 四个段选择子，指向上面的段描述符表项。这四个段选择子。内核初始化的时候，启动第一个用户态的进程，就是将这四个值赋值给段寄存器。
	- 容易碎片，不容易换出
- 分页（Paging）页目录表(1k 10bit)->页表(1k 10bit)->具体位置（4K 12bit）
	- 操作系统把物理内存分成一块一块大小相同的页，这样更方便管理，可以扩大可用物理内存的大小，提高物理内存的利用率。
	- 换出：有的内存页面长时间不用了，可以暂时写到硬盘上
	- 换入： 一旦需要的时候，再加载进来
	- 换入和换出以页为单位的。页面的大小一般为 4KB。为了能够定位和访问每个页，需要有个页表，保存每个页的起始地址，再加上在页内的偏移量，组成线性地址，就能对于内存中的每个位置进行访问了。
	- 虚拟地址:虚拟内存中的页通过页表映射为了物理内存中的页。
		- 页号作为页表的索引，页表包含物理页每页所在物理内存的基地址
		- 基地址与页内偏移的组合就形成了物理内存地址
	- 页表中所有页表项必须提前建好，并且要求是连续的。如果不连续，就没有办法通过虚拟地址里面的页号找到对应的页表项了。
	- 虚拟地址空间共 4GB。如果分成 4KB 一个页，那就是 1M 个页。每个页表项需要 4 个字节来存储，那么整个 4GB 空间的映射就需要 4MB 的内存来存储映射表,太大了
	- 页表再分页
		- 4G 的空间需要 4M 的页表来存储映射
		- 把这 4M 分成 1K（1024）个 4K，每个 4K 又能放在一页里面，这样 1K 个 4K 就是 1K 个页，通过页目录表管理 1K 个页，这个页目录表里面有 1K 项，每项 4 个字节，页目录表大小是 4K。
		- 页目录有 1K 项，用 10 位就可以表示访问页目录的哪一项。这一项其实对应的是一整页的页表项，也即 4K 的页表项。
		- 每个页表项是 4 个字节，因而一整页的页表项是 1K 个。再用 10 位就可以表示访问页表项的哪一项，页表项中的一项对应的就是一个页，是存放数据的页，这个页的大小是 4K，用 12 位可以定位这个页内的任何一个位置。
		- 这样加起来正好 32 位，也就是用前 10 位定位到页目录表中的一项。将这一项对应的页表取出来共 1k 项，再用中间 10 位定位到页表中的一项，将这一项对应的存放数据的页取出来，再用最后 12 位定位到页中的具体位置访问数据。
	- 使用页目录优点：页目录需要 1K 个全部分配，占用内存 4K，但是里面只有一项使用了。到了页表项，只需要分配能够管理那个数据页的页表项页就可以了，也就是说，最多 4K，这样内存就节省多了
	- 64 位的系统
		- 全局页目录项 PGD（Page Global Directory）
		- 上层页目录项 PUD（Page Upper Directory）
		- 中间页目录项 PMD（Page Middle Directory）
		- 页表项 PTE（Page Table Entry）
		- 地址线只有48条，硬件要求传入的地址48位到63位地址必须相同。 4K页面下， 48位线性地址分为5段，位宽度分别是9、9、9、12。映射的方法为页表查找。

![分页结构](../_static/memory_paging.jpg)

```
#define GDT_ENTRY_INIT(flags, base, limit) { { { \
    .a = ((limit) & 0xffff) | (((base) & 0xffff) << 16), \
    .b = (((base) & 0xff0000) >> 16) | (((flags) & 0xf0ff) << 8) | \
      ((limit) & 0xf0000) | ((base) & 0xff000000), \
  } } }


DEFINE_PER_CPU_PAGE_ALIGNED(struct gdt_page, gdt_page) = { .gdt = {
#ifdef CONFIG_X86_64
  [GDT_ENTRY_KERNEL32_CS]    = GDT_ENTRY_INIT(0xc09b, 0, 0xfffff),
  [GDT_ENTRY_KERNEL_CS]    = GDT_ENTRY_INIT(0xa09b, 0, 0xfffff),
  [GDT_ENTRY_KERNEL_DS]    = GDT_ENTRY_INIT(0xc093, 0, 0xfffff),
  [GDT_ENTRY_DEFAULT_USER32_CS]  = GDT_ENTRY_INIT(0xc0fb, 0, 0xfffff),
  [GDT_ENTRY_DEFAULT_USER_DS]  = GDT_ENTRY_INIT(0xc0f3, 0, 0xfffff),
  [GDT_ENTRY_DEFAULT_USER_CS]  = GDT_ENTRY_INIT(0xa0fb, 0, 0xfffff),
#else
  [GDT_ENTRY_KERNEL_CS]    = GDT_ENTRY_INIT(0xc09a, 0, 0xfffff),
  [GDT_ENTRY_KERNEL_DS]    = GDT_ENTRY_INIT(0xc092, 0, 0xfffff),
  [GDT_ENTRY_DEFAULT_USER_CS]  = GDT_ENTRY_INIT(0xc0fa, 0, 0xfffff),
  [GDT_ENTRY_DEFAULT_USER_DS]  = GDT_ENTRY_INIT(0xc0f2, 0, 0xfffff),
......
#endif
} };
EXPORT_PER_CPU_SYMBOL_GPL(gdt_page);


#define __KERNEL_CS      (GDT_ENTRY_KERNEL_CS*8)
#define __KERNEL_DS      (GDT_ENTRY_KERNEL_DS*8)
#define __USER_DS      (GDT_ENTRY_DEFAULT_USER_DS*8 + 3)
#define __USER_CS      (GDT_ENTRY_DEFAULT_USER_CS*8 + 3)
```

#### 进程虚拟内存空间

*  独享内存空间：每个进程都有自己的内存，互相之间不干扰，有独立的进程内存空间
	*  每个进程的物理地址对于进程不可见，谁也不能直接访问这个物理地址。
	*  操作系统会给进程分配一个虚拟地址。所有进程看到的这个地址都是一样的，里面内存都是从 0 开始编号。
	*  在程序里面，指令写入的地址是虚拟地址
*  进程的内存空间 32 位的是 4G，不可能有这么多物理内存
	*  不用部分不用管，只有进程要去使用部分内存的时候，才会使用内存管理的系统调用来登记，说自己马上就要用了，希望分配一部分内存给它，但是这还不代表真的就对应到了物理内存。
	*  只有真的写入数据的时候，发现没有对应物理内存，才会触发一个中断，现分配物理内存
*  用户态和内核态划分
	*  task_struct 中 struct mm_struct 结构来管理内存
	*  task_size字段 分割用户态地址空间和内核态地址空间
		*  32 位系统，最大能够寻址 2^32=4G，其中用户态虚拟地址空间是 3G，内核态是 1G
		*  64 位系统，虚拟地址只使用了 48 位。就像代码里面写的一样，1 左移了 47 位，就相当于 48 位地址空间一半的位置，0x0000800000000000，然后减去一个页，就是 0x00007FFFFFFFF000，共 128T。同样，内核空间也是 128T。内核空间和用户空间之间隔着很大的空隙，以此来进行隔离。
*  用户态布局
	*  total_vm 是总共映射的页的数目。这么大的虚拟地址空间，不可能都有真实内存对应，所以这里是映射的数目。
	*  当内存吃紧的时候，有些页可以换出到硬盘上，有的页因为比较重要，不能换出。locked_vm 就是被锁定不能换出，pinned_vm 是不能换出，也不能移动。
	*  data_vm 是存放数据的页的数目，
	*  exec_vm 是存放可执行文件的页的数目，
	*  stack_vm 是栈所占的页的数目。
	*  start_code 和 end_code 表示可执行代码的开始和结束位置，
	*  start_data 和 end_data 表示已初始化数据的开始位置和结束位置。
	*  start_brk 是堆的起始位置，brk 是堆当前的结束位置。前面咱们讲过 malloc 申请一小块内存的话，就是通过改变 brk 位置实现的。
	*  start_stack 是栈的起始位置，栈的结束位置在寄存器的栈顶指针中。
	*  arg_start 和 arg_end 是参数列表的位置， env_start 和 env_end 是环境变量的位置。它们都位于栈中最高地址的地方。
	*  mmap_base 表示虚拟地址空间中用于内存映射的起始地址。一般情况下，这个空间是从高地址到低地址增长的。前面讲 malloc 申请一大块内存的时候，就是通过 mmap 在这里映射一块区域到物理内存。加载动态链接库 so 文件，也是在这个区域里面，映射一块区域到 so 文件。
	*  vm_area_struct  来描述这些区域的属性
		*  一个是单链表，用于将这些区域串起来
		*  vm_start 和 vm_end 指定了该区域在用户空间中的起始和结束地址
		*  vm_next 和 vm_prev 将这个区域串在链表上
		* 还有一个红黑树。又是这个数据结构，在进程调度的时候用的也是红黑树。它的好处就是查找和修改都很快。这里用红黑树，就是为了快速查找一个内存区域，并在需要改变的时候，能够快速修改。
		* vm_rb 将这个区域放在红黑树上
		* vm_ops 里面是对这个内存区域可以做的操作的定义
		* 匿名映射 anon_vma  anonymous：虚拟内存区域映射到物理内存
		* 虚拟内存区域映射到文件，需要有 vm_file 指定被映射的文件
		* 如何和上面的内存区域关联：在 load_elf_binary 里面实现的。加载内核的是它，启动第一个用户态进程 init 的是它，fork 完了以后，调用 exec 运行一个二进制程序的也是它。
			* exec 运行一个二进制程序的时候，除了解析 ELF 的格式之外，另外一个重要的事情就是建立内存映射。
				* 调用 setup_new_exec，设置内存映射区 mmap_base
				* 调用 setup_arg_pages，设置栈的 vm_area_struct，这里面设置了 mm->arg_start 是指向栈底的，current->mm->start_stack 就是栈底
				* elf_map 会将 ELF 文件中的代码部分映射到内存中来
				* set_brk 设置了堆的 vm_area_struct，这里面设置了 current->mm->start_brk = current->mm->brk，也即堆里面还是空的
				* load_elf_interp 将依赖的 so 映射到内存中的内存映射区域。
	* 映射完毕后，什么情况下会修改
		* 函数的调用，涉及函数栈的改变，主要是改变栈顶指针
		* 通过 malloc 申请一个堆内的空间，当然底层要么执行 brk，要么执行 mmap。看一下 brk 是怎么做的。
			* brk 系统调用实现的入口是 sys_brk 函数
			* 堆是从低地址向高地址增长的，sys_brk 函数的参数 brk 是新的堆顶位置，而当前的 mm->brk 是原来堆顶的位置。
			* 首先要做的第一个事情，将原来的堆顶和现在的堆顶，都按照页对齐地址，然后比较大小。
				* 如果两者相同，说明这次增加的堆的量很小，还在一个页里面，不需要另行分配页，直接跳到 set_brk 那里，设置 mm->brk 为新的 brk 就可以了。
				* 如果发现新旧堆顶不在一个页里面，麻烦了，这下要跨页了。
				* 如果发现新堆顶小于旧堆顶，这说明不是新分配内存了，而是释放内存了，释放的还不小，至少释放了一页，于是调用 do_munmap 将这一页的内存映射去掉。
				* 如果还有空间，就调用 do_brk 进一步分配堆空间，从旧堆顶开始，分配计算出的新旧堆顶之间的页数。
			* do_brk 中
				* 调用 find_vma_links 找到将来的 vm_area_struct 节点在红黑树的位置，找到它的父节点、前序节点。
				* 接下来调用 vma_merge，看这个新节点是否能够和现有树中的节点合并。
				* 如果地址是连着的，能够合并，则不用创建新的 vm_area_struct 了，直接跳到 out，更新统计值即可；
				* 如果不能合并，则创建新的 vm_area_struct，既加到 anon_vma_chain 链表中，也加到红黑树中。
* 内核态布局
	* 内核态的虚拟空间和某一个进程没有关系，所有进程通过系统调用进入到内核之后，看到的虚拟地址空间都是一样的。强调一下，千万别以为到了内核里面，就会直接使用物理内存地址了，想当然地认为下面讨论的都是物理内存地址，不是的，这里讨论的还是虚拟内存地址，但是由于内核总是涉及管理物理内存，因而总是隐隐约约发生关系，所以这里必须思路清晰，分清楚物理内存地址和虚拟内存地址。
	* 32 位的内核态虚拟地址空间一共就 1G，占绝大部分的前 896M，称为直接映射区。
		* 所谓的直接映射区，就是这一块空间是连续的，和物理内存是非常简单的映射关系，其实就是虚拟内存地址减去 3G，就得到物理内存的位置。
		* 内核里面有两个宏
			* `__pa(vaddr)` 返回与虚拟地址 vaddr 相关的物理地址
			* `__va(paddr)` 计算出对应于物理地址 paddr 的虚拟地址
			* 这里虚拟地址和物理地址发生了关联关系，在物理内存的开始的 896M 的空间，会被直接映射到 3G 至 3G+896M 的虚拟地址
		* 896M 分解
			* 在系统启动的时候，物理内存的前 1M 已经被占用了，从 1M 开始加载内核代码段，然后就是内核的全局变量、BSS 等，也是 ELF 里面涵盖的。
			* 内核的代码段，全局变量，BSS 也就会被映射到 3G 后的虚拟地址空间里面。具体的物理内存布局可以查看 /proc/iomem。
			* 碰到系统调用创建进程，会创建 task_struct 实例，内核的进程管理代码会将实例创建在 3G 至 3G+896M 的虚拟空间中，当然也会被放在物理内存里面的前 896M 里面，相应的页表也会被创建。内核的进程管理的代码会将内核栈创建同样的空间
			* 896M 这个值在内核中被定义为 high_memory，在此之上常称为“高端内存”
				* 高端内存是物理内存的概念。仅仅是内核中的内存管理模块看待物理内存的时候的概念。
				* 在内核中，除了内存管理模块直接操作物理地址之外，内核的其他模块，仍然要操作虚拟地址，而虚拟地址是需要内存管理模块分配和映射好的。
				* 假设电脑 2G 内存，现在如果内核的其他模块想要访问物理内存 1.5G 的地方，应该怎么办呢？
					* 不能使用物理地址。需要使用内存管理模块给分配的虚拟地址，但是虚拟地址的 0 到 3G 已经被用户态进程占用去了，作为内核不能使用。
					* 因为写 1.5G 的虚拟内存位置，一方面不知道应该根据哪个进程的页表进行映射；另一方面，就算映射了也不是真正想访问的物理内存的地方，所以发现内核，能够使用的虚拟内存地址，只剩下 1G 减去 896M 的空间了。
				* 在 896M 到 VMALLOC_START 之间有 8M 的空间。
				* VMALLOC_START 到 VMALLOC_END 之间称为内核动态映射空间，也即内核想像用户态进程一样 malloc 申请内存，在内核里面可以使用 vmalloc。假设物理内存里面，896M 到 1.5G 之间已经被用户态进程占用了，并且映射关系放在了进程的页表中，内核 vmalloc 的时候，只能从分配物理内存 1.5G 开始，就需要使用这一段的虚拟地址进行映射，映射关系放在专门给内核自己用的页表里面。
				* PKMAP_BASE 到 FIXADDR_START 的空间称为持久内核映射。使用 alloc_pages() 函数的时候，在物理内存的高端内存得到 struct page 结构，可以调用 kmap 将其映射到这个区域。
				* FIXADDR_START 到 FIXADDR_TOP(0xFFFF F000) 的空间，称为固定映射区域，主要用于满足特殊需求。
					* 最后一个区域可以通过 kmap_atomic 实现临时内核映射。假设用户态的进程要映射一个文件到内存中，先要映射用户态进程空间的一段虚拟地址到物理内存，然后将文件内容写入这个物理内存供用户态进程访问。
					* 给用户态进程分配物理内存页可以通过 alloc_pages()，分配完毕后，按说将用户态进程虚拟地址和物理内存的映射关系放在用户态进程的页表中，就完事大吉了。
					* 这个时候，用户态进程可以通过用户态的虚拟地址，也即 0 至 3G 的部分，经过页表映射后访问物理内存，并不需要内核态的虚拟地址里面也划出一块来，映射到这个物理内存页。但是如果要把文件内容写入物理内存，这件事情要内核来干了，这就只好通过 kmap_atomic 做一个临时映射，写入物理内存完毕后，再 kunmap_atomic 来解映射即可。
	* 64 位的内存布局
			* 从 0xffff800000000000 开始就是内核的部分，只不过一开始有 8T 的空档区域。
			* 从` __PAGE_OFFSET_BASE(0xffff880000000000) `开始的 64T 的虚拟地址空间是直接映射区域，也就是减去 PAGE_OFFSET 就是物理地址。虚拟地址和物理地址之间的映射在大部分情况下还是会通过建立页表的方式进行映射。
			* 从 VMALLOC_START（0xffffc90000000000）开始到 VMALLOC_END（0xffffe90000000000）的 32T 的空间是给 vmalloc 的。从 VMEMMAP_START（0xffffea0000000000）开始的 1T 空间用于存放物理页面的描述结构 struct page 的。
			* 从 `__START_KERNEL_map（0xffffffff80000000）`开始的 512M 用于存放内核代码段、全局变量、BSS 等。这里对应到物理内存开始的位置，减去 `__START_KERNEL_map `就能得到物理内存的地址。这里和直接映射区有点像，但是不矛盾，因为直接映射区之前有 8T 的空当区域，早就过了内核代码在物理内存中加载的位置。
* 工具
	* `/proc/pid/pagemap`  
	* `/proc/kpagecount`  
	* `/proc/kpageflags`  
	* `/proc/kpagecgroup`

![32 位内核态布局](../_static/32bit_core_memory.jpg)
![32 内存态布局](../_static/32bit_memory_map.jpg)
![64 位内核态布局](../_static/64bit_core_memory.jpg)
![64 内存态布局](../_static/64bit_memory_map.jpg)

```c
struct mm_struct    *mm;

unsigned long task_size;    /* size of task vm space */

unsigned long mmap_base;  /* base of mmap area */
unsigned long total_vm;    /* Total pages mapped */
unsigned long locked_vm;  /* Pages that have PG_mlocked set */
unsigned long pinned_vm;  /* Refcount permanently increased */
unsigned long data_vm;    /* VM_WRITE & ~VM_SHARED & ~VM_STACK */
unsigned long exec_vm;    /* VM_EXEC & ~VM_WRITE & ~VM_STACK */
unsigned long stack_vm;    /* VM_STACK */
unsigned long start_code, end_code, start_data, end_data;
unsigned long start_brk, brk, start_stack;
unsigned long arg_start, arg_end, env_start, env_end;

struct vm_area_struct *mmap;    /* list of VMAs */
struct rb_root mm_rb;


#ifdef CONFIG_X86_32
/*
 * User space process size: 3GB (default).
 */
#define TASK_SIZE    PAGE_OFFSET
#define TASK_SIZE_MAX    TASK_SIZE
/*
config PAGE_OFFSET
        hex
        default 0xC0000000
        depends on X86_32
*/
#else
/*
 * User space process size. 47bits minus one guard page.
*/
#define TASK_SIZE_MAX  ((1UL << 47) - PAGE_SIZE)
#define TASK_SIZE    (test_thread_flag(TIF_ADDR32) ? \
          IA32_PAGE_OFFSET : TASK_SIZE_MAX)
......

current->mm->task_size = TASK_SIZE;


struct vm_area_struct {
  /* The first cache line has the info for VMA tree walking. */
  unsigned long vm_start;    /* Our start address within vm_mm. */
  unsigned long vm_end;    /* The first byte after our end address within vm_mm. */
  /* linked list of VM areas per task, sorted by address */
  struct vm_area_struct *vm_next, *vm_prev;
  struct rb_node vm_rb;
  struct mm_struct *vm_mm;  /* The address space we belong to. */
  struct list_head anon_vma_chain; /* Serialized by mmap_sem &
            * page_table_lock */
  struct anon_vma *anon_vma;  /* Serialized by page_table_lock */
  /* Function pointers to deal with this struct. */
  const struct vm_operations_struct *vm_ops;
  struct file * vm_file;    /* File we map to (can be NULL). */
  void * vm_private_data;    /* was vm_pte (shared mem) */
} __randomize_layout;


static int load_elf_binary(struct linux_binprm *bprm)
{
......
  setup_new_exec(bprm);
......
  retval = setup_arg_pages(bprm, randomize_stack_top(STACK_TOP),
         executable_stack);
......
  error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt,
        elf_prot, elf_flags, total_size);
......
  retval = set_brk(elf_bss, elf_brk, bss_prot);
......
  elf_entry = load_elf_interp(&loc->interp_elf_ex,
              interpreter,
              &interp_map_addr,
              load_bias, interp_elf_phdata);
......
  current->mm->end_code = end_code;
  current->mm->start_code = start_code;
  current->mm->start_data = start_data;
  current->mm->end_data = end_data;
  current->mm->start_stack = bprm->p;
......
}


SYSCALL_DEFINE1(brk, unsigned long, brk)
{
  unsigned long retval;
  unsigned long newbrk, oldbrk;
  struct mm_struct *mm = current->mm;
  struct vm_area_struct *next;
......
  newbrk = PAGE_ALIGN(brk);
  oldbrk = PAGE_ALIGN(mm->brk);
  if (oldbrk == newbrk)
    goto set_brk;


  /* Always allow shrinking brk. */
  if (brk <= mm->brk) {
    if (!do_munmap(mm, newbrk, oldbrk-newbrk, &uf))
      goto set_brk;
    goto out;
  }


  /* Check against existing mmap mappings. */
  next = find_vma(mm, oldbrk);
  if (next && newbrk + PAGE_SIZE > vm_start_gap(next))
    goto out;


  /* Ok, looks good - let it rip. */
  if (do_brk(oldbrk, newbrk-oldbrk, &uf) < 0)
    goto out;


set_brk:
  mm->brk = brk;
......
  return brk;
out:
  retval = mm->brk;
  return retval
  

static int do_brk(unsigned long addr, unsigned long len, struct list_head *uf)
{
  return do_brk_flags(addr, len, 0, uf);
}


static int do_brk_flags(unsigned long addr, unsigned long request, unsigned long flags, struct list_head *uf)
{
  struct mm_struct *mm = current->mm;
  struct vm_area_struct *vma, *prev;
  unsigned long len;
  struct rb_node **rb_link, *rb_parent;
  pgoff_t pgoff = addr >> PAGE_SHIFT;
  int error;


  len = PAGE_ALIGN(request);
......
  find_vma_links(mm, addr, addr + len, &prev, &rb_link,
            &rb_parent);
......
  vma = vma_merge(mm, prev, addr, addr + len, flags,
      NULL, NULL, pgoff, NULL, NULL_VM_UFFD_CTX);
  if (vma)
    goto out;
......
  vma = kmem_cache_zalloc(vm_area_cachep, GFP_KERNEL);
  INIT_LIST_HEAD(&vma->anon_vma_chain);
  vma->vm_mm = mm;
  vma->vm_start = addr;
  vma->vm_end = addr + len;
  vma->vm_pgoff = pgoff;
  vma->vm_flags = flags;
  vma->vm_page_prot = vm_get_page_prot(flags);
  vma_link(mm, vma, prev, rb_link, rb_parent);
out:
  perf_event_mmap(vma);
  mm->total_vm += len >> PAGE_SHIFT;
  mm->data_vm += len >> PAGE_SHIFT;
  if (flags & VM_LOCKED)
    mm->locked_vm += (len >> PAGE_SHIFT);
  vma->vm_flags |= VM_SOFTDIRTY;
  return 0;
  

#define __va(x)      ((void *)((unsigned long)(x)+PAGE_OFFSET))
#define __pa(x)    __phys_addr((unsigned long)(x))
#define __phys_addr(x)    __phys_addr_nodebug(x)
#define __phys_addr_nodebug(x)  ((x) - PAGE_OFFSET)

```

#### 物理内存管理

* 平坦内存模型（Flat Memory Model）：由于物理地址是连续的，页也是连续的，每个页大小也是一样的。因而对于任何一个地址，只要直接除一下每页的大小，很容易直接算出在哪一页。每个页有一个结构 struct page 表示，这个结构也是放在一个数组里面，这样根据页号，很容易通过下标找到相应的 struct page 结构。
* SMP（Symmetric multiprocessing）对称多处理器：CPU 有多个，在总线的一侧。所有的内存条组成一大片内存，在总线的另一侧，所有的 CPU 访问内存都要过总线，而且距离都是一样的
	* 缺点：总线会成为瓶颈，因为数据都要走它
* NUMA（Non-uniform memory access）非一致内存访问：内存不是一整块。每个 CPU 都有自己的本地内存，CPU 访问本地内存不用过总线，因而速度要快很多，每个 CPU 和内存在一起，称为一个 NUMA 节点。
	* 在本地内存不足的情况下，每个 CPU 都可以去另外的 NUMA 节点申请内存，这个时候访问延时就会比较长。
	* 内存被分成了多个节点，每个节点再被分成一个一个的页面。由于页需要全局唯一定位，页还是需要有全局唯一的页号的。但是由于物理内存不是连起来的了，页号也就不再连续了。于是内存模型就变成了非连续内存模型，管理起来就复杂一些。
	* NUMA 往往是非连续内存模型。而非连续内存模型不一定就是 NUMA，有时候一大片内存的情况下，也会有物理内存地址不连续的情况。
* 节点 
	* 数据结构 typedef struct pglist_data pg_data_t
		- 每一个节点都有自己的 ID：node_id
		- node_mem_map 节点的 struct page 数组，用于描述这个节点里面的所有的页
		- node_start_pfn 是这个节点的起始页号
		- node_spanned_pages 是这个节点中包含不连续的物理内存地址的页面数
		- node_present_pages 是真正可用的物理页面的数目。
		- 64M 物理内存隔着一个 4M 的空洞，然后是另外的 64M 物理内存。这样换算成页面数目就是，16K 个页面隔着 1K 个页面，然后是另外 16K 个页面。这种情况下，node_spanned_pages 就是 33K 个页面，node_present_pages 就是 32K 个页面。
	- 每一个节点分成一个个区域 zone，放在数组 node_zones 里面。这个数组的大小为 MAX_NR_ZONES
	- 区域类型
		- ZONE_DMA 是指可用于作 DMA（Direct Memory Access，直接内存存取）的内存。
			- DMA 是一种机制：要把外设的数据读入内存或把内存的数据传送到外设，原来都要通过 CPU 控制完成，但是这会占用 CPU，影响 CPU 处理其他事情，所以有了 DMA 模式。
			- CPU 只需向 DMA 控制器下达指令，让 DMA 控制器来处理数据的传送，数据传送完毕再把信息反馈给 CPU，这样就可以解放 CPU。
		- 64 位系统，有两个 DMA 区域。除了上面说的 ZONE_DMA，还有 ZONE_DMA32
		- ZONE_NORMAL 是直接映射区，从物理内存到虚拟内存的内核区域，通过加上一个常量直接映射。
		- ZONE_HIGHMEM 是高端内存区，对于 32 位系统来说超过 896M 的地方，对于 64 位没必要有的一段区域。
		- ZONE_MOVABLE 是可移动区域，通过将物理内存划分为可移动分配区域和不可移动分配区域来避免内存碎片。
	- nr_zones 表示当前节点的区域的数量。node_zonelists 是备用节点和它的内存区域的情况。前面讲 NUMA 的时候，讲了 CPU 访问内存，本节点速度最快，但是如果本节点内存不够怎么办，还是需要去其他节点进行分配。毕竟，就算在备用节点里面选择，慢了点也比没有强。既然整个内存被分成了多个节点，那 pglist_data 应该放在一个数组里面。每个节点一项
- 区域 数据结构 zone
	- zone_start_pfn 表示属于这个 zone 的第一个页，spanned_pages = zone_end_pfn - zone_start_pfn，也即 spanned_pages 指的是不管中间有没有物理内存空洞，反正就是最后的页号减去起始的页号。
	- present_pages = spanned_pages - absent_pages(pages in holes)，也即 present_pages 是这个 zone 在物理内存中真实存在的所有 page 数目。
	- managed_pages = present_pages - reserved_pages，也即 managed_pages 是这个 zone 被伙伴系统管理的所有的 page 数目
	- per_cpu_pageset 用于区分冷热页。什么叫冷热页呢？咱们讲 x86 体系结构的时候讲过，为了让 CPU 快速访问段描述符，在 CPU 里面有段描述符缓存。CPU 访问这个缓存的速度比内存快得多。同样对于页面来讲，也是这样的。如果一个页被加载到 CPU 高速缓存里面，这就是一个热页（Hot Page），CPU 读起来速度会快很多，如果没有就是冷页（Cold Page）。由于每个 CPU 都有自己的高速缓存，因而 per_cpu_pageset 也是每个 CPU 一个。
- 页
	- 组成物理内存的基本单位，页的数据结构 struct page。这是一个特别复杂的结构，里面有很多的 union，union 结构是在 C 语言中被用于同一块内存根据情况保存不同类型数据的一种方式。这里之所以用了 union，是因为一个物理页面使用模式有多种。
	- 第一种模式:要用就用一整页。这一整页的内存，或者直接和虚拟地址空间建立映射关系，把这种称为匿名页（Anonymous Page）。或者用于关联一个文件，然后再和虚拟地址空间建立映射关系，这样的文件，称为内存映射文件（Memory-mapped File），使用 union 中的以下变量
		- `struct address_space *mapping` 用于内存映射，如果是匿名页，最低位为 1；如果是映射文件，最低位为 0
		- pgoff_t index 是在映射区的偏移量
		- `atomic_t _mapcount`，每个进程都有自己的页表，这里指有多少个页表项指向了这个页；
		- truct list_head lru 表示这一页应该在一个链表上，例如这个页面被换出，就在换出页的链表中；
		- compound 相关的变量用于复合页（Compound Page），就是将物理上连续的两个或多个页看成一个独立的大页。
	- 第二种模式:仅需分配小块内存
		- 采用一种被称为 slab allocator 的技术，用于分配称为 slab 的一小块内存。基本原理是从内存管理模块申请一整块页，然后划分成多个小块的存储池，用复杂的队列来维护这些小块的状态（状态包括：被分配了 / 被放回池子 / 应该被回收）。
		- 因为 slab allocator 对于队列的维护过于复杂，后来就有了一种不使用队列的分配器 slub allocator，后面会解析这个分配器。它里面还是用了很多 slab 的字眼，因为它保留了 slab 的用户接口，可以看成 slab allocator 的另一种实现。
		- 还有一种小块内存的分配器称为 slob，非常简单，主要使用在小型的嵌入式系统。
		- 会使用 union 中的以下变量
			- s_mem 是已经分配了正在使用的 slab 的第一个对象
			- freelist 是池子中的空闲对象
			- rcu_head 是需要释放的列表。
- 页的分配
	- 对于要分配比较大的内存，例如到分配页级别的，可以使用伙伴系统（Buddy System）
		- Linux 中的内存管理的“页”大小为 4KB。把所有的空闲页分组为 11 个页块链表，每个块链表分别包含很多个大小的页块，有 1、2、4、8、16、32、64、128、256、512 和 1024 个连续页的页块。最大可以申请 1024 个连续页，对应 4MB 大小的连续内存。
		- 每个页块的第一个页的物理地址是该页块大小的整数倍。
		- 第 i 个页块链表中，页块中页的数目为 2^i。struct zone 里面的 `free_area[MAX_ORDER]`
		- 当向内核请求分配 (2^(i-1)，2^i]数目的页块时，按照 2^i 页块请求处理。如果对应的页块链表中没有空闲页块，那就在更大的页块链表中去找。
		- 当分配的页块中有多余的页时，伙伴系统会根据多余的页块大小插入到对应的空闲页块链表中。
		- 逻辑在分配页的函数 alloc_pages 中看到，调用 alloc_pages_current，gfp 表示希望在哪个区域中分配这个内存：
			- GFP_USER 用于分配一个页映射到用户进程的虚拟地址空间，并且希望直接被内核或者硬件访问，主要用于一个用户进程希望通过内存映射的方式，访问某些硬件的缓存，例如显卡缓存
			- GFP_KERNEL 用于内核中分配页，主要分配 ZONE_NORMAL 区域，也即直接映射区
			- GFP_HIGHMEM，顾名思义就是主要分配高端区域的内存。
			- 参数 order，就是表示分配 2 的 order 次方个页
			- 接下来调用` __alloc_pages_nodemask`。这是伙伴系统的核心方法。会调用 get_page_from_freelist。就是在一个循环中先看当前节点的 zone。如果找不到空闲页，则再看备用节点的 zone。
			- 每一个 zone，都有伙伴系统维护的各种大小的队列，就像上面伙伴系统原理里讲的那样。这里调用 rmqueue 就很好理解了，就是找到合适大小的那个队列，把页面取下来。
			- 接下来的调用链是 rmqueue->`__rmqueue`->`__rmqueue_smallest`。这里能清楚看到伙伴系统的逻辑。从当前的 order，也即指数开始，在伙伴系统的 free_area 找 2^order 大小的页块。如果链表的第一个不为空，就找到了；如果为空，就到更大的 order 的页块链表里面去找。找到以后，除了将页块从链表中取下来，还要把多余部分放到其他页块链表里面。expand 就是干这个事情的。area–就是伙伴系统那个表里面的前一项，前一项里面的页块大小是当前项的页块大小除以 2，size 右移一位也就是除以 2，list_add 就是加到链表上，nr_free++ 就是计数加 1。

![页块链表](../_static/page_list.jpg)
![物理内存的组织](../_static/phsycle_memory.jpg)

```
typedef struct pglist_data {
  struct zone node_zones[MAX_NR_ZONES];
  struct zonelist node_zonelists[MAX_ZONELISTS];
  int nr_zones;
  struct page *node_mem_map;
  unsigned long node_start_pfn;
  unsigned long node_present_pages; /* total number of physical pages */
  unsigned long node_spanned_pages; /* total size of physical page range, including holes */
  int node_id;
......
} pg_data_t;


enum zone_type {
#ifdef CONFIG_ZONE_DMA
  ZONE_DMA,
#endif
#ifdef CONFIG_ZONE_DMA32
  ZONE_DMA32,
#endif
  ZONE_NORMAL,
#ifdef CONFIG_HIGHMEM
  ZONE_HIGHMEM,
#endif
  ZONE_MOVABLE,
  __MAX_NR_ZONES
};


struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;


struct zone {
......
  struct pglist_data  *zone_pgdat;
  struct per_cpu_pageset __percpu *pageset;
  
  struct free_area  free_area[MAX_ORDER];


  unsigned long    zone_start_pfn;


  /*
   * spanned_pages is the total pages spanned by the zone, including
   * holes, which is calculated as:
   *   spanned_pages = zone_end_pfn - zone_start_pfn;
   *
   * present_pages is physical pages existing within the zone, which
   * is calculated as:
   *  present_pages = spanned_pages - absent_pages(pages in holes);
   *
   * managed_pages is present pages managed by the buddy system, which
   * is calculated as (reserved_pages includes pages allocated by the
   * bootmem allocator):
   *  managed_pages = present_pages - reserved_pages;
   *
   */
  unsigned long    managed_pages;
  unsigned long    spanned_pages;
  unsigned long    present_pages;


  const char    *name;
......
  /* free areas of different sizes */
  struct free_area  free_area[MAX_ORDER];


  /* zone flags, see below */
  unsigned long    flags;


  /* Primarily protects free_area */
  spinlock_t    lock;
......
} ____cacheline_internodealigned_in_


struct page {
  unsigned long flags;
  union {
	struct address_space *mapping;  
	void *s_mem;      /* slab first object */
	atomic_t compound_mapcount;  /* first tail page */
  };
  union {
	pgoff_t index;    /* Our offset within mapping. */
	void *freelist;    /* sl[aou]b first free object */
  };
  union {
	unsigned counters;
	struct {
	  union {
		atomic_t _mapcount;
		unsigned int active;    /* SLAB */
		struct {      /* SLUB */
		  unsigned inuse:16;
		  unsigned objects:15;
		  unsigned frozen:1;
		};
		int units;      /* SLOB */
	  };
	  atomic_t _refcount;
	};
  };
  union {
	struct list_head lru;  /* Pageout list   */
	struct dev_pagemap *pgmap; 
	struct {    /* slub per cpu partial pages */
	  struct page *next;  /* Next partial slab */
	  int pages;  /* Nr of partial slabs left */
	  int pobjects;  /* Approximate # of objects */
	};
	struct rcu_head rcu_head;
	struct {
	  unsigned long compound_head; /* If bit zero is set */
	  unsigned int compound_dtor;
	  unsigned int compound_order;
	};
  };
  union {
	unsigned long private;
	struct kmem_cache *slab_cache;  /* SL[AU]B: Pointer to slab */
  };
......
}
	
	

static inline struct page *
alloc_pages(gfp_t gfp_mask, unsigned int order)
{
  return alloc_pages_current(gfp_mask, order);
}


/**
 *   alloc_pages_current - Allocate pages.
 *
 *  @gfp:
 *    %GFP_USER   user allocation,
 *        %GFP_KERNEL kernel allocation,
 *        %GFP_HIGHMEM highmem allocation,
 *        %GFP_FS     don't call back into a file system.
 *        %GFP_ATOMIC don't sleep.
 *  @order: Power of two of allocation size in pages. 0 is a single page.
 *
 *  Allocate a page from the kernel page pool.  When not in
 *  interrupt context and apply the current process NUMA policy.
 *  Returns NULL when no page can be allocated.
 */
struct page *alloc_pages_current(gfp_t gfp, unsigned order)
{
  struct mempolicy *pol = &default_policy;
  struct page *page;
......
  page = __alloc_pages_nodemask(gfp, order,
        policy_node(gfp, pol, numa_node_id()),
        policy_nodemask(gfp, pol));
......
  return page;
}

static struct page *
get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
            const struct alloc_context *ac)
{
......
  for_next_zone_zonelist_nodemask(zone, z, ac->zonelist, ac->high_zoneidx, ac->nodemask) {
    struct page *page;
......
    page = rmqueue(ac->preferred_zoneref->zone, zone, order,
        gfp_mask, alloc_flags, ac->migratetype);
......
}


static inline
struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
            int migratetype)
{
  unsigned int current_order;
  struct free_area *area;
  struct page *page;


  /* Find a page of the appropriate size in the preferred list */
  for (current_order = order; current_order < MAX_ORDER; ++current_order) {
    area = &(zone->free_area[current_order]);
    page = list_first_entry_or_null(&area->free_list[migratetype],
              struct page, lru);
    if (!page)
      continue;
    list_del(&page->lru);
    rmv_page_order(page);
    area->nr_free--;
    expand(zone, page, order, current_order, area, migratetype);
    set_pcppage_migratetype(page, migratetype);
    return page;
  }


  return NULL;


static inline void expand(struct zone *zone, struct page *page,
  int low, int high, struct free_area *area,
  int migratetype)
{
  unsigned long size = 1 << high;


  while (high > low) {
    area--;
    high--;
    size >>= 1;
......
    list_add(&page[size].lru, &area->free_list[migratetype]);
    area->nr_free++;
    set_page_order(&page[size], high);
  }
}
```

##### 小内存的分配

* kmem_cache_alloc_node()
	* 创建进程的时候，会调用 dup_task_struct，它想要试图复制一个 task_struct 对象，需要先调用 alloc_task_struct_node，分配一个 task_struct 对象.从代码可以看出，调用 kmem_cache_alloc_node 函数，在 task_struct 的缓存区域 task_struct_cachep 分配了一块内存。
	* 在系统初始化的时候，task_struct_cachep 会被 kmem_cache_create 函数创建。这个函数也比较容易看懂，专门用于分配 task_struct 对象的缓存。这个缓存区的名字就叫 task_struct。缓存区中每一块的大小正好等于 task_struct 的大小，也即 arch_task_struct_size。
	* 有了这个缓存区，每次创建 task_struct 的时候，不用到内存里面去分配，先在缓存里面看看有没有直接可用的，这就是 kmem_cache_alloc_node 的作用。
	* 当一个进程结束，task_struct 也不用直接被销毁，而是放回到缓存中，这就是 kmem_cache_free 的作用。这样，新进程创建的时候，就可以直接用现成的缓存中的 task_struct 了。
* struct kmem_cache
	* 有个变量 struct list_head list,要创建和管理的缓存绝对不止 task_struct。所有的缓存最后都会放在一个链表里面，也就是 LIST_HEAD(slab_caches)。
	* 三个 kmem_cache_order_objects 类型的变量。这里面的 order，就是 2 的 order 次方个页面的大内存块，objects 就是能够存放的缓存对象的数量。
	* 每一项的结构都是缓存对象后面跟一个下一个空闲对象的指针，这样非常方便将所有的空闲对象链成一个链。就相当于数据结构里面，用数组实现一个可随机插入和删除的链表。
		* size 是包含这个指针的大小
		* object_size 是纯对象的大小
		* offset 就是把下一个空闲对象的指针存放在这一项里的偏移量。
	* kmem_cache_cpu 和 kmem_cache_node，都是每个 NUMA 节点上有一个
		* 在分配缓存块的时候，要分两种路径，fast path 快速通道 和 slow path 普通通道。
			* kmem_cache_cpu 就是快速通道
			* kmem_cache_node 是普通通道。
			* 每次分配的时候，要先从 kmem_cache_cpu 进行分配。如果 kmem_cache_cpu 里面没有空闲的块，那就到 kmem_cache_node 中进行分配；如果还是没有空闲的块，才去伙伴系统分配新的页。
		* kmem_cache_cpu 里面是如何存放缓存块
			* page 指向大内存块的第一个页，缓存块就是从里面分配的。
			* freelist 指向大内存块里面第一个空闲的项。按照上面说的，这一项会有指针指向下一个空闲的项，最终所有空闲的项会形成一个链表。
			* partial 指向的也是大内存块的第一个页，之所以名字叫 partial（部分），就是因为它里面部分被分配出去了，部分是空的。这是一个备用列表，当 page 满了，就会从这里找。
		* kmem_cache_node
			* 也有一个 partial，是一个链表。这个链表里存放的是部分空闲的内存块。这是 kmem_cache_cpu 里面的 partial 的备用列表，如果那里没有，就到这里来找。
* kmem_cache_alloc_node 会调用 slab_alloc_node
	* 快速通道很简单，取出 cpu_slab 也即 kmem_cache_cpu 的 freelist，这就是第一个空闲的项，可以直接返回了。如果没有空闲的了，则只好进入普通通道，调用 `__slab_alloc`。
	* 首先再次尝试一下 kmem_cache_cpu 的 freelist。为什么呢？万一当前进程被中断，等回来的时候，别人已经释放了一些缓存，说不定又有空间了呢。如果找到了，就跳到 load_freelist，在这里将 freelist 指向下一个空闲项，返回就可以了。
	* 如果 freelist 还是没有，则跳到 new_slab 里面去。这里面先去 kmem_cache_cpu 的 partial 里面看。如果 partial 不是空的，那就将 kmem_cache_cpu 的 page，也就是快速通道的那一大块内存，替换为 partial 里面的大块内存。然后 redo，重新试下。这次应该就可以成功了。
	* 如果真的还不行，那就要到 new_slab_objects 了。
	* 在这里面，get_partial 会根据 node id，找到相应的 kmem_cache_node，然后调用 get_partial_node，开始在这个节点进行分配。
	* acquire_slab 会从 kmem_cache_node 的 partial 链表中拿下一大块内存来，并且将 freelist，也就是第一块空闲的缓存块，赋值给 t。并且当第一轮循环的时候，将 kmem_cache_cpu 的 page 指向取下来的这一大块内存，返回的 object 就是这块内存里面的第一个缓存块 t。如果 kmem_cache_cpu 也有一个 partial，就会进行第二轮，再次取下一大块内存来，这次调用 put_cpu_partial，放到 kmem_cache_cpu 的 partial 里面。
	* 如果 kmem_cache_node 里面也没有空闲的内存，这就说明原来分配的页里面都放满了，就要回到 new_slab_objects 函数，里面 new_slab 函数会调用 allocate_slab。
	* 在这里，看到了 alloc_slab_page 分配页面。分配的时候，要按 kmem_cache_order_objects 里面的 order 来。如果第一次分配不成功，说明内存已经很紧张了，那就换成 min 版本的 kmem_cache_order_objects。

```c

struct kmem_cache {
  struct kmem_cache_cpu __percpu *cpu_slab;
  /* Used for retriving partial slabs etc */
  unsigned long flags;
  unsigned long min_partial;
  int size;    /* The size of an object including meta data */
  int object_size;  /* The size of an object without meta data */
  int offset;    /* Free pointer offset. */
#ifdef CONFIG_SLUB_CPU_PARTIAL
  int cpu_partial;  /* Number of per cpu partial objects to keep around */
#endif
  struct kmem_cache_order_objects oo;
  /* Allocation and freeing of slabs */
  struct kmem_cache_order_objects max;
  struct kmem_cache_order_objects min;
  gfp_t allocflags;  /* gfp flags to use on each alloc */
  int refcount;    /* Refcount for slab cache destroy */
  void (*ctor)(void *);
......
  const char *name;  /* Name (only for display!) */
  struct list_head list;  /* List of slab caches */
......
  struct kmem_cache_node *node[MAX_NUMNODES];
};


struct kmem_cache_cpu {
  void **freelist;  /* Pointer to next available object */
  unsigned long tid;  /* Globally unique transaction id */
  struct page *page;  /* The slab from which we are allocating */
#ifdef CONFIG_SLUB_CPU_PARTIAL
  struct page *partial;  /* Partially allocated frozen slabs */
#endif
......
};


struct kmem_cache_node {
  spinlock_t list_lock;
......
#ifdef CONFIG_SLUB
  unsigned long nr_partial;
  struct list_head partial;
......
#endif
};


/*
 * Inlined fastpath so that allocation functions (kmalloc, kmem_cache_alloc)
 * have the fastpath folded into their functions. So no function call
 * overhead for requests that can be satisfied on the fastpath.
 *
 * The fastpath works by first checking if the lockless freelist can be used.
 * If not then __slab_alloc is called for slow processing.
 *
 * Otherwise we can simply pick the next object from the lockless free list.
 */
static __always_inline void *slab_alloc_node(struct kmem_cache *s,
    gfp_t gfpflags, int node, unsigned long addr)
{
  void *object;
  struct kmem_cache_cpu *c;
  struct page *page;
  unsigned long tid;
......
  tid = this_cpu_read(s->cpu_slab->tid);
  c = raw_cpu_ptr(s->cpu_slab);
......
  object = c->freelist;
  page = c->page;
  if (unlikely(!object || !node_match(page, node))) {
    object = __slab_alloc(s, gfpflags, node, addr, c);
    stat(s, ALLOC_SLOWPATH);
  } 
......
  return object;
}


static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
        unsigned long addr, struct kmem_cache_cpu *c)
{
  void *freelist;
  struct page *page;
......
redo:
......
  /* must check again c->freelist in case of cpu migration or IRQ */
  freelist = c->freelist;
  if (freelist)
    goto load_freelist;


  freelist = get_freelist(s, page);


  if (!freelist) {
    c->page = NULL;
    stat(s, DEACTIVATE_BYPASS);
    goto new_slab;
  }


load_freelist:
  c->freelist = get_freepointer(s, freelist);
  c->tid = next_tid(c->tid);
  return freelist;


new_slab:


  if (slub_percpu_partial(c)) {
    page = c->page = slub_percpu_partial(c);
    slub_set_percpu_partial(c, page);
    stat(s, CPU_PARTIAL_ALLOC);
    goto redo;
  }


  freelist = new_slab_objects(s, gfpflags, node, &c);
......
  return freeli
  


static inline void *new_slab_objects(struct kmem_cache *s, gfp_t flags,
      int node, struct kmem_cache_cpu **pc)
{
  void *freelist;
  struct kmem_cache_cpu *c = *pc;
  struct page *page;


  freelist = get_partial(s, flags, node, c);


  if (freelist)
    return freelist;


  page = new_slab(s, flags, node);
  if (page) {
    c = raw_cpu_ptr(s->cpu_slab);
    if (c->page)
      flush_slab(s, c);


    freelist = page->freelist;
    page->freelist = NULL;


    stat(s, ALLOC_SLAB);
    c->page = page;
    *pc = c;
  } else
    freelist = NULL;


  return freelis


/*
 * Try to allocate a partial slab from a specific node.
 */
static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
        struct kmem_cache_cpu *c, gfp_t flags)
{
  struct page *page, *page2;
  void *object = NULL;
  int available = 0;
  int objects;
......
  list_for_each_entry_safe(page, page2, &n->partial, lru) {
    void *t;


    t = acquire_slab(s, n, page, object == NULL, &objects);
    if (!t)
      break;


    available += objects;
    if (!object) {
      c->page = page;
      stat(s, ALLOC_FROM_PARTIAL);
      object = t;
    } else {
      put_cpu_partial(s, page, 0);
      stat(s, CPU_PARTIAL_NODE);
    }
    if (!kmem_cache_has_cpu_partial(s)
      || available > slub_cpu_partial(s) / 2)
      break;
  }
......
  return object;


static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
{
  struct page *page;
  struct kmem_cache_order_objects oo = s->oo;
  gfp_t alloc_gfp;
  void *start, *p;
  int idx, order;
  bool shuffle;


  flags &= gfp_allowed_mask;
......
  page = alloc_slab_page(s, alloc_gfp, node, oo);
  if (unlikely(!page)) {
    oo = s->min;
    alloc_gfp = flags;
    /*
     * Allocation may have failed due to fragmentation.
     * Try a lower order alloc if possible
     */
    page = alloc_slab_page(s, alloc_gfp, node, oo);
    if (unlikely(!page))
      goto out;
    stat(s, ORDER_FALLBACK);
  }
......
  return page;
}
```

##### 页面换出

* 分配内存的时候，发现没有地方了，就试图回收一下，调用链为 get_page_from_freelist->node_reclaim->`__node_reclaim`->shrink_node 页面换出也是以内存节点为单位的
* 还有一种情况，就是作为内存管理系统应该主动去做的,就是内核线程 kswapd。这个内核线程，在系统初始化的时候就被创建。这样它会进入一个无限循环，直到系统停止。在这个循环中，如果内存使用没有那么紧张，那它就可以放心睡大觉；如果内存紧张了，就需要去检查一下内存，看看是否需要换出一些内存页。balance_pgdat->kswapd_shrink_node->shrink_node
* shrink_node 会调用 shrink_node_memcg。这里面有一个循环处理页面的列表
	* 里面有个 lru 列表。从定义可以想象，所有的页面都被挂在 LRU 列表中。LRU 是 Least Recent Use，也就是最近最少使用。也就是说，这个列表里面会按照活跃程度进行排序，这样就容易把不怎么用的内存页拿出来做处理。
	* 内存页总共分两类，一类是匿名页，和虚拟地址空间进行关联；一类是内存映射，不但和虚拟地址空间关联，还和文件管理关联。
	* 每一类都有两个列表，一个是 active，一个是 inactive。顾名思义，active 就是比较活跃的，inactive 就是不怎么活跃的。这两个里面的页会变化，过一段时间，活跃的可能变为不活跃，不活跃的可能变为活跃。如果要换出内存，那就是从不活跃的列表中找出最不活跃的，换出到硬盘上。
* shrink_list 会先缩减活跃页面列表，再压缩不活跃的页面列表。对于不活跃列表的缩减，shrink_inactive_list 就需要对页面进行回收；对于匿名页来讲，需要分配 swap，将内存页写入文件系统；对于内存映射关联了文件的，我们需要将在内存中对于文件的修改写回到文件中。
* 总结一下。对于物理内存来讲，从下层到上层的关系及分配模式如下：
	* 物理内存分 NUMA 节点，分别进行管理
	* 每个 NUMA 节点分成多个内存区域
	* 每个内存区域分成多个物理页面
	* 伙伴系统将多个连续的页面作为一个大的内存块分配给上层
	* kswapd 负责物理页面的换入换出
	* Slub Allocator 将从伙伴系统申请的大内存块切成小块，分配给其他系统。

![物理内存的管理](../_static/phsycle_memory_manage.jpg)

```c

/*
 * The background pageout daemon, started as a kernel thread
 * from the init process.
 *
 * This basically trickles out pages so that we have _some_
 * free memory available even if there is no other activity
 * that frees anything up. This is needed for things like routing
 * etc, where we otherwise might have all activity going on in
 * asynchronous contexts that cannot page things out.
 *
 * If there are applications that are active memory-allocators
 * (most normal use), this basically shouldn't matter.
 */
static int kswapd(void *p)
{
  unsigned int alloc_order, reclaim_order;
  unsigned int classzone_idx = MAX_NR_ZONES - 1;
  pg_data_t *pgdat = (pg_data_t*)p;
  struct task_struct *tsk = current;


    for ( ; ; ) {
......
        kswapd_try_to_sleep(pgdat, alloc_order, reclaim_order,
          classzone_idx);
......
        reclaim_order = balance_pgdat(pgdat, alloc_order, classzone_idx);
......
    }
}



/*
 * This is a basic per-node page freer.  Used by both kswapd and direct reclaim.
 */
static void shrink_node_memcg(struct pglist_data *pgdat, struct mem_cgroup *memcg,
            struct scan_control *sc, unsigned long *lru_pages)
{
......
  unsigned long nr[NR_LRU_LISTS];
  enum lru_list lru;
......
  while (nr[LRU_INACTIVE_ANON] || nr[LRU_ACTIVE_FILE] ||
          nr[LRU_INACTIVE_FILE]) {
    unsigned long nr_anon, nr_file, percentage;
    unsigned long nr_scanned;


    for_each_evictable_lru(lru) {
      if (nr[lru]) {
        nr_to_scan = min(nr[lru], SWAP_CLUSTER_MAX);
        nr[lru] -= nr_to_scan;


        nr_reclaimed += shrink_list(lru, nr_to_scan,
                  lruvec, memcg, sc);
      }
    }
......
  }
......


enum lru_list {
  LRU_INACTIVE_ANON = LRU_BASE,
  LRU_ACTIVE_ANON = LRU_BASE + LRU_ACTIVE,
  LRU_INACTIVE_FILE = LRU_BASE + LRU_FILE,
  LRU_ACTIVE_FILE = LRU_BASE + LRU_FILE + LRU_ACTIVE,
  LRU_UNEVICTABLE,
  NR_LRU_LISTS
};


#define for_each_evictable_lru(lru) for (lru = 0; lru <= LRU_ACTIVE_FILE; lru++)


static unsigned long shrink_list(enum lru_list lru, unsigned long nr_to_scan,
         struct lruvec *lruvec, struct mem_cgroup *memcg,
         struct scan_control *sc)
{
  if (is_active_lru(lru)) {
    if (inactive_list_is_low(lruvec, is_file_lru(lru),
           memcg, sc, true))
      shrink_active_list(nr_to_scan, lruvec, sc, lru);
    return 0;
  }


  return shrink_inactive_list(nr_to_scan, lruvec, sc, lru);
```

#### 用户态内存映射

* mmap 原理

### 进程管理

#### 进程创建

* fork 是一个系统调用，在 sys_call_table 中找到相应的系统调用 sys_fork。sys_fork 会调用 `_do_fork`
* 复制结构 copy_process
	* dup_task_struct 
		* 调用 alloc_task_struct_node 分配一个 task_struct 结构
		* 调用 alloc_thread_stack_node 来创建内核栈，调用 `__vmalloc_node_range` 分配一个连续的 THREAD_SIZE 的内存空间，赋值给 task_struct 的 `void *stack` 成员变量
		* 调用 `arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)`，将 task_struct 进行复制，其实就是调用 memcpy
		* 调用 setup_thread_stack 设置 thread_info
	* copy_creds
		* 调用 prepare_creds，准备一个新的 `struct cred *new`。如何准备呢？其实还是从内存中分配一个新的 struct cred 结构，然后调用 memcpy 复制一份父进程的 cred
		* 接着 p->cred = p->real_cred = get_cred(new)，将新进程的“我能操作谁”和“谁能操作我”两个权限都指向新的 cred。
	* 重新设置进程运行统计量
	* 设置调度相关的变量。sched_fork 主要做了下面几件事情：
		* 调用 `__sched_fork`，在这里面将 on_rq 设为 0，初始化 sched_entity，将里面的 exec_start、sum_exec_runtime、prev_sum_exec_runtime、vruntime 都设为 0。几个变量涉及进程的实际运行时间和虚拟运行时间。是否到时间应该被调度，靠它们几个
		* 设置进程的状态 p->state = TASK_NEW
		* 初始化优先级 prio、normal_prio、static_prio；
		* 设置调度类，如果是普通进程，就设置为 p->sched_class = &fair_sched_class；
		* 调用调度类的 task_fork 函数，对于 CFS 来讲，就是调用 task_fork_fair。在这个函数里，先调用 update_curr，对于当前的进程进行统计量更新，然后把子进程和父进程的 vruntime 设成一样，最后调用 place_entity，初始化 sched_entity。这里有一个变量 sysctl_sched_child_runs_first，可以设置父进程和子进程谁先运行。如果设置了子进程先运行，即便两个进程的 vruntime 一样，也要把子进程的 sched_entity 放在前面，然后调用 resched_curr，标记当前运行的进程 TIF_NEED_RESCHED，也就是说，把父进程设置为应该被调度，这样下次调度的时候，父进程会被子进程抢占。
	* 开始初始化与文件和文件系统相关的变量
		* copy_files 主要用于复制一个进程打开的文件信息。这些信息用一个结构 files_struct 来维护，每个打开的文件都有一个文件描述符。在 copy_files 函数里面调用 dup_fd，在这里面会创建一个新的 files_struct，然后将所有的文件描述符数组 fdtable 拷贝一份。
		* copy_fs 主要用于复制一个进程的目录信息。这些信息用一个结构 fs_struct 来维护。一个进程有自己的根目录和根文件系统 root，也有当前目录 pwd 和当前目录的文件系统，都在 fs_struct 里面维护。copy_fs 函数里面调用 copy_fs_struct，创建一个新的 fs_struct，并复制原来进程的 fs_struct。
	* 初始化与信号相关的变量
		* copy_sighand 会分配一个新的 sighand_struct。这里最主要的是维护信号处理函数，在 copy_sighand 里面会调用 memcpy，将信号处理函数 sighand->action 从父进程复制到子进程。
		* init_sigpending 和 copy_signal 用于初始化，并且复制用于维护发给这个进程的信号的数据结构。copy_signal 函数会分配一个新的 signal_struct，并进行初始化。
	* 复制进程内存空间
		* 进程都有自己的内存空间，用 mm_struct 结构来表示。
		* copy_mm 函数中调用 dup_mm，分配一个新的 mm_struct 结构，调用 memcpy 复制这个结构。
		* dup_mmap 用于复制内存空间中内存映射的部分。前面讲系统调用的时候，说过，mmap 可以分配大块的内存，其实 mmap 也可以将一个文件映射到内存中，方便可以像读写内存一样读写文件
	* 分配 pid，设置 tid，group_leader
* 唤醒新进程 wake_up_new_task
	* 将进程的状态设置为 TASK_RUNNING
	* activate_task 函数中会调用 enqueue_task
	* 如果是 CFS 的调度类，则执行相应的 enqueue_task_fair。
		* 在 enqueue_task_fair 中取出的队列就是 cfs_rq，然后调用 enqueue_entity。
		* 在 enqueue_entity 函数里面，会调用 update_curr，更新运行的统计量，然后调用 `__enqueue_entity`，将 sched_entity 加入到红黑树里面，然后将 se->on_rq = 1 设置在队列上。
		* 回到 enqueue_task_fair 后，将这个队列上运行的进程数目加一。然后，wake_up_new_task 会调用 check_preempt_curr，看是否能够抢占当前进程。
		* 在 check_preempt_curr 中，会调用相应的调度类的 rq->curr->sched_class->check_preempt_curr(rq, p, flags)。对于 CFS 调度类来讲，调用的是 check_preempt_wakeup。
			* 前面调用 task_fork_fair 的时候，设置 sysctl_sched_child_runs_first 了，已经将当前父进程的 TIF_NEED_RESCHED 设置了，则直接返回。
			* 否则，check_preempt_wakeup 还是会调用 update_curr 更新一次统计量，然后 wakeup_preempt_entity 将父进程和子进程 PK 一次，看是不是要抢占，如果要则调用 resched_curr 标记父进程为 TIF_NEED_RESCHED。
			* 如果新创建的进程应该抢占父进程，在什么时间抢占呢？别忘了 fork 是一个系统调用，从系统调用返回的时候，是抢占的一个好时机，如果父进程判断自己已经被设置为 TIF_NEED_RESCHED，就让子进程先跑，抢占自己。

```
long _do_fork(unsigned long clone_flags,
        unsigned long stack_start,
        unsigned long stack_size,
        int __user *parent_tidptr,
        int __user *child_tidptr,
        unsigned long tls)
{
  struct task_struct *p;
  int trace = 0;
  long nr;


......
  p = copy_process(clone_flags, stack_start, stack_size,
       child_tidptr, NULL, trace, tls, NUMA_NO_NODE);
......
  if (!IS_ERR(p)) {
    struct pid *pid;
    pid = get_task_pid(p, PIDTYPE_PID);
    nr = pid_vnr(pid);


    if (clone_flags & CLONE_PARENT_SETTID)
      put_user(nr, parent_tidptr);


......
    wake_up_new_task(p);
......
    put_pid(pid);
  } 
......


static __latent_entropy struct task_struct *copy_process(
          unsigned long clone_flags,
          unsigned long stack_start,
          unsigned long stack_size,
          int __user *child_tidptr,
          struct pid *pid,
          int trace,
          unsigned long tls,
          int node)
{
  int retval;
  struct task_struct *p;
......
  p = dup_task_struct(current, node);
  
retval = copy_creds(p, clone_flags);

p->utime = p->stime = p->gtime = 0;
p->start_time = ktime_get_ns();
p->real_start_time = ktime_get_boot_ns();


retval = sched_fork(clone_flags, p);


retval = copy_files(clone_flags, p);
retval = copy_fs(clone_flags, p);


init_sigpending(&p->pending);
retval = copy_sighand(clone_flags, p);
retval = copy_signal(clone_flags, p);


retval = copy_mm(clone_flags, p);


  INIT_LIST_HEAD(&p->children);
  INIT_LIST_HEAD(&p->sibling);
......
    p->pid = pid_nr(pid);
  if (clone_flags & CLONE_THREAD) {
    p->exit_signal = -1;
    p->group_leader = current->group_leader;
    p->tgid = current->tgid;
  } else {
    if (clone_flags & CLONE_PARENT)
      p->exit_signal = current->group_leader->exit_signal;
    else
      p->exit_signal = (clone_flags & CSIGNAL);
    p->group_leader = p;
    p->tgid = p->pid;
  }
......
  if (clone_flags & (CLONE_PARENT|CLONE_THREAD)) {
    p->real_parent = current->real_parent;
    p->parent_exec_id = current->parent_exec_id;
  } else {
    p->real_parent = current;
    p->parent_exec_id = current->self_exec_id;
  }
  
  

void wake_up_new_task(struct task_struct *p)
{
  struct rq_flags rf;
  struct rq *rq;
......
  p->state = TASK_RUNNING;
......
  activate_task(rq, p, ENQUEUE_NOCLOCK);
  p->on_rq = TASK_ON_RQ_QUEUED;
  trace_sched_wakeup_new(p);
  check_preempt_curr(rq, p, WF_FORK);
......
}
```


#### 用户态代码执行

* 用户态代码访问核心资源：用户态 -> 系统调用 -> 保存寄存器 -> 内核态执行系统调用 -> 恢复寄存器 -> 返回用户态，例如 访问网卡发一个网络包
	* 暂停当前的运行，通过中断请求发起系统调用
		* 暂停的那一刻，要把当时 CPU 的寄存器的值全部暂存到一个地方，这个地方可以放在进程管理系统很容易获取的地方。当系统调用完毕，返回的时候，再从这个地方将寄存器的值恢复回去，就能接着运行了。
	* 内核将从系统调用传过来的包，在网卡上排队，轮到的时候就发送。
	* 发送完了，系统调用结束，返回用户态，让暂停运行的程序接着运行。

#### 线程

* 从用户态来看，创建进程就是立项|启动一个项目。项目包含很多资源，例如会议室、资料库等。这些东西都属于这个项目，但是项目需要人去执行。
* 多线程（Multithreading）：有多个人并行执行不同的部分
* 进程默认有一个主线程
* 线程并行
	* 访问数据
		* 整个进程里共享全局数据。例如全局变量，虽然在不同进程中是隔离的，但是在一个进程中是共享的
		* 线程栈上的本地数据：每个线程都有自己的栈空间
			* 主线程在内存中有一个栈空间，其他线程栈也拥有独立的栈空间。为了避免线程之间的栈空间踩踏，线程栈之间还会有小块区域，用来隔离保护各自的栈空间。一旦另一个线程踏入到这个隔离区，就会引发段错误。
			* 栈的大小  ulimit -a
			* 栈修改 ulimit -s 
			* 修改线程栈的大小 `int pthread_attr_setstacksize(pthread_attr_t *attr, size_t stacksize);`
		* 线程私有数据 Thread Specific Data 
			* 创建 `int pthread_key_create(pthread_key_t *key, void (*destructor)(void*))` 创建一个 key，伴随着一个析构函数。key 一旦被创建，所有线程都可以访问它，但各线程可根据自己的需要往 key 中填入不同的值，这就相当于提供了一个同名而不同值的全局变量。
			* 获取 `void *pthread_getspecific(pthread_key_t key)`
			* 设置 key 对应的 value `int pthread_setspecific(pthread_key_t key, const void *value)`
	* 数据保护
		* 共享数据
			* Mutex  Mutual Exclusion 互斥 访问的时候，去申请加把锁，谁先拿到锁，谁就拿到了访问权限，其他人就只好在门外等着，等这个人访问结束，把锁打开，其他人再去争夺，还是遵循谁先拿到谁访问。
				* 使用 pthread_mutex_init 函数初始化这个 mutex，初始化后，就可以用它来保护共享变量了。
				* pthread_mutex_lock() 去抢那把锁的函数，抢到就可以执行下一行程序，对共享变量进行访问；没抢到就被阻塞在那里等待。
				* 如果不想被阻塞，可以使用 pthread_mutex_trylock 去抢那把锁，如果抢到了，就可以执行下一行程序，对共享变量进行访问；如果没抢到，不会被阻塞，而是返回一个错误码。
				* 当共享数据访问结束，用 pthread_mutex_unlock 释放锁，给其他人使用，最终调用 pthread_mutex_destroy 销毁锁。
				* 问题：pthread_mutex_lock()，那就需要一直在那里等着。如果是 pthread_mutex_trylock()，就可以不用等着，去干点儿别的
			* 条件变量和互斥锁配合使用
				* 主线程维护的数据结构
				* 通知其它工作线程
* 工具
	* pstree -apl pid看进程树  
	* pstack pid 看栈
* 图书
	* Programming with POSIX

```c
# mutex.c
gcc mutex.c -lpthread
```

#####  线程创建

* 线程不是一个完全由内核实现的机制，它是由内核态和用户态合作完成的。pthread_create 不是一个系统调用，是 Glibc 库的一个函数
* 用户态创建线程
	* pthread_create() 
		* 线程属性参数设置
		* 用户态有一个用于维护线程的结构，一个 pthread 结构
		* 创建线程栈：ALLOCATE_STACK 是一个宏，找到它的定义之后，发现它其实就是一个函数
			* 如果在线程属性里面设置过栈的大小，需要把设置的值拿出来
			* 为防止栈的访问越界，在栈的末尾会有一块空间 guardsize，一旦访问到这里就错误了
			* 其实线程栈是在进程的堆里面创建的。如果一个进程不断地创建和删除线程，不可能不断地去申请和清除线程栈使用的内存块，这样就需要有一个缓存。get_cached_stack 就是根据计算出来的 size 大小，看一看已经有的缓存中，有没有已经能够满足条件的
			* 如果缓存里面没有，就需要调用 `__mmap` 创建一块新的，如果要在堆里面 malloc 一块内存，比较大的话，用 `__mmap`
			* 线程栈也是自顶向下生长的，每个线程要有一个 pthread 结构，这个结构也是放在栈的空间里面的。在栈底的位置，其实是地址最高位；
			* 计算出 guard 内存的位置，调用 setup_stack_prot 设置这块内存的是受保护的
			* 接下来，开始填充 pthread 结构里面的成员变量 stackblock、stackblock_size、guardsize、specific。这里的 specific 是用于存放 Thread Specific Data 的，也即属于线程的全局变量
			* 将这个线程栈放到 stack_used 链表中，其实管理线程栈总共有两个链表，一个是 stack_used，也就是这个栈正被使用；另一个是 stack_cache，就是上面说的，一旦线程结束，先缓存起来，不释放，等有其他的线程创建的时候，给其他的线程用。
* 内核态创建任务
	* 真正创建线程的是调用 create_thread 函数
		* ARCH_CLONE，调用的是 `__clone`
		* 如果在进程的主线程里面调用其他系统调用，当前用户态的栈是指向整个进程的栈，栈顶指针也是指向进程的栈，指令指针也是指向进程的主线程的代码。此时此刻执行到这里，调用 clone 的时候，用户态的栈、栈顶指针、指令指针和其他系统调用一样，都是指向主线程的。
		* 对于线程来说，这些都要变,希望当 clone 这个系统调用成功的时候，除了内核里面有这个线程对应的 task_struct，当系统调用返回到用户态的时候，用户态的栈应该是线程的栈，栈顶指针应该指向线程的栈，指令指针应该指向线程将要执行的那个函数。所以这些都需要自己做，将线程要执行的函数的参数和指令的位置都压到栈里面，从内核返回，从栈里弹出来的时候，就从这个函数开始，带着这些参数执行下去。
	* 在内核的clone系统调用中发现 `_do_fork`
		* 复杂的标志位设定的影响
			* 对于 copy_files，原来调用 dup_fd 复制一个 files_struct 的，现在因为 CLONE_FILES 标识位变成将原来的 files_struct 引用计数加一。
			* 对于 copy_fs，原来是调用 copy_fs_struct 复制一个 fs_struct，现在因为 CLONE_FS 标识位变成将原来的 fs_struct 的用户数加一。
			* 对于 copy_sighand，原来是创建一个新的 sighand_struct，现在因为 CLONE_SIGHAND 标识位变成将原来的 sighand_struct 引用计数加一。
			* 对于 copy_signal，原来是创建一个新的 signal_struct，现在因为 CLONE_THREAD 直接返回了
			* 对于 copy_mm，原来是调用 dup_mm 复制一个 mm_struct，现在因为 CLONE_VM 标识位而直接指向了原来的 mm_struct。
		* 对于亲缘关系的影响
			* 如果是新进程，那这个进程的 group_leader 就是它自己，tgid 是它自己的 pid，这就完全重打锣鼓另开张了，自己是线程组的头。如果是新线程，group_leader 是当前进程的，group_leader，tgid 是当前进程的 tgid，也就是当前进程的 pid，这个时候还是拜原来进程为老大。
			* 如果是新进程，新进程的 real_parent 是当前的进程，在进程树里面又见一辈人；如果是新线程，线程的 real_parent 是当前的进程的 real_parent，其实是平辈的。
		* 对于信号的处理：如何保证发给进程的信号虽然可以被一个线程处理，但是影响范围应该是整个进程的。如果一个信号是发给一个线程的 pthread_kill，则应该只有线程能够收到。
			* 在 copy_process 的主流程里面，无论是创建进程还是线程，都会初始化 struct sigpending pending，也就是每个 task_struct，都会有这样一个成员变量。这就是一个信号列表。如果这个 task_struct 是一个线程，这里面的信号就是发给这个线程的；如果这个 task_struct 是一个进程，这里面的信号是发给主线程的。
			* copy_signal 的时候，在创建进程的过程中，会初始化 signal_struct 里面的 struct sigpending shared_pending。但是，在创建线程的过程中，连 signal_struct 都共享了。也就是说，整个进程里的所有线程共享一个 shared_pending，这也是一个信号列表，是发给整个进程的，哪个线程处理都一样。
* 用户态执行线程
	* 根据 `__clone `的第一个参数，回到用户态也不是直接运行指定的那个函数，而是一个通用的 start_thread，这是所有线程在用户态的统一入口。
	* 在 start_thread 入口函数中，才真正的调用用户提供的函数，在用户的函数执行完毕之后，会释放这个线程相关的数据。例如，线程本地数据 thread_local variables，线程数目也减一。如果这是最后一个线程了，就直接退出进程，另外`__free_tcb` 用于释放 pthread。
	* `__free_tcb` 会调用 `__deallocate_stack` 来释放整个线程栈，这个线程栈要从当前使用线程栈的列表 stack_used 中拿下来，放到缓存的线程栈列表 stack_cache 中。
* 创建进程的话，调用的系统调用是 fork，在 copy_process 函数里面，会将五大结构 files_struct、fs_struct、sighand_struct、signal_struct、mm_struct 都复制一遍，从此父进程和子进程各用各的数据结构。而创建线程的话，调用的是系统调用 clone，在 copy_process 函数里面， 五大结构仅仅是引用计数加一，也即线程共享进程的数据结构。

![进程与线程的创建](../_static/process_thread_create.jpg)

```
##  nptl/pthread_create.c 
int __pthread_create_2_1 (pthread_t *newthread, const pthread_attr_t *attr, void *(*start_routine) (void *), void *arg)
{
	const struct pthread_attr *iattr = (struct pthread_attr *) attr;struct pthread_attr default_attr;if (iattr == NULL){ ...... iattr = &default_attr;}
	
	
	struct pthread *pd = NULL;
	
	
	int err = ALLOCATE_STACK (iattr, &pd);
}
versioned_symbol (libpthread, __pthread_create_2_1, pthread_create, GLIBC_2_1);


pd->start_routine = start_routine;
pd->arg = arg;
pd->schedpolicy = self->schedpolicy;
pd->schedparam = self->schedparam;
/* Pass the descriptor to the caller.  */
*newthread = (pthread_t) pd;
atomic_increment (&__nptl_nthreads);
retval = create_thread (pd, iattr, &stopped_start, STACK_VARIABLES_ARGS, &thread_ran);


static int
create_thread (struct pthread *pd, const struct pthread_attr *attr,
bool *stopped_start, STACK_VARIABLES_PARMS, bool *thread_ran)
{
  const int clone_flags = (CLONE_VM | CLONE_FS | CLONE_FILES | CLONE_SYSVSEM | CLONE_SIGHAND | CLONE_THREAD | CLONE_SETTLS | CLONE_PARENT_SETTID | CLONE_CHILD_CLEARTID | 0);
  ARCH_CLONE (&start_thread, STACK_VARIABLES_ARGS, clone_flags, pd, &pd->tid, tp, &pd->tid)；
  /* It's started now, so if we fail below, we'll have to cancel it
and let it clean itself up.  */
  *thread_ran = true;
}

## 内核里面对于 clone 系统调用的定义
SYSCALL_DEFINE5(clone, unsigned long, clone_flags, unsigned long, newsp,
     int __user *, parent_tidptr,
     int __user *, child_tidptr,
     unsigned long, tls)
{
  return _do_fork(clone_flags, newsp, 0, parent_tidptr, child_tidptr, tls);
}


SYSCALL_DEFINE5(clone, unsigned long, clone_flags, unsigned long, newsp,
     int __user *, parent_tidptr,
     int __user *, child_tidptr,
     unsigned long, tls)
{
  return _do_fork(clone_flags, newsp, 0, parent_tidptr, child_tidptr, tls);
}


static int copy_files(unsigned long clone_flags, struct task_struct *tsk)
{
  struct files_struct *oldf, *newf;
  oldf = current->files;
  if (clone_flags & CLONE_FILES) {
    atomic_inc(&oldf->count);
    goto out;
  }
  newf = dup_fd(oldf, &error);
  tsk->files = newf;
out:
  return error;
}


static int copy_fs(unsigned long clone_flags, struct task_struct *tsk)
{
  struct fs_struct *fs = current->fs;
  if (clone_flags & CLONE_FS) {
    fs->users++;
    return 0;
  }
  tsk->fs = copy_fs_struct(fs);
  return 0;
}


p->pid = pid_nr(pid);
if (clone_flags & CLONE_THREAD) {
  p->exit_signal = -1;
  p->group_leader = current->group_leader;
  p->tgid = current->tgid;
} else {
  if (clone_flags & CLONE_PARENT)
    p->exit_signal = current->group_leader->exit_signal;
  else
    p->exit_signal = (clone_flags & CSIGNAL);
  p->group_leader = p;
  p->tgid = p->pid;
}
  /* CLONE_PARENT re-uses the old parent */
if (clone_flags & (CLONE_PARENT|CLONE_THREAD)) {
  p->real_parent = current->real_parent;
  p->parent_exec_id = current->parent_exec_id;
} else {
  p->real_parent = current;
  p->parent_exec_id = current->self_exec_id;
}


#define START_THREAD_DEFN \
  static int __attribute__ ((noreturn)) start_thread (void *arg)


START_THREAD_DEFN
{
    struct pthread *pd = START_THREAD_SELF;
    /* Run the code the user provided.  */
    THREAD_SETMEM (pd, result, pd->start_routine (pd->arg));
    /* Call destructors for the thread_local TLS variables.  */
    /* Run the destructor for the thread-local data.  */
    __nptl_deallocate_tsd ();
    if (__glibc_unlikely (atomic_decrement_and_test (&__nptl_nthreads)))
        /* This was the last thread.  */
        exit (0);
    __free_tcb (pd);
    __exit_thread ();
}
```

#### 进程数据结构 task_struct

* 链表将所有 task_struct 串起来
* 任务ID
	* pid process id，tgid  thread group ID
		* 只有主线程，pid 是自己，tgid 是自己，group_leader 指向的还是自己(指针)
		* 进程创建其他线程，线程自己 pid，tgid 是进程的主线程的 pid，group_leader 指向的就是进程的主线程
		* 信号处理字段
			* 哪些信号被阻塞暂不处理（blocked）
			- 哪些信号尚等待处理（pending）
			- 哪些信号正在通过信号处理函数进行处理（sighand）
			- 处理的结果可以是忽略
			- 可以是结束进程
			- `struct sigpending pending` 进入 `struct signal_struct *signal` 去看的话，还有一个 `struct sigpending shared_pending` 一个是本任务的，一个是线程组共享的。
- 任务状态
	- state（状态）可以取的值定义在 include/linux/sched.h 头文件中
		- 通过 bitset 方式设置，当前是什么状态，哪一位就置一
		- TASK_RUNNING 并不是说进程正在运行，而是表示进程在时刻准备运行的状态。处于这个状态的进程获得时间片的时候，就是在运行中；如果没有获得时间片，就说明它被其他进程抢占了，在等待再次分配时间片。
		- 在运行中的进程，一旦要进行一些 I/O 操作，需要等待 I/O 完毕，这个时候会释放 CPU，进入睡眠状态。
			- TASK_INTERRUPTIBLE，可中断的睡眠状态。这是一种浅睡眠的状态，虽然在睡眠，等待 I/O 完成，但是这个时候一个信号来的时候，进程还是要被唤醒。只不过唤醒后，不是继续刚才的操作，而是进行信号处理。当然程序员可以根据自己的意愿，来写信号处理函数，例如收到某些信号，就放弃等待这个 I/O 操作完成，直接退出；或者收到某些信息，继续等待。
			- 另一种睡眠是 TASK_UNINTERRUPTIBLE，不可中断的睡眠状态。这是一种深度睡眠状态，不可被信号唤醒，只能死等 I/O 操作完成。一旦 I/O 操作因为特殊原因不能完成，这个时候，谁也叫不醒这个进程了。kill 它呢？别忘了，kill 本身也是一个信号，既然这个状态不可被信号唤醒，kill 信号也被忽略了。除非重启电脑，没有其他办法。是一个比较危险的事情，除非程序员极其有把握，不然还是不要设置成 TASK_UNINTERRUPTIBLE。
		- TASK_KILLABLE，可以终止的新睡眠状态。进程处于这种状态中，运行原理类似 TASK_UNINTERRUPTIBLE，只不过可以响应致命信号。
		- TASK_WAKEKILL 用于在接收到致命信号时唤醒进程，而 TASK_KILLABLE 相当于这两位都设置了。
		- TASK_STOPPED 是在进程接收到 SIGSTOP、SIGTTIN、SIGTSTP 或者 SIGTTOU 信号之后进入该状态。
		- TASK_TRACED 表示进程被 debugger 等进程监视，进程执行被调试程序所停止。当一个进程被另外的进程所监视，每一个信号都会让进程进入该状态。
		- 一旦一个进程要结束，先进入的是 EXIT_ZOMBIE 状态，但是这个时候它的父进程还没有使用 wait() 等系统调用来获知它的终止信息，此时进程就成了僵尸进程。
		- EXIT_DEAD 是进程的最终状态。EXIT_ZOMBIE 和 EXIT_DEAD 也可以用于 exit_state。
	- 标志  flags 这些字段都被定义成为宏，以 PF 开头
		- PF_EXITING 表示正在退出。当有这个 flag 的时候，在函数 find_alive_thread 中，找活着的线程，遇到有这个 flag 的，就直接跳过。
		- PF_VCPU 表示进程运行在虚拟 CPU 上。在函数 account_system_time 中，统计进程的系统运行时间，如果有这个 flag，就调用 account_guest_time，按照客户机的时间进行统计。
		- PF_FORKNOEXEC 表示 fork 完了，还没有 exec。在 `_do_fork` 函数里面调用 copy_process，这个时候把 flag 设置为 PF_FORKNOEXEC。当 exec 中调用了 load_elf_binary 的时候，又把这个 flag 去掉。
- 运行统计信息
- 进程亲缘关系：整个进程其实就是一棵进程树。而拥有同一父进程的所有进程都具有兄弟关系
	- parent 指向其父进程。当它终止时，必须向它的父进程发送信号。
		- real_parent 和 parent 是一样的，但是也会有另外的情况存在。例如，bash 创建一个进程，那进程的 parent 和 real_parent 就都是 bash。
		- 如果在 bash 上使用 GDB 来 debug 一个进程，这个时候 GDB 是 parent，bash 是这个进程的 real_parent。
	- children 表示链表的头部。链表中的所有元素都是它的子进程。
	- sibling 用于把当前进程插入到兄弟链表中。
- 进程权限 一个对象对另一个对象进行某些动作。当动作要实施的时候，就要审核权限，当两边的权限匹配上了，就可以实施操作
	- real_cred 就是说明谁能操作我这个进程 “谁能操作我” 我是 Objective
	- cred 就是说明我这个进程能够操作谁  “我能操作谁” Subjective
	- RCU(Read-Copy Update)，是 Linux 中比较重要的一种同步机制。顾名思义就是“读，拷贝更新”，再直白点是“随意读，但更新数据的时候，需要先复制一份副本，在副本上完成修改，再一次性地替换旧数据”。这是 Linux 内核实现的一种针对“读多写少”的共享数据的同步机制。
	- cred 结构
		- uid 和 gid，注释是 real user/group id。一般情况下，谁启动的进程，就是谁的 ID。但是权限审核的时候，往往不比较这两个，也就是说不大起作用
		- euid 和 egid，注释是 effective user/group id。一看这个名字，就知道这个是起“作用”的。当这个进程要操作消息队列、共享内存、信号量等对象的时候，其实就是在比较这个用户和组是否有权限
		- fsuid 和 fsgid，也就是 filesystem user/group id。这个是对文件操作会审核的权限。
		- fsuid、euid，和 uid 是一样的，fsgid、egid，和 gid 也是一样的。因为谁启动的进程，就应该审核启动的用户到底有没有这个权限。
			- `chmod u+s program` 设置 set-user-ID 的标识位，把文件权限变成 rwsr-xr-x。euid 和 fsuid 就不是使用用户  了，因为看到 set-user-id 标识，就改为文件的所有者的 ID
		- 一个进程可以随时通过 setuid 设置用户 ID，用户 ID 还会保存在一个地方，这就是 suid 和 sgid，也就是 saved uid 和 save gid。这样就可以很方便地使用 setuid，通过设置 uid 或者 suid 来改变权限
	- capabilities 用位图表示权限，在 capability.h 可以找到定义的权限,用于扩展用户权限太小，不用只能赋予 root 权限产生安全问题
		- cap_permitted 表示进程能够使用的权限。但是真正起作用的是 cap_effective。
		- cap_permitted 中可以包含 cap_effective 中没有的权限。一个进程可以在必要的时候，放弃自己的某些权限，这样更加安全。假设自己因为代码漏洞被攻破了，但是如果啥也干不了，就没办法进一步突破。
		- cap_inheritable 表示当可执行文件的扩展属性设置了 inheritable 位时，调用 exec 执行该程序会继承调用者的 inheritable 集合，并将其加入到 permitted 集合。但在非 root 用户下执行 exec 时，通常不会保留 inheritable 集合，但是往往又是非 root 用户，才想保留权限，所以非常鸡肋。
		- cap_bset capability bounding set，是系统中所有进程允许保留的权限。如果这个集合中不存在某个权限，那么系统中的所有进程都没有这个权限。即使以超级用户权限执行的进程，也是一样的。这样有很多好处。例如，系统启动以后，将加载内核模块的权限去掉，那所有进程都不能加载内核模块。这样，即便这台机器被攻破，也做不了太多有害的事情。
		- cap_ambient 是比较新加入内核的，就是为了解决 cap_inheritable 鸡肋的状况，也就是，非 root 用户进程使用 exec 执行一个程序的时候，如何保留权限的问题。当执行 exec 的时候，cap_ambient 会被添加到 cap_permitted 中，同时设置到 cap_effective 中。
- 内存管理
	- 每个进程都有自己独立的虚拟内存空间，数据结构 mm_struct
- 文件与文件系统
	- 一个文件系统的数据结构
	- 一个打开文件的数据结构
- Tips
	- 进程亲缘关系维护的数据结构，是一种很有参考价值的实现方式，在内核中会多个地方出现类似的结构
	- 进程权限中 setuid 的原理，这一点比较难理解，但是很重要，面试经常会考。
- 进程相关信息可以通过ps 获取， 依赖关系通过pstree获取，文件相关通过lsof， fuser，capabilities相关通过capsh，getcap获取
* 32 位和 64 位的工作模式，左边是 32 位的，右边是 64 位的
	* 在用户态，应用程序进行了至少一次函数调用。32 位和 64 的传递参数的方式稍有不同，32 位的就是用函数栈，64 位的前 6 个参数用寄存器，其他的用函数栈。
	* 在内核态，32 位和 64 位都使用内核栈，格式也稍有不同，主要集中在 pt_regs 结构上。
		- 内核栈和 task_struct 的关联关系不同。32 位主要靠 thread_info，64 位主要靠 Per-CPU 变量。

![工作模式](../_static/linux_work_mode.jpg)

```c
struct list_head    tasks;

pid_t pid;
pid_t tgid;
struct task_struct *group_leader; 


/* Signal handlers: */
struct signal_struct    *signal;
struct sighand_struct    *sighand;
sigset_t      blocked;
sigset_t      real_blocked;
sigset_t      saved_sigmask;
struct sigpending    pending;
unsigned long      sas_ss_sp;
size_t        sas_ss_size;
unsigned int      sas_ss_flags;


volatile long state;    /* -1 unrunnable, 0 runnable, >0 stopped */
int exit_state;
unsigned int flags;


// 是否在运行队列上
int        on_rq;
//优先级
int        prio;
int        static_prio;
int        normal_prio;
unsigned int      rt_priority;
//调度器类
const struct sched_class  *sched_class;
//调度实体
struct sched_entity    se;
struct sched_rt_entity    rt;
struct sched_dl_entity    dl;
//调度策略
unsigned int      policy;
//可以使用哪些CPU
int        nr_cpus_allowed;
cpumask_t      cpus_allowed;
struct sched_info    sched_info;

u64        utime;//用户态消耗的CPU时间
u64        stime;//内核态消耗的CPU时间
unsigned long      nvcsw;//自愿(voluntary)上下文切换计数
unsigned long      nivcsw;//非自愿(involuntary)上下文切换计数
u64        start_time;//进程启动时间，不包含睡眠时间
u64        real_start_time;//进程启动时间，包含睡眠时间


struct task_struct __rcu *real_parent; /* real parent process */
struct task_struct __rcu *parent; /* recipient of SIGCHLD, wait4() reports */
struct list_head children;      /* list of my children */
struct list_head sibling;       /* linkage in my parent's children list */


/* Objective and real subjective task credentials (COW): */
const struct cred __rcu         *real_cred;
/* Effective (overridable) subjective task credentials (COW): */
const struct cred __rcu         *cred;

/* Filesystem information: */
struct fs_struct                *fs;
/* Open file information: */
struct files_struct             *files;


struct thread_info    thread_info;
void  *stack;

# capability.h
#define CAP_CHOWN            0
#define CAP_KILL             5
#define CAP_NET_BIND_SERVICE 10
#define CAP_NET_RAW          13
#define CAP_SYS_MODULE       16
#define CAP_SYS_RAWIO        17
#define CAP_SYS_BOOT         22
#define CAP_SYS_TIME         25
#define CAP_AUDIT_READ          37
#define CAP_LAST_CAP         CAP_AUDIT_READ

# 32 bit 内核栈
#define THREAD_SIZE_ORDER  1
#define THREAD_SIZE    (PAGE_SIZE << THREAD_SIZE_ORDER)

# 64 Bit 内核栈
#ifdef CONFIG_KASAN
#define KASAN_STACK_ORDER 1
#else
#define KASAN_STACK_ORDER 0
#endif


#define THREAD_SIZE_ORDER  (2 + KASAN_STACK_ORDER)
#define THREAD_SIZE  (PAGE_SIZE << THREAD_SIZE_ORDER)
```

```c
struct cred {
......
        kuid_t          uid;            /* real UID of the task */
        kgid_t          gid;            /* real GID of the task */
        kuid_t          suid;           /* saved UID of the task */
        kgid_t          sgid;           /* saved GID of the task */
        kuid_t          euid;           /* effective UID of the task */
        kgid_t          egid;           /* effective GID of the task */
        kuid_t          fsuid;          /* UID for VFS ops */
        kgid_t          fsgid;          /* GID for VFS ops */
......
        kernel_cap_t    cap_inheritable; /* caps our children can inherit */
        kernel_cap_t    cap_permitted;  /* caps we're permitted */
        kernel_cap_t    cap_effective;  /* caps we can actually use */
        kernel_cap_t    cap_bset;       /* capability bounding set */
        kernel_cap_t    cap_ambient;    /* Ambient capability set */
......
} __randomize_layout;
```

![task_struct 的结构图](../_static/task_struct.jpg)

##### 用户态函数栈

* 在用户态中，程序的执行往往是一个函数调用另一个函数。函数调用都是通过栈来进行的
	- 在进程的内存空间里面，栈是一个从高地址到低地址，往下增长的结构，也就是上面是栈底，下面是栈顶，入栈和出栈的操作都是从下面的栈顶开始的。
	- 32 位操作系统中，CPU 里，ESP（Extended Stack Pointer）是栈顶指针寄存器，
		- 入栈操作 Push 和出栈操作 Pop 指令，会自动调整 ESP 的值。
		- 寄存器 EBP（Extended Base Pointer），是栈基地址指针寄存器，指向当前栈帧的最底部。返回的时候，返回值会保存在 EAX 寄存器中，从栈中弹出返回地址，将指令跳转回去，参数也从栈中弹出，然后继续执行调用函数
	- 64 位操作系统，rax 用于保存函数调用的返回结果。栈顶指针寄存器变成了 rsp，指向栈顶位置。
		- 堆栈的 Pop 和 Push 操作会自动调整 rsp，栈基指针寄存器变成了 rbp，指向当前栈帧的起始位置。
		- 改变比较多的是参数传递。rdi、rsi、rdx、rcx、r8、r9 这 6 个寄存器，用于传递存储函数调用时的 6 个参数。如果超过 6 的时候，还是需要放到栈里面。
		- 前 6 个参数有时候需要进行寻址，但是如果在寄存器里面，是没有地址的，因而还是会放到栈里面，只不过放到栈里面的操作是被调用函数做的

![32位用户态函数栈](../_static/user_func_stack.jpg)
![64位用户态函数栈](../_static/64bit_user_func_stack.jpg)

##### 内核态函数栈

* task_struct 的其他成员变量都是和进程管理有关的，内核栈是和进程运行有关系的。
- Linux 给每个 task 都分配了内核栈,成员变量 stack
	- 32 位系统 `arch/x86/include/asm/page_32_types.h`，定义：一个 PAGE_SIZE 是 4K，左移一位就是乘以 2，也就是 8K
	- 64 位系统 `arch/x86/include/asm/page_64_types.h`，定义：在 PAGE_SIZE 的基础上左移两位，也即 16K，并且要求起始地址必须是 8192 的整数倍
	- 空间最低位置，是一个 thread_info 结构,是对 task_struct 结构的补充。因为 task_struct 结构庞大但是通用，不同的体系结构就需要保存不同的东西，所以往往与体系结构有关的，都放在 thread_info 里面。
	- 最高地址端，存放的是另一个结构 pt_regs,32 位和 64 位的定义不一样
		- 系统调用的时候，压栈的值的顺序和 struct pt_regs 中寄存器定义的顺序是一样的。
		- 在内核中，CPU 的寄存器 ESP 或者 RSP，已经指向内核栈的栈顶，在内核态里的调用都有和用户态相似的过程。
- 通过 task_struct 找内核栈
	- 如果有一个 task_struct 的 stack 指针在手，通过 `*task_stack_page` 找到这个线程内核栈开始位置
	- 这个位置加上 THREAD_SIZE 就到了最后的位置，然后转换为 struct pt_regs，再减一，就相当于减少一个 pt_regs 的位置，就到了这个结构的首地址
		- `TOP_OF_KERNEL_STACK_PADDING` 32 位机器上是 8，其他是 0,因为压栈 pt_regs 有两种情况。CPU 用 ring 来区分权限，从而 Linux 可以区分内核态和用户态。
			- 拿涉及从用户态到内核态的变化的系统调用来说。因为涉及权限的改变，会压栈保存 SS、ESP 寄存器的，这两个寄存器共占用 8 个 byte
			- 不涉及权限的变化，就不会压栈这 8 个 byte。这样就会使得两种情况不兼容。如果没有压栈还访问，就会报错，所以还不如预留在这里，保证安全。在 64 位上，修改了这个问题，变成了定长的。
	- 从 task_struct 通过 task_pt_regs(task) 得到相应的 pt_regs
- 内核代码里面有这样一个 union，将 thread_info 和 stack 放在一起 `include/linux/sched.h`,开头是 thread_info，后面是 stack
- 通过内核栈找 task_struct
	- 交给 thread_info 这个结构
	- 成员变量 task 指向 task_struct，常用 current_thread_info()->task 来获取 task_struct
	- thread_info 位置是内核栈的最高位置，减去 THREAD_SIZE，就到了 thread_info 的起始地址
	- 现在变成只剩下一个 flags,current_thread_info 有了新的实现方式。`include/linux/thread_info.h` 定义了 current_thread_info
	- current  在 `arch/x86/include/asm/current.h` 中定义
	- 每个 CPU 运行的 task_struct 不通过 thread_info 获取了，而是直接放在 Per CPU 变量里面了
	- 多核情况下，CPU 是同时运行的，但是它们共同使用其他的硬件资源的时候，需要解决多个 CPU 之间的同步问题。
	- Per CPU 变量是内核中一种重要的同步机制。顾名思义，Per CPU 变量就是为每个 CPU 构造一个变量的副本，这样多个 CPU 各自操作自己的副本，互不干涉。比如，当前进程的变量 current_task 就被声明为 Per CPU 变量。
	- 使用 Per CPU 变量
		- 在`arch/x86/include/asm/current.h`声明这个变量
		- 在`arch/x86/kernel/cpu/common.c` 定义这个变量
	- 系统刚刚初始化的时候，current_task 都指向 init_task,当某个 CPU 上进程进行切换的时候，current_task 被修改为将要切换到的目标进程。例如，进程切换函数`__switch_to` 就会改变 current_task。
	- 要获取当前的运行中的 task_struct 的时候，就需要调用 this_cpu_read_stable 进行读取。
	
![内核栈](../_static/core_stack.jpg)

```c
# pt_regs
#ifdef __i386__
struct pt_regs {
  unsigned long bx;
  unsigned long cx;
  unsigned long dx;
  unsigned long si;
  unsigned long di;
  unsigned long bp;
  unsigned long ax;
  unsigned long ds;
  unsigned long es;
  unsigned long fs;
  unsigned long gs;
  unsigned long orig_ax;
  unsigned long ip;
  unsigned long cs;
  unsigned long flags;
  unsigned long sp;
  unsigned long ss;
};
#else 
struct pt_regs {
  unsigned long r15;
  unsigned long r14;
  unsigned long r13;
  unsigned long r12;
  unsigned long bp;
  unsigned long bx;
  unsigned long r11;
  unsigned long r10;
  unsigned long r9;
  unsigned long r8;
  unsigned long ax;
  unsigned long cx;
  unsigned long dx;
  unsigned long si;
  unsigned long di;
  unsigned long orig_ax;
  unsigned long ip;
  unsigned long cs;
  unsigned long flags;
  unsigned long sp;
  unsigned long ss;
/* top of stack page */
};
#endif 

# include/linux/sched.h
union thread_union {
#ifndef CONFIG_THREAD_INFO_IN_TASK
  struct thread_info thread_info;
#endif
  unsigned long stack[THREAD_SIZE/sizeof(long)];
};


static inline void *task_stack_page(const struct task_struct *task)
{
  return task->stack;
}


/*
 * TOP_OF_KERNEL_STACK_PADDING reserves 8 bytes on top of the ring0 stack.
 * This is necessary to guarantee that the entire "struct pt_regs"
 * is accessible even if the CPU haven't stored the SS/ESP registers
 * on the stack (interrupt gate does not save these registers
 * when switching to the same priv ring).
 * Therefore beware: accessing the ss/esp fields of the
 * "struct pt_regs" is possible, but they may contain the
 * completely wrong values.
 */
#define task_pt_regs(task) \
({                  \
  unsigned long __ptr = (unsigned long)task_stack_page(task);  \
  __ptr += THREAD_SIZE - TOP_OF_KERNEL_STACK_PADDING;    \
  ((struct pt_regs *)__ptr) - 1;          \
})


struct thread_info {
  struct task_struct  *task;    /* main task structure */
  __u32      flags;    /* low level flags */
  __u32      status;    /* thread synchronous flags */
  __u32      cpu;    /* current CPU */
  mm_segment_t    addr_limit;
  unsigned int    sig_on_uaccess_error:1;
  unsigned int    uaccess_err:1;  /* uaccess failed */
};


static inline struct thread_info *current_thread_info(void)
{
  return (struct thread_info *)(current_top_of_stack() - THREAD_SIZE);
}

# 内核栈中找 task_struct
struct thread_info {
        unsigned long           flags;          /* low level flags */
};

## include/linux/thread_info.h
#include <asm/current.h>
#define current_thread_info() ((struct thread_info *)current)
#endif

## arch/x86/include/asm/current.h
struct task_struct;


DECLARE_PER_CPU(struct task_struct *, current_task);


static __always_inline struct task_struct *get_current(void)
{
  return this_cpu_read_stable(current_task);
}


#define current get_current

## arch/x86/include/asm/current.h 中声明变量 Per CPU
DECLARE_PER_CPU(struct task_struct *, current_task);

## arch/x86/kernel/cpu/common.c 中定义
DEFINE_PER_CPU(struct task_struct *, current_task) = &init_task;

## current_task 被修改为将要切换到的目标进程
__visible __notrace_funcgraph struct task_struct *
__switch_to(struct task_struct *prev_p, struct task_struct *next_p)
{
......
this_cpu_write(current_task, next_p);
......
return prev_p;
}


#define this_cpu_read_stable(var)       percpu_stable_op("mov", var)
```

#### 调度

* 有效地分配 CPU 的时间，既要保证进程的最快响应，也要保证进程之间的公平
* 进程大概可以分成两种
	* 实时进程，也就是需要尽快执行返回结果的那种。这种优先级就会比较高
	* 普通进程，大部分的进程其实都是这种。可以按照正常流程完成，优先级就没实时进程这么高，但是人家肯定也有确定的交付日期。
* 调度策略: task_struct 中的一个成员变量
	* 实时调度策略
		* SCHED_FIFO 先来先服务，高优先级的进程可以抢占低优先级的进程，而相同优先级的进程，遵循先来先得。
		* SCHED_RR 轮流调度算法 采用时间片，相同优先级的任务当用完时间片会被放到队列尾部，以保证公平性，而高优先级的任务也是可以抢占低优先级的任务。
		* SCHED_DEADLINE 按照任务的 deadline 进行调度的。当产生一个调度点的时候，DL 调度器总是选择其 deadline 距离当前时间点最近的那个任务，并调度它执行。
	* 普通调度策略
		* SCHED_NORMAL 普通进程
		* SCHED_BATCH 后台进程，几乎不需要和前端进行交互。这有点像公司在接项目同时，开发一些可以复用的模块，作为公司的技术积累，从而使得在之后接新项目的时候，能够减少工作量。这类项目可以默默执行，不要影响需要交互的进程，可以降低它的优先级。
		* SCHED_IDLE 特别空闲的时候才跑的进程，相当于咱们学习训练类的项目，比如咱们公司很长时间没有接到外在项目了，可以弄几个这样的项目练练手。
* 优先级：在 task_struct 中的字段，配合调度策略的。一个数值，对于实时进程，优先级的范围是 0～99；对于普通进程，优先级的范围是 100～139。数值越小，优先级越高。
* 执行逻辑：无论是 policy 还是 priority，都设置了一个变量，变量仅仅表示了应该这样这样干，执行字段 `*sched_class`，有几种实现
	* stop_sched_class 优先级最高的任务会使用这种策略，会中断所有其他线程，且不会被其他任务打断
	* dl_sched_class 对应上面的 deadline 调度策略
	* rt_sched_class 对应 RR 算法或者 FIFO 算法的调度策略，具体调度策略由进程的 task_struct->policy 指定
	* fair_sched_class 普通进程的调度策略
	* idle_sched_class 空闲进程的调度策略
* 一个 CPU 上有一个队列，CFS 的队列是一棵红黑树，树的每一个节点都是一个 sched_entity，每个 sched_entity 都属于一个 task_struct，task_struct 里面有指针指向这个进程属于哪个调度类。
* 调度的时候，依次调用调度类的函数，从 CPU 的队列中取出下一个进程。

![](../_static/process_manage.jpg)

```
## task_struct 中调度策略成员变量与优先级
unsigned int policy;

int prio, static_prio, normal_prio;
unsigned int rt_priority;

const struct sched_class *sched_class;

## policy 定义
#define SCHED_NORMAL    0
#define SCHED_FIFO    1
#define SCHED_RR    2
#define SCHED_BATCH    3
#define SCHED_IDLE    5
#define SCHED_DEADLINE    6
```

##### CFS   Completely Fair Scheduling 完全公平调度算法

* 原理
	* 记录进程运行时间。CPU 会提供一个时钟，过一段时间就触发一个时钟中断。就像咱们的表滴答一下，这个我们叫 Tick。CFS 会为每一个进程安排一个虚拟运行时间 vruntime。`虚拟运行时间 vruntime += 实际运行时间 delta_exec * NICE_0_LOAD/ 权重`
	* 如果一个进程在运行，随着时间的增长，也就是一个个 tick 的到来，进程的 vruntime 将不断增大。没有得到执行的进程 vruntime 不变。
	* 那些 vruntime 少的，原来受到了不公平的对待，需要给它补上，所以会优先运行这样的进程。
	* 优先级高的vruntime 权重参数比较大，算的实际时间减少
	* 选取下一个运行进程的时候，还是按照最小的 vruntime 来的
* 数据结构：对 vruntime 进行排序，找出最小的那个
	* 不但查询的时候，能够快速找到最小的，更新的时候也需要能够快速地调整排序，要知道 vruntime 可是经常在变的，变了再插入这个数据结构，就需要重新排序
	* 能够平衡查询和更新速度的是树，在这里使用的是红黑树。
	* 调度实体：红黑树的的节点是应该包括 vruntime 的
		* task_struct 中成员变量,不光 CFS 调度策略需要有这样一个数据结构进行排序，其他的调度策略也同样有自己的数据结构进行排序，因为任何一个策略做调度的时候，都是要区分谁先运行谁后运行。
			* struct sched_entity se 完全公平算法调度实体
			* struct sched_rt_entity rt 实时调度实体
			* struct sched_dl_entity dl Deadline 调度实体
		* 进程根据自己是实时的，还是普通的类型，通过这个成员变量，将自己挂在某一个数据结构里面，和其他的进程排序，等待被调度。
	* 红黑树存放位置：每个 CPU 都有自己的 struct rq 结构，用于描述在此 CPU 上所运行的所有进程，其包括一个实时进程队列 rt_rq 和一个 CFS 运行队列 cfs_rq，在调度时，调度器首先会先去实时进程队列找是否有实时进程需要运行，如果没有才会去 CFS 运行队列找是否有进程需要运行。
	* cfs_rq：rb_root 指向的就是红黑树的根节点，这个红黑树在 CPU 看起来就是一个队列，不断地取下一个应该运行的进程。rb_leftmost 指向的是最左面的节点。

```
## 更新进程运行的统计量
/*
 * Update the current task's runtime statistics.
 */
static void update_curr(struct cfs_rq *cfs_rq)
{
  struct sched_entity *curr = cfs_rq->curr;
  u64 now = rq_clock_task(rq_of(cfs_rq));
  u64 delta_exec;
......
  delta_exec = now - curr->exec_start;
......
  curr->exec_start = now;
......
  curr->sum_exec_runtime += delta_exec;
......
  curr->vruntime += calc_delta_fair(delta_exec, curr);
  update_min_vruntime(cfs_rq);
......
}


/*
 * delta /= w
 */
static inline u64 calc_delta_fair(u64 delta, struct sched_entity *se)
{
  if (unlikely(se->load.weight != NICE_0_LOAD))
        /* delta_exec * weight / lw.weight */
    delta = __calc_delta(delta, NICE_0_LOAD, &se->load);
  return delta;
}


struct sched_entity {
  struct load_weight    load;
  struct rb_node      run_node;
  struct list_head    group_node;
  unsigned int      on_rq;
  u64        exec_start;
  u64        sum_exec_runtime;
  u64        vruntime;
  u64        prev_sum_exec_runtime;
  u64        nr_migrations;
  struct sched_statistics    statistics;
......
};


struct rq {
  /* runqueue lock: */
  raw_spinlock_t lock;
  unsigned int nr_running;
  unsigned long cpu_load[CPU_LOAD_IDX_MAX];
......
  struct load_weight load;
  unsigned long nr_load_updates;
  u64 nr_switches;


  struct cfs_rq cfs;
  struct rt_rq rt;
  struct dl_rq dl;
......
  struct task_struct *curr, *idle, *stop;
......
};


/* CFS-related fields in a runqueue */
struct cfs_rq {
  struct load_weight load;
  unsigned int nr_running, h_nr_running;


  u64 exec_clock;
  u64 min_vruntime;
#ifndef CONFIG_64BIT
  u64 min_vruntime_copy;
#endif
  struct rb_root tasks_timeline;
  struct rb_node *rb_leftmost;


  struct sched_entity *curr, *next, *last, *skip;
......
};

```

##### 调度类工作

* sched_class 用于在队列上操作任务
	* 第一个成员变量，是一个指针，指向下一个调度类。
	*  enqueue_task 向就绪队列中添加一个进程，当某个进程进入可运行状态时，调用这个函数；
	*  dequeue_task 将一个进程从就绪队列中删除；
	*  pick_next_task 选择接下来要运行的进程；
	*  put_prev_task 用另一个进程代替当前运行的进程；
	*  set_curr_task 用于修改调度策略；
	*  task_tick 每次周期性时钟到的时候，这个函数被调用，可能触发调度。
	*  在这里面，重点看 fair_sched_class 对于 pick_next_task 的实现 pick_next_task_fair，获取下一个进程。调用路径如下：pick_next_task_fair->pick_next_entity->__pick_first_entity。
* 所有调度类类型放在一个链表上的。以调度最常见操作，取下一个任务为例，里面有一个 for_each_class 循环，沿着调度类型的顺序，依次调用每个调度类的方法。从优先级最高的调度类到优先级低的调度类，依次执行。而对于每种调度类，有自己的实现，例如，CFS 就有 fair_sched_class。
* 对于同样的 pick_next_task 选取下一个要运行的任务这个动作，不同的调度类有自己的实现。
	* fair_sched_class 的实现是 pick_next_task_fair，操作 cfs_rq
	* rt_sched_class 的实现是 pick_next_task_rt。操作 rt_rq
* 某个 CPU 需要找下一个任务执行的时候，会按照优先级依次调用调度类，不同的调度类操作不同的队列。当然 rt_sched_class 先被调用，它会在 rt_rq 上找下一个任务，只有找不到的时候，才轮到 fair_sched_class 被调用，它会在 cfs_rq 上找下一个任务。这样保证了实时任务的优先级永远大于普通任务。

```
struct sched_class {
  const struct sched_class *next;


  void (*enqueue_task) (struct rq *rq, struct task_struct *p, int flags);
  void (*dequeue_task) (struct rq *rq, struct task_struct *p, int flags);
  void (*yield_task) (struct rq *rq);
  bool (*yield_to_task) (struct rq *rq, struct task_struct *p, bool preempt);


  void (*check_preempt_curr) (struct rq *rq, struct task_struct *p, int flags);


  struct task_struct * (*pick_next_task) (struct rq *rq,
            struct task_struct *prev,
            struct rq_flags *rf);
  void (*put_prev_task) (struct rq *rq, struct task_struct *p);


  void (*set_curr_task) (struct rq *rq);
  void (*task_tick) (struct rq *rq, struct task_struct *p, int queued);
  void (*task_fork) (struct task_struct *p);
  void (*task_dead) (struct task_struct *p);


  void (*switched_from) (struct rq *this_rq, struct task_struct *task);
  void (*switched_to) (struct rq *this_rq, struct task_struct *task);
  void (*prio_changed) (struct rq *this_rq, struct task_struct *task, int oldprio);
  unsigned int (*get_rr_interval) (struct rq *rq,
           struct task_struct *task);
  void (*update_curr) (struct rq *rq)
  

extern const struct sched_class stop_sched_class;
extern const struct sched_class dl_sched_class;
extern const struct sched_class rt_sched_class;
extern const struct sched_class fair_sched_class;
extern const struct sched_class idle_sched_class;

/*
 * Pick up the highest-prio task:
 */
static inline struct task_struct *
pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
{
  const struct sched_class *class;
  struct task_struct *p;
......
  for_each_class(class) {
    p = class->pick_next_task(rq, prev, rf);
    if (p) {
      if (unlikely(p == RETRY_TASK))
        goto again;
      return p;
    }
  }
}


const struct sched_class fair_sched_class = {
  .next      = &idle_sched_class,
  .enqueue_task    = enqueue_task_fair,
  .dequeue_task    = dequeue_task_fair,
  .yield_task    = yield_task_fair,
  .yield_to_task    = yield_to_task_fair,
  .check_preempt_curr  = check_preempt_wakeup,
  .pick_next_task    = pick_next_task_fair,
  .put_prev_task    = put_prev_task_fair,
  .set_curr_task          = set_curr_task_fair,
  .task_tick    = task_tick_fair,
  .task_fork    = task_fork_fair,
  .prio_changed    = prio_changed_fair,
  .switched_from    = switched_from_fair,
  .switched_to    = switched_to_fair,
  .get_rr_interval  = get_rr_interval_fair,
  .update_curr    = update_curr_fair,
};


static struct task_struct *
pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
{
  struct task_struct *p;
  struct rt_rq *rt_rq = &rq->rt;
......
}


static struct task_struct *
pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
{
  struct cfs_rq *cfs_rq = &rq->cfs;
  struct sched_entity *se;
  struct task_struct *p;
......
}


## fair_sched_class 对于 pick_next_task 的实现 pick_next_task_fair，调用路径 pick_next_task_fair->pick_next_entity->__pick_first_entity。 
## 从红黑树里面取最左面的节点。
struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
{
  struct rb_node *left = rb_first_cached(&cfs_rq->tasks_timeline);


  if (!left)
    return NULL;


  return rb_entry(left, struct sched_entity, run_node);
```

#### 主动调度

* 网络和存储则多是和外部设备的合作；在操作外部设备的时候，往往需要让出 CPU，选择调用 schedule() 函数
* schedule 函数调用过程
	* 主要逻辑是在 `__schedule` 函数中实现
		* 当前的 CPU 上，取出任务队列 rq
		* `task_struct *prev` 指向这个 CPU 的任务队列上面正在运行的那个进程 curr
		* 继任 获取下一个任务，`task_struct *next` 指向下一个任务
			* 上面的逻辑普通进程 调用的就是 fair_sched_class.pick_next_task
			* 对于 CFS 调度类，取出相应的队列 cfs_r
				* 取出当前正在运行的任务 curr，如果依然是可运行的状态，也即处于进程就绪状态，则调用 update_curr 更新 vruntime。
				* pick_next_entity 从红黑树里面，取最左边的一个节点
					* task_of 得到下一个调度实体对应的 task_struct，如果发现继任和前任不一样，这就说明有一个更需要运行的进程了，就需要更新红黑树了。前面前任的 vruntime 更新过了，put_prev_entity 放回红黑树，会找到相应的位置，然后 set_next_entity 将继任者设为当前任务。
			* 当选出的继任者和前任不同，就要进行上下文切换，继任者进程正式进入运行。

```
## 写入块设备
static void btrfs_wait_for_no_snapshoting_writes(struct btrfs_root *root)
{
......
  do {
    prepare_to_wait(&root->subv_writers->wait, &wait,
        TASK_UNINTERRUPTIBLE);
    writers = percpu_counter_sum(&root->subv_writers->counter);
    if (writers)
      schedule();
    finish_wait(&root->subv_writers->wait, &wait);
  } while (writers);
}

## 网络设备
static ssize_t tap_do_read(struct tap_queue *q,
         struct iov_iter *to,
         int noblock, struct sk_buff *skb)
{
......
  while (1) {
    if (!noblock)
      prepare_to_wait(sk_sleep(&q->sk), &wait,
          TASK_INTERRUPTIBLE);
......
    /* Nothing to read, let's sleep */
    schedule();
  }
......
}


asmlinkage __visible void __sched schedule(void)
{
  struct task_struct *tsk = current;


  sched_submit_work(tsk);
  do {
    preempt_disable();
    __schedule(false);
    sched_preempt_enable_no_resched();
  } while (need_resched());
}


static void __sched notrace __schedule(bool preempt)
{
  struct task_struct *prev, *next;
  unsigned long *switch_count;
  struct rq_flags rf;
  struct rq *rq;
  int cpu;


  cpu = smp_processor_id();
  rq = cpu_rq(cpu);
  prev = rq->curr;

	next = pick_next_task(rq, prev, &rf);
	clear_tsk_need_resched(prev);
	clear_preempt_need_resched();
	

static inline struct task_struct *
pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
{
  const struct sched_class *class;
  struct task_struct *p;
  /*
   * Optimization: we know that if all tasks are in the fair class we can call that function directly, but only if the @prev task wasn't of a higher scheduling class, because otherwise those loose the opportunity to pull in more work from other CPUs.
   */
  if (likely((prev->sched_class == &idle_sched_class ||
        prev->sched_class == &fair_sched_class) &&
       rq->nr_running == rq->cfs.h_nr_running)) {
    p = fair_sched_class.pick_next_task(rq, prev, rf);
    if (unlikely(p == RETRY_TASK))
      goto again;
    /* Assumes fair_sched_class->next == idle_sched_class */
    if (unlikely(!p))
      p = idle_sched_class.pick_next_task(rq, prev, rf);
    return p;
  }
again:
  for_each_class(class) {
    p = class->pick_next_task(rq, prev, rf);
    if (p) {
      if (unlikely(p == RETRY_TASK))
        goto again;
      return p;
    }
  }
}


static struct task_struct *
pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
{
  struct cfs_rq *cfs_rq = &rq->cfs;
  struct sched_entity *se;
  struct task_struct *p;
  int new_tasks;
  

## CFS 调度类，取出相应队列 cfs_rq，取出当前正在运行的任务 curr，如果依然是可运行的状态，也即处于进程就绪状态，则调用 update_curr 更新 vruntime
struct sched_entity *curr = cfs_rq->curr;
if (curr) {
  if (curr->on_rq)
	update_curr(cfs_rq);
  else
	curr = NULL;
......
}
## pick_next_entity 从红黑树里面，取最左边的一个节点
se = pick_next_entity(cfs_rq, curr);
	
	
## pick_next_entity
  p = task_of(se);


  if (prev != p) {
    struct sched_entity *pse = &prev->se;
......
    put_prev_entity(cfs_rq, pse);
    set_next_entity(cfs_rq, se);
  }


  return p


if (likely(prev != next)) {
    rq->nr_switches++;
    rq->curr = next;
    ++*switch_count;
......
    rq = context_switch(rq, prev, next, &rf);
```

#### 进程上下文切换

* 切换进程空间，也即虚拟内存
* 切换寄存器和 CPU 上下文:switch_to->`__switch_to_asm`汇编代码->`__switch_to`
	- 64位 `__switch_to` 有一个 Per CPU 的结构体 tss
		+ 在 x86 体系结构中，提供了一种以硬件的方式进行进程切换的模式，对于每个进程，x86 希望在内存里面维护一个 TSS（Task State Segment，任务状态段）结构。这里面有所有的寄存器。
		+ 有一个特殊的寄存器 TR（Task Register，任务寄存器），指向某个进程的 TSS。更改 TR 的值，将会触发硬件保存 CPU 所有寄存器的值到当前进程的 TSS 中，然后从新进程的 TSS 中读出所有寄存器值，加载到 CPU 对应的寄存器中。
		+ 缺点:做进程切换的时候，没必要每个寄存器都切换，这样每个进程一个 TSS，就需要全量保存，全量切换，动作太大了。
		+ 系统初始化调用 cpu_init :给每一个 CPU 关联一个 TSS，然后将 TR 指向这个 TSS，然后在操作系统的运行过程中，TR 就不切换了，永远指向这个 TSS。TSS 用数据结构 tss_struct 表示，在 x86_hw_tss 中可以看到和图中相应的结构。
		+ Linux 中，真的参与进程切换的寄存器很少，主要的就是栈顶寄存器。task_struct 里面成员变量 thread，保留了要切换进程的时候需要修改的寄存器
	+ 进程切换，将某个进程的 thread_struct 里面的寄存器的值，写入到 CPU 的 TR 指向的 tss_struct，对于 CPU 来讲，这就算是完成了切换
* 指令指针寄存器切换：内核态共享内存，切换进程同时上下文切换，因此需要进程记住自己的路径。从哪里来，要到哪里去 A->B->C->A
	* 进程 A 在内核态的指令指针是指向 `__schedule `了。这里请记住，**A 进程内核栈会保存这个 `__schedule` 的调用，而且知道这是从 btrfs_wait_for_no_snapshoting_writes 这个函数里面进去的**。
	* 当进程 A 在内核里面执行 switch_to 的时候，内核态的指令指针也是指向这一行的。在 switch_to 里面，将寄存器和栈都切换到成了进程 B 的，唯一没有变的就是指令指针寄存器。当 switch_to 返回的时候，指令指针寄存器指向了下一条语句 finish_task_switch。但这个时候的 finish_task_switch 已经不是进程 A 的 finish_task_switch 了，而是进程 B 的 finish_task_switch 了。
	* 从 finish_task_switch 完毕后，返回 `__schedule` 的调用了。返回到哪里呢？按照函数返回的原理，当然是从内核栈里面去找，是返回到 btrfs_wait_for_no_snapshoting_writes 吗？当然不是了，因为 btrfs_wait_for_no_snapshoting_writes 是在 A 进程的内核栈里面的，它早就被切换走了，应该从 B 进程的内核栈里面找。
	* B 是前面例子里面调用 tap_do_read 读网卡的进程。它当年调用 `__schedule` 的时候，是从 tap_do_read 这个函数调用进去的.内核栈里面放的是 tap_do_read。于是，从`__schedule` 返回之后，当然是接着 tap_do_read 运行，然后在内核运行完毕后，返回用户态。这个时候，B 进程内核栈的 pt_regs 也保存了用户态的指令指针寄存器，就接着在用户态的下一条指令开始运行就可以了。
	* 只有一个 CPU，从 B 切换到 C，从 C 又切换到 A。在 C 切换到 A 的时候:这个时候运行的 finish_task_switch，才是 A 进程的 finish_task_switch。运行完毕从`__schedule` 返回的时候，从内核栈上才知道，当年是从 btrfs_wait_for_no_snapshoting_writes 调用进去的，因而应该返回 btrfs_wait_for_no_snapshoting_writes 继续执行，最后内核执行完毕返回用户态，同样恢复 pt_regs，恢复用户态的指令指针寄存器，从用户态接着运行。
	* 通过三个变量 switch_to(prev = A, next=B，last = C);A 当时被切换走的时候，是切换成 B，这次切换回来，是从 C 回来的"
			- 进程A从进程C切换回来时，进程A内核栈中变量的定义:prev=last=C，netxt=B，由于当前就是在进程A的地址空间里，所以，进程A可以说，当年我被切换到进程B，现在，由进程C又切换回来了。
	- A-》B-》C-》A 整个过程才能让A最后知道我是被谁切走的 又从哪里切回来，其实last就是前一个内核栈的prev,只是需要将prev携带到next内核栈保留到last中
	- 切换,就是切内核态的 stack/rsp/pc, 这样下一个任务就能找到在哪执行了,以及继续怎么执行, 而内核态共享一片内存空间,所以不需要mm_switch,切换完了,返回用户态,用户态的stack/rsp/pc都被切换了, 而用户态的内存空间需要单独切换
	- 当函数返回的时候，由于切换了上下文，包括栈指针，所以一个进程函数执行return返回到了另一个进程，也就是完成了进程的切换。
* 工具
	* 通过`ps -o etime= -p "$$"` 可以 查看，进程的运行时间
	*  通过/proc/{pid}/status 中的 voluntary_ctxt_switches: nonvoluntary_ctxt_switches: 可以看到主动调度和抢占调度的次数
	*  也可以单独安装sysstat 使用`pidstat -w` 查看相关进程的调度信息
	*  ps 里面的TIME就是进程的 cpu runtime
	*  查看上下文切换,可以用cat /proc/x/status

![32 位的 TSS 结构](../_static/32bit_tss.jpg)

```c
/*
 * context_switch - switch to the new MM and the new thread's register state.
 */
static __always_inline struct rq *
context_switch(struct rq *rq, struct task_struct *prev,
         struct task_struct *next, struct rq_flags *rf)
{
  struct mm_struct *mm, *oldmm;
......
  mm = next->mm;
  oldmm = prev->active_mm;
......
  switch_mm_irqs_off(oldmm, mm, next);
......
  /* Here we just switch the register state and the stack. */
  switch_to(prev, next, prev);
  barrier();
  return finish_task_switch(prev);
}


#define switch_to(prev, next, last)          \
do {                  \
  prepare_switch_to(prev, next);          \
                  \
  ((last) = __switch_to_asm((prev), (next)));      \
} while (0)

## 32 位操作系统 切换栈顶指针 esp
/*
 * %eax: prev task
 * %edx: next task
 */
ENTRY(__switch_to_asm)
......
  /* switch stack */
  movl  %esp, TASK_threadsp(%eax)
  movl  TASK_threadsp(%edx), %esp
......
  jmp  __switch_to
END(__switch_to_asm)

## 64 位操作系统 切换 栈顶指针 rsp
/*
 * %rdi: prev task
 * %rsi: next task
 */
ENTRY(__switch_to_asm)
......
  /* switch stack */
  movq  %rsp, TASK_threadsp(%rdi)
  movq  TASK_threadsp(%rsi), %rsp
......
  jmp  __switch_to
END(__switch_to_asm)


__visible __notrace_funcgraph struct task_struct *
__switch_to(struct task_struct *prev_p, struct task_struct *next_p)
{
  struct thread_struct *prev = &prev_p->thread;
  struct thread_struct *next = &next_p->thread;
......
  int cpu = smp_processor_id();
  struct tss_struct *tss = &per_cpu(cpu_tss, cpu);
......
  load_TLS(next, cpu);
......
  this_cpu_write(current_task, next_p);


  /* Reload esp0 and ss1.  This changes current_thread_info(). */
  load_sp0(tss, next);
......
  return prev_p;
}


__visible __notrace_funcgraph struct task_struct *
__switch_to(struct task_struct *prev_p, struct task_struct *next_p)
{
  struct thread_struct *prev = &prev_p->thread;
  struct thread_struct *next = &next_p->thread;
......
  int cpu = smp_processor_id();
  struct tss_struct *tss = &per_cpu(cpu_tss, cpu);
......
  load_TLS(next, cpu);
......
  this_cpu_write(current_task, next_p);


  /* Reload esp0 and ss1.  This changes current_thread_info(). */
  load_sp0(tss, next);
......
  return prev_p;
}


void cpu_init(void)
{
  int cpu = smp_processor_id();
  struct task_struct *curr = current;
  struct tss_struct *t = &per_cpu(cpu_tss, cpu);
    ......
    load_sp0(t, thread);
  set_tss_desc(cpu, t);
  load_TR_desc();
    ......
}


struct tss_struct {
  /*
   * The hardware state:
   */
  struct x86_hw_tss  x86_tss;
  unsigned long    io_bitmap[IO_BITMAP_LONGS + 1];
}
```


#### 抢占式调度

* 通过计算判断是否被抢占
	* 时钟中断处理函数会调用 scheduler_tick()
	* sum_exec_runtime-prev_sum_exec_runtime 就是这次调度占用实际时间。如果这个时间大于 ideal_runtime，则应该被抢占了。
	* 还会通过 `__pick_first_entity` 取出红黑树中最小的进程。如果当前进程的 vruntime 大于红黑树中最小的进程的 vruntime，且差值大于 ideal_runtime，也应该被抢占了。
* 当一个进程被唤醒的时候，当被唤醒的进程优先级高于 CPU 上的当前进程，就会触发抢占。
	* try_to_wake_up() 调用 ttwu_queue 将这个唤醒的任务添加到队列当中。
	* ttwu_queue 再调用 ttwu_do_activate 激活这个任务。
	* ttwu_do_activate 调用 ttwu_do_wakeup。这里面调用了 check_preempt_curr 检查是否应该发生抢占。
* 当发现当前进程应该被抢占，不能直接把它踢下来，而是把它标记为应该被抢占。为什么呢？因为进程调度第一定律呀，一定要等待正在运行的进程调用`__schedule` 才行啊，所以这里只能先标记一下。
	* 标记一个进程应该被抢占，调用 resched_curr，它会调用 set_tsk_need_resched，标记进程应该被抢占，但是此时此刻，并不真的抢占，而是打上一个标签 TIF_NEED_RESCHED。
* 抢占时机
	* 用户态抢占时机：
		* 从系统调用中返回的那个时刻。64 位的系统调用的链路位 do_syscall_64->syscall_return_slowpath->prepare_exit_to_usermode->exit_to_usermode_loop，中的exit_to_usermode_loop
		* 从中断中返回的那个时刻：`arch/x86/entry/entry_64.S` 中有中断的处理过程。是一段汇编语言代码，重点领会它的意思就行，不要纠结每一行都看懂
			* 中断处理调用的是 do_IRQ 函数，中断完毕后分为两种情况，一个是返回用户态，一个是返回内核态
	* 内核态的抢占时机
		* 被抢占的时机一般发生在 preempt_enable() 中。在内核态的执行中，有的操作是不能被中断的，所以在进行这些操作之前，总是先调用 preempt_disable() 关闭抢占，当再次打开的时候，就是一次内核态代码被抢占的机会。
		* preempt_enable() 调用 preempt_count_dec_and_test()，判断 preempt_count 和 TIF_NEED_RESCHED 是否可以被抢占。如果可以，就调用 preempt_schedule->preempt_schedule_common->`__schedule` 进行调度
		* 在内核态也会遇到中断的情况，当中断返回的时候，返回的仍然是内核态。这个时候也是一个执行抢占的时机，再看中断汇编代码中断返回的代码中返回内核的那部分代码，调用的是 preempt_schedule_irq。

```
void scheduler_tick(void)
{
  int cpu = smp_processor_id();
  struct rq *rq = cpu_rq(cpu);
  struct task_struct *curr = rq->curr;
......
  curr->sched_class->task_tick(rq, curr, 0);
  cpu_load_update_active(rq);
  calc_global_load_tick(rq);
......
}

## fair_sched_class task_tick 实现
static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
{
  struct cfs_rq *cfs_rq;
  struct sched_entity *se = &curr->se;


  for_each_sched_entity(se) {
    cfs_rq = cfs_rq_of(se);
    entity_tick(cfs_rq, se, queued);
  }
......
}


static void
entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
{
  update_curr(cfs_rq);
  update_load_avg(curr, UPDATE_TG);
  update_cfs_shares(curr);
.....
  if (cfs_rq->nr_running > 1)
  ## 检查是否是时候被抢占
    check_preempt_tick(cfs_rq, curr);
}


static void
check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
{
  unsigned long ideal_runtime, delta_exec;
  struct sched_entity *se;
  s64 delta;


  ideal_runtime = sched_slice(cfs_rq, curr);
  delta_exec = curr->sum_exec_runtime - curr->prev_sum_exec_runtime;
  if (delta_exec > ideal_runtime) {
    resched_curr(rq_of(cfs_rq));
    return;
  }
......
  se = __pick_first_entity(cfs_rq);
  delta = curr->vruntime - se->vruntime;
  if (delta < 0)
    return;
  if (delta > ideal_runtime)
    resched_curr(rq_of(cfs_rq));
}



static void ttwu_do_wakeup(struct rq *rq, struct task_struct *p, int wake_flags,
         struct rq_flags *rf)
{
  check_preempt_curr(rq, p, wake_flags);
  p->state = TASK_RUNNING;
  trace_sched_wakeup(p);
  

static inline void set_tsk_need_resched(struct task_struct *tsk)
{
  set_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
}



static void exit_to_usermode_loop(struct pt_regs *regs, u32 cached_flags)
{
  while (true) {
    /* We have work to do. */
    local_irq_enable();


    if (cached_flags & _TIF_NEED_RESCHED)
      schedule();
......
  }
}


#define preempt_enable() \
do { \
  if (unlikely(preempt_count_dec_and_test())) \
    __preempt_schedule(); \
} while (0)


#define preempt_count_dec_and_test() \
  ({ preempt_count_sub(1); should_resched(0); })


static __always_inline bool should_resched(int preempt_offset)
{
  return unlikely(preempt_count() == preempt_offset &&
      tif_need_resched());
}


#define tif_need_resched() test_thread_flag(TIF_NEED_RESCHED)


static void __sched notrace preempt_schedule_common(void)
{
  do {
......
    __schedule(true);
......
  } while (need_resched())
```

#### Multi-Level Feed Queue

* 饿死:优先队列一直有任务,普通队列的task一直得不到处理
* 通过优先级保证交互性的task，能够快速响应，同时通过统计task 对CPU的使用时间以期对TASK判断
	* 如果某个task 在其时间片里用完前释放CPU， 可以认为这是种交互式的task, 优先级保留。
	* 反之认为某个task是需要运行时间长的。同时基于对task 对cpu 时间使用的统计作为判断依据。这样经过一段时间运行后，长时间运行的队列会被逐渐降低优先级。
* 快速响应的task 能够优先使用CPU
	* 问题
		* 如果优先级低的一直得不到cpu, 可能会出现饿死
		* 有人可能会利用这个漏洞编程的方式在使用完CPU时间片后释放CPU，从而控制CPU
	* Multi-feedback-queue 5条规则：  
		- 如果A的优先级大于B， 则A先运行。  
		- 如果A的优先级等于B， 则以RR算法交互运行。  
		-  新来的 Task 会被置于最高的优先级。  
		- 如果一个task 在其当前优先级运行完被分配的时间片后，会降低其优先级，重置其放弃使用CPU的次数。（这条规则修改过，是为了防止有人利于原有规则的漏洞控制CPU, 原来的规则是如果一个task 在其时间片用完前释放cpu, 则其优先级保持不变， 这个修正增加了对task 实际使用cpu 时间统计作为判断依据）。  
		- 系统每过时钟周期的倍数，会重置所有task 的优先级。（这条规则是为了防止task被饿死的，也是我之前所疑惑的）。

####  信号 Signal

* 对于一些不严重的信号，可以忽略，该干啥干啥，但是像 SIGKILL（用于终止一个进程的信号）和 SIGSTOP（用于中止一个进程的信号）是不能忽略的，可以执行对于该信号的默认动作。
* 每种信号都定义了默认的动作，例如硬件故障，默认终止；也可以提供信号处理函数，可以通过sigaction系统调用，注册一个信号处理函数。

#### 进程间通信

* 消息队列（Message Queue） 在内核里
	* 通过msgget创建一个新的队列
	* msgsnd将消息发送到消息队列
	* 消息接收方可以使用msgrcv从队列中取消息
* 共享内存
	* shmget 创建一个共享内存块
	* shmat 将共享内存映射到自己的内存空间，然后就可以读写
	* 存在“竞争”问题：如果大家同时修改同一块数据咋办？
	* 信号量机制 Semaphore：让不同的人能够排他地访问
		* 对于只允许一个人访问的需求，将信号量设为 1
		* 当一个人要访问的时候，先调用sem_wait。如果这时候没有人访问，则占用这个信号量，就可以开始访问了。
		* 如果这个时候另一个人要访问，也会调用 sem_wait。由于前一个人已经在访问了，所以后面这个人就必须等待上一个人访问完之后才能访问。
		* 当上一个人访问完毕后，会调用sem_post将信号量释放，于是下一个人等待结束，可以访问这个资源了。

### 网络服务

* 不同机器的通过网络相互通信，要遵循相同的网络协议，也即 TCP/IP 网络协议栈。Linux 内核里有对于网络协议栈的实现
* 网络服务是通过套接字 Socket 来提供服务的
	* Socket “插口”|“插槽
* 在通信之前，双方都要建立一个 Socket。

## 资料

* OSTEP(Operating System Three Easy Picies)
* 《一个64位操作系统的设计与实现》
* 《从实模式到保护模式》
* https://github.com/chyyuu/ucore_os_lab