# C++

## 学习

* 学好C++，一定要学习C++11，搞懂内存管理
* 熟悉智能指针和RAII等基本内存管理原则
* 搞懂虚函数和继承，函数重载与重写
* 熟悉C++调试等
* 不要死抠语法细节
* 了解Big picture，从做项目中去掌握和理解C++的这些特性
* 看完基本的C++语法，类，继承之后就可以开始写代码了。遇到模板或者STL容器不懂的时候，再去针对性地阅读相关的章节和Google查找资料来学习

## 环境搭建

```sh
sudo apt install gcc g++ gdb

## sublime  C++.sublime-build
{
    "shell_cmd": "g++ \"${file}\" -o \"${file_path}/${file_base_name}\"",
    "file_regex": "^(..[^:]*):([0-9]+):?([0-9]+)?:? (.*)$",
    "working_dir": "${file_path}",
    "selector": "source.c, source.c++",

    "variants":
    [
        {
            "name": "Run",
            "shell_cmd": "g++ \"${file}\" -o \"${file_path}/${file_base_name}\" && \"${file_path}/${file_base_name}\""
        }
    ]
}

cc -v

# IDE
sudo apt intall kdevelop
```

## 语法基础

* 指针和引用的概念
* 指针与内存关系
* 程序编译过程
* static、const、#define的用法和区别
* C和C++区别

## 语法进阶

* 智能指针
* 左值、右值引用和move语义
* 类型转换方式
* 常用的设计模式
* 线程安全的单例模式
* 内存溢出和内存泄漏
* C++11新特性
* 静态链接库和动态链接库

## 标志符

* 区分大小写

## I/O

* 文件读写
  - ifstream 处理输入，读取文件
  - ofstream 处理输出，写入文件
  - fstream 既可以处理输入也可以处理输出
    + ios::in打开文件以便输入
    + ios::out 打开文件以便输出
    + ios::trunc 文件存在，删除文件，否则重建
    + ios:binary 以二进制打开文件
    + ios::app 追加形式文件，输入写到文件末尾

## 文件包含

* 末尾没有引号
* 双引号时从当前目录寻找
* 尖括号从指定位置寻找

## 宏

* 用标志符定义常量

## 变量

* 变量引用：定义别名
* 作用域
  - 局部变量：函数内声明
    + 作用域 函数内部
    + 如果定义了与全局变量一致，比全局变量 优先级高
  - 全局变量：函数外声明变量
    + 初始化：未初始化值为0 '\0'
    + 作用域：可以被任何函数使用或修改，
      * 只限于定义处到文件结束
      * extern
        - 函数外部：扩展全局变量到声明位置
        - 函数内部：作用域仅扩展到函数内部
        - 不允许在该声明中初始化
        - 声明对其他文件变量的引用
    + 与局部变量同名时，局部变量优先级高
  - {} 标志一个作用域，可以定义同名参数，不相互影响
* 生存期
  - auto 默认 与作用域一致
    + 再次调用，重新分配存储单元以及初始化
  - static 静态：程序运行期间分配固定的存储空间
    + 局部变量中声明
    + 编译时分配一块静态存储区的内存，运行时始终存在，调用结束后,不会回收
* `extern`
  - 提前声明全局变量，避免 使用未声明变量报错
  - 多文件共享

## 常量

* 字面值：运行中值不变
  - 字符常量：以单引号
  - 字符串常量：双引号，按顺序逐个存储字符，最后自动加 \n
* 符号常量 const

## 运算符

* 结合优先级有左结合跟右结合

## typedef

* 为已有数据类型定义新名称

## 结构体 struct

* 一种“构造”而成的数据类型，在使用之前必须先定义它
* 由一系列具有相同类型或不同类型的数据构成的数据集合
* 每一个成员可以是一个基本数据类型或者构造类型
* 作用
  - 封装一些属性来组成新的类型
* -> 通过指针访问属性
* 大小与内存对齐
  - 各成员变量在存放的时候根据在结构中出现的顺序依次申请空间
  - 同时按照前面的数据结构对齐方式调整位置，空缺的字节会自动填充
  - 为了确保结构的大小为结构的字节边界数（即该结构中占用最大空间的类型所占用的字节数）的倍数，所以在为最后一个成员变量申请空间后，还会根据需要自动填充空缺的字节

