# [bootstrap](https://github.com/twbs/bootstrap)

The most popular HTML, CSS, and JavaScript framework for developing responsive, mobile first projects on the web. <http://getbootstrap.com>

* 特性
  - 移动设备优先:先满足小屏幕移动设备（手机、平板），再去扩展里面的components去满足大屏幕设备（笔记本、台式机）
    + 内容 Content
    + 布局 Layout
      * 优先设计更小的宽度
      * Base CSS强调移动设备；中等关注平板、电脑
    + 渐进增强 Progressive Enhancement 随着屏幕大小增加而添加元素
  - 漂亮的设计
  - 友好的学习曲线
  - 卓越的兼容性
  - 响应式设计:
  - 12列响应式栅格结构
  - 样式向导文档
* 排版、链接样式设置了基本的全局样式:保留和坚持部分浏览器的基础样式，解决部分潜在的问题，提升一些细节的体验，在排版、链接样式设置了基本的全局样式
  - 移除body的margin声明
  - 设置body的背景色为白色 background-color: #fff;
  - 为排版设置了基本的字体、字号和行高
  - 设置全局链接颜色，且当链接处于悬浮:hover状态时才会显示下划线样式
* 栅格系统是Bootstrap中的核心，正是因为栅格系统的存在，Bootstrap才能有着如此强大的响应式布局方案。Bootstrap 提供了一套响应式、移动设备优先的流式栅格系统，随着屏幕或视口（viewport）尺寸的增加，系统会自动分为最多12列。包含了用于简单的布局选项的预定义类，也包含了用于生成更多语义布局的功能强大的混合类
* 基础CSS代码默认从小屏幕设备（比如移动设备、平板电脑）开始，然后使用媒体查询扩展到大屏幕设备（比如笔记本电脑、台式电脑）上的组件和网格
* 策略
  - 内容：决定什么是最重要的
  - 布局：优先设计更小的宽度
  - 渐进增强：随着屏幕大小增加而添加元素

## 安装

```sh
brew install bootstrap
npm install bootstrap@3
```

## 引入

```html
<!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
<!-- 可选的 Bootstrap 主题文件（一般不用引入） -->
<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
```

## 原理

* 布局容器container:只有放在带 container or container-fluid类的 <div>标签里面的html代码才会被Bootstrap识别
  - container类还设置了媒体查询:在浏览器viewport宽度768~992px区间宽度固定为750px，在992~1200px区间宽度宽度固定为970px，大于1200px的时候宽度固定为1170px，所以container类在viewport大于768px的时候会有变化的左右margin
  - container-fluid类没有媒体查询设置，所以始终是100%宽度，没有左右margin
* 数据行（.row）必须包含在容器.container（固定宽度）或.container-fluid（100%宽度）中，以便为其赋予合适的排列（aligment）和内填充（padding）
* 在数据行（.row)中可以添加列（column），但列数之和不能超过平分的总列数（在超过时，多余部分会换行显示），默认12
  - 页面上的具体内容应当放置于列（column）内，并且只有列（column）可以作为数据行.row容器的直接子元素
  - 预定义的网格类，比如 .row 和 .col-xs-4，可用于快速创建网格布局
  - 列是通过指定1到12的值来表示其跨越的范围。例如，三个等宽的列可以使用三个.col-xs-4来创建
  - 如果一“行（row）”中包含了的“列（column）”大于 12，多余的“列（column）”所在的元素将被作为一个整体另起一行排列。
  - 媒体查询（media query）的基本结构，根据查看网页的设备的某些重要信息（比如屏幕大小、分辨率、颜色位深等），页面可以分别应用不同的样式甚至替换整个样式表
* 列偏移 offset
  - 需要给需要偏移的列元素上添加类名 col-md-offset-*(星号代表要偏移的列组合数)，那么具有这个类名的列就会向右偏移，通过使用* 选择器为当前元素增加了左侧的边距（margin）。例如：在列元素中添加.col-md-offset-6 类将 .col-md-6元素向右侧偏移了6个列（column）的宽度
* 列嵌套
  - 可以在一个列中添加一个或者多个行（.row）容器，然后在这个行容器中插入列
  - 在列容器中的行容器（.row），宽度为100%时，就是当前外部列的宽度
* 列排序
  - 改变列的方向，就是改变左右浮动，并且设置浮动的距离.通过添加类名 col-md-push-*和 col-md-pull-* (其中星号代表移动的列组合数)

## 教程

* [http://learnbootstrap.today/](http://learnbootstrap.today/):图书

## 扩展

## 工具

* [bootstrapstudi](https://bootstrapstudio.io/)
* [bootstrap-material-design](https://github.com/FezVrasta/bootstrap-material-design)

* [startbootstrap-sb-admin-2](https://github.com/BlackrockDigital/startbootstrap-sb-admin-2):A free, open source, Bootstrap admin theme created by Start Bootstrap <https://startbootstrap.com/themes/sb-admin-2/>
* [ace](https://github.com/bopoda/ace):Twitter bootstrap 3 admin template <http://ace.jeka.by>
* [almasaeed2010/AdminLTE](https://github.com/almasaeed2010/AdminLTE):AdminLTE - Free Premium Admin control Panel Theme Based On Bootstrap 3.x <https://adminlte.io>
* [ColorlibHQ/AdminLTE](https://github.com/ColorlibHQ/AdminLTE):AdminLTE - Free Premium Admin control Panel Theme Based On Bootstrap 3.x <https://adminlte.io>
* [pi-hole/AdminLTE](https://github.com/pi-hole/AdminLTE)

## 参考

* [文档](http://getbootstrap.com/)
* [Bootstrap 4: Everything You Need to Know](https://medium.freecodecamp.org/bootstrap-4-everything-you-need-to-know-c750991f6784)
