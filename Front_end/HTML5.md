# HTML5



## fetch



## 改进体验

* fake 页 - 首屏加速
    - 目标：首屏 3s 以内:因为 71% 的用户期望移动页面跟 pc 页面一样快 (3s) ，74% 的用户能容忍的响应时间为 5 秒，所以我们必须保证移动端页面有足够的速度。
    - 方案：
        + 避免页面长时间白页，页面渲染只需要完整的 HTML 以及 CSS
        + 加载结束后页面第一屏便渲染结束，然后再异步加载j
        + 静态资源不使用 cookie
        + 优化加载顺序（css头、js尾(异步))
        + 降低请求「数」
        + 将可合并的 CSS、JS 文件合并
        + CSS sprites 合并图片资源（http://zerosprites.com/）
* 降低请求「量」
    + 合理的使用图片资源（对大图进行处理，使用矢量图片） 
    + JS混淆（通过简化函数名称， 变量名称， 去空格等达到减小 JS 文件的大小） 
    + 规划好使用的第三方工具库，减少不必要的引用 
    + 启用 GZIP 压缩 
    + Zepto 替换 JQuery
* 缓存一切可缓存的
    + 页面缓存（manifest，减轻服务器压力、加快页面加载速度）
    + 数据缓存（localStorage/indexedDataBase）
    + 只缓存非敏感信息 !!!
* 合理使用 Ajax 的 Get、Post
    - Post方法在AJAX 请求下会被拆分成两个: sending header first, then sending data
    - Get提交的数据较少
    - Post相对来说更安全
* 使用合理的图片加载方案
    - 延迟加载：使用 setTimeOut 或 setInterval 进行加载延迟
    - 条件加载：符合某些条件，或触发了某些事件才开始异步下载
    - 可视区加载：即仅加载用户可以看到的区域，这个主要由监控滚动条来实现，一般会在距用户看到某图片前一定距离遍开始加载，这样能保证用户拉下时正好能看到图片
* 减少渲染回流
    - HTML渲染过程
        + 生成DOM树
        + 计算CSS样式
        + 构建 render tree
        + reflow，定位元素位置大小
        + 绘制页面
    - 这些操作会导致回流
        + 操作dom结构
        + 动画
        + DOM样式修改
        + 获取元素尺寸的API
    - 注：若是 javascript 动态改变 DOM Tree 便会引起 reflow 页面中的元素改变，只要不影响尺寸，比如只是颜色改变只会引起 repaint 不会引起回流
* 减少使用定位元素
    + static元素处于文档流中，其渲染速度是最快的
    + absolute定位元素在手机上可能会导致的问题：
        * 定位元素在手机上不能显示
        * 定位元素动画效果失效。
        * 以上问题便是 UI 渲染失效多导致，最好的解决方案是减少使用定位元素，否则只能引起强烈 reflow 才能解决
    - Fix 定位元素导致的问题
        * fixed元素遭遇文本框时失效，可能会飘到页面中间阻挡输入
        * 影响效率
* 手动释放资源
    - 不能完全依赖于浏览器的垃圾回收
    - 资源必须手动释放
        + 释放没有使用的闭包
        + 观察者需要得到清理
        + 释放定时器
        + view 切换过程中，在 destroy 中释放 view 相关资源
* 区域滚动使用 Iscroll
    - webapp 区域滚动 
    - 解决动画过程带来的长短页问题
* Touch 事件替换 Click
    - Click 点击响应比 Touch 慢 300ms（手机需要知道你是不是想双击放大网页内容）
    - 解决动画过程带来的长短页问题
    - 总而言之，IScroll 方案的提出，是让 webapp 媲美 native app 靠近了一大步，真正的平起平坐还需要浏览器的支援
* 合理使用 CSS 特性
    - 不要使用 CSS 字体 
    - 避免使用 CSS 表达式 
    - 高频渲染触发 GPU 加速（CSS3 transitions  CSS3 3D transforms）
* 尽量不要使用 DataURI
    - 解析是由成本 
    - 手机端 DataURI 要比简单的外链资源要慢 6 倍
* 合理使用 Canvas 动画
    - Canvas是状态机，减少状态切换能提高效率
    - Canvas分层渲染
    - 少用 shadow
    - canvas.width = canvas.width 代替 context.clearRect(0, 0, width, height)
    - 坐标系整数化
    - 使用 requeatAnimationFrame
    - 放弃 settimeout 动画
