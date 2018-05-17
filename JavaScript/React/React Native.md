# React Native

React 是一套可以用简洁的语法高效绘制 DOM 的框架

通过 React 来构建 iOS 原生应用和 Android 原生应用。Virtual DOM 保持不变，你仍然可以使用 JSX 来创建它，但实际的 UI 是用原生的组件构建，

RN是在Facebook所提出的核心概念Learn once, write anywhere所诞生的产物，着力于提高多平台开发的开发效率。我们可以同时为android和ios两个平台开发App，只需要根据两个平台不一样的地方去做一些调整即可。RN主要负责UI部分，而原生主要负责交互和数据处理。RN属于hybrid开发，并且与原生无缝连接，相比Web App和Native开发，RN取长补短，集合了两者的优势。RN开发的APP可以跳过App Store审核，远程更新代码，提高迭代频率和效率，既有Native的体验，又保留React的开发效率。
RN的原理是将React代码转化为原生API，iOS一套，Android一套。RN在一开始生成OC模块表，然后把这个模块表传入JS中，JS参照模块表，就能间接调用OC的代码。

围绕着React所建立起来的生态系统以及组件化开发思想能有效地分解大规模应用的复杂度、提高资源复用率。简单的说，React拥有以下你想要的特性：

* 同构渲染：服务器端和客户端共用一套代码，一份模板，两端使用。
* 完全组件化：自动分析加载页面的静态资源依赖。
* 生态圈：畅享所有 React 组件。
* 比webview 更好的体验，更好的性能，更好的手机交互
* 未来发展的一种趋势之一，提前了解学习，装13
* 解决项目中一些痛点，比如更新，ui方面的需求改动，丰富的运营手段。
* 由于 AppStore 审核周期的限制，如何动态的更改 app 成为了永恒的话题。无论采用何种方式，我们的流程总是可以归结为以下三部曲：“从 Server 获取配置 --> 解析 --> 执行native代码”。
    - 通过 HTTP 请求获取 JSON 格式的配置文件。
    - 配置文件中标记了每一个元素的属性，比如位置，颜色，图片 URL 等。
    - 解析完 JSON 后，我们调用 Objective-C 的代码，完成 UI 控件的渲染。

React是由Facebook开发出来的用于开发用户交互界面的JS库。其源码由Facebook和社区优秀的程序员维护。React带来了很多新的东西，例如组件化、JSX、虚拟DOM等。其提供的虚拟DOM使得我们渲染组件呈现非常之快，让我们从频繁操作DOM的繁重工作之中解脱。它做的工作更多偏重于MVC中的V层，结合其它如Flux等一起，你可以非常容易构建强大的应用。

React的世界里，一切都是组件。你可以构建任何直接的HTML没有的组件，例如下拉菜单、导航菜单等。同时，组件里也可以包含其它组件。每一个组件都有一个render方法，用于呈现该组件。同时，每一个组件都有属于自己的scope，从而与其它的组件界定开来，用于构建属于该组件的方法，以方便复用。JSX是基于JS的扩展，它允许你在JS里直接写HTML的代码，而不用像我们过去一样要想在JS里写HTML不得不拼接一大堆的字符串。React不直接操作DOM，频繁的操作DOM会非常影响性能和体验。React将DOM结构储存在内存中，与render方法的返回值进行比较，通过其自由的diff算法计算出不同的地方，然后反应到真实的DOM当中。也就是说，大多数情况我们渲染组件、更改组件状态等都是操作的虚拟DOM，只有在有所改变的情况下，才会反应到真实的DOM当中。React Native基于ReacJS，把 React 编程模式的能力带到移动开发,用来开发iOS和Android原生应用.

odeJs 是基于JavaScript的,可以做为后台开发的语言. 提供了很多系统级的API，如文件操作、网络编程等. 用事件驱动, 异步编程,主要是为后台网络服务设计.React Native 借助 Node.js，即 JavaScript 运行时来创建 JavaScript 代码。

总结来说，React Native使用NodeJS来做系统处理，使用React来渲染。

## [安装](https://facebook.github.io/react-native/docs/getting-started.html)

### windows

- Chocolatey（ 基于Nuget的Windows包管理工具）安装与使用

