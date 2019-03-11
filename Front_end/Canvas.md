# Canvas

HTML5新增的组件，它就像一块幕布，可以用JavaScript在上面绘制各种图表、动画等。没有Canvas的年代，绘图只能借助Flash插件实现，页面不得不用JavaScript和Flash进行交互。有了Canvas，我们就再也不需要Flash了，直接使用JavaScript完成绘制。
在使用Canvas前，用canvas.getContext来测试浏览器是否支持Canvas。

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

## 工具

* [fabricjs/fabric.js](https://github.com/fabricjs/fabric.js):Javascript Canvas Library, SVG-to-Canvas (& canvas-to-SVG) Parser http://fabricjs.com
* [Mikhus/canvas-gauges](https://github.com/Mikhus/canvas-gauges):HTML5 Canvas Gauge. Tiny implementation of highly configurable gauge using pure JavaScript and HTML5 canvas. No dependencies. Suitable for IoT devices because of minimum code base. http://canvas-gauges.com/
* [paperjs/paper.js](https://github.com/paperjs/paper.js):The Swiss Army Knife of Vector Graphics Scripting – Scriptographer ported to JavaScript and the browser, using HTML5 Canvas. Created by @lehni & @puckey http://paperjs.org

## 项目

* [dli/paint](https://github.com/dli/paint):Fluid Paint - http://david.li/paint
