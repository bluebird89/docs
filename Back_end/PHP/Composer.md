# [composer/composer](https://github.com/composer/composer)

Dependency Manager for PHP https://getcomposer.org/

PHP 用来管理依赖（dependency）关系的工具。可以在自己的项目中声明所依赖的外部工具库（libraries），Composer 会帮你安装这些依赖的库文件。

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

## 安装

* window配置：｀C:\Users\XXX\AppData\Roaming\Composer\config.json｀

```sh
# method 1
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

# method 2
php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');"
php composer-setup.php # 安装
php -r "unlink('composer-setup.php');" # 删除
sudo mv composer.phar /usr/local/bin/composer

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

# config
composer config -l # 查看
composer config -g repo.packagist composer https://packagist.phpcomposer.com ## 全局配置国内镜像
composer config repo.packagist composer https://packagist.phpcomposer.com # 项目配置国内镜像
```

## package

* 如果编辑了composer.json,增加或更新了细节信息，比如库的描述、作者、更多参数，甚至仅仅增加了一个空格，都会改变文件的md5sum。然后Composer就会警告哈希值和composer.lock中记载的不同:composer update nothing
* autoload:PHP autoloader 的自动加载映射
    * Files类型格式：支持将数组中的文件进行自动加载，文件的路径相对于项目的根目录.需要在任何请求中都加载某些文件，可以使用 files 自动加载机制
    * classmap类型格式：支持将数组中的路径下的文件进行自动加载。其很方便，但缺点是一旦增加了新文件，需要执行dump-autoload命令重新生成映射文件vendor/composer/autoload_classmap.php。
    * psr-0类型:支持将命名空间映射到路径。命名空间结尾的\\不可省略。当执行install或update时，加载信息会写入vendor/composer/autoload_namespace.php文件。如果希望解析指定路径下的所有命名空间，则将命名空间置为空串即可。需要注意的是对应name2\space\Foo类的类文件的路径为path2/name2/space/Foo.php
    * psr-4类型:支持将命名空间映射到路径。命名空间结尾的\\不可省略。当执行install或update时，加载信息会写入vendor/composer/autoload_psr4.php文件。如果希望解析指定路径下的所有命名空间，则将命名空间置为空串即可。需要注意的是对应name2\space\Foo类的类文件的路径为path2/space/Foo.php，name2不出现在路径中。
    * PSR-4和PSR-0
      - PSR-4指定的就当作当前命名空间的目录
      - PSR-0 指定的是当前命名空间的父目录
      * 最大的区别是对下划线（underscore)的定义不同。PSR-4中，在类名中使用下划线没有任何特殊含义。而PSR-0则规定类名中的下划线_会被转化成目录分隔符。
      * 按需加载
* name格式："name":"vendor/package"
* version格式："version":"1.0.2"
* repositories仓库地址:
  - 默认Composer 只使用 Packagist 仓库。通过指定仓库地址，可以从任何地方获取包
  - composer:仓库通过网络提供 packages.json 文件，它包含一个 composer.json 对象的列表，还有额外的 dist 或 source 信息。packages.json 文件通过 PHP 流加载
  - vcs:版本控制系统仓库，如：git、svn、hg
  - pear:可以导入任何 pear 仓库到你的项目中
* 加载自定义包
  - 建立存放第三方的目录
  - 修改composer.json中的autoload>classmap增加文件路径
  - `composer dump-autoload`  
* 加载没有制作 Composer，以 require 的方式进行加载

```
# 添加自定义包
"autoload":{
  "files":["src/MyLibrary/functions.php","path/to/2.php"],
  "classmap": ["path/to/src1","path/to/src2",...]
  "psr-0":
    {
      "Monolog\\": "src/",
      "Vendor\\Namespace\\": "src/",
      "Vendor_Namespace_": "src/",
      "Monolog\\": ["src/", "lib/"],
      # PHP 源文件放在项目的根目录
      "UniqueGlobalClass": "",
      # 有个目录下全是用命名空间组织的，你可以用空前缀
      "": "src/"
    },
  "psr-4":{
    "name1\\space\\":["path/",...],
    "name2\\space\\":["path2/",...],
  }
},

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


## 使用

* global 命令允许你在 COMPOSER_HOME 目录下执行命令
* 精确版本：示例： 1.0.2
* 使用比较操作符可以指定包的范围。这些操作符包括：>，>=，<，<=，!=
* 使用空格 或者逗号,表示逻辑上的与，使用双竖线||表示逻辑上的或。其中与的优先级会大于或
* 范围（使用连字符）: 1.0 - 2.0
* 可以使用通配符去定义版本: 1.0.*
* 下一个重要版本操作符：使用波浪号~ : `~1.2`
* 折音号^：例如，^1.2.3相当于>=1.2.3 <2.0.0
* 镜像：安装包的数据（主要是 zip 文件）一般是从 github.com 上下载的，安装包的元数据是从 packagist.org 上下载的。
* 考虑缓存，dist包优先:Composer会自动存档你下载的dist包(`~/.composer/cache/files/`)。默认设置下，dist包用于加了tag的版本，例如"symfony/symfony": "v2.1.4"，或者是通配符或版本区间，"2.1.\*"或">=2.2,<2.3-dev"
* Github允许你下载某个git引用的压缩包。为了强制使用压缩包，而不是克隆源代码，可以使用install和update的--prefer-dist选项。
* 考虑修改，源代码优先:--prefer-source

```sh
composer list  # 列出所有可用的命令
composer init  # 新建文件 composer.json
composer init --require=foo/bar:1.0.0 -n
composer init --require="twig/twig:1.*" -n --profile # 显示执行时间

composer search monolog
compsoer show monolog
composer clear-cache

composer global require "squizlabs/php_codesniffer=*"
composer global require friendsofphp/php-cs-fixer

composer install -vvv # 使用composer install或者composer update命令将会更新所有的扩展包
composer update|remove [packagename] -vvv # 更新的话，先删除composer.lock文件
composer self-update

composer create-project swoft/swoft swoft
composer create-project doctrine/orm path 2.2.0

export PATH="/usr/local/bin:/Users/username/.composer/vendor/bin":$PATH # 添加到全局文件

composer dump-autoload --optimize|-o # 优化自动加载,将 PSR-4/PSR-0 的规则转化为了 classmap 的规则
composer dump-autoload --classmap-authoritative|-a  # 同样也是生成了 classmap，区别在于当加载器在 classmap 中找不到目标类时，不会再去文件系统中查找
composer dump-autoload --apcu # 要安装 apcu 扩展。apcu 可以理解为一块内存，并且可以在多进程中共享,文件系统中找到的结果存储到共享内存

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

## [PSR(PHP Standards Recommendations)](http://www.php-fig.org/)

组织制定的PHP语言开发规范，约定了很多方面的规则，如命名空间、类名 规范、编码风格标准、Autoload、公共接口等

## question

```
＃　http://packagist.phpcomposer.com/  Authentication required

# centos: Do not run Composer as root/super user
composer install --no-plugins --no-scripts

# PHP Fatal error:  Allowed memory size of 2147483648 bytes exhausted (tried to allocate 4096 bytes) in phar:///usr/local/Cellar/composer/1.7.2/bin/composer/src/Composer/DependencyResolver/RuleSetGenerator.php on line 126
调整PHP memory_limit 大小
```

## 参考

* [官网](https://getcomposer.org/)
* [中文](https://www.phpcomposer.com/)
* [Packagist](https://packagist.org):The PHP Package Repository

## 工具

* [Ocramius/PackageVersions](https://github.com/Ocramius/PackageVersions):📦 Composer addon to efficiently get installed packages' version numbers
