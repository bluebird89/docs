# [webpack/webpack](https://github.com/webpack/webpack)

A bundler for javascript and friends. Packs many modules into a few bundled assets. Code Splitting allows to load parts for the application on demand. Through "loaders," modules can be CommonJs, AMD, ES6 modules, CSS, Images, JSON, Coffeescript, LESS, ... and your custom stuff. https://webpack.js.org

module bundler(模块加载器兼打包工具)。所有小文件打包成一个或多个大文件.一种前端模块化打包解决方案，但是更重要的是它又是一个可以融合运用各种前端新技术的平台，明白webpack的使用哲学后，只需要简单的配置,我们就可以随心所欲的在webpack项目中使用jsx/ts,使用babel/postcss等平台提供的众多其它功能，只需通过一条命令由源码构建最终可用文件.

* 直接使用 require(XXX) 的形式来引入各模块，即使它们可能需要经过编译，有着各种健全的加载器（loader）处理
* 对 CommonJS 、 AMD 、ES6的语法做了兼容.以 commonJS 的形式来书写脚本滴，但对 AMD/CMD 的支持也很全面，方便旧项目进行代码迁移。
* web开发中常用到的静态资源主要有JavaScript、CSS、图片、Jade等文件，webpack中将静态资源文件称之为模块。能被模块化的不仅仅是 JS 了。
* 开发便捷，能替代部分 grunt/gulp 的工作，比如打包、压缩混淆、图片转base64等。
* 扩展性强，插件机制完善，特别是支持 React 热插拔（见 react-hot-loader ）,串联式模块加载器以及插件机制，让其具有更好的灵活性和扩展性，例如提供对CoffeeScript、ES6的支持
* 独立的配置文件webpack.config.js
* 将代码切割成不同的chunk，实现按需加载，降低了初始化时间
* 支持 SourceUrls 和 SourceMaps，易于调试
* 使用异步 IO 并具有多级缓存。这使得 webpack 很快且在增量编译上更加快

## 概念

* 模块打包机：分析项目结构，找到JavaScript模块以及其它的一些浏览器不能直接运行的拓展语言（Scss，TypeScript等），并将其转换和打包为合适的格式供浏览器使用。所有的文件都都当做模块处理
* Webpack的工作方式是：把项目当做一个整体，通过一个给定的主文件（如：index.js），Webpack将从这个文件开始找到你的项目的所有依赖文件，使用loaders处理它们，最后打包为一个（或多个）浏览器可识别的JavaScript文件。
* Loaders：使用不同的loader，webpack有能力调用外部的脚本或工具，实现对不同格式的文件的处理，比如说分析转换scss为css，或者把下一代的JS文件（ES6，ES7)转换为现代浏览器兼容的JS文件，对React的开发而言，合适的Loaders可以把React的中用到的JSX文件转换为JS文件。单独安装并且需要在webpack.config.js中的modules关键字下进行配置，不同的组件不同rules。Loaders的配置包括以下几方面：
    - test：一个用以匹配loaders所处理文件的拓展名的正则表达式（必须）
    - loader：loader的名称（必须）
    - include/exclude:手动添加必须处理的文件（文件夹）或屏蔽不需要处理的文件（文件夹）（可选）；
    - query：为loaders提供额外的设置选项（可选）
* Source Maps：webpack就可以在打包时为我们生成的source maps，这为我们提供了一种对应编译文件和源文件的方法，使得编译后的代码可读性更高，也更容易调试。
* 默认配置文件只有一个webpack.config.js

## 安装

```sh
npm init  #  初始化项目信息

npm install -g webpack # 全局安装
npm install --save-dev webpack #  本地安装Webpack

webpack hello.js hello.bundle.js  # 基本使用
webpack hello.js hello.bundle.js --module-bind 'css=style-loader!css-loader' --watch  #  单次绑定模块，实时更新

--progress  #  显示打包过程的进度
--display-modules  #  显示打包的模块
--display-reasons #  显示打包这些模块的原因
--watch / -w  #  监听变动并自动打包
--display-error-details #  能查阅更详尽的信息
--config XXX.js #  # 使用另一份配置文件（比如webpack.config2.js）来打包
-p    #  对打包后的文件进行压缩，提供production
-d #  提供source map，方便调试。
```

## 配置

