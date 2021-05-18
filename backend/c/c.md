# [C](link)

* 编写好的C程序需要先编译成可执行的机器指令才能运行
  - 预处理作为一个阶段，它主要是对源文件进行一些处理，比如将#define替换成实际值、将#include指定的文件内容填充进来。
  - 编译（compile）就是源代码到目标代码
  - 链接(link)是将各个目标文件链接起来从而形成一个可执行的程序，当然链接器也会引入被程序所用到的所有标准C函数库的函数

## 配置


```sh
g++ -v -E -x c++ -

# 添加到 includePath中
```

## 编译器

* GCC，GCC即（GNU Compiler Collection，GNU编译器套件），由GNU开发的GPL许可的编译器自由软件。刚开始只作为C语言编译器，但后来发展成多种语言编译器，比如C、C++、Java、Android、Objective-C和Fortran等等。现在很多unix-like操作系统自带GCC，将其作为标准编译器。
* MS C，与微软的Visual Studio一起集成发布，由微软提供的一套完整的集成开发环境，编译后能在微软的所有操作系统上运行。比如VS一般会使用CL编译器。
* Clang，它是一个基于LLVM的C/C++/Objective-C轻量级编译器，常用于Mac系统下。
* Turbo C，这是一个比较流行的C编译器，小巧快速。
* cc，即C Compiler，这是一个unix系统古老的编译器，很多经典书籍会看到这个编译器。为保持兼容，现在的linux系统会将cc作为一个符号连接指向gcc，即/usr/bin/cc -> gcc。
* CMake 编译程序需要两步
  - 执行 Cmake 生成配置文件，主要是 Makefile；具体做法是执行`cd build && cmake -f ../`命令，之后在 build 目录下，会发现 CMake 根据系统环境如编译器、头文件等自动生成了一份 Makefile
  - build 目录运行 make，让 make 驱动 gcc 编译、链接生成二进制可执行程序，这个过程可能会持续几分钟。最后在 build/bin 目录下，会生成所有可运行的二进制程序

```sh
sudo apt install gcc-7 g++-7 gcc-8 g++-8 gcc-9 g++-9

gcc --version
# ubuntu
gcc test.c -o test
./test

# vscode
Ctrl+Shift+B
```

## 运行

* Linux平台上的编译器更为重要，最典型的当属 GCC
* 企业里实际项目的编译动作叫 make，编译的实际动作和过程都是写在 makefile文件里，所以makefile的书写规则建议学习！
* -o 指定输出文件的文件名
* -E：gcc -E test.c -o test.i  // 预处理
* -S：gcc -S test.i  // 将预处理输出文件test.i汇编成test.s文件
* -c：gcc -c test.s  // 编译
* -O：gcc -O1 test.c -otest // 使用编译优化级别1编译程序。级别为1~3，级别越大优化效果越好，但编译时间越长
* gcc testfun.c test.c -o test // 编译链接
* gcc -otestfun.o test.o -o test // 链接

```sh
gcc -c adder.c
gcc -c name.c
gcc name.o adder.o hello.c
```

## 结构体 struct

* 复合数据类型的一种。同时也是一些元素的集合，这些元素称为结构体的成员，且这些成员可以为不同的类型
* 成员一般用名字访问
* 结构体可以被声明为变量、指针或数组等，用以实现较复杂的数据结构

## 指针

## 内存管理

## 编译安装

* 配置（configure）
  - 因为不同计算机的系统环境不一样，通过指定编译参数，编译器就可以灵活适应环境，编译出各种环境都能运行的机器码。这个确定编译参数的步骤
  - 配置信息保存在一个配置文件之中，约定俗成是一个叫做configure的脚本文件。通常它是由autoconf工具生成的。编译器通过运行这个脚本，获知编译参数
  - 手动向configure脚本提供编译参数 `./configure --prefix=/www --with-mysql`
* 确定标准库和头文件的位置
  - 从配置文件中知道标准库和头文件的位置。一般来说，配置文件会给出一个清单，列出几个具体的目录。等到编译时，编译器就按顺序到这几个目录中，寻找目标。
