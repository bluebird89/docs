# Interview



## Job

个人价值最大化。那么，你要选择一个自己能够接触到的、完全竞争的、短流程的渠道，利用你的算法技术和对业务的理解实现变现的过程。

需要有一个承载的产品，而产品研发的过程是非常漫长的。同样地，自动驾驶算法需要汽车生产场商的实验。用户行为分析算法，需要电子商务平台的以用户购买行为进行验证。

* 上级的技术能力
* 安排合理的流程
* 平静空间
* 更多的书面交流
* 师友关系：职业发展、技术成长
* 最好的设备

## 方向

* web：前后端并不是对立的，而是纯粹的一家人。只是被国内外的一些市场强行分成了前后端，归根到底，是需要前后端都懂得
* 算法相关岗位(深度学习、计算机视觉等)
* 数据相关岗位：可视化是整个数据链路最外层，最后走高P还是需要理解整个链路层的。数据研发这个是在web开发的基础上用数据附能，懂可视化的一定是有前端能力的，懂hadoop的一定java玩的溜，属于web开发的拓展方向。
* 图形学相关岗位（比如网易开发游戏引擎的大牛等）
* 大规模系统的底层相关（阿里云）
* 安全相关


## 技能点

* Python语法以及其他基础部分
    1.可变与不可变类型；
    2.浅拷贝与深拷贝的实现方式、区别；deepcopy如果你来设计，如何实现；
    3.__new__() 与 __init__()的区别；
    4.你知道几种设计模式；
    5.编码和解码你了解过么；
    6.列表推导list comprehension和生成器的优劣；
    7.什么是装饰器；如果想在函数之后进行装饰，应该怎么做；
    8.手写个使用装饰器实现的单例模式；
    9.使用装饰器的单例和使用其他方法的单例，在后续使用中，有何区别；
    10.手写：正则邮箱地址；
    11.介绍下垃圾回收：引用计数/分代回收/孤立引用环；
    12.多进程与多线程的区别；CPU密集型适合用什么；
    13.进程通信的方式有几种；
    14.介绍下协程，为何比线程还快；
    15.range和xrange的区别（他妹的我学的py3…）；
    16.由于我有C/C++背景，因此要求用C来手写：将IP地址字符串（比如“172.0.0.1”）转为32位二进制数的函数。

* 数据结构与算法
    1.手写快排；堆排；几种常用排序的算法复杂度是多少；快排平均复杂度多少，最坏情况如何优化；
    2.手写：已知一个长度n的无序列表，元素均是数字，要求把所有间隔为d的组合找出来，你写的解法算法复杂度多少；
    3.手写：一个列表A=[A1，A2，…,An]，要求把列表中所有的组合情况打印出来；
    4.手写：用一行python写出1+2+3+…+10**8 ；
    5.手写python：用递归的方式判断字符串是否为回文；
    6.单向链表长度未知，如何判断其中是否有环；
    7.单向链表如何使用快速排序算法进行排序；
    8.手写：一个长度n的无序数字元素列表，如何求中位数，如何尽快的估算中位数，你的算法复杂度是多少；
    9.如何遍历一个内部未知的文件夹（两种树的优先遍历方式）

* 网络基础部分
    1.TCP/IP分别在模型的哪一层；
    2.socket长连接是什么意思；
    3.select和epoll你了解么，区别在哪；
    4.TCP UDP区别；三次握手四次挥手讲一下；
    5.TIME_WAIT过多是因为什么；
    6.http一次连接的全过程：你来说下从用户发起request——到用户接收到response；
    7.http连接方式。get和post的区别，你还了解其他的方式么；
    8.restful你知道么；
    9.状态码你知道多少，比如200/403/404/504等等；

* 数据库部分：
    - MySQL索引优化、查询优化和存储优化
    - MySQL数据库设计、管理和优化，具备数据库规划能力
    - MySQL锁有几种；死锁是怎么产生的；
    - 为何，以及如何分区、分表；
    - MySQL的char varchar text的区别；
    - 了解join么，有几种，有何区别，A LEFT JOIN B，查询的结果中，B没有的那部分是如何显示的（NULL）；
    - 索引类型有几种，BTree索引和hash索引的区别（我没答上来这俩在磁盘结构上的区别）；
    - 手写：如何对查询命令进行优化；
    - NoSQL了解么，和关系数据库的区别；
    - redis有几种常用存储类型；
    - 非关系型数据库（Redis，Memcached）

* Linux部分
    1.讲一下你常用的Linux/git命令和作用；
    2.查看当前进程是用什么命令，除了文件相关的操作外，你平时还有什么操作命令；（因为我本人Linux本身就很水，只会基本的操作，所以这部分面试官也基本没怎么问。。反正问了就大眼瞪小眼呗）
    - Shell编程

