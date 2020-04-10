# Shell

Shell是Linux/Unix的一个外壳。隐藏了操作系统底层的细节,作为命令解析器负责外界与Linux内核的交互，接收用户或其他应用程序的命令，然后把这些命令转化成内核能理解的语言，传给内核，内核是真正干活的，干完之后再把结果返回用户或应用程序。

* 支持模糊匹配符
* 每次bash会生成子shell进程，只有部分父进程的环境被复制到子shell环境中
* 利用exit命令有条不紊地退出子shell
* 命令列 表要想成为进程列表，这些命令必须包含在括号里 `(pwd ; ls ; cd /etc ; pwd ; cd ; pwd ; ls)` 生成了一个子shell来执行对应的命令
* 要想知道是否生成了子shell，得借助一个使用了环境变量的命令。这个命令就是echo $BASH_SUBSHELL。如果该命令返回0，就表明没有子shell。如果返回 1或者其他更大的数字，就表明存在子shell。 `( pwd ; echo $BASH_SUBSHELL)`
* sleep命令会在后台(&)睡眠3000秒(50分钟)。当它被置入后台，在shell CLI提示符返回 之前，会出现两条信息。第一条信息是显示在方括号中的后台作业(background job)号(1)。 第二条是后台作业的进程ID(2396)。
* `jobs -l`:将进程列表置入后台模式。你既可以在子shell中 进行繁重的处理工作，同时也不会让子shell的I/O受制于终端
* 生成子shell的成本不低，而且速度还慢。创建嵌套子shell更是火上浇油

## 配置

* /etc/profile：所有用户的shell都有权使用配置好的环境变量 不管是哪个用户，登录时都会读取该文件.建议不修改这个文件
* /etc/bashrc:全局（公有）配置，bash shell执行时，不管是何种方式，都会读取此文件. 在这个文件中添加系统级环境变量
* bash_profile  ~/.bashrc 用户登录时，该文件仅仅执行一次。用来设置环境变量功能和/etc/profile 相同只不过只针对用户来设定
    - ~/.bash_profile:一般在这个文件中添加用户级环境变量
    - 如果ssh方式远程登录Linux时，会自动执行用户家目录下的.bash_profile文件，所有可以在这个文件里面添加一些内容，以便ssh登录Linux时都会执行相应的内容。
* ~/.zshrc：zsh配置文件
* `echo PATH="$PATH:/my_new_path"`:临时添加，关闭后失效
* 选项如果单字符选项前使用一个减号-。单词选项前使用两个减号--
* alias参考
    - https://www.cyberciti.biz/tips/bash-aliases-mac-centos-linux-unix.html
    - https://www.digitalocean.com/community/questions/what-are-your-favorite-bash-aliases
    - https://www.linuxtrainingacademy.com/23-handy-bash-shell-aliases-for-unix-linux-and-mac-os-x/
    - https://brettterpstra.com/2013/03/31/a-few-more-of-my-favorite-shell-aliases/
* 参考
    - https://dev.to/_darrenburns/10-tools-to-power-up-your-command-line-4id4
    - https://dev.to/_darrenburns/tools-to-power-up-your-command-line-part-2-2737
    - https://dev.to/_darrenburns/power-up-your-command-line-part-3-4o53
    - https://darrenburns.net/posts/tools/
    - https://hacker-tools.github.io/

