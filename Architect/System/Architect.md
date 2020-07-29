# Architect

说起架构，大多人想到的是技术语言、技术框架、SOA、微服务、中间件等，这些都是纯粹的系统架构或基础架构，它们基本不受业务影响，大多可以独立于具体业务进行开发和发展，形成自己独立的体系甚至标准化的技术产品。 但实际上大多情况下 技术是为业务服务 的，我们开发的更多的是应用系统或者称之为业务系统，业务的不同特点决定了应用（业务）架构也必然有不同的特点。而这些不同的特点单纯靠技术肯定解决不了，应用架构设计的一条重要原则是 **技术中立**，所以更多时候我们要从应用的角度而不是技术的角度去考虑问题。

应用架构很容易也很难，容易的在于 不需过多关注技术实现，难的在于 必须根据实际业务场景和业务需要及时间、成本、资源等给出当下最合适、一定不是最完美的架构方案。

之前看过关于架构是设计出来的还是演进来的的讨论，其实这个也简单，在某个特定的阶段或时间点，如系统初期，它一定是设计出来的。但纵观一个系统的架构历程，或者说一定要在两者间选择一个的话，它一定是 演进而来 的。所有的大型互联网系统在初期一定不是设计成现在这个样子的，都是伴随着业务从小到大、从少到多、从简单到复杂的过程演进而来，架构的演进过程也见证了业务的发展历程。

技术无止境，但应用架构（业务系统）对技术的追求要有所止境，当 DB 瓶颈解决不了时 换个思路，来个排队系统和预约系统，技术难度就降低了很多；分布式事务解决不了，那就做好回滚、补偿、对账这些基础工作。

多从应用架构的角度去思考解决方案，前面更有一片天！

## 案例

### 秒杀

流量控制：展示层流量 > 应用层流量 > 服务层流量 > DB 层流量

让 DB 可以象应用层和服务层一样随时分布式扩展，可实际上 DB 做不到，DB 是最大的瓶颈，所以才有了 排队系统 和 预约系统。

缓存是一定要用到的，但秒杀往往是瞬间的事，缓存的时效性导致缓存系统在这样的大流量对 DB 的瞬间冲击时几乎没有帮助。

库存更新使得大量的 udpate sql 直接到了 DB，DB 压力非常大。我们尝试了在 mysql 下先 select，有库存时再 update，

排队系统是目前大多秒杀场景最常用的，本质是 异步处理放缓流量、削平瞬间峰值，降低对后续服务层和 DB 层的流量冲击。

预约系统的作用在于 提前预知流量，虽然预约量本身不可控，但秒杀前可以针对已知流量提前做好预案，让 系统处于可控状态。

#### 应用方法

- DB 层不能任意或随时扩展，是最大的瓶颈和最后的底线，是绝对不能破的，一是 DB 并发连接不能超过最大连接数，二是 DB 压力不能太大，所以流量必须在前端控制。
- 服务层虽然可以分布式扩展，但受限于 DB 连接，并不意味着可以无限扩展。如果是公共服务层不区分秒杀业务和普通业务，是不好做流量过滤的，因为会影响到普通业务的正常流量，这种情况下只能从应用层想办法。如果是单独为秒杀流程服务，或者说流量来源能区分出秒杀业务或其他业务的，那还是有思路的，办法总比困难多，如：

  - 随机数过滤：将一定百分比的用户请求直接过滤返回给应用层包装，以友好的方式返回提示给用户。
  - 预设阀值限流：设定单机在单位时间的处理最大阀值，如单机的实际处理能力 TPS 最大是 10000/ 秒，设定阀值为 20，当单机单位时间内（秒）的并发请求达到阀值时，后续请求直接返回给应用层，以友好的方式返回提示给用户。此时系统并不处理业务逻辑和进行 DB 操作，只是简单地判断和响应返回，所以单机的处理能力 20+X 是远大于 10000/ 秒的。
  - 注：上述两种方法 并不是 串行或有依赖的，两者都是一种可选的方法（每层都可以使用），它们的本质都是 流量过滤 和 提升单机处理能力 保护系统以免被冲垮。在保证一定用户体验（单机处理能力）的情况下将流量过滤最大化。

