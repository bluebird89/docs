# Clear the screen of your clutter
alias c="clear"
alias cl="clear;ls;pwd"

## ls
alias ll='ls -la'
alias l.='ls -d .* --color=auto'
alias wl='ll | wc -l'
alias l='ls -l'
alias lh='ls -lh'
alias la="ls -aF"
alias ld="ls -ld"
alias ls='ls --color=auto'
alias lt='ls -At1 && echo "------Oldest--"'
alias ltr='ls -Art1 && echo "------Newest--"'

## a quick way to get out of current directory ##
alias p='pwd'
alias path='echo -e ${PATH//:/\\n}'

cdl() { cd "$@" && pwd ; ls -alF; }
alias ..="cdl ../../"
alias ...='cdl ../../../'
alias ....='cdl ../../../../'
alias .....='cd ../../../../'
alias .3="cd ../../.."
alias .4='cd ../../../../'
alias .5='cd ../../../../..'

alias mkdir='mkdir -pv'
# alias mkcd='foo(){ mkdir -p "$1"; cd "$1" }; foo '
mcd() { mkdir -p $1 && cd $1 && pwd ; }
bak() { cp "$@" "$@.bak"-`date +%y%m%d`; echo "`date +%Y-%m-%d` backed up $PWD/$@"; }

alias cp="cp -iv" # interactive, verbose
alias rm="rm -i" # interactive
alias mv="mv -iv" # interactive, verbose
alias ln='ln -i'
# do not delete / or prompt if deleting more than 3 files at a time #
alias rm='rm -I --preserve-root'
alias find='fzf'

