# Linux系统

以Ubuntu为主要使用系统，不用修改hosts can access google

## 软件

- 云笔记:simplenote
- video: VLC
- editor: atom
- zsh
- oh my zsh 而非 zsh fish
- KchmViewer:阅读CHM
- LaTeX

## Usage:

```
搜索：sudo apt-cache search php7.1
删除：sudo apt-get autoremove  || sudo apt-get --purge remove
源管理：sudo gedit /etc/apt/sources.list

关闭终端:ctrl+d

where||type compsoer
```

## 操作

- 传输文件通过ssh：

  ```
  scp id_rsa.pub git@172.26.186.117:/home/git/
  \\ 登陆服务器
  ssh -p 2222 user@host
  ```

- 文件文件 cat file >> another file

- 服务管理：

  ```
  sudo systemctl enable nginx
  sudo systemctl start nginx
  sudo systemctl restart nginx
  systemctl status nginx
  sudo systemctl reload nginx
  ```

- 修改hosts

  ```
  sudo su
  curl https://github.com/racaljk/hosts/blob/master/hosts -L >> /etc/hosts
  ```

# sougou pinyin install

- command line
- package

  - get package: download sogou_pinyin_linux_1.0.0.0033_amd64.deb
  - install:

```
sudo dpkg  -i   sogou_pinyin_linux_1.0.0.0033_amd64.deb
```

- config:

  - system setting->language support
  - choose language,key input fcitx

## atom install

```
sudo add-apt-repository ppa:webupd8team/atom
sudo apt-get update
sudo apt-get install atom
```

## clean

```
sudo apt-get autoclean
sudo apt-get autoremove
sudo apt-get clean
```

## chrome(firefox 禁用console.log)

```
sudo wget http://www.linuxidc.com/files/repo/google-chrome.list -P /etc/apt/sources.list.d/
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub  | sudo apt-key add -
sudo apt-get update
sudo apt-get install google-chrome-stable
```

## 防火墙

- ufw： sudo ufw allow 'Nginx HTTP' sudo ufw status sudo ufw allow https

## 指令

- 实时刷新文件：tail -f file
- 查看linux系统信息

  - uname -a：显示电脑以及操作系统的相关信息
  - cat /proc/version:说明正在运行的内核版本
  - cat /etc/issue:显示的是发行版本信息
  - lsb_release -a

## 启动项

启动目录： /etc/rc.d/rc[0~6].d 命令行脚本文件：/etc/init.d/ 本地文件：/etc/rc.local 添加 /etc/init.d/nginx start

- 提高电池的寿命并且减少过热

  ```
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

```
// 查看某一端口的占用情况
[sudo ]lsof -i : (port)
// 显示tcp，udp的端口和进程等相关
netstat -tunlp
// 指定端口号进程情况
netstat -tunlp|grep (port)
// 进程查看
ps -ef | grep nginx
ps aux | grep nginx
lsof -Pni4 | grep LISTEN | grep php
// 关闭进程
kill -9 pid
```

chkconfig --list sshd

## 终端命令

- ssh:连接到一个远程主机，然后登录进入其 Unix shell。这就使得通过自己本地机器的终端在服务器上提交指令成为了可能。

```
ssh username@remote_host
ssh username@remote_host ls /var/www
```

- grep:用来在文本中查找字符串,从一个文件或者直接就是流的形式获取到输入, 通过一个正则表达式来分析内容，然后返回匹配的行。该命令在需要对大型文件进行内容过滤的时候非常趁手`grep "$(date +"%Y-%m-%d")" all-errors-ever.log > today-errors.log`
- 使用 alias 这个 bash 内置的命令来为它们创建一个短别名:alias server="python -m SimpleHTTPServer 9000"
- Curl 是一个命令行工具，用来通过 HTTP（s），FTP 等其它几十种你可能尚未听说过的协议来发起网络请求。
- Tree 用可视化的效果向你展示一个目录下的文件 tree -P '_.min._'
- Tmux 是一个终端复用器,它是一个可以将多个终端连接到单个终端会话的工具。可以在一个终端中进行程序之间的切换，添加分屏窗格，还有就是将多个终端连接到同一个会话，使它们保持同步。 当你在远程服务器上工作时，Tmux 特别有用，因为它可以让你创建新的选项卡，然后在选项卡之间切换
- du 命令会生成相关文件和有关目录的空间使用情况的报告。它很容易使用，也可以递归地运行，会遍历每个子目录并且返回每个文件的单个大小。`du -sh *`
- tar:用来处理文件压缩的默认 Unix 工具.
- md5sum:它们可以用来检查文件的完整性。`md5sum ubuntu-16.04.3-desktop-amd64.iso` 将生成的字符串与原作者提供的（比如 UbuntuHashes）进行比较
- Htop 是个比内置的 top 任务管理更强大的工具。它提供了带有诸多选项的高级接口用于监控系统进程。
- ln:unix 里面的链接同 Windows 中的快捷方式类似，允许你快速地访问到一个特定的文件。`sudo ln -s ~/Desktop/Scripts/git-scripts/git-cleanup /usr/local/bin/`