- 应用层

  - 通过 Tomcat 最大连接数控制，超过最大连接数的请求 直接拒绝服务，但用户体验很不好，系统假死崩溃的感觉，尽量通过加分布式服务器的方式解决。（服务层一定要通过应用层控制不能超过最大连接数，展示层和应用层直接取决于用户量，很难控制，可以使用预约系统让流量可控）

- 展示层：随机数过滤，将一定百分比的流量请求直接以友好的方式提示给用户。 正常讲展示层是 不应该过滤 的，请求都没有到服务器，但从业务角度看，抢购秒杀本身就是一个概率事件，并不是完全取决于先后顺序 (有时后来的反而能抢到，这取决于分布式服务器处理、网络、排队系统的异步处理等)。 虽然对技术人来说欺骗用户的感觉很不耻，但关键时刻偶尔抱一下佛脚也是一种办法，总比系统被冲垮了好。

#### 分布式思考

保证分布式事务，特别是异构系统和异构 DB最终的数据一致性

## 多任务

* 计算密集型任务：要进行大量的计算，消耗CPU资源，如视频解码等，启用与CPU核心数相同的并行任务数可最大化利用CPU资源和加快任务的执行；
* IO密集型任务：如网络、磁盘IO等，CPU消耗很少，任务的大部分时间都在等待IO操作完成(因为IO的速度远远低于CPU和内存的速度)，任务数适当增多，CPU效率将提高。

* 在支持多线程的系统中，进程是系统资源分配的基本单位，线程是系统独立调度的基本单位；
* 无论系统支持什么样的线程模型，操作系统调度器指派到处理器内核进行处理的对象是内核线程；
* 用户级线程在用户空间调度灵活高效，内核级线程在内核空间调度成本更高；
* 用户级线程在本进程内竞争CPU处理资源，内核级线程在全系统内竞争CPU处理资源，因此后者才能发挥SMP、MPP、NUMA并行处理的优势；
* 进程的创建、撤消、切换成本都高于线程，故使用多个线程比使用多个进程更有管理维持上的性能优势；
* 由于多线程共享进程资源会导致任何一个线程挂掉都可能造成整个进程崩溃，多进程应用程序在出现进程池内的进程崩溃或被攻击的情况下表现更加健壮，一个子进程崩溃不会影响主进程和其他子进程。因此Chrome浏览器为每一个标签页运行一个进程，Apache最早也是采用多进程模式。在Windows下，多线程的效率比多进程要高，所以微软的IIS服务器默认采用多线程模式。由于多线程存在稳定性的问题，IIS的稳定性就不如Apache。为了缓解这个问题，IIS和Apache现在又有多进程+多线程的混合模式；
* 协程切换快，不存在锁安全问题，异步编码结构同步化，要充分利用多核CPU的计算能力，还要以多进程或多线程为载体。

## 模型

* 数据模型
* 业务模型

### 进程与线程

* 多进程模式：在多核CPU上运行多个进程(数量与CPU核心数相同)可充分利用多核CPU计算能力。由于系统同时运行的进程数少，因此系统调度也非常高效。但每个系统允许同时运行的最大进程数量是有限的；
* 多线程模式；
* 多进程 + 多线程模式；
* 多进程或多线程+ 多协程模式；
* 单进程或单线程 + 异步IO复用模式：异步IO也称事件驱动模型。Nginx就是支持异步IO复用的Web服务器，在单核CPU上采用单进程就可以高效地支持多任务。用异步IO复用来实现多任务也是一个主要的应用趋势，但是无法充分利用多核CPU的计算能力。

#### 线程(thread)

