# Linux

[torvalds/linux](https://github.com/torvalds/linux): Linux kernel source tree

以Ubuntu为主要使用系统，不用修改hosts can access google

UNIX/Linux 本身是没有图形界面的，我们通常在 UNIX/Linux 发行版上看到的图形界面实际都只是运行在 Linux 系统之上的一套软件,而 Linux 上的这套软件以前是 XFree86，现在则是 xorg（X.Org），而这套软件又是通过 X 窗口系统（X Window System，也常被称为 X11 或 X）实现的，X 本身只是工具包及架构协议，而 xorg 便是 X 架构规范的一个实现体，也就是说它是实现了 X 协议规范的一个提供图形界面服务的服务器，就像实现了 http 协议提供 web 服务的 Apache 。如果只有服务器也是不能实现一个完整的桌面环境的，当然还需要一个客户端，我们称为 X Client，像如下几个大家熟知也最流行的实现了客户端功能的桌面环境 KDE，GNOME，XFCE，LXDE 。

Linux 是一个可以实现多用户登陆的操作系统，多用户可以同时登陆同一台主机，共享主机的一些资源，不同的用户也分别有自己的用户空间，可用于存放各自的文件。虽然不同用户的文件是放在同一个物理磁盘上的甚至同一个逻辑分区或者目录里，但是由于 Linux 的用户管理和 文件权限机制，不同用户不可以轻易地查看、修改彼此的文件。

## 目录结构

Linux 文件系统是一个目录树的结构，文件系统结构从一个根目录开始，根目录下可以有任意多个文件和子目录，子目录中又可以有任意多个文件和子目录

* bin   存放二进制可执行文件(ls,cat,mkdir等)
* boot  存放用于系统引导时使用的各种文件
* dev   用于存放设备文件
* etc    存放系统配置文件
* home  存放所有用户文件的根目录
* lib    存放跟文件系统中的程序运行所需要的共享库及内核模块
* mnt   系统管理员安装临时文件系统的安装点
* opt    额外安装的可选应用程序包所放置的位置
* proc   虚拟文件系统，存放当前内存的映射
* root   超级用户目录
* sbin   存放二进制可执行文件，只有root才能访问
* tmp   用于存放各种临时文件
* usr    用于存放系统应用程序，比较重要的目录/usr/local 本地管理员软件安装目录
* var    用于存放运行时需要改变数据的文件

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
declare tmp // 使用 declare 命令创建一个变量名为 tmp 的变量
tmp=God // 使用 = 号赋值运算符，将变量 tmp 赋值为 God
echo $tmp // 读取变量的值：使用 echo 命令和 $ 符号（$ 符号用于表示引用一个变量的值）
set:显示当前 Shell 所有变量，包括其内建环境变量（与 Shell 外观等相关），用户自定义变量及导出的环境变量。
env:显示与当前用户相关的环境变量，还可以让命令在指定环境中运行
export：显示从 Shell 中导出成环境变量的变量
unset temp : 删除变量temp
```

## 虚拟机

* 用WinSCP.exe等工具上传系统镜像文件rhel-server-7.0-x86_64-dvd.iso到/usr/local/src目录
* 使用Putty.exe工具远程连接到RHEL服务器
* 挂载系统镜像文件

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
ping www.baidu.com  #测试网络是否正常

ip addr # 查看IP地址
```

### 镜像挂载

```sh
mkdir /media/cdrom  #新建镜像文件挂载目录
cd /usr/local/src  #进入系统镜像文件存放目录
ls  #列出目录文件，可以看到刚刚上传的系统镜像文件
mount -t iso9660 -o loop /usr/local/src/rhel-server-7.0-x86_64-dvd.iso  /media/cdrom #挂载系统镜像
cd  /media/cdrom  #进入挂载目录，使用ls命令可以看到已经有文件存在了

umount  /media/cdrom  #卸载系统镜像

vi /etc/fstab   #添加以下代码。实现开机自动挂载
/usr/local/src/rhel-server-7.0-x86_64-dvd.iso  /media/cdrom   iso9660    defaults,ro,loop  0 0
```


## 硬件

```sh
df -T
```

## 软件

### 在线安装

- 在本地的一个数据库中搜索关于 cowsay 软件的相关信息
- 根据这些信息在相关的服务器上下载软件安装
- 安装某个软件时，如果该软件有其它依赖程序，系统会为我们自动安装所以来的程序；
- 如果本地的数据库不够新，可能就会发生搜索不到的情况，这时候需要我们更新本地的数据库，使用命令sudo apt-get update可执行更新；
- 软件源镜像服务器可能会有多个，有时候某些特定的软件需要我们添加特定的源；

```sh
sudo apt-get install cowsay` `source ~/.zshrc

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

systemctl start httpd.service  #启动apache
systemctl stop httpd.service  #停止apache
systemctl restart httpd.service  #重启apache
systemctl enable httpd.service  #设置开机启动
```

### 防火墙

```sh
ystemctl stop firewalld.service #停止firewall
systemctl disable firewalld.service #禁止firewall开机启动
yum install iptables-services  #安装iptables

vi /etc/sysconfig/iptables  #编辑防火墙配置文件
# Firewall configuration written by system-config-firewall
# Manual customization of this file is not recommended.
*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
-A INPUT -p icmp -j ACCEPT
-A INPUT -i lo -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
-A INPUT -j REJECT --reject-with icmp-host-prohibited
-A FORWARD -j REJECT --reject-with icmp-host-prohibited
COMMIT

systemctl  start  iptables.service  #启动防火墙
systemctl  stop  iptables.service  #停止防火墙
systemctl  restart  iptables.service  #重启防火墙
systemctl  status  iptables.service  #查看防火墙状态
systemctl  enable  iptables.service  #设置开机启动

vi /etc/selinux/config

#SELINUX=enforcing #注释掉
#SELINUXTYPE=targeted #注释掉
SELINUX=disabled #增加

:wq! #保存退出

setenforce 0 #使配置立即生效
```

### web设置

```sh
hostname  www  #设置主机名为www

vi /etc/hostname #编辑配置文件
www   localhost.localdomain  #修改localhost.localdomain为www
```

#### apt-get

程序安装有home路径，bin路径

ubuntu.16替换apt-get为apt

* install 其后加上软件包名，用于安装一个软件包
* update 从软件源镜像服务器上下载/更新用于更新本地软件源的软件包列表
* upgrade 升级本地可更新的全部软件包，但存在依赖问题时将不会升级，通常会在更新之前执行一次update
* dist-upgrade 解决依赖关系并升级(存在一定危险性)
* remove 移除已安装的软件包，包括与被移除软件包有依赖关系的软件包，但不包含软件包的配置文件
* autoremove 移除之前被其他软件包依赖，但现在不再被使用的软件包
* purge 与remove相同，但会完全移除软件包，包含其配置文件
* clean 移除下载到本地的已经安装的软件包，默认保存在/var/cache/apt/archives/
* autoclean 移除已安装的软件的旧版本软件包
* -y 自动回应是否安装软件包的选项，在一些自动化安装脚本中使用这个参数将十分有用
* -q 静默安装方式，指定多个q或者-q=#,#表示数字，用于设定静默级别，这在你不想要在安装软件包时屏幕输出过多时很有用
* -f 修复损坏的依赖关系
* -d 只下载不安装
* --reinstall 重新安装已经安装但可能存在问题的软件包
* --install-suggests 同时安装APT给出的建议安装的软件包
* sudo apt-cache search softname1 softname2 softname3...... 针对本地数据进行相关操作的工具，search 顾名思义在本地的数据库中寻找有关 softname1 softname2 ...... 相关软件的信息

#### 从磁盘安装deb安装包

下载相应deb软件包，使用dpkg命令来安装

* -i 安装指定deb包,之后修复依赖关系的安装`sudo apt-get -f install`
* -R 后面加上目录名，用于安装该目录下的所有deb安装包
* -r remove，移除某个已安装的软件包
* -I 显示deb包文件的信息
* -s 显示已安装软件的信息
* -S 搜索已安装的软件包
* -L 显示已安装软件包的目录信息

#### 从二进制软件包安装

需要做的只是将从网络上下载的二进制包解压后放到合适的目录，然后将包含可执行的主程序文件的目录添加进PATH环境变量即可

#### 从源代码安装

源管理：sudo gedit /etc/apt/sources.list

### 列表

* 云笔记:simplenote
* video: VLC
* editor: atom
* oh my zsh 而非 zsh fish
* KchmViewer:阅读CHM
* LaTeX

## Usage:

```
ctrl+d # 关闭终端

where||type composer
```

### Network

sudo gedit /etc/modprobe.d/iwlwifi.config add `options iwlwifi 11n_disable=1`

### 终端

终端本质上是对应着 Linux 上的 /dev/tty 设备，Linux 的多用户登陆就是通过不同的 /dev/tty 设备完成的

Ubuntu具体说来，它默认提供七个终端，其中第一个到第六个虚拟控制台是全屏的字符终端，第七个虚拟控制台是图形终端，用来运行GUI程序，按快捷键CTRL+ALT+F1，或CTRL+ALT+F2.......CTRL+ALT+F6，CTRL+ALT+F7可完成对应的切换

## 文件

Linux 的磁盘是"挂在"（挂载在）目录上的，每一个目录不仅能使用本地磁盘分区的文件系统，也可以使用网络上的文件系统。Linux的大部分目录结构是依据FHS标准（英文：Filesystem Hierarchy Standard 中文：文件系统层次结构标准）规定好的，多数 Linux 版本采用这种文件组织形式，FHS 定义了系统中每个区域的用途、所需要的最小构成的文件和目录同时还给出了例外处理与矛盾处理。

FHS包含两层规范：

* / 下面的各个目录应该要放什么文件数据，例如 /etc 应该放置设置文件，/bin 与 /sbin 则应该放置可执行文件等等。
* 针对 /usr 及 /var 这两个目录的子目录来定义。例如 /var/log 放置系统登录文件，/usr/share 放置共享数据等等。

```
-r-xr-x---
```

### 身份

owner
group
others

```sh
etc/passwd

chown [-R] [帐号名称] [文件或目录]
chown [-R] [帐号名称]:[群组名称] [文件或目录]

etc/group
chgrp [-options] [群组名] [文档路径]
```

### 类型

* `-` 普通文件：一般是用一些相关的应用程序创建的（如图像工具、文档工具、归档工具... 或 cp工具等),这类文件的删除方式是用rm 命令,而创建使用touch命令,用符号-表示；
* `d` 目录：目录在Linux是一个比较特殊的文件，用字符d表示，删除用rm 或rmdir命令；
* 块设备文件：存在于/dev目录下，如硬盘，光驱等设备，用字符d表示;
* 设备文件：（ /dev 目录下有各种设备文件，大都跟具体的硬件设备相关），如猫的串口设备，用字符c表示；
* socket文件;用字符s表示，比如启动MySQL服务器时，产生的mysql.sock的文件;
* pipe 管道文件：可以实现两个程序（可以从不同机器上telnet）实时交互，用字符p表示；
* `l` 链接文件:软链接等同于 Windows 上的快捷方式；用字符l表示； 软硬链接文件的共同点和区别：无论是修改软链接，硬链接生成的文件还是直接修改源文件，相应的文件都会改变，但是如果删除了源文件，硬链接生成的文件依旧存在而软链接生成的文件就不再有效了。

