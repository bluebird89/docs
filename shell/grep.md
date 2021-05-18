## grep Global search REgrular expression and Print out the line

* `grep string filename` 全局搜索正则表达式并打印出匹配的行
  - give it your search term first, followed by what you’re searching within
  - By default it searches by line, and returns those lines that contain what you searched for
  - You can also send it input from STDIN
* 参数
  + -A: print n number of lines after the match
  + -B: print n number of lines before the match
  + -C #：context，前后各#行
  + --color: add color to the matched output --color=auto：将找到的关键词部分加上颜色的显示
  * 查询多文件 searching in multiple files
    - -h：查询多文件时不显示文件名
    - -l：查询多文件时只输出包含匹配字符的文件名
  + -e: search literally, and protects patterns starting with a hyphen 实现多个选项间的成逻辑or关系，grep –e 'cat ' -e 'dog' file
  + -c: instead of returning matches, return the number of matches 统计匹配的行数
  + -E: interpret search as an extended regular expression 使用正则
  + -F: interpret search as a list of fixed strings, including newlines, dots, etc
  + -f: get the search patterns from this file
  + -H: print the filename with each match
  + --help: get some help
  + -I 不区分大小写（单个字符）
  + -i: ignore the case of your search term 忽略字符大小写
  + -m: stop reading file after n number of matches
  + -n: print the line number of where matches were found 显示匹配的行号
  + -o: print only the matching part of the line 仅显示匹配到的字符串
  + -q: don’t output anything, but exit with status 0 if any match is found (check that status with echo $?). 静默模式，不输出任何信息
  + -r|--recursive 和指定"-d recurse"参数相同
  * -s：不显示不存在或无匹配文本的错误信息
  + -V: get grep’s version
  + -v：显示不被 pattern 匹配到的行，反向选择 ,查找文件中不包含"test"内容的行 show lines that don’t match, instead of those that do
  + -w: find matches surrounded by space 匹配整个单词,（字母，数字，下划线不算单词边界）
  + -x: return only an exact match

```sh
grep root /etc/passwd
grep "startingKeyword.*endingKeyword" filename

grep "string" filenameKeyword*
grep 'Ubuntu' *.txt
grep '[[:digit:]]' names.txt
grep '^[[:digit:]]' names.txt

grep -i "string" filename # 不会考虑搜索字符串是大写还是小写

grep -rn --color POST access.log # n则输出具体的行数
grep -rn --color Exception -A10 -B2   error.log # A  after  内容后n行 B  before  内容前n行 C  count?  内容前后n行

grep -v test log.txt

# 支持正则
grep -n '[^v]na' linuxmi.py
grep -n '[^a-z]na' linuxmi.py
grep -n '^ba' linuxmi.py
grep -n '^[^a-zA-Z]' linuxmi.py # 查询不以字母开头的字符串
grep -n '\.$' linuxmi.py
grep -n 'l..k' linuxmi.py # "."匹配除\r\n外的任意一个字符。查询l与k之间包含两个字符的行
# l开头以e结尾中间至少包含一个x的行
grep -n 'lxx*e' linuxmi.py

# 删除目录中的所有class文件
find . | grep .class$ | xargs rm -rvf
#把所有的rmvb文件拷贝到目录
ls *.rmvb | xargs -n1 -i cp {} /mÏount/xiaodianying

# find matches surrounded by space
grep -w 1 file.txt

grep '[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}' net.txt

# 查看Exception关键字的前2行和后10行
grep -rn --color Exception -A10 -B2   error.log

#查找/usr/下所有import关键字，已经它们所在的文件和行数
grep -rn --color import /usr/
```

## [ripgrep]](https://github.com/BurntSushi/ripgrep)

更好的grep,在递归目录匹配的时候，会忽略到配置在 .gitignore 中的规则

* 跟 fd 一样默认忽略隐藏目录和文件，遵守 .gitignore
* 比 grep 快得多
* [](https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md)

```sh
sudo apt-get install ripgrep

rg -n -w '[A-Z]+_SUSPEND'
rg -uuu -tc -n -w '[A-Z]+_SUSPEND'
rg -w 'Sherlock [A-Z]\w+'

rg fast README.md
rg 'fast\w+' README.md
rg 'fast\w*' README.md
```

## [ack](https://github.com/beyondgrep/ack3)

ack is a grep-like search tool optimized for source code. <https://beyondgrep.com/>

## [the_silver_searcher](https://github.com/ggreer/the_silver_searcher)

A code-searching tool similar to ack, but faster. http://geoff.greer.fm/ag/
