# HTML（HyperText Markup Language）

* 超文本标记语言,是一套标记标签 (markup tag);
* HTML 使用标记标签来描述网页,标签或元素(element),格式:<开始标签>内容<结束标签>;
* HTML 文档由嵌套的 HTML 元素构成。
* 元素属性:属性可以在元素中添加附加信息,属性一般描述于开始标签,属性总是以名称/值对的形式出现，比如：name="value"。

## 历史

* 1982年的时候，万维网的发明者Tim Berners-Lee爵士为了让全世界的物理学家能够方便的进行合作与信息共享，造了HTML(HyperText Markup Language) 超文本置标语言
* 1990年，博士发明了世界上第一个浏览器WorldWideWeb
* 在1991年3月，Tim Berners-Lee把HTML介绍给了给他在CERN(欧洲核子研究中心) 工作的朋友，当时网页浏览器被其世界各地的成员用来浏览CERN庞大的电话薄

## 类型

* `<!DOCTYPE>`:为浏览器提供一项信息HTML 是用什么版本编写
* HTML 4.01 规定了三种文档类型
  - Strict
  - Transitional
  - Frameset
* XHTML 1.0 规定了三种 XML 文档类型
  - Strict
  - Transitional
  - Frameset

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
```

## 元素 Element

* `<html>`  定义 HTML 文档。
* `<body>`  定义文档的主体。
  - 页面背景图片:background="../i/eg_background.jpg"
* 注释: `<!-- 这是一个注释 -->`
* 属性
  - class(定义一个或多个类名) 可以累加
  - id(唯一id)
  - style(元素的行内样式（inline style）)
  - title
* 标题 `<h1>这是一个标题</h1>`: h1~h6
* 段落 `<p>这是另外一个段落。</p>`
* 图像 `<img src="/images/logo.png" width="258" height="39" />`
  - align
    + top middle bottom
    + left right:浮动至段落的左边或右边
  - width height
  - 图像作为一个链接:`<a href="../example/html/lastpage.html"> <img border="0" src="../i/eg_buttonnext.gif" /> </a>`
* 水平线: `<hr />`
* 换行: `<br />`
  - 未来的 HTML 版本中，不允许使用没有结束标签（闭合标签）的 HTML 元素
* 格式化
  - 文本
    + <b> 定义粗体文本。
    + <big> 定义大号字。
    + <em>  定义着重文字。
    + <i> 定义斜体字。
    + <small> 定义小号字。
    + <strong>  定义加重语气。
    + <sub> 定义下标字。
    + <sup> 定义上标字。
    + <ins> 定义插入字。
    + <del> 定义删除字
  - 计算机输出
    + <code>  定义计算机代码。
    + <kbd> 定义键盘码。
    + <samp>  定义计算机代码样本。
    + <tt>  定义打字机代码。
    + <var> 定义变量。
    + <pre> 定义预格式文本。
  - 引用
    + <abbr>  定义缩写。
    + <acronym> 定义首字母缩写。
    + <address> 定义地址。
    + <bdo> 定义文字方向。
    + <blockquote>  定义长的引用。
    + <q> 定义短的引用语。
    + <cite>  定义引用、引证。
    + <dfn> 定义一个定义项目。
* 链接 `<a href="http://www.runoob.com">这是一个链接</a>`
  - target:_top(到父级框架) _blank
  - herf
    + url
    + #id:name='id'规定锚（anchor）的名称 直接跳至该命名锚
    + email:mailto:webmaster@example.com
* 表格
  - 支持嵌套：表格、列表
  - 创建布局的一种简单的方式
  - `<table>`属性
     + width：表格的宽度，默认单位是px(像素)。
     + height：表格的高度。
     + border：边框的粗细,不定义边框属性，表格将不显示边框
     + bordercolor：边框颜色。
     + rules：合并单元格边线。取值：All
     + cellpadding：单元格边线到内容之间的距离(填充距离)
     + cellspacing：两个单元格之间的距离(间距)
     + background：背景图片
     + bgColor：表格背景颜色
     + align：表格水平对齐方式，取值：left、center、right
     + frame：边框：box above below hsides(上下) vsides（左右）
  - 标题：`<caption>我的标题</caption>`
  - `<thead>`
  - `<tfoot>`
  - `<col align="right" />`:列定义属性值
  - `<tr>`属性
    + height：行高
    + backgroundColor：背景色
    + background：背景图片
    + align：水平对齐
    + valign：垂直对齐，取值：top、middle、bottom
  - `<td>`或`<th>`属性
    + width：单元格宽度
    + height：单元格高度
    + bgColor：背景色
    + background：背景图片
    + align：水平对齐，首列左对齐，其它右对齐
    + valign：垂直对齐
    + colspan：跨列合并
    + rowspan：跨行合并
    + 空值：`<td>&nbsp;</td>`
* 表单(form):包含表单元素的区域
  - 文本域（Text Fields）
  - lable:为 input 元素定义标注
    + for:属性的值设置为相关元素的 id 属性的值
  - textarea
  - 单选按钮（Radio Buttons）
  - 复选框（Checkboxes）
  - 下拉列表（select）
    + options
      * selected
    + optgroup：定义选项组
  - button
  - Fieldset:数据周围绘制一个带标题的框
  - submit
  - reset
  - password
  - hidden
* 列表
  - 支持嵌套
  - ul:type:disc circle square
    + li
  - ol:type:A a I i
    + li
  - dl:
    + dt dd
* 区块
  - 块级元素(block-level):以新行来开始和结束,在其前后显示折行
    + `<h1>, <p>, <ul>, <table>`
    + `<div>`
      * 经常与 CSS 一起使用，用来布局网页 设置样式属性
      * 文档布局:分组 HTML 元素的块级元素
  - 内联元素(inline):显示时通常不会以新行开始
  - `<b>, <td>, <a>, <img>`
    + `<span>` 用于对文档中的行内元素进行组合。标签提供了一种将文本的一部分或者文档的一部分独立出来的方式。
    + 当对它应用样式时，它才会产生视觉上的变化。否则与其他文本不会任何视觉上的差异。
* address
* blockquote

```html
/*声明为 HTML5 文档*/
<!DOCTYPE html>
<html>
/*<head> 元素包含了文档的元（meta）数据*/
<head>
  <meta charset="utf-8">
  /*<title> 元素描述了文档的标题*/
  <title>菜鸟教程(runoob.com)</title>
  <style type="text/css">
    div#container{width:500px}
    div#header {background-color:#99bbbb;}
    div#menu {background-color:#ffff99; height:200px; width:100px; float:left;}
    div#content {background-color:#EEEEEE; height:200px; width:400px; float:left;}
    div#footer {background-color:#99bbbb; clear:both; text-align:center;}
    h1 {margin-bottom:0;}
    h2 {margin-bottom:0; font-size:14px;}
    ul {margin:0;}
    li {list-style:none;}
  </style>
