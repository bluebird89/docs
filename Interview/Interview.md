# Interview

* 掌握好基础
* 仔细阅读需求文档
* 大公司都有自己在用的框架，你进去后基本上得重新学这些框架，所以对他们来说，基础是否扎实才是考察的关键

## 方向

* web：前后端并不是对立的，而是纯粹的一家人。只是被国内外的一些市场强行分成了前后端，归根到底，是需要前后端都懂得
* 算法相关岗位(深度学习、计算机视觉等)
* 数据相关岗位：可视化是整个数据链路最外层，最后走高P还是需要理解整个链路层的。数据研发这个是在web开发的基础上用数据附能，懂可视化的一定是有前端能力的，懂hadoop的一定java玩的溜，属于web开发的拓展方向。
* 图形学相关岗位（比如网易开发游戏引擎的大牛等）
* 大规模系统的底层相关（阿里云）
* 安全相关

## 技能点

* Python语法以及其他基础部分
    1.可变与不可变类型；
    2.浅拷贝与深拷贝的实现方式、区别；deepcopy如果你来设计，如何实现；
    3.__new__() 与 __init__()的区别；
    4.你知道几种设计模式；
    5.编码和解码你了解过么；
    6.列表推导list comprehension和生成器的优劣；
    7.什么是装饰器；如果想在函数之后进行装饰，应该怎么做；
    8.手写个使用装饰器实现的单例模式；
    9.使用装饰器的单例和使用其他方法的单例，在后续使用中，有何区别；
    10.手写：正则邮箱地址；
    11.介绍下垃圾回收：引用计数/分代回收/孤立引用环；
    12.多进程与多线程的区别；CPU密集型适合用什么；
    13.进程通信的方式有几种；
    14.介绍下协程，为何比线程还快；
    15.range和xrange的区别（他妹的我学的py3…）；
    16.由于我有C/C++背景，因此要求用C来手写：将IP地址字符串（比如“172.0.0.1”）转为32位二进制数的函数。
* 数据结构与算法
    1.手写快排；堆排；几种常用排序的算法复杂度是多少；快排平均复杂度多少，最坏情况如何优化；
    2.手写：已知一个长度n的无序列表，元素均是数字，要求把所有间隔为d的组合找出来，你写的解法算法复杂度多少；
    3.手写：一个列表A=[A1，A2，…,An]，要求把列表中所有的组合情况打印出来；
    4.手写：用一行python写出1+2+3+…+10**8 ；
    5.手写python：用递归的方式判断字符串是否为回文；
    6.单向链表长度未知，如何判断其中是否有环；
    7.单向链表如何使用快速排序算法进行排序；
    8.手写：一个长度n的无序数字元素列表，如何求中位数，如何尽快的估算中位数，你的算法复杂度是多少；
    9.如何遍历一个内部未知的文件夹（两种树的优先遍历方式）
* 网络基础部分
    1.TCP/IP分别在模型的哪一层；
    2.socket长连接是什么意思；
    3.select和epoll你了解么，区别在哪；
    4.TCP UDP区别；三次握手四次挥手讲一下；
    5.TIME_WAIT过多是因为什么；
    6.http一次连接的全过程：你来说下从用户发起request——到用户接收到response；
    7.http连接方式。get和post的区别，你还了解其他的方式么；
    8.restful你知道么；
    9.状态码你知道多少，比如200/403/404/504等等；
* 数据库部分：
    - MySQL索引优化、查询优化和存储优化
    - MySQL数据库设计、管理和优化，具备数据库规划能力
    - MySQL锁有几种；死锁是怎么产生的；
    - 为何，以及如何分区、分表；
    - MySQL的char varchar text的区别；
    - 了解join么，有几种，有何区别，A LEFT JOIN B，查询的结果中，B没有的那部分是如何显示的（NULL）；
    - 索引类型有几种，BTree索引和hash索引的区别（我没答上来这俩在磁盘结构上的区别）；
    - 手写：如何对查询命令进行优化；
    - NoSQL了解么，和关系数据库的区别；
    - redis有几种常用存储类型；
    - 非关系型数据库（Redis，Memcached）
* Linux部分
    1.讲一下你常用的Linux/git命令和作用；
    2.查看当前进程是用什么命令，除了文件相关的操作外，你平时还有什么操作命令；（因为我本人Linux本身就很水，只会基本的操作，所以这部分面试官也基本没怎么问。。反正问了就大眼瞪小眼呗）
    - Shell编程
* django项目部分
    1.都是让简单的介绍下你在公司的项目，不管是不是后端相关的，主要是要体现出你干了什么；
    2.你在项目中遇到最难的部分是什么，你是怎么解决的；
    3.你看过django的admin源码么；看过flask的源码么；你如何理解开源；
    4.MVC / MTV；
    5.缓存怎么用；
    6.中间件是干嘛的；
    7.CSRF是什么，django是如何避免的；XSS呢；
    8.如果你来设计login，简单的说一下思路；
    9.session和cookie的联系与区别；session为什么说是安全的；
    10.uWSGI和Nginx的作用；
