# xUnit 

## [PHPUnit](https://github.com/sebastianbergmann/phpunit)

The PHP Unit Testing framework. <https://phpunit.de/>

### 安装

```sh
wget https://phar.phpunit.de/phpunit.phar
chmod +x phpunit.phar
sudo mv phpunit.phar /usr/local/bin/phpunit
phpunit --version

sudo pear install pear.phpunit.de/PHPUnit

sudo pear channel-discover pear.phpunit.de
sudo pear install phpunit/PHPUnit
```

### 配置

* PhpStrom
	* 创建代码文件
	* 右键 goto->test 创建测试文件->指定目录
	* 测试文件引入源文件
	* 配置文件
	  - 设置：phpunit->user composer autoloader->vender/autoloader.php
	  - 测试文件路径：run->edit configuration->directory
	* 执行单个文件
	  - 当前测试类右键Run即可
	  - `phpunit tests/ArraysTest.php`

```sh
phpunit MyTest.php
```

### 优化

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

## [Junit](https://github.com/junit-team/junit5)

* The next generation of JUnit. <https://junit.org>
* 测试方法使用@Test修饰
* 使用public void修饰，不带任何参数
* 新建源代码目录存放测试代码
* 测试类包与被测试类保持一致
* 测试单元中每个方法可以独立测试，方法间不能有任何依赖
* 测试类使用Test作为类名后缀
* 测试方法使用test作为方法名前缀

Failture:由断言方法引起，输出与预期不一样
Error:代码异常引起
测试用例不是用来证明你是对的，而是用来证明你没有错

### 版本

* JUnit5=Platform+Jupiter+Vintage

## 基础

* 结构
	* one test case per every class： Class -> `ClassTest`
	* Every test is a method，Every method will be run independently in an isolated environment
* 声明
	* method 命名 test* 
	* 通过 @test 注解，函数名字不必以 test 开头
* `ClassTest`通常继承 `PHPUnit\Framework\TestCase`
* 全局单元测试:一次性执行所有的单元测试，可以编写 phpunit.xml 文件来实现
  - `<directory>test</directory>` 指定了测试代码都放在 test 目录下

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
 
```sh
phpunit --colors -stop-on-error -stop-on-failure --denug --strict

phpunit -c phpunit.xml --testsuite=Unit  # 指定套件
 --coverage-html . # 在根目录下生成 HTML 格式的测试覆盖率报告文档
```

####  assert*()

* an if() construct inside a test used for enable checks on variables
* contain multiple assertions, beware that the first failure will prevent the
subsequent assertions from being executed. Only the assert*() calls which
strictly depends on the previous ones to make sense should be placed in
the same method as them.
* support a supplemental string parameter named $message, which will be shown in the case of a failing test caused by the assertion
* `void assertTrue(boolean expected, boolean actual)`
* `void assertFalse(boolean condition)`
* `assertEquals($expected, $actual)`
* `void assertArrayEquals(expectedArray, resultArray):assertArrayEquals()` 
*  `assertSame($expected, $actual)`
* `void assertNotSame(boolean condition):assertNotSame()`
* `assertContains($needle, $haystack)`
* `assertArrayHasKey($key, $array) assertContainsOnly($type, $haystack)`
* `assertType($type, $variable)`
* `assertNotNull($variable)`
* `void assertNull(Object object)`
*  `assertLessThan(),assertGreaterThan()`
*  `assertGreatherThanOrEqual(), assertLessThanOrEquals()`
*  `ssertStringsStartsWith($prefix, $string) assertStringsEndsWith($suffix, $string)`

#### fixture

* fixture 对开始执行某个测试时应用程序和数据库所处初始状态的描述
	* more than one fixture is requested, the common practice is to break down the test case, preparing more than one test case class for the system under test; these classes represents different scenarios and
