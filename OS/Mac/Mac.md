# MAC

Mac：最大优势是 GUI 和命令行的完美结合

## 硬件

* Apple Magic Trackpad 2：重现Mac pro mul touch功能
* 耳机 BeoPlay H6
* iPad Pro：阅读利器
* 格式化移动硬盘：ExFAT格式
* imac Radeon Pro 580
    + (2019)Radeon Pro 580X 图形处理器 (配备 8GB 显存) 可选配 Radeon Pro Vega 48

## 系统配置

* 开启鼠标更多功能
* 将功能键(F1-F12)的行为设置为标准的功能键
* dock 停在左边
* iphone,只能同步一台设备itunes配置
* 设置未收录的开发者应用`sudo spctl --master-disable`

### 配置

* [arialdomartini/dotfiles](https://github.com/arialdomartini/dotfiles)Just my Mac OS X and Linux dot files
* [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles).files, including ~/.macos -- sensible hacker defaults for macOS
* [skwp/dotfiles](https://github.com/skwp/dotfiles) YADR - The best vim,git,zsh plugins and the cleanest vimrc you've ever seen
* [holman/dotfiles](https://github.com/holman/dotfiles)@holman does dotfiles
* [thoughtbot/dotfiles](https://github.com/thoughtbot/dotfiles):A set of vim, zsh, git, and tmux configuration files.
* [使用 dotfiles 和 stow 管理你的 dotfiles](https://github.com/jcouyang/dotfiles)
* [nikitavoloboev/my-mac-os](https://github.com/nikitavoloboev/my-mac-os):💻 List of applications, alfred workflows and various tools that make my macOS experience even more amazing
* [donnemartin/dev-setup](https://github.com/˚∫)Mac OS X development environment setup: Easy-to-understand instructions with automated setup scripts for developer tools like Vim, Sublime Text, Bash, iTerm, Python data analysis, Spark, Hadoop MapReduce, AWS, Heroku, JavaScript web development, Android development, common data stores, and dev-based OS X defaults.
* [nicolashery/mac-dev-setup](https://github.com/nicolashery/mac-dev-setup)A beginner's guide to setting up a development environment on Mac OS X
* [geerlingguy/mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook)Mac setup and configuration via Ansible.
* [thoughtbot/laptop](https://github.com/thoughtbot/laptop)A shell script to set up a macOS laptop for web and mobile development.
* [Multi-Touch](https://support.apple.com/zh-cn/HT204895)
* [maximum-awesome](https://github.com/square/maximum-awesome)Config files for vim and tmux.
* [Mac 开发配置手册](https://aaaaaashu.gitbooks.io/mac-dev-setup/content/)
* [2ndalpha/gasmask](https://github.com/2ndalpha/gasmask)Hosts file manager for OS X
* [agarrharr/awesome-macos-screensavers](https://github.com/agarrharr/awesome-macos-screensavers)A curated list of screensavers for Mac OS X
* [sb2nov/mac-setup](https://github.com/sb2nov/mac-setup) Installing Development environment on Mac OS X(<http://sourabhbajaj.com/mac-setup/>) 推荐
* [mac-setup/](http://sourabhbajaj.com/mac-setup/) the basics of setting up a development environment on a new Mac
* [smyhvae/Mac](https://github.com/smyhvae/Mac) Mac软件、使用技巧整理
* [高效MacBook工作环境配置](http://goahead2010.iteye.com/blog/2232869)
* [Louiszhai/tool](https://github.com/Louiszhai/tool) 提升开发效率：Mac工具链推荐
* [iCHAIT/awesome-macOS](https://github.com/iCHAIT/awesome-macOS) A curated list of awesome applications, softwares, tools and shiny things for macOS.
* [jaywcjlove/awesome-mac](https://github.com/jaywcjlove/awesome-mac)a collection of awesome Mac applications and tools for developers and designers.
* [MAC全栈开发环境搭建指南](https://mac.aotu.io/index.html)
* [macdao/ocds-guide-to-setting-up-mac](https://github.com/macdao/ocds-guide-to-setting-up-mac):OCD's Guide to Setting up Mac
* [herrbischoff/awesome-macos-command-line](https://github.com/herrbischoff/awesome-macos-command-line):Use your macOS terminal shell to do awesome things.
* [Mac OS X 配置指南](https://wild-flame.github.io/guides/)
* [phodal/setup.guide](https://github.com/phodal/setup.guide)

## 启动项

* 配置目录
    - ~/Library/Preferences/ – （当前用户设置的进程）
    - ~/Library/LaunchAgents/ – （当前用户的守护进程）
    - /Library/LaunchAgents/ – （管理员设置的用户进程）
    - /Library/LaunchDaemons/ – （管理员提供的系统守护进程）
    - /System/Library/LaunchAgents/ – （Mac操作系统提供的用户进程）
    - /System/Library/LaunchDaemons/ – （Mac操作系统提供的系统守护进程）

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

# 查看服务名
launchctl list | grep anydesk
# 停止服务
launchctl stop com.philandro.anydesk
# 移除服务
launchctl unload com.philandro.anydesk

# 添加服务
launchctl load -w ~/Library/LaunchAgents/memcached.plist
```

### 命令行

* [guarinogabriel/Mac-CLI](https://github.com/guarinogabriel/Mac-CLI)  OS X command line tools for developers – The ultimate tool to manage your Mac. It provides a huge set of command line commands that automatize the usage of your OS X system.
* [0nn0/terminal-mac-cheatsheet](https://github.com/0nn0/terminal-mac-cheatsheet)List of my most used commands and shortcuts in the terminal for Mac
* [rgcr/m-cli](https://github.com/rgcr/m-cli): Swiss Army Knife for macOS

```sh
# mac专有的pbcopy/pbpaste 把命令行输出拷贝到系统粘贴板：
cat test.sh| pbcopy

# 把系统粘贴板内容拷到终端:
pbpaste

for i in `say -v '?' | cut -d ' ' -f 1`; do echo $i && say -v "$i" 'Hello World';done
```

### Spoitlight

* 查词典 Command+L
* 在浏览器查询 Command+B

## 共享目录

* smaba
    - windows下Run "\\192.168.0.4" 来访问其他机器共享的目录
    - Mac中， 先打开Finder, command +K  打开共享目录 输入： smb://192.168.0.4/share

## Stickies

* notes
    - 通过Web
    - Create a Progressive Web App (PWA) :More Tools-> Create Shortcut
    - More Tools, and then click Create Shortcut.
* 系统自带的便利贴

## 软件

* 安装
    - 可以通过plist文件安装软件
    - app store安装
    - 互联网下载：下载dmg，会打开安装包，需将app图标拖到application中（文件位置/Users/henry/Library/Application Support）
    - 文件包直接拖进application
    - `brew cask install firefox`
* 卸载
    - launchpad 长按
    - finder 找到移动到垃圾桶
    - 通过appcleaner彻底清除
* 系统
    - [airmail](http://airmailapp.com/):mail client
    - [Hazel](https://www.noodlesoft.com/):Automated Organization for Your Mac.
    - [Gemini](https://macpaw.com/gemini):The intelligent duplicate file finder
    - BTT(BetterTouchTool) 触控板手势增强
    - htop:运行于 Linux 系统监控与进程管理软件，用于取代 Unix 下传统的 top。与 top 只提供最消耗资源的进程列表不同，htop 提供所有进程的列表，并且使用彩色标识出处理器、swap 和内存状态
    - CleanMyMac（需购买解说功能）
    - [Little Snitch 4](https://www.obdev.at/products/littlesnitch/index.html):makes these Internet connections visible and puts you back in control!
    - [Dropzone](https://aptonic.com/):makes it faster and easier to move and copy files, launch applications, upload to many different services, and more.
    - [Time](https://timingapp.com/):automatically tracking how you spend your time.
    - [Fantastical 2](https://flexibits.com/fantastical):The calendar app 收费
    - [Hammerspoon](http://www.hammerspoon.org/): a desktop automation tool for OS X. It bridges various system level APIs into a Lua scripting engine
    - SwitchHosts
    - f.lux 屏幕颜色控制
    - manico
    - [dylanaraps/neofetch](https://github.com/dylanaraps/neofetch):🖼️ A command-line system information tool written in bash 3.2+
    - [MrRio/vtop](https://github.com/MrRio/vtop):Wow such top. So stats. More better than regular top. <http://parall.ax/vtop>
    - [GPG Suite](https://gpgtools.org/)
    - [dashlane](https://www.dashlane.com/zh):密码管理工具
    - [spectacl](https://www.spectacleapp.com/):Move and resize windows with ease
    - [wulkano/kap](https://github.com/wulkano/kap):An open-source screen recorder built with web technology <https://getkap.co>
    - [Unarchiver](link)
    - [LICEcap](link):gif录制
    - [sizeup](link) 窗口管理软件
        + control+option+command + M ： 使当前窗口全屏
        + control+option+command + 方向键上键 ： 使当前窗口占用当前屏幕上半部分
        + control+option+command + 方向键下键 ： 使当前窗口占用当前屏幕下半部分
        + control+option+command + 方向键左键 ： 使当前窗口占用当前屏幕左半部分
        + control+option+command + 方向键右键 ： 使当前窗口占用当前屏幕右半部分
        + control+option + 方向键左键 ： 将当前窗口发送到左边显示器屏幕
        + control+option + 方向键右键 ： 将当前窗口发送到右边显示器屏幕
    - [Spectacle](link):控制窗口
    - [chunkwm](https://koekeishiya.github.io/chunkwm/index.html):a tiling window manager for macOS
    - [onmyway133/FinderGo](https://github.com/onmyway133/FinderGo):🐢 Open terminal quickly from Finder
    - [sveinbjornt/Sloth](https://github.com/sveinbjornt/Sloth):Mac app that shows all open files and sockets in use by all running processes. Nice GUI for lsof. https://sveinbjorn.org/sloth
    - Luna Display:Turn your iPad into a second display
    - 实用工具：/System/Library/CoreServices/Applications
    - [QSpace](link)一个国产软件，MacOS 系统的多视图文件管理器，支持很多特色功能。让你摆脱多窗口来回切换的繁琐，和拖拽时找不准目标的尴尬
    - [Ityscal](https://www.mowglii.com/itsycal/)  日历
* vpn
    - Tunnelblick_3.7.2_build_4850：点击配置文件（xxx.tblk 或者 .conf）就可以加载陪配置
* 设计
    - UI:sketch sketch box
    - Axure：原型工具
    - CmapTools：概念图
    - UML:staruml
    - 截图
* 写作
    - Latex
    - Alternote(evernote简单客户端)
    - Quiver：笔记软件
    - [tusk](https://github.com/champloohq/tusk):自定义主题的evernote的app
    - [ulysses](https://ulyssesapp.com/)
    - [marked2](http://marked2app.com/)
    - [freemind](http://freemind.sourceforge.net/wiki/index.php/Download)
    - Upad
    - [Bear](https://bear.app/):Write beautifully on iPhone, iPad, and Mac
* 下载
    - bitlord
    - Folx
    - [CodeTips/BaiduNetdiskPlugin-macOS](https://github.com/CodeTips/BaiduNetdiskPlugin-macOS):For macOS.百度网盘 破解SVIP、下载速度限制~
* 工具
    - [CheatSheet] 长按⌘键可以显示当前程序快捷键
    - [flux](https://justgetflux.com/)
    - [moom](https://manytricks.com/moom/)
    - [sharkdp/fd](https://github.com/sharkdp/fd):A simple, fast and user-friendly alternative to find.
    - [Keyboard Maestro](https://www.waerfa.com/keyboard-maestro):essentially an IDE for automation
    - [transmissionbt](https://transmissionbt.com/):Transmission is a cross-platform BitTorrent client
    - [beaker](https://beakerbrowser.com/):Beaker is a peer-to-peer browser with tools to create and host websites.
    - [Helium](http://heliumfloats.com/):A floating browser window for OS X
    - Android file transfer
* Pod
    - [insidegui/PodcastMenu](https://github.com/insidegui/PodcastMenu):Put Overcast on your Mac's menu bar
* Web开发
    - [Paw](https://paw.cloud/):The most advanced API tool for Mac
    - MAMP:基础版不支持自定义
    - [yichengchen/clashX](https://github.com/yichengchen/clashX):A rule based custom proxy with GUI for Mac base on clash.
* 沟通
    - [Textual 7](<Textual is the world's most popular application for interacting with Internet Relay Chat (IRC) chatrooms on macOS.>)
    - [OmniGraffle](https://www.omnigroup.com/omnigraffle)
    - slack
    - [telegram](https://telegram.org/)
    - weibo:WeiboX
    - IM+
* RSS
    - [Reeder 3](http://reederapp.com/mac/)
    - feedly
    - leaf
* 管理
    - Keyboard Maestro:流程制作工具
    - OmniOutliner
    - OmniPlan
    - OmniFocus：GTD思路的应用
    - Fantastical：日程管理应用
    - sourcetree
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
* 文档
    - [dash](https://kapeli.com/dash):语言文档
    - [apidoc](http://apidocjs.com/)
    - [jgm/pandoc](https://github.com/jgm/pandoc):Universal markup converter <http://johnmacfarlane.net/pandoc>
    - [TRANSMIT 5](https://www.panic.com/transmit/):Upload, download, and manage files on tons of servers with an easy, familiar, and powerful UI. It’s quite good.
    - Cloud Outline
    - iCHM
* 音乐
    - 播放器：MPlayerX
    - [beardedspice/beardedspice](https://github.com/beardedspice/beardedspice):Mac Media Keys for the Masses <http://beardedspice.github.io>
    - [Noizio](http://noiz.io/):turn on the sound and allow yourself to become engulfed in the tranquil sounds of nature.
* 图片
    - 修图Snapseed
    - [Pixave](http://www.littlehj.com/mac/) - Image/GIF/Video organizer
* 录屏
    - [wulkano/kap](https://github.com/wulkano/kap):An open-source screen recorder built with web technology https://getkap.co
* 阅读
    - ibooks：阅读支持pdf与epub，可以通过icloud同步
    - iTunes Movie Trailers
    - mounty:win的移动硬盘
    - [irreader](http://irreader.fatecore.com)
    - [luin/medis](https://github.com/luin/medis)Medis is a beautiful, easy-to-use Mac database management application for Redis.
* 代码
    - Xcode
    - [SnippetsLab](https://www.renfei.org/snippets-lab/):SnippetsLab is an easy-to-use code snippets manager
    - [PHPstrom](https://www.jetbrains.com/phpstorm/download/download-thanks.html?pl)
    - atom:通过brew安装
    - [macvim-dev/macvim](https://github.com/macvim-dev/macvim)
    - [b4winckler/macvim](https://github.com/b4winckler/macvim)Vim - the text editor - for Mac OS X
* 虚拟机
    - Parallels Desktop
* 安全
    - WireGuard for macOS
* Screensaver
    - Apple TV Aerial
* 软件订阅
    - [setapp](https://setapp.com)The first subscription service for Mac apps.
* [LyricsX](https://github.com/MichaelRow/Lyrics)
* [fliqlo](https://fliqlo.com/):A flip Clock screensavers
* 说明
    - strace在linux下用来跟踪某个进程的系统调用，dtruss
* [JadenGeller/Helium](https://github.com/JadenGeller/Helium):A floating browser window for OS X <http://heliumfloats.com>
* elpass
* 迷你天气：macOS 天气应用，在 Dock 栏知实时天气

### screensavers

* 安装
    - /Library/Screen Savers/ 或者 ~/Library/Screen Savers/
* 资源
    - Fliqlo
    - [JohnCoates/Aerial](https://github.com/JohnCoates/Aerial):Apple TV Aerial Screensaver for Mac
        + 航拍横跨了中国、拉斯维加斯、旧金山、夏威夷、迪拜等等地方的白天和夜晚的精美景象。因为每一个航拍体积都很大
        + brew cask install aerial
        + 下载点击安装，重新进入系统偏好设置

### 苹果铃声制作

* 音乐文件用itunes打开
* getinfo剪辑（长度不变）
* 转换acc
* 在文件位置移开未见重命名.m4r
* 拖进tones
* 同步手机

## Route table

```
netstat -nr # 查看路由表
sudo route -n add -net 192.168.0.0 -netmask 255.255.255.0 192.168.5.254
route add -net 172.17.0.0 -netmask 255.255.255.0 dev eth0
route add [-net|-host] [网域或主机] netmask [mask] [gw|dev]
```

#### iTerm2

* iTerm2 的标签的颜色会变化，以指示该 tPab 当前的状态。当该标签有新输出的时候，标签会变成洋红色；新的输出长时间没有查看，标签会变成红色。可在设置中关掉该功能。
* 在 iTerm2 中，双击选中，三击选中整行，四击智能选中（智能规则可配置），可以识别网址，引号引起的字符串，邮箱地址等

## 快捷键

* ## 键位
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
* 隐藏dock：option + command + d
* 隐藏最前面的应用的窗口 Command-H
* 要查看最前面的应用但隐藏所有其他应用： option + command + h
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
* 按着Option键 -->如关机时免再确认一次
* Shift+Control+ 推出键:锁屏键
* command + l 进入地址栏

#### 系统功能

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
* Command–Mission Control 显示桌面。即使您未在 Finder 中，这个快捷键也有效。
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
* Command+Shift+G 可以前往任何文件夹,包括隐藏文件夹
* Command+Shift+. 显示或隐藏 隐藏文件
* 修改DNS提高Apple Store 网速:打开：systerm Preferences > Network > Advanced > DNS
    - 223.5.5.5 223.6.6.6 114.114.114.114 168.95.1.1 168.95.192.22 68.95.192.33

## Safari && [Chrome](https://www.google.com/chrome/browser/desktop/index.html#)

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

#### 文稿快捷键

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

#### 翻页

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

#### iPhone 控制keynote（同一个网路下）

* mac端偏好设置中remote开启并连接手机
* iphone keynote进入远程控制，开始控制
* AirPlay功能投影到Apple TV

## airdrop：苹果设备局域网共享链接，开启后，进行shares

## handoff:浏览器设备共享

## 触摸板

* 点按： 左键点击效果
* 双指点按： 右键点击效果
* 双指轻点两下： 智能缩放
* 双指滚动： 滚轮效果
* 双指张开或捏合： 缩放效果
* 双指左扫或右扫： 前进或后退
* 双指从右侧边缘向左轻扫： 通知中心
* 三指拖移：（系统偏好设置 -> 辅助功能 -> 鼠标和触控版 -> 触控版选项 -> 启用拖移）
* 四指左扫或右扫： 在全屏幕的应用之间轻扫
* 五指张开或捏合： 显示桌面

## [alfred](https://www.alfredapp.com/):a very powerful launcher that you can program to show you anything you want

* 购买 Powerpack. 快捷键：option + space
* [workflow](http://www.alfredworkflow.com/)
* [learn-anything / alfred-workflows](https://github.com/learn-anything/alfred-workflows):Amazing Alfred Workflows
* [gharlan / alfred-github-workflow](https://github.com/gharlan/alfred-github-workflow):GitHub Workflow for Alfred 3
* [hzlzh / AlfredWorkflow.com](https://github.com/hzlzh/AlfredWorkflow.com):A public Collection of Alfred Workflows. http://www.alfredworkflow.com/
* [zenorocha / alfred-workflows](https://github.com/zenorocha/alfred-workflows):🤘 A collection of Alfred 3 and 4 workflows that will rock your world

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

    Description            | Keys
    -----------------------| -----------------------
    Toggle Window Menu     | <kbd>Alt</kbd>
    Return to Notes        | <kbd>Esc</kbd>
    Delete Note            | <kbd>Delete</kbd>
    Toggle Dark Theme      | <kbd>Cmd/Ctrl</kbd> <kbd>D</kbd>
    Toggle Focus Mode      | <kbd>Cmd/Ctrl</kbd> <kbd>K</kbd>
    Exit Focus Mode        | <kbd>Cmd/Ctrl</kbd> <kbd>O</kbd>
    New Note               | <kbd>Cmd/Ctrl</kbd> <kbd>N</kbd>
    Add Shortcut           | <kbd>Cmd/Ctrl</kbd> <kbd>S</kbd>
    Set Reminder           | <kbd>Cmd/Ctrl</kbd> <kbd>E</kbd>
    Search Notes           | <kbd>Cmd/Ctrl</kbd> <kbd>F</kbd>
    Bold Text              | <kbd>Cmd/Ctrl</kbd> <kbd>B</kbd>
    Italic Text            | <kbd>Cmd/Ctrl</kbd> <kbd>I</kbd>
    Underline Text         | <kbd>Cmd/Ctrl</kbd> <kbd>U</kbd>
    Strikethrough Text     | <kbd>Cmd/Ctrl</kbd> <kbd>T</kbd>
    Increase Indentation   | <kbd>Cmd/Ctrl</kbd> <kbd>M</kbd>
    Toggle Settings        | <kbd>Cmd/Ctrl</kbd> <kbd>,</kbd>
    Make Text Smaller      | <kbd>Cmd/Ctrl</kbd> <kbd>-</kbd>
    Reset Zoom Level       | <kbd>Cmd/Ctrl</kbd> <kbd>0</kbd>
    Toggle Black Theme     | <kbd>Cmd/Ctrl</kbd> <kbd>Alt</kbd> <kbd>E</kbd>
    Toggle Tags            | <kbd>Cmd/Ctrl</kbd> <kbd>Alt</kbd> <kbd>T</kbd>
    Toggle Notebooks       | <kbd>Cmd/Ctrl</kbd> <kbd>Alt</kbd> <kbd>N</kbd>
    Align Left             | <kbd>Cmd/Ctrl</kbd> <kbd>Alt</kbd> <kbd>L</kbd>
    Align Center           | <kbd>Cmd/Ctrl</kbd> <kbd>Alt</kbd> <kbd>M</kbd>
    Align Right            | <kbd>Cmd/Ctrl</kbd> <kbd>Alt</kbd> <kbd>R</kbd>
    Make Text Larger       | <kbd>Cmd/Ctrl</kbd> <kbd>Shift</kbd> <kbd>=</kbd>
    New Tag                | <kbd>Cmd/Ctrl</kbd> <kbd>Shift</kbd> <kbd>T</kbd>
    New Notebook           | <kbd>Cmd/Ctrl</kbd> <kbd>Shift</kbd> <kbd>N</kbd>
    Toggle Checkbox        | <kbd>Cmd/Ctrl</kbd> <kbd>Shift</kbd> <kbd>C</kbd>
    Code Block             | <kbd>Cmd/Ctrl</kbd> <kbd>Shift</kbd> <kbd>L</kbd>
    Add Link               | <kbd>Cmd/Ctrl</kbd> <kbd>Shift</kbd> <kbd>K</kbd>
    Attach File            | <kbd>Cmd/Ctrl</kbd> <kbd>Shift</kbd> <kbd>F</kbd>
    Insert from Drive      | <kbd>Cmd/Ctrl</kbd> <kbd>Shift</kbd> <kbd>D</kbd>
    Decrease Indentation   | <kbd>Cmd/Ctrl</kbd> <kbd>Shift</kbd> <kbd>M</kbd>
    Numbered List          | <kbd>Cmd/Ctrl</kbd> <kbd>Shift</kbd> <kbd>O</kbd>
    Toggle Shortcuts       | <kbd>Cmd/Ctrl</kbd> <kbd>Shift</kbd> <kbd>S</kbd>
    Bulleted List          | <kbd>Cmd/Ctrl</kbd> <kbd>Shift</kbd> <kbd>.</kbd>
    Submscript Text         | <kbd>Cmd/Ctrl</kbd> <kbd>Shift</kbd> <kbd>]</kbd>
    Superscript Text       | <kbd>Cmd/Ctrl</kbd> <kbd>Shift</kbd> <kbd>[</kbd>
    Insert Horizontal Rule | <kbd>Cmd/Ctrl</kbd> <kbd>Shift</kbd> <kbd>-</kbd>

### XtraFinder 文件管理器，涉及权限，暂停使用

## Xcode

```sh
xcode-select --install # 安装 Command Line Tools
```

## 自启动的配置

* System -> Accounts，选择Login Items
* ~/Library/LaunchAgents 由用户自己定义的任务项
* /Library/LaunchAgents 由管理员为用户定义的任务项
* /Library/LaunchDaemons 由管理员定义的守护进程任务项
* /System/Library/LaunchAgents 由Mac OS X为用户定义的任务项
* /System/Library/LaunchDaemons 由Mac OS X定义的守护进程任务项
* /System/Library/StartupItems: 系统相关的StartupItems
* /Library/StartupItems

```
sudo launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist
sudo launchctl load -w /System/Library/LaunchDaemons/org.apache.httpd.plist

export PATH=/opt/local/bin:/opt/local/sbin:$PATH

# 检查plist语法
plutil ~/Library/LaunchAgents/example.plist
# 载入配置, 使配置生效
launchctl load ~/Library/LaunchAgents/example.plist
# 卸载配置
launchctl unload ~/Library/LaunchAgents/example.plist
# 查看服务运行状态
launchctl list
```

### 网络连接

在局域网mac通过内网地址链接ubuntu，远程ssh登陆mac需要mac开启允许远程登陆

```shell
lsof -i tcp:8081  # 端口查看
```

## 远程登录

开启设置-〉共享-〉远程登录

## [lra/mackup](https://github.com/lra/mackup)

Keep your application settings in sync (OS X/Linux)系统配置备份

linux下（mac下）有各种app，每个人会根据个人的喜好和习惯来设置一些（快捷键，变量等等），而dotfiles就是保存了这些自定义设置的文件。在系统中使用一个文件夹，通过ln命令，将不同的app，不同的系统设置文件都指引到这个文件夹

```
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
karabiner
```

## 端口查看

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
```

## 问题

```
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

## 工具

* [basecamp/pow](https://github.com/basecamp/pow):Zero-configuration Rack server for Mac OS X http://pow.cx/v
* macOS Server拥有众多强大工具可以让整个团队更高效地分享信息，分工合理第一合作

## 参考

* [黑果小兵的部落阁](https://blog.daliansky.ne)
* [hzlzh/Best-App](https://github.com/hzlzh/Best-App):收集&推荐优秀的 Apps/硬件/技巧/周边等