## 数组

* 定义数组大小用符号常量或者字面值，不可以用变量
* 字符串是用字符数组来存储.系统自动分配 `\0` 表示字符串的结束
* 数组是指向数组第一个元素的指针，在指针上进行数学运算指向数组中的元素
* 数组指针是变量，数组是常量
  - 指针可以自加，数组不可以
* 二维数组
  - 可以省略第一维参数
  - 取值 `*(*(q + 1) + 2)`

### Vector

* 存当可变数组，容量可以动态改变，初始化的时候不需要确定数组的大小

### 优先队列 priority_queue

* 队尾插入元素，队头删除元素
* 特点:队头永远是优先级最大的元素，出队顺序与入队顺序无关

## 指针

* `char *p = &c`:定义了一个指向char类型变量指针
* p：存放变量地址，做数学运算
  - *p++: a[i++]:先取指向的变量值 `(*p)` p =p+1
  - *p--: a[i--]
  - *--p: a[--i]：先运算，再取值
  - *++p: a[++i]
* &c 取地址操作
* `*p +1`: *p 取得指针所指向的变量值
* 生命时为指针标识符，使用时为取值操作
* 字符数组指针：用于处理字符串数组，因为字符串长度不一样

## 运算符

* short char 自动转换 int
* float 自动转换double

## 函数

* 形参
  - 传值
  - 引用
  - 指针
    + *p 赋值操作
    + p++ 寻址
  - 常指针
    - 防止对实参修改
    - 实参为常对象地址
  * 数组名：对形参修改即是对实参修改
  * 对象
+ 返回值
  * 指针
* 重载：标志符一样，参数个数或数据类型不一致
* template 模板
  - 只是对函数的描述，编译器不产生任何代码，调用时模板用实参类型代替T类型参数,生产重载函数

## 引用

* 方法在单独文件中声明，编译时需要加上该文件
* 使用 #include "max.c"

## 标准库STL

* 提供了丰富的算法库支持和各种容器
* 迭代器、空间配置器理解
* 常用容器特点、用法以及底层实现vector、list、deque、set、map、unorderedmap
* C++ 标准库提供了包括最基础的标准输入输出iostrem、各种容器vector、set、string ，熟练掌握标准库
* queue
  - front():队列头部
  - pop():从头部开始
  - push();压人尾部
  - back():队列尾部
* stack
* priority_queue:二叉堆，最大（小）值先出
  - pop()：弹出栈顶元素（最大值）

## 标准化输入输出

* printf
  - d 十进制 5d 设定对齐长度
  - o 八进制
  - x 十六进制
  - u 无符号
  - c 字符
  - s 字符串
  - f 浮点
  - e 科学计数法
* scanf
  - 定义了输入格式
  - 一次输入多个变量：遇到 空格 制表符 enter 为变量结束

## 控制

* 分支
  - 关系运算符
  - 逻辑运算符
  - 条件运算符（三元）
  - switch
    + 没有break,会执行所以分支
    + 符合条件的作处理

## 编译

* 多个文件，必须有且只有一个main函数
* 预处理 Pre-Process：处理源文件中 #ifdef #include #define,生成中间文件`*.i`
  - #include <myinc.h> 在预装的库里查找 /usr/include，/usr/local/include，/usr/lib/gcc-lib/i386-linux/2.95.2/include /usr/include/c++/9
  - #include "myinc.h" 在当前目录内查找文件
* 编译 Compiling：输入中间文件，生成汇编语言文件 *.s
* 汇编 Asssembling:将汇编 转换回二进制机器代码
  - main 函数不是必须的
* 链接 Linking：将二进制机器代码文件生成可执行文件
* gcc 参数
  - -c 只编译，不链接
  - -g 产生调试器 gdb,用于对源代码调试
  - -O 优化编译、链接
  - -O2 更好的优化
  - -Wall 输出警告信息
  - -w 关闭警告信息

