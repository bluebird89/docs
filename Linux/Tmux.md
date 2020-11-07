# Tmux

* 终端复用软件,通过一个终端登录远程主机并运行tmux后，在其中可以开启多个控制台而无需再“浪费”多余的终端来连接这台远程主机
* 一个终端复用器,是一个可以将多个终端连接到单个终端会话的工具。可以在一个终端中进行程序之间的切换，添加分屏窗格
* 将多个终端连接到同一个会话，使它们保持同步
* 在远程服务器上工作时，可以创建新的选项卡，然后在选项卡之间切换
* 基于session概念的多终端窗口管理功能:用户随时可以通过命令行恢复上次的会话

## 安装

```sh
sudo apt-get install tmux
sudo yum install tmux
brew install tmux

tmux # into 底部有一个状态栏。状态栏的左侧是窗口信息（编号和名称），右侧是系统信息
```

## 配置

* [.tmux](https://github.com/gpakosz/.tmux)  🇫🇷 Oh My Tmux! Pretty & versatile tmux configuration made with ❤️

```sh
touch ~/.tmux.conf # 新建用户配置文件

set -g mode-mouse on # 开启鼠标模式
set -g mouse-select-pane on # 允许鼠标选择窗格
set-option -g allow-rename off # 如果喜欢给窗口自定义命名，那么需要关闭窗口的自动命名
set-window-option -g mode-keys vi  # 如果对 vim 比较熟悉，可以将 copy mode 的快捷键换成 vi 模式
tmux kill-server

tmux source ~/.tmux.conf
```

## 使用

* 通过`tmux`进入界面，在开启了tmux服务器后， 新建一个 tmux 的会话（session），而这个会话则会首先创建一个窗口，其中仅包含一个面板.退出exit
* session->windows->panel
	- 命令行典型使用方式:打开一个终端窗口（terminal window，以下简称"窗口"），在里面输入命令。用户与计算机的这种临时的交互，称为一次"会话"（session）
		+ 开启一个默认的Window（也即窗口）。Tmux中可以拥有多个会话，多个会话之间可以来回无缝切换
    	+ 窗口与其中启动的进程是连在一起的。打开窗口，会话开始；关闭窗口，会话结束
    	+ 会话与窗口可以"解绑"：窗口关闭时，会话并不终止，而是继续运行，等到以后需要的时候，再让会话"绑定"其他窗口
	- 终端复用器（terminal multiplexer）在需要经常登录远程服务器工作的时候会很有用，可以保持远程登录的会话，还可以在一个窗口中查看多个 shell 的状态 替代screen、nohup
    	+ 允许在单个窗口中，同时访问多个会话。这对于同时运行多个命令行程序很有用
    	+ 可以让新窗口"接入"已经存在的会话
    	+ 允许每个会话有多个连接窗口，因此可以多人实时共享会话
    	+ 支持窗口任意的垂直和水平拆分
    	+ 在服务端运行Tmux，方便保存窗口和各种会话
    	+ 在本地终端运行，方便日常程序开发
    - panel是比Window更小的界面元素。Tmux中可以对window进行任意分割，由window分割出来的单位就叫做panel了
* 状态
	- [0] 是 tmux 服务器创建的第一个会话。编号从 0 开始。tmux 服务器会跟踪所有的会话确认其是否存活。
	- 0:testuser@scarlett:~ – 有关该会话的第一个窗口的信息。编号从 0 开始。这表示窗口的活动窗格中的终端归主机名 scarlett 中 testuser 用户所有。当前目录是 ~ (家目录)
	- – 显示目前在此窗口中
	- “scarlett.internal.fri” – 正在使用的 tmux 服务器的主机名
	- session-name:windowid
* [插件](https://github.com/tmux-plugins)
	- <prefix> I 安装插件，并更新Tmux
	- <prefix> U 更新所有已安装插件
	- <prefix> Alt U 移除所有插件列表中不存在的插件
	- Resurrect 一个非常好用的保存当前Tmux窗口和Panel布局的插件
	- urlview 在终端界面中自动搜寻所有的URL链接地址，合并为一个可以选择的列表
* 快捷键都要通过前缀键唤起。默认的前缀键 <prefix> 是Ctrl+b Ctrl+b(⌃b):激活控制台,所有快捷键都基于此前置快捷键
    - 列出所有快捷键 tmux list-keys
    - 列出所有命令及其参数:tmux list-commands
    - 列出当前所有会话的信息 tmux info
    - 重新加载配置 tmux source-file ~/.tmux.conf
* 系统操作
	- ?：列出所有快捷键；按q返回
	- d：脱离当前会话；这样可以暂时返回Shell界面，输入tmux attach能够重新进入之前的会话
	- D:选择要脱离的会话；在同时开启了多个会话时使用
	- Ctrl+z:挂起当前会话
	- r:强制重绘未脱离的会话
	- s:选择并切换会话；在同时开启了多个会话时使用
	- ::进入命令行模式；此时可以输入支持的命令，例如kill-server可以关闭服务器
	- [:进入复制模式；此时的操作与vi/emacs相同，按q/Esc退出
	- ~:列出提示信息缓存；其中包含了之前tmux返回的各种提示信息
* 会话操作
	- 查看 tmux ls|s：列出所有会话
    - 新建 tmux new -s <session-name>|:new
    - 分离: tmux detach|d 退出 tmux 进程，返回至 shell 主进程
    - 接入 tmux attach -t <session-name>
    - 杀死 tmux kill-session -t <session-name>
    - 切换 tmux switch -t <session-name>
    - 重命名 tmux rename-session -t 0 <new-name>|$
* 窗口操作:第一个启动的 Tmux 窗口，编号是0，第二个窗口的编号是1，以此类推
	- 显示窗口列表及选择 w: sesiionid:windownumcount|status
	- 新建窗口 `tmux new-window -n <window-name>`|c
	- 关闭当前窗口 &
	- rename window:,
	- 修改当前窗口编号(只能变为没有使用的编号):.
    - <number>：切换到指定编号的窗口，其中的<number>是状态栏上的窗口编号
	- 在前后两个窗口间互相切换:l
	- n:后一个串口
	- p:前一个窗口
	- u 新建窗口并切换到新窗口
	- f:查找窗口
	- t:显示时钟
	- 划分窗格 tmux split-window|tmux split-window -h
    - 移动光标 tmux select-pane -U|D|L|R
    - 交换窗格 tmux swap-pane -U|D
    - 切换 tmux select-window -t <window-number>|<window-name>
    - 重命名窗口  tmux rename-window <new-name>|q
* panel 操作
	- ”|-:将当前面板平分为上下两块
	- %||:将当前面板平分为左右两块
	- h|← 选择左边窗格
	- j|↓ 选择下面窗格
	- k|↑ 选择上面窗格
	- l|→ 选择右边窗格
    - o：交换窗格
    - Ctrl+o：当前窗格上移
	- x:关闭当前面板
	- {:向前置换当前面板
	- }:向后置换当前面板
	- ; 选择上次使用的窗格
    - !：将当前窗格拆分为一个独立窗口
	- Space:在预置的面板布局中循环切换；依次包括even-horizontal、even-vertical、main-horizontal、main-vertical、tiled
	- q:显示所有窗格的序号，在序号出现期间按下对应的数字，即可跳转至对应的窗格
	- z 最大化当前窗格，再次执行可恢复原来大小
	- H|Ctrl+← 以1个单元格为单位移动边缘以调整当前面板大小 左
	- J|Ctrl+↓ 以1个单元格为单位移动边缘以调整当前面板大小 下
	- K|Ctrl+↑ 以1个单元格为单位移动边缘以调整当前面板大小 上
	- L|Ctrl+→ 以1个单元格为单位移动边缘以调整当前面板大小 右

```sh
tmux new -s foo # 新建名称为 foo 的会话
tmux ls # 列出所有 tmux 会话
tmux a # 恢复至上一次的会话
tmux a -t foo # 恢复名称为 foo 的会话，会话默认名称为数字
tmux kill-session -t foo # 删除名称为 foo 的会话
tmux kill-server # 删除所有的会话
```