* entry：入口文件
* output：生成文件
* __dirname：全局变量，当前脚本目录
* devtool: 'eval-source-map',
* devserver：webpack-dev-server配置
* loaders

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
    //  page3: {
      //  subp1: "./sp1",
     //   subp2: "./sp2"
    //}
  },
  //入口文件输出配置
  output: {
      path: 'dist/js/page',
      filename: '[name].js'
  },
  module: {
      //加载器配置 表示匹配的资源类型 每一种文件都需要使用什么加载器来处理 "-loader"其实是可以省略不写的，多个loader之间用“!”连接起来。
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
    //自动扩展文件后缀名，意味着我们require模块可以省略不写后缀名,自行补全文件后缀
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
}
```

## 组件

* webpack-dev-server：浏览器监听代码修改，并自动刷新显示修改后的结果.基于Node.js Express框架的开发服务器，一个静态资源Web服务器，对于简单静态页面或者仅依赖于独立服务的前端页面，都可以直接使用这个开发服务器进行开发。在开发过程中，开发服务器会监听每一个文件的变化，进行实时打包，并且可以推送通知前端页面代码发生了变化，从而可以实现页面的自动刷新。
* babel：编译JavaScript的平台
    - 下一代的JavaScript代码（ES6，ES7...），即使这些标准目前并未被当前的浏览器完全的支持
    - 使用基于JavaScript进行了拓展的语言，比如React的JSX；
* css-loader：能够使用类似@import 和 url(...)的方法实现 require()的功能。`require('css-loader!./style.css');`:可以解析执行css文件
  - CSS Module的官网，CSS Module只对类名和动画的名字起作用
* style-loader：所有的计算后的样式加入页面中，二者组合在一起使你能够把样式表嵌入webpack打包后的JS文件中`require('style-loader!css-loader!./style.css');`:为了生成一个style标签，并且将解析后的css文件插入到style中去
* CSS modules：通过CSS模块，所有的类名，动画名默认都只作用于当前模块。在CSS loader中进行配置后，所需要做的一切就是把"modules"传递到所需要的地方，然后就可以直接把CSS的类名传递到组件的代码中，且这样做只对当前组件有效，不必担心在不同的模块中使用相同的类名造成冲突。
* UglifyJsPlugin，可以优化（支持压缩、混淆）代码
* file-loader:将图片转为连接
* url-loader:对小图片直接Base64编码，对大图片通过file-loader进行处理
* image-webpack-loader:对各种图片进行压缩
* mini-css-extract-plugin:所有的css抽离为独立的css文件

### 插件

插件（Plugins）是用来拓展Webpack功能的，会在整个构建过程中生效，执行相关的任务

* 与loaders区别：loaders是在打包构建过程中用来处理源文件的（JSX，Scss，Less..），一次处理一个，插件并不直接操作单个文件，它直接对整个构建过程其作用
* HtmlWebpackPlugin：依据一个简单的index.html模板，生成一个自动引用打包后的JS文件到新index.html
* 热替换（HMR）Hot Module Replacement：在修改组件代码后，自动刷新实时预览修改后的效果。配置在webpack配置文件中添加HMR插件；在Webpack Dev Server中添加"hot"参数；如果是React模块，使用我们已经熟悉的Babel可以更方便的实现功能热加载。
* [webpack/webpack-dev-middleware](https://github.com/webpack/webpack-dev-middleware):A development middleware for webpack

### 构建

* ExtractTextPlugin：分离CSS和JS文件
* UglifyJsPlugin：压缩JS代码；
* OccurenceOrderPlugin :为组件分配ID，通过这个插件webpack可以分析和优先考虑使用最多的模块，并为它们分配最小的ID
* 缓存：一个哈希值添加到打包的文件名中，使用方法如下,添加特殊的字符串混合体（[name], [id] and [hash]）到输出文件名前 `filename: "bundle-[hash].js"`
* 代码分隔(Code Split):减少代码重复;支持缓存;
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
  - 一个module有可能同属于多个cacheGroup，因此可以通过设置某个cacheGroup的优先级(priority)来解决，priority值越大，表示优先级越高，也即会优先其作用。Webpack的两个默认cacheGroup的优先级都被设置成了负数，而我们自定义的cacheGroup的默认priority为0，因此可以初步保证自定义的cacheGroup总会优先于默认的起作用。

### [配置不同环境](https://zhuanlan.zhihu.com/p/29161762)

* 开发环境
    - NODE_ENV 为 development
    - 启用模块热更新（hot module replacement）
    - 额外的 webpack-dev-server 配置项，API Proxy 配置项
    - 输出 Sourcemap
* 生产环境
    - NODE_ENV 为 production
    - 将 React、jQuery 等常用库设置为 external，直接采用 CDN 线上的版本
    - 样式源文件（如 css、less、scss 等）需要通过 ExtractTextPlugin 独立抽取成 css 文件
    - 启用 post-css
    - 启用 optimize-minimize（如 uglify 等）
    - 中大型的商业网站生产环境下，是绝对不能有 console.log() 的，所以要为 babel 配置 Remove console transform
* 需要说明的是因为开发环境下启用了 hot module replacement，为了让样式源文件的修改也同样能被热替换，不能使用 ExtractTextPlugin，而转为随 JS Bundle 一起输出。
* 在开发环境下的时候，需要使用 npm run dev 来启动，而在生产环境中，则用 npm run build 来发布
* 在真实场景中，不会直接使用 webpack-dev-server，而采用 express + webpack/webpack-dev-middleware

```json
# package.json
{
  "scripts": {
    "build": "webpack --optimize-minimize",
    "dev": "webpack-dev-server --config webpack.dev.config.js",
    "start": "npm run dev" // 或添加你自己的 start 逻辑
  },
}