* 确定依赖关系
  - 编译器需要确定编译的先后顺序,编译顺序保存在一个叫做makefile的文件中，里面列出哪个文件先编译，哪个文件后编译。
  - makefile文件由configure脚本运行生成，这就是为什么编译时configure必须首先运行的原因。
* 头文件的预编译（precompilation）
  - 不同的源码文件，可能引用同一个头文件（比如stdio.h）。为了节省时间，编译器会在编译源码之前，先编译头文件。这保证了头文件只需编译一次，不必每次用到的时候，都重新编译了。
  - 用来声明宏的#define命令，就不会被预编译
* 预处理（Preprocessing）
  - 替换掉源码中bash的头文件和宏
* 编译（Compilation）
  - 生成机器码。对于某些编译器来说，还存在一个中间步骤，会先把源码转为汇编码（assembly），然后再把汇编码转为机器码
* 连接（Linking）
  - 把外部函数的代码（通常是后缀名为.lib和.a的文件），添加到可执行文件中
  - 静态连接:通过拷贝，将外部函数库添加到可执行文件的方式
    + 适用范围比较广，不用担心用户机器缺少某个库文件；缺点是安装包会比较大，而且多个应用程序之间，无法共享库文件
  - make命令:从头文件预编译开始，一直到做完这一步
* 安装（Installation）
  - 上一步的连接是在内存中进行的，即编译器在内存中生成了可执行文件。下一步，必须将可执行文件保存到用户事先指定的安装目录。
  - 将可执行文件（连带相关的数据文件）拷贝过去:创建目录、保存文件、设置权限等步骤
* 操作系统连接
  - 在操作系统中，登记这个程序的元数据：文件名、文件描述、关联后缀名等等。Linux系统中，这些信息通常保存在/usr/share/applications目录下的.desktop文件中
  - make install命令:用来完成"安装"和"操作系统连接"
* 动态连接: 外部函数库不进入安装包，只在运行时动态引用
  - 好处是安装包会比较小，多个应用程序可以共享库文件；缺点是用户必须事先安装好库文件，而且版本和安装位置都必须符合要求，否则就不能正常运行。
  - 现实中，大部分软件采用动态连接，共享库文件。这种动态共享的库文件，Linux平台是后缀名为.so的文件，Windows平台是.dll文件，Mac平台是.dylib文件

## 课程

* [cse251](http://cse.msu.edu/~cse251/)

## 图书

* 《[C Programming Language (2nd Edition) C程序设计语言（第2版）](https://www.amazon.cn/gp/product/B0011425T8)》
* C语言程序设计现代方法
* 《C Primer Plus》
  - 这地方有一个巨大的错觉，就是读完一遍《C Primer Plus》后就觉得自己会CLang了，有这种优越感的，请你尝试用CLang做个什么东西出来？然后你发现似乎真的什么也做不了，这会儿就可以步入到《Unix环境高级编程》的节奏
  - 面向对象编程的哲学思想是，通过对语言建模来适应问题，而不是对问题建模来适应语言。
* 《[C标准库](https://www.amazon.cn/gp/product/B00IZW4DK8)》
* 《[C和指针](https://www.amazon.cn/gp/product/B00163LU68)》
* 《[C专家编程](https://www.amazon.cn/gp/product/B0012NIW9K)》
* 《[C陷阱与缺陷](https://www.amazon.cn/gp/product/B0012UMPBY)》
* 《[C语言接口与实现](https://www.amazon.cn/gp/product/B01D10NSCM)》
* 《C语言参考手册（第5版）》
* 《C程序设计语言》C 编程语言；如何像程序员一样思考；底层计算模型
* [C Internals](http://www.avabodh.com/cin/cin.html)

## 工具

* [tbox](https://github.com/tboox/tbox):📦 A glib-like multi-platform c library <http://tboox.org>
* [http-parser](nodejs/http-parser):http request/response parser for c
* [Source Insight](https://www.sourceinsight.com/)
* ccache：高速C/C++编译缓存工具，反复编译内核非常有用。使用起来也非常方便
* 陈皓 《跟我一起写makefile》
