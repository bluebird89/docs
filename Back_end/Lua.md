# [Lua](http://www.lua.org)

* 1993 年在巴西里约热内卢天主教大学(Pontifical Catholic University of Rio de Janeiro in Brazil)诞生了一门编程语言，发明者是该校的三位研究人员，他们给这门语言取了个浪漫的名字——Lua，在葡萄牙语里代表美丽的月亮
* 官方实现完全采用 ANSI C 编写，能以 C 程序库的形式嵌入到宿主程序中.LuaJIT 2 和标准 Lua 5.1 解释器采用的是著名的 MIT 许可协议
* 特性：
	- 变量名没有类型，值才有类型，变量名在运行时可与任何类型的值绑定;
	- 语言只提供唯一一种数据结构，称为表(table)，它混合了数组、哈希，可以用任何类型的值作为 key 和 value。提供了一致且富有表达力的表构造语法，使得 Lua 很适合描述复杂的数据;
	- 函数是一等类型，支持匿名函数和正则尾递归(proper tail recursion);
    支持词法定界(lexical scoping)和闭包(closure);
	- 提供 thread 类型和结构化的协程(coroutine)机制，在此基础上可方便实现协作式多任务;
	- 运行期能编译字符串形式的程序文本并载入虚拟机执行;
	- 通过元表(metatable)和元方法(metamethod)提供动态元机制(dynamic meta-mechanism)，从而允许程序运行时根据需要改变或扩充语法设施的内定语义;
	- 能方便地利用表和动态元机制实现基于原型(prototype-based)的面向对象模型;
	- 从 5.1 版开始提供了完善的模块机制，从而更好地支持开发大型的应用程序;
