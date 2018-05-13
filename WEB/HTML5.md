# HTML5


## 体验改进的 14 条军规

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
