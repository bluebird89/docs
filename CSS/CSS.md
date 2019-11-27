# CSS Cascading Style Sheet层叠样式表。

* “层叠”是指多个外层元素的样式，会被内层元素去继承。
* “样式”，主要指外观。包括：字体、文本、背景图片、定位、浮点等。
* 优先级
  - 浏览器缺省设置
  - 外部样式表
  - 内部样式表
  - 内联样式

```html
<link rel="stylesheet" type="text/css" href="mystyle.css" />

<style type="text/css">
  hr {color: sienna;}
  p {margin-left: 20px;}
  body {background-image: url("images/back40.gif");}
</style>

<p style="color: sienna; margin-left: 20px">
This is a paragraph
</p>
```

## 历史

* CSS1.0在1997 年 由W3C发布，第一版主要规定了选择器、样式属性、伪类 / 对象几个大的部分；
* CSS2.0/2.1在1998 年 由W3C发布，CSS2 规范是基于 CSS1 设计的，扩充和改进了很多更加强大的属性。包括选择器、位置模型、布局、表格样式、媒体类型、伪类、光标样式；
* 将CSS模块化，并且按照每个模块的进度来标准化。所以从形式上来讲，CSS3已经不存在了。现在CSS 包括了修订后的 CSS2.1 以及完整模块对它的扩充，模块的 level（级别）数并不一致。可以在每个时间点上为 CSS 标准定义一个 snapshots

## 格式

* 如果值为若干单词，则要给值加引号
* Selector:选择某一个HTML标记
  - Universal Selector:*
  - Type Selectors:p
  - Class Selectors:.box
  - ID Selectors:#box
  - Attribute Selectors
    + E [ attr ] { sRules } 有 attr 属性的 E
    + E [ attr = value ] { sRules } 具有 attr 属性且属性值等于 value
    + E [ attr ~= hello ] { sRules } 具有 attr 属性且属性值为用空格分隔的字词列表 包含指定值的 attr 属性的所有元素设置样式 <a title="hello world">
    + E [ attr |= hello ] { sRules } 具有 attr 属性且属性值为一用连字符分隔的字词列表 <a title="hello-world">
  - Grouping :用逗号将需要分组的选择器分开 body , p ,  .box  , #header 通过逗号分隔
  - Descendant Selectors（某个元素的所有后代元素）: E1 E2 所有被 E1 包含的 E2  { sRules } body div 通过空格分隔
  - Child Selectors（当前元素的子元素）：div > h2
  - Pseudo Selectors，一般是用来选择<a>元素的
    + Pseudo-classes
      * :link 正常链接效果。
      * :hover 鼠标放上的效果
      * :visited 访问过的效果
      * :active 激活状态
    + Pseudo-Elements
      * :after
      * :before
  - :nth-child(n):于其父元素的第n个子元素 .item:nth-child(2)
  + Selector : first-child
* 属性名:属性值构成

```css
selector {property: value}

* {color:red}
*.div { text-decoration:none; }

h1 {color:red; font-size:14px;}

.box{color:red;}
div.box{color:red;}  // 给 class = box 的<div>元素加样式

#box{color:red;}  //给 id=box 元素加样式

body , p ,  .box  , #header {color:red;}
.box .header{color:red;}
div > h2{color:red;}

div:first-letter { font-size:14px; }
a.fly :hover { font-size:14px; color:red; }

a:link { font-size: 14pt; text-decoration: underline; color: blue; }
```

## 属性

* 背景
  - background-color
  - background-image
  - background-repeat：属性值 repeat 导致图像在水平垂直方向上都平铺，就像以往背景图像的通常做法一样。repeat-x 和 repeat-y 分别导致图像只在水平或垂直方向上重复，no-repeat 则不允许图像在任何方向上平铺。
  - background-position：图像在背景中的位置 top、bottom、left、right 和 center，图像位于 0% 0%，其左上角将放在元素内边距区的左上角。如果图像位置是 100% 100%，会使图像的右下角放在右边距的右下角。
  - background-attachment：文档比较长，那么当文档向下滚动时，背景图像也会随之滚动 防止这种滚动。声明图像相对于可视区是固定的（fixed），因此不会受到滚动的影响
* 尺寸
    - width：元素的宽度。
    - height：元素的高度。
