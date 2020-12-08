## grep Global Regular Expression Print

全局搜索正则表达式并打印出匹配的行

* 参数：
    - -c：只输出匹配行的计数
    - -i：表示不区分大小写
    - -h：查询多文件时不显示文件名
    - -l：查询多文件时只输出包含匹配字符的文件名
    - -n：显示匹配行及行号
    - -s：不显示不存在或无匹配文本的错误信息
    - -v：显示不包含匹配文本的所有行，表示反向查找
    - --color=auto ：可以将找到的关键词部分加上颜色的显示

```sh
grep “string” filename
grep root /etc/passwd
grep “string” filenameKeyword*
grep 'Ubuntu' *.txt
grep “startingKeyword.*endingKeyword” filename
grep -i “string” filename # 不会考虑搜索字符串是大写还是小写
grep -rn --color POST access.log # n则输出具体的行数

grep -rn --color Exception -A10 -B2   error.log # A  after  内容后n行 B  before  内容前n行 C  count?  内容前后n行

grep -vn 'png' linuxmi.py
grep -n '[^v]na' linuxmi.py
grep -n '[^a-z]na' linuxmi.py
grep -n '^ba' linuxmi.py
grep -n '^[^a-zA-Z]' linuxmi.py # 查询不以字母开头的字符串
grep -n '\.$' linuxmi.py
grep -n 'l..k' linuxmi.py # “.”匹配除\r\n外的任意一个字符。查询l与k之间包含两个字符的行
# l开头以e结尾中间至少包含一个x的行
grep -n 'lxx*e' linuxmi.py

# 删除目录中的所有class文件
find . | grep .class$ | xargs rm -rvf
#把所有的rmvb文件拷贝到目录
ls *.rmvb | xargs -n1 -i cp {} /mount/xiaodianying
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
