## AWK

* 命名得自于三个创始人姓别的首字母
* 一种报表生成器
* linux上使用的是GNU awk简称gawk pattern scanning and processing language：（模式扫描和处理语言），gawk其实就是awk的链接文件，gawk是一种过程式编程语言，支持条件判断、数组、循环等各种编程语言中所有可以使用的功能
* 同sed命令类似，只不过sed擅长取行，awk命令擅长取列
* 功能
  - 打印文件中某一列
  - 对文件进行格式化处理的，对文件内容进行各种“排版”，进而格式化显示

## 应用

* 格式
  - `awk [options] -f progfile [--] file`
  - `awk [options] [--] 'program' file`
  - `awk [options] 'BEGIN{ action;… } pattern{ action;… } END{ action;… }' file`
* options
      + -f progfile，--file=progfile：read program file
      + -F fs，--field-separator=fs： define input field separator by extended regex
      + -v var=val，--assign=var=val：assign values to variables
* pattern:根据pattern模式，过滤匹配的行
  - 未指定：表示空模式，匹配每一行
  - /regular expression/：仅处理能够模式匹配到的行，支持正则表达式，需要用/ /括起来
  - 关系表达式：结果为“真”才会被处理。真：结果为非0值，非空字符串。假：结果为空字符串或0值
  - /pat1/,/pat2/：startline,endline ，行范围,支持正则表达式，不支持直接给出数字格式
* 流程
  - 执行[option]相关内容
  - BEGIN{} 仅在开始处理文件中的文本之前执行一次。比如变量初始化、打印输出表格的表头等语句
  - 从文件或标准输入(stdin)读取每一行，然后执行pattern{action;…}语句块，逐行扫描文件，直到文件全部被读取完毕
  - pattern语句块:可选,如果没有提供pattern 语句块，则默认执行{ print } ，即打印每一个读取到的行
  - END{}仅在文本处理完成之后执行一次。比如打印所有行的分析结果这类信息汇总，可选语句块

```sh
awk -F "," '/^a/ {print $1,$2}' file
#    参数    范围  操作

netstat  -ant |
awk ' \
    BEGIN{print  "State","Count" }  \
    /^tcp/ \
    { rt[$6]++ } \
    END{  for(i in rt){print i,rt[i]}  }'
```

## 语法

* 主程序部分用单引号‘包围
* 列$是以1开始的，而0指的是原始字符串
* 变量：分为内置变量和自定义变量，声明-v
  - 内置变量
    + FS：输入字段分隔符，默认为空白字符，想当于-F选项。分隔符可以是多个，用[]括起来表示,如：-v FS="[,./-:;]"
    + OFS：输出字段分隔符，默认为空白字符，分隔符可以是多个，同上
    + RS ：输入记录(所认为行)分隔符，指定输入时的换行符，原换行符仍有效，分隔符可以是多个，同上
    + ORS ：指定记录输出的分隔标志 输出记录(所认为的行)分隔符，输出时用指定符号代替换行符，分隔符可以是多个，同上
    + NF：列数
    + NR：行号
    + FNR ：各文件分别计数, 记录数（行号）
    + FILENAME ：当前文件名
    + ARGC：命令行参数个数
    + ARGV ：数组，保存命令行所给定各参数
  - 自定义变量(区分字符大小写)：
    + 在'{...}'前，需要用-v var=value：awk -v var=value '{...}'
    + FILENAME 当前处理的文件名称，在一次性处理多个文件时非常有用
    + program 中直接定义：awk '{var=vlue}'

