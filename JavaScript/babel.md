## [babel](https://github.com/babel/babel)

🐠 Babel is a compiler for writing next generation JavaScript. https://babeljs.io/

* 一个工具链，主要用于在旧的浏览器或环境中将 ECMAScript 2015+ 代码转换为向后兼容版本的 JavaScript 代码
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

```sh
npm install --save-dev @babel/core @babel/cli @babel/preset-env
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
* babel-cli allows you to compile files from the command line.
* preset-react and preset-env are both presets that transform specific flavors of code — in this case,
    - the env preset allows us to transform ES6+ into more traditional javascript
    - the react preset does the same, but with JSX instead

## 参考

* [jamiebuilds/babel-handbook](https://github.com/jamiebuilds/babel-handbook):📘 A guided handbook on how to use Babel and how to create plugins for Babel. https://git.io/babel-handbooks
* [swc-project/swc](https://github.com/swc-project/swc):Super-fast alternative for babel https://swc-project.github.io/rustdoc/swc/