```sh
cmd [options] [arguments] # options称为选项，arguments称为参数

echo $SHELL # 查看shell

/* 如果vim还没有语法高亮，那么在/etc/profile 中添加以下语句 */
export TERM=xterm-color
// 注: 只对各个用户自己的主目录下的.vimrc修改的话，修改内容只对本用户有效,要想全部有效，可以修改 /etc/vimrc           
# 同样的 /etc/bashrc 是针对所有用户的启动文件

# ~/.vimrc
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
set laststatus=2     # 开启状态栏(默认是1)
set smartindent     # 开启新航时使用智能自动缩进
set hlsearch     # 搜索时高亮显示找到的文本
set wrap     # 设置自动换行
set tabstop=4     # 设置缩进为4个空格
set softtabstop=4
set shiftwidth=4
filetype on     # 检测文件类型
set history=500     # 设置历史行数
set smartindent     # 理想添加 依据上面的格式自动对齐

ls /usr/share/vim/vim72/colors/  # 可以查看vim支持的主题色

/* 目录配色方案(将/etc中的DIR_COLORS文件复制到自己主目录中，并重命名为.dir_colors) */
cp /etc/DIR_COLORS ~/.dir_colors

/* PS1 用户主提示符配色方案(在 .bashrc 文件中添加) */
export PS1="\[\e[0;36m\]\u\[\e[m\]@\[\e[0;32m\]\h: \[\e[0;35m\]\W\[\e[m\] \\$"

// 另外种等效写法
# PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h: \[\033[35m\]\W\[\033[m\] \\$  "
# export PS1

// 另外种主提示符样式(（)对CentOS默认的主提示符加颜色标识)
# export PS1="[\[\e[0;36m\]\u\[\e[m\]@\[\e[0;32m\]\h \[\e[0;35m\]\W\[\e[m\]]\\$  "

alias # list

alias amazonbackup='s3backup'
alias apt='sudo apt-get'

alias name=value
alias name='command'
alias name='command arg1 arg2'
alias name='/path/to/script'
alias name='/path/to/script.pl arg1'
unalias aliasname
unalias foo

# disable a bash alias temporarily
## path/to/full/command
/usr/bin/clear
## call alias with a backslash ##
\c
## use /bin/ls command and avoid ls alias ##
command ls

# .bashrc
# if user is not root, pass all commands via sudo #
if [ $UID -ne 0 ]; then
    alias reboot='sudo reboot'
    alias update='sudo apt-get upgrade'
fi
### Get os name via uname ###
_myos="$(uname)"
 
### add alias as per os using $_myos ###
case $_myos in
   Linux) alias foo='/path/to/linux/bin/foo';;
   FreeBSD|OpenBSD) alias foo='/path/to/bsd/bin/foo' ;;
   SunOS) alias foo='/path/to/sunos/bin/foo' ;;
   *) ;;
esac

# alias
## Colorize the ls output ##
alias ls='ls --color=auto'
## Use a long listing format ##
alias ll='ls -la'
## Show hidden files ##
alias cls='clear'   #DOS风格的清空
# Clear the screen of your clutter
alias c="clear"
alias cl="clear;ls;pwd"
# ls better
alias la="ls -aF"
alias ld="ls -ld"
alias ll="ls -l"
alias lt='ls -At1 && echo "------Oldest--"'
alias ltr='ls -Art1 && echo "------Newest--"'

alias h='history | tail'
alias hg='history | grep'
alias hl='history | less'
# share history between terminal sessions
alias he="history -a" # export history
alias hi="history -n" # import history
alias nis="npm install --save "
alias svim='sudo vim'
alias mkcd='foo(){ mkdir -p "$1"; cd "$1" }; foo '
alias install='sudo apt get install'

## get rid of command not found ##
alias cd..='cd ..'

## a quick way to get out of current directory ##
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'
alias www='python -m SimpleHTTPServer 8000'
## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias sha1='openssl sha1'
# install  colordiff package :)
alias diff='colordiff'
alias mount='mount |column -t'
# handy short cuts #
alias j='jobs -l'
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'
alias vi=vim
alias svi='sudo vi'
alias vis='vim "+set si"'
alias edit='vim'

# add and remove new/deleted files from git index automatically
alias gitar="git ls-files -d -m -o -z --exclude-standard | xargs -0 git update-index --add --remove"
# git push
alias gpd="git push origin develop"
alias gpm="git push origin master"
# Remove git from a project
alias ungit="find . -name '.git' -exec rm -rf {} \;"

# Stop after sending count ECHO_REQUEST packets #
alias ping='ping -c 5'
# Do not wait interval 1 second, go fast #
alias fastping='ping -c 100 -s.2'
alias ports='netstat -tulanp'
## replace mac with your actual server mac address #
alias wakeupnas01='/usr/bin/wakeonlan 00:11:32:11:15:FC'
alias wakeupnas02='/usr/bin/wakeonlan 00:11:32:11:15:FD'
alias wakeupnas03='/usr/bin/wakeonlan 00:11:32:11:15:FE'
## shortcut  for iptables and pass it via sudo#
alias ipt='sudo /sbin/iptables'
 
# display all rules #
alias iptlist='sudo /sbin/iptables -L -n -v --line-numbers'
alias iptlistin='sudo /sbin/iptables -L INPUT -n -v --line-numbers'
alias iptlistout='sudo /sbin/iptables -L OUTPUT -n -v --line-numbers'
alias iptlistfw='sudo /sbin/iptables -L FORWARD -n -v --line-numbers'
alias firewall=iptlist
# get web server headers #
alias header='curl -I'
 
# find out if remote server supports gzip / mod_deflate or not #
alias headerc='curl -I --compress'

# do not delete / or prompt if deleting more than 3 files at a time #
alias rm='rm -I --preserve-root'

# confirmation #
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
# Make some of the file manipulation programs verbose
alias mv="mv -v"
alias rm="rm -vi"
alias cp="cp -v"

# Parenting changing perms on / #
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

 # distro specific  - Debian / Ubuntu and friends #
# install with apt-get
alias apt-get="sudo apt-get"
alias updatey="sudo apt-get --yes"
 ## distrp specifc RHEL/CentOS ##
alias update='yum update'
alias updatey='yum -y update'

# reboot / halt / poweroff
alias reboot='sudo /sbin/reboot'
alias poweroff='sudo /sbin/poweroff'
alias halt='sudo /sbin/halt'
alias shutdown='sudo /sbin/shutdown'

# update on one command
alias update='sudo apt-get update && sudo apt-get upgrade'

# also pass it via sudo so whoever is admin can reload it without calling you #
alias nginxreload='sudo /usr/local/nginx/sbin/nginx -s reload'
alias nginxtest='sudo /usr/local/nginx/sbin/nginx -t'
alias lightyload='sudo /etc/init.d/lighttpd reload'
alias lightytest='sudo /usr/sbin/lighttpd -f /etc/lighttpd/lighttpd.conf -t'
alias httpdreload='sudo /usr/sbin/apachectl -k graceful'
alias httpdtest='sudo /usr/sbin/apachectl -t && /usr/sbin/apachectl -t -D DUMP_VHOSTS'

# if cron fails or if you want backup on demand just run these commands #
# again pass it via sudo so whoever is in admin group can start the job #
# Backup scripts #
alias backup='sudo /home/scripts/admin/scripts/backup/wrapper.backup.sh --type local --taget /raid1/backups'
alias nasbackup='sudo /home/scripts/admin/scripts/backup/wrapper.backup.sh --type nas --target nas01'
alias s3backup='sudo /home/scripts/admin/scripts/backup/wrapper.backup.sh --type nas --target nas01 --auth /home/scripts/admin/.authdata/amazon.keys'
alias rsnapshothourly='sudo /home/scripts/admin/scripts/backup/wrapper.rsnapshot.sh --type remote --target nas03 --auth /home/scripts/admin/.authdata/ssh.keys --config /home/scripts/admin/scripts/backup/config/adsl.conf'
alias rsnapshotdaily='sudo  /home/scripts/admin/scripts/backup/wrapper.rsnapshot.sh --type remote --target nas03 --auth /home/scripts/admin/.authdata/ssh.keys  --config /home/scripts/admin/scripts/backup/config/adsl.conf'
alias rsnapshotweekly='sudo /home/scripts/admin/scripts/backup/wrapper.rsnapshot.sh --type remote --target nas03 --auth /home/scripts/admin/.authdata/ssh.keys  --config /home/scripts/admin/scripts/backup/config/adsl.conf'
alias rsnapshotmonthly='sudo /home/scripts/admin/scripts/backup/wrapper.rsnapshot.sh --type remote --target nas03 --auth /home/scripts/admin/.authdata/ssh.keys  --config /home/scripts/admin/scripts/backup/config/adsl.conf'
alias amazonbackup=s3backup

## play video files in a current directory ##
# cd ~/Download/movie-name
# playavi or vlc
alias playavi='mplayer *.avi'
alias vlc='vlc *.avi'
 
# play all music files from the current directory #
alias playwave='for i in *.wav; do mplayer "$i"; done'
alias playogg='for i in *.ogg; do mplayer "$i"; done'
alias playmp3='for i in *.mp3; do mplayer "$i"; done'
 
# play files from nas devices #
alias nplaywave='for i in /nas/multimedia/wave/*.wav; do mplayer "$i"; done'
alias nplayogg='for i in /nas/multimedia/ogg/*.ogg; do mplayer "$i"; done'
alias nplaymp3='for i in /nas/multimedia/mp3/*.mp3; do mplayer "$i"; done'
 
# shuffle mp3/ogg etc by default #
alias music='mplayer --shuffle *'

## All of our servers eth1 is connected to the Internets via vlan / router etc  ##
alias dnstop='dnstop -l 5  eth1'
alias vnstat='vnstat -i eth1'
alias iftop='iftop -i eth1'
alias tcpdump='tcpdump -i eth1'
alias ethtool='ethtool eth1'
 
# work on wlan0 by default #
# Only useful for laptop as all servers are without wireless interface
alias iwconfig='iwconfig wlan0'

## pass options to free ##
alias meminfo='free -m -l -t'
 
## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
 
## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
 
## Get server cpu info ##
alias cpuinfo='lscpu'
 
#copy output of last command to clipboard
alias cl="fc -e -|pbcopy"

# top
alias cpu='top -o cpu'
alias mem='top -o rsize' # memory

# copy the working directory path
alias cpwd='pwd|tr -d "\n"|pbcopy'

# DNS (with update thanks to @blanco)
alias flush="sudo killall -HUP mDNSResponder"

# Get your current public IP
alias ip="curl icanhazip.com"

## older system use /proc/cpuinfo ##
##alias cpuinfo='less /proc/cpuinfo' ##
 
## get GPU ram on desktop / laptop##
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'

# Reboot my home Linksys WAG160N / WAG54 / WAG320 / WAG120N Router / Gateway from *nix.
alias rebootlinksys="curl -u 'admin:my-super-password' 'http://192.168.1.2/setup.cgi?todo=reboot'"
 
# Reboot tomato based Asus NT16 wireless bridge
alias reboottomato="ssh admin@192.168.1.1 /sbin/reboot"

## this one saved by butt so many times ##
alias wget='wget -c'

## this one saved by butt so many times ##
alias ff4='/opt/firefox4/firefox'
alias ff13='/opt/firefox13/firefox'
alias chrome='/opt/google/chrome/chrome'
alias opera='/opt/opera/opera'
 
#default ff
alias ff=ff13
 
#my default browser
alias browser=chrome

## set some other defaults ##
alias df='df -H'
alias du='du -ch'
 
# top is atop, just like vi is vim
alias top='sudo htop'
alias cat='bat'
alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"

## nfsrestart  - must be root  ##
## refresh nfs mount / cache etc for Apache ##
alias nfsrestart='sync && sleep 2 && /etc/init.d/httpd stop && umount netapp2:/exports/http && sleep 2 && mount -o rw,sync,rsize=32768,wsize=32768,intr,hard,proto=tcp,fsc natapp2:/exports /http/var/www/html &&  /etc/init.d/httpd start'
 
## Memcached server status  ##
alias mcdstats='/usr/bin/memcached-tool 10.10.27.11:11211 stats'
alias mcdshow='/usr/bin/memcached-tool 10.10.27.11:11211 display'
 
## quickly flush out memcached server ##
alias flushmcd='echo "flush_all" | nc 10.10.27.11 11211'
 
## Remove assets quickly from Akamai / Amazon cdn ##
alias cdndel='/home/scripts/admin/cdn/purge_cdn_cache --profile akamai'
alias amzcdndel='/home/scripts/admin/cdn/purge_cdn_cache --profile amazon'
 
## supply list of urls via file or stdin
alias cdnmdel='/home/scripts/admin/cdn/purge_cdn_cache --profile akamai --stdin'
alias amzcdnmdel='/home/scripts/admin/cdn/purge_cdn_cache --profile amazon --stdin'

# time machine log
alias tmlog="syslog -F '\$Time \$Message' -k Sender com.apple.backupd-auto -k Time ge -30m | tail -n 1"

# trim newlines
alias tn='tr -d "\n"'

# list TODO/FIX lines from the current project
alias todos="ack -n --nogroup '(TODO|FIX(ME)?):'"

# create a Taskpaper todo file in the current folder
alias tp='touch todo.taskpaper && open -a "Taskpaper" todo.taskpaper'

# Reloads the bashrc file
alias bashreload="source ~/.bashrc && echo Bash config reloaded"

# Open nano and make backup of original file. Useful for config files and things you don't want to edit the original
function nanobk() {
    echo "You are making a copy of $1 before you open it. Press enter to continue."
    read nul
    cp $1 $1.bak
    nano $1
}

# Clear DNS Cache
# Still need testing on this one
alias flushdns="sudo /etc/init.d/dns-clean restart && echo DNS cache flushed"

# Get IPs associated with this site
# Work to dynamically list all interfaces. Will add later. 
# Currently only uses the hardcoded interface names
function myip()
{
    extIp=$(dig +short myip.opendns.com @resolver1.opendns.com)

    printf "Wireless IP: "
    MY_IP=$(/sbin/ifconfig wlp4s0 | awk '/inet/ { print $2 } ' |
      sed -e s/addr://)
    echo ${MY_IP:-"Not connected"}

    printf "Wired IP: "
    MY_IP=$(/sbin/ifconfig enp0s25 | awk '/inet/ { print $2 } ' |
      sed -e s/addr://)
    echo ${MY_IP:-"Not connected"}

    echo ""
    echo "WAN IP: $extIp"
}

# Syntax: "repeat [X] [command]"
function repeat()      
{
    local i max
    max=$1; shift;
    for ((i=1; i <= max ; i++)); do  # --> C-like syntax
        eval "$@";
    done
}

# Prints disk usage in human readable form
alias d="du -sh"

# GREP Motifications
alias grep="grep --color"
alias grepp="grep -P --color"

# Json tools (pipe unformatted to these to nicely format the JSON)
alias json="python -m json.tool"
alias jsonf="python -m json.tool"

# Edit shortcuts for config files
alias sshconfig="${EDITOR:-nano} ~/.ssh/config"
alias bashrc="${EDITOR:-nano} +120 ~/.bashrc && source ~/.bashrc && echo Bash config edited and reloaded."

# SSH helper
alias sshclear="rm ~/.ssh/multiplex/* -f && echo SSH connection cache cleared;"
alias sshlist="echo Currently open ssh connections && echo && l ~/.ssh/multiplex/"

stty erase ^H        #清除退格 (这个很有必要)

# /etc/profile
export PATH=$PATH:/opt/perl/site/bin:/opt/perl/bin

bash <(curl -s https://gist.github.com/Jacksgong/9d0519f68b7940a07075a834b3178979/raw/803256593b7b05177408ccbc0bc68e072a8e3a0a/init-shell.sh)

# ~/.inputrc
set completion-ignore-case on
```

