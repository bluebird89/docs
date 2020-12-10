# [think](https://github.com/top-think/think)

PHP Framework ThinkPHP5——为API开发而设计的高性能PHP框架（基于PHP5.4+） <http://www.thinkphp.cn>

## 说明

* 3.1
  - 数据插入字段的过滤，通过表字段缓存
  - 核心（Core）：就是框架的核心代码，不可缺少的东西，TP本身是基于MVC思想开发的框架。
  - 行为（Behavior）：行为在新版ThinkPHP的架构里面起着举足轻重的作用，在系统核心之上，设置了很多标签扩展位，而每个标签位置可以依次执行各自的独立行为。行为扩展就因此而诞生了，而且很多系统功能也是通过内置的行为扩展完成的，所有行为扩展都是可替换和增加的，由此形成了底层框架可组装的基础。
  - 驱动（ Driver ）：数据库驱动、缓存驱动、标签库驱动和模板引擎驱动，以及外置的类扩展。
* 5.1.37
* 6

## 创建项目

```sh
composer create-project topthink/think tp

composer require topthink/think-swoole
php think run
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

php -S localhost:8888 route/route.php

location / {
   if (!-e $request_filename) {
        rewrite  ^(.*)$  /index.php?s=/$1  last;
    }
}
```

## 源代码

* `$bind`:一组 类的标识 到 类 的映射：门面模式

## 命令行

```sh
php think

php public/index.php index/Demon/start # 命令行运行
```

## 项目

* [thinkcmf](https://github.com/thinkcmf/thinkcmf):ThinkCMF5 is a content manage framework ,based on ThinkPHP5
* [thinkphp-bjyadmin](https://github.com/baijunyao/thinkphp-bjyadmin):thinkphp整合Auth权限管理、支付宝、微信支付、阿里oss、友盟推送、融云即时通讯、云通讯短信、Email、Excel、PDF等等；基于thinkphp扩展了大量的功能；而不改动thinkphp核心；非常方便的升级、移植和使用； <http://baijunyao.comw>

## 扩展

* [framework](https://github.com/top-think/framework):ThinkPHP Framework  <http://www.thinkphp.cn>
* [think-swoole](https://github.com/top-think/think-swoole):Swoole extend for thinkphp5
* admin
  * [ucer-admin](https://github.com/Ucer/ucer-admin):ucer admin system based Thinkphp5.0.10 <http://codehaoshi.com>
  * [tpAdmin](https://github.com/yuan1994/tpAdmin):一个基于ThinkPHP5的管理后台，支持代码自动生成，RBAC权限管理，无限级节点权限管理，一个智能化的管理后台
  * [tp-admin](https://github.com/Astonep/tp-admin):基于ThinkPHP5拿来即用高性能后台管理系统 <http://tpadmin.shijinrong.cn/admin/login>
  * [layuimini](https://github.com/zhongshaofa/layuimini):后台admin前端模板，基于 layui 编写的最简洁、易用的后台框架模板。只需提供一个接口就直接初始化整个框架，无需复杂操作。 <http://layuimini.99php.cn>
  * [lyadmin](https://github.com/ijry/lyadmin):lyadmin是一套轻量级通用后台，采用ThinkPHP+Bootstrap3制作，内置系统设置、上传管理、权限管理、模块管理、插件管理等功能，独有的Builder页面自动生成技术节省50%开发成本，先进的模块化开发的支持让开发成本一降再降，致力于为个人和中小型企业打造全方位的PHP企业级开发解决方案。另外提供整套企业开发解决方案，集PC、手机、微信、App、小程序五端于一体，更有用户中心模块、门户模块、钱包支付中心模块、商城模块、OAuth2统一登陆、内部Git模块、Docker模块可供选择。 <https://www.lingyun.net/lyadmin.html>
* [think-seaslog](https://github.com/top-think/think-seaslog)
* [think-annotation](https://github.com/top-think/think-annotation):ThinkPHP6注解

## 参考

* [ThinkPHP5.1完全开发手册](https://www.kancloud.cn/manual/thinkphp6.0)
