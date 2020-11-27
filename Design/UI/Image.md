# Image

## 原理

* 每一个像素都会代表着一个单独的色块。用二进制来表示，使用的二进制位数越多，像素的色彩就越丰富
* 百万像素（MP）代指单位面积内的像素数量在以百万为单位时的
* 使用规格超出自身实际需求的照片并不能提升输出图像的呈现质量
* DPI（Dots Per Inch，图像每英寸像素点数）
  - DPI 是一种将图像的面积和理论打印尺寸进行关联的文件属性。除非你打算把这些图片打印出来，否则 DPI 就没有那么重要
  - 如果你的图片宽度为 3000 像素，而你打算把它打印在一张 10 英寸宽的画布上，这张图片的最大可印刷 dpi 就是 300dpi。如果这张图片要被打印在一张 100 英寸宽的画布，它的最大可印刷 dpi 则为 30dpi

## 概念

* 类型
  - 点阵图(位图)：构成点阵图的最小单位是像素，位图就是由像素阵列的排列来实现其显示效果的，每个像素有自己的颜色信息，在对位图图像进行编辑操作的时候，可操作的对象是每个像素，可以改变图像的色相、饱和度、透明度，从而改变图像的显示效果。jpg、png、webp等
    + 有损压缩：压缩文件大小的过程中，损失了一部分图片的信息，也即降低了图片的质量，并且这种损失是不可逆的，不可能从一个有损压缩过的图片中恢复出完整的图片
  - 矢量图，也叫做向量图。矢量图并不纪录画面上每一点的信息，而是纪录了元素形状及颜色的算法，打开一幅矢量图的时候，软件对图形对应的函数进行运算，将运算结果图形的形状和颜色显示。
* 压缩：一种减小文件尺寸（这种尺寸指的是譬如“MB”这样的储存规格，而非图片的分辨率），同时提供与原图像尽量相似的输出图片的处理手段。
  - 无压缩：不对图片数据进行压缩处理，能准确地呈现原图片。BMP 格式就是其中之一
  - 无损压缩：在压缩图片的过程中，图片的质量没有任何损耗。任何时候都可以从无损压缩过的图片中恢复出原来的信息。
    + 压缩算法对图片的所有的数据进行编码压缩，能在保证图片的质量的同时降低图片的尺寸。 png 是其中的代表。
  - 有损压缩：压缩文件大小的过程中，损失了一部分图片的信息，也即降低了图片的质量，并且这种损失是不可逆的，不可能从一个有损压缩过的图片中恢复出完整的图片
    + 常见的有损压缩手段，是按照一定的算法将临近的像素点进行合并。压缩算法不会对图片所有的数据进行编码压缩，而是在压缩的时候，去除了人眼无法识别的图片细节。因此有损压缩可以在同等图片质量的情况下大幅降低图片的尺寸。其中的代表是 jpg。
  - 图片的用途是网站或者其它的面向公众展示的地方，应该对图片进行一定的压缩处理（通常为原图的 70 到 90 之间就能达到很好的平衡）
  - 把一张 3MP 的图片缩放到 8MP 的规格并不能提升它的图像质量。同理，把一张压缩到 80 压缩规格的照片重新压缩到 100 的规格也无法让这张图片再度溯回。
* Alpha通道
  - 在原有的图片编码方法基础上，增加像素的透明度信息。图形处理中，通常把 RGB 三种颜色信息称为红通道、绿通道和蓝通道，相应的把透明度称为 Alpha 通道
