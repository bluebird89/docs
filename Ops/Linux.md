# Linux

以Ubuntu为主要使用系统，不用修改hosts can access google

UNIX/Linux 本身是没有图形界面的，我们通常在 UNIX/Linux 发行版上看到的图形界面实际都只是运行在 Linux 系统之上的一套软件,而 Linux 上的这套软件以前是 XFree86，现在则是 xorg（X.Org），而这套软件又是通过 X 窗口系统（X Window System，也常被称为 X11 或 X）实现的，X 本身只是工具包及架构协议，而 xorg 便是 X 架构规范的一个实现体，也就是说它是实现了 X 协议规范的一个提供图形界面服务的服务器，就像实现了 http 协议提供 web 服务的 Apache 。如果只有服务器也是不能实现一个完整的桌面环境的，当然还需要一个客户端，我们称为 X Client，像如下几个大家熟知也最流行的实现了客户端功能的桌面环境 KDE，GNOME，XFCE，LXDE 。

Linux 是一个可以实现多用户登陆的操作系统，多用户可以同时登陆同一台主机，共享主机的一些资源，不同的用户也分别有自己的用户空间，可用于存放各自的文件。虽然不同用户的文件是放在同一个物理磁盘上的甚至同一个逻辑分区或者目录里，但是由于 Linux 的用户管理和 文件权限机制，不同用户不可以轻易地查看、修改彼此的文件。

## 环境变量

每个进程都有其各自的环境变量设置，且默认情况下，当一个进程被创建时，处理创建过程中明确指定的话，它将继承其父进程的绝大部分环境设置。Shell 程序也作为一个进程运行在操作系统之上，而我们在 Shell 中运行的大部分命令都将以 Shell 的子进程的方式运行。

- 永久的：需要修改配置文件，变量永久生效； /etc/bashrc 存放的是 shell 变量 `echo "PATH=$PATH:/home/shiyanlou/mybin" >> .zshrc`
- .profile（不是/etc/profile） 只对当前用户永久生效，所以如果想要添加一个永久生效的环境变量，只需要打开 /etc/profile
- 环境变量理解生效 `source .zshrc` `. ./.zshrc`
- 临时的：使用 export 命令行声明即可，变量在关闭 shell 时失效。`PATH=$PATH:/home/zhangwang/mybin`给 PATH 环境变量追加了一个路径，它也只是在当前 Shell 有效，一旦退出终端，再打开就会发现又失效了。

```
declare tmp // 使用 declare 命令创建一个变量名为 tmp 的变量
tmp=God // 使用 = 号赋值运算符，将变量 tmp 赋值为 God
echo $tmp // 读取变量的值：使用 echo 命令和 $ 符号（$ 符号用于表示引用一个变量的值）
set:显示当前 Shell 所有变量，包括其内建环境变量（与 Shell 外观等相关），用户自定义变量及导出的环境变量。
env:显示与当前用户相关的环境变量，还可以让命令在指定环境中运行
export：显示从 Shell 中导出成环境变量的变量
unset temp : 删除变量temp
```

