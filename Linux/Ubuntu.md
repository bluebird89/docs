# Ubuntu

UNIX/Linux 本身是没有图形界面的，我们通常在 UNIX/Linux 发行版上看到的图形界面实际都只是运行在 Linux 系统之上的一套软件,而 Linux 上的这套软件以前是 XFree86，现在则是 xorg（X.Org），而这套软件又是通过 X 窗口系统（X Window System，也常被称为 X11 或 X）实现的，X 本身只是工具包及架构协议，而 xorg 便是 X 架构规范的一个实现体，也就是说它是实现了 X 协议规范的一个提供图形界面服务的服务器，就像实现了 http 协议提供 web 服务的 Apache 。如果只有服务器也是不能实现一个完整的桌面环境的，当然还需要一个客户端，我们称为 X Client，像如下几个大家熟知也最流行的实现了客户端功能的桌面环境 KDE，GNOME，XFCE，LXDE 。

Linux 是一个可以实现多用户登陆的操作系统，多用户可以同时登陆同一台主机，共享主机的一些资源，不同的用户也分别有自己的用户空间，可用于存放各自的文件。虽然不同用户的文件是放在同一个物理磁盘上的甚至同一个逻辑分区或者目录里，但是由于 Linux 的用户管理和 文件权限机制，不同用户不可以轻易地查看、修改彼此的文件。

## 安装

### 虚拟机

* 用WinSCP.exe等工具上传系统镜像文件rhel-server-7.0-x86_64-dvd.iso到/usr/local/src目录
* 使用Putty.exe工具远程连接到RHEL服务器
* 挂载系统镜像文件
* 内存一定不能低于4g，因为你给虚拟机分配的内存在虚拟机启动之后会1:1的从你的物理内存中划走

### 分区

win10 && UBUNTU 双系统