* 色彩深度
  - 色彩深度又叫色彩位数，即位图中要用多少个二进制位来表示每个点的颜色，是分辨率的一个重要指标。常用有1位（单色），2位（4色，CGA），4位（16色，VGA），8位（256色），16位（增强色），24位（真彩色）和32位等。色深16位以上的位图还可以根据其中分别表示RGB三原色或CMYK四原色（有的还包括Alpha通道）的位数进一步分类，如16位位图图片还可分为R5G6B5，R5G5B5X1（有1位不携带信息），R5G5B5A1，R4G4B4A4等等。
    + 8位色，所谓8位色并不是图像只有8种颜色，而是2^8，即256种颜色，8位图指的是用8个bits来表示颜色；
    + 16位色，2^16，从人眼的感觉来说，16位色基本可以满足视觉需要了；
    + 24位色，又称为“真彩色”。大概有1600万之多，这个数字几乎是人类视觉可分辨颜色的极限；
    + 32位色，并非 2^32, 其实也是 2^24 种颜色，不过它增加了2^8 阶颜色的灰度，也就是8位透明度，因此规定它为32位色。
  - 设计者一般选择 24 位图像。32 位图像虽然质量更好，但同时也带来更大的图像体积
* 真彩色图像是一种用三个或更多字节描述像素的计算机图像存储方式。
  - 前三个通道都会各用一个字节表示，如红绿蓝（RGB）或者蓝绿红（BGR）。如果存在第四个字节，则表示该图像采用了 Alpha 通道。然而，实际系统往往用多于 8 位（即1字节）表达一个通道，如一个 48 位的扫描仪等。这样的系统都统称为真彩色系统。
* 伪彩色图像其实可以理解为索引图像，他的每个像素值存储的不是直接的基色强度，而是存储的索引

## 类型

* JPEG：最常见的一种图像格式，文件后辍名为“.JPEG”或“.jpg”，很典型的使用有损压缩图像格式，也就是说使用者每次进行 JPEG 的存档动作后，图档的一些内容细节都会遭到永久性的破坏，尤其是使用过高的压缩比例，将使最终解压缩后恢复的图像质量明显降低，如果追求高品质图像，不宜采用过高压缩比例。JPEG 图片格式的设计目标，是在不影响人类可分辨的图片质量的前提下，尽可能的压缩文件大小。
  - 使用从 0 到 100 之间取值的参数来代表自身的压缩质量层级——100 代表最低规格的图片压缩处理，0 则意味着最高的压缩处理规格
  - 两种保存方式：Baseline JPEG（标准型）、Progressive JPEG（渐进式）
    + Baseline JPEG 文件存储方式是按从上到下的扫描方式，把每一行顺序的保存在 JPEG 文件中。打开这个文件显示它的内容时，数据将按照存储时的顺序从上到下一行一行的被显示出来，直到所有的数据都被读完，就完成了整张图片的显示。如果文件较大或者网络下载速度较慢，那么就会看到图片被一行行加载的效果，这种格式的JPEG没有什么优点，因此，一般都推荐使用Progressive JPEG。
    + Progressive JPEG 文件包含多次扫描，这些扫描顺寻的存储在 JPEG 文件中。打开文件过程中，会先显示整个图片的模糊轮廓，随着扫描次数的增加，图片变得越来越清晰。这种格式的主要优点是在网络较慢的情况下，可以看到图片的轮廓知道正在加载的图片大概是什么。在一些网站打开较大图片时，你就会注意到这种技术。
      * 可以让用户在没有下载完图片就可以看到最终图像的大致轮廓，一定程度上可以提升用户体验（瀑布流的网站建议还是使用标准型的）。
  - 优点
    + 可以支持 24bit 真彩色，普遍应用于需要连续色调的图像如色彩丰富的图片、照片等；
    + 可利用可变的压缩比以控制文件大小；
    + 支持交错（对于渐近式 JPEG 文件）；
  - 缺点
    + JPEG 不适合用来存储企业 Logo、线框类的图。因为有损压缩会导致图片模糊，而直接色的选用，又会导致图片文件较GIF更大。
    + 有损耗压缩会使原始图片数据质量下降。
    + JPEG 图像不支持透明度处理，透明图片需要召唤 PNG 来呈现。
  - 适合场景：JPG 适用于呈现色彩丰富的图片，日常开发中，JPG 图片经常作为大的背景图、轮播图或 Banner 图出现。
