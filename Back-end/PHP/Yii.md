# Yii

## 仓库

- [yiisoft/yii2](https://github.com/yiisoft/yii2):Yii 2: The Fast, Secure and Professional PHP Framework <http://www.yiiframework.com>

## yii-advanced 初始化

```
composer global require "fxp/composer-asset-plugin:^1.2.0"
composer install
php init
php requirements.php
```

1. common/config/main-local.php 中的 components['db'] 配置
2. yii migrate:生成数据表
3. 断言测试
