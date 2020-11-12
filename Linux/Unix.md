# Unix

## 起源

* MULTICS（Multiplexed Information and Computing Service）的项目
    - 上世纪六十年代时，大部份计算机都是采用批处理（Batch Processing）的方式（也就是说，当作业积累一定数量的时候，计算机才会进行处理）
    - 美国电话及电报公司（American Telephone and Telegraph Inc.；AT&T）、通用电器公司（General Electrics；G.E.）及麻省理工学院（Massachusetts Institute of Technology；MIT）计划合作开发一个多用途（General-Purpose）、分时（Time-Sharing）及多用户（Multi-User）的操作系统，也就是这个MULTICS，其被设计运行在GE-645大型主机上
    - 这个项目由于太过复杂，整个目标过于庞大，糅合了太多的特性，进展太慢，几年下来都没有任何成果，而且性能都很低。于是到了1969年2月，贝尔实验室（Bell Labs）决定退出这个项目
* 贝尔实验室中的有个叫Ken Thompson的人，他为MULTICS这个操作系统写游戏了个叫“Space Travel”的游戏，在MULTICS上经过实际运行后，他发现游戏速度很慢而且耗费昂贵 —— 每次运行会花费75美元
* 退出这个项目以后。他为了让这个游戏能玩，所以他找来Dennis Ritchie为这个游戏开发一个极其简单的操作系统。这就是后来的Unix（值得一提的是，当时他们本想在DEC-10上写，后来没有申请到，只好在实验室的墙角边找了一台被人遗弃的Digital PDP-7的迷你计算机进行他们的计划，这台计算机上连个操作系统都没有，于是他们用汇编语言仅一个月的时间就开发了一个操作系统的原型）
* 他们的同事Brian Kernighan非常不喜欢这个系统，嘲笑Ken Thompson说：“你写的系统好真差劲，干脆叫Unics算了。”Unics的名字就是相对于MULTICS的一种戏称，后业改成了Unix。于是，Unix就在这样被游戏和玩笑创造了，当时是1969年8月。也就是这一年，Linux之父Linus Torvalds在芬兰出生了
* 历史起始于二十世纪六十年代的AT&T贝尔实验室，一小组程序员正在为PDP-7编写多任务、多用户操作系统。在贝尔实验室研究机构的这个小组里有两位最知名的人物，ken Thompson和Dennis Ritchie
* 尽管Unix的许多概念继承于它的先驱Multics，但在二十世纪八十代早期Unix小组用C语言重写这个小型操作系统的决定使得Unix与其它的系统区别开来。只有几百个系统调用，秉承一切皆文件的设计思想。那个时候的操作系统很少是可移植的。相反，由于先天的设计和底层源语言，那些操作系统和所被授权运行的硬件平台紧密地联系在一起。通过使用C语言重构Unix，现在Unix可以被移植到许多硬件平台
* 1971年，Ken Thompson写了充分长篇的申请报告，申请到了一台PDP-11/24的机器。于是Unix第一版出来了。在一台PDP-11/24的机器上完成。这台电脑只有24KB的物理内存和500K磁盘空间。Unix占用了12KB的内存，剩下的一半内存可以支持两用户进行Space Travel的游戏。而著名的fork()系统调用也就是在这时出现的
* 1973年的时候，Ken Thompson 与Dennis Ritchie感到用汇编语言做移植太过于头痛，他们想用高级语言来完成第三版，对于当时完全以汇编语言来开发程序的年代，他们的想法算是相当的疯狂。一开始他们想尝试用Fortran，可是失败了。后来他们用一个叫BCPL（Basic Combined Programming Language）的语言开发，他们整合了BCPL形成B语言，后来Dennis Ritchie觉得B语言还是不能满足要求，就是就改良了B语言，这就是今天的大名鼎鼎的C语言。于是，Ken Thompson 与Dennis Ritchie成功地用C语言重写了Unix的第三版内核。至此，Unix这个操作系统修改、移植相当便利，为Unix日后的普及打下了坚实的基础。而Unix和C完美地结合成为一个统一体，C与Unix很快成为世界的主
* Unix的第一篇文章 “The UNIX Time Sharing System”由Ken Thompson和Dennis Ritchie于1974年7月的 the Communications of the ACM发表。这是UNIX与外界的首次接触。结果引起了学术界的广泛兴趣并对其源码索取，所以，Unix第五版就以“仅用于教育目的”的协议，提供给各大学作为教学之用，成为当时操作系统课程中的范例教材。各大学公司开始通过Unix源码对Unix进行了各种各样的改进和扩展。于是，Unix开始广泛流行
* 除了这个新的可移植移能力，有几个对于用户和程序员来说很有吸引力的操作系统设计的关键点使得Unix扩张到除贝尔实验室以外的其它领域，如研究、学术甚至商业用途
* 关键点一，Ken Thompson的Unix哲学成为了模块化软件设计和计算的强有力的典范
* Unix哲学建议使用小规模的为特定目的构建的程序的结合体来处理复杂的总体任务。由于Unix是围绕着文件和管道设计的，这个"piping（管道)“模型至今仍然很流行，把程序的输入和输出链接在一起作为一系列的线性输入操作。实际上，当今的函数即服务（FaaS）/无服务器计算模型要更多地归功于对Unix哲学的继承
* 在20世纪70和80年代末，Unix成为了族谱的根，族谱扩展到研究届、学术届和不断增长的商业Unix操作系统业务。Unix不是开源软件，Unix源码可以与它的拥有者AT&T通过协议获得许可证。第一个已知的软件许可证在1975年卖给了伊利诺伊大学
* Unix在学术界发展迅速，随着伯克利成为重要的活动中心，在70年代给了Ken Thompson一个学术休假。通过在伯克利的Unix的所有活动，一个新的Unix软件支付诞生了：伯克利软件发行版，或者叫BSD。最初，BSD并不是AT&T的Unix的代替品，而是附加软件和功能附加品。直到1979年的2BSD（第二Berkeley软件发型版）,伯克利研究生Bill Joy已经添加了现在知名的程序，例如vi和C shell（/bin/csh）
* 除了BSD成为了Unix家族中最受欢迎的分支之一，Unix的商业产品在20世纪80年代和90年代激增，包括HP-UX、IBM的AIX、Sun的Solaris、Sequent和Xenix。随着分支从最初的根开始增长，“Unix战争”开始了，标准化成为了社区的一个新焦点。POSIX标准诞生于1988年，以及其他开源工作组的标准化工作一直进行到到20世纪90年代
* BSD可能是当今所有现代Unix系统中最大的安装基础。此外，在最近的历史中，每一个苹果Mac硬件单元搭载的系统都可以被称为BSD，因为它的OS X（现在的macOS）操作系统是一个BSD-派生
* Unix的BSD分支是开源的，而NetBSD、OpenBSD和FreeBSD都有强大的用户群和开源社区

