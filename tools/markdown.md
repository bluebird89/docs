# [Markdown guide](https://www.markdownguide.org/)

Markdown is a way to style text on the web. You control the display of the document; formatting words as bold or italic, adding images, and creating lists are just a few of the things we can do with Markdown. Mostly, Markdown is just regular text with a few non-alphabetic characters thrown in, like `#` or `*`.

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

## 标题 Headers

**Example:**

```markdown
# 第一级标题 `<h1>`
## 第二级标题 `<h2>`
###### 第六级标题 `<h6>`

# This is an `<h1>` tag
## This is an `<h2>` tag
###### This is an `<h6>` tag

这是一个一级标题
============================
这是一个二级标题
--------------------------------------------------
### 这是一个三级标题
```

**Result:**

# 第一级标题  `</h1>`

## 第二级标题 `<h2>`

###### 第六级标题 `<h6>`

# This is an `<h1>` tag

## This is an `<h2>` tag

###### This is an `<h6>` tag

这是一个一级标题
============================

这是一个二级标题
--------------------------------------------------

### 这是一个三级标题

---

## 强调 Emphasis

* Bold:command/control + b
  - 使用双星号asterisks
* Italic:command/control + i
  - 用单星号标注单词中间的斜体来表示
* Bold and italic
  - 用三星号将单词或短语的中间部分加粗并以斜体显示
