# Windows

Windows是最烂的开发平台

## 工具

* [Chocolatey](https://github.com/chocolatey/choco):The package manager for Windows Software Management Automation https://chocolatey.org/
* [Scoop](https://scoop.sh)
* 快速启动
  - launchy
  - [Wox-launcher/Wox](https://github.com/Wox-launcher/Wox):Launcher for Windows, an alternative to Alfred and Launchy. http://wox.one
  - Rolan 轻量级桌面启动器
* 资源管理器: Clover Total Commander
* 快捷键：AutoHotKey
* 本地搜索
  - [Listary](https://www.listary.com/) :Windows 文件浏览增强工具 极速的文件和APP搜索工具，可大幅度提高打开文件和app的速度
  - Everything
* Notepad++
* 工具：ShareX
* 同步工具：goodsync
* 词典：GoldenDict
* 虚拟机
    - VirtualBox
* VistaSwitcher：程序切换工具
* StrokeIt:让鼠标手势无处不在
* f.lux 随时间改变屏幕色温
* 全局鼠标手势：WGestures
* 字体渲染增强：MacType
* 任务栏透明化：TranslucentTB
* RSS:深蓝阅读 theoldreader
* Sumatra PDF PDF阅读
* Foxit Reader
* editor：Visual Studio Code
* 电子书管理神器：Calibre
* CCleaner, Defraggler, Recuva & Speccy.
* Evernote
* Foxmail
* RTX
* TIM
* Youdao
* Firefox 浏览器
    - AdBlock Plus Firefox扩展
* Opera 浏览器
* Google Chrome 浏览器
* VLC 媒体播放
* 7-Zip 文件压缩
* OpenOffice.org 办公
* μTorrent BT下载
* GIMP 图像编辑 介绍文章
* FileZilla FTP软件
* Defraggler 系统优化-碎片整理
* Winamp 媒体播放
* Eclipse IDE 开发环境
* PuTTY Telnet远程连接
* Rainmeter 桌面增强
* AutoHotkey 脚本工具
* MediaMonkey 媒体管理
* Quicksilver Mac下的程序快速启动工具
* WinSCP FTP客户羰
* Boxee 媒体中心
* Media Player Classic 媒体播放

```sh
## 安装 choco 以管理员运行cmd
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

choco search python php birtualbox jdk8 cclear

choco install mysql.workbench

cinst Atom
```

## 安装

* 先分区格式化，主分区激活
    - 主分区
    - 逻辑分区
* 更新引导记录

## 配置

* 添加自启动 文件位置：`C:\Users\henryli\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup`
  - get location cmd: shell:startup  
  - add shortcuts into folder
  - Sticky Notes
* 默认图片 Windows Photo Viewer 恢复
* 睡眠(Sleep):把当前操作系统的状态保存在内存中，除内存电源外，切断笔记本所有其他电源 启动时，从内存读取上次保存的系统状态，直接恢复使用。
* 休眠(Hibernate):把当前操作系统的状态保存到硬盘中，然后切断笔记本所有电源。启动时，从硬盘读取上次保存的系统状态，直接恢复使用。

```
# Windows Photo Viewer 恢复 cmd 打开命令提示符，输入以下内容
FTYPE Paint.Picture=%SystemRoot%\System32\rundll32.exe "%ProgramFiles%\Windows Photo Viewer\PhotoViewer.dll", ImageView_Fullscreen %1
FTYPE jpegfile=%SystemRoot%\System32\rundll32.exe "%ProgramFiles%\Windows Photo Viewer\PhotoViewer.dll", ImageView_Fullscreen %1
FTYPE pngfile=%SystemRoot%\System32\rundll32.exe "%ProgramFiles%\Windows Photo Viewer\PhotoViewer.dll", ImageView_Fullscreen %1
```

## 快捷键

* alt+tab：长按为显示任务列表，短切为与上次任务切换
* WIN+D：窗口最小化，显示桌面，再按一次还原桌面
* WIN+R：打开运行，输入命令可以执行相应操作，输入路径可以打开对应路径，输入程序名称可以打开对应程序（前提是你打开的是windows下面的程序）;输入cmd打- 开DOS窗口，输入notepad打开记事本，输入calc打开计算器等
* WIN+E：打开我的电脑
* CTRL+ALT+Delete Ctrl + Shift + Esc ：程序不响应时用这一招结束不响应的程序，xp下用得比较多
* WIN+L：锁屏
* WIN+Tab/ALT+SHIFT+TAB：切换程序
* CTRL+W：关闭程序标签页
* CTRL+Home：跳转到文件最开头，直接按Home跳转到行头
* CTRL+End：跳转到文件尾部，直接按End跳转到行尾
* ALT+双击：查看文件属性
* WIN+数字键：启动任务栏上的程序
* ctrl + z/y:
* 在桌面或者任何文件夹下，SHIFT+鼠标右键，可以在当前路径下打开DOS命令窗口
* 在桌面或者任何文件夹下，CTRL+鼠标左键，拖动文件、文件夹都可以立马生成文件对应的副本
* 新建只有扩展名的文件的方法：".suffix."，·比如创建.gitignore，正常情况下windows是不允许创建的，但在扩展名后面加点，即.gitignore.就可以正常创建了
* CTRL+SHIFT+ESC/Ctrl+Alt+Del：打开进程管理器
* WIN+左箭头：当前窗口缩放为屏幕的一半，靠屏幕左侧显示
* WIN+右箭头：当前窗口缩放为屏幕的一半，靠屏幕右侧显示
* WIN+上箭头：最大化当前窗口
* WIN+下箭头：还原和最小化当前窗口
* Win+Shift+左箭头：移动到左边屏幕
* Win+Shift+右箭头：移动到右边屏幕
* 在桌面上，右键任何一个程序，鼠标定位到快捷键一栏，为该应用设置启动快捷键，然后你就可以通过这个这个快捷键来启动该程序啦
* alt + f4:关闭程序
* shift + del：彻底删除文件
* alt + d：定位到地址栏
* f11：窗口最大化的来回切换
* alt + ←/→：切换上下级文件
* ctrl+shift+n：新建文件夹
* WIN+Home：最小化所有窗口，除了当前激活窗口
* WIN+M：最小化所有窗口
* WIN+SHIFT+M：还原最小化窗口到桌面上
* WIN+P：选择一个演示文稿显示模式
* WIN+Pause：显示系统属性对话框
* WIN+F：打开windows帮助中心
* WIN+T/alt+ESC：切换任务栏上的程序
* WIN+ALT+数字：让位于任务栏指定位置（按下的数字作为序号）的程序，显示跳转清单
* Win + Home：最小化所有窗口，除了当前激活窗口
* win + p:投影
* 命令行：WIN+R
  - 输入"msconfig"，弹出系统设置界面，可设置禁止、允许进程开机自启动
  - 输入"psr"后回车：打开步骤记录器
  - 输入"mip"，启动数学公式手写板
  - cmd进入命令行
* 快捷方式可以设置快捷键
* Shift+Tab（返回上一个选项或上一栏）
* Ctrl+Shift+Tab（切换至上一个标签）
* CTRL+鼠标左键，拖动文件、文件夹都可以立马生成文件对应的副本
* Win+T to cycle through the taskbar icons
* Win + d：删除文件

```sh
ipconfig /flushdns # 刷新域名
```

## 服务管理

* 获取服务名称
  - 在服务列表中，找到服务项
  - 点击找到服务名称
* 删除服务项:`sc delete jenkins`

### [cmder + gow](http://bliker.github.io/cmder/)

* 添加到环境变量
* 快捷键
  - 双Tab，用于补全
  - Ctrl+T，建立新页
  - Ctrl+W，关闭标签页
  - Ctrl+Tab，切换标签页
  - Alt+F4，关闭所有标签页
  - Ctrl+1，切换到第一个页签，Ctrl+2同理
  - Alt + enter，切换到全屏状态

```
Environment里添加set LANG=zh_CN.UTF-8

# 修改配置文件 vendor/init.bat
@prompt $E[1;32;40m$P$S{git}{hg}$S$_$E[1;30;40m{lamb}$S$E[0m # 修改前
@prompt $E[1;32;40m$P$S{git}{hg}$S$_$E[1;30;40m $$ $S$E[0m #修改后

local cmder_prompt = "\x1b[1;32;40m{cwd} {git}{hg} \n\x1b[1;30;40m{lamb} \x1b[0m" #before changes
local cmder_prompt = "\x1b[1;32;40m{cwd} {git}{hg} \n\x1b[1;30;40m# \x1b[0m" #after changes

# 配置aliases：cmder->config->aliases
l=ls --show-control-chars
la=ls -aF --show-control-chars
ll=ls -alF --show-control-chars
ls=ls --show-control-chars -F
```

## xp

> cannt load library mscoree.dll

* 安装 dotNetFx40_Full_x86_x64

### MarkdownPad

```
Soar360@live.com

GBPduHjWfJU1mZqcPM3BikjYKF6xKhlKIys3i1MU2eJHqWGImDHzWdD6xhMNLGVpbP2M5SN6bnxn2kSE8qHqNY5QaaRxmO3YSMHxlv2EYpjdwLcPwfeTG7kUdnhKE0vVy4RidP6Y2wZ0q74f47fzsZo45JE2hfQBFi2O9Jldjp1mW8HUpTtLA2a5/sQytXJUQl/QKO0jUQY4pa5CCx20sV1ClOTZtAGngSOJtIOFXK599sBr5aIEFyH0K7H4BoNMiiDMnxt1rD8Vb/ikJdhGMMQr0R4B+L3nWU97eaVPTRKfWGDE8/eAgKzpGwrQQoDh+nzX1xoVQ8NAuH+s4UcSeQ==
```

## [Zeal](https://zealdocs.org/)

Zeal is an offline documentation browser for software developers.linux and windows

```
# download
# by choco
choco install zeal

sudo apt-get install zeal
```

## WSL(Windows Subsystem for Linux)

* 支持bash：在启用或关闭 Windows 功能，开启Windows Subsystem for linux (Beta) [参考](https://blog.jessfraz.com/post/windows-for-linux-nerds/)

```
# PowerShell as Administrator
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
restart system
cmd + r input:bash download ubuntu
```

## 系统

* [felixrieseberg/windows95](https://github.com/felixrieseberg/windows95):💩🚀 Windows 95 in Electron. Runs on macOS, Linux, and Windows.
* [Awesome-Windows/Awesome](https://github.com/Awesome-Windows/Awesome):An awesome & curated list of best applications and tools for Windows.
* [Windows10 LTSB](https://msdn.itellyou.cn)
* [Microsoft/MS-DOS](https://github.com/Microsoft/MS-DOS):The original sources of MS-DOS 1.25 and 2.0, for reference purposes

## 开发

* Windows Presentation Foundation（WPF）
* Windows Forms
* Windows UI XAML Library（WinUI）

## resource

* [xiazaiba](https://www.xiazaiba.com/)
* [AlternativeTo](https://alternativeto.net/):Crowdsourced software recommendations
* [Slant](https://www.slant.co/):Trustworthy product rankings for all your shopping needs
* [itellyou](https://msdn.itellyou.cn)
* UI
  - [duilib/duilib](https://github.com/duilib/duilib):Duilib是一个Windows下免费开源的DirectUI界面库