```sh
gcc -E file.c -o test.i # 预处理
gcc -S test.i -o test.s # 编译
gcc  -c test.s -o test.o # 汇编
gcc test.o -o test
gcc -o test test2.c test3.c test2.c
```

## 头文件与函数定义分离

* 函数声明和定义分离开来
* 加快编译速度:未修改的函数，公共框架和公共类编译生成静态库

## main函数中的参数

```sh
// 将输出保存到t.txt.错误保存到f.txt.从input.txt读入数据
./main.out 1>true.txt 2>false.txt < input.txt
```

## 面对对象 oop

* 类：实现数据封装与抽象的工具
  - 数据成员
    + 不能在声明时初始化，只能通过成员函数实现
    + 自身类对象不能作为类数据成员，自身类指针可以
    + 常数据成员：不能修改的，只能通过初始化时确定
  - 成员函数
    + 类内部实现
    + 类外部 class::func 实现
    + 常成员函数：可以对常对象进行调用，只读方法
      * 经常作为不修改对象数据成员的方法
* 对象
  - 成员引用：obj.attribute || objPointer->attribute
  - 常对象：用const修饰，不能被修改的对象
      * 只有常成员函数可以操作常对象
  - this 隐含在每一个成员函数，指向被操作对象
* 消息：其它对对象提出服务请求
* 构造函数
  - 与类名相同，不能指定函数类型
  - 是成员函数
  - 可以重载
  - 创建对象时调用
  - 没有定义会生成缺省构造函数
  - 如果已定义构造函数，还需要缺省构造函数要显性声明
  - 静态对象没有显性的构造初始化时，按照默认构造函数对数据成员为0或空
* 析构函数
  - 无参且不能指定类型
  - 不能重载
* 拷贝构造
  - 用一个已知对象初始化创建一个同类对象
  - 只有一个参数，是对某一个对象的引用
  - 没有显性定义，会生成一个默认拷贝构造，将已知对象所有数据成员值拷贝到新对象
  - 可通过对象引用或者className::func
* 静态：类成员
  - 数据
    + 初始化在类外进行
  - 函数
    + 可以应用静态数据，不能直接引用非静态数据，通过对象引用
* 友元 friend: 非成员函数访问私有成员方法
  - 提高执行效率，破坏了类封装性与数据的隐秘性
  - 非成员函数，在类内声明，类外实现
  - 可以访问类私有成员
* 封装
  - 访问限定符 public、private、protected
* 继承
  - 继承方式：派生类对象（只有public可以访问基类公有成员）与派生类成员函数都可访问（派生类是否继承基类公有与保护并且指定权限）对基类成员的访问权限
    + public
      * **基类公有成员和保护成员可以被派生类成员函数访问**
      * 基类公有成员和保护成员成为派生类的成员，权限不变，可以被继承
      * 基类公有成员能被派生对象访问
    + protected
      * 基类公有成员和保护成员可被派生类成员函数访问
      * 基类公有成员和保护成员成为派生类的保护成员，可以被继承
      * 基类所有成员不能被派生类对象访问
    + private（默认）
      * 基类公有成员和保护成员可被派生类成员函数访问
      * 基类公有成员和保护成员成为派生类的私有成员，无法被继承
      * 基类所有成员不能被派生类对象访问
  - 派生类构造函数 son(para):father(para),obj(para)
    + 必须调用基类构造函数，保证基类数据初始化
    + 派生类如果有基类子对象，还应对子对象初始化
    + 调用顺序：基类构造-》子对象构造-》派生类构造
  - 派生类析构：派生类-》基类
  - 虚继承、菱形继承
* 多态
  - 静态
    + 函数重载
    + 运算符重载
      * 重载为成员函数：参数会比正常减少一个
      * 重载为友元函数
* 虚函数 virtual
  - 意味该成员函数在派生类中有其他实现
  - 基类指针指向派生类时，普通函数执行基类方法（编译时确定），虚函数执行派生类方法（运行时确定）
  - 声明为基类，传参为派生类时，调用的不是动态联编
  - 动态联编：在运行时决定调用哪个同名函数的方法
  - 派生类与基类的虚函数有相同名称、返回类型、参数个数和参数类型
  - 可以只在基类中声明，派生类隐藏 virtual
  - 纯虚函数:基类不做任何实现 virtual type func(para) = 0;
  - 虚函数表
