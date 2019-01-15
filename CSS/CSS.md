# CSS Cascading Style Sheet层叠样式表。

* CSS主要用来控制各个元素(标记)的外观的。
* HTML控制内容的结构。
* JS给各个元素添加行为(动作)的。
* “层叠”是指多个外层元素的样式，会被内层元素去继承。
* “样式”，主要指外观。包括：字体、文本、背景图片、定位、浮点等。

## 格式

* 选择器:选择某一个HTML标记
    - 通配符:*
    - 标签选择器:p
    - 类选择器:.box
    - id选择器:#box
    - 多元素选择器:body , p ,  .box  , #header 通过逗号分隔
    - 后代元素选择器（某个元素的所有后代元素）:body div 通过空格分隔
    - 子元素选择器（当前元素的子元素）：div > h2
    - 伪类选择器，一般是用来选择<a>元素的
        + link 正常链接效果。
        + hover 鼠标放上的效果
        + visited 访问过的效果
        + active 激活状态
* 属性名:属性值构成

```css
* {color:red}
h1 {color:red; font-size:14px;}
.box{color:red;}
div.box{color:red;}  //给 class = box 的<div>元素加样式
#box{color:red;}  //给 id=box 元素加样式

body , p ,  .box  , #header {color:red;}
.box .header{color:red;}
div > h2{color:red;}
```

## 属性

* 尺寸属性
    - width：元素的宽度。
    - height：元素的高度。
* 字体属性
    - `font-size`：文字大小。
    - `font-weight`：加粗效果。取值：bold
    - `font-style`：斜体效果。取值：italic
    - `font-family`：字体。
* 文本属性
    - color：文本颜色。
    - `line-height`：行高，可以是百分比，也可以是固定值。
    - `text-align`：文本的水平对齐方式，取值：left、center、right
    - `letter-spacing`：字间距。
    - `text-decoration`：文本修饰线，取值：underline(下划线)、none、overline(上划线)、line-through(删除线)
    - `text-indent`：首行缩进。
* 边框属性
    - border-left border-right border-top border-bottom
        + 格式：border-left: 粗细 线型 颜色;
        + 线型：none(无线)、solid(实线)、dotted(点状线)、dashed(虚线)、double(双线)
        + 注意：多个参数值之间用空格隔开。
        + 举例：div{border-left:5px solid red;} div{border:2px solid blue;}
* 内填充属性：边线到内容间的距离
  + padding-left padding-right padding-top padding-bottom
* 外边距属性：边框线往外的距离
  - 垂直方向上的外边距相遇时将会发生折叠。这意味着如果一个元素的下边距遇到了另一个元素的上边距，那么二者中较大的一个将被留下

```css
h1{
    padding:10px; //四个内填充都是10px
    padding:10px 20px; //上下内填充为10px，左右内填充为20px
    padding:5px 10px 15px; //上填充为5px，左右为10px，下为15px
    padding:5px 10px 15px 20px;  //顺序一定为：上右下左
}
```

## 元素组合

* 块元素
    - 块元素单独占一行。
    - 块元素左右都有换行符。
    - 块元素可以设置width和height属性。
    - 常用的块元素有哪些？<div>、<p>、<h1>、<table>、<form>、<ul>、<ol>、<li>、<pre>等
* 行内元素
    - 行内元素不会单独占一行，多个行内元素会排在同一行。
    - 行内元素没有width和height属性。
    - 行内元素有哪些？<span>、<font>、<b>、<i>、<u>、<s>、<a>、<input>、<label>、<img>等
* <div>和<span>是没有意义的标记，但是又使用最多的
* <img>和<input>是行内块元素(inline-block)，也有width和height

## 样式管理

- 内联样式- 在HTML元素中使用"style" 属性
- 内部样式表 -在HTML文档头部 区域使用

用 CSS 最大的好处是，如果把 CSS 代码存放到外部样式表中，那么站点会更易于维护 最常用于图片操作、表单验证以及内容动态更新

