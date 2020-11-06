# Unix

* 历史起始于二十世纪六十年代的AT&T贝尔实验室，一小组程序员正在为PDP-7编写多任务、多用户操作系统。在贝尔实验室研究机构的这个小组里有两位最知名的人物，ken Thompson和Dennis Ritchie
* 尽管Unix的许多概念继承于它的先驱Multics，但在二十世纪八十代早期Unix小组用C语言重写这个小型操作系统的决定使得Unix与其它的系统区别开来。只有几百个系统调用，秉承一切皆文件的设计思想。那个时候的操作系统很少是可移植的。相反，由于先天的设计和底层源语言，那些操作系统和所被授权运行的硬件平台紧密地联系在一起。通过使用C语言重构Unix，现在Unix可以被移植到许多硬件平台
* 除了这个新的可移植移能力，有几个对于用户和程序员来说很有吸引力的操作系统设计的关键点使得Unix扩张到除贝尔实验室以外的其它领域，如研究、学术甚至商业用途
* 关键点一，Ken Thompson的Unix哲学成为了模块化软件设计和计算的强有力的典范
* Unix哲学建议使用小规模的为特定目的构建的程序的结合体来处理复杂的总体任务。由于Unix是围绕着文件和管道设计的，这个"piping（管道)“模型至今仍然很流行，把程序的输入和输出链接在一起作为一系列的线性输入操作。实际上，当今的函数即服务（FaaS）/无服务器计算模型要更多地归功于对Unix哲学的继承
* 在20世纪70和80年代末，Unix成为了族谱的根，族谱扩展到研究届、学术届和不断增长的商业Unix操作系统业务。Unix不是开源软件，Unix源码可以与它的拥有者AT&T通过协议获得许可证。第一个已知的软件许可证在1975年卖给了伊利诺伊大学
* Unix在学术界发展迅速，随着伯克利成为重要的活动中心，在70年代给了Ken Thompson一个学术休假。通过在伯克利的Unix的所有活动，一个新的Unix软件支付诞生了：伯克利软件发行版，或者叫BSD。最初，BSD并不是AT&T的Unix的代替品，而是附加软件和功能附加品。直到1979年的2BSD（第二Berkeley软件发型版）,伯克利研究生Bill Joy已经添加了现在知名的程序，例如vi和C shell（/bin/csh）
* 除了BSD成为了Unix家族中最受欢迎的分支之一，Unix的商业产品在20世纪80年代和90年代激增，包括HP-UX、IBM的AIX、Sun的Solaris、Sequent和Xenix。随着分支从最初的根开始增长，“Unix战争”开始了，标准化成为了社区的一个新焦点。POSIX标准诞生于1988年，以及其他开源工作组的标准化工作一直进行到到20世纪90年代
* BSD可能是当今所有现代Unix系统中最大的安装基础。此外，在最近的历史中，每一个苹果Mac硬件单元搭载的系统都可以被称为BSD，因为它的OS X（现在的macOS）操作系统是一个BSD-派生
* Unix的BSD分支是开源的，而NetBSD、OpenBSD和FreeBSD都有强大的用户群和开源社区

## 哲学

* 小即是美
* 让程序只做好一件事
* 尽可能早地建立原型
* 可移植性比效率更重要
* 数据应该保存为文本文件
* 尽可能地榨取软件的全部价值
* 使用shell脚本来提高效率和可移植性
* 避免使用可定制性低下的用户界面
* 所有程序都是数据的过滤器

## IO模型

* Blocking IO - 阻塞IO
* NoneBlocking IO - 非阻塞IO
* IO multiplexing - IO多路复用
* signal driven IO - 信号驱动IO
* asynchronous IO - 异步IO

## HOC High Order Calculator

* 组件
    - 词法分析器lex
    - 语法分析器yacc
    - 标准数学库stdlib

## 系统

* [XINU](https://xinu.cs.purdue.edu/)

## 教程

* [UNIX Tutorial for Beginners](http://www.ee.surrey.ac.uk/Teaching/Unix/) – 来自The University of Surrey的新手指南，告诉你Unix系统最基本的特性
* [UNIX Training Manual](https://alvinalexander.com/unix/unix-dnld.shtml) – 这是一个 88页 的培训手册，主要用一些示例来教一个Unix文件系统的相关的命令。严格说来，这并不是一个教程，但也很有用
* [Learn UNIX Tutorial](http://www.softlookup.com/tutorial/Unix/index.asp) – Soft Lookup 的一个全面的 UNIX 教程，完全可以让你从一个新手变成一个高手
* [UNIX](http://heather.cs.ucdavis.edu/~matloff/UnixAndC/Unix/UnixBareMn.pdf) – The Bare Minimum – 来自 UC Davis 教授，提供了一个简单的UNIX介绍
* [Learning About UNIX](https://faraday.physics.utoronto.ca/GeneralInterest/Harrison/LearnLinux/) – 来自University of Toronto，提供了一些UNIX 和Linux 课程笔记。这个课程关注于UNIX 和Linux 工具
* [UNIX for Advanced Users]() – Indiana University的 UNIX Workstation Support Group 提供的一个相当不错的面对UNIX 高级用户的教程。
* [Kevin Heard’s UNIX Tutorial](https://people.ischool.berkeley.edu/~kevin/unix-tutorial/) – Kevin Heard (UC Berkeley) 的一个相当相当不错的三部教程，从Unix的基础开始，以高级话题结束
* [Advanced Bash Scripting Guide](http://tldp.org/LDP/abs/html/) – 来自于Linux Document Project 的教程，一个shell编程由浅入深的教程
* [UNIX Shell Scripting Advanced](https://www.vtc.com/products/Unix-Shell-Scripting-Advanced-tutorials.htm) – VTC 有一组视频的 UNIX 的教程。而这一个是指导高级用户如何进行脚本编程
* [Advanced C Shell Programming](http://heather.cs.ucdavis.edu/~matloff/UnixAndC/Unix/CShellII.pdf) – 这是UC Davis 的教程，主要教使用如何使用C shell 和tcsh 进行脚本编程

## 图书

* 《[UNIX网络编程 卷1：套接字联网API（第3版）](https://www.amazon.cn/gp/product/B011S72JB6)》
* 《[UNIX网络编程 卷2：进程间通信](https://www.amazon.cn/gp/product/B012R5A29O)》
* 《[UNIX编程环境](https://www.amazon.cn/gp/product/B00IYTQBYS/)》
* 《[Unix 环境高级编程(第3版)](https://www.amazon.cn/gp/product/B00KMR129E)》
    - [huaxz1986/APUE_notes](https://github.com/huaxz1986/APUE_notes):《UNIX环境高级编程》中文第三版笔记
* 《UNIX操作系统设计》
* 《[UNIX编程艺术](https://www.amazon.cn/gp/product/B008Z1IEQ8)》

## 参考

* [6.S081 Operating System Engineering](https://pdos.csail.mit.edu/6.828/2019/xv6.html)
  - [mit-pdos / xv6-public](https://github.com/mit-pdos/xv6-public):xv6 OS http://pdos.csail.mit.edu/6.828/
  - [ranxian / xv6-chinese ](https://github.com/ranxian/xv6-chinese):中文版的 MIT xv6 文档
