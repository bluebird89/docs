# [phpunit](https://github.com/sebastianbergmann/phpunit)

The PHP Unit Testing framework. <https://phpunit.de/>

* 单元测试主要是作为一种良好实践来编写的，能帮助开发人员识别并修复 bug、重构代码，还可以看作被测软件单元的文档
* 理想的单元测试应当覆盖程序中所有可能的路径

## 安装

```sh
wget https://phar.phpunit.de/phpunit.phar
chmod +x phpunit.phar
sudo mv phpunit.phar /usr/local/bin/phpunit
phpunit --version

sudo pear install pear.phpunit.de/PHPUnit
```

## 使用

* 针对类 Class 的测试写在类 `ClassTest`中
* `ClassTest`（通常）继承自 `PHPUnit\Framework\TestCase`
* 测试都是命名为 test* 的公用方法
* 测试方法内，类似于 assertSame() 这样的断言方法用来对实际值与预期值的匹配做出断言
* 提供了 @test 的注解，如果一个测试函数添加了 @test 注解，那么测试函数名字就不必以 test 开头
* `PHPUnit\Framework\TestCase`
  - setUp 函数，如果自己编写的测试类重写了这个函数，那么每次在开始执行测试函数之前，会先执行 setUp 进行测试之前的初始化
  - tearDown 函数，如果重写，那么在测试函数执行完毕之后调用 tearDown 函数
* Mock 测试:虚拟出一个调用
* 执行单个文件
  - Phpstorm 下 当前测试类右键Run即可
  - `phpunit tests/ArraysTest.php`
* 全局单元测试:一次性执行所有的单元测试，可以编写 phpunit.xml 文件来实现
  - `<directory>test</directory>` 指定了测试代码都放在 test 目录下

```sh
phpunit --colors -stop-on-error -stop-on-failure --denug --strict
phpunit -c phpunit.xml --testsuite=Unit  # 指定套件
 --coverage-html . # 在根目录下生成 HTML 格式的测试覆盖率报告文档
```

## 配置使用

在 PhpStrom 环境下使用

* 创建代码文件
* 右键 goto->test 创建测试文件（指定目录）
* 测试文件引入源文件
* 配置文件
  - 设置：phpunit->user composer autoloader->vender/autoloader.php
  - 测试文件路径：run->edit configuration->directory
* run

## 优化

* 编写
  * 测试的依赖关系:一个单元测试通常覆盖一个函数或方法中的一个特定路径。但是，测试方法并不一定非要是一个封装良好的独立实体。测试方法之间经常有隐含的依赖关系暗藏在测试的实现方案中。
    - 支持对测试方法之间的显式依赖关系进行声明。这种依赖关系并不是定义在测试方法的执行顺序中，而是允许生产者(producer)返回一个测试基境(fixture)的实例，并将此实例传递给依赖于它的消费者(consumer)们
    - 生产者(producer)，是能生成被测单元并将其作为返回值的测试方法。
    - 消费者(consumer)，是依赖于一个或多个生产者及其返回值的测试方法
    - 默认情况下，生产者所产生的返回值将“原样”传递给相应的消费者。这意味着，如果生产者返回的是一个对象，那么传递给消费者的将是一个指向此对象的引用。如果需要传递对象的副本而非引用，则应当用 @depends clone 替代 @depends。
    - 测试可以使用多个 @depends 标注。PHPUnit 不会更改测试的运行顺序，因此你需要自行保证某个测试所依赖的所有测试均出现于这个测试之前。
  * 数据供给器:以接受任意参数。这些参数由数据供给器方法提供。用 @dataProvider 标注来指定使用哪个数据供给器方法
  * 对异常进行测试:expectException()  expectExceptionCode()、expectExceptionMessage() 和 expectExceptionMessageRegExp()
  * 对 PHP 错误进行测试:PHPUnit\Framework\Error PHPUnit\Framework\Error\Notice 和 PHPUnit\Framework\Error\Warning
  * 对输出进行测试:断言（比如说）某方法的运行过程中生成了预期的输出（例如，通过 echo 或 print）
    - void expectOutputRegex(string $regularExpression) 设置输出预期为输出应当匹配正则表达式 $regularExpression。
    - void expectOutputString(string $expectedString) 设置输出预期为输出应当与 $expectedString 字符串相等。
    - bool setOutputCallback(callable $callback)  设置回调函数，用来做诸如将实际输出规范化之类的动作。
    - string getActualOutput()    获取实际输出。
  * 错误相关信息的输出:测试失败时，PHPUnit 全力提供尽可能多的有助于找出问题所在的上下文信息
