# Shell

Shell是Linux/Unix的一个外壳。它负责外界与Linux内核的交互，接收用户或其他应用程序的命令，然后把这些命令转化成内核能理解的语言，传给内核，内核是真正干活的，干完之后再把结果返回用户或应用程序。

Shell之所以叫Shell 是因为它隐藏了操作系统底层的细节。命令解析器

```sh
# 命令失败，往往需要脚本停止执行，防止错误累积
set -e
command || { echo "command failed"; exit 1; }
if ! command; then echo "command failed"; exit 1; fi
command
if [ "$?" -ne 0 ]; then echo "command failed"; exit 1; fi
```

## 端口占用

```sh
netstat -an | grep 3306
netstat -tunlp |grep 端口号 # 查看指定的端口号的进程情况 -t 显示tcp -u udp -n:拒绝显示别名，能数字数字 -l 列出在listen 服务状态 -p 显示相关程序名
lsof -i:80 # -i参数表示网络链接，:80指明端口号
```

## 查找

```sh
find / -name *.conf -type f -print | xargs file

find / -name *.conf -type f -print | xargs tar cjf test.tar.gz

ssh -p 22 -C -f -N -g -L 9200:192.168.1.19:9200 ihavecar@192.168.1.19

netstat -anlp|grep 80|grep tcp|awk '{print $5}'|awk -F: '{print $1}'|sort|uniq -c|sort -nr|head -n20

netstat -nat |awk ‘{print $6}’|sort|uniq -c|sort -rn

ping api.jpush.cn | awk ‘{ print $0”    “ strftime(“%Y-%m-%d %H:%M:%S”,systime()) } ‘ >> /tmp/jiguang.log &

wget ftp://ftp.is.co.za/mirror/ftp.rpmforge.net/redhat/el6/en/x86_64/dag/RPMS/multitail-5.2.9-1.el6.rf.x86_64.rpm
yum -y localinstall multitail-5.2.9-1.el6.rf.x86_64.rpm
multitail -e "Accepted" /var/log/secure -l "ping baidu.com"

ps -aux | sort -rnk 3 | head -20

ps -aux | sort -rnk 4 | head -20
```

## 磁盘管理

```sh
fdisk  -l # 所有硬盘的分区信息,包括没有挂上的分区和USB设备
ls -l /dev/sda* # 查看第一块硬盘的分区信息
df -a|-h|-T #-a或-all：显示全部的文件系统 -h或--human-readable：以可读性较高的方式来显示信息 -T或--print-type：显示文件系统的类型

du [option] 目录名或文件名 # [option]主要参数  -a或-all：显示目录中个别文件的大小 -h或--human-readable：以K，M，G为单位显示，提高信息可读性 -S或--separate-dirs：省略指定目录下的子目录，只显示该目录的总和（注意：该命令是大写S） ncdu

tin-summer
curl -LSfs https://japaric.github.io/trust/install.sh | sh -s -- --git vmchale/tin-summer
cargo install tin-summer

sn f
sn sort /home/sk/ -n5
sn ar -t100M

cargo install du-dust
wget https://github.com/bootandy/dust/releases/download/v0.3.1/dust-v0.3.1-x86_64-unknown-linux-gnu.tar.gz
tar -xvf dust-v0.3.1-x86_64-unknown-linux-gnu.tar.gz
sudo mv dust /usr/local/bin/
dust -p
dust <dir1> <dir2>
dust -s
dust -n 10
dust -d 3
dust -h

yay -S diskus
wget "https://github.com/sharkdp/diskus/releases/download/v0.3.1/diskus_0.3.1_amd64.deb"
sudo dpkg -i diskus_0.3.1_amd64.deb
cargo install diskus

du -sh dir
diskus -h

# duu
wget https://github.com/jftuga/duu/releases/download/2.20/duu.py
python3 duu.py
python3 duu.py /home/sk/Downloads/
```

## 配置

* /etc/profile：所有用户的shell都有权使用你配置好的环境变量 添加 export PATH="$PATH:/my_new_path"
* bash_profile  ~/.bashrc 当用户登录时，该文件仅仅执行一次。用来设置环境变量 功能和/etc/profile 相同只不过 他指针对用户来设定,需要source 生效或者退出后生效
    - 如果ssh方式远程登录Linux时，会自动执行用户家目录下的.bash_profile文件，所有可以在这个文件里面添加一些内容，以便ssh登录Linux时都会执行相应的内容。
* /etc/vim/.vimrc # vim的root用户配置文件
* ～/.vimrc # 针对当前用户的配置
* ~/.zshrc：zsh配置文件
* PATH="$PATH:/my_new_path":临时添加，关闭后失效
* 选项如果单字符选项前使用一个减号-。单词选项前使用两个减号--

```sh
cmd [options] [arguments] # options称为选项，arguments称为参数

echo $SHELL # 查看shell

/* 如果vim还没有语法高亮，那么在/etc/profile 中添加以下语句 */
export TERM=xterm-color
// 注: 只对各个用户自己的主目录下的.vimrc修改的话，修改内容只对本用户有效,要想全部有效，可以修改 /etc/vimrc           同样的 /etc/bashrc 是针对所有用户的启动文件

/* 以下是 ~/.vimrc 文件的内容 */
set nonumber # 不设置行号
set shell=/bin/bash     # 设置shell环境
syntax on     # 开启vim语法高亮
colorscheme desert     # 设置主题色
set background=dark
set autoindent     # 设置自动缩进
set nocompatible     # 不向下兼容vi
set showmatch      # 开启括号匹配
set cursorline     # 光标所在行高亮
set ruler     # 设置标尺
set laststatus=2     # 开启状态栏（默认是1）
set smartindent     # 开启新航时使用智能自动缩进
set hlsearch     # 搜索时高亮显示找到的文本
set wrap     # 设置自动换行
set tabstop=4     # 设置缩进为4个空格
set softtabstop=4
set shiftwidth=4
filetype on     # 检测文件类型
set history=500     # 设置历史行数
set smartindent     # 理想添加 依据上面的格式自动对齐

ls /usr/share/vim/vim72/colors/        可以查看vim支持的主题色

/* 目录配色方案（将/etc中的DIR_COLORS文件复制到自己主目录中，并重命名为.dir_colors） */
cp /etc/DIR_COLORS ~/.dir_colors

/* PS1 用户主提示符配色方案(在 .bashrc 文件中添加) */
export PS1="\[\e[0;36m\]\u\[\e[m\]@\[\e[0;32m\]\h: \[\e[0;35m\]\W\[\e[m\] \\$  "
// 另外种等效写法
# PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h: \[\033[35m\]\W\[\033[m\] \\$  "
# export PS1

// 另外种主提示符样式（对CentOS默认的主提示符加颜色标识）
# export PS1="[\[\e[0;36m\]\u\[\e[m\]@\[\e[0;32m\]\h \[\e[0;35m\]\W\[\e[m\]]\\$  "

/* .bashrc 文件中个人习惯的别名命令 */
alias cls='clear'   #DOS风格的清空
alias h='history | tail'
alias hg='history | grep'
alias hl='history | less'
stty erase ^H        #清除退格 (这个很有必要)

/*  /etc/profile 文件设置 */
export PATH=$PATH:/opt/perl/site/bin:/opt/perl/bin
```

