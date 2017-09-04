[入门Webpack](http://www.jianshu.com/p/42e11515c10f)

[Webpack for React](http://www.pro-react.com/materials/appendixA/)

[代码](https://github.com/bluebird89/webpack_for_react)

# 概念

模块打包机：它做的事情是，分析你的项目结构，找到JavaScript模块以及其它的一些浏览器不能直接运行的拓展语言（Scss，TypeScript等），并将其转换和打包为合适的格式供浏览器使用。所有的文件都都当做模块处理

Webpack的工作方式是：把你的项目当做一个整体，通过一个给定的主文件（如：index.js），Webpack将从这个文件开始找到你的项目的所有依赖文件，使用loaders处理它们，最后打包为一个（或多个）浏览器可识别的JavaScript文件。

Loaders：使用不同的loader，webpack有能力调用外部的脚本或工具，实现对不同格式的文件的处理，比如说分析转换scss为css，或者把下一代的JS文件（ES6，ES7)转换为现代浏览器兼容的JS文件，对React的开发而言，合适的Loaders可以把React的中用到的JSX文件转换为JS文件。单独安装并且需要在webpack.config.js中的modules关键字下进行配置，不同的组件不同rules。Loaders的配置包括以下几方面：

- test：一个用以匹配loaders所处理文件的拓展名的正则表达式（必须）
- loader：loader的名称（必须）
- include/exclude:手动添加必须处理的文件（文件夹）或屏蔽不需要处理的文件（文件夹）（可选）；
- query：为loaders提供额外的设置选项（可选）

Source Maps：webpack就可以在打包时为我们生成的source maps，这为我们提供了一种对应编译文件和源文件的方法，使得编译后的代码可读性更高，也更容易调试。

## 区别

Gulp/Grunt是一种能够优化前端的开发流程的工具，而WebPack是一种模块化的解决方案，不过Webpack的优点使得Webpack在很多场景下可以替代Gulp/Grunt类的工具。

Grunt和Gulp的工作方式是：在一个配置文件中，指明对某些文件进行类似编译，组合，压缩等任务的具体步骤，工具之后可以自动替你完成这些任务。

## 安装

```
//全局安装
npm install -g webpack

npm init
// 安装Webpack
npm install --save-dev webpack
// 构建npm脚本
```

## 配置文件

- __dirname：全局变量，当前脚本目录
- devtool: 'eval-source-map',
- entry：入口文件
- output：生成文件
- devserver：webpack-dev-server配置

  ```
  devServer: {
    contentBase: "./public",//本地服务器所加载的页面所在的目录
    historyApiFallback: true,//不跳转
    inline: true//实时刷新
  }
  ```

- loaders：

## 组件

- webpack-dev-server：浏览器监听你的代码的修改，并自动刷新显示修改后的结果.
- babel：编译JavaScript的平台

  - 下一代的JavaScript代码（ES6，ES7...），即使这些标准目前并未被当前的浏览器完全的支持；
  - 使用基于JavaScript进行了拓展的语言，比如React的JSX；

- css-loader：能够使用类似@import 和 url(...)的方法实现 require()的功能。

- style-loader：所有的计算后的样式加入页面中，二者组合在一起使你能够把样式表嵌入webpack打包后的JS文件中

- CSS modules：通过CSS模块，所有的类名，动画名默认都只作用于当前模块。在CSS loader中进行配置后，你所需要做的一切就是把"modules"传递到所需要的地方，然后就可以直接把CSS的类名传递到组件的代码中，且这样做只对当前组件有效，不必担心在不同的模块中使用相同的类名造成冲突。

## 插件

插件（Plugins）是用来拓展Webpack功能的，它们会在整个构建过程中生效，执行相关的任务。

与loaders区别：loaders是在打包构建过程中用来处理源文件的（JSX，Scss，Less..），一次处理一个，插件并不直接操作单个文件，它直接对整个构建过程其作用。

- HtmlWebpackPlugin：依据一个简单的index.html模板，生成一个自动引用你打包后的JS文件的新index.html。
- Hot Module Replacement：在修改组件代码后，自动刷新实时预览修改后的效果。配置在webpack配置文件中添加HMR插件；在Webpack Dev Server中添加"hot"参数；如果是React模块，使用我们已经熟悉的Babel可以更方便的实现功能热加载。

## 构建

- ExtractTextPlugin：分离CSS和JS文件
- UglifyJsPlugin：压缩JS代码；
- OccurenceOrderPlugin :为组件分配ID，通过这个插件webpack可以分析和优先考虑使用最多的模块，并为它们分配最小的ID
- 缓存：一个哈希值添加到打包的文件名中，使用方法如下,添加特殊的字符串混合体（[name], [id] and [hash]）到输出文件名前 `filename: "bundle-[hash].js"`

## 扩展功能

[webpack-dashboard](https://github.com/FormidableLabs/webpack-dashboard)
