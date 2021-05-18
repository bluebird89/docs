# 技巧

## 修改键位映射

* 当某一个按键被按下，软件截获键盘发出的按键事件（keypress event）并使用另外一个事件取代
  - 将 Caps Lock 映射为 Ctrl 或者 Escape：Caps Lock 使用了键盘上一个非常方便的位置而它的功能却很少被用到，所以我们（讲师）非常推荐这个修改；
  - 将 PrtSc 映射为播放/暂停：大部分操作系统支持播放/暂停键；
  - 交换 Ctrl 和 Meta 键（Windows 的徽标键或者 Mac 的 Command 键）
* 将键位映射为任意常用的指令。软件监听到特定的按键组合后会运行设定的脚本
  - 打开一个新的终端或者浏览器窗口；
  - 输出特定的字符串，比如：一个超长邮件地址或者 MIT ID；
  - 使计算机或者显示器进入睡眠模式。
* 软件
    + macOS - [karabiner-elements](https://pqrs.org/osx/karabiner/), skhd 或者 BetterTouchTool
  - Linux - xmodmap 或者 Autokey
  - Windows - 控制面板，[AutoHotkey](https://www.autohotkey.com/) 或者 SharpKeys
  - QMK - 如果你的键盘支持定制固件，QMK 可以直接在键盘的硬件上修改键位映射。保留在键盘里的映射免除了在别的机器上的重复配置。

## 守护进程（daemon）

* 以守护进程运行的程序名一般以 d 结尾
* SSH 服务端 sshd，用来监听传入的 SSH 连接请求并对用户进行鉴权
* Linux 中的 systemd（the system daemon）是最常用的配置和运行守护进程的方法
  - systemctl status 命令可以看到正在运行的所有守护进程
  - 用户使用 systemctl 命令和 systemd 交互来enable（启用）、disable（禁用）、start（启动）、stop（停止）、restart（重启）、或者status（检查）配置好的守护进程及系统服务
* systemd 提供了一个很方便的界面用于配置和启用新的守护进程或系统服务。下面的配置文件使用了守护进程来运行一个简单的 Python 程序。文件的内容非常直接所以我们不对它详细阐述。[systemd 配置文件的详细指南](https://www.freedesktop.org/software/systemd/man/systemd.service.html)

```
# /etc/systemd/system/myapp.service
[Unit]
# 配置文件描述
Description=My Custom App
# 在网络服务启动后启动该进程
After=network.target

[Service]
# 运行该进程的用户
User=foo
# 运行该进程的用户组
Group=foo
# 运行该进程的根目录
WorkingDirectory=/home/foo/projects/mydaemon
# 开始该进程的命令
ExecStart=/usr/bin/local/python3.7 app.py
# 在出现错误时重启该进程
Restart=on-failure

[Install]
# 相当于Windows的开机启动。即使GUI没有启动，该进程也会加载并运行
WantedBy=multi-user.target
# 如果该进程仅需要在GUI活动时运行，这里应写作：
# WantedBy=graphical.target
# graphical.target在multi-user.target的基础上运行和GUI相关的服务
```

## FUSE（用户空间文件系统）

* UNIX 文件系统在传统上是以内核模块的形式实现，导致只有内核可以进行文件系统相关的调用
* 允许运行在用户空间上的程序实现文件系统调用，并将这些调用与内核接口联系起来。在实践中，这意味着用户可以在文件系统调用中实现任意功能。
* 可以用于实现如：一个将所有文件系统操作都使用 SSH 转发到远程主机，由远程主机处理后返回结果到本地计算机的虚拟文件系统。这个文件系统里的文件虽然存储在远程主机，对于本地计算机上的软件而言和存储在本地别无二致。sshfs就是一个实现了这种功能的 FUSE 文件系统。
* [sshfs](https://github.com/libfuse/sshfs)：使用 SSH 连接在本地打开远程主机上的文件
* [rclone](https://rclone.org/commands/rclone_mount/)：将 Dropbox、Google Drive、Amazon S3、或者 Google Cloud Storage 一类的云存储服务挂载为本地文件系统
* gocryptfs：覆盖在加密文件上的文件系统。文件以加密形式保存在磁盘里，但该文件系统挂载后用户可以直接从挂载点访问文件的明文
* kbfs：分布式端到端加密文件系统。在这个文件系统里有私密（private），共享（shared），以及公开（public）三种类型的文件夹
* borgbackup：方便用户浏览删除重复数据后的压缩加密备份

## 备份

* 误区
  - 复制存储在同一个磁盘上的数据不是备份，因为这个磁盘是一个单点故障（single point of failure）
  - 同步方案也不是备份。即使方便如 Dropbox 或者 Google Drive，当数据在本地被抹除或者损坏，同步方案可能会把这些“更改”同步到云端。同理，像 RAID 这样的磁盘镜像方案也不是备份。它不能防止文件被意外删除、损坏、或者被勒索软件加密。
  - 不要盲目信任备份方案。用户应该经常检查备份是否可以用来恢复数据
* 有效备份方案核心特性
  - 版本控制：保证了用户可以从任何记录过的历史版本中恢复数据
  - 删除重复数据：使其仅备份增量变化可以减少存储开销
  - 安全性：作为用户，应该考虑别人需要有什么信息或者工具才可以访问或者完全删除你的数据及备份

## API（应用程序接口）

* 大多数线上服务提供的 API（应用程序接口）可以通过编程方式来访问这些服务的数
* 用户可以访问不同的子路径来访问需要调用的操作，以及添加查询参数使 API 返回符合查询参数条件的结果
* 有些需要认证的 API 通常要求用户在请求中加入某种私密令牌（secret token）来完成认证
  - [OAuth](https://www.oauth.com/)通过向用户提供一系列仅可用于该 API 特定功能的私密令牌进行校验。因为使用了有效 OAuth 令牌的请求在 API 看来就是用户本人发出的请求，所以请一定保管好这些私密令牌。否则其他人就可以冒用你的身份进行任何你可以在这个 API 上进行的操作。
  - [IFTTT If This Then That](https://ifttt.com/) 将很多 API 整合在一起，让某 API 发生的特定事件触发在其他 API 上执行的任务。

## 常见命令行标志参数及模式

* 大部分工具支持 --help 或者类似的标志参数（flag）来显示它们的简略用法
* 会造成不可撤回操作的工具一般会提供“空运行”（dry run）标志参数，这样用户可以确认工具真实运行时会进行的操作。这些工具通常也会有“交互式”（interactive）标志参数，在执行每个不可撤回的操作前提示用户确认
* --version 或者 -V 标志参数可以让工具显示它的版本信息
* 基本所有的工具支持使用 --verbose 或者 -v 标志参数来输出详细的运行信息。多次使用这个标志参数，比如 -vvv，可以让工具输出更详细的信息（经常用于调试）。同样，很多工具支持 --quiet 标志参数来抑制除错误提示之外的其他输出
* 使用 - 代替输入或者输出文件名意味着工具将从标准输入（standard input）获取所需内容，或者向标准输出（standard output）输出结果
* 会造成破坏性结果的工具一般默认进行非递归的操作，但是支持使用“递归”（recursive）标志函数（通常是 -r）
* 可能需要向工具传入一个 看上去 像标志参数的普通参数，可以使用特殊参数 -- 让某个程序 停止处理 -- 后面出现的标志参数以及选项，比如：
  - 使用 rm 删除一个叫 -r 的文件； rm -- -r 会让 rm 将 -r 当作文件名
  - 在通过一个程序运行另一个程序的时候（ssh machine foo），向内层的程序（foo）传递一个标志参数。 ssh machine --for-ssh -- foo --for-foo 的 -- 会让 ssh 知道 --for-foo 不是 ssh 的标志参数。

## 窗口管理器

* 堆叠式（floating/stacking）管理器：窗口一般就堆在屏幕上，可以拖拽改变窗口的位置、缩放窗口、以及让窗口堆叠在一起
* 平铺式（tiling）管理器：把不同的窗口像贴瓷砖一样平铺在一起而不和其他窗口重叠

## 习惯

* 多去使用键盘，少使用鼠标。这一目标可以通过多加利用快捷键，更换界面等来实现。
* 学好编辑器。作为程序员大部分时间都是在编辑文件，因此值得学好这些技能。
* 学习怎样去自动化或简化工作流程中的重复任务。因为这会节省大量的时间。
* 学习像 Git 之类的版本控制工具并且知道如何与 GitHub 结合，以便在现代的软件项目中协同工作。
