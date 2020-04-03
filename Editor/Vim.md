# [vim/vim](https://github.com/vim/vim)

The official Vim repository http://www.vim.org Vim的一个最大用途是批量修改文件，列模式，正则表达式替换，区域替换

* 内置于任何类Unix系统上，可以直接在服务器上编辑文件
* 与大多数文本编辑器和IDE相比，轻量级的，即使在性能较弱的硬件上运行速度也很快且高效
* 完全由键盘驱动的，更有效率

## 安装

```sh
brew install vim
```

## 配置

* 全局配置：/etc/vim/vimrc或者/etc/vimrc
* 用户配置：~/.vimrc
* 选项
    - all：列出所有选项设置情况
    - term：设置终端类型
    - ignorance：在搜索中忽略大小写
    - list：显示制表位(Ctrl+I)和行尾标志（$)
    - number：显示行号
    - report：显示由面向行的命令修改过的数目
    - terse：显示简短的警告信息
    - warn：在转到别的文件时若没保存当前文件则显示NO write信息
    - nomagic：允许在搜索模式中，使用前面不带“/”的特殊字符
    - nowrapscan：禁止vi在搜索到达文件两端时，又从另一端开始
    - mesg：允许vi显示其他用户用write写到自己终端上的信息

```

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 显示相关
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set shortmess=atI   " 启动的时候不显示那个援助乌干达儿童的提示
winpos 5 5         " 设定窗口位置
set lines=30 columns=85    " 设定窗口大小

set nu|number            " 显示行号
set relativenumber " 显示光标所在的当前行的行号，其他行都为相对于该行的相对行号
set cursorline " 光标所在的当前行高亮

set wrap|nowrap # 自动折行
set linebreak # 只有遇到指定的符号（比如空格、连词号和其他标点符号），才发生折行
set wrapmargin=2 # 指定折行处与编辑窗口的右边缘之间空出的字符数。
set scrolloff=5 # 垂直滚动时，光标距离顶部/底部的位置（单位：行）
set sidescrolloff=15 # 水平滚动时，光标距离行首或行尾的位置（单位：字符）。该配置在不折行时比较有用。
set laststatus=2 # 是否显示状态栏。0 表示不显示，1 表示只在多窗口时显示，2 表示显示。
set ruler # 在状态栏显示光标的当前位置（位于哪一行哪一列）。

set go=             " 不要图形按钮
"color asmanian2     " 设置背景主题
set guifont=Courier_New:h10:cANSI   " 设置字体
syntax on           " 语法高亮
autocmd InsertLeave * se nocul  " 用浅色高亮当前行
autocmd InsertEnter * se cul    " 用浅色高亮当前行

set showcmd         " 输入的命令显示出来，看的清楚些
set mouse=a   " 支持使用鼠标
set showmode " 在底部显示，当前处于命令模式还是插入模式。
set cmdheight=1     " 命令行（在状态行下）的高度，设置为1
"set whichwrap+=<,>,h,l   " 允许backspace和光标键跨越行边界(不建议)
set scrolloff=3     " 光标移动到buffer的顶部和底部时保持3行距离
set novisualbell    " 不要闪烁(不明白)
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   "状态行显示的内容
set laststatus=1    " 启动显示状态行(1),总是显示状态行(2)
set foldenable      " 允许折叠
set foldmethod=manual   " 手动折叠
set background=dark "背景使用黑色

" 显示中文帮助
if version >= 603
    set helplang=cn
    set encoding=utf-8 " 使用 utf-8 编码
endif

" 设置配色方案
"colorscheme murphy

"字体
"if (has("gui_running"))
"   set guifont=Bitstream\ Vera\ Sans\ Mono\ 10
"endif

set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936
set fileencoding=utf-8

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""新文件标题""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新建.c,.h,.sh,.java文件，自动插入文件头
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java exec ":call SetTitle()"
""定义函数SetTitle，自动插入文件头
func SetTitle()
    "如果文件类型为.sh文件
    if &filetype == 'sh'
        call setline(1,"\#########################################################################")
        call append(line("."), "\# File Name     : ".expand("%"))
        call append(line(".")+1, "\# Author        : enjoy5512")
        call append(line(".")+2, "\# mail          : enjoy5512@163.com")
        call append(line(".")+3, "\# Created Time  : ".strftime("%c"))
        call append(line(".")+4, "\#########################################################################")
        call append(line(".")+5, "")
        call append(line(".")+6, "\#!/bin/bash")
    call append(line(".")+7, "")
    call append(line(".")+8, "")
    else
        call setline(1, "/*************************************************************************")
        call append(line("."), "    > File Name       : ".expand("%"))
        call append(line(".")+1, "    > Author          : enjoy5512")
        call append(line(".")+2, "    > Mail            : enjoy5512@163.com ")
        call append(line(".")+3, "    > Created Time    : ".strftime("%c"))
        call append(line(".")+4, " ************************************************************************/")
        call append(line(".")+5, "")
    endif
    if &filetype == 'cpp'
        call append(line(".")+6, "#include<iostream>")
    call append(line(".")+7, "")
        call append(line(".")+8, "using namespace std;")
        call append(line(".")+9, "")
        call append(line(".")+10, "int main(int argc,char *argv[])")
        call append(line(".")+11, "{")
        call append(line(".")+12, "     ")
        call append(line(".")+13, "    return 0;")
        call append(line(".")+14, "}")
    endif
    if &filetype == 'c'
        call append(line(".")+6, "#include<stdio.h>")
        call append(line(".")+7, "")
        call append(line(".")+8, "int main(int argc,char *argv[])")
        call append(line(".")+9, "{")
        call append(line(".")+10, "     ")
        call append(line(".")+11, "    return 0;")
        call append(line(".")+12, "}")
    autocmd BufNewFile * 12 j
    endif
endfunc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"键盘命令
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"C，C++ 按F5编译运行
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!gcc % -o %<"
        exec "! ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'sh'
        :!./%
    endif
endfunc
"C,C++的调试
map <C-F5> :call Rungdb()<CR>
func! Rungdb()
    exec "w"
    if &filetype == 'c'
        exec "!gcc % -g -o %<"
        exec "!gdb -tui ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -g -o %<"
        exec "!gdb -tui ./%<"
    endif
endfunc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""实用设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 设置当文件被改动时自动载入
set autoread
" quickfix模式
autocmd FileType c,cpp map <buffer> <leader><space> :w<cr>:make<cr>
"代码补全
set completeopt=preview,menu
"允许插件
filetype plugin on
"共享剪贴板
set clipboard+=unnamed
"从不备份
set nobackup
"自动保存
set autowrite
set ruler                   " 打开状态栏标尺
set cursorline              " 突出显示当前行
set magic                   " 设置魔术
set guioptions-=T           " 隐藏工具栏
set guioptions-=m           " 隐藏菜单栏
set foldcolumn=0
set foldmethod=indent
set foldlevel=3
set foldenable              " 开始折叠

set nocompatible " 不与 Vi 兼容（采用 Vim 自己的操作命令）
set syntax=on " 语法高亮
set noeb " 去掉输入错误的提示声音
set confirm " 在处理未保存或只读文件的时候，弹出确认

set autoindent " 自动缩进
set cindent
set tabstop=4 " Tab键的宽度
set expandtab " 由于 Tab 键在不同的编辑器缩进不一致，该设置自动将 Tab 转为空格
set softtabstop=4 " Tab 转为多少个空格\
set shiftwidth=4 " 在文本上按下>>（增加一级缩进）、<<（取消一级缩进）或者==（取消全部缩进）时，每一级的字符数。

set nobackup
set noswapfile "禁止生成临时文件

set ignorecase "搜索忽略大小写

set hlsearch "搜索逐字符高亮
set incsearch
"行内替换
set gdefault
"编码设置
set enc=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
"语言设置
set langmenu=zh_CN.UTF-8
set helplang=cn
" 状态行显示的内容（包括文件类型和解码）
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
"set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]
"set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\
" 总是显示状态行
set laststatus=2
" 命令行（在状态行下）的高度，默认为1，这里是2
set cmdheight=2
" 侦测文件类型
filetype on " 载入文件类型插件
filetype plugin on " 为特定文件类型载入相关缩进文件
filetype indent on " 开启文件类型检查，并且载入与该类型对应的缩进规则。
" 保存全局变量
set viminfo+=!
" 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\
" 高亮显示匹配的括号
set showmatch
" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=1
" 光标移动到buffer的顶部和底部时保持3行距离
set scrolloff=3
" 为C程序提供自动缩进
set smartindent
" 高亮显示普通txt文件（需要txt.vim脚本）
au BufRead,BufNewFile *  setfiletype txt
"自动补全
":inoremap ( ()<ESC>i
":inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {<CR>}<ESC>O
:inoremap } <c-r>=ClosePair('}')<CR>
":inoremap [ []<ESC>i
":inoremap ] <c-r>=ClosePair(']')<CR>
":inoremap " ""<ESC>i
":inoremap ' ''<ESC>i
function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction
filetype plugin indent on
"打开文件类型检测, 加了这句才可以用智能补全
set completeopt=longest,menu

set showmatch # 光标遇到圆括号、方括号、大括号时，自动高亮对应的另一个圆括号、方括号和大括号。

set hlsearch # 搜索时，高亮显示匹配结果。
set incsearch # 输入搜索模式时，每输入一个字符，就自动跳到第一个匹配的结果。

set ignorecase # 搜索时忽略大小写。

set smartcase # 如果同时打开了ignorecase，那么对于只有一个大写字母的搜索词，将大小写敏感；其他情况都是大小写不敏感。比如，搜索Test时，将不匹配test；搜索test时，将匹配Test。

set spell spelllang=en_us 打开英语单词的拼写检查。
set nobackup # 不创建备份文件。默认情况下，文件保存时，会额外创建一个备份文件，它的文件名是在原文件名的末尾，再添加一个波浪号（〜）。
set noswapfile # 不创建交换文件。交换文件主要用于系统崩溃时恢复文件，文件名的开头是.、结尾是.swp。

set undofile # 保留撤销历史。
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//
set undodir=~/.vim/.undo// 设置备份文件、交换文件、操作历史文件的保存位置。  结尾的//表示生成的文件名带有绝对路径，路径中用%替换目录分隔符，这样可以防止文件重名。
set autochdir # 自动切换工作目录。这主要用在一个 Vim 会话之中打开多个文件的情况，默认的工作目录是打开的第一个文件的目录。该配置可以将工作目录自动切换到，正在编辑的文件的目录。

set noerrorbells # 出错时，不要发出响声。
set visualbell # 出错时，发出视觉提示，通常是屏幕闪烁。

set autoread # 打开文件监视。如果在编辑过程中文件发生外部改变（比如被别的编辑器编辑了），就会发出提示
set listchars=tab:»■,trail:■
set list # 如果行尾有多余的空格（包括 Tab 键），该配置将让这些空格显示成可见的小方块。

set wildmenu
set wildmode=longest:list,full # 命令模式下，底部操作指令按下 Tab 键自动补全。第一次按下 Tab，会显示所有匹配的操作指令的清单；第二次按下 Tab，会依次选择各个指令。
```

