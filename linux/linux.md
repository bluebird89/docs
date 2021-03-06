# [linux](https://github.com/torvalds/linux)

* 由芬兰大学生linus在1991年开发，基于Intel80386微处理器，开发完后就在因特网发布了源码。借鉴了unix的很多设计思想，但实现完全不同。开源协议非常自由，可以自由修改，但需要将改过源码继续发布出来
* Linux 操作系统实际上是90年代初期的两个成果组合
  - Richard Stallman 希望创建一个作为替代私有Unix系统的真正免费的和开源的系统
    + [GNU](http://ftp.gnu.org/gnu/) 由Richard Stallman（理查德·斯托曼）在1983年9月27日公开发起的自由软件集体协作计划。目标是创建一套完全自由的操作系统.以 GNU 名义开发实用工具和程序
    + 这是一种递归算法，意思是“GNU不是Unix！”虽然它有一个内核项目正在进行，但结果证实开展起来很困难，这样没有内核，免费并开源操作系统的梦想就无法实现
  - Linus Torvald 工作:编写出一种可工作的和可行的内核，被他称为Linux--整个操作系统因此而诞生。鉴于Linus使用的是多种GNU工具（例如GNU编译器集合或GCC），GNU工具和Linux内核的结合是天生的绝配
  - GNU系统与Linux内核结合构成一个完整的操作系统：一个基于Linux的GNU系统，该操作系统在通常情况下称为“GNU/Linux”，或简称Linux
* Linux发行版使用GNU提供组件、Linux内核，MIT的X-Windows GUI以及其他可以在开源BSD许可下使用的BSD组件来实现。像Slackware和Red Hat这样的发行版的早期流行给了上世纪90年代的“普通PC用户”使用Linux操作系统的机会，以及他们在工作或学术生活中使用的许多专有的Unix系统功能和实用工具
* 在免费和开源组件之上提供支持的商业Linux产品变得可行，因为包括IBM在内的许多企业都从专有的Unix迁移到在Linux上提供中间件和软件解决方案。Red Hat在Red Hat Enterprise Linux周围建立了一个商业支持模型，德国供应商SUSE Linux Enterprise Server（SLES）也是如此
* 特点
  - 单内核
  - 模块化设计，支持动态加载内核模块
  - 支持对称多处理机制（SMP），多个处理器需要考虑共享资源问题
  - 抢占式多任务操作系统，内核对进程的调度属于抢占式
  - 支持内核线程，但不区分线程与进程，所有进程都一样
* Multi-User Operating Systems
  - 多用户可以同时登陆同一台主机，共享主机资源
  - 不同用户分别有自己用户空间，用于存放各自文件
  - 不同用户文件放在同一个物理磁盘上的甚至同一个逻辑分区或者目录里，但是由于 Linux 的用户管理和 文件权限机制，不同用户不可以轻易地查看、修改彼此的文件

## Linux vs Unix

Linux是基于Unix的，属于Unix类，Uinx操作系统支持多用户、多任务、多线程和支持多种CPU架构的操作系统。Linux继承了Unix以网络为核心的设计思想，是一个性能稳定的多用户网络操作系统

* 相似
  - 用户体验角度来讲，没有太多区别！Linux的大部分优点包括操作系统可跨多硬件架构（包括现代PC）特性，以及能够让Unix系统的管理员和用户使用他们熟悉的工具的能力
  - 在Unix上编写的软件可以在Linux操作系统上编译，而在移植方面不用花费太多的功夫。
  - 作为把Linux作为主要目标的开发平台，macOS设备和操作系统的普及，可能归功于类BSD的macOS操作系统。很多Linux系统工具和脚本可以简单地在macOS终端运行。很多在Linux上可用的开源软件组件也可以在macOS上使用，如Homebrew
* 区别
  - 开源vs私有，授权软件
    + Unix发行版中缺少通用内核对软件和硬件供应商都有影响。由于Unix家族的商业和学术分支，供应商可能不得不为不同版本的Unix开发不同的驱动，而且作为很多不同版本的Unix的二进制设备驱动，对这些软件的SDK或者发行版本的访问，也会让他们有授权和其他方面的担忧
    + 对于Linux，供应商可以为特定硬件设备创建设备驱动，并有理由预计，它可以在大多数发行版中运行
* Linux 已经显示出超越专有 Unix 的显著优势在于其在大量硬件平台和设备上的可用性。 Raspberry Pi 受到业余爱好者和发烧友的欢迎，它是 Linux 驱动的，为运行 Linux 的各种物联网设备打开了大门。 已经提到了 Android 设备，汽车（包括Automotive Grade Linux）和智能电视，其中Linux占有很大的市场份额

![UNIX/BSD操作系统历史](../_static/Unix-like-operating-systems-history.png "Optional title")

## 10 moments that shaped Linux history

* Linus Torvalds initially released Linux to the world in 1991 as a hobby. It didn't remain a hobby for long!
* In 1993, several Linux distributions were founded, notably Debian, Red Hat, and Slackware. These were important because they demonstrated Linux's gains in market acceptance and development that enabled it to survive the tumultuous OS wars, browser wars, and protocol wars of the 1990s. In contrast, many established, commercial, and proprietary products did not make it past the turn of the millennium!
* In 2000, IBM announced it would invest US$1 billion dollars in Linux. In his CNN Money [article about the investment](https://money.cnn.com/2000/12/12/technology/ibm_linux), Richard Richtmyer wrote: "The announcement underscores Big Blue's commitment to Linux and marks significant progress in moving the alternative operating system into the mainstream commercial market."
* In 2002, it seemed the entire Hollywood movie industry adopted Linux. Disney, Dreamworks, and Industrial Light & Magic all began making movies with Linux that year.
* In 2003, another big moment came with the US government's acceptance of Linux. Red Hat Linux was awarded the Department of Defense Common Operating Environment (COE) certification. This is significant because the government—intelligence and military agencies in particular—have very strict requirements for computing systems to prevent attacks and support national security. This opened the door for other agencies to use Linux. Later that year, the National Weather Service announced it would replace outdated systems with new computers running Linux.
* This "moment" is really a collection of my personal experiences. As my career progressed in the 2000s, I discovered several types of systems and devices that I managed were all running Linux. Some of the places I found Linux were VMware ESX, F5 Big-IP, Check Point UTM Edge, Cisco ASA, and PIX. This made me realize that Linux was truly viable and here to stay.
* In 2004, Canonical was founded by Mark Shuttleworth to provide an easy-to-use Linux desktop—Ubuntu Linux—based on the Debian distribution. I think Ubuntu Linux helped to expand the desktop Linux install base. It put Linux in front of many more people, from casual home users to professional software developers.
* Google released two operating systems based on the Linux kernel: the Android mobile operating system in mid-2008 and Chrome OS, running on a Chromebook, in 2011. Since then, millions of Android mobile phones and Chromebooks have been sold.
* In the past 10 years or so, cloud computing has gone from a grandiose vision of computing on the internet to a reinvention of how we use computers personally and professionally. The big players in the cloud space are built on Linux, including Amazon Web Services, Google Cloud Services, and Linode. Even in cases where we aren't certain, such as Microsoft Azure, running Linux workloads is well supported.
* Many automakers began introducing Linux a few years ago. This led to the formation of the collaborative open source project called Automotive Grade Linux. Major car makers, such as Toyota and Subaru, have joined together to develop Linux-based automotive entertainment, navigation, and engine-management systems.

## Linux distributions 发行版

* 顺序： arch->gentoo->freebsd
* [GNU](https://www.gnu.org/)
  - [Linux](https://www.getgnulinux.org/)
* BSD Berkeley Software Distribution
  - Linux和BSD（Berkeley Software Distribution）均是UNIX的演化分支。并且，Linux中相当多的特性和功能（比如用于配置DNS的Bind软件）都是取自于BSD的。而FreeBSD便是BSD家族中最出名，用户数量最多的一个发行版
  - Mac
* 入门：类似Windows的体验；安装简单；可靠；“类似Linux”，且不自成一派；“恰好管用”；
  - [Linux Mint](https://linuxmint.com/)
    + [Guide-for-linuxmint](https://github.com/Duter2016/Guide-for-linuxmint)
  - [Debian](https://www.debian.org/)
* 进阶：完全掌控电脑和操作系统；了解Linux内部；精简的优化系统
  - Slackware Linux
  - [Arch Linux](https://www.archlinux.org/)
  - [Gentoo Linux](https://www.gentoo.org/)
* 正常：运行平稳，维护量低；最小配置；大部分事情可以自动完成；兼容硬件和软件
  - [openSUSE](https://www.opensuse.org/)
  - [Ubuntu](./ubuntu.md)
  - [UbuntuDDE](https://ubuntudde.com/): Powerful Ubuntu with the most beautiful desktop environment.
* 安全与稳定：为学习最新的东西而甘冒风险；最新和最伟大的功能；有趣的配置以便于处理重大更改
  - [Fedora](https://getfedora.org/)
  - [Kali Linux](https://www.kali.org/ "Kali Linux")
    + [offensive-security/kali-linux-docker](https://github.com/offensive-security/kali-linux-docker):Kali Linux Docker
    + [kalitools](https://github.com/Jack-Liang/kalitools):Kali Linux工具清单
* 服务器：稳定性；安全；支持其他出于同样原因的程序员使用
  - [CentOS](./centos.md)
  - Red Hat Enterprise Linux (RHEL)
    + 2018年10月份，IBM宣布，已经正式完成对红帽(Red Hat)的收购，耗资340亿美元
  - [FreeBSD](https://www.freebsd.org/)
    + 立于1993年，拥有相当长的历史
* 性能：显著的性能提升；高负载计算
  - Clear Linux  (For Intel CPUS, by Intel)
* 桌面：安全性；匿名性
  - [TAILS Linux](https://tails.boum.org/index.en.html)
  - Alpine Linux
  - CoreOS
  - TENS Linux (DOD Project)
  - Tin Hat Linux
  - [OpenBSD](http://www.openbsd.org/)
  - [Manjaro](https://manjaro.org/):anjaro is a professionally made Linux based operating system that is a suitable replacement for Windows or MacOS. Multiple Desktop Environments are available through our Official and Community editions. We also work with manufacturers to design dedicated hardware. Visit the shop for more information 基于 Arch 的 Linux 发行版,安装是一件稍微复杂的工作
    + [Manjaro 配置记录](https://10101.io/2020/05/24/manjaro-configuration)
  - [Elementary OS](https://elementary.io/)
  - [openEuler](https://openeuler.org/)
  - Icaros Desktop
* 最小化：将在旧的硬件上运行；尽可能最小化
  - ArchBang
  - [Kubuntu](https://kubuntu.org/):unites Ubuntu with KDE and the fabulous Plasma desktop, bringing you a full set of applications. 需要等待数月来获取新的 KDE 软件
  - [Lubuntu](https://lubuntu.net/):a fast and lightweight operating system with a clean and easy-to-use user interface.It is a Linux system, that uses the minimal desktop LXDE/LXQT, and a selection of light applications
  - Puppy Linux
  - Tiny Core Linux
  - Bodhi Linux
* SUSE Linux Enterprise Server
* [Zorin OS](https://zorinos.com/):努力提供了良好的用户体验
  - [Zorin Grid](https://itsfoss.com/zorin-grid/)
* Cub Linux
* [Pop!_os](https://system76.com/pop):an operating system for STEM and creative professionals who use their computer as a tool to discover and create
* [KDE Neon](https://neon.kde.org/):基于 Ubuntu 的轻量级 Linux 发行版,采用 KDE Plasma 桌面，看起来精美绝伦
* [Nitrux](https://nxos.org/)
* [xubuntu](https://xubuntu.org/)
* [MX Linux](https://mxlinux.org/)
* [Solus](https://getsol.us/home/)
* [AntiX](https://antixlinux.com/)
* [TurnKey Linux](http://www.turnkeylinux.org/)  Deploy open source apps on VM or the clouds
* [Qubes OS](https://www.qubes-os.org/ "Qubes OS")

![distro-family-tree](../_static/distro-family-tree.png "Optional title")

## 安装

- 最外层客户机Ubuntu
- 两三个小分区出来，可以装多个linux发行版
- 公用/home分区
+ 每次装linux，/直接装在其中一个小分区上，/home挂载到第三个主分区去，那里存放文档和代码数据的，这样有什么新的linux就装，文档一直在，
+ 可以装新linux时起个不重复的用户名，也在home下，完全不影响老的文档和使用环境配置
- 安装第二个Linux发行版的时候，需要注意的是，EFI分区和交换分区swap已经有可用的了，安装程序可以自动检测得到，因此不需要再关系这2个分区，只需要在磁盘剩余的空闲分区中创建这个系统本身需要的根分区/和/home分区

## 操作系统

* 由内核空间和用户空间组成。从存储的角度来看，内核空间主要是指需要引导程序加载和启动的内核程序，用户空间的核心则是 rootfs

```
arch| uname -m # 显示机器的处理器架构

# 查看linux系统信息
cat /proc/version # 说明正在运行的内核版本
cat /etc/issue # 显示的是发行版本信息
lsb_release -a
uname -a # 显示电脑以及操作系统的相关信息
uname -rs # 显示正在使用的内核版本
sudo dpkg --get-selections |grep linux-image

neofetch
```

## Architecture

* The Linux kernel is monolithic in nature.
  - 补丁 Prepatch：Prepatch 或 “RC” 内核是主线内核的预发布版本，主要针对其他内核开发者和 Linux 爱好者。它们必须从源码中编译，并且通常包含新的功能，这些功能必须在稳定发布之前进行测试。Prepatch 内核由 Linus Torvalds 维护和发布。
  - 主线版 Mainline：主线版本由 Linus Torvalds 维护。它是介绍所有新功能的版本，包含了所有令人兴奋的新开发的功能。新的主线内核每 2-3 个月发布一次。
  - 稳定版 Stable：每一个主线内核发布后，都被认为是“稳定的”。任何稳定内核的错误修复都会从主线版本上回溯，并由指定的稳定内核维护者应用。在下一个主线内核可用之前，通常只有几个错误修复内核的发布 – 除非它被指定为 “长期维护内核”。稳定的内核更新是根据需要发布的，通常一周一次。
  - 长期版 Longterm：通常会有几个 “长期维护 “的内核版本，目的是为旧内核树的错误进行后向（backporting）修正。只有重要的bug 修复才会被应用到这长期内核版本中，而且它们通常不会频繁发布，尤其是对于老的内核版本。
* System calls are used to interact with the Linux kernel space.
* Kernel code can only be executed in the kernel mode. Non-kernel code is executed in the user mode.
* Device drivers are used to communicate with the hardware devices.

![Linux Architecture](../_static/linux_architecture.png "Linux Architecture")

## 桌面环境 Desktop Environments

* UNIX/Linux 本身没有图形界面的，在发行版上看到的图形界面是运行在 Linux 系统之上的一套软件,以前是 XFree86，现在是 xorg（X.Org）
* 通过 X 窗口系统（X Window System，也常被称为 X11 或 X）实现的，X 本身只是工具包及架构协议
* xorg 是 X 架构规范的一个实现体，实现了 X 协议规范的一个提供图形界面服务的服务器，就像实现了 http 协议提供 web 服务的 Apache
* 如果只有服务器也是不能实现一个完整的桌面环境的，还需要一个客户端 X Client，像如下几个熟知也最流行的实现了客户端功能的桌面环境
* [MATE](https://mate-desktop.org/ "MATE Desktop Environment")
	*  forked from Gnome 2.x
- [KDE Plasma](https://www.kde.org/plasma-desktop)
  + [](https://store.kde.org/browse/cat/)
  + wighet
    * 安装
    * Event Calendar 
- [Xfce](https://www.xfce.org/)
- GNOME
- [LXDE](https://www.lxde.org/ "LXDE Desktop Environment")*(**Lightweight X11 Desktop Environment**)
- [LXQT](https://lxqt-project.org/ "LXQt - The Lightweight Qt Desktop Environment")
- [Trinity Desktop Environment (TDE)](https://www.trinitydesktop.org/ "Trinity Desktop Environment")
- [Cinnamon](http://cinnamon.linuxmint.com/) a GTK+ based desktop environment and a fork of the GNOME Shell
* Graphical user interface (GUI) vs Command line interface (CLI)
  - Graphical user interface allows a user to interact with the computer using graphics such as icons and images. When a user clicks on an icon to open an application on a computer, he or she is actually using the GUI. It's easy to perform tasks using GUI.
  - Command line interface allows a user to interact with the computer using commands. A user types the command in a terminal and the system helps in executing these commands. A new user with experience on GUI may find it difficult to interact with CLI as he/she needs to be aware of the commands to perform a particular operation.

```sh
sudo apt install lxde
sudo apt install lxqt
sudo apt install xfce4

sudo aptitude| apt install tde-trinity
dnf install trinity-desktop-all       
```

## Shell vs Terminal

* Shell is a program that takes commands from the users and gives them to the operating system for processing. Shell is an example of a CLI(command line interface).
  - Bash is one of the most popular shell programs available on Linux servers. Other popular shell programs are zsh, ksh and tcsh.
* Terminal is a program that opens a window and lets you interact with the shell. Some popular examples of terminals are gnome-terminal, xterm, konsole etc.

## Command Line

* [REPL](https://repl.it/languages/bash) one of the popular online bash interpreters for running linux commands
* A command is a program that tells the operating system to perform specific work. Programs are stored as files in linux. Therefore, a command is also a file which is stored somewhere on the disk.
* Commands may also take additional arguments as input from the user. These arguments are called command line arguments.
  - -h|--help
  - man pages - short for manual pages

## 配置

* 系统默认的字符编码是 UTF-8。Windows 是 GBK 编码，不支持UTF8. 所以 Linux下 的中文文件名到 Windwos下就成了乱码
* [backup](https://github.com/backup/backup):Easy full stack backup operations on UNIX-like systems. http://backup.github.io/backup/v4/

```sh
## ~/.bashrc:
# set default editor to Vim
export EDITOR=vim

lshw -class disk -class storage -short

export CDPATH=".:/home/username"
```

```
\# Avoid a smurf attack
net.ipv4.icmp\_echo\_ignore\_broadcasts \= 1
 
# Turn on protection for bad icmp error messages
net.ipv4.icmp\_ignore\_bogus\_error\_responses \= 1
 
# Turn on syncookies for SYN flood attack protection
net.ipv4.tcp\_syncookies \= 1
 
# Turn on and log spoofed, source routed, and redirect packets
net.ipv4.conf.all.log\_martians \= 1
net.ipv4.conf.default.log\_martians \= 1
 
# No source routed packets here
net.ipv4.conf.all.accept\_source\_route \= 0
net.ipv4.conf.default.accept\_source\_route \= 0
 
# Turn on reverse path filtering
net.ipv4.conf.all.rp\_filter \= 1
net.ipv4.conf.default.rp\_filter \= 1
 
# Make sure no one can alter the routing tables
net.ipv4.conf.all.accept\_redirects \= 0
net.ipv4.conf.default.accept\_redirects \= 0
net.ipv4.conf.all.secure\_redirects \= 0
net.ipv4.conf.default.secure\_redirects \= 0
 
# Don't act as a router
net.ipv4.ip\_forward = 0
net.ipv4.conf.all.send\_redirects = 0
net.ipv4.conf.default.send\_redirects = 0
 
 
# Turn on execshild
kernel.exec-shield = 1
kernel.randomize\_va\_space = 1
 
# Tuen IPv6
net.ipv6.conf.default.router\_solicitations = 0
net.ipv6.conf.default.accept\_ra\_rtr\_pref = 0
net.ipv6.conf.default.accept\_ra\_pinfo = 0
net.ipv6.conf.default.accept\_ra\_defrtr = 0
net.ipv6.conf.default.autoconf = 0
net.ipv6.conf.default.dad\_transmits = 0
net.ipv6.conf.default.max\_addresses = 1
 
# Optimization for port usefor LBs
# Increase system file descriptor limit
fs.file-max = 65535
 
# Allow for more PIDs (to reduce rollover problems); may break some programs 32768
kernel.pid\_max = 65536
 
# Increase system IP port limits
net.ipv4.ip\_local\_port\_range = 2000 65000
 
# Increase TCP max buffer size setable using setsockopt()
net.ipv4.tcp\_rmem = 4096 87380 8388608
net.ipv4.tcp\_wmem = 4096 87380 8388608
 
# Increase Linux auto tuning TCP buffer limits
# min, default, and max number of bytes to use
# set max to at least 4MB, or higher if you use very high BDP paths
# Tcp Windows etc
net.core.rmem\_max = 8388608
net.core.wmem\_max = 8388608
net.core.netdev\_max\_backlog = 5000
net.ipv4.tcp\_window\_scaling = 1
```

## 硬件

```sh
lshw -short
lshw -C cpu | grep -i product # 查看 CPU 品牌和型号
lshw -short -C memory # 获取系统内存更多的信息，包括类型、容量、速度和电压
lshw -short -C memory | grep -i empty # 检查一下计算机是否有空闲的插槽可以插入额外的内存条
lshw -short -C disk # 显示每个磁盘设备的描述信息

# cpu
lscpu
lscpu | grep -i mhz # 查看 CPU 的速度（兆赫兹）
lscpu | grep -i bogo # 或其 BogoMips 额定功率

cat /proc/cpuinfo |grep "model name"|uniq|cut -f2 -d:
time echo "scale=500;4*a(1)"|bc -l -q # 计算时间越短越好

# memory
dmidecode -t memory | grep -i size # 列出每根内存条和其容量
dmidecode -t memory | grep -i max # 可以安装的最大内存

# 显卡内存
lspci | grep -i vga
lspci -v -s 00:02.0 #  加上视频设备号

lshw -C network # 网卡硬件详细信息
ifconfig -a
ip link show
netstat -i

## 硬件
dmidecode -q # 显示硬件系统部件 - (SMBIOS / DMI)
hdparm -i /dev/hda # 罗列一个磁盘的架构特性
hdparm -tT /dev/sda # 在磁盘上执行测试性读取操作
cat /proc/cpuinfo # 显示CPU info的信息
cat /proc/cpuinfo | grep name | cut -f2 -d: | uniq -c # cpu型号
at /proc/cpuinfo | grep physical | uniq -c # 物理cpu颗数
cat /proc/interrupts # 显示中断
cat /proc/meminfo # 内存使用
cat /proc/swaps # 显示哪些swap被使用
cat /proc/version # 显示内核的版本
cat /proc/net/dev # 显示网络适配器及统计
cat /proc/mounts # 显示已加载的文件系统
lscpu
lspci -tv # 罗列 PCI 设备
lsusb -tv # 显示 USB 设备

# Show info about disk sda
hdparm -i /dev/sda

# Perform a read speed test on disk sda
hdparm -tT /dev/sda

grep “model name” /proc/cpuinfo | cut -f2 -d: # 查看CPU

# Display processor related statistics
mpstat 1

# Display virtual memory statistics
vmstat 1

# Display I/O statistics
iostat 1

sudo apt install kinfocenter
```

## 启动

* 初始：BIOS->MBR->引导加载程序->内核
  - 计算机电源通电后
  - 开机自检(Power-On-Self-Test, POST):自动从主板 BIOS(Basic Input/Output System)读取其中所存储程序（直接连接在主板上的硬件(硬盘，网络接口，键盘，串口，并口)）进行开机自检，对硬件进行检测和初始化
  - 启动存储设备中读取起始 512 bytes 的磁盘中的第一个分区|MBR(Master Boot Record) 主引导记录，被读入到一个固定的内存区域并执行。告诉电脑从该设备的某一个分区(partition)来装载引导加载程序(boot loader)。boot 程序将自身复制到高位地址的内存从而为操作系统释放低位地址的内存。Boot loader储存有操作系统(OS)的相关信息，比如操作系统名称，操作系统内核 (内核)所在位置等。常用的boot loader有GRUB和LILO
  - boot 程序读取启动设备的根目录。boot 程序要理解文件系统和目录格式。然后 boot 程序被调入内核，把控制权移交给内核。直到这里，boot 完成了它的工作。系统内核开始运行
  - boot loader 会加载内核(kernel)。内核实际上是一个用来操作计算机的程序，它是计算机操作系统的内核，主要的任务是管理计算机的硬件资源，充当软件和硬件的接口。操作系统上的任何操作都要通过内核传达给硬件
  - 内核启动代码是使用汇编语言完成的，主要包括创建内核堆栈、识别 CPU 类型、计算内存、禁用中断、启动内存管理单元等，然后调用 C 语言的 main 函数执行操作系统部分
    + 会分配一个消息缓冲区来存放调试出现的问题，调试信息会写入缓冲区。如果调试出现错误，这些信息可以通过诊断程序调出来
    + 操作系统会进行自动配置，检测设备，加载配置文件，被检测设备如果做出响应，就会被添加到已链接的设备表中，如果没有相应，就归为未连接直接忽略
    + 仔细手工处理进程0，设置其堆栈，然后运行它，执行初始化、配置时钟、挂载文件系统。创建 init 进程(进程 1 ) 和 守护进程(进程 2)
* 内核：内核->init process
  - 内核启动后，会挂载root文件系统为其提供用户空间支持
  - 内核会首先预留自己运行所需内存空间
  - 通过驱动程序(driver)检测计算机硬件，操作系统就可以知道有哪些硬件可用
  - 内核会启动一个init进程,是Linux系统中的1号进程(Linux系统没有0号进程)
* init process
  - 会检测它的标志以确定它是否为单用户还是多用户服务
  - 单用户 single user mode：会调用 fork 函数创建一个 shell 进程，并且等待这个进程结束 初始脚本还没有开始执行，可以检测并修复计算机可能存在的错误
  - 多用户：调用 fork 函数创建一个运行系统初始化的 shell 脚本（即 /etc/rc）的进程，这个进程可以进行文件系统一致性检测、挂载文件系统、开启守护进程等
  - /etc/rc 这个进程会从 /etc/ttys 中读取数据，/etc/ttys 列出了所有的终端和属性。对于每一个启用的终端，这个进程调用 fork 函数创建一个自身的副本，进行内部处理并运行一个名为 getty 的程序，getty 程序会在终端上输入 login:
  - 等待用户输入用户名，在输入用户名后，getty 程序结束，登陆程序 /bin/login 开始运行。login 程序需要输入密码，并与保存在 /etc/passwd 中的密码进行对比，如果输入正确，login 程序以用户 shell 程序替换自身，等待第一个命令。如果不正确，login 程序要求输入另一个用户名。
  - 一系列的初始脚本(startup scripts)：常见的shell scripts，执行如下功能：设置计算机名称，时区，检测文件系统，挂载硬盘，清空临时文件，设置网络
  - 给出登录(login)对话框，或者是图形化的登录界面
* GNU GRUB GRand Unified Bootloader 一个支持多种操作系统的启动引导管理器
  - 在一台有多个操作系统的计算机中，通过GRUB在计算机启动时选择用户希望运行的操作系统
  - 可以引导Linux系统分区上的不同内核，也可用于向内核传递启动参数，如进入单用户模式
  - 同时支持EFI和BIOS方式启动
* 启动项
  - 启动目录： /etc/rc.d/rc[0~6].d
  - 命令行脚本文件：/etc/init.d/ 查看系统引导时启动的服务项
  - 本地文件：/etc/rc.local
  - 添加 /etc/init.d/nginx start

![系统启动过程](../_static/os_boot.png "Optional title")

```sh
# 启动盘制作
sudo dd bs=4M if=/home/hcf/dev/iso/ubuntu-16.04-desktop-amd64.iso of=/dev/sdb4

sudo dmidecode

# 界面切换
init 3
init 5
--run level 0 :关机
--run level 3 :纯文本模式
--run level 5 :含有图形接口模式
--run level 6 :重新启动

chkconfig --list sshd

## 修改时区
sudo tzselect
sudo cp /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime
# /etc/timezone 改为Asia/Shanghai

# 关机（必须用root用户）
shutdown -h now  ## 立刻关机
shutdown -h 10  ##  10分钟以后关机
shutdown -h 12:00:00  ##12点整的时候关机
shutdown -h # 关机后关闭电源
shutdown -r now  # 关机/重启 -h:关机 -r:重启
halt｜reboot｜poweroff

sudo update-grub
```

## 环境变量 ENV

* 每个进程都有其各自环境变量设置，且默认情况下，当一个进程被创建时，处理创建过程中明确指定的话，将继承其父进程的绝大部分环境设置。Shell 程序也作为一个进程运行在操作系统之上，而在 Shell 中运行的大部分命令都将以 Shell 的子进程的方式运行
* 定义用于进行命令和程序查找的目录,如果命令或者程序位置没有包括在PATH变量中，那么如果不使用绝对路径的话，shell是没法找到的
* 目录使用冒号分隔
* PATH变量修改只能持续到退出或重启系统
* 登入Linux系统启动一个bash shell时，默认情况下bash会在几个文件中查找命令。这些文件叫作启动文件或环境文件
* 启动 bash shell 方式
  - 登录时默认登录 shell
    + $HOME/.bashrc
    + /etc/profile:系统上默认 bash 主启动文件,系统上的每个用户登录时都会执行这个启动文件.按照下列顺序运行第一个被找到的文件，余下的则被忽略
      * $HOME/.bash_profile:会先去检查HOME目录中是不是还有一个叫.bashrc的启动文件。如果有 的话，会先执行启动文件里面的命令
      * $HOME/.bash_login
      * $HOME/.profile
  - 作为非登录shell的交互式shell,不会访问/etc/profile文件，只会检查用户HOME目录 中的 .bashrc 文件
  - 作为运行脚本的非交互shell
    + 如果父shell是登录shell，在/etc/profile、/etc/profile.d/*.sh和$HOME/.bashrc文件中设置并导出了变量，用于执行脚本的子shell就能够继承这些变量
    + 由父shell设置但并未导出的变量都是局部变量。子shell无法继承局部变量
* 永久：修改配置文件，变量永久生效； /etc/bashrc 存放的是 shell 变量 `echo "PATH=$PATH:/home/shiyanlou/mybin" >> .zshrc`
	* ~/.profile（不是/etc/profile） 只对当前用户永久生效
	* 添加一个永久生效的环境变量，需要打开 /etc/profile
* 临时：用 export 命令行声明，变量在关闭 shell 时失效`PATH=$PATH:/home/zhangwang/mybin`给 PATH 环境变量追加了一个路径，只是在当前 Shell 有效，退出终端就失效
* ${变量名#匹配字串}: 从头向后开始匹配，删除符合匹配字串的最短数据
* ${变量名##匹配字串}: 从头向后开始匹配，删除符合匹配字串的最长数据
* ${变量名%匹配字串}: 从尾向前开始匹配，删除符合匹配字串的最短数据
* `${变量名%%匹配字串}`: 从尾向前开始匹配，删除符合匹配字串的最长数据
* ${变量名/旧的字串/新的字串}:将符合旧字串的第一个字串替换为新的字串
* ${变量名//旧的字串/新的字串}: 将符合旧字串的全部字串替换为新的字串

```sh
# 使用 declare 命令创建一个变量名为 tmp 的变量
declare tmp
# 使用 = 号赋值运算符，将变量 tmp 赋值为 God
tmp=God
# 读取变量的值：使用 echo 命令和 $ 符号（$ 符号用于表示引用一个变量的值）
echo $tmp
# 显示当前 Shell 所有变量，包括其内建环境变量（与 Shell 外观等相关），用户自定义变量及导出的环境变量
set
# 显示与当前用户相关的环境变量，还可以让命令在指定环境中运行
env
# 显示从 Shell 中导出成环境变量的变量
export PATH=PATH:/usr/bin/:/bin/:/sbin/
# 删除变量temp
unset temp

# 环境变量立即生效
source ~/.zshrc
. ./.zshrc

PATH=$PATH:/home/christine/Scripts

# 修改默认编辑器
sudo update-alternatives --config editor
```

## 模块机制  loadable module

* UNIX 设备驱动程序是被静态加载到内核中的。因此，只要系统启动后，设备驱动程序都会被加载到内存中。随着个人电脑 Linux 的出现，这种静态链接完成后会使用一段时间的模式被打破。相对于小型机上的 I/O 设备，PC 上可用的 I/O 设备有了数量级的增长。绝大多数用户没有能力去添加一个新的应用程序、更新设备驱动、重新连接内核，然后进行安装。
* The Kernel modules are used to add support for new hardware (as device drivers), and/or filesystems, or for adding system calls
* Linux 为解决这个问题，引入可加载(loadable module) 机制
  - 在系统运行时添加到内核中的代码块。当一个模块被加载到内核时
    + 加载过程中，模块会被动态重新部署
    + 系统会检查程序程序所需资源是否可用。如果可用，则把这些资源标记为正在使用
    + 设置所需的中断向量,更新驱动转换表使其能够处理新的主设备类型
    + 最后再来运行设备驱动程序
  - 在完成上述工作后，驱动程序就会安装完成，其他现代 UNIX 系统也支持可加载机制
- usually stored under Modules are stored in `/usr/lib/modules/<kernel_release_directory>`
	-  \-`a/--author`, `-d/--description`, `-l/--license`, `-p/--parameters`

```sh
# gets the details of currently loaded Kernel modules from the file `/proc/modules`.
lsmod

modinfo modname
modinfo -F author|description|license|parm|depends modname
```

## 服务 Systemd

* a system and service manager for Linux operating systems
* Systemd units are the building blocks of systemd

```sh
# /lib/systemd/system/goweb.service
[Unit]
Description=goweb

[Service]
Type=simple
Restart=always # ensures that systemd will always try to restart the program if it stops
RestartSec=5s # wait time between restart attempts
ExecStart=/home/user/go/go-web/main #  the point of entry for this service

[Install]
WantedBy=multi-user.target

systemctl --version
whereis systemd|whereis systemctl

systemd-analyze blame #  分析启动时各个进程花费的时间
systemd-analyze critical-chain # 分析启动时的关键链
systemd-analyze critical-chain httpd.service # 分析某个服务（httpd）的关键链

systemctl list-unit-files --type=service | grep enabled # 展示开机启动时的进程项
systemctl list-units # 列出所有运行中单元
systemctl --failed # 列出所有失败单元

# Managing System Services
sudo systemctl is-active|stop|enable|disable|status|restart|start|reload|kill|is-enabled bluetooth.service
sudo systemctl mask|unmask bluetooth.service # 屏蔽（不能启动）或显示服务

systemctl list-unit-files --type=mount # 列出所有系统挂载点
systemctl start|stop|restart|reload|status|is-active|enable|disable|mask|unmask tmp.mount # 挂载、卸载、重新挂载、重载系统挂载点并检查系统中挂载点状态

systemctl list-unit-files --type=socket # 列出所有可用系统套接口
systemctl start|restart|stop|reload|status|is-active|enable|disable|mask|unmask cups.socket

## 禁用服务列表
accounts-daemon.service # AccountsService 的一部分，AccountsService 允许程序获得或操作用户账户信息
avahi-daemon.service # 用于零配置网络发现，使电脑超容易发现网络中打印机或其他的主机
brltty.service # 提供布莱叶盲文设备支持，例如布莱叶盲文显示器。
debug-shell.service # 开放了一个巨大的安全漏洞（该服务提供了一个无密码的 root shell ，用于帮助 调试 systemd 问题），除非你正在使用该服务，否则永远不要启动服务。
ModemManager.service # 该服务是一个被 dbus 激活的守护进程，用于提供移动
pppd-dns.service # 是一个计算机发展的遗物，如果你使用拨号接入互联网的话，保留它，否则你不需要它。
rtkit-daemon.service # 一个 实时内核调度器real-time kernel scheduler
whoopsie.service # 是 Ubuntu 错误报告服务。它用于收集 Ubuntu 系统崩溃报告，并发送报告到 https://daisy.ubuntu.com 。 可以放心地禁止其启动，或者永久的卸载它。
wpa_supplicant.service # 仅在你使用 Wi-Fi 连接时需要


systemctl show -p CPUShares httpd.service # 获取当前某个服务的CPU分配额
systemctl set-property httpd.service CPUShares=2000 # 将某个服务（httpd.service）的CPU分配份额限制为2000 CPUShares/
# vi /etc/systemd/system/httpd.service.d/90-CPUShares.conf
[Service]
CPUShares=2000

systemctl show httpd # 检查某个服务的所有配置细节
systemctl list-dependencies httpd.service # 获取某个服务（httpd）的依赖性列表
systemd-cgls # 按等级列出控制组
systemd-cgtop # 按CPU、内存、输入和输出列出控制组
systemctl get-default # 列出当前使用的运行等级
systemctl rescue # 启动系统救援模式
systemctl isolate runlevel5.target|graphical.target # 启动运行等级5，即图形模式
systemctl emergency # 进入紧急模式
systemctl isolate runlevel3.target|multiuser.target # 启动运行等级3，即多用户模式（命令行）
systemctl set-default runlevel3.target|runlevel5.target # 设置默认运行等级
systemctl reboot|halt|suspend|hibernate|hybrid-sleep # 重启、停止、挂起、休眠系统或使系统进入混合睡眠
```

## Capabilities

* special attributes in the Linux kernel that grant processes and binary executables specific privileges that are normally reserved for processes whose effective user ID is 0
* if a process or binary that has one or more capability is exploited, the potential damage is limited when compared to the same process running as root.
* Capabilities can be set on processes and executable files
* type
  - CAP_CHOWN: Make changes to the User ID and Group ID of files
  - CAP_DAC_OVERRIDE: Override DAC (Discretionary Access Control). For example, vto bypass read/write/execute permission checks.
  - CAP_KILL: Bypass permission checks for sending signals to processes.
  - CAP_SYS_NICE: Raise the niceness of processes
  - CAP_SYS_TIME: Set the system and real-time hardware clock
* assigned in sets
  - namely "permitted", "inheritable", "effective" and "ambient" for threads
  - "permitted", "inheritable" and "effective" for files
* file capabilities
  - getcap
  - setcap

```sh
man 7 capabilities

apt install libcap2-bin
yum install libcap
pacman -S libcap

getcap /usr/bin/ping
#  find out which capabilities are already set
getcap -r / 2>/dev/null

setcap "CAP_CHOWN+ep" testfile
#  remove all capabilities
setcap -r testfile
```

## [内核 Kernel](https://www.kernel.org/)

* Linux内核处于用户进程和硬件之间,操作系统的核心，独立于普通的应用程序，可以访问受保护的内存空间，也有访问底层硬件设备的所有权限
* 进程管理
  - 进程实际是某特定应用程序的一个运行实体
  - 调度程序:通过在短的时间间隔内轮流运行这些进程而实现“多任务”。这一短的时间间隔称为“时间片”，让进程轮流运行的方法称为“进程调度”
  - 进程调度控制进程对CPU的访问。当需要选择下一个进程运行时，由调度程序选择最值得运行的进程。可运行进程实际上是仅等待CPU资源的进程，如果某个进程在等待其它资源，则该进程是不可运行进程。Linux使用了比较简单的基于优先级的进程调度算法选择新的进程
  - 通过多任务机制，每个进程可认为只有自己独占计算机，从而简化程序的编写。每个进程有自己单独的地址空间，并且只能由这一进程访问，这样，操作系统避免了进程之间的互相干扰以及“坏”程序对系统可能造成的危害
  - 进程间的通讯机制来帮助完成这样的任务。Linux 中常见的进程间通讯机制有信号、管道、共享内存、信号量和套接字等
  - 内核通过 SCI 提供了一个应用程序编程接口（API）来创建一个新进程（fork、exec 或 Portable Operating System Interface [POSⅨ] 函数），停止进程（kill、exit），并在它们之间进行通信和同步（signal 或者 POSⅨ 机制）。
* 内存管理：允许多个进程安全地共享主内存区域，支持虚拟内存.括了管理可用内存的方式，以及物理和虚拟映射所使用的硬件机制
  - 将内存划分为容易处理的“内存页”（对于大部分体系结构来说都是 4KB）
  - 提供了对 4KB 缓冲区的抽象,使用 4KB 缓冲区为基数，然后从中分配结构，并跟踪内存页使用情况，比如哪些内存页是满的，哪些页面没有完全使用，哪些页面为空。这样就允许该模式根据系统需要来动态调整内存使用。
  - 交换:出现可用内存被消耗光的情况，页面可以移出内存并放入磁盘中。源代码可以在 ./linux/mm 中找到
  - Swap分区，即交换区，系统在物理内存不够时，与Swap进行交换。
    + 即当系统的物理内存不够用时，把硬盘中一部分空间释放出来，以供当前运行的程序使用。当那些程序要运行时，再从Swap分区中恢复保存的数据到内存中。
    + 那些被释放内存空间的程序一般是很长时间没有什么操作的程序。
    + Swap 空间一般应大于或等于物理内存的大小，同时最小不应小于64M，最大应该是物理内存的两倍
* 设备驱动程序:为每一种硬件控制器所编写的设备驱动程序模块。实际控制操作系统和硬件设备之间的交互.运行在高特权级的处理器环境中，从而可以直接对硬件进行操作,任何一个设备驱动程序的错误都可能导致操作系统的崩溃.
  - 提供一组操作系统可理解的抽象接口完成和操作系统之间的交互，而与硬件相关的具体操作细节由设备驱动程序完成。一般而言，设备驱动程序和设备的控制芯片有关，例如，如果计算机硬盘是 SCSI  硬盘，则需要使用 SCSI  驱动程序，而不是 IDE 驱动程序。
* 文件系统：将独立的文件系统组合成了一个层次化的树形结构，并且由一个单独的实体代表这一文件系统
  - 将新的文件系统通过一个称为“挂装”或“挂上”的操作将其挂装到某个目录上，从而让不同的文件系统结合成为一个整体
  - 类型
    + 普通文件：C语言元代码、SHELL脚本、二进制的可执行文件等。分为纯文本和二进制。
    + 目录文件：目录，存储文件的唯一地方。
    + 链接文件：指向同一个文件或目录的的文件。
    + 设备文件：与系统外设相关的，通常在/dev下面。分为块设备和字符设备。
    + 管道(FIFO)文件 :  提供进程建通信的一种方式
    + 套接字(socket) 文件： 该文件类型与网络通信有关
  - 虚拟文件系统(VirtualFileSystem,VFS):隐藏了各种不同硬件的具体细节，为所有设备提供统一的接口，支持多达数十种不同的文件系统
    + 逻辑文件系统指Linux所支持的文件系统，如ext2,fat等
    + 设备驱动程序为每一种硬件控制器所编写的设备驱动程序模块
  - 虚拟文件系统（VFS）是 Linux 内核中非常有用的一个方面，因为它为文件系统提供了一个通用的接口抽象。VFS 在 SCI 和内核所支持的文件系统之间提供了一个交换层。即VFS 在用户和文件系统之间提供了一个交换层。
    + 在 VFS 上面，是对诸如 open、close、read 和 write 之类的函数的一个通用 API 抽象。在 VFS 下面是文件系统抽象，它定义了上层函数的实现方式。它们是给定文件系统（超过 50 个）的插件。文件系统的源代码可以在 ./linux/fs 中找到。
  - 文件系统层之下是缓冲区缓存，它为文件系统层提供了一个通用函数集（与具体文件系统无关）。这个缓存层通过将数据保留一段时间（或者随即预先读取数据以便在需要是就可用）优化了对物理设备的访问
  - 缓冲区缓存之下是设备驱动程序，它实现了特定物理设备的接口
* 网络接口（NET）：提供对各种网络标准协议的存取和各种网络硬件的支持
  - 网络协议部分负责实现每一种可能的网络传输协议
  - 网络设备驱动程序负责与硬件设备通讯，每一种可能的硬件设备都有相应的设备驱动程序。
* 系统调用接口：SCI 层提供了某些机制执行从用户空间到内核的函数调用。依赖于体系结构。SCI 实际上是一个非常有用的函数调用多路复用和多路分解服务。在 ./linux/kernel 中可以找到 SCI 的实现，并在 ./linux/arch 中找到依赖于体系结构的部分
  - 每个系统调用都对应一个系统调用号，调用号用于指明具体哪个系统调用
  - 系统调用既为应用程序提供了请求接口，又保证了系统的安全和稳定。用户空间的程序不能直接访问内核代码，内核代码驻留在受保护的内存地址中，用户进程无法访问这块内存
  - 应用程序一般会使用用户空间实现的应用编程接口来间接调用系统调用，API可以通过一个或若干个系统调用来实现一个接口，而且能屏蔽不同操作系统的差异，为应用程序提供相同的接口
  - 操作系统为用户态的进程与硬件设备(如CPU、磁盘和打印机等)之间的交互提供了一组接口，这些接口使得程序更具有可移植性，因为不同的操作系统只要所提供的一组接口相同，那么在这些操作系统之上就可以正确地编译和执行相同的程序，这组接口就是所谓的“系统调用”
  - 引入系统调用原因
    + 系统调用在用户进程和硬件设备之间增加一层，屏蔽了硬件的复杂操作，从而让应用层的使用更加便捷。
    + 使得编程更加容易
    + 极大地提高了系统的安全性
    + 使得操作系统更具有可移植性
* 一些GNU程序库和工具:图形界面的X Window系统和相应的桌面环境，如KDE或GNOME，并包含数千种从办公套件，编译器，文本编辑器到科学工具的应用软件

* I/O 部分负责与设备进行交互以及执行网络和存储 I/O 操作的所有内核部分
  - 最高层是一个虚拟文件系统，也就是说不管文件是来自内存还是磁盘中，都是经过虚拟文件系统中的
  - 从底层看，所有的驱动都是字符驱动或者块设备驱动
  - 二者的主要区别就是是否允许随机访问。网络驱动设备并不是一种独立的驱动设备，它实际上是一种字符设备，不过网络设备的处理方式和字符设备不同。
* 内存部件，程序被装载进内存，由 CPU 执行，这里会涉及到虚拟内存的部件，页面的换入和换出是如何进行的，坏页面的替换和经常使用的页面会进行缓存。
* 进程模块负责进程的创建和终止、进程的调度、Linux 把进程和线程看作是可运行的实体，并使用统一的调度策略来进行调度

```sh
# 查看
free -h
# swap文件位置
swapon -s
# 新增
dd if=/dev/zero of=/swapmem bs=1G count=2
#　使用
mkswap -f swapmem
chmod 0600 swapmem
#　关闭
swapoff /swapfile
swapon /swapmem

# 开机启动 /etc/fstab
 UUID=fa207ef7-79a7-4092-8381-98c2a5143c74 /               ext4    errors=remount-ro 0       1
 10 /swapmem                                 none            swap    sw              0       0
 11 /dev/fd0        /media/floppy0  auto    rw,user,noauto,exec,utf8 0       0

uname -sr
```

## CPU

* 芯片制作
  - 提纯精度11个9的硅片（99.999999999%）
  - 生成晶圆
  - 使用光刻机加工晶圆
  - 使用刻蚀机沟槽
  - 完成P型半导体制作
  - 使用200号的粗砂纸抹掉原标志
  - 涂上新标志
* 占用CPU最高线程
  - top->shift+p 记下进程号
  - top -Hp 进程号:查看占用CPU最高的线程
  - printf 0x%x 线程号:得到其16进制线程号
  - jstack 进程号:得到java执行栈，然后grep16进制找到相应的信息
  - `ps -eo %cpu,pid |sort -n -k1 -r | head -n 1 |  awk '{print $2}' |xargs  top -b -n1 -Hp | grep COMMAND -A1 | tail -n 1 | awk '{print $1}' | xargs printf 0x%x`
* top
  - 如果load超过了cpu核数，则负载过高
  - 如果wa过高，可初步判断I/O有问题
  - sy,si,hi,st，任何一个超过5%，都有问题
  - 进程状态长时处于D、Z、T状态，提高注意度
  - cpu不均衡，判断亲和性和优先级问题
  - load代表的就是你目前系统进程的排队情况
    + 单核的cpu达到100%，load约1
    + 双核的cpu都达到100%，load约2
    + 四核的cpu都达到100%，load约为4
* vmstat
  - b 置于等待队列（等待资源、等待输入/输出）的内核线程数目。数字过大则cpu太忙。
  - cs 如果频繁的进行上下文切换，则考虑是否是线程数开的过多
  - si/so 显示了交换分区的现状，有时候会造成cpu问题，一并关注
* [sar](https://github.com/vlsi/ksar) 最为全面的系统性能分析工具之一
  - `yum install sysstat -y`
  - sar -u  默认
  - sar -P ALL 每颗cpu的使用状态信息
  - sar -q  cpu队列的长度，runq-sz>cpu count就表明有瓶颈了
  - sar -w  每秒上下文交换
* mpstat|pidstat|dstat
* 关注要素：
  - 利用率  一般是瞬时值，属于采样范围，用来判断有没有峰值。比如cpu utilization
  - 饱和度  一般指资源已完全使用，新请求在特定queue里排队。比如cpu load过高
  - 错误信息 硬件或者驱动错误，比如dmesg命令显示的OOM
  - 联想信息 对引起的原因进行猜测，并用更多的工具验证猜想。比如系统响应慢猜测大量用到了swap
* 原因
  - 信息收集 问题起始时间，上下文
  - 改动集合 问题发生前所有变更列表
  - 问题抽象 将描述抽象成具体的资源问题
  - 问题排查 将信息整理完毕，就可以进行真正的荒野之旅了
* /proc目录是一个虚拟目录，存储的是当前内核的一系列特殊文件，不仅能查看一些状态，甚至能修改一些值来改变系统的行为
  - top的load （使用uptime命令得到同样的结果）。读取的就是 /proc/loadavg 文件
  - 每核cpu的信息，读取 /proc/stat文件
* CPU过高
  - GC引起的CPU过高
  - st%占比过高:st过高一般是物理CPU资源不足所致，也就是只发生在虚拟机上
  - 网卡
    + 解决方式1：使用CPU亲和性功能，kafka略过网卡所使用的CPU
    + 解决方式2: 更换网卡
    + 通常修改的方式还是有些复杂了，比如，修改 /proc/irq/{seq}/smp_affinity,可以直接安装irqbalance，然后执行就可以了。`yum install irqbalance -y ` `service irqbalance start`
  - cpu使用率低，但负载高:cpu id%高，也就是空闲，比如90%。但 load average非常高.load average高，说明其任务已经排队，许多任务正在等待。出现此种情况，可能存在大量不可中断的进程

```sh
cat /proc/cpuinfo
lscpu
sudo apt install cpuid
sudo dmidecode --type processor

sudo lshw
```

## [磁盘](https://wiki.archlinux.org/title/Partitioning)

+ IDE接口硬盘 /dev/hda、/dev/hdb …
+ SCSI |SATA接口的硬盘 /dev/sda、/dev/sdb … …
* 传统的 BIOS (Basic Input/Output System) 和 UEFI (Unified Extensible Firmware Interface) 可以看做是电脑的固件，都是在电脑启动后初始化所有连接的硬件设备，之后从硬盘中运行引导程序。
	* Legacy BIOS会执行MBR区域的程序。
	* UEFI可以在GPT上寻找[ESP](https://en.wikipedia.org/wiki/EFI_system_partition) (EFI system partition)来运行其中的程序。
* 分区：磁盘上存储分区信息方式，包含分区从哪里开始的信息The partitioning scheme is stored in a [partition table](https://wiki.archlinux.org/title/Partitioning#Partition_table) such as Master Boot Record (MBR) or GUID Partition Table (GPT)
	* MBR分区方式最多只允许4个主分区，其中可以有一个是逻辑分区
		* 如果X的值1到4,表示硬盘的主分区（包含扩展分区）
		* 逻辑分区从从5开始的，比如/dev/hda5肯定是逻辑分区
	* GPT则不限制分区数量，而且分区都是主分区
	* GPT兼容MBR的，GPT分区可以通过MBR引导启动或者往MBR区域写入引导程序。所以在安装时可以不管是GPT分的区还是MBR分区都直接以传统方式安装GRUB。
	* 如果grub-install发现是GPT分区那么会自动把GRUB安装到boot分区，并且还可以在MBR分区写入引导，引导执行boot分区的grub程序。
	* 包含Windows的双系统下不能同时使用GPT和MBR，这是Windows的强制限制，使用只能使用GPT+UEFI启动或者MBR+BIOS启动。
		* 所以如果先安装了Windows，并且之后要安装其他系统的话就必须要注意在分区时不能够改变这分区方式，并且如果是GPT的话，不能改变ESP分区。这是在存在Windows时安装其他系统的前提条件，但是如果不知道系统的安装程序做了什么的话可以也会无法引导。可以在系统安装好之后再在Windows的引导程序中加入其他系统的选项，也可以在GRUB中加入启动Windows的选项。如果是GPT分区的话通常还可以在boot界面选择哪个系统启动。
* MBR（Master Boot Record）存在于驱动器开始部分的一个特殊的启动扇区,硬盘最开始的512字节的区域
	+ bootstrap code 已安装操作系统的启动加载器
		+ 主引导程序（偏移地址0000H--0088H ）负责从活动分区中装载，并运行系统引导程序
		+ The first 440 bytes of MBR are the **bootstrap code area**. On BIOS systems it usually contains the first stage of the boot loader. The bootstrap code can be backed up, restored from backup or erased using dd
		+  出错信息数据区：偏移地址0089H--00E1H 为出错信息，00E2H--01BDH 全为0 字节
	+ partition table:In the MBR partition table (also known as DOS or MS-DOS partition table)
		* 分区表（DPT,Disk Partition Table ）含4 个分区项，偏移地址01BEH--01FDH, 每个分区表项长16 个字节，共64 字节为 分区项1 、分区项2 、分区项3 、分区项4
		* 结束标志字，偏移地址01FE--01FF 的2 个字节值为结束标志 55AA
		+ 主分区和扩展分区数目之和不能大于四个,标识使用/dev/hd[a-z]X或者/dev/sd[a-z]X来标识，[a-z]代表硬盘号，X代表硬盘内分区号
		-   Primary
			-   can be bootable and are limited to four partitions per disk or RAID volume. If the MBR partition table requires more than four partitions, then one of the primary partitions needs to be replaced by an **extended** partition containing **logical** partitions within it.
			-   可以马上被挂载使用但不能再分区
			-   区号为1-4
		-   Extended
			-   can be thought of as containers for logical partitions. A hard disk can contain no more than one extended partition. The extended partition is also counted as a primary partition so if the disk has an extended partition, only three additional primary partitions are possible (i.e. three primary partitions and one extended partition). The number of logical partitions residing in an extended partition is unlimited. A system that dual boots with Windows will require for Windows to reside in a primary partition.
			-   必须进行二次分区后才能挂载
			-   是逻辑分区的“容器”，实际上只有主分区和逻辑分区进行数据存储
			-   Logical
				-   逻辑分区号从5开始累加的数字
		-   The customary numbering scheme 
			- primary partitions _sda1_ through _sda3_
			- an extended partition _sda4_. 
				- The logical partitions on _sda4_ are numbered _sda5_, _sda6_, etc.
  * GUID Partition Table(GPT) is a partitioning scheme that is part of the Unified Extensible Firmware Interface specification UEFI
	  *  it uses globally unique identifiers (GUIDs), or UUIDs in the Linux world, to define partitions and partition types. It is designed to succeed the Master Boot Record partitioning scheme method.没有主分区和逻辑分区之分，每个硬盘最多可以有128个分区
	+ 4个区域
		+ At the start of a GUID Partition Table disk there is a protective Master Boot Record (PMBR) to protect against GPT-unaware software. This protective MBR just like an ordinary MBR has a bootstrap code area which can be used for BIOS/GPT booting with boot loaders that support it.
		+ 分区表
		+ GPT分区
		+ 备份区域
* `etc/fstab`: `UUID=b543f8f7-579c-45b5-96d6-31de6fa1a55e /home/lgd/disk1 ext4 defaults 1 2`
    + 分区设备文件名或UUID
    + 挂载点
    + 文件系统名称
    + 挂载参数，挂载权限
    + 指定分区是否被dump备份，0代表不备份，1代表每天备份，2代表不定期备份。
    + 指定分区是否被fsck检测，0代表不检测，其他数字代表检测的优先级，比如1的优先级比2高。根目录所在的分区的优先级为1，其他分区的优先级为大于或等于2
* df (disk free)：列出文件系统的整体磁盘使用量
  - -a：列出所有的文件系统，包括系统特有的/proc等文件系统
  - -k：以KB的容量显示各文件系统
  - -m：以MB的容量显示各文件系统
  - -h：以人们较易阅读的GB,MB,KB等格式自行显示
  - -H：以M=1000K替代M=1024K的进位方式
  - -T：连同该分区的文件系统名称（例如ext3）也列出
  - -i：不用硬盘容量，而以inode的数量来显示
* du (disk usage)：显示每个文件和目录的磁盘使用空间（评估目录所占容量）,可以递归地运行，会遍历每个子目录并且返回每个文件的单个大小。`du -sh *`
  - -a : 列出所有的文件与目录容量，因为默认仅统计目录下面的文件量而已
  - -b : 显示目录中文件的大小，以字节byte为单位
  - -h : 以人们较易读的容量格式（G/M）显示；
  - -s : 列出总量，而不列出每个个别的目录占用了容量；
  - -S : 不包括子目录下的总计，与-s有点差别；
  - -k : 以KB列出容量显示
  - -m : 以MB列出容量显示
  - `sudo du -h / | sort -n -r | head -n 5`
  - gdu:du 命令的 Go 语言版
* [duf](https://github.com/muesli/duf):Disk Usage/Free Utility
* rm:删除文件之后，空间就被释放了吗
  - 只有当一个文件的引用计数为0（包括硬链接数）的时候，才可能调用unlink删除，只要它不是0，那么就不会被删除
  - 删除：文件名到 inode 的链接删除，只要不被重新写入新的数据，磁盘上的block数据块不会被删除
  - 如何释放： `lsof |grep deleted` 被标记为deleted的文件
* 磁盘阵列（Redundant Arrays of independent Disks,RAID）,廉价冗余（独立）磁盘阵列。RAID是一种把多块独立的物理硬盘按不同的方式组合起来形成一个硬盘组（逻辑硬盘），提供比单个硬盘更高的存储性能和数据备份技术。RAID技术，可以实现把多个磁盘组合在一起作为一个逻辑卷提供磁盘跨越功能；可以把数据分成多个数据块（Block）并行写入/读出多个磁盘以提高访问磁盘的速度；可以通过镜像或校验操作提供容错能力。具体的功能以不同的RAID组合实现。在用户看来，RAID组成的磁盘组就像是一个硬盘，可以对它进行分区、格式化等操作。RAID的存储速度比单个硬盘高很多，并且可以提供自动数据备份，提供良好的容错能力。RAID级别，不同的RAID组合方式分为不同的RAID级别：
  - RAID 0：称为Stripping条带存储技术，所有磁盘完全地并行读，并行写，是组建磁盘阵列最简单的一种形式，只需要2块以上的硬盘即可，成本低，可以提供整个磁盘的性能和吞吐量，但RAID 0没有提供数据冗余和错误修复功能，因此单块硬盘的损坏会导致所有的数据丢失。（RAID 0只是单纯地提高磁盘容量和性能，没有为数据提供可靠性保证，适用于对数据安全性要求不高的环境）
  - RAID 1：镜像存储，通过把两块磁盘中的一块磁盘的数据镜像到另一块磁盘上， 实现数据冗余，在两块磁盘上产生互为备份的数据，其容量仅等于一块磁盘的容量。当数据在写入一块磁盘时，会在另一块闲置的磁盘上生产镜像，在不影响性能情况下最大限度的保证系统的可靠性和可修复性；当原始数据繁忙时，可直接从镜像拷贝中读取数据（从两块硬盘中较快的一块中读出），提高读取性能。相反的，RAID 1的写入速度较缓慢。RAID 1一般支持“热交换”，即阵列中硬盘的移除或替换可以在系统运行状态下进行，无须中断退出系统。RAID 1是磁盘阵列中硬盘单位成本最高的，但它提供了很高的数据安全性、可靠性和可用性，当一块硬盘失效时，系统可以自动切换到镜像磁盘上读写，而不需要重组失效的数据
  - RAID 0+1：也被称为RAID 10，实际是将RAID 0和RAID 1结合的形式，在连续地以位或字节为单位分割数据并且并行读/写多个磁盘的同时，为每一块磁盘做镜像进行冗余。通过RAID 0+1的组合形式，数据除分布在多个盘上外，每个盘都有其物理镜像盘，提供冗余能力，允许一个以下磁盘故障，而不影响数据可用性，并且有快速读/写能力。RAID 0+1至少需要4个硬盘在磁盘镜像中建立带区集。RAID 0+1技术在保证数据高可靠性的同时，也保证了数据读/写的高效性
  - RAID 5：是一种存储性能、数据安全和存储成本兼顾的存储解决方案。RAID 5可以理解为是RAID 0和RAID 1的折衷方案，RAID 5至少需要三块硬盘。RAID 5可以为系统提供数据安全保障，但保障程度要比镜像低而磁盘空间利用率要比镜像高。RAID 5具有和RAID 0相近似的数据读取速度，只是多了一个奇偶校验信息，写入数据的速度比对单个磁盘进行写入操作稍慢。同时由于多个数据对应一个奇偶校验信息，RAID 5的磁盘空间利用率要比RAID 1高，存储成本相对较低，是目前运用较多的一种解决方案
* 工具
  - gparted
  - pydf:Colourised Filesystem Disk Space Usage
  - i-nex 收集硬件信息，并且类似于 Windows 下流行的 CPU-Z 的显示
  - HardInfo 显示硬件具体信息，甚至包括一组八个的流行的性能基准程序，可以用它们评估系统性能。
  - KInfoCenter 和 Lshw 也能够显示硬件的详细信息，并且可以从许多软件仓库中获取。

```sh
dmidecode -t bios # 显示了 UEFI 或 BIOS 的日期和版

# 磁盘文件系统和设
gdisk -l

# shows the volumes 列出所有磁盘及其分区和大小
lsblk 
inxi -Fxz # 能够列出包括 CPU、图形、音频、网络、驱动、分区、传感器等详细信息 -F 参数意味着你将得到完整的输出，x 增加细节信息，z 参数隐藏像 MAC 和 IP 等私人身份信息
hwinfo --short

sudo file -s /dev/nvme?n*
sudo growpart /dev/nvme0n1 1
sudo resize2fs /dev/xvda1
hdparm -i /dev/sda # 获取任何指定的 SATA 磁盘详细信息，例如其型号、序列号以及支持的模式和扇区数量等

fdisk -l # 获取更多有关扇区数量、大小、文件系统 ID 和 类型以及分区开始和结束扇区
blkid # 列出了每个分区的唯一标识符（UUID）及其文件系统类型

# 分区
sudo fdisk /dev/sdb # 硬盘进行分区

m # 查看所有命令的菜单及帮助信息
d # 删除不想要的分区
n # 添加一个新的分区
p # 设置一个主分区（e为扩展分区），再接下来设置起止扇区号（一个扇区512B，根据个人需要设置分区大小）
t # 更改分区类型
L # 可查看所有分区类型的编号，根据个人需求，输入对应的分区类型编号
w # 保存退出

lsusb|lspci # 列出已挂载的文件系统和它们的挂载点，以及已用的空间和可用的空间
# 统计数据块使用情况
df -m # 列出已挂载的文件系统和它们的挂载点，以及已用的空间和可用的空间
df -Th
df -aT # 查看分区的文件系统
df -h  /etc # Human-readable 显示目前所有文件系统的总容量，使用量，剩余容量
df -k
df -h /
df -h .

dpkg-query -Wf '${Installed-Size}\t${Package}\n' | sort -n

sync; echo 3 > /proc/sys/vm/drop_caches # 清空缓存
hdparm -t /dev/sda # 测试读性能 选择测试磁盘，建议做 2-3 组取平均值
time dd if=/dev/zero of=/tmp/speed bs=1M count=2K conv=fsync;rm /tmp/speed # 测试写入性能 根据业务选择不同的 BlockSize 大小按需多次测试取平均值

# cannot create temp file for here-document: No space left on device  mounting a tmpfs to /tmp

# 查看目录的容量
# -h 同--human-readable 以K，M，G为单位，提高信息的可读性
# -a 同--all 显示目录中所有文件的大小
sudo du -h --max-depth=1 / | grep '[0-9]G\>'
du -sh /* # 递归地运行，遍历每个子目录并且返回每个文件的单个大小
du -h --max-depth=1 /home  # 文件大小相加
du -sh /*
du -h --max-depth=1 /var/log/*
du -sm * | sort -n # /统计当前目录大小 并安大小 排序
du -sk * | sort -n
du -sk * | grep guojf 看一个人的大小
du -b /home # 查看目前/HOME目录的容量(k)及子目录的容量(k)
du -hd 1 .
du -hd 1 . | sort -n
du -kd 1 . | sort -n
du -hd 1 . | sort -hr

sudo growpart /dev/xvda 1 # 对磁盘 分区4扩容
growpart /dev/sda 1 # Resize partition 1 on /dev/sda must supply disk and partition-number
sudo mkfs.ext4 /dev/sdb1 # 格式化成ext4文件系统 （输入sudo mkfs，按两次tab键，会出现多种文件系统，根据需求选择）


# Display the last 100 syslog messages  (Use /var/log/syslog for Debian based systems.)
tail 100 /var/log/messages

# bash: cannot create temp file for here-document: No space left on device
# 该磁盘空间已满，可以进行扩容，或者将该磁盘的部分目录迁移到别的磁盘

dd if=/dev/urandom of=/boot/test.txt bs=50M count=1 # 生成文件,挂载

# 文件置空
cat /dev/null > calatina.out

sync # 将所有未写的系统缓冲区写到磁盘中
```

## 中断

* 中断是向处理器发送的输入信号，能够表示某个时间需要操作系统立刻处理，如果操作系统接收了中断，那么处理器会暂停当前的任务、存储上下文状态、并执行中断处理器处理发生的事件，在中断处理器结束后，当前处理器会恢复上下文继续完成之前的工作
* 硬件中断是由处理器外部的设备触发的电子信号,通知给CPU，中断本质是一个特殊的电信号，处理器接收到中断后会马上告知内核
  - 为克服对I/O接口采用程序查询控制服务方式所带来的处理器低效率而产生的，它的主要优点是只有在I/O接口需要服务时才能得到处理器的响应，而不需要处理器不断地进行查询；因此，最初的中断全部是对外部设备而言的，称为外部中断(或硬件中断)；
  - 分类
    + 可屏蔽中断(INTR)：所有I/O设备产生的中断请求(IRQ)均引起
    + 非屏蔽中断(NMI)：紧急事件(如硬件故障)引起的故障则产生
  - 异常也叫做内部中断，它是为解决机器运行时所出现的某些随机事件及编程的方便而出现的；又分为故障(fault)和陷阱(trap)，它们的共同特点是既不使用中断控制器，又不能被屏蔽(异常其实是CPU发出的终端信号)。
  - 为使处理器可以容易地识别每种中断源，将256种向量中断从0到255进行编号，即赋以一个中断类型码n，把这个8位的无符号整数叫做向量，即中断向量。256个中断向量的分配如下
    + 编号为0~31的向量对应于异常和非屏蔽中断；
    + 编号为32~47的向量(即由I/O设备引起的中断)分配给可屏蔽中断；
    + 剩余的、编号为48~255的向量用来标识软中断；Linux只用其中的一个(即128或0x80向量)来实现系统调用
  - 中断描述符表：在实地址模式下，CPU将内存中从0开始的1KB空间作为一个中断向量表，表中每个表项占4个字节；
    + 在保护模式，由4个字节的表项构成的中断向量表满足不了要求；因此在保护模式下，中断向量表中的表项由8个字节组成，中断向量表也改称为中断描述符表(IDT)；IDT中的每个表项叫做一个门描述符(gate descriptor)。门描述符中类型码占3位，表示门描述符的类型，主要分为以下几类：
      * 中断门(interrupt gate)：其类型码为110，包含了一个中断或异常处理程序所在段的选择符和段内偏移量；
      * 陷阱门(trap gate)：其类型码为111；
      * 系统门(system gate)：是Linux内核特别设置的，用来让用户态的进程访问陷阱门
  - 处理程序：在响应每个特定的中断时都会执行指定的一个函数，该函数为中断处理程序，每个硬件有一个相应的中断处理程序，他属于设备驱动的一部分
    + 中断处理程序被内核调用来响应中断，它们运行在中断上下文中，在该上下文中执行的代码不能够阻塞。
    + 上半部用于执行有严格时限的工作，比如应答硬件。而下半部用于处理能够延后处理的工作。上半部和下半部其实就是一种异步化处理思想，这样既能够保证响应速度，又能够完成大工作量的处理。
      * 网卡来说，它的缓存大小是固定的，一旦网卡接收到数据后内核必须马上将它们拷贝到内存中，不然将可能导致网卡的缓存爆满而数据包被丢失。
      * 对于网卡的中断信号处理应该快速将网卡数据包拷贝到内存中，这就是上半部的工作，快速执行完后马上结束中断处理，将处理器交还给中断前的程序。
      * 耗时的数据包处理操作则放到下半部中，这部分可以稍后一点再处理，没有很强的时效性。
* 软件中断是由处理器在执行特定指令时触发的，某些特殊的指令也可以故意触发软件中断
  - 应用程序通过调用 C 语言库中的函数发起系统调用；
  - C 语言函数通过栈收到调用方传入的参数并将系统调用需要的参数拷贝到寄存器；
  - Linux 中的每一个系统调用都有特定的序号，函数会将系统调用的编号拷贝到 eax 寄存器；
  - 函数执行 INT 0x80 指令，处理器会从用户态切换到内核态并执行预先定义好的处理器；
  - 执行中断处理器 entry_INT80_32 处理系统调用；
    + 执行 SAVE_ALL 将寄存器的值存储到内核栈上并调用 do_int80_syscall_32；
    + 调用 do_syscall_32_irqs_on 检查系统调用的序号是否合法；
    + 在系统调用表 ia32_sys_call_table 中查找对应的系统调用实现并传入寄存器的值；
    + 系统调用在执行期间会检查参数的合法性、在用户态内存和内核态内存之间传输数据，系统调用的结果会被存储到 eax 寄存器中；
    + 从内核栈中恢复寄存器的值并将返回值放到栈上；
    + 系统调用会返回 C 函数，包装函数会将结果返回给应用程序；
  - 如果系统调用服务在执行过程中出现了错误，C 语言函数会将错误存储在全局变量 errno 中并根据系统调用的结果返回一个用整数 int 表示的状态
* 中断上下文是指内核在执行一个中断处理程序时所处的上下文，在该上下文中不能睡眠，也不能调用某些函数。中断处理程序时打断了其它正在执行的代码，所以它必须要快速简洁地执行完毕，中断处理程序有自己的栈

## [系统调用](https://mp.weixin.qq.com/s/ftCz3VuJ8tqHyld3unNmuA)

* 操作系统可以分为两种模式
  - 内核态：操作系统内核使用的模式
  - 用户态：用户应用程序所使用的模式
* 上下文切换 指的就是内核态模式和用户态模式的频繁切换
* 进程映像:执行程序时所需要的可执行文件,包括
  - 代码段（codesegment/textsegment）｜文本段：用来存放指令，运行代码的一块内存空间，此空间大小在代码运行前就已经确定，内存空间一般属于只读，某些架构的代码也允许可写。在代码段中，也有可能包含一些只读的常数变量，例如字符串常量等。
  - 数据段（datasegment）：可读可写，存储初始化的全局变量和初始化的 static 变量，数据段中数据的生存期是随程序持续性（随进程持续性） 随进程持续性：进程创建就存在，进程死亡就消失
  - bss 段（bsssegment）： 可读可写，存储未初始化的全局变量和未初始化的 static 变量，bss 段中的数据一般默认为 0
  - Data 段：是可读写的，因为变量的值可以在运行时更改。此段的大小也固定
  - 栈（stack）：可读可写，存储的是函数或代码中的局部变量(非 static 变量)栈的生存期随代码块持续性，代码块运行就给你分配空间，代码块结束，就自动回收空间
  - 堆（heap）：可读可写，存储的是程序运行期间动态分配的 malloc/realloc 的空间，堆的生存期随进程持续性，从 malloc/realloc 到 free 一直存在
* 系统调用:引起内核态和用户态切换的一种方式，系统调用通常在后台静默运行，表示计算机程序向其操作系统内核请求服务
  - fork 调用用于创建一个与父进程相同的子进程，创建完进程后的子进程拥有和父进程一样的程序计数器、相同的 CPU 寄存器、相同的打开文件
  - exec 系统调用用于执行驻留在活动进程中的文件，调用 exec 后，新的可执行文件会替换先前的可执行文件并获得执行.
    + 新的执行程序被加载到相同的执行空间中，因此进程的 PID不会修改，因为「没有创建新进程，只是替换旧进程」。
    + 但是进程的数据、代码、堆栈都已经被修改。如果当前要被替换的进程包含多个线程，那么所有的线程将被终止，新的进程映像被加载执行
    + 原理
      * 当前进程映像被替换为新的进程映像
      * 新的进程映像是你做为 exec 传递的灿睡
      * 结束当前正在运行的进程
      * 新的进程映像有 PID，相同的环境和一些文件描述符(因为未替换进程，只是替换了进程映像)
      * CPU 状态和虚拟内存受到影响，当前进程映像的虚拟内存映射被新进程映像的虚拟内存代替。
  - waitpid 等待子进程结束或终止
  - exit：算机进程的终止，表示进程能够正常结束，其他值表示进程以非正常的行为结束
* 计算机程序在执行的过程中向操作系统内核申请服务的方法，这可能包含硬件相关的服务、新进程的创建和执行以及进程调度。系统调用为用户程序提供了操作系统的接口
* 分类
  - 设备管理。完成设备的请求或释放，以及设备启动等功能。
  - 文件管理。完成文件的读、写、创建及删除等功能。
  - 进程控制。完成进程的创建、撤销、阻塞及唤醒等功能。
  - 进程通信。完成进程之间的消息传递或信号传递等功能。
  - 内存管理。完成内存的分配、回收以及获取作业占用内存区大小及地址等功能。
* vDSO 虚拟动态链接对象（Virtual Dynamically Shared Object、vDSO）：可以减少系统调用的消耗的时间
  - Linux 内核对用户空间暴露内核空间部分函数的一种机制[^16]，简单来说，我们将 Linux 内核中不涉及安全的系统调用直接映射到用户空间，这样用户空间中的应用程序在调用这些函数时就不需要切换到内核态以减少性能上的损失
  - 用了标准的链接和加载技术，作为一个动态链接库，它由 Linux 内核提供并映射到每一个正在执行的进程中
  - ` ldd /bin/cat`  `cat /proc/self/maps`
  - 因为 vDSO 是由操作系统直接提供的，所以它并不存在对应的文件，在程序执行的过程中我们也能在虚拟内存中看到它加载的位置。vDSO 可以为用户程序提供虚拟的系统调用，它会使用内核提供的数据在用户态模拟系统调用
* 方法：
  - 使用软件中断（Software interrupt）触发系统调用；
    + 基于软件中断的系统调用是一个比较复杂的流程，应用程序通过软件中断陷入内核态并在内核态查询并执行系统调用表注册的函数，整个过程不仅需要存储寄存器中的数据、从用户态切换至内核态，还需要完成验证参数的合法性，与函数调用的过程相比确实会带来很多的额外开销
    + 使用 INT 0x80 来触发系统调用早就是过去时了，大多数的程序都会尽量避免这种触发方式。然而这一规则也不是通用的，因为 Go 语言团队在做基准测试时发现 INT 0x80 触发系统调用在部分操作系统上与其他方式有着几乎相同的性能[，所以在 Android/386 和 Linux/386 等架构上仍然会使用中断来执行系统调用
  - 使用 SYSCALL / SYSENTER 等汇编指令触发系统调用；
    + 在较新的版本使用了新的汇编指令 SYSENTER / SYSCALL，它们是 Intel 和 AMD 上用于实现快速系统调用的指令
    + 低延迟的系统调用和返回指令，它们会认为操作系统实现了线性内存模型（Linear-memory Model），极大地简化了操作系统系统调用和返回的过程，其中包括不必要的检查、预加载参数等，与软件中断驱动的系统调用相比，使用快速系统调用指令可以减少 25% 的时钟周期
    + 线性内存模型是一种内存寻址的常见范式，在这种模式中，线性内存与应用程序存储在单一连续的空间地址中，CPU 可以不借助内存碎片或者分页技术使用地址直接访问可用的内存地址。
    + 在 64 位的操作系统上，我们会使用 SYSCALL / SYSRET 进入和退出系统调用，该指令会在操作系统最高权限等级中执行。内核在初始化时会调用  syscall_init 函数将 entry_SYSCALL_64 存入 MSR 寄存器（Model Specific Register、MSR）中，MSR 寄存器是 x86 指令集中用于调试、追踪以及性能监控的控制寄存器
    + 当内核收到了用户程序触发的系统调用时，它会在 MSR 寄存器中读取需要执行的函数并按照 x86-64 的调用惯例在寄存器中读取系统调用的编号以及参数，你能在 entry_SYSCALL_64 函数的注释中找到相关的调用惯例
    + 汇编函数 entry_SYSCALL_64 会在执行的过程中调用 do_syscall_64，它的实现与上一节中的 do_int80_syscall_32 有些相似，它们都会在系统调用表中查找函数并传入寄存器中的参数
    + 与 INT 0x80 通过触发软件中断实现系统调用不同，SYSENTER 和 SYSCALL 是专门为系统调用设计的汇编指令，它们不需要在中断描述表（Interrupt Descriptor Table、IDT）中查找系统调用对应的执行过程，也不需要保存堆栈和返回地址等信息，所以能够减少所需要的额外开销
  - 使用虚拟动态共享对象（virtual dynamic shared object、vDSO）执行系统调用；
* io wait

## 内核同步

* 临界区(critical regions)就是访问和操作共享数据的代码段，多个内核任务并发访问同一个资源通常是不安全的
* 如果两个内核任务可能处于同一个临界区，就是一种错误现象；如果确实发生了这种情况，就称它为竞争状态
* 避免并发和防止竞争状态称为同步(synchronization)
* 死锁
  - 包括自死锁和ABBA死锁，
  - 产生死锁有四个原因：互斥使用、不可抢占、请求和保持，以及循环等待；
  - 避免死锁的方法有：破坏“不可剥夺”条件、破坏“请求和保持”条件、破坏“循环等待”条件。
* 并发执行：“伪并发”和“真并发”
  - 中断：它可能随时打断当前正在执行的代码；
  - 内核抢占：内核中的任务可能会被另一个任务抢占；
  - 睡眠及其与用户空间的同步：在内核执行的进程可能会睡眠，这就会唤醒调度程序，调度一个新的用户进程执行；
  - 对称多处理：两个或多个处理器可以同时执行代码。
* 信号量：是一种睡眠锁，是1968年由Dijkstra提出的，如果一个任务试图获得一个已被持有的信号量，信号量会将其推入等待队列，然后让其睡眠；当持有信号量的进程将信号量释放后，在等待队列中的一个任务将被唤醒，从而可以获得这个信号量；
  - 信号量支持两个原子操作P()和V()，前者叫做测试操作，后者叫做增加操作；后来的系统把这两种操作分别叫做down()和up()；
  - down()操作通过对信号量计数减1来请求获得一个信号量；up()操作用来释放信号量，该操作也被称作“提升”(upping)信号量，因为它会增加信号量的计数值。

## 运行时

* 程序在执行过程中通常有用户态和内核态两种状态
* CPU对处于内核态根据上下文环境进一步细分，因此有了下面三种状态：
  - 内核态，运行于进程上下文，内核代表进程运行于内核空间
  - 内核态，运行于中断上下文，内核代表硬件运行于内核空间
  - 用户态，运行于用户空间
* 操作系统为每一个进程，分配了这么一个上下文，用来存放：代码、数据、用户堆栈、共享存储区、寄存器、进程控制块等
* 上下文切换
  - 让步式上下文切换:指执行线程主动释放CPU，与锁竞争严重程度成正比，可通过减少锁竞争来避免
  - 抢占式上下文切换:指线程因分配的时间片用尽而被迫放弃CPU，或者被其他优先级更高的线程所抢占。一般由于线程数大于CPU可用核心数引起，可通过调整线程数，适当减少线程数来避免
* `vmstat 1`
  - cs(context switch)

```sh
# 跟踪所有上下文切换，直到Ctrl-C：
perf record -e context-switches -c 1 -a

# 包括使用的原始设置（请参阅：man perf_event_open）：
perf record -vv -e context-switches -a

# 使用堆栈跟踪的示例上下文切换，直到Ctrl-C：
perf record -e context-switches -ag

perf report # 查看相关结果
```


## Memory Management 内存

* 又称主存，是 CPU 能直接寻址的存储空间，由半导体器件制成
* 作用
  - 暂时存放 cpu 的运算数据
  - 硬盘等外部存储器交换的数据
  - 保障 cpu 计算的稳定性和高性能
* 用户态&内核态
  - 用户态：Ring3 运行于用户态的代码则要受到处理器的诸多
  - 内核态：Ring0 在处理器的存储保护中，核心态
  - 用户态切换到内核态的 3 种方式
    + 系统调用
    + 异常
    + 外设中断
  - 区别：每个进程都有完全属于自己的，独立的，不被干扰的内存空间；用户态的程序就不能随意操作内核地址空间，具有一定的安全保护作用；内核态线程共享内核地址空间；
* 地址
  - 将主板上的物理内存条所提供的内存空间定义为物理内存空间，其中每个内存单元的实际地址就是物理地址
  - 将程序员看到的内存空间定义为虚拟地址空间(或地址空间)，其中的地址就叫做虚拟地址(或虚地址)，一般用“段:偏移量”的形式来描述，如A815:CF2D
  - 线性地址空间是指一段连续的、不分段的、范围为0~4GB的地址空间，一个线性地址就是线性地址空间的一个绝对地址
* 虚地址转换为物理地址：在保护模式下，内存管理单元(MMU)由一个或一组芯片组成硬件电路，包含分段部件和分页部件两个部件，其功能是指虚拟地址映射为物理地址，即进行地址转换
  - 分段机制
    + 逻辑地址的段寄存器中的值提供段描述符
    + 从段描述符中得到段基址和段界限
    + 加上逻辑地址的偏移量，就得到了线性地址
  - 分页机制
    + 在分段机制之后进行的，进一步将线性地址转换为物理地址
    + 10 位页目录，10 位页表项， 12 位页偏移地址
    + 单页的大小为 4KB
  - 段选择符
    - 为了方便快速检索段选择符，处理器提供了 6 个分段寄存器来缓存段选择符：cs,ss,ds,es,fs 和 gs
    - 段的基地址(Base Address)：在线性地址空间中段的起始地址
    - 段的界限(Limit)：在虚拟地址空间中，段内可以使用的最大偏移量
  - 32位线性地址空间要采用两级页表：页表是把线性地址映射到物理地址的一种数据结构，4GB的线性空间可以被划分为1M个4KB大小的页，每个页表项占4字节，则1M个页表项的页表就需要占用4MB空间，而且还要求是连续的，于是采用两级页表来实现；两级页表就是对页表再进行分页，第一级称为页目录，其中存放关于页表的信息；4MB的页表再次分页，可以分为1K个4KB大小的页
* 用户态地址空间
  - TEXT：代码段可执行代码、字符串字面值、只读变量
  - DATA：数据段，映射程序中已经初始化的全局变量
  - BSS 段：存放程序中未初始化的全局变量
  - HEAP：运行时的堆，在程序运行中使用 malloc 申请的内存区域
  - MMAP：共享库及匿名文件的映射区域
  - STACK：用户进程栈
* 用户态内存分配函数
  - alloca 是向栈申请内存,因此无需释放
  - malloc 所分配的内存空间未被初始化，使用 malloc() 函数的程序开始时(内存空间还没有被重新分配)能正常运行，但经过一段时间后(内存空间已被重新分配) 可能会出现问题
  - calloc 会将所分配的内存空间中的每一位都初始化为零
  - realloc 扩展现有内存空间大小
  - a)如果当前连续内存块足够 realloc 的话，只是将 p 所指向的空间扩大，并返回 p 的指针地址。这个时候 q 和 p指向的地址是一样的
  - b)如果当前连续内存块不够长度，再找一个足够长的地方，分配一块新的内存，q，并将 p 指向的内容 copy 到 q，返回 q。并将 p 所指向的内存空间删除
* 内核态地址空间
  - 直接映射区：线性空间中从 3G 开始最大 896M 的区间，为直接内存映射区
  - 动态内存映射区：该区域由内核函数 vmalloc 来分配
  - 永久内存映射区：该区域可访问高端内存
  - 固定映射区：该区域和 4G 的顶端只有 4k 的隔离带，其每个地址项都服务于特定的用途，如：ACPI_BASE 等
* 内核态内存分配函数
  - 函数分配原理最大内存其他`_get_free_pages` 直接对页框进行操作4MB适用于分配较大量的连续物理内存
  - kmem_cache_alloc基于 slab 机制实现128KB适合需要频繁申请释放相同大小内存块时使用
  - kmalloc 基于 kmem_cache_alloc 实现128KB最常见的分配方式，需要小于页框大小的内存时可以使用
  - vmalloc建立非连续物理内存到虚拟地址的映射物理不连续，适合需要大内存，但是对地址连续性没有要求的场合
  - dma_alloc_coherent基于_alloc_pages 实现4MB适用于 DMA 操作
  - ioremap实现已知物理地址到虚拟地址的映射适用于物理地址已知的场合，如设备驱动
  - alloc_bootmem在启动 kernel 时，预留一段内存，内核看不见小于物理内存大小，内存管理要求较高
* 进程内存空间
  - 用户进程通常情况只能访问用户空间的虚拟地址，不能访问内核空间虚拟地址
  - 内核空间是由内核负责映射，不会跟着进程变化；内核空间地址有自己对应的页表，用户进程各自有不同额页表
* 页面高速缓存自动保留处理器最近使用的32项页表项，因此可以覆盖128KB范围的内存
* swap:物理内存的可用空间是有限的，所以逻辑内存映射一部分地址到硬盘上，以便获取更大的物理内存地址
  - 应用真正的高并发了，swap绝对能体验到它魔鬼性的一面：进程倒是死不了了，但GC时间长的无法忍受
* 采用分页机制来实现虚拟存储器管理
  - Linux的分段机制使得所有的进程都使用相同的段寄存器，使得内存管理变得简单
  - Linux的设计目标之一就是能够被移植到绝大多数流行的处理平台上，但许多RISC处理器支持的分段功能非常有限；为了保证可移植性，Linux采用三级分页模式，因为许多处理器都采用64位结构；Linux定义了三种类型的页表：页目录(PGD)、中间目录(PMD)和页表(PT)
* 内存分配算法
  - 内存碎片
    + 产生原因：内存分配较小，并且分配的这些小的内存生存周期又较长，反复申请后将产生内存碎片的出现
    + 优点：提高分配速度，便于内存管理，防止内存泄露
    + 缺点：大量的内存碎片会使系统缓慢，内存使用率低，浪费大
  - 如何避免内存碎片
    + 少用动态内存分配的函数(尽量使用栈空间)
    + 分配内存和释放的内存尽量在同一个函数中
    + 尽量一次性申请较大的内存，而不要反复申请小内存
    + 尽可能申请大块的 2 的指数幂大小的内存空间
    + 外部碎片避免——伙伴系统算法
    + 内部碎片避免——slab 算法
    + 自己进行内存管理工作，设计内存池
  - 伙伴系统算法——组织结构
    + 概念
      * 为内核提供了一种用于分配一组连续的页而建立的一种高效的分配策略，并有效的解决了外碎片问题
      * 分配的内存区是以页框为基本单位的
    + 外部碎片
      * 外部碎片指的是还没有被分配出去（不属于任何进程），但由于太小了无法分配给申请内存空间的新进程的内存空闲区域3)    组织结构
      * 把所有的空闲页分组为 11 个块链表，每个块链表分别包含大小为 1，2，4，8，16，32，64，128，256，512 和 1024 个连续页框的页块。最大可以申请 1024 个连续页，对应 4MB 大小的连续内存。
  - 伙伴系统算法——申请和回收
    - 申请算法
      * 申请 2^i 个页块存储空间，如果 2^i 对应的块链表有空闲页块，则分配给应用
      * 如果没有空闲页块，则查找 2^(i 1) 对应的块链表是否有空闲页块，如果有，则分配 2^i 块链表节点给应用，另外 2^i 块链表节点插入到 2^i 对应的块链表中
      * 如果 2^(i 1) 块链表中没有空闲页块，则重复步骤 2，直到找到有空闲页块的块链表
      * 如果仍然没有，则返回内存分配失败
    - 回收算法
      * 释放 2^i 个页块存储空间，查找 2^i 个页块对应的块链表，是否有与其物理地址是连续的页块，如果没有，则无需合并
      * 如果有，则合并成 2^（i 1）的页块，以此类推，继续查找下一级块链接，直到不能合并为止
    + 条件
      * 两个块具有相同的大小
      * 它们的物理地址是连续的
      * 页块大小相同
* 如何分配 4M 以上内存
  - 为何限制大块内存分配
    + 分配的内存越大, 失败的可能性越大
    + 大块内存使用场景少
  - 内核中获取 4M 以上大内存的方法
    + 修改 MAX_ORDER, 重新编译内核
    + 内核启动选型传递'mem='参数, 如'mem=80M，预留部分内存；然后通过
    + request_mem_region 和 ioremap_nocache 将预留的内存映射到模块中。需要修改内核启动参数, 无需重新编译内核. 但这种方法不支持 x86 架构, 只支持 ARM, PowerPC 等非 x86 架构
    + 在 start_kernel 中 mem_init 函数之前调用 alloc_boot_mem 函数预分配大块内存, 需要重新编译内核
    + vmalloc 函数，内核代码使用它来分配在虚拟内存中连续但在物理内存中不一定连续的内存
* 伙伴系统——反碎片机制
  - 不可移动页
    + 这些页在内存中有固定的位置，不能够移动，也不可回收
    + 内核代码段，数据段，内核 kmalloc() 出来的内存，内核线程占用的内存等
  - 可回收页
    + 这些页不能移动，但可以删除。内核在回收页占据了太多的内存时或者内存短缺时进行页面回收3)    可移动页
    + 这些页可以任意移动，用户空间应用程序使用的页都属于该类别。它们是通过页表映射的
    + 当它们移动到新的位置，页表项也会相应的更新
* 请求调页
  - 如果被访问的页不在内存，也就是这个页还没有被存放在任何一个物理页面中内核分配一个新的页面并将其适当地初始化，这种技术称为“请求调页”；
  - “请求调页”是一种动态内存分配技术，将页面的分配推迟到不能再推迟为止，一直推迟到进程要访问的页不在物理内存时为止，由此引起一个缺页异常；该技术的引入主要是因为进程开始运行时并不访问其地址空间中的全部地址
* 缺页异常
  - 通过 get_free_pages 申请一个或多个物理页面
  - 换算 addr 在进程 pdg 映射中所在的 pte 地址
  - 将 addr 对应的 pte 设置为物理页面的首地址
  - 系统调用：Brk—申请内存小于等于 128kb，do_map—申请内存大于 128kb
* `free -m`: 可用的memory=free memory+buffers+cached
* Buffer和Cache
  - Cache（缓存）位于CPU与内存之间的临时存储器，缓存容量比内存小的多但交换速度比内存要快得多。Cache通过缓存文件数据块，解决CPU运算速度与内存读写速度不匹配的矛盾，提高CPU和内存之间的数据交换速度。Cache缓存越大，CPU处理速度越快。
  - Buffer（缓冲）高速缓冲存储器，通过缓存磁盘（I/O设备）数据块，加快对磁盘上数据的访问，减少I/O，提高内存和硬盘（或其他I/O设备）之间的数据交换速度。Buffer是即将要被写入磁盘的，而Cache是被从磁盘中读出来的。
* Linux系统采用的是虚拟内存，进程的代码，库，堆和栈的使用都会消耗内存，但是申请出来的内存，只要没真正access过，是不算的，因为没有真正为之分配物理页面
  - 第一层防护墙swap；当swap也用的差不多了，会尝试释放cache；当这两者资源都耗尽，杀手就出现了。oom killer会在系统内存耗尽的情况下跳出来，选择性的干掉一些进程以求释放一点内存。2.4内核杀新进程；2.6杀用的最多的那个
* overcommit_memory
  - 0:表示内核将检查是否有足够的可用内存供应用进程使用；如果有足够的可用内存，内存申请允许；否则，内存申请失败，并把错误返回给应用进程。
  - 1:表示内核允许分配所有的物理内存，而不管当前的内存状态如何
  - 2:表示内核允许分配超过所有物理内存和交换空间总和的内存
* 零拷贝 zero-copy:避免 CPU 将数据从一块存储拷贝到另外一块存储
  - 服务端：文件内容是否缓存在内核缓冲区->循环的从磁盘读入文件内容->(DMA)内核缓冲区->用户空间缓冲区->网络堆栈相关内核缓冲区->已连接的 Socket
  - 让数据传输不需要经过 user space
  - mmap:通过内存映射，将文件映射到内核缓冲区，同时，用户空间可以共享内核空间的数据。这样，在进行网络传输时，就可以减少内核空间到用户空间的拷贝次数
    + 用 mmap () 来代替 read 调用:磁盘上的数据会通过 DMA 被拷贝的内核缓冲区，接着操作系统会把这段内核缓冲区与应用程序共享
    + 调用 write ()，操作系统直接将内核缓冲区的内容拷贝到 Socket 缓冲区中，这一切都发生在内核态，最后，Socket 缓冲区再把数据发到网卡去
    + 隐藏陷阱:当程序 map 了一个文件，但是当这个文件被另一个进程截断 (truncate) 时，Write 系统调用会因为访问非法地址而被 SIGBUS 信号终止。SIGBUS 信号默认会杀死你的进程并产生一个 coredump，如果你的服务器这样被中止了，那会产生一笔损失
    + 解决方案
      * 为 SIGBUS 信号建立信号处理程序:遇到 SIGBUS 信号时，信号处理程序简单地返回，Write 系统调用在被中断之前会返回已经写入的字节数，并且 errno 会被设置成 success
      * 使用文件租借锁:在文件描述符上使用租借锁，我们为文件向内核申请一个租借锁.当其他进程想要截断这个文件时，内核会向我们发送一个实时的 RTSIGNALLEASE 信号，告诉我们内核正在破坏加持在文件上的读写锁.这样在程序访问非法内存并且被 SIGBUS 杀死之前，你的 Write 系统调用会被中断。Write 会返回已经写入的字节数，并且置 errno 为 success
  - 从 2.1 版内核开始，Linux 引入了 sendfile 来简化操作：利用 DMA 引擎将文件内容拷贝到内核缓冲区去，然后将带有文件位置和长度信息的缓冲区描述符添加 Socket 缓冲区去
    + 系统调用 sendfile () 在代表输入文件的描述符 infd 和代表输出文件的描述符 outfd 之间传送文件内容（字节）
    + 描述符 outfd 必须指向一个套接字，而 infd 指向的文件必须是可以 mmap 的.这些局限限制了 sendfile 的使用，使 sendfile 只能将数据从文件传递到套接字上，反之则不行。
    + 不仅减少了数据拷贝的次数，还减少了上下文切换，数据传送始终只发生在 kernel space
    + 调用 sendfile 时，如果有其它进程截断了文件会发生什么:仅仅返回它在被中断之前已经传输的字节数，errno 会被置为 success
    + 在调用 sendfile 之前给文件加了锁，sendfile 的行为仍然和之前相同，我们还会收到 RTSIGNALLEASE 的信号
    + Linux的sendfile系调用可以实现将服务器中的本地文件直接拷贝（通过DMA）到Socket缓存，进而发送到网络中，避免了文件数据的多次拷贝
    + Nginx
      * Nginx中，当使用sendfile函数时，TCP_NOPUSH才起作用，因为在sendfile时，Nginx会要求发送某些信息来预先解释数据，这些信息其实就是报头内容，典型情况下报头很小，而且套接字上设置了TCP_NODELAY。有报头的包将被立即传输，在某些情况下（取决于内部的包计数器），因为这个包成功地被对方收到后需要请求对方确认。这样，大量数据的传输就会被推迟而且产生了不必要的网络流量交换。而通过设置TCP_NOPUSH=on，表示将所有HTTP的header一次性发出去
      * Nginx的TCP_NODELAY只有在配置长连接时才起作用，因为长连接可能引起小包的阻塞，配置TCP_NODELAY可以避免该阻塞
      * 在 nginx 中，tcp_nopush 配置和 tcp_nodelay “互斥”。
      * 默认nginx访问后端都是用的短连接(HTTP1.0)，一个请求来了，Nginx 新开一个端口和后端建立连接，后端执行完毕后主动关闭该链接）。
      * 默认情况下，nginx已经自动开启了对client连接的keep alive支持（同时client发送的HTTP请求要求keep alive）。
    + 省略页缓存数据拷贝到 Socket 缓存中：仅仅需要把缓冲区描述符传到 Socket 缓冲区，再把数据长度传过去，这样 DMA 控制器直接将页缓存中的数据打包发送到网络中就可以
    + 需要硬件以及驱动程序支持
    + 只适用于将数据从文件拷贝到套接字上
  - 2.6.17 版本引入 splice 系统调用，用于在两个文件描述符中移动数据
    + 调用在两个文件描述符之间移动数据，而不需要数据在内核空间和用户空间来回拷贝
    + 从 fdin 拷贝 len 长度的数据到 fdout，但是有一方必须是管道设备， splice 的一些局限性
    + flags 参数有以下几种取值：
      * SPLICEFMOVE：尝试去移动数据而不是拷贝数据。这仅仅是对内核的一个小提示：如果内核不能从 pipe 移动数据或者 pipe 的缓存不是一个整页面，仍然需要拷贝数据
      * Linux 最初的实现有些问题，所以从 2.6.21 开始这个选项不起作用，后面的 Linux 版本应该会实现
      * SPLICEFNONBLOCK：splice 操作不会被阻塞。然而，如果文件描述符没有被设置为不可被阻塞方式的 I/O ，那么调用 splice 有可能仍然被阻塞
      * SPLICEFMORE：后面的 splice 调用会有更多的数据
    + 数据必须在用户空间和内核空间之间拷贝
      * Linux 通常利用写时复制（copy on write）来减少系统开销，这个技术又时常称作 COW.多个程序同时访问同一块数据,只有当程序需要对数据内容进行修改时，才会把数据内容拷贝到程序自己的应用空间里去
* top展示的字段，RES才是真正的物理内存占用
  - Htop 是个比内置的 top 任务管理更强大的工具。它提供了带有诸多选项的高级接口用于监控系统进程
* 系统可用内存，包括：free + buffers + cached，因为后两者可以自动释放。但不要迷信，有很大一部分，你是释放不了的
* slab 算法
  - 基本概念
    + Linux 所使用的 slab 分配器的基础是 Jeff Bonwick 为 SunOS 操作系统首次引入的一种算法
    + 基本思想是将内核中经常使用的对象放到高速缓存中，并且由系统保持为初始的可利用状态。比如进程描述符，内核中会频繁对此数据进行申请和释放
  - 内部碎片
    + 已经被分配出去的的内存空间大于请求所需的内存空间3) 基本目标
    + 减少伙伴算法在分配小块连续内存时所产生的内部碎片
    + 将频繁使用的对象缓存起来，减少分配、初始化和释放对象的时间开销
    + 通过着色技术调整对象以更好的使用硬件高速缓存
* slab 分配器结构
  - 由于对象是从 slab 中分配和释放的，因此单个 slab 可以在 slab 列表之间进行移动
  - slabs_empty 列表中的 slab 是进行回收（reaping）的主要备选对象
  - slab 还支持通用对象的初始化，从而避免了为同一目而对一个对象重复进行初始化
* slab 高速缓存
  - 普通高速缓存
    + slab 分配器所提供的小块连续内存的分配是通过通用高速缓存实现的
    + 通用高速缓存所提供的对象具有几何分布的大小，范围为 32 到 131072 字节。
    + 内核中提供了 kmalloc() 和 kfree() 两个接口分别进行内存的申请和释放
  - 专用高速缓存
    + 内核为专用高速缓存的申请和释放提供了一套完整的接口，根据所传入的参数为具体的对象分配 slab 缓存
    + kmem_cache_create() 用于对一个指定的对象创建高速缓存。从 cache_cache 普通高速缓存中为新的专有缓存分配一个高速缓存描述符，并把这个描述符插入到高速缓存描述符形成的 cache_chain 链表中
    + kmem_cache_alloc() 在其参数所指定的高速缓存中分配一个 slab。相反， kmem_cache_free() 在其参数所指定的高速缓存中释放一个 slab
* slab区，是内核的缓存文件句柄等信息等的特殊区域，slabtop命令可以看到具体使用
* 内核态内存池
  - 基本原理
    + 先申请分配一定数量的、大小相等(一般情况下) 的内存块留作备用
    + 当有新的内存需求时，就从内存池中分出一部分内存块，若内存块不够再继续申请新的内存
    + 这样做的一个显著优点是尽量避免了内存碎片，使得内存分配效率得到提升
  - 内核 API
    + mempool_create 创建内存池对象
    + mempool_alloc 分配函数获得该对象
    + mempool_free 释放一个对象
    + mempool_destroy 销毁内存池
* DMA 内存
  - 什么是 DMA
    + 直接内存访问是一种硬件机制，允许外围设备和主内存之间直接传输它们的 I/O数据，而不需要系统处理器的参与
    + DMA 控制器能向 CPU 发出系统保持（HOLD）信号，提出总线接管请求
    + 当 CPU 发出允许接管信号后，负责对总线的控制，进入 DMA 方式
    + 能对存储器寻址及能修改地址指针，实现对内存的读写操作
    + 能决定本次 DMA 传送的字节数，判断 DMA 传送是否结束
    + 发出 DMA 结束信号，使 CPU 恢复正常工作状态
  - DMA 信号
    + DREQ：DMA 请求信号。是外设向 DMA 控制器提出要求，DMA 操作的申请信号
    + DACK：DMA 响应信号。是 DMA 控制器向提出 DMA 请求的外设表示已收到请求和正进行处理的信号
    + HRQ：DMA 控制器向 CPU 发出的信号，要求接管总线的请求信号。
    + HLDA：CPU 向 DMA 控制器发出的信号，允许接管总线的应答信号
* 内存使用场景
  - page 管理
  - slab（kmalloc、内存池）
  - 用户态内存使用（malloc、relloc 文件映射、共享内存）
  - 程序的内存 map（栈、堆、code、data）
  - 内核和用户态的数据传递（copy_from_user、copy_to_user）
  - 内存映射（硬件寄存器、保留内存）
  - DMA 内存
* malloc 申请内存
  - 调用 malloc 函数时，它沿 free_chuck_list 连接表寻找一个大到足以满足用户请求所需要的内存块
  - free_chuck_list 连接表的主要工作是维护一个空闲的堆空间缓冲区链表
  - 如果空间缓冲区链表没有找到对应的节点，需要通过系统调用 sys_brk 延伸进程的栈空间
* 用户进程访问内存分析
  - 用户态进程独占虚拟地址空间，两个进程的虚拟地址可相同
  - 在访问用户态虚拟地址空间时，如果没有映射物理地址，通过系统调用发出缺页异常
  - 缺页异常陷入内核，分配物理地址空间，与用户态虚拟地址建立映射
* 共享内存
  - 原理
    + 它允许多个不相关的进程去访问同一部分逻辑内存
    + 两个运行中的进程之间传输数据，共享内存将是一种效率极高的解决方案
    + 两个运行中的进程共享数据，是进程间通信的高效方法，可有效减少数据拷贝的次数
  - Shm 接口
    + shmget 创建共享内存
    + shmat 启动对该共享内存的访问，并把共享内存连接到当前进程的地址空间
    + shmdt 将共享内存从当前进程中分离
* 坑
  - C 内存泄露
    + 在类的构造函数和析构函数中没有匹配地调用 new 和 delete 函数
    + 没有正确地清除嵌套的对象指针
    + 没有将基类的析构函数定义为虚函数
    + 当基类的指针指向子类对象时，如果基类的析构函数不是 virtual，那么子类的析构函数将不会被调用，子类的资源没有得到正确释放，因此造成内存泄露
    + 缺少拷贝构造函数，按值传递会调用（拷贝）构造函数，引用传递不会调用
    + 指向对象的指针数组不等同于对象数组，数组中存放的是指向对象的指针，不仅要释放每个对象的空间，还要释放每个指针的空间
    + 缺少重载赋值运算符，也是逐个成员拷贝的方式复制对象，如果这个类的大小是可变的，那么结果就是造成内存泄露
  - C 野指针
    + 指针变量没有初始化
    + 指针被 free 或 delete 后，没有设置为 NULL
    + 指针操作超越了变量的作用范围，比如返回指向栈内存的指针就是野指针
    + 访问空指针（需要做空判断）
    + sizeof 无法获取数组的大小
    + 试图修改常量，如：char p='1234';p=\'1\';
  - C 资源访问冲突
    + 多线程共享变量没有用 valotile 修饰
    + 多线程访问全局变量未加锁
    + 全局变量仅对单进程有效
    + 多进程写共享内存数据，未做同步处理
    + mmap 内存映射，多进程不安全
  - STL 迭代器失效
    + 被删除的迭代器失效
    + 添加元素（insert/push_back 等）、删除元素导致顺序容器迭代器失效
  - C++ 11 智能指针
    + auto_ptr 替换为 unique_ptr
    + 使用 make_shared 初始化一个 shared_ptr
    + weak_ptr 智能指针助手（1）原理分析：
  - C++ 11 更小更快更安全
    + std::atomic 原子数据类型 多线程安全
    + std::array 定长数组开销比 array 小和 std::vector 不同的是 array 的长度是固定的，不能动态拓展
    + std::vector vector 瘦身 shrink_to_fit()：将 capacity 减少为于 size() 相同的大小
    + td::forward_list
* std::unordered_map、std::unordered_set用 hash 实现的无序的容器，插入、删除和查找的时间复杂度都是 O(1)，在不关注容器内元素顺序的场合，使用 unordered 的容器能获得更高的性能
* 如何查看内存
  - 系统中内存使用情况：/proc/meminfo
  - 进程的内存使用情况：/proc/28040/status
  - `free -h` display the memory usage of the system 查询内存总使用率
  - 查询进程 cpu 和内存使用占比：top
  - `vmstat` display the memory usage along with additional information about io and cpu usage 虚拟内存统计
  - 进程消耗内存占比和排序：ps aux –sort -rss
  - 释放系统内存缓存： /proc/sys/vm/drop_caches
  - To free pagecache, use echo 1 > /proc/sys/vm/drop_caches
  - To free dentries and inodes, use echo 2 > /proc/sys/vm/drop_caches
  - To free pagecache, dentries and inodes, use echo 3 >/proc/sys/vm/drop_caches
* 参考
  - [Linux系统内存知识](https://mp.weixin.qq.com/s/aw9dq77SdO2pWxu049drwA)
  - [Linux内存管理（下篇）：10张图解再谈物理内存和虚拟内存](https://mp.weixin.qq.com/s/EvU7pV51ctPooREQt_8SaQ)
  - [](https://mp.weixin.qq.com/s/Aj-A5ltGJoD5fkFiMlhjoA)

```sh
cat /proc/meminfo
# /etc/sysctl.conf ，改vm.overcommit_memory=1，然后sysctl -p 使配置文件生效
sysctl vm.overcommit_memory=1
echo 1 > /proc/sys/vm/overcommit_memory

buf = mmap(diskfd, len);
write(sockfd, buf, len);

## 应该在 mmap 文件之前加锁，并且在操作完文件后解锁
if(fcntl(diskfd, F_SETSIG, RT_SIGNAL_LEASE) == -1) {
    perror("kernel lease set signal");
    return -1;
}
/* l_type can be F_RDLCK F_WRLCK  加锁*/
/* l_type can be  F_UNLCK 解锁*/
if(fcntl(diskfd, F_SETLEASE, l_type)){
    perror("kernel lease set type");
    return -1;
}

#include<sys/sendfile.h>
ssize_t sendfile(int out_fd, int in_fd, off_t *offset, size_t count);

#define _GNU_SOURCE         /* See feature_test_macros(7) */
#include <fcntl.h>
ssize_t splice(int fd_in, loff_t *off_in, int fd_out, loff_t *off_out, size_t len, unsigned int flags);

# 排查内存
# 物理内存
# 根据使用量排序查看RES
top -> shift + m
#查看进程使用的物理内存
ps -p 75 -o rss,vsz
#显示内存的使用情况
free -h
#使用sar查看内存信息
sar -r
#显示内存每个区的详情
cat /proc/meminfo
#查看slab区使用情况
slabtop

lsmem

# swap
#查看si,so是否异常
vmstat 1
#使用sar查看swap
sar -W
#禁用swap
swapoff
#查询swap优先级
sysctl -q vm.swappiness
#设置swap优先级
sysctl vm.swappiness=10

# jvm
# 查看系统级别的故障和问题
dmesg
# 统计实例最多的类前十位
jmap -histo pid | sort -n -r -k 2 | head -10
# 统计容量前十的类
jmap -histo pid | sort -n -r -k 3 | head -10

# 释放内存
echo 3 > /proc/sys/vm/drop_caches
#查看进程物理内存分布
pmap -x 75  | sort -n -k3
#dump内存内容
gdb --batch --pid 75 -ex "dump memory a.dump 0x7f2bceda1000 0x7f2bcef2b000"

dmesg -T
```

## [虚拟内存](https://mp.weixin.qq.com/s/Z1HkFdnz_WoZt_mi1F4Y0w)

* 所有运行在当前操作系统的进程会共享系统中的 CPU 和内存资源，操作系统会使用 CPU 调度器分配 CPU 时间[^1]并引入虚拟内存系统以管理物理内存
* 虚拟内存是操作系统物理内存和进程之间的中间层，它为进程隐藏了物理内存这一概念，为进程提供了更加简洁和易用的接口以及更加复杂的功能
* 进程持有的虚拟地址（Virtual Address）会经过内存管理单元（Memory Mangament Unit）的转换变成物理地址[^2]，然后再通过物理地址访问内存
* 主存储是相对比较稀缺的资源，虽然顺序读取只比磁盘快 1 个数量级，但是它能**提供极快的随机访问速度**，从内存上随机读取数据是磁盘的 100,000 倍[^3]，充分利用内存的随机访问速度是改善程序执行效率的有效方式
* 虚拟内存中的虚拟页（Virtual Page，PP）可能处于以下的三种状态
  - 未分配（Unallocated）：没有被进程申请使用的，也就是空闲的虚拟内存，不占用虚拟内存磁盘的任何空间
  - 未缓存（Uncached）：仅加载到磁盘中的内存页
  - 已缓存（Cached）：已经加载到主存中的内存页
* 当用户程序访问未被缓存的虚拟页时，硬件就会触发缺页中断（Page Fault，PF）
  - 在部分情况下，被访问的页面已经加载到了物理内存中，但是用户程序的页表（Page Table）并不存在该对应关系，这时只需要在页表中建立虚拟内存到物理内存的关系
  - 在其他情况下，操作系统需要将磁盘上未被缓存的虚拟页加载到物理内存中
* 操作系统以页为单位管理内存，当进程发现需要访问的数据不在内存时，操作系统可能会将数据以页的方式加载到内存中，这个过程是由内存管理单元（MMU）完成。操作系统的虚拟内存作为一个抽象层，起到了以下三个非常关键的作用：
  - 缓存：可以利用磁盘起到缓存的作用，提高进程访问指定内存的速度。结合磁盘和物理内存的优势为进程提供看起来速度足够快并且容量足够大的存储
    + 将虚拟内存看作是在磁盘上一片空间，当这片空间中的一部分访问比较频繁时，该部分数据会以页为单位被缓存到主存中以加速 CPU 访问数据的性能
    + 虚拟内存**利用空间较大的磁盘存储作为『内存』并使用主存储缓存**进行加速，让上层认为操作系统的内存很大而且很快，然而区域很大的磁盘并不快，而很快的内存也并不大。(寻址空间与访问速度)
  - 内存管理：可以为进程提供独立的内存空间，简化程序的链接、加载过程并通过动态库共享内存。引入多层的页表结构将虚拟内存翻译成物理内存，进程之间可以共享物理内存减少开销
    + 制造一种每个进程的内存都是独立的假象，在 64 位的操作系统上，每个进程都会拥有 256 TiB 的内存空间，内核空间和用户空间分别占 128 TiB。每个进程的虚拟内存空间是完全独立的，所以它们都可以完整的使用 0x0000000000000000 到 0x00007FFFFFFFFFFF 的全部内存
    + 虚拟内存空间只是操作系统中的逻辑结构，最终还是需要访问物理内存或者磁盘上的内容，需要为进程实现地址翻译器，实现从虚拟地址到物理地址的转换
    + 页表是虚拟内存系统中的重要数据结构，每一个进程的页表中都存储了从虚拟内存到物理内存页的映射关系，为了存储 64 位操作系统中 128 TiB 虚拟内存的映射数据，Linux 在 2.6.10 中引入了四层的页表辅助虚拟地址的转换，在 4.11 中引入了五层的页表结构
    + 使用最低的 12 位作为页面的偏移量，剩下的 32 位会分四组分别表示当前层级在上一层中的索引，所有的虚拟地址都可以用上述的多层页表查找到对应的物理地址
    + 多个进程可以通过虚拟内存共享物理内存
      * Redis 快照使用子进程 一文中介绍的写时复制就利用了虚拟内存的这个特性
      * Linux 中调用 fork 创建子进程时，实际上只复制了父进程的页表,父子进程会通过不同的页表指向相同的物理内存
    + 共享一些常见的动态库减少物理内存的占用，所有的进程都可能调用相同的操作系统内核代码，而 C 语言程序也会调用相同的标准库
    + 独立的虚拟内存空间也会简化内存的分配过程，当用户程序向操作系统申请堆内存时，操作系统可以分配几个连续的虚拟页，但是这些虚拟页可以对应到物理内存中不连续的页中
  - 内存保护:可以控制进程对物理内存的访问，隔离不同进程的访问权限，提高系统的安全性
    + 每一个进程都持有独立的虚拟内存空间，那么虚拟内存中页表可以理解成进程和物理页的『连接表』，其中可以存储进程和物理页之间的访问关系，包括读权限、写权限和执行权限
    + 内存管理单元可以决定当前进程是否有权限访问目标的物理内存，这样我们就最终将权限管理的功能全部收敛到虚拟内存系统中，减少了可能出现风险的代码路径
* 主内存的空间是有限的，当主内存中不包含可以使用的空间时，操作系统会从选择合适的物理内存页驱逐回磁盘，为新的内存页让出位置，选择待驱逐页的过程在操作系统中叫做页面替换（Page Replacement）
* 缺页中断和页面替换技术都是操作系统调页算法（Paging）的一部分，该算法的目的就是充分利用内存资源作为磁盘的缓存以提高程序的运行效率。

## 缓存 Cache

* 缓冲区高速缓存包含块设备驱动程序使用的数据缓冲区
  - 支持「以固定大小的块，扇区或群集读取和（可选）写入数据」。每个块都有自己的物理地址。通常块的大小在 512 - 65536 之间。所有传输的信息都会以连续的块为单位。块设备的基本特征是每个块都较为对立，能够独立的进行读写。常见的块设备有 「硬盘、蓝光光盘、USB 盘」
* page cache：文件系统层级的缓存
  - 从磁盘里读取的内容是存储到这里，这样程序读取磁盘内容就会非常快，比如使用Linux的grep和find等命令查找内容和文件时，第一次会慢很多，再次执行就快好多倍，几乎是瞬间
  - page cache的数据被修改过后，也即脏数据，等到写入磁盘时机到来时，会转移到buffer cache 而不是直接写入到磁盘。
  - 看到的cached这列的数值表示的是当前的页缓存（page cache）的占用量，page cache文件的页数据，页是逻辑上的概念，因此page cache是与文件系统同级的
  - 用于一次一页地缓存文件中的内容，并且可以通过文件和文件中的偏移量进行访问。当页面从磁盘读入内存时，它们被缓存在页面缓存中
* buffer cache：磁盘等块设备的缓冲，内存的这一部分是要写入到磁盘里的
  - buffers列表示当前的块缓存（buffer cache）占用量，buffer cache用于缓存块设备（如磁盘）的块数据。
  - 块是物理上的概念，因此buffer cache是与块设备驱动程序同级的
  - 只要这些页面在写入交换文件后没有修改，则下次交换该页面时，无需将其写入交换文件，因为该页面已在交换文件中。可以直接丢弃。在大量交换的系统中，这节省了许多不必要的和昂贵的磁盘操作
  - 两者都是用来加速数据 IO
    + 将写入的页标记为dirty，然后向外部存储flush
    + 读数据时首先读取缓存，如果未命中，再去外部存储读取，并且将读取来的数据也加入缓存
* 操作系统总是积极地将所有空闲内存都用作page cache和buffer cache，当os的内存不够用时也会用LRU等算法淘汰缓存页
* 缓存 I/O
  - 缓存 I/O 又被称作标准 I/O，大多数文件系统的默认 I/O 操作都是缓存 I/O
  - 在 Linux 的缓存 I/O 机制中，操作系统会将 I/O 的数据缓存在文件系统的页缓存（ page cache ）中，也就是数据会先被拷贝到操作系统内核的缓冲区中，然后才会从操作系统内核的缓冲区拷贝到应用程序的地址空间。
  - 缺点：数据在传输过程中需要在应用程序地址空间和内核进行多次数据拷贝操作，这些数据拷贝操作所带来的 CPU 以及内存开销是非常大的

```sh
free -m
-/+ buffers/cache
```

![Alt text](../_static/buffer_page.png "Optional title")

## I/O

### 设备

+ 将设备看成文件
  * 每个设备都对应一个文件名，在内核中也就对应一个索引节点
  * 对文件操作的系统调用大都适用于设备文件
  * 从应用程序角度看，设备文件的逻辑空间是一个线性空间
  * 对于同一个具体的设备而言，文件操作和设备驱动是同一个事物的不同层次，概念上可以将一个系统划分为应用、文件系统和设备驱动三个层次
+ 设备分类
  * 块设备：像磁盘那样的以块或扇区为单位、成块进行输入/输出的设备，文件系统通常都建立在块设备上
  * 字符设备：像键盘那样以字符(字节)为单位，逐个字符进行输入/输出的设备
  
* 有磁盘、打印机、网络等 I/O 设备，Linux 把这些设备当作一种 特殊文件 整合到文件系统中，一般通常位于 /dev 目录下。可以使用与普通文件相同的方式来对待这些特殊文件
  - 块特殊文件是一个能存储固定大小块信息的设备，它支持「以固定大小的块，扇区或群集读取和（可选）写入数据」。每个块都有自己的物理地址。通常块的大小在 512 - 65536 之间。所有传输的信息都会以连续的块为单位。块设备的基本特征是每个块都较为对立，能够独立的进行读写。常见的块设备有 「硬盘、蓝光光盘、USB 盘」与字符设备相比，块设备通常需要较少的引脚。
    + 缺点基于给定固态存储器的块设备比基于相同类型的存储器的字节寻址要慢一些，因为必须在块的开头开始读取或写入。所以，要读取该块的任何部分，必须寻找到该块的开始，读取整个块，如果不使用该块，则将其丢弃。要写入块的一部分，必须寻找到块的开始，将整个块读入内存，修改数据，再次寻找到块的开头处，然后将整个块写回设备。
  - 另一类 I/O 设备是字符特殊文件。字符设备以字符为单位发送或接收一个字符流，而不考虑任何块结构。字符设备是不可寻址的，也没有任何寻道操作。常见的字符设备有 「打印机、网络设备、鼠标、以及大多数与磁盘不同的设备」
    + 每个设备特殊文件都会和 设备驱动 相关联。每个驱动程序都通过一个 主设备号 来标识。如果一个驱动支持多个设备的话，此时会在主设备的后面新加一个 次设备号 来标识。主设备号和次设备号共同确定了唯一的驱动设备
    + CPU 并不直接和设备打交道，它们中间有一个叫作 设备控制器（Device Control Unit）的组件
    + 绝大多数字符特殊文件都不能随机访问，因为他们需要使用和块特殊文件不同的方式来控制
* 另外一个概念是网络，也是由 UNIX 引入，网络中一个很关键的概念就是套接字(socket)。套接字允许用户连接到网络
  - 可以动态创建和销毁。成功创建一个套接字后，系统会返回一个文件描述符(file descriptor)，在后面的创建链接、读数据、写数据、解除连接时都需要使用到这个文件描述符。每个套接字都支持一种特定类型的网络类型，在创建时指定。一般最常用的几种
    + 可靠的面向连接的字节流:使用管道 在两台机器之间建立连接。能够保证字节从一台机器按照顺序到达另一台机器，系统能够保证所有字节都能到达
    + 可靠的面向连接的数据包
      * 除了数据包之间的分界之外，第二种类型和第一种类型是类似的
    + 不可靠的数据包传输
  
* 普通磁盘的随机写和顺序写相差是非常大的。而随机写完全和cpu内存不在一个数量级。缓冲区依然是解决速度差异的唯一工具，所以在极端情况比如断电等，就产生了太多的不确定性。这些缓冲区，都容易丢
* 消除性能差异，软件方面做的优化
  - 数据库设计，采用BTree结构组织数据，通过减少对磁盘的访问和随机读取，来提高性能
  - Postgres通过顺序写WAL日志、ES通过写translog等，通过预写，避免断电后数据丢失问题
  - Kafka通过顺序写来增加性能，但在topic非常多的情况下性能弱化为随机写
  - Kafka通过零拷贝技术，利用DMA绕过内存直接发送数据
  - Redis使用内存模拟存储，它流行的主要原因就是和硬盘打交道的传统DB速度太慢
  - 回忆一下内存篇的buffer区，是用来缓冲写入硬盘的数据的。linux的sync命令可以将buffer的数据刷到硬盘上，突然断电的话，就不好说了
* iostat：查看硬盘整体的状况
  - %util 最重要的判断参数。一般地，如果该参数是100%表示设备已经接近满负荷运行了
  - Device 表示发生在哪块硬盘。如果你有多快，则会显示多行
  - avgqu-sz 还记得准备篇里提到的么？这个值是请求队列的饱和度，也就是平均请求队列的长度。毫无疑问，队列长度越短越好
  - await 响应时间应该低于5ms，如果大于10ms就比较大了。这个时间包括了队列时间和服务时间
  - svctm   表示平均每次设备I/O操作的服务时间。如果svctm的值与await很接近，表示几乎没有I/O等待，磁盘性能很好，如果await的值远高于svctm的值，则表示I/O队列等待太长，系统上运行的应用程序将变慢
* iotop 看到占用I/O最多的应用。本质是一个python脚本，从proc目录中获取thread的IO信息，进行汇总
* 通过ps命令或者top命令得到状态为D的进程 `for x in `seq 1 1 10`; do ps -eo state,pid,cmd | grep "^D"; echo "----"$x; sleep 5; done`
* zero copy
  - 少了内核缓存向用户空间的拷贝的过程
 
###  设备驱动

- 设备驱动程序：处理和管理硬件控制器的软件
  - I/O端口包括控制寄存器、状态寄存器和数据寄存器三大类
  - 根据访问外设寄存器的不同方式，将CPU分为两大类：一类是“内存映射”(memory-mapped)方式，另一类是“I/O映射”(I/O- mapped)方式。
  - LSB(Linux Standard Base)
  
* 速度：CPU的速度非常快，但向硬件发起一个请求并接到其响应的速度是相当慢的
  - 轮询机制：让内核定期对硬件设备进行查询，看是否需要处理，如果需要则处理，这种情况可能会让内核做很多无用功
  - 中断机制：让硬件主动来发送信号，当硬件有事件发生时则向内核发出信号，然后内核再介入处理，内核一般也是使用中断机制来管理硬件
  - 
### 中断

* 硬件产生中断信号，通过总线将电信号发送给中断控制器
* 中断控制器会将中断信号发往处理器。处理器会立即停止正在做的事情，然后关闭中断系统并跳到预定义的位置开始执行代码，这个预定义的代码就是由内核设置的中断处理程序入口
* 对于每个中断线，处理器都会跳转到对应一个唯一的入口位置。内核执行do_IRQ()函数对所接收到的中断进行响应

### I/O 系统调用

* 特殊文件是一种在文件系统中与硬件设备相关联的文件。特殊文件也被称为 设备文件(device file)。特殊文件的目的是将设备作为文件系统中的文件进行公开。特殊文件为硬件设备提供了借口，用于文件 I/O 的工具可以进行访问。因为设备有两种类型，同样特殊文件也有两种，即字符特殊文件和块特殊文件
* IO 是通过一系列设备驱动实现的，每个设备类型对应一个设备驱动。设备驱动为操作系统和硬件分别预留接口，通过设备驱动来屏蔽操作系统和硬件的差异。
* 当用户访问一个特殊的文件时，由文件系统提供此特殊文件的主设备号和次设备号，并判断它是一个块特殊文件还是字符特殊文件。主设备号用于标识字符设备还是块设备，次设备号用于参数传递。
* 每个驱动程序都有两部分：这两部分都是属于 Linux 内核，也都运行在内核态下。上半部分运行在调用者上下文并且与 Linux 其他部分交互。下半部分运行在内核上下文并且与设备进行交互。驱动程序可以调用内存分配、定时器管理、DMA 控制等内核过程。可被调用的内核功能都位于 驱动程序 - 内核接口 的文档中。
* 块设备实现:
	* 系统中处理块特殊文件 I/O 部分的目标是为了使传输次数尽可能的小。为了实现这个目标，Linux 系统在磁盘驱动程序和文件系统之间设置了一个 高速缓存(cache)
  - 在 Linux 内核 2.2 之前，Linux 系统维护着两个缓存：页面缓存(page cache) 和 缓冲区缓存(buffer cache)，因此，存储在一个磁盘块中的文件可能会在两个缓存中。2.2 版本以后 Linux 内核只有一个统一的缓存一个 通用数据块层(generic block layer) 把这些融合在一起，实现了磁盘、数据块、缓冲区和数据页之间必要的转换,通用数据块主要有以下几个功能
    + 将数据缓冲区放在内存高位处，当 CPU 访问数据时，页面才会映射到内核线性地址中，并且此后取消映射
    + 实现 零拷贝机制，磁盘数据可以直接放入用户模式的地址空间，而无需先复制到内核内存中
    + 管理磁盘卷，会把不同块设备上的多个磁盘分区视为一个分区。
    + 利用最新的磁盘控制器的高级功能，例如 DMA 等
  - 使用 IO 调度器 来保证减少磁头的反复移动从而减少损失。I/O 调度器的作用是对块设备的读写操作进行排序，对读写请求进行合并。Linux 有许多调度器的变体，从而满足不同的工作需要。最基本的 Linux 调度器是基于传统的 Linux 电梯调度器(Linux elevator scheduler)。Linux 电梯调度器的主要工作流程就是按照磁盘扇区的地址排序并存储在一个双向链表 中。新的请求将会以链表的形式插入。这种方法可以有效的防止磁头重复移动。因为电梯调度器会容易产生饥饿现象。因此，Linux 在原基础上进行了修改，维护了两个链表，在 最后日期(deadline) 内维护了排序后的读写操作。默认的读操作耗时 0.5s，默认写操作耗时 5s。如果在最后期限内等待时间最长的链表没有获得服务，那么它将优先获得服务。
* 字符设备实现
  - 由于字符设备会产生并使用字符流、字节数据，因此对随机访问的支持意义不大。一个例外是使用 行规则(line disciplines)。一个行规可以和终端设备相关联，使用 tty_struct 结构来表示，它表示与终端设备交换数据的解释器，当然这也属于内核的一部分
    + 行规是某些类 UNIX 系统中的一层，终端子系统通常由三层组成：上层提供字符设备接口，下层硬件驱动程序与硬件或伪终端进行交互，中层规则用于实现终端设备共有的行为
* 网络设备实现
  - 虽然 网络设备(network devices) 也会产生字符流，因为它们的异步(asynchronous) 特性是他们不易与其他字符设备在同一接口下集成。网络设备驱动程序会产生很多数据包，经由网络协议到达用户应用程序中。

### IO 模型

* 同步阻塞IO（Blocking IO）默认情况下所有 socket 都是blocking
  - 当用户进程调用 recvfrom 这个系统调用，kernel 就开始 IO 的第一个阶段
    + 准备数据（对于网络IO来说，数据在一开始还没有到达。比如，还没有收到一个完整的 UDP 包。 kernel 就要等待足够的数据到来）。需要等待，也就是说数据被拷贝到操作系统内核缓冲区中需要一个过程
    + 在用户进程这边，整个进程会被阻塞（当然，是进程自己选择的阻塞）。当 kernel 一直等到数据准备好了，会将数据从kernel中拷贝到用户内存，然后kernel返回结果，用户进程才解除 block 的状态，重新运行起来
* 同步非阻塞IO（Non-blocking IO） 非阻塞IO要求socket被设置为NONBLOCK
  - 当用户进程发出read操作时，如果kernel中的数据还没有准备好，那么它并不会block用户进程，而是立刻返回一个error
  - 用户进程判断结果是一个error时，就知道数据还没有准备好，于是可以再次发送read操作
  - kernel中数据准备好了，并且又再次收到了用户进程的system call，就将数据拷贝到了用户内存，然后返回
* IO多路复用（IO Multiplexing|event driven IO） 即经典Reactor设计模式
  - select
	  - 用户进程调用select，整个进程会被block，而同时，kernel会“监视”所有select负责的socket，当任何一个socket中的数据准备好了，select就会返回。这个时候用户进程再调用read操作，将数据从kernel拷贝到用户进程
	  - 特点:通过一种机制一个进程能同时等待多个文件描述符，而这些文件描述符（套接字描述符）其中的任意一个进入读就绪状态，select()函数就可以返回
    + 分3类，writefds、readfds、和exceptfds,直到有描述符就绪（有数据 可读、可写、或者有except），或者超时（timeout指定等待时间，如果立即返回设为null即可），函数返回
    + 当select函数返回后，遍历fdset，来找到就绪的描述符
    + 缺点:单个进程能够监视的文件描述符的数量存在最大限制，在Linux上一般为1024，可以通过修改宏定义甚至重新编译内核的方式提升这一限制，但也会造成效率降低
  - poll
    + 使用一个 pollfd的指针实现:包含了要监视的event和发生的event，不再使用select“参数-值”传递的方式
    + pollfd并没有最大数量限制（数量过大后性能也是会下降）
    + poll返回后，需要轮询pollfd来获取就绪的描述符
    + select和poll都需要在返回后，通过遍历文件描述符来获取已经就绪的socket。事实上，同时连接的大量客户端在一时刻可能只有很少的处于就绪状态，因此随着监视的描述符数量的增长，其效率也会线性下降
  - epoll:使用一个文件描述符管理多个描述符，将用户关系的文件描述符的事件存放到内核的一个事件表中，在用户空间和内核空间的copy只需一次
    + int epoll_create(int size):创建一个epoll的句柄
      * size用来告诉内核这个监听的数目一共有多大,参数size并不是限制了epoll所能监听的描述符最大个数，只是对内核初始分配内部数据结构的一个建议
      * 当创建好epoll句柄后，它就会占用一个fd值，在linux下如果查看/proc/进程id/fd/，是能够看到这个fd的
      * 在使用完epoll后，必须调用close()关闭，否则可能导致fd被耗尽
    + int epoll_ctl(int epfd, int op, int fd, struct epoll_event event):对指定描述符fd执行op操作
      * epfd：是epoll_create()的返回值
      * op：表示op操作，用三个宏来表示：添加EPOLL_CTL_ADD，删除EPOLL_CTL_DEL，修改EPOLL_CTL_MOD。分别添加、删除和修改对fd的监听事件
      * fd：是需要监听的fd（文件描述符）
      * epoll_event：是告诉内核需要监听什么事
    + int epoll_wait(int epfd, struct epoll_event * events, int maxevents, int timeout): 等待epfd上的io事件，最多返回maxevents个事件
      * 参数events用来从内核得到事件的集合，maxevents告之内核这个events有多大，这个maxevents的值不能大于创建epoll_create()时的size，参数timeout是超时时间（毫秒，0会立即返回，-1将不确定，也有说法说是永久阻塞）
      * 该函数返回需要处理的事件数目，如返回0表示已超时
    + 工作模式
      * LT（level trigger）:默认模式 当epoll_wait检测到描述符事件发生并将此事件通知应用程序，应用程序可以不立即处理该事件。下次调用epoll_wait时，会再次响应应用程序并通知此事件(状态保持)
      * ET（edge trigger）:当epoll_wait检测到描述符事件发生并将此事件通知应用程序，应用程序必须立即处理该事件。如果不处理，下次调用epoll_wait时，不会再次响应应用程序并通知此事件（不复现）
        - 很大程度上减少了epoll事件被重复触发的次数，因此效率要比LT模式高
    + 优点
      * 监视的描述符数量不受限制
  - select/poll中，进程只有在调用一定的方法后，内核才对所有监视的文件描述符进行扫描，而epoll事先通过epoll_ctl()来注册一 个文件描述符，一旦基于某个文件描述符就绪时，内核会采用类似callback的回调机制，迅速激活这个文件描述符，当进程调用epoll_wait() 时便得到通知。(此处去掉了遍历文件描述符，而是通过监听回调的的机制。这正是epoll的魅力所在。)
  - 需要使用两个system call (select 和 recvfrom)，而blocking IO只调用了一个system call (recvfrom)。但是，用select的优势在于它可以同时处理多个connection
  - 如果处理的连接数不是很高的话，使用select/epoll的web server不一定比使用multi-threading + blocking IO的web server性能更好，可能延迟还更大。优势并不是对于单个连接能处理得更快，而是在于能处理更多的连接。）
  - 实际中，对于每一个socket，一般都设置成为non-blocking，但是整个用户的process其实是一直被block的。只不过process是被select这个函数block，而不是被socket IO给block
  - events可以是以下几个宏的集合：
    + EPOLLIN ：表示对应的文件描述符可以读（包括对端SOCKET正常关闭）
    + EPOLLOUT：表示对应的文件描述符可以写
    + EPOLLPRI：表示对应的文件描述符有紧急的数据可读（这里应该表示有带外数据到来）
    + EPOLLERR：表示对应的文件描述符发生错误
    + EPOLLHUP：表示对应的文件描述符被挂断
    + EPOLLET： 将EPOLL设为边缘触发(Edge Triggered)模式，这是相对于水平触发(Level Triggered)来说的。
    + EPOLLONESHOT：只监听一次事件，当监听完这次事件之后，如果还需要继续监听这个socket的话，需要再次把这个socket加入到EPOLL队列里
* 信号驱动 I/O（ signal driven IO）
* 异步IO（Asynchronous IO） 经典 Proactor设计模式
  - 用户进程发起read操作之后，立刻就可以开始去做其它的事
  - 另一方面，从kernel的角度，当它受到一个asynchronous read之后，首先它会立刻返回，所以不会对用户进程产生任何block。然后，kernel会等待数据准备完成，然后将数据拷贝到用户内存，当这一切都完成之后，kernel会给用户进程发送一个signal，告诉它read操作完成
* synchronous IO VS asynchronous IO
  - A synchronous I/O operation causes the requesting process to be blocked until that I/O operation completes;
  - An asynchronous I/O operation does not cause the requesting process to be blocked;
* 参考
  - [操作系统 I/O 全流程](https://www.cnblogs.com/cxuanBlog/p/13156493.html)

```sh
# 内存够大，那么可以做一个内存盘
mkdir /memdisk
mount  -t tmpfs -o size=1024m  tmpfs /memdisk/
time dd if=/dev/zero of=test.file bs=4k count=200000

#查看wa
top
#查看wa和io(bi、bo)
vmstat 1
#查看性能相关i/o详情
sar -b 1 2
# 查看问题相关i/o详情
iostat -x 1
# 查看使用i/o最多的进程
iotop
```

```
int select(int n, fd_set *readfds, fd_set *writefds, fd_set *exceptfds,
           struct timeval *timeout);

int poll(struct pollfd *fds, unsigned int nfds, int timeout);
struct pollfd {
  int fd;        /* file descriptor */
  short events;  /* requested events to watch */
  short revents; /* returned events witnessed */
};

int epoll_create(int size) ；
#创建一个epoll的句柄，size用来告诉内核这个监听的数目一共有多大
    int epoll_ctl(int epfd, int op, int fd, struct epoll_event *event) ；
    int epoll_wait(int epfd, struct epoll_event *events, int maxevents,
                   int timeout);

struct epoll_event {
  __uint32_t events; /* Epoll events */
  epoll_data_t data; /* User data variable */
};

while (rs) {
  buflen = recv(activeevents[i].data.fd, buf, sizeof(buf), 0);
  if (buflen < 0) {
    // 由于是非阻塞的模式,所以当errno为EAGAIN时,表示当前缓冲区已无数据可读
    // 在这里就当作是该次事件已处理处.
    if (errno == EAGAIN) {
      break;
    } else {
      return;
    }
  } else if (buflen == 0) {
    // 这里表示对端的socket已正常关闭.
  }
 if(buflen == sizeof(buf){
    rs = 1;  // 需要再次读取
 }
 else{
    rs = 0;
 }
}

#define IPADDRESS "127.0.0.1"
#define PORT 8787
#define MAXSIZE 1024
#define LISTENQ 5
#define FDSIZE 1000
#define EPOLLEVENTS 100
listenfd = socket_bind(IPADDRESS, PORT);
struct epoll_event events[EPOLLEVENTS];
//创建一个描述符
epollfd = epoll_create(FDSIZE);
//添加监听描述符事件
add_event(epollfd, listenfd, EPOLLIN);
//循环等待
for (;;) {
  //该函数返回已经准备好的描述符事件数目
  ret = epoll_wait(epollfd, events, EPOLLEVENTS, -1);
  //处理接收到的连接
  handle_events(epollfd, events, ret, listenfd, buf);
}
//事件处理函数
static void handle_events(int epollfd, struct epoll_event *events, int num,
                          int listenfd, char *buf) {
  int i;
  int fd;
  //进行遍历;这里只要遍历已经准备好的io事件。num并不是当初epoll_create时的FDSIZE。
  for (i = 0; i < num; i++) {
    fd = events[i].data.fd;
    //根据描述符的类型和事件类型进行处理
    if ((fd == listenfd) && (events[i].events & EPOLLIN))
      handle_accpet(epollfd, listenfd);
    else if (events[i].events & EPOLLIN)
      do_read(epollfd, fd, buf);
    else if (events[i].events & EPOLLOUT)
      do_write(epollfd, fd, buf);
  }
}

//添加事件
static void add_event(int epollfd, int fd, int state) {
  struct epoll_event ev;
  ev.events = state;
  ev.data.fd = fd;
  epoll_ctl(epollfd, EPOLL_CTL_ADD, fd, &ev);
}
//处理接收到的连接
static void handle_accpet(int epollfd, int listenfd) {
  int clifd;
  struct sockaddr_in cliaddr;
  socklen_t cliaddrlen;
  clifd = accept(listenfd, (struct sockaddr *)&cliaddr, &cliaddrlen);
  if (clifd == -1)
    perror("accpet error:");
  else {
    printf("accept a new client: %s:%d\n", inet_ntoa(cliaddr.sin_addr),
           cliaddr.sin_port);  //添加一个客户描述符和事件
    add_event(epollfd, clifd, EPOLLIN);
  }
}
//读处理
static void do_read(int epollfd, int fd, char *buf) {
  int nread;
  nread = read(fd, buf, MAXSIZE);
  if (nread == -1) {
    perror("read error:");
    close(fd);                           //记住close fd
    delete_event(epollfd, fd, EPOLLIN);  //删除监听
  } else if (nread == 0) {
    fprintf(stderr, "client close.\n");
    close(fd);                           //记住close fd
    delete_event(epollfd, fd, EPOLLIN);  //删除监听
  } else {
    printf("read message is : %s", buf);
    //修改描述符对应的事件，由读改为写
    modify_event(epollfd, fd, EPOLLOUT);
  }
}
//写处理
static void do_write(int epollfd, int fd, char *buf) {
  int nwrite;
  nwrite = write(fd, buf, strlen(buf));
  if (nwrite == -1) {
    perror("write error:");
    close(fd);                            //记住close fd
    delete_event(epollfd, fd, EPOLLOUT);  //删除监听
  } else {
    modify_event(epollfd, fd, EPOLLIN);
  }
  memset(buf, 0, MAXSIZE);
}
//删除事件
static void delete_event(int epollfd, int fd, int state) {
  struct epoll_event ev;
  ev.events = state;
  ev.data.fd = fd;
  epoll_ctl(epollfd, EPOLL_CTL_DEL, fd, &ev);
}
//修改事件
static void modify_event(int epollfd, int fd, int state) {
  struct epoll_event ev;
  ev.events = state;
  ev.data.fd = fd;
  epoll_ctl(epollfd, EPOLL_CTL_MOD, fd, &ev);
}
```

## 进程 Process

* 程序是一些保存在磁盘上的指令的有序集合,是静态的的一个可执行映像中，可执行映像(executable image)就是一个可执行文件的内容
* 进程会被表示为 任务，通过结构体 structure 来创建，Linux 统一使用任务结构来代表执行上下文。因此，对于每个单线程进程来说，单线程进程将用一个任务结构表示，对于多线程进程来说，将为每一个用户级线程分配一个任务结构。Linux 内核是多线程的，并且内核级线程不与任何用户级线程相关联
* 对于每个进程来说，在内存中都会有一个 task_struct 进程描述符与之对应。进程描述符包含了内核管理进程所有有用的信息，包括 「调度参数、打开文件描述符等等」。进程描述符从进程创建开始就一直存在于内核堆栈中。通过 PID 来区分不同的进程，内核会将所有进程的任务结构组成为一个双向链表。PID 能够直接被映射称为进程的任务结构所在的地址，从而不需要遍历双向链表直接访问
* 进程描述符是存在用户的任务结构中，当进程位于内存并开始运行时，进程描述符才会被调入内存
  - 调度参数(scheduling parameters)：进程优先级、最近消耗 CPU 的时间、最近睡眠时间一起决定了下一个需要运行的进程
  - 内存映像(memory image)：我们上面说到，进程映像是执行程序时所需要的可执行文件，它由数据和代码组成。
  - 信号(signals)：显示哪些信号被捕获、哪些信号被执行
  - 寄存器：当发生内核陷入 (trap) 时，寄存器的内容会被保存下来。
  - 系统调用状态(system call state)：当前系统调用的信息，包括参数和结果
  - 文件描述符表(file descriptor table)：有关文件描述符的系统被调用时，文件描述符作为索引在文件描述符表中定位相关文件的 i-node 数据结构
  - 统计数据(accounting)：记录用户、进程占用系统 CPU 时间表的指针，一些操作系统还保存进程最多占用的 CPU 时间、进程拥有的最大堆栈空间、进程可以消耗的页面数等。
  - 内核堆栈(kernel stack)：进程的内核部分可以使用的固定堆栈
  - 其他：当前进程状态、事件等待时间、距离警报的超时时间、PID、父进程的 PID 以及用户标识符等
* 创建进程流程：为子进程开辟一块新的用户空间的进程描述符，然后从父进程复制大量的内容。为这个子进程分配一个 PID，设置其内存映射，赋予它访问父进程文件的权限，注册并启动
* 进程描述符的主要内容是根据父进程的描述符来填充。Linux 操作系统会寻找一个可用的 PID，并且此 PID 没有被任何进程使用，更新进程标示符使其指向一个新的数据结构即可。为了减少 hash table 的碰撞，进程描述符会形成链表。它还将 task_struct 的字段设置为指向任务数组上相应的上一个/下一个进程
* 进程代表程序执行过程，是一个动态的实体，包括了动态创建、调度和消亡的整个过程,随着程序中指令的执行而不断地变化，在某个时刻进程的内容被称为进程映像(process image),是程序资源管理最小单位
  - 程序执行过程是一个执行环境的总和，除了包括程序中各种指令和数据外，还有一些额外数据
  - 执行环境的动态变化体现了程序的运行，为了对动态变化的过程进行描述，就引入了“进程”概念
  - 处于执行期的程序，包含各种资源，比如文件、信号、内核数据、处理器状态、内存空间、执行线程、全局数据段等。进程提供了虚拟处理器和虚拟内存，看起来进程就像自己独享相应资源
  - 内核将所有进程保存在任务队列中，是一个双向循环链表，该链表中每个节点的类型都是task_struct进程描述符结构
  - 所有进程都是PID为1的init进程的后代，内核启动的最后阶段启动init进程，负责读取系统的初始化脚本并执行其它相关程序
  - 每个进程都有一个父进程，每个进程也都可以有零个或多个子进程
  - fork()用于创建子进程，通过拷贝当前进程来创建一个子进程，父子进程区别在于PID、PPID、某些资源、统计量不同
    + 由操作系统内核实现的系统调用，用于创建当前进程自身一个副本
    + fork()使用了写时拷贝机制，父进程和子进程共享同一个拷贝，只有需要写入时数据才会被复制
      * fork 完成后，子进程和父进程没有共享内存，所以需要复制技术来实现同步，但是复制开销比较大，因此 Linux 操作系统使用了一种 欺骗 方式。即为子进程分配页表，然后新分配的页表指向父进程的页面，同时这些页面是只读的。
      * 当进程向这些页面进行写入的时候，会开启保护错误。内核发现写入操作后，会为进程分配一个副本，使得写入时把数据复制到这个副本上，这个副本是共享的，这种方式称为 写入时复制(copy on write)，这种方式避免了在同一块内存区域维护两个副本的必要，节省内存空间
    + fork()的实际开销:复制父进程的页表以及给子进程创建唯一进程描述符
  - exec()负责读取可执行文件并将其载入空间开始运行
    + 内核会进行查找验证可执行文件，把参数和环境变量复制到内核，释放旧的地址空间
    + 由操作系统内核实现的系统调用，用于在已有进程的上下文中运行一个可执行文件
  - 进程调用exit()系统调用时进程被终结
  - 运行着的程序，每个进程都有着它自己的地址空间，由被允许进程访问的内存地址组成
  - 有一个或多个执行线程，而线程是一系列执行指令的集合
    + 一个进程中的线程共享各种资源，特别是地址空间
    + 一个进程中的线程可以直接通过共享内存来进行通信
  - 不同进程默认情况下不能共享内存
  - 环境变量通常在系统启动时由初始化脚本进行初始化，然后由系统中的所有其他进程继承。同样，当在一个程序中打开另一个程序时，调用程序会先复制一个与自身完全一样的进程，即子进程。子进程可以根据需要修改环境变量。子进程再通过执行被调用的程序来覆盖自己
* 进程控制块：进程的描述结构叫做task_struct，将这样的数据结构称作进程控制块(PCB)
  - PCB是一个其域多达80多项的相当庞大的数据结构，按其功能将所有域划分为：状态信息，链接信息、各种标识符、进程间通信信息、时间和定时器信息、调度信息、文件系统信息、虚拟内存信息和处理器环境信息
  - 组织方式有：进程链表、散列表、可运行队列和等待队列
* 进程切换:内核必须有能力挂起正在CPU上运行的进程，并恢复以前挂起的某个进程的执行
  - 流程
    + 保存处理机上下文，包括程序计数器和其他寄存器
    + 更新PCB信息
    + 把进程的PCB移入相应的队列，如就绪、在某事件阻塞等队列
    + 选择另一个进程执行，并更新其PCB
    + 更新内存管理的数据结构恢复处理机上下文
  - 进程阻塞：正在执行的进程，由于期待的某些事件未发生，如请求系统资源失败、等待某种操作的完成、新数据尚未到达或无新工作做等，则由系统自动执行阻塞原语(Block)，使自己由运行状态变为阻塞状态
* 进程状态
  - 创建状态(new) ：进程正在被创建，尚未到就绪状态。
  - 就绪状态(ready) ：进程已处于准备运行状态，即进程获得了除了处理器之外的一切所需资源，一旦得到处理器资源(处理器分配的时间片)即可运行。
  - 运行状态(running) ：进程正在处理器上上运行(单核CPU下任意时刻只有一个进程处于运行状态)。
  - 阻塞状态(waiting) ：又称为等待状态，进程正在等待某一事件而暂停运行如等待某资源为可用或等待 IO 操作完成。即使处理器空闲，该进程也不能运行。
  - 结束状态(terminated) ：进程正在从系统中消失。可能是进程正常结束或其他原因中断退出运行。
  - 运行态、就绪态和阻塞态(或等待态)
  - 四种可能的转换关系：运行态->阻塞态、运行态->就绪态、就绪态->运行态和阻塞态->就绪态
  - 将就绪态和运行态合并为一个状态—可运行态，再包括其它方面的一些改变，将进程状态划分为：可运行态、睡眠(或等待)态(分为深度睡眠态和浅度睡眠态)、暂停状态和僵死状态
* 调度
  - 目的:最大限度地利用CPU时间，只要有可执行的任务就要尽量去执行，系统中几乎总是任务数大于处理器个数，所以肯定某个时刻有任务得不到执行
  - 多任务系统能并发地执行多个进程，一个CPU时是一对多，多个CPU时是多对多，所有任务看起来就像是同时在运行一样
  - 多任务系统分为抢占式和非抢占式
    + linux是抢占式调度，调度程序来决定进程的挂起和执行，每个进程能执行的时间为时间片，现代系统一般都有一定的策略来动态分配时间片
    + 非抢占式则是由进程自己主动停止，否则将一直运行下去，调度程序无法决定进程的运行停止，如果某个进程一直运行则会使系统奔溃
  - 调度策略
    + 进程分类
      * I/O密集型大部分时间进行各种I/O请求，通常这些进程只运行很短一段时间，然后就在I/O上阻塞了。
      * 处理器密集型则是大部分时间都用于代码执行上，不停地运行而且没有什么I/O请求。当然有些进程既是I/O密集型也是处理器密集型。对于前者我们希望时间片少一点，对于后者我们希望时间片多一点，调度策略就是要在两个矛盾中找到平衡，使得进程能够响应迅速又能最大系统利用率。
    + 优先级调度算法(非抢占式优先级算法和抢占式优先级算法)是最基本的一种调度算法，它把进程进行了分级，优先级高的先运行，优先级低的后运行，相同优先级的进程则轮流运行。某些系统中优先级高的进程将更频繁运行，且时间片也更长。调度程序选择时间片未用尽且优先级最高的进程来执行。linux有两种优先级范围，第一种是nice值，从-20到+19，默认为0，值越大优先级越低。第二种是实时优先级，默认范围是0到99，值越高表示优先级越高。任何实时进程的优先级都高于普通进程，也就是说nice优先级和实时优先级是两个不同维度
    + 时间片轮转调度算法是进程在被抢占前所能持续运行的时间，默认的时间片大小不容易确定，时间片太长会使交互响应变差，时间片太短会增加进程切换带来的损耗。也就是前面说到的矛盾，I/O密集型希望时间片短点，而处理器密集型则希望时间片长点。
    + linux采用了完全公平调度（CFS）算法，它是一个针对普通进程的调度器，linux中称为SCHED_NORMAL，而POSIX则称为SCHED_OTHRER，实现类在kernel/sched_fair.c中。CFS允许每个进程运行一段时间、循环轮转、选择运行最少的进程作为待运行进程，CFS计算所有可运行进程总数作为基础，再计算一个进程应该运行多久，而不是靠优先级来计算时间片。CFS有一个最小时间片（最小粒度），默认是1ms。也就是说就算有无穷大个进程，每个进程最少也能有1ms时间片。CFS确保给每个进程公平的处理器使用比。
      * CFS不再简单使用时间片的概念，而是必须要维护每个进程运行的时间记账，以此确保每个进程公平分配。
      * CFS选择下一个待运行进程时它会挑一个具有最小运行时间的进程。
      * 睡眠（被阻塞）的进程处于不可执行状态，它将从可执行红黑树中移除，放到等待队列中。等待队列是简单链表结构，
      * 唤醒，与睡眠刚好相反，进程被设置为可执行状态，并且从等待队列中移到可执行红黑树中。
      * 上下文切换，即从一个可执行线程切换到另一个可执行进程，由kernel/sched.c的context_switch函数负责。将虚拟内存从上一个进程映射到新进程，保存恢复栈信息和寄存器信息以及其它相关信息。
      * 内核提供了need_resched标志来表明是否需要重新执行一次调度，内核无论是咋中断处理程序还是在系统调用后返回都会检查这个歌表示，如果被设置了则内核会选择一个更适合的进程投入运行。
    + 多级反馈队列调度算法
    + 实时调度算法：linux提供了两种实时调度策略：`SCHED_FIFO`和`SCHED_RR`
      * 前者是一种简单的先入先出调度算法，它不使用时间片。处于`SCHED_FIFO`级别的进程会比任何`SCHED_NORMAL`级别的进程先得到调度。一旦某个SCHED_FIFO级别的进程处于可执行状态，它将会一直执行，直到它自己阻塞或显示释放CPU。只有更高优先级的SCHED_FIFO或SCHED_RR进程才能抢占它。两个相同优先级的SCHED_FIFO级别的进程会轮流执行，其它普通进程只能等它变为不可运行状态后才有机会执行。
      * SCHED_RR大致与SCHED_FIFO相同，但它是耗尽事先分配的时间后就不再继续执行，即SCHED_RR是带了时间片的SCHED_FIFO。时间片只是相对于同一优先级的进程，低优先级的进程无法抢占SCHED_RR任务，即使它的时间片耗尽也不行。
    + 考虑因素：考虑五个方面：公平、高效、响应时间、周转时间和吞吐量
* 为了保证用户进程不能直接操作内核（kernel），保证内核安全，操心系统将虚拟空间划分为两部分
  - Linux的虚拟地址空间的大小为4GB，内核将这4GB的空间分为两部分
  - 内核空间:较高的1GB(虚地址0xC0000000到0xFFFFFFFF)供内核使用
  - 用户空间:较低的3GB(虚地址0x00000000到0xBFFFFFFF)供各个进程使用
  - 每个进程可以通过系统调用进入内核，内核空间由系统内的所有进程共享.从具体进程的角度来看，每个进程都可以拥有4GB的虚拟地址空间(也叫做虚拟内存)
* CPU活动状态
  - 运行于用户空间，执行用户进程
  - 运行于内核空间，处于进程上下文，表示执行某个进程
  - 运行于内核空间，处于中断上下文，此时与任务进程都无关，它在处理某个中断
* 放弃处理器时间linux通过sched_yield()系统调用来放弃当前进程的处理器时间，让给其他待执行进行，对于实时进程，它会将进程从活动队列中移到其优先级队列的后面。早期linux的yield语义不一样，只会将进程放到优先级队列的末尾，放弃的时间不会太长
* 文件描述符fd：用于表述指向文件的引用的抽象化概念，形式上是一个非负整数
  - 实际上是一个索引值，指向内核为每一个进程所维护的该进程打开文件的记录表
  - 当程序打开一个现有文件或者创建一个新文件时，内核向进程返回一个文件描述符
* pid 为 1 的 /sbin/init 进程
  - 负责执行内核的一部分初始化工作和系统配置，也会创建一些类似 getty 的注册进程
* pid 为 2 的 kthreadd 进程
  - 负责管理和调度其他的内核进程
* 工具
  - ps (process status)：report a snapshot of the current processes，PID ( Process IDentity )，pid唯一标识一个进程
    - `ps -ef | grep intresting`
    - `ps aux`
    + `ps -p 98`
  - `top` show information about Linux processes running on the system in real time
  - [strace](http://man7.org/linux/man-pages/man1/strace.1.html): trace system calls and signals 跟踪进程内部的系统调用和信号 `strace  -c ./tiem_test`
    + 系统调用（system call）:指运行在「用户态」的程序向操作系统「内核态」请求需要更高权限运行的服务，系统调用提供用户程序与操作系统之间的接口
    + strace后面跟着启动一个进程，可以跟踪启动后进程的系统调用和信号，这个命令可以看到进程执行时候都调用了哪些系统调用，通过指定不同的选项可以输出系统调用发生的时间，精度可以精确到微秒，甚至还可以统计分析系统「调用的耗时」，这在排查进程假死问题的时候很有用，能帮你发现进程卡在哪个系统调用上
  - pstack: print a stack trace of a running process 打印出运行中程序的堆栈信息,可以看到进程内启动的线程号，每个进程内线程的「堆栈」内容也能看到  `pstack pid`
    + LPW是指Light-weight process 轻量级线程:Linux中没有真正的线程
    + Linux中没有的线程Thread是由进程来模拟实现的所以称作：轻量级进程
    + 进程是「资源管理」的最小单元，线程是「资源调度」的最小单元（这里不考虑协程）
  - pstree: display a tree of processes pstree按树形结构打印运行中进程结构信息 `pstree -p 11811`
  - procps
  - gdb是GNU开发的gcc套件中Linux下程序调试工具，可以查看程序的堆栈、设置断点、打印程序运行时信息，甚至还能调试多线程程序，功能十分强大.
    + 调试C/C++程序首先编译的时候要加-g选项
    + 可以直接用gdb启动程序调试，命令：gdb prog
    + 用gdb附着到一个已经启动的进程上调试也可以。命令：gdb prog pid
    + 程序崩溃之后参数corefile也可以用gdb调试，看看程序死掉之前留了什么遗言（堆栈信息）给你。命令：gdb prog corefile，这里有一点需要注意，有些Linux系统默认程序崩溃不生成corefile，这时你需要ulimit -c unlimited这样就能生成corefile了。
* 通过/proc/pid文件了解进程的运行时信息和统计信息。/proc系统是一个伪文件系统，它只存在内存当中，而不占用外存空间，以文件系统的方式为内核与进程提供通信的接口
  - /proc目录下有很多以数字命名的目录，每个数字代表进程号PID它们是进程目录。系统中当前运行的每一个进程在/proc下都对应一个以进程号为目录名的目录/proc/pid，它们是读取进程信息的接口，可以进到这个文件里面，了解进程的运行时信息和统计信息
  - /proc/pid/environ 包含了进程的可用环境变量的列表 。程序出问题了如果不确定环境变量是否设置生效，可以cat这个文件出来查看确认一下
  - /proc/pid/fd/ 这个目录包含了进程打开的每一个文件的链接。从这里可以查看进程打开的文件描述符信息，包括标准输入、输出、错误流，进程打开的socket连接文件描述符也能看到，lsof命令也有类似的作用
  - /proc/pid/stat包含了进程的所有状态信息，进程号、父进程号、 线程组号、 该任务在用户态运行的时间 、 该任务在用内核态运行的时间、 虚拟地址空间的代码段、 阻塞信号的位图等等信息应有尽有
  - /proc/pid/cmdline 该文件保存了进程的完整命令行
  - /proc/pid/cwd一个符号连接, 指向进程当前的工作目录
  - /proc/pid/exe包含了正在进程中运行的程序链接
  - /proc/pid/mem包含了进程在内存中的内容
  - /proc/pid/statm包含了进程的内存使用信息
* 遇到问题（崩溃coredump、假死、阻塞、系统调用超时、文件描述符异常）
  - ps查看进程id，看看进程还在不在以及进程状态
  - 如果在的话strace、psstack看下进程当前信息，是不是卡死在哪个位置，对比各帧最后调用信息找到异常点
  - 如果进程不再了，如果有corefile文件，直接上gdb查看corefile信息
  - 其他疑难杂症怀疑进程状态信息的时候，看看/proc/pid下面的进程状态信息，可能会给你启发
* 参考
  - [进程和线程基础知识全家桶](https://mp.weixin.qq.com/s/HFscrp3jsu_Cz52cGqm73A)
  - [参透并发编程](https://mp.weixin.qq.com/s/-PRq4ChaCkEFB_DJyyKhvg)
* 孤儿进程、僵尸进程和守护进程
* fork返回值
* Reactor和Proactor模式

![进程示例](../_static/process_flow.png "Optional title")

```c
// 生产者
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#define FileName "data.dat"
#define DataString "Now is the winter of our discontent\nMade glorious summer by this sun of York\n"
void report_and_exit(const char* msg) {
  perror(msg);
  exit(-1); /* EXIT_FAILURE */
}
int main() {
  struct flock lock;
  lock.l_type = F_WRLCK;    /* read/write (exclusive versus shared) lock */
  lock.l_whence = SEEK_SET; /* base for seek offsets */
  lock.l_start = 0;         /* 1st byte in file */
  lock.l_len = 0;           /* 0 here means 'until EOF' */
  lock.l_pid = getpid();    /* process id */
  int fd; /* file descriptor to identify a file within a process */
  if ((fd = open(FileName, O_RDWR | O_CREAT, 0666)) < 0)  /* -1 signals an error */
    report_and_exit("open failed...");
  if (fcntl(fd, F_SETLK, &lock) < 0) /** F_SETLK doesn't block, F_SETLKW does **/
    report_and_exit("fcntl failed to get lock...");
  else {
    write(fd, DataString, strlen(DataString)); /* populate data file */
    fprintf(stderr, "Process %d has written to data file...\n", lock.l_pid);
  }
  /* Now release the lock explicitly. */
  lock.l_type = F_UNLCK;
  if (fcntl(fd, F_SETLK, &lock) < 0)
    report_and_exit("explicit unlocking failed...");
  close(fd); /* close the file: would unlock if needed */
  return 0;  /* terminating the process would unlock as well */
}

// 消费者程序
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#define FileName "data.dat"
void report_and_exit(const char* msg) {
  perror(msg);
  exit(-1); /* EXIT_FAILURE */
}
int main() {
  struct flock lock;
  lock.l_type = F_WRLCK;    /* read/write (exclusive) lock */
  lock.l_whence = SEEK_SET; /* base for seek offsets */
  lock.l_start = 0;         /* 1st byte in file */
  lock.l_len = 0;           /* 0 here means 'until EOF' */
  lock.l_pid = getpid();    /* process id */
  int fd; /* file descriptor to identify a file within a process */
  if ((fd = open(FileName, O_RDONLY)) < 0)  /* -1 signals an error */
    report_and_exit("open to read failed...");
  /* If the file is write-locked, we can't continue. */
  fcntl(fd, F_GETLK, &lock); /* sets lock.l_type to F_UNLCK if no write lock */
  if (lock.l_type != F_UNLCK)
    report_and_exit("file is still write locked...");
  lock.l_type = F_RDLCK; /* prevents any writing during the reading */
  if (fcntl(fd, F_SETLK, &lock) < 0)
    report_and_exit("can't get a read-only lock...");
  /* Read the bytes (they happen to be ASCII codes) one at a time. */
  int c; /* buffer for read bytes */
  while (read(fd, &c, 1) > 0)    /* 0 signals EOF */
    write(STDOUT_FILENO, &c, 1); /* write one byte to the standard output */
  /* Release the lock explicitly. */
  lock.l_type = F_UNLCK;
  if (fcntl(fd, F_SETLK, &lock) < 0)
    report_and_exit("explicit unlocking failed...");
  close(fd);
  return 0;
}
```

### 进程间通信 Inter-Process Communication IPC

* 共享文件 file
  - 生产者应该在写入文件时获得一个文件的排斥锁。一个排斥锁最多被一个进程所拥有。这样就可以排除掉竞争条件的发生，因为在锁被释放之前没有其他的进程可以访问这个文件
  - 消费者应该在从文件中读取内容时得到至少一个共享锁。多个读取者可以同时保有一个共享锁，但是没有写入者可以获取到文件内容，甚至在当只有一个读取者保有一个共享锁时。
  - 标准的 I/O 库中包含一个名为 fcntl 的实用函数，它可以被用来检查或者操作一个文件上的排斥锁和共享锁。该函数通过一个文件描述符（一个在进程中的非负整数值）来标记一个文件（在不同的进程中不同的文件描述符可能标记同一个物理文件）。对于文件的锁定， Linux 提供了名为 flock 的库函数，它是 fcntl 的一个精简包装
  - 竞争条件：生产者和消费者可能恰好在同一时间访问该文件，从而使得输出结果不确定。为了避免竞争条件的发生，该文件在处于读或写状态时必须以某种方式处于被锁状态，从而阻止在写操作执行时和其他操作的冲突
    + 生产者应该在写入文件时获得一个文件的排斥锁。一个排斥锁最多被一个进程所拥有。这样就可以排除掉竞争条件的发生，因为在锁被释放之前没有其他的进程可以访问这个文件。
    + 消费者应该在从文件中读取内容时得到至少一个共享锁。多个读取者可以同时保有一个共享锁，但是没有写入者可以获取到文件内容，甚至在当只有一个读取者保有一个共享锁时。共享锁可以提升效率
  - 标准的 I/O 库中包含一个名为 fcntl 的实用函数，它可以被用来检查或者操作一个文件上的排斥锁和共享锁,该函数通过一个文件描述符（一个在进程中的非负整数值）来标记一个文件（在不同的进程中不同的文件描述符可能标记同一个物理文件）
  - 对于文件的锁定， Linux 提供了名为 flock 的库函数，它是 fcntl 的一个精简包装。
  - 内容还可以是纷繁复杂的，任意的字节数据（例如一个电影）都可以
* 共享内存（使用信号量）shared memory
  - Linux 系统提供了两类不同的 API：传统的 System V API 和更新一点的 POSIX API,在单个应用中，这些 API 不能混用.POSIX 方式的一个坏处是它的特性仍在发展中，并且依赖于安装的内核版本，这非常影响代码的可移植性
  - 流程
    + 创建共享内存段或者使用已创建的共享内存段(shmget())
    + 将进程附加到已经创建的内存段中(shmat())
    + 从已连接的共享内存段分离进程(shmdt())
    + 对共享内存段执行控制操作(shmctl())
  - 信号量:调整对共享内存的获取。在任何时候当共享内存进入一个写入者场景时，无论是多进程还是多线程，都有遇到基于内存的竞争条件的风险，所以，需要引入信号量来协调（同步）对共享内存的获取
    + 信号量机制：为了防止冲突，得有个约束或者说一种保护机制。使得同一份共享的资源只能一个进程使用
    + 实际上是一个计数器，主要实现进程之间的同步和互斥，定义了两种操作
      * p操作为申请资源，会将数值减去M，表示这部分被他使用了，其他进程暂时不能用
      * v操作是归还资源操作，告知归还了资源可以用这部分
    + 一般的信号量也被叫做一个计数信号量，因为带有一个可以增加的值（通常初始化为 0）
    + 同步机制
      * 考虑一家租用自行车的商店，在它的库存中有 100 辆自行车，还有一个供职员用于租赁的程序。每当一辆自行车被租出去，信号量就增加 1；当一辆自行车被还回来，信号量就减 1。在信号量的值为 100 之前都还可以进行租赁业务，但如果等于 100 时，就必须停止业务，直到至少有一辆自行车被还回来，从而信号量减为 99。
      * 二元信号量是一个特例，它只有两个值：0 和 1。在这种情况下，信号量的表现为互斥量（一个互斥的构造）。
    + 不同信号用不同的值表示，每个信号设置相应的函数，一旦进程发送某一个信号给另一个进程，另一进程将执行相应的函数进行处理。也就是说先把可能出现的异常等问题准备好，一旦信号产生就执行相应的逻辑即可
  - 主要着重点都在 shm_open 和 mmap 函数上：在成功时，写调用返回一个备份文件的文件描述符，而读调用则使用这个文件描述符从共享内存段中获取一个指针
  - 每个进程都有自己的虚拟内存空间，不同进程映射到不同物理内存空间.申请一块虚拟地址空间，不同进程通过这块虚拟地址空间映射到相同的物理地址空间
  - 通过shmget创建一份共享内存，并可以通过`ipcs`命令查看创建的共享内存
  - 此时如果一个进程需要访问这段内存，需要将这个内存加载到自己虚拟地址空间的一个位置，让内核给它一个合法地址。使用完毕接触板顶并删除内存对象
  - 会出现写冲突
* 管道 pipe:拥有一个写端用于写入字节数据，还有一个读端用于按照先入先出的顺序读入这些字节数据
  - 在两个进程之间，可以建立一个通道，一个进程向这个通道里写入字节流，另一个进程从这个管道中读取字节流。管道是同步的
  - Names Pipes 命名管道|FIFO，因为第一个进入的字节，就会第一个出.一个可信且高效,双向传输，可以考虑使用两个管道拼接即可
    + `mkfifo test`:可通过 `ls -s` 查到,会"p"标识
    + `echo "666" > test`
    + `cat < test`
  - 匿名管道：`netstat -nlp | grep xxx` "|"前面部分作为"|"后面的输入，很明显是单向传输，自行创建和销毁,前后程序以不同的进程执行
    + 前面为写入方，后面为读取方，默认情况下，读取方将会阻塞，直到从通道中能够读取到字节数据，而写入方在写完它的字节数据后，将发送 流已终止end-of-stream的标志。
    + cat test.dat | sort | uniq
    + fork 调用成功，则它将创建一个新的子进程，向父进程返回一个值，向子进程返回另外的一个值。在调用 fork 后父进程和子进程都将执行相同的代码。（子进程继承了到此为止父进程中声明的所有变量的拷贝）
      * 向子进程返回 0
      * 向父进程返回子进程的进程 ID
  - 未命名的管道没有备份文件：操作系统负责维护内存中的缓冲区，用来将字节从写入器传输到读取器。一旦写入或者输出终止的话，缓冲区将被回收，传输的数据会丢失。相比之下，命名管道具有支持文件和独特 API ，命名管道在文件系统中作为设备的专用文件存在。当所有的进程通信完成后，命名管道将保留在文件系统中以备后用
  + 缺点:A进程将数据写入管道，B进程需要等待A进程将信息写完以后才能读出来
  - 优点:简单
* 消息队列 Message Queue
  - 消息队列是用来描述内核寻址空间内的内部链接列表
  - 每个消息队列由 IPC 标识符唯一标识。消息队列有两种模式，一种是严格模式， 严格模式就像是 FIFO 先入先出队列似的，消息顺序发送，顺序读取。还有一种模式是 非严格模式，消息的顺序性不是非常重要。
  - 一系列的消息，每个消息包含两部分 msg
    + 荷载，一个字节序列（在 C 中是 char）
    + 类型，以一个正整数值的形式给定，类型用来分类消息，为了更灵活的回收
  - 在发送数据的时候，按照一个个独立单元(消息体)进行发送，其中每个消息体规定大小块，同时发送方和接收方约定好消息类型或者正文的格式
  - 在管道中，其大小受限且只能承载无格式字节流的方式，而消息队列允许不同进程以消息队列的形式发送给任意的进程
* 套接字 UNIX Domain Socket
  - 不需要经过网络协议栈，不需要打包拆包、计算校验和、维护序号和应答等，只是将应用层数据从一个进程拷贝到另一个进程
  - 用于同一台主机上两个没有亲缘关系的进程，并且是全双工的，提供可靠消息传递（消息不丢失、不重复、不错乱）的IPC机制
  - 需要来自诸如TCP（传输控制协议）或较低级别UDP（用户数据报协议）等基础协议的支持
  - 分类
    + 顺序包套接字(Sequential Packet Socket)：此类套接字为最大长度固定的数据报提供可靠的连接。此连接是双向的并且是顺序的。
    + 数据报套接字(Datagram Socket)：数据包套接字支持双向数据流。数据包套接字接受消息的顺序与发送者可能不同。
    + 流式套接字(Stream Socket)：流套接字的工作方式类似于电话对话，提供双向可靠的数据流。
    + 原始套接字(Raw Socket)：可以使用原始套接字访问基础通信协议。
  - 跨机器：在应用服务器上部署一个local-proxy；应用与local-proxy之间使用UNIX Domain Socket来通讯；local-proxy与后端服务进行TCP长连接通讯
* 信号 signal
  - 一种软件中断，使用 UNIX 提供的信号机制执行进程间通信。当一个进程接收到信号时，它会停止执行、处理该信号并基于信号传递的信息来改变其执行
  - 通过向一个或多个进程发送异步事件信号来实现，信号可以从键盘或者访问不存在的位置等地方产生；信号通过 shell 将任务发送给子进程。
  - 进程可以选择忽略发送过来的信号，但是有两个是不能忽略的：SIGSTOP 和 SIGKILL 信号
  - SIGSTOP 信号会通知当前正在运行的进程执行关闭操作，会让进程暂停。在终端中，键入 Ctrl-Z 会让 shell 发送 SIGTSTP 信号
    + 命令中 & 后缀可以让命令在直接在后台运行，这使得您可以直接在 shell 中继续做其他操作，不过它此时还是会使用 shell 的标准输出
    + 使用 fg 或 bg 命令恢复暂停工作。它们分别表示在前台继续或在后台继续
    + jobs 命令会列出当前终端会话中尚未完成的全部任务
    + 使用百分号 + 任务编号（jobs 会打印任务编号）来选取该任务
    + 选择最近的一个任务，可以使用 $! 这一特殊参数
    + 后台的进程仍然是终端进程的子进程，一旦关闭终端（会发送另外一个信号SIGHUP），这些后台的进程也会终止
    + 使用 nohup (一个用来忽略 SIGHUP 的封装) 来运行程序
  - SIGKILL 信号会通知当前进程应该被杀死
  - SIGABRT 和 SIGIOT 信号发送给进程，告诉其进行终止，这个 信号通常在调用 C标准库的abort()函数时由进程本身启动
  - 当设置的时钟功能超时时会将 SIGALRM 、 SIGVTALRM、SIGPROF 发送给进程。当实际时间或时钟时间超时时，发送 SIGALRM。当进程使用的 CPU 时间超时时，将发送 SIGVTALRM。当进程和系统代表进程使用的CPU 时间超时时，将发送 SIGPROF
  - SIGBUS 将造成总线中断错误时发送给进程
  - 当子进程终止、被中断或者被中断恢复，将 SIGCHLD 发送给进程。此信号的一种常见用法是指示操作系统在子进程终止后清除其使用的资源。
  - SIGCONT 信号指示操作系统继续执行先前由 SIGSTOP 或 SIGTSTP 信号暂停的进程。该信号的一个重要用途是在 Unix shell 中的作业控制中
  - SIGFPE 信号在执行错误的算术运算（例如除以零）时将被发送到进程
  - 当 SIGUP 信号控制的终端关闭时，会发送给进程。许多守护程序将重新加载其配置文件并重新打开其日志文件，而不是在收到此信号时退出。
  - SIGILL 信号在尝试执行非法、格式错误、未知或者特权指令时发出
  - 当用户希望中断进程时，操作系统会向进程发送 SIGINT 信号。用户输入 ctrl - c 就是希望中断进程
  - SIGKILL 信号发送到进程以使其马上进行终止。与 SIGTERM 和 SIGINT 相比，这个信号无法捕获和忽略执行，并且进程在接收到此信号后无法执行任何清理操作
    + 僵尸进程无法杀死，因为僵尸进程已经死了，它在等待父进程对其进行捕获
    + 处于阻塞状态的进程只有再次唤醒后才会被 kill 掉
    + init 进程是 Linux 的初始化进程，这个进程会忽略任何信号
    + SIGKILL 通常是作为最后杀死进程的信号、它通常作用于 SIGTERM 没有响应时发送给进程。
  - SIGPIPE 尝试写入进程管道时发现管道未连接无法写入时发送到进程
  - SIGTERM 则是一个更加通用的、也更加优雅地退出信号。发出这个信号使用 kill 命令,语法：`kill -TERM <PID>`

```sh
sleep 1000
^Z
[1]  + 18653 suspended  sleep 1000

 nohup sleep 2000 &
[2] 18745
appending output to nohup.out

$ jobs
[1]  + suspended  sleep 1000
[2]  - running    nohup sleep 2000

$ bg %1
[1]  - 18653 continued  sleep 1000

$ jobs
[1]  - running    sleep 1000
[2]  + running    nohup sleep 2000

$ kill -STOP %1
[1]  + 18653 suspended (signal)  sleep 1000

$ jobs
[1]  + suspended (signal)  sleep 1000
[2]  - running    nohup sleep 2000

$ kill -SIGHUP %1
[1]  + 18653 hangup     sleep 1000

$ jobs
[2]  + running    nohup sleep 2000

$ kill -SIGHUP %2

$ jobs
[2]  + running    nohup sleep 2000

$ kill %2
[2]  + 18745 terminated  nohup sleep 2000

$ jobs
```

### 信号

* kill 可将指定的信息送至程序。预设的信息为 SIGTERM (15), 可将指定程序终止
* 若仍无法终止该程序，可使用 SIGKILL (9) 信息尝试强制删除程序，即 kill -9.可以无条件终止进程，其他信号进程都有权利忽略
  - HUP     1    终端断线
  - INT     2    中断（同 Ctrl + C）
  - QUIT    3    退出（同 Ctrl + \）
  - TERM   15    终止
  - KILL    9    强制终止
  - CONT   18    继续（与 STOP 相反， fg/bg 命令）
  - STOP   19    暂停（同 Ctrl + Z）
* 信号
  - SIGTERM: 向主进程 / 管理进程发送此信号服务器将安全终止
  - 在 PHP 代码中可以调用 $serv->shutdown() 完成此操作
  - SIGUSR1: 向主进程/管理进程发送 SIGUSR1 信号，将平稳地 restart 所有 Worker 进程
  - SIGUSR2: 向主进程/管理进程发送 SIGUSR2 信号，将平稳地重启所有 Task 进程

## 线程 Thread

* 线程是进程的活动对象，每个线程都拥有独立的程序计数器、进程栈和一组寄存器。操作操作系统能够进行运算调度的最小单位
  - 线程能在同一程序里面共享内存地址空间，共享文件和其它资源
  - 从内核角度来说linux并没有线程这个概念，它将线程当成是进程来看待
  - 内核线程没有独立的地址空间，只运行在内核空间，从不切换到用户空间
* 并没有为线程准备特定的数据结构，因为 Linux只有task_struct这一种描述进程的结构体。在内核看来只有进程而没有线程，线程调度时也是当做进程来调度的。Linux所谓的线程其实是与其他进程共享资源的轻量级进程
* 内核级线程
  - 通常使用几个进程表在内核中实现，每个任务都会对应一个进程表。在这种情况下，内核会在每个进程的时间片内调度每个线程
  - 所有能够阻塞的调用都会通过系统调用的方式来实现，当一个线程阻塞时，内核可以进行选择，是运行在同一个进程中的另一个线程（如果有就绪线程的话）还是运行一个另一个进程中的线程
* 轻量级线程 Light-weight Process LWP ：一种由内核支持的用户线程，每一个轻量级进程都与一个特定的内核线程关联
  - 进程切换都需要清除所有的表、进程间的共享信息也比较麻烦，一般来说通过管道或者共享内存，如果是 fork 函数后的父子进程则使用共享文件
  - 线程切换不需要像进程一样具有昂贵的开销，而且线程通信起来也更方便
* 用户级线程
  - 避免使用内核，比内核线程快很多
  - 有一个问题，即单个线程可能会垄断 CPU 时间片，导致其他线程无法执行从而 饿死。如果执行一个 I/O 操作，那么 I/O 会阻塞，其他线程也无法运行
    + 使用时钟周期的监视器来控制第一时间时间片独占
  - 基于内核线程的高级抽象，系统只有先支持内核线程才能有 LWP
  - 每一个进程有一个或多个 LWPs ，每个LWP 由一个内核线程支持，在这种实现的操作系统中 LWP 就是用户线程
  - 查看 LWP 信息 `pstack pid`
* 线程是被内核所调度，线程被调度切换到另一个线程上下文的时候，需要保存一个用户线程的状态到内存，恢复另一个线程状态到寄存器，然后更新调度器的数据结构，这几步操作设计用户态到内核态转换，开销比较多
* 线程跟核心数关系
* 混合实现：将用户级线程与某些或者全部内核线程多路复用起来

### 线程同步机制

* 互斥量
* 信号量
* 锁机制
* 条件变量
* 读写锁

## 协程

* 协程出现给高并发和 IO 密集型服务开发提供了另一种选择
* 一种比线程更加轻量级的微线程
  - 调度开销:完全由用户控制，协程拥有自己的寄存器上下文和栈，协程调度切换时，将寄存器上下文和栈保存到其他地方，在切回来的时候，恢复先前保存的寄存器上下文和栈，直接操作用户空间栈，完全没有内核切换的开销
  - 栈大小可以动态伸缩

## 调度

* 系统会给每个线程分配一个 nice 值，这个值代表了优先级的概念。nice 值默认值是 0 ，但是可以通过系统调用 nice 值来修改。修改值的范围从 -20 - +19。nice 值决定了线程的静态优先级。一般系统管理员的 nice 值会比一般线程的优先级高，它的范围是 -20 - -1
* 分类
  - 实时先入先出
    + 具有最高优先级，它不会被其他线程所抢占，除非那是一个刚刚准备好的，拥有更高优先级的线程进入
  - 实时轮询
    + 与实时先入先出线程基本相同，只是每个实时轮转线程都有一个时间量，时间到了之后就可以被抢占。如果多个实时线程准备完毕，那么每个线程运行它时间量所规定的时间，然后插入到实时轮转线程末尾
  - 分时
* Linux O(1) 调度器
  - 2.6 内核版本的调度器。这个名字的由来是因为能够在常数时间内执行任务调度。在 O(1) 调度器里，调度队列被组织成两个数组，一个是任务「正在活动」的数组，一个是任务「过期失效」的数组
  - 调度器从正在活动数组中选择一个优先级最高的任务。如果这个任务的时间片过期失效了，就把它移动到过期失效数组中。如果这个任务阻塞了，比如说正在等待 I/O 事件，那么在它的时间片过期失效之前，一旦 I/O 操作完成，那么这个任务将会继续运行，它将被放回到之前正在活动的数组中，因为这个任务之前已经消耗一部分 CPU 时间片，所以它将运行剩下的时间片。
  - 当这个任务运行完它的时间片后，它就会被放到过期失效数组中。一旦正在活动的任务数组中没有其他任务后，调度器将会交换指针，使得正在活动的数组变为过期失效数组，过期失效数组变为正在活动的数组。使用这种方式可以保证每个优先级的任务都能够得到执行，不会导致线程饥饿。
  - 不同优先级的任务所得到 CPU 分配的时间片也是不同的，高优先级进程往往能得到较长的时间片，低优先级的任务得到较少的时间片
  - 为了保证能够更好的提供服务，通常会为 交互式进程 赋予较高的优先级，交互式进程就是用户进程
    + 系统会区分是静态优先级 还是 动态优先级
    + 动态优先级是采用一种奖励机制来实现的。奖励机制有两种方式：「奖励交互式线程、惩罚占用 CPU 的线程」
    + 在 Linux O(1) 调度器中，最高的优先级奖励是 -5，注意这个优先级越低越容易被线程调度器接受，所以最高惩罚的优先级是 +5。具体体现就是操作系统维护一个名为 sleep_avg 的变量，任务唤醒会增加 sleep_avg 变量的值，当任务被抢占或者时间量过期会减少这个变量的值，反映在奖励机制上。
  - 使用启发式的这种方式，会使任务的优先级变得复杂并且不完善，从而导致在处理交互任务时性能很糟糕
* 公平调度器 Completely Fair Scheduler, CFS
  - 使用一颗红黑树作为调度队列
  - CFS 算法总是优先调度哪些使用 CPU 时间最少的任务。最小的任务一般都是在最左边的位置。当有一个新的任务需要运行时，CFS 会把这个任务和最左边的数值进行对比，如果此任务具有最小时间值，那么它将进行运行，否则它会进行比较，找到合适的位置进行插入。然后 CPU 运行红黑树上当前比较的最左边的任务。
  - 在红黑树中选择一个节点来运行的时间可以是常数时间，但是插入一个任务的时间是 O(loog(N))，其中 N 是系统中的任务数。考虑到当前系统的负载水平，这是可以接受的。
  - 调度器只需要考虑可运行的任务即可。这些任务被放在适当的调度队列中。不可运行的任务和正在等待的各种 I/O 操作或内核事件的任务被放入一个等待队列中。等待队列头包含一个指向任务链表的指针和一个自旋锁。自旋锁对于并发处理场景下用处很大。

## [文件系统 File System Organization](https://refspecs.linuxfoundation.org/FHS_3.0/fhs/index.html)

* 一个典型 Linux 文件系统
  - bootfs(boot file system) 
	  - bootloader 主要用于引导加载 kernel
	  -  kernel 当 kernel 被加载到内存中后 bootfs 会被 umount 掉
  - rootfs (root file system) 包含典型 Linux 系统中的/dev，/proc，/bin，/etc 等标准目录和文件,不同的 linux 发行版在 rootfs 这一层会有所区别，体现发行版本的差异性
+ 传统的 Linux 加载 bootfs 时会先将 rootfs 设为 read-only，然后在系统自检之后将 rootfs 从 read-only 改为 read-write，然后就可在 rootfs 上进行读写操作了
* 磁盘分区和目录关系
  - 目录是逻辑上的区分,分区是物理上的区分
  - 磁盘分区都必须挂载到目录树中的某个具体目录上才能进行读写操作,根目录是所有Linux的文件和目录所在地方，需要挂载上一个磁盘分区
* 文件结构是文件存放在磁盘等存贮设备上的组织方法,主要体现在对文件和目录的组织上
* 文件是一个抽象概念，是存放一切数据或信息的仓库
  - Windows 操作系统采用树型结构，但其树型结构的根是磁盘分区的盘符，有几个分区就有几个树型结构，它们之间的关系式并列的
  - Linux中，无论操作系统管理几个磁盘分区，目录树只有一个,结构：根目录(/)在上，其它的平行在下
    + Linux是一个多用户系统，制定这样一个固定的目录规划有助于对系统文件和不同的用户文件进行统一管理
    + Linux 文件系统是一个目录树的结构，文件系统结构从一个根目录开始，根文件系统所占空间一般应该比较小，因为其中的绝大部分文件都不需要经常改动，而且包括严格的文件和一个小的 不经常改变的文件系统不容易损坏。除了可能的一个叫/vmlinuz标准的系统引导映像之外，根目录一般不含任何文件
* 文件系统类型
  - ext2 早期linux中常用的文件系统
  - ext3  ext2的升级版，带日志功能
  - RAMFS  内存文件系统，速度很快
  - NFS  网络文件系统，由SUN发明，主要用于远程文件共享
  - MS-DOS  MS-DOS文件系统
  - VFAT Windows 95/98 操作系统采用的文件系统
  - FAT Windows XP 操作系统采用的文件系统
    + FAT：并没有 inode 存在，每个 block 号码都记录在前一个 block 当中，要一个一个的将 block 读出后，才会知道下一个 block 在何处。
    + 如果同一个文件数据写入的 block 分散的太过厉害时，则我们的磁盘读取头将无法在磁盘转一圈就读到所有的数据， 因此磁盘就会多转好几圈才能完整的读取到这个文件的内容
    + 碎片整理：文件写入的 block 太过于离散了，此时文件读取的效能将会变的很差所致，将同一个文件所属的 blocks 汇整在一起
  - NTFS Windows NT/XP 操作系统采用的文件系统
  - HPFS OS/2 操作系统采用的文件系统
  - PROC 虚拟的进程文件系统
  - ISO9660  大部分光盘所采用的文件系统
  - ufsSun OS 所采用的文件系统
  - NCPFS ovell 服务器所采用的文件系统
  - SMBFS Samba 的共享文件系统
  - XFS 由SGI开发的先进的日志文件系统，支持超大容量文件
  - JFS IBM的AIX使用的日志文件系统
  - ReiserFS 基于平衡树结构的文件系统
  - udf 可擦写的数据光盘文件系统
* 分区完毕后还需要进行格式化(format)，之后操作系统才能够使用这个分区，格式化目的是能使操作系统可以使用的文件系统格式
* 每种操作系统能够使用的文件系统并不相同，在默认的情况下，windows 操作系统是不会认识 Linux 的 Ext2 的
* 可被挂载的数据为一个文件系统而不是一个分区：
  - 将一个分区格式化为多个文件系统(例如LVM)
  - 将多个分区合成一个文件系统(LVM, 软件磁盘阵列 RAID (software raid))
* 被指定为相应的文件系统后，整个分区被分为 1024，2048 和 4096 字节大小的块。根据块使用的不同，可分为：
  - 超级块(Superblock): 这是整个文件系统的第一块空间。包括整个文件系统的基本信息，如块大小，inode/block的总量、使用量、剩余量，指向空间 inode 和数据块的指针等相关信息。
  - inode块(文件索引节点): 文件系统索引,记录文件的属性。它是文件系统的最基本单元，是文件系统连接任何子目录、任何文件的桥梁。每个子目录和文件只有唯一的一个 inode 块。它包含了文件系统中文件的基本属性(文件的长度、创建及修改时间、权限、所属关系)、存放数据的位置等相关信息. 在 Linux 下可以通过 “ls -li” 命令查看文件的 inode 信息。硬连接和源文件具有相同的 inode 。
  - 数据块(Block):实际记录文件的内容，若文件太大时，会占用多个 block。为了提高目录访问效率，Linux 还提供了表达路径与 inode 对应关系的 dentry 结构。它描述了路径信息并连接到节点 inode，它包括各种目录信息，还指向了 inode 和超级块
* 文件系统会为每个文件分配两个数据结构
  - 引节点（index node）:用来记录文件的元信息，比如 inode 编号、文件大小、访问权限、创建时间、修改时间、数据在磁盘的位置等等。索引节点是文件的唯一标识，它们之间一一对应，也同样都会被存储在硬盘中，所以索引节点同样占用磁盘空间
  - 目录项（directory entry）:用来记录文件的名字、索引节点指针以及与其他目录项的层级关联关系。多个目录项关联起来，就会形成目录结构，但它与索引节点不同的是，目录项是由内核维护的一个数据结构，不存放于磁盘，而是缓存在内存。
* 查看某个文件时，会先从inode table中查出文件属性及数据存放点，再从数据块中读取数据
  - 索引式文件系统(indexed allocation)：某一个文件的属性与权限数据是放置到 inode 4 号，而这个 inode 记录了文件数据的实际放置点为 2, 7, 13, 15 这四个 block 号码，此时操作系统就能够据此来排列磁盘的阅读顺序，可以一口气将四个 block 内容读出来
    + 如果文件系统使用太久，常常删除/编辑/新增文件时，那么还是可能会造成文件数据太过于离散的问题，此时或许会需要进行重整一下的

* 挂载：所有存储设备都必须挂载使用，包括硬盘
  - 将一个文件系统的顶层目录挂到另一个文件系统的子目录上，使它们成为一个整体,把该子目录称为挂载点.
  - 挂载点必须是一个目录
  - 一个分区挂载在一个已存在的目录上，这个目录可以不为空，但挂载后这个目录下以前的内容将不可用
  - 光盘、软盘、其他操作系统使用的文件系统的格式与linux使用的文件系统格式是不一样，挂载前要了解linux是否支持所要挂载的文件系统格式
    + 格式
      * 光盘是ISO9660
      * 软盘是fat16或ext2
      * windows NT是fat16、NTFS
      * windows98是fat16、fat32；windows2000和windowsXP是fat16、fat32、 NTFS。
    + -t 指定设备的文件系统类型（什么提到的文件类型）
    + -o 指定挂载文件系统时的选项。有些也可用在/etc/fstab中。常用的有
      * codepage=XXX 代码页
      * iocharset=XXX 字符集
      * ro 以只读方式挂载
      * rw 以读写方式挂载
      * nouser 使一般用户无法挂载
      * user 可以让一般用户挂载设备
  - 在/etc目录下有个fstab文件，它里面列出了linux开机时自动挂载的文件系统的列表
    + 第一列是挂载的文件系统的设备名，第二列是挂载点，第三列是挂载的文件系统类型，第四列是挂载的选项，选项间用逗号分隔
    + 参数defaults实际上包含了一组默认参数：
      * rw 以可读写模式挂载
      * suid 开启用户ID和群组ID设置位
      * dev 可解读文件系统上的字符或区块设备
      * exec 可执行二进制文件
      * auto 自动挂载
      * nouser 使一般用户无法挂载
      * async 以非同步方式执行文件系统的输入输出操作
  - sudo mount 查看下主机已经挂载的文件系统，每一行代表一个设备或虚拟设备格式[设备名]on[挂载点]
* 文件系统在内核中的表示
  - 文件与IO: 每个进程在PCB（Process Control Block）中都保存着一份文件描述符表，文件描述符就是这个表的索引，每个表项都有一个指向已打开文件的指针.已打开的文件在内核中用file结构体表示，文件描述符表中的指针指向file结构体。
    + 维护File Status Flag（file结构体的成员f_flags）
    + 当前读写位置（file结构体的成员f_pos）
    + 指向一个file_operations结构体，这个结构体的成员都是函数指针，指向实现各种文件操作的内核函数.由内核调用file_operations的各成员所指向的内核函数完成用户请求
      * release成员用于完成用户程序的close请求,减少引用计数，只有引用计数减到0才关闭文件
    + f_count:引用计数（Reference Count）,当close(fd1)时并不会释放file结构体，而只是把引用计数减到1,引用计数减到0同时释放file结构体，这才真的关闭了文件
    + 一个指向dentry结构体的指针，“dentry”是directory entry（目录项）的缩写.为了减少读盘次数，内核缓存了目录的树状结构，称为dentry cache，其中每个节点是一个dentry结构体，只要沿着路径各部分的dentry搜索即可
      * 只保存最近访问过的目录项，如果要找的目录项在cache中没有，就要从磁盘读到内存中。
      * 每个dentry结构体都有一个指针指向inode结构体。inode结构体保存着从磁盘inode读上来的信息,例如所有者、文件大小、文件类型和权限位等。
      * 每个inode结构体都有一个指向inode_operations结构体的指针，后者也是一组函数指针指向一些完成文件目录操作的内核函数.inode_operations所指向的不是针对某一个文件进行操作的函数，而是影响文件和目录布局的函数
      * inode结构体有一个指向super_block结构体的指针。super_block结构体保存着从磁盘分区的超级块读上来的信息，例如文件系统类型、块大小等
      * super_block结构体的s_root成员是一个指向dentry的指针，表示这个文件系统的根目录被mount到哪里，在上图的例子中这个分区被mount到/home目录下
* 参考
  - [文件系统](https://mp.weixin.qq.com/s/qJdoXTv_XS_4ts9YuzMNIw)

### 目录功用

* Linux 的磁盘是"挂在"（挂载在）目录上的，每一个目录不仅能使用本地磁盘分区的文件系统，也可以使用网络上的文件系统。
* Linux的大部分目录结构是依据FHS标准（Filesystem Hierarchy Standard 文件系统层次结构标准）规定好的，多数 Linux 版本采用这种文件组织形式，FHS 定义了系统中每个区域的用途、所需要的最小构成的文件和目录同时还给出了例外处理与矛盾处理,包含两层规范：
  - / 下面的各个目录应该要放什么文件数据，例如 /etc 应该放置设置文件，/bin 与 /sbin 则应该放置可执行文件等等
  - 针对 /usr 及 /var 这两个目录的子目录来定义。例如 /var/log 放置系统登录文件，/usr/share 放置共享数据等等

* `/`每台机器都有根文件系统，包含系统引导和使其他文件系统得以mount所必要的文件，根文件系统应该有单用户状态所必须的足够的内容。还应该包括修复损坏 系统、恢复备份等的工具
* /bin：包含了引导启动所需的命令或普通用户可能用的命令(可能在引导启动后),都是二进制可执行命令。多是系统中重要的系统文件
* /boot：目录存放引导加载器(bootstrap loader)使用的文件，如lilo，核心映像也经常放在这里，而不是放在根目录中。但是如果有许多核心映像，这个目录就可能变得很大，这时使用单独的 文件系统会更好一些。还有一点要注意的是，要确保核心映像必须在ide硬盘的前1024柱面内。
* /dev：存放了设备文件，即设备驱动程序，用户通过这些文件访问外部设备。比如，用户可 以通过访问/dev/mouse来访问鼠标的输入，就像访问其他文件一样。
  - /dev/console：系统控制台，也就是直接和系统连接的监视器。
  - /dev/hd：ide硬盘驱动程序接口。如：/dev/hda指的是第一个硬 盘，had1则是指/dev/hda的第一个分区。如系统中有其他的硬盘，则依次为/dev /hdb、/dev/hdc、；如有多个分区则依次为hda1、hda2
  - /dev/sd：scsi磁盘驱动程序接口。如系统有scsi硬盘，就不会访问/dev/had， 而会访问/dev/sda。
  - /dev/fd：软驱设备驱动程序。如：/dev/fd0指 系统的第一个软盘，也就是通常所说的a盘，/dev/fd1指第二个软盘，. . . . . .而/dev/fd1 h1440则表示访问驱动器1中的4.5高密盘
  - /dev/st：scsi磁带驱动器驱动程序
  - /dev/tty：提供虚拟控制台支持。如：/dev/tty1指 的是系统的第一个虚拟控制台，/dev/tty2则是系统的第二个虚拟控制台
  - /dev/pty：提供远程登陆伪终端支持。在进行telnet登录时就要用到/dev/pty设 备
  - /dev/ttys：计算机串行接口，对于dos来说就是“com1”口
  - /dev/cua：计算机串行接口，与调制解调器一起使用的设备
  - /dev/cdrom     光盘
  - /dev/hdc       IDE硬盘   centos 5.5
  - /dev/sr0       光盘      centos 6.x
  - /dev/null：“黑洞”，所有写入该设备的信息都将消失。例如：当想要将屏幕 上的输出信息隐藏起来时，只要将输出信息输入到/dev/null中即可
* /etc：存放全局的系统配置文件和应用配置文件
  - /etc/hostname:系统的hostname
  - /etc/network/interfaces：网络接口
  - /etc/resolv.conf:系统的dns服务
  - /etc/rc或者/etc/rc.d或者/etc/init.d：启动、或改变运行级时运行的脚本或脚本的目录。系统初始化文件
  - /etc/passwd：用户数据库，其中的域给出了用户名、真实姓名、用户起始目 录、加密口令和用户的其他信息
  - /etc/shadow：在安装了影子(shadow)口令软件的系统上的影子口令文件。影子口令文件将/etc/passwd文件中的加密口令移动到/etc/shadow中，而后者只对超级用户(root)可读。这使破译口令更困 难，以此增加系统的安全性
  - /etc/fdprm：软盘参数表，用以说明不同的软盘格式。可用setfdprm进 行设置。更多的信息见setfdprm的帮助页
  - /etc/fstab：指定启动时需要自动安装的文件系统列表。也包括用swapon -a启用的swap区的信息
  - /etc/group：类似/etc/passwd ，但说明的不是用户信息而是组的信息。包括组的各种数据
  - /etc/inittab：init 的配置文件
  - /etc/issue：包括用户在登录提示符前的输出信息。通常包括系统的一段短说明 或欢迎信息。具体内容由系统管理员确定
  - /etc/magic：“file”的配置文件。包含不同文件格式的说 明，“file”基于它猜测文件类型
  - /etc/motd：motd是message of the day的缩写，用户成功登录后自动输出。内容由系统管理员确定。常用于通告信息，如计划关机时间的警告等
  - /etc/mtab：当前安装的文件系统列表。由脚本(scritp)初始化，并由 mount命令自动更新。当需要一个当前安装的文件系统的列表时使用(例如df命令)。
  - /etc/login.defs：login命令的配置文件
  - /etc/printcap：类似/etc/termcap ，但针对打印机。语法不同
  - /etc/profile：系统环境变量
  - /etc/csh.login、/etc/csh.cshrc：登录或启动时bourne或cshells执行的文件。这允许系统管理员为所有用户建立全局缺省环境
  - /etc/securetty：确认安全终端，即哪个终端允许超级用户(root) 登录。一般只列出虚拟控制台，这样就不可能(至少很困难)通过调制解调器(modem)或网络闯入系统并得到超级用户特权
  - /etc/shells：列出可以使用的shell。chsh命令允许用户在本文件指定范围内改变登录的shell。提供一台机器ftp服务的服务进程ftpd检查用户shell是否列在/etc/shells文件 中，如果不是，将不允许该用户登录
  - /etc/termcap：终端性能数据库。说明不同的终端用什么“转义序列”控 制。写程序时不直接输出转义序列(这样只能工作于特定品牌的终端)，而是从/etc/termcap中查找要做的工作的 正确序列。这样，多数的程序可以在多数终端上运行
  - /etc/apt/sources.list：软件源管理
  - /etc/init.d/:服务网初始化脚本
* /home：用户主目录的基点
  - 用户user的主目录就是/home/user
  - /root：系统管理员的主目录
* /lib：标准程序设计库，又叫动态链接共享库及内核模块，作用类似windows里的.dll文件。根文件系统上的程序所需的共享库，这些文件包含了可被许多程序共享的代码，以避免每个程序都包含有相同的子程序的副本，故可以使得可执行文件变得更小，节省空间
  - /lib/modules目录包含系统核心可加载各种模块，尤其是那些在恢复损坏的系统时重 新引导系统所需的模块(例如网络和文件系统驱动)
* /mnt：系统管理员临时安装(mount)文件系统的安装点。程序并不自动支持安装到/mnt
  - /mnt/dosa可能是使用 msdos文件系统的软驱
  - /mnt/exta可能是使用ext2文件系统的软驱
  - /mnt/cdrom光 驱等等
* /opt：额外安装的可选应用程序包所放置的位置，`/opt/firefox`目录下面就包含了运行firefox所需要的所有文件、库、数据等等。要删除firefox时只需删除/opt/firefox_beta目录即可
* /proc：虚拟的目录，是系统内存的映射。可直接访问这个目录来获取系统信息
  - /proc/x：关于进程x的信息目录，这x是这一进程的标识号。每个进程在 /proc下有一个名为自己进程号的目录
  - /proc/cpuinfo：存放处理器(cpu)的信息，如cpu的类型、制造商、 型号和性能等
  - /proc/devices：当前运行的核心配置的设备驱动的列表
  - /proc/dma：显示当前使用的dma通道
  - /proc/filesystems：核心配置的文件系统信息
  - /proc/interrupts：显示被占用的中断信息和占用者的信息，以及被占用 的数量
  - /proc/ioports：当前使用的i/o端口
  - /proc/kcore：系统物理内存映像。与物理内存大小完全一样，然而实际上没有 占用这么多内存；它仅仅是在程序访问它时才被创建。(注意：除非你把它拷贝到什么地方，否则/proc下没有任何东西占用任何磁盘空间。)
  - /proc/kmsg：核心输出的消息。也会被送到syslog
  - /proc/ksyms：核心符号表
  - /proc/loadavg：系统“平均负载”；3个没有意义的指示器指出系统当前 的工作量
  - /proc/meminfo：各种存储器使用信息，包括物理内存和交换分区 (swap)
  - /proc/modules：存放当前加载了哪些核心模块信息
  - /proc/net：网络协议状态信息
  - /proc/self：存放到查看/proc的 程序的进程目录的符号连接。当2个进程查看/proc时，这将会是不同的连接。这主要便于程序得到它自己的进程目录
  - /proc/stat：系统的不同状态，例如，系统启动后页面发生错误的次数
  - /proc/uptime：系统启动的时间长度
  - /proc/version：核心版本
* /sbin：系统管理命令，也用于存储二进制文件。这里存放的是系统管理员使用的管理程序，只有root才能访问
* /tmp：存放程序在运行时产生的信息和数据。但在引导启动后，运行的程序最好使用/var/tmp来 代替/tmp，因为前者可能拥有一个更大的磁盘空间。
* /usr：最庞大目录，要用到的应用程序和文件几乎都在这个目录，所有命令、库、man页和其他一般操作中所需的不改变的文件（节省了磁盘空间，且易于管理）
  - /usr/local 本地管理员软件安装目录
  - /usr/x11r6：存放x window的目录
  - /usr/bin：众多的应用程序
  - /usr/sbin：超级用户的一些管理程序
  - /usr/doc：linux文档
  - /usr/include：linux下开发和编译应用程序所需要的头文件
  - /usr/lib：常用的动态链接库和软件包的配置文件
  - /usr/man：帮助文档
  - /usr/src：源代码，linux内核的源代码就放在/usr/src/linux 里
  - /usr/local下一般是你安装软件的目录，这个目录就相当于在windows下的programefiles这个目录
  - /usr/local/bin：本地增加的命令
  - /usr/local/lib：本地增加的库根文件系统
* /var：用户创建的所有变量文件和临时文件的存储，比如spool目录(mail、news、打印机等用的)，log文件、 formatted manual pages和暂存文件。传统上/var 的所有东西曾在 /usr 下的某个地方，但这样/usr 就不可能只读安装了
  - /var/catman：包括了格式化过的帮助(man)页。帮助页的源文件一般存在 /usr/man/catman中；有些man页可能有预格式化的版本，存在/usr/man/cat中。而其他的man页在第一次看时都需要格式化，格 式化完的版本存在/var/man中，这样其他人再看相同的页时就无须等待格式化了。(/var/catman经常被 清除，就像清除临时目录一样。)
  - /var/lib：存放系统正常运行时要改变的文件
  - /var/local：存放/usr/local中 安装的程序的可变数据(即系统管理员安装的程序)。注意，如果必要，即使本地安装的程序也会使用其他/var目录，例如/var/lock
  - /var/lock：锁定文件。许多程序遵循在/var/lock中 产生一个锁定文件的约定，以用来支持他们正在使用某个特定的设备或文件。其他程序注意到这个锁定文件时，就不会再使用这个设备或文件
  - /var/log：各种程序的日志(log)文件，尤其是login (/var/log/wtmplog纪 录所有到系统的登录和注销) 和syslog (/var/log/messages 纪录存储所有核心和系统程序信息)。/var/log 里的文件经常不确定地增长，应该定期清除
  - /var/run：保存在下一次系统引导前有效的关于系统的信息文件。例如，/var/run/utmp包 含当前登录的用户的信息
  - /var/spool：放置“假脱机(spool)”程序的目录，如mail、 news、打印队列和其他队列工作的目录。每个不同的spool在/var/spool下有自己的子目录，例如，用户的邮箱就存放在/var/spool/mail 中
  - /var/tmp：比/tmp允许更大的或需要存在较长时间的临时文件。注意系统管理 员可能不允许/var/tmp有很旧的文件
* /lost+found：平时是空的，系统非正常关机而留下“无家可归”的文件就在这里

### 文件操作

* 文件属性 `-rw-r--r--    1 henry  staff       658 Jun  3  2019 serverless.yml`
  - 第一个字段 类型
    - `-` 普通文件：一般是用一些相关的应用程序创建的（如图像工具、文档工具、归档工具... 或 cp工具等)
    - `d` 目录：目录在Linux是一个比较特殊的文件，用字符d表示，删除用rm 或rmdir命令
    - l 表示链接文件，等同于 Windows 上的快捷方式，unix 里面的链接同 Windows 中的快捷方式类似，允许快速地访问到一个特定的文件
      + 软硬链接文件的共同点和区别：无论是修改软链接，硬链接生成的文件还是直接修改源文件，相应的文件都会改变，但是如果删除了源文件，硬链接生成的文件依旧存在而软链接生成的文件就不再有效了
      + 硬链接（Hard Link）：默认 硬链接是使用同一个索引节点（inode号）的链接， 即可以允许多个文件名指向同一个文件索引节点
        * 原文件名和连接文件名都指向相同的物理地址
        * 目录不能有硬连接
        * 修改其中一个，与其连接的文件同时被修改
        * 硬连接不能跨越文件系统（不能跨越不同的分区）文件在磁盘中只有一个拷贝，节省硬盘空间
        * 删除一个硬链接，不会影响该索引节点的源文件以及其下的多个硬链接,可以防止不必要的误删除
        * 增加一个文件的链接数，只要该文件的链接数不为 0 ，该文件就不会被物理删除，所以删除一个具有多个硬链接数的文件，必须删除所有它的硬链接才可删除。
        * 由于删除文件要在同一个索引节点属于唯一的连接时才能成功，因此可以防止不必要的误删除
      + 软连接（符号链接，Symbolic Link）：符号链接是以路径的形式创建的链接，类似于windows的快捷方式链接，符号链接允许创建多个文件名链接到同一个源文件，删除源文件，其下的所有软连接将不可用。（软连接支持目录，支持跨分区、跨文件系统）使用 -s 参数
    - `sudo ln -s ~/Desktop/Scripts/git-scripts/git-cleanup /usr/local/bin/`
  * 区别
    - 硬链接原文件和新文件的inode编号一致。而软链接不一样。
    - 对原文件删除，会导致软链接不可用，而硬链接不受影响。
    - 对原文件的修改，软、硬链接文件内容也一样的修改，因为都是指向同一个文件内容的。
    - s 套接字文件，比如启动MySQL服务器时，产生的mysql.sock的文件
    - c 字符设备文件，比如/dev/中的很多文件，大都跟具体的硬件设备相关，如猫的串口设备
    - b 表示块设备文件，比如一些磁盘，存在于/dev目录下，如硬盘，光驱等设备
    - p 管道文件，可以实现两个程序（可以从不同机器上telnet）实时交互
    - 备份会以在文件名后附加 ~ 字符的文件名保存
  - 权限 File Permissions `rw-r--r--` ower:group:others
    + 权限类型
      * 读权限：读取文件内容|查询目录下文件名 使用 cat、more、head、tail ls
      * 写权限: 编辑、新增、修改文件内容|修改目录结构的权限
      * 执行权限:通常指可以运行的二进制程序文件或者脚本文件(Linux 上不是通过文件后缀名来区分文件的类型)
      * Read, write and execute rwx 111 7
      * Read and write  rw- 110 6
      * Read and execute  r-x 101 5
      * Read only r-- 100 4
      * Write and execute -wx 011 3
      * Write only  -w- 010 2
      * Execute only  --x 001 1
      * None  --- 000 0
      * 一个目录同时具有读权限和执行权限才可以打开并查看内部文件，而一个目录要有写权限才允许在其中创建其它文件，因为目录文件实际保存着该目录里面的文件的列表等信息
      * sticky bit:只用于目录上,一个目录可以让任何人写人文件，但是不能删除其他用户的文件
        - ls -dl /tmp
    + 所有者权限:所属用户组权限，是指所在的用户组中的所有其它用户对于该文件的权限
    + 格式
      * `chmod 664 <filename>`
      * `chmod g+s`：This means that all new files and subdirectories created within the current directory inherit the group ID of the directory, rather than the primary group ID of the user who created the file.  This will also be passed on to new subdirectories created in the current directory.
    + `chown \<new_owner> \<file_name>`
    + `chgrp groupname filename`
* 查看 Navigating the File System
  - `file filename|dirname`
  - `stat filename|dirname` 看到mtime,ctime,atime类似的字样
    + 文件的字节数
    + 文件拥有者user
    + 文件所属组group
    + 文件的读、写、执行权限
    + 文件的时间戳
      * ctime指inode上一次变动的时间
      * mtime指文件内容上一次变动的时间
      * atime指文件上一次打开的时间。
    + 链接数，即有多少文件名指向这个inode （ln命令）
    + 文件数据block的位置（具体的数据位置）
  - pwd (print working directory)
  - cd (change directory)
  - Tree 用可视化的效果向你展示一个目录下的文件 tree -P '_.min._'
  - md5sum:可以用来检查文件的完整性。`md5sum ubuntu-16.04.3-desktop-amd64.iso` 将生成的字符串与原作者提供的（比如 UbuntuHashes）进行比较
  - ls (list files and directories)
    + 参数
      * -a:列出所有文件，包括隐藏文件
      * -A 所有隐藏文件（. 和 .. 除外）
      * -c 根据ctime排序
      * --color 现实色彩
      * -d:显示目录本身
      * -g 选项只显示所属组的列
      * -h｜--human:将文件大小转换为更加人性化的表示方法
      * -l:列出文件及其详细信息
      * -m:以逗号分隔文件列表
      * -o 选项只显示所有者的列
      * -t 根据文件的最近更改的时间（最新的文件最先列出）进行排序
      * -1:每行一个文件
      * -X 按文件扩展名而不是文件名对条目进行排序
      * -R 递归地列出目录
      * --time-style
        - full-iso：ISO 完整格式（1970-01-01 21:12:00）
        - long-iso：ISO 长格式（1970-01-01 21:12）
        - iso：iso 格式（01-01 21:12）
        - locale：本地化格式（使用你的区域设置）
        - posix-STYLE：POSIX 风格（用区域设置定义替换 STYLE）
    + 匹佩符
      * `*`：匹配 0 或多个字符，如`ls *.html`将匹配所有以html结尾的文件,`ls b*.png`将匹配所有以b开头，png结尾的文件；
      * `?`：匹配任意一个字符,如`ls abc?.png` 可匹配abcd.png/abce.png
      * `[list]` # 匹配 list 中的任意单一字符
      * `[!list]`:匹配 除list 中的任意单一字符以外的字符
      * `[c1-c2]`:匹配 c1-c2 中的任意单一字符 如：[0-9] [a-z]
      * `{string1,string2,...}`:匹配 string1 或 string2 (或更多)其一字符串，如 `{css,html}`， `ls app.{html.css}`将匹配app.css 和app.html;
      * `{c1..c2}`:匹配 c1-c2 中全部字符 如{1..10}
      * 通配符大小写敏感
    + 结果
      * 斜杠 `/`表示目录（或“文件夹”）
      * 星号（`*`）表示可执行文件。这包括二进制文件（编译代码）以及脚本（具有可执行权限的文本文件）
      * 符号（`@`）表示符号链接（或“别名”）
      * 等号（`=`）表示套接字
      * 在 BSD 上，百分号（`%`）表示涂改whiteout（某些文件系统上的文件删除方法）
      * 在 GNU 上，尖括号（`>`）表示门door（Illumos 和 Solaris上的进程间通信）
      * 竖线（`|`）表示 FIFO 管道。    这个选项的一个更简单的版本是 `-p`，只区分文件和目录
    + [broot](https://dystroy.org/broot/) Get an overview of a directory, even a big one
    + [exa](https://github.com/ogham/exa) A modern replacement for ‘ls’. https://the.exa.website/
  - wc word count
    + -l
* Viewing Files
  - cat:concatenate and write file(s) to your screen
    + -b, --number-nonblank    number nonempty output lines, overrides -n
    + -n, --number             number all output lines
    + -s option saves screen space
  - `less [参数] 文件` 上下滚动查看内容
    + 优点
      * 默认情况下启动时没有鼠标支持，因此不会淹没鼠标事件，所以可以在终端轻松地选择和复制文本
      * 可轻松处理大文件。选择转换到Less的主要原因是，如果要检查大型日志文件，在到处导航，例如检查文件的末尾的时候，mcview不会完全切断它。Less就很快，只需按下“G”就行，然后按“g”就能回到起点
      * 默认已安装
      * 使用Vim作导航，因此能很好地融入到其他工具的约定中
      * 很容易搜索，使用“/”、“?”、“n”和“N”键能有高亮效果，使用“j”和“k”导航。当然，它也支持箭头键和PgDn / PgUp键。
      * 许多工具都使用它。例如，man和git diff工具都使用Less来呈现信息
    + 参数
      * -c 从顶部（从上到下）刷新屏幕，并显示文件内容。而不是通过底部滚动完成刷新
      * -f 强制打开文件，二进制文件显示时，不提示警告
      * -i 搜索时忽略大小写；除非搜索串中包含大写字母
      * -I 搜索时忽略大小写，除非搜索串中包含小写字母
      * -m 显示读取文件的百分比
      * -M 显法读取文件的百分比、行号及总行数
      * -N 在每行前输出行号
      * -p pattern 搜索pattern；比如在/etc/profile搜索单词MAIL，就用 less -p MAIL /etc/profile
      * -s 把连续多个空白行作为一个空白行显示；
      * -Q 在终端下不响铃
    + 操作
      * / 向下搜索，比如/1111将查找1111字样
      * ? 向上搜索
      * n 重复上一个搜索
      * N 反向上一个搜索
      * `<space>` 向后翻页
      * b 向前翻页
      * j 向下一行
      * k 向上一行
      * q 退出less
      * g 到开头
      * G 去结尾
  - `more <filename>` displaying one screen at a time in case the file is large
    + 空格键 向下翻页
    + q 退出
    + / 字符并在其后加上想要查找的文字
    + `ls | more`
  - head|tail
    + -n 5
    + -f 循环读取
  - [find](../shell/find.md)
* Manipulating Files
  - touch (create new file)
  - mkdir (create new directories)
  - cp (copy files and directories)
    + -r
    + -f
    + -i
    + -v
    + -p 文件属性也复制
    + -a 将档案所有特性一起复制
  - mv (move files and directories)
    + -f 直接覆盖，不提示
    + -i 覆盖时提示
    + -b 覆盖时，做备份
    + -u 文件较新时，才覆盖
  - rm (delete files and directories)
* Text Processing Commands
  - [sed](../shell/sed.md)
    + `sed 's/<text_to_replace>/<replacement_text>/' <file_name>`
  - sort
    + -k 选择排序依据列
    + -t 指定分隔符
    + -n 依照数组大小排序
    + -r 倒叙
  - [`grep <word_to_search> <file_name>`](../shell/grep.md)用来在文本中查找字符串,从一个文件或者直接就是流的形式获取到输入,通过一个正则表达式来分析内容，然后返回匹配的行。该命令在需要对大型文件进行内容过滤的时候非常趁手
    + `grep ‘productivity’ core.md Dict.md lctt2014.md lctt2016.md lctt2018.md README.md | more`
    + `grep "$(date +"%Y-%m-%d")" all-errors-ever.log > today-errors.log`
  * uniq 删除排序文件中重复行
    - -c 显示重复次数
    - -u 仅显示出现一次的
* [ranger](https://github.com/ranger/ranger):A VIM-inspired filemanager for the console https://ranger.github.io/

```sh
cat >> ~/.bashrc <<EOF
function man()
{
    env \\
    LESS_TERMCAP_mb=\$(printf "\e[1;31m") \\
    LESS_TERMCAP_md=\$(printf "\e[1;31m") \\
    LESS_TERMCAP_me=\$(printf "\e[0m") \\
    LESS_TERMCAP_se=\$(printf "\e[0m") \\
    LESS_TERMCAP_so=\$(printf "\e[1;44;33m") \\
    LESS_TERMCAP_ue=\$(printf "\e[0m") \\
    LESS_TERMCAP_us=\$(printf "\e[1;32m") \\
    man "\$@"}
EOF

sort authors.txt | uniq -c > authors-sorted.txt

cat File1 File2 >File\_Output
```

### 虚拟文件系统 vfs

* 将各种不同文件系统的操作和管理纳入到一个统一的框架中，使得用户程序可以通过同一个文件系统界面，也就是同一组系统调用，对各种不同的文件系统以及文件进行操作；用户程序可以不关心不同文件系统的实现细节，而使用系统提供的统一、抽象、虚拟的文件系统界面；这种统一的框架就是所谓的虚拟文件系统转换，一般简称虚拟文件系统(VFS)；
* VFS 对象类型
  - 超级块(superblock)对象
  - 索引节点(inode)对象
  - 目录项(dentry)对象
  - 文件(file)对象
* 虚拟文件系统界面是虚拟文件系统所提供的抽象界面，它主要由一组标准的、抽象的操作构成，这些函数(操作)以系统调用的形式供用户调用。

* `dd if=/dev/zero of=virtual.img bs=1M count=256` 从/dev/zero设备创建一个容量为 256M 的空文件virtual.img
* `sudo mkfs.ext4 virtual.img` 格式化virtual.img为ext4格式
* dd：默认从标准输入中读取，并写入到标准输出中,但输入输出也可以用选项if（input file，输入文件）和of（output file，输出文件）改变。
* `dd if=/dev/stdin of=test bs=10 count=1 conv=ucase` 将输出的英文字符转换为大写再写入文件

![VFS子系统](../_static/VFS.png "VFS子系统")

### 压缩

* .tar 使用tar命令压缩或解压
  - -c 创建
  - -x 解压
  - -t 查看
  - -C 指定要解压目录
  - -r:表示递归打包包含子目录的全部内容
  - -q:表示为安静模式，即不向屏幕输出信息
  - -o:表示输出文件，需在其后紧跟打包输出文件名
  - -[1-9]:设置压缩等级，1 表示最快压缩但体积大，9 表示体积最小但耗时最久。
  - -x:排除我们上一次创建的 zip 文件，否则又会被打包进这一次的压缩文件中
  - -e：创建加密压缩包
  - -l:将 LF（换行） 转换为 CR+LF(windows 回车加换行)
  - -v 显示处理过程
  - -f 目标文件，其后必须紧跟 目标文件
  - -j 调用 bzip2 进行解压缩
  - -z 调用 gzip 进行解压缩

.bz2 使用bzip2命令操作
.gz 使用gzip命令操作
.zip 使用unzip命令解压
.rar 使用unrar命令解压
.Z  使用compress,uncompress

* 一个块是 512 个字节大小，不足或正好 512 个字节将占据一个块

```sh
mkdir /media/cdrom  # 新建镜像文件挂载目录
cd /usr/local/src  #进入系统镜像文件存放目录
ls *.c  # 列出目录文件，可以看到刚刚上传的系统镜像文件
ls [abc]*

dd # 默认从标准输入中读取，并写入到标准输出中,但输入输出也可以用选项if（input file，输入文件）和of（output file，输出文件）改变。
# dd if=/dev/zero of=virtual.img bs=1M count=256  # 从/dev/zero设备创建一个容量为 256M 的空文件virtual.img
# dd if=/dev/stdin of=test bs=10 count=1 conv=ucase # 将输出的英文字符转换为大写再写入文件
sudo mount # 查看下主机已经挂载的文件系统，每一行代表一个设备或虚拟设备格式[设备名]on[挂载点]

# 挂载系统镜像 mount -t 文件系统 设备描述文件 挂载点（已经存在空目录）
mount -t iso9660 -o loop /usr/local/src/rhel-server-7.0-x86_64-dvd.iso  /media/cdrom
cd  /media/cdrom  # 进入挂载目录，使用ls命令可以看到已经有文件存在了

# /etc/fstab   # 添加以下代码。实现开机自动挂载
/dev/hda2 / ext3 defaults 1 1
/dev/hda1 /boot ext3 defaults 1 2
none /dev/pts devpts gid=5,mode=620 0 0
none /proc proc defaults 0 0
none /dev/shm tmpfs defaults 0 0
/dev/hda3 swap swap defaults 0 0
/dev/cdrom /mnt/cdrom iso9660 noauto,codepage=936,iocharset=gb2312 0 0
/dev/fd0 /mnt/floppy auto noauto,owner,kudzu 0 0
/dev/hdb1 /mnt/winc vfat defaults,codepage=936,iocharset=cp936 0 0
/dev/hda5 /mnt/wind vfat defaults,codepage=936,iocharset=cp936 0 0
/usr/local/src/rhel-server-7.0-x86_64-dvd.iso  /media/cdrom   iso9660    defaults,ro,loop  0 0

## 挂载 mount [-参数] [设备名称] [挂载点]
mount /dev/fd0 /mnt/floppy # 挂载一个软盘
mount /dev/cdrom /mnt/cdrom # 挂载一个cdrom或dvdrom
mount /dev/hdc /mnt/cdrecorder # 挂载一个cdrw或dvdrom
mount /dev/hdb /mnt/cdrecorder # 挂载一个cdrw或dvdrom
mount -o loop file.iso /mnt/cdrom 挂载一个文件或ISO镜像文件
mount -t vfat /dev/hda5 /mnt/hda5 # 挂载一个Windows FAT32文件系统
mount /dev/sda1 /mnt/usbdisk 挂载一个usb 捷盘或闪存设备
mount -t smbfs -o username=user,password=pass //WinClient/share /mnt/share 挂载一个windows网络共享
mkdir /media/cdrom  #新建镜像文件挂载目录
cd /usr/local/src  #进入系统镜像文件存放目录
mount -t iso9660 -o loop /usr/local/src/rhel-server-7.0-x86_64-dvd.iso  /media/cdrom #挂载光盘
cd  /media/cdrom  #进入挂载目录，使用ls命令可以看到已经有文件存在

umount  /media/cdrom  # 卸载系统镜像 退出挂载目录，才能卸载

ls -F # 查看目录中的文件
alias ls='ls -A -F -B --human --color'
ls -a|l|h|d directory # list 列出某文件夹下的文件，添加参数可实现更细致的功能

ls -l l*
mv -v users-0* users-info/  # Option -v flag enables verbose output
ls l?st.sh
ls l[abdcio]st.sh
ls ??st*
ls [clst][io]?t*
rm *tar*
ls users-[0-9][a-zA-Z0-9][0-9]*
ls users-[0-9][!0-9][a-zA-Z]*

# -rw-------    1   root    root    1190    08-10 23:37     anaconda-ks.cfg 长格式实例： 权限位 引用计数 属主、组 大小 最后修改时间
tree # 查看文件列表
tree /home -p # 获取项目树形结构 Tree 用可视化的效果展示一个目录下的文件

cd /home/henry|~|..|../.. # change directory 通过相对路径、绝对路径切换目录,cd到不存在的目录时会报错
cd   # 进入用户主目录
cd -  # 返回进入此目录之前所在的目录

touch # 创建空文件 或 修改文件时间 touch file{1..5}.txt 使用通配符批量创建 5 个文件
touch  somefile.1  ## 创建一个空文件
touch  filename|dir/filename
touch -t 0712250000 file1 # 修改一个文件或目录的时间戳 - (YYMMDDhhmm)
file logo.png # Returns information for given file
file /bin/ls # 查看文件类型

echo "hi,boy" > somefile.2  ## 利用重定向“>”的功能，将一条指令的输出结果写入到一个文件中，会覆盖原文件内容，如果指定的文件不存在，则会创建出来
echo "hi baby" >> somefile.2  ## 将一条指令的输出结果追加到一个文件中，不会覆盖原文件内容

rename # 批量重命名,需要用到正则表达式
rename 's/.txt/.c/' *.txt 批量将这 5 个后缀为 .txt 的文本文件重命名为以 .c 为后缀的文件:
rename 'y/a-z/A-Z/' *.c 批量将这 5 个文件，文件名改为大写

pwd # print working directory 打印当前目录

mkdir  newdir # make directories 创建目录
mkdir -p father/son/grandson # 递归创建
mkdir  dir/newdir|dir/dir/newdir
basename，dirname

# 移动文件、文件重命名
mv  sourcefile  destinationDirectory|desalinationFile  #  移动文件、文件重命名 将当前目录下的install.log 移动到aaa文件夹中去
mv  dir1  dir2                # dir1移动到dir2目录下,并给改名字为"原名"
mv  dir1  dir2/newdir         # dir1移动到dir2目录下,并给改名字为newdir
mv  dir1/dir2  dir3/dir4      # dir2移动到dir4目录下,并给改名字为"原名"
mv  dir1/dir2  dir3/dir4/newdir  # dir2移动到dir4目录下,并给改名字为 newdir
mv  dir1/dir2  ./             # dir2移动到 当前 目录下,并给改名字为"原名"
mv  dir1/dir2  ./newdir           # dir2移动到 当前 目录下,并给改名字为newdir

rmdir # remove empty directories 删除目录
rm -rf directory # r递归删除，f参数表示强制
rm -rf log/* # 方法二：删除logs文件夹下的所有文件，而不删除文件夹本身
rm filename      # 普通文件删除
rm dir # 删除目录
rm -r dir         # 删除目录[无视层次]需要-r参数
rm -rf  文件      # recursive force 递归强制删除文件,force 避免删除隐藏文件的提示
rm -rf /         # 递归强制方式删除系统里边的全部内容

# 生产环境把rm -rf 命令替换为mv，再写个定时shell定期清理
# 帐号权限的分离，线上分配work帐号，只能够删除/home/work/logs/目录，无法删除根目录。
# cd ${log_path} && rm -rf *
# 制定编码规范，对目录进行操作之前，要先判断目录是否存在。

wc  -l|-m|-w # 行 字符 字 获取某一个文件的行数和字数`wc package.json`

cp -r|p|d|a 源文件 目标位置/目标名称 # 复制文件或目录  r:复制目录 p:连带文件属性一起复制 -d:源文件是链接文件，则复制链接属性 a:相当于pdr
cp  file1  dir1  # file1被复制到dir1目录下一份，并给改名字为“原名”
cp  file1  dir1/newfile  # file1被复制到dir1目录下一份，并给改名字为newfile
cp -r dir1  dir2 # dir1被复制到dir2目录下一份，并给改名字为“原名” # recursive递归方式拷贝目录
cp -r dir1  dir2/newdir  # dir1被复制到dir2目录下一份，并给改名字为newdir
cp -r dir1/dir2/dir3   dir4/dir5  # dir3被复制到dir5目录下一份，并给改名字为"原名"

sort # 排序
diff file1 file2 # 比较两个文件的异同
md5sum  file
md5sum -c file

dos2unix # 行结束符转换成unix
base64 inputfile output
base64 -d inputfile output

cat -n file # 查看文件内容，从头到尾的内容 -n:列出行号 当一个文档太长时， cat 只能展示最后布满屏幕的内容
cat  filename   # 在终端显示文件全部内容,读取某一个文件内的内容,打印文件内容到标准输出(正序)
less filename   # "上下左右"键方式查看文件各个部分内容,支持回看，q键退出查看

wc  filename     # 计算文件行数
nl # 显示的时候，顺道输出行号
umask # 档案预设权限
chattr # 配置文件档案隐藏属性
lsattr # 显示档案隐藏属性

tac # 打印文件内容到标准输出(逆序)

head  -n 20 file # 显示文件头几行(默认显示10行)
tail -n 1 /etc/passwd # 查看文件的尾几行（默认10行）
tail -f file

# Enter 键向下滚动一行 Space 键向上滚动一屏 h 显示帮助 q 退出
more file # 分屏显示文件内容,终端底部显示当前阅读的进度 逐行显示内容
more +100 /etc/locale.gen       # 从 100 行开始显示

# 动作
回车键 向下移动一行
y 向上移动一行
空格键 向下滚动一屏
b 向上滚动一屏
d 向下滚动半屏
h less的帮助
u 向上洋动半屏
w 可以指定显示哪行开始显示，是从指定数字的下一行显示 比如指定的是6，那就从第7行显示
g 跳到第一行
G 跳到最后一行
p n% 跳到n%，比如 10%，也就是说比整个文件内容的10%处开始显示
/pattern 搜索pattern ，比如 /MAIL表示在文件中搜索MAIL单词
v 调用vi编辑器
q 退出less

grep -i "security" jan2017articles.csv

echo  内容 > filename    # 给文件“覆盖写”方式追加内容
echo  内容 >> filename   # 给文件纯追加内容
cat file >> another file # 文件追加

ln source new-link
ln -s source new-link
ln -s 源文件 目标文件 创建链接文件 # 链接文件相当于快捷方式 (文件名都必须写绝对路径)
ln -l /user/bin/java #  show link info
ln  # unix 里面的链接同 Windows 中的快捷方式类似，允许你快速地访问到一个特定的文件。
sudo ln -s ~/Desktop/Scripts/git-scripts/git-cleanup /usr/local/bin/

psketch

tee # It splits the output of a program, so we can both print & save it. For example, add a new entry to hosts file;
echo "127.0.0.1 foobar" | sudo tee -a /etc/hosts

tree -d # Lists contents of a directory in tree-like format

sudo mkfs.ext4 virtual.img # 格式化virtual.img为ext4格式

cat $FILE | pbcopy # 将内容复制到粘贴板

# -r-xr-x---
chmod 755 test # change the permissions mode of a file 修改权限  赋予一个shell文件test.sh可执行权限，拥有者可读、写、执行，群组账号和其他人可读、执行。
chmod  u g o a | +（加入） -（除去） =（设置） | r w x | 文档路径
chmod u=rwx,g+rwx,o-rwx test
chmod 000  filename   # 所有用户没有任何权限
sudo chown user1:user1 /etc/apt/sources.list # 修改文件的属主或属组 change file ownership

chown [-R] [帐号名称] [文件或目录]
chown [-R] [帐号名称]:[群组名称] [文件或目录]

zip -r -9 -q -o shiyanlou_9.zip /home/shiyanlou -x ~/*.zip # 设置不同压缩等级
zip -r -e -o shiyanlou_encryption.zip /home/shiyanlou  # 创建加密
zip -r -l -o shiyanlou.zip /home/shiyanlou   # 解决windows和linux对换行的不同处理问题

unzip -q shiyanlou.zip -d ziptest   # 静默且指定解压目录，目录不存在会自动创建
unzip -O GBK 中文压缩文件.zip # 使用 -O（英文字母，大写 o）参数指定编码类型
gzip，zcat
bzip2，bzcat

tar -zcvf 压缩文件名 源文件 # 压缩/解压 同时打包 -z:识别.gz格式  -c:压缩  -v:显示压缩过程  -f:指定压缩包名
tar -zxvf  压缩文件名   # 解压缩同时解打包

tar -jcvf 压缩文件名 源文件   # 压缩同时打包
tar -jxvf aa.tar.bz2  /tmp/ # 解打包同时解压缩

tar -ztvf aa.tar.gz  # 查看不解压
tar -jtvf aa.tar.bz2 # -t  只查看，不解压

rar a all *.jpg
unrar e all.rar

whereis who  # 只能搜索二进制文件(-b)，man 帮助文件(-m)和源代码文件(-s)。
where composer
type composer
locate /etc/sh(查找 /etc 下所有以 sh 开头的文件)  # 通过/var/lib/mlocate/mlocate.db数据库查找，不过这个数据库也不是实时更新的，系统会使用定时任务每天自动执行 updatedb 命令更新一次，所以有时候你刚添加的文件，它可能会找不到
locate /usr/share/\*.jpg # 注意要添加 * 号前面的反斜杠转义，否则会无法找到。
which man # 使用 which 来确定是否安装了某个指定的软件，因为它只从 PATH 环境变量指定的路径中去搜索命令
```

### 文件系统调用

* 为了对一个文件进行读写的前提是先需要打开文件，必须使用 creat 或者 open 打开，参数是打开文件的方式，是只读、可读写还是只写。open 系统调用也会返回文件描述符。打开文件后，需要使用 close 系统调用进行关闭。close 和 open 返回的 fd 总是未被使用的最小数量
* 当程序要求打开一个文件时，内核会进行如下操作
  - 授予访问权限
  - 在全局文件表(global file table)中创建一个条目(entry)
  - 向软件提供条目的位置
* 文件描述符由唯一的非负整数组成，系统上每个打开的文件至少存在一个文件描述符

### Network File System NFS 网络文件系统

* 每一个 NFS 服务都会导出一个或者多个目录供远程客户端访问。当一个目录可用时，它的所有子目录也可用。因此，通常整个目录树都会作为一个整体导出。服务器导出的目录列表会用一个文件来维护，这个文件是 /etc/exports，当服务器启动后，这些目录可以自动的被导出。客户端通过挂载这些导出的目录来访问它们。当一个客户端挂载了一个远程目录，这个目录就成为客户端目录层次的一部分
* 由于 NFS 的协议之一是支持异构系统，客户端和服务器可能在不同的硬件上运行不同的操作系统，因此有必要在服务器和客户端之间进行接口定义。这样才能让任何写一个新客户端能够和现有的服务器一起正常工作
* 访问限制
  - 单个客户端： `/mnt/linuxidc clientIP(rw,sync,no_subtree_check)`
  - 多个客户端： `/mnt/linuxidc client1IP(rw,sync,no_subtree_check)`
  - 多个客户端，通过指定客户端所属的整个子网： `/mnt/linuxidc 192.168.182.0/24(rw,sync,no_subtree_check)`

```sh
sudo apt-get install -y nfs-kernel-server

cd ~
mkdir nfs
# vi /etc/exports 添加
/home/erick/nfs *(rw,sync,no_root_squash,no_subtree_check)

sudo /etc/init.d/rpcbind restart
sudo /etc/init.d/nfs-kernel-server restart

sudo apt-get install -y nfs-common
showmount -e 172.16.36.25
sudo mount -t nfs 172.16.36.25:/home/erick/nfs /mnt
sudo umount /mnt
```

## 软件 Package

* Package Management 包管理：apt|yum
  - [DNF](https://docs.fedoraproject.org/en-US/quick-docs/dnf/) is the successor to YUM which is now used in Fedora for installing and managing packages. DNF may replace YUM in the future on all RPM based Linux distributions
  - 原理
    + 在本地的一个数据库中搜索关于 cowsay 软件的相关信息
    + 根据这些信息在相关的服务器上下载软件安装
    + 安装某个软件时，如果该软件有其它依赖程序，系统会为我们自动安装所以来的程序；
    + 如果本地的数据库不够新，可能就会发生搜索不到的情况，这时候需要我们更新本地的数据库，使用命令sudo apt-get update可执行更新；
    + 软件源镜像服务器可能会有多个，有时候某些特定的软件需要我们添加特定的源；
  - 参数
    + `sudo apt-cache search softname1 softname2 softname3......` 针对本地数据进行相关操作的工具
    + install
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
* 从二进制软件包安装：需要做的只是将从网络上下载的二进制包解压后放到/opt，建立软连接/usr/local/bin/
* [Pkgs](https://pkgs.org/):Packages Search for Linux and Unix
* AppImage
* [winapps](https://github.com/Fmstrat/winapps)Run Windows apps such as Microsoft Office/Adobe in Linux (Ubuntu/Fedora) and GNOME/KDE as if they were a part of the native OS, including Nautilus integration.
* [Linuxbrew/brew](https://github.com/Linuxbrew/brew):🍺🐧 The Homebrew package manager for Linux https://linuxbrew.sh
* [Bleachbit](https://www.bleachbit.org/download/linux)
  - `sudo apt install bleachbit`

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

./configure -h # 完全自定义 参数

sudo chmod +x ./Qv2ray-refs.tags.v1.99.6-linux.AppImage
sudo ./Qv2ray-refs.tags.v1.99.6-linux.AppImage
```

### [flatpak](https://flatpak.org/)

The Future of　Apps On linux

* a universal package management system to build and distribute applications on any Linux distros
* [Flathub](https://flathub.org/home):the home of hundreds of apps which can be easily installed on any Linux distribution

```sh
sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak

# /var/lib/flatpak/repo/config 全局配置

#  ~/.local/share/flatpak/repo/config
[remote “flathub”]
url=https://sel.flathub.org/repo/
# url=https://dl.flathub.org/repo/
url-is-set=true
xa.title=Flathub
gpg-verify=true
gpg-verify-summary=true
xa.comment=Central repository of Flatpak applications
xa.description=Central repository of Flatpak applications
xa.icon=https://dl.flathub.org/repo/logo.svg
xa.homepage=https://flathub.org/

flatpak remote-list
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

## restart

flatpak list
flatpak install --from /path/to/<app-id>.flatpakref
flatpak install flathub com.netease.CloudMusic
flatpak run com.netease.CloudMusic
```

## Daemons

* A computer program that runs as a background process
* 使用 & 运行程序
  - 程序转入后台运行
  - 结果会输出到终端
  - 使用 Ctrl + C 发送 SIGINT 信号，程序免疫
  - 关闭 Shell session 发送 SIGHUP 信号，程序关闭
* nohup:不挂断地运行命令 `nohup Command [Arg …] [　& ]`
  - 无论是否将 nohup 命令的输出重定向到终端，输出都将附加到当前目录的 nohup.out 文件中
  - 如果当前目录的 nohup.out 文件不可写，输出重定向到 $HOME/nohup.out 文件中
  - 如果没有文件能创建或打开以用于追加，那么 Command 参数指定的命令不可调用
  - 输出重定向，默认重定向到当前目录下 nohup.out 文件
  - 使用 Ctrl + C 发送 SIGINT 信号，程序关闭
  - 关闭 Shell Session 发送 SIGHUP 信号，程序免疫

```sh
date # 获取当前时间
date +%Y-%m-%d
date +%Y-%m-%d  --date="-1 day" #加减也可以 month | year
date -s "2016-07-28 16:12:00" ## 修改时间
# Show how long the system has been running + load
uptime # 查看当前系统运行多长时间

clock -w # 将时间修改保存到 BIOS

--version/-V # 查看某个程序的版本
history # 显示历史
--help # 用于显示 shell 内建命令的简要帮助信息 help exit
man # 查看命令的帮助
info ls # 查看信息

cal # 日历
bc # 支持任意精度的交互执行的计算器语言
date # 获取当前时间

grep  # 用来在文本中查找字符串,从一个文件或者直接就是流的形式获取到输入, 通过一个正则表达式来分析内容，然后返回匹配的行。该命令在需要对大型文件进行内容过滤的时候非常趁手`grep "$(date +"%Y-%m-%d")" all-errors-ever.log > today-errors.log`
# 使用 alias 这个 bash 内置的命令来为它们创建一个短别名
alias server="python -m SimpleHTTPServer 9000"

tar # 用来处理文件压缩的默认 Unix 工具.
md5sum  # 它们可以用来检查文件的完整性。`md5sum ubuntu-16.04.3-desktop-amd64.iso` 将生成的字符串与原作者提供的（比如 UbuntuHashes）进行比较

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

# 自定义输出文件 (标准输出和错误输出合并到 main.log)
nohup python main.py >> main.log 2>&1 &
# 不记录输出信息
nohup python main.py &> /dev/null &
# 不记录输出信息并将程序的进程号写入 pidfile.txt 文件中，方便后续杀死进程
nohup python main.py &> /dev/null & echo $! > pidfile.txt
```

## 重定向 redirect

* redirect output：`[number]>`
* redirect input: `[number]<`
* 0 标准输入
* 1 标准输出
* 2 标准错误输出
	* error messages go to a stream called stderr, which is designated as `2>`
	* 2>&1 错误信息重定向到标准输出
* /dev/null文件:写入到它的内容都会被丢弃，会起到"禁止输出"的效果，如果希望屏蔽stdout和stderr

```sh
ls /void 2> output.log
wc < output.log

command > /dev/null 2>&1

# 重启所有worker进程
kill -USR1 主进程PID

# 仅重启task进程
kill -USR2 主进程PID
```

## 网络 Networking

* Linux内核通过一个虚拟的网桥设备（Net Device）来实现桥接的。这个虚拟设备可以绑定若干个以太网接口，从而将它们连接起来
  - 对于网络协议栈的上层来说，只看到br0。因为桥接是在数据链路层实现的，上层不需要关心桥接的细节，于是协议栈上层需要发送的报文被送到br0，网桥设备的处理代码判断报文被转发到eth0还是eth1，或者两者皆转发
  - 从eth0或者从eth1接收到的报文被提交给网桥的处理代码，在这里判断报文应该被转发、丢弃或者提交到协议栈上层。
* 类型
  - lo  回环接口
  - eth0 或 enp* 以太网接口
  - wlan0 无线网接口
  - ppp0  点对点协议接口（由拨号调制解调器、PPTP VPN 连接或者 USB 调制解调器使用）
  - vboxnet0 或 vmnet* 虚拟机网络接口
* 网络分内网与外网
* 端口
  - 使用
    - 是否暴漏
    - 修改防火墙规则
  - 分类
    + 0 - 1023： 常用端口和系统端口
    + 1024 - 49151： 软件注册端口
    + 49152 - 65535： 动态端口或私有端口
  - /etc/services 文件可以查看到更多关于保留端口的信息
  - 扫描
* 服务：封装的命令行，带有设定的参数、日志记录、运行监控
* 启动服务会生成进程，端口占用
* Linux 中 DNS Resolver 由 glibc/musl 提供，配置文件为 /etc/resolv.conf
  - 首先查看 hosts 文件中有没有该域名的记录，如果有就直接返回了。没找到才会去查找本地 DNS 缓存、别的 DNS 服务器
  - 通过重复使用 nameserver 字段，可以指定多个 DNS 服务器（Linux 最多三个）。DNS 查询会按配置中的顺序选用 DNS 服务器。 **仅在靠前的 DNS 服务器没有响应（timeout）时，才会使用后续的 DNS 服务器！所以指定的服务器中的 DNS 记录最好完全一致**不要把第一个配内网 DNS，第二个配外网
  - 末尾有一行: search lan，指定所谓的 DNS 搜索域
  -  有了搜索域就可以稍微偷点懒，省略掉域名的一部分后缀，让 DNS Resolver 自己去在各搜索域中搜索
* netstat:打印网络连接、路由表、连接的数据统计、伪装连接以及广播域成员
  - `ss -s`
  - 属于net-tools工具集，而ss属于iproute
    + 统计  ifconfig  ss
    + 地址  netstat ip addr
    + 路由  route ip route
    + 邻居  arp ip neigh
    + VPN iptunnel  ip tunnel
    + VLAN  vconfig ip link
    + 组播  ipmaddr ip maddr
  - -a 所有当前连接
  - -t 显示和tcp相关
  - -u 显示和udp相关
  - -x 显示和Unix sockets相关
  - -wa 查看RAW sockets
  - -n|numeric 禁用域名解析功能  默认情况下 netstat 会通过反向域名解析技术查找每个 IP 地址对应的主机名
  - -l 显示处于Listen(监听)状态,不要使用 -a 选项，否则 netstat 会列出所有连接(还有连接)，而不仅仅是监听端口
  - -p|program 显示建立连接的程序名与进程号，必须运行在 root 权限之下，不然它就不能得到运行在 root 权限下的进程名
  - -s|statistics 网络统计数据，包括某个协议下的收发包数量
  - -r 选项打印内核路由信息
  - -ie 打印网络接口信息
  - -c 持续输出信息
  - -ep 可以同时查看进程名和用户名
  - -g 输出 IPv4 和 IPv6 的多播组信息
  - -g 输出 IPv4 和 IPv6 的多播组信息
  - -i 打印网络接口信息
  - -v|verbose shows Active Internet connections and Active UNIX domain sockets without server information.
  - 查看当前系统连接`netstat -antp | awk '{a[$6]++}END{ for(x in a)print x,a[x]}'`
* LISTEN 状态
  - Recv-Q：代表建立的连接还有多少没有被accept，比如Nginx接受新连接变的很慢
  - Send-Q：代表listen backlog值
* ESTAB 状态
  - Recv-Q：内核中的数据还有多少(bytes)没有被应用程序读取，发生了一定程度的阻塞
  - Send-Q：代表内核中发送队列里还有多少(bytes)数据没有收到ack，对端的接收处理能力不强
* 在Linux网络协议栈有一组网络回调函数挂接点，通过这些挂接点函数挂接的钩子函数可以在Linux网络栈处理数据包的过程中对数据包一些操作，例如过滤、修改、丢弃等。整个挂接点技术叫做Iptables和Netfilter
  - Netfilter负责在内核中执行各种各样的挂接规则，运行在内核模式中
  - Iptables是在用户模式下运行的进程，负责协助维护内核中Netfilter的各种规则表
  - 通过二者的配合来实现整个Linux网络协议栈中灵活的数据包处理机制
  - 支持Table类型
    + RAW
    + MANGLE
    + NAT
    + FILTER
    + 优先级是RAW最高，FILTER最低
* Route
  - Linux系统包含了一个完整的路由功能。当IP层在处理数据发送或者转发时，会使用路由表来决定发往哪里。通常情况下，如果主机与目的主机直接相连，那么主机可以直接发送IP报文到目的主机
  - 路由功能是由IP层维护的一张路由表来实现。当主机收到数据报文时，用此表来决策接下来应该做什么操作
  - 当从网络侧接收到数据报文时，IP层首先会检查报文的IP地址是否与主机自身的地址相同。
  - 如果数据报文中的IP地址是自身主机的地址，那么报文将被发送到传输层相应的协议栈中去
  - 如果报文中的IP地址不是主机自身的地址，并且配置了路由功能，那么报文将被转发，否则报文将被丢弃
  - 路由表的数据一般以条目形式存在，一个典型的路由表条目通常包含以下主要条目项：
    + 目的IP地址
    + 下一个路由器的IP地址
    + 标志
    + 网络接口规范
  - 通过路由表转发时，如果任何条目的第一个字段完全匹配目标条目的IP地址（主机）或部分匹配（网络），那么它将指示下一个路由器的IP地址。这些信息将告诉主机数据包该转发到哪一个“下一个路由器”。而条目中所有其它字段将提供更多的辅助信息来为路由转发做决定
  - 如果没有一个完全匹配的IP，则继续搜索网络ID。找到则转发数据到指定路由器上。由此可知，网络上所有主机都是通过这个路由表中的单个条目进行管理
  - 如果上述两个条件都不匹配，则将数据报文转发到一个默认路由器上
  - 如果上述步骤失败，默认路由器也不存在，那么这个数据报文无法转发。任何无法投递的数据都会产生一个ICMP主机不可达或者ICMP网络不可达的错误，并将该错误返回给生成此数据的应用程序
  - the destination IP is bitwise AND’d with the Genmask and if the answer is the destination part of the table then that gateway and interface is picked for routing
  - doesn’t match with any destination in the routing table. Then Linux does an AND of destination IP with 0.0.0.0 and we get 0.0.0.0. This answer matches the default row
* Route Table
  - Local表用于供Linux协议栈识别本地地址，以及进行本地各个不同网络之间的数据转发 `ip route show table local type local`
  - MAIN表用于各类网络IP转发。它的建立既可以使用静态配置生成，也可以使用动态路由发现协议生成。动态路由发现协议一般使用组播功能来通过发送路由发现数据，动态获取和交换网络的路由信息，并更新到路由表中
  - Routing table is processed in the order of more octets of 1 set in genmask and genmask 0.0.0.0 is the default route if nothing matches.
  - gateway 0.0.0.0. This gateway means no Layer3(Network layer) hop is needed to send the packet. Both source and destination are in the same network. Kernel has to figure out the mac of the destination and populate source and destination mac appropriately and send the packet out so that it reaches the destination without any Layer3 hop in the middle
  - gateway 管理：Update the routing table to use another host(container/VM) in the same network as a gateway for 8.8.8.8/32 and run ping 8.8.8.8. Do the packet capture on the new gateway to see L3 hop is working as expected(might need to disable icmp_redirect)
* sar linux上功能最全的监控软件
  - `sar -n DEV 1 `即可每秒刷新一次网络流量
  - `watch cat /proc/net/dev`
  - iftop
* http 抓包:将自身当作代理，能够抓取你的浏览器到服务器之间的通讯，并提供修改、重放、批量执行的功能。是发现问题，分析协议，攻击站点的利器
  - Burpsuite （跨平台)
  - Fiddle2 (Win)
  - Charles (Mac)
* 流量复制
  - Gor(推荐)
  - TCPReplay
  - TCPCopy
* 异常
  - TIME_WAIT一般通过优化内核参数能够解决
    + 主动关闭连接的一方保持的状态，像nginx、爬虫服务器，经常发生大量处于`time_wait`状态的连接。TCP一般在主动关闭连接后，会等待2MS，然后彻底关闭连接。由于HTTP使用了TCP协议，所以在这些频繁开关连接的服务器上，就积压了非常多的TIME_WAIT状态连接
    + dmesg `ss -s`
  - CLOSE_WAIT一般是由于程序编写不合理造成的，更应该引起开发者注意
    + 由于对端主动关闭，而我方没有正确处理的原因引起的。说白了，就是程序写的有问题，属于危害比较大的一种
* 到对端路由检测 tracepath google.com
* 全方位监控工具
  - nmon
* 远程登录
  - telnet
  - [ssh](../network/ssh.md)
* 网桥 Bridge
  - 一个数据链路层（data link）的设备，根据Mac地址的信息转发到网桥的不同端口上.网桥是一个二层的虚拟网络设备，把若干个网络接口“连接”起来，使得网口之间的报文可以转发
  - 网桥能够解析收发的报文，读取目标的Mac地址信息，和自己的Mac地址表结合，来决策报文转发的目标网口
  - 为了实现这些功能，网桥会学习源Mac地址。在转发报文时，网桥只需要向特定的端口转发，从而避免不必要的网络交互。如果它遇到了一个自己从未学过的地址，就无法知道这个报文应该向哪个网口转发，就将报文广播给除了报文来源之外的所有网口
  - 通过一个虚拟的网桥设备（Net Device）来实现桥接的。这个虚拟设备可以绑定若干个以太网接口，从而将它们连接起来。Net Device网桥和普通的设备不同，最明显的是它还可以有一个ip地址
* 为了支持越来越多的网卡以及虚拟设备，所以使用网桥去提供这些设备之间转发数据的二层设备
* Linux内核支持网口的桥接（以太网接口），这与单纯的交换机还是不太一样，交换机仅仅是一个二层设备，对于接受到的报文，要么转发，要么丢弃
* 运行着Linux内核的机器本身就是一台主机，有可能是网络报文的目的地，其收到的报文要么转发，要么丢弃，还可能被送到网络协议的网络层，从而被自己主机本身的协议栈消化

```sh
systemd-resolve --flush-caches # 清理缓存
# /etc/sysctl.conf
net.ipv4.ip_local_port_range = 1024 65535 # 用户端口范围
net.ipv4.tcp_max_syn_backlog = 4096
net.ipv4.tcp_fin_timeout = 30
fs.file-max=65535 # 系统最大文件句柄，控制的是能打开文件最大数量

hostname # 返回系统的主机名称
host xx.xxx.com # 显示某域名相关托管服务器/邮件服务器
hostname  www  #设置主机名为www
# /etc/hostname # 编辑配置文件
www   localhost.localdomain  #修改localhost.localdomain为www

curl http://icanhazip.com # 查看本机IP
curl https://github.com/racaljk/hosts/blob/master/hosts -L >> /etc/hosts

ping -c 次数 ip # 测试网络畅通性
ping 8.8.8.8 # 检测连接
ip addr # 查看IP地址
# Send ICMP echo request to host
ping host

# interface configuration.’ It allows admins to view their network interfaces and assign, add, delete, or control interface parameters
ifconfig -a
# Display eth0 address and details
ifconfig eth0

# 停止某个网卡
ifdown
# 开启某个网卡
ifup
# 多功能管理工具
ethtool

# iwconfig command is very similar to ifconfig, except the fact that it is only for configuring wireless interfaces.
# iwconfig
# iwconfig --help
# man iwconfig

# Query or control network driver and hardware settings
ethtool eth0

# manage network devices, tunnels, routing, and many more
ip addr
# ip link
# ip addr add 192.168.1.XXX/24 dev eth0

# Display whois information for domain
whois google.com

# Display DNS information for domain
dig domain

# Reverse lookup of IP_ADDRESS
dig -x IP_ADDRESS

# querying DNS servers and grab essential information regarding remote servers
nslookup google.com

# display the routes our packets take before reaching a remote destination
traceroute google.com

# Display DNS ip address for domain
host domain

# Display the network address of the host name.
hostname -i

# Display all local ip addresses
hostname -I

# Download http://domain.com/file
wget http://domain.com/file

# Display listening tcp and udp ports and corresponding programs
netstat -nutlp

sudo gedit /etc/modprobe.d/iwlwifi.config add `options iwlwifi 11n_disable=1`

# restrict or block IPs and is used to protect servers from various malicious attacks
iptables -L
service iptables status
service iptables stop # tempory
chkconfig optables off # always

# firewall as default
firewall-cmd --state
firewall-cmd --reload # restart
systemctl status|stop|disable firewalld.service # cancle start with system

## port test
yum install telnet.x86_64
telnet 10.0.3.69 2020  # 测试端口能否访问

netstat -tunlp # 显示tcp，udp的端口和进程等相关
sudo netstat -plunt
netstat -tln | grep 8000
netstat -tunlp|grep (port)  # 指定端口号进程情况
netstat -anp | grep LISTEN # 通过进程id查看占用的端口
netstat -atnp | grep ESTA # 查询建立连接状态
sudo netstat -anp | grep 80 # 通过进程id查看占用的端口
watch -d -n0 "netstat -atnp | grep ESTA" # watch 命令监视 active 状态的连接
netstat -atnp | grep ESTA # 获得 active 状态的连接

ip route | column -t # 显示默认网关和路由表：
netstat -r

# native service
sudo systemctl enable|disable nginx | httpd.service # enable 设置开机启动 disable 使服务不自动启动
sudo systemctl status|start|restart|reload nginx | httpd.service # start 启动 stop 停止 restart 重启
systemctl list-units --type=service # 查看服务

# pidof prints out the process id of a running program. For example, below command will output the process ID of nginx
pidof nginx

# Display all the currently running processes on the system.
ps -ef | grep nginx # 根据进程名查看进程id
ps aux | grep nginx

kill pid
kill -9 pid # 关闭进程
kill -s 9 processId
kill -USR2 $(pidof nginx)
pkill -f nginx

# 退出
ctrl+c   ## 有些程序也可以用q键
ctrl+z   ## 进程会挂起到后台

jobs -l # 后台列表
fg %3   ## 让进程回到前台
bg jobid  ## 让进程在后台继续执行
kill -STOP %job_id

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

# 下载工具
wget -O newname.md https://github.com/LCTT/TranslateProject/blob/master/README.md     ### 下载 README 文件并重命名为 newname.md
wget -c url     ### 下载 url 并开启断点续传

# 查看系统正在监听的tcp连接
ss -atr
ss -atn #仅ip
# 查看系统中所有连接
ss -alt

# 查看监听444端口的进程pid
ss -ltp | grep 444

#查看进程555占用了哪些端口
ss -ltp | grep 555
# 显示所有udp连接
ss -u -a
# 和某个ip的所有连接
ss dst 10.66.224.130
ss dst 10.66.224.130:http
ss dst 10.66.224.130:smtp
ss dst 10.66.224.130:443
# 显示所有的http连接
ss  dport = :http
# 查看连接本机最多的前10个ip地址
netstat -antp | awk '{print $4}' | cut -d ':' -f1 | sort | uniq -c  | sort -n -k1 -r | head -n 10

ss -t -o state established

# sysctl命令可以设置这些参数，如果想要重启生效的话，加入/etc/sysctl.conf文件中
# 修改阈值
net.ipv4.tcp_max_tw_buckets = 50000
# 表示开启TCP连接中TIME-WAIT sockets的快速回收
net.ipv4.tcp_tw_reuse = 1
#启用timewait 快速回收。这个一定要开启，默认是关闭的。
net.ipv4.tcp_tw_recycle= 1
# 修改系統默认的TIMEOUT时间,默认是60s
net.ipv4.tcp_fin_timeout = 10
#测试参数的话，可以使用 sysctl -w net.ipv4.tcp_tw_reuse = 1 这样的命令。如果是写入进文件的，则使用sysctl -p生效。

# 在机器上开放5879端口 server
nc -l -vv -p 5879 -e /bin/bash # 在机器上开放5879端口
# 构造了一个循环
rm -f /tmp/f; mkfifo /tmp/f
cat /tmp/f | /bin/bash -i 2>&1 | nc -l  5879 > /tmp/f

# client
nc -v 192.16.1.54 5879

nc -l 5879 > file
nc -v 192.16.1.54 5879 < redis-5.0.5.tar.gz

nc -vvv baidu.com 443
nc -vzw 2 192.16.1.54 8888-9999 # 扫描主机的端口

## route
# gives the default routing table
route -n
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         172.17.0.1      0.0.0.0         UG    0      0        0 eth0
172.17.0.0      0.0.0.0         255.255.0.0     U     0      0        0 eth0

# IP 108.174.10.10 is AND’d with 255.255.255.0 and the answer we get is 108.174.10.0 which doesn’t match with any destination in the routing table. Then Linux does an AND of destination IP with 0.0.0.0 and we get 0.0.0.0. This answer matches the default row
#
# the packet has to be sent to next hop 172.17.0.1 via eth0. The source IP of the packet will be set as the IP of interface eth0. Now to send the packet to 172.17.0.1
# linux has to figure out the MAC address of 172.17.0.1. MAC address is figured by looking at the internal arp cache which stores translation between IP address and MAC address.
#
# If there is a cache miss, Linux broadcasts ARP request within the internal network asking who has 172.17.0.1. The owner of the IP sends an ARP response which is cached by the kernel and the kernel sends the packet to the gateway by setting Source mac address as mac address of eth0 and destination mac address of 172.17.0.1 which we got just now.
#
# Similar routing lookup process is followed in each hop till the packet reaches the actual server. Transport layer and layers above it come to play only at end servers. During intermediate hops only till the IP/Network layer is involved.
```

### [lsof lists open files](http://www.netadmintools.com/html/lsof.man.html)

* default : without options, lsof lists all open files for active processes
* grouping : it’s possible to group options, e.g. -abC, but you have to watch for which options take parameters
* -h : get help
* -a : AND the results (instead of OR)
* -l : show the userID instead of the username in the output
* -t : get process IDs only
* -U : get the UNIX socket address
* -F : the output is ready for another command, which can be formatted in various ways, e.g. -F pcfn (for process id, command name, file descriptor, and file name, with a null terminator)
* -i Show all connections with
  - `-i 6` Get only IPv6 traffic with
  - `-iTCP`
  - `-i :port` Show networking related to a given port
  - `-i@ip` Show connections to a specific host
* -u Show what a given user has open
* -c See what files and network connections a named command
* -p See what a given process ID has open

```sh
#列出所有的网络链接
lsof -i
#列出所有udp的网络链接
lsof -i udp
#列出谁在使用某个端口
lsof -i :3306
#列出谁在使用特定的tcp端口
lsof -i tcp:80
#根据文件描述范围列出文件信息
lsof -d 2-3

# List all open files on the system
lsof -i -P | grep ssh

lsof -Pni4 | grep LISTEN | grep php

# 查看8080端口占用
lsof -i :8080
lsof -i@172.16.12.5:22

# Find ports that are awaiting connections
lsof -i -sTCP:LISTEN
lsof -i -sTCP:ESTABLISHED

lsof abc.txt # 显示开启文件abc.txt的进程

# 显示syslog-ng进程现在打开的文件
lsof -c syslog-ng

lsof -p 10075
lsof -c -p 1234 # 列出进程号为1234的进程所打开的文件

# HUP processes
lsof -t -c sshd

lsof -g gid # 显示归属gid的进程情况

# Show everything interacting with a given directory
lsof /var/log/messages/
lsof +d /usr/local/ # 显示目录下被进程开启的文件
lsof +D /usr/local/ # 同上，但是会搜索目录下的目录，时间较长

lsof -d 4 # 显示使用fd为4的进程

lsof -i -U # 显示所有打开的端口和UNIX domain文件

# List files opened by user
lsof -u daniel
lsof -u ^daniel
kill -9 `lsof -t -u daniel`

# Show me everything daniel is doing connected to 1.1.1.1
lsof -u daniel -i @1.1.1.1
lsof -i @fw.google.com:2150-2180
```

## 用户管理 User/Group Management

* 用户 User
  - Users in Linux has an associated user ID called UID attached to them.
  - Users also has a home directory and a login shell associated with them
  - `/etc/passwd` Stores the user name, the uid, the gid, the home directory, the login shell etc 存放用户帐号和其相关信息 (密码除外) `用户名:未使用:UID:GID:备注:家目录:shell`
  - `/etc/shadow` Stores the password associated with the users 由于所有用户对 passwd 文件均有读取权限，因此密码信息并未保存在该文件中，而是采用 MD5 加密算法加密保存在了 `/etc/shadow` 中，只有 root 用户可以读取 `用户名:加密密码:上次修改时间:最短使用天数:最长使用天数间:修改前警示天数:过期后宽限时间:未使用`
    + passwd 文件中，一行定义一个用户帐号，每行均由多个不同的字段构成，各字段值间用 ":” 分隔，每个字段均代表该帐号某方面的信息
    + 系统自动创建了 linux 进程或部分服务程序正常工作所需要使用的账户，账户的最后一个字段的值一般为 `/sbin/nologin`，表示该帐号不能用来登录系统`account:password(用 x 占位):accountId:groupId:accountName:homeDir:shell`
    + 让某用户没有 telnet 权限，即不允许该用户利用 telnet 远程登录和访问 linux 操作系统，则设置该用户所使用的 shell 为 `/bin/true` 即可
    + 让用户没有 telnet 和 ftp 登录权限，则可设置该用户的 shell 为 `/bin/false`
    + 每行定义和保存一个账户的相关信息。第一个字段为用户帐户名，第二个字段为账户的密码
    + 设置所有用户账户密码过期的时间，则可通过修改 `/etc/login.defs` 配置文件中的 `PASS_MAX_DAYS` 配置项的值来实现，其默认值为 99999，代表用户账户密码永不过期。其中 `PASS_MIN_LEN` 配置项用于指定账户密码的最小长度，默认为 5 个字符。
  - 新建 `useradd [option] username`
    + verify that the user has been created by tailing the /etc/passwd file
    + The uid and gid are 1000 for the newly created user
    + 不指定用户组的话，默认会自动创建一个与用户名相同的用户组
    + home directory
      * 系统会自动创建该用户对应的主目录，该目录默认放在 `/home` 目录下
      * 家目录修改后需要手动创建，不同于创建用户家目录设置
      * 修改用户家目录时，该目录不会自动创建(需要手动创建)
    + 参数
      * -c 注释      用户设置对账户的注释说明文字
      * -b 设置另一个可以创建家目录的基础目录,指定 /home2 而不是 /home
      * -d 主目录    指定用来取代默认的 / home/username 的主目录
      * -k 会在创建新用户时，复制 /etc/skel 目录下的所有文件到用户的家目录中
      * -m          若主目录不存在，则创建它。-r 与 - m 相结合，可为系统账户创建主目录
      * -e YYYY-MM-DD 的格式指定一个用户的过期时间
      * -M          不创建主目录
      * -e date     指定账户过期的日期。日期格式为 MM/DD/YY
      * -f days     帐号过期几日后永久停权。若指定为 0，则立即被停权，若为 -1，则关闭此功能
      * -g 用户组     指定将用户加入到哪个用户组，该用户组必须存在
      * -G 用户组列表 指定用户同时加入的用户组列表，各组用逗分隔
      * -n          不为用户创建私有用户组
      * -s shell    指定用户登录时使用的 shell，默认为 `/bin/bash`
      * -r          创建一个用户 ID 小于 500 的系统账户，默认不创建对应的主目录
      * -u 用户 ID    手动指定新用户的 ID 值，该值必须唯一，且大于 499
      * -p password 为新建用户指定登录密码。此处的 password 是对应登录密码经 MD5 加密后所得到的密码值，不实真实密码原文，因此在实际应用中，该参数选项使用较少，通常单独使用 passwd 命令来为用户设置登录密码
  - `usermod` modify the attributes of an user like the home directory or the shell
  - `userdel`
  - 锁定：通过在密码文件 `/etc/shadow` 密码字段前加 “！” 来标识该用户被锁定，除了用户账户可被锁定外，账户密码也可被锁定，任何一方被锁定后，都将无法登录系统。只有 root 用户才有权执行该命令
  - LDAP
  - `id username` be used to find the uid and gid associated with an user.
  - `passwd username` create or modify passwords for a user
    + "!!" in an account entry in shadow means the account of an user has been created, but not yet given a password.
  - "root" user or superuser is the most privileged user with unrestricted access to all the resources on the system. It has UID 0
    + 默认情况下在 sudo 用户组里的可以使用 sudo 命令获得 root 权限
  - su username
    + - 切换到对应用户主目录
* 用户组 group
  - A group is a collection of one or more users. A group makes it easier to share permissions among a group of users.
  - Each group has a group ID called GID associated with it.
  - 用户组帐号信息保存在 /etc/group 配置文件中，任何用户均可以读取。用户组的真实密码保存在 /etc/gshadow 配置文件中 `组名:未使用:GID:成员列表`
  - `/etc/group` Stores information about different groups on the system
    + 第一个字段代表用户组的名称
    + 第二个字段为 x
    + 第三个为用户组的 ID 号
    + 第四个为该用户组的用户成员列表，各用户名间用逗号分隔
  - `groupadd \<group_name>`  Creates a new group
  - `groupmod \<group_name>`  Modifies attributes of a group
  - `groupdel \<group_name>`  Deletes a group
  - `gpasswd \<group_name>` Modifies password for group
  - others
  - nobody:nogroup
* [sudo](https://www.sudo.ws/): allows a user to run commands with the security privileges of the root user
  - /etc/sudoers holds the names of users permitted to invoke sudo
  - providing root access to users is to add them to a group which has permissions to run all the commands. "wheel" is a group in redhat Linux with such privileges
  - `%wheel ALL=(ALL) NOPASSWD: ALL`
    + 第一个参数（%wheel）定义组的成员。 wheel 组的成员可以以所有主机上的所有用户身份运行所有应用程序
    + 第二个参数（ALL）定义组成员可以在其上运行命令的主机
    + 第三个参数（(ALL)）定义了可以执行命令的用户名
    + 最后一个参数（ALL）定义可以运行的应用程序
* 系统管理员向其他用户发送消息
  - `wall file`,通过更新文件执行
  - `write username`:交互实时执行
  - `talk username`

```sh
who|w # Show who is logged in and what they are doing.
last # 查看最近的登陆历史记录
whoami # 只列出用户名 用于查询当前用户的名称 find out the current user in Linux is to use the whoami command

who mom likes/who am i # 列出用户名，所使用终端的编号和开启时间

finger # 列出当前用户的详细信息，需使用apt-get提前安装

su <user> # 切换到用户user,执行时需要输入目标用户的密码
su - <user> # 切换用户，同时环境变量也会跟着改变成目标用户的环境变量
su -l lilei # 切换登录用户
su -
su - root

useradd  username # 创建用户会同时创建同名组
sudo useradd -u 1020 -c "Perry Example" \
-G tgroup -b /home2 \
-s /usr/bin/zsh \
-e 20201201 -f 5 perry

getent passwd perry; getent group perry; getent shadow perry; id perry

useradd -m -g users -G tgroup,fgroup,libvirt milly -c "Bailey is cool" -s /usr/bin/bash newuser ### -m 创建 home 目录， -g 所属的主组， -G 指定该用户在哪些附加组， -s 设定默认的 shell ，newuser 为新的用户名
useradd -g 组编号 -u 用户编号 -d 家目录 username # 创建用户同时，指定组别、用户编号、家目录
useradd -d /var/vodup -s /sbin/nologin vodup
id nisj # uid=502(nisj) gid=500(babyfish) groups=500(babyfish) id 命令用于显示当前用户的 uid，gid 和所属的用户组的列表
tail -1 /etc/passwd # nisj:x:502:500::/home/nisj:/bin/bash
sudo adduser lilei # 新建一个叫做lilei的用户，添加用户到系统，同时也会默认为新用户创建 home目录

getent passwd sonny timmy
getent group sonny timmy

usermod  -g gid  username     # 修改组别是常见操作
usermod  -g gid -u uid -d 家目录  -l newname username # 修改组别、用户编号、家目录、名字
usermod techmoe -G sudo # 用户添加进sudo组
usermod [option] username
usermod -l nsj0820 nsj820 # -l newName oldName 改变用户帐户名，主目录仍为原来
usermod -d /home/nsj0820 nsj0820 # 修改主目录
usermod -L user # 锁定账户
usermod -U user # 接锁账户
usermod -a -G group1,group2 username add user "username" to the group1,group2
usermod -G sudo <student>  # </student>不同的组对不同的文件可能具有不同的操作权限，比如说通过上述命令新建的用户默认是没有使用sudo的权限的，我们可以使用usermod命令把它加入sudo组用以具备相应的权限。

# 修改 user test to love
usermod -l love -d /home/love -m test
groupmod -n love test

getent group 1001
groups zhangwang # 查看用户属于那些组（groups）
cat /etc/group | sort # 命令查看某组包含那些成员
sudo usermod -G sudo student # 不同的组对不同的文件可能具有不同的操作权限，比如说通过上述命令新建的用户默认是没有使用sudo的权限的，可以使用usermod命令把它加入sudo组用以具备相应的权限。
sudo usermod -aG sudo,root jacks # add the user 'jacks' to 'root' and 'sudo' group
usermod -a -G groupA user # -a 代表 append， 将自己添加到 用户组 groupA 中，而不必离开其他用户组
sudo deluser student --remove-home # 删除用户及用户相关文件；
userdel username     # 删除用户(删除passwd文件对应信息)，此时其家目录需要手动删除
userdel -r username # -r 在删除该账户的同时，一并删除该账户对应的主目录

passwd 用户名  # 设定密码:只有 root 用户才有权设置指定账户的密码。一般用户只能设置或修改自己账户的密码（不带参数）
sudo passwd username # 强制修改用户密码，没有密码强度限制
passwd -l 帐户名
passwd -u 帐户名 # 解锁账户密码
passwd -S 账户名 # 查询当前账户的密码是否被锁定
passwd -d 帐户名 # 帐户密码被删除后，将不能登录系统，除非重新设置密码 该命令也只有 root 用户才有权执行

chgrp [-options] [群组名] [文档路径]

groupadd [r] group_name # 创建用户组,命令带有 - r 参数，则创建系统用户组，该类用户组的 GID 值小于 500；若没有 - r 参数，则创建普通用户组，其 GID 值大于或等于 500.
groupmod -n new_group_name old_group_name # 重命名一个用户组
groupmod -g new_GID 用户组名称 # 重设用户组的 GID,但不能与已有用户组的 GID 值重复
groupdel group_name # 删除用户组
groupmod -g gid  -n newname  groupname

gpasswd -a 用户账户  用户组名 # 可以将用户添加到指定的组，使其成为该组的成员
gpasswd -d 用户账户  用户组名 # 若要从用户组中移除某用户

groups nisj # groups 用于产看指定用户所隶属的用户组
gpasswd -A 用户账户 要管理的用户组 # 将指定的用户设置为指定用户组的用户管理员。用户管理员只能对授权的用户组进行用户管理 (添加用户到组或从组中删除用户)，无权对其他用户组进行管理。

choot

# 修改用户
henry:x:1000:1000:henry.li,,,:/home/henry:/bin/bash

# 关掉sudo的密码:所有sudo组内的用户使用sudo时就不需要密码
sudo visudo

%sudo   ALL=(ALL:ALL) ALL # change
%sudo   ALL=(ALL:ALL) NOPASSWD:ALL

# 关闭root账号登陆和使用密码登陆
# /etc/ssh/sshd_config
PermitRootLogin no # 关闭root账号登陆
PasswordAuthentication yes # 关闭密码登陆
systemctl reload ssh.service
```

## [Openssl](https://www.openssl.org/)

a robust, commercial-grade, and full-featured toolkit for the Transport Layer Security (TLS) and Secure Sockets Layer (SSL) protocols. It is also a general-purpose cryptography library

```sh
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
    LANGUAGE = (unset),
    LC_ALL = (unset),
    LANG = "en_US.UTF-8"
are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").

# .bashrc
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# openssl: error while loading shared libraries: libcrypto.so.1.1: cannot open shared object file: No such file or directory

ln -s /usr/local/openssl/lib/libssl.so.1.1 /usr/lib/libssl.so.1.1
ln -s /usr/local/openssl/lib/libcrypto.so.1.1 /usr/lib/libcrypto.so.1.1

su  # 切回root  不需要密码
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
du -f --max-depth=[遍历文件夹的深度] [file/folder] # 读性好的查看文件空间
! df -h # local

get /etc/group
!less group # 参看本地文件
```

## 虚拟化

* Hypervisor：Linux的最重要创新之一，引入Hypervisor，运行其他操作系统的操作系统，它们为执行提供独立的虚拟硬件平台，同时硬件虚拟平台可以提供对底层机器的虚拟的完整访问.在解决软件架构设计问题时，通常做法是引入一个抽象层来解决，其实这种做法是有点普世原理，同样适用于硬件封装，Hypervisor正是这样一种虚拟抽象层。
  - 只有5%的时间在全负荷工作，其他时间则处于休眠或者空闲状态，虚拟化技术可以大大提升服务器的利用率，从而间接减少服务器数量，即成本
  - Hypervisor作为虚拟技术的核心，抽象虚拟化硬件平台.它支持给每一个虚拟机分配内存，CPU，网络和磁盘，并加载虚拟机的客户操作系统。当然，在获取到这么优秀功能（对硬件的虚拟化，并搭载操作系统）的代价，自然牺牲了启动速度及在资源利用率，性能的开销等
* LXC(Linux Container）：一种内核虚拟化技术，相比上述的Hypervisor技术则提供更轻量级的虚拟化，以隔离进程和资源，且无需提供指令解析机制及全虚拟化的复杂性，
  - LXC或者容器将操作系统层面的资源分到孤立／隔离的组中，用来管理使用资源。
  - LXC为Sourceforge上的开源项目，其实现是借助Linux的内核特性，（cgroups子系统+namespace）,在OS层次上做整合为进程提供虚拟执行环境，即称之为容器，除了分配绑定cpu，内存，提供独立的namespace（网络，pid，ipc，mnt，uts）

![](../_static/Hypervisor.jpg)

## Samba

```sh
sudo apt-get install samba samba-common
sudo apt-get autoremove samba

mkdir /home/myshare
chmod 777 /home/myshare

sudo smbpasswd  -a  henry # add user
sudo ufw allow 'Samba'
# /etc/samba/smb.conf 添加下列设定
 ntlm auth = yes
#======================= Share Definitions =====================

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

sudo service samba|smbd status|start|stop|restart

# mac 链接 finder中com＋K
smb://192.168.100.106
# windows cmd
\\192.168.182.188

# windows access internet \\192.168.1.13 share
```

## 日志 log

* Syslog
* tracelog
* logrotate
  - 为系统监控和故障排查保留必要的日志内容，同时又防止过多的日志造成单个日志文件太大
  - 在一组日志文件之中，编号最大的（最旧的）一个日志文件会被删除，其余的日志文件编号则依次增大并取代较旧的日志文件，而较新的文件则取代它作为当前的日志文件
  - crontab 会每天定时执行 /etc/cron.daily 目录下的脚本  logrotate
  - 配置路径：`/etc/logrotate.d`
    + /usr/sbin/logrotate -- the logrotate command itself (the executable)
    + /etc/cron.daily/logrotate -- the shell script that runs logrotate on a daily basis (note that it might be /etc/cron.daily/logrotate.cron on some systems)
    + /etc/logrotate.conf -- the log rotation configuration file
    + /var/lib/logrotate/status file -- created when /etc/cron.daily/logrotate runs, shows the date and time when each of the log files was last rotated
  - 手动执行：`logrotate -f /etc/logrotate.d/rsyslog`
  - `logrotate -f /etc/logrotate.d/nginx`
  - [Linux 日志切割神器 logrotate 原理介绍和配置详解](https://wsgzao.github.io/post/logrotate/)

```sh
journal -u docker

journalctl -b -1 # 命令可以重现上一次启动时候的信息
journalctl -b -2 # 可以重现倒数第 2 次启动
systemd-analyze blame # 这个命令可以显示进程耗时

/etc/logrotate.d/nginx
// /var/log/nginx/*.log {
  # 打包日志频率 daily:每天 weekly:每周 monthly:每月
  daily
  # 打包文件添加日期后缀
  dateext
  # 找不到日志也ok
  missingok
  # 保存14份日志
  rotate 14
  # 压缩日志 默认gzip
  compress
  # 延时压缩到下次rotate
  delaycompress
  # 忽略空日志
  notifempty
  # ？
  create 0640 www-data adm
  # 执行完所有rotate再执行脚本
  sharedscripts
  # ?
  prerotate
          if [ -d /etc/logrotate.d/httpd-prerotate ]; then \
                  run-parts /etc/logrotate.d/httpd-prerotate; \
          fi \
  endscript
  # ？
  postrotate
          invoke-rc.d nginx rotate >/dev/null 2>&1
  endscript
}
```

### [Stacer](https://github.com/oguzhaninan/Stacer)

Linux System Optimizer and Monitoring

```sh
sudo add-apt-repository ppa:oguzhaninan/stacer
sudo apt-get update
sudo apt-get install stacer
```

### tr

```sh
grep "20 Jan 2017" jan2017articles.csv | tr ',' '\t' > jan20only.tsv
```

## sort

* 对于文本进行排序
* -l 按照当前环境排序
* -m 合并已经排序好的文件,不排序
* -n 按照字符串的数值顺序比较,暗含-b
* -r 颠倒比较的结果

```sh
sort -nr -t$'\t' -k8 jan20only.tsv | head -n 1
```

## cut

```sh
cut -d',' -f3 jan17no_headers.csv > authors.txt
```

## XMonad

* 用Haskell写的平铺窗口管理器。XMonad提供的各种自动布局和简单易学的快捷键使得它从键盘操作桌面非常自然。而且还有大多数基于活动的终端和面向键盘的工具
* 功能：
  - 极简主义和高度可配置。默认配置中几乎没有窗户装饰和工具栏，而且可以大范围进行定制
  - 面向键盘，友好的用户体验
  - 平铺。不必手动排列窗口
  - 如果使用鼠标，光标所在的窗口自动获得焦点

## [modern-unix](https://github.com/ibraheemdev/modern-unix)

* A collection of modern/faster/saner alternatives to common unix commands.
* [`bat`](https://github.com/sharkdp/bat) A `cat` clone with syntax highlighting and Git integration.
* [`exa`](https://github.com/ogham/exa) A modern replacement for `ls`.
* [`lsd`](https://github.com/Peltoche/lsd) The next gen file listing command. Backwards compatible with `ls`.
* [`delta`](https://github.com/dandavison/delta) A viewer for `git` and `diff` output
* [`dust`](https://github.com/bootandy/dust) A more intutive version of `du` written in rust.
* [`duf`](https://github.com/muesli/duf) A better `df` alternative
* [`broot`](https://github.com/Canop/broot) A new way to see and navigate directory `tree`s
* [`fd`](https://github.com/sharkdp/fd) A simple, fast and user-friendly alternative to `find`.
* [`ripgrep`](https://github.com/BurntSushi/ripgrep) An extremely fast alternative to `grep` that respects your gitignore
* [`ag`](https://github.com/ggreer/the_silver_searcher) A code searching tool similar to `ack`, but faster.
* [`fzf`](https://github.com/junegunn/fzf) A general purpose command-line fuzzy finder.
* [`mcfly`](https://github.com/cantino/mcfly) Fly through your shell `history`. Great Scott!
* [`choose`](https://github.com/theryangeary/choose)  A human-friendly and fast alternative to `cut` and (sometimes) `awk`
* [`jq`](https://github.com/stedolan/jq) `sed` for JSON data.
* [`sd`](https://github.com/chmln/sd) An intuitive find & replace CLI (`sed` alternative).
* [`cheat`](https://github.com/cheat/cheat)
* [`tldr`](https://github.com/tldr-pages/tldr) A community effort to simplify `man` pages with practical examples. Create and view interactive cheatsheets on the command-line.
* [`bottom`](https://github.com/ClementTsang/bottom) Yet another cross-platform graphical process/system monitor.
* [`glances`](https://github.com/nicolargo/glances) Glances an Eye on your system. A `top`/`htop` alternative for GNU/Linux, BSD, Mac OS and Windows operating systems.
* [`gtop`](https://github.com/aksakalli/gtop)

System monitoring dashboard for terminal.
* # [`hyperfine`](https://github.com/sharkdp/hyperfine) A command-line benchmarking tool.
* # [`gping`](https://github.com/orf/gping) `ping`, but with a graph.
* # [`procs`](https://github.com/dalance/procs) A modern replacement for `ps` written in Rust.
* # [`httpie`](https://github.com/httpie/httpie) A modern, user-friendly command-line HTTP client for the API era.
* # [`curlie`](https://github.com/rs/curlie) The power of `curl`, the ease of use of `httpie`.
* # [`xh`](https://github.com/ducaale/xh) A friendly and fast tool for sending HTTP requests. It reimplements as much as possible of HTTPie's excellent design, with a focus on improved performance.
* # [`zoxide`](https://github.com/ajeetdsouza/zoxide) A smarter `cd` command inspired by `z`.
* # [`dog`](https://github.com/ogham/dog) A user-friendly command-line DNS client. `dig` on steroids

## [技巧](https://coolshell.cn/articles/8883.html)

* 基础
  - 了解 ssh
    + 明白不需要口令的用户认证（通过ssh-agent, ssh-add），学会用ssh翻墙，用scp而不是ftp传文件
    + scp 远端的时候，你可以按tab键来查看远端的目录和文件
  - bash的作业管理，如： &, Ctrl-Z, Ctrl-C, jobs, fg, bg, kill, 等等。当然，你也要知道Ctrl+\（SIGQUIT）和Ctrl+C （SIGINT）的区别
  - 文件管理 ： ls 和 ls -l (最好知道 “ls -l” 的每一列的意思), less, head, tail 和 tail -f, ln 和 ln -s (你知道明白hard link和soft link的不同和优缺点), chown, chmod, du (如果你想看看磁盘的大小 du -sk *), df, mount。当然，原作者忘了find命令
  - 基础的网络管理：ip 或 ifconfig, dig。当然，原作者还忘了如netstat, ping, traceroute, 等
  - 理解正则表达式，还有grep/egrep的各种选项。比如： -o, -A, 和 -B 这些选项是很值得了解的
  - 学习使用 apt-get 和 yum 来查找和安装软件（前者的经典分发包是Ubuntu，后者的经典分发包是Redhat），我还建议你试着从源码编译安装软件
* 日常
  - 在 bash 里，使用 Ctrl-R 而不是上下光标键来查找历史命令
  - 在 bash里，使用 Ctrl-W 来删除最后一个单词，使用 Ctrl-U 来删除一行。请man bash后查找Readline Key Bindings一节来看看bash的默认热键，比如：Alt-. 把上一次命令的最后一个参数打出来，而Alt-* 则列出你可以输入的命令。
  - pstree -p 可以帮你显示进程树。（读过我的那篇《一个fork的面试题》的人应该都不陌生）
  - 使用 pgrep 和 pkill 来找到或是kill 某个名字的进程。 (-f 选项很有用).
  - 了解可以发给进程的信号。例如：要挂起一个进程，使用 kill -STOP [pid]. 使用 man 7 signal 来查看各种信号，使用kill -l 来查看数字和信号的对应表
  - 使用 nohup 或  disown 如果要让某个进程运行在后台。
  - 在bash的脚本中，可以使用 set -x 来debug输出。使用 set -e 来当有错误发生的时候abort执行。考虑使用 set -o pipefail 来限制错误。还可以使用trap来截获信号（如截获ctrl+c）。
  - 在bash 脚本中，subshells (写在圆括号里的) 是一个很方便的方式来组合一些命令。一个常用的例子是临时地到另一个目录中，例如： `(cd /some/other/dir; other-command)`
  - 在 bash 中，注意那里有很多的变量展开。如：检查一个变量是否存在: `${name:?error message}`。如果一个bash的脚本需要一个参数，也许就是这样一个表达式 `input_file=${1:?usage: $0 input_file}`。一个计算表达式：` i=$(( (i + 1) % 5 ))`。一个序列： {1..10}。 截断一个字符串： ${var%suffix} 和 ${var#prefix}。 示例： if var=foo.pdf, then echo ${var%.pdf}.txt prints “foo.txt”.
  - 通过 <(some command) 可以把某命令当成一个文件。示例：比较一个本地文件和远程文件 /etc/hosts： diff /etc/hosts <(ssh somehost cat /etc/hosts)
  - 了解什么叫 “here documents” ，就是诸如 cat <<EOF 这样的东西。
  - 在 bash中，使用重定向到标准输出和标准错误。如： some-command >logfile 2>&1。另外，要确认某命令没有把某个打开了的文件句柄重定向给标准输入，最佳实践是加上 “</dev/null”，把/dev/null重定向到标准输入。
  - 使用 man ascii 来查看 ASCII 表
  - 在远端的 ssh 会话里，使用 screen 或 dtach 来保存你的会话。（参看《28个Unix/Linux的命令行神器》）
  - 要来debug Web，试试curl 和 curl -I 或是 wget 。我觉得debug Web的利器是firebug，curl和wget是用来抓网页的，呵呵。
  - 把 HTML 转成文本： lynx -dump -stdin
  - 如果要处理XML，使用 xmlstarlet
  - 对于 Amazon S3， s3cmd 是一个很方便的命令（还有点不成熟）
  - 在 ssh 中，知道怎么来使用ssh隧道。通过 -L or -D (还有-R) ，翻墙神器。
  - 可以对 ssh 做点优化。比如，.ssh/config 包含着一些配置：避免链接被丢弃，链接新的host时不需要确认，转发认证，以前使用压缩（如果你要使用scp传文件）：
  - 如果输了个命令行，但是改变注意了，但又不想删除它，因为要在历史命令中找到它，但也不想执行它。按下 Alt-# ，于是这个命令关就被加了一个#字符，于是就被注释掉了。
* 数据处理
  - 了解 sort 和 uniq 命令 (包括 uniq 的 -u 和 -d 选项).
  - 了解用 cut, paste, 和 join 命令来操作文本文件。很多人忘了在cut前使用join。
  - 如果你知道怎么用sort/uniq来做集合交集、并集、差集能很大地促进你的工作效率。假设有两个文本文件a和b已解被 uniq了，那么，用sort/uniq会是最快的方式，无论这两个文件有多大（sort不会被内存所限，你甚至可以使用-T选项，如果你的/tmp目录很小）
  - 了解和字符集相关的命令行工具，包括排序和性能。很多的Linux安装程序都会设置LANG 或是其它和字符集相关的环境变量。这些东西可能会让一些命令（如：sort）的执行性能慢N多倍（注：就算是你用UTF-8编码文本文件，你也可以很安全地使用ASCII来对其排序）。如果你想Disable那个i18n 并使用传统的基于byte的排序方法，那就设置export LC_ALL=C （实际上，你可以把其放在 .bashrc）。如果这设置这个变量，你的sort命令很有可能会是错的。
  - 了解 awk 和 sed，并用他们来做一些简单的数据修改操作。例如：求第三列的数字之和： awk ‘{ x += $3 } END { print x }’。这可能会比Python快3倍，并比Python的代码少三倍。
  - 使用 shuf 来打乱一个文件中的行或是选择文件中一个随机的行。
  - 了解sort命令的选项。了解key是什么（-t和-k）。具体说来，你可以使用-k1,1来对第一列排序，-k1来对全行排序。
  - Stable sort (sort -s) 会很有用。例如：如果你要想对两例排序，先是以第二列，然后再以第一列，那么你可以这样：` sort -k1,1 | sort -s -k2,2`
  - 输入一个Tab字符（比如：你想在sort -t选项后输入`<tab>字符`），你可以先按Ctrl-V，然后再按Tab键，就可以输入`<tab>`字符。当然，也可以使用`$’\t’`。
  - 如果想查看二进制文件，可以使用hd命令（在CentOS下是hexdump命令），如果想编译二进制文件，可以使用bvi命令（http://bvi.sourceforge.net/）
  - 另外，对于二进制文件，你可以使用strings（配合grep等）来查看二进制中的文本。
  - 对于文本文件转码，你可以试一下 iconv。或是试试更强的 uconv 命令（这个命令支持更高级的Unicode编码）
  - 分隔一个大文件使用split命令（split by size）和csplit命令（split by a pattern）
* 系统调试
  - 如果想知道磁盘、CPU、或网络状态，使用 iostat, netstat, top (或更好的 htop), 还有 dstat 命令。你可以很快地知道你的系统发生了什么事。关于这方面的命令，还有iftop, iotop等（参看《28个Unix/Linux的命令行神器》）
  - 要了解内存的状态，你可以使用free和vmstat命令。具体来说，你需要注意 “cached” 的值，这个值是Linux内核占用的内存。还有free的值。
  - Java 系统监控有一个小的技巧是，你可以使用`kill -3 <pid>` 发一个SIGQUIT的信号给JVM，可以把堆栈信息（包括垃圾回收的信息）dump到stderr/logs。
  - 使用 mtr 会比使用 traceroute 要更容易定位一个网络问题。
  - 如果你要找到哪个socket或进程在使用网络带宽，你可以使用 iftop 或 nethogs。
  - Apache的一个叫 ab 的工具是一个很有用的，用quick-and-dirty的方式来测试网站服务器的性能负载的工作。如果你需要更为复杂的测试，你可以试试 siege。
  - 如果要抓网络包的话，试试 wireshark 或 tshark。
  - 了解 strace 和 ltrace。这两个命令可以让你查看进程的系统调用，这有助于你分析进程的hang在哪了，怎么crash和failed的。你还可以用其来做性能profile，使用 -c 选项，可以使用-p选项来attach上任意一个进程
  - 了解用ldd命令来检查相关的动态链接库。注意：ldd的安全问题
  - 使用gdb来调试一个正在运行的进程或分析core dump文件。参看我写的《GDB中应该知道的几个调试方法》
  - 学会到 /proc 目录中查看信息。这是一个Linux内核运行时记录的整个操作系统的运行统计和信息，比如：` /proc/cpuinfo, /proc/xxx/cwd, /proc/xxx/exe, /proc/xxx/fd/, /proc/xxx/smaps`.
  - 如果调试某个东西为什么出错时，sar命令会有用。可以让看看 CPU, 内存, 网络, 等的统计信息。
  - 使用 dmesg 来查看一些硬件或驱动程序的信息或问题

```sh
# c is a union b 并集
cat a b | sort | uniq > c
# c is a intersect b 交集
cat a b | sort | uniq -d > c
# c is set difference a - b 差集
cat a b b | sort | uniq -u > c
```

## 教程

* [Introduction to Linux](https://www.ibm.com/developerworks/linux/newto/) – 来自IBM的教程，用于给那些想学习Linux的人
* [Linux Desktop 101](https://www.lifewire.com/learn-how-linux-4102755):14周课时的教程，主要用于学校里教学生如何在一个PC上运行一个Linux操作系统
* [Getting Started with Linux](https://www.linux.org/lessons/beginner/index.html) – 来自Linux Online 的20课时的用于新手的教程
* [IBM’s Technical Library](https://www.ibm.com/developerworks/views/linux/libraryview.jsp?type_by=Tutorials) – IBM’s Technical Library 提供的一组给高级Linux用户的教程
* [Linux-Tutorial](https://github.com/judasn/Linux-Tutorial):《Java 程序员眼中的 Linux》
* [Edx basic linux commands course](https://courses.edx.org/courses/course-v1:LinuxFoundationX+LFS101x+1T2020/course/)
* [Edx Red Hat Enterprise Linux Course](https://courses.edx.org/courses/course-v1:RedHat+RH066x+2T2017/course/)

### [Linux From Scratch](http://www.linuxfromscratch.org/)

a project that provides you with step-by-step instructions for building your own custom Linux system, entirely from source code

## 图书

* Essential System Administration: Tools and Techniques for Linux and Unix Administration by Æleen Frisch
* Learning the UNIX Operating System, Fifth Edition by Jerry Peek , Grace Todino-Gonguet , John Strang
* Linux in a Nutshell: A Desktop Quick Reference by Ellen Siever and Stephen Figgins
* Classic Shell Scripting  by Arnold Robbins and Nelson H.F. Beebe
* 《Sed & Awk》  by Dale Dougherty
* Learning the vi and Vim Editors: Text Processing at Maximum Speed and power  Arnold Robbins
* bash Cookbook : Solutions and Examples for bash Users by Carl Albing
* Bash Pocket Reference: Help for Power Users and Sys Admins  By Armold Robbins
* TCP/IP Network Administration (3rd Edition; O’Reilly Networking) by Craig Hunt
* DNS and BIND by Cricket Liu
* Linux 内核完全解析
* 《[Linux内核设计与实现（第3版）》奠定基础的书籍
* [Understanding the Linux Kernel 深入理解Linux内核]
* 《[深入Linux内核架构](https://www.amazon.cn/gp/product/B003QN7J7U)》
* Linux 内核源代码情景分析
* [Linux 内核揭密](https://xinqiu.gitbooks.io/linux-insides-cn/content/index.html)
  - [linux-insides-zh](https://github.com/MintCN/linux-insides-zh) 
* 《Linux高性能服务器编程》
* 《POSIX多线程程序设计》
* 《Linux多线程服务端编程》
* 《Unix/Linux 编程实践教程》
* 《Linux/UNIX系统编程手册》
* 《[Linux系统编程（第2版）](https://www.amazon.cn/gp/product/B00JUM2ML4)》
* LINUX 操作系统(第2版)
* [Advanced Linux Programming Linux 环境高级编程](https://mentorembedded.github.io/advancedlinuxprogramming/)
  - 学习系统编程接口、系统调用 API 、内存管理、进程间通信（ IPC ）
* [《鸟哥的Linux私房菜:基础学习篇(第3版)》](http://linux.vbird.org/)
* 《鸟哥的Linux私房菜:服务器架设篇(第3版)》
* Linux运维之道
* 嵌入式Linux基础教程(第2版)
* 精通Linux设备驱动程序开发
* 《只是为了好玩:Linux 之父林纳斯自传》

## 工具

* [smenu](https://github.com/p-gen/smenu):Terminal utility that allows you to use words coming from the standard input to create a nice selection window just below the cursor. Once done, your selection will be sent to standard output. More in the Wiki
* [up](https://github.com/akavel/up):Ultimate Plumber is a tool for writing Linux pipes with instant live preview
* [bcc](https://github.com/iovisor/bcc):BCC - Tools for BPF-based Linux IO analysis, networking, monitoring, and more
* Monitor
  - [Monit](https://mmonit.com/monit/):功能异常强大的进程、文件、设备、系统监控软件，适用于Linux/Unix系统 With all features needed for system monitoring and error recovery. It's like having a watchdog with a toolbox on your server
  - [bashtop](https://github.com/aristocratos/bashtop):Linux resource monitor
  - [Cockpit](https://cockpit-project.org/):The easy-to-use, integrated, glanceable, and open web-based interface for your servers
* [systemd](https://github.com/systemd/systemd):systemd is a suite of basic building blocks for a Linux system. It provides a system and service manager that runs as PID 1 and starts the rest of the system. systemd provides aggressive parallelization capabilities, uses socket and D-Bus activation for starting services, offers on-demand starting of daemons, keeps track of processes using Linux control groups, maintains mount and automount points, and implements an elaborate transactional dependency-based service control logic.
* [LTF](https://github.com/843723683/LTF):Linux test framework
* [ServerCat - Linux Status & SS‪H‬](link) apple 客户端
* [GNU parallel](http://www.gnu.org/software/parallel/)a shell tool for executing jobs in parallel using one or more computers.

## 参考

* [The Linux Kernel documentation](https://www.kernel.org/doc/html/latest/index.html)
* [Awesome-Linux-Software](https://github.com/luong-komorebi/Awesome-Linux-Software):A list of awesome applications, software, tools and other materials for Linux distros. https://luong-komorebi.github.io/Awesome-Linux-Software/
* [awesome-linux](https://github.com/inputsh/awesome-linux):🐧 A list of awesome projects and resources that make Linux even more awesome. 🐧
* [Command-line-text-processing](https://github.com/learnbyexample/Command-line-text-processing):From finding text to search and replace, from sorting to beautifying text and more
* [面向 Linux 程序员和系统管理员的技术资源](https://www.ibm.com/developerworks/cn/linux/)
* [HAPPY HACKING LINUX](https://azer.bike/happy-hacking-linux/)
* [linuxkit](https://github.com/linuxkit/linuxkit):A toolkit for building secure, portable and lean operating systems for containers
* [Linux Performance](http://www.brendangregg.com/linuxperf.html)
* [linux-perf-examples](https://github.com/feiskyer/linux-perf-examples):《Linux 性能优化实战》案例
* [test-your-sysadmin-skills](https://github.com/trimstray/test-your-sysadmin-skills):A collection of *nix Sysadmin Test Questions and Answers. Test your knowledge and skills in different fields with these Q/A.
* [linux-insides)](https://github.com/0xAX/linux-insides) A little bit about a linux kernel https://0xax.gitbooks.io/linux-insides/content/index.html
* [the-practical-linux-hardening-guide](https://github.com/trimstray/the-practical-linux-hardening-guide):🔥 This guide details the planning and the tools involved in creating a secure Linux production systems - work in progress.
* [Linux Hardening Guide](https://madaidans-insecurities.github.io/guides/linux-hardening.html)
* [VITUX](https://vitux.com) Linux Compendium
* [Borg+Vorta is finally a usable backup solution for Linux desktop](https://simon-frey.com/blog/borgvorta-is-finally-a-usable-backup-solution-for-linux-desktop/)
* [The Linux Documentation Project](https://tldp.org/)
  - [From DOS/Windows to Linux HOWTO](https://tldp.org/HOWTO/DOS-Win-to-Linux-HOWTO.html)
  - [Hands-On Introduction to Linux](http://tldp.org/LDP/intro-linux/html/index.html)

* [linux-command](https://github.com/jaywcjlove/linux-command):Linux命令大全搜索工具，内容包含Linux命令手册、详解、学习、搜集。https://git.io/linux
	
* [linux 指令](https://www.yuque.com/books/share/742ca8f6-34f3-41ef-b239-be00aaf0df31)

* [LVS：跑在Linux内核上的负载均衡器](https://liangshuang.name/2017/11/19/lvs/)
* [全面理解Linux性能优化](https://mp.weixin.qq.com/s/C7KDLcHUhr7QR2hq_pm4kA)	
* [linux 内存管理初探](https://mp.weixin.qq.com/s?__biz=MzA3OTgyMDcwNg==&mid=2650636296&idx=1&sn=48ca904ca1e71ffb467fb0befdd39853&chksm=87a482c5b0d30bd3da8d6fba90d8eb17438103806bb99d20c8713dd67af7929833ceea7502ab)
* [十五分钟制作一个属于自己得Linux操作系统](https://mp.weixin.qq.com/s?__biz=MzA3OTgyMDcwNg==&mid=2650636229&idx=1&sn=5904d82ee06d0e78a6140e1905bd06f0&chksm=87a47d08b0d3f41e592774b07f2977876f42e4d14d7f148e53f0f805d249bd20cdd83495a337)
	
* [Linux 知识](https://mp.weixin.qq.com/s/CK7OZXNkMgfVnf-0ZwuuZA)
