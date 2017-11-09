## Webpack

模块加载器兼打包工具。所有小文件打包成一个或多个大文件.一种前端模块化打包解决方案，但是更重要的是它又是一个可以融合运用各种前端新技术的平台，明白webpack的使用哲学后，只需要简单的配置,我们就可以随心所欲的在webpack项目中使用jsx/ts,使用babel/postcss等平台提供的众多其它功能，只需通过一条命令由源码构建最终可用文件.

* 直接使用 require(XXX) 的形式来引入各模块，即使它们可能需要经过编译，有着各种健全的加载器（loader）处理
* 以 commonJS 的形式来书写脚本滴，但对 AMD/CMD 的支持也很全面，方便旧项目进行代码迁移。
* 能被模块化的不仅仅是 JS 了。
* 开发便捷，能替代部分 grunt/gulp 的工作，比如打包、压缩混淆、图片转base64等。
* 扩展性强，插件机制完善，特别是支持 React 热插拔（见 react-hot-loader ）的功能让人眼前一亮。

### 概念

模块打包机：它做的事情是，分析你的项目结构，找到JavaScript模块以及其它的一些浏览器不能直接运行的拓展语言（Scss，TypeScript等），并将其转换和打包为合适的格式供浏览器使用。所有的文件都都当做模块处理

Webpack的工作方式是：把你的项目当做一个整体，通过一个给定的主文件（如：index.js），Webpack将从这个文件开始找到你的项目的所有依赖文件，使用loaders处理它们，最后打包为一个（或多个）浏览器可识别的JavaScript文件。

Loaders：使用不同的loader，webpack有能力调用外部的脚本或工具，实现对不同格式的文件的处理，比如说分析转换scss为css，或者把下一代的JS文件（ES6，ES7)转换为现代浏览器兼容的JS文件，对React的开发而言，合适的Loaders可以把React的中用到的JSX文件转换为JS文件。单独安装并且需要在webpack.config.js中的modules关键字下进行配置，不同的组件不同rules。Loaders的配置包括以下几方面：

- test：一个用以匹配loaders所处理文件的拓展名的正则表达式（必须）
- loader：loader的名称（必须）
- include/exclude:手动添加必须处理的文件（文件夹）或屏蔽不需要处理的文件（文件夹）（可选）；
- query：为loaders提供额外的设置选项（可选）

Source Maps：webpack就可以在打包时为我们生成的source maps，这为我们提供了一种对应编译文件和源文件的方法，使得编译后的代码可读性更高，也更容易调试。

Webpack 的默认配置文件只有一个，即 webpack.config.js

### 区别

Gulp/Grunt是一种能够优化前端的开发流程的工具，而WebPack是一种模块化的解决方案，不过Webpack的优点使得Webpack在很多场景下可以替代Gulp/Grunt类的工具。

Grunt和Gulp的工作方式是：在一个配置文件中，指明对某些文件进行类似编译，组合，压缩等任务的具体步骤，工具之后可以自动替你完成这些任务。

### 安装

```
npm init  // 初始化项目信息

npm install -g webpack //全局安装
npm install --save-dev webpack // 本地安装Webpack

webpack hello.js hello.bundle.js  //基本使用

--progress  // 显示打包过程的进度
--display-modules  // 显示打包的模块
--display-reasons // 显示打包这些模块的原因
--watch // 监听变动并自动打包
--display-error-details // 能查阅更详尽的信息
--config XXX.js // //使用另一份配置文件（比如webpack.config2.js）来打包
-p    //压缩混淆脚本，这个非常非常重要！
```

### 配置文件

