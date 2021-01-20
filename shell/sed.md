# [sed stream editor](http://www.gnu.org/software/sed/manual/sed.html)

* 基于文本编辑器ed构建的"流编辑器",用程序的方式来编辑文本
* 基本上就是玩正则模式匹配
* 功能
  - 自动编辑一个或多个文件，简化对文件的反复操作，编写转换程序等，且支持正则表达式

```sh
sed -n '1,4 p' file.text
```

## 版本

* 不同版本间有不同之处，大部分不支持在编辑命令中间使用标签（:name）或分支命令（b,t），除非是放在那些的末尾
* GNU sed 让命令更紧凑

## 语法

* Pattern Space -n参数: 是否打印当前行
  - 一次处理一行内容
  - 处理时把当前处理行存储在临时缓存区中，称为"模式空间"(patternspace)
  - 接着用sed命令处理缓存区中内容，处理完成后，把缓存区内容标准输出
  - 然后读入下一行，执行下一个循环
  - 如果没有使用诸如'D'特殊命令，那么会在两个循环之间清空模式空间，但不会清空**保留空间**
  - 不断重复，直到文件末尾。文件内容并没有改变，除非使用重定向存储输出
* Address `[address[,address]][!]{cmd}`
  - !表示匹配成功后是否执行命令
  - 一个数字
  - 一个模式
  - 通过逗号要分隔两个address 表示两个address的区间
  - 相对位置
* 命令打包
  - cmd可以是多个，它们可以用分号分开，可以用大括号括起来作为嵌套命令
* Hold Space
  - g 将hold space中的内容拷贝到pattern space中，原来pattern space里的内容清除
  - G 将hold space中的内容append到pattern space\n后
  - h 将pattern space中的内容拷贝到hold space中，原来的hold space里的内容被清除
  - H 将pattern space中的内容append到hold space\n后
  - x 交换pattern space和hold space的内容
* 引号
  - 使用单引号（'…'）而非双引号 （"…"）这是因为sed通常是在Unix平台上使用
  - 单引号：Unix的shell（命令解释器）不会对美元符（$）和后引号（`…`）进行解释和执行
  - 双引号：美元符会被展开为变量或参数的值，后引号中的命令被执行并以输出的结果代替后引号中的内容
  - 在"csh"及其衍生的shell中使用感叹号（!）时需要在其前面加上转义用的反斜杠（就像这样：`\!`）以保证上面所使用的例子能正常运行（包括使用单引号的情况下）
  - DOS版本Sed则一律使用双引号（"…"）而不是引号来圈起命令
* '\t'用法
  - 为了使本文保持行文简洁，在脚本中使用'\t'来表示一个制表符。但是现在大部分版本的sed还不能识别'\t'的简写方式，因此当在命令行中为脚本输入制表符时，应该直接按TAB键来输入制表符而不是输入'\t'
  - 下列工具软件都支持'\t'做为一个正则表达式的字元来表示制表符：awk、perl、HHsed、sedmod以及GNU sed v3.02.80。
* 许多版本接受象"/one/ s/RE1/RE2/"这种在's'前带有空格的命令，有些却不接受 "/one/! s/RE1/RE2/"。这时只需要把中间的空格去掉就行
* 参数
  - -n 是--quiet|silent意思。表明忽略执行过程的输出，只输出结果即可
  - -i 所有改动将直接修改原文件内容
  - -f|--file <script文件> 以选项中指定文件来处理输入文本文件

```
foreach line in file {
    // 把行放入 Pattern_Space
    Pattern_Space <= line;
    // 对每个pattern space执行sed命令
    Pattern_Space <= EXEC(sed_cmd, Pattern_Space);
    // 如果没有指定 -n 则输出处理后的Pattern_Space
    if (sed option hasn't "-n")  {
       print Pattern_Space
    }
}

```

