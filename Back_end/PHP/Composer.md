# Composer

 PHP 用来管理依赖（dependency）关系的工具。你可以在自己的项目中声明所依赖的外部工具库（libraries），Composer 会帮你安装这些依赖的库文件。

## 安装

```sh
sudo apt-get install composer

curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

brew install composer  # Mac
# file_put_contents(./composer.json): failed to open stream: Permission denied
sudo chown -R $USER .composer/

### 卸载composer:找到文件删除即可
```

## 使用

global 命令允许你在 COMPOSER_HOME 目录下执行命令

```sh
## 全局配置国内镜像
composer config -g repo.packagist composer https://packagist.phpcomposer.com
composer config repo.packagist composer https://packagist.phpcomposer.com

composer list  # 列出所有可用的命令
composer init

composer search monolog
compsoer show monolog

composer require cocur/slugify
composer install # 使用composer install或者composer update命令将会更新所有的扩展包
composer update
composer remove
composer self-update
sss
composer create-project swoft/swoft swoft

composer dump-autoload --optimize # 优化一下自动加载
```

```php
require **DIR** . '/vendor/autoload.php';
use Cocur\Slugify\Slugify;
$slugify = new Slugify();
echo $slugify->slugify('Hello World, this is a long sentence and I need to make a slug from it!');
```

## 加载没有制作 Composer，而是还以 require 的方式进行加载

* 建立存放第三方的 SDK 目录
* 修改composer.json中的autoload>classmap增加文件路径
* `composer dump-autoload`

## 参考

* [官网](https://getcomposer.org/)
* [composer/composer](https://github.com/composer/composer):Dependency Manager for PHP https://getcomposer.org/
* [中文](https://www.phpcomposer.com/)
