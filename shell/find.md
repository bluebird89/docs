## 查找

* `find [path] [option] [action]`: 不但可以通过文件类型、文件名进行查找而且可以根据文件的属性（如文件的时间戳，文件的权限等）进行搜索
* 第一个参数：搜索的起点
* 可选参数
  - -name：按名称搜索
  - 在末尾添加`-ls`会显示文件相关的详细信息
  - `-size 189b`:找到 189 个块大小的文件，而不是 189 个字节
    + 189c（字符）
    + 200w：字
  - -inum: 通过用于维护文件元数据（即除文件内容和文件名之外的所有内容）的索引节点来查找文件
  - -group:用户组拥有的文件
  - -nouser: 查找不属于当前系统上的任何用户的文件
  - -mtime:查找在某个参考时间范围内状态（如权限）发生更改的文件
  - -atime:查找在访问过的本地文件
  - -newer:查找比其他文件更新的文件
  - 文件类型找到一个文件
    + b      块特殊文件（缓冲的）
    + c      字符特殊文件（无缓冲的）
    + d      目录
    + p      命名管道（FIFO）
    + f      常规文件
    + l      符号链接
    + s      套接字
  - -mindepth 和 -maxdepth 选项控制在文件系统中搜索的深度（从当前位置或起始点开始）
  - -empty:寻找空文件，但不进入目录及其子目录
  - -perm:查找具有特定权限集的文件
  - -exec:执行命令
    + {} 代表根据搜索条件找到的每个文件的名称
    + -exec 替换为 -ok：会在删除任何文件之前要求确认
* 通配符 `*` ，请将搜索字符串放到单引号或双引号内，以避免通配符被 shell 所解释

```sh
find  /  -name passwd     # "递归遍历"系统全部目录查找名字等于passwd的文件
find . -type f -name "*.css"  # List all CSS files (including subdirectories)
find . -type f \( -name "*.css" -or -name "*.html" \) # List all CSS or HTML files
find . -name  "an*"  # 模糊查找文件名字以an开始

find -size +1G -ls 2>/dev/null
find  ./  -size  +50c # 在当前目录下查找大小[大于]50个字节的文件

find -inum 919674 -ls 2>/dev/null

find / -user user1 # 搜索属于用户 'user1' 的文件和目录
find /tmp -group admins -ls
find /tmp -nouser -ls

find /usr/bin -type f -atime +100 # 搜索在过去100天内未被使用过的执行文件
find /usr/bin -type f -mtime -10 # 搜索在10天内被创建或者修改过的文件
find . -newer dig1 -ls

find . -type l -ls

find . -maxdepth 2 -empty -type f -ls

find -perm 777 -type f -ls

find / -name \*.rpm -exec chmod 755 '{}' \; # 搜索以 '.rpm' 结尾的文件并定义其权限
find . -name runme -exec rm {} \; # 定位并删除文件
find . -name runme -ok rm -rf {} \;

find / -xdev -name \*.rpm # 搜索以 '.rpm' # 结尾的文件，忽略光驱、捷盘等可移动设备

find / -name passwd -mindepth 3 -maxdepth 4 # 在3到4个层次的目录里边定位passwd文件

find . -name PATTERN    ### 从当前目录查找符合 PATTERN 的文件
find /home -name PATTERN -exec ls -l {} \;  # 从 /home 文件查找所有符合 PATTERN 的文件，并交由 ls 输出详细信息
find / -name *.conf -type f -print | xargs file
find / -name *.conf -type f -print | xargs tar cjf test.tar.gz
```

## [fzf](https://github.com/junegunn/fzf)

* 🌸 A command-line fuzzy finder
* `git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install`
* Use
  - CTRL-J / CTRL-K (or CTRL-N / CTRL-P) to move cursor up and down
  - Enter key to select the item, CTRL-C / CTRL-G / ESC to exit
  - On multi-select mode (-m), TAB and Shift-TAB to mark multiple items
  - Emacs style key bindings
  - Mouse: scroll, click, double-click; shift-click and shift-scroll on multi-select mode

## [fd](https://github.com/sharkdp/fd)

A simple, fast and user-friendly alternative to 'find'

* 方便语法: fd PATTERN 而不是 `find -i name '*PATTERN*'`
* 彩色终端输出
* 聪明案例: 默认情况下,搜索不区分大小写. 如果模式包含大写字符*, 则切换为区分大小写字符.
* 默认情况下,忽略隐藏的目录和文件,要禁用此行为,使用-H (或) --hidden选项
  - 忽略来自特定子目录的搜索结果. 使用-E (或) --exclude选择此选项 `fd -H -E .git …`
* 默认情况忽略匹配.gitignore文件,禁用此行为,使用-I (或) --no-ignore选项
* 支持正则表达式
* Unicode感知
* 命令输入量*50%*优于*find: -)
* 用类似于GNU穿行的语法，执行并行命令

```sh
wget https://github.com/sharkdp/fd/releases/download/v8.1.1/fd_8.1.1_amd64.deb
sudo dpkg -i fd_8.1.1_amd64.deb

SAGE:
    fd [FLAGS/OPTIONS] [<pattern>] [<path>...]

FLAGS:
    -H, --hidden            搜索隐藏的文件和目录
    -I, --no-ignore         不要忽略 .(git | fd)ignore 文件匹配
        --no-ignore-vcs     不要忽略.gitignore文件的匹配
    -s, --case-sensitive    区分大小写的搜索（默认值：智能案例）
    -i, --ignore-case       不区分大小写的搜索（默认值：智能案例）
    -F, --fixed-strings     将模式视为文字字符串
    -a, --absolute-path     显示绝对路径而不是相对路径
    -L, --follow            遵循符号链接
    -p, --full-path         搜索完整路径（默认值：仅限 file-/dirname）
    -0, --print0            用null字符分隔结果
    -h, --help              打印帮助信息
    -V, --version           打印版本信息

OPTIONS:
    -d, --max-depth <depth>        设置最大搜索深度（默认值：无）
    -t, --type <filetype>...       按类型过滤：文件（f），目录（d），符号链接（l），
                                   可执行（x），空（e）
    -e, --extension <ext>...       按文件扩展名过滤
    -x, --exec <cmd>               为每个搜索结果执行命令
    -E, --exclude <pattern>...     排除与给定glob模式匹配的条目
        --ignore-file <path>...    以.gitignore格式添加自定义忽略文件
    -c, --color <when>             何时使用颜色：never，*auto*, always
    -j, --threads <num>            设置用于搜索和执行的线程数
    -S, --size <size>...           根据文件大小限制结果。

ARGS:
    <pattern>    the search pattern, a regular expression (optional)
    <path>...    the root directory for the filesystem search (optional)

fd netfl
fd '^x.*rc$'
# 指定根目录
fd passwd /etc
# fd可以不带参数调用. 这是非常有用的,以便快速地查看当前目录中的所有条目,递归地
fd

#特定文件扩展名
fd -e md

# 隐藏和忽略的文件
fd -H pre-commit

fd -0 -e rs | xargs -0 wc -l

# 使用fd生成fzf命令行模糊查找器的输入:
export FZF_DEFAULT_COMMAND='fd --type file'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
键入vim <Ctrl-T>在你的终端打开FZF，也即是fd的搜索结果

# 遵循符号链接并包含隐藏文件 (但不包括.git文件夹)
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git'

# 置fzf内的fd的颜色输出:
export FZF_DEFAULT_COMMAND="fd --type file --color=always"
export FZF_DEFAULT_OPTS="--ansi"
```