</head>
/*<body> 元素包含了可见的页面内容*/
<body>
    <h1>我的第一个标题</h1>
    <p>我的第一个段落。</p>

    <table>
      <tr>
          <td>内容</td>
      </tr>
    </table>

    // 锚点
  <a href="#tips">有用的提示</a>
  <a name="tips">基本的注意事项 - 有用的提示</a>
  <a href="javascript:void(0)"
  onclick="(function() {
         window.open(<?= "'" . Yii::app()->createUrl('disclosure/disclosure/users', array('model_id' => $value->id)) . "'" ?>, '_blank');
         location.reload();
         })()">click</a>

<h4>横跨两列的单元格：</h4>
<table border="1">
<tr>
  <th>姓名</th>
  <th colspan="2">电话</th>
</tr>
<tr>
  <td>Bill Gates</td>
  <td>555 77 854</td>
  <td>555 77 855</td>
</tr>
</table>

<h4>横跨两行的单元格：</h4>
<table border="1">
<tr>
  <th>姓名</th>
  <td>Bill Gates</td>
</tr>
<tr>
  <th rowspan="2">电话</th>
  <td>555 77 854</td>
</tr>
<tr>
  <td>555 77 855</td>
</tr>
</table>

<table width="100%" border="1">
  <col align="left" />
  <col align="left" />
  <col align="right" />
  <tr>
    <th>ISBN</th>
    <th>Title</th>
    <th>Price</th>
  </tr>
  <tr>
    <td>3476896</td>
    <td>My first HTML</td>
    <td>$53</td>
  </tr>