* GIF(Graphics Interchange Format) 原义是“图像互换格式”，是一种基于 LZW 算法连续色调的无损的基于索引色的压缩格式。其压缩率一般在 50% 左右，它不属于任何应用程序所以几乎所有相关软件都支持它，公共领域有大量的软件在使用 GIF 图像文件
  - 一种无损压缩，所以它只是对像素数据进行压缩，其实 LZW 算法只是一个压缩数据的算法，如果懂哈夫曼算法的话，可能就比较好理解压缩数据
  - GIF 的特性是帧动画。
  - 相比古老的bmp格式，尺寸较小，而且支持透明(不支持半透明，因为不支持 Alpha 透明通道 )和动画。
  - 优点
    + 优秀的压缩算法使其在一定程度上保证图像质量的同时将体积变得很小。
    + 可插入多帧，从而实现动画效果。
    + 可设置透明色以产生对象浮现于背景之上的效果。
  - 缺点
    + 采用了 8 位压缩，最多只能处理 256 种颜色，故不宜应用于真彩色
  - 适合场景：色彩简单的 logo、icon、线框图、文字输出等
* GIF vs JPEG
  - 当图片拥有丰富的色彩时，并且没有明显锐利反差的边缘线条时，选择 JPEG 可以得到最好的输出结果，照片就是最好的例子
  - 当图片是拥有明确边缘的线条图、没有使用太多色彩、甚至可能需要透明背景时，GIF 是很好的选择，档案小、画质又精美
* PNG：便携式网络图形（简称 PNG，英语全称：Portable Network Graphics）
  - 特点
    + PNG 能够提供长度比 GIF 小30%的无损压缩图像文件。
    + 同时提供 24 位和 32 位真彩色图像支持以及其他诸多技术性支持。
    + 由于PNG 优秀的特点，PNG 格式图片可以称为“网页设计专用格式”。
    + PNG 最初的开发目的是为了作为 GIF 的替代方案的，作为做新开发的影像传输文件格式，PNG 同样使用了无损压缩格式，事实上 PNG 的开发就是因为 GIF 所使用的无损压缩格式专利问题而诞生的。
  - 形式
    + PNG-8 是 PNG 的索引色版本。PNG-8 是无损的、使用索引色的、点阵图。是非常好的 GIF 替代者，在可能的情况下，应该尽可能的使用 PNG-8 而不是 GIF，因为在相同的图片效果下，PNG-8 具有更小的文件体积。除此之外，PNG-8 还支持透明度的调节，而 GIF 并不支持。 现在，除非需要动画的支持，否则我们没有理由使用 GIF 而不是 PNG-8
    + PNG-24 是 PNG 的直接色版本。PNG-24 是无损的、使用直接色的、点阵图。听起来非常像 BMP，是的，从显示效果上来看，PNG-24 跟 BMP 没有不同。PNG-24 的优点在于，它压缩了图片的数据，使得同样效果的图片，PNG-24 格式的文件大小要比 BMP 小得多。当然，PNG24 的图片还是要比 JPEG、GIF、PNG-8 大得多。
      * 虽然 PNG-24 的一个很大的目标，是替换 JPEG 的使用。但一般而言，PNG-24 的文件大小是 JPEG 的五倍之多，而显示效果则通常只能获得一点点提升。所以，只有在你不在乎图片的文件体积，而想要最好的显示效果时，才应该使用 PNG-24 格式。
      * PNG-24 跟 PNG-8 一样，是支持图片透明度的。
      * 理论上来说，当追求最佳的显示效果、并且不在意文件体积大小时，是推荐使用 PNG-24 的。 实践当中，为了规避体积的问题，一般不用PNG去处理较复杂的图像。当遇到适合 PNG 的场景时，也会优先选择更为小巧的 PNG-8。
    + PNG-32 跟 PNG-24 的区别就是多了一个 Alpha 通道，用来支持半透明，其他的跟 PNG-24 基本一样。
    + 优点
      * 支持高级别无损耗压缩；
      * 支持 alpha 通道透明度；
      * 支持 256 色调色板技术以产生小体积文件
      * 最高支持 24 位真彩色图像以及 8 位灰度图像。
      * 支持图像亮度的 Gamma 校准信息。
      * 支持存储附加文本信息，以保留图像名称、作者、著作权、创作时间、注释等信息。
      * 渐近显示和流式读写，适合在网络传输中快速显示预览效果后再展示全貌。
    + 缺点
      * 较旧的浏览器 IE6- 和程序可能不支持 PNG 文件；
      * 与 JPEG 的有损耗压缩相比，PNG 提供的压缩量较少；
      * 与 GIF 格式相比，对多图像文件或动画文件不提供任何支持。
    + 适合场景：呈现小的 Logo、颜色简单且对比强烈的图片或背景等。
  - 知识
    + PNG 分为两种，一种是 Index，一种是 RGB。
      * Index 记录同一种颜色的值和出现的位置（简单地说，比如一个 2px*2px 的超级小图，从左往右从上往下依次的颜色是红，白，白，红，那么记录的方法就是“红-1,4；白-2,3”）
      * 而 RGB 图则把所有像素的色值依次记录下来（即“红，白，白红”）。对于相同的图片，Index 格式的尺寸总是小于 RGB。
      * PNG-8 就是 Index，称作为索引色，而 PNG-24 和 PNG-32 是 RGB 形式，也可称作为直接色。因为 PNG 是无损压缩，保留了图片需要的所有信息，所以索引色是可以转化为直接色的。
