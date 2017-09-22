# PHPunit install

```
wget https://phar.phpunit.de/phpunit.phar
chmod +x phpunit.phar
sudo mv phpunit.phar /usr/local/bin/phpunit
phpunit --version
```

# PHPDoc

```
brew isntall php71
```

## 代码规范

[jupeter/clean-code-php](https://github.com/jupeter/clean-code-php)

## OOP

继承：类分层、接口分层 实现：类实现接口 依赖：类作为另一个类方法的参数 关联：类属性 聚合：可以有 组合：必须有

- PHP异步调用
- 正则匹配src标签
- 处理回文字符

## 模型

数据模型

业务模型

## 功能

trait就是为了避免代码重复而生

```
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

接口与抽象类：

1.接口中的每个方法，继承类里面都要去实现 2.接口中的方法后面不要跟大口号{},因为接口只是定义需要有这个函数，并不是自己去实现 3.抽象类中 abstract 的方法，继承类里面都要去实现，也可以理解成接口中的每个方法都是 abstract 方法 4.抽象方法中没有abstract 的方法，继承类不必非要写那个方法

举例,场景：我们在记录日志的时候，有时候可能需要写入文件，有时候可能写入数据库 这时候，我们可以写一个Log接口，定义需要的方法 然后分别写一个FileLog类和一个DatabaseLog类 然后我们写一个UsersController类做一个依赖注入，这样我们需要使用哪种方式写日志，实例化的时候，注入哪种类即可

```
<?php
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

### 扩展

- intl
- mcrypt
- memeache
- memeached
- mongo
- opcache
- pdo-pgsql
- phalcon
- redis
- sphinx
- swoole
- xdebug

TP参考：<https://github.com/ijry/lyadmin>

laravel->symfony

<https://leanpub.com/phptherightway/read#test_driven_development_title>

## 框架

- yaf
- [pinguo/php-msf](https://github.com/pinguo/php-msf)PHP微服务框架即"Micro Service Framework For PHP"，是Camera360社区服务器端团队基于Swoole自主研发现代化的PHP协程服务框架，简称msf或者php-msf，是Swoole的工程级企业应用框架，经受了Camera360亿级用户高并发大流量的考验
- [Youzan Zan Php Installer](https://github.com/youzan/zan-installer)Youzan Zan Php Installer
- [tencent-php/tsf](https://github.com/tencent-php/tsf):coroutine and Swoole based php server framework in tencent

## 资源

- [Awesome PHP](http://coffeephp.com/resources)
- [ziadoz/awesome-php](https://github.com/ziadoz/awesome-php)
- [开源项目](https://my.oschina.net/editorial-story/blog/1535228)

## 社区

- [coffeephp](http://coffeephp.com/)
- [fukuball/Awesome-Laravel-Education](https://github.com/fukuball/Awesome-Laravel-Education)

<http://www.jianshu.com/p/a5d905778b47>

$GLOBALS['HTTP_RAW_POST_DATA']

## 扩展

- [youzan/php-co-koa](https://github.com/youzan/php-co-koa)PHP异步编程: 手把手教你实现co与Koa
- [youzan/zan](https://github.com/youzan/zan)高效稳定、安全易用、线上实时验证的全异步高性能网络库，通过PHP扩展方式使用。
- [HanSon/youzan-sdk](https://github.com/HanSon/youzan-sdk)有赞 SDK
- [hprose/hprose-php](https://github.com/hprose/hprose-php)Hprose is a cross-language RPC
- [awesome-php](https://github.com/ziadoz/awesome-php)

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