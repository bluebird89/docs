# PHP

所用的程序是要经过两层代理

* PHP代表HyperText预处理器。
* PHP是一种解释型语言，即不需要编译。
* PHP是一种服务器端脚本语言。
* PHP比其他脚本语言更快,如：Python和asp。
* HTTP协议在Nginx等服务器的解析下
* 再传送给相应的Handler（PHP等）来处理。后端渲染，默认html处理，模版文件以.php后缀
* 服务端脚本程序，只能通过服务器访问，需要配置虚拟主机调试

## 安装

### windows

下载PHP安装包，解压即可

```bash
./php.exe -f e:\www\test.php # 不一定非php扩展名文件
php.exe -v
php.exe -i # 运行phpinfo()函数
php.exe -m # 显示已经加载了那些module
php -a # 进入命令行模式
```

### Mac

* 程序路径：`/usr/local/Cellar/php71/7.1.12_23`
* 配置路: `/usr/local/etc/php/7.1/php.ini`
* control script:/usr/local/opt/php71/sbin/php71-fpm

```sh
brew install php71
brew info php71

## 配置文件添加扩展
include=/usr/local/etc/php/7.1/conf.d/*.ini

mkdir -p ~/Library/LaunchAgents
cp /usr/local/opt/php71/homebrew.mxcl.php71.plist ~/Library/LaunchAgents/
launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.php71.plist

sudo brew services start/stop/restart php71
```

### linux源码安装

```sh
lsb_release -a # 系统环境查看

yum -y install make apr* autoconf automake curl-devel gcc gcc-c++ zlib-devel openssl openssl-devel pcre-devel gd # 编译环境的准备

yum install -y vsftpd # ftp环境的搭建(使用 非root 用户后，在ftp客户端上传相关的源码
useradd asion
service vsftpd status

libxml2 # libxml2 安装(xml和html文件相关依赖的库)
tar -zxvf libxml2-2.6.30
cd libxml2-2.6.30
./configure --prefix=/usr/local/libxml2 
make && make install

cd /lamp/libmcrypt-2.5.8 # libmcrypt-2.5.8 安装(加密库)
./configure --prefix=/usr/local/libmcrypt/ 
make && make install
# 进入libmcrypt-2.5.8文件夹内的 
libltdl > cd ./libmcrypt-2.5.8/libltdl
./configure --enable-ltdl-install
make && make install
# zlib库安装
./configure
make && make install
# png图片库安装
./configure --prefix=/usr/local/libpng/ 
make && make install
# jpeg图片库安装(需要自己创建jpeg6)
mkdir /usr/local/jpeg6
mkdir /usr/local/jpeg6/bin
mkdir /usr/local/jpeg6/lib
mkdir /usr/local/jpeg6/include
mkdir -p /usr/local/jpeg6/man/man1 
cd /lamp/jpeg-6b
./configure --prefix=/usr/local/jpeg6/ --enable-shared --enable-static 
make && make install
# freetype字体库安装
./configure --prefix=/usr/local/freetype/
make && make install
# autoconfig生成makefile安装(不需要指定安装路径) 
./configure
make && make install
# GD 库 的 安 装
./configure --prefix=/usr/local/gd2/ --with-jpeg=/usr/local/jpeg6/ --with-freetype=/usr/local/freetype/ --enable
make && make install
# 注意:当make的时候，出现以下错误
configure.ac:64: error: possibly undefined macro: AM_ICONV
If this token and others are legitimate, please use m4_pattern_allow. See the Autoconf documentation.
make: *** [configure] Error 1
# 解决方案:解决办法 ，编译加m4_pattern_allow参数 即:./configure --enable-m4_pattern_allow 便能顺利编译安装

# 安装PHP
cd /usr/local/src/php-5.3.28
./configure --prefix=/usr/local/php/ --with-config-file-path=/usr/local/php/etc/ --with-apxs2=/usr/local/apache2/bin/apxs --with-my make
make install
cp php.ini-dist /usr/local/php/etc/php.ini

# 打开Apache的配置文件(添加AddType这两行)
cd /etc/httpd/
vim httpd.conf
AddType application/x-httpd-php .php
AddType application/x-httpd-source .phps

cd /usr/local/php/etc/
vim php.ini
date.timezone = Asia/Shanghai
```

## [PHP发展](https://segmentfault.com/a/1190000008888700)

