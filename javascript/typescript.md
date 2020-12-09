# [TypeScript](https://github.com/Microsoft/TypeScript)

TypeScript is a superset of JavaScript that compiles to clean JavaScript output. <http://www.typescriptlang.org>

## 安装

* 编译器 tsc，编译生成 js 文件 `tsc filename.ts`

```sh
npm install -g typescript

tsc hello.ts
tsc --build tsconfig.json
```

## 配置

```js
// tsconfig.json
```

## 原理

* 只会在编译时对类型进行静态检查，如果发现有错误，编译的时候就会报错

## 使用

* 类型批注：提供静态类型以在编译时启动类型检查。可选的，而且可以被忽略而使用 JavaScript 常规的动态类型
  - 基本类型的批注是number, bool和string。而弱或动态类型的结构则是any类型
  - 可以被导出到一个单独的声明文件以让使用类型的已被编译为JavaScript的TypeScript脚本的类型信息可用。批注可以为一个现有的JavaScript库声明，就像已经为Node.js和jQuery所做的那样
* 接口：对象作为数据集合
* 箭头函数表达式（lambda表达式）：()=>{something}或()=>something 相当于js中的函数,它的好处是可以自动将函数中的this附加到上下文中
* 类：支持集成了可选的类型批注支持的ECMAScript 6的类。public 和 private 访问修饰符。Public 成员可以在任何地方访问， private 成员只允许在类中访问.默认为private
* 继承：可以继承一个已存在的类并创建一个派生类，继承使用关键字 extends
  - 继承了父类（super）的属性
  - 可复用构造函数
  - 在重写父类的方法实现
  - 复用方法需要声明

## 原始数据类型

* Boolean
* Number
* String
* Array
* Tuple 类似于数组，但是成员数量是已知的
* Enum 一个常量集合。创建一个Enum，就创建了一个数据的新类型
* Any 表示接受任何值
* Void 只能接受undefined和null作为值，主要用来标记不返回任何值的函数返回值的类型
* Function

## 任意值

## 类型推论

## 联合类型

## 对象的类型——接口

## 数组的类型

## 函数的类型

## 类型断言

## 声明文件

## 内置对象

## class

* 当通过this为实例分配属性时，必须添加属性定义
* 实例属性还可以用public或private修饰
* 继承与ES6的继承是一致的
* Interface用来定义和描述Class
  - 属性名后面如果有问号，就表示可以不部署

## 教程

* [typescript-tutorial](https://github.com/xcatliu/typescript-tutorial) TypeScript 入门教程 <https://ts.xcatliu.com/>
* [TypeScript-Node-Starter](https://github.com/Microsoft/TypeScript-Node-Starter):A starter template for TypeScript and Node with a detailed README describing how to use the two together.
* [typescript-library-starter](https://github.com/alexjoverm/typescript-library-starter):Starter kit with zero-config for building a library in TypeScript, featuring RollupJS, Jest, Prettier, TSLint, Semantic Release, and more!

## 图书

* [TypeScript Deep Dive 深入理解 TypeScript](https://basarat.gitbook.io/typescript/getting-started)
  - [typescript-book-chinese](https://github.com/jkchao/typescript-book-chinese):TypeScript Deep Dive 中文版 <https://jkchao.github.io/typescript-book-chinese/>

## 工具

* [typeorm](https://github.com/typeorm/typeorm):ORM for TypeScript and JavaScript (ES7, ES6, ES5). Supports MySQL, PostgreSQL, MariaDB, SQLite, MS SQL Server, Oracle, WebSQL databases. Works in NodeJS, Browser, Ionic, Cordova and Electron platforms. <http://typeorm.io>
* [prisma/prisma](https://github.com/prisma/prisma):Modern DB toolkit to query, migrate and model your database <https://www.prisma.io/>
* [quicktype](https://github.com/quicktype/quicktype):Generate types and converters from JSON, Schema, and GraphQL <https://quicktype.io>
* [ts-loader](https://github.com/TypeStrong/ts-loader):TypeScript loader for webpack
* [tslint](https://github.com/palantir/tslint):🚦 An extensible linter for the TypeScript language <http://palantir.github.io/tslint/>
* [assemblyscript](https://github.com/AssemblyScript/assemblyscript):A TypeScript to WebAssembly compiler 🚀 <https://assemblyscript.org>
* [routing-controllers](https://github.com/typestack/routing-controllers):Create structured, declarative and beautifully organized class-based controllers with heavy decorators usage in Express / Koa using TypeScript and Routing Controllers Framework.
* [async-ray](https://github.com/rpgeeganage/async-ray):Provide async/await callbacks for every, find, findIndex, filter, forEach, map, reduce, reduceRight and some methods in Array. <https://rpgeeganage.github.io/async-ray>
* [typedoc](https://github.com/TypeStrong/typedoc):Documentation generator for TypeScript projects. <https://typedoc.org>
* [typescript-eslint](https://github.com/typescript-eslint/typescript-eslint) ✨ Monorepo for all the tooling which enables ESLint to support TypeScript
* [tsdx](https://github.com/palmerhq/tsdx):Zero-config CLI for TypeScript package development <https://npm.im/tsdx>
* [ts-jest](https://github.com/kulshekhar/ts-jest):TypeScript preprocessor with sourcemap support for Jest <https://kulshekhar.github.io/ts-jest>

## 参考

* [TypeScript 中文手册](https://typescript.bootcss.com/)
* [The TypeScript Handbook](https://www.staging-typescript.org/docs/handbook/intro.html)
* [typescript-book](https://github.com/basarat/typescript-book):📚 The definitive guide to TypeScript and possibly the best TypeScript book 📖. Free and Open Source 🌹
* [DefinitelyTyped](https://github.com/DefinitelyTyped/DefinitelyTyped):The repository for high quality TypeScript type definitions. <http://definitelytyped.org/>
* [fp-ts](https://github.com/gcanti/fp-ts):Functional programming in TypeScript <https://gcanti.github.io/fp-ts/>
* [why is so important?](https://www.warambil.com/typescript-why-is-so-important)
