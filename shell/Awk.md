
  <script>或--expression=<script> 以选项中指定的script来处理输入的文本文件。</li>
  <li>-f<script文件>或--file=<script文件> 以选项中指定的script文件来处理输入的文本文件。</li>
  <li>-n或--quiet或--silent 仅显示script处理后的结果。</li>
  <li>sed 可以直接修改文件的内容，不必使用管道命令或数据流重导向！ 不过，由於这个动作会直接修改到原始的文件，所以请你千万不要随便拿系统配置来测试！ 添加一行<code>sed -i &#39;$aHow are you today&#39; log.txt</code></li>
  </ul>
  <h3 id="-">高级编辑命令：也是对定界范围内的内容进行处理了，不过是处理起来更加高级。</h3>
  <ul>
  <li>P：打印模式空间开端至\n 内容，并追加到默认输出之前</li>
  <li>h：把模式空间中的内容覆盖至保持空间中；m &gt; b</li>
  <li>H：把模式空间中的内容追加至保持空间中; m&gt;&gt;b</li>
  <li>g：从保持空间取出数据覆盖至模式空间; b&gt;m</li>
  <li>G：从保持空间取出内容追加至模式空间; b&gt;&gt;m</li>
  <li>x：把模式空间中的内容与保持空间中的内容进行互换; m &lt;-&gt;b</li>
  <li>n：读取匹配到的行的下一行覆盖至模式空间; n&gt;m</li>
  <li>N：读取匹配到的行的下一行追加至模式空间; n&gt;&gt;m</li>
  <li>d：删除模式空间中的行; delete m</li>
  <li>D：如果模式空间包含换行符，则删除直到第一个换行符的模式空间中的文本，并不会读取新的 输入行，而使用合成的模式空间重新启动循环。如果模式空间不包含换行符，则会像发出d 命令那样启动正常的新循环</li>
  </ul>
  <p>看着有点有，这里写几个用法示例：</p>
  <pre><code>sed ‘2p’ /etc/passwd
  sed –n ‘2p’ /etc/passwd
  sed –n ‘1,4p’ /etc/passwd
  sed –n ‘/root/p’ /etc/passwd
  sed –n ‘2,/root/p’ /etc/passwd
  sed -n ‘/^$/=’ file
  sed –n –e ‘/^$/p’ –e ‘/^$/=’ file
  sed ‘/root/a\superman’ /etc/passwd
  sed ‘/root/i\superman’ /etc/passwd
  sed ‘/root/c\superman’ /etc/passwd
  sed ‘/^$/d’ file
  sed ‘1,10d’ file
  nl /etc/passwd | sed ‘2,5d’
  nl /etc/passwd | sed ‘2a tea’
  sed &#39;s/test/mytest/g&#39; example
  sed –n ‘s/root/&amp;superman/p’ /etc/passwd
  sed –n ‘s/root/superman&amp;/p’ /etc/passwd
  sed -e ‘s/dog/cat/’ -e ‘s/hi/lo/’ pets
  sed –i.bak ‘s/dog/cat/g’ pets
  sed -n &#39;n;p&#39; FILE
  sed &#39;1!G;h;$!d&#39; FILE
  sed &#39;N;D‘ FILE
  sed &#39;$!N;$!D&#39; FILE
  sed &#39;$!d&#39; FILE
  sed ‘G’ FILE
  sed ‘g’ FILE
  sed ‘/^$/d;G’ FILE
  sed &#39;n;d&#39; FILE
  sed -n &#39;1!G;h;$p&#39; FILE
  </code></pre><h3 id="nl">nl</h3>
  <p>nl -- line numbering filter</p>
  <h3 id="awk">awk</h3>
  <p>man awk
  awk是一种报表生成器，就是对文件进行格式化处理的，这里的格式化不是文件系统的格式化，而是对文件内容进行各种“排版”，进而格式化显示。</p>
  <pre><code>gawk - pattern scanning and processing language：（模式扫描和处理语言）
  awk [options] &#39;BEGIN{ action;… } pattern{ action;… } END{ action;… }&#39; file ...
  -f progfile，--file=progfile：从文件中来读取awk 的program
  -F fs，--field-separator=fs：指明输入时用到的字段分割符
  -v var=val，--assign=var=val：在执行program之前来定义变量
  </code></pre><ul>
  <li>执行[option]相关内容，也就是-f，-F，-v选项内容。</li>
  <li>执行BEGIN{action;… } 语句块中的语句。BEGIN 语句块在awk开始从输入流中读取行之前被执行，这是一个可选的语句块，比如变量初始化、打印输出表格的表头等语句通常可以写在BEGIN 语句块中。</li>
  <li>从文件或标准输入(stdin) 读取每一行，然后执行pattern{action;… }语句块，它逐行扫描文件，从第一行到最后一行重复这个过程，直到文件全部被读取完毕。pattern语句块中的通用命令是最重要的部分，也是可选的。如果没有提供pattern 语句块，则默认执行{ print } ，即打印每一个读取到的行，awk 读取的每一行都会执行该语句块。</li>
  <li>当读至输入流末尾时，也就是所有行都被读取完执行完后，再执行END{action;…} 语句块。END 语句块在awk从输入流中读取完所有的行之后即被执行，比如打印所有行的分析结果这类信息汇总都是在END 语句块中完成，它也是一个可选语句块。</li>
  </ul>
  <h4 id="-">内置变量：</h4>
  <pre><code>FS：输入字段分隔符，默认为空白字符，这个想当于-F选项。分隔符可以是多个，用[]括起来表示,如：-v FS=&quot;[,./-:;]&quot;
  OFS：输出字段分隔符，默认为空白字符，分隔符可以是多个，同上
  RS ：输入记录(所认为的行)分隔符，指定输入时的换行符，原换行符仍有效，分隔符可以是多个，同上
  ORS ：输出记录(所认为的行)分隔符，输出时用指定符号代替换行符，分隔符可以是多个，同上
  NF：字段数量
  NR：记录数(所认为的行)
  FNR ：各文件分别计数, 记录数（行号）
  FILENAME ：当前文件名
  ARGC：命令行参数的个数
  ARGV ：数组，保存的是命令行所给定的各参数
  </code></pre><h4 id="-">自定义变量(区分字符大小写)：</h4>
  <pre><code>在&#39;{...}&#39;前，需要用-v var=value：awk -v var=value &#39;{...}&#39;
  在program 中直接定义：awk &#39;{var=vlue}&#39;
  </code></pre><h4 id="-">实例</h4>
  <pre><code>awk -v FS=&#39;:&#39; &#39;{print $1,FS,$3}’ /etc/passwd
  awk –F: &#39;{print $1,$3,$7}’ /etc/passwd
  awk -v FS=‘:’ -v OFS=‘:’ &#39;{print $1,$3,$7}’ /etc/passwd
  awk -v RS=&#39; &#39; ‘{print }’ /etc/passwd
  awk -v RS=&quot;[[:space:]/=]&quot; &#39;{print }&#39; /etc/fstab |sort
  awk -v RS=&#39; &#39; -v ORS=&#39;###&#39;‘{print }’ /etc/passwd
  awk -F： ‘{print NF}’ /etc/fstab, 引用内置变量不用$
  awk -F: &#39;{print $(NF-1)}&#39; /etc/passwd
  awk &#39;{print NR}&#39; /etc/fstab ; awk &#39;END{print NR}&#39; /etc/fstab
  awk &#39;{print FNR}&#39; /etc/fstab /etc/inittab
  awk &#39;{print FNR}&#39; /etc/fstab /etc/inittab
  awk &#39;{print FILENAME}’ /etc/fstab
  awk &#39;{print ARGC}’ /etc/fstab /etc/inittab
  awk ‘BEGIN {print ARGC}’ /etc/fstab /etc/inittab
  awk ‘BEGIN {print ARGV[0]}’ /etc/fstab   /etc/inittab
  awk ‘BEGIN {print ARGV[1]}’ /etc/fstab  /etc/inittab
  awk -v test=&#39;hello gawk&#39; &#39;{print test}&#39; /etc/fstab
  awk -v test=&#39;hello gawk&#39; &#39;BEGIN{print test}&#39;
  awk &#39;BEGIN{test=&quot;hello,gawk&quot;;print test}&#39;
  awk –F:‘{sex=“male”;print $1,sex,age;age=18}’ /etc/passwd
  awk -F: &#39;{sex=&quot;male&quot;;age=18;print $1,sex,age}&#39; /etc/passwd
  echo &quot;{print script,\$1,\$2}&quot;  &gt; awkscript
  awk -F: -f awkscript script=“awk” /etc/passwd
  </code></pre><h4 id="print-printf">print和printf</h4>
  <p>print 格式：print item1,item2, ...</p>
  <p>printf格式：printf “FORMAT ”,item1,item2, ...</p>
  <ul>
  <li>逗号为分隔符时，显示的是空格；</li>
  <li>分隔符分隔的字段（域）标记称为域标识，用$0,$1,$2,...,$n表示，其中$0 为所有域，$1就是表示第一个字段（域），以此类推；</li>
  <li>输出的各item可以字符串，也可以是数值，当前记录的字段，变量或awk 的表达式等；</li>
  <li>如果省略了item ，相当于print $0</li>
  <li>对于printf来说，必须指定FORMAT，即必须指出后面每个itemsN的输出格式，且还不会自动换行，需要显式则指明换行控制符&quot;\n&quot;</li>
  </ul>
  <pre><code>%c：显示字符的ASCII码
  %d, %i：显示十进制整数
  %e, %E：显示科学计数法数值
  %f：显示为浮点数
  %g, %G：以科学计数法或浮点形式显示数值
  %s：显示字符串
  %u：无符号整数
  %%：显示%自身
  #[.#]：第一个数字控制显示的宽度；第二个#表示小数点后精度，%3.1f
  -：左对齐（默认右对齐）；%-15s，就是以左对齐方式显示15个字符长度
  +：显示数值的正负符号 %+d

  awk &#39;{print &quot;hello,awk&quot;}&#39;
  awk –F: &#39;{print}&#39; /etc/passwd
  awk –F: ‘{print “wang”}’ /etc/passwd
  awk –F: ‘{print $1}’ /etc/passwd
  awk –F: ‘{print $0}’ /etc/passwd
  awk –F: ‘{print $1”\t”$3}’ /etc/passwd
  tail –3 /etc/fstab |awk ‘{print $2,$4}’
  awk -F: ‘{printf &quot;%s&quot;,$1}’ /etc/passwd
  awk -F: ‘{printf &quot;%s\n&quot;,$1}’ /etc/passwd
  awk -F: &#39;{printf &quot;%-20s %10d\n&quot;,$1,$3}&#39; /etc/passwd
  awk -F: ‘{printf &quot;Username: %s\n&quot;,$1}’ /etc/passwd
  awk -F: ‘{printf “Username: %s,UID:%d\n&quot;,$1,$3}’ /etc/passwd
  awk -F: ‘{printf &quot;Username: %15s,UID:%d\n&quot;,$1,$3}’ /etc/passwd
  awk -F: ‘{printf &quot;Username: %-15s,UID:%d\n&quot;,$1,$3}’ /etc/passwd
  lsmod
  awk -v FS=&quot; &quot; &#39;BEGIN{printf &quot;%s %26s %10s\n&quot;,&quot;Module&quot;,&quot;Size&quot;,&quot;Used by&quot;}{printf &quot;%-20s %13d
  </code></pre><h4 id="-">操作符</h4>
  <pre><code>- 算术操作符：x+y, x-y, x*y, x/y, x^y, x%y
  - 赋值操作符：=, +=, -=, *=, /=, %=, ^=，++, --
  - 比较操作符：==, !=, &gt;, &gt;=, &lt;, &lt;=
  - 模式匹配符：~ ：左边是否和右边匹配包含；!~ ：是否不匹配
  - 逻辑操作符：与:&amp;&amp; ；或:|| ；非:!
  - 条件表达式（三目表达式）：selector ? if-true-expression : if-false-expression
  awk –F: &#39;$0 ~ /root/{print $1}‘ /etc/passwd
  awk &#39;$0~“^root&quot;&#39; /etc/passwd
  awk &#39;$0 !~ /root/‘ /etc/passwd
  awk –F: ‘$3==0’ /etc/passwd
  awk–F: &#39;$3&gt;=0 &amp;&amp; $3&lt;=1000 {print $1}&#39; /etc/passwd
  awk -F: &#39;$3==0 || $3&gt;=1000 {print $1}&#39; /etc/passwd
  awk -F: ‘!($3==0) {print $1}&#39; /etc/passwd
  awk -F: ‘!($3&gt;=500) {print $3}’ /etc/passwd
  awk -F: &#39;{$3&gt;=1000?usertype=&quot;Common User&quot;:usertype=&quot;Sysadmin or SySUSEr&quot;;printf &quot;%15s:%-s\n&quot;
  </code></pre><h4 id="pattern">pattern</h4>
  <p>根据pattern条件，过滤匹配的行，再做处理。</p>
  <pre><code>- 未指定：表示空模式，匹配每一行
  - /regular expression/：仅处理能够模式匹配到的行，支持正则表达式，需要用/ /括起来
  - 关系表达式：结果为“真”才会被处理。真：结果为非0值，非空字符串。假：结果为空字符串或0值
  - /pat1/,/pat2/：startline,endline ，行范围,支持正则表达式，不支持直接给出数字格式
  - BEGIN{}和END{}：BEGIN{} 仅在开始处理文件中的文本之前执行一次。END{}仅在文本处理完成之后执行 一次


  awk &#39;/^UUID/{print $1}&#39; /etc/fstab
  awk &#39;!/^UUID/{print $1}&#39; /etc/fstab
  awk -F: ‘/^root\&gt;/,/^nobody\&gt;/{print $1}&#39; /etc/passwd
  awk -F: ‘(NR&gt;=10&amp;&amp;NR&lt;=20){print NR,$1}&#39;  /etc/passw
  awk -F: &#39;i=1;j=1{print i,j}&#39; /etc/passwd
  awk ‘!0’ /etc/passwd ; awk ‘!1’ /etc/passwd
  awk –F: &#39;$3&gt;=1000{print $1,$3}&#39; /etc/passwd
  awk -F: &#39;$3&lt;1000{print $1,$3}&#39; /etc/passwd
  awk -F: &#39;$NF==&quot;/bin/bash&quot;{print $1,$NF}&#39; /etc/passwd
  awk -F: &#39;$NF ~ /bash$/{print $1,$NF}&#39; /etc/passwd
  awk -F : &#39;BEGIN {print &quot;USER USERID&quot;} {print $1&quot;:&quot;$3}END{print &quot;end file&quot;}&#39; /etc/passwd
  awk -F: &#39;BEGIN{print &quot;    USER     USERID&quot;}{printf &quot;|%8s| %10d|\n&quot;,$1,$3}END{print &quot;END FILE&quot;}&#39; /etc/passwd
  awk -F : &#39;{print &quot;USER USERID“;print $1&quot;:&quot;$3} END{print&quot;end file&quot;}&#39; /etc/passwd
  awk -F: &#39;BEGIN{print &quot; USER UID \n---------------&quot;}{print $1,$3}&#39; /etc/passwd
  awk -F: &#39;BEGIN{print &quot;    USER     USERID\n----------------------&quot;}{printf &quot;|%8s| %10d|\n&quot;,$1,$3}END{print &quot;----------------------\nEND FILE&quot;}&#39; /etc/passwd
  awk -F: &#39;BEGIN{print &quot; USER UID \n---------------&quot;}{print $1,$3}&#39;END{print &quot;==============&quot;} /etc/passwd
  seq 10 |awk ‘i=0’
  seq 10 |awk ‘i=1’
  seq 10 | awk &#39;i=!i‘
  seq 10 | awk &#39;{i=!i;print i}‘
  seq 10 | awk ‘!(i=!i)’
  seq 10 |awk -v i=1 &#39;i=!i&#39;
  </code></pre><h4 id="action">action</h4>
  <ul>
  <li>表达式语句，包括算术表达式和比较表达式，就是用进行比较和计算的。</li>
  <li>控制语句，用作进行控制，典型的就是if else，while等语句，和bash脚本里面用法差不多。</li>
  <li>输入语句，用来做为输入，变量赋值就算是。</li>
  <li>输出语句，用来输出显示的，典型的是print和printf</li>
  <li>组合语句，这个很多理解，就是多种语句的组合</li>
  </ul>
  <h5 id="if-else">if-else</h5>
  <ul>
  <li>{if(condition){statement;…}}：条件满足就执行statement</li>
  <li>{if(condition){statement1;…}{else statement2}}：条件满足执行statement1，不满足执行statement2</li>
  <li>{if(condition1){statement1}else if(condition2){statement2}else{statement3}}：条件1满足执行statement2，不满足条件1但满足条件2执行statement2，所用条件都不满足就执行statement3<pre><code>awk -F: &#39;{if($3&gt;=1000)print $1,$3}&#39; /etc/passwd
  awk -F: &#39;{if($NF==&quot;/bin/bash&quot;) print $1}&#39; /etc/passwd
  awk &#39;{if(NF&gt;5) print $0}&#39; /etc/fstab
  awk -F: &#39;{if($3&gt;=1000) {printf &quot;Common user: %s\n&quot;,$1}else{printf &quot;root or Sysuser: %s\n&quot;,$1}}&#39; /etc/passwd
  awk -F: &#39;{if($3&gt;=1000) printf &quot;Common user: %s\n&quot;,$1;else printf &quot;root or Sysuser: %s\n&quot;,$1}&#39; /etc/passwd
  df -h|awk -F% &#39;/^\/dev/{print $1}&#39;|awk &#39;$NF&gt;=80{print $1,$5}‘
  awk &#39;BEGIN{ test=100;if(test&gt;90){print &quot;very good&quot;}else if(test&gt;60){ print &quot;good&quot;}else{print &quot;bad&quot;}
  </code></pre></li>
  </ul>
  <h5 id="while-do-while">while和do-while</h5>
  <ul>
  <li>while(condition){statement;…}：条件为“真”时，进入循环；条件为“假”时， 退出循环</li>
  <li>do {statement;…}while(condition)：无论真假，至少执行一次循环体。当条件为“真”时，退出循环；条件为“假”时，继续循环<pre><code>awk &#39;/^[[:space:]]*linux16/{i=1;while(i&lt;=NF){print $i,length($i); i++}}&#39; /etc/grub2.cfg
  awk &#39;/^[[:space:]]*linux16/{i=1;while(i&lt;=NF) {if(length($i)&gt;=10){print $i,length($i)}; i++}}&#39; /etc/grub2.cfg
  awk &#39;BEGIN{ total=0;i=0;do{total+=i;i++}while(i&lt;=100);print total}‘
  </code></pre></li>
  </ul>
  <h5 id="for">for</h5>
  <ul>
  <li>for(expr1;expr2;expr3) {statement;…}：expr1为变量赋值，如var=value，初始进行变量赋值；expr2为条件判断语句，j&lt;=10，满足条件就继续执行statement；expr3为迭代语句，如j++，每次执行完statement后就迭代增加</li>
  <li>for(var in array) {for-body}：变量var遍历数组，每个数组中的var都会执行一次for-body<pre><code>awk &#39;/^[[:space:]]*linux16/{for(i=1;i&lt;=NF;i++) {print $i,length($i)}}&#39; /etc/grub2.cfg
  awk &#39;/^[^#]/{type[$3]++}END{for(i in type)print i,type[i]}&#39; /etc/fstab
  awk -v RS=&quot;[[:space:]/=,-]&quot; &#39;/[[:alpha:]]/{ha[$0]++}END{for(i in ha)print i,ha[i]}&#39; /etc/fstab
  </code></pre></li>
  </ul>
  <h5 id="switch-bash-case-">switch 相当于bash中的case语句</h5>
  <p>switch(expr) {case VAL1 or /REGEXP/:statement1; case VAL2 or /REGEXP2/: statement2;...; default: statementn}：若expr满足 VAL1 or /REGEXP/就执行statement1，若expr满足VAL2 or /REGEXP2/就执行statement2，以此类推，执行statementN，都不满足就执行statement</p>
  <h5 id="break-continue-next">break、continue和next</h5>
  <ul>
  <li>break[n]：当第n次循环到来后，结束整个循环，n=0就是指本次循环</li>
  <li>continue[n]：满足条件后，直接进行第n次循环，本次循环不在进行，n=0也就是提前结束本次循环而直接进入下一轮</li>
  <li>next：提前结束对本行的处理动作而直接进入下一行处理</li>
  </ul>
  <pre><code>awk ‘BEGIN{sum=0;for(i=1;i&lt;=100;i++){if(i%2==0)continue;sum+=i}print sum}‘
  awk ‘BEGIN{sum=0;for(i=1;i&lt;=100;i++){if(i==66)break;sum+=i}print sum}‘
  awk -F: &#39;{if($3%2!=0) next; print $1,$3}&#39; /etc/passwd
  </code></pre><h4 id="-">数组</h4>
  <p>关联数组，格式为：array[index-expression]：arry为数组名，index-expression为下标。index-expression可使用任意字符串，字符串要使用双引号括起来；如果某数组元素事先不存在，在引用时，awk 会自动创建此元素，并将其值初始化为“空串”。
  若要判断数组中是否存在某元素，要使用“index in array”格式进行遍历。若要遍历数组中的每个元素，要使用for循环：for(var in array) {for-body}，使用for循环会使var 会遍历array的每个索引。此时要显示数组元素的值，则要使用array[var]。</p>
  <pre><code>awk &#39;BEGIN{weekdays[&quot;mon&quot;]=&quot;Monday&quot;;weekdays[&quot;tue&quot;]=&quot;Tuesday&quot;;print weekdays[&quot;mon&quot;]}‘
  awk &#39;!arr[$0]++&#39; dupfile
  awk &#39;{!arr[$0]++;print $0, arr[$0]}&#39; dupfile
  awk &#39;BEGIN{weekdays[&quot;mon&quot;]=&quot;Monday&quot;;weekdays[&quot;tue&quot;]=&quot;Tuesday&quot;;for(i in weekdays) {print weekdays[i]}}‘
  netstat -tan | awk &#39;/^tcp/{state[$NF]++}END{for(i in state) { print i,state[i]}}&#39;
  awk &#39;{ip[$1]++}END{for(i in ip) {print i,ip[i]}}&#39;/var/log/httpd/access_log
  </code></pre><h4 id="-">函数</h4>
  <pre><code>rand()：返回0 和1 之间一个随机数
  srand()：生成随机数种子
  int()：取整数
  length([s])：返回指定字符串的长度
  sub(r,s,[t])：对t字符串进行搜索，r表示的模式匹配的内容，并将第一个匹配的内容替换为s
  gsub(r,s,[t])：对t字符串进行搜索，r表示的模式匹配的内容，并全部替换为s所表示的内容
  split(s,array,[r])：以r为分隔符，切割字符串s，并将切割后的结果保存至array 所表示的数组中，第一个索引值为1, 第二个索引值为2,…也就是说awk的数组下标是从1开始编号的。
  substr(s,i,[n])：从s所表示的字符串中取子串，取法：从i表示的位置开始，取n个字符。
  systime()：取当前系统时间，结果形式为时间戳。
  system()：调用shell中的命令。空格是awk中的字符串连接符，如果system 中需要使用awk中的变量可以使用空格分隔，或者说除了awk的变量外其他一律用&quot;&quot; 引用 起来。

  awk &#39;BEGIN{srand(); for (i=1;i&lt;=10;i++)print int(rand()*100) }&#39;
  echo &quot;2008:08:08 08:08:08&quot; | awk &#39;sub(/:/,“-&quot;,$1)&#39;
  echo &quot;2008:08:08 08:08:08&quot; | awk ‘gsub(/:/,“-&quot;,$0)&#39;
  netstat -tan | awk &#39;/^tcp\&gt;/{split($5,ip,&quot;:&quot;);count[ip[1]]++}END{for (i in count) {print i,count[i]}}&#39;
  awk BEGIN&#39;{system(&quot;hostname&quot;) }&#39;
  awk &#39;BEGIN{score=100; system(&quot;echo your score is &quot; score) }&#39;

  自定义函数，格式为

  function fname ( arg1,arg2 , ... ) {
  statements
  return expr
  }

  cat fun.awk
      function max(v1,v2) {
          v1&gt;v2?var=v1:var=v2
          return var
      }
        BEGIN{a=3;b=2;print max(a,b)}
  awk –f fun.awk
  </code></pre><h4 id="-">脚本</h4>
  <p>将awk程序写成脚本形式，来直接调用或直接执行。</p>
  <p>格式1：<code>BEGIN{} pattern{} END{}</code>
  格式2：</p>
  <pre><code>\#!/bin/awk  -f
  \#add &#39;x&#39;  right 
  BEGIN{} pattern{} END{}
  </code></pre><p>格式1假设为f1.awk文件，格式2假设为f2.awk文件，那么用法是：</p>
  <pre><code>awk [-v var=value] f1.awk [file]
  f2.awk [-v var=value] [var1=value1] [file]
  </code></pre><p>对于awk [-v var=value] f1.awk [file]来说，很好理解，就是把处理阶段放到一个文件而已，真正展开后，也就是普通的awk语句。
  对于f2.awk [-v var=value] [var1=value1] [file]来说， [-v var=value]是在BEGIN之前设置的变量值，[var1=value1]是在BEGIN过程之后进行的，也就是说直到首行输入完成后，这个变量才可用，这就想awk脚本黄总传递参数了。
  示例：</p>
  <pre><code>cat f1.awk
      {if($3&gt;=1000)print $1,$3}
  awk -F: -f f1.awk /etc/passwd

  cat f2.awk
      #!/bin/awk –f
      #this is a awk script
      {if($3&gt;=1000)print $1,$3}
      #chmod +x f2.awk
  f2.awk –F: /etc/passwd

  cat test.awk
      #!/bin/awk –f
      {if($3 &gt;=min &amp;&amp; $3&lt;=max)print $1,$3}
      #chmod +x test.awk
  test.awk -F: min=100 max=200 /etc/passwd
  </code></pre><h3 id="rsync">rsync</h3>
  <p>类unix系统下的数据镜像备份工具。使用快速增量备份工具Remote Sync可以远程同步，支持本地复制，或者与其他SSH、rsync主机同步。</p>
  <h2 id="-">扩展</h2>
  <ul>
  <li><a href="https://github.com/aleksandar-todorovic/awesome-linux">aleksandar-todorovic/awesome-linux</a>A list of awesome projects and resources that make Linux even more awesome</li>
  </ul>
  <h2 id="-">参考</h2>
  <ul>
  <li><a href="http://www.linuxidc.com/Linux/2017-10/147270.htm">awk基本用法和工作原理详解</a></li>
  </ul>
  </script>

```
# test.txt

1.2.3.4
4.5.6.7
2.3.4.5
1.2.3.4

awk '{arr[$1]++;}END{for(i in arr){print i , arr[i] }}'
```
