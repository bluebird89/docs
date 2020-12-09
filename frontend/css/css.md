# [CSS Cascading Style Sheet 层叠样式表](https://developer.mozilla.org/zh-CN/docs/Web/CSS)

* 定义网页样式，比如每个网页元素的位置、大小、颜色等等

## 版本

* 1996年12月，CSS 1.0 标准问世,由W3C发布，主要规定了选择器、样式属性、伪类/对象部分
* CSS 2.0/2.1 在 1998 年 由W3C发布
  - 基于 CSS1 设计，扩充和改进了很多更加强大的属性。包括选择器、位置模型、布局、表格样式、媒体类型、伪类、光标样式
* CSS 3采用模块化结构，每个模块都是独立定义的，定义完成以后，再加入 CSS 标准，以下主要模块
  - Display
  - Box alignment
  - Flexible box
  - CSS Grid
  - Inline Layout
  - Position Layout
  - CSS Shapes
  - CSS Transforms

## 规则

* CSS 样式表由大量样式规则组成。每条样式规则分成两个部分
  - 选择器（selector）指明本条规则对哪些网页元素生效
  - 声明块（declaration block）描述样式规则的具体内容。放在一对大括号里面
    + 大括号之中是一个或多个键值对，每个键值对给出一条样式描述，键值对之间用分号分割
    + 允许重复声明某个样式，声明的键值对会覆盖前面的键值对
* 使用/*...*/表示注释，可以是单行，也可以是多行
* 继承：不仅影响网页元素本身，还会影响该元素的后代元素
  - 典型的例子就是字体属性font-family，网页根元素html设置了字体以后，该网页的所有元素都会默认使用指定的字体
* 优先级
  - 多条规则都对同一个网页元素指定样式，只要 CSS 属性不发生冲突，那么这些规则都是有效的
  - 发生冲突后优先级，针对性越强的选择器，优先级越高
    + 特殊性（specificity）：选择器越特殊，规则就越强。特殊性最低的是元素名本身，然后是元素的class属性，特殊性最高的是id属性
    + 顺序（order）同样特殊性的规则，晚出现的优先级高
    + 重要性（importance）特别注明某条规则的重要程度要比其他所有规则高，方法是在声明的末尾加上!important。由于可维护性很差，一旦出现问题，很难排查，除非是殊情况，否则不推荐使用这种方法
    + 浏览器计算每条规则优先级值方法
      * !important后缀为 10000
      * 行内样式为 1000
      * ID 为 100
      * class、伪类、属性选择器为 10
      * 标签名、伪元素为 1
* 嵌入网页方法
  - 浏览器缺省设置
  - 外部样式表
  - 内部样式表
  - 内联样式

## 属性

* 对于不能继承元素，inherit属性值 可以让子元素继承父元素属性
* initial 可以将 CSS 属性设回初始值。主要用处：让那些默认继承父元素的 CSS 属性不再继承，回到初始值
* unset 如果存在继承，则继承父元素的值（等同于inherit），如果不存在继承，则重置为初始值（等同于initial）
* revert 消除当前样式表对该元素设置样式
  - revert用在网站提供的样式表：则显示用户演示表设置的值。如果不存在用户样式表，则浏览器赋予的默认值
  - revert用在用户提供的样式表：显示浏览器赋予的默认值
* background-blend-mode属性指定背景的颜色混合模式，共有16个值可取：normal（默认值，即不混合）, multiply, screen, overlay, darken, lighten, color-dodge, color-burn, hard-light, soft-light, difference, exclusion, hue, saturation, color and luminosity（显示单色效果）

## 选择器 Selector

* Universal Selector:*
* Type Selectors 元素名称选择器
* Class Selectors:.box
  - 尽量使用 class 选择器，而不是 ID 选择器
* ID Selectors:#box
  - 样式不能在其他元素上复用
  - ID 选择器的特殊性比class选择器要强得多。这意味着如果要覆盖使用id选择器定义的样式，就要编写特殊性更强的CSS规则
* Attribute Selectors 属性选择器
  - [attribute] 匹配指定属性，不论具体值是什么
  - [attribute="value"] 完全匹配指定属性值
  - [attribute~="value"] 属性值是以空格分隔的多个单词，其中有一个完全匹配指定值
  - [attribute|="value"] 属性值以value-打头
  - [attribute^="value"] 属性值以value开头，value为完整的单词或单词的一部分
  - [attribute$="value"] 属性值以value结尾，value为完整的单词或单词的一部分
  - [attribute*="value"] 属性值为指定值的子字符串
  - 修饰符
    + i 表示不区分大小写
* Grouping 用逗号将需要分组选择器分开 body, p,  .box, #header
  + :matches(A, B)选择器表示匹配A或B
* Descendant Selectors 后代元素: E1 E2 所有被 E1 包含的 E2, 通过空格分隔
* Child Selectors 子元素 div>h2
* :not()表示选中不匹配指定条件元素,可以采用链式写法
* Pseudo Selectors 一般是用来选择<a>元素
  - Pseudo-classes 浏览器根据网页元素状态，自动提供 CSS 类，无需在 HTML 代码显式标记这些类
    + :empty：没有任何子元素
    + :in-range：针对有range属性的input
    + :out-of-range：针对有range属性的input
    + :optional：没有required属性的input元素
    + :required
    + :disabled｜enabled
    + :fullscreen
    + :not()
    + :focus：链接获得焦点
    + :link 新的、未访问的链接
    + :hover 鼠标指针停留在链接上
    + :visited 访问过的效果
    + :active 激活状态
    + :first-child|last-child 表示一组元素最｜第一个元素，且该元素必须是父元素的第一个子元素
    + :nth-child() 选中指定位置的子元素。:nth-last-child()选中指定的倒数位置的子元素
      * 如果元素名与:nth-child()之间没有空格:表示匹配该种子元素
      * 有空格时，表示匹配该元素的子元素
      * li:nth-child(-n + 3) 选中前三个元素，可以在n前面使用负数符号1-
    + :first-of-type选中一组元素之中的第一个元素,:last-of-type选中本类之中最后一个元素
    + :nth-of-type()匹配指定类型和位置的元素，:nth-last-of-type()匹配倒数位置的指定类型和位置的元素
      * 参数可以是an + b 形式
      * 参数可以是even或odd
  - Pseudo-Elements：HTML 中并不存在元素
    + ::first-line
    + ::first-letter
    + ::after
    + ::before
* target选择器用来匹配当前hash
* BEM命名法
  - BEM是Block（区块）、Element（元素）、Modifier（修饰符）三者的简称
  - 区块是顶级组件的抽象
  - 元素是组件的组成部分
  - 修饰符是组件或元素的状态
  - 区块与元素之间用两个下划线连接，元素与修饰符之间用两个连词线连接