* 大流量与并发
* 分布式、集群
* 高并发、高负载、高可用系统
* 运维
    - devops理念，愿意用自动化、规范化的方式
* 缓存
* 队列
    - rabbitmq
* 架构
    - 设计模式
    - 重构
    - 架构设计

* 硬性
    - 必须4年以上工作经验
    - 教育经历要求计算机科学专业
    - 要求统招本科学历
    - 年龄要求必须小于32岁
    - 稳定性必须稳定性好
* Web技术栈、包括HTTP协议、Web安全、静态化设计、前后端分离架构；

## C++

* 熟悉分布式系统原理和C++

## Linux

```sh
# Linux如何挂载windows下的共享目录？
mount.cifs //IP地址/server /mnt/server -o user=administrator,password=123456 # linux 下的server需要自己手动建一个 后面的user与pass 是windows主机的账号和密码 注意空格 和逗号

# 如何查看http的并发请求数与其TCP连接状态？
netstat -n | awk ‘/^tcp/ {++b[$NF]}’ END {for(a in b) print a,b[a]}’
# 还有ulimit -n 查看linux系统打开最大的文件描述符，这里默认1024，不修改这里web服务器修改再大也没用。若要用就修改很几个办法，这里说其中一个： 修改/etc/security/limits.conf
* soft nofile 10240
* hard nofile 10240 # 重启后生效

# 如何用tcpdump嗅探80端口的访问看看谁最高
tcpdump -i eth0 -tnn dst port 80 -c 1000 | awk -F”.” ‘{print $1″.”$2″.”$3″.”$4″.”}’ | sort |uniq -c | sort -nr | head-5

# 如何查看/var/log目录下的文件数？
ls /var/log/ -1R | grep “-” | wc -l

# 如何查看Linux系统每个ip的连接数？
netstat -n | awk ‘/^tcp/ {print $5}’ | awk -F: ‘{print $1}’ | sort | uniq -c | sort -rn

# shell下生成32位随机密码
cat /dev/urandom | head -1 | md5sum | head -c 32 >> /pass

# 统计出apache的access.log中访问量最多的5个ip
cat access.log | awk ‘{print $1}’ | sort | uniq -c | sort -n -r | head -5

# 如何查看二进制文件的内容？
我们一般通过hexdump命令 来查看二进制文件的内容。
hexdump -C XXX(文件名) -C是参数 不同的参数有不同的意义
-C 是比较规范的 十六进制和ASCII码显示
-c 是单字节字符显示
-b 单字节八进制显示
-o 是双字节八进制显示
-d 是双字节十进制显示
-x 是双字节十六进制显示

# ps aux 中的VSZ代表什么意思，RSS代表什么意思？
VSZ:虚拟内存集,进程占用的虚拟内存空间
RSS:物理内存集,进程战用实际物理内存空间

# 如何检测并修复/dev/hda5？
fsck用来检查和维护不一致的文件系统。若系统掉电或磁盘发生问题，可利用fsck命令对文件系统进行检查

# 介绍下Linux系统的开机启动顺序
加载BIOS–>读取MBR–>Boot Loader–>加载内核–>用户层init一句inittab文件来设定系统运行的等级(一般3或者
5，3是多用户命令行，5是界面)–>init进程执行rc.syninit–>启动内核模块–>执行不同级别运行的脚本程序–>执行/etc/rc.d/rc.local(本地运行服务)–>执行/bin/login,就可以登录了。

# 符号链接与硬链接的区别
我们可以把符号链接，也就是软连接 当做是 windows系统里的 快捷方式。
硬链接 就好像是 又复制了一份，举例说明：
ln 3.txt 4.txt 这是硬链接，相当于复制，不可以跨分区，但修改3,4会跟着变，若删除3,4不受任何影响。
ln -s 3.txt 4.txt 这是软连接，相当于快捷方式。修改4,3也会跟着变，若删除3,4就坏掉了。不可以用了。

# 保存当前磁盘分区的分区表
dd 命令是以个强大的命令，在复制的同时进行转换
dd if=/dev/sda of=./mbr.txt bs=1 count=512

# 如何在文本里面进行复制、粘贴，删除行，删除全部，按行查找和按字母查找？
以下操作全部在命令行状态操作，不要在编辑状态操作。
在文本里 移动到想要复制的行 按yy 想复制到哪就移动到哪，然后按P 就黏贴了
删除行 移动到改行 按dd
删除全部 dG 这里注意G一定要大写
按行查找 :90 这样就是找到第90行
按字母查找 /path 这样就是 找到path这个单词所在的位置，文本里可能存在多个,多次查找会显示在不同的位置。

# 手动安装grub
grub-install /dev/sda

# 修改内核参数
vi /etc/sysctl.conf 这里修改参数
sysctl -p 刷新后可用

# 在1-39内取随机数
expr $[RANDOM%39] +1
RANDOM随机数
%39取余数范围0-38

# 限制apache每秒新建连接数为1，峰值为3
每秒新建连接数 一般都是由防火墙来做，apache本身好像无法设置每秒新建连接数，只能设置最大连接：
iptables -A INPUT -d 172.16.100.1 -p tcp –dport 80 -m limit –limit 1/second -j ACCEPT

# FTP的主动模式和被动模式
FTP协议有两种工作方式：PORT方式和PASV方式，中文意思为主动式和被动式。

PORT（主动）方式的连接过程是：客户端向服务器的FTP端口（默认是21）发送连接请 求，服务器接受连接，建立一条命令链路。当需要传送数据时，客户端在命令链路上用PORT 命令告诉服务器：“我打开了XX端口，你过来连接我”。于是服务器从20端口向客户端的 XX端口发送连接请求，建立一条数据链路来传送数据。

PASV（被动）方式的连接过程是：客户端向服务器的FTP端口（默认是21）发送连接请 求，服务器接受连接，建立一条命令链路。当需要传送数据时，服务器在命令链路上用PASV 命令告诉客户端：“我打开了XX端口，你过来连接我”。于是客户端向服务器的XX端口 发送连接请求，建立一条数据链路来传送数据。
从上面可以看出，两种方式的命令链路连接方法是一样的，而数据链路的建立方法就完 全不同。

# 显示/etc/inittab中以#开头，且后面跟了一个或者多个空白字符，而后又跟了任意非空白字符的行
grep “^#\{1,\}[^]” /etc/inittab

# 显示/etc/inittab中包含了:一个数字:(即两个冒号中间一个数字)的行
grep “\:[0-9]\{1\}:” /etc/inittab

# 怎么把脚本添加到系统服务里，即用service来调用？
在脚本里加入
#!/bin/bash
# chkconfig: 345 85 15
# description: httpd
然后保存
chkconfig httpd –add 创建系统服务
现在就可以使用service 来 start or restart

# 写一个脚本，实现批量添加20个用户，用户名为user01-20，密码为user后面跟5个随机字符
#!/bin/bash
#description: useradd
for i in `seq -f”%02g” 1 20`;do
useradd user$i
echo “user$i-`echo $RANDOM|md5sum|cut -c 1-5`”|passwd –stdinuser$i >/dev/null 2>&1
done

# 写一个脚本，实现判断192.168.1.0/24网络里，当前在线的IP有哪些，能ping通则认为在线
#!/bin/bash
for ip in `seq 1 255`
do
ping -c 1 192.168.1.$ip > /dev/null 2>&1
if [ $? -eq 0 ]; then
echo 192.168.1.$ip UP
else
echo 192.168.1.$ip DOWN
fi
}&
done
wait

# 写一个脚本，判断一个指定的脚本是否是语法错误；如果有错误，则提醒用户键入Q或者q无视错误并退出其它任何键可以通过vim打开这个指定的脚本
#!/bin/bash
read -p “please input check script-> ” file
if [ -f $file ]; then
sh -n $file > /dev/null 2>&1
if [ $? -ne 0 ]; then
read -p “You input $file syntax error,[Type q to exit or Type vim to edit]” answer
case $answer in
q | Q)
exit 0
;;
vim )
vim $file
;;
*）
exit 0
;;
esac
fi
else
echo “$file not exist”
exit 1
fi

# 写一个脚本，要求如何：
创建一个函数，能接受两个参数：
1)第一个参数为URL，即可下载的文件；第二个参数为目录，即下载后保存的位置；
2)如果用户给的目录不存在，则提示用户是否创建；如果创建就继续执行，否则，函数返回一个51的错误值给调用脚本；
3)如果给的目录存在，则下载文件；下载命令执行结束后测试文件下载成功与否；如果成功，则返回0给调用脚本，否则，返回52给调用脚本；

[root@localhost tmp]# cat downfile.sh
#!/bin/bash
url=$1
dir=$2
download()
{
cd $dir >> /dev/null 2>&1
if [ $? -ne 0 ];then
read -p “$dir No such file or directory,create?(y/n)” answer
if [ “$answer” == “y” ];then
mkdir -p $dir
cd $dir
wget $url 1> /dev/null 2>&1
else
return “51”
fi
fi
if [ $? -ne 0 ]; then
return “52”
fi
}
download $url $dir
echo $?

# 写一个脚本，详细需求如下：

1、创建一个函数，可以接受一个磁盘设备路径（如/dev/sdb）作为参数;在真正开始后面步骤之前提醒用户有危险，并让用户选择是否继续；而后将此磁盘设备上的所有分区清空（提示，使用命令dd if=/dev/zero of=/dev/sdb bs=512 count=1实现，注意其中的设备路径不要写错了；
如果此步骤失败，返回67给主程序；
接着在此磁盘设备上创建两个主分区，一个大小为100M，一个大小为1G；如果此步骤失败，返回68给主程序；
格式化此两分区，文件系统类型为ext3；如果此步骤失败，返回69给主程序；
如果上述过程都正常，返回0给主程序；

2、调用此函数；并通过接收函数执行的返回值来判断其执行情况，并将信息显示出来；

local Darray=(`ls /dev/sd[a-z]`)
for i in ${Darray};do
[[ “$i” == “$1” ]] && Sd=$i &&break
done
else
return66
fi

#当匹配成功，进入选择，告诉用户，是否继续，输错的话进入无限循环，当用户选择Y,则清空目标分区，且跳出while循环

while :;do
read -p “Warning!!!This operation will clean $Sd data.Next=y,Quit=n [y|n]:” Choice
case $Choice in
y)
dd if=/dev/zero of=$Sd bs=512 count=1 &> /dev/null &&break || return 67 ;;
n)
exit 88 ;;
*)
echo “Invalid choice,please choice again.” ;;
esac
done

#使用echo传递给fdisk进行分区，如果此命令失败，则跳转出去，错误值68，需要注意的是，有时候这个返回值很诡异，笔者之前成功与否都是返回的1，后来重启之后，就好了，如果慎重的话，可以对创建的分区，进行判断，不过就需要使用其他工具截取相关字段了，虽有些小麻烦，但无大碍

echo-e “n\np\n1\n\n+100M\nn\np\n2\n\n+1024M\nw\n”|fdisk /dev/sdb&> /dev/null || || return 68

#格式化之前，让内核重新读取磁盘分区表，值得注意的是，有的系统版本，使用partprobe无效，譬如笔者的环境是rhel5.8，而rhel6.0以后，这个命令就很危险了，而使用partx -a /dev/sdb则效果更好…此项需慎重，如果格式化失败，则告知把失败的分区定义成变量，且跳出函数，并带出错误值69

`partprobe`
Part=`fdisk -l /dev/$Sd|tail -2|cut -d” ” -f1`
for M in ${Part};do
mke2fs -j $M &> /dev/null && ErrorPart=$M &&return 69
done
return 0
}

#下面代码，调用函数，接收函数返回值，根据返回值进行判断哪里出错。

Disk_Mod $1
Res=$?
[ $Res-eq 0 ] && exit 0
[ $Res-eq 66 ] && echo “Error! Invalid input.”
[ $Res-eq 67 ] && echo “Error! Command -> dd fdisk mke2fs

28、如何让history命令显示具体时间？
HISTTIMEFORMAT=”%Y-%m-%d %H:%M:%S”
export HISTTIMEFORMAT
重新开机后会还原，可以写/etc/profile
```

