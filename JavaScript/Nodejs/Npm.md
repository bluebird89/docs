# npm

Node.js的包管理工具（node package manager）。

Node的包描述文件是一个JSON文件，用于描述非代码相关的信息。而NPM则是一个根据包规范来提供Node服务的Node包管理器。它解决了依赖包安装的问题，却面临着两个新的问题：

* 安装的时候无法保证速度和一致性。
* 安全问题，因为NPM安装时允许运行代码。
* 大家都把自己开发的模块打包后放到npm官网上，如果要使用，直接通过npm安装就可以直接用，不用管代码存在哪，应该从哪下载。
* npm可以根据依赖关系，把所有依赖的包都下载下来并管理起来。

## 使用

```sh
npm -v
npm init  # 创建一个npm项目,配置项目信息，在package.json文件
npm install react react-dom --save # 安装依赖
npm i -g npm # npm更新
```

## npm

node的包管理工具。配置文件`package.json` scripts：script会安装一定顺序寻找命令对应位置，本地的node_modules/.bin路径就在这个寻找清单中.`npm run {script name}`,将构建命令提到外部指令来

```sh
# npm设置镜像加速
npm config set registry https://registry.npm.taobao.org --global
npm config set disturl https://npm.taobao.org/dist --global
```

## 代码

- [npm/npm](https://github.com/npm/npm):a package manager for javascript <http://www.npmjs.com/>