</table>

<table width="100%" border="1">
  <colgroup span="2" align="left"></colgroup>
  <colgroup align="right" style="color:#0000FF;"></colgroup>
  <tr>
    <th>ISBN</th>
    <th>Title</th>
    <th>Price</th>
  </tr>
  <tr>
    <td>3476896</td>
    <td>My first HTML</td>
    <td>$53</td>
  </tr>
</table>

<dl>
   <dt>计算机</dt>
   <dd>用来计算的仪器 ... ...</dd>
   <dt>显示器</dt>
   <dd>以视觉方式显示信息的装置 ... ...</dd>
</dl>

<p><span>some text.</span>some other text.</p>

<div id="container">
  <div id="header">
    <h1>Main Title of Web Page</h1>
  </div>
  <div id="menu">
    <h2>Menu</h2>
    <ul>
      <li>HTML</li>
      <li>CSS</li>
      <li>JavaScript</li>
    </ul>
  </div>
  <div id="content">Content goes here</div>
  <div id="footer">Copyright W3School.com.cn</div>
</div>
<table width="500" border="0">
  <tr>
    <td colspan="2" style="background-color:#99bbbb;">
      <h1>Main Title of Web Page</h1>
    </td>
  </tr>

  <tr valign="top">
    <td style="background-color:#ffff99;width:100px;text-align:top;">
      <b>Menu</b><br />
      HTML<br />
      CSS<br />
      JavaScript
    </td>
    <td style="background-color:#EEEEEE;height:200px;width:400px;text-align:top;">
    Content goes here</td>
  </tr>

  <tr>
    <td colspan="2" style="background-color:#99bbbb;text-align:center;">
    Copyright W3School.com.cn</td>
  </tr>
</table>

<form action="HTML_submit" method="get" accept-charset="utf-8">

  First name:  <input type="text" name="firstname" /> <br />
  Last name:  <input type="text" name="lastname" /> <br />

  <input type="radio" name="sex" value="male" /> Male <br />
  <input type="radio" name="sex" value="female" /> Female <br />

  <label for="male">Male</label>
  <input type="radio" name="sex" id="male" />
  <br />
  <label for="female">Female</label>
  <input type="radio" name="sex" id="female" />

  <input type="checkbox" name="bike" /> I have a bike <br />
  <input type="checkbox" name="car" /> I have a car <br />

  <input type="password">
  <input type="hidden">

  <select name="cars">
    <option value="volvo">Volvo</option>
    <option value="saab">Saab</option>
    <option value="fiat">Fiat</option>
    <option value="audi" selected="selected">Audi</option>
  </select>

  <select>
    <optgroup label="Swedish Cars">
      <option value="volvo">Volvo</option>
      <option value="saab">Saab</option>
    </optgroup>
    <optgroup label="German Cars">
      <option value="mercedes">Mercedes</option>
      <option value="audi">Audi</option>
    </optgroup>
  </select>

  <textarea rows="10" cols="30">
  The cat was playing in the garden.

  <input type="button" value="Hello world!">

  <fieldset>
      <legend>健康信息</legend>
      身高：<input type="text" />
      体重：<input type="text" />
  </fieldset>

  <input type="submit" value="Submit" />
