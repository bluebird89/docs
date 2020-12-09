# [webpack](https://github.com/webpack/webpack)

A bundler for javascript and friends. Packs many modules into a few bundled assets. Code Splitting allows to load parts for the application on demand. Through "loaders," modules can be CommonJs, AMD, ES6 modules, CSS, Images, JSON, Coffeescript, LESS, ... and your custom stuff. <https://webpack.js.org>

* module bundler(模块加载器兼打包工具)，将不同脚本打包成一个文件，浏览器可以运行这个文件
* 一种前端模块化打包解决方案，可以融合运用各种前端新技术

* 直接使用 require(XXX) 的形式来引入各模块
* 对 CommonJS 、 AMD 、ES6的语法做了兼容.以 commonJS 的形式来书写脚本滴，但对 AMD/CMD 的支持也很全面，方便旧项目进行代码迁移
* 能将依赖模块，区分成不同的代码块（chunk），按需加载
* 能将静态资源（样式表、图片、字体等等），像加载模块那样加载
* 扩展性强，插件机制完善，特别是支持 React 热插拔,串联式模块加载器以及插件机制，让其具有更好的灵活性和扩展性，例如提供对CoffeeScript、ES6的支持
* 支持 SourceUrls 和 SourceMaps，易于调试
  - Source Maps：在打包时生成source maps，提供了编译文件和源文件方法的对应关系，使得编译后代码可读性更高，也更容易调试
* 使用异步 IO 并具有多级缓存

## 概念

* 模块打包机：分析项目结构，找到JavaScript模块以及其它的一些浏览器不能直接运行的拓展语言（Scss，TypeScript等），并将其转换和打包为合适的格式供浏览器使用。所有的文件都都当做模块处理
* 工作方式：把项目当做一个整体，通过一个给定的主文件（如：index.js），Webpack将从这个文件开始找到你的项目的所有依赖文件，使用loaders处理它们，最后打包为一个（或多个）浏览器可识别的JavaScript文件
* Loaders：使用不同的loader，webpack有能力调用外部的脚本或工具，实现对不同格式的文件的处理，比如说分析转换scss为css，或者把下一代的JS文件（ES6，ES7)转换为现代浏览器兼容的JS文件，对React的开发而言，合适的Loaders可以把React的中用到的JSX文件转换为JS文件。单独安装并且需要在webpack.config.js中的modules关键字下进行配置，不同的组件不同rules。Loaders的配置包括以下几方面：
  - test：一个用以匹配loaders所处理文件的拓展名的正则表达式（必须）
  - loader：loader的名称（必须）
  - include/exclude:手动添加必须处理的文件（文件夹）或屏蔽不需要处理的文件（文件夹）（可选）；
  - query：为loaders提供额外的设置选项（可选）

## 安装与使用

* 参数
  - --progress  #  显示打包过程的进度
  - --display-modules  #  显示打包的模块
  - --display-reasons #  显示打包这些模块的原因
  - --watch｜-w  #  监听变动并自动打包
  - --devtool用来指定如何生成 Source map 文件
  - --display-error-details  能查阅更详尽的信息
  - --config XXX.js  指定配置文件
  - -p    #  对打包后的文件进行压缩，提供production
  - -d #  提供source map，方便调试

```sh
npm init  #  初始化项目信息

npm i -g webpack-cli
npm install --save-dev webpack #  本地安装Webpack

# 手动
webpack hello.js hello.bundle.js  # 基本使用
webpack hello.js hello.bundle.js --module-bind 'css=style-loader!css-loader' --watch  #  单次绑定模块，实时更新

# Error: Cannot find module '@babel/core'
npm install @babel/core --save
```

## [配置](https://www.webpackjs.com/configuration/)

