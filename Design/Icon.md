# Icon

* CSS Sprites（雪碧图）:减少并发下载的需求。因此，优化的方案也就显而易见了：把各种小图标拼合成一个大图，然后想办法让浏览器把它重新切成多个就可以了。恰好，浏览器有一个特性叫background-position，也就是说假如我们把这张大图设置为当前元素（宽w、高h）的背景，并且指定了 background-position 为 (x, y)，那么当前元素的背景就是从大图上 (x, y, x+w, y+h) 截取出来的那个区域。这样一来，就把 N 个并发下载合并成了一张大图和一个 css 文件
* Data URL: `data:[<mediatype>][;base64],<data>，`
	- Data URL 和普通的 http URL 没有什么区别 —— 除了不用额外下载。因此，凡是能用 http URL 的地方都可以换成 Data URL.把图标的下载合并到了 html/css 的下载过程中。
	- 拖慢了整体渲染速度:浏览器的下载优先级是 html > css > 图片等资源
* 字体图标
	- 视网膜屏的设备像素比（devicePixelRatio，简称 dpr）是 3，那么图标就需要三个像素才能在视网膜屏下绘制出一个完美的逻辑像素，否则就会有粗糙感
	- 自定义字体:本来是为了解决让浏览器显示更好看的文字而创造的技术，字体文件包含要用的那些文字的字体轮廓数据就可以了。这些轮廓数据是矢量数据，用来表示每个字的“画法”：从 0,0 开始，以 50%,10% 为控制点，画一条贝塞尔曲线到 100%,30%。显然，这种数据是不会受到屏幕分辨率影响的.无论把它放到多大，它都是平滑而且不失真的。事实上，这正是一切矢量绘图技术共同的优点
	- 除了支持平滑缩放的优势以外，字体图标还有另一个优势，那就是它本身就是文字。它会受到字号、前景色、行高等参数的控制，和普通文字没有任何区别。而图标，在实际应用中经常会和普通文字一起混排
	- 缺点
		+ 单色
		+ 工具链复杂:虽然有一些工具可以帮你把一组 svg 文件拼合成一个字体文件，但是它们对 svg 的格式有严格的要求，不是任何一个 svg 都可以用的。你很难向 UX 解释什么样的图能用、什么样的图不能用。其次，即使是可用的 svg，你也很难告诉工具每个图标的字体基线是哪个（通俗来说，基线就是你这个图标的底部和字母 g 的底部对齐，还是和字母 h 的底部对齐）
	- 在普通的团队中使用自定义字体图标是相当困难的。不过好在还有不普通的团队，比如 FontAwesome，他们专门制作、维护了一组免费图标贡献给开源社区。如果你需要的图标恰好是其中之一，那么直接用就可以了，你需要做的只是引入它的 css 之后，在 html 中使用<i class="fa fa-home"></i>
* svg 图标
	- FontAwesome 虽好，但也不是万能的。它往往不足以融入 UX 的 Design System，而 UX 显然也不愿意削足适履，为了图标而改变自己的整体设计。
	- svg 也是图片，也有同样的优缺点 —— 但能支持视网膜屏
	- 用法
		+ 可以把 svg 内联到 html 中。svg 和 html 在语法上非常像，都是 xml 语系，只是使用了不同的命名空间（xmlns），因此我们可以把 svg 作为一个元素内联到 html 中，现代浏览器可以正确地解释它们。这种用法比较自然，html 中引入的 css 也同样可以作用于 svg 内部的元素上，图文可以无缝整合在一起
			*  svg 中各个元素的 id 会并入页面的命名空间中，比如在 svg 中引用了一个名为 a 的过滤器，那么如果 html 或另一个 svg 中也定义了它，就会互相冲突。在稍大点的项目中要解决这种冲突会相当麻烦。
			*  如果这个图标出现很多次，它的内容就会在 html 中重复很多遍，体积也会相应的增大
		+  有一种机制可以解决这个问题，也就是use 标签。使用 use 标签，你可以根据 id 引用本页面中的 svg 元素，甚至来自其它 svg 文件中的元素.要引用本页面中的 id 为 a 的 rect 元素，只需要写 <use xlink:href="#a">即可，并且在这里可以指定自己的 svg 属性，以覆盖原始元素上的 svg 设置。这样一来，图标内容被重复很多遍的问题就解决了
			*  图标的颜色不会自动跟随文字颜色
			*  图标的大小不会自动跟随字体大小
*  合字（Ligature）
	-  最早使用合字的图标体系是 Google 的 Material Design，比如用 <i class="material-icons">home</i>就可以显示出一座房子，它是怎么工作的呢
		+  material-icons 类为这个 i元素指定了一个支持合字的字体库：'Material Icons'，然后就会在字体库中检索出 home 这个合字对应的单字，并且把那个单字显示出来就可以了。换句话说，home 是某个单字的别名
	-  为什么不像 FontAwesome 那样直接引用这个单字，而要用合字中转一次呢
		+  屏幕阅读器无法理解某个单字表示的是房子形状的图标，因此页面的编写者就需要给这个图标加上特殊的 aria-label等属性，以便屏幕阅读器朗读它们。这称为 Accessibility（无障碍），简称 a11y
*  优化
	-  摇树优化：没有实际使用到的图标应该自动被优化掉，而不应该让手工检查哪些图标没用到，并且从源码中删掉
	-   SPA：并不需要同时下载大量的图标，而是按需加载。一个图标一张图”的方式未必就真的不可接受，针对你的实际业务场景，做一下链路分析，它没准反倒是最合适的方案
	-   svg 文件本身的优化。很多工具导出的 svg 文件很啰嗦，里面有很多对于显示没有意义的东西。一些 svg 图标即使减小到原来体积的一半儿都不会影响显示，因此，针对 svg 本身做一些优化也是有价值的。`npm i -g svgo` 命令就可以全局安装。可以用 svgo命令对单个文件或者整个目录做优化；可以手工使用，也可以把它集成到工具链里

## 资源

* [akveo/eva-icons](https://github.com/akveo/eva-icons):A pack of more than 480 beautifully crafted Open Source icons. SVG, Sketch, Web Font and Animations support. https://akveo.github.io/eva-icons/
* [Templarian/MaterialDesign](https://github.com/Templarian/MaterialDesign):✒2700+ Material Design Icons from the Community https://materialdesignicons.com
* [atisawd/boxicons](https://github.com/atisawd/boxicons):High Quality web friendly icons https://boxicons.com
* [feathericons/feather](https://github.com/feathericons/feather):Simply beautiful open source icons https://feathericons.com
* [google/material-design-icons](https://github.com/google/material-design-icons):Material Design icons by Google http://google.github.io/material-design-icons/
* [iconfont](https://www.iconfont.cn/)
* [unDraw](https://undraw.co/)
* [Search Icons Visually](http://compute.vision/nouns/index.html)
* [Fotor](Fotor.com):免费在线平面设计工具和图片编辑器
* [coreui / coreui-icons](https://github.com/coreui/coreui-icons):CoreUI Free Icons - Premium designed free icon set with marks in SVG, Webfont and raster formats https://coreui.io/icons/
* [astrit / css.gg](https://github.com/astrit/css.gg):500+ CSS Icons. Customizable, Retina Ready with API & NPM https://css.gg
* [twbs/icons](https://github.com/twbs/icons):Official open source SVG icon library for Bootstrap. https://icons.getbootstrap.com/