# Parenting changing perms on / #
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep -i --color=auto' # 用颜色标识，更醒目；忽略大小写
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grepp="grep -P --color"
alias nocomm='grep -Ev '\''^(#|$)'\'''

alias vi=vim
alias svi='sudo vim'
alias vis='vim "+set si"'
alias edit='vim'
alias lvim="vim -c \"normal '0\"" # 编辑vim最近打开的文件

alias bc='bc -l'

alias sha1='openssl sha1'

# install  colordiff package :)
alias diff='colordiff'

alias mount='mount |column -t'

# handy short cuts #
alias hg='history|grep'
alias h='history | tail'
alias hl='history | less'
alias he="history -a" # export history
alias hi="history -n" # import history

alias j='jobs -l'

alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'

## iptables and pass it via sudo#
alias firewall=iptlist
alias ipt='sudo /sbin/iptables'
alias iptlist='sudo /sbin/iptables -L -n -v --line-numbers'
alias iptlistin='sudo /sbin/iptables -L INPUT -n -v --line-numbers'
alias iptlistout='sudo /sbin/iptables -L OUTPUT -n -v --line-numbers'
alias iptlistfw='sudo /sbin/iptables -L FORWARD -n -v --line-numbers'

# get web server headers #
alias header='curl -I'
# find out if remote server supports gzip / mod_deflate or not #
alias headerc='curl -I --compress'

alias ai='sudo apt-fast install -y'
alias ad='sudo apt-fast update'
alias ag='sudo apt-fast upgrade -y'
alias ar='sudo apt-fast remove --purge'
alias ac='sudo apt-fast autoremove --purge && sudo apt-fast autoclean'
alias adg='sudo apt-get update && sudo apt-get upgrade -y'
alias update='yum update'
alias updatey='yum -y update'

alias service="sudo systemctl"
alias k="kubectl"
alias f='fuck'
alias jn='jupyter notebook'

alias wget='aria2c'
alias tail='sudo tail -f -n 20'

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

## npm
alias nis="npm install --save "

# add and remove new/deleted files from git index automatically
alias gitar="git ls-files -d -m -o -z --exclude-standard | xargs -0 git update-index --add --remove"
alias gpd="git push origin develop"
alias gpm="git push origin master"
alias ungit="find . -name '.git' -exec rm -rf {} \;"

## replace mac with your actual server mac address #
alias wakeupnas01='/usr/bin/wakeonlan 00:11:32:11:15:FC'
alias wakeupnas02='/usr/bin/wakeonlan 00:11:32:11:15:FD'
alias wakeupnas03='/usr/bin/wakeonlan 00:11:32:11:15:FE'

# get web#
alias ping='ping -c 5'
alias fastping='ping -c 100 -s.2'
alias fastping='ping -c 100 -s.2'
alias header='curl -I'
alias headerc='curl -I --compress'
alias ip="curl icanhazip.com"
alias ports='netstat -tulanp'

## system ##
alias reboot='sudo /sbin/reboot'
alias poweroff='sudo /sbin/poweroff'
alias halt='sudo /sbin/halt'
alias shutdown='sudo /sbin/shutdown -p now'
# Reboot my home Linksys WAG160N / WAG54 / WAG320 / WAG120N Router / Gateway from *nix.
alias rebootlinksys="curl -u 'admin:my-super-password' 'http://192.168.1.2/setup.cgi?todo=reboot'"
alias reboottomato="ssh admin@192.168.1.1 /sbin/reboot"

# server
alias nginxreload='sudo /usr/local/nginx/sbin/nginx -s reload'
alias nginxtest='sudo /usr/local/nginx/sbin/nginx -t'
alias lightyload='sudo /etc/init.d/lighttpd reload'
alias lightytest='sudo /usr/sbin/lighttpd -f /etc/lighttpd/lighttpd.conf -t'
alias httpdreload='sudo /usr/sbin/apachectl -k graceful'
alias httpdtest='sudo /usr/sbin/apachectl -t && /usr/sbin/apachectl -t -D DUMP_VHOSTS'

# Backup scripts #
alias backup='sudo /home/scripts/admin/scripts/backup/wrapper.backup.sh --type local --taget /raid1/backups'
alias nasbackup='sudo /home/scripts/admin/scripts/backup/wrapper.backup.sh --type nas --target nas01'
alias s3backup='sudo /home/scripts/admin/scripts/backup/wrapper.backup.sh --type nas --target nas01 --auth /home/scripts/admin/.authdata/amazon.keys'
alias rsnapshothourly='sudo /home/scripts/admin/scripts/backup/wrapper.rsnapshot.sh --type remote --target nas03 --auth /home/scripts/admin/.authdata/ssh.keys --config /home/scripts/admin/scripts/backup/config/adsl.conf'
alias rsnapshotdaily='sudo  /home/scripts/admin/scripts/backup/wrapper.rsnapshot.sh --type remote --target nas03 --auth /home/scripts/admin/.authdata/ssh.keys  --config /home/scripts/admin/scripts/backup/config/adsl.conf'
alias rsnapshotweekly='sudo /home/scripts/admin/scripts/backup/wrapper.rsnapshot.sh --type remote --target nas03 --auth /home/scripts/admin/.authdata/ssh.keys  --config /home/scripts/admin/scripts/backup/config/adsl.conf'
alias rsnapshotmonthly='sudo /home/scripts/admin/scripts/backup/wrapper.rsnapshot.sh --type remote --target nas03 --auth /home/scripts/admin/.authdata/ssh.keys  --config /home/scripts/admin/scripts/backup/config/adsl.conf'
alias amazonbackup=s3backup

# play all music files from the current directory #
alias playwave='for i in *.wav; do mplayer "$i"; done'
alias playogg='for i in *.ogg; do mplayer "$i"; done'
alias playmp3='for i in *.mp3; do mplayer "$i"; done'
alias music='mplayer --shuffle *'
alias nplaywave='for i in /nas/multimedia/wave/*.wav; do mplayer "$i"; done'
alias nplayogg='for i in /nas/multimedia/ogg/*.ogg; do mplayer "$i"; done'
alias nplaymp3='for i in /nas/multimedia/mp3/*.mp3; do mplayer "$i"; done'

# shuffle mp3/ogg etc by default #

## All of our servers eth1 is connected to the Internets via vlan / router etc  ##
alias dnstop='dnstop -l 5  eth1'
alias vnstat='vnstat -i eth1'
alias iftop='iftop -i eth1'
alias tcpdump='tcpdump -i eth1'
alias ethtool='ethtool eth1'

# work on wlan0 by default #
# Only useful for laptop as all servers are without wireless interface
alias iwconfig='iwconfig wlan0'

## get top process eating memory
alias mem='top -o rsize'
alias psmem='ps auxf | sort -nr -k 4'
alias meminfo='free -m -l -t'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

## get top process eating cpu ##
alias cpu='top -o cpu'
alias cpuinfo='lscpu'
alias cpuinfo1='less /proc/cpuinfo'
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

alias cl="fc -e -|pbcopy"

# copy the working directory path
alias cpwd='pwd|tr -d "\n"|pbcopy'

# DNS (with update thanks to @blanco)
alias flush="sudo killall -HUP mDNSResponder"

alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'

## this one saved by butt so many times ##
alias wget='wget -c'

alias f='fasd -f'          # 文件
alias d='fasd -d'        # 目录
alias a='fasd -a'        # 任意
alias s='fasd -si'       # 显示并选择

alias sd='fasd -sid'        # 选择目录
alias sf='fasd -sif'          # 选择文件
alias z='fasd_cd -d'       # 跳转至目录
alias zz='fasd_cd -d -i'  # 选择并跳转至目录

## browser ##
alias ff='/opt/firefox13/firefox'
alias chrome='/opt/google/chrome/chrome'
alias opera='/opt/opera/opera'
alias browser=chrome
alias ff=ff

## set some other defaults ##
alias df='pydf'
alias du='du -sch'
alias du="ncdu dark -rr -x --exclude .git --exclude node_modules"

# top is atop, just like vi is vim
alias top='sudo htop'
alias cat='bat'

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
alias bashrc="${EDITOR:-nano} +120 ~/.bashrc && source ~/.bashrc && echo Bash config edited and reloaded."
alias bashreload="source ~/.bashrc && echo Bash config reloaded"

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

# Json tools (pipe unformatted to these to nicely format the JSON)
alias json="python -m json.tool"
alias jsonf="python -m json.tool"

# ssh
alias sshconfig="${EDITOR:-nano} ~/.ssh/config"
alias sshclear="rm ~/.ssh/multiplex/* -f && echo SSH connection cache cleared;"
alias sshlist="echo Currently open ssh connections && echo && l ~/.ssh/multiplex/"

stty erase ^H        # 清除退格

# 快速根据进程号pid杀死进程，如 psid tomcat， 然后 kill9 两个tab键提示要kill的进程号
alias kill9='kill -9';
alias psg='\ps aux | grep -v grep | grep --color'
psid() {
[[ ! -n ${1} ]] && return; # bail if no argument
pro="[${1:0:1}]${1:1}"; # process-name –> [p]rocess-name (makes grep better)
ps axo pid,user,command | grep -v grep |grep -i --color ${pro}; # show matching processes
pids="$(ps axo pid,user,command | grep -v grep | grep -i ${pro} | awk '{print $1}')"; # get pids
complete -W "${pids}" kill9 # make a completion list for kk
}

# 解压所有归档文件工具
function extract {
	if [ -z "$1" ]; then
		# display usage if no parameters given
		echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
	else
	if [ -f $1 ] ; then
	# NAME=${1%.*
}

case $1 in
	*.tar.bz2) tar xvjf $1 ;;
	*.tar.gz) tar xvzf $1 ;;
	*.tar.xz) tar xvJf $1 ;;
	*.lzma) unlzma $1 ;;
	*.bz2) bunzip2 $1 ;;
	*.rar) unrar x -ad $1 ;;
	*.gz) gunzip $1 ;;
	*.tar) tar xvf $1 ;;
	*.tbz2) tar xvjf $1 ;;
	*.tgz) tar xvzf $1 ;;
	*.zip) unzip $1 ;;
	*.Z) uncompress $1 ;;
	*.7z) 7z x $1 ;;
	*.xz) unxz $1 ;;
	*.exe) cabextract $1 ;;
	*) echo "extract: '$1' - unknown archive method" ;;
	esac