* 默认配置文件 webpack.config.js
* 采用 CommonJS 模块格式，输出一个配置对象
* webpack
  - entry：打包入口脚本。可以是一个字段，一个数组
    + 对象时，通常与output字段配合，打出多个包
  - output：打包后输出
  - __dirname：全局变量，当前脚本目录
  - devtool: 'eval-source-map'
  - devserver：webpack-dev-server配置
    + hot：是否打开热替换
    + contentBase：存放静态文件的位置
    + publicPath：存放打包文件的位置，一般与output.publicPath相同
    + historyApiFallback：发生 404 错误时打开的位置
  - externals 指定哪些模块不需要打包，全局环境本身会提供
  - module 字段
    + rules 指定转码规则
  - loaders
  - resolve字段是一个对象，规定了模块解析的设置
    + modules 设置模块加载时，依次搜索的目录
    + extensions 设置脚本文件的后缀名，即不指定脚本的后缀名时，Webpack 会自动添加的后缀名
    + mainFields默认采用 ["browser", "module", "main"]
  - plugins指定打包时需要插件
  - require支持模块加载以后，执行回调函数
  - require.ensure 方法用来指定分开打包的脚本
    + 第一个参数是一个数组，表示0.bundle.js依赖的模块，可以不输入任何值，表示没有任何依赖
    + 第二个参数是一个回调函数，该函数将在0.bundle.js加载后执行。该函数的参数require函数，凡是在函数体内用require加载的模块都会被打包进入0.bundle.js
    + 第三个参数是一个字符串，表示当前require.ensure打包的这段代码的名字，用于使用多个require.ensure时，所有代码可以打包成一个文件，避免打包成多个文件
* 开发环境
  - NODE_ENV 为 development
  - 启用模块热更新（hot module replacement）
    + 为了让样式源文件的修改也同样能被热替换，不能使用 ExtractTextPlugin，而转为随 JS Bundle 一起输出
  - 额外的 webpack-dev-server 配置项，API Proxy 配置项
  - 输出 Sourcemap
* 生产环境
  - NODE_ENV 为 production
  - 将 React、jQuery 等常用库设置为 external，直接采用 CDN 线上的版本
  - 样式源文件（如 css、less、scss 等）需要通过 ExtractTextPlugin 独立抽取成 css 文件
  - 启用 post-css
  - 启用 optimize-minimize（如 uglify 等）
  - 绝对不能有 console.log() 的，所以要为 babel 配置 Remove console transform
  + 生产环境不会直接使用 webpack-dev-server，而采用 express + webpack/webpack-dev-middleware
