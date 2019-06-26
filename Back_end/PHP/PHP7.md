# PHP7

* PHP是以多进程模型设计的，这样的好处是请求之间互不干涉，一个请求失败也不会对其他进程造成影响

短闭包
空合并运算符
Trait
属性类型
扩散运算符
JIT 编译器
FFI
匿名类
声明返回类型
Contemporary cryptography
Generators

## 功能

-   改进的性能 - PHPNG代码合并在PHP7中，这是比 PHP5快两倍;
-   降低内存消耗 - 优化后PHP7使用较少的资源;
-   标量类型声明 - 现在，参数和返回值类型可以被强制执行;
-   一致性的64位支持 - 64位架构机器持续支持;
-   改进异常层次结构 - 异常层次结构得到改善;
-   许多致命错误转换成异常 - 异常的范围增大覆盖为许多致命的错误转化异常；
-   安全随机数发生器 - 加入新的安全随机数生成器的API;
-   已过时的API和扩展删除 - 不同的旧的和不支持的应用程序和扩展，从最新的版本中删除;
-   null合并运算符（??）的新空合并运算符被加入;
-   返回和标量类型声明支持返回类型和参数类型也被加入;
-   增加了对匿名匿名类的支持;
-   零成本声明支持零成本加入断言。

## 语法

-   变量标量类型声明：标量类型声明与返回类型声明
    -   int
    -   float
    -   bool
    -   string
    -   interfaces
    -   array
    -   callable
-   Null合并运算符：用来与isset（）函数函数一起替换三元操作
-   飞船操作符：用于比较两个表达式。当第一个表达式较第二个表达式分别小于，等于或大于时它分别返回-1，0或1。
-   定义常量数组
-   匿名类
-   Closure::call() 方法加入到临时绑定（bindTo）的对象范围
-   引入了过滤 unserialize（）函数以在反序列化不受信任的数据对象时提供更好的安全性。它可以防止可能的代码注入，使开发人员能够使用序列化白名单类。
-   IntlChar类：这个类自身定义了许多静态方法用于操作多字符集的 unicode 字符。需要安装intl拓展
-   两个新的函数引入以产生一个跨平台的方式加密安全整数和字符串。
    -   random_bytes() - 生成加密安全伪随机字节。
    -   random_int() - 生成加密安全伪随机整数。
-   期望是向后兼容的增强到旧 assert() 函数。期望允许在生产代码零成本的断言，并提供在断言失败时抛出自定义异常的能力。assert() 不是一种语言构建体，其中第一个参数是一个表达式的比较字符串或布尔用于测试。
    -   ssertion - 断言。在PHP 5中，这必须是要计算一个字符串或要测试一个布尔值。 在PHP中7，这也可能是一个返回值的表达式，将执行和使用的结果，以指示断言是成功还是失败。
- 生成器支持返回表达式：它允许在生成器函数中通过使用 return 语法来返回一个表达式 （但是不允许返回引用值）， 可以通过调用 Generator::getReturn() 方法来获取生成器的返回值， 但是这个方法只能在生成器完成产生工作以后调用一次。
- 生成器委派：只需在最外层生成其中使用yield from，就可以把一个生成器自动委派给其他的生成器
- 会话选项设置：session_start() 可以加入一个数组覆盖php.ini的配置
-   单次使用 use 语句可以用来从同一个命名空间导入类，函数和常量(而不用多次使用 use 语句)。
-   错误处理：传统的错误报告机制的错误：通过抛出异常错误处理。类似于异常，这些错误异常会冒泡，直到它们到达第一个匹配的catch块。如果没有匹配的块，那么会使用 set_exception_handler() 安装一个默认的异常处理并被调用，并在情况下，如果没有默认的异常处理程序，那么该异常将被转换为一个致命的错误，并会像传统错误那样处理。
    -   由于 Error 层次结构不是从异常（Exception），代码扩展使用catch (Exception $e) { ... } 块来处理未捕获的异常，PHP5中将不会处理这样的错误。  catch (Error $e) { ... } 块或 set_exception_handler（）处理程序需要处理的致命错误。
-   引入了intdiv()的新函数，它执行操作数的整数除法并返回结果为 int 类型
-   null合并运算符
-   Unicode codepoint 转译语法:接受一个以16进制形式的 Unicode codepoint，并打印出一个双引号或heredoc包围的 UTF-8 编码格式的字符串。 可以接受任何有效的 codepoint，并且开头的 0 是可以省略的
- preg_replace_callback_array：可以使用一个关联数组来对每个正则表达式注册回调函数， 正则表达式本身作为关联数组的键， 而对应的回调函数就是关联数组的值
* 改变了大多数错误的报告方式。不同于传统（PHP 5）的错误报告机制，大多数错误被作为 Error 异常抛出。
* list 会按照原来的顺序进行赋值。不再是逆序了.不再支持解开字符串
* foreach不再改变内部数组指针
* 十六进制字符串不再被认为是数字
* $HTTP_RAW_POST_DATA 被移 使用php://input代替
* 7.1
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

## 禁止

-   不要使用 `mysql_` 函数：从核心中全部移除了

## 工具

* [swisnl/php7-upgrade-tools](https://github.com/swisnl/php7-upgrade-tools):A set of tools for upgrading applications to PHP 7
* [rectorphp/rector](https://github.com/rectorphp/rector):Instant Upgrades for PHP Applications https://www.tomasvotruba.cz/blog/2018/02/19/rector-part-1-what-and-how/

## 参考

-   [tpunt/PHP7-Reference](tpunt/PHP7-Reference):An overview of the features, changes, and backward compatibility breakages in PHP 7