* 磁盘压缩出30G分区，空闲不做盘符与格式化
* 制作UBUNTU启动U盘
  - 通过UltraISO打开UBUNUT镜像文件(Mac用[etcher](https://etcher.io/))
  - 启动：写入硬盘映像，写入U盘文件
* 启动通过U盘
  - 安装类型：其他选项
  - 对之前分配的未使用磁盘空间分区：
      + /：存储系统文件，建议10GB ~ 15GB； 主分区 挂载点 /  /dev/sda
      + /swap：交换分区，即Linux系统的虚拟内存，建议是物理内存的2倍； 逻辑分区 用于交换空间
      + /boot：包含系统内核和系统启动所需的文件，实现双系统的关键所在，建议500M。 逻辑分区 挂载点 /boot 安装启动引导器的设备： 选择/boot对应的盘符
      + /home：home目录，存放音乐、图片及下载等文件的空间，建议最后分配所有剩下的空间； 逻辑分区 挂载点 /home
      + 生产服务器建议单独再划分一个/data分区存放数据
  - 安装系统
* 通过EASYCD配置启动
  - 添加新条目 linux/BSD选项
  - 选中分区boot分区
* 重启运行

## screen

* tweak

```sh
sudo apt install gnome-tweak-tool
```

### 网络配置

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

hostname  www  #设置主机名为www

vi /etc/hostname #编辑配置文件
www   localhost.localdomain  #修改localhost.localdomain为www

sudo gedit /etc/modprobe.d/iwlwifi.config add `options iwlwifi 11n_disable=1`

host xx.xxx.com：显示某域名相关托管服务器/邮件服务器
ping 8.8.8.8检测连接

# host  文件修改 以Ubuntu为主要使用系统，不用修改hosts can access google
sudo su # switch root
curl https://github.com/racaljk/hosts/blob/master/hosts -L >> /etc/hosts
```

### 软件安装

* 在线安装:通过软件包管理工具
  - sudo gedit /etc/apt/sources.list
  - 程序安装有home路径
  - bin路径
  - ubuntu.16替换apt-get为apt
* 软件源管理
  - 在本地的一个数据库中搜索关于 cowsay 软件的相关信息
  - 根据这些信息在相关的服务器上下载软件安装
  - 安装某个软件时，如果该软件有其它依赖程序，系统会为我们自动安装所以来的程序；
  - 如果本地的数据库不够新，可能就会发生搜索不到的情况，这时候需要我们更新本地的数据库，使用命令sudo apt-get update可执行更新；
  - 软件源镜像服务器可能会有多个，有时候某些特定的软件需要我们添加特定的源；
  - deb包是Debian，Ubuntu等Linux发行版的软件安装包，扩展名为.deb，是类似于rpm的软件包，Debian，Ubuntu系统不推荐使用deb软件包，因为要解决软件包依赖问题，安装也比较麻烦。下载相应deb软件包，使用dpkg命令来安装
  - 源管理
    + 配置路径
      * /etc/apt/sources.list
      * /etc/apt/sources.list.d
    - [Aliyun](http://mirrors.aliyun.com)
* 从二进制软件包安装：需要做的只是将从网络上下载的二进制包解压后放到合适的目录，然后将包含可执行的主程序文件的目录添加进PATH环境变量即可
* 源码编译安装

```sh
do-release-upgrade

# fix ubuntu
sudo rm/var/lib/apt/lists/lock
sudo rm/var/lib/dpkg/lock
sudo rm/var/lib/dpkg/lock-frontend

sudo apt-cache search softname1 softname2 softname3...... # 针对本地数据进行相关操作的工具，search 顾名思义在本地的数据库中寻找有关 softname1 softname2 ...... 相关软件的信息
sudo apt[-get] install [packagename] # 其后加上软件包名，用于安装一个软件包
sudo apt[-get] -f install # 解决依赖问题
sudo apt update --fix-missing
sudo apt[-get] upgrade # 从软件源镜像服务器上下载/更新用于更新本地软件源的软件包列表 升级本地可更新的全部软件包，但存在依赖问题时将不会升级，通常会在更新之前执行一次update
sudo apt[-get] dist-upgrade # 解决依赖关系并升级(存在一定危险性)
sudo apt --fix-broken install # continue install

sudo apt-get remove netease-cloud-music # 移除已安装的软件包，包括与被移除软件包有依赖关系的软件包，但不包含软件包的配置文件
sudo apt-get autoremove # 移除之前被其他软件包依赖，但现在不再被使用的软件包  purge 与remove相同，但会完全移除软件包，包含其配置文件
sudo apt-get clean # 移除下载到本地的已经安装的软件包，默认保存在/var/cache/apt/archives/
sudo apt-get autoclean #移除已安装的软件的旧版本软件包

sudo dpkg --configure -a # fixing broken dependencies E: Sub-process /usr/bin/dpkg returned an error code (1)
sudo apt-get install -f
## 参数
-i|--install
-l|--list #简明地列出软件包的状态。
-r|--remove # 只是删掉数据和可执行文件
-P|--purge # 还删除所有的配制文件
-V|--verify  # 检查包的完整性
-s|--status # 软件包的详细信息
-S|--search
-C|--audit  # 检查是否有软件包残损
-c|--contents # 包含的文件结构
-L|--listfiles # 所有文件清单
-i # 安装指定deb包,之后修复依赖关系的安装`sudo apt-get -f install`
-R # 后面加上目录名，用于安装该目录下的所有deb安装包
-r # remove，移除某个已安装的软件包
-I # 显示deb包文件的信息
-s # 显示已安装软件的信息
-S # 搜索已安装的软件包
-L # 显示已安装软件包的目录信息
-y # 自动回应是否安装软件包的选项，在一些自动化安装脚本中使用这个参数将十分有用
-q # 静默安装方式，指定多个q或者-q=#,#表示数字，用于设定静默级别，这在你不想要在安装软件包时屏幕输出过多时很有用
-f # 修复损坏的依赖关系
-d # 只下载不安装git aa
sudo dpkg -i netease-cloud-music_1.1.0_amd64_ubuntu.deb # install failed.depency to install

dpkg --get-selections | grep hold
--reinstall # 重新安装已经安装但可能存在问题的软件包
--install-suggests # 同时安装APT给出的建议安装的软件包
# 显示包的具体信息
dpkg -p package-name
sudo aptitude install <packagename>
sudo apt-get install apt-transport-https

sudo add-apt-repository --remove ppa:finalterm/daily # remove

## 替换源
# /etc/apt/sources.list.d
sudo mv /etc/apt/sources.list /etc/apt/sources.list.backup #备份系统默认的软件源
sudo vim /etc/apt/sources.list

sudo add-apt-repository ppa:nilarimogard/webupd8   # add source
sudo add-apt-repository -r ppa:nilarimogard/webupd8   # add source
sudo apt update

sudo apt install -f # fix software database is boken
sudo apt update --fix-missing

sudo apt-get upgrade

## error
E: Could not get lock /var/lib/dpkg/lock – open (11: Resource temporarily unavailable)
E: Unable to lock the administration directory (/var/lib/dpkg/), is another process using it?

sudo killall apt apt-get

## 源码编译 源码cp到/usr/local/src/下
cd xxx
./configure --help
./configure --prefix=/usr/local/libxml2
make && make install
```

### 列表

* 云笔记
  - simplenote
* video:
  - VLC
* editor
  - atom
* oh my zsh
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
* 图片
  - gnome-screenshot:`sudo apt-get install gnome-screenshot`
  - Gimp
  - Shutter
  - Imagemagick
  - Kazam
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
* 浮动图标工具栏：docky `sudo apt-get install docky`
* 贴纸
  - indicator-stickynotes
  - Xpad:`sudo apt-get install xpad`

```
sudo add-apt-repository ppa:umang/indicator-stickynotes
sudo apt-get update
sudo apt-get install indicator-stickynotes 

```


## VM

```sh
codesudo apt install open-vm-tools open-vm-tools-desktop # 重启
```

## source

```
# 使用清华提供镜像源
# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial main main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-security main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-security main restricted universe multiverse

# 预发布软件源，不建议启用
# deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-proposed main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-proposed main restricted universe multiverse
```

## keyword map

* 工作区
  * Win 键，进入活动概览视图模式
  * Ctrl + Alt + 方向箭头
* super:window  long hold super:Keyboard Shortcuts
* super + s :  show all workspaces
* Ctrl+Alt+arrow+keys:switch workspace
* Ctrl+Alt+Shift and an arrow key to move a window between workspaces
* Paste:Middle Click
* Alt+F2:want to run a command without pulling up a terminal
* Ctrl+Alt+F#:Switch Between Virtual Consoles, use alt+ arrow keys to switch,并行存在的
* Press Alt and type the name of the menu item you want to activate – for example, if you’re using Firefox and want menu items related to bookmarks, press the Alt key and type bookmark. Use the arrow keys and Enter key to activate a menu item.
* Super+L or Ctrl+Alt+L: Locks the screen
* Super+D or Ctrl+Alt+D: Show desktop
* Ctrl+Q: Close an application window
* Prt Scrn:take a screenshot of the desktop.
* Alt+Prt Scrn:take a  screenshot of a window.
* Shift+Prt Scrn:take a screenshot of an area you select.
* ctrl + super + d :show desktop
* Super+Tab Switch between windows from the same application, or from the selected application after Super+Tab.This shortcut uses ` on US keyboards, where the ` key is above Tab. On all other keyboards, the shortcut is Superplus the key above Tab.
* Super+A Show the list of applications.

## 端口与进程管理

```sh
# 防火墙
sudo ufw status
sudo ufw app list
sudo ufw allow 'Nginx HTTP'
sudo ufw allow https
sudo ufw allow 443
sudo ufw enable/disable
bash <(curl -s https://git.jacksgong.com/Jacksgong/script/raw/master/firewall.sh)

# 查看某一端口的占用情况
[sudo ]lsof -i : (port)
# 显示tcp，udp的端口和进程等相关
netstat -tunlp
# 指定端口号进程情况
netstat -tunlp|grep (port)
# 进程查看
ps -ef | grep nginx
ps aux | grep nginx
lsof -Pni4 | grep LISTEN | grep php
# 关闭进程
kill -9 pid
```

## 用户管理

* 每次次新建用户如果不指定用户组的话，默认会自动创建一个与用户名相同的用户组； 默认情况下在 sudo 用户组里的可以使用 sudo 命令获得 root 权限。
* 家目录修改后需要手动创建，不同于创建用户家目录设置
* 创建用户时设置家目录，该目录会自动创建
* 修改用户家目录时，该目录不会自动创建(需要手动创建)

```sh
who am <i>  # </i>只列出用户名
who mom likes/who am <i>  # </i>列出用户名，所使用终端的编号和开启时间；
<finger>  # </finger>列出当前用户的详细信息，需使用apt-get提前安装；

su <user> # 切换到用户user,执行时需要输入目标用户的密码；
su - <user> # 切换用户，同时环境变量也会跟着改变成目标用户的环境变量。
su -l <lilei> # </lilei>切换登录用户;
sudo adduser <lilei>  # </lilei>新建一个叫做lilei的用户，添加用户到系统，同时也会默认为新用户创建 home目录：
sudo <useradd>  # </useradd>只创建用户，创建完了需要用 passwd lilei 去设置新用户的密码;
groups <zhangwang>  # </zhangwang>查看用户属于那些组（groups）   // 每
cat /etc/group | sort 命令查看某组包含那些成员  # /etc/group文件中分行显示了用户组（Group）、用户组口令、GID 及该用户组所包含的用户（User）
sudo usermod -G sudo <student>  # </student>不同的组对不同的文件可能具有不同的操作权限，比如说通过上述命令新建的用户默认是没有使用sudo的权限的，我们可以使用usermod命令把它加入sudo组用以具备相应的权限。
sudo deluser student --remove-home：删除用户及用户相关文件；

su -
su - root
su henry

useradd  username      # 创建用户会同时创建同名组
useradd  -g  组编号   username # 创建用户的同时设置组别
useradd  -g 组编号 -u 用户编号 -d 家目录 username # 创建用户同时，指定组别、用户编号、家目录

usermod  -g gid  username     # 修改组别是常见操作
usermod  -g gid -u uid -d 家目录  -l  newname   username # 修改组别、用户编号、家目录、名字
usermod techmoe -G sudo # 用户添加进sudo组

userdel username     # 删除用户(删除passwd文件对应信息)，此时其家目录需要手动删除
userdel -r username  # 删除用户的同时也删除其“家目录”

groupadd  groupname
groupmod -g gid  -n newname  groupname
groupdel 组名

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

### 文件管理

Linux 的磁盘是"挂在"（挂载在）目录上的，每一个目录不仅能使用本地磁盘分区的文件系统，也可以使用网络上的文件系统。Linux的大部分目录结构是依据FHS标准（英文：Filesystem Hierarchy Standard 中文：文件系统层次结构标准）规定好的，多数 Linux 版本采用这种文件组织形式，FHS 定义了系统中每个区域的用途、所需要的最小构成的文件和目录同时还给出了例外处理与矛盾处理。

FHS包含两层规范：

* / 下面的各个目录应该要放什么文件数据，例如 /etc 应该放置设置文件，/bin 与 /sbin 则应该放置可执行文件等等。
* 针对 /usr 及 /var 这两个目录的子目录来定义。例如 /var/log 放置系统登录文件，/usr/share 放置共享数据等等。

> 文件类型

* 普通文件：一般是用一些相关的应用程序创建的（如图像工具、文档工具、归档工具... 或 cp工具等),这类文件的删除方式是用rm 命令,而创建使用touch命令,用符号-表示；
* 目录：目录在Linux是一个比较特殊的文件，用字符d表示，删除用rm 或rmdir命令；
* 块设备文件：存在于/dev目录下，如硬盘，光驱等设备，用字符d表示;
* 设备文件：（ /dev 目录下有各种设备文件，大都跟具体的硬件设备相关），如猫的串口设备，用字符c表示；
* socket文件;用字符s表示，比如启动MySQL服务器时，产生的mysql.sock的文件;
* pipe 管道文件：可以实现两个程序（可以从不同机器上telnet）实时交互，用字符p表示；
* 链接文件:软链接等同于 Windows 上的快捷方式；用字符l表示； 软硬链接文件的共同点和区别：无论是修改软链接，硬链接生成的文件还是直接修改源文件，相应的文件都会改变，但是如果删除了源文件，硬链接生成的文件依旧存在而软链接生成的文件就不再有效了。

> 文件权限

一个目录同时具有读权限和执行权限才可以打开并查看内部文件，而一个目录要有写权限才允许在其中创建其它文件，这是因为目录文件实际保存着该目录里面的文件的列表等信息。

* 读权限：可以使用 `cat <file name>` 之类的命令来读取某个文件的内容;
* 写权限:表示你可以编辑和修改某个文件；
* 执行权限:通常指可以运行的二进制程序文件或者脚本文件(Linux 上不是通过文件后缀名来区分文件的类型);
* 所有者权限，所属用户组权限，是指所在的用户组中的所有其它用户对于该文件的权限

```sh
# 权限管理
chmod u+/-/=rwx, g+/-/=rwx, o+/-/=rwx filename
chmod 000  filename   # 所有用户没有任何权限

sudo chown zhangwang /etc/apt/sources.list
```

> 文件管理

```sh
touch  filename
touch  dir/filename

cat  filename   # 在终端显示文件全部内容,读取某一个文件内的内容,打印文件内容到标准输出(正序)
more filename   # 通过"敲回车"方式从第一行逐行查看文件内容,不支持回看,q键退出查看
less filename   # "上下左右"键方式查看文件各个部分内容,支持回看，q键退出查看
head  -n  filename # 查看文件“前n行”内容
tail  -n  filename # 查看文件“末尾n行”内容
wc  filename     # 计算文件行数
umask # 档案预设权限
chattr # 配置文件档案隐藏属性
lsattr # 显示档案隐藏属性
file /bin/l # file:查看文件类型

echo  内容 > filename    # 给文件“覆盖写”方式追加内容
echo  内容 >> filename   # 给文件纯追加内容

touch # 来更改已有文件的时间戳或新建档案（比如，最近访问时间，最近修改时间） touch file{1..5}.txt 使用通配符批量创建 5 个文件
rename # 批量重命名,需要用到正则表达式
rename s/.txt/.c/ *.txt # 批量将这 5 个后缀为 .txt 的文本文件重命名为以 .c 为后缀的文件:
rename y/a-z/A-Z/ *.c # 批量将这 5 个文件，文件名改为大写

sudo mkfs.ext4 virtual.img # 格式化virtual.img为ext4格式
cat file >> another file

tail -f file

pwd打印当前目录
cat:读取某一个文件内的内容
wc:获取某一个文件的行数和字数
psketch

tree /home -p # 获取项目树形结构
```

> 目录管理

```sh
du -h 文件/目录 # 查看文件占据磁盘空间大小,命令可以查看目录的容量，-h #同--human-readable 以K，M，G为单位，提高信息的可读性；-a #同--all 显示目录中所有文件的大小 -d:指定查看目录的深度 `du -h -d 1 ~`命令会生成相关文件和有关目录的空间使用情况的报告。它很容易使用，也可以递归地运行，会遍历每个子目录并且返回每个文件的单个大小。`du -sh *`

ls # 列出某文件夹下的文件，添加参数可实现更细致的功能，-a 所有文件，包括隐藏文件 -l # 列出文件及其详细信息(权限)
tree # 查看文件列表
cd # 切换目录,cd到不存在的目录时会报错
pwd # 打印当前目录
wc package.json # 获取某一个文件的行数和字数
cp # 复制某文件 -r
sort #排序
diff # 比较两个文件的异同

tac # 打印文件内容到标准输出(逆序)
cat
nl # 显示的时候，顺道输出行号
more less # 比较简单，只能向一个方向滚动,查看文件：打开后默认只显示一屏内容，终端底部显示当前阅读的进度。可以使用 Enter 键向下滚动一行，使用 Space 键向下滚动一屏，按下 h 显示帮助，q 退出。

head # 查看文件的头几行（默认10行）
tail # 查看文件的尾几行（默认10行）
tail -n 1 /etc/passwd
Tree 用可视化的效果向你展示一个目录下的文件 tree -P '_.min._'

mkdir # 创建目录
mkdir -p father/son/grandson # 新建多级目录
mkdir  newdir
mkdir -p newdir/newdir/newdir     # 递归方式创建多级目录 newdir新目录多于1个层次(2/3/4等)就设置-p参数，如果就一个新的目录则无需-p参数
mkdir  dir/newdir
mkdir  dir/dir/newdir
mkdir -p dir/newdir/newdir

rm  filename      # 普通文件删除
rm dir # 删除目录
rm -r dir         # 删除目录[无视层次]需要-r参数
rm -rf  文件      # recursive force 递归强制删除文件,force 避免删除隐藏文件的提示
rm -rf /         # 递归强制方式删除系统里边的全部内容

# 移动文件、文件重命名
mv  dir1  dir2                # dir1移动到dir2目录下,并给改名字为"原名"
mv  dir1  dir2/newdir         # dir1移动到dir2目录下,并给改名字为newdir
mv  dir1/dir2  dir3/dir4      # dir2移动到dir4目录下,并给改名字为"原名"
mv  dir1/dir2  dir3/dir4/newdir  # dir2移动到dir4目录下,并给改名字为 newdir
mv  dir1/dir2  ./             # dir2移动到 当前 目录下,并给改名字为"原名"
mv  dir1/dir2  ./newdir           # dir2移动到 当前 目录下,并给改名字为newdir

cp  file1  dir1  # file1被复制到dir1目录下一份，并给改名字为“原名”
cp  file1  dir1/newfile  # file1被复制到dir1目录下一份，并给改名字为newfile
cp -r dir1  dir2 # dir1被复制到dir2目录下一份，并给改名字为“原名” # recursive递归方式拷贝目录
cp -r dir1  dir2/newdir  # dir1被复制到dir2目录下一份，并给改名字为newdir
cp -r dir1/dir2/dir3   dir4/dir5  # dir3被复制到dir5目录下一份，并给改名字为"原名"

basename，dirname
ln  # unix 里面的链接同 Windows 中的快捷方式类似，允许你快速地访问到一个特定的文件。
`sudo ln -s ~/Desktop/Scripts/git-scripts/git-cleanup /usr/local/bin/`

dd # 默认从标准输入中读取，并写入到标准输出中,但输入输出也可以用选项if（input file，输入文件）和of（output file，输出文件）改变。
# dd if=/dev/zero of=virtual.img bs=1M count=256  # 从/dev/zero设备创建一个容量为 256M 的空文件virtual.img
# dd if=/dev/stdin of=test bs=10 count=1 conv=ucase # 将输出的英文字符转换为大写再写入文件
sudo mount # 查看下主机已经挂载的文件系统，每一行代表一个设备或虚拟设备格式[设备名]on[挂载点]
```

> 文件压缩

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
gzip，zcat
bzip2，bzcat
tar
```

> 挂载镜像文件

```sh
# 挂载镜像文件
mkdir /media/cdrom  #新建镜像文件挂载目录
cd /usr/local/src  #进入系统镜像文件存放目录
ls  #列出目录文件，可以看到刚刚上传的系统镜像文件
mount -t iso9660 -o loop /usr/local/src/rhel-server-7.0-x86_64-dvd.iso  /media/cdrom #挂载系统镜像
cd  /media/cdrom  #进入挂载目录，使用ls命令可以看到已经有文件存在了

umount  /media/cdrom  #卸载系统镜像

vi /etc/fstab   #添加以下代码。实现开机自动挂载
/usr/local/src/rhel-server-7.0-x86_64-dvd.iso  /media/cdrom   iso9660    defaults,ro,loop  0 0
```

> 搜索

```sh
whereis who  # 只能搜索二进制文件(-b)，man 帮助文件(-m)和源代码文件(-s)。
where composer
type composer
locate /etc/sh(查找 /etc 下所有以 sh 开头的文件)  # 通过/var/lib/mlocate/mlocate.db数据库查找，不过这个数据库也不是实时更新的，系统会使用定时任务每天自动执行 updatedb 命令更新一次，所以有时候你刚添加的文件，它可能会找不到
locate /usr/share/\*.jpg # 注意要添加 * 号前面的反斜杠转义，否则会无法找到。
which man # 使用 which 来确定是否安装了某个指定的软件，因为它只从 PATH 环境变量指定的路径中去搜索命令
sudo find /etc/ -name interfaces/ # 格式find [path] [option] [action];  不但可以通过文件类型、文件名进行查找而且可以根据文件的属性（如文件的时间戳，文件的权限等）进行搜索。

find  ./  -size  +50c # 在当前目录下查找大小[大于]50个字节的文件
find  ./  -size  -50c # 在当前目录下查找大小[小于]50个字节的文件
find / -name passwd -mindepth 3 -maxdepth 4 # 在3到4个层次的目录里边定位passwd文件
find  /  -name  passwd[完整名称]     # "递归遍历"系统全部目录查找名字等于passwd的文件
find  目录 -name  "an*" [部分名称]     # 模糊查找文件名字以an开始的

### grep：Global search REgrular expression and Print out the line
--color=auto：对匹配到的文本着色显示
-v：显示不被pattern 匹配到的行，反向选择 ,查找文件中不包含"test"内容的行 `grep -v test log.txt`
-i：忽略字符大小写
-n：显示匹配的行号
-c：统计匹配的行数
-o：仅显示匹配到的字符串
-q：静默模式，不输出任何信息
-A #：after，后#行 ,显示包含这行后续#行
-B #：before，前#行
-C #：context，前后各#行
-e：实现多个选项间的成逻辑or关系，grep –e 'cat ' -e 'dog' file
-w：匹配整个单词,（字母，数字，下划线不算单词边界）
-E：使用ERE
-r或--recursive 此参数的效果和指定"-d recurse"参数相同。
```

#### 匹配符

* `*`：匹配 0 或多个字符，如`ls *.html`将匹配所有以html结尾的文件,`ls b*.png`将匹配所有以b开头，png结尾的文件；
* `?`：匹配任意一个字符,如`ls abc?.png` 可匹配abcd.png/abce.png
* `[list]`:匹配 list 中的任意单一字符
* `[!list]`:匹配 除list 中的任意单一字符以外的字符
* `[c1-c2]`:匹配 c1-c2 中的任意单一字符 如：[0-9] [a-z]
* `{string1,string2,...}`:匹配 string1 或 string2 (或更多)其一字符串，如 `{css,html}`， `ls app.{html.css}`将匹配app.css 和app.html;
* `{c1..c2}`:匹配 c1-c2 中全部字符 如{1..10}
* 注意通配符大小写敏感

### Terminal

* Shell之所以叫Shell 是因为它隐藏了操作系统底层的细节
* 终端本质上是对应着 Linux 上的 /dev/tty 设备，Linux 的多用户登陆就是通过不同的 /dev/tty 设备完成的
* 默认提供七个终端，其中第一个到第六个虚拟控制台是全屏的字符终端，第七个虚拟控制台是图形终端，用来运行GUI程序，按快捷键CTRL+ALT+F1，或CTRL+ALT+F2.......CTRL+ALT+F6，CTRL+ALT+F7可完成对应的切换
* 快捷键
  - Tab 点击Tab键可以实现命令补全,目录补全、命令参数补全;
  - Ctrl+c:强行终止当前程序（常用）;
  - Ctrl+d:键盘输入结束或退出终端（常用）;
  - Ctrl+s:暂停当前程序，暂停后按下任意键恢复运行;
  - Ctrl+z:将当前程序放到后台运行，恢复到前台为命令fg;
  - Ctrl+a:将光标移至输入行头，相当于Home键;
  - Ctrl+e:将光标移至输入行末，相当于End键;
  - Ctrl+k:删除从光标所在位置到行末,常配合ctrl+a使用;
  - Alt+Backspace:向前删除一个单词，常配合ctrl+e使用;
  - Shift+PgUp:将终端显示向上滚动;
  - Shift+PgDn:将终端显示向下滚动;
  - Ctrl+d:键盘输入结束或退出终端
  - Ctrl+a 光标移动到开始位置
  - Ctrl+e 光标移动到最末尾
  - Ctrl+k 删除此处至末尾的所有内容
  - Ctrl+u 删除此处至开始的所有内容
  - Ctrl+d 删除当前字符
  - Ctrl+h 删除当前字符前一个字符
  - Ctrl+w 删除此处到左边的单词
  - Ctrl+y 粘贴由 Ctrl+u ， Ctrl+d ， Ctrl+w 删除的单词
  - Ctrl+l 相当于clear，即清屏
  - Ctrl+r 查找历史命令
  - Ctrl+b 向回移动光标
  - Ctrl+f 向前移动光标
  - Ctrl+t 将光标位置的字符和前一个字符进行位置交换
  - Ctrl+& 恢复 ctrl+h 或者 ctrl+d 或者 ctrl+w 删除的内容
  - Ctrl+S 暂停屏幕输出
  - Ctrl+Q 继续屏幕输出
  - Ctrl+Left-Arrow 光标移动到上一个单词的词首
  - Ctrl+Right-Arrow 光标移动到下一个单词的词尾
  - Ctrl+p 向上显示缓存命令
  - Ctrl+n 向下显示缓存命令
  - Ctrl+d 关闭终端
  - Ctrl+xx 在EOL和当前光标位置移动
  - Ctrl+x@ 显示可能hostname补全
  - Ctrl+c 终止进程/命令
  - Shift +上或下 终端上下滚动
  - Shift+PgUp/PgDn 终端上下翻页滚动
  - Ctrl+Shift+n 新终端
  - alt+F2 输入gnome-terminal打开终端
  - Shift+Ctrl+T 打开新的标签页
  - Shift+Ctrl+W 关闭标签页
  - Shift+Ctrl+C 复制
  - Shift+Ctrl+V 粘贴
  - Alt+数字 切换至对应的标签页
  - Shift+Ctrl+N 打开新的终端窗口
  - Shift+Ctrl+Q 管壁终端窗口
  - Shift+Ctrl+PgUp/PgDn 左移右移标签页
  - Ctrl+PgUp/PgDn 切换标签页
  - F1 打开帮助指南
  - F10 激活菜单栏
  - F11 全屏切换
  - Alt+F 打开 “文件” 菜单（file）
  - Alt+E 打开 “编辑” 菜单（edit）
  - Alt+V 打开 “查看” 菜单（view）
  - Alt+S 打开 “搜索” 菜单（search）
  - Alt+T 打开 “终端” 菜单（terminal）
  - Alt+H 打开 “帮助” 菜单（help）

## 系统相关

```sh
# 查看linux系统信息
uname -a # 显示电脑以及操作系统的相关信息 -r 核心版本
cat /proc/version # 说明正在运行的内核版本
cat /etc/issue # 显示的是发行版本信息
lsb_release -a

df -T
reboot/poweroff
date # 获取当前时间
cal # 日历
bc # 计算器

uname # 返回系统名称 sudo uname --m
hostname # 返回系统的主机名称
--version/-V # 查看某个程序的版本
history # 显示历史
help # 用于显示 shell 内建命令的简要帮助信息 help exit
man #
info ls
ssh # 连接到一个远程主机，然后登录进入其 Unix shell。这就使得通过自己本地机器的终端在服务器上提交指令成为了可能。
grep  # 用来在文本中查找字符串,从一个文件或者直接就是流的形式获取到输入, 通过一个正则表达式来分析内容，然后返回匹配的行。该命令在需要对大型文件进行内容过滤的时候非常趁手`grep "$(date +"%Y-%m-%d")" all-errors-ever.log > today-errors.log`
alias server="python -m SimpleHTTPServer 9000" # 使用 alias 这个 bash 内置的命令来为它们创建一个短别名

which # 寻找执行文件

whereis #
who
locate #

tar # 用来处理文件压缩的默认 Unix 工具.
md5sum  # 它们可以用来检查文件的完整性。`md5sum ubuntu-16.04.3-desktop-amd64.iso` 将生成的字符串与原作者提供的（比如 UbuntuHashes）进行比较

# 界面切换
init 3
init 5
--run level 0 :关机
--run level 3 :纯文本模式
--run level 5 :含有图形接口模式
--run level 6 :重新启动

chkconfig --list sshd
```

### font

```sh
sudo apt install fonts-firacode
```

## 服务管理

```sh
systemctl status nginx
sudo systemctl enable|start|restart|reload nginx

sudo uname --m

Failed to start mysql.service: Unit mysql.service is masked.
systemctl unmask mysql.service
service mysql start
```

## 启动项

启动目录： /etc/rc.d/rc[0~6].d 命令行脚本文件：/etc/init.d/ 本地文件：/etc/rc.local 添加 /etc/init.d/nginx start

> 修改时区

```sh
sudo tzselect
sudo cp /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime

sudo vi /etc/timezone
# 改为Asia/Shanghai
```

> ssh

* 基于密钥的验证是最安全的几个身份验证模式使用OpenSSH,如普通密码和Kerberos票据。 基于密钥的验证密码身份验证有几个优点,例如键值更难以蛮力,比普通密码或者猜测,提供充足的密钥长度。 其他身份验证方法仅在非常特殊的情况下使用。
* SSH可以使用RSA(Rivest-Shamir-Adleman)或“DSA(数字签名算法)的钥匙。 这两个被认为是最先进的算法,当SSH发明,但DSA已经被视为近年来更不安全。 RSA是唯一推荐选择新钥匙,所以本指南使用RSA密钥”和“SSH密钥”可以互换使用。
* 基于密钥的验证使用两个密钥,一个“公共”键,任何人都可以看到,和另一个“私人”键,只有老板是允许的。 安全通信使用的基于密钥的认证,需要创建一个密钥对,安全地存储私钥在电脑人想从登录,并存储公钥在电脑上一个想登录。
* 使用基于密钥登录使用ssh通常被认为是比使用普通安全密码登录。 导的这个部分将解释的过程中生成的一组公共/私有RSA密钥,并将它们用于登录到你的Ubuntu电脑通过OpenSSH(s)。如果只有服务器也是不能实现一个完整的桌面环境的，当然还需要一个客户端，我们称为

```sh
# 密钥生成
ssh-keygen -t rsa -b 4096
ssh-copy-id <username>@<host>
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys

# 传输文件通过ssh
scp id_rsa.pub git@172.26.186.117:/home/git/
scp -P 1101 username@servername:/remote_path/filename  ~/local_destination   // 源文件  目标文件

ssh -p 2222 user@host   # 登陆服务器
ssh username@remote_host
ssh username@remote_host ls /var/www
```

### 软件安装

#### [sougou pinyin](https://pinyin.sogou.com/linux/?r=pinyin)

command line或者package

```sh
sudo apt install fcitx fcitx-googlepinyin im-config
im-config

# download sogoupinyin_2.2.0.0108_amd64.deb
sudo dpkg  -i   sogoupinyin_2.2.0.0108_amd64.deb # 手动安装
sudo apt-get install -f

# 配置
system setting->language support
choose language,key input method system: fcitx
fcitx add sogou pinyin

Ctrl+Shift+F # trantional change simple

# atom install
sudo add-apt-repository ppa:webupd8team/atom
sudo apt-get update
sudo apt-get install atom

sudo apt install vlc
# evernote
sudo add-apt-repository ppa:nixnote/nixnote2-daily
sudo apt update
sudo apt install nixnote2
File->Add Another User…
Tools->Synchronize

# chrome(firefox 禁用console.log)
sudo wget http://www.linuxidc.com/files/repo/google-chrome.list -P /etc/apt/sources.list.d/
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub  | sudo apt-key add -
sudo apt-get update
sudo apt-get install google-chrome-stable

# mysql workbeach
sudo dpkg -i mysql-apt-config_0.8.9-1_all.deb
sudo apt-get update
sudo apt-get install mysql-workbench-community

sudo apt install aptitude
sudo aptitude install <packagename>
sudo aptitude -f install <packagename>

systemctl unmask mysql.service
service mysql start

dpkg --get-selections | grep hold
sudo aptitude install <packagename>

sudo dpkg --configure -a # fixing broken dependencies
sudo apt-get install -f

[VMware Workstation 12 Pro](http://www.vmware.com/cn/products/workstation/workstation-evaluation)
sudo chmod +x VMware-Workstation-Full-12.1.1-3770994.x86_64.bundle
sudo ./VMware-Workstation-Full-12.1.1-3770994.x86_64.bundle
可用Linux版注册密钥：5A02H-AU243-TZJ49-GTC7K-3C61N
VMware =》 菜单选中VM =》点击 Install VMware Tools
sudo apt-get install lamp-server
```

> PHP

```sh
sudo apt-get install autoconf build-essential curl libtool \
  libssl-dev libcurl4-openssl-dev libxml2-dev libreadline7 \
  libreadline-dev libzip-dev libzip4  openssl \
  pkg-config zlib1g-dev

ln -s /usr/lib/x86_64-linux-gnu/libssl.so /usr/lib # configure: error: Cannot find OpenSSL’s libraries
```

#### [xflux-gui/fluxgui](https://github.com/xflux-gui/fluxgui)

Better lighting for Linux. Open source GUI for xflux https://justgetflux.com/linux.html

```sh
sudo add-apt-repository ppa:nathan-renniewaldock/flux
sudo apt-get update
sudo apt-get install fluxgui
```

### 问题

> Boot分区不足

```sh
# 查看已安装的linux-image各版本
dpkg --get-selections |grep linux-image
# 查看使用版本
uname -a
# 清除旧版本
sudo apt-get purge linux-image-3.5.0-27-generic
# 因使用remove命令而残留的deinstall的
sudo dpkg -P linux-image-extra-3.5.0-17-generic
```

> sudo: /usr/lib/sudo/sudoers.so must be owned by uid 0
> sudo: fatal error, unable to load plugins

pkexec chown root /usr/lib/sudo/sudoers.so
chown root /usr/lib/sudo/sudoers.so

## top

用来监控Linux系统状况，比如cpu、内存的使用

top [-] [d] [p] [q] [c] [C] [S] [s]  [n]，参数

* d 指定每两次屏幕信息刷新之间的时间间隔。当然用户可以使用s交互命令来改变之。
* p 通过指定监控进程ID来仅仅监控某个进程的状态。
* q 该选项将使top没有任何延迟的进行刷新。如果调用程序有超级用户权限，那么top将以尽可能高的优先级运行。
* S 指定累计模式。
* s 使top命令在安全模式中运行。这将去除交互命令所带来的潜在危险。
* i  使top不显示任何闲置或者僵死进程。
* c 显示整个命令行而不只是显示命令名。
* 多核CPU监控:在top基本视图中，按键盘数字“1”，可监控每个逻辑CPU的状况
* 统计信息区:前五行是系统整体的统计信息。
  * 第一行是任务队列信息，同 uptime 命令的执行结果
    + 10:37:35  当前时间
    + up 25 days, 17:29 系统运行时间，格式为时:分
    + 1 user  当前登录用户数
    + load average: 0.00, 0.02, 0.05  系统负载，即任务队列的平均长度。三个数值分别为 1分钟、5分钟、15分钟前到现在的平均值。
  - Tasks: 104 total  进程总数
    _ 1 running 正在运行的进程数
    _ 103 sleeping  睡眠的进程数
    _ 0 stopped 停止的进程数
    _ 0 zombie  僵尸进程数
  - Cpu(s):  0.1%us 用户空间占用CPU百分比
    + 0.0%sy  内核空间占用CPU百分比
    + 0.0%ni  用户进程空间内改变过优先级的进程占用CPU百分比
    + 99.9%id 空闲CPU百分比
    + 0.0%wa  等待输入输出的CPU时间百分比
  - Mem:   2067816k total 物理内存总量
    + 2007264k used 使用的物理内存总量
    + 60552k free 空闲内存总量
    + 73752k buffers  用作内核缓存的内存量
  - Swap:   524284k total 交换区总量
    + 315424k used  使用的交换区总量
    + 208860k free  空闲交换区总量
    + 625832k cached  缓冲的交换区总量。
    + 内存中的内容被换出到交换区，而后又被换入到内存，但使用过的交换区尚未被覆盖，
    + 该数值即为这些内容已存在于内存中的交换区的大小。
    + 相应的内存再次被换出时可不必再对交换区写入。
* 进程信息区：显示了各个进程的详细信息
  -  PID 进程id
  -  PPID  父进程id
  -  RUSER Real user name
  -  UID 进程所有者的用户id
  -  USER  进程所有者的用户名
  -  GROUP 进程所有者的组名
  -  TTY 启动进程的终端名。不是从终端启动的进程则显示为 ?
  -  PR  优先级
  -  NI  nice值。负值表示高优先级，正值表示低优先级
  -  P 最后使用的CPU，仅在多CPU环境下有意义
  -  %CPU  上次更新到现在的CPU时间占用百分比
  -  TIME  进程使用的CPU时间总计，单位秒
  -  TIME+ 进程使用的CPU时间总计，单位1/100秒
  -  %MEM  进程使用的物理内存百分比
  -  VIRT  进程使用的虚拟内存总量，单位kb。VIRT=SWAP+RES
  -  SWAP  进程使用的虚拟内存中，被换出的大小，单位kb。
  -  RES 进程使用的、未被换出的物理内存大小，单位kb。RES=CODE+DATA
  -  CODE  可执行代码占用的物理内存大小，单位kb
  -  DATA  可执行代码以外的部分(数据段+栈)占用的物理内存大小，单位kb
  -  SHR 共享内存大小，单位kb
  -  nFLT  页面错误次数
  -  nDRT  最后一次写入到现在，被修改过的页面数。
  -  S 进程状态。
    + =不可中断的睡眠状态
    + =运行
    + =睡眠
    + =跟踪/停止
    + =僵尸进程
  -  COMMAND 命令名/命令行
  -  WCHAN 若该进程在睡眠，则显示睡眠中的系统函数名
  -  Flags 任务标志，参考 sched.h

* f 键可以选择显示的内容。按 f 键之后会显示列的列表，按 a-z 即可显示或隐藏对应的列，最后按回车键确定。
* 按 o 键可以改变列的显示顺序。按小写的 a-z 可以将相应的列向右移动，而大写的 A-Z可以将相应的列向左移动。最后按回车键确定。
* 按大写的 F 或 O 键，然后按 a-z 可以将进程按照相应的列进行排序。而大写的 R 键可以将当前的排序倒转。
* Ctrl+L 擦除并且重写屏幕。
* h或者? 显示帮助画面，给出一些简短的命令总结说明。
* k 终止一个进程。系统将提示用户输入需要终止的进程PID，以及需要发送给该进程什么样的信号。一般的终止进程可以使用15信号；如果不能正常结束那就使用信号9强制结束该进程。默认值是信号15。在安全模式中此命令被屏蔽。
* i 忽略闲置和僵死进程。这是一个开关式命令。
* q 退出程序。
* r 重新安排一个进程的优先级别。系统提示用户输入需要改变的进程PID以及需要设置的进程优先级值。输入一个正值将使优先级降低，反之则可以使该进程拥有更高的优先权。默认值是10。
* s 改变两次刷新之间的延迟时间。系统将提示用户输入新的时间，单位为s。如果有小数，就换算成m s。输入0值则系统将不断刷新，默认值是5 s。需要注意的是如果设置太小的时间，很可能会引起不断刷新，从而根本来不及看清显示的情况，而且系统负载也会大大增加。
* f或者F 从当前显示中添加或者删除项目。
* o或者O改变显示项目的顺序。
* l 切换显示平均负载和启动时间信息。
* m 切换显示内存信息。
* t 切换显示进程和CPU状态信息。
* c 切换显示命令名称和完整命令行。
* M 根据驻留内存大小进行排序。
* P 根据CPU使用百分比大小进行排序。
* T 根据时间/累计时间进行排序。
* W 将当前设置写入~/.toprc文件中。这是写top配置文件的推荐方法。
* Shift+M 可按内存占用情况进行排序。

> Htop 是个比内置的 top 任务管理更强大的工具。它提供了带有诸多选项的高级接口用于监控系统进程。

```sh
sudo apt install htop
htop
```

## 虚拟化

* Hypervisor：Linux的最重要创新之一，引入Hypervisor，运行其他操作系统的操作系统，它们为执行提供独立的虚拟硬件平台，同时硬件虚拟平台可以提供对底层机器的虚拟的完整访问.在解决软件架构设计问题时，通常做法是引入一个抽象层来解决，其实这种做法是有点普世原理，同样适用于硬件封装，Hypervisor正是这样一种虚拟抽象层。 只有5%的时间在全负荷工作，其他时间则处于休眠或者空闲状态，虚拟化技术可以大大提升服务器的利用率，从而间接减少服务器数量，即成本！ ![](../_static/Hypervisor.jpg) Hypervisor作为虚拟技术的核心，抽象虚拟化硬件平台.它支持给每一个虚拟机分配内存，CPU， 网络和磁盘，并加载虚拟机的客户操作系统。当然，在获取到这么优秀功能（对硬件的虚拟化，并搭载操作系统）的代价，自然牺牲了启动速度及在资源利用率，性能的开销等。
* LXC(Linux Container）：一种内核虚拟化技术，相比上述的Hypervisor技术则提供更轻量级的虚拟化，以隔离进程和资源，且无需提供指令解析机制及全虚拟化的复杂性，LXC或者容器将操作系统层面的资源分到孤立／隔离的组中，用来管理使用资源。LXC为Sourceforge上的开源项目，其实现是借助Linux的内核特性，（cgroups子系统+namespace）, 在OS层次上做整合为进程提供虚拟执行环境，即称之为容器，除了分配绑定cpu，内存，提供独立的namespace（网络，pid，ipc，mnt，uts）

> Samba服务

```sh
# 安装与配置
apt-get install samba
mkdir -p /home／directory
chmod 777 /home／directory
vim /etc/samba/smb.conf
#[global]的地方添加 security = user
# 文件最后添加下列设定
[global]
workgroup = WORKGROUP           #设置工作组
server string = Samba Server        #设置描述字符串
log file = /var/log/samba/log.%m    #日志文件路径
max log size = 50                         #日志文件大小限制（单位：K）
security = share

[share]
path = /home/username/share
available = yes
browsealbe = yes
public = yes
writable = yes
guest ok = yes

useradd username
sudo smbpasswd -a username
/etc/init.d/samba restart

# mac 链接 finder中com＋K
smb://192.168.100.106
# windows
\\172.16.44.175\Ubuntu
```

### ubunu 优化

```sh
# 提高电池的寿命并且减少过热
sudo add-apt-repository ppa:linrunner/tlp
sudo apt update
sudo apt install tlp tlp-rdw
sudo tlp start

# Guake是一个比较酷的终端
sudo apt install guake

# add source  or http://pinyin.sogou.com/linux/
deb http://archive.ubuntukylin.com:10006/ubuntukylin trusty main
sudo apt install sogoupinyin

# remove libre
sudo apt remove libreoffice-common

# remove Amazon
sudo apt-get remove unity-webapps-common thunderbird totem rhythmbox simple-scan gnome-mahjongg aisleriot gnome-mines cheese transmission-common gnome-orca webbrowser-app gnome-sudoku onboard deja-dup empathy

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

# 编辑文件sudo vim /etc/sysctl.conf 在末尾添加
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

## Screenshots

* ctrl+Print：复制截图到窗口
* ctrl+alt+Print：窗口截取并添加到粘贴板
* shift+alt+Print:区域截取并添加到粘贴板

### phpMyAdmin

```sh
sudo apt update
sudo apt install phpmyadmin php-mbstring php-gettext
sudo phpenmod mbstring

ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';

## /usr/share/phpmyadmin/.htaccess
AuthType Basic
AuthName "Restricted Files"
AuthUserFile /etc/phpmyadmin/.htpasswd
Require valid-user

sudo htpasswd -c /etc/phpmyadmin/.htpasswd username
sudo htpasswd /etc/phpmyadmin/.htpasswd additionaluser

# https://domain_name_or_IP/phpmyadmin
```

### mysql workbeach

```sh
# down
sudo dpkg -i mysql-apt-config_0.8.9-1_all.deb
sudo apt-get update
sudo apt-get install mysql-workbench-community
sudo apt install mysql-workbench

sudo apt install aptitude
sudo aptitude install <packagename>
sudo aptitude -f install <packagename>
```

## 18.04

* cgroup v2
* AMD 安全内存加密
* 最新 MD 驱动
* 针对 SATA Link 电源管理的改进
* 默认采用的 JRE/JDK 是 OpenJDK 10

## config

* install sogou chrome VLC git zsh
* Ubuntu Software => Add-ons => Shell extensions:NetSpeed  Coverflow Alt-Tab
* 统一管理主题中的各个部分:`sudo apt install gnome-tweak-tool`
* sudo vim /etc/default/grub
    - `add  GRUB_DISABLE_OS_PROBER=true`
    - 修复grub:sudo update-grub

## 参考

* [官网](https://www.ubuntu.com)
* [LewisVo/Awesome-Linux-Software](https://github.com/LewisVo/Awesome-Linux-Software):🐧 A list of awesome applications, software, tools and other materials for Linux distros.
* [kholia/OSX-KVM](https://github.com/kholia/OSX-KVM):Run El Capitan, macOS Sierra, High Sierra and Mojave on QEMU/KVM. No support is provided at the moment.
* [shubhampathak/autosetup](https://github.com/shubhampathak/autosetup):Auto setup is a bash script compatible with Debian based distributions to install and setup necessary programs.
