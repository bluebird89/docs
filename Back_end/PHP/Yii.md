# Yii

## 参考

* [yiisoft/yii2](https://github.com/yiisoft/yii2):Yii 2: The Fast, Secure and Professional PHP Framework <http://www.yiiframework.com>
* [yiisoft/yii2-app-advanced](https://github.com/yiisoft/yii2-app-advanced):Yii 2.0 Advanced Application Template http://www.yiiframework.com
*  

## yii-advanced

```php
composer global require "fxp/composer-asset-plugin:^1.2.0"
composer create-project --prefer-dist yiisoft/yii2-app-advanced yii-application
composer install
php init
php requirements.php
```

1. common/config/main-local.php 中的 components['db'] 配置
2. yii migrate:生成数据表
3. 断言测试
