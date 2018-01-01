# PHP

所用的程序是要经过两层代理的，即HTTP协议在Nginx等服务器的解析下，然后再传送给相应的Handler（PHP等）来处理。服务端脚本程序，只能通过服务器访问，需要配置虚拟主机调试

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
```

### 配置

```sh
mkdir -p ~/Library/LaunchAgents
cp /usr/local/opt/php71/homebrew.mxcl.php71.plist ~/Library/LaunchAgents/
launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.php71.plist

brew services start homebrew/php/php71
```

## [PHP发展](https://segmentfault.com/a/1190000008888700)

- composer:PHP 的依赖管理可以变得非常简单
- PHP7:对 Zend 引擎做了大量修改，大幅提升了 PHP 语言的性能.做好 MySQL 优化，使用 Memcache 和 Redis 进行加速
- PSR: <http://www.php-fig.org/> 组织制定的PHP语言开发规范，约定了很多方面的规则，如命名空间、类名 规范、编码风格标准、Autoload、公共接口等
- Swoole:Swoole 是一个异步并行的通信引擎，作为 PHP 的扩展来运行。Node.js 的异步回调 Swoole 有，Go语言的协程 Swoole 也有，这完全颠覆了对 PHP 的认知.使用 Swoole PHP 可以实现常驻内存的 Server 程序，可以实现 TCP 、 UDP 异步网络通信的编程开发。比如 WebSocket 即使通信、聊天、推送服务器、RPC 远程调用服务、网关、代理、游戏服务器等。
- Laravel:社区非常活跃，代码贡献者众多，第三方的插件非常多，生态系统相当繁荣。 Laravel 底层使用了很多 symfony2 组件，通过 composer 实现了依赖管理。Laravel 提供的命令行工具基于 symfony.console 实现，功能强大，集成了各种项目管理、自动生成代码的功能。
- PHP5.3 之后支持了类似 Java 的 jar 包，名为 phar。用来将多个 PHP 文件打包为一个文件。这个特性使得 PHP 也可以像 Java 一样方便地实现应用程序打包和组件化。一个应用程序可以打成一个 Phar 包，直接放到 PHP-FPM 中运行。配合 Swoole ，可以在命令行下执行 php server.phar 一键启动服务器。PHP 的代码包可以用 Phar 打包成组件，放到 Swoole 的服务器容器中去加载执行。
- PHP 作为一门动态脚本语言，优点是开发方便效率高。缺点就是性能差。在密集运算的场景下比 C 、 C++ 相差几十倍甚至上百倍。另外 PHP 不可以直接操作底层，需要依赖扩展库来提供 API 实现。PHP 程序员可以学习一门静态编译语言作为补充实现动静互补，C/C++/Go 都是不错的选择。而且静态语言的编程体验与动态语言完全不同，学习过程可以让你得到更大的提升。 掌握 C/C++ 语言后，还可以阅读 PHP 、 Swoole 、 Nginx 、Redis 、 Linux内核 等开源软件的源码，了解其底层运行原理。 现在最新版本的Swoole提供了C++扩展模块的支持，封装了Zend API，用C++操作PHP变得很简单，可以用C++实现PHP扩展函数和类。
- HTML5
- Vue.js 可以非常方便地实现数据和 DOM 元素的绑定。通过 Ajax 请求后台接口返回数据后，更新前端数据自动实现界面渲染。
- React Native 是一个不错的选择
- 深度学习/人工智能:自动驾驶、大数据分析、网络游戏、图像识别、语言处理等。当然现在普通的工程师可能还无法参与到人工智能产品中，但至少应该理解深度学习/人工智能的基本概念和原理。

## OOP

继承：类分层、接口分层 实现：类实现接口 依赖：类作为另一个类方法的参数 关联：类属性 聚合：可以有 组合：必须有

- PHP异步调用
- 正则匹配src标签
- 处理回文字符

## 模型

数据模型

业务模型

## 语法

### 基础

* PHP代码的标记：<?php …… ?>
* PHP文件的扩展名：.php
* PHP中每行程序代码，必须以英文下的分号(;)结束。而JS中分号可以省略。
* PHP程序也是区分大小写的，但函数名和关键字不区分大小写。如：if、break、switch
* 访问PHP文件，必须要经过服务器，或者以域名开头来访问。如：http://www.2015.com/test.php
* PHP文件及路径上不能包括中文或空格。
* 单行注释：//、#
* 多行注释：/* …… */
* 变量：临时存储数据的容器，指向值的指针
    - 变量的名称，可以包含：字母、数字、下划线。
    - 变量的名称，不能以数字开头，但可以以字母或下划线开头。如：$_ABC、$abc
    - 变量名称前必须要带“$”符号。“$”不是变量名称一部分，它只是对变量名称的一个引用或标识符。
    - 变量名称区分大小写。如：$name和$Name是两个变量
    - 对于由几个单词构成的变量名称的命名规则
        + “驼峰式”命名：$getUserName、$getUserPwd
        + “下划线”命名：$get_user_name、$set_user_pwd

```php
#!/usr/bin/env php
<?php
print "Hello, Red Hat Developers World from PHP " . PHP_VERSION . "\n";
?>
```

### 数据类型

变量本身没有类型之说，所说的类型是指变量中，存储的数据的类型。

* 基本数据类型
    - 字符串型
    - 整型
    - 浮点型
    - 布尔型
* 复合数据类型
    - 数组
    - 对象
* 特殊数据类型
    - NULL:unset() 与 NULL：删除引用，触发相应变量容器refcount减一，但在函数中的行为会依赖于想要销毁的变量的类型而有所不同，比如unset 一个全局变量，则只是局部变量被销毁，而在调用环境中的变量(包括函数参数引用传递的变量)将保持调用 unset 之前一样的值；unset 变量与给变量赋值NULL不同，变量赋值NULL直接对相应变量容器refcount = 0
    - 资源

```php
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

