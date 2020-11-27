# HTML HyperText Markup Language 超文本标记语言

* 一种用于创建[网页](https://zh.wikipedia.org/wiki/%E7%BD%91%E9%A1%B5)的标准标记语言
* HTML 使用标记标签来描述网页,标签或元素(element),格式:<开始标签>内容<结束标签>

## 历史

* 1982年的时候，万维网的发明者Tim Berners-Lee爵士为了让全世界的物理学家能够方便的进行合作与信息共享，造了HTML(HyperText Markup Language) 超文本置标语言
* 最大特点就是支持超链接，点击链接就可以跳转到其他网页，从而构成了整个互联网
* 1990年，发明了世界上第一个浏览器WorldWideWeb
* 1991年3月，Tim Berners-Lee把HTML介绍给了给他在CERN(欧洲核子研究中心) 工作的朋友，当时网页浏览器被其世界各地的成员用来浏览CERN庞大的电话薄
* 1999年，HTML 4.01 版发布，成为广泛接受的 HTML 标准
* 2014年，HTML 5 发布，这是目前正在使用的版本

## 概念

* 语法
  - 大小写不敏感
  - 将文本里面的换行符（\n）和回车符（\r），替换成空格
* 标签 tag:告诉浏览器，如何处理这段代码。标签的内容就是浏览器所要渲染的、展示在网页上的内容
  - 单独使用的标签，通常是因为标签本身就足够完成功能了，不需要标签之间的内容
  - 可以嵌套
  - 标签内容的头部和尾部的空格，一律忽略不计
  - 标签内容里面的多个连续空格（包含制表符\t），会被浏览器合并成一个
* 渲染网页时，会把 HTML 源码解析成一个标签树，每个标签都是树的一个节点（node）。这种节点就称为网页元素（element）
  - “标签”和“元素”基本上是同义词，只是使用的场合不一样：标签是从源码角度来看，元素是从编程角度来看
  - 忽略缩进和换行
* 属性（attribute）：标定制元素的行为，不同的属性会导致元素有不同的行为
  - 推荐总是使用双引号
  - 大小写不敏感
  - 使用空格与标签名和其他属性分隔，属性名与属性值之间，通过等号=连接
* 局属性 global attributes：所有元素都可以使用的属性
  - id属性是元素在网页内的唯一标识符
    + 属性的值必须是全局唯一的，同一个页面不能有两个相同的id属性
    + 值还可以在最前面加上#，放到 URL 中作为锚点，定位到该元素在网页内部的位置
  - class属性用来对网页元素进行分类。如果不同元素的class属性值相同，就表示它们是一类的
  - title属性用来为元素添加附加说明，鼠标悬浮在元素上面时，会将title属性值作为浮动提示，显示出来
  - tabindex：浏览器允许使用 Tab 键，遍历网页元素
    + 值是一个整数，表示用户按下 Tab 键的时候，网页焦点转移的顺序。不同的属性值有不同的含义。
    + 负整数：该元素可以获得焦点
    + 0：该元素参与 Tab 键的遍历，顺序由浏览器指定，通常是按照其在网页里面出现的位置
    + 正整数：网页元素按照从小到大的顺序（1、2、3、……），参与 Tab 键的遍历
  - accesskey属性指定网页元素获得焦点的快捷键，该属性的值必须是单个的可打印字符。只要按下快捷键，该元素就会得到焦点
  - style属性用来指定当前元素的 CSS 样式
  - hidden是一个布尔属性，表示当前的网页元素不再跟页面相关，因此浏览器不会渲染这个元素
  - lang属性指定网页元素使用的语言
    + zh-Hans：简体中文
    + zh-Hant：繁体中文
  - dir属性表示文字的阅读方向
    + tr：从左到右阅读，比如英语。
    + rtl：从右到左阅读，阿拉伯语、波斯语、希伯来语都属于这一类。
    + auto：浏览器根据内容的解析结果，自行决定
  - contenteditable属性允许用户修改内容
    + true或空字符串：内容可以编辑
    + false：不可以编辑
  - spellcheck属性就表示，是否打开拼写检查
  - data-属性用于放置自定义数据。如果没有其他属性或元素合适放置数据，就可以放在data-属性
    + data-属性只能通过 CSS 或 JavaScript 利用
* 注释：浏览器会自动忽略注释。注释以<!--开头，以-->结尾

## 基本标签

* 文档类型
  - `<!DOCTYPE>`:为浏览器提供一项信息HTML 是用什么版本编写
  - HTML 4.01 规定了三种文档类型
    + Strict
    + Transitional
    + Frameset
  - XHTML 1.0 规定了三种 XML 文档类型
    + Strict
    + Transitional
    + Frameset
* <html>标签是网页的顶层容器，即标签树结构的顶层节点，也称为根元素（root element），其他元素都是它的子元素。一个网页只能有一个<html>标签
  - lang属性，表示网页内容默认的语言
* <head>标签是一个容器标签，用于放置网页的元信息。它的内容不会出现在网页上，而是为网页渲染提供额外信息
  - <meta>：设置网页的元数据（metadata），一个<meta>标签就是一项元数据，网页可以有多个<meta>，<meta>标签约定放在<head>内容的最前面
    + charset属性，用来指定网页的编码方式
    + name属性表示元数据的名字，content属性表示元数据的值。合在一起使用，就可以为网页指定一项元数据
      *description是网页内容的描述
      * keywords是网页内容的关键字
      *author是网页作者
      * viewport
        - width    设置viewport宽度，为一个正整数，或字符串‘device-width’
        - device-width  设备宽度
        - height   设置viewport高度，一般设置了宽度，会自动解析出高度，可以不用设置
        - initial-scale    默认缩放比例（初始缩放比例），为一个数字，可以带小数
        - minimum-scale    允许用户最小缩放比例，为一个数字，可以带小数
        - maximum-scale    允许用户最大缩放比例，为一个数字，可以带小数
        - user-scalable    是否允许手动缩放
    + http-equiv属性用来覆盖 HTTP 回应的头信息字段，content属性是对应的字段内容
  - <link>：连接外部样式表
  - <title>：设置网页标题
  - <base>：设置网页内部相对 URL 的计算基准
  - <style>：放置内嵌的样式表
  - <script>：引入脚本
  - <noscript>：浏览器不支持脚本时，所要显示的内容
  - 参考
    + [joshbuchea/HEAD](https://github.com/joshbuchea/HEAD):A list of everything that *could* go in the head of your document https://gethead.info
* <body> 一个容器标签，用于放置网页的主体内容
  - <html>的第二个子元素，紧跟在<head>后面
  - background="../i/eg_background.jpg"

```html
<!--HTML5 -->
<!DOCTYPE html>

<!--HTML 4.01 -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "
http://www.w3.org/TR/html4/strict.dtd">

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "
http://www.w3.org/TR/html4/frameset.dtd">

<!--XHTML 1.0 -->
<!DOCTYPE html
PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!DOCTYPE html
PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">

<meta name="description" content="Free Web tutorials on HTML, CSS, XML" />
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Content-Security-Policy" content="default-src 'self'">

<!-- 这是一个注释 -->
<script type="text/javascript">
document.write("Hello World!")
</script>

<noscript>Your browser does not support JavaScript!</noscript>
```

## 字符编码

* 服务器向浏览器发送 HTML 网页文件时，会通过 HTTP 头信息，声明网页的编码方式 `Content-Type: text/html; charset=UTF-8`
* 每个字符有一个 Unicode 号码，称为码点（code point）
* 不是每一个 Unicode 字符都能直接在 HTML 语言里面显示
  - 有些没有可打印形式
  - 小于号（<）和大于号（>）用来定义 HTML 标签，其他需要用到这两个符号的场合，必须防止它们被解释成标签
  - 无法找到一种输入法，可以直接输入所有这些字符不允许混合使用多种编码
* 表示法是&#N;
* 实体 entity
  - <：&lt;
  - >：&gt;
  - "：&quot;
  - '：&apos;
  - &：&amp;
  - ©：&copy;
  - #：&num;
  - §：&sect;
  - ¥：&yen;
  - $：&dollar;
  - £：&pound;
  - ¢：&cent;
  - %：&percnt;
  - *：$ast;
  - @：&commat;
  - ^：&Hat;
  - ±：&plusmn;
  - 空格：&nbsp;

## 语义结构

* 标签的名称都带有语义 semantic,使用时应该尽量符合标签的语义
* 重要作用，就是声明网页元素的性质，使得用户只看标签，就能了解这个元素的意义
* <header>
  - 页眉:表示整个网页的头部,网站导航和搜索栏
  - 表示一篇文章或者一个区块的头部,文章标题、作者等信息
  - 可以用在多种场景，所以一个页面可能包含多个<header>
* <footer>标签表示网页、文章或章节的尾部。如果用于整张网页的尾部，就称为“页尾”，通常包含版权信息或者其他相关信息
* <main>标签表示页面的主体内容，一个页面只能有一个<main>
* <article>标签表示页面里面一段完整的内容，即使页面的其他部分不存在，也具有独立使用的意义，通常用来表示一篇文章或者一个论坛帖子
* <aside>标签用来放置与网页或文章主要内容间接相关的部分
  - 网页级别的<aside>，可以用来放置侧边栏，但不一定就在页面的侧边
  - 文章级别的<aside>，可以用来放置评论或注释
* <section>标签表示一个含有主题的独立部分，通常用在文档里面表示一个章节
  - 适合幻灯片展示的页面,每个<section>代表一个幻灯片
* <nav>标签用于放置页面或文档的导航信息
* 标题 <h1> ~ <h6> 表示文章标题 `<h1>这是一个标题</h1>`
  - 如果主标题包含多级标题（比如带有副标题），那么可以使用<hgroup>标签，将多级标题放在其中

## 块级元素 block

* 默认占据一个独立的区域，在网页上会自动另起一行，占据 100% 的宽度
* dl,dt,dd,blockquote,<div>、<p>、<h1>、<table>、<form>、<ul>、<ol>、<li>、<pre>
* 默认情况下，宽度自动填满其父元素宽度
* 可以容纳内联元素和其他块元素
* display属性为block
* 垂直相邻外边距margin会合并
* 左右都有换行符
* 可以设置width和height属性

## 行内元素 inline

* 默认与其他元素在同一行，不产生换行
* strong,select,em,button,textarea,td <span>、<font>、<b>、<i>、<u>、<s>、<a>、<input>、<label>、<img>
* 没有width和height属性
  - 宽度只与内容有关
  - 高度随字体大小而改变
* 只能容纳文本或者其他行内元素
* display属性为inline
* 水平方向的padding-left、padding-right、margin-left、margin-right都产生边距效果
* 竖直方向的padding-top、padding-bottom、margin-top、margin-bottom却不会产生边距效果

## 元素 Element

* 格式化
  - 文本
    + <big> 定义大号字
    + <small> 定义小号字
  - 计算机输出
    + <samp>  定义计算机代码样本
    + <tt>  定义打字机代码
    + <var> 定义变量
  - 引用
    + <acronym> 定义首字母缩写
    + <dfn> 定义一个定义项目

## 文本标签

* <div>是一个通用标签，表示一个区块（division）。它没有语义，如果网页需要一个块级元素容器，又没有其他合适的标签，就可以使用这个标签
  - 最常见用途就是提供 CSS 的钩子，用来指定各种样式
  - 样式上需要多个块级元素组合在一起，就可以使用<div>,这应该是最后的措施，带有语义的块级标签始终应该优先使用，当且仅当没有其他语义元素合适时，才可以使用<div>
  - 常与 CSS 一起使用，用来布局网页设置样式属性
  - 文档布局:分组 HTML 元素的块级元素
* <p>标签是一个块级元素，代表文章的一个段落（paragraph）
  - 不仅是文本，任何想以段落显示的内容，比如图片和表单项，都可以放进<p>元素
* <span>是一个通用目的的行内标签（即不会产生换行），不带有任何语义
  - 通常用作 CSS 样式的钩子，如果需要对某些行内内容指定样式，就可以把它们放置在<span>
  - 用于对文档中的行内元素进行组合。标签提供了一种将文本的一部分或者文档的一部分独立出来的方式
  - 当对它应用样式时才会产生视觉上的变化。否则与其他文本不会任何视觉上的差异
* <br>让网页产生一个换行效果。该标签是单独使用的，没有闭合标签
  - 对于诗歌和地址的换行非常有用
  - 块级元素间隔，不要使用<br>来产生，而要使用 CSS 指定
* <wbr>标签跟<br>很相似，表示一个可选的断行。如果一行的宽度足够，则不断行；如果宽度不够，需要断行，就在<wbr>的位置的断行
  - 为了防止浏览器在一个很长的单词中间，不正确地断行或者不断行，所以事先标明可以断行的位置
* <hr>用来在一篇文章中分隔两个不同的主题，浏览器会将其渲染为一根水平线。该标签是单独使用的，没有闭合标签
* <pre>是一个块级元素，表示保留原来的格式（preformatted），即浏览器会保留该标签内部原始的换行和空格。浏览器默认以等宽字体显示标签内容
  - 只保留空格和换行，不会保留 HTML 标签
* <strong>是一个行内元素，表示它包含的内容具有很强的重要性，需要引起注意。浏览器会以粗体显示内容
  - <b>与<strong>很相似，也表示它包含的内容需要引起注意，浏览器会加粗显示
* <em>是一个行内标签，表示强调（emphasize），浏览器会以斜体显示它包含的内容
  - <i>标签与<em>相似，也表示与其他地方有所区别，浏览器会以斜体显示。它是 Italic 的缩写
* <sub>标签将内容变为下标，<sup>标签将内容变为上标。都是行内元素，主要用于数学公式、分子式
* <var>标签表示代码或数学公式的变量
* <u>标签是一个行内元素，表示对内容提供某种注释，提醒用户这里可能有问题，基本上只用来表示拼写错误。浏览器默认以下划线渲染内容
  - <u>会产生下划线，由于链接也默认带有下划线，所以必须非常小心使用<u>标签，避免用户误以为可以点击。万一确有必要使用，最好使用 CSS 改变<u>的默认样式
* <s>标签是一个行内元素，为内容加上删除线
* <blockquote>是一个块级标签，表示引用他人的话
  - cite属性，它的值是一个网址，表示引言来源，不会显示在网页上
* <cite>标签表示引言出处或者作者，浏览器默认使用斜体显示这部分内容
* <q>是一个行内标签，也表示引用。它与<blockquote>的区别，就是它不会产生换行
* <code>标签是一个行内元素，表示标签内容是计算机代码，浏览器默认会以等宽字体显示
  - 表示多行代码，<code>标签必须放在<pre>内部。<code>本身仅表示一行代码
* <kbd>标签是一个行内元素，原意是用户从键盘输入的内容，现在扩展到各种输入，包括语音输入。浏览器默认以等宽字体显示标签内容
  - 可以嵌套，方便指定样式
* <samp>标签是一个行内元素，表示计算机程序输出内容的一个例子。浏览器默认以等宽字体显示
* <mark>是一个行内标签，表示突出显示的内容。Chrome 浏览器默认会以亮黄色背景，显示该标签的内容
  - 适合在引用的内容（<q>或<blockquote>）中，标记出需要关注的句子
  - 用于在搜索结果中，标记出匹配的关键词
* <small>是一个行内标签，浏览器会将它包含的内容，以小一号的字号显示，不需要使用 CSS 样式。它通常用于文章附带的版权信息或法律信息
* <time>是一个行内标签，为跟时间相关的内容提供机器可读的格式
  - datetime属性，用来指定机器可读的日期
* <data>标签与<time>类似，也是提供机器可读的内容，但是用于非时间的场合
* <address>标签是一个块级元素，表示某人或某个组织的联系方式
  - 内容不得有非联系信息，比如发布日期
  - 不能嵌套，并且内部不能有标题标签
  - 会放在<footer>里面
* <abbr>标签是一个行内元素，表示标签内容是一个缩写
  - title属性给出缩写的完整形式，或者缩写的描述,鼠标悬停在该元素上方时，title属性值作为提示，会完整显示出来
* <ins>标签是一个行内元素，表示原始文档添加（insert）的内容,<del>与之类似，表示删除（delete）的内容。它们通常用于展示文档的删改
  - cite：该属性的值是一个 URL，表示该网址可以解释本次删改。
  - datetime：表示删改发生的时间
* <dfn>是一个行内元素，表示标签内容是一个术语（definition），本段或本句包含它的定义
* <ruby>标签表示文字的语音注释，主要用于东亚文字，比如汉语拼音和日语的片假名。它默认将语音注释，以小字体显示在文字的上方,内部还有许多配套的标签
  - <rp>标签的用处，是为不支持语音注释的浏览器，提供一个兼容方案,一般用于放置圆括号
  - <rt>标签用于放置语音注释
  - <rb>标签用于划分文字单位
  - <rbc>标签表示一组文字，通常包含多个<rb>元素
  - <rtc>标签表示一组语音注释，跟<rbc>对应
* <bdo>标签是一个行内元素，表示文字方向与网页主体内容的方向不一致

## 列表标签

* 有序列表:<ol>标签是一个有序列表容器（ordered list），会在内部的列表项前面产生数字编号。列表项的顺序有意义时，比如排名，就会采用这个标签
  - reversed属性产生倒序的数字列表
  - start属性的值是一个整数，表示数字列表的起始编号
  - type属性指定数字编号的样式
    + a：小写字母
    + A：大写字母
    + i：小写罗马数字
    + I：大写罗马数字
    + 1：整数（默认值）
* 无序列表:<ul>标签是一个无序列表容器（unordered list），会在内部的列表项前面产生实心小圆点，作为列表符号。列表项的顺序无意义时，采用这个标签
  - type
    + disc
    + circle
    + square
* <li>表示列表项，用在<ol>或<ul>容器之中
  - <ol>之中，<li>有一个value属性，定义当前列表项的编号，后面列表项会从这个值开始编号
* <dl>标签是一个块级元素，表示一组术语的列表（description list）
  - 术语名 description term 由<dt>标签定义
  - 术语解释（description detail）由<dd>标签定义
  - <dt>和<dd>都是块级元素，<dd>默认会在<dt>下方缩进显示
  - 多个术语（<dt>）对应一个解释（<dd>），或者多个解释（<dd>）对应一个术语（<dt>），都是合法的
* 支持嵌套

## 图像标签

* <img>标签用于插入图片。单独使用的，没有闭合标签
  - 默认是一个行内元素，与前后的文字处在同一行
  - 默认以原始大小显示。如果图片很大，又与文字处在同一行，那么图片将把当前行的行高撑高，并且图片的底边与文字的底边在同一条水平线上
  - <img>可以放在<a>标签内部，使得图片变成一个可以点击的链接
* 属性
  - src属性指定图片的网址
  - alt属性用来设定图片的文字说明。图片不显示时（比如下载失败，或用户关闭图片加载），图片的位置上会显示该文本
  - width属性和height属性可以指定图片显示时的宽度和高度，单位是像素或百分比,可以用 CSS 设置，所以不建议使用这两个属性
    + 只设置了一个，另一个没有设置。这时，浏览器会根据图片的原始大小，自动设置对应比例的图片宽度或高度
  - referrerpolicy:导致的图片加载的 HTTP 请求，默认会带有Referer的头信息。referrerpolicy属性对这个行为进行设置
  - 图片和网页属于不同的网站，网页加载图片就会导致跨域请求，对方服务器可能要求跨域认证,crossorigin属性用来告诉浏览器，是否采用跨域的形式下载图片，默认是不采用，打开了这个属性，HTTP 请求的头信息里面，就会加入origin字段，给出请求发出的域名
    + anonymous：跨域请求不带有用户凭证（通常是 Cookie）
    + use-credentials：跨域请求带有用户凭证
  - loading：浏览器的默认行为是，只要解析到<img>标签，就开始加载图片。对于很长的网页，这样做很浪费带宽，因为用户不一定会往下滚动，一直看到网页结束
    + loading属性改变了这个行为，可以指定图片的懒加载，即图片默认不加载，只有即将滚动进入视口，变成用户可见时才会加载，这样就节省了带宽
    + 值
      * auto：浏览器默认行为，等同于不使用loading属性。
      * lazy：启用懒加载。
      * eager：立即加载资源，无论它在页面上的哪个位置
  - <figure>标签可以理解为一个图像区块，将图像和相关信息封装在一起
    + 可以封装引言、代码、诗歌等等。它等于是一个将主体内容与附加信息，封装在一起的语义容器
  - <figcaption>是它的可选子元素，表示图像的文本描述，通常用于放置标题，可以出现多个
  - align
    + top middle bottom
    + left right:浮动至段落的左边或右边
* 所有情况默认插入的都是同一张图像,问题
  - 体积：桌面端显示的是大尺寸的图像，文件体积较大。手机的屏幕较小，只需要小尺寸的图像，可以节省带宽，加速网页渲染
  - 像素密度：桌面显示器一般是单倍像素密度，而手机的显示屏往往是多倍像素密度，即显示时多个像素合成为一个像素，这种屏幕称为 Retina 屏幕
    + 在桌面端很清晰，放到手机上会有点模糊，因为图像没有那么高的像素密度，浏览器自动把图像的每个像素复制到周围像素，满足像素密度的要求，导致图像的锐利度有所下降
  - 视觉风格：桌面显示器的面积较大，图像可以容纳更多细节。手机的屏幕较小，许多细节是看不清的，需要突出重点
* srcset属性：用来指定多张图像，适应不同像素密度的屏幕
  - 值是一个逗号分隔的字符串，每个部分都是一张图像的 URL，后面接一个空格，然后是像素密度的描述符
  - 图像 URL 后面的像素密度描述符，格式是像素密度倍数 + 字母x，浏览器根据当前设备的像素密度，选择需要加载的图像
* sizes属性：像素密度的适配，只适合显示区域一样大小的图像
  - 属性的值是一个逗号分隔的字符串，除了最后一部分，前面每个部分都是一个放在括号里面的媒体查询表达式，后面是一个空格，再加上图像的显示宽度
* <picture>是一个容器标签，内部使用<source>和<img>，指定不同情况下加载的图像
  - 内部的<source>标签，主要使用media属性和srcset属性。media属性给出媒体查询表达式，srcset属性就是<img>标签的srcset属性，给出加载的图像文件。sizes属性其实这里也可以用，但由于有了media属性，就没有必要了
  - 浏览器按照<source>标签出现的顺序，依次判断当前设备是否满足media属性的媒体查询表达式，如果满足就加载srcset属性指定的图片文件，并且不再执行后面的<source>标签和<img>标签
  - <img>标签是默认情况下加载的图像，用来满足上面所有<source>都不匹配的情况，或者不支持<picture>的老式浏览器
  - <picture>标签还可以用来选择不同格式的图像。比如，如果当前浏览器支持 Webp 格式，就加载这种格式的图像，否则加载 PNG 图像

### 属性

* Backgrounds
  - Bgcolor:将背景设置为某种颜色
  - Background:景设置为图像。属性值为图像的URL
    + 增加了页面的加载时间
    + 否与页面中的其他图象搭配良好
    + 是否与页面中的文字颜色搭配良好
    + 平铺效果怎么样
    + 文字的注意力被背景图像喧宾夺主

## 响应式设计 responsive web design

* 网页在不同尺寸的设备上，都能产生良好的显示效果
* JavaScript 和 CSS 都可以实现。这里只介绍语义性最好的 HTML 方法，浏览器原生支持

## 链接标签

* 链接通过<a>标签表示，用户点击后，浏览器会跳转到指定的网址 `<a href="http://www.runoob.com">这是一个链接</a>`
  - 内部不仅可以放置文字，也可以放置其他元素，比如段落、图像、多媒体等等
  - target属性指定如何展示打开的链接。它可以是在指定的窗口打开，也可以在<iframe>里面打开
    + _self：当前窗口打开，这是默认值
    + _blank：新窗口打开
    + _parent：上层窗口打开，这通常用于从父窗口打开的子窗口，或者<iframe>里面的链接。如果当前窗口没有上层窗口，这个值等同于_self
    + _top：顶层窗口打开。如果当前窗口就是顶层窗口，这个值等同于_self
  - href属性给出链接指向的网址。它的值应该是一个 URL 或者锚点
    + url
    + #id:name='id'规定锚（anchor）的名称 直接跳至该命名锚
    + email:mailto:webmaster@example.com
  - hreflang属性给出链接指向的网址所使用的语言，纯粹是提示性的，没有实际功能
  - title属性给出链接的说明信息。鼠标悬停在链接上方时，浏览器会将这个属性的值，以提示块的形式显示出来
  - rel属性说明链接与当前页面的关系
    + alternate：当前文档的另一种形式，比如翻译。
    + author：作者链接。
    + bookmark：用作书签的永久地址。
    + external：当前文档的外部参考文档。
    + help：帮助链接。
    + license：许可证链接。
    + next：系列文档的下一篇。
    + nofollow：告诉搜索引擎忽略该链接，主要用于用户提交的内容，防止有人企图通过添加链接，提高该链接的搜索排名。
    + noreferrer：告诉浏览器打开链接时，不要将当前网址作为 HTTP 头信息的Referer字段发送出去，这样可以隐藏点击的来源。
    + noopener：告诉浏览器打开链接时，不让链接窗口通过 JavaScript 的window.opener属性引用原始窗口，这样就提高了安全性。
    + prev：系列文档的上一篇。
    + search：文档的搜索链接。
    + tag：文档的标签链接
  - referrerpolicy属性用于精确设定点击链接时，浏览器发送 HTTP 头信息的Referer字段的行为
    + no-referrer 表示不发送Referer字段
    + no-referrer-when-downgrade
    + origin 只发送源信息（协议+域名+端口）
    + origin-when-cross-origin、unsafe-url
    + same-origin 表示同源时才发送Referer字段
    + strict-origin、strict-origin-when-cross-origin
  - ping属性指定一个网址，用户点击的时候，会向该网址发出一个 POST 请求，通常用于跟踪用户的行为
  - type属性给出链接 URL 的 MIME 类型，比如到底是网页，还是图像或文件。它也是纯粹提示性的属性，没有实际功能
  - download属性表明当前链接用于下载，而不是跳转到另一个 URL
    + 只在链接与网址同源时，才会生效
    + 设置了值，那么这个值就是下载的文件名
* 使用mailto协议指向一个邮件地址，用户点击后，浏览器会打开本机默认的邮件程序，让用户向指定的地址发送邮件，邮件协议还允许指定其他几个邮件要素
  - subject：主题
  - cc：抄送
  - bcc：密送
  - body：邮件内容
* 使用tel协议，创建电话链接
* <link>标签主要用于将当前网页与相关的外部资源联系起来，通常放在<head>元素里面。最常见的用途就是加载 CSS 样式表
  - 可以加载替代样式表，即默认不生效、需要用户手动切换的样式表
  - title属性在这里是必需的，用来在浏览器菜单里面列出这些样式表的名字，供用户选择，以替代默认样式表
  - 加载网站的 favicon 图标文件
  - 用于提供文档的相关链接
  - rel属性表示外部资源与当前文档之间的关系，是<link>标签的必需属性
    + alternate：文档的另一种表现形式的链接，比如打印版。
    + author：文档作者的链接。
    + dns-prefetch：要求浏览器提前执行指定网址的 DNS 查询。
    + help：帮助文档的链接。
    + icon：加载文档的图标文件。
    + license：许可证链接。
    + next：系列文档下一篇的链接。
    + pingback：接收当前文档 pingback 请求的网址。
    + preconnect：要求浏览器提前与给定服务器，建立 HTTP 连接。
    + prefetch：要求浏览器提前下载并缓存指定资源，供下一个页面使用。它的优先级较低，浏览器可以不下载。
    + preload：要求浏览器提前下载并缓存指定资源，当前页面稍后就会用到。它的优先级较高，浏览器必须立即下载。
    + prerender：要求浏览器提前渲染指定链接。这样的话，用户稍后打开该链接，就会立刻显示，感觉非常快。
    + prev：表示当前文档是系列文档的一篇，这里给出上一篇文档的链接。
    + search：提供当前网页的搜索链接。
    + stylesheet：加载一张样式表
  - 资源的预加载
    + <link rel="preload">告诉浏览器尽快下载并缓存资源（如脚本或样式表），该指令优先级较高，浏览器肯定会执行。当加载页面几秒钟后需要该资源时，它会很有用。下载后，浏览器不会对资源执行任何操作，脚本未执行，样式表未应用。它只是缓存，当其他东西需要它时，它立即可用
      *优点：一是允许指定预加载资源的类型，二是允许onload事件的回调函数
      * 配合as属性，告诉浏览器预处理资源的类型
        - "script"
        - "style"
        - "image"
        - "media"
        - "document"
    + <link rel="prefetch">的使用场合是，如果后续的页面需要某个资源，并且希望预加载该资源，以便加速页面渲染。该指令不是强制性的，优先级较低，浏览器不一定会执行
    + <link rel="preconnect">要求浏览器提前与某个域名建立 TCP 连接。当你知道，很快就会请求该域名时，这会很有帮助
    + <link rel="dns-prefetch">要求浏览器提前执行某个域名的 DNS 解析
    + <link rel="prerender">要求浏览器加载某个网页，并且提前渲染它。用户点击指向该网页的链接时，就会立即呈现该页面。如果确定用户下一步会访问该页面，这会很有帮助
  - media属性给出外部资源生效的媒介条件
    + crossorigin：加载外部资源的跨域设置。
    + href：外部资源的网址。
    + referrerpolicy：加载时Referer头信息字段的处理方法。
    + as：rel="preload"或rel="prefetch"时，设置外部资源的类型。
    + type：外部资源的 MIME 类型，目前仅用于rel="preload"或rel="prefetch"的情况。
    + title：加载样式表时，用来标识样式表的名称。
    + sizes：用来声明图标文件的尺寸，比如加载苹果手机的图标文件。
* <script>用于加载脚本代码，目前主要是加载 JavaScript 代码
  - 可以加载外部脚本，src属性给出外部脚本的地址
  - type属性给出脚本的类型，默认是 JavaScript 代码
  - async：该属性指定 JavaScript 代码为异步执行，不是造成阻塞效果，JavaScript 代码默认是同步执行。
  - defer：该属性指定 JavaScript 代码不是立即执行，而是页面解析完成后执行。
  - crossorigin：如果采用这个属性，就会采用跨域的方式加载外部脚本，即 HTTP 请求的头信息会加上origin字段。
  - integrity：给出外部脚本的哈希值，防止脚本被篡改。只有哈希值相符的外部脚本，才会执行。
  - nonce：一个密码随机数，由服务器在 HTTP 头信息里面给出，每次加载脚本都不一样。它相当于给出了内嵌脚本的白名单，只有在白名单内的脚本才能执行。
  - referrerpolicy：HTTP 请求的Referer字段的处理方法
* <noscript>标签用于浏览器不支持或关闭 JavaScript 时，所要显示的内容。用户关闭 JavaScript 可能是为了节省带宽，以延长手机电池寿命，或者为了防止追踪，保护隐私

### 颜色

* 一个十六进制符号来定义，这个符号由红色、绿色和蓝色的值组成（RGB）
  - #0000FF
  - rgb(0,0,255)
  - blue

## 多媒体标签

* <video>标签是一个块级元素，用于放置视频。如果浏览器支持加载的视频格式，就会显示一个播放器，否则显示<video>内部的子元素
  - src：视频文件的网址。
  - controls：播放器是否显示控制栏。该属性是布尔属性，不用赋值，只要写上属性名，就表示打开。如果不想使用浏览器默认的播放器，而想使用自定义播放器，就不要使用该属性。
  - width：视频播放器的宽度，单位像素。
  - height：视频播放器的高度，单位像素。
  - autoplay：视频是否自动播放，该属性为布尔属性。
  - loop：视频是否循环播放，该属性为布尔属性。
  - muted：是否默认静音，该属性为布尔属性。
  - poster：视频播放器的封面图片的 URL。
  - preload：视频播放之前，是否缓冲视频文件。这个属性仅适合没有设置autoplay的情况。它有三个值，分别是none（不缓冲）、metadata（仅仅缓冲视频文件的元数据）、auto（可以缓冲整个文件）。
  - playsinline：iPhone 的 Safari 浏览器播放视频时，会自动全屏，该属性可以禁止这种行为。该属性为布尔属性。
  - crossorigin：是否采用跨域的方式加载视频。它可以取两个值，分别是anonymous（跨域请求时，不发送用户凭证，主要是 Cookie），use-credentials（跨域时发送用户凭证）。
  - currentTime：指定当前播放位置（双精度浮点数，单位为秒）。如果尚未开始播放，则会从这个属性指定的位置开始播放。
  - duration：该属性只读，指示时间轴上的持续播放时间（总长度），值为双精度浮点数（单位为秒）。如果是流媒体，没有已知的结束时间，属性值为+Infinity
  - 为了避免浏览器不支持视频格式，可以使用<source>标签，放置同一个视频的多种格式
* <track>标签用于指定视频的字幕，格式是 WebVTT （.vtt文件），放置在<video>标签内部。它是一个单独使用的标签，没有结束标签
  - label：播放器显示的字幕名称，供用户选择。
  - kind：字幕的类型，默认是subtitles，表示将原始声音成翻译外国文字，比如英文视频提供中文字幕。另一个常见的值是captions，表示原始声音的文字描述，通常是视频原始使用的语言，比如英文视频提供英文字幕。
  - src：vtt 字幕文件的网址。
  - srclang：字幕的语言，必须是有效的语言代码。
  - default：是否默认打开，布尔属性
* <audio>标签是一个块级元素，用于放置音频，用法与<video>标签基本一致
  - autoplay：是否自动播放，布尔属性。
  - controls：是否显示播放工具栏，布尔属性。如果不设置，浏览器不显示播放界面，通常用于背景音乐。
  - crossorigin：是否使用跨域方式请求。
  - loop：是否循环播放，布尔属性。
  - muted：是否静音，布尔属性。
  - preload：音频文件的缓冲设置。
  - src：音频文件网址
* <source>标签用于<picture>、<video>、<audio>的内部，用于指定一项外部资源。单标签是单独使用的，没有结束标签
  - type：指定外部资源的 MIME 类型。
  - src：指定源文件，用于<video>和<audio>。
  - srcset：指定不同条件下加载的图像文件，用于<picture>。
  - media：指定媒体查询表达式，用于<picture>。
  - sizes：指定不同设备的显示大小，用于<picture>，必须跟srcset搭配使用
* <embed>标签用于嵌入外部内容，这个外部内容通常由浏览器插件负责控制。由于浏览器的默认插件都不一致，很可能不是所有浏览器的用户都能访问这部分内容，建议谨慎使用
  - height：显示高度，单位为像素，不允许百分比。
  - width：显示宽度，单位为像素，不允许百分比。
  - src：嵌入的资源的 URL。
  - type：嵌入资源的 MIME 类型
* <object>标签作用跟<embed>相似，也是插入外部资源，由浏览器插件处理。它可以视为<embed>的替代品，有标准化行为，只限于插入少数几种通用资源，没有历史遗留问题，因此更推荐使用
  - data：嵌入的资源的 URL。
  - form：当前网页中相关联表单的id属性（如果有的话）。
  - height：资源的显示高度，单位为像素，不能使用百分比。
  - width：资源的显示宽度，单位为像素，不能使用百分比。
  - type：资源的 MIME 类型。
  - typemustmatch：布尔属性，表示data属性与type属性是否必须匹配

### 框架 iframe

* <iframe>标签生成一个指定区域，在该区域中嵌入其他网页。它是一个容器元素，如果浏览器不支持<iframe>，就会显示内部的子元素
  - 不能放在body中，而是用于对整个页面布局的效果
  - allowfullscreen：允许嵌入的网页全屏显示，需要全屏 API 的支持，请参考相关的 JavaScript 教程。
  - frameborder：是否绘制边框，0为不绘制，1为绘制（默认值）。建议尽量少用这个属性，而是在 CSS 里面设置样式。
  - src：嵌入的网页的 URL。
  - width：显示区域的宽度。
  - height：显示区域的高度。
  - sandbox：设置嵌入的网页权限
    + 当作布尔属性使用，表示打开所有限制
    + allow-forms：允许提交表单。
    + allow-modals：允许提示框，即允许执行window.alert()等会产生弹出提示框的 JavaScript 方法。
    + allow-popups：允许嵌入的网页使用window.open()方法弹出窗口。
    + allow-popups-to-escape-sandbox：允许弹出窗口不受沙箱的限制。
    + allow-orientation-lock：允许嵌入的网页用脚本锁定屏幕的方向，即横屏或竖屏。
    + allow-pointer-lock：允许嵌入的网页使用 Pointer Lock API，锁定鼠标的移动。
    + allow-presentation：允许嵌入的网页使用 Presentation API。
    + allow-same-origin：不打开该项限制，将使得所有加载的网页都视为跨域。
    + allow-scripts：允许嵌入的网页运行脚本（但不创建弹出窗口）。
    + allow-storage-access-by-user-activation：允许在用户激动的情况下，嵌入的网页通过 Storage Access API 访问父窗口的储存。
    + allow-top-navigation：允许嵌入的网页对顶级窗口进行导航。
    + allow-top-navigation-by-user-activation：允许嵌入的网页对顶级窗口进行导航，但必须由用户激活。
    + allow-downloads-without-user-activation：允许在没有用户激活的情况下，嵌入的网页启动下载
  - importance：浏览器下载嵌入的网页的优先级，可以设置三个值。high表示高优先级，low表示低优先级，auto表示由浏览器自行决定。
  - name：内嵌窗口的名称，可以用于<a>、<form>、<base>的target属性。
  - referrerpolicy：请求嵌入网页时，HTTP 请求的Referer字段的设置
  - loading属性可以触发<iframe>网页的懒加载
    + auto：浏览器的默认行为，与不使用loading属性效果相同。
    + lazy：<iframe>的懒加载，即将滚动进入视口时开始加载。
    + eager：立即加载资源，无论在页面上的位置如何
    + 如果<iframe>是隐藏的，则loading属性无效，将会立即加载。只要满足以下任一个条件，Chrome 浏览器就会认为<iframe>是隐藏的
      *<iframe>的宽度和高度为4像素或更小。
      * 样式设为display: none或visibility: hidden。
      * 使用定位坐标为负X或负Y，将<iframe>放置在屏幕外
* rows/columns 的值规定了每行或每列占据屏幕的面积
  - 如果有可见边框，用户可以拖动边框来改变它的大小。为了避免这种情况发生，可以在 <frame> 标签中加入：noresize="noresize"。不可拖动
* Frame:定义了放置在每个框架中的 HTML 文档
  - 为不支持框架的浏览器添加 `<noframes>` 标签:你添加包含一段文本的 `<noframes>` 标签，就必须将这段文字嵌套于 `<body></body>` 标签内

- 导航框架:主页中name的值和target的值对应时，链接网站就显示在对应框体内，从而实现了局部刷新，就是导航
- 跳转至框架内的一个指定的节
  + `<frame src="../example/html/link.html#C10">`
  + link.html 中`<a name="C10"> 进行标识。`
- 可用作链接的目标（target）。链接的 target 属性必须引用 iframe 的 name 属性

## 表格 table

* 表格（table）以行（row）和列（column）的形式展示数据
* 支持嵌套：表格、列表
* 创建布局的一种简单的方式
* <table>是一个块级容器标签，所有表格内容都要放在这个标签里面
  - width：表格的宽度，默认单位是px(像素)。
  - height：表格的高度。
  - border：边框的粗细,不定义边框属性，表格将不显示边框
  - bordercolor：边框颜色。
  - rules：合并单元格边线。取值：All
  - cellpadding：单元格边线到内容之间的距离(填充距离)
  - cellspacing：两个单元格之间的距离(间距)
  - background：背景图片
  - bgColor：表格背景颜色
  - align：表格水平对齐方式，取值：left、center、right
  - frame：边框：box above below hsides(上下) vsides（左右）
* <caption>总是<table>里面的第一个子元素，表示表格的标题。该元素是可选的
* <thead>、<tbody>、<tfoot>都是块级容器元素，且都是<table>的一级子元素，分别表示表头、表体和表尾,都是可选的。如果使用了<thead>，那么<tbody>和<tfoot>一定在<thead>的后面。如果使用了<tbody>，那么<tfoot>一定在<tbody>后面.大型表格内部可以使用多个<tbody>，表示连续的多个部分
* <colgroup>是<table>的一级子元素，用来包含一组列的定义
* <col>是<colgroup>的子元素，用来定义表格的一列
  - 不仅是一个单独使用的标签，没有结束标志，而且还是一个空元素，没有子元素。主要作用，除了申明表格结构，还可以为表格附加样式
  - span属性，值为正整数，默认为1。如果大于1，就表示该列的宽度包含连续的多列
* <tr>标签表示表格的一行（table row）。如果表格有<thead>、<tbody>、<tfoot>，那么<tr>就放在这些容器元素之中，否则直接放在<table>的下一级
  - height：行高
  - backgroundColor：背景色
  - background：背景图片
  - align：水平对齐
  - valign：垂直对齐，取值：top、middle、bottom
* <th>和<td>都用来定义表格的单元格。其中，<th>是标题单元格，<td>是数据单元格
  - width：单元格宽度
  - height：单元格高度
  - bgColor：背景色
  - background：背景图片
  - align：水平对齐，首列左对齐，其它右对齐
  - valign：垂直对齐
  - colspan：单元格跨越的栏数
  - rowspan：单元格跨越的行数
  - headers属性:单元格对应哪个表头
  - scope属性只有<th>标签支持，一般不在<td>标签使用，表示该<th>单元格到底是栏的标题，还是列的标题
    + row：该行的所有单元格，都与该标题单元格相关。
    + col：该列的所有单元格，都与该标题单元格相关。
    + rowgroup：多行组成的一个行组的所有单元格，都与该标题单元格相关，可以与rowspan属性配合使用。
    + colgroup：多列组成的一个列组的所有单元格，都与该标题单元格相关，可以与colspan属性配合使用。
    + auto：默认值，表示由浏览器自行决定
  - 空值：`<td>&nbsp;</td>`

## 表单 form

* 用户输入信息与网页互动的一种形式。大多数情况下，用户提交的信息会发给服务器
* 由一种或多种的小部件组成,这些小部件称为控件（controls）
* <form>标签用来定义一个表单，所有表单内容放到这个容器元素之中
  - accept-charset：服务器接受的字符编码列表，使用空格分隔，默认与网页编码相同。
  - action：服务器接收数据的 URL。
  - autocomplete：如果用户没有填写某个控件，浏览器是否可以自动填写该值。它的可能取值分别为off（不自动填写）和on（自动填写）。
  - method：提交数据的 HTTP 方法，可能的值有post（表单数据作为 HTTP 数据体发送），get（表单数据作为 URL 的查询字符串发送），dialog（表单位于<dialog>内部使用）。
  - enctype：当method属性等于post时，该属性指定提交给服务器的 MIME 类型
    + application/x-www-form-urlencoded（默认值）:控件名和控件值都要转义（空格转为+号，非数字和非字母转为%HH的形式，换行转为CR LF），控件名和控件值之间用=分隔。控件按照出现顺序排列，控件之间用&分隔
    + multipart/form-data（文件上传的情况）:用于文件上传。这个类型上传大文件时，会将文件分成多块传送，每一块的 HTTP 头信息都有Content-Disposition属性，值为form-data，以及一个name属性，值为控件名
    + text/plain
  - name：表单的名称，应该在网页中是唯一的。注意，如果一个控件没有设置name属性，那么这个控件的值就不会作为键值对，向服务器发送。
  - novalidate：布尔属性，表单提交时是否取消验证。
  - target：在哪个窗口展示服务器返回的数据，可能的值有_self（当前窗口），_blank（新建窗口），_parent（父窗口），_top（顶层窗口），<iframe>标签的name属性（即表单返回结果展示在<iframe>窗口）
* <fieldset>标签是一个块级容器标签，表示控件的集合，用于将一组相关控件组合成一组
  - disabled：布尔属性，一旦设置会使得<fieldset>内部包含的控件都不可用，都变成灰色状态。
  - form：指定控件组所属的<form>，它的值等于<form>的id属性。
  - name：该控件组的名称
* <legend>标签用来设置<fieldset>控件组的标题，通常是<fieldset>内部的第一个元素，会嵌入显示在控件组的上边框里面
* <label>标签是一个行内元素，提供控件的文字说明，帮助用户理解控件的目的
  - 增加了控件的可用性。有些控件比较小（比如单选框），不容易点击，那么点击对应的<label>标签，也能选中该控件。点击<label>，就相当于控件本身的click事
  - for属性关联相对应的控件，它的值是对应控件的id属性。所以，控件最好设置id属性
  - 一个控件可以有多个关联的<label>标签
* <input>标签是一个行内元素，用来接收用户的输入。它是一个单独使用的标签，没有结束标志
  - autofocus：布尔属性，是否在页面加载时自动获得焦点。
  - disabled：布尔属性，是否禁用该控件。一旦设置，该控件将变灰，用户可以看到，但是无法操作。
  - form：关联表单的id属性。设置了该属性后，控件可以放置在页面的任何位置，否则只能放在<form>内部。
  - list：关联的<datalist>的id属性，设置该控件相关的数据列表，详见后文。
  - name：控件的名称，主要用于向服务器提交数据时，控件键值对的键名。注意，只有设置了name属性的控件，才会向服务器提交，不设置就不会提交。
  - readonly：布尔属性，是否为只读
  - required：布尔属性，是否为必填
  - type：控件类型
    + 默认值 type="text"是普通的文本输入框，用来输入单行文本。如果用户输入换行符，换行符会自动从输入中删除
      * maxlength：可以输入的最大字符数，值为一个非负整数。
      * minlength：可以输入的最小字符数，值为一个非负整数，且必须小于maxlength。
      * pattern：用户输入必须匹配的正则表达式，比如要求用户输入4个～8个英文字符，可以写成pattern="[a-z]{4,8}"。如果用户输入不符合要求，浏览器会弹出提示，不会提交表单。
      * placeholder：输入字段为空时，用于提示的示例值。只要用户没有任何字符，该提示就会出现，否则会消失。
      * readonly：布尔属性，表示该输入框是只读的，用户只能看，不能输入。
      * size：表示输入框的显示长度有多少个字符宽，它的值是一个正整数，默认等于20。超过这个数字的字符，必须移动光标才能看到。
      * spellcheck：是否对用户输入启用拼写检查，可能的值为true或false
    + type="search"是一个用于搜索的文本输入框，基本等同于type="text"。某些浏览器会在输入的时候，在输入框的尾部显示一个删除按钮，点击就会删除所有输入，让用户从头开始输入
    + type="button"是没有默认行为的按钮，通常脚本指定click事件的监听函数来使用
    + type="submit"是表单的提交按钮。用户点击这个按钮，就会把表单提交给服务器
      * 不指定value属性，浏览器会在提交按钮上显示默认的文字，通常是Submit
      * formaction：提交表单数据的服务器 URL。
      * formenctype：表单数据的编码类型。
      * formmethod：提交表单使用的 HTTP 方法（get或post）。
      * formnovalidate：一个布尔值，表示数据提交给服务器之前，是否要忽略表单验证。
      * formtarget：收到服务器返回的数据后，在哪一个窗口显示
    + type="image"表示将一个图像文件作为提交按钮，行为和用法与type="submit"完全一致
      * alt：图像无法加载时显示的替代字符串。
      * src：加载的图像 URL。
      * height：图像的显示高度，单位为像素。
      * width：图像的显示宽度，单位为像素。
      * formaction：提交表单数据的服务器 URL。
      * formenctype：表单数据的编码类型。
      * formmethod：提交表单使用的 HTTP 方法（get或post）。
      * formnovalidate：一个布尔值，表示数据提交给服务器之前，是否要忽略表单验证。
      * formtarget：收到服务器返回的数据后，在哪一个窗口显示
    + type="reset"是一个重置按钮，用户点击以后，所有表格控件重置为初始值
    + type="checkbox"是复选框，允许选择或取消选择该选项
      * 显示一个可以点击的选择框，点击可以选中，再次点击可以取消
      * checked属性表示默认选中
      * 多个相关的复选框，可以放在<fieldset>里面
    + type="radio"是单选框，表示一组选择之中，只能选中一项。单选框通常为一个小圆圈，选中时会被填充或突出显示
      * checked：布尔属性，表示是否默认选中当前项。
      * value：用户选中该项时，提交到服务器的值，默认为on'
    + type="email"是一个只能输入电子邮箱的文本输入框。表单提交之前，浏览器会自动验证是否符合电子邮箱的格式，如果不符合就会显示提示，无法提交到服务器
      * multiple的布尔属性，一旦设置，就表示该输入框可以输入多个逗号分隔的电子邮箱
      * maxlength：可以输入的最大字符数。
      * minlength：可以输入的最少字符数。
      * multiple：布尔属性，是否允许输入多个以逗号分隔的电子邮箱。
      * pattern：输入必须匹配的正则表达式。
      * placeholder：输入为空时的显示文本。
      * readonly：布尔属性，该输入框是否只读。
      * size：一个非负整数，表示输入框的显示长度为多少个字符。
      * spellcheck：是否对输入内容启用拼写检查，可能的值为true或false
      * 还可以搭配<datalist>标签，提供输入的备选项
    + type="password"是一个密码输入框。用户的输入会被遮挡，字符通常显示星号（*）或点（·）
      * 输入内容包含换行符（U+000A）和回车符（U+000D），浏览器会自动将这两个字符过滤掉
      * maxlength：可以输入的最大字符数。
      * minlength：可以输入的最少字符数。
      * pattern：输入必须匹配的正则表达式。
      * placeholder：输入为空时的显示文本。
      * readonly：布尔属性，该输入框是否只读。
      * size：一个非负整数，表示输入框的显示长度为多少个字符。
      * autocomplete：是否允许自动填充，可能的值有on（允许自动填充）、off（不允许自动填充）、current-password（填入当前网站保存的密码）、new-password（自动生成一个随机密码）。
      * inputmode：允许用户输入的数据类型，可能的值有none（不使用系统输入法）、text（标准文本输入）、decimal（数字，包含小数）、numeric（数字0-9）等
    + type="file"是一个文件选择框，允许用户选择一个或多个文件，常用于文件上传功能
      * accept：允许选择的文件类型，使用逗号分隔，可以使用 MIME 类型（比如image/jpeg），也可以使用后缀名（比如.doc），还可以使用audio/*（任何音频文件）、video/*（任何视频文件）、image/*（任何图像文件）等表示法。
      * capture：用于捕获图像或视频数据的源，可能的值有user（面向用户的摄像头或麦克风），environment（外接的摄像头或麦克风）。
      * multiple：布尔属性，是否允许用户选择多个文件
    + type="hidden"是一个不显示在页面的控件，用户无法输入它的值，主要用来向服务器传递一些隐藏信息
      * CSRF 攻击会伪造表单数据，那么使用这个控件，可以为每个表单生成一个独一无二的隐藏编号，防止伪造表单提交
    + type="number"是一个数字输入框，只能输入数字。浏览器通常会在输入框的最右侧，显示一个可以点击的上下箭头，点击向上箭头，数字会递增，点击向下箭头，数字会递减
      * max：允许输入的最大数值。
      * min：允许输入的最小数值。
      * placeholder：用户输入为空时，显示的示例值。
      * readonly：布尔属性，表示该控件是否为只读。
      * step：点击向上和向下箭头时，数值每次递减的步长值。如果用户输入的值，不符合步长值的设定，浏览器会自动四舍五入到最近似的值。默认的步长值是1，如果初始的value属性设为1.5，那么点击向上箭头得到2.5，点击向下箭头得到0.5
    + type="range"是一个滑块，用户拖动滑块，选择给定范围之中的一个数值。因为拖动产生的值是不精确的，如果需要精确数值，不建议使用这个控件。常见的例子是调节音量
      * max：允许的最大值，默认为100。
      * min：允许的最小值，默认为0。
      * step：步长值，默认为1
      * 与<datalist>标签配合使用，可以在滑动区域产生刻度
    + type="url"是一个只能输入网址的文本框。提交表单之前，浏览器会自动检查网址格式是否正确，如果不正确，就会无法提交
      * maxlength：允许的最大字符数。
      * minlength：允许的最少字符串。
      * pattern：输入内容必须匹配的正则表达式。
      * placeholder：输入为空时显示的示例文本。
      * readonly：布尔属性，表示该控件的内容是否只读。
      * size：一个非负整数，表示该输入框显示宽度为多少个字符。
      * spellcheck：是否启动拼写检查，可能的值为true（启用）和false（不启用)
    + type="tel"是一个只能输入电话号码的输入框。由于全世界的电话号码格式都不相同，因此浏览器没有默认的验证模式，大多数时候需要自定义验证
    + type="color"是一个选择颜色的控件，它的值一律都是#rrggbb格式
    + type="date"是一个只能输入日期的输入框，用户可以输入年月日，但是不能输入时分秒。输入格式是YYYY-MM-DD
    + type="time"是一个只能输入时间的输入框，可以输入时分秒，不能输入年月日。日期格式是24小时制的hh:mm，如果包括秒数，格式则是hh:mm:ss
    + type="month"是一个只能输入年份和月份的输入框，格式为YYYY-MM
    + type="week"是一个输入一年中第几周的输入框。格式为yyyy-Www
    + type="datetime-local"是一个时间输入框，让用户输入年月日和时分，格式为yyyy-MM-ddThh:mm,不支持秒
  - value：控件的值
* <button>标签会生成一个可以点击的按钮，没有默认行为，通常需要用type属性或脚本指定按钮的功能
  - autofocus：布尔属性，表示网页加载时，焦点就在这个按钮。网页里面只能有一个元素，具有这个属性。
  - disabled：布尔属性，表示按钮不可用，会导致按钮变灰，不可点击。
  - name：按钮的名称（与value属性配合使用），将以name=value的形式，随表单一起提交到服务器。
  - value：按钮的值（与name属性配合使用），将以name=value的形式，随表单一起提交到服务器。
  - type：按钮的类型，可能的值有三种：submit（点击后将数据提交给服务器），reset（将所有控件的值重置为初始值），button（没有默认行为，由脚本指定按钮的行为）。
  - form：指定按钮关联的<form>表单，值为<form>的id属性。如果省略该属性，默认关联按钮所在父表单。
  - formaction：数据提交到服务器的目标 URL，会覆盖<form>元素的action属性。
  - formenctype：数据提交到服务器的编码方式，会覆盖<form>元素的enctype属性。可能的值有三种：application/x-www-form-urlencoded（默认值），multipart/form-data（只用于文件上传），text/plain。
  - formmethod：数据提交到服务器使用的 HTTP 方法，会覆盖<form>元素的method属性，可能的值为post或get。
  - formnovalidate：布尔属性，数据提交到服务器时关闭本地验证，会覆盖<form>元素的novalidate属性。
  - formtarget：数据提交到服务器后，展示服务器返回数据的窗口，会覆盖<form>元素的target属性。可能的值有_self（当前窗口），_blank（新的空窗口）、_parent（父窗口）、_top（顶层窗口）
* <textarea>是一个块级元素，用来生成多行的文本框
  - autofocus：布尔属性，是否自动获得焦点。
  - cols：文本框的宽度，单位为字符，默认值为20。
  - disabled：布尔属性，是否禁用该控件。
  - form：关联表单的id属性。
  - maxlength：允许输入的最大字符数。如果未指定此值，用户可以输入无限数量的字符。
  - minlength：允许输入的最小字符数。
  - name：控件的名称。
  - placeholder：输入为空时显示的提示文本。
  - readonly：布尔属性，控件是否为只读。
  - required：布尔属性，控件是否为必填。
  - rows：文本框的高度，单位为行。
  - spellcheck：是否打开浏览器的拼写检查。可能的值有true（打开），default（由父元素或网页设置决定），false（关闭）。
  - wrap：输入的文本是否自动换行。可能的值有hard（浏览器自动插入换行符CR + LF，使得每行不超过控件的宽度），soft（输入内容超过宽度时自动换行，但不会加入新的换行符，并且浏览器保证所有换行符都是CR + LR，这是默认值），off（关闭自动换行，单行长度超过宽度时，会出现水平滚动条）
* <select>标签用于生成一个下拉菜单
  - 菜单项由<option>标签给出，每个<option>代表可以选择的一个值
    + disabled：布尔属性，是否禁用该项
    + label：该项的说明。如果省略，则等于该项的文本内容
    + selected：布尔属性，是否为默认值。显然，一组菜单中，只能有一个菜单项设置该属性,一旦设置，就表示该项是默认选中的菜单项
    + value：该项提交到服务器的值。如果省略，则等于该项的文本内容
  - autofocus：布尔属性，页面加载时是否自动获得焦点
  - disabled：布尔属性，是否禁用当前控件
  - form：关联表单的id属性
  - multiple：布尔属性，是否可以选择多个菜单项。默认情况下，只能选择一项。一旦设置，多数浏览器会显示一个滚动列表框。用户可能需要按住Shift或其他功能键，选中多项
  - name：控件名
  - required：布尔属性，是否为必填控件
  - size：设置了multiple属性时，页面显示时一次可见的行数，其他行需要滚动查看
* <optgroup>表示菜单项的分组，通常用在<select>内部
  - disabled：布尔设置，是否禁用该组。一旦设置，该组所有的菜单项都不可选。
  - label：菜单项的标题
* <datalist>标签是一个容器标签，用于为指定控件提供一组相关数据，通常用于生成输入提示。它的内部使用<option>，生成每个菜单项
* <output>标签是一个行内元素，用于显示用户操作的结果
  - for：关联控件的id属性，表示为该控件的操作结果。
  - form：关联表单的id属性。
  - name：控件的名称
* <progress>标签是一个行内元素，表示任务的完成进度。浏览器通常会将显示为进度条
  - max：进度条的最大值，应该是一个大于0的浮点数。默认值为1。
  - value：进度条的当前值。它必须是0和max属性之间的一个有效浮点数。如果省略了max属性，该值则必须在0和1之间。如果省略了value属性，则进度条会出现滚动，表明正在进行中，无法知道完成的进度
* <meter>标签是一个行内元素，表示指示器，用来显示已知范围内的一个值，很适合用于任务的当前进度、磁盘已用空间、充电量等带有比例性质的场合。浏览器通常会将其显示为一个不会滚动的指示条
  - 子元素，正常情况下不会显示。只有在浏览器不支持<meter>时才会显示

## 其他标签

* <dialog>标签表示一个可以关闭的对话框
  - 默认情况下，对话框是隐藏的，不会在网页上显示。如果要让对话框显示，必须加上open属性
  - 里面，可以放入其他 HTML 元素
  - 提供Dialog.showModal()和Dialog.close()两个方法，用于打开/关闭对话框
  - Dialog.close()方法可以接受一个字符串作为参数，用于传递信息
  - returnValue属性可以读取这个字符串，否则returnValue属性等于提交按钮的value属性
  - Dialog.showModal()方法唤起对话框时，会有一个透明层，阻止用户与对话框外部的内容互动
  - 事件
    + close：对话框关闭时触发
    + cancel：用户按下esc键关闭对话框时触发
* <details>标签用来折叠内容，浏览器会折叠显示该标签的内容
  - open属性，用于默认打开折叠
  - open属性返回<details>当前是打开还是关闭
  - toggle事件，打开或关闭折叠时，都会触发这个事件
* <summary>标签用来定制折叠内容的标题

## 图文不可复制

```
-webkit-user-select: none;
-ms-user-select: none;
-moz-user-select: none;
-khtml-user-select: none;
user-select: none;
```

## 教程

* [HTML 教程](https://wangdoc.com/html)

## 工具

* [lazysizes](https://github.com/aFarkas/lazysizes):High performance and SEO friendly lazy loader for images (responsive and normal), iframes and more, that detects any visibility changes triggered through user interaction, CSS or JavaScript without configuration
* [hakimel/reveal.js](https://github.com/hakimel/reveal.js):The HTML Presentation Framework <http://lab.hakim.se/reveal-js/>
* [html5-boilerplate](https://github.com/h5bp/html5-boilerplate):A professional front-end template for building fast, robust, and adaptable web apps or sites. html5boilerplate.com/

## 参考

* [h5bp/html5-boilerplate](https://github.com/h5bp/html5-boilerplate):A professional front-end template for building fast, robust, and adaptable web apps or sites. <https://html5boilerplate.com/>
* [HTML](https://html.spec.whatwg.org/)
  - [HTML中文](https://whatwg-cn.github.io/html/)
* [dennwc/dom](https://github.com/dennwc/dom):DOM library for Go and WASM
* [Intersection Observer](https://www.w3.org/TR/2018/WD-intersection-observer-20181106/)

* [使用canvas实现和HTML5 video交互的弹幕效果](https://www.zhangxinxu.com/wordpress/2017/09/html5-canvas-video-barrage/)