* WebP：出于减少数据量、加速网络传输的目的而开发的。这是Google旧款VP8编码(已在2010五月开源)的衍生分支，在质量等同于JPEG的情况下压缩文件尺寸。Edge、Firefox、Google声称从PNG格式转换至WebP格式后文件尺寸能够减少28%至45%，其中压缩比例具体取决于原始PNG格
  - 是同时支持有损和无损压缩的、使用直接色的、点阵图。
  - 相同质量的图片，WebP 具有更小的文件体积
  - 体验
    + 在无损压缩的情况下，相同质量的 WebP 图片，文件大小要比 PNG 小26%；
    * 在有损压缩的情况下，具有相同图片精度的 WebP 图片，文件大小要比 JPEG 小 25%~34%；
    * WebP 图片格式支持图片透明度，一个无损压缩的 WebP 图片，如果要支持透明度只需要 22% 的格外文件大小。
  + 缺点
    * IE 和 Safari 所有的版本都是不支持的(这是硬伤)， 火狐也是最新的几个版本才开始支持
  - WebP 与 JPG 相比较，编码速度慢 10 倍，解码速度慢 1.5 倍，而绝大部分的网络应用中，图片都是静态文件，所以对于用户使用只需要关心解码速度即可。但实际上，WebP 虽然会增加额外的解码时间，但是由于减少了文件体积，缩短了加载的时间，实际上文件的渲染速度反而变快了。
  - 使用场景
    + 如果大规模的适用 WebP，一定要在 Safari 和 IE 里面施行降级
* APNG（Animated Portable Network Graphics）顾名思义是基于 PNG 格式扩展的一种动画格式，增加了对动画图像的支持，同时加入了 24 位图像和 8 位 Alpha 透明度的支持，这意味着动画将拥有更好的质量，其诞生的目的是为了替代老旧的 GIF 格式，但它目前并没有获得 PNG 组织官方的认可。
  - APNG 第1帧为标准 PNG 图像，剩余的动画和帧速等数据放在 PNG 扩展数据块，因此只支持原版 PNG 的软件会正确显示第 1 帧。
  - 在兼容性方面绝大部分浏览器都还是支持的，如果以前是因为动画的原因用 GIF 的，现在用 APNG 是一个不错的选择，其他的特性是跟 PNG 样的，因为 APNG 只是一个 PNG 的扩展。
