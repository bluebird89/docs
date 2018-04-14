# Vscode

## 指令

### 左边列表

* File explorer:  `command + shift + E`
* Search across files: `command + shift + F`
* Source code management `command + shift + G`
* launch and debug `command + shift + d`
* Manage extensions `command + shift + x`
* `shift+cmd+m`

### 快捷键


> general

⇧⌘P, F1 Show Command Palette
⌘P Quick Open, Go to File…
⇧⌘N New window/instance
⌘W Close window/instance
⌘, User Settings
⌘K ⌘S Keyboard Shortcuts

> Basic editing

⌘X Cut line (empty selection)
⌘C Copy line (empty selection)
⌥↓ / ⌥↑ Move line down/up
⇧⌥↓ / ⇧⌥↑ Copy line down/up
⇧⌘K Delete line
⌘Enter / ⇧⌘Enter Insert line below/above
⇧⌘\ Jump to matching bracket
⌘] / ⌘[ Indent/outdent line
Home / End Go to beginning/end of line
⌘↑ / ⌘↓ Go to beginning/end of file
⌃PgUp / ⌃PgDn Scroll line up/down
⌘PgUp /⌘PgDn Scroll page up/down
⌥⌘[ / ⌥⌘] Fold/unfold region
⌘K ⌘[ / ⌘K ⌘] Fold/unfold all subregions
⌘K ⌘0 / ⌘K ⌘J Fold/unfold all regions
⌘K ⌘C Add line comment
⌘K ⌘U Remove line comment
⌘/ Toggle line comment
⇧⌥A Toggle block comment
⌥Z Toggle word wrap

> Multi-cursor and selection

⌥ + click Insert cursor
⌥⌘↑ Insert cursor above
⌥⌘↓ Insert cursor below
⌘U Undo last cursor operation
⇧⌥I Insert cursor at end of each line selected
⌘I Select current line
⇧⌘L Select all occurrences of current selection
⌘F2 Select all occurrences of current word
⌃⇧⌘→ / ← Expand / shrink selection
⇧⌥ + drag mouse Column (box) selection
⇧⌥⌘↑ / ↓ Column (box) selection up/down
⇧⌥⌘← / → Column (box) selection left/right
⇧⌥⌘PgUp Column (box) selection page up
⇧⌥⌘PgDn Column (box) selection page down

> Search and replace

⌘F Find
⌥⌘F Replace
⌘G / ⇧⌘G Find next/previous
⌥Enter Select all occurrences of Find match
⌘D Add selection to next Find match
⌘K ⌘D Move last selection to next Find match

> Rich languages editing

⌃Space Trigger suggestion
⇧⌘Space Trigger parameter hints
⇧⌥F Format document
⌘K ⌘F Format selection
F12 Go to Definition
⌥F12 Peek Definition
⌘K F12 Open Definition to the side
⌘. Quick Fix
⇧F12 Show References
F2 Rename Symbol
⌘K ⌘X Trim trailing whitespace
⌘K M Change file language

> Navigation

⌘T Show all Symbols
⌃G Go to Line...
⌘P Go to File...
⇧⌘O Go to Symbol...
⇧⌘M Show Problems panel
F8 / ⇧F8 Go to next/previous error or warning
⌃⇧Tab Navigate editor group history
⌃- / ⌃⇧- Go back/forward
⌃⇧M Toggle Tab moves focus

> Editor management

⌘W Close editor
⌘K F Close folder
⌘\ Split editor
⌘1 / ⌘2 / ⌘3 Focus into 1
st, 2nd, 3rd editor group
⌘K ⌘← / ⌘K ⌘→ Focus into previous/next editor group
⌘K ⇧⌘← / ⌘K ⇧⌘→ Move editor left/right
⌘K ← / ⌘K → Move active editor group

> File management

⌘N New File
⌘O Open File...
⌘S Save
⇧⌘S Save As...
⌥⌘S Save All
⌘W Close
⌘K ⌘W Close All

⇧⌘T Reopen closed editor
⌘K Enter Keep preview mode editor open
⌃Tab / ⌃⇧Tab Open next / previous
⌘K P Copy path of active file
⌘K R Reveal active file in Explorer
⌘K O Show active file in new window/instance

> Display

⌃⌘F Toggle full screen
⌥⌘1 Toggle editor layout (horizontal/vertical)
⌘= / ⇧⌘- Zoom in/out
⌘B Toggle Sidebar visibility
⇧⌘E Show Explorer / Toggle focus
⇧⌘F Show Search
⌃⇧G Show Source Control
⇧⌘D Show Debug
⇧⌘X Show Extensions
⇧⌘H Replace in files
⇧⌘J Toggle Search details
⇧⌘U Show Output panel
⇧⌘V Open Markdown preview
⌘K V Open Markdown preview to the side
⌘K Z Zen Mode (Esc Esc to exit)

> Debug

F9 Toggle breakpoint
F5 Start/Continue
F11 / ⇧F11 Step into/ out
F10 Step over
⇧F5 Stop
⌘K ⌘I Show hover

> Integrated terminal

⌃` Show integrated terminal
⌃⇧` Create new terminal
⌘C Copy selection
⌘↑ / ↓ Scroll up/down
PgUp / PgDn Scroll page up/down
⌘Home / End Scroll to top/bottom
⇧⌥⌘↓, ⇧⌥⌘→, ⇧⌥⌘↑, ⇧⌥⌘←   Box Selection 

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

## 扩展

* [Microsoft/vscode](https://github.com/Microsoft/vscode):Visual Studio Code <https://code.visualstudio.com>
* [viatsko/awesome-vscode](https://github.com/viatsko/awesome-vscode):A curated list of delightful VS Code packages and resources.
* [Microsoft/vscode-tips-and-tricks](https://github.com/Microsoft/vscode-tips-and-tricks):Collection of helpful tips and tricks for VS Code.
* [vscode-element-helper](https://github.com/ElemeFE/vscode-element-helper)
* [keyboard-shortcuts-macos](https://code.visualstudio.com/shortcuts/keyboard-shortcuts-macos.pdf)
* https://code.visualstudio.com/
* [octref/polacode](https://github.com/octref/polacode):camera_flash Polaroid for your code 