- entry：入口文件
- output：生成文件
- __dirname：全局变量，当前脚本目录
- devtool: 'eval-source-map',
- devserver：webpack-dev-server配置

  ```js
  var webpack = require('webpack');
  var commonsPlugin = new webpack.optimize.CommonsChunkPlugin('common.js');

  module.exports = {
      //插件项 使用了一个 CommonsChunkPlugin 的插件,来提取多个页面之间的公共模块，并将该模块打包为 common.js 。
      plugins: [commonsPlugin],
      //页面入口文件配置 支持数组形式，将加载数组中的所有模块，但以最后一个模块作为输出
      entry: {
          index : './src/js/page/index.js'
          // page2: ["./entry1", "./entry2"] 
          // p1: "./page1",
        // p2: "./page2",
        // p3: "./page3",
        // ap1: "./admin/page1",
        // ap2: "./admin/page2"
      },
      //入口文件输出配置 
      output: {
          path: 'dist/js/page',
          filename: '[name].js'
      },
      module: {
          //加载器配置 每一种文件都需要使用什么加载器来处理 "-loader"其实是可以省略不写的，多个loader之间用“!”连接起来。
          loaders: [
              { test: /\.css$/, loader: 'style-loader!css-loader' },
              { test: /\.js$/, loader: 'jsx-loader?harmony' },
              { test: /\.scss$/, loader: 'style!css!sass?sourceMap'},
              { test: /\.(png|jpg)$/, loader: 'url-loader?limit=8192'} //将样式中引用到的图片转为模块来处理,“?limit=8192”表示将所有小于8kb的图片都转为base64形式（其实应该说超过8kb的才使用 url-loader 来映射到文件，否则转为data url形式）。
          ]
      },
      plugins: [
          new CommonsChunkPlugin("admin-commons.js", ["ap1", "ap2"]),
          new CommonsChunkPlugin("commons.js", ["p1", "p2", "admin-commons.js"])
      ]
      //其它解决方案配置
      resolve: {
          //查找module的话从这里开始查找
        root: 'E:/github/flux-example/src', //绝对路径
        //自动扩展文件后缀名，意味着我们require模块可以省略不写后缀名
        extensions: ['', '.js', '.json', '.scss'],
        //模块别名定义，方便后续直接引用别名，无须多写长长的地址
        alias: {
            AppStore : 'js/stores/AppStores.js',//后续直接 require('AppStore') 即可
            ActionType : 'js/actions/ActionType.js',
            AppAction : 'js/actions/AppAction.js'
        }
        devServer: {
            contentBase: "./public",//本地服务器所加载的页面所在的目录
            historyApiFallback: true,//不跳转
            inline: true//实时刷新
        }

  };

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

- loaders：

### 组件

- webpack-dev-server：浏览器监听你的代码的修改，并自动刷新显示修改后的结果.
- babel：编译JavaScript的平台

  - 下一代的JavaScript代码（ES6，ES7...），即使这些标准目前并未被当前的浏览器完全的支持；
  - 使用基于JavaScript进行了拓展的语言，比如React的JSX；

- css-loader：能够使用类似@import 和 url(...)的方法实现 require()的功能。`require('css-loader!./style.css');`:可以解析执行css文件
- style-loader：所有的计算后的样式加入页面中，二者组合在一起使你能够把样式表嵌入webpack打包后的JS文件中`require('style-loader!css-loader!./style.css');`:为了生成一个style标签，并且将解析后的css文件插入到style中去
- CSS modules：通过CSS模块，所有的类名，动画名默认都只作用于当前模块。在CSS loader中进行配置后，你所需要做的一切就是把"modules"传递到所需要的地方，然后就可以直接把CSS的类名传递到组件的代码中，且这样做只对当前组件有效，不必担心在不同的模块中使用相同的类名造成冲突。

```shell
webpack hello.js hello.bundle.js --module-bind 'css=style-loader!css-loader' --watch  // 单次绑定模块，实时更新
```
### 插件

插件（Plugins）是用来拓展Webpack功能的，它们会在整个构建过程中生效，执行相关的任务。

与loaders区别：loaders是在打包构建过程中用来处理源文件的（JSX，Scss，Less..），一次处理一个，插件并不直接操作单个文件，它直接对整个构建过程其作用。

- HtmlWebpackPlugin：依据一个简单的index.html模板，生成一个自动引用你打包后的JS文件的新index.html。
- Hot Module Replacement：在修改组件代码后，自动刷新实时预览修改后的效果。配置在webpack配置文件中添加HMR插件；在Webpack Dev Server中添加"hot"参数；如果是React模块，使用我们已经熟悉的Babel可以更方便的实现功能热加载。

### 构建

- ExtractTextPlugin：分离CSS和JS文件
- UglifyJsPlugin：压缩JS代码；
- OccurenceOrderPlugin :为组件分配ID，通过这个插件webpack可以分析和优先考虑使用最多的模块，并为它们分配最小的ID
- 缓存：一个哈希值添加到打包的文件名中，使用方法如下,添加特殊的字符串混合体（[name], [id] and [hash]）到输出文件名前 `filename: "bundle-[hash].js"`

### [重构webpack配置文件](https://zhuanlan.zhihu.com/p/29161762):配置不同环境

- 开发环境

  - NODE_ENV 为 development
  - 启用模块热更新（hot module replacement）
  - 额外的 webpack-dev-server 配置项，API Proxy 配置项
  - 输出 Sourcemap

- 生产环境

  - NODE_ENV 为 production
  - 将 React、jQuery 等常用库设置为 external，直接采用 CDN 线上的版本
  - 样式源文件（如 css、less、scss 等）需要通过 ExtractTextPlugin 独立抽取成 css 文件
  - 启用 post-css
  - 启用 optimize-minimize（如 uglify 等）
  - 中大型的商业网站生产环境下，是绝对不能有 console.log() 的，所以要为 babel 配置 Remove console transform

这里需要说明的是因为开发环境下启用了 hot module replacement，为了让样式源文件的修改也同样能被热替换，不能使用 ExtractTextPlugin，而转为随 JS Bundle 一起输出。

package.json 里添加相应的配置：

```json
{
  "scripts": {
    "build": "webpack --optimize-minimize",
    "dev": "webpack-dev-server --config webpack.dev.config.js",
    "start": "npm run dev" // 或添加你自己的 start 逻辑
  },
}