## 背景 background

* 不定义背景图片或者背景色，一个网页元素背景就是透明的
* opaque值在0到100之间。默认值是100，表示百分之百不透明，而0表示百分之百透明
* background属性可以同时指定背景图和背景颜色 `background: url(sweettexture.jpg) blue;`
  - background-color
  - `background-image:url(/i/eg_bg_04.gif);`
* background-repeat：当背景图片小于容器时的平铺方式,可以设置两个值，分别表示 X 轴和 Y 轴的重复方式,一个值是简写形式
  - repeat：背景图片沿容器的X轴和Y轴平铺，将会平铺满整个容器，可能会造成背景图片显示不全
  - repeat-x： 背景图片沿容器的X轴平铺
  - repeat-y：背景图片沿容器的Y轴平铺
  - no-repeat：背景图片不做任何平铺
  - round：背景图片沿容器的X轴和Y轴平铺，将会铺满整个容器。如果有多余空间，会升缩背景图片适应容器大小，不会造成图片显示不全
  - space：背景图片沿容器的X轴和Y轴平铺，将会铺满整个容器。如果有多余空间，不会改变背景图片的大小，而是平均分配相邻图片之间的空间，不会造成图片显示不全
* background-position：图像在背景中的位置
  - top
  - bottom
  - left
  - right
  - center
  - 0% 0%:左上角将放在元素内边距区的左上角
  - 100% 100%:图像右下角放在右边距右下角
* background-attachment 设置背景图案的位置，是否在视口里面是固定的，也就是说，是否随着滚动条一起滚动
  - scroll：默认值，表示背景图片绑定区块内容，会随着视口滚动条滚动，但不会随着区块滚动条滚动
  - fixed：背景图片绑定视口，不会随着视口滚动条和区块滚动条滚动
  - local：背景图片会随着视口滚动条和区块滚动条滚动

## 盒子模型 Box Model

* 依赖 display 属性 + position属性 + float属性.规定了元素框处理元素内容、内边距、边框 和 外边距方式
* 由内到外：element(height width)->padding(内边距呈现元素背景)->border->margin(默认是透明)
* 背景应用于内容和内边距、边框组成区域
* 将元素 margin 和 padding 设置为零来覆盖浏览器样式
* element
  - width 和 height 指的是内容区域宽度和高度。增加内边距、边框和外边距不会影响内容区域的尺寸，但是会增加元素框的总尺寸
  - width: auto表示父元素提供的所有宽度（100%）
  - content-box(default) - 为元素设置了宽度和高度，只是内容尺寸
* padding 内填充属性：边线到内容间的距离
  - 设置百分数值。百分数值是相对于其父元素 width 计算的，这一点与外边距一样。所以，如果父元素的 width 改变，它们也会改变
  - padding-top
  - padding-right
  - padding-bottom
  - padding-left
* border 边框
  - border-style:none outset solid dotted dashed double groove ridge inset inherit
    - border-top-style border-right-style border-bottom-style border-left-style
  - border-width:2px 或 0.1em；或者使用关键字: thin 、medium（默认值） 和 thick
    + border-top-width border-right-width border-bottom-width border-left-width
  - border-color:默认的边框颜色是元素本身的前景色。如果没有为边框声明颜色，它将与元素的文本颜色相同
    + border-top-color border-right-color border-bottom-color border-left-color
  - 格式：border-left: 粗细 线型 颜色; div{border-left:5px solid red;}
    + 线型：none(无线)、solid(实线)、dotted(点状线)、dashed(虚线)、double(双线)
    + 注意：多个参数值之间用空格隔开
    + border-radius
      * oval(椭圆形):border-radius: 100px / 50px;
* margin:围绕在元素边框的空白区域
  - 默认值是 0，所以如果没有为 margin 声明一个值，就不会出现外边距
  - 浏览器对许多元素已经提供了预定样式，外边距也不例外。例如，在支持 CSS 的浏览器中，外边距会在每个段落元素的上面和下面生成“空行”
  - margin-top margin-right margin-bottom margin-left
  - 外边距合并
    + 当两个垂直外边距相遇时，将形成一个外边距。合并后外边距高度等于两个发生合并的外边距的高度中的较大者
    + 当一个元素包含在另一个元素中时（假设没有内边距或边框把外边距分隔开），它们的上和/或下外边距也会发生合并，一侧合为一个较大值
    + 有一个空元素，它有外边距，但是没有边框或填充。在这种情况下，上外边距与下外边距就碰到了一起，发生合并
* box-sizing：盒状模型宽度范围
  - content-box：默认值，只包括内容区的宽度，不包括padding和border
  - border-box：宽度包括padding和border
* max-width设为none，可以让元素占满父元素的整个宽度
* overflow属性指定如果元素的大小超出容器时行为
  - visible：默认值，表示溢出的部分可见
  - hidden：表示溢出的部分不可见
  - scroll：表示发生溢出时，会显示滚动条，用户可以拖动滚动条，看到溢出的部分
* clip规则指定元素超出容器大小时，具体显示哪个部分。它只对绝对定位（absolute）和固定定位（fixed）的元素有效
  - react函数四个参数含义
    + 第一个参数：剪切后的顶边距离容器的顶边的距离
    + 第二个参数：剪切后的右边界距离容器的左边界的距离
    + 第三个参数：剪切后的底边距离容器的顶边的距离
    + 第四个参数：剪切后的左边界距离容器的左边界的距离
  - clip-path是clip规则的继承者，用来剪切元素的大小。它对所有定位方式都适用
* object-fit命令指定一个元素的大小应该如何适应它的容器，主要用于图像。它可以取以下的值。
  - fill：容器的宽度和高度就是元素的宽度和高度，会截去溢出的部分
  - contain：元素会填满容器，不会改变长宽比，可能会有溢出。
  - cover：元素会填满容器，可能会改变长宽比，但不会有溢出。
  - none：元素不会改变的大小，具体的展示效果由默认算法决定
  - scale-down：展示效果会选择none或contain之中，对象尺寸较小的一个
  - inherit：使用父元素的值
  - initial：使用浏览器的默认值
  - unset：这个属性是inherit和initial的结合，如果该元素继承父元素，就采用inherit，否则采用initial

## 字体 Font