* executed for every test,the test methods have the same state as a starting point
* `setUp()` 运行测试方法前，调用的模板方法,创建测试所用对象的地方
* `tearDown()` 测试方法运行结束后，不管是成功还是失败，调用的模板方法,清理测试所用对象的地方
	* * 只有在 `setUp()` 中分配了诸如文件或套接字之类的外部资源时才需要实现 `tearDown()`
	* * 如果 `setUp()` 中只创建纯 PHP 对象，通常可以略过 `tearDown()`。
	* 如果在 `setUp()` 中创建了大量对象，可能想要在` tearDown()` 中 `unset()` 指向这些对象的变量，这样可以被垃圾回收机制回收掉。对测试用例对象的垃圾回收动作则是不可预知的。
* `setUpBeforeClass(`) 与 `tearDownAfterClass()` 在测试用例类的第一个测试运行之前和测试用例类最后一个测试运行之后调用
* `assertPreConditions()` and` assertPostConditions()` executed before and after the a test method. 
	* differ from setUp() and tearDown() since they are executed only if the test did not already fail and they can halt the execution with a failing assertion. 
	* setUp() and tearDown() should never throw exceptions and they are executed anyway, unconcerned by the current test outcome.
* sharing a fixture between test cases can be a smell for a bad design
	* 在测试之间共享基境的需求源于某个未解决的设计问题
	* 一个有实际意义的例子是数据库连接：只登录数据库一次，然后重用此连接，而不是每个测试都建立一个新的数据库连接。这样能加快测试的运行。
	* 共享会降低测试价值。潜在设计问题是对象之间并非松散耦合。如果解决掉潜在设计问题并使用桩件(stub)来编写测试，就能达成更好的结果，而不是在测试之间产生运行时依赖并错过改进设计的机会。
	* 全局状态:使用 singleton 代码很难测试,使用全局变量代码也一样，类的静态属性也是
		* 通常情况下，欲测代码和全局变量之间会强烈耦合，并且其创建无法控制
		* 另外一个问题：一个测试对全局变量的改变可能会破坏另外一个测试
	  - 全局变量 `$foo = 'bar';` 实际上是存储为 `$GLOBALS['foo'] = 'bar'` 超全局变量`$GLOBALS` 在任何变量作用域中都总是可用的内建变量
	  - 在函数或者方法的变量作用域中，要访问全局变量 `$foo`，可以直接访问 `$GLOBALS['foo']` 来创建一个引用全局变量的局部变量

#### annotations

* a standard way to add metadata to code entities: add behavior to test case class without making write boilerplate code
* must be placed in docblock comments
	* the php engine there is no native support for them: phpunit extracts them from the comment block using reflection.
* `@Test`
* `@Before`
* `@After`
* `@BeforeClass`
* `@AfterClass`
* `@Ignore`
* `@dataProvider`
* `@depends` solve this common problem of logic and temporal precedence
	* 生成：返回数据
	* 依赖数据作为参数引入到测试中，可以修改
	* 多个参数按照声明顺序作为测试参数传入

#### stub

#### Mock

* 虚拟出一个调用

##### [Mock](https://github.com/nuysoft/Mock)

A simulation data generator <http://mockjs.com>

* [easy-mock](https://github.com/easy-mock/easy-mock):A persistent service that generates mock data quickly and provids visualization view. <https://easy-mock.com>
* [json-server](https://github.com/typicode/json-server):Get a full fake REST API with zero coding in less than 30 seconds (seriously)
* [nock](https://github.com/nock/nock):HTTP server mocking and expectations library for Node.js

## 术语

* SUT system under test

## 图书

* 单元测试的艺术
* [xUnit Test Patterns: Refactoring Test Code](http://xunitpatterns.com/index.html)

## 工具

* [JUnitGenerator V2.0](link)自动生成测试代码，需要安装
* [semaphore](https://semaphoreci.com/):Hosted CI/CD for teams that don’t like bottlenecks

## 参考

* [docs](https://junit.org/junit5/docs/current/user-guide/)
* [Writing Tests with JUnit 5](https://blog.jetbrains.com/idea/2020/09/writing-tests-with-junit-5/)
* [unit test](https://mkyong.com/unittest/)
* [PHPUnit 文档](http://www.phpunit.cn)
* [PHPUnit Manual](https://phpunit.readthedocs.io/zh_CN/latest/index.html)
  *　Gerard Meszaros《xUnit 测试模式》
