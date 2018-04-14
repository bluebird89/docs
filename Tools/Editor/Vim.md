# vim

brew install MacVim

Vim的一个最大用途是批量修改文件，列模式，正则表达式替换，区域替换，

## 配置文件

～/.vimrc

```
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 显示相关  
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set shortmess=atI   " 启动的时候不显示那个援助乌干达儿童的提示  
winpos 5 5         " 设定窗口位置  
set lines=30 columns=85    " 设定窗口大小  
set nu              " 显示行号  
set go=             " 不要图形按钮  
"color asmanian2     " 设置背景主题  
set guifont=Courier_New:h10:cANSI   " 设置字体  
syntax on           " 语法高亮  
autocmd InsertLeave * se nocul  " 用浅色高亮当前行  
autocmd InsertEnter * se cul    " 用浅色高亮当前行  
set ruler           " 显示标尺  
set showcmd         " 输入的命令显示出来，看的清楚些  
set cmdheight=1     " 命令行（在状态行下）的高度，设置为1  
"set whichwrap+=<,>,h,l   " 允许backspace和光标键跨越行边界(不建议)  
set scrolloff=3     " 光标移动到buffer的顶部和底部时保持3行距离  
set novisualbell    " 不要闪烁(不明白)  
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   "状态行显示的内容  
set laststatus=1    " 启动显示状态行(1),总是显示状态行(2)  
set foldenable      " 允许折叠  
set foldmethod=manual   " 手动折叠  
set background=dark "背景使用黑色 
set nocompatible  "去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限  
" 显示中文帮助
if version >= 603
    set helplang=cn
    set encoding=utf-8
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
" 不要使用vi的键盘模式，而是vim自己的
set nocompatible
" 语法高亮
set syntax=on
" 去掉输入错误的提示声音
set noeb
" 在处理未保存或只读文件的时候，弹出确认
set confirm
" 自动缩进
set autoindent
set cindent
" Tab键的宽度
set tabstop=4
" 统一缩进为4
set softtabstop=4
set shiftwidth=4
"禁止生成临时文件
set nobackup
set noswapfile
"搜索忽略大小写
set ignorecase
"搜索逐字符高亮
set hlsearch
set incsearch
"行内替换
set gdefault
"编码设置
set enc=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
"语言设置
set langmenu=zh_CN.UTF-8
set helplang=cn
" 我的状态行显示的内容（包括文件类型和解码）
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
"set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]
"set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\
" 总是显示状态行
set laststatus=2
" 命令行（在状态行下）的高度，默认为1，这里是2
set cmdheight=2
" 侦测文件类型
filetype on
" 载入文件类型插件
filetype plugin on
" 为特定文件类型载入相关缩进文件
filetype indent on
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
```

## 使用

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
+ or RETURN First character of next line                | ndd Delete n lines
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

ye Copy to end of word

File Handling | null
------------- | ----------------------------------
:w Write file | :w! Write file (ignoring warnings) | :w! file Overwrite file (ignoring warnings) | :wq Write file and quit | :q Quit | :q! Quit (even if changes not saved) | :w file Write file as file, leaving original untouched | ZZ Quit, only writing file if changed | 😡 Quit, only writing file if changed | :n1,n2w file Write lines n1 to n2 to file | :n1,n2w >> file Append lines n1 to n2 to file | :e file2 Edit file2 (current file becomes alternate file) | :e! Reload file from disk (revert to previous saved version) | :e# Edit alternate file | % Display current filename |

# Display alternate filename |

:n Edit next file | :n! Edit next file (ignoring warnings) | :n files Specify new list of files | :r file Insert file after cursor | :r !command Run command, and insert output after current line |

![](../_static/vim.png)

## 使用

vi有3个模式：插入模式、命令模式、低行模式

* 插入模式：在此模式下可以输入字符，按ESC将回到命令模式。
* 命令模式：可以移动光标、删除字符等。
* 低行模式：可以保存文件、退出vi、设置vi、查找等功能(低行模式也可以看作是命令模式里的)。