* 字体文件类型
  - 内嵌OpenType（Embedded OpenType，.eot）。在使用@font-face时，Internet Explorer 8及之前的版本仅支持内嵌OpenType。内嵌OpenType是Microsoft的一项专有格式，它使用数字版权管理技术防止在未经许可的情况下使用字体。
  - TrueType（.ttf）和OpenType（.otf），台式机使用的标准字体文件类型。TrueType和OpenType得到了Mozilla Firefox（3.5及之后的版本）、Opera（10及之后的版本）、Safari（3.1及之后的版本）、Mobile Safari（iOS 4.2及之后的版本）、Google Chrome（4.0及之后的版本）及Internet Explorer（9及之后的版本）的广泛支持。这些格式不使用数字版权管理。
  - Web开放字体格式（Web Open Font Format，.woff）。这种较新的标准是专为Web字体设计的。Web开放字体格式的字体是经压缩的TrueType字体或OpenType字体。WOFF格式还允许在文件上附加额外的元数据。字体设计人员或厂商可以利用这些元数据，在原字体信息的基础上，添加额外的许可证或其他信息。这些元数据不会以任何方式影响字体的表现，但经用户请求，这些元数据可以呈现出来。Mozilla Firefox（3.6及之后的版本）、Opera（11.1及之后的版本）、Safari（5.1及之后的版本）、Google Chrome（6.0及之后的版本）及Internet Explorer（9及之后的版本）均支持Web开放字体格式。
  - 可缩放矢量图形（Scalable Vector Graphics，.svg）。简言之，应避免对Web字体文件使用SVG。它更多地用于早期Web字体，因为它是iOS 4.1上移动Safari唯一支持的格式（还有可能引起一些崩溃的情况）。从iOS 4.2（于2011年初即被广泛使用）起，移动Safari开始支持TrueType
* `font-family`：字体
  - 通用
    + Serif 字体
    + Sans-serif 字体
    + Monospace 字体
    + Cursive 字体
    + Fantasy 字体
  - 特定字体
    + Times
    + Courier
    - 如果用户代理上没有安装 Georgia 字体，就只能使用用户代理的默认字体来显示 h1 元素。
    - 可以通过结合特定字体名和通用字体系列来解决.对字体非常熟悉
    - 可以为给定的元素指定一系列类似的字体。要做到这一点，需要把这些字体按照优先顺序排列，然后用逗号进行连接
  - web font 样式表指定的字体需要下载
    + 浏览器发现样式表指定的字体，是一种需要下载的字体，会去检查缓存里面是否存在这种字体，如果不存在就开始从网上下载
    + 网页上使用这种字体的文字，会显示不出来，而展现一片空白。这段时间称为”阻塞期“（block），每种浏览器的”阻塞期“时间长度不尽相同，Chrome、Firefox 和 Safari 都是3秒，即文字会有3秒钟显示不出来，而 IE 是0秒，即没有阻塞期
    + 阻塞期结束，如果字体已经下载完成，浏览器就会采用下载的字体进行渲染，文字就会显示出来
    + 如果下载还没有结束，浏览器就会采用替代字体进行渲染，文字也会显示出来，但是与最终状态不一样，这段时间称为”替换期“（swap）。此时，浏览器其实还在下载字体
    + 等到字体下载成功，这时浏览器会用下载的字体，替换现有的字体，这时网页会一闪
    + 如果字体下载失败了，这时浏览器就会继续使用现有的字体，因此网页不会发生变化
* `font-size`：设置网页字体大小
* font-smooth属性 控制浏览器对字体渲染
  - 字体图标缩小时可能会遇到部分图标存在锯齿现象
* font-display 控制浏览器在下载字体时的渲染行为
  - block 打开阻塞期
  - swap 关闭阻塞期，直接进入替换期，即浏览器不会出现文字显示不出来的情况
  - fallback 设置阻塞期的长度是100毫秒，即文字有100毫秒显示不出来，然后立即进入替换期。等到字体下载结束，再使用下载的字体渲染
  - optional 设置阻塞期也是100毫秒。然后，等到100毫秒结束，浏览器发现字体已经下载完成，就使用下载的字体渲染，否则就不再下载，永久性使用替代字体渲染。它主要用于网速较慢的环境，不让用户长时间等到字体下载

- `font-weight`：加粗效果
  + normal
  + bold
  + 关键字 100 ~ 900 为字体指定了 9 级加粗度。如果一个字体内置了这些加粗级别，那么这些数字就直接映射到预定义的级别，100 对应最细的字体变形，900 对应最粗的字体变形。数字 400 等价于 normal，而 700 等价于 bold

* `font-style`：斜体效果
  - normal
  - italic
  - oblique
* font-variant:设定小型大写字母,不是一般的大写字母，也不是小写字母，这种字母采用不同大小的大写字母

```
/*# 文字正体显示为背景模样，再配合-webkit-text-stroke描边也是不错的一种体验*/
-webkit-text-stroke-width: 0.5px;
-webkit-text-fill-color: transparent;
```

## color

* 允许使用关键字表示颜色，CSS2.1 设置了16个基本的颜色，CSS 3 又增加了131个
* 六位颜色表示法又称为 RGB 表示
  - 分别使用两位十六进制数表示红色（R）、绿色（G）、蓝色（B），组合在一起就是六位，然后加上#前缀，比如#59007F
  - 每种颜色使用0～255表示浓度，0表示没有，255表示浓度最深
  - 果一个十六进制颜色是由三对重复的数字组成,可以只写一个
* 八位颜色表示法：Chrome 浏览器支持八位的颜色表示法RRGGBBAA，前六位是红、绿、蓝颜色值，后两位表示透明度（alpha transparency）
  - #ffffff80相当于rgba(255, 255, 255, .5)
  - alpha设置越接近0，颜色就越透明。如果设为0，就是完全透明的，就像没有设置任何颜色。类似地，1表示完全不透明
* HSLA 表示法
  - HSL 代表色相（hue）、饱和度（saturation）和亮度（lightness）
  - 色相的取值范围为0～360
  - 饱和度和亮度的取值均为百分数，范围为0～100%
  - 红色为hsl(0,100%,50%);
  - 黄色为hsl(60,100%,50%);
  - 绿色为hsl(120,100%,50%);
  - 青色为hsl(180,100%,50%);
  - 蓝色为hsl(240,100%,50%);
  - 紫红色为hsl(300,100%,50%);
* currentColor是一个属性值，代表当前元素的color属性的值
  - 伪元素也可以使用

## 单位

* 绝对长度:in cm mm pt磅 pc 皮卡
* em 一种相对单位，1em 等于当前元素的font-size
  - 浏览器中默认的文本大小是 16 像素。因此 1em 的默认尺寸是 16 像素
  - 如果当前元素没有指定字体的像素大小，那么1em等于父元素字体的像素大小
  - 优点
    + 保持不同元素之间的比例关系，因此它比像素单位更合适用来设定字体大小
  - 整个网页的字体大小，如果全部使用em单位，不使用像素单位，会引发一个问题。em将会基于父元素计算，从而出现累积效应
  - 如果font-size使用em，其它使用em属性 两者的计算基点是不一样的
  - rem单位与em几乎完全一致，只有一个差异，它总是等于根元素<html>的font-size大小，与当前元素或父元素的设置无关，这就避免了em的缺陷
    + 字体大小font-size属性使用rem，其他必须等比例缩放的属性使用em
    + `font-size:1rem`:定义该区块字体大小基数值，等于根元素 font-size 计算值
