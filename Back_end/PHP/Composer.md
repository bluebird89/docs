# [composer/composer](https://github.com/composer/composer)

Dependency Manager for PHP https://getcomposer.org/  [中文](https://www.phpcomposer.com/)

* 自动加载可以使用__autoload()和sql_autoload_register()两种机制
  - _autoload()有个缺点就是一个进程中只能定义一次
  - sql_autoload_register()不存在这个问题，它可以把函数注册到__autoload队列中
* 底层也是通过 spl_autoload_register 函数实现类的自动加载的，只是在此之前，还会建立命令空间与类脚本路径的映射

## 原理

* zend_lookup_class_ex
  * EG(class_table)
  * spl_autoload_call  spl_autoload_register:将用户的autoload函数放到SPL_G(autoload_functions)中，且将spl_autoload_call注册到PHP中。
    * Composer\Autoload\ClassLoader::loadClass
      * findFile
        * class map lookup
        * PSR-4 lookup
        * PSR-0 :autoload_namespaces.php
* $prefix不为空的PSR-4加载规则:比如类A\B\C，先找A\B\对应目录下面的C.php；再找A\对应目录下面的B\C.php；以此类推
* $prefix为空的PSR-4加载规则:如果找不到，那就在fallbackDirsPsr4下找A\B\C.php文件
* $prefix不为空的PSR-0加载规则:PSR-0支持namespace和下划线分隔的类（PEAR-like class name）；这点对一些需要向namespace迁移的旧仓库很有用 对于类A\B\C或者A_B_C，先找A\B\对应目录下面的C.php；再找A\对应目录下面的B\C.php；以此类推
* $prefix为空的PSR-0加载规则:如果找不到，直接在prefixesPsr0中找A\B\C.php文件 如果还没有找到，在条件允许的状态下，可以到include path中找A\B\C.php文件
* composer install 会遍历　lock 源

## 安装

