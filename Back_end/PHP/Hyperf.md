# [Hyperf](https://github.com/hyperf-cloud/hyperf)

🚀 A coroutine framework that focuses on hyperspeed and flexibility, specifically used for build microservices or middlewares. https://www.hyperf.io
The Way to PHP Microservice Hyperf = Hyperspeed + Flexibility

```sh
composer create-project hyperf/hyperf-skeleton

composer require illuminate/hashing gregwar/captcha \ hyperf/validation hyperf/translation hyperf/constants phper666/jwt-auth  hyperf/config-aliyun-acm hyperf/json-rpc hyperf/rpc-server

php bin/hyperf.php jwt:publish --config
php bin/hyperf.php vendor:publish hyperf/translation
php bin/hyperf.php vendor:publish hyperf/validation
```

## 中间件

* 全局中间件 -> 方法级别中间件 -> 类级别中间件

## 参考

* [文档](https://doc.hyperf.io)
* [《PHP微服务练兵》系列](https://blog.csdn.net/donjan/article/details/103005084)