## [Coreutils - GNU core utilities](https://www.gnu.org/software/coreutils/)

the basic file, shell and text manipulation utilities of the GNU operating system

## 语法

* 应用
    - 不适用场景
        + 比数组更复杂的数据结构
        + 出现了复杂的转义问题
        + 有太多的字符串操作
        + 不太需要调用其它程序和跟其它程序管道交互
* 变量
    - 从bash 3.2版开始，正则表达式和globbing表达式都不能用引号包裹。如果表达式里有空格，可以把它存储到一个变量里
    - local:函数内部变量
    - readonly:只读变量
    - 尽量对bash脚本里的所有变量使用local或readonly进行注解
* 操作符
    - `||`  逻辑or(仅双中括号里使用)
    - `&&`  逻辑and(仅双中括号里使用)
    - `<`   字符串比较(双中括号里不需要转移)
    - `-lt` 数字比较
    - `=`   字符串相等
    - `==`  以Globbing方式进行字符串比较(仅双中括号里使用，参考下文)
    - `=~`  用正则表达式进行字符串比较(仅双中括号里使用，参考下文)
    - `-n`  非空字符串
    - `-z`  空字符串
    - `-eq` 数字相等
    - `-ne` 数字不等
* 内置变量
    - `$0`  脚本名称
    - `$n`  传给脚本/函数的第n个参数
    - `$$`  脚本的PID
    - `$!`  上一个被执行的命令的PID(后台运行的进程)
    - `$?`  上一个命令的退出状态(管道命令使用${PIPESTATUS})
    - `$#`  传递给脚本/函数的参数个数 能够处理空格参数，而且参数间的空格也能正确的处理
    - `$@`  传递给脚本/函数的所有参数(识别每个参数) 用双引号括起来
    - `$*`  传递给脚本/函数的所有参数(把所有参数当成一个字符串)
    - `${10}`   在超过两位数的参数时，使用大括号限定起来
* bash shell 内置了一个type命令会根据输入的单词来显示此命令的类型，主要有以下五种类型：
    - 别名
        + 创建：`alias li='ls -li'`
        + 查看：`alias -p`
    - 方法
    - 内置命令
    - 关键字
    - 文件
    - 参数
        + 逐行详细地查看脚本的内容，可以使用-v 选项。
        + -x 选项，它们在执行时显示命令。当我们决定选择分支的时候，更加使用
