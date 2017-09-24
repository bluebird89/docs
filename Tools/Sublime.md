# sublime

## 安装

- linux

  ```
  wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
  echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
  sudo apt-get update
  sudo apt-get install sublime-text
  ```

# lisense

build 3143后，失效

```
—– BEGIN LICENSE —–
Michael Barnes
Single User License
EA7E-821385
8A353C41 872A0D5C DF9B2950 AFF6F667
C458EA6D 8EA3C286 98D1D650 131A97AB
AA919AEC EF20E143 B361B1E7 4C8B7F04
B085E65E 2F5F5360 8489D422 FB8FC1AA
93F6323C FD7F7544 3F39C318 D95E6480
FCCC7561 8A4A1741 68FA4223 ADCEDE07
200C25BE DBBC4855 C4CFB774 C5EC138C
0FEC1CEF D9DCECEC D3A5DAD1 01316C36
—— END LICENSE ——

—– BEGIN LICENSE —–
Nicolas Hennion
Single User License
EA7E-866075
8A01AA83 1D668D24 4484AEBC 3B04512C
827B0DE5 69E9B07A A39ACCC0 F95F5410
729D5639 4C37CECB B2522FB3 8D37FDC1
72899363 BBA441AC A5F47F08 6CD3B3FE
CEFB3783 B2E1BA96 71AAF7B4 AFB61B1D
0CC513E7 52FF2333 9F726D2C CDE53B4A
810C0D4F E1F419A3 CDA0832B 8440565A
35BF00F6 4CA9F869 ED10E245 469C233E
—— END LICENSE ——

—– BEGIN LICENSE —–
Anthony Sansone
Single User License
EA7E-878563
28B9A648 42B99D8A F2E3E9E0 16DE076E
E218B3DC F3606379 C33C1526 E8B58964
B2CB3F63 BDF901BE D31424D2 082891B5
F7058694 55FA46D8 EFC11878 0868F093
B17CAFE7 63A78881 86B78E38 0F146238
BAE22DBB D4EC71A1 0EC2E701 C7F9C648
5CF29CA3 1CB14285 19A46991 E9A98676
14FD4777 2D8A0AB6 A444EE0D CA009B54
—— END LICENSE ——

—– BEGIN LICENSE —–
Alexey Plutalov
Single User License
EA7E-860776
3DC19CC1 134CDF23 504DC871 2DE5CE55
585DC8A6 253BB0D9 637C87A2 D8D0BA85
AAE574AD BA7D6DA9 2B9773F2 324C5DEF
17830A4E FBCF9D1D 182406E9 F883EA87
E585BBA1 2538C270 E2E857C2 194283CA
7234FF9E D0392F93 1D16E021 F1914917
63909E12 203C0169 3F08FFC8 86D06EA8
73DDAEF0 AC559F30 A6A67947 B60104C6
—— END LICENSE ——
```

## [文档](http://www.sublimetext.com/docs/3/index.html)

## 配置说明(文件以对象.功能命名）:settin分default user package,包配置优先级最高

