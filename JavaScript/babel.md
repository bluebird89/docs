## [babel](https://github.com/babel/babel)

🐠 Babel is a compiler for writing next generation JavaScript.  https://babel.dev/

* 一个工具链，主要用于在旧浏览器或环境中,将 ECMAScript 2015+ 代码转换为向后兼容版本的 JavaScript 代码
* 功能
    - 转换语法
    - Polyfill 实现目标环境中缺少的功能 (通过 @babel/polyfill)
    - 源代码转换 (codemods)
* 步骤
  - 解析（parse）:解析代码并输出抽象语法树（AST）含词法分析和语法分析
  - 转换（transform）:转换接收AST并对其进行遍历，对节点进行添加、更新及移除等操作，这是最复杂的过程，同时也是插件将要介入工作的部分
  - 生成（generate）:把AST转换成字符串形式的代码
* 版本
  - 7.0
    + 引入了 babel.config.js

## [配置](https://babeljs.io/setup#installation)

* 配置文件是.babelrc，存放在项目的根目录下
* presets字段设定转码规则，官方提供以下规则集，可以根据需要安装
  - babel-preset-es2015:把 ES2015（最新版本的 JavaScript 标准，也叫做 ES6）编译成 ES5
  - babel-preset-react
  - babel-preset-stage-0|1|2|3
* plugins
* 基于环境自定义
  - 当前环境可以使用 process.env.BABEL_ENV 来获得。 如果 BABEL_ENV 不可用，将会替换成 NODE_ENV，并且如果后者也没有设置，那么缺省值是"development"
* targets 中配置需要兼容的环境，关于浏览器配置对应的浏览器列表，可以从 browserl.ist 上查看。
* modules 表示编出输出的模块类型，支持"amd","umd","systemjs","commonjs",false 这些选项，false 表示不输出任何模块类型。
* loose 代表松散模式，将 loose 设置为 true，能够更好地兼容 ie8 以下环境

```sh
npm install --save-dev @babel/core @babel/cli @babel/babel-preset-env
npm install --save @babel/polyfill

# .babelrc
{
  "presets": [
    "@babel/preset-env"
  ]
}

babel --presets @babel/preset-typescript script.ts
```

## 组件

* babel-core is the main babel package — We need this for babel to do any transformations on our code.
  - 字符串形式的 JavaScript 代码可以直接使用 babel.transform 来编译
  - 文件使用异步 api transformFile 或者 同步 api transformFileSync
  - 有一个 Babel AST（抽象语法树）了就可以直接从 AST 进行转换 transformFromAst
* babel-cli allows you to compile files from the command line.
  - 参数
    + --out-file|-o 指定输出文件
    + --out-dir|-d 指定输出目录
    + -s  生成source map文件
  - 自带一个babel-node命令，提供一个支持ES6的REPL环境。它支持Node的REPL环境的所有功能，而且可以直接运行ES6代码
* preset-react and preset-env are both presets that transform specific flavors of code — in this case,
    - the env preset allows us to transform ES6+ into more traditional javascript
    - the react preset does the same, but with JSX instead

```sh
babel-node es6.js
```

## babel-register

* 改写require命令，为它加上一个钩子。此后，每当使用require加载.js、.jsx、.es和.es6后缀名的文件，就会先用Babel进行转码
* 只会对require命令加载的文件转码，而不会对当前文件转码
* 由于是实时转码，所以只适合在开发环境使用

## babel-transform-runtime 提供类似程序运行时，可以将全局的 polyfill 沙盒化

* 为了实现 ECMAScript 规范细节，Babel 会使用“助手”方法来保持生成代码整洁
* 由于这些助手方法可能会特别长并且会被添加到每一个文件的顶部，因此可以统一移动到一个单一的“运行时（runtime）”中去

## babel-preset-env

* 通过提供提供兼容环境，而决定要编译那些 ES 特性
* 通过 ES 的特性和 特性的兼容列表 计算出每个特性的兼容性信息
* 通过给定兼容性要求，计算出要使用的 babel 插件

## babel-polyfill 代码填充｜兼容性补丁

* 可以编译所有时新的 JavaScript 语法，如果想使用 api 新特性，在 babel 中一般通过 babel-polyfill 来解决
* 通过引入一个 polyfill 文件来解决问题，在当前运行环境中用来模拟性的复制尚不存在的原生 api 的代码。 能让提前使用还不可用的 APIs
* 用了优秀的 core-js 用作 polyfill，并且还有定制化的 regenerator 来让 generators（生成器）和 async functions（异步函数）正常工作
* 默认不会对Iterator、Generator、Promise、Map、Set等全局对象，以及一些全局对象的方法（比如Object.assign）转码。如果想要对这些对象转码，就要安装babel-polyfill

## 抽象语法树 AST

*

## 工具

* [swc-project/swc](https://github.com/swc-project/swc):Super-fast alternative for babel https://swc-project.github.io/rustdoc/swc/