```sh
# 对3行到6行执行命令 /This/d
sed '3,6 {/This/d}' pets.txt
# 对3行到6行，匹配/This/成功后，再匹配/fish/，成功后执行d命令
sed '3,6 {/This/{/fish/d}}' pets.txt

# 反序一个文件的行
# 1!G —— 只有第一行不执行G命令，将hold space中的内容append回到pattern space
# h —— 第一行都执行h命令，将pattern space中的内容拷贝到hold space中
# $!d —— 除了最后一行不执行d命令，其它行都执行d命令，删除当前行
sed '1!G;h;$!d' t.txt
```

## 范围

* 行数从 1 开始
* 不给地址 对全文进行处理
* p 打印命令，打印当前模式空间内容，追加到匹配行之后
  - -n 显示匹配行 `nl log.txt | sed -n '/is/p'`
  - a替换A，多个用;分开 `nl log.txt | sed -n '/is/{s/a/A/;p}'`
* `n` 指定行/pattern/能够被模式匹配到的每一行
* `n,m` 从第n行到第m行
* `n,+m` 从第n行，加上其后面m行
* `1~2` ~ 表示步进，选择奇数行
* `2~2` 选择偶数行
* `2,$` 从第二行到文件结尾
* `/sys/,+3` 选择出现sys字样的行，以及后面的三行
* `n ,/pat1/` 从第n行到符合 /pat1/ 这个模式的行
* `/\^sys/,/mem/` 模式之间匹配，选择以sys开头行，和出现mem字样行之间的所有行

```sh
sed "3s/my/your/g" pets.txt
sed "3,6s/my/your/g" pets.txt
sed 's/s/S/1' my.txt
# 只替换每一行的第二个s
sed 's/s/S/2' my.txt
# 只替换第一行的第3个以后的s
sed 's/s/S/3g' my.txt

# 其中的+3表示后面连续3行
sed '/dog/,+3s/^/# /g' pets.txt
# 多个匹配
sed '1,3s/my/your/g; 3,$s/This/That/g' my.txt
sed -e '1,3s/my/your/g' -e '3,$s/This/That/g' my.txt

sed -n '5p' file
sed -n '2,5 p' file
sed -n '1~2 p' file
sed -n '2~2 p' file
sed -n '2,+3p' file
sed -n '2,$ p' file
# 查看第5-7行和10-13行
sed -n -e '5,7p' -e '10,13p' file

sed -n '/sys/,+3 p' file
sed -n '/^sys/,/mem/p' file
sed '/sys/,+3 s/a/b/g' file
sed '/^sys/,/mem/s/a/b/g' file

# 删除所有#开头的行和空行
sed -e 's/#.*//' -e '/^$/ d' file
```

## 编辑

* 地址定界后，对范围内容进行相关编辑
* 接受一个或多个编辑命令，并且每读入一行后就依次应用这些命令
* = 为模式空间中的行打印行号
* ! 模式空间中匹配行取反处理
* ； 对一行进行多次操作的命令的分割
* & 配合s///使用，代表前面所查找到的字符等
* `a [\]text` 在指定行后面追加文本支持使用\n 实现多行行后追加 `sed -e 4a\newline log.txt`
* `i [\]text` 在行前面插入文本
* `c [\]text` 替换匹配行 `nl log.txt | sed '2,3c No 2-3 number'`
* d 删除匹配行，这个时候就要去掉-n参数了,并立即启用下一轮循环 `nl log.txt | sed '2,3d'`
* D 如果模式空间包含换行符，则删除直到第一个换行符的模式空间中的文本，并不会读取新的输入行，而使用合成的模式空间重新启动循环。如果模式空间不包含换行符，则会像发出d 命令那样启动正常的新循环
* -e
* g 行内全局替换。也可以指定行内的第几个符合要求的进行替换：2g,就表示第2个替换
* n 读取匹配到的行的下一行覆盖至模式空间
* N 读取匹配到的行的下一行追加至模式空间,把下一行的内容纳入当成缓冲区做匹配
* P 打印模式空间开端至 \n 内容，并追加到默认输出之前
* q 读取到指定行之后退出,当只需要显示文件的前面的部分或需要删除后面的内容时,在处理大文件时，会节省大量时间
* r /path/somefile：读取指定文件的文本至模式空间中匹配到的行后
* s/// 查找替换, 支持使用其它分隔符，s@@@ ，s### `nl log.txt | sed -e '3d' -e 's/test/TEST/'`
* w /path/somefile 保存模式匹配行至指定文件

