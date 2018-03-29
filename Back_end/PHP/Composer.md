## Composer

工程化的思想引入，管理包.在安装依赖后，Composer 将把安装时确切的版本号列表写入 composer.lock 文件

### 安装

```sh
sudo apt-get install composer
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

brew install composer  // Mac
# file_put_contents(./composer.json): failed to open stream: Permission denied
sudo chown -R $USER .composer/
```

### 配置国内镜像

composer config -g repo.packagist composer `https://packagist.phpcomposer.com`

### 使用

global 命令允许你在 COMPOSER_HOME 目录下执行其它命令 sudo chown -R $USER $HOME/.composer

```php
composer init
composer search monolog
compsoer show monolog
composer require cocur/slugify
composer install
composer update
composer remove
composer self-update
composer create-project swoft/swoft swoft
```

```php
require **DIR** . '/vendor/autoload.php';
use Cocur\Slugify\Slugify;
$slugify = new Slugify();
echo $slugify->slugify('Hello World, this is a long sentence and I need to make a slug from it!');
```

### 卸载composer:找到文件删除即可

## 仓库

* [composer/composer](https://github.com/composer/composer):Dependency Manager for PHP https://getcomposer.org/
