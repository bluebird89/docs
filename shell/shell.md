# Shell

* 之所以叫Shell,因为隐藏了操作系统底层细节,是Linux/Unix的一个外壳。作为命令解析器负责外界与Linux内核的交互，接收用户或其他应用程序的命令，然后把这些命令转化成内核能理解的语言，传给内核，内核是真正干活的，干完之后再把结果返回用户或应用程序
* 命令行 shell：系统用户界面，提供了用户与内核进行交互操作的一种接口。接收用户输入的命令并把它送入内核去执行，是一个命令解释器
  - Bourne Shell（sh）：贝尔实验室开发的
  - Bourne Again shell（bash）：GNU操作系统上默认的shell,大部分linux的发行套件使用的都是这种shell
  - Korn shell（ksh）：对Bourne SHell的发展，在大部分内容上与Bourne Shell兼容
  - C Shell（csh）:SUN公司Shell的BSD版本
  - Z Shell（zsh）
  - Friendly Interactive Shell（fish）
* 由大量标准应用程序组成。六种类型
  - 文件和目录操作命令
  - 过滤器
  - 文本程序
  - 系统管理
  - 程序开发工具，例如编辑器和编译器

## 配置

* bash - ~/.bashrc, ~/.bash_profile
* git - ~/.gitconfig
* vim - ~/.vimrc 和 ~/.vim 目录
* ssh - ~/.ssh/config
* tmux - ~/.tmux.conf
* 用户每次使用 Shell，都会开启一个与 Shell 的 Session
  - 登录 Session|login shell:用户登录系统以后，系统为用户开启的原始 Session，通常需要用户输入用户名和密码进行登录.一般进行整个系统环境的初始化，启动的初始化脚本依次
    + /etc/profile：所有用户的全局配置脚本
      * Linux 发行版更新的时候，会更新/etc里面的文件
    + /etc/profile.d目录里面所有.sh文件
      * 想修改所有用户的登陆环境，就在/etc/profile.d目录里面新建.sh脚本
    + ~/.bash_profile：用户的个人配置脚本。如果该脚本存在，则执行完就不再往下执行
      * 脚本定义了一些最基本的环境变量，然后执行了~/.bashrc
    + ~/.bash_login：如果~/.bash_profile没找到，则尝试执行这个脚本（C shell 的初始化脚本）。如果该脚本存在，则执行完就不再往下执行
    + ~/.profile：如果~/.bash_profile和~/.bash_login都没找到，则尝试读取这个脚本（Bourne shell 和 Korn shell 的初始化脚本）
    + `bash --login` 强制执行登录 Session 会执行的脚本
    + `bash --noprofile` 会跳过上面这些 Profile 脚本
  - 非登录 Session|non-login shell:用户进入系统以后，手动新建的 Session，这时不会进行环境初始化
    + /etc/bash.bashrc：对全体用户有效。
    + ~/.bashrc：仅对当前用户有效
    + 每次新建一个 Bash 窗口，就相当于新建一个非登录 Session，所以~/.bashrc每次都会执行。执行脚本相当于新建一个非互动的 Bash 环境，这种情况不会调用~/.bashrc
    + `bash --norc` 禁止在非登录 Session 执行~/.bashrc脚本
* `~/.bash_logout` 脚本在每次退出 Session 时执行，通常用来做一些清理工作和记录工作
* 键盘绑定：全局键盘绑定文件默认为/etc/inputrc，可以在主目录创建自己的键盘绑定文件.inputrc文件。如果定义了这个文件，需要在其中加入`$include /etc/inputrc`，保证全局绑定不会被遗漏
  - "\C-t":"pwd\n" 将Ctrl + t绑定为运行pwd命令
