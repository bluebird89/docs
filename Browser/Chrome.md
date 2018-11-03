# Chrome

## 插件

* Tampermonkey
* ABP
* crxMouse Chrome Gestures:用鼠标操作Chrome
* Momentum ：一款清新的新标签页插件，具有待办、天气、搜索功能，最最重要的是，插件的大背景，非常具有创意和艺术气息
* Infinity New Tab：基于Chrome的云应用服务
* 网页截图:注释&批注：捕获整个页面或任何部分
* Vue React AngularJS Devtools
* Postman：接口调试
* OneTab：所有标签页转换成一个列表
* Print Friendly & PDF：用户自定义打印内容
* 眼不见心不烦：屏蔽微博
* Allow-Control-Allow-Origin: *
* Octotree：github目录工具 Code tree for GitHub
* AdBlock
* Awesome Screenshot: Screen Video Recorder
* Axure RP Extension for Chrome
* JSONView
* XML Tree
* User-Agent Switcher for Chrome
* Momentum
* Octotree:Code tree for GitHub
* 网站分析工具 Wappalyzer
* 代码特效图 Marmoset
* 批量打开多个链接 LinkClump
* 清除历史记录 Click&Clean
* 程序调试工具 Firebug Lite
* [deanoemcke/thegreatsuspender](https://github.com/deanoemcke/thegreatsuspender):A chrome extension for suspending all tabs to free up memory
* [philc/vimium](The hacker's browser.)The hacker's browser.
* User-Agent Switcher for Chrome
* [gongjunhao/seckill](https://github.com/gongjunhao/seckill):Chrome浏览器 抢购、秒杀插件，秒杀助手，定时自动点击

```
Navigating the current page:

?       show the help dialog for a list of all available keys
h       scroll left
j       scroll down
k       scroll up
l       scroll right
gg      scroll to top of the page
G       scroll to bottom of the page
d       scroll down half a page
u       scroll up half a page
f       open a link in the current tab
F       open a link in a new tab
r       reload
gs      view source
i       enter insert mode -- all commands will be ignored until you hit Esc to exit
yy      copy the current url to the clipboard
yf      copy a link url to the clipboard
gf      cycle forward to the next frame
gF      focus the main/top frame
Navigating to new pages:

o       Open URL, bookmark, or history entry
O       Open URL, bookmark, history entry in a new tab
b       Open bookmark
B       Open bookmark in a new tab
Using find:

/       enter find mode
          -- type your search query and hit enter to search, or Esc to cancel
n       cycle forward to the next find match
N       cycle backward to the previous find match
For advanced usage, see regular expressions on the wiki.

Navigating your history:

H       go back in history
L       go forward in history
Manipulating tabs:

J, gT   go one tab left
K, gt   go one tab right
g0      go to the first tab
g$      go to the last tab
^       visit the previously-visited tab
t       create tab
yt      duplicate current tab
x       close current tab
X       restore closed tab (i.e. unwind the 'x' command)
T       search through your open tabs
W       move current tab to new window
<a-p>   pin/unpin current tab
Using marks:

ma, mA  set local mark "a" (global mark "A")
`a, `A  jump to local mark "a" (global mark "A")
``      jump back to the position before the previous jump
          -- that is, before the previous gg, G, n, N, / or `a
Additional advanced browsing commands:

]], [[  Follow the link labeled 'next' or '>' ('previous' or '<')
          - helpful for browsing paginated sites
<a-f>   open multiple links in a new tab
gi      focus the first (or n-th) text input box on the page
gu      go up one level in the URL hierarchy
gU      go up to root of the URL hierarchy
ge      edit the current URL
gE      edit the current URL and open in a new tab
zH      scroll all the way left
zL      scroll all the way right
v       enter visual mode; use p/P to paste-and-go, use y to yank
V       enter visual line mode
```

## 配置

chrome://net-internals/#hsts

## 技巧

* Ctrl键或Cmd并点链接：打开一个新的标签页而不离开现有的页面
* Shift键或Cmd并点链接：在一个全新的窗口中打开一个链接
* 空格键向下滚动一个完整的页面长度 Shift键和空格键：相反操作
* Ctrl键或Cmd+Shift+T：重新打开你最近关闭的标签
* Ctrl+Shift+D：打开一堆选项卡并想把这些页面都保存起来
* 选中词汇右键搜索或者拖动到地址栏
* 点击链接拖动到书签栏
* Chrome://restart 重启浏览器
* chrome://extensions/shortcuts ： 快捷方式
* 地址栏中输入文件夹路径：当作文件浏览器
* Ctrl或Cmd+H或在地址栏中键入Chrome://history:打开你的浏览记录
* 自定义搜索引擎功能:“cs”作为关键字，将chrome://settings设置为URL
    - gmail.com”或其他缩写作为关键字，以及将“https://mail.google.com/mail/ca/u/0/#search/%s”设置为URL

```
# 粘贴到地址栏并保存书签，对文本格式化操作
data:text/html;charset=utf-8, <title>Scratchpad</title><style>body {padding: 5%; font-size: 1.5em; font-family: Arial; }”></style><link rel=”shortcut icon” href=”https://ssl.gstatic.com/docs/documents/images/kix-favicon6.ico”/><body OnLoad=’document.body.focus();’ contenteditable spellcheck=”true” >
```

## Developer Tools

* console
    - 直接输入JavaScript代码，按回车后执行
    - console 里 输入:document.designMode = "on"  可以直接修改网页上的内容
    - buffer 5个你查看过的DOM对象，你可以直接在Console中用 $0, $1, $2, $3, $4来访问。
    - 像jQuery那样的语法来获得DOM对象，如：$("#mydiv")
    -  `$$(".class")` 来选择所有满足条件的DOM对象
    -  使用 getEventListeners($("selector")) 来查看某个DOM对象上的事件
    -   monitorEvents($("selector")) 来监控相关的事件
    -   函数
        + monitor 来监控一函数，传入函数名称
        + copy 把一个变量的值copy到剪贴板
        + inspect：可以让你控制台跳到你需要查看的对象
    - 输出
        + console.log("%c左耳朵", "font-size:90px;color:#888")
            * %s    格式化输出一个字符串变量。
            * %i or %d    格式化输出一个整型变量的值。
            * %f  格式化输出一个浮点数变量的值。
            * %o  格式化输出一个DOM对象。
            * %O  格式化输出一个Javascript对象。
            * %c  为后面的字符串加上CSS样式
        + console.debug
        + console.info
        + console.warn
        + console.error
        + console.table
        + console.trace() 可以打出js的函数调用栈
        * console.time() 和 console.timeEnd() 可以帮你计算一段代码间消耗的时间。
        * console.profile() 和 console.profileEnd() 可以让你查看CPU的消耗。
        * console.count() 可以让你看到相同的日志当前被打印的次数。
        * console.assert(expression, object) 可以让你assert一个表达式
* Sources
    - 代码格式化
    - 断点设置
        + DOM设置断点：选中DOM添加
        + break points中：给XHR和Event Listener设置断点
* Elements
    - 强制DOM状态
* More Tools
    - Animations:慢动作播放动画
* Network
    - 添加Thtottle:来模拟一个网络很慢情况
    - Copy => Copy as cURL：获取请求的curl
* 手机模式
    - 右上角的more：Capture snapshot

```js
console.todo = function( msg){
  console.log( '%c%s %s %s', 'font-size:20px; color:yellow; background-color: blue;', '--', msg, '--');
}
console.important = function( msg){
  console.log( '%c%s %s %s', 'font-size:20px; color:brown; font-weight: bold; text-decoration: underline;', '--', msg, '--');
}
```
## 工具

* [andrewdavey/immutable-devtools](https://github.com/andrewdavey/immutable-devtools):Chrome Dev Tools custom formatter for Immutable-js values
* [extfans](https://extfans.com/)三方扩展商店

## 参考

* [ChromeDevTools/awesome-chrome-devtools](https://github.com/ChromeDevTools/awesome-chrome-devtools):Awesome tooling and resources in the Chrome DevTools & DevTools Protocol ecosystem
* [Chrome 开发者工具](https://developers.google.com/web/tools/chrome-devtools/)
* [ChromeDevTools/devtools-protocol](https://github.com/ChromeDevTools/devtools-protocol):Chrome DevTools Protocol 