* 像素 pixels
  - 显示器上图像是由许多点构成的，这些点称为像素，意思就是"构成图像的元素"
  - 500×300像素，是分辨率的尺寸单位
* 分辨率: 每英寸像素PPI（pixels per inch）为单位来表示
* vh表示百分之一的浏览器视口高度，vw表示百分之一的浏览器视口宽度。每当视口的高度和宽度发生变化，它们就会自动重新计算
* vmin表示vh与vw之中较短的那个单位，vmax则表示较长的那个单位
* ch表示多少个字符
* calc方法用于计算值，常用于两种不同的单位之间的计算（比如百分比和绝对长度）
* attr()用于读取网页元素的属性值

## 文本

* visibility（可见性）
* `line-height`：行高，可以是百分比，也可以是固定值。
* `text-align`：设置块级元素内部的文本对齐方式
  - left：默认值，文本向左对齐
  - right：右对齐
  - center：居中对齐
  - justify：两端对齐，除了最后一行是左对齐。
  - inherit：继承父元素的值
  - start：direction属性为从左到右时，为左对齐；从右到左时，为右对齐
  - end：direction属性为从左到右时，为右对齐；从右到左时，为左对齐
* vertical-align 设置一个元素与在同一条水平线上的其他元素如何对齐。这些元素需要都是inline,用于同一行的图标与文字的对齐
  - baseline：对齐父元素的基线，默认值
  - length: 升高或降低特定的长度，可使用负值
  - %：升高或降低line-height的百分比，不允许负值
  - sub：设为下标
  - super：设为上标
  - top: 当前元素的顶部对齐最高元素的顶边
  - text-top：当前元素的顶部对齐父元素字体的顶部
  - middle：元素位于父元素的垂直中部
  - bottom：当前元素的底部对齐本行最低元素的底部
  - text-bottom：当前元素的底部，对齐父元素字体的底部
  - initial：设置为默认值
  - inherit：继承父元素的值
  - 对设为display: table-cell的元素也有效，可以控制元素在单元格之中的垂直对齐方式
  * justify 文本行的左右两端都放在父元素的内边界上。然后，调整单词和字母间的间隔，使各行的长度恰好相等

+ tab-size属性设置 Tab 键的宽度，可以设置为整数（表示多少个空格），也可以设置为具体的长度单位,常用于<pre>标签之中

* `text-indent`：首行缩进，长度可以是负值，也可以用百分比值
  - 为所有块级元素应用 text-indent，但无法将该属性应用于行内元素，图像之类的替换元素上也无法应用 text-indent 属性
  - 设置负值时要注意：首行的某些文本可能会超出浏览器窗口的左边界。为了避免出现这种显示问题，建议针对负缩进再设置一个外边距或一些内边距
  - text-indent 属性可以继承

+ word-spacing 属性可以改变字（单词）之间的标准间隔 接受一个正长度值或负长度值。如果提供一个正长度值，那么字之间的间隔就会增加。为 word-spacing 设置一个负值，会把它拉近

* `letter-spacing`：字母间隔修改的是字符或字母之间的间隔
* word-wrap 正式名称是overflow-wrap，用于规定是否可以在一个词内部断行，避免溢出容器
  - normal：只在可以断行的地方断行。
  - break-word：可以在任意点断行，避免某个词过长，发生溢出
* word-break用于规定是否可以在词内断行
  - normal：使用浏览器默认的断行规则
  - break-all：对于非 CJK 字符，可以任意字符之间断行。
  - keep-all：对于 CJK 字符不允许换行。非 CJK 字符与normal相同
* hyphens 连字号
  - 打开
    + 设置文本的语言 <html>标签的lang属性 。告诉浏览器使用哪个连字词典，正确的自动连字需要一个适合文本语言的连字词典
  - none表示一个词不会在断行处被拆开，即断行处不会有连词线
  - manual表示只有在一个词内部的字符表示可以有连词线时，才会在断行处拆开。断行处，会有连词
  - auto表示浏览器决定一个词是否可以在断行处拆开，以及是否会有连词线
* text-transform 修改大小写
  - none uppercase lowercase capitalize
* `text-decoration`：设置文本采用哪一种装饰线
  - none
  - underline：下划线，默认线宽1px
  - overline：上划线，默认线宽1px
  - line-through：删除线，默认线宽1px
  - inherit：继承父元素的设置
  - 多种装饰线可以同时存在
  - 默认情况下，装饰线的颜色与文本的color属性一致,
  - 用作text-decoration-style和text-decoration-color的简写形式
    + text-decoration-color 设置文本的装饰线的颜色
    + text-decoration-style设置文本划线类型
      * solid：单条直线
      * double：双条直线
      * dotted：多个点组成的直线
      * dashed：多个短划线组成的直线
      * wavy：波浪线
    + text-decoration-line设置文本采用何种装饰线，与text-decoration单个值的写法相同。建议采用后者，因为浏览器的支持度更好
  - text-decoration-skip设置文本的装饰线应该在哪里中断，主要用于改善文本被装饰以后的可读性
    + objects：默认值，装饰线遇到图片或其他inline-block对象时中断。
    + none：装饰线不会有任何中断，包括遇到行内对象。
    + spaces：装饰线在空格、断词处中断。
    + ink：装饰线遇到有笔画下降或上升的字母时中断。
    + edges：装饰线在内容开始后和结束前都收缩一点，主要用于多个连续的装饰线，可以看上去连成一条。
    + box-decoration：装饰线在继承的 margin、border 和 padding 处中断
* white-space：提供更精确一点的空格处理方式
  - HTML 代码的空格通常会被浏览器忽略
  - 空格原样输出
    + 可以使用<pre>标签
    + 改用 HTML 实体&nbsp;表示空格
  - 处理空格的规则适用于：普通的空格键、制表符（\t）和换行符（\r和\n）
  - 默认值为normal，表示浏览器以正常方式处理空格
  - pre：按照<pre>标签的方式处理
  - nowrap：不会因为超出容器宽度而发生换行
  - pre-wrap 还是按照<pre>标签的方式处理，唯一区别是超出容器宽度时，会发生换行
  - pre-line 保留换行符。除了换行符会原样输出，其他都与white-space:normal规则一致
* direction 设置块级元素内部的文本阅读方向
  - ltr
  - rtl
  - 对于行内元素，只有当 unicode-bidi 属性设置为 embed 或 bidi-override 时才会应用 direction 属性
  - unicode-bidi  设置文本方向，值 normal embed 或 bidi-overrid

## 列表

