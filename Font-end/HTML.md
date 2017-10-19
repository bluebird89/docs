# HTML

- 超文本标记语言（HyperText Markup Language，简称：HTML）,是一种标记语言;
- 标记语言是一套标记标签 (markup tag);
- HTML 使用标记标签来描述网页;标签或元素(element);
- 格式:<开始标签>内容<结束标签>;
- HTML 文档由嵌套的 HTML 元素构成。
- 元素属性:属性可以在元素中添加附加信息,属性一般描述于开始标签,属性总是以名称/值对的形式出现，比如：name="value"。

  - class(定义一个或多个类名)
  - id(唯一id)
  - style(元素的行内样式（inline style）)
  - title

```
/*声明为 HTML5 文档*/
<!DOCTYPE html>
/*<html> 元素是 HTML 页面的根元素*/
<html>
/*<head> 元素包含了文档的元（meta）数据*/
<head>
<meta charset="utf-8">
/*<title> 元素描述了文档的标题*/
<title>菜鸟教程(runoob.com)</title>
</head>
/*<body> 元素包含了可见的页面内容*/
<body>
    <h1>我的第一个标题</h1>
    <p>我的第一个段落。</p>
</body>
</html>
```

- 标题 `<h1>这是一个标题</h1>`
- 段落 `<p>这是另外一个段落。</p>`
- 图像 `<img src="/images/logo.png" width="258" height="39" />`
- 空元素:在开始标签中进行关闭: `<br> <hr>`
- 水平线: `<hr>`
- 换行: `<br>`
- 注释: `<!-- 这是一个注释 -->`
- 文本格式化:
- 链接 `<a href="http://www.runoob.com">这是一个链接</a>`

  - target:_top(到父级框架) _blank
  - herf: url #id

- 表格
- 表单
- 列表
- 区块

  - 块级元素(block-level以新行来开始和结束):<div> 元素经常与 CSS 一起使用，用来布局网页。用于组合其他 HTML 元素的容器.
  - 内联元素(inline显示时通常不会以新行开始)<span> 用于对文档中的行内元素进行组合。当对它应用样式时，它才会产生视觉上的变化。如果不对

    <span> 应用样式，那么 <span> 元素中的文本与其他文本不会任何视觉上的差异。标签提供了一种将文本的一部分或者文档的一部分独立出来的方式。</span></span>

# CSS

用 CSS 最大的好处是，如果把 CSS 代码存放到外部样式表中，那么站点会更易于维护 最常用于图片操作、表单验证以及内容动态更新

- 内联样式- 在HTML元素中使用"style" 属性
- 内部样式表 -在HTML文档头部 区域使用

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


a标签不能嵌套

## 扩展

* [hakimel/reveal.js](https://github.com/hakimel/reveal.js):The HTML Presentation Framework http://lab.hakim.se/reveal-js/