## 算法

* 神经网络翻译系统
* 熟悉深度学习常用和最新算法及模型，掌握深度学习的基础数学原理，熟练使用TensorFlow等训练平台
* 1000 瓶药，又一个有毒，10个瓶子，10个小白鼠
    - 瓶子进行二进制编码，11111 00000
    - 对应的位给小白鼠喝
* 计算两个文件相对路径
* 字符串的所有组合

## 习惯

* 每年一定要拿出两个月出去面试——不管你要不要走。需要不断评估自己的价格，和发现自己身上的缺点及时弥补。
* 多与猎头保持联系和沟通，随时了解自己在行业内的合理价值，以及行业内最新的高薪技能诉求。务必保持自己的职场竞争力。
* 你的价格是市场决定的，而不是你的能力。
* 真正让你成为Java大牛的是你懂的不同语言的哲学，懂得不同场景下发挥出Java的优势，规避Java的劣势，深知Java的优缺点。而不是抱着Java是最好的语言，写一辈子Java。
* 在Web这条线上想走到高P，基本上都是走业务架构这条路，这考验的就是大局观了。你只会一个前端或者一个Java根本不够格。纯粹研究技术上P10的基本上属于蜀道难了——说的清楚点，对于传统的Web开发工程师（前后端）不通过管理走高P基本上只有往架构方向走，这个时候靠的是你全面的能力和良好的大局观,你当初的那些前端技术、后端技术就是个敲门砖。
* 不转型，人到中年会越来越被动，转型，路很长，而且很不好走。
* 转型是条不归路，走了就回不去了。
* 都是锦上添花，鲜有人雪中送碳。求伯乐不如求已。
* 核心竞争力建立的基础，是市场的稀缺。做高管，操大盘。
* 精力是有限的，深度和广度如何平衡是个问题，有了广度要不要转型是个问题，深度的积累在转型时价值会骤降，敢不敢，舍不舍得