* 命令行测试执行器
  - `phpunit ArrayTest`:在当前工作目录中寻找 ArrayTest.php
  - `phpunit UnitTest UnitTest.php`:源文件并加载之,类必须满足以下二个条件之一
    - 要么它继承自 PHPUnit\Framework\TestCase
    - 要么它提供 public static suite() 方法，这个方法返回一个 PHPUnit_Framework_Test 对象

## 基境(fixture)

将整个场景设置成某个已知的状态，并在测试结束后将其复原到初始状态。这个已知的状态称为测试的 基境(fixture)

* 基境(fixture)是对开始执行某个测试时应用程序和数据库所处初始状态的描述

* 运行某个测试方法前，会调用一个名叫 setUp() 的模板方法。setUp() 是创建测试所用对象的地方。

* 当测试方法运行结束后，不管是成功还是失败，都会调用另外一个名叫 tearDown() 的模板方法。tearDown() 是清理测试所用对象的地方。

* setUpBeforeClass() 与 tearDownAfterClass() 模板方法将分别在测试用例类的第一个测试运行之前和测试用例类的最后一个测试运行之后调用

* 只有在 setUp() 中分配了诸如文件或套接字之类的外部资源时才需要实现 tearDown()

* 如果 setUp() 中只创建纯 PHP 对象，通常可以略过 tearDown()。不过，如果在 setUp() 中创建了大量对象，可能想要在 tearDown() 中 unset() 指向这些对象的变量，这样它们就可以被垃圾回收机制回收掉。对测试用例对象的垃圾回收动作则是不可预知的。

* 基境共享:在测试之间共享基境的需求都源于某个未解决的设计问题。一个有实际意义的例子是数据库连接：只登录数据库一次，然后重用此连接，而不是每个测试都建立一个新的数据库连接。这样能加快测试的运行。

* 会降低测试的价值。潜在的设计问题是对象之间并非松散耦合。如果解决掉潜在的设计问题并使用桩件(stub)来编写测试，就能达成更好的结果，而不是在测试之间产生运行时依赖并错过改进设计的机会。

* 全局状态:使用单件(singleton)的代码很难测试,使用全局变量的代码也一样。通常情况下，欲测代码和全局变量之间会强烈耦合，并且其创建无法控制。另外一个问题是，一个测试对全局变量的改变可能会破坏另外一个测试。

  - 全局变量 $foo = 'bar'; 实际上是存储为 $GLOBALS['foo'] = 'bar'; 的。
  - ``$GLOBALS``这个变量是一种被称为*超全局*变量的变量。
  - 超全局变量是一种在任何变量作用域中都总是可用的内建变量。
  - 在函数或者方法的变量作用域中，要访问全局变量 $foo，可以直接访问 $GLOBALS['foo']，或者用 global $foo; 来创建一个引用全局变量的局部变量。
  - 类的静态属性也是一种全局状态

* 组织测试

  - 文件系统来编排测试套件:所有测试用例源文件放在一个测试目录中
    - 通过对测试目录进行递归遍历，PHPUnit 能自动发现并运行测试 `phpunit --bootstrap src/autoload.php tests`,
    - `phpunit --bootstrap src/autoload.php tests/CurrencyTest` 单个文件
  - 用 XML 配置来编排测试套件

* 未完成的测试与跳过的测试

* 数据库测试:DbUnit 扩展大大简化了为测试设置数据库的操作，并且可以在对数据执行了一系列操作之后验证数据库的内容,支持 MySQL、PostgreSQL、Oracle 和 SQLite。通过集成 Zend Framework 或 Doctrine 2，也可以访问其他数据库系统，比如 IBM DB2 或者 Microsoft SQL Server。

  - 数据库交互建立和维护都很复杂。对数据库进行测试时，需要考虑以下这些变数：
    + 数据库和表
    + 向表中插入测试所需要的行
    + 测试运行完毕后验证数据库的状态
    + 每个新测试都要清理数据库
      -　保持每个测试所使用的数据量较小并且尽可能用非数据库测试来对代码进行测试，即使很大的测试套件也能轻松在一分钟内跑完。
  - todo

* 测试替身

## 工具

* [semaphore](https://semaphoreci.com/):Hosted CI/CD for teams that don’t like bottlenecks

## 参考

* [PHPUnit 文档](http://www.phpunit.cn)
* [PHPUnit Manual](https://phpunit.readthedocs.io/zh_CN/latest/index.html)
  *　Gerard Meszaros《xUnit 测试模式》
