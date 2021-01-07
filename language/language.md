# 编程语言

* 计算机（Computer）:在计算机的层次上，CPU执行的是加减乘除的指令代码，以及各种条件判断和跳转指令
* 计算（Compute）:指数学意义上的计算，越是抽象的计算，离计算机硬件越远
* 两门以上编程语言（强类型+弱类型)

## 发展

* 汇编语言
* Compiled language
  - compile the program and then run the executable
  - 编译器：把源程序的每一条语句都编译成机器语言 machine code,并保存成二进制文件,运行时计算机可以直接以机器语言来运行此程序,速度很快
  - machine code which can be directly read by your operating system. When you execute that program, your OS will know how exactly to run it
* Interpreted language
  - run the source code directly
  - 对于解释型语言，需要一个专门解释器解释执行
  - 解释器：只在执行程序时,才一条一条解释成机器语言给计算机来执行,所以运行速度是不如编译后的程序运行的快
  - 翻译器并不产生目标机器代码，而是产生易于执行中间代码 bytecode
  - 中间代码与机器代码是不同的，中间代码解释是由软件支持的，不能直接使用硬件，软件解释器通常会导致执行效率较低
  - 用解释型语言编写的程序是由另一个可以理解中间代码的解释程序执行的
  - 与编译程序不同的是，解释程序的任务是逐一将源程序的语句解释成可执行的机器指令，不需要将源程序翻译成目标代码后再执行
  - To run this bytecode, we have something called Virtual Machines. These so called Virtual Machines are the programs which can read the bytecode and run it on a given operating system
* Compiled vs. Interpreted
  - Compiling a C program would produce what we also know as machine code. As opposed to bytecode.
  - Generally, when we run a python program, a python VM process is started which reads the python source code, compiles it to byte code and run it in a single step. Compiling is not a separate step. Shown only for illustration purpose.
  - Binaries generated for C like languages are not exactly run as is. Since there are multiple types of binaries (eg: ELF), there are more complicated steps involved in order to run a binary but we will not go into that since all that is done at OS level.
* 函数：把长长的代码封装起来，这样就写一次，就可以到处调用了
* 数据结构：把参数组织起来，以后就传递这个数据结构
* oop
  - Object：数据和操作给结合起来，形成Objec，以后Object的属性数据不允许直接访问，只能通过这个Object的函数来操作
    + Object的方法都是相同的，他们被重复地放在一个个对象当中，Class！把这些重复的方法代码从对象中剥离出来，放到一个公共的Class中！用new 这个关键字： Stack object1 = new Stack();
  - Stack类的函数定义只有一份，但是Stack类生成的Object有很多份。人类在写push()函数，pop()函数的时候，要操作Object的数据， 到底操作的是哪一个Object？ 上帝说：“ 要有this !”
  - 有继承！把那些类似的、重复代码放到父类当中去，这样子类就可以直接使用，不用重新再写一遍了
  - 要有多态！就是对同一个接口，使用不同的实例而执行不同操作。
  - 继承破坏了封装性，父类的很多细节对子类都是可见的，父类的变化可能会极大地影响子类。优先使用组合而不是继承.面向接口编程，而不是实现编程。
  - 编程的关键是要抽象啊！得把系统需求抽象成高层的概念，然后在概念层次进行编程。
* 对应到编程语言，就是越低级语言，越贴近计算机，抽象程度低，执行效率高，比如C语言；越高级的语言，越贴近计算，抽象程度高，执行效率低，比如Lisp语言。
* 静态语言 statically typed language:在编译期间就能够知道数据类型的语言，在运行前就能够检查类型的正确性，一旦类型确定后就不能再更改
  - the compiler is written in a way that it can verify types related errors during compile time
* 动态语言|脚本语言 dynamic language
  - 没有任何特定的情况需要指定变量的类型，在运行时确定的数据类型.因其易于编写和易于运行的特性，被预测在未来将发展强大
  - types are not known until a program is run. So in a way, python compiler is dumb (or, less strict)
  - 脚本语言”（script language），指不具备开发操作系统的能力，而是只用来编写控制其他大型应用程序（比如浏览器）的“脚本”
  -  dynamically typed language, that means all types are determined at runtime. And that makes python run very slow compared to other statically typed languages.
* C语言是可以用来编写操作系统的贴近硬件的语言，所以，C语言适合开发那些追求运行速度、充分发挥硬件性能的程序。而Python是用来编写应用程序的高级编程语言
* 高级编程语言通常都会提供一个比较完善的基础代码库，能直接调用

