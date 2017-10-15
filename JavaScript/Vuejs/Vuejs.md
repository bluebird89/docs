# vue

官方文档为基本应用，扩展为模板与wepack方面的扩展,核心webpack.js的配置

- 全局安装脚手架：sudo npm install -g vue-cli vue-router vuex vue-resource vue-loader webpack
- 以webpack模板初始化项目： vue init webpack sell：程序文件名称
- 模块安装：npm insall
- 运行开发者模式：npm run dev(代码实时更新)
- 打包文件：npm run build，包含index文件与dist资源包

## 项目：

- [官方教程](https://cn.vuejs.org/v2/guide/)
- [webpack-simple](https://github.com/vuejs-templates/webpack-simple)
- [pwa](https://github.com/vuejs-templates/pwa) progressive-web-apps
- [vuejs-templates/webpack](https://github.com/vuejs-templates/webpack):通过webpack打包的vuejs模版
- [awesome-vue](https://github.com/vuejs/awesome-vue)
- [ElemeFE/cooking](https://github.com/ElemeFE/cooking)
- [PanJiaChen/vue-element-admin](https://github.com/PanJiaChen/vue-element-admin)
- [vue2-happyfri](https://github.com/bailicangdu/vue2-happyfri)vue2 + vue-router + vuex 入门项目
- [vue2-elm](https://github.com/bailicangdu/vue2-elm)基于 vue2 + vuex 构建一个具有 45 个页面的大型单页面应用

## 重构

- [tonyfree/youzan](https://github.com/tonyfree/youzan)

### App 流程

- 需求分析
- 脚手架工具
- 数据mock
- 架构设计
  - 模块拆分
  - 组件抽象
- 代码编写
- 自测
- 编译打包

### 组件

- vue-resource
- vue-router
- better-scroll

- 工程化

- 模块化

- 组件化

## 使用

* 定义View
* 定义Model
* 创建一个Vue实例或"ViewModel"，它用于连接View和Model

### 语法

```
<input type="text" v-model="message"/>  //创建双向数据绑定
<h1 v-if="age >= 25">Age: {{ age }}</h1> //  条件渲染指令，它根据表达式的真假来删除和插入元素
<h1 v-show="age >= 25">Age: {{ age }}</h1> //  指令的元素始终会被渲染到HTML，它只是简单地为元素设置CSS的style属性。
用v-else指令为v-if或v-show添加一个“else块”。v-else元素必须立即跟在v-if或v-show元素的后面——否则它不能被识别。
v-for="item in items" // v-for指令基于一个数组渲染一个列表
v-bind:argument="expression"  // 指令可以在其名称后面带一个参数，中间放一个冒号隔开，这个参数通常是HTML元素的特性（attribute） 简写为 ：
<a v-on:click="doSomething">   // v-on指令用于给监听DOM事件，它的用语法和v-bind是类似的，例如监听<a>元素的点击事件   简写为@

```

数据绑定最常见的形式就是使用 "Mustache" 语法：{{}}

### 特点

- 数据驱动
- 组件化

### npm源替换`nmp install -g --registery= https://registery.npm.taobao.org`

### webstrom设置

- 添加vuejs插件
- File Types配置 将.vue格式的文件注册为HTML文件类型

### 添加插件

- package.json中添加"stylus-loader": "^1.4.0"，npm install安装插件

## 组件

* [Vuex](https://vuex.vuejs.org/zh-cn/)

## 工具

- vetur：vscode插件


## 参考

* [Vue.js——60分钟快速入门](http://www.cnblogs.com/keepfool/p/5619070.html)


## todo

- [vue-element-admin](https://github.com/PanJiaChen/vue-element-admin)
- [JavaScript 进阶之 Vue.js + Node.js 入门实战开发](http://blog.csdn.net/gitchat/article/details/77931664)
- http://www.cnblogs.com/keepfool/

