# MAC

最大优势 GUI 和 命令行的完美结合

## 硬件

* Apple Magic Trackpad 2：重现 Mac pro mul touch 功能
* 耳机 BeoPlay H6
* iPad Pro：阅读利器
* 格式化移动硬盘：ExFAT格式
* imac Radeon Pro 580
  + (2019)Radeon Pro 580X 图形处理器 (配备 8GB 显存) 可选配 Radeon Pro Vega 48
- nuc 黑苹果

## 结构

* macOS 剥离 Cocoa、Carbon等东西，剩下的叫Darwin，包含POSIX兼容、UNIX线程、进程实现
* [XNU](https://github.com/apple/darwin-xnu): macOS和iOS的核心，由三个主要部分组成的一个分层体系结构
  - 内核的内环是Mach层，源自卡纳基-梅隆大学开发的Mach内核
  - BSD层
  - I/O Kit

![Alt text](../_static/MacOS-architecture.gif "Optional title")
![Alt text](../_static/Darwin-and-macOS.gif "Optional title")
![Alt text](../_static/MacOS-kernel-architecture.gif "Optional title")

## 配置

* 开启鼠标更多功能
* 功能键(F1-F12)的行为设置为标准功能键
* dock 停在左边
* iphone,只能同步一台设备itunes配置
* 设置未收录开发者应用`sudo spctl --master-disable`
* 配置
  - [dotfiles](https://github.com/mathiasbynens/dotfiles).files, including ~/.macos -- sensible hacker defaults for macOS
  - [dotfiles](https://github.com/skwp/dotfiles) YADR - The best vim,git,zsh plugins and the cleanest vimrc you've ever seen
  - [dotfiles](https://github.com/holman/dotfiles)@holman does dotfiles
  - [dotfiles](https://github.com/thoughtbot/dotfiles):A set of vim, zsh, git, and tmux configuration files.
* 脚本
  - [dev-setup](https://github.com/donnemartin/dev-setup)Mac OS X development environment setup: Easy-to-understand instructions with automated setup scripts for developer tools like Vim, Sublime Text, Bash, iTerm, Python data analysis, Spark, Hadoop MapReduce, AWS, Heroku, JavaScript web development, Android development, common data stores, and dev-based OS X defaults.
  - [mac-dev-setup](https://github.com/nicolashery/mac-dev-setup)A beginner's guide to setting up a development environment on Mac OS X
  - [mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook)Mac setup and configuration via Ansible.
  - [mac-setup](https://github.com/sb2nov/mac-setup) Installing Development environment on Mac OS X(<http://sourabhbajaj.com/mac-setup/>) 推荐
  - [setup.guide](https://github.com/phodal/setup.guide)
  - [pow](https://github.com/basecamp/pow):Zero-configuration Rack server for Mac OS X <http://pow.cx/v>
* 参考
  - [laptop](https://github.com/thoughtbot/laptop)A shell script to set up a macOS laptop for web and mobile development.
  - [Mac](https://github.com/smyhvae/Mac) Mac软件、使用技巧整理
  - [高效MacBook工作环境配置](http://goahead2010.iteye.com/blog/2232869)
  - [MAC全栈开发环境搭建指南](https://mac.aotu.io/index.html)
  - [ocds-guide-to-setting-up-mac](https://github.com/macdao/ocds-guide-to-setting-up-mac):OCD's Guide to Setting up Mac
  - [Mac OS X 配置指南](https://wild-flame.github.io/guides/)
  - [Mac 开发配置手册](https://aaaaaashu.gitbooks.io/mac-dev-setup/content/)

```sh
# 开启 SSD 的 Trim 模式
sudo trimforce enable
```

### [mackup](https://github.com/lra/mackup)

* Keep your application settings in sync (OS X/Linux)系统配置备份
* linux下（mac下）有各种app，每个人会根据个人的喜好和习惯来设置一些（快捷键，变量等等），而dotfiles就是保存了这些自定义设置的文件。在系统中使用一个文件夹，通过ln命令，将不同的app，不同的系统设置文件都指引到这个文件夹

```sh
brew install mackup # 通过mackup备份 默认放在文件Dropbox/

mackup backup
mackup restore
mackup uninstall

# mackup 配置文件 .mackup.cfg
[storage]
engine = file_system
path = dotfiles # 文件路径
directory = home

[applications_to_sync]
atom
pycharmce
myvim
ideaic15
zsh
mackup
dash
```

## 启动项

* System -> Accounts，选择Login Items
* 配置目录
  - ~/Library/Preferences/ – （当前用户设置的进程）
  - ~/Library/LaunchAgents/ – 用户自己定义的任务项
  - /Library/LaunchAgents/ – （管理员设置的用户进程）
  - /Library/LaunchDaemons/ – （管理员提供的系统守护进程）
  - /System/Library/LaunchAgents/ – （Mac操作系统提供的用户进程）
  - /System/Library/LaunchDaemons/ – （Mac操作系统提供的系统守护进程）
  - /System/Library/StartupItems: 系统相关的StartupItems
  - /Library/StartupItems
* 在 Mac 设备启动时通过 Command + V 或者 Command +S 快捷键改变启动行为。除此外，通过 NVRAM 或第三方引导程序（如 Clover）中也可以设置启动参数。macOS 内置了许多启动参数，可以用于专业用户调试或排除故障。可以通过 nvram 工具设置启动参数： `sudo nvram boot-args="-v"`
* 对于三方引导程序（如 Clover 等）的用户来说，可以在 config.plist 文件、或者在启动菜单中设置引导参数。
  - - v：以「啰嗦模式」启动，等价于 Mac 设备上的快捷键 Command + V。
  - -x：以「安全模式」启动，等价于 Mac 设备上的长按 Shift 键。在这一模式下 macOS 会加载尽可能少的内核扩展（kext）文件。
  - -s：以「单用户模式」启动，等价于 Mac 设备上的快捷键 Command + S。这一模式将会启动终端模式，你可以用这种方式修复你的系统。
  - f：旧版的「安全模式」。
  - -f：启动时强制重建内核扩展（kext）缓存。
  - config：指定用于代替 com.apple.Boot.plist 的配置文件。config=sukka 将会加载 /Library/Preferences/SystemConfiguration/sukka.plist
  - arch=x86_64：在 OS X Snow Leopard 中，即使已经内置了 64 位内核，系统也依然默认启动 32 位内核。这个启动参数可以使系统强制使用 64 位内核。如果要使系统总是以 32 位内核启动，请将 x86_64 部分替换为 i386。在某些情况下，第三方 kext 可能只有 32 位或 64 位，需要启动到相应的内核类型才能加载。
  - -legacy：启动到 32 位内核。
  - maxmem=32：将可寻址内存限制为指定的容量，本例中为 32 GB。如果没有这一启动参数，macOS 会将内存限制设置为硬件可以寻址的最大容量、亦或是安装的内存容量。
  - cpus=1：限制系统中活动 CPU 的数量。苹果的开发者工具有一个选项用于启用或禁用系统中的一些 CPU，但你也可以通过这个参数指定要使用的 CPU 数量。在某些情况下，这也许有助于省电、或者你正在调试 X86 电源驱动，否则这一选项真的没什么别的作用。
  - rd=disk0s1：强制指定启动分区。
  - rp：根目录位置。
  - trace：Kernel Trace 缓冲区大小。
  - iog=0x0：这一参数强制 macOS 在笔记本上 不使用 Clamshell 模式。此时当你外接了显示器和键盘，合盖后笔记本不会睡眠、但内置显示器将会关闭。
  - serverperfmode：为 macOS Server 开启 性能模式
  - _panicd_ip=11.4.5.14：设置一个 Kernel Panic 收集服务器的 IP 地址，日志将会通过 UDP 协议发送给这个 IP 的 1069 端口。
  - panicd_port：修改日志发送端口（默认为 1069）。
  - debug=0x144：这一参数结合了内核调试功能来显示内核进程的额外信息，这在 Kernel Panic 时很有用。可用的参数包括以下这些：
  - 0x1：DB_HALT，在引导时暂停，直到外部调试串口已经连接并被识别
  - 0x2：DB_PRT，将内核的 printf() 函数输出的信息打印到 Console.app
  - 0x4：DB_NMI，启用内核调试功能，包括生成非屏蔽中断（NMI）。在 Power Mac 上，只需简单地按下电源键就能产生 NMI。在笔记本电脑上，在按下电源键时必须按住命令键。如果按住电源键超过五秒钟，系统将关闭电源。在「系统偏好设置」中更改启动盘时 DB_NMI 位将被清除。
  - 0x8：DB_KPRT，将 kprintf() 产生的内核调试输出发送到远程输出设备，通常是一个调试串口（如果有的话）。注意， kprintf() 的输出是同步的。
  - 0x10：DB_KDB，使用 KDB 代替 GDB 作为默认的内核调试器。与 GDB 不同，KDB 必须被显式编译到内核中。此外，基于 KDB 的调试需要原生的串口硬件（而不是基于 USB 的串口适配器）。
  - 0x20：SB_SLOG，启用将杂项诊断记录到系统日志中。设置了这个位后，load_shared_file() 内核函数会记录额外的信息。
  - 0x40：DB_ARP，允许跨局域网调试内核。
  - 0x80：DB_KDP_BP_DIS，已经被弃用，用于支持旧版的 GDB。
  - 0x100：DB_LOG_PI_SCRN，禁用五国、而把 Kernel Panic 的相关数据直接打印在屏幕上。这一参数还可以用于 Core Dump。
  - 0x200：DB_KDP_GETC_ENA，在 Kernel Panic 后启用快捷键（c 继续，r 重启，k 进入 KDB）
  - 0x400：DB_KERN_DUMP_ON_PANIC，当 Kernel Panic 时触发一次 Core Dump。
  - 0x800：DB_KERN_DUMP_ON_NMI，当产生 NMI 时触发一次 Core Dump。
  - 0x1000：DB_DBG_POST_CORE，等待调试器连接（如果使用 GDB）或在 NMI 触发的内核转储后等待调试器（如果使用 KDB）。如果没有设置 DB_DBG_POST_CORE，内核在 Core Dump 后继续运行。
  - 0x2000：只生成并发送 Kernel Panic Log，不生成完整的 Core Dump。
  - artsize：指定要用于地址解析表（ART）的页数。
  - BootCacheOverride：BootCache 驱动程序被加载，但从网络启动时不会运行。设置 BootCacheOverride=1 可以覆盖此行为。
  - dart：设置 dart=0 会关闭 64 位硬件上的系统 PCI 地址映射器（DART）。DART 在拥有 2GB 以上物理内存的机器上是必需的，但在所有机器上无论内存大小，默认情况下都会启用 DART
  - diag：启用内核的内置诊断接口及其特定功能。
  - fill：指定一个整数值，在启动是将会用这个整数填充所有内存。
  - fn：改变处理器的强制休眠行为。设置 fn=1 将关闭强制休眠；设置 fn=2 将开启强制休眠。
  - _fpu：禁用x86上的FPU功能。_fpu=387 将禁用 FXSR/SSE/SSE2，而字符串值为 _fpu=se 的字符串值将禁用 SSE2。
  - hfile：休眠文件的名称（这一参数也会修改 sysctl 中的 kern.hibernatefile 变量）。
  - io：I/O Kit 驱动调试位。设置为 0x00200000 （即 kIOLogSynchronous）时会使 IOLog() 函数同步执行。
  - novmx=1：禁用 AltiVec。
  - pcata=0：禁用板载 PC ATA 驱动器。
  - pmsx=1：在 OS X 10.4.3 上启用实验性电源管理（PMS）。
  - _router_ip=11.4.5.14：使用跨局域网内核调试时指定网关 IP。
  - serial=1，启用串口调试。
  - smbios=1：在 SMBIOS 驱动中启用详细的日志信息，仅限于 32 位机器。
  - vmdx 和pmdx：内核启动时在内存中创建一个分区，参数格式为 base.size，其中 base 是对齐的内存地址、size 是内存页面大小的倍数。vmdx 指虚拟内存、pmdx 指物理内存。创建成功后将会被分别挂载在 dev/mdx 和 dev/emdx 下。
  - -b：不执行 /etc/rc.boot。
  - -l：日志中输出内存泄漏相关记录。
  - srv=1：如果你在 X Servers 或 macOS Server 系统中使用这一参数，macOS 会修改内核的电源和网络参数，提升作为服务器的性能。
  - nvram_paniclog：将 Kernel Panic 日志写入 NVRAM。
  - acpi：启用 AppleACPIPlatform 调试。
  - acpi_level：ACPI 调试等级。
  - idlehalt=1：无视所有空闲进程、使 CPU 进入低功率模式。
  - platform：platform=X86PC 强制禁用 ACPI 电源管理；platform=ACPI 强制启用 ACPI 电源管理。
  - keepsyms=1：保留 KLD/Address-Symbol 翻译

```sh
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>KeepAlive</key>
    <true/>
    <key>Label</key>
    <string>memcached</string>
    <key>ProgramArguments</key>
    <array>
      <string>/usr/bin/memcached</string>
      <string>-d</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>UserName</key>
    <string>michael</string>
  </dict>
</plist>

# 检查plist语法
plutil ~/Library/LaunchAgents/example.plist
# 查看服务
launchctl list | grep anydesk
# 停止服务
launchctl stop com.philandro.anydesk
# 添加服务
launchctl load ~/Library/LaunchAgents/example.plist
launchctl load -w ~/Library/LaunchAgents/memcached.plist
sudo launchctl load -w /System/Library/LaunchDaemons/org.apache.httpd.plist
# 卸载配置
launchctl unload ~/Library/LaunchAgents/example.plist
launchctl unload com.philandro.anydesk
sudo launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist

## sudo免输入密码
sudo visudo
%admin ALL=(ALL) NOPASSWD: ALL

export PATH=/opt/local/bin:/opt/local/sbin:$PATH
```

## 菜单栏

* 去掉蓝牙等无需经常使用的图标
* 将电池显示设置为百分比

## [Multi-Touch](https://support.apple.com/zh-cn/HT204895)

* 光标与点击
  - 轻拍来点按
  - 辅助点按
  - 查找
  - 三指拖移
* 滚动缩放
  - 默认全选
* 查询单词释义：鼠标放在单词上，不用选中，直接长按，再抬起
* 双手轻按屏幕：唤醒右键
* 双指旋转：改变照片的显示方向
* 屏幕缩放：双指放大放小
* 显示通知中心：双手从触控盘外右侧滑至触控盘内
* 桌面调度：三指往下&三指往上
* 启动台启动：拇指和三指聚拢
* 返回桌面：拇指和三指张开
* 右上方的图标，按住command键可调整位置，往下拖可删除，又可在系统偏好设置里重新找回
* 桌面分配：对应不同应用场景
* 聚焦搜索：command+空格，直接弹出搜索内容，再点击command+B即可跳转到Safari里查看搜索内容
* 画中画功能：在视频网站中点击右键，鼠标挪到一旁，再点一下右键，选择“画中画’’功能，视频画面大小可自由拖拽
* Option 使用场景：
  - 拖拽文件时按住option，即可复制粘贴当前所拖拽文件
  - 按菜单栏时，按住option，会出现多种功能；按住Wi-Fi图标同时按住option，可显示当前IP信息
  - 按住option同时按住通知中心的图标，系统进入勿扰模式
* 程序安装&卸载
  - 安装程序：通过APP store或者通过网页，网页下载的dmg文件相当于Windows里的EXE文件
  - 删除程序：在启动台长按程序图标再删除，或者在访达的应用程序里，将程序拖拽到废纸篓

## Mission Control

* 区分工作台:不同的桌面存放不同的软件。使用 Mission Control 和多 Desktop 工作区，简直就是完美任务切换
  - control+num:切换窗口
* 保持专注,一个工作区下做一件事情,至于这件事情需要多少软件，那就提前把这些软件放进来就好
  - [ShiftIt](https://github.com/fikovnik/ShiftIt):布局程序窗口
  - Option+Tab 在同一工作台切换不同的程序
  - Cmd+~:切换同一个软件不同窗口
* 使用快速查看窗口
* 同时移动所有的窗口
* 使用键盘控制导航
  - Control键和向上方向键来启用 Mission Control

## Spotlight

* 去掉字体和书签与历史记录等不需要的内容
* 设置合适的快捷键
* 查词典 Command+L
* 在浏览器查询 Command+B

## airdrop

* 苹果设备局域网共享链接，开启后，进行shares

## 共享目录

* smaba
  - windows下Run "\\192.168.0.4" 来访问其他机器共享的目录
  - Mac中， 先打开Finder, command +K  打开共享目录 输入：`smb://192.168.0.4/share`

## 软件

* 安装
  - 通过plist文件安装软件
  - app store 安装
  - 下载dmg，打开安装包，将app图标拖到application中
  - `brew cask install firefox`
* 卸载
  - launchpad 长按
  - finder 找到移动到垃圾桶
  - 通过[AppCleaner](https://freemacsoft.net/appcleaner/)彻底清除
* 系统
  *   [Eye Monitor](https://sspai.com/post/66205)
  *   [Aware](https://awaremac.com/)屏幕使用时长监控
  - [airmail](http://airmailapp.com/):mail client
  - [nylas-mail](https://github.com/nylas/nylas-mail):💌 An extensible desktop mail app built on the modern web. Forks welcome!
  - [Hazel](https://www.noodlesoft.com/):Automated Organization for Your Mac.
  - [Gemini](https://macpaw.com/gemini):The intelligent duplicate file finder
  - TotalFinder - macOS 上最强的 Finder 增强软件
  - BTT(BetterTouchTool) 触控板手势增强
  - CleanMyMac
  - [Little Snitch 4](https://www.obdev.at/products/littlesnitch/index.html):makes these Internet connections visible and puts you back in control!
  - [Dropzone](https://aptonic.com/):makes it faster and easier to move and copy files, launch applications, upload to many different services, and more.
  - [Time](https://timingapp.com/):automatically tracking how you spend your time.
  - [Fantastical 2](https://flexibits.com/fantastical):The calendar app 收费
  - manico:Dock app 映射为数字键
  - [neofetch](https://github.com/dylanaraps/neofetch):🖼️ A command-line system information tool written in bash 3.2+
  - [vtop](https://github.com/MrRio/vtop):Wow such top. So stats. More better than regular top. <http://parall.ax/vtop>
  - [GPG Suite](https://gpgtools.org/)
  - [dashlane](https://www.dashlane.com/zh):密码管理工具
  - [kap](https://github.com/wulkano/kap):An open-source screen recorder built with web technology <https://getkap.co>
  - [LICEcap](link):gif录制
  - [FinderGo](https://github.com/onmyway133/FinderGo):🐢 Open terminal quickly from Finder
  - [Sloth](https://github.com/sveinbjornt/Sloth):Mac app that shows all open files and sockets in use by all running processes. Nice GUI for lsof. <https://sveinbjorn.org/sloth>
  - Luna Display:Turn your iPad into a second display
  - 实用工具：/System/Library/CoreServices/Applications
  - [Ityscal](https://www.mowglii.com/itsycal/) 日历
  - [quick-look-plugins](https://github.com/sindresorhus/quick-look-plugins):List of useful Quick Look plugins for developers
  - [smcfunControl](link)
  - uTools - 比 Alfred 更简洁的工作流
* 设计
  - UI:sketch sketch box
  - Axure：原型工具
  - CmapTools：概念图
  - Snipaste - 灵活的截图 + 贴图软件
* 写作
  - Latex
  - Quiver：笔记软件
  - [tusk](https://github.com/champloohq/tusk):自定义主题的evernote的app
  - [ulysses](https://ulyssesapp.com/)
  - [marked2](http://marked2app.com/)
  - Upad
  - [Bear](https://bear.app/):Write beautifully on iPhone, iPad, and Mac
* 下载
  - bitlord
  - Folx
  - [BaiduNetdiskPlugin-macOS](https://github.com/CodeTips/BaiduNetdiskPlugin-macOS):For macOS.百度网盘 破解SVIP、下载速度限制~
* 工具
  - [CheatSheet]() 长按⌘键可以显示当前程序快捷键
  - [flux](https://justgetflux.com/) 屏幕颜色控制
  - [Lunar](https://github.com/alin23/Lunar) 智能调节外接显示器亮度 <https://lunar.fyi/>
  - [](https://github.com/pqrs-org/Karabiner-Elements):Karabiner-Elements is a powerful utility for keyboard customization on macOS Sierra (10.12) or later. <https://pqrs.org/osx/karabiner/>
  - [stats](https://github.com/exelban/stats):macOS system monitor in your menu bar
  - [eul](https://github.com/gao-sun/eul):desktop_computer macOS status monitoring app written in SwiftUI.
* 窗口管理
  - [spectacl](https://www.spectacleapp.com/):Move and resize windows with ease
  - [QSpace](link)一个国产软件，MacOS 系统的多视图文件管理器，支持很多特色功能。让摆脱多窗口来回切换的繁琐，和拖拽时找不准目标的尴尬
  - [chunkwm](https://koekeishiya.github.io/chunkwm/index.html):a tiling window manager for macOS
  - [moom](https://manytricks.com/moom/)使用体验优异的窗口管理软件
  - [Magnet](link)
  - [Rectangle](https://rectangleapp.com/)
  - [sizeup](link) 窗口管理软件
    + control+option+command + M ： 使当前窗口全屏
    + control+option+command + 方向键上键 ： 使当前窗口占用当前屏幕上半部分
    + control+option+command + 方向键下键 ： 使当前窗口占用当前屏幕下半部分
    + control+option+command + 方向键左键 ： 使当前窗口占用当前屏幕左半部分
    + control+option+command + 方向键右键 ： 使当前窗口占用当前屏幕右半部分
    + control+option + 方向键左键 ： 将当前窗口发送到左边显示器屏幕
    + control+option + 方向键右键 ： 将当前窗口发送到右边显示器屏幕
  - [transmissionbt](https://transmissionbt.com/):Transmission is a cross-platform BitTorrent client
  - [Helium](http://heliumfloats.com/):A floating browser window for OS X
  - Android file transfer
  - SensibleSideButtons - 在 macOS 上使用鼠标上的前进后退按键
* Pod
  - [PodcastMenu](https://github.com/insidegui/PodcastMenu):Put Overcast on your Mac's menu bar
* Web开发
  - [Paw](https://paw.cloud/):The most advanced API tool for Mac
  - MAMP:基础版不支持自定义
  - [clashX](https://github.com/yichengchen/clashX):A rule based custom proxy with GUI for Mac base on clash.
* 沟通
  - [Textual 7](<Textual is the world's most popular application for interacting with Internet Relay Chat (IRC) chatrooms on macOS.>)
  - [telegram](https://telegram.org/)
  - weibo:WeiboX
  - IM+
* 管理
  - OmniOutliner
  - OmniPlan
  - OmniFocus：GTD思路的应用
  - [Ship](https://www.realartists.com/index.html):Fast, native, comprehensive issue tracking and code review for GitHub
  - [trello](https://trello.com/home): Project management tool
  - [2do](https://www.2doapp.com/mac):helping me organise my tasks and things
  - Day One - Digital journal
  - Just Focus：商店下载
  - [pomofocus](https://pomofocus.io/):网页版
  - Any.do
  - Todoist
  - TickTick
  - Lucidchart
  - Kanban
  - [fsnotes](https://github.com/glushchenko/fsnotes):Notes manager for macOS/iOS
* 文档
  - [dash](https://kapeli.com/dash):语言文档
  - [TRANSMIT 5](https://www.panic.com/transmit/):Upload, download, and manage files on tons of servers with an easy, familiar, and powerful UI. It’s quite good.
  - Cloud Outline
  - iCHM
  * Clearview - 支持 PDF, EPUB, CHM, MOBI 的免费阅读器
* 音乐
  - 播放器：MPlayerX
  - [beardedspice](https://github.com/beardedspice/beardedspice):Mac Media Keys for the Masses <http://beardedspice.github.io>
  - [Noizio](http://noiz.io/):turn on the sound and allow yourself to become engulfed in the tranquil sounds of nature.
* 图片
  - 修图 Snapseed
  - iShot
  - [Pixave](http://www.littlehj.com/mac/) - Image/GIF/Video organizer
  - [ImageOptim](https://github.com/ImageOptim/ImageOptim):GUI image optimizer for Mac <https://imageoptim.com/mac>
* 阅读
  - ibooks：阅读支持pdf与epub，可以通过icloud同步
  - iTunes Movie Trailers
  - mounty:win的移动硬盘
  - [irreader](http://irreader.fatecore.com)
  - [medis](https://github.com/luin/medis)Medis is a beautiful, easy-to-use Mac database management application for Redis.
* 代码
  - [SnippetsLab](https://www.renfei.org/snippets-lab/):SnippetsLab is an easy-to-use code snippets manager
* 虚拟机
  - Parallels Desktop
* 安全
  - WireGuard for macOS
* 软件订阅
  - [setapp](https://setapp.com)The first subscription service for Mac apps.
* [LyricsX](https://github.com/MichaelRow/Lyrics)
* 说明
  - strace在linux下用来跟踪某个进程的系统调用，dtruss
* [Helium](https://github.com/JadenGeller/Helium):A floating browser window for OS X <http://heliumfloats.com>
* elpass
* 迷你天气：macOS 天气应用，在 Dock 栏知实时天气
* Things 3
* [MonitorControl](https://github.com/MonitorControl/MonitorControl):desktop_computer Control your external monitor brightness & volume on your Mac
* Moment：常驻于 macOS 菜单栏和通知中心的倒数日工具，又不止于倒数日。我们还支持了纪念日、时间进度条、你关心的人的年龄，每一个事件都支持单独添加到菜单栏
* Dropzone 就是这样一款，既能给带来键盘上如同 Launch Center Pro 体验同时，也提供了通过鼠标拖拽这样的操作，实现鼠标操作的肌肉记忆的应用
* [Here](https://here.app/)
* AutoSwitchInput - 自动切换输入法
* [Bartender](https://www.macbartender.com/):Organize your menu bar icons
* Hidden Bar - 另一款通知栏折叠工具
* [eZip](https://ezip.awehunt.com/):优秀的 macOS 压缩软件
* [poolside-fm](https://apps.apple.com/us/app/poolside-fm/id1514817810?mt=12)
* 参考
  - [Louiszhai/tool](https://github.com/Louiszhai/tool) 提升开发效率：Mac工具链推荐

### Stickies

* notes
  - 通过Web
  - Create a Progressive Web App (PWA) :More Tools-> Create Shortcut
  - More Tools, and then click Create Shortcut.
* 系统自带便利贴

### [brew](https://github.com/Homebrew/brew)

🍺 The missing package manager for macOS (or Linux)

* brew（意为酿酒）的命名很有意思，全部都使用了酿酒过程中采用的材料/器具，名词对应以下的概念：
* Formula（配方） 程序包定义，本质上是一个rb文件
* Keg（桶）程序包的安装路径
* Cellar（地窖）所有程序包（桶）的根目录
* Tap（水龙头）程序包的源
* Bottle （瓶子）编译打包好的程序包
* 增加一个程序源（新增一个水龙头） brew tap homebrew/php
* [homebrew-core](https://github.com/Homebrew/homebrew-core):🍻 Default formulae for the missing package manager for macOS <https://brew.sh>
* [axe.store](https://github.com/kuaibiancheng/axe.store):一款 Mac 下的包管理工具，同时支持命令行软件和图形界面软件安装

#### 文件路径

* 程序文件 /usr/local/etc/
* 应用文件 /usr/local/Cellar/
* 日志文件/usr/local/var
* 链接文件 /usr/local/opt

```sh
# 安装
# /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

HOMEBREW_PREFIX = "/usr/local".freeze
HOMEBREW_REPOSITORY = "/usr/local/Homebrew".freeze
HOMEBREW_CACHE = "#{ENV["HOME"]}/Library/Caches/Homebrew".freeze
HOMEBREW_OLD_CACHE = "/Library/Caches/Homebrew".freeze
#BREW_REPO = "https://github.com/Homebrew/brew".freeze
BREW_REPO = "git://mirrors.ustc.edu.cn/brew.git".freeze
#CORE_TAP_REPO = "https://github.com/Homebrew/homebrew-core".freeze
CORE_TAP_REPO = "git://mirrors.ustc.edu.cn/homebrew-core.git".freeze

/usr/bin/ruby ~/brew_install
```

#### brew vs [homebrew-cask](https://github.com/Homebrew/homebrew-cask)

🍻 A CLI workflow for the administration of macOS applications distributed as binaries <https://brew.sh>

* Homebrew 默认情况下会自带：
  - homebrew/core
  - homebrew/cask：Homebrew 的 macOS Native 应用扩展，通过 cask 可以安装各类应用程序
  - homebrew/services：台服务程序扩展，它基于 macOS 的 launchctl
  - homebrew/bundle：解决所有软件依赖，包括官方和第三方的 formula 以及 cask
* cask-versions：旧版的软件
* cask-fonts： Homebrew 官方的字体源
* brew:下载源码解压后。／.configure&& make install,同时包含相关以来库，并自动配置好各种环境变量，易于卸载
* brew cask：在 Homebrew 基础上的一个增强工具，用来安装 Mac 上的 GUI 程序应用包.已经编译好的应用包（.dmg/.pkg）,仅仅下载解压，放到统一目录（／opt/homebrew-cask/caskroom）,再软链到~/Applications/目录下

```sh
echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile(.zshrc)

brew -v|version
brew config
brew doctor

brew tap homebrew/services # brew 服务管理
# brew tap caskroom/cask
brew tap caskroom/versions
brew untap Homebrew/homebrew-versions # Remove a tapped repository

brew list --versions # 列出本机通过brew安装的所有软件

brew search name| /wget*/ # 搜索brew 支持的软件（支持模糊搜索)

brew install caskroom/cask/brew-cask
brew install -vd FORMULA
brew install tig|bash-completion|brew-cask-completion

brew (info|home|options) [FORMULA...]

brew deps name * # 显示包依赖
brew server * # 启动web服务器，可以通过浏览器访问http://localhost:4567/ 来同网页来管理包

brew update
# homebrew-cask is a shallow clone. To `brew update` first run:
git -C "/usr/local/Homebrew/Library/Taps/homebrew/homebrew-cask" fetch --unshallow
brew outdated # 查看哪些程序需要更新  brew update && brew upgrade

brew upgrade name  #更新安装过的软件(如果不加软件名，就更新所有可以更新的软件)
brew uninstall --force name # 卸载软件
brew remove  name # 卸载软件

brew cleanup #清除下载缓存
brew update && brew upgrade && brew cleanup ; say mission complete

brew update-reset # `require': cannot load such file -- active_support/core_ext/object/blank (LoadError)

brew link --force openssl # 链接新的openssl到环境变量中
brew link --overwrite docker

brew services [-v|--verbose] [list | run | start | stop | restart| reload | cleanup] formula|--all

# 卸载
cd `brew –prefix`
rm -rf Cellar
brew prune
rm -rf Library .git .gitignore bin/brew README.md share/man/man1/brew
rm -rf ~/Library/Caches/Homebrew

brew cask search|install|info|uninstall name
brew list --cask # 列出应用的信息

# plugins
brew cask install \
    qlcolorcode \
    qlstephen \
    qlmarkdown \
    quicklook-json \
    qlprettypatch \
    quicklook-csv \
    betterzipql \
    webpquicklook \
    suspicious-package

# app
brew cask install \
    alfred \
    android-file-transfer \
    appcleaner \
    caffeine \
    cheatsheet \
    docker \
    doubletwist \
    flux \
    google-chrome \
    iterm2 \
    mou \
    qq \
    spectacle \
    sublime-text \
    superduper \
    transmission \
    valentina-studio \
    vlc \
    virtualbox \
    the-unarchiver \
    thunder \
    evernote \

##
# Homebrew
##
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

##
# Homebrew bash completion
##
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    source $(brew --prefix)/etc/bash_completion
fi

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"

brews   brew list -1
brewsp  brew list --pinned
bubo    brew update && brew outdated
bubc    brew upgrade && brew cleanup
bubu    bubo && bubc
buf brew upgrade --formula
bcubo   brew update && brew outdated --cask
bcubc   brew cask reinstall $(brew outdated --cask) && brew cleanup
```

#### 源管理

```sh
# 替换清华 https://mirrors.tuna.tsinghua.edu.cn/help/homebrew/
git -C "$(brew --repo)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git
git -C "$(brew --repo homebrew/core)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git
git -C "$(brew --repo homebrew/cask)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask.git
git -C "$(brew --repo homebrew/cask-fonts)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask-fonts.git
git -C "$(brew --repo homebrew/cask-drivers)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask-drivers.git

## 更换 阿里
cd "$(brew --repo)" && git remote set-url origin https://mirrors.aliyun.com/homebrew/brew.git
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core" && git remote set-url origin https://mirrors.aliyun.com/homebrew/homebrew-core.git
echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.aliyun.com/homebrew/homebrew-bottles' >> ~/.zshrc

## 中科大
cd "$(brew --repo)" && git remote set-url origin git://mirrors.ustc.edu.cn/brew.git
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core" && git remote set-url origin git://mirrors.ustc.edu.cn/homebrew-core.git
echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles' >> ~/.bash_profile

# 还原
git -C "$(brew --repo)" remote set-url origin https://github.com/Homebrew/brew.git
git -C "$(brew --repo homebrew/core)" remote set-url origin https://github.com/Homebrew/homebrew-core.git
git -C "$(brew --repo homebrew/cask)" remote set-url origin https://github.com/Homebrew/homebrew-cask.git

git -C "/usr/local/Homebrew" remote set-url origin https://github.com/Homebrew/brew
git -C "/usr/local/Homebrew/Library/Taps/homebrew/homebrew-core" remote set-url origin https://github.com/Homebrew/homebrew-core

brew update

source ~/.zshrc
```

#### 服务管理

```sh
brew services start|stop|run mysql
```

#### 问题

```
> brew postinstall node  brew postinstall php@7.1 安装权限问题

cd /usr/local && sudo chown -R $(whoami) bin etc include lib sbin share var Frameworks

> Error: undefined method `core_tap?' for nil:NilClass

brew update --force
```

### [MacPORTS](https://guide.macports.org/)

an open-source community initiative to design an easy-to-use system for compiling, installing, and upgrading either command-line, X11 or Aqua based open-source software on the Mac operating system.

* Mac算是BSD的一个变种吧。所以，BSD的包管理软件port被移植到Mac上就显的理所当然了。
* macports的工作方式是下载source code然后在本地编译。
* macport的理念是尽量减少对系统现有库的依赖。 所以，第一次用macport的时候，需要很长时间让macport重新build整个基本库。代价是较长的编译时间，较多的依赖关系下载。
* 好处是不怎么依赖系统，也就是说，更新Mac OS不会破坏你现有的 package。另外，macports安装所有的package到/opt/local下面。这样不会和系统现有的/usr/local有什么冲突。
* 通过rsync维持数据索引一致

```sh
wget http://distfiles.macports.org/MacPorts/MacPorts-1.9.2.tar.gz
tar zxvf MacPorts-1.9.2.tar.gz
cd MacPorts-1.9.2
./configure && make && sudo make install
cd ../
rm -rf MacPorts-1.9.2*

# 添加 /etc/profile
export PATH=/opt/local/bin:$PATH
export PATH=/opt/local/sbin:$PATH

sudo port -v selfupdate  # 更新 MacPorts 索引
port search NAME
sudo port install NAME
sudo port uninstall NAME
port outdated
sudo port upgrade outdated
port help selfupdate
port list

port search --name --glob 'php*'
port search --name --line --glob 'php*'
port search --name --line --regex '^php\d*$'

port info yubico-pam
port deps apache2 +openldap
port contents xorg-renderproto
port installed

# 卸载
sudo port -fp uninstall installed
sudo rm -rf \
        /opt/local \
        /Applications/DarwinPorts \
        /Applications/MacPorts \
        /Library/LaunchDaemons/org.macports.* \
        /Library/Receipts/DarwinPorts*.pkg \
        /Library/Receipts/MacPorts*.pkg \
        /Library/StartupItems/DarwinPortsStartup \
        /Library/Tcl/darwinports1.0 \
        /Library/Tcl/macports1.0 \
        ~/.macports
```

#### homebrew vs macports

下载source并在本地编译安装，与macports差别

* homebrew的理念是尽量使用系统现有的库。这样可以大大的减少编译时间。
* package都安装到/usr/local下面。
* 资源包管理：Homebrew(安装完brew时，brew-cask已经安装好了，无需额外安装）

## screensavers

* 安装
  - /Library/Screen Savers/ 或者 ~/Library/Screen Savers/
* 资源
  - [fliqlo](https://fliqlo.com/):A flip Clock screensavers
  - Apple TV Aerial
  - [awesome-macos-screensavers](https://github.com/agarrharr/awesome-macos-screensavers)A curated list of screensavers for Mac OS X
  - [Aerial](https://github.com/JohnCoates/Aerial):Apple TV Aerial Screensaver for Mac
    + 航拍横跨中国、拉斯维加斯、旧金山、夏威夷、迪拜等等地方的白天和夜晚的精美景象
    + `brew cask install aerial`
    + 下载点击安装，重新进入系统偏好设置
  - [](https://github.com/OrangeJedi/Aerial):Apple TV screen saver for Windows

## 铃声制作

* 音乐文件用itunes打开
* getinfo剪辑（长度不变）
* 转换acc
* 在文件位置移开未见重命名.m4r
* 拖进tones
* 同步手机

## Automator

### [Keyboard Maestro](https://www.waerfa.com/keyboard-maestro)

essentially an IDE for automation

### [Hammerspoon](http://www.hammerspoon.org/)

* a desktop automation tool for OS X. It bridges various system level APIs into a Lua scripting engine
* 面向 macOS 的一个桌面自动化框架。它允许用户编写和操作系统功能挂钩的 Lua 脚本，从而与键盘、鼠标、窗口、文件系统等交互
* 应用：
  - 绑定移动窗口到的特定位置的快捷键
  - 创建可以自动将窗口整理成特定布局的菜单栏按钮
  - 在到实验室以后，通过检测所连接的 WiFi 网络自动静音扬声器
  - 在你不小心拿了朋友的充电器时弹出警告
* 可以运行任意 Lua 代码，绑定菜单栏按钮、按键、或者事件。Hammerspoon 提供了一个全面的用于和系统交互的库，因此它能没有限制地实现任何功能。你可以从头编写自己的 Hammerspoon 配置，也可以结合别人公布的配置来满足自己的需求
* 参考
  - [Hammerspoon 官方教程](https://www.hammerspoon.org/go/)
  - [官方示例配置](https://github.com/Hammerspoon/hammerspoon/wiki/Sample-Configurations)
  - [Anish 的 Hammerspoon 配置](Anish 的 Hammerspoon 配置)

### [alfred](https://www.alfredapp.com/)

a very powerful launcher that you can program to show you anything you want

* 购买 Powerpack. 快捷键：option + space
* [workflow](http://www.alfredworkflow.com/)
  - [alfred-workflows](https://github.com/learn-anything/alfred-workflows):Amazing Alfred Workflows
  - [alfred-github-workflow](https://github.com/gharlan/alfred-github-workflow):GitHub Workflow for Alfred 3
  - [AlfredWorkflow.com](https://github.com/hzlzh/AlfredWorkflow.com):A public Collection of Alfred Workflows. <http://www.alfredworkflow.com/>
  - [alfred-workflows](https://github.com/zenorocha/alfred-workflows):🤘 A collection of Alfred 3 and 4 workflows that will rock your world

## terminal

* [Mac-CLI](https://github.com/guarinogabriel/Mac-CLI)  OS X command line tools for developers – The ultimate tool to manage your Mac. It provides a huge set of command line commands that automatize the usage of your OS X system.
* [terminal-mac-cheatsheet](https://github.com/0nn0/terminal-mac-cheatsheet)List of my most used commands and shortcuts in the terminal for Mac
* [m-cli](https://github.com/rgcr/m-cli): Swiss Army Knife for macOS
* [awesome-macos-command-line](https://github.com/herrbischoff/awesome-macos-command-line):Use your macOS terminal shell to do awesome things.
* iTerm2
  - 标签颜色会变化，以指示该 tab 当前的状态
    + 当该标签有新输出的时候，标签会变成洋红色
    + 新的输出长时间没有查看，标签会变成红色。可在设置中关掉该功能。
  - 双击选中，三击选中整行，四击智能选中（智能规则可配置），可以识别网址，引号引起的字符串，邮箱地址等
  - [启用 rz 与 sz 功能](https://wsgzao.github.io/post/lrzsz/)

```sh
# mac专有的pbcopy/pbpaste 把命令行输出拷贝到系统粘贴板：
cat test.sh| pbcopy

# 把系统粘贴板内容拷到终端:
pbpaste

for i in `say -v '?' | cut -d ' ' -f 1`; do echo $i && say -v "$i" 'Hello World';done
```

## 快捷键

* 键位
  - Command ⌘
  - Shift ⇧
  - Option ⌥
  - Control ⌃
  - Caps Lock ⇪
  - Fn
* option + command + sapce：finder
* Command–空格键：打开Spotlight
* command + n:新文件或新窗口
* command + m:最小化串口
* Ctrl+Command+ f:窗口最大化
* command + w:关闭当前窗口或文件
* command + d:后台关闭程序
* command + s/c/x/z/f／g/a/~:保存／复制／剪切／撤销／查找／查找的在一个／切换tab
* command + option + v 粘贴
* 预览文件 快速查看 --###Space
* 文件简介 -->Command+i
* 打开文件 -->Command+O
* 剪切文件 -->Command+Option+v
* 删除文件 -->Command+BackSpace
* command+delete，即删除选中文件
* command+双击选中的文件，即打开文件
* 隐藏dock：option + command + d
* 隐藏最前面应用窗口 Command-H
* 查看最前面应用但隐藏所有其他应用： option + command + h
* 强制退出： Option-Command-Esc
* control + command + Space:打开emoji
* Command-Shift-G：调出窗口，可输入绝对路径直达文件夹
* command + 上方向键：往上级文件
* Command-Delete：将文件移至废纸篓
* Command-Shift-Delete：清倒废纸篓
* 调出Spotlight搜索 --> Ctrl＋SpaceP
* ⌃+ 上/左/右:桌面间切换
* 已开应用之间的切换 --> Command+tab / Command+tab 选中后+Option 强制恢复窗口
* 程序内tab切换：⌃ + tab ⌘+⌥+←, ⌘+⌥+→, ⌘+⌥+{, ⌘+⌥+}。⌘+数字直接定位到该 tab；
* 新建 tab：⌘+t
* Command+Option+Esc:强制退出
* F11: 回到桌面
* 设置触发角 -->系统偏好 － Mission Control
* 隐藏DOCK -->Command+Option+D
* option+command+v
* 按着Option键 -->如关机时免再确认一次
* Shift+Control+ 推出键:锁屏键
* command + l 进入地址栏
* 截屏
  - command+shift+5
  - command+shift+3 截取当前整个屏幕，默认保存到桌面
  - command+shift+4 截取部分屏幕，默认保存到桌面
  - command+shift+option +3 截取当前整个屏幕，默认复制到剪切板（可直接粘贴到指定的窗口）
  - command+shift+option +4 截取部分屏幕，默认复制到剪切板（可直接粘贴到指定的窗口）
  - command+shift+4+空格键，精准剪切当前窗口

### 系统功能

* 打开我的文档或浏览器主页：shift + command + H
* 粘贴文本 -->Shift+Command+Option+V
* 将文件放在同新文件夹下 -->Ctrl+Command+N
* 全屏截图 -->Command+shift+3
* 区域截图 -->Command+Shift+4
* 窗口截图 -->Command+Shift+Space+4
* control＋command＋f：全屏/还原
* 直接新标签打开文件夹 Command+双击

```sh
cd ~ # .bash_profile 文件里引用了 .bash_prompt 和 .aliases，每次启动 Terminal 的时候，它都会引用 .bash_profile 里的设置，所以，以后你就可以把所有你需要的缩写都放到 .aliases 文件里去。
curl -O https://raw.githubusercontent.com/donnemartin/dev-setup/master/.bash_profile
curl -O https://raw.githubusercontent.com/donnemartin/dev-setup/master/.bash_prompt
curl -O https://raw.githubusercontent.com/donnemartin/dev-setup/master/.aliases
# [更换主题](https://github.com/tomislav/osx-terminal.app-colors-solarized)中的Solarized Dark.terminal，偏好导入并设置为默认，字体设为Courier New，20
```

### finder

* Command-D 复制所选文件。
* Command-E 推出所选磁盘或宗卷。
* Command-F 在 Finder 窗口中开始 Spotlight 搜索。
* Command-I 显示所选文件的"显示简介"窗口。
* Shift-Command-C 打开"电脑"窗口。
* Shift-Command-D 打开"桌面"文件夹。
* Shift-Command-F 打开"我的所有文件"窗口。
* Shift-Command-G 打开"前往文件夹"窗口。
* Shift-Command-H 打开当前 macOS 用户帐户的个人文件夹。
* Shift-Command-I 打开 iCloud Drive。
* Shift-Command-K 打开"网络"窗口。
* Option-Command-L 打开"下载"文件夹。
* Shift-Command-O 打开"文稿"文件夹。
* Shift-Command-R 打开"AirDrop"窗口。
* Shift-Command-T 将所选的 Finder 项目添加到 Dock（OS X Mountain Lion 或更低版本）
* Control-Shift-Command-T 将所选的 Finder 项目添加到 Dock（OS X Mavericks 或更高版本）
* Shift-Command-U 打开"实用工具"文件夹。
* Option-Command-D 显示或隐藏 Dock。即使您未在 Finder 中，这个快捷键通常也有效。
* Control-Command-T 将所选项添加到边栏（OS X Mavericks 或更高版本）。
* Option-Command-P 隐藏或显示 Finder 窗口中的路径栏。
* Option-Command-S 隐藏或显示 Finder 窗口中的边栏。
* Command–斜线 (/) 隐藏或显示 Finder 窗口中的状态栏。
* 状态栏图标
  - 移动：按住Command键，然后拖动某个图标即可
  - 删除：按住Command键并点按该图标，将其拖出菜单栏，当鼠标下方出现删除图标时再放开，就能将图标删除
* Command-J 显示"显示"选项。
* Command-K 打开"连接服务器"窗口。
* Command-L 为所选项制作替身。
* Command-N 打开一个新的 Finder 窗口。
* Shift-Command-N 新建文件夹。
* Option-Command-N 新建智能文件夹。
* Command-R 显示所选替身的原始文件。
* Command-T 在当前 Finder 窗口中有单个标签页开着的状态下显示或隐藏标签页栏。
* Shift-Command-T 显示或隐藏 Finder 标签页。
* Option-Command-T 在当前 Finder 窗口中有单个标签页开着的状态下显示或隐藏工具栏。
* Option-Command-V 移动：将剪贴板中的文件从原始位置移动到当前位置。
* Option-Command-Y 显示所选文件的快速查看幻灯片显示。
* Command-Y 使用"快速查看"预览所选文件。
* Command-1 以图标方式显示 Finder 窗口中的项目。
* Command-2 以列表方式显示 Finder 窗口中的项目。
* Command-3 以分栏方式显示 Finder 窗口中的项目。
* Command-4 以 Cover Flow 方式显示 Finder 窗口中的项目。
* Command–左中括号 (\[) 前往上一文件夹。
* Command–右中括号 (]) 前往下一文件夹。
* Command–上箭头 打开包含当前文件夹的文件夹。
* Command–Control–上箭头 在新窗口中打开包含当前文件夹的文件夹。
* Command–下箭头 打开所选项。
* Command–Mission Control 显示桌面。即使未在 Finder 中，这个快捷键也有效。
* Command–调高亮度 开启或关闭目标显示器模式。
* Command–调低亮度 当 Mac 连接到多个显示器时打开或关闭显示器镜像功能。
* 右箭头 打开所选文件夹。这个快捷键仅在列表视图中有效。
* 左箭头 关闭所选文件夹。这个快捷键仅在列表视图中有效。
* Option-连按 在单独的窗口中打开文件夹，并关闭当前窗口。
* Command-连按 在单独的标签页或窗口中打开文件夹。
* Command-Delete 将所选项移到废纸篓。
* Shift-Command-Delete 清倒废纸篓。
* Option-Shift-Command-Delete 清倒废纸篓而不显示确认对话框。
* Command-Y 使用"快速查看"预览文件。
* Option–调高亮度 打开"显示器"偏好设置。这个快捷键可与任一亮度键搭配使用。
* Option–Mission Control 打开"Mission Control"偏好设置。
* Option–调高音量 打开"声音"偏好设置。这个快捷键可与任一音量键搭配使用。
* 拖移时按 Command 键 将拖移的项目移到其他宗卷或位置。拖移项目时指针会随之变化。
* 拖移时按住 Option 键 拷贝拖移的项目。拖移项目时指针会随之变化。
* 拖移时按住 Option-Command 为拖移的项目制作替身。拖移项目时指针会随之变化。
* Option-点按开合三角形 打开所选文件夹内的所有文件夹。这个快捷键仅在列表视图中有效。
* Command-点按窗口标题 查看包含当前文件夹的文件夹。
* 选中一个文件按 enter 可以直接改名的
* cmd+up是回到上一层文件夹cmd+ down 如果是文件夹就进入文件夹
* 选中一个文件按 enter 可以直接改名的...cmd+up是回到上一层文件夹cmd+ down 如果是文件夹就进入文件夹
* 使用Finder登录FTP：打开Finder然后按Command+K
* Fn+Delete键，就可以向后删除
* Command(⌘)- 空格键   聚焦
* Command+Shift+G 可以前往任何文件夹,包括隐藏文件夹
* Command+Shift+. 显示或隐藏 隐藏文件
* 修改DNS提高Apple Store 网速:打开：systerm Preferences > Network > Advanced > DNS
  - 223.5.5.5 223.6.6.6 114.114.114.114 168.95.1.1 168.95.192.22 68.95.192.33

### Safari && Chrome

* command + 1（2、3...）分别是打开书签栏的第一个、第二个..
* command+r command + shift + r刷新。喜欢看直播的同学有福啦。
* command+d 当前网页添加到书签。
* command+opt+1打开topsites。
* command+opt+2打开历史记录。
* command+【 上一个标签页。
* command+】 下一个标签页。
* command+shift+home 打开首页。
* command + w:关闭当前标签
* Safari偏好设置 -->Command+ ，
* 进入阅读模式 -->Command+Shift+ R
* 选中文字加便签 -->Command+Shift+Y
* ⌥-⌘-I 开发工具
* 关闭其他标签 Conmand+Option+w
* 标签向左 Ctrl+Shift+tab
* 标签向右 Ctrl+tab
* 标签左右 Shift+Command+ &lt;- / ->
* 新建标签 Conmand+T
* 新建窗口 Conmand+n
* 打开侧栏 Conmand+Shift+L
* 打开标签栏 Shift+Command+B
* 刷新 Command+R
* 恢复 Command+Z
* 主页 Command+Shift+H
* 调试工具 Option-Command-I
* Command–上箭头：页面历史的切换
* Command+M: 最小化窗口
* Command+W: 关闭窗口
* Command+Q: 退出程序
* 按住⌘键:
  - 可以拖拽选中的字符串；
  - 点击 url：调用默认浏览器访问该网址；
  - 点击文件：调用默认程序打开文件；
  - 如果文件名是filename:42，且默认文本编辑器是 Macvim、Textmate或BBEdit，将会直接打开到这一行；
  - 点击文件夹：在 finder 中打开该文件夹；
  - 同时按住option键，可以以矩形选中，类似于vim中的ctrl v操作。

- tab操作
  - 切换 tab：⌘+←, ⌘+→, ⌘+{, ⌘+}。⌘+数字直接定位到该 tab；
  - 新建 tab：⌘+t；
  - 顺序切换 pane：⌘+[, ⌘+]；
  - 按方向切换 pane：⌘+Option+方向键；
  - 切分屏幕：⌘+d 水平切分，⌘+Shift+d 垂直切分；
  - 智能查找，支持正则查找：⌘+f。
  - ⌘+;弹出自动补齐窗口 之前做法 control + r：历史命令行匹配
  - ⌘+Option+e全屏展示所有的 tab，可以搜索

### 文稿快捷键

* Command-B 以粗体显示所选文本，或者打开或关闭粗体显示功能。
* Command-I 以斜体显示所选文本，或者打开或关闭斜体显示功能。
* Command-U 对所选文本加下划线，或者打开或关闭加下划线功能。
* Command-T 显示或隐藏"字体"窗口.
* Command-D 从"打开"对话框或"存储"对话框中选择"桌面"文件夹。
* Control-Command-D 显示或隐藏所选字词的定义。
* Shift-Command-冒号 (:) 显示"拼写和语法"窗口。
* Command-分号 (;) 查找文稿中拼写错误的字词。
* Option-Delete 删除插入点左边的字词。
* Control-H 删除插入点左边的字符。也可以使用 Delete 键。
* Control-D 删除插入点右边的字符。也可以使用 Fn-Delete。
* Fn-Delete 在没有向前删除 键的键盘上向前删除。也可以使用 Control-D。
* Control-K 删除插入点与行或段落末尾处之间的文本。
* Command-Delete 在包含"删除"或"不存储"按钮的对话框中选择"删除"或"不存储"。

### 翻页

* Fn–上箭头 向上翻页：向上滚动一页。
* Fn–下箭头 向下翻页：向下滚动一页。
* Fn–左箭头 开头：滚动到文稿开头。
* Fn–右箭头 结尾：滚动到文稿末尾。
* Fn + Delete 键可向后删除内容
* option+shift+K:logo
* Command–上箭头 将插入点移至文稿开头。
* Command–下箭头 将插入点移至文稿末尾。
* Command–左箭头 将插入点移至当前行的行首。
* Command–右箭头 将插入点移至当前行的行尾。
* Option–左箭头 将插入点移至上一字词的词首。
* Option–右箭头 将插入点移至下一字词的词尾。
* Shift–Command–上箭头 选中插入点与文稿开头之间的文本。
* Shift–Command–下箭头 选中插入点与文稿末尾之间的文本。
* Shift–Command–左箭头 选中插入点与当前行行首之间的文本。
* Shift–Command–右箭头 选中插入点与当前行行尾之间的文本。
* Shift–上箭头 将文本选择范围扩展到上一行相同水平位置的最近字符处。
* Shift–下箭头 将文本选择范围扩展到下一行相同水平位置的最近字符处。
* Shift–左箭头 将文本选择范围向左扩展一个字符。
* Shift–右箭头 将文本选择范围向右扩展一个字符。
* Option–Shift–上箭头 将文本选择范围扩展到当前段落的段首，再按一次则扩展到下一段落的段首。
* Option–Shift–下箭头 将文本选择范围扩展到当前段落的段尾，再按一次则扩展到下一段落的段尾。
* Option–Shift–左箭头 将文本选择范围扩展到当前字词的词首，再按一次则扩展到后一字词的词首。
* Option–Shift–右箭头 将文本选择范围扩展到当前字词的词尾，再按一次则扩展到后一字词的词尾。
* Control-A 移至行或段落的开头。
* Control-E 移至行或段落的末尾。
* Control-F 向前移动一个字符。
* Control-B 向后移动一个字符。
* Control-L 将光标或所选内容置于可见区域中央。
* Control-P 上移一行。
* Control-N 下移一行。
* Control-O 在插入点后插入一行。
* Control-T 将插入点后面的字符与插入点前面的字符交换。
* Command–左花括号 ({) 左对齐。
* Command–右花括号 (}) 右对齐。
* Shift–Command–竖线 (|) 居中对齐。
* Option-Command-F 前往搜索栏。
* Option-Command-T 显示或隐藏应用中的工具栏。
* Option-Command-C 拷贝样式：将所选项的格式设置拷贝到剪贴板。
* Option-Command-V 粘贴样式：将拷贝的样式应用到所选项。
* Option-Shift-Command-V 粘贴并匹配样式：将周围内容的样式应用到粘贴在这个内容中的项目。
* Option-Command-I 显示或隐藏检查器窗口。
* Shift-Command-P 页面设置：显示用于选择文稿设置的窗口。
* Shift-Command-S 显示"存储为"对话框或复制当前文稿。
* Shift–Command– 减号 (-) 缩小所选项。
* Shift–Command– 加号 (+) 放大所选项。
* Command–等号 (=) 可执行相同的功能。

#### AirServer Connect：Mac显示iPhone

* 手机线接电脑；quickplayer 新建影片录制 录像按钮选择设备
* 通过软件AirServer Connect（收费）

#### iPhone 控制 keynote（同一个网路下）

* mac端偏好设置中remote开启并连接手机
* iphone keynote进入远程控制，开始控制
* AirPlay功能投影到Apple TV

## handoff:浏览器设备共享

### features

* Essentials：可设置搜索“应用程序(默认自动选中)”、“联系人”、“设置”。
* Extras：可设置搜索“文件夹”、“文本文件”、“压缩”、“文档”、“图片”、“AppleScript”等其他文件。
* Unintelligent：Search all file types 搜索所有文件类型。使用 Find+空格+文件名 来查询文件或文件夹；使用 Open+空格+文件名 也可以打开文件。键入空格，输入要查找文件名 find是定位文件，open是定位并打开文件，in是在文件中进行全文检索
* Search Scope：设置 Alfred 查询时会搜索的文件夹范围，可自己添加和删除。
* Fallbacks：若上面的查询搜索不到结果时，就会调用这里设置的网站或搜索引擎来进行进一步的查询。默认反馈结果为 Google、Amazon、Wikipedia 网页搜索。
  - 自定义搜索页面
    - <https://www.baidu.com/s?ie=utf-8&f=8&wd={query}>
    - <http://www.stackoverflow.com/search?q={query}>
    - <http://www.stackoverflow.com/search?q={query}>
  - 当计数器用:直接输入计算
  - 设置搜索关键字搜索浏览器书签
  - 自定义关键词搜索单词
  - 操作Shell：输入>即可直接运行shell命令。比如>cat \*.py | grep print，可以直接打开终端并查找当前py文件中包含 print 的语句

### workflows

* 使用 Vagrant 或者 Docker（配合 docker-machine 和 docker-compose）
* 用 Time Machine 做好备份

### Keyboard shortcuts

    | Description            | Keys                                              |
    | ---------------------- | ------------------------------------------------- |
    | Toggle Window Menu     | <kbd>Alt</kbd>                                    |
    | Return to Notes        | <kbd>Esc</kbd>                                    |
    | Delete Note            | <kbd>Delete</kbd>                                 |
    | Toggle Dark Theme      | <kbd>Cmd/Ctrl</kbd> <kbd>D</kbd>                  |
    | Toggle Focus Mode      | <kbd>Cmd/Ctrl</kbd> <kbd>K</kbd>                  |
    | Exit Focus Mode        | <kbd>Cmd/Ctrl</kbd> <kbd>O</kbd>                  |
    | New Note               | <kbd>Cmd/Ctrl</kbd> <kbd>N</kbd>                  |
    | Add Shortcut           | <kbd>Cmd/Ctrl</kbd> <kbd>S</kbd>                  |
    | Set Reminder           | <kbd>Cmd/Ctrl</kbd> <kbd>E</kbd>                  |
    | Search Notes           | <kbd>Cmd/Ctrl</kbd> <kbd>F</kbd>                  |
    | Bold Text              | <kbd>Cmd/Ctrl</kbd> <kbd>B</kbd>                  |
    | Italic Text            | <kbd>Cmd/Ctrl</kbd> <kbd>I</kbd>                  |
    | Underline Text         | <kbd>Cmd/Ctrl</kbd> <kbd>U</kbd>                  |
    | Strikethrough Text     | <kbd>Cmd/Ctrl</kbd> <kbd>T</kbd>                  |
    | Increase Indentation   | <kbd>Cmd/Ctrl</kbd> <kbd>M</kbd>                  |
    | Toggle Settings        | <kbd>Cmd/Ctrl</kbd> <kbd>,</kbd>                  |
    | Make Text Smaller      | <kbd>Cmd/Ctrl</kbd> <kbd>-</kbd>                  |
    | Reset Zoom Level       | <kbd>Cmd/Ctrl</kbd> <kbd>0</kbd>                  |
    | Toggle Black Theme     | <kbd>Cmd/Ctrl</kbd> <kbd>Alt</kbd> <kbd>E</kbd>   |
    | Toggle Tags            | <kbd>Cmd/Ctrl</kbd> <kbd>Alt</kbd> <kbd>T</kbd>   |
    | Toggle Notebooks       | <kbd>Cmd/Ctrl</kbd> <kbd>Alt</kbd> <kbd>N</kbd>   |
    | Align Left             | <kbd>Cmd/Ctrl</kbd> <kbd>Alt</kbd> <kbd>L</kbd>   |
    | Align Center           | <kbd>Cmd/Ctrl</kbd> <kbd>Alt</kbd> <kbd>M</kbd>   |
    | Align Right            | <kbd>Cmd/Ctrl</kbd> <kbd>Alt</kbd> <kbd>R</kbd>   |
    | Make Text Larger       | <kbd>Cmd/Ctrl</kbd> <kbd>Shift</kbd> <kbd>=</kbd> |
    | New Tag                | <kbd>Cmd/Ctrl</kbd> <kbd>Shift</kbd> <kbd>T</kbd> |
    | New Notebook           | <kbd>Cmd/Ctrl</kbd> <kbd>Shift</kbd> <kbd>N</kbd> |
    | Toggle Checkbox        | <kbd>Cmd/Ctrl</kbd> <kbd>Shift</kbd> <kbd>C</kbd> |
    | Code Block             | <kbd>Cmd/Ctrl</kbd> <kbd>Shift</kbd> <kbd>L</kbd> |
    | Add Link               | <kbd>Cmd/Ctrl</kbd> <kbd>Shift</kbd> <kbd>K</kbd> |
    | Attach File            | <kbd>Cmd/Ctrl</kbd> <kbd>Shift</kbd> <kbd>F</kbd> |
    | Insert from Drive      | <kbd>Cmd/Ctrl</kbd> <kbd>Shift</kbd> <kbd>D</kbd> |
    | Decrease Indentation   | <kbd>Cmd/Ctrl</kbd> <kbd>Shift</kbd> <kbd>M</kbd> |
    | Numbered List          | <kbd>Cmd/Ctrl</kbd> <kbd>Shift</kbd> <kbd>O</kbd> |
    | Toggle Shortcuts       | <kbd>Cmd/Ctrl</kbd> <kbd>Shift</kbd> <kbd>S</kbd> |
    | Bulleted List          | <kbd>Cmd/Ctrl</kbd> <kbd>Shift</kbd> <kbd>.</kbd> |
    | Submscript Text        | <kbd>Cmd/Ctrl</kbd> <kbd>Shift</kbd> <kbd>]</kbd> |
    | Superscript Text       | <kbd>Cmd/Ctrl</kbd> <kbd>Shift</kbd> <kbd>[</kbd> |
    | Insert Horizontal Rule | <kbd>Cmd/Ctrl</kbd> <kbd>Shift</kbd> <kbd>-</kbd> |

### XtraFinder 文件管理器，涉及权限，暂停使用

## 网络

* 在局域网mac通过内网地址链接ubuntu，远程ssh登陆mac需要mac开启允许远程登陆
* lsof
  - -a 列出打开文件存在的进程
  - -c<进程名> 列出指定进程所打开的文件
  - -g 列出GID号进程详情
  - -d<文件号> 列出占用该文件号的进程
  - +d<目录> 列出目录下被打开的文件
  - +D<目录> 递归列出目录下被打开的文件
  - -n<目录> 列出使用NFS的文件
  - -i<条件> 列出符合条件的进程。（4、6、协议、:端口、 @ip ）
  - -p<进程号> 列出指定进程号所打开的文件
  - -u 列出UID号进程详情
  - -h 显示帮助信息
  - -v 显示版本信息

```sh
sudo lsof -nP -iTCP:端口号 -sTCP:LISTEN
lsof -Pni4 | grep LISTEN | grep php
lsof -nP -iTCP:4000 |grep LISTEN|awk '{print $2;}'
lsof -i tcp:8811

netstat lnp tcp
netsta lnp udp

lsof -i tcp:8081  # 端口查看

sudo lsof -i :9000

## Route table
netstat -nr # 查看路由表
sudo route -n add -net 192.168.0.0 -netmask 255.255.255.0 192.168.5.254
route add -net 172.17.0.0 -netmask 255.255.255.0 dev eth0
route add [-net|-host] [网域或主机] netmask [mask] [gw|dev]
```

### 远程登录

* 开启设置-〉共享-〉远程登录

## 问题

```
Failed to initialize MacPorts, OS platform mismatch 重新安装

dyld: Library not loaded: /usr/local/opt/icu4c/lib/libicui18n.62.dylib

icu4c was upgraded to version 63 but my locally installed postgres image still referenced icu4c 62.1

brew switch icu4c 62.1

127.0.0.1 无法连接

/privte/etc/hosts
::1 localhost那一行注释掉或者删掉
```

## 重置密码

* 重新启动时,按住CMD + R、直到苹果标志出现。然后你就可以进入恢复模式
* Utilities > Terminal打开一个终端。在终端,输入resetpassword并按Enter键
* 选择你的OS X驱动。从下拉下“:选择用户帐户”,选择你想要的用户帐户重置密码

## 图书

* [The Cult of Mac, 2nd Ed](link)
* [碼農 codeMaker](link)
* Take Control of the Mac Command Line with Terminal
* macOS Terminal and Shell

## 工具

* macOS Server拥有众多强大工具可以让整个团队更高效地分享信息，分工合理第一合作
* [Docker-OSX](https://github.com/sickcodes/Docker-OSX):Mac in Docker! Run near native OSX-KVM in Docker! X11 Forwarding!
* [quick-look-plugins](https://github.com/sindresorhus/quick-look-plugins):List of useful Quick Look plugins for developers
* [sshpass](https://wsgzao.github.io/post/sshpass/)
* [darwin-xnu](https://github.com/apple/darwin-xnu)The Darwin Kernel (mirror) <https://opensource.apple.com/>
  - XNU，实际上是“XNU is Not Unix（是XNU，不是Unix）”的缩写，属于macOS（包括以往全部版本）以及iOS所使用的类Unix内核。通过公开内核代码，苹果公司将帮助开发人员更轻松地理解其设备与更高软件层同内核之间的协作原理
  - 其源代码基于苹果公共源许可（ Apple Public Source License ）2.0，这其实是一项相当严格的许可;开发人员可能需要查看其详细信息，而后再有根据地将此次发布的内核代码引入自有项目
* [xbar](https://github.com/matryer/xbar)Put the output from any script or program into your macOS Menu Bar (the BitBar reboot) https://xbarapp.com/

## 参考

* [awesome-macOS](https://github.com/iCHAIT/awesome-macOS) A curated list of awesome applications, softwares, tools and shiny things for macOS.
* [awesome-mac](https://github.com/jaywcjlove/awesome-mac)a collection of awesome Mac applications and tools for developers and designers.
* [my-mac-os](https://github.com/nikitavoloboev/my-mac-os):💻 List of applications, alfred workflows and various tools that make my macOS experience even more amazing
* [macOS 从小白到入门](https://wsgzao.github.io/post/macbook/)
* [黑果小兵的部落阁](https://blog.daliansky.ne)
* [Best-App](https://github.com/hzlzh/Best-App):收集&推荐优秀的 Apps/硬件/技巧/周边等
* [gasmask](https://github.com/2ndalpha/gasmask)Hosts file manager for OS X

* [Mac OS X 背后的故事](https://kb.cnblogs.com/page/114879/)