### 权限

一个目录同时具有读权限和执行权限才可以打开并查看内部文件，而一个目录要有写权限才允许在其中创建其它文件，这是因为目录文件实际保存着该目录里面的文件的列表等信息。

* readable 读权限：可以使用 `cat <file name>` 之类的命令来读取某个文件的内容
* writable 写权限，表示你可以编辑和修改某个文件
* excutable执行权限，通常指可以运行的二进制程序文件或者脚本文件(Linux 上不是通过文件后缀名来区分文件的类型)
* 所有者权限，所属用户组权限，是指你所在的用户组中的所有其它用户对于该文件的权限

```sh
chmod 700 iphone6
sudo chown zhangwang /etc/apt/sources.list

chmod | u g o a | +（加入） -（除去） =（设置） | r w x | 文档路径

chmod u=rwx,g=rwx,o=rwx test
chmod ugo=rwx test
chmod a=rwx test

chmod u-x,g-x,o-x test
chmod ugo-x test
chmod a-x test

chmod u+x,g+x,o+x test
chmod ugo+x test
chmod a+x test

chmod 755 test # 赋予一个shell文件test.sh可执行权限，拥有者可读、写、执行，群组账号和其他人可读、执行。
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
zip -r -9 -q -o shiyanlou_9.zip /home/shiyanlou -x ~/*.zip // 设置不同压缩等级
zip -r -e -o shiyanlou_encryption.zip /home/shiyanlou  // 创建加密
zip -r -l -o shiyanlou.zip /home/shiyanlou   // 解决windows和linux对换行的不同处理问题

unzip -q shiyanlou.zip -d ziptest   // 静默且指定解压目录，目录不存在会自动创建
unzip -O GBK 中文压缩文件.zip // 使用 -O（英文字母，大写 o）参数指定编码类型
```