- Packages文件目录：Preferences > Browse Packages 打开文件夹 Installed Packages 下看到所安装的各类包,windows中~\AppData\Roaming\Sublime Text 3\Packages\User
- [配置同步:同步Packages/User文件夹](https://packagecontrol.io/docs/syncing)

```
通过云端工具git 网盘
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

- 用户配置Preferences.sublime-settings： Preferences > setting
- 包管理文件：Package Control.sublime-settings
- 插件管理文件：
- 主题目录识别：在包文件下Theme - Monokai Pro
- 自定义快捷键Default (Windows).sublime-keymap:Preferences -> Key Bindings - Users
- 代码片段：

[插件管理工具安装](https://packagecontrol.io/installation)

```
# Preferences > Browse Packages 在文件夹 Installed Packages 下看到所安装的各类包,windows中~\AppData\Roaming\Sublime Text 3\
ctrl+`
import urllib.request,os,hashlib; h = 'df21e130d211cfc94d9b0905775a7c0f' + '1e3d39e33b79698005270310898eea76'; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); by = urllib.request.urlopen( 'http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); print('Error validating download (got %s instead of %s), please try manual install' % (dh, h)) if dh != h else open(os.path.join( ipp, pf), 'wb' ).write(by)
# 重启sublime
```

插件安装

```
# open Package Control's Command Palette：Control + Shift + P (Windows)，Command + Shift + P (on Mac)，或者通过菜单 Tools > Command Palette
#  install package
# 输入package文件名称，回车安装
# 设置语法关联：View > Syntax > Open all with current extension as... 或者 View > Syntax 勾选 MarkdownEditing 下的 MultiMarkdown
```

插件配置

```
# gitHub flavored Markdown 的配置Packages/User/Markdown.sublime-settings
# MultiMarkdown 的配置Packages/User/MultiMarkdown.sublime-settings
```

- sublime Text SFTP:SublimeText -> Preferences -> Package Settings -> SFTP -> Setting Users

  ```
  {
  "email":"Rimke@163.com",s
  "product_key":"e83eda-38644b-43c828-e3669b-cd8a85",
  }
  ```

## 插件

- SublimeLinter：前端编码利器用于高亮提示用户编写的代码中存在的不规范和错误的写法、代码跳转
- HTML-CSS-JS Prettify：格式化（美化）html、css、js三种文件类型的插件
- SublimeTmpl：文件模板都在插件目录的templates

```
ctrl+alt+h html
ctrl+alt+j javascript
ctrl+alt+c css
ctrl+alt+p php
ctrl+alt+r ruby
ctrl+alt+shift+p python
```

- Markdown Preview
- MarkdownEditing
- SublimeTableEditor:markdown表格插件

```
表头：|Name|Phone + tab
删除：Alt + Shift + 左/右/上/下/
移动：Alt + 左/右/上/下/
```

- Git:Plugin for some git integration into sublime text
- Doc​Blockr: Simplifies writing DocBlock comments in Javascript, PHP, CoffeeScript, Actionscript, C & C++
- sublime-text-git
- Alignment：进行智能对齐。
- SublimeCodeIntel:code intelligence and smart autocomplete engine
- GitGutter:see git diff in gutter
- GoSublime:A Golang plugin collection for SublimeText 3
- Bootstrap 3 Snippets:A sublime plugin complete with Bootstrap 3 snippets

  ```
  # 在Preferences.sublime-settings 添加
  "auto_complete_triggers": [{"selector": "text.html", "characters": "bs3"}]
  ```

# 自定义配置

- 包配置：Package Control.sublime-settings
- 界面配置：Preferences.sublime-settings
- 自定义代码片段：*.sublime-snippet
- 自动补全：*.sublime-completions
- 自动构建：*.sublime-build
- 批处理：*.sublime-build 通过shell脚本构建

# 新建模板

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

# 工具

- 控制台:ctrl+ `
- 命令面板:ctrl+shift+p
- 设置高亮语言语法：set syntax php

# 编辑

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

# 查找与跳转

- ctrl+p：搜索并跳转不同的文件
- 跳转函数：ctrl+r
- 直接查找文件
- @symbol跳转到symbol符号所在的位置（函数）
- # 关键字跳转：输入#keyword跳转到keyword所在的位置

- 行号跳转：输入:12跳转到文件的第12行（ctrl+g）

- 查找：ctrl+f

- 替换：ctrl+h ctrl+shift+f：可选文件夹或过滤器

# 显示

- 分屏：alt+shift+数字 ctl+shift+n:切组
- 切栏：alt+数字
- 分割或合并窗口：ctrl+k ctrl+↑ ↓ 左右切换窗口
- 新建文件到分割窗口：ctrl+k，Ctrl+Shift+↑

# 管理

- 切换标签：ctrl+tab
- 切换侧栏：ctrl+k ctrl+b
- 恢复标签：ctrl+shift+t

# html

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

```
ul>li.item${item$$}*5
h$[title=item$]{Header $}*3(添加属性)
ul>li.item$$$*5(多个占位符)
ul>li.item$@-*5(逆序)
ul>li.item$@3_5(定位起始符) div#v$@3_5
```

- 包含多个类：p.class1.class2.class3
- 自定义属性：p[title='hello'] td[rowspan=2 colspan=3 title]
- 文本：{}
- 隐标签：ul>.class table>.row>.col
- a:link a:mail meta:utf
- form：get

# 检查

- F6: 开启/关闭拼写检查
- Ctrl+F6: 定位下一个拼错
- Ctrl+Shift+F6: 定位上一个拼错

# 注释

- 行注释：Ctrl+/
- 块注释：Ctrl+Shift+/

# 构建build

- 运行构建：ctrl+b

## 主题theme

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

[总结配置](https://github.com/jikeytang/sublime-text)
