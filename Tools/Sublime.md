# sublime

## 安装

### linux

```shell
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text
```

### Mac

```shell
brew cask install sublime-text
```

## 配置

配置说明(文件以对象.功能命名）:settin分default user package,包配置优先级最高

- Packages文件目录：Preferences > Browse Packages 打开文件夹 Installed Packages 下看到所安装的各类包,windows中~\AppData\Roaming\Sublime Text 3\Packages\User
- [配置同步:同步Packages/User文件夹](https://packagecontrol.io/docs/syncing)
- 用户配置Preferences.sublime-settings： Preferences > setting
- 包管理文件：Package Control.sublime-settings
- 插件管理文件：
- 主题目录识别：在包文件下Theme - Monokai Pro
- 自定义快捷键Default (Windows).sublime-keymap:Preferences -> Key Bindings - Users
- 代码片段

```shell
# 通过云端工具git 网盘
# Close Sublime Text
# Open Terminal
cd ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/
mkdir ~/Dropbox/Sublime
mv User ~/Dropbox/Sublime/
ln -s ~/Dropbox/Sublime/User
# other machine
cd ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/
rm -r User
ln -s ~/Dropbox/Sublime/User
```

[插件管理工具安装](https://packagecontrol.io/installation)

- Preferences > Browse Packages 在文件夹 Installed Packages 下看到所安装的各类包,windows中~\AppData\Roaming\Sublime Text 3\
ctrl+`
import urllib.request,os,hashlib; h = 'df21e130d211cfc94d9b0905775a7c0f' + '1e3d39e33b79698005270310898eea76'; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); by = urllib.request.urlopen( 'http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); print('Error validating download (got %s instead of %s), please try manual install' % (dh, h)) if dh != h else open(os.path.join( ipp, pf), 'wb' ).write(by)
- 重启sublime
- 插件安装
- open Package Control's Command Palette：Control + Shift + P (Windows)，Command + Shift + P (on Mac)，或者通过菜单 Tools > Command Palette
- install package
- 输入package文件名称，回车安装
- 设置语法关联：View > Syntax > Open all with current extension as... 或者 View > Syntax 勾选 MarkdownEditing 下的 MultiMarkdown

插件配置

- gitHub flavored Markdown 的配置Packages/User/Markdown.sublime-settings
- MultiMarkdown 的配置Packages/User/MultiMarkdown.sublime-settings
- sublime Text SFTP:SublimeText -> Preferences -> Package Settings -> SFTP -> Setting Users

```json
{
"email":"Rimke@163.com",s
"product_key":"e83eda-38644b-43c828-e3669b-cd8a85",
}
```

## 插件

- SublimeLinter：前端编码利器用于高亮提示用户编写的代码中存在的不规范和错误的写法、代码跳转
- HTML-CSS-JS Prettify：格式化（美化）html、css、js三种文件类型的插件
- SublimeTmpl：文件模板都在插件目录的templates
- Markdown Preview
- MarkdownEditing
- SublimeTableEditor:markdown表格插件
- Git:Plugin for some git integration into sublime text
- Doc​Blockr: Simplifies writing DocBlock comments in Javascript, PHP, CoffeeScript, Actionscript, C & C++
- sublime-text-git
- Alignment：进行智能对齐。
- SublimeCodeIntel:code intelligence and smart autocomplete engine
- GitGutter:see git diff in gutter
- GoSublime:A Golang plugin collection for SublimeText 3
- Bootstrap 3 Snippets:A sublime plugin complete with Bootstrap 3 snippets
- autofilename:自动关联图片,css,js等资源路径插件

```
ctrl+alt+h html
ctrl+alt+j javascript
ctrl+alt+c css
ctrl+alt+p php
ctrl+alt+r ruby
ctrl+alt+shift+p python

表头：|Name|Phone + tab
删除：Alt + Shift + 左/右/上/下/
移动：Alt + 左/右/上/下/

# 在Preferences.sublime-settings 添加
"auto_complete_triggers": [{"selector": "text.html", "characters": "bs3"}]
```

## 自定义配置

- 包配置：Package Control.sublime-settings
- 界面配置：Preferences.sublime-settings
- 自定义代码片段：*.sublime-snippet
- 自动补全：*.sublime-completions
- 自动构建：*.sublime-build
- 批处理：*.sublime-build 通过shell脚本构建

## 新建模板

- html：ctrl+alt+h php注释 html:5
- javascript：ctrl+alt+j
- css：ctrl+alt+c
- php：ctrl+alt+p
- ruby：ctrl+alt+r
- python：ctrl+alt+shift+p
- 新建窗口:Ctrl+Shift+N
- 打开文件:Ctrl+O
- 保存文件:Ctrl+S
- 另存文件:Ctrl+Shift+S
- 关闭文件:Ctrl+W

## 工具

- 控制台:ctrl+ `
- 命令面板:ctrl+shift+p
- 设置高亮语言语法：set syntax php

## 编辑

- 多行同时编辑：选中行数 ctrl+shift+L
- 选词： 选中文本 逐个添加：ctrl+d 全部选中 alt+f3
- 合并行：Ctrl+J
- 换行：alt+q
- 选择整行：Ctrl+L
- 同时编辑不同文本： ctrl 选中不同文本
- 竖行选中： shift+鼠标右键
- 添加新行：ctrl+enter ctrl+shift+enter
- 缩进与反缩进：ctrl+[, ctrl+]
- 复制当前行：ctrl+shift+d
- 删除当前行：ctrl+shift+k
- 粘贴保持样式：ctrl+shift+v
- 移动行：ctrl+shift+↑ ↓
- 添加或删除注释：ctrl+/
- 获取{}中内容：ctrl+shift+m
- 移动{}开始与结束：ctrl+m
- F9：行排序(按a-z，大小写敏感)
- shift+f9：行排序(按a-z，大小写不敏感)
- 从光标处删除至行首：Ctrl+K Backspace
- 从光标处删除至行尾：Ctrl+K k
- 改为大写：Ctrl+K+U
- 改为小写：Ctrl+K+L
- 折叠与展开代码：ctrl+shift+[,]
- 折叠与展开属性：ctrl+k+t,0
- 撤销：ctrl+z,y，u
- 重做ctrl+y
- 恢复ctrl+u
- 开关宏记录：Ctrl+Q
- 运行宏：Ctrl+Shift+Q
- 词互换：ctrl+t
- 做运算：ctrl+shift+y
- 数字步增：ctrl+↑ ↓
- 以单词粒度移动光标：alt+left/right
- 以整行移动：ctrl+left/right
- 左右选择：alt+shift+left/right
- 上下选择：shift+up/down

### 查找与跳转

- ctrl+p：搜索并跳转不同的文件
- 跳转函数：ctrl+r
- 直接查找文件
- @symbol跳转到symbol符号所在的位置（函数）
- `# 关键字跳转：输入#keyword跳转到keyword所在的位置`
- 行号跳转：输入:12跳转到文件的第12行（ctrl+g）
- 查找：ctrl+f
- 替换：ctrl+h ctrl+shift+f：可选文件夹或过滤器

### 显示

- 分屏：alt+shift+数字 ctl+shift+n:切组
- 切栏：alt+数字
- 分割或合并窗口：ctrl+k ctrl+↑ ↓ 左右切换窗口
- 新建文件到分割窗口：ctrl+k，Ctrl+Shift+↑

### 管理

- 切换标签：ctrl+tab
- 切换侧栏：ctrl+k ctrl+b
- 恢复标签：ctrl+shift+t

### html

- 激发zencoding控制台:ctrl+alt+enter
- 默认标签为div:.container #container
- 获取模板：输入! ctrl+e
- 闭合标签：alt+.
- 移除父标签：ctrl+shift+;
- 添加标签：ctrl+shift+g
- 全屏：f11
- 免打扰：shift+f11
- 后代：ul>li .wrap>ul.list>.sites
- 兄弟：div+p+bq
- 分组：div>(header>ul>li*2>a)+footer>p
- 乘法：li*5
- 向上一层：.warp>p>a^p .warp>p>a^^p
- a[href="<http://www.baidu.com"]{百度}>
- 递增：
- 包含多个类：p.class1.class2.class3
- 自定义属性：p[title='hello'] td[rowspan=2 colspan=3 title]
- 文本：{}
- 隐标签：ul>.class table>.row>.col
- a:link a:mail meta:utf
- form：get

```
ul>li.item${item$$}*5
h$[title=item$]{Header $}*3(添加属性)
ul>li.item$$$*5(多个占位符)
ul>li.item$@-*5(逆序)
ul>li.item$@3_5(定位起始符) div#v$@3_5
```

### 检查

- F6: 开启/关闭拼写检查
- Ctrl+F6: 定位下一个拼错
- Ctrl+Shift+F6: 定位上一个拼错

### 注释

- 行注释：Ctrl+/
- 块注释：Ctrl+Shift+/

### 构建build

- 运行构建：ctrl+b

### 主题theme

- material
- Monokai Pro

```
Package Control ‣ Install Package ‣ Theme - Monokai Pro
Command Palette ‣ Monokai Pro: select theme
```

## [代码片段](http://www.jianshu.com/p/356bd7b2ea8e)

Snippet可以存储在任何的文件夹中, 并且以.sublime-snippet为文件扩展名, 默认是存储在.sublime-snippet文件夹下.snippet四个组成部分:

- content:其中必须包含<![CDATA[...]]>,否则无法工作, Type your snippet here用来写你自己的代码片段
- tabTrigger:用来引发代码片段的字符或者字符串, 比如在以上例子上, 在编辑窗口输入hello然后按下tab就会在编辑器输出Type your snippet here这段代码片段
- scope: 表示你的代码片段会在那种语言环境下激活, 比如上面代码定义了source.python, 意思是这段代码片段会在python语言环境下激活.
- description :展示代码片段的描述, 如果不写的话, 默认使用代码片段的文件名作为描述
- 环境变量
- fields:通过tab键循环的改变代码片段的一些值
- snippet镜像区域,会使相同编号的位置同时进行编辑:系统$n -snippet Placeholders:添加默认值，占位符设置嵌套

```
<snippet>
   <content><![CDATA[
=================================
$TM_FILENAME   用户文件名
$TM_FILEPATH   用户文件全路径
$TM_FULLNAME    用户的用户名
$TM_LINE_INDEX   插入多少列, 默认为0
$TM_LINE_NUMBER   一个snippet插入多少行
$TM_SOFT_TABS  如果设置translate_tabs_to_spaces : true 则为Yes
$TM_TAB_SIZE   每个Tab包含几个空格
First Name: ${1:Guillermo}
Second Name: ${2:López}
Address: ${3:Main Street 1234}
User name: $1
Environment Variable : ${4:$TM_FILEPATH }  #可以设置默认占位符为环境变量
Test: ${5:Nested ${6:Placeholder}}
=================================
]]></content>
    <!-- Optional: Set a tabTrigger to define how to trigger the snippet -->
    <tabTrigger>hello</tabTrigger>
    <!-- Optional: Set a scope to limit where the snippet will trigger -->
    <scope>source.python</scope>
</snippet>
```

### Emmet

```
html:5 或!：用于HTML5文档类型
html:xt：用于XHTML过渡文档类型
html:4s：用于HTML4严格文档类型

p#foo 补充ID
p.foo 补充类
h1{foo} 和 a[href=#] 为h1和a标签

>：子元素符号，表示嵌套的元素
+：同级标签符号
^：可以使该符号前的标签提升一行

(.foo>h1)+(.bar>h2) 
ul>li*3
ul>li.item$*3
```

### 快捷键

#### 选择类

Ctrl+D选中光标所占的文本,继续操作则会选中下一个相同的的文本
ctrl+G:输入行号,可快速跳转该行
ctrl+p:输入冒号,在输入行号，可快速跳转到某一行
Alt+F3选中文本按下快捷键,即可一次性选择全部相同的文本进行同时编辑:举个例子:快速选中并更改所有相同的变量名和函数名等
Ctrl+L:选中整行,继续操作则继续选择下一行,效果和shift+向下箭头效果一样
Ctrl+shift+L:先选中多行,在按下快捷键,会在每行行尾插入光标,即可同时编辑这行
Ctrl+Shift+M 选择括号内的内容（继续选择父括号）。举个栗子：快速选中删除函数中的代码，重写函数体代码或重写括号内里的内容
Ctrl+M 光标移动至括号内结束或开始的位置
Ctrl+Enter 在下一行插入新行。举个栗子：即使光标不在行尾，也能快速向下插入一行
Ctrl+Shift+Enter 在上一行插入新行。举个栗子：即使光标不在行首，也能快速向上插入一行
ctrl+shift+[:选中代码,按下快捷键,折叠代码
ctrl+shift+]:选中代码,按下快捷键,展开代码
Ctrl+k+0:展开所有折叠代码
ctrl+←:向左单位性地移动光标,快速移动光标
ctrl+→:向右单位性移动光标,快速移动光标
shift+↑ 向上选中多行
shift+↓ 向下选中多行
Shift+← 向左选中文本
Shift+→ 向右选中文本
Ctrl+Shift+← 向左单位性地选中文本
Ctrl+Shift+→ 向右单位性地选中文本
Ctrl+Shift+↑ 将光标所在行和上一行代码互换（将光标所在行插入到上一行之前）
Ctrl+Shift+↓ 将光标所在行和下一行代码互换（将光标所在行插入到下一行之后）
Ctrl+Alt+↑ 或Ctrl+Alt+鼠标向上拖动 向上添加多行光标，可同时编辑多行
Ctrl+Alt+↓或Ctrl+Alt+鼠标向下拖动 向下添加多行光标，可同时编辑多行
多重选择功能允许在页面中同时存在多个光标,让很多本来需要正则表达式,高级搜索和替换才能完成的的任务也变得游刃有余了 激活多重选择的方法有两及种:
按住ctrl然后在页面中希望中现光标的位置点击
选择数行文本,然后按下shift+ctrl+L
通过反复按下ctrl+D即可将全文中与光标当前所在位置的词相同的词逐一加入选择,而直接按下Alt+F3即可一次性选择所有相同的词
按下鼠标中键来进行垂直方向的纵列选择,也可以进入多重编辑状态

#### 编辑类

Ctrl+J:合并选中多行代码为一行:将多行格式的css属性合并为一行
ctrl+shift+D:复制光标所在的整行,插入到下一行
Tab 向右缩进。只对光标后（或者选中的）的代码有效
Shift+Tab 向左缩进
Ctrl+[ 向左缩进。对整行有效
Ctrl+] 向右缩进。对整行有效
Ctrl+K+K 从光标处开始删除代码至行尾。按住Ctrl，按两次K
Ctrl+Shift+K 删除整行
Ctrl+/ 注释单行
Ctrl+Shift+/ 注释多行
Ctrl+K+U 转换大写
Ctrl+K+L 转换小写
Ctrl+Z 撤销
Ctrl+Y 恢复撤销
Ctrl+U 软撤销，感觉和 Gtrl+Z 一样
Ctrl+F2 设置书签，F2切换书签
Ctrl+T 左右字母互换

#### 搜索类

* Ctrl+F 打开底部搜索框，查找关键字
* Ctrl+shift+F 在文件夹内查找，与普通编辑器不同的地方是sublime允许添加多个文件夹进行查找
* Ctrl+P 打开搜索框。举个栗子
    + 输入当前项目中的文件名，快速搜索文件
    + 输入@和关键字，查找文件中函数名
    + 输入：和数字，跳转到文件中该行代码
    + 输入#和关键字，查找变量名
* Ctrl+G 打开搜索框，自动带：，输入数字跳转到该行代码。举个栗子：在页面代码比较长的文件中快速定位
* Ctrl+R 打开搜索框，自动带@，输入关键字，查找文件中的函数名。举个栗子：在函数较多的页面快速查找某个函数
* Ctrl+: 打开搜索框，自动带#，输入关键字，查找文件中的变量名、属性名等
* Esc 退出光标多行选择，退出搜索框，命令框
* Ctrl+Shift+P 打开命令框。场景栗子：打开命名框，输入关键字，调用sublime text或插件的功能，例如使用package安装插件

### 配置同步

### 通过共享文件

- 清除 Packages 目录下User
- `ln -s ~/baiduyunebooks/sublime3/Packages/User User` // 建立符号链接

### 通过sync-setting配置

- 新建github的token
- 安装syn-setting插件
- 配置文件，主进程download，其它更新
- 安装 

* [总结配置](https://github.com/jikeytang/sublime-text)
* [](http://laravelacademy.org/post/6711.html)
* [文档](http://www.sublimetext.com/docs/3/index.html)