* 抽象类：至少包含一个虚函数
  - 用来组织继承的层次结构，提供一个公共基类
  - 只能作为其他类基类，不能实例化对象
  - 不能做参数类型，函数返回值类型
  - 通过声明抽象类的指针或引用，可以指向派生类，实现多态.调用方法 ->
* 静态绑定和动态绑定
* new/delete和malloc/free
* 重载、重写和隐藏

## 内存模型

* 程序运行时所需内存空间
  - 固定部分：所占空间都是固定的，而且占用的空间非常小
    + 未初始化数据区(Uninitialized Data)：存放未初始化的全局变量和静态变量
    + 初始化数据区(Initialized Data)：存放已经初始化的全局变量和静态变量
    + 程序代码区(Text)：存放函数体的二进制代码
  - 可变部分
    + 栈区(Stack)：由编译器自动分配释放，存放函数的参数值，局部变量的值等，其操作方式类似于数据结构中的栈。
      * 在代码块执行结束之后，系统会自动回收
    + 堆区(Heap) ：一般由程序员分配释放，若程序员不释放，程序结束时可能由OS收回
      * 需要程序员自己回收，所以也就是造成内存泄漏的发源地
* 内存对齐
  - CPU 读取内存不是一次读取单个字节，而是一次性读取一整个 CacheLine ，这个 CacheLine 的大小是 64 字节

## [细节](https://mp.weixin.qq.com/s/HLmZzFtNF9kVbIGS47E-BA)

* 尽量以const，enum，inline 替换 #define
  - #define 是不被视为语言的一部分，它在程序编译阶段中的预处理阶段的作用，就是做简单的替换
  - 遇到了编译错误，那么这个错误信息也许会提到 3.14 而不是 PI
  - 定义常量字符串，则必须要 const 两次，目的是为了防止指针所指内容和指针自身不能被改变     `const char* const myName = "小林coding";`
  - 对于单纯常量，最好以 const 对象或 enum 替换 #define
  - 对于形式函数的宏，最好改用 inline 函数替换 #define
  - #define 不重视作用域，所以对于 class 的专属常量，应避免使用宏定义 `const std::string myName("小林coding");`
* 尽可能使用 const:告诉编译器和其他程序员某值应该保持不变
  - 面对指针，可以指定指针自身、指针所指物，或两者都（或都不）是 const
  - 面对迭代器，你也指定迭代器自身或自迭代器所指物不可被改变
  - 希望迭代器所指的物不可被改动，需要的是 const_iterator（即声明一个 const T* 指针）

```c++
char myName[] = "小林coding";
char *p = myName;             // non-const pointer, non-const data 指针所指物是常量（不能改变 *p 的值）
const char* p = myName;       // non-const pointer, const data 表示指针自身是常量（不能改变 p 的值）
char* const p = myName;       // const pointer, non-const data
const char* const p = myName; // const pointer, const data 表示指针所指物和指针自身都是常量
```

## C++11

* 新标准提供了解决现有问题更优雅、更 C++ 的实现。现行的大部分 C++ 软件还是 C++98 的标准，C++98 是 C++ 的第一个标准，经历这么多年的发展，从前你需要从Boost库（一个在 C++98 年代的准 C++ 标准）获得的对 C++ 的扩充支持的大部分功能已经纳入了 C++11 和甚至 C++2X 更新的标准当中，与时俱进拿起更先进的生产工具，工具就是效率

## 面试