npm run dev // 构建npm脚本
```

在开发环境下的时候，你需要使用 npm run dev 来启动，而在生产环境中，则用 npm run build 来发布。

在真实场景中，我们不会直接使用 webpack-dev-server，而采用 express + webpack/webpack-dev-middleware

## 仓库

* [webpack/webpack](https://github.com/webpack/webpack):A bundler for javascript and friends. Packs many modules into a few bundled assets. Code Splitting allows to load parts for the application on demand. Through "loaders," modules can be CommonJs, AMD, ES6 modules, CSS, Images, JSON, Coffeescript, LESS, ... and your custom stuff. https://webpack.js.org
## 工具

* [webpack-dashboard](https://github.com/FormidableLabs/webpack-dashboard):A CLI dashboard for webpack dev server
* [webpack/webpack-dev-server](https://github.com/webpack/webpack-dev-server):Serves a webpack app. Updates the browser on changes.

### webpack-dashboard

```
// 安装
npm install webpack-dashboard --save-dev
yarn add webpack-dashboard

// Import the plugin:
var DashboardPlugin = require('webpack-dashboard/plugin'); // const

// If you aren't using express, add it to your webpack configs plugins section:
plugins: [
    new DashboardPlugin()
]

// 脚本修改
"scripts": {
    "dev": "webpack-dashboard -- node index.js"
}

// 在vue-cli与create-my-react
plugin 位置正确
脚本配置正确
```

### 跨域

在config中index.js,dev-->proxyTable

## 部署



## 参考

* [webpack 从入门到工程实践](http://gitbook.cn/books/599270d5625e0436309466c7/index.html)
* [Webpack 工程的 PWA 实战](http://gitbook.cn/books/59957adbebb0e06f9f24c389/index.html)

## 教程

* [webpack/react-starter](https://github.com/webpack/react-starter):[OUTDATED] Starter template for React with webpack. Doesn't focus on simplicity! NOT FOR BEGINNERS!
* [入门Webpack](http://www.jianshu.com/p/42e11515c10f)
* [Webpack for React](http://www.pro-react.com/materials/appendixA/)
* [代码](https://github.com/bluebird89/webpack_for_react)