```
                                                        The Operating System

                                                              +------------------------------------+
                                                              |                                    |
                                                              |                                    |
                                                              |                                    |
hello_world.py                    Python bytecode             |         Python VM Process          |
                                                              |                                    |
+----------------+                +----------------+          |         +----------------+         |
|print(...       |   COMPILE      |LOAD_CONST...   |          |         |Reads bytecode  |         |
|                +--------------->+                +------------------->+line by line    |         |
|                |                |                |          |         |and executes.   |         |
|                |                |                |          |         |                |         |
+----------------+                +----------------+          |         +----------------+         |
                                                              |                                    |
                                                              |                                    |
                                                              |                                    |
hello_world.c                     OS Specific machinecode     |         A New Process              |
                                                              |                                    |
+----------------+                +----------------+          |         +----------------+         |
|void main() {   |   COMPILE      | binary contents|          |         | binary contents|         |
|                +--------------->+                +------------------->+                |         |
|                |                |                |          |         |                |         |
|                |                |                |          |         |                |         |
+----------------+                +----------------+          |         +----------------+         |
                                                              |         (binary contents           |
                                                              |         runs as is)                |
                                                              |                                    |
                                                              |                                    |
                                                              +------------------------------------+
```

## 类别

* 面向对象
* 命令式
* 函数式
* 程序式

## 方法

* 请千万不要用“复制”-“粘贴”把代码从页面粘贴到你自己的电脑上。写程序也讲究一个感觉，你需要一个字母一个字母地把代码自己敲进去，在敲代码的过程中，初学者经常会敲错代码：拼写不对，大小写不对，混用中英文标点，混用空格和Tab键，所以，你需要仔细地检查、对照，才能以最快的速度掌握如何写程序。
* 快速预览技术整体
* 积累案例库
* 通过微服务融合
* 技术难点
  * 偏理论：碎片化
  * 偏实践
* 技术分享
* 工程实施。即使用该语言时，开发应用时需要哪些实践
* 应用开发。理解完整的开发应用所需要的知识体系
* 框架设计。使用该语言如何进行各种抽象设计
  - 抽象。语言如何进行抽象
  - 如何进行跨语言的设计支持
  - 模块化开发。如何完成跨团队、跨业务模块的代码、服务共享。
  - 包管理/依赖管理。如如何构建，并发布到制品仓库，实现复用
* 语言练习。要么用它来写语法解析，要么来解析这门语言
  - 编写其它语言/DSL 的解析器
  - 使用其它语言编写该语言的解析器
  - 使用该语言解析该语言
* 领域特定编程/场景编程。即寻找适合这门语言的场景

## 内容

* 了解编程语言的语法特征
  - 数据类型
  - 运算符
  - 控制语句
  - 编程模式
* 掌握编译或解释的过程，及编译器/解释器性能，调试方法、工具
* 配合算法，实现业务逻辑

## 闭包

* 变量的值始终保持在内存中

## 词汇

* Expression
* Statement
* Lexical

## 工具

* [bazel](https://github.com/bazelbuild/bazel):a fast, scalable, multi-language and extensible build system <https://bazel.build>
* [semantic](https://github.com/github/semantic):Parsing, analyzing, and comparing source code across many languages
* [gaia](https://github.com/gaia-pipeline/gaia):Build powerful pipelines in any programming language.

## 语言

* [unison](https://github.com/unisonweb/unison):Next generation programming language, currently in development <http://unisonweb.org>
* [v](./v.md)
* [taichi](https://github.com/taichi-dev/taichi):The Taichi programming language <http://taichi.graphics>
* [ChezScheme](https://github.com/cisco/ChezScheme) Chez Scheme is both a programming language and an implementation of that language, with supporting tools and documentation.
* [crystal](https://github.com/crystal-lang/crystal) The Crystal Programming Language <https://crystal-lang.org>
* [julia](https://github.com/JuliaLang/julia) The Julia Language: A fresh approach to technical computing. <https://julialang.org/>
* [skip](https://github.com/skiplang/skip):A programming language to skip the things you have already computed <http://www.skiplang.com>

## 资源

* [learndesignthehardway](https://www.learndesignthehardway.com)
* [arl](https://github.com/kaxap/arl) lists of most popular repositories for most favoured programming languages
* [freeCodeCamp](https://github.com/freeCodeCamp/freeCodeCamp):The <https://freeCodeCamp.org> open source codebase and curriculum. Learn to code for free together with millions of people.
* [Best-websites-a-programmer-should-visit](https://github.com/sdmg15/Best-websites-a-programmer-should-visit):🔗 Some useful websites for programmers.
* [ProgrammingLanguage-Series](<https://github.com/wx-chevalier/ProgrammingLanguage-Series>📚 编程语言语法基础与工程实践，JavaScript | Java | Python | Go | Rust | CPP | Swift)
* [Learn X in Y minutes](https://learnxinyminutes.com/)
