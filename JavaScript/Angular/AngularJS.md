# Angular

* 渐进式Web应用：借助现代化Web平台的力量，交付app式体验。高性能、离线化、零安装。
* 原生：借助来自Ionic、NativeScript和React Native中的技术与思想，构建原生移动应用。
* 桌面：借助你已经在Web开发中学过的能力，结合访问原生操作系统API的能力，创造能在桌面环境下安装的应用，横跨Mac、Windows和Linux平台。
* 代码生成:Angular会把你的模板转换成代码，针对现代JavaScript虚拟机进行高度优化，轻松获得框架提供的高生产率，同时又能保留所有手写代码的优点。
* 统一:在服务端渲染应用的首屏，像只有HTML和CSS的页面那样几乎瞬间展现，支持node.js、.NET、PHP，以及其它服务器，为通过SEO来优化站点铺平了道路。
* 代码拆分:Angular应用通过新的组件路由（Component Router）模块实现快速加载，提供了自动拆分代码的功能，为用户单独加载它们请求的视图中需要的那部分代码。
* 模板:通过简单而强大的模板语法，快速创建UI视图。
* Angular命令行工具:命令行工具：快速进入构建环节、添加组件和测试，然后立即部署。
* 各种IDE:在常用IDE和编辑器中获得智能代码补全、实时错误反馈及其它反馈等特性。
* 测试:使用Karma进行单元测试，让你在每次存盘时都能立即知道是否弄坏了什么。Protractor则让你的场景测试运行得又快又稳定。
* 动画:通过Angular中直观简便的API创建高性能复杂编排和动画时间线 —— 只要非常少的代码。
* 可访问性:通过支持ARIA的组件、开发者指南和内置的一体化测试基础设施，创建具有完备可访问性的应用。

准备：NPM TypeScript

## 项目

```js
cd D:\\workspace\js
git clone https://github.com/angular/quickstart.git quickstart
cd quickstart
npm install   # 执行npm安装和配置
npm start     # 启动项目

npm run tsc # 单独编译Typescrip到Javascript。
npm run tsc:w # 单独编译Typescrip，并监控文件状态，发现文件变化重新编译
npm run lite  # 启动Server，在浏览器中查看效果。
npm test # 单元测试
npm run e2e  # E2E测试End-to-end
```

### 项目结构

* app/app.components.ts, 一个自定义组件，Typescript代码。
* app/app.module.ts, 模块文件，用于组合管理组件，Typescript代码。
* app/main.ts, 项目启动的入口，加载ts文件，Typescript代码。
* app/app.components.spec.ts, 单测试文件
* .gitignore, git的配置文件
* * index.html, 单页应用的html入口文件
* package.json, Node项目的工程配置文件
* tsconfig.json, Typescript语言的配置文件

## anjular-cli

嵌套了一层src目录，然后才是app目录。另外，多了angular-cli.json的配置文件。

```sh
npm install -g angular-cli

ng help
ng version
ng new conan1      // 新建项目
cd conan1
ng serve  # 启动项目
ng serve --host 0.0.0.0 --port 4201 --live-reload-port 49153
```

### 模块生成器

* component:组件，生成单独文件以及注册
* directive:属性型指令用于改变一个 DOM 元素的外观或行为。
* service:服务，可以封装代码，比如我们可以对数据访问代码单独隔离，封装到一个独立的服务中
* pipe:管道，可以用于数据的连续处理操作，比如可以把日期在界面端进行格式化

```shell
ng generate component my-new-component # 组件Component
ng generate directive my-new-directive # 指令Directive 
ng generate pipe my-new-service # 服务Service   
ng generate pipe my-new-pipe # 管道Pipe  
ng generate class my-new-class # 类Class  
ng generate interface my-new-interface # 接口Interface 
ng generate enum my-new-enum # 枚举对象Enum    
ng generate module my-module # 模块Module
```


## 资源

* [angular/angular.js](https://github.com/angular/angular.js):AngularJS - HTML enhanced for web apps! https://angularjs.org
* [angular/angular-cli](https://github.com/angular/angular-cli):CLI tool for Angular
* [angular/material](https://github.com/angular/material):Material design for AngularJS https://material.angularjs.org/
* [angular-ui/angular-google-maps](https://github.com/angular-ui/angular-google-maps):AngularJS directives for the Google Maps Javascript API http://angular-ui.github.io/angular-g…
* [shyamseshadri/angularjs-book](https://github.com/shyamseshadri/angularjs-book):Examples and Code snippets from the AngularJS O'Reilly book
* [angular/quickstart](https://github.com/angular/quickstart):Angular 2 QuickStart - source from the documentation

## 参考

* [Top 12 Productivity Tips for WebStorm and Angular – Part 1](https://www.sitepoint.com/productivity-tips-for-webstorm-and-angular-part-1/)
* [Angular2新的体验](http://blog.fens.me/angular2-init/)