### [zsh-users/zsh](https://github.com/zsh-users/zsh)

```sh
cat /etc/shells

echo $SHELL/bin/bash

sudo yum install zsh
sudo apt-get install zsh git wget

brew install zsh zsh-completions # Mac

wget --no-check-certificate 。![]https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh

chsh -s /bin/zsh
source ~/.bashrc # 运行
```

#### [robbyrussell/oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)

A delightful community-driven (with 1,000+ contributors) framework for managing your zsh configuration. Includes 200+ optional plugins (rails, git, OSX, hub, capistrano, brew, ant, php, python, etc), over 140 themes to spice up your morning, and an auto-update tool so that makes it easy to keep up with the latest updates from the community.

```sh
# 自动安装
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

# 手动
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

chsh -s /bin/zsh # 修改系统bash
source ~/.bashrc # 运行

zsh # 切换zsh
bash # 切换 bash

cd ~/.oh-my-zsh/custom/plugins
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git # add to .zshrc plugin

echo 'export PATH="/usr/local/sbin:$PATH"' >> ~/.zshrc
```

> 配置： home目录的.zshrc(不用单配，插件配置有)

```sh
# install fonts-powerline
`sudo apt-get install fonts-powerline`

# config
ZSH_THEME="agnoster"

export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

# alias
alias cls='clear'
alias ll='ls -l'
alias la='ls -a'
alias vi='vim'
alias javac="javac -J-Dfile.encoding=utf8"
alias grep="grep --color=auto"
alias -s html=mate   # 在命令行直接输入后缀为 html 的文件名，会在 TextMate 中打开
alias -s rb=mate     # 在命令行直接输入 ruby 文件，会在 TextMate 中打开
alias -s py=vi       # 在命令行直接输入 python 文件，会用 vim 中打开，以下类似
alias -s js=vi
alias -s c=vi
alias -s java=vi
alias -s txt=vi
alias -s gz='tar -xzvf'
alias -s tgz='tar -xzvf'
alias -s zip='unzip'
alias -s bz2='tar -xjvf'
alias cdhome='cd ~'
alias cdroot='cd /'
alias gpull='git pull'
alias gci='git commit -a'
alias gpush='git push origin HEAD:refs/for/master'
alias gst='git status'
alias sublime='open -a "Sublime Text"' # 加入Sublime Text

alias untar='tar -zxvf '
alias wget='wget -c ' # 下载的东西，但如果出现问题可以恢复
alias getpass="openssl rand -base64 20" # 新的网络帐户生成随机的 20 个字符的密码
alias sha='shasum -a 256 ' # 下载文件并需要测试校验和
alias ping='ping -c 5' #  限制在五个 ping
alias www='python -m SimpleHTTPServer 8000' # 在任何你想要的文件夹中启动 Web 服务器。
alias speed='speedtest-cli --server 2406 --simple' # 网络有多快？只需下载 Speedtest-cli 并使用此别名即可。你可以使用 speedtest-cli --list 命令选择离你所在位置更近的服务器。
alias ipe='curl ipinfo.io/ip' # 需要知道你的外部 IP 地址
alias ipi='ipconfig getifaddr en0' # 知道你的本地 IP 地址
alias c='clear'

ZSH_THEME="robbyrussell" # 主题设置（文件在~/.oh-my-zsh/themes）

# 插件
plugins=(git textmate ruby autojump osx mvn gradle autojump)

export DEFAULT_USER="henry" # hide username

PROMPT='%{$fg_bold[red]%}➜ %{$fg_bold[green]%}%p%{$fg[cyan]%}%d %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%}% %{$reset_color%}>'
#PROMPT='%{$fg_bold[red]%}➜ %{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'

# 更新
upgrade_oh_my_zsh
uninstall_oh_my_zsh
```