npm run dev // 构建npm脚本
```

## [vuejs/vue-cli](https://github.com/vuejs/vue-cli)

hammer_and_wrench CLI for rapid Vue.js development https://cli.vuejs.org/

```sh
npm install -g vue-cli
vue list
vue init <template-name> <project-name>
```

### [webpack-dashboard](https://github.com/FormidableLabs/webpack-dashboard)

A CLI dashboard for webpack dev server

```sh
# 安装
npm install webpack-dashboard --save-dev
yarn add webpack-dashboard

# Import the plugin:
var DashboardPlugin = require('webpack-dashboard/plugin'); // const

# If you aren't using express, add it to your webpack configs plugins section:
plugins: [
    new DashboardPlugin()
]

# 脚本修改
"scripts": {
    "dev": "webpack-dashboard -- node index.js"
}
```

### webpack-bundle-analyzer

```sh
npm install --save-dev webpack-bundle-analyzer

# 修改webpack.config.js
let BundleAnalyzerPlugin = require('webpack-bundle-analyzer').BundleAnalyzerPlugin;

module.exports = {
    plugins: [new BundleAnalyzerPlugin()]
}

npm run build --report
```

```js
module.exports = {
    context: path.resolve('js'),
    entry: {
        utils:'./utils.js',
        main:'./main.js'
    },
    output: {
        path: path.resolve('build/js/'),
        publicPath:'/public/assets/js/',
        filename: '[name].js'
    },
    devServer: {
        contentBase: 'views'
    },
    module: {
        preLoaders: [
            {
                test: /\.js$/,
                exclude: /node_modules/,
                loader: 'jshint'
            }
        ],

        loaders: [
            {
                test: /\.js$/,
                exclude: /node_modules/,
                loader: 'babel',
                query: {
                    presets: [
                        'es2015'
                    ]
                }
            },
            {
                test: /\.less$/,
                exclude: /node_modules/,
                loader: 'style!css!less'
            },
            {
                test: /\.(jpg|jpeg|png|gif)$/,
                include: /images/,
                loader: 'url'
            }

        ]
    },

    jshint:{
            "failOnHint": true,
            'esnext': true,
        }
};
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

## 问题

```
Parsing error: The keyword 'import' is reserved

"parserOptions": {
    "sourceType": "module"
  }
```

## 工具

* [survivejs/webpack-merge](https://github.com/survivejs/webpack-merge):Merge designed for Webpack (MIT)
* [babel/babel-loader](https://github.com/babel/babel-loader):📦 Webpack plugin for Babel
* [shama/webpack-stream](https://github.com/shama/webpack-stream):🍹 Run webpack through a stream interface
* [webpackmonitor/webpackmonitor](https://github.com/webpackmonitor/webpackmonitor):A tool for monitoring webpack optimization metrics through the development process http://webpackmonitor.com
* [GoogleChromeLabs/webpack-libs-optimizations](https://github.com/GoogleChromeLabs/webpack-libs-optimizations):Using a library in your webpack project? Here’s how to optimize it
* [webpack/webpack-dev-server](https://github.com/webpack/webpack-dev-server):Serves a webpack app. Updates the browser on changes.

## 参考

* [webpack-contrib/awesome-webpack](https://github.com/webpack-contrib/awesome-webpack):A curated list of awesome Webpack resources, libraries and tools
* [webpack-china/awesome-webpack-cn](https://github.com/webpack-china/awesome-webpack-cn):[印记中文](https://docschina.org/) - webpack 优秀中文文章 https://webpack.docschina.org/
* [gwuhaolin/dive-into-webpack](https://github.com/gwuhaolin/dive-into-webpack):全面的Webpack教程《深入浅出Webpack》电子书 http://webpack.wuhaolin.cn

* [webpack-simple](https://github.com/vuejs-templates/webpack-simple)
* [webpack 从入门到工程实践](http://gitbook.cn/books/599270d5625e0436309466c7/index.html)
* [Webpack 工程的 PWA 实战](http://gitbook.cn/books/59957adbebb0e06f9f24c389/index.html)
* [webpack/react-starter](https://github.com/webpack/react-starter):[OUTDATED] Starter template for React with webpack. Doesn't focus on simplicity! NOT FOR BEGINNERS!

* [入门Webpack](http://www.jianshu.com/p/42e11515c10f)
* [Webpack for React](http://www.pro-react.com/materials/appendixA/)
* [代码](https://github.com/bluebird89/webpack_for_react)

* [vue-cli document](https://vuejs-templates.github.io/webpack/)
* [基于webpack的前后端分离开发环境实战](https://segmentfault.com/a/1190000009266900)
* [webpack：从入门到真实项目配置](https://juejin.im/post/59bb37fa6fb9a00a554f89d2)
* [petehunt/webpack-howto](https://github.com/petehunt/webpack-howto)
* [KieSun/webpack-demo](https://github.com/KieSun/webpack-demo):从入门到真实项目配置，每个 commit 基本都对应一小节
* [wallstreetcn/webpack-and-spa-guide](https://github.com/wallstreetcn/webpack-and-spa-guide):Webpack 4 和单页应用入门
* [ruanyf/webpack-demos](https://github.com/ruanyf/webpack-demos):a collection of simple demos of Webpack
