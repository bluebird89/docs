# vim

brew install MacVim

Vim的一个最大用途是批量修改文件，列模式，正则表达式替换，区域替换，

## 配置文件

～/.vimrc

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

```
vi有3个模式：插入模式、命令模式、低行模式
1）插入模式：在此模式下可以输入字符，按ESC将回到命令模式。
2）命令模式：可以移动光标、删除字符等。
3）低行模式：可以保存文件、退出vi、设置vi、查找等功能(低行模式也可以看作是命令模式里的)。
进入vi的命令
vi filename :打开或新建文件，并将光标置于第一行首
vi +n filename ：打开文件，并将光标置于第n行首
vi + filename ：打开文件，并将光标置于最后一行首
vi +/pattern filename：打开文件，并将光标置于第一个与pattern匹配的串处
vi -r filename ：在上次正用vi编辑时发生系统崩溃，恢复filename
vi -o/O filename1 filename2 … ：打开多个文件，依次进行编辑

vi 关闭文件

:w ? ? ? //保存文件
:w vpser.net //保存至vpser.net文件
:q ? ? ? ? ?//退出编辑器，如果文件已修改请使用下面的命令
:q! ? ? ? ?//退出编辑器，且不保存
:wq ? ? ? ? //退出编辑器，且保存文件

移动光标类命令
h ：光标左移一个字符
l ：光标右移一个字符
space：光标右移一个字符
Backspace：光标左移一个字符
k或Ctrl+p：光标上移一行
j或Ctrl+n ：光标下移一行
Enter ：光标下移一行
w或W ：光标右移一个字至字首
b或B ：光标左移一个字至字首
e或E ：光标右移一个字至字尾
) ：光标移至句尾
( ：光标移至句首
}：光标移至段落开头
{：光标移至段落结尾
nG：光标移至第n行首
n+：光标下移n行
n-：光标上移n行
n$：光标移至第n行尾
H ：光标移至屏幕顶行
M ：光标移至屏幕中间行
L ：光标移至屏幕最后行
0：（注意是数字零）光标移至当前行首
$：光标移至当前行尾

n+ ? ? ? ?//向下跳n行
n- ? ? ? ? //向上跳n行
nG ? ? ? ?//跳到行号为n的行
G ? ? ? ? ? //跳至文件的底部

屏幕翻滚类命令
Ctrl+u：向文件首翻半屏
Ctrl+d：向文件尾翻半屏
Ctrl+f：向文件尾翻一屏
Ctrl＋b；向文件首翻一屏
nz：将第n行滚至屏幕顶部，不指定n时将当前行滚至屏幕顶部。

插入文本类命令
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

复制、粘贴

yy ? ?//将当前行复制到缓存区，也可以用 “ayy 复制，”a 为缓冲区，a也可以替换为a到z的任意字母，可以完成多个复制任务。
nyy ? //将当前行向下n行复制到缓冲区，也可以用 “anyy 复制，”a 为缓冲区，a也可以替换为a到z的任意字母，可以完成多个复制任务。
yw ? ?//复制从光标开始到词尾的字符。
nyw ? //复制从光标开始的n个单词。
y^ ? ? ?//复制从光标到行首的内容。??
y$ ? ? ?//复制从光标到行尾的内容。
p ? ? ? ?//粘贴剪切板里的内容在光标后，如果使用了前面的自定义缓冲区，建议使用”ap 进行粘贴。
P ? ? ? ?//粘贴剪切板里的内容在光标前，如果使用了前面的自定义缓冲区，建议使用”aP 进行粘贴。

文本替换

:s/old/new ? ? ?//用new替换行中首次出现的old
:s/old/new/g ? ? ? ??//用new替换行中所有的old
:n,m?s/old/new/g ? ? //用new替换从n到m行里所有的old
:%s/old/new/g ? ? ?//用new替换当前文件里所有的old

简单替换表达式
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
删除命令
ndw或ndW：删除光标处开始及其后的n-1个字
do：删至行首
d$：删至行尾
ndd：删除当前行及其后n-1行
x或X：删除一个字符，x删除光标后的，而X删除光标前的
Ctrl+u：删除输入方式下所输入的文本

x ? ? ? ? //删除当前字符
nx ? ? ? ? //删除从光标开始的n个字符
dd ? ? ? //删除当前行
ndd ? ? //向下删除当前行在内的n行
u ? ? ? ?//撤销上一步操作
U ? ? ? //撤销对当前行的所有操作

搜索及替换命令
/pattern：从光标开始处向文件尾搜索pattern
?pattern：从光标开始处向文件首搜索pattern
n：在同一方向重复上一次搜索命令
N：在反方向上重复上一次搜索命令
：s/p1/p2/g：将当前行中所有p1均用p2替代
：n1,n2s/p1/p2/g：将第n1至n2行中所有p1均用p2替代
：g/p1/s//p2/g：将文件中所有p1均用p2替换

选项设置
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

最后行方式命令
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

寄存器操作
“?nyy：将当前行及其下n行的内容保存到寄存器？中，其中?为一个字母，n为一个数字
“?nyw：将当前行及其下n个字保存到寄存器？中，其中?为一个字母，n为一个数字
“?nyl：将当前行及其下n个字符保存到寄存器？中，其中?为一个字母，n为一个数字
“?p：取出寄存器？中的内容并将其放到光标位置处。这里？可以是一个字母，也可以是一个数字
ndd：将当前行及其下共n行文本删除，并将所删内容放到1号删除寄存器中。
```

## neovim

```sh
brew install neovim
```
## 配置

* [neovim/neovim](https://github.com/neovim/neovim):Vim-fork focused on extensibility and usability https://salt.bountysource.com/teams/n…
* [amix/vimrc](https://github.com/amix/vimrc):The ultimate Vim configuration: vimrc
* [Valloric/YouCompleteMe](https://github.com/Valloric/YouCompleteMe):A code-completion engine for Vim http://valloric.github.io/YouCompleteMe/
* [VundleVim/Vundle.vim](https://github.com/VundleVim/Vundle.vim):Vundle, the plug-in manager for Vim http://github.com/VundleVim/Vundle.Vim
* [philc/vimium](https://github.com/philc/vimium):The hacker's browser.
* [tpope/vim-pathogen](https://github.com/tpope/vim-pathogen):pathogen.vim: manage your runtimepath