* django项目部分
    1.都是让简单的介绍下你在公司的项目，不管是不是后端相关的，主要是要体现出你干了什么；
    2.你在项目中遇到最难的部分是什么，你是怎么解决的；
    3.你看过django的admin源码么；看过flask的源码么；你如何理解开源；
    4.MVC / MTV；
    5.缓存怎么用；
    6.中间件是干嘛的；
    7.CSRF是什么，django是如何避免的；XSS呢；
    8.如果你来设计login，简单的说一下思路；
    9.session和cookie的联系与区别；session为什么说是安全的；
    10.uWSGI和Nginx的作用；

* 大流量与并发
* 分布式、集群
* 高并发、高负载、高可用系统
* 运维
    - devops理念，愿意用自动化、规范化的方式
* 缓存
* 队列
    - rabbitmq
* 架构
    - 设计模式
    - 重构
    - 架构设计

* 硬性
    - 必须4年以上工作经验
    - 教育经历要求计算机科学专业
    - 要求统招本科学历
    - 年龄要求必须小于32岁
    - 稳定性必须稳定性好
* Web技术栈、包括HTTP协议、Web安全、静态化设计、前后端分离架构；


## 习惯

* 每年一定要拿出两个月出去面试——不管你要不要走。需要不断评估自己的价格，和发现自己身上的缺点及时弥补。
* 你的价格是市场决定的，而不是你的能力。
* 真正让你成为Java大牛的是你懂的不同语言的哲学，懂得不同场景下发挥出Java的优势，规避Java的劣势，深知Java的优缺点。而不是抱着Java是最好的语言，写一辈子Java。
* 在Web这条线上想走到高P，基本上都是走业务架构这条路，这考验的就是大局观了。你只会一个前端或者一个Java根本不够格。纯粹研究技术上P10的基本上属于蜀道难了——说的清楚点，对于传统的Web开发工程师（前后端）不通过管理走高P基本上只有往架构方向走，这个时候靠的是你全面的能力和良好的大局观,你当初的那些前端技术、后端技术就是个敲门砖。

## 案例

张丹：从程序员开始，到架构师一路走来，经历过太多的系统和应用。做过手机游戏，写过编程工具；做过大型Web应用系统，写过公司内部CRM；做过SOA的系统集成，写过基于Hadoop的大数据工具；做过外包，做过电商，做过团购，做过支付，做过SNS，也做过移动SNS。以前只用Java，然后学了PHP，现在用R和Javascript。最后跳出IT圈，进入金融圈，研发量化交易软件。

# Remote Job

整个 Github 公司有 60% 的员工是在家里远程办公。新员工培训：在公司内的聊天室内，静静地看别人聊天，体会一下别人是如何工作的

## 资源

* [yangshun/tech-interview-handbook](https://github.com/yangshun/tech-interview-handbook):💯 Algorithms, front end and behavioral content for rocking your coding interview 🆕 Interview Cheatsheet! 🆕
* [jwasham/coding-interview-university](https://github.com/jwasham/coding-interview-university):A complete computer science study plan to become a software engineer.
* [jdsutton/Technical-Interview-Megarepo](https://github.com/jdsutton/Technical-Interview-Megarepo):Study materials for SE/CS technical interviews
* [h5bp/Front-end-Developer-Interview-Questions](https://github.com/h5bp/Front-end-Developer-Interview-Questions):A list of helpful front-end related questions you can use to interview potential candidates, test yourself or completely ignore.
* [arialdomartini/Back-End-Developer-Interview-Questions](https://github.com/arialdomartini/Back-End-Developer-Interview-Questions):A list of helpful back-end related questions you can use to interview potential candidates, test yourself or completely ignore.
* [MaximAbramchuck/awesome-interview-questions](https://github.com/MaximAbramchuck/awesome-interview-questions)::octocat: A curated awesome list of lists of interview questions. Feel free to contribute! 🎓 https://github.com/BotCube/awesome-bots
* [kdn251/interviews](https://github.com/kdn251/interviews):Everything you need to know to get the job.
* [ElemeFE/node-interview](https://github.com/ElemeFE/node-interview):How to pass the Node.js interview of ElemeFE.
* [alex/what-happens-when](https://github.com/alex/what-happens-when):An attempt to answer the age old interview question "What happens when you type google.com into your browser and press enter?"
* [kamranahmedse/developer-roadmap](https://github.com/kamranahmedse/developer-roadmap):Roadmap to becoming a web developer in 2018

## 工具

* [salomonelli/best-resume-ever](https://github.com/salomonelli/best-resume-ever):Build fast 🚀 and easy multiple beautiful resumes and create your best CV ever! Made with Vue and LESS.
- [lukasz-madon/awesome-remote-job](https://github.com/lukasz-madon/awesome-remote-job)