* 指针和引用的区别
* define和const
* 内联函数和define
* c++内存管理
* 栈和堆区别，全局变量和局部变量
* c++多态，虚函数，纯虚函数
* 多态的好处
* 数据库索引，给一个语句问有没有用到索引，底层怎么实现的
* B树和B+树
* 哈希冲突
* 说一说常见的排序算法和时间，空间复杂度
* TCP,UDP,可靠传输，网络什么时候拥塞
* 为什么要内存对齐
* 非对称加密和对称加密
* static变量和局部变量
* 内存溢出
* 会gdb调试？说一下gdb调试的原理
* c++11有哪些特性，实现一下shared_ptr
* 多线程怎么进行调度
* memcpy写一下
* strcpy写一下
* 了解c++多态吗，那用c实现一下。
* 擅长的语言（C语言，C++），对C++的了解程度
* malloc和new分配内存的区别
* malloc内部的实现原理
* malloc能够分配的最大内存空间（32位）（提到了段），如果申请了2G的内存，会立即与物理地址对应吗，如果不会，往里面写数据的时候
* 否会产生缺页中断
* 如何查看段的范围和大小
* elf目标可执行文件的组成部分，elf文件中的段跟运行时的段有什么区别
* 如何装载目标文件到内存当中
* 缺页中断的处理过程
* 提到了换页换出的时候会产生缺页中断，反问是否一定是换页产生的吗？上面提到的未分配空间呢？
* 这种缺页中断在系统和硬件中是由哪些CPU，寄存器参与的。
* 提到了MMU，CR3寄存器
* 为了加快页表的转换，会使用一些什么样的硬件和软件
* 了解大页内存吗？它是什么概念，有什么优点和缺点。优点：减少页表
* 对于汇编这部分了解多吗？C语言的函数调用在汇编的角度是怎么实现的？
* 提到了ebp，esp函数栈，jmp跳转
* Linux库函数memcpy，能不能想出比较高效的内存拷贝方式。除了按字节拷贝还有没有性能更好的方法。
* Linux上运行的进程的CPU有什么组成部分，整体的CPU占用和每一块的CPU的占用。怎么用top去看一个进程的CPU占用的组成部分。（是
* C++ STL里面有很多性能优化相关的类，这个你了解吗？STL的string类本身有多大，如何保存字符串的？vector如何动态扩展空间？
* 提到了size()和capacity()
* 挑一个研究的最深的技术点。挑自己最擅长的说，比如说网络编程、系统内核啊等等
* 乐观锁和悲观锁的区别
* 提到了CAS
* 问到了CAS的应用场景，CAS允许有短暂的访问迟滞吗？
* CAS为了实现锁的原语，在Linux系统上是怎么去实现的？
* 谈的是RING中的源码，使用多个struct，但是他说没有谈到点上，想问的是背后原理（汇编也好，x86架构上也好）（可能是单句汇编语言或者是总线锁）
* volatile关键字的作用？主要是为了解决什么问题？为了防止编译器进行哪种方式的优化？
* 为了防止编译器优化，最核心的是做了什么优化，怎么理解直接去读这个值
* 缓存是一个什么样的硬件？
* 寄存器也算是缓存的一部分吗？
* CPU访问寄存器、访问缓存、访问内存哪个快？访问的时间周期是多少？快多少倍？
* 技术也好、做事情的方式也好的优势和劣势？
* 为什么不用CNN，用LSTM
* LSTM为什么可以缓解梯度消失
* 什么是梯度消失和梯度爆炸
* 为什么要提取时序信息
* 说一下RNN和CNN
* 虚指针
* 写一下单例模式，别的进程可以访问这个进程的创建的单例模式的实例吗
* 说一下内存泄漏
* 有几个虚函数表
* while(1)死循环
* attention机制
* 说一下继承中的构造函数和析构函数
* 野指针讲
* 平衡二叉树怎么插入一个结点
* TCP怎么重传
* 共享内存为什么可以实现进程通信
* 每个进程都有自己的内存，为什么可以访问共享内存
* 希尔排序吗，比直接插入排序快吗，为什么，时间复杂度平均多少
* 单链表快排
* 写一下反转单链表
* [TechCPP](https://github.com/youngyangyang04/TechCPP)C++面试&C++学习指南

## 图书

* 《Programming: Principles and Practice Using C++ C++程序设计原理与实践》Bjarne Stroustrup
* 《The C++ Programming Language C++程序设计语言》
* **《C++ Primer》**
  - 《[C++ Primer习题集(第5版)](https://www.amazon.cn/gp/product/B00S6U4C6E) 》
* 《[Effective C++:改善程序与设计的55个具体做法](https://www.amazon.cn/gp/product/B004G72P24) 》 todo 写过几万行C++代码之后，再去阅读会更好。而且推荐每年都至少读一遍。
* 《[More Effective C++:35个改善编程与设计的有效方法](https://www.amazon.cn/gp/product/B004IP8BD6) 》
* 《[C++编程思想 Think in C++](https://www.amazon.cn/gp/product/B005CFUQR0)》
* Modern C++ Tutorial
* 《C++ 标准程序库》
* 《[C++标准库](https://www.amazon.cn/gp/product/B00YLZIRHI)》
* 《STL源码剖析》
* inside c++ model
* 《深入理解C++11》
* 《深度探索 C++ 对象模型》
  - [modern-cpp-tutorial](https://github.com/changkun/modern-cpp-tutorial)📚 C++11/14/17 On the Fly <https://changkun.de/modern-cpp/>
* 《C++语言的设计与演化》
* [Optimizing software in C++](https://www.agner.org/optimize/optimizing_cpp.pdf)
* C++ 沉思录
* [C++ 匠心之作 从0到1入门](https://github.com/AnkerLeng/Cpp-0-1-Resource)

## 工具

* IDE
  - [Code::Blocks](http://www.codeblocks.org) <https://launchpad.net/~codeblocks-devs/+archive/ubuntu/release>
    + `sudo add-apt-repository ppa:codeblocks-devs/release`
    + sudo apt-get update
    + `sudo apt-get install codeblocks codeblocks-contrib`
  - Qtcreator
* [concurrentqueue](https://github.com/cameron314/concurrentqueue):A fast multi-producer, multi-consumer lock-free concurrent queue for C++11
* [phxpaxos](https://github.com/Tencent/phxpaxos)：The Paxos library implemented in C++ that has been used in the WeChat production environment.
* [libco](https://github.com/Tencent/libco)libco is a coroutine library which is widely used in wechat back-end service.
* [flameshot](https://github.com/lupoDharkael/flameshot):Powerful yet simple to use screenshot software
* [doctest](https://github.com/onqtam/doctest):The fastest feature-rich C++11 single-header testing framework for unit tests and TDD <http://bit.ly/doctest-docs>
* package manager
  - [vcpkg](https://github.com/Microsoft/vcpkg):C++ Library Manager for Windows, Linux, and MacOS
* [Catch2](https://github.com/catchorg/Catch2):A modern, C++-native, header-only, test framework for unit-tests, TDD and BDD - using C++11, C++14, C++17 and later (or C++03 on the Catch1.x branch) <https://discord.gg/4CWS9zD>
* [asio](https://github.com/boostorg/asio) Boost.org asio module http://boost.org/libs/asio
* [beast](https://github.com/boostorg/beast)HTTP and WebSocket built on Boost.Asio in C++11 http://www.boost.org/libs/beast
* [Boost.Hana](https://www.boost.org/doc/libs/1_61_0/libs/hana/doc/html/index.html):Hana is a header-only library for C++ metaprogramming suited for computations on both types and values
* [benchmark](https://github.com/google/benchmark):A microbenchmark support library

## 参考

* [C/C++ 开源库及示例代码](https://github.com/programthink/opensource/blob/master/libs/cpp.wiki)
* [cppreference](https://en.cppreference.com/)
* [CppCoreGuidelines](https://github.com/isocpp/CppCoreGuidelines):The C++ Core Guidelines are a set of tried-and-true guidelines, rules, and best practices about coding in C++<http://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines>
* [Google C++ Style Guide](https://google.github.io/styleguide/cppguide.html)
* [awesome-cpp](https://github.com/fffaraz/awesome-cpp):A curated list of awesome C++ (or C) frameworks, libraries, resources, and shiny things. Inspired by awesome-... stuff. <http://fffaraz.github.io/awesome-cpp/>
* [interview](https://github.com/huihut/interview):📚 C/C++面试知识总结
* Qt
  - [Awesome Qt](https://github.com/fffaraz/awesome-qt)：一系列优秀的`Qt`库和资源
  - [3rd-party-applications](https://github.com/Razor-qt/razor-qt/wiki/3rd-party-applications)：一系列优秀的`Qt`第三方程序