* print和printf:都是打印输出，两者用法和显示上有些不同
  - `print item1,item2, ...`
  - `printf “FORMAT ”,item1,item2, ...`
  - 要点：
    + 逗号为分隔符时，显示空格
    + 分隔符分隔的字段（域）标记称为域标识，用$0,$1,$2,...,$n表示，其中$0 为所有域，$1就是表示第一个字段（域），以此类推
    + 输出各item可以字符串，也可以是数值，当前记录的字段，变量或awk 的表达式等
    + 如果省略了item ，相当于print $0
    + 对于printf来说，必须指定FORMAT，即必须指出后面每个itemsN的输出格式，且还不会自动换行，需要显式则指明换行控制符"\n"
  - printf格式符和修饰符
    + %c：显示字符的ASCII码
    + %d, %i：显示十进制整数
    + %e, %E：显示科学计数法数值
    + %f：显示为浮点数
    + %g, %G：以科学计数法或浮点形式显示数值
    + %s：显示字符串
    + %u：无符号整数
    + %%：显示%自身
    + #[.#]：第一个数字控制显示的宽度；第二个#表示小数点后精度，%3.1f
    + -：左对齐（默认右对齐）；%-15s，就是以左对齐方式显示15个字符长度
    + +：显示数值的正负符号 %+d

* 操作符
  - 算术操作符：x+y, x-y, x*y, x/y, x^y, x%y
  -
  - 赋值操作符：=, +=, -=, *=, /=, %=, ^=，++, --
  - 比较操作符：==, !=, >, >=, <, <=
  - 模式匹配符：~ ：左边是否和右边匹配包含；!~ ：是否不匹配
  - 逻辑操作符：与:&& ；或:|| ；非:!
  - 条件表达式（三目表达式）：selector ? if-true-expression : if-false-expression

* action分类
  - 表达式：算术表达式和比较表达式
  - 控制：进行控制
    + if-else
      * {if(condition){statement;…}}：条件满足就执行statement
      * {if(condition){statement1;…}{else statement2}}：条件满足执行statement1，不满足执行statement2
      * {if(condition1){statement1}else if(condition2){statement2}else{statement3}}：条件1满足执行statement2，不满足条件1但满足条件2执行statement2，所用条件都不满足就执行statement3
    + switch
      * switch(expr) {case VAL1 or /REGEXP/:statement1; case VAL2 or /REGEXP2/: statement2;...; default: statementn}：若expr满足 VAL1 or /REGEXP/就执行statement1，若expr满足VAL2 or /REGEXP2/就执行statement2，以此类推，执行statementN，都不满足就执行statement
    + while和do-while
      * while(condition){statement;…}：条件为“真”时，进入循环；条件为“假”时， 退出循环
      * do {statement;…}while(condition)：无论真假，至少执行一次循环体。当条件为“真”时，退出循环；条件为“假”时，继续循环
    + for
      * for(expr1;expr2;expr3){statement;…}：expr1为变量赋值，如var=value，初始进行变量赋值；expr2为条件判断语句，j<=10，满足条件就继续执行statement；expr3为迭代语句，如j++，每次执行完statement后就迭代增加
      * for(var in array) {for-body}：变量var遍历数组，每个数组中的var都会执行一次for-body
    + break 和continue，用于条件判断循环语句，next是用于awk自身循环的语句
      * break[n]：当第n次循环到来后，结束整个循环，n=0就是指本次循环
      * continue[n]：满足条件后，直接进行第n次循环，本次循环不在进行，n=0也就是提前结束本次循环而直接进入下一轮
      * next：提前结束对本行的处理动作而直接进入下一行处理
  - 输入：用来做为输入，变量赋值就算是
  - 输出：用来输出显示的，典型的是print和printf

* 数组：关联数组，格式：`array[index-expression]：arry为数组名，index-expression为下标`
  - 实际上index-expression可使用任意字符串，字符串要使用双引号括起来 `arr[key] = value`
  - 如果某数组元素事先不存在，在引用时，awk 会自动创建此元素，并将其值初始化为“空串”
  - 判断数组中是否存在某元素：“index in array”格式进行遍历
  - 遍历数组中的每个元素：for(var in array) {for-body array[var] }
  - `delete arr[key]`