</form>

<blockquote>
Text quoted from some source.
</blockquote>

<address>
Address 1<br>
Address 2<br>
City<br>
</address>

</body>
</html>
```

### 属性

* Backgrounds
  - Bgcolor:将背景设置为某种颜色
  - Background:景设置为图像。属性值为图像的URL
    + 增加了页面的加载时间
    + 否与页面中的其他图象搭配良好
    + 是否与页面中的文字颜色搭配良好
    + 平铺效果怎么样
    + 文字的注意力被背景图像喧宾夺主

### 颜色

* 一个十六进制符号来定义，这个符号由红色、绿色和蓝色的值组成（RGB）
  - #0000FF
  - rgb(0,0,255)
  - blue

### 框架(frameset)

在同一个浏览器窗口中显示不止一个页面

* rame不能放在body中，而是用于对整个页面布局的效果
* rows/columns 的值规定了每行或每列占据屏幕的面积
  - 如果有可见边框，用户可以拖动边框来改变它的大小。为了避免这种情况发生，可以在 <frame> 标签中加入：noresize="noresize"。不可拖动
* Frame:定义了放置在每个框架中的 HTML 文档
  - 为不支持框架的浏览器添加 `<noframes>` 标签:你添加包含一段文本的 `<noframes>` 标签，就必须将这段文字嵌套于 `<body></body>` 标签内
- 导航框架:主页中name的值和target的值对应时，链接网站就显示在对应框体内，从而实现了局部刷新，就是导航
- 跳转至框架内的一个指定的节
  + ` <frame src="../example/html/link.html#C10">`
  + link.html 中`<a name="C10"> 进行标识。`
- iframe:网页内显示网页
  + height
  + width
  + Iframe:0 删除边框
  + 可用作链接的目标（target）。链接的 target 属性必须引用 iframe 的 name 属性

```html
<frameset cols="25%,50%,25%">
  <frame src="../example/html/frame_a.html" noresize="noresize">
  <frame src="../example/html/frame_b.html">
  <frame src="../example/html/frame_c.html">

  <noframes>
    <body>您的浏览器无法处理框架！</body>
  </noframes>
</frameset>

<frameset rows="25%,50%,25%">
  <frame src="../example/html/frame_a.html">
  <frame src="../example/html/frame_b.html">
  <frame src="../example/html/frame_c.html">
</frameset>

<frameset rows="50%,50%">
  <frame src="../example/html/frame_a.html">
  <frameset cols="25%,75%">
    <frame src="../example/html/frame_b.html">
    <frame src="../example/html/frame_c.html">
  </frameset>
</frameset>

<iframe src="URL"></iframe>
```

## header

* title：标题
* base:页面上的所有链接规定默认地址或默认目标
* meta：关于 HTML 文档的元数据,元数据（metadata）是关于数据的信息,用name 和 content 属性来索引您的页面
  - description
  - keywords
  - author
* link:定义文档与外部资源之间的关系
* style:为 HTML 文档定义样式信息

```html
<meta name="description" content="Free Web tutorials on HTML, CSS, XML" />
```

## 脚本

页面的动态和交互

* `<script>` 标签用于定义客户端脚本
* `<noscript>` 标签提供无法使用脚本时的替代内容

```html
<script type="text/javascript">
document.write("Hello World!")
</script>