* 字体
  - `font-family`：字体
    + 通用
      * Serif 字体
      * Sans-serif 字体
      * Monospace 字体
      * Cursive 字体
      * Fantasy 字体
    + 特定字体
      * Times
      * Courier
    - 如果用户代理上没有安装 Georgia 字体，就只能使用用户代理的默认字体来显示 h1 元素。 可以通过结合特定字体名和通用字体系列来解决.对字体非常熟悉，也可以为给定的元素指定一系列类似的字体。要做到这一点，需要把这些字体按照优先顺序排列，然后用逗号进行连接：
  - `font-size`：文字大小,绝对值、相对值
    + em 等于当前的字体尺寸。如果一个元素的 font-size 为 16 像素，那么对于该元素，1em 就等于 16 像素。在设置字体大小时，em 的值会相对于父元素的字体大小改变。 浏览器中默认的文本大小是 16 像素。因此 1em 的默认尺寸是 16 像素。 可以使用下面这个公式将像素转换为 em：pixels/16=em，假设父元素的 font-size 为 20px，那么公式需改为：pixels/20=em
    + 使用 em 单位，则可以在所有浏览器中调整文本大小。
  + `font-weight`：加粗效果。取值：normal bold 关键字 100 ~ 900 为字体指定了 9 级加粗度。如果一个字体内置了这些加粗级别，那么这些数字就直接映射到预定义的级别，100 对应最细的字体变形，900 对应最粗的字体变形。数字 400 等价于 normal，而 700 等价于 bold。
  - `font-style`：斜体效果。取值：normal italic oblique
  - font-variant:设定小型大写字母,不是一般的大写字母，也不是小写字母，这种字母采用不同大小的大写字母
* 文本
    - color：文本颜色。
    - `line-height`：行高，可以是百分比，也可以是固定值。
    - `text-align`：文本的水平对齐方式，取值：left、center、right
      - justify 文本行的左右两端都放在父元素的内边界上。然后，调整单词和字母间的间隔，使各行的长度恰好相等
    * word-spacing 属性可以改变字（单词）之间的标准间隔 接受一个正长度值或负长度值。如果提供一个正长度值，那么字之间的间隔就会增加。为 word-spacing 设置一个负值，会把它拉近
    - `letter-spacing`：字母间隔修改的是字符或字母之间的间隔
    - text-transform：none uppercase lowercase capitalize
    - `text-decoration`：文本修饰线，取值：none、underline(下划线)、overline(上划线)、line-through(删除线)
    - white-space：默认的 XHTML 处理已经完成了空白符处理：它会把所有空白符合并为一个空格。
      + normal：各个字之间只会显示一个空格，同时忽略元素中的换行
      + pre：空白符不会被忽略
      + nowrap：防止元素中的文本换行，除非使用了一个 br 元素
      + pre-wrap，那么该元素中的文本会保留空白符序列，但是文本行会正常地换行。源文本中的行分隔符以及生成的行分隔符也会保留
      + pre-line 与 pre-wrap 相反，会像正常文本中一样合并空白符序列，但保留换行符
    - `text-indent`：首行缩进，长度可以是负值，也可以用百分比值
      + 为所有块级元素应用 text-indent，但无法将该属性应用于行内元素，图像之类的替换元素上也无法应用 text-indent 属性
      + 设置负值时要注意：首行的某些文本可能会超出浏览器窗口的左边界。为了避免出现这种显示问题，建议针对负缩进再设置一个外边距或一些内边距
      + text-indent 属性可以继承
    - direction 属性规定文本的方向 / 书写方向，ltr 和 rtl
      - 对于行内元素，只有当 unicode-bidi 属性设置为 embed 或 bidi-override 时才会应用 direction 属性 unicode-bidi  设置文本方向，值 normal embed 或 bidi-overrid
* 链接
  - a:link - 普通的、未被访问的链接
  - a:visited - 用户已访问的链接
  - a:hover - 鼠标指针位于链接的上方，
  - a:active - 链接被点击的时刻
  - 设置样式时，请按照以下次序规则：a:hover 必须位于 a:link 和 a:visited 之后 a:active 必须位于 a:hover 之后
  - text-decoration 属性大多用于去掉链接中的下划线
  - background-color 属性规定链接的背景色
* 列表
  - list-style-type：修改用于列表项的标志类型
    + 无序：disc circle square none
    + 有序：decimal decimal-leading-zero lower-roman upper-roman lower-alpha upper-alpha lower-greek lower-latin upper-latin hebrew armenian georgian cjk-ideographic hiragana hiragana-iroha katakana-iroha
  -  list-style-image：对各标志使用一个图像
  -  list-style-position: 确定标志出现在列表项内容之外还是内容内部 inside outside
* table
  - border:边框
  - border-collapse 属性设置是否将表格边框折叠为单一边框. 这是由于 table、th 以及 td 元素都有独立的边框,默认表格具有双线条边框 collapse separate
  - border-spacing  设置分隔单元格边框的距离
  - caption-side  设置表格标题的位置
  - empty-cells 设置是否显示表格中的空单元格。
  - table-layout  设置显示单元、行和列的算法
  - width 和 height 属性定义表格的宽度和高度
  - text-align:表格文本对齐 设置水平对齐方式
  - vertical-align 表格文本对齐 设置垂直对齐方式
  - padding 表格内边距 内容与边框的距离
  -  background-color color
  -  table-layout
    +  automatic:列的宽度是由列单元格中没有折行的最宽的内容设定的
    +  fixed:允许浏览器更快地对表格进行布局 水平布局仅取决于表格宽度、列宽度、表格边框宽度、单元格间距，而与单元格的内容无关