* 语法
    - 有变量的字符串里，推荐使用双引号
    - 开头解释器：`#!/bin/bash`
    - 语法缩进:四个空格
    - 在标准输入上输入多行字符串
    - 命名建议规则：变量名大写、局部变量小写，函数名小写，名字体现出实际作用
    - 默认变量是全局的，在函数中变量local指定为局部变量，避免污染其他作用域
    - `$()`与``:用于shell命令的执行 用`$()`代替反单引号(`)
    - `pwd -P`:得出当前物理路径(（)非引用等路径)
    - function:定义一个函数，可加或不加
    - `egrep`
    - 用`[[]]`(双层中括号)替代[]
    - `bash -n myscript.sh `
        + -n:脚本进行语法检查
        + -v:跟踪脚本里每个命令的执行 `set -o verbose`
        + `set -x` -x:跟踪脚本里每个命令的执行并附加扩充信息 `set -o xtrace`
        + `set -e`:遇到执行非0时退出脚本
        + `set -o nounset`:引用未定义的变量(缺省值为“”)
        + `set -o errexit`:执行失败的命令被忽略
* 语句
    - exit 0：表示脚本结束退出，exit有一个整型参数，0表示正常退出，非0表示脚本执行中有错误
* 文件
    - dirname：显示最后一个结点前的路径
    - basename：显示最后一个结点的名称
* 内建命令 `type cd`
    - 不需要使用子进程来执行,已经和shell编译成了一体，作为shell工具的组成部分存在。不需要借助外部程序文件来运行
* 外部命令
    - 程序通常位于/bin、/usr/bin、/sbin或/usr/sbin中
    - 外部命令执行时，会创建出一个子进程。这种操作被称为衍生(forking),需要花费时间和精力来设置新子进程的环境
* 历史记录
    - `history -a` shell会话之前强制将命令历史记录写入.bash_history文件
    - `!!` `!20`:显示出从 shell历史记录中唤回的命令，然后执行该命令
* 正则表达式
* 习惯
    - 多加注释说明
    - 写脚本一定先测试再到生产上
    - 对一些变理，你可以使用默认值。如：${FOO:-'default'}
    - 处理你代码的退出码。这样方便你的脚本跟别的命令行或脚本集成。
    - 尽量不要使用 ; 来执行多个命令，而是使用 &&，这样会在出错的时候停止运行后续的命令。
    - 对于一些字符串变量，使用引号括起，避免其中有空格或是别的什么诡异字符。
    - 如果你的脚有参数，你需要检查脚本运行是否带了你想要的参数，或是，你的脚本可以在没有参数的情况下安全的运行。
    - 为你的脚本设置 -h 和 --help 来显示帮助信息。千万不要把这两个参数用做为的功能。
    - 使用 $() 而不是 “ 来获得命令行的输出，主要原因是易读。
    - 小心不同的平台，尤其是 MacOS 和 Linux 的跨平台。
    - 对于 rm -rf 这样的高危操作，需要检查后面的变量名是否为空，比如：rm -rf $MYDIDR/* 如果 $MYDIR为空，结果是灾难性的。
    - 考虑使用 “find/while” 而不是 “for/find”。如：for F in $(find . -type f) ; do echo $F; done 写成 find . -type f | while read F ; do echo $F ; done 不但可以容忍空格，而且还更快。
    - 防御式编程，在正式执行命令前，把相关的东西都检查好，比如，文件目录有没有存在。
* 调试 
* `前置 commands ; command1 && command2 || command3 ; 跟随 commands` 假如 command1 退出时返回码为零，就执行 command2，否则执行 command3
    - command1 && command2 这样的控制语句能够运行的原因是，每条命令执行完毕时都会给 shell 发送一个返回码，用来表示它执行成功与否。默认情况下，返回码为 0 表示成功，其他任何正值表示失败

```sh
type -a|t cd

test -d $HOME/bin || mkdir $HOME/bin

#! /bin/bash
echo "Hello World"
echo "file name $(basename $0)"
echo "You are using `basename $0`"
echo "Hello $1"
echo "Hello $*"
echo "Args count: $#"
exit 0
```

## PS1

```
\a    ASCII 响铃字符（也可以键入 \007） 
\d    "Wed Sep 06" 格式的日期 
\e    ASCII 转义字符（也可以键入 \033） 
\h    主机名的第一部分（如 "mybox"） 
\H    主机的全称（如 "mybox.mydomain.com"） 
\j    在此 shell 中通过按 ^Z 挂起的进程数 
\l    此 shell 的终端设备名（如 "ttyp4"） 
\n    换行符 
\r    回车符 
\s    shell 的名称（如 "bash"） 
\t    24 小时制时间（如 "23:01:01"） 
\T    12 小时制时间（如 "11:01:01"） 
\@    带有 am/pm 的 12 小时制时间 
\u    用户名 
\v    bash 的版本（如 2.04） 
\V    Bash 版本（包括补丁级别） ?/td> 
\w    当前工作目录（如 "/home/drobbins"） 
\W    当前工作目录的“基名 (basename)”（如 "drobbins"） 
\!    当前命令在历史缓冲区中的位置 
\#    命令编号（只要您键入内容，它就会在每次提示时累加） 
\$    如果您不是超级用户 (root)，则插入一个 "$"；如果您是超级用户，则显示一个 "#" 
\xxx    插入一个用三位数 xxx（用零代替未使用的数字，如 "\007"）表示的 ASCII 字符 
\\    反斜杠 
\[    这个序列应该出现在不移动光标的字符序列（如颜色转义序列）之前。它使 bash 能够正确计算自动换行。 
\]    这个序列应该出现在非打印字符序列之后
```

## 协程

* 在后台生成一个子shell，并在这个子shell中执行命令 `coproc My_Job { sleep 10; }`
* 扩展语法:必须确保在第一个花括号({)和命令名之间有一个空格。还必须保证命令以分号(;)结 尾。另外，分号和闭花括号(})之间也得有一个空格

## 文件管理

* 新建文件夹(mkdir)
* 新建文件(touch)
* 移动(mv)
* 复制(cp)
* 删除(rm)
* 链接
    - 符号链接就是一个实实在在的文件，它指向存放在虚拟目录结构中某个地方的另一个文件
    - 硬链接会创建独立的虚拟文件，其中包含了原始文件的信息及位置。但是它们从根本上而言是同一个文件。引用硬链接文件等同于引用了源文件。只能对处于同一存储媒体的文件创建硬链接。要想在不同存储媒体的文件之间创建链接， 只能使用符号链接。
* 临时文件
    - 创建前检查文件是否已经存在。
    - 确保临时文件已成功创建。
    - 临时文件必须有权限的限制。
    - 临时文件要使用不可预测的文件名。
    - 脚本退出时，要删除临时文件（使用trap命令）
    - 直接运行mktemp命令，就能生成一个临时文件，文件名是随机的，而且权限是只有用户本人可读写
        + -d参数可以创建一个临时目录
        + -p参数可以指定临时文件所在的目录。默认是使用$TMPDIR环境变量指定的目录，如果这个变量没设置，那么使用/tmp目录
        + -t参数可以指定临时文件的文件名模板，模板的末尾必须至少包含三个连续的X字符，表示随机字符，建议至少使用六个X。默认的文件名模板是tmp.后接十个随机字符
    - 后面最好使用 OR 运算符（||），指定创建失败时退出脚本
    - 保证脚本退出时临时文件被删除，可以使用trap命令指定退出时的清除操作
        + trap [动作] [信号]
        + 本正常执行结束，还是用户按 Ctrl + C 终止，都会产生EXIT信号
        + trap命令必须放在脚本的开头。否则，它上方的任何命令导致脚本退出，都不会被它捕获
        + trap需要触发多条命令，可以封装一个 Bash 函数

```sh
file my_file
mount # 输出当前系统上挂载设备列表
mount -t vfat /dev/sdb1 /media/disk
umount /home/rich/mnt
df -h

grep [options] pattern [file]
grep -v t file1 # 反向搜索(输出不匹配该模式的行)
# -c参数:有多少行含有匹配的模式

mktemp -t mytemp.XXXXXXX
trap 'rm -f "$TMPFILE"' EXIT # 遇到EXIT信号时，就会执行rm -f "$TMPFILE"

#!/bin/bash

trap 'rm -f "$TMPFILE"' EXIT

ls /etc > $TMPFILE
if grep -qi "kernel" $TMPFILE; then
  echo 'find'
fi
```

## 环境变量

* 系统环境变量
    - 基本上都是使用全大写字母，以区别于普通用户的环境变量
    - set命令会显示为某个特定进程设置的所有环境变量，包括局部变量、全局变量以及用户定义变量
    - 引用某个环境变量的时候，必须在变量前面加上一个美元符`($)`.显示变量当前值、让变量作为命令行参数.如果要用到变量，使用$;如果要操作变量，不使用$
    - 可作为数组使用
* 全局变量：对于shell会话和所有生成的子shell都是可见的
    - 创建全局环境变量的方法是先创建一个局部环境变量，然后再把它导出到全局环境中
    - 修改/删除子shell中全局环境变量并不会影响到父shell中该变量的值
    - 子shell甚至无法使用export命令改变父shell中全局环境变量的值
    - unset命令中引用环境变量时，记住不要使用$.在子进程中删除了一个全局环境变量， 这只对子进程有效。该全局环境变量在父进程中依然可用
* 局部变量：对创建它们的 shell可见
    - 要给变量赋一个含有空格的字符串值，必须用单引号来界定字符串的首和尾
    - 变量名、等号和值之间没有空格
    - 如果生成了另外一个shell，它在子shell中就不可用,退出了子进程，那个局部环境变量就不可用
    - 回到父shell时，子shell中设置的局部变量就不存在
* PATH环境变量:定义了用于进行命令和程序查找的目录,如果命令或者程序的位置没有包括在PATH变量中，那么如果不使用绝对路径的话，shell是没法找到的
    - 目录使用冒号分隔
    - PATH变量的修改只能持续到退出或重启系统
    - 登入Linux系统启动一个bash shell时，默认情况下bash会在几个文件中查找命令。这些文件叫作启动文件或环境文件
    - 启动bash shell有3种方式
        + 登录时作为默认登录shell:
            * $HOME/.bashrc
            * /etc/profile:系统上默认的bash shell的主启动文件,系统上的每个用户登录时都会执行这个启动文件.按照下列顺序运行第一个被找到的文件，余下的则被忽略
            * $HOME/.bash_profile:会先去检查HOME目录中是不是还有一个叫.bashrc的启动文件。如果有 的话，会先执行启动文件里面的命令
            * $HOME/.bash_login
            * $HOME/.profile
        + 作为非登录shell的交互式shell,不会访问/etc/profile文件，只会检查用户HOME目录 中的.bashrc文件
        + 作为运行脚本的非交互shell
            * 如果父shell是登录shell，在/etc/profile、/etc/profile.d/*.sh和$HOME/.bashrc文件中 设置并导出了变量，用于执行脚本的子shell就能够继承这些变量
            * 由父shell设置但并未导出的变量都是局部变量。子shell无法继承局部变量。

```sh
printenv HOME

# 局部用户定义变量
my_variable=Hello
echo $my_variable

mytest=(one two three four five)
echo ${mytest[2]}
mytest[2]=seven
unset mytest[2]
echo ${mytest[*]}

my_variable="I am Global now"
export my_variable
echo $my_variable

PATH=$PATH:/home/christine/Scripts
```

## 进程管理

* ps(process status):能够给出当前系统中进程的快照,捕获系统在某一事件的进程状态
* 三种使用的语法格式
    - UNIX 风格，选项可以组合在一起，并且选项前必须有“-”连字符
    - BSD 风格，选项可以组合在一起，但是选项前不能有“-”连字符
    - GNU 风格的长选项，选项前有两个“-”连字符
* 信息
    - PID: 运行着的命令(CMD)的进程编号
    - TTY: 命令所运行的位置（终端）
    - TIME: 运行着的该命令所占用的CPU处理时间
    - CMD: 该进程所运行的命令
* 参数
    - -a 代表 all。同时加上x参数会显示没有控制终端的进程
    - -u：查看特定用户进程的情况下
    - -aux ：结果按照 CPU 或者内存用量来筛选
    - --sort：来排序
    - -C ：后面跟要找的进程的名字
    - -f:查看格式化的信息列表
    - -L 参数:后面加上特定的PID,知道特定进程的线程
    - -axjf:以树形结构显示进程
    - -e 显示所有进程信息
    - -o 参数控制输出
        + Pid显示PID
        + User运行应用的用户
        + Args:运行应用的应用
    - -U 参数按真实用户ID(RUID)筛选进程，它会从用户列表中选择真实用户名或 ID。真实用户即实际创建该进程的用户。
    - -u 参数用来筛选有效用户ID（EUID）

```sh
ps -aux --sort -pcpu | less
ps -aux --sort -pmem | less
ps -aux --sort -pcpu,+pmem | head -n 10
ps -C getty
ps -eo pid,user,args # 查看现在有谁登入了服务器
ps -U root -u root u # 最后的u参数用来决定以针对用户的格式输出，由User, PID, %CPU, %MEM, VSZ, RSS, TTY, STAT, START, TIME 和 COMMAND这几列组成
watch -n 1 ‘ps -aux --sort -pmem, -pcpu | head 20’ # 实时监控进程状态: 通过CPU和内存的使用率来筛选进程，并且结果能够每秒刷新一次
```

## 网络

* netstat(show network status):列出系统上所有的网络套接字连接情况，包括 tcp, udp 以及 unix 套接字，另外还能列出处于监听状态（即等待接入请求）的套接字
* 参数
    - -a 列出所有当前的连接
    - -t 列出 TCP 协议的连接
    - -u 列出 UDP 协议的连接
    - -n 禁用域名解析功能. 默认情况下 netstat 会通过反向域名解析技术查找每个 IP 地址对应的主机名,降低查找速度。如果觉没有必要知道主机名

```sh
netstat -an | grep 3306
netstat -tunlp |grep 端口号 # 查看指定的端口号的进程情况 -t 显示tcp -u udp -n:拒绝显示别名，能数字数字 -l 列出在listen 服务状态 -p 显示相关程序名
lsof -i:80 # -i参数表示网络链接，:80指明端口号
```

## 查找

* xargs:给命令传递参数的一个过滤器
    - 将管道或标准输入(（)stdin)数据转换成命令行参数 也能够从文件的输出中读取数据
    - 能够捕获一个命令的输出，然后传递给另外一个命令
    - 参数
        + -a file 从文件中读入作为sdtin
        + -e flag ，注意有的时候可能会是-E，flag必须是一个以空格分隔的标志，当xargs分析到含有flag这个标志的时候就停止。
        + -p 当每次执行一个argument的时候询问一次用户。
        + -n num 后面加次数，表示命令在执行的时候一次用的argument的个数，默认是用所有的。
        + -t 表示先打印命令，然后再执行。
        + -i|I，将xargs的每项名称，一般是一行一行赋值给 {}，可以用 {} 代替。
        + -r no-run-if-empty 当xargs的输入为空的时候则停止xargs，不用再去执行了。
        + -s num 命令行的最大字符数，指的是 xargs 后面那个命令的最大命令行字符数。
        + -L|l num 从标准输入一次读取 num 行送给 command 命令。
        + -d delim 分隔符，默认的xargs分隔符是回车，argument的分隔符是空格，这里修改的是xargs的分隔符。
        + -x exit的意思，主要是配合-s使用。。
        + -P 修改最大的进程数，默认是1，为0时候为as many as it can 

```sh
find . -name PATTERN    ### 从当前目录查找符合 PATTERN 的文件
find /home -name PATTERN -exec ls -l {} \;  # 从 /home 文件查找所有符合 PATTERN 的文件，并交由 ls 输出详细信息 
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

netstat -nat | awk  '{print  $5}' | awk -F ':' '{print $1}' | sort | uniq -c | sort -rn | head -n 10 # 查看连接你服务器 top10 用户端的 IP 地址
cat .bash_history | sort | uniq -c | sort -rn | head -n 10 (or cat .zhistory | sort | uniq -c | sort -rn | head -n 10 # 查看一下你最常用的10个命令

cat test.txt | xargs # 多行输入单行输出
echo "nameXnameXnameXname" | xargs -dX -n2 # 自定义一个定界符

ls *.jpg | xargs -n1 -I {} cp {} /data/images # 复制所有图片文件到 /data/images 目录下

find . -type f -name "*.jpg" -print | xargs tar -czvf images.tar.gz # 查找所有的 jpg 文件，并且压缩
find . -type f -name "*.php" -print0 | xargs -0 wc -l # 统计一个源代码目录中所有 php 文件的行数
find . -type f -name "*.log" -print0 | xargs -0 rm -f

#!/bin/bash
#sk.sh命令内容，打印出所有参数。

echo $*

cat arg.txt | xargs -I {} ./sk.sh -p {} -l

# 输出nginx日志的ip和每个ip的pv，pv最高的前10
#2019-06-26T10:01:57+08:00|nginx001.server.ops.pro.dc|100.116.222.80|10.31.150.232:41021|0.014|0.011|0.000|200|200|273|-|/visit|sign=91CD1988CE8B313B8A0454A4BBE930DF|-|-|http|POST|112.4.238.213
awk -F"|" '{print $3}' access.log | sort | uniq -c | sort -nk1 -r | head -n10
```

## 磁盘管理

```sh
fdisk  -l # 所有硬盘的分区信息,包括没有挂上的分区和USB设备
ls -l /dev/sda* # 查看第一块硬盘的分区信息
df -a|-h|-T #-a或-all：显示全部的文件系统 -h或--human-readable：以可读性较高的方式来显示信息 -T或--print-type：显示文件系统的类型

du [option] 目录名或文件名 # [option]主要参数  -a或-all：显示目录中个别文件的大小 -h或--human-readable：以K，M，G为单位显示，提高信息可读性 -S或--separate-dirs：省略指定目录下的子目录，只显示该目录的总和(（)注意：该命令是大写S) ncdu

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

ls -l my_script # 过滤输出列表
```

## 重定向

* redirect output：[number]>
* redirect input: [number]<
* error messages go to a stream called stderr, which is designated as 2>

```sh
ls /void 2> output.log
wc < output.log 
```

## grep

全局搜索正则表达式并打印出匹配的行

```sh
grep “string” filename
grep “string” filenameKeyword*
grep 'Ubuntu' *.txt
grep “startingKeyword.*endingKeyword” filename
grep -i “string” filename # 不会考虑搜索字符串是大写还是小写
grep -rn --color POST access.log # n则输出具体的行数

grep -rn --color Exception -A10 -B2   error.log # A  after  内容后n行 B  before  内容前n行 C  count?  内容前后n行

# 删除目录中的所有class文件
find . | grep .class$ | xargs rm -rvf
#把所有的rmvb文件拷贝到目录
ls *.rmvb | xargs -n1 -i cp {} /mount/xiaodianying
```

### [zsh-users/zsh](https://github.com/zsh-users/zsh)

* [robbyrussell/oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)：A delightful community-driven (with 1,000+ contributors) framework for managing your zsh configuration. Includes 200+ optional plugins (rails, git, OSX, hub, capistrano, brew, ant, php, python, etc), over 140 themes to spice up your morning, and an auto-update tool so that makes it easy to keep up with the latest updates from the community.
    - 兼容bash
    - 自动cd：只需输入目录名称
    - 命令选项补齐，比如输入 git，然后按 Tab，即可显示出 git都有哪些命令
    - 目录一次性补全：比如输入 Doc/doc按 Tab键会自动变成 Documents/document/
    - 组件
        + [plugin](https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins)
        + [zsh-users/zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)：Fish shell like syntax highlighting for Zsh.
        + [zsh-users/zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions):Fish-like autosuggestions for zsh
        + [zsh-users/antigen](https://github.com/zsh-users/antigen):The plugin manager for zsh. http://antigen.sharats.me
        + [unixorn/awesome-zsh-plugins](https://github.com/unixorn/awesome-zsh-plugins):A collection of ZSH frameworks, plugins & themes inspired by the various awesome list collections out there.
        + incr是一款自动提示插件
        + [sindresorhus/pure](https://github.com/sindresorhus/pure):Pretty, minimal and fast ZSH prompt
    - Theme
        + agnoster
        + cloud
        + wedisagree
        + [denysdovhan/spaceship-prompt](https://github.com/denysdovhan/spaceship-prompt):🚀⭐️ A Zsh prompt for Astronauts https://denysdovhan.com/spaceship-prompt/
    - 工具
        + [sindresorhus/pure](https://github.com/sindresorhus/pure):Pretty, minimal and fast ZSH prompt
        + [zplug / zplug](https://github.com/zplug/zplug):🌺 A next-generation plugin manager for zsh

```sh
cat /etc/shells

echo $SHELL/bin/bash

sudo yum install zsh
sudo apt-get install zsh git wget

brew install zsh zsh-completions # Mac

wget --no-check-certificate 。![]https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh

chsh -s /bin/zsh
source ~/.bashrc # 运行

# oh-my-zsh
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

## 配置：home目录的.zshrc(不用单配，插件配置有)

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

ZSH_THEME="robbyrussell" # 主题设置(（)文件在~/.oh-my-zsh/themes)

# 插件
plugins=(git textmate ruby autojump osx mvn gradle autojump)

export DEFAULT_USER="henry" # hide username

PROMPT='%{$fg_bold[red]%}➜ %{$fg_bold[green]%}%p%{$fg[cyan]%}%d %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%}% %{$reset_color%}>'
#PROMPT='%{$fg_bold[red]%}➜ %{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'

# 更新
upgrade_oh_my_zsh
uninstall_oh_my_zsh
```

### [fish-shell/fish-shell](https://github.com/fish-shell/fish-shell)

The user-friendly command line shell. http://fishshell.com

* 彩色显示
* 有效路径为下划线
* 光标会给提示:→(选中) 只采纳一部分，可以按下(Alt + →)
* 补全存在的历史记录或猜测可能性(tab选择)
* [fisherman/fisherman](https://github.com/fisherman/fisherman):The fish-shell plugin manager.

```sh
# 安装
sudo apt-get install fish
brew install fish

# iterm 配置
echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher  // 安装fisherman(（)fish 的插件管理器)
fisher omf/theme-default
fish # 启动
help # 手册

## 配置文件：~/.config/fish/config.fish或者fish_config
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

### xmonad

所有操作都通过键盘，只适合命令行的重度用户.用来管理软件窗口的位置和大小，会自动在桌面上平铺(（)tiling)窗口。桌面环境通常很重，窗口管理器就很轻，不仅体积小，资源占用也少，用户可以配置各种细节，释放出系统的最大性能。

* 极简主义和高度可配置。默认配置中几乎没有窗户装饰和工具栏，而且可以大范围进行定制。
* 面向键盘，友好的用户体验。
* 平铺。不必手动排列窗口。
* 如果你使用鼠标，光标所在的窗口自动获得焦点
* 配置文件:～/.xmonad/xmonad.hs。该文件需要用户自己新建 modMask = mod4Mask
* 使用
    + 退出当前会话,通过xmonad 会话重新登录,有默认的功能键mod(alt)
    + 打开终端:mod + shift + return 新窗口总是独占主栏，旧窗口平分副栏
    + 切换布局:mod + space
    + 移动副栏到主栏:mod + , 逆操作 mod + .
    + 切换栏:mod + j mod + k
    + 移动栏位置:mod + return
    + 调整窗口顺序 mod + shift + j mod + shift + k
    + 调整窗口尺寸: mod + l mod + h
    + 该窗口就会变成浮动窗口，可以放到屏幕的任何位置:mod + 鼠标左键拖动窗口
    + 调整窗口大小:mod + 鼠标右键
    + 当前浮动窗口就会结束浮动，重新回到 xmonad 的布局:mod + t
    + 关闭窗口:mod + shift + c
    + 工作区切换:mod + 1到mod + 9
    + 把光标前的两个词调换一下位置：按一下 esc 键，然后再按一下 t
    + 将一个窗口移到不同的工作区，先用mod + j或mod + k，将其变成焦点窗口，然后使用mod + shift + 6，就将其移到了6号工作区(1号工作区是终端，2号是浏览器，4号是虚拟机)
* 多显示器: xrandr(或者Xinerama 和 winView，另外 arandr 是 xrandr 的图形界面),多显示器时，每个显示器会分配到一个工作区
    + 查看显示器的连接情况:xrandr -q
    + 转移焦点到左显示器:mod + w
    + 转移焦点到右显示器:mod + e
* xmobar:提供了一个状态栏，将常用信息显示在上面,配置文件~/.xmobarrc
* dmenu 在桌面顶部提供了一个菜单条，可以快速启动应用程序
    + mod + p就会进入dmenu菜单栏
    + 按下ESC键可以退出
    + 方向键用来选择应用程序
    + return键用来启动

```sh
sudo apt-get install xmonad
sudo apt-get install xmobar dmenu
```

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

### Terminal 快捷键

* Shell之所以叫Shell 是因为它隐藏了操作系统底层的细节
* 终端本质上是对应着 Linux 上的 /dev/tty 设备，Linux 的多用户登陆就是通过不同的 /dev/tty 设备完成的
* 默认提供七个终端，其中第一个到第六个虚拟控制台是全屏的字符终端，第七个虚拟控制台是图形终端，用来运行GUI程序，按快捷键CTRL+ALT+F1，或CTRL+ALT+F2.......CTRL+ALT+F6，CTRL+ALT+F7可完成对应的切换
* 快捷键
  - Tab 点击Tab键可以实现命令补全,目录补全、命令参数补全;
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
  - Ctrl+d:键盘输入结束或退出终端
  - Ctrl+a 光标移动到开始位置
  - Ctrl+e 光标移动到最末尾
  - Ctrl+k 删除此处至末尾的所有内容
  - Ctrl+u 删除此处至开始的所有内容
  - Ctrl+d 删除当前字符
  - Ctrl+h 删除当前字符前一个字符
  - Ctrl+w 删除此处到左边的单词
  - Ctrl+y 粘贴由 Ctrl+u ， Ctrl+d ， Ctrl+w 删除的单词
  - Ctrl+l 相当于clear，即清屏
  - Ctrl+r 查找历史命令
  - Ctrl+b 向回移动光标
  - Ctrl+f 向前移动光标
  - Ctrl+t 将光标位置的字符和前一个字符进行位置交换
  - Ctrl+& 恢复 ctrl+h 或者 ctrl+d 或者 ctrl+w 删除的内容
  - Ctrl+S 暂停屏幕输出
  - Ctrl+Q 继续屏幕输出
  - Ctrl+Left-Arrow 光标移动到上一个单词的词首
  - Ctrl+Right-Arrow 光标移动到下一个单词的词尾
  - Ctrl+p 向上显示缓存命令
  - Ctrl+n 向下显示缓存命令
  - Ctrl+d 关闭终端
  - Ctrl+xx 在EOL和当前光标位置移动
  - Ctrl+x@ 显示可能hostname补全
  - Ctrl+c 终止进程/命令
  - Shift +上或下 终端上下滚动
  - Shift+PgUp/PgDn 终端上下翻页滚动
  - Ctrl+Shift+n 新终端
  - alt+F2 输入gnome-terminal打开终端
  - Shift+Ctrl+T 打开新的标签页
  - Shift+Ctrl+W 关闭标签页
  - Shift+Ctrl+C 复制
  - Shift+Ctrl+V 粘贴
  - Alt+数字 切换至对应的标签页
  - Shift+Ctrl+N 打开新的终端窗口
  - Shift+Ctrl+Q 管壁终端窗口
  - Shift+Ctrl+PgUp/PgDn 左移右移标签页
  - Ctrl+PgUp/PgDn 切换标签页
  - F1 打开帮助指南
  - F10 激活菜单栏
  - F11 全屏切换
  - Alt+F 打开 “文件” 菜单（file）
  - Alt+E 打开 “编辑” 菜单（edit）
  - Alt+V 打开 “查看” 菜单（view）
  - Alt+S 打开 “搜索” 菜单（search）
  - Alt+T 打开 “终端” 菜单（terminal）
  - Alt+H 打开 “帮助” 菜单（help）
  - cmmand + d:新开同框分屏
  - Ctrl+d:键盘输入结束或退出终端
  - Ctrl+s:暂停当前程序，暂停后按下任意键恢复运行
  - Ctrl+z:将当前程序放到后台运行，恢复到前台为命令fg
  - Ctrl+a:将光标移至输入行头，相当于Home键
  - Ctrl+e:将光标移至输入行末，相当于End键
  - Ctrl + K :删除从光标所在位置到行末,常配合ctrl+a使用
  - Alt+Backspace:向前删除一个单词，常配合ctrl+e使用
  - Shift+PgUp:将终端显示向上滚动
  - Shift+PgDn:将终端显示向下滚动
  - clear|ctrl+l :清屏
  - Ctrl + U 删除光标之前的全部内容
  - Ctrl + Y 撤销之前的删除操作
  - Ctrl + W 删除之前的一个参数

* Tab:点击Tab键可以实现命令补全,目录补全、命令参数补全
* Ctrl+c:强行终止当前程序(（)常用)
* Ctrl+d:键盘输入结束或退出终端(（)常用)
* Ctrl+s:暂停当前程序，暂停后按下任意键恢复运行
* Ctrl+z:将当前程序放到后台运行，恢复到前台为命令fg
* Ctrl+a:将光标移至输入行头，相当于Home键
* Ctrl+e:将光标移至输入行末，相当于End键
* Ctrl+k:删除从光标所在位置到行末,常配合ctrl+a使用
* Ctrl+u  删除光标之前到剪贴板
* Alt+Backspace:向前删除一个单词，常配合ctrl+e使用
* Shift+PgUp:将终端显示向上滚动
* Shift+PgDn:将终端显示向下滚动
* Ctrl+y  粘贴
* Ctrl+l  清屏
* Ctrl+r  查询命令(多次按)
* Ctrl+/  撤销
* Alt–.   使用前一次命令的最后一个词(命令本身也是一个词)

