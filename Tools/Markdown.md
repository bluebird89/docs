# Markdown 语法 Markdown syntax guide 

Markdown is a way to style text on the web. You control the display of the document; formatting words as bold or italic, adding images, and creating lists are just a few of the things we can do with Markdown. Mostly, Markdown is just regular text with a few non-alphabetic characters thrown in, like # or *.

GitHub supports [emoji](https://www.webpagefx.com/tools/emoji-cheat-sheet/)! :smile: 

## 设计哲学 Philosophy

> Markdown 的目標是實現「易讀易寫」。
> 
> 不過最需要強調的便是它的可讀性。一份使用 Markdown 格式撰寫的文件應該可以直接以純文字發佈，並且看起來不會像是由許多標籤或是格式指令所構成。
> 
> Markdown 的語法有個主要的目的：用來作為一種網路內容的*寫作*用語言。
> 
> Markdown is intended to be as easy-to-read and easy-to-write as is feasible.
> 
> Readability, however, is emphasized above all else. A Markdown-formatted document should be publishable as-is, as plain text, without looking like it's been marked up with tags or formatting instructions.
> 
> Markdown's syntax is intended for one purpose: to be used as a format for *writing* for the web.

<!-- more -->
--------------------------------------------------------------------------------

## 标题  Headers

Markdown 语法：**Example:**

```
# 第一级标题 `<h1>` 
## 第二级标题 `<h2>` 
###### 第六级标题 `<h6>` 

# This is an `<h1>` tag
## This is an `<h2>` tag
###### This is an `<h6>` tag
```

效果如下：**Result:**

# 第一级标题 `<h1>` 
## 第二级标题 `<h2>` 
###### 第六级标题 `<h6>` 

# This is an `<h1>` tag
## This is an `<h2>` tag
###### This is an `<h6>` tag

## 强调 Emphasis

Markdown 语法： **Example:**

```
*这些文字会生成`<em>`*
_这些文字会生成`<u>`_

**这些文字会生成`<strong>`**
__这些文字会生成`<strong>`__

*This text will be italic*
_This will also be italic_

**This text will be bold**
__This will also be bold__

*You **can** combine them*
```

效果如下：**Result:**

*这些文字会生成`<em>`*
_这些文字会生成`<u>`_

**这些文字会生成`<strong>`**
__这些文字会生成`<strong>`__

*This text will be italic*
_This will also be italic_

**This text will be bold**
__This will also be bold__

*You **can** combine them*

## 换行 Newlines

四个及以上空格加回车。
End a line with two or more spaces + enter.

## 列表 Lists

### 无序列表 Unordered

Markdown 语法： **Example:**

```
* 项目一 无序列表 `* + 空格键`
* 项目二
    * 项目二的子项目一 无序列表 `TAB + * + 空格键`
    * 项目二的子项目二

* Item 1 unordered list `* + SPACE`
* Item 2
    * Item 2a unordered list `TAB + * + SPACE`
    * Item 2b

- Dashes work just as well
- And if you have sub points, put two spaces before the dash or star:
  - Like this
  - And this
```


效果如下： **Result:**

* Item 1 unordered list `* + SPACE`
* Item 2
    - Item 2a unordered list `TAB + * + SPACE`
    - Item 2b

- Dashes work just as well
- And if you have sub points, put two spaces before the dash or star:
  - Like this
  - And this

### 有序列表 Ordered

Markdown 语法：**Example:**

```
1. Item 1 ordered list `Number + . + SPACE`
2. Item 2 
3. Item 3
    1. Item 3a ordered list `TAB + Number + . + SPACE`
    2. Item 3b
```

效果如下：

1. Item 1 ordered list `Number + . + SPACE`
2. Item 2 
3. Item 3
    1. Item 3a ordered list `TAB + Number + . + SPACE`
    2. Item 3b

### 任务列表 Task lists

Markdown 语法： **Example:**

```
- [ ] 任务一 未做任务 `- + 空格 + [ ]`
- [x] 任务二 已做任务 `- + 空格 + [x]`
- [ ] task one not finish `- + SPACE + [ ]`
- [x] task two finished `- + SPACE + [x]`
```

效果如下：**Result:**

- [ ] 任务一 未做任务 `- + 空格 + [ ]`
- [x] 任务二 已做任务 `- + 空格 + [x]`
- [ ] task one not finish `- + SPACE + [ ]`
- [x] task two finished `- + SPACE + [x]`
 
 
## 图片 Images

Markdown 语法： **Example:**
格式: Format: ![Alt Text](url)
```
![GitHub set up](http://zh.mweb.im/asset/img/set-up-git.gif)

![Image of Yaktocat](https://octodex.github.com/images/yaktocat.png)
```

效果如下：**Result:**


![GitHub set up](https://help.github.com/assets/images/site/set-up-git.gif)
![Image of Yaktocat](https://octodex.github.com/images/yaktocat.png)


## 链接 Links

Markdown 语法： **Example:**

```
email <example@example.com>
[GitHub](http://github.com)
自动生成连接  <http://www.github.com/>

email <example@example.com>
[GitHub](http://github.com)
autolink  <http://www.github.com/>
```

效果如下： **Result:**

Email 连接： <example@example.com>

[连接标题Github网站](http://github.com)

自动生成连接像： <http://www.github.com/> 这样

An email <example@example.com> link.

[GitHub](http://github.com)

Automatic linking for URLs
Any URL (like <http://www.github.com/>) will be automatically converted into a clickable link.

## 区块引用 Blockquotes

Markdown 语法： **Example:**

```
某某说:
> 第一行引用
> 第二行费用文字
As Kanye West said:
> We're living the future so
> the present is our past.
```

效果如下：

某某说:
> 第一行引用
> 
> 第二行费用文字

As Kanye West said:
> We're living the future so
> 
> the present is our past.

## 行内代码 Inline code

Markdown 语法： **Example:**

```
像这样即可：`<addr>` `code`
I think you should use an `<addr>` `code` element here instead.
```

效果如下： 

像这样即可：`<addr>` `code`

I think you should use an `<addr>` `code` element here instead.

## 多行或者一段代码 Multi-line code

Markdown 语法： **Example:**

    ```js
    function fancyAlert(arg) {
        if(arg) {
        $.facebox({div:'#foo'})
        }
    
    }
    ```

效果如下： **Result:**

```js
function fancyAlert(arg) {
    if(arg) {
    $.facebox({div:'#foo'})
    }

}
```

## 顺序图或流程图 Sequence and Flow chart github不支持

Markdown 语法： **Example:**

    ```sequence
    张三->李四: 嘿，小四儿, 写博客了没?
    Note right of 李四: 李四愣了一下，说：
    李四-->张三: 忙得吐血，哪有时间写。
    ```

    ```flow
    st=>start: 开始
    e=>end: 结束
    op=>operation: 我的操作
    cond=>condition: 确认？

    st->op->cond
    cond(yes)->e
    cond(no)->op
    ```
    ```sequence
    Andrew->China: Says Hello
    Note right of China: China thinks about it
    China-->Andrew: How are you?
    Andrew->>China: I am good thanks!
    ```

    ```flow
    st=>start: Start:>http://www.google.com[blank]
    e=>end:>http://www.google.com
    op1=>operation: My Operation
    sub1=>subroutine: My Subroutine
    cond=>condition: Yes
    or No?:>http://www.google.com
    io=>inputoutput: catch something...

    st->op1->cond
    cond(yes)->io->e
    cond(no)->sub1(right)->op1
    ```

**Result:**

```sequence
张三->李四: 嘿，小四儿, 写博客了没?
Note right of 李四: 李四愣了一下，说：
李四-->张三: 忙得吐血，哪有时间写。
```

```flow
st=>start: 开始
e=>end: 结束
op=>operation: 我的操作
cond=>condition: 确认？

st->op->cond
cond(yes)->e
cond(no)->op
```

```sequence
Andrew->China: Says Hello
Note right of China: China thinks about it
China-->Andrew: How are you?
Andrew->>China: I am good thanks!
```

```flow
st=>start: Start:>http://www.google.com[blank]
e=>end:>http://www.google.com
op1=>operation: My Operation
sub1=>subroutine: My Subroutine
cond=>condition: Yes
or No?:>http://www.google.com
io=>inputoutput: catch something...

st->op1->cond
cond(yes)->io->e
cond(no)->sub1(right)->op1
```


## 表格 Tables

Markdown 语法： **Example:**

```
First Header | Second Header
------------ | -------------
Content from cell 1 | Content from cell 2
Content in the first column | Content in the second column
```

效果如下： **Result:**

First Header | Second Header
------------ | -------------
Content from cell 1 | Content from cell 2
Content in the first column | Content in the second column

## 删除线 Strikethrough

Markdown 语法： **Example:**

加删除线像这样用： ~~删除这些~~
(like ~~this~~)

效果如下： **Result:**

加删除线像这样用： ~~删除这些~~

Any word wrapped with two tildes (like ~~this~~) will appear crossed out.


## 分隔线 Horizontal Rules
 
以下三种方式都可以生成分隔线：
```
***

*****

- - -
```

效果如下： **Result:**

***

*****

- - -

## MathJax LaTex github不支持

Use double US dollars sign pair for Block level Math formula, and one US dollar sign pair for Inline Level.

Markdown 语法：

```
块级公式： Block level
$$  x = \dfrac{-b \pm \sqrt{b^2 - 4ac}}{2a} $$

\\[ \frac{1}{\Bigl(\sqrt{\phi \sqrt{5}}-\phi\Bigr) e^{\frac25 \pi}} =
1+\frac{e^{-2\pi}} {1+\frac{e^{-4\pi}} {1+\frac{e^{-6\pi}}
{1+\frac{e^{-8\pi}} {1+\ldots} } } } \\]

行内公式： $\Gamma(n) = (n-1)!\quad\forall n\in\mathbb N$

For example this is a Block level $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}$$ formula, and this is an inline Level $x = {-b \pm \sqrt{b^2-4ac} \over 2a}$ formula.

\\[ \frac{1}{\Bigl(\sqrt{\phi \sqrt{5}}-\phi\Bigr) e^{\frac25 \pi}} =
1+\frac{e^{-2\pi}} {1+\frac{e^{-4\pi}} {1+\frac{e^{-6\pi}}
{1+\frac{e^{-8\pi}} {1+\ldots} } } } \\]
```

**Result:** 

块级公式：
$$  x = \dfrac{-b \pm \sqrt{b^2 - 4ac}}{2a} $$

\\[ \frac{1}{\Bigl(\sqrt{\phi \sqrt{5}}-\phi\Bigr) e^{\frac25 \pi}} =
1+\frac{e^{-2\pi}} {1+\frac{e^{-4\pi}} {1+\frac{e^{-6\pi}}
{1+\frac{e^{-8\pi}} {1+\ldots} } } } \\]

行内公式： $\Gamma(n) = (n-1)!\quad\forall n\in\mathbb N$

For example this is a Block level $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}$$ formula, and this is an inline Level $x = {-b \pm \sqrt{b^2-4ac} \over 2a}$ formula.

\\[ \frac{1}{\Bigl(\sqrt{\phi \sqrt{5}}-\phi\Bigr) e^{\frac25 \pi}} =
1+\frac{e^{-2\pi}} {1+\frac{e^{-4\pi}} {1+\frac{e^{-6\pi}}
{1+\frac{e^{-8\pi}} {1+\ldots} } } } \\]

## 脚注 Footnote github不支持

Markdown 语法：

```
这是一个脚注：[^sample_footnote]
This is a footnote:[^sample_footnote]
```

效果如下：

这是一个脚注：[^sample_footnote]

[^sample_footnote]: 这里是脚注信息


## 注释和阅读更多 Comment And Read More..

<!-- comment -->

<!-- more -->

**注** 阅读更多的功能只用在生成网站或博客时，插入时注意要后空一行。



--------------------------------------------------------------------------------

## 二. 列表

方法：无序列表在文字前面加上 - ；有序列表，在文字前面加上 1\. 2\. 3\. 即可

### 实例：

#### 无序列表：

- 列表1
  - hello world
- 列表2
- 列表3
- 1
- 2
- 3

#### 有序列表

1. 
2.
3.

--------------------------------------------------------------------------------

## 三、引用

说明：文稿中引用一段别处的句子，文字前加上 > 并与文字保留一个字符的空格

#### 实例：

> 一盏灯， 一片昏黄； 一简书， 一杯淡茶。 守着那一份淡定， 品读属于自己的寂寞。 保持淡定， 才能欣赏到最美丽的风景！ 保持淡定， 人生从此不再寂寞。

> > 一寸山河一寸血，十万青年十万军 ......蒋介石；

--------------------------------------------------------------------------------

## 四、粗体与斜体

说明：符号与文本间无需空格

### 实例：

_斜体_ _world!_
**粗体** **hello**
~~我已无效~~

--------------------------------------------------------------------------------

## 五、插入超链接与图片

说明：插入链接： [显示文本](链接地址)；插入图片： ![ ](图片链接地址).

#### 实例：

插入超链接 [直播吧](http://www.zhibo8.com)
插入图片![有道云笔记logo](http://note.youdao.com/favicon.ico)
![爱情](http://i.imgur.com/zjwDS9u.jpg)

--------------------------------------------------------------------------------

### 五、分割线

说明：需要另起一行，连续输入三个星号 _*_

#### 实例：

--------------------------------------------------------------------------------

### 六、表格

#### 实例：

Tables        |      Are      |  Cool
------------- | :-----------: | ----:
col 3 is      | right-aligned | $1600
col 2 is      |   centered    |   $12
zebra stripes |   are neat    |    $1

### 七、代码

说明：用两个 ` 把中间的代码包裹起来 ,选择全部代码 table键保持原格

#### 实例：

```
`function Person () {
    }
Person.prototype = {
    constructor: Person,
    name: "ShiJianwen",
    age: 19,
    job: "Frontend Engineer"
};`
```

### markdown 不支持，有道云笔记支持

### 八、待办与清单

说明：待办的事项文本或者清单文本前加上- [ ]、- [x]

#### 实例：

- [x] 洗发水
- [ ] 水果

--------------------------------------------------------------------------------

### 九、流程图

说明：TOP BOTTOM RIGHT LEFT

#### 实例

```
graph TB
a-->b
```

```
graph TB
    A{开始}-->B(输入打印份数)
    B --> C[打印机是否正常]
    C -->|是|D[装订]
    C -->|否|E[修复错误]
```

```
graph LR
a-->b
```

## 十、甘特图

说明：待办的事项文本或者清单文本前加上- [ ]、- [x]

### 实例

```
gantt
    dateFormat YYYY-MM-DD
    title 计划进度表

    section 问卷调查阶段
    项目确认:done,des1,2015-06-01,2015-06-06
    问卷设计:done,des2,2015-06-04, 4d
    问卷确定:done,des3,after des2,3d
    报告提交:active，des4，2015-06-26，5d
```

# 欢迎使用 Cmd Markdown 编辑阅读器

--------------------------------------------------------------------------------

我们理解您需要更便捷更高效的工具记录思想，整理笔记、知识，并将其中承载的价值传播给他人，**Cmd Markdown** 是我们给出的答案 ---- 我们为记录思想和分享知识提供更专业的工具。 您可以使用 Cmd Markdown：

> - 整理知识，学习笔记
> - 发布日记，杂文，所见所想
> - 撰写发布技术文稿（代码支持）
> - 撰写发布学术论文（LaTeX 公式支持）

![cmd-markdown-logo](https://www.zybuluo.com/static/img/logo.png)

除了您现在看到的这个 Cmd Markdown 在线版本，您还可以前往以下网址下载：

## [Windows/Mac/Linux 全平台客户端](https://www.zybuluo.com/cmd/)

> 请保留此份 Cmd Markdown 的欢迎稿兼使用说明，如需撰写新稿件，点击顶部工具栏右侧的 __ **新文稿** 或者使用快捷键 `Ctrl+Alt+N`。

--------------------------------------------------------------------------------

## 什么是 Markdown

Markdown 是一种方便记忆、书写的纯文本标记语言，用户可以使用这些标记符号以最小的输入代价生成极富表现力的文档：譬如您正在阅读的这份文档。它使用简单的符号标记不同的标题，分割不同的段落，**粗体** 或者 _斜体_ 某些文字，更棒的是，它还可以

### 1\. 制作一份待办事宜 [Todo 列表](https://www.zybuluo.com/mdeditor?url=https://www.zybuluo.com/static/editor/md-help.markdown#13-待办事宜-todo-列表)

- [ ] 支持以 PDF 格式导出文稿
- [ ] 改进 Cmd 渲染算法，使用局部渲染技术提高渲染效率
- [x] 新增 Todo 列表功能
- [x] 修复 LaTex 公式渲染问题
- [x] 新增 LaTex 公式编号功能

### 2\. 书写一个质能守恒公式[^LaTeX]

$$E=mc^2$$

### 3\. 高亮一段代码[^code]

```python
@requires_authorization
class SomeClass:
    pass

if __name__ == '__main__':
    # A comment
    print 'hello world'
```

### 4\. 高效绘制 [流程图](https://www.zybuluo.com/mdeditor?url=https://www.zybuluo.com/static/editor/md-help.markdown#7-流程图)

```flow
st=>start: Start
op=>operation: Your Operation
cond=>condition: Yes or No?
e=>end

st->op->cond
cond(yes)->e
cond(no)->op
```

### 5\. 高效绘制 [序列图](https://www.zybuluo.com/mdeditor?url=https://www.zybuluo.com/static/editor/md-help.markdown#8-序列图)

```seq
Alice->Bob: Hello Bob, how are you?
Note right of Bob: Bob thinks
Bob-->Alice: I am good thanks!
```

### 6\. 绘制表格

项目  |     价格 | 数量
--- | -----: | :-:
计算机 | \$1600 |  5
手机  |   \$12 | 12
管线  |    \$1 | 234

### 7\. 更详细语法说明

想要查看更详细的语法说明，可以参考我们准备的 [Cmd Markdown 简明语法手册][1]，进阶用户可以参考 [Cmd Markdown 高阶语法手册][2] 了解更多高级功能。

总而言之，不同于其它 _所见即所得_ 的编辑器：你只需使用键盘专注于书写文本内容，就可以生成印刷级的排版格式，省却在键盘和工具栏之间来回切换，调整内容和格式的麻烦。**Markdown 在流畅的书写和印刷级的阅读体验之间找到了平衡。** 目前它已经成为世界上最大的技术分享网站 GitHub 和 技术问答网站 StackOverFlow 的御用书写格式。

--------------------------------------------------------------------------------

## 什么是 Cmd Markdown

您可以使用很多工具书写 Markdown，但是 Cmd Markdown 是这个星球上我们已知的、最好的 Markdown 工具----没有之一 ：）因为深信文字的力量，所以我们和你一样，对流畅书写，分享思想和知识，以及阅读体验有极致的追求，我们把对于这些诉求的回应整合在 Cmd Markdown，并且一次，两次，三次，乃至无数次地提升这个工具的体验，最终将它演化成一个 **编辑/发布/阅读** Markdown 的在线平台----您可以在任何地方，任何系统/设备上管理这里的文字。

### 1\. 实时同步预览

我们将 Cmd Markdown 的主界面一分为二，左边为**编辑区**，右边为**预览区**，在编辑区的操作会实时地渲染到预览区方便查看最终的版面效果，并且如果你在其中一个区拖动滚动条，我们有一个巧妙的算法把另一个区的滚动条同步到等价的位置，超酷！

### 2\. 编辑工具栏

也许您还是一个 Markdown 语法的新手，在您完全熟悉它之前，我们在 **编辑区** 的顶部放置了一个如下图所示的工具栏，您可以使用鼠标在工具栏上调整格式，不过我们仍旧鼓励你使用键盘标记格式，提高书写的流畅度。

![tool-editor](https://www.zybuluo.com/static/img/toolbar-editor.png)

### 3\. 编辑模式

完全心无旁骛的方式编辑文字：点击 **编辑工具栏** 最右测的拉伸按钮或者按下 `Ctrl + M`，将 Cmd Markdown 切换到独立的编辑模式，这是一个极度简洁的写作环境，所有可能会引起分心的元素都已经被挪除，超清爽！

### 4\. 实时的云端文稿

为了保障数据安全，Cmd Markdown 会将您每一次击键的内容保存至云端，同时在 **编辑工具栏** 的最右侧提示 `已保存` 的字样。无需担心浏览器崩溃，机器掉电或者地震，海啸----在编辑的过程中随时关闭浏览器或者机器，下一次回到 Cmd Markdown 的时候继续写作。

### 5\. 离线模式

在网络环境不稳定的情况下记录文字一样很安全！在您写作的时候，如果电脑突然失去网络连接，Cmd Markdown 会智能切换至离线模式，将您后续键入的文字保存在本地，直到网络恢复再将他们传送至云端，即使在网络恢复前关闭浏览器或者电脑，一样没有问题，等到下次开启 Cmd Markdown 的时候，她会提醒您将离线保存的文字传送至云端。简而言之，我们尽最大的努力保障您文字的安全。

### 6\. 管理工具栏

为了便于管理您的文稿，在 **预览区** 的顶部放置了如下所示的 **管理工具栏**：

![tool-manager](https://www.zybuluo.com/static/img/toolbar-manager.jpg)

通过管理工具栏可以：

**发布：将当前的文稿生成固定链接，在网络上发布，分享** 新建：开始撰写一篇新的文稿 **删除：删除当前的文稿** 导出：将当前的文稿转化为 Markdown 文本或者 Html 格式，并导出到本地 **列表：所有新增和过往的文稿都可以在这里查看、操作** 模式：切换 普通/Vim/Emacs 编辑模式

### 7\. 阅读工具栏

![tool-manager](https://www.zybuluo.com/static/img/toolbar-reader.jpg)

通过 **预览区** 右上角的 **阅读工具栏**，可以查看当前文稿的目录并增强阅读体验。

工具栏上的五个图标依次为：

**目录：快速导航当前文稿的目录结构以跳转到感兴趣的段落** 视图：互换左边编辑区和右边预览区的位置 **主题：内置了黑白两种模式的主题，试试 **黑色主题**，超炫！** 阅读：心无旁骛的阅读模式提供超一流的阅读体验 __ 全屏：简洁，简洁，再简洁，一个完全沉浸式的写作和阅读环境

### 8\. 阅读模式

在 **阅读工具栏** 点击 __ 或者按下 `Ctrl+Alt+M` 随即进入独立的阅读模式界面，我们在版面渲染上的每一个细节：字体，字号，行间距，前背景色都倾注了大量的时间，努力提升阅读的体验和品质。

### 9\. 标签、分类和搜索

在编辑区任意行首位置输入以下格式的文字可以标签当前文档：

标签： 未分类

标签以后的文稿在【文件列表】（Ctrl+Alt+F）里会按照标签分类，用户可以同时使用键盘或者鼠标浏览查看，或者在【文件列表】的搜索文本框内搜索标题关键字过滤文稿，如下图所示：

![file-list](https://www.zybuluo.com/static/img/file-list.png)

### 10\. 文稿发布和分享

在您使用 Cmd Markdown 记录，创作，整理，阅读文稿的同时，我们不仅希望它是一个有力的工具，更希望您的思想和知识通过这个平台，连同优质的阅读体验，将他们分享给有相同志趣的人，进而鼓励更多的人来到这里记录分享他们的思想和知识，尝试点击 __ (Ctrl+Alt+P) 发布这份文档给好友吧！

--------------------------------------------------------------------------------

再一次感谢您花费时间阅读这份欢迎稿，点击 __ (Ctrl+Alt+N) 开始撰写新的文稿吧！祝您在这里记录、阅读、分享愉快！

作者 [@ghosert][3]<br>
2015 年 06月 15日

[^LaTeX]: 支持 **LaTeX** 编辑显示支持，例如：$\sum_{i=1}^n a_i=0$， 访问 [MathJax][4] 参考更多使用方法。

[^code]: 代码高亮功能支持包括 Java, Python, JavaScript 在内的，**四十一**种主流编程语言。

# Sample Markdown Cheat Sheet

This is a sample markdown file to help you write Markdown quickly :)

If you use the fabulous [Sublime Text 2/3 editor][st] along with the [Markdown Preview plugin][markdownpreview], open your ST2 Palette with `CMD+⇧+P` then choose `Markdown Preview in browser` to see the result in your browser.

## Text basics

_italic_ **bold** 

`important`

This is a paragraph with a footnote (builtin parser only). [^note-id]

Insert `[ TOC ]` without spaces to generate a table of contents (builtin parsers only).

## Indentation

> Here is some indented text

> > even more indented

## Titles

# Big title (h1)

## Middle title (h2)

### Smaller title (h3)

#### and so on (h4)

##### and so on (h5)

###### and so on (h5)

## Example lists (1)

- bullets can be `-`, `+`, or `*`
- bullet list 2

  - sub item 1
  - sub item 2

    with indented text inside

- bullet list 3

- bullet list 4

- bullet list 5

## Links

- [example inline link](http://lmgtfy.com/)
- [another one with a title](http://lmgtfy.com/ "Hello, world").
- [reference 1][ref1] or [reference 2 with title][ref2].References are usually placed at the bottom of the document

## Images

A sample image :

![revolunet logo][revolunet-logo]

As links, images can also use references instead of inline links :

![revolunet logo][revolunet-logo]

## Code

Backticks can be used to `highlight` some words.

Also, any indented block is considered a code block. If `enable_highlight` is `true`, syntax highlighting will be included (for the builtin parser - the github parser does this automatically).

```
<script>
    document.location = 'http://lmgtfy.com/?q=markdown+cheat+sheet';
</script>
```

### Tables

The `tables` extension of the _Python-Markdown_ parser is activated by default, but is currently **not** available in _Markdown2_.

The syntax was adopted from the [php markdown project](http://michelf.ca/projects/php-markdown/extra/#table), and is also used in github flavoured markdown.

Year | Temperature (low) | Temperature (high)
---- | ----------------- | ------------------
1900 | -10               | 25
1910 | -15               | 30
1920 | -10               | 32

### Wiki Tables

If you are using _Markdown2_ with the `wiki-tables` extra activated you should see a table below:

|| _Year_ || _Temperature (low)_ || _Temperature (high)_ ||<br>
|| 1900 || -10 || 25 ||<br>
|| 1910 || -15 || 30 ||<br>
|| 1920 || -10 || 32 ||

[1]: https://www.zybuluo.com/mdeditor?url=https://www.zybuluo.com/static/editor/md-help.markdown
[2]: https://www.zybuluo.com/mdeditor?url=https://www.zybuluo.com/static/editor/md-help.markdown#cmd-markdown-高阶语法手册
[3]: http://weibo.com/ghosert
[4]: http://meta.math.stackexchange.com/questions/5020/mathjax-basic-tutorial-and-quick-reference
[emoji]: http://www.emoji-cheat-sheet.com/
[gfm]: https://help.github.com/articles/github-flavored-markdown/
[markdownpreview]: https://github.com/revolunet/sublimetext-markdown-preview
[markdownref]: http://daringfireball.net/projects/markdown/basics
[ref1]: http://revolunet.com
[ref2]: http://revolunet.com "rich web apps"
[revolunet]: http://revolunet.com
[revolunet-logo]: http://www.revolunet.com/static/parisjs8/img/logo-revolunet-carre.jpg "revolunet logo"
[st]: http://sublimetext.com

## 软件列表

- MWeb Lite
- MacDow：MWeb 是专业的 Markdown 写作、记笔记、静态博客生成软件。然后这里**重点说明**一下：MWeb 有**两个模式**，外部模式和文档库模式。外部模式中把本地硬盘或 Dropbox 等网盘的文件夹引入，就可以使用 MWeb 的拖拽、粘贴插入图片、图床等特色功能。文档库模式设计为用于记笔记和静态博客生成。对于有**同步和协作需求**的朋友，请使用外部模式！使用视图菜单或者快捷键 `CMD + E` 可以打开外部模式，`CMD + L` 可以打开文档库。左边的第一第二栏是使用**右键**和底部的几个按钮操作，另外就是右上角有三个按钮了（外部模式是两个），快捷键分别是：`CMD + 7/8/9`。

### writing on MWeb MWeb 写作使用说明

如果不想打这么多空格，只要回车就为换行，请勾选：`Preferences` - `Themes` - `Translate newlines to <br> tags`
如果是 MWeb 的文档库中的文档，还可以用拖放图片、`CMD + V` 粘贴、`CMD + Option + I` 导入这三种方式来增加图片。
MWeb 引入的特别的语法来设置图片宽度，方法是在图片描述后加 `-w + 图片宽度` 即可，比如说要设置上面的图片的宽度为 140
如果是 MWeb 的文档库中的文档，拖放或`CMD + Option + I` 导入非图片时，会生成连接。
`Preferences` - `Themes` - `Enable sequence & flow chart`
Actions->Insert Read More Comment *或者* `Command + .`
**注** 阅读更多的功能只用在生成网站或博客时，插入时注意要后空一行。

#### TOC Table of Contents 内容列表

Markdown 语法： **Example:**

```
[TOC]
```

**Result:**

[TOC]

#### 快捷键 **Shortcuts:**

* `CMD + 4` 或 `CMD + R` 预览才可以看效果
* `Control + Shift + I` 可插入图片
* `Control + Shift + L` 可插入链接
* `Option + U` 无序列表
* `CMD + Shift + B` 可插入区块引用区块引用
* `CMD + K` 可插入行内代码
* `CMD + Shift + K` 多行或者一段代码
* `CMD + U`、`CMD + I`、`CMD + B` 强调
* 快捷键：`CMD + 1` 是在仅编辑器模式和三栏模式中切换。
* 快捷键：`CMD + 2` 是在二栏模式和仅编辑器模式中切换。
* 快捷键：`CMD + 3` 是在三栏模式和仅编辑器模式中切换。
* 快捷键：`CMD + 4` 是在编辑器/预览模式和三栏模式中切换。
* 快捷键：`CMD + R` 是在编辑器和预览模式中切换。


###  编辑器插件

#### sublime插件


- Markdown Preview：预览
- MarkdownEditing：代码提示
- Markdown Extended：语法高亮
- MarkdownLivePreview `alt + m`
- Markdown​TOC

## 参考

- [mastering-markdown](https://guides.github.com/features/mastering-markdown/)
- <http://bramp.github.io/js-sequence-diagrams/>, <http://adrai.github.io/flowchart.js/>