* list-style（列表样式）
* list-style-type：修改用于列表项的标志类型
  - 无序：disc circle square none
  - 有序：decimal decimal-leading-zero lower-roman upper-roman lower-alpha upper-alpha lower-greek lower-latin upper-latin hebrew armenian georgian cjk-ideographic hiragana hiragana-iroha katakana-iroha
* list-style-image 用于为列表指定定制的标记
* list-style-position 用于确定列表标记的位置  确定标志出现在列表项内容之外还是内容内部 inside outside

## table

* border:边框
* border-collapse 属性设置是否将表格边框折叠为单一边框. 这是由于 table、th 以及 td 元素都有独立的边框,默认表格具有双线条边框 collapse separate
* border-spacing  设置分隔单元格边框的距离
* caption-side  设置表格标题的位置
* empty-cells 设置是否显示表格中的空单元格。
* table-layout  设置显示单元、行和列的算法
* width 和 height 属性定义表格的宽度和高度
* text-align:表格文本对齐 设置水平对齐方式
* vertical-align 表格文本对齐 设置垂直对齐方式
* padding 表格内边距 内容与边框的距离
* background-color color
* table-layout
  - automatic:列的宽度是由列单元格中没有折行的最宽的内容设定的
  - fixed:允许浏览器更快地对表格进行布局 水平布局仅取决于表格宽度、列宽度、表格边框宽度、单元格间距，而与单元格的内容无关
  border-collapse（用于控制表格相邻单元格的边框是否合并为单一边框）
border-spacing（用于指定表格边框之间的空隙大小）
caption-side（用于设置表格标题的位置）
empty-cells（用于设置是否显示表格中的空单元格）

## 链接

* a:link - 普通的、未被访问的链接
* a:visited - 用户已访问的链接
* a:hover - 鼠标指针位于链接的上方，
* a:active - 链接被点击的时刻
* 设置样式时，请按照以下次序规则：a:hover 必须位于 a:link 和 a:visited 之后 a:active 必须位于 a:hover 之后
* text-decoration 属性大多用于去掉链接中的下划线
* background-color 属性规定链接的背景色

```css
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

```

## position 指定一个元素在网页上位置

定义元素框相对于其正常位置应该出现的位置，或者相对于父元素、另一个元素甚至浏览器窗口本身的位置

* static:默认值
  - 浏览器会按照源码顺序，决定每个元素位置，这称为"正常的页面流"（normal flow）
  - 每个块级元素占据自己的区块（block），元素与元素之间不产生重叠，这个位置就是元素的默认位置
  - 元素位置，是浏览器自主决定的，top、bottom、left、right属性无效
* fixed
  - 相对于视口（viewport，浏览器窗口）进行偏移，即定位基点是浏览器窗口
  - 导致元素的位置不随页面滚动而变化，好像固定在网页上一样
* relative
  - 相对于默认位置（即static时位置）进行偏移，即定位基点是元素的默认位置
  - 搭配top、bottom、left、right属性一起使用，用来指定偏移方向和距离
* absolute:相对于上级元素（一般是父元素）进行偏移，即定位基点是父元素
  - 限制条件：定位基点（一般是父元素）不能是static定位，否则定位基点就会变成整个网页的根元素html
  - 搭配top、bottom、left、right 属性一起使用
  - 定位的元素会被"正常页面流"忽略，即在"正常页面流"中，该元素所占空间为零，周边元素不受影响
* sticky：产生动态效果，很像relative和fixed的结合，比如网页的搜索工具栏、表头
  - 生效的前提：必须搭配top、bottom、left、right这四个属性一起使用，不能省略
  - 规则
    + 当页面滚动，父元素开始脱离视口时（即部分不可见），只要与sticky元素的距离达到生效门槛（top），relative定位自动切换为fixed定位
    + 等到父元素完全脱离视口时（即完全不可见），fixed定位自动切换回relative定位
* z-index表示元素重叠时的层次关系。这个值越高，对应的元素就在越上层。所有元素的默认z-index是0
  - position属性的值不是static），z-index属性才有意义
  - 一组设置了z-index属性的元素，堆叠顺序取决于是否处在同一个堆叠上下文（stacking context）。三种情况会创建堆叠上下文
    + 网页的根元素（即<html>元素）
    + 网页元素是非静态布局，且z-index属性不等于auto
    + 网页元素的opacity属性小于1
  - 同一个堆叠上下文之中，元素的堆叠（从下层到上层）按照以下顺序决定
    + 堆叠上下文的根元素
    + 设置了定位、且z-index为负值的元素
    + 没有设置定位的元素
    + 设置了定位、且z-index为auto的元素
    + 设置了定位、且z-index为正值的元素

## layout

* 传统：基于盒状模型，display属性搭配position属性和float属性
  - display: none; 会从文档流移除该元素及其子元素，仿佛它们是不存在的。它们占据的空间会释放出来
  - display: block; 产生块级元素，会占据一行，占满容器的宽度
  - display: inline; 产生行内元素，没有自己的高度和宽度，由容器决定，前后不会产生换行
  - display: list-item; 将元素渲染为一个列表项，行首产生一个列表标记，可以用list-style定制样式
  - display: inline-block;产生行内的块级元素，有自己的高和宽，但是前后不会产生换行
  - display: table;
    + table-header-group 对应<thead>
    + table-row 对应<tr>
    + table-cell 对应<td>
    + table-row-group 对应<tbody>
    + table-footer-group 对应<tfoot>
    + table-column-group 对应<colgroup>
    + table-column 对应<col>
    + table-caption 对应<caption>
    + inline-table 将一个表格渲染具有inline-block的形式
* float属性 指定元素定位在容器左侧或右侧，文字和其他行内元素紧挨在它的旁边
  - left：定位在容器的左侧
  - right：定位在容器的右侧
  - none：不采用浮动定位（默认值）
  - 清理浮动
    + 产生原因：如果紧跟元素高度小于浮动元素高度,导致紧跟在后面元素，不是出现在浮动元素下方，而是在浮动元素右侧
    + 容器内部的文本不希望紧贴浮动元素，这时也可以使用clear属性进行清理浮动
    + left：左侧不能有浮动元素
    + right：右侧不能有浮动元素
    + both：两侧不能有浮动元素
    + none：默认值，不需要清理浮动
  - 如果一个容器里面所有子元素都是浮动，就会导致这个容器变成一个空容器，高度缩为0。因为布局的时候，浮动的所有子元素是脱离父容器计算位置的，这导致渲染引擎认为这个容器是空元素
    + 父容器也进行浮动
    + 父容器添加overflow: hidden 容器计算高度的时候，就会自动将浮动的子元素考虑在内
    + CSS 生成内容以后，就不会被渲染引擎当成是一个空元素