#### 操作

* du命令可以查看目录的容量，-h #同--human-readable 以K，M，G为单位，提高信息的可读性；-a #同--all 显示目录中所有文件的大小 -d:指定查看目录的深度 `du -h -d 1 ~`
* touch:来更改已有文件的时间戳的（比如，最近访问时间，最近修改时间） touch file{1..5}.txt 使用通配符批量创建 5 个文件
* rename:批量重命名,需要用到正则表达式
* rename 's/.txt/.c/' *.txt 批量将这 5 个后缀为 .txt 的文本文件重命名为以 .c 为后缀的文件:
* rename 'y/a-z/A-Z/' *.c 批量将这 5 个文件，文件名改为大写:
* ls:列出某文件夹下的文件，添加参数可实现更细致的功能，
* ls -a 列出所有文件，包括隐藏文件
* ls -l 列出文件及其详细信息(权限)
* tree:查看文件列表
* cd切换目录,cd到不存在的目录时会报错
* pwd打印当前目录
* cat:读取某一个文件内的内容
* wc:获取某一个文件的行数和字数`wc package.json`
* cp:复制某文件 -r
* mkdir:创建目录
* rm dir：删除目录
* rm -rf:r递归删除，f参数表示强制
* mv 移动文件、文件重命名
* sort排序
* diff:比较两个文件的异同
* mkdir -p father/son/grandson:新建多级目录
* cat:打印文件内容到标准输出(正序)
* tac:打印文件内容到标准输出(逆序)
* more:比较简单，只能向一个方向滚动,查看文件：打开后默认只显示一屏内容，终端底部显示当前阅读的进度。可以使用 Enter 键向下滚动一行，使用 Space 键向下滚动一屏，按下 h 显示帮助，q 退出。
* file:查看文件类型`file /bin/ls`
* head:查看文件的头几行（默认10行）
* tail:查看文件的尾几行（默认10行） `tail -n 1 /etc/passwd`
* `dd if=/dev/zero of=virtual.img bs=1M count=256` 从/dev/zero设备创建一个容量为 256M 的空文件virtual.img
* `sudo mkfs.ext4 virtual.img` 格式化virtual.img为ext4格式
* dd：默认从标准输入中读取，并写入到标准输出中,但输入输出也可以用选项if（input file，输入文件）和of（output file，输出文件）改变。
* `dd if=/dev/stdin of=test bs=10 count=1 conv=ucase` 将输出的英文字符转换为大写再写入文件
* sudo mount 查看下主机已经挂载的文件系统，每一行代表一个设备或虚拟设备格式[设备名]on[挂载点]

