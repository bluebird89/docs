# Shell

* 之所以叫Shell,因为隐藏了操作系统底层的细节,是Linux/Unix的一个外壳。作为命令解析器负责外界与Linux内核的交互，接收用户或其他应用程序的命令，然后把这些命令转化成内核能理解的语言，传给内核，内核是真正干活的，干完之后再把结果返回用户或应用程序
* 支持模糊匹配符
* 每次bash会生成子shell进程，只有部分父进程的环境被复制到子shell环境中
* 利用exit命令有条不紊地退出子shell
* 命令列 表要想成为进程列表，这些命令必须包含在括号里 `(pwd ; ls ; cd /etc ; pwd ; cd ; pwd ; ls)` 生成了一个子shell来执行对应的命令
* 要想知道是否生成了子shell，借助一个使用了环境变量的命令。`echo $BASH_SUBSHELL` 如果该命令返回0，就表明没有子shell。如果返回 1 或者其他更大的数字，就表明存在子shell。 `( pwd ; echo $BASH_SUBSHELL)`
* 生成子shell的成本不低，而且速度还慢。创建嵌套子shell更是火上浇油
* 命令行shell：系统的用户界面，提供了用户与内核进行交互操作的一种接口。接收用户输入的命令并把它送入内核去执行，是一个命令解释器
  - Bourne Shell：是贝尔实验室开发的
  - BASH：GNU的Bourne Again Shell，是GNU操作系统上默认的shell,大部分linux的发行套件使用的都是这种shell
  - Korn Shell：是对Bourne SHell的发展，在大部分内容上与Bourne Shell兼容
  - C Shell：是SUN公司Shell的BSD版本

## 配置

* /etc/profile：所有用户的shell都有权使用配置好的环境变量 不管是哪个用户，登录时都会读取该文件.建议不修改这个文件
* /etc/bashrc:全局（公有）配置，bash shell执行时，不管是何种方式，都会读取此文件. 在这个文件中添加系统级环境变量
* bash_profile  ~/.bashrc 用户登录时，该文件仅仅执行一次。用来设置环境变量功能和/etc/profile 相同只不过只针对用户来设定
    - ~/.bash_profile:一般在这个文件中添加用户级环境变量
    - 如果ssh方式远程登录Linux时，会自动执行用户家目录下的.bash_profile文件，所有可以在这个文件里面添加一些内容，以便ssh登录Linux时都会执行相应的内容。
* ~/.zshrc：zsh配置文件
* `echo PATH="$PATH:/my_new_path"`:临时添加，关闭后失效
* 选项如果单字符选项前使用一个减号-。单词选项前使用两个减号--
* alias
	- `alias c='clear'`
	- disable
		+ /usr/bin/clear
		+ \c
		+ command ls
	- `unalias aliasname`