* 多栏式布局是 CSS 原生提供的一种内容分栏显示的解决方案
  - 分栏
    + column-count属性指定div的子元素分成指定栏
    + column-width属性指定每一栏的宽度
    + column-count与column-width不应同时使用，同时只能有一个属性生效
    + 设定position: fixed和position: absolute子元素，将不纳入多栏式布局的栏计算
  - 间隔
    + column-gap：间隔宽度
    + column-rule-color：间隔线的颜色
    + column-rule-style：间隔线的样式，比如dashed、dotted等，默认是solid
    + column-rule-width：间隔线本身的宽度
    + column-rule：column-rule-color、column-rule-style、column-rule-width这三个属性的快捷形式
    + column-span属性指定某个子元素可以占据多栏的宽度，比如标题。它只能设两个值all和none
    + column-fill属性指定内容如何在多栏之间分配
      * 默认值balance表示栏与栏是等高
      * auto表示只占据内容所需的空间
  - 内容断点
    + break-inside属性决定子元素内部如何断点
      * auto：默认值，表示子元素内部可以插入断点
      * avoid：避免在子元素内部插入所有类型（page、column、region）的断点
      * avoid-column：避免子元素内部插入栏与栏的断点
    + break-before属性决定子元素前方如何断点
      * auto：默认值，子元素前方可以插入断点
      * avoid：避免在子元素前方插入所有类型（page、column、region）的断点
      * avoid-column：避免在子元素前方插入栏与栏的断点
      * column：子元素前方强制插入一个栏断点
    + break-after属性决定子元素后方如何断点
      * auto：默认值，子元素后方可以插入断点
      * avoid：避免在子元素后方插入所有类型（page、column、region）的断点
      * avoid-column：避免在子元素后方插入栏与栏的断点
      * column：子元素后方强制插入一个栏断点
* [flex](./Flex.md)
* [Grid](./Grid.md)
* table
  - 标签布局模式
    + table { display: table }
    + tr { display: table-row }
    + thead { display: table-header-group }
    + tbody { display: table-row-group }
    + tfoot { display: table-footer-group }
    + col { display: table-column }
    + colgroup { display: table-column-group }
    + td, th { display: table-cell }
    + caption { display: table-caption }
  - 让页尾总是显示在浏览器的最低部，即使页面高度不足一页
  - display:table-caption使得该行显示在表格的最顶部。
  - display:table-header-group使得该行显示在表格的头部，但是位置低于table-caption的行。
  - display:table-footer-group使得该行显示在表格的底部

## 打印

* @media print 设置打印样式，即用户选择打印当前网页时，生效的 CSS 规则
* 可以与正常样式规则混合使用(嵌套)
* @media screen 只对屏幕浏览有效
* 分页符属性用来设置页面的分页：值都是两个：always（生效）和avoid（避免）
  - page-break-before：元素之前分页
  - page-break-after：元素之后分页
  - page-break-inside：元素内部分页
* orphans属性设置跨页前的行数少于多少行时，所有行都移到下一页打印
* widow属性设置出现在新页面的行数，最少应该有几行
* @page命令主要用来定义页面距
  - margin
  - :first、:last、:left、:right和:blank选择器，选中特殊页面
* 技巧
  - 每一页都出现表头:只需要使用<thead>元素定义表头，<tbody>元素定义表的数据部分即可
  - 打印链接的网址:使用:after伪元素

## 自适应网页设计 Responsive Web Design

* 一次设计，普遍适用，根据不同的媒介，自动采用不同 CSS 规则
* 头部添加 viewport，设置网页默认宽度和高度
  - width=device-width 网页宽度默认等于屏幕宽度
  - initial-scale=1 即网页初始放比例占屏幕面积的100%
  - 网页会根据屏幕宽度调整布局，所以不能使用绝对宽度的布局，也不能使用具有绝对宽度的元素，使用百分比或auto，字体使用相对大小（em）
* 流动布局：各个区块的位置都是浮动的，不是固定不变的。如果宽度太小，放不下两个元素，后面的元素会自动滚动到前面元素的下方，不会在水平方向overflow（溢出），避免了水平滚动条的出现
* CSS3 引入 Media Query模块，自动探测屏幕宽度
  - media命令用来规定 CSS 规则生效的媒介。@media命令后面使用关键词，指定生效条件
    + screen
    + print
  - 媒介名称之前，还可以使用not和only关键字
  - 同时需要满足多个条件，可以使用and关键字
  - 允许使用表达式，指定 CSS 生效条件。表达式可以放在圆括号之中

## image

* 概念
  * 固有尺寸：固有宽度、固有高度和固有宽高比的集合。对于特定对象，这三个尺寸可能都存在，也可能都不存在。比如光栅图像同时拥有这三个，SVG 图像只有固有宽高比，CSS 渐变就没有任何固有尺寸
  * 指定大小：通过width  height  background-size中的一个或多个指定的
  * 默认对象大小：一个具有确定宽高的矩形。在既没有固有尺寸，也没有指定大小时生效
  * 具体对象大小：对象最终显示的大小，即有明确宽度和高度值的矩形

+ 显示效果:算它最终“具体对象大小”
  * 优先使用指定大小，得到要显示宽和高
  - 如果只指定了一个宽度，或只指定了一个高度
    + 如果有固有宽高比，则用它和给出的那个，计算出来另一个
    + 否则，就取固有尺寸里的
    + 如果也没有固有尺寸，那就取默认对象大小的
  - 如果没有指定大小
    + 先用固有尺寸里的
    + 如果没有固有尺寸，那就取默认对象大小的
  - 指定大小 > 固有尺寸 > 默认对象大小
  - 图像超出背景区域的部分，会被裁剪掉；覆盖不全的部分，会用背景色来填充
  - 调整图像大小的属性 background-size

* width
* height
* object-fit  定义内容如何适应容器的高和宽
  - contain：图片自动升缩，以固有的长宽比，完整显示在容器中。
  - fill：图片自动填满容器，即使破坏原有的长宽比。
  - cover：保留图像的长宽比，但会自动升缩以填满容器，长度或宽度中较小的一个会完全在容器中展示，较大的一个会溢出。
  - none：完全忽视容器的大小，使用图片固有的长宽比。
  - scale-down: none或者contain中导致图片尺寸较小的那个值
* object-position设置容器中的对象（通常是图片）的垂直和水平位置
* background-size 提供指定大小
  - 包含约束（contain constraint ）遵循固有宽高比，宽高都小于等于背景区域，然后尽可能的大
  - 覆盖约束（cover constraint）遵循固有宽高比，宽高都大于等于背景区域，然后尽可能的小