```html
  <style> 元素 来包含CSS</li>
  <li>外部引用 - 使用外部 CSS 文件</li>
  <li>外部样式表(External style sheet)&lt;内部样式表(Internal style sheet)&lt;内联样式(Inline style)</li>
  </ul>
  <h4 id="-">　选择器　</h4>
  <ul>
  <li><h1 id="id">id</h1>
  </li>
  <li>.class</li>
  <li><p>tag.class</p>
  <h3 id="-">清除浮动</h3>
  <p>浮动产生原因：一个子盒子使用了CSS float浮动属性，导致父级对象盒子不能被撑开
  解决办法：清楚浮动</p>
  <p>  <style type="text/css"></p>
  <pre><code>      .outer{border: 1px solid #ccc;background: #fc9;color: #fff; margin: 50px auto;padding: 50px;}
        .div1{width: 80px;height: 80px;background: red;float: left;}
        .div2{width: 80px;height: 80px;background: blue;float: left;}
        .div3{width: 80px;height: 280px;background: sienna;float: right;}
        .clear{clear:both; height: 0; line-height: 0; font-size: 0}
    &lt;/style&gt;
  </code></pre>  <div class="outer">
        <div class="div1">1</div>
        <div class="div2">2</div>
        <div class="div3">3</div>
        <div class="clear"></div>
    </div>
  </li>
  </ul>
  </style>
```

## 自适应网页设计（Responsive Web Design)

一次设计，普遍适用，可以自动识别屏幕宽度、并做出相应调整的网页设计。

## 显示

- 像素（pixels）：显示器上的图像是由许多点构成的，这些点称为像素，意思就是"构成图像的元素"。500×300像素，是分辨率的尺寸单位。是指在由一个数字序列表示的图像中的一个最小单位
- 像素每英寸PPI（pixels per inch）为单位来表示影像分辨率的大小。

## 设备：

- mobile
- PC

- 实现：

  - 头部添加标签，viewport是网页默认的宽度和高度，上面这行代码的意思是，网页宽度默认等于屏幕宽度（width=device-width），原始缩放比例（initial-scale=1）为1.0，即网页初始大小占屏幕面积的100%。网页会根据屏幕宽度调整布局，所以不能使用绝对宽度的布局，也不能使用具有绝对宽度的元素，使用百分比或auto，字体使用相对大小（em）；

    ```html
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    ```

  - 流动布局：各个区块的位置都是浮动的，不是固定不变的。如果宽度太小，放不下两个元素，后面的元素会自动滚动到前面元素的下方，不会在水平方向overflow（溢出），避免了水平滚动条的出现。

  - "自适应网页设计"的核心，就是CSS3引入的Media Query模块。它的意思就是，自动探测屏幕宽度，然后加载相应的CSS文件。

    ```html
    <link rel="stylesheet" type="text/css"
    　　　　media="screen and (min-width: 400px) and (max-device-width: 600px)"
    　　　　href="smallScreen.css" />
    @import url("tinyScreen.css") screen and (max-device-width: 400px);
    ```

  - CSS实现

    ```css
    @media screen and (max-device-width: 400px) {
    　　　　.column {
    　　　　　　float: none;
    　　　　　　width:auto;
    　　　　}
    　　　　#sidebar {
    　　　　　　display:none;
    　　　　}
    　　}
    ```

  - 图片 视频的自动缩放

    ```html
    img, object { max-width: 100%;}

    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet">
    <style>
      .red-text {
        color: red;
      }
      h2{
        font-family: Lobster;
      }
      p {
        font-size: 16px;
        font-family: Monospace;
      }
    </style>
    ```

## 盒子模型

* box-sizing：有利于样式化，而且你在也不用做乏味的数学运算
  - content-box(default) - 当我们为元素设置了宽度和高度，但那只是内容的尺寸。所有的 padding 和 border 都在不包含在内容当中，也就是在内容的外部。
  - border-box - padding和 border 被包含在 宽度和高度当中。 如果一个 div 的宽度为 100px ，而被设置了 box-sizing: border-box， 那么它的宽度将始终是 100px， 无论你添加多少 padding 和 border 。

## Flex

## 执行 CSS 重置

各浏览器的默认行为还是存在很多分歧。解决这个问题最好的办法就是使用一个 CSS 重置文件为所有元素重新设置默认样式

```css
* {

      margin: 0;

      padding: 0;

      box-sizing: border-box;

  }
```

## CSS

- color background-color font-size border
- 行内样式>内嵌样式 >外部样式> 用户样式（user stylesheets\custom.CSS）>浏览器样式
- 选择器：
  - *
  - 复杂度与搜索时间有关 [attr] [attr='val'] [attr$='val'] [attr^='val']
  - 关系选择器：后代：
  - stylus less sass
  - 伪元素： ：active ：hover
  - 联合选择器 ： \
  - 同级样式会对比专一程度： id>其他属性与伪类个数>元素名字与伪元素名字个数