#### 系统相关：

* date:获取当前时间
* uname:返回系统名称
* hostname：返回系统的主机名称
* --version/-V 查看某个程序的版本
* history 显示历史
* help 用于显示 shell 内建命令的简要帮助信息 help exit
* man
* info ls
* lsb_release -a
* cal:日历

#### 修改时区

```sh
sudo tzselect
sudo cp /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime

sudo vi /etc/timezone
改为Asia/Shanghai
```
#### 网络相关：

* host xx.xxx.com：显示某域名相关托管服务器/邮件服务器
* ping 8.8.8.8检测连接

#### 搜索相关命令

```sh
`whereis who`  # 只能搜索二进制文件(-b)，man 帮助文件(-m)和源代码文件(-s)。
`locate /etc/sh`(查找 /etc 下所有以 sh 开头的文件)  # 通过/var/lib/mlocate/mlocate.db数据库查找，不过这个数据库也不是实时更新的，系统会使用定时任务每天自动执行 updatedb 命令更新一次，所以有时候你刚添加的文件，它可能会找不到
`locate /usr/share/\*.jpg` # 注意要添加 * 号前面的反斜杠转义，否则会无法找到。
`which man` 使用 which 来确定是否安装了某个指定的软件，因为它只从 PATH 环境变量指定的路径中去搜索命令
`sudo find /etc/ -name interfaces/` 格式find [path] [option] [action];  不但可以通过文件类型、文件名进行查找而且可以根据文件的属性（如文件的时间戳，文件的权限等）进行搜索。
```