```sh
// 以管理员身份运行cmd：
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

// choco install/uninstall/upgrade package/package
choco install python2
choco install nodejs  // 优化npm镜像
choco install jdk8
```

- 安装 Android Studio

  - Android Studio的欢迎界面中选择Configure | SDK Manager

    - SDK Platforms(Android 6.0 (Marshmallow):Show Package Details)

      - Google APIs
      - Android SDK Platform 23
      - Intel x86 Atom_64 System Image
      - Google APIs Intel x86 Atom_64 System Image

    - SDK Tools(Show Package Details)

      - Android SDK Build-Tools:23.0.1

  - 添加用户变量ANDROID_HOME，sdk地址：D:\Tool\Android\sdk

  - 新建项目运行，保证有物理机或者一个AVD

- 项目构建

```sh
// 安装react-native-cli
npm install -g react-native-cli
// 初始化项目
react-native init AwesomeProject
//  运行应用
cd AwesomeProject
react-native run-android
react-native run-ios

sudo xcode-select -s /Applications/Xcode8.1.app/Contents/Developer/    # （红色部分是你实际的xcode app的名称）


lsof -i tcp:8081
```

### Mac

```shell
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install node
npm config set registry https://registry.npm.taobao.org --global
npm config set disturl https://npm.taobao.org/dist --global

npm install -g yarn react-native-cli
yarn config set registry https://registry.npm.taobao.org --global
yarn config set disturl https://npm.taobao.org/dist --global
sudo chown -R `whoami` /usr/local

brew install watchman # 监视文件系统变更的工具。安装此工具可以提高开发时的性能（packager可以快速捕捉文件的变化从而实现实时刷新）
brew install flow # 静态的JS类型检查工具
xcode

apm install nuclide # 由Facebook提供的基于atom的集成开发环境，可用于编写、运行和 调试React Native应用

react-native init AwesomeProject  ＃ 新建一个项目
cd AwesomeProject
react-native run-android
react-native run-ios
```


## 开发基础

### JSX

react.js 、react-dom.js 和 Browser.js ，它们必须首先加载。其中，react.js 是 React 的核心库，react-dom.js 是提供与 DOM 相关的功能，Browser.js 的作用是将 JSX 语法转为 JavaScript 语法
写 HTML 标签或 React 标签，它们终将被转换成原生的 JavaScript 并创建 DOM。

```typescript
<script type="text/babel">
  // ** Our code goes here! **
</script>

ReactDOM.render(
  <div>
  {
    names.map(function (name) {
      return <div>Hello, {name}!</div>
    })
  }
  </div>,
  document.getElementById('example')
);

```


### 组件

```typescript
var HelloMessage = React.createClass({
  render: function() {
    return <h1>Hello {this.props.name}</h1>;
  }
});

ReactDOM.render(
  <HelloMessage name="John" />,
  document.getElementById('example')
);
```


### 布局

#### Flexbox

Flexbox 是css3 里面引入的布局模型－弹性盒子模型，旨在通过弹性的方式来对齐河分布容器中的内容空间，使其能够适应不同屏幕的宽度。react nativie中 的flexbox 是这个规范的一个子集

Flexbox解决了什么问题？

* 浮动布局
* 不同宽度屏幕的适
* 宽度自动分配
* 水平垂直居中

容器属性

* flexDirection ： row,row-reverse,colum,colum-reverse   #类型于linerlayout 里的 orientation 属性
* flexWrap       :   wap,nowap,wap-reverse                      #textview 是否换行
* alignItems    ： flex-start,flex-end,center,stretch    # item 的 排列对齐方式 ，上对齐，下对齐 上下间距对齐， 以及严苛对其
* justifyContent：flex-start,flex-end,center,space-between,space-roud  # 类似于linerlayout里 layout_gravity 属性

元素属性

* flex          ：number                     #类型于weight 属性
* alignSelf     ：atuo,flex-start,flex-end,center,stretch  #类似于 gravity 属性
* flex－flow  flexDirection 和 flexWrap 属性 的简写形式，默认值为 row nowrap

![lifecycle](/path/to/RN-lifecycle.jpg "lifecycle")


## ReactJS