* 源
  - [aliyun](https://mirrors.aliyun.com/composer/)
  - [tencent](https://mirrors.cloud.tencent.com/composer/)
  - [huaweicloud](https://mirrors.huaweicloud.com/repository/php/)
  - [cnpkg.org](https://php.cnpkg.org)
  - [laravel-china](https://packagist.laravel-china.org)

```sh
# method 1
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

# method 2
php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');"
php composer-setup.php # 安装
php -r "unlink('composer-setup.php');" # 删除
sudo mv composer.phar /usr/local/bin/composer

sudo chown -R $USER .composer/

# method 3
wget https://getcomposer.org/composer.phar
chmod +x composer.phar
mv composer.phar /usr/local/bin/composer

# Mac
brew install composer
# ubuntu
apt install composer
# centos
yum install epel-release -y
yum install composer

# file_put_contents(./composer.json): failed to open stream: Permission denied
sudo chown -R $USER .composer/

### 卸载composer:找到文件删除即可
# ~/.composer/auth.json
# C:\Users\XXX\AppData\Roaming\Composer\config.json
composer config -l # 查看
composer config --list --global
composer config -g repo.packagist composer https://packagist.phpcomposer.com # 全局配置
composer config repo.packagist composer https://packagist.phpcomposer.com # 项目配置
composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/
composer config -g repo.packagist composer https://mirrors.huaweicloud.com/repository/php/
composer config composer_home

composer config -g --unset repos.packagist
composer config --global --auth github-oauth.github.com myCorrectLongToken

composer config repositories.repo-name vcs https://github.com//repo
composer config -g  repositories.tmo composer https://packages.tmogroup.asia/
```

## package

* 编辑composer.json,增加或更新了细节信息，比如库的描述、作者、更多参数，甚至仅仅增加了一个空格，都会改变文件的md5sum。然后Composer就会警告哈希值和composer.lock中记载的不同:composer update nothing
* name格式："name":"vendor/package"
* version格式："version":"1.0.2"
* repositories仓库地址
  - 默认Composer 只使用 Packagist 仓库。通过指定仓库地址，可以从任何地方获取包
  - composer:仓库通过网络提供 packages.json 文件，包含一个 composer.json 对象的列表，还有额外的 dist 或 source 信息。packages.json 文件通过 PHP 流加载
  - vcs:版本控制系统仓库，如：git、svn、hg
  - pear:可以导入任何 pear 仓库到你的项目中
* 加载自定义包
  - 建立存放第三方的目录
  - 修改composer.json中的autoload>classmap增加文件路径
  - `composer dump-autoload`
* 加载没有制作 Composer，以 require 的方式进行加载

```
"repositories": [
        {
            "type": "composer",
            "url": "http://packages.example.com"
        },
        {
            "type": "composer",
            "url": "https://packages.example.com",
            "options": {
                "ssl": {
                    "verify_peer": "true"
                }
            }
        },
        {
            "type": "vcs",
            "url": "https://github.com/Seldaek/monolog"
        },
        {
            "type": "pear",
            "url": "http://pear2.php.net"
        },
        {
            "type": "package",
            "package": {
                "name": "smarty/smarty",
                "version": "3.1.7",
                "dist": {
                    "url": "http://www.smarty.net/files/Smarty-3.1.7.zip",
                    "type": "zip"
                },
                "source": {
                    "url": "http://smarty-php.googlecode.com/svn/",
                    "type": "svn",
                    "reference": "tags/Smarty_3_1_7/distribution/"
                }
            }
        }
    ]
```

## 自动加载

* Files：手动指定直接加载的文件（相对于 vendor 目录）
  - 不需要满足 PSR-0 和 PSR-4 规范
  - 将数组中文件进行自动加载，文件路径相对于项目根目录
* classmap：支持将数组中路径下的文件进行自动加载
  - 配置指定目录或者文件，然后在composer安装或者更新的时，会扫描指定目录下以.php和.inc结尾的文件中的class，生成class到指定file path映射`vendor/composer/autoload_classmap.php`
  - 用 spl_autoload_register 这个函数来怒做自动加载了
  - 即使不遵循 PSR-0 和 PSR-4 规范也可以自动加载成功
  - 缺点:一旦增加了新文件，需要执行dump-autoload命令重新生成映射文件
* psr-0:支持将命名空间映射到路径。命名空间结尾`\\`不可省略
  * 执行install或update时，加载信息会写入`vendor/composer/autoload_namespace.php`
  * 如果希望解析指定路径下所有命名空间，则将命名空间置为空串即可
  * 注意:对应name2\space\Foo类的类文件的路径为path2/name2/space/Foo.php
* psr-4:支持将命名空间映射到路径。命名空间结尾的`\\`不可省略
  - 执行install或update时，加载信息会写入~~`vendor/composer/autoload_psr4.php`
  - 如果希望解析指定路径下的所有命名空间，则将命名空间置为空串即可。
  - 注意:对应name2\space\Foo类的类文件的路径为path2/space/Foo.php，name2不出现在路径中
* PSR-4 vs PSR-0
  - $student = new \Bpp\Student()
  * PSR-4指定的就当作当前命名空间的目录,代码目录结构是： app/Student.php 。即目录不需要包含最外层的命名空间 App
    - 去加载”Foo\Bar\Baz”这个class时，会去寻找“src\Bar\Baz.php”这个文件，对应的会写入到vendor/composer/autoload_psr4.php 这个文件中
  * PSR-0 指定的是当前命名空间的父目录,代码目录结构是： bpp/Bpp/Student.php 。即目录包含最外层命名空间 Bpp
    - 目录名称与命名空间层层对应，类名中的下划线_会被转化成目录分隔符，会导致目录结构变得比较深,加载”Foo\Bar\Baz”这个class时，会去寻找“src\Foo\Bar\Baz.php”这个文件，这个配置会以map的形式写入生成的vendor/composer/autoload_namespaces.php中。
  + 最大区别是对下划线（underscore)定义不同
    * PSR-4中，在类名中使用下划线没有任何特殊含义
    * PSR-0则规定类名中的下划线_会被转化成目录分隔符
  + 按需加载

```
require '../vendor/autoload.php
```

## 使用

* global 命令允许在 COMPOSER_HOME 目录下执行命令
* 精确版本：示例： 1.0.2
* 使用比较操作符可以指定包的范围。这些操作符包括：>，>=，<，<=，!=
* 使用空格 或者逗号,表示逻辑上的与，使用双竖线||表示逻辑上的或。其中与的优先级会大于或
* 范围（使用连字符）: 1.0 - 2.0
* 可以使用通配符去定义版本: 1.0.*
* 下一个重要版本操作符：使用波浪号~ : `~1.2`
* 折音号^：例如，^1.2.3相当于>=1.2.3 <2.0.0
* 镜像：安装包的数据（主要是 zip 文件）一般是从 github.com 上下载的，安装包的元数据是从 packagist.org 上下载的
* 考虑缓存，dist包优先:Composer会自动存档下载dist包(`~/.composer/cache/files/`)。默认设置下，dist包用于加了tag的版本，例如"symfony/symfony": "v2.1.4"，或者是通配符或版本区间，"2.1.\*"或">=2.2,<2.3-dev"
* Github允许下载某个git引用的压缩包。为了强制使用压缩包，而不是克隆源代码，可以使用install和update的--prefer-dist选项
* 考虑修改，源代码优先:--prefer-source
* composer remove 更新很多版本库

```sh
composer list  # 列出所有可用的命令
composer init  # 新建文件 composer.json
composer init --require=foo/bar:1.0.0 -n
composer init --require="twig/twig:1.*" -n --profile # 显示执行时间

composer require --dev /repo:dev-branchname

composer why vlucas/phpdotenv # 确定哪些依赖项需要它
composer search monolog
compsoer show -t monolog # 用依赖关系树的形式 查看安装的包及其版本号和说明
composer status -v # 查看本地修改的软件包和文件
composer clear-cache

composer global require "squizlabs/php_codesniffer=*"
composer global require friendsofphp/php-cs-fixer

composer install -vvv # 使用composer install或者composer update命令将会更新所有的扩展包
composer outdated -m # 检测一下已安装的包，哪些有可以升级
composer update|remove [packagename] -vvv # 更新的话，先删除composer.lock文件
composer self-update

composer create-project swoft/swoft swoft
composer create-project doctrine/orm path 2.2.0

export PATH="/usr/local/bin:/Users/username/.composer/vendor/bin":$PATH # 添加到全局文件

composer dump-autoload --optimize|-o # 优化自动加载,将 PSR-4/PSR-0 的规则转化为了 classmap 的规则
composer dump-autoload --classmap-authoritative|-a  # 同样也是生成了 classmap，区别在于当加载器在 classmap 中找不到目标类时，不会再去文件系统中查找
composer dump-autoload --apcu # 要安装 apcu 扩展。apcu 可以理解为一块内存，并且可以在多进程中共享,文件系统中找到的结果存储到共享内存
composer run-script

# >=1.0
# >=1.0 <2.0
# >=1.0 <1.1 || >=1.2

## 使用
require 'vendor/autoload.php' # 自动加载
require **DIR** . '/vendor/autoload.php';

use Cocur\Slugify\Slugify;
$slugify = new Slugify();
echo $slugify->slugify('Hello World, this is a long sentence and I need to make a slug from it!');
```

## question

```
＃　http://packagist.phpcomposer.com/  Authentication required

# centos: Do not run Composer as root/super user
composer install --no-plugins --no-scripts

# PHP Fatal error:  Allowed memory size of 2147483648 bytes exhausted (tried to allocate 4096 bytes) in phar:///usr/local/Cellar/composer/1.7.2/bin/composer/src/Composer/DependencyResolver/RuleSetGenerator.php on line 126
调整PHP memory_limit 大小
```

## 命名空间

* 如果一个文件中包含命名空间，它必须在其它所有代码之前声明命名空间
* 用户编写的代码与PHP内部的类/函数/常量或第三方类/函数/常量之间的名字冲突
* 为很长的标识符名称(通常是为了缓解第一类问题而定义的)创建一个别名（或简短）的名称，提高源代码的可读性
* 以下类型的代码受命名空间的影响，它们是：类（包括抽象类和traits）、接口、函数和常量
* 可以在同一个文件中定义多个命名空间,建议使用下面的大括号形式的语法
* 类名可以通过三种方式引用
  - 非限定名称，或不包含前缀的类名称，例如 $a=new foo(); 或 foo::staticmethod();。如果当前命名空间是 currentnamespace，foo 将被解析为 currentnamespace\foo。如果使用 foo 的代码是全局的，不包含在任何命名空间中的代码，则 foo 会被解析为foo。
  - 限定名称,或包含前缀的名称，例如 $a = new subnamespace\foo(); 或 subnamespace\foo::staticmethod();。如果当前的命名空间是 currentnamespace，则 foo 会被解析为 currentnamespace\subnamespace\foo。如果使用 foo 的代码是全局的，不包含在任何命名空间中的代码，foo 会被解析为subnamespace\foo。
  - 完全限定名称，或包含了全局前缀操作符的名称，例如， $a = new \currentnamespace\foo(); 或 \currentnamespace\foo::staticmethod();。
* 两种抽象的访问当前命名空间内部元素的方法，`__NAMESPACE__` 魔术常量和namespace关键字
  - 常量__NAMESPACE__的值是包含当前命名空间名称的字符串。在全局的，不包括在任何命名空间中的代码，它包含一个空的字符串
* 导入：允许通过别名引用或导入外部的完全限定名称
  - 为类名称使用别名
  - 为接口使用别名
  - 为命名空间名称使用别名

```php
namespace my\name;

class MyClass {}
function myfunction() {}
const MYCONST = 1;

$a = new MyClass;
$c = new \my\name\MyClass;

$d = namespace\MYCONST;

$d = __NAMESPACE__ . '\MYCONST';
echo constant($d);

# 同一个文件中定义多个命名空间,两种方式
namespace MyProject;

const CONNECT_OK = 1;
class Connection { /* ... */ }
function connect() { /* ... */  }

namespace AnotherProject;

const CONNECT_OK = 1;
class Connection { /* ... */ }
function connect() { /* ... */  }

## 方式2
namespace MyProject {

const CONNECT_OK = 1;
class Connection { /* ... */ }
function connect() { /* ... */  }
}

namespace AnotherProject {

const CONNECT_OK = 1;
class Connection { /* ... */ }
function connect() { /* ... */  }
}

## 引用方式
namespace Foo\Bar;
include 'file1.php';

const FOO = 2;
function foo() {}
class foo
{
    static function staticmethod() {}
}

/* 非限定名称 */
foo(); // 解析为 Foo\Bar\foo resolves to function Foo\Bar\foo
foo::staticmethod(); // 解析为类 Foo\Bar\foo的静态方法staticmethod。resolves to class Foo\Bar\foo, method staticmethod
echo FOO; // resolves to constant Foo\Bar\FOO

/* 限定名称 */
subnamespace\foo(); // 解析为函数 Foo\Bar\subnamespace\foo
subnamespace\foo::staticmethod(); // 解析为类 Foo\Bar\subnamespace\foo,
                                  // 以及类的方法 staticmethod
echo subnamespace\FOO; // 解析为常量 Foo\Bar\subnamespace\FOO

/* 完全限定名称 */
\Foo\Bar\foo(); // 解析为函数 Foo\Bar\foo
\Foo\Bar\foo::staticmethod(); // 解析为类 Foo\Bar\foo, 以及类的方法 staticmethod
echo \Foo\Bar\FOO; // 解析为常量 Foo\Bar\FOO

## __NAMESPACE__
namespace MyProject;
echo '"', __NAMESPACE__, '"'; // 输出 "MyProject"
function get($classname)
{
    $a = __NAMESPACE__ . '\\' . $classname;
    return new $a;
}

## 全局代码
echo '"', __NAMESPACE__, '"'; // 输出 ""

## namespace
namespace MyProject;

use blah\blah as mine; // see "Using namespaces: importing/aliasing"

blah\mine(); // calls function MyProject\blah\mine()
namespace\blah\mine(); // calls function MyProject\blah\mine()

namespace\func(); // calls function MyProject\func()
namespace\sub\func(); // calls function MyProject\sub\func()
namespace\cname::method(); // calls static method "method" of class MyProject\cname
$a = new namespace\sub\cname(); // instantiates object of class MyProject\sub\cname
$b = namespace\CONSTANT; // assigns value of constant MyProject\CONSTANT to $b

## 全局
namespace\func(); // calls function func()
namespace\sub\func(); // calls function sub\func()
namespace\cname::method(); // calls static method "method" of class cname
$a = new namespace\sub\cname(); // instantiates object of class sub\cname
$b = namespace\CONSTANT; // assigns value of constant CONSTANT to $b

## 使用use操作符导入/使用别名
namespace foo;
use My\Full\Classname as Another;

// 下面的例子与 use My\Full\NSname as NSname 相同
use My\Full\NSname;
// 导入一个全局类
use ArrayObject;
// importing a function (PHP 5.6+)
use function My\Full\functionName;
// aliasing a function (PHP 5.6+)
use function My\Full\functionName as func;
// importing a constant (PHP 5.6+)
use const My\Full\CONSTANT;

$obj = new namespace\Another; // 实例化 foo\Another 对象
$obj = new Another; // 实例化 My\Full\Classname　对象
NSname\subns\func(); // 调用函数 My\Full\NSname\subns\func
$a = new ArrayObject(array(1)); // 实例化 ArrayObject 对象
// 如果不使用 "use \ArrayObject" ，则实例化一个 foo\ArrayObject 对象
func(); // calls function My\Full\functionName
echo CONSTANT; // echoes the value of My\Full\CONSTANT

# 通过use操作符导入/使用别名，一行中包含多个use语句
use My\Full\Classname as Another, My\Full\NSname;
$obj = new Another; // 实例化 My\Full\Classname 对象
NSname\subns\func(); // 调用函数 My\Full\NSname\subns\func

# 导入和动态名称
use My\Full\Classname as Another, My\Full\NSname;
$obj = new Another; // 实例化一个 My\Full\Classname 对象
$a = 'Another';
$obj = new $a;      // 实际化一个 Another 对象

# 导入和完全限定名称
use My\Full\Classname as Another, My\Full\NSname;
$obj = new Another; // instantiates object of class My\Full\Classname
$obj = new \Another; // instantiates object of class Another
$obj = new Another\thing; // instantiates object of class My\Full\Classname\thing
$obj = new \Another\thing; // instantiates object of class Another\thing
```

## 自动加载

PHP在需要类定义的时候调用它

* include 或 require
* `__autoload`:调用不存在的类时会被自动调用,现在基本废弃
  - 一个文件中不允许有多个 `__autoload()`方法，引入文件中也存在`__autoload()`
  - 一个文件中引入多个文件目录
* bool spl_autoload_register ([ callable $autoload_function [, bool $throw = true [, bool $prepend = false ]]] ) :注册给定的函数作为 `__autoload` 的实现
  - 函数名称
  - 闭包函数
* 获取所有已注册的 `__autoload()` 函数:spl_autoload_functions ( void )
* spl_classes — 返回所有可用的SPL类
* spl_autoload_unregister — 注销已注册的`__autoload()`函数

```php
<?php
function __autoload($class){
    if(file_exists($class.".php")){
        require_once($class.".php");
    }else{
        die("文件不存在！");
    }
}

Test1::test();
Test2::test();

// 注册
spl_autoload_register(function ($class_name) {
    $class_name = str_replace('\\','/', $class_name); /*将 use语句中的’\’替换成’/‘，避免造成转移字符导致require_once时会报错*/
    $file_name  = $class_name . '.class.php';
    if (file_exists($file_name)) {
        require_once $file_name;
    }

});

use Animal\Dog;

$dog = new Dog();
$cat = new \Animal\Cat();
```

## 创建组件

* 确定厂商名称和包名，即形如laravel/framework这样，要确保其全局唯一性，在Packagist中不存在

* 系统结构基本上是确定的：
  
  - src：存放组件源代码
  
  - tests：存放组件测试代码
  
  - composer.json：Composer配置文件，用于描述组件，声明组件依赖以及自动加载配置等
    
    + name：组件的厂商名和包名，也是Packagist中的组件名
    + description：简要说明组件
    + keywords：描述属性的关键字
    + homepage：组件网站URL
    + license：PHP组件采用的软件许可证（更多软件许可证参考：http://choosealicense.com/）
    + authors：作者信息数组
    + support：组件用户获取技术支持的方式
    + require：组件自身依赖的组件
    + require-dev：开发这个组件所需的依赖
    + suggest：建议安装的组件
    + autoload：告诉Composer自动加载器如何自动加载这个组件
  
  - README.md：关于组件的相关信息、使用文档说明、软件许可证等
    
    + 组件的名称和描述
    + 安装说明
    + 使用说明
    + 测试说明
    + 贡献方式
    + 支持资源
    + 作者信息
    + 软件许可证
  
  - CONTRIBUTING.md：告知别人如何为这个组件做贡献
  
  - LICENSE：纯文本文件，声明组件的软件许可证
  
  - CHANGELOG.md：列出组件在每个版本中引入的改动

```sh
composer init
```

## 参考

* [Packagist](https://packagist.org):The PHP Package Repository
* [PSR(PHP Standards Recommendations)](http://www.php-fig.org/):组织制定的PHP语言开发规范，约定了很多方面的规则，如命名空间、类名规范、编码风格标准、Autoload、公共接口等

## 工具

* [Ocramius/PackageVersions](https://github.com/Ocramius/PackageVersions):📦 Composer addon to efficiently get installed packages' version numbers
* [satis](https://github.com/composer/satis):Simple static Composer repository generator - For a full private Composer repo use Private Packagist
