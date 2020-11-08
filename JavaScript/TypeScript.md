# [TypeScript](https://github.com/Microsoft/TypeScript)

TypeScript is a superset of JavaScript that compiles to clean JavaScript output. http://www.typescriptlang.org

## 安装

```sh
npm install -g typescript
```

## 使用

使用 TypeScript 编译器，名称叫 tsc，可将编译结果生成 js 文件 `tsc filename.ts`

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

```typescript
superShout() {
  return super.shoutout();
}
```

## 数据类型

* Boolean
* Number
* String
* Array
* Tuple 类似于数组，但是成员数量是已知的
* Enum 一个常量集合。创建一个Enum，就创建了一个数据的新类型
* Any 表示接受任何值
* Void 只能接受undefined和null作为值，主要用来标记不返回任何值的函数返回值的类型
* Function

## class

* 当通过this为实例分配属性时，必须添加属性定义
* 实例属性还可以用public或private修饰
* 继承与ES6的继承是一致的
* Interface用来定义和描述Class
  - 属性名后面如果有问号，就表示可以不部署

## 教程

* [Microsoft/TypeScript-Node-Starter](https://github.com/Microsoft/TypeScript-Node-Starter):A starter template for TypeScript and Node with a detailed README describing how to use the two together.
* [xcatliu/typescript-tutorial](https://github.com/xcatliu/typescript-tutorial):TypeScript 入门教程 https://ts.xcatliu.com/
* [alexjoverm/typescript-library-starter](https://github.com/alexjoverm/typescript-library-starter):Starter kit with zero-config for building a library in TypeScript, featuring RollupJS, Jest, Prettier, TSLint, Semantic Release, and more!
* [Microsoft/TypeScript-React-Native-Starter](https://github.com/Microsoft/TypeScript-React-Native-Starter):A starter template for TypeScript and React Native with a detailed README describing how to use the two together.
* [](https://tutorialzine.com/2016/07/learn-typescript-in-30-minutes)
* [typescript-tutorial](https://github.com/xcatliu/typescript-tutorial) [TypeScript 入门教程](https://ts.xcatliu.com/)

## 工具

* orm
    - [typeorm/typeorm](https://github.com/typeorm/typeorm):ORM for TypeScript and JavaScript (ES7, ES6, ES5). Supports MySQL, PostgreSQL, MariaDB, SQLite, MS SQL Server, Oracle, WebSQL databases. Works in NodeJS, Browser, Ionic, Cordova and Electron platforms. http://typeorm.io
    - [prisma/prisma](https://github.com/prisma/prisma):Modern DB toolkit to query, migrate and model your database https://www.prisma.io/
* [quicktype/quicktype](https://github.com/quicktype/quicktype):Generate types and converters from JSON, Schema, and GraphQL https://quicktype.io
* [TypeStrong/ts-loader](https://github.com/TypeStrong/ts-loader):TypeScript loader for webpack
* [palantir/tslint](https://github.com/palantir/tslint):🚦 An extensible linter for the TypeScript language http://palantir.github.io/tslint/
* [AssemblyScript/assemblyscript](https://github.com/AssemblyScript/assemblyscript):A TypeScript to WebAssembly compiler 🚀 https://assemblyscript.org
* [typestack/routing-controllers](https://github.com/typestack/routing-controllers):Create structured, declarative and beautifully organized class-based controllers with heavy decorators usage in Express / Koa using TypeScript and Routing Controllers Framework.
* [rpgeeganage/async-ray](https://github.com/rpgeeganage/async-ray):Provide async/await callbacks for every, find, findIndex, filter, forEach, map, reduce, reduceRight and some methods in Array. https://rpgeeganage.github.io/async-ray
* [TypeStrong/typedoc](https://github.com/TypeStrong/typedoc):Documentation generator for TypeScript projects. https://typedoc.org
* [palmerhq/tsdx](https://github.com/palmerhq/tsdx):Zero-config CLI for TypeScript package development https://npm.im/tsdx
* 测试
    - [kulshekhar/ts-jest](https://github.com/kulshekhar/ts-jest):TypeScript preprocessor with sourcemap support for Jest https://kulshekhar.github.io/ts-jest

## 参考

* [TypeScript 中文手册](https://typescript.bootcss.com/)
* [The TypeScript Handbook](https://www.staging-typescript.org/docs/handbook/intro.html)
* [TypeScript Deep Dive](https://basarat.gitbook.io/typescript/getting-started)
* [basarat/typescript-book](https://github.com/basarat/typescript-book):📚 The definitive guide to TypeScript and possibly the best TypeScript book 📖. Free and Open Source 🌹
* [DefinitelyTyped/DefinitelyTyped](https://github.com/DefinitelyTyped/DefinitelyTyped):The repository for high quality TypeScript type definitions. http://definitelytyped.org/
* [gcanti/fp-ts](https://github.com/gcanti/fp-ts):Functional programming in TypeScript https://gcanti.github.io/fp-ts/
* [jkchao/typescript-book-chinese](https://github.com/jkchao/typescript-book-chinese):TypeScript Deep Dive 中文版
* [why is so important?](https://www.warambil.com/typescript-why-is-so-important)