else
	echo "$1 - file does not exist"
	fi
fi
}

alias mysql='/usr/local/opt/mysql/bin/mysql'
alias mysqladmin='/usr/local/opt/mysql/bin/mysqladmin'

alias code="/Applications/Visual\ Studio\ Code\ -\ Insiders.app/Contents/Resources/app/bin/code"
alias y="ydict"
alias vi="nvim"
alias vim="nvim"
alias tmux="tmux -2"
alias ssh="ssh -X"
alias s="ssh -X"
alias md="mkdir -p"
alias rd="rmdir"
alias df="df -h"
alias mv="mv -i"
alias slink="link -s"
alias l="ls -l"
alias la="ls -a"
alias ll="ls -la"
alias lt="ls -lhtrF"
alias l.="ls -lhtrdF .*"
alias grep="grep --color=auto"
alias cd..="cd .."
alias cd...="cd ../.."
alias cd....="cd ../../.."
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias zb="cat /dev/urandom | hexdump -C | grep --color=auto \"ca fe\""
alias mtr="/usr/local/bin/mtr"
alias gs="git status"
alias gsm="git summary"
alias ga='git add'
alias gd='git diff'
alias gf='git fetch'
alias grv='git remote -v'
alias grb='git rebase'
alias gbr='git branch'
alias gpl="git pull"
alias gps="git push"
alias gco="git checkout"
alias gl="git log"
alias gc="git commit -m"
alias gm="git merge"
alias pro="proxychains4"
alias gb="go build"

#For docker
alias dm="docker-machine"
alias di="docker images"
alias dps="docker ps"
alias dsp="docker stop"
alias ds="docker start"
alias dl="docker logs --tail=50"
alias drm="docker rm"
alias drmi="docker rmi $(docker images --filter "dangling=true" -q --no-trunc)"
alias kc="kubectl"


alias -s go=vi
alias -s html=vi
alias -s rb=vi
alias -s py=vi
alias -s txt=vi
alias -s ex=vi
alias -s exs=vi
alias -s js=vi
alias -s json=vi

# alias for proxy
alias proxy="export ALL_PROXY=socks5://127.0.0.1:7070"
alias unproxy="unset ALL_PROXY"
alias ip="curl -4 ip.sb"
alias ipv6="curl -6 ip.sb"
