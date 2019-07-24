# [sebastianbergmann/phpunit](https://github.com/sebastianbergmann/phpunit)

The PHP Unit Testing framework. https://phpunit.de/

## 安装

```sh
wget https://phar.phpunit.de/phpunit.phar
chmod +x phpunit.phar
sudo mv phpunit.phar /usr/local/bin/phpunit
phpunit --version
```

## 使用

* 单元测试类名必须以 Test 结尾，必须继承 \PHPUnit\Framework\TestCase 基类。
* 每个测试函数必须以 test 开头
* 提供了 @test 的注解，如果一个测试函数添加了 @test 注解，那么测试函数名字就不必以 test 开头
* PHPUnit\Framework\TestCase 有一个 setUp 函数，如果自己编写的测试类重写了这个函数，那么每次在开始执行测试函数之前，会先执行 setUp 进行测试之前的初始化。同样，也有一个 tearDown 的函数，如果重写，那么在测试函数执行完毕之后调用 tearDown 函数
* Mock 测试:虚拟出一个 调用
* 执行单个文件
    - Phpstorm 下 当前测试类右键Run即可
    - `phpunit tests/ArraysTest.php`
* 全局单元测试:一次性执行所有的单元测试，可以编写 phpunit.xml 文件来实现
    - `<directory>test</directory>` 指定了测试代码都放在 test 目录下

```php
# 功能代码 src/Email.php
declare(strict_types=1);

final class Email
{
    private $email;

    private function \__construct(string $email)
    {
        $this->ensureIsValidEmail($email);

        $this->email = $email;
    }

    public static function fromString(string $email): self
    {
        return new self($email);
    }

    public function \__toString(): string
    {
        return $this->email;
    }

    private function ensureIsValidEmail(string $email): void
    {
        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            throw new InvalidArgumentException(
                sprintf(
                    '"%s" is not a valid email address',
                    $email
                )
            );
        }
    }
}

# 测试用例 tests/EmailTest.php
declare(strict_types=1);

use PHPUnit\Framework\TestCase;

/**
* @covers Email
*/
final class EmailTest extends TestCase
{
    public function testCanBeCreatedFromValidEmailAddress(): void
    {
        $this->assertInstanceOf(
            Email::class,
            Email::fromString('user@example.com')
        );
    }

    public function testCannotBeCreatedFromInvalidEmailAddress(): void
    {
        $this->expectException(InvalidArgumentException::class);
        Email::fromString('invalid');
    }

    public function testCanBeUsedAsString(): void
    {
        $this->assertEquals(
            'user@example.com',
            Email::fromString('user@example.com')
        );
    }
}

# `phpunit --bootstrap src/Email.php tests/EmailTest`

/**
 * Generated from @assert (0, 0) == 0.
 */
public function testSum() {
    $obj = new Calculator;
    $this->assertEquals(0, $obj->sum(0, 0));
}

<?xml version="1.0" encoding="UTF-8"?>
<phpunit>
    <testsuites>
        <testsuite>
            <directory>test</directory>
        </testsuite>
    </testsuites>
    <logging>
        <log type="testdox-html" target="tmp/log.html"/>
    </logging>
</phpunit>
```

## 配置使用

在 PhpStrom 环境下使用

-   创建代码文件
-   右键 goto->test 创建测试文件（指定目录）
-   测试文件引入源文件
-   配置文件
    -   设置：phpunit->user composer autoloader->vender/autoloader.php
    -   测试文件路径：run->edit configuration->directory
-   run

## 参考

-  [PHPUnit 文档](http://www.phpunit.cn) <https://phpunit.de/manual/6.5/zh_cn/>
