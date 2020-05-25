# [php/php-src](https://github.com/php/php-src)

The PHP Interpreter <http://www.php.net>

* PHP(Hypertext Preprocessor)
* 一门弱类型的语言，变量在声明时不需要确定类型，运行时类型会发生显式或隐式的类型改变
* 一种解释型语言，即不需要编译。构建在 Zend 虚拟机之上
* 一种服务器端脚本语言，只能通过服务器访问，需要配置虚拟主机调试,结果以纯 HTML 形式返回给浏览器
* HTTP协议在Nginx等服务器的解析下,传送给相应的Handler（PHP等）来处理
* 后端渲染，默认html处理，模版文件以.php后缀
* 优点:开发方便效率高
* 缺点
    - 性能差：在密集运算的场景下比 C 、C++ 相差很大
    - 不可以直接操作底层，需要依赖扩展库来提供 API 实现
    - **可控**：常驻内存运行环境的缺失
    - 不可控：进程的入口点和退出时机由额外的程序控制，执行PHP脚本的时机仍然由外部驱动

## 发展

* Phar：PHP5.3 之后支持了类似 Java 的 jar 包，名为 phar。可以像 Java 一样方便地实现应用程序打包和组件化，一个应用程序可以打成一个 Phar 包，直接放到 PHP-FPM 中运行。配合 Swoole，可以在命令行下执行 php server.phar 一键启动服务器
* 7:PHP是以多进程模型设计的，好处是请求之间互不干涉，一个请求失败也不会对其他进程造成影响
    - 变量标量类型声明：标量类型声明与返回类型声明
        + int
        + float
        + bool
        + string
        + interfaces
        + array
        + callable
    - 短闭包
    - null合并运算符（??）的新空合并运算符被加入 用来与isset（）函数函数一起替换三元操作
    - Trait
    - 属性类型
    - 扩散运算符
    - JIT 编译器
    - FFI
    - 匿名类
    - Contemporary cryptography
    - Generators
    -   改进的性能 - PHPNG代码合并在PHP7中，比 PHP5快两倍
    -   降低内存消耗 - 优化后PHP7使用较少的资源
    -   标量类型声明:参数和返回值类型可以被强制执行
    -   一致性的64位支持 - 64位架构机器持续支持
    -   改进异常层次结构 - 异常层次结构得到改善
    -   许多致命错误转换成异常 - 异常的范围增大覆盖为许多致命的错误转化异常；
    -   安全随机数发生器 - 加入新的安全随机数生成器的API
    -   已过时的API和扩展删除 - 不同的旧的和不支持的应用程序和扩展，从最新的版本中删除
    -   零成本声明支持零成本加入断言
    -  飞船操作符：用于比较两个表达式。当第一个表达式较第二个表达式分别小于，等于或大于时它分别返回-1，0或1。
    +   定义常量数组
    +   Closure::call() 方法加入到临时绑定（bindTo）的对象范围
    +   引入了过滤 unserialize（）函数以在反序列化不受信任的数据对象时提供更好的安全性。它可以防止可能的代码注入，使开发人员能够使用序列化白名单类。
    +   IntlChar类：这个类自身定义了许多静态方法用于操作多字符集的 unicode 字符。需要安装intl拓展
    +   两个新的函数引入以产生一个跨平台的方式加密安全整数和字符串。
        +   random_bytes() - 生成加密安全伪随机字节。
        +   random_int() - 生成加密安全伪随机整数。
    +   期望是向后兼容的增强到旧 assert() 函数。期望允许在生产代码零成本的断言，并提供在断言失败时抛出自定义异常的能力。assert() 不是一种语言构建体，其中第一个参数是一个表达式的比较字符串或布尔用于测试。
        +   ssertion - 断言。在PHP 5中，这必须是要计算一个字符串或要测试一个布尔值。 在PHP中7，这也可能是一个返回值的表达式，将执行和使用的结果，以指示断言是成功还是失败。
    + 生成器支持返回表达式：允许在生成器函数中通过使用 return 语法来返回一个表达式 （但是不允许返回引用值）， 可以通过调用 Generator::getReturn() 方法来获取生成器的返回值， 但是这个方法只能在生成器完成产生工作以后调用一次。
    + 生成器委派：只需在最外层生成其中使用yield from，就可以把一个生成器自动委派给其他的生成器
    + 会话选项设置：session_start() 可以加入一个数组覆盖php.ini的配置
    +   单次使用 use 语句可以用来从同一个命名空间导入类，函数和常量(而不用多次使用 use 语句)。
    +   错误处理：传统的错误报告机制的错误：通过抛出异常错误处理。类似于异常，这些错误异常会冒泡，直到它们到达第一个匹配的catch块。如果没有匹配的块，那么会使用 set_exception_handler() 安装一个默认的异常处理并被调用，并在情况下，如果没有默认的异常处理程序，那么该异常将被转换为一个致命的错误，并会像传统错误那样处理。
        +   由于 Error 层次结构不是从异常（Exception），代码扩展使用catch (Exception $e) { ... } 块来处理未捕获的异常，PHP5中将不会处理这样的错误。  catch (Error $e) { ... } 块或 set_exception_handler（）处理程序需要处理的致命错误。
    +   引入了intdiv()的新函数，它执行操作数的整数除法并返回结果为 int 类型
    +   null合并运算符
    +   Unicode codepoint 转译语法:接受一个以16进制形式的 Unicode codepoint，并打印出一个双引号或heredoc包围的 UTF-8 编码格式的字符串。 可以接受任何有效的 codepoint，并且开头的 0 是可以省略的
    + preg_replace_callback_array：可以使用一个关联数组来对每个正则表达式注册回调函数， 正则表达式本身作为关联数组的键， 而对应的回调函数就是关联数组的值
    - 改变了大多数错误的报告方式。不同于传统（PHP 5）的错误报告机制，大多数错误被作为 Error 异常抛出。
    - list 会按照原来的顺序进行赋值。不再是逆序了.不再支持解开字符串
    - foreach不再改变内部数组指针
    - 十六进制字符串不再被认为是数字
    - $HTTP_RAW_POST_DATA 被移 使用php://input代替
* 7.1 :2015.12.3
    - 减少内存分配次数
    - 多使用栈内存
    - 缓存数组的hash值
    - 字符串解析成桉树改为宏展开
    - 使用大块连续内存代替小块破碎内存
    - 空合并赋值操作符:第一个操作数是存在并且不为 NULL，则返回该操作数。否则返回第二个操作数
    - 参数以及返回值的类型现在可以通过在类型前加上一个问号使之允许为空。当启用这个特性时，传入的参数或者函数返回的结果要么是给定的类型，要么是null
    - 返回值声明为 void 类型的方法要么干脆省去 return 语句。对于 void来说，NULL 不是一个合法的返回值。
    - 类常量可见性
    - iterable 伪类:可以被用在参数或者返回值类型中，它代表接受数组或者实现了Traversable接口的对象.
    - 多异常捕获处理:一个catch语句块现在可以通过管道字符(|)来实现多个异常的捕获。 这对于需要同时处理来自不同类的不同异常时很有用
    - list支持键名
    - 字符串支持负向
    - 将callback 转闭包:Closure新增了一个静态方法，用于将callable快速地 转为一个Closure 对象。
    - 对http2服务器推送的支持现在已经被加入到 CURL 扩展
    - 传递参数过少时将抛出错误:过去我们传递参数过少 会产生warning。php7.1开始会抛出error
    - 移除了ext/mcrypt拓展
* 7.2
    - JIT(JUST_IN_TIME)
    - 增加新的类型object
    - 通过名称加载扩展:扩展文件不再需要通过文件加载 (Unix下以.so为文件扩展名，在Windows下以 .dll 为文件扩展名) 进行指定。可以在php.ini配置文件进行启用
    - 允许重写抽象方法:当一个抽象类继承于另外一个抽象类的时候，继承后的抽象类可以重写被继承的抽象类的抽象方法。
    - 使用Argon2算法生成密码散列:Argon2 已经被加入到密码散列（password hashing） API (这些函数以 password_ 开头), 以下是暴露出来的常量
    - 新增 PDO 字符串扩展类型,准备支持多语言字符集，PDO的字符串类型已经扩展支持国际化的字符集。以下是扩展的常量：
        + PDO::PARAM_STR_NATL
        + PDO::PARAM_STR_CHAR
        + PDO::ATTR_DEFAULT_STR_PARAM
    - 命名分组命名空间支持尾部逗号
    - number_format 返回值
    - get_class()不再允许null。
    - count 作用在不是 Countable Types 将发生warning
    - 不带引号的字符串:在之前不带引号的字符串是不存在的全局常量，转化成他们自身的字符串。现在将会产生waring。
    - __autoload 被废弃
    -  each 被废弃:使用此函数遍历时，比普通的 foreach 更慢， 并且给新语法的变化带来实现问题。因此它被废弃了。
    - is_object、gettype修正:is_object 作用在**__PHP_Incomplete_Class** 将反正 true;gettype作用在闭包在将正确返回resource
    - Convert Numeric Keys in Object/Array Casts:把数组转对象的时候，可以访问到整型键的值。
* 7.3
    - 添加了 array_key_first() 和 array_key_last() 来获取数组的第一个和最后一个元素的键名
    - 添加了 fpm_get_status() 方法, 来获取FPM状态数组,
    - 添加了几个FPM的配置项, 用来控制日志单行最大字符数, 日志缓冲等: log_limit, log_buffering, decorate_workers_output
    - libcurl >= 7.15.5 is now required
    - curl 添加了一堆常量
    - json_decode 添加了一个常量, JSON_THROW_ON_ERROR, 如果解析失败可以抛出异常, 而不是通过之前的方法 json_last_error() 去获取
    - spl autoloader: 如果一个加载失败, 剩下的都不再执行
    - 说明了一些循环引用的情况会得到怎样的结果
    - heredoc/nowdoc  中如果遇到跟定界符相同的字符串就认为结束了,  而最后真正的结束符则会被认为是语法错误;
    - 在 循环+switch-case 语句的case 中使用continue 会报warning
    - 说明了, 静态变量在被继承时, 如果在子类里发生了循环引用, 父类里的静态变量会跟着变
* 7.4
    - 短闭包函数
    - 预加载:框架启动时在内存中加载文件，而且在后续请求中永久有效,每次预加载的文件发生改变时，框架需要重新启动
    - 属性类型限定
    - 三元运算符 `$data['date'] ??= new DateTime();`
    - 预加载
        - 在服务器启动的时候，将某些文件永久读取到内存中，之后的请求即可直接从这内存中读取。利用这个功能，能够将框架，或者是类库预加载到内存中，以进一步提高性能，还能将php写的函数，当成内部函数使用（因为已经永久加载到内存，整个服务器共享）
        - 文件有所更新就得重新启动服务器
        - php.ini的 `opcache.preload` 指向一个启动文件，可以包含其他文件
    - 协变返回和逆变参数
        - 协变返回类型
    - 抛弃 array_merge ：在数组表达式中引入了扩展运算符
    - 箭头函数
    - 协变量返回和协变量参数
* 8
    - 实现了一个虚拟机 Zend VM，将可读脚本编译成虚拟机理解的指令，也就是操作码，这个执行阶段就是“编译时（Compile Time）”；在“运行时（Runtime）”执行阶段，虚拟机 Zend VM 会执行这些编译好的操作码

```php
// Strict mode
declare(strict_types=1);
function sum(int ...$ints)
{
   return array_sum($ints);
}
print(sum(2, '3', 4.1)); # Fatal error

declare(strict_types=1);
function returnIntValue(int $value): int
{
   return $value + 1.0;
}
print(returnIntValue(5));

$username = $_GET['username'] ?? $_POST['username'] ?? 'not passed'; # null合并运算符

print( 1 <=> 1);print("<br/>"); // 0
print( 1 <=> 2);print("<br/>"); // -1
print( 2 <=> 1);print("<br/>"); // 1

define('ALLOWED_IMAGE_EXTENSIONS', ['jpg', 'jpeg', 'gif', 'png']);

interface Logger {
   public function log(string $msg);
}
class Application {
   private $logger;

   public function getLogger(): Logger {
      return $this->logger;
   }

   public function setLogger(Logger $logger) {
      $this->logger = $logger;
   }
}

$app = new Application;
$app->setLogger(new class implements Logger {
   public function log(string $msg) {
      print($msg);
   }
});
$app->getLogger()->log("My first Log Message");

class A {
   private $x = 1;
}
$value = function() {
   return $this->x;
};
print($value->call(new A));

class MyClass1 {
   public $obj1prop;
}
class MyClass2 {
   public $obj2prop;
}
$obj1 = new MyClass1();
$obj1->obj1prop = 1;
$obj2 = new MyClass2();
$obj2->obj2prop = 2;
$serializedObj1 = serialize($obj1);
$serializedObj2 = serialize($obj2);
$data = unserialize($serializedObj1 , ["allowed_classes" => true]); // 不允许将所有的对象都转换为 __PHP_Incomplete_Class 对象
$data2 = unserialize($serializedObj2 , ["allowed_classes" => ["MyClass1", "MyClass2"]]); // 将除 MyClass 和 MyClass2 之外的所有对象都转换为 __PHP_Incomplete_Class 对象

$bytes = random_bytes(5);
print(bin2hex($bytes));
print(random_int(-1000, 0));

printf('%x', IntlChar::CODEPOINT_MAX);
echo IntlChar::charName('@');
var_dump(IntlChar::ispunct('!'));

ini_set('assert.exception', 1);
class CustomError extends AssertionError {}
assert(false, new CustomError('Custom Error Message!'));

use com\yiibai\{ClassA, ClassB, ClassC as C};
use function com\yiibai\{fn_a, fn_b, fn_c};
use const com\yiibai\{ConstA, ConstB, ConstC};

$gen = (function() {
    yield 1;
    yield 2;

    return 3;
})();
foreach ($gen as $val) {
    echo $val, PHP_EOL;
}
echo $gen->getReturn(), PHP_EOL;
# output
//1
//2
//3

function gen()
{
    yield 1;
    yield 2;

    yield from gen2();
}
function gen2()
{
    yield 3;
    yield 4;
}
foreach (gen() as $val)
{
    echo $val, PHP_EOL;
}
var_dump(intdiv(10,3)) //3

session_start([
    'cache_limiter' => 'private',
    'read_and_close' => true,
]);

class MathOperations
{
   protected $n = 10;

   // Try to get the Division by Zero error object and display as Exception
   public function doOperation(): string
   {
      try {
         $value = $this->n % 0;
         return $value;
      } catch (DivisionByZeroError $e) {
         return $e->getMessage();
      }
   }
}
$mathOperationsObj = new MathOperations();
print($mathOperationsObj->doOperation());

echo "\u{aa}";// ª
echo "\u{0000aa}";// ª
echo "\u{9999}";// 香

string preg_replace_callback_array(array $regexesAndCallbacks, string $input);
$tokenStream = []; // [tokenName, lexeme] pairs

$input = <<<'end'
$a = 3; // variable initialisation
end;

// Pre PHP 7 code
preg_replace_callback(
    [
        '~\$[a-z_][a-z\d_]*~i',
        '~=~',
        '~[\d]+~',
        '~;~',
        '~//.*~'
    ],
    function ($match) use (&$tokenStream) {
        if (strpos($match[0], '$') === 0) {
            $tokenStream[] = ['T_VARIABLE', $match[0]];
        } elseif (strpos($match[0], '=') === 0) {
            $tokenStream[] = ['T_ASSIGN', $match[0]];
        } elseif (ctype_digit($match[0])) {
            $tokenStream[] = ['T_NUM', $match[0]];
        } elseif (strpos($match[0], ';') === 0) {
            $tokenStream[] = ['T_TERMINATE_STMT', $match[0]];
        } elseif (strpos($match[0], '//') === 0) {
            $tokenStream[] = ['T_COMMENT', $match[0]];
        }
    },
    $input
);

// PHP 7+ code
preg_replace_callback_array(
    [
        '~\$[a-z_][a-z\d_]*~i' => function ($match) use (&$tokenStream) {
            $tokenStream[] = ['T_VARIABLE', $match[0]];
        },
        '~=~' => function ($match) use (&$tokenStream) {
            $tokenStream[] = ['T_ASSIGN', $match[0]];
        },
        '~[\d]+~' => function ($match) use (&$tokenStream) {
            $tokenStream[] = ['T_NUM', $match[0]];
        },
        '~;~' => function ($match) use (&$tokenStream) {
            $tokenStream[] = ['T_TERMINATE_STMT', $match[0]];
        },
        '~//.*~' => function ($match) use (&$tokenStream) {
            $tokenStream[] = ['T_COMMENT', $match[0]];
        }
    ],
    $input
);

interface Throwable
    |- Exception implements Throwable
        |- ...
    |- Error implements Throwable
        |- TypeError extends Error
        |- ParseError extends Error
        |- AssertionError extends Error
        |- ArithmeticError extends Error
            |- DivisionByZeroError extends ArithmeticError
function handler(Exception $e) { ... }
set_exception_handler('handler');

// 兼容 PHP 5 和 7
function handler($e) { ... }

// 仅支持 PHP 7
function handler(Throwable $e) { ... }

list($a,$b,$c) = [1,2,3];
var_dump($a);//1
var_dump($b);//2
var_dump($c);//3

$array = [0, 1, 2];
foreach ($array as &$val) {
    var_dump(current($array));
}
?>
#php 5
int(1)
int(2)
bool(false)
#php7
int(0)
int(0)
int(0)

var_dump("0x123" == "291");
#php5
true
#php7
false

function fun() :?string
{
  return null;
}

function fun1(?$a)
{
  var_dump($a);
}
fun1(null);//null
fun1('1');//1

function fun() :void
{
  echo "hello world";
}

function fun() :void
{
  echo "hello world";
}

class Something
{
    const PUBLIC_CONST_A = 1;
    public const PUBLIC_CONST_B = 2;
    protected const PROTECTED_CONST = 3;
    private const PRIVATE_CONST = 4;
}

function iterator(iterable $iter)
{
    foreach ($iter as $val) {
        //
    }
}

try {
    // some code
} catch (FirstException | SecondException $e) {
    // handle first and second exceptions
}

$data = [
    ["id" => 1, "name" => 'Tom'],
    ["id" => 2, "name" => 'Fred'],
];

// list() style
list("id" => $id1, "name" => $name1) = $data[0];
var_dump($id1);//1

$a= "hello";
$a[-2];//l

<?php
class Test
{
    public function exposeFunction()
    {
        return Closure::fromCallable([$this, 'privateFunction']);
    }

    private function privateFunction($param)
    {
        var_dump($param);
    }
}

$privFunc = (new Test)->exposeFunction();
$privFunc('some value');

function test(object $obj) : object
{
    return new SplQueue();
}
test(new StdClass());

; ini file
extension=php-ast
zend_extension=opcache

abstract class A
{
    abstract function test(string $s);
}
abstract class B extends A
{
    // overridden - still maintaining contravariance for parameters and covariance for return
    abstract function test($s) : int;
}

use Foo\Bar\{
    Foo,
    Bar,
    Baz,
};

var_dump(number_format(-0.01)); // now outputs string(1) "0" instead of string(2) "-0"

var_dump(get_class(null))// warning

count(1), // integers are not countable

// array to object
$arr = [0 => 1];
$obj = (object)$arr;
var_dump(
    $obj,
    $obj->{'0'}, // now accessible
    $obj->{0} // now accessible
);

array_map(fn(User $user) => $user->id, $users)

```

