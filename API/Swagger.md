# [swagger-ui](https://github.com/swagger-api/swagger-ui)

Swagger UI is a collection of HTML, Javascript, and CSS assets that dynamically generate beautiful documentation from a Swagger-compliant API. <http://swagger.io>

* 以将扫描工具生成的 swagger.json 文件内容展示在网页上
* Swagger是一种通用的、和编程语言无关的API的描述规范。只要开发者在自己的API之上添加符合Swagger规范的描述，就能利用上Swagger丰富的生态，找到符合自己开发语言的工具去做很多事：比如最常用的生成API文档，或者生成返回假数据的服务端基础代码等等。

* scheme
* 授权
* 请求 curl

## PHP

* 将 swagger-ui 项目中的 dist 文件夹拷贝到public根目录下
* 在php文件中写 swagger 格式的 /** 注释 */
* 用 swagger-php 内的 bin/swagger.phar 命令扫描 php controller 所在目录, 生成 swagger.json 文件
* 将 swagger.json 文件拷贝到 swagger-ui 中 index.html 指定的目录中
* index.html中修改url
* 打开 swagger-ui 所在的 url, 就可以看到文档了. 文档中的各个 api 可以在该网址上直接访问得到数据.

```sh
composer require zircote/swagger-php
artisan make:controller SwaggerController

php vendor/bin/swagger app/Http/Controllers -o public/swagger-ui
```

```php
<?php

/**
 * @SWG\Swagger(
 *   schemes={"http"},
 *   host="api.my_project.com",
 *   consumes={"multipart/form-data"},
 *   produces={"application/json"},
 *   @SWG\Info(
 *     version="2.3",
 *     title="my project doc",
 *     description="my project 接口文档, V2-3.<br>
以后大家就在这里愉快的对接口把!<br>
以后大家就在这里愉快的对接口把!<br>
以后大家就在这里愉快的对接口把!<br>
"
 *   ),
 *
 *   @SWG\Tag(
 *     name="User",
 *     description="用户操作",
 *   ),
 *
 *   @SWG\Tag(
 *     name="MainPage",
 *     description="首页模块",
 *   ),
 *
 *   @SWG\Tag(
 *     name="News",
 *     description="新闻资讯",
 *   ),
 *
 *   @SWG\Tag(
 *     name="Misc",
 *     description="其他接口",
 *   ),
 * )
 */

/**
* @SWG\Post(path="/user/login", tags={"User"},
*   summary="登录接口(用户名+密码)",
*   description="用户登录接口,账号可为 用户名 或 手机号. 参考(这个会在页面产生一个可跳转的链接: [用户登录注意事项](http://blog.csdn.net/liuxu0703/)",
*   @SWG\Parameter(name="userName", type="string", required=true, in="formData",
*     description="登录用户名/手机号"
*   ),
*   @SWG\Parameter(name="password", type="string", required=true, in="formData",
*     description="登录密码"
*   ),
*   @SWG\Parameter(name="image_list", type="string", required=true, in="formData",
*     @SWG\Schema(type="array", @SWG\Items(ref="#/definitions/Image")),
*     description="用户相册. 好吧,没人会在登录时要求填一堆图片信息.这里是为了示例 带结构的数据, @SWG\Schema ,这个结构需要另行定义,下面会讲."
*   ),
*   @SWG\Parameter(name="video", type="string", required=true, in="formData",
*     @SWG\Schema(ref="#/definitions/Video"),
*     description="用户 呃... 视频? 同上,为了示例 @SWG\Schema ."
*   ),
*   @SWG\Parameter(name="client_type", type="integer", required=false, in="formData",
*     description="调用此接口的客户端类型: 1-Android, 2-IOS. 非必填,所以 required 写了 false"
*   ),
*   @SWG\Parameter(name="gender", type="integer", required=false, in="formData",
*     default="1",
*     description="性别: 1-男; 2-女. 注意这个参数的default上写的不是参数默认值,而是默认会被填写在swagger页面上的值,为的是方便用swagger就地访问该接口."
*   ),
* )
*/
public function loginAction() {
// php code
}

/**
* @SWG\Get(path="/User/myWebPage", tags={"User"},
*   produces={"text/html"},
*   summary="用户的个人网页",
*   description="这不是个api接口,这个返回一个页面,所以 produces 写了 text/html",
*   @SWG\Parameter(name="userId", type="integer", required=true, in="query"),
*   @SWG\Parameter(name="userToken", type="string", required=true, in="query",
*     description="用户令牌",
*   ),
* )
*/
public function myWebPageAction(){
// php code
}
```

## 参考

* [Swagger从入门到精通](https://www.gitbook.com/book/huangwenchao/swagger/details)
* [swagger-api/swagger-codegen](https://github.com/swagger-api/swagger-codegen):swagger-codegen contains a template-driven engine to generate documentation, API clients and server stubs in different languages by parsing your OpenAPI / Swagger definition. <http://swagger.io>
* [Swagger2Markup/swagger2markup](https://github.com/Swagger2Markup/swagger2markup):A Swagger to AsciiDoc or Markdown converter to simplify the generation of an up-to-date RESTful API documentation by combining documentation that’s been hand-written with auto-generated API documentation.
