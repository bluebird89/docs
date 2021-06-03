# 编译原理

* 编译器是一个将高级语言翻译为低级语言的程序
* 利用现成的工具去生成/操作一个抽象语法树（AST），甚至可以会写一个DSL（领域特定语言）。所以得理解词法分析、语法分析、语义分析，中间代码生成，代码优化这个基本编译的过程。学习了编译与原理，会对语言的一些设计有更深的理解，比如LISP
* 指令系统
  - 精简指令集计算机（RISC）:供了最小的机器指令集，计算机效率高速度快且制造成本低
  - 复杂指令集计算机(CISC):提供了强大丰富的指令集，能更方便实现复杂的软件
  - 三类
    + 数据传输类指令用于将数据从一个地方移动到另一个地方。比如将主存单元的内容加载到寄存器的LOAD指令，反之将寄存器的内容保存到主存的STORE指令。此外，CPU与其它设备（键盘、鼠标、打印机、显示器、磁盘等）进行通信的指令被称为I/O指令。
    + 算术/逻辑类指令用于让控制单元请求在算术/逻辑单元内执行运算。这些运算包括算术、与、或、异或和位移等。
    + 控制类指令用于指导程序执行。比如转移（JUMP）指令，它包括无条件转移和条件转移


* Expression
* Statement
* Lexical

## 编译器

* 作用就是输入一个文本文件输出一个二进制文件
* 词法分析
  - 把源代码中的每个“单词”提取出来，在编译技术中“单词”被称为token
  - 不只是每个单词被称为一个token，除去单词之外的比如左括号、右括号、赋值操作符等都被称为token
* 语法分析：根据语言定义的语法恢复其原本结构
  - 在扫描出各个token后根据规则将其用树的形式表示出来，这颗树就被称为语法树
* 语义分析：检查这棵树是不是合法的，比如不能把一个整数和一个字符串相加、比较符左右两边的数据类型要相同
* 中间代码生成：遍历语法树并用中间代码 intermediate representation code IR code来表示
* 中间代码优化
* 优化后的中间代码转换为机器码

## 图书

* Compilers: Principles,Techniques,and Tools(the Dragon Book) 编译原理技术和工具 Alfred V.Aho,Ravi Sethi,Jeffrey D.Ullman

