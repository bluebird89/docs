# PHP7

PHP是以多进程模型设计的，这样的好处是请求之间互不干涉，一个请求失败也不会对其他进程造成影响.随着PHP的应用变大，访问量增加这种方式显然是不合适的，因为启动一个进程的开销对于海量请求是不划算的，所以现在PHP基本都是运行在PHP-FPM的管理下的，这是一个PHP进程管理器，它常驻内存启动一些PHP进程待命，当请求进入时分配一个进程进行处理，PHP进程处理完毕后回收进程，但并不销毁进程，这让PHP也能应对高流量的访问请求。

## 功能

* 改进的性能 - PHPNG代码合并在PHP7中，这是比 PHP5快两倍;
* 降低内存消耗 - 优化后PHP7使用较少的资源;
* 标量类型声明 - 现在，参数和返回值类型可以被强制执行;
* 一致性的64位支持 - 64位架构机器持续支持;
* 改进异常层次结构 - 异常层次结构得到改善;
* 许多致命错误转换成异常 - 异常的范围增大覆盖为许多致命的错误转化异常；
* 安全随机数发生器 - 加入新的安全随机数生成器的API;
* 已过时的API和扩展删除 - 不同的旧的和不支持的应用程序和扩展，从最新的版本中删除;
* null合并运算符（??）的新空合并运算符被加入;
* 返回和标量类型声明支持返回类型和参数类型也被加入;
* 增加了对匿名匿名类的支持;
* 零成本声明支持零成本加入断言。

## 语法

* 标量类型：标量类型声明与返回类型声明
    - int
    - float
    - bool
    - string
    - interfaces
    - array
    - callable
* Null合并运算符：用来与isset（）函数函数一起替换三元操作
* 飞船操作符：用于比较两个表达式。当第一个表达式较第二个表达式分别小于，等于或大于时它分别返回-1，0或1。
* 定义常量数组
* 匿名类
* Closure::call() 方法加入到临时绑定（bindTo）的对象范围
* 引入了过滤 unserialize（）函数以在反序列化不受信任的数据对象时提供更好的安全性。它可以防止可能的代码注入，使开发人员能够使用序列化白名单类。
* 两个新的函数引入以产生一个跨平台的方式加密安全整数和字符串。
    - random_bytes() - 生成加密安全伪随机字节。
    - random_int() - 生成加密安全伪随机整数。
* 期望是向后兼容的增强到旧 assert() 函数。期望允许在生产代码零成本的断言，并提供在断言失败时抛出自定义异常的能力。assert() 不是一种语言构建体，其中第一个参数是一个表达式的比较字符串或布尔用于测试。
    - ssertion - 断言。在PHP 5中，这必须是要计算一个字符串或要测试一个布尔值。 在PHP中7，这也可能是一个返回值的表达式，将执行和使用的结果，以指示断言是成功还是失败。
* 单次使用 use 语句可以用来从同一个命名空间导入类，函数和常量(而不用多次使用 use 语句)。
* 错误处理：传统的错误报告机制的错误：通过抛出异常错误处理。类似于异常，这些错误异常会冒泡，直到它们到达第一个匹配的catch块。如果没有匹配的块，那么会使用 set_exception_handler() 安装一个默认的异常处理并被调用，并在情况下，如果没有默认的异常处理程序，那么该异常将被转换为一个致命的错误，并会像传统错误那样处理。
    - 由于 Error 层次结构不是从异常（Exception），代码扩展使用catch (Exception $e) { ... } 块来处理未捕获的异常，PHP5中将不会处理这样的错误。  catch (Error $e) { ... } 块或 set_exception_handler（）处理程序需要处理的致命错误。
* 引入了intdiv()的新函数，它执行操作数的整数除法并返回结果为 int 类型

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
   return $value;
}
print(returnIntValue(5));

declare(strict_types=1);
function returnIntValue(int $value): int
{
   return $value + 1.0;
}
print(returnIntValue(5));

$username = $_GET['username'] ?? $_POST['username'] ?? 'not passed';

print( 1 <=> 1);print("<br/>");
print( 1 <=> 2);print("<br/>");
print( 2 <=> 1);print("<br/>");

define('animals', [
   'dog',
   'cat',
   'bird'
]);

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
$data = unserialize($serializedObj1 , ["allowed_classes" => true]);
$data2 = unserialize($serializedObj2 , ["allowed_classes" => ["MyClass1", "MyClass2"]]);

$bytes = random_bytes(5);
print(bin2hex($bytes));

print(random_int(-1000, 0));

ini_set('assert.exception', 1);
class CustomError extends AssertionError {}
assert(false, new CustomError('Custom Error Message!'));

use com\yiibai\{ClassA, ClassB, ClassC as C};
use function com\yiibai\{fn_a, fn_b, fn_c};
use const com\yiibai\{ConstA, ConstB, ConstC};

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
```