```php
$username = $_GET['user'] ?? 'nobody'

# 7.4
$parts = ['apple', 'pear'];
$fruits = ['banana', 'orange', ...$parts, 'watermelon'];
var_dump($fruits);

$b = array_map(fn($n) => $n * $n * $n, [1, 2, 3, 4, 5]);
## 替换use
$factor = 10;
$calc = fn($num) => $num * $factor;
```

## 原理

* Zend引擎读取.php文件
* PHP 代码 => Token => 抽象语法树 => Opcodes => 执行
    - 源代码通过词法分析得到 Token： Token 是 PHP 代码被切割成的有意义的标识。PHP7 一共有 137 种 Token，在 zend_language_parser.h 文件中做了定义
    - 基于语法分析器将 Token 转换成抽象语法树（AST）：Token 就是一个个的词块，但是单独的词块不能表达完整的语义，还需要借助一定的规则进行组织串联。所以就需要语法分析器根据语法匹配 Token，将 Token 进行串联。语法分析器串联完 Token 后的产物就是抽象语法树（AST，Abstract Syntax Tree）。 AST 是 PHP7 版本的新特性，之前版本的 PHP 代码的执行过程中是没有生成 AST 这一步的。它的作用主要是实现了 PHP 编译器和解释器的解耦，提升了可维护性。
    - 语法树转换成 Opcode
    - 执行 Opcodes： opcodes 是 opcode 的集合形式，是 PHP 执行过程中的中间代码。
* 开启 opcache：指将 opcodes 进行缓存。通过省去从源码到 opcode 的阶段，引擎直接执行缓存好的 opacode，以提升性能
* 四层体系构成，从下到上依次是 Zend 引擎、Extensions 扩展、SAPI 接口、上层应用
* Zend 引擎:PHP4 以后加入 PHP 的，是对原有PHP解释器的重写，整体使用 C 语言进行开发。作用是将PHP代码翻译为一种叫opcode的中间语言，它类似于JAVA的ByteCode（字节码）。引擎对PHP代码会执行四个步骤：
    - 词法分析 Scanning（Lexing），将 PHP 代码转换为语言片段（Tokens）
    - 解析 Parsing， 将 Tokens 转换成简单而有意义的表达式
    - 编译 Compilation， AST 将表达式编译成Opcode
    - 执行 Execution，虚拟机顺序执行Opcode，每次一条，以实现PHP代码所表达的功能
    - APC、Opchche 这些扩展可以将Opcode缓存以加速PHP应用的运行速度，使用它们就可以在请求再次来临时省略前三步
    - 引擎也实现了基本的数据结构、内存分配及管理，提供了相应的API方法供外部调用
* Extensions 扩展:常见的内置函数、标准库都是通过extension来实现的，这些叫做PHP的核心扩展，用户也可以根据自己的要求安装PHP的扩展
* SAPI(Server Application Programming Interface) 服务端应用编程接口：通过一系列钩子函数使得PHP可以和外围交换数据
    - SAPI 就是 PHP 和外部环境的代理器，它把外部环境抽象后，为内部的PHP提供一套固定的，统一的接口，使得 PHP 自身实现能够不受错综复杂的外部环境影响，保持一定的独立性
    - 通过 SAPI 的解耦，PHP 可以不再考虑如何针对不同应用进行兼容，而应用本身也可以针对自己的特点实现不同的处理方式
    - 几种常用的 SAPI：
        + apache2handler: Apache 扩展，编译后生成动态链接库，配置到 Apache 下。当有 http 请求到 Apache 时，根据配置会调用此动态链接库来执行 PHP 代码，完成与 PHP 的交互。
        + cgi-fcgi: 编译后生成支持 CGI 协议的可执行程序，webserver（如 NGINX）通过 CGI 协议把请求传给 CGI 进程，CGI 进程根据请求执行相应代码后将执行结果返回给 webserver。
        + fpm-fcgi: fpm 是 FastCGI 进程管理器。以 NGINX 服务器为例，当有请求发送到 NGINX 服务器，NGINX 按照 FastCGI 协议把请求交给 php-fpm 进程处理。
        + cli: PHP 的命令行交互接口
            * Zend 目录 Zend 目录是 PHP 的核心代码。PHP 中的内存管理，垃圾回收、进程管理、变量、数组实现等均在该目录的源码里。
            * main 目录 main 目录是 SAPI 层和 Zend 层的黏合剂。Zend 层实现了 PHP 脚本的编译和执行，sapi 层实现了输入和输出的抽象，main 目录则在它们中间起着承上启下的作用。承上，解析 SAPI 的请求，分析要执行的脚本文件和参数；启下，调用 zend 引擎之前，完成必要的模块初始化等工作。
            * ext 目录 ext 是 PHP 扩展相关的目录，常用的 array、str、pdo 等系列函数都在这里定义。
            * TSRM TSRM（Thread Safe Resource Manager）—— 线程安全资源管理器， 是用来保证资源共享的安全。
* 上层应用:程序员编写的PHP程序，无论是 Web 应用还是 Cli 方式运行的应用都是上层应用
* 请求
    - php_module_startup()
    - php_request_startup()
    - php_excute_script()
    - php_request_shutdown()
    - php_module_shutdown()
* 变量实现
* 自动回收
    - 引用计数 (reference counting) GC 机制
    - 每个对象都内含一个引用计数器 refcount，每个 reference 连接到对象，计数器加 1,共用value
    - 当 reference 离开生存空间或被设为 NULL，计数器减 1
    - 当某个对象的引用计数器为零时,释放其所占的内存空间
    - 引用计数大于0的value发生写操作时进行分离
* 语言特性
* 内存操作
* 线程安全

![PHP 架构](../../_static/php_construct.jpg "Optional title")

```sh
## 开启Opcache
zend_extension=opcache.so
opcache.enable=1
opcache.enable_cli=1
opcache.huge_code_pages=1
opcache.file_cache=/tmp

# 系统开启HugePages
cat /proc/meminfo  | grep Huge
AnonHugePages:    106496 kB
HugePages_Total:     512
HugePages_Free:      504
HugePages_Rsvd:       27
HugePages_Surp:        0
Hugepagesize:       2048 kB
```

## 安装

* 程序路径：`/usr/local/Cellar/php71/7.1.12_23`
* 配置文件: `/usr/local/etc/php/7.1/` The php.ini and php-fpm.ini file
* 通过php-fpm进程运行 `/usr/local/opt/php71/sbin/php-fpm --nodaemonize --fpm-config /usr/local/etc/php/7.1/php-fpm.conf :nginx`
* php71卸载后php-fpm仍然运行
    - `brew services stop php`
* phpize
    - phpize有版本号，依赖安装指定目录
        + mac:`/usr/local/lib/php/pecl/20180731/`
    - 需要php7.*-dev 支持
* [philcook/brew-php-switcher](https://github.com/philcook/brew-php-switcher):Brew PHP switcher is a simple shell script to switch your apache and CLI quickly between major versions of PHP. If you support multiple products/projects that are built using either brand new or old legacy PHP functionality. For users of Homebrew (or brew for short) currently only.

```sh
/usr/local/apache2/bin/apachectl start|stop
service httpd restart

LoadModule php5_module modules/libphp5.so # httpd.conf中添加

extension_dir = "/usr/local/lib/php/pecl/20180731"

cgi.fix_pathinfo=0 #  php.ini 文件中的配置项  如果文件不存在，则阻止 Nginx 将请求发送到后端的 PHP-FPM 模块， 以避免遭受恶意脚本注入的攻击
# 确保 php-fpm 模块使用 www-data 用户和 www-data 用户组的身份运行
# This is an extremely insecure setting because it tells PHP to attempt to execute the closest file it can find if a PHP file does not match exactly. This basically would allow users to craft PHP requests in a way that would allow them to execute scripts that they shouldn't be allowed to execute.

### windows 下载PHP安装包，解压即可
./php.exe -f e:\www\test.php # 不一定非php扩展名文件
php.exe -v
php.exe -i # 运行phpinfo()函数

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

brew services start|stop|restart php71

PHP Startup: Unable to load dynamic library # 扩展重复加载

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

### 扩展安装

* 用apt或者yum命令安装
* 用pecl安装

```sh
php -m # 查看添加扩展
php --ri xhprof

ln -s /etc/php5/mods-available/redis.ini /etc/php5/cli/conf.d/10-redis.ini
ln -s /etc/php5/mods-available/redis.ini /etc/php5/apache2/conf.d/10-redis.ini

apt-cache search memcached
apt-get install -y php5-memcached
```

### Cli

* 用多进程
    - 子进程结束以后, 内核会负责回收资源
    - 子进程异常退出不会导致整个进程Thread退出. 父进程还有机会重建流程
* 一个常驻主进程, 只负责任务分发, 逻辑更清楚
* 实现定时任务
* 开发桌面应用就是使用PHP-CLI和GTK包
* linux下用php编写shell脚本
* [ircmaxell/phpvm](https://github.com/ircmaxell/phpvm):A PHP version manager for CLI PHP
* 配置
    - 配置比较长的max_execution_time

```sh
php --ini　# 查找PHP CLI的ini文件位置
php -r "echo php_sapi_name();" # 判断当前执行的php是什么模式下 R RUN
php -f /path/to/yourfile.php # 调用PHP CLI解释器，并给脚本传递参数。这种方法首先要设置php解释器的路径，Windows平台在运行CLI之前，需设置类似path c:\php的命令，也失去了CLI脚本第一行的意义，因此不建议使用该方法。

# 第二种方法是首先运行chmod+x <要运行的脚本文件名>（UNIX/Linux环境），将该PHP文件置为可执行权限，然后在CLI脚本头部第一行加入声明（类似于#! /usr/bin/php或PHP CLI解释器位置），接着在命令行直接执行。这是CLI首选方法，建议采用

# /usr/local/lib/php/pecl/20180731/swoole.so doesn't appear to be a valid Zend extension

php -S localhost:8000 # 内置 web 服务器
```

### [PECL](http://pecl.php.net/)

PHP Extension Community Library，管理着最底层的PHP扩展。用 C 写的

* [PEAR](http://pear.php.net/)：PHP Extension and Application Repository，管理着项目环境的扩展。用 PHP 写的
    - 编译好的依赖：/usr/lib/php
* Composer：和PEAR都管理着项目环境的依赖，这些依赖也是用 PHP 写的，区别不大。但 composer 却比 PEAR 更受欢迎
* 扩展
    - vld:查看代码opcache

```sh
sudo apt install php-pear
pecl install memcached

phpize -v # 需要安装php7.*-dev
cd extname
phpize
./configure
make
make install
# 配置文件添加扩展
extension="swoole.so"

sudo apt-get install php-xml php7.3-xml php-dev php7.3-dev

wget http://pear.php.net/go-pear.phar
php go-pear.phar

# 修改bin路径
pear version
sudo apt install php7.3-dev # to use phpize 生成编译检测脚本

pecl channel-update pecl.php.net
pecl uninstall redis

HP Warning:  PHP Startup: redis: Unable to initialize module
Module compiled with module API=20170718
PHP    compiled with module API=20180731

pear.php.net is using a unsupported protocol - This should never happen.

pear update-channels
pear upgrade

Setting up php7.3-fpm (7.3.5-1+ubuntu18.04.1+deb.sury.org+1) ...
Error: The new file /usr/lib/php/7.3/php.ini-production does not exist!
dpkg: error processing package php7.3-fpm (--configure):
 installed php7.3-fpm package post-installation script subprocess returned error exit status 1
Errors were encountered while processing:
 php7.3-fpm

pecl install channel://pecl.php.net/vld-0.16.0
php -dvld.active=1 -dvld.excute=0 at.php # excute =0 opcode在么 并不执行
# Invalid argument supplied for foreach() in Command.php on line 249
sudo apt isntall php7.4-xml
# Trying to access array offset on value of type bool in PEAR/REST.php
mkdir -p /tmp/pear/cache
```

## 配置

* memory_limit:设定单个 PHP 进程可以使用的系统内存最大值
    - PHP 操作 Redis Set 集合。修改配置
    - 如果项目中每页页面使用的内存不大，建议改成小一些，这样可以承载更多的并发处理
    - PHP 脚本中调用 memory_get_peak_usage()函数多次测试自己项目脚本
* Zend OPcache 扩展
    - PHP解释器在执行PHP脚本时会解析PHP脚本代码，把PHP代码编译成一系列[Zend操作码](http://php.net/manual/zh/internals2.opcodes.php)，由于每个操作码都是一个字节长，所以又叫字节码，字节码可以直接被Zend虚拟机执行
    - 每次请求PHP文件都是这样，这会消耗很多资源，如果每次HTTP请求都必须不断解析、编译和执行PHP脚本，消耗的资源更多
    - 如果PHP源码不变，相应的字节码也不会变化，显然没有必要每次都重新生成Opcode，结合在Web应用中无处不在的缓存机制，可以把首次生成的Opcode缓存起来,直接从内存中读取预先编译好的字节码
    - 在配置中开启扩展
* max_execution_time 设置单个 PHP 进程在终止之前最长可运行时间
* Session 会话
    - 放在 Redis 或者 Memcached 中，可以减少磁盘的 IO 操作频率，还可以方便业务服务器伸缩
* error_reporting
* cgi.fix_pathinfo:值由1改为0
    - nginx通过 fastcgi_param 指令将参数传递给 FastCGI Server
    - 访问URL：http://phpvim.net/foo.jpg/a.php/b.php/c.php
    - 传递给 FastCGI 的 SCRIPT_FILENAME：foo.jpg/a.php/b.php/c.php
    - cgi.fix_pathinfo = 1 时，PHP CGI 以 / 为分隔符号从后向前依次检查根目录下如下路径，直到找个某个存在的文件，如果这个文件是个非法的文件
        + foo.jpg/a.php/b.php
        + foo.jpg/a.php
        + foo.jpg
    - PHP 会把这个文件当成 cgi 脚本执行，并赋值路径给 CGI 环境变量——SCRIPT_FILENAME，也就是 `$_SERVER['SCRIPT_FILENAME']` 的值了。
        + PHP的cgi SAPI中的参数fix_pathinfo

```
# 查看
php-config
php-config --extension-dir # PHP扩展目录

# session 存储道memcache
session.save_handler = 'memcached'
session.save_path = '127.0.0.1:11211'

expose_php = Off # X-Powered-By的配置

opcache.enable=1 # 开关打开
opcache.validate_timestamps=1    # 生产环境中配置为0：因为Zend Opcache将不能觉察PHP脚本的变化，必须手动清空Zend OPcache缓存的字节码，才能让它发现PHP文件的变动。这个配置适合在生产环境中设置为0，但在开发环境设置为1
opcache.revalidate_freq=240   # 检查脚本时间戳是否有更新时间
opcache.memory_consumption=64    # Opcache的共享内存大小，以M为单位
opcache.interned_strings_buffer=16    # 用来存储临时字符串的内存大小，以M为单位
opcache.max_accelerated_files=4000    # Opcache哈希表可以存储的脚本文件数量上限 对多缓存文件限制, 命中率不到 100% 的话, 可以试着提高这个值
opcache.fast_shutdown=1         # 使用快速停止续发事件

php -r "echo ini_get('memory_limit').PHP_EOL;" # 获取php内存大小

防止变量覆盖： register_globals=off
防止越权访问目录： open_basedir=/var/www/html（指定目录）
防止远程文件包含： allow_url_include=off and allow_url_fopen=off
防止显示详细的错误信息： display_errors=off
记录错误在日志文件中： log_errors=on
关闭不安全的字符串转义处理函数（防SQLi和XSS）： magic_quotes_gpc=off
如果PHP以CGI方式安装则需要关闭： cgi.fix_pathinfo=0
防御XSS（开启HttpOnly） session.cookie_httponly=1
HTTPS下提高安全性： session.cookie_secure=1
```

## 基础

* 代码标记：`<?php …… ?>`
* 文件扩展名 `.php`
* 每行代码必须以英文下分号`;`结束
* 区分大小写，但函数名和关键字不区分大小写。如：`if、break、switch`
* 访问PHP文件，必须要经过服务器访问。如：<http://www.2015.com/test.php>
* 文件名及路径中不能包括中文或空格
* 单行注释：`//、#`
* 多行注释：`/* …… */`
* 变量：临时存储数据的容器，指向值的指针
    - 作用域
        + 包含了 include 和 require 引入的文件
        + 局部变量 local：函数内部声明的变量，仅在函数内部访问
        + 全局作用域 global：在所有函数外部定义的变量
            + 除了函数外，全局变量可以被脚本中的任何部分访问
            + 要在一个函数中访问一个全局变量，需要使用 global 关键字
            + 所有全局变量存储在一个名为 $GLOBALS[index] 的数组中。index 保存变量的名称,可以在函数内部访问，也可以直接用来更新全局变量
        + 静态变量（static variable）：仅在局部函数域中存在，当程序执行离开此作用域时，其值并不丢失
        + parameter：通过调用代码将值传递给函数的局部变量
    - 本身没有类型，所说的类型是指变量中存储的数据的类型
    - 命名
        + 可以包含：字母、数字、下划线，可以用中文。
        + 不能以数字和特殊符号开头，但可以以字母或下划线开头。如：$_ABC、$abc
    - 变量名称前必须要带`$`符号。`$`不是变量名称一部分，只是对变量名称的一个引用或标识符
    - 命名规则
        + “驼峰式”命名：$getUserName、$getUserPwd
        + “下划线”命名：$get_user_name、$set_user_pwd
    - 赋值
        - 传值:$variablename指向value存储的地址 `$foo = 'Bob';`
        - 引用:新的变量简单的引用了原始变量,只有有名字的变量才可以引用赋值 `$bar = &$foo`
        - 对象赋值，浅拷贝,取了另一个名字而已，指向的内存空间还是一样 还是两份数据？
        - `$a = $b $b =56` $a 的值不变
        - clone函数在克隆对象时候，普通属性是深拷贝，原对象的对象属性还是引用赋值，浅拷贝
        - 魔术方法__clone实现真正深拷贝
    - 可变变量：`$$var`是一个引用变量，用于存储$var的值
* PHP 之外的变量
    - `$_GET $_POST $_REQUEST`
    - `$_SERVER`
    - `$_COOKIE`
* 常量
    - 定义
        + 常量前面没有`$`
        + 只能用 `define()` 函数定义，而不能通过赋值语句
        + 可以不用理会变量的作用域而在任何地方定义和访问
        + 一旦定义就不能被重新定义或者取消定义
        + 常量的值只能是标量, PHP 7 中还允许是 array
    - `define(name, value, case-insensitive = false)`: 区分大小写,成功时返回 TRUE， 或者在失败时返回 FALSE
    - defined():检查某个名称的常量是否存在
    - const关键字在编译时定义常量
        + 是一个语言构造不是一个函数
        + 比define()快一点，因为没有返回值
        + 区分大小写
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
    echo $y;
}
myTest(); // 15

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
myTest(5); # 5

// 函数内销毁全局变量$foo是无效的,应使用 $GLOBALS 数组来实现
function destroy_foo() {
    global $foo;
    // unset($foo);
    unset($GLOBALS['bar']);
    echo $foo;//Notice: Undefined variable: foo
}
$foo = 'bar';
destroy_foo();
echo $foo;//bar

