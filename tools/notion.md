# [Notion](https://www.notion.so/)

Work offline, collaborate in real-time, write without distractions.

* 创始人 Ivan 是一位中国人，在五六年前创立了 Notion。曾因一个版本的 Notion 不够稳定，解雇了全公司的员工。之后与联合创始人搬去了日本京都从头编程，才有了如今的 Notion
* workspace：工作空间
* page：页面
  - 自定义icon,支持 url
* notion的页面是无限层级的，一个页面能够添加多个页面，页面中的页面也可以继续添加页面。
* block：万物皆块（block） 块一个标题、一张图表都被定义为块，块具备在页面中随意拖拽的特性。
* database：数据库，database也是block的一种，它主要包含图表、看板等。
* view：视图，database可以用不同视图切换展示，例如表格可以切换为看板。
* template：模版，可以直接复用的样式。

## 页面 Pages

* 如何多人编辑
  - Operational Transformation。因为 Notion 引入了 block 的概念，它做协同的方法可以来的简单很多：在页面一级，只有调整 block 的位置才需要使用 OT 协同。一个用户调整页面的结构，并不会影响另一个用户修改受影响的 block 本身。而两个用户之间同时对一个 block 进行修改，也需要做 OT
  - 因为 block 的粒度很细，整个多人协作编辑时不用 OT，使用乐观锁（optimistic locking）也可以达到目的
  - 某个用户对文档某部分的编辑，可以通过 CQRS（Command and Query Responsibility Segregation）/ Event Sourcing 的方式来在各个客户端，各个共享用户间进行同步：用户的行为触发事件，各个平台接收事件，然后本地进行事件的处理和状态的更新。只要大家的更新算法一致，事件的顺序保持一致，那么所有人可以得到同样的状态
* 版本控制
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

* block 的概念非常类似 unix 文件系统中的 inode，但比 inode 丰富得多。一个 block，包含两部分内容
  - content 是用户在这个 block 里输入的内容 — 但不全是。我很怀疑 Notion 内部有一套类似 Markdown 的标记语言（但从 API 上没有体现出来），甚至就是一个 Markdown 的超集，通过一个 parser，来将 block 的 content 渲染成最终的展现形式。比如说，page block 就是一个对子页面的引用，渲染出来就是一个点击进入子页面的链接。
  - block 有一些属性（attribute）或者元数据（metadata）。里面涵盖 block 的颜色，样式，父页面的引用，等等。
  - 一个 block 只能属于一个页面（page）。如果需要同样内容的 block 被包含在不同的页面，只能通过复制。但这种复制产生的是一个完整的副本。
* 如何组织成 page
  - 一个页面下的所有的 block 通过 btree（或者其他类似的结构）组织起来。btree 可以在插入效率和有序遍历间达到一个不错的平衡
  - 如果使用 btree，那么每个 block 都有一个唯一可变的序号，代表其在文章中的位置。添加或者移动 block 时按照这个序号来插入。如果用户把一个 block 拽到两个 block 之间，那么这个 block 先被删除，然后再插入到两个已有的 block 之间（比如 block 1 和 block 2 之间，那么新的序号是 1.5）
  - 因为 page 可以支持多栏的版式，所以 block 仅仅有一个维度的序号还不够，它需要两个维度的序号，水平方向和垂直方向。
  - page 在渲染的时候，按照序号的顺序遍历 blocks，然后依次调用 block 的 render 方法，把 block 渲染出来 — 这个渲染的结果可能还是个中间过程，因为 page 还有自己的样式和 attributes，最后再附上 page 自己的样式，得到最终在不同端上的渲染结果
* 版本控制
  - 在一处修改一下，修改立刻展示在其他平台:每次修改的时候，web 立即得到通知，然后去主动 post 到 Notion 的 syncRecordValues REST API 上。即使仅仅修改一两个字，这个 API 每次都返回完整的 block 的内容。从这里我们能确定的是每次修改，block 的版本一直在增长。
  - API 并不是描述事件，而在描述状态,弊端是随着数据的增多，API 里要描绘的状态就会越来越多，从而拖累整个系统运行的效率。
  - 创建了一个 hello world 的 block，然后将其拖拽到上一个 block 上面。Notion API 返回这样的数据：除了 hello world block 本身，还有整个 page 的 block 的列表.每次在 page 里插入 block 的时候，Notion 都会发回整个 page 的 block 的列表，然后客户端按照这个列表更新
* Basic
  - 标题
  - 引用
  - 列表
  - 页面（/Page）
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
    + Esc 键：选中当前编辑的 Block，逻辑是退出编辑，进入 Block 操作
    + Shift 键：多选 Block
    + 选中 Block 时，↑ ↓ ← → 方向键：上下选取 Block
    + 选中 Block 时，Ctrl + A：全选所有的 Bloc
        + - 选中 Block 时，Ctrl + D：复制一份 Block
    + 选中 Block 时，Ctrl + Enter：激活，可以用于按钮、选中、切换待办事项、或者进入全屏图片
    + 选中 Page Block 时，Ctrl + Shift + R：重命名这个 Page
    + 选中 Image Block 时，空格键：进入图片全屏浏览
  - 字体
    + Ctrl + B：加粗文字
    + Ctrl + I：斜体文字
    + Ctrl + K：添加超链接
    + Ctrl + E：添加代码格式（同时变为等宽字体）
    + Ctrl + Shift + S：添加删除线