* composer:PHP 的依赖管理可以变得非常简单
* PHP7:对 Zend 引擎做了大量修改，大幅提升了 PHP 语言的性能.做好 MySQL 优化，使用 Memcache 和 Redis 进行加速
* [PSR](http://www.php-fig.org/)组织制定的PHP语言开发规范，约定了很多方面的规则，如命名空间、类名 规范、编码风格标准、Autoload、公共接口等
* Swoole:Swoole 是一个异步并行的通信引擎，作为 PHP 的扩展来运行。Node.js 的异步回调 Swoole 有，Go语言的协程 Swoole 也有，这完全颠覆了对 PHP 的认知.使用 Swoole PHP 可以实现常驻内存的 Server 程序，可以实现 TCP 、 UDP 异步网络通信的编程开发。比如 WebSocket 即使通信、聊天、推送服务器、RPC 远程调用服务、网关、代理、游戏服务器等。
* Laravel:社区非常活跃，代码贡献者众多，第三方的插件非常多，生态系统相当繁荣。 Laravel 底层使用了很多 symfony2 组件，通过 composer 实现了依赖管理。Laravel 提供的命令行工具基于 symfony.console 实现，功能强大，集成了各种项目管理、自动生成代码的功能。
* PHP5.3 之后支持了类似 Java 的 jar 包，名为 phar。用来将多个 PHP 文件打包为一个文件。这个特性使得 PHP 也可以像 Java 一样方便地实现应用程序打包和组件化。一个应用程序可以打成一个 Phar 包，直接放到 PHP-FPM 中运行。配合 Swoole ，可以在命令行下执行 php server.phar 一键启动服务器。PHP 的代码包可以用 Phar 打包成组件，放到 Swoole 的服务器容器中去加载执行。
* PHP 作为一门动态脚本语言，优点是开发方便效率高。缺点就是性能差。在密集运算的场景下比 C 、 C++ 相差几十倍甚至上百倍。另外 PHP 不可以直接操作底层，需要依赖扩展库来提供 API 实现。PHP 程序员可以学习一门静态编译语言作为补充实现动静互补，C/C++/Go 都是不错的选择。而且静态语言的编程体验与动态语言完全不同，学习过程可以让你得到更大的提升。 掌握 C/C++ 语言后，还可以阅读 PHP 、 Swoole 、 Nginx 、Redis 、 Linux内核 等开源软件的源码，了解其底层运行原理。 现在最新版本的Swoole提供了C++扩展模块的支持，封装了Zend API，用C++操作PHP变得很简单，可以用C++实现PHP扩展函数和类。
* HTML5
* Vue.js 可以非常方便地实现数据和 DOM 元素的绑定。通过 Ajax 请求后台接口返回数据后，更新前端数据自动实现界面渲染。
* React Native 是一个不错的选择
* 深度学习/人工智能:自动驾驶、大数据分析、网络游戏、图像识别、语言处理等。当然现在普通的工程师可能还无法参与到人工智能产品中，但至少应该理解深度学习/人工智能的基本概念和原理。
* PHP
    * 7.1 :2015.12.3 性能提升
    * 7.2 JIT(JUST_IN_TIME)

## CGI vs CLI


### 包管理工具

* [PECL](http://pecl.php.net/)：PHP Extension Community Library，管理着最底层的PHP扩展。这些扩展是用 C 写的。
* [PEAR](http://pear.php.net/)：PHP Extension and Application Repository，管理着项目环境的扩展。用 PHP 写的。
* Composer：和PEAR都管理着项目环境的依赖，这些依赖也是用 PHP 写的，区别不大。但 composer 却比 PEAR 来的更受欢迎

```sh
curl -O http://pear.php.net/go-pear.phar
sudo php -d detect_unicode=0 go-pear.phar

# 4 修改bin路径
# pear version
```
## 语法

### 基础

* PHP代码的标记：<?php …… ?>
* PHP文件的扩展名：.php
* PHP中每行程序代码，必须以英文下的分号(;)结束。而JS中分号可以省略。
* PHP程序区分大小写的，但函数名和关键字不区分大小写。如：if、break、switch
* 访问PHP文件，必须要经过服务器，或者以域名开头来访问。如：http://www.2015.com/test.php
* PHP文件及路径上不能包括中文或空格。
* 单行注释：//、#
* 多行注释：/* …… */
* 变量：临时存储数据的容器，指向值的指针。保存数据内存位置的名称。 变量是用于保存临时数据的临时存储
    - 变量的名称，可以包含：字母、数字、下划线。
    - 变量的名称，不能以数字和特殊符号开头，但可以以字母或下划线开头。如：$_ABC、$abc
    - 变量名称前必须要带“$”符号。“$”不是变量名称一部分，它只是对变量名称的一个引用或标识符。
    - 变量名称区分大小写。如：$name和$Name是两个变量
    - 对于由几个单词构成的变量名称的命名规则
        + “驼峰式”命名：$getUserName、$getUserPwd
        + “下划线”命名：$get_user_name、$set_user_pwd
    - 赋值：$variablename指向value存储的地址
    - `$$var`是一个引用变量，用于存储$var的值
* 常量
    - define()函数：define(name, value, case-insensitive = false) 区分大小写
    - const关键字在编译时定义常量。 它是一个语言构造不是一个函数。比define()快一点，因为它没有返回值。它总是区分大小写的
    - 魔术常量
        + __LINE__  表示使用当前行号。
        + __FILE__    表示文件的完整路径和文件名。 如果它在include中使用，则返回包含文件的名称。
        + __DIR__ 表示文件的完整目录路径。 等同于dirname(__file__)。 除非它是根目录，否则它没有尾部斜杠。 它还解析符号链接。
        + __FUNCTION__    表示使用它的函数名称。如果它在任何函数之外使用，则它将返回空白。
        + __CLASS__   表示使用它的函数名称。如果它在任何函数之外使用，则它将返回空白。
        + __TRAIT__   表示使用它的特征名称。 如果它在任何函数之外使用，则它将返回空白。 它包括它被声明的命名空间。
        + __METHOD__  表示使用它的类方法的名称。方法名称在有声明时返回。
        + __NAMESPACE__   表示当前命名空间的名称。

```php
$variablename = value;

define("MESSAGE","Hello YiiBai PHP");
const MESSAGE="Hello const by YiiBai PHP";
```

### 控制语句

* echo：是一个语言结构(语句)，不是一个函数，所以不需要使用括号。但是如果要使用多个参数，则需要使用括号。打印字符串，多行字符串，转义字符，变量，数组等。
* print
* 嵌套的使用：执行在内还是在外
* 条件
    - if
    - if-else
    - if-else-if
    - 嵌套if
    - switch语句
* 循环
    - for语句
    - foreach循环循环用于遍历数组元素
    - while
    - do...while
* break:中断了当前for，while，do-while，switch和for-each循环的执行。 如果在内循环中使用break，它只中断了内循环的执行。
* continue:

```php
#!/usr/bin/env php
print "Hello, Red Hat Developers World from PHP " . PHP_VERSION . "\n";
echo "<h2>Hello First PHP</h2>";

$num=12;  
if($num<100){  
    echo "$num is less than 100";  
}

if($num%2==0){  
    echo "$num is even number";  
}else{  
    echo "$num is odd number";  
}

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
foreach( $season as $arr ){  
    echo "Season is: $arr<br />";  
}

$n=1;  
while($n<=10){  
    echo "$n<br/>";  
    $n++;  
}

$n=1;  
do{  
    echo "$n<br/>";  
    $n++;  
}while($n<=10);

for($i=1;$i<=10;$i++){  
    echo "$i <br/>";  
    if($i==5){  
        break;  
    }  
}
```

### 数据类型

变量本身没有类型之说，所说的类型是指变量中，存储的数据的类型。

* 标量类型
    - 布尔型
    - 字符串型
        + 单引号PHP字符串中，大多数转义序列和变量不会被解释。 可以使用单引号\'反斜杠和通过\\在单引号引用PHP字符串。
        + 双引号的PHP字符串中存储多行文本，特殊字符和转义序列
    - 整型
    - 浮点型
* 复合类型
    - 数组
        + 索引数组
        + 关联数组
        + 多维数组
    - 对象
* 特殊类型
    - NULL:unset() 与 NULL：删除引用，触发相应变量容器refcount减一，但在函数中的行为会依赖于想要销毁的变量的类型而有所不同，比如unset 一个全局变量，则只是局部变量被销毁，而在调用环境中的变量(包括函数参数引用传递的变量)将保持调用 unset 之前一样的值；unset 变量与给变量赋值NULL不同，变量赋值NULL直接对相应变量容器refcount = 0
    - 资源

```php
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

$str='Hello text within single quote';
$str2="Using double \"quote\" with backslash inside double quoted string"; 

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
```

#### 运算符

用于对操作数执行操作

* 算术运算符:`* / % + - `
* 比较运算符:`< <= > >= == != === !== <>`
* 按位运算符:`<< >>`
* 逻辑运算符:`&& || and xor or !`
* 字符串运算符:`.`
* 递增/递减运算符
* 数组运算符
* 类型运算符:`instanceof (int) (float) (string) (array) (object) (bool)`
* 执行操作符
* 错误控制操作符
* 分配操作符:`= += -= *= **= /= .= %= &= ^= <<= >>= =>`
* 位运算符：`& ^ |`
* 三元运算符：`?:`

```php
clone new
```

#### 杂项

* 数学函数
* 表单处理:post get提交请求
* 包含文件
    - 用于包含基于给定路径的文件。 可以使用文件的相对路径或绝对路径
    - 文件丢失时包含的处理方式：include语句允许脚本继续，但require语句暂停脚本产生致命的E_COMPILE_ERROR级别错误。
* json
    - json_encode()函数返回值JSON的表示形式：它将PHP变量(包含数组)转换为JSON格式数据。
    - json_decode()函数解码JSON字符串：将JSON字符串转换为PHP变量。
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
    - 引用调用:要传递值作为参考(引用)，您需要在参数名称前使用＆符号(&)。
    - 值调用:传递给函数的值默认情况下不会修改实际值(通过值调用),传递给函数的值是通过值调用。作用域函数范围内
    - 默认参数
    - 可变长度参数函数
* 返回值
* 递归函数

addslashes函数转义风险：对于URL参数arg = %df\'在经过addslashes转义后在GBK编码下arg = 運'
urldecode函数解码风险：对于URL参数uid = 1%2527在调用urldecode函数解码(二次解码)后将变成uid = 1'

```php
function sayHello(){  
    echo "Hello PHP Function";  
}  
sayHello();//calling function

function sayHello($name,$age = 28){  
echo "Hello $name, you are $age years old<br/>";  
}  
sayHello("Maxsu",27);  
sayHello("Minsu",26);  
sayHello("John",23);
sayHello("Henry");

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

### MySQL

PHP 5.5以来，mysql_connect()扩展已被弃用。 现在，建议使用以下2种替代方法之一。

* mysqli_connection()
* PDO::__ construct()

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

### 面向对象(OOP)

继承：类分层、接口分层 
实现：类实现接口 
依赖：类作为另一个类方法的参数 
关联：类属性 
聚合：可以有 
组合：必须有

#### 对象

对象是一堆属性组成。对象在底层的实现。采取属性数组+方法数组来实现的。对象在zend中的定义是使用了一种zend_object_value结构体来存储的，这个结构体包含：

* 一个指针，也就是说明这个对象由哪个类实现出来的，这个类在哪里。
* 这个对象的属性。
* guards,阻止递归调用的。

对象的方法不会存在对象里面，要使用对象的方法，实际上是通过指针找到这个类，再用这个类里面的方法来执行的。（通过类序列化检测）

延迟绑定：之类重写父类方法，其它调用该方法时用static而非self

- PHP异步调用
- 正则匹配src标签
- 处理回文字符

#### 访问控制(可见性)

* public表明类成员在任何地方可见
* protected表明类成员在其自身、子类和父类内可见
* private表明类成员只对自己可见。
* 对于private和protected有个特例，同一个类的对象即使不是同一个实例也可以互相访问对方的私有与受保护成员

范围解析符(::)：通常以self::、 parent::、 static:: 和 <classname>::形式来访问静态成员、类常量，另外，static::、self:: 和 parent:: 还可用来调用类中的非静态方法。类中实例话自己

* self
* parent
* static:调用类里面的方法

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

#### trait

为了避免代码重复而生,既可以实现代码分离又可以不用在逻辑层做任何处理

```php
Trait OwnerTrait{
    public function owner(){
        var_dump('comment owner');
    }
}

class Comment{
    use OwnerTrait;
}
//(new Comment())->owner();
// 或者以下两行代码是一样的效果
$comment = new Comment();
$comment->owner();
```

优先级:从基类继承的成员会被 trait 插入的成员所覆盖。优先顺序是来自当前类的成员覆盖了 trait 的方法，而 trait 则覆盖了被继承的方法。

#### 接口与抽象类

* 接口中的每个方法，继承类里面都要去实现 2.接口中的方法后面不要跟大口号{},因为接口只是定义需要有这个函数，并不是自己去实现 3.抽象类中 abstract 的方法，继承类里面都要去实现，也可以理解成接口中的每个方法都是 abstract 方法 4.抽象方法中没有abstract 的方法，继承类不必非要写那个方法

举例,场景：我们在记录日志的时候，有时候可能需要写入文件，有时候可能写入数据库 这时候，我们可以写一个Log接口，定义需要的方法 然后分别写一个FileLog类和一个DatabaseLog类 然后我们写一个UsersController类做一个依赖注入，这样我们需要使用哪种方式写日志，实例化的时候，注入哪种类即可

* 抽象类定义要使用abstract关键字来声明，凡是用abstract关键字定义了抽象方法的类必须声明为抽象类。另外，子类实现抽象方法时访问控制必须和父类中一样（或者更为宽松），同时调用方式必须匹配，即类型和所需参数数量必须一致；
* 接口是通过interface关键字来定义的，但其中定义所有的方法都是空的，访问控制必须是public。另外，接口可以如类一样定义常量，可以使用extends来继承其他接口；
* 抽象类可用于对多个同构类的通用部分定义，用extends关键字继承(父子间存在"is a"关系)，属单继承。接口可用于多个异构类的通用部分定义，用implements关键字继承(父子间存在"like a"关系)，可多继承。如果子类不能实现父类或接口的全部抽象方法，则该子类只能被声明成抽象类。

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

## 扩展

* intl
* mcrypt
* memeache
* memeached
    - memcache完全在PHP框架内开发的，提供了memcached的接口，memecached扩展是使用了libmemcached库提供的api与memcached服务端进行交互。 libmemcached 是 memcache 的 C 客户端，它具有低内存，线程安全等优点
    - memcache提供了面向过程及面向对象的接口，memached只支持面向对象的接口。 memcached 实现了更多的 memcached 协议。
    - memcached 支持 Binary Protocol，而 memcache 不支持，意味着 memcached 会有更高的性能。不过，还需要注意的是，memcached 目前还不支持长连接。
* mongo
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
* phpredis
* PHP-FPM进程池：FastCGI Process Manager 的master process是常驻内存的，以static、dynamic、ondemand三种方式来管理进程池中的worker process，可以有效控制内存和进程并平滑重载PHP配置，在发生意外情况的时候能够重新启动并恢复被破坏的 opcode。
```sh
brew tap homebrew/homebrew-php
brew install php71 --with-pear

brew install mcrypt
```


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

## 说明

* PHP5.5之后废弃mysql扩展

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

## 源码

* [php/php-src](https://github.com/php/php-src):The PHP Interpreter <http://www.php.net>
* [facebook/hhvm](https://github.com/facebook/hhvm):A virtual machine designed for executing programs written in Hack and PHP. <http://hhvm.com>

## 框架

* [pinguo/php-msf](https://github.com/pinguo/php-msf)PHP微服务框架即"Micro Service Framework For PHP"，是Camera360社区服务器端团队基于Swoole自主研发现代化的PHP协程服务框架，简称msf或者php-msf，是Swoole的工程级企业应用框架，经受了Camera360亿级用户高并发大流量的考验
* [Youzan Zan Php Installer](https://github.com/youzan/zan-installer)Youzan Zan Php Installer
* [tencent-php/tsf](https://github.com/tencent-php/tsf):coroutine and Swoole based php server framework in tencent
* [slimphp/Slim](https://github.com/slimphp/Slim):Slim Framework source code <http://slimframework.com>
* [nette/nette](https://github.com/nette/nette):METAPACKAGE for Nette Framework components https://nette.org
* [Tencent/Biny](https://github.com/Tencent/Biny):Biny is a tiny, high-performance PHP framework for web applications
* [reactphp/react](https://github.com/reactphp/react):Event-driven, non-blocking I/O with PHP. https://reactphp.org

### 论坛

- [flarum/flarum](https://github.com/flarum/flarum):Delightfully simple forum software. <http://flarum.org>

### 电商

- [magento/magento2](https://github.com/magento/magento2): a cutting edge, feature-rich eCommerce solution that gets results.

### CMS

* [bolt/bolt](https://github.com/bolt/bolt):Bolt is a simple CMS written in PHP. It is based on Silex and Symfony components, uses Twig and either SQLite, MySQL or PostgreSQL.

### Wiki

* [MediaWiki](https://www.mediawiki.org/wiki/MediaWiki)

## 扩展

* [PHP 开发者如何做代码审查?](http://blog.csdn.net/gitchat/article/details/78050953)
* [thephpleague/glide](https://github.com/thephpleague/glide):Wonderfully easy on-demand image manipulation library with an HTTP based API. <http://glide.thephpleague.com>
* [dompdf/dompdf](https://github.com/dompdf/dompdf):HTML to PDF converter (PHP5) <http://dompdf.github.com/>
* [PHPOffice/PHPExcel](https://github.com/PHPOffice/PHPExcel):A pure PHP library for reading and writing spreadsheet files
* [briannesbitt/Carbon](https://github.com/briannesbitt/Carbon):A simple PHP API extension for DateTime. <http://carbon.nesbot.com/>
* [Intervention/image](https://github.com/Intervention/image):PHP Image Manipulation <http://image.intervention.io>
* [fzaninotto/Faker](https://github.com/fzaninotto/Faker):Faker is a PHP library that generates fake data for you
* [guzzle/guzzle](https://github.com/guzzle/guzzle):Guzzle, an extensible PHP HTTP client <http://guzzlephp.org/>
* [reactphp/react](https://github.com/reactphp/react):Event-driven, non-blocking I/O with PHP. <https://reactphp.org>
* [CopernicaMarketingSoftware/PHP-CPP](https://github.com/CopernicaMarketingSoftware/PHP-CPP):Library to build PHP extensions with C++ <http://www.php-cpp.com/>
* [nikic/PHP-Parser](https://github.com/nikic/PHP-Parser):A PHP parser written in PHP
* [jenssegers/laravel-mongodb](https://github.com/jenssegers/laravel-mongodb#installation):A MongoDB based Eloquent model and Query builder for Laravel (Moloquent) https://jenssegers.com
* [youzan/php-co-koa](https://github.com/youzan/php-co-koa)PHP异步编程: 手把手教你实现co与Koa
* [youzan/zan](https://github.com/youzan/zan)高效稳定、安全易用、线上实时验证的全异步高性能网络库，通过PHP扩展方式使用。
* [HanSon/youzan-sdk](https://github.com/HanSon/youzan-sdk)有赞 SDK
* [hprose/hprose-php](https://github.com/hprose/hprose-php)Hprose is a cross-language RPC
* [swoole/php-cp](https://github.com/swoole/php-cp)
* [thephpleague/omnipay](https://github.com/thephpleague/omnipay):A framework agnostic, multi-gateway payment processing library for PHP 5.3+ http://omnipay.thephpleague.com/
* [thephpleague/flysystem](https://github.com/thephpleague/flysystem):Abstraction for local and remote filesystems http://flysystem.thephpleague.com
* [thephpleague/oauth2-server](https://github.com/thephpleague/oauth2-server):A spec compliant, secure by default PHP OAuth 2.0 Server https://oauth2.thephpleague.com
* [thephpleague/fractal](https://github.com/thephpleague/fractal):Output complex, flexible, AJAX/RESTful data structures. http://fractal.thephpleague.com
* [thephpleague/oauth2-client](https://github.com/thephpleague/oauth2-client):Easy integration with OAuth 2.0 service providers. http://oauth2-client.thephpleague.com
* [thephpleague/climate](https://github.com/thephpleague/climate):PHP's best friend for the terminal. http://climate.thephpleague.com
* [thephpleague/csv](https://github.com/thephpleague/csv):CSV data manipulation made easy in PHP https://csv.thephpleague.com
* [thephpleague/glide](https://github.com/thephpleague/glide):Wonderfully easy on-demand image manipulation library with an HTTP based API. http://glide.thephpleague.com
* [thephpleague/skeleton](https://github.com/thephpleague/skeleton):A skeleton repository for League Packages http://thephpleague.com
* [KnpLabs/php-github-api](https://github.com/KnpLabs/php-github-api):A simple PHP GitHub API client, Object Oriented, tested and documented. For 5.5+.
* [twigphp/Twig](https://github.com/twigphp/Twig):Twig, the flexible, fast, and secure template language for PHP http://twig.sensiolabs.org/
* [smarty-php/smarty](https://github.com/smarty-php/smarty)

## 社区

- [coffeephp](http://coffeephp.com/)
- [fukuball/Awesome-Laravel-Education](https://github.com/fukuball/Awesome-Laravel-Education)

## 参考

- [codeguy/php-the-right-way](https://github.com/codeguy/php-the-right-way):An easy-to-read, quick reference for PHP best practices, accepted coding standards, and links to authoritative tutorials around the Web <http://www.phptherightway.com>
- [walu/phpbook](https://github.com/walu/phpbook):PHP扩展开发及内核应用
- [laruence/php7-internal](https://github.com/laruence/php7-internal):Understanding PHP7 Internal articles
- [PHP 教程](http://www.w3school.com.cn/php/)
- [Awesome PHP](http://coffeephp.com/resources)
- [ziadoz/awesome-php](https://github.com/ziadoz/awesome-php):A curated list of amazingly awesome PHP libraries, resources and shiny things.
- [DesignPatternsPHP](https://github.com/domnikl/DesignPatternsPHP)
- [PHP Best Practices](https://phpbestpractices.org)

## 工具

* [cytopia/docker-php-fpm-7.2](https://github.com/cytopia/docker-php-fpm-7.2):PHP-FPM 7.2 on CentOS 7 http://devilbox.org/
* [travis-ci-examples/php](https://github.com/travis-ci-examples/php):Example PHP project using Travis CI http://travis-ci.org

## 图书

* [PHP: The Right Way](http://www.phptherightway.com/)
* [reeze/tipi](https://github.com/reeze/tipi):Thinking In PHP Internals, An open book on PHP Internals http://www.php-internals.com/
* Morden php
* https://www.phparch.com/magazine/


* Composer包 Composer Repositories
      - [Firegento](http://packages.firegento.com):Magento Module Composer Repository.
      - [Packagist](https://packagist.org):The PHP Package Repository.
      - [PaketHub](https://pakethub.com):All-in-One PHP Package Repository.
      - [Private Packagist](https://packagist.com):Composer package archive as a service for PHP.
      - [WordPress Packagist](https://wpackagist.org):Manage your plugins with Composer.
* 依赖管理 Dependency Management 依赖和包管理库
      - [Composer Installers](https://github.com/composer/installers): 一个多框架Composer库安装器
      - [Composer](https://getcomposer.org/)
      - [Melody](http://melody.sensiolabs.org/): 一个用于构建Composer脚本文件的工具
      - [Pickle](https://github.com/FriendsOfPHP/pickle): 一个PHP扩展安装器
* 其他的依赖管理 Dependency Management Extras
      - [Composed](https://github.com/joshdifabio/composed): 一个在运行时解析你项目Composer环境的库
      - [Composer Checker](https://github.com/silpion/composer-checker): 一个校验Composer配置的工具
      - [Composer Merge Plugin](https://github.com/wikimedia/composer-merge-plugin): 一个用于合并多个composer.json文件的Composer插件
      - [Composition](https://github.com/bamarni/composition): 一个在运行时检查Composer环境的库
      - [NameSpacer](https://github.com/ralphschindler/Namespacer): 一个转化下划线到命名空间的库
      - [Patch Installer](https://github.com/goatherd/patch-installer): 一个使用Composer安装补丁的库
      - [Prestissimo](https://github.com/hirak/prestissimo): 一个开启并行安装进程的Composer插件
      - [Satis](https://github.com/composer/satis): 一个静态Composer存储库的生成器
      - [tooly](https://github.com/tommy-muehle/tooly-composer-script): 一个在项目中使用Composer管理PHAR文件的库
      - [Toran Proxy](https://toranproxy.com): 一个静态Composer存储库和代理
* 框架 FrameworksWeb开发框架
      - [Aura PHP](http://auraphp.com/): 一个独立的组件框架
      - [CakePHP](https://cakephp.org/): 一个快速应用程序开发框架 (CP)
      - [Laravel 5](https://laravel.com/): 另一个PHP框架 (L5)
      - [Nette](https://nette.org): 另一个由个体组件组成的框架
      - [Phalcon](https://phalconphp.com/en/): 通过C扩展实现的框架
      - [PPI Framework 2](http://www.ppi.io): 一个互操作性框架
      - [Symfony](https://symfony.com/): 一个独立组件组成的框架 (SF)
      - [Yii2](https://github.com/yiisoft/yii2/): 另一个PHP框架
      - [Zend Framework 2](https://framework.zend.com): 另一个由独立组件组成的框架 (ZF2)
      - [Radar](https://github.com/radarphp/Radar.Adr): 一个基于PHP的Action-Domain-Responder实现
      - [Ice](https://www.iceframework.org/): 另一个通过C扩展实现的简单快速的PHP框架
* 其他框架 Framework Extras 其他Web开发框架
      - [CakePHP CRUD](https://github.com/friendsofcake/crud): CakePHP的快速应用程序（RAD）插件
      - [Knp RAD Bundle](http://rad.knplabs.com/): Symfony 2的快速应用程序（RAD）包
      - [Symfony CMF]:(https://github.com/symfony-cmf/symfony-cmf) 一个创建自定义CMS的内容管理框架
* 框架组件 Components 来自web开发框架的独立组件
      - [CakePHP Plugins](https://plugins.cakephp.org/): CakePHP插件的目录
      - [Hoa Project](https://hoa-project.net/En/): 另一个PHP组件包
      - [League of Extraordinary Packages](https://thephpleague.com/): 一个PHP软件开发组
      - [Symfony Components](http://symfony.com/doc/master/components/index.html): Symfony组件
      - [Zend Framework 2 Components](https://packages.zendframework.com/): Zend Framework 2组件
* 微型框架 Micro Frameworks 微型框架和路由
      - [Bullet PHP](http://bulletphp.com/): 用于构建REST APIs的微型框架
      - [Lumen](https://lumen.laravel.com): 一个Laravel的微型框架
      - [Proton](https://github.com/alexbilbie/Proton): 一个StackPHP兼容的微型框架
      - [Silex](http://silex.sensiolabs.org/): 基于Symfony2组件的微型框架
      - [Slim](https://www.slimframework.com/): 另一个简单的微型框架
* 其他微型框架 Micro Framework Extras 其他相关的微型框架和路由
      - [Silex Skeleton](https://github.com/silexphp/Silex-Skeleton): Silex的项目架构
      - [Silex Web Profiler](https://github.com/silexphp/Silex-WebProfiler): 一个Silex web的调试工具
      - [Slim Skeleton](https://github.com/slimphp/Slim-Skeleton): Slim架构
      - [Slim View](https://github.com/slimphp/Slim-Views): Slim自定义视图的集合
* 路由 Routers 处理应用路由的库
      - [Fast Route](https://github.com/nikic/FastRoute): 一个快速路由的库
      - [Klein](https://github.com/klein/klein.php): 一个灵活的路由的库
      - [Pux](https://github.com/c9s/Pux): 另一个快速路由的库
      - [Route](https://github.com/thephpleague/route): 一个基于Fast Route的路由的库
* 模板 Templating 模板化和词法分析的库和工具
      - [Foil](https://github.com/FoilPHP/Foil): 另一个原生PHP模板库
      - [Lex](https://github.com/pyrocms/lex): 一个轻量级模板解析器
      - [MtHaml](https://github.com/arnaud-lb/MtHaml): 一个HAML模板语言的PHP实现
      - [Mustache](https://github.com/bobthecow/mustache.php): 一个Mustache模板语言的PHP实现
      - [Phly Mustache](https://github.com/phly/phly_mustache): 另一个Mustache模板语言的PHP实现
      - [PHPTAL](http://phptal.org/): 一个模板语言的PHP实现
      - [Plates](http://platesphp.com/): 一个原生PHP模板库
      - [Smarty](http://www.smarty.net/): 一个模板引擎
      - [Twig](http://twig.sensiolabs.org/): 一个全面的模板语言
      - [Tale Jade](https://github.com/Talesoft/tale-jade): Jade模版语言的PHP实现
      - [doctrine2](https://github.com/doctrine/doctrine2):http://docs.doctrine-project.org/projects/doctrine-orm/en/latest/index.html
* 静态站点生成器 Static Site Generators 用来生成web页面的预处理内容的工具
      - [Couscous](http://couscous.io): 一个将Markdown转化为漂亮的网站的工具
      - [Phrozn](https://github.com/Pawka/phrozn): 另一个转换Textile，Markdown和Twig为HTML的工具
      - [Sculpin](https://sculpin.io): 转换Markdown和Twig为静态HTML的工具
      - [Spress](http://spress.yosymfony.com): 一个能够将Markdown和Twig转化为HTML的可扩展工具
* 超文本传输协议 HTTP 用于HTTP的库
      - [Buzz](https://github.com/kriswallsmith/Buzz): 另一个HTTP客户端
      - [Guzzle](https://github.com/guzzle/guzzle): 一个全面的HTTP客户端
      - [HTTPFul](https://github.com/nategood/httpful): 一个链式HTTP库
      - [PHP VCR](http://php-vcr.github.io/): 一个录制和重放HTTP请求的库
      - [Requests](https://github.com/rmccue/Requests): 一个简单的HTTP库
      - [Retrofit](https://github.com/tebru/retrofit-php): 一个能轻松创建REST API客户端的库
      - [zend-diactoros](https://github.com/zendframework/zend-diactoros): PSR-7 HTTP消息实现
* 爬虫 Scraping 用于网站爬取的库
      - [Embed](https://github.com/oscarotero/Embed):  一个从web服务或网页中提取的信息的工具
      - [Goutte](https://github.com/FriendsOfPHP/Goutte): 一个简单的web爬取器
      - [PHP Spider](https://github.com/mvdbos/php-spider): 一个可配置和可扩展的PHP web爬虫
* 中间件 Middlewares 使用中间件构建应用程序的库
      - [Expressive](https://zendframework.github.io/zend-expressive/): 基于PSR-7的Zend中间件
      - [PSR7-Middlewares](https://github.com/oscarotero/psr7-middlewares): 灵感来源于方便的中间件
      - [Relay](https://github.com/relayphp/Relay.Relay): 一个PHP 5.5 PSR-7的中间件调度器
      - [Stack](https://github.com/stackphp): 一个用于Silex/Symfony的可堆叠的中间件的库
      - [zend-stratigility](https://github.com/zendframework/zend-stratigility): 基于PHP PSR-7之上的中间件之上
* 网址 URL 解析URL的库
      - (https://github.com/jeremykendall/php-domain-parser)[PHP Domain Parser]: 一个本地前缀解析库
      - (https://github.com/jwage/purl)[Purl]: 一个URL处理库
      - (https://github.com/fruux/sabre-uri)[sabre/uri]: 一个URI操作库
      - (https://github.com/thephpleague/uri)[Uri]: 另一个URL处理库
* 电子邮件 Email 发送和解析邮件的库
      - (https://github.com/tijsverkoyen/CssToInlineStyles)[CssToInlineStyles]: 一个在邮件模板中的内联CSS库
      - (https://github.com/willdurand/EmailReplyParser)[Email Reply Parser]: 一个邮件回复解析的库
      - (https://github.com/nojacko/email-validator)[Email Validator]: 一个较小的电子邮件验证库
      - (https://github.com/tedious/Fetch)[Fetch]: 一个IMAP库
      - (https://github.com/mautic/mautic)[Mautic]: 邮件营销自动化
      - (https://github.com/PHPMailer/PHPMailer)[PHPMailer]: 另一个邮件解决方案
      - (https://github.com/henrikbjorn/Stampie)[Stampie]: 一个邮件服务库，类似于[SendGrid](http://sendgrid.com)[PostMark](https://postmarkapp.com),[MailGun](http://www.mailgun.com)[Mandrill](http://www.mandrill.com)
      - (http://swiftmailer.org/)[SwiftMailer]: 一个邮件解决方案
* 文件 Files 文件处理和MIME类型检测的库
      - (https://github.com/dflydev/dflydev-apache-mime-types)[Apache MIME Types]: 一个解析Apache MIME类型的库
      - (https://github.com/dflydev/dflydev-canal)[Canal]: 一个检测互联网媒体类型的库
      - (https://github.com/thephpleague/csv)[CSV]: 一个CSV数据处理库
      - (https://github.com/versionable/Ferret)[Ferret]: 一个MIME检测库
      - (https://github.com/thephpleague/Flysystem)[Flysystem]: 另一个文件系统抽象层
      - (https://github.com/KnpLabs/Gaufrette)[Gaufrette]: 一个文件系统抽象层
      - (https://github.com/hoaproject/Mime)[Hoa Mime]: 另一个MIME检测库
      - (https://github.com/henrikbjorn/Lurker)[Lurker]: 一个资源跟踪库
      - (https://github.com/PHP-FFmpeg/PHP-FFmpeg/)[PHP FFmpeg]: 一个用于[FFmpeg](http://www.ffmpeg.org/)视频包装的库
      - (https://github.com/wapmorgan/UnifiedArchive)[UnifiedArchive]: 一个统一标准的压缩和解压的库
* 流 Streams 处理流的库
      - [Streamer](https://github.com/fzaninotto/Streamer): 一个简单的面向对象的流包装库
* 依赖注入 Dependency Injection 实现依赖注入设计模式的库
      - (https://github.com/jeremeamia/acclimate-container)[Acclimate]: 一个依赖注入容器和服务定位的通用接口
      - (https://github.com/rdlowrey/Auryn)[Auryn]: 一个递归的依赖注入容器
      - (https://github.com/thephpleague/container)[Container]: 另一个可伸缩的依赖注入容器
      - (https://github.com/bitExpert/disco)[Disco]: 一个兼容PSR-11基于annotation的依赖注入容器
      - (http://php-di.org/)[PHP-DI]: 一个支持自动装配和PHP配置的依赖注入容器
      - (http://pimple.sensiolabs.org/)[Pimple]: 一个小的依赖注入容器
      - (https://github.com/symfony/dependency-injection)[Symfony DI]: 一个依赖注入容器组件 (SF2)
* 图像 Imagery 处理图像的库
      - (https://github.com/thephpleague/color-extractor)[Color Extractor]: 一个从图像中提取颜色的库
      - (https://github.com/Sybio/GifCreator)[GIF Creator]: 一个通过多张图片创建GIF动画的库
      - (https://github.com/Sybio/GifFrameExtractor)[GIF Frame Extractor]: 一个提取GIF动画帧信息的库
      - (https://github.com/thephpleague/glide)[Glide]: 一个按需处理图像的库
      - (https://github.com/jenssegers/imagehash)[Image Hash]: 一个用于生成图像哈希感知的库
      - (https://github.com/psliwa/image-optimizer)[Image Optimizer]: 一个优化图像的库
      - (https://github.com/nmcteam/image-with-text)[Image With Text]: 一个在图像中嵌入文本的库
      - (http://imagine.readthedocs.io/en/latest/index.html)[Imagine]: 一个图像处理库
      - (https://github.com/Intervention/image)[Intervention Image]: 另一个图像处理库
      - (https://github.com/Sybio/ImageWorkshop)[PHP Image Workshop]: 另一个图像处理库
* 测试 Testing 测试代码和生成测试数据的库
      - (https://github.com/nelmio/alice)[Alice]: 富有表现力的一代库
      - (https://github.com/Codeception/AspectMock)[AspectMock]: 一个PHPUnit/Codeception的模拟框架。
      - (https://github.com/atoum/atoum)[Atoum]: 一个简单的测试库
      - (http://docs.behat.org/en/v2.5/)[Behat]: 一个行为驱动开发（BDD）测试框架
      - (https://github.com/Codeception/Codeception)[Codeception]: 一个全栈测试框架
      - (https://github.com/sebastianbergmann/dbunit)[DBUnit]: 一个PHPUnit的数据库测试库
      - (https://github.com/fzaninotto/Faker)[Faker]: 一个伪数据生成库
      - (https://github.com/InterNations/http-mock)[HTTP Mock]: 一个在单元测试模拟HTTP请求的库
      - (https://github.com/kahlan/kahlan)[Kahlan]: 全栈Unit/BDD测试框架，内置stub，mock和代码覆盖率的支持
      - (http://mink.behat.org/en/latest/)[Mink]: Web验收测试
      - (https://github.com/padraic/mockery)[Mockery]: 一个用于测试的模拟对象的库
      - (https://github.com/brianium/paratest)[ParaTest]: 一个PHPUnit的并行测试库
      - (https://github.com/peridot-php/peridot)[Peridot]: 一个事件驱动开发的测试框架
      - (https://github.com/mlively/Phake)[Phake]: 另一个用于测试的模拟对象的库
      - (https://github.com/danielstjules/pho)[Pho]: 另一个行为驱动开发测试框架
      - (https://github.com/php-mock/php-mock)[PHP-Mock]: 一个基于PHP函数的模拟库
      - (https://github.com/phpspec/phpspec)[PHPSpec]: 一个基于功能点设计的单元测试库
      - (https://qa.php.net/write-test.php)[PHPT]: 一个使用PHP本身的测试工具
      - (https://github.com/sebastianbergmann/phpunit)[PHPUnit]: 一个单元测试框架
      - (https://github.com/phpspec/prophecy)[Prophecy]: 一个可选度很高的模拟框架
      - (https://github.com/mauris/samsui)[Samsui]: 另一个伪数据生成库
      - (https://github.com/mikey179/vfsStream)[VFS Stream]: 一个用于测试的虚拟文件系统流的包装器
      - (https://github.com/adlawson/php-vfs)[VFS]: 另一个用于测试虚拟的文件系统
* 持续集成 Continuous Integration 持续集成的库和应用
      - (https://circleci.com)[CircleCI]: 一个持续集成平台
      - (https://about.gitlab.com/gitlab-ci/)[GitlabCi]: 使用GitLab CI测试、构建、部署你的代码，像TravisCI
      - (https://jenkins.io/index.html)[Jenkins]: 一个(http://jenkins-php.org/index.html)[PHP支持]的持续集成平台
      - (https://github.com/jolicode/JoliCi)[JoliCi]: 一个用PHP编写的由Docker支持的持续集成的客户端
      - (https://www.phptesting.org/)[PHPCI]: 一个PHP的开源的持续集成平台
      - (https://semaphoreci.com/)[SemaphoreCI]: 一个开放源码和私人项目的持续集成平台
      - (https://app.shippable.com/)[Shippable]: 一个基于开源和私人项目持续集成平台的docker
      - (http://sismo.sensiolabs.org/)[Sismo]: 一个持续测试的服务库
      - (https://travis-ci.org/)[Travis CI]: 一个持续集成平台
      - (http://www.wercker.com/)[Wercker]: 一个持续集成平台
* 文档 Documentation 生成项目文档的库
      - (https://github.com/apigen/apigen)[APIGen]: 另一个API文档生成器
      - (https://github.com/justinwalsh/daux.io)[daux.io]: 一个使用Markdown文件的文档生成器
      - (https://github.com/phpDocumentor/phpDocumentor2)[PHP Documentor 2]: 一个API文档生成器
      - (http://phpdox.de/)[phpDox]: 一个PHP项目的文档生成器（不限于API文档）
      - (https://github.com/FriendsOfPHP/Sami)[Sami]: 一个API文档生成器
* 安全 Security 生成安全的随机数，加密数据，扫描漏洞的库
      - (https://paragonie.com/project/halite)[Halite]: 一个简单的使用[libsodium](https://github.com/jedisct1/libsodium)的加密库
      - (https://github.com/ezyang/htmlpurifier)[HTML Purifier]: 一个兼容标准的HTML过滤器
      - (https://github.com/psecio/iniscan)[IniScan]: 一个扫描PHP INI文件安全的库
      - (https://github.com/jenssegers/optimus)[Optimus]: 基于Knuth乘法散列方法的身份混淆工具
      - (https://github.com/defuse/php-encryption)[PHP Encryption]: 一个安全的PHP加密库
      - (https://github.com/PHPIDS/PHPIDS)[PHP IDS]: 一个结构化的PHP安全层
      - (https://github.com/Herzult/php-ssh)[PHP SSH]: 一个试验的面向对象的SSH包装库
      - (http://phpseclib.sourceforge.net/)[PHPSecLib]: 一个纯PHP安全通信库
      - (https://github.com/ircmaxell/RandomLib)[RandomLib]: 一个生成随机数和字符串的库
      - (https://github.com/padraic/SecurityMultiTool)[SecurityMultiTool]: 一个PHP安全库
      - (https://security.sensiolabs.org/)[SensioLabs Security Check]: 一个为检查Composer依赖提供安全建议的web工具
      - (https://github.com/timoh6/TCrypto)[TCrypto]: 一个简单的键值加密存储库
      - (https://github.com/pixeloution/true-random)[True Random]: 使用[www.random.org](https://www.random.org/)生成随机数的库
      - (https://vaddy.net/)[VAddy]: 一个持续安全的web应用测试平台
      - (https://www.owasp.org/index.php/OWASP_Zed_Attack_Proxy_Project)[Zed]: 一个集成的web应用渗透测试工具
* 密码 Passwords 处理和存储密码的库和工具
      - (https://github.com/timoh6/GenPhrase)[GenPhrase]: 一个随机生成安全密码哈希的库
      - (https://github.com/ircmaxell/password_compat)[Password Compat]: 一个新的PHP5.5密码函数的兼容库
      - (https://github.com/ircmaxell/password-policy)[Password Policy]:  一个PHP和JavaScript的密码策略库
      - (https://github.com/jeremykendall/password-validator)[Password Validator]: 一个校验和升级密码哈希的库
      - (https://github.com/hackzilla/password-generator)[Password-Generator]: 一个生成随机密码的PHP库
      - (https://github.com/ircmaxell/PHP-PasswordLib)[PHP Password Lib]: 一个生成和校验密码的库
      - (http://www.openwall.com/phpass/)[phpass]: 一个便携式的密码哈希框架
      - (https://github.com/bjeavons/zxcvbn-php)[Zxcvbn PHP]: 一个基于Zxcvbn JS的现实的PHP密码强度估计库
* 代码分析 Code Analysis 分析，解析和处理代码库的库和工具
      - (https://github.com/polyfractal/athletic)[Athletic]: 一个基于注释的基准检测库
      - (https://github.com/Roave/BetterReflection)[Better Reflection]: 基于AST的反射库，允许分析操作代码
      - (https://codeclimate.com)[Code Climate]: 一个自动代码审查工具
      - (https://github.com/jakubledl/dissect)[Dissect]: 一个词法和语法分析的工具集合
      - (https://github.com/exakat/exakat)[Exakat]: 一个PHP的静态分析引擎
      - (https://github.com/phpro/grumphp)[GrumPHP]: 一个用来保护代码质量的Composer插件
      - (https://github.com/Trismegiste/Mondrian)[Mondrian]: 使用图论的代码分析工具
      - (https://github.com/scrutinizer-ci/php-analyzer)[PHP Analyser]: 一个分析PHP代码查找缺陷和错误的库
      - (https://github.com/squizlabs/PHP_CodeSniffer)[PHP Code Sniffer]: 一个检测PHP、CSS和JS代码标准冲突的库
      - (https://github.com/FriendsOfPHP/PHP-CS-Fixer)[PHP CS Fixer]: 一个编码标准库
      - (https://github.com/schmittjoh/php-manipulator)[PHP Manipulator]: 一个分析和修改PHP源代码的库
      - (https://phpmd.org/)[PHP Mess Detector]: 一个扫描代码缺陷，次优代码，未使用的参数等等的库。
      - (https://github.com/phpmetrics/PhpMetrics)[PHP Metrics]: 一个静态测量库
      - (https://github.com/monque/PHP-Migration)[PHP Migration]: 一个PHP版本升级的静态分析库
      - (https://github.com/nikic/PHP-Parser)[PHP Parser]: 一个PHP编写的PHP解析器
      - (https://github.com/QafooLabs/php-refactoring-browser)[PHP Refactoring Browser]: 一个重构PHP代码的命令行工具集
      - (https://github.com/tomzx/php-semver-checker)[PHP Semantic Versioning Checker]: 一个比较两个源集和确定适当的应用语义版本的命令行实用程序
      - (https://github.com/etsy/phan)[phan]: 一个基于PHP 7+和php-ast扩展的静态分析器
      - (https://github.com/PHPCheckstyle/phpcheckstyle)[PHPCheckstyle]: 一个帮助遵守特定的编码惯例的工具
      - (https://github.com/sebastianbergmann/phpcpd)[PHPCPD]: 一个检测复制和粘贴代码的库
      - (https://github.com/mamuz/PhpDependencyAnalysis)[PhpDependencyAnalysis]: 一个创建可定制依赖图的工具
      - (https://github.com/sebastianbergmann/phploc)[PHPLOC]: 一个快速测量PHP项目大小的工具
      - (https://github.com/EdgedesignCZ/phpqa)[PHPQA]: 一个用于运行质量保证工具的工具(phploc, phpcpd, phpcs, pdepend, phpmd, phpmetrics).
      - (https://github.com/ircmaxell/PHPPHP)[PHPPHP]: 一个PHP实现的PHP虚拟机
      - (https://github.com/Corveda/PHPSandbox)[PHPSandbox]: 一个PHP沙盒环境
      - (https://github.com/phpstan/phpstan)[PHPStan]: 一个PHP静态分析工具
      - (https://github.com/Qafoo/QualityAnalyzer)[Qafoo Quality Analyzer]: 一个可视化指标和源代码的工具
      - (https://scrutinizer-ci.com/)[Scrutinizer]: 一个审查PHP代码的web工具
      - (https://github.com/devster/ubench)[UBench]: 一个简单的微型基准检测库
* Architectural 相关的设计模式库，组织代码编程的方法和途径
      - (https://github.com/igorw/compose)[Compose]: 一个功能组合库
      - (https://github.com/domnikl/DesignPatternsPHP)[Design Patterns PHP]: 一个使用PHP实现的设计模式存储库
      - (http://yohan.giarel.li/Finite/)[Finite]: 一个简单的PHP有限状态机
      - (https://github.com/lstrojny/functional-php)[Functional PHP]: 一个函数式编程库
      - (https://github.com/endel/galapagos)[Galapagos]: 语言转换进化
      - (https://github.com/nikic/iter)[Iter]: 一个使用生成器提供迭代原语的库
      - (https://github.com/ircmaxell/monad-php)[Monad PHP]: 一个简单Monad库
      - (http://patchwork2.org/)[Patchwork]: 一个重新定义用户的函数库
      - (https://github.com/schmittjoh/php-option)[PHP Option]: 一个可选的类型库
      - (https://github.com/thephpleague/pipeline)[Pipeline]: 一个管道模式的实现
      - (https://github.com/bobthecow/Ruler)[Ruler]: 一个简单的无状态的生产环境规则引擎
      - (https://github.com/K-Phoen/rulerz)[RulerZ]: 一个强大的规则引擎和规范模式的实现
* 调试和分析 Debugging and Profiling 调试和分析代码的库和工具
      - (http://pecl.php.net/package/APM)[APM]: 一个收集SQLite/MySQL/StatsD错误信息和统计信息的监控扩展
      - (https://github.com/barbushin/php-console)[Barbushin PHP Console]: 另一个使用Google Chrome的web调试控制台
      - (https://blackfire.io)[Blackfire.io]: 一个低开销的代码分析器
      - (https://github.com/kint-php/kint)[Kint]: 一个调试和分析工具
      - (https://github.com/Seldaek/php-console)[PHP Console]: 一个web调试控制台
      - (http://phpdebugbar.com/)[PHP Debug Bar]: 一个调试工具栏
      - (https://github.com/phpbench/phpbench)[PHPBench]: 一个基准测试框架
      - (http://phpdbg.com/)[PHPDBG]: 一个交互的PHP调试器
      - (https://tideways.io/)[Tideways.io]: Monitoring and profiling tool
      - (https://github.com/nette/tracy)[Tracy]: A一个简单的错误检测，写日志和时间测量库
      - (https://github.com/xdebug/xdebug)[xDebug]: 一个调试和分析PHP的工具
      - (https://github.com/phacility/xhprof)[XHProf]: 一个最初由Facebook开发的分析工具
      - (http://www.zend.com/en/products/server/z-ray)[Z-Ray]: 一个调试和配置Zend服务器的工具
* 构建工具 Build Tools 项目构建和自动化工具
      - (https://github.com/CHH/bob)[Bob]: 一个简单的项目自动化工具
      - (https://github.com/box-project/box2)[Box]: 一个构建PHAR文件的工具
      - (https://github.com/jonathantorres/construct)[Construct]: 一个PHP项目的生成器
      - (https://github.com/jaz303/phake)[Phake]: 一个PHP克隆库
      - (https://www.phing.info/)[Phing]: 一个灵感来自于Apache Ant的PHP项目构建系统
* 任务运行器 Task Runners 自动运行任务的库
      - (http://bldr.io/)[Bldr]: 一个构建在Symfony组件上的PHP任务运行器
      - (https://github.com/jobbyphp/jobby)[Jobby]: 一个没有修改crontab的PHP定时任务管理器
      - (https://github.com/consolidation/Robo)[Robo]: 一个面向对象配置的PHP任务运行器
      - (http://taskphp.github.io/)[Task]: 一个灵感来源于Grunt和Gulp的纯PHP任务运行器
* 导航 Navigation 构建导航结构的工具
      - (https://github.com/tackk/cartographer)[Cartographer]: 一个站点地图生成库
      - (https://github.com/KnpLabs/KnpMenu)[KnpMenu]: 一个菜单库
* 资源管理 Asset Management 管理，压缩和最小化web站点资源的工具
      - (https://github.com/tedious/JShrink)[JShrink]: 一个JavaScript的最小化库
      - (https://github.com/meenie/munee)[Munee]: 一个资源优化库
      - (https://github.com/puli/repository)[Puli]: 一个检测资源绝对路径的库
      - (https://github.com/Bee-Lab/bowerphp)[BowerPHP]: Bower的一个PHP实现，一个web包管理工具
* 地理位置 Geolocation 地理编码地址和使用纬度经度的库
      - (http://geocoder-php.org/)[GeoCoder]: 一个地理编码库
      - (https://github.com/jmikola/geojson)[GeoJSON]: 一个GeoJSON的实现
      - (https://github.com/thephpleague/geotools)[GeoTools]: 一个地理工具相关的库
      - (https://github.com/mjaschen/phpgeo)[PHPGeo]: 一个简单的地理库
* 日期和时间 Date and Time 处理日期和时间的库
      - (http://yohan.giarel.li/CalendR/)[CalendR]: 一个日历管理库
      - (https://github.com/briannesbitt/Carbon)[Carbon]: 一个简单的日期时间API扩展
      - (https://github.com/cakephp/chronos)[Chronos]: 一个支持可变和不可变日期时间的DateTime API扩展
      - (https://github.com/jasonlewis/expressive-date)[ExpressiveDate]: 另一个日期时间API扩展
      - (https://github.com/fightbulc/moment.php)[Moment.php]: 灵感来源于Moment.js的PHP DateTime处理库，支持国际化
      - (https://github.com/azuyalabs/yasumi)[Yasumi]: 一个帮助你计算节日日期和名称的库
* 事件 Event 时间驱动或实现非阻塞事件循环的库
      - (https://github.com/amphp/amp)[Amp]: 一个事件驱动的不阻塞的I/O库
      - (https://github.com/broadway/broadway)[Broadway]: 一个事件源和CQRS(命令查询责任分离)库
      - (https://github.com/cakephp/event)[Cake Event]: 一个事件调度的库 (CP)
      - (https://github.com/Wisembly/Elephant.io)[Elephant.io]: 另一个web socket库
      - (https://github.com/igorw/evenement)[Evenement]: 一个事件调度的库
      - (https://github.com/thephpleague/event)[Event]: 一个专注于域名事件的库
      - (https://github.com/hoaproject/Eventsource)[Hoa EventSource]: 一个事件源库
      - (https://github.com/hoaproject/Websocket)[Hoa WebSocket]: 另一个web socket库
      - (https://github.com/prooph/event-store)[Prooph Event Store]: 一个持久化事件消息的事件源组件
      - (https://github.com/ratchetphp/Ratchet)[Ratchet]: 一个web socket库
      - (https://github.com/reactphp/react)[React]: 一个事件驱动的非阻塞I/O库.
      - (https://github.com/asm89/Rx.PHP)[Rx.PHP]: 一个reactive扩展库
      - (https://github.com/walkor/Workerman)[Workerman]: 一个事件驱动的不阻塞的I/O库
* 日志 Logging 生成和处理日志文件的库
      - [Analog](https://github.com/jbroadway/analog): 一个基于闭包的微型日志包
      - [KLogger](https://github.com/katzgrau/KLogger): 一个易用的兼容PSR-3的日志类
      - [Monolog](https://github.com/Seldaek/monolog): 一个全面的日志工具
* 电子商务 E-commerce 处理支付和构建在线电子商务商店的库和应用
      - [Money](https://github.com/moneyphp/money): 一个Fowler金钱模式的PHP实现
      - [OmniPay](https://github.com/thephpleague/omnipay): 一个框架混合了多网关支付处理的库
      - [Payum](https://github.com/payum/payum): 一个支付抽象库
      - [Shopware](https://github.com/shopware/shopware): 一个可高度定制的电子商务软件
      - [Swap](https://github.com/florianv/swap): 一个汇率库
      - [Sylius](http://sylius.org/): 一个开源的电子商务解决方案
* PDF 处理PDF文件的库和软件
      - (https://github.com/dompdf/dompdf)[Dompdf]: 一个将HTML转换为PDF的工具
      - (https://github.com/psliwa/PHPPdf)[PHPPdf]: 一个将XML文件转换为PDF和图片的库
      - (https://github.com/KnpLabs/snappy)[Snappy]: 一个PDF和图像生成器库
      - (https://github.com/wkhtmltopdf/wkhtmltopdf)[WKHTMLToPDF]: 一个将HTML转换为PDF的工具
* 办公 Office Libraries for working with office suite documents.
      - (https://github.com/Wisembly/ExcelAnt)[ExcelAnt]: 一个操作Excel文档的库
      - (https://github.com/PHPOffice/PHPPresentation)[PHPPowerPoint]: 一个处理PPT文档的库
      - (https://github.com/PHPOffice/PHPWord)[PHPWord]: 一个处理Word文档的库
      - (https://github.com/PHPOffice/PhpSpreadsheet)[PHPSpreadsheet]: 一个纯PHP的读写电子表格的库 (successor of PHPExcel)
* 数据库 Database 使用对象关系映射（ORM）或数据映射技术的数据库交互的库
      - (https://github.com/etrepat/baum)[Baum]: 一个Eloquent的嵌套集实现
      - (https://github.com/cakephp/orm)[Cake ORM]: 对象关系映射工具，利用DataMapper模式实现 (CP)
      - (https://github.com/Atlantic18/DoctrineExtensions)[Doctrine Extensions]: 一个Doctrine行为扩展的集合
      - (http://www.doctrine-project.org/)[Doctrine]: 一个全面的DBAL和ORM
      - (https://github.com/illuminate/database)[Eloquent]: 一个简单的ORM(L5)
      - (https://github.com/corneltek/LazyRecord)[LazyRecord]: 一个简单、可扩展、高性能的ORM
      - (https://github.com/chanmix51/Pomm)[Pomm]: 一个PostgreSQL对象模型管理器
      - (http://propelorm.org/)[Propel]: 一个快速的ORM，迁移库和查询构架器
      - (https://github.com/Ocramius/ProxyManager)[ProxyManager]: 一个为数据映射生成代理对象的工具集
      - (http://redbeanphp.com/index.php)[RedBean]: 一个轻量级，低配置的ORM
      - (https://github.com/vlucas/spot2)[Spot2]: 一个MySQL的ORM映射器
* 迁移 Migrations 帮助管理数据库模式和迁移的库
      - (http://docs.doctrine-project.org/projects/doctrine-migrations/en/latest/toc.html)[Doctrine Migrations]: 一个Doctrine的迁移库
      - (https://github.com/icomefromthenet/Migrations)[Migrations]: 一个迁移管理库
      - (https://github.com/robmorgan/phinx)[Phinx]: 另一个数据库迁移的管理库
      - (https://github.com/davedevelopment/phpmig)[PHPMig]: 另一个迁移管理库
      - (https://github.com/ruckus/ruckusing-migrations)[Ruckusing]: 基于PHP下ActiveRecord的数据库迁移，支持MySQL, Postgres, SQLite
* NoSQL NoSQL 处理NoSQL后端的库
      - (https://github.com/thephpleague/monga)[Monga]: 一个MongoDB抽象库
      - (https://github.com/alexbilbie/MongoQB)[MongoQB]: 一个MongoDB查询构建库
      - (https://github.com/sokil/php-mongo)[PHPMongo]: 一个MongoDB ORM.
      - (https://github.com/nrk/predis)[Predis]: 一个功能完整的Redis库
* 队列 Queue 处理事件和任务队列的库
      - (https://github.com/bernardphp/bernard)[Bernard]: 一个多后端抽象库
      - (https://github.com/jakubkulhan/bunny)[BunnyPHP]: 一个高性能的纯PHP AMQP(RabbitMQ)同步和异步(ReactPHP)库
      - (https://github.com/pda/pheanstalk)[Pheanstalk]: 一个Beanstalkd客户端库
      - (https://github.com/php-amqplib/php-amqplib)[PHP AMQP]: 一个纯PHP AMQP库
      - (https://github.com/tarantool-php/queue)[Tarantool Queue]: PHP绑定Tarantool队列
      - (https://github.com/php-amqplib/Thumper)[Thumper]: 一个RabbitMQ模式库
* 搜索 Search 在数据上索引和执行查询的库和软件
      - (https://github.com/ruflin/Elastica)[Elastica]: ElasticSearch的客户端库
      - (https://github.com/elastic/elasticsearch-php)[ElasticSearch PHP]: (https://www.elastic.co/)[ElasticSearch]的官方客户端库
      - (http://www.solarium-project.org/)[Solarium]: (http://lucene.apache.org/solr/)[Solr]的客户端库
      - (https://github.com/ripaclub/sphinxsearch)[Sphinx Search]: Sphinx搜索库，提供SphinxQL索引和搜索的功能
      - (http://foolcode.github.io/SphinxQL-Query-Builder/)[SphinxQL query builder]: (http://sphinxsearch.com/)[Sphinx]搜索引擎的的查询库
* 命令行 Command Line 关于命令行工具的库
      - (https://github.com/borisrepl/boris)[Boris]: 一个微型PHP REPL
      - (https://github.com/Cilex/Cilex)[Cilex]: 一个构建命令行工具的微型框架
      - (https://github.com/php-school/cli-menu)[CLI Menu]: 一个构建CLI菜单的库
      - (https://github.com/c9s/CLIFramework)[CLIFramework]: 一个支持完全zsh／bash、子命令和选项约束的命令行框架，这也归功于phpbrew
      - (https://github.com/thephpleague/climate)[CLImate]: 一个输出带颜色的和特殊格式的命令行库
      - (https://github.com/nategood/commando)[Commando]: 另一个简单的命令行选择解析器
      - (https://github.com/mtdowling/cron-expression)[Cron Expression]: 一个计算cron运行日期的库
      - (https://github.com/ulrichsg/getopt-php)[GetOpt]: 一个命令行选择解析器
      - (https://github.com/c9s/GetOptionKit)[GetOptionKit]: 另一个命令行选择解析器
      - (https://github.com/hoaproject/Console)[Hoa Console]: 另一个命令行库
      - (https://github.com/CHH/optparse)[OptParse]: 另一个命令行选择解析器
      - (https://github.com/mcrumm/pecan)[Pecan]: 一个事件驱动和非阻塞的shell
      - (https://github.com/bobthecow/psysh)[PsySH]: 另一个PHP REPL
      - (https://github.com/MrRio/shellwrap)[ShellWrap]: -一个简单的命令行包装库
* 身份验证和授权 Authentication and Authorization 实现身份验证和授权的库
      - (https://github.com/dflydev/dflydev-hawk)[Hawk]: 一个Hawk HTTP身份认证库
      - (https://github.com/socialConnect/auth)[SocialConnect Auth]: 一个开源的social sign (OAuth1\OAuth2\OpenID\OpenIDConnect)
      - (https://github.com/lcobucci/jwt)[Json Web Token]: 使用JSON Tokens进行身份验证和信息传输
      - (https://github.com/BeatSwitch/lock)[Lock]: 一种实现访问控制列表（ACL）系统的库
      - (https://github.com/thephpleague/oauth1-client)[OAuth 1.0 Client]: 一个OAuth 1.0客户端的库
      - (https://github.com/thephpleague/oauth2-client)[OAuth 2.0 Client]: 一个OAuth 2.0客户端的库
      - (http://bshaffer.github.io/oauth2-server-php-docs/)[OAuth2 Server]: 另一个OAuth2服务器实现
      - (http://oauth2.thephpleague.com/)[OAuth2 Server]: 另一个OAuth2服务器实现
      - (https://github.com/opauth/opauth)[Opauth]: 一个多渠道的身份验证框架
      - (https://github.com/Lusitanian/PHPoAuthLib)[PHP oAuthLib]: 另一个OAuth库
      - (https://cartalyst.com/manual/sentinel-social/2.0)[Sentinel Social]: 一个社交网络身份验证库
      - (https://cartalyst.com/manual/sentinel/2.0)[Sentinel]: 一个混合的身份验证和授权的框架库
      - (https://github.com/abraham/twitteroauth)[TwitterOAuth]: 一个Twitter OAuth库
      - (https://github.com/lyrixx/twitter-sdk)[TwitterSDK]: 一个完全测试的Twitter SDK
* 标记 Markup 处理标记的库
      - (https://github.com/cebe/markdown)[Cebe Markdown]: 一个快速的可扩展的Markdown解析器
      - (https://github.com/kzykhys/Ciconia)[Ciconia]: 另一个支持Github Markdown风格的Markdown解析器
      - (https://github.com/thephpleague/commonmark)[CommonMark PHP]: 一个对[CommonMark spec](http://spec.commonmark.org/)全支持的Markdown解析器
      - (https://github.com/milesj/decoda)[Decoda]: 一个轻量级标记解析库
      - (https://github.com/heyupdate/Emoji)[Emoji]: 一个把Unicode字符和名称转换为表情符号图片的库
      - (https://github.com/thephpleague/html-to-markdown)[HTML to Markdown]: 将HTML转化为Markdown
      - (https://github.com/Masterminds/html5-php)[HTML5 PHP]: 一个HTML5解析和序列化库
      - (https://github.com/erusev/parsedown)[Parsedown]: 另一个Markdown解析器
      - (https://github.com/michelf/php-markdown)[PHP Markdown]: 一个Markdown解析器
* 字符串 Strings 解析和处理字符串的库
      - (https://github.com/jenssegers/agent)[Agent]: 一个基于Mobiledetect的桌面／手机端user agent解析库
      - (https://github.com/sensiolabs/ansi-to-html)[ANSI to HTML5]: 一个将ANSI转化为HTML5的库
      - (https://github.com/mikeemoo/ColorJizz-PHP)[Color Jizz]: 处理和转换颜色的库
      - (https://github.com/piwik/device-detector)[Device Detector]: 另一个解析user agent字符串的库
      - (https://github.com/hoaproject/Ustring)[Hoa String]: 另一个UTF-8字符串库
      - (https://github.com/fukuball/jieba-php)[Jieba-PHP]: Python的jieba的PHP端口，自然语言处理的中文文本分词
      - (https://github.com/serbanghita/Mobile-Detect)[Mobile-Detect]: 一个用于检测移动设备的轻量级PHP类(包括平板电脑)
      - (https://github.com/nicolas-grekas/Patchwork-UTF8)[Patchwork UTF-8]: 一个处理UTF-8字符串的便携库
      - (https://github.com/cocur/slugify)[Slugify]: 转换字符串到slug的库
      - (https://github.com/jdorn/sql-formatter/)[SQL Formatter]: 一个格式化SQL语句的库
      - (https://github.com/danielstjules/Stringy)[Stringy]: 一个多字节支持的字符串处理库
      - (https://github.com/kzykhys/Text)[Text]: 一个文本处理库
      - (https://github.com/tobie/ua-parser/tree/master/php)[UA Parser]: 一个解析user agent字符串的库
      - (https://github.com/jbroadway/urlify)[URLify]: 一个Django中URLify.js的PHP版本
      - (https://github.com/ramsey/uuid)[UUID]: 生成UUIDs的库
* 数字 Numbers 处理数字的库
      - (https://github.com/gabrielelana/byte-units)[ByteUnits]: 一个在二进制和度量系统中解析,格式化和转换字节单元的库
      - (https://github.com/giggsey/libphonenumber-for-php)[LibPhoneNumber for PHP]: 一个Google电话号码处理的PHP实现库
      - (https://github.com/moontoast/math)[Math]: 一个处理巨大数字的库
      - (https://github.com/powder96/numbers.php)[Numbers PHP]: 一个处理数字的库
      - [PHP Conversion](https://github.com/Crisu83/php-conversion): 另一个用于度量单位间转换的库
      - [PHP Units of Measure](https://github.com/triplepoint/php-units-of-measure): 一个计量单位转换的库
* 过滤和验证 Filtering and Validation 过滤和验证数据的库
      - [Cake Validation](https://github.com/cakephp/validation): 另一个验证库 (CP)
      - (https://github.com/rdohms/DMS-Filter)[DMS Filter]: 一个注释过滤库
      - (https://github.com/ircmaxell/filterus)[Filterus]: 一个简单的PHP过滤库
      - (https://github.com/ronanguilloux/IsoCodes)[ISO-codes]: 一个验证各种ISO和ZIP编码的库(IBAN, SWIFT/BIC, BBAN, VAT, SSN, UKNIN)
      - (https://github.com/romaricdrigon/MetaYaml)[MetaYaml]: 一个支持YAML,JSON和XML的模式验证库
      - (https://github.com/Respect/Validation)[Respect Validation]: 一个简单的验证库
      - (https://github.com/brandonsavage/Upload)[Upload]: 一个处理文件上传和验证的库
      - (https://github.com/vlucas/valitron)[Valitron]: 另一个验证库
      - (https://github.com/serkin/Volan)[Volan]: 另一个简单的验证库
* 接口 API 开发REST-ful API的库和web工具
      - (https://api-platform.com)[API Platform]: 暴露出REST API的项目，包含JSON-LD, Hydra格式
      - (https://github.com/zfcampus/zf-apigility-skeleton)[Apigility]: 一个使用Zend Framework 2构建的API构建器
      - [Drest](https://github.com/leedavis81/drest): 一个将Doctrine实体暴露为REST资源节点的库
      - (https://github.com/blongden/hal)[HAL]: 一个超文本应用语言(HAL)构建库
      - (https://github.com/willdurand/Hateoas)[Hateoas]: 一个HOATEOAS REST web服务库
      - (https://github.com/willdurand/Negotiation)[Negotiation]: 一个内容协商库
      - (https://github.com/Luracast/Restler)[Restler]: 一个将PHP方法暴露为RESTful web API的轻量级框架
      - (https://github.com/wsdl2phpgenerator/wsdl2phpgenerator)[wsdl2phpgenerator]: 一个从SOAP WSDL文件生成PHP类的工具
* 缓存 Caching 缓存数据的库
      - (http://php.net/manual/en/book.apc.php)[Alternative PHP Cache (APC)]: 打开PHP操作码缓存
      - (https://github.com/frqnck/apix-cache)[APIx Cache]:  一个轻量级的PSR-6缓存
      - (https://github.com/gordalina/cachetool)[CacheTool]: 一个使用命令行清除apc/opcode缓存的工具
      - (https://github.com/cakephp/cache)[Cake Cache]: 一个缓存库 (CP)
      - (https://github.com/doctrine/cache)[Doctrine Cache]: 一个缓存库
      - (https://github.com/sobstel/metaphore)[Metaphore]: 一个缓存失效防范的库，使用信号标记阻止dogpile影响
      - (https://github.com/tedious/Stash)[Stash]: 另一个缓存库
      - (https://github.com/zendframework/zend-cache)[Zend Cache]: 另一个缓存库 (ZF2)
* 数据结构和存储 Data Structure and Storage 实现数据结构和存储技术的库
      - (https://github.com/morrisonlevi/Ardent)[Ardent]: 一个数据结构库
      - (https://github.com/cakephp/collection)[Cake Collection]: 一个简单的集合库 (CP)
      - (https://github.com/italolelis/collections)[Collections]: 一个PHP的集合抽象库
      - (https://github.com/thephpleague/fractal)[Fractal]: 一个转换复杂数据结构到JSON输出的库
      - (https://github.com/akanehara/ginq)[Ginq]: 另一个基于.NET实现的PHP的LINQ库
      - (https://github.com/cweiske/jsonmapper)[JsonMapper]: 一个将内嵌JSON结构映射为PHP类的库
      - (https://github.com/DusanKasan/Knapsack)[Knapsack]: 一个集合的库，灵感来自Clojure的相关库
      - (https://github.com/schmittjoh/php-collection)[PHP Collections]: 一个简单的集合库
      - (https://github.com/TimeToogo/Pinq)[PINQ]: 一个基于.NET实现的PHP的LINQ(Language Integrated Query)库
      - (https://github.com/ScriptFUSION/Porter)[Porter]: 数据导入的抽象框架
      - (https://github.com/schmittjoh/serializer)[Serializer]: 一个序列化和反序列化数据的库
      - (https://github.com/Wisembly/Totem)[Totem]: -一个管理和创建数据交换集的库
      - (https://github.com/Athari/YaLinqo)[YaLinqo]: 另一个PHP的LINQ库
      - (https://github.com/zendframework/zend-serializer)[Zend Serializer]: 另一个序列化和反序列化数据的库 (ZF2)
* 通知 Notifications 处理通知软件的库
      - (https://github.com/jolicode/JoliNotif)[JoliNotif]: 一个跨平台的桌面通知库(支持Growl, notify-send, toaster等)
      - (https://github.com/filp/nod)[Nod]: 一个通知库(Growl等)
      - (https://github.com/Ph3nol/NotificationPusher)[Notification Pusher]: 一个设备推送通知的独立库
      - (https://github.com/mac-cain13/notificato)[Notificato]: 一个处理推送通知的库
      - (https://github.com/namshi/notificator)[Notificator]: 一个轻量级的通知库
      - (https://github.com/gomoob/php-pushwoosh)[Php-pushwoosh]: 一个使用Pushwoosh REST Web服务轻松推送通知的PHP库
* 部署 Deployment 项目部署库
      - (https://github.com/deployphp/deployer)[Deployer]: 一个部署工具
      - (https://github.com/laravel/envoy)[Envoy]: 一个用PHP运行SSH任务的工具
      - (https://github.com/aerialls/Plum)[Plum]: 一个部署库
      - (https://github.com/tamagokun/pomander)[Pomander]: 一个PHP应用部署工具
      - (https://github.com/rocketeers/rocketeer)[Rocketeer]: PHP世界里的一个快速简单的部署器
* 国际化和本地化 Internationalisation and Localisation 国际化(I18n)和本地化(L10n)的库
      - [Cake I18n](https://github.com/cakephp/i18n): 消息国际化和日期和数字的本地化 (CP)
* 第三方API Third Party APIs 访问第三方API的库
      - (https://github.com/aws/aws-sdk-php)[Amazon Web Service SDK]: PHP AWS SDK官方库
      - (http://campaignmonitor.github.io/createsend-php/)[Campaign Monitor]: Campaign Monitor官方PHP库
      - (https://github.com/toin0u/DigitalOcean)[Digital Ocean]: Digital Ocean API接口库
      - (https://github.com/dropbox/dropbox-sdk-php)[Dropbox SDK]: Dropbox SDK官方PHP库
      - (https://github.com/dsyph3r/github-api3-php)[Github]: 一个Github API交互库
      - (https://github.com/KnpLabs/php-github-api)[PHP Github API]: 另一个Github API交互库
      - (https://github.com/gwkunze/S3StreamWrapper)[S3 Stream Wrapper]: Amazon S3流包装库
      - (https://github.com/stripe/stripe-php)[Stripe]: Stripe官方PHP库
      - (https://github.com/twilio/twilio-php)[Twilio]: Twilio官方PHP REST API
      - (https://github.com/widop/twitter-oauth)[Twitter OAuth]: 一个Twitter OAuth工作流交互库
      - (https://github.com/widop/twitter-rest)[Twitter REST]: 一个Twitter REST API交互库
* 扩展 Extensions 帮助构建PHP扩展的库
      - [PHP CPP](http://www.php-cpp.com/): 一个开发PHP扩展的C++库
      - [Zephir](https://github.com/phalcon/zephir): 用于开发PHP扩展，且介于PHP和C++之间的编译语言
* 杂项 Miscellaneous 创建一个开发环境的软件
      - (https://github.com/doctrine/annotations)[Annotations]: 一个注释库(Doctrine的一部分)
      - (https://github.com/cakephp/utility)[Cake Utility]: 工具类如Inflector，字符串，哈希，安全和XML (CP)
      - (https://github.com/adamnicholson/Chief)[Chief]: 一个命令总线库
      - (https://github.com/ClassPreloader/ClassPreloader)[ClassPreloader]: 一个优化自动加载的库
      - (https://github.com/umpirsky/country-list)[Country List]: 所有带有名称和ISO 3166-1编码的国家列表
      - (https://github.com/mpratt/Embera)[Embera]: 一个Oembed消费库
      - (https://github.com/essence/essence)[Essence]: 一个用于提取网络媒体的库
      - (https://github.com/selvinortiz/flux)[Flux]: 一个正则表达式构建库
      - (https://github.com/alexandresalome/graphviz)[Graphviz]: 一个图形库
      - (https://github.com/hprose/hprose-php)[Hprose-PHP]: 一个很牛的RPC库，现在支持25+种语言
      - (https://github.com/Seldaek/jsonlint)[JSON Lint]: 一个JSON lint工具
      - (https://github.com/willdurand/JsonpCallbackValidator)[JSONPCallbackValidator]: 验证JSONP回调的库
      - (https://github.com/kakawait/Jumper)[Jumper]: 一个远程服务执行库
      - (https://github.com/raulfraile/Ladybug)[LadyBug]: 一个dumper库
      - (https://github.com/igorw/lambda-php)[Lambda PHP]: 一个PHP中的Lambda计算解析器
      - (https://github.com/beberlei/litecqrs-php)[LiteCQRS]: 一个CQRS(命令查询责任分离)库
      - (https://github.com/beberlei/metrics)[Metrics]: 一个简单的度量API库
      - (https://github.com/ARCANEDEV/noCAPTCHA)[noCAPTCHA]: 一个帮助使用谷歌noCAPTCHA (reCAPTCHA)的工具
      - (https://github.com/willdurand/nmap)[Nmap]: 一个(https://nmap.org/)[Nmap] PHP包装器
      - (https://github.com/euskadi31/Opengraph)[Opengraph]: 一个开放图库
      - (https://github.com/whiteoctober/Pagerfanta)[Pagerfanta]: 一个分页库
      - (https://github.com/Kitano/php-expression)[PHP Expression]: 一个PHP表达式语言
      - (https://github.com/eymengunay/php-passbook)[PHP PassBook]: 一个iOS PassBook PHP库
      - (https://github.com/ronanguilloux/php-gpio)[PHP-GPIO]: 一个用于Raspberry PI的GPIO pin的库
      - (https://github.com/php-ai/php-ml)[PHP-ML]: 一个机器学习的PHP库
      - (https://github.com/phpcr/phpcr)[PHPCR]: 一个Java内容存储库(JCR)的PHP实现
      - (http://dunkels.com/adam/phpstack/)[PHPStack]: 一个PHP编写的TCP/IP栈概念
      - (https://github.com/koriym/print_o)[print_o]: 一个对象图的可视化器
      - (https://github.com/lstrojny/Procrastinator)[Procrastinator]: 一个运行耗时任务的库
      - (https://github.com/prooph/service-bus)[Prooph Service Bus]: 轻量级的消息总线，支持CQRS和微服务
      - (https://github.com/liip/RMT)[RMT]: 一个编写版本和发布软件的库
      - (https://github.com/fruux/sabre-vobject)[sabre/vobject]: 一个解析VCard和iCalendar对象的库
      - (https://github.com/webfactory/slimdump)[Slimdump]: 一个简单的MySQL dumper工具
      - (https://github.com/kriswallsmith/spork)[Spork]: 一个处理forking的库
      - (https://github.com/EvanDotPro/Sslurp)[Sslurp]: 一个使得SSL处理减少的库
      - (https://github.com/jeremeamia/super_closure)[SuperClosure]: 一个允许闭包序列化的库
      - (http://symfony.com/doc/current/components/var_dumper.html)[Symfony VarDumper]: 一个dumper库(SF2)
      - (http://anahkiasen.github.io/underscore-php/)[Underscore]: 一个Undersccore JS库的PHP实现
      - (https://github.com/filp/whoops)[Whoops]: 一个不错的错误处理库
* PHP安装 PHP Installation 在你的电脑上帮助安装和管理PHP的工具
      - (https://github.com/Homebrew/homebrew-php)[HomeBrew PHP]: 一个HomeBrew的PHP通道
      - (https://brew.sh/)[HomeBrew]: 一个OSX包管理器
      - (https://github.com/phpbrew/phpbrew)[PHP Brew]: 一个PHP版本管理和安装器
      - (https://github.com/php-build/php-build)[PHP Build]: 另一个PHP版本安装器
      - (https://github.com/CHH/phpenv)[PHP Env]: 另一个PHP版本管理器
      - (https://php-osx.liip.ch/)[PHP OSX]: 一个OSX下的PHP安装器
      - (https://github.com/jubianchi/phpswitch)[PHP Switch]: 另一个PHP版本管理器
      - (http://virtphp.org/)[VirtPHP]: 一个创建和管理独立PHP环境的工具
* 开发环境 Development Environment 创建沙盒开发环境的软件和工具
      - (https://www.ansible.com/)[Ansible]: 一个非常简单的编制框架
      - (http://phansible.com/)[Phansible]: 一个用Ansible构建PHP开发虚拟机的web工具
      - (http://getprotobox.com/)[Protobox]: 另一个构建PHP开发虚拟机的web工具
      - (https://puphpet.com/)[PuPHPet]: 一个构建PHP开发虚拟机的web工具
      - (https://puppet.com/)[Puppet]: 一个服务器自动化框架和应用
      - (https://www.vagrantup.com/)[Vagrant]: 一个便携的开发环境工具
      - (https://www.docker.com/)[Docker]: 一个容器化的平台
* 虚拟机 Virtual Machines 相关的PHP虚拟机
      - (http://hacklang.org/)[Hack]: 一个PHP进行无缝操作的HHVM编程语言
      - (https://github.com/facebook/hhvm)[HHVM]: Facebook出品的PHP虚拟机，Runtime和JIT
      - (https://github.com/hippyvm/hippyvm)[HippyVM]: 另一个PHP虚拟机
* 集成开发环境(IDE) Integrated Development Environment 支持PHP的集成开发环境
      - (https://www.eclipse.org/downloads/)[Eclipse for PHP Developers]: 一个基于Eclipse平台的PHP IDE
      - (https://netbeans.org)[Netbeans]: 一个支持PHP和HTML5的IDE
      - (http://www.jetbrains.com/phpstorm/)[PhpStorm]: 一个商业PHP IDE
* Web应用 Web Applications 基于Web的应用和工具
      - (https://3v4l.org/)[3V4L]: 一个在线的PHP和HHVM shell
      - (https://dbv.vizuina.com/)[DBV]: 一个数据库版本控制应用
      - (https://github.com/CoderKungfu/php-queue)[PHP Queue]: A一个管理后端队列的应用
      - (https://github.com/sj26/mailcatcher)[MailCatcher]: 一个抓取和查看邮件的web工具
      - (https://github.com/cachethq/cachet)[Cachet]: 开源状态页面系统
      - (https://github.com/mnapoli/phpBeanstalkdAdmin)[phpBeanstalkdAdmin]: 一个Beanstalkd的监控管理页面
      - (https://github.com/ErikDubbelboer/phpRedisAdmin)[phpRedisAdmin]: 一个用于管理[Redis](http://redis.io/)数据库的简单web界面
      - (https://github.com/phppgadmin/phppgadmin)[phpPgAdmin]: 一个PostgreSQL的web管理工具
      - (https://github.com/phpmyadmin/phpmyadmin)[phpMyAdmin]: 一个MySQL/MariaDB的web界面
      - (https://www.adminer.org/)[Adminer]: 一个数据库管理工具
      - (https://github.com/getgrav/grav)[Grav]: 一个现代的flat－file的CMS
* 基础架构 Infrastructure 提供PHP应用和服务的基础架构
      - [appserver.io](http://appserver.io/): 一个用PHP写的多线程的PHP应用服务器
      - [php-pm](https://github.com/php-pm/php-pm): 一个PHP应用的进程管理器、修改器和负载平衡器
* PHP网站 PHP Websites PHP相关的有用的网站
      - (https://nomadphp.com/)[Nomad PHP]: 一个在线PHP学习资源
      - (https://phpbestpractices.org/)[PHP Best Practices]: 一个PHP最佳实践指南
      - (http://www.php-fig.org/)[PHP FIG]: PHP框架交互组
      - (https://php-mentoring.org/)[PHP Mentoring]: 点对点PHP导师组织
      - (http://phpsecurity.readthedocs.io/en/latest/index.html)[PHP Security]: 一个PHP安全指南
      - (http://www.phptherightway.com/)[PHP The Right Way]: 一个PHP最佳实践的快速指引手册
      - (http://php.ug)[PHP UG]: 一个帮助用户定位最近的PHP用户组(UG)的网站
      - (http://phpversions.info/)[PHP Versions]: 哪些版本的PHP可以用在哪几种流行的Web主机上的列表
      - (http://www.phpweekly.com/archive.html)[PHP Weekly]: 一个PHP新闻周刊
      - (https://phptrends.com/)[PHPTrends]: 一个快速增长的PHP类库的概述
      - (http://securingphp.com/)[Securing PHP]: 一个关于PHP安全和库的建议的简报
      - (http://7php.com/)[Seven PHP]: 一个PHP社区成员采访的网站
* 其他网站 Other Websites web开发相关的有用网站
      - (https://www.atlassian.com/git)[Atlassian Git Tutorials]: 一个Git教程系列
      - (http://hginit.com/)[Hg Init]: 一个Mercurial教程系列
      - (http://semver.org/)[Semantic Versioning]: 一个解析语义版本的网站
      - (https://serversforhackers.com/)[Servers for Hackers]: 一个关于服务器管理的新闻通讯
      - (https://www.owasp.org/index.php/Main_Page)[The Open Web Application Security Project (OWASP)]: 一个开放软件安全社区
      - (https://websec.io/)[WebSec IO]: 一个web安全社区资源
* PHP书籍 PHP Books PHP相关的非常好的书籍
      - (https://www.functionalphp.com/)[Functional Programming in PHP]: 这本书将告诉你如何利用PHP5.3+的新功能的认识函数式编程的原则
      - (https://leanpub.com/grumpy-phpunit)[Grumpy PHPUnit]: 一本Chris Hartjes关于使用PHPUnit进行单元测试的书
      - (http://www.brandonsavage.net)[Mastering Object-Orientated PHP]: 一本Brandon Savage关于PHP面向对象的书
      - (http://shop.oreilly.com/product/0636920033868.do)[Modern PHP New Features and Good Practices]: 一本Josh Lockhart关于新的PHP功能和最佳做法的书
      - (https://leanpub.com/mlaphp)[Modernising Legacy Applications in PHP]: 一本Paul M.Jones关于遗留PHP应用进行现代化的书
      - (https://leanpub.com/php7)[PHP 7 Upgrade Guide]: 一本Colin O'Dell的包含所有PHP 7功能和改变的书
      - (https://daylerees.com/php-pandas/)[PHP Pandas]: 一本Dayle Rees关于如何学习写PHP的书
      - (http://www.scalingphpbook.com)[Scaling PHP Applications]: 一本Steve Corona关于扩展PHP应用程序的电子书
      - (https://leanpub.com/securingphp-coreconcepts)[Securing PHP: Core Concepts]: 一本Chris Cornutt关于PHP常见安全条款和实践的书
      - (https://leanpub.com/signalingphp)[Signaling PHP]: 一本Cal Evans关于在CLI脚本捕获PCNTL信号的书
      - (https://leanpub.com/grumpy-testing)[The Grumpy Programmer's Guide to Building Testable PHP Applications]: 一本Chris Hartjes关于构建PHP应用程序测试的书
      - (https://www.phparch.com/books/xml-parsing-with-php/)[XML Parsing with PHP]: 这本书涵盖的解析和验证XML文档，利用XPath表达式，使用命名空间，以及如何创建和修改XML文件的编程
      - (https://leanpub.com/ddd-in-php)[Domain-Driven Design in PHP]: 展示PHP DDD风格的实例
* 其他书籍 Other Books 与一般计算和web开发相关的书
      - (https://www.elastic.co/guide/index.html)[Elasticsearch: The Definitive Guide]: Clinton Cormley和Zachary Tong编写的与Elasticsearch工作的一本指南
      - (http://eloquentjavascript.net/)[Eloquent JavaScript]: Marijin Haverbeke关于JavaScript编程的一本书
      - (http://www.headfirstlabs.com/books/hfdp/)[Head First Design Patterns]: 解说软件设计模式的一本书
      - (https://git-scm.com/book/en/v2)[Pro Git]: Scott Chacon和Ben Straub关于Git的一本书
      - (http://linuxcommand.org/tlcl.php)[The Linux Command Line]: William Shotts关于Linux命令行的一本书
      - [The Tangled Web — Securing Web Applications](https://www.amazon.com/Tangled-Web-Securing-Modern-Applications/dp/1593273886): Michal Zalewski关于web应用安全的一本书
      - [Understanding Computation](http://computationbook.com): Tom Stuart关于计算理论的一本书
      - [Vagrant Cookbook](https://leanpub.com/vagrantcookbook): Erika Heidi关于创建 Vagrant环境的一本书
* PHP视频 PHP Videos 
      - [Nomad PHP Lightning Talks](https://www.youtube.com/c/nomadphp): PHP社区成员10到15分钟的快速会谈
      - [PHP UK Conference](https://www.youtube.com/user/phpukconference/videos): 一个PHP英国会议的视频集合
      - [Programming with Anthony](https://www.youtube.com/playlist?list=PLM-218uGSX3DQ3KsB5NJnuOqPqc5CW2kW): Anthony Ferrara的视频系列
      - [Taking PHP Seriously](https://www.infoq.com/presentations/php-history): 来自Facebook Keith Adams 讲述PHP优势
* PHP播客 PHP Podcasts 专注于PHP话题的博客
      - [PHP Town Hall](https://phptownhall.com/): 一个随意的Ben Edmunds和Phil Sturgeon的PHP播客
      - [PHP Roundtable](https://www.phproundtable.com/): PHP Roundtable是一个讨论PHP开发者关心话题的临时聚会
* PHP阅读 PHP Reading PHP相关的阅读资料
      - [Composer Primer](https://daylerees.com/composer-primer/): Composer初级使用
      - [Composer Stability Flags](https://igor.io/2013/02/07/composer-stability-flags.html): 一篇关于Composer稳定性标志的文章
      - [Composer Versioning](https://igor.io/2013/01/07/composer-versioning.html): 一篇关于Composer版本的文章
      - [Create Your Own PHP Framework](http://fabien.potencier.org/create-your-own-framework-on-top-of-the-symfony2-components-part-1.html): 一部Fabien Potencier的关于如何创建你自己的PHP框架的系列文章
      - [Don't Worry About BREACH](http://blog.ircmaxell.com/2013/08/dont-worry-about-breach.html): 一篇关于BREACH攻击和CSRF令牌的文章
      - [On PHP 5.3, Lambda Functions and Closures](http://fabien.potencier.org/on-php-5-3-lambda-functions-and-closures.html): 一篇关于lambda函数和闭包的文章
      - [PHP Is Much Better Than You Think](http://fabien.potencier.org/php-is-much-better-than-you-think.html): 一篇关于PHP语言和生态圈的文章
      - [PHP Package Checklist](http://phppackagechecklist.com/): 一个成功PHP包开发的清单
      - [PHP Sucks! But I Like It!](http://blog.ircmaxell.com/2012/04/php-sucks-but-i-like-it.html): 一篇关于PHP利弊的文章
      - [Preventing CSRF Attacks](http://blog.ircmaxell.com/2013/02/preventing-csrf-attacks.html): 一篇阻止CSRF攻击的文章
      - [Seven Ways to Screw Up BCrypt](http://blog.ircmaxell.com/2012/12/seven-ways-to-screw-up-bcrypt.html): 一篇关于纠正BCrypt实现的文章
      - [Use Env](https://seancoates.com/blogs/use-env/): 一篇关于使用unix环境帮助的文章
* PHP内核阅读 PHP Internals Reading 阅读PHP内核或性能相关的资料
  + [Disproving the Single Quotes Myth](http://nikic.github.io/2012/01/09/Disproving-the-Single-Quotes-Performance-Myth.html): 一篇关于单，双引号字符串性能的文章
  + [How Big Are PHP Arrays (And Values) Really?](http://nikic.github.io/2011/12/12/How-big-are-PHP-arrays-really-Hint-BIG.html): 一篇关于数组原理的文章
  + [How Foreach Works](http://stackoverflow.com/questions/10057671/how-does-php-foreach-actually-work/14854568#14854568): StackOverflow关于foreach回答的详情
  + [How Long is a Piece of String](http://blog.golemon.com/2006/06/how-long-is-piece-of-string.html): 一篇关于字符串原理的文章
  + [PHP Evaluation Order](https://gist.github.com/nikic/6699370): 一篇关于PHP评估顺序的文章
  + [PHP Internals Book](http://www.phpinternalsbook.com): 一本由三名核心开发编写的关于PHP内核的在线书
  + [PHP RFCs](https://wiki.php.net/rfc): PHP RFCs主页(请求注解)
  + [Print vs Echo, Which One is Faster?](http://fabien.potencier.org/print-vs-echo-which-one-is-faster.html): 一篇关于打印和echo性能的文章
  + [The PHP Ternary Operator. Fast or Not?](http://fabien.potencier.org/the-php-ternary-operator-fast-or-not.html): 一篇关于三元操作性能的文章
  + [Understanding OpCodes](http://blog.golemon.com/2008/01/understanding-opcodes.html): 一篇关于opcodes的文章
  + [When Does Foreach Copy?](http://nikic.github.io/2011/11/11/PHP-Internals-When-does-foreach-copy.html): 一篇关于foreach原理的文章
  + [Why Objects (Usually) Use Less Memory Than Arrays](https://gist.github.com/nikic/5015323): 一篇关于对象和数组原理的文章
  + [You're Being Lied To](http://blog.golemon.com/2007/01/youre-being-lied-to.html): 一篇关于内核ZVALs的文章

## 性能

```sh 
time php php-src/Zend/micro_bench.php # 源码自带性能测试
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
```
### [xdebug](https://xdebug.org/)

```sh
brew install homebrew/php/php71-xdebug

```

TP参考：<https://github.com/ijry/lyadmin>

<https://leanpub.com/phptherightway/read#test_driven_development_title>

- <http://phpbestpractices.justjavac.com/>
<http://www.jianshu.com/p/a5d905778b47>

$GLOBALS['HTTP_RAW_POST_DATA']
prof

thrift http://thrift.apache.org/