# 常量
define("MESSAGE", "Hello YiiBai PHP");
const MESSAGE = "Hello const by YiiBai PHP";

require('./ShopProduct.php'); # 加载文件

# __clone实现真正深拷贝
class Test{
    public $a=1;
}

class TestOne{
    public $b=1;
    public $obj;
    //包含了一个对象属性，clone时，它会是浅拷贝
    public function __construct(){
        $this->obj = new Test();
    }

    //  方法一 重写clone函数
    public function __clone(){
        $this->obj = clone $this->obj;
    }
}

$m = new TestOne();

//方法二，序列化反序列化实现对象深拷贝
$n = serialize($m);
$n = unserialize($n);

$n->b = 2;
echo $m->b;//输出原来的1
echo PHP_EOL;
//普通属性实现了深拷贝，改变普通属性b，不会对源对象有影响
$n->obj->a = 3;
echo $m->obj->a;//输出1，不随新对象改变，还是保持了原来的属性,可以看到，序列化和反序列化可以实现对象的深拷贝
```

### 数据类型

* 标量
    + Boolean（布尔型）
        + 布尔值 FALSE 本身
        + 整型值 0（零）
        + 浮点型值 0.0（零）
        + 空字符串，以及字符串 "0"
        + 不包括任何元素的数组
        + 从空标记生成的 SimpleXML 对象
    + String（字符串）
        * 单引号PHP字符串中，大多数转义序列和变量不会被解释。 可以使用单引号`\'`反斜杠和通过`\\`在单引号引用PHP字符串
        * 双引号的PHP字符串中存储多行文本，特殊字符和转义序列,对一些特殊的字符进行解析
            * `\n`  换行（ASCII 字符集中的 LF 或 0x0A (10)）
            * `\r`  回车（ASCII 字符集中的 CR 或 0x0D (13)）
            * `\t`  水平制表符（ASCII 字符集中的 HT 或 0x09 (9)）
            * `\v`  垂直制表符（ASCII 字符集中的 VT 或 0x0B (11)）（自 PHP 5.2.5 起）
            * `\e`  Escape（ASCII 字符集中的 ESC 或 0x1B (27)）（自 PHP 5.4.0 起）
            * `\f`  换页（ASCII 字符集中的 FF 或 0x0C (12)）（自 PHP 5.2.5 起）
            * `\`  反斜线
            * `\$`  美元标记
            * `\"`  双引号
        + heredoc 结构就象是没有使用双引号的双引号字符串，单引号不用被转义，但是上文中列出的转义序列还可以使用
        + Nowdoc 结构是类似于单引号字符串的。Nowdoc 结构很象 heredoc 结构，但是 nowdoc 中不进行解析操作
            * 这种结构很适合用于嵌入 PHP 代码或其它大段文本而无需对其中的特殊字符进行转义
        + 方法
            - `addslashes` 转义风险：对于URL参数arg = %df\'在经过addslashes转义后在GBK编码下arg = 運'
            - `urldecode` 解码风险：对于URL参数uid = 1%2527在调用urldecode函数解码(二次解码)后将变成uid = 1'
            - `ord ( string $string ) : int`:转换字符串第一个字节为 0-255 之间的值
        * printf
            - %b binary representation
            - %c print the ascii character, same as chr() function
            - %d standard integer representation
            - %e scientific notation
            - %u unsigned integer representation of a positive integer
            - %u unsigned integer representation of a negative integer
            - %f floating point representation
            - %o octal representation
            - %s string representation
            - %x hexadecimal representation (lower-case)
            - %X hexadecimal representation (upper-case)
            - %+d  sign specifier on a positive or negative integer
    + Integer（整型）
    + Float（浮点型）
        * NaN:代表着任何不同值，不应拿 NAN 去和其它值进行比较，包括其自身，应该用 is_nan() 来检查
- NULL（空值）
    + 尚未被赋值
    + 被赋值为 NULL
    + 被 unset()
        * 删除引用，触发相应变量容器refcount减一 引用计数器
        * 在函数中的行为会依赖于想要销毁的变量的类型而有所不同
            - 比如unset 一个全局变量，则只是局部变量被销毁，而在调用环境中的变量(包括函数参数引用传递的变量)将保持调用 unset 之前一样的值
        * unset 变量与给变量赋值NULL不同，变量赋值NULL直接对相应变量容器refcount = 0

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

$str=strtolower("My name is Yiibai");
$str=ucwords("My name is Yiibai");
$str=ucfirst("My name is Yiibai");
$str=strrev("My name is Yiibai");

$len=strlen("My name is Yiibai");

$str = preg_replace_callback(
    '/([a-z]*)([A-Z]*)/',
    function($matchs){
        return strtoupper($matchs[1]).strtolower($matchs[2]);
    },
$str
);

echo ord("S") # 83
echo ord("Shanghai") # 83
substr()
htmlentities(string)
addslashes(str)
html_entity_decode(string)

print # 一个语法结构(language constructs), 并不是一个函数, 参数的list并不要求有括号
```

#### 复合

* Array（数组）:一个有序映射
    - 映射是一种把 values 关联到 keys 的类型。因此可以当成真正的数组，或列表（向量），散列表（是映射的一种实现），字典，集合，栈，队列以及更多可能性
    + key 会有如下的强制转换
        + 合法整型值的字符串会被转换为整型。例如键名 "8" 实际会被储存为 8。但是 "08" 则不会强制转换，因为其不是一个合法的十进制数值
        + 浮点数也会被转换为整型，意味着其小数部分会被舍去。例如键名 8.7 实际会被储存为 8
        + 布尔值也会被转换成整型。即键名 true 实际会被储存为 1 而键名 false 会被储存为 0
        + Null 会被转换为空字符串，即键名 null 实际会被储存为 ""
        + 数组和对象不能被用为键名。坚持这么做会导致警告：Illegal offset type
    - 类型
        * 索引数组
        * 关联数组
        * 多维数组
    + 方法
        * `+`:运算符把右边的数组元素附加到左边的数组后面，两个数组中都有的键名，则只用左边数组中的，右边的被忽略。
        * `in_array()`
        * `array_filter()` 过滤数组中的所有值为空的元素
        * `array_reduce($source, function(){}, $distination)`
        * `array_walk_recursive()`
        * `array_map()`:处理后的数组, 要得到处理后的元素值,需要return返回
        * `array_walk()`:返回true或者false,要得到处理后的元素值，需要在传入参数值加 & 引用符号
        * `array_column($array, cloumnName[, indexCloumn])`
    + 遍历
        * each — 返回数组中当前的键／值对并将数组指针向前移动一步
* Object（对象）
* callback:接受用户自定义的回调函数作为参数。回调函数不止可以是简单函数，还可以是对象的方法，包括静态类方法。
* Resource 资源
* 类型转换
    - 乘法运算符"*"。如果任何一个操作数是float，则所有的操作数都被当成float，结果也是float。否则操作数会被解释为integer，结果也是integer
        + 并没有改变这些操作数本身的类型；改变的仅是这些操作数如何被求值以及表达式本身的类型
* 类型判断
    - `gettype()`
    - `empty()`
    - `isset()`
    - `is_null()`
    - `boolean()`
    - `is_numeric()`

```php
# 声明
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