* 组件
    - [plugin](https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins)
    - [zsh-users/zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)：Fish shell like syntax highlighting for Zsh.
    - [zsh-users/zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions):Fish-like autosuggestions for zsh
    - [zsh-users/antigen](https://github.com/zsh-users/antigen):The plugin manager for zsh. http://antigen.sharats.me
    - [unixorn/awesome-zsh-plugins](https://github.com/unixorn/awesome-zsh-plugins):A collection of ZSH frameworks, plugins & themes inspired by the various awesome list collections out there.
* Theme
    - agnoster
    - cloud
    - [denysdovhan/spaceship-prompt](https://github.com/denysdovhan/spaceship-prompt):🚀⭐️ A Zsh prompt for Astronauts https://denysdovhan.com/spaceship-prompt/
* 工具
    - [sindresorhus/pure](https://github.com/sindresorhus/pure):Pretty, minimal and fast ZSH prompt

## grep

全局搜索正则表达式并打印出匹配的行

```sh
grep “string” filename
grep “string” filenameKeyword*
grep 'Ubuntu' *.txt
grep “startingKeyword.*endingKeyword” filename
grep -i “string” filename # 不会考虑搜索字符串是大写还是小写
```

### [fish-shell/fish-shell](https://github.com/fish-shell/fish-shell)

The user-friendly command line shell. http://fishshell.com

* 彩色显示
* 有效路径为下划线
* 光标会给提示:→(选中) 只采纳一部分，可以按下(Alt + →)
* 补全存在的历史记录或猜测可能性(tab选择)

```sh
# 安装
sudo apt-get install fish
brew install fish

# iterm 配置
echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher  // 安装fisherman（fish 的插件管理器）
fisher omf/theme-default
fish # 启动
help # 手册
```

> 配置文件：~/.config/fish/config.fish或者fish_config

```sh
if grep fish /etc/shells
    echo Found fish
else if grep bash /etc/shells
    echo Found bash
else
    echo Got nothing
end

switch (uname)
case Linux
    echo Hi Tux!
case Darwin
    echo Hi Hexley!
case FreeBSD NetBSD DragonFly
    echo Hi Beastie!
case '*'
    echo Hi, stranger!
end

while true
  echo "Loop forever"
end

for file in *.txt
  cp $file $file.bak
end

function ll
  ls -lhG $argv
end

function fish_prompt
  set_color purple
  date "+%m/%d/%y"
  set_color FF0
  echo (pwd) '>'
  set_color normal
end
```

* [fisherman/fisherman](https://github.com/fisherman/fisherman):The fish-shell plugin manager.

### xmonad

所有操作都通过键盘，只适合命令行的重度用户.用来管理软件窗口的位置和大小，会自动在桌面上平铺（tiling）窗口。桌面环境通常很重，窗口管理器就很轻，不仅体积小，资源占用也少，用户可以配置各种细节，释放出系统的最大性能。

  ● 极简主义和高度可配置。默认配置中几乎没有窗户装饰和工具栏，而且可以大范围进行定制。
  ● 面向键盘，友好的用户体验。
  ● 平铺。不必手动排列窗口。
  ● 如果你使用鼠标，光标所在的窗口自动获得焦点。

> 安装

```sh
sudo apt-get install xmonad
sudo apt-get install xmobar dmenu
```

配置文件:～/.xmonad/xmonad.hs。该文件需要用户自己新建 modMask = mod4Mask

> 使用

- 退出当前会话,通过xmonad 会话重新登录,有默认的功能键mod(alt)
- 打开终端:mod + shift + return 新窗口总是独占主栏，旧窗口平分副栏
- 切换布局:mod + space
- 移动副栏到主栏:mod + , 逆操作 mod + .
- 切换栏:mod + j mod + k
- 移动栏位置:mod + return
- 调整窗口顺序 mod + shift + j mod + shift + k
- 调整窗口尺寸: mod + l mod + h
- 该窗口就会变成浮动窗口，可以放到屏幕的任何位置:mod + 鼠标左键拖动窗口
- 调整窗口大小:mod + 鼠标右键
- 当前浮动窗口就会结束浮动，重新回到 xmonad 的布局:mod + t
- 关闭窗口:mod + shift + c
- 工作区切换:mod + 1到mod + 9
- 把光标前的两个词调换一下位置：按一下 esc 键，然后再按一下 t
- 将一个窗口移到不同的工作区，先用mod + j或mod + k，将其变成焦点窗口，然后使用mod + shift + 6，就将其移到了6号工作区(1号工作区是终端，2号是浏览器，4号是虚拟机)

多显示器: xrandr(或者Xinerama 和 winView，另外 arandr 是 xrandr 的图形界面),多显示器时，每个显示器会分配到一个工作区

- 查看显示器的连接情况:xrandr -q
- 转移焦点到左显示器:mod + w
- 转移焦点到右显示器:mod + e

xmobar:提供了一个状态栏，将常用信息显示在上面,配置文件~/.xmobarrc

dmenu 在桌面顶部提供了一个菜单条，可以快速启动应用程序

- mod + p就会进入dmenu菜单栏
- 按下ESC键可以退出
- 方向键用来选择应用程序
- return键用来启动

### iterm2

| 功能                       | mac                |
| -------------------------- | ------------------ |
| 切换tab                    | ⌘+←, ⌘+→, ⌘+{, ⌘+} |
| 直接定位到该 tab           | ⌘+数字             |
| 弹出自动补齐窗口           | ⌘+;                |
| 智能查找，支持正则查找     | ⌘+f                |
| 找到当前的鼠标             | ⌘+/                |
| 弹出历史命令记录窗口       | ⌘+Shift+;          |
| 弹出历史粘贴记录窗口       | ⌘+Shift+h          |
| 可以搜索全屏展示所有的 tab | ⌘+Option+e         |
| 全屏                       | command+enter      |

### 快捷键

* Tab:点击Tab键可以实现命令补全,目录补全、命令参数补全;
* Ctrl+c:强行终止当前程序（常用）;
* Ctrl+d:键盘输入结束或退出终端（常用）;
* Ctrl+s:暂停当前程序，暂停后按下任意键恢复运行;
* Ctrl+z:将当前程序放到后台运行，恢复到前台为命令fg;
* Ctrl+a:将光标移至输入行头，相当于Home键;
* Ctrl+e:将光标移至输入行末，相当于End键;
* Ctrl+k:删除从光标所在位置到行末,常配合ctrl+a使用;
* Alt+Backspace:向前删除一个单词，常配合ctrl+e使用;
* Shift+PgUp:将终端显示向上滚动;
* Shift+PgDn:将终端显示向下滚动;

### 写脚本

```sh
#!/bin/bash
#

#==================
start_mysql() {
    printf "Starting MySQL...\n"
    /etc/rc.d/mysqld start
}
stop_mysql() {
    printf "Stopping MySQL...\n"
    /etc/rc.d/mysqld stop
}
restart_mysql() {
    printf "Restarting MySQL...\n"
    /etc/rc.d/mysqld restart
}
start_php() {
    printf "Starting PHP-FPM...\n"
    ulimit -SHn 65535
    /etc/rc.d/php-fpm start
}
stop_php() {
    printf "Stopping PHP-FPM...\n"
    /etc/rc.d/php-fpm stop
}
restart_php() {
    printf "Restarting PHP-FPM...\n"
    /etc/rc.d/php-fpm restart
}
start_apache2() {
    printf "Starting Apache2...\n"
    /etc/rc.d/httpd start
}
stop_apache2() {
    printf "Stopping Apache2...\n"
    /etc/rc.d/httpd stop
}
restart_apache2() {
    printf "Restarting Apache2...\n"
    /etc/rc.d/httpd restart
}
start_nginx() {
    printf "Starting Nginx...\n"
    /etc/rc.d/nginx start
}
stop_nginx() {
    printf "Stopping Nginx...\n"
    /etc/rc.d/nginx stop
}
restart_nginx() {
    printf "Restarting Nginx...\n"
    /etc/rc.d/nginx restart
}
start_lighttpd() {
    printf "Starting LigHttpd...\n"
    /etc/rc.d/lighttpd start
}
stop_lighttpd() {
    printf "Stopping LigHttpd...\n"
    /etc/rc.d/lighttpd stop
}
restart_lighttpd() {
    printf "Restarting LigHttpd...\n"
    /etc/rc.d/lighttpd restart
}
#==================

echo "Choose instance:"
echo "1. nginx + php-fpm + mysqld + postfix"
echo "2. lighttpd + php-fpm + mysqld + postfix"
echo "3. apache2 + php + mysql + postfix"
read num
    case $num in
        1)
            echo "nginx + php-fpm + mysqld"
            echo "Choose instance:"
            echo "1. start"
            echo "2. stop"
            echo "3. restart"
            read num
                case $num in
                    1)
                        start_mysql
                        start_php
                        start_nginx
                        ;;
                    2)
                        stop_mysql
                        stop_php
                        stop_nginx
                        ;;
                    3)
                        restart_mysql
                        restart_php
                        restart_nginx
                        ;;
                    *)
                        echo "Wrong number, please re-run and choose again."
                        ;;
                esac
            exit 0
            ;;
        2)
            echo "lighttpd + php-fastcgi + mysqld"
            echo "Choose instance:"
            echo "1. start"
            echo "2. stop"
            echo "3. restart"
            read num
                case $num in
                    1)
                        start_mysql
                        start_lighttpd
                        ;;
                    2)
                        stop_mysql
                        stop_lighttpd
                        ;;
                    3)
                        restart_mysql
                        restart_lighttpd
                        ;;
                    *)
                        echo "Wrong number, please re-run and choose again."
                        ;;
                esac
            exit 0
            ;;
        3)
            echo "apache2 + php + mysqld"
            echo "Choose instance:"
            echo "1. start"
            echo "2. stop"
            echo "3. restart"
            read num
                case $num in
                    1)
                        start_mysql
                        start_apache2
                        ;;
                    2)
                        stop_mysql
                        stop_apache2
                        ;;
                    3)
                        restart_mysql
                        restart_apache2
                        ;;
                    *)
                        echo "Wrong number, please re-run and choose again."
                        ;;
                esac
            exit 0
            ;;
        *)
            echo " Wrong number, please re-run and choose again."
            ;;
    esac
exit 0

# vim:set ts=4 sw=4 ft=sh et:
```

### terminator

```sh
sudo apt-get install terminator #  depend python version too old
```

### 跳板机

```sh
# 方法一
ssh 目标机器登录用户@目标机器IP -p 目标机器端口 -o ProxyCommand='ssh -p 跳板机端口 跳板机登录用户@跳板机IP -W %h:%p'

# 在 $HOME/.ssh 目录下建立/修改文件 config
Host tiaoban   #任意名字，随便使用
    HostName 192.168.1.1   #这个是跳板机的IP，支持域名
    Port 22      #跳板机端口
    User username_tiaoban       #跳板机用户

Host nginx      #同样，任意名字，随便起
    HostName 192.168.1.2  #真正登陆的服务器，不支持域名必须IP地址
    Port 22   #服务器的端口
    User username   #服务器的用户
    ProxyCommand ssh username_tiaoban@tiaoban -W %h:%p

Host 10.10.0.*      #可以用*通配符
    Port 22   #服务器的端口
    User username   #服务器的用户
    ProxyCommand ssh username_tiaoban@tiaoban -W %h:%p
```

## tac

```sh
brew install coreutils
ln -s /usr/local/bin/gtac /usr/local/bin/tac
```

## 分类

* mosh

## 免密码登录

~/.ssh

* authorized_keys:存放远程免密登录的公钥,主要通过这个文件记录多台机器的公钥
* id_rsa : 生成的私钥文件
* id_rsa.pub ： 生成的公钥文件
* know_hosts : 已知的主机公钥清单　
* 如果希望ssh公钥生效需满足至少下面两个条件：
    - .ssh目录的权限必须是700
    - .ssh/authorized_keys文件权限必须是600

```sh
ssh-keygen -t rsa # 生成.ssh文件目录

ssh-copy-id -i ~/.ssh/id_rsa.pub <romte_ip>
scp -p ~/.ssh/id_rsa.pub root@<remote_ip>:/root/.ssh/authorized_keys

scp ~/.ssh/id_rsa.pub root@<remote_ip>:pub_key //将文件拷贝至远程服务器
cat ~/pub_key >>~/.ssh/authorized_keys //将内容追加到authorized_keys文件中， 不过要登录远程服务器来执行这条命令

# 通过ansible,将需要做免密操作的机器hosts添加到/etc/ansible/hosts下：
[Avoid close]
192.168.91.132
192.168.91.133
192.168.91.134

ansible <groupname> -m authorized_key -a "user=root key='{{ lookup('file','/root/.ssh/id_rsa.pub') }}'" -k
```

## [Hyper](https://hyper.is)

### Konsole

* 搜索/高亮功能。高亮匹配是实时刷新的，这对于拖尾日志文件真的很方便。
* 易于选择和复制文本块。
* 简单选择屏幕滚动，使用CTRL + SHIFT + K清理缓冲区。
* 可自定义隐藏大部分不必要的细节（标签栏、菜单），默认提供许多颜色主题

## 实例

* 开头加解释器：#!/bin/bash
* 语法缩进，使用四个空格；多加注释说明。
* 命名建议规则：变量名大写、局部变量小写，函数名小写，名字体现出实际作用。
* 默认变量是全局的，在函数中变量local指定为局部变量，避免污染其他作用域。
* 有两个命令能帮助我调试脚本：set -e 遇到执行非0时退出脚本，set-x 打印执行过程。
* 写脚本一定先测试再到生产上。

```sh
# 获取随机字符串或数字
## 获取随机8位字符串：
# echo $RANDOM |md5sum |cut -c 1-8 # 471b94f2
# openssl rand -base64 4
# cat /proc/sys/kernel/random/uuid |cut -c 1-8

## 获取随机8位数字：
# echo $RANDOM |cksum |cut -c 1-8  # cksum：打印CRC效验和统计字节
# openssl rand -base64 4 |cksum |cut -c 1-8
# date +%N |cut -c 1-8

# 定义一个颜色输出字符串函数

#方法1：
function echo_color() {

    if [ $1 == "green" ]; then

        echo -e "\033[32;40m$2\033[0m"

    elif [ $1 == "red" ]; then

        echo -e "\033[31;40m$2\033[0m"

    fi

}

# 方法2：
function echo_color() {

    case $1 in

        green)

            echo -e "\033[32;40m$2\033[0m"

            ;;

        red)

            echo -e "\033[31;40m$2\033[0m"

            ;;

        *)

            echo "Example: echo_color red string"

    esac

}

使用方法：echo_color green "test"

function关键字定义一个函数，可加或不加。

# 批量创建用户

#!/bin/bash

DATE=$(date +%F_%T)

USER_FILE=user.txt

echo_color(){

    if [ $1 == "green" ]; then

        echo -e "\033[32;40m$2\033[0m"

    elif [ $1 == "red" ]; then

        echo -e "\033[31;40m$2\033[0m"

    fi

}

# 如果用户文件存在并且大小大于0就备份

if [ -s $USER_FILE ]; then

    mv $USER_FILE ${USER_FILE}-${DATE}.bak

    echo_color green "$USER_FILE exist, rename ${USER_FILE}-${DATE}.bak"

fi

echo -e "User\tPassword" >> $USER_FILE

echo "----------------" >> $USER_FILE

for USER in user{1..10}; do

    if ! id $USER &>/dev/null; then

        PASS=$(echo $RANDOM |md5sum |cut -c 1-8)

        useradd $USER

        echo $PASS |passwd --stdin $USER &>/dev/null

        echo -e "$USER\t$PASS" >> $USER_FILE

        echo "$USER User create successful."

    else

        echo_color red "$USER User already exists!"

    fi

done

# 检查软件包是否安装

#!/bin/bash

if rpm -q sysstat &>/dev/null; then

    echo "sysstat is already installed."

else

    echo "sysstat is not installed!"

fi

# 检查服务状态

#!/bin/bash

PORT_C=$(ss -anu |grep -c 123)

PS_C=$(ps -ef |grep ntpd |grep -vc grep)

if [ $PORT_C -eq 0 -o $PS_C -eq 0 ]; then

    echo "内容" | mail -s "主题" dst@example.com

fi

# 检查主机存活状态

方法1：将错误IP放到数组里面判断是否ping失败三次

#!/bin/bash

IP_LIST="192.168.18.1 192.168.1.1 192.168.18.2"

for IP in $IP_LIST; do

    NUM=1

    while [ $NUM -le 3 ]; do

        if ping -c 1 $IP > /dev/null; then

            echo "$IP Ping is successful."

            break

        else

            # echo "$IP Ping is failure $NUM"

            FAIL_COUNT[$NUM]=$IP

            let NUM++

        fi

    done

    if [ ${#FAIL_COUNT[*]} -eq 3 ];then

        echo "${FAIL_COUNT[1]} Ping is failure!"

        unset FAIL_COUNT[*]

    fi

done

方法2：将错误次数放到FAIL_COUNT变量里面判断是否ping失败三次

#!/bin/bash

IP_LIST="192.168.18.1 192.168.1.1 192.168.18.2"

for IP in $IP_LIST; do

    FAIL_COUNT=0

    for ((i=1;i<=3;i++)); do

        if ping -c 1 $IP >/dev/null; then

            echo "$IP Ping is successful."

            break

        else

            # echo "$IP Ping is failure $i"

            let FAIL_COUNT++

        fi

    done

    if [ $FAIL_COUNT -eq 3 ]; then

        echo "$IP Ping is failure!"

    fi

done

方法3：利用for循环将ping通就跳出循环继续，如果不跳出就会走到打印ping失败

#!/bin/bash

ping_success_status() {

    if ping -c 1 $IP >/dev/null; then

        echo "$IP Ping is successful."

        continue

    fi

}

IP_LIST="192.168.18.1 192.168.1.1 192.168.18.2"

for IP in $IP_LIST; do

    ping_success_status

    ping_success_status

    ping_success_status

    echo "$IP Ping is failure!"

done

# 监控CPU、内存和硬盘利用率

1）CPU

借助vmstat工具来分析CPU统计信息。

#!/bin/bash

DATE=$(date +%F" "%H:%M)

IP=$(ifconfig eth0 |awk -F '[ :]+' '/inet addr/{print $4}')  # 只支持CentOS6

MAIL="example@mail.com"

if ! which vmstat &>/dev/null; then

    echo "vmstat command no found, Please install procps package."

    exit 1

fi

US=$(vmstat |awk 'NR==3{print $13}')

SY=$(vmstat |awk 'NR==3{print $14}')

IDLE=$(vmstat |awk 'NR==3{print $15}')

WAIT=$(vmstat |awk 'NR==3{print $16}')

USE=$(($US+$SY))

if [ $USE -ge 50 ]; then

    echo "

    Date: $DATE

    Host: $IP

    Problem: CPU utilization $USE

    " | mail -s "CPU Monitor" $MAIL

fi

2）内存

#!/bin/bash

DATE=$(date +%F" "%H:%M)

IP=$(ifconfig eth0 |awk -F '[ :]+' '/inet addr/{print $4}')

MAIL="example@mail.com"

TOTAL=$(free -m |awk '/Mem/{print $2}')

USE=$(free -m |awk '/Mem/{print $3-$6-$7}')

FREE=$(($TOTAL-$USE))

# 内存小于1G发送报警邮件

if [ $FREE -lt 1024 ]; then

    echo "

    Date: $DATE

    Host: $IP

    Problem: Total=$TOTAL,Use=$USE,Free=$FREE

    " | mail -s "Memory Monitor" $MAIL

fi

3）硬盘

#!/bin/bash

DATE=$(date +%F" "%H:%M)

IP=$(ifconfig eth0 |awk -F '[ :]+' '/inet addr/{print $4}')

MAIL="example@mail.com"

TOTAL=$(fdisk -l |awk -F'[: ]+' 'BEGIN{OFS="="}/^Disk \/dev/{printf "%s=%sG,",$2,$3}')

PART_USE=$(df -h |awk 'BEGIN{OFS="="}/^\/dev/{print $1,int($5),$6}')

for i in $PART_USE; do

    PART=$(echo $i |cut -d"=" -f1)

    USE=$(echo $i |cut -d"=" -f2)

    MOUNT=$(echo $i |cut -d"=" -f3)

    if [ $USE -gt 80 ]; then

        echo "

        Date: $DATE

        Host: $IP

        Total: $TOTAL

        Problem: $PART=$USE($MOUNT)

        " | mail -s "Disk Monitor" $MAIL

    fi

done

# 批量主机磁盘利用率监控:前提监控端和被监控端SSH免交互登录或者密钥登录。写一个配置文件保存被监控主机SSH连接信息，文件内容格式：IP User Port
#!/bin/bash

HOST_INFO=host.info

for IP in $(awk '/^[^#]/{print $1}' $HOST_INFO); do

    USER=$(awk -v ip=$IP 'ip==$1{print $2}' $HOST_INFO)

    PORT=$(awk -v ip=$IP 'ip==$1{print $3}' $HOST_INFO)

    TMP_FILE=/tmp/disk.tmp

    ssh -p $PORT $USER@$IP 'df -h' > $TMP_FILE

    USE_RATE_LIST=$(awk 'BEGIN{OFS="="}/^\/dev/{print $1,int($5)}' $TMP_FILE)

    for USE_RATE in $USE_RATE_LIST; do

        PART_NAME=${USE_RATE%=*}

        USE_RATE=${USE_RATE#*=}

        if [ $USE_RATE -ge 80 ]; then

            echo "Warning: $PART_NAME Partition usage $USE_RATE%!"

        fi

    done

done

# 检查网站可用性

1）检查URL可用性

方法1：

check_url() {

    HTTP_CODE=$(curl -o /dev/null --connect-timeout 3 -s -w "%{http_code}" $1)

    if [ $HTTP_CODE -ne 200 ]; then

        echo "Warning: $1 Access failure!"

    fi

}

方法2：

check_url() {

if ! wget -T 10 --tries=1 --spider $1 >/dev/null 2>&1; then

#-T超时时间，--tries尝试1次，--spider爬虫模式

        echo "Warning: $1 Access failure!"

    fi

}

使用方法：check_url www.baidu.com

2）判断三次URL可用性

思路与上面检查主机存活状态一样。

方法1：利用循环技巧，如果成功就跳出当前循环，否则执行到最后一行

#!/bin/bash

check_url() {

    HTTP_CODE=$(curl -o /dev/null --connect-timeout 3 -s -w "%{http_code}" $1)

    if [ $HTTP_CODE -eq 200 ]; then

        continue

    fi

}

URL_LIST="www.baidu.com www.agasgf.com"

for URL in $URL_LIST; do

    check_url $URL

    check_url $URL

    check_url $URL

    echo "Warning: $URL Access failure!"

done
--------------------------------------------------------------------------------
# 方法2：错误次数保存到变量

#!/bin/bash

URL_LIST="www.baidu.com www.agasgf.com"

for URL in $URL_LIST; do

    FAIL_COUNT=0

    for ((i=1;i<=3;i++)); do

        HTTP_CODE=$(curl -o /dev/null --connect-timeout 3 -s -w "%{http_code}" $URL)

        if [ $HTTP_CODE -ne 200 ]; then

            let FAIL_COUNT++

        else

            break

        fi

    done

    if [ $FAIL_COUNT -eq 3 ]; then

        echo "Warning: $URL Access failure!"

    fi

done
--------------------------------------------------------------------------------
# 方法3：错误次数保存到数组

#!/bin/bash

URL_LIST="www.baidu.com www.agasgf.com"

for URL in $URL_LIST; do

    NUM=1

    while [ $NUM -le 3 ]; do

        HTTP_CODE=$(curl -o /dev/null --connect-timeout 3 -s -w "%{http_code}" $URL)

        if [ $HTTP_CODE -ne 200 ]; then

            FAIL_COUNT[$NUM]=$IP  #创建数组，以$NUM下标，$IP元素

            let NUM++

        else

            break

        fi

    done

    if [ ${#FAIL_COUNT[*]} -eq 3 ]; then

        echo "Warning: $URL Access failure!"

        unset FAIL_COUNT[*]    #清空数组

    fi

done

#检查MySQL主从同步状态
#!/bin/bash

USER=bak

PASSWD=123456

IO_SQL_STATUS=$(mysql -u$USER -p$PASSWD -e 'show slave status\G' |awk -F: '/Slave_.*_Running/{gsub(": ",":");print $0}')  #gsub去除冒号后面的空格

for i in $IO_SQL_STATUS; do

    THREAD_STATUS_NAME=${i%:*}

    THREAD_STATUS=${i#*:}

    if [ "$THREAD_STATUS" != "Yes" ]; then

        echo "Error: MySQL Master-Slave $THREAD_STATUS_NAME status is $THREAD_STATUS!"

    fi

done
```

## 配置

* [direnv/direnv](https://github.com/direnv/direnv):Unclutter your .profile http://direnv.net

## terminal

- putty
- xshell6
- [FinalShell](http://www.hostbuf.com/)
- WinSSHTerm
- KiTTY
- ZOC Terminal
- MobaXterm
- Terminus
- Console2
- cmder
- ConEmu
- [Eugeny/terminus](https://github.com/Eugeny/terminus):A terminal for a more modern age https://eugeny.github.io/terminus/
* [msys2](http://www.msys2.org/)
* powercmd
* [cmder + gow](http://bliker.github.io/cmder/)
* git bash
* [Babun](http://babun.github.io/)
* [lukesampson/scoop](https://github.com/lukesampson/scoop):A command-line installer for Windows. https://scoop.sh
* [railsware/upterm](https://github.com/railsware/upterm):A terminal emulator for the 21st century.

## 教程

* [learnbyexample/command-line-text-processing](https://github.com/learnbyexample/Command-line-text-processing):⚡️ From finding text to search and replace, from sorting to beautifying text and more 🎨
* [learnbyexample/Linux_command_line](https://github.com/learnbyexample/Linux_command_line):💻 Introduction to Linux commands and Shell scripting
* [learnbyexample/scripting_course](https://github.com/learnbyexample/scripting_course):📓 A reference guide to Linux command line, Vim and Scripting https://learnbyexample.github.io/scripting_course/

## 扩展

* shellcheck：shell脚本静态检查工具，能够识别语法错误以及不规范的写法。
* yapf：Google开发的python代码格式规范化工具，支持pep8以及Google代码风格。
* mosh：基于UDP的终端连接，可以替代ssh，连接更稳定，即使IP变了，也能自动重连。
* PathPicker(fpp):在命令行输出中自动识别目录和文件，支持交互式，配合git非常有用
* sz/rz：交互式文件传输，在多重跳板机下传输文件非常好用，不用一级一级传输。
* ccache：高速C/C++编译缓存工具，反复编译内核非常有用。使用起来也非常方便
* tmux：终端复用工具，替代screen、nohup
* neovim: 替代vim。
* script/scriptreplay: 终端会话录制。

```sh
cat demo.json | jq '.id,.name,.status,.attachments'

axel -n 20 http://centos.ustc.edu.cn/centos/7/isos/x86_64/CentOS-7-x86_64-Minimal-1511.iso
ccache gcc foo.c
```

## 工具

* help
    - [idank/explainshell](https://github.com/idank/explainshell):match command-line arguments to their help text
* 查看
    * [sharkdp/bat](https://github.com/sharkdp/bat):A cat(1) clone with wings.
* 搜索
    - ag：比grep、ack更快的递归搜索文件内容
    - fzf：命令行下模糊搜索工具，能够交互式智能搜索并选取文件或者内容，配合终端ctrl-r历史命令搜索简直完美。
* monitor
    - top:查看在系统中运行的进程或线程,默认是以 CPU 进行排序的
    - [htop](http://hisham.hm/htop/): 提供更美观、更方便的进程监控工具
    - [atop](http://www.atoptool.nl/):按日记录进程的日志供以后分析。它也能显示所有进程的资源消耗。它还会高亮显示已经达到临界负载的资源。
    - [apachetop](https://github.com/JeremyJones/Apachetop) 会监控 apache 网络服务器的整体性能。它主要是基于 mytop。它会显示当前的读取进程、写入进程的数量以及请求进程的总数。
    - [ftptop](http://www.proftpd.org/docs/howto/Scoreboard.html) 给你提供了当前所有连接到 ftp 服务器的基本信息，如会话总数，正在上传和下载的客户端数量以及客户端是谁。
    - [mytop](http://jeremy.zawodny.com/mysql/mytop/) 是一个很简洁的工具，用于监控 mysql 的线程和性能。它能让你实时查看数据库以及正在处理哪些查询。
    - [powertop](https://01.org/powertop) 可以帮助你诊断与电量消耗和电源管理相关的问题。它也可以帮你进行电源管理设置，以实现对你服务器最有效的配置。你可以使用 tab 键切换选项卡
    - [iotop](http://guichaz.free.fr/iotop/) 用于检查 I/O 的使用情况，并为你提供了一个类似 top 的界面来显示。它按列显示读和写的速率，每行代表一个进程。当发生交换或 I/O 等待时，它会显示进程消耗时间的百分比。
    - [ntopng]( http://www.ntop.org/products/ntop/) 是 ntop 的升级版，它提供了一个能通过浏览器进行网络监控的图形用户界面。它还有其他用途，如：地理定位主机，显示网络流量和 ip 流量分布并能进行分析。
    - [iftop](http://www.ex-parrot.com/pdw/iftop/) 类似于 top，但它主要不是检查 cpu 的使用率而是监听所选择网络接口的流量，并以表格的形式显示当前的使用量。像“为什么我的网速这么慢呢？！”这样的问题它可以直接回答。
    - [jnettop](http://jnettop.kubs.info/wiki/) 以相同的方式来监测网络流量但比 iftop 更形象。它还支持自定义的文本输出，并能以友好的交互方式来深度分析日志。
    - [BandwidthD](http://bandwidthd.sourceforge.net/) 可以跟踪 TCP/IP 网络子网的使用情况，并能在浏览器中通过 png 图片形象化地构建一个 HTML 页面。它有一个数据库系统，支持搜索、过滤，多传感器和自定义报表。
    - [EtherApe](http://etherape.sourceforge.net/) 以图形化显示网络流量，可以支持更多的节点。它可以捕获实时流量信息，也可以从 tcpdump 进行读取。也可以使用 pcap 格式的网络过滤器来显示特定信息。
    - [ethtool](https://www.kernel.org/pub/software/network/ethtool/) 用于显示和修改网络接口控制器的一些参数。它也可以用来诊断以太网设备，并获得更多的统计数据。
    - [NetHogs]( http://nethogs.sourceforge.net/) 打破了网络流量按协议或子网进行统计的惯例，它以进程来分组。所以，当网络流量猛增时，你可以使用 NetHogs 查看是由哪个进程造成的。
    - [iptraf](http://iptraf.seul.org/) 收集的各种指标，如 TCP 连接数据包和字节数，端口统计和活动指标，TCP/UDP 通信故障，站内数据包和字节数。
    - [ngrep](http://ngrep.sourceforge.net/) 就是网络层的 grep。它使用 pcap ，允许通过指定扩展正则表达式或十六进制表达式来匹配数据包。
    - [MRTG](http://oss.oetiker.ch/mrtg/) 最初被开发来监控路由器的流量，但现在它也能够监控网络相关的东西。它每五分钟收集一次，然后产生一个 HTML 页面。它还具有发送邮件报警的能力。
    - [bmon](https://github.com/tgraf/bmon/) 能监控并帮助你调试网络。它能捕获网络相关的统计数据，并以友好的方式进行展示。你还可以与 bmon 通过脚本进行交互。
    - traceroute是一个内置工具，能显示路由和测量数据包在网络中的延迟。
    - [IPTState](http://www.phildev.net/iptstate/index.shtml) 可以让你观察流量是如何通过 iptables，并通过你指定的条件来进行排序。该工具还允许你从 iptables 的表中删除状态信息。
    - [darkstat](https://unix4lyfe.org/darkstat/) 能捕获网络流量并计算使用情况的统计数据。该报告保存在一个简单的 HTTP 服务器中，它为你提供了一个非常棒的图形用户界面。
    - [vnStat]( http://humdi.net/vnstat/) 是一个网络流量监控工具，它的数据统计是由内核进行提供的，其消耗的系统资源非常少。系统重新启动后，它收集的数据仍然存在。有艺术感的系统管理员可以使用它的颜色选项。
    - netstat 是一个内置的工具，它能显示 TCP 网络连接，路由表和网络接口数量，被用来在网络中查找问题。
    - ss 命令能够显示的信息比 netstat 更多，也更快。如果你想查看统计结果的总信息，你可以使用命令 ss -s
    - [Nmap](http://nmap.org/) 可以扫描你服务器开放的端口并且可以检测正在使用哪个操作系统。但你也可以将其用于 SQL 注入漏洞、网络发现和渗透测试相关的其他用途。
    - [MTR](http://www.bitwizard.nl/mtr/) 将 traceroute 和 ping 的功能结合到了一个网络诊断工具上。当使用该工具时，它会限制单个数据包的跳数，然后监视它们的到期时到达的位置。然后每秒进行重复。
    - [Tcpdump](http://www.tcpdump.org/) 将按照你在命令行中指定的表达式输出匹配捕获到的数据包的信息。你还可以将此数据保存并进一步分析。
    - [Justniffer](http://justniffer.sourceforge.net/) 是 tcp 数据包嗅探器。使用此嗅探器你可以选择收集低级别的数据还是高级别的数据。它也可以让你以自定义方式生成日志。比如模仿 Apache 的访问日志。
* man
    * [tldr-pages/tldr](https://github.com/tldr-pages/tldr): books Simplified and community-driven man pages http://tldr-pages.github.io/
* hex
    - [sharkdp/hexyl](https://github.com/sharkdp/hexyl):A command-line hex viewer
* git
    * [arialdomartini/oh-my-git](https://github.com/arialdomartini/oh-my-git)
    * tig：字符模式下交互查看git项目，可以替代git命令。
* download
    - you-get: 非常强大的媒体下载工具，支持youtube、google+、优酷、芒果TV、腾讯视频、秒拍等视频下载。
    - axel：多线程下载工具，下载文件时可以替代curl、wget。
* prompt
    - [b-ryan/powerline-shell](https://github.com/b-ryan/powerline-shell):A beautiful and useful prompt for your shell
* sql
    - mycli：mysql客户端，支持语法高亮和命令补全，效果类似ipython，可以替代mysql命令。
* json
    - jq: json文件处理以及格式化显示，支持高亮，可以替换python -m json.tool。
* 代码统计
    - cloc：代码统计工具，能够统计代码的空行数、注释行、编程语言。
* benchmark
    - [sharkdp/hyperfine](https://github.com/sharkdp/hyperfine):A command-line benchmarking tool
* [svenstaro/genact](https://github.com/svenstaro/genact):🌀 A nonsense activity generator https://svenstaro.github.io/genact/
* [kentcdodds/cross-env](https://github.com/kentcdodds/cross-env):🔀 Cross platform setting of environment scripts https://www.npmjs.com/package/cross-env
* [Swordfish90/cool-retro-term](https://github.com/Swordfish90/cool-retro-term):A good looking terminal emulator which mimics the old cathode display...
* [nvbn/thefuck](https://github.com/nvbn/thefuck):Magnificent app which corrects your previous console command.
* [mixn/carbon-now-cli](https://github.com/mixn/carbon-now-cli):🎨 Beautiful images of your code — from right inside your terminal.
* [faressoft/terminalizer](https://github.com/faressoft/terminalizer):🦄 Record your terminal and generate animated gif images
* [niieani/bash-oo-framework](https://github.com/niieani/bash-oo-framework):Bash Infinity is a modern boilerplate / framework / standard library for bash
* [ericfreese/rat](https://github.com/ericfreese/rat):Compose shell commands to build interactive terminal applications
* [kovidgoyal/kitty](https://github.com/kovidgoyal/kitty):A cross-platform, fast, feature full, GPU based terminal emulator
* 自动更正命令
    - [nvbn/thefuck](https://github.com/nvbn/thefuck):Magnificent app which corrects your previous console command.
* [idank/explainshell](https://github.com/idank/explainshell):match command-line arguments to their help text
* [sindresorhus/fkill-cli](https://github.com/sindresorhus/fkill-cli):Fabulously kill processes. Cross-platform.
* [tartley/colorama](https://github.com/tartley/colorama):Simple cross-platform colored terminal text in Python
* [dylanaraps/fff](https://github.com/dylanaraps/fff):🚀 fucking fast file-manager
* [jmacdonald/amp](https://github.com/jmacdonald/amp):A complete text editor for your terminal. https://amp.rs
* [liamg/aminal](https://github.com/liamg/aminal):Golang terminal emulator from scratch
* [amanusk/s-tui](https://github.com/amanusk/s-tui):Terminal based CPU stress and monitoring utility https://amanusk.github.io/s-tui/
* [GitSquared/edex-ui](https://github.com/GitSquared/edex-ui):A science fiction terminal emulator designed for large touchscreens that runs on all major OSs.
* [rupa/z](https://github.com/rupa/z):z - jump around

## 参考

* [dylanaraps/pure-bash-bible](https://github.com/dylanaraps/pure-bash-bible):📖 A collection of pure bash alternatives to external processes.
* [alebcay/awesome-shell](https://github.com/alebcay/awesome-shell)：A curated list of awesome command-line frameworks, toolkits, guides and gizmos. Inspired by awesome-php.
* [窗口管理器 xmonad 教程](http://www.ruanyifeng.com/blog/2017/07/xmonad.html)
