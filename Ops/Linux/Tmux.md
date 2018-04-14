# Tmux

终端复用软件,通过一个终端登录远程主机并运行tmux后，在其中可以开启多个控制台而无需再“浪费”多余的终端来连接这台远程主机

## 安装

```sh
sudo apt-get install tmux
yum install -y tmux
brew install tmux
```

## 配置

```
touch ~/.tmux.conf # 新建用户配置文件

set -g mode-mouse on # 开启鼠标模式
set -g mouse-select-pane on # 允许鼠标选择窗格
set-option -g allow-rename off # 如果喜欢给窗口自定义命名，那么需要关闭窗口的自动命名
set-window-option -g mode-keys vi  # 如果对 vim 比较熟悉，可以将 copy mode 的快捷键换成 vi 模式
tmux kill-server
```

## 使用

通过`tmux`进入界面，在开启了tmux服务器后， 新建一个 tmux 的会话（session），而这个会话则会首先创建一个窗口，其中仅包含一个面板.退出exit

* [0] – 这是 tmux 服务器创建的第一个会话。编号从 0 开始。tmux 服务器会跟踪所有的会话确认其是否存活。
* 0:testuser@scarlett:~ – 有关该会话的第一个窗口的信息。编号从 0 开始。这表示窗口的活动窗格中的终端归主机名 scarlett 中 testuser 用户所有。当前目录是 ~ (家目录)。
* – 显示你目前在此窗口中。
* “scarlett.internal.fri” – 你正在使用的 tmux 服务器的主机名。

Ctrl+b(⌃b):激活控制台,所有快捷键都基于此前置快捷键

> 系统操作

* ?：列出所有快捷键；按q返回
* d：脱离当前会话；这样可以暂时返回Shell界面，输入tmux attach能够重新进入之前的会话
* D:选择要脱离的会话；在同时开启了多个会话时使用
* Ctrl+z:挂起当前会话
* r:强制重绘未脱离的会话
* s:选择并切换会话；在同时开启了多个会话时使用
* ::进入命令行模式；此时可以输入支持的命令，例如kill-server可以关闭服务器
* [:进入复制模式；此时的操作与vi/emacs相同，按q/Esc退出
* ~:列出提示信息缓存；其中包含了之前tmux返回的各种提示信息

> 窗口操作

* c：创建新窗口
* &：关闭当前窗口
* 数字键：切换至指定窗口
* p：切换至上一窗口
* n：切换至下一窗口
* l:在前后两个窗口间互相切换
* w:通过窗口列表切换窗口,下使用 ⌃p 和 ⌃n 进行上下选择
* ,:重命名当前窗口；这样便于识别
* .:修改当前窗口编号；相当于窗口重新排序
* f:在所有窗口中查找指定文本
* 空格键:采用下一个内置布局，这个很有意思，在多屏时，用这个就会将多有屏幕竖着展示
* w:以菜单方式显示及选择窗口
* s:以菜单方式显示和选择会话。这个常用到，可以选择进入哪个tmux
* t:显示时钟。然后按enter键后就会恢复到shell终端状态

> 面板操作

* ”:将当前面板平分为上下两块
* %:将当前面板平分为左右两块
* x:关闭当前面板
* {:向前置换当前面板
* }:向后置换当前面板
* ; 选择上次使用的窗格
* !:将当前面板置于新窗口；即新建一个窗口，其中仅包含当前面板
* Ctrl+方向键:以1个单元格为单位移动边缘以调整当前面板大小
* Alt+方向键:以5个单元格为单位移动边缘以调整当前面板大小
* Space:在预置的面板布局中循环切换；依次包括even-horizontal、even-vertical、main-horizontal、main-vertical、tiled
* q:显示所有窗格的序号，在序号出现期间按下对应的数字，即可跳转至对应的窗格
* o:跳到下一个分隔窗口，也可以使用上下左右方向键来选择
* z 最大化当前窗格，再次执行可恢复原来大小

> 会话操作

* $ 重命名当前会话
* s 选择会话列表
* d detach 当前会话，运行后将会退出 tmux 进程，返回至 shell 主进程

```sh
tmux new -s foo # 新建名称为 foo 的会话
tmux ls # 列出所有 tmux 会话
tmux a # 恢复至上一次的会话
tmux a -t foo # 恢复名称为 foo 的会话，会话默认名称为数字
tmux kill-session -t foo # 删除名称为 foo 的会话
tmux kill-server # 删除所有的会话
```
