# Code 编程


## 编程语言

* 计算机（Computer）:在计算机的层次上，CPU执行的是加减乘除的指令代码，以及各种条件判断和跳转指令
* 计算（Compute）:指数学意义上的计算，越是抽象的计算，离计算机硬件越远
* 掌握两门以上编程语言（强类型+弱类型)
* [unison](https://github.com/unisonweb/unison):Next generation programming language, currently in development <http://unisonweb.org>
* [taichi](https://github.com/taichi-dev/taichi):The Taichi programming language <http://taichi.graphics>
* [ChezScheme](https://github.com/cisco/ChezScheme) Chez Scheme is both a programming language and an implementation of that language, with supporting tools and documentation.
* [crystal](https://github.com/crystal-lang/crystal) The Crystal Programming Language <https://crystal-lang.org>
* [julia](https://github.com/JuliaLang/julia) The Julia Language: A fresh approach to technical computing. <https://julialang.org/>
* [skip](https://github.com/skiplang/skip):A programming language to skip the things you have already computed <http://www.skiplang.com>
* [v](https://github.com/vlang/v) Simple, fast, safe, compiled language for developing maintainable software. Compiles itself in <1s with zero library dependencies. <https://vlang.io>
* [ProgrammingLanguage-Series](<https://github.com/wx-chevalier/ProgrammingLanguage-Series>📚 编程语言语法基础与工程实践，JavaScript | Java | Python | Go | Rust | CPP | Swift)
* [Learn X in Y minutes](https://learnxinyminutes.com/)

### 发展

* 机器语音
* 汇编语言
* 结构化编程：自顶向下，逐步求精
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
* Compiled vs Interpreted
  - Compiling a C program would produce what we also know as machine code. As opposed to bytecode.
  - Generally, when we run a python program, a python VM process is started which reads the python source code, compiles it to byte code and run it in a single step. Compiling is not a separate step. Shown only for illustration purpose.
  - Binaries generated for C like languages are not exactly run as is. Since there are multiple types of binaries (eg: ELF), there are more complicated steps involved in order to run a binary but we will not go into that since all that is done at OS level.

* 对应到编程语言，就是越低级语言，越贴近计算机，抽象程度低，执行效率高，比如C语言；越高级的语言，越贴近计算，抽象程度高，执行效率低，比如Lisp语言。
  - 静态语言 statically typed language:在编译期间就能够知道数据类型的语言，在运行前就能够检查类型的正确性，一旦类型确定后就不能再更改
    + the compiler is written in a way that it can verify types related errors during compile time
  - 动态语言|脚本语言 dynamic language
    + 没有任何特定的情况需要指定变量的类型，在运行时确定的数据类型.因其易于编写和易于运行的特性，被预测在未来将发展强大
    + types are not known until a program is run. So in a way, python compiler is dumb (or, less strict)
    + 脚本语言”（script language），指不具备开发操作系统的能力，而是只用来编写控制其他大型应用程序（比如浏览器）的“脚本”
    +  dynamically typed language, that means all types are determined at runtime. And that makes python run very slow compared to other statically typed languages.
  - C语言是可以用来编写操作系统的贴近硬件的语言，所以，C语言适合开发那些追求运行速度、充分发挥硬件性能的程序。而Python是用来编写应用程序的高级编程语言
  - 高级编程语言通常都会提供一个比较完善的基础代码库，能直接调用

```sh
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


### 原理

* [硬件内存模型](https://research.swtch.com/hwmm)
* [编程语言内存模型 ](https://colobu.com/2021/07/11/Programming-Language-Memory-Models/)

### 内容

* 了解编程语言的语法特征
  - 数据类型
  - 运算符
  - 控制语句
  - 编程模式
* 掌握编译或解释的过程，及编译器/解释器性能，调试方法、工具
* 配合算法，实现业务逻辑
* 函数：把长长的代码封装起来，这样就写一次，就可以到处调用了
* 程序 = 数据结构+算法：把参数组织起来，以后就传递这个数据结构
* oop

#### 闭包

* 变量的值始终保持在内存中

## 知识

* 概念的理解与场景的确定

### 方向

* 深度与复杂性：算法
* 结构性：设计模式

### 结构

要了解技术就一定需要了解整个计算机的技术历史发展和进化路线。因为，你要朝着球运动的轨迹去，而不是朝着球的位置去，要知道球的运动轨迹，你就需要知道它历史上是怎么跑的。

* 横向的知识架构
* 纵向深化
* 源码的分析
* 知识不断进行生态进化

### 态度

* 新技术态度:要了解技术就一定需要了解整个计算机的技术历史发展和进化路线,要朝着球运动的轨迹去，而不是朝着球的位置去，要知道球的运动轨迹，你就需要知道它历史上是怎么跑的。
  - 70年代Unix的出现，是软件发展方面的一个里程碑，那个时期的C语言，也是语言方面的里程碑。（当时）所有的项目都在Unix/C上，全世界人都在用这两样东西写软件。Linux跟随的是Unix, Windows下的开发也是 C/C++
  - C++虽然接过了C的接力棒，但是它的问题是它没有一个企业方面的架构，而且太随意了
  - Java被发明后，被IBM把企业架构这部分的需求接了过来，J2EE的出现让C/C++捉襟见肘了，在语言进化上，还有Python/Ruby，后面还有了.NET，但可惜的是这只局限在Windows平台上。这些就是企业级软件方面语言层面就是C -> C++ -> Java这条主干，操作系统是Unix -> Linux/Windows这条主干
  - 网络知识就是Ethernet -> IP -> TCP/UDP 这条主干
  - 互联网方面的（HTML/CSS/JS/LAMP…）
  - 架构
    + 从单机的年代，到C/S架构（界面，业务逻辑，数据SQL都在Client上，只有数据库服库在S上）
    + 到B/S结构（用浏览器来充当Client，但是传统的ASP/PHP/JSP/Perl/CGI这样的编程也都把界面，业务逻辑，和SQL都放在一起），但是B/S已经把这些东西放到了Web Server上
    + 后来的中间件，把业务逻辑再抽出一层，放到一个叫App Server上，经典的三层结构
    + 再到分布式结构，业务层分布式，数据层分布式
    + 今天的云架构——全部移到服务器
    + 一直再把东西往后端移，前端只剩一个浏览器或是一个手机。通过这个你可以看到整个技术发展的趋势。所以，如果你了解了这些变迁，了解了这些变迁过程“不断填坑”的过程，你将会对技术有很强的把握
  - 技术的发展要根植于历史，而不是未来。技术都是承前的，只有承前的才会常青
  - 要去了解整个计算机文化，源起于Unix/C这条线上
* 教育领域计算机科学的侧重
  - 应该至少要知道这些演变和进化的过程。而如果你要解决一些业务和技术难题，就需要抓住某种技术很深入地学习，当成艺术一样来学习
  - 业务性能:技术的基础就很管用了，比如：操作系统的文件管理，进程调度，内存管理，网络的七层模型，TCP/UCPUDP的协议，语言用法、编译和类库的实现，数据结构，算法等等就非常关键了
  - 业务智能:发现很多东西都很学院派了，比如，搜索算法，推荐算法，预测，统计，机器学习，图像识别，分布式架构和算法，等等，你需要读很多计算机学院派的论文
  - 真正的高手把那些理论的基础知识应用到现在的业务上来
* 编程不在于用什么语言去coding，而是你组织程序、设计软件的能力，只要你上升到脑力劳动上来，用什么都一样，技术无贵贱。

## 方法

* 不要只是简单的、被动的使用正在使用的资源，要及时进行练习和家庭作业，实践是学习编码绝对必要的部分。
* 避免在编程语言之间来回切换；选择一门语言并坚持下去。这是因为编程最终与解决问题有关，而不是与编程语言有关。学会解决问题是具有挑战性的，并且是只有通过练习才能磨练的技能。每次切换语言时，你都在浪费时间，可以花时间练习运用所学的知识来提高解决问题的能力。
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
* 资源获取途径
  - 图书，学习任何一项技能前，看书都是一种最有效的途径

* 缓存
* 预处理和延后处理
* 池化
  - 内存池难点:
    + 如何快速分配内存
    + 降低内存碎片率
    + 维护内存池所需的额外空间尽量少
  - 线程池
    + 管理器（Manager）: 用于创建并管理线程池。
    + 工作线程（Worker）: 执行任务的线程。
    + 任务接口（Task）: 每个具体的任务必须实现任务接口，工作线程将调用该接口来完成具体的任务。
    + 任务队列（TaskQueue）: 存放还未执行的任务。
* 同步变异步
* 消息队列
* 批量处理

## 实践

* 把大块需求拆解成小块任务
* 把小块的任务实现成代码
* 程序员的基本功:做得又好又快
* 核心:通过各种各样的算法去实现具体的业务逻辑，把繁杂的过程抽象化、可计算化。从纯粹软件的角度讲，甚至可以说：算法 + 数据 == 计算机程序
* 学习编程最大的悲剧:就是明明自己的目的是模仿逐步形成自己的技能，而误以为自己要去创造新事物。所以学习编程之前需要搞懂
  - 做创造性的工作；还是做模仿性的工作。模仿类型的工作时不需要从理论开始的，而是从练习开始的。一开始就模仿写代码
* 理论与实践：不去实际写代码有些问题是发现不了的,学了几年的游泳理论还是不会游泳的。实践中需要注意的东西，不动手是学习不到的
* 程序员工作本质其实是对事物或者问题进行抽象，只有抽象后才能进行深度思考，才能建模，建好模型后，才能用编程语言写成程序。一旦抽象久了，就很难了解事情的真相，不能一直处在一个虚拟的环境里，需要对事物进行还原，需要走到真实的环境中与人接触，到真实的场景中去讨论需求，去做软件定价，销售等，这些工作比我们想象中的要复杂

### 硅谷

* 如何做好 Code Review
  - 在软件开发的过程中，对源代码进行同级评审，其目的是找出并修正软件开发过程中出现的错误，保证软件质量，提高开发者自身水平。
  - 发现国内公司做代码评审的比例并不算高，这可能和各公司的工程师文化有关系
  - 不过硅谷稍具规模的公司，代码评审的流程都是比较规范的，模式也差不多
* 开发流程
  - OKR 的设立
  - 主项目及其子项目的确立
  - 每个子项目的生命周期
  - 主项目的生命周期
  - 收尾、维护、复盘。
* 从 1 到 N 都需要进行的业务拆分，需要综合考虑各种因素，找到平衡点
  - 你的业务量是否足够大，逻辑是否足够复杂以至于必须进行系统拆分。水平扩展是不是已经不起作用了？代码的相互影响、部署时间过长真的是系统的切肤之痛么？如果答案都是肯定的，那么你就应该进行系统拆分了。
  - 对于服务化的架构，你的开发人员多少经验，能否正确驾驭而不是让本文中提到的问题成为拦路虎么？
  - 系统拆分是一个“从一到多容易，从多到一困难”的过程，这个过程几乎是不可逆的。在做拆分计划的时候，一定要慎之又慎。
* 要有 7 至 8 轮面试，招人需谨慎，要对面试者和公司负责
  - 算法编程：考察编程的硬功夫
  - 系统设计：给候选人一个系统设计的场景，根据自己的能力和经验去架构整个系统
  - 工作经验面试：与候选人聊他做过的项目，深入了解和挖掘候选人的技能树

![code review流程](../_static/code_review_flow.jpg "Optional title")
![开发流程](../_static/dev_flow.jpg "Optional title")
## 高质量代码

* 特点
  - 可读性高
  - 结构清晰
  - 可扩展（方便维护）
  - 代码风格统一
  - 低复杂性
  - 简练
* 遵循
  - 代码规范
    + 好处
      * 促进团队合作
      * 降低维护成本
      * 有助于代码审查
      * 养成代码规范习惯，有助于程序员自身的成长
      * 能够认识到规范的重要性，并坚持规范的开发习惯
    + 前端代码规范推荐
      * 百度前端代码规范
      * feross/standard · GitHub
      * Airbnb JavaScript Style Guide
  - 提前设计
    + 阅读文档，分析需求
    + 画原型图或草图（方便理解整体架构）
    + 写大纲或伪代码（如果项目比较大还要细分模块）
    + 实现细节
  - 重构：在不改变软件系统外部行为的前提下，改善它的内部结构
    + 可以使软件更容易地被修改和被理解。通过不断地改进软件设计以达到简单设计的目标，减少由于设计与业务的不匹配带来的架构与设计腐化
    + 重构能改善软件设计
    + 重构使软件更易理解
    + 重构有助于找到Bug
    + 重构有助于提高自我编程能力
    + 重构有助于加深理解代码
    + 重构能适应需求变更
  - 代码要求
    + 不要编写大段代码
    + 重复代码封装成函数
    + 在编写代码的过程中养成不断重构的习惯
    + 添加必要的注释
    + 留下可扩展的空间
  - 测试：目的都是为了找出尽可能多的BUG，保证产品的质量
    + 测试的过程本身就是一个自我 code review 的过程，在这个过程中，可以发现一些设计上的问题(比如代码设计的不可测试)，代码编写方面的问题(比如一些边界条件的处理不当)等，做到及时发现及时修正，不需要等到测试阶段甚至上线之后再发现再修改
  - 自我要求
    + 先从代码规范开始，熟悉代码规范，遵循规范写代码，直到成为习惯
* 三要素
  - 可读性强：
    + 不要编写大段代码
    + 将段落封装成一个又一个函数
    + 在编写代码的工程中养成不断重构的习惯
    + 函数设计遵循的原则：职责驱动设计
    + 从上往下的编写：每个被分出去的程序，可以暂时只写一个空程序而不去具体实现功能，当主程序完成以后，再一个个实它的所有子程序。
    + 当一个函数的代码行数达到15-20行，开始考虑是否需要重构代码。
    + 一个类不应当有太多的函数，函数过多要考虑分为多个类，一个包也不应该有太多的类
    + 释义名称：new/add , edit/mod , del , find/query
    + 释义名称：get开头的函数仅仅用于获取类属性
    + 注释：职责驱动设计，首先描述该类的职责
    + 注释：编写的是一个借口 or抽象类，在@author后添加@see，将该接口的抽象类的所有实现类列出来
  - 可维护性：适应软件在部署和使用中的各种情况
    + 代码不能写死（路径为相对路径 or 通过属性文件修改 ）
    + 预测可能发生的变化
    + 将某些条件设置为可配置的，需要必要的注释
  - 可变更性：因需求变化而对代码进行修改
    + 提高代码的可复用性
    + 对模型进行分析，用例模型，领域模型，分析模型，正向工程，逆向工程
    + 利用设计模式提高可变更性：经典的32个模式
      * if...else : （重构一下，保证不修改原有代码，仅仅增加新的代码就能应付选项的增加）:写成父类方法
      * 选项较多，并且增加选项的可能性很大的情况下可以使用工厂模式
      * 策略模式：解决继承出现的问题，减少类的继承，在类中增加某些方法的策略来代替继承，可以无限制的增加策略
      * 适配器模式：设计的系统要与其他系统/模块交互，可能调用接口或交换数据。我方的接口按照某个协议编写，保持固定不变，在于真正对方接口时，在前段设计一个适配器类，对方协议变更，可以更换适配器。（启发：类似于rank中的service层，传的参数也同样尽量不要限制，而是传递数组）（通过适配器接受数据or传输数据）
      * 模板模式：通常有一个抽象类，在抽象类中有一个主函数，按顺序调用其他函数（启发：类似于JdbController extends Controller），比较个性的步骤由其继承类完成。父类的主函数应当是final，其中的函数可以是可选步骤，称为【hood】，在编写时，抽象类中并不是抽象函数，而是一个空函数，继承类可以重载，也可以什么也不写，为空执行。
    + 职责驱动设计（RDD） & 领域驱动设计（DDD）
    + 根据职责分配行为和函数
    + 根据需求进行用例分析，根据用例绘制领域模型和分析模型
    + 《UML和模式应用》：RDD以职责为中心分配行为，软件对象与现实世界尽量保持一致（低表示差异）
    + 《领域驱动设计》：领域模型，需求分析阶段建立领域模型
* 代码质量评价：低耦合，高内聚（功能，元素除了职责任务，没有其他工作）
* 其他概念：
  - 高内聚低耦合
  - 领域模型
  - 工厂模式 based on 多态
  - 用例模型

## 优秀

* 优秀程序员的价值，不在于其所掌握的几招屠龙之术，而是在细节中见真著。
* 如果我们可以一次把事情做对，并且做好，在允许的范围内尽可能追求卓越
* 规避问题和逃避问题的趋向，是人类心理疾病的根源。

* 没有书本会教解决以前没人碰到过的问题。成年人可以直接去学习编码，孩子们则需要发掘他们的好奇心
* 经验
  - 代码能够工作
  - 使代码清晰、可重用和整洁
  - 艺术家的敏感融入抽象逻辑中，相信代码的美感对编程来说，和所有的算法或编码模式一样重要。
  - 在过程中你教教他们如何把事情做好，你让他们知道这世界充满了有趣的事情等待他们去发现，向他们展示如何充满激情地在他们所做的每件事中寻找那种瞬间的质量感
* 由于开发程序变得容易了，一个人可以在知道很少的情况下完成小型程序。但这也意味着，这个人可能永远也不会写大程序。这个行业里面，只要学会5％的东西，可以完成简单的工作，就可以谋生了。
* 想做一个什么样的程序员，完全取决于你真正想做的事情。如果您想制作网站，那么你不需要计算机科学学位。甚至不需要学位。如果你想制作一些前所未有的令人兴奋的精彩内容，如果你想在行业中做出微小的改变并稍微改变世界，那么你确实需要那个学位。
* 或者换一种方式看待它：如果想建造狗屋，只需用锤子和钉子。如果想成为一名设计和建造摩天大楼的建筑师，那么首先要获得建筑学位。但请不要明明在建造狗屋，却称呼自己为建筑师

* 一名优秀的开发者，只要对一门语言很硬核地掌握了，对各种基本概念知其然，也知其所以然，那么，学任何其他语言都会比较轻松。因为组成语言的要素是相同的，可以相互印证，融会贯通。比如传值和传引用是怎么运作的，数据分配在栈上和堆上都有什么不同，为什么有些东西要分配在栈上，有些只能分配在堆上，这些东西在一门语言身上学通了，另一门语言也是一样。
* 有更快的开发效率、更好的程序设计、更好的代码质量、更善于 debug、更能够解决技术难题.
* 小撮开发人员的贡献总和可能与另外那一大撮人（大于总人数的80%）的贡献总和不相上下（甚至可能超过）
* 做正确的事
	* 不好习惯
		* 先做自己喜欢的事情，再做自己不喜欢的事情  
		* 先做紧急的事情，再做不紧急的事情  
		* 先做容易做的事情，再做不容易做的事情  
		* 先做自己了解、熟悉的事情，再做自己不了解、不熟悉的事情  
		* 先做有趣的事情，再做枯燥的事情  
		* 先做易于告一段落的事情，再做不易于告一段落的事情  
		* 先做自己熟悉的人托付的事情，再做自己不熟悉的人托付的事情
	* 评估权重：时会很容易被琐事纠缠，白白浪费不少时间，每天忙完了都不清楚忙些啥。评估你准备做的每件事情的【权重】。权重来源于这件事情对于达成目标是否有帮助？帮助有多大？
	* 严格按照权重执行：工作中偶尔碰上看起来紧急的突发事情，也【不要】轻易改变原先安排的计划表，而要先冷静评估一下这个紧急的事情的权重。只有属于紧急且权重高（重要）的突发事件，你才可以调整计划，把这件突发事情加入其中。
* 正确地做事-善用工具
	* 盲打过关
	* 字体的选择是非常重要的（看起来舒服的字体起码能保护眼睛）。首先必须选择一种【等宽】的字体（比如 FixedSys、Courier New）；其次该字体必须能够【清楚地区分】几种容易混淆的字符，避免阅读代码的时候看错
	* 对词法高亮进行设置时，至少要把：“代码注释、关键字、字符串、数字”这几种语法要素用不同的颜色区分开。当然，如果还能根据“类名、函数名、变量名等”进行着色，那就更好
	* 熟练地使用快捷键
	* 源代码管理工具：在编写功能代码时，每完成一个功能点，并且自己经过了自测之后，提交一次；在调试的时候，每修复一个 bug，提交一次。这样能够保证提交到 RCS 的代码都是【能编译通过的，并且业务逻辑上也是相对完整的（对于每日构建后的测试很重要）
	* 提交时不写注释
	* 不做代码基线（Baseline）、不做代码分支（Branch）
		* 当有一个版本发布（Release）并交付给用户使用时，都需要在 RCS 中制作一个基线，以便于进行相应的 bug 跟踪和补丁制作。因此，诸如【做基线】之类的事情，属于整个团队的集体行为，需要由 Team Leader 牵头来搞
	* 自己的开发机器上要有尽可能仿真（和用户的环境相似）的运行环境，并且运行辅助工具能够有效地发现运行时的一些不正常的信息
* 正确地做事-善用自动化
	*  Perl 语言的创始人Larry Wall曾经评价过程序员的三大美德
		- 懒惰:干尽量少的活，但是依然保质保量地完成工作.自动完成
			- 观察平时做的事情中，有哪些属于重复劳动；然后评估一下这些重复劳动是否可以用某些工具来替代；如果有可能替代，就可以动手把这个工具实现出来，然后就可以让工具来帮你做事情了
			- 使用 Feed（RSS） 订阅工具Blog
			- 通过程序断言来调试程序，有70%-80%的逻辑错误会被 assert 暴露出来
			- 自动化测试:尽量多使用一些自动化测试工具（比如 [QTP](https://en.wikipedia.org/wiki/HP_QuickTest_Professional)）和一些测试脚本来完成上述的软件功能验证操作。不光能节约很多时间，提高了效率；而且在自己编写测试脚本的过程中，或许还能学些新东西，提高一下个人能力
		- 急躁
		- 傲慢

## 习惯

* 花10，000小时练习编码
* 不断构建项目（代码，代码，代码）
* 阅读有关技术和产品的书籍
* 在压力和截止日期前能够准确交付
* 透彻阅读其他人的代码
* 选择新语言（每年一种新语言规则）和技术（一旦发布就拿起新东西）
* 结对编程，与不同类型的人合作
* 编写高质量的代码，即具有国际标准的工程级代码
* 积极参与开源项目
* 想清楚，再动手写代码
* 不交流，就会头破血流：需求理解清楚
* 文档没人看，但还是要写：用来做记录
* 一定要写注释
* 别指望需求会稳定
* 业务高于技术
* 不要心存侥幸：你隐约感觉会出bug的地方，就一定会出bug。
* 自己先测几遍
* 尽可能自己解决问题
* 专注技术栈，莫多尔不精
* 打印日志
* 不断重构反思
* 依然觉得写代码很快乐
* 远离一会儿，有助于找出盲点
* 使用一个新语言，编写另外一个语言的解析器

## 建议

* 开发过程
  - 代码不仅仅是用来运行的。代码也是跨团队交流的一种方式，是向他人描述问题解决方案的一种方式。良好的代码可读性不是那么容易做到的，但它是编写代码最基础的部分之一。良好的代码可读性包括清晰地分解代码，选择恰当的自解释变量名，添加注释来描述所有隐含的内容。
  - 不要渴望你的 pull request 能为你赢得多少名声，而要多关注你的 pull request 能为你的用户和社区做些什么。要不惜一切代价避免“功利性的贡献”。如果你提交的功能对于这个产品想要达到的目的没有明显的帮助，就不要添加任何功能。
  - 品味也适用于代码。品味是一种受约束的满足过程，这种满足是由对简单的渴望所约束的。保持对简单性的偏爱。
  - 要学会说“不”——仅仅因为有人要求做某个特性，并不意味着你就应该这么做。每个特性都有一个超出初始实现的成本：维护成本、文档成本和用户的认知成本。我们要时刻提醒自己：我们真的应该这样做吗? 通常，答案是否定的。
  - 当你准备答应实现一个新的使用场景时，请记住，仅从字面意思理解实现用户的需求通常不是最佳选择。用户关注的仅仅是他们自己的特定使用场景，你必须从整个项目的角度出发，兼顾整体性和原则性。通常，正确的做法是在现有特性的基础上做扩展。
  - 不断进行持续集成，并以完整的单元测试覆盖为目标。确保你处在一个可以自信地编写代码的环境中；如果不是这样，那么你需要从构建正确的基础设施开始。
  - 可以不事先计划好一切。先试一下，看看结果如何。尽早对错误的选择进行回退。当然，前提是确保你的开发环境可以做到这一点。
  - 好的软件使困难的事情变得简单。问题一开始看起来很困难，并不意味着解决方案必须很复杂或者很难操作。在很多情况下，工程师给出的解决方案都是未经思考的，这就可能在有更简单的解决方案（虽然可能不那么明显）的情况下，带来不必要的复杂性（我们可以使用 ML！我们可以尝试构建一个应用程序！我们可以使用区块链！）。在编写任何代码之前，请确保你所选择的解决方案已经简单到不能再简单。做任何事情都要有本源思维。
  - 避免隐式规则。应该明确说明你自己开发的隐式规则，并与他人共享。当你发现自己提出了一个重复的、准算法的工作流时，你应该设法将它标准化到一个文档中，以便其他团队成员能够从此经验中获益。此外，你应该在软件中尝试自动化任何可以自动化的工作流 (例如，正确性检查)。
  - 在设计过程中应该考虑你选择方案的总体影响，而不仅仅是你希望关注的那些方面——比如收入或增长。除了你正在监控的那些指标之外，你的软件对其用户、对整个世界还会带来哪些影响? 是否存在超过价值主张的不良副作用? 在保持软件可用性的同时，你能做些什么来解决这些问题呢?
  - **设计伦理，把你的价值观融入你的作品中**
* API 设计
  - API 是有用户的，因此它事关用户体验。在你做的每一个决定中，都要考虑到用户。要站在用户的角度思考问题，无论他们是初学者还是有经验的开发人员。
  - 总是想着让你的用户在使用 API 的过程中尽量减少认知负荷。自动化可以自动化的东西，最小化用户需要做的操作和选择，不显示不重要的选项，设计简单一致的工作流，反映简单一致的思维模型。
  - 简单的事情要简单处理，复杂的事情应该尽量简单化。不要为了少量特殊的使用场景而增加普通使用场景的认知负荷，即使是最低限度的
  - 如果工作流的认知负荷足够低，那么用户在使用一到两次之后，应该可以凭记忆完成工作了 (无需查找教程或文档)。
  - 寻求与领域专家和实践者的心智模型相匹配的 API。有领域经验但没有 API 经验的人应该能够使用最少的文档直观地理解你的 API，主要是通过查看一些代码示例，看看哪些对象可用，以及它们的特征是什么。
  - 一个参数的含义应该是容易理解的，而不需要任何关于底层实现的上下文。必须由用户指定的参数应该与用户关于问题的心理模型相关，而不是与代码中的实现细节相关。API 只与它所要解决的问题有关，与软件在后台如何工作无关。
  - 最强大的心智模型是模块化和层次化的：在高层次上很简单，但在细节上很精确。同样地，一个好的 API 也应该是模块化和层次化的：易于使用，但具有表现力。在更少的对象上有复杂的特性和具有更简单特性的对象之间有一个平衡。一个好的 API 要有合理数量的对象，并具有相当简单的特性
  - 你的 API 不可避免地反映了你选择的实现方式，特别是你选择的数据结构。要实现直观的API，你必须选择自然适合其领域的数据结构——与领域专家的心智模型相匹配。
  - 有意识地设计端到端工作流，而不是一组原子特性。大多数开发人员在设计 API 时都会问：我们应该提供哪些功能?让我们为这些功能提供配置选项吧。恰恰相反，开发人员应该这样问：这个工具有哪些使用场景?对于每个使用场景，用户操作的最佳顺序是什么? 支持这个工作流的最简单的API是什么?你的API中的原子选项应该能够满足在高级工作流中出现的明显需求——不要“因为有人可能需要它”而添加某个功能。
  - 错误消息，以及在与 API 交互过程中向用户提供的任何反馈，都是API的一部分。交互性和反馈是用户体验的一部分。需要谨慎的设计 API 的错误消息。
  - 因为代码是一种交流方式，所以命名很重要——无论是命名项目还是变量。名字反映了你对问题的看法。避免使用过于通用的名称（ x, variable, parameter），避免使用过于冗长和特定的命名模式，避免使用可能造成不必要误解的术语 (主、从)，并确保你的命名选择方式是一致的。命名一致性意味着内部命名一致性 (不要在其他地方将“dim”称为“axis”) 和与问题域的既定约定的一致性。在确定名称之前，请确保查找领域专家 (或其他 API) 使用的现有名称。
  - 文档是影响 API 用户体验的关键。它不是一个附加产品。着力产出高质量的文档，你将看到比开发更多功能带来的更高回报。
  - Show, don 't tell：你的文档不应该讨论软件是如何工作的，它应该展示如何使用这个软件。显示端到端工作流的代码示例；为 API 的每个常见使用场景和关键特性展示代码示例。
  - **生产力可以归结为快速决策和偏好行动**
* 职业生涯
  - 事业的进步不在于管理了多少人，而在于产生了多大的影响：一个有你的工作的世界和一个没有你的工作的世界之间的差别。
  - 软件开发是团队合作 ; 它不仅关乎技术能力，也关乎人际关系。做一个好队友。当你开始做事情的时候，要和别人保持沟通。
  - 技术从来都不是中立的。如果你的工作可能对世界产生任何影响，那么这种影响是有道德导向的。我们在软件产品中做出的看似无害的技术选择有可能会影响获得技术的条件、使用动机、谁将受益、谁将受害。技术选择也是伦理选择。因此，对于你希望自己的选择支持的价值，一定要慎重和明确。基于道德准则来做设计，把你的价值观融入你的作品中。永远不要想，我只是在开发一种能力，这个能力本身是中性的。并不是因为你的开发方式决定了它将如何被使用。
  - 自我指导——掌控你的工作和环境——是获得生活满足感的关键。确保你给你周围的人足够的自我导向，确保你的职业选择为你自己带来更大的回报
  - 创造世界所需要的，而不仅仅是你希望拥有的。技术人员往往过着精细化的生活，专注于满足自己特定需求的产品。寻找机会拓宽你的生活经验，这将使你更好地看到世界需要什么
  - 当做出任何具有长期影响的选择时，将你的价值观置于短期的自我利益和短暂的情绪之上——比如贪婪或恐惧。知道你的价值观是什么，让它们来引导你。
  - 当发现自己陷入矛盾中时，应该停下来寻找我们共同的价值观和共同的目标，并提醒自己，我们几乎肯定站在同一条战线上。
  - 生产力可以归结为快速决策和偏好行动。这需要 a) 来自经验的良好直觉，以便在给出部分信息的情况下做出普遍正确的决定 ; b)对何时要小心地前进或等待更多信息要有敏锐的意识，因为一个错误的决定的代价将大于等待的代价。在不同的环境中，最佳速度 / 质量决策权衡可能会有很大的差异
  - 快速做决定意味着在你的职业生涯中你能做出更多的决定，这会让你对哪一个备选项才是正确的选择产生更强的直觉。经验是生产力的关键，更高的生产力将为你提供更多的经验：这是一个良性循环。
  - 在你意识到自己缺乏直觉的情况下，坚持抽象原则。在你的职业生涯中建立一个可靠的原则清单。原则是形式化的直觉，比原始模式识别适用于更广泛的情况 (这需要对类似情况有直接且广泛的经验)
* 本质上做技术的都是手艺人，但代码不会传承，代码只会更新—程序员都是不吃老本的手艺人
* 工作越久越发现，靠谱和情商慢慢比技术能力还要重要一些
* 程序员的收入相对可观，但把「月薪」变成「时薪」，你会发现所谓赚得多其实是个笑话。这行吃的是青春饭，30岁后的一段日子里，从业者就能感受到了前所未有的压力
* 于是开始强迫自己研究投资理财—我发现我们在理财方面是有优势的！比如流水不低，花钱又不多，结余率很高，每个月都有比较可观的钱可以拿去理财
* 对新事物的接受程度高，更容易抓住新物种的早期红利；「执行力」比普通人强，而执行力在投资中太重要了
* 最好的理财方式，是构建一个「赚钱系统」。搭建好框架后，我们只需花少量的时间做后期维护。这个系统会源源不断地赚取「睡后收入」

### GOOD

* The only “best practice” you should be using all the time is “Use Your Brain”.
* Programmers who don’t code in their spare time for fun will never become as good as those that do.
* Most comments in code are in fact a pernicious form of code duplication.
* XML is highly overrated
* Not all programmers are created equal
* ”Googling it” is okay!
* If you only know one language, no matter how well you know it, you’re not a great programmer.
* Your job is to put yourself out of work.
* Design patterns are hurting good design more than they’re helping it.
* Unit Testing won’t help you write good code
* 过早的优化是万恶之源。Premature optimization is the root of all evil! – Donald Knuth
* 在水里行走和以一个需求规格进行软件开发，有一点是相同的，那就是如果水或需求都被冻住不了，那么行走和软件开发都会变得容易。Walking on water and developing software from a specification are easy if both are frozen – Edward V Berard
* Hofstadter 定理：“一件事情总是会花费比你预期更多的时间，就算是你已经考虑过本条Hofstadter 定理”。It always takes longer than you expect, even when you take into account Hofstadter’s Law. – Hofstadter’s Law
* 有些遇到问题的人总是会说“我知道，我会使用正则表达式”，那么，你现在有两个问题了。（意思是：你本想用正则表达式来解决你已有问题，但实际上你又引入了“正则表达式”的一个新问题）Some people, when confronted with a problem, think “I know, I’ll use regular expressions.” Now they have two problems – Jamie Zawinski
* 调试程序的难度是写代码的两倍。因此，只要你的代码写的尽可能的清楚，那么你在调试代码时就不需要那么地有技巧。Debugging is twice as hard as writing the code in the first place. Therefore, if you write the code as cleverly as possible, you are, by definition, not smart enough to debug it. – Brian Kernighan
* 用代码行来衡量开发进度，无异于用重量来衡量制造飞机的进度。Measuring programming progress by lines of code is like measuring aircraft building progress by weight.  – Bill Gates
* PHP被一些不合格的业余人员造就成了一个小恶魔；而Perl则是被一些熟练的但不正当的专业人员造就成了一个超级大恶魔。PHP is a minor evil perpetrated and created by incompetent amateurs, whereas Perl is a great and insidious evil, perpetrated by skilled but perverted professionals.  – Jon Ribbens
* 在两个场合我被问到：“请你告诉我，如果你给机器输入了错误的数字，那么，是否还能得到正确的答案？”我并不能正确领会这类想法。（注意，本引言的作者姓Babbage，这个名字和神父同名，意思是，作者在反问提问的人，你是问我还是向神父祈祷？）On two occasions I have been asked, ‘Pray, Mr. Babbage, if you put into the machine wrong figures, will the right answers come out?’ I am not able rightly to apprehend the kind of confusion of ideas that could provoke such a question.”  – Charles Babbage
* 在编程的时候，我们一定要想像一下，以后维护我们自己的代码的那个人会成为一个有暴力倾向的疯子，并且，他还知道我们住在哪里？Always code as if the guy who ends up maintaining your code will be a violent psychopath who knows where you live. – Rick Osborne
* 现代的编程是“程序员努力建一个更大更傻的程序”和“世界正在尝试创造更多更傻的人”之间的一种竞赛，目前为止，后者是赢家。Programming today is a race between software engineers striving to build bigger and better idiot-proof programs, and the Universe trying to produce bigger and better idiots. So far, the Universe is winning. – Rich Cook
* 我才不关于我的代码是否能在你的机器上工作！我们不会给你提供机器。I don’t care if it works on your machine! We are not shipping your machine! – Ovidiu Platon
* 我总是希望我的电脑能够像电话一样容易使用；我的这个希望正在变成现实，因为我现在已经不知道怎么去使用我的电话了。I have always wished for my computer to be as easy to use as my telephone; my wish has come true because I can no longer figure out how to use my telephone. – Bjarne Stroustrup
* 计算机是一种在人类历史上所有发明中，可以让你比以前更快地犯更多的错误的发明，同样，其也包括了“手枪”和“龙舌兰酒”这两种发明的缺陷。A computer lets you make more mistakes faster than any other invention in human history, with the possible exceptions of handguns and tequila. – Mitch Ratcliffe
* 如果调试程序是一种标准的可以铲除BUG的流程，那么，编程就是把他们放进来的流程。If debugging is the process of removing software bugs, then programming must be the process of putting them in. – E. W. Dijkstra
* 教一群被BASIC先入为主的学生，什么是好的编程风格简直是一件不可能的事。对于一些有潜力的程序员，他们所受到的智力上的伤害远远超过了重建他们的信心。It is practically impossible to teach good programming style to students that have had prior exposure to BASIC. As potential programmers, they are mentally mutilated beyond hope of regeneration. – E. W. Dijkstra
* 理论上来说，理论和实际是一样的。但实际上来说，他们则不是。In theory, theory and practice are the same. In practice, they’re not. – Unknown
* 只有两个事情是无穷尽的：宇宙和人类的愚蠢。当然，我现在还不能确定宇宙是无穷尽的。Two things are infinite: the universe and human stupidity; and I’m not sure about the universe. – Albert Einstein
* Perl这种语言就好像是被RSA加密算法加密过的一样。Perl – The only language that looks the same before and after RSA encryption. – Keith Bostic
* 我爱“最终期限”，我喜欢“嗖嗖嗖”的声音就像他们在飞一样。I love deadlines. I like the whooshing sound they make as they fly by. – Douglas Adams
* 说Java好的是因为它跨平台就像好像说肛交好是因为其可以适用于一切性别。Saying that Java is good because it works on all platforms is like saying anal sex is good because it works on all genders – Unknown
* XML就像是一种强暴——如果它不能解决你的问题，那只能说明你没有用好它。XML is like violence – if it doesn’t solve your problems, you are not using enough of it. – Unknown
* 爱因期坦说，自然界中的一切一定会有一个简单的解释，因为上帝并不是反复无常和独裁的。当然，不会有什么信仰能程序员像爱因期坦那样感到舒服。Einstein argued that there must be simplified explanations of nature, because God is not capricious or arbitrary. No such faith comforts the software engineer. – Fred Brooks
* 函数不要超过50行。
* 不要一次性写太多来不及测的代码，而是要写一段调试一段
* UT和编码要同步做
* 多写注释方便的往往是自己
* 碰到一堆问题时，一次只尝试解决一个问题
* 没把握一眼看出问题症结的时候，老老实实单步调试
* 设计模式是个好东西，但不要强行使用
* 没造成可观的损失前不要尝试做性能优化
* 没事别重复造轮子
* 大多数情况下Boss不关心技术含量，而且往往简单的解决方案更快更有效果
* 不要害怕接触新知识，因为害怕也没用，不管你愿意不愿意，你现在会的东西5年后就会过时
* 重构是程序员的主力技能
* 工作日志能提升脑容量
* 先用profiler调查，才有脸谈优化
* 漫山遍野的注释实际背景噪音
* 普通程序员+google=超级程序员
* 写单元测试总是合算的
* 不要先写框架再写实现。最好反过来，从原型中提炼框架
* 代码结构清晰，其它问题都不算事儿
* 管理行不行，就看工作流
* 编码不要畏惧变化，要拥抱变化
* 常充电。程序员只有一种死法：土死的。

### BAD

* 情绪化的思维
* 怀疑别人
* 过多关注实现，陷入问题细节
* 使用并不熟悉的代码
* 拼命工作而不是聪明的工作
* 总是在等待、找借口以及抱怨
* 滋生办公室政治
* 说得多做得少
* 顽固
* 写“聪明”的代码
* 面向对象编程因为其具有丰富的特性（封装、抽象、继承、多态），可以实现很多复杂的设计思路，是很多设计原则、设计模式等编码实现的基础
* 设计原则是指导我们代码设计的一些经验总结，对于某些场景下，是否应该应用某种设计模式，具有指导意义。比如，“开闭原则”是很多设计模式（策略、模板等）的指导原则
* 设计模式是针对软件开发中经常遇到的一些设计问题，总结出来的一套解决方案或者设计思路。应用设计模式的主要目的是提高代码的可扩展性。从抽象程度上来讲，设计原则比设计模式更抽象。设计模式更加具体、更加可执行
* 编程规范主要解决的是代码的可读性问题。编码规范相对于设计原则、设计模式，更加具体、更加偏重代码细节、更加能落地。持续的小重构依赖的理论基础主要就是编程规范
* 重构作为保持代码质量不下降的有效手段，利用的就是面向对象、设计原则、设计模式、编码规范这些理论

## [编程范式](paradigm)

## 任务分解

* 将复杂问题拆解为可验证的、相互独立的、简单任务；当所有简单任务都完成时，复杂问题也就解决了
  - 复杂问题：不能清楚的在脑海里浮现出每行代码该怎么写的问题
  - 简单任务：清楚的知道每行代码该怎么写，naming
    + **输入输出**对于小任务而言很重要
    + 确定每个小任务的输入与输出，描述需要包含两个东西：
      * 类型
      * 业务含义：通过变量名
  - 可验证：当给定输入的时候，明确的知道输出是什么
  - 相互独立：当明确知道该小任务输入输出是什么的时候，小任务就可以被完成
    + 特点：乱序，即可以先完成”找出最大值“，再完成”判断是否大于十“，最后完成”找出所有偶数“。每个任务之间相互不影响
  - 完成：当所有简单任务完成后，可以满足复杂问题的所有需求，即在拆分任务的时候不能遗漏功能
* 步骤
  - 理解需求:确认问题域
  - 拆分 **划分上下文**
  - 实现
  - 验证
  - 优化

* 能像机器一样思考的人就适合做程序员.所有的计算机都是“冯・诺伊曼体系” 模型.所有的问题都从输入和输出的角度去思考，这就是计算机这台机器的思考方式
* 语义分析的方法论
* 输入，输出是些什么呢？机器在加工什么？SICP 中又说了，非形式的讲，只在处理两种东西，数据和过程，他们还不是严格区分的
  - 中间处理部分是过程
  - 输入和输出是数据
* 步骤,需要 Analytical Thinking
  - 分解问题
  - 找到子问题之间关联（通过输入输出关联起来）
  - 找到问题边界，明确假设与结果
* 问题
  - what：过程描述
  - How:怎么实现
  - why:设计
* Practice
  - 试着做FizzBuzzWhizz的Tasking
  - 计算一个文本文件 words.txt 中每个单词出现的频率
    + 只包含小写字母和空格
    + 每个单词只包含小写字母
    + 单词之间由一个或多个空格分开
* 特征
  - 独立
    + 意味着可拆分，职责单一。返例是多重循环 无法做到拆分彼此
    + 所谓各自独立（Exclusive），说的就是在划分任务的过程中，每一个任务都对应一个代码块或一个函数，这些代码块和函数，是互相不包含的
  - 穷尽
    + 每一个任务的输出都能被下一个任务输入使用
    + 最终保证所有任务的配合完成可以完成这个目标
* 输入类型
  - 参数
  - 读取全局变量
  - 调用全局函数后得到的返回值
  - 读取局部作用域变量（比如this）
  - 调用局部函数后得到的返回值
  - hard code的数据
* 输出类型
  - 返回值
  - 修改全局变量
  - 调用全局函数时传的参数
  - 修改局部作用域变量（比如this）
  - 调用局部函数时传的参数
* Evaluate task
  - 语文问题:用词精确，前后一致
  - 接口问题:完全穷尽
  - 每个函数之间互相不知道对方的内在实现,各自独立

![Alt text](../_static/tasking.png "Optional title")

## 流程

* 需求：文档
* 产品设计：设计原型
* 架构：
* 实现
* 反馈实现

## 实现

* 网站web 手机应用app
* 支付系统、图像集群、广告平台

## 后端

* SOA，微服务架构
* Go 的微服务架构
* 对缓存，消息队列，微服务，websocket等都有深刻的认识和应用经验
* 有分布式处理，SAAS服务有一定的工作经验优

### 数据库

* MySQL数据库、事务及SQL优化
* Redis及常用队列中间件

## 数据

* 数据结构和算法
* Spark，Hadoop，Hive和 MapReduce
* 精通数据仓库建模技术，能够处理数据瑕疵，交互式及可视化数据；
* 擅长高效设计和ETL workflows；
* 熟悉机器学习如自然语言处理或预测建模。
* 数据驱动 数据设计与构建

## 复杂性

* 价值并不在于某项单独技能有多厉害，而是整体交付能力。而交付过程中，需要管理各种复杂性。变得复杂，恰恰是一个公司走向成熟的标志。
* [Computational Complexity: A Modern Approach](https://theory.cs.princeton.edu/complexity/)

### 来源

* 高并发、高性能：互联网系统特点，用户量大，请求量大，高并发高性能成为必备要求。性能差体验会差，用户会有别选择。
* 高可用：系统高可用可提升用户体验，也变为必备要求。十几年前我们买股票都需要T+N操作，而现在通过手机可以实时办理。
* 可扩展、易迭代：在产品初期，采用单体或简单的架构。成熟期，演进为现在大中台、小前台的概念，把不变的和变得拆分开来。产品经理、构师需避免无限放大需求，面向未来设计，进入尴尬境地。
* 低成本：是个过程。ROI投入产出比越往后越低。
* 低规模：规模小，成本肯定低，运维、扩展.... 都将方便。所以简单、适用、演进架构设计原则很重要。
* 易运维：除了传统运方面。业务的快速发展，灰度发布、快速发布回滚、部分功能升级、ab测试等对架构层面提出更高要求，也是现在容器化技术这么流行原因之一

### 系统设计

* 能够完成小型系统的基本设计，包括简单的数据库设计，能够完成基本的浏览器 -< Nginx+PHP -< 数据库 架构的设计开发工作；
* 能够支撑每天几十万到数百万流量网站的开发维护工作；

## 第二阶段：提高阶段

重点：提高针对LNMP的技能，能够更全面的对LNMP有熟练的应用。
目标：能够随时随地搭建好LNMP环境，快速完成常规配置；能够追查解决大部分遇到的开发和线上环境的问题；能够独立承担中型系统的构架和开发工作；能够在大型系统中承担某个中型模块的开发工作；

### Linux

在第一阶段的基础上面，能够流畅的使用Shell脚本来完成很多自动化的工作；
awk/sed/perl 也操作的不错，能够完成很多文本处理和数据统计等工作；
基本能够安装大部分非特殊的Linux程序（包括各种库、包、第三方依赖等等，比如MongoDB/Redis/Sphinx/Luncene/SVN之类的）；
了解基本的Linux服务，知道如何查看Linux的性能指标数据，知道基本的Linux下面的问题跟踪等。

### Nginx

在第一阶段的基础上面，了解复杂一些的Nginx配置；
包括 多核配置、events、proxy_pass，sendfile/tcp_*配置，知道超时等相关配置和性能影响；
知道nginx除了web server，还能够承担代理服务器、反向静态服务器等配置；
知道基本的nginx配置调优；
知道如何配置权限、编译一个nginx扩展到nginx；
知道基本的nginx运行原理（master/worker机制，epoll），知道为什么nginx性能比apache性能好等知识；

### MySQL/MongoDB

在第一阶段的基础上面，在MySQL开发方面，掌握很多小技巧，包括常规SQL优化（group by/order by/rand优化等）；
除了能够搭建MySQL，还能够冷热备份MySQL数据，还知道影响innodb/myisam性能的配置选项（比如key_buffer/query_cache/sort_buffer/innodb_buffer_pool_size/innodb_flush_log_at_trx_commit等），也知道这些选项配置成为多少值合适；
另外也了解一些特殊的配置选项，比如 知道如何搭建mysql主从同步的环境，知道各个binlog_format的区别；
知道MySQL的性能追查，包括slow_log/explain等，还能够知道基本的索引建立处理等知识；
原理方面了解基本的MySQL的架构（Server+存储引擎），知道基本的InnoDB/MyISAM索引存储结构和不同（聚簇索引，B树）；
知道基本的InnoDB事务处理机制；
了解大部分MySQL异常情况的处理方案（或者知道哪儿找到处理方案）；
条件允许的情况，建议了解一下NoSQL的代表MongoDB数据库，顺便对比跟MySQL的差别，同时能够在合适的应用场景安全谨慎的使用MongoDB，知道基本的PHP与MongoDB的结合开发。

### Redis/Memcached

在大部分中型系统里面一定会涉及到缓存处理，所以一定要了解基本的缓存；
知道Memcached和Redis的异同和应用场景，能够独立安装 Redis/Memcached，了解Memcahed的一些基本特性和限制，比如最大的value值，知道PHP跟他们的使用结合；
Redis了解基本工作原理和使用，了解常规的数据类型，知道什么场景应用什么类型，了解Redis的事务等等;
原理部分，能够大概了解Memcached的内存结构（slab机制），redis就了解常用数据类型底层实现存储结构（SDS/链表/SkipList/HashTable）等等，顺便了解一下Redis的事务、RDB、AOF等机制更好

### PHP

除了第一阶段的能力，安装配置方面能够随意安装PHP和各种第三方扩展的编译安装配置；
了解php-fpm的大部分配置选项和含义（如max_requests/max_children/request_terminate_timeout之类的影响性能的配置），知道mod_php/fastcgi的区别；
在PHP方面已经能够熟练各种基础技术，还包括各种深入些的PHP，包括对PHP面向对象的深入理解/SPL/语法层面的特殊特性比如反射之类的；
在框架方面已经阅读过最少一个以上常规PHP MVC框架的代码了，知道基本PHP框架内部实现机制和设计思想；在PHP开发中已经能够熟练使用常规的设计模式来应用开发（抽象工厂/单例/观察者/命令链/策略/适配器 等模式）；
建议开发自己的PHP MVC框架来充分让开发自由化，让自己深入理解MVC模式，也让自己能够在业务项目开发里快速升级；
熟悉PHP的各种代码优化方法，熟悉大部分PHP安全方面问题的解决处理；熟悉基本的PHP执行的机制原理（Zend引擎/扩展基本工作机制）；

### C/C++

开始涉猎一定的C/C++语言，能够写基本的C/C++代码，对基本的C/C++语法熟悉（指针、数组操作、字符串、常规标准API）和数据结构（链表、树、哈希、队列）有一定的熟悉下；
对Linux下面的C语言开发有基本的了解概念，会简单的makefile文件编写，能够使用简单的GCC/GDB的程序编译简单调试工作；
对基本的网络编程有大概了解。（本项是为了向更高层次打下基础）

### 前端

在第一阶段的基础上面，熟悉基本的HTTP协议（协议代码200/300/400/500，基本的HTTP交互头）；
条件允许，可以在深入写出稍微优雅的HTML+CSS+JavaScript，或者能够大致简单使用某些前端框架（jQuery/YUI/ExtJS/RequireJS/BootStrap之类）；
如果条件允许，可以深入学习JavaScript编程，比如闭包机制、DOM处理；再深入些可以读读jQuery源码做深入学习。（本项不做重点学习，除非对前端有兴趣）

### 系统设计

能够设计大部分中型系统的网站架构、数据库、基本PHP框架选型；性能测试排查处理等；
能够完成类似：浏览器 -< CDN(Squid) -< Nginx+PHP -< 缓存 -< 数据库 结构网站的基本设计开发维护；
能够支撑每天数百万到千万流量基本网站的开发维护工作；

## 第三阶段：高级阶段 （高级PHP程序员）

重点：除了基本的LNMP程序，还能够在某个方向或领域有深入学习。（纵深维度发展）

目标：除了能够完成基本的PHP业务开发，还能够解决大部分深入复杂的技术问题，并且可以独立设计完成中大型的系统设计和开发工作；自己能够独立hold深入某个技术方向，在这块比较专业。（比如在MySQL、Nginx、PHP、Redis等等任一方向深入研究）

### Linux

除了第二阶段的能力，在Linux下面除了常规的操作和性能监控跟踪，还能够使用很多高级复杂的命令完成工作（watch/tcpdump/starce/ldd/ar等)；
在shell脚本方面，已经能够编写比较复杂的shell脚本（超过500行）来协助完成很多包括备份、自动化处理、监控等工作的shell；
对awk/sed/perl 等应用已经如火纯青，能够随意操作控制处理文本统计分析各种复杂格式的数据；
对Linux内部机制有一些了解，对内核模块加载，启动错误处理等等有个基本的处理；
同时对一些其他相关的东西也了解，比如NFS、磁盘管理等等；

### Nginx

在第二阶段的基础上面，已经能够把Nginx操作的很熟练，能够对Nginx进行更深入的运维工作，比如监控、性能优化，复杂问题处理等等；
看个人兴趣，更多方面可以考虑侧重在关于Nginx工作原理部分的深入学习，主要表现在阅读源码开始，比如具体的master/worker工作机制，Nginx内部的事件处理，内存管理等等；
同时可以学习Nginx扩展的开发，可以定制一些自己私有的扩展；
同时可以对Nginx+Lua有一定程度的了解，看看是否可以结合应用出更好模式；
这个阶段的要求是对Nginx原理的深入理解，可以考虑成为Nginx方向的深入专业者。

### MySQL/MongoDB

在第二阶段的基础上面，在MySQL应用方面，除了之前的基本SQL优化，还能够在完成一些复杂操作，比如大批量数据的导入导出，线上大批量数据的更改表结构或者增删索引字段等等高危操作；
除了安装配置，已经能够处理更多复杂的MySQL的问题，比如各种问题的追查，主从同步延迟问题的解决、跨机房同步数据方案、MySQL高可用架构等都有涉及了解；
对MySQL应用层面，对MySQL的核心关键技术比较熟悉，比如事务机制（隔离级别、锁等）、对触发器、分区等技术有一定了解和应用；
对MySQL性能方面，有包括磁盘优化（SAS迁移到SSD）、服务器优化（内存、服务器本身配置）、除了二阶段的其他核心性能优化选项（innodb_log_buffer_size/back_log/table_open_cache/thread_cache_size/innodb_lock_wait_timeout等）、连接池软件选择应用，对show *（show status/show profile）类的操作语句有深入了解，能够完成大部分的性能问题追查；
MySQL备份技术的深入熟悉，包括灾备还原、对Binlog的深入理解，冷热备份，多IDC备份等；在MySQL原理方面，有更多了解，比如对MySQL的工作机制开始阅读部分源码，比如对主从同步（复制）技术的源码学习，或者对某个存储引擎（MyISAM/Innodb/TokuDB）等等的源码学习理解，如果条件允许，可以参考CSV引擎开发自己简单的存储引擎来保存一些数据，增强对MySQL的理解；
在这个过程，如果自己有兴趣，也可以考虑往DBA方向发展。MongoDB层面，可以考虑比如说在写少读多的情况开始在线上应用MongoDB，或者是做一些线上的数据分析处理的操作，具体场景可以按照工作来，不过核心是要更好的深入理解RMDBS和NoSQL的不同场景下面的应用，如果条件或者兴趣允许，可以开始深入学习一下MongoDB的工作机制。

### Redis/Memcached

在第二阶段的基础上面，能够更深入的应用和学习。因为Memcached不是特别复杂，建议可以把源码进行阅读，特别是内存管理部分，方便深入理解；Redis部分，可以多做一些复杂的数据结构的应用（zset来做排行榜排序操作/事务处理用来保证原子性在秒杀类场景应用之类的使用操作）；
多涉及aof等同步机制的学习应用，设计一个高可用的Redis应用架构和集群；
建议可以深入的学习一下Redis的源码，把在第二阶段积累的知识都可以应用上，特别可以阅读一下包括核心事件管理、内存管理、内部核心数据结构等充分学习了解一下。如果兴趣允许，可以成为一个Redis方面非常专业的使用者。

### PHP

作为基础核心技能，在第二阶段的基础上面，需要有更深入的学习和应用

从基本代码应用上面来说，能够解决在PHP开发中遇到95%的问题，了解大部分PHP的技巧；
对大部分的PHP框架能够迅速在一天内上手使用，并且了解各个主流PHP框架的优缺点，能够迅速方便项目开发中做技术选型；
在配置方面，除了常规第二阶段会的知识，会了解一些比较偏门的配置选项（php auto_prepend_file/auto_append_file），包括扩展中的一些复杂高级配置和原理（比如memcached扩展配置中的memcache.hash_strategy、apc扩展配置中的apc.mmap_file_mask/apc.slam_defense/apc.file_update_protection之类的）；
对php的工作机制比较了解，包括php-fpm工作机制（比如php-fpm在不同配置机器下面开启进程数量计算以及原理），对zend引擎有基本熟悉（vm/gc/stream处理），阅读过基本的PHP内核源码（或者阅读过相关文章），对PHP内部机制的大部分核心数据结构（基础类型/Array/Object）实现有了解，对于核心基础结构（zval/hashtable/gc）有深入学习了解；
能够进行基本的PHP扩展开发，了解一些扩展开发的中高级知识（minit/rinit等），熟悉php跟apache/nginx不同的通信交互方式细节（mod_php/fastcgi）；
除了开发PHP扩展，可以考虑学习开发Zend扩展，从更底层去了解PHP。

### C/C++

在第二阶段基础上面，能够在C/C++语言方面有更深入的学习了解，能够完成中小型C/C++系统的开发工作；
除了基本第二阶段的基础C/C++语法和数据结构，也能够学习一些特殊数据结构（b-tree/rb-tree/skiplist/lsm-tree/trie-tree等）方便在特殊工作中需求；
在系统编程方面，熟悉多进程、多线程编程；多进程情况下面了解大部分多进程之间的通信方式，能够灵活选择通信方式（共享内存/信号量/管道等）；
多线程编程能够良好的解决锁冲突问题，并且能够进行多线程程序的开发调试工作；同时对网络编程比较熟悉，了解多进程模型/多线程模型/异步网络IO模型的差别和选型，熟悉不同异步网络IO模型的原理和差异（select/poll/epoll/iocp等），并且熟悉常见的异步框架（ACE/ICE/libev/libevent/libuv/Boost.ASIO等）和使用，如果闲暇也可以看看一些国产自己开发的库（比如muduo）；
同时能够设计好的高并发程序架构（leader-follow/master-worker等）；
了解大部分C/C++后端Server开发中的问题（内存管理、日志打印、高并发、前后端通信协议、服务监控），知道各个后端服务RPC通信问题（struct/http/thirft/protobuf等）；
能够更熟络的使用GCC和GDB来开发编译调试程序，在线上程序core掉后能够迅速追查跟踪解决问题；
通用模块开发方面，可以积累或者开发一些通用的工具或库（比如异步网络框架、日志库、内存池、线程池等），不过开发后是否应用要谨慎，省的埋坑去追bug；

### 前端

深入了解HTTP协议（包括各个细致协议特殊协议代码和背后原因，比如302静态文件缓存了，502是nginx后面php挂了之类的）；
除了之前的前端方面的各种框架应用整合能力，前端方面的学习如果有兴趣可以更深入，表现形式是，可以自己开发一些类似jQuery的前端框架，或者开发一个富文本编辑器之类的比较琐碎考验JavaScript功力；

### 其他领域语言学习

在基础的PHP/C/C++语言方面有基本积累，建议在当前阶段可以尝试学习不同的编程语言，看个人兴趣爱好，脚本类语言可以学学 Python/Ruby 之类的，函数式编程语言可以试试 Lisp/Haskell/Scala/Erlang 之类的，静态语言可以试试 Java/Golang，数据统计分析可以了解了解R语言，如果想换个视角做后端业务，可以试试 Node.js还有前面提到的跟Nginx结合的Nginx_Lua等。学习不同的语言主要是提升自己的视野和解决问题手段的差异，比如会了解除了进程/线程，还有轻量级协程；
比如在跨机器通信场景下面，Erlang的解决方案简单的惊人；比如在不想选择C/C++的情况下，还有类似高效的Erlang/Golang可用等等；
主要是提升视野。

### 系统设计

* 能够应用掌握的经验技能，设计出比较复杂的中大型系统，能够解决大部分线上的各种复杂系统的问题，完成类似 浏览器 -< CDN -< 负载均衡 -<接入层 -< Nginx+PHP -< 业务缓存 -< 数据库 -< 各路复杂后端RPC交互（存储后端、逻辑后端、反作弊后端、外部服务） -< 更多后端 酱紫的复杂业务
* 能够支撑每天数千万到数亿流量网站的正常开发维护工作。

## hackathon


## [the-little-printf](https://ferd.ca/the-little-printf.html)

* 只做擅长的领域的开发,确保我在我的领域的永远有价值，每次我和同事合作的时候，都是一次不好的经历。以往的经验：最好的办法是：把他们的代码拿过来重写。然后就可以了！"
* 黑暗的办公室政治：让他们知道他们走上歧途了，却又不明确的指出来。这表现的我比他们厉害。然而他们毫无头绪，像雾里看花。没有人能明白我的意思
* 不相信有可靠或者好的的程序！根本不可能！这是我的第一个感觉，因为我正在处理一个垃圾的系统
* 在这个飞速发展的世界中，如果你想参加这场游戏，你需要有先进的技术。否则你就会被时代淘汰，没有人想被时代淘汰。好的工具是为了解决问题而被制造出来的。但是你却盲目追求新的技术，而不是为了什么实际的目的。
* 因为你是最熟悉这些问题（bug🔥）的人，你只能变的越来越累，直到你的boss招了一个人顶替你原来的工作，这是唯一出路。但如果你担心其他人修改你写的东西时候遇到问题，你只能帮助别人改一个又一个的bug，当然这些都是你讨厌的事情。直到你对这一切感到麻木。
* 有些时候软件架构师看起来既不是软件工程师，也不是架构师（是老师？）
* 从解决复杂的问题而得到快乐和他们看重的名声和身份，这种快乐是片刻的。因为最终，如果你解决的问题没有实际价值（为了解决问题而解决问题），忽略了'以人为本'。那么你永远不会得到真正的满足！"随着你的成长，可能找到一家比之前更好的单位。可能是钱多，或者是因为这个工作更趣，这都很正常。只要你知道你自己想要的是什么！
* 当你解决了人们真正面临的问题的时候，你会觉得真正的满足。"你花费了大量的时间在你的系统上。最重要的是：你忘记当初为什么创建这个系统，反而花费时间在优化系统上面，那么它就变成了一场炫耀的游戏。这才是最可悲的。"
* 开发者经常忘记最开始的初衷（真正有意义的事情）。如果你失去做这件事意义，而是为了解决系统的问题，才花时间在这上面。这就是问题的所在
* 大多数电子游戏：你不能创造，只能反应，浪费你的时间。

### Drunk Post: Things I've learned as a Sr Engineer

-   The best way I've advanced my career is by changing companies.
-   Technology stacks don't really matter because there are like 15 basic patterns of software engineering in my field that apply. I work in data so it's not going to be the same as webdev or embedded. But all fields have about 10-20 core principles and the tech stack is just trying to make those things easier, so don't fret overit.
-   There's a reason why people recommend job hunting. If I'm unsatisfied at a job, it's probably time to move on.
-   I've made some good, lifelong friends at companies I've worked with. I don't need to make that a requirement of every place I work. I've been perfectly happy working at places where I didn't form friendships with my coworkers and I've been unhappy at places where I made some great friends.
-   I've learned to be honest with my manager. Not too honest, but honest enough where I can be authentic at work. What's the worse that can happen? He fire me? I'll just pick up a new job in 2 weeks.
-   If I'm awaken at 2am from being on-call for more than once per quarter, then something is seriously wrong and I will either fix it or quit.
-   pour another glass
-   Qualities of a good manager share a lot of qualities of a good engineer.
-   When I first started, I was enamored with technology and programming and computer science. I'm over it.
-   Good code is code that can be understood by a junior engineer. Great code can be understood by a first year CS freshman. The best code is no code at all.
-   The most underrated skill to learn as an engineer is how to document. Fuck, someone please teach me how to write good documentation. Seriously, if there's any recommendations, I'd seriously pay for a course (like probably a lot of money, maybe 1k for a course if it guaranteed that I could write good docs.)
-   Related to above, writing good proposals for changes is a great skill.
-   Almost every holy war out there (vim vs emacs, mac vs linux, whatever) doesn't matter... except one. See below.
-   The older I get, the more I appreciate dynamic languages. Fuck, I said it. Fight me.
-   If I ever find myself thinking I'm the smartest person in the room, it's time to leave.
-   I don't know why full stack webdevs are paid so poorly. No really, they should be paid like half a mil a year just base salary. Fuck they have to understand both front end AND back end AND how different browsers work AND networking AND databases AND caching AND differences between web and mobile AND omg what the fuck there's another framework out there that companies want to use? Seriously, why are webdevs paid so little.
-   We should hire more interns, they're awesome. Those energetic little fucks with their ideas. Even better when they can question or criticize something. I love interns.
-   Don't meet your heroes. I paid 5k to take a course by one of my heroes. He's a brilliant man, but at the end of it I realized that he's making it up as he goes along like the rest of us.
-   Tech stack matters. OK I just said tech stack doesn't matter, but hear me out. If you hear Python dev vs C++ dev, you think very different things, right? That's because certain tools are really good at certain jobs. If you're not sure what you want to do, just do Java. It's a shitty programming language that's good at almost everything.
-   The greatest programming language ever is lisp. I should learn lisp.
-   For beginners, the most lucrative programming language to learn is SQL. Fuck all other languages. If you know SQL and nothing else, you can make bank. Payroll specialtist? Maybe 50k. Payroll specialist who knows SQL? 90k. Average joe with organizational skills at big corp? $40k. Average joe with organization skills AND sql? Call yourself a PM and earn $150k.
-   Tests are important but TDD is a damn cult.
-   Cushy government jobs are not what they are cracked up to be, at least for early to mid-career engineers. Sure, $120k + bennies + pension sound great, but you'll be selling your soul to work on esoteric proprietary technology. Much respect to government workers but seriously there's a reason why the median age for engineers at those places is 50+. Advice does not apply to government contractors.
-   Third party recruiters are leeches. However, if you find a good one, seriously develop a good relationship with them. They can help bootstrap your career. How do you know if you have a good one? If they've been a third party recruiter for more than 3 years, they're probably bad. The good ones typically become recruiters are large companies.
-   Options are worthless or can make you a millionaire. They're probably worthless unless the headcount of engineering is more than 100. Then _maybe_ they are worth something within this decade.
-   Work from home is the tits. But lack of whiteboarding sucks.
-   I've never worked at FAANG so I don't know what I'm missing. But I've hired (and not hired) engineers from FAANGs and they don't know what they're doing either.
-   My self worth is not a function of or correlated with my total compensation. Capitalism is a poor way to determine self-worth.
-   Managers have less power than you think. Way less power. If you ever thing, why doesn't Manager XYZ fire somebody, it's because they can't.
-   Titles mostly don't matter. Principal Distinguished Staff Lead Engineer from Whatever Company, whatever. What did you do and what did you accomplish. That's all people care about.
-   Speaking of titles: early in your career, title changes up are nice. Junior to Mid. Mid to Senior. Senior to Lead. Later in your career, title changes _down_ are nice. That way, you can get the same compensation but then get an increase when you're promoted. In other words, early in your career (<10 years), title changes UP are good because it lets you grow your skills and responsibilities. Later, title changes down are nice because it lets you grow your salary.
-   Max out our 401ks.
-   Be kind to everyone. Not because it'll help your career (it will), but because being kind is rewarding by itself.
-   If I didn't learn something from the junior engineer or intern this past month, I wasn't paying attention.
-   Oops I'm out of wine.
-   Paying for classes, books, conferences is worth it. I've done a few conferences, a few 1.5k courses, many books, and a subscription. Worth it. This way, I can better pretend what I'm doing.
-   Seriously, why aren't webdevs paid more? They know everything!!!
-   Carpal tunnel and back problems are no joke. Spend the 1k now on good equipment.
-   The smartest man I've every worked for was a Math PhD. I've learned so much from that guy. I hope he's doing well.
-   Once, in high school, there was thing girl who was a great friend of mine. I mean we talked and hung out and shared a lot of personal stuff over a few years. Then there was a rumor that I liked her or that we were going out or whatever. She didn't take that too well so she started to ignore me. That didn't feel too good. I guess this would be the modern equivalent to "ghosting". I don't wish her any ill will though, and I hope she's doing great. I'm sorry I didn't handle that better.
-   I had a girlfriend in 8th grade that I didn't want to break up with even though I didn't like her anymore so I just started to ignore her. That was so fucked up. I'm sorry, Lena.
-   You know what the best part of being a software engineer is? You can meet and talk to people who think like you. Not necessarily the same interests like sports and TV shows and stuff. But they think about problems the same way you think of them. That's pretty cool.
-   There's not enough women in technology. What a fucked up industry. That needs to change. I've been trying to be more encouraging and helpful to the women engineers in our org, but I don't know what else to do.
-   Same with black engineers. What the hell?
-   I've never really started hating a language or technology until I started becoming intimately familiar with it. Also, I think a piece of tech is good if I hate it but I simultaneously would recommend it to a client. Fuck Jenkins but man I don't think I would be commuting software malpractice by recommending it to a new client.
-   That being said, git is awful and I have choice but to use it. Also, GUI git tools can go to hell, give me the command line any day. There's like 7 command lines to memorize, everything else can be googled.
-   Since I work in data, I'm going to give a data-specific lessons learned. Fuck pandas.
-   My job is easier because I have semi-technical analysts on my team. Semi-technical because they know programming but not software engineering. This is a blessing because if something doesn't make sense to them, it means that it was probably badly designed. I love the analysts on the team; they've helped me grow so much more than the most brilliant engineers.
-   Dark mode is great until you're forced to use light mode (webpage or an unsupported app). That's why I use light mode.
-   I know enough about security to know that I don't know shit about security.
-   Crap I'm out of wine.
-   Being a good engineer means knowing best practices. Being a senior engineer means knowing when to break best practices.
-   If people are trying to assign blame to a bug or outage, it's time to move on.
-   A lot of progressive companies, especially startups, talk about bringing your "authentic self". Well what if your authentic self is all about watching porn? Yeah, it's healthy to keep a barrier between your work and personal life.
-   I love drinking with my co-workers during happy hour. I'd rather spend time with kids, family, or friends.
-   The best demonstration of great leadership is when my leader took the fall for a mistake that was 100% my fault. You better believe I would've walked over fire for her.
-   On the same token, the best leaders I've been privileged to work under did their best to both advocate for my opinions and also explain to me other opinions 'that conflict with mine. I'm working hard to be like them.
-   Fuck side projects. If you love doing them, great! Even if I had the time to do side-projects, I'm too damn busy writing drunken posts on reddit
-   Algorithms and data strictures are important--to a point. I don't see pharmacist interviews test trivia about organic chemistry. There's something fucked with our industry's interview process.
-   Damn, those devops guys and gals are f'ing smart. At least those mofos get paid though.
-   It's not important to do what I like. It's more important to do what I don't hate.
-   The closer I am to the product, the closer I am to driving revnue, the more I feel valued regardless of how technical my work is. This has been true for even the most progressive companies.
-   Linux is important even when I was working in all Windows. Why? Because I eventually worked in Linux. So happy for those weekend where I screwed around installing Arch.
-   I've learned to be wary for ambiguous buzz words like big data. WTF is "big" data? I've dealt with 10k rows streaming every 10 minutes in Spark and Kafka and dealt with 1B rows batched up hourly in Python and MySQL. Those labels can go fuck themselves.
-   Not all great jobs are in Silicon Valley. But a lot are.

## 课程

* [freeCodeCamp](https://github.com/freeCodeCamp/freeCodeCamp): freeCodeCamp.org's open source codebase and curriculum. Learn to code at home. <https://www.freecodecamp.org/>
* [斯坦福大学公开课：编程方法学28集全](https://www.bilibili.com/video/av8048664)

## 项目

* [realworld](https://github.com/gothinkster/realworld):"The mother of all demo apps" — Exemplary fullstack Medium.com clone powered by React, Angular, Node, Django, and many more 🏅 <https://realworld.io/>

## 人物

* g9yuayon：Danny Yuan
	* 原籍成都,大学读两年之后(辍学赴加读本科)，先后在IBM和netflix编码
	* Twitter, HN, reddit
* Draveness
* 陈硕

### [陈皓](https://www.ituring.com.cn/article/9174)

  - 98年大学毕业，找到了一份令旁人羡慕的银行工作，后来离开
    + 银行正值扩张电子信息化业务的时候，其实应该有很多事可做，但是当时的主要工作都是由厂商来干。比如说IBM或Cisco拿下单子来，会把工作外包给系统集成商。作为一位技术人员，其实可以发挥的空间并不大，多数时间只是出了问题打电话的角色。没有人会教你任何事，出了问题，就是打电话，然后按照他们的指导来完成工作
    + 当时的辞职书是这么写的：“本人对现有工作毫无兴趣，申请辞职。”处长说，“你可以这么写，但是要加上‘经调解无效’，另外，分给你的房就不能要了。
  - 第一次去面试
    + 问了我半个小时，我一个问题都答不上来。我一直低着头，好像被审问的犯罪分子一样。我从大学毕业出来就没经历过什么面试，再加上自己内向的性格，所以，整个过程我都在低着头，不敢看别人一眼
    + 面试官问了我一个问题是“有不懂的问题你会怎么办”，这样的问题我都不敢回答
    + 最后面试官对我说：“你出来干什么，象你这种性格根本不适合
  - 决定经常出去面试，基本上每周都要去，不管懂不懂，也不管是什么公司，也不管别人鄙不鄙视我，反正一有机会就去面试
  - 散乱地学习两年后，才慢慢确定了要走C/C++/Unix/Windows系统底层的路子。这样扑天盖地学习的结果有一个好处就是，成长的速度相当之快。我自己摸索到了适合我的学习方法（从基础和原理上学习），从而不再害怕各种新的技术
  - 等到一年半之后，用句赵本山的台词说，我在面试中学会抢答了。面试官的问题没问完，我就能说出答案了。其实，基本上是面一个公司过一个,感到技术能力不行就去学技术，交往能力不行我就去面试
  - 没什么技术含量的工作,想尽一切方法提高交作业的效率.有更多的时间，去研究公司里外那些更为核心更为有技术含量的技术
    + 要去经历大多数人经历不到的，要把学习时间花在那些比较难的地方
    + 要写文章就要写没有人写过的，或是别人写过，但我能写得更好的
    + 更重要的是，技术和知识完全是可以变现的.只要能帮上大忙，就一定会赢得别人的尊重
    + 培训公司的投入产出比明显高很多后
  - 25~35 岁是每个人最宝贵的时光，应该用在刀刃上,把我的时间投在一些主流、高级和比较有挑战性的技术上，这可以让我保持两件事儿：一个是技术和技能的领先，二是对技术本质和趋势的敏感度
  - 从亚马逊到阿里巴巴是我在互联网行业的工作经历，这两段经历让我对这两家看似类似但内部完全不同的成功大公司，有了更为全面的了解和看法.两种完全不一样甚至有些矛盾的玩法
  - 新技术态度
    + 会去了解，但不会把很大的精力放在这。这些技术尚不成熟，只需要跟得住就可以了
    + 成熟的技术，比如Unix，40多年，C，40多年，C++，30多年，Java也有将近20年了……，所以，技术并不多啊。还有很多技术比如ruby,lisp这样的，它们没有进入主流的原因主要是缺少企业级的应用背景
    + 一个脉络下来，70年代Unix的出现，是软件发展方面的一个里程碑，那个时期的C语言，也是语言方面的里程碑。（当时）所有的项目都在Unix/C上，全世界人都在用这两样东西写软件。Linux跟随的是Unix, Windows下的开发也是 C。这时候出现的C++很自然就被大家接受了，企业级的系统很自然就会迁移到这上面，C++虽然接过了C的接力棒，但是它的问题是它没有一个企业方面的架构，否则也不会有今天的Java。C++和C非常接近，它只不过是C的一个扩展，长年没有一个企业架构的框架。而Java出现之后，IBM把企业架构这部分的需求接了过来，J2EE的出现让C/C++捉襟见肘了，后面还有了.NET，但可惜的是这只局限在Windows平台上
    + 另外一条脉络就是互联网方面的（HTML/CSS/JS/LAMP…）。这条脉络和上述的那条C/C++/Java的我都没有放，作为一个有技术忧虑症的人，这两条软件开发的主线一定不能放弃。无论是应用还是学术，我都会看，知识不愁多。何必搞应用的和搞学术的分开阵营，互相看不起呢？都是知识，学就好了
    + 技术的发展要根植于历史，而不是未来。不要和我描述这个技术的未来会多么美好，用这个技术可以实现什么花哨的东西。很多常青的技术都是承前的。所以说“某某（技术）要火”这样的话是没有意义的，等它火了、应用多了咱们再说嘛（笑）。有些人说不学C/C++也是没有问题的，我对此的回应是:如果连主干都可以不学的话，还有什么其他的好学呢？极端一点，我要这么说：这些是计算机发展的根、脉络、祖师爷，这样的东西怎么可以不学呢
  - 真正的高手都来自知识密集型的学院派。他们更强的是，可以把那些理论的基础知识应用到现在的业务上来。但很可惜，我们国内今天的教育并没有很好地把那些学院派的理论知识和现实的业务问题很好地接合起来.
  - 教育和现实脱节太严重了，教的东西无论是在技术还是在实践上都严重落后和脱节，没有通过实际的业务或技术问题来教学生那些理论知识，这是一个失败
  - 早上7:30起床，会浏览一下国外的新闻，hacker news, tech church, reddit, highavailability之类的站点,9点上班。晚上6、7点钟下班，开始带孩子。十点钟孩子睡了觉，我会开始重新细读一下这一天都发生了些什么事情。这个时间也有可能会用来看书。学习的过程（我）是不喜欢被打断的，所以从十点到十二点，家人都睡了，这正是我连续学习的好时间。可能从晚上11:30开始，我会做点笔记或者写博客。我现在对酷壳文章的质量要求比较高一些，所以大概积累一个星期的时间才可以生成一篇文章。每天我大概都在一两点钟才会睡觉。没办法，我有技术焦虑症
  - 前端后端都是编程，Javascript是编程，C++也是编程。编程不在于你用什么语言去coding，而是你组织程序、设计软件的能力，只要你上升到脑力劳动上来，用什么都一样，技术无贵贱就是这个意思
  - 入世和出世要分开，不要让世俗的东西打扰到你的内心世界，你的情绪不应该为别人所控，也不应该被世俗所污染，活得真实，你才会快乐。第二点就是要有热情，有了热情，你的心情就会很好，加班都可以是快乐的，想一想我们整个通宵用来打游戏的时光

## 图书

* [《How to Design Programs An Introduction to Programming and Computing》](http://htdp.org/)
* 程序是怎样运行的
* Code Reading: The Open Source Perspective
* 《发布！软件的设计与部署》：现实世界中充满了恶意用户，无论是主观的恶意，还是那种当点击页面上的按钮无响应后又多点击了100次的并非故意的恶意。这本书交给你如何为失败而做准备，并将这些恶意的影响降低到最低。欢迎来到现实世界。
* 《正见：佛陀的证悟》：一本直指内心的书，用极为平白的语言描述了原始佛教的四圣谛，没有任何的高深莫测或者故弄玄虚，作者用现实世界中的例子来阐述最为幽深的佛法，每个字都值得玩味。可以让你在纷乱的现世中找到内心的平静。
* 《[CODE: The Hidden Language of Computer Hardware and Software 编码：隐匿在计算机软硬件背后的语言](https://www.amazon.cn/gp/product/B009RSXIB4)》
* 《[编程原本](https://www.amazon.cn/gp/product/B006P7V73G)》
* 《[代码大全2 Code Complete](https://www.amazon.cn/gp/product/B0061XKRXA)》
* 《[代码整洁之道 Clean Code](https://www.amazon.cn/gp/product/B0031M9GHC)》
* 《[编程语言实现模式](https://www.amazon.cn/gp/product/B007HYMPBY)》
* 《[编写可读代码的艺术](https://www.amazon.cn/gp/product/B008B4DTG4)》
* 《[程序员修炼之道：从小工到专家《The Pragmatic Programmer》](https://www.amazon.cn/gp/product/B004GV08CY)》
  - [pragmatic-programmer-zh](https://github.com/caicaishmily/pragmatic-programmer-zh)
* 《The Practice of Programming》Kernighan
* [《计算机程序设计艺术 The Art of Computer Programming》](https://www-cs-faculty.stanford.edu/~knuth/taocp.html) Donald E. Knuth.
* 《[修改代码的艺术（Working Effectively with Legacy Code）](https://www.amazon.cn/gp/product/B00KMJ2Q1U)》
* [optimization](https://www.agner.org/optimize/)
  - Optimizing subroutines in assembly language: An optimization guide for x86 platforms
  - The microarchitecture of Intel, AMD and VIA CPUs: An optimization guide for assembly programmers and compiler makers
  - Instruction tables: Lists of instruction latencies, throughputs and micro-operation breakdowns for Intel, AMD and VIA CPUs
  - Calling conventions for different C++ compilers and operating systems

* [经典编程书籍大全](https://github.com/jobbole/awesome-programming-books):100+ 经典技术书籍，涵盖：计算机系统与网络、系统架构、算法与数据结构、前端开发、后端开发、移动开发、数据库、测试、项目与团队、程序员职业修炼、求职面试 和 编程相关的经典书籍。
* [每个程序员都应该要读的书](https://stackoverflow.com/questions/1711/what-is-the-single-most-influential-book-every-programmer-should-read)
* [free-programming-books](https://github.com/EbookFoundation/free-programming-books)Freely available programming books
  - [free-programming-books-zh_CN](https://github.com/justjavac/free-programming-books-zh_CN)
* [practical-programming-books](https://github.com/EZLippi/practical-programming-books)这里收录比较实用的计算机相关技术书籍，可以在短期之内入门的简单实用教程、一些技术网站以及一些写的比较好的博文
* [books-collection](https://github.com/waylau/books-collection):To the programmer's open source and free books collection 给程序员的开源、免费书籍收集，图书集合
* [Best-Books](https://www.best-books.dev/)
* [book](https://github.com/KeKe-Li/book):📚 All programming languages books <https://github.com/KeKe-Li/book>
* [book](https://github.com/songhuiqing/book)
* [books](https://github.com/programthink/books):【编程随想】收藏的电子书清单

### [Technology Radar](https://www.thoughtworks.com/radar)

* ThoughtWorks每半年发布一次的技术趋势报告，它持续追踪有趣的技术是如何发展的，我们将其称之为条目。技术雷达使用象限和环对其进行分类，不同象限代表不同种类的技术，而环则代表我们对其作出的成熟度评估
* [ThoughtWorks(中国)程序员读书雷达](http://agiledon.github.io/blog/2013/04/17/thoughtworks-developer-reading-radar/)
  - Coding Practice | 编程实践
    + 基础篇
      * Clean Code《代码整洁之道》
      * Pragmatic Unit Testing《单元测试之道》
      * The Productive Programmer《卓有成效的程序员》
      * Test-Driven Development By Example《测试驱动开发》
      * Clean Coder《程序员的职业修养》
      * The Art of Readable Code《编写可读代码的艺术》
    + 进阶篇
      * Refactoring To Patterns《重构与模式》
      * Implementation Patterns《实现模式》
      * Code complete 2nd edition《代码大全》
      * The Pragmatic Programmer《程序员修炼之道》
    + 高级篇
      * Structure and Interpretation of Computer Programs《计算机程序的构造和解释》
      * Working Effectively with Legacy Code《修改代码的艺术》
  - Architecture & Design | 架构与设计
    + 基础篇
      * Agile Software Development 《敏捷软件开发：原则、实践与模式》
      * Head First Design Patterns《深入浅出设计模式》
      * Design Patterns 《设计模式》
    + 进阶篇
      * The Art of UNIX Programming 《Unix编程艺术》
      * Practical API Design 《框架设计的艺术》
      * Domain Specific Languages 《领域特定语言》
      * Patterns of Enterprise Application Architecture 《企业应用架构模式》
    + 高级篇
      * Release It
      * Domain-Driven Design 《领域驱动设计》
      * Enterprise Integration Patterns《企业集成模式》
      * Beautiful Architecture《架构之美》
      * Pattern-Oriented Software Architecture《面向模式的软件架构》
  - Methodology | 方法学
    + 基础篇
      * User Stories Applied《用户故事与敏捷方法》
      * The Gold Mine《金矿》
      * Scrum and XP From the Trenches《硝烟中的Scrum和XP》
      * Continuous Integration《持续集成》
      * Extreme Programming Explained《解析极限编程》
    + 进阶篇
      * Lean Thinking《精益思想》
      * Continuous Delivery《持续交付》
      * How Google Tests Software
      * Agile Testing
      * Extreme Programming Refactored《重构极限编程》
    + 高级篇
      * Specification By Example
  - Thought & Leadership | 思想与领导力
    + 基础篇
      * The Effective Executive《卓有成效的管理者》
      * Are Your Lights On?《你的灯亮着吗》
      * Becoming A Technical Leader《成为技术领导者》
    + 进阶篇
      * The Fifth Discipline《第五项修炼》
      * The Design Of Business
      * Management 3.0《管理3.0：培养和提升敏捷领导力》
      * Presentation To Win
      * The McKinsey Way《麦肯锡方法》
    + 高级篇
      * Thinking, Fast and Slow《思考快与慢》
* [ThoughtWorks读书雷达（2016）](https://insights.thoughtworks.cn/reading-radar-2016/)
  - 编程与实践
    + 基础篇
      * 白帽子讲Web安全:互联网时代，每个人都需要知道的安全知识必备书籍。
      * 敏捷软件开发：原则、实践和模式
      * 重构 代码坏味道和相应代码的最佳实践。
      * 编写可读代码的艺术
      * 程序员的职业素养 The Clean Coder：A Code of Conduct for Professional Programmers
      * 软件开发践行录:ThoughtWorks聚集了很多爱思考爱分享的人。本书可以说就是这样一群极有天分的软件精英的思想和观点的汇聚，是他们多年的宝贵实践经验的凝结。涉猎广泛，通俗易懂，相信你读完肯定会有收获。
    + 进阶篇
      * 实现模式
      * 领域特定语言
      * Building Microservices:微服务是支持可演化性的一些一起协同工作的小而自治的服务。许多组织发现这种细粒度的架构让系统更具弹性，扩展，也能增加团队的自治。但是，大量的服务会导致很多令人头疼的问题必须处理。这本书作为一个一站式商店包含微服务涉及的各种主题，并且通过在ThoughtWorks，Amazon，Netflix和其他公司的具体实践，帮助大家了解微服务。
    + 高级篇
      * 计算机程序的构造和解释
      * 修改代码的艺术
  - 提升与修炼
    + 基础篇
      * 程序员思维修炼
      * 金字塔原理
      * 暗时间:为什么我每天都看书学习进步却并不明显？为什么有些人玩得时间不比我少学的时间不比我多，但却越来越牛？也许刘未鹏会给你答案。
      * 黑客：计算机革命的英雄 每门专业都有其灵魂，或者说启蒙思想。黑客精神伦理及其独特的价值观在很多方面都深刻地影响了今天软件业的形态。这本书对“黑客”的起源及发展做了详尽的阐释。对于一位以计算机，尤其是软件为职业的人来说，这本书将带你“寻根访祖”，探寻日常工作背后的哲思
    + 进阶篇
      * 系统思考
      * 咨询的奥秘
      * The Trusted Advisor:这本书初看有点儿像中文版的“厚黑学”，但是它内容并不是教读者取得个人功利的最大化，而是如何与他人合作，达到“win-win”。它的内容虽然涉及作为顾问如何有效地为客户提供价值，不过书中的建议操作性很强，完全可以应用在更广泛的范畴——我们每天与他人的交流很多都是向别人提建议或者接受别人建议的过程。最初我担心这本书的内容不适合“国情”，但后来的经历告诉我，在沟通与协作上，全人类都面临相同的挑战。
      * Unix编程艺术:UNIX作为一款软件，绝对是人类的工程史上的奇迹，今天最重要的系统几乎全部运行在UNIX或其变体之上。它诞生于软件工程方法论的“创世纪”。得益于数位天才的努力，UNIX将他们的智慧全部包容进来，比如我们耳熟能详的KISS，YAGNI原则。不过这些智慧大多以源代码的形式保留在磁盘上了。所幸Eric Raymond的妙笔让这些睿智跃然纸上，触手可得，也让后人可以不断地从中汲取智慧和精神动力。
    + 高级篇
      * 分析模式
      * 实现领域驱动设计:本书适合于那些已经具备面向对象编程基础并想进一步提升的开发人员，它告诉我们：好的软件不只是用好设计模式这么简单，而是要能够准确地表达业务意图，达到“代码本身即是设计”
  - 流程与交付
    + 基础篇
      * 硝烟中的Scrum和XP
      * 用户故事与敏捷方法
    + 进阶篇
      * 持续交付
      * Google软件测试之道
      * 敏捷软件测试
      * 精益软件度量:软件度量是当今软件开发行业的热点话题，但同时也是推广实施过程中的难题。一方面软件企业管理存在度量的迫切需求，另一方面，企业在推行软件度量的实践上问题颇多、效果不佳。人们迫切需要破解度量难题，找到切实可行的软件度量的实践方法。而这本书从精益理念的角度，尝试重新梳理在中等规模到大规模软件开发中度量体系设计和实施的思路。
    + 高级篇
      * 发布！软件的设计与部署
      * 看板方法
      * 实例化需求：团队如何交付正确的软件
      * 精益和敏捷开发大型应用指南:精益和敏捷在很多人眼里只是那些小而美的团队才能玩的转的工具，在大团队大项目中会出现各种各样的阻碍，源于和已有组织结构，沟通结构甚至绩效考核制度的不匹配。而大团体如何运用精益思想和敏捷的原则与实践开发？相信看完本书你会找到答案。
  - 思想与领导力
    + 基础篇
      * 门后的秘密
      * 部落的力量
        - 如果你幸运的话，在你的一生中，会有一些经历让你难忘，每当你遇到困难的时候，你都会不自觉的想起那个时候是什么样的，从中寻找答案，你在努力让自己身边的环境回到“当年”的那个状态，虽然已经物是人非。如果你不能，你会痛苦、无力、抱怨世事不如以前了。
        - 然而“当年”那个状态到底是什么状态？所谓伟大的团队到底有什么样的特点？他们中的每一个人心里想的是什么，他们之间又是如何交互的？所谓团队建设究竟应该怎么做？你又如何领导你的团队到达这样的状态？
        - 作为一个软件工程师，你一定会多多少少的遇到这些困惑，强烈建议你读读这本书，因为，毕竟，软件是一个协作的游戏。
    + 进阶篇
      * 精益思想
      * 第五项修炼
      * 影响力:为什么有些人极具说服力？同样的观点为什么不同人说出来的大家的反应是不一样的甚至截然相反的？这就是影响力这个武器的威力所在。影响力的打造和经营，无论对于个人还是企业，都可以让我们做到事半功倍，节省更多的成本，创造更多的价值
    + 高级篇
      * Agile IT Organization Design
      * 管理3.0：培养和提升敏捷领导力
      * 精益企业:“精益”的概念源自于二十世纪末期美国人对丰田制造方法的研究，总结出的可以同是提高质量并降低成本的秘密。“精益创业”将这种方法用于初创企业，并随着很多硅谷的明星公司以及国内很多创业奇迹故事而流行开来。于是很多人开始认为只有小型的初创企业才能谈及“精益”。本书的三位作者以他们自身丰富的经历告诉我们，同样的原则、方法、实践也适用于“恐龙”般的大型企业，从而保持它们与“初创公司”的竞争力。
* ThoughtWorks读书雷达 3.0-技术变革者眼中的知识彼岸
  - 思想领导力
    + 《值得信赖的顾问》信任是客户关系的基础,也是实现双赢的必经之路。作者用清晰易读又富有洞见的文字回答了“如何成为值得信任的专业顾问”这个所有咨询行业从业者都应该思考的问题。无论你是什么角色,只要你服务于客户, 在作者的描述里,你总能找到灵光乍现的时刻。
    + 《专业服务公司的管理》推荐PM或者团队领导者都读一读,读完这本书会对公司的运营模式、营收方式、人才储备、客户管理都有一个细致的了解。我读完最大的感受是意识到人才储备和知识共享非常重要,想要贡献自己的一份力量。
    + 《系统之美》敏捷思想的两大启发:精益和系统思考。如果想要探索后者,这本书将向你呈现系统理论的核心,可以作为一本很好的入门指南使用。如果你已经对系统理论有所了解,关心其发展前沿或是想要深入分析其中更抽象、深邃的理 论,这本书则不太适合。系统思考的方式能引导我们看清问题的本质。至于做或者不做,这是个人的选择,在人类精神的系统关照下,我 们应当知道什么该做,什么必须去做。
    + 《成为技术领导者》温伯格,作为技术思想三部曲中的一本,这本书一直引领着这个行业的技术从业者走向未来之路,不管是在职业上,还是在认知上。可信的译者余晟也为此书增色不少。
    + 《奈飞文化手册》本书系统介绍了奈飞文化准则,从多个角度揭示了奈飞为什么要对传统的企业文化理念发起冲击,以及它在打造自己的企业文化过程中提出了哪些颠覆性的观点。比如借鉴书中的一个观点:主动送优秀的人离开。对于企业,有责任不断抬高组织的天花板,创造进步的空间。而对于个人,也需要成为一个终身学习者,不断获取新技能并积累新经验。适合管理者和HR阅读,可以将本书看作是打造团队文化的行动指南。
    + 《技术的本质》科学的进步其实是对概念和术语的逐步定义。对事物本质的探究有利于我们抽象出共通概念,以此建立更广泛层面的复用。如果你在研究领域驱动设计,本书将会给你一个更广泛的视野。除此而外,面对日益发达的技术,作者还表现出了非常具有人文关怀的态度:“我们需要和自然容为一体。如果技术将我们与自然分离,它带给我们的就是死亡。如果技术加强了我们和自然的联系,那就是它对生命和人性的厚爱。”中文翻译质量不尽人意,建议阅读原文。
    + 《精益企业》“精益”的概念源自于二十世纪末期美国人对丰田制造方法的研究,进而总结出的可以同时提高质量并降低成本的秘密。“精益创业”将这种方法用于初创企业,并随着很多硅谷的明星公司以及国内很多创业奇迹故事而流行开来。 于是很多人开始认为只有小型的初创企业才能谈及“精益”。本书的三位作者以他们自身丰富的经历告诉我们,同样的原则、方法、实践也 适用于“恐龙”般的大型企业,从而保持它们 与“初创公司”的竞争力。
  - 编程实践
    + 《编码的奥秘》从信息的编码到计算的本质,以风趣幽默的方式写就,是计算机启蒙的绝佳书籍。
    + 《测试驱动开发:实战与模式解析》任何程序员,如果想要让自己计划内的编程工作不被修复缺陷所挤占,想要构建一个快速反馈的保护网,使得已经编写的代码逻辑不会被新增代码所破坏,想要提升编程体验,增强修改代码时的安全感,那么就可尝试该书所介绍的测试驱动开发方法,并从书中详细描述的两个实例中体验上述价值。
    + 《重构 改善既有代码的设计(第2版)》使用任何编程语言的程序员,如果对代码抱有持续改进的态度,都能从该书中学到一系和维护的形式。该书是18年后的第二版,使用JavaScript语言,通过实例介绍了重构的原则和方法。书中第3章“代码的坏味道”尤其有用,能帮助读者识别需要重构的代码,从而加以改进。
    + 《领域驱动设计》领域驱动设计的开山之作。作者后悔没有将该书最重要的战略设计内容,放在这本冗长书籍前半部分,导致有读者没有坚持读到那就放弃了。这本书对于初学者阅读起来的确存在难度,示例很少。在我看来领域驱动设计对程序员最直接的好处就是指导他们如何编写更好的代码,战略设计虽然重要,但是在更多时候靠的并不是一些既定的规范,而是程序员的经验。因此,我更倾向于对编码有实际指导意义的书籍,比如《实现领域驱动设计》和《领域驱动设计模式、原理与实践》
    + 《架构整洁之道》Bob在《架构整洁之道》中再次不厌其烦地阐述了SOLID原则,并引申出了组件构建原则和耦合原则,进而提出整洁架构。令我印象颇深的是SOLID中依赖倒置原则和组件耦合原则中的稳定依赖原则,两者分别强调了在类和组件设计中依赖管理的重要性,也正是基于此,才会得出数据库、Web、应用程序框架均为实现细节这个初看匪夷所思细想恍然大悟的结论。
    + 《敏捷软件开发:原则、模式与实践(C#版)》对于使用面向对象方法进行开发的程序员来说,如果想要让代码易于理解、扩展和测试,就要了解“单一职责原则、开闭原则、里氏替 换原则、依赖倒置原则、接口隔离原则” (简称 SOLID)设计方法。Bob不仅使用实例在书中对这些原则进行了详细描述,还介绍了敏捷软件开发的过程和编写代码的常用模式。
    + 《修改代码的艺术》有研究表明,软件维护成本占寿命周期费用的60%~80%,并且还有继续增加的趋势,而修改代码是软件维护中不可或缺的环节。在实际工 作系统层面的问题,作中,我们看到大约80%以上的代码,在编写时不曾顾及可测试性。如何为这些难以测试的遗留代码编写自动化单元测试,是绝大部分要实现DevOps的企业要面对的挑战。本书提供了一些模式和方法,帮助你为这些遗留代码添加自动化单元测试。
    + 《微服务架构设计模式》本书详尽地讲解了微服务实践中各种模式,并且包含大量的代码实例,对于从事微服务的开发者来说,是一本拿来即用的手册式书籍。
    + 《数据密集型应用系统设计》一本被书名耽误的书。我很喜欢的一点是这本书阐明了我们当前的应用系统面临怎样一个场景,使得我们需要解决数据密集型的问题;并且指出了在不同的部分,数据密集型这个问题会呈现出不同的场景。然后才说解决方案以及方案背后的原理。这样的撰写方式,更能帮助读者建立一条故事线来进行理解。
    + 《深入理解计算机系统》这本书曾经给过我无数次思想自由的获得感,做软件多了之后会发现很多问题其实就是操作系统层面的问题,,比如Nodejs使用到的IO多路复用，比如Kafka用到的零拷贝技术,又比如Nginx的TCP调优,这些知识虽然不能被用于日常编码,但是对于我们系统性地了解软件背后的工作原理是大有裨益的。另外,他们背后所体现的思想在所有软件中都是通用的。读完这本书之后我有一个感慨:操作系统才是软件之王呀。
    + 《演进式架构》在遗传算法中,适应度函数用来评估设计方案是否是最优的,架构的适应度函数则为架构特 征提供了客观的完整性评估。通过架构适应度函数,架构师可以识别出那些相对更加重要的架构特征,并可以将适应度函数构建到持续交付流水线中使我们能够开展引导性变更来保护这些特征。
  - 流程交付
    + 《持续交付》这是一本2013和2016版读书雷达都推荐到的书。仍然推荐,是因为内容并未过时,它截取了thoughtWorks最理想的工作画面,落成可以反复咀嚼的文字。即使在今天,也可以作为每日的团队开发纪律的参照。虽然行文啰嗦,好在细读起来,字字珠玑,这样的重复即是强调,可以接受。
    + 《凤凰项目 : 一个IT运维的传奇故事》记得看完这本书后的第一感触:毕竟想把事情做好的人还是占大多数。虽然是虚构的故事,但极具场景化的描述, 对长期从事IT一线工作的开发者和运维人员来说,极具带入感,会引起足够的共鸣。用一本厚厚的书籍讲一个精彩的故事,在这个行当里面并不多见,尤其讲清楚DevOps这回事。
    + 《代码大全》能帮助他们更好地提炼出高内聚的方法。回想起来,当我对OO还很混沌的时候,就是通过阅读《代码大全》弄懂内聚问题的。
    + 《全程软件测试(第3版)》以全局视角展示当前的软件测试全貌,虽然很多知识点都点到为止,但是可以解决读者在软件测试领域只见树木不见森林的问题。
    + 《发布!软件的设计与部署》现实世界中充满了恶意用户,无论是主观的恶意,还是那种当点击页面上的按钮无响应后又多点击了100次的并非故意的恶意。这本书交给你如何为失败而做准备,并将这些恶意的影响降低到最低。欢迎来到现实世界。
    + 《深入核心的敏捷开发――ThoughtWorks五大关键实践》ThoughtWorks一线团队并不死守教科书式好地提炼出高内聚的方法。回想起来,在 N 年上,在一线生产的热土中,反省和提炼经验,总结核心实践。本书就是这些实践的生动呈现,并且深入分析了这些实践所处的组织和管理生态,最后以企业实际所经历各个发展阶段的演进案例,以及采样丰富的行业分析,描述了这个领域从微观到宏观的动态。
    + 《Accelerate》一份研究分析报告——通过对超过2000家组织4项关键指标长达4年的追踪调研,定义了24种实现高效组织的关键能力,证明了组织绩效和软件交付效能之间存在直接关联。语言简洁易懂,是一本可以放在手边随时翻阅的手册。
 - 个人修炼
    + 《演讲的技术》世界是一个大舞台,而这正是一本教人如何表演的书。生活与工作中有太多场景我们都希望能够更好地表达自己比如:举办一场session,主持一场站会,会见一次客户,和心上人约会。自信与不自信都不是与生俱来的,每个人都需要这样一份指南来帮助自己或者别人演绎更精彩的生活。
    + 《软技能-代码之外的生存指南》程序员这个职业与其他行业本质上并没有什么不同,除了代码能力这个硬技能外,同样需要为人处世、自我营销、持续学习、保持高效等软技能。能写一手好代码决定了你的下限不会太低,但左右逢源的软技能才真正定义了你的天花板。
    + 《非暴力沟通》当听到你对我说“你这人真自私!”,我感到十分难过 。因为我需要尊重,所以你是否愿意读一下《非暴力沟通》,学习“观察、感受、需要和请求”这种非暴力沟通模式?要想让这种沟通模式达到最佳效果,需要使用书中所介绍的方法,避免让他人将你所表达的“观察”理解为“评论”,将你所传达的“感受”解读为“想法”,进而事与愿违。
    + 《转行》最近3年,我做过 TL,也做了咨询师,在有着不同子文化的项目中工作着。在这之中,我自己有很多迷茫,心理健康也一度出现了问题。这本书介绍了 “转行”,或者说在比较剧烈地切换工作背景和目标的时候,我们会遇到什么样的困难。如何重新锚定我们的职业价值,获得职业乐趣。
    + 《你要如何衡量你的人生》除了幸福,我们似乎拥有一切。可是幸福在哪里?这本书不提供答案,但却提供了寻找答案到的缜密分析运用于对个人成功和幸福的研究,总结出了可以解释其因果关系的理论。
    + 《正见：佛陀的证悟》一本直指内心的书，用极为平白的语言描述了原始佛教的四圣谛，没有任何的高深莫测或者故弄玄虚，作者用现实世界中的例子来阐述最为幽深的佛法，每个字都值得玩味。她可以让你在纷乱的现世中找到内心的平静。
    + 《深度工作》如果手头有一项工作,假设给你一个刚毕业的大学生,你要多久能培训TA做好这件工作?如果只要三个月,那么这就是个浮浅工作。如何把时间和精力投入在只有深入思考才能完成的高价值工作上
  - 认知提升
    + 《技术垄断――文化向技术投降》试图向读者描述技术何时、如何、为何成为特别危险的敌人;作者通过带领读者回顾人类进步历史的三个阶段:工具使用文化、技术统治文化和技术垄断文化来完成了这三个问题的阐述。作为软件行业的从业者,我进入此行很重要的价值观指引源自我唯科学主义的倾向(并非信仰)。本书的标题仿佛在挑战我一直以来的处世哲学,庆幸的是我没有避开它,阅读此书使我从时代的背景思考了为什么崇尚技术的想法会优先吸引自己,为什么欣赏艺术仍然是我生活中不可或缺的一部分。
    + 《智能时代》大数据和机器智能的出现,对我们的技术发展、商业和社会都会产生重大的影响。作者吴军指出,我们在过去认为非常难以解决的问题,会因为大数据和机器智能的使用而迎刃而解,比如解决癌症个性化治疗的难题。同时,大数据和机器智能还会彻底改变未来的商业模式,很多传统的行业都将采用智能技术实现升级换代,同时改变原有的商业模式。
    + 《升维:争夺产品认知高地的战争》从认知格局、体系和方法论三个层面为产品认知提供科学指导。适合产品经理、顾问阅读,书中有非常多的事例引用,书的结构也循序渐进,从注重能力向注重认知转变的产品管理方法,并且通过提升对解决方案的认知,讲述如何建立客户信任并形成合作关系的系统性方法。
    + 《大教堂与集市》读过《人月神话》以及《Just for Fun》《Free as in Freedom》这两本Linus与Richard的传记,可以再读一读《大教堂与集市》,或许能为你打开全新的视野。有人说这是一本“可以和《人月神话》齐名的软件项目管理书籍”,或者说是对传统软件开发管理方法的一种批判性思考,探究“开源社区”为软件开发提供的另一种协作模式。
    + 《团队协作的五大障碍》书的一开始就提到:最根本的竞争优势既不是来自资本实力、发展战略,也不是来自技术,而是来自团队协作,因为团队协作能力是非常强大而且弥足珍贵的。本书用小说的笔法讲述了团队协作中五个普遍而又危险的问题:缺乏信任、惧怕冲突、欠缺投入、逃避责任、无视结果。通过认识团队的人性化特点,团队成员就可以克服人性的弱点,建立信任,进行有益的争论,全力投入,注重集体成绩,从而取得成功。推荐团队中的每一位小伙伴阅读。
    + 《论大战略》书里没有讲很多抽象深奥的理论,而是从2500年前的波希战争开始,写到20世纪的第二次世界大战;从地中海的罗马领袖,写到改变美洲新大陆的美国总统。用一个个清晰生动的例子讲解谁是好的战略家,谁是差的战略家,谁能平衡目标和能力,谁又能敏锐的捕捉到环境的变化作出调整。
    + 《复杂》这是一本提升认知的书。我们在理解代码的世界之外,还需要理解复杂的现实世界。作者渊博的多学科背景经验给了读者一次跨越认知的机会,从混沌学,到统计力学,到信息论,到计算科学,到进化论,到现代综合,到遗传学,到度量方法,再到网络科学。更重要的是,本书或者说复杂系统对于其他领域和现象的启示。
  - 新兴技术
    + 《零信任网络:在不可信网络中构建安全系统》介绍了一个理想的现代安全模型框架,包含了大量极具价值的实战经验。虽然,从某种意义上来说,它看上去更像是一本DevOps/Ops或者是信息安全方面的书籍,但是总的来说,我从中学到了一些之前不了解的网络相关的知识。这本书从我们熟悉的 DMZ 区(Demilitarized Zone,隔离区)讲起,介绍了DMZ潜在的种种风险
    + 《Mastering Bitcoin》需要掌握比特币的所有知识都在这本书中。从白皮书到源码片段,从POW到UTXO,你想了解的所有比特币底层原理,都可以在这里找到引述。
    + 《深度学习》适合各类读者阅读,包括相关专业的大学生或研究生,以及不具有机器学习或统计背景、但是想要快速补充深度学习知识,以便在实际产品或平台中应用的软件工程师。
    + 《代码本色:用编程模拟自然系统》这本书用Processing代码来模拟自然系统,作者在GitHub上也提供了p5js移植版源码。

![Alt text](../_static/dev_book.png "Optional title")

## 参考

* [DZone](http://www.dzone.com)
* [Stackoverflow](http://stackoverflow.com/)
* [30-seconds-of-code](https://github.com/30-seconds/30-seconds-of-code)：Curated collection of useful Javascript snippets that you can understand in 30 seconds or less. <https://30secondsofcode.org/>
* [be-a-professional-programmer](https://github.com/stanzhai/be-a-professional-programmer):成为专业程序员路上用到的各种优秀资料、神器及框架 <http://tools.stanzhai.site>
* [how to be a Programmer](https://github.com/braydie/HowToBeAProgrammer) <https://braydie.gitbooks.io/how-to-be-a-programmer/content/zh/>
* [Qix](https://github.com/ty4z2008/Qix)Machine Learning、Deep Learning、PostgreSQL、Distributed System、Node.Js、Golang ty4z2008.github.io/qix
* [professional-programming](https://github.com/charlax/professional-programming):A collection of full-stack resources for programmers.
* [todomvc](https://github.com/tastejs/todomvc)Helping you select an MV* framework - Todo apps for React.js, Ember.js, Angular, and many more <http://todomvc.com/>
* [tech](https://github.com/hedengcheng/tech):programming, database, distributed systemee
* [What every computer science major should know](http://matt.might.net/articles/what-cs-majors-should-know/)
  - 个人来说，作品集（Portfolio）会比简历（Resume）更有参考意义
  - 计算机专业工作者也要学会与人交流的技巧，包括如何写演示文稿，以及面对质疑时如何与人辩论的能力
  - 所需要的硬技能：工程类数学、Unix 哲学和实践、系统管理、程序设计语言、离散数学、数据结构与算法、计算机体系结构、操作系统、网络、安全、密码学、软件测试、用户体验、可视化、并行计算、软件工程、形式化方法、图形学、机器人、人工智能、机器学习、数据库等等
  - [every-programmer-should-know](https://github.com/mr-mig/every-programmer-should-know):A collection of (mostly) technical things every software developer should know
* [Teach Yourself Programming in Ten Years](http://norvig.com/21-days.html)
* [97 Things Every Programmer Should Know](https://97-things-every-x-should-know.gitbooks.io/97-things-every-programmer-should-know)
* [learn-anything](https://github.com/learn-anything/learn-anything):Search Interactive Maps to Learn Anything <https://learn-anything.xyz>
* [easy-tips](https://github.com/TIGERB/easy-tips):A little Tips in my Code Career with PHP&Go 🐘 <http://easy-tips.tigerb.cn>
* [Tutorials & training to grow your development skills](https://www.ibm.com/developerworks/learn/)
* [Best-websites-a-programmer-should-visit](https://github.com/sdmg15/Best-websites-a-programmer-should-visit)

## 编程：Google: github awesome talks

* [programming-talks](https://github.com/hellerve/programming-talks):Awesome & interesting talks about programming
* [Inventing on Principle (2012)](https://vimeo.com/36579366):用真正的「幻灯片」，讨论未来
* [The future of programming (2013)](https://vimeo.com/71278954):优秀的工具是如何能够帮助人们思考和创造
* Rich Hickey:clojure 的创始人，十多年来他为社区贡献了很多经典的演讲
  - Are we there yet? (2009)：包含后面两个主题（simplicity, value）的讲座，醍醐灌顶。
  - Simple made easy（2011）：大道至简。Rich 介绍了简约和简单的区别 —— do one thing and do it well。我们很容易设计出复杂的系统，却很难剥茧抽丝，设计出简约富有美感的系统。
  - the value of values（2012）：醍醐灌顶的讲座。Rich 喜好从事物的本源和基本属性出发，来探究那些我们自以为懂却没弄懂的内容。什么是 value？value 和 place 如何 decouple，如果我们在代码中都能使用 value，我们有何收益等。
  - The language of the system (2013)：提到了 machine 的概念，以及 transform，move，route 等让人赏心悦目的函数式编程的思想。如果对做 system 感兴趣，这个讲座一定不要错过。
  - Transducers（2014）：哈，transform，map/reduce 就听过，transducer 是什么鬼？这个讲座可以主要关注其产生 transducer 的思想。
  - Persistent Data Structures and Managed References（2019）：immutable 背后的数据结构。来源于 Chris Okasaki 的 “Purely Functional Data Structures”。其实好多人讲过这个，比如 2017 CppCon 的 Postmodern immutable data structures，还有早期 react 的作者。
* Joe Armstrong
  - the mess we’re in（2014）：介绍了一些有趣的 history，讲了 name，causality，simultanuity 和 entropy。
  - The Forgotten Ideas in Computer Science (2018)：这个视频有些琐碎，不感兴趣的地方可以高倍速播放
* [Forget Velocity, Let’s Talk Acceleration（2017）](https://www.youtube.com/watch?v=Lbcyyu8XB_Y)
* [Railway oriented programming（2014）](https://vimeo.com/113707214)
* [Functional Design Patterns (2017)](https://www.youtube.com/watch?v=srQt1NAHYC0)
* [Architecture the Lost Years（2011）](https://www.youtube.com/watch?v=WpkDN78P884)
* [The Future of Programming（2016）](https://www.youtube.com/watch?v=ecIWPzGEbFc)


## 工具

* [bazel](https://github.com/bazelbuild/bazel):a fast, scalable, multi-language and extensible build system <https://bazel.build>
* [semantic](https://github.com/github/semantic):Parsing, analyzing, and comparing source code across many languages
* [gaia](https://github.com/gaia-pipeline/gaia):Build powerful pipelines in any programming language.

* [free-for-dev](https://github.com/ripienaar/free-for-dev):A list of SaaS, PaaS and IaaS offerings that have free tiers of interest to devops and infradev <https://free-for.dev/>
* [carbon](https://github.com/dawnlabs/carbon):🎨 Create and share beautiful images of your source code <https://dawnlabs.io/carbon>
* [learnxinyminutes-docs](https://github.com/adambard/learnxinyminutes-docs):Code documentation written as code! How novel and totally my idea! <http://learnxinyminutes.com/>
* [Programming-Alpha-To-Omega](https://github.com/justjavac/Programming-Alpha-To-Omega):从零开始学编程 系列汇总（从 α 到 Ω）
* [codelf](https://github.com/unbug/codelf):Best GitHub stars, repositories tagger and organizer. Search over projects from Github, Bitbucket, Google Code, Codeplex, Sourceforge, Fedora Project, GitLab to find real-world usage variable names <https://unbug.github.io/codelf/>
* [prettier](https://github.com/prettier/prettier):Prettier is an opinionated code formatter. <https://prettier.io>
* [the_silver_searcher](https://github.com/ggreer/the_silver_searcher):A code-searching tool similar to ack, but faster. <http://geoff.greer.fm/ag/>
* [codimd](https://github.com/hackmdio/codimd):CodiMD - Realtime collaborative markdown notes on all platforms.
* cheatsheet
  - [cheatsheets](https://github.com/rstacruz/cheatsheets):My cheatsheets <https://devhints.io>
  - [cheat.sh](https://github.com/chubin/cheat.sh):the only cheat sheet you need <https://cheat.sh/>
  * [Rico's cheatsheets](https://devhints.io/)
  - [awesome-cheatsheet](https://github.com/detailyang/awesome-cheatsheet)🍻 awesome cheatsheet

## 资源

* [learndesignthehardway](https://www.learndesignthehardway.com)
* [arl](https://github.com/kaxap/arl) lists of most popular repositories for most favoured programming languages
* [freeCodeCamp](https://github.com/freeCodeCamp/freeCodeCamp):The <https://freeCodeCamp.org> open source codebase and curriculum. Learn to code for free together with millions of people.
* [Best-websites-a-programmer-should-visit](https://github.com/sdmg15/Best-websites-a-programmer-should-visit):🔗 Some useful websites for programmers.