*  Outline
  -  outline  在一个声明中设置所有的轮廓属性
  -  outline-color  设置轮廓的颜色
  - outline-style 设置轮廓的样式
  - outline-width 设置轮廓的宽度
* 边框
    - border-left border-right border-top border-bottom
        + 格式：border-left: 粗细 线型 颜色;
        + 线型：none(无线)、solid(实线)、dotted(点状线)、dashed(虚线)、double(双线)
        + 注意：多个参数值之间用空格隔开。
        + 举例：div{border-left:5px solid red;} div{border:2px solid blue;}
        + border-radius
          * oval(椭圆形):border-radius: 100px / 50px;
* 内填充属性：边线到内容间的距离
  + padding-left padding-right padding-top padding-bottom
* 外边距属性：边框线往外的距离
  - 垂直方向上的外边距相遇时将会发生折叠。这意味着如果一个元素的下边距遇到了另一个元素的上边距，那么二者中较大的一个将被留下

```css
p {background-color: gray;}
body {background-image: url(/i/eg_bg_04.gif);}

body
  {
  background-image: url(/i/eg_bg_03.gif);
  background-repeat: repeat-y;
  background-position:center;
  background-attachment:fixed
  }

p {text-indent: -5em; padding-left: 5em;}
p.tight {word-spacing: -0.5em;}
h4 {letter-spacing: 20px}
p {white-space: normal;}

body {font-family: sans-serif;}
h1 {font-family: Georgia, serif;}
p {font-family: Times, TimesNR, 'New Century Schoolbook',
     Georgia, 'New York', serif;}
p {font-variant:small-caps;}
h1 {font-size:3.75em;} /* 60px/16=3.75em */
h2 {font-size:2.5em;}  /* 40px/16=2.5em */
p {font-size:0.875em;} /* 14px/16=0.875em */

/* 结合使用百分比和 EM 在所有浏览器中均有效的方案是为 body 元素（父元素）以百分比设置默认的 font-size 值 */
body {font-size:100%;}
h1 {font-size:3.75em;}
h2 {font-size:2.5em;}
p {font-size:0.875em;}

a:link,a:visited
{
display:block;
font-weight:bold;
font-size:14px;
font-family:Verdana, Arial, Helvetica, sans-serif;
color:#FFFFFF;
background-color:#98bf21;
width:120px;
text-align:center;
padding:4px;
text-decoration:none;
}

a:hover,a:active
{
background-color:#7A991A;
}

ul {list-style-type : square}
ul li {list-style-image : url(xxx.gif)}

ul
{
list-style: square inside url('../i/eg_arrow.gif')
}

table
{
border-collapse:collapse;
width:100%;
}

table{
border-collapse: separate;
border-spacing: 10px 50px # 第一个是水平间隔，第二个是垂直间隔。除非 border-collapse 被设置为 separate，否则将忽略这个属性
empty-cells:hide;
}
table,th, td
{
border: 1px solid black;
}
th {
  height:50px;
  background-color:green;
  color:white;
}
td
  {
  text-align:right;
  vertical-align:bottom;
  padding:15px;
  }
caption
{
caption-side:bottom
}

p.one
{
border:red solid thin;
outline:#00ff00 dotted thick;
outline-style:solid;
outline-width:thin;
}
```

## 盒子模型 Box Model

依赖 display 属性 + position属性 + float属性.规定了元素框处理元素内容、内边距、边框 和 外边距 的方式

* 由内到外：element(height width)->padding(内边距呈现了元素的背景)->border->margin(默认是透明)
* 背景应用于由内容和内边距、边框组成的区域
* 通过将元素的 margin 和 padding 设置为零来覆盖这些浏览器样式
* element
  - 元素的内边距设置百分数值。百分数值是相对于其父元素的 width 计算的，这一点与外边距一样。所以，如果父元素的 width 改变，它们也会改变。
  - width 和 height 指的是内容区域的宽度和高度。增加内边距、边框和外边距不会影响内容区域的尺寸，但是会增加元素框的总尺寸。
* padding
  - padding-top
  - padding-right
  - padding-bottom
  - padding-left
* border 边框绘制在“元素的背景之上”
  - border-style:none outset solid dotted dashed double groove ridge inset inherit
    - border-top-style border-right-style border-bottom-style border-left-style
  - border-width:2px 或 0.1em；或者使用关键字: thin 、medium（默认值） 和 thick。
    + border-top-width border-right-width border-bottom-width border-left-width
  - border-color:默认的边框颜色是元素本身的前景色。如果没有为边框声明颜色，它将与元素的文本颜色相同
    + border-top-color border-right-color border-bottom-color border-left-color