```sh
vi filename :打开或新建文件，并将光标置于第一行首
vi +n filename ：打开文件，并将光标置于第n行首
vi + filename ：打开文件，并将光标置于最后一行首
vi +/pattern filename：打开文件，并将光标置于第一个与pattern匹配的串处
vi -r filename ：在上次正用vi编辑时发生系统崩溃，恢复filename
vi -o/O filename1 filename2 … ：打开多个文件，依次进行编辑

# 关闭文件
:w ? ? ? //保存文件
:w vpser.net //保存至vpser.net文件
:q ? ? ? ? ?//退出编辑器，如果文件已修改请使用下面的命令
:q! ? ? ? ?//退出编辑器，且不保存
:wq ? ? ? ? //退出编辑器，且保存文件

# 移动光标类命令
h ：光标左移一个字符
l ：光标右移一个字符
k或Ctrl+p：光标上移一行
j或Ctrl+n ：光标下移一行

space：光标右移一个字符
Backspace：光标左移一个字符
Enter ：光标下移一行

w或W ：光标右移一个字至字首
b或B ：光标左移一个字至字首
e或E ：光标右移一个字至字尾

) ：光标移至句尾
( ：光标移至句首
}：光标移至段落开头
{：光标移至段落结尾

G   文档尾行
nG：光标移至第n行首
n+：光标下移n行
n-：光标上移n行
n$：光标移至第n行尾

H ：光标移至屏幕顶行
M ：光标移至屏幕中间行
L ：光标移至屏幕最后行

0：（注意是数字零）光标移至当前行首
$：光标移至当前行尾

a 光标向后移动一位
i 光标和内容没有变化
o 新起一个空白行
s 删除光标所在字符

n+ ? ? ? ?//向下跳n行
n- ? ? ? ? //向上跳n行
nG ? ? ? ?//跳到行号为n的行
G ? ? ? ? ? //跳至文件的底部

# 屏幕翻滚类命令
Ctrl+u：向文件首翻半屏
Ctrl+d：向文件尾翻半屏
Ctrl+f：向文件尾翻一屏
Ctrl＋b；向文件首翻一屏
nz：将第n行滚至屏幕顶部，不指定n时将当前行滚至屏幕顶部。

# 插入文本类命令
i ：在光标前
I ：在当前行首
a：光标后
A：在当前行尾
o：在当前行之下新开一行
O：在当前行之上新开一行
r：替换当前字符
R：替换当前字符及其后的字符，直至按ESC键
s：从当前光标位置处开始，以输入的文本替代指定数目的字符
S：删除指定数目的行，并以所输入文本代替之
ncw或nCW：修改指定数目的字
nCC：修改指定数目的行

# 复制、粘贴
yy ? ?//将当前行复制到缓存区，也可以用 “ayy 复制，”a 为缓冲区，a也可以替换为a到z的任意字母，可以完成多个复制任务。
nyy ? //将当前行向下n行复制到缓冲区，也可以用 “anyy 复制，”a 为缓冲区，a也可以替换为a到z的任意字母，可以完成多个复制任务。
yw ? ?//复制从光标开始到词尾的字符。
nyw ? //复制从光标开始的n个单词。
y^ ? ? ?//复制从光标到行首的内容。??
y$ ? ? ?//复制从光标到行尾的内容。
p ? ? ? ?//粘贴剪切板里的内容在光标后，如果使用了前面的自定义缓冲区，建议使用”ap 进行粘贴。
P ? ? ? ?//粘贴剪切板里的内容在光标前，如果使用了前面的自定义缓冲区，建议使用”aP 进行粘贴。

# 文本替换
:s/old/new ? ? ?//用new替换行中首次出现的old
:s/old/new/g ? ? ? ??//用new替换行中所有的old
:n,m?s/old/new/g ? ? //用new替换从n到m行里所有的old
:%s/old/new/g ? ? ?//用new替换当前文件里所有的old

# 简单替换表达式
? ? ? ??:%s/four/4/g
“%” 范围前缀表示在所有行中执行替换，最后的 “g” 标记表示替换行中的所有匹配点，如果仅仅对当前行进行操作，那么只要去掉%即可
如果你有一个像 “thirtyfour” 这样的单词，上面的命令会出错。这种情况下，这个单词会被替换成”thirty4″。要解决这个问题，用?“<”来指定匹配单词开头：
? ? ? ???:%s/<four/4/g
显然，这样在处理 “fourty” 的时候还是会出错。用?“>”?来解决这个问题：
:%s/<four>/4/g
如果你在编码，你可能只想替换注释中的 “four”，而保留代码中的。由于这很难指定，可以在替换命令中加一个 “c” 标记，这样，Vim 会在每次替换前提示你：
? ? ? ? :%s/<four>/4/gc
单词精确匹配替换
sed -e “s/\<old\>/new/g” ?file

#删除命令
ndw或ndW：删除光标处开始及其后的n-1个字
do：删至行首
d$：删至行尾
ndd：删除当前行及其后n-1行
x或X：删除一个字符，x删除光标后的，而X删除光标前的
Ctrl+u：删除输入方式下所输入的文本
cw      光标所在字符删除至单词结尾(是删除单词的便捷方式)，同时会进入编辑模式

x ? ? ? ? //删除当前字符
nx ? ? ? ? //删除从光标开始的n个字符
dd ? ? ? //删除当前行
ndd ? ? //向下删除当前行在内的n行
u ? ? ? ?//撤销上一步操作
U ? ? ? //撤销对当前行的所有操作

# 搜索及替换命令
/pattern：从光标开始处向文件尾搜索pattern
?pattern：从光标开始处向文件首搜索pattern
n：在同一方向重复上一次搜索命令
N：在反方向上重复上一次搜索命令
：s/p1/p2/g：将当前行中所有p1均用p2替代
：n1,n2s/p1/p2/g：将第n1至n2行中所有p1均用p2替代
：g/p1/s//p2/g：将文件中所有p1均用p2替换

# 选项设置
all：列出所有选项设置情况
term：设置终端类型
ignorance：在搜索中忽略大小写
list：显示制表位(Ctrl+I)和行尾标志（$)
number：显示行号
report：显示由面向行的命令修改过的数目
terse：显示简短的警告信息
warn：在转到别的文件时若没保存当前文件则显示NO write信息
nomagic：允许在搜索模式中，使用前面不带“/”的特殊字符
nowrapscan：禁止vi在搜索到达文件两端时，又从另一端开始
mesg：允许vi显示其他用户用write写到自己终端上的信息

# 最后行方式命令
：n1,n2 co n3：将n1行到n2行之间的内容拷贝到第n3行下
：n1,n2 m n3：将n1行到n2行之间的内容移至到第n3行下
：n1,n2 d ：将n1行到n2行之间的内容删除
：w ：保存当前文件
：e filename：打开文件filename进行编辑
：x：保存当前文件并退出
：q：退出vi
：q!：不保存文件并退出vi
：!command：执行shell命令command
：n1,n2 w!command：将文件中n1行至n2行的内容作为command的输入并执行之，若不指定n1，n2，则表示将整个文件内容作为command的输入
：r!command：将命令command的输出结果放到当前行

# 寄存器操作
“?nyy：将当前行及其下n行的内容保存到寄存器？中，其中?为一个字母，n为一个数字
“?nyw：将当前行及其下n个字保存到寄存器？中，其中?为一个字母，n为一个数字
“?nyl：将当前行及其下n个字符保存到寄存器？中，其中?为一个字母，n为一个数字
“?p：取出寄存器？中的内容并将其放到光标位置处。这里？可以是一个字母，也可以是一个数字
ndd：将当前行及其下共n行文本删除，并将所删内容放到1号删除寄存器中。

:set number 或 set nu           # 给编辑器设置行号
:set nonumber 或 set nonu       # 取消行号设置
:数字   # 光标跳转到数字所在行
:/内容/ 或 /内容         //内容查找，小写n(next)下一个,大写N(next)上一个
:s/cont1/cont2/         //把光标所在行的"第一个"cont1替换为cont2
:s/cont1/cont2/g        //把光标"所在行"的全部cont1替换为cont2
:%s/cont1/cont2/g       //把"整个文档"中的全部cont1替换为cont2

u       undo撤销，从文件打开后的所有操作都可以撤销
r       对单词字符进行替换
.       重复执行"最近"的一条指令
J       合并上下两行
```