## 前端

* 精通各种 Web 前端技术和标准，熟练掌握 ES2015 语法；
* 至少掌握React、Vue等一种主流框架，能独立开发高质量组件；
* 熟悉SVG、Canvas等前端绘图技术，有大数据可视化开发经验优先考虑；

## 软技能

* 主动、皮实、聪明、担当，有良好的沟通和团队协作能力，持续推动拿结果；
* 喜欢钻研技术，能够快速掌握和应用新技术，有开源项目贡献经验优先考虑。

## 案例

张丹：从程序员开始，到架构师一路走来，经历过太多的系统和应用。做过手机游戏，写过编程工具；做过大型Web应用系统，写过公司内部CRM；做过SOA的系统集成，写过基于Hadoop的大数据工具；做过外包，做过电商，做过团购，做过支付，做过SNS，也做过移动SNS。以前只用Java，然后学了PHP，现在用R和Javascript。最后跳出IT圈，进入金融圈，研发量化交易软件。

## Remote Job

整个 Github 公司有 60% 的员工是在家里远程办公。新员工培训：在公司内的聊天室内，静静地看别人聊天，体会一下别人是如何工作的

# 面试

### 前端篇

#### HTML

HTML 由元素组成，可以被多个属性修饰。元素和属性是 HTML 里最重要的两个概念。