* alias
  - `alias c='clear'`
  - `unalias aliasname`
  - disable
    + 全路径 /usr/bin/clear
    + 转义 \c
    + command ls
  - 参考
    + [Shell startup scripts](https://blog.flowblok.id.au/2013-02/shell-startup-scripts.html)
    + <https://www.digitalocean.com/community/questions/what-are-your-favorite-bash-aliases>
    + <https://www.linuxtrainingacademy.com/23-handy-bash-shell-aliases-for-unix-linux-and-mac-os-x/>
    + <https://brettterpstra.com/2013/03/31/a-few-more-of-my-favorite-shell-aliases/>
    + [standard-aliases](https://github.com/gto76/standard-aliases):Attempt at defining a standard extension to Linux in form of Bash functions
* [starship](https://github.com/starship/starship):cometmilky_way The cross-shell prompt for astronauts <https://starship.rs>
* 参考
  - [dotfiles.github.io](http://dotfiles.github.io/)
  - <https://dev.to/_darrenburns/10-tools-to-power-up-your-command-line-4id4>
  - <https://dev.to/_darrenburns/tools-to-power-up-your-command-line-part-2-2737>
  - <https://dev.to/_darrenburns/power-up-your-command-line-part-3-4o53>
  - <https://darrenburns.net/posts/tools/>
  - <https://hacker-tools.github.io/>

```sh
cmd [options] [arguments] # options称为选项，arguments称为参数

echo $SHELL # 查看shell

# /* 如果vim还没有语法高亮，那么在/etc/profile 中添加以下语句 */
export TERM=xterm-color
# // 注: 只对各个用户自己的主目录下的.vimrc修改的话，修改内容只对本用户有效,要想全部有效，可以修改 /etc/vimrc
# 同样的 /etc/bashrc 是针对所有用户的启动文件

ls /usr/share/vim/vim72/colors/  # 可以查看vim支持的主题色

# /* 目录配色方案(将/etc中的DIR_COLORS文件复制到自己主目录中，并重命名为.dir_colors) */
cp /etc/DIR_COLORS ~/.dir_colors

# .bashrc
# if user is not root, pass all commands via sudo #
if [ $UID -ne 0 ]; then
    alias reboot='sudo reboot'
    alias update='sudo apt-get upgrade'
fi
# Get os name via uname ###
_myos="$(uname)"

# add alias as per os using $_myos ###
case $_myos in
   Linux) alias foo='/path/to/linux/bin/foo';;
   FreeBSD|OpenBSD) alias foo='/path/to/bsd/bin/foo' ;;
   SunOS) alias foo='/path/to/sunos/bin/foo' ;;
   *) ;;
esac

# /etc/profile
export PATH=$PATH:/opt/perl/site/bin:/opt/perl/bin

bash <(curl -s https://gist.github.com/Jacksgong/9d0519f68b7940a07075a834b3178979/raw/803256593b7b05177408ccbc0bc68e072a8e3a0a/init-shell.sh)

# .bash_profile
PATH=/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/bin
PATH=$PATH:$HOME/bin

SHELL=/bin/bash
MANPATH=/usr/man:/usr/X11/man
EDITOR=/usr/bin/vi
PS1='\h:\w\$ '
PS2='> '

if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi

export PATH
export EDITOR

# ~/.inputrc
set completion-ignore-case on
```

## [Coreutils - GNU core utilities](https://www.gnu.org/software/coreutils/)

the basic file, shell and text manipulation utilities of the GNU operating system

## 模式

* 交互模式 Interactive mode:shell直接与用户交互
* 非交互模式 Non-interactive mode:shell从文件或者管道中读取命令并执行。当shell解释器执行完文件中最后一个命令，shell进程终止，并回到父进程
  - `sh example.sh`
  - `./example.sh` 通过chmod命令给文件添加可执行权限，来直接执行脚本文件,有 Shebang 行的时候，可以直接调用执行
    + 要求脚本文件的第一行必须指定解释器,以#!字符开头,这个字符称为 Shebang，所以这一行就叫做 Shebang 行
      * `#!/bin/bash`
      * `#!/usr/bin/env bash` 系统会自动在PATH环境变量中查找指定程序,因为程序的路径是不确定的
      * 另外操作系统的PATH变量有可能被配置为指向程序的另一个版本，上面的做法还会使用旧版本
  - 将脚本放在环境变量$PATH指定的目录中，就不需要指定路径了。因为 Bash 会自动到这些目录中，寻找是否存在同名的可执行文件
    + 在主目录新建一个~/bin子目录，专门存放可执行脚本，然后把~/bin加入$PATH
  - 脚本参数:调用脚本的时候，脚本文件名后面可以带有参数
* env命令总是指向/usr/bin/env文件
  - #!/usr/bin/env NAME这个语法的意思是，让 Shell 查找$PATH环境变量里面第一个匹配的NAME。如果不知道某个命令的具体路径，或者希望兼容其他用户的机器，这样的写法就很有用
  - 参数
    + -i, --ignore-environment：不带环境变量启动
    + -u, --unset=NAME：从环境变量中删除一个变量
    + --help：显示帮助
    + --version：输出版本信息
* shift命令可以改变脚本参数，每次执行都会移除脚本当前的第一个参数（$1），使得后面的参数向前一位
* getopts命令用在脚本内部，可以解析复杂的脚本命令行参数，通常与while循环一起使用，取出脚本所有的带有前置连词线（-）的参数
* 配置项参数终止符 --
  - 希望指定变量只能作为实体参数，不能当作配置项参数 `ls -- $myPath`
* source 通常用于重新加载一个配置文件
  - 最大特点是在当前 Shell 执行脚本
  - source命令执行脚本时，不需要export变量
  - 在脚本内部加载外部库
  - 简写形式:使用一个点（.）来表示
    + 对于 source 命令来说，命令是在当前的bash会话中执行的，因此当 source 执行完毕，对当前环境的任何更改（例如更改目录或是定义函数）都会留存在当前会话中
    + 单独运行 ./script.sh 时，当前的bash会话将启动新的bash会话（实例），并在新实例中运行命令 script.sh。 因此，如果 script.sh 更改目录，新的bash会话（实例）会更改目录，但是一旦退出并将控制权返回给父bash会话，父会话仍然留在先前的位置（不会有目录的更改）
    + 如果 script.sh 定义了要在终端中访问的函数，需要用 source 命令在当前bash会话中定义这个函数。否则，如果你运行 ./script.sh，只有新的bash会话（进程）才能执行定义的函数，而当前的shell不能
* read：将用户输入存入一个变量，方便后面的代码使用
  - 如果没有提供变量名，环境变量REPLY会包含用户输入的一整行数据
  - 可以接受用户输入的多个值
    + 如果用户的输入项少于read命令给出的变量数目，那么额外的变量值为空
    + 如果用户的输入项多于定义的变量，那么多余的输入项会包含到最后一个变量中、
  - 读取文件
  - 参数
    + -t 设置了超时的秒数。如果超过了指定时间，用户仍然没有输入，脚本将放弃等待，继续向下执行。环境变量TMOUT也可以起到同样作用，指定read命令等待用户输入的时间（单位为秒）
    + -p 指定用户输入的提示信息
    + -a 把用户的输入赋值给一个数组，从零号位置开始
    + -n 指定只读取若干个字符作为变量值，而不是整行读取
    + -e 允许用户输入的时候，使用readline库提供的快捷键
    + -d delimiter：定义字符串delimiter的第一个字符作为用户输入的结束，而不是一个换行符。
    + -r：raw 模式，表示不把用户输入的反斜杠字符解释为转义字符。
    + -s：使得用户的输入不显示在屏幕上，这常常用于输入密码或保密信息。
    + -u fd：使用文件描述符fd作为输入
  - read命令读取的值，默认是以空格分隔
    + 可以通过自定义环境变量IFS（内部字段分隔符，Internal Field Separator 的缩写），修改分隔标志
    + IFS的默认值是空格、Tab 符号、换行符号，通常取第一个（即空格）
    + 把IFS定义成冒号（:）或分号（;），就可以分隔以这两个符号分隔的值，这对读取文件很有用
    + IFS的赋值命令和read命令写在一行，这样的话，IFS的改变仅对后面的命令生效，该命令执行后IFS会自动恢复原来的值
    + 如果IFS设为空字符串，就等同于将整行读入一个变量

```sh
#!/usr/bin/env bash
echo "Hello, world!"

while getopts 'lha:' OPTION; do
  case "$OPTION" in
    l)
      echo "linuxconfig"
      ;;

    h)
      echo "h stands for h"
      ;;

    a)
      avalue="$OPTARG"
      echo "The value provided is $OPTARG"
      ;;
    ?)
      echo "script usage: $(basename $0) [-l] [-h] [-a somevalue]" >&2
      exit 1
      ;;
  esac
done
shift "$(($OPTIND - 1))"

#!/bin/bash
# read-single: read multiple values into default variable
echo -n "Enter one or more values > "
read
echo "REPLY = '$REPLY'"

#!/bin/bash

filename='/etc/hosts'

while read myline
do
  echo "$myline"
done < $filename

OLD_IFS="$IFS"
IFS=":"
read user pw uid gid name home shell <<< "$file_info"
IFS="$OLD_IFS"
```

## 语法

* 应用
  - 不适用场景
    + 比数组更复杂数据结构
    + 出现复杂转义问题
    + 有太多字符串操作
    + 不太需要调用其它程序和跟其它程序管道交互
  - 从bash 3.2版开始，正则表达式和globbing表达式都不能用引号包裹。如果表达式里有空格，可以把它存储到一个变量里
* `type cd`:判断命令来源,显示命令类型，不需要使用子进程来执行,已经和shell编译成了一体，作为shell工具的组成部分存在。不需要借助外部程序文件来运行
  - 别名 alias
    + 创建：`alias li='ls -li'`
    + 查看：`alias -p`
  - 方法 function
  - 内建命令 builtin
  - 关键字 keyword
  - 文件 file
  - 参数
    + -v 逐行详细地查看脚本的内容
    + -x 在执行时显示命令。当决定选择分支的时候
    + -t 返回一个命令类型
* 语法
  - echo
    + -n 取消输出文本末尾的回车符
    + -e 会解释引号（双引号和单引号）里面的特殊字符（比如换行符\n）。如果不使用-e参数，即默认情况下，引号会让特殊字符变成普通字符，echo不解释它们，原样输出。
  - 语法缩进:四个空格
  - 在标准输入上输入多行字符串
  - 默认变量是全局的，在函数中变量local指定为局部变量，避免污染其他作用域
  - `$()`与``:用于shell命令的执行 用`$()`代替反单引号(`)
  - `pwd -P`:得出当前物理路径(（)非引用等路径)
  - function:定义一个函数，可加或不加
  - `egrep`
  - 用`[[]]`(双层中括号)替代[]
  - `bash -n myscript.sh`
    + -n:脚本进行语法检查
    + -v:跟踪脚本里每个命令的执行 `set -o verbose`
    + `set -x` -x:跟踪脚本里每个命令的执行并附加扩充信息 `set -o xtrace`
    + `set -e`:遇到执行非0时退出脚本
    + `set -o nounset`:引用未定义的变量(缺省值为“”)
    + `set -o errexit`:执行失败的命令被忽略
* 命令格式,同一个配置项往往有长和短两种形式
  - -l｜list
  - -r|reverse
* 使用空格（或 Tab 键）区分不同的参数,如果参数之间有多个空格，Bash 会自动忽略多余的空格
* 分号（;）是命令的结束符，使得一行可以放置多个命令
* 注释：特殊的语句，会被shell解释器忽略，以#开头，到行尾结束
* 文件
  - dirname：显示最后一个结点前的路径
  - basename：显示最后一个结点的名称
* 外部命令
  - 程序通常位于/bin、/usr/bin、/sbin或/usr/sbin中
  - 外部命令执行时，会创建出一个子进程。这种操作被称为衍生(forking),需要花费时间和精力来设置新子进程的环境
* 习惯
  - 写脚本一定先测试再到生产上
  - 处理代码退出码:方便脚本跟别的命令行或脚本集成
  - 尽量不要使用 ; 来执行多个命令，而是使用 &&，这样会在出错的时候停止运行后续的命令
  - 对于一些字符串变量，使用引号括起，避免其中有空格或是别的什么诡异字符
  - 如果你的脚有参数，你需要检查脚本运行是否带了你想要的参数，或是，你的脚本可以在没有参数的情况下安全的运行。
  - 为脚本设置 -h 和 --help 来显示帮助信息。千万不要把这两个参数用做为的功能
  - 使用 $() 而不是 “ 来获得命令行的输出，主要原因是易读
  - 小心不同平台，尤其是 MacOS 和 Linux 的跨平台
  - 对于 rm -rf 这样高危操作，需要检查后面的变量名是否为空，比如：rm -rf $MYDIDR/* 如果 $MYDIR为空，结果是灾难性的。
  - 考虑使用 “find/while” 而不是 “for/find”。如：for F in $(find . -type f) ; do echo $F; done 写成 find . -type f | while read F ; do echo $F ; done 不但可以容忍空格，而且还更快。
  - 防御式编程，在正式执行命令前，把相关的东西都检查好，比如，文件目录有没有存在

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

echo "<HTML>
    <HEAD>
          <TITLE>Page Title</TITLE>
    </HEAD>
    <BODY>
          Page body.
    </BODY>
</HTML>"

echo -e 'Hello\nWorld'
```

## 变量

* 命名
  - 字母，数字和下划线组成
  - 第一个字符必须是一个字母或一个下划线，不能是数字
  - 不允许出现空格和标点符号
    + 值包含空格，则必须将值放在引号中
  - 存储数字类型或者字符串类型
  - 赋值等号两边不能有空格
  - 可以重复赋值，后面的赋值会覆盖前面的赋值
  - 同一行定义多个变量，必须使用分号（;）分隔
  - 字符串变量可以用单引号或者双引号括起来
    + 单引号:保留字符字面含义，各种特殊字符在单引号里面，都会变为普通字符，不能包含变量
      * 单引号之中使用单引号，不能使用转义，需要在外层的单引号前面加上一个美元符号（$），然后再对里层的单引号转义 `echo $'it\'s'`,更合理的方法是改在双引号之中使用单引号
    + 双引号:变量引用或者命令置换是会被展开的,可以出现转义字符,推荐使用
      * 美元符号（$）、反引号（`）和反斜杠（\）,在双引号之中，依然有特殊含义，会被 Bash 自动扩展。
      * 美元符号用来引用变量
      * 反引号则是执行子命令
      * 换行符在双引号之中，会失去特殊含义，Bash 不再将其解释为命令的结束，只是作为普通的换行符
      * 文件名包含连续空格（或制表符和换行符）,必须使用双引号，将文件名放在里面
      * 保存原始命令输出格式 `echo "$(cal)"`
  - 变量名大写、局部变量小写，函数名小写，名字体现出实际作用
* set命令显示所有变量（包括环境变量和自定义变量），以及所有的 Bash 函数
* 默认值
  - ${varname:-word} 如果变量varname存在且不为空，则返回它的值，否则返回word
  - ${varname:+word} 如果变量名存在且不为空，则返回word，否则返回空值.测试变量是否存在
    + ${count:+1}
  - ${varname:?message} 如果变量varname存在且不为空，则返回它的值，否则打印出varname: message，并中断脚本的执行,防止变量未定义
  - 变量名的部分可以用数字1到9，表示脚本的参数 `filename=${1:?"filename missing."}`
* 调用：`$|${}`
  - 使用花括号{}包围,用于变量名与其他字符连用的情况
  - 如果变量的值本身也是变量，可以使用${!varname}的语法，读取最终的值
* unset命令用来删除一个变量,不存在的 Bash 变量一律等于空字符串，所以即使unset命令删除了变量，还是可以读取这个变量，值为空字符串
  - 删除一个变量，也可以将这个变量设成空字符串
* declare命令可以声明一些特殊类型的变量，为变量设置一些限制
  - -a：声明数组变量
  - -f：输出所有函数定义
  - -F：输出所有函数名
  - -i：声明整数变量
  - -l：声明变量为小写字母
  - -p：查看变量信息
  - -r：声明只读变量
  - -u：声明变量为大写字母
  - -x：该变量输出为环境变量
  - 不带任何参数时，declare命令输出当前环境的所有变量，包括函数在内，等同于不带有任何参数的set命令
  - 一个变量声明为整数以后，依然可以被改写为字符串
* readonly 将变量定义为只读，意味着不能改变
  - -f：声明的变量为函数名
  - -p：打印出所有的只读变量
  - -a：声明的变量为数组
* let命令声明变量时，可以直接执行算术表达式
* 全局变量
  - 对于 shell 会话和所有生成子 shell 可见
  - 创建:先创建一个局部环境变量，然后再导出到全局环境中
  - 修改|删除子shell中全局环境变量并不会影响到父shell中该变量的值
  - 子 shell 甚至无法使用 export 命令改变父shell中全局环境变量值
  - unset 命令中引用环境变量时，记住不要使用$
    + 在子进程中删除一个全局环境变量，只对子进程有效。该全局环境变量在父进程中依然可用
* 局部变量 Local variables
  - 在某个脚本内部有效变量,不能被其他的程序和脚本访问
  - 声明:用=声明，变量名、等号和值之间没有空格 `username="denysdovhan"`
  - 访问:`echo $username`
  - 删除:`unset username`
  - 给变量赋一个含有空格的字符串值，必须用单引号来界定字符串的首和尾
  - local 关键字声明属于某个函数的局部变量，会在函数结束时消失
  - 如果生成了另外一个shell，它在子shell中就不可用,退出了子进程，那个局部环境变量就不可用
  - 回到父shell时，子shell中设置的局部变量就不存在
* 环境变量 Environment variables
  - 当前shell会话内所有的程序或脚本都可见的变量,创建跟创建局部变量类似，但使用export关键字 `export GLOBAL_VAR="I'm a global variable"`
  - 把变量传递给子 Shell，需要使用export命令。这样输出的变量，对于子 Shell 来说就是环境变量,子 Shell 如果修改继承的变量，不会影响父 Shell
  - 保存操作系统运行时使用参数,长期使用，可以写在配置文件中。`/etc/profile` 或者用户家目录 `.bash_profile`
  - 基本上用全大写字母，以区别于普通用户环境变量
  - env|printenv 显示所有环境变量
  - printenv|echo varibale 查看单个环境变量值
  - BASHPID：Bash 进程的进程 ID。
  - BASHOPTS：当前 Shell 的参数，可以用shopt命令修改。
  - BASH_LINENO返回一个数组，内容是每一轮调用对应的行号
  - BASH_SOURCE返回一个数组，内容是当前的脚本调用堆栈。该数组的0号成员是当前执行的脚本，1号成员是调用当前脚本的脚本
  - DISPLAY：图形环境的显示器名字，通常是:0，表示 X Server 的第一个显示器。
  - EDITOR：默认的文本编辑器。
  - FUNCNAME返回一个数组，内容是当前的函数调用堆栈。该数组的0号成员是当前调用的函数，1号成员是调用当前函数的函数
  - HOME：用户的主目录。
  - HOST：当前主机的名称。
  - IFS：词与词之间的分隔符，默认为空格。
  - LANG：字符集以及语言编码，比如zh_CN.UTF-8。
  - LINENO返回它在脚本里面的行号
  - PATH：由冒号分开的目录列表，当输入可执行程序名后，会搜索这个目录列表。
  - PWD：当前工作目录。
  - RANDOM：返回一个0到32767之间的随机数。
  - SHELL：Shell 的名字。
  - SHELLOPTS：启动当前 Shell 的set命令的参数
  - TERM：终端类型名，即终端仿真器所用的协议。
  - UID：当前用户的 ID 编号。
  - USER：当前用户的用户名。
  - PS1：Shell 提示符 通常是美元符号$，对于根用户则是井号#
  - PS2： 输入多行命令时，折行输入时系统的提示符，默认为>。
  - PS3 使用select命令时，系统输入菜单的提示符
  - PS4 默认为+。使用 Bash 的-x参数执行脚本时，每一行命令在执行前都会先打印出来，并且在行首出现的那个提示符
    + \a    ASCII 响铃字符（也可以键入 \007）
    + \d    "Wed Sep 06" 格式的日期
    + \e    ASCII 转义字符（也可以键入 \033）
    + \h    主机名的第一部分（如 "mybox"）
    + \H    主机的全称（如 "mybox.mydomain.com"）
    + \j    在此 shell 中通过按 ^Z 挂起的进程数
    + \l    此 shell 的终端设备名（如 "ttyp4"）
    + \n    换行符
    + \r    回车符
    + \s    shell 的名称（如 "bash"）
    + \t    24 小时制时间（如 "23:01:01"）
    + \T    12 小时制时间（如 "11:01:01"）
    + \@    带有 am/pm 的 12 小时制时间
    + \u    用户名
    + \v    bash 的版本（如 2.04）
    + \V    Bash 版本（包括补丁级别） ?/td>
    + \w    当前工作目录（如 "/home/drobbins"）
    + \W    当前工作目录的“基名 (basename)”（如 "drobbins"）
    + `\!`    当前命令在历史缓冲区中的位置
    + `\#`    命令编号（只要您键入内容，它就会在每次提示时累加）
    + `\$`    如果您不是超级用户 (root)，则插入一个 "$"；如果您是超级用户，则显示一个 "#"
    + \xxx    插入一个用三位数 xxx（用零代替未使用的数字，如 "\007"）表示的 ASCII 字符
    + `\\`    反斜杠
    + `\[`    这个序列应该出现在不移动光标的字符序列（如颜色转义序列）之前。它使 bash 能够正确计算自动换行。
    + `\]`    这个序列应该出现在非打印字符序列之后
  - 文本颜色
    + \033[0;30m：黑色
    + \033[1;30m：深灰色
    + \033[0;31m：红色
    + \033[1;31m：浅红色
    + \033[0;32m：绿色
    + \033[1;32m：浅绿色
    + \033[0;33m：棕色
    + \033[1;33m：黄色
    + \033[0;34m：蓝色
    + \033[1;34m：浅蓝色
    + \033[0;35m：粉红
    + \033[1;35m：浅粉色
    + \033[0;36m：青色
    + \033[1;36m：浅青色
    + \033[0;37m：浅灰色
    + \033[1;37m：白色
  - 背景颜色
    + \033[0;40m：蓝色
    + \033[1;44m：黑色
    + \033[0;41m：红色
    + \033[1;45m：粉红
    + \033[0;42m：绿色
    + \033[1;46m：青色
    + \033[0;43m：棕色
    + \033[1;47m：浅灰色
* 预定义变量｜位置参数 Positional parameters：调用一个函数并传给它参数时创建的变量,类似于环境变量，不同是不能重定义
  - `$0`  脚本名称
  - `$1 … $9`  传给脚本/函数的第1个到第9个参数列表,第10个参数可以用${10}的形式引用
  - `$$`  脚本PID
  - `$!`  上一个后台执行的异步命令的进程 ID
  - `$-`  当前 Shell 的启动参数
  - `$_`  上一个命令的最后一个参数
  - `$?`  上一个命令退出状态(管道命令使用${PIPESTATUS})
  - `$#`  传递给脚本/函数的参数个数,能够处理空格参数
  - `$@`  传递给脚本/函数的所有参数(识别每个参数) 参数之间使用空格分隔
  - `$*`  传递给脚本/函数的所有参数(把所有参数当成一个字符串)，参数之间使用变量$IFS值的第一个字符分隔，默认为空格，但是可以自定义
  - `@`与`"*"`区别:在使用双引号时候。如果脚本运行时两个参数为a,b，则"*"等价于"ab",而"@"等价于"a","b"
  - `${10}`   在超过两位数的参数时，使用大括号限定起来
  - $FUNCNAME 函数名称（仅在函数内部有值）
* 自定义变量：用户在当前 Shell 里面自己定义的变量，必须先定义后使用，而且仅在当前 Shell 可用。一旦退出当前 Shell，该变量就不存在了
* 转义 escape
  - 原样输出特殊字符，在前面加上反斜杠，使其变成普通字符
  - 在命令行使用不可打印字符，把它们放在引号里面，然后使用echo命令的-e参数
  - 换行符是一个特殊字符，表示命令的结束，Bash 收到这个字符以后，就会对输入的命令进行解释执行。换行符前面加上反斜杠转义，就使得换行符变成一个普通字符，Bash 会将其当作空格处理，从而可以将一行命令写成多行

```sh
printenv HOME
echo "Your home: $HOME" # Your home: /Users/<username>
echo 'Your home: $HOME' # Your home: $HOME

my_variable="I am Global now"
export my_variable
echo $my_variable

# 如果变量为空，赋给默认值
${VAR:='default'}
${$1:='first'}
# 或者
FOO=${FOO:-'default'}

# /* PS1 用户主提示符配色方案(在 .bashrc 文件中添加) */
export PS1="\[\e[0;36m\]\u\[\e[m\]@\[\e[0;32m\]\h: \[\e[0;35m\]\W\[\e[m\] \\$"
PS1='\[\033[0;41m\]<\u@\h \W>\$\[\033[0m\] '

# // 另外种等效写法
# export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h: \

# // 另外种主提示符样式(（)对CentOS默认的主提示符加颜色标识)
# export PS1="[\[\e[0;36m\]\u\[\e[m\]@\[\e[0;32m\]\h \[\e[0;35m\]\W\[\e[m\]]\\$  "
```

## 扩展 expansions

* Shell 接收到用户输入的命令以后，会根据空格将用户的输入，拆分成一个个词元（token）。然后，Shell 会扩展词元里面的特殊字符，扩展完成后才会调用相应的命令
* 模式扩展 globbing|通配符扩展 wildcard expansion:特殊字符的扩展
  - 关闭扩展 `set -o noglob` `set -f`
* 发生在一行命令被分成一个个的记号（tokens）之后,一种执行数学运算的机制，还可以用来保存命令的执行结果
* 波浪线扩展
  - 自动扩展成当前用户主目录
  - ~+会扩展成当前所在的目录
* ? 字符扩展
  - 代表文件路径里面任意单个字符，不包括空字符
  - 如果匹配多个字符，就需要多个?连用
  - 属于文件名扩展，只有文件确实存在的前提下，才会发生扩展。如果文件不存在，扩展就不会发生
* * 字符扩展
  - 代表文件路径里面的任意数量的任意字符，包括零个字符
  - 输出当前目录的所有文件，直接用*即可
  - 不会匹配隐藏文件（以.开头的文件）
  - 匹配隐藏文件，需要写成.*
  - 匹配隐藏文件，同时要排除.和..这两个特殊的隐藏文件 .[!.]*
  - 只匹配当前目录，不会匹配子目录 `*/*.txt`
* 方括号扩展
  - 只有文件确实存在的前提下才会扩展
  - 属于文件名匹配，即扩展后的结果必须符合现有的文件路径。如果不存在匹配，就会保持原样，不进行扩展
  - 简写形式[start-end]，表示匹配一个连续的范围
    + [a-z]：所有小写字母
    + [a-zA-Z]：所有小写字母与大写字母
    + [a-zA-Z0-9]：所有小写字母、大写字母与数字
    + [abc]*：所有以a、b、c字符之一开头的文件名
    + program.[co]：文件program.c与文件program.o
    + `BACKUP.[0-9][0-9][0-9]`：所有以BACKUP.开头，后面是三个数字的文件名
  - 否定形式[!start-end]
* 大括号扩展
  - 让生成任意字符串成为可能。跟文件名扩展很类似
  - 创建一个可被循环迭代的区间 {start..end}
    + 支持逆序
  - 逗号前面可以没有值，表示扩展的第一项为空
  - 内部的逗号前后不能有空格
  - 可以嵌套
  - 不是文件名扩展，所以总是会扩展
* 变量扩展
  - 将美元符号$开头的词元视为变量，将其扩展成变量值
  - 变量名放在${}里面
  - `${!string*}`或`${!string@}`返回所有匹配给定字符串string的变量名
  - ${!S*} 所有以S开头的变量名
* 子命令扩展|进程替换 process substitution|命令置换
  - `` 或 $(...)可以扩展成另一个命令的运行结果，该命令所有输出都会作为返回值
  - 通过 `$( CMD )` 这样的方式来执行CMD 这个命令时，然后它的输出结果会替换掉 $( CMD )
* 算数扩展:算数表达式必须包在$(( ))中
* 字符类 [[:class:]]表示一个字符类，扩展成某一类特定字符之中的一个
  - [[:alnum:]]：匹配任意英文字母与数字
  - [[:alpha:]]：匹配任意英文字母
  - [[:blank:]]：空格和 Tab 键。
  - [[:cntrl:]]：ASCII 码 0-31 的不可打印字符。
  - [[:digit:]]：匹配任意数字 0-9。
  - [![:digit:]] 匹配所有非数字
  - [[:graph:]]：A-Z、a-z、0-9 和标点符号。
  - [[:upper:]]：匹配任意大写字母 A-Z。
  - [[:lower:]]：匹配任意小写字母 a-z。
  - [[:print:]]：ASCII 码 32-127 的可打印字符。
  - [[:punct:]]：标点符号（除了 A-Z、a-z、0-9 的可打印字符）。
  - [[:space:]]：空格、Tab、LF（10）、VT（11）、FF（12）、CR（13）。
  - [[:xdigit:]]：16进制字符（A-F、a-f、0-9）。
* 注意
  - 通配符是先解释，再执行
  - 文件名扩展在不匹配时，会原样输出
  - 所有文件名扩展只匹配单层路径，不能跨目录匹配，即无法匹配子目录里面的文件。或者说，?或*这样的通配符，不能匹配路径分隔符（/）
  - 允许文件名使用通配符，即文件名包括特殊字符
* 量词语法用来控制模式匹配的次数。在 Bash 的extglob参数打开的情况下才能使用，默认打开的。查询 `shopt extglob`
  - ?(pattern-list)：匹配零个或一个模式
  - *(pattern-list)：匹配零个或多个模式
  - +(pattern-list)：匹配一个或多个模式
  - @(pattern-list)：只匹配一个模式
  - !(pattern-list)：匹配零个或一个以上的模式，但不匹配单独一个的模式
* 当局部变量和环境变量包含空格时，在引号中的扩展
  - 输入 可能 包含空格，务必要用引号把表达式包起来

```sh
ls ??.txt
ls *.txt
ls [ab].txt

echo beg{i,a,u}n # begin began begun
echo {0..5} # 0 1 2 3 4 5
echo {00..8..2} # 00 02 04 06 08
# 等同于 cp a.log a.log.bak
cp a.log{,.bak}
echo a{A{1,2},B{3,4}}b
echo {a..c}{1..3} # a1 a2 a3 b1 b2 b3 c1 c2 c3

# 命令置换
now=`date +%T`
# or
now=$(date +%T)
echo $now # 19:08:26

result=$(( ((10 + 5*3) - 7) / 2 ))
echo $result # 9

x=4
y=7
echo $(( x + y ))     # 11
echo $(( ++x + y++ )) # 12
echo $(( x + y ))     # 13

INPUT="A string  with   strange    whitespace."
# 给了5个单独的参数 —— $INPUT被分成了单独的词，echo在每个词之间打印了一个空格
echo $INPUT   # A string with strange whitespace.
# 只给了它一个参数（整个$INPUT的值，包括其中的空格）
echo "$INPUT" # A string  with   strange    whitespace.

FILE="Favorite Things.txt"
cat $FILE   # 尝试输出两个文件: `Favorite` 和 `Things.txt`
cat "$FILE" # 输出一个文件: `Favorite Things.txt`

ls abc+(.txt)

# 打开某个参数
shopt -s [optionname]
# 关闭某个参数
shopt -u [optionname]
# 查询某个参数关闭还是打开
shopt [optionname]
```

## 字符串操作

* ${#varname} 获取字符串长度
* ${varname:offset:length} 提取子串
  - 不能直接操作字符串，只能通过变量来读取字符串，并且不会改变原始字符串。变量前面的美元符号可以省略
  - 省略length，则从位置offset开始，一直返回到字符串的结尾
  - offset为负值，表示从字符串的末尾开始算起。注意，负数前面必须有一个空格， 以防止与${variable:-word}的变量的设置默认值语法混淆
  - length可以是正值，也可以是负值
* 搜索和替换
  - 字符串头部模式匹配:检查字符串开头，是否匹配给定的模式。如果匹配成功，就删除匹配的部分，返回剩下的部分。原始变量不会发生变化
    + 匹配模式pattern可以使用*、?、[]等通配符
    + 头部匹配部分，替换成其他内容
  - 字符串尾部模式匹配
  - 任意位置的模式匹配
    + 模式部分可以使用通配符
    + 如果省略了string部分，那么就相当于匹配的部分替换成空字符串，即删除匹配的部分

```sh
count=frogfootman
echo ${count:4:4}
foo="This string is long."
echo ${foo: -5} # long.
echo ${foo: -5:2} # lo
echo ${foo: -5:-2} # lon

# 如果 pattern 匹配变量 variable 的开头，
# 删除最短匹配（非贪婪匹配）部分，返回剩余部分
${variable#pattern}

# 如果 pattern 匹配变量 variable 的开头，
# 删除最长匹配（贪婪匹配）的部分，返回剩余部分
${variable##pattern}

path=/home/cam/book/long.file.name
echo ${path##*/} # long.file.name

# 模式必须出现在字符串的开头
${variable/#pattern/string}
foo=JPG.JPG
echo ${foo/#JPG/jpg} jpg.JPG

# 如果 pattern 匹配变量 variable 的结尾，
# 删除最短匹配（非贪婪匹配）的部分，返回剩余部分
${variable%pattern}

# 如果 pattern 匹配变量 variable 的结尾，
# 删除最长匹配（贪婪匹配）的部分，返回剩余部分
${variable%%pattern}
echo ${path%.*} # /home/cam/book/long.file
echo ${path%%.*} # /home/cam/book/long
echo ${path%/*} # /home/cam/book
# 替换文件后缀名
file=foo.png
echo ${file%.png}.jpg

# 尾部替换
${variable/%pattern/string}
foo=JPG.JPG
echo ${foo/%JPG/jpg} # JPG.jpg

# 如果 pattern 匹配变量 variable 的一部分，
# 最长匹配（贪婪匹配）的那部分被 string 替换，但仅替换第一个匹配
${variable/pattern/string}

# 如果 pattern 匹配变量 variable 的一部分，
# 最长匹配（贪婪匹配）的那部分被 string 替换，所有匹配都替换
${variable//pattern/string}
path=/home/cam/foo/foo.name
echo ${path/foo/bar} # /home/cam/bar/foo.name
echo ${path//foo/bar} # /home/cam/bar/bar.name

# 转为大写
${varname^^}
# 转为小写
${varname,,}
```

## 数组 array

* 下标从0开始
* 注意特殊环境变量 Input Field Separator IFS，保存了数组中元素的分隔符,默认值是一个空格 IFS=' '
* 通过 切片 运算符来取出数组中的某一片元素
* @和*放不放在双引号之中，是有差别的
  - 在引号内，${fruits[@]}将数组中的每个元素扩展为一个单独的参数；数组元素中的空格得以保留
  - ${activities[*]} 放在双引号之中，所有元素就会变成单个字符串返回
* 拷贝数组 `hobbies=( "${activities[@]}" )`
* 引用一个不带下标的数组变量，则引用的是0号位置的数组元素
* `${!array[@]}`|`${!array[*]}`:可以返回数组的成员序号，即哪些位置是有值的
* 提取数组成员: `${array[@]:offset:length}`
* unset 删除一个数组成员
  - 将某个成员设为空值，可以从返回值中“隐藏”这个成员,这个成员仍然存在，只是值变成了空值,不建议
* 直接将数组变量赋值为空字符串，相当于“隐藏”数组的第一个成员
* unset ArrayName可以清空整个数组
* Bash 新版本支持关联数组

```sh
fruits[0]=Apple
fruits[1]=Pear
fruits[2]=Plum

fruits=(Apple Pear Plum)
array=([2]=c [0]=a [1]=b)
# 当前目录的所有 MP3 文件，放进一个数组
mp3s=( *.mp3 )

declare -a ARRAYNAME

# 关联数组
declare -A colors
colors["red"]="#ff0000"
colors["green"]="#00ff00"
colors["blue"]="#0000ff"

echo ${fruits[1]} # Pear

fruits[2]=seven
echo ${fruits[*]} # Apple Pear seven
echo ${fruits[@]} # Apple Pear seven
printf "+ %s\n" ${fruits[*]}

fruits[1]="Desert fig"
printf "+ %s\n" ${fruits[*]}
# + Apple
# + Desert
# + fig
# + Plum
printf "+ %s\n" "${fruits[@]}"
echo ${fruits[@]:0:2} # Apple Desert fig

# 添加元素
fruits=(Orange "${fruits[@]}" Banana Cherry)
echo ${fruits[@]} # Orange Apple Desert fig Plum Banana Cherry

foo=(a b c)
foo+=(d e f)

unset fruits[2]

# 数组长度
${#array[*]}
${#array[@]}
```

## 流，管道以及序列

* 流 Streams：将一个程序的输出发送到另一个程序或文件
* 文件描述符 file descriptor：Each open file gets assigned a file descriptor. A file descriptor is an unique identifier for open files in the system. There are always three default files open
  - 标准输入文件 stdin(the keyboard),：文件描述符 0
  - 标准输出文件 stdout(the screen)：文件描述符 1
  - 标准错误文件 stderr(error messages output to the screen)：文件描述符 2
* 管道 pipes：把一个程序的输出当做另一个程序的输入 `command1 | command2 | command3`
  - 管道的返回值通常是管道中最后一个命令的返回值
  - shell会等到管道中所有的命令都结束后，才会返回一个值
  - 如果想让管道中任意一个命令失败后，管道就宣告失败，设置pipefail选项 `set -o pipefail`
  - `ssh myserver 'journalctl | grep sshd | grep "Disconnected from"' | less`
    + `ssh myserver 'journalctl | grep sshd | grep "Disconnected from"' > ssh.log` `less ssh.log`
    + 日志是一个非常大的文件，把这么大的文件流直接传输到本地电脑上再进行过滤是对流量的一种浪费。因此采取另外一种方式，先在远端机器上过滤文本内容，然后再将结果传输到本机
* 重定向 I/O Redirection：控制一个命令输入来自哪里，输出结果到什么地方
  - > 重定向输出
  - &>  重定向输出和错误输出
  - &>> 以附加的形式重定向输出和错误输出
  - < 重定向输入
  - <<  Here文档|here document:一种输入多行字符串的方法,格式分成开始标记（<< token）和结束标记（token）
    + 开始标记是两个小于号 + Here 文档的名称，名称可以随意取，后面必须是一个换行符；
    + 结束标记是单独一行顶格写的 Here 文档名称，如果不是顶格，结束标记不起作用。两者之间就是多行字符串的内容
    + 内部会发生变量替换，同时支持反斜杠转义，但是不支持通配符扩展，双引号和单引号也失去语法作用，变成了普通字符。
    + 不希望发生变量替换，可以把 Here 文档的开始标记放在单引号之中
    + 本质是重定向，将字符串重定向输出给某个命令，相当于包含了echo命令,只适合那些可以接受标准输入作为参数的命令,也不能作为变量的值，只能用于命令的参数
  - <<< Here字符串|Here string
    + 将字符串通过标准输入，传递给命令 `md5sum <<< 'ddd'`
* 命令序列 lists:由;，&，&&或者||运算符分隔的一个或多个管道序列
  - 命令以&结尾，shell将会在一个子shell中异步执行这个命令
  - 以;分隔的命令将会依次执行：一个接着一个。shell会等待直到每个命令执行完
  - 以&&和||分隔的命令分别叫做 与 和 或 序列
  - `command1 && command2 || command3`:command1 退出时返回码为零，就执行 command2，否则执行 command3
  - 成为进程列表:命令必须包含在括号里 `(pwd ; ls ; cd /etc ; pwd ; cd ; pwd ; ls)` 生成了一个子shell来执行对应的命令

```sh
# ls的结果将会被写到list.txt中
ls -l > list.txt

# 将输出附加到list.txt中
ls -a >> list.txt

# 所有的错误信息会被写到errors.txt中
grep da * 2> errors.txt

# 从errors.txt中读取输入
less < errors.txt

ls -l | grep .md$ | less

# command2 会在 command1 之后执行
command1 ; command2

# 当且仅当command1执行成功（返回0值）时，command2才会执行
command1 && command2
# 当且仅当command1执行失败（返回错误码）时，command2才会执行
command1 || command2

cat << _EOF_
<html>
<head>
    <title>
    The title of your page
    </title>
</head>

<body>
    Your page content goes here.
</body>
</html>
_EOF_

foo='hello world'
$ cat << '_example_'
$foo
"$foo"
'$foo'
_example_

# $foo
# "$foo"
# '$foo'

command << token
  string
token
```

## 运算符

* 算数运算
  - 算术表达式 ((...))语法可以进行整数的算术运算
    + 会自动忽略内部的空格
    + 语法不返回值，命令执行的结果根据算术运算的结果而定。只要算术结果不是0，命令就算执行成功
    + 要读取算术运算的结果，需要在((...))前面加上美元符号$((...))，使其变成算术表达式，返回算术运算的值
    + 内部可以用圆括号改变运算顺序
    + 可以嵌套
    + 不需要在变量名之前加上$，不过加上也不报错
    + 使用字符串，Bash 会认为那是一个变量名。如果不存在同名变量，Bash 就会将其作为空值，因此不会报错
    + 如果一个变量的值为字符串,即该字符串如果不对应已存在的变量，在$((...))里面会被当作空值
    + `expr 表达式`
      * 支持变量替换
    + 运算符号两边要有空格
    + 遇到特殊符号如*号需要在前面加反斜杠
    + 空格和特殊字符串需要用引号括起来
    + 操作:(先编写一个运算相关的shell脚本)
  - 进制
    + number：没有任何特殊表示法的数字是十进制数（以10为底）。
    + 0number：八进制数。
    + 0xnumber：十六进制数。
    + base#number：base进制的
  - 算术运算符
    + +：加法
    + -：减法
    + *：乘法
    + /：除法（整除）
    + %：余数
    + **：指数
    + ++：自增运算（前缀或后缀）
    + --：自减运算（前缀或后缀）
  - 位运算符
    + <<：位左移运算，把一个数字的所有位向左移动指定的位。
    + >>：位右移运算，把一个数字的所有位向右移动指定的位。
    + &：位的“与”运算，对两个数字的所有位执行一个AND操作。
    + |：位的“或”运算，对两个数字的所有位执行一个OR操作。
    + ~：位的“否”运算，对一个数字的所有位取反。
    + ^：位的异或运算（exclusive or），对两个数字的所有位执行一个异或操作
  - 逻辑运算符
    + <：小于
    + >：大于
    + <=：小于或相等
    + >=：大于或相等
    + ==：相等
    + !=：不相等
    + &&：逻辑与
    + ||：逻辑或
    + !：逻辑否
    + expr1?expr2:expr3：三元条件运算符。若表达式expr1的计算结果为非零值（算术真），则执行表达式expr2，否则执行表达式expr3
  - 赋值运算
    + parameter = value：简单赋值。
    + parameter += value：等价于parameter = parameter + value。
    + parameter -= value：等价于parameter = parameter – value。
    + parameter *= value：等价于parameter = parameter * value。
    + parameter /= value：等价于parameter = parameter / value。
    + parameter %= value：等价于parameter = parameter % value。
    + parameter <<= value：等价于parameter = parameter << value。
    + parameter >>= value：等价于parameter = parameter >> value。
    + parameter &= value：等价于parameter = parameter & value。
    + parameter |= value：等价于parameter = parameter | value。
    + parameter ^= value：等价于parameter = parameter ^ value
  - 求值运算
    + 逗号,在$((...))内部是求值运算符，执行前后两个表达式，并返回后一个表达式的值
  - let命令用于将算术运算的结果，赋予一个变量

```sh
((foo = 5 + 5))
echo $foo
echo $(((5**2) * 3)) # 75

echo $((0xff))
echo $((2#11111111))

echo $((foo = 1 + 2, 3 * 4)) # 12
```

## 行操作

* 内置了 Readline 库，具有这个库提供的很多“行操作”功能,默认采用 Emacs 快捷键，也可以改成 Vi 快捷键 `set -o vi|emacs`
  - 永久性更改编辑模式（Emacs / Vi），可以将命令写在~/.inputrc文件 `set editing-mode vi`
* 光标移动
  - Ctrl + a：移到行首。
  - Ctrl + b：向行首移动一个字符，与左箭头作用相同。
  - Ctrl + e：移到行尾。
  - Ctrl + f：向行尾移动一个字符，与右箭头作用相同。
  - Alt + f：移动到当前单词的词尾。
  - Alt + b：移动到当前单词的词首。
  - Ctrl + l 清除屏幕
* 编辑
  - Ctrl + d：删除光标位置的字符（delete）。
  - Ctrl + w：删除光标前面的单词。
  - Ctrl + t：光标位置的字符与它前面一位的字符交换位置（transpose）。
  - Alt + t：光标位置的词与它前面一位的词交换位置（transpose）。
  - Alt + l：将光标位置至词尾转为小写（lowercase）。
  - Alt + u：将光标位置至词尾转为大写（uppercase
  - Ctrl + k：剪切光标位置到行尾的文本。
  - Ctrl + u：剪切光标位置到行首的文本。
  - Alt + d：剪切光标位置到词尾的文本。
  - Alt + Backspace：剪切光标位置到词首的文本。
  - Ctrl + y：在光标位置粘贴文本
* 自动补全
  - Tab：完成自动补全。
  - Alt + ?：列出可能的补全，与连按两次 Tab 键作用相同。
  - Alt + /：尝试文件路径补全。
  - Ctrl + x /：先按Ctrl + x，再按/，等同于Alt + ?，列出可能的文件路径补全。
  - Alt + !：命令补全。
  - Ctrl + x !：先按Ctrl + x，再按!，等同于Alt + !，命令补全。
  - Alt + ~：用户名补全。
  - Ctrl + x ~：先按Ctrl + x，再按~，等同于Alt + ~，用户名补全。
  - Alt + $：变量名补全。
  - Ctrl + x $：先按Ctrl + x，再按$，等同于Alt + $，变量名补全。
  - Alt + @：主机名补全。
  - Ctrl + x @：先按Ctrl + x，再按@，等同于Alt + @，主机名补全。
  - Alt + *：在命令行一次性插入所有可能的补全。
  - Alt + Tab：尝试用.bash_history里面以前执行命令，进行补全。
* 历史
  - 将用户在当前 Shell 的操作历史写入~/.bash_history文件，该文件默认储存500个操作 `echo $HISTFILE`
  - history
    + -a shell会话之前强制将命令历史记录写入.bash_history文件
    + -c 清除操作历史
  - `!e` 表示找出操作历史之中，最近的那一条以e开头的命令并执行
  - ”感叹号 + 字符“会扩展成以前执行过的命令，所以含有感叹号的字符串放在双引号里面，必须非常小心
  - `export HISTTIMEFORMAT='%F %T  '` 自定义格式
  - `export HISTSIZE=0` 不希望保存本次操作的历史
  - 快捷键
    + Ctrl + p：显示上一个命令，与向上箭头效果相同（previous）。
    + Ctrl + n：显示下一个命令，与向下箭头效果相同（next）。
    + Alt + <：显示第一个命令。
    + Alt + >：显示最后一个命令，即当前的命令。
    + Ctrl + o：执行历史文件里面的当前条目，并自动显示下一条命令
    + !!：执行上一个命令。
    + !n：执行历史文件里面行号为n的命令。
    + !-n：执行当前命令之前n条的命令。
    + !string：执行最近一个以指定字符串string开头的命令。
    + !?string：执行最近一条包含字符串string的命令。
    + ^string1^string2：执行最近一条包含string1的命令，将其替换成string2

## 文件管理

* 新建文件夹(mkdir)
* 新建文件(touch)
* 移动(mv)
* 复制(cp)
* 删除(rm)
* `cd -` 可以返回前一次的目录
* 目录堆栈
  - dirs 可以显示目录堆栈的内容
  - `pushd dirname` 进入目录dirname，并将该目录放入堆栈
    + 第一次使用时，会将当前目录先放入堆栈，然后将所要进入的目录也放入堆栈，位置在前一个记录的上方。以后每次使用pushd命令，都会将所要进入的目录，放在堆栈的顶部。
  - popd命令不带有参数时，会移除堆栈的顶部记录，并进入新的堆栈顶部目录（即原来的第二条目录）
  - 参数
    + -n 表示仅操作堆栈，不改变目录
    + 接受一个整数作为参数，该整数表示堆栈中指定位置的记录（从0开始），作为操作对象。这时不会切换目录
* 链接
  - 符号链接就是一个实实在在的文件，它指向存放在虚拟目录结构中某个地方的另一个文件
  - 硬链接会创建独立的虚拟文件，其中包含了原始文件的信息及位置。但是它们从根本上而言是同一个文件。引用硬链接文件等同于引用了源文件。只能对处于同一存储媒体的文件创建硬链接。要想在不同存储媒体的文件之间创建链接， 只能使用符号链接。
* 临时文件
  - 创建前检查文件是否已经存在
  - 确保临时文件已成功创建
  - 必须有权限限制
  - 要使用不可预测的文件名
  - mktemp 生成一个临时文件，文件名是随机的，而且权限是只有用户本人可读写
    + -d 可以创建一个临时目录
    + -p 可以指定临时文件所在的目录。默认是使用$TMPDIR环境变量指定的目录，如果这个变量没设置，那么使用/tmp目录
    + -t 可以指定临时文件的文件名模板，模板末尾必须至少包含三个连续的X字符，表示随机字符，建议至少使用六个X。默认的文件名模板是tmp.后接十个随机字符
  - 后面最好使用 OR 运算符（||），指定创建失败时退出脚本
  - 保证脚本退出时临时文件被删除，使用trap命令指定退出时的清除操作
* `trap [动作] [信号1] [信号2] ...` 在 Bash 脚本中响应系统信号
  - `trap -l` 可以列出所有系统信号
    + HUP：编号1，脚本与所在的终端脱离联系。
    + INT：编号2，用户按下 Ctrl + C，意图让脚本终止运行。
    + QUIT：编号3，用户按下 Ctrl + 斜杠，意图退出脚本。
    + KILL：编号9，该信号用于杀死进程。
    + TERM：编号15，这是kill命令发出的默认信号。
    + EXIT：编号0，这不是系统信号，而是 Bash 脚本特有的信号，不管什么情况，只要退出脚本就会产生
  - trap命令必须放在脚本的开头。否则，它上方的任何命令导致脚本退出，都不会被它捕获
  - trap 需要触发多条命令，可以封装一个 Bash 函数

```sh
file my_file
mount # 输出当前系统上挂载设备列表
mount -t vfat /dev/sdb1 /media/disk
umount /home/rich/mnt
df -h

grep [options] pattern [file]
grep -v t file1 # 反向搜索(输出不匹配该模式的行)
# -c参数:有多少行含有匹配的模式

TMPFILE=$(mktemp) || exit 1

mktemp -t mytemp.XXXXXXX
trap 'rm -f "$TMPFILE"' EXIT # 遇到EXIT信号时，就会执行rm -f "$TMPFILE"

#!/bin/bash
trap 'rm -f "$TMPFILE"' EXIT

ls /etc > $TMPFILE
if grep -qi "kernel" $TMPFILE; then
  echo 'find'
fi

# 从栈顶算起的3号目录（从0开始），移动到栈顶
pushd +3
# 从栈底算起的3号目录（从0开始），移动到栈顶
pushd -3
# 删除从栈顶算起的3号目录（从0开始）
popd +3
# 删除从栈底算起的3号目录（从0开始）
popd -3
```

## 控制语句

* 条件语句 Conditional statements: 决定一个操作是否被执行。结果取决于一个包在[[ ]]里的表达式。
  - if
    + 如果中括号里的表达式为真，那么then和fi之间的代码会被执行。fi标志着条件代码块的结束
    + if关键字后面也可以是一条命令，该条命令执行成功（返回值0），就意味着判断条件成立
    + if后面可以跟任意数量的命令。这时，所有命令都会执行，但是判断真伪只看最后一个命令，即使前面所有命令都失败，只要最后一个命令返回0，就会执行
  - case:面对很多情况，分别要采取不同的措施
    + |用来分割多个模式，)用来结束一个模式序列
      * a)：匹配a。
      * a|b)：匹配a或b。
      * [[:alpha:]])：匹配单个字母。
      * ???)：匹配3个字符的单词。
      * *.txt)：匹配.txt结尾。
      * *)：匹配任意输入，通过作为case结构的最后一个模式。
    + 第一个匹配上的模式对应的命令将会被执行
    + 命令块儿之间要用;;分隔
    + Bash 4.0之前，case结构只能匹配一个条件，然后就会退出case结构。Bash 4.0之后，允许匹配多个条件，这时可以用;;&终止每个条件块。
  - 基元和组合表达式|检测命令|条件表达式:帮助检测一个条件的结果
    + `test expression`
    + `[ expression ]`
    + `[[ expression ]]`
    + 可以包含&&和||运算符，分别对应 与 和 或
    + 跟文件系统相关
      * -b 是否块设备
      * -c 是否字符设备
      * -g 是否设置SGID
      * -k 是否设置粘着位
      * -p 是否具名管道
      * -u 是否设置SUID
      * [ -e FILE ] 如果文件、目录存在 (exists)，为真
      * [ -f FILE ] 如果FILE存在且为一个普通文件（file），为真
      * [ -d FILE ] 如果FILE存在且为一个目录（directory），为真
      * [ -s FILE ] 如果FILE存在且非空（size 大于0），为真
      * [ -r FILE ] 如果FILE存在且有读权限（readable），为真
      * [ -w FILE ] 如果FILE存在且有写权限（writable），为真
      * [ -x FILE ] 如果FILE存在且有可执行权限（executable），为真
      * [ -L FILE ] 如果FILE存在且为一个符号链接（link），为真
      * [ FILE1 -nt FILE2 ] FILE1比FILE2新（newer than）
      * [ FILE1 -ot FILE2 ] FILE1比FILE2旧（older than）
    + 跟字符串相关
      * `str` 是否为空
      * `<`   字符串比较(双中括号里不需要转移)
      * `=~`  用正则表达式进行字符串比较
      * [ -z STR ]  STR为空（长度为0，zero）
      * [ -n STR ]  STR非空（长度非0，non-zero）
      * [ STR1 == STR2 ]  STR1和STR2相等
      * [ STR1 != STR2 ]  STR1和STR2不等
    + 算数二元运算符
      * [ ARG1 -eq ARG2 ] ARG1和ARG2相等（equal）
      * [ ARG1 -ne ARG2 ] ARG1和ARG2不等（not equal）
      * [ ARG1 -lt ARG2 ] ARG1小于ARG2（less than）
      * [ ARG1 -le ARG2 ] ARG1小于等于ARG2（less than or equal）
      * [ ARG1 -gt ARG2 ] ARG1大于ARG2（greater than）
      * [ ARG1 -ge ARG2 ] ARG1大于等于ARG2（greater than or equal）
    + 组合表达式
      * [ ! EXPR ]  如果EXPR为假，为真
      * [ (EXPR) ]  返回EXPR的值
      * [ EXPR1 -a EXPR2 ]  逻辑 与， 如果EXPR1和（and）EXPR2都为真，为真
      * [ EXPR1 -o EXPR2 ]  逻辑 或， 如果EXPR1或（or）EXPR2为真，为真
* 循环:只要控制条件为真就一直迭代执行的代码块
  - for variable in list; do
    + 每次循环的过程中，arg依次被赋值为从elem1到elemN
    + 值可以是通配符或者大括号扩展
    + for (( expression1; expression2; expression3 )); do
  - while
    + 循环检测一个条件，只要这个条件为 真，就执行一段命令
  - until
    + 跟while一样也需要检测一个测试条件，但不同的是，只要该条件为 假 就一直执行循环
  - select
    + select生成一个菜单，内容是列表list的每一项，并且每一项前面还有一个数字编号。
    + Bash 提示用户选择一项，输入它的编号。
    + 用户输入以后，Bash 会将该项的内容存在变量name，该项的编号存入环境变量REPLY。如果用户没有输入，就按回车键，Bash 会重新输出菜单，让用户选择。
    + 执行命令体commands。
    + 执行结束后，回到第一步，重复这个过程
  - 提前结束一个循环或跳过某次循环执行的情况
    + break语句用来提前结束当前循环
    + continue语句用来跳过某次迭代

```sh
if [[ 1 -eq 1 ]]; then echo "true"; fi

# 写成多行
if [[ 1 -eq 1 ]]; then
  echo "true"
fi

# 写成一行
if [[ 2 -ne 1 ]]; then echo "true"; else echo "false"; fi

# 写成多行
if [[ 2 -ne 1 ]]; then
  echo "true"
else
  echo "false"
fi

if [[ `uname` == "Adam" ]]; then
  echo "Do not eat an apple!"
elif [[ `uname` == "Eva" ]]; then
  echo "Do not take an apple!"
else
  echo "Apples are delicious!"
fi

#!/bin/bash

MIN_VAL=1
MAX_VAL=100

INT=50

if [[ "$INT" =~ ^-?[0-9]+$ ]]; then
  if [[ $INT -ge $MIN_VAL && $INT -le $MAX_VAL ]]; then
    echo "$INT is within $MIN_VAL to $MAX_VAL."
  else
    echo "$INT is out of range."
  fi
else
  echo "INT is not an integer." >&2
  exit 1
fi

case "$extension" in
  "jpg"|"jpeg")
    echo "It's image with jpeg extension."
  ;;
  "png")
    echo "It's image with png extension."
  ;;
  "gif")
    echo "Oh, it's a giphy!"
  ;;
  *)
    echo "Woops! It's not image!"
  ;;
esac

for i in {1..5}; do echo $i; done

#!/bin/bash

for FILE in $HOME/*.bash; do
  mv "$FILE" "${HOME}/scripts"
  chmod +x "${HOME}/scripts/${FILE}"
done

for (( i = 0; i < 10; i++ )); do
  if [[ $(( i % 2 )) -eq 0 ]]; then continue; fi
  echo $i
done

#!/bin/bash

# 0到9之间每个数的平方
x=0
while [[ $x -lt 10 ]]; do
  echo $(( x * x ))
# x加1
  x=$(( x + 1 ))
done

until cp $1 $2; do
  echo 'Attempt to copy failed. waiting...'
  sleep 5
done

#!/bin/bash

PS3="Choose the package manager: "
select ITEM in bower npm gem pip
do
  echo -n "Enter the package name: " && read PACKAGE
  case $ITEM in
    bower) bower install $PACKAGE ;;
    npm)   npm   install $PACKAGE ;;
    gem)   gem   install $PACKAGE ;;
    pip)   pip   install $PACKAGE ;;
  esac
  break # 避免无限循环
done
```

## 函数 function

* 函数是一个命令序列，可以重复使用的代码片段,组织在函数名下面
* 函数总是在当前 Shell 执行，这是跟脚本的一个重大区别，Bash 会新建一个子 Shell 执行脚本.如果函数与脚本同名，函数会优先执行.函数的优先级不如别名，即如果函数与别名同名，那么别名优先执行
* 必须在调用前声明函数
* 可以接收参数并返回结果 —— 返回值
* 参数:在函数内部，跟非交互式下的脚本参数处理方式相同 —— 使用位置参数
* 函数体内直接声明的变量，属于全局变量，整个脚本都可以读取
* 可以修改全局变量
* 用local命令声明局部变量
* 返回值使用return命令返回
* unset 删除一个函数
* 函数 vs 脚本
  - 函数只能用与shell使用相同的语言，脚本可以使用任意语言。因此在脚本中包含 shebang 是很重要的。
  - 函数仅在定义时被加载，脚本会在每次被执行时加载。这让函数的加载比脚本略快一些，但每次修改函数定义，都要重新加载一次。
  - 函数会在当前的shell环境中执行，脚本会在单独的进程中执行。因此，函数可以对环境变量进行更改，比如改变当前工作目录，脚本则不行。脚本需要使用 export 将环境变量导出，并将值传递给环境变量。
  - 与其他程序语言一样，函数可以提高代码模块性、代码复用性并创建清晰性的结构。shell脚本中往往也会包含它们自己的函数定义。

```sh
fn() {
  # codes
}

# 第二种
function fn() {
  # codes
}

# 带参数函数
greeting () {
  if [[ -n $1 ]]; then
    echo "Hello, $1!"
  else
    echo "Hello, unknown!"
  fi
  return 0
}

greeting Denys  # Hello, Denys!
greeting        # Hello, unknown!
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
* 每次bash会生成子shell进程，只有部分父进程的环境被复制到子shell环境中
* 要想知道是否生成了子shell，借助一个使用了环境变量的命令。`echo $BASH_SUBSHELL` 如果该命令返回0，就表明没有子shell。如果返回 1 或者其他更大的数字，就表明存在子shell。 `( pwd ; echo $BASH_SUBSHELL)`
* 生成子shell成本不低，而且速度还慢。创建嵌套子shell更是火上浇油
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

## 返回值 Exit codes

* 每个命令都有一个返回值（返回状态或者退出状态）。命令执行成功的返回值总是0（零值），执行失败的命令，返回一个非0值（错误码）。错误码必须是一个1到255之间的整数
* exit 命令:终止当前执行，并把返回值交给shell。当exit不带任何参数时，会终止当前脚本的执行并返回在它之前最后一个执行的命令的返回值
* 一个程序运行结束后，shell将其返回值赋值给$?环境变量。因此$?变量通常被用来检测一个脚本执行成功与否
* 使用return命令来结束一个函数的执行并将返回值返回给调用者
* 在函数内部用exit，不但会中止函数的继续执行，而且会终止整个程序的执行

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

## Debugging

* set命令用来修改子 Shell 环境的运行参数
  - set 显示所有的环境变量和 Shell 函数
* 想以debug模式运行某脚本，可以在其shebang中使用一个特殊的选项 `#!/bin/bash options`
  - `set -e` 脚本里面有运行失败的命令（返回值非0），Bash 默认会继续执行后面的命令. -e 脚本只要发生错误，就终止执行
    + 不适用于管道命令 `set -o pipefail` 用来解决这种情况，只要一个子命令失败，整个管道命令就失败，脚本就会终止执行
    + 导致函数内的错误不会被trap命令捕获,-E参数可以纠正这个行为，使得函数也能继承trap命令
  - `set -u｜-o nounset` Bash 默认遇到不存在的变量忽略它，-u 就用来改变这种行为。脚本在头部加上它，遇到不存在的变量就会报错，并停止执行
  - `set -f|-o noglob`  禁止文件名展开（globbing）
  - `set -i｜-o interactive` 让脚本以 交互 模式运行
  - `set -n|-o noexec` 读取命令，但不执行（语法检查）
  - -t  — 执行完第一条命令后退出
  - `set -v|-o verbose` 在执行每条命令前，向stderr输出该命令
  - `set -x｜-o xtrace` 在执行每条命令前，向stderr输出该命令以及该命令的扩展参数
    + 输出的命令之前的+号，是由系统变量PS4决定，可以修改这个变量 `export PS4='$LINENO + '`
* debug脚本的一部分:使用set命令会很方便。这个命令可以启用或禁用选项。使用-启用选项，+禁用选项
* shopt命令用来调整 Shell 的参数, 跟set命令的作用很类似。set是从 Ksh 继承的，属于 POSIX 规范的一部分，而shopt是 Bash 特有的
  - shopt 查看所有参数，以及各自打开和关闭状态
    + shopt [optionname] 查询某个参数关闭还是打开
    + shopt -s [optionname] 用来打开某个参数
    + shopt -u [optionname] 用来关闭某个参数
  - dotglob 让扩展结果包括隐藏文件（即点开头的文件）
  - nullglob 让通配符不匹配任何文件名时，返回空字符
  - failglob 通配符不匹配任何文件名时，Bash 会直接报错，而不是让各个命令去处理
  - extglob 使 Bash 支持 ksh 的一些扩展语法。默认应该是打开的,主要应用是支持量词语法
  - nocaseglob 通配符扩展不区分大小写
  - globstar 使得**匹配零个或多个子目录。该参数默认是关闭的
  - -q 也是查询某个参数是否打开，但不是直接输出查询结果，而是通过命令的执行状态（$?）表示查询结果。如果状态为0，表示该参数打开；如果为1，表示该参数关闭

```sh
#!/bin/bash -x

for (( i = 0; i < 3; i++ )); do
  echo $i
done

#!/bin/bash

echo "xtrace is turned off"
set -x
echo "xtrace is enabled"
set +x
echo "xtrace is turned off again"

command
if [ "$?" -ne 0 ]; then echo "command failed"; exit 1; fi

# 写法一
set -Eeuxo pipefail

# 写法二
set -Eeux
set -o pipefail
```

## xargs

* xargs:给命令传递参数的过滤器，将管道或标准输入(（)stdin)数据转换成命令行参数 `xargs [-options] [command]`
  - xargs后面的命令默认是echo
    + 输入xargs按下回车以后，命令行就会等待用户输入，作为标准输入。
    + 可以输入任意内容，然后按下Ctrl d，表示输入结束，这时echo命令就会把前面的输入打印出来
    + 如果不知道命令会变成什么样，可以使用xargs echo来看看会是什么样
  - 能够从文件的输出中读取数据
  - 能够捕获一个命令的输出，然后传递给另外一个命令
  - 参数
    + -a file 从文件中读入作为sdtin
    + -e flag ，注意有的时候可能会是-E，flag必须是一个以空格分隔的标志，当xargs分析到含有flag这个标志的时候就停止。
    + -p 每次执行时候询问用户确认
    + -t 打印出最终要执行的命令，然后直接执行，不需要用户确认
    + -n num 指定每次将多少项，作为命令行参数，默认是用所有的
    + -I 指定每一项命令行参数的替代字符串将xargs的每项名称，一般是一行一行赋值给 {}，可以用 {} 代替
      * `find . -name \*.py | xargs grep some_function` `cat hosts | xargs -I{} ssh root@{} hostname`
    + -r no-run-if-empty 当xargs的输入为空的时候则停止xargs，不用再去执行了。
    + -s num 命令行的最大字符数，指的是 xargs 后面那个命令的最大命令行字符数。
    + -L|l num 指定多少行作为一个命令行参数,限定有多少个命令
    + -d delim 分隔符，默认的xargs分隔符是回车，argument的分隔符是空格，这里修改的是xargs的分隔符。
    + -x exit的意思，配合-s使用
    + -P 指定并行进程，默认是1，为0时候为as many as it can
    + -print0，指定输出的文件列表以null分隔。然后，xargs命令的-0参数表示用null当作分隔符
* `xargs find -name`: 执行命令，将参数分离出来
  - 后紧跟要执行命令
  - 参数输入
    + 通过管道输入
    + 通过命令行直接输入

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

## 快捷键

* Ctrl + L：清除屏幕并将当前行移到页面顶部
* Ctrl + C：中止当前正在执行的命令
* Shift + PageUp：向上滚动
* Shift + PageDown：向下滚动
* Ctrl + U：从光标位置删除到行首
* Ctrl + K：从光标位置删除到行尾
* Ctrl + D：关闭 Shell 会话
* ↑，↓：浏览已执行命令的历史记录

## [bash](http://ftp.gnu.org/gnu/bash/)

* 一个Unix Shell，作为Bourne shell的free software替代品，由Brian Fox为GNU项目编写。发布于1989年，在很长一段时间，Linux系统和macOS系统都把Bash作为默认的shell
* 学习bash原因:当今最强大、可移植性最好的，为所有基于Unix的系统编写高效率脚本的工具之一
* [Bourne-Again Shell manual](https://www.gnu.org/software/bash/manual/)
* [Bash Guide for Beginners](https://www.tldp.org/LDP/Bash-Beginners-Guide/html/)
* [Bash Reference Manual](https://tiswww.case.edu/php/chet/bash/bashref.html)
* [Bash scripting cheat sheet](https://devhints.io/bash)
* [bash(1) – Linux man page](https://linux.die.net/man/1/bash)
* [An A-Z Index of the Bash command line for Linux.](https://ss64.com/bash/)
* [bash-handbook](https://github.com/denysdovhan/bash-handbook):book For those who wanna learn Bash <https://git.io/bash-handbook>
* [bash-completion](https://github.com/scop/bash-completion) Programmable completion functions for bash
* [bash-oo-framework](https://github.com/niieani/bash-oo-framework):Bash Infinity is a modern boilerplate / framework / standard library for bash
* [bash-it](https://github.com/Bash-it/bash-it):A community Bash framework.
* [pure-bash-bible](https://github.com/dylanaraps/pure-bash-bible):📖 A collection of pure bash alternatives to external processes.
* [learnyoubash](https://github.com/denysdovhan/learnyoubash)

### [zsh](https://github.com/zsh-users/zsh)

* [An Introduction to the Z Shell](http://zsh.sourceforge.net)
* [prezto](https://github.com/sorin-ionescu/prezto) The configuration framework for Zsh
* [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)：A delightful community-driven (with 1,000+ contributors) framework for managing your zsh configuration. Includes 200+ optional plugins (rails, git, OSX, hub, capistrano, brew, ant, php, python, etc), over 140 themes to spice up your morning, and an auto-update tool so that makes it easy to keep up with the latest updates from the community. <https://ohmyz.sh/>
  - 兼容 bash
  - 自动 cd:只需输入目录名称
  - 命令选项补齐
  - 目录一次性补全：比如输 Doc/doc
  - 智能替换
  - 行内替换/通配符扩展
  - 拼写纠错
  - 更好的 tab 补全和选择
  - 路径展开 (cd /u/lo/b 会被展开为 /usr/local/bin)
* powerline: need font support
* [plugin](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins)
  - plugin manager
    + [antigen](https://github.com/zsh-users/antigen):The plugin manager for zsh. <http://antigen.sharats.me>
    + [zplug](https://github.com/zplug/zplug):🌺 A next-generation plugin manager for zsh `curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh`
    + [](https://github.com/getantibody/antibody) The fastest shell plugin manager.
  - [Overview](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins-Overview)
  - custom
    + [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)：Fish shell like syntax highlighting for Zsh.
    + [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions):Fish-like autosuggestions for zsh
    + [pure](https://github.com/sindresorhus/pure):Pretty, minimal and fast ZSH prompt `npm install --global pure-prompt`
* [Theme](~/.oh-my-zsh/themes)
  - agnoster
  - cloud
  - wedisagree
  - ambda-mod
  - [powerlevel10k](https://github.com/romkatv/powerlevel10k) `git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k`
  - [spaceship-prompt](https://github.com/denysdovhan/spaceship-prompt):🚀⭐️ A Zsh prompt for Astronauts <https://denysdovhan.com/spaceship-prompt/>
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
  - [awesome-zsh-plugins](https://github.com/unixorn/awesome-zsh-plugins):A collection of ZSH frameworks, plugins & themes inspired by the various awesome list collections out there.
* 优化
  - 禁用多余插件
  - 避免产生子进程:常见的会产生子进程的语法有是 eval 和 Command substitution，在编写 .zshrc 时应该尽量避免使用它们
  - 启用 ZSH_DISABLE_COMPFIX
* macOS
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

The user-friendly command line shell. <http://fishshell.com>

* 彩色显示
* 有效路径为下划线
* 光标会给提示:→(选中) 只采纳一部分，可以按下(Alt + →)
* 补全存在的历史记录或猜测可能性(tab选择)
* [fisherman/fisherman](https://github.com/fisherman/fisherman):The fish-shell plugin manager.
* <https://wiki.archlinux.org/index.php/Fish>

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

## [bats-core](https://github.com/bats-core/bats-core)

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

## [bat](https://github.com/sharkdp/bat)

A cat(1) clone with wings

```sh
wget https://github.com/sharkdp/bat/releases/download/v0.15.4/bat_0.15.4_amd64.deb

brew install bat
```

## snieept

```sh
history | awk '{$1="";print substr($0,2)}' | sort | uniq -c | sort -n | tail -n 10
```

## Termial

* [ish](https://github.com/ish-app/ish):Linux shell for iOS <https://ish.app>
- [iTerm2-Color-Schemes](https://github.com/mbadolato/iTerm2-Color-Schemes):Over 200 terminal color schemes/themes for iTerm/iTerm2. Includes ports to Terminal, Konsole, PuTTY, Xresources, XRDB, Remmina, Termite, XFCE, Tilda, FreeBSD VT, Terminator, Kitty, MobaXterm, LXTerminal, Microsoft's Windows Terminal, Visual Studio <http://www.iterm2colorschemes.com>
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
  + [Babun](http://babun.github.io/):a Windows shell you will love!
  + [nushell](https://github.com/nushell/nushell): A new type of shell www.nushell.sh/ `cargo install nu --features=stable`
    * The goal of this project is to take the Unix philosophy of shells, where pipes connect simple commands together, and bring it to the modern style of development
* [Hyper](https://github.com/zeit/hyper):A terminal built on web technologies create a beautiful and extensible experience for command-line interface users, built on open web standards <https://hyper.is>
* [mosh](https://mosh.org/)：基于UDP的终端连接，可以替代ssh，连接更稳定，即使IP变了，也能自动重连
* [PowerShell](https://github.com/PowerShell/PowerShell):PowerShell for every system! <https://microsoft.com/PowerShell>
* [terminus](https://github.com/Eugeny/terminus):A terminal for a more modern age <https://eugeny.github.io/terminus/>
* [msys2](http://www.msys2.org/)
* powercmd
* [alacritty](https://github.com/alacritty/alacritty):A cross-platform, GPU-accelerated terminal emulator
* [scoop](https://github.com/lukesampson/scoop):A command-line installer for Windows. <https://scoop.sh>
* [upterm](https://github.com/railsware/upterm):A terminal emulator for the 21st century.

## 教程

* [command-line-text-processing](https://github.com/learnbyexample/Command-line-text-processing):⚡️ From finding text to search and replace, from sorting to beautifying text and more 🎨
* [Linux_command_line](https://github.com/learnbyexample/Linux_command_line):💻 Introduction to Linux commands and Shell scripting
* [scripting_course](https://github.com/learnbyexample/scripting_course):📓 A reference guide to Linux command line, Vim and Scripting <https://learnbyexample.github.io/scripting_course/>
* [Introduction to text manipulation on UNIX-based systems](https://www.ibm.com/developerworks/aix/library/au-unixtext/index.html)
* [linuxcommand](http://linuxcommand.org)
* [Advanced Bash-Scripting Guide](http://tldp.org/LDP/abs/html/index.html)
* [pure-bash-bible](https://github.com/dylanaraps/pure-bash-bible):book A collection of pure bash alternatives to external processes.
* [bash-guide](https://github.com/Idnan/bash-guide):A guide to learn bash
* [Bash 脚本教程](https://wangdoc.com/bash) <https://github.com/wangdoc/bash-tutorial>
* [learning_the_shell](https://linuxcommand.org/lc3_learning_the_shell.php)

```sh
axel -n 20 http://centos.ustc.edu.cn/centos/7/isos/x86_64/CentOS-7-x86_64-Minimal-1511.iso
ccache gcc foo.c
```

## 图书

* 《Linux Shell脚本攻略》
* 《Shell脚本学习指南》
* [The Linux Command Line](http://linuxcommand.org/tlcl.php): William Shotts关于Linux命令行的一本书
* Linux命令行与shell脚本编程大全（第3版）
  - [shell](https://github.com/fengyuhetao/shell):Linux命令行与shell脚本编程大全案例

## 工具

* [edex-ui](https://github.com/GitSquared/edex-ui):A cross-platform, customizable science fiction terminal emulator with advanced monitoring & touchscreen support.
* help
  - [explainshell](https://github.com/idank/explainshell):match command-line arguments to their help text
  - [tldr](https://github.com/tldr-pages/tldr): books Simplified and community-driven man pages <http://tldr-pages.github.io/> `npm install -g tldr`
  - [linux-command](https://github.com/jaywcjlove/linux-command):Linux命令大全搜索工具，内容包含Linux命令手册、详解、学习、搜集。<https://git.io/linux> <https://git.io/linux>
  - cheat
* [lynx](link):终端构建的Web浏览应用程序
* cd
  - [fasd](https://github.com/clvv/fasd) 增强cd命令
  - [ranger](https://github.com/ranger/ranger) 在多目录上浏览各种文件 比 cd 和 cat 更有效率，甚至可以在终端预览图片
* [exa](https://github.com/ogham/exa):A modern version of ‘ls’. <https://the.exa.website/>
* [prettyping](https://github.com/denilsonsa/prettyping) 图示化的ping
* du
  - [ncdu](https;//dev.yorhel.nl/ncdu)
  - [nnn](https://github.com/jarun/nnn)
* [asciinema](https://asciinema.org/)和 [svg-trem](https://github.com/marionebl/svg-term-cli) 如果想把的命令行操作建录制成一个 SVG 动图
* [Taskbook](https://github.com/klaussinani/taskbook) 可以完全在命令行中使用的任务管理器 ，支持 ToDo 管理，还可以为每个任务加上优先级
* [sshrc](https://github.com/Russell91/sshrc ) 在登录远程服务器的时候也能使用本机的 shell 的 rc 文件中的配置
* monitor
  - top:查看在系统中运行的进程或线程,默认是以 CPU 进行排序
  - [sampler](https://github.com/sqshq/sampler):Tool for shell commands execution, visualization and alerting. Configured with a simple YAML file. <https://sampler.dev>
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
  - traceroute 一个内置工具，能显示路由和测量数据包在网络中的延迟,数据包在IP网络经过的路由器的IP地址
  - [IPTState](http://www.phildev.net/iptstate/index.shtml) 可以让你观察流量是如何通过 iptables，并通过你指定的条件来进行排序。该工具还允许你从 iptables 的表中删除状态信息。
  - [darkstat](https://unix4lyfe.org/darkstat/) 能捕获网络流量并计算使用情况的统计数据。该报告保存在一个简单的 HTTP 服务器中，它为你提供了一个非常棒的图形用户界面。
  - [vnStat]( http://humdi.net/vnstat/) 是一个网络流量监控工具，它的数据统计是由内核进行提供的，其消耗的系统资源非常少。系统重新启动后，它收集的数据仍然存在。有艺术感的系统管理员可以使用它的颜色选项
  - netstat 是一个内置的工具，显示 TCP 网络连接，路由表和网络接口数量，被用来在网络中查找问题
  - ss:iproute2 包附带的另一个工具，允许查询 socket 的有关统计信息,显示的信息比 netstat 更多，也更快。如果想查看统计结果的总信息，你可以使用命令 ss -s
  - [Nmap](http://nmap.org/) 可以扫描你服务器开放的端口并且可以检测正在使用哪个操作系统。但你也可以将其用于 SQL 注入漏洞、网络发现和渗透测试相关的其他用途。
  - [MTR](http://www.bitwizard.nl/mtr/) 将 traceroute 和 ping 的功能结合到了一个网络诊断工具上。当使用该工具时，它会限制单个数据包的跳数，然后监视它们的到期时到达的位置。然后每秒进行重复。
  - [Justniffer](http://justniffer.sourceforge.net/) 是 tcp 数据包嗅探器。使用此嗅探器你可以选择收集低级别的数据还是高级别的数据。它也可以让你以自定义方式生成日志。比如模仿 Apache 的访问日志。
* [hexyl](https://github.com/sharkdp/hexyl):A command-line hex viewer
* prompt
  - [powerline-shell](https://github.com/b-ryan/powerline-shell):A beautiful and useful prompt for your shell
    + pre-patched and adjusted fonts for usage with the Powerline statusline plugin `sudo apt-get install fonts-powerline`
    + Powerline a statusline plugin for vim, and provides statuslines and prompts for several other applications `pip install powerline-status`
* mycli：mysql客户端，支持语法高亮和命令补全，效果类似ipython，可以替代mysql命令
* json
  - jq: json文件处理以及格式化显示，支持高亮，可以替换python -m json.tool
* 代码统计
  - cloc：代码统计工具，能够统计代码的空行数、注释行、编程语言
* [hyperfine](https://github.com/sharkdp/hyperfine):A command-line benchmarking tool
* [genact](https://github.com/svenstaro/genact):🌀 A nonsense activity generator <https://svenstaro.github.io/genact/>
* [cross-env](https://github.com/kentcdodds/cross-env):🔀 Cross platform setting of environment scripts <https://www.npmjs.com/package/cross-env>
* [cool-retro-term](https://github.com/Swordfish90/cool-retro-term):A good looking terminal emulator which mimics the old cathode display...
* [thefuck](https://github.com/nvbn/thefuck):Magnificent app which corrects your previous console command.
* [carbon-now-cli](https://github.com/mixn/carbon-now-cli):🎨 Beautiful images of your code — from right inside your terminal.
* [terminalizer](https://github.com/faressoft/terminalizer):🦄 Record your terminal and generate animated gif images
* [rat](https://github.com/ericfreese/rat):Compose shell commands to build interactive terminal applications
* [kitty](https://github.com/kovidgoyal/kitty):A cross-platform, fast, feature full, GPU based terminal emulator
* [explainshell](https://github.com/idank/explainshell):match command-line arguments to their help text [explainshell](https://explainshell.com)
* [fkill-cli](https://github.com/sindresorhus/fkill-cli):Fabulously kill processes. Cross-platform.
* [colorama](https://github.com/tartley/colorama):Simple cross-platform colored terminal text in Python
* [fff](https://github.com/dylanaraps/fff):🚀 fucking fast file-manager
* [amp](https://github.com/jmacdonald/amp):A complete text editor for your terminal. <https://amp.rs>
* [aminal](https://github.com/liamg/aminal):Golang terminal emulator from scratch
* [s-tui](https://github.com/amanusk/s-tui):Terminal based CPU stress and monitoring utility <https://amanusk.github.io/s-tui/>
* [z](https://github.com/rupa/z):z - jump around
* [shellcheck](https://github.com/koalaman/shellcheck)：ShellCheck, a static analysis tool for shell scripts <https://www.shellcheck.net>
* yapf：Google开发的python代码格式规范化工具，支持pep8以及Google代码风格
* PathPicker(fpp):在命令行输出中自动识别目录和文件，支持交互式，配合git非常有用
* sz/rz：交互式文件传输，在多重跳板机下传输文件非常好用，不用一级一级传输
* script/scriptreplay: 终端会话录制
* 配置
  - [direnv](https://github.com/direnv/direnv):Unclutter your .profile <http://direnv.net>

## snippets

* [Bash-Snippets](https://github.com/alexanderepstein/Bash-Snippets):A collection of small bash scripts for heavy terminal users

## 参考

* [awesome-shell](https://github.com/alebcay/awesome-shell)：A curated list of awesome command-line frameworks, toolkits, guides and gizmos. Inspired by awesome-php.
* [awesome-bash](https://github.com/awesome-lists/awesome-bash)
* [Google’s Shell Style Guide](https://google.github.io/styleguide/shell.xml)
* [the-art-of-command-line](https://github.com/jlevy/the-art-of-command-line):Master the command line, in one page
* https://www.shellscript.sh/

* [across](https://github.com/teddysun/across)
* 脚本参考
  - <http://www.bashoneliners.com/>
  - <http://www.shell-fu.org/>
  - <http://www.commandlinefu.com/>
  - <http://www.shelldorado.com/scripts/>
  - <https://snippets.siftie.com/public/tag/bash/>
  - <https://bash.cyberciti.biz/>
  - <https://github.com/miguelgfierro/scripts>
  - <https://github.com/epety/100-shell-script-examples>
  - <https://github.com/ruanyf/simple-bash-scripts>
  - 和shell有关的索引资源
    + <https://terminalsare.sexy/>
