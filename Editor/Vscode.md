# [vscode](https://github.com/Microsoft/vscode)

Visual Studio Code <https://code.visualstudio.com>

## 安裝

```sh
# download file
sudo dpkg -i <file>.deb
sudo apt-get install -f # Install dependencies

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

sudo apt-get update
sudo apt-get install code
```

## 插件

* advanced-new-file
* Apollo GraphQL
* Auto Close Tag
* Auto Rename Tag
* Auto Import:自动去查找、分析、然后提供代码补全。对于TypeScript和TSX
* Bracket Pair Colorizer
* Beautify
* C/C++
* CSS Peek
* Change Case
* Code Runner
* Color Highlight
* Color Info
* Color Picker
* Code Spell Checker
* [vscode-debug-visualizer](https://github.com/hediet/vscode-debug-visualizer)
* Debugger for Chrome
* Document This
* advanced-new-file
* EditorConfig for VS Code
* Emmet
* ESLint
* Eva Theme
* Faker
* File Utils
* Flutter
* [foam](https://github.com/foambubble/foam):A personal knowledge management and sharing system for VSCode
* gi:给 .gitignore 文件添加各种语言忽略文件配置
* Git Blame
* Git History
* GitLens
* Git Project Manager
* Go
* HTML Boilerplate
* Import Cost
* Icon Fonts
* IntelliSense for CSS class names in HTML
* Language and Framework Packs
    - React Native Tools
    - Vue 2 Snippets
* Laravel Blade Snippets
* Live Server
* Indent-Rainbow:使得对齐更加具有可读性
* IntelliCode, Microsoft’s tool for AI-assisted coding
* JavaScript (ES6) code snippets
* Jest
* Minify
* Markdownlint
* npm Intellisense
* Open-In-Browser
* Path Intellisense
* Prettier
* Polacode 可以把代码生成图片
* PHP IntelliSense
* [prettier/prettier](https://github.com/prettier/prettier):Prettier is an opinionated code formatter. https://prettier.io
* Quokka.js
* React Native Tools
* Reactjs code snippets
* Regex Previewer
* Remote
* Settings Sync
    - [shanalikhan/code-settings-sync](https://github.com/shanalikhan/code-settings-sync):🌴💪 Synchronize your Visual Studio Code Settings Across Multiple Machines using Github GIST 💪🌴
    - ALT+SHIFT+D 下载配置
    - ALT+SHIFT+U 上传配置
* snippets
* Stylelint
* Sublime Text Keymap and Settings Importer
* SVG Viewer
* TODO Highlight
* Todo Tree
- Trello Viewer
* Trailing Spaces
* TSLint
* TypeScript Hero
* Vetur
* vscode-icons
* VS Live Share
* vscode-pandoc:文档生成
* View In Browser
* WakaTime
* vscode-leetcode

## 主题

* One Monokai
* Aglia
* One Dark Pro
* Material Theme
* Material Icon Theme
* An Old Hope Theme

## 配置

## vim

* 编辑html
    - dit 删除标签内部的内容。
    - cit 删除 标签内部的内容并切换到insert模式。
    - yit 复制 标签内部的内容。
    - vit 选中标签内部的内容。
    - vat 选中标签以及内部的内容。
    - di) yi) ci):删除 修改 复制括号 () 引号内部的内容
    - da) ya) ca) #通知删除 括号

### 左边列表

-   File explorer: `command + shift + E`
-   Search across files: `command + shift + F`
-   Source code management `command + shift + G`
-   launch and debug `command + shift + d`
-   Manage extensions `command + shift + x`
-   `shift+cmd+m`

### [快捷键](https://code.visualstudio.com/shortcuts/keyboard-shortcuts-windows.pdf)

* general
    - ⇧⌘P, F1 Show Command Palette
    - ⌘P Quick Open, Go to File…
    - ⇧⌘N New window/instance
    - ⌘W Close window/instance
    - ⌘, User Settings
    - ⌘K ⌘S Keyboard Shortcuts
