# [Ubuntu](https://www.ubuntu.com)

## 安装

* 虚拟机
  - 用WinSCP.exe等工具上传系统镜像文件rhel-server-7.0-x86_64-dvd.iso到/usr/local/src目录
  - 使用Putty.exe工具远程连接到RHEL服务器
  - 挂载系统镜像文件
  - 内存一定不能低于4g，因为你给虚拟机分配的内存在虚拟机启动之后会1:1的从物理内存中划走
* win10 && UBUNTU 双系统
  - 磁盘压缩出30G分区，空闲不做盘符与格式化
  - 制作UBUNTU启动U盘
    + 通过UltraISO打开UBUNUT镜像文件(Mac用[etcher](https://etcher.io/))
    + 启动：写入硬盘映像，写入U盘文件
  - 启动通过U盘
    + 安装类型：其他选项
    + 磁盘空间分区
        * /：主分区 系统文件，30GB；  挂载点 /  /dev/sda
        * /swap：逻辑分区 交换分区（虚拟内存），建议是当前 RAM 的两倍
        * /boot：逻辑分区 引导分区 安装启动引导器的设备 包含系统内核和系统启动所需的文件，实现双系统的关键所在，建议500M 挂载点 /boot 
        * /home：逻辑分区 home目录，存放音乐、图片及下载等文件的空间，建议最后分配所有剩下的空间 挂载点 /home
        * /usr 大一点
        * 生产服务器建议单独再划分一个/data分区存放数据
    + 安装系统
  - 通过EASYCD配置启动
    + 添加新条目 linux/BSD选项
    + 选中分区boot分区
  - 重启运行

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

# 时区设置 
sudo dpkg-reconfigure tzdata
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

### 软件安装

* 在线安装:通过软件包管理工具
  - sudo gedit /etc/apt/sources.list
  - 程序安装有home路径
  - bin路径
  - ubuntu.16替换apt-get为apt
* 软件源管理
  - 在本地的一个数据库中搜索关于 cowsay 软件的相关信息
  - snap
  - 根据这些信息在相关的服务器上下载软件安装
  - 安装某个软件时，如果该软件有其它依赖程序，系统会为我们自动安装所以来的程序；
  - 如果本地的数据库不够新，可能就会发生搜索不到的情况，这时候需要我们更新本地的数据库，使用命令sudo apt-get update可执行更新；
  - 软件源镜像服务器可能会有多个，有时候某些特定的软件需要我们添加特定的源；
  - deb包是Debian，Ubuntu等Linux发行版的软件安装包，扩展名为.deb，是类似于rpm的软件包，Debian，Ubuntu系统不推荐使用deb软件包，因为要解决软件包依赖问题，安装也比较麻烦。下载相应deb软件包，使用dpkg命令来安装
  - 源管理
    + software & updates:select best server
    + 配置路径
      * /etc/apt/sources.list
      * /etc/apt/sources.list.d
    - [Aliyun](http://mirrors.aliyun.com)
* 从二进制软件包安装：需要做的只是将从网络上下载的二进制包解压后放到合适的目录，然后将包含可执行的主程序文件的目录添加进PATH环境变量即可
* 源码编译安装
* 列表
  - 云笔记
    + simplenote
  - video:
    + VLC
  - editor
    + atom
  - oh my zsh
  - KchmViewer:阅读CHM
  - LaTeX
  - Chromium
  - Nylas N1：超好用的跨平台电子邮件客户端  Thunderbird
  - Spotify for Linux：音乐流媒体服务
  - Lightworks Free：专业的非线视频编辑器
  - Viber：跨平台的 Skype 替代品
  - Vivaldi：功能强大的 web 浏览器
  - BleachBit: cleaner(softer center)
  - albert
  - 听播客: Vocal
  - PDF 阅读：Foxit Reader
  - 图片
    + gnome-screenshot:`sudo apt-get install gnome-screenshot`
    + Gimp
    + Shutter
    + Imagemagick
    + Kazam
  - Gtile:分屏工具
  - MySQL Workbench
  - [Cloud music](http://d1.music.126.net/dmusic/netease-cloud-music_1.2.0_amd64_ubuntu_20190424_1.deb)
  - shadowshocks
  - Jitsy:通讯工具
  - Synaptic：软件管理
  - thunderbird mail: can  add addon to manage rss
  - xchm:`sudo apt-get install xchm`
  - [wechat](https://github.com/geeeeeeeeek/electronic-wechat/releases)
  - [cherrytree](www.giuspen.com/cherrytree/):note
  - [seamonkey](https://www.seamonkey-project.org/):develop the SeaMonkey all-in-one internet application suite
  - [Sayonara Player](https://sayonara-player.com/index.php)
  - Disk Usage Analyzer
  - [Pomodoro](https://gnomepomodoro.org/)
  - 贴纸
    + indicator-stickynotes
    + Xpad:`sudo apt-get install xpad`

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
sudo apt-get autoclean # 移除已安装的软件的旧版本软件包

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
sudo dpkg --configure -a # fixing broken dependencies

sudo apt install aptitude
sudo aptitude install <packagename>
sudo aptitude -f install <packagename>

sudo apt-get install -f # fix software database is boken

## 替换源
sudo mv /etc/apt/sources.list /etc/apt/sources.list.backup #备份系统默认的软件源

## /etc/apt/sources.list.d
# 清华源
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse
deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse
deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse
deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse
deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-proposed main restricted universe multiverse
deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-proposed main restricted universe multiverse

# 中科大源
deb https://mirrors.ustc.edu.cn/ubuntu/ bionic main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ bionic main restricted universe multiverse
deb https://mirrors.ustc.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse
deb https://mirrors.ustc.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse
deb https://mirrors.ustc.edu.cn/ubuntu/ bionic-security main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ bionic-security main restricted universe multiverse
deb https://mirrors.ustc.edu.cn/ubuntu/ bionic-proposed main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ bionic-proposed main restricted universe multiverse

# 163源
deb http://mirrors.163.com/ubuntu/ bionic main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ bionic-security main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ bionic-updates main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ bionic-backports main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ bionic main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ bionic-security main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ bionic-updates main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ bionic-backports main restricted universe multiverse

sudo add-apt-repository ppa:nilarimogard/webupd8   # add source
sudo add-apt-repository -r(--remove) ppa:nilarimogard/webupd8   # add source
sudo apt update
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

## keyword map

* 工作区
  - Win 键，进入活动概览视图模式
  - Ctrl + Alt + 方向箭头
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
* Super+A Show the list of applications
* Screenshots
  - ctrl+Print：复制截图到窗口
  - ctrl+alt+Print：窗口截取并添加到粘贴板
  - shift+alt+Print:区域截取并添加到粘贴板

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

### 软件

```sh
sudo apt install fonts-firacode

# [sougou pinyin](https://pinyin.sogou.com/linux/?r=pinyin)
sudo apt-get purge ibus
sudo apt install fcitx fcitx-table fcitx-googlepinyin im-config
im-config # 查看配置

# add source
deb http://archive.ubuntukylin.com:10006/ubuntukylin trusty main
sudo apt install sogoupinyin
# download sogoupinyin_2.2.0.0108_amd64.deb
sudo dpkg -i sogoupinyin_2.2.0.0108_amd64.deb # 手动安装
sudo apt-get install -f
# 配置
system setting->language support
choose language,key input method system: fcitx
# fcitx add sogou pinyin
Ctrl+Shift+F # trantional change simple

# chrome(firefox 禁用console.log)
sudo wget http://www.linuxidc.com/files/repo/google-chrome.list -P /etc/apt/sources.list.d/
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub  | sudo apt-key add -
sudo apt-get update
sudo apt-get install google-chrome-stable

# mysql workbeach
sudo dpkg -i mysql-apt-config_0.8.9-1_all.deb
sudo apt-get update
sudo apt-get install mysql-workbench-community

systemctl unmask mysql.service
service mysql start

sudo add-apt-repository ppa:umang/indicator-stickynotes
sudo apt-get update
sudo apt-get install indicator-stickynotes 

sudo add-apt-repository ppa:fossfreedom/indicator-sysmonitor
sudo apt-get update
sudo apt-get install indicator-sysmonitor

sudo add-apt-repository ppa:kasra-mp/ubuntu-indicator-weather
sudo apt-get update
sudo apt-get install indicator-weather

# 提高电池寿命并且减少过热
sudo add-apt-repository ppa:linrunner/tlp
sudo apt install tlp tlp-rdw
sudo tlp start

## [xflux-gui/fluxgui](https://github.com/xflux-gui/fluxgui):Better lighting for Linux. Open source GUI for xflux https://justgetflux.com/linux.html
sudo add-apt-repository ppa:nathan-renniewaldock/flux
sudo apt-get update
sudo apt-get install fluxgui

## VM
sudo apt install open-vm-tools open-vm-tools-desktop # 重启

# [VMware Workstation 12 Pro](http://www.vmware.com/cn/products/workstation/workstation-evaluation)
sudo chmod +x VMware-Workstation-Full-12.1.1-3770994.x86_64.bundle
sudo ./VMware-Workstation-Full-12.1.1-3770994.x86_64.bundle
# 注册密钥：5A02H-AU243-TZJ49-GTC7K-3C61N
# VMware =》 菜单选中VM =》点击 Install VMware Tools
sudo apt-get install lamp-server

## [fusuma](https://github.com/iberianpig/fusuma):Multitouch gestures with libinput driver on X11, Linux 
sudo gpasswd -a $USER input # 重新登录账户
sudo apt-get install libinput-tools
sudo apt-get install xdotool
sudo apt-get install ruby
gem install|update fusuma
gsettings set org.gnome.desktop.peripherals.touchpad send-events enable # 确保触控板的info传输到GNOME桌面环境

fusuma # 启动
mkdir -p ~/.config/fusuma
gedit ~/.config/fusuma/config.yml
# ~/.config/fusuma/config.yml  tab 键写成 Tab
# 配置 Startup Application: fusuma value
swipe:
  3:
    left:
      command: 'xdotool key super+Left'
    right:
      command: 'xdotool key super+Right'
    up:
      command: 'xdotool key super+Up'
    down:
      command: 'xdotool key super+Down'
  4:
    left:
      command: 'xdotool key alt+Shift+Tab'
    right:
      command: 'xdotool key alt+Tab'
    up:
      command: 'xdotool key ctrl+w'
    down:
      command: 'xdotool key ctrl+t'

pinch:
  2:
    in:
      command: 'xdotool key ctrl+equal'
    out:
      command: 'xdotool key ctrl+minus'
  4:
    in:
      command: 'xdotool key super+a'
    out:
      command: 'xdotool key super+s'

threshold:
  swipe: 1
  pinch: 1

interval:
  swipe: 1
  pinch: 1

tar -zxvf Postman*.tar.gz
sudo mv Postman /opt/Postman
sudo cp ~/下载/desktops/postman.desktop /usr/share/applications/

# 安装
sudo apt-get install ubuntu-restricted-extras openssh-server filezilla vlc apt-transport-https unrar lnav cmake qtcreator

# Guake一个比较酷的终端
sudo apt install guake

gsettings set com.canonical.indicator.datetime time-format 'custom' # 不要选择显示星期或者年份
gsettings set com.canonical.indicator.datetime custom-time-format '%Y年%m月%d日 %A%H:%M:%S' # 手动设置显示格式
gsettings set com.canonical.Unity.Launcher launcher-position Bottom|Left # unity Unity显示位置
gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-minimize-window true # 点击图标最小化

# Tweak tool优化工具
sudo apt-get install gnome-tweak-tool # 应用有 Tweaks配置界面
sudo apt-get install unity-tweak-tool

sudo apt install materia-gtk-theme
sudo apt install papirus-icon-theme #  Applications: Materia-light  Icons: Papirus

sudo apt install net-tools       # ifconfig 必备
sudo apt install iputils-ping

# 记录下网卡名字，比如我的，有enp4s0f2、lo、wlp9s0b1三个 /etc/sysctl.conf 追加
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1 #需跟网卡信息对应
net.ipv6.conf.enp4s0f2.disable_ipv6 = 1 #需跟网卡信息对应
net.ipv6.conf.wlp9s0b1.disable_ipv6 = 1 #需跟网卡信息对应
sudo sysctl -p

xset m 0 0 # 设置鼠标加速度

sudo apt-get remove totem \
rhythmbox \
gnome-mahjongg \
aisleriot \
gnome-mines \
cheese \
transmission-common \
gnome-orca \
webbrowser-app \
unity-webapps-common \
gnome-sudoku \
onboard \
simple-scan \
landscape-client-ui-install \
deja-dup \
totem \
rhythmbox \
empathy \
brasero

sudo apt-get autoremove
sudo apt-get autoclean

# /etc/dhcp/dhclient.conf 添加使用aliyun和114的DNS
prepend domain-name-servers 114.114.114.114;
prepend domain-name-servers 223.5.5.5;

### PHP
sudo apt-get install autoconf build-essential curl libtool \
  libssl-dev libcurl4-openssl-dev libxml2-dev libreadline7 \
  libreadline-dev libzip-dev libzip4  openssl \
  pkg-config zlib1g-dev

### phpMyAdmin
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

# Htop 是个比内置的 top 任务管理更强大的工具。它提供了带有诸多选项的高级接口用于监控系统进程。
sudo apt install htop
htop
```

## 快捷方式

```
sudo touch /usr/share/applications/fusuma.desktop
# /usr/share/applications/fusuma.desktop 添加到开机启动
[Desktop Entry]
Encoding=UTF-8
Name=fusuma
Comment=fusuma
Exec=/var/lib/gems/2.5.0/gems/fusuma-0.10.2/exe/fusuma
＃上面这里时你的fusuma的路径，如果你不知道在哪里，就在根目录下搜索一下，找到这个路径。
Icon=/usr/share/icons/chumoban.png
＃这里是你的fusuma的图标，随便找一个就行，如果时强迫症，非得找个好看的，就来这里http://www.iconfont.cn/
Terminal=false  #软件打开时是否启动终端，这里选择false
StartupNotify=false
Type=Application
Categories=Application;Development;
```

## top

用来监控Linux系统状况，比如cpu、内存的使用

top [-] [d] [p] [q] [c] [C] [S] [s]  [n]，参数

* d 指定每两次屏幕信息刷新之间的时间间隔。当然用户可以使用s交互命令来改变之。
* p 通过指定监控进程ID来仅仅监控某个进程的状态。
* q 该选项将使top没有任何延迟的进行刷新。如果调用程序有超级用户权限，那么top将以尽可能高的优先级运行。
* S 指定累计模式。
* s 使top命令在安全模式中运行。这将去除交互命令所带来的潜在危险。
* i 使top不显示任何闲置或者僵死进程。
* c 显示整个命令行而不只是显示命令名。
* 多核CPU监控:在top基本视图中，按键盘数字“1”，可监控每个逻辑CPU的状况
* 统计信息区:前五行是系统整体的统计信息。
  - 第一行是任务队列信息，同 uptime 命令的执行结果
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

## 18.04

* cgroup v2
* AMD 安全内存加密
* 最新 MD 驱动
* 针对 SATA Link 电源管理的改进
* 默认采用的 JRE/JDK 是 OpenJDK 10
* Keymap
   - Switch to overview: Super key
   - List all applications: Super key + A
   - Switch workspaces: Ctrl + Alt + Up/Down
   - ctlr+alt+shift+上下键:窗口移入下一个工作区

## 问题

```sh
## Boot分区不足
# 查看已安装的linux-image各版本
dpkg --get-selections |grep linux-image
# 查看使用版本
uname -a
# 清除旧版本
sudo apt-get purge linux-image-3.5.0-27-generic
# 因使用remove命令而残留的deinstall的
sudo dpkg -P linux-image-extra-3.5.0-17-generic

# sudo: /usr/lib/sudo/sudoers.so must be owned by uid 0
# sudo: fatal error, unable to load plugins
pkexec chown root /usr/lib/sudo/sudoers.so
chown root /usr/lib/sudo/sudoers.so

# Failed to connect to 127.0.0.1 port 1080: Connection refused
检测网络代理

ln -s /usr/lib/x86_64-linux-gnu/libssl.so /usr/lib # configure: error: Cannot find OpenSSL’s libraries

#  修复grub/etc/default/grub
add GRUB_DISABLE_OS_PROBER=true
sudo update-grub
```

## 参考

* [LewisVo/Awesome-Linux-Software](https://github.com/LewisVo/Awesome-Linux-Software):🐧 A list of awesome applications, software, tools and other materials for Linux distros.
* [kholia/OSX-KVM](https://github.com/kholia/OSX-KVM):Run El Capitan, macOS Sierra, High Sierra and Mojave on QEMU/KVM. No support is provided at the moment.
* [shubhampathak/autosetup](https://github.com/shubhampathak/autosetup):Auto setup is a bash script compatible with Debian based distributions to install and setup necessary programs.