* alias参考
    - https://www.digitalocean.com/community/questions/what-are-your-favorite-bash-aliases
    - https://www.linuxtrainingacademy.com/23-handy-bash-shell-aliases-for-unix-linux-and-mac-os-x/
    - https://brettterpstra.com/2013/03/31/a-few-more-of-my-favorite-shell-aliases/
    - [standard-aliases ](https://github.com/gto76/standard-aliases):Attempt at defining a standard extension to Linux in form of Bash functions
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

# /etc/profile
export PATH=$PATH:/opt/perl/site/bin:/opt/perl/bin

bash <(curl -s https://gist.github.com/Jacksgong/9d0519f68b7940a07075a834b3178979/raw/803256593b7b05177408ccbc0bc68e072a8e3a0a/init-shell.sh)

# ~/.inputrc
set completion-ignore-case on
```

## [Coreutils - GNU core utilities](https://www.gnu.org/software/coreutils/)

the basic file, shell and text manipulation utilities of the GNU operating system

## 文件描述符

* 命令行会打开三个文件
    - 标准输入文件:stdin文件描述符为0
    - 标准输出文件:stdout文件描述符为1
    - 标准错误文件:stderr文件描述符2

## 变量

* 命名
    - 只能由大小写字母，数字和下划线组成
    - 变量名称不能以数字开头
    - 以存储数字类型或者字符串类型
    - 赋值等号两边不能有空格
    - 字符串的变量可以用单引号或者双引号括起来,单引号内容原样输出，不能包含变量.双引号 可以出现转义字符
* 调用：使用$符号或者$符号加上花括号。一般来讲使用花括号的用法
* 使用readonly将变量定义为只读，只读意味着不能改变
* 分类
    - 环境变量：保存操作系统运行时使用的参数,长期使用，可以把它们写在配置文件中。 /etc/profile 或者 用户家目录的.bash_profile
        + 基本上都是使用全大写字母，以区别于普通用户的环境变量
        + set命令会显示为某个特定进程设置的所有环境变量，包括局部变量、全局变量以及用户定义变量
        + 引用某个环境变量的时候，必须在变量前面加上一个美元符`($)`.显示变量当前值、让变量作为命令行参数.如果要用到变量，使用$;如果要操作变量，不使用$
        + 可作为数组使用
        + `printenv`
        + `export kaka="kaka"`
        + `unset kaka`
    - 位置变量：传递脚本参数时使用
    - 预定义变量：类似于环境变量，不同是不能重定义
        + `$0`  脚本名称
        + `$n`  传给脚本/函数的第n个参数
        + `$$`  脚本的PID
        + `$!`  上一个被执行的命令的PID(后台运行的进程)
        + `$?`  上一个命令的退出状态(管道命令使用${PIPESTATUS})
        + `$#`  传递给脚本/函数的参数个数 能够处理空格参数，而且参数间的空格也能正确的处理
        + `$@`  传递给脚本/函数的所有参数(识别每个参数) 用双引号括起来
        + `$*`  传递给脚本/函数的所有参数(把所有参数当成一个字符串)
        + `${10}`   在超过两位数的参数时，使用大括号限定起来
        + `@`与`"*"`区别:在使用双引号的时候。如果脚本运行时两个参数为a,b，则"*"等价于"ab",而"@"等价于"a","b"
    - 自定义变量：由用户自定义,可用于用户编写的脚
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

## 运算符

* 算数运算符
    - 规则：`expr 表达式`
        + 运算符号两边要有空格
        + 遇到特殊符号如*号需要在前面加反斜杠
        + 空格和特殊字符串需要用引号括起来
        + 操作:(先编写一个运算相关的shell脚本)
* 关系运算符
    - `-eq` 相等
    - `-ne` 不等
    - `-gt` d大于
    - `-lt` 小于
    - `-gt` 大于等于
    - `-le` 小于等于
* 布尔运算符
    - `!` 非运算
    - `-O` 或
    - `-a` 与
* 逻辑运算符
    - `&&` and
    - `||` or
* 字符串运算符
    - `=` 是否相等
    - `！=` 不相等
    - `-z` 长度为0
    - `-n` 长度不为0
    - `str` 是否为空
    - `<`   字符串比较(双中括号里不需要转移)
    - `==`  以Globbing方式进行字符串比较(仅双中括号里使用，参考下文)
    - `=~`  用正则表达式进行字符串比较(仅双中括号里使用，参考下文)
* 文件测试运算符
    - -b 是否块设备
    - -c 是否字符设备
    - -d 是否目录
    - -e 文件、目录是否存在
    - -f 是否普通文件
    - -g 是否设置SGID
    - -k 是否设置粘着位
    - -p 是否具名管道
    - -u 是否设置SUID
    - -r 是否可读
    - -w 是否可写
    - -s 文件是否为空
    - -x 文件是否可执行

## 语法

* 应用
    - 不适用场景
        + 比数组更复杂的数据结构
        + 出现了复杂的转义问题
        + 有太多的字符串操作
        + 不太需要调用其它程序和跟其它程序管道交互
    - 从bash 3.2版开始，正则表达式和globbing表达式都不能用引号包裹。如果表达式里有空格，可以把它存储到一个变量里
    - local:函数内部变量
    - readonly:只读变量
    - 尽量对bash脚本里的所有变量使用local或readonly进行注解
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
    - 防御式编程，在正式执行命令前，把相关的东西都检查好，比如，文件目录有没有存在
* 调试
* `前置 commands ; command1 && command2 || command3 ; 跟随 commands` 假如 command1 退出时返回码为零，就执行 command2，否则执行 command3
    - command1 && command2 这样的控制语句能够运行的原因是，每条命令执行完毕时都会给 shell 发送一个返回码，用来表示它执行成功与否。默认情况下，返回码为 0 表示成功，其他任何正值表示失败
* “&” 脚本在后台运行时使用它
* “&&”当前一个脚本成功完成才执行后面的命令

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

## 进程管理

* ps(process status):能够给出当前系统中进程的快照,捕获系统在某一事件的进程状态
* 语法格式
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
* sleep命令会在后台(&)睡眠3000秒(50分钟)。当被置入后台，在shell CLI提示符返回 之前，会出现两条信息
	- 第一条信息是显示在方括号中的后台作业(background job)号(1)
	- 第二条是后台作业的进程ID(2396)
* `jobs -l`:将进程列表置入后台模式。既可以在子shell中 进行繁重的处理工作，同时也不会让子shell的I/O受制于终端
* 协程
    - 在后台生成一个子shell，并在这个子shell中执行命令 `coproc My_Job { sleep 10; }`
    - 扩展语法:必须确保在第一个花括号({)和命令名之间有一个空格。还必须保证命令以分号(;)结尾。另外，分号和闭花括号(})之间也得有一个空格

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
    - 参数
        + -a 列出所有当前的连接
        + -t 列出 TCP 协议的连接
        + -u 列出 UDP 协议的连接
        + -n 禁用域名解析功能. 默认情况下 netstat 会通过反向域名解析技术查找每个 IP 地址对应的主机名,降低查找速度。如果觉没有必要知道主机名
* nc netcat命令 nc/netcat(选项)(参数)
  - 实现任意TCP/UDP端口的侦听，nc可以作为server以TCP或UDP方式侦听指定端口
  - 端口的扫描，nc可以作为client发起TCP或UDP连接
  - 机器之间传输文件
  - 机器之间网络测速
  - 选项
      + -g<网关>：设置路由器跃程通信网关，最多设置8个；
      + -G<指向器数目>：设置来源路由指向器，其数值为4的倍数；
      + -i<延迟秒数>：设置时间间隔，以便传送信息及扫描通信端口；
      + -l：使用监听模式，监控传入的资料，nc被当作server，侦听并接受连接，而非向其它地址发起连接
      + -n：直接使用ip地址，而不通过域名服务器；
      + -o<输出文件>：指定文件名称，把往来传输的数据以16进制字码倾倒成该文件保存；
      + -p<通信端口>：设置本地主机使用的通信端口；
      + -r：指定源端口和目的端口都进行随机的选择；
      + -s<来源位址>：设置本地主机送出数据包的IP地址
      + -u：使用UDP传输协议，默认为TCP
      + -v：显示指令执行过程，输出交互或出错信息，新手调试时尤为有用
      + -w<超时秒数>：设置等待连线的时间；
      + -z：使用0输入/输出模式，只在扫描通信端口时使用。

```sh
netstat -an | grep 3306
netstat -tunlp |grep 端口号 # 查看指定的端口号的进程情况 -t 显示tcp -u udp -n:拒绝显示别名，能数字数字 -l 列出在listen 服务状态 -p 显示相关程序名
lsof -i:80 # -i参数表示网络链接，:80指明端口号

ip netns exec

sudo apt install nmap-ncat

nc -l 9999  # 开启一个本地9999的TCP协议端口，由客户端主动发起连接，一旦连接必须由服务端发起关闭
nc -vw 2 192.168.21.248 11111  #通过nc去访问192.168.21.248主机的11111端口，确认是否存活；可不加参数
nc -ul 9999                       # 开启一个本地9999的UDP协议端口，客户端不需要由服务端主动发起关闭
nc 192.168.21.248 9999 < test     # 通过192.168.21.248的9999TCP端口发送数据文件
nc -l 9999 > zabbix.file          # 开启一个本地9999的TCP端口，用来接收文件内容

# 端口扫描
nc -v -w 2 192.168.2.34 -z 21-24
# 从192.168.2.33拷贝文件到192.168.2.34
# 在192.168.2.34上：
nc -lp 1234 > test.txt
# 在192.168.2.33上
nc -w l 192.168.2.34 1234 < test.txt
# 聊天 Ctrl+D正常退出
nc -lp 1234
nc 192.168.228.222 1234
# 传输目录
nc -l 1234 | tar xzvf -
tar czvf – nginx-0.6.34 | nc 192.168.228.222 1234
# 操作memcached
# 存储数据
printf “set key 0 10 6rnresultrn” |nc 192.168.2.34 11211
# 获取数据
printf “get keyrn” |nc 192.168.2.34 11211
# 删除数据
printf “delete keyrn” |nc 192.168.2.34 11211
# 查看状态
printf “statsrn” |nc 192.168.2.34 11211
# 模拟top命令查看状态
watch “echo stats” |nc 192.168.2.34 11211
# 清空缓存
printf “flush_allrn” |nc 192.168.2.34 11211
# 从本地1234端口到host.example.com的80端口连接，5秒超时
nc -p 1234 -w 5 host.example.com 80
echo -n "GET / HTTP/1.0"r"n"r"n" | nc host.example.com 80
nc -u host.example.com 53

# 克隆硬盘或分区
nc -l -p 1234 | dd of=/dev/sda
dd if=/dev/sda | nc 192.168.228.222 1234

nc www.linuxso.com 80
GET / HTTP/1.1
Host: ispconfig.org
Referrer: mypage.com
User-Agent: my-browser

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
cat .bash_history | sort | uniq -c | sort -rn | head -n 10 (or cat .zhistory | sort | uniq -c | sort -rn | head -n 10 # 查看一下最常用的10个命令

# 输出nginx日志的ip和每个ip的pv，pv最高的前10
#2019-06-26T10:01:57+08:00|nginx001.server.ops.pro.dc|100.116.222.80|10.31.150.232:41021|0.014|0.011|0.000|200|200|273|-|/visit|sign=91CD1988CE8B313B8A0454A4BBE930DF|-|-|http|POST|112.4.238.213
awk -F"|" '{print $3}' access.log | sort | uniq -c | sort -nk1 -r | head -n10
```

## xargs

* xargs:给命令传递参数的过滤器，将管道或标准输入(（)stdin)数据转换成命令行参数 `xargs [-options] [command]`
    - xargs后面的命令默认是echo
        + 输入xargs按下回车以后，命令行就会等待用户输入，作为标准输入。
        + 可以输入任意内容，然后按下Ctrl d，表示输入结束，这时echo命令就会把前面的输入打印出来
    - 能够从文件的输出中读取数据
    - 能够捕获一个命令的输出，然后传递给另外一个命令
    - 参数
        + -a file 从文件中读入作为sdtin
        + -e flag ，注意有的时候可能会是-E，flag必须是一个以空格分隔的标志，当xargs分析到含有flag这个标志的时候就停止。
        + -p 每次执行时候询问用户确认
        + -t 打印出最终要执行的命令，然后直接执行，不需要用户确认
        + -n num 指定每次将多少项，作为命令行参数，默认是用所有的
        + -I 指定每一项命令行参数的替代字符串将xargs的每项名称，一般是一行一行赋值给 {}，可以用 {} 代替。
        + -r no-run-if-empty 当xargs的输入为空的时候则停止xargs，不用再去执行了。
        + -s num 命令行的最大字符数，指的是 xargs 后面那个命令的最大命令行字符数。
        + -L|l num 指定多少行作为一个命令行参数
        + -d delim 分隔符，默认的xargs分隔符是回车，argument的分隔符是空格，这里修改的是xargs的分隔符。
        + -x exit的意思，配合-s使用
        + -P 修改最大进程数，默认是1，为0时候为as many as it can
        + -print0，指定输出的文件列表以null分隔。然后，xargs命令的-0参数表示用null当作分隔符
* xargs find -name: 执行命令，将参数分离出来
    - 后紧跟要执行命令
    - 参数输入
        + 通过管道输入
        + 通过命令行直接输入
* 特别适合find命令

```sh
cat test.txt | xargs # 多行输入单行输出
echo "one two three" | xargs mkdir

# 命令行会等待用户输入所要搜索的文件。用户输入"*.txt"，表示搜索当前目录下的所有 TXT 文件，然后按下Ctrl d，表示输入结束。这时就相当执行find -name *.txt
xargs find -name

# 删除/path路径下的所有文件。由于分隔符是null，所以处理包含空格的文件名，也不会报错
find /path -type f -print0 | xargs -0 rm
find . -name "*.txt" | xargs grep "abc"
# 每行运行一次echo命令
echo -e "a\nb\nc" | xargs -L 1 echo

echo {0..9} | xargs -n 2 echo

# 前面file声明参数，后面是执行体，每一项带入到后面脚本
cat foo.txt | xargs -I file sh -c 'echo file; mkdir file'

echo "nameXnameXnameXname" | xargs -dX -n2 # 自定义一个定界符

ls *.jpg | xargs -n1 -I {} cp {} /data/images # 复制所有图片文件到 /data/images 目录下

find . -type f -name "*.jpg" -print | xargs tar -czvf images.tar.gz # 查找所有的 jpg 文件，并且压缩
find . -type f -name "*.php" -print0 | xargs -0 wc -l # 统计一个源代码目录中所有 php 文件的行数
find . -type f -name "*.log" -print0 | xargs -0 rm -f

#!/bin/bash
#sk.sh命令内容，打印出所有参数。

echo $*

cat arg.txt | xargs -I {} ./sk.sh -p {} -l
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

### [zsh](https://github.com/zsh-users/zsh)

* [An Introduction to the Z Shell](http://zsh.sourceforge.net)
* [prezto](https://github.com/sorin-ionescu/prezto) The configuration framework for Zsh
* [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)：A delightful community-driven (with 1,000+ contributors) framework for managing your zsh configuration. Includes 200+ optional plugins (rails, git, OSX, hub, capistrano, brew, ant, php, python, etc), over 140 themes to spice up your morning, and an auto-update tool so that makes it easy to keep up with the latest updates from the community. https://ohmyz.sh/
    - 兼容 bash
    - 自动 cd:只需输入目录名称
    - 命令选项补齐
    - 目录一次性补全：比如输 Doc/doc
* powerline: need font support
* [plugin](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins)
    - plugin manager
        + [antigen](https://github.com/zsh-users/antigen):The plugin manager for zsh. http://antigen.sharats.me
        + [zplug](https://github.com/zplug/zplug):🌺 A next-generation plugin manager for zsh `curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh`
        + [](https://github.com/getantibody/antibody) The fastest shell plugin manager.
    - [Overview](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins-Overview)
    - custom
        + [zsh-users/zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)：Fish shell like syntax highlighting for Zsh.
        + [zsh-users/zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions):Fish-like autosuggestions for zsh
        + [sindresorhus/pure](https://github.com/sindresorhus/pure):Pretty, minimal and fast ZSH prompt `npm install --global pure-prompt`
* [Theme](~/.oh-my-zsh/themes)
    - agnoster
    - cloud
    - wedisagree
    - ambda-mod
    - [powerlevel10k](https://github.com/romkatv/powerlevel10k) `git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k`
    - [denysdovhan/spaceship-prompt](https://github.com/denysdovhan/spaceship-prompt):🚀⭐️ A Zsh prompt for Astronauts https://denysdovhan.com/spaceship-prompt/
* use
    - `j src` autojump 访问 ~/workspace/src
    - `st README.md` Sublime Text 打开当前目录 README.md 文件
    - web-search `baidu hhkb pro2` 直接在浏览器打开百度搜索关键字”hhkb pro2”
    - 进程id补全 kill firefox + tab
    - 快速跳转:d + enter，列出最近访问过的各个目录，然后选择目录前面的数字进行快速跳转
    - 目录名简写与补全:只需要输入每个目录的首字母就行，然后再TAB键补全
    - r 重复执行上一条命令
    - catimg 查看图片
    - encode64
    - wd 书签功能
        + wd list
        + wd add web
        + wb web
* 参考
    - [unixorn/awesome-zsh-plugins](https://github.com/unixorn/awesome-zsh-plugins):A collection of ZSH frameworks, plugins & themes inspired by the various awesome list collections out there.
* 优化
    - 禁用多余插件
    - 避免产生子进程:常见的会产生子进程的语法有是 eval 和 Command substitution，在编写 .zshrc 时应该尽量避免使用它们
    - 启用 ZSH_DISABLE_COMPFIX
*  macOS
    - zsh 启动序列的第一项为 /etc/zprofile 而不是 ~/.zprofile。通过 /etc/zprofile 来调用 path_helper
    - path_helper 又会读取 /etc/paths 、/etc/paths/d、etc/manpaths 和 etc/manpaths.d、并将其添加到 $PATH 和 $MANPATH 变量中。通过 path_helper 提供了一种快速在不同 shell 中共享 $PATH 和 $MANPATH 的方法。过去，path_helper 是一个运行速度很慢的 shell 脚本[6] 以至于有人制作了专门的 patch[7]、甚至 使用 Perl[8] 重写了一个替代品。不过 macOS 意识到了这个问题，现在 path_helper 不再是一个脚本而是一个预编译好的二进制文件。如果通过 profiling 发现 path_helper 有在拖累 zsh 启动，那么可以考虑放弃使用 /etc/paths/d、而是在 .zshrc 中直接维护 $PATH
    - login process：默认在启动、终端登陆 shell 时会触发 macOS 的 login -fp username。这一操作会调用 syslog() 函数向 /var/log/asl 写入日志、并读取上一次登录记录、以 Last login 的形式显示出来。可以修改 etc/asl.conf 配置文件中定义的日志等级。修改 iTerm2 设置中的 Login Command 为 /bin/zsh 可以加快 zsh 启动速度，本质上也是绕过了上述读取和写入日志的环节

```sh
cat /etc/shells
echo $SHELL

sudo yum install zsh
sudo apt-get install zsh git wget
sudo apt-get install powerline fonts-powerline
brew install zsh zsh-completions
brew cask install font-sourcecodepro-nerd-font
brew install zplug

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
wget --no-check-certificate 。![]https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh

# 手动
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

chsh -s /bin/zsh
source ~/.bashrc # 运行
sudo usermod -s /usr/bin/zsh $(whoami) # set ZSH as the default login shell for the user

## 配置：~/.zshrc(不用单配，插件配置有)
sudo apt-get install zsh-theme-powerlevel9k
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
echo "source /usr/share/powerlevel9k/powerlevel9k.zsh-theme" >> ~/.zshrc

p10k configure

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# config 主题设置(（)文件在~/.oh-my-zsh/themes)
ZSH_THEME="agnoster"  |robbyrussell| powerlevel9k/powerlevel9k
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# 插件
plugins=(git textmate ruby autojump osx mvn gradle)
# hide username
export DEFAULT_USER="henry"

PROMPT='%{$fg_bold[red]%}➜ %{$fg_bold[green]%}%p%{$fg[cyan]%}%d %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%}% %{$reset_color%}>'
#PROMPT='%{$fg_bold[red]%}➜ %{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# 更新
upgrade_oh_my_zsh
uninstall_oh_my_zsh

# zsh 启动耗时测量
/usr/bin/time /bin/zsh -i -c exit
for i in $(seq 1 5); do /usr/bin/time /bin/zsh -i -c exit; done
for i in $(seq 1 20); do /usr/bin/time /bin/zsh --no-rcs -i -c exit; done

# profiling 模块 zprof 用于衡量 zsh 各个函数的执行用时
zmodload zsh/zprof
# 获取各函数用时数据
zprof

# 获取完整的 .zshrc 性能分析，应该使用 xtrace
chmod +x format_profile.zsh
./format_profile.zsh zsh_profile.123456 | head -n 30

# 封装好的 lazyload 函数

# 判断命令是否存在
[[ command -v node &>/dev/null ]] && node -v
[[ which -a node &>/dev/null ]] && node -v
[[ type node &>/dev/null ]] && node -v
(( $+commands[node] )) && node -v

# 变量字符串查找:$variable[(i)keyword] 和 $variable[(I)keyword]，前者是从左往右寻找、后者是从右往左寻找，返回值为第一个匹配的首字符位置，当没有匹配时返回值则是变量的最终位置，也就是说当找不到匹配时 (i) 会返回字符串的长度、而 (I) 会返回 0
[[ $(echo $FPATH | grep "/usr/local/share/zsh/site-functions") ]] && echo "homebrew exists in fpath"
(( $FPATH[(I)/usr/local/share/zsh/site-functions] )) && echo "homebrew exists in fpath"

# 变量字符串替换
echo $HOST | sed -e "s/.local//"
echo ${HOST/.local/}
echo ${HOST/.local/.foxtail}
```

### [fish-shell](https://github.com/fish-shell/fish-shell)

The user-friendly command line shell. http://fishshell.com

* 彩色显示
* 有效路径为下划线
* 光标会给提示:→(选中) 只采纳一部分，可以按下(Alt + →)
* 补全存在的历史记录或猜测可能性(tab选择)
* [fisherman/fisherman](https://github.com/fisherman/fisherman):The fish-shell plugin manager.
* https://wiki.archlinux.org/index.php/Fish

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
* [窗口管理器 xmonad 教程](http://www.ruanyifeng.com/blog/2017/07/xmonad.html)

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

### Terminal Keymap

* 终端本质上是对应着 Linux 上的 /dev/tty 设备，Linux 的多用户登陆就是通过不同的 /dev/tty 设备完成的
* 默认提供七个终端，其中第一个到第六个虚拟控制台是全屏的字符终端，第七个虚拟控制台是图形终端，用来运行GUI程序，按快捷键CTRL+ALT+F1，或CTRL+ALT+F2.......CTRL+ALT+F6，CTRL+ALT+F7可完成对应的切换

* Ctrl+Shift+n 新终端
* Shift+Ctrl+t 打开新的标签页
* Shift+Ctrl+w|q 关闭标签页
* Tab 实现命令补全,目录补全、命令参数补全
* Ctrl+c:强行终止当前程序 或者删除整行
* Ctrl + d ：删除光标处的字符，同Del键。没有命令是表示注销用户
* Ctrl+z:将当前程序放到后台运行，恢复到前台为命令fg
* Ctrl+a:将光标移至输入行头，相当于Home键
* Ctrl+e:将光标移至输入行末，相当于End键
* Ctrl + K :删除从光标所在位置到行末,常配合ctrl+a使用
* Alt+Backspace:向前删除一个单词，常配合ctrl+e使用
* Shift+PgUp:将终端显示向上滚动
* Shift+PgDn:将终端显示向下滚动
* 复制粘贴
    - Ctrl+y 粘贴由 Ctrl+u ， Ctrl+d ， Ctrl+w,Ctrl+k 剪切内容
    - Ctrl+k 剪切此光标后内容
    - Ctrl+u 剪切此光标之前内容,输错命令或密码
    - Ctrl+d 剪切当前字符
    - Ctrl+h 剪切当前字符前一个字符
    - Ctrl+w 剪切光标左边的参数（选项）或内容（实际是以空格为单位向前剪切一个word）

* Ctrl+l 相当于clear，即清屏
* Ctrl+r 查找历史命令
* Ctrl + g ：从历史搜索模式退出，同ESC
* Ctrl+t 将光标位置的字符和前一个字符进行位置交换
* Ctrl+S 暂停屏幕输出
* Ctrl+Q 继续屏幕输出
* Ctrl + f ：按字符前移（右向），同→
* Ctrl + b ：按字符后移（左向），同←
* Alt + d ：从光标处删除至字尾。可以Ctrl+y粘贴回来
* Ctrl+Left-Arrow|Alt + b ：按单词后移（左向）
* Ctrl+Right-Arrow|Alt + f ：按单词前移，标点等特殊字符与空格一样分隔单词（右向）
* Ctrl + p ：历史中的上一条命令，同↑
* Ctrl + n ：历史中的下一条命令，同↓
* Ctrl+xx 在行头和当前光标位置切换
* Shift+Ctrl+C 复制
* Shift+Ctrl+V 粘贴
* Ctrl+/|Ctrl+x + Ctrl+u  撤销
* Alt + .：同!$，输出上一个命令的最后一个参数（选项or单词）
* Alt + \ ：删除当前光标前面所有的空白字符
* Ctrl + ]　c ：从当前光标处向右定位到字符 c 处
* Esc　Ctrl + ]　c ：从当前光标向左定位到字符 c 处。（ bind -P 可以看到绑定信息）
* Ctrl + r　str ：可以搜索历史，也可以当前光标处向左定位到字符串 str，Esc后可定位继续编辑
* Ctrl -s　str ：从当前光标处向右定位到字符串 str 处，Esc 退出
* !! 执行上一条

```sh
dialog --title "Oh hey" --inputbox "Howdy?" 8 55 # interact with the user on command-line
```

### 脚本

* shell 是可以与计算机进行高效交互的文本接口,提供了一套交互式的编程语言
* shell 的生命力很强，在各种高级编程语言大行其道的今天，很多的任务依然离不开 shell。比如可以使用 shell 来执行一些编译任务，或者做一些批处理任务，初始化数据、打包程序等等。

```sh
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

## tac

```sh
brew install coreutils
ln -s /usr/local/bin/gtac /usr/local/bin/tac
```

## [autojump](https://github.com/joelthelion/autojump)

* 记得之前某个访问过的目录的大概名字，配合autojump，就能快速跳转过去
* j + 目录名

```sh
brew install autojump
sudo apt-get install autojump
# 以使得qutojump生效
. /usr/share/autojump/autojump.sh
echo . /usr/share/autojump/autojump.sh >> ~/.zshrc
source ~/.zshrc
```

## [thefuck](https://github.com/nvbn/thefuck)

```sh
sudo pip3 install thefuck
```

## [bats-core/bats-core](https://github.com/bats-core/bats-core)

Bash Automated Testing System

## 问题

```
# Sorry, user henry is not allowed to execute '/usr/bin/apt update' as root
# 从recovery 模式进入到root 用户界面
# /etc/sudoers
henry ALL=(ALL) NOPASSWD:ALL
```

## [terminator](https://terminator-gtk3.readthedocs.io/en/latest/index.html)

* depend python2.7
* config: right click->prefermance or  `cd ~/.config/terminator/ && sudo vi config`
* Theme
    - [](https://atomcorp.github.io/themes/)
* 可以监视通知

```
sudo add-apt-repository ppa:gnome-terminator
sudo apt update
sudo apt install terminator

[global_config]
  enabled_plugins = CustomCommandsMenu, TestPlugin, ActivityWatch, TerminalShot, MavenPluginURLHandler
  title_inactive_bg_color = "#820f49"
[keybindings]
[layouts]
  [[default]]

    [[[child1]]]

      parent = window0

      profile = default

      type = Terminal

    [[[window0]]]

      parent = ""

      type = Window
[plugins]
[profiles]
  [[default]]
    background_color = "#2e2f31"
    background_darkness = 0.86
    background_image = /home/taowang/桌面/earth.jpg
    background_type = image
    copy_on_selection = True
    cursor_color = "#eee8d5"
    font = Monospace 12
    foreground_color = "#f3f0e7"
    scroll_on_output = False
    scrollback_lines = 50000
    use_system_font = False
  [[New Profile]]
    background_image = None
```

## [sharkdp/bat](https://github.com/sharkdp/bat)

A cat(1) clone with wings

```sh
wget https://github.com/sharkdp/bat/releases/download/v0.15.4/bat_0.15.4_amd64.deb

brew install bat
```

## Termial

* ios
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
    + [Babun](http://babun.github.io/)
    + [nushell](https://github.com/nushell/nushell): A new type of shell www.nushell.sh/ `cargo install nu --features=stable`
        * The goal of this project is to take the Unix philosophy of shells, where pipes connect simple commands together, and bring it to the modern style of development
* [Hyper](https://github.com/zeit/hyper):A terminal built on web technologies create a beautiful and extensible experience for command-line interface users, built on open web standards https://hyper.is
* mosh：基于UDP的终端连接，可以替代ssh，连接更稳定，即使IP变了，也能自动重连
* [PowerShell](https://github.com/PowerShell/PowerShell):PowerShell for every system! https://microsoft.com/PowerShell
* [terminus](https://github.com/Eugeny/terminus):A terminal for a more modern age https://eugeny.github.io/terminus/
* [msys2](http://www.msys2.org/)
* powercmd
* [alacritty](https://github.com/alacritty/alacritty):A cross-platform, GPU-accelerated terminal emulator
* [lukesampson/scoop](https://github.com/lukesampson/scoop):A command-line installer for Windows. https://scoop.sh
* [railsware/upterm](https://github.com/railsware/upterm):A terminal emulator for the 21st century.

## [bash](http://ftp.gnu.org/gnu/bash/) https://www.gnu.org/software/bash/manua

* [Bash-it/bash-it](https://github.com/Bash-it/bash-it):A community Bash framework.
* [dylanaraps/pure-bash-bible](https://github.com/dylanaraps/pure-bash-bible):📖 A collection of pure bash alternatives to external processes.
* [Bash Guide for Beginners](https://www.tldp.org/LDP/Bash-Beginners-Guide/html/)
* [Bash Reference Manual](https://tiswww.case.edu/php/chet/bash/bashref.html)
* [Bash scripting cheat sheet](https://devhints.io/bash)
* [bash(1) – Linux man page](https://linux.die.net/man/1/bash)
* [An A-Z Index of the Bash command line for Linux.](https://ss64.com/bash/)
* [bash-completion](https://github.com/scop/bash-completion) Programmable completion functions for bash

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
axel -n 20 http://centos.ustc.edu.cn/centos/7/isos/x86_64/CentOS-7-x86_64-Minimal-1511.iso
ccache gcc foo.c
```

## 图书

* 《Linux Shell脚本攻略》
* 《Shell脚本学习指南》
* Linux命令行与shell脚本编程大全（第3版）
    - [fengyuhetao/shell](https://github.com/fengyuhetao/shell):Linux命令行与shell脚本编程大全案例

## 工具

* [edex-ui](https://github.com/GitSquared/edex-ui):A cross-platform, customizable science fiction terminal emulator with advanced monitoring & touchscreen support.
* help
    - [idank/explainshell](https://github.com/idank/explainshell):match command-line arguments to their help text
    - [tldr-pages/tldr](https://github.com/tldr-pages/tldr): books Simplified and community-driven man pages http://tldr-pages.github.io/ `npm install -g tldr`
    - [jaywcjlove / linux-command](https://github.com/jaywcjlove/linux-command):Linux命令大全搜索工具，内容包含Linux命令手册、详解、学习、搜集。https://git.io/linux https://git.io/linux
    - cheat
* [lynx](link):终端构建的Web浏览应用程序
* cd
    - [fasd](https://github.com/clvv/fasd) 增强cd命令
    - [ranger](https://github.com/ranger/ranger) 在多目录上浏览各种文件 比 cd 和 cat 更有效率，甚至可以在终端预览图片
* ls
    - [ogham/exa](https://github.com/ogham/exa):A modern version of ‘ls’. https://the.exa.website/
* [prettyping](https://github.com/denilsonsa/prettyping) 图示化的ping
* du
    - [ncdu](https;//dev.yorhel.nl/ncdu)
    - [nnn](https://github.com/jarun/nnn)
* [asciinema](https://asciinema.org/)和 [svg-trem](https://github.com/marionebl/svg-term-cli) 如果想把的命令行操作建录制成一个 SVG 动图
* [Taskbook](https://github.com/klaussinani/taskbook) 可以完全在命令行中使用的任务管理器 ，支持 ToDo 管理，还可以为每个任务加上优先级
* [sshrc](https://github.com/Russell91/sshrc ) 在登录远程服务器的时候也能使用本机的 shell 的 rc 文件中的配置
* monitor
    - top:查看在系统中运行的进程或线程,默认是以 CPU 进行排序
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
    - [ngrep](http://ngrep.sourceforge.net/) 就是网络层的 grep。使用 pcap ，允许通过指定扩展正则表达式或十六进制表达式来匹配数据包。
    - [MRTG](http://oss.oetiker.ch/mrtg/) 最初被开发来监控路由器的流量，但现在它也能够监控网络相关的东西。它每五分钟收集一次，然后产生一个 HTML 页面。它还具有发送邮件报警的能力。
    - [bmon](https://github.com/tgraf/bmon/) 能监控并帮助你调试网络。它能捕获网络相关的统计数据，并以友好的方式进行展示。你还可以与 bmon 通过脚本进行交互。
    - traceroute是一个内置工具，能显示路由和测量数据包在网络中的延迟,数据包在IP网络经过的路由器的IP地址
    - [IPTState](http://www.phildev.net/iptstate/index.shtml) 可以让你观察流量是如何通过 iptables，并通过你指定的条件来进行排序。该工具还允许你从 iptables 的表中删除状态信息。
    - [darkstat](https://unix4lyfe.org/darkstat/) 能捕获网络流量并计算使用情况的统计数据。该报告保存在一个简单的 HTTP 服务器中，它为你提供了一个非常棒的图形用户界面。
    - [vnStat]( http://humdi.net/vnstat/) 是一个网络流量监控工具，它的数据统计是由内核进行提供的，其消耗的系统资源非常少。系统重新启动后，它收集的数据仍然存在。有艺术感的系统管理员可以使用它的颜色选项
    - netstat 是一个内置的工具，显示 TCP 网络连接，路由表和网络接口数量，被用来在网络中查找问题
    - ss:iproute2 包附带的另一个工具，允许查询 socket 的有关统计信息,显示的信息比 netstat 更多，也更快。如果想查看统计结果的总信息，你可以使用命令 ss -s
    - [Nmap](http://nmap.org/) 可以扫描你服务器开放的端口并且可以检测正在使用哪个操作系统。但你也可以将其用于 SQL 注入漏洞、网络发现和渗透测试相关的其他用途。
    - [MTR](http://www.bitwizard.nl/mtr/) 将 traceroute 和 ping 的功能结合到了一个网络诊断工具上。当使用该工具时，它会限制单个数据包的跳数，然后监视它们的到期时到达的位置。然后每秒进行重复。
    - [Justniffer](http://justniffer.sourceforge.net/) 是 tcp 数据包嗅探器。使用此嗅探器你可以选择收集低级别的数据还是高级别的数据。它也可以让你以自定义方式生成日志。比如模仿 Apache 的访问日志。
* hex
    - [sharkdp/hexyl](https://github.com/sharkdp/hexyl):A command-line hex viewer
* prompt
    - [b-ryan/powerline-shell](https://github.com/b-ryan/powerline-shell):A beautiful and useful prompt for your shell
        + pre-patched and adjusted fonts for usage with the Powerline statusline plugin `sudo apt-get install fonts-powerline`
        + Powerline a statusline plugin for vim, and provides statuslines and prompts for several other applications `pip install powerline-status`
    - [starship/starship](https://github.com/starship/starship):cometmilky_way The cross-shell prompt for astronauts https://starship.rs
* sql
    - mycli：mysql客户端，支持语法高亮和命令补全，效果类似ipython，可以替代mysql命令
* json
    - jq: json文件处理以及格式化显示，支持高亮，可以替换python -m json.tool
* 代码统计
    - cloc：代码统计工具，能够统计代码的空行数、注释行、编程语言
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
* [idank/explainshell](https://github.com/idank/explainshell):match command-line arguments to their help text [explainshell](https://explainshell.com)
* [sindresorhus/fkill-cli](https://github.com/sindresorhus/fkill-cli):Fabulously kill processes. Cross-platform.
* [tartley/colorama](https://github.com/tartley/colorama):Simple cross-platform colored terminal text in Python
* [dylanaraps/fff](https://github.com/dylanaraps/fff):🚀 fucking fast file-manager
* [jmacdonald/amp](https://github.com/jmacdonald/amp):A complete text editor for your terminal. https://amp.rs
* [liamg/aminal](https://github.com/liamg/aminal):Golang terminal emulator from scratch
* [amanusk/s-tui](https://github.com/amanusk/s-tui):Terminal based CPU stress and monitoring utility https://amanusk.github.io/s-tui/
* [rupa/z](https://github.com/rupa/z):z - jump around
* [jwilm/alacritty](https://github.com/jwilm/alacritty):A cross-platform, GPU-accelerated terminal emulator
* [koalaman / shellcheck](https://github.com/koalaman/shellcheck)：ShellCheck, a static analysis tool for shell scripts https://www.shellcheck.net
* yapf：Google开发的python代码格式规范化工具，支持pep8以及Google代码风格
* PathPicker(fpp):在命令行输出中自动识别目录和文件，支持交互式，配合git非常有用
* sz/rz：交互式文件传输，在多重跳板机下传输文件非常好用，不用一级一级传输
* script/scriptreplay: 终端会话录制
* 配置
    - [direnv/direnv](https://github.com/direnv/direnv):Unclutter your .profile http://direnv.net

## snippets

* [alexanderepstein/Bash-Snippets](https://github.com/alexanderepstein/Bash-Snippets):A collection of small bash scripts for heavy terminal users

## 参考

* [alebcay/awesome-shell](https://github.com/alebcay/awesome-shell)：A curated list of awesome command-line frameworks, toolkits, guides and gizmos. Inspired by awesome-php.
* [Google’s Shell Style Guide](https://google.github.io/styleguide/shell.xml)
* [the-art-of-command-line](https://github.com/jlevy/the-art-of-command-line):Master the command line, in one page

* [teddysun / across](https://github.com/teddysun/across)
* 脚本参考
    - http://www.bashoneliners.com/
    - http://www.shell-fu.org/
    - http://www.commandlinefu.com/
    - http://www.shelldorado.com/scripts/
    - https://snippets.siftie.com/public/tag/bash/
    - https://bash.cyberciti.biz/
    - https://github.com/miguelgfierro/scripts
    - https://github.com/epety/100-shell-script-examples
    - https://github.com/ruanyf/simple-bash-scripts
    - 和shell有关的索引资源
        + https://github.com/awesome-lists/awesome-bash
        + https://terminalsare.sexy/