- 样式层叠器
- 样式单位
  - 颜色： 颜色white 十六进制#ffffff 十进制255,255,255 rgb（112,128.144,0.4） hsl(h, s, l)
  - 长度：
    - 绝对 in cm mm pt磅 pc皮卡
    - 相对(另一个尺寸倍数) em相对元素字号高度 ex rem px像素 %

## image

* 概念
  * 固有尺寸：是固有宽度、固有高度和固有宽高比的集合。对于特定对象，这三个尺寸可能都存在，也可能都不存在。比如光栅图像同时拥有这三个，SVG 图像只有固有宽高比，CSS 渐变就没有任何固有尺寸
  * 指定大小：是通过width  height  background-size中的一个或多个指定的。
  * 默认对象大小：是一个具有确定宽高的矩形。在既没有固有尺寸，也没有指定大小时生效。
  * 具体对象大小：是对象最终显示的大小，即有明确宽度和高度值的矩形。
+ 显示效果:算它最终的“具体对象大小”
  * 优先使用指定大小，得到要显示的宽和高
  - 如果只指定了一个宽度，或只指定了一个高度，那么
    + 如果有固有宽高比，则用它和给出的那个，计算出来另一个
    + 否则，就取固有尺寸里的
    + 如果也没有固有尺寸，那就取默认对象大小的
  - 如果没有指定大小
    + 先用固有尺寸里的
    + 如果没有固有尺寸，那就取默认对象大小的
  - 指定大小 > 固有尺寸 > 默认对象大小
  - 图像超出背景区域的部分，会被裁剪掉；覆盖不全的部分，会用背景色来填充
  - 当是<img>时，也有个相应的属性可以调整图像大小，即 object-fit
  - 调整图像大小的属性background-size
* image
  * width height
* background-image
  - background-size属性提供指定大小
    + 包含约束（contain constraint ）遵循固有宽高比，宽高都小于等于背景区域，然后尽可能的大。
    + 覆盖约束（cover constraint）遵循固有宽高比，宽高都大于等于背景区域，然后尽可能的小。

```html
<img src="https://p1.ssl.qhimg.com/t01068da1826ad05875.png"> <!-- 宽 54px，高 49px -->
<img src="https://p1.ssl.qhimg.com/t01068da1826ad05875.png" width="30" height="30"> <!-- 宽 30px，高 30px -->
<img src="https://p1.ssl.qhimg.com/t01068da1826ad05875.png" width="30"> <!--  宽 30px，高 30/(54/49)=27.22px -->
<img src="https://p1.ssl.qhimg.com/t01068da1826ad05875.png" height="30">  <!-- 宽 30*(54/49)=33.06px，高 30px -->

<style>
.img {
 display: inline-block;
 background-color: #eee;
 background-image: url('https://p1.ssl.qhimg.com/t01068da1826ad05875.png');
 background-repeat: no-repeat;
 background-size: auto; /*auto 是默认值*/
}
</style>
<span class="img" style="width: 100px; height: 100px;"></span> <!-- 宽 54px，高 49px -->
<span class="img" style="width: 30px; height: 30px;"></span> <!-- 宽 54px，高 49px -->
<span class="img" style="width: 30px; height: 30px; background-size: 10px 10px;"></span> <!-- 宽 10px，高 10px -->
<span class="img" style="width: 30px; height: 30px; background-size: contain;"></span> <!-- 宽 30px，高 27.22px -->
<span class="img" style="width: 100px; height: 100px; background-size: cover;"></span> <!-- 宽 100px，高 100px -->
```

## Font

字体图标缩小时可能会遇到部分图标存在锯齿现象

```css
# 消除锯齿
-webkit-font-smoothing: antialiased;
-moz-osx-font-smoothing: grayscale;
-webkit-text-stroke-width: 0.2px;

# 文字正体显示为背景模样，再配合-webkit-text-stroke描边也是不错的一种体验
-webkit-text-stroke-width: 0.5px;
-webkit-text-fill-color: transparent;
```

## 框架

自适应

- 方法：
- 组件：表单 、表格、图标、面包屑、菜单、导航、Modal 窗口
- 修改源代码

## 优化

* caniuse检测你正在使用的属性是否被广泛支持
* Validate

## framework