- 高效：React通过虚拟DOM和Diff算法，最大限度地减少与DOM的交互和渲染。——提高运行效率
- 组件化：通过 React 构建组件，使得代码更加容易复用，适应大型项目开发。——提高可维护性和复用性以及开发效率
- 模块化：通过模块化工具库来解决模块化问题——提高可维护性和复用性
- 单向数据流：React 实现了单向响应的数据流，从而减少了重复代码，这也是它为什么比传统数据绑定更简单。提高可维护性。

生命周期
![../_static/react_lifecircle.png]

## 组件

- React Router是React中使用的路由库，通过管理URL来管理组件及对应的状态。Router组件本身只是一个容器，真正的路由要通过Route组件定义。Router组件支持嵌套路由、支持通配符，能让你轻松控制整个项目的路由结构。
- Redux跟React没有直接的关系，本身可以支持React、Angular、Ember等等框架。Redux其实是Flux-like 更优雅的写法。通过react-redux这个库，可以方便的将react和redux结合起来：React负责页面展现，Redux负责维护/更新数据状态。大致过程为：当用户在View中触发事件产生Action，Action 进到 Reducer，Reducer根据Action Type去匹配对应处理的动作，然后返回一个新的状态。View则因为检测到状态更新而进行重绘。Redux只有一个Store负责存放整个App的状态，而唯一能改变状态的方法只有发送Action。Redux社区中使用比较多的库有：redux-sagas、redux-gen、redux-loop、redux-effects、redux-side-effects、redux-thunks、rx-redux、redux-rx…

## 前后端分离

阶段
- Web端通过ajax调用接口，使用JS把数据渲染到页面上
- 数据结构和业务逻辑混淆在一起

