# HTML5

HTML5 是 W3C(World Wide Web Consortium) 与 WHATWG(Web Hypertext Application Technology Working Group) 合作的结果

## 视频

* 格式
  - Ogg = 带有 Theora 视频编码和 Vorbis 音频编码的 Ogg 文件
  - MPEG4 = 带有 H.264 视频编码和 AAC 音频编码的 MPEG 4 文件
  - WebM = 带有 VP8 视频编码和 Vorbis 音频编码的 WebM 文件
* 属性
  - audioTracks 返回表示可用音轨的 AudioTrackList 对象
  - autoplay    设置或返回是否在加载完成后随即播放音频/视频
  - buffered    返回表示音频/视频已缓冲部分的 TimeRanges 对象
  - controller  返回表示音频/视频当前媒体控制器的 MediaController 对象
  - controls    设置或返回音频/视频是否显示控件（比如播放/暂停等）
  - crossOrigin 设置或返回音频/视频的 CORS 设置
  - currentSrc  返回当前音频/视频的 URL
  - currentTime 设置或返回音频/视频中的当前播放位置（以秒计）
  - defaultMuted    设置或返回音频/视频默认是否静音
  - defaultPlaybackRate 设置或返回音频/视频的默认播放速度
  - duration    返回当前音频/视频的长度（以秒计）
  - ended   返回音频/视频的播放是否已结束
  - error   返回表示音频/视频错误状态的 MediaError 对象
  - loop    设置或返回音频/视频是否应在结束时重新播放
  - mediaGroup  设置或返回音频/视频所属的组合（用于连接多个音频/视频元素）
  - muted   设置或返回音频/视频是否静音
  - networkState    返回音频/视频的当前网络状态
  - paused  设置或返回音频/视频是否暂停
  - playbackRate    设置或返回音频/视频播放的速度
  - played  返回表示音频/视频已播放部分的 TimeRanges 对象
  - preload 设置或返回音频/视频是否应该在页面加载后进行加载
  - readyState  返回音频/视频当前的就绪状态
  - seekable    返回表示音频/视频可寻址部分的 TimeRanges 对象
  - seeking 返回用户是否正在音频/视频中进行查找
  - src 设置或返回音频/视频元素的当前来源
  - startDate   返回表示当前时间偏移的 Date 对象
  - textTracks  返回表示可用文本轨道的 TextTrackList 对象
  - videoTracks 返回表示可用视频轨道的 VideoTrackList 对象
  - volume  设置或返回音频/视频的音量
* 方法
  - addTextTrack()    向音频/视频添加新的文本轨道
  - canPlayType()   检测浏览器是否能播放指定的音频/视频类型
  - load()  重新加载音频/视频元素
  - play()  开始播放音频/视频
  - pause() 暂停当前播放的音频/视频
* 事件
  - abort   当音频/视频的加载已放弃时
  - canplay 当浏览器可以播放音频/视频时
  - canplaythrough  当浏览器可在不因缓冲而停顿的情况下进行播放时
  - durationchange  当音频/视频的时长已更改时
  - emptied 当目前的播放列表为空时
  - ended   当目前的播放列表已结束时
  - error   当在音频/视频加载期间发生错误时
  - loadeddata  当浏览器已加载音频/视频的当前帧时
  - loadedmetadata  当浏览器已加载音频/视频的元数据时
  - loadstart   当浏览器开始查找音频/视频时
  - pause   当音频/视频已暂停时
  - play    当音频/视频已开始或不再暂停时
  - playing 当音频/视频在已因缓冲而暂停或停止后已就绪时
  - progress    当浏览器正在下载音频/视频时
  - ratechange  当音频/视频的播放速度已更改时
  - seeked  当用户已移动/跳跃到音频/视频中的新位置时
  - seeking 当用户开始移动/跳跃到音频/视频中的新位置时
  - stalled 当浏览器尝试获取媒体数据，但数据不可用时
  - suspend 当浏览器刻意不获取媒体数据时
  - timeupdate  当目前的播放位置已更改时
  - volumechange    当音量已更改时
  - waiting 当视频由于需要缓冲下一帧而停止