## 分裂

* 1978年，对 Unix而言是革命性的一年；因为学术界的老大柏克利大学 （UC Berkeley），推出了一份以第六版为基础，加上一些改进和新功能而成的 Unix。这就是著名的“1 BSD（1st Berkeley Software Distribution）”，开创了Unix的另一个分支：BSD 系列。
* 同时期，AT&T成立USG（Unix Support Group），将 Unix变成商业化的产品。从此，BSD的 Unix 便和AT&T 的Unix 分庭抗礼，Unix就分为System IV和4.x BSD这两大主流，各自蓬勃发展
* 1979年发布的Unix 第七版被称为是“最后一个真正的Unix”，这个版本的Unix内核只有40K bytes。后来这个版本被移植到VAX机上（我在大学时学习C语言时用过这个VAX机，我还记得那时上VAX机最大的爱好就是使用talk命令和别人聊天，呵呵）。20世纪80年代相继发布的8、9、10版本只授权给了少数大学
* 1982年，AT&T基于版本7开发了UNIX System Ⅲ的第一个版本，这是一个商业版本仅供出售。为了解决混乱的UNIX版本情况，AT&T综合了其他大学和公司开发的各种UNIX，开发了UNIX System V Release 1。这个新的UNIX商业发布版本不再包含源代码，所以加州大学Berkeley分校继续开发BSD UNIX，作为UNIX System III和V的替代选择。BSD对UNIX最重要的贡献之一是TCP/IP。BSD 有8个主要的发行版中包含了TCP/IP：4.1c、4.2、4.3、4.3-Tahoe、4.3-Reno、Net2、4.4以及 4.4-lite。这些发布版中的TCP/IP代码几乎是现在所有系统中TCP/IP实现的前辈，包括AT&T System V UNIX 和Microsoft Windows中的TCP/IP都参照了BSD的源码
* 同时，其他一些公司也开始为其自己的小型机或工作站提供商业版本的UNIX系统，有些选择System V作为基础版本，有些则选择了BSD。BSD的一名主要开发者，Bill Joy，在BSD基础上开发了SunOS，并最终创办了Sun Microsystems
* 1991年，一群BSD开发者（Donn Seeley、Mike Karels、Bill Jolitz 和 Trent Hein）离开了加州大学，创办了Berkeley Software Design, Inc (BSDI)。BSDI是第一家在便宜常见的Intel平台上提供全功能商业BSD UNIX的厂商。后来Bill Jolitz 离开了BSDI，开始了386BSD的工作。386BSD被认为是FreeBSD、OpenBSD 和 NetBSD、DragonFlyBSD的先辈
* 这是一个AT&T妄图私有化的Unix的时代。为了私有化Unix，1986年IEEE指定了一个委员会制定了一个一个开放作业系统的标准,称为 POSIX (Portable Operating Systems Interface)。最后加上个X，不知道是为了好听，还是因为这本质上是UNIX的标准。当然，AT&T的Unix取得了这个标准制订战争的胜利，还取得了Unix这个注册商标。此时BSD的拥护者自喻为冷酷无情的公司帝国的反抗军。就销售量来说，AT&T UNIX始终赶不上BSD/Sun。到1990年，AT&T与BSD版本已难明显区分，因为彼此都有采用对方的新发明.这段时期，从实验室出来的被全世界所分享的Unix，正处于被私有化的关键时期。

