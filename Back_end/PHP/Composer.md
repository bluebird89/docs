# [composer/composer](https://github.com/composer/composer)

Dependency Manager for PHP https://getcomposer.org/

PHP 用来管理依赖（dependency）关系的工具。你可以在自己的项目中声明所依赖的外部工具库（libraries），Composer 会帮你安装这些依赖的库文件。

## 安装

```sh
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer

brew install composer  # Mac
# file_put_contents(./composer.json): failed to open stream: Permission denied
sudo chown -R $USER .composer/

### 卸载composer:找到文件删除即可
```

## 配置

* C:\Users\XXX\AppData\Roaming\Composer\config.json

## 使用

global 命令允许你在 COMPOSER_HOME 目录下执行命令

* 精确版本：示例： 1.0.2
* 使用比较操作符你可以指定包的范围。这些操作符包括：>，>=，<，<=，!=
* 使用空格 或者逗号,表示逻辑上的与，使用双竖线||表示逻辑上的或。其中与的优先级会大于或
* 范围（使用连字符）: 1.0 - 2.0
* 可以使用通配符去定义版本: 1.0.*
* 下一个重要版本操作符：使用波浪号~ : ~1.2
* 折音号^：例如，^1.2.3相当于>=1.2.3 <2.0.0

考虑缓存，dist包优先:Composer会自动存档你下载的dist包(~/.composer/cache/files/)。默认设置下，dist包用于加了tag的版本，例如"symfony/symfony": "v2.1.4"，或者是通配符或版本区间，"2.1.*"或">=2.2,<2.3-dev"
Github允许你下载某个git引用的压缩包。为了强制使用压缩包，而不是克隆源代码，你可以使用install和update的--prefer-dist选项。
考虑修改，源代码优先:--prefer-source

```sh
composer config -g repo.packagist composer https://packagist.phpcomposer.com ## 全局配置国内镜像
composer config repo.packagist composer https://packagist.phpcomposer.com # peroject

composer config -l

composer list  # 列出所有可用的命令
composer init  # 新建文件 composer.json
composer init --require=foo/bar:1.0.0 -n
composer init --require="twig/twig:1.*" -n --profile # 显示执行时间

composer search monolog
compsoer show monolog

composer global require "squizlabs/php_codesniffer=*"
composer global require friendsofphp/php-cs-fixer

composer install # 使用composer install或者composer update命令将会更新所有的扩展包
composer update [packagename]
composer remove [packagename]
composer self-update

composer create-project swoft/swoft swoft
composer create-project doctrine/orm path 2.2.0

export PATH="/usr/local/bin:/Users/username/.composer/vendor/bin":$PATH # 添加到全局文件

composer dump-autoload --optimize # 优化自动加载

>=1.0
>=1.0 <2.0
>=1.0 <1.1 || >=1.2

require 'vendor/autoload.php'; # 自动加载
```

```php
require **DIR** . '/vendor/autoload.php';

use Cocur\Slugify\Slugify;
$slugify = new Slugify();
echo $slugify->slugify('Hello World, this is a long sentence and I need to make a slug from it!');
```

## package

* 如果你编辑了composer.json,如果你增加或更新了细节信息，比如库的描述、作者、更多参数，甚至仅仅增加了一个空格，都会改变文件的md5sum。然后Composer就会警告你哈希值和composer.lock中记载的不同:composer update nothing
* require:"require":{"vendor-name/package-name":"version", ...} 名字部分会作为vendor下的路径进行创建
* autoload:composer支持PSR-0,PSR-4,classmap及files包含以支持文件自动加载。PSR-4为推荐方式。
    * Files类型格式：支持将数组中的文件进行自动加载，文件的路径相对于项目的根目录
    * classmap类型格式：支持将数组中的路径下的文件进行自动加载。其很方便，但缺点是一旦增加了新文件，需要执行dump-autoload命令重新生成映射文件vendor/composer/autoload_classmap.php。
    * psr-0类型:支持将命名空间映射到路径。命名空间结尾的\\不可省略。当执行install或update时，加载信息会写入vendor/composer/autoload_namespace.php文件。如果希望解析指定路径下的所有命名空间，则将命名空间置为空串即可。需要注意的是对应name2\space\Foo类的类文件的路径为path2/name2/space/Foo.php
    * psr-4类型:支持将命名空间映射到路径。命名空间结尾的\\不可省略。当执行install或update时，加载信息会写入vendor/composer/autoload_psr4.php文件。如果希望解析指定路径下的所有命名空间，则将命名空间置为空串即可。需要注意的是对应name2\space\Foo类的类文件的路径为path2/space/Foo.php，name2不出现在路径中。
    * PSR-4和PSR-0最大的区别是对下划线（underscore)的定义不同。PSR-4中，在类名中使用下划线没有任何特殊含义。而PSR-0则规定类名中的下划线_会被转化成目录分隔符。
* name格式："name":"vendor/package"
* version格式："version":"1.0.2"

```
# file
"autoload":{"files":["path/to/1.php","path/to/2.php",...]}

# classmap
"autoload":{"classmap": ["path/to/src1","path/to/src2",...]}

# psr-0
"autoload":{"psr-0":{
                            "name1\\space\\":["path/",...],
                            "name2\\space\\":["path2/",...],
                          }
     }

# psr-4
"autoload":{"psr-4":{
                            "name1\\space\\":["path/",...],
                            "name2\\space\\":["path2/",...],
                          }
                 }
```

## Principle

## 加载没有制作 Composer，而是还以 require 的方式进行加载

* 建立存放第三方的 SDK 目录
* 修改composer.json中的autoload>classmap增加文件路径
* `composer dump-autoload`

## 参考

* [官网](https://getcomposer.org/)
* [中文](https://www.phpcomposer.com/)
* [Packagist](https://packagist.org):The PHP Package Repository

https://www.robberphex.com/2018/05/858