前后端分离的意义主要在于解耦，解耦后前后端职责划分更明确，前端能做的事也越来越多，比如我们可以在Node层做些监控和日志管理，将SSO登录集成进Node层，使用PM2对Node做多进程管理。这样之后，后端项目就可以做成”微服务”式的架构。
后端项目”微服务”式架构有如下优势：
- 每个项目都很有针对性，仅关注某个业务方向。
- 每个项目可由不同团队独立开发，互不影响，能快速响应需求、及时推出市场。
- 允许在频繁发布不同项目的同时保持系统其他部分的可用性和稳定性：依赖少、构建速度快 & 上线速度快。
- 前端只与Node中间层进行数据通信，Node层则通过thrift接口与后端服务进行数据通信；Node 中间层的 API 设计遵循 RESTFul 的架构风格，并且都以 /api/* 做为前缀；Node 中间层可以视情况添加缓存服务

架构图
![](../_static/front_back_seperate.png)

- Web端通过ajax调用接口，使用JS把数据渲染到页面上
- 数据结构和业务逻辑混淆在一起

## [facebookincubator/create-react-app](https://github.com/facebookincubator/create-react-app)

Create React apps with no build configuration.

```sh
npm install -g create-react-app

create-react-app my-app
cd my-app/
npm start
npm run eject #  导出配置文件
```


## 测试

使用Airbnb团队开发的enzyme，它也可以与其他测试工具如Jest、Mocha等配合使用。由于Jest是Facebook开发并且是在Jasmine测试框架上演变而来的，断言格式我们比较熟悉，因此大家可能更容易上手。Jest的目标是减少测试一个项目所要花费的时间和认知负荷，它提供了大部分我们需要的现成工具：快速的命令行接口、Mock工具集以及它的自动模块Mock系统，总的来说就是让测试变得更简单。

- [airbnb/enzyme](https://github.com/airbnb/enzyme):JavaScript Testing utilities for React http://airbnb.io/enzyme/

## 工具

* [storybooks/storybook](https://github.com/storybooks/storybook): Interactive development & testing environment for React, React-Native, Vue UI components https://storybook.js.org
* [reactjs/redux](https://github.com/reactjs/redux):Predictable state container for JavaScript apps http://redux.js.org
* [ReactTraining/react-router](https://github.com/ReactTraining/react-router):Declarative routing for React https://reacttraining.com/react-router/
* [aksonov/react-native-router-flux](https://github.com/aksonov/react-native-router-flux):First Declarative React Native Router
* [AllenFang/react-bootstrap-table](https://github.com/AllenFang/react-bootstrap-table):A Bootstrap table built with React.js https://allenfang.github.io/react-boo…
* [gaearon/redux-devtools](https://github.com/gaearon/redux-devtools):DevTools for Redux with hot reloading, action replay, and customizable UI http://youtube.com/watch?v=xsSnOQynTHs
* [akiran/react-slick](https://github.com/akiran/react-slick):React carousel component http://neostack.com/opensource/react-…
* [acdlite/redux-router](https://github.com/acdlite/redux-router):Redux bindings for React Router – keep your router state inside your Redux store
* [gabrielbull/react-desktop](https://github.com/gabrielbull/react-desktop):React UI Components for macOS Sierra and Windows 10 http://reactdesktop.js.org
* [react-boilerplate/react-boilerplate](https://github.com/react-boilerplate/react-boilerplate):A highly scalable, offline-first foundation with the best developer experience and a focus on performance and best practices. https://www.reactboilerplate.com
* [ant-design/ant-design](https://github.com/ant-design/ant-design):🐜 A UI Design Language http://ant.design
* [airbnb/react-dates](https://github.com/airbnb/react-dates):An easily internationalizable, mobile-friendly datepicker library for the web http://airbnb.io/react-dates
* [airbnb/lottie-android](https://github.com/airbnb/lottie-android):Render After Effects animations natively on Android and iOS, Web, and React Native http://airbnb.io/lottie/
* [airbnb/lottie-ios](https://github.com/airbnb/lottie-ios):An iOS library to natively render After Effects vector animations http://airbnb.io/lottie/
* [airbnb/react-native-maps](https://github.com/airbnb/react-native-maps):React Native Mapview component for iOS + Android
* [airbnb/native-navigation](https://github.com/airbnb/native-navigation):Native navigation library for React Native applications http://airbnb.io/native-navigation/
* [React Studio](https://reactstudio.com/)
* [maisano/react-router-transition](https://github.com/maisano/react-router-transition):painless transitions built for react-router, powered by react-motion
* [jaredpalmer/formik](https://github.com/jaredpalmer/formik):Build forms in React, without the tears sob https://npm.im/formik
* [Hacker0x01/react-datepicker](https://github.com/Hacker0x01/react-datepicker):A simple and reusable datepicker component for React https://reactdatepicker.com/
* [ptmt/react-native-macos](https://github.com/ptmt/react-native-macos):React Native for macOS is an experimental fork for writing desktop apps using Cocoa
* [GeekyAnts/NativeBase](https://github.com/GeekyAnts/NativeBase):Essential cross-platform UI components for React Native https://nativebase.io/
* [oblador/react-native-vector-icons](https://github.com/oblador/react-native-vector-icons):Customizable Icons for React Native with support for NavBar/TabBar/ToolbarAndroid, image source and full styling.
* [rt2zz/redux-persist](https://github.com/rt2zz/redux-persist):persist and rehydrate a redux store
* [react-navigation/react-navigation](https://github.com/react-navigation/react-navigation):Routing and navigation for your React Native apps https://reactnavigation.org
* [necolas/react-native-web](https://github.com/necolas/react-native-web):React Native for Web
* [react-native-training/react-native-elements](https://github.com/react-native-training/react-native-elements):Cross Platform React Native UI Toolkit
* [markerikson/react-redux-links](https://github.com/markerikson/react-redux-links):Curated tutorial and resource links I've collected on React, Redux, ES6, and more

## 参考

* [facebook/react](https://github.com/facebook/react):A declarative, efficient, and flexible JavaScript library for building user interfaces. https://reactjs.org
* [fangwei716/30-days-of-react-native](https://github.com/fangwei716/30-days-of-react-native)30 days of React Native demos
* [kdchang/reactjs101](https://github.com/kdchang/reactjs101):從零開始學 ReactJS（ReactJS 101）是一本希望讓初學者一看就懂的 ReactJS 中文入門教學書，由淺入深學習 ReactJS 生態系 (Flux, Redux, React Router, ImmutableJS, React Native, Relay/GraphQL etc.)。 https://www.gitbook.com/book/kdchang/…
* [Reactjs docs](https://reactjs.org/docs/hello-world.html)
* [reactjs/react-basic](https://github.com/reactjs/react-basic):A description of the conceptual model of React without implementation burden.
* [React 生态系统：从小白到大神](http://blog.csdn.net/gitchat/article/details/77978708)
* [React Native的极简手册](http://www.jianshu.com/p/318342e139c7) 没看懂
* [xgrommx/awesome-redux](https://github.com/xgrommx/awesome-redux):Awesome list of Redux examples and middlewares
* [camsong/redux-in-chinese](https://github.com/camsong/redux-in-chinese):Redux 中文文档 http://cn.redux.js.org/
* [reactnativecn/react-native-guide](https://github.com/reactnativecn/react-native-guide):React Native指南汇集了各类react-native学习资源、开源App和组件
* [styleguidist/react-styleguidist](https://github.com/styleguidist/react-styleguidist):Isolated React component development environment with a living style guide https://react-styleguidist.js.org/
* [wojtekmaj/react-lifecycle-methods-diagram](https://github.com/wojtekmaj/react-lifecycle-methods-diagram):Interactive React lifecycle methods diagram. http://projects.wojtekmaj.pl/react-li…
* [facebook/react-native](https://github.com/facebook/react-native):A framework for building native apps with React. http://facebook.github.io/react-native/
* [网站](http://facebook.github.io/react-native/)
* [react-native-elements](https://github.com/react-native-training/react-native-elements):Cross Platform React Native UI Toolkit https://react-native-training.github.…
* [jondot/awesome-react-native](https://github.com/jondot/awesome-react-native):Awesome React Native components, news, tools, and learning material! http://www.awesome-react-native.com
* [f8app](https://github.com/fbsamples/f8app)<http://makeitopen.com/>
* [facebook/react](https://github.com/facebook/react):A declarative, efficient, and flexible JavaScript library for building user interfaces. https://reactjs.org
* [设计含结构](https://github.com/airbnb/react-sketchapp)
* [文档](http://airbnb.io/react-sketchapp/docs/)
* [文档](http://reactnative.cn/docs/0.49/getting-started.html)
* [页面设计](https://github.com/ant-design/ant-design/)
* [react-native-guide](https://github.com/reactnativecn/react-native-guide)
* [react-native-macos](https://github.com/ptmt/react-native-macos)
* [enaqx/awesome-react](https://github.com/enaqx/awesome-react)A collection of awesome things regarding React ecosystem.
* [davezuko/react-redux-starter-kit](https://github.com/davezuko/react-redux-starter-kit):Get started with React, Redux, and React-Router.
* [vasanthk/react-bits](https://github.com/vasanthk/react-bits):✨ React patterns, techniques, tips and tricks ✨ https://vasanthk.gitbooks.io/react-bits
* [react-pxq](https://github.com/bailicangdu/react-pxq)一个 react + redux 的完整项目 和 个人总结
* [youzan/zent-kit](https://github.com/youzan/zent-kit)React 组件库开发脚手架
* [youzan/zent](https://github.com/youzan/zent)A collection of essential UI components written with React.
* [zeit/next.js](https://github.com/zeit/next.js):Framework for server-rendered React apps https://zeit.co/blog/next4
* [vhpoet/react-native-styling-cheat-sheet](https://github.com/vhpoet/react-native-styling-cheat-sheet):Most of the React Native styling material in one page
* [kriasoft/react-starter-kit](https://github.com/kriasoft/react-starter-kit):React Starter Kit — isomorphic web app boilerplate (Node.js, Express, GraphQL, React.js, Babel, PostCSS, Webpack, Browsersync) https://reactstarter.com
* [erikras/react-redux-universal-hot-example](https://github.com/erikras/react-redux-universal-hot-example):A starter boilerplate for a universal webapp using express, react, redux, webpack, and react-transform

## 项目

* [trazyn/ieaseMusic](https://github.com/trazyn/ieaseMusic):这应该是最好的网易云音乐播放器了，没有之一，如果有请打醒 🤘
* [Binaryify/NeteaseCloudMusicApi](https://github.com/Binaryify/NeteaseCloudMusicApi):网易云音乐nodejs api https://binaryify.github.io/NeteaseCl…
* [JonJam/yorpw_ui_web](https://github.com/JonJam/yorpw_ui_web):Password manager SPA built using React and Redux
* [JonJam/react-redux-ts](https://github.com/JonJam/react-redux-ts):React/Redux TypeScript starter project
* [taikongfeizhu/webpack-develop-startkit](https://github.com/taikongfeizhu/webpack-develop-startkit):webpack-develop-startkit
