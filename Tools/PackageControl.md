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

## Yarn

安装yarn( Yarn是Facebook提供的替代npm的工具，可以加速node模块的下载)与react-native-cli（React Native的命令行工具用于执行创建、初始化、更新项目、运行打包服务（packager）等任务）。快速(缓存它下载的每个包，所以不需要重复下载)、可靠(每个安装包的代码执行前使用校验码验证包的完整性)、安全的依赖管理(用一个格式详尽但简洁的 lockfile 和一个精确的算法来安装)

[中文文档](https://yarnpkg.com/zh-Hans/)

### 安装

```
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

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