* filter 表示图片滤镜
  - url()：引用定义在SVG文件中的滤镜
  - blur()：高斯模糊 参数为模糊半径
  - brightness()：亮度
  - contrast()：对比度 0%为全黑，100%为原始对比度
  - drop-shadow()：阴影 阴影效果，设置同box-shadow接近
  - grayscale()：灰度 0%为原始色彩，100%为完全灰度
  - hue-rotate()：色调旋转 0为原始色调，360为色彩轮旋转一周后回到原色调
  - invert()：色调分离 0%为原始效果，100%为完全负片效果
  - opacity()：透明 0%为完全透明，100%为完全不透明
  - saturate()：饱和度 0%为完全不饱和，100%为完全饱和
  - sepia()：加入褐色色调 0%为原始效果，100%为完全作旧

```html
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

## animation 动画

* timer
  - linear：线性运行，各个时刻速度都一样。
  - ease: 快速加速，然后逐渐减速，CSS 的默认值。
  - ease-in：逐渐加速，结尾时变快，适用于退出页面显示的元素。
  - ease-out：开始时速度最快，然后逐渐慢下来，适用于进入页面显示的元素。
  - ease-in-out：主键加速然后变慢，与ease相似，但开始时加速较慢，适合那些在页面有着明确开始和结束的动画
* transition 定义元素状态变化的过渡,四个参数 `transition: [*property] [*transition-duration] [transition-timing-function] [transition-delay];`
  - *property：元素的哪一个 CSS 属性需要过渡效果，该参数必需
  - *transition-duration：过渡效果的持续时间，该参数必需
  - transition-timing-function：定时函数，默认是ease
  - transition-delay：过渡从多少秒以后开始，默认是0
* animation 用来指定元素的动画效果  `animation: [*animation-name] [*animation-duration] [animation-timing-function] [animation-delay] [animation-iteration-count] [animation-direction] [animation-fill-mode] [animation-play-state];`
  - *animation-name：关键帧的名字，该参数必需。
  - *animation-duration：动画持续的时间，该参数必需。
  - animation-timing-function：定时器函数，默认是ease。
  - animation-delay：动画效果多少秒后开始，默认为0。
  - animation-iteration-count：动画重复的次数，可以指定为一个整数，表示多少次，默认值是infinite关键字，表示无限次。
  - animation-direction：动画方向，可能的值为forward、backward或alternating，默认值为normal。
  - animation-fill-mode：默认值为none。
  - animation-play-state：动画默认是否生效，默认值为running
  - animation属性是一个简写形式
* [animate-css/animate.css](https://github.com/animate-css/animate.css):🍿 A cross-browser library of CSS animations. As easy to use as an easy thing. <https://animate.style/>

## transform 元素的变形

* skew(20deg):定义了一个元素在二维平面上的倾斜转换。结果是一个<transform-function>数据类型,指定一个或两个参数，它们表示在每个方向上应用的倾斜量
* rotate(45deg):一个旋转属性，将元素在不变形的情况下旋转到不动点周围
* transform-origin: 100% 100%;

## 函数

* minmax提供一个长度范围，不小于较小值，不大于较大值
  - 网格布局中，max也允许设置为比例因子fr，但min不能设置为fr
  - auto在max位置等同于max-content，在min位置等同于min-content
* image-set()用来选取符合响应式条件的图片

## 高级

* CSS 变量:允许用户自定义属性,定义在某个选择器里面，而且只对该选择器有效.所在区块，相当于变量的作用域
  - :root选择器之中，可以设置全局的自定义属性
  - 也可以在行内定义
  - 必须以两个连词线开头，并且大小写敏感
  - 通过var()函数取出变量
    + 第二个参数，指定默认值。如果某个自定义属性没有设置，默认值就会生效
    + 默认值包含逗号，那么var()会将第一个逗号后面的所有值，当作默认值
  - var()内部还可以使用var()
  - 局部变量可以覆盖全局变量
  - 可以与calc函数结合使用
  - 变量不包含单位时，不能直接添加单位
  - JavaScript 可以操作这些变量
* supports命令用来判断浏览器是否支持某项CSS功能
* initial-letter决定首字母的下沉样式
* CSS Shape
  - 网页灰度显示
    + shape-outside属性使得行内（inline）的内容，围绕outside指定的曲线排列。
    + shape-margin属性指定shape-outside与内容之间的margin
  - circle函数可以使用circle(r at x y)这样的形式，定义半径和圆心的坐标。注意，这里的坐标是相对于原始形状，而不是相对于父容器
  - ellipse()
  - polygon()

## 优化

* caniuse 检测正在使用的属性是否被广泛支持
* Validate
* 执行 CSS 重置;各浏览器默认行为还是存在很多分歧。解决这个问题最好的办法就是使用一个 CSS 重置文件为所有元素重新设置默认样式
  - [normalize.css](https://github.com/necolas/normalize.css):A collection of HTML element and attribute style-normalizations <http://necolas.github.io/normalize.css/>
  - [modern-normalize](https://github.com/sindresorhus/modern-normalize):Normalize browsers' default style

```css
* {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
  }