```sh
# 为文件中的每一行进行编号（简单的左对齐方式）。这里使用了"制表符"
# （tab，见本文末尾关于'\t'的用法的描述）而不是空格来对齐边缘。
sed = filename | sed 'N;s/\n/\t/'

# 对文件中的所有行编号（行号在左，文字右端对齐）。
sed = filename | sed 'N; s/^/ /; s/ *\(.\{6,\}\)\n/\1 /'

# 对文件中的所有行编号，但只显示非空白行的行号。
sed '/./=' filename | sed '/./N; s/\n/ /'

# 计算行数 （模拟 "wc -l"）
sed -n '$='

sed 'N;s/my/your/' pets.txt

sed "1 i This is my monkey, my monkey's name is wukong" my.txt
sed "$ a This is my monkey, my monkey's name is wukong" my.txt
sed "/fish/a This is my monkey, my monkey's name is wukong" my.txt
sed "/my/a ----" my.txt
sed "2 c This is my monkey, my monkey's name is wukong" my.txt
sed "/fish/c This is my monkey, my monkey's name is wukong" my.txt

sed '/fish/d' my.txt
sed '2d' my.txt
sed '2,$d' my.txt

# 从第一行打印到匹配fish成功的那一行
sed -n '1,/fish/p' my.txt
sed -n '/dog/,/fish/p' my.txt
```

## s substitute

* 查找替换其中某些值，并输出结果。使用替换模式很少使用-n参数
* 替换
  - 不能使用正则,常用精确替换
  - 替位符&：用在替换字符串中，代表原始查找匹配数据
    + [&] 表明将查找到的数据使用[]包围起来
    + "&" 表明将查找的数据使用"包围起来
* flag 参数
  - g 默认只匹配行中第一次出现的内容，加上g，一行上的替换所有的匹配
  - p 当使用-n参数，p将仅输出匹配行内容
  - w 和上面的w模式类似，仅输出有变换行
  - i 忽略大小写
  - e 表示将输出每一行，执行一个命令。不建议使用，可以使用xargs配合完成这种功能
* 字符转义 `\\，\*`之类的处理,可以使用|^@!四个字符来替换\
* 正则
  - ^ 表示一行的开头。如：/^#/ 以#开头的匹配
  - $ 表示一行的结尾。如：/}$/ 以}结尾的匹配
  - \< 表示词首。 如：\<abc 表示以 abc 为首的詞
  - `\>` 表示词尾。 如：`abc\>` 表示以 abc 結尾的詞
  - . 表示某个字符出现了0次或多次
  - [ ] 字符集合。 如：[abc] 表示匹配a或b或c
    + [a-zA-Z] 表示匹配所有的26个字符
    + 如果其中有^表示反，如 [^a] 表示非a的字符
  - * 0个或者多个匹配
  - + 1个或者多个匹配
  - ? 0个或者1个匹配
  - {m} 匹配重复m次
  - {m,n} 前面的匹配重复m到n次
  - \ 转义字符
  - [0-9] 匹配括号中的任何一个字符,or的作用
  - | or，或者
  - \b 匹配一个单词。比如\blucky\b 只匹配单词lucky
* 使用&来当做被匹配的变量
* 圆括号匹配: 圆括号括起来的正则表达式所匹配的字符串会可以当成变量来使用，sed中使用的是\1,\2