```html
<video src="movie.ogg" width="320" height="240" controls="controls">
  <source src="movie.ogg" type="video/ogg">
  <source src="movie.mp4" type="video/mp4">
Your browser does not support the video tag.
</video>
```

## 音频

* 格式
  - ogg
  - mp3
  - wav
* 属性
  - audioTracks 返回表示可用音轨的 AudioTrackList 对象
  - autoplay    设置或返回是否在加载完成后随即播放音频/视频
  - buffered    返回表示音频/视频已缓冲部分的 TimeRanges 对象
  - controller  返回表示音频/视频当前媒体控制器的 MediaController 对象
  - controls    设置或返回音频/视频是否显示控件（比如播放/暂停等）
  - crossOrigin 设置或返回音频/视频的 CORS 设置
  - currentSrc  返回当前音频/视频的 URL
  - currentTime 设置或返回音频/视频中的当前播放位置（以秒计）
  - defaultMuted    设置或返回音频/视频默认是否静音
  - defaultPlaybackRate 设置或返回音频/视频的默认播放速度
  - duration    返回当前音频/视频的长度（以秒计）
  - ended   返回音频/视频的播放是否已结束
  - error   返回表示音频/视频错误状态的 MediaError 对象
  - loop    设置或返回音频/视频是否应在结束时重新播放
  - mediaGroup  设置或返回音频/视频所属的组合（用于连接多个音频/视频元素）
  - muted   设置或返回音频/视频是否静音
  - networkState    返回音频/视频的当前网络状态
  - paused  设置或返回音频/视频是否暂停
  - playbackRate    设置或返回音频/视频播放的速度
  - played  返回表示音频/视频已播放部分的 TimeRanges 对象
  - preload 设置或返回音频/视频是否应该在页面加载后进行加载
  - readyState  返回音频/视频当前的就绪状态
  - seekable    返回表示音频/视频可寻址部分的 TimeRanges 对象
  - seeking 返回用户是否正在音频/视频中进行查找
  - src 设置或返回音频/视频元素的当前来源
  - startDate   返回表示当前时间偏移的 Date 对象
  - textTracks  返回表示可用文本轨道的 TextTrackList 对象
  - videoTracks 返回表示可用视频轨道的 VideoTrackList 对象
  - volume  设置或返回音频/视频的音量
* 方法
  - addTextTrack()  向音频/视频添加新的文本轨道
  - canPlayType()   检测浏览器是否能播放指定的音频/视频类型
  - load()  重新加载音频/视频元素
  - play()  开始播放音频/视频
  - pause() 暂停当前播放的音频/视频
* 事件
  - abort   当音频/视频的加载已放弃时
  - canplay 当浏览器可以播放音频/视频时
  - canplaythrough  当浏览器可在不因缓冲而停顿的情况下进行播放时
  - durationchange  当音频/视频的时长已更改时
  - emptied 当目前的播放列表为空时
  - ended   当目前的播放列表已结束时
  - error   当在音频/视频加载期间发生错误时
  - loadeddata  当浏览器已加载音频/视频的当前帧时
  - loadedmetadata  当浏览器已加载音频/视频的元数据时
  - loadstart   当浏览器开始查找音频/视频时
  - pause   当音频/视频已暂停时
  - play    当音频/视频已开始或不再暂停时
  - playing 当音频/视频在已因缓冲而暂停或停止后已就绪时
  - progress    当浏览器正在下载音频/视频时
  - ratechange  当音频/视频的播放速度已更改时
  - seeked  当用户已移动/跳跃到音频/视频中的新位置时
  - seeking 当用户开始移动/跳跃到音频/视频中的新位置时
  - stalled 当浏览器尝试获取媒体数据，但数据不可用时
  - suspend 当浏览器刻意不获取媒体数据时
  - timeupdate  当目前的播放位置已更改时
  - volumechange    当音量已更改时
  - waiting 当视频由于需要缓冲下一帧而停止

