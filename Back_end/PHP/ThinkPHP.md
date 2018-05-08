# thinkphp

* 核心（Core）：就是框架的核心代码，不可缺少的东西，TP本身是基于MVC思想开发的框架。
* 行为（Behavior） ：行为在新版ThinkPHP的架构里面起着举足轻重的作用，在系统核心之上，设置了很多标签扩展位，而每个标签位置可以依次执行各自的独立行为。行为扩展就因此而诞生了，而且很多系统功能也是通过内置的行为扩展完成的，所有行为扩展都是可替换和增加的，由此形成了底层框架可组装的基础。<br><b>
* 驱动（ Driver ）：数据库驱动、缓存驱动、标签库驱动和模板引擎驱动，以及外置的类扩展。

## 说明

* 3.1
    - 数据插入字段的过滤，通过表字段缓存
* 3.2
* 5.0

## 功能

* 支持命令行

```sh
php think

php public/index.php index/Demon/start # 命令行运行
```

## 创建项目

```sh
composer create-project topthink/think tp5
composer require topthink/think-swoole
```

## web配置

```
# 3.1
<IfModule mod_rewrite.c>
    RewriteEngine on
    RewriteCond %{REQUEST_FILENAME} !-d
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteRule ^(.*)$ index.php\/?s=$1 [QSA,PT,L]
</IfModule>
```

## 资源

* [ThinkPHP5.1完全开发手册](https://www.kancloud.cn/manual/thinkphp5_1)
* [top-think/think](https://github.com/top-think/think):PHP Framework ThinkPHP5——为API开发而设计的高性能PHP框架（基于PHP5.4+） http://www.thinkphp.cn
* [top-think/framework](https://github.com/top-think/framework):ThinkPHP5 Framework http://www.thinkphp.cn
* [top-think/thinkphp](https://github.com/top-think/thinkphp):ThinkPHP3.2 ——基于PHP5的简单快速的面向对象的PHP框架 http://www.thinkphp.cn
* [top-think/thinkng](https://github.com/top-think/thinkng):基于 ThinkPHP 5 框架核心重写的下一代 ThinkPHP 