## 数据库 Database

* 插入 Database（Inline）然后在其他地方调用其中的数据（Linked Database）
* 自定义column 类型
  - Tag
  - Date
  - Number
  - URL
  - file
  - Formula
* filter
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
- 导入
  + 支持 5 种基础格式： TXT、Markdown、CSV（Excel）、Word、HTML
  + 7 种服务：Trello、Asana、Google Docs、Dropbox Paper、Quip、Evernote、Workflowy

## 模板

*自定义末班，相当于代码snieppt
*　建一个通用模板：右上角 New 旁边的「v」，再点击 「+ New Template」
*使用建好的模板
    -点击 Database 右上角 New 旁边的「v」，在点击模板即可开始创建，适合新建软件。
    - 直接点进 Page 进行点击 Page 中的模板名即可，适合已经创建好的 Page。
*　类型
    - 博客文章：利用 Notion 的分栏功能，轻松排版出一篇图文并茂的博客文章。
    - 每周议程：把一页分栏成五列，分别安排周一到周五的任务。
    - 阅读清单：在数据库中添加希望阅读的书籍、链接、概述、作者，来督促自己看书、实时记录读书笔记、查阅阅读进度都是不错的选择。

* 资源
  - [Notion Pages](https://notionpages.com/):Discover new, productive Notion templates
  - [Notion 模板中心](https://www.notion.so/Notion-bc848f6560db42f6888c5104685d815d)

```
slice("■■■■■■■■■■", 10 - round(min(dateBetween(now(), prop("BeginTime"), "days"), prop("DayOfYear")) / prop("DayOfYear") * 10)) + " " + format(round(min(dateBetween(now(), prop("BeginTime"), "days"), prop("DayOfYear")) / prop("DayOfYear") * 100))
+ "%"

join("", if(largerEq(multiply(divide(prop("当前"), prop("目标")), 100), 10), slice("🌕🌕🌕🌕🌕🌕🌕🌕🌕🌕", 0, multiply(floor(divide(multiply(divide(prop("当前"), prop("目标")), 100), 10)), 2)), ""), if(largerEq(multiply(divide(subtract(prop("目标"), prop("当前")), prop("目标")), 100), 10), slice("🌑🌑🌑🌑🌑🌑🌑🌑🌑🌑", 0, multiply(ceil(multiply(divide(subtract(prop("目标"), prop("当前")), prop("目标")), 10)), 2)), ""), " ", slice(format(multiply(divide(prop("当前"), prop("目标")), 100)), 0, 5), "%")

if(prop("Type") == "日", slice("██████████", 10 - round(toNumber(hour(now())) / 24 * 10)) + slice("░░░░░░░░░░", round(toNumber(hour(now())) / 24 * 10)) + " " + format(round(toNumber(hour(now())) / 24 * 100 * 100) / 100) + "% ", if(prop("Type") == "周", slice("██████████", 10 - round(toNumber((day(now()) ? 0 : 7) ? 7 : day(now())) / 7 * 10)) + slice("░░░░░░░░░░", round(toNumber((day(now()) ? 0 : 7) ? 7 : day(now())) / 7 * 10)) + " " + format(round(toNumber((day(now()) ? 0 : 7) ? 7 : day(now())) / 7 * 100 * 100) / 100) + "%", if(prop("Type") == "月", slice("██████████", 10 - round(toNumber(date(now())) / 31 * 10)) + slice("░░░░░░░░░░", round(toNumber(date(now())) / 31 * 10)) + " " + format(round(toNumber(date(now())) / 31 * 100)) + "%", if(prop("Type") == "年", slice("██████████", 10 - round(toNumber(dateBetween(now(), prop("年份开始"), "days") / 365 * 10))) + slice("░░░░░░░░░░", toNumber(dateBetween(now(), prop("年份开始"), "days") / 365 * 10)) + " " + format(round(toNumber(dateBetween(now(), prop("年份开始"), "days")) / 365 * 100 * 100) / 100) + "%", slice("██████████", 10 - round(toNumber(dateBetween(now(), prop("你的出生"), "years")) / 76 * 10)) + slice("░░░░░░░░░░", round(toNumber(dateBetween(now(), prop("你的出生"), "years")) / 76 * 10)) + " " + format(round(toNumber(dateBetween(now(), prop("你的出生"), "years")) / 76 * 10000) / 100) + "%"))))
```

## 教程

* [177](https://www.notion.so/177-466f3df46024432fabc894c57bb83bb0)

## 工具

* Fluid 是一个将网站变成应用程序的 Mac 实用程序。因为 Notion 提供了 Web 版本，可以将每个重要的 Notion 页面制作成 Fluid 应用程序，并将其固定在菜单栏上
* [Slidepad](http://osen.deisgn) 和 Better and Better 这两个软件都可以吸附在侧边，区别是
  - Slidepad 借助第三方登录 Web 版 Notion，可以使用置顶功能
  - Better and Better 可以直接针对 Notion 官方客户端进行吸附，但不能置顶。