#### 用户管理

每次次新建用户如果不指定用户组的话，默认会自动创建一个与用户名相同的用户组； 默认情况下在 sudo 用户组里的可以使用 sudo 命令获得 root 权限。

```sh
who am i:只列出用户名
who mom likes/who am i:列出用户名，所使用终端的编号和开启时间；
finger:列出当前用户的详细信息，需使用apt-get提前安装；

su <user>:切换到用户user,执行时需要输入目标用户的密码；
su - <user>:切换用户，同时环境变量也会跟着改变成目标用户的环境变量。
su -l lilei:切换登录用户;
sudo adduser lilei:新建一个叫做lilei的用户，添加用户到系统，同时也会默认为新用户创建 home目录：
sudo useradd:只创建用户，创建完了需要用 passwd lilei 去设置新用户的密码;
groups zhangwang:查看用户属于那些组（groups）   // 每
cat /etc/group | sort 命令查看某组包含那些成员:/etc/group文件中分行显示了用户组（Group）、用户组口令、GID 及该用户组所包含的用户（User）
sudo usermod -G sudo student:不同的组对不同的文件可能具有不同的操作权限，比如说通过上述命令新建的用户默认是没有使用sudo的权限的，我们可以使用usermod命令把它加入sudo组用以具备相应的权限。
sudo deluser student --remove-home：删除用户及用户相关文件；
```

#### 匹配符

- `*`：匹配 0 或多个字符，如`ls *.html`将匹配所有以html结尾的文件,`ls b*.png`将匹配所有以b开头，png结尾的文件；
- `?`：匹配任意一个字符,如`ls abc?.png` 可匹配abcd.png/abce.png
- `[list]`:匹配 list 中的任意单一字符
- `[!list]`:匹配 除list 中的任意单一字符以外的字符
- `[c1-c2]`:匹配 c1-c2 中的任意单一字符 如：[0-9] [a-z]
- `{string1,string2,...}`:匹配 string1 或 string2 (或更多)其一字符串，如 `{css,html}`， `ls app.{html.css}`将匹配app.css 和app.html;
- `{c1..c2}`:匹配 c1-c2 中全部字符 如{1..10}
- 注意通配符大小写敏感

## 操作

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
```

### 密钥生成

```sh
ssh-keygen -t rsa -b 4096
ssh-copy-id <username>@<host>

chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys

scp ~/.ssh/id_rsa.pub hadoop@192.168.1.134:~/
cat ~/id_rsa.pub >> ~/.ssh/authorized_keys
rm ~/id_rsa.pub
```

- 传输文件通过ssh：

  ```
  scp id_rsa.pub git@172.26.186.117:/home/git/
  scp -P 1101 username@servername:/remote_path/filename  ~/local_destination   // 源文件  目标文件
  ssh -p 2222 user@host   # 登陆服务器
  ```

- 复制文件 cat file >> another file
- 服务管理：

  ```sh
  sudo systemctl enable nginx
  sudo systemctl start nginx
  sudo systemctl restart nginx
  systemctl status nginx
  sudo systemctl reload nginx
  ```

- 修改hosts

  ```sh
  sudo su
  curl https://github.com/racaljk/hosts/blob/master/hosts -L >> /etc/hosts
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
File->Add Another User…
Tools->Synchronize
```

## clean

```sh
sudo apt-get autoclean
sudo apt-get autoremove
sudo apt-get clean
```

## chrome(firefox 禁用console.log)

```sh
sudo wget http://www.linuxidc.com/files/repo/google-chrome.list -P /etc/apt/sources.list.d/
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub  | sudo apt-key add -
sudo apt-get update
sudo apt-get install google-chrome-stable
```

## ufw防火墙

```sh
sudo ufw allow 'Nginx HTTP'
sudo ufw status
sudo ufw allow https
sudo ufw enable/disable
```

## 指令

* 实时刷新文件：tail -f file
* 查看linux系统信息

  - uname -a：显示电脑以及操作系统的相关信息
  - cat /proc/version:说明正在运行的内核版本
  - cat /etc/issue:显示的是发行版本信息
  - lsb_release -a

## 启动项

启动目录： /etc/rc.d/rc[0~6].d 命令行脚本文件：/etc/init.d/ 本地文件：/etc/rc.local 添加 /etc/init.d/nginx start

- 提高电池的寿命并且减少过热

  ```sh
  sudo add-apt-repository ppa:linrunner/tlp
  sudo apt-get update
  sudo apt-get install tlp tlp-rdw
  sudo tlp start
  ```

## 命令行

```
Ctrl+d:键盘输入结束或退出终端（常用）;
Ctrl+s:暂停当前程序，暂停后按下任意键恢复运行;
Ctrl+z:将当前程序放到后台运行，恢复到前台为命令fg;
Ctrl+a:将光标移至输入行头，相当于Home键;
Ctrl+e:将光标移至输入行末，相当于End键;
Ctrl+k:删除从光标所在位置到行末,常配合ctrl+a使用;
Alt+Backspace:向前删除一个单词，常配合ctrl+e使用;
Shift+PgUp:将终端显示向上滚动;
Shift+PgDn:将终端显示向下滚动;
pwd打印当前目录
cat:读取某一个文件内的内容
wc:获取某一个文件的行数和字数
psketch
date:获取当前时间
uname:返回系统名称
hostname：返回系统的主机名称