```html
<audio controls="controls">
  <source src="song.ogg" type="audio/ogg">
  <source src="song.mp3" type="audio/mpeg">
Your browser does not support the audio tag.
</audio>
```

## 拖放

抓取对象以后拖到另一个位置

* 使元素可拖动，把 draggable 属性设置为 true
* ondragstart 属性调用了一个函数，drag(event)，它规定了被拖动的数据
* dataTransfer.setData() 方法设置被拖数据的数据类型和值
* ondragover 事件规定在何处放置被拖动的数据,默认地，无法将数据/元素放置到其他元素中。如果需要设置允许放置，我们必须阻止对元素的默认处理方式。
* 当放置被拖数据时，会发生 drop 事件

```html
<!DOCTYPE HTML>
<html>
<head>
    <script type="text/javascript">
    function allowDrop(ev)
    {
        ev.preventDefault();
    }

    function drag(ev)
    {
        ev.dataTransfer.setData("Text",ev.target.id);
    }

    function drop(ev)
    {
        ev.preventDefault();
        var data=ev.dataTransfer.getData("Text");
        ev.target.appendChild(document.getElementById(data));
    }
    </script>
</head>
<body>

<div id="div1" ondrop="drop(event)" ondragover="allowDrop(event)"></div>
<img id="drag1" src="img_logo.gif" draggable="true" ondragstart="drag(event)" width="336" height="69" />
<div id="div2" ondrop="drop(event)" ondragover="allowDrop(event)"></div>
</body>
</html>
```

## Canvas

* HTML5新增的组件，它就像一块幕布，可以用JavaScript在上面绘制各种图表、动画等。
* 没有Canvas的年代，绘图只能借助Flash插件实现，页面不得不用JavaScript和Flash进行交互。 有了Canvas，我们就再也不需要Flash了，直接使用JavaScript完成绘制。
* 在使用Canvas前，用canvas.getContext来测试浏览器是否支持Canvas,JavaScript代码放在元素下面
* 功能
  - 颜色、样式和阴影
    + 属性
      * fillStyle   设置或返回用于填充绘画的颜色、渐变或模式
      * strokeStyle 设置或返回用于笔触的颜色、渐变或模式
      * shadowColor 设置或返回用于阴影的颜色
      * shadowBlur  设置或返回用于阴影的模糊级别
      * shadowOffsetX   设置或返回阴影距形状的水平距离
      * shadowOffsetY   设置或返回阴影距形状的垂直距离
    + 方法
      * createLinearGradient()  创建线性渐变（用在画布内容上）
      * createPattern() 在指定的方向上重复指定的元素
      * createRadialGradient()  创建放射状/环形的渐变（用在画布内容上）
      * addColorStop()  规定渐变对象中的颜色和停止位置
  - 线条样式
    + 属性
      * lineCap 设置或返回线条的结束端点样式
      * lineJoin    设置或返回两条线相交时，所创建的拐角类型
      * lineWidth   设置或返回当前的线条宽度
      * miterLimit  设置或返回最大斜接长度
  - 矩形
    + 方法
      * rect()  创建矩形
      * fillRect()  绘制“被填充”的矩形
      * strokeRect()    绘制矩形（无填充）
      * clearRect() 在给定的矩形内清除指定的像素
  - 路径
    + 方法
      * fill()  填充当前绘图（路径）
      * stroke()    绘制已定义的路径
      * beginPath() 起始一条路径，或重置当前路径
      * moveTo()    把路径移动到画布中的指定点，不创建线条
      * closePath() 创建从当前点回到起始点的路径
      * lineTo()    添加一个新点，然后在画布中创建从该点到最后指定点的线条
      * clip()  从原始画布剪切任意形状和尺寸的区域
      * quadraticCurveTo()  创建二次贝塞尔曲线
      * bezierCurveTo() 创建三次方贝塞尔曲线
      * arc()   创建弧/曲线（用于创建圆形或部分圆）
      * arcTo() 创建两切线之间的弧/曲线
      * isPointInPath() 如果指定的点位于当前路径中，则返回 true，否则返回 false
  - 转换
    + 方法
      * scale() 缩放当前绘图至更大或更小
      * rotate()    旋转当前绘图
      * translate() 重新映射画布上的 (0,0) 位置
      * transform() 替换绘图的当前转换矩阵
      * setTransform()  将当前转换重置为单位矩阵。然后运行 transform()
  - 文本
    + 属性
      * font    设置或返回文本内容的当前字体属性
      * textAlign   设置或返回文本内容的当前对齐方式
      * textBaseline    设置或返回在绘制文本时使用的当前文本基线
    + 方法
      * fillText()  在画布上绘制“被填充的”文本
      * strokeText()    在画布上绘制文本（无填充）
      * measureText()   返回包含指定文本宽度的对象
  - 图像绘制
    + 方法
      * drawImage() 向画布上绘制图像、画布或视频
  - 像素操作
    + 属性
      * width   返回 ImageData 对象的宽度
      * height  返回 ImageData 对象的高度
      * data    返回一个对象，其包含指定的 ImageData 对象的图像数据
    + 方法
      * createImageData()   创建新的、空白的 ImageData 对象
      * getImageData()  返回 ImageData 对象，该对象为画布上指定的矩形复制像素数据
      * putImageData()  把图像数据（从指定的 ImageData 对象）放回画布上
  - 合成
    + 属性
      * globalAlpha 设置或返回绘图的当前 alpha 或透明值
      * globalCompositeOperation    设置或返回新图像如何绘制到已有的图像上
  - 其他
    + 方法
      * save()  保存当前环境的状态
      * restore()   返回之前保存过的路径状态和属性

