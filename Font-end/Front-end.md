# 前端工程师技能清单@udacity

## HTML

用来描述元素应该如何在网站上布局，并向浏览器提供网站所需的其他所有文件列表

- 语义元素： 语义元素明确地对浏览器和开发者描述其含义；元素包括文章和部分， 而不是到处使用 div
- 块级元素： 块级元素占据了父元素的整个空间
- 内嵌元素： 内嵌元素仅占据由内嵌元素定义标记界定的空间
- 表格：表格表示文档部分， 其中包含向网络服务器提交信息的交互式控件
- 输入类型： 输入元素用于为网络表格创建交互式控件， 以便接受用户输入的数据

### 定元素

## CSS

层叠样式表（简称 CSS）负责控制网站的外观。颜色、字体，甚至一些动画

- 显示值类型：显示属性使你能够控制图表或容器元素的渲染效果
- 盒模型：盒模型负责定义矩形框（表示文档中的元素）的尺寸
- 基本定位：定位属性会为定位元素选择替代规则

  - 静态定位：静态定位使元素能够使用常规行为
  - 绝对定位：不会为元素留空间，而是位于相对于祖先或容器块的特定位置
  - 固定：不会为元素留空间，而是位于相对于屏幕视口的特定位置
  - 弹性盒： 一种布局模式， 可以组织网页上的元素， 使元素行为能够符合预期， 这样网页布局就能够满足不同的屏幕大小和设备显示器的要求
  - 悬浮型：指定元素应该遵守常规版型，并放置在容器的左侧或右侧

- 字体样式和网络字体：字体样式使我们能够更改文本的外观；网络字体使我们能够加载只有部分客户端能使用的网络字体文件
- 背景：背景使我们能够定义用作容器背景的颜色或图片
- 伪选择器器：伪选择器使我们能够选择出现在HTML中定义的元素周围的假定元素
- 动画和过渡：动画和过渡使我们能够对元素设定动画效果或在元素的两个状态之间定义过渡

## CSS框架

框架使我们能够轻松地设计网站结构和构 建网站。 它们会提供自定义 CSS 类， 简化了内容布局操作， 确保无论是何种设备， 你的内容都能看起来很美观。 框架可以帮助你遵循行业最佳做法和现代设计原则

- Bootstrap
- Foundation

## JavaScript

负责控制网站的交互操作。

- 数据类型：该语言支持的不同变量类型（例如字符串和整型）
- 语法：定义如何组织语言的一般规则
- 函数：用来执行特定任务的代码块
- 字面值可以简化代码
- 对象字面值： JavaScript 中的所有内容都是对象， 但是自己编写对象
- 面向对象的编程： 在 JavaScript 中， 你可以采用多种方式来实现面向对象 的编程， 包括
- 函数方式、原型方式和伪类方式
- 设计模式：设计模式是可以重复利用的常见问题解决方案
- AJAX： AJAX 使我们能够异步地从网络服务器上请求数据，不需要重新加载网页
- jQuery： jQuery 是一种非常热门的库，使我们能够更轻松地进行跨浏览器 DOM 遍历和操作、处理事件和执行AJAX 操作

## JavaScript框架

会强制要求各种最佳做法，并且通常会强制要求我们在处理各种文件时遵守组织性格式，使我们能够轻松地编写网络应用

- AngularJS： 支持双向数据绑定，使你能够扩展 HTML 词汇以创建前端网络应用
- EmberJS： 通过使用严格的文件和对象命名规范，不用再使用样板代码
- KnockoutJS： 通过声明性绑定系统，使我们能更轻松地创建由数据驱动的应用

## 响应式网站设计

打开网站并缩小浏览器窗口大小，如何使网站能够缩放，并进行自我调整，从而在所有设备上都能提供超棒的体验

- @媒体查询：媒体查询使内容能够根据具体的输出设备的范围调整呈现方式，不用更改内容本身
- 相对大小单位： CSS 还提供了除像素 (px) 之外的很多其他衡量单位，例如 em、 rem、 vw、 vh 和 vmin

## 版本控制

### Git： Git 是一种分布式版本控制系统