* margin:围绕在元素边框的空白区域
  - 默认值是 0，所以如果没有为 margin 声明一个值，就不会出现外边距
  - 浏览器对许多元素已经提供了预定的样式，外边距也不例外。例如，在支持 CSS 的浏览器中，外边距会在每个段落元素的上面和下面生成“空行”
  - margin-top margin-right margin-bottom margin-left
  - 外边距合并
    + 当两个垂直外边距相遇时，它们将形成一个外边距。合并后的外边距的高度等于两个发生合并的外边距的高度中的较大者
    + 当一个元素包含在另一个元素中时（假设没有内边距或边框把外边距分隔开），它们的上和/或下外边距也会发生合并，一侧合为一个较大值
    + 有一个空元素，它有外边距，但是没有边框或填充。在这种情况下，上外边距与下外边距就碰到了一起，发生合并

* box-sizing：有利于样式化，而且你在也不用做乏味的数学运算
* content-box(default) - 当我们为元素设置了宽度和高度，但那只是内容的尺寸。所有的 padding 和 border 都在不包含在内容当中，也就是在内容的外部。
* border-box - padding和 border 被包含在 宽度和高度当中。 如果一个 div 的宽度为 100px ，而被设置了 box-sizing: border-box， 那么它的宽度将始终是 100px， 无论你添加多少 padding 和 border 。

```css
* {
  margin: 0;
  padding: 0;
}

h1 {padding: 10px 0.25em 2ex 20%;}
h1{
    padding:10px; //四个内填充都是10px
    padding:10px 20px; //上下内填充为10px，左右内填充为20px
    padding:5px 10px 15px; //上填充为5px，左右为10px，下为15px
    padding:5px 10px 15px 20px;  //顺序一定为：上右下左
}
h1 {
  padding-top: 10px;
  padding-right: 0.25em;
  padding-bottom: 2ex;
  padding-left: 20%;
  }

a:link, a:visited {
  border-style: solid;
  border-width: 5px;
  border-color: transparent;
  }

h1 {margin : 10px 0px 15px 5px;}

a:hover {border-color: gray;}
```

position属性
  fixed
  relative
  absolute

* transform
  - skew(20deg)
  - rotate(45deg)
*  transform-origin: 100% 100%;

## 定位

定义元素框相对于其正常位置应该出现的位置，或者相对于父元素、另一个元素甚至浏览器窗口本身的位置

* 块元素
    - 块元素单独占一行。
    - 块元素左右都有换行符。
    - 块元素可以设置width和height属性。
    - 常用的块元素：`<div>、<p>、<h1>、<table>、<form>、<ul>、<ol>、<li>、<pre>`等
* 行内元素
    - 行内元素不会单独占一行，多个行内元素会排在同一行。
    - 行内元素没有width和height属性。
    - 行内元素：`<span>、<font>、<b>、<i>、<u>、<s>、<a>、<input>、<label>、<img>`等
* `<div>`和`<span>`是没有意义的标记，但是又使用最多的
* `<img>`和`<input>`是行内块元素(inline-block)，也有width和height
* 以使用 display 属性改变生成的框的类型： block none

不可以在内联元素 `<span>` 中嵌入`<p>`

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

## 问题

```
https://fonts.googleapis.com/css?family=Raleway:700,400,300,700italic,400italic,300italic 
```

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
* [tailwindcss/tailwindcss](https://github.com/tailwindcss/tailwindcss):A utility-first CSS framework for rapid UI development.  https://tailwindcss.com/
* element
* iView

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
* [daneden/animate.css](https://github.com/daneden/animate.css):🍿 A cross-browser library of CSS animations. As easy to use as an easy thing. http://daneden.github.io/animate.css
* [IanLunn/Hover](https://github.com/IanLunn/Hover):A collection of CSS3 powered hover effects to be applied to links, buttons, logos, SVG, featured images and so on. Easily apply to your own elements, modify or just use for inspiration. Available in CSS, Sass, and LESS. http://ianlunn.github.io/Hover/

## 参考

* [scottjehl/Respond](https://github.com/scottjehl/Respond):A fast & lightweight polyfill for min/max-width CSS3 Media Queries (for IE 6-8, and more)
* [IanLunn/Hover](https://github.com/IanLunn/Hover):A collection of CSS3 powered hover effects to be applied to links, buttons, logos, SVG, featured images and so on. Easily apply to your own elements, modify or just use for inspiration. Available in CSS, Sass, and LESS. http://ianlunn.github.io/Hover/
* [basscss/basscss](https://github.com/basscss/basscss):Low-level CSS Toolkit http://basscss.com
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
* [CSS：层叠样式表](https://developer.mozilla.org/zh-CN/docs/Web/CSS)