## 法律纠纷

*  Berkeley Software Design, Inc（BSDI）很快就与AT&T的UNIX Systems Laboratories（USL）附属公司产生了法律纠纷，USL是AT&T注册的公司。AT&T为了拥有System V版权，以及Unix商标，为了垄断Unix，1992年，USL正式对BSDI提起诉讼，说BSD剽窃他的源码。而最终了结了好评如潮的BSD系统
* 由于最后判决悬而未决，这桩法律诉讼将BSD后裔的开发，特别是自由软件，延迟了两年，这导致没有法律问题的Linux内核获得了极大的支持。Linux跟386BSD的开发几乎同时起步，Linus说，当时如果有自由的基于386的Unix-like操作系统，他就可能不会创造Linux。尽管无法预料这给以后的软件业究竟造成了什么样的影响（如果没有这个法律纠纷，很有可能没有今天的革命性的Linux），但有一点可以肯定，Linux更加丰富了这块土壤
* 这场官司一直打到 AT&T将自己的Unix系统实验室卖掉，新接手的Novell公司采取了一种比较开明的做法，允许BSDI自由发布自己的BSD，但是前提是必须将来自于AT&T的代码完全删除，于是诞生了4.4 BSD Lite版，由于这个版本不存在法律问题，4.4BSD Lite成为了现代BSD系统的基础版本
* 这桩诉讼最终在1994年1月了结，更多地满足了BSDI的利益。伯克利套件的18,000个文件中，只有3个文件要求删除，另有70个文件要求修改，并显示USL的版权说明。这项调解另外要求，USL不得对4.4BSD提起诉讼，不管是用户还是BSDI代码的分发者。于是，BSD Unix走上了复兴的道路。BSD的开发也走向了几个不同的方向，并最终导致了FreeBSD、OpenBSD和NetBSD的出现
* 从AT&T意识到了Unix的商业价值，不再将Unix源码授权给学术机构以来，到以后的几十年，Unix仍在不断变化，其版权所有者不断变更，授权者的数量也在增加。Unix的版权曾经为AT&T所有，之后Novell拥有了Unix，再之后Novell又将版权出售给了SCO（这一事实双方尚存在争议）。有很多大公司在取得了Unix的授权之后，开发了自己的Unix产品。（几年前，据传闻微软为了限制Linux，微软让SCO到法院告Linux剽窃其源码）
* 由于Unix是由C语言写的，所以修改和移植都很容易，因此，很多商业公司及学术机构均加入这个操作系统的研发，各个不同版本的Unix也开始蓬勃发展。这才产生了今天这么多的各式各样的Unix衍生产品。如AIX、Solaris、HP-UX、IRIX、OSF、Ultrix等等.（这些商业化的Unix基本上都是源于AT&T授权的Unix System V）