```sh
dialog --title "Oh hey" --inputbox "Howdy?" 8 55 # interact with the user on command-line
```

### 脚本

shell 是可以与计算机进行高效交互的文本接口。shell 提供了一套交互式的编程语言(（)脚本)，shell的种类很多，比如 sh、bash、zsh 等。shell 的生命力很强，在各种高级编程语言大行其道的今天，很多的任务依然离不开 shell。比如可以使用 shell 来执行一些编译任务，或者做一些批处理任务，初始化数据、打包程序等等。

```sh
touch zsh-script.sh

#!/bin/zsh
echo Hello shell

# 给脚本执行的权限
chmod +x zsh-script.sh
# 执行脚本
./zsh-script.sh
# 后台运行
./zsh-script.sh &

# 处理命令行参数的一个样例：
while [ "$1" != "" ]; do
    case $1 in
        -s  )   shift
    SERVER=$1 ;;
        -d  )   shift
    DATE=$1 ;;
  --paramter|p ) shift
    PARAMETER=$1;;
        -h|help  )   usage # function call
                exit ;;
        * )     usage # All other parameters
                exit 1
    esac
    shift
done

# 命令行菜单的一个样例：
#!/bin/bash
# Bash Menu Script Example

PS3='Please enter your choice: '
options=("Option 1" "Option 2" "Option 3" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Option 1")
            echo "you chose choice 1"
            ;;
        "Option 2")
            echo "you chose choice 2"
            ;;
        "Option 3")
            echo "you chose choice $REPLY which is $opt"
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

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

## 免密码登录

* ~/.ssh/authorized_keys:存放远程免密登录的公钥,主要通过这个文件记录多台机器的公钥
* ~/.ssh/id_rsa : 生成的私钥文件
* ~/.ssh/id_rsa.pub ： 生成的公钥文件
* ~/.ssh/know_hosts : 已知的主机公钥清单　
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

# have SSH host keys for those IPs in your ~/.ssh/known_hosts
ssh-keygen -R <IP_ADDRESS>
```

