# 系统

以Ubuntu为主要使用系统，不用修改hosts can access google

# 软件

- 云笔记:simplenote
- video: VLC
- editor: atom
- zsh
- oh my zsh 而非 zsh fish
- KchmViewer:阅读CHM
- LaTeX

# Usage:

```
搜索：sudo apt-cache search php7.1
删除：sudo apt-get autoremove  || sudo apt-get --purge remove
源管理：sudo gedit /etc/apt/sources.list

关闭终端:ctrl+d

where||type compsoer
```

# 操作

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

# atom install

```
sudo add-apt-repository ppa:webupd8team/atom
sudo apt-get update
sudo apt-get install atom
```

# clean

```
sudo apt-get autoclean
sudo apt-get autoremove
sudo apt-get clean
```

# chrome(firefox 禁用console.log)

```
sudo wget http://www.linuxidc.com/files/repo/google-chrome.list -P /etc/apt/sources.list.d/
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub  | sudo apt-key add -
sudo apt-get update
sudo apt-get install google-chrome-stable
```

# 防火墙

- ufw： sudo ufw allow 'Nginx HTTP' sudo ufw status sudo ufw allow https

# 指令

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

supervisor