## 开源组织

* AT&T的这种商业态度，让当时许许多的Unix的爱好者和软件开发者们感到相当的痛心和忧虑，他们认为商业化的种种限制并不利于产生的发展，相反还能导制产品出现诸多的问题。随着商业化Unix的版本的种种限制和诸多问题，引起了大众的不满和反对。于是，大家开始有组织地结成“反叛联盟”以此对抗欺行罢市的AT&T等商业化行为。
* 另一方面，关于“大教堂”（集权、封闭、受控、保密）和“集市”（分权、公开、精细的同僚复审）两种开发模式的对比成为了新思潮的中心思想。这个新思潮对IT业产生了非常深远影响。为整个计算机世界带来了革命性的价值观。
* ，一个名叫Richard Stallman的领袖出现了，他认为Unix是一个相当好的操作系统，如果大家都能够将自己所学贡献出来，那么这个系统将会更加的优异！他倡导的Open Source的概念，就是针对Unix这一事实反对实验室里的产品商业化私有化。尽管Stallman既不是、也从来没有成为一个Unix程序员，但在后1980的大环境下，实现一个仿Unix操作系统成了他追求的明确战略目标。Richard Stallman早期的捐助者大都是新踏入Unix土地的老牌ARPANET黑客，他们对代码共享的使命感甚至比那些有更多Unix背景的人强烈。
* 为了这个理想，Richard Stallman于1984年创业了GNU，计划开发一套与Unix相互兼容的的软件。1985 年 Richard Stallman 又创立了自由软件基金会（Free Software Foundation）来为 GNU 计划提供技术、法律以及财政支持。尽管 GNU 计划大部分时候是由个人自愿无偿贡献，但 FSF 有时还是会聘请程序员帮助编写。当 GNU 计划开始逐渐获得成功时，一些商业公司开始介入开发和技术支持。当中最著名的就是之后被 Red Hat 兼并的 Cygnus Solutions。
* GNU组织的建立，延续了当年Unix刚出现时的情形，并为这种情形建立了可靠的法律和财务保障。GNU 工程十几年以来, 已经成为一个对软件开发主要的影响力量， 创造了无数的重要的工具。例如：强健的编译器，有力的文本编辑器，甚至一个全功能的操作系统。从那时开始，许多程序员聚集起来开始开发一个自由的、高质量、易理解的软件，让这使得Unix社区生机勃勃，一派繁荣景象。
* 自90年代发起这个计划以来，GNU 开始大量的产生或收集各种系统所必备的组件，像是——函数库（libraries）、编译器（compilers）、调式工具（debugs）、文本编辑器（text editors）、网站服务器（web server），以及一个Unix的使用者接口（Unix shell）等等，等等。但由于种种原因，GNU一直没有开发操作系统的kernel。正当Richard Stallman在为操作系统内核伤脑筋的时候，Linux出现了

## Linux横空出世