* SVG 可缩放矢量图形，英文 Scalable Vector Graphics(SVG)，是无损的、矢量图
  - SVG是一种用 XML 定义的语言，用来描述二维矢量及矢量/栅格图形。
  - SVG提供了3种类型的图形对象
    + 矢量图形（例如：由直线和曲线组成的路径）
      * 图形对象还可进行分组、添加样式、变换、组合等操作，特征集包括嵌套变换、剪切路径、alpha 蒙板、滤镜效果、模板对象和其它扩展。
    + 图象
    + 文本
  - SVG 跟上面这些图片格式最大的不同，是 SVG 是矢量图。 由直线和曲线以及绘制它们的方法组成。
  - 放大一个 SVG 图片的时候，看到的还是线和曲线，而不会出现像素点。这意味着 SVG 图片在放大时，不会失真，所以它非常适合用来绘制企业 Logo、Icon 等。
  - 优点
    + SVG 可被非常多的工具读取和修改（比如记事本）。
    + SVG 与 JPEG 和 GIF 图像比起来，尺寸更小，且可压缩性更强。
    + SVG 是可伸缩的。
    + SVG 图像中的文本是可选的，同时也是可搜索的（很适合制作地图）。
    + SVG 可以与 JavaScript 技术一起运行
    + SVG图形格式支持多种滤镜和特殊效果，在不改变图像内容的前提下可以实现位图格式中类似文字阴影的效果。
    + SVG图形格式可以用来动态生成图形。例如，可用 SVG 动态生成具有交互功能的地图，嵌入网页中，并显示给终端用户。
  - 缺点
    + 渲染成本比较高，对于性能有影响。
    + SVG 的学习成本比较高，因为它是可编程的。
  - 适用场景
    - 高保真度复杂矢量文档已是并将继续是 SVG 的最佳点。它非常详细，适用于查看和打印，可以是独立的，也可以嵌入到网页中
    - 在WEB项目中的平面图绘制，如需要绘制线，多边形，图片等。
    - 数据可视化。

## Data URL

* 以data:模式为前缀的URL，允许内容的创建者将较小的文件嵌入到文档中
* 由data:前缀、MIME类型（表明数据类型）、base64标志位（如果是文本，则可选）以及数据本身四部分组成 `data:[<mediatype>][;base64],data`
* 优势
  - 当访问外部资源很麻烦或受限时，可以将外部资源转为Data URL引用(这个比较鸡肋)
  - 当图片是在服务器端用程序动态生成，每个访问用户显示的都不同时，这是需要返回一个可用的URL（场景较少）
  - 当图片的体积太小，占用一个HTTP会话不是很值得时（雪碧图可以出场了）
* 缺点
  - 体积更大：Base64编码的数据体积通常是原数据的体积4/3，也就是Data URL形式的图片会比二进制格式的图片体积大1/3
  - 不会缓存：Data URL形式的图片不会被浏览器缓存，这意味着每次访问这样的页面时都被下载一次。这是一个使用效率方面的问题——尤其当这个图片被整个网站大量使用的时候。
* 场景
  - 在浏览器地址栏中使用
  - 在script/img/video/iframe等标签的src属性内使用Data URL
  - 在`<link>`标签的href中使用Data URL
  - 在css样式background的url中使用Data URL

