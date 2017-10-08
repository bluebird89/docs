# Node
其高性能并行I/O使得分布式开发更加高效，利用稳定接口可提升web渲染速度，也十分适合做实时应用开发。


- CommonJS:Node.JS首先采用了js模块化的概念。Node.js服务器端通过exports、module.exports来输出模块，并使用require同步载入模块，而浏览器端的可以使用Browserify实现。
- AMD:AMD规范用于异步加载模块，主要用于浏览器端，当然也支持其他js环境，主要应用有requireJS。
- ES6 Module:ES6标准定义了JS的模块化方式，目的是取代CommonJS、AMD、CMD等规范，一统江湖，成为通用的模块化解决方案。但浏览器和Node端对ES6的支持度还不是很高，需要用Babel进行转译（Babel编译器可以将ES6、JSX等代码转换成浏览器可以看得懂的语法）。
- Gulp/Grunt+Webpack/Browserify:在构建前端项目资源，使用自动化工具协助进行自动化程序码打包、转译等重复性工作，可以大幅提升开发效率。
    - Gulp:Gulp和Grunt一样是一种基于任务的构建工具，能够优化前端工作流程。
    - Webpack:webpack傻瓜式的项目构建方式解决了模块化开发和静态文件处理两大问题。但随着项目越来越大，特定需求的出现就使得webpack越来越难配置了。因此webpack在没太多特定需求的项目使用是没有问题的，当然，webpack的未来肯定是围绕ES的支持度、构建速度与产出代码的性能和用户体验来建设的。其未来的重要关注点：
        - 高性能的构建缓存
        - 提升初始化速度和增量构建效率
        - 更好的支持Type Script
        - 修订长期缓存
        - 支持WASM模块支持
        - 提升用户体验
    - Browserify:Browserify是基于Unix小工具协作的方式实现模块化方案的，轻便且配置容易，管道形式的组织则让开发者很容易插拔或修改其中某一环节的操作。
- ES2015/ES6:我们都知道ECMASCRIPT是组成JS的三要素之一，ES6其第6个版本，ES的历史确实也挺曲折的。通过ES6最常用的特性，我们来了解ES6到底解决了什么：
    - let, const（变量类型）：解决变量作用域泄露的问题。
    - Class, extends, super（类、继承）：让对象原型的写法更加清晰、更像面向对象编程的语法，也更加通俗易懂。
    - Arrow functions（箭头函数）：1.简洁、简洁、简洁，2.解决this绑定的问题（继承外面的this）。
    - Template string（模板字符串）：解决传统写法非常麻烦的问题。
    - Destructuring（解构）：避免让API使用者记住多个参数的使用顺序。
    - Default, rest（默认值、参数）：简化，替代arguments，使代码更易于阅读。
- ImmutableJS:我们知道在JavaScript中有两种数据类型：基础数据类型和引用类型。在JavaScript中的对象数据是可以变的，由于使用了引用，所以修改了复制的值也会相应地修改原始值。通常我们用deepCopy来避免修改，但这样做法会产生资源浪费。而ImmutableJS的出现很好的解决了这一问题。

## npm
Node的包描述文件是一个JSON文件，用于描述非代码相关的信息。而NPM则是一个根据包规范来提供Node服务的Node包管理器。它解决了依赖包安装的问题，却面临着两个新的问题：

- 安装的时候无法保证速度和一致性。
- 安全问题，因为NPM安装时允许运行代码。

于是Yarn就出现了

## 安装

```
# ubuntu
sudo git clone https://github.com/nodejs/node.git
sudo chmod -R 755 node
cd node
sudo ./configure
sudo make
sudo make install

curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs

curl http://npmjs.org/install.sh | sh

# Mac
brew install nvm
nvm install 4.4.5
nvm use 4.4.5

brew install node
```

## 资料

- [开发命令行工具](https://juejin.im/post/59b73c9df265da06670c5868)
- [ElemeFE/node-interview](https://github.com/ElemeFE/node-interview)

## 扩展

- [youzan/zan-tool](https://github.com/youzan/zan-tool):Zan Node Web 框架的配套开发工具，例如初始化一个新项目、新建一个 NPM 包、本地开发等。
- [NodeOS](https://github.com/NodeOS/NodeOS)
- [sindresorhus/awesome-electron](https://github.com/sindresorhus/awesome-electron)Useful resources for creating apps with Electron
- [sindresorhus/awesome-nodejs](https://github.com/sindresorhus/awesome-nodejs)Delightful Node.js packages and resources
- [sequelize/sequelize](https://github.com/sequelize/sequelize)An easy-to-use multi SQL dialect ORM for Node.js <http://docs.sequelizejs.com>
- [thinkjs/thinkjs](https://github.com/thinkjs/thinkjs)Use full ES2015+ features to develop Node.js applications, Support TypeScript <http://blog.csdn.net/u012939368/article/details/77444889>