* 1990年，Linus Torvalds还是芬兰赫尔辛基大学的一名学生，最初是用汇编语言写了一个在80386保护模式下处理多任务切换的程序，后来从Minix（Andy Tanenbaum教授所写的很小 的Unix操作系统,主要用于操作系统教学）得到灵感，进一步产生了自认为狂妄的想法——写一个比Minix更好的Minix，于是开始写了一些硬件的设备驱动程序，一个小的文件系统。这样0.0.1版本的Linux就出来了，但是它只具有操作系统内核的勉强的雏形，甚至不能运行，你必须在有Minix的机器上编译以后才能玩。这时候Linus已经完全着迷而不想停止，决定踢开Minix，于是在1991年10 月5号发布Linux 0.0.2版本,在这个版本中已经可以运行bash 和gcc。
* 从一开始，Linus就决定自由扩散Linux，包括原代码，随即Linux引起黑客们（hacker）的注意，通过计算机网络加入了Linux的内核开发。Linux倾向于成为一个黑客的系统——直到今天，在Linux社区里内核的开发被认为是真正的编程。由于一批高水平黑客的加入，使Linux 发展迅猛，几乎一两个礼拜就有新版或修正版的出现，到1993年底94年初，Linux 1.0终于诞生了！Linux 1.0已经是一个功能完备的操作系统，而且内核写得紧凑高效，可以充分发挥硬件的性能，在4M内存的80386机器上也表现得非常好，至今人们还在津津乐道。时至今日，kernel的版本已经出到2.6。Linux的发展不像传统的软件工程，它完全是透过网络，集合世界各地的高手而成的一套操作系统，在这里我们也可以见识到网络快速传播的威力。Linux初次让整个世界感觉到了开源力量和网络力量的如此强大。（Linux 的标志和吉祥物是一只名字叫做 Tux 的 企鹅，标志的由来是因为Linus在澳洲时曾被一只动物园里的企鹅咬了一口，便选择了企鹅作为Linux的标志。）
* Linux 的历史是和GNU紧密联系在一起的。从1983年开始的GNU计划致力于开发一个自由并且完整的类Unix操作系统，包括软件开发工具和各种应用程序。到1991年 Linux 内核发布的时候，GNU已经几乎完成了除了系统内核之外的各种必备软件的开发。在 Linus Torvalds 和其它开发人员的努力下，GNU组件可以运行于Linux内核之上。整个内核是基于 GNU 通用公共许可，也就是GPL（GNU General Public License，GNU通用公共许可证）的，但是Linux内核并不是GNU 计划的一部分。1994年3月，Linux1.0版正式发布，Marc Ewing成立了 Red Hat 软件公司，成为最著名的 Linux 分销商之一。
* 严格来讲，Linux这个词本身只表示Linux内核，但在实际上人们已经习惯了用Linux来形容整个基于Linux内核，并且使用GNU 工程各种工具和应用程序的操作系统(也被称为GNU/Linux)。基于这些组件的Linux软件被称为Linux发行版。一般来讲，一个Linux发行套件包含大量的软件，比如软件开发工具，数据库，Web服务器（例如Apache)，X Window，桌面环境（比如GNOME和KDE），办公套件（比如OpenOffice.org），等等。
* 1991至1995年间，Linux从概念型的0.1版本内核原型，发展成为能够在性能和特性上均堪媲美专有Unix的操作系统，并且在连续正常工作时间等重要统计数据上打败了这些Unix中的绝大部分。1995年，Linux找到了自己的杀手级应用——开源的web服务器Apache。就像Linux，Apache出众地稳定和高效。很快，运行Apache的Linux机器成了全球ISP平台的首选。约60%的网站选用Apache，轻松击败了另两个主要的专有型竞争对手。今天的LAMP（Linux , Apache, MySQL, PHP）已经成为了架构Web服务器的主要首选。
* 现如今的Linux不但可以装在几乎所有的主流服务器上，当然也包括桌面的X86系统中。其还常常被用于嵌入式系统，机顶盒、手机、交换机、游戏机、PDA、网络交换机、路由器、等等，都是因为Linux那精彩的内核。
* Linux的出现，不仅仅给世界带来了一个免费的操作系统，也不仅仅是对Unix自由、共享的文化的延续，它的出现带给了计算机世界自Unix、GNU以来更为成熟的思想和文化。

## Linux今天的领袖