- 当前 Shell 进程私有用户自定义变量，如上面我们创建的 tmp 变量，只在当前 Shell 中有效。
- ${变量名#匹配字串}: 从头向后开始匹配，删除符合匹配字串的最短数据
- ${变量名##匹配字串}: 从头向后开始匹配，删除符合匹配字串的最长数据
- ${变量名%匹配字串}: 从尾向前开始匹配，删除符合匹配字串的最短数据
- ${变量名%%匹配字串}: 从尾向前开始匹配，删除符合匹配字串的最长数据
- ${变量名/旧的字串/新的字串}:将符合旧字串的第一个字串替换为新的字串
- ${变量名//旧的字串/新的字串}: 将符合旧字串的全部字串替换为新的字串

## 软件

### 在线安装

`sudo apt-get install cowsay` `source ~/.zshrc`

sudo add-apt-repository --remove ppa:finalterm/daily

- 在本地的一个数据库中搜索关于 cowsay 软件的相关信息
- 根据这些信息在相关的服务器上下载软件安装
- 安装某个软件时，如果该软件有其它依赖程序，系统会为我们自动安装所以来的程序；
- 如果本地的数据库不够新，可能就会发生搜索不到的情况，这时候需要我们更新本地的数据库，使用命令sudo apt-get update可执行更新；
- 软件源镜像服务器可能会有多个，有时候某些特定的软件需要我们添加特定的源；

#### apt-get

程序安装有home路径，bin路径

ubuntu.16替换apt-get为apt

- install 其后加上软件包名，用于安装一个软件包
- update 从软件源镜像服务器上下载/更新用于更新本地软件源的软件包列表
- upgrade 升级本地可更新的全部软件包，但存在依赖问题时将不会升级，通常会在更新之前执行一次update
- dist-upgrade 解决依赖关系并升级(存在一定危险性)
- remove 移除已安装的软件包，包括与被移除软件包有依赖关系的软件包，但不包含软件包的配置文件
- autoremove 移除之前被其他软件包依赖，但现在不再被使用的软件包
- purge 与remove相同，但会完全移除软件包，包含其配置文件
- clean 移除下载到本地的已经安装的软件包，默认保存在/var/cache/apt/archives/
- autoclean 移除已安装的软件的旧版本软件包
- -y 自动回应是否安装软件包的选项，在一些自动化安装脚本中使用这个参数将十分有用
- -q 静默安装方式，指定多个q或者-q=#,#表示数字，用于设定静默级别，这在你不想要在安装软件包时屏幕输出过多时很有用
- -f 修复损坏的依赖关系
- -d 只下载不安装
- --reinstall 重新安装已经安装但可能存在问题的软件包
- --install-suggests 同时安装APT给出的建议安装的软件包
- sudo apt-cache search softname1 softname2 softname3...... 针对本地数据进行相关操作的工具，search 顾名思义在本地的数据库中寻找有关 softname1 softname2 ...... 相关软件的信息

#### 从磁盘安装deb安装包

下载相应deb软件包，使用dpkg命令来安装

- -i 安装指定deb包,之后修复依赖关系的安装`sudo apt-get -f install`
- -R 后面加上目录名，用于安装该目录下的所有deb安装包
- -r remove，移除某个已安装的软件包
- -I 显示deb包文件的信息
- -s 显示已安装软件的信息
- -S 搜索已安装的软件包
- -L 显示已安装软件包的目录信息

#### 从二进制软件包安装

需要做的只是将从网络上下载的二进制包解压后放到合适的目录，然后将包含可执行的主程序文件的目录添加进PATH环境变量即可

#### 从源代码安装

源管理：sudo gedit /etc/apt/sources.list

### 列表

- 云笔记:simplenote
- video: VLC
- editor: atom
- oh my zsh 而非 zsh fish
- KchmViewer:阅读CHM
- LaTeX

## Usage:

```
关闭终端:ctrl+d

where||type composer
```
### Network
sudo gedit /etc/modprobe.d/iwlwifi.config 
add `options iwlwifi 11n_disable=1`
### 终端

终端本质上是对应着 Linux 上的 /dev/tty 设备，Linux 的多用户登陆就是通过不同的 /dev/tty 设备完成的

Ubuntu具体说来，它默认提供七个终端，其中第一个到第六个虚拟控制台是全屏的字符终端，第七个虚拟控制台是图形终端，用来运行GUI程序，按快捷键CTRL+ALT+F1，或CTRL+ALT+F2.......CTRL+ALT+F6，CTRL+ALT+F7可完成对应的切换

## 文件

Linux 的磁盘是"挂在"（挂载在）目录上的，每一个目录不仅能使用本地磁盘分区的文件系统，也可以使用网络上的文件系统。Linux的大部分目录结构是依据FHS标准（英文：Filesystem Hierarchy Standard 中文：文件系统层次结构标准）规定好的，多数 Linux 版本采用这种文件组织形式，FHS 定义了系统中每个区域的用途、所需要的最小构成的文件和目录同时还给出了例外处理与矛盾处理。

FHS包含两层规范：

- / 下面的各个目录应该要放什么文件数据，例如 /etc 应该放置设置文件，/bin 与 /sbin 则应该放置可执行文件等等。
- 针对 /usr 及 /var 这两个目录的子目录来定义。例如 /var/log 放置系统登录文件，/usr/share 放置共享数据等等。

### 文件类型

- 普通文件：一般是用一些相关的应用程序创建的（如图像工具、文档工具、归档工具... 或 cp工具等),这类文件的删除方式是用rm 命令,而创建使用touch命令,用符号-表示；
- 目录：目录在Linux是一个比较特殊的文件，用字符d表示，删除用rm 或rmdir命令；
- 块设备文件：存在于/dev目录下，如硬盘，光驱等设备，用字符d表示;
- 设备文件：（ /dev 目录下有各种设备文件，大都跟具体的硬件设备相关），如猫的串口设备，用字符c表示；
- socket文件;用字符s表示，比如启动MySQL服务器时，产生的mysql.sock的文件;
- pipe 管道文件：可以实现两个程序（可以从不同机器上telnet）实时交互，用字符p表示；
- 链接文件:软链接等同于 Windows 上的快捷方式；用字符l表示； 软硬链接文件的共同点和区别：无论是修改软链接，硬链接生成的文件还是直接修改源文件，相应的文件都会改变，但是如果删除了源文件，硬链接生成的文件依旧存在而软链接生成的文件就不再有效了。

### 文件权限

一个目录同时具有读权限和执行权限才可以打开并查看内部文件，而一个目录要有写权限才允许在其中创建其它文件，这是因为目录文件实际保存着该目录里面的文件的列表等信息。

- 读权限：可以使用 `cat <file name>` 之类的命令来读取某个文件的内容;
- 写权限，表示你可以编辑和修改某个文件；
- 执行权限，通常指可以运行的二进制程序文件或者脚本文件(Linux 上不是通过文件后缀名来区分文件的类型);
- 所有者权限，所属用户组权限，是指你所在的用户组中的所有其它用户对于该文件的权限
- `chmod 700 iphone6`
- `sudo chown zhangwang /etc/apt/sources.list`

#### 文件压缩

##### 压缩

- -r:表示递归打包包含子目录的全部内容
- -q:表示为安静模式，即不向屏幕输出信息
- -o:表示输出文件，需在其后紧跟打包输出文件名
- -[1-9]:设置压缩等级，1 表示最快压缩但体积大，9 表示体积最小但耗时最久。
- -x:排除我们上一次创建的 zip 文件，否则又会被打包进这一次的压缩文件中
- -e：创建加密压缩包
- -l:将 LF（换行） 转换为 CR+LF(windows 回车加换行)

```
zip -r -9 -q -o shiyanlou_9.zip /home/shiyanlou -x ~/*.zip // 设置不同压缩等级
zip -r -e -o shiyanlou_encryption.zip /home/shiyanlou  // 创建加密
zip -r -l -o shiyanlou.zip /home/shiyanlou   // 解决windows和linux对换行的不同处理问题

unzip -q shiyanlou.zip -d ziptest   // 静默且指定解压目录，目录不存在会自动创建
unzip -O GBK 中文压缩文件.zip // 使用 -O（英文字母，大写 o）参数指定编码类型
```

### shell

Shell之所以叫Shell 是因为它隐藏了操作系统底层的细节。命令解析器

- Tab:点击Tab键可以实现命令补全,目录补全、命令参数补全;
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

#### 操作文件

- du命令可以查看目录的容量，-h #同--human-readable 以K，M，G为单位，提高信息的可读性；-a #同--all 显示目录中所有文件的大小 -d:指定查看目录的深度 `du -h -d 1 ~`
- touch:来更改已有文件的时间戳的（比如，最近访问时间，最近修改时间） touch file{1..5}.txt 使用通配符批量创建 5 个文件
- rename:批量重命名,需要用到正则表达式
- rename 's/.txt/.c/' *.txt 批量将这 5 个后缀为 .txt 的文本文件重命名为以 .c 为后缀的文件:
- rename 'y/a-z/A-Z/' *.c 批量将这 5 个文件，文件名改为大写:
- ls:列出某文件夹下的文件，添加参数可实现更细致的功能，
- ls -a 列出所有文件，包括隐藏文件
- ls -l 列出文件及其详细信息(权限)
- tree:查看文件列表
- cd切换目录,cd到不存在的目录时会报错
- pwd打印当前目录
- cat:读取某一个文件内的内容
- wc:获取某一个文件的行数和字数`wc package.json`
- cp:复制某文件 -r
- mkdir:创建目录
- rm dir：删除目录
- rm -rf:r递归删除，f参数表示强制
- mv 移动文件、文件重命名
- sort排序
- diff:比较两个文件的异同
- mkdir -p father/son/grandson:新建多级目录
- cat:打印文件内容到标准输出(正序)
- tac:打印文件内容到标准输出(逆序)
- more:比较简单，只能向一个方向滚动,查看文件：打开后默认只显示一屏内容，终端底部显示当前阅读的进度。可以使用 Enter 键向下滚动一行，使用 Space 键向下滚动一屏，按下 h 显示帮助，q 退出。
- file:查看文件类型`file /bin/ls`
- head:查看文件的头几行（默认10行）
- tail:查看文件的尾几行（默认10行） `tail -n 1 /etc/passwd`
- `dd if=/dev/zero of=virtual.img bs=1M count=256` 从/dev/zero设备创建一个容量为 256M 的空文件virtual.img
- `sudo mkfs.ext4 virtual.img` 格式化virtual.img为ext4格式
- dd默认从标准输入中读取，并写入到标准输出中,但输入输出也可以用选项if（input file，输入文件）和of（output file，输出文件）改变。
- `dd if=/dev/stdin of=test bs=10 count=1 conv=ucase` 将输出的英文字符转换为大写再写入文件
- sudo mount 查看下主机已经挂载的文件系统，每一行代表一个设备或虚拟设备格式[设备名]on[挂载点]

#### 系统相关：

- date:获取当前时间
- uname:返回系统名称
- hostname：返回系统的主机名称
- --version/-V 查看某个程序的版本
- history 显示历史
- help 用于显示 shell 内建命令的简要帮助信息 help exit
- man
- info ls

#### 网络相关：

- host xx.xxx.com：显示某域名相关托管服务器/邮件服务器
- ping 8.8.8.8检测连接

#### 搜索相关命令

```
`whereis who`  \\ 只能搜索二进制文件(-b)，man 帮助文件(-m)和源代码文件(-s)。
`locate /etc/sh`(查找 /etc 下所有以 sh 开头的文件)  \\ 通过/var/lib/mlocate/mlocate.db数据库查找，不过这个数据库也不是实时更新的，系统会使用定时任务每天自动执行 updatedb 命令更新一次，所以有时候你刚添加的文件，它可能会找不到
`locate /usr/share/\*.jpg` \\ 注意要添加 * 号前面的反斜杠转义，否则会无法找到。
`which man` 使用 which 来确定是否安装了某个指定的软件，因为它只从 PATH 环境变量指定的路径中去搜索命令
`sudo find /etc/ -name interfaces/` 格式find [path] [option] [action];  不但可以通过文件类型、文件名进行查找而且可以根据文件的属性（如文件的时间戳，文件的权限等）进行搜索。
```

#### 用户管理

每次次新建用户如果不指定用户组的话，默认会自动创建一个与用户名相同的用户组； 默认情况下在 sudo 用户组里的可以使用 sudo 命令获得 root 权限。

```
who am i:只列出用户名
who mom likes/who am i:列出用户名，所使用终端的编号和开启时间；
finger:列出当前用户的详细信息，需使用apt-get提前安装；

su <user>:切换到用户user,执行时需要输入目标用户的密码；
su - <user>:切换用户，同时环境变量也会跟着改变成目标用户的环境变量。
su -l lilei:切换登录用户; 
sudo adduser lilei:新建一个叫做lilei的用户，添加用户到系统，同时也会默认为新用户创建 home目录：
sudo useradd:只创建用户，创建完了需要用 passwd lilei 去设置新用户的密码; 
groups zhangwang:查看用户属于那些组（groups）   // 每
cat /etc/group | sort 命令查看某组包含那些成员:/etc/group文件中分行显示了用户组（Group）、用户组口令、GID 及该用户组所包含的用户（User）
sudo usermod -G sudo student:不同的组对不同的文件可能具有不同的操作权限，比如说通过上述命令新建的用户默认是没有使用sudo的权限的，我们可以使用usermod命令把它加入sudo组用以具备相应的权限。
sudo deluser student --remove-home：删除用户及用户相关文件；
```

#### 匹配符

- `*`：匹配 0 或多个字符，如`ls *.html`将匹配所有以html结尾的文件,`ls b*.png`将匹配所有以b开头，png结尾的文件；
- `?`：匹配任意一个字符,如`ls abc?.png` 可匹配abcd.png/abce.png
- `[list]`:匹配 list 中的任意单一字符
- `[!list]`:匹配 除list 中的任意单一字符以外的字符
- `[c1-c2]`:匹配 c1-c2 中的任意单一字符 如：[0-9] [a-z]
- `{string1,string2,...}`:匹配 string1 或 string2 (或更多)其一字符串，如 `{css,html}`， `ls app.{html.css}`将匹配app.css 和app.html;
- `{c1..c2}`:匹配 c1-c2 中全部字符 如{1..10}
- 注意通配符大小写敏感

## 操作

- 传输文件通过ssh：

  ```
  scp id_rsa.pub git@172.26.186.117:/home/git/    \\ 登陆服务器
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


// ervernote
sudo add-apt-repository ppa:nixnote/nixnote2-daily
sudo apt update
sudo apt install nixnote2
File->Add Another User…
Tools->Synchronize
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

## ufw防火墙

```
sudo ufw allow 'Nginx HTTP' 
sudo ufw status 
sudo ufw allow https
sudo ufw enable/disable
```

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

## Hypervisor

Linux的最重要创新之一，引入Hypervisor，运行其他操作系统的操作系统，它们为执行提供独立的虚拟硬件平台，同时硬件虚拟平台可以提供对底层机器的虚拟的完整访问.在解决软件架构设计问题时，通常做法是引入一个抽象层来解决，其实这种做法是有点普世原理，同样适用于硬件封装，Hypervisor正是这样一种虚拟抽象层。 只有5%的时间在全负荷工作，其他时间则处于休眠或者空闲状态，虚拟化技术可以大大提升服务器的利用率，从而间接减少服务器数量，即成本！ ![](../_static/Hypervisor.jpg) Hypervisor作为虚拟技术的核心，抽象虚拟化硬件平台.它支持给每一个虚拟机分配内存，CPU， 网络和磁盘，并加载虚拟机的客户操作系统。当然，在获取到这么优秀功能（对硬件的虚拟化，并搭载操作系统）的代价，自然牺牲了启动速度及在资源利用率，性能的开销等。

## LXC(Linux Container）

一种内核虚拟化技术，相比上述的Hypervisor技术则提供更轻量级的虚拟化，以隔离进程和资源，且无需提供指令解析机制及全虚拟化的复杂性，LXC或者容器将操作系统层面的资源分到孤立／隔离的组中，用来管理使用资源。LXC为Sourceforge上的开源项目，其实现是借助Linux的内核特性，（cgroups子系统+namespace）, 在OS层次上做整合为进程提供虚拟执行环境，即称之为容器，除了分配绑定cpu，内存，提供独立的namespace（网络，pid，ipc，mnt，uts）

## Samba服务

### 安装与配置

```
apt-get install samba
mkdir -p /home／directory
chmod 777 /home／directory
vim /etc/samba/smb.conf
[global]的地方添加 security = user
文件最后添加下列设定

[share]
path = /home/username/share      
available = yes
browsealbe = yes
public = yes
writable = yes

useradd username
sudo smbpasswd -a username
/etc/init.d/samba restart

mac 链接
finder中com＋K
smb://192.168.100.106
\\172.16.44.175\Ubuntu
```

## shell扩展

### grep：Global search REgrular expression and Print out the line
--color=auto：对匹配到的文本着色显示
_ -v：显示不被pattern 匹配到的行，反向选择
_ -i：忽略字符大小写
_ -n：显示匹配的行号
_ -c：统计匹配的行数
_ -o：仅显示匹配到的字符串
_ -q：静默模式，不输出任何信息
_ -A #：after，后#行 ,显示包含这行后续#行
_ -B #：before，前#行
_ -C #：context，前后各#行
_ -e：实现多个选项间的成逻辑or关系，grep –e ‘cat ’ -e ‘dog’ file
_ -w：匹配整个单词,（字母，数字，下划线不算单词边界）
_ -E：使用ERE

## sed

一种流编辑器，它一次处理一行内容。处理时，把当前处理的行存储在临时缓存区中，称为“模式空间”(patternspace)，接着用sed命令处理缓存区中的内容，处理完成后，把缓存区的内容送往屏幕。然后读入下一行，执行下一个循环。如果没有使用诸如‘D’的特殊命令，那么会在两个循环之间清空模式空间，但不会清空保留空间。这样不断重复，直到文件末尾。文件内容并没有改变，除非你使用重定向存储输出。
sed的功能：主要用来自动编辑一个或多个文件，简化对文件的反复操作，编写转换程序等，且支持正则表达式！

### 地址定界：就是说明用来处理一行中的那个些部分的。

- 不给地址：对全文进行处理
- #：指定的行/pattern/能够被模式匹配到的每一行
- #,#：从第n行到第m行
- #,+#：从第n行，加上其后面m行
- /pat1/,/pat2/：符合第一个模式和第二个模式的所有行
- #,/pat1/：从第n行到符合 /pat1/ 这个模式的行
- 1~2 ：~ 这个符号表示步进，1~2 表示的是奇数行
- 2~2：表示的是偶数行

### 编辑命令：地址定界后，对范围内的内容进行相关编辑。

- d：删除模式空间匹配的行，并立即启用下一轮循环
- p：打印当前模式空间内容，追加到默认输出之后
- q：读取到指定行之后退出
- a [\]text：在指定行后面追加文本支持使用\n 实现多行行后追加
- i [\]text：在行前面插入文本
- c [\]text：替换行为单行或多行文本
- w /path/somefile：保存模式匹配的行至指定文件
- r /path/somefile：读取指定文件的文本至模式空间中匹配到的行后
- =：为模式空间中的行打印行号
- !：模式空间中匹配行取反处理
- s///：查找替换, 支持使用其它分隔符，s@@@ ，s###
- ；：对一行进行多次操作的命令的分割
- &：配合s///使用，代表前面所查找到的字符等，&sm ；sm&。
- g：行内全局替换。也可以指定行内的第几个符合要求的进行替换：2g,就表示第2个替换。
- p：显示替换成功的行
- w /PATH/TO/SOMEFILE：将替换成功的行保存至文件中

### 高级编辑命令：也是对定界范围内的内容进行处理了，不过是处理起来更加高级。

- P：打印模式空间开端至\n 内容，并追加到默认输出之前
- h：把模式空间中的内容覆盖至保持空间中；m > b
- H：把模式空间中的内容追加至保持空间中; m>>b
- g：从保持空间取出数据覆盖至模式空间; b>m
- G：从保持空间取出内容追加至模式空间; b>>m
- x：把模式空间中的内容与保持空间中的内容进行互换; m <->b
- n：读取匹配到的行的下一行覆盖至模式空间; n>m
- N：读取匹配到的行的下一行追加至模式空间; n>>m
- d：删除模式空间中的行; delete m
- D：如果模式空间包含换行符，则删除直到第一个换行符的模式空间中的文本，并不会读取新的 输入行，而使用合成的模式空间重新启动循环。如果模式空间不包含换行符，则会像发出d 命令那样启动正常的新循环

看着有点有，这里写几个用法示例：
```
sed ‘2p’ /etc/passwd
sed –n ‘2p’ /etc/passwd
sed –n ‘1,4p’ /etc/passwd
sed –n ‘/root/p’ /etc/passwd
sed –n ‘2,/root/p’ /etc/passwd
sed -n ‘/^$/=’ file
sed –n –e ‘/^$/p’ –e ‘/^$/=’ file
sed ‘/root/a\superman’ /etc/passwd
sed ‘/root/i\superman’ /etc/passwd
sed ‘/root/c\superman’ /etc/passwd
sed ‘/^$/d’ file
sed ‘1,10d’ file
nl /etc/passwd | sed ‘2,5d’
nl /etc/passwd | sed ‘2a tea’
sed 's/test/mytest/g' example
sed –n ‘s/root/&superman/p’ /etc/passwd
sed –n ‘s/root/superman&/p’ /etc/passwd
sed -e ‘s/dog/cat/’ -e ‘s/hi/lo/’ pets
sed –i.bak ‘s/dog/cat/g’ pets
sed -n 'n;p' FILE
sed '1!G;h;$!d' FILE
sed 'N;D‘ FILE
sed '$!N;$!D' FILE
sed '$!d' FILE
sed ‘G’ FILE
sed ‘g’ FILE
sed ‘/^$/d;G’ FILE
sed 'n;d' FILE
sed -n '1!G;h;$p' FILE
```


### awk
man awk
awk是一种报表生成器，就是对文件进行格式化处理的，这里的格式化不是文件系统的格式化，而是对文件内容进行各种“排版”，进而格式化显示。
```
gawk - pattern scanning and processing language：（模式扫描和处理语言）
awk [options] 'BEGIN{ action;… } pattern{ action;… } END{ action;… }' file ...
-f progfile，--file=progfile：从文件中来读取awk 的program
-F fs，--field-separator=fs：指明输入时用到的字段分割符
-v var=val，--assign=var=val：在执行program之前来定义变量
```

- 执行[option]相关内容，也就是-f，-F，-v选项内容。
- 执行BEGIN{action;… } 语句块中的语句。BEGIN 语句块在awk开始从输入流中读取行之前被执行，这是一个可选的语句块，比如变量初始化、打印输出表格的表头等语句通常可以写在BEGIN 语句块中。
- 从文件或标准输入(stdin) 读取每一行，然后执行pattern{action;… }语句块，它逐行扫描文件，从第一行到最后一行重复这个过程，直到文件全部被读取完毕。pattern语句块中的通用命令是最重要的部分，也是可选的。如果没有提供pattern 语句块，则默认执行{ print } ，即打印每一个读取到的行，awk 读取的每一行都会执行该语句块。
- 当读至输入流末尾时，也就是所有行都被读取完执行完后，再执行END{action;…} 语句块。END 语句块在awk从输入流中读取完所有的行之后即被执行，比如打印所有行的分析结果这类信息汇总都是在END 语句块中完成，它也是一个可选语句块。

#### 内置变量：
```
FS：输入字段分隔符，默认为空白字符，这个想当于-F选项。分隔符可以是多个，用[]括起来表示,如：-v FS="[,./-:;]"
OFS：输出字段分隔符，默认为空白字符，分隔符可以是多个，同上
RS ：输入记录(所认为的行)分隔符，指定输入时的换行符，原换行符仍有效，分隔符可以是多个，同上
ORS ：输出记录(所认为的行)分隔符，输出时用指定符号代替换行符，分隔符可以是多个，同上
NF：字段数量
NR：记录数(所认为的行)
FNR ：各文件分别计数, 记录数（行号）
FILENAME ：当前文件名
ARGC：命令行参数的个数
ARGV ：数组，保存的是命令行所给定的各参数
```

#### 自定义变量(区分字符大小写)：
```
在'{...}'前，需要用-v var=value：awk -v var=value '{...}'
在program 中直接定义：awk '{var=vlue}'
```

#### 实例
```
awk -v FS=':' '{print $1,FS,$3}’ /etc/passwd
awk –F: '{print $1,$3,$7}’ /etc/passwd
awk -v FS=‘:’ -v OFS=‘:’ '{print $1,$3,$7}’ /etc/passwd
awk -v RS=' ' ‘{print }’ /etc/passwd
awk -v RS="[[:space:]/=]" '{print }' /etc/fstab |sort
awk -v RS=' ' -v ORS='###'‘{print }’ /etc/passwd
awk -F： ‘{print NF}’ /etc/fstab, 引用内置变量不用$
awk -F: '{print $(NF-1)}' /etc/passwd
awk '{print NR}' /etc/fstab ; awk 'END{print NR}' /etc/fstab
awk '{print FNR}' /etc/fstab /etc/inittab
awk '{print FNR}' /etc/fstab /etc/inittab
awk '{print FILENAME}’ /etc/fstab
awk '{print ARGC}’ /etc/fstab /etc/inittab
awk ‘BEGIN {print ARGC}’ /etc/fstab /etc/inittab
awk ‘BEGIN {print ARGV[0]}’ /etc/fstab   /etc/inittab
awk ‘BEGIN {print ARGV[1]}’ /etc/fstab  /etc/inittab
awk -v test='hello gawk' '{print test}' /etc/fstab
awk -v test='hello gawk' 'BEGIN{print test}'
awk 'BEGIN{test="hello,gawk";print test}'
awk –F:‘{sex=“male”;print $1,sex,age;age=18}’ /etc/passwd
awk -F: '{sex="male";age=18;print $1,sex,age}' /etc/passwd
echo "{print script,\$1,\$2}"  > awkscript
awk -F: -f awkscript script=“awk” /etc/passwd
```

#### print和printf
print 格式：print item1,item2, ...

printf格式：printf “FORMAT ”,item1,item2, ...

- 逗号为分隔符时，显示的是空格；
- 分隔符分隔的字段（域）标记称为域标识，用$0,$1,$2,...,$n表示，其中$0 为所有域，$1就是表示第一个字段（域），以此类推；
- 输出的各item可以字符串，也可以是数值，当前记录的字段，变量或awk 的表达式等；
- 如果省略了item ，相当于print $0
- 对于printf来说，必须指定FORMAT，即必须指出后面每个itemsN的输出格式，且还不会自动换行，需要显式则指明换行控制符"\n"

```
%c：显示字符的ASCII码
%d, %i：显示十进制整数
%e, %E：显示科学计数法数值
%f：显示为浮点数
%g, %G：以科学计数法或浮点形式显示数值
%s：显示字符串
%u：无符号整数
%%：显示%自身
#[.#]：第一个数字控制显示的宽度；第二个#表示小数点后精度，%3.1f
-：左对齐（默认右对齐）；%-15s，就是以左对齐方式显示15个字符长度
+：显示数值的正负符号 %+d

awk '{print "hello,awk"}'
awk –F: '{print}' /etc/passwd
awk –F: ‘{print “wang”}’ /etc/passwd
awk –F: ‘{print $1}’ /etc/passwd
awk –F: ‘{print $0}’ /etc/passwd
awk –F: ‘{print $1”\t”$3}’ /etc/passwd
tail –3 /etc/fstab |awk ‘{print $2,$4}’
awk -F: ‘{printf "%s",$1}’ /etc/passwd
awk -F: ‘{printf "%s\n",$1}’ /etc/passwd
awk -F: '{printf "%-20s %10d\n",$1,$3}' /etc/passwd
awk -F: ‘{printf "Username: %s\n",$1}’ /etc/passwd
awk -F: ‘{printf “Username: %s,UID:%d\n",$1,$3}’ /etc/passwd
awk -F: ‘{printf "Username: %15s,UID:%d\n",$1,$3}’ /etc/passwd
awk -F: ‘{printf "Username: %-15s,UID:%d\n",$1,$3}’ /etc/passwd
lsmod
awk -v FS=" " 'BEGIN{printf "%s %26s %10s\n","Module","Size","Used by"}{printf "%-20s %13d
```

#### 操作符
- 算术操作符：x+y, x-y, x*y, x/y, x^y, x%y
- 赋值操作符：=, +=, -=, *=, /=, %=, ^=，++, --
- 比较操作符：==, !=, >, >=, <, <=
- 模式匹配符：~ ：左边是否和右边匹配包含；!~ ：是否不匹配
- 逻辑操作符：与:&& ；或:|| ；非:!
- 条件表达式（三目表达式）：selector ? if-true-expression : if-false-expression
```
awk –F: '$0 ~ /root/{print $1}‘ /etc/passwd
awk '$0~“^root"' /etc/passwd
awk '$0 !~ /root/‘ /etc/passwd
awk –F: ‘$3==0’ /etc/passwd
awk–F: '$3>=0 && $3<=1000 {print $1}' /etc/passwd
awk -F: '$3==0 || $3>=1000 {print $1}' /etc/passwd
awk -F: ‘!($3==0) {print $1}' /etc/passwd
awk -F: ‘!($3>=500) {print $3}’ /etc/passwd
awk -F: '{$3>=1000?usertype="Common User":usertype="Sysadmin or SySUSEr";printf "%15s:%-s\n"
```

#### pattern

根据pattern条件，过滤匹配的行，再做处理。
- 未指定：表示空模式，匹配每一行
- /regular expression/：仅处理能够模式匹配到的行，支持正则表达式，需要用/ /括起来
- 关系表达式：结果为“真”才会被处理。真：结果为非0值，非空字符串。假：结果为空字符串或0值
- /pat1/,/pat2/：startline,endline ，行范围,支持正则表达式，不支持直接给出数字格式
- BEGIN{}和END{}：BEGIN{} 仅在开始处理文件中的文本之前执行一次。END{}仅在文本处理完成之后执行 一次

```
awk '/^UUID/{print $1}' /etc/fstab
awk '!/^UUID/{print $1}' /etc/fstab
awk -F: ‘/^root\>/,/^nobody\>/{print $1}' /etc/passwd
awk -F: ‘(NR>=10&&NR<=20){print NR,$1}'  /etc/passw
awk -F: 'i=1;j=1{print i,j}' /etc/passwd
awk ‘!0’ /etc/passwd ; awk ‘!1’ /etc/passwd
awk –F: '$3>=1000{print $1,$3}' /etc/passwd
awk -F: '$3<1000{print $1,$3}' /etc/passwd
awk -F: '$NF=="/bin/bash"{print $1,$NF}' /etc/passwd
awk -F: '$NF ~ /bash$/{print $1,$NF}' /etc/passwd
awk -F : 'BEGIN {print "USER USERID"} {print $1":"$3}END{print "end file"}' /etc/passwd
awk -F: 'BEGIN{print "    USER     USERID"}{printf "|%8s| %10d|\n",$1,$3}END{print "END FILE"}' /etc/passwd
awk -F : '{print "USER USERID“;print $1":"$3} END{print"end file"}' /etc/passwd
awk -F: 'BEGIN{print " USER UID \n---------------"}{print $1,$3}' /etc/passwd
awk -F: 'BEGIN{print "    USER     USERID\n----------------------"}{printf "|%8s| %10d|\n",$1,$3}END{print "----------------------\nEND FILE"}' /etc/passwd
awk -F: 'BEGIN{print " USER UID \n---------------"}{print $1,$3}'END{print "=============="} /etc/passwd
seq 10 |awk ‘i=0’
seq 10 |awk ‘i=1’
seq 10 | awk 'i=!i‘
seq 10 | awk '{i=!i;print i}‘
seq 10 | awk ‘!(i=!i)’
seq 10 |awk -v i=1 'i=!i'
```

#### action
- 表达式语句，包括算术表达式和比较表达式，就是用进行比较和计算的。
- 控制语句，用作进行控制，典型的就是if else，while等语句，和bash脚本里面用法差不多。
- 输入语句，用来做为输入，变量赋值就算是。
- 输出语句，用来输出显示的，典型的是print和printf
- 组合语句，这个很多理解，就是多种语句的组合

##### if-else

- {if(condition){statement;…}}：条件满足就执行statement
- {if(condition){statement1;…}{else statement2}}：条件满足执行statement1，不满足执行statement2
- {if(condition1){statement1}else if(condition2){statement2}else{statement3}}：条件1满足执行statement2，不满足条件1但满足条件2执行statement2，所用条件都不满足就执行statement3
```
awk -F: '{if($3>=1000)print $1,$3}' /etc/passwd
awk -F: '{if($NF=="/bin/bash") print $1}' /etc/passwd
awk '{if(NF>5) print $0}' /etc/fstab
awk -F: '{if($3>=1000) {printf "Common user: %s\n",$1}else{printf "root or Sysuser: %s\n",$1}}' /etc/passwd
awk -F: '{if($3>=1000) printf "Common user: %s\n",$1;else printf "root or Sysuser: %s\n",$1}' /etc/passwd
df -h|awk -F% '/^\/dev/{print $1}'|awk '$NF>=80{print $1,$5}‘
awk 'BEGIN{ test=100;if(test>90){print "very good"}else if(test>60){ print "good"}else{print "bad"}
```

##### while和do-while

- while(condition){statement;…}：条件为“真”时，进入循环；条件为“假”时， 退出循环
- do {statement;…}while(condition)：无论真假，至少执行一次循环体。当条件为“真”时，退出循环；条件为“假”时，继续循环
```
awk '/^[[:space:]]*linux16/{i=1;while(i<=NF){print $i,length($i); i++}}' /etc/grub2.cfg
awk '/^[[:space:]]*linux16/{i=1;while(i<=NF) {if(length($i)>=10){print $i,length($i)}; i++}}' /etc/grub2.cfg
awk 'BEGIN{ total=0;i=0;do{total+=i;i++}while(i<=100);print total}‘
```

##### for

- for(expr1;expr2;expr3) {statement;…}：expr1为变量赋值，如var=value，初始进行变量赋值；expr2为条件判断语句，j<=10，满足条件就继续执行statement；expr3为迭代语句，如j++，每次执行完statement后就迭代增加
- for(var in array) {for-body}：变量var遍历数组，每个数组中的var都会执行一次for-body
```
awk '/^[[:space:]]*linux16/{for(i=1;i<=NF;i++) {print $i,length($i)}}' /etc/grub2.cfg
awk '/^[^#]/{type[$3]++}END{for(i in type)print i,type[i]}' /etc/fstab
awk -v RS="[[:space:]/=,-]" '/[[:alpha:]]/{ha[$0]++}END{for(i in ha)print i,ha[i]}' /etc/fstab
```

##### switch 相当于bash中的case语句

switch(expr) {case VAL1 or /REGEXP/:statement1; case VAL2 or /REGEXP2/: statement2;...; default: statementn}：若expr满足 VAL1 or /REGEXP/就执行statement1，若expr满足VAL2 or /REGEXP2/就执行statement2，以此类推，执行statementN，都不满足就执行statement

##### break、continue和next

- break[n]：当第n次循环到来后，结束整个循环，n=0就是指本次循环
- continue[n]：满足条件后，直接进行第n次循环，本次循环不在进行，n=0也就是提前结束本次循环而直接进入下一轮
- next：提前结束对本行的处理动作而直接进入下一行处理

```
awk ‘BEGIN{sum=0;for(i=1;i<=100;i++){if(i%2==0)continue;sum+=i}print sum}‘
awk ‘BEGIN{sum=0;for(i=1;i<=100;i++){if(i==66)break;sum+=i}print sum}‘
awk -F: '{if($3%2!=0) next; print $1,$3}' /etc/passwd
```

#### 数组

关联数组，格式为：array[index-expression]：arry为数组名，index-expression为下标。index-expression可使用任意字符串，字符串要使用双引号括起来；如果某数组元素事先不存在，在引用时，awk 会自动创建此元素，并将其值初始化为“空串”。
若要判断数组中是否存在某元素，要使用“index in array”格式进行遍历。若要遍历数组中的每个元素，要使用for循环：for(var in array) {for-body}，使用for循环会使var 会遍历array的每个索引。此时要显示数组元素的值，则要使用array[var]。
```
awk 'BEGIN{weekdays["mon"]="Monday";weekdays["tue"]="Tuesday";print weekdays["mon"]}‘
awk '!arr[$0]++' dupfile
awk '{!arr[$0]++;print $0, arr[$0]}' dupfile
awk 'BEGIN{weekdays["mon"]="Monday";weekdays["tue"]="Tuesday";for(i in weekdays) {print weekdays[i]}}‘
netstat -tan | awk '/^tcp/{state[$NF]++}END{for(i in state) { print i,state[i]}}'
awk '{ip[$1]++}END{for(i in ip) {print i,ip[i]}}'/var/log/httpd/access_log
```

#### 函数

```
rand()：返回0 和1 之间一个随机数
srand()：生成随机数种子
int()：取整数
length([s])：返回指定字符串的长度
sub(r,s,[t])：对t字符串进行搜索，r表示的模式匹配的内容，并将第一个匹配的内容替换为s
gsub(r,s,[t])：对t字符串进行搜索，r表示的模式匹配的内容，并全部替换为s所表示的内容
split(s,array,[r])：以r为分隔符，切割字符串s，并将切割后的结果保存至array 所表示的数组中，第一个索引值为1, 第二个索引值为2,…也就是说awk的数组下标是从1开始编号的。
substr(s,i,[n])：从s所表示的字符串中取子串，取法：从i表示的位置开始，取n个字符。
systime()：取当前系统时间，结果形式为时间戳。
system()：调用shell中的命令。空格是awk中的字符串连接符，如果system 中需要使用awk中的变量可以使用空格分隔，或者说除了awk的变量外其他一律用"" 引用 起来。

awk 'BEGIN{srand(); for (i=1;i<=10;i++)print int(rand()*100) }'
echo "2008:08:08 08:08:08" | awk 'sub(/:/,“-",$1)'
echo "2008:08:08 08:08:08" | awk ‘gsub(/:/,“-",$0)'
netstat -tan | awk '/^tcp\>/{split($5,ip,":");count[ip[1]]++}END{for (i in count) {print i,count[i]}}'
awk BEGIN'{system("hostname") }'
awk 'BEGIN{score=100; system("echo your score is " score) }'

自定义函数，格式为

function fname ( arg1,arg2 , ... ) {
statements
return expr
}

cat fun.awk
    function max(v1,v2) {
        v1>v2?var=v1:var=v2
        return var
    }
      BEGIN{a=3;b=2;print max(a,b)}
awk –f fun.awk
```

#### 脚本
将awk程序写成脚本形式，来直接调用或直接执行。

格式1：`BEGIN{} pattern{} END{}`
格式2：
```
\#!/bin/awk  -f
\#add 'x'  right 
BEGIN{} pattern{} END{}
```
格式1假设为f1.awk文件，格式2假设为f2.awk文件，那么用法是：
```
awk [-v var=value] f1.awk [file]
f2.awk [-v var=value] [var1=value1] [file]
```

对于awk [-v var=value] f1.awk [file]来说，很好理解，就是把处理阶段放到一个文件而已，真正展开后，也就是普通的awk语句。
对于f2.awk [-v var=value] [var1=value1] [file]来说， [-v var=value]是在BEGIN之前设置的变量值，[var1=value1]是在BEGIN过程之后进行的，也就是说直到首行输入完成后，这个变量才可用，这就想awk脚本黄总传递参数了。
示例：
```
cat f1.awk
    {if($3>=1000)print $1,$3}
awk -F: -f f1.awk /etc/passwd

cat f2.awk
    #!/bin/awk –f
    #this is a awk script
    {if($3>=1000)print $1,$3}
    #chmod +x f2.awk
f2.awk –F: /etc/passwd

cat test.awk
    #!/bin/awk –f
    {if($3 >=min && $3<=max)print $1,$3}
    #chmod +x test.awk
test.awk -F: min=100 max=200 /etc/passwd
```

### rsync
类unix系统下的数据镜像备份工具。使用快速增量备份工具Remote Sync可以远程同步，支持本地复制，或者与其他SSH、rsync主机同步。

## 扩展

- [aleksandar-todorovic/awesome-linux](https://github.com/aleksandar-todorovic/awesome-linux)A list of awesome projects and resources that make Linux even more awesome

## 参考

- [awk基本用法和工作原理详解](http://www.linuxidc.com/Linux/2017-10/147270.htm)