host xx.xxx.com：显示某域名相关托管服务器/邮件服务器
ping 8.8.8.8检测连接

whereis
who
locate
```

## Boot分区不足

```
\\ 查看已安装的linux-image各版本
dpkg --get-selections |grep linux-image
// 查看使用版本
uname -a
／／清除旧版本
sudo apt-get purge linux-image-3.5.0-27-generic
图中因使用remove命令而残留的deinstall的
sudo dpkg -P linux-image-extra-3.5.0-17-generic
```

## 端口 进程

```sh
[sudo ]lsof -i : (port) # 查看某一端口的占用情况

netstat -tunlp # 显示tcp，udp的端口和进程等相关
netstat -plntu

netstat -tunlp|grep (port)  # // 指定端口号进程情况

ps -ef | grep nginx # 进程查看
ps aux | grep nginx

lsof -Pni4 | grep LISTEN | grep php

kill -9 pid # 关闭进程
kill pid
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

```sh
ssh username@remote_host
ssh username@remote_host ls /var/www
```

## Hypervisor

Linux的最重要创新之一，引入Hypervisor，运行其他操作系统的操作系统，它们为执行提供独立的虚拟硬件平台，同时硬件虚拟平台可以提供对底层机器的虚拟的完整访问.在解决软件架构设计问题时，通常做法是引入一个抽象层来解决，其实这种做法是有点普世原理，同样适用于硬件封装，Hypervisor正是这样一种虚拟抽象层。 只有5%的时间在全负荷工作，其他时间则处于休眠或者空闲状态，虚拟化技术可以大大提升服务器的利用率，从而间接减少服务器数量，即成本！ ![](../_static/Hypervisor.jpg) Hypervisor作为虚拟技术的核心，抽象虚拟化硬件平台.它支持给每一个虚拟机分配内存，CPU， 网络和磁盘，并加载虚拟机的客户操作系统。当然，在获取到这么优秀功能（对硬件的虚拟化，并搭载操作系统）的代价，自然牺牲了启动速度及在资源利用率，性能的开销等。

## LXC(Linux Container）

一种内核虚拟化技术，相比上述的Hypervisor技术则提供更轻量级的虚拟化，以隔离进程和资源，且无需提供指令解析机制及全虚拟化的复杂性，LXC或者容器将操作系统层面的资源分到孤立／隔离的组中，用来管理使用资源。LXC为Sourceforge上的开源项目，其实现是借助Linux的内核特性，（cgroups子系统+namespace）, 在OS层次上做整合为进程提供虚拟执行环境，即称之为容器，除了分配绑定cpu，内存，提供独立的namespace（网络，pid，ipc，mnt，uts）

## Samba服务

### 安装与配置

```sh
sudo apt-get install samba samba-common
sudo apt-get autoremove samba

mkdir /home/myshare
chmod 777 /home/myshare

sudo smbpasswd  -a  henry # add user

vim /etc/samba/smb.conf # 添加下列设定

[share]
comment=This is samba dir
path=/home/myshare  
create mask=0755
directory mask=0755
writeable=yes
valid users=henry
browseable=yes

sudo samba start | stop | restart
sudo service smbd status

mac 链接
finder中com＋K
smb://192.168.100.106

\\172.16.44.175\Ubuntu

# windows access internet \\192.168.1.13 share
```

