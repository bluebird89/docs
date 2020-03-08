# [C](link)

## 编译器

* CMake 编译程序需要两步
    - 执行 Cmake 生成配置文件，主要是 Makefile；具体做法是执行`cd build && cmake -f ../`命令，之后在 build 目录下，会发现 CMake 根据系统环境如编译器、头文件等自动生成了一份 Makefile
    -  build 目录运行 make，让 make 驱动 gcc 编译、链接生成二进制可执行程序，这个过程可能会持续几分钟。最后在 build/bin 目录下，会生成所有可运行的二进制程序

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

* -o选项用来指定输出文件的文件名：将test.c预处理、汇编、编译并链接形成可执行文件test。。
*  -E

          用法：#gcc -E test.c -otest.i

          作用：将test.c预处理输出test.i文件。
*  -S

          用法：#gcc -S test.i

          作用：将预处理输出文件test.i汇编成test.s文件。
*  选项 -c

          用法：#gcc -c test.s

          作用：将汇编输出文件test.s编译输出test.o文件。
* 无选项链接

          用法：#gcc test.o -o test

          作用：将编译输出文件test.o链接成最终可执行文件test。
* -O

          用法：#gcc -O1 test.c -otest

          作用：使用编译优化级别1编译程序。级别为1~3，级别越大优化效果越好，但编译时间越长。
个文件一起编译

          用法：#gcc testfun.ctest.c -o test

          作用：将testfun.c和test.c分别编译后链接成test可执行文件。

          2. 分别编译各个源文件，之后对编译后输出的目标文件链接。

          用法：

          #gcc -ctestfun.c //将testfun.c编译成testfun.o

          #gcc -ctest.c //将test.c编译成test.o

          #gcc -otestfun.o test.o -o test //将testfun.o和test.o链接成test

          以上两种方法相比较，第一中方法编译时需要所有文件重新编译，而第二种方法可以只重新编译修改的文件，未修改的文件不用重新编译。
## 工具

* [tboox/tbox](https://github.com/tboox/tbox):📦 A glib-like multi-platform c library http://tboox.org
* [nodejs/http-parser](nodejs/http-parser):http request/response parser for c
* [hellogcc/100-gdb-tips](https://github.com/hellogcc/100-gdb-tips):A collection of gdb tips. 100 maybe just mean many here. 
* 
* [Source Insight](https://www.sourceinsight.com/)