## 使用

* 模式
    - Insert模式：按i键进入,左下角显示--INSERT--,可以输入字符，按ESC将回到命令模式
    - Normal模式：按Esc或Ctrl+[进入, 左下角显示文件名或为空, 可以移动光标、删除字符等
    - Visual模式：左下角显示--VISUAL-- 可以对选定的文本运行命令操作并该命令仅仅作用于选定文本
* 通用
    - `N<command>`:重复某个命令N次,命令都可以配合数字使用.Esc是必须的，否则命令不生效
    - . 重复前一次命令
    - 自动提示:输入一个词的开头，然后按 <C-p>或是<C-n>
    - History: 以:和/开头的命令都有历史纪录，可以首先键入:或/然后按上下箭头来选择某个历史命令
    - :set ruler?　　查看是否设置了ruler，在.vimrc中，使用set命令设制的选项都可以通过这个命令查看
    - :scriptnames　　查看vim脚本文件的位置，比如.vimrc文件，语法文件及plugin等。
    - :set list 显示非打印字符，如tab，空格，行尾等。如果tab无法显示，请确定用set lcs=tab:>-命令设置了.vimrc文件，并确保你的文件中的确有tab，如果开启了expendtab，那么tab将被扩展为空格。

Cursor control and position                             | Editing
------------------------------------------------------- | ------------------------------------------------------
h Left                                                  | A Append to end of current line
j Down                                                  | i Insert before cursor
k Up                                                    | I Insert at beginning of line
l (or spacebar) Right                                   | o Open line above cursor
w Forward one word                                      | O Open line below cursor
b Back one word                                         | ESC End of insert mode
e End of word                                           | Ctrl-I Insert a tab
( Beginning of current sentence                         | Ctrl-T Move to next tab position
) Beginning of next sentence                            | Backspace Move back one character
{ Beginning of current paragraph                        | Ctrl-U Delete current line
} Beginning of next paragraph                           | Ctrl-V Quote next character
[[ Beginning of current section                         | Ctrl-W Move back one word
]] Beginning of next section                            | cw Change word
0 Start of current line                                 | cc Change line
$ End of current line                                   | C Change from current position to end of line
^ First non-white character of current line             | dd Delete current line
\+ or RETURN First character of next line                | ndd Delete n lines
– First character of previous line                      | D Delete remainer of line
n character n of current line                           | dw Delete word
H Top line of current screen                            | d} Delete rest of paragraph
M Middle line of current screen                         | d^ Delete back to start of line
L Last line of current screen                           | c/pat Delete up to first occurance of pattern
nH n lines after top line of current screen             | dn Delete up to next occurance of pattern
nL n lines before last line of current screen           | dfa Delete up to and including a on current line
Ctrl-F Forward one screen                               | dta Delete up to, but not including, a on current line
Ctrl-B Back one screen                                  | dL Delete up to last line on screen
Ctrl-D Down half a screen                               | dG Delete to end of file
Ctrl-U Up half a screen                                 | J Join two lines
Ctrl-E Display another line at bottom of screen         | p Insert buffer after cursor
Ctrl-Y Display another line at top of screen            | P Insert buffer before cursor
z RETURN Redraw screen with cursor at top               | rx Replace character with x
z . Redraw screen with cursor in middle                 | Rtext Replace text beginning at cursor
z – Redraw screen with cursor at bottom                 | s Substitute character
Ctrl-L Redraw screen without re-positioning             | ns Substitute n characters
Ctrl-R Redraw screen without re-positioning             | S Substitute entire line
/text Search for text (forwards)                        | u Undo last change
/ Repeat forward search                                 | U Restore current line
?text Search for text (backwards)                       | x Delete current cursor position
? Repeat previous search backwards                      | X Delete back one character
n Repeat previous search                                | nX Delete previous n characters
N Repeat previous search, but it opposite direction     | . Repeat last change
/text/+n Go to line n after text                        | ~ Reverse case
?text?-n Go to line n before text                       | y Copy current line to new buffer
% Find match of current parenthesis, brace, or bracket. | yy Copy current line
Ctrl-G Display line number of cursor                    | "xyy Copy current line into buffer x
nG Move cursor to line number n                         | "Xd Delete and append into buffer x
:n Move cursor to line number n                         | "xp Put contents of buffer x
G Move to last line in file                             | y]] Copy up to next section heading
ye Copy to end of word |
:w Write file | :w! Write file (ignoring warnings)
:w! file Overwrite file (ignoring warnings) | :wq Write file and quit
:q Quit | :q! Quit (even if changes not saved)
:w file Write file as file, leaving original untouched | ZZ Quit, only writing file if changed
😡 Quit, only writing file if changed | :n1,n2w file Write lines n1 to n2 to file
:n1,n2w >> file Append lines n1 to n2 to file | :e file2 Edit file2 (current file becomes alternate file)
:e! Reload file from disk (revert to previous saved version) | :e# Edit alternate file
% Display current filename |
:n Edit next file | :n! Edit next file (ignoring warnings)
:n files Specify new list of files | :r file Insert file after cursor
:r !command Run command, and insert output after current line |