```html
<canvas id="test-canvas" width="200" heigth="100">
    <p>你的浏览器不支持Canvas</p>
</canvas>

<script>
    var canvas = document.getElementById('test-canvas'), ctx = canvas.getContext('2d');
    // 绘制笑脸
    ctx.clearRect(0, 0, 200, 200); // 擦除(0,0)位置大小为200x200的矩形，擦除的意思是把该区域变为透明
    ctx.fillStyle = '#dddddd'; // 设置颜色
    ctx.fillRect(10, 10, 130, 130); // 把(10,10)位置大小为130x130的矩形涂色
    // 利用Path绘制复杂路径:
    var path=new Path2D();
    path.arc(75, 75, 50, 0, Math.PI*2, true);
    path.moveTo(110,75);
    path.arc(75, 75, 35, 0, Math.PI, false);
    path.moveTo(65, 65);
    path.arc(60, 65, 5, 0, Math.PI*2, true);
    path.moveTo(95, 65);
    path.arc(90, 65, 5, 0, Math.PI*2, true);
    ctx.strokeStyle = '#0000ff';
    ctx.stroke(path);

    // 文字
    ctx.clearRect(0, 0, 200, 200); // 擦除(0,0)位置大小为200x200的矩形，擦除的意思是把该区域变为透明
    ctx.fillStyle = '#dddddd'; // 设置颜色
    ctx.fillRect(10, 10, 130, 130); // 把(10,10)位置大小为130x130的矩形涂色
    // 利用Path绘制复杂路径:
    var path=new Path2D();
    path.arc(75, 75, 50, 0, Math.PI*2, true);
    path.moveTo(110,75);
    path.arc(75, 75, 35, 0, Math.PI, false);
    path.moveTo(65, 65);
    path.arc(60, 65, 5, 0, Math.PI*2, true);
    path.moveTo(95, 65);
    path.arc(90, 65, 5, 0, Math.PI*2, true);
    ctx.strokeStyle = '#0000ff';
    ctx.stroke(path);
    var gl = canvas.getContext("webgl");
</script>
```