* （基础）HTML 元素的初级划分：[块级元素](https://developer.mozilla.org/en-US/docs/Web/HTML/Block-level_elements)和[行内元素](https://developer.mozilla.org/en-US/docs/Web/HTML/Inline_elements)，初学者必须非常了解这两则的区别，能够识别常用的元素到底是块级还是行内元素。
* （进阶）但是上述划分并没有从语义化上进行区分，所以可以从语义化、功能化上进行分类，见 [HTML 元素参考](https://developer.mozilla.org/en-US/docs/Web/HTML/Element) 章节。
* （进阶）再高级一点从 Content Model 上划分，见 Content categories 或 [HTML 规范](https://html.spec.whatwg.org/multipage/dom.html#kinds-of-content)。
* （Code Review）另外可以查缺补漏，看看 [HTML 属性参考](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes) 章节的内容，熟悉常用的属性，并且了解一些冷门的属性的使用技巧。
* （实战）结合上述参考，需要懂得 HTML 在段落、表格、表单、多媒体（视频、图片等）、SEO 上的应用。

#### CSS

* [选择器](https://developer.mozilla.org/en-US/docs/Learn/CSS/Introduction_to_CSS/Selectors)
* [数据类型](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Types)（单位）
* [文本](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Text) & [字体](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Fonts)
* 布局:前四点是 display 的概念，再后面两点是位移相关，最后两点是变种，懂得其中的概念，懂得根据项目情况灵活运用即为基础扎实。
    - [Table](https://developer.mozilla.org/zh-CN/docs/Web/CSS/CSS_Table)（ungrid 方案）
    - Inline Block（巧妙）
    - [Flexible Box](https://developer.mozilla.org/zh-CN/docs/Web/CSS/CSS_Flexible_Box_Layout)（主流）
    - [Grid](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Grid_Layout)（草案）
    - [Positioning](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Positioning)（位移）
    - [Transforms](https://developer.mozilla.org/zh-CN/docs/Web/CSS/CSS_Transforms)（位移）
    - [Float](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Positioning)（经典）
    - [Columns](https://developer.mozilla.org/zh-CN/docs/Web/CSS/CSS_Columns)（巧妙）
* [盒模型](https://developer.mozilla.org/en-US/docs/Learn/CSS/Styling_boxes/Box_model_recap):从里到外相关的属性有
    - width 和 height，包括 min 和 max
    - padding
    - border/box-sizing/box-shadow
    - margin
    - overflow
    - outline
* 动画，包括两方面 transition（过渡） 和 animation（时间轴和关键帧）

#### JavaScript

与 HTML 和 CSS 相关的 [DOM](https://developer.mozilla.org/en-US/docs/Web/API/Document_Object_Model) 和 [CSSOM](https://developer.mozilla.org/en-US/docs/Web/API/CSS_Object_Model) （重点研究对象）的相关 API 是初级开发需要掌握的。

#### 协议篇

WEB 是通过 HTTP 协议进行客户端和服务端间通信的，对于 WEB 应用开发，理解 HTTP 协议非常关键，其次要了解整个 TCP/IP 协议族，如果是游戏开发，理解 TCP 协议也非常关键，这部分建议看书：

* 首推《[图解HTTP](https://book.douban.com/subject/25863515/)》，初级开发来说
* 再看《[HTTP权威指南](https://book.douban.com/subject/10746113/)》，后面几个章节可以不用看。
* 对 SSL、TLS 感兴趣可以捎带看《[HTTPS权威指南 : 在服务器和Web应用上部署SSL/TLS和PKI](https://book.douban.com/subject/26869219/)》
* 如果想更进一步可以看《[TCP/IP详解](https://book.douban.com/series/12438)》系列。

#### HTTP 协议

* URL:URL 部分需要了解 URL 的结构组成部分，尤其需要知道如何处理编码的问题。
* 报文:报文的结构，包括请求报文和响应报文，重点考察的知识点包括：请求方法，响应状态码和首部字段。首部字段，考察重点主要在 Cookie、Authorization 还有 CORS 相关问题。
* SSL & TLS:HTTP + 加密 + 认证 + 完整性保护 = HTTPS.进阶看《[HTTPS权威指南 : 在服务器和Web应用上部署SSL/TLS和PKI](https://book.douban.com/subject/26869219/)》

#### HTTP/2.0

实战的重点在于 [HTTP](https://developer.mozilla.org/en-US/docs/Web/HTTP) 的实际应用，大致分两点：HTTP Server 和 HTTP Client。

HTTP 服务端其实就是 WEB 服务器，初步可以从 Nginx + php-fpm 和 Apache + mod_php 着手，后续的可以捣鼓 Socket 相关的扩展，国内比较推荐 swoole，小众的 reactphp、amphp 代码写的也非常优雅，这方面主要是 Socket，有时间可以重点看看 《[TCP/IP详解 卷1：协议](https://book.douban.com/subject/1088054/)》和《[UNIX网络编程 卷1：套接字联网API（第3版）](https://book.douban.com/subject/4859464/)》。

PHP 没有官方标准的 HTTP 类库，但是有个 PSR-7 标准，自己动手实践，实现这个标准的接口能大致理解 HTTP 的实战应用到底体现在哪里，这里会初步涉猎 I/O Streams 方面的知识，为以后进阶 Socket 编程奠定基础。

HTTP 客户端，PHP 只提供了 cURL 扩展，基本无敌，能搞定很多跨平台数据调用，进阶可以感受下 Socket 实现，不局限与应用层（HTTP），还可以直接走传输层（TCP/UDP），这方面重点考察 REST 的应用，进阶可以考察 RPC 之类。

另外 HTTP（还有一些相关协议） 应用，如果没有各种 SaaS 平台的使用和开发经验那是非常吃亏的，这方面的经验积累是长期的也是进阶的关键。

### PHP 篇

从编程语言的角度出发，考察更多的是编程语言的硬实力，而并非花哨的各种应用。

#### 基础

基础来说，翻阅 PHP 官方文档，翻两年就差不多了。如果是考察编程语言的硬实力主要体现在三方面：

* 数据结构
* 算法
* 设计模式

#### 数据结构与算法

数据结构与算法是密不可分的，初级开发熟悉 string 和 array 的各种增删改查排比操作是重点，感兴趣的还可以了解一下 PHP 的数据结构扩展库，除了 SPL 标准库还有个 ext-ds 扩展。

如果想学习数据结构与算法，首推《[算法（第4版）](https://book.douban.com/subject/19952400/)》一书，比《算法导论（原书第2版）》好理解多了，中高级 PHP 开发必读，可以针对性的写一些 PHP 实现。

另外，推荐一本刷算法的《[程序员代码面试指南：IT名企算法与数据结构题目最优解](https://book.douban.com/subject/26638586/)》，同样可以针对性的写一些 PHP 实现。

游戏应用算法会涉及的比较多，WEB 应用数据结构会涉及的比较多，尤其在各种解析器、编译器的实现上。感兴趣的可以自己去写一些模板引擎、编辑器的实现，个人比较推荐大家自己动手实现下 YAML 解析，YAML & JSON 在互联网跨平台上有广泛的应用。

#### 设计模式

对于初学者来说，先从面向对象开始着手，致力于写可读性、可维护性代码就行了，设计模式对于初级开发我的建议是忘了它吧。 实际一点，坚持 GitHub 上翻两年代码也差不多了，培养 Code Review 能力。实战可以自己去实现框架的方方面面，从这个过程中去理解设计模式，对于设计模式来说不要为了用而用。

#### 进阶

多进程、多线程相关，异步思维的培养。

* swoole 全套
* libev 和 libevent 之类的 PHP 扩展库（PHP 7 之后就剩 ext-event 扩展库了）
* PHP 的多线程 ext-pthreads 库，目前正在发展中，PHP 7.2+，需要开启 zts。

在这个过程中，势必会不断的了解 C/C++ 编写的扩展库，为以后进军高级开发带来很大帮助。

#### 高级

高级 PHP 开发不懂 C/C++ 是非常吃亏的，个人建议 PHP 开发也有必要学习 C/C++ 编程，不求精通，但是要有一定的理解和阅读 C/C++ 代码的能力。

初步可以从了解 PHP 内核着手，PHP 5 和 PHP 7 有很大的不同，建议直接看 7 的。盘古大叔的《[PHP7内核剖析](https://github.com/pangudashu/php7-internal)》总结还不错的，建议入门的人看看。

扩展库：国外的 PHP-CPP 和国内的 PHP-X，另外还有 phalcon 的 zephir。

### 框架篇

首先说个现在 PHP 里也流行起来的 IoC 容器，IoC 的概念简单的说来：

IoC（控制反转）目前比较流行的两种方式 DI（依赖注入模式，被动） 和 SL（服务器定位模式，主动），DI 是遵循 DIP（依赖反转原则）的，SL 是 anti-pattern（反模式）的，不遵循 DIP。因为注入的形式五花八门，为了代码复用性和扩展性出现了 IoC 容器这么个东西，它是遵循各自 DI/SL 模式实现的容器，IoC 容器会大量运用反射机制来实现。

Laravel 中 Container（illuminate/container）是 DI/SL 的混合体。关于这个概念，可以多读几遍下面这篇文章（Java 版）：

[Inversion of Control Containers and the Dependency Injection pattern](https://martinfowler.com/articles/injection.html) [[译文](http://files.cnblogs.com/files/dongbeifeng/DependencyInjection.pdf)]

#### 基础

说回到框架，核心主要有三部分：HTTP、Routing 和 MVC，推荐看 Slim 框架的底层代码。

* HTTP 的 Request、Response 是必备，其次还有 Cookie & Session，这些都是面试的考点。
* Routing 核心其实就是 Event Dispatching 的概念，Lumen 和 Slim 都用的 FastRoute，底层实现写的非常不错。不过，如果想规范化的学习 Routing，建议看 symfony/routing 的实现。
* MVC 方面：Model 是核心，View 和 Controller 有各种变形。Model 分 Active Record 和 Data Mapper，对于的有 Eloquent（AR）和 Doctrine 2（DM）两大阵营（其他框架的使用者不要喷我）。

#### 进阶

* 初步，可以从学习和阅读框架源码开始，symfony 的组件化思路是非常值得推荐和学习的。
* 其次，可以从 swoole 全套着手了解异步思维。
* 另外，ext-event 扩展库相关的 PHP 类库，如 reactphp、amphp、workerman 等等也是非常值得学习使用。

### MySQL

#### 初级

重点放在 SQL，用好相关 ORM 就可以了，在实践中出问题，面向 Google 编程来解决。另外的重点，表结构设计，从我个人浅薄的经验来总结，大致有：

* 文章类
* 评论类
* 日历相关，课程表、日历事件等
* 时刻表，运动健身相关，或者是一些小程序
* 票务相关，电影票、火车票、机票等等（与时刻表相关联）
* 订单类，只要有支付就有订单。
* 用户相关，尤其是涉及权限时的处理。

#### 高级

大型网站还可以从数据库读写分离下功夫，解决数据库高负载的问题。再高级一点把数据库抽象为数据访问的相关服务平台，那内容可以引申出多个方面：

* 数据库
* 文件存储
* NoSQL
* 缓存
* 搜索引擎

### Docker

Docker 的出现实在是太赞了，以前需要通过 VM 来捣鼓的东西，现在 Docker 就可以做了。非常有利于培养 Service 思维。

#### 初级

从实战着手，尤其是了解 Linux CLI 和 shell 编程，重点推荐《[Linux命令行与shell脚本编程大全 第3版](https://book.douban.com/subject/26854226/)》一书，入门首选。原理方面《[现代操作系统（第3版）](https://book.douban.com/subject/3852290/)》可以看看，重点看进程与线程、I/O、死锁三个章节。

#### 实战

英文不错直接上手官方文档就可以了，中文方面可以看书《[Docker — 从入门到实践](https://yeasy.gitbooks.io/docker_practice/content/)》

Docker 初级的重点在于 Dockerfile 镜像，Linux CLI 和 shell 编程在这里就非常有用了。会涉及到 Nginx、PHP、MySQL、Redis 等配置问题。

如果自己不知道怎么配，可以学习 [LaraDock](https://github.com/laradock/laradock)，不过 LaraDock 有点臃肿，但是用来学习和提高认知是非常有帮助的。

## 要求

* 熟悉linux/unix系统与开发环境
    - Linux内核、文件系统、IO调优
* 熟悉TCP/IP协议
* 网络编程
    - 多线程编程
* 具有MySQL索引优化、查询优化和存储优化经验
* memcache、redis、mongodb等常用nosql解决方案
* 消息队列
* Swoole
* yaf
* Shell
* Go
    - 对Kubernetes的定制化开发
    - docker、kubernetes
    - 微服务
        + 微服务产品（服务框架，RPC，Service Mesh，服务注册中心，定时任务，动态配置，服务治理，应用容器等
* Ruby
* 业务
    - 支付接口
* 测试
    - 自动化测试和持续集成
    - Test Driven
* 数据结构与算法
* 领域建模
* 敏捷开发
* 分布式系统、集群管理
    - paxos/raft
    - Ceph/HDFS/GlusterFS
* C++
    - 音频
        + 各种音频算法在移动端(Android/iOS)或服务端的实现和优化, 包括不限于: 音效算法, 音频/语音前后处理增强算法(降噪/回声消除等), 音乐信息检索算法, 音频传输及编解码算法等
* 大数据
    - Hadoop/Spark/Hive/Flink/Kafka/Druid
* 前端技术
    - 如AngulaJS, ReactJS

## 工具

* [salomonelli/best-resume-ever](https://github.com/salomonelli/best-resume-ever):Build fast 🚀 and easy multiple beautiful resumes and create your best CV ever! Made with Vue and LESS.
- [lukasz-madon/awesome-remote-job](https://github.com/lukasz-madon/awesome-remote-job)

## 资源

* [yangshun/tech-interview-handbook](https://github.com/yangshun/tech-interview-handbook):💯 Algorithms, front end and behavioral content for rocking your coding interview 🆕 Interview Cheatsheet! 🆕
* [jwasham/coding-interview-university](https://github.com/jwasham/coding-interview-university):A complete computer science study plan to become a software engineer.
* [jdsutton/Technical-Interview-Megarepo](https://github.com/jdsutton/Technical-Interview-Megarepo):Study materials for SE/CS technical interviews
* [h5bp/Front-end-Developer-Interview-Questions](https://github.com/h5bp/Front-end-Developer-Interview-Questions):A list of helpful front-end related questions you can use to interview potential candidates, test yourself or completely ignore.
* [arialdomartini/Back-End-Developer-Interview-Questions](https://github.com/arialdomartini/Back-End-Developer-Interview-Questions):A list of helpful back-end related questions you can use to interview potential candidates, test yourself or completely ignore.
* [MaximAbramchuck/awesome-interview-questions](https://github.com/MaximAbramchuck/awesome-interview-questions)::octocat: A curated awesome list of lists of interview questions. Feel free to contribute! 🎓 https://github.com/BotCube/awesome-bots
* [kdn251/interviews](https://github.com/kdn251/interviews):Everything you need to know to get the job.
* [ElemeFE/node-interview](https://github.com/ElemeFE/node-interview):How to pass the Node.js interview of ElemeFE.
* [alex/what-happens-when](https://github.com/alex/what-happens-when):An attempt to answer the age old interview question "What happens when you type google.com into your browser and press enter?"
* [kamranahmedse/developer-roadmap](https://github.com/kamranahmedse/developer-roadmap):Roadmap to becoming a web developer in 2018
* [fejes713/30-seconds-of-interviews](https://github.com/fejes713/30-seconds-of-interviews):A curated collection of common interview questions to help you prepare for your next interview. https://30secondsofinterviews.org
* [30-seconds/30-seconds-of-interviews](https://github.com/30-seconds/30-seconds-of-interviews):A curated collection of common interview questions to help you prepare for your next interview. https://30secondsofinterviews.org
* [imhuay/Algorithm_Interview_Notes-Chinese](https://github.com/imhuay/Algorithm_Interview_Notes-Chinese):2018/2019/校招/春招/秋招/算法/机器学习(Machine Learning)/深度学习(Deep Learning)/自然语言处理(NLP)/C/C++/Python/面试笔记
* [frank-lam/2019_campus_apply](https://github.com/frank-lam/2019_campus_apply):🚀 Full Stack Developer Tutorial，后台技术栈/全栈开发/架构师之路，秋招/春招/校招/面试。 from zero to hero.
* [basecamp/handbook](https://github.com/basecamp/handbook):Basecamp Employee Handbook https://basecamp.com/about
* [WsmDyj/Interview](https://github.com/WsmDyj/Interview):Some interview experience
* [CyC2018/CS-Notes](https://github.com/CyC2018/CS-Notes):😋 技术面试必备基础知识 https://cyc2018.github.io/CS-Notes
* [0voice/interview_internal_reference](https://github.com/0voice/interview_internal_reference):2019年最新总结，阿里，腾讯，百度，美团，头条等技术面试题目，以及答案，专家出题人分析汇总。
* [qinxuewu/interview-docs](https://github.com/qinxuewu/interview-docs):Java知识学习总结+源码阅读笔记。