### [oguzhaninan/Stacer](https://github.com/oguzhaninan/Stacer)

Linux System Optimizer and Monitoring

```sh
sudo add-apt-repository ppa:oguzhaninan/stacer
sudo apt-get update
sudo apt-get install stacer
```

## shell扩展

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

## sed

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

### 编辑命令：地址定界后，对范围内的内容进行相关编辑。

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

## 扩展

* [The Linux Kernel documentation](https://www.kernel.org/doc/html/latest/index.html):

## 参考

* [learnbyexample/Command-line-text-processing](https://github.com/learnbyexample/Command-line-text-processing):From finding text to search and replace, from sorting to beautifying text and more
* [LVS：跑在Linux内核上的负载均衡器](https://liangshuang.name/2017/11/19/lvs/)


```sh
# 提高电池的寿命并且减少过热
sudo add-apt-repository ppa:linrunner/tlp
sudo apt update
sudo apt install tlp tlp-rdw
sudo tlp start

Guake是一个比较酷的终端
sudo apt install guake

 # add source  or http://pinyin.sogou.com/linux/
deb http://archive.ubuntukylin.com:10006/ubuntukylin trusty main
sudo apt install sogoupinyin

# remove libre
sudo apt remove libreoffice-common

# remove Amazon
sudo apt-get remove unity-webapps-common

# 不要选择显示星期或者年份
gsettings set com.canonical.indicator.datetime time-format 'custom'
# 手动设置显示格式
gsettings set com.canonical.indicator.datetime custom-time-format '%Y年%m月%d日 %A%H:%M:%S'

# unity Unity显示的位置
gsettings set com.canonical.Unity.Launcher launcher-position Bottom
gsettings set com.canonical.Unity.Launcher launcher-position Left

# 点击图标最小化
gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-minimize-window true

# Tweak tool优化工具    Unity Tweak Tool  gnome-tweak-tool
sudo apt-get install gnome-tweak-tool
sudo apt-get install unity-tweak-tool

ifconfig

sudo apt install net-tools       # ifconfig
sudo apt install iputils-ping

记录下网卡名字，比如我的，有enp4s0f2、lo、wlp9s0b1三个
2）、编辑文件：

sudo vim /etc/sysctl.conf

在末尾添加：

    net.ipv6.conf.all.disable_ipv6 = 1
    net.ipv6.conf.default.disable_ipv6 = 1
    net.ipv6.conf.lo.disable_ipv6 = 1 #需跟网卡信息对应
    net.ipv6.conf.enp4s0f2.disable_ipv6 = 1 #需跟网卡信息对应
    net.ipv6.conf.wlp9s0b1.disable_ipv6 = 1 #需跟网卡信息对应
sudo sysctl -p

xset m 0 0 # 设置鼠标加速度

# 安装状态栏指示器
sudo add-apt-repository ppa:fossfreedom/indicator-sysmonitor
sudo apt update
sudo apt install indicator-sysmonitor


sudo apt-get remove thunderbird totem rhythmbox simple-scan gnome-mahjongg aisleriot gnome-mines cheese transmission-common gnome-orca webbrowser-app gnome-sudoku onboard deja-dup
sudo apt-get autoremove
sudo apt-get autoclean
```

http://mirrors.aliyun.com

```
sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak #备份系统默认的软件源
sudo vim /etc/apt/sources.list

add source

sudo add-apt-repository ppa:nilarimogard/webupd8
sudo apt update
sudo apt install albert
```

* chrome
* Nylas N1：超好用的跨平台电子邮件客户端  Thunderbird
* sougou
* Spotify for Linux：音乐流媒体服务
* Lightworks Free：专业的非线视频编辑器
* Viber：跨平台的 Skype 替代品
* Vivaldi：功能强大的 web 浏览器
* BleachBit: cleaner(softer center)
* VLC
* albert
* 听播客: Vocal
* PDF 阅读：Foxit Reader
* gimp
* Gtile:分屏工具
* MySQL Workbench
* vscode
* shadowshocks

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

mysql workbeach

```sh
# down
sudo dpkg -i mysql-apt-config_0.8.9-1_all.deb
sudo apt-get update
sudo apt-get install mysql-workbench-community


sudo apt install aptitude
sudo aptitude install <packagename>
sudo aptitude -f install <packagename>
```


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