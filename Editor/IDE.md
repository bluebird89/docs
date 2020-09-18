# IDE

* CLion:专为C/C++所创建的跨平台IDE
* AppCode:用于帮助开发 Mac、iPhone 和 iPad 的应用程序
* RubyMine:供了一个综合的Ruby编码编辑器
* [Komodo IDE](https://www.activestate.com/)
* [visualfc/liteide](https://github.com/visualfc/liteide):LiteIDE is a simple, open source, cross-platform Go IDE.
* [CodeSandbox](https://codesandbox.io/)
  - [CompuIves/codesandbox-client](https://github.com/CompuIves/codesandbox-client):An online code editor tailored for web application development 🏖️ https://codesandbox.io
* [stackblitz/core](https://github.com/stackblitz/core):Online IDE powered by Visual Studio Code ⚡️ https://stackblitz.com
* [theia-ide/theia](https://github.com/theia-ide/theia):Theia is a cloud & desktop IDE framework implemented in TypeScript. http://theia-ide.org

generate:Alt+ins

## 配置

* 依赖指定版本
* `.local/share/JetBrains/Toolbox/apps/`
* `.cache/JetBrains/PhpStorm2020.2/log/`
* JVM Options
  - sucked in X11 input-methods related function
  - `.local/share/JetBrains/Toolbox/apps/PhpStorm/ch-0/202.6948.87.vmoptions`
  - -Dawt.ime.disabled=true

## Tips

* 打印统一 keyMap

## PHPStrom

* ubuntu 下载文件含有安装文档,安装文件会自动启动脚本/usr/local/bin/pstorm,IDE启动需要占用单独进程终端，可以`pstorm&`启动
* 配置文件: 会在根目录下生成文件夹./php，其中有config and system, 自定义配置：Create the file "idea.properties" and open it in an editor. Set theidea.system.path and/or idea.config.path variables as desired, for example:
* plugin
  - Save Actions
* Diagrams
  - Project tool window->right-click ->Diagrams | Show Diagram
*  Navigate shift+shift
  -  Class 代表类
  -  File 代表文件
  -  Symbol 代表符号/标记（可用于导航到指定变量、方法）
  -  Line ctrl + G
  -  自定义搜索作用域
*  File and Code Templates 文件代码模版 :Command + Shift + A 调出 Action 导航界面，在输入框输入 templates，在下拉列表中选中「File and Code Templates」
*  代码片段模版:Live Templates
*  Option 键（Windows 系统是 Alt 键:锚定多个光标的方式同时编辑多处文本,  Ctrl + G
*  debug
  -  F7:step into 单步执行
  -  在 variable  添加 Watch
* Xdebug 进行断点调试
  - 配置:以便可以接收到服务端的远程调试连接，首先在 Preferences | Languages & Frameworks | PHP | Debug 中配置 Debug 端口与 Xdebug 扩展配置保持一致
  - 在 Preferences | Languages & Frameworks | PHP | Servers 中新增服务器配置（域名和端口与对应的 PHP Web 应用保持一致即可）
  - Run 下拉菜单中点击「Start Listening for PHP Debug Connections」启动监听
  - f8
* Preferences | Directories:根命名空间与指定目录的映射
* PHP CS Fixer批量修正
  - Preferences | Tools | External Tools 界面点击「+」
  - fix $FileDir$ --rules=@PSR2
  - $ProjectFileDir$
  - 右键-> External Tools->PHP CS Fixer
* ctrl+ ` :View -> Quick Switch Scheme... 快速切换主题

## 快捷键

- 项目名右键选择"Local History | Show History"可查看本地修改记录
- Ctrl + E 可查看最近打开文件或项目
- 打开File | Setting | Editor，选择Appearance下面的Show Method Separators。它会将你的代码按方法，用灰色线框进行智能分割。你还可以使用：alt+↑或↓，在方法之间进行跳转
- Ctrl + Shift + V／Command+shift+V，可选择要粘贴的历史
- Command+delete 删除删除当前行，并把下一行代码上移
- Ctrl + D，复制粘贴选中的文本
- Ctrl + Y，删除当前行或选中行
- Ctrl + Alt + 左右方向键，定位到上一次编辑的位置
- Alt + 上下方向键，跳转到上/下函数
- Alt + 左右方向键，导航标签切换
- Ctrl + N，根据类名称查找
- Ctrl + Shift + N，根据文件名查找
- Ctrl + Shift + Alt + N，根据函数名查找
- Ctrl + Shift + F，Find in Path
- Ctrl + Shift + I，查看变量初始化的值
- Ctrl + F12，快速查看当前文件的所有方法
- Ctrl + /，单行注释
- Ctrl + Shift + /，多行注
- 修改默认打开的文件模版："file" ---> "setting" ---> "file and code template"
- /** + Enter，自动生成注释
- Ctrl + Alt + L，格式化代码
- ctrl + shift + n: 打开工程中的文件
- ctrl + j: 输出模板
- ctrl + b: 跳到变量申明处
- ctrl + alt + T: 围绕包裹代码(包括zencoding的Wrap with Abbreviation), ctrl + shift + del: 删除包裹
- ctrl + []: 匹配 {}[]
- ctrl + F12: 可以显示当前文件的结构，快速跳转到目标函数
- ctrl + x: 剪切行
- alt + left/right:标签切换
- ctrl + r: 替换 ctrl + shift + r: 全局替换
- ctrl + shift + up: 行移动
- shift + alt + up: 块移动
- ctrl + d: 行复制
- ctrl + shift + ]/[: 选中块代码
- ctrl + / : 单行注释
- ctrl + shift + / : 块注释
- ctrl + shift + i : 显示当前class,function的详细信息
- ctrl + p: 显示默认参数
- ctrl + shift + v: 可以复制多个文本
- shift + enter: 智能跳到下一行 ctrl + alt + enter: 在上一行添加空白行vb
- ctrl + k: svn 提交
- ctrl + shift + u: 大小写
- ctrl + ~ : 切换主题
- ctrl + F11: 添加标签 ctrl + shift + 大键盘数字键, F11:添加空标签, shift+F11:显示标签列表，方便快捷跳转
- ctrl + alt + F12: file path
- ctrl + alt + a: search keymap
- shift + F6: 重构标签名
- Ctrl+delete 删除光标后面的单词
- Ctrl+BackSpace 删除光标前面的单词
- Ctrl+ +/- 折叠/展开代码
- Ctrl + Alt + V 快速引进一个变量
- Ctrl+Alt + I 自动对齐格式
- alt+j: 多选单个单词
- ctrl+alt+m: 重构函数
- Control+Shift+J 把下面一行缩上来变成一行
- shift+enter 快速换行，代码不折行
- Command+shift+U 大小写转换
- Command+w 关闭当前文件选项卡
- alt+/ 代码补全
- command + shift + a:
- command + shift + n:

自定义：

1. alt + d :show in explorer
2. alt + c: 删除单行
3. alt + s: 注释单行
4. alt + b: open in browser
5. shift + space: suggest path
6. 全屏的快捷键是 ` ，就是esc下面的那个键
7. F1: project
8. split line: ctrl+alt+enter, before current:ctrl+enter
9. new line: shift + enter, before current : ctrl + enter
10. alt + F11: 焦点从编辑区到工具区 Jump to last tool window
11. alt + p: surround with
12. alt+1: hide active tool window
13. alt+U: upload file to ftp
14. alt+T: show toolbar
15. alt + L : show history 查看本地历史记录

## mac

* command + 左键：代码定义处
* Command+F 搜索
* Command+R 替换
* Command+G 查找下一个
* Command+shift+G 查找下一个
* Command+shift+F 按路径搜索
* Command+shift+R 按路径替换
* Command+O 跳转到某个类
* Command+shift+O 跳转到某个文件
* Command+alt+O 跳转到某个符号
* F12 打开之前打开的工具窗口（TODO、终端等）
* Command+L 弹出输入框，指定跳转到第几行
* Command+E 弹出对话框，可以选择最近打开过的文件
* Command+B 跳转到变量声明处
* Control+J 获取变量或函数相关信息（类型、注释等，注释是拿上一行的注释）
* Command+Y 小浮窗显示变量或函数声明时的行
* F2,shift+F2 切换到上\下一个突出错误的位置
* F3 添加书签
* alt+F3 添加带助记的书签
* alt+1,alt+2... 切换到相应助记的书签位置
* Command+F3 打开书签列表
* 双击shift 弹出小浮窗搜索所有
* Command+1,Command+2... 打开各种工具窗口
* Command+~切换项目 Command+shift+~ 反向切换项目 (在打开的不同项目中切换) -
* 全局搜索（command + shift + F）
* 显示类中的方法 （command + 7）
* 函数追踪 （command +鼠标点击）
* 单行注释/取消（command + /）
* 输入行号跳到某一行（command + l）
* 列出打开的文件（command + e）
* 删除当前行（command + x）
* 复制当前行（command + d）
* 跳到变量申明处（command + b）
* 格式化代码（command + option + l）
* 关闭当前窗口 （command + w）
* 项目刷新 （command + option + y）
* 多行注释（command + option + /）
* 查找//@todo标签（command + 6）
* 列出左侧文件（command + 1）
* 切换大小写（command + shift + u）
* 复制（command + c）
* 粘贴（command + v）
* 撤销（command + z）
* 配置文件头默认注释:IDE settings->Editor->File and Code Templates->PHP File Header。
* 设置注释不顶格:IDE settings->Editor->Code Style->PHP 去掉勾 Line comment at first column。
* 去掉右上角浏览器:IDE settings->tools ->WebBrowsers  去掉选中即可。
* PHPStorm + CodeSniffer设置:IDE settings->Languages & Frameworks->PHP->CodeSniffer-> 配置即可。
* 选择编码规范:IDE settings->Editor->Inspections->PHP->PHP Code Sniffer validation(打钩) ->Coding Standard 选择规范（PEAR）。
* 下载地址:http://pear.php.net/package/PHP_CodeSniffer/

* double shift：搜索文件
* alt + 1:项目试图切换
* command + shift + n：打开输入的文件
* command + e :最近文件

## 编辑

* Command+alt+T 用 (if..else, try..catch, for, etc.)包住
* alt+↑ 向上选取代码块
* alt+↓ 向下选取代码块
* Command+alt+L 格式化代码
* Control+alt+I 快速调整缩进
* Command+D 复制代码副本
* Command+delete 删除当前行
* Control+Shift+J 清除缩进变成单行
* shift+回车 快速换行
* Command+回车 换行光标还在原先位置
* Command+shift+U 大小写转换
* Command+shift+[,Command+shift+] 文件选项卡快速切换
* Command+加号,Command+减号 收缩代码块
* Command+shift+加号，Command+shift+减号 收缩整个文档的代码块
* Command+W 关闭当前文件选项卡
* alt+单击 光标在多处定位
* Control+shift+J 把下面行的缩进收上来
* shift + F6 高级修改，可快速修改光标所在的标签、变量、函数等
* alt+/ 代码补全
* Control+alt+R 运行项目
* Command+Control+R 运行Debug
* Command+F8 添加断点
* Command+shift+F8 打开断点列表

## 导航

* Command+O 跳转到某个类
* Command+shift+O 跳转到某个文件
* Command+alt+O 跳转到某个符号
* Control+←,Control+→ 转到上/下一个编辑器选项卡
* F12 打开之前打开的工具窗口（TODO、终端等）
* Command+L 跳转行
* Command+E 弹出最近文件
* Command+alt+←,Command+alt+→ 向前向后导航到代码块交接处（一般是空行处）
* Command+shift+delete 导航到上一个编辑位置的位置
* Command+B 跳转到变量声明处
* Control+J 获取变量相关信息（类型、注释等，注释是拿上一行的注释）
* Command+Y 小浮窗显示变量声明时的行
* Command+[,Command+] 光标现在的位置和之前的位置切换
* Command+F12 文件结构弹出式菜单
* alt+H 类的层次结构
* F2,shift+F2 切换到上\下一个突出错误的位置
* Command+↑ 跳转到导航栏
* F3 添加书签
* alt+F3 添加带助记的书签
* alt+1,alt+2... 切换到相应助记的书签位置
* Command+F3 打开书签列表

## 版本控制

* control+V 打开VST小浮窗
* Command+K 提交项目
* Command+T 更新项目
* alt+shift+C 打开最近修改列表

* 添加版本信息分组:名词
* 提交时添加动词

## 重构

* F5 复制文件到某个目录
* F6 移动文件到某个目录
* Command+delete 安全删除
* shift+F6 重命名

## 功能

* REST Client：Tools | Test RESTful Web Service
    - Generate Authorization Header
    - Alt+Insert (CMD+N on Mac OS X) will add a new cookie
* command-line tool
    - Project Settings | Command Line Tool Support
    - Tools | Run Command... menu or with Ctrl+Shift+X
* MAMP
* DataBase:MySQL
    - SQL Editor
    - ?, :variable, @variable, #variable# or $variable$：设置语句参数
    - control+j:查看单条数据
* vagrant
    - Init in Project Root
    - Start SSH session

## IDEA

* 可以自动生成对应的Junit方法:  ALT+SHIFT+T
* 最近修改过的文件: Ctrl+E
* 定位类: ctrl+n
* 定位文件: ctrl + shift +n
* 定位函数或者属性 ctrl + shift + alt +n
* 字符串 ctrl + shift + f
* 大小写 ctrl+shift+u
* 列操作 ctrl+shift+alt +j
* 插件
  - Alibaba Java Code Guidelines—阿里巴巴 Java 代码规范
  - Alibaba Cloud Toolkit
  - CamelCase-多种命名格式之间切换
  - Codota—代码智能提示
  - GsonFormat+RoboPOJOGenerator—JSON转类对象
  - GitToolBox
  - IDE Features Trainer—IDEA交互式教程
  - Key Promoter X—快捷键
  - Lombok
  - Presentation Assistant—快捷键展示
  - RestfulToolkit—RESTful服务开发
  - SequenceDiagram
  - Statistic—项目信息统计
  - Translation-必备的翻译插件
* [IntelliJ IDEA config](https://www.jianshu.com/p/320d82d405ad)
* Diagrams
* theme
  - Dark Purple Theme
  -  Cyan Light Theme
* ctrl + `
  - 5 switch theme
  - 1 Editor Color Scheme
  - 3 keymap

数据是统一的，能够实现批量处理

## Refactor

* 变量/属性
* 函数/方法
* 在父子类之间转移方法
* 接口

## postfix

* ALT+ENTER
* 自动创建实现类
* 导包
* 格式化输出数据
* 修正单词拼写

## macro

* selects all the lines (Ctrl+A), formats (Ctrl+Alt+L), deselect all (Up and Down arrow) and saves a file (Ctrl+S), and bind this macro to Ctrl+S.
  - Edit > Macros > Start Macro recording
  - Press Ctrl+A, then Ctrl+Alt+L, then Up arrow, then Down arrow, and finally then Ctrl+Alt+Shift+S
  - Stop recording the macro clicking on the Stop button on the bottom right of the page.
  Give this macro a name like "Format and Save"

## plugin

* IdeaVim
  - key map:Editor->Vim Emulation

## action

* 通过锚定多个光标的方式同时编辑多处文本:按住 Option 键（Windows 系统是 Alt 键），将光标移动到其他要编辑的文本起始位置
* 分割窗口

## 问题

```
# The current inotify(7) watch limit is too low
#  /etc/sysctl.conf
fs.inotify.max_user_watches = 524288
```

## 工具

* [Microsoft/monaco-editor](https://github.com/Microsoft/monaco-editor):A browser based code editor https://microsoft.github.io/monaco-editor/
* [cdoco/jetbrains-license-server](https://github.com/cdoco/jetbrains-license-server):已废弃
* [激活](https://www.jianshu.com/p/133af2e4fe3f): 修改host 0.0.0.0 account.jetbrains.com  去http://idea.lanyus.com/ 生存激活码
* [LightTable/LightTable](https://github.com/LightTable/LightTable):The Light Table IDE ⛺ http://www.lighttable.com
* [申请免费使用](https://www.jetbrains.com/shop/eform/opensource?product=ALL)
* [ChrisRM/material-theme-jetbrains](https://github.com/ChrisRM/material-theme-jetbrains#installation):JetBrains theme of Material Theme

## 参考

* [confluence](https://confluence.jetbrains.com/display/PhpStorm)