### neovim

```sh
brew install neovim
```

### [syl20bnr/spacemacs](https://github.com/syl20bnr/spacemacs)

A community-driven Emacs distribution - The best editor is neither Emacs nor Vim, it's Emacs *and* Vim! http://spacemacs.org

```sh
brew tap d12frosted/emacs-plus
brew install emacs-plus
brew linkapps emacs-plus

emacs --insecure
```

## 配置

* [neovim/neovim](https://github.com/neovim/neovim):Vim-fork focused on extensibility and usability https://salt.bountysource.com/teams/n…
* [amix/vimrc](https://github.com/amix/vimrc):The ultimate Vim configuration: vimrc
* [Valloric/YouCompleteMe](https://github.com/Valloric/YouCompleteMe):A code-completion engine for Vim http://valloric.github.io/YouCompleteMe/
* [VundleVim/Vundle.vim](https://github.com/VundleVim/Vundle.vim):Vundle, the plug-in manager for Vim http://github.com/VundleVim/Vundle.Vim
* [philc/vimium](https://github.com/philc/vimium):The hacker's browser.
* [tpope/vim-pathogen](https://github.com/tpope/vim-pathogen):pathogen.vim: manage your runtimepath

## 工具doc

* [syl20bnr/spacemacs](https://github.com/syl20bnr/spacemacs):A community-driven Emacs distribution - The best editor is neither Emacs nor Vim, it's Emacs *and* Vim!

## 插件

* [cknadler/vim-anywhere](https://github.com/cknadler/vim-anywhere):Use Vim everywhere you've always wanted to
* https://github.com/rupa/z
* https://github.com/rupa/v