- add
- clone
- commit
- push
- pull
- branch
- log

  #### GitHub

  一种 Git 资源库网络托管服务，提供各种其他功能，使开发者能够相互协作

- forking

- pull requests

  ### 网站性能

  理解几种简单的浏览器渲染原则， 你将能够确保向用户呈现快速、高效的网站

- 关键呈现路径： 关键呈现路径是浏览器用来将 HTML、 CSS 和 JavaScript转换成实际像素并发送到用户屏幕的流程

- 图片优化： 图片优化是针对图片内容使用正确的图片类型和从图片文件中移除多余的元数据的流程
- JavaScript 压缩： JavaScript 压缩是指从 JavaScript 文件中删除不必要的字符以减小文件大小的流程

## 浏览器开发者工具

提供了所有的详细信息，可以帮助你揭开代码的神秘面纱，是测试、衡量和迭代改进代码的重要平台

- 元素检测： 元素面板使你能够查看一个 DOM 树中的所有内容，并检查和在运行中修改 DOM 元素
- 网络： 网络面板可以录制关于应用中每项网络操作的信息
- 时间轴： 时间轴面板使你能够录制和分析应用在运行期间的所有活动
- 应用调试： 调试面板使你能够观察应用在运行期间消耗的内存
- 资源： 资源面板使你能够检测应用加载的资源

## 构建和自动化工具

需要运行测试套件、优化图片、遵守你所在单位的代码格式指南，甚至准备将代码部署到成品服务器上。还需要完成大 量的重复性甚至枯燥的工作。 Grunt 和 Gulp 等构建和自动化工具可以在后台帮你处理所有这些任务，使你能够专注于构建强大的网络应用。

- npm： npm 是 Node.js 的默认程序包管理器，后者是大多数构建和自动化工具编写代码时用到的框架
- Grunt： Grunt 是基于任务的命令行构建工具，可以与硬盘上的文件交互
- Gulp： Gulp 是基于程序的命令行构建工具，负责阅读硬盘上的文件，然后以流的形式与这些文件交互
- Bower： Bower 是 HTML、 CSS 和 JavaScript 库的程序包管理器，使你能够定义和检索依赖项并确定其版本

## 测试

当你的应用变得越来越复杂时，就很容易出现 bug，或者完全破坏现有的功能。单元、集成和行为测试是很棒的测试方法，可以确保你在添加新功能时不会破坏代码

- Mocha： Mocha 是一个 JavaScript 测试框架，在 Node.js 和浏览器中运行，使异步测试变得简单起来
- Jasmine： Jasmine 是一个开源、行为驱动的 JavaScript 测试框架

## 软技能

培养自己的沟通交流能力、指导和激励他人的能力，并能够从宏观层面看待工作，将使你成为潜在雇主青睐的候选人士。

- 善于沟通： 能够向庞大的团队（包括管理层、同事和客户）传达目标、进度和问题
- 灵活地处理问题： 了解问题背后的问题，并将问题分解成更小、更易解决的小问题
- 积极上进： 及时掌握这一领域的发展动态，并了解最新的技术发展状况
- 自我激励： 愿意实验和探索；勇于冒险，但是在面临挫折时能够坚持不懈

# 2.个人技能系统性进步与视野@杨文坚：

- 个人通用能力
- 技能知识点
- 工程业务经验
- 架构思想
- 先进方法与流程

## Javascript

### 自动化测试：单元测试 集成测试 浏览器测试

- mocha + should + node
- karma
- 链表，通过CI集成测试

### 知识点

- 奇怪的this
- 时间模型
- 生命提升
- 继承
- 跨域
- AJAX模型

### 异步流程控制

- Callback
- Genrator
- async function
- RxJS
- observable

### 模块化

- CommonJS
- AMD & CMD
- 加载器
- ES mould
- node模块转化CommonJS转化*MD

### 模板引擎

- Template & DOM Template
- 模板引擎优化
- 字符串模板输出React Comonent、VueComonent

## Webpack

- 用Webpack搭建一个项目
- 浏览器兼容性
- 搭建构建系统，通过测试用例

## 性能测试对比

- jsben.ch
- beachmark.js

## 基于缓存的前端性能优化

- HTTP 缓存
- LocalStorage
- App Cache
- Hybrid App 缓存
- Service Worker

