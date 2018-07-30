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

## 框架

自适应

- 方法：
- 组件：表单 、表格、图标、面包屑、菜单、导航、Modal 窗口
- 修改源代码

## 优化

* caniuse检测你正在使用的属性是否被广泛支持
* Validate

## framework

* Bootstrap
* Flat UI
* Semantic UI
* BootMetro
* Pure
* Metro UI CSS
* Bootswatch
* jQuery UI Bootstrap
* EZ-CSS

## 工具

* [basscss/basscss](https://github.com/basscss/basscss):Low-level CSS Toolkit http://basscss.com


## 参考

* [scottjehl/Respond](https://github.com/scottjehl/Respond):A fast & lightweight polyfill for min/max-width CSS3 Media Queries (for IE 6-8, and more)
* [IanLunn/Hover](https://github.com/IanLunn/Hover):A collection of CSS3 powered hover effects to be applied to links, buttons, logos, SVG, featured images and so on. Easily apply to your own elements, modify or just use for inspiration. Available in CSS, Sass, and LESS. http://ianlunn.github.io/Hover/
* [basscss/basscss](https://github.com/basscss/basscss):Low-level CSS Toolkit http://basscss.com
* [daneden/animate.css](https://github.com/daneden/animate.css):🍿 A cross-browser library of CSS animations. As easy to use as an easy thing. http://daneden.github.io/animate.css
* [necolas/normalize.css](https://github.com/necolas/normalize.css):A collection of HTML element and attribute style-normalizations http://necolas.github.io/normalize.css/
* [bjankord/Style-Guide-Boilerplate](https://github.com/bjankord/Style-Guide-Boilerplate):A starting point for crafting living style guides.
* [sindresorhus/modern-normalize](https://github.com/sindresorhus/modern-normalize):Normalize browsers' default style
* [30 Seconds of CSS](https://atomiks.github.io/30-seconds-of-css/#box-sizing-reset)
* [Jxnblk](https://jxnblk.com/)
