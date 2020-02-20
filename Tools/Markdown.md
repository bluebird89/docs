# Markdown syntax guide

Markdown is a way to style text on the web. You control the display of the document; formatting words as bold or italic, adding images, and creating lists are just a few of the things we can do with Markdown. Mostly, Markdown is just regular text with a few non-alphabetic characters thrown in, like `#` or `*`.

GitHub supports [emoji](https://www.webpagefx.com/tools/emoji-cheat-sheet/)! :smile:

## 设计哲学 Philosophy

> Markdown 的目標是實現「易讀易寫」。
>
> 不過最需要強調的便是它的可讀性。一份使用 Markdown 格式撰寫的文件應該可以直接以純文字發佈，並且看起來不會像是由許多標籤或是格式指令所構成。
>
> Markdown 的語法有個主要的目的：用來作為一種網路內容的*寫作*用語言。
>
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

```
# 第一级标题 `<h1>`
## 第二级标题 `<h2>`
###### 第六级标题 `<h6>`

# This is an `<h1>` tag
## This is an `<h2>` tag
###### This is an `<h6>` tag
```

**Result:**

# 第一级标题  `</h1>`
## 第二级标题 `<h2>`
###### 第六级标题 `<h6>`

# This is an `<h1>` tag
## This is an `<h2>` tag
###### This is an `<h6>` tag

## 强调 Emphasis

**Example:**

* Bold:command/control + b
* Italic:command/control + i
* Bold and italic
* Strikethrough

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
**This text is _extremely_ important**

~~This was mistaken text~~
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

## 换行 Newlines

* End a line with two or more spaces + enter
* add new line between two section
* first line add <br> </br>

## 分隔线 Horizontal Rules

以下三种方式都可以生成分隔线：
```
***

*****

- - -
```

**Result:**

***

*****

- - -

## 列表 Lists

### 无序列表 Unordered

无序列表在文字前面加上 -

**Example:**

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

**Result:**

* Item 1 unordered list `* + SPACE`
* Item 2
    - Item 2a unordered list `TAB + * + SPACE`
    - Item 2b

- Dashes work just as well
- And if you have sub points, put two spaces before the dash or star:
  - Like this
  - And this

### 有序列表 Ordered

有序列表，在文字前面加上 1\. 2\. 3\.

**Example:**

```
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

### 任务列表 Task lists

**Example:**

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

**Example:**

格式: Format: ![Alt Text](url)

```
![GitHub set up](http://zh.mweb.im/asset/img/set-up-git.gif)

![Image of Yaktocat](https://octodex.github.com/images/yaktocat.png)

* ![tully](../_static/tully.jpg)

* 插入图片![有道云笔记logo](http://note.youdao.com/favicon.ico)

* ![爱情](http://i.imgur.com/zjwDS9u.jpg)
```

效果如下：**Result:**

* ![GitHub set up](https://help.github.com/assets/images/site/set-up-git.gif)
* ![Image of Yaktocat](https://octodex.github.com/images/yaktocat.png)
* ![tully](../_static/tully.jpg)
* 插入图片![有道云笔记logo](http://note.youdao.com/favicon.ico)  
* ![爱情](http://i.imgur.com/zjwDS9u.jpg)

## 链接 Links

**Example:**

```
email <example@example.com>
自动生成连接  <http://www.github.com/>
email <example@example.com>
autolink  <http://www.github.com/>

[GitHub](http://github.com)
```

**Result:**

* Email 连接： <example@example.com>  
* 自动生成连接像： <http://www.github.com/>  
* An email <example@example.com> link.  
* Automatic linking for URLs  
* Any URL (like <http://www.github.com/>) will be automatically converted into a clickable link.  
* [连接标题Github网站](http://github.com)  
* [another one with a title](http://lmgtfy.com/ "Hello, world")
* 插入超链接 [直播吧](http://www.zhibo8.com)
* [本地链接](../Tools/Document/Document.md#使用)


## Section links

You can link directly to a section in a rendered file by hovering over the section heading to expose the link:

## Relative links

[Contribution guidelines for this project](docs/CONTRIBUTING.md)

## 区块引用 Blockquotes/Quoting text

**Example:**

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

> 一盏灯， 一片昏黄； 一简书， 一杯淡茶。 守着那一份淡定， 品读属于自己的寂寞。 保持淡定， 才能欣赏到最美丽的风景！ 保持淡定， 人生从此不再寂寞。

> > 一寸山河一寸血，十万青年十万军 ......蒋介石；

## 行内代码 Inline code/Quoting code

**Example:**

```
像这样即可：`<addr>` `code`
I think you should use an `<addr>` `code` element here instead.
```

效果如下：

像这样即可：`<addr>` `code`

I think you should use an `<addr>` `code` element here instead.

## 多行或者一段代码 Multi-line code

**Example:**

```js
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

## 顺序图或流程图 Sequence and Flow chart github不支持


**Example:**

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

**Example:**

```
First Header | Second Header
------------ | -------------
Content from cell 1 | Content from cell 2
Content in the first column | Content in the second column
```

**Result:**

First Header | Second Header
------------ | -------------
Content from cell 1 | Content from cell 2
Content in the first column | Content in the second column

Tables        |      Are      |  Cool
------------- | :-----------: | ----:
col 3 is      | right-aligned | $1600
col 2 is      |   centered    |   $12
zebra stripes |   are neat    |    $1

项目  |     价格 | 数量
--- | -----: | :-:
计算机 | \$1600 |  5
手机  |   \$12 | 12
管线  |    \$1 | 234

Year | Temperature (low) | Temperature (high)
---- | ----------------- | ------------------
1900 | -10               | 25
1910 | -15               | 30
1920 | -10               | 32

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


#### TOC Table of Contents 内容列表

Insert `[ TOC ]` without spaces to generate a table of contents (builtin parsers only).

**Example:**

```
[TOC]
```

**Result:**

[TOC]

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

### 2\. 书写一个质能守恒公式[^LaTeX]

$$E=mc^2$$

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

### Ignoring Markdown formatting

You can tell GitHub to ignore (or escape) Markdown formatting by using \ before the Markdown character.

Let's rename \*our-new-project\* to \*our-old-project\*.

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

### writing on MWeb MWeb 写作使用说明

如果不想打这么多空格，只要回车就为换行，请勾选：`Preferences` - `Themes` - `Translate newlines to <br> tags`
如果是 MWeb 的文档库中的文档，还可以用拖放图片、`CMD + V` 粘贴、`CMD + Option + I` 导入这三种方式来增加图片。
MWeb 引入的特别的语法来设置图片宽度，方法是在图片描述后加 `-w + 图片宽度` 即可，比如说要设置上面的图片的宽度为 140
如果是 MWeb 的文档库中的文档，拖放或`CMD + Option + I` 导入非图片时，会生成连接。
`Preferences` - `Themes` - `Enable sequence & flow chart`
Actions->Insert Read More Comment *或者* `Command + .`
**注** 阅读更多的功能只用在生成网站或博客时，插入时注意要后空一行。

#### 快捷键 **Shortcuts:**

* `CMD + 4` 或 `CMD + R` 预览才可以看效果
* `Control + Shift + I` 可插入图片
* `Control + Shift + L` 可插入链接
* `Option + U` 无序列表
* `CMD + Shift + B` 可插入区块引用区块引用
* `CMD + K` 可插入行内代码
* `CMD + Shift + K` 多行或者一段代码
* `CMD + U`、`CMD + I`、`CMD + B` 强调
* `CMD + 1` 是在仅编辑器模式和三栏模式中切换。
* `CMD + 2` 是在二栏模式和仅编辑器模式中切换。
* `CMD + 3` 是在三栏模式和仅编辑器模式中切换。
* `CMD + 4` 是在编辑器/预览模式和三栏模式中切换。
* `CMD + R` 是在编辑器和预览模式中切换。

##  插件

* sublime插件
    + Markdown Preview：预览
    + MarkdownEditing：代码提示
    + Markdown Extended：语法高亮
    + MarkdownLivePreview `alt + m`
    + Markdown​TOC

## 编辑器

* mac
    - Mou for Mac
    - [Bear](https://bear.app/)
    - Ulysses for Mac
    - MWeb Lite
    - MWeb for Mac
    - [Twig](https://github.com/lukakerr/Pine):A modern, native macOS markdown editor https://lukakerr.github.io/Pine
    - [MacDown](https://github.com/MacDownApp/macdown):Open source Markdown editor for macOS. https://macdown.uranusjr.com/
    - Mark Text:实时显示的markdown编辑器
    - [Quiver](link)
    - [幕布](https://mubu.com/):可折叠的markdown
* [typora](https://www.typora.io/)
* windows
    - MarkdownPad(需要浏览器渲染插件awesome)
    - MarkPad
    - Cmd Markdown
    - CherryTree
    - [zybuluo](https://www.zybuluo.com/cmd/)
- MacDow：MWeb 是专业的 Markdown 写作、记笔记、静态博客生成软件。然后这里**重点说明**一下：MWeb 有**两个模式**，外部模式和文档库模式。外部模式中把本地硬盘或 Dropbox 等网盘的文件夹引入，就可以使用 MWeb 的拖拽、粘贴插入图片、图床等特色功能。文档库模式设计为用于记笔记和静态博客生成。对于有**同步和协作需求**的朋友，请使用外部模式！使用视图菜单或者快捷键 `CMD + E` 可以打开外部模式，`CMD + L` 可以打开文档库。左边的第一第二栏是使用**右键**和底部的几个按钮操作，另外就是右上角有三个按钮了（外部模式是两个），快捷键分别是：`CMD + 7/8/9`。
- [marktext/marktext](https://github.com/marktext/marktext):📝Next generation markdown editor, running on platforms of MacOS Windows and Linux. https://marktext.github.io/website/ `brew cask install mark-text`
* [fabiospampinato/notable](https://github.com/fabiospampinato/notable):The markdown-based note-taking app that doesn't suck.
* [Markdown Here](https://markdown-here.com/)
* [GitNote](https://www.gitnoteapp.com)
* [MedleyText](link)
* [BoostIO/Boostnote](https://github.com/BoostIO/Boostnote):A markdown editor for developers on Mac, Windows and Linux. https://boostnote.io
* OneNote
* Haroopad
    - [下载地址](http://pad.haroopress.com/user.html)
    - `sudo dpkg -i haroopad-v0.13.1-x64.deb`
* [notable/notable](https://github.com/notable/notable):The Markdown-based note-taking app that doesn't suck. https://notable.md
* [tamlok / vnote](https://github.com/tamlok/vnote):https://github.com/tamlok/vnote

## 工具

* [ikatyang/emoji-cheat-sheet](https://github.com/ikatyang/emoji-cheat-sheet/blob/master/README.md):A markdown version emoji cheat sheet
* [zhangjikai/online-markdown-reader](https://github.com/zhangjikai/online-markdown-reader):Markdown 在线阅读器 http://markdown.zhangjikai.com/
* [tamlok/vnote](https://github.com/tamlok/vnote):A Vim-inspired note-taking application that knows programmers and Markdown better. https://tamlok.github.io/vnote
* [nhnent/tui.editor](https://github.com/nhnent/tui.editor):🍞📝 Markdown WYSIWYG Editor. GFM Standard + Chart & UML Extensible. http://ui.toast.com/tui-editor
* [gsuitedevs/md2googleslides](https://github.com/gsuitedevs/md2googleslides):Generate Google Slides from markdown
* [pandao/editor.md](https://github.com/pandao/editor.md):The open source embeddable online markdown editor (component). https://pandao.github.io/editor.md/
* [gnab/remark](https://github.com/gnab/remark):A simple, in-browser, markdown-driven slideshow tool. http://remarkjs.com
* [knsv/mermaid](https://github.com/knsv/mermaid):Generation of diagram and flowchart from text in a similar manner as markdown http://knsv.github.io/mermaid/
* [aaronsw/html2text](https://github.com/aaronsw/html2text):Convert HTML to Markdown-formatted text. http://www.aaronsw.com/2002/html2text/
* [benweet/stackedit](https://github.com/benweet/stackedit):In-browser Markdown editor https://stackedit.io/
* [showdownjs/showdown](https://github.com/showdownjs/showdown):A bidirectional Markdown to HTML to Markdown converter written in Javascript http://www.showdownjs.com/
* [adam-p/markdown-here](https://github.com/adam-p/markdown-here):Google Chrome, Firefox, and Thunderbird extension that lets you write email in Markdown and render it before sending. http://markdown-here.com
* [benweet/stackedit](https://github.com/benweet/stackedit):In-browser Markdown editor https://stackedit.io/
* [markedjs/marked](https://github.com/markedjs/marked):A markdown parser and compiler. Built for speed. https://marked.js.org/
* [mdx-js/mdx](https://github.com/mdx-js/mdx):JSX in Markdown for ambitious projects https://mdxjs.com
* [nhnent/tui.editor](https://github.com/nhnent/tui.editor):🍞📝 Markdown WYSIWYG Editor. GFM Standard + Chart & UML Extensible. http://ui.toast.com/tui-editor
* [Mark Text](https://github.com/marktext/marktext/)
* [evilstreak/markdown-js](https://github.com/evilstreak/markdown-js):A Markdown parser for javascript
* [Marp](https://yhatt.github.io/marp/):Markdown Presentation Writer
* [Paste to Markdown](https://euangoddard.github.io/clipboard2markdown/)
* [markdown-it/markdown-it](https://github.com/markdown-it/markdown-it):Markdown parser, done right. 100% CommonMark support, extensions, syntax plugins & high speed https://markdown-it.github.io
* [xi-editor/xi-editor](https://github.com/xi-editor/xi-editor):A modern editor with a backend written in Rust. https://xi-editor.io
* [taniarascia/takenote](https://github.com/taniarascia/takenote):📝 A web-based note-taking app with GitHub sync and Markdown support. https://takenote.dev

## 参考

* [mastering-markdown](https://guides.github.com/features/mastering-markdown/)
* [js-sequence-diagrams](https://bramp.github.io/js-sequence-diagrams/):Turns text into UML sequence diagrams
* [flowchart.js](http://adrai.github.io/flowchart.js/):Draws simple SVG flow chart diagrams from textual representation of the diagram
* [adam-p/markdown-here](https://github.com/adam-p/markdown-here):Google Chrome, Firefox, and Thunderbird extension that lets you write email in Markdown and render it before sending. http://markdown-here.com