* 函数
  - rand()：返回0 和1 之间一个随机数
  - srand()：生成随机数种子
  - int()：取整数
  - log()
  - sqrt()
  - sin()
  - cos()
  - atan2()
  - length([s])：返回指定字符串的长度
  - sub(r,s,[t])：对t字符串进行搜索，r表示的模式匹配的内容，并将第一个匹配的内容替换为s
  - gsub(r,s,[t])：对t字符串进行搜索，r表示的模式匹配的内容，并全部替换为s所表示的内容
  - split(s,array,[r])：以r为分隔符，切割字符串s，并将切割后的结果保存至array 所表示的数组中，第一个索引值为1, 第二个索引值为2,…也就是说awk的数组下标是从1开始编号的。
  - substr(s,i,[n])：从s所表示的字符串中取子串，取法：从i表示的位置开始，取n个字符。
  - systime()：取当前系统时间，结果形式为时间戳。
  - system()：调用shell中的命令。空格是awk中的字符串连接符，如果system 中需要使用awk中的变量可以使用空格分隔，或者说除了awk的变量外其他一律用"" 引用 起来。

```sh
awk -F ","  '{print $1,$2}' file

# 变量
# FS 输入字段分割符
awk -v FS=':' '{print $1,FS,$3}' /etc/passwd
awk –F: '{print $1,$3,$7}' /etc/passwd
# OFS 输出风格符
awk -v FS=':' -v OFS=':' '{print $1,$3,$7}' /etc/passwd
# RS 输入换行符
awk -v RS=' ' '{print }' /etc/passwd
awk -v RS="[[:space:]/=]" '{print }' /etc/fstab |sort
# ORS 输出换行符
awk -v RS=' ' -v ORS='###' '{print }' /etc/passwd
awk 'BEGIN{FS=":";OFS="-"}{print $1,$2,$4}' file
# NF 列数
awk -F： '{print NF}' /etc/fstab
awk -F: '{print $(NF-1)}' /etc/passwd
awk -F, '{if(NF==3){print}}' file
# 过滤（去掉）空白行
awk 'NF' file
# 行数
awk '{print NR,$0}' /etc/fstab
awk 'END{print NR}' /etc/fstab
awk '{print FNR}' /etc/fstab /etc/inittab
awk '{print FILENAME}' /etc/fstab

awk '{print ARGC}' /etc/fstab /etc/inittab
awk 'BEGIN {print ARGC}' /etc/fstab /etc/inittab
awk 'BEGIN {print ARGV[1]}' /etc/fstab  /etc/inittab
awk -v test='hello gawk' '{print test}' /etc/fstab
awk -v test='hello gawk' 'BEGIN{print test}'
awk 'BEGIN{test="hello,gawk";print test}'
awk -F: '{sex=“male”;print $1,sex,age;age=18}' /etc/passwd
awk -F: '{sex="male";age=18;print $1,sex,age}' /etc/passwd

echo "{print script,\$1,\$2}"  > awkscript
awk -F: -f awkscript script=“awk” /etc/passwd

# print
awk '{print "hello,awk"}'
awk –F: '{print}' /etc/passwd
awk –F: '{print “wang”}' /etc/passwd
awk –F: '{print $1}' /etc/passwd
awk –F: '{print $0}' /etc/passwd
awk –F: '{print $1”\t”$3}' /etc/passwd

tail –3 /etc/fstab |awk '{print $2,$4}'

awk -F: '{printf "%s",$1}' /etc/passwd
awk -F: '{printf "%s\n",$1}' /etc/passwd
awk -F: '{printf "%-20s %10d\n",$1,$3}' /etc/passwd
awk -F: '{printf "Username: %s\n",$1}' /etc/passwd
awk -F: '{printf “Username: %s,UID:%d\n",$1,$3}' /etc/passwd
awk -F: '{printf "Username: %15s,UID:%d\n",$1,$3}' /etc/passwd
awk -F: '{printf "Username: %-15s,UID:%d\n",$1,$3}' /etc/passwd

awk -v FS=" " 'BEGIN{printf "%s %26s %10s\n","Module","Size","Used by"}{printf "%-20s %13d %5s %s\n",$1,$2,$3,$4}' /proc/modules

# 操作符
awk –F: '$0 ~ /root/{print $1}' /etc/passwd
awk '$0~“^root"' /etc/passwd
awk '$0 !~ /root/' /etc/passwd
awk –F: '$3==0' /etc/passwd
awk –F: '$3>=0 && $3<=1000 {print $1}' /etc/passwd
awk -F: '$3==0 || $3>=1000 {print $1}' /etc/passwd
awk -F: '!($3==0) {print $1}' /etc/passwd
awk -F: '!($3>=500) {print $3}' /etc/passwd
awk -F: '{$3>=1000?usertype="Common User":usertype="Sysadmin or SySUSEr";printf "%15s:%-s\n",$1,usertype}' /etc/passwd

# Pattern
awk '/^UUID/{print $1}' /etc/fstab
awk '!/^UUID/{print $1}' /etc/fstab
awk -F: '/^root\>/,/^nobody\>/{print $1}' /etc/passwd
awk -F: '(NR>=10&&NR<=20){print NR,$1}'  /etc/passw
awk -F: 'i=1;j=1{print i,j}' /etc/passwd
awk ‘!0’ /etc/passwd
awk ‘!1’ /etc/passwd
awk -F: '$3>=1000{print $1,$3}' /etc/passwd
awk -F: '$3<1000{print $1,$3}' /etc/passwd
awk -F: '$NF=="/bin/bash"{print $1,$NF}' /etc/passwd
awk -F: '$NF ~ /bash$/{print $1,$NF}' /etc/passwd
awk -F: 'BEGIN {print "USER USERID"} {print $1":"$3}END{print "end file"}' /etc/passwd
awk -F: 'BEGIN{print "    USER     USERID"}{printf "|%8s| %10d|\n",$1,$3}END{print "END FILE"}' /etc/passwd
awk -F: '{print "USER USERID“;print $1":"$3} END{print"end file"}' /etc/passwd
awk -F: 'BEGIN{print " USER UID \n---------------"}{print $1,$3}' /etc/passwd
awk -F: 'BEGIN{print "    USER     USERID\n----------------------"}{printf "|%8s| %10d|\n",$1,$3}END{print "----------------------\nEND FILE"}' /etc/passwd
awk -F: 'BEGIN{print " USER UID \n---------------"}{print $1,$3}'END{print "=============="} /etc/passwd

seq 10 | awk 'i=0'
seq 10 | awk 'i=1'
seq 10 | awk 'i=!i'
seq 10 | awk '{i=!i;print i}'
seq 10 | awk '!(i=!i)'
seq 10 | awk -v i=1 'i=!i'

# if-else
awk -F: '{if($3>=1000)print $1,$3}' /etc/passwd
awk -F: '{if($NF=="/bin/bash") print $1}' /etc/passwd
awk '{if(NF>5) print $0}' /etc/fstab
awk -F: '{if($3>=1000) {printf "Common user: %s\n",$1}else{printf "root or Sysuser: %s\n",$1}}' /etc/passwd
awk -F: '{if($3>=1000) printf "Common user: %s\n",$1;else printf "root or Sysuser: %s\n",$1}' /etc/passwd
df -h|awk -F% '/^\/dev/{print $1}'|awk '$NF>=80{print $1,$5}'
awk 'BEGIN{ test=100;if(test>90){print "very good"}else if(test>60){ print "good"}else{print "no pass"}}'

# while
awk '/^[[:space:]]*linux16/{i=1;while(i<=NF){print $i,length($i); i++}}' /etc/grub2.cfg
awk '/^[[:space:]]*linux16/{i=1;while(i<=NF) {if(length($i)>=10){print $i,length($i)}; i++}}' /etc/grub2.cfg
awk 'BEGIN{ total=0;i=0;do{total+=i;i++}while(i<=100);print total}'

# for
awk '/^[[:space:]]*linux16/{for(i=1;i<=NF;i++) {print $i,length($i)}}' /etc/grub2.cfg
awk '/^[^#]/{type[$3]++}END{for(i in type)print i,type[i]}' /etc/fstab
awk -v RS="[[:space:]/=,-]" '/[[:alpha:]]/{ha[$0]++}END{for(i in ha)print i,ha[i]}' /etc/fstab

awk 'BEGIN{sum=0;for(i=1;i<=100;i++){if(i%2==0)continue;sum+=i}print sum}'
awk 'BEGIN{sum=0;for(i=1;i<=100;i++){if(i==66)break;sum+=i}print sum}'
awk -F: '{if($3%2!=0) next; print $1,$3}' /etc/passwd

# 数组
awk 'BEGIN{weekdays["mon"]="Monday";weekdays["tue"]="Tuesday";print weekdays["mon"]}‘
awk '!arr[$0]++' dupfile
awk '{!arr[$0]++;print $0, arr[$0]}' dupfile
awk 'BEGIN{weekdays["mon"]="Monday";weekdays["tue"]="Tuesday";for(i in weekdays) {print weekdays[i]}}‘
netstat -tan | awk '/^tcp/{state[$NF]++}END{for(i in state) { print i,state[i]}}'
awk '{ip[$1]++}END{for(i in ip) {print i,ip[i]}}'/var/log/httpd/access_log

# 函数
awk 'BEGIN{srand(); for (i=1;i<=10;i++)print int(rand()*100) }'
echo "2008:08:08 08:08:08" | awk 'sub(/:/,“-",$1)'
echo "2008:08:08 08:08:08" | awk 'gsub(/:/,“-",$0)'
netstat -tan | awk '/^tcp\>/{split($5,ip,":");count[ip[1]]++}END{for (i in count) {print i,count[i]}}'
awk BEGIN'{system("hostname") }'
awk 'BEGIN{score=100; system("echo your score is " score) }'

# 自定义函数
function fname ( arg1,arg2 , ... ) {
statements
return expr
}
# 示例
cat fun.awk
    function max(v1,v2) {
        v1>v2?var=v1:var=v2
        return var
    }
      BEGIN{a=3;b=2;print max(a,b)}

awk –f fun.awk

# 脚本
# f1.awk
BEGIN{} pattern{} END{}

awk [-v var=value] f1.awk [file]

## f2.awk
\#!/bin/awk  -f
\#add 'x'  right
BEGIN{} pattern{} END{}

f2.awk [-v var=value] [var1=value1] [file]

cat f1.awk
    {if($3>=1000)print $1,$3}
awk -F: -f f1.awk /etc/passwd

cat f2.awk
    #!/bin/awk –f
    #this is a awk script
    {if($3>=1000)print $1,$3}
    #chmod +x f2.awk
f2.awk –F: /etc/passwd

cat test.awk
    #!/bin/awk –f
    {if($3 >=min && $3<=max)print $1,$3}
    #chmod +x test.awk
test.awk -F: min=100 max=200 /etc/passwd

# test.txt
1.2.3.4
4.5.6.7
2.3.4.5
1.2.3.4

awk '{arr[$1]++;}END{for(i in arr){print i , arr[i] }}'

awk -F "\t" '{print $3 "  " $NF}' jan20only.tsv

# 输出Recv-Q不为0的记录
netstat -ant | awk '$2 > 0 {print}'
# 外网连接数，根据ip分组
netstat -ant | awk '/^tcp/{print $4}' | awk -F: '!/^:/{print $1}' | sort | uniq -c
# 打印RSS物理内存占用
top -b -n 1 | awk 'NR>7{rss+=$6}END{print rss}'

#打印奇数行
awk 'a=!a' file
#输出行数
awk 'END{print NR}' file

# 下面两个命令是等价
awk -F ':'  '{print $3}' file
awk 'BEGIN{FS=":"}{print $3}' file
```