* Linux和GNU关系是比较微妙的。那时，自由软件基金会编写的用户软件工具包铺平了一条摆脱高成本专有软件开发工具的前进道路。意识服从经济，而不是领导：一些新手加入了RMS的革命运动，高举GPL大旗，另一些人则更认同整体意义上的Unix传统，加入了反对GPL的阵营，但其他大部分人置身事外，一心编码。
* Linus Torvalds巧妙地跨越了GPL和反GPL的派别之争。他利用GNU工具包搭起了自创的Linux内核，用GPL的传染性质保护它，但拒绝认同Richard Stallman的许可协议反映的思想体系计划。Linus Torvalds明确表示他认为自由软件一般情况下更好，但他偶尔也用专有软件。即使在他自己的事业中，他也拒绝成为狂热分子。这一点极大地吸引了大多数黑客，他们虽然早就反感Richard Stallman的言辞，但他们的怀疑论一直缺个有影响力或者令人信服的代言人。而Linus Torvalds正好充当了这一角色。
* Linus Torvalds令人愉快的实用主义及灵活而低调的行事风格，促使黑客文化在1993至1997年间取得了一连串令人惊奇的胜利，不仅仅在技术上的成功，还让围绕Linux操作系统的发行、服务和支持产业有了坚实的开端。结果，他的名望和影响也一飞冲天。Torvalds成为了互联网时代的英雄；到1995年为止，他只用了四年时间就在整个黑客文化界声名显赫，而Richard Stallman为此花了十五年，而且他还远远超过了Stallman向外界贩卖“自由软件”的记录。与Torvalds相比，Richard Stallman的言辞渐渐显得既刺耳又无力。（参看《Linus Torvalds 语录 Top 10》）
* 今天，我们也说不清楚是GNU Linux还是Linux GNU。Linux既不排斥开源，也不排斥商业化，Linus认为好的软件是需要免费和商业化共同推进的。正是这种革命性的想法，造就了今天的Linux火红的局面。Linux就像一股清泉流入了所有人的心中，引发了很多的启迪和思考

## Unix与黑客文化

* 黑客的文化和Unix的商业化存在着必然的联系。自从Unix出现，黑客文化就与之而来
* 1993初，一个悲观的观察家撰文指出，已经有理由认为Unix的传奇故事连同他带有黑客文明将一同破产。许多人预测，从那时起Unix将在六月内死亡。他们很清楚，十年的Unix商业化，使自由跨平台的Unix梦以失败告终。Unix允诺的跨平台可移植性，在一打大公司专有的Unix版本之间不停地斗嘴中丢失，一个完美的操作系统最终沦为多种版本的一团乱麻，这应该说是人类文明史上的一个重大悲剧
* 在专有软件社会中，只有像微软一样的“集权制，大教堂”生产方式才能成功。那个时代的人悲观地相信，技术世界的个人英雄主义时代已经结束，软件工业和发展中的互联网络将逐渐地由像微软一样的巨型企业支配，再也没有“佐罗”，世界是恺撒大帝的世界，计算机文明将进入黑暗的帝国时代。黑客已经死了，自由不付存在
* 自从Unix出现以来，第一代的Unix黑客似乎垂垂老矣，衣食不饱( Berkeley计算机科学研究组在1994丢失了自己基金)。这是一个抑压的时代。专有的商业Unix的结果证明那么沉重、那么盲目、那么不适当，以致微软能够用那次等技术的Windows抢走他们生存的空间，拿走他们的干粮。黑客世界的残余力量被逼到了世界上的角落里，苟延残喘
* 就在黑客文化日渐衰落之时，美国新闻周刊的资深记者Steven Levy完成了著名的《黑客列传》一书，书中着力介绍了一个人物：Richard M. Stallman的故事，他是麻省理工学院（MIT）人工智能实验室领袖人物，坚决反对实验室的研究成果商业化。他是商业软件社会中坚强的一员，决不随波逐流，建立了全新的黑客文化
* Richard M. Stallman（他的登陆名RMS更为人熟知）早在1970年代晚期就已经证明他是当时最有能力的程序员之一。Emacs编辑器就是他众多发明中的一项。RMS的目标是将后1980的松散黑客社群变成一台有组织的社会化机器以达到一个单纯的革命目标。也许他未意识到，他的言行与当年卡尔·马克思号召产业无产阶级反抗工作的努力如出一辙。RMS宣言引发的争论至今仍存于黑客文化中。他的纲要远不止于维护一个代码库，已经暗含了废除软件知识产权主张的精髓。RMS通过“自由软件（free software）”让黑客文化更加有自我意识。当然，这个充满魅力又具争议的人物本身已经成为了一个黑客文化英雄
* 只有痴迷的“黑客”和具有创造力的怪人结成的反叛联盟才能把我们从愚蠢中拯救出来——他们接着教导我们，真正的专业和奉献精神，正是我们在屈服于世俗观念的“合理商业做法”之前的所作所为。 ——《The Art of Unix Programming》
* RMS让世界上所有的人都知道，入侵电脑系统只是低级不入流的黑客干的事，真正的黑客，是为了自由，为了软件的自由，为了挑战计算机世界中的霸权主义而斗争。他们不是街头小混混，他们更像是绿林好汉，更像是罗宾汉，更像是佐罗。就像渴望民主的人民同专制的政府斗争一样。RMS领导着许多的黑客通过互联网向专有软件发出宣战
* X Windows是首批由服务于全球各地不同组织的许多个人以团队形式开发的大规模开源项目之一。电子邮件使创意得以在这个群体中快速传播，问题由此得以快速解决，而开发者可以人尽其才。软件更新可以在数小时之内发送到位，使得每个节点在整个开发过程中步调一致。网络改变了软件的开发模式
* 另一方面，RMS的理论体系有许多东西非常有争议，他的GPL被认为是一种“病毒式”的协议，BSD的fans和老牌Unix黑客们认为，他们编写Unix的年头都比GPL声明要长得多，GPL依然有太多的限制，而BSD协议则比GPL更加的自由。另一方面，RMS走向了另一个极端，他是完全反版权的，反商业化的。把软件产品从强制收费推向了强制免费、共享和开源，这也为他带来了许多许多的争议
* 在RMS组织黑客闹革命的年代里，没有多少黑客认同于RMS的理论体系，更多的他们参与GNU只是为了体现那种在互联网上协同工作，令人激动的工作模式。自从GNU设立以来，争议不断，而黑客文化却从未有统一在他的理想体系之下
* 自从Linux出现以后，一个新的黑客领袖出现了，Linus Torvalds的中庸态度网聚了世界上顶尖的黑客，其绕过了GPL和反GPL的派系之争，他使用GNU的工具从而以GPL的“传染性”保护了Linux，但他同时也不承认RMS的理论思想体系，他即开源，又支持商业化。虽然，他没有带给黑客们什么重要的思想体系或统一的价值观，但他整合了全世界黑客的阵营，让所有的黑客的行为都围绕着Linux这一事物进行。他以“用自由软件是因为它运行得更好”轻而易举地盖过了“用自由软件是因为所有软件都该是自由的”
* 1998年初，这种新思潮促使网景公司（Netscape Communications）公布了其Mozilla浏览器的源码。媒体对此事件的关注促成了Linux在华尔街的上市，推动了1999－2001年间科技股的繁荣。事实证明，此事无论对黑客文化的历史还是对Unix的历史都是一个转折点

