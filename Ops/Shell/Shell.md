# Shell

Shell是Linux/Unix的一个外壳。它负责外界与Linux内核的交互，接收用户或其他应用程序的命令，然后把这些命令转化成内核能理解的语言，传给内核，内核是真正干活的，干完之后再把结果返回用户或应用程序。

## 配置

* /etc/profile：所有用户的shell都有权使用你配置好的环境变量 添加 export PATH="$PATH:/my_new_path"
* bash_profile  ~/.bashrc 当用户登录时，该文件仅仅执行一次。用来设置环境变量 功能和/etc/profile 相同只不过 他指针对用户来设定,需要source 生效或者退出后生效
    - 如果ssh方式远程登录Linux时，会自动执行用户家目录下的.bash_profile文件，所有可以在这个文件里面添加一些内容，以便ssh登录Linux时都会执行相应的内容。
* /etc/vim/.vimrc # vim的root用户配置文件
* ～/.vimrc # 针对当前用户的配置
* ~/.zshrc：zsh配置文件
* PATH="$PATH:/my_new_path":临时添加，关闭后失效

```sh
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

### zsh

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

#### oh my zsh

* plugin
* themes

```sh
# 自动安装
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh

# 手动
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

chsh -s /bin/zsh # 修改系统bash
source ~/.bashrc # 运行

zsh # 切换zsh
bash # 切换 bash
```

> 配置： home目录的.zshrc(不用单配，插件配置有)

```
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

ZSH_THEME="robbyrussell" # 主题设置（文件在~/.oh-my-zsh/themes）

# 插件
plugins=(git textmate ruby autojump osx mvn gradle autojump)
```

```
PROMPT='%{$fg_bold[red]%}➜ %{$fg_bold[green]%}%p%{$fg[cyan]%}%d %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%}% %{$reset_color%}>'
#PROMPT='%{$fg_bold[red]%}➜ %{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'
```

### fish

the friendly interactive shell

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

```
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

所有操作都通过键盘，只适合命令行的重度用户.用来管理软件窗口的位置和大小，会自动在桌面上平铺（tiling）窗口。桌面环境通常很重，窗口管理器就很轻，不仅体积小，资源占用也少，用户可以配置各种细节，释放出系统的最大性能。

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

### 添加变量

echo 'export PATH="/usr/local/sbin:$PATH"' >> ~/.zshrc

### iterm2

|   功能   | mac         |
|----------|----------|
| 切换tab | ⌘+←, ⌘+→, ⌘+{, ⌘+} |
| 直接定位到该 tab| ⌘+数字 |
| 弹出自动补齐窗口| ⌘+; |
| 智能查找，支持正则查找| ⌘+f |
| 找到当前的鼠标 | ⌘+/ |
| 弹出历史命令记录窗口 | ⌘+Shift+; |
|弹出历史粘贴记录窗口 |⌘+Shift+h |
|可以搜索全屏展示所有的 tab|⌘+Option+e|
|全屏| command+enter|

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

## 参考

* [fisherman/fisherman](https://github.com/fisherman/fisherman):The fish-shell plugin manager. 
* [robbyrussell/oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh):A delightful community-driven (with 1,000+ contributors) framework for managing your zsh configuration. Includes 200+ optional plugins (rails, git, OSX, hub, capistrano, brew, ant, php, python, etc), over 140 themes to spice up your morning, and an auto-update tool so that makes it easy to keep up with the latest updates from the community. 
* [arialdomartini/oh-my-git](https://github.com/arialdomartini/oh-my-git)
* [窗口管理器 xmonad 教程](http://www.ruanyifeng.com/blog/2017/07/xmonad.html)
* [alebcay/awesome-shell](https://github.com/alebcay/awesome-shell)