线程通常由线程ID、当前指令指针(PC）、寄存器集合和堆栈组成，是进程中的一个实体，是系统独立调度分派的基本单位；线程也有就绪、阻塞和运行三种基本状态。进程是系统资源分配的基本单位，创建、撤消、切换开销大，进程间通信IPC(Inter-Process Communication)复杂，在SMP、MPP、NUMA系统上同时运行多个线程并行执行更为合适。线程的实体包括程序、数据和线程控制块（Thread Control Block，TCB），TCB包括以下信息：

* 线程状态；
* 当线程不运行时，被保存的现场资源；
* 一组执行堆栈；
* 存放每个线程的局部变量主存；
* 访问同一个进程中的主存和其它资源。 

SMP(Symmetric Multi-Processor)系统中有多个处理器(核心)，每个处理器都有自己的控制单元、算术逻辑单元和寄存器，都可以通过某种互联机制(通常是系统总线)访问一个共享的主存和I/O设备，还可以通过存储器中共享地址空间中的消息和状态信息相互通信。SMP广泛应用于PC和移动设备领域，并行度很高，能够显著提升性能。在SMP系统中，只运行操作系统的一个拷贝，不同处理器被授权均匀访问(Uniform Memory Access，UMA亦称作统一寻址技术或统一内存存取)存储器的不同部分，但同一时间只能有一个处理器访问存储器。

* 单核CPU上运行多线程的锁问题：线程在被阻塞或睡眠状态下，其已经持有的资源访问权不能释放才能保证并发访问资源的最终一致性。因此，多个并发线程访问多个不同对象时，有可能导致各自同时获得一部分资源访问权，而等待对方释放另一部分资源访问权被阻死，于是死锁发生。
* 单核CPU上运行多线程的效率问题：在CPU密集型作业条件下，多线程的确不能提高性能，甚至更浪费时间；但是，在IO密集型作业条件下，多线程则可以提升性能。

模型

* 内核级线程(Kernel-Level Thread)：内核级线程驻留在内核空间，由操作系统调度器管理、调度和分派；内核级线程在其生命期内都将被映射到一个内核线程，一旦终止，两个线程都将离开系统；内核级线程不受用户态上下文的拖累，资源同步和数据共享比进程要低一些。如下图所示：
* 用户级线程(User-Level Thread)：用户级线程的创建、调度、同步和销毁是通过库函数在用户空间完成的，对内核都是不可见的，因此无法被调度到处理器内核。在任意给定时刻进程都只能运行一个用户级线程，在整个程序执行过程中是进程而非其用户级线程与一个内核线程关联起来。用户级线程的创建、销毁、切换代价比内核级线程小得多，允许每个进程定制自己的调度算法，线程管理比较灵活，还能在不支持线程的操作系统中实现。如下图所示：
* 混合模型：在支持多线程的操作系统中，不同系统实现的线程模型并不相同，有的实现了用户级线程模型，有的实现了内核级线程模型
![混合线程模型]（../_static/thread.jpg "混合线程模型")

#### 进程

轻量进程(Lightweight Process，LWP)：每一个轻量进程都与一个特定的内核线程关联，是对用户级线程、内核级线程二者部分特性的抽象、融合和模拟。轻量进程有自己的进程标识符、优先级、状态以及栈和局部存储区，并和其他进程有着父子关系，这和类Unix操作系统调用vfork()生成的进程类似；轻量进程即使在I/O中阻塞，也不会影响所属进程的其他轻量进程的执行。LWP由clone()系统调用创建，参数是CLONE_VM，与父进程是共享进程地址空间和系统资源的。在大多数系统中，LWP与普通进程的区别也在于它只有一个最小的执行上下文和调度所需的统计信息，这也是它被称为轻量级的原因。

#### 协程

协程又称微线程，一个线程可以包含一个或多个协程，协程的相关特性如下：

* 运行在用户态，是系统内核不可感知的，有自己的目态栈，相当于用户级线程；
* 异步编码结构同步化；
* 从内部挂起主动释放CPU而非线程的抢占式调度切换，共享资源不加锁；
* 多个协程在同一个线程上下文中执行，同一时间只有一个是处于激活态，其他都是暂停态(suspended)，无法充分利用多核CPU的计算能力；
* 目态栈数据量小，切换更快。
其实，协程先于抢占式调度切换的线程出现用来模拟多任务并发，但由于其主动释放CPU而非抢占式(Non-Preempt)调度切换导致多任务时间片不均衡，而后线程出现了；协程近年来又开始出现流行的趋势。win32中称协程为纤程(Fiber)，主要用于旧的Unix应用的移植，创建新应用还是建议优先使用线程。

## 参考

* [donnemartin/system-design-primer](https://github.com/donnemartin/system-design-primer):Learn how to design large-scale systems. Prep for the system design interview. Includes Anki flashcards.
* [binhnguyennus/awesome-scalability](https://github.com/binhnguyennus/awesome-scalability):An updated and curated list of selected readings to illustrate Scalability, Availability, and Stability Design Patterns in Back-end Development. 