## 加载优化

- lazyload
- 小图 -> 大图
- 预加载
- 异步加载
- MTU

## 优化案例

- 对象池优化
- 移动性能优化

## 前端上报技术

- 打点上报
- 错误上报
- 性能上报
- 跟踪用户操作
- 利用数据

## 安全

- CSRF
- CSRF防范技术
- XSS
- 富文本XSS防范

# (前端工程师技能图谱)[<https://github.com/TeamStuQ/skill-map/blob/master/data/map-FrontEndEngineer.md>]

## 浏览器

```
  - IE6/7/8/9/10/11 (Trident)
  - Firefox (Gecko)
  - Chrome/Chromium (Blink)
  - Safari (WebKit)
  - Opera (Blink)
```

## 编程语言

```
  - JavaScript/Node.js
  - CoffeeScript
  - TypeScript
```

## 切页面

```
  - HTML/HTML5
  - CSS/CSS3
  - Sass/LESS/Stylus
  - PhotoShop/Paint.net/Fireworks/GIMP/Sketch
```

## 开发工具

### 编辑器和IDE

```
- VIM/Sublime Text2
- Notepad++/EditPlus
- WebStorm
- Emacs EmacsWiki
- Brackets
- Atom
- Lime Text
- Light Table
- Codebox
- TextMate
- Neovim
- Komodo IDE / Edit
- Eclipse
- Visual Studio/Visual Studio Code
- NetBeans
- Cloud9 IDE
- HBuilder
- Nuclide
```

### 调试工具

- Firebug/Firecookie
- YSlow
- IEDeveloperToolbar/IETester
- Fiddler/Charles
- Chrome Dev Tools
- Dragonfly
- DebugBar
- Venkman

### 版本管理

- Git/SVN/Mercurial
- Github/GitLab/Bitbucket/Gitorious/GNU Savannah/Launchpad/SourceForge/TeamForge

## 代码质量

### Coding style

- Eslint/JSLint/JSHint/jscs
- CSSLint
- Markup Validation Service
- HTML Validators

### 单元测试

- QUnit/Jasmine
- Mocha/Should/Chai/Expect
- Unit JS

### 自动化测试

- WebDriver/Protractor/Karma Runner/Sahi
- phantomjs
- SourceLabs/BrowserStack

## 前端库/框架

- jQuery/Underscore/Mootools/Prototype.js
- YUI3/Dojo/ExtJS/KISSY
- Backbone/KnockoutJS/Emberjs
- AngularJS

  - Batarang

- Bootstrap
- Semantic UI
- Juice UI
- Web Atoms
- Polymer
- Dhtmlx
- qooxdoo
- React
- Brick
- Vue.js

## 前端标准/规范

- HTTP/1.1: RFCs 7230-7235
- HTTP/2
- ECMAScript 5/6/7
- W3C: DOM/BOM/XHTML/XML/JSON/JSONP/...
- CommonJS Modules/AMD
- HTML5/CSS3
- Semantic Web

  - MicroData
  - RDFa

- Web Accessibility

  - WCAG
  - Role Attribute
  - WAI-ARIA

## 性能

- JSPerf
- YSlow 35 rules
- PageSpeed
- HTTPWatch
- DynaTrace's Ajax
- 高性能JavaScript

## SEO

## 编程知识储备

- 数据结构
- OOP/AOP
- 原型链/作用域链
- 闭包
- 编程范型
- 设计模式
- Javascript Tips

## 部署流程

### 压缩合并

- YUI Compressor
- Google Clousure Complier
- UglifyJS
- CleanCSS

### 文档输出

- JSDoc
- Dox/Doxmate/Grunt-Doxmate

### 项目构建工具

- make/Ant
- GYP
- Grunt
- Gulp
- Yeoman
- FIS
- Mod
- Webpack

## 代码组织

### 类库模块化

- CommonJS/AMD/ES6 Module
- YUI3模块

### 业务逻辑模块化

- bower/component

### 文件加载

- LABjs
- SeaJS/Require.js/Webpack

### 模块化预处理器

- Browserify

## 安全

- CSRF/XSS
- CSP
- Same-origin policy
- ADsafe/Caja/Sandbox

