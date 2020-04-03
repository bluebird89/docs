# Rsync

rsync is a file transfer program capable of efficient remote update via a fast differencing algorithm.

* 增量 – 对比文件差异，然后只传输差异部分
* 压缩 – 怎么实现秒传？传得越少，速度越快
* 黑名单 – 某些目录和文件是永远不用传的
* 安全 – 有权限校验，可以走ssh通道，根据主机、或者用户名
* 连续 – 不是一次只传一个文件

## 配置

* 配置文件 `rsyncd.conf`:控制认证、访问、日志记录等等。该文件是由一个或多个模块结构组成
* 一个模块定义以方括弧中的模块名开始，直到下一个模块定义开始或者文件结束，模块中包含格式为name = value的参数定义
* 每个模块其实就对应需要备份的一个目录树

## 参数

* -a, --archive 归档模式，表示以递归方式传输文件，并保持所有文件属性，等于-rlptgoD
* -c, --checksum 打开校验开关，强制对文件传输进行校验v，使用文件校验和而不是时间戳来决定改变的文件，通常消耗的时间更久
* --delete：删除目标上无关的文件
* -d 不要递归目录
* -v, --verbose  详细模式输出
* -r, --recursive  对子目录以递归模式处理
* -R, --relative  使用相对路径信息
* -b, --backup  创建备份，也就是对于目的已经存在有同样的文件名时，将老的文件重新命名为~filename。可以使用--suffix选项来指定不同的备份文件前缀。
* --backup-dir  将备份文件(如~filename)存放在在目录下。
* -suffix=SUFFIX  定义备份文件前缀
* -u, --update  仅仅进行更新，也就是跳过所有已经存在于DST，并且文件时间晚于要备份的文件。(不覆盖更新的文件)
* -l, --links    保留软链结
* -L, --copy-links  想对待常规文件一样处理软链结
* --copy-unsafe-links  仅仅拷贝指向SRC路径目录树以外的链结
* --safe-links  忽略指向SRC路径目录树以外的链结
* -H, --hard-links  保留硬链结
* -p, --perms  保持文件权限
* -o, --owner  保持文件属主信息
* -g, --group    保持文件属组信息
* -D, --devices  保持设备文件信息
* -t, --times    保持文件时间信息
* -S, --sparse  对稀疏文件进行特殊处理以节省DST的空间
* -n, --dry-run  现实哪些文件将被传输
* -W, --whole-file  拷贝文件，不进行增量检测
* -x, --one-file-system  不要跨越文件系统边界
* -B, --block-size=SIZE  检验算法使用的块尺寸，默认是700字节
* -e, --rsh=COMMAND  指定替代rsh的shell程序
* --rsync-path=PATH    指定远程服务器上的rsync命令所在路径信息
* -C, --cvs-exclude      使用和CVS一样的方法自动忽略文件，用来排除那些不希望传输的文件
* --existing  仅仅更新那些已经存在于DST的文件，而不备份那些新创建的文件
* --delete    删除那些DST中SRC没有的文件
* --delete-excluded  同样删除接收端那些被该选项指定排除的文件
* --delete-after      传输结束以后再删除
* --ignore-errors    及时出现IO错误也进行删除
* --max-delete=NUM  最多删除NUM个文件
* --partial  保留那些因故没有完全传输的文件，以是加快随后的再次传输
* --force    强制删除目录，即使不为空
* --numeric-ids  不将数字的用户和组ID匹配为用户名和组名
* --timeout=TIME IP  超时时间，单位为秒
* -I, --ignore-times  不跳过那些有同样的时间和长度的文件
* --size-only  当决定是否要备份文件时，仅仅察看文件大小而不考虑文件时间
* --modify-window=NUM  决定文件是否时间相同时使用的时间戳窗口，默认为0
* -T --temp-dir=DIR      在DIR中创建临时文件
* --compare-dest=DIR    同样比较DIR中的文件来决定是否需要备份
* -P  等同于 --partial
* --progress    显示备份过程
* -z, --compress  对备份的文件在传输时进行压缩处理
* --exclude=PATTERN 指定排除不需要传输的文件模式;--include=PATTERN 指定不排除而需要传输的文件模式.都不能使用间隔符
* --exclude-from=FILE 排除FILE中指定模式的文件;--include-from=FILE 不排除FILE指定模式匹配的文件
    - 若文件/目录在剔除列表中，则忽略传输
    - 若文件/目录在包含列表中，则传输之
    - 若文件/目录未被提及，也传输之
    - 规则文件 FILE 的书写约定
        + 每行书写一条规则 RULE
        + 以 # 或 ; 开始的行为注释行
    - 包含（include）和排除（exclude）规则的语法如下：
        + include PATTERN 或简写为 + PATTERN
        + exclude PATTERN 或简写为 - PATTERN
    - PATTERN 的书写规则如下：
        + 以 / 开头：匹配被传输的跟路径上的文件或目录
        + 以 / 结尾：匹配目录而非普通文件、链接文件或设备文件
        + 使用通配符
        + *：匹配非空目录或文件（遇到 / 截止）
        + **：匹配任何路径（包含 / ）
        + ?：匹配除了 / 的任意单个字符
        + [：匹配字符集中的任意一个字符，如 [a-z] 或 [[:alpha:]]
        + 可以使用转义字符 \ 将上述通配符还原为字符本身含义
* --version  打印版本信息
* --address  绑定到特定的地址
* --config=FILE  指定其他的配置文件，不使用默认的rsyncd.conf文件
* --port=PORT  指定其他的rsync服务端口
* --blocking-io  对远程shell使用阻塞IO
* -stats  给出某些文件的传输状态
* --progress  在传输时现实传输过程
* --log-format=FORMAT  指定日志文件格式
* --password-file=FILE    从FILE中得到密码
* --bwlimit=KBPS  限制I/O带宽，KBytes per second
* -h, --help  显示帮助信息

```sh
rsync [OPTION]... SRC [SRC]... DEST
rsync [OPTION]... SRC [SRC]... [USER@]HOST:DEST
rsync [OPTION]... SRC [SRC]... [USER@]HOST::DEST
rsync [OPTION]... SRC [SRC]... rsync://[USER@]HOST[:PORT]/DEST
rsync [OPTION]... [USER@]HOST:SRC [DEST] # ':' usages connect via remote shell
rsync [OPTION]... [USER@]HOST::SRC [DEST] # '::' & 'rsync://' usages connect to an rsync daemon, and require SRC or DEST to start with a module name.
rsync [OPTION]... rsync://[USER@]HOST[:PORT]/SRC [DEST]

rsync -r dir1/ dir2 # sync the contents of dir1 to dir2 on the same system
rsync -a --delete /home /backups # /home：表示将整个 home 目录复制到目标目录; /home/ ： 表示将 home 目录中的所有内容复制到目标目录
rsync --rsh=ssh --delete -avz  ~/Backups/ henry@ubuntu:/home/henry/backups/ # 将Backups/文件下面同步到backups下面
rsync --delete /opt/app/tomcat/webapps/ROOT/* -avSH root@221.130.14.87:/opt/app/apache-tomcat-6.0.29/webapps/ROOT/ # rsync服务器主动同步到别的服务器的命令示例,前提是做好两个服务器之间的无密钥ssh登陆

# 同步静态主机表文件
[root@soho ~]# rsync /etc/hosts centos5:/etc/hosts # 执行“推”复制同步（centos5 是可解析的远程主机名）
[root@centos5 ~]# rsync soho:/etc/hosts /etc/hosts # 执行“拉”复制同步（soho 是可解析的远程主机名）

# 同步用户的环境文件
[osmond@soho ~]$ rsync ~/.bash* centos5: # 执行“推”复制同步
[osmond@cnetos5 ~]$ rsync soho:~/.bash* . # 执行“拉”复制同步

# 同步站点根目录
[osmond@soho ~]$ rsync -avz --delete /var/www root@192.168.0.101:/var/www # 执行“推”复制同步
[osmond@cnetos5 ~]$ rsync -avz --delete root@192.168.0.55:/var/www /var/www # 执行“拉”复制同步

# 使用rsync 从远程rsync 服务器同步数据,可以到如下站点查找离自己最近的提供 rsync 服务的镜像站点
# CentOS — http://www.centos.org/modules/tinycontent/index.php?id=13
# Ubuntu — https://launchpad.net/ubuntu/+archivemirrors
rsync -aqzH --delete --delay-updates \
rsync://mirror.centos.net.cn/centos /var/www/mirror/centos
rsync -azH --progress --delete --delay-updates \
rsync://ubuntu.org.cn/ubuntu /var/www/mirror/ubuntu/
rsync -azH --progress --delete --delay-updates \
rsync://ubuntu.org.cn/ubuntu-cn /var/www/mirror/ubuntu-cn/

# 为了每天不断更新，可以安排一个 cron 任务：
# crontab -e
# mirror centos at 0:10AM everyday
10 0 * * * rsync -aqzH --delete --delay-updates rsync://mirror.centos.net.cn/centos /var/www/mirror/centos/
# mirror ubuntu at 2:10AM everyday
10 2 * * * rsync -azH --progress --delete --delay-updates rsync://ubuntu.org.cn/ubuntu /var/www/mirror/ubuntu/
# mirror ubuntu-cn at 4:10AM everyday
10 4 * * * rsync -azH --progress --delete --delay-updates rsync://ubuntu.org.cn/ubuntu-cn /var/www/mirror/ubuntu-cn/

# 可以使用 ––exclude 选项排除源目录中要传输的文件；同样地，也可以使用 ––include 选项指定要传输的文件。
rsync -vzrtopg --delete --exclude "logs/" --exclude "conf/" --progress \
backup@192.168.0.101:/www/ /backup/www/

rsync -av --include '*/' --exclude '*' \
backup@192.168.0.101:/www/ /backup/www-tree/

- *.o # 不传输所有后缀为 .o 的文件
- /foo # 不传输传输根目录下名为 foo 的文件或目录
- foo/ # 不传输名为 foo 的目录
- /foo/bar # 不传输 /foo 目录下的名为 bar 的文件或目录
# 传输所有目录和C语言源文件并禁止传输其他文件
+ */
+ *.c
- *
# 仅传输 foo 目录和其下的 bar.c 文件
+ foo/
+ foo/bar.c
- *

# 下面的规则存入名为 www-rsync-rules 的文件
- logs/ # 不传输 logs 目录
- *.tmp # 不传输后缀为 .tmp 的文件

# 传输 Apache 虚拟主机文档目录（/*/ 匹配域名）
+ /srv/www/
+ /srv/www/*/
+ /srv/www/*/htdocs/
+ /srv/www/*/htdocs/**

# 传输每个用户的 public_html 目录（/*/ 匹配用户名）
+ /home/
+ /home/*/
+ /home/*/public_html/
+ /home/*/public_html/**

- * # 禁止传输其他
rsync -av --delete --exclude-from=www-rsync-rules / remotehost:/dest/dir

rsync -zvr /var/opt/installation/inventory/ /root/temp # Synchronize Two Directories in a Local Server
rsync -azv /var/opt/installation/inventory/ /root/temp/ # reserve timestamps during Sync using rsync -a
rsync -v /var/lib/rpm/Pubkeys /root/temp/ # Synchronize Only One File
rsync -avz /root/temp/ thegeekstuff@192.168.200.10:/home/thegeekstuff/temp/ # Synchronize Files From Local to Remote
rsync -avz thegeekstuff@192.168.200.10:/var/lib/rpm /root/temp # Synchronize Files From Remote to Local
rsync -avz -e ssh thegeekstuff@192.168.200.10:/var/lib/rpm /root/temp # Remote shell for Synchronization
rsync -avzu thegeekstuff@192.168.200.10:/var/lib/rpm /root/temp # Do Not Overwrite the Modified Files at the Destination
rsync -v -d thegeekstuff@192.168.200.10:/var/lib/ . # Synchronize only the Directory Tree Structure (not the files)
rsync -avz --progress thegeekstuff@192.168.200.10:/var/lib/rpm/ /root/temp/ # View the rsync Progress during Transfer
rsync -avz --delete thegeekstuff@192.168.200.10:/var/lib/rpm/  # Delete the Files Created at the Target
rsync -avz --existing root@192.168.1.2:/var/lib/rpm/ . # Do not Create New File at the Target
rsync -avzi thegeekstuff@192.168.200.10:/var/lib/rpm/ /root/temp/ # View the Changes Between Source and Destination
rsync -avz --include 'P*' --exclude '*' thegeekstuff@192.168.200.10:/var/lib/rpm/ /root/temp/ #  Include and Exclude Pattern during File Transfer
rsync -avz --max-size='100K' thegeekstuff@192.168.200.10:/var/lib/rpm/ /root/temp/ # Do Not Transfer Large Files
rsync -avzW  thegeekstuff@192.168.200.10:/var/lib/rpm/ /root/temp # Transfer the Whole File
```

## 使用

```sh
mkdir /etc/rsyncd
touch /etc/rsyncd/rsyncd.conf
ln -s /etc/rsyncd/rsyncd.conf /etc/rsyncd.conf

mkdir /etc/rsyncd  # 创建一个目录存放rsyncd.motd和rsyncd.pwd文件
touch /etc/rsyncd/rsyncd.secrets # 创建rsyncd.secrets文件存放用户名：密码
chmod 600 /etc/rsyncd/rsyncd.secrets  # 为了密码的安全性，将rsyncd.secrets文件的权限设为600

hosta:hosta-s-password
hostb:hostb-s-password

touch /etc/rsyncd/rsyncd.motd  # 创建登录成功欢迎页面
vi /etc/rsyncd/rsyncd.motd  # 编辑欢迎信息
find / -name rsyncd.conf    # 找到配置文件所在的目录
vi /etc/rsyncd.conf  # 编辑配置文件

# /etc/rsyncd: configuration file for rsync daemon mode
# See rsyncd.conf man page for more options.
# configuration example:

uid = root   #设置用户
gid = root  #设置用户组
syslog facility = local3 # 将使用LOCAL3 日志设备（facility) 需要在 /etc/syslog.conf 文件中添加如：local3.info /var/log/rsync.log,重启服务service syslog restart

use chroot = yes
read only = yes

max connections = 4  #客户端最多连接数
timeout = 300

pid file = /var/run/rsyncd.pid  #设  rsync 的守护进程将其 PID 写入指定的文件。
motd file = /etc/rsyncd/rsyncd.motd  # 指定一个消息文件，当客户连接服务器时该文件的内容显示给客户。 登录成功欢迎页面
log file    # 指定 rsync 守护进程的日志文件，而不将日志发送给 syslog。

host allow = 192.168.0.221 192.168.0.222 #允许连接的IP，IP段用空格隔开
hosts deny=*

secrets file = /etc/rsyncd/rsyncd.secrets
auth users = bua,bub

# exclude = lost+found/
# transfer logging = yes
# timeout = 900
# ignore nonreadable = yes
# dont compress   = *.gz *.tgz *.zip *.z *.Z *.rpm *.deb *.bz2

# [ftp]
#        path = /home/ftp
#        comment = ftp export area

[uploadfile] #模块名
    path = /data  #本模块指定的文件目录
    list = no  #是否列出服务器提供的同步目录，设置为no较为安全
    ignore errors  #忽略IO错误
    auth users = user1  #认证用户，在rsyncd.pwd设置了该用户的密码
    secrets file = /etc/rsyncd/rsyncd.pwd  #指定用户：密码文件
    comment = module loading success!  #该模块的说明文字
    exclude = a/ b/   #排除本模块下指定目录中的个别文件目录

[home]
    uid = root
    gid = root
    path = /home
    comment = product server home
    exclude = www/ samba/ ftp/
[www]
    path = /home/www
    comment = product server www
    exclude = logs/

touch /opt/app/rsync/etc/rsyncucweb.password
echo "images:ucweb@file" > /opt/app/rsync/etc/rsyncucweb.password
chmod 600 /opt/app/rsync/ect/rsyncucweb.password # 更改密码文件的权限

/www/wdlinux/rsync/bin/rsync --daemon  --config=/etc/rsyncd.conf  # 启动rsync服务; etc/rc.d/rc.local，设置开机启动 在最后添加/opt/app/rsync/bin/rsync --daemon --config=/opt/app/rsync/etc/rsync.conf

chkconfig rsync off
# service xinetd restart
# echo "/usr/bin/rsync --daemon">>/etc/rc.local
# /usr/bin/rsync --daemon

iptables -A INPUT -p tcp -m state --state NEW  -m tcp --dport 873 -j ACCEPT  //设置873端口通过服务器
ptables -L   //查看防火墙是否打开了873端口
ps -ef | grep rsync  //查看rsync进程是否开启

rsync  --list-only user1@***.***.***.***::uploadfile  # 查看rsync服务器上提供出来的同步文件列表（用户名@rsync服务器IP::模块名）
rsync --list-only rsync://bua@192.168.0.220/home
rsync -avzP -delete user1@***.***.***.***::uploadfile /data/test  # 将rsync服务器上uploadfile模块下的代码同步到本地/data/test下
rsync -avzP --delete rsync://bua@192.168.0.220/www /backups/192.168.0.220/$(date +'%y-%m-%d')/www # 保存历史归档
rsync -avzP --delete --exclude "lost+found/" /home/ hosta@192.168.0.221::hosta-home # 推送同步

# 首先在备份主机上部署如下的目录：
/backups/192.168.0.220/current # 存放同步的目录
/backups/192.168.0.220/archive # 存放归档的目录
rsync -avzP --delete bua@192.168.0.220::home /backups/192.168.0.220/current/home # 先备份，后存档
tar -cjf /backups/192.168.0.220/archive/home-$(date +'%y-%m-%d').tbz \
-C /backups/192.168.0.220/current/home .
```

```sh
## 客户端
echo “ucweb@file”>/etc/rsyncucweb.password
chmod 600 /etc/rsyncucweb.password
rsync -avz --password-file=/etc/rsyncucweb.password images@172.16.10.201::case /opt/case

vim /usr/sbin/rsync.sh # 设置自动化
rsync -avz --password-file=/etc/rsyncucweb.password images@172.16.10.201::case /opt/case 
tar -zcvf /opt/case.$(date +%Y-%m-%d).tar.gz /opt/case

chmod 770 /usr/sbin/rsync.sh
crontab –e
00 * * * * /bin/sh /usr/sbin/rsyncd.sh
```

```sh
HOMES="alan"
DRIVE="/media/WDPassport"

for HOME in $HOMES; do
    cd /home/$HOME
    rsync -cdlptgov --delete . /$DRIVE/$HOME # 拷贝它在源目录中发现的文件和目录
    find . -maxdepth 1 -type d -not -name "." -exec rsync -crlptgov --delete {} /$DRIVE/$HOME \;
done
```

## 参考

* [ncw/rclone](https://github.com/ncw/rclone):"rsync for cloud storage" - Google Drive, Amazon Drive, S3, Dropbox, Backblaze B2, One Drive, Swift, Hubic, Cloudfiles, Google Cloud Storage, Yandex Files https://rclone.org