##### Lambda表达式(匿名函数)与闭包

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


addslashes函数转义风险：对于URL参数arg = %df\'在经过addslashes转义后在GBK编码下arg = 運'
2. urldecode函数解码风险：对于URL参数uid = 1%2527在调用urldecode函数解码(二次解码)后将变成uid = 1'

### 文件操作

```php
$fp  = fopen('lock.txt', 'w+');
if (flock($fp, LOCK_EX)) {
    fwrite($fp, 'write something');
    flock($fp, LOCK_UN);
} else {
    echo "file is locking...";
}
fclose($fp);
```


### 面向对象

访问控制(可见性)：

* public表明类成员在任何地方可见
* protected表明类成员在其自身、子类和父类内可见
* private表明类成员只对自己可见。
* 对于private和protected有个特例，同一个类的对象即使不是同一个实例也可以互相访问对方的私有与受保护成员

范围解析符(::)：通常以self::、 parent::、 static:: 和 <classname>::形式来访问静态成员、类常量，另外，static::、self:: 和 parent:: 还可用来调用类中的非静态方法。 

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

#### trait

为了避免代码重复而生

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
* mongo
* Opcache:通过将 PHP 脚本预编译的字节码存储到共享内存中来提升 PHP 的性能， 存储预编译字节码的好处就是省去了每次加载和解析 PHP 脚本的开销，但是对于I/O开销如读写磁盘文件、读写数据库等并无影响。
    - 字节码(Byte Code)：一种包含执行程序比机器码更抽象的中间码，由一序列 op代码/数据对组成的二进制文件。 比如Java源码经编译后生成的字节码在运行时通过JVM(JVM针对不同平台有不同版本，Java程序在JVM中运行而称 为解释性语言Interpreted)再做一次转换生成机器码，才能够跨平台运行；C#也类似，EXE文件的执行依赖.NET Framework；HHVM(HipHop Virtual Machine，Facebook开源的PHP虚拟机)采用了JIT(Just In Time Just Compiling，即时编译)技术，在运行时编译字节码为机器码，让他们的PHP性能测试提升了一个数量级。 唯有C/C++编译生成的二进制文件可直接运行。
    - 机器码(Machine Code)：也被称为原生码(Native Code)，用二进制代码表示的计算机能直接识别和执行的一种机器指令的集合，它是计算机硬件结构赋予的操作功能。
* pdo-pgsql
* phalcon
* redis
* sphinx
* swoole
* xdebug
* apc:op缓存
* PHP-FPM进程池：FastCGI Process Manager 的master process是常驻内存的，以static、dynamic、ondemand三种方式来管理进程池中的worker process，可以有效控制内存和进程并平滑重载PHP配置，在发生意外情况的时候能够重新启动并恢复被破坏的 opcode。


### Docker配置

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

### Traits

既可以实现代码分离又可以不用在逻辑层做任何处理

## 说明

* PHP5.5之后废弃mysql扩展

## 框架