* 非常高效，运行得比许多其它脚本(如 Perl、Python、Ruby)都快
* [LuaJIT](http://luajit.org):利用即时编译（Just-in Time）技术把 Lua 代码编译成本地机器码后交由 CPU 直接执行
	- 一句一句编译源代码，但是会将翻译过的代码缓存起来以降低性能损耗
	- 采用 C 和汇编语言编写的 Lua 解释器与即时编译器。LuaJIT 被设计成全兼容标准的 Lua 5.1 语言，同时可选地支持 Lua 5.2 和 Lua 5.3 中的一些不破坏向后兼容性的有用特性

## install

* Lua:静态编译的程序在执行前全部被翻译为机器码
* 动态直译执行的则是一句一句边运行边翻译
* [LuaRocks](https://github.com/luarocks/luarocks):LuaRocks is the package manager for the Lua programming language. http://www.luarocks.org

```sh
sudo apt install build-essential libreadline-dev
apt-get install lua5.2

curl -R -O http://www.lua.org/ftp/lua-5.3.5.tar.gz
tar -zxf lua-5.3.5.tar.gz
cd lua-5.3.5
make linux test
sudo make install

wget https://luajit.org/download/LuaJIT-2.0.5.tar.gz
make
sudo make install

brew install luarocks
wget https://luarocks.org/releases/luarocks-3.3.1.tar.gz
tar zxpf luarocks-3.3.1.tar.gz
cd luarocks-3.3.1
./configure.
make
sudo make install
```

## 基础数据类型

* nil	表示无效值，在条件表达式中表示 false.一个变量在第一次赋值前的默认值是 nil，将 nil 赋予给一个全局变量就等同于删除它
	- 如果对一个 nil 进行索引的话，会导致异常
* boolean	布尔值，包含 true/false,nil 和 false 为“假”，其它所有值均为“真”。比如 0 和空字符串就是“真”
* number	表示双精度类型的实浮点数
	- LuaJIT 支持所谓的“dual-number”（双数）模式，即 LuaJIT 会根据上下文用整型来存储整数，而用双精度浮点数来存放浮点数
	- LuaJIT 还支持“长长整型”的大整数（在 x86_64 体系结构上则是 64 位整数）
* string 字符串:通过双引号或单引号括住
	- 可以用一种长括号（即[[ ]]）括起来的方式定义:两个正的方括号（即[[）间插入 n 个等号定义为第 n 级正长括号,0 级正的长括号写作 [[ ，一级正的长括号写作 [=[
	- 一个长字符串可以由任何一级的正的长括号开始，而由第一个碰到的同级反的长括号结束。整个词法分析过程将不受分行限制，不处理任何转义符，并且忽略掉任何不同级别的长括号。这种方式描述的字符串可以包含任何东西，当然本级别的反长括号除外
	- 字符串是不可改变的值,修改要求来创建一个新的字符串
	- 不能通过下标来访问字符串的某个字符
	- 在 Lua 实现中，Lua 字符串一般都会经历一个“内化”（intern）的过程，即两个完全一样的 Lua 字符串在 Lua 虚拟机中只会存储一份。每一个 Lua 字符串在创建时都会插入到 Lua 虚拟机内部的一个全局的哈希表中
		+ 创建相同的 Lua 字符串并不会引入新的动态内存分配操作，所以相对便宜（但仍有全局哈希表查询的开销），
		+ 内容相同的 Lua 字符串不会占用多份存储空间
		+ 已经创建好的 Lua 字符串之间进行相等性比较时是 O(1) 时间度的开销，而不是通常见到的 O(n)
* table	实现了一种抽象的“关联数组”。“关联数组”是一种具有特殊索引方式的数组，索引通常是字符串（string）或者 number 类型，但也可以是除 nil 以外的任意类型的值
	- 内部实现上，table 通常实现为一个哈希表、一个数组、或者两者的混合.具体的实现动态依赖于具体的 table 的键分布特点
	- table.getn(t) 等价于 #t 但计算的是数组元素，不包括 hash 键值。而且数组是以第一个 nil 元素来判断数组结束。# 只计算 array 的元素个数，它实际上调用了对象的 metatable 的 __len 函数。对于有 __len 方法的函数返回函数返回值，不然就返回数组成员数目
	- 内部实际采用哈希表和数组分别保存键值对、普通值，所以不推荐混合使用这两种赋值方式
	- 允许 nil 值的存在，但是数组默认结束标志却是 nil
	- 一定不要使用 # 操作符或 table.getn 来计算包含 nil 的数组长度，这是一个未定义的操作，不一定报错，但不能保证结果如你所想
	- 要删除一个数组中的元素，请使用 remove 函数，而不是用 nil 赋值
	- 值可能是 {}，这时它不等于 nil
* function	表示 C 或 Lua 编写的函
	- 可以存储在变量中，可以通过参数传递给其他函数，还可以作为其他函数的返回值
	- 有名函数定义本质上是匿名函数对变量赋值

* userdata	表示任意存储在变量中的 C 数据结
* thread	表示执行的独立线程，用于执行协同程序

## 变量

* 在一个 block 中的变量，如果之前没有定义过，那么认为它是一个全局变量，而不是这个 block 的局部变量
* 局部变量:生命周期是有限的，作用域仅限于声明它的块（block）。一个块是一个控制结构的执行体、或者是一个函数的执行体再或者是一个程序块（chunk）
	- 局部变量可以避免因为命名问题污染了全局环境
	- local 变量的访问比全局变量更快
	- 由于局部变量出了作用域之后生命周期结束，这样可以被垃圾回收器及时释放
* 工具
	- [lj-releng](https://github.com/openresty/openresty-devel-utils/blob/master/lj-releng)扫描 Lua 代码，定位使用 Lua 全局变量的地方:


##　表达式

* 使用“==”做等于判断时，要注意对于 table, userdate 和函数，是作引用比较的。也就是说，只有当两个变量引用同一个对象时，才认为它们相等
*  Lua 字符串总是会被“内化”，即相同内容的字符串只会被保存一份，因此 Lua 字符串之间的相等性比较可以简化为其内部存储地址的比较。这意味着 Lua 字符串的相等性比较总是为 O(1)
* 字符串连接运算符几乎总会创建一个新的（更大的）字符串。这意味着如果有很多这样的连接操作（比如在循环中使用 .. 来拼接最终结果），则性能损耗会非常大。在这种情况下，推荐使用 table 和 table.concat() 来进行很多字符串的拼接
* 优先级
	- ^
	- not   # -
	- *   /   %
	- +   -
	- ..
	- < > <=  >=  ==  ~=
	- and
	- or

## 控制

* 将 else 与 if 写成 "else if" 则相当于在 else 里嵌套另一个 if 语句
* 泛型 for 循环与数字型 for 循环有两个相同点
	- （1）循环变量是循环体的局部变量
	- （2）决不应该对循环变量作任何赋值
	- 在 LuaJIT 2.1 中，ipairs() 内建函数是可以被 JIT 编译的，而 pairs() 则只能被解释执行。因此在性能敏感的场景，应当合理安排数据结构，避免对哈希表进行遍历
* goto 一项用途，就是简化错误处理的流程。直接 goto 到函数末尾统一的错误处理过程，是更为清晰的写

## 函数

* 优点
	- 降低程序的复杂性
	- 增加程序的可读性
	- 避免重复代码
	- 隐含局部变量
* 全局变量一般会污染全局名字空间，同时也有性能损耗（即查询全局环境表的开销），应当尽量使用“局部函数”，其记法是类似的，只是开头加上 local 修饰符
* 函数定义本质上就是变量赋值，而变量的定义总是应放置在变量使用之前，所以函数的定义也需要放置在函数调用之前
* 参数大部分是按值传递的。值传递就是调用函数时，实参把它的值通过赋值运算传递给形参，然后形参的改变和实参就没有关系了.实参是通过它在参数表中的位置与形参匹配起来的
	- 若形参个数和实参个数不同时，Lua 会自动调整实参个数。调整规则
	- 若实参个数大于形参个数，从左向右，多余的实参被忽略
	- 若实参个数小于形参个数，从左向右，没有被实参初始化的形参会被初始化为 nil
* 变长参数。若形参为 ... , 表示该函数可以接收不同长度的参数。访问参数的时候也要使用 ...
	- LuaJIT 2 尚不能 JIT 编译这种变长参数的用法，只能解释执行。所以对性能敏感的代码，应当避免使用此种形式
* 参数是 table 类型时，传递进来的是 实际参数的引用，此时在函数内部对该 table 所做的修改，会直接对调用者所传递的实际参数生效，而无需自己返回结果和让调用者进行赋值
* 返回值：允许函数返回多个值
	- 返回值的个数和接收返回值的变量的个数不一致时，会自动调整参数个数。
	-  调整规则： 若返回值个数大于接收变量的个数，多余的返回值会被忽略掉；
	-  若返回值个数小于参数个数，从左向右，没有被返回值初始化的变量会被初始化为 nil
*  一个函数有一个以上返回值，且函数调用不是一个列表表达式的最后一个元素，那么函数调用只会产生一个返回值, 也就是第一个返回值
	-  确保只取函数返回值的第一个值，可以使用括号运算符
*  全动态函数调用:调用回调函数，并把一个数组参数作为回调函数的参数

## 模块

* 从 Lua 5.1 语言添加了对模块和包的支持
* 一个代码模块就是一个程序库，可以通过 require 来加载
	- 一个 Lua 模块的数据结构是用一个 Lua 值（通常是一个 Lua 表或者 Lua 函数）。
	- 一个 Lua 模块代码就是一个会返回这个 Lua 值的代码块
	- 可以使用内建函数 require() 来加载和缓存模块
	- 模块加载后的结果通过是一个 Lua table，这个表就像是一个命名空间，其内容就是模块中导出的所有东西，比如函数和变量。require 函数会返回 Lua 模块加载后的结果，即用于表示该 Lua 模块的 Lua 值。
* 需要导出给外部使用的公共模块，处于安全考虑，是要避免全局变量的出现

## String

* 内部用来标识各个组成字节的下标是从 1 开始
* 使用 string.byte 来进行字符串相关的扫描和分析

## table

* table.getn 获取长度:如果数组有一个“空洞”（就是说，nil 值被夹在非空值之间），那么 #t 可能是指向任何一个是 nil 值的前一个位置的下标（就是说，任何一个 nil 值都有可能被当成数组的结束）。这也就说明对于有“空洞”的情况，table 的长度存在一定的 不可确定性。
* 元素要删除，直接 remove，不要用 nil 去代替
* table.maxn (table) 返回（数组型）表 table 的最大索引编号；如果此表没有正的索引编号，返回 0

## 文件操作

* 隐式文件描述:设置一个默认的输入或输出文件，然后在这个文件上进行所有的输入或输出操作。所有的操作函数由 io 表提供
* 显式文件描述 使用 file:XXX() 函数方式进行操作, 其中 file 为 io.open() 返回的文件句柄

## 元表 (metatable)

* 类似于 C++ 语言中的操作符重载
* setmetatable(table, metatable)：此方法用于为一个表设置元表。
* getmetatable(table)：此方法用于获取表的元表对象
* "__add" 	+ 操作
* "__sub" 	- 操作 其行为类似于 "add" 操作
* "__mul" 	* 操作 其行为类似于 "add" 操作
* "__div" 	/ 操作 其行为类似于 "add" 操作
* "__mod" 	% 操作 其行为类似于 "add" 操作
* "__pow" 	^ （幂）操作 其行为类似于 "add" 操作
* "__unm" 	一元 - 操作
* "__concat" 	.. （字符串连接）操作
* "__len" 	# 操作
* "__eq" 	== 操作 函数 getcomphandler 定义了 Lua 怎样选择一个处理器来作比较操作,仅在两个对象类型相同且有对应操作相同的元方法时才起效
* "__lt" 	< 操作
* "__le" 	<= 操作
* "__index" 	取下标操作用于访问 table[key]
* "__newindex" 	赋值给指定下标 table[key] = value
* "__tostring" 	转换成字符串
* "__call" 	当 Lua 调用一个值时调用
* "__mode" 	用于弱表(week table)
* "__metatable" 	用于保护metatable不被访问

## OOP

* 将函数和相关的数据放置于同一个表中就形成了一个对象
* 继承可以用元表实现，它提供了在父类中查找存在的方法和变量的机制。在 Lua 中是不推荐使用继承方式完成构造的，这样做引入的问题可能比解决的问题要多
* 成员的私有性，使用类似于函数闭包的形式来实现

## 正则表达式

* Lua 语言的规范和 ngx.re.* 的规范
	- Lua 中正则表达式的性能并不如 ngx.re.* 中的正则表达式优秀,有 5% - 15% 的性能损失，而且 Lua 将表达式编译成 Pattern 之后，并不会将 Pattern 缓存，而是每此使用都重新编译一遍，潜在地降低了性能
	- Lua 中的正则表达式并不符合 POSIX 规范，而 ngx.re.* 中实现的是标准的 POSIX 规范，后者明显更具备通用性
* Lua 正则
	- 使用 '%' 来进行转义，而其他语言的正则表达式使用 '\' 符号来进行转义
	- 并不使用 '?' 来表示非贪婪匹配，而是定义了不同的字符来表示是否是贪婪匹配
		+ + 	匹配前一字符 1 次或多次 	非贪婪
		+ * 	匹配前一字符 0 次或多次 	贪婪
		+ - 	匹配前一字符 0 次或多次 	非贪婪
		+ ? 	匹配前一字符 0 次或1次 	仅用于此，不用于标识是否贪婪
		+ . 	任意字符
		+ %a 	字母
		+ %c 	控制字符
		+ %d 	数字
		+ %l 	小写字母
		+ %p 	标点字符
		+ %s 	空白符
		+ %u 	大写字母
		+ %w 	字母和数字
		+ %x 	十六进制数字
		+ %z 	代表 0 的字符
	- string.find 的基本应用是在目标串内搜索匹配指定的模式的串。函数如果找到匹配的串，就返回它的开始索引和结束索引，否则返回 nil
		+ 第三个参数是可选的：标示目标串中搜索的起始位置
	- string.gmatch 也可以使用返回迭代器的方式
* ngx.re.*
	- o 选项:被编译的 Pattern 将会在工作进程中缓存，并且被当前工作进程的每次请求所共享。Pattern 缓存的上限值通过 lua_regex_cache_max_entries 来修改，它的默认值为1024
	- j 选项:如果使用的 PCRE 库支持 JIT，OpenResty 会在编译 Pattern 时启用 JIT。启用 JIT 后正则匹配会有明显的性能提升.验证当前 PCRE 库是否支持 JIT
		+ 编译 OpenResty 时在 ./configure 中指定 --with-debug 选项
		+ 在 error_log 指令中指定日志级别为 debug
		+ 运行正则匹配代码，查看日志中是否有 pcre JIT compiling result: 1


## 框架

* [torch/torch7](https://github.com/torch/torch7):Torch is a scientific computing framework with wide support for machine learning algorithms that puts GPUs first. It is easy to use and efficient, thanks to an easy and fast scripting language, LuaJIT, and an underlying C/CUDA implementation. http://torch.ch/

## 工具

* [LuaRocks ](https://luarocks.org/):the package manager for Lua modules
* 编辑器
    - hammerspoon
    - idea　插件　emmylua
* [Azure/golua](https://github.com/Azure/golua):A Lua 5.3 engine implemented in Go
* [tboox/ltui](https://github.com/tboox/ltui):🍯A cross-platform terminal ui library based on Lua https://tboox.org
* [tboox/xmake](https://github.com/tboox/xmake):🔥 A cross-platform build utility based on Lua https://xmake.io
* [yuin/gopher-lua](https://github.com/yuin/gopher-lua):GopherLua: VM and compiler for Lua in Go

## 参考

* [cloudwu/lua53doc](https://github.com/cloudwu/lua53doc):The Chinese Translation of Lua 5.3 document
* [torch/nn](https://github.com/torch/nn)
* [openresty/lua-nginx-module](https://github.com/openresty/lua-nginx-module):Embed the Power of Lua into NGINX HTTP servers https://openresty.org/