```
# uuencode
uuencode -m <源文件> <转码后标识>

## Javascript
btoa('hello base64') // "aGVsbG8gYmFzZTY0"
atob('aGVsbG8gYmFzZTY0') // "hello base64"

# Canvas提供了toDataURL
<canvas id="testCanvas" width="200" height="100"></canvas>
<textarea id="testCanvas-content"></textarea>

var canvas = document.getElementById('testCanvas');
if (canvas.getContext) {
  var ctx = canvas.getContext('2d');
  // 设置字体
  ctx.font = "Bold 20px Arial";
  // 设置对齐方式
  ctx.textAlign = "left";
  // 设置填充颜色
  ctx.fillStyle = "#0f0";
  // 设置字体内容，以及在画布上的位置
  ctx.fillText("hello base64", 10, 30);
  // 描边颜色
  ctx.strokeStyle = "#0f0";
  // 绘制空心字
  ctx.strokeText("hello base64", 10, 80);
  // 获取 Data URL
  document.getElementById('testCanvas-content').value = canvas.toDataURL();
}

# FileReader API的readAsDataURL
<div class="demo-area">
  <input type="file" id="testReadAsDataURL">
  <textarea id="testReadAsDataURL-content"></textarea>
</div>

var reader = new FileReader()
reader.onload = function(e) {
  var textarea = document.getElementById('testReadAsDataURL-content');
  textarea.value = reader.result
}
document.getElementById('testReadAsDataURL').onchange = function(e) {
  var file = e.target.files[0]
  reader.readAsDataURL(file)
}

<a href="base64内容" target="_blank" id="setDataURLInHref"></a>
var scriptDataURL = `data:text/javascript;base64,YWxlcnQoJ+WcqHNjcmlwdOS4reS9v+eUqERhdGEgVVJMJykK`
// 对应文本为：alert('在script中使用Data URL')
$('#setDataURLInScriptBtn').click(function() {
  $('<script>').attr('src', scriptDataURL).appendTo($('body'))
})

var linkDataURL = `data:text/css;base64,I3NldERhdGFVUkxJbkxpbmtCdG57Y29sb3I6IHJlZDt9Cg==`
// 对应内容为：setDataURLInLinkBtn{color: red;}
$('#setDataURLInLinkBtn').click(function() {
  $('<link rel="stylesheet" type ="text/css">').attr('href', linkDataURL).appendTo($('head'))
})

const bgDataURL = $('#testCanvas-content')[0].value
$('#setDataURLInBG').css('background-image', `url(${bgDataURL})`)
```

## convert

* 在 Linux 或者 MacOS 的命令行里做图片转换，用到的命令叫做 convert，是属于 ImageMagick 套件里的一个工具
* identify 命令也属于 ImageMagick 套件，作用是查看图片文件的属性

```sh
identify original.jpg
convert original.png original.jpg

convert original.jpg -resize 900x800 out1.jpg
convert original.jpg -resize 900 out2.jpg
convert original.jpg -resize x400 out2.1.jpg
convert original.jpg -resize 900x800! out3.jpg # 强制得到
convert original.jpg -resize 50% out4.jpg

convert original.jpg -crop 900x300+0+0 out5.jpg # 图片大小是 900x300。命令中的 +0+0 是指相对图片最左上角在 X 轴和 Y 轴上的偏移量

onvert original.jpg -crop 900x+0+0 out7.jpg #
convert original.jpg -crop 900x+10+30 out8.jpg # 输出图片的高度是原图高度减去偏移量
onvert original.jpg -crop 50%x+0+0 out8.jpg
convert original.jpg -crop 50%x60%+0+0 out10.jpg
convert original.jpg -crop 900x60%+0+0 out11.jpg

md5sum out11.jpg
```

## 资源