* Basic editing
    - ⌘X Cut line (empty selection)
    - ⌘C Copy line (empty selection)
    - ⌥↓ / ⌥↑ Move line down/up
    - ⇧⌥↓ / ⇧⌥↑ Copy line down/up
    - ⇧⌘K Delete line
    - ⌘Enter / ⇧⌘Enter Insert line below/above
    - ⇧⌘\ Jump to matching bracket
    - ⌘] / ⌘[ Indent/outdent line
    - Home / End Go to beginning/end of line
    - ⌘↑ / ⌘↓ Go to beginning/end of file
    - ⌃PgUp / ⌃PgDn Scroll line up/down
    - ⌘PgUp /⌘PgDn Scroll page up/down
    - ⌥⌘[ / ⌥⌘] Fold/unfold region
    - ⌘K ⌘[ / ⌘K ⌘] Fold/unfold all subregions
    - ⌘K ⌘0 / ⌘K ⌘J Fold/unfold all regions
    - ⌘K ⌘C Add line comment
    - ⌘K ⌘U Remove line comment
    - ⌘/ Toggle line comment
    - ⇧⌥A Toggle block comment
    - ⌥Z Toggle word wrap
* Multi-cursor and selection
    - ⌥ + click Insert cursor
    - ⌥⌘↑ Insert cursor above
    - ⌥⌘↓ Insert cursor below
    - ⌘U Undo last cursor operation
    - ⇧⌥I Insert cursor at end of each line selected
    - ⌘I Select current line
    - ⇧⌘L Select all occurrences of current selection
    - ⌘F2 Select all occurrences of current word
    - ⌃⇧⌘→ / ← Expand / shrink selection
    - ⇧⌥ + drag mouse Column (box) selection
    - ⇧⌥⌘↑ / ↓ Column (box) selection up/down
    - ⇧⌥⌘← / → Column (box) selection left/right
    - ⇧⌥⌘PgUp Column (box) selection page up
    - ⇧⌥⌘PgDn Column (box) selection page down
* Search and replace
    - ⌘F Find
    - ⌥⌘F Replace
    - ⌘G / ⇧⌘G Find next/previous
    - ⌥Enter Select all occurrences of Find match
    - ⌘D Add selection to next Find match
    - ⌘K ⌘D Move last selection to next Find match
* Rich languages editing
    - ⌃Space Trigger suggestion
    - ⇧⌘Space Trigger parameter hints
    - ⇧⌥F Format document
    - ⌘K ⌘F Format selection
    - F12 Go to Definition
    - ⌥F12 Peek Definition
    - ⌘K F12 Open Definition to the side
    - ⌘. Quick Fix
    - ⇧F12 Show References
    - F2 Rename Symbol
    - ⌘K ⌘X Trim trailing whitespace
    - ⌘K M Change file language
* Navigation
    - ⌘T Show all Symbols
    - ⌃G Go to Line...
    - ⌘P Go to File...
    - ⇧⌘O Go to Symbol...
    - ⇧⌘M Show Problems panel
    - F8 / ⇧F8 Go to next/previous error or warning
    - ⌃⇧Tab Navigate editor group history
    - ⌃- / ⌃⇧- Go back/forward
    - ⌃⇧M Toggle Tab moves focus
    - ctrl+b:toggle sidebar
* Editor management
    - ⌘W Close editor
    - ⌘K F Close folder
    - ⌘\ Split editor
    - ⌘1 / ⌘2 / ⌘3 Focus into 1
    - st, 2nd, 3rd editor group
    - ⌘K ⌘← / ⌘K ⌘→ Focus into previous/next editor group
    - ⌘K ⇧⌘← / ⌘K ⇧⌘→ Move editor left/right
    - ⌘K ← / ⌘K → Move active editor group
* File management
    - ⌘N New File
    - ⌘O Open File...
    - ⌘S Save
    - ⇧⌘S Save As...
    - ⌥⌘S Save All
    - ⌘W Close
    - ⌘K ⌘W Close All
    - ⇧⌘T Reopen closed editor
    - ⌘K Enter Keep preview mode editor open
    - ⌃Tab / ⌃⇧Tab Open next / previous
    - ⌘K P Copy path of active file
    - ⌘K R Reveal active file in Explorer
    - ⌘K O Show active file in new window/instance
* Display
    - ⌃⌘F Toggle full screen
    - ⌥⌘1 Toggle editor layout (horizontal/vertical)
    - ⌘= / ⇧⌘- Zoom in/out
    - ⌘B Toggle Sidebar visibility
    - ⇧⌘E Show Explorer / Toggle focus
    - ⇧⌘F Show Search
    - ⌃⇧G Show Source Control
    - ⇧⌘D Show Debug
    - ⇧⌘X Show Extensions
    - ⇧⌘H Replace in files
    - ⇧⌘J Toggle Search details
    - ⇧⌘U Show Output panel
    - ⇧⌘V Open Markdown preview
    - ⌘K V Open Markdown preview to the side
    - ⌘K Z Zen Mode (Esc Esc to exit)
* Debug
    - F9 Toggle breakpoint
    - F5 Start/Continue
    - F11 / ⇧F11 Step into/ out
    - F10 Step over
    - ⇧F5 Stop
    - ⌘K ⌘I Show hover
* Integrated terminal
    - ⌃`Show integrated terminal ⌃⇧`  Create new terminal
    - ⌘C Copy selection
    - ⌘↑ / ↓ Scroll up/down
    - PgUp / PgDn Scroll page up/down
    - ⌘Home / End Scroll to top/bottom
    - ⇧⌥⌘↓, ⇧⌥⌘→, ⇧⌥⌘↑, ⇧⌥⌘← Box Selection
    - ctrl+K ctrl+s 进入快捷键设置界面
* 行
    - 重开一行：光标在行尾的话，回车即可；不在行尾，ctrl + enter 向下重开一行；ctrl+shift + enter 则是在上一行重开一行
    - 删除一行：光标没有选择内容时，ctrl + x 剪切一行；ctrl +shift + k 直接删除一行
    - 移动一行：alt + ↑ 向上移动一行；alt + ↓ 向下移动一行
    - 复制一行：shift + alt + ↓ 向下复制一行；shift + alt + ↑ 向上复制一行
    - ctrl + z 回退
* 词
    - 中一个词：ctrl + d

### CLI tool

Open the Command Palette (F1) and type "shell command". Hit enter to execute Shell Command: Install 'code' command in PATH.

```sh
code --help # see help options
code . # open code with current directory
code pro6.js pro6.scss ../
code -r . # open the current directory in the most recently used code window
code -n # create a new window
code --locale=es # change the language
code --diff <file1> <file2> # open diff editor
code --disable-extensions . # disable all extensions
```

## 代码片段 User Snippets

```
"Print to console": {
    "prefix": "log",
    "body": [
        "console.log('$1');",
        "$2"
    ],
    "description": "Log output to console"
}
```

## launch

## task 构建（编译、链接等）任务

## tips

```sh
"Developer: Open Process Explorer"
```

## [Set Up Remote Development Workflow With VS Code in Your Browser](https://hackernoon.com/how-you-can-set-up-remote-development-workflow-with-vs-code-in-your-browser-3y3q3wu9)

* [cdr/code-server](https://github.com/cdr/code-server):VS Code in the browser https://coder.com

## 扩展

* [viatsko/awesome-vscode](https://github.com/viatsko/awesome-vscode):A curated list of delightful VS Code packages and resources.
* [vscode-element-helper](https://github.com/ElemeFE/vscode-element-helper)
* [keyboard-shortcuts-macos](https://code.visualstudio.com/shortcuts/keyboard-shortcuts-macos.pdf)
* [octref/polacode](https://github.com/octref/polacode):📸 Polaroid for your code

## 工具

* [Microsoft/monaco-editor](https://github.com/Microsoft/monaco-editor):A browser based code editor https://microsoft.github.io/monaco-editor/
* [eclipse-theia/theia](https://github.com/eclipse-theia/theia):Eclipse Theia is a cloud & desktop IDE framework implemented in TypeScript. http://theia-ide.org

## 參考

* [文檔](https://code.visualstudio.com/docs)
* [Microsoft/vscode-tips-and-tricks](https://github.com/Microsoft/vscode-tips-and-tricks):Collection of helpful tips and tricks for VS Code.
