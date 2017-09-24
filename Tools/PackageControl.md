# Package Control

各种资源包管理工具

- Composer
- Yarn
- Bower
- Webpack

## npm

node的包管理工具。配置文件`package.json` scripts：script会安装一定顺序寻找命令对应位置，本地的node_modules/.bin路径就在这个寻找清单中.`npm run {script name}`,将构建命令提到外部指令来

```
// npm设置镜像加速
npm config set registry https://registry.npm.taobao.org --global
npm config set disturl https://npm.taobao.org/dist --global
// 更新npm 版本
npm i -g npm
```

### 资料

## composer:

工程化的思想引入，管理包.在安装依赖后，Composer 将把安装时确切的版本号列表写入 composer.lock 文件

### 安装

```
sudo apt-get install composer
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

brew install composer  // Mac
# file_put_contents(./composer.json): failed to open stream: Permission denied
sudo chown -R $USER .composer/
```

### 配置国内镜像

composer config -g repo.packagist composer `https://packagist.phpcomposer.com`

### 使用

global 命令允许你在 COMPOSER_HOME 目录下执行其它命令 sudo chown -R $USER $HOME/.composer

```
composer init
composer search monolog
compsoer show monolog
composer require cocur/slugify
composer install
composer update
composer remove
composer self-update
```

```
<?php
require **DIR** . '/vendor/autoload.php';
use Cocur\Slugify\Slugify;
$slugify = new Slugify();
echo $slugify->slugify('Hello World, this is a long sentence and I need to make a slug from it!');
```

### 卸载composer:找到文件删除即可

## Yarn

安装yarn( Yarn是Facebook提供的替代npm的工具，可以加速node模块的下载)与react-native-cli（React Native的命令行工具用于执行创建、初始化、更新项目、运行打包服务（packager）等任务）。快速(缓存它下载的每个包，所以不需要重复下载)、可靠(每个安装包的代码执行前使用校验码验证包的完整性)、安全的依赖管理(用一个格式详尽但简洁的 lockfile 和一个精确的算法来安装)

[中文文档](https://yarnpkg.com/zh-Hans/)

### 安装

```
curl -sS <https://dl.yarnpkg.com/debian/pubkey.gpg> | sudo apt-key add - echo "deb <https://dl.yarnpkg.com/debian/> stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt-get update && sudo apt-get install yarn

npm install -g yarn
brew install yarn
```

### 镜像源配置

```
yarn config set registry https://registry.npm.taobao.org --global
yarn config set disturl https://npm.taobao.org/dist --global
```

### 使用

- 开始新项目:yarn init 打开一个交互式表单天剑项目信息,生成package.json信息文件
- 添加依赖包: yarn add [package] yarn add [package]@[version] 1.2.3 ^1.0.0 yarn add [package]@[tag]
- 分别添加到 devDependencies、peerDependencies 和 optionalDependencies： yarn add [package] --dev yarn add [package] --peer yarn add [package] --optional
- 升级依赖包: yarn upgrade [package] yarn upgrade [package]@[version] yarn upgrade [package]@[tag]
- 移除依赖包: yarn remove [package]
- 安装项目的全部依赖:yarn || yarn install --flat 安装一个包的单一版本 --force 强制重新下载所有包 --production 只安装生产环境依赖

## bundle

## grunt

Grunt: The JavaScript Task Runner.构建工具:自动化。对于需要反复重复的任务，例如压缩（minification）、编译、单元测试、linting等.每次运行grunt时，它都会使用node的require()系统查找本地已安装好的grunt。正因为如此，你可以从你项目的任意子目录运行grunt。 `

```
npm install -g grunt-cli
pm install grunt  // 项目中安装
```

## bower

Bower can manage components that contain HTML, CSS, JavaScript, fonts or even image files. Bower doesn't concatenate or minify code or do anything else - it just installs the right versions of the packages you need and their dependencies.

```
$ npm install -g bower
# installs the project dependencies listed in bower.json
$ bower install
# registered package
$ bower install jquery
# GitHub shorthand
$ bower install desandro/masonry
# Git endpoint
$ bower install git://github.com/user/package.git
# URL
$ bower install <http://example.com/script.js>
# Create a bower.json
$ bower init
# use

<script src="bower_components/jquery/dist/jquery.min.js">
</script>
```

## gulp

The streaming build system ,用自动化构建工具增强你的工作流程

```
# 全局安装
npm install -g gulp
# 作为项目依赖安装
npm install --save-dev gulp
# 构建配置文件根目录创建gulpfile.js
var gulp = require('gulp');
gulp.task('default', function() { // 将你的默认的任务代码放在这 });
# 运行
gulp
```

## Webpack

所有小文件打包成一个或多个大文件

[入门Webpack](http://www.jianshu.com/p/42e11515c10f)

[Webpack for React](http://www.pro-react.com/materials/appendixA/)

[代码](https://github.com/bluebird89/webpack_for_react)

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
//全局安装
npm install -g webpack

npm init
// 安装Webpack
npm install --save-dev webpack
// 构建npm脚本
npm run dev
```

### 配置文件

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

### 组件

- webpack-dev-server：浏览器监听你的代码的修改，并自动刷新显示修改后的结果.
- babel：编译JavaScript的平台

  - 下一代的JavaScript代码（ES6，ES7...），即使这些标准目前并未被当前的浏览器完全的支持；
  - 使用基于JavaScript进行了拓展的语言，比如React的JSX；

- css-loader：能够使用类似@import 和 url(...)的方法实现 require()的功能。

- style-loader：所有的计算后的样式加入页面中，二者组合在一起使你能够把样式表嵌入webpack打包后的JS文件中

- CSS modules：通过CSS模块，所有的类名，动画名默认都只作用于当前模块。在CSS loader中进行配置后，你所需要做的一切就是把"modules"传递到所需要的地方，然后就可以直接把CSS的类名传递到组件的代码中，且这样做只对当前组件有效，不必担心在不同的模块中使用相同的类名造成冲突。

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

```
{
  ...
  "scripts": {
    "build": "webpack --optimize-minimize",
    "dev": "webpack-dev-server --config webpack.dev.config.js",
    "start": "npm run dev" // 或添加你自己的 start 逻辑
  },
  ...
}
```

在开发环境下的时候，你需要使用 npm run dev 来启动，而在生产环境中，则用 npm run build 来发布。

在真实场景中，我们不会直接使用 webpack-dev-server，而采用 express + webpack/webpack-dev-middleware

### 扩展功能

[webpack-dashboard](https://github.com/FormidableLabs/webpack-dashboard)