## Unix的历史教训

* 距开源越近就越繁荣。任何将Unix专有化的企图，只能陷入停滞和衰败。
* 回顾过去，我们早该认识到这一点。1984年至今，我们浪费了十年时间才学到这个教训。如果我们日后不思悔改，可能还得大吃苦头。
* 虽然我们在软件设计这个重要但狭窄的领域比其他人聪明，但这不能使我们摆脱对技术与经济相互作用影响的茫然，而这些就发生在我们的眼皮底下。即使Unix社区中最具洞察力、最具远见卓识的思想家，他们的眼光终究有限。对今后的教训就是：过度依赖任何一种技术或者商业模式都是错误的——相反，保持软件及其设计传统的的灵活性才是长存之道。
* 另一个教训是：别和低价而灵活的方案较劲。或者，换句话说，低档的硬件只要数量足够，就能爬上性能曲线而最终获胜。经济学家Clayton Christensen称之为“破坏性技术”，他在《创新者窘境》（The Innovator’s Dilemma）[Christensen]一书中以磁盘驱动器、蒸汽挖土机和摩托车为例阐明了这种现象的发生。当小型机取代大型机、工作站和服务器取代小型机以及日用Intel机器又取代工作站和服务器时，我们也看到了这种现象。开源运动获得成功正是由于软件的大众化。Unix要繁荣，就必须继续采用吸纳低价而灵活的方案的诀窍，而不是去反对它们。
* 最后，旧学派的Unix社区因采用了传统的公司组织、财务和市场等命令机制而最终未能实现“职业化”。只有痴迷的“黑客”和具有创造力的怪人结成的反叛联盟才能把我们从愚蠢中拯救出来——他们接着教导我们，真正的专业和奉献精神，正是我们在屈服于世俗观念的“合理商业做法”之前的所作所为。

