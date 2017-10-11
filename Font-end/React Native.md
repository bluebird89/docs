# React Native

通过 React 来构建 iOS 原生应用和 Android 原生应用。Virtual DOM 保持不变，你仍然可以使用 JSX 来创建它，但实际的 UI 是用原生的组件构建，

RN是在Facebook所提出的核心概念Learn once, write anywhere所诞生的产物，着力于提高多平台开发的开发效率。我们可以同时为android和ios两个平台开发App，只需要根据两个平台不一样的地方去做一些调整即可。RN主要负责UI部分，而原生主要负责交互和数据处理。RN属于hybrid开发，并且与原生无缝连接，相比Web App和Native开发，RN取长补短，集合了两者的优势。RN开发的APP可以跳过App Store审核，远程更新代码，提高迭代频率和效率，既有Native的体验，又保留React的开发效率。 
RN的原理是将React代码转化为原生API，iOS一套，Android一套。RN在一开始生成OC模块表，然后把这个模块表传入JS中，JS参照模块表，就能间接调用OC的代码。

围绕着React所建立起来的生态系统以及组件化开发思想能有效地分解大规模应用的复杂度、提高资源复用率。简单的说，React拥有以下你想要的特性：

- 同构渲染：服务器端和客户端共用一套代码，一份模板，两端使用。
- 完全组件化：自动分析加载页面的静态资源依赖。
- 生态圈：畅享所有 React 组件。

## 资源

- [react-native](https://github.com/facebook/react-native)
- [网站](http://facebook.github.io/react-native/)
- [react-native-elements](https://github.com/react-native-training/react-native-elements)
- [awesome-react-native](https://github.com/jondot/awesome-react-native)
- [f8app](https://github.com/fbsamples/f8app)<http://makeitopen.com/>
- [仓库](https://github.com/facebook/react)
- [设计含结构](https://github.com/airbnb/react-sketchapp)
- [文档](http://airbnb.io/react-sketchapp/docs/)
- [页面设计](https://github.com/ant-design/ant-design/)
- [react-native-guide](https://github.com/reactnativecn/react-native-guide)
- [react-native-macos](https://github.com/ptmt/react-native-macos)
- [storybook](https://github.com/storybooks/storybook)
- [jondot/awesome-react-native](https://github.com/jondot/awesome-react-native)
- [enaqx/awesome-react](https://github.com/enaqx/awesome-react)A collection of awesome things regarding React ecosystem.
- [davezuko/react-redux-starter-kit](https://github.com/davezuko/react-redux-starter-kit)

## [安装](https://facebook.github.io/react-native/docs/getting-started.html)

- Chocolatey（ 基于Nuget的Windows包管理工具）安装与使用

```
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

```
// 安装react-native-cli
npm install -g react-native-cli
// 初始化项目
react-native init AwesomeProject
//  运行应用
cd AwesomeProject
react-native run-android
```


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

## 测试

使用Airbnb团队开发的enzyme，它也可以与其他测试工具如Jest、Mocha等配合使用。由于Jest是Facebook开发并且是在Jasmine测试框架上演变而来的，断言格式我们比较熟悉，因此大家可能更容易上手。Jest的目标是减少测试一个项目所要花费的时间和认知负荷，它提供了大部分我们需要的现成工具：快速的命令行接口、Mock工具集以及它的自动模块Mock系统，总的来说就是让测试变得更简单。

## 扩展

- [youzan/zent-kit](https://github.com/youzan/zent-kit)React 组件库开发脚手架
- [youzan/zent](https://github.com/youzan/zent)A collection of essential UI components written with React.


## 项目

- [react-pxq](https://github.com/bailicangdu/react-pxq)一个 react + redux 的完整项目 和 个人总结


## 参考

- [React 生态系统：从小白到大神](http://blog.csdn.net/gitchat/article/details/77978708)
- [React Native的极简手册](http://www.jianshu.com/p/318342e139c7)
