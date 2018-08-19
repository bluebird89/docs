# Chrome

## 插件

- Tampermonkey
- ABP
- crxMouse Chrome Gestures:用鼠标操作Chrome
- Momentum ：一款清新的新标签页插件，具有待办、天气、搜索功能，最最重要的是，插件的大背景，非常具有创意和艺术气息
- Infinity New Tab：基于Chrome的云应用服务
- 网页截图:注释&批注：捕获整个页面或任何部分
- Vue React AngularJS Devtools
- Postman：接口调试
- OneTab：所有标签页转换成一个列表
- Print Friendly & PDF：用户自定义打印内容
- 眼不见心不烦：屏蔽微博
- Allow-Control-Allow-Origin: *
- Octotree：github目录工具 Code tree for GitHub
- AdBlock
- Awesome Screenshot: Screen Video Recorder
- Axure RP Extension for Chrome
- JSONView
- XML Tree
- User-Agent Switcher for Chrome
- Momentum
- Octotree:Code tree for GitHub
- 网站分析工具 Wappalyzer
- 代码特效图 Marmoset
- 批量打开多个链接 LinkClump
- 清除历史记录 Click&Clean
- 程序调试工具 Firebug Lite
- Vimium：浏览器vim化

  - Navigating the page

    - j,

      <c-e>    Scroll down</c-e>

    - k,

      <c-y>    Scroll up</c-y>

    - gg Scroll to the top of the page
    - G Scroll to the bottom of the page
    - d Scroll a half page down
    - u Scroll a half page up
    - h Scroll left
    - l Scroll right
    - r Reload the page
    - yy Copy the current URL to the clipboard
    - p Open the clipboard's URL in the current tab
    - P Open the clipboard's URL in a new tab
    - i Enter insert mode
    - v Enter visual mode
    - gi Focus the first text input on the page
    - f Open a link in the current tab
    - F Open a link in a new tab
    - gf Select the next frame on the page
    - gF Select the page's main/top frame

  - Using the vomnibar

    - o Open URL, bookmark or history entry
    - O Open URL, bookmark or history entry in a new tab
    - b Open a bookmark
    - B Open a bookmark in a new tab
    - T Search through your open tabs

  - Using find

    - / Enter find mode
    - n Cycle forward to the next find match
    - N Cycle backward to the previous find match

  - Navigating history

    - H Go back in history
    - L Go forward in history

  - Manipulating tabs

    - t Create new tab
    - J, gT Go one tab left
    - K, gt Go one tab right
    - ^ Go to previously-visited tab
    - g0 Go to the first tab
    - g$ Go to the last tab
    - yt Duplicate current tab
    - <a-p>        Pin or unpin current tab</a-p>

    - <a-m>        Mute or unmute current tab</a-m>

    - x Close current tab
    - X Restore closed tab

  - Miscellaneous

    - ? Show help

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

* console:直接输入JavaScript代码，按回车后执行

