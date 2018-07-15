# [sebastianbergmann/phpunit](https://github.com/sebastianbergmann/phpunit)

The PHP Unit Testing framework. https://phpunit.de/

## 安装

```sh
wget https://phar.phpunit.de/phpunit.phar
chmod +x phpunit.phar
sudo mv phpunit.phar /usr/local/bin/phpunit
phpunit --version
```

## 配置使用

在PhpStrom环境下使用

* 创建代码文件
* 右键goto->test创建测试文件（指定目录）
* 测试文件引入源文件
* 配置文件
    - 设置：phpunit->user composer autoloader->vender/autoloader.php
    - 测试文件路径：run->edit configuration->directory
* run

## 参考

* [PHPUnit文档](http://www.phpunit.cn)