* Strikethrough
* [font-awesome](http://fortawesome.github.io/Font-Awesome/3.2.1/icons/)

**Example:**

```markdown
*这些文字会生成`<em>`*
_这些文字会生成`<u>`_

**这些文字会生成`<strong>`**
__这些文字会生成`<strong>`__

*This text will be italic*
_This will also be italic_

**This text will be bold**
__This will also be bold__

*You **can** combine them*
**This text is _extremely_ important**

~~This was mistaken text~~

<!-- 显示icon -->
<i class="icon-file"></i> **新文稿**
```

**Result:**

*这些文字会生成`<em>`*
_这些文字会生成`<u>`_

**这些文字会生成`<strong>`**
__这些文字会生成`<strong>`__

*This text will be italic*
_This will also be italic_

**This text will be bold**
__This will also be bold__

*You **can** combine them*
**This text is _extremely_ important**

~~This was mistaken text~~

<i class="icon-file"></i> **新文稿**

---

## 段落 Paragraphs

* 用一个或多个空白行对段落和标题进行分隔
* 创建段落，使用空白行将一行或多行文本进行分隔
* 不要用空格（spaces）或制表符（ tabs）缩进段落

## 换行 Newlines

* 结尾空格（trailing whitespace）：End a line with two or more spaces + enter 在一行的末尾添加两个或多个空格，然后按回车键（return），即可创建一个换行（line break） (<br>)
* add new line between two section
* first line add <br> </br>

---

## 分隔线 Horizontal Rules

三种方式：

```markdown
***

*****

---

_________________
```

**Result:**

***

*****

---

_________________

---

## 列表 Lists

### 无序列表 Unordered

无序列表在文字前面加上 -

**Example:**

```markdown
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

**Result:**

* Item 1 unordered list `* + SPACE`

* Item 2

  - Item 2a unordered list `TAB + * + SPACE`
  - Item 2b

- Dashes work just as well

- And if you have sub points, put two spaces before the dash or star:

  - Like this
  - And this

---

### 有序列表 Ordered

有序列表，在文字前面加上 1\. 2\. 3\.

**Example:**

```markdown
1. Item 1 ordered list `Number + . + SPACE`
2. Item 2
3. Item 3
    1. Item 3a ordered list `TAB + Number + . + SPACE`
    2. Item 3b
```

**Result:**

1. Item 1 ordered list `Number + . + SPACE`
2. Item 2
3. Item 3
   1. Item 3a ordered list `TAB + Number + . + SPACE`
   2. Item 3b

---

### Definition Lists

First Term
: This is the definition of the first term.

Second Term
: This is one definition of the second term.
: This is another definition of the second term.

### 任务列表 Task lists

**Example:**

```markdown
- [ ] 任务一 未做任务 `- + 空格 + [ ]`
- [x] 任务二 已做任务 `- + 空格 + [x]`
- [ ] task one not finish `- + SPACE + [ ]`
- [x] task two finished `- + SPACE + [x]`
```

效果 **Result:**

- [ ] 任务一 未做任务 `- + 空格 + [ ]`
- [x] 任务二 已做任务 `- + 空格 + [x]`
- [ ] task one not finish `- + SPACE + [ ]`
- [x] task two finished `- + SPACE + [x]`

---

## 图片 Images

**Example:**

格式: Format: `![Alt Text](url)`

```markdown
![GitHub set up](http://zh.mweb.im/asset/img/set-up-git.gif)

插入图片![Image of Yaktocat](https://octodex.github.com/images/yaktocat.png)
```

效果如下：**Result:**

* ![GitHub set up](https://help.github.com/assets/images/site/set-up-git.gif)
* 插入图片![Image of Yaktocat](https://octodex.github.com/images/yaktocat.png)

---

## 链接 Links

**Example:**

```markdown
An email <example@example.com> link.
自动生成连接  <http://www.github.com/>

[GitHub](http://github.com)
`http://www.example.com`
```

**Result:**

* 自动生成连接像： <http://www.github.com/>
* An email <example@example.com> link.
* Any URL (like <http://www.github.com/>) will be automatically converted into a clickable link.
* [连接标题Github网站](http://github.com)
* [another one with a title](http://lmgtfy.com/ "Hello, world")
* 插入超链接 [直播吧](http://www.zhibo8.com)
* [本地链接](../Tools/Document/Document.md#使用)
* `http://www.example.com`

---

## Section links

You can link directly to a section in a rendered file by hovering over the section heading to expose the link

[markdown][1]
[hobbit-hole](https://en.wikipedia.org/wiki/Hobbit#Lifestyle "Hobbit lifestyles")

^1:<<https://en.wikipedia.org/wiki/Hobbit#Lifestyle> "Hobbit lifestyles">

---

## Relative links

[Contribution guidelines for this project](../TODO.md)

---

## 区块引用 Blockquotes/Quoting text

**Example:**

```markdown
某某说:
> 第一行引用
> 第二行费用文字
As Kanye West said:
> We're living the future so
> the present is our past.

> * 整理知识，学习笔记
> * 发布日记，杂文，所见所想
> * 撰写发布技术文稿（代码支持）
> * 撰写发布学术论文（LaTeX 公式支持）

 <!-- 嵌套块引用（Nested Blockquotes） -->
> > 一寸山河一寸血，十万青年十万军 ......蒋介石；
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
>
> * 整理知识，学习笔记
> * 发布日记，杂文，所见所想
> * 撰写发布技术文稿（代码支持）
> * 撰写发布学术论文（LaTeX 公式支持）
> 一盏灯， 一片昏黄； 一简书， 一杯淡茶。 守着那一份淡定， 品读属于自己的寂寞。 保持淡定， 才能欣赏到最美丽的风景！ 保持淡定， 人生从此不再寂寞。
>
> > 一寸山河一寸血，十万青年十万军 ......蒋介石；

---

## 行内代码 Inline code/Quoting code

**Example:**

```markdown
像这样即可：`<addr>` `code`
I think you should use an `<addr>` `code` element here instead.
```

效果如下：

像这样即可：`<addr>` `code`

I think you should use an `<addr>` `code` element here instead.

---

## 多行或者一段代码 Multi-line code

**Example:**

```markdown
function fancyAlert(arg) {
    if(arg) {
        $.facebox({div:'#foo'})
    }
}
```

**Result:**

```js
function fancyAlert(arg) {
    if(arg) {
        $.facebox({div:'#foo'})
    }
}
```

---

## 表格 Tables

* 默认靠左，居中两边加冒号

**Example:**

```markdown
| Tables        |      Are      |  Cool |
| ------------- | :-----------: | ----: |
| col 3 is      | right-aligned | $1600 |
| col 2 is      |   centered    |   $12 |
| zebra stripes |   are neat    |    $1 |

| 项目   |   价格 | 数量  |
| ------ | -----: | :---: |
| 计算机 | \$1600 |   5   |
| 手机   |   \$12 |  12   |
| 管线   |    \$1 |  234  |
```

**Result:**

| Tables        |      Are      |  Cool |
| ------------- | :-----------: | ----: |
| col 3 is      | right-aligned | $1600 |
| col 2 is      |   centered    |   $12 |
| zebra stripes |   are neat    |    $1 |

| 项目   |   价格 | 数量  |
| ------ | -----: | :---: |
| 计算机 | \$1600 |   5   |
| 手机   |   \$12 |  12   |
| 管线   |    \$1 |  234  |

---

## Html 标签

在 Markdown 语法中嵌套 Html 标签

<table>
    <tr>
        <th rowspan="2">值班人员</th>
        <th>星期一</th>
        <th>星期二</th>
        <th>星期三</th>
    </tr>
    <tr>
        <td>李强</td>
        <td>张明</td>
        <td>王平</td>
    </tr>
</table>

---

## 标签

标签： 数学 英语 Markdown
Tags： 数学 英语 Markdown

## MathJax LaTex github不支持

Use double US dollars sign pair for Block level Math formula
one US dollar sign pair for Inline Level.

语法：

```markdown
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

---

## 脚注｜角标 Footnote github不支持

语法：

```markdown
这是一个脚注：[^sample_footnote]
This is a footnote:[^sample_footnote]

Here's a simple footnote,[^1] and here's a longer one.[^bignote]

[^1]: This is the first footnote.

[^bignote]: Here's one with multiple paragraphs and code.

    Indent paragraphs to include them in the footnote.

    `{ my code }`

    Add as many paragraphs as you like.
```

效果：

这是一个脚注：[^sample_footnote]

[^sample_footnote]: 这里是脚注信息

Here's a simple footnote,[^1] and here's a longer one.[^bignote]

[^1]: This is the first footnote.

[^bignote]: Here's one with multiple paragraphs and code.

    Indent paragraphs to include them in the footnote.

    `{ my code }`

    Add as many paragraphs as you like.

## 注释和阅读更多 Comment And Read More

<!-- comment -->

<!-- more -->

**注** 阅读更多的功能只用在生成网站或博客时，插入时注意要后空一行

---

#### TOC Table of Contents 内容列表

Insert `[ TOC ]` without spaces to generate a table of contents (builtin parsers only).

**Example:**

```markdown
[TOC]
```

**Result:**

[TOC]

--------------------------------------------------------------------------------

### [序列图|顺序图 Sequence chart](https://www.zybuluo.com/mdeditor?url=https://www.zybuluo.com/static/editor/md-help.markdown#8-序列图) github不支持

**Example:**

```markdown
Alice->Bob: Hello Bob, how are you?
Note right of Bob: Bob thinks
Bob-->Alice: I am good thanks!
```

```sequence
Andrew->China: Says Hello
Note right of China: China thinks about it
China-->Andrew: How are you?
Andrew->>China: I am good thanks!
```

更多语法参考：[序列图语法参考](http://bramp.github.io/js-sequence-diagrams/)

## [流程图 Flow chart](https://www.zybuluo.com/mdeditor?url=https://www.zybuluo.com/static/editor/md-help.markdown#7-流程图) github不支持

说明：TOP BOTTOM RIGHT LEFT

```flow
st=>start: Start
op=>operation: Your Operation
cond=>condition: Yes or No?
e=>end

st->op->cond
cond(yes)->e
cond(no)->op
```

```flow
graph TB
a-->b
```

```flow
graph TB
    A{开始}-->B(输入打印份数)
    B --> C[打印机是否正常]
    C -->|是|D[装订]
    C -->|否|E[修复错误]
```

```flow
graph LR
a-->b
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

更多语法参考：[流程图语法参考](http://adrai.github.io/flowchart.js/)

---

## 甘特图

```gantt
    dateFormat YYYY-MM-DD
    title 计划进度表

    section 问卷调查阶段
    项目确认:done,des1,2015-06-01,2015-06-06
    问卷设计:done,des2,2015-06-04, 4d
    问卷确定:done,des3,after des2,3d
    报告提交:active，des4，2015-06-26，5d
```

```gantt
    title 项目开发流程
    section 项目确定
        需求分析       :a1, 2016-06-22, 3d
        可行性报告     :after a1, 5d
        概念验证       : 5d
    section 项目实施
        概要设计      :2016-07-05  , 5d
        详细设计      :2016-07-08, 10d
        编码          :2016-07-15, 10d
        测试          :2016-07-22, 5d
    section 发布验收
        发布: 2d
        验收: 3d
```

更多语法参考：[甘特图语法参考](https://knsv.github.io/mermaid/#gant-diagrams)

## Mermaid 流程图

```graphLR
    A[Hard edge] -->|Link text| B(Round edge)
    B --> C{Decision}
    C -->|One| D[Result one]
    C -->|Two| E[Result two]
```

更多语法参考：[Mermaid 流程图语法参考](https://knsv.github.io/mermaid/#flowcharts-basic-syntax)

## Mermaid 序列图

```sequence
    Alice->John: Hello John, how are you?
    loop every minute
        John-->Alice: Great!
    end
```

[Mermaid 序列图语法参考](https://knsv.github.io/mermaid/#sequence-diagrams)

### Mentioning people and teams

```
@github/support What do you think about these updates?
```

### Referencing issues and pull requests

bring up a list of suggested issues and pull requests within the repository by typing #

### Paragraphs and line breaks

You can create a new paragraph by leaving a blank line between lines of text

### Using emoji

You can add emoji to your writing by typing :EMOJICODE:.

@octocat :+1: This PR looks great - it's ready to merge! :shipit:

Gone camping! :tent: Be back soon.

That is so funny! :joy:

### Ignoring Markdown formatting

You can tell GitHub to ignore (or escape) Markdown formatting by using \ before the Markdown character.

Let's rename *our-new-project* to \*our-old-project\*.

[^1]: https://www.zybuluo.com/mdeditor?url=https://www.zybuluo.com/static/editor/md-help.markdown
[^2]: https://www.zybuluo.com/mdeditor?url=https://www.zybuluo.com/static/editor/md-help.markdown#cmd-markdown-高阶语法手册
[^3]: http://weibo.com/ghosert
[^4]: http://meta.math.stackexchange.com/questions/5020/mathjax-basic-tutorial-and-quick-reference
[^emoji]: http://www.emoji-cheat-sheet.com/
[^gfm]: https://help.github.com/articles/github-flavored-markdown/
[^markdownpreview]: https://github.com/revolunet/sublimetext-markdown-preview
[^markdownref]: http://daringfireball.net/projects/markdown/basics
[^ref1]: http://revolunet.com
[^ref2]: http://revolunet.com "rich web apps"
[^revolunet]: http://revolunet.com
[^revolunet-logo]: http://www.revolunet.com/static/parisjs8/img/logo-revolunet-carre.jpg "revolunet logo"
[^st]: http://sublimetext.com

#### 快捷键 **Shortcuts:**

* `CMD + 4` 或 `CMD + R` 预览效果
* `Control + Shift + I` 插入图片
* `Control + Shift + L` 插入链接
* `Option + U` 无序列表
* `CMD + Shift + B` 可插入区块引用区块引用
* `CMD + K` 插入行内代码
* `CMD + Shift + K` 多行或者一段代码
* `CMD + U`、`CMD + I`、`CMD + B` 强调
* `CMD + 1` 在仅编辑器模式和三栏模式中切换
* `CMD + 2` 在二栏模式和仅编辑器模式中切换
* `CMD + 3` 在三栏模式和仅编辑器模式中切换
* `CMD + 4` 在编辑器/预览模式和三栏模式中切换
* `CMD + R` 在编辑器和预览模式中切换

## 编辑器

* [typora](https://www.typora.io/)
  - `sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BA300B7755AFCFAE` `wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -`
  - `sudo add-apt-repository 'deb https://typora.io/linux ./'`
  - `sudo apt-get install typora`
  - [PicGo](https://github.com/Molunerfinn/PicGo) 一款免费的图床管理应用，支持拖拽上传，剪切板上传等方式。可以用它快捷地将图片上传到图床并获得网络链接
* [marktext](https://github.com/marktext/marktext):📝A simple and elegant markdown editor, available for Linux, macOS and Windows. <https://marktext.app>
* [trilium](https://github.com/zadam/trilium):Build your personal knowledge base with Trilium Notes
* [Haroopad](http://pad.haroopress.com/user.html):a markdown enabled document processor for creating web-friendly documents
* [notable](https://github.com/notable/notable):The Markdown-based note-taking app that doesn't suck. <https://notable.app/>
* [Cmd Markdown](https://www.zybuluo.com/cmd/) 开启卓越写作之旅
* [Dillinger](https://dillinger.io/) 在线
* Mac
  - [Mou](http://25.io/mou/):Markdown editor for developers.
  - [Bear](https://bear.app/):Write beautifully on iPhone, iPad, and Mac
  - [Ulysses for Mac](https://ulysses.app/):The Ultimate Writing App for Mac, iPad and iPhone
  - [Twig](https://github.com/lukakerr/Pine):A modern, native macOS markdown editor <https://lukakerr.github.io/Pine>
  - [MacDown](https://github.com/MacDownApp/macdown):Open source Markdown editor for macOS. <https://macdown.uranusjr.com/>
  - [Quiver](http://happenapps.com/):a notebook built for programmers. It lets you easily mix text, code, Markdown and LaTeX within one note, edit code with an awesome code editor, live preview Markdown and LaTeX, and find any note instantly via the full-text search.收费
  - [幕布](https://mubu.com/):极简大纲笔记 | 一键生成思维导图
  - [MWeb](https://zh.mweb.im/):专业付费 Markdown 写作、记笔记、静态博客生成软件。
* Windows
  - MarkdownPad(需要浏览器渲染插件awesome)
  - MarkPad
* [GitNote](https://www.gitnoteapp.com)
* [MedleyText](https://medleytext.net/):reate stylish and meaningful programming notes, blogs with ease
* [Boostnote](https://github.com/BoostIO/Boostnote):A markdown editor for developers on Mac, Windows and Linux. <https://boostnote.io>
* 开源
  - [CherryTree](http://www.giuspen.com/cherrytree/):A hierarchical note taking application, featuring rich text and syntax highlighting, storing data in a single XML or SQLite file
* Apostrophe:An elegant, distraction-free markdown editor
* [Zettlr](https://github.com/Zettlr/Zettlr): A Markdown Editor for the 21st century. www.zettlr.com/
* [wechat-format](https://github.com/lyricat/wechat-format) 微信公众号排版编辑器，转换 Markdown 到微信特制的 HTML <https://lab.lyric.im/wxformat>
  - [](https://github.com/doocs/md) ✍ 一款高度简洁的微信 Markdown 编辑器：支持 Markdown 所有基础语法、色盘取色、一键复制并粘贴到公众号后台、多图上传、一键下载文档、自定义 CSS 样式、一键重置等特性 <https://doocs.github.io/md>
* [markdown-wasm](https://github.com/rsms/markdown-wasm) Markdown parser and HTML generator implemented in WebAssembly, based on md4c <https://rsms.me/markdown-wasm/>

## 工具

* [ikatyang/emoji-cheat-sheet](https://github.com/ikatyang/emoji-cheat-sheet/blob/master/README.md):A markdown version emoji cheat sheet
* [zhangjikai/online-markdown-reader](https://github.com/zhangjikai/online-markdown-reader):Markdown 在线阅读器 <http://markdown.zhangjikai.com/>
* [tamlok/vnote](https://github.com/tamlok/vnote):A Vim-inspired note-taking application that knows programmers and Markdown better. <https://tamlok.github.io/vnote>
* [nhnent/tui.editor](https://github.com/nhnent/tui.editor):🍞📝 Markdown WYSIWYG Editor. GFM Standard + Chart & UML Extensible. <http://ui.toast.com/tui-editor>
* [gsuitedevs/md2googleslides](https://github.com/gsuitedevs/md2googleslides):Generate Google Slides from markdown
* [pandao/editor.md](https://github.com/pandao/editor.md):The open source embeddable online markdown editor (component). <https://pandao.github.io/editor.md/>
* [gnab/remark](https://github.com/gnab/remark):A simple, in-browser, markdown-driven slideshow tool. <http://remarkjs.com>
* [knsv/mermaid](https://github.com/knsv/mermaid):Generation of diagram and flowchart from text in a similar manner as markdown <http://knsv.github.io/mermaid/>
* [aaronsw/html2text](https://github.com/aaronsw/html2text):Convert HTML to Markdown-formatted text. <http://www.aaronsw.com/2002/html2text/>
* [benweet/stackedit](https://github.com/benweet/stackedit):In-browser Markdown editor <https://stackedit.io/>
* [showdownjs/showdown](https://github.com/showdownjs/showdown):A bidirectional Markdown to HTML to Markdown converter written in Javascript <http://www.showdownjs.com/>
* [adam-p/markdown-here](https://github.com/adam-p/markdown-here):Google Chrome, Firefox, and Thunderbird extension that lets you write email in Markdown and render it before sending. <http://markdown-here.com>
* [benweet/stackedit](https://github.com/benweet/stackedit):In-browser Markdown editor <https://stackedit.io/>
* [markedjs/marked](https://github.com/markedjs/marked):A markdown parser and compiler. Built for speed. <https://marked.js.org/>
* [mdx-js/mdx](https://github.com/mdx-js/mdx):JSX in Markdown for ambitious projects <https://mdxjs.com>
* [evilstreak/markdown-js](https://github.com/evilstreak/markdown-js):A Markdown parser for javascript
* [Marp](https://yhatt.github.io/marp/):Markdown Presentation Writer
* [Paste to Markdown](https://euangoddard.github.io/clipboard2markdown/)
* [markdown-it/markdown-it](https://github.com/markdown-it/markdown-it):Markdown parser, done right. 100% CommonMark support, extensions, syntax plugins & high speed <https://markdown-it.github.io>
* [xi-editor/xi-editor](https://github.com/xi-editor/xi-editor):A modern editor with a backend written in Rust. <https://xi-editor.io>
* [taniarascia/takenote](https://github.com/taniarascia/takenote):📝 A web-based note-taking app with GitHub sync and Markdown support. <https://takenote.dev>
* markoff:A lightweight Markdown (CommonMark) previewer for macOS

## 参考

* [mastering-markdown](https://guides.github.com/features/mastering-markdown/)
* [js-sequence-diagrams](https://bramp.github.io/js-sequence-diagrams/):Turns text into UML sequence diagrams
* [flowchart.js](http://adrai.github.io/flowchart.js/):Draws simple SVG flow chart diagrams from textual representation of the diagram
* [adam-p/markdown-here](https://github.com/adam-p/markdown-here):Google Chrome, Firefox, and Thunderbird extension that lets you write email in Markdown and render it before sending. <http://markdown-here.com>
