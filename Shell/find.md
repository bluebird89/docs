
```sh
find . -name PATTERN    ### 从当前目录查找符合 PATTERN 的文件
find /home -name PATTERN -exec ls -l {} \;  # 从 /home 文件查找所有符合 PATTERN 的文件，并交由 ls 输出详细信息
find / -name *.conf -type f -print | xargs file
find / -name *.conf -type f -print | xargs tar cjf test.tar.gz

```


###  [fzf](https://github.com/junegunn/fzf)

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

* 方便语法: fd PATTERN而不是find -iname '*PATTERN*'.
* 彩色终端输出 (类似于ls)
* 它是快速的 (见基准下面) .
* 聪明案例: 默认情况下,搜索不区分大小写. 如果模式包含大写字符*, 则切换为区分大小写字符. .
* 默认情况下,忽略隐藏的目录和文件.
* 忽略匹配.gitignore文件中的模式,默认情况.
* 正则表达式.
* Unicode感知.
* 命令输入量*50%*优于*find: -)
* 用类似于GNU穿行的语法，执行并行命令.

```sh
wget https://github.com/sharkdp/fd/releases/download/v8.1.1/fd_8.1.1_amd64.deb
sudo dpkg -i
```