## 移动Web

- HTML5/CSS3
- 响应式网页设计
- Zeptojs/iScroll
- V5/Sencha Touch
- PhoneGap (Cordova)
- Ionic
- jQuery Mobile
- W3C Mobile Web Initiative
- W3C mobileOK Checker
- Open Mobile Alliance

  - React Native/Weex

## 前沿技术社区/会议

- D2/WebRebuild
- NodeParty/W3CTech/HTML5梦工厂
- JSConf/沪JS(JSConf.cn)
- QCon/Velocity/SDCC
- JSConf/NodeConf
- CSSConf
- YDN/YUIConf
- HybridApp
- WHATWG
- MDN
- codepen
- w3cplus
- CNode

## 计算机知识储备

- 编译原理
- 计算机网络
- 操作系统
- 算法原理
- 软件工程/软件测试原理
- Unicode

## 软技能

- 知识管理/总结分享
- 沟通技巧/团队协作
- 需求管理/PM
- 交互设计/可用性/可访问性知识

## 可视化

- SVG/Canvas/VML
- SVG: D3/Raphaël/Snap.svg/DataV
- Canvas: CreateJS/KineticJS
- WebGL/Three.JS


所有客户端都是前端

## 扩展
- http://geek.csdn.net/news/detail/237049
- [dypsilon/frontend-dev-bookmarks](https://github.com/dypsilon/frontend-dev-bookmarks)
- [AlloyTeam/Mars](https://github.com/AlloyTeam/Mars)腾讯移动Web前端知识库
- [fex-team/webuploader](https://github.com/fex-team/webuploader)It's a new file uploader solution!
- [ECharts](https://github.com/ecomfe/echarts)ECharts is a free, powerful charting and visualization library offering an easy way of adding intuitive, interactive, and highly customizable charts to your commercial products.


## 面试

- [DDFE/DDFE-blog](https://github.com/DDFE/DDFE-blog)

## 前端工程化

### 开发需求
- 代码规范：ESLint是一个用来识别 ECMAScript 并且按照规则给出报告的代码检测工具，使用它可以避免低级错误和统一代码的风格。我们可以方便的在配置文件中配置自己想要的风格规范，通常推荐使用Airbnb JavaScript或者google的规范。
- CSS预处理：可以使用less或sass来优化css的开发过程，而如果考虑到浏览器兼容性的hack问题，我们可以用postcss作为预处理工具帮我们自动解决这些 hack。
- 热更新：hmr能够在感知你的代码有变动的情况下自动调用编译工具编译源码，然后通过 livereload 自动刷新浏览器，这样做的话能节省你的调试时间。
- Mock：由于采用了前后端分离的开发模式，在真实开发中，为了让前端开发不受后端进度的影响，我们需要对数据进行mock。前后端先约定API 接口定义，然后前端根据定义mock 接口。一般大公司会有自己的mock平台，小公司如果没有的话也可以使用开源的mock工具。

### 共享需求
对于公司而言，快速高效地实现业务是终极目标，这对前后端来说都是挑战。在前端团队中，能够形成基础组件库和业务组件库是一种必然需求。
所以在设计前端项目架构的时候，一定要考虑业务的组件化和可共享性。有人说开发通用组件是造轮子，其实造出符合自己的轮子何尝不是一种领悟。共享需求主要有四种：基础代码共享、通用工具方法共享、基础交互组件共享以及业务组件共享。
在组件方面，React提供了天然的组件结构，我们只需要在开发过程中，隐藏组件的内部实现，每个组件更独立，很容易形成可重用组件。

### 性能需求
构建过程中使用Grunt/Gulp、webpack等构建工具实现。

- JS/CSS 代码压缩
- JS/CSS 代码合并
- 图片压缩
- CSS 图片精灵或雪碧图

### 部署需求
会用代码管理工具来管理源码，然后将开发流程和部署流程与git结合起来。多人分支协作流程：用git flow来管理代码分支。


## 文档
- [Web technology for developers](https://developer.mozilla.org/en-US/docs/Web)

## 参考
- [从软件工程角度看大前端技术栈](http://blog.csdn.net/gitchat/article/details/77199990)