<noscript>Your browser does not support JavaScript!</noscript>
```

## 实体

* 空格  &nbsp;
* 小于号 &lt;
* 大于号 &gt;
* 和号  &amp;
* 引号  &quot;
* 撇号  &apos;

## URL(Uniform Resource Locator)

* scheme://host.domain:port/path/filename
* URL 只能使用 ASCII 字符集来通过因特网进行发送,由于 URL 常常会包含 ASCII 集合之外的字符，URL 必须转换为有效的 ASCII 格式

## 多媒体

* 视频
  - AVI .avi  AVI (Audio Video Interleave) 格式是由微软开发的。所有运行 Windows 的计算机都支持 AVI 格式。它是因特网上很常见的格式，但非 Windows 计算机并不总是能够播放。
  - WMV .wmv  Windows Media 格式是由微软开发的。Windows Media 在因特网上很常见，但是如果未安装额外的（免费）组件，就无法播放 Windows Media 电影。一些后期的 Windows Media 电影在所有非 Windows 计算机上都无法播放，因为没有合适的播放器。
  - MPEG .mpg .mpeg MPEG (Moving Pictures Expert Group) 格式是因特网上最流行的格式。它是跨平台的，得到了所有最流行的浏览器的支持。
  - QuickTime .mov  QuickTime 格式是由苹果公司开发的。QuickTime 是因特网上常见的格式，但是 QuickTime 电影不能在没有安装额外的（免费）组件的 Windows 计算机上播放。
  - RealVideo .rm .ram RealVideo 格式是由 Real Media 针对因特网开发的。该格式允许低带宽条件下（在线视频、网络电视）的视频流。由于是低带宽优先的，质量常会降低。
  - Flash .swf .flv Flash (Shockwave) 格式是由 Macromedia 开发的。Shockwave 格式需要额外的组件来播放。但是该组件会预装到 Firefox 或 IE 之类的浏览器上。
  - Mpeg-4  .mp4  Mpeg-4 (with H.264 video compression) 是一种针对因特网的新格式。事实上，YouTube 推荐使用 MP4。YouTube 接收多种格式，然后全部转换为 .flv 或 .mp4 以供分发。越来越多的视频发布者转到 MP4，将其作为 Flash 播放器和 HTML5 的因特网共享格式。
* 声音
  - MIDI .mid .midi MIDI (Musical Instrument Digital Interface) 是一种针对电子音乐设备（比如合成器和声卡）的格式。MIDI 文件不含有声音，但包含可被电子产品（比如声卡）播放的数字音乐指令。因为 MIDI 格式仅包含指令，所以 MIDI 文件极其小巧。上面的例子只有 23k 的大小，但却能播放将近 5 分钟。MIDI 得到了广泛的平台上的大量软件的支持。大多数流行的网络浏览器都支持 MIDI。
  - RealAudio .rm .ram RealAudio 格式是由 Real Media 针对因特网开发的。该格式也支持视频。该格式允许低带宽条件下的音频流（在线音乐、网络音乐）。由于是低带宽优先的，质量常会降低。
  - Wave  .wav  Wave (waveform) 格式是由 IBM 和微软开发的。所有运行 Windows 的计算机和所有网络浏览器（除了 Google Chrome）都支持它。
  - WMA .wma  WMA 格式 (Windows Media Audio)，质量优于 MP3，兼容大多数播放器，除了 iPod。WMA 文件可作为连续的数据流来传输，这使它对于网络电台或在线音乐很实用。
  - MP3 .mp3 .mpga MP3 文件实际上是 MPEG 文件的声音部分。MPEG 格式最初是由运动图像专家组开发的。MP3 是其中最受欢迎的针对音乐的声音格式。
  - HTML5 <audio> 元素会尝试以 mp3 或 ogg 来播放音频。如果失败，代码将回退尝试 <embed> 元素。
* 辅助程序可用于播放音频和视频（以及其他）。辅助程序是使用 <object> 标签来加载的。使用辅助程序播放视频和音频的一个优势是，您能够允许用户来控制部分或全部播放设置

```html
<object width="420" height="360"
classid="clsid:02BF25D5-8C17-4B23-BC80-D3488ABDDC6B"
codebase="http://www.apple.com/qtactivex/qtplugin.cab">
<param name="src" value="bird.wav" />
<param name="controller" value="true" />
</object>