$emp = array (
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

sort($season);# 自身操作
foreach( $season as $s )
{
    echo "$s <br/>";
}

print_r(array_reverse($season)); # 赋值新变量

echo array_search("spring", $season);

$name1=array("maxsu","john","vivek","minsu");
$name2=array("umesh","maxsu","kartik","minsu");
print_r(array_intersect($name1,$name2)); # 交集


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

## 数组合并
# 索引数组 + 会保留第一个值，后面同样key舍弃，merge不会覆盖掉原来的值
# 关联数组：+ 会保留第一个值，merge会保留保留后者
$arr1 = ['PHP', 'apache'];
$arr2 = ['PHP', 'MySQl', 'HTML', 'CSS'];
$mergeArr = array_merge($arr1, $arr2);
$plusArr = $arr1 + $arr2;
print_r(($mergeArr);
print_r(($plusArr);

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

// callback
call_user_func('my_callback_function');

$foo = $foo * 1.3;  // $foo 现在是一个浮点数 (2.6)
$foo = 5 * "10 Little Piggies"; // $foo 是整数 (50)
$foo = 5 * "10 Small Pigs";     // $foo 是整数 (50)

function array2gbk($array)
{
    array_walk($array, function(&$value) {
        $value = iconv('utf-8', 'gbk', $value);
    });

    return $array;
}

function array2gbk1($array)
{
    $array = array_map(function($value){
        return iconv('utf-8', 'gbk', $value);
    }, $array);

    return $array;
}

$user = array(
    '0' => array('id' => 100, 'username' => 'a1'),
    '1' => array('id' => 101, 'username' => 'a2'),
    '2' => array('id' => 102, 'username' => 'a3'),
    '3' => array('id' => 103, 'username' => 'a4'),
    '4' => array('id' => 104, 'username' => 'a5'),
);
$username = array();
array_walk($user, function($value, $key) use (&$username){
    $username[] = $value['username'];
});
```

### 控制语句

* 表达式：任何有值的东西
* echo：是一个语言结构(语句)，不是一个函数，所以不需要使用括号。但是如果要使用多个参数，则需要使用括号。打印字符串，多行字符串，转义字符，变量，数组等。
* print
* print_r
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
* break:中断当前for，while，do-while，switch和for-each循环的执行
    - 如果在内循环中使用break，只中断了内循环的执行
    - 接受一个可选的数字参数来决定跳出几重循环
* continue：跳过本次循环中剩余的代码并在条件求值为真时开始执行下一次循环
    - 接受一个可选的数字参数来决定跳过几重循环到循环结尾
* return
* include
    - 被包含文件先按参数给出的路径寻找
    - 如果没有给出目录（只有文件名）时则按照 include_path 指定的目录寻找
    - 如果在 include_path 下没找到该文件则 include 最后才在调用脚本文件所在的目录和当前工作目录下寻找
    - 如果最后仍未找到文件则 include 结构会发出一条警告
    - include_once 语句在脚本执行期间包含并运行指定文件。此行为和 include 语句类似，唯一区别是如果该文件中已经被包含过，则不会再次包含。如同此语句名字暗示的那样，只会包含一次。
* require 在出错时产生 E_COMPILE_ERROR 级别的错误
    - require_once 语句和 require 语句完全相同，唯一区别是 PHP 会检查该文件是否已经被包含过，如果是则不会再次包含
* goto:跳转到程序中的另一位置
    - 该目标位置可以用目标名称加上冒号来标记，而跳转指令是 goto 之后接上目标位置的标记
* 替代语法
* 嵌套使用

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
* 位运算符：`&(位与) ^（异或） | ~ << >>`
    - &: 转换为布尔 5&1 为1
    - |：合并集合 1101 | 1011 为 1111
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
    - $a == $b： 如果 $a 和 $b 具有相同的键／值对则为 TRUE
    - $a === $b：如果 $a 和 $b 具有相同的键／值对并且顺序和类型都相同则为 TRUE
    - $a != $b    不等  如果 $a 不等于 $b 则为 TRUE
    - $a <> $b    不等  如果 $a 不等于 $b 则为 TRUE
    - $a !== $b   不全等 如果 $a 不全等于 $b 则为 TRUE
* 类型运算符:`instanceof (int) (float) (string) (array) (object) (bool)`
* 执行操作符:反引号（``）,尝试将反引号中的内容作为 shell 命令来执行，并将其输出信息返回
    - 激活了安全模式或者关闭了 shell_exec() 时无效
* 错误控制操作符:@,当将其放置在一个 PHP 表达式之前，该表达式可能产生的任何错误信息都被忽略掉
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

# 做权限验证
echo 2 & 10; // 输出：2
echo 2 | 10; // 输出结果：10
echo 1 ^ 1; // 输出结果：0
echo 1 ^ 0; // 输出结果：1

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

### 函数

一段可以重复使用多次的代码

* 参数
    - 值传递:传递给函数的值默认情况下不会修改实际值(通过值调用),传递给函数的值是通过值调用。作用域函数范围内
    - 引用调用:要传递值作为参考(引用)，需要在参数名称前使用＆符号(&)
    - 允许使用数组 array 、object、特殊类型 NULL 作为默认参数
    - 可以设置默认参数
    - 可变长度参数
    - 可变数量的参数列表:`...`
* 可变函数：一个变量名后有圆括号，PHP 将寻找与变量的值同名的函数，并且尝试执行它。可变函数可以用来实现包括回调函数
* 匿名函数（Anonymous functions），也叫闭包函数（Closure），允许 临时创建一个没有指定名称的函数
    - 经常用作回调函数（callback）
    - 不能直接访问闭包外的变量，通过 use 关键字来调用上下文变量
    - 闭包内所引用的变量不能被外部所访问,在闭包内对变量的改变从而影响到上下文变量的值，使用&的引用传参
    - Lambda表达式(匿名函数)实现了一次执行且无污染的函数定义，是抛弃型函数并且不维护任何类型的状态
    - 闭包在匿名函数的基础上增加了与外部环境的变量交互，通过 use 子句中指定要导入的外部环境变量
* 返回值
* 递归函数

```php
function sayHello($name,$age = 28){
    echo "Hello $name, you are $age years old<br/>";
}
sayHello("Maxsu",27);
sayHello("Henry");

function add_some_extra(&$string)
{
    $string .= 'and something extra.';
    echo $string;
}
$str = 'This is a string, ';
add_some_extra($str); # This is a string, and something extra.

function makecoffee($types = array("cappuccino"), $coffeeMaker = NULL)
{
    $device = is_null($coffeeMaker) ? "hands" : $coffeeMaker;
    return "Making a cup of ".join(", ", $types)." with $device.\n";
}
echo makecoffee();
echo makecoffee(array("cappuccino", "lavazza"), "teapot");

function increment($i)
{
    echo $i++;
}
$i = 10;
increment($i); # 10

function increment(&$i)
{
    echo $i++;
}
$i = 10;
increment($i);
echo $i; # 10 11

function sum(...$numbers) {
    $acc = 0;
    foreach ($numbers as $n) {
        $acc += $n;
    }
    return $acc;
}
echo sum(1, 2, 3, 4);

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
print_r(bin2hex($bytes));//string(10) "385e33f741"
print_r(random_int(100, 999));//int(248)
```

### 状态管理

服务器端存储技术

* cookie是一个小段信息，存储在客户端浏览器中。用于识别用户。cookie在服务器端创建并保存到客户端浏览器。 每当客户端向服务器发送请求时，cookie都会嵌入请求。 这样，cookie数据信息可以在服务器端接收。
    - 设置
    - 获取
    - 删除
* session:用于临时存储和从一个页面传递信息到另一个页面(直到用户关闭网站)
    - 广泛应用于购物网站(需要存储和传递购物车信息、用户名，产品代码，产品名称，产品价格等信息），从一个页面传递到另一个页面。
    - PHP会话为每个浏览器创建唯一的用户ID，以识别用户，并避免多个浏览器之间的冲突
    - session_start()函数用于启动会话，它启动一个新的或恢复现有会话
        + 如果已创建会话，则返回现有会话
        + 如果会话不可用，它将创建并返回新会话
    - $_SESSION是一个包含所有会话变量的关联数组。 它用于设置和获取会话变量值
    - session_destroy()

```php
setcookie("CookieName", "CookieValue");/* defining name and value only*/
setcookie("CookieName", "CookieValue", time()+1*60*60);//using expiry in 1 hour(1*60*60 seconds or 3600 seconds)
setcookie("CookieName", "CookieValue", time()+1*60*60, "/mypath/", "yiibai.com", 1);

$value=$_COOKIE["CookieName"];//returns cookie value

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

## IO

* 本质上是 “流(stream)” ，通过流操作文件、内存、网络等设备的数据。查看PHP 源代码
* 读写文件
* 命令行输入和输出:php_sapi_name返回值为cli，标准输入输出均指向终端
    - STDIN: 标准输入，只读，等同于用fopen打开”php://stdin”;
    - STDOUT: 标准输出，只写，等同于用fopen打开”php://stdout”;
    - STDERR: 标准错误输出，只写，等同于fopen打开”php://stderr”。
* 与远程网址交互:curl
* file_get_contents
* 方法
    - fputs
    - fwrite


### 文件操作

* 创建文件
* 访问文件有三种方式
    - 相对文件 `foo.txt => currentdirectory/foo.txt`
    - 相对路径 `subdirectory/foo.txt=> currentdirectory/subdirectory/foo.txt`
    - 绝对路径 `/main/foo.txt=> /main/foo.txt`
* 打开文件：`resource fopen ( string $filename , string $mode [, bool $use_include_path = false [, resource $context ]] )` 用于打开文件或URL并返回资源
    - filename 是 "scheme://..." 的格式，则被当成一个 URL，PHP 将搜索协议处理器（也被称为封装协议）来处理此模式
    - 如果该协议尚未注册封装协议，PHP 将发出一条消息来帮助检查脚本中潜在的问题并将 filename 当成一个普通的文件名继续执行下去
    - 指定的是一个本地文件，将尝试在该文件上打开一个流。该文件必须是 PHP 可以访问的，因此需要确认文件访问权限允许该访问
    - 相对路径无法打开
    - 接受两个参数
        + $filename表示要被打开的文件
        + $mode表示文件模式
    - r 以只读模式打开文件。 将文件指针放在文件的开头。
    - r+  以读写模式打开文件。 将文件指针放在文件的开头。
    - w   以只写模式打开文件。 将文件指针放在文件的开头，并将文件截断为零长度。 如果找不到文件，则会自动创建一个新文件。
    - w+  以读写模式打开文件。 将文件指针放在文件的开头，并将文件截断为零长度。 如果找不到文件，则会自动创建一个新文件。
    - a   以只写模式打开文件。 将文件指针放在文件的末尾。 如果找不到文件，则会创建一个新文件。
    - a+  以读写模式打开文件。 将文件指针放在文件的末尾。 如果找不到文件，则会创建一个新文件。
    - x   以只写模式创建和打开文件。 将文件指针放在文件的开头。 如果找到文件，fopen()函数返回FALSE。
    - x+  与x相同，但以读写模式创建和打开文件。
    - c   以只写模式打开文件。 如果文件不存在，则会创建。 如果存在，不会被截断(与’w‘相反)，也不会调用此函数失败(如’x‘的情况)。 文件指针位于文件的开头
    - c+  与c相同，但它以读写模式打开文件。
* flock：获取文件锁，可用其实现进程互斥锁；
* 读取文件：`string fread (resource $handle , int $length )`函数用于读取文件的数据
    - 参数：文件资源($handle 由fopen()函数创建的文件指针)和文件大小($length 要读取的字节长度)
    - 逐行读取文件：`string fgets ( resource $handle [, int $length ] )`函数用于从文件中读取单行数据内容
    - 逐个字符读取文件：`string fgetc ( resource $handle )`函数用于从文件中读取单个字符
        + 要使用fgetc()函数获取所有数据，请在while循环中使用!feof()函数作为条件。
* 写入文件：`int fwrite ( resource $handle , string $string [, int $length ] )`：用于将字符串的内容写入文件
    - 如果再次运行上面的代码，将擦除文件的前一个数据并写入新的数据。
    - 附加文件
* 删除文件：`bool unlink ( string $filename [, resource $context ] )`
* 关闭文件 `fclose($fd)`
* 上传文件：`bool move_uploaded_file ( string $filename , string $destination )`
    - `$_FILES['filename']['name']`   返回文件名称
    - `$_FILES['filename']['type']` 返回文件的MIME类型
    - `$_FILES['filename']['size']` 返回文件的大小(以字节为单位)
    - `$_FILES['filename']['tmp_name']` 返回存储在服务器上的文件的临时文件名。
    - `$_FILES['filename']['error']`    返回与此文件相关联的错误代码。
* 下载文件：`int readfile ( string $filename [, bool $use_include_path = false [, resource $context ]] )`
    - $filename：表示文件名
    - $use_include_path：它是可选参数。它默认为false。可以将其设置为true以搜索included_path中的文件
    - $context：表示上下文流资源
    - int：它返回从文件读取的字节数
* 方法：
    - basename:返回路径中的文件名部分

```php
# 读取
$filename = "c:\\myfile.txt";
$handle = fopen($filename, "r");//open file in read mode
$contents = fread($handle, filesize($filename));//read file
echo $contents;//printing data of file
fclose($handle);//close file

# 写入并加
$fp  = fopen(dirname(__FILE__) . '/lock.txt', 'w+');
if (flock($fp, LOCK_EX)) {
    fwrite($fp, 'write something');
    flock($fp, LOCK_UN);
} else {
    echo "file is locking...";
}
fclose($fp);

# 追加
$fp = fopen(dirname(__FILE__) . '/data.txt', 'a');//opens file in append mode
fwrite($fp, ' this is additional text ');
fwrite($fp, 'appending data');
fclose($fp);
echo "File appended successfully";

# 删除
$status=unlink(dirname(__FILE__) . '/data.txt');
if($status){
    echo "File deleted successfully";
}else{
    echo "Sorry!";
}

$fp = fopen("c:\\file1.txt", "r");//open file in read mode
while(!feof($fp)) {
  echo fgetc($fp);
}
fclose($fp);

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

echo "1) ".basename("/etc/sudoers.d", ".d").PHP_EOL;
echo "2) ".basename("/etc/passwd").PHP_EOL;
echo "3) ".basename("/etc/").PHP_EOL;
echo "4) ".basename(".").PHP_EOL;
echo "5) ".basename("/");
```

### php://input

* Coentent-Type仅在取值为application/x-www-data-urlencoded和multipart/form-data两种情况下，PHP才会将http请求数据包中相应的数据填入全局变量$_POST
* PHP不能识别的Content-Type类型的时候，会将http请求包中相应的数据填入变量$HTTP_RAW_POST_DATA
* Coentent-Type为multipart/form-data的时候，PHP不会将http请求数据包中的相应数据填入php://input
* “php://input可以读取没有处理过的POST数据
* php://input读取不到`$_GET`数据。因为`$_GET`数据作为query_path写在http请求头部(header)的PATH字段，而不是写在http请求的body部分
* 只有Content-Type为application/x-www-data-urlencoded时，php://input数据才跟$_POST数据相一致
* 相较于$HTTP_RAW_POST_DATA而言，它给内存带来的压力较小，并且不需要特殊的php.ini设置

### redirect

* `header ( string $header [, bool $replace = TRUE [, int $http_response_code ]] ) : void`
* `using ob_start() and ob_end_flush()`
* 通过 javascript

```php
header(“Location: http://example.com”[,TRUE,301]);
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

* mysql:PHP 5.5以来扩展已被弃用，建议使用以下2种替代方法之一
* mysqli
* PDO
    - 提供预处理语句查询
        + 位置参数
            * `$tis = $conn->prepare("INSERT INTO STUDENTS(name, age) values(?, ?)"); $tis->bindParam(1,$name); $tis->bindParam(2,$age);`
            * `$tis = $conn->prepare("INSERT INTO STUDENTS(name, age) values(?, ?)"); $tis->bindValue(1,'mike'); $tis->bindValue(2,22);`
        + 命名参数 `$tis = $conn->prepare("INSERT INTO STUDENTS(name, age) values(:name, :age)"); $tis->bindParam(':name', $name); $tis->bindParam(':age', $age);`
    - 错误异常处理、灵活取得查询结果（返回数组、字符串、对象、回调函数）、字符过滤防止 SQL 攻击、事务处理、存储过程

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
* final
    - 父类中的方法被声明为 final，则子类无法覆盖该方法
    - 如果一个类被声明为 final，则不能被继承

### 对象

* 对象是一堆属性组成
    - 在底层的实现,采取属性数组+方法数组来实现的。对象在zend中的定义是使用了一种zend_object_value结构体来存储的，这个结构体包含：
        + 一个指针L说明这个对象由哪个类实现出来的
        + 对象的属性
        + guards:阻止递归调用
    - 对象的方法不会存在对象里面，要使用对象的方法，实际上是通过指针找到这个类，再用这个类里面的方法来执行的。（通过类序列化检测）
* static
    - 修饰函数或变量使其成为类函数和类变量
    - 修饰函数内变量延长生命周期至整个应用程序
    - 延迟绑定：子类重写父类方法，其它调用该方法时用static而非self
        + static:: 不再被解析为定义当前方法所在的类，而是在实际运行时计算的。也可以称之为"静态绑定"，因为它可以用于（但不限于）静态方法的调用
        + 当进行静态方法调用时，该类名即为明确指定的那个（通常在 :: 运算符左侧部分）
        + 当进行非静态方法调用时，即为该对象所属的类
    - self 只引用声明，static 执行当前对象.static 指的调用上下文，self 解析上下文
    - 静态方法可以在非静态上下文调用
* 对象复制：对对象的所有属性执行一个浅复制（shallow copy）。所有的引用属性 仍然会是一个指向原来的变量的引用
    - 赋值与传递通过引用进行
    - 获取副本用clone，只复制引用，不复制引用的对象
    - `__clone()` 在复制得到的对象上运行
* 传递:默认情况下通过引用传递
    - 对象作为参数传递、作为结果返回或者赋值给另外一个变量
    - 另外一个变量跟原来的不是引用的关系，只是他们都保存着同一个标识符的拷贝，这个标识符指向同一个对象的真正内容
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

class Base {
    public function __construct() {
        echo "Base constructor!", PHP_EOL;
    }

    public static function getSelf() {
        return new self();
    }

    public static function getInstance() {
        return new static();
    }

    public function selfFoo() {
        return self::foo();
    }

    public function staticFoo() {
        return static::foo();
    }

    public function thisFoo() {
        return $this->foo();
    }

    public function foo() {
        echo  "Base Foo!", PHP_EOL;
    }
}

class Child extends Base {
    public function __construct() {
        echo "Child constructor!", PHP_EOL;
    }

    public function foo() {
        echo "Child Foo!", PHP_EOL;
    }
}

$base = Child::getSelf();
$child = Child::getInstance();

$child->selfFoo();
$child->staticFoo();
$child->thisFoo();
// Base constructor!
// Child constructor!
// Base Foo!
// Child Foo!
// Child Foo!
```

#### 访问控制(可见性)

* public:类成员在任何地方可见
* protected:类成员在自身、子类和父类内可见
* private:类成员只对自己可见。
* private和protected有个特例:同一个类的对象即使不是同一个实例也可以互相访问对方的私有与受保护成员
* 范围解析符(::)：通常以self::、 parent::、 static:: 和 `<classname>::`形式来访问静态成员、类常量
* static::、self:: 和 parent:: 可用来调用类中的非静态方法。类中实例或自己
* self
    - 替代类名，引用当前类的静态成员变量和静态函数；
    - 抑制多态行为，引用当前类的函数而非子类中覆盖的实现；
* self VS static
    - 在函数引用上
        + 对于静态成员函数，self指向代码当前类，static指向调用类
        + 对于非静态成员函数，self抑制多态，指向当前类的成员函数，static等同于this，动态指向调用类的函数
* parent
* this
    - this不能用在静态成员函数中，self可以；
    - 对静态成员函数/变量的访问，建议 用self，不要用$this::或$this->的形式；
    - 对非静态成员变量的访问，不能用self，只能用this;
    - this要在对象已经实例化的情况下使用，self没有此限制；
    - 在非静态成员函数内使用，self抑制多态行为，引用当前类的函数；而this引用调用类的重写(override)函数（如果有的话）
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

多态性是指相同的操作或函数、过程可作用于多种类型的对象上并获得不同的结果

* 一个对外接口，多个内部实现方法
* 多态性允许每个对象以适合自身的方式去响应共同的消息。多态性增强了软件的灵活性和重用性。
* 面向对象编程并不只是将相关的方法与数据简单的结合起来，而是采用面向对象编程中的各种要素将现实生活中的各种情况清晰的描述出来
* 主要在于可以将不同的子类对象都当作一个父类来处理，并且可以屏蔽不同子类对象之间所存在的差异，写出通用的代码，做出通用的编程，以适应需求的不断变化
* 通常为了使项目能够在以后的时间里的轻松实现扩展与升级，需要通过继承实现可复用模块进行轻松升级
* 在进行可复用模块设计时，就需要尽可能的减少使用流程控制语句。此时就可以采用多态实现该类设计。

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

* 接口
    - 通过interface关键字来定义的，但其中定义所有的方法都是空的，访问控制必须是public。
    - 接口可以如类一样定义常量，可以使用extends来继承其他接口
    - 接口中的每个方法，继承类里面都要去实现
    - 接口中的方法后面不要跟大口号{},因为接口只是定义需要有这个函数，并不是自己去实现
    - 不能实例化，抽象类中 abstract 的方法，强制要求子类定义这些方法，也可以理解成接口中的每个方法都是 abstract 方法
* 抽象类
    - abstract 的方法，继承类不必非要写那个方法
    - 抽象类定义要使用abstract关键字来声明，凡是用abstract关键字定义了抽象方法的类必须声明为抽象类。
    - 子类实现抽象方法时访问控制必须和父类中一样（或者更为宽松），同时调用方式必须匹配，即类型和所需参数数量必须一致；
    - 抽象类可用于对多个同构类的通用部分定义，用extends关键字继承(父子间存在"is a"关系)，属单继承。接口可用于多个异构类的通用部分定义，用implements关键字继承(父子间存在"like a"关系)，可多继承。如果子类不能实现父类或接口的全部抽象方法，则该子类只能被声明成抽象类。
* 接口比抽象更严格
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
* 优先级:当前类的成员 > trait 的方法 > 被继承的方法
* Trait 和 Class 相似，但仅旨在用细粒度和一致的方式来组合功能。它为传统继承增加了水平特性的组合；应用的几个 Class 之间不需要继承
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

* 匿名类被嵌套进普通 Class 后，不能访问这个外部类（Outer class）的 private（私有）、protected（受保护）方法或者属性
* 为了访问外部类（Outer class）protected 属性或方法，匿名类可以 extend（扩展）此外部类
* 为了使用外部类（Outer class）的 private 属性，必须通过构造器传进来

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

* 以双下划线（__）开始命名的方法
* `__construct()`
* `__destruct()`
* `__call($funName, $arguments)`:当调用一个未定义或不可达方法时， __call () 方法将被调用
* `__callStatic($funName, $arguments)`   当调用一个未定义或不可达的静态方法时， __callStatic () 方法将被调用
* `__clone()`
* `__get()`:读取不可访问属性的值
* `__set()`:在给不可访问属性赋值时
* `__isset()`:当对不可访问属性调用 isset() 或 empty() 时
* `__unset()`:当对不可访问属性调用 unset() 时
* `__sleep()`:serialize() 函数会检查类中是否存在一个魔术方法 __sleep()。如果存在，该方法会先被调用，然后才执行序列化操作,可以用于清理对象，并返回一个包含对象中所有应被序列化的变量名称的数组,不能返回父类的私有成员的名字。这样做会产生一个 E_NOTICE 级别的错误.
* `__wakeup()`:unserialize() 会检查是否存在一个 __wakeup() 方法。如果存在，则会先调用 __wakeup 方法，预先准备对象需要的资源
* `__toString()`:用于一个类被当成字符串时应怎样回应
* `__invoke()`:以调用函数的方式访问一个对象时， __invoke () 方法将首先被调用
* `__set_state()`:当调用 var_export () 方法时，__set_state () 方法将被调用
* `__autoload($className)`   试图载入一个未定义的类时调用。
* `__debugInfo()`   输出 debug 信息。

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

function __call($function, $args){
    array_unshift($args, $this->value);
    $this->value = call_user_func_array($function, $args);
    return $this;
}

function __call($function, $args){
    $this->value = call_user_func($function, $this->value, $args[0]);
    return $this;
}
```

## 反射

```php
# 利用反射机制创建实例
$reflector = new reflectionClass(User::class);
$constructor = $reflector->getConstructor();
$dependencies = $constructor->getParameters();
$user = $reflector->newInstanceArgs($dependencies = []);
```

## 杂项

* 数学函数
* 电子邮件
* 时间
* XML
    - simplexml_load_file
* 网络
    - gethostbyaddr()：获取指定的IP地址对应的主机名
    - gethostbynamel():获取互联网主机名对应的 IPv4 地址列表
* 密码散列算法函数
    - password_​get_​info
    - password_​hash
    - password_​needs_​rehash
    - password_​verify
* 性能
    - memory_get_usage()
    - microtime()
    - `$jRawData = file_get_contents( 'php://input' );`

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

$result = mail($to,$subject,$message,$header);
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

# 时间
var_dump(date("Y-m-d", strtotime("-1 month", strtotime("2017-03-31")))); # 输出2017-03-03
var_dump(date("Y-m-d", strtotime("last day of -1 month", strtotime("2017-03-31")))); # 输出2017-02-28
var_dump(date("Y-m-d", strtotime("first day of +1 month", strtotime("2017-08-31")))); # 输出2017-09-01

$hostname = gethostbyaddr($_SERVER['REMOTE_ADDR']);
```

### 生成器

提供了一种更容易的方法来实现简单的对象迭代，性能开销和复杂性大大降低

* 一个生成器函数看起来像一个普通的函数，不同的是普通函数返回一个值，而一个生成器可以yield生成许多它所需要的值
* 一个简单的例子就是使用生成器来重新实现 range() 函数。 标准的 range() 函数需要在内存中生成一个数组包含每一个在它范围内的值，然后返回该数组, 结果就是会产生多个很大的数组。 比如，调用 range(0, 1000000) 将导致内存占用超过 100 MB。
* 当一个生成器被调用的时候，它返回一个可以被遍历的对象.当遍历这个对象的时候(例如通过一个foreach循环)，PHP 将会在每次需要值的时候调用生成器函数，并在产生一个值之后保存生成器的状态，这样它就可以在需要产生下一个值的时候恢复调用状态。
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

## 调用外部命令

* 能执行linux系统的shell命令:可以获得命令执行的状态码
    - system() 输出并返回最后一行shell结果
        + 关掉 安全模式 safe_mode = off
        + 禁用函数列表 disable_functions = proc_open, popen, exec, system, shell_exec, passthru 把 exec 去掉
    - exec() 不输出结果，返回最后一行shell结果，所有结果可以保存到一个返回的数组里面。
    - passthru() 只调用命令，把命令的运行结果原样地直接输出到标准输出设备上。
```sh
system("/usr/a.sh");
```

## 异常


## 重定向

```
header('Location: http://www.baidu.com') ;
echo '<meta http-equiv="Refresh" content="0;url=http://www.baidu.com" >';
echo '<script>window.location.href="www.baidu.com"</script>';
```

## 序列化

* 作用
    - 方便传输
    - 方便存储
* 方案
    - 文本序列化,更好可读性
        + json
        + jsond:jsond_encode() jsond_decode()
        + serialize:serialize() unserialize()
        + xml
    - 二进制序列化,速度快
        + msgpack: msgpack_pack() msgpack_unpack()
        + protobuf
        + thrift
* 指标
    - 序列化的速度
    - 序列化后数据的大小
* JSON
    - `json_encode( mixed $value [, int $options = 0 [, int $depth = 512 ]] )` 函数返回值JSON的表示形式：它将PHP变量(包含数组)转换为JSON格式数据
        + 1:JSON_HEX_TAG:所有的 < 和 > 转换成 \u003C 和 \u003E
        + 2:JSON_HEX_AMP:所有的 & 转换成 \u0026
        + 4:JSON_HEX_APOS:所有的 ' 转换成 \u0027
        + 8:JSON_HEX_QUOT:所有的 " 转换成 \u0022
        + 16:JSON_FORCE_OBJECT:使一个非关联数组输出一个类（Object）而非数组。 在数组为空而接受者需要一个类（Object）的时候尤其有用
        + 32:JSON_NUMERIC_CHECK:将所有数字字符串编码成数字（numbers）
        + 64:JSON_UNESCAPED_SLASHES:不要编码 /： 已转义用htmlspecialchars_decode()处理
        + 128:JSON_PRETTY_PRINT:用空白字符格式化返回的数据
        + 256:JSON_UNESCAPED_UNICODE:以字面编码多字节 Unicode 字符（默认是编码成 \uXXXX）
        + 512:JSON_PARTIAL_OUTPUT_ON_ERROR:Substitute some unencodable values instead of failing
        + 1024:JSON_PRESERVE_ZERO_FRACTION:Ensures that float values are always encoded as a float value
    - json_decode()函数解码JSON字符串：将JSON字符串转换为PHP变量
        + 字符串要求
            * 使用UTF-8编码
            * 不能在最后元素有逗号
            * 不能使用单引号
            * 不能有\r,\t，如果有请替换
    - `int json_last_error ( void )`:返回json_encode() or json_decode() call的错误
        + JSON_ERROR_NONE   没有错误发生   
        + JSON_ERROR_DEPTH    到达了最大堆栈深度    
        + JSON_ERROR_STATE_MISMATCH   无效或异常的 JSON  
        + JSON_ERROR_CTRL_CHAR    控制字符错误，可能是编码不对   
        + JSON_ERROR_SYNTAX   语法错误     
        + JSON_ERROR_UTF8 异常的 UTF-8 字符，也许是因为不正确的编码。   PHP 5.3.3
        + JSON_ERROR_RECURSION    One or more recursive references in the value to be encoded PHP 5.5.0
        + JSON_ERROR_INF_OR_NAN   One or more NAN or INF values in the value to be encoded    PHP 5.5.0
        + JSON_ERROR_UNSUPPORTED_TYPE 指定的类型，值无法编码。    PHP 5.5.0
        + JSON_ERROR_INVALID_PROPERTY_NAME    指定的属性名无法编码。 PHP 7.0.0
        + JSON_ERROR_UTF16    畸形的 UTF-16 字符，可能因为字符编码不正确。

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

## 跨域请求

* Access-Control-Allow-Origin 设置方法
    - 设置*是最简单粗暴的，但是服务器出于安全考虑，肯定不会这么干，而且，如果是*的话，游览器将不会发送cookies，即使你的XHR设置了withCredentials
    - 指定域，如上图中的http://172.20.0.206，一般的系统中间都有一个nginx，所以推荐这种,例如：'Access-Control-Allow-Origin:http://172.20.0.206'
    - 动态设置为请求域，多人协作时，多个前端对接一个后台，这样很方便
    - withCredentials：表示XHR是否接收cookies和发送cookies，也就是说如果该值是false，响应头的Set-Cookie，浏览器也不会理，并且即使有目标站点的cookies，浏览器也不会发送。
* Access-Control-Allow-Credentials :是否允许后续请求携带认证信息（cookies）,该值只能是true,否则不返回
* option请求多了2个字段：
    - Access-Control-Request-Method：该次请求的请求方式
    - Access-Control-Request-Headers：该次请求的自定义请求头字段
    - Access-Control-Max-Age 预检结果缓存时间 表明该响应的有效时间为 86400 秒，也就是 24 小时。在有效时间内，浏览器无须为同一请求再次发起预检请求。浏览器自身维护了一个最大有效时间，如果该首部字段的值超过了最大有效时间，将不会生效

```php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Credentials: true');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS'); //允许的请求类型
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept"); // 允许的请求头字段
```

## Docker

* [docker-library/php](https://github.com/docker-library/php):Docker Official Image packaging for PHP https://php.net
* [yeszao/dnmp](https://github.com/yeszao/dnmp):Docker LNMP (Nginx, PHP7/PHP5, MySQL, Redis) https://www.awaimai.com/2120.html

```
mkdir -p ~/php-fpm/logs ~/php-fpm/conf

# Dockerfile

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

docker build -t php:5.6-fpm .
docker run -p 9000:9000 --name myphp-fpm -v ~/nginx/www:/www -v $PWD/conf:/usr/local/etc/php -v $PWD/logs:/phplogs -d php:5.6-fpm
```

## [xhprof](https://github.com/phacility/xhprof)

* 一个分层PHP性能分析工具。报告函数级别的请求次数和各种指标，包括阻塞时间，CPU时间和内存使用情况。
* [longxinH/xhprof](https://github.com/longxinH/xhprof):PHP7 support
* 工具
    - [EvaEngine/xhprof.io ](https://github.com/EvaEngine/xhprof.io):GUI to analyze the profiling data collected using XHProf – A Hierarchical Profiler for PHP. http://xhprof.io/
    - [perftools/xhgui](https://github.com/perftools/xhgui):A graphical interface for XHProf data built on MongoDB
* 方法
    - xhprof_disable — 停止 xhprof 分析器
    - xhprof_enable — 启动 xhprof 性能分析器
        + 如果xhprof_enable(XHPROF_FLAGS_CPU + XHPROF_FLAGS_MEMORY)可以输出更多指标
    - xhprof_sample_disable — 停止 xhprof 性能采样分析器
    - xhprof_sample_enable — 以采样模式启动 XHProf 性能分析
* 主要指标： 
    - Inclusive Time (或子树时间)：包括子函数所有执行时间。 
    - Exclusive Time/Self Time：函数执行本身花费的时间，不包括子树执行时间。 
    - Wall时间：花去了的时间或挂钟时间。 
    - CPU时间：用户耗的时间+内核耗的时间 
    - Function Name 函数名 
    - Calls 调用次数 
    - Calls% 调用百分比 
    - 消耗时间 
        + **Incl. Wall Time (microsec) ** 调用的包括子函数所有花费时间 以微秒算(一百万分之一秒)
        + IWall% 调用的包括子函数所有花费时间的百分比 
        + **Excl. Wall Time (microsec) ** 函数执行本身花费的时间，不包括子树执行时间,以微秒算(一百万分之一秒) 
        + EWall% 函数执行本身花费的时间的百分比，不包括子树执行时间 
   - 消耗CPU 
        + Incl. CPU(microsecs) 调用的包括子函数所有花费的cpu时间。减Incl. Wall Time即为等待cpu的时间 
        + ICpu% Incl. CPU(microsecs)的百分比 
        + Excl. CPU(microsec) 函数执行本身花费的cpu时间，不包括子树执行时间,以微秒算(一百万分之一秒)。 
        + ECPU% Excl. CPU(microsec)的百分比 
   - 消耗内存 
        + Incl.MemUse(bytes) 包括子函数执行使用的内存。 
        + IMemUse% Incl.MemUse(bytes)的百分比 
        + Excl.MemUse(bytes) 函数执行本身内存,以字节算 
        + EMemUse% Excl.MemUse(bytes)的百分比 
   - 消耗内存峰值 
        + Incl.PeakMemUse(bytes) Incl.MemUse的峰值 
        + IPeakMemUse% Incl.PeakMemUse(bytes) 的峰值百分比 
        + Excl.PeakMemUse(bytes) Excl.MemUse的峰值 
        + EPeakMemUse% EMemUse% 峰值百分比
* 黄色最耗时路径
* 红色是瓶颈

```sh
git clone https://github.com/longxinH/xhprof
cd xhprof/extension/
/usr/local/php/bin/phpize
./configure --with-php-config=/usr/local/Cellar/php/7.3.6/bin/php-config --enable-xhprof
make&&make install
# 配置
[xhprof]
extension=xhprof.so
xhprof.output_dir = /Users/henry/Workspace/www/xhprof # 该目录自由定义即可,用来保存xhprof生成的源文件

## 重启PHP服务
kill -USR2 `cat /opt/php-7.0.14/var/run/php-fpm.pid`

sudo pecl install channel://pecl.php.net/xhprof-0.9.4

yum install graphviz # 性能图渲染

# 使用
xhprof_enable(); # 需要分析的代码

##  Code

$xhprof_data = xhprof_disable();
include_once ROOT_PATH.'/xhprof_lib/utils/xhprof_lib.php';
include_once ROOT_PATH . '/xhprof_lib/utils/xhprof_runs.php';
$xhprof_runs = new XHProfRuns_Default();
$run_id = $xhprof_runs->save_run($xhprof_data, "xhprof_test"); # 将run_id保存起来或者随代码一起输出

# 查看结果
$host_url/xhpfrof_html/index.php?run=58d3b28b521f6&source=xhprof_test

# 项目中
<?php
namespace backend\component;

use Yii;
use common\component\baseController;

class backendBaseController extends baseController
{
    public $layout = "/content";
    public $enableCsrfValidation = false;

    public static $profiling = 0;

    public function init(){
        parent::init();

        self::$profiling = 1;// !(mt_rand() % 9);
        if  (self::$profiling) {
            xhprof_enable(XHPROF_FLAGS_CPU | XHPROF_FLAGS_MEMORY);
        }
    }

    public function __destruct()
    {
        if(self::$profiling){
            $data = xhprof_disable();
            //$_SERVER['XHPROF_ROOT_PATH'] 该环境变量由第3步得来
            include_once $_SERVER['XHPROF_ROOT_PATH'] . "/xhprof_lib/utils/xhprof_lib.php";
            include_once $_SERVER['XHPROF_ROOT_PATH'] . "/xhprof_lib/utils/xhprof_runs.php";
            $x = new XHProfRuns_Default();

            //当前路由
            $routeName = Yii::$app->requestedRoute;
            //路由为空，则说明是首页
            if (empty($routeName)){
                $routeName = Yii::$app->defaultRoute;
            }

            //拼接xhprof分析结果保存文件名
            $xhprofFilename = str_replace('/', '_', $routeName).'_'.date('Ymd_His');
            $x->save_run($data, $xhprofFilename);
        }
    }
}
```

## 性能

* 测试
    - 压测
        + ab `ab -n1000 -c10 https://www.baidu.com/`  -n请求数 -c并发数,结果看下面参数
            * requests per second
            * time per request
    - `time php php-src/Zend/micro_bench.php` :查看 user 参数
    - XHPorf
* 语言级
    - 编译解析开销:zend逐行扫描 分析 成zend能识别的语法解析成opcode（内置方法生成opcode 少）执行
        + 用语言内置函数:已做优化，比自己实现的方法优化
        + 内置函数性能：知道方法的时间复杂度 比如：isset arrat_key_exists
        + 魔法函数性能不佳
        + 产生错误抑制符：代码前后改变错误等级 error_reporting 前面忽略 后面还原，通过vld:查看opcode
    - 合理使用内存：unset释放掉
        - unset注销不掉
    - 正则 回溯开销大
    - 避免循环内运算：for中 length 放在外面
    - 减少密集运算：开销比C大
    - 带引号字符串作为键值
* 周边：系统依赖，找到问题核心
    - php是串行执行的
    - 文件操作性能：读写内存 << 读写数据库 << 读写磁盘 << 读写网络（网络延时）
    - 硬件
        + 运行环境linux
        + 硬盘 文件存储
        + 内存：memache 热数据
    - 软件
        + 数据库
    - 网络：减少网络请求
        + 对方接口不确定
        + 网络稳定性
        + 设置超时
            * 连接超时 800ms
            * 读超时 200ms
            * 写超时 500ms
        + 串行并行化
            * curl_multi依赖最长
            * swoole
    - 压缩PHP输出 Gzip
        + 快
        + 服务器、客户端：额外CPU开销
        + 大于100k使用,根据内容重复度压缩后
    - 缓存
        + 重复请求 内容不变
        + smarty: 开启caching
    - 重叠时间窗口
        + 前提是后任务不强依赖前一任务
        + 旁路方案
* 方法
    - APC：Opcache缓存
        + yac
    - 扩展实现高频逻辑
    - runtime优化:HHVM

## web

* apache
    - module
    - CGI
    - php-fpm

```php
<?php header("Content-type: text/html; charset=utf-8"); ?>
```

## 控制反转（Inversion of Control，缩写为IoC）

* 面向对象编程中的一种设计原则，可以用来减低代码之间的耦合度，为相互依赖的组件提供抽象，将依赖的获取交给第三方来控制，即依赖对象不在被依赖的模块中获取
* 方式
    - 依赖注入（Dependency Injection，简称DI）：构造函数注入 或者 属性注入
    - 依赖查找（Dependency Lookup）
* 控制反转：对象在被创建的时候，由一个调控系统内所有对象的外界实体，将其所依赖的对象的引用传递(注入)给它，由外部负责其依赖需求
* 依赖倒置(Dependence Inversion Principle,DIP) 是一种抽象的软件设计原则
    - 高层模块不应依赖于低层模块，底层的模块要依赖于高层模块定义的接口,两者应该依赖于抽象
    - 抽象不应该依赖于实现，实现应该依赖于抽象
    - 电脑就相当于是高层模块，而 U盘、鼠标等就相当于是底层模块。电脑定义了一个插口（接口），可以供其他的设备插入使用，但是电脑并不依赖于具体要插入的设备，它只是定义好了一个接口规范，只要是符合这个接口规范的设备都可以插入到这台电脑上来使用
* IOC 容器功能：
    - 自动的管理依赖关系，避免手工管理的缺陷
    - 再需要使用依赖的时候自动的为我们注入所需依赖
    - 管理对象的声明周期
    - 利用反射类来完成容器的自动注入

```php
interface DbDrive
{
    public function insert();
}

/**
 * Class MysqlDb
 *
 * @since 2.0
 */
class MysqlDb implements DbDrive
{
    public function insert()
    {
        //TODO::插入一些数据
    }
}

/**
 * Class MongoDb
 *
 * @since 2.0
 */
class MongoDb implements DbDrive
{
    public function insert()
    {
        //TODO::插入一些数据
    }
}

/**
 * Class Order
 *
 * @since 2.0
 */
class Order
{
    /**
     * @var DbDrive
     */
    private $db;

    /**
     * Order constructor.
     *
     * @param DbDrive $driver
     */
    public function __construct(DbDrive $driver)
    {
        $this->db = $driver;
    }

    public function add()
    {
        //TODO::订单业务
        $this->db->insert();//执行入库操作
    }
}

$db = new MysqlDb();//创建一个依赖
$order = new Order($db);//将需要依赖的对象通过构造函数传递进去
$order->add();//正常的去调用业务

# IOC 容器
<?php

/**
 * Class Container
 */
class Container
{
    /**
     * 容器内所管理的所有实例
     * @var array
     */
    protected $instances = [];

    /**
     * @param $class
     * @param null $concrete
     */
    public function set($class, $concrete = null)
    {
        if ($concrete === null) {
            $concrete = $class;
        }
        $this->instances[$class] = $concrete;
    }

    /**
     * 获取目标实例
     *
     * @param $class
     * @param array $param
     *
     * @return mixed|null|object
     * @throws Exception
     */
    public function get($class, ...$param)
    {
        // 如果容器中不存在则注册到容器
        if (!isset($this->instances[$class])) {
            $this->set($class);
        }
        //解决依赖并返回实例
        return $this->resolve($this->instances[$class], $param);
    }

    /**
     * 解决依赖
     *
     * @param $class
     * @param $param
     *
     * @return mixed|object
     * @throws ReflectionException
     * @throws Exception
     */
    public function resolve($class, $param)
    {
        if ($class instanceof Closure) {
            return $class($this, $param);
        }
        $reflector = new ReflectionClass($class);
        // 检查类是否可以实例化
        if (!$reflector->isInstantiable()) {
            throw new Exception("{$class} 不能被实例化");
        }
        // 通过反射获取到目标类的构造函数
        $constructor = $reflector->getConstructor();
        if (is_null($constructor)) {
            // 如果目标没有构造函数则直接返回实例化对象
            return $reflector->newInstance();
        }

        // 获取构造函数参数
        $parameters = $constructor->getParameters();
        //获取到构造函数中的依赖
        $dependencies = $this->getDependencies($parameters);
        // 解决掉所有依赖问题并返回实例
        return $reflector->newInstanceArgs($dependencies);
    }

    /**
     * 解决依赖关系
     *
     * @param $parameters
     *
     * @return array
     * @throws Exception
     */
    public function getDependencies($parameters)
    {
        $dependencies = [];
        foreach ($parameters as $parameter) {
            $dependency = $parameter->getClass();
            if ($dependency === null) {
                // 检查是否有默认值
                if ($parameter->isDefaultValueAvailable()) {
                    // 获取参数默认值
                    $dependencies[] = $parameter->getDefaultValue();
                } else {
                    throw new Exception("无法解析依赖关系 {$parameter->name}");
                }
            } else {
                // 重新调用get() 方法获取需要依赖的类到容器中。
                $dependencies[] = $this->get($dependency->name);
            }
        }

        return $dependencies;
    }
}

class MysqlDb
{
    public function insert()
    {
        echo 'mysql';
    }
}

class Order
{
    private $db;

    public function __construct(MysqlDb $db)
    {
        $this->db = $db;
    }

    public function add()
    {
        $this->db->insert();
    }

}

$container = new Container();//使用容器
$order = $container->get('Order');//通过容器拿到我们的Order类
$order->add();//正常的使用业务
```

## curl

* 选项的值将被作为长整形使用(在option参数中指定)：
    - CURLOPT_INFILESIZE: 上传一个文件到远程站点，这个选项告诉PHP你上传文件的大小。
    - CURLOPT_VERBOSE: 想CURL报告每一件意外的事情，设置这个选项为一个非零值。
    - CURLOPT_HEADER: 想把一个头包含在输出中，设置这个选项为一个非零值。
    - CURLOPT_NOPROGRESS: 不会PHP为CURL传输显示一个进程条，设置这个选项为一个非零值。注意：PHP自动设置这个选项为非零值，e仅仅为了调试的目的来改变这个选项。
    - CURLOPT_NOBODY: 不想在输出中包含body部分，设置这个选项为一个非零值
    - CURLOPT_FAILONERROR: 想让PHP在发生错误(HTTP代码返回大于等于300)时，不显示，设置这个选项为一人非零值。默认行为是返回一个正常页，忽略代码。
    - CURLOPT_UPLOAD: 想让PHP为上传做准备，设置这个选项为一个非零值。
    - CURLOPT_POST: 想PHP去做一个正规的HTTP POST，设置这个选项为一个非零值。这个POST是普通的 application/x-www-from-urlencoded 类型，多数被HTML表单使用。
    - CURLOPT_FTPLISTONLY: 设置这个选项为非零值，PHP将列出FTP的目录名列表。
    - CURLOPT_FTPAPPEND: 设置这个选项为一个非零值，PHP将应用远程文件代替覆盖它。
    - CURLOPT_NETRC: 设置这个选项为一个非零值，PHP将在你的 ~./netrc 文件中查找你要建立连接的远程站点的用户名及密码。
    - CURLOPT_FOLLOWLOCATION: 设置这个选项为一个非零值(象 “Location: “)的头，服务器会把它当做HTTP头的一部分发送(注意是递归的，PHP将发送形如 “Location: “的头)。
    - CURLOPT_PUT: 设置这个选项为一个非零值去用HTTP上传一个文件。要上传这个文件必须设置CURLOPT_INFILE和CURLOPT_INFILESIZE选项.
    - CURLOPT_MUTE: 设置这个选项为一个非零值，PHP对于CURL函数将完全沉默。
    - CURLOPT_TIMEOUT: 设置一个长整形数，作为最大延续多少秒 告诉成功 PHP 从服务器接收缓冲完成前需要等待多长时间 **响应超时**
    - CURLOPT_LOW_SPEED_LIMIT: 设置一个长整形数，控制传送多少字节。
    - CURLOPT_LOW_SPEED_TIME: 设置一个长整形数，控制多少秒传送CURLOPT_LOW_SPEED_LIMIT规定的字节数。
    - CURLOPT_RESUME_FROM: 传递一个包含字节偏移地址的长整形参数，(你想转移到的开始表单)。
    - CURLOPT_SSLVERSION: 传递一个包含SSL版本的长参数。默认PHP将被它自己努力的确定，在更多的安全中你必须手工设置。
    - CURLOPT_TIMECONDITION: 传递一个长参数，指定怎么处理CURLOPT_TIMEVALUE参数。可以设置这个参数为TIMECOND_IFMODSINCE 或 TIMECOND_ISUNMODSINCE。这仅用于HTTP
    - CURLOPT_CONNECTTIMEOUT:告诉 PHP 在成功连接服务器前等待多久 **连接超时**
    - CURLOPT_TIMEVALUE: 传递一个从1970-1-1开始到现在的秒数。这个时间将被CURLOPT_TIMEVALUE选项作为指定值使用，或被默认TIMECOND_IFMODSINCE使用。
* 选项的值将被作为字符串：
    - CURLOPT_URL: 这是想用PHP取回的URL地址。也可以在用curl_init()函数初始化时设置这个选项。
    - CURLOPT_USERPWD: 传递一个形如[username]:[password]风格的字符串,作用PHP去连接。
    - CURLOPT_PROXYUSERPWD: 传递一个形如[username]:[password] 格式的字符串去连接HTTP代理。
    - CURLOPT_RANGE: 传递一个想指定的范围。它应该是”X-Y”格式，X或Y是被除外的。HTTP传送同样支持几个间隔，用逗句来分隔(X-Y,N-M)。
    - CURLOPT_POSTFIELDS: 传递一个作为HTTP “POST”操作的所有数据的字符串。
    - CURLOPT_REFERER: 在HTTP请求中包含一个”referer”头的字符串。
    - CURLOPT_USERAGENT: 在HTTP请求中包含一个”user-agent”头的字符串。
    - CURLOPT_FTPPORT: 传递一个包含被ftp “POST”指令使用的IP地址。这个POST指令告诉远程服务器去连接我们指定的IP地址。这个字符串可以是一个IP地址，一个主机名，一个网络界面名(在UNIX下)，或是‘-'(使用系统默认IP地址)。
    - CURLOPT_COOKIE: 传递一个包含HTTP cookie的头连接。
    - CURLOPT_SSLCERT: 传递一个包含PEM格式证书的字符串。
    - CURLOPT_SSLCERTPASSWD: 传递一个包含使用CURLOPT_SSLCERT证书必需的密码。
    - CURLOPT_COOKIEFILE: 传递一个包含cookie数据的文件的名字的字符串。这个cookie文件可以是Netscape格式，或是堆存在文件中的HTTP风格的头。
    - CURLOPT_CUSTOMREQUEST: 当进行HTTP请求时，传递一个字符被GET或HEAD使用。为进行DELETE或其它操作是有益的，更Pass a string to be used instead of GET or HEAD when doing an HTTP request. This is useful for doing or another, more obscure, HTTP request. 注意: 在确认的服务器支持命令先不要去这样做。下列的选项要求一个文件描述(通过使用fopen()函数获得)：　
    - CURLOPT_FILE: 这个文件将是放置传送的输出文件，默认是STDOUT.
    - CURLOPT_INFILE: 这个文件是传送过来的输入文件。
    - CURLOPT_WRITEHEADER: 这个文件写有输出的头部分。
    - CURLOPT_STDERR: 这个文件写有错误而不是stderr。用来获取需要登录的页面的例子,当前做法是每次或许都登录一次,有需要的人再做改进了.

## APCu

## 正则表达式 PREG

* 元字符
    - .   匹配除换行符以外的任意字符
    - \w  匹配字母或数字或下划线或汉字
    - \s  匹配任意的空白符
    - \d  匹配数字
    - \b  匹配单词的开始或结束
    - ^   匹配字符串的开始
    - $   匹配字符串的结束
* 字符转义:要查找特殊意义字符`.`，或者`*`,使用\来取消。使用`\\.` `\\\*` `\\\`
* 重复
    - `*`   重复零次或更多次
    - `+`   重复一次或更多次
    - ?   重复零次或一次
    - {n} 重复n次
    - {n,}    重复n次或更多次
    - {n,m}   重复n到m次
* 字符类
    - [“your set”]：如[aeiou]，则匹配a，e，i，o和u中的任意一个，同理[.?!]匹配标点符号(.或?或!)
    - [0-9]：与\d就是完全一致，表示一位数字
    - [a-zA-Z]：表示一个字母，[a-z0-9A-Z]等同于\w(当然值考虑英文的话)
    - `\(?0\d{2}[)-]?\d{8}` # (010)88886666，或022-22334455，或02912345678等
    -  \ 将下一个字符标记为一个特殊字符、或一个原义字符、或一个 向后引用、或一个八进制转义符。例如，'n' 匹配字符 "n"。'\n' 匹配一个换行符。序列 '\' 匹配 "" 而 "\(" 则匹配 "("。
    -   ^   匹配输入字符串的开始位置。如果设置了 RegExp 对象的 Multiline 属性，^ 也匹配 '\n' 或 '\r' 之后的位置。
    -   $   匹配输入字符串的结束位置。如果设置了RegExp 对象的 Multiline 属性，$ 也匹配 '\n' 或 '\r' 之前的位置。
    -   *   匹配前面的子表达式零次或多次。例如，zo* 能匹配 "z" 以及 "zoo"。* 等价于{0,}。
    -   +   匹配前面的子表达式一次或多次。例如，'zo+' 能匹配 "zo" 以及 "zoo"，但不能匹配 "z"。+ 等价于 {1,}。
    -   ?   匹配前面的子表达式零次或一次。例如，"do(es)?" 可以匹配 "do" 或 "does" 中的"do" 。? 等价于 {0,1}。
    -   {n} n 是一个非负整数。匹配确定的 n 次。例如，'o{2}' 不能匹配 "Bob" 中的 'o'，但是能匹配 "food" 中的两个 o。
    -   {n,}    n 是一个非负整数。至少匹配n 次。例如，'o{2,}' 不能匹配 "Bob" 中的 'o'，但能匹配 "foooood" 中的所有 o。'o{1,}' 等价于 'o+'。'o{0,}' 则等价于 'o*'。
    -   {n,m}   m 和 n 均为非负整数，其中n <= m。最少匹配 n 次且最多匹配 m 次。例如，"o{1,3}" 将匹配 "fooooood" 中的前三个 o。'o{0,1}' 等价于 'o?'。请注意在逗号和两个数之间不能有空格。
    -   ?   当该字符紧跟在任何一个其他限制符 (*, +, ?, {n}, {n,}, {n,m}) 后面时，匹配模式是非贪婪的。非贪婪模式尽可能少的匹配所搜索的字符串，而默认的贪婪模式则尽可能多的匹配所搜索的字符串。例如，对于字符串 "oooo"，'o+?' 将匹配单个 "o"，而 'o+' 将匹配所有 'o'。
    -   .   匹配除 "\n" 之外的任何单个字符。要匹配包括 '\n' 在内的任何字符，请使用象 '[.\n]' 的模式。
    -   [xyz]   字符集合。匹配所包含的任意一个字符。例如， '[abc]' 可以匹配 "plain" 中的 'a'。
    -   [^xyz]  负值字符集合。匹配未包含的任意字符。例如， '[^abc]' 可以匹配 "plain" 中的'p'、'l'、'i'、'n'。
    -   [a-z]   字符范围。匹配指定范围内的任意字符。例如，'[a-z]' 可以匹配 'a' 到 'z' 范围内的任意小写字母字符。
    -   [^a-z]  负值字符范围。匹配任何不在指定范围内的任意字符。例如，'[^a-z]' 可以匹配任何不在 'a' 到 'z' 范围内的任意字符。
    -   \b  匹配一个单词边界，也就是指单词和空格间的位置。例如， 'er\b' 可以匹配"never" 中的 'er'，但不能匹配 "verb" 中的 'er'。
    -   \B  匹配非单词边界。'er\B' 能匹配 "verb" 中的 'er'，但不能匹配 "never" 中的 'er'。
    -   \cx 匹配由 x 指明的控制字符。例如， \cM 匹配一个 Control-M 或回车符。x 的值必须为 A-Z 或 a-z 之一。否则，将 c 视为一个原义的 'c' 字符。
    -   \d  匹配一个数字字符。等价于 [0-9]。
    -   \D  匹配一个非数字字符。等价于 [^0-9]。
    -   \f  匹配一个换页符。等价于 \x0c 和 \cL。
    -   \n  匹配一个换行符。等价于 \x0a 和 \cJ。
    -   \r  匹配一个回车符。等价于 \x0d 和 \cM。
    -   \s  匹配任何空白字符，包括空格、制表符、换页符等等。等价于 [ \f\n\r\t\v]。
    -   \S  匹配任何非空白字符。等价于 [^ \f\n\r\t\v]。
    -   \t  匹配一个制表符。等价于 \x09 和 \cI。
    -   \v  匹配一个垂直制表符。等价于 \x0b 和 \cK。
    -   \w  匹配包括下划线的任何单词字符。等价于'[A-Za-z0-9_]'。
    -   \W  匹配任何非单词字符。等价于 '[^A-Za-z0-9_]'。
    -   \xn 匹配 n，其中 n 为十六进制转义值。十六进制转义值必须为确定的两个数字长。例如，'\x41' 匹配 "A"。'\x041' 则等价于 '\x04' & "1"。正则表达式中可以使用 ASCII 编码。
    -   \num    匹配 num，其中 num 是一个正整数。对所获取的匹配的引用。例如，'(.)\1' 匹配两个连续的相同字符。
    -   \n  标识一个八进制转义值或一个向后引用。如果 \n 之前至少 n 个获取的子表达式，则 n 为向后引用。否则，如果 n 为八进制数字 (0-7)，则 n 为一个八进制转义值。
    -   \nm 标识一个八进制转义值或一个向后引用。如果 \nm 之前至少有 nm 个获得子表达式，则 nm 为向后引用。如果 \nm 之前至少有 n 个获取，则 n 为一个后跟文字 m 的向后引用。如果前面的条件都不满足，若 n 和 m 均为八进制数字 (0-7)，则 \nm 将匹配八进制转义值 nm。
    -   \nml    如果 n 为八进制数字 (0-3)，且 m 和 l 均为八进制数字 (0-7)，则匹配八进制转义值 nml。
    -   \un 匹配 n，其中 n 是一个用四个十六进制数字表示的 Unicode 字符。例如， \u00A9 匹配版权符号 (?)。
    -   \(pattern\) 匹配pattern 并获取这一匹配。所获取的匹配可以从产生的Matches集合得到，在VBScript 中使用SubMatches集合，在JScript 中则使用 $0…$9 属性。要匹配圆括号字符，请使用 '\(' 或 '\)'。        -
    -   \(?:pattern\) 匹配pattern但不获取匹配结果，也就是说这是一个非获取匹配，不进行存储供以后使用。这在使用 "或" 字符“|”来组合一个模式的各个部分是很有用。
    -   例如，“industr\(?:y|ies\)”就是一个比 “industry|industries” 更简略的表达式。     -
    -   \(?=pattern\) 正向预查，在任何匹配pattern的字符串开始处匹配查找字符串。这是一个非获取匹配，也就是说，该匹配不需要获取供以后使用。例如，'Windows (?=95|98|NT|2000)' 能匹配 "Windows 2000" 中的 "Windows" ，但不能匹配"Windows 3.1" 中的 "Windows"。预查不消耗字符，也就是说，在一个匹配发生后，在最后一次匹配之后立即开始下一次匹配的搜索，而不是从包含预查的字符之后开始。     -
    -   (?!pattern) 负向预查，在任何不匹配 pattern 的字符串开始处匹配查找字符串。这是一个非获取匹配，也就是说，该匹配不需要获取供以后使用。例如'Windows (?!95|98|NT|2000)' 能匹配 "Windows 3.1" 中的 "Windows"，但不能匹配 "Windows 2000" 中的 "Windows"。预查不消耗字符，也就是说，在一个匹配发生后，在最后一次匹配之后立即开始下一次匹配的搜索，而不是从包含预查的字符之后开始。     -
    -   x|y 匹配x或y。例如，'z|food' 能匹配 "z" 或 "food"。'(z|f)ood' 则匹配 "zood" 或 "food"。

如果你认真去看例4-1，发现那个表达式也能匹配010)12345678或(022-87654321这样的“不正确”的格式。要解决这个问题，我们需要用到分枝条件。

正则表达式里的分枝条件指的是有几种规则，如果满足其中任意一种规则都应该当成匹配，具体方法是用|（竖线）把不同的规则分隔开

例5-1：0\d{2}-\d{8}|0\d{3}-\d{7}

分析：这个表达式能匹配两种以连字号分隔的电话号码：一种是三位区号，8位本地号(如：010-12345678)，一种是4位区号，7位本地号(如：0376-2233445)，0\d{2}-\d{8}表示“0”加两数字加“-”加8个数字，0\d{3}-\d{7}表示“0”加三数字加“-”加7个数字，|可理解为“或”。就是查找与前者相匹配或者与后者相匹配的内容。

注意：使用分枝条件时，要注意各个条件的顺序。因为匹配分枝条件时，将会从左到右地测试每个条件，如果满足了某个分枝的话，就不会去再管其它的条件了。如：\d{5}-\d{4}|\d{5}和\d{5}|\d{5}-\d{4}是不同的。

* 分组：用小括号来指定子表达式，然后就可以指定这个子表达式的重复次数了 `(\d{1,3}.){3}\d{1,3}`

分析：这是一个简单的IP地址匹配表达式。要理解这个表达式，请按下列顺序分析它：\d{1,3}匹配1到3位的数字，(\d{1,3}\.) {3}匹配三位数字加上一个英文句号(这个整体也就是这个分组)重复3次，最后再加上一个一到三位的数字\d{1,3}。

不幸的是，它也将匹配256.300.888.999这种不可能存在的IP地址。如果能使用算术比较的话，或许能简单地解决这个问题，但是正则表达式中并不提供关于数学的任何功能，所以只能使用冗长的分组，选择，字符类来描述一个正确的IP地址：((2[0-4]\d|25[0-5]|[01]?\d\d?).){3}(2[0-4]\d|25[0-5]|[01]?\d\d?)。

* 反义
    - \W  匹配任意不是字母，数字，下划线，汉字的字符
    - \S  匹配任意不是空白符的字符
    - \D  匹配任意非数字的字符
    - \B  匹配不是单词开头或结束的位置
    - [^x]    匹配除了x以外的任意字符
    - [^aeiou]    匹配除了aeiou这几个字母以外的任意字符
* 后向引用：使用小括号指定一个子表达式后，匹配这个子表达式的文本(也就是此分组捕获的内容)可以在表达式或其它程序中作进一步的处理
    - 默认情况下，每个分组会自动拥有一个组号，规则是：从左向右，以分组的左括号为标志，第一个出现的分组的组号为1，第二个为2，以此类推。
    - 后向引用用于重复搜索前面某个分组匹配的文本。例如，\1代表分组1匹配的文本。

例8-1：\b(\w+)\b\s+\1\b

分析：可以匹配重复的单词，像go go, 或者kitty kitty。这个表达式首先是一个单词，也就是单词开始处和结束处之间的多于一个的字母或数字\b(\w+)\b，这个单词会被捕获到编号为1的分组中，然后是1个或几个空白符\s+，最后是分组1中捕获的内容（也就是前面匹配的那个单词）\1。


对一个正则表达式模式或部分模式两边添加圆括号将导致相关匹配存储到一个临时缓冲区中，所捕获的每个子匹配都按照在正则表达式模式中从左至右所遇到的内容存储。存储子匹配的缓冲区编号从 1 开始，连续编号直至最大 99 个子表达式。每个缓冲区都可以使用 '\n' 访问，其中 n 为一个标识特定缓冲区的一位或两位十进制数。

可以使用非捕获元字符 '?:', '?=', or '?!' 来忽略对相关匹配的保存。

* 常用分组语法
    - 捕获  (exp)   匹配exp,并捕获文本到自动命名的组里
    - (?<name>exp)    匹配exp,并捕获文本到名称为name的组里，也可以写成(?'name'exp)
    - (?:exp) 匹配exp,不捕获匹配的文本，也不给此分组分配组号
    - 零宽断言    (?=exp) 匹配exp前面的位置
    - (?<=exp)    匹配exp后面的位置
    - (?!exp) 匹配后面跟的不是exp的位置
    - `(?<!exp)`    匹配前面不是exp的位置
    - 注释  (?#comment) 这种类型的分组不对正则表达式的处理产生任何影响，用于提供注释让人阅读
* 贪婪与懒惰
    当正则表达式中包含能接受重复的限定符时，通常的行为是（在使整个表达式能得到匹配的前提下）匹配尽可能多的字符。以这个表达式为例：a.\*b，它将会匹配最长的以a开始，以b结束的字符串。如果用它来搜索aabab的话，它会匹配整个字符串aabab。这被称为贪婪匹配。
    有时，我们更需要懒惰匹配，也就是匹配尽可能少的字符。前面给出的限定符都可以被转化为懒惰匹配模式，只要在它后面加上一个问号?。这样.\*?就意味着匹配任意数量的重复，但是在能使整个匹配成功的前提下使用最少的重复。现在看看懒惰版的例子吧：
    a.*?b匹配最短的，以a开始，以b结束的字符串。如果把它应用于aabab的话，它会匹配aab（第一到第三个字符）和ab（第四到第五个字符）。注意：最先开始的匹配拥有最高的优先权
    - *?  重复任意次，但尽可能少重复
    - +?  重复1次或更多次，但尽可能少重复
    - ??  重复0次或1次，但尽可能少重复
    - {n,m}?  重复n到m次，但尽可能少重复
    - {n,}?   重复n次以上，但尽可能少重复
* 模式修正符
    - i：模式中的字符将同时匹配大小写字母。
    - m：“行起始”和“行结束”除了匹配整个字符串开头和结束外，还分别匹配其中的换行符的之后和之前。
    - s：模式中的圆点元字符（.）匹配所有的字符，包括换行符。没有此设定的话，则不包括换行符。
    - x：模式中的空白字符除了被转义的或在字符类中的以外完全被忽略，在未转义的字符类之外的 #以及下一个换行符之间的所有字符，包括两头，也都被忽略。
    - e：如果设定了此修正符，preg_replace() 在替换字符串中对逆向引用作正常的替换，
    - ?在 . + 和 * 之后 表示非贪婪匹配: *、+和?限定符都是贪婪的，因为它们会尽可能多的匹配文字，只有在它们的后面加上一个?就可以实现非贪婪或最小匹配。
* 参考
    - [五分钟，正则表达式不再是你的烦恼](https://www.jianshu.com/p/4f258d81ff4c)
    - https://www.w3cschool.cn/regexp/jhbv1pr1.html
    - https://www.cnblogs.com/yelons/p/6644579.html
    - https://www.cnblogs.com/longdaye/p/8001221.html
    - https://blog.csdn.net/kkobebryant/article/details/267527
    - http://www.jb51.net/article/77428.htm
    - https://www.cnblogs.com/hellohell/p/5718319.html

```
<?php
$string = "上飞机离开我<img border='0' alt='' src='/uploadfile/2009/0921/20090921091612567.jpg' border='0' />sdfsdf";

$su = preg_match("/ \<[ ]*img.*src[ ]*\=[ ]*[\"|\'](.+?)[\"|\'] /", $string,$match); // 匹配src=的内容
print_r($match[1]); // 输出 /uploadfile/2009/0921/20090921091612567.jpg

$su = preg_match("/ \<[ ]*img.*src[ ]*\=[ ]*[\"|\'](.+)[\"|\'] /", $string,$match);
print_r($match[1]); // 输出 /uploadfile/2009/0921/20090921091612567.jpg' border='
?>

用户名: ^[a-z0-9_-]{3,16}$
密码: ^[a-z0-9_-]{6,18}$
十六进制值: ^#?([a-f0-9]{6}|[a-f0-9]{3})$
电子邮箱: ^([a-z0-9_.-]+)@([\da-z.-]+).([a-z.]{2,6})$
URL: ^(https?://)?([\da-z.-]+).([a-z.]{2,6})([/\w .-]*)*/?$
IP 地址: ^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?).){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$
HTML 标签: <([a-z]+)([<]+)*(?:>(.*)</\1>|\s+/>)$
Unicode编码中的汉字范围： ^[u4e00-u9fa5],{0,}$
匹配中文字符的正则表达式： [\u4e00-\u9fa5]
匹配双字节字符(包括汉字在内)： [^\x00-\xff]
匹配空白行的正则表达式： \n\s*\r
匹配HTML标记的正则表达式： <(\S*?)[^>]*>.*?</\1>|<.*? />
匹配首尾空白字符的正则表达式： ^\s*|\s*$
匹配Email地址的正则表达式： \w+([-+.]\w+)*@\w+([-.]\w+)*.\w+([-.]\w+)*
匹配网址URL的正则表达式： [a-zA-z]+://[^\s]*
匹配帐号是否合法(字母开头，允许5-16字节，允许字母数字下划线)： ^[a-zA-Z][a-zA-Z0-9_]{4,15}$
匹配国内电话号码： \d{3}-\d{8}|\d{4}-\d{7}
匹配腾讯QQ号： [1-9][0-9]{4,}
匹配中国大陆邮政编码： [1-9]\d{5}(?!\d)
匹配身份证： \d{15}|\d{18}
匹配ip地址： ((2[0-4]\d|25[0-5]|[01]?\d\d?).){3}(2[0-4]\d|25[0-5]|[01]?\d\d?)

^[1-9]\d*$　 　 //匹配正整数
^-[1-9]\d*$ 　 //匹配负整数
^-?[1-9]\d*$　　 //匹配整数
^[1-9]\d*|0$　 //匹配非负整数（正整数 + 0）
^-[1-9]\d*|0$　　 //匹配非正整数（负整数 + 0）
^[1-9]\d*.\d*|0.\d*[1-9]\d*$　　 //匹配正浮点数
^-([1-9]\d*.\d*|0.\d*[1-9]\d*)$　 //匹配负浮点数
^-?([1-9]\d*.\d*|0.\d*[1-9]\d*|0?.0+|0)$　 //匹配浮点数
^[1-9]\d*.\d*|0.\d*[1-9]\d*|0?.0+|0$　　 //匹配非负浮点数（正浮点数 + 0）
^(-([1-9]\d*.\d*|0.\d*[1-9]\d*))|0?.0+|0$　　//匹配非正浮点数（负浮点数 + 0）
评注：处理大量数据时有用，具体应用时注意修正

^[A-Za-z]+$　　//匹配由26个英文字母组成的字符串
^[A-Z]+$　　//匹配由26个英文字母的大写组成的字符串
^[a-z]+$　　//匹配由26个英文字母的小写组成的字符串
^[A-Za-z0-9]+$　　//匹配由数字和26个英文字母组成的字符串
^\w+$　　//匹配由数字、26个英文字母或者下划线组成的字符串
```

## 禁止

*  不要使用 `mysql_` 函数：从核心中全部移除了

## PHP能力

用工具来实现想法，不管是自己的想法还是他人的需求，学会转化

* 平静的心态：遇事不可急躁，不可轻言放弃，而是需要静静的思考
* 问题解决思路
    - 编码问题
    - PHP和SQL数据库执行效率问题
    - Session和Cookie域和加密解析问题
    - 程序的执行顺序问题
    - 程序编写的多环境适用问题
    - 分类的构建和结构设计问题
    - 字符串处理问题：正则表达式处理或简单PHP字符串处理函数来处理
    - 各种模板引擎的编写局限性问题
    - PHP和web端数据交互问题（如ajax，接口调用等）
* PHP基础知识：过硬的基础知识会让你在项目开发过程中游刃有余
    - 语法规则
    - MYSQL各种sql语句的写法，增删改查基本的不说了,in(),union,left(),leftjoin,as,replace,alter table,where的字段排序,各种索引建立的方法要特别熟悉
    - 会自己搭建LAMP环境和WAMP环境，用集成软件一键式安装的不算。开发程序，对于自己开发的环境构建结构都不清楚，怎么排查问题？所以至少要会用对立的msi文件来安装自己需要的开发环境。安装3-5遍成功，这个算还行，还得会安装各种扩展，配置apache服务，知道各种参数设置的地方以及知道怎么设置各种参数；会linux操作系统的基本命令。
    - 熟悉web方面的其他程序，因为PHP不是一个完全独立的东西，他是一个和其他语言和要素配合来完成一个项目的，如果对其他语言和要素不太熟悉，在团队协作过程中会非常吃力。这些其他要素包括：html，javascript，jquery，xml，http协议，正则表达式等
* 综合的互联网应用及项目管理知识和素养
    - 见识广博，擅于学习：不要只顾着天天编程，学会抽点时间去看看一些大型开源系统的架构思路，以及大型商务网站的构建方式。向他们学习，补充自己的不足。比如至少该晓得不同类型的开源系统有哪些吧，比如Uchome,dede,phpcms,wordpress,discuz,帝国等等看多了，会总结发现一些常规性的思路，比如缓存的机制，比如模板机制，比如静态页面生成等等。
    - 项目解决方案选型：不同需求，用不同的机构和选型。有些架构固然强大，但是用于小型项目也会很吃力，就是杀机不用牛刀。根据需求来选型很重要。选型不是随口就能定的，需要一个PHP程序员用于良好的储备，个人觉得至少需要以下储备，才具备选型能力：熟练应用至少一个PHP框架，两-三个PHP开源系统；拥有自己的一套应用系统。
    - 良好的项目管理素养：项目不是一直开发过程中，项目也会进入运营期，维护期，这样，具备良好的项目管理素养会使项目更加稳定，可控。良好的项目管理素养包括：
        + 良好的项目开发及维护习惯，记住：千万别为了一时的省力，造成后面多次的重复劳动。时时提醒自己将工作流程化，流程规划化，规范简单化。
        + 良好的多人合作管理意识：项目不是一个人的，是多人协作的产物，也是服务于大众的，因而，要提升协作意识，让相关人员一同来完善项目。
    - 丰富的项目开发应用经验：学理论，去考试或考核是学校里面的事儿，没有项目经验，就像满肚子经文，吐也难吐出。这就需要实际的项目将自己的知识去学会转化为需求实现。
    - 良好的开发规范
        + 代码可读性强：对象，方法，函数的注释；一套成熟的命名规范；
        + 代码冗余度底：程序和文件的重用性大，高内聚，低耦合
        + 执行效率高：用最简单的程序流程实现应用需求，勿扰大弯子
        + 代码安全性好：做一名警惕的程序员，任何有用户输入和上传文件的地方都得额外谨慎，也许一个程序员一时的疏忽就会导致一个系统顷刻间崩溃。


## 第一阶段：基础阶段（基础PHP程序员）

重点：把LNMP搞熟练（核心是安装配置基本操作)

目标：能够完成基本的LNMP系统安装，简单配置维护；能够做基本的简单系统的PHP开发；能够在PHP中型系统中支持某个PHP功能模块的开发。

时间：完成本阶段的时间因人而异，有的成长快半年一年就过了，成长慢的两三年也有。

### Linux

基本命令、操作、启动、基本服务配置（包括rpm安装文件，各种服务配置等）
会写简单的shell脚本和awk/sed 脚本命令等。

### Nginx

做到能够安装配置nginx+php，知道基本的nginx核心配置选项，知道 server/fastcgi_pass/access_log 等基础配置，目标是能够让nginx+php_fpm顺利工作。

### MySQL

会自己搭建mysql，知道基本的mysql配置选项；知道innodb和myisam的区别，知道针对InnoDB和MyISAM两个引擎的不同配置选项；
知道基本的两个引擎的差异和选择上面的区别；能够纯手工编译搭建一个MySQL数据库并且配置好编码等正常稳定运行；核心主旨是能够搭建一个可运行的MySQL数据库。

### PHP

基本语法数组、字符串、数据库、XML、Socket、GD/ImageMgk图片处理等等；
熟悉各种跟MySQL操作链接的api（mysql/mysqli/PDO)，知道各种编码问题的解决；知道常规熟练使用的PHP框架（ThinkPHP、Zendframework、Yii、Yaf等）；
了解基本MVC的运行机制和为什么这么做，稍微知道不同的PHP框架之间的区别；
能够快速学习一个MVC框架。能够知道开发工程中的文件目录组织，有基本的良好的代码结构和风格，能够完成小系统的开发和中型系统中某个模块的开发工作。

### 前端

如果条件时间允许，可以适当学习下 HTML/CSS/JS 等相关知识，知道什么web标准，div+css的web/wap页面模式，知道HTML5和HTML4的区别；
了解一些基本的前端只是和JS框架（jQuery之类的）；
了解一些基本的JavaScript编程知识；（本项不是必须项，如果有时间，稍微了解一下是可以的，不过不建议作为重点，除非个人有强烈兴趣）

### 系统设计
能够完成小型系统的基本设计，包括简单的数据库设计，能够完成基本的浏览器 -< Nginx+PHP -< 数据库 架构的设计开发工作；
能够支撑每天几十万到数百万流量网站的开发维护工作；

## 第二阶段：提高阶段

重点：提高针对LNMP的技能，能够更全面的对LNMP有熟练的应用。
目标：能够随时随地搭建好LNMP环境，快速完成常规配置；能够追查解决大部分遇到的开发和线上环境的问题；能够独立承担中型系统的构架和开发工作；能够在大型系统中承担某个中型模块的开发工作；

### Linux

在第一阶段的基础上面，能够流畅的使用Shell脚本来完成很多自动化的工作；
awk/sed/perl 也操作的不错，能够完成很多文本处理和数据统计等工作；
基本能够安装大部分非特殊的Linux程序（包括各种库、包、第三方依赖等等，比如MongoDB/Redis/Sphinx/Luncene/SVN之类的）；
了解基本的Linux服务，知道如何查看Linux的性能指标数据，知道基本的Linux下面的问题跟踪等。

### Nginx:

在第一阶段的基础上面，了解复杂一些的Nginx配置；
包括 多核配置、events、proxy_pass，sendfile/tcp_*配置，知道超时等相关配置和性能影响；
知道nginx除了web server，还能够承担代理服务器、反向静态服务器等配置；
知道基本的nginx配置调优；
知道如何配置权限、编译一个nginx扩展到nginx；
知道基本的nginx运行原理（master/worker机制，epoll），知道为什么nginx性能比apache性能好等知识；

### MySQL/MongoDB：

在第一阶段的基础上面，在MySQL开发方面，掌握很多小技巧，包括常规SQL优化（group by/order by/rand优化等）；
除了能够搭建MySQL，还能够冷热备份MySQL数据，还知道影响innodb/myisam性能的配置选项（比如key_buffer/query_cache/sort_buffer/innodb_buffer_pool_size/innodb_flush_log_at_trx_commit等），也知道这些选项配置成为多少值合适；
另外也了解一些特殊的配置选项，比如 知道如何搭建mysql主从同步的环境，知道各个binlog_format的区别；
知道MySQL的性能追查，包括slow_log/explain等，还能够知道基本的索引建立处理等知识；
原理方面了解基本的MySQL的架构（Server+存储引擎），知道基本的InnoDB/MyISAM索引存储结构和不同（聚簇索引，B树）；
知道基本的InnoDB事务处理机制；
了解大部分MySQL异常情况的处理方案（或者知道哪儿找到处理方案）；
条件允许的情况，建议了解一下NoSQL的代表MongoDB数据库，顺便对比跟MySQL的差别，同时能够在合适的应用场景安全谨慎的使用MongoDB，知道基本的PHP与MongoDB的结合开发。

### Redis/Memcached：

在大部分中型系统里面一定会涉及到缓存处理，所以一定要了解基本的缓存；
知道Memcached和Redis的异同和应用场景，能够独立安装 Redis/Memcached，了解Memcahed的一些基本特性和限制，比如最大的value值，知道PHP跟他们的使用结合；
Redis了解基本工作原理和使用，了解常规的数据类型，知道什么场景应用什么类型，了解Redis的事务等等;
原理部分，能够大概了解Memcached的内存结构（slab机制），redis就了解常用数据类型底层实现存储结构（SDS/链表/SkipList/HashTable）等等，顺便了解一下Redis的事务、RDB、AOF等机制更好

### PHP：

除了第一阶段的能力，安装配置方面能够随意安装PHP和各种第三方扩展的编译安装配置；
了解php-fpm的大部分配置选项和含义（如max_requests/max_children/request_terminate_timeout之类的影响性能的配置），知道mod_php/fastcgi的区别；
在PHP方面已经能够熟练各种基础技术，还包括各种深入些的PHP，包括对PHP面向对象的深入理解/SPL/语法层面的特殊特性比如反射之类的；
在框架方面已经阅读过最少一个以上常规PHP MVC框架的代码了，知道基本PHP框架内部实现机制和设计思想；在PHP开发中已经能够熟练使用常规的设计模式来应用开发（抽象工厂/单例/观察者/命令链/策略/适配器 等模式）；
建议开发自己的PHP MVC框架来充分让开发自由化，让自己深入理解MVC模式，也让自己能够在业务项目开发里快速升级；
熟悉PHP的各种代码优化方法，熟悉大部分PHP安全方面问题的解决处理；熟悉基本的PHP执行的机制原理（Zend引擎/扩展基本工作机制）；

### C/C++：

开始涉猎一定的C/C++语言，能够写基本的C/C++代码，对基本的C/C++语法熟悉（指针、数组操作、字符串、常规标准API）和数据结构（链表、树、哈希、队列）有一定的熟悉下；
对Linux下面的C语言开发有基本的了解概念，会简单的makefile文件编写，能够使用简单的GCC/GDB的程序编译简单调试工作；
对基本的网络编程有大概了解。（本项是为了向更高层次打下基础）

### 前端：

在第一阶段的基础上面，熟悉基本的HTTP协议（协议代码200/300/400/500，基本的HTTP交互头）；
条件允许，可以在深入写出稍微优雅的HTML+CSS+JavaScript，或者能够大致简单使用某些前端框架（jQuery/YUI/ExtJS/RequireJS/BootStrap之类）；
如果条件允许，可以深入学习JavaScript编程，比如闭包机制、DOM处理；再深入些可以读读jQuery源码做深入学习。（本项不做重点学习，除非对前端有兴趣）

### 系统设计：

能够设计大部分中型系统的网站架构、数据库、基本PHP框架选型；性能测试排查处理等；
能够完成类似：浏览器 -< CDN(Squid) -< Nginx+PHP -< 缓存 -< 数据库 结构网站的基本设计开发维护；
能够支撑每天数百万到千万流量基本网站的开发维护工作；

## 第三阶段：高级阶段 （高级PHP程序员）

重点：除了基本的LNMP程序，还能够在某个方向或领域有深入学习。（纵深维度发展）

目标：除了能够完成基本的PHP业务开发，还能够解决大部分深入复杂的技术问题，并且可以独立设计完成中大型的系统设计和开发工作；自己能够独立hold深入某个技术方向，在这块比较专业。（比如在MySQL、Nginx、PHP、Redis等等任一方向深入研究）

### Linux：

除了第二阶段的能力，在Linux下面除了常规的操作和性能监控跟踪，还能够使用很多高级复杂的命令完成工作（watch/tcpdump/starce/ldd/ar等)；
在shell脚本方面，已经能够编写比较复杂的shell脚本（超过500行）来协助完成很多包括备份、自动化处理、监控等工作的shell；
对awk/sed/perl 等应用已经如火纯青，能够随意操作控制处理文本统计分析各种复杂格式的数据；
对Linux内部机制有一些了解，对内核模块加载，启动错误处理等等有个基本的处理；
同时对一些其他相关的东西也了解，比如NFS、磁盘管理等等；

## Nginx:

在第二阶段的基础上面，已经能够把Nginx操作的很熟练，能够对Nginx进行更深入的运维工作，比如监控、性能优化，复杂问题处理等等；
看个人兴趣，更多方面可以考虑侧重在关于Nginx工作原理部分的深入学习，主要表现在阅读源码开始，比如具体的master/worker工作机制，Nginx内部的事件处理，内存管理等等；
同时可以学习Nginx扩展的开发，可以定制一些自己私有的扩展；
同时可以对Nginx+Lua有一定程度的了解，看看是否可以结合应用出更好模式；
这个阶段的要求是对Nginx原理的深入理解，可以考虑成为Nginx方向的深入专业者。

### MySQL/MongoDB：

在第二阶段的基础上面，在MySQL应用方面，除了之前的基本SQL优化，还能够在完成一些复杂操作，比如大批量数据的导入导出，线上大批量数据的更改表结构或者增删索引字段等等高危操作；
除了安装配置，已经能够处理更多复杂的MySQL的问题，比如各种问题的追查，主从同步延迟问题的解决、跨机房同步数据方案、MySQL高可用架构等都有涉及了解；
对MySQL应用层面，对MySQL的核心关键技术比较熟悉，比如事务机制（隔离级别、锁等）、对触发器、分区等技术有一定了解和应用；
对MySQL性能方面，有包括磁盘优化（SAS迁移到SSD）、服务器优化（内存、服务器本身配置）、除了二阶段的其他核心性能优化选项（innodb_log_buffer_size/back_log/table_open_cache/thread_cache_size/innodb_lock_wait_timeout等）、连接池软件选择应用，对show *（show status/show profile）类的操作语句有深入了解，能够完成大部分的性能问题追查；
MySQL备份技术的深入熟悉，包括灾备还原、对Binlog的深入理解，冷热备份，多IDC备份等；在MySQL原理方面，有更多了解，比如对MySQL的工作机制开始阅读部分源码，比如对主从同步（复制）技术的源码学习，或者对某个存储引擎（MyISAM/Innodb/TokuDB）等等的源码学习理解，如果条件允许，可以参考CSV引擎开发自己简单的存储引擎来保存一些数据，增强对MySQL的理解；
在这个过程，如果自己有兴趣，也可以考虑往DBA方向发展。MongoDB层面，可以考虑比如说在写少读多的情况开始在线上应用MongoDB，或者是做一些线上的数据分析处理的操作，具体场景可以按照工作来，不过核心是要更好的深入理解RMDBS和NoSQL的不同场景下面的应用，如果条件或者兴趣允许，可以开始深入学习一下MongoDB的工作机制。

### Redis/Memcached：

在第二阶段的基础上面，能够更深入的应用和学习。因为Memcached不是特别复杂，建议可以把源码进行阅读，特别是内存管理部分，方便深入理解；Redis部分，可以多做一些复杂的数据结构的应用（zset来做排行榜排序操作/事务处理用来保证原子性在秒杀类场景应用之类的使用操作）；
多涉及aof等同步机制的学习应用，设计一个高可用的Redis应用架构和集群；
建议可以深入的学习一下Redis的源码，把在第二阶段积累的知识都可以应用上，特别可以阅读一下包括核心事件管理、内存管理、内部核心数据结构等充分学习了解一下。如果兴趣允许，可以成为一个Redis方面非常专业的使用者。

### PHP：

作为基础核心技能，我们在第二阶段的基础上面，需要有更深入的学习和应用。

从基本代码应用上面来说，能够解决在PHP开发中遇到95%的问题，了解大部分PHP的技巧；
对大部分的PHP框架能够迅速在一天内上手使用，并且了解各个主流PHP框架的优缺点，能够迅速方便项目开发中做技术选型；
在配置方面，除了常规第二阶段会的知识，会了解一些比较偏门的配置选项（php auto_prepend_file/auto_append_file），包括扩展中的一些复杂高级配置和原理（比如memcached扩展配置中的memcache.hash_strategy、apc扩展配置中的apc.mmap_file_mask/apc.slam_defense/apc.file_update_protection之类的）；
对php的工作机制比较了解，包括php-fpm工作机制（比如php-fpm在不同配置机器下面开启进程数量计算以及原理），对zend引擎有基本熟悉（vm/gc/stream处理），阅读过基本的PHP内核源码（或者阅读过相关文章），对PHP内部机制的大部分核心数据结构（基础类型/Array/Object）实现有了解，对于核心基础结构（zval/hashtable/gc）有深入学习了解；
能够进行基本的PHP扩展开发，了解一些扩展开发的中高级知识（minit/rinit等），熟悉php跟apache/nginx不同的通信交互方式细节（mod_php/fastcgi）；
除了开发PHP扩展，可以考虑学习开发Zend扩展，从更底层去了解PHP。

### C/C++：

在第二阶段基础上面，能够在C/C++语言方面有更深入的学习了解，能够完成中小型C/C++系统的开发工作；
除了基本第二阶段的基础C/C++语法和数据结构，也能够学习一些特殊数据结构（b-tree/rb-tree/skiplist/lsm-tree/trie-tree等）方便在特殊工作中需求；
在系统编程方面，熟悉多进程、多线程编程；多进程情况下面了解大部分多进程之间的通信方式，能够灵活选择通信方式（共享内存/信号量/管道等）；
多线程编程能够良好的解决锁冲突问题，并且能够进行多线程程序的开发调试工作；同时对网络编程比较熟悉，了解多进程模型/多线程模型/异步网络IO模型的差别和选型，熟悉不同异步网络IO模型的原理和差异（select/poll/epoll/iocp等），并且熟悉常见的异步框架（ACE/ICE/libev/libevent/libuv/Boost.ASIO等）和使用，如果闲暇也可以看看一些国产自己开发的库（比如muduo）；
同时能够设计好的高并发程序架构（leader-follow/master-worker等）；
了解大部分C/C++后端Server开发中的问题（内存管理、日志打印、高并发、前后端通信协议、服务监控），知道各个后端服务RPC通信问题（struct/http/thirft/protobuf等）；
能够更熟络的使用GCC和GDB来开发编译调试程序，在线上程序core掉后能够迅速追查跟踪解决问题；
通用模块开发方面，可以积累或者开发一些通用的工具或库（比如异步网络框架、日志库、内存池、线程池等），不过开发后是否应用要谨慎，省的埋坑去追bug；

### 前端：

深入了解HTTP协议（包括各个细致协议特殊协议代码和背后原因，比如302静态文件缓存了，502是nginx后面php挂了之类的）；
除了之前的前端方面的各种框架应用整合能力，前端方面的学习如果有兴趣可以更深入，表现形式是，可以自己开发一些类似jQuery的前端框架，或者开发一个富文本编辑器之类的比较琐碎考验JavaScript功力；

### 其他领域语言学习：

在基础的PHP/C/C++语言方面有基本积累，建议在当前阶段可以尝试学习不同的编程语言，看个人兴趣爱好，脚本类语言可以学学 Python/Ruby 之类的，函数式编程语言可以试试 Lisp/Haskell/Scala/Erlang 之类的，静态语言可以试试 Java/Golang，数据统计分析可以了解了解R语言，如果想换个视角做后端业务，可以试试 Node.js还有前面提到的跟Nginx结合的Nginx_Lua等。学习不同的语言主要是提升自己的视野和解决问题手段的差异，比如会了解除了进程/线程，还有轻量级协程；
比如在跨机器通信场景下面，Erlang的解决方案简单的惊人；比如在不想选择C/C++的情况下，还有类似高效的Erlang/Golang可用等等；
主要是提升视野。

### 其他专业方向学习：

在本阶段里面，会除了基本的LNMP技能之外，会考虑一些其他领域知识的学习，这些都是可以的，看个人兴趣和长期的目标方向。

目前情况能够选择的领域比较多，比如、云计算（分布式存储、分布式计算、虚拟机等），机器学习（数据挖掘、模式识别等，应用到统计、个性化推荐），自然语言处理（中文分词等），搜索引擎技术、图形图像、语音识别等等。

除了这些高大上的，也有很多偏工程方面可以学习的地方，比如高性能系统、移动开发（Android/IOS）、计算机安全、嵌入式系统、硬件等方向。

### 系统设计：

系统设计在第二阶段的基础之上，能够应用掌握的经验技能，设计出比较复杂的中大型系统，能够解决大部分线上的各种复杂系统的问题，完成类似 浏览器 -< CDN -< 负载均衡 -<接入层 -< Nginx+PHP -< 业务缓存 -< 数据库 -< 各路复杂后端RPC交互（存储后端、逻辑后端、反作弊后端、外部服务） -< 更多后端 酱紫的复杂业务；
能够支撑每天数千万到数亿流量网站的正常开发维护工作。

## 面试

> mysql_real_escape_string mysql_escape_string区别

mysql_real_escape_string需要预先连接数据库，并可在第二个参数传入数据库连接（不填则使用上一个连接）
两者都是对数据库插入数据进行转义，但是mysql_real_escape_string转义时，会考虑数据库连接的字符集。
它们的用处都是用来能让数据正常插入到数据库中，并防止sql注入，但是并不能做到100%防止sql注入。

> 内存泄漏

内存泄漏是因为一块被分配内存既不能被使用，也不能被回收，直到浏览器进程结束。

页面元素被删除，但是绑定在该元素上的事件未被删除；
闭包维持函数内局部变量（外部不可控），使其得不到释放；
意外的全局变量；
引用被删除，但是引用内的引用，还存在内存中。

外部调用类函数

> sql注入

ZEND引擎维护了一个栈zval，每个创建的变量和资源都会压入这个栈中，每个压入的数组结构都类似：[refcount => int, is_ref => 0|1, value => union, type => string]，变量被unset时，ref_count如果变成0，则被回收。

当遇到变量循环引用自身时，使用同步回收算法回收。

sapi是php封装的对外数据传递接口，通常有cgi/fastcgi/cli/apache2handler四种运行模式。

crc32


索引用b+树存储，而不是哈希表，数据库索引存储还有其他数据结构吗？

答：O(log(n))，O(1)

因为哈希表是散列的，在遇到`key`>'12'这种查找条件时，不起作用，并且空间复杂度较高。

备注：b+数根据层数决定时间复杂度，数据量多的情况下一般4-5层，然后用二分法查找页中的数据，时间复杂度远小于log(n)。

## 大数据

* 查询上运行EXPLAIN，看看是不是缺少什么索引。曾经做过一个查询，通过增加了一个索引后效率提高了4个数量级
* 如果正在做SQL查询，然后获得结果，并把很多数字弄到一起，看看能不能使用像SUM（）和AVG（）之类的函数调用GROUP BY语句
    - 跟普遍的情况下，让数据库处理尽量多的计算。一点很重要的提示是：（至少在MySQL里是这样）布尔表达式的值为0或1，如果有创意的话，可以使用SUM（）和它的小伙伴们做些很让人惊讶的事情。
* 是不是把这些同样很耗费时间的数字计算了很多遍。例如，假设1000袋土豆的成本是昂贵的计算，但并不需要把这个成本计算500次，然后才把1000袋土豆的成本存储在一个数组或其他类似的地方，所以你不必把同样的东西翻来覆去的计算。这个技术叫做记忆术，在像你这样的报告中使用往往会带来奇迹般的效果

## 方向

* SPL库系列请仔细研究
* PHP的socket模块以及pcntl模块
* 从工程代码组织角度去理解和学习设计模式和面向对象OOP
* 接纳一门新的语言。推荐Golang。对自己足够狠，请深入研究C语言
* MySQL请购买《MySQL技术内幕：innodb存储引擎》和《高性能MySQL》两本书，Redis请购买《Redis设计与实现》
* 《C Primer Plus》和《Unix环境高级编程》。这地方有一个巨大的错觉，就是读完一遍《C Primer Plus》后就觉得自己会CLang了，有这种优越感的，请你尝试用CLang做个什么东西出来？然后你发现似乎真的什么也做不了，这会儿就可以步入到《Unix环境高级编程》的节奏
* 一切基于基础之上的上层应用都是海市蜃楼，犹如过眼云烟。不变的永远是基于事件监听的异步非阻塞IO
* 技术
    - 分布式配置中心
    - 服务熔断、限流、降级
    - 异步框架
    - 分布式KV数据库
    - 微服务架构
    - Docker发布代码

## 安全

* md5：一种信息摘要算法（其实就是哈希），不是加密算法，因为md5不可逆，但是加解密是一个可逆的过程
* 分类
    - 对称加密，常见算法 DES、3DES、AES等
        + 用同一个密钥对信息加解密
        + 欲要加密，必先加密密钥的矛盾
        + [gibberish-aes-php](https://github.com/ivantcholakov/gibberish-aes-php)
    - 非对称加密，RSA、DSA、ECDH等
        + 公钥和私钥是成双成对生成的，二者之间通过某种神秘的数学原理连接
        + 公钥加密的数据，只能通过相应的私钥解密；私钥加密的数据，只能通过对应的公钥解密
        + 发给谁信息用谁公钥加密,用自己公钥加密，只有自己私钥解密，利用自己私钥加密，所有有自己公钥的都可以解密
        + 私钥加密，公钥验签
        + 公钥可以颁发给任何人，私钥自己保留
        + [pikirasa](https://github.com/vlucas/pikirasa)
        + 加密周期长,耗资源
    - 混合
        + 随机生成一个AES对称加密用的密钥，然后用客户端的RSA公钥加密后传给客户端
        + 客户端再通过自己的RSA私钥解密得到这个AES对称密钥，然后再用这个AES对称密钥进行后续的加解密即可
        + 给这个AES密钥设定一个有效期，过期后，就再次利用上面的流程申请新的AES密钥即可
* 密钥协商\交换
    - 避免密钥在网络上的传输被劫持导致的安全问题
    - 利用RSA等非对称加密技术进行交换
    - 利用专门伺候密钥交换需求的交换算法，比如DH算法，全称叫做Diffie-Hellman密钥交换
        + 元首手里有的数据有100（基数）、9、300（加密），古德里安手里的数据有100、3、900（加密），然后两个人此时只需要默默地做下面这一步：元首：9 * 300 = 2700 古德里安：3 * 900 = 2700，就是2700
        + [diffie-hellman-php](https://github.com/jcink/diffie-hellman-php)
        + ECDH [ECDH-PHP](https://github.com/Querdos/ECDH-PHP)

```php
https://github.com/Querdos/ECDH-PHP

<?php
require_once './autoloader.php';
use Querdos\lib\ECDHCurve25519;
$xitele   = new ECDHCurve25519();
$gudelian = new ECDHCurve25519();
$xitele->computeSecret( $gudelian->getPublic() );
$gudelian->computeSecret( $xitele->getPublic() );
// shareKey1 和 shareKey2 就是协商出来的密钥
$shareKey1 = $xitele->getSecret();
echo $shareKey1.PHP_EOL;
$shareKey2 = $gudelian->getSecret();
echo $shareKey2.PHP_EOL;
// 我们用gmp cmp来对比是否为同一个密钥
if ( 0 == gmp_cmp( $shareKey1, $shareKey2 ) ) {
  echo "一样".PHP_EOL;
}
else {
  echo "不一样".PHP_EOL;
}
// 除此之外，ecdh比dh多了一个验证数据签名验证，也就是说ecdh可以检验数据是否被篡改！
$msg = "hello world";
$signature = $xitele->signMessage( $msg );
if ( $gudelian->verifySignature( $signature, $xitele->getPublic(), $msg ) ) {
  echo "验证数据签名成功".PHP_EOL;
}
else {
  echo "验证数据签名失败".PHP_EOL;
}
exit;
```

## [xdebug](https://xdebug.org/)

* 浏览器扩展：xdebug helper(非必须)
* [原理](https://xdebug.org/docs/remote)
    - PHP Xdebug 插件起了9000端口（server）
        + 浏览器向服务器发送一个带有 XDEBUG_SESSION_START 参数的请求，服务器收到这个请求之后交给后端的 PHP（已开启 xdebug 模块）处理
        + Php 接受带了 XDEBUG_SESSION_START 参数的请求，Xdebug 会向来源 ip 客户端(IDE)的 9000 端口（默认是 9000 端口）发送一个 debug 请求，然后客户端的 9000 端口响应这个请求，那么 debug 就开始了
        + 客户端（IDE）收到 Xdebug 发送过来的执行情况，把这些信息展示给开发者
        + Php 知道 Xdebug 已经准备好了，那么就开始开始一行一行的执行代码，但是每执行一行都会让 Xdebug 过滤一下，Xdebug 在过滤每一行代码的时候，都会暂停代码的执行，然后向客户端的 9000 端口发送该行代码的执行情况，等待客户端的决策
  - IDE监听9000端口(client):集成了一个遵循 BGDp 的 Xdebug 插件
        + 启动插件:会启动一个 9000 的端口监听远程服务器发过来的 debug 信息
    - servers:实际服务起的端口号，脚本运行需要的地址
  - 通信协议 DBGp:端口意义不大,加了一层代理

```
brew install php71-xdebug
pecl install xdebug

# php.ini
zend_extension="xdebug.so"
xdebug.remote_enable = on
xdebug.remote_host = localhost
xdebug.remote_port = 9000
xdebug.remote_handler = dbgp
<!-- xdebug.remote_mode = "req" -->
xdebug.idekey = PHPSTORM
xdebug.remote_log = /tmp/xdebug.log

# PHPstrom setting
## debug
Debug port 9000

## DBGP
PHPSTORM
localhost
80

## Servers
localhost 80 Xdebug

# Script
URL # 实际URL

## start listening
```

## 问题

>  5096 segmentation fault (core dumped)  php http_server.php

>  Warning: "continue" targeting switch is equivalent to "break". Did you mean to use "continue 2"?

## 面试

* [Web 开发进阶指南](https://laravel-china.org/articles/9059/web-development-guide)
* [todayqq/PHPerInterviewGuide](https://github.com/todayqq/PHPerInterviewGuide)
* [sushengbuhuo/php-interview-2018](https://github.com/sushengbuhuo/php-interview-2018)
* [xianyunyh/PHP-Interview](https://github.com/xianyunyh/PHP-Interview):PHP面试整理的资料。包括PHP、MySQL、Linux、计算机网络等资料
* [金题](https://www.jintix.com/)
* [colinlet/PHP-Interview-QA](https://github.com/colinlet/PHP-Interview-QA):PHP面试问答

## 扩展

* intl
* mcrypt
* memeached
    - memcache完全在PHP框架内开发的，提供了memcached的接口，memecached扩展是使用了libmemcached库提供的api与memcached服务端进行交互。 libmemcached 是 memcache 的 C 客户端，它具有低内存，线程安全等优点
    - memcache提供了面向过程及面向对象的接口，memached只支持面向对象的接口。 memcached 实现了更多的 memcached 协议。
    - memcached 支持 Binary Protocol，而 memcache 不支持，意味着 memcached 会有更高的性能。不过，还需要注意的是，memcached 目前还不支持长连接。
* mongodb
* Opcache:通过将 PHP 脚本预编译的字节码存储到共享内存中来提升 PHP 的性能，省去了每次加载和解析 PHP 脚本的开销，但是对于I/O开销如读写磁盘文件、读写数据库等并无影响
    - 字节码(Byte Code)：一种包含执行程序比机器码更抽象的中间码，由一序列 op代码/数据对组成的二进制文件。 比如Java源码经编译后生成的字节码在运行时通过JVM(JVM针对不同平台有不同版本，Java程序在JVM中运行而称 为解释性语言Interpreted)再做一次转换生成机器码，才能够跨平台运行；C#也类似，EXE文件的执行依赖.NET Framework；HHVM(HipHop Virtual Machine，Facebook开源的PHP虚拟机)采用了JIT(Just In Time Just Compiling，即时编译)技术，在运行时编译字节码为机器码，让他们的PHP性能测试提升了一个数量级。 唯有C/C++编译生成的二进制文件可直接运行。
    - 机器码(Machine Code)：也被称为原生码(Native Code)，用二进制代码表示的计算机能直接识别和执行的一种机器指令的集合，它是计算机硬件结构赋予的操作功能。
* pdo-pgsql
* phalcon
* [redis](http://pecl.php.net/package/redis)
    - [predis](https://github.com/nrk/predis/):Flexible and feature-complete Redis client for PHP and HHVM https://github.com/nrk/predis/wiki 纯 php 实现的，通过 socket 与 redis 服务器通信，使用时只需要通过 composer 加载依赖，无需额外安装扩展
    - [phpredis/phpredis](https://github.com/phpredis/phpredis): A PHP extension for Redis 是基于 c 语言开发的 PHP 扩展，速度快、内存小.需要安装对应的扩展才能使用.功能上两者差不多，性能上略胜一筹，但由于与 redis 通信的主要瓶颈还是在网络 IO 上
* sphinx
* swoole
* apc:op缓存
* [defuse/php-encryption](https://github.com/defuse/php-encryption):Simple Encryption in PHP.
* [jedisct1/libsodium](https://github.com/jedisct1/libsodium):A modern, portable, easy to use crypto library https://libsodium.org
* PHPDoc
* [PHP_CodeSniffer](https://github.com/squizlabs/PHP_CodeSniffer)：PHP_CodeSniffer tokenizes PHP, JavaScript and CSS files and detects violations of a defined set of coding standards. http://pear.php.net/package/PHP_CodeS…
* [php-cs-fixer](https://github.com/FriendsOfPHP/PHP-CS-Fixer)：PHP Code Beautifier and Fixer(phpcbf) PHP代码规范与质量检查工具

```sh
brew tap homebrew/homebrew-php
brew install php71 --with-pear

brew install mcrypt

yum install php-mcrypt|php5-mcrypt
apt-get install php-mcrypt|php5-mcrypt
pecl install mcrypt-snapshot|mcrypt-1.0.1
brew install php71-mcrypt

# PHP_CodeSniffer
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

# php-cs-fixer
wget http://cs.sensiolabs.org/download/php-cs-fixer-v2.phar -O php-cs-fixer
wget https://github.com/FriendsOfPHP/PHP-CS-Fixer/releases/download/v2.10.0/php-cs-fixer.phar -O php-cs-fixer
curl -L http://cs.sensiolabs.org/download/php-cs-fixer-v2.phar -o php-cs-fixer

sudo chmod a+x php-cs-fixer
sudo mv php-cs-fixer /usr/local/bin/php-cs-fixer

composer global require friendsofphp/php-cs-fixer
export PATH="$PATH:$HOME/.composer/vendor/bin"
brew install homebrew/php/php-cs-fixer

composer global require phpmd/phpmd

sudo php-cs-fixer self-update
brew upgrade php-cs-fixer

php php-cs-fixer.phar fix /path/to/dir
php php-cs-fixer.phar fix /path/to/file

phpcs --config-show
phpcs --config-set

pecl channel-update pecl.php.net
```

## 工具

* [https://phar.io](https://phar.io):The PHAR Installation and Verification Environment (PHIVE)
* [sebastianfeldmann/phpbu](https://github.com/sebastianfeldmann/phpbu):PHP Backup Utility - Creates and encrypts database and file backups, syncs your backups to other servers or cloud services and assists you monitor your backup process https://phpbu.de
* [laradock/laradock](https://github.com/Laradock/laradock):The most popular full PHP development environment on Docker. http://laradock.io
* [swisnl/php7-upgrade-tools](https://github.com/swisnl/php7-upgrade-tools):A set of tools for upgrading applications to PHP 7
* [rectorphp/rector](https://github.com/rectorphp/rector):Instant Upgrades for PHP Applications https://www.tomasvotruba.cz/blog/2018/02/19/rector-part-1-what-and-how/
* 环境平台
    - [XAMPP](https://www.apachefriends.org/index.html)
    - [wamp](link)
    - [mamp](https://www.mamp.info)
        + http://localhost:8888/MAMP/
        + /Applications/MAMP/htdocs
        + MySQL port：8889
    - Wnmp:Version of nginx for Windows uses the native Win32 API (not the Cygwin emulation layer). Only the select() connection processing method is currently used, so high performance and scalability should not be expected.
        + `tasklist /fi "imagename eq nginx.exe" # 查看进程，没有查看error.log`

## 参考

* [Inversion of Control Containers and the Dependency Injection pattern](https://martinfowler.com/articles/injection.html)
* [tpunt/PHP7-Reference](tpunt/PHP7-Reference):An overview of the features, changes, and backward compatibility breakages in PHP 7