* [unsplash](https://unsplash.com/):Photos for everyone
* [天空之城](https://www.skypixel.com/):一个专注于航拍影像的网站
* [1x](https://1x.com/):摄影网站，作品质量极高。
* [LFI](http://lfi-online.de/ceemes/en/gallery/):徕卡旗下的作品廊
* [500px](https://500px.com/popular)
* [Pixelmator](http://www.pixelmator.com):图像处理软件
* [GIPHY](https://giphy.com/):寻找动图好去处。
* [Beautiful Royalty-Free Photos Sorted By AI](https://www.pickpik.com)
* [yandex search](https://yandex.com/images/)
* [pinterest](https://www.pinterest.com/)

## 工具

* 转换
  - [IMageMagick](https://imagemagick.cn/)
    + convert:转换图像格式，调整图像大小、模糊、裁剪、去斑、抖动、绘图、翻转、加入、重新采样等等
    + mogrify:批量缩放大小
  - [renzhezhilu / webp2jpg-online](https://github.com/renzhezhilu/webp2jpg-online):在线图片格式转化器,纯前端实现，无需上传文件,可将jpeg、jpg、png、gif、webp、svg、ico、bmp文件转化为jpeg、png、webp动画、ico、gif文件。本地即可完成转换。Online picture format converter, can convert jpeg, jpg, png, gif, webp, svg, ico, bmp files into jpeg, png, webp animation,gif, ico files. No need to upload files, conversion can be done locally。 <https://renzhezhilu.github.io/webp2jpg-online/>
* [nagadomi/waifu2x](https://github.com/nagadomi/waifu2x):Image Super-Resolution for Anime-Style Art
* [photoprism/photoprism](https://github.com/photoprism/photoprism):Personal photo management powered by Go and Google TensorFlow <https://photoprism.org/>
* [google/filament](https://github.com/google/filament):Filament is a real-time physically based rendering engine for Android, Windows, Linux, macOS and WASM/WebGL
* [Gimp](https://www.gimp.org)
* [muukii/Pixel](https://github.com/muukii/Pixel):🎨🖼 An image editor and engine using CoreImage
* 看图
  - FastStone Image Viewer
* 截图
  - [snipaste](https://www.snipaste.com/):a simple but powerful snipping tool, and also allows you to pin the screenshot back onto the screen
  - Xnip
* 压缩
  - [GoogleChromeLabs/squoosh](https://github.com/GoogleChromeLabs/squoosh):Make images smaller using best-in-class codecs, right in the browser. <https://squoosh.app>
  - [fengyuanchen/compressorjs](https://github.com/fengyuanchen/compressorjs):JavaScript image compressor.
* [libvips/libvips](https://github.com/libvips/libvips):A fast image processing library with low memory needs. <https://libvips.github.io/libvips/>
* [AlloyImage](https://github.com/AlloyTeam/AlloyImage)基于HTML5技术的专业图像处理库
* [DmitryUlyanov/deep-image-prior](https://github.com/DmitryUlyanov/deep-image-prior):Image restoration with neural networks but without learning. <https://dmitryulyanov.github.io/deep_image_prior>
* [esimov/caire](https://github.com/esimov/caire):Content aware image resize library
* [jantic/DeOldify](https://github.com/jantic/DeOldify):A Deep Learning based project for colorizing and restoring old images
* [hackerb9/lsix](https://github.com/hackerb9/lsix):Like "ls", but for images. Shows thumbnails in terminal using sixel graphics.
* [nagadomi/waifu2x](https://github.com/nagadomi/waifu2x):Image Super-Resolution for Anime-Style Art
* [remove](http://remove.bg):Remove Image Background
* [Find The Best Free Stock Photos For Your Project](https://www.mailomix.com/products/stock-photo-search/)
* [ImageOptim/ImageOptim](https://github.com/ImageOptim/ImageOptim):GUI image optimizer for Mac <https://imageoptim.com/mac>
* [illuminations](https://illuminations.nctm.org):在线画图网站
* 图床
  - [uPic](link): Mac 图床 (文件) 上传客户端，它可以将图片、各种文件上传到配置好的指定对象存储中，然后即时生成可供互联网访问的文件 URL,支持图床： smms、 又拍云 USS、七牛云 KODO、 阿里云 OSS、 腾讯云 COS、微博、Github、 Gitee、 Amazon S3、自定义上传接口
  - PicGo
* Inpaint:图片去水印

## 参考

* [Data URLs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URIs)
