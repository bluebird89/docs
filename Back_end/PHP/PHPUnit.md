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

-   [PHPUnit 文档](http://www.phpunit.cn)