### 工具

* [fabricjs/fabric.js](https://github.com/fabricjs/fabric.js):Javascript Canvas Library, SVG-to-Canvas (& canvas-to-SVG) Parser http://fabricjs.com
* [Mikhus/canvas-gauges](https://github.com/Mikhus/canvas-gauges):HTML5 Canvas Gauge. Tiny implementation of highly configurable gauge using pure JavaScript and HTML5 canvas. No dependencies. Suitable for IoT devices because of minimum code base. http://canvas-gauges.com/
* [paperjs/paper.js](https://github.com/paperjs/paper.js):The Swiss Army Knife of Vector Graphics Scripting – Scriptographer ported to JavaScript and the browser, using HTML5 Canvas. Created by @lehni & @puckey http://paperjs.org

### 项目

* [dli/paint](https://github.com/dli/paint):Fluid Paint - http://david.li/paint
* [canvas粒子时钟](https://www.cnblogs.com/xiaohuochai/p/6368039.html)

## SVG(Scalable Vector Graphics)

* SVG 用于定义用于网络的基于矢量的图形
* SVG 使用 XML 格式定义图形
* SVG 图像在放大或改变尺寸的情况下其图形质量不会有损失
* SVG 是万维网联盟的标准
* 与其他图像格式相比（比如 JPEG 和 GIF）的优势
  - SVG 图像可通过文本编辑器来创建和修改
  - SVG 图像可被搜索、索引、脚本化或压缩
  - SVG 是可伸缩的
  - SVG 图像可在任何的分辨率下被高质量地打印
  - SVG 可在图像质量不下降的情况下被放大

### 工具

* [duopixel/Method-Draw](https://github.com/duopixel/Method-Draw):Method Draw, the SVG Editor for Method of Action http://editor.method.ac

### Canvas vs SVG

* SVG
  - 一种使用 XML 描述 2D 图形的语言。
  - 意味着 SVG DOM 中的每个元素都是可用的。您可以为某个元素附加 JavaScript 事件处理器。
  - 每个被绘制的图形均被视为对象。如果 SVG 对象的属性发生变化，那么浏览器能够自动重现图形。
  - 依赖分辨率
  - 不支持事件处理器
  - 弱的文本渲染能力
  - 能够以 .png 或 .jpg 格式保存结果图像
  - 最适合图像密集型的游戏，其中的许多对象会被频繁重绘
* Canvas
  + Canvas 通过 JavaScript 来绘制 2D 图形。
  + Canvas 是逐像素进行渲染的。
  + 在 canvas 中，一旦图形被绘制完成，它就不会继续得到浏览器的关注。如果其位置发生变化，那么整个场景也需要重新绘制，包括任何或许已被图形覆盖的对象。
  - 不依赖分辨率
  - 支持事件处理器
  - 最适合带有大型渲染区域的应用程序（比如谷歌地图）
  - 复杂度高会减慢渲染速度（任何过度使用 DOM 的应用都不快）
  - 不适合游戏应用

## Geolocation

定位用户的位置

* 属性
  - coords.latitude 十进制数的纬度
  - coords.longitude    十进制数的经度
  - coords.accuracy 位置精度
  - coords.altitude 海拔，海平面以上以米计
  - coords.altitudeAccuracy 位置的海拔精度
  - coords.heading  方向，从正北开始以度计
  - coords.speed    速度，以米/每秒计
  - timestamp   响应的日期/时间

## Web存储

* localStorage:没有时间限制的数据存储
  - cookie 不适合大量数据的存储，因为它们由每个对服务器的请求来传递
  - 存储的数据没有时间限制
* sessionStorage - 针对一个 session 的数据存储
  - 当用户关闭浏览器窗口后，数据会被删除

## Application Cache

* 优势
  - 离线浏览 - 用户可在应用离线时使用它们
  - 速度 - 已缓存资源加载得更快
  - 减少服务器负载 - 浏览器将只从服务器下载更新过或更改过的资源
* 使用
  - 指定缓存文件 manifest，扩展名是：".appcache"
  - 配置
    + manifest 文件需要配置正确的 MIME-type，即 "text/cache-manifest"。必须在 web 服务器上进行配置
    + 以 "#" 开头的是注释行
    + manifest 文件可分为三个部分
      * CACHE MANIFEST：必须：列出的文件将在首次下载后进行缓存
        - 当 manifest 文件加载后，浏览器会从网站的根目录下载这三个文件。然后，无论用户何时与因特网断开连接，这些资源依然是可用的
      * NETWORK：列出的文件需要与服务器的连接，且不会被缓存
        - 用星号来指示所有其他其他资源/文件都需要因特网连接
      * FALLBACK：列出的文件规定当页面无法访问时的回退页面
        - 可以列多个，依次替补
  - 更新
    + 一旦文件被缓存，则浏览器会继续展示已缓存的版本，即使您修改了服务器上的文件。为了确保浏览器更新缓存，您需要更新 manifest 文件
    + 用户清空浏览器缓存
    + manifest 文件被修改:更新注释行中的日期和版本号是一种使浏览器重新缓存文件的办法。
    + 由程序来更新应用缓存

```html
<!DOCTYPE HTML>
<html manifest="demo.appcache">
...
</html>

// demo.appcache 配置
CACHE MANIFEST
# 2012-02-21 v1.0.0
/theme.css
/logo.gif
/main.js

NETWORK:
login.asp

FALLBACK:
/html5/ /404.html
```

## Web Workers

* 当在 HTML 页面中执行脚本时，页面的状态是不可响应的，直到脚本已完成。 web worker 是运行在后台的 JavaScript，独立于其他脚本，不会影响页面的性能

## 服务器发送事件（server-sent event）

允许网页获得来自服务器的更新

* 使用
  - 创建一个新的 EventSource 对象，然后规定发送更新的页面的 URL
  - 每接收到一次更新，就会发生 onmessage 事件
  - 当 onmessage 事件发生时，把已接收的数据推入 id 为 "result" 的元素中
* 方法
  - onopen    当通往服务器的连接被打开
  - onmessage   当接收到消息
  - onerror 当错误发生

```js
if(typeof(EventSource)!=="undefined")
  {
  var source=new EventSource("../example/html5/demo_sse.php");
  source.onmessage=function(event)
    {
    document.getElementById("result").innerHTML+=event.data + "<br />";
    };
  }
else
  {
  document.getElementById("result").innerHTML="Sorry, your browser does not support server-sent events...";
  }
```

## 表单

* 类型
  - email
  - url
  - number
    + max   number  规定允许的最大值
    + min number  规定允许的最小值
    + step    number  规定合法的数字间隔（如果 step="3"，则合法的数是 -3,0,3,6 等）
    + value   number  规定默认值
  - range
    + max   number  规定允许的最大值
    + min number  规定允许的最小值
    + step    number  规定合法的数字间隔（如果 step="3"，则合法的数是 -3,0,3,6 等）
    + value   number  规定默认值
  - Date pickers (date, month, week, time, datetime, datetime-local)
  - search
  - color
  - datalist 元素规定输入域的选项列表
    + 列表是通过 datalist 内的 option 元素创建的。
    + 如需把 datalist 绑定到输入域，请用输入域的 list 属性引用 datalist 的 id
    + option 元素永远都要设置 value 属性
  - keygen 元素的作用是提供一种验证用户的可靠方法。
    + keygen 元素是密钥对生成器（key-pair generator）。当提交表单时，会生成两个键，一个是私钥，一个公钥。
    + 私钥（private key）存储于客户端，公钥（public key）则被发送到服务器。公钥可用于之后验证用户的客户端证书（client certificate）。
  - output 元素用于不同类型的输出
* 属性
  - 表单
    + autocomplete:form 应该拥有自动完成功能
    + novalidate:提交表单时不应该验证 form 或 input 域
  - inut
    + autocomplete:input 域应该拥有自动完成功能
    + autofocus:在页面加载时，域自动地获得焦点
    + form:规定输入域所属的一个或多个表单,必须引用所属表单的 id
    + form overrides:重写 form 元素的某些属性设定
      + formaction
      + formenctype
      + formmethod
      + formnovalidate
      + formtarget
    + height 和 width:只适用于 image 类型的 <input> 标签
    + list:规定输入域的 datalist。datalist 是输入域的选项列表
    + min, max 和 step
    + multiple:可选择多个值,用于 email 和 file
    + pattern (regexp):用于验证 input 域的模式
    + placeholder:提供一种提示（hint），描述输入域所期待的值
    + required:必须在提交之前填写输入域（不能为空）

```html
Webpage: <input type="url" list="url_list" name="link" />
<datalist id="url_list">
<option label="W3School" value="http://www.W3School.com.cn" />
<option label="Google" value="http://www.google.com" />
<option label="Microsoft" value="http://www.microsoft.com" />
</datalist>
```

## 事件

* window
  - onafterprint：在打印文档之后运行脚本
  - onbeforeprint：在文档打印之前运行脚本
  - onbeforeonload：在文档加载之前运行脚本
  - onblur：当窗口失去焦点时运行脚本
  - onerror：当错误发生时运行脚本
  - onfocus：当窗口获得焦点时运行脚本
  - onhaschange：当文档改变时运行脚本
  - onload：当文档加载时运行脚本
  - onunload   ：当用户离开文档时运行脚本
  - onmessage ：当触发消息时运行脚本
  - onoffline  ：当文档离线时运行脚本
  - ononline   ：当文档上线时运行脚本
  - onpagehide ：当窗口隐藏时运行脚本
  - onpageshow ：当窗口可见时运行脚本
  - onpopstate ：当窗口历史记录改变时运行脚本
  - onredo ：当文档执行再执行操作（redo）时运行脚本
  - onresize   ：当调整窗口大小时运行脚本
  - onstorage  ：当文档加载加载时运行脚本
  - onundo ：当 Web Storage 区域更新时（存储空间中的数据发生变化时）
* form
  - onfocus:当元素获得焦点时运行脚本
  - onblur :当元素失去焦点时运行脚本
  - onchange   :当元素改变时运行脚本
  - oncontextmenu  :当触发上下文菜单时运行脚本
  - onformchange   :当表单改变时运行脚本
  - onforminput:当表单获得用户输入时运行脚本
  - oninput:当元素获得用户输入时运行脚本
  - oninvalid  :当元素无效时运行脚本
  - onreset:当表单重置时运行脚本。HTML 5 不支持。
  - onselect   :当选取元素时运行脚本
  - onsubmit   :当提交表单时运行脚本
* 键盘
  - onkeydown：当按下按键时运行脚本
  - onkeypress：当按下并松开按键时运行脚本
  - onkeyup：当松开按键时运行脚本
* 鼠标
  - onclick：当单击鼠标时运行脚本
  - ondblclick ：当双击鼠标时运行脚本
  - ondrag ：当拖动元素时运行脚本
  - ondragend  ：当拖动操作结束时运行脚本
  - ondragenter：当元素被拖动至有效的拖放目标时运行脚本
  - ondragleave：当元素离开有效拖放目标时运行脚本
  - ondragover ：当元素被拖动至有效拖放目标上方时运行脚本
  - ondragstart：当拖动操作开始时运行脚本
  - ondrop ：当被拖动元素正在被拖放时运行脚本
  - onmousedown：当按下鼠标按钮时运行脚本
  - onmousemove：当鼠标指针移动时运行脚本
  - onmouseout ：当鼠标指针移出元素时运行脚本
  - onmouseover：当鼠标指针移至元素之上时运行脚本
  - onmouseup  ：当松开鼠标按钮时运行脚本
  - onmousewheel   ：当转动鼠标滚轮时运行脚本
  - onscroll   ：当滚动元素滚动元素的滚动条时运行脚本
* 媒体
  - onabort：当发生中止事件时运行脚本
  - oncanplay  ：当媒介能够开始播放但可能因缓冲而需要停止时运行脚本
  - oncanplaythrough   ：当媒介能够无需因缓冲而停止即可播放至结尾时运行脚本
  - ondurationchange   ：当媒介长度改变时运行脚本
  - onemptied  ：当媒介资源元素突然为空时（网络错误、加载错误等）运行脚本
  - onended：当媒介已抵达结尾时运行脚本
  - onerror：当在元素加载期间发生错误时运行脚本
  - onloadeddata   ：当加载媒介数据时运行脚本
  - onloadedmetadata   ：当媒介元素的持续时间以及其他媒介数据已加载时运行脚本
  - onloadstart：当浏览器开始加载媒介数据时运行脚本
  - onpause：当媒介数据暂停时运行脚本
  - onplay ：当媒介数据将要开始播放时运行脚本
  - onplaying  ：当媒介数据已开始播放时运行脚本
  - onprogress ：当浏览器正在取媒介数据时运行脚本
  - onratechange   ：当媒介数据的播放速率改变时运行脚本
  - onreadystatechange ：当就绪状态（ready-state）改变时运行脚本
  - onseeked   ：当媒介元素的定位属性 [1] 不再为真且定位已结束时运行脚本
  - onseeking  ：当媒介元素的定位属性为真且定位已开始时运行脚本
  - onstalled  ：当取回媒介数据过程中（延迟）存在错误时运行脚本
  - onsuspend  ：当浏览器已在取媒介数据但在取回整个媒介文件之前停止时运行脚本
  - ontimeupdate   ：当媒介改变其播放位置时运行脚本
  - onvolumechange ：当媒介改变音量亦或当音量被设置为静音时运行脚本
  - onwaiting  ：当媒介已停止播放但打算继续播放时运行脚本

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

## 工具

* [pa7/heatmap.js](https://github.com/pa7/heatmap.js):🔥 JavaScript Library for HTML5 canvas based heatmaps https://www.patrick-wied.at/static/heatmapjs/
* [pixijs/pixi.js](https://github.com/pixijs/pixi.js):The HTML5 Creation Engine: Create beautiful digital content with the fastest, most flexible 2D WebGL renderer. http://pixijs.com
* [mozilla/BrowserQuest](https://github.com/mozilla/BrowserQuest):A HTML5/JavaScript multiplayer game experiment http://browserquest.mozilla.org/
* [flowjs/flow.js](https://github.com/flowjs/flow.js):A JavaScript library providing multiple simultaneous, stable, fault-tolerant and resumable/restartable file uploads via the HTML5 File API.
* [eligrey/FileSaver.js](https://github.com/eligrey/FileSaver.js):An HTML5 saveAs() FileSaver implementation https://eligrey.com/blog/saving-generated-files-on-the-client-side/
* [nbedos/termtosvg](https://github.com/nbedos/termtosvg):Record terminal sessions as SVG animations https://nbedos.github.io/termtosvg/
* [h5bp/html5-boilerplate](https://github.com/h5bp/html5-boilerplate):A professional front-end template for building fast, robust, and adaptable web apps or sites. https://html5boilerplate.com/
* [turbolinks](https://github.com/turbolinks/turbolinks):Turbolinks makes navigating your web application faster

## 参考
