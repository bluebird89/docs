# sed

一种流编辑器，它一次处理一行内容。处理时，把当前处理的行存储在临时缓存区中，称为"模式空间"(patternspace)，接着用sed命令处理缓存区中的内容，处理完成后，把缓存区的内容送往屏幕。然后读入下一行，执行下一个循环。如果没有使用诸如'D'的特殊命令，那么会在两个循环之间清空模式空间，但不会清空保留空间。这样不断重复，直到文件末尾。文件内容并没有改变，除非你使用重定向存储输出。 sed的功能：主要用来自动编辑一个或多个文件，简化对文件的反复操作，编写转换程序等，且支持正则表达式！

### 地址定界：就是说明用来处理一行中的那个些部分的。

- 不给地址：对全文进行处理
- # ：指定的行/pattern/能够被模式匹配到的每一行
- # ,#：从第n行到第m行
- # ,+#：从第n行，加上其后面m行
- /pat1/,/pat2/：符合第一个模式和第二个模式的所有行
- # ,/pat1/：从第n行到符合 /pat1/ 这个模式的行
- 1~2 ：~ 这个符号表示步进，1~2 表示的是奇数行
- 2~2：表示的是偶数行

### 编辑命令：地址定界后，对范围内的内容进行相关编辑。

- d：删除模式空间匹配的行，并立即启用下一轮循环 `nl log.txt | sed '2,3d'`
- p：打印当前模式空间内容，追加到默认输出之后
- q：读取到指定行之后退出
- `a [\]text`：在指定行后面追加文本支持使用\n 实现多行行后追加 `sed -e 4a\newline log.txt`
- `i [\]text`：在行前面插入文本
- `c [\]text`：替换行为单行或多行文本 `nl log.txt | sed '2,3c No 2-3 number'`
- w /path/somefile：保存模式匹配的行至指定文件
- r /path/somefile：读取指定文件的文本至模式空间中匹配到的行后
- =：为模式空间中的行打印行号
- !：模式空间中匹配行取反处理
- s///：查找替换, 支持使用其它分隔符，s@@@ ，s### `nl log.txt | sed -e '3d' -e 's/test/TEST/'`
- ；：对一行进行多次操作的命令的分割
- &：配合s///使用，代表前面所查找到的字符等，&sm ；sm&。
- g：行内全局替换。也可以指定行内的第几个符合要求的进行替换：2g,就表示第2个替换。
- p：显示替换成功的行 `nl log.txt | sed -n '/is/p'` a替换A，多个用;分开`nl log.txt | sed -n '/is/{s/a/A/;p}'`
- w /PATH/TO/SOMEFILE：将替换成功的行保存至文件中
- -e