```sh
sed 's/^/#/g' pets.txt
sed 's/$/ --- /g' pets.txt

sed 's/my/[&]/g' my.txt

sed 's/This is my \([^,&]*\),.*is \(.*\)/\1:\2/g' my.txt

# 范围  匹配 替换 flag
sed '/^sys/s/a/b/g' file

# 输出长度不小于50个字符的行
sed -n '/^.{50}/p'
# 统计文件中有每个单词出现了多少次
sed 's/ /\n/g' file | sort | uniq -c
# 查找目录中的py文件，删掉所有行级注释
find ./ -name "*.py" | xargs sed  -i.bak '/^[ ]*#/d'

#通过加入一个参数，可以将原文件做个备份
sed -i.bak 's/a/b/' file
# 仅输出ip地址
ip route show | sed -n '/src/p' | sed -e 's/  */ /g' | cut -d' ' -f9
sed 's/a/b/g' file
sed 's/[a,b,c]/<&>/g' file
sed -n 's/a/b/gipw output.txt' file
sed 's/^/ls -la/e' file
sed '/aaa/s@/etc@/usr@g' file

# Unix环境：转换DOS的新行符（CR/LF）为Unix格式。
sed 's/.$//' # 假设所有行以CR/LF结束
sed 's/^M$//' # 在bash/tcsh中，将按Ctrl-M改为按Ctrl-V
sed 's/\x0D$//' # ssed、gsed 3.02.80，及更高版本

# Unix环境：转换Unix的新行符（LF）为DOS格式。
sed "s/$/`echo -e \\\r`/" # 在ksh下所使用的命令
# sed "s/$'"/`echo \\\r`/" # 在bash下所使用的命令
sed "s/$/`echo \\\r`/" # 在zsh下所使用的命令
sed 's/$/\r/' # gsed 3.02.80 及更高版本

# 删除所有#开头的行和空行。
sed -e 's/#.*//' -e '/^$/ d' file

# 在每一行后面增加一空行
sed G
# 将所有空行删除并在每一行后面增加一空行,这样在输出的文本中每一行后面将有且只有一空行。
sed '/^$/d;G'

# 在每一行后面增加两行空行
sed 'G;G'

# 将第一个脚本所产生的所有空行删除（即删除所有偶数行）
sed 'n;d'

# 在匹配式样"regex"的行之前插入一空行
sed '/regex/{x;p;x;}'

# 在匹配式样"regex"的行之后插入一空行
sed '/regex/G'

# 在匹配式样"regex"的行之前和之后各插入一空行
sed '/regex/{x;p;x;G;}'

# DOS环境：转换Unix新行符（LF）为DOS格式。
sed "s/$//" # 方法 1
sed -n p # 方法 2

# DOS环境：转换DOS新行符（CR/LF）为Unix格式。
# 下面的脚本只对UnxUtils sed 4.0.7 及更高版本有效。要识别UnxUtils版本的
# sed可以通过其特有的"–text"选项。你可以使用帮助选项（"–help"）看
# 其中有无一个"–text"项以此来判断所使用的是否是UnxUtils版本。其它DOS
# 版本的的sed则无法进行这一转换。但可以用"tr"来实现这一转换。
sed "s/\r//" infile >outfile # UnxUtils sed v4.0.7 或更高版本
tr -d \r <infile >outfile # GNU tr 1.22 或更高版本

# 将每一行前导的"空白字符"（空格，制表符）删除
# 使之左对齐
sed 's/^[ \t]*//' # 见本文末尾关于'\t'用法的描述

# 将每一行拖尾的"空白字符"（空格，制表符）删除
sed 's/[ \t]*$//' # 见本文末尾关于'\t'用法的描述

# 将每一行中的前导和拖尾的空白字符删除
sed 's/^[ \t]*//;s/[ \t]*$//'

# 在每一行开头处插入5个空格（使全文向右移动5个字符的位置）
sed 's/^/ /'

# 以79个字符为宽度，将所有文本右对齐
sed -e :a -e 's/^.\{1,78\}$/ &/;ta' # 78个字符外加最后的一个空格

# 以79个字符为宽度，使所有文本居中。在方法1中，为了让文本居中每一行的前
# 头和后头都填充了空格。 在方法2中，在居中文本的过程中只在文本的前面填充
# 空格，并且最终这些空格将有一半会被删除。此外每一行的后头并未填充空格。
sed -e :a -e 's/^.\{1,77\}$/ & /;ta' # 方法1
sed -e :a -e 's/^.\{1,77\}$/ &/;ta' -e 's/\( *\)\1/\1/' # 方法2

# 在每一行中查找字串"foo"，并将找到的"foo"替换为"bar"
sed 's/foo/bar/' # 只替换每一行中的第一个"foo"字串
sed 's/foo/bar/4' # 只替换每一行中的第四个"foo"字串
sed 's/foo/bar/g' # 将每一行中的所有"foo"都换成"bar"
sed 's/\(.*\)foo\(.*foo\)/\1bar\2/' # 替换倒数第二个"foo"
sed 's/\(.*\)foo/\1bar/' # 替换最后一个"foo"

# 只在行中出现字串"baz"的情况下将"foo"替换成"bar"
sed '/baz/s/foo/bar/g'

# 将"foo"替换成"bar"，并且只在行中未出现字串"baz"的情况下替换
sed '/baz/!s/foo/bar/g'

# 不管是"scarlet""ruby"还是"puce"，一律换成"red"
sed 's/scarlet/red/g;s/ruby/red/g;s/puce/red/g' #对多数的sed都有效
gsed 's/scarlet\|ruby\|puce/red/g' # 只对GNU sed有效

# 倒置所有行，第一行成为最后一行，依次类推（模拟"tac"）。
# 由于某些原因，使用下面命令时HHsed v1.5会将文件中的空行删除
sed '1!G;h;$!d' # 方法1
sed -n '1!G;h;$p' # 方法2

# 将行中的字符逆序排列，第一个字成为最后一字，……（模拟"rev"）
sed '/\n/!G;s/\(.\)\(.*\n\)/&\2\1/;//D;s/.//'

# 将每两行连接成一行（类似"paste"）
sed '$!N;s/\n/ /'

# 如果当前行以反斜杠"\"结束，则将下一行并到当前行末尾
# 并去掉原来行尾的反斜杠
sed -e :a -e '/\\$/N; s/\\\n//; ta'

# 如果当前行以等号开头，将当前行并到上一行末尾
# 并以单个空格代替原来行头的"="
sed -e :a -e '$!N;s/\n=/ /;ta' -e 'P;D'

# 为数字字串增加逗号分隔符号，将"1234567"改为"1,234,567"
sed ':a;s/\B[0-9]\{3\}\>/,&/;ta' # GNU sed
sed -e :a -e 's/\(.*[0-9]\)\([0-9]\{3\}\)/\1,\2/;ta' # 其他sed

# 为带有小数点和负号的数值增加逗号分隔符（GNU sed）
gsed -r ':a;s/(^|[^0-9.])([0-9]+)([0-9]{3})/\1\2,\3/g;ta'

# 在每5行后增加一空白行 （在第5，10，15，20，等行后增加一空白行）
gsed '0~5G' # 只对GNU sed有效
sed 'n;n;n;n;G;' # 其他sed

# 显示文件中的最后10行 （模拟"tail"）
sed -e :a -e '$q;N;11,$D;ba'

# 显示文件中的最后2行（模拟"tail -2"命令）
sed '$!N;$!D'

# 显示文件中的最后一行（模拟"tail -1"）
sed '$!d' # 方法1
sed -n '$p' # 方法2

# 显示文件中的倒数第二行
sed -e '$!{h;d;}' -e x # 当文件中只有一行时，输入空行
sed -e '1{$q;}' -e '$!{h;d;}' -e x # 当文件中只有一行时，显示该行
sed -e '1{$d;}' -e '$!{h;d;}' -e x # 当文件中只有一行时，不输出

# 只显示匹配正则表达式的行（模拟"grep"）
sed -n '/regexp/p' # 方法1
sed '/regexp/!d' # 方法2

# 只显示"不"匹配正则表达式的行（模拟"grep -v"）
sed -n '/regexp/!p' # 方法1，与前面的命令相对应
sed '/regexp/d' # 方法2，类似的语法

# 查找"regexp"并将匹配行的上一行显示出来，但并不显示匹配行
sed -n '/regexp/{g;1!p;};h'

# 查找"regexp"并将匹配行的下一行显示出来，但并不显示匹配行
sed -n '/regexp/{n;p;}'

# 显示包含"regexp"的行及其前后行，并在第一行之前加上"regexp"所
# 在行的行号 （类似"grep -A1 -B1"）
sed -n -e '/regexp/{=;x;1!p;g;$!N;p;D;}' -e h

# 显示包含"AAA"、"BBB"或"CCC"的行（任意次序）
sed '/AAA/!d; /BBB/!d; /CCC/!d' # 字串的次序不影响结果

# 显示包含"AAA"、"BBB"和"CCC"的行（固定次序）
sed '/AAA.*BBB.*CCC/!d'

# 显示包含"AAA""BBB"或"CCC"的行 （模拟"egrep"）
sed -e '/AAA/b' -e '/BBB/b' -e '/CCC/b' -e d # 多数sed
gsed '/AAA\|BBB\|CCC/!d' # 对GNU sed有效

# 显示包含"AAA"的段落 （段落间以空行分隔）
# HHsed v1.5 必须在"x;"后加入"G;"，接下来的3个脚本都是这样
sed -e '/./{H;$!d;}' -e 'x;/AAA/!d;'

# 显示包含"AAA""BBB"和"CCC"三个字串的段落 （任意次序）
sed -e '/./{H;$!d;}' -e 'x;/AAA/!d;/BBB/!d;/CCC/!d'

# 显示包含"AAA"、"BBB"、"CCC"三者中任一字串的段落 （任意次序）
sed -e '/./{H;$!d;}' -e 'x;/AAA/b' -e '/BBB/b' -e '/CCC/b' -e d
gsed '/./{H;$!d;};x;/AAA\|BBB\|CCC/b;d' # 只对GNU sed有效

# 显示包含65个或以上字符的行
sed -n '/^.\{65\}/p'

# 显示包含65个以下字符的行
sed -n '/^.\{65\}/!p' # 方法1，与上面的脚本相对应
sed '/^.\{65\}/d' # 方法2，更简便一点的方法

# 显示部分文本——从包含正则表达式的行开始到最后一行结束
sed -n '/regexp/,$p'

# 显示部分文本——指定行号范围（从第8至第12行，含8和12行）
sed -n '8,12p' # 方法1
sed '8,12!d' # 方法2

# 显示第52行
sed -n '52p' # 方法1
sed '52!d' # 方法2
sed '52q;d' # 方法3, 处理大文件时更有效率

# 从第3行开始，每7行显示一次
gsed -n '3~7p' # 只对GNU sed有效
sed -n '3,${p;n;n;n;n;n;n;}' # 其他sed

# 显示两个正则表达式之间的文本（包含）
sed -n '/Iowa/,/Montana/p' # 区分大小写方式

# 选择性地删除特定行：显示通篇文档，除了两个正则表达式之间的内容
sed '/Iowa/,/Montana/d'

# 删除文件中相邻的重复行（模拟"uniq"）
# 只保留重复行中的第一行，其他行删除
sed '$!N; /^\(.*\)\n\1$/!P; D'

# 删除文件中的重复行，不管有无相邻。注意hold space所能支持的缓存
# 大小，或者使用GNU sed。
sed -n 'G; s/\n/&&/; /^\([ -~]*\n\).*\n\1/d; s/\n//; h; P'

# 删除除重复行外的所有行（模拟"uniq -d"）
sed '$!N; s/^\(.*\)\n\1$/\1/; t; D'

# 删除文件中开头的10行
sed '1,10d'

# 删除文件中的最后一行
sed '$d'

# 删除文件中的最后两行
sed 'N;$!P;$!D;$d'

# 删除文件中的最后10行
sed -e :a -e '$d;N;2,10ba' -e 'P;D' # 方法1
sed -n -e :a -e '1,10!{P;N;D;};N;ba' # 方法2

# 删除8的倍数行
gsed '0~8d' # 只对GNU sed有效
sed 'n;n;n;n;n;n;n;d;' # 其他sed

# 删除匹配式样的行
sed '/pattern/d' # 删除含pattern的行。当然pattern
# 可以换成任何有效的正则表达式

# 删除文件中的所有空行（与"grep '.' "效果相同）
sed '/^$/d' # 方法1
sed '/./!d' # 方法2

# 只保留多个相邻空行的第一行。并且删除文件顶部和尾部的空行。
# （模拟"cat -s"）
sed '/./,/^$/!d' #方法1，删除文件顶部的空行，允许尾部保留一空行
sed '/^$/N;/\n$/D' #方法2，允许顶部保留一空行，尾部不留空行

# 只保留多个相邻空行的前两行。
sed '/^$/N;/\n$/N;//D'

# 删除文件顶部的所有空行
sed '/./,$!d'

# 删除文件尾部的所有空行
sed -e :a -e '/^\n*$/{$d;N;ba' -e '}' # 对所有sed有效
sed -e :a -e '/^\n*$/N;/\n$/ba' # 同上，但只对 gsed 3.02.*有效

# 删除每个段落的最后一行
sed -n '/^$/{p;h;};/./{x;/./p;}'

# 移除手册页（man page）中的nroff标记。在Unix System V或bash shell下使
# 用'echo'命令时可能需要加上 -e 选项。
sed "s/.`echo \\\b`//g" # 外层的双括号是必须的（Unix环境）
sed 's/.^H//g' # 在bash或tcsh中, 按 Ctrl-V 再按 Ctrl-H
sed 's/.\x08//g' # sed 1.5，GNU sed，ssed所使用的十六进制的表示方法

# 提取新闻组或 e-mail 的邮件头
sed '/^$/q' # 删除第一行空行后的所有内容

# 提取新闻组或 e-mail 的正文部分
sed '1,/^$/d' # 删除第一行空行之前的所有内容

# 从邮件头提取"Subject"（标题栏字段），并移除开头的"Subject:"字样
sed '/^Subject: */!d; s///;q'

# 从邮件头获得回复地址
sed '/^Reply-To:/q; /^From:/h; /./d;g;q'

# 获取邮件地址。在上一个脚本所产生的那一行邮件头的基础上进一步的将非电邮
# 地址的部分剃除。（见上一脚本）
sed 's/ *(.*)//; s/>.*//; s/.*[:<] *//'

# 在每一行开头加上一个尖括号和空格（引用信息）
sed 's/^/> /'

# 将每一行开头处的尖括号和空格删除（解除引用）
sed 's/^> //'

# 移除大部分的HTML标签（包括跨行标签）
sed -e :a -e 's/<[^>]*>//g;/</N;//ba'

# 将分成多卷的uuencode文件解码。移除文件头信息，只保留uuencode编码部分。
# 文件必须以特定顺序传给sed。下面第一种版本的脚本可以直接在命令行下输入；
# 第二种版本则可以放入一个带执行权限的shell脚本中。（由Rahul Dhesi的一
# 个脚本修改而来。）
sed '/^end/,/^begin/d' file1 file2 … fileX | uudecode # vers. 1
sed '/^end/,/^begin/d' "$@" | uudecode # vers. 2

# 将文件中的段落以字母顺序排序。段落间以（一行或多行）空行分隔。GNU sed使用
# 字元"\v"来表示垂直制表符，这里用它来作为换行符的占位符——当然你也可以
# 用其他未在文件中使用的字符来代替它。
sed '/./{H;d;};x;s/\n/={NL}=/g' file | sort | sed '1s/={NL}=//;s/={NL}=/\n/g'
gsed '/./{H;d};x;y/\n/\v/' file | sort | sed '1s/\v//;y/\v/\n/'

# 分别压缩每个.TXT文件，压缩后删除原来的文件并将压缩后的.ZIP文件
# 命名为与原来相同的名字（只是扩展名不同）。（DOS环境："dir /b"
# 显示不带路径的文件名）。
echo @echo off >zipup.bat
dir /b *.txt | sed "s/^\(.*\)\.TXT/pkzip -mo \1 \1.TXT/" >>zipup.bat

cat filename | sed '10q' # 使用管道输入
sed '10q' filename # 同样效果，但不使用管道输入
sed '10q' filename > newfile # 将输出转移（重定向）到磁盘上

sed -e '/AAA/b' -e '/BBB/b' -e '/CCC/b' -e d
sed '/AAA/b;/BBB/b;/CCC/b;d' # 甚至可以写成
sed '/AAA\|BBB\|CCC/b;d'

sed 's/foo/bar/g' filename # 标准替换命令
sed '/foo/ s/foo/bar/g' filename # 速度更快
sed '/foo/ s//bar/g' filename # 简写形式

sed -n '45,50p' filename # 显示第45到50行
sed -n '51q;45,50p' filename # 一样，但快得多

sed -i '$aHow are you today' log.txt

sed '2p' /etc/passwd
sed -n '2p' /etc/passwd
sed -n '1,4p' /etc/passwd
sed -n '/root/p' /etc/passwd
sed -n '2,/root/p' /etc/passwd
sed -n '/^$/=' file
sed -n –e '/^$/p' –e '/^$/=' file
sed '/root/a\superman' /etc/passwd
sed '/root/i\superman' /etc/passwd
sed '/root/c\superman' /etc/passwd
sed '/^$/d' file
sed '1,10d' file
nl /etc/passwd | sed '2,5d'
nl /etc/passwd | sed '2a tea'
sed 's/test/mytest/g' example
sed -n 's/root/&superman/p' /etc/passwd
sed -n 's/root/superman&/p' /etc/passwd
sed -e 's/dog/cat/' -e 's/hi/lo/' pets
sed –i.bak 's/dog/cat/g' pets

sed -n 'n;p' FILE
sed '1!G;h;$!d' FILE
sed -n '1!G;h;$p' FILE
sed 'N;D' FILE
sed '$!N;$!D' FILE
sed '$!d' FILE
sed 'G' FILE
sed 'g' FILE
sed '/^$/d;G' FILE
sed 'n;d' FILE

# sort -n 会按照数字顺序对输入进行排序 默认情况下是按照字典序排序
# -k1,1 则表示“仅基于以空格分割的第一列进行排序”
# ,n 部分表示“仅排序到第n个部分”，默认情况是到行尾
#
# paste命令来合并行(-s)，并指定一个分隔符进行分割 (-d)
ssh myserver journalctl
 | grep sshd
 | grep "Disconnected from"
 | sed -E 's/.*Disconnected from (invalid |authenticating )?user (.*) [^ ]+ port [0-9]+( \[preauth\])?$/\2/'
 | sort | uniq -c
 # | sort -nk1,1 | tail -n10
 # | awk '{print $2}' | paste -sd,
 # | awk '{print $1}' | R --slave -e 'x <- scan(file="stdin", quiet=TRUE); summary(x)'
 | gnuplot -p -e 'set boxwidth 0.5; plot "-" using 1:xtic(2) with boxes'

rustup toolchain list | grep nightly | grep -vE "nightly-x86" | sed 's/-x86.*//' | xargs rustup toolchain uninstall

ffmpeg -loglevel panic -i /dev/video0 -frames 1 -f image2 -
 | convert - -colorspace gray -
 | gzip
 | ssh mymachine 'gzip -d | tee copy.jpg | env DISPLAY=:0 feh -'
```

## 图书
* 《sed & awk》第二版 Dale Dougherty Arnold Robbins
* 《UNIX Text Processing》 Dale Dougherty

## 参考

* [SED 简明教程](https://coolshell.cn/articles/9104.html)
* Mike Arst写的教程——压缩包名称是"U-SEDIT2.ZIP"
