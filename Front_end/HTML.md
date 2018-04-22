# HTML（HyperText Markup Language，简称：HTML）

超文本标记语言,是一种标记语言

* 标记语言是一套标记标签 (markup tag);
* HTML 使用标记标签来描述网页;标签或元素(element);
* 格式:<开始标签>内容<结束标签>;
* HTML 文档由嵌套的 HTML 元素构成。
* 元素属性:属性可以在元素中添加附加信息,属性一般描述于开始标签,属性总是以名称/值对的形式出现，比如：name="value"。

## 元素

* class(定义一个或多个类名)
* id(唯一id)
* style(元素的行内样式（inline style）)
* title

### table

`<table>`属性

 * width：表格的宽度，默认单位是px(像素)。
 * height：表格的高度。
 * border：边框的粗细。
 * bordercolor：边框颜色。
 * rules：合并单元格边线。取值：All
 * cellpadding：单元格边线到内容之间的距离(填充距离)。
 * cellspacing：两个单元格之间的距离(间距)
 * background：背景图片
 * bgColor：表格背景颜色
 * align：表格水平对齐方式，取值：left、center、right

`<tr>`属性

* height：行高
* backgroundColor：背景色
* background：背景图片
* align：水平对齐
* valign：垂直对齐，取值：top、middle、bottom

`<td>`或`<th>`属性

* width：单元格宽度
* height：单元格高度
* bgColor：背景色
* background：背景图片
* align：水平对齐
* valign：垂直对齐
* colspan：跨列合并
* rowspan：跨行合并

```html
<table>
    <tr>
        <td>内容</td>
    </tr>
</table>
```

```html
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

## HTML5

# 结构

- 元数据元素

# 元素

- 元素嵌套

  - 父子关系（父元素唯一）

    - 兄弟关系：

  - 祖先-后代关系：

- 表示结构元素 div

# 属性

- id 独一无二
- class 可以累加

# HTML5

语义与表现分离

# DOM

表示文档中所有元素的JavaScript对象模型

- HTMLElement

  - classname：getElementByClassName
  - id:
  - tagName
  - querySelector
  - querySelectorAll

# event

- type:事件名 -

# CSS

- color background-color font-size border
- 行内样式 内嵌样式 >外部样式> 用户样式（user stylesheets\custom.CSS）>浏览器样式
- 选择器：

  - * \

    <type\> .\<class\> #<id>
      <type>.<class>
    </class></type>
    </id></class\></type\>

  - 复杂度与搜索时间有关 [attr] [attr='val'] [attr$='val'] [attr^='val']
  - 关系选择器：后代：

    <selector>
      <selector> 子元素<selector> &gt; <selector> 兄弟元素（之后的的第一个选择器2元素） <selector> + <selector> 之后的所有选择器2的兄弟元素<selector> ~ <selector>
    </selector></selector></selector></selector></selector></selector></selector>
    </selector>

  - stylus less sass
  - 伪元素： ：active ：hover
  - 联合选择器 ： \

    <selector\> ， <selector> ：not(selector)</selector></selector\>

  - 同级样式会对比专一程度： id>其他属性与伪类个数>元素名字与伪元素名字个数

- 样式层叠器
- 样式单位

  - 颜色： 颜色white 十六进制#ffffff 十进制255,255,255 rgb（112,128.144,0.4） hsl(h, s, l)
  - 长度：

    - 绝对 in cm mm pt磅 pc皮卡
    - 相对(另一个尺寸倍数) em相对元素字号高度 ex rem px像素 %

# JavaScript

脚本语言

- 直接写入 HTML 输出流
- 对事件的响应
- 改变 HTML 内容、属性、样式
- 验证输入
- 使用

  <script>
  </script>

 含在head或者body中
- 对大小写敏感
- 使用 Unicode 字符集
- 分号用于分隔 JavaScript 语句
- 按照编写顺序依次执行每条语句，通过函数编写代码块：代码块的作用是一并地执行语句序列。

## 输出数据

- window.alert() 弹出警告框。
- 使用 document.write() 方法将内容写到 HTML 文档中。

  ```
  折行
  document.write("你好 \
  世界!");
  ```

- 使用 innerHTML 写入到 HTML 元素（操作 HTML 元素）。
- 使用 console.log() 写入到浏览器的控制台：能看到结构化的东西；不会打断页面的操作

## 语法

- 固定值称为字面量
- 数据类型：

  - Null:将变量的值设置为 null 来清空变量
  - Undefined:表示变量不含有值
  - Number
  - string
  - Boolean
  - array
  - object：

    - 键值对在 JavaScript 对象通常称为 对象属性
    - 对象的方法定义了一个函数，并作为对象的属性存储。对象方法通过添加 () 调用 (作为一个函数)。

  - function：函数是由事件驱动的或者当它被调用时执行的可重复使用的代码块。

    - 参数
    - 返回值
    - 作用域：
    - 局部变量：只能在函数内部访问它
    - 全局变量：网页上的所有脚本和函数都能访问它 -

- 变量，用于存储信息的"容器"：var x = 5, age=30, job="carpenter";

  - 生命周期：在它声明时初始化，局部变量在函数执行完毕后销毁，全局变量在页面关闭后销毁

- 注释：

  - 单行：//
  - 多行：/** /

- 事件


a标签不能嵌套

## 扩展

* [hakimel/reveal.js](https://github.com/hakimel/reveal.js):The HTML Presentation Framework http://lab.hakim.se/reveal-js/

> 参考

* [joshbuchea/HEAD](https://github.com/joshbuchea/HEAD):A list of everything that *could* go in the head of your document https://gethead.info
* [Bilibili/flv.js](https://github.com/Bilibili/flv.js)HTML5 FLV Player
* [h5bp/html5-boilerplate](https://github.com/h5bp/html5-boilerplate):A professional front-end template for building fast, robust, and adaptable web apps or sites. https://html5boilerplate.com/
* [HTML](https://html.spec.whatwg.org/) [HTML中文](https://whatwg-cn.github.io/html/)