## [Unix族谱](http://www.levenez.com/unix/)

## Unix的特点

* 开发UNIX，没有正式立项，是Ken Thompson和Dennis Ritchie等少数几个人偷偷干的，如果一切都要从头从新设计，那几乎是不可能的。所以，Unix吸取与借鉴了Multics的经验，如内核，进程，层次式目录，面向流的I/O，把设备当作文件，……等等。但是Unix在继承中又有创新，比如Unix采用一种无格式的文件结构，文件由字节串加\0组成。这带来两大好处：一是在说明文件时不必加进许多无关的“填充物”，二是任何程序的输出可直接用作其他任何程序的输入，不必经过转换。后面这一点叫做“管道”(piping)，这就是Unix首创的。此外，像把设备当作文件，从而简化了设备管理这一操作系统设计中的难题，虽然不是UNIX的发明，但是实现上它采用了一些新方法，比Multics更高明一些。
* Everything (including hardware) is a file 所有的事物（甚至硬件本身）都是一个的文件。
* Configuration data stored in text 以文本形式储存配置数据。
* Small, single-purpose program 程序尽量朝向小而单一的目标设计
* Avoid captive user interfaces 尽量避免令人困惑的用户接口
* Ability to chain program together to perform complex tasks 将几个程序连结起来，处理大而复杂的工作。

## Unix的影响和[哲学](http://en.wikipedia.org/wiki/Unix_philosophy)

* 软件开发的若干哲学和思想。
* 全民参与推动软件，代码共享的模式。
* 开启了黑客文化和开源项目。
* 免费和商业的完美结合的Linux。
* C语言，而后发展的C++，Java等等类C的语言和脚本。（参看《C语言的演变史》）
* TCP/IP，其的Socket编程已成为今天通用的网络编程主流

* AT&T虽然发展了Unix，但今天Unix的混乱的局面也和AT&T 有着直接原因。但反过来说，如果没有AT&T的反面教材，今天的GNU/Linux很有可能也不会出现。AT&T究竟是限制了Unix的发展，还是以反面示例促进了Unix社区，已不好评说。今天，软件是商业化好还是开源好的争论还在继续，纵观这几十年来Unix的历史，Linux的划时代地出现。相信你会得出自己的结论

## 哲学

* 小即是美
* 让程序只做好一件事 Write programs that do one thing and do it well.
* 尽可能早地建立原型
* 可移植性比效率更重要
* 数据应该保存为文本文件
* 尽可能地榨取软件的全部价值
* 使用shell脚本来提高效率和可移植性
* 避免使用可定制性低下的用户界面
* 所有程序都是数据的过滤器
* Write programs to handle text streams, because that is a universal interface.
* Write programs to work together.

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

* 《[UNIX网络编程 卷1：套接字联网API](https://www.amazon.cn/gp/product/B011S72JB6)》
* 《[UNIX网络编程 卷2：进程间通信](https://www.amazon.cn/gp/product/B012R5A29O)》
* 《[UNIX编程环境](https://www.amazon.cn/gp/product/B00IYTQBYS/)》
* 《[Unix 环境高级编程](https://www.amazon.cn/gp/product/B00KMR129E)》
    - [huaxz1986/APUE_notes](https://github.com/huaxz1986/APUE_notes):《UNIX环境高级编程》中文第三版笔记
* 《UNIX操作系统设计》
* 《[UNIX编程艺术](https://www.amazon.cn/gp/product/B008Z1IEQ8)》
* [《The Unix-Haters Handbook》](http://research.microsoft.com/~daniel/uhh-download.html)
* UNIX: A History and a Memoir

## 参考

* [6.S081 Operating System Engineering](https://pdos.csail.mit.edu/6.828/2019/xv6.html)
  - [mit-pdos / xv6-public](https://github.com/mit-pdos/xv6-public):xv6 OS http://pdos.csail.mit.edu/6.828/
  - [ranxian / xv6-chinese ](https://github.com/ranxian/xv6-chinese):中文版的 MIT xv6 文档
* [UNIX传奇(上篇)](https://coolshell.cn/articles/2322.html)