* Flat UI
* Semantic UI
* BootMetro
* Pure
* Metro UI CSS
* Bootswatch
* jQuery UI Bootstrap
* EZ-CSS
* [Dogfalo/materialize](https://github.com/Dogfalo/materialize):Materialize, a CSS Framework based on Material Design https://materializecss.com
* [BcRikko/NES.css](https://github.com/BcRikko/NES.css):NES-style CSS Framework | ファミコン風CSSフレームワーク https://bcrikko.github.io/NES.css
* [OfficeDev/office-ui-fabric-core](https://github.com/OfficeDev/office-ui-fabric-core):The front-end CSS framework for building experiences for Office and Office 365.

## 实例

* [chokcoco/CSS-Inspiration](https://github.com/chokcoco/CSS-Inspiration):CSS Inspiration，在这里找到写 CSS 的灵感！https://chokcoco.github.io/CSS-Inspiration/#/./init
* [tobiasahlin/SpinKit](https://github.com/tobiasahlin/SpinKit):A collection of loading indicators animated with CSS http://tobiasahlin.com/spinkit/

## 工具

* [basscss/basscss](https://github.com/basscss/basscss):Low-level CSS Toolkit http://basscss.com
* [Dogfalo/materialize](https://github.com/Dogfalo/materialize):Materialize, a CSS Framework based on Material Design https://materializecss.com
* [Chalarangelo/mini.css](https://github.com/Chalarangelo/mini.css):A minimal, responsive, style-agnostic CSS framework! https://minicss.org/
* [Spiderpig86/Cirrus](https://github.com/Spiderpig86/Cirrus):☁️ The CSS framework for the modern web. https://spiderpig86.github.io/Cirrus
* [szynszyliszys/repaintless](https://github.com/szynszyliszys/repaintless):Library for fast CSS Animations
* [nzbin/three-dots](https://github.com/nzbin/three-dots):🔮 CSS loading animations made by single element. https://nzbin.github.io/three-dots/
* [ConnorAtherton/loaders.css](https://github.com/ConnorAtherton/loaders.css):Delightful, performance-focused pure css loading animations. https://connoratherton.com/loaders
* [matthiasmullie/minify](https://github.com/matthiasmullie/minify):CSS & JavaScript minifier, in PHP. Removes whitespace, strips comments, combines files (incl. @import statements and small assets in CSS files), and optimizes/shortens a few common programming patterns. https://www.minifier.org

## 参考

* [scottjehl/Respond](https://github.com/scottjehl/Respond):A fast & lightweight polyfill for min/max-width CSS3 Media Queries (for IE 6-8, and more)
* [IanLunn/Hover](https://github.com/IanLunn/Hover):A collection of CSS3 powered hover effects to be applied to links, buttons, logos, SVG, featured images and so on. Easily apply to your own elements, modify or just use for inspiration. Available in CSS, Sass, and LESS. http://ianlunn.github.io/Hover/
* [basscss/basscss](https://github.com/basscss/basscss):Low-level CSS Toolkit http://basscss.com
* [daneden/animate.css](https://github.com/daneden/animate.css):🍿 A cross-browser library of CSS animations. As easy to use as an easy thing. http://daneden.github.io/animate.css
* [necolas/normalize.css](https://github.com/necolas/normalize.css):A collection of HTML element and attribute style-normalizations http://necolas.github.io/normalize.css/
* [bjankord/Style-Guide-Boilerplate](https://github.com/bjankord/Style-Guide-Boilerplate):A starting point for crafting living style guides.
* [sindresorhus/modern-normalize](https://github.com/sindresorhus/modern-normalize):Normalize browsers' default style
* [30 Seconds of CSS](https://atomiks.github.io/30-seconds-of-css/)
* [30-seconds/30-seconds-of-css](https://github.com/30-seconds/30-seconds-of-css):A curated collection of useful CSS snippets you can understand in 30 seconds or less.
* [Jxnblk](https://jxnblk.com/)
* [l-hammer/You-need-to-know-css](https://github.com/l-hammer/You-need-to-know-css):🖖CSS tricks web developers need to know~ https://lhammer.cn/You-need-to-know-css/
* [五个最新的CSS特性以及如何使用它们](https://zhuanlan.zhihu.com/p/40736286)
* [chokcoco/iCSS](https://github.com/chokcoco/iCSS):谈谈一些有趣的 CSS 话题
* [danielcrisp/hot-new-css-features](https://github.com/danielcrisp/hot-new-css-features):A step-by-step demonstration of five new hot CSS features