```

## CSS 预处理器

* CSS 作为一门样式语言，语法简单，易于上手.由于不具备常规编程语言提供的变量、函数、继承等机制，因此很容易写出大量没有逻辑、难以复用和扩展的代码，在日常开发使用中，如果没有完善的编码规范，编写的 CSS 代码会非常冗余且难以维护
* 基于 CSS 语言的语法扩展，除了能解决上述缺乏语言特性带来的问题之外，还支持嵌套书写，减少重复输入父级选择器（可理解为 CSS 中的继承机制），提高了代码的可读性和编写效率
* [PostCSS](./postcss.md)
* [Sass](./sass.nd) 功能更加强大或者说 Sass 的语言层面更接近于一门完整的编程语言
* [Less](./less.md) 更接近于 CSS 语法
* 变量：就像其他编程语言一样，免于多处修改。
  - Sass：使用「$」对变量进行声明，变量名和变量值使用冒号进行分割
  - Less：使用「@」对变量进行声明
  - Stylus：中声明变量没有任何限定，结尾的分号可有可无，但变量名和变量值之间必须要有『等号』。但需要注意的是，如果用“@”符号来声明变量，Stylus会进行编译，但不会赋值给变量。就是说，Stylus 不要使用『@』声明变量。Stylus 调用变量的方法和Less、Sass完全相同。
* 作用域：有了变量，就必须得有作用域进行管理。就想js一样，它会从局部作用域开始往上查找变量。
  - Sass：它的方式是三者中最差的，不存在全局变量的概念
  - Less：它的方式和js比较相似，逐级往上查找变量
  - Stylus：它的方式和Less比较相似，但是它和Sass一样更倾向于指令式查找
* 嵌套：对于css来说，有嵌套的写法无疑是完美的，更像是父子层级之间明确关系
  者在这处的处理都是一样的，使用「&」表示父元素
* Stylus

## CSS-in-JS

* CSS Modules 模块化CSS 将CSS文件以模块的形式引入到JavaScript里，基本上解决了全局污染、命名混乱、样式重用和冗余的问题，但CSS有嵌套结构的限制（只能一层），也无法方便的在CSS和JavaScript之间共享变量
* CSS-in-JS就是在组件内部使用JavaScript对CSS进行了抽象，可以对其声明和加以维护。这样不仅降低了编写CSS样式带来的风险，也让开发变得更加轻松。它和CSS Modules的区别是不再需要CSS样式文件
* [styled-components](https://github.com/styled-components/styled-components) Visual primitives for the component age. Use the best bits of ES6 and CSS to style your apps without stress 💅 <https://styled-components.com>

## 问题

```
https://fonts.googleapis.com/css?family=Raleway:700,400,300,700italic,400italic,300italic
```

## 课程

* [css-animation-101](https://github.com/cssanimation/css-animation-101):Learn how to bring animation to your web projects <https://cssanimation.rocks>

## 图书

* 《[CSS 揭秘](https://www.amazon.cn/gp/product/B01ET3FO86)》
* 《CSS 世界》
* 《[CSS 设计指南](https://www.amazon.cn/gp/product/B00M2DKZ1W)》
* 《[CSS 权威指南](https://www.amazon.cn/gp/product/B0011F5SIC)》
* [CSS 禅意花园](http://www.csszengarden.com/) css zen garden
* 《精通 CSS: 高级 Web 标准解决方案》
* 《众妙之门: 精通 CSS3》
* 《[深入浅出 HTML 与 CSS](https://www.amazon.cn/gp/product/B01LXL42O5)》
* 《[点石成金:访客至上的网页设计秘笈](https://www.amazon.cn/gp/product/B00QGA04RM)》
* 超越 css

## framework

* BootMetro
* Bootswatch
* [materialize](https://github.com/Dogfalo/materialize):Materialize, a CSS Framework based on Material Design <https://materializecss.com>
* EZ-CSS
* Flat UI
* iView
* laiketui
* Metro UI CSS
* [milligram](https://github.com/milligram/milligram) A minimalist CSS framework. <https://milligram.io>
* [moon](https://github.com/kbrsh/moon) 🌙 The minimal & fast UI library <https://moonjs.org/>
* [NES.css](https://github.com/BcRikko/NES.css):NES-style CSS Framework | ファミコン風CSSフレームワーク <https://bcrikko.github.io/NES.css>
* [office-ui-fabric-core](https://github.com/OfficeDev/office-ui-fabric-core):The front-end CSS framework for building experiences for Office and Office 365.
* [spectre](https://github.com/picturepan2/spectre) Spectre.css - A Lightweight, Responsive and Modern CSS Framework <https://picturepan2.github.io/spectre/>
* [pure](https://github.com/pure-css/pure):A set of small, responsive CSS modules that you can use in every web project. <https://purecss.io/>
* Semantic UI
* [shoelace](https://github.com/shoelace-style/shoelace):A collection of professionally designed, every day UI components built on a framework-agnostic technology. <https://shoelace.style/>
* [UIkit](https://getuikit.com/):A lightweight and modular front-end framework
  for developing fast and powerful web interfaces.

## 工具

* [basscss](https://github.com/basscss/basscss):Low-level CSS Toolkit <http://basscss.com>
* [mini.css](https://github.com/Chalarangelo/mini.css):A minimal, responsive, style-agnostic CSS framework! <https://minicss.org/>
* [stylelint](https://github.com/stylelint/stylelint) <https://stylelint.io/>
* [Cirrus](https://github.com/Spiderpig86/Cirrus):☁️ The CSS framework for the modern web. <https://spiderpig86.github.io/Cirrus>
* [repaintless](https://github.com/szynszyliszys/repaintless):Library for fast CSS Animations
* [three-dots](https://github.com/nzbin/three-dots):🔮 CSS loading animations made by single element. <https://nzbin.github.io/three-dots/>
* [loaders.css](https://github.com/ConnorAtherton/loaders.css):Delightful, performance-focused pure css loading animations. <https://connoratherton.com/loaders>
* [minify](https://github.com/matthiasmullie/minify):CSS & JavaScript minifier, in PHP. Removes whitespace, strips comments, combines files (incl. @import statements and small assets in CSS files), and optimizes/shortens a few common programming patterns. <https://www.minifier.org>
* [Hover](https://github.com/IanLunn/Hover):A collection of CSS3 powered hover effects to be applied to links, buttons, logos, SVG, featured images and so on. Easily apply to your own elements, modify or just use for inspiration. Available in CSS, Sass, and LESS. <http://ianlunn.github.io/Hover/>
* [yui3](https://github.com/yui/yui3) A library for building richly interactive web applications. <http://yuilibrary.com/>
* [tachyons](https://github.com/tachyons-css/tachyons/):Functional css for humans <https://tachyons.io>

## 参考

* [Respond](https://github.com/scottjehl/Respond):A fast & lightweight polyfill for min/max-width CSS3 Media Queries (for IE 6-8, and more)
* [Style-Guide-Boilerplate](https://github.com/bjankord/Style-Guide-Boilerplate):A starting point for crafting living style guides.
* [30 Seconds of CSS](https://atomiks.github.io/30-seconds-of-css/)
* [30-seconds-of-css](https://github.com/30-seconds/30-seconds-of-css)Short CSS code snippets for all your development needs <https://www.30secondsofcode.org/css/p/1>
* [Jxnblk](https://jxnblk.com/)
* [You-need-to-know-css](https://github.com/l-hammer/You-need-to-know-css):🖖CSS tricks web developers need to know~ <https://lhammer.cn/You-need-to-know-css/>
* [How to Efficiently Master the CSS Grid in a Jiffy](https://medium.com/flexbox-and-grids/how-to-efficiently-master-the-css-grid-in-a-jiffy-585d0c213577)
* [CSS-Inspiration](https://github.com/chokcoco/CSS-Inspiration):CSS Inspiration，在这里找到写 CSS 的灵感！<https://chokcoco.github.io/CSS-Inspiration/#/./init>
* [SpinKit](https://github.com/tobiasahlin/SpinKit):A collection of loading indicators animated with CSS <http://tobiasahlin.com/spinkit/>
* [chokcoco/iCSS](https://github.com/chokcoco/iCSS):谈谈一些有趣的 CSS 话题
* [hot-new-css-features](https://github.com/danielcrisp/hot-new-css-features):A step-by-step demonstration of five new hot CSS features
* [](https://generative-art-with-css.commons.host/)
* [](https://github.com/jgthms/web-design-in-4-minutes):<https://jgthms.com/web-design-in-4-minutes/>
* [五个最新的CSS特性以及如何使用它们](https://zhuanlan.zhihu.com/p/40736286)