* 参考
  - [为什么要做三份 Webpack 配置文件](https://zhuanlan.zhihu.com/p/29161762)

```js
// Error: Plugin/Preset files are not allowed to export objects, only functions. In /Users/henry/Workspace/Code/tool/webpack/node_modules/babel-preset-es2015/lib/index.js

gulp.task("webpack", function(callback) { // 配合grunt/pulp使用
  // run webpack
  webpack({
      // configuration
  }, function(err, stats) {
      if(err) throw new gutil.PluginError("webpack", err);
      gutil.log("[webpack]", stats.toString({
          // output options
      }));
      callback();
  });
});
```

## loaders

* Webpack 的强大在于可以通过require加载任何东西。默认情况下，加载的是 JavaScript 文件。如果不是，就要通过 Loader 变形
* 多个 Loader 可以连用
* 参数
  - 指定同一类文件，都使用某个loader
  - 排除某些文件
  - 设置 preloader
* [webpack/webpack-dev-server](https://github.com/webpack/webpack-dev-server):Serves a webpack app. Updates the browser on changes
  - 基于 Express 开发的服务器，一个静态资源Web服务器，适用于简单静态页面或者仅依赖于独立服务的前端页面
  - 在开发过程中，开发服务器会监听每一个文件变化，进行实时打包，并且可以推送通知前端页面代码发生了变化，从而可以实现页面的自动刷新
  - 参数
    + Webpack的实例
    + 配置对象
      * contentBase属性指定HTTP服务器对外访问的主目录，即源文件应该在这个目录。
      * publicPath属性指定静态资源的目录，它是针对网站根目录的，而不是针对服务器根目录
* [babel-loader](https://github.com/babel/babel-loader):📦 Webpack plugin for Babel
  - 下一代JavaScript代码（ES6，ES7...），即使这些标准目前并未被当前的浏览器完全的支持
  - 使用基于JavaScript进行了拓展的语言，比如React的JSX
* css-loader：能够使用类似@import 和 url(...)方法实现 require()的功能。`require('css-loader!./style.css');`:可以解析执行css文件
  - CSS Module官网，CSS Module只对类名和动画的名字起作用
  - CSS modules：通过CSS模块，所有类名，动画名默认都只作用于当前模块
  - 在CSS loader中进行配置后，所需要做的一切就是把"modules"传递到所需要的地方，然后就可以直接把CSS的类名传递到组件的代码中，且这样做只对当前组件有效，不必担心在不同的模块中使用相同的类名造成冲突
* style-loader：所有的计算后样式加入页面中，二者组合在一起使能够把样式表嵌入webpack打包后的JS文件中`require('style-loader!css-loader!./style.css');`:为了生成一个style标签，并且将解析后的css文件插入到style中去
* file-loader:将图片转为连接
* url-loader:对小图片直接Base64编码，对大图片通过file-loader进行处理
* image-webpack-loader:对图片进行压缩

### 插件 Plugins

* 用来拓展Webpack功能的，会在整个构建过程中生效，执行相关的任务
* 与loaders区别：loaders是在打包构建过程中用来处理源文件的（JSX，Scss，Less..），一次处理一个，插件并不直接操作单个文件，它直接对整个构建过程其作用
* HtmlWebpackPlugin：依据一个简单的index.html模板，生成一个自动引用打包后的JS文件到新index.html
* 热替换（HMR）Hot Module Replacement：在修改组件代码后，自动刷新实时预览修改后的效果。配置在webpack配置文件中添加HMR插件；在Webpack Dev Server中添加"hot"参数；如果是React模块，使用已经熟悉的Babel可以更方便的实现功能热加载。
* [webpack/webpack-dev-middleware](https://github.com/webpack/webpack-dev-middleware):A development middleware for webpack
* ExtractTextPlugin：分离CSS和JS文件
* UglifyJsPlugin：压缩 优化（支持压缩、混淆）代码
* mini-css-extract-plugin:所有的css抽离为独立的css文件
  - [webpack-contrib/mini-css-extract-plugin](https://github.com/webpack-contrib/mini-css-extract-plugin):Lightweight CSS extraction plugin
* OccurenceOrderPlugin :为组件分配ID，通过这个插件webpack可以分析和优先考虑使用最多的模块，并为它们分配最小的ID
* 缓存：一个哈希值添加到打包的文件名中，使用方法如下,添加特殊的字符串混合体（[name], [id] and [hash]）到输出文件名前 `filename: "bundle-[hash].js"`
* 代码分隔(Code Split):减少代码重复;支持缓存
  - 场景
    + 入口文件，每个入口文件将有单独的一次代码分割
    + 使用SplitChunksPlugin插件
    + 异步加载，比如使用import()
  - 做法
    + 为第三方依赖库(vendor)单独打包
    + 为webpack自己的runtime代码（manifest）单独打包
    + 为公共业务代码单独打包
    + 为异步加载的module单独打包
  - Webpack4放弃了CommonsChunkPlugin，转而使用SplitChunksPlugin，并通过内置的optimization配置段进行配置
    + 默认只对两种情况进行分割：一是异步加载的module，二是被其他chunk引用次数大于等于2的module
    + 对第三方库有默认的配置(配置有名为vendors的cacheGroup)，为每个第三方库单独默认生成对应的异步加载文件
    + 默认生产chunk最小为30k
    + 默认有两个cacheGroup，一个为vendors用于处理第三方依赖库；一个是default(处理当module被引用等于或超过2次时情况)
  - 一个module有可能同属于多个cacheGroup，因此可以通过设置某个cacheGroup的优先级(priority)来解决，priority值越大，表示优先级越高，也即会优先其作用。Webpack的两个默认cacheGroup的优先级都被设置成了负数，而我们自定义的cacheGroup的默认priority为0，因此可以初步保证自定义的cacheGroup总会优先于默认的起作用

## Node API

* Webpack可以在 Node 环境中调用，它是一个构造函数，接受一个配置对象作为参数，生成 Webpack 实例

### [webpack-dashboard](https://github.com/FormidableLabs/webpack-dashboard)

A CLI dashboard for webpack dev server

```sh
# 安装
npm install webpack-dashboard --save-dev
yarn add webpack-dashboard

# Import the plugin:
var DashboardPlugin = require('webpack-dashboard/plugin');

# If you aren't using express, add it to your webpack configs plugins section:
plugins: [
    new DashboardPlugin()
]

# 脚本修改
"scripts": {
    "dev": "webpack-dashboard -- node index.js"
}
```

### [webpack-bundle-analyzer](https://github.com/webpack-contrib/webpack-bundle-analyzer)

```sh
npm install --save-dev webpack-bundle-analyzer

# 修改webpack.config.js
let BundleAnalyzerPlugin = require('webpack-bundle-analyzer').BundleAnalyzerPlugin;

module.exports = {
    plugins: [new BundleAnalyzerPlugin()]
}

npm run build --report
```

### 跨域

* 在config->index.js->dev-->proxyTable
* webpack-dev-server开启proxy
* 开发环境用nginx反代理

```js
proxyTable: {
  '/list': {
    target: 'http://api.xxxxxxxx.com',
    changeOrigin: true,
    pathRewrite: {
      '^/list': '/list'
    }
  }
}
```

## 微前端 micro front-end

## 模块联合 module federation

## 图书

* [gwuhaolin/dive-into-webpack](https://github.com/gwuhaolin/dive-into-webpack):全面的Webpack教程《深入浅出Webpack》电子书 <http://webpack.wuhaolin.cn>

## 工具

* [survivejs/webpack-merge](https://github.com/survivejs/webpack-merge):Merge designed for Webpack (MIT)
* [shama/webpack-stream](https://github.com/shama/webpack-stream):🍹 Run webpack through a stream interface
* [webpackmonitor/webpackmonitor](https://github.com/webpackmonitor/webpackmonitor):A tool for monitoring webpack optimization metrics through the development process <http://webpackmonitor.com>
* [GoogleChromeLabs/webpack-libs-optimizations](https://github.com/GoogleChromeLabs/webpack-libs-optimizations):Using a library in your webpack project? Here’s how to optimize it

## 参考

* [webpack-develop-startkit](https://github.com/taikongfeizhu/webpack-develop-startkit):webpack-develop-startkit
* [awesome-webpack](https://github.com/webpack-contrib/awesome-webpack):A curated list of awesome Webpack resources, libraries and tools
  - [webpack-china/awesome-webpack-cn](https://github.com/webpack-china/awesome-webpack-cn):[印记中文](https://docschina.org/) - webpack 优秀中文文章 <https://webpack.docschina.org/>

* [webpack-simple](https://github.com/vuejs-templates/webpack-simple)

* [webpack 从入门到工程实践](http://gitbook.cn/books/599270d5625e0436309466c7/index.html)
* [Webpack 工程的 PWA 实战](http://gitbook.cn/books/59957adbebb0e06f9f24c389/index.html)
* [react-starter](https://github.com/webpack/react-starter):[OUTDATED] Starter template for React with webpack. Doesn't focus on simplicity! NOT FOR BEGINNERS!
* [入门Webpack](http://www.jianshu.com/p/42e11515c10f)
* [Webpack for React](http://www.pro-react.com/materials/appendixA/)
* [vue-cli document](https://vuejs-templates.github.io/webpack/)
* [基于webpack的前后端分离开发环境实战](https://segmentfault.com/a/1190000009266900)
* [webpack：从入门到真实项目配置](https://juejin.im/post/59bb37fa6fb9a00a554f89d2)
* [petehunt/webpack-howto](https://github.com/petehunt/webpack-howto)
* [KieSun/webpack-demo](https://github.com/KieSun/webpack-demo):从入门到真实项目配置，每个 commit 基本都对应一小节
* [webpack-and-spa-guide](https://github.com/wallstreetcn/webpack-and-spa-guide):Webpack 4 和单页应用入门
* [ruanyf/webpack-demos](https://github.com/ruanyf/webpack-demos):a collection of simple demos of Webpack
