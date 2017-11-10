# Koa

koa是Express的下一代基于Node.js的web框架.新版Node.js开始支持ES6，Express的团队又基于ES6的generator重新编写了下一代web框架koa。和Express相比，koa 1.0使用generator实现异步，代码看起来像同步的

* 用generator实现异步比回调简单了不少，但是generator的本意并不是异步。
* Promise才是为异步设计的，但是Promise的写法……想想就复杂。
* ES7（目前是草案，还没有发布）引入了新的关键字async和await，可以轻松地把一个function变为异步模式
* koa团队非常超前地基于ES7开发了koa2，和koa 1相比，koa2完全使用Promise并配合async来实现异步
* 参数ctx是由koa传入的封装了request和response的变量，我们可以通过它访问request和response
* next是koa传入的将要处理的下一个异步函数。
* 首先用await next();处理下一个异步函数，然后，设置response的Content-Type和内容。
* 由async标记的函数称为异步函数，在异步函数中，可以用await调用另一个异步函数

```js
var koa = require('koa');
var app = koa();
app.use('/test', function *() {
    yield doReadFile1();
    var data = yield doReadFile2();
    this.body = data;
});
app.listen(3000);

app.use(async (ctx, next) => {
    await next();
    var data = await doReadFile();
    ctx.response.type = 'text/plain';
    ctx.response.body = data;
});
```

## 使用

```js
npm install koa
```
## 仓库

- [koajs/koa](https://github.com/koajs/koa):Expressive middleware for node.js using ES2017 async functions <http://koajs.com>

## 工具

- [chentsulin/koa-graphql](https://github.com/chentsulin/koa-graphql):Create a GraphQL HTTP server with Koa.

## 教程

- [17koa/koa-generator-examples](https://github.com/17koa/koa-generator-examples):
- [koajs/workshop](https://github.com/koajs/workshop):Koa Training Workshop
- [koajs/examples](https://github.com/koajs/examples):Example Koa apps
