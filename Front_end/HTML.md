# HTML（HyperText Markup Language）

* 超文本标记语言,是一套标记标签 (markup tag);
* HTML 使用标记标签来描述网页,标签或元素(element),格式:<开始标签>内容<结束标签>;
* HTML 文档由嵌套的 HTML 元素构成。
* 元素属性:属性可以在元素中添加附加信息,属性一般描述于开始标签,属性总是以名称/值对的形式出现，比如：name="value"。

## 元素 Element

* class(定义一个或多个类名) 可以累加
* id(唯一id)
* style(元素的行内样式（inline style）)
* title

### table

* 标题 `<h1>这是一个标题</h1>`
* 段落 `<p>这是另外一个段落。</p>`
* 图像 `<img src="/images/logo.png" width="258" height="39" />`
* 空元素:在开始标签中进行关闭: `<br> <hr>`
* 水平线: `<hr>`
* 换行: `<br>`
* 注释: `<!-- 这是一个注释 -->`
* 文本格式化:
* 链接 `<a href="http://www.runoob.com">这是一个链接</a>`
  - target:_top(到父级框架) _blank
  - herf: url #id
* 表格
  - `<table>`属性
     + width：表格的宽度，默认单位是px(像素)。
     + height：表格的高度。
     + border：边框的粗细。
     + bordercolor：边框颜色。
     + rules：合并单元格边线。取值：All
     + cellpadding：单元格边线到内容之间的距离(填充距离)。
     + cellspacing：两个单元格之间的距离(间距)
     + background：背景图片
     + bgColor：表格背景颜色
     + align：表格水平对齐方式，取值：left、center、right
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
    + align：水平对齐
    + valign：垂直对齐
    + colspan：跨列合并
    + rowspan：跨行合并
* 表单
* 列表
* 区块
  - 块级元素(block-level以新行来开始和结束):<div> 元素经常与 CSS 一起使用，用来布局网页。用于组合其他 HTML 元素的容器.
  - 内联元素(inline显示时通常不会以新行开始)<span> 用于对文档中的行内元素进行组合。当对它应用样式时，它才会产生视觉上的变化。如果不对

    <span> 应用样式，那么 <span> 元素中的文本与其他文本不会任何视觉上的差异。标签提供了一种将文本的一部分或者文档的一部分独立出来的方式。</span></span>

```html
/*声明为 HTML5 文档*/
<!DOCTYPE html>
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

    <table>
      <tr>
          <td>内容</td>
      </tr>
    </table>

    <a href="javascript:void(0)"
   onclick="(function() {
           window.open(<?= "'" . Yii::app()->createUrl('disclosure/disclosure/users', array('model_id' => $value->id)) . "'" ?>, '_blank');
           location.reload();
           })()">click</a>
</body>
</html>
```

## 结构

- 元数据元素

## 元素

- 元素嵌套
  - 父子关系（父元素唯一）
  - 兄弟关系：
  - 祖先-后代关系：
- 表示结构元素 div

## DOM

表示文档中所有元素的JavaScript对象模型

- HTMLElement
  - classname：getElementByClassName
  - id:
  - tagName
  - querySelector
  - querySelectorAll

## event

- type:事件名

## 扩展

* [hakimel/reveal.js](https://github.com/hakimel/reveal.js):The HTML Presentation Framework http://lab.hakim.se/reveal-js/

## Dashboard

* [tabler/tabler](https://github.com/tabler/tabler):Tabler is free and open-source HTML Dashboard UI Kit built on Bootstrap 4 https://tabler.github.io/

## 参考

* [joshbuchea/HEAD](https://github.com/joshbuchea/HEAD):A list of everything that *could* go in the head of your document https://gethead.info
* [Bilibili/flv.js](https://github.com/Bilibili/flv.js)HTML5 FLV Player
* [h5bp/html5-boilerplate](https://github.com/h5bp/html5-boilerplate):A professional front-end template for building fast, robust, and adaptable web apps or sites. https://html5boilerplate.com/
* [HTML](https://html.spec.whatwg.org/) [HTML中文](https://whatwg-cn.github.io/html/)
