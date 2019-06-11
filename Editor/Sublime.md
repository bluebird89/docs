# Sublime Text 3

## 安装

```sh
### linux
curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo add-apt-repository "deb https://download.sublimetext.com/ apt/stable/"

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

sudo apt-get update
sudo apt-get install sublime-text

### Mac
brew cask install sublime-text

ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl

### windows
# 下载软件
# 添加到命令行`D:\Program Files\Sublime Text 3`
```

## 配置

配置文件以对象.功能命名:user重写default

-   配置:Preferences.sublime-settings
    -   包配置：Package Control.sublime-settings
    -   界面配置：Preferences.sublime-settings
    -   自定义代码片段：\*.sublime-snippet
    -   自动补全：\*.sublime-completions
    -   自动构建：\*.sublime-build
    -   批处理：\*.sublime-build 通过shell脚本构建
-   主题配置：在包文件下Theme - Monokai Pro
-   快捷键：Default (Windows).sublime-keymap

包管理工具[Package Control](https://packagecontrol.io/installation)

-   Preferences > Browse Packages：Installed Packages； windows中~\\AppData\\Roaming\\Sublime Text 3\\
-   安装package：打开控制台console:`ctrl+\`
-   如果安装报错，比如连接远程服务器失败之类的，请设置wbond.net的host，如下：50.116.33.29 sublime.wbond.net
-   重启sublime
-   open Package Control's Command Palette：Control + Shift + P (Windows)，Command + Shift + P (on Mac)，或者通过菜单 Tools > Command Palette
-   install package->输入package文件名称
- channel配置：
    - 添加channle:`Control + Shift + P `, `Package Control  Settings-user`

```
import urllib.request,os,hashlib; h = 'df21e130d211cfc94d9b0905775a7c0f' + '1e3d39e33b79698005270310898eea76'; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); by = urllib.request.urlopen( 'http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); print('Error validating download (got %s instead of %s), please try manual install' % (dh, h)) if dh != h else open(os.path.join( ipp, pf), 'wb' ).write(by)

"channels":
    [
        "https://raw.githubusercontent.com/wilon/sublime/master/download/channel_v3.json",
        "https://packagecontrol.io/channel_v3.json"
        // "channel_v3.jsondir/channel_v3.json"
    ],
```


## 插件

-   AlignTab:一个使用正则表达式来帮助对齐的插件
-   Alignment：进行智能对齐
-   All Autocomplete: Extend Sublime Text 2 auto-completion to find matches in all open files of the current window
- Anaconda
-   autofilename:自动关联图片,css,js等资源路径插件
-   AutoFileName: Plugin that auto-completes filenames
-   AutoPEP8：格式化Python代码
-   Autoprefixer插件：这是一款CSS3私有前缀自动补全插件
-   Bootstrap 3 Snippets:A sublime plugin complete with Bootstrap 3 snippets
-   BracketHighlighter: Bracket and tag highlighter
-   Ctags:是一个经典的代码跳转插件
-   ConvertToUTF8:支持 GBK, BIG5, EUC-KR, EUC-JP, Shift_JIS 等编码的插件
    +   Codecs33
-   ColorHighlighter:展示你所选择的颜色代码的真正颜色。同时它还包含一个颜色选择器让你可以方便地更改颜色。
-   Doc​Blockr: Simplifies writing DocBlock comments in Javascript, PHP, CoffeeScript, Actionscript, C & C++
-   Emmet:更快更高效地编写HTML和CSS
-   FileDiffs: Shows diffs between the current file, or selection(s) in the current file, and clipboard, another file, or unsaved changes
-   Git:Plugin for some git integration into sublime text
-   GitGutter: A Sublime Text 2 and 3 plugin to see git diff in gutter
-   QuickGotoAnything
-   Go to definition
-   HTML-CSS-JS Prettify：格式化（美化）html、css、js三种文件类型的插件
-   JavaScript Patterns
-   jQuery:插件强大
-   La​Te​XTools:LaTeX 环境配置以及编译
-   LaTeX-cwl LaTeX 命令的自动补全
-   LaTeXYZ 提供更加智能的数学环境下的自动补全以及快捷键
-   MarkdownEditing
-   Markdown Preview
-   Modific:高亮自上次提交后修改过的代码行（支持Git，SVN，Bazaar，Mercurial以及TFS）
-   MultiEditUtils:该插件用于帮助多重选择下的编辑
-   Origami:可以随心所欲地分割窗口！创建新板块，删除板块，在板块之间移动或复制显示内容。
-   Package Control
-   PackageResourceViewer:查看和编辑SublimeText附带的不同的包
-   PHP Code Beautifier:代码美化插件
-   Pretty JSON
-   Python Auto-Complete: Sublime Text 2 plugin which adds additional auto-completion capability to Python scripts
-   Python Imports Sorter: Sublime Text 2 plugin to organize your imports easily
-   Python PEP8 Autoformat: Python PEP8 auto-format is a plugin to interactively reformat Python source code according to PEP-8
-   PythonTraceback: Easy navigation in your python tracebacks
-   SideBarEnhancements: Enhancements to sidebar. Files and folders.
-   Sftp:代码实时同步到测试服务器插件
-   SublimeTableEditor:markdown表格插件
-   SublimeTmpl：文件模板都在插件目录的SublimeTmpl/templates
    -   command palette 中输入tmpl:
    -   自定义模板路径: "Data\\Packages\\User\\SublimeTmpl\\templates" 目录;默认模版路径: "Data\\Packages\\SublimeTmpl\\templates" 目录
    -   复制默认模版修改
    -   支持 ${date} 变量
-   [SublimeLinter](https://github.com/SublimeLinter/SublimeLinter)：The code linting framework for Sublime Text 3 http://sublimelinter.com
-   SublimeCodeIntel:code intelligence and smart autocomplete engine
-   Sublime​REPL:不同语言命令行模式
-   SublimeLinter-pep8: Linter plugin for python using PEP8
-   SublimeEnhancements
-   TrailingSpaces: Highlight trailing spaces and delete them in a flash
-   Terminal:Sublime中直接使用终端打开你的项目文件夹

```
ctrl+alt+h html
ctrl+alt+j javascript
ctrl+alt+c css
ctrl+alt+p php
ctrl+alt+r ruby
ctrl+alt+shift+p python

|Name|Phone + tab   # 表头
Alt + Shift + 左/右/上/下/ # 删除
Alt + 左/右/上/下/  # 移动

# 在Preferences.sublime-settings 添加
"auto_complete_triggers": [{"selector": "text.html", "characters": "bs3"}]
```

## 通用快捷键

-   Ctrl+Shift+P|⌘⇧P：打开Package Control:Command prompt
-   Ctrl+p： 会列出当前打开的文件（或者是当前文件夹的文件），输入文件名然后 Enter 跳转至该文件
    -   @ 符号跳转：输入 @symbol 跳转到 symbol 符号所在的位置 Ctrl+R
    -   \# 关键字跳转：输入 #keyword 跳转到 keyword 所在的位置
    -   : 行号跳转：输入 :12 跳转到文件的第12行。 Ctrl+G
-   ⌘K, ⌘B 隐藏/打开 侧边栏| Toggle side bar
-   set syntax php：设置高亮语言语法
-   html：ctrl+alt+h php注释 html:5
-   javascript：ctrl+alt+j
-   css：ctrl+alt+c
-   php：ctrl+alt+p
-   ruby：ctrl+alt+r
-   python：ctrl+alt+shift+p
-   新建窗口:Ctrl+Shift+N
-   打开文件:Ctrl+O
-   保存文件:Ctrl+S
-   另存文件:Ctrl+Shift+S
-   关闭文件:Ctrl+W

Ctrl+W：关闭当前打开文件
Ctrl+Shift+W：关闭所有打开文件
Ctrl+Shift+V：粘贴并格式化
Ctrl+D：选择单词，重复可增加选择下一个相同的单词
Ctrl+L：选择行，重复可依次增加选择下一行
Ctrl+Shift+L：选择多行
Ctrl+Shift+Enter：在当前行前插入新行
Ctrl+X：删除当前行
Ctrl+M：跳转到对应括号
Ctrl+U：软撤销，撤销光标位置
Ctrl+J：合并多行成一行
Ctrl+F：查找内容
Ctrl+Shift+F：全项目查找并替换
Ctrl+H：替换
Ctrl+R：前往 method
Ctrl+N：新建窗口
Ctrl+K+B：开关侧栏
Ctrl+Shift+M：选中当前括号内容，重复可选着括号本身
Ctrl+F2：设置/删除标记
Ctrl+/：注释当前行
Ctrl+Shift+/：当前位置插入注释
Ctrl+Alt+/：块注释，并Focus到首行，写注释说明用的
Ctrl+Shift+A：选择当前标签前后，修改标签用的
F11：全屏
Shift+F11：全屏免打扰模式，只编辑当前文件
Alt+F3：选择所有相同的词
Alt+.：闭合标签
Alt+Shift+数字：分屏显示
Alt+数字：切换打开第N个文件
Ctrl+Shift+上下：替换行

### 编辑

* Edit(编辑)
    -   ⌘\[向左缩进 | Left indent
    -   ⌘]向右缩进 | Right Indent
    -   ⌘⌃↑与上一行互换（超实用！）| Swap line up
    -   ⌘⌃↓与下一￼行互换￼（超实用！）| Swap line down
    -   ⌘⇧D复制粘贴当前行（减少多余的粘贴）| Duplicate line
    -   ⌘J拼接行（css格式化时挺有用） | join lines
    -   ⌘←去往行的开头 | Beginning of line
    -   ⌘→去往行末尾 | End of line
    -   ⌘⌃/块注释 | Toggle comment block
    -   ⌃K从光标开始的地方删除到行尾 | Delete to end
    -   ⌃⇧K删除一整行 | delete line
    -   ⌃T相邻单词互换位置，在','前试用| Transpose
    -   ⌘⇧↩向光标前插入一行|insert line before
    -   ⌘↩向光标后插入一行|inter line after
    -   ⌘⌥T插入特殊字符|Special characters
    -   ⌃D向后删除
* Selection(光标选中)
    - ⌘D选中相同的词 | Expand selection to words
    - ⌃⌘G多重文本光标选中| Expand all selection to words
    - ⌘L选中一行|Expand selection to lineEsc单选（取消多重选择）|Single selection,Cancel multiple selections
    - ⌃⇧↑一行一行向上选中|Add previous line
    - ⌃⇧↓一行一行向下选中|Add next line
    - ⌘⇧L将选中的区域分割成多行选中状态(多光标操作状态)|Split into lines
    - ⌥+拖动鼠标多重光标选中⌘⇧J已缩进层级为依据，一层层向外选中|Expand selection to indentation
    - ⌃⇧M将匹配括号中的内容选中|Expand selection to brackets
* Find(查找)
    - ⌘F普通查找|Find
    - ⌘G查找下一个|Find next
    - ⌘⇧G查找上一个|Find prev
    - ⌘⇧F在文件夹中查找| Find in files
    - ⌘⇧E缓存用于替换的内容，方便之后的替换|Use selection for replace
    - ⌘E缓存用于查找的内容，方便之后的查找|Use selection for find
    - ⌘⌥E一个接一个往下替换|Replace next
* View(视图):推荐使用Origami插件，可以随意对sublime进行分割
* Go to(跳转/定位)
    - ⌘P跳转文件（很方便）| Go to anything
    - ⌘R定位文件中的方法@| Go to symbol
    - ⌘G定位文件中的行号:| Go to line
    - ⌃M定位匹配的括号 | Jump to matching bracket
    - ⌘F2设置/取消定位标记| Toggle bookmark
    - F2跳转到定位标记处 | Next bookmark
    - ⌘⇧F2清除所有定位标记| Clear all bookmarks
    - ⌘⌥→下一个打开的文件| Next file
    - F12:goto_definition
* Project(工程)
    - ⌘⌃P在保存过的工程中切换，随意变换工程环境|Switch project window
* Tabs（标签栏）
    ⌘⇧t 打开最后一次关闭的文件|Open last closed tab
    ^Tab 循环遍历tab|Cycle up through tabs
    ^⇧Tab 反方向循环遍历tab|Cycle down through tabs

-   多行同时编辑：选中行数 ctrl+shift+L
-   选词： 选中文本 逐个添加：ctrl+d
-   全部选中 alt+f3 control + commond + G
-   合并行：Ctrl+J
-   换行：alt+q
-   选择整行：Ctrl+L
-   同时编辑不同文本： ctrl 选中不同文本
-   竖行选中： shift+鼠标右键
-   添加新行：ctrl+enter ctrl+shift+enter
-   缩进与反缩进：ctrl+[, ctrl+]
-   复制当前行：ctrl+shift+d
-   删除当前行：ctrl+shift+k
-   粘贴保持样式：ctrl+shift+v
-   移动行：ctrl+shift+↑ ↓
-   添加或删除注释：ctrl+/
-   获取{}中内容：ctrl+shift+m
-   移动{}开始与结束：ctrl+m
-   F9：行排序(按a-z，大小写敏感)
-   shift+f9：行排序(按a-z，大小写不敏感)
-   从光标处删除至行首：Ctrl+K Backspace
-   从光标处删除至行尾：Ctrl+K k
-   改为大写：Ctrl+K+U
-   改为小写：Ctrl+K+L
-   折叠与展开代码：ctrl+shift+[,]
-   折叠与展开属性：ctrl+k+t,0
-   撤销：ctrl+z,y，u
-   重做ctrl+y
-   恢复ctrl+u
-   开关宏记录：Ctrl+Q
-   运行宏：Ctrl+Shift+Q
-   词互换：ctrl+t
-   做运算：ctrl+shift+y
-   数字步增：ctrl+↑ ↓
-   以单词粒度移动光标：alt+left/right
-   以整行移动：ctrl+left/right
-   左右选择：alt+shift+left/right
-   上下选择：shift+up/down
-   Ctrl + M 可以快速的在起始括号和结尾括号间切换
-   Ctrl + Shift + M 则可以快速选择括号间的内容
-   对于缩进型语言（例如Python）则可以使用 Ctrl + Shift + J
-   Ctrl + Enter：在当前行下面新增一行然后跳至该行
-   Ctrl + Shift + Enter：在当前行上面增加一行并跳至该行
-   Ctrl + ←/→：进行逐词移动
-   Ctrl + Shift + ←/→进行逐词选择
-   Ctrl + ↑/↓移动当前显示区域
-   Ctrl + Shift + ↑/↓移动当前行

### 查找与跳转

使用模糊字符串匹配（Fuzzy String Matching）

-   Ctrl + R 会列出当前文件中的符号（例如类名和函数名，但无法深入到变量名），输入符号名称 Enter 即可以跳转到该处。
-   可以使用 F12 快速跳转到当前光标所在符号的定义处（Jump to Definition）。
-   直接查找文件
-   @symbol跳转到symbol符号所在的位置（函数）
-   `# 关键字跳转：输入#keyword跳转到keyword所在的位置`
-   行号跳转：输入:12跳转到文件的第12行（ctrl+g）
-   对于 Markdown， Ctrl + R 会列出其大纲

### 显示

-   分屏：Alt + Shift +数字
    -   Alt + Shift + 2 进行左右分屏
    -   Alt + Shift + 8 进行上下分屏
    -   Alt + Shift + 5 进行上下左右分屏
    -   Ctrl + 数字键 跳转到指定屏，Ctrl + 1 会跳转到1屏
    -   Ctrl + Shift + 数字键 将当前屏移动到指定屏。Ctrl + Shift + 2 会将当前屏移动到2屏
-   ctl+shift+n:切组
-   切栏：alt+数字
-   分割或合并窗口：ctrl+k ctrl+↑ ↓ 左右切换窗口
-   新建文件到分割窗口：ctrl+k，Ctrl+Shift+↑
-   Ctrl + Shift + N 创建一个新窗口
-   Ctrl + W:关闭窗口
-   Ctrl + Shift + T 恢复刚刚关闭的标签
-   F11 切换普通全屏
-   Shift + F11 切换无干扰全屏

### 管理

-   切换标签：ctrl+tab
-   切换侧栏：ctrl+k ctrl+b
-   恢复标签：ctrl+shift+t

### html

-   激发zencoding控制台:ctrl+alt+enter
-   默认标签为div:.container #container
-   获取模板：输入! ctrl+e
-   闭合标签：alt+.
-   移除父标签：ctrl+shift+;
-   添加标签：ctrl+shift+g
-   全屏：f11
-   免打扰：shift+f11
-   后代：ul>li .wrap>ul.list>.sites
-   兄弟：div+p+bq
-   分组：div>(header>ul>li\*2>a)+footer>p
-   乘法：li\*5
-   向上一层：.warp>p>a^p .warp>p>a^^p
-   a[href="<http://www.baidu.com"]{百度}>
-   递增：
-   包含多个类：p.class1.class2.class3
-   自定义属性：p[title='hello'] td[rowspan=2 colspan=3 title]
-   section#block$\_3>h2.title+p.words_2
-   文本：{}
-   隐标签：ul>.class table>.row>.col
-   a:link a:mail meta:utf
-   form：get


    ul>li.item${item$$}*5
    h$[title=item$]{Header $}*3(添加属性)
    ul>li.item$$$*5(多个占位符)
    ul>li.item$@-*5(逆序)
    ul>li.item$@3_5(定位起始符) div#v$@3_5

#### 选择类

-   Ctrl+D选中光标所占的文本,继续操作则会选中下一个相同的的文本，再次 Ctrl + D 或者 Shift + ←/→ 选择该词出现的下一个位置，在多重选词的过程中，使用 Ctrl + K 进行跳过，使用 Ctrl + U 进行回退，使用 Esc 退出多重编辑
-   ctrl+G:输入行号,可快速跳转该行
-   ctrl+p:输入冒号,在输入行号，可快速跳转到某一行
-   F3 跳到其下一个出现位置， Shift + F3 跳到其上一个出现位置
-   Alt+F3选中文本按下快捷键,即可一次性选择全部相同的文本进行同时编辑:举个例子:快速选中并更改所有相同的变量名和函数名等
-   Ctrl+L:选中整行,继续操作则继续选择下一行,效果和shift+向下箭头效果一样
-   Ctrl+shift+L:先选中多行,在按下快捷键,会在每行行尾插入光标,即可同时编辑这行
-   Ctrl+Shift+M 选择括号内的内容（继续选择父括号）。举个栗子：快速选中删除函数中的代码，重写函数体代码或重写括号内里的内容
-   Ctrl+M 光标移动至括号内结束或开始的位置
-   Ctrl+Enter 在下一行插入新行。举个栗子：即使光标不在行尾，也能快速向下插入一行
-   Ctrl+Shift+Enter 在上一行插入新行。举个栗子：即使光标不在行首，也能快速向上插入一行
-   ctrl+shift+\[:选中代码,按下快捷键,折叠代码
-   ctrl+shift+]:选中代码,按下快捷键,展开代码
-   Ctrl+k+0:展开所有折叠代码
-   ctrl+←:向左单位性地移动光标,快速移动光标
-   ctrl+→:向右单位性移动光标,快速移动光标
-   shift+↑ 向上选中多行
-   shift+↓ 向下选中多行
-   Shift+← 向左选中文本
-   Shift+→ 向右选中文本
-   Ctrl+Shift+← 向左单位性地选中文本
-   Ctrl+Shift+→ 向右单位性地选中文本
-   Ctrl+Shift+↑ 将光标所在行和上一行代码互换（将光标所在行插入到上一行之前）
-   Ctrl+Shift+↓ 将光标所在行和下一行代码互换（将光标所在行插入到下一行之后）
-   Ctrl+Alt+↑ 或Ctrl+Alt+鼠标向上拖动 向上添加多行光标，可同时编辑多行
-   Ctrl+Alt+↓或Ctrl+Alt+鼠标向下拖动 向下添加多行光标，可同时编辑多行
-   多重选择功能允许在页面中同时存在多个光标,让很多本来需要正则表达式,高级搜索和替换才能完成的的任务也变得游刃有余了 激活多重选择的方法有两及种:
-   按住ctrl然后在页面中希望中现光标的位置点击
-   选择数行文本,然后按下shift+ctrl+L
-   通过反复按下ctrl+D即可将全文中与光标当前所在位置的词相同的词逐一加入选择,而直接按下Alt+F3即可一次性选择所有相同的词
-   按下鼠标中键来进行垂直方向的纵列选择,也可以进入多重编辑状态

#### 编辑类

-   Ctrl+J:合并选中多行代码为一行:将多行格式的css属性合并为一行
-   ctrl+shift+D:复制光标所在的整行,插入到下一行
-   Tab 向右缩进。只对光标后（或者选中的）的代码有效
-   Shift+Tab 向左缩进
-   Ctrl+\[ 向左缩进。对整行有效
-   Ctrl+] 向右缩进。对整行有效
-   Ctrl+K+K 从光标处开始删除代码至行尾。按住Ctrl，按两次K
-   Ctrl+Shift+K 删除整行
-   Ctrl+/ 注释单行
-   Ctrl+Shift+/ 注释多行
-   Ctrl+K+U 转换大写
-   Ctrl+K+L 转换小写
-   Ctrl+Z 撤销
-   Ctrl+Y 恢复撤销
-   Ctrl+U 软撤销，感觉和 Gtrl+Z 一样
-   Ctrl+F2 设置书签，F2切换书签
-   Ctrl+T 左右字母互换

#### 搜索类

-   Ctrl+F 打开底部搜索框，查找关键字:存在不同的匹配模式
    -   Alt + R 切换正则匹配模式的开启/关闭
    -   Alt + C 切换大小写敏感（Case-sensitive）模式
    -   Alt + W 切换整字匹配（Whole matching）模式
-   Ctrl+shift+F 在文件夹内查找，与普通编辑器不同的地方是sublime允许添加多个文件夹进行查找
-   `"auto_find_in_selection": true`:范围内搜索
-   在搜索框输入关键字后 Enter 跳至关键字当前光标的下一个位置， Shift + Enter 跳至上一个位置， Alt + Enter 选中其出现的所有位置
-   Ctrl + H 进行替换
-   Ctrl + H 进行标准替换，输入替换内容后，使用 Ctrl + Shift + H 替换当前关键字， Ctrl + Alt + Enter 替换所有匹配关键字。
-   Ctrl+P 打开搜索框。举个栗子
    -   输入当前项目中的文件名，快速搜索文件
    -   输入@和关键字，查找文件中函数名
    -   输入：和数字，跳转到文件中该行代码
    -   输入#和关键字，查找变量名
-   Ctrl+G 打开搜索框，自动带：，输入数字跳转到该行代码。举个栗子：在页面代码比较长的文件中快速定位
-   Ctrl+R 打开搜索框，自动带@，输入关键字，查找文件中的函数名。举个栗子：在函数较多的页面快速查找某个函数
-   Ctrl+: 打开搜索框，自动带#，输入关键字，查找文件中的变量名、属性名等
-   Esc 退出光标多行选择，退出搜索框，命令框
-   Ctrl+Shift+P 打开命令框。场景栗子：打开命名框，输入关键字，调用sublime text或插件的功能，例如使用package安装插件

#### 格式化

-   Ctrl + \[ 向左缩进
-   Ctrl + ] 向右缩进
-   Ctrl + Shift + V 可以以当前缩进粘贴代码

### 检查

-   F6: 开启/关闭拼写检查
-   Ctrl+F6: 定位下一个拼错
-   Ctrl+Shift+F6: 定位上一个拼错

### 注释

-   行注释：Ctrl+/
-   块注释：Ctrl+Shift+/

### 构建build

-   构建：ctrl+b
-   运行：ctrl+shift+b

```json
{
    "shell_cmd": "make",
    "cmd" : ["gcc $file_name -o ${file_base_name}"],
    "shell" : true,
    "working_dir" : "$file_path",
    "variants" :
    {
        "name" : "Run",
        "cmd" : "./${file_base_name}"
    }
}

# 生效有延时,配置php环境变量
{
    "cmd": ["php", "$file"],
    "file_regex": "php$",
    "selector"  : "source.php"
}
```

### 主题theme

-   material
-   Monokai Pro
-   [SpaceGray](https://github.com/kkga/spacegray/)
-   [allanhortle/Centurion](https://github.com/allanhortle/Centurion)
-   [kkga/spacegray](https://github.com/kkga/spacegray):A Hyperminimal UI Theme for Sublime Text <http://kkga.github.io/spacegray>
- [ihodev/sublime-boxy](https://github.com/ihodev/sublime-boxy):It Was the Most Hackable Theme for Sublime Text 3

```
Package Control ‣ Install Package ‣ Theme - Monokai Pro
Command Palette ‣ Monokai Pro: select theme
```

### [代码段（Code Snippets）](http://www.jianshu.com/p/356bd7b2ea8e)

Snippet可以存储在任何的文件夹中, 并且以.sublime-snippet为文件扩展名, 默认是存储在.sublime-snippet文件夹下.snippet四个组成部分:

-   content:其中必须包含<![CDATA[...]]>,否则无法工作, Type your snippet here用来写你自己的代码片段
-   tabTrigger:用来引发代码片段的字符或者字符串, 比如在以上例子上, 在编辑窗口输入hello然后按下tab就会在编辑器输出Type your snippet here这段代码片段
-   scope: 表示你的代码片段会在那种语言环境下激活, 比如上面代码定义了source.python, 意思是这段代码片段会在python语言环境下激活.
-   description :展示代码片段的描述, 如果不写的话, 默认使用代码片段的文件名作为描述
-   环境变量
-   fields:通过tab键循环的改变代码片段的一些值
-   snippet镜像区域,会使相同编号的位置同时进行编辑:系统$n -snippet Placeholders:添加默认值，占位符设置嵌套

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

### 配置同步

[配置同步:同步Packages/User文件夹](https://packagecontrol.io/docs/syncing)

#### 通过共享文件

-   清除 Packages 目录下User
-   `ln -s ~/baiduyunebooks/sublime3/Packages/User User` // 建立符号链接

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

#### 通过sync-setting配置

-   新建github的token
-   安装syn-setting插件
-   配置文件，主进程download，其它更新

## 参考

- [官网](http://www.sublimetext.com/3)
- [总结配置](https://github.com/jikeytang/sublime-text)
-   [sublime-undocs](http://docs.sublimetext.info/en/latest/index.html#)
-   [精通 Sublime Text](http://laravelacademy.org/post/6711.html)
-   [文档](http://www.sublimetext.com/docs/3)
-   [Sublime Text 全程指南](http://lucida.me/blog/sublime-text-complete-guide/)
-   [非官方文档](http://sublime-text-unofficial-documentation.readthedocs.org/)

## 问题

markdown-editing无法snipeet,语法高亮：移除JavaScriptNext Package