* 尽量避免使用DOM。当需要反复使用DOM时，先把对DOM的引用存到JavaScript本地变量里再使用。使用设置innerHTML的方法来替换document.createElement/appendChild()方 法。
* eval()有问题，new Fuction()构造函数也是，尽量避免使用它们。
* 拒绝使用with语句。 它会导致当你引用这个变量时去额外的搜索这样的一个命名空间，with里的代码在编译时期是完全未知的。
* 使用for()循环替代for…in循 环。因为for…in循环在开始循环之前需要Script引擎创建一个含有所有可循环属性的 List，需要多检查一次。
* 把try-catch语句放在循环外面，不要放在循环里面，因为异常是很少发生的，放在外面避免每次都要执行 它们。
* 甚至圣经里都提到过这个 – 不要全局的。全局变量的生命周期贯穿整个脚本的生命周期，而本地变量的存在范围随着本地命名空间的销毁而消失。当在函数或其它地方引用一个全局变量时，脚 本引擎需要搜索整个全局命名空间。
* fullName += 'John'; fullName += 'Holdings';执行速度快于fullName += 'John' + 'Holdings';
* 如果你需要把多个字符串连接起来，最好是把他们做成一个数组，然后调用join()方法实现这个操作。这种方式在生成HTML片段时尤其 有效。
* 对于简单的任务，最好使用基本操作方式来实现，而不是使用函数调用实现。例如val1 < val2 ? val1 : val2;执行速度快于Math.min(val1, val2);，类似的，myArr.push(newEle);慢于myArr[myArr.length] = newEle;
* 将函数的引用作为参数传递到setTimeout()和setInterval()里优于将函数名作为字符串参数传递（硬编码）。例如，setTimeout(“someFunc()”, 1000)执行效率慢于setTimeout(someFunc, 1000)
* 当进行遍历操作时避免使用DOM操作。通过像getElementsByTagName()这 种方法得到的DOM元素队列都是动态的；有可能在你还没有对它遍历完成时，它已经被改变。这有可能导致死循环。
* 当你对对象的成员（属性或方法）进行反复操作时，先存储对它们的引用。例如var getTags = document.getElementsByTagName; getTags(‘div’);
* 在任何的代码段里，在局部变量范围外存放一个这个局部变量的引用。* 在HTTP头信息里加入缓存控制过期和最大存活时间标记。
* 优化CSS。要使用<link>方式，而不要使用@import方式。请参考这个优秀的文档http://www.slideshare.net/stubbornella/object-oriented-css
* 使用CSS技术来优化图片资源
* 用GZip方式压缩 .js 和 .css 文件。如果你使用的是Apache，在 .htaccess 里设置压缩方式，你的HTML, XML 和 JSON 也同时会被压缩。 AddOutputFilterByType DEFLATE text/html text/css text/plain text/xml application/x-javascript application/json
* 使用JavaScript压缩工具。除了使用YUI和JSMin外，你还可以试一试Google Closure http://closure-compiler.appspot.com/home (感谢: James Westgate, 一位读者)
* 优化每个页面上的各种资源，把它们拆分到各个子域上，这么它们就能够并行下载。请参考http://yuiblog.com/blog/2007/04/11/performance-research-part-4/
* 将CSS样式表放在页面的最顶端，这样能方便包括IE在内的浏览器进行解析。
* 尽量将DOM结构保持的越简单越好。DOM的体积会影响相关的操作效率，像查找， 遍历，DOM改动都有影响。document.getElementsByTagName(‘*’).length这 个值越小越好。
* 注意你使用的选择器。例如，如果你想获取一个ul下的直接子元素，使用jQuery(“ul > li”)而不要使用jQuery(“ul li”)
* 当切换元素的可见性时(display),请记住：element.css({display:none})的 速度快于element.hide() 和 element.addClass(‘myHiddenClass’)。 除非在一个循环里，我选择element.addClass(‘myHiddenClass’)， 这样会使代码更简洁 – 不要使用 inline CSS 和 JavaScript。
* 当你使用完对DOM的引用变量后，要把它置为NULL。
* 使用AJAX时，GET的执行效率高于POST。所以要尽量使用 GET 方式。只是要注意一点，IE只允许你用GET传送2K的数据。
* 小心使用脚本动画。没有硬件的支持，动画会执行的很慢。尽量避免使用那些没有实际价值的动画效果。
* 如果你的background-image对于这个图片的容器太小的话，请避免使 用background-repeat。如果你的背景图片需要来回填充很多次才能充满背景，那么将background-repeat属性设置成background-image 和repeat-x 或 repeat-y来 达到填充背景的效果的做法是不明智的，这种填充方式的效率特别的低。你应该尝试使用一个足够大的图片来做background-image并 且使用background-repeat: no-repeat。
* 布局时不要使用<table>。 <table>在浏览器完全把它画出来之前需要反复绘制好几次。因为DOM中<table>是很少见的一种之后输出的会影响之前输出的显示效果的元素。对于表格数据来说，你可 以使用table-layout:fixed; 这是一种更有效的现实算法，根据CSS 2.1技术说明，这种写法可以让表格一行一行的输出。
* 尽可能的使用原始JavaScript。限制JavaScript框架的使用。

```javascript
function foo(arr) {
  var a = ‘something’;//变量 ‘a’ 对于下面的一段就是范围外变量,这个变量的引用在很多情况下会有用处。
  for (var i = 0, j = a, loopLen = arr.length; i < loopLen; i++) {
  //do something
  }
}
```

## 参考

## 工具

* [pa7/heatmap.js](https://github.com/pa7/heatmap.js):🔥 JavaScript Library for HTML5 canvas based heatmaps https://www.patrick-wied.at/static/heatmapjs/
* [pixijs/pixi.js](https://github.com/pixijs/pixi.js):The HTML5 Creation Engine: Create beautiful digital content with the fastest, most flexible 2D WebGL renderer. http://pixijs.com
* [mozilla/BrowserQuest](https://github.com/mozilla/BrowserQuest):A HTML5/JavaScript multiplayer game experiment http://browserquest.mozilla.org/
* [flowjs/flow.js](https://github.com/flowjs/flow.js):A JavaScript library providing multiple simultaneous, stable, fault-tolerant and resumable/restartable file uploads via the HTML5 File API.
* [eligrey/FileSaver.js](https://github.com/eligrey/FileSaver.js):An HTML5 saveAs() FileSaver implementation https://eligrey.com/blog/saving-generated-files-on-the-client-side/
* [nbedos/termtosvg](https://github.com/nbedos/termtosvg):Record terminal sessions as SVG animations https://nbedos.github.io/termtosvg/
* [h5bp/html5-boilerplate](https://github.com/h5bp/html5-boilerplate):A professional front-end template for building fast, robust, and adaptable web apps or sites. https://html5boilerplate.com/