![](../_static/vim.png)

### 显示

* :split → 创建分屏 (:vsplit创建垂直分屏)
* <C-w><dir> : dir就是方向，可以是 hjkl 或是 ←↓↑→ 中的一个，其用来切换分屏。
* <C-w>_ (或 <C-w>|) : 最大化尺寸 (<C-w>| 垂直分屏)
* <C-w>+ (或 <C-w>-) : 增加尺寸

### 文件

* vi filename :打开或新建文件，并将光标置于第一行首
* :open|o file 在vim窗口中打开一个新文件
* vim file1 file2 file3 ... 同时打开多个文件
* :split file 在新窗口中打开文件
* :close – close current window
* 切换同时打开的文件
    - :bn 切换到下一个文件
    - :bp 切换到上一个文件
* :args 查看当前打开的文件列表，当前正在编辑的文件会用[]括起来。
* 打开远程文件，比如ftp或者share folder
    - `:e ftp://192.168.10.76/abc.txt`
    - `:e \\qadrive\test\1.txt`
* vi +n filename ：打开文件，并将光标置于第n行首
* vi + filename ：打开文件，并将光标置于最后一行首
* vi +/pattern filename：打开文件，并将光标置于第一个与pattern匹配的串处
* vi -r filename ：在上次正用vi编辑时发生系统崩溃，恢复filename
* vi -o/O filename1 filename2 … ：打开多个文件，依次进行编辑
* :w  保存文件
* :w vpser.net 保存至vpser.net文件
* `:saveas <path/to/file>` → 另存为 `<path/to/file>`
* :q 退出编辑器
* :x， ZZ 或 :wq  保存并退出 (:x 表示仅在需要时保存，ZZ不需要输入冒号并回车)
* :q! 退出不保存
* :qa! 强行退出所有的正在编辑的文件，就算别的文件有更改
* `:e <path/to/file>` → 打开一个文件
* :e! 放弃所有修改，并打开原来文件