<object width="420" height="360"
classid="clsid:02BF25D5-8C17-4B23-BC80-D3488ABDDC6B"
codebase="http://www.apple.com/qtactivex/qtplugin.cab">
<param name="src" value="movie.mp4" />
<param name="controller" value="true" />
</object>

<object width="400" height="40"
classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
codebase="http://fpdownload.macromedia.com/
pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0">
<param name="SRC" value="bookmark.swf">
<embed src="bookmark.swf" width="400" height="40"></embed>
</object>

<object height="100" width="100" data="song.mp3"></object>
<!-- html5 标签 -->
<audio controls="controls">
  <source src="song.mp3" type="audio/mp3" />
  <source src="song.ogg" type="audio/ogg" />
  <embed height="100" width="100" src="song.mp3" />
</audio>

<video width="320" height="240" controls="controls">
  <source src="movie.mp4" type="video/mp4" />
  <source src="movie.ogg" type="video/ogg" />
  <source src="movie.webm" type="video/webm" />
  <object data="movie.mp4" width="320" height="240">
    <embed src="movie.swf" width="320" height="240" />
  </object>
</video>
```

## DOM

表示文档中所有元素的JavaScript对象模型

- HTMLElement
  - classname：getElementByClassName
  - id:
  - tagName
  - querySelector
  - querySelectorAll

## event

* 窗口事件 (Window Events) 仅在 body 和 frameset 元素中有效。
  - onload:当文档被载入时执行脚本
  - onunload:当文档被卸下时执行脚本
* 表单元素事件 (Form Element Events) 仅在表单元素中有效。
  - onchange:当元素改变时执行脚本
  - onsubmit:当表单被提交时执行脚本
  - onreset:当表单被重置时执行脚本
  - onselect:当元素被选取时执行脚本
  - onblur:当元素失去焦点时执行脚本
  - onfocus:当元素获得焦点时执行脚本
* 图像事件 (Image Events) 该属性可用于 img 元素：
  - onabort:当图像加载中断时执行脚本
* 键盘事件 (Keyboard Events):在下列元素中无效：base、bdo、br、frame、frameset、head、html、iframe、meta、param、script、style 以及 title 元素。
  - onkeydown:当键盘被按下时执行脚本
  - onkeypress:当键盘被按下后又松开时执行脚本
  - onkeyup:当键盘被松开时执行脚本
* 鼠标事件 (Mouse Events):在下列元素中无效：base、bdo、br、frame、frameset、head、html、iframe、meta、param、script、style 以及 title 元素。
  - onclick:当鼠标被单击时执行脚本
  - ondblclick:当鼠标被双击时执行脚本
  - onmousedown:当鼠标按钮被按下时执行脚本
  - onmousemove:当鼠标指针移动时执行脚本
  - onmouseout:当鼠标指针移出某元素时执行脚本
  - onmouseover:当鼠标指针悬停于某元素之上时执行脚本
  - onmouseup:当鼠标按钮被松开时执行脚本

## 扩展

* [hakimel/reveal.js](https://github.com/hakimel/reveal.js):The HTML Presentation Framework http://lab.hakim.se/reveal-js/

## Dashboard

* [tabler/tabler](https://github.com/tabler/tabler):Tabler is free and open-source HTML Dashboard UI Kit built on Bootstrap 4 https://tabler.github.io/

## 参考

* [joshbuchea/HEAD](https://github.com/joshbuchea/HEAD):A list of everything that *could* go in the head of your document https://gethead.info
* [Bilibili/flv.js](https://github.com/Bilibili/flv.js)HTML5 FLV Player
* [h5bp/html5-boilerplate](https://github.com/h5bp/html5-boilerplate):A professional front-end template for building fast, robust, and adaptable web apps or sites. https://html5boilerplate.com/
* [HTML](https://html.spec.whatwg.org/) [HTML中文](https://whatwg-cn.github.io/html/)