## autojump

```sh
brew install autojump

git clone git://github.com/joelthelion/autojump.git ./install.py

j + 目录名
```

## 问题

```
# Sorry, user henry is not allowed to execute '/usr/bin/apt update' as root
# 从recovery 模式进入到root 用户界面
# /etc/sudoers
henry ALL=(ALL) NOPASSWD:ALL
```

## 教程

* [learnbyexample/command-line-text-processing](https://github.com/learnbyexample/Command-line-text-processing):⚡️ From finding text to search and replace, from sorting to beautifying text and more 🎨
* [learnbyexample/Linux_command_line](https://github.com/learnbyexample/Linux_command_line):💻 Introduction to Linux commands and Shell scripting
* [learnbyexample/scripting_course](https://github.com/learnbyexample/scripting_course):📓 A reference guide to Linux command line, Vim and Scripting https://learnbyexample.github.io/scripting_course/
* [Introduction to text manipulation on UNIX-based systems](https://www.ibm.com/developerworks/aix/library/au-unixtext/index.html)
* [Linux 教程](https://www.runoob.com/linux/linux-tutorial.html)
* [linuxcommand](http://linuxcommand.org)
* [Advanced Bash-Scripting Guide](http://tldp.org/LDP/abs/html/index.html)
* [denysdovhan/bash-handbook](https://github.com/denysdovhan/bash-handbook):book For those who wanna learn Bash https://git.io/bash-handbook
* [dylanaraps / pure-bash-bible](https://github.com/dylanaraps/pure-bash-bible):book A collection of pure bash alternatives to external processes.
* [Idnan / bash-guide](https://github.com/Idnan/bash-guide):A guide to learn bash

```sh
cat demo.json | jq '.id,.name,.status,.attachments'

axel -n 20 http://centos.ustc.edu.cn/centos/7/isos/x86_64/CentOS-7-x86_64-Minimal-1511.iso
ccache gcc foo.c
```

## 工具

* terminal
    - ios
        + [ish-app / ish](https://github.com/ish-app/ish):Linux shell for iOS https://ish.app
    - Mac
        + Iterm2
            * [mbadolato / iTerm2-Color-Schemes](https://github.com/mbadolato/iTerm2-Color-Schemes):Over 200 terminal color schemes/themes for iTerm/iTerm2. Includes ports to Terminal, Konsole, PuTTY, Xresources, XRDB, Remmina, Termite, XFCE, Tilda, FreeBSD VT, Terminator, Kitty, MobaXterm, LXTerminal, Microsoft's Windows Terminal, Visual Studio http://www.iterm2colorschemes.com
    - Linux
        + 原生命令行
        + [Konsole](https://konsole.kde.org/)
            * 搜索/高亮功能。高亮匹配是实时刷新的，这对于拖尾日志文件真的很方便
            * 易于选择和复制文本块
            * 简单选择屏幕滚动，使用CTRL + SHIFT + K清理缓冲区
            * 可自定义隐藏大部分不必要的细节(（)标签栏、菜单)，默认提供许多颜色主题
    - Windows
        + WSL:提供了一个由微软开发的Linux兼容的内核接口(（)不包含Linux内核代码)，然后可以在其上运行GNU用户空间
            * WSL2
        + [putty](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)
        + xshell6
        + [FinalShell](http://www.hostbuf.com/)
        + WinSSHTerm
        + KiTTY
        + ZOC Terminal
        + [MobaXterm](https://mobaxterm.mobatek.net/) Enhanced terminal for Windows with X11 server, tabbed SSH client, network tools and much more
        + Console2
        + [cmder + gow](http://bliker.github.io/cmder/)
        + ConEmu
        + [PowerShell](https://github.com/PowerShell/PowerShell):PowerShell for every system! https://microsoft.com/PowerShell
        + [Babun](http://babun.github.io/)
        + [Terminal](https://github.com/microsoft/terminal):The new Windows Terminal, and the original Windows console host -- all in the same place!
    - [Eugeny/terminus](https://github.com/Eugeny/terminus):A terminal for a more modern age https://eugeny.github.io/terminus/
    - [msys2](http://www.msys2.org/)
    - powercmd
    - [alacritty / alacritty](https://github.com/alacritty/alacritty):A cross-platform, GPU-accelerated terminal emulator
    - [lukesampson/scoop](https://github.com/lukesampson/scoop):A command-line installer for Windows. https://scoop.sh
    - [railsware/upterm](https://github.com/railsware/upterm):A terminal emulator for the 21st century.
* help
    - [idank/explainshell](https://github.com/idank/explainshell):match command-line arguments to their help text
    - [tldr-pages/tldr](https://github.com/tldr-pages/tldr): books Simplified and community-driven man pages http://tldr-pages.github.io/
    - [jaywcjlove / linux-command](https://github.com/jaywcjlove/linux-command):Linux命令大全搜索工具，内容包含Linux命令手册、详解、学习、搜集。https://git.io/linux https://git.io/linux
* 查看
    - [sharkdp/bat](https://github.com/sharkdp/bat):A cat(1) clone with wings.
* [lynx](link):终端构建的Web浏览应用程序
* [fasd](https://github.com/clvv/fasd) 增强cd命令
* [ogham/exa](https://github.com/ogham/exa):A modern version of ‘ls’. https://the.exa.website/
* [alexanderepstein/Bash-Snippets](https://github.com/alexanderepstein/Bash-Snippets):A collection of small bash scripts for heavy terminal users
* [ranger](https://github.com/ranger/ranger) 在多目录上浏览各种文件 比 cd 和 cat 更有效率，甚至可以在终端预览图片
* [prettyping](https://github.com/denilsonsa/prettyping) 图示化的ping
* [ncdu]()比 du 好用多了,另一个选择是 [nnn](https://github.com/jarun/nnn)
* [asciinema](https://asciinema.org/)和 [svg-trem](https://github.com/marionebl/svg-term-cli) 如果想把的命令行操作建录制成一个 SVG 动图
* [httpie](https://github.com/jakubroztocil/httpie) 是一个可以用来替代 curl 和 wget 的 http 客户端，httpie 支持 json 和语法高亮，可以使用简单的语法进行 http 访问: http -v github.com
* [tmux]() 在需要经常登录远程服务器工作的时候会很有用，可以保持远程登录的会话，还可以在一个窗口中查看多个 shell 的状态 替代screen、nohup
* [Taskbook](https://github.com/klaussinani/taskbook) 是可以完全在命令行中使用的任务管理器 ，支持 ToDo 管理，还可以为每个任务加上优先级
* [sshrc](https://github.com/Russell91/sshrc ) 在登录远程服务器的时候也能使用本机的 shell 的 rc 文件中的配置
* 搜索
    - [ack](https://beyondgrep.com/)、[ag](https://github.com/ggreer/the_silver_searcher)和 [rg](https://github.com/BurntSushi/ripgrep)是更好的grep，和上面的fd一样，在递归目录匹配的时候，会忽略到配置在 .gitignore 中的规则
    - [fzf](https://github.com/junegunn/fzf) cherry_blossom A command-line fuzzy finder `git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install`
    - [fd](https://github.com/sharkdp/fd) A simple, fast and user-friendly alternative to 'find' 一个比 find 更简单更快的命令，会自动地忽略掉一些配置在 .gitignore 中的文件，以及 .git 下的文件
    - [ ggreer / the_silver_searcher ](https://github.com/ggreer/the_silver_searcher):A code-searching tool similar to ack, but faster. http://geoff.greer.fm/ag/
* monitor
    - top:查看在系统中运行的进程或线程,默认是以 CPU 进行排序的
    - [sqshq / sampler ](https://github.com/sqshq/sampler):Tool for shell commands execution, visualization and alerting. Configured with a simple YAML file. https://sampler.dev
    - nslookup:指定查询的类型，可以查到DNS记录的生存时间还可以指定使用哪个DNS服务器进行解释
    - [htop](http://hisham.hm/htop/): 提供更美观、更方便的进程监控工具
    - [atop](http://www.atoptool.nl/):按日记录进程的日志供以后分析。也能显示所有进程的资源消耗。还会高亮显示已经达到临界负载的资源。
    - [apachetop](https://github.com/JeremyJones/Apachetop) 会监控 apache 网络服务器的整体性能。它主要是基于 mytop。它会显示当前的读取进程、写入进程的数量以及请求进程的总数。
    - [ftptop](http://www.proftpd.org/docs/howto/Scoreboard.html) 给提供了当前所有连接到 ftp 服务器的基本信息，如会话总数，正在上传和下载的客户端数量以及客户端是谁。
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
    - traceroute是一个内置工具，能显示路由和测量数据包在网络中的延迟,数据包在IP网络经过的路由器的IP地址
    - [IPTState](http://www.phildev.net/iptstate/index.shtml) 可以让你观察流量是如何通过 iptables，并通过你指定的条件来进行排序。该工具还允许你从 iptables 的表中删除状态信息。
    - [darkstat](https://unix4lyfe.org/darkstat/) 能捕获网络流量并计算使用情况的统计数据。该报告保存在一个简单的 HTTP 服务器中，它为你提供了一个非常棒的图形用户界面。
    - [vnStat]( http://humdi.net/vnstat/) 是一个网络流量监控工具，它的数据统计是由内核进行提供的，其消耗的系统资源非常少。系统重新启动后，它收集的数据仍然存在。有艺术感的系统管理员可以使用它的颜色选项。
    - netstat 是一个内置的工具，显示 TCP 网络连接，路由表和网络接口数量，被用来在网络中查找问题。
    - ss:iproute2 包附带的另一个工具，允许查询 socket 的有关统计信息,显示的信息比 netstat 更多，也更快。如果想查看统计结果的总信息，你可以使用命令 ss -s
    - [Nmap](http://nmap.org/) 可以扫描你服务器开放的端口并且可以检测正在使用哪个操作系统。但你也可以将其用于 SQL 注入漏洞、网络发现和渗透测试相关的其他用途。
    - [MTR](http://www.bitwizard.nl/mtr/) 将 traceroute 和 ping 的功能结合到了一个网络诊断工具上。当使用该工具时，它会限制单个数据包的跳数，然后监视它们的到期时到达的位置。然后每秒进行重复。
    - [Justniffer](http://justniffer.sourceforge.net/) 是 tcp 数据包嗅探器。使用此嗅探器你可以选择收集低级别的数据还是高级别的数据。它也可以让你以自定义方式生成日志。比如模仿 Apache 的访问日志。
* hex
    - [sharkdp/hexyl](https://github.com/sharkdp/hexyl):A command-line hex viewer
* git
    - [arialdomartini/oh-my-git](https://github.com/arialdomartini/oh-my-git)
    - [magicmonty/bash-git-prompt](https://github.com/magicmonty/bash-git-prompt):An informative and fancy bash prompt for Git users
    - tig：字符模式下交互查看git项目，可以替代git命令
* download
    - you-get: 非常强大的媒体下载工具，支持youtube、google+、优酷、芒果TV、腾讯视频、秒拍等视频下载。
    - axel：多线程下载工具，下载文件时可以替代curl、wget
* prompt
    - [b-ryan/powerline-shell](https://github.com/b-ryan/powerline-shell):A beautiful and useful prompt for your shell
        + pre-patched and adjusted fonts for usage with the Powerline statusline plugin `sudo apt-get install fonts-powerline`
        + Powerline a statusline plugin for vim, and provides statuslines and prompts for several other applications `pip install powerline-status`
    - [starship/starship](https://github.com/starship/starship):cometmilky_way The cross-shell prompt for astronauts https://starship.rs
* sql
    - mycli：mysql客户端，支持语法高亮和命令补全，效果类似ipython，可以替代mysql命令。
* json
    - jq: json文件处理以及格式化显示，支持高亮，可以替换python -m json.tool。
* 代码统计
    - cloc：代码统计工具，能够统计代码的空行数、注释行、编程语言。
* benchmark
    - [sharkdp/hyperfine](https://github.com/sharkdp/hyperfine):A command-line benchmarking tool
* [bash](http://ftp.gnu.org/gnu/bash/) https://www.gnu.org/software/bash/manua
    - [Bash-it/bash-it](https://github.com/Bash-it/bash-it):A community Bash framework.
    - [dylanaraps/pure-bash-bible ](https://github.com/dylanaraps/pure-bash-bible):book A collection of pure bash alternatives to external processes.
* [svenstaro/genact](https://github.com/svenstaro/genact):🌀 A nonsense activity generator https://svenstaro.github.io/genact/
* [kentcdodds/cross-env](https://github.com/kentcdodds/cross-env):🔀 Cross platform setting of environment scripts https://www.npmjs.com/package/cross-env
* [Swordfish90/cool-retro-term](https://github.com/Swordfish90/cool-retro-term):A good looking terminal emulator which mimics the old cathode display...
* [nvbn/thefuck](https://github.com/nvbn/thefuck):Magnificent app which corrects your previous console command.
* [mixn/carbon-now-cli](https://github.com/mixn/carbon-now-cli):🎨 Beautiful images of your code — from right inside your terminal.
* [faressoft/terminalizer](https://github.com/faressoft/terminalizer):🦄 Record your terminal and generate animated gif images
* [niieani/bash-oo-framework](https://github.com/niieani/bash-oo-framework):Bash Infinity is a modern boilerplate / framework / standard library for bash
* [ericfreese/rat](https://github.com/ericfreese/rat):Compose shell commands to build interactive terminal applications
* [kovidgoyal/kitty](https://github.com/kovidgoyal/kitty):A cross-platform, fast, feature full, GPU based terminal emulator
* [idank/explainshell](https://github.com/idank/explainshell):match command-line arguments to their help text
* [sindresorhus/fkill-cli](https://github.com/sindresorhus/fkill-cli):Fabulously kill processes. Cross-platform.
* [tartley/colorama](https://github.com/tartley/colorama):Simple cross-platform colored terminal text in Python
* [dylanaraps/fff](https://github.com/dylanaraps/fff):🚀 fucking fast file-manager
* [jmacdonald/amp](https://github.com/jmacdonald/amp):A complete text editor for your terminal. https://amp.rs
* [liamg/aminal](https://github.com/liamg/aminal):Golang terminal emulator from scratch
* [amanusk/s-tui](https://github.com/amanusk/s-tui):Terminal based CPU stress and monitoring utility https://amanusk.github.io/s-tui/
* [GitSquared/edex-ui](https://github.com/GitSquared/edex-ui):A science fiction terminal emulator designed for large touchscreens that runs on all major OSs.
* [rupa/z](https://github.com/rupa/z):z - jump around
* [Eugeny/terminus](https://github.com/Eugeny/terminus):A terminal for a more modern age https://eugeny.github.io/terminus/
* [jwilm/alacritty](https://github.com/jwilm/alacritty):A cross-platform, GPU-accelerated terminal emulator
* [koalaman / shellcheck](https://github.com/koalaman/shellcheck)：ShellCheck, a static analysis tool for shell scripts https://www.shellcheck.net
* yapf：Google开发的python代码格式规范化工具，支持pep8以及Google代码风格。
* mosh：基于UDP的终端连接，可以替代ssh，连接更稳定，即使IP变了，也能自动重连。
* PathPicker(fpp):在命令行输出中自动识别目录和文件，支持交互式，配合git非常有用
* sz/rz：交互式文件传输，在多重跳板机下传输文件非常好用，不用一级一级传输。
* ccache：高速C/C++编译缓存工具，反复编译内核非常有用。使用起来也非常方便
* neovim: 替代vim
* script/scriptreplay: 终端会话录制
* [Hyper](https://hyper.is):create a beautiful and extensible experience for command-line interface users, built on open web standards
* 配置
    - [direnv/direnv](https://github.com/direnv/direnv):Unclutter your .profile http://direnv.net

## 参考

* [dylanaraps/pure-bash-bible](https://github.com/dylanaraps/pure-bash-bible):📖 A collection of pure bash alternatives to external processes.
* [alebcay/awesome-shell](https://github.com/alebcay/awesome-shell)：A curated list of awesome command-line frameworks, toolkits, guides and gizmos. Inspired by awesome-php.
* [窗口管理器 xmonad 教程](http://www.ruanyifeng.com/blog/2017/07/xmonad.html)
* [fengyuhetao/shell](https://github.com/fengyuhetao/shell):Linux命令行与shell脚本编程大全案例
* [Bash Guide for Beginners](https://www.tldp.org/LDP/Bash-Beginners-Guide/html/)
* [Bash Reference Manual](https://tiswww.case.edu/php/chet/bash/bashref.html)
* [Bash scripting cheat sheet](https://devhints.io/bash)
* [bash(1) – Linux man page](https://linux.die.net/man/1/bash)
* [An A-Z Index of the Bash command line for Linux.](https://ss64.com/bash/)
* [Google’s Shell Style Guide](https://google.github.io/styleguide/shell.xml)
* [jlevy/the-art-of-command-line](https://github.com/jlevy/the-art-of-command-line):Master the command line, in one page
* [explainshell](https://explainshell.com)
* 脚本参考
    - http://www.bashoneliners.com/
    - http://www.shell-fu.org/
    - http://www.commandlinefu.com/
    - http://www.shelldorado.com/scripts/
    - https://snippets.siftie.com/public/tag/bash/
    - https://bash.cyberciti.biz/
    - https://github.com/alexanderepstein/Bash-Snippets
    - https://github.com/miguelgfierro/scripts
    - https://github.com/epety/100-shell-script-examples
    - https://github.com/ruanyf/simple-bash-scripts
    - 框架
        - 写bash脚本的框架 https://github.com/Bash-it/bash-it
    - 和shell有关的索引资源
        + https://github.com/alebcay/awesome-shell
        + https://github.com/awesome-lists/awesome-bash
        + https://terminalsare.sexy/
