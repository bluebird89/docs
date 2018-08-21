# [Microsoft/TypeScript](https://github.com/Microsoft/TypeScript)

TypeScript is a superset of JavaScript that compiles to clean JavaScript output. http://www.typescriptlang.org
TypeScript 是一种由微软开发的自由和开源的编程语言，它是JavaScript的一个超集，扩展了JavaScript的语法。现有的 JavaScript 代码可与 TypeScript 一起工作无需任何修改，TypeScript 通过类型注解提供编译时的静态类型检查。

## 安装

```sh
npm install -g typescript
```

## 使用

使用 TypeScript 编译器，名称叫 tsc，可将编译结果生成 js 文件 tsc filename.ts

- 类型批注：提供静态类型以在编译时启动类型检查。这是可选的，而且可以被忽略而使用 JavaScript 常规的动态类型。
  - 基本类型的批注是number, bool和string。而弱或动态类型的结构则是any类型
  - 可以被导出到一个单独的声明文件以让使用类型的已被编译为JavaScript的TypeScript脚本的类型信息可用。批注可以为一个现有的JavaScript库声明，就像已经为Node.js和jQuery所做的那样
- 接口：对象作为数据集合
- 箭头函数表达式（lambda表达式）：()=>{something}或()=>something 相当于js中的函数,它的好处是可以自动将函数中的this附加到上下文中。
- 类：支持集成了可选的类型批注支持的ECMAScript 6的类。public 和 private 访问修饰符。Public 成员可以在任何地方访问， private 成员只允许在类中访问.默认为private
- 继承：可以继承一个已存在的类并创建一个派生类，继承使用关键字 extends
  - 继承了父类（super）的属性
  - 可复用构造函数
  - 在重写父类的方法实现
  - 复用方法需要声明

  ```
  superShout() {
    return super.shoutout();
  }
  ```


## 工具

* [ry/deno](https://github.com/ry/deno):A secure TypeScript runtime on V8
* [DefinitelyTyped/DefinitelyTyped](https://github.com/DefinitelyTyped/DefinitelyTyped):The repository for high quality TypeScript type definitions. http://definitelytyped.org/
* [typeorm/typeorm](https://github.com/typeorm/typeorm):ORM for TypeScript and JavaScript (ES7, ES6, ES5). Supports MySQL, PostgreSQL, MariaDB, SQLite, MS SQL Server, Oracle, WebSQL databases. Works in NodeJS, Browser, Ionic, Cordova and Electron platforms. http://typeorm.io
* [quicktype/quicktype](https://github.com/quicktype/quicktype):Generate types and converters from JSON, Schema, and GraphQL https://quicktype.io

## 参考

* [](https://tutorialzine.com/2016/07/learn-typescript-in-30-minutes)
* [xcatliu/typescript-tutorial](https://github.com/xcatliu/typescript-tutorial):TypeScript 入门教程 https://ts.xcatliu.com/
* [DefinitelyTyped/DefinitelyTyped](https://github.com/DefinitelyTyped/DefinitelyTyped):The repository for high quality TypeScript type definitions. http://definitelytyped.org/

## 教程

* [Microsoft/TypeScript-Node-Starter](https://github.com/Microsoft/TypeScript-Node-Starter):A starter template for TypeScript and Node with a detailed README describing how to use the two together.