### 移动

* h|Backspace：光标左移一个字符
* l|space|w：光标右移一个字符
* k|Ctrl+p：光标上移一行
* j|Ctrl+n|Enter：光标下移一行
H – move to top of screen
M – move to middle of screen
L – move to bottom of screen
* 30j:向下移动30行
* w|W：向后移动一个单词（光标停在单词首部），如果已到行尾，则转至下一行行首。此命令快，可以代替l命令
* e|E：光标右移一个单词至词尾
* b|B：光向后移动一个单词至词首
* ge：光向后移动一个单词至词尾
* )：光标移至句尾
* (：光标移至句首
* }：光标移至段落开头
* {：光标移至段落结尾
* :N 到第N行
* G|]]: 文档尾行
* nG：光标移至第n行首
* n+：光标下移n行
* n-：光标上移n行
* n$：光标移至下面n行行尾
* gg | 1G|[[:到文件头
* 0：（数字零）光标移至本行第一个字符上
* `$|<HOME>`：光标移至当前行尾
* ^ :到本行第一个不是blank字符(空格，tab，换行，回车等)的位置
* g_ :到本行最后一个不是blank字符的位置
* `f` 查找字符 ; f {char}会定位到第一个{char}出现的光标位置
`F` 查找字符；与f类似，不过是向后查找
`;` 重复上次搜索
`, `如果重复上次搜索按多了，则可以通过`,`回退
* fa :光标后第一个为a的字符,3fa :在当前行查找第三个出现的a
* t, :到逗号前的第一个字符
* F 和 T :和 f 和 t 一样，只不过是相反方向
* dt" :删除所有的内容，直到遇到双引号—— "
* 屏幕
    - Ctrl + e 向下滚动一行
    - Ctrl + y 向上滚动一行
    - H ：光标移至屏幕顶行
    - M ：光标移至屏幕中间行
    - L ：光标移至屏幕最后行
    - Ctrl+u：向文件首翻半屏
    - Ctrl+d：向文件尾翻半屏
    - Ctrl+f：向文件尾翻一屏
    - Ctrl＋b；向文件首翻一屏
    - nz：将第n行滚至屏幕顶部，不指定n时将当前行滚至屏幕顶部。

## 插入

* i ：当前位置前插入，3a！:在当前位置后插入3个！
* I ：在当前行首
* a：光标后
* A：在当前行尾
* o：新起一个空白行
* O：在当前行之前插入一行
* r：替换当前字符
* R：替换当前字符及其后的字符，直至按ESC键
* s：从当前光标位置处开始，以输入的文本替代指定数目的字符
* S：删除指定数目的行，并以所输入文本代替之
* ncw或nCW：修改指定数目的字
* nCC：修改指定数目的行

## 查找

* /text　　查找text，按n健查找下一个，按N健查找前一个
* ?text　　查找text，反向查找，按n健查找下一个，按N健查找前一个
* 有一些特殊字符在查找时需要转义　　.*[]^%/?~$
* - * 和 #: 匹配光标当前所在的单词，移动光标到下一个（或上一个）匹配单词（*是下一个，#是上一个）
* 2n 查找下面第二个匹配
* :set nu 开启行号
* :set ignorecase　　忽略大小写的查找
* :set noignorecase　　不忽略大小写的查找
* :set hlsearch　　高亮搜索结果，所有结果都高亮显示，而不是只显示一个匹配。
* :set nohlsearch　　关闭高亮搜索显示
* :nohlsearch　　关闭当前的高亮显示，如果再次搜索或者按下n或N键，则会再次高亮。
* :set incsearch　　逐步搜索模式，对当前键入的字符进行搜索而不必等待键入完成。
* :set wrapscan　　重新搜索，在搜索到文件头或尾时，返回继续搜索，默认开启。

## 替换

* % : 匹配括号移动，包括 (, {, [.
* 用“<”来指定匹配单词开头
* :s/old/new 用new替换行中首次出现的old
* :s/old/new/g  用new替换行中所有的old
* :%s/old/new/g 用new替换当前文件里所有的old
* :n,m?s/old/new/g  用new替换从n到m行里所有的old
* ：n1,n2s/p1/p2/g：将第n1至n2行中所有p1均用p2替代
* ：g/p1/s//p2/g：将文件中所有p1均用p2替换
* :%s/<four>/4/gc 只想替换注释中的 “four”，而保留代码中
* %s/$/sth/ 在行尾追加sth
* %s/\^M//g 替换掉dos换行符，\^M使用ctrl+v  + Enter即可输入
* :g/\^\s*$/d 删除空行以及只有空格的行
* %s/#.*//g 删除#之后的字符
* sed -e “s/\<old\>/new/g” ?file # 单词精确匹配替换

## 编辑

* r 替换字符
* ggVG 全选
* u 撤销（Undo）
* U 撤销对整行的操作
* Ctrl + r 重做（Redo），即撤销的撤销
* J 合并下一行
* gU 光标处转大写
* ggguG 整篇文章大写转化为小写
* % 跳转到下一个匹配,如在<div>上按%，则跳转到相应的</div>
* 拷贝与复制
    - yy 复制当前行 也可以用 “ayy 复制，”a 为缓冲区，a也可以替换为a到z的任意字母，可以完成多个复制任务
    - 10yy 向下复制10行
    - yw 复制光标开始的一个单词
    - nyw  复制从光标开始的n个单词
    - y^ 复制从光标到行首的内容
    - y$  复制从光标到行尾的内容
    - 0y$ 从行头拷贝到最后一个字符
    - ye 当前位置拷贝到本单词的最后一个字符
    - yfB 复制光标到第一个大写B中间的内容
    - y2fB 复制光标到第二个大写B中间的内容
    - y2/foo 来拷贝2个 “foo” 之间的字符串
    - p  在当前光标后粘贴,如果之前使用了yy命令来复制一行，那么就在当前行的下一行粘贴
    - shift+p 在当前行前粘贴
    - :1,10 co 20 将1-10行插入到第20行之后
    - :1,$ co $ 将整个文件复制一份并添加到文件尾部
    - P 粘贴剪切板里的内容在光标前，如果使用了前面的自定义缓冲区，建议使用”aP 进行粘贴。
    - p 粘贴复制或剪切的内容
    - 3p 将复制或剪切的内容粘贴三次
    - u  # 撤销上一步操作
    - U  # 撤销对当前行的所有操作*
    - 在命令模式下，执行%s/$/");/g，在行尾追加数据
    - 按ESC进入普通模式，并使用gg回到行首
    - 按ctrl+v进入可视化模式，然后按G到文件尾
    - 不要理会编辑器反应，按I进入插入模式，输入list.add("
    - 按ESC回到普通模式，可以发现以上输入已经在每一行生效了
    - ddp交换当前行和其下一行
* 剪切
    - ndd 剪切当前行之后的n行
    - :1,10d 将1-10行剪切。利用p命令可将剪切后的内容进行粘贴。
    - :1, 10 m 20 将第1-10行移动到第20行之后。

## 删除

* ndw或ndW：删除光标处开始及其后的n-1个字
* dw 删除一个单词
* do：删至行首
* D|d$ 删除当前字符至行尾
* dd 删除当前行 10d 删除当前行开始的10行
* dj 删除上一行
* dk 删除下一行
* 200dd 删除200行
* kdgg 删除当前行之前所有行（不包括当前行）
* jdG 删除当前行之后所有行（不包括当前行）
* :1,10d 删除1-10行
* :11,$d 删除11行及以后所有的行
* :1,$d 删除所有行
* df” 删除到出现的第一个双引号
* x|dl 剪切光标所在的一个字符，如果是在行尾，则为向前剪切,3x 删除当前光标开始向后三个字符
* X|dh 剪切光标前一个字符
* cw  # 光标所在字符删除至单词结尾(是删除单词的便捷方式)，同时会进入编辑模式
* 3x 剪切三个
* xp 交换当前字符和其后一个字符，如从bs变成sb
* J 删除两行之间的空行，实际上是合并两行。
* Ctrl+u：删除输入方式下所输入的文本

## 块操作

```
^ <C-v> <C-d> I-- [ESC]
^ → 到行头
<C-v> → 开始块操作 # windows下是 <C-q>
<C-d> → 向下移动 (你也可以使用hjkl来移动光标，或是使用%，或是别的)
I-- [ESC] → I是插入，插入“--”，按ESC键来为每一行生效。
```

## 窗口

* ：split或new 打开一个新窗口，光标停在顶层的窗口上
* :split file或:new file 用新窗口打开文件
* split打开的窗口都是横向的，使用vsplit可以纵向打开窗口。
* Ctrl+ww 移动到下一个窗口
* Ctrl+wj 移动到下方的窗口
* Ctrl+wk 移动到上方的窗口
* 关闭窗口
    - :close 最后一个窗口不能使用此命令，可以防止意外退出vim。
    - :q 如果是最后一个被关闭的窗口，那么将退出vim。
    - ZZ 保存并退出。 关闭所有窗口，只保留当前窗口

## 最后行方式命令

```
：n1,n2 co n3：将n1行到n2行之间的内容拷贝到第n3行下
：n1,n2 m n3：将n1行到n2行之间的内容移至到第n3行下
：n1,n2 d ：将n1行到n2行之间的内容删除

：!command：执行shell命令command
：n1,n2 w!command：将文件中n1行至n2行的内容作为command的输入并执行之，若不指定n1，n2，则表示将整个文件内容作为command的输入
：r!command：将命令command的输出结果放到当前行
```

## 寄存器操作

```
“?nyy：将当前行及其下n行的内容保存到寄存器？中，其中?为一个字母，n为一个数字
“?nyw：将当前行及其下n个字保存到寄存器？中，其中?为一个字母，n为一个数字
“?nyl：将当前行及其下n个字符保存到寄存器？中，其中?为一个字母，n为一个数字
“?p：取出寄存器？中的内容并将其放到光标位置处。这里？可以是一个字母，也可以是一个数字
ndd：将当前行及其下共n行文本删除，并将所删内容放到1号删除寄存器中。

:set number | nu | nonumber | nonu       # 取消行号设置
::set number? # 查询某个配置项是打开还是关闭
u | <C-r>      undo撤销，从文件打开后的所有操作都可以撤销
r       对单词字符进行替换
.       重复执行"最近"的一条指令
J       合并上下两行
```

### Visual

* 普通模式下按v（逐字）或V（逐行）即可进入
* 命令格式：<action>a<object> 和 <action>i<object>
* action：d (删除), y (拷贝), v (可以视模式选择)
* object 可能是： w 一个单词， W 一个以空格为分隔的单词， s 一个句字， p 一个段落。也可以是一个特别的字符："、 '、 )、 }、 ]。
    - d (删除 )
    - v (可视化的选择)
    - gU (变大写)
    - gu (变小写)
    - J → 把所有的行连接起来（变成一行）
    - < 或 > → 左右缩进
    - = → 自动给缩进

```
(map (+) ("foo")) # 光标键在第一个 o

vi" → 会选择 foo.
va" → 会选择 "foo".
vi) → 会选择 "foo".
va) → 会选择("foo").
v2i) → 会选择 map (+) ("foo")
v2a) → 会选择 (map (+) ("foo"))

<C-v>
选中相关的行 (可使用 j 或 <C-d> 或是 /pattern 或是 % 等……)
$ 到行最后
A, 输入字符串，按 ESC

# 纵向编辑
10.1.5.214 
10.1.5.212 
10.1.5.210

游标定位第一行 IP 地址第二段的“5”->ctrl-v 进入纵向编辑模式->G 移动游标到最后一行->r 进入修改模式->修改目标值->esc
游标定位到第一行第一列->ctrl-v 进入纵向编辑模式->G 移动游标到最后一行->I 进入行首插入模式->添加内容->esc
游标定位到第一行最后一列->ctrl-v 进入纵向编辑模式->G 移动游标到最后一行->A 进入行尾插入模式->添加内容->esc
```

## 宏

* 录制宏:按q键加任意字母开始录制，再按q键结束录制（这意味着vim中的宏不可嵌套）
* 使用:@加宏名
* @@ 是一个快捷键用来replay最新录制的宏

```
在一个只有一行且这一行只有“1”的文本中，键入如下命令：

qaYp<C-a>q→
qa 开始录制
Yp 复制行.
<C-a> 增加1.
q 停止录制.
@a → 在1下面写下 2
@@ → 在2 正面写下3
100@@ 会创建新的100行，并把数据增加到 103.

# 
按下gg到行首
按下qa进行宏录制，a是我们起的一个标记名称
按I进入插入模式，输入list.add("
按ESC进入普通模式，然后按$跳到行尾
按j进入下一行，然后按^回到行首
再次按下q结束宏录制
输入@a触发宏测试一下录制效果
输入100@a重复宏100次，也就是影响下面的100行
```

## 执行shell命令

* :!command
    - :!ls 列出当前目录下文件
    - :!perl -c script.pl 检查perl脚本语法，可以不用退出vim，非常方便。
    - :!perl script.pl 执行perl脚本，可以不用退出vim，非常方便。
    - :suspend或Ctrl - Z 挂起vim，回到shell，按fg可以返回vim。
* 注释命令
    - 3,5 s/^/#/g 注释第3-5行
    - 3,5 s/^#//g 解除3-5行的注释
    - 1,$ s/^/#/g 注释整个文档。
    - :%s/^/#/g 注释整个文档，此法更快。

## 学习计划

* 每天坚持输入一次Vimtutor，这一习惯至少持续一个星期。重点是花大量的时间练习，直到基本的导航和编辑命令成为第二本能
* 尽可能少地进行其他配置，不使用插件
    - 不要添加太多插件试图使Vim成为一个完整的IDE——Vim作为Vim就很好，作为IDE则很糟糕
    - 添加一个配色方案（vim-code-dark）
    - 打开语法高亮
    - 设置空格和制表符
    - 设置自动缩进
    - 打开行号
    - 用tab在子文件夹中查找文件
    - 配置为按ESC快速退出插入模式
    - 配置结构： .vim>color/+plugin/+vimrc
* 尽可能少地使用插件
    - 不要安装插件管理器（较新版本的Vim原生的插件管理就已足够）
    - 不要安装树浏览器或模糊文件查找器插件（使用:find与子文件夹搜索效果就很好）
    - 不要为可视化标签安装插件（试着习惯原生Vim缓存，:b <TAB>很有用）
    - 不要安装自动完成的插件（原生Vim已经可以使用<CTRL n>来补全）
    - 不要为多行注释安装插件（尝试使用可视化模式）
    - 不要为多游标安装插件（使用带n的/搜索，需要时重复.）
    - 插件：增强Vim语言性
        + 考虑安装auto-pairs.vim（成对插入或删除括号，花括号，引号）
        + 考虑安装endwise.vim（Ruby中，在if,do,def等之后自动添加end）
        + 考虑安装ragtag.vim（HTML，erb等中的标签助手）
        + 考虑安装surround.vim（添加一个新的修饰符来更改包围的引号，括号等）
        + 考虑安装commentary.vim（添加一个新的动词到注释行）
        + 考虑安装repeat.vim（为特定插件添加.repeat支持）
* 动词和名词组合Vim命令,Chris Toomey的“掌握Vim语言”演讲很值得一看
    * 知道一些动词和名词：
        + 动词 — d（删除），c（修改），y（复制），>（缩进）
        + 名词（动作性的） — w（单词），b（前移一个单词），2j（下移两行）
        + 名词（文本对象） — iw（内部单词），it（内部标签），i""（内部引用）
    - 组合动词和名词来创建任意数量的命令
        + dw：删除到单词末尾
        + diw：删除光标所在单词
        + y4j：复制四行
        + cit：修改HTML标签内的内容

## [VundleVim/Vundle.vim](https://github.com/VundleVim/Vundle.vim)

Vundle, the plug-in manager for Vim http://github.com/VundleVim/Vundle.Vim

> Not an editor command: ^M
:set fileformat=unix :w

## 问题

> .git/rebase-merge/git-rebase-todo" E509: Cannot create backup file (add ! to override)

## 配置

* vimtutor
* [qvacua / vimr](https://github.com/qvacua/vimr):VimR — Neovim GUI for macOS http://vimr.org
* [amix/vimrc](https://github.com/amix/vimrc):The ultimate Vim configuration: vimrc
* [Valloric/YouCompleteMe](https://github.com/Valloric/YouCompleteMe):A code-completion engine for Vim http://valloric.github.io/YouCompleteMe/
* [philc/vimium](https://github.com/philc/vimium):The hacker's browser.
* [tpope/vim-pathogen](https://github.com/tpope/vim-pathogen):pathogen.vim: manage your runtimepath
* [square/maximum-awesome](https://github.com/square/maximum-awesome):Config files for vim and tmux.
* [SpaceVim/SpaceVim](https://github.com/SpaceVim/SpaceVim):A community-driven modular vim distribution - The ultimate vim configuration https://spacevim.org
* [ericzhang-cn/maximum-awesome-linux](https://github.com/ericzhang-cn/maximum-awesome-linux):Config files for vim and tmux.
    - ,d brings up NERDTree, a sidebar buffer for navigating and manipulating files
    - ,t brings up ctrlp.vim, a project file filter for easily opening specific files
* [avelino/vim-bootstrap](https://github.com/avelino/vim-bootstrap):Vim Bootstrap is generator provides a simple method of generating a .vimrc configuration for vim https://vim-bootstrap.com/
* [lexVim](https://github.com/lexkong/lexVim): `./start_vim.sh`
    - gd 或者ctrl + ] 跳转到对应的函数定义处
    - ctrl + t 标签退栈
    - ctrl + o 跳转到前一个位置
    - <F4> 最近文件列表
    - <F5> 在 Vim 的上面打开文件查找窗口
    - <F9> 生成供函数跳转的 tag
    - <F2> 打开目录窗口，再按会关闭目录窗口
    - <F6> 添加函数注释

## 插件

* [cknadler/vim-anywhere](https://github.com/cknadler/vim-anywhere):Use Vim everywhere you've always wanted to
* [rupa/z](https://github.com/rupa/z):z - jump around
* [rupa/v](https://github.com/rupa/v):z for vim
* [scrooloose/nerdtree](https://github.com/scrooloose/nerdtree):A tree explorer plugin for vim.
* [fatih/vim-go](https://github.com/fatih/vim-go):Go development plugin for Vim
* [powerline/powerline](https://github.com/powerline/powerline):Powerline is a statusline plugin for vim, and provides statuslines and prompts for several other applications, including zsh, bash, tmux, IPython, Awesome and Qtile. https://powerline.readthedocs.io/en/latest/
* NERDTree：可以在单独的window中浏览目录和文件，方便打开的选取文件。
* taglist：可以通过ctags生成的tag文件索引定位代码中的常量、函数、类等结构，阅读代码和写代码必备。
* powerline：在底部显示一个非常漂亮的状态条，还可以通过不同的颜色提醒用户当前处于什么状态（如normal、insert或visual）。
* vim-colors-solarized：vim的solarized配色插件

## 工具

* [coolwanglu/vim.js](https://github.com/coolwanglu/vim.js):JavaScript port of Vim http://coolwanglu.github.io/vim.js/emterpreter/vim.html
* [junegunn/fzf](https://github.com/junegunn/fzf):🌸 A command-line fuzzy finder
* [tpope/vim-vinegar](https://github.com/tpope/vim-vinegar):vinegar.vim: Combine with netrw to create a delicious salad dressing https://www.vim.org/scripts/script.php?script_id=5671
* [neoclide/coc.nvim](https://github.com/neoclide/coc.nvim):Intellisense engine for vim8 & neovim, full language server protocol support as VSCode https://salt.bountysource.com/teams/coc-nvim
* [vimwiki / vimwiki](https://github.com/vimwiki/vimwiki):Personal Wiki for Vim http://vimwiki.github.io/

## 教程

* [A vim Tutorial and Primer](https://danielmiessler.com/study/vim/)
* <https://github.com/junegunn/vim-plug>: junegunn 是韩国的一个大牛，擅长写 Vim 插件，看起来总是令人赏心悦目
* [SpaceVim](https://github.com/SpaceVim/SpaceVim):一个开箱即用的 Vim 配置，对新手很友好，和 Spacemacs 一样
* [reddit 的 Vim 频道](https://www.reddit.com/r/vim/):有很多最前沿的 Vim 技巧
