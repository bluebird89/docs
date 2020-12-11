# [C](link)

* 编写好的C程序需要先编译成可执行的机器指令才能运行
  - 预处理作为一个阶段，它主要是对源文件进行一些处理，比如将#define替换成实际值、将#include指定的文件内容填充进来。
  - 编译（compile）就是源代码到目标代码
  - 链接(link)是将各个目标文件链接起来从而形成一个可执行的程序，当然链接器也会引入被程序所用到的所有标准C函数库的函数

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

```
gcc -c adder.c
gcc -c name.c
gcc name.o adder.o hello.c
```

## 结构体(struct)

* 复合数据类型的一种。同时也是一些元素的集合，这些元素称为结构体的成员，且这些成员可以为不同的类型
* 成员一般用名字访问
* 结构体可以被声明为变量、指针或数组等，用以实现较复杂的数据结构

## 指针

## 内存管理

## 图书

* 《[C Programming Language (2nd Edition) C程序设计语言（第2版）](https://www.amazon.cn/gp/product/B0011425T8)》
* C语言程序设计现代方法
* 《C Primer Plus》
  - 这地方有一个巨大的错觉，就是读完一遍《C Primer Plus》后就觉得自己会CLang了，有这种优越感的，请你尝试用CLang做个什么东西出来？然后你发现似乎真的什么也做不了，这会儿就可以步入到《Unix环境高级编程》的节奏
* 《C专家编程》
* 《[C标准库](https://www.amazon.cn/gp/product/B00IZW4DK8)》
* 《[C和指针](https://www.amazon.cn/gp/product/B00163LU68)》
* 《[C专家编程](https://www.amazon.cn/gp/product/B0012NIW9K)》
* 《[C陷阱与缺陷](https://www.amazon.cn/gp/product/B0012UMPBY)》
* 《[C语言接口与实现](https://www.amazon.cn/gp/product/B01D10NSCM)》
* 《C语言参考手册（第5版）》
* 《C程序设计语言》：C 编程语言；如何像程序员一样思考；底层计算模型
* [C Internals](http://www.avabodh.com/cin/cin.html)

## 工具

* [tbox](https://github.com/tboox/tbox):📦 A glib-like multi-platform c library <http://tboox.org>
* [http-parser](nodejs/http-parser):http request/response parser for c
* [Source Insight](https://www.sourceinsight.com/)
* ccache：高速C/C++编译缓存工具，反复编译内核非常有用。使用起来也非常方便
* 陈皓 《跟我一起写makefile》