* [Modern Compiler Implementation in C  现代编译原理-C语言描述](https://www.cs.princeton.edu/~appel/modern/c/)
  - 《编译原理》：<https://www.bilibili.com/video/av17649289>
* Advanced Compiler Design and Implementation 高级编译器设计与实现 Steven S.Muchnick
* [Crafting Interpreters](https://craftinginterpreters.com/contents.html)
  - [Alex Aiken’s course on edX](https://www.edx.org/course/compilers)

## 工具

* [Compiler Expolorer](https://godbolt.org/)

## 参考

* [the-super-tiny-compiler](https://github.com/jamiebuilds/the-super-tiny-compiler):snowman Possibly the smallest compiler ever <https://git.io/compiler>

### Philosophy

-   [What every compiler writer should know about programmers. M. Anton Ert](https://c9x.me/compile/bib/ubc.pdf) Contains some good warnings about taking the slippery path many compiler writers are taking with respect to undefined behavior.

### Compiler Descriptions

-   [A New C Compiler. Ken Thompson.](https://c9x.me/compile/bib/new-c.pdf)A description of the portable C99 Plan 9 compilers.
-   [A Tour Through the Portable C Compiler. S. C. Johnson. ](https://c9x.me/compile/bib/pcc-tour.pdf)It is probably not a very good reference, but full compiler descriptions are pretty rare. The [PCC compiler](http://pcc.ludd.ltu.se/) has changed quite a bit since this writeup.
-   A Retargetable C Compiler: Design and Implementation. David R. Hanson and Christopher W. Fraser. A resonably sized book exposing the full source code of a [retargetable compiler](https://github.com/drh/lcc) (lcc). I found the parts describing the frontend and the automatic code generator most interesting.

### Books

-   [Compiler Construction. Niklaus Wirth](https://c9x.me/compile/bib/wirthcc.pdf)An elementary and short textbook to learn the basics of compilation. Written by Wirth, a Turing award winner, inventor of Pascal.
-  [ Compilers: Principles, Techniques, and Tools. Alfred V. Aho, Ravi Sethi, and Jeffrey D. Ullman. ](http://www.amazon.com/Compilers-Principles-Techniques-Alfred-Aho/dp/0201100886)Despite being intimidating, it is a very readable book with many examples. It has the best material available on lexing and parsing. Some key concepts of more advanced optimizations are also very nicely exposed.
-   [Advanced Compiler Design and Implementation. Steven Muchnick. ](http://www.amazon.com/Advanced-Compiler-Design-Implementation-Muchnick/dp/1558603204)A pretty comprehensive exposition of compiler technology. Many details are left aside and some code is wrong. Its main value is I think the span of its coverage.
-   Hacker's Delight. Henry S. Warren, Jr. This is a really fun book for computer geeks. It is also filled with tricks that can be used for strength reduction. For example, it will teach you how to turn a division by a constant into a multiplication.

### Dominators and Static Single Assignment

-   [The Static Single Assignment Book.] (http://ssabook.gforge.inria.fr/latest/book.pdf)A very detailed and practical book about many aspects of the SSA intermediate representation.
-   [Simple and Efficient Construction of Static Single Assignment Form. Matthias Braun, Sebastian Buchwald, Sebastian Hack, Roland Leißa, Christoph Mallon, and Andreas Zwinkau.] (https://c9x.me/compile/bib/braun13cc.pdf)Combining laziness and memoization, the authors make a naive construction algorithm both efficient and correct. The algorithm is especially useful for fixing SSA invariants locally broken.
-   [An Efficient Method of Computing Static Single Assignment Form. Ron Cytron, Jeanne Ferrante, Barry K. Rosen, Mark N. Wegman, and F. Kenneth Zadeck. ](https://c9x.me/compile/bib/ssa.pdf)The paper explaining the classic construction algorithm of SSA form using domination information.
-   [A Simple, Fast Dominance Algorithm. Keith D. Cooper, Tymothy J. Harvey, and Ken Kennedy. ](https://c9x.me/compile/bib/quickdom.pdf)An algorithm to compute the domination information very practical and simple to implement. It can be slower than the more complex Lengauer-Tarjan algorithm on huge input programs.

### Optimizations

-   [Constant Propagation with Conditional Branches. Mark N. Wegman and F. Kenneth Zadeck.] (https://c9x.me/compile/bib/constpropssa.pdf)The state-of-the-art algorithm for constant propagation (known as sparse conditional constant propagation). Despite being cutting edge, the algorithm remains simple.
-   [Global Code Motion Global Value Numbering. Cliff Click.] (https://c9x.me/compile/bib/click-gvn.pdf)Explains how to make value numbering a global optimization by leveraging SSA form and an independent global code motion algorithm.

### Register Allocation

-   [Linear Scan Register Allocation. Massimiliano Poletto and Vivek Sarkar. ](https://c9x.me/compile/bib/linearscan.pdf)The classic linear scan paper, this algorithm is fairly popular in JIT compilers because it compiles quickly and generates reasonable code.
-   [Linear Scan Register Allocation on SSA Form. Christian Wimmer Michael Franz.] (https://c9x.me/compile/bib/Wimmer10a.pdf)An adaptation of the classic and fast linear scan algorithm to work on SSA form. It presents the challenges posed by SSA form pretty well.
-   [Iterated Register Coalescing. Lal George and Andrew W. Appel.] (https://c9x.me/compile/bib/irc.pdf)A classic paper for register allocation using graph coloring. It is usually said to be slow and not used in JIT compilers. It is also not often used in big compilers because not flexible enough (see below for a fix).
-   [A Generalized Algorithm for Graph-Coloring Register Allocation. Michael D. Smith, Norman Ramsey, and Glenn Holloway.] (https://c9x.me/compile/bib/pcc-rega.pdf)Graph-coloring as presented in textbooks is not suited to real computers. This paper presents various extensions to handle register classes and aliases. It is the algorithm used in PCC.

### Code Generation

-   [Engineering a Simple, Efficient Code Generator Generator. Christopher W. Fraser, David R. Hanson, and Todd A. Proebsting.] (https://c9x.me/compile/bib/iburg.pdf)This paper presents iburg, a flexible code generator generator that generates compact and simple code. It is used in the retargetable C compiler lcc.

### Machine Specific

-  [ What Every Computer Scientist Should Know About Floating Point Arithmetic. David Glodberg.](https://c9x.me/compile/bib/floating-point.pdf)
-  [ System V Application Binary Interface (AMD64).](https://c9x.me/compile/bib/abi-x64.pdf)(Almost) Everything you need to know to interface with C code on x64 platforms running a UNIX OS.
-   [Procedure Call Standard for the ARM 64-bit Architecture.](https://c9x.me/compile/bib/abi-arm64.pdf)The ABI for AARCH64, saner and better explained than the x64 one.
-   [Short X86 Instruction Set Reference.](https://c9x.me/x86/)