# [php/php-src](https://github.com/php/php-src)

The PHP Interpreter <http://www.php.net>

* 一门弱类型的语言，变量在声明的那一刻不需要确定它的类型，而在运行时类型也会发生显式或隐式的类型改变
* PHP(Hypertext Preprocessor)
* PHP是一种解释型语言，即不需要编译。构建在Zend 虚拟机之上
* PHP是一种服务器端脚本语言，结果以纯 HTML 形式返回给浏览器
* PHP比其他脚本语言更快,如：Python和asp。
* HTTP协议在Nginx等服务器的解析下,传送给相应的Handler（PHP等）来处理。后端渲染，默认html处理，模版文件以.php后缀
* 服务端脚本程序，只能通过服务器访问，需要配置虚拟主机调试

## 发展

* [PSR](http://www.php-fig.org/)组织制定的PHP语言开发规范，约定了很多方面的规则，如命名空间、类名 规范、编码风格标准、Autoload、公共接口等
* Swoole:Swoole 是一个异步并行的通信引擎，作为 PHP 的扩展来运行。Node.js 的异步回调 Swoole 有，Go语言的协程 Swoole 也有，这完全颠覆了对 PHP 的认知.使用 Swoole PHP 可以实现常驻内存的 Server 程序，可以实现 TCP 、 UDP 异步网络通信的编程开发。比如 WebSocket 即使通信、聊天、推送服务器、RPC 远程调用服务、网关、代理、游戏服务器等。
* Phar:PHP5.3 之后支持了类似 Java 的 jar 包，名为 phar。用来将多个 PHP 文件打包为一个文件。这个特性使得 PHP 也可以像 Java 一样方便地实现应用程序打包和组件化。一个应用程序可以打成一个 Phar 包，直接放到 PHP-FPM 中运行。配合 Swoole ，可以在命令行下执行 php server.phar 一键启动服务器。PHP 的代码包可以用 Phar 打包成组件，放到 Swoole 的服务器容器中去加载执行。
* PHP 作为一门动态脚本语言，优点是开发方便效率高。缺点就是性能差。在密集运算的场景下比 C 、 C++ 相差几十倍甚至上百倍。另外 PHP 不可以直接操作底层，需要依赖扩展库来提供 API 实现。PHP 程序员可以学习一门静态编译语言作为补充实现动静互补，C/C++/Go 都是不错的选择。而且静态语言的编程体验与动态语言完全不同，学习过程可以让你得到更大的提升。 掌握 C/C++ 语言后，还可以阅读 PHP 、 Swoole 、 Nginx 、Redis 、 Linux内核 等开源软件的源码，了解其底层运行原理。 现在最新版本的Swoole提供了C++扩展模块的支持，封装了Zend API，用C++操作PHP变得很简单，可以用C++实现PHP扩展函数和类。
* PHP
    * 7.1 :2015.12.3 性能提升
    * 7.2 JIT(JUST_IN_TIME)
    * 8:实现了一个虚拟机 Zend VM，将可读脚本编译成虚拟机理解的指令，也就是操作码，这个执行阶段就是“编译时（Compile Time）”；在“运行时（Runtime）”执行阶段，虚拟机 Zend VM 会执行这些编译好的操作码

## 原理

* Zend 引擎:PHP4 以后加入 PHP 的，是对原有PHP解释器的重写，整体使用 C 语言进行开发，也就是说可以把PHP理解成用C写的一个编程语言软件，引擎的作用是将PHP代码翻译为一种叫opcode的中间语言，它类似于JAVA的ByteCode（字节码）。引擎对PHP代码会执行四个步骤：
    - 词法分析 Scanning（Lexing），将 PHP 代码转换为语言片段（Tokens）。
    - 解析 Parsing， 将 Tokens 转换成简单而有意义的表达式。
    - 编译 Compilation，将表达式编译成Opcode。
    - 执行 Execution，顺序执行Opcode，每次一条，以实现PHP代码所表达的功能。
    - APC、Opchche 这些扩展可以将Opcode缓存以加速PHP应用的运行速度，使用它们就可以在请求再次来临时省略前三步。
    - 引擎也实现了基本的数据结构、内存分配及管理，提供了相应的API方法供外部调用。
* 由虚拟机来执行这些OPCODE
* Extensions 扩展:常见的内置函数、标准库都是通过extension来实现的，这些叫做PHP的核心扩展，用户也可以根据自己的要求安装PHP的扩展。
* SAPI(Server Application Programming Interface)中文为服务端应用编程接口，它通过一系列钩子函数使得PHP可以和外围交换数据，SAPI 就是 PHP 和外部环境的代理器，它把外部环境抽象后，为内部的PHP提供一套固定的，统一的接口，使得 PHP 自身实现能够不受错综复杂的外部环境影响，保持一定的独立性。通过 SAPI 的解耦，PHP 可以不再考虑如何针对不同应用进行兼容，而应用本身也可以针对自己的特点实现不同的处理方式。
* 上层应用:程序员编写的PHP程序，无论是 Web 应用还是 Cli 方式运行的应用都是上层应用，PHP 程序员主要工作就是编写它们

![PHP 的架构](../../_static/php_construct.jpg "Optional title")

## 安装

* 程序路径：`/usr/local/Cellar/php71/7.1.12_23`
* 配置文件: `/usr/local/etc/php/7.1/` The php.ini and php-fpm.ini file
* /usr/local/opt/php71/sbin/php-fpm --nodaemonize --fpm-config /usr/local/etc/php/7.1/php-fpm.conf :nginx 通过php-fpm进程运行
* php71卸载后php-fpm仍然运行
* phpize pecl 需要php7.*-dev 支持

```sh
/usr/local/apache2/bin/apachectl start/stop   service httpd restart

LoadModule php5_module modules/libphp5.so # httpd.conf中添加

cgi.fix_pathinfo 设置为 0  #  php.ini 文件中的配置项  如果文件不存在，则阻止 Nginx 将请求发送到后端的 PHP-FPM 模块， 以避免遭受恶意脚本注入的攻击
# 确保 php-fpm 模块使用 www-data 用户和 www-data 用户组的身份运行
# This is an extremely insecure setting because it tells PHP to attempt to execute the closest file it can find if a PHP file does not match exactly. This basically would allow users to craft PHP requests in a way that would allow them to execute scripts that they shouldn't be allowed to execute.

### windows 下载PHP安装包，解压即可
./php.exe -f e:\www\test.php # 不一定非php扩展名文件
php.exe -v
php.exe -i # 运行phpinfo()函数

php.exe -m # 显示已经加载了那些module
php -a # 进入命令行模式

### Mac
brew install --without-apache --with-fpm php

/usr/local/Cellar/php/7.2.9_2/bin/pear config-set php_ini /usr/local/etc/php
/usr/local/Cellar/php/7.2.9_2/bin/pear config-set php_dir /usr/local/share/p
/usr/local/Cellar/php/7.2.9_2/bin/pear config-set doc_dir /usr/local/share/p
/usr/local/Cellar/php/7.2.9_2/bin/pear config-set ext_dir /usr/local/lib/php
/usr/local/Cellar/php/7.2.9_2/bin/pear config-set bin_dir /usr/local/opt/php
/usr/local/Cellar/php/7.2.9_2/bin/pear config-set data_dir /usr/local/share/
/usr/local/Cellar/php/7.2.9_2/bin/pear config-set cfg_dir /usr/local/share/p
/usr/local/Cellar/php/7.2.9_2/bin/pear config-set www_dir /usr/local/share/p
/usr/local/Cellar/php/7.2.9_2/bin/pear config-set man_dir /usr/local/share/m
/usr/local/Cellar/php/7.2.9_2/bin/pear config-set test_dir /usr/local/share/
/usr/local/Cellar/php/7.2.9_2/bin/pear config-set php_bin /usr/local/opt/php
/usr/local/Cellar/php/7.2.9_2/bin/pear update-channels

## 配置文件添加扩展
include=/usr/local/etc/php/7.1/conf.d/*.ini

mkdir -p ~/Library/LaunchAgents
cp /usr/local/opt/php71/homebrew.mxcl.php71.plist ~/Library/LaunchAgents/
launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.php71.plist

sudo brew services start/stop/restart php71

PHP Startup: Unable to load dynamic library # 扩展重复加载

php -i | grep php.ini
php -m

# 默认php-cli为/usr/bin/php，提升优先级
echo 'export PATH="/usr/local/opt/php@7.1/bin:$PATH"' >> ~/.zshrc
echo 'export PATH="/usr/local/opt/php@7.1/sbin:$PATH"' >> ~/.zshrc

### linux源码安装
lsb_release -a # 系统环境查看

cd /etc/httpd/
vim httpd.conf
AddType application/x-httpd-php .php
AddType application/x-httpd-source .phps

cd /usr/local/php/etc/
vim php.ini
date.timezone = Asia/Shanghai

brew install brew-php-switcher
brew-php-switcher 5.6

# virtual memory exhausted: Cannot allocate memory
# 编译调整虚拟机内存大小

## ubuntu 安装
apt-get update && apt-get upgrade
apt-get install software-properties-common
sudo add-apt-repository ppa:ondrej/php
apt-get install php
```

* [philcook/brew-php-switcher](https://github.com/philcook/brew-php-switcher):Brew PHP switcher is a simple shell script to switch your apache and CLI quickly between major versions of PHP. If you support multiple products/projects that are built using either brand new or old legacy PHP functionality. For users of Homebrew (or brew for short) currently only.

### 扩展安装

* 使用apt或者yum命令安装
* 使用pecl安装

```
php -m # 查看添加扩展
php --ini　＃　查找PHP CLI的ini文件位置

ln -s /etc/php5/mods-available/redis.ini /etc/php5/cli/conf.d/10-redis.ini
ln -s /etc/php5/mods-available/redis.ini /etc/php5/apache2/conf.d/10-redis.ini

apt-cache search memcached
apt-get install -y php5-memcached

pecl install memcached
```

### Cli

* 用多进程, 子进程结束以后, 内核会负责回收资源
* 使用多进程,子进程异常退出不会导致整个进程Thread退出. 父进程还有机会重建流程.
* 一个常驻主进程, 只负责任务分发, 逻辑更清楚.
* 完全支持多线程
* 如上，可以实现定时任务
* 开发桌面应用就是使用PHP-CLI和GTK包
* linux下用php编写shell脚本
* [ircmaxell/phpvm](https://github.com/ircmaxell/phpvm):A PHP version manager for CLI PHP

与PHP不同的配置文件
由webserver使用的php.ini文件，会配置比较短的max_execution_time，而在命令行中的php.ini文件，会配置比较长的max_execution_time。

```php
php --ini
php -r "echo php_sapi_name();" // 判断当前执行的php是什么模式下 R RUN
php -f /path/to/yourfile.php # 调用PHP CLI解释器，并给脚本传递参数。这种方法首先要设置php解释器的路径，Windows平台在运行CLI之前，需设置类似path c:\php的命令，也失去了CLI脚本第一行的意义，因此不建议使用该方法。

第二种方法是首先运行chmod+x <要运行的脚本文件名>（UNIX/Linux环境），将该PHP文件置为可执行权限，然后在CLI脚本头部第一行加入声明（类似于#! /usr/bin/php或PHP CLI解释器位置），接着在命令行直接执行。这是CLI首选方法，建议采用
```

### [PECL](http://pecl.php.net/)：

PHP Extension Community Library，管理着最底层的PHP扩展。用 C 写的

* [PEAR](http://pear.php.net/)：PHP Extension and Application Repository，管理着项目环境的扩展。用 PHP 写的
    - 编译好的依赖：/usr/lib/php
* Composer：和PEAR都管理着项目环境的依赖，这些依赖也是用 PHP 写的，区别不大。但 composer 却比 PEAR 来的更受欢迎

```sh
phpize -v

sudo apt-get install php-xml php7.3-xml php-dev php7.3-dev
sudo apt install php-pear

wget http://pear.php.net/go-pear.phar
php go-pear.phar


# 修改bin路径
pear version
sudo apt install php7.3-dev # to use phpize  生成编译检测脚本

pecl channel-update pecl.php.net

HP Warning:  PHP Startup: redis: Unable to initialize module
Module compiled with module API=20170718
PHP    compiled with module API=20180731

pear.php.net is using a unsupported protocol - This should never happen.

pear update-channels
pecl update-channels
pear upgrade
pecl upgrade

Setting up php7.3-fpm (7.3.5-1+ubuntu18.04.1+deb.sury.org+1) ...
Error: The new file /usr/lib/php/7.3/php.ini-production does not exist!
dpkg: error processing package php7.3-fpm (--configure):
 installed php7.3-fpm package post-installation script subprocess returned error exit status 1
Errors were encountered while processing:
 php7.3-fpm
```

## 配置

* memory_limit:设定单个 PHP 进程可以使用的系统内存最大值，从系统可用性上来讲建议越大越好
    - PHP 操作 Redis Set 集合。修改配置
    - 如果您的项目中每页页面使用的内存不大，建议改成小一些，这样可以承载更多的并发处理。
    - PHP 脚本中调用 memory_get_peak_usage()函数多次测试自己项目脚本
* Zend OPcache 扩展
    - PHP解释器在执行PHP脚本时会解析PHP脚本代码，把PHP代码编译成一系列Zend操作码(http://php.net/manual/zh/internals2.opcodes.php)，由于每个操作码都是一个字节长，所以又叫字节码，字节码可以直接被Zend虚拟机执行），然后执行字节码。
    - 每次请求PHP文件都是这样，这会消耗很多资源，如果每次HTTP请求都必须不断解析、编译和执行PHP脚本，消耗的资源更多。
    - 如果PHP源码不变，相应的字节码也不会变化，显然没有必要每次都重新生成Opcode，结合在Web应用中无处不在的缓存机制，我们可以把首次生成的Opcode缓存起来,直接从内存中读取预先编译好的字节码
    - 在配置中开启扩展
* max_execution_time 用于设置单个 PHP 进程在终止之前最长可运行时间
* Session 会话放在 Redis 或者 Memcached 中，这么做不仅可以减少磁盘的 IO 操作频率，还可以方便业务服务器伸缩。如果想把会话数据保存在 Memcached 中，需要做如下配置：
* error_reporting

```
# 查看配置
php-config

session.save_handler = 'memcached'
session.save_path = '127.0.0.1:11211'

expose_php = Off # X-Powered-By的配置

# 找到PHP扩展所在目录
php-config --extension-dir

opcache.enable=1 # 开关打开
opcache.validate_timestamps=1    # 生产环境中配置为0：因为Zend Opcache将不能觉察PHP脚本的变化，必须手动清空Zend OPcache缓存的字节码，才能让它发现PHP文件的变动。这个配置适合在生产环境中设置为0，但在开发环境设置为1
opcache.revalidate_freq=240   # 检查脚本时间戳是否有更新时间
opcache.memory_consumption=64    # Opcache的共享内存大小，以M为单位
opcache.interned_strings_buffer=16    # 用来存储临时字符串的内存大小，以M为单位
opcache.max_accelerated_files=4000    # Opcache哈希表可以存储的脚本文件数量上限 对多缓存文件限制, 命中率不到 100% 的话, 可以试着提高这个值
opcache.fast_shutdown=1         # 使用快速停止续发事件

php -r "echo ini_get('memory_limit').PHP_EOL;" # 获取php内存大小
```

## 语法

### 基础

* PHP代码的标记：<?php …… ?>
* PHP文件的扩展名：.php
* PHP中每行程序代码，必须以英文下的分号(;)结束。
* PHP程序区分大小写的，但函数名和关键字不区分大小写。如：if、break、switch
* 访问PHP文件，必须要经过服务器，或者以域名开头来访问。如：http://www.2015.com/test.php
* PHP文件及路径上不能包括中文或空格。
* 单行注释：//、#
* 多行注释：/* …… */
* 变量：临时存储数据的容器，指向值的指针。保存数据内存位置的名称。 变量是用于保存临时数据的临时存储
    - 作用域：变量范围
        + 包含了 include 和 require 引入的文件
        + 局部变量local：函数内部声明的变量，仅能在函数内部访问
        + 全局作用域global：在所有函数外部定义的变量
            + 除了函数外，全局变量可以被脚本中的任何部分访问
            + 要在一个函数中访问一个全局变量，需要使用 global 关键字。
            + 所有全局变量存储在一个名为 $GLOBALS[index] 的数组中。index 保存变量的名称。这个数组可以在函数内部访问，也可以直接用来更新全局变量。
        + 静态变量（static variable）：仅在局部函数域中存在，但当程序执行离开此作用域时，其值并不丢失
        + parameter：通过调用代码将值传递给函数的局部变量
    - 变量本身没有类型之说，所说的类型是指变量中存储的数据的类型。
    - 变量的名称，可以包含：字母、数字、下划线，可以用中文。
    - 变量的名称，不能以数字和特殊符号开头，但可以以字母或下划线开头。如：$_ABC、$abc
    - 变量名称前必须要带“$”符号。“$”不是变量名称一部分，它只是对变量名称的一个引用或标识符。
    - 变量名称区分大小写。如：$name和$Name是两个变量
    - 对于由几个单词构成的变量名称的命名规则
        + “驼峰式”命名：$getUserName、$getUserPwd
        + “下划线”命名：$get_user_name、$set_user_pwd
    - 赋值
        - 传值赋值:$variablename指向value存储的地址
        - 引用赋值:新的变量简单的引用了原始变量,只有有名字的变量才可以引用赋值:$foo = 'Bob'; $bar = &$foo;
    - 可变变量：`$$var`是一个引用变量，用于存储$var的值
* PHP 之外的变量
    - `$_GET $_POST $_REQUEST`
    - `$_SERVER`
    - `$_COOKIE`
* 常量
    - 定义
        + 常量前面没有美元符号（$）；
        + 常量只能用 define() 函数定义，而不能通过赋值语句；
        + 常量可以不用理会变量的作用域而在任何地方定义和访问；
        + 常量一旦定义就不能被重新定义或者取消定义；
        + 常量的值只能是标量, PHP 7 中还允许是个 array
    - define()函数：define(name, value, case-insensitive = false) 区分大小写,成功时返回 TRUE， 或者在失败时返回 FALSE
    - defined — 检查某个名称的常量是否存在
    - const关键字在编译时定义常量。 它是一个语言构造不是一个函数。比define()快一点，因为它没有返回值。它总是区分大小写的
    - 魔术常量
        + `__LINE__`  表示使用当前行号。
        + `__FILE__`    表示文件的完整路径和文件名。 如果它在include中使用，则返回包含文件的名称。
        + `__DIR__`表示文件的完整目录路径。 等同于dirname(__file__)。 除非它是根目录，否则它没有尾部斜杠。 它还解析符号链接。
        + `__FUNCTION__`    表示使用它的函数名称。如果它在任何函数之外使用，则它将返回空白。
        + `__CLASS__`   表示使用它的函数名称。如果它在任何函数之外使用，则它将返回空白。
        + `__TRAIT__`   表示使用它的特征名称。 如果它在任何函数之外使用，则它将返回空白。 它包括它被声明的命名空间。
        + `__METHOD__`  表示使用它的类方法的名称。方法名称在有声明时返回。
        + `__NAMESPACE__`   表示当前命名空间的名称。

```php
# 变量
$variablename = value;

$x=5;
$y=10;
function myTest()
{
    global $x,$y;
    $y=$x+$y;
}
myTest();
echo $y; // 输出 15

function myTest()
{
    static $x=0;
    echo $x;
    $x++;
}
myTest(); // 0
myTest(); // 1
myTest(); // 2

function myTest($x)
{
    echo $x;
}
myTest(5);
function test()
{
    static $a = 0;
    echo $a;
    $a++;
}

# 常量
define("MESSAGE", "Hello YiiBai PHP");
const MESSAGE = "Hello const by YiiBai PHP";

require('./ShopProduct.php'); # 加载文件名称
```

### 数据类型

* 标量类型
    + Boolean（布尔型）
        + 布尔值 FALSE 本身
        + 整型值 0（零）
        + 浮点型值 0.0（零）
        + 空字符串，以及字符串 "0"
        + 不包括任何元素的数组
        + 从空标记生成的 SimpleXML 对象
    + String（字符串）
        * 单引号PHP字符串中，大多数转义序列和变量不会被解释。 可以使用单引号\'反斜杠和通过\\在单引号引用PHP字符串。
        * 双引号的PHP字符串中存储多行文本，特殊字符和转义序列,对一些特殊的字符进行解析
            * \n  换行（ASCII 字符集中的 LF 或 0x0A (10)）
            * \r  回车（ASCII 字符集中的 CR 或 0x0D (13)）
            * \t  水平制表符（ASCII 字符集中的 HT 或 0x09 (9)）
            * \v  垂直制表符（ASCII 字符集中的 VT 或 0x0B (11)）（自 PHP 5.2.5 起）
            * \e  Escape（ASCII 字符集中的 ESC 或 0x1B (27)）（自 PHP 5.4.0 起）
            * \f  换页（ASCII 字符集中的 FF 或 0x0C (12)）（自 PHP 5.2.5 起）
            * \\  反斜线
            * \$  美元标记
            * \"  双引号
        + heredoc 结构就象是没有使用双引号的双引号字符串，这就是说在 heredoc 结构中单引号不用被转义，但是上文中列出的转义序列还可以使用
        + Nowdoc 结构是类似于单引号字符串的。Nowdoc 结构很象 heredoc 结构，但是 nowdoc 中不进行解析操作。这种结构很适合用于嵌入 PHP 代码或其它大段文本而无需对其中的特殊字符进行转义
        * addslashes函数转义风险：对于URL参数arg = %df\'在经过addslashes转义后在GBK编码下arg = 運'
        * urldecode函数解码风险：对于URL参数uid = 1%2527在调用urldecode函数解码(二次解码)后将变成uid = 1'
    + Integer（整型）
    + Float（浮点型）
        * NaN:代表着任何不同值，不应拿 NAN 去和其它值进行比较，包括其自身，应该用 is_nan() 来检查
- NULL（空值）
    + 被赋值为 NULL。
    + 尚未被赋值。
    + 被 unset():删除引用，触发相应变量容器refcount减一，但在函数中的行为会依赖于想要销毁的变量的类型而有所不同，比如unset 一个全局变量，则只是局部变量被销毁，而在调用环境中的变量(包括函数参数引用传递的变量)将保持调用 unset 之前一样的值；unset 变量与给变量赋值NULL不同，变量赋值NULL直接对相应变量容器refcount = 0

```php
$a = 1234; // 十进制数
$a = -123; // 负数
$a = 0123; // 八进制数 (等于十进制 83)
$a = 0x1A; // 十六进制数 (等于十进制 26)
$a = 0b11111111; // 二进制数字 (等于十进制 255)

$str='Hello text within single quote';
$str2="Using double \"quote\" with backslash inside double quoted string";
echo 'You can also have embedded newlines in 
strings this way as it is
okay to do';

 $bar = <<<EOT
bar
    EOT;
define('fruit', 'veggie');

$str=strtolower("My name is Yiibai"); # strtoupper
$str=ucwords("My name is Yiibai"); # strtoupper
$str=ucfirst("My name is Yiibai"); # lcfirst
$str=strrev("My name is Yiibai"); # lcfirst

$len=strlen("My name is Yiibai");

$str = preg_replace_callback(
    '/([a-z]*)([A-Z]*)/',
    function($matchs){
        return strtoupper($matchs[1]).strtolower($matchs[2]);
    },
$str
);

substr()
htmlentities(string)
addslashes(str)
html_entity_decode(string)

print # 一个语法结构(language constructs), 他并不是一个函数, 参数的list并不要求有括号
```

#### 复合类型

- Array（数组）:一个有序映射。映射是一种把 values 关联到 keys 的类型。因此可以把它当成真正的数组，或列表（向量），散列表（是映射的一种实现），字典，集合，栈，队列以及更多可能性
    + key 会有如下的强制转换：
        + 包含有合法整型值的字符串会被转换为整型。例如键名 "8" 实际会被储存为 8。但是 "08" 则不会强制转换，因为其不是一个合法的十进制数值。
        + 浮点数也会被转换为整型，意味着其小数部分会被舍去。例如键名 8.7 实际会被储存为 8。
        + 布尔值也会被转换成整型。即键名 true 实际会被储存为 1 而键名 false 会被储存为 0。
        + Null 会被转换为空字符串，即键名 null 实际会被储存为 ""。
        + 数组和对象不能被用为键名。坚持这么做会导致警告：Illegal offset type。
    + 索引数组
    + 关联数组
    + 多维数组
- Object（对象）
- callback:接受用户自定义的回调函数作为参数。回调函数不止可以是简单函数，还可以是对象的方法，包括静态类方法。
* 资源
* 类型转换
    - 乘法运算符"*"。如果任何一个操作数是float，则所有的操作数都被当成float，结果也是float。否则操作数会被解释为integer，结果也是integer。并没有改变这些操作数本身的类型；改变的仅是这些操作数如何被求值以及表达式本身的类型
* 类型判断
    - gettype()
    - empty()
    - is_null()
    - isset()
    - boolean

```php
# array
$season=array("summer","winter","spring","autumn");
$season[0]="summer";
$season[1]="winter";
$season[2]="spring";
$season[3]="autumn";

$salary=array("Hema"=>"350000","John"=>"450000","Kartik"=>"200000");
$salary["Hema"]="350000";
$salary["John"]="450000";
$salary["Kartik"]="200000";

echo count($salary);
foreach($salary as $k => $v) {
    echo "Key: ".$k." Value: ".$v."<br/>";
}

$emp = array
  (
  array(1,"sonoo",400000),
  array(2,"john",450000),
  array(3,"rahul",300000)
  );
for ($row = 0; $row < 3; $row++) {
    for ($col = 0; $col < 3; $col++) {
        echo $emp[$row][$col]."  ";
    }
  echo "<br/>";
}

$salary=array("Maxsu"=>"550000","Vimal"=>"250000","Ratan"=>"200000");
print_r(array_change_key_case($salary,CASE_UPPER)); # Array ( [SONOO] => 550000 [VIMAL] => 250000 [RATAN] => 200000 )
print_r(array_chunk($salary,2, $preserve_keys = false));

$season=array("summer","winter","spring","autumn");

sort($season);
foreach( $season as $s )
{
    echo "$s<br />";
}

$reverseseason=array_reverse($season);
foreach( $reverseseason as $s )
{
  echo "$s<br />";
}

$key=array_search("spring",$season);
echo $key;

$name1=array("maxsu","john","vivek","minsu");
$name2=array("umesh","maxsu","kartik","minsu");
$name3=array_intersect($name1,$name2);
foreach( $name3 as $n )
{
  echo "$n<br />";
}

//示例一：函数内销毁全局变量$foo是无效的
function destroy_foo() {
    global $foo;
    unset($foo);
    echo $foo;//Notice: Undefined variable: foo
}
$foo = 'bar';
destroy_foo();
echo $foo;//bar

//示例二：要在函数中 unset 一个全局变量，应使用 $GLOBALS 数组来实现
function foo()
{
    unset($GLOBALS['bar']);
}
$bar = "something";
foo();
echo $bar;//Notice: Undefined variable: bar

$arr = array(
    array(
        'name'=>'sadas',
        'norder'=>1
    ),
    array(
        'name'=>'sadas',
        'norder'=>11
    ),
    array(
        'name'=>'sadas',
        'norder'=>123
    ),
    array(
        'name'=>'sadas',
        'norder'=>11
    )
);
array_multisort(array_column($arr, 'norder'), SORT_ASC, $arr);

array_map(function($element){return strtotime($element['add_time']);}, $datas);

## 数组合并：
# 索引数组 +会保留第一个值，后面同样值舍弃，merge不会覆盖掉原来的值
# 关联数组：+会保留第一个值，merge会保留保留后者
$arr1 = ['PHP', 'apache'];
$arr2 = ['PHP', 'MySQl', 'HTML', 'CSS'];
$mergeArr = array_merge($arr1, $arr2);
$plusArr = $arr1 + $arr2;
var_dump($mergeArr);
var_dump($plusArr);

$items = array(
    [
        "uid"=>1,
        "pid"=>0,
        "views"=>100
    ],
    [
        "uid"=>2,
        "pid"=>1,
        "views"=>200
    ],
    [
        "uid"=>3,
        "pid"=>0,
        "views"=>300
    ],
    [
        "uid"=>4,
        "pid"=>0,
        "views"=>400
    ],
    [
        "uid"=>5,
        "pid"=>3,
        "views"=>500
    ]
);

array_column($items,'uid'); # [1,2,3,4,5];
array_column($items,'uid','view'); # [100=>1,200=>2,300=>3,400=>4,500=>5];

array_combine();

array_walk(array, funcname)

function my_callback_function() {
    echo 'hello world!';
}

// Type 1: Simple callback
call_user_func('my_callback_function');

$foo = $foo * 1.3;  // $foo 现在是一个浮点数 (2.6)
$foo = 5 * "10 Little Piggies"; // $foo 是整数 (50)
$foo = 5 * "10 Small Pigs";     // $foo 是整数 (50)
```

### 控制语句

* 表达式：任何有值的东西
* echo：是一个语言结构(语句)，不是一个函数，所以不需要使用括号。但是如果要使用多个参数，则需要使用括号。打印字符串，多行字符串，转义字符，变量，数组等。
* print
* printf()
* 条件
    - if
    - if-else
    - elseif/else if
    - 嵌套if
    - switch语句
* 循环
    - for语句
    - foreach循环循环用于遍历数组元素、对象属性
    - while
    - do...while
* break:中断了当前for，while，do-while，switch和for-each循环的执行。 如果在内循环中使用break，它只中断了内循环的执行。接受一个可选的数字参数来决定跳出几重循环
* continue：跳过本次循环中剩余的代码并在条件求值为真时开始执行下一次循环。接受一个可选的数字参数来决定跳过几重循环到循环结尾
* return
* include
    - 被包含文件先按参数给出的路径寻找，
    - 如果没有给出目录（只有文件名）时则按照 include_path 指定的目录寻找。
    - 如果在 include_path 下没找到该文件则 include 最后才在调用脚本文件所在的目录和当前工作目录下寻找。
    - 如果最后仍未找到文件则 include 结构会发出一条警告；
    - include_once 语句在脚本执行期间包含并运行指定文件。此行为和 include 语句类似，唯一区别是如果该文件中已经被包含过，则不会再次包含。如同此语句名字暗示的那样，只会包含一次。
* require 在出错时产生 E_COMPILE_ERROR 级别的错误
    - require_once 语句和 require 语句完全相同，唯一区别是 PHP 会检查该文件是否已经被包含过，如果是则不会再次包含。
* goto:跳转到程序中的另一位置。该目标位置可以用目标名称加上冒号来标记，而跳转指令是 goto 之后接上目标位置的标记
* 替代语法
* 嵌套的使用

```php
#!/usr/bin/env php
print "Hello, Red Hat Developers World from PHP " . PHP_VERSION . "\n";
echo "<h2>Hello First PHP</h2>";
printf('(%1$2d = %1$04b) = (%2$2d = %2$04b)' . ' %3$s (%4$2d = %4$04b)' . "\n", $result, $value, '&', $test);

$num=12;
if ($num % 2 == 0) {
    echo "$num is even number";
} else {
    echo "$num is odd number";
}

if($a > $b):
    echo $a." is greater than ".$b;
elseif($a == $b): // 注意使用了一个单词的 elseif
    echo $a." equals ".$b;
else:
    echo $a." is neither greater than or equal to ".$b;
endif;

switch($num){
    case 10:
        echo("number is equals to 10");
        break;
    case 20:
        echo("number is equal to 20");
        break;
    case 30:
        echo("number is equal to 30");
        break;
    default:
        echo("number is not equal to 10, 20 or 30");
}

for($n=1;$n<=10;$n++){
    echo "$n<br/>";
}

$season=array("summer","winter","spring","autumn");
foreach( $season as $key => $value ){
    echo "Season is: $value<br />";
}

$n=1;
while($n<=10){
    echo "$n<br/>";
    $n++;
}

$n = 1;
do{
    echo "$n<br/>";
    $n++;
}while($n<=10);

<?php
goto a;
echo 'Foo';
 
a:
echo 'Bar';
?>
```

#### 运算符

用于对操作数执行操作

* 算术运算符:`* / % + - **`
* 赋值运算符:`= += -= *= **= /= .= %= &= ^= <<= >>= =>`
* 位运算符：`&(位与) ^（异或） | ~ << >> `
* 比较运算符:`< <= > >= == != === !== <>`
    - $a <=> $b:太空船运算符 当$a小于、等于、大于$b时 分别返回一个小于、等于、大于0的integer 值
    - $a ?? $b ?? $c:NULL 合并操作符  从左往右第一个存在且不为 NULL 的操作数。如果都没有定义且不为 NULL，则返回 NULL
* 逻辑运算符:`&& and ||or xor  !`,有优先级
* 字符串运算符
    - 连接运算符（"."）：返回其左右参数连接后的字符串
    - 连接赋值运算符（".="）：将右边参数附加到左边的参数之后
* 递增/递减运算符
    - ++$a    前加  $a 的值加一，然后返回 $a
    - $a++    后加  返回 $a，然后将 $a 的值加一
    - --$a    前减  $a 的值减一， 然后返回 $a
    - $a--    后减  返回 $a，然后将 $a 的值减一
* 数组运算符
    - $a + $b：相同key保留前面
    - $a == $b： 如果 $a 和 $b 具有相同的键／值对则为 TRUE。
    - $a === $b：如果 $a 和 $b 具有相同的键／值对并且顺序和类型都相同则为 TRUE。
    - $a != $b    不等  如果 $a 不等于 $b 则为 TRUE。
    - $a <> $b    不等  如果 $a 不等于 $b 则为 TRUE。
    - $a !== $b   不全等 如果 $a 不全等于 $b 则为 TRUE。
* 类型运算符:`instanceof (int) (float) (string) (array) (object) (bool)`
* 执行操作符:反引号（``）,尝试将反引号中的内容作为 shell 命令来执行，并将其输出信息返回
    - 激活了安全模式或者关闭了 shell_exec() 时是无效的
* 错误控制操作符:@。当将其放置在一个 PHP 表达式之前，该表达式可能产生的任何错误信息都被忽略掉
* 三元运算符：`$first ? $second : $third`

```php
// 涉及数字比较，优先转化为数字
var_dump('abcd' == 0);
var_dump(0 == 'abcd');
var_dump('0' == 'abcd');

define("READ", 1);
define("WRITE", 2);
define("DELETE", 4);
define("UPDATE", 8);

$permission = READ|WRITE; // 赋予权限 加法
$permission = READ & ~WRITE; // 禁止写权限 反向全量的选法

if( READ & $permission ){ //判断权限
　　echo "ok";
}

E_ALL & ~E_NOTICE # 除了提示级别
E_ALL ^ E_NOTICE #
E_ERROR | E_RECOVERABLE_ERROR # 只显示错误和可恢复

# 异或运算同样的值两次能还原为原理的值
$arr=[6,8];
$arr[0] = $arr[0] ^ $arr[1];
var_dump($arr); # array(2) { [0]=> int(14) [1]=> int(8) }
$arr[1] = $arr[0] ^ $arr[1];
var_dump($arr); # array(2) { [0]=> int(14) [1]=> int(6) }
$arr[0] = $arr[0] ^ $arr[1];
var_dump($arr); # array(2) { [0]=> int(8) [1]=> int(6) }

echo 1 <=> 1; // 0
echo 1 <=> 2; // -1
echo 2 <=> 1; // 1

$my_file = @file ('non_existent_file') or die ("Failed opening file: error was '$php_errormsg'");

$output = `ls -al`;
echo "<pre>$output</pre>";

$a = array("a" => "apple", "b" => "banana");
$b = array("a" => "pear", "b" => "strawberry", "c" => "cherry");
$c = $a + $b; // Union of $a and $b

class MyClass
{
}

$a = new MyClass;
var_dump(!($a instanceof stdClass)); # true
```

#### 杂项

* 数学函数
* 电子邮件

```php
abs(-7)
abs(-7.2)
ceil(-4.8) # -4
floor(-4.8) # -5
sqrt(25)

decbin(10) # 1010
dechex(10) # a
decoct(22) # 26
bindec(1011) # 11
$n1=10;
echo (base_convert($n1,10,2)."<br/>");// 1010

require("menu.html");

ini_set("sendmail_from", "maxsujaiswal@yiibai.com");
$to = "maxsujaiswal1987@gmail.com";//change receiver address
$subject = "This is subject";
$message = "This is simple text message.";
$header = "From:maxsujaiswal@yiibai.com \r\n";

$result = mail ($to,$subject,$message,$header);

if( $result == true ){
  echo "Message sent successfully...";
}else{
  echo "Sorry, unable to send mail...";
}

$to = "abc@example.com";//发送HTML消息
$subject = "This is subject";
$message = "<h1>This is HTML heading</h1>";

$header = "From:xyz@example.com \r\n";
$header .= "MIME-Version: 1.0 \r\n";
$header .= "Content-type: text/html;charset=UTF-8 \r\n";

$result = mail ($to,$subject,$message,$header);

if( $result == true ){
  echo "Message sent successfully...";
}else{
  echo "Sorry, unable to send mail...";
}

$to = "abc@example.com";  # 使用附件发送邮件
$subject = "This is subject";
$message = "This is a text message.";
# Open a file
$file = fopen("/tmp/test.txt", "r" );//change your file location
if( $file == false )
{
 echo "Error in opening file";
 exit();
}
# Read the file into a variable
$size = filesize("/tmp/test.txt");
$content = fread( $file, $size);

# encode the data for safe transit
# and insert \r\n after every 76 chars.
$encoded_content = chunk_split( base64_encode($content));

# Get a random 32 bit number using time() as seed.
$num = md5( time() );

# Define the main headers.
$header = "From:xyz@example.com\r\n";
$header .= "MIME-Version: 1.0\r\n";
$header .= "Content-Type: multipart/mixed; ";
$header .= "boundary=$num\r\n";
$header .= "--$num\r\n";

# Define the message section
$header .= "Content-Type: text/plain\r\n";
$header .= "Content-Transfer-Encoding:8bit\r\n\n";
$header .= "$message\r\n";
$header .= "--$num\r\n";

# Define the attachment section
$header .= "Content-Type:  multipart/mixed; ";
$header .= "name=\"test.txt\"\r\n";
$header .= "Content-Transfer-Encoding:base64\r\n";
$header .= "Content-Disposition:attachment; ";
$header .= "filename=\"test.txt\"\r\n\n";
$header .= "$encoded_content\r\n";
$header .= "--$num--";

# Send email now
$result = mail ( $to, $subject, "", $header );
if( $result == true ){
  echo "Message sent successfully...";
}else{
  echo "Sorry, unable to send mail...";
}
<?
//add() function with two parameter
function add($x,$y)
{
    $sum=$x+$y;
    echo "Sum = $sum <br><br>";
}
//sub() function with two parameter
function sub($x,$y)
{
    $sub=$x-$y;
    echo "Diff = $sub <br><br>";
}
//call function, get  two argument through input box and click on add or sub button
if(isset($_POST['add']))
{
    //call add() function
     add($_POST['first'],$_POST['second']);
}
if(isset($_POST['sub']))
{
    //call add() function
    sub($_POST['first'],$_POST['second']);
}
?>
<form method="post">
    Enter first number: <input type="number" name="first"/><br>
    Enter second number: <input type="number" name="second"/><br>
<input type="submit" name="add" value="ADDITION"/>
<input type="submit" name="sub" value="SUBTRACTION"/>
</form>

string http_build_query ( mixed $query_data [, string $numeric_prefix [, string $arg_separator [, int $enc_type = PHP_QUERY_RFC1738 ]]] )

header('Location:'.$url);  // 跳转页面 Location和":"之间无空格。
header('content-type:text/html;charset=utf-8'); // 声明content-type
header('HTTP/1.1 404 Not Found'); // 返回response状态码
header('Refresh: 10; url=http://www.baidu.com/');  //10s后跳转。

// 控制浏览器缓存
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");
header("Last-Modified: " . gmdate("D, d M Y H:i:s") . "GMT");
header("Cache-Control: no-cache, must-revalidate");
header("Pragma: no-cache");

// 执行http验证
header('HTTP/1.1 401 Unauthorized');
header('WWW-Authenticate: Basic realm="Top Secret"');

// 执行下载操作
header('Content-Type: application/octet-stream'); //设置内容类型
header('Content-Disposition: attachment; filename="example.zip"'); //设置MIME用户作为附件
header('Content-Transfer-Encoding: binary'); //设置传输方式
header('Content-Length: '.filesize('example.zip')); //设置内容长度
```

#### Lambda表达式(匿名函数)与闭包

Lambda表达式(匿名函数)实现了一次执行且无污染的函数定义，是抛弃型函数并且不维护任何类型的状态。闭包在匿名函数的基础上增加了与外部环境的变量交互，通过 use 子句中指定要导入的外部环境变量

```php
function getClosure($n)
{
  $a = 100;
  return function($m) use ($n, &$a) {
        $a += $n + $m;
        echo $a."\n";
    };
}
$fn = getClosure(1);
$fn(1);//102
$fn(2);//105
$fn(3);//109
echo $a;//Notice: Undefined variable

class Dog
{
    private $_name;
    protected $_color;

    public function __construct($name, $color)
    {
         $this->_name = $name;
         $this->_color = $color;
    }

    public function greet($greeting)
    {
         return function() use ($greeting) {
            //类中闭包可通过 $this 变量导入对象
            echo "$greeting, I am a {$this->_color} dog named {$this->_name}.\n";
         };
    }

    public function swim()
     {
         return static function() {
            //类中静态闭包不可通过 $this 变量导入对象，由于无需将对象导入闭包中，
            //因此可以节省大量内存，尤其是在拥有许多不需要此功能的闭包时。
            echo "swimming....\n";
         };
     }

     private function privateMethod()
     {
        echo "You have accessed to {$this->_name}'s privateMethod().\n";
     }

     public function __invoke()
    {
         //此方法允许对象本身被调用为闭包
         echo "I am a dog!\n";
    }
}

$dog = new Dog("Rover","red");
$dog->greet("Hello")();
$dog->swim()();
$dog();
//通过ReflectionClass、ReflectionMethod来动态创建闭包，并实现直接调用非公开方法。
$class = new ReflectionClass('Dog');
$closure = $class->getMethod('privateMethod')->getClosure($dog);
$closure();

$username = $_GET['user'] ?? 'nobody';

$a < $b ($a <=> $b) === -1
$a <= $b    ($a <=> $b) === -1 || ($a <=> $b) === 0
$a == $b    ($a <=> $b) === 0
$a != $b    ($a <=> $b) !== 0
$a >= $b    ($a <=> $b) === 1 || ($a <=> $b) === 0
$a > $b ($a <=> $b) === 1

$bytes = random_bytes(5);
var_dump(bin2hex($bytes));//string(10) "385e33f741"
var_dump(random_int(100, 999));//int(248)
```

### 函数

一段可以重复使用多次的代码。 它可以接受输入作为参数列表和返回值

* 参数
    - 值传递:传递给函数的值默认情况下不会修改实际值(通过值调用),传递给函数的值是通过值调用。作用域函数范围内
    - 引用调用:要传递值作为参考(引用)，您需要在参数名称前使用＆符号(&)
    - 允许使用数组 array 和特殊类型 NULL 作为默认参数
    - 默认参数
    - 可变长度参数函数
* 可变函数：一个变量名后有圆括号，PHP 将寻找与变量的值同名的函数，并且尝试执行它。可变函数可以用来实现包括回调函数
* 匿名函数（Anonymous functions），也叫闭包函数（closures），允许 临时创建一个没有指定名称的函数。最经常用作回调函数（callback）参数的值
    - 从父作用域继承变量:use
* 返回值
* 递归函数

```php
function sayHello(){
    echo "Hello PHP Function";
}
sayHello();//calling function

function sayHello($name,$age = 28){
echo "Hello $name, you are $age years old<br/>";
}
sayHello("Maxsu",27);
sayHello("Henry");

function add_some_extra(&$string)
{
    $string .= 'and something extra.';
}
$str = 'This is a string, ';
add_some_extra($str);
echo $str; # This is a string, and something extra.

function makecoffee($types = array("cappuccino"), $coffeeMaker = NULL)
{
    $device = is_null($coffeeMaker) ? "hands" : $coffeeMaker;
    return "Making a cup of ".join(", ", $types)." with $device.\n";
}
echo makecoffee();
echo makecoffee(array("cappuccino", "lavazza"), "teapot");

function increment($i)
{
    $i++;
}
$i = 10;
increment($i);
echo $i; # 10

function increment(&$i)
{
    $i++;
}
$i = 10;
increment($i);
echo $i;  # 11

function small_numbers()
{
    return array (0, 1, 2);
}
list ($zero, $one, $two) = small_numbers();

function add(...$numbers) {
    $sum = 0;
    foreach ($numbers as $n) {
        $sum += $n;
    }
    return $sum;
}
echo add(1, 2, 3, 4);

function display($number) {
    if($number<=5){
     echo "$number <br/>";
     display($number+1);
    }
}
display(1);

function factorial($n)
{
    if ($n < 0)
        return -1; /*Wrong value*/
    if ($n == 0)
        return 1; /*Terminating condition*/
    return ($n * factorial ($n -1));
}
echo factorial(5);

function foo() {
    echo "In foo()<br />\n";
}

function bar($arg = '') {
    echo "In bar(); argument was '$arg'.<br />\n";
}

// 使用 echo 的包装函数
function echoit($string)
{
    echo $string;
}

$func = 'foo';
$func();        // This calls foo()

$func = 'bar';
$func('test');  // This calls bar()

$func = 'echoit';
$func('test');  // This calls echoit()

echo preg_replace_callback('~-([a-z])~', function ($match) {
    return strtoupper($match[1]);
}, 'hello-world');// 输出 helloWorld
$greet = function($name)
{
    printf("Hello %s\r\n", $name);
};

$greet('World');
$greet('PHP');

$message = 'hello';
$example = function () use ($message) {
    var_dump($message);
};
echo $example();
```

### 状态管理

服务器端存储技术

* cookie是一个小段信息，存储在客户端浏览器中。它可用于识别用户。cookie在服务器端创建并保存到客户端浏览器。 每当客户端向服务器发送请求时，cookie都会嵌入请求。 这样，cookie数据信息可以在服务器端接收。
    - 设置
    - 获取
    - 删除
* session:用于临时存储和从一个页面传递信息到另一个页面(直到用户关闭网站).广泛应用于购物网站，我们需要存储和传递购物车信息。 用户名，产品代码，产品名称，产品价格等信息从一个页面传递到另一个页面。
    - PHP会话为每个浏览器创建唯一的用户ID，以识别用户，并避免多个浏览器之间的冲突。
    - session_start()函数用于启动会话。 它启动一个新的或恢复现有会话。 如果已创建会话，则返回现有会话。 如果会话不可用，它将创建并返回新会话。
    - $_SESSION是一个包含所有会话变量的关联数组。 它用于设置和获取会话变量值。
    - session_destroy()

```php
setcookie("CookieName", "CookieValue");/* defining name and value only*/
setcookie("CookieName", "CookieValue", time()+1*60*60);//using expiry in 1 hour(1*60*60 seconds or 3600 seconds)
setcookie("CookieName", "CookieValue", time()+1*60*60, "/mypath/", "yiibai.com", 1);

$value=$_COOKIE["CookieName"];//returns cookie value

<?php
setcookie("user", "Maxsu");
?>
<?php
if(!isset($_COOKIE["user"])) {
    echo "Sorry, cookie is not found!";
} else {
    echo "<br/>Cookie Value: " . $_COOKIE["user"];
}
?>

# session1.php
<?php
session_start();
?>
<html>
<body>
<?php
$_SESSION["user"] = "Maxsu";
echo "Session information are set successfully.<br/>";
?>
<a href="session2.php">Visit next page</a>
</body>
</html>
# session2.php
<?php
session_start();
?>
<html>
<body>
<?php
echo "User is: ".$_SESSION["user"];
?>
</body>
</html>

<?php
session_start();

if (!isset($_SESSION['counter'])) {
    $_SESSION['counter'] = 1;
} else {
    $_SESSION['counter']++;
}
echo ("Page Views: ".$_SESSION['counter']);
```

### 文件操作

* 创建文件
* 访问一个文件有三种方式
    - 相对文件名形式如foo.txt，它会被解析为 currentdirectory/foo.txt
    - 相对路径名形式如subdirectory/foo.txt。它会被解析为 currentdirectory/subdirectory/foo.txt
    - 绝对路径名形式如/main/foo.txt。它会被解析为/main/foo.txt
* 打开文件：resource fopen ( string $filename , string $mode [, bool $use_include_path = false [, resource $context ]] )函数用于打开文件或URL并返回资源。 fopen()函数接受两个参数$ filename和$mode。 $filename表示要被打开的文件，$mode表示文件模式
    - r 以只读模式打开文件。 它将文件指针放在文件的开头。
    - r+  以读写模式打开文件。 它将文件指针放在文件的开头。
    - w   以只写模式打开文件。 它将文件指针放在文件的开头，并将文件截断为零长度。 如果找不到文件，则会自动创建一个新文件。
    - w+  以读写模式打开文件。 它将文件指针放在文件的开头，并将文件截断为零长度。 如果找不到文件，则会自动创建一个新文件。
    - a   以只写模式打开文件。 它将文件指针放在文件的末尾。 如果找不到文件，则会创建一个新文件。
    - a+  以读写模式打开文件。 它将文件指针放在文件的末尾。 如果找不到文件，则会创建一个新文件。
    - x   以只写模式创建和打开文件。 它将文件指针放在文件的开头。 如果找到文件，fopen()函数返回FALSE。
    - x+  它与x相同，但它以读写模式创建和打开文件。
    - c   以只写模式打开文件。 如果文件不存在，则会创建它。 如果存在，它不会被截断(与’w‘相反)，也不会调用此函数失败(如’x‘的情况)。 文件指针位于文件的开头
    - c+  它与c相同，但它以读写模式打开文件。
* 读取文件：string fread (resource $handle , int $length )函数用于读取文件的数据。 它需要两个参数：文件资源($handle 由fopen()函数创建的文件指针)和文件大小($length 要读取的字节长度)
    - 逐行读取文件：string fgets ( resource $handle [, int $length ] )函数用于从文件中读取单行数据内容。
    - 逐个字符读取文件：string fgetc ( resource $handle )函数用于从文件中读取单个字符。 要使用fgetc()函数获取所有数据，请在while循环中使用!feof()函数作为条件。
* 写入文件：int fwrite ( resource $handle , string $string [, int $length ] )：用于将字符串的内容写入文件。
    - 如果再次运行上面的代码，它将擦除文件的前一个数据并写入新的数据。
    - 附加文件
* 删除文件：bool unlink ( string $filename [, resource $context ] )
* 关闭文件
* 上传文件：`bool move_uploaded_file ( string $filename , string $destination )`
    - $_FILES['filename']['name']   返回文件名称
    - $_FILES['filename']['type'] 返回文件的MIME类型
    - $_FILES['filename']['size'] 返回文件的大小(以字节为单位)
    - $_FILES['filename']['tmp_name'] 返回存储在服务器上的文件的临时文件名。
    - $_FILES['filename']['error']    返回与此文件相关联的错误代码。
* 下载文件：int readfile ( string $filename [, bool $use_include_path = false [, resource $context ]] )
    - $filename：表示文件名
    - $use_include_path：它是可选参数。它默认为false。可以将其设置为true以搜索included_path中的文件。
    - $context：表示上下文流资源。
    - int：它返回从文件读取的字节数。

```php
$filename = "c:\\myfile.txt";
$handle = fopen($filename, "r");//open file in read mode
$contents = fread($handle, filesize($filename));//read file
echo $contents;//printing data of file
fclose($handle);//close file

$fp = fopen('data.txt', 'w');//open file in write mode
fwrite($fp, 'hello ');
fwrite($fp, 'php file');
fclose($fp);
echo "File written successfully";

$status=unlink('data.txt');
if($status){
echo "File deleted successfully";
}else{
echo "Sorry!";
}

$fp  = fopen('lock.txt', 'w+');
if (flock($fp, LOCK_EX)) {
    fwrite($fp, 'write something');
    flock($fp, LOCK_UN);
} else {
    echo "file is locking...";
}
fclose($fp);

$fp = fopen("c:\\file1.txt", "r");//open file in read mode
while(!feof($fp)) {
  echo fgetc($fp);
}
fclose($fp);

$fp = fopen('data.txt', 'a');//opens file in append mode
fwrite($fp, ' this is additional text ');
fwrite($fp, 'appending data');
fclose($fp);
echo "File appended successfully";

# uploadform.html
<form action="uploader.php" method="post" enctype="multipart/form-data">
    选择上传的文件:
    <input type="file" name="fileToUpload"/>
    <input type="submit" value="Upload Image" name="submit"/>
</form>

<?php
$target_path = "D:/";
$target_path = $target_path.basename( $_FILES['fileToUpload']['name']);

if(move_uploaded_file($_FILES['fileToUpload']['tmp_name'], $target_path)) {
    echo "File uploaded successfully!";
} else{
    echo "Sorry, file not uploaded, please try again!";
}
?>

$file_url = 'http://www.myremoteserver.com/file.exe';
header('Content-Type: application/octet-stream');
header("Content-Transfer-Encoding: Binary");
header("Content-disposition: attachment; filename=\"" . basename($file_url) . "\"");
readfile($file_url);
```

### redirect

* header ( string $header [, bool $replace = TRUE [, int $http_response_code ]] ) : void
* using ob_start() and ob_end_flush()
* javascript

```php
header(“Location: http://example.com”);
exit;

header(“Location: http://example.com”,TRUE,301);
exit;

header(“Location: /page2.php”);
exit;

$url = ‘http://’ . $_SERVER[‘HTTP_HOST’]; // Get server
$url .= rtrim(dirname($_SERVER[‘PHP_SELF’]), ‘/\\’); // Get current directory
$url .= ‘/relative/path/to/page/’; // relative path
header(‘Location: ‘ . $url, TRUE, 302);

session_start();
if (!isset( $_SESSION[“authorized-user”]))
{
header(“location:../”);
exit();
}

header(“location: page1.php”);
echo “moving to page 2”
header(“location: page2.php”); //replaces page1.php

header( “refresh:5;url=/page6.php” );
echo ‘Redirecting in 5 secs. Click here to go directly <a href=”/page6.php”>here</a>.’;

ob_start(); //this has to be the first line of your page
header(‘Location: page2.php’);
ob_end_flush(); //this has to be the last line of your page

echo ‘<script type=”text/javascript”>
window.location = “http:/example.com/”
</script>’;
```

### MySQL

PHP 5.5以来，mysql_connect()扩展已被弃用。 现在，建议使用以下2种替代方法之一

* mysqli_connection()
* PDO::__ construct()

https://linux.cn/article-10899-1.html

```php
$host = 'localhost:3306';
$user = 'root';  // MySQL用户帐号
$pass = '';  // MySQL用户帐号对应的密码
$conn = mysqli_connect($host, $user, $pass);
if(! $conn )
{
  die('Could not connect: ' . mysqli_error());
}
echo 'Connected successfully';

$sql = 'CREATE Database mydb';
if(mysqli_query( $conn,$sql)){
    echo "Database mydb created successfully.";
}else{
    echo "Sorry, database creation failed ".mysqli_error($conn);
}

$sql = "create table emp5(id INT AUTO_INCREMENT,name VARCHAR(20) NOT NULL,
emp_salary INT NOT NULL,primary key (id))";
if(mysqli_query($conn, $sql)){
 echo "Table emp5 created successfully";
}else{
echo "Could not create table: ". mysqli_error($conn);

$sql = 'INSERT INTO emp4(name,salary) VALUES ("maxsu", 9000)';
if(mysqli_query($conn, $sql)){
 echo "Record inserted successfully";
}else{
echo "Could not insert record: ". mysqli_error($conn);
}

$id=2;
$name="Rahul";
$salary=80000;
$sql = "update emp4 set name="$name", salary=$salary where id=$id";
if(mysqli_query($conn, $sql)){
 echo "Record updated successfully";
}else{
echo "Could not update record: ". mysqli_error($conn);
}

$id=2;
$sql = "delete from emp4 where id=$id";
if(mysqli_query($conn, $sql)){
 echo "Record deleted successfully";
}else{
echo "Could not deleted record: ". mysqli_error($conn);
}

$sql = 'SELECT * FROM emp4';
$retval=mysqli_query($conn, $sql);

if(mysqli_num_rows($retval) > 0){
 while($row = mysqli_fetch_assoc($retval)){
    echo "EMP ID :{$row['id']}  <br> ".
         "EMP NAME : {$row['name']} <br> ".
         "EMP SALARY : {$row['salary']} <br> ".
         "--------------------------------<br>";
 } //end of while
}else{
echo "0 results";
}

$sql = 'SELECT * FROM emp4 order by name';
$retval=mysqli_query($conn, $sql);

if(mysqli_num_rows($retval) > 0){
 while($row = mysqli_fetch_assoc($retval)){
    echo "EMP ID :{$row['id']}  <br> ".
         "EMP NAME : {$row['name']} <br> ".
         "EMP SALARY : {$row['salary']} <br> ".
         "--------------------------------<br>";
 } //end of while
}else{
echo "0 results";
}

mysqli_close($conn);
```

## 面向对象(OOP)

* 继承：类分层、接口分层
* 实现：类实现接口
* 依赖：类作为另一个类方法的参数
* 关联：类属性
* 聚合：可以有
* 组合：必须有

### 类

* spl_autoload：__autoload()函数的默认实现
* spl_autoload_register:  注册给定的函数作为 __autoload（7.2之后废弃） 的实现，替代spl_autoload（）
* 构造函数：创建新对象时先调用此方法，适合在使用对象之前做一些初始化工作
    - 子类中定义了构造函数则不会隐式调用其父类的构造函数
    - 要执行父类的构造函数，需要在子类的构造函数中调用 parent::__construct()
    - 如果子类没有定义构造函数则会如同一个普通的类方法一样从父类继
* 析构函数
* 父类中的方法被声明为 final，则子类无法覆盖该方法。如果一个类被声明为 final，则不能被继承

### 对象

* 对象是一堆属性组成。在底层的实现,采取属性数组+方法数组来实现的。对象在zend中的定义是使用了一种zend_object_value结构体来存储的，这个结构体包含：
    - 一个指针，也就是说明这个对象由哪个类实现出来的，这个类在哪里
    - 这个对象的属性。
    - guards,阻止递归调用的。
    - 对象的方法不会存在对象里面，要使用对象的方法，实际上是通过指针找到这个类，再用这个类里面的方法来执行的。（通过类序列化检测）
* 延迟绑定：子类重写父类方法，其它调用该方法时用static而非self
    - static:: 不再被解析为定义当前方法所在的类，而是在实际运行时计算的。也可以称之为"静态绑定"，因为它可以用于（但不限于）静态方法的调用
    - 当进行静态方法调用时，该类名即为明确指定的那个（通常在 :: 运算符左侧部分）
    - 当进行非静态方法调用时，即为该对象所属的类。
* 对象复制：对对象的所有属性执行一个浅复制（shallow copy）。所有的引用属性 仍然会是一个指向原来的变量的引用
* 默认情况下对象是通过引用传递的:对象作为参数传递、作为结果返回或者赋值给另外一个变量，另外一个变量跟原来的不是引用的关系，只是他们都保存着同一个标识符的拷贝，这个标识符指向同一个对象的真正内容
* 场景
    + PHP异步调用
    + 正则匹配src标签
    + 处理回文字符

```php
class A {
    public static function who() {
        echo __CLASS__;
    }
    public static function test() {
        self::who();
    }
}

class B extends A {
    public static function who() {
        echo __CLASS__;
    }
}

B::test(); # A
```

#### 访问控制(可见性)

* public表明类成员在任何地方可见
* protected表明类成员在其自身、子类和父类内可见
* private表明类成员只对自己可见。
* 对于private和protected有个特例，同一个类的对象即使不是同一个实例也可以互相访问对方的私有与受保护成员

范围解析符(::)：通常以self::、 parent::、 static:: 和 <classname>::形式来访问静态成员、类常量，另外，static::、self:: 和 parent:: 还可用来调用类中的非静态方法。类中实例话自己

* self
* parent
* static:调用类里面的静态属性与静态方法

```php
class Test
{
    private $foo;

    public function __construct($foo)
    {
        $this->foo = $foo;
    }

    private function bar()
    {
        echo 'Accessed the private method.';
    }

    public function baz(Test $other)
    {
        // We can change the private property:
        $other->foo = 'hello';
        var_dump($other->foo);

        // We can also call the private method:
        $other->bar();
    }
}

$test = new Test('test');
$test->baz(new Test('other'));

# 延迟绑定
class A
{
    public static $proPublic = "public of A";

    public function myMethod()
    {
        echo static::$proPublic."\n";
    }

    public function test()
    {
        echo "Class A:\n";
        echo self::$proPublic."\n";
        echo __CLASS__."\n";
        //echo parent::$proPublic."\n";
        self::myMethod();
        static::myMethod();
    }
}

class B extends A
{
   public static $proPublic = "public of B";

   public function test()
    {
        echo "\n\nClass B:\n";
        echo self::$proPublic."\n";
        echo __CLASS__."\n";
        echo parent::$proPublic."\n";
        self::myMethod();
        static::myMethod();
    }
}

class C extends B
{
    public static $proPublic = "public of C";
}

$t1 = new A();
$t1->test();
$t2 = new B();
$t2->test();
$t3 = new C();
$t3->test();
```

#### 多态

多态性是指相同的操作或函数、过程可作用于多种类型的对象上并获得不同的结果。不同的对象，收到同一消息将可以产生不同的结果，这种现象称为多态性。“一个对外接口，多个内部实现方法”。在面向对象的理论 中，多态性的一般定义为：同一个操作作用于不同的类的实例，将产生不同的执行结果。也即不同类的对象收到相同的消息时，将得到不同的结果。

* 多态性允许每个对象以适合自身的方式去响应共同的消息。多态性增强了软件的灵活性和重用性。
* 面向对象编程并不只是将相关的方法与数据简单的结合起来，而是采用面向对象编程中的各种要素将现实生活中的各种情况清晰的描述出来。
* 采用面向对象中的多态主要在于可以将不同的子类对象都当作一个父类来处理，并且可以屏蔽不同子类对象之间所存在的差异，写出通用的代码，做出通用的编程，以适应需求的不断变化。
* 通常为了使项目能够在以后的时间里的轻松实现扩展与升级，需要通过继承实现可复用模块进行轻松升级。在进行可复用模块设计时，就需要尽可能的减少使用流程控制语句。此时就可以采用多态实现该类设计。

```php
<?php
class employee{//定义员工父类
    protected function working(){//定义员工工作，需要在子类的实现
        echo "本方法需要在子类中重载!";
    }
}
class painter extends employee{//定义油漆工类
    public function working(){//实现继承的工作方法
        echo "油漆工正在刷漆！/n";
    }
}
class typist extends employee{//定义打字员类
    public function working(){
        echo "打字员正在打字！/n";
    }
}
class manager extends employee{//定义经理类
    public function working(){
        echo "经理正在开会！";
    }
}
function printworking($obj){//定义处理方法
    if($obj instanceof employee){//若是员工对象，则显示其工作状态
        $obj->working();
    }else{//否则显示错误信息
        echo "Error: 对象错误！";
    }
}
printworking(new painter());//显示油漆工的工作
printworking(new typist());//显示打字员的工作
printworking(new manager());//显示经理的工作
?>
```

#### 接口与抽象类

* 接口是通过interface关键字来定义的，但其中定义所有的方法都是空的，访问控制必须是public。
* 接口可以如类一样定义常量，可以使用extends来继承其他接口
* 接口中的每个方法，继承类里面都要去实现
* 接口中的方法后面不要跟大口号{},因为接口只是定义需要有这个函数，并不是自己去实现
* 不能实例化，抽象类中 abstract 的方法，强制要求子类定义这些方法，也可以理解成接口中的每个方法都是 abstract 方法
* 抽象方法中没有abstract 的方法，继承类不必非要写那个方法
* 抽象类定义要使用abstract关键字来声明，凡是用abstract关键字定义了抽象方法的类必须声明为抽象类。
* 子类实现抽象方法时访问控制必须和父类中一样（或者更为宽松），同时调用方式必须匹配，即类型和所需参数数量必须一致；
* 抽象类可用于对多个同构类的通用部分定义，用extends关键字继承(父子间存在"is a"关系)，属单继承。接口可用于多个异构类的通用部分定义，用implements关键字继承(父子间存在"like a"关系)，可多继承。如果子类不能实现父类或接口的全部抽象方法，则该子类只能被声明成抽象类。
* 接口比抽象更严格，
* 重写vs重载
    - 重载指多个名字相同，但参数不同的函数在同一作用域并存的现象.参数不同有三种情况：参数个数不同，参数类型不同，参数顺序不同.函数重载多见于强类型语言，编译后函数在函数符号表的名称一般是函数名加参数类型
        + php不支持：function_exists、 method_exists、is_callable、get_defined_functions、ReflectionMethod/ReflectionFunction类的getParameters/getNumberOfParameters/getNumberOfRequiredParameters
    - 重写出现在继承中，指子类重定义父类功能的现象，也被称为覆盖,即相同签名的成员函数在子类中重新定义（实现抽象函数或接口不是重写），是实现多态（polymorphism）的一种关键技术

```php
// 定义接口
interface  Log{
    public function save($message);
}

// 稳健型日志
class FileLog implements Log{
    public function save($message){
        var_dump('log into file'.$message);
    }
}
// 数据库型日志
class DatabaseLog implements Log{
    public function save($message){
        var_dump('log into database'.$message);
    }
}

//自定义类实现接口
class UsersController{
    protected $log;
    public function __construct(Log $log)
    {
        $this->log = $log;
    }

    public function register(){
        $name= 'long';
        $this->log->save($name);
    }
}

//$controller = new UsersController(new DatabaseLog());
//string(21) "log into databaselong"
$controller = new UsersController(new FileLog());
//string(17) "log into filelong"
$controller->register();
```

#### trait

* 减少单继承语言的限制，自由地在不同层次结构内独立的类中复用 method
* 优先级:当前类的成员>trait 的方法>被继承的方法
* Trait 和 Class 相似，但仅仅旨在用细粒度和一致的方式来组合功能。它为传统继承增加了水平特性的组合；也就是说，应用的几个 Class 之间不需要继承。
* 无法通过 trait 自身来实例化

```php
class Base {
    public function sayHi() {
        echo 'Hello ';
    }
}

trait SayWorld {
    public function sayHello() {
        parent::sayHello();
        echo 'World!';
    }
}

trait World {
    public function sayWorld() {
        echo ' I am coming';
    }
}

class MyHelloWorld extends Base {
    use SayHello, SayWorld;
}

$o = new MyHelloWorld();
$o->sayHi();
$o->sayHello();
$o->SayWorld();
```

### 匿名类

* 匿名类被嵌套进普通 Class 后，不能访问这个外部类（Outer class）的 private（私有）、protected（受保护）方法或者属性。 为了访问外部类（Outer class）protected 属性或方法，匿名类可以 extend（扩展）此外部类。 为了使用外部类（Outer class）的 private 属性，必须通过构造器传进来：

```php
$util->setLogger(new class {
    public function log($msg)
    {
        echo $msg;
    }
});

class Outer
{
    private $prop = 1;
    protected $prop2 = 2;

    protected function func1()
    {
        return 3;
    }

    public function func2()
    {
        return new class($this->prop) extends Outer {
            private $prop3;

            public function __construct($prop)
            {
                $this->prop3 = $prop;
            }

            public function func3()
            {
                return $this->prop2 + $this->prop3 + $this->func1();
            }
        };
    }
}

echo (new Outer)->func2()->func3(); # 6
```

## 魔术方法

* `__construct()`
* `__destruct()`
* `__call()`
* `__callStatic()`
* `__get()`
* `__set()`
* `__isset()`
* `__unset()`
* `__sleep()`:serialize() 函数会检查类中是否存在一个魔术方法 __sleep()。如果存在，该方法会先被调用，然后才执行序列化操作,可以用于清理对象，并返回一个包含对象中所有应被序列化的变量名称的数组,不能返回父类的私有成员的名字。这样做会产生一个 E_NOTICE 级别的错误.
* `__wakeup()`:unserialize() 会检查是否存在一个 __wakeup() 方法。如果存在，则会先调用 __wakeup 方法，预先准备对象需要的资源
* `__toString()`:用于一个类被当成字符串时应怎样回应
* `__invoke()`:当尝试以调用函数的方式调用一个对象时
* `__set_state()`
* `__clone()`

```php
class CallableClass
{
    function __invoke($x) {
        var_dump($x);
    }
}
$obj = new CallableClass;
$obj(5);
var_dump(is_callable($obj));
```

## 命名空间

* 如果一个文件中包含命名空间，它必须在其它所有代码之前声明命名空间
* 用户编写的代码与PHP内部的类/函数/常量或第三方类/函数/常量之间的名字冲突
* 为很长的标识符名称(通常是为了缓解第一类问题而定义的)创建一个别名（或简短）的名称，提高源代码的可读性
* 以下类型的代码受命名空间的影响，它们是：类（包括抽象类和traits）、接口、函数和常量
* 可以在同一个文件中定义多个命名空间,建议使用下面的大括号形式的语法
* 类名可以通过三种方式引用
    - 非限定名称，或不包含前缀的类名称，例如 $a=new foo(); 或 foo::staticmethod();。如果当前命名空间是 currentnamespace，foo 将被解析为 currentnamespace\foo。如果使用 foo 的代码是全局的，不包含在任何命名空间中的代码，则 foo 会被解析为foo。
    - 限定名称,或包含前缀的名称，例如 $a = new subnamespace\foo(); 或 subnamespace\foo::staticmethod();。如果当前的命名空间是 currentnamespace，则 foo 会被解析为 currentnamespace\subnamespace\foo。如果使用 foo 的代码是全局的，不包含在任何命名空间中的代码，foo 会被解析为subnamespace\foo。
    - 完全限定名称，或包含了全局前缀操作符的名称，例如， $a = new \currentnamespace\foo(); 或 \currentnamespace\foo::staticmethod();。
* 两种抽象的访问当前命名空间内部元素的方法，`__NAMESPACE__` 魔术常量和namespace关键字
    - 常量__NAMESPACE__的值是包含当前命名空间名称的字符串。在全局的，不包括在任何命名空间中的代码，它包含一个空的字符串
* 导入：允许通过别名引用或导入外部的完全限定名称
    - 为类名称使用别名
    - 为接口使用别名
    - 为命名空间名称使用别名

```php
namespace my\name;

class MyClass {}
function myfunction() {}
const MYCONST = 1;

$a = new MyClass;
$c = new \my\name\MyClass;

$d = namespace\MYCONST;

$d = __NAMESPACE__ . '\MYCONST';
echo constant($d);

# 同一个文件中定义多个命名空间,两种方式
namespace MyProject;

const CONNECT_OK = 1;
class Connection { /* ... */ }
function connect() { /* ... */  }

namespace AnotherProject;

const CONNECT_OK = 1;
class Connection { /* ... */ }
function connect() { /* ... */  }

## 方式2
namespace MyProject {

const CONNECT_OK = 1;
class Connection { /* ... */ }
function connect() { /* ... */  }
}

namespace AnotherProject {

const CONNECT_OK = 1;
class Connection { /* ... */ }
function connect() { /* ... */  }
}

## 引用方式
namespace Foo\Bar;
include 'file1.php';

const FOO = 2;
function foo() {}
class foo
{
    static function staticmethod() {}
}

/* 非限定名称 */
foo(); // 解析为 Foo\Bar\foo resolves to function Foo\Bar\foo
foo::staticmethod(); // 解析为类 Foo\Bar\foo的静态方法staticmethod。resolves to class Foo\Bar\foo, method staticmethod
echo FOO; // resolves to constant Foo\Bar\FOO

/* 限定名称 */
subnamespace\foo(); // 解析为函数 Foo\Bar\subnamespace\foo
subnamespace\foo::staticmethod(); // 解析为类 Foo\Bar\subnamespace\foo,
                                  // 以及类的方法 staticmethod
echo subnamespace\FOO; // 解析为常量 Foo\Bar\subnamespace\FOO

/* 完全限定名称 */
\Foo\Bar\foo(); // 解析为函数 Foo\Bar\foo
\Foo\Bar\foo::staticmethod(); // 解析为类 Foo\Bar\foo, 以及类的方法 staticmethod
echo \Foo\Bar\FOO; // 解析为常量 Foo\Bar\FOO

## __NAMESPACE__
namespace MyProject;
echo '"', __NAMESPACE__, '"'; // 输出 "MyProject"
function get($classname)
{
    $a = __NAMESPACE__ . '\\' . $classname;
    return new $a;
}

## 全局代码
echo '"', __NAMESPACE__, '"'; // 输出 ""

## namespace
namespace MyProject;

use blah\blah as mine; // see "Using namespaces: importing/aliasing"

blah\mine(); // calls function MyProject\blah\mine()
namespace\blah\mine(); // calls function MyProject\blah\mine()

namespace\func(); // calls function MyProject\func()
namespace\sub\func(); // calls function MyProject\sub\func()
namespace\cname::method(); // calls static method "method" of class MyProject\cname
$a = new namespace\sub\cname(); // instantiates object of class MyProject\sub\cname
$b = namespace\CONSTANT; // assigns value of constant MyProject\CONSTANT to $b

## 全局
namespace\func(); // calls function func()
namespace\sub\func(); // calls function sub\func()
namespace\cname::method(); // calls static method "method" of class cname
$a = new namespace\sub\cname(); // instantiates object of class sub\cname
$b = namespace\CONSTANT; // assigns value of constant CONSTANT to $b

## 使用use操作符导入/使用别名
namespace foo;
use My\Full\Classname as Another;

// 下面的例子与 use My\Full\NSname as NSname 相同
use My\Full\NSname;
// 导入一个全局类
use ArrayObject;
// importing a function (PHP 5.6+)
use function My\Full\functionName;
// aliasing a function (PHP 5.6+)
use function My\Full\functionName as func;
// importing a constant (PHP 5.6+)
use const My\Full\CONSTANT;

$obj = new namespace\Another; // 实例化 foo\Another 对象
$obj = new Another; // 实例化 My\Full\Classname　对象
NSname\subns\func(); // 调用函数 My\Full\NSname\subns\func
$a = new ArrayObject(array(1)); // 实例化 ArrayObject 对象
// 如果不使用 "use \ArrayObject" ，则实例化一个 foo\ArrayObject 对象
func(); // calls function My\Full\functionName
echo CONSTANT; // echoes the value of My\Full\CONSTANT

# 通过use操作符导入/使用别名，一行中包含多个use语句
use My\Full\Classname as Another, My\Full\NSname;
$obj = new Another; // 实例化 My\Full\Classname 对象
NSname\subns\func(); // 调用函数 My\Full\NSname\subns\func

# 导入和动态名称
use My\Full\Classname as Another, My\Full\NSname;
$obj = new Another; // 实例化一个 My\Full\Classname 对象
$a = 'Another';
$obj = new $a;      // 实际化一个 Another 对象

# 导入和完全限定名称
use My\Full\Classname as Another, My\Full\NSname;
$obj = new Another; // instantiates object of class My\Full\Classname
$obj = new \Another; // instantiates object of class Another
$obj = new Another\thing; // instantiates object of class My\Full\Classname\thing
$obj = new \Another\thing; // instantiates object of class Another\thing
```

## 时间

```php
var_dump(date("Y-m-d", strtotime("-1 month", strtotime("2017-03-31")))); # 输出2017-03-03
var_dump(date("Y-m-d", strtotime("last day of -1 month", strtotime("2017-03-31")))); # 输出2017-02-28
var_dump(date("Y-m-d", strtotime("first day of +1 month", strtotime("2017-08-31")))); # 输出2017-09-01

```

### 生成器

提供了一种更容易的方法来实现简单的对象迭代，性能开销和复杂性大大降低。

* 一个生成器函数看起来像一个普通的函数，不同的是普通函数返回一个值，而一个生成器可以yield生成许多它所需要的值
* 一个简单的例子就是使用生成器来重新实现 range() 函数。 标准的 range() 函数需要在内存中生成一个数组包含每一个在它范围内的值，然后返回该数组, 结果就是会产生多个很大的数组。 比如，调用 range(0, 1000000) 将导致内存占用超过 100 MB。
* 当一个生成器被调用的时候，它返回一个可以被遍历的对象.当你遍历这个对象的时候(例如通过一个foreach循环)，PHP 将会在每次需要值的时候调用生成器函数，并在产生一个值之后保存生成器的状态，这样它就可以在需要产生下一个值的时候恢复调用状态。
* 一旦不再需要产生更多的值，生成器函数可以简单退出，而调用生成器的代码还可以继续执行，就像一个数组已经被遍历完了
* 生成器函数的核心是yield关键字。它最简单的调用形式看起来像一个return申明，不同之处在于普通return会返回值并终止函数的执行，而yield会返回一个值给循环调用此生成器的代码并且只是暂停执行生成器函数。
* 在一个表达式上下文(例如在一个赋值表达式的右侧)中使用yield，你必须使用圆括号把yield申明包围起来
* 使用，函数yield返回，遍历获取值
* 支持关联键值对,制定键名
* 在没有参数传入的情况下被调用来生成一个 NULL值并配对一个自动的键名
* 方法
    - array iterator_to_array ( Traversable $iterator [, bool $use_keys = true ] )

```php
function xrange($start, $limit, $step = 1) {
    if ($start < $limit) {
        if ($step <= 0) {
            throw new LogicException('Step must be +ve');
        }

        for ($i = $start; $i <= $limit; $i += $step) {
            yield $i;
        }
    } else {
        if ($step >= 0) {
            throw new LogicException('Step must be -ve');
        }

        for ($i = $start; $i >= $limit; $i += $step) {
            yield $i;
        }
    }
}

foreach (xrange(1, 9, 2) as $number) {
    echo "$number ";
}

$data = (yield $value);

$iterator = new ArrayIterator(array('recipe'=>'pancakes', 'egg', 'milk', 'flour'));
var_dump(iterator_to_array($iterator, true));
var_dump(iterator_to_array($iterator, false));
```

## 自动加载

PHP在需要类定义的时候调用它

* include 或require
* `__autoload`:调用不存在的类时会被自动调用,现在基本废弃
    - 一个文件中不允许有多个 `__autoload()`方法，引入文件中也存在`__autoload()`
    - 一个文件中引入多个文件目录
* bool spl_autoload_register ([ callable $autoload_function [, bool $throw = true [, bool $prepend = false ]]] ) :注册给定的函数作为 `__autoload` 的实现
    - 函数名称
    - 闭包函数
* 获取所有已注册的 `__autoload()` 函数:spl_autoload_functions ( void ) 
* spl_classes — 返回所有可用的SPL类
* spl_autoload_unregister — 注销已注册的`__autoload()`函数 


```php
<?php
function __autoload($class){
    if(file_exists($class.".php")){
        require_once($class.".php");
    }else{
        die("文件不存在！");
    }
}

Test1::test();
Test2::test();

// 注册
spl_autoload_register(function ($class_name) {
    $class_name = str_replace('\\','/', $class_name); /*将 use语句中的’\’替换成’/‘，避免造成转移字符导致require_once时会报错*/
    $file_name  = $class_name . '.class.php';
    if (file_exists($file_name)) {
        require_once $file_name;
    }

});

use Animal\Dog;

$dog = new Dog();
$cat = new \Animal\Cat();
```

## JSON

* json_encode( mixed $value [, int $options = 0 [, int $depth = 512 ]] )函数返回值JSON的表示形式：它将PHP变量(包含数组)转换为JSON格式数据
    - 1:JSON_HEX_TAG:所有的 < 和 > 转换成 \u003C 和 \u003E
    - 2:JSON_HEX_AMP:所有的 & 转换成 \u0026
    - 4:JSON_HEX_APOS:所有的 ' 转换成 \u0027
    - 8:JSON_HEX_QUOT:所有的 " 转换成 \u0022
    - 16:JSON_FORCE_OBJECT:使一个非关联数组输出一个类（Object）而非数组。 在数组为空而接受者需要一个类（Object）的时候尤其有用
    - 32:JSON_NUMERIC_CHECK:将所有数字字符串编码成数字（numbers）
    - 64:JSON_UNESCAPED_SLASHES:不要编码 /
    - 128:JSON_PRETTY_PRINT:用空白字符格式化返回的数据
    - 256:JSON_UNESCAPED_UNICODE:以字面编码多字节 Unicode 字符（默认是编码成 \uXXXX）
    - 512:JSON_PARTIAL_OUTPUT_ON_ERROR:Substitute some unencodable values instead of failing
    - 1024:JSON_PRESERVE_ZERO_FRACTION:Ensures that float values are always encoded as a float value
* json_decode()函数解码JSON字符串：将JSON字符串转换为PHP变量
* json_last_error_msg — Returns the error string of the last json_encode() or json_decode() call
* json_last_error — 返回最后发生的错误

```php
<?php
$a = array('<foo>',"'bar'",'"baz"','&blong&', "\xc3\xa9");

echo "Normal: ",  json_encode($a), "\n"; # Normal: ["<foo>","'bar'","\"baz\"","&blong&","\u00e9"]
echo "Tags: ",    json_encode($a, JSON_HEX_TAG), "\n"; # Tags: ["\u003Cfoo\u003E","'bar'","\"baz\"","&blong&","\u00e9"]
echo "Apos: ",    json_encode($a, JSON_HEX_APOS), "\n"; # Apos: ["<foo>","\u0027bar\u0027","\"baz\"","&blong&","\u00e9"]
echo "Quot: ",    json_encode($a, JSON_HEX_QUOT), "\n"; # Quot: ["<foo>","'bar'","\u0022baz\u0022","&blong&","\u00e9"]
echo "Amp: ",     json_encode($a, JSON_HEX_AMP), "\n"; # Amp: ["<foo>","'bar'","\"baz\"","\u0026blong\u0026","\u00e9"]
echo "Unicode: ", json_encode($a, JSON_UNESCAPED_UNICODE), "\n"; # Unicode: ["<foo>","'bar'","\"baz\"","&blong&","é"]
echo "All: ",     json_encode($a, JSON_HEX_TAG | JSON_HEX_APOS | JSON_HEX_QUOT | JSON_HEX_AMP | JSON_UNESCAPED_UNICODE), "\n\n"; # All: ["\u003Cfoo\u003E","\u0027bar\u0027","\u0022baz\u0022","\u0026blong\u0026","é"]

$b = array();

echo "Empty array output as array: ", json_encode($b), "\n"; # Empty array output as array: []
echo "Empty array output as object: ", json_encode($b, JSON_FORCE_OBJECT), "\n\n"; # Empty array output as object: {}

$c = array(array(1,2,3));

echo "Non-associative array output as array: ", json_encode($c), "\n"; # Non-associative array output as array: [[1,2,3]]
echo "Non-associative array output as object: ", json_encode($c, JSON_FORCE_OBJECT), "\n\n"; # Non-associative array output as object: {"0":{"0":1,"1":2,"2":3}}

$d = array('foo' => 'bar', 'baz' => 'long');

echo "Associative array always output as object: ", json_encode($d), "\n"; # Associative array always output as object: {"foo":"bar","baz":"long"}
echo "Associative array always output as object: ", json_encode($d, JSON_FORCE_OBJECT), "\n\n"; # Associative array always output as object: {"foo":"bar","baz":"long"}
?>
```

## XML

* simplexml_load_file

## 网络

* gethostbyaddr()：获取指定的IP地址对应的主机名
* gethostbynamel():获取互联网主机名对应的 IPv4 地址列表

```php
$hostname = gethostbyaddr($_SERVER['REMOTE_ADDR']);
```

##  密码散列算法函数

* password_​get_​info
* password_​hash
* password_​needs_​rehash
* password_​verify

## 性能

* memory_get_usage()
* microtime()

## 扩展

* intl
* mcrypt
* memeache
* memeached
    - memcache完全在PHP框架内开发的，提供了memcached的接口，memecached扩展是使用了libmemcached库提供的api与memcached服务端进行交互。 libmemcached 是 memcache 的 C 客户端，它具有低内存，线程安全等优点
    - memcache提供了面向过程及面向对象的接口，memached只支持面向对象的接口。 memcached 实现了更多的 memcached 协议。
    - memcached 支持 Binary Protocol，而 memcache 不支持，意味着 memcached 会有更高的性能。不过，还需要注意的是，memcached 目前还不支持长连接。
* mongodb
* Opcache:通过将 PHP 脚本预编译的字节码存储到共享内存中来提升 PHP 的性能， 存储预编译字节码的好处就是省去了每次加载和解析 PHP 脚本的开销，但是对于I/O开销如读写磁盘文件、读写数据库等并无影响。
    - 字节码(Byte Code)：一种包含执行程序比机器码更抽象的中间码，由一序列 op代码/数据对组成的二进制文件。 比如Java源码经编译后生成的字节码在运行时通过JVM(JVM针对不同平台有不同版本，Java程序在JVM中运行而称 为解释性语言Interpreted)再做一次转换生成机器码，才能够跨平台运行；C#也类似，EXE文件的执行依赖.NET Framework；HHVM(HipHop Virtual Machine，Facebook开源的PHP虚拟机)采用了JIT(Just In Time Just Compiling，即时编译)技术，在运行时编译字节码为机器码，让他们的PHP性能测试提升了一个数量级。 唯有C/C++编译生成的二进制文件可直接运行。
    - 机器码(Machine Code)：也被称为原生码(Native Code)，用二进制代码表示的计算机能直接识别和执行的一种机器指令的集合，它是计算机硬件结构赋予的操作功能。
* pdo-pgsql
* phalcon
* redis: http://pecl.php.net/package/redis
* sphinx
* swoole
* xdebug
* apc:op缓存
* [phpredis/phpredis](https://github.com/phpredis/phpredis):A PHP extension for Redis
* PHP-FPM进程池：FastCGI Process Manager 的master process是常驻内存的，以static、dynamic、ondemand三种方式来管理进程池中的worker process，可以有效控制内存和进程并平滑重载PHP配置，在发生意外情况的时候能够重新启动并恢复被破坏的 opcode。

```sh
brew tap homebrew/homebrew-php
brew install php71 --with-pear

brew install mcrypt
brew install php71-xdebug

yum install php-mcrypt|php5-mcrypt
apt-get install php-mcrypt|php5-mcrypt
pecl install mcrypt-snapshot|mcrypt-1.0.1
brew install php71-mcrypt
```

* [defuse/php-encryption](https://github.com/defuse/php-encryption):Simple Encryption in PHP.
* [jedisct1/libsodium](https://github.com/jedisct1/libsodium):A modern, portable, easy to use crypto library https://libsodium.org

## Docker配置

- mkdir -p ~/php-fpm/logs ~/php-fpm/conf
- 构建Dockerfile

```
FROM debian:jessie

# persistent / runtime deps

ENV PHPIZE_DEPS \ autoconf \ file \ g++ \ gcc \ libc-dev \ make \ pkg-config \ re2c RUN apt-get update && apt-get install -y \ $PHPIZE_DEPS \ ca-certificates \ curl \ libedit2 \ libsqlite3-0 \ libxml2 \ --no-install-recommends && rm -r /var/lib/apt/lists/*

ENV PHP_INI_DIR /usr/local/etc/php RUN mkdir -p $PHP_INI_DIR/conf.d

## <autogenerated>
</autogenerated>

ENV PHP_EXTRA_CONFIGURE_ARGS --enable-fpm --with-fpm-user=www-data --with-fpm-group=www-data

##

ENV GPG_KEYS 0BD78B5F97500D450838F95DFE857D9A90D90EC1 6E4F6AB321FDC07F2C332E3AC2BF0BC433CFC8B3

ENV PHP_VERSION 5.6.22 ENV PHP_FILENAME php-5.6.22.tar.xz ENV PHP_SHA256 c96980d7de1d66c821a4ee5809df0076f925b2fe0b8c362d234d92f2f0a178e2

RUN set -xe \ && buildDeps=" \ $PHP_EXTRA_BUILD_DEPS \ libcurl4-openssl-dev \ libedit-dev \ libsqlite3-dev \ libssl-dev \ libxml2-dev \ xz-utils \ " \ && apt-get update && apt-get install -y $buildDeps --no-install-recommends && rm -rf /var/lib/apt/lists/_ \ && curl -fSL "<http://php.net/get/$PHP_FILENAME/from/this/mirror>" -o "$PHP_FILENAME" \ && echo "$PHP_SHA256_ $PHP_FILENAME" | sha256sum -c - \ && curl -fSL "<http://php.net/get/$PHP_FILENAME.asc/from/this/mirror>" -o "$PHP_FILENAME.asc" \ && export GNUPGHOME="$(mktemp -d)" \ && for key in $GPG_KEYS; do \ gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \ done \ && gpg --batch --verify "$PHP_FILENAME.asc" "$PHP_FILENAME" \ && rm -r "$GNUPGHOME" "$PHP_FILENAME.asc" \ && mkdir -p /usr/src/php \ && tar -xf "$PHP_FILENAME" -C /usr/src/php --strip-components=1 \ && rm "$PHP_FILENAME" \ && cd /usr/src/php \ && ./configure \ --with-config-file-path="$PHP_INI_DIR" \ --with-config-file-scan-dir="$PHP_INI_DIR/conf.d" \ $PHP_EXTRA_CONFIGURE_ARGS \ --disable-cgi \

# --enable-mysqlnd is included here because it's harder to compile after the fact than extensions are (since it's a plugin for several extensions, not an extension in itself)

    --enable-mysqlnd \


# --enable-mbstring is included here because otherwise there's no way to get pecl to use it properly (see <https://github.com/docker-library/php/issues/195>)


    --enable-mbstring \
    --with-curl \
    --with-libedit \
    --with-openssl \
    --with-zlib \
&& make -j"$(nproc)" \
&& make install \
&& { find /usr/local/bin /usr/local/sbin -type f -executable -exec strip --strip-all '{}' + || true; } \
&& make clean \
&& apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false $buildDeps


COPY docker-php-ext-* /usr/local/bin/

## <autogenerated>
</autogenerated>

WORKDIR /var/www/html

RUN set -ex \ && cd /usr/local/etc \ && if [ -d php-fpm.d ]; then \


    # for some reason, upstream's php-fpm.conf.default has "include=NONE/etc/php-fpm.d/*.conf"
    sed 's!=NONE/!=!g' php-fpm.conf.default | tee php-fpm.conf > /dev/null; \
    cp php-fpm.d/www.conf.default php-fpm.d/www.conf; \
else \
    # PHP 5.x don't use "include=" by default, so we'll create our own simple config that mimics PHP 7+ for consistency
    mkdir php-fpm.d; \
    cp php-fpm.conf.default php-fpm.d/www.conf; \
    { \
        echo '[global]'; \
        echo 'include=etc/php-fpm.d/*.conf'; \
    } | tee php-fpm.conf; \
fi \
&& { \
    echo '[global]'; \
    echo 'error_log = /proc/self/fd/2'; \
    echo; \
    echo '[www]'; \
    echo '; if we send this to /proc/self/fd/1, it never appears'; \
    echo 'access.log = /proc/self/fd/2'; \
    echo; \
    echo 'clear_env = no'; \
    echo; \
    echo '; Ensure worker stdout and stderr are sent to the main error log.'; \
    echo 'catch_workers_output = yes'; \
} | tee php-fpm.d/docker.conf \
&& { \
    echo '[global]'; \
    echo 'daemonize = no'; \
    echo; \
    echo '[www]'; \
    echo 'listen = [::]:9000'; \
} | tee php-fpm.d/zz-docker.conf
EXPOSE 9000 CMD ["php-fpm"]
```

- docker build -t php:5.6-fpm .
- docker run -p 9000:9000 --name myphp-fpm -v ~/nginx/www:/www -v $PWD/conf:/usr/local/etc/php -v $PWD/logs:/phplogs -d php:5.6-fpm

## 规范

### PSR0

类的自动加载

* 一个完全标准的命名空间(namespace)和类(class)的结构是这样的：\<Vendor Name>\(<Namespace>\)*<Class Name>
* 每个命名空间(namespace)都必须有一个顶级的空间名(namespace)("组织名(Vendor Name)")。
* 每个命名空间(namespace)中可以根据需要使用任意数量的子命名空间(sub-namespace)。
* 从文件系统中加载源文件时，空间名(namespace)中的分隔符将被转换为 DIRECTORY_SEPARATOR。
* 类名(class name)中的每个下划线_都将被转换为一个DIRECTORY_SEPARATOR。下划线_在空间名(namespace)中没有什么特殊的意义。
* 完全标准的命名空间(namespace)和类(class)从文件系统加载源文件时将会加上.php后缀。
* 组织名(vendor name)，空间名(namespace)，类名(class name)都由大小写字母组合而成。
* 自动加载

```php
function autoload($className)
{
    $className = ltrim($className, '\\');
    $fileName  = '';
    $namespace = '';
    if ($lastNsPos = strrpos($className, '\\')) {
        $namespace = substr($className, 0, $lastNsPos);
        $className = substr($className, $lastNsPos + 1);
        $fileName  = str_replace('\\', DIRECTORY_SEPARATOR, $namespace) . DIRECTORY_SEPARATOR;
    }
    $fileName .= str_replace('_', DIRECTORY_SEPARATOR, $className) . '.php';

    require $fileName;
}
spl_autoload_register('autoload');
```

### PSR4

描述的是通过文件路径自动载入类的指南；它作为对 PSR-0 的补充；根据这个 指导如何规范存放文件来自动载入；

* 术语「类」是一个泛称；它包含类，接口，traits 以及其他类似的结构；
* 完全限定类名应该类似如下范例：<NamespaceName>(<SubNamespaceNames>)*<ClassName>
    - 完全限定类名必须有一个顶级命名空间（Vendor Name）；
    - 完全限定类名可以有多个子命名空间；
    - 完全限定类名应该有一个终止类名；
    - 下划线在完全限定类名中是没有特殊含义的；
    - 字母在完全限定类名中可以是任何大小写的组合；
    - 所有类名必须以大小写敏感的方式引用；
* 当从完全限定类名载入文件时：
    - 在完全限定类名中，连续的一个或几个子命名空间构成的命名空间前缀（不包括顶级命名空间的分隔符），至少对应着至少一个基础目录。
    - 在「命名空间前缀」后的连续子命名空间名称对应一个「基础目录」下的子目录，其中的命名 空间分隔符表示目录分隔符。子目录名称必须和子命名空间名大小写匹配；
    - 终止类名对应一个以 .php 结尾的文件。文件名必须和终止类名大小写匹配；
* 自动载入器的实现不可抛出任何异常，不可引发任何等级的错误；也不应返回值；
* 自动生成的PSR4配置文件名称为autoload_psr4.php（PSR0的是autoload_namespace.php），配置文件返回一个关联数组，键是名称空间的前缀，值是名称空间前缀对应的路径。

## 框架

* 提供了一个用以构建web应用的基本框架，从而简化了用PHP编写web应用程序的流程。
* 不但节省开发时间，有助于建立更稳定的应用，而且减少了重复编码的开发。
* 可以帮助初学者建立更稳定的应用服务，这可以让你花更多的时间去创建实际的Web应用程序，而不是花时间写重复的代码。

### 协程

PHP 最大的优势在于快速开发，劣势在于效率和工程规范。协程、异步这些技术相对学习成本高，优势在于性能提升明显.

## 性能

```sh
time php php-src/Zend/micro_bench.php # 源码自带性能测试
```

## web

* apache
    - module
    - CGI
    - php-fpm

```php
<?php header("Content-type: text/html; charset=utf-8"); ?>
```

## 插件

* PHPDoc
* PHPCS PHP代码规范与质量检查工具

### [PHP_CodeSniffer](https://github.com/squizlabs/PHP_CodeSniffer)

PHP_CodeSniffer tokenizes PHP, JavaScript and CSS files and detects violations of a defined set of coding standards. http://pear.php.net/package/PHP_CodeS…

```sh
curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar
php phpcs.phar -h
curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar
php phpcbf.phar -h

pear install PHP_CodeSniffer

composer global require "squizlabs/php_codesniffer=*"

phpcs /path/to/code/myfile.php
phpcs /path/to/code

/Users/henry/.composer/vendor/bin/phpcs # phpstrom 开启

# vscode
phpcs.enable true
```

### [php-cs-fixer](https://github.com/FriendsOfPHP/PHP-CS-Fixer)

* PHP Code Beautifier and Fixer(phpcbf)

```sh
wget http://cs.sensiolabs.org/download/php-cs-fixer-v2.phar -O php-cs-fixer
wget https://github.com/FriendsOfPHP/PHP-CS-Fixer/releases/download/v2.10.0/php-cs-fixer.phar -O php-cs-fixer
curl -L http://cs.sensiolabs.org/download/php-cs-fixer-v2.phar -o php-cs-fixer

sudo chmod a+x php-cs-fixer
sudo mv php-cs-fixer /usr/local/bin/php-cs-fixer

composer global require friendsofphp/php-cs-fixer
export PATH="$PATH:$HOME/.composer/vendor/bin"
brew install homebrew/php/php-cs-fixer

sudo php-cs-fixer self-update
brew upgrade php-cs-fixer

php php-cs-fixer.phar fix /path/to/dir
php php-cs-fixer.phar fix /path/to/file

phpcs --config-show
phpcs --config-set
```

## 大数据

* 如果你正在做成千上万条查询，看看你能不能先只做几条查询。我之前曾使用一个PHP函数把70000条查询降为十几条查询，这样它的运行时间就从几分钟降到了几分之一秒。
* 在你的查询上运行EXPLAIN，看看你是不是缺少什么索引。我曾经做过一个查询，通过增加了一个索引后效率提高了4个数量级，这没有任何夸张的成分。如果你正在使用MySQL，你可以学学这个，这种“黑魔法”技能会让你和你的小伙伴惊呆的。
* 如果你正在做SQL查询，然后获得结果，并把很多数字弄到一起，看看你能不能使用像SUM（）和AVG（）之类的函数调用GROUP BY语句。跟普遍的情况下，让数据库处理尽量多的计算。我能给你的一点很重要的提示是：（至少在MySQL里是这样）布尔表达式的值为0或1，如果你很有创意的话，你可以使用SUM（）和它的小伙伴们做些很让人惊讶的事情。
* 看看你是不是把这些同样很耗费时间的数字计算了很多遍。例如，假设1000袋土豆的成本是昂贵的计算，但你并不需要把这个成本计算500次，然后才把1000袋土豆的成本存储在一个数组或其他类似的地方，所以你不必把同样的东西翻来覆去的计算。这个技术叫做记忆术，在像你这样的报告中使用往往会带来奇迹般的效果。

## 安全

### cgi.fix_pathinfo

值由1改为0

nginx通过 fastcgi_param 指令将参数传递给 FastCGI Server

* 访问URL：http://phpvim.net/foo.jpg/a.php/b.php/c.php
* 传递给 FastCGI 的 SCRIPT_FILENAME：foo.jpg/a.php/b.php/c.php
* cgi.fix_pathinfo = 1 时，PHP CGI 以 / 为分隔符号从后向前依次检查根目录下如下路径，直到找个某个存在的文件，如果这个文件是个非法的文件
    - foo.jpg/a.php/b.php
    - foo.jpg/a.php
    - foo.jpg
* PHP 会把这个文件当成 cgi 脚本执行，并赋值路径给 CGI 环境变量——SCRIPT_FILENAME，也就是 `$_SERVER['SCRIPT_FILENAME']` 的值了。
    - PHP的cgi SAPI中的参数fix_pathinfo

## 问题

>  5096 segmentation fault (core dumped)  php http_server.php

## 参考

* [Inversion of Control Containers and the Dependency Injection pattern](https://martinfowler.com/articles/injection.html)

$GLOBALS['HTTP_RAW_POST_DATA']
prof
