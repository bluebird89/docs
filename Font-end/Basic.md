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

  ,含在head或者body中
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