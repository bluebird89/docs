# [Notion](https://www.notion.so/)

* 万物皆块（block）:可以基于模板
* page:自定义icon
*     workspace：工作空间

    page：页面

    notion的页面是无限层级的，一个页面能够添加多个页面，页面中的页面也可以继续添加页面。

    block：块一个标题、一张图表都被定义为块，块具备在页面中随意拖拽的特性。

    database：数据库，database也是block的一种，它主要包含图表、看板等。

    view：视图，database可以用不同视图切换展示，例如表格可以切换为看板。

    template：模版，可以直接复用的样式。

## 页面 Pages

* Ctrl + N：创建新页面
* Ctrl + Shift + N ：打开一个新的 Notion 窗口
* Ctrl + P ：快速查找页面（可用于快速跳转到其他页面）
* Ctrl + [ ：返回上一页
* Ctrl + ] ：进入下一页
* Ctrl + U ：转到父页面
* Ctrl + Shift + L ：切换黑暗模式
* Ctrl + \ ：打开 / 关闭侧边栏
* Ctrl + Shift + P（仅适用于创建新页面时）：用于选择添加页面的位置

## Block

* Basic
	- 标题
	- 引用
	- 列表
	- 页面（/Page）
* Database：数据库类型
	- 创建一个单独的 Database 页面（Full Page）
	- 插入 Database（Inline）然后在其他地方调用其中的数据（Linked Database）
	- 功能
		+ 自定义column 类型
		+ filter
* Media：多媒体附件
	- 图片
	- 视频
	- 音频
	- 代码框
	- 网页书签
	- 文件附件
* Embeds：动态的网络服务
	- Google Drive
	- Tweet
	- Github Gist
* Advanced
	- TeX 公式
	- 新建自定义模板
	- 当前路径
* 操作
	- 选取
		+ Esc 键：选中当前编辑的 Block，逻辑是退出编辑，进入 Block 操作。
		+ Shift 键：多选 Block
		+ 选中 Block 时，↑ ↓ ← → 方向键：上下选取 Block
		+ 选中 Block 时，Ctrl + A：全选所有的 Bloc
		+ - 选中 Block 时，Ctrl + D：复制一份 Block。
		+ 选中 Block 时，Ctrl + Enter：激活，可以用于按钮、选中、切换待办事项、或者进入全屏图片
		+ 选中 Page Block 时，Ctrl + Shift + R：重命名这个 Page
		+ 选中 Image Block 时，空格键：进入图片全屏浏览

Ctrl + B：加粗文字
Ctrl + I：斜体文字
Ctrl + K：添加超链接
Ctrl + E：添加代码格式（同时变为等宽字体）
Ctrl + Shift + S：添加删除线

## 数据库

* 可以关联
* 视图
	- Table：表格形式，类似于 Airtable 表格，便于做数据统计。每一行都可以单独打开变成一个 Page，添加更多的内容。
	- Board：看板形式，类似于 Trello 看板，便于任务分配、分类。卡片中的选项可以完全由自己定义，看板的分组也可以用选项来改变。
	- Gallery：画廊形式，便于查看多张卡片中的开头部分，可以在卡片开头添加一些概要内容。
	- List：列表形式，便于查看一部分关键性的信息，比如只显示名称和进度，来明确任务的进度。
	- Calendar：日历形式，便于查看时间相关的信息，可以在日历上按时间顺序查看任务。
- 表现
	+ Full Page Databse：整页数据库。就像 Excel 一样，整个页面就是一个数据库。
	- Inline Database：段落内数据库。则像是在 Word 中插入的表格一样，可以在文章中间放一个表格或是日历。
	- Create Linked Database：连接到现有数据库。同样是在 Word 中插入表格，但内容是调用现有的 Database 中的数据，通过过滤和筛选来使用其中的一部分数据。在文章中修改时，也会对原有的 Database 数据进行修改
- 筛选、排序、搜索、隐藏列
- 导入:支持 5 种基础格式： TXT、Markdown、CSV（Excel）、Word、HTML，以及 7 种服务：Trello、Asana、Google Docs、Dropbox Paper、Quip、Evernote、Workflowy

## 模板

*　自定义末班，相当于代码snieppt
*　类型
	- 博客文章：利用 Notion 的分栏功能，轻松排版出一篇图文并茂的博客文章。
	- 每周议程：把一页分栏成五列，分别安排周一到周五的任务。
	- 阅读清单：在数据库中添加希望阅读的书籍、链接、概述、作者，来督促自己看书、实时记录读书笔记、查阅阅读进度都是不错的选择。
* 资源
	- [Notion Pages](https://notionpages.com/):Discover new, productive Notion templates

Fluid 是一个将网站变成应用程序的 Mac 实用程序。因为 Notion 提供了 Web 版本，我可以将每个重要的 Notion 页面制作成 Fluid 应用程序，并将其固定在菜单栏上

Slidepad 和 Better and Better 这两个软件都可以吸附在侧边，区别是 Slidepad 借助第三方登录 Web 版 Notion，可以使用置顶功能；Better and Better 可以直接针对 Notion 官方客户端进行吸附，但不能置顶。

这里只详细说了软件 [Slidepad](http://osen.deisgn) 的使用，Better and Better 安装后在设置中开启吸附，然后点击窗口 Ctrl+Cmd+Option+→ 即可吸附

```
slice("■■■■■■■■■■", 10 - round(min(dateBetween(now(), prop("BeginTime"), "days"), prop("DayOfYear")) / prop("DayOfYear") * 10)) + " " + format(round(min(dateBetween(now(), prop("BeginTime"), "days"), prop("DayOfYear")) / prop("DayOfYear") * 100))
+ "%"

join("", if(largerEq(multiply(divide(prop("当前"), prop("目标")), 100), 10), slice("🌕🌕🌕🌕🌕🌕🌕🌕🌕🌕", 0, multiply(floor(divide(multiply(divide(prop("当前"), prop("目标")), 100), 10)), 2)), ""), if(largerEq(multiply(divide(subtract(prop("目标"), prop("当前")), prop("目标")), 100), 10), slice("🌑🌑🌑🌑🌑🌑🌑🌑🌑🌑", 0, multiply(ceil(multiply(divide(subtract(prop("目标"), prop("当前")), prop("目标")), 10)), 2)), ""), " ", slice(format(multiply(divide(prop("当前"), prop("目标")), 100)), 0, 5), "%")

if(prop("Type") == "日", slice("██████████", 10 - round(toNumber(hour(now())) / 24 * 10)) + slice("░░░░░░░░░░", round(toNumber(hour(now())) / 24 * 10)) + " " + format(round(toNumber(hour(now())) / 24 * 100 * 100) / 100) + "% ", if(prop("Type") == "周", slice("██████████", 10 - round(toNumber((day(now()) ? 0 : 7) ? 7 : day(now())) / 7 * 10)) + slice("░░░░░░░░░░", round(toNumber((day(now()) ? 0 : 7) ? 7 : day(now())) / 7 * 10)) + " " + format(round(toNumber((day(now()) ? 0 : 7) ? 7 : day(now())) / 7 * 100 * 100) / 100) + "%", if(prop("Type") == "月", slice("██████████", 10 - round(toNumber(date(now())) / 31 * 10)) + slice("░░░░░░░░░░", round(toNumber(date(now())) / 31 * 10)) + " " + format(round(toNumber(date(now())) / 31 * 100)) + "%", if(prop("Type") == "年", slice("██████████", 10 - round(toNumber(dateBetween(now(), prop("年份开始"), "days") / 365 * 10))) + slice("░░░░░░░░░░", toNumber(dateBetween(now(), prop("年份开始"), "days") / 365 * 10)) + " " + format(round(toNumber(dateBetween(now(), prop("年份开始"), "days")) / 365 * 100 * 100) / 100) + "%", slice("██████████", 10 - round(toNumber(dateBetween(now(), prop("你的出生"), "years")) / 76 * 10)) + slice("░░░░░░░░░░", round(toNumber(dateBetween(now(), prop("你的出生"), "years")) / 76 * 10)) + " " + format(round(toNumber(dateBetween(now(), prop("你的出生"), "years")) / 76 * 10000) / 100) + "%"))))
```