- [php/php-src](https://github.com/php/php-src):The PHP Interpreter <http://www.php.net>
- [pinguo/php-msf](https://github.com/pinguo/php-msf)PHP微服务框架即"Micro Service Framework For PHP"，是Camera360社区服务器端团队基于Swoole自主研发现代化的PHP协程服务框架，简称msf或者php-msf，是Swoole的工程级企业应用框架，经受了Camera360亿级用户高并发大流量的考验
- [Youzan Zan Php Installer](https://github.com/youzan/zan-installer)Youzan Zan Php Installer
- [tencent-php/tsf](https://github.com/tencent-php/tsf):coroutine and Swoole based php server framework in tencent
- [slimphp/Slim](https://github.com/slimphp/Slim):Slim Framework source code <http://slimframework.com>
- [nette/nette](https://github.com/nette/nette):METAPACKAGE for Nette Framework components https://nette.org
- [Tencent/Biny](https://github.com/Tencent/Biny):Biny is a tiny, high-performance PHP framework for web applications

### 论坛

- [flarum/flarum](https://github.com/flarum/flarum):Delightfully simple forum software. <http://flarum.org>

### 电商

- [magento/magento2](https://github.com/magento/magento2): a cutting edge, feature-rich eCommerce solution that gets results.

### CMS

* [bolt/bolt](https://github.com/bolt/bolt):Bolt is a simple CMS written in PHP. It is based on Silex and Symfony components, uses Twig and either SQLite, MySQL or PostgreSQL.

## 扩展

* [PHP 开发者如何做代码审查?](http://blog.csdn.net/gitchat/article/details/78050953)
* [twigphp/Twig](https://github.com/twigphp/Twig):Twig, the flexible, fast, and secure template language for PHP <http://twig.sensiolabs.org/>
* [thephpleague/glide](https://github.com/thephpleague/glide):Wonderfully easy on-demand image manipulation library with an HTTP based API. <http://glide.thephpleague.com>
* [dompdf/dompdf](https://github.com/dompdf/dompdf):HTML to PDF converter (PHP5) <http://dompdf.github.com/>
* [PHPOffice/PHPExcel](https://github.com/PHPOffice/PHPExcel):A pure PHP library for reading and writing spreadsheet files
* [briannesbitt/Carbon](https://github.com/briannesbitt/Carbon):A simple PHP API extension for DateTime. <http://carbon.nesbot.com/>
* [Intervention/image](https://github.com/Intervention/image):PHP Image Manipulation <http://image.intervention.io>
* [fzaninotto/Faker](https://github.com/fzaninotto/Faker):Faker is a PHP library that generates fake data for you
* [guzzle/guzzle](https://github.com/guzzle/guzzle):Guzzle, an extensible PHP HTTP client <http://guzzlephp.org/>
* [reactphp/react](https://github.com/reactphp/react):Event-driven, non-blocking I/O with PHP. <https://reactphp.org>
* [CopernicaMarketingSoftware/PHP-CPP](https://github.com/CopernicaMarketingSoftware/PHP-CPP):Library to build PHP extensions with C++ <http://www.php-cpp.com/>
* [facebook/hhvm](https://github.com/facebook/hhvm):A virtual machine designed for executing programs written in Hack and PHP. <http://hhvm.com>
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

## 图书

* [PHP: The Right Way](http://www.phptherightway.com/)
* [reeze/tipi](https://github.com/reeze/tipi):Thinking In PHP Internals, An open book on PHP Internals http://www.php-internals.com/
* Morden php

### 对象

对象是一堆属性组成。对象在底层的实现。采取属性数组+方法数组来实现的。对象在zend中的定义是使用了一种zend_object_value结构体来存储的，这个结构体包含：
* 一个指针，也就是说明这个对象由哪个类实现出来的，这个类在哪里。
* 这个对象的属性。
* guards,阻止递归调用的。

对象的方法不会存在对象里面，要使用对象的方法，实际上是通过指针找到这个类，再用这个类里面的方法来执行的。（通过类序列化检测）

延迟绑定：之类重写父类方法，其它调用该方法时用static而非self

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


```

### xdebug

```sh
brew install homebrew/php/php71-xdebug

```

TP参考：<https://github.com/ijry/lyadmin>

<https://leanpub.com/phptherightway/read#test_driven_development_title>

- <http://phpbestpractices.justjavac.com/>
<http://www.jianshu.com/p/a5d905778b47>

$GLOBALS['HTTP_RAW_POST_DATA']
prof
