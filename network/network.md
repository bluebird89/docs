# NetWork 计算机网络

## [TCP/IP](./tcp_ip.md)

## 多进程/多线程/协程

* 现在操作系统都采用虚拟存储器，对32位操作系统而言，寻址空间（虚拟存储空间）为4G（2的32次方）
* 操作系统核心是内核，独立于普通的应用程序，可以访问受保护的内存空间，也有访问底层硬件设备的所有权限。
* 应用程序稳定性远远比不上操作系统程序,为了保证用户进程不能直接操作内核（kernel）。隔离操作系统程序和应用程序。将虚拟空间划分为两部分
* 内核空间：将最高的1G字节（虚拟地址0xC0000000到0xFFFFFFFF），供内核使用
  - 运行操作系统程序和驱动程序
  - 所有的系统资源操作都在内核空间进行，比如读写磁盘文件，内存分配和回收，网络接口调用等
  - 只能 内核空间 控制 Socket 读写
* 用户空间:将较低的3G字节（虚拟地址0x00000000到0xBFFFFFFF），供各个进程使用
  - 运行应用程序

* 进程 process 资源分配的最小单位
  - 一个任务就是一个进程（Process）,一个进程至少有一个线程
  - 跑在一个cpu里面的并发都需要处理上下文切换的问题。进程就是这样抽象出来个一个概念，搭配虚拟内存、进程表之类的东西，用来管理独立的程序运行、切换。频繁的进程上下文切换导致了OS性能的降低
  - 进程间通信
    + 同一台机器上进程间的通信（IPC）有多种方式，可以是通过消息队列、FIFO、共享内存等方式
    + 管道、UnixSocket、消息队列、共享内存
    + 网络编程套接字：分布在不同机器上的程序通过系统提供的网络通信接口，跨越网络将不同机器上的进程连接起来，实现跨机器的网络通信。一般有UDP套接字、TCP套接字、Unix Domain
  - 进程切换
    + 切换页全局目录（Page Global Directory）来加载一个新的地址空间，实际上就是加载新进程的cr3寄存器值
    + 切换内核堆栈和硬件上下文，这些包含了内核执行一个新进程的所有信息，包含了CPU寄存器
  - 进程上下文：进程是由内核来管理和调度的，进程的切换只能发生在内核态，因此虚拟内存、栈、全局变量等用户空间的资源，以及内核堆栈、寄存器等内核空间的状态
  - 进程上下文切换开销
    + 挂起一个进程，将这个进程在 CPU 中的状态（上下文）存储于内存中的某处
    + 在内存中检索下一个进程的上下文并将其在 CPU 的寄存器中恢复
    + 跳转到程序计数器所指向的位置（即跳转到进程被中断时的代码行），以恢复该进程
  - 有的时候碰着I/O访问，阻塞了后面所有的计算。空着也是空着，内核就直接把CPU切换到其他进程，让人家先用着。当然除了I\O阻塞，还有时钟阻塞等等。后来发现不成，太慢了。为啥呀，一切换进程得反复进入内核，置换掉一大堆状态。进程数一高，大部分系统资源就被进程切换给吃掉了。
  - 多进程:服务器的主进程负责监听客户的连接，一旦与客户端连接完成，accept() 函数就会返回一个「已连接 Socket」，这时就通过 fork() 函数创建一个子进程，实际上就把父进程所有相关的东西都复制一份，包括文件描述符、内存地址空间、程序计数器、执行的代码等.两个进程刚复制完的时候，几乎一摸一样。不过，会根据返回值来区分是父进程还是子进程，如果返回值是 0，则是子进程；如果返回值是其他的整数，就是父进程。
    + 子进程会复制父进程的文件描述符，于是就可以直接使用「已连接 Socket 」和客户端通信了
    + 子进程不需要关心「监听 Socket」，只需要关心「已连接 Socket」
    + 父进程则相反，将客户服务交给子进程来处理，因此父进程不需要关心「已连接 Socket」，只需要关心「监听 Socket」
    + 当「子进程」退出时，实际上内核里还会保留该进程的一些信息，也是会占用内存的，如果不做好“回收”工作，就会变成僵尸进程，随着僵尸进程越多，会慢慢耗尽系统资源
    + 父进程要“善后”在子进程退出后回收资源
      * 调用 wait()函数
      * 调用 waitpid() 函数
* 线程（Thread）操作系统调度的最小单位
  - 运行在进程中的一个“逻辑流”，单进程中可以运行多个线程，同进程里的线程可以共享进程的部分资源的，比如文件描述符列表、进程空间、代码、全局数据、堆、共享库等，这些共享些资源在上下文切换时是不需要切换，而只需要切换线程的私有数据、寄存器等不共享的数据，因此同一个进程下的线程上下文切换的开销要比进程小得多。
  - 搞出线程概念:这个地方阻塞了，还有其他地方的逻辑流可以计算，这些逻辑流是共享一个地址空间的，不用特别麻烦的重新加载地址空间，页表缓冲区，只要把寄存器刷新一遍就行，能比切换进程开销少点。
  - 当服务器与客户端 TCP 完成连接后，通过 pthread_create() 函数创建线程，然后将「已连接 Socket」的文件描述符传递给线程函数，接着在线程里和客户端进行通信，从而达到并发处理的目的。
  - 线程的上下文：线程会共享父进程的虚拟内存和全局变量等资源，父进程的资源加上线上自己的私有数据
    + 如果是同一进程的线程，因为有资源共享，所以会比多进程间的切换消耗更少的资源
  - 切换
    + 要先保存上一个线程的上下文，然后执行下一个线程，当条件满足时，切换回上一个线程，并恢复上下文
    + 线程间对资源竞争问题
  - 线程池的方式来避免线程的频繁创建和销毁，所谓的线程池，就是提前创建若干个线程，这样当由新连接建立时，将这个已连接的 Socket 放入到一个队列里，然后线程池里的线程负责从队列中取出已连接 Socket 进程处理。
    + 队列是全局的，每个线程都会操作，为了避免多线程竞争，线程在操作这个队列前要加锁。
  - 多线程:进程开销太大，线程则轻量级的多，可以通过在进程中创建新的线程来处理请求
* 协程
  - 自己在进程里面写一个逻辑流调度的东西。那么即可以利用到并发优势，又可以避免反复系统调用，还有进程切换造成的开销，分分钟给你上几千个逻辑流不费力。这就是用户态线程。实现一个用户态线程有两个必须要处理的问题：
  - 碰着阻塞式I\O会导致整个进程被挂起
  - 由于缺乏时钟阻塞，进程需要自己拥有调度线程的能力
  - 如果一种实现使得每个线程需要自己通过调用某个方法，主动交出控制权。那么我们就称这种用户态线程是协作式的，即是协程。协程就是在用户程序中实现了协作式任务调度。
  - yield 关键字就是用来产生中断, 并保存当前的上下文的, 比如说程序的一段代码是访问远程服务器，那这个时候CPU就是空闲的，就用yield让出CPU，接着执行下一段的代码，如果下一段代码还是访问除CPU以外的其它资源，还可以调用yield让出CPU. 继续往下执行，这样就可以用同步的方式写异步的代码了
    + 为应用层实现多任务提供了工具
    + 协程不允许多任务同时执行，要执行其它协程，必须使用关键字yield主动放弃cpu控制权
    + 协程需要自己写任务管理器，以及任务调度器
    + 减轻了OS处理零散任务和轻量级任务的负担
  - 协程需要上下文切换，但是不会产生 CPU上下文切换和进程/线程上下文的切换,因为这些切换都是在同一个线程中，即用户态中的切换，甚至可以简单的理解为，协程上下文之间的切换，就是移动了一下你程序里面的指针，CPU资源依旧属于当前线程
    + 没有IO阻塞操作,不会发生协程切换
    + 带IO阻塞操作:基于协程的php+ swoole服务比 Java + netty服务的QPS高了6倍
    + 在进程/线程切换的时候，会产生额外的CPU资源花销，特别是在用户态和内核态之间切换的时候

* 内核实现线程与线程之间的调度，通常一个线程是无法从头到尾占用着 cpu 的，尤其是进行 i/o 操作时，许多的系统调用都是阻塞的，此时内核保存该线程的上下文，然后挂起该线程。更多时候是由于该线程的本次运行时间耗尽，只得被挂起等待 cpu 的下一次
* 进程和线程的切换，会产生CPU上下文切换和进程/线程上下文的切换。而这些上下文切换,都是会消耗额外的CPU的资源的
* 典型PHP-FPM的CGI模式，每一个HTTP请求会经历如下，决定了在高并发上的灾难性表现
  - 都会读取框架的数百个php文件
  - 都会重新建立/释放一遍MYSQL/REIDS/MQ连接
  - 都会重新动态解释编译执行PHP文件
  - 都会在不同的php-fpm进程直接不停的切换切换再切换

* execve函数参数
  - 可执行文件的路径pathname
  - 参数的指针数组argv 指向一个NULL结尾的指针数组，每个元素都是一个指向参数字符串的指针。按照约定，argv[0]是可执行文件的名称
  - 环境变量的指针数组envp  数据结构类似。唯一的区别是，环境变量数组元素指向的字符串都是名-值对形式的，比如"PWD=/usr/droh"
  - 加载:找到pathname对应的可执行文件后，execve会调用操作系统永驻内存的loader代码，把可执行文件的代码和数据从磁盘复制到内存。然后，跳到其第一个指令或“入口点”开始执行该程序

```c
// 改造堵塞IO read 函数:用多线程手段使得主线程没有卡在 read 函数上不往下走
while(1) {
  connfd = accept(listenfd);  // 阻塞建立连接
  pthread_create（doWork);  // 创建一个新的线程
}
void doWork() {
  int n = read(connfd, buf);  // 阻塞读数据
  doSomeThing(buf);  // 利用读到的数据做些什么
  close(connfd);     // 关闭连接，循环等待下一个连接
}

// 操作系统提供一个非阻塞的 read 函数:如果没有数据到达时（到达网卡并拷贝到了内核缓冲区），立刻返回一个错误值（-1），而不是阻塞地等待
// 非阻塞的 read，指的是在数据到达前，即数据还未到达网卡，或者到达网卡但还没有拷贝到内核缓冲区之前，这个阶段是非阻塞的
// 当数据已到达内核缓冲区，此时调用 read 函数仍然是阻塞的，需要等待数据从内核缓冲区拷贝到用户缓冲区，才能返回
fcntl(connfd, F_SETFL, O_NONBLOCK);
int n = read(connfd, buffer) != SUCCESS);

int execve(const char *pathname, char *const argv[], char *const envp[]);
```

## Socket 套接字

* 起源于 Unix ，由 BSD UNIX 开发,Unix/Linux 基本哲学之一就是“一切皆文件”，可以用“打开(open) –> 读写(write/read) –> 关闭(close)”模式来进行操作。因此 Socket 也被处理为一种特殊的文件.后来被移植到 Windows 的 Winsock 以及嵌入式系统中。应用程序利用 Socket，可以设置对端的 IP 地址、端口号，并实现数据的接收和发送
* 应用程序在基于 TCP 协议或 UDP 协议进行通信时，需要用到操作系统提供的类库，这种类库一般称为 API（Application Programming Interface，应用编程接口）.socket本质是编程接口(API)，对TCP/IP的封装，TCP/IP也要提供可供程序员做网络开发所用的接口，这就是Socket编程接口.Socket编程接口在设计的时候，就希望也能适应其他的网络协议
* Unix domain socket
  - Unix domain socket 或者 IPCsocket 是一种终端，可以使同一台操作系统上的两个或多个进程进行数据通信
  - 与管道相比，Unix domain sockets 既可以使用字节流数和数据队列，而管道通信则只能通过字节流
  - Unix domain sockets的接口和Internet socket很像，但它不使用网络底层协议来通信
  - Unix domain socket 的功能是POSIX操作系统里的一种组件
  - Unix domain sockets 使用系统文件的地址来作为自己的身份。可以被系统进程引用。所以两个进程可以同时打开一个Unix domain sockets来进行通信。不过这种通信方式是发生在系统内核里而不会在网络里传播。
  - These are secure in that they are file-based and can't be read by remote servers. We can further use linux permission to set who can read and write to this socket file.
  - Unix Socket vs Tcp Socket
    + 不会走到TCP 那层，直接以文件形式，以stream socket通讯
    + unix socket减少了不必要的tcp开销，而tcp需要经过loopback，还要申请临时端口和tcp相关资源
    + unix socket高并发时候不稳定，连接数爆发时，会产生大量的长时缓存，在没有面向连接协议的支撑下，大数据包可能会直接出错不返回异常
    + tcp这样的面向连接的协议，多少可以保证通信的正确性和完整性
    + TCP socket,需要走到IP层
* Socket 是对 TCP/IP 协议族的一种封装，是应用层与TCP/IP协议族通信的中间软件抽象层.从设计模式角度看来，Socket其实就是一个门面模式，把复杂的TCP/IP协议族隐藏在Socket接口后面
* Socket实质上提供进程通信的端点:网络上两个程序通过一个双向的通信连接实现数据的交换，连接的一端称为一个socket，建立网络通信连接至少要一对端口号(socket).进程通信之前，双方首先必须各自创建一个端点，否则是没有办法建立联系并相互通信的.Socket利用网间网通信设施实现进程通信，对通信设施的细节毫不关心，只要通信设施能提供足够的通信能力
* 网络通信过程中端点的抽象表示，包含进行网络通信必须的五种信息：连接使用的协议，本地主机的IP地址，本地进程的协议端口，远地主机的IP地址，远地进程的协议端口
  - Socket 可以被定义描述为两个应用通信通道的端点。一个 Socket 端点可以用 Socket 地址来描述，Socket 地址结构由三元组 IP 地址，端口和使用协议组成（ TCP or UDP ）,可以唯一标识网络中的进程，网络中的进程通信可以利用这个标志与其它进程进行交互
* 在内核中 Socket 以「文件」的形式存在的，有对应的文件描述符
  - 文件描述符
    + 每一个进程都有一个数据结构 task_struct，该结构体里有一个指向「文件描述符数组」的成员指针
    + 该数组里列出这个进程打开的所有文件的文件描述符。数组的下标是文件描述符，是一个整数，而数组的内容是一个指针，指向内核中所有打开的文件的列表，也就是说内核可以通过文件描述符找到对应打开的文件。
    + 每个文件都有一个 inode，Socket 文件的 inode 指向了内核中的 Socket 结构，在这个结构体里有两个队列，分别是发送队列和接收队列，两个队列里面保存的是一个个 struct sk_buff，用链表的组织形式串起来
    + sk_buff 可以表示各个层的数据包，在应用层数据包叫 data，在 TCP 层我们称为 segment，在 IP 层我们叫 packet，在数据链路层称为 frame
  - 全部数据包只用一个结构体来描述:协议栈采用的是分层结构，上层向下层传递数据时需要增加包头，下层向上层数据时又需要去掉包头，如果每一层都用一个结构体，那在层之间传递数据的时候，就要发生多次拷贝，这将大大降低 CPU 效率
  - 为了在层级之间传递数据时，不发生拷贝，只用 `sk_buff` 一个结构体来描述所有的网络包.通过调整 `sk_buff` 中 data 的指针
    + 当接收报文时，从网卡驱动开始，通过协议栈层层往上传送数据报，通过增加 skb->data 的值，来逐步剥离协议首部。
    + 当要发送报文时，创建 sk_buff 结构体，数据缓存区的头部预留足够的空间，用来填充各层首部，在经过各下层协议时，通过减少 skb->data 的值来增加协议首部。

* Socket连接是长连接，理论上客户端和服务器端一旦建立连接将不会主动断开此连接
* Socket连接属于请求-响应形式，服务端可主动将消息推送给客户端

### Socket 编程

* 建立Socket连接至少需要一对套接字，其中一个运行于客户端，称为ClientSocket ，另一个运行于服务器端，称为ServerSocket
  - 服务器监听:通过 `netstate` 命令查看对应端口号是否有被监听
    + socket() 创建套接字
      * 创建Socket连接时，可以指定使用传输层协议，支持不同的传输层协议（TCP或UDP）
      * 把一个地址族中的特定地址赋给socket
        - sockfd：即socket描述字，通过socket()函数创建了，唯一标识一个socket。bind()函数就是将给这个描述字绑定一个名字。
        - addr：一个const struct sockaddr *指针，指向要绑定给sockfd的协议地址。这个地址结构根据地址创建socket时的地址协议族的不同而不同
    + bind() 给 Socket 绑定一个 IP 地址和端口
      * 绑定 IP 地址目的：一台机器是可以有多个网卡的，每个网卡都有对应的 IP 地址，当绑定一个网卡时，内核在收到该网卡上的包，才会发给我们
      * 绑定端口目的：当内核收到 TCP 报文，通过 TCP 头里面的端口号，来找到我们的应用程序，然后把数据传递给我们
    + listen() 服务器端套接字并不定位具体的客户端套接字，而是处于等待连接的状态，实时监控网络状态
    + 操作系统内核中，为每个 Socket 维护两个队列
      * TCP 全连接队列:连接三次握手已经完毕，服务端处于 established 状态
      * TCP 半连接队列:三次握手还没完成，服务端处于 syn_rcvd 状态
  - 客户端请求：客户端套接字提出连接请求，要连接的目标是服务器端的套接字
    + 通过 connect() 函数发起连接。在参数中指明要连接的 IP 地址和端口号
      * 参数中描述要连接的服务器的套接字，指出服务器端套接字的地址和端口号，然后就向服务器端套接字提出连接请求
      * 开始发起三次握手，操作系统会给客户端分配一个临时的端口
  - 连接确认：当服务器端套接字监听到或者说接收到客户端套接字的连接请求，它就响应客户端套接字的请求，建立一个新的线程，把服务器端套接字的描述发给客户端，一旦客户端确认了此描述，连接就建立好了。而服务器端套接字继续处于监听状态，继续接收其他客户端套接字的连接请求
  - 接受请求，从网络中读取一条 HTTP 请求报文。accept() 允许连接请求
    + 一旦握手成功，服务端的 accept 就会返回另一个 Socket 用于传输数据
      * 当 TCP 全连接队列不为空后，服务端的 accept() 函数，就会从内核中的 TCP 全连接队列里拿出一个已经完成连接的  Socket 返回应用程序，后续数据传输都用这个 Socket。
    + 服务端调用 accept() 函数，拿出已经完成的连接进行处理从内核获取客户端的连接，如果没有客户端连接，则会阻塞等待客户端连接的到来
    + 负责监听的 Socket 和真正用来传数据的 Socket 是两个，一个叫作监听 Socket，一个叫作已连接 Socket
  - 处理请求，访问资源。read()/write() 数据交换
    + 双方开始通过 read 和 write 函数来读写数据，就像往一个文件流里面写东西一样
    + 通信时，一个应用程序将数据写入Socket，然后通过网卡把数据发送到另外一个应用程序的Socket中
    + read()
      * 数据从网卡拷贝到内核缓存区，文件描述符读已就绪
      * 从内核缓存区拷贝到用户缓冲区，文件描述符置读未就绪
  - 构建发送响应，创建带有 header 的 HTTP 响应报文传给客户端。close() 关闭连接
* TCP 连接是由四元组：本机IP, 本机端口, 对端IP, 对端端口唯一确认
  - 服务器的本地 IP 和端口是固定的:服务器作为服务方，通常会在本地固定监听一个端口，等待客户端的连接。对于服务端 TCP 连接的四元组只有对端 IP 和端口是会变化的，所以最大 TCP 连接数 = 客户端 IP 数×客户端端口数.对于 IPv4，客户端的 IP 数最多为 2 的 32 次方，客户端的端口数最多为 2 的 16 次方，也就是服务端单机最大 TCP 连接数约为 2 的 48 次方
  - 服务器肯定承载不了那么大的连接数，主要会受两个方面的限制
    + 文件描述符，Socket 实际上是一个文件，也就会对应一个文件描述符。在 Linux 下，单个进程打开的文件描述符数是有限制的，没有经过修改的值一般都是 1024，不过我们可以通过 ulimit 增大文件描述符的数目；
    + 系统内存，每个 TCP 连接在内核中都有对应的数据结构，意味着每个连接都是会占用一定内存的
* 接收缓存区、发送缓存区、阻塞/非阻塞、超时
* C10K:每新进来一个 TCP 连接请求，就需要分配一个进程或线程
* 应用层通过传输层进行数据通信时，TCP会遇到同时为多个应用程序进程提供并发服务的问题.多个TCP连接或多个应用程序进程可能需要通过同一个 TCP协议端口传输数据,为了区别不同的应用程序进程和连接，许多计算机操作系统为应用程序与TCP／IP协议交互提供了套接字(Socket)接口
  - 应用层可以和传输层通过Socket接口，区分来自不同应用程序进程或网络连接的通信，实现数据传输的并发服务。
  - 应用层通过传输层进行数据通信时，TCP会遇到同时为多个应用程序进程提供并发服务的问题。
  - 多个TCP连接或多个应用程序进程可能需要通过同一个 TCP协议端口传输数据。为了区别不同的应用程序进程和连接，许多计算机操作系统为应用程序与TCP／IP协议交互提供了套接字(Socket)接口。应用层可以和传输层通过Socket接口，区分来自不同应用程序进程或网络连接的通信，实现数据传输的并发服务。
* Socket 编程是阻塞 I/O 模型，基本上只能一对一通信

![Unix_Socket_Tcp_Socket](../static/tcp-socket-or-unix-domain-socket1.png "Unix_Socket_Tcp_Socket")
![socket2](../static/socket2.png "socket2")
![socket 连接](../_static/tcp.png "Optional title")

```c
listenfd = socket();   // 打开一个网络通信端口
// int bind(int sockfd, const struct sockaddr *addr, socklen_t addrlen);
bind(listenfd);        // 绑定

int listen(int sockfd, int backlog);
listen(listenfd);      // 监听

while(1) {
// int accept(int sockfd, struct sockaddr *addr, socklen_t *addrlen);
  connfd = accept(listenfd);  // 阻塞建立连接

// ssize_t read(int fd, void *buf, size_t count);
  int n = read(connfd, buf);  // 阻塞读数据
  doSomeThing(buf);  // 利用读到的数据做些什么
  close(connfd);     // 关闭连接，循环等待下一个连接
}

int connect(int sockfd, const struct sockaddr *addr, socklen_t addrlen);

#include <unistd.h>

ssize_t write(int fd, const void *buf, size_t count);

#include <sys/types.h>
#include <sys/socket.h>

ssize_t send(int sockfd, const void *buf, size_t len, int flags);
ssize_t recv(int sockfd, void *buf, size_t len, int flags);

ssize_t sendto(int sockfd, const void *buf, size_t len, int flags,
              const struct sockaddr *dest_addr, socklen_t addrlen);
ssize_t recvfrom(int sockfd, void *buf, size_t len, int flags,
                struct sockaddr *src_addr, socklen_t *addrlen);

ssize_t sendmsg(int sockfd, const struct msghdr *msg, int flags);
ssize_t recvmsg(int sockfd, struct msghdr *msg, int flags);

int close(int fd);
```

## 网络 IO 模型

* 整个演变过程，就是对CPU有效性能压榨的过程

* 同步与异步:关注消息通信机制 (synchronous communication/ asynchronous communication).等馒头这件事，是一直等到＂馒头出炉＂的结果，还是立即跑路等阿梅告诉你的＂馒头出炉＂．
  - 同步:在发出一个 *调用* 时，在没有得到结果之前，该 *调用* 就不返回。但是一旦调用返回，就得到返回值了
    + 同步阻塞IO：在Linux中，默认情况下所有socket都是阻塞模式
      * 用户线程调用系统函数read()，内核开始准备数据（从网络接收数据），内核准备数据完成后，数据从内核拷贝到用户空间的应用程序缓冲区，数据拷贝完成后，请求才返回
      * 从发起read请求到最终完成内核到应用程序的拷贝，整个过程线程都是阻塞的
      * 为了提高性能，可以为每个连接都分配一个线程。因此，在大量连接的场景下就需要大量的线程，会造成巨大的性能损耗，这也是传统阻塞IO的最大缺陷
    + 同步非阻塞IO
      * 用户线程在发起Read请求后立即返回，不用等待内核准备数据的过程
      * 如果Read请求没读取到数据，用户线程会不断轮询发起Read请求，直到数据到达（内核准备好数据）后才停止轮询
      * 非阻塞IO模型虽然避免了由于线程阻塞问题带来的大量线程消耗，但是频繁的重复轮询大大增加了请求次数，对CPU消耗也比较明显。在实际应用中很少使用
  - 异步:*调用*在发出之后，调用就直接返回了，所以没有返回结果。换句话说，当一个异步过程调用发出后，调用者不会立刻得到结果。而是在*调用*发出后，*被调用者*通过状态、通知来通知调用者，或通过回调函数处理这个调用。

* 阻塞与非阻塞:程序在等待调用结果（消息，返回值）时当前线程状态
  - 阻塞IO:发出一个请求不能立刻返回响应，要等所有的逻辑全处理完才能返回响应.指调用结果返回之前，当前线程会被挂起。调用线程只有在得到结果之后才会返回
    + 去甜在心馒头店买太极馒头，阿梅说：＂暂时没，正在蒸呢，你自己看着点儿！＂．于是你就站在旁边只等馒头．此时的你，是阻塞的，是同步的．阻塞表现在你除了等馒头，别的什么都不做了．同步表现在等馒头的过程中，阿梅不提供通知服务，你不得不自己要等到＂馒头出炉＂的消息.典型PHP开发，基于LNMP
    + 去甜在心馒头店买太极馒头，阿梅说：＂暂时没，正在蒸呢，蒸好了我打电话告诉你！＂．但你依然站在旁边只等馒头，此时的你，是阻塞的，是异步的．阻塞表现在你除了等馒头，别的什么都不做了．异步表现在等馒头的过程中，阿梅提供电话通知＂馒头出炉＂的消息，只需要等阿梅的电话．
  - 非阻塞IO:发出一个请求立刻返回应答，不用等处理完所有逻辑.在不能立刻得到结果之前，该调用不会阻塞当前线程
    + 去甜在心馒头店买太极馒头，阿梅说：＂暂时没，正在蒸呢，你自己看着点儿！＂．于是你就站在旁边发微信，然后问一句：＂好了没？＂，然后发QQ，然后再问一句：＂好了没？＂．此时的你，是非阻塞的，是同步的．非阻塞表现在你除了等馒头，自己还干干别的时不时会主动问问馒头好没好．同步表现在等馒头的过程中，阿梅不提供通知服务，你不得不自己要等到＂馒头出炉＂的消息．
    + 去甜在心馒头店买太极馒头，阿梅说：＂暂时没，正在蒸呢，蒸好了我打电话告诉你！＂．于是你就走了，去买了双新球鞋，看了看武馆，总之，从此不再过问馒头的事情，一心只等阿梅电话．此时的你，是非阻塞的，是异步的．非阻塞表现在你除了等馒头，自己还干干别的时不时会主动问问馒头好没好．异步表现在等馒头的过程中，阿梅提供电话通知＂馒头出炉＂的消息，你只需要等阿梅的电话．

### I/O 多路复用

* 多个请求复用一个进程
* 建立在多路事件分离函数select，poll，epoll之上,select/poll/epoll 内核提供给用户态的多路复用系统调用，进程可以通过一个系统调用函数从内核中获取多个事件
  - 发起read请求前，先更新select的socket监控列表，然后等待select函数返回（此过程是阻塞的，所以说多路复用IO也是阻塞IO模型）
  - 当某个socket有数据到达时，select函数返回。此时用户线程才正式发起read请求，读取并处理数据
  - select/poll/epoll 获取网络事件:在获取事件时，先把所有连接（文件描述符）传给内核，再由内核返回产生了事件的连接，然后在用户态中再处理这些连接对应的请求即可
  - 这种模式用一个专门的监视线程去检查多个socket，如果某个socket有数据到达就交给工作线程处理
  - 由于等待Socket数据到达过程非常耗时，所以这种方式解决了阻塞IO模型一个Socket连接就需要一个线程的问题，也不存在非阻塞IO模型忙轮询带来的CPU性能损耗的问题
  - 实际应用场景很多，比如Java NIO，Redis以及Dubbo采用的通信框架Netty
* 文件描述符集合:一个线程维护多个 Socket（前面多进程或多线程都是一个进程或线程维护一个 Socket）,有两种实现方式
  - 轮询:调用内核的 select 函数监听文件描述符集合是否有变化，一旦有变化，就会依次查看每个文件描述符，对那些发生变化的文件描述符进行读写操作，然后再调用 select 函数监听下一轮的变化
  - 事件通知:就是某个文件描述符发生变化，调用 epoll 函数主动通知。这种方式使得监听的 Socket 数据增加的时候，效率不会大幅度降低，能够同时监听的 Socket 的数目也非常多。上限就为系统定义的、进程打开的最大文件描述符个数
* select
  - 操作系统提供的系统调用函数，可以把一个文件描述符的数组发给操作系统内核，让操作系统去遍历文件描述符集合，当检查到有事件产生后，将此 Socket 标记为可读或可写
  - 再把整个文件描述符集合拷贝回用户态里，然后用户态再通过遍历找到可读或可写的 Socket，然后再对其处理。操作系统会将准备就绪的文件描述符做上标识，用户层将不会再有无意义的系统调用开销。
  - 把关注的 Socket 集合通过 select/poll 系统调用从用户态拷贝到内核态，然后由内核检测事件，当有网络事件产生时，内核需要遍历进程关注 Socket 集合，找到对应的 Socket，并设置其状态为可读/可写，然后把整个 Socket 集合从内核态拷贝到用户态，用户态还要继续遍历整个 Socket 集合找到可读/可写的 Socket，然后对其处理
    + 2 次「拷贝」文件描述符集合:先从用户空间传入内核空间，由内核修改后，再传出到用户空间中
    + 需要进行 2 次「遍历」文件描述符集合，一次是在内核态里，一个次是在用户态里
  - select 使用固定长度的 BitsMap，表示文件描述符集合，而且所支持的文件描述符的个数是有限制的，在 Linux 系统中，由内核中的 FD_SETSIZE 限制， 默认最大值为 1024，只能监听 0~1023 的文件描述符
  - Under Linux, select() may report a socket file descriptor as "ready for reading", while nevertheless a subsequent read blocks. This could for example happen when data has arrived but upon examination has wrong checksum and is discarded. There may be other circumstances in which a file descriptor is spuriously reported as ready. Thus it may be safer to use O_NONBLOCK on sockets that should not block.
  - 细节：
    + select 调用需要传入 fd 数组，需要拷贝一份到内核，高并发场景下这样的拷贝消耗的资源是惊人的。（可优化为不复制）
    + select 在内核层仍然是通过遍历的方式检查文件描述符的就绪状态，是个同步过程，只不过无系统调用切换上下文的开销。（内核层可优化为异步事件通知）
    + select 仅仅返回可读文件描述符的个数，具体哪个可读还是要用户自己遍历。（可优化为只返回给用户就绪的文件描述符，无需用户做无效的遍历）
* poll
  - 不再用 BitsMap 来存储所关注的文件描述符，取而代之用动态数组，以链表形式来组织，突破了 select 的文件描述符个数限制，当然还会受到系统文件描述符限制
  - poll 和 select 并没有太大的本质区别，都是使用「线性结构」存储进程关注的 Socket 集合，因此都需要遍历文件描述符集合来找到可读或可写的 Socket，时间复杂度为 O(n)，而且也需要在用户态与内核态之间拷贝文件描述符集合，这种方式随着并发数上来，性能的损耗会呈指数级增长
* epoll
  - Linux 2.6内核提供了新的epoll系统调用，可以维持无限数量的连接，而且无需轮询，这才真正解决了 C10K 问题
  - select/poll 问题:需要循环检测连接是否有事件,如果服务器有100万个连接，在某一时间只有一个连接向服务器发送了数据，select/poll需要做循环100万次，其中只有1次是命中的，剩下的99万9999次都是无效的，白白浪费了CPU资源.在epoll出世前，QQ用户量剧增，但是select以及select的高配版本poll都无法解决他们的问题，于是乎QQ当年的服务器就不得不用UDP协议来避规这个问题，一直到后来有了epoll，QQ开始逐步在PC客户端中的配置项中允许用户选择UDP服务器或TCP服务器
  - epoll 通过两个方面，很好解决了 select/poll 的问题
    + 内核中保存一份文件描述符集合，无需用户每次都重新传入，只需告诉内核修改的部分即可
    + 内核仅会将有 IO 事件的文件描述符返回给用户，用户也无需遍历整个文件描述符集合。epoll 在内核里使用红黑树来跟踪进程所有待检测的文件描述字，把需要监控的 socket 通过 epoll_ctl() 函数加入内核中的红黑树里，红黑树是个高效的数据结构，增删查一般时间复杂度是 O(logn)，通过对这棵黑红树进行操作，这样就不需要像 select/poll 每次操作时都传入整个 socket 集合，只需要传入一个待检测的 socket，减少了内核和用户空间大量的数据拷贝和内存分配。
    + 内核不再通过轮询的方式找到就绪的文件描述符，而是通过异步 IO 事件唤醒。epoll 使用事件驱动的机制，内核里维护了一个链表来记录就绪事件，当某个 socket 有事件发生时，通过回调函数内核会将其加入到这个就绪事件列表中，当用户调用 epoll_wait() 函数时，只会返回有事件发生的文件描述符的个数，不需要像 select/poll 那样轮询扫描整个 socket 集合，大大提高了检测的效率。
  - epoll 的方式即使监听的 Socket 数量越多的时候，效率不会大幅度降低，能够同时监听的 Socket 的数目也非常的多了，上限就为系统定义的进程打开的最大文件描述符个数。因而，epoll 被称为解决 C10K 问题的利器。
  - `epoll_wait` 实现的内核代码中调用了 `__put_user` 函数，将数据从内核拷贝到用户空间
  - 各种高并发异步IO的服务器程序都是基于epoll实现的，比如Nginx、Node.js、Erlang、Golang。像 Node.js，Redis 这样单进程单线程的程序，都可以维持超过1百万TCP连接，全部归功于epoll技术
  - 事件触发模式
    + 边缘触发（edge-triggered，ET）当被监控的 Socket 描述符上有可读事件发生时，服务器端只会从 epoll_wait 中苏醒一次，即使进程没有调用 read 函数从内核读取数据，也依然只苏醒一次，因此我们程序要保证一次性将内核缓冲区的数据读取完
      * 只有第一次满足条件的时候才触发，之后就不会再传递同样的事件了
      * 收到通知后应尽可能地读写数据，以免错失读写的机会。因此，会循环从文件描述符读写数据，那么如果文件描述符是阻塞的，没有数据可读写时，进程会阻塞在读写函数那里，程序就没办法继续往下执行。所以，边缘触发模式一般和非阻塞 I/O 搭配使用，程序会一直执行 I/O 操作，直到系统调用（如 read 和 write）返回错误，错误类型为 EAGAIN 或 EWOULDBLOCK。
    + 水平触发（level-triggered，LT）当被监控的 Socket 上有可读事件发生时，服务器端不断地从 epoll_wait 中苏醒，直到内核缓冲区数据被 read 函数读完才结束，目的是告诉有数据需要读取
      * 只要满足事件的条件，比如内核中有数据需要读，就一直不断地把这个事件传递给用户
      * 当内核通知文件描述符可读写时，接下来还可以继续去检测它的状态，看它是否依然可读或可写。所以在收到通知后，没必要一次执行尽可能多的读写操作。
    + 边缘触发的效率比水平触发的效率要高，因为边缘触发可以减少 epoll_wait 的系统调用次数，系统调用也是有一定的开销的的，毕竟也存在上下文的切换。
    + select/poll 只有水平触发模式，epoll 默认的触发模式是水平触发
  - 多线程+epoll的模式下,有效的压榨CPU性能
  - 基于 epoll 实现的 Reactor 模型.IO复用异步非阻塞程序使用经典的Reactor模型，它本身不处理任何数据收发。只是可以监视一个socket句柄的事件变化
    + 主进程/线程往epoll内核事件中注册socket上的读就绪亊件
    + 主进程/线程调用epoll_wait等待socket上有数据可读。
    + 当socket上有数据可读时，epoll_wait通知主进程/线程。主进程/线程则将socket可读事件放入请求队列。
    + 睡眠在请求队列上的某个工作线程被唤醒，它从socket读取数据，并处理客户请求， 然后往epoll内核事件表中注册该socket上的写就绪事件。
    + 主线程调用epoll_wait等待socket可写。
    + 当socket可写时，epoll_wait通知主进程/线程主进程/线程将socket可写事件放入请求队列。
    + 睡眠在请求队列上的某个工作线程被唤醒，它往socket上写入服务器处理客户请求

![同步阻塞IO](,,/_static/block_io.png "Optional title")
![同步非阻塞IO](,,/_static/sync_no_block.png "Optional title")
![多路复用IO模型](,,/_static/mutal_reuse.png "Optional title")
![reactor](../_satic/eventloop.png "Optional title")

```c
// accept 监听
fdlist.add(connfd);

// 新的线程不断遍历
while(1) {
  for(fd <-- fdlist) {
    if(read(fd) != -1) {
      doSomeThing();
    }
  }
}

int select(
    int nfds,
    fd_set *readfds,
    fd_set *writefds,
    fd_set *exceptfds,
    struct timeval *timeout);
// nfds:监控的文件描述符集里最大文件描述符加1
// readfds：监控有读数据到达文件描述符集合，传入传出参数
// writefds：监控写数据到达文件描述符集合，传入传出参数
// exceptfds：监控异常发生达文件描述符集合, 传入传出参数
// timeout：定时阻塞监控时间，3种情况
//  1.NULL，永远等下去
//  2.设置timeval，等待固定时间
//  3.设置timeval里时间均为0，检查描述字后立即返回，轮询

// 线程不断接受客户端连接，并把 socket 文件描述符放到一个 list 里
while(1) {
  connfd = accept(listenfd);
  fcntl(connfd, F_SETFL, O_NONBLOCK);
  fdlist.add(connfd);
}
// 另一个线程调用 select，将这批文件描述符 list 交给操作系统去遍历
while(1) {
  // 把一堆文件描述符 list 传给 select 函数
  // 有已就绪的文件描述符就返回，nready 表示有多少个就绪的
  nready = select(list);
  ...
}
while(1) {
  nready = select(list);
  // 用户层依然要遍历，只不过少了很多无效的系统调用
  for(fd <-- fdlist) {
    if(fd != -1) {
      // 只读已就绪的文件描述符
      read(fd, buf);
      // 总共只有 nready 个已就绪描述符，不用过多遍历
      if(--nready == 0) break;
    }
  }
}

int poll(struct pollfd *fds, nfds_tnfds, int timeout);

struct pollfd {
  intfd; /*文件描述符*/
  shortevents; /*监控的事件*/
  shortrevents; /*监控事件中满足条件返回的事件*/
};

// 创建一个 epoll 句柄
int epoll_create(int size);
// 向内核添加、修改或删除要监控的文件描述符。
int epoll_ctl( int epfd, int op, int fd, struct epoll_event *event);
// 类似发起了 select() 调用
int epoll_wait(int epfd, struct epoll_event *events, int max events, int timeout);
```

## Wi-Fi

* 高质量无线 LAN.是 WECA（无线以太网兼容性联盟）为普及 IEEE802.11 的各种标准而打造的一个品牌
* 从 02 年开始更名为 Wi-Fi Appliance，该组织向 Wi-Fi 设备厂商提供 IEEE802.11 产品的互操性测试，并对合格的产品颁发 Wi-Fi Certified认证，因此，带有 Wi-Fi 标志的无线 LAN 设备意味着该产品已经过互操性测试并通过认证

## OSPF 开放式最短链路优先

* 一个内部网关协议(Interior Gateway Protocol,简称IGP)。OSPF通过路由器之间通告网络接口的状态来建立链路状态数据库，生成最短路径树，OSPF会自动计算路由接口上的Cost值，但也可以通过手工指定该接口的Cost值，手工指定的优先于自动计算的值。
* OSPF计算的Cost，同样是和接口带宽成反比，带宽越高，Cost值越小。到达目标相同Cost值的路径，可以执行负载均衡，最多6条链路同时执行负载均衡。

## Overlay 网络

* 构建在另一个网络上的计算机网络,一种网络虚拟化技术的形式,不能独立出现，Overlay 底层依赖的网络就是 Underlay 网络
* Underlay 网络是专门用来承载用户 IP 流量的基础架构层，它与 Overlay 网络之间的关系有点类似物理机和虚拟机。
  - Underlay 网络和物理机都是真正存在的实体，它们分别对应着真实存在的网络设备和计算设备
  - Overlay 网络和虚拟机都是依托在下层实体使用软件虚拟出来的层级。
* 使用虚拟局域网扩展技术（Virtual Extensible LAN，VxLAN）组建 Overlay 网络
  - 使用虚拟隧道端点（Virtual Tunnel End Point、VTEP）设备对服务器发出和收到的数据包进行二次封装和解封
  - 数据包的传输过程中，通信的双方都不知道底层网络做的这些转换，认为两者可以通过二层的网络互相访问，但是实际上经过了三层 IP 网络的中转，通过 VTEP 之间建立的隧道实现了连通
* 利用底层网络在多数据中心之间组成二层网络，但是它的封包和拆包过程也会带来额外开销
* 组成：
  - 边缘设备：是指与虚拟机直接相连的设备
  - 控制平面：主要负责虚拟隧道的建立维护以及主机可达性信息的通告
  - 转发平面：承载 Overlay 报文的物理网络
* 基于隧道封装技术
  - VXLAN（Virtual eXtensible LAN）
  - TRILL（Transparent InterconnecTIon of Lots of Links）技术是电信设备厂商主推的新型环网技术
  - NVGRE（Network VirtualizaTIon using Generic RouTIng EncapsulaTIon）
  - STT（Stateless Transport Tunneling Protocol）
* 解决
  - 云计算中集群内的、跨集群的或者数据中心间的虚拟机和实例的迁移比较常见；
    + 保证业务不中断，需要保证迁移过程中的 IP 地址不变，因为 Overlay 是在网络层实现二层网络，所以多个物理机之间只要网络层可达就能组建虚拟的局域网，虚拟机或者容器迁移后仍然处于同一个二层网络，也就不需要改变 IP 地址
    + 使用 VxLAN 构成二层网络中，虚拟机在不同集群、不同可用区和不同数据中心迁移后，仍然可以保证二层网络的可达性，这能够帮助我们保证线上业务的可用性、提升集群的资源利用率、容忍虚拟机和节点的故障
  - 单个集群中的虚拟机规模可能非常大，大量的 MAC 地址和 ARP 请求会为网络设备带来巨大的压力
    + 网络只需要知道不同 VTEP 的 MAC 地址，由此可以将 MAC 地址表项中的几十万条数据降低到几千条，ARP 请求也只会在集群中的 VTEP 之间扩散，远端的 VTEP 将数据拆包后也仅会在本地广播，不会影响其他的 VTEP，虽然这对于集群中的网络设备仍然有较高的要求，但是已经极大地降低了核心网络设备的压力
    + 集群中虚拟机的规模可能是物理机是几十倍，与物理机构成的传统集群相比，虚拟机构成的集群包含的 MAC 地址数量可能多一两个数量级，网络设备很难承担如此大规模的二层网络请求，Overlay 网络通过 IP 封包和控制平面可以减少集群中的 MAC 地址表项和 ARP 请求
  - 传统的网络隔离技术 VLAN 只能建立 4096 个虚拟网络，公有云以及大规模的虚拟化集群需要更多的虚拟网络才能满足网络隔离的需求
    + 大规模的数据中心往往都会对外提供云计算服务，同一个物理集群可能会被拆分成多个小块分配给不同的租户（Tenant），因为二层网络的数据帧可能会进行广播，所以出于安全的考虑这些不同的租户之间需要进行网络隔离，避免租户之间的流量互相影响甚至恶意攻击
    + 传统的网络隔离会使用虚拟局域网技术（Virtual LAN、VLAN），VLAN 会使用 12 比特表示虚拟网络 ID，虚拟网络的上限是 4096 个
    + VxLAN 使用 24 比特的 VNI 表示虚拟网络个数，总共可以表示 16,777,216 个虚拟网络

## VPC

* 通过子网将资源进行逻辑隔离为用户提供隔离的网络环，可以灵活的定义子网网段，并支持随时在现有 VPC 中追加新的定义网段，保证地址取之不尽，解决传统子网带来的节点数量的限制。并可以使用 VPN 等方式连接本地数据中心后将业务平滑迁移到云端
* VPC 内连接互联网
  - VPC 内使用子网将资源进行了隔离，初始情况下子网内资源无法连接到互联网，所有资源和服务仅可内网访问，起到了预想的与公网隔离的效果。但如果资源只能内网访问显然也不是我们想要的，我们创建的 Web 应用等服务需要暴露在公网上，也就需要将 VPC 子网内的资源具有访问互联网的能力。
  - 为 VPC 子网内每一个云主机资源绑定 EIP；通过 NAT 网关将 VPC 子网内资源路由至 NAT 网关，并通过其绑定的 EIP 连接互联网。
  - 实现
    + 创建 VPC 及子网 subnet-a，并部署相关云主机等资源；
    + 选择使用 EIP 方式，申请 EIP 并绑定至云主机 UHost，则云主机 UHost 可以通过 EIP 与互联网进行连接；这种方式配置最简单，但是却要为每一台云主机 UHost 绑定 EIP，如果资源数量较多，不建议使用这种方式
    + 选择使用 NAT 网关方式，在 VPC 中创建 NAT 网关并选择 subnet-a 连通，此时子网 subnet-a 中的所有资源将会路由至 NAT 网关，并通过绑定在 NAT 网关上的 EIP 连接互联网；这种方式通过一个配置即可满足一个子网内资源的连接互联网需求；
    + 云主机绑定 EIP 方式与 NAT 网关方式，两者只能取其一进行使用。
* 通过 VPC 子网隔离内外网组件
  - 将资源和组件划分为互联网可访问、互联网不可访问进行隔离
  - 在 VPC 中创建子网 subnet-a（供连接互联网），创建 subnet-b（供内网使用），通过 NAT 网关只连接 subnet-a 并面向互联网开放；subnet-b 不连接到该 NAT 网关并且其中资源也不绑定 EIP。
  - 实现
    + 创建 VPC;
    + 创建两个子网 subnet a 和 subnet b，subnet a 为前端接入子网，部署云主机；subnet b 为数据库子网部署云数据库；
    + 配置 NAT 网关，并连接前端接入子网 subnet-a，使其可以连接到互联网，对外提供前端接入功能；数据库子网 subnet-b 只能仅在 VPC 内访问，前端接入子网中的云主机 UHost 可以连接后端业务子网中的后端服务器和云数据库并实现业务支撑和数据操作。
  - 场景
    + 数据库私有子网中只能内网访问，但是仍会碰到云数据库进行版本更新、漏洞修复等需要访问互联网的情况。基于这种临时需求，可以通过 NAT 网关的白名单模式来连接互联网。在 NAT 网关配置中添加 subnet-b，但是需要使用白名单模式，仅允许开放指定数据库的特定端口，尽可能避免全部暴露在互联网。
* 云平台多 VPC 之间互联
  - UCloud 云平台支持跨地域、跨项目的多个 VPC 连接，可在控制台直接操作配置。
  - 实现
    - 在云平台 VPC 配置中直接选择多个 VPC，可直接实现 VPC 联通 ;
    - 在 VPC1 中所有流量会路由至 VPC 虚拟 NAT 网关，同样 VPC2 中所有流量会路由至虚拟 NAT 网关 2;
    - UCloud 云平台会自动将 VPC1 和 VPC2 进行连接，便可以实现两个 VPC 之间的流量传输。
* 连接本地网络与云端 VPC
  - 用户业务部署在多个地域或者本地数据中心，需要将业务进行联通。
  - 使用 VPN、专线接入 UConnect 连接本地数据中心 VPC 子网与 UCloud 云平台的 VPC 子网；
  - 使用跨域通道 UDPN 连接 UCloud 云平台的多个 VPC 子网
  - 实现
    + 在云端部署 VPC 公网子网、私网子网，并部署业务所需云平台资源；
    + 在云端配置 IPSec VPN，其中配置云端网关地址、客户本地（对端）网关地址；
    + 在客户本地安装 VPN 软件，并配置客户本地网关、云端网关；
    + 在云端和客户本地 VPN 中配置 VPN 隧道（tunnel）并连通指定子网，测试流量正常。
  - 场景：混合云架构

## 网络抖动

## 性能

* 连接指标
  - 连接相关:服务端能保持，管理，处理多少客户端的连接
    + 活跃连接数：所有ESTABLISHED状态的TCP连接，某个瞬时，这些连接正在传输数据。如果您采用的是长连接的情况，一个连接会同时传输多个请求。也可以间接考察后端服务并发处理能力，注意不同于并发量。
    + 非活跃连接数：表示除ESTABLISHED状态的其它所有状态的TCP连接数。
    + 并发连接数：所有建立的TCP连接数量。=活跃连接数+非活跃连接数。
    + 新建连接数：在统计周期内，从客户端连接到服务器端，新建立的连接请求的平均数。主要考察应对突发流量或从正常到高峰流量的能力。如：秒杀、抢票场景。
    + 丢弃连接数：每秒丢弃的连接数。如果连接服务器做了连接熔断处理，这部分数据即熔断的连接。
    + 关于tcp连接数量，在linux下，跟文件句柄描述项有关，可以ulimit -n查看，也可修改。其它就是跟硬件资源cpu、内存、网络带宽有关。单机可以做到数十万级的并发连接数，如何实现呢？后面IO模型时讲解。
  - 流量相关:主要是网络带宽的配置
    + 流入流量：从外部访问服务器所消耗的流量
    + 流出流量：服务器对外响应的流量
  - 数据包数:数据包是TCP三次握手建立连接后，传输的内容封装
    + 流入数据包数：服务器每秒接到的请求数据包数量。
    + 流出数据包数：服务器每秒发出的数据包数量。
    + 关于TCP/IP包的细节请查阅相关文档。但是有一点一定注意，我们单次请求可能会分成多个包发送，拆包、粘包问题网络中间件都会为我们处理（比如消息补齐、回车结尾、自定义消息头体、自定义协议等解决方案）。如果我们传递的用户数据较小，那么效率肯定会提升。反过来无限制的压缩传输包的大小，解压也会耗费cpu资源，需平衡处理
  - 应用传输协议:传输协议压缩率好，传输性能好，对并发性能提升高。但是也需要看调用双方的语言可以使用协议才行。可以自己定义，也可以使用成熟的传输协议。比如redis的序列化传输协议、json传输协议、Protocol Buffers传输协议、http协议等。尤其在 rpc调用过程中，这个传输协议选择需要仔细甄别选型。
* 并发连接与并发量
  - 并发连接数：=活跃连接数+非活跃连接数。所有建立的TCP连接数量。网络服务器能并行管理的连接数。
  - 活跃连接数：所有ESTABLISHED状态的TCP连接。
  - 并发量：瞬时通过活跃连接传输数据的量，这个量一般在处理端好评估。跟活跃连接数没有绝对的关系。网络服务器能并行处理的业务请求数。
  - rt响应时间：各类操作单机rt肯定不相同。比如：从cache中读数据和分布式事务写数据库，资源的消耗不同，操作时间本身就不同。
  - 吞吐量：QPS/TPS，每秒可以处理的查询或事务数，这个是关键指标
  - 从系统整体层面、各个服务个体、服务中某个方法都需综合考虑
    + 打开商品详情页操作，需要动静分离。后续一连串的动态服务、cache机制，整体rt本身会短，单机可以支持的qps较高。（服务间、方法间也有差别）
    + 提交订单操作需要分布式事务、分布式锁等，rt本身会长，单机可支持的qps较低。
    + 那是否我们就会针对订单提交的服务部署更多机器呢？答案是不一定。因为用户浏览商品的频度会很高，而提交订单的频度很低。如何正确的评估呢？
    + 需要服务分类：关键服务/非关键服务、高峰各服务的qps需求，来均衡考虑
* 网络应用应该考虑平衡 处理连接能力 与 能管理连接请求（连接 请求 响应） 达到平衡：客户端请求会形成一个大队列；服务器会处理这个大队列中的任务。这个队列能有多大，看连接管理能力；如何保证进入队列任务的速率和处理移除任务的速度平衡，是关键。达到平衡是目的

## 网络编程:用Sockets API开发基于TCP/IP的网络应用程序

* Sockets API 很少用，大多数时候使用封装好的网络库。 


![Web 服务器请求周期](../_static/web_request_response.png "Optional title")

```sh
netstat -an
```

## 穿透

### [frp](https://github.com/fatedier/frp)

A fast reverse proxy to help you expose a local server behind a NAT or firewall to the internet. 将内网资源映射到公网

* 服务器端配置：Frps和Frps.ini
* 客户端配置：Frpc和Frpc.ini
* 隧道类型：
  - TCP 映射 基础的 TCP 映射，适用于大多数服务，例如远程桌面、SSH、Minecraft、泰拉瑞亚等
  - UDP 映射 基础的 UDP 映射，适用于域名解析、部分基于 UDP 协议的游戏等
  - HTTP 映射 搭建网站专用映射，并通过 80 端口访问。
  - HTTPS 映射 带有 SSL 加密的网站映射，通过 443 端口访问，服务器需要支持 SSL。
  - XTCP 映射 客户端之间点对点 (P2P) 连接协议，流量不经过服务器，适合大流量传输的场景，需要两台设备之间都运行一个客户端
  - STCP 映射 安全交换 TCP 连接协议，基于 TCP，访问此服务的用户也需要运行一个客户端，才能建立连接，流量由服务器转发
* 参考
  - [提供frp服务器](https://www.ioiox.com/frp.html)

```sh
# Frps.ini文件最初配置 指定了当服务器端启动Frp后监听的端口是7000端口，也就是内网和服务器进行交互的端口，可以修改为其他的端口
[common]
bind_port = 8002 # 服务器端端口
privilege_token = fxl421125 # 客户端连接凭证
max_pool_count = 5 # 最大连接数
vhost_http_port = 8003 # 客户端映射的端口
dashboard_port = 7500 # 服务器看板的访问端口
dashboard_user = admin # 服务器看板账户
dashboard_pwd = fxl123
vhost_http_port = 8003 # 以后访问web服务需要用到的端口

./frps -c frps.ini # 启动Frp服务

# Frpc.ini初始配置
[common]
server_addr = 188.45.34.21 # 公网服务器的公网IP
server_port = 8002 # 服务器端Frp监听的端口 与Frps.ini中的配置端口一致
privilege_token = fxl123 # 服务器连接凭证

[ssh]
type = tcp
local_ip = 127.0.0.1 # 内网机器的IP
local_port = 22
remote_port = 8004 # 指定的需要映射到公网服务器上的端口

[nas]
type = http
local_port = 5000
custom_domains = no1.sunnyrx.com # 域名的A记录要解析到外网主机的IP

[web]
privilege_mode = true
remote_port = 6000
type = http
local_port = 80 # 监视本地的http服务端口
use_gzip = true
custom_domains = manager.fanxl.cn # 绑定域名 域名需要配置好解析，解析到服务器

./frpc -c frpc.ini

# 通过服务器公网IP和8004端口来连接内网机器了（ssh）
ssh -p remote_port username@server_addr
```

### [ngrok](https://github.com/inconshreveable/ngrok)

* Introspected tunnels to localhost
* an application that gives you external (internet) access to your private systems that are hidden behind NAT or a firewall.
* [](https://ngrok.com/):Spend more time programming. One command for an instant, secure URL to your localhost server through any NAT or firewall.
* public URLs for sending previews to clients
* demoing local functionality with external people.

```sh
ngrok http -auth=”youruser:yourpassword” 8181

ngrok http https://localhost:8181

ngrok tcp 22
ngrok tcp 3389
```

## 网卡

* lo loopback 环回接口:往往会被分配到 127.0.0.1 这个地址。用于本机通信，经过内核处理后直接返回，不会在任何网络中出现
* eth0
* wlp2s0
- 网络设备状态标识 <BROADCAST,MULTICAST,UP,LOWER_UP>
	+ UP 表示网卡处于启动的状态
	+ BROADCAST 表示这个网卡有广播地址，可以发送广播包
	+ MULTICAST 表示网卡可以发送多播包
	+ LOWER_UP 表示 L1 是启动的，也就是网线是插着的

## 管理

### Network manager

```sh
nmcli device # Display network devices
nmcli device show eth0 # Show information about eth0 device

nmcli connection # Show network connections
nmcli connection up foo # Bring connection foo up

nmcli device wifi connect foo # Connect to wireless network foo
```

### Routing

```sh
ip route # Show current routes
route add default gw 10.0.0.1 # Add 10.0.0.1 as default gateway to routing table
ip addr show # Show your local IP address
ip neighbor # show Show neighbors
arp # Show neighbors
```

### Firewall

```sh
firewall-cmd --get-active-zones # List active firewall zones
-–change-interface eth0 --zone=example # Place eth0 into example zone
--get-services # List all defined services
--add-service samba --zone=example # Add samba ports to example zone
--add-port=123/tcp --zone=example # Add port 123 to example zone
--permanent # Add this flag to make a change persistent
```

## 工具集

*  ping traceroute mtr 都使用的 “ICMP” 包来测试 Internet 两点之间的网络连接状况

### ip

* 归属于 iproute2 工具集，iproute2 旨在取代 net-tools，并提供了一些新功能

```sh
ip address show

# 手动分配 IP 地址
sudo ip address add 169.254.0.1 dev eth0

# 查看交互邻居
ip neighbour
```

### ipconfig

* 用于显示当前TCP/IP配置的设置值
* 属于 net-tools 工具集。net-tools 起源于 BSD，自 2001 年起，Linux 社区已经停止对其进行维护

```sh
ipconfig # 显示每个已经配置了的接口的IP地址、子网掩码和缺省网关值
ipconfig /all # 为DNS和WINS服务器显示它已配置且所有使用的附加信息，并且能够显示内置于本地网卡中的物理地址（MAC）
```

### route

```sh
# 查看路由表
route

# 添加一条路由信息
# 为 `eth0` 接口添加一个地址范围（从 `169.254.0.0` 开始到 `169.254.0.255` 结束）的路由。路由协议设置为“静态”，表示作为管理员创建了这个路由，作为对该范围内的任何动态路由进行覆盖。
sudo ip route \
	add 169.254.0.0/24 \
	dev eth0 \
	proto static
```

### ping

* verify connectivity between you and a remote system
* 网路连通性探测:确定网络是否正确连接，以及网络连接的状况,是ICMP的最著名应用
* 实现长时间的网络监控
* 原理：用类型码为0的ICMP发请求，受到请求的主机则用类型码为8的ICMP回应
* 参数
  - -c: 执行 ping 操作的次数, 默认是一直执行, 除非被中断
  - -D 显时间戳
  - -i: 每次执行 ping 操作的间隔时间, 默认是 1s
	- [-l] :定义所发送数据包的大小，默认为32字节
	- [-n] :定义所发数据包的次数
  - -s: 指定执行 ping 操作时发送的包的大小, 默认是 56B, 添加报文头之后, 最终发送的是 64B
	- [-t] :表示不间断向目标IP发送数据包
* 使用 fflush()，不然文件不会有信息，因为 awk 有缓存
* pingpong:一种数据缓存的手段，通过 pingpong 操作可以提高数据传输的效率
  - 什么时候需要 pingpong？在两个模块间交换数据时，上一级处理的结果不能马上被下一级所处理完成，这样上一级必须等待下一级处理完成才可以送新的数据，这样就会对性能产生很大的损失。
  - 引入 pingpong 后我们可以不去等待下一级处理结束，而是将结果保存在 pong 路的缓存中，pong 路的数据准备好的时刻，ping 路的数据也处理完毕（下一级），然后无需等待直接处理 pong 路数据，上一级也无需等待，转而将结果存储在 ping 路。这样便提高了处理效率。
- [gping](https://github.com/orf/gping) Ping, but with a graph

```sh
# local host是系统网络保留名，是127.0.0.1的别名，每台计算机都应该能够将该名字转换成该地址。
# 否则，则表示主机文件（/Windows/host）中存在问题。
ping localhost
ping6 example.com

# 如果测试成功，表明网卡、TCP/IP协议的安装、IP地址、子网掩码的设置正常
# 如果测试不成功，表示TCP/IP的安装或设置存在有问题，表示本地配置或安装存在问题，应当对网络设备和通讯介质进行测试、检查并排除。
ping 127.0.0.1

# 如果测试成功，表明本地网络中的网卡和载体运行正确
# 如果收到0个回送应答，那么表示子网掩码不正确或网卡配置错误或电缆系统有问题。
ping 局域网内其他IP

# 如果应答正确，表示局域网中的网关路由器正在运行并能够做出应答。
ping 网关IP

# 如果收到正确应答，表示成功的使用了缺省网关。对于拨号上网用户则表示能够成功的访问Internet（但不排除ISP的DNS会有问题）
ping 远程IP

## 对域名执行，必须先将域名转换成IP地址，通常是通过DNS服务器
# 出现故障，则表示本机DNS服务器的IP地址配置不正确，或它所访问的DNS服务器有故障
# 能正常运行，那么计算机进行本地和远程通信基本上就没有问题
#
# 命令的成功并不表示所有的网络配置都没有问题，例如，某些子网掩码错误就可能无法用这些方法检测到
ping www.yahoo.com

ping baidu.com | awk '{ print strftime("%Y.%m.%d %H:%M:%S",systime())"\t"$0; fflush() }'
ping baidu.com | awk '{"date" | getline date; print date,$0}'
ping baidu.com | awk -v date="$(date +"%Y-%m-%d %r")" '{print date, $0}'

# 未加 fflush()，执行命令生成文件会等一会才会有信息打印到文件里
nohup ping baidu.com | awk '{ print strftime("%Y-%m-%d %H:%M:%S",systime())"\t" $0; fflush() }' >> long_ping.txt &

nohup ping baidu.com -i 1 | while read pong; do echo "$(date +"%Y-%m-%d %H:%M:%S") | $pong"; done | tee -a ping-baidu.com.log &
```

* ifconfig/ipaddr:查看服务器网卡，IP等信息
  - CIDR 地址中包含标准的32位IP地址和有关网络前缀位数的信息。比如10.172.100.3/24，IP地址斜杠后面数字24，代表24位是网络号，后面八位为主机号
  - 使用IP地址和子网掩码进行AND计算得到网络号
* [tcpdump](./tcpdump.md):类似工具在windows中是wireshark
* lsof 列出当前系统打开的文件描述符
* dpkt定义包packet类，网络报文类型的基础类
  - IP，ICMP等继承于dpkt class，每一个子类有一个_hdr_ 结构，此结构定义了不同报文的头部，方便取出相应的控制字段
* scapy:嗅探包不是爬虫框架scrapy

### nslookup

* query Internet name servers

```sh
# Display your DNS server and target IP address
nslookup example.com
```

### Traceroute

* trace the path from one system to another, including routers in between
* 侦测主机到目的主机之间所经路由情况的重要工具。
* 收到到目的主机的IP后，首先给目的主机发送一个TTL=1的UDP数据包，而经过的第一个路由器收到这个数据包以后，就自动把TTL减1，而TTL变为0以后，路由器就把这个包给抛弃了，并同时产生一个主机不可达的ICMP数据报给主机。
* 主机收到这个数据报以后再发一个TTL=2的UDP数据报给目的主机，然后刺激第二个路由器给主机发ICMP数据 报。如此往复直到到达目的主机。这样，traceroute就拿到了所有的路由器IP

```sh
traceroute google.com
```

### Telnet

* connect to ports and query them for functionality

```sh
openssl s_client -starttls smtp \
-connect example.com:587
telnet example.com 110
```

### netstat network status

* analyze interface, port, protocol statistics, and routing tables
* 一个网络信息统计工具。可以得到网卡接口上全部数据，路由表信息，网卡接口信息,列出系统上所有的网络套接字连接情况，包括 tcp, udp 以及 unix 套接字，另外还能列出处于监听状态（即等待接入请求）的套接字
* 参数
	* --listening -l List ports in listening mode
	  - --all -a List all ports
	  - --route -r Display routing tables
	  - -t 列出 TCP 协议连接
	  - -u 列出 UDP 协议连接
	  - --interfaces -i Display TX/RX packet statistics for each interface
	  - -n 禁用域名解析功能. 默认情况下 netstat 会通过反向域名解析技术查找每个 IP 地址对应的主机名,降低查找速度。如果觉没有必要知道主机名

```sh
# 列出所有连接
netstat -a
# 只列出TCP|UDP
netstat -at|au

# 列出监听中连接
netstat -tnl

# 获取进程名、进程号以及用户 ID
nestat  -nlpt
netstat -tulpn

# 打印统计信息
netstat -s

# netstat持续输出
netstat -ct

# 打印active状态连接
netstat -atnp | grep ESTA

# 查看服务是否运行(npt)
netstat -aple| grep ntp

netstat -an | grep 3306
netstat -tunlp |grep 端口号 # 查看指定的端口号的进程情况 -t 显示tcp -u udp -n:拒绝显示别名，能数字数字 -l 列出在listen 服务状态 -p 显示相关程序名
lsof -i:80 # -i参数表示网络链接，:80指明端口号

ip netns exec


netstat -anlp|grep 80|grep tcp|awk '{print $5}'|awk -F: '{print $1}'|sort|uniq -c|sort -nr|head -n20 # 查看连接服务器 top10 用户端的 IP 地址
netstat -nat | awk  '{print  $5}' | awk -F ':' '{print $1}' | sort | uniq -c | sort -rn | head -n 10
netstat -nat |awk ‘{print $6}’|sort|uniq -c|sort -rn
ping api.jpush.cn | awk ‘{ print $0”    “ strftime(“%Y-%m-%d %H:%M:%S”,systime()) } ‘ >> /tmp/jiguang.log &

wget ftp://ftp.is.co.za/mirror/ftp.rpmforge.net/redhat/el6/en/x86_64/dag/RPMS/multitail-5.2.9-1.el6.rf.x86_64.rpm
yum -y localinstall multitail-5.2.9-1.el6.rf.x86_64.rpm
multitail -e "Accepted" /var/log/secure -l "ping baidu.com"

ps -aux | sort -rnk 3 | head -20
ps -aux | sort -rnk 4 | head -20

cat .bash_history | sort | uniq -c | sort -rn | head -n 10 (or cat .zhistory | sort | uniq -c | sort -rn | head -n 10 # 查看一下最常用的10个命令

# 输出nginx日志的ip和每个ip的pv，pv最高的前10
#2019-06-26T10:01:57+08:00|nginx001.server.ops.pro.dc|100.116.222.80|10.31.150.232:41021|0.014|0.011|0.000|200|200|273|-|/visit|sign=91CD1988CE8B313B8A0454A4BBE930DF|-|-|http|POST|112.4.238.213
awk -F"|" '{print $3}' access.log | sort | uniq -c | sort -nk1 -r | head -n10
```

### [Tcpdump](http://www.tcpdump.org/)

* 命令行中通过指定表达式输出匹配捕获到的数据包的信息
* 采用底层库winpcap/libpcap实现，bpf过滤机制
* Packet structure
	* The TCP flags are in `tcp[13]` :
		* ACK = 0×10,
		* RST = 0×04
		* SYN = 0×02
		* FIN = 0×01
	* The ICMP type is in` icmp[0]` 
		- 0 (echo response),
		- 3 (destination unreachable)
		- 8 (echo request) 
		- 11 (time exceeded).
	- IPv6
		- The transport layer protocol number is in the `ip6[6]` (“next header”) field
			- ICMP = 0×01
			- TCP = 0×06
			- UDP = 0×11
		- The IPv6 header is 40 bytes, assuming no extension headers, so `tcp[13]` maps to` ip6[53]` and `icmp[0]` maps to `ip6[40]`
- Recipes
	- Rejected : Capture RST and ICMP Destination Unreachable packets, useful when debugging a firewall to see what it rejects:`((tcp[13] & 4 == 4 ) || (ip6[6] == 6 && ip6[53] & 4 == 4 ) || (icmp[0] == 3) | | (icmp6 && ip6[40] == 1 ))`
	- Successful TCP handshakes Capture SYN+ACK packets to monitor successful TCP handshakes: `((tcp[13] & 0x12 = = 0x12 ) || (ip6[6] == 6 && ip6[53]&0x12 == 0x12 ))`
	- TCP termination Capture FIN+ACK packets to monitor TCP session terminations:`((tcp[13] & 0x11 == 0x11 ) || (ip6[6] == 6 && ip6[53] & 0x11 == 0x11 ))`
	- IPv6 neighbor and router discovery Capture ICMP6 neighbor solicitation / advertisement packets (135, 136) and ICMP6 router solicitation / advertisement / redirect packets (133, 134, 137): `(icmp6 && (ip6[40] >= 133 && ip6[40] <= 137))`
* 参数
  - -a 将网络地址和广播地址转变成名字
  - -A 打印ascii
  - -c 在收到指定包的数目后，tcpdump就会停止 Only get x number of packets and then stop.
  - -d 将匹配信息包的代码以人们能够理解的汇编格式给出
  - -D Show the list of available interfaces
  - -dd 将匹配信息包的代码以c语言程序段的格式给出
  - -ddd 将匹配信息包的代码以十进制的形式给出
  - -e 在输出行打印出数据链路层的头部信息 Get the ethernet header as well.
  - -E Decrypt IPSEC traffic by providing an encryption key.
  - -f 将外部的Internet地址以数字的形式打印出来
  - -F 从指定的文件中读取表达式,忽略其它的表达式
  - `-i eth0` 指定网卡
    + -i any get all interfaces
  - -l 使标准输出变为缓冲行形式 Line-readable output (for viewing as you save, or sending to other commands)
  - -n 不解析域名
  - -nn 表示端口也是数字，否则解析成服务名,不解析IP地址和端口的名称
  - -q Show less protocol information.
  - -r 从指定的文件中读取包(这些包一般通过-w选项产生)
  - -s 设置抓包长度，0表示不限制 Define the snaplength (size) of the capture in bytes. Use -s0 to get everything, unless you are intentionally capturing less.
  - -S Print absolute sequence numbers.
  - -t 在输出的每一行不打印时间戳 Give human-readable timestamp output.
  - -tttt Give maximally human-readable timestamp output.
  - -T 将监听到的包直接解释为指定的类型的报文，常见的类型有rpc（远程过程调用）和snmp（简单网络管理协议）
  - -v 输出一个稍微详细的信息，例如在ip包中可以包括ttl和服务类型的信息
  - -vv 输出详细的报文信息
  - -w 将抓取的包写入到某个文件中
  - -X 打印hex码 Show the packet’s contents in both hex and ascii.
  - -XX Same as -X, but also shows the ethernet header.
* Combinations
  - 非 : ! or "not" (去掉双引号)
  - 且 : && or "and"
  - 或 : || or "or"
* 参考
  - [](https://hackertarget.com/tcpdump-examples/)

```sh
# networking tool which displays the TCP/IP packets transmitted and received by your system
tcpdump -c 15
tcpdump --help

# 网络过滤
tcpdump net 1.2.3.0/24
# 协议过滤
tcpdump -nn icmp

tcpdump -nn host 192.168.1.100
tcpdump -nn port 80


# find traffic by ip tcpdump host|src｜dst 1.1.1.1`
tcpdump ip6
tcpdump dst 192.168.0.2 and src net and not icmp
tcpdump 'src 10.0.2.4 and (dst port 3389 or 22)'
# verbose output, with no resolution of hostnames or port numbers, using absolute sequence numbers, and showing human-readable timestamps
tcpdump -ttnnvvS
tcpdump -nnvvS src 10.5.2.3 and dst port 3389

tcpdump -nvX src net 192.168.0.0/16 and dst net 10.0.0.0/8 or 172.16.0.0/16

# 端口过滤
tcpdump portrange 21-23
# based on packet size
tcpdump less 32
tcpdump greater 64
tcpdump <= 128

# reading / writing captures to a file (pcap)
tcpdump port 80 -w capture_file
tcpdump -r capture_file

# 抓取所有经过网卡1，目的或源地址IP为172.16.7.206的网络数据
tcpdump -i eth1 [src|dst] host 172.16.7.206
# 抓取所有经过网卡1，目的或源端口为1234的网络数据
tcpdump -i eth1 [src|dst] port 1234
tcpdump -i eth0 host 10.10.1.1

tcpdump -i eth1 [src|dst] net 192.168
# 抓取所有经过网卡1，协议类型为UDP的网络数据
tcpdump -i eth1 udp|arp|ip|tcp|icmp
# 抓取本地环路数据包
tcpdump -i lo udp # 抓取UDP数据
tcpdump -i lo udp port 1234 # 抓取端口1234的UDP数据
tcpdump -i lo port 1234 # 抓取端口1234的数据


# 抓取所有经过网卡1的SYN类型数据包
tcpdump -i eth1 ‘tcp[tcpflags] = tcp-syn’
# 抓取经过网卡1的所有DNS数据包（默认端口）
tcpdump -i eth1 udp dst port 53

# 逻辑语句过滤：抓取所有经过网卡1，目的网络是172.16，但目的主机不是192.168.1.200的TCP数据
tcpdump -i eth1 ‘((tcp) and ((dst net 172.16) and (not dst host 192.168.1.200)))’
# 抓取所有经过 eth1，目标 MAC 地址是 00:01:02:03:04:05 的 ICMP 数据
tcpdump -i eth1 '((icmp) and ((ether dst host 00:01:02:03:04:05)))'
# 抓取所有经过网卡1，目的主机为172.16.7.206的端口80的网络数据并存储
tcpdump -i eth1 host 172.16.7.206 and port 80 -w /tmp/xxx.cap

# 只抓 SYN 包
tcpdump -i eth1 'tcp[tcpflags] = tcp-syn'
# 抓 SYN, ACK
tcpdump -i eth1 'tcp[tcpflags] & tcp-syn != 0 and tcp[tcpflags] & tcp-ack != 0'

# Isolate TCP RST flags.
tcpdump 'tcp[13] & 4!=0'
tcpdump 'tcp[tcpflags] == tcp-rst'

# Isolate TCP SYN flags.
tcpdump 'tcp[13] & 2!=0'
tcpdump 'tcp[tcpflags] == tcp-syn'

# Isolate packets that have both the SYN and ACK flags set.
tcpdump 'tcp[13]=18'

# Isolate TCP URG flags.
tcpdump 'tcp[13] & 32!=0'
tcpdump 'tcp[tcpflags] == tcp-urg'

# Isolate TCP ACK flags.
tcpdump 'tcp[13] & 16!=0'
tcpdump 'tcp[tcpflags] == tcp-ack'

# Isolate TCP PSH flags.
tcpdump 'tcp[13] & 8!=0'
tcpdump 'tcp[tcpflags] == tcp-push'

# Isolate TCP FIN flags.
tcpdump 'tcp[13] & 1!=0'
tcpdump 'tcp[tcpflags] == tcp-fin'

# both syn and rst set
tcpdump 'tcp[13] = 6'

# find http user agents
tcpdump -vvAls0 | grep 'User-Agent:'

# cleartext get requests
tcpdump -vvAls0 | grep 'GET'

# find http cookies
tcpdump -vvAls0 | grep 'Set-Cookie|Host:|Cookie:'

# find dns traffic
tcpdump -vvAs0 port 53

# find ftp traffic
tcpdump -vvAs0 port ftp or ftp-data

# find ntp traffic
tcpdump -vvAs0 port 123

# 抓 SMTP 数据
# 抓取数据区开始为"MAIL"的包，"MAIL"的十六进制为 0x4d41494c。
tcpdump -i eth1 '((port 25) and (tcp[(tcp[12]>>2):4] = 0x4d41494c))'

# 抓取所有经过1234端口的UDP网络数据
tcpdump udp port 1234

# 抓 HTTP GET 数据
tcpdump -i eth1 'tcp[(tcp[12]>>2):4] = 0x47455420' # "GET "的十六进制是 47455420
#抓 SSH 返回
tcpdump -i eth1 'tcp[(tcp[12]>>2):4] = 0x5353482D' # "SSH-"的十六进制是 0x5353482D

# 抓老版本的 SSH 返回信息，如"SSH-1.99.."
tcpdump -i eth1 '(tcp[(tcp[12]>>2):4] = 0x5353482D) and (tcp[((tcp[12]>>2)+4):2]= 0x312E)'
# 抓取端口号8000的GET包，然后写入GET.log
tcpdump -i eth0 '((port 8000) and (tcp[(tcp[12]>>2):4]=0x47455420))' -nnAl -w /tmp/GET.log

# 抓 DNS 请求数据
tcpdump -i eth1 udp dst port 53

# 抓取系统中的get,post请求（非https)
tcpdump -s 0 -v -n -l | egrep -i "POST /|GET /|Host:"

tcpdump -i any tcp and host 192.168.33.10 and port 80 -w http.pcap
tcpdump -i eth0 tcp and host 192.168.33.10 and port 80 -w tcp.sys_timeout.pcap
# 捕获特定网口数据包
tcpdump -i eth0
# 捕获特定个数(1000)的包
tcpdump -c 1000 -i eth0
# 将捕获的包保存到文件
tcpdump -w a.pcap -i eth0
# 读取pcap格式的包
tcpdump -r a.pcap
# 增加捕获包的时间戳
tcpdump -n -ttt -i eth0
# 指定捕获包的协议类型
tcpdump -i eth0 arp
# 捕获指定端口
tcpdump -i eth0 post 22
# 捕获特定目标ip+port的包
tcpdump -i eth0 dst address and port 22
# 捕获DNS请求和响应
tcpdump -i eth0 -s0 port 53
# 匹配Http请求头
tcpdump -s 0 -v -n -l | egrep -i "POST /|GET /|Host:"

# find ssh connections This one works regardless of what port the connection comes in on, because it’s getting the banner response.
tcpdump 'tcp[(tcp[12]>>2):4] = 0x5353482D'

# find cleartext passwords
tcpdump port http or port ftp or port smtp or port imap or port pop3 or port telnet -lA | egrep -i -B5 'pass=|pwd=|log=|login=|user=|username=|pw=|passw=|passwd= |password=|pass:|user:|username:|password:|login:|pass |user '

# find traffic with evil bit There’s a bit in the IP header that never gets set by legitimate applications, which we call the “Evil Bit”. Here’s a fun filter to find packets where it’s been toggled.
tcpdump 'ip[6] & 128 != 0'
```

### netcat network cat  nc

- Concatenate and redirect sockets
  - 实现任意 TCP/UDP 端口侦听:增加 -l 参数后，nc 可以作为 server 以 TCP 或 UDP 方式侦听指定端口
  - 端口扫描:nc 可以作为 client 发起 TCP 或 UDP 连接
  - 端口转发
    + 运行【两个】nc 进程，一个充当“服务端”，另一个是“客户端”，然后用【管道】让把两个进程的“标准输入输出”交叉配对。
    + 所谓的“交叉配对”就是——每一个 nc 进程的“标准输出”都【对接】到另一个 nc 进程的“标准输入”。如此一来，就可以完美地建立【双向通讯】
  - 代理转发 Proxy Forward
  - 机器间传输文件
  - 机器间网络测速
  - 快速构建网络链接
* 选项
  - -g<网关>：设置路由器跃程通信网关，最多设置8个
  - -G<指向器数目>：设置来源路由指向器，其数值为4的倍数
  - -i<延迟秒数>：设置时间间隔，以便传送信息及扫描通信端口
  - -l：使用监听模式，监控传入的资料，nc被当作server，侦听并接受连接，而非向其它地址发起连接
  - -n：直接使用ip地址，而不通过域名服务器
  - -o <输出文件>：指定文件名称，把往来传输的数据以16进制字码倾倒成该文件保存
  - -p <通信端口>：设置本地主机使用的通信端口
  - -r：指定源端口和目的端口都进行随机的选择
  - -s<来源位址>：设置本地主机送出数据包的IP地址
  - -u：使用UDP传输协议，默认TCP
  - -v：显示指令执行过程，输出交互或出错信息，新手调试时尤为有用
  - -w<超时秒数>：设置等待连线的时间
  - -z：开启“zero-I/O 模式”，只判断某个监听端口是否能连上，连上后【不】与对端进行数据通讯,在扫描通信端口时使用

```sh
sudo apt install nmap-ncat

# 测试某个远程主机的【监听】端口是否可达
nc -nv x.x.x.x xx

## 判断防火墙是否“允许 or 禁止”某个端口
nc -lv -p 8080
## 持续开启监听端口
nc -lv -p -k 8080

# 扫描机器A端口号在30-40服务
nc -z A 30-40
nc -znv x.x.x.x 1-1024
nc -znv x.x.x.x 1-1024  2>&1 | grep succeeded
# 连接服务器A 端口号为5000
nc -C A 5000
#传送文件 MachineA:
nc -v -n ip portE:\a.exe

## 探测“服务器类型”和“软件版本”
alias nc-tor='nc -X 5 -x 127.0.0.1:9050'
echo "EXIT" | nc-tor -vq 5 -n 服务器IP 22
echo "EXIT" | nc-tor -vq 5 服务器域名 22

# 开启一个本地9999的TCP协议端口，由客户端主动发起连接，一旦连接必须由服务端发起关闭
nc -l 9999
# 通过nc去访问192.168.21.248主机的11111端口，确认是否存活；可不加参数
nc -vw 2 192.168.21.248 11111
# 开启一个本地9999的UDP协议端口，客户端不需要由服务端主动发起关闭
nc -ul 9999
nc 192.168.21.248 9999 < test     # 通过192.168.21.248的9999TCP端口发送数据文件
nc -l 9999 > zabbix.file          # 开启一个本地9999的TCP端口，用来接收文件内容

# 端口扫描
nc -v -w 2 192.168.2.34 -z 21-24
# 从192.168.2.33拷贝文件到192.168.2.34
# 在192.168.2.34上：
nc -lp 1234 > test.txt
# 在192.168.2.33上
nc -w l 192.168.2.34 1234 < test.txt
# 聊天 Ctrl+D正常退出
nc -lp 1234
nc 192.168.228.222 1234

# 传输目录
nc -l 1234 | tar xzvf -
tar czvf – nginx-0.6.34 | nc 192.168.228.222 1234
# 操作memcached
# 存储数据
printf “set key 0 10 6rnresultrn” |nc 192.168.2.34 11211
# 获取数据
printf “get keyrn” |nc 192.168.2.34 11211
# 删除数据
printf “delete keyrn” |nc 192.168.2.34 11211
# 查看状态
printf “statsrn” |nc 192.168.2.34 11211
# 模拟top命令查看状态
watch “echo stats” |nc 192.168.2.34 11211
# 清空缓存
printf “flush_allrn” |nc 192.168.2.34 11211
# 从本地1234端口到host.example.com的80端口连接，5秒超时
nc -p 1234 -w 5 host.example.com 80
echo -n "GET / HTTP/1.0"r"n"r"n" | nc host.example.com 80
nc -u host.example.com 53

# 克隆硬盘或分区
nc -l -p 1234 | dd of=/dev/sda
dd if=/dev/sda | nc 192.168.228.222 1234

nc www.linuxso.com 80
GET / HTTP/1.1
Host: ispconfig.org
Referrer: mypage.com
User-Agent: my-browser

ssh -p 22 -C -f -N -g -L 9200:192.168.1.19:9200 ihavecar@192.168.1.19

# 基于 nc 的端口转发（Port Forward）
mkfifo nc_pipe
nc -l -p 1234 < nc_pipe | nc 127.0.0.1 5678 > nc_pipe
```

### socat(socket cat) "netcat++" (extended design, new implementation)

* 给 socat 提供两个地址，socat 干的活就是把两个地址的流对接起来。左边地址的输出传给右边，同时又把右边地址的输出传给左边，也就是一个双向的数据管道
* 地址类型
	* -/stdio，TCP, TCP-LISTEN, UDP, UDP-LISTEN, OPEN, EXEC, SOCKS, PROXY 等等
* 可用于端口监听、链接，文件和进程读写，代理桥接等等

```sh
sudo apt| yum install socat
# macOS
brew install socat

# 检测远程端口的可连接
# -d[ddd] 增加日志详细程度，-dd  Prints fatal, error, warning, and notice messages.
socat -dd - TCP:192.168.1.252:3306

# -v 显示详细信息
# -z 不发送数据，效果为立即关闭连接，快速得出结果
nc -vz 192.168.1.2 8080

# -vv 显示更详细的内容
# -w2 超时时间设为 2 秒
# 使用 nc 做简单的端口扫描
nc -vv -w2 -z 192.168.1.2 20-500

## 测试本机端口是否能正常被外部访问（检测防火墙、路由）
# 在本机监听一个 TCP 端口，接收到的内容传到 stdout，同时将 stdin 的输入传给客户端：
# 服务端启动命令，socat/nc 二选一
socat TCP-LISTEN:7000 -
# -l --listening
nc -l 7000
# 客户端连接命令，socat/nc 二选一
socat TCP:192.168.31.123:7000 -
nc 192.168.11.123 7000

### UDP 协议的测试也非常类似，使用 netcat 的示例如下：
# 服务端，只监听 ipv4
nc -u -l 8080
# 客户端
nc -u 192.168.31.123 8080
# 客户端本机测试，注意 localhost 会被优先解析为 ipv6! 这会导致服务端(ipv4)的 nc 接收不到数据！
nc -u localhost 8080

# 使用 socat 的 UDP 测试示例如下：
socat UDP-LISTEN:7000 -
socat UDP:192.168.31.123:7000 -

## 调试 TLS 协议
# 模拟一个 mTLS 服务器，监听 4433 端口，接收到的数据同样输出到 stdout：
# socat 需要使用同时包含证书和私钥的 pem 文件，生成方法如下
cat server.key server.crt > server.pem
cat client.key client.crt > client.pem

# 服务端启动命令
socat openssl-listen:4433,reuseaddr,cert=server.pem,cafile=client.crt -

# 客户端连接命令
socat - openssl-connect:192.168.31.123:4433,cert=client.pem,cafile=server.crt
# 或者使用 curl 连接(我们知道 ca.crt 和 server.crt 都能被用做 cacert/cafile)
curl -v --cacert ca.crt --cert client.crt --key client.key --tls-max 1.2 https://192.168.31.123:4433

# 上面的命令使用了 mTLS 双向认证的协议，可通过设定 verify=0 来关掉客户端认证

# socat 需要使用同时包含证书和私钥的 pem 文件，生成方法如下
cat server.key server.crt > server.pem

# 服务端启动命令
socat openssl-listen:4433,reuseaddr,cert=server.pem,verify=0 -

# 客户端连接命令，如果 ip/域名不受证书保护，就也需要添加 verify=0
socat - openssl-connect:192.168.31.123:4433,cafile=server.crt
# 或者使用 curl 连接，证书无效请添加 -k 跳过证书验证
curl -v --cacert server.crt https://192.168.31.123:4433

### 数据传输
# 以将 demo.tar.gz 从主机 A 发送到主机 B 为例,在数据发送方 A 执行
# -u 表示数据只从左边的地址单向传输给右边（socat 默认是一个双向管道）
# -U 和 -u 相反，数据只从右边单向传输给左边
socat -u open:demo.tar.gz tcp-listen:2000,reuseaddr
# 在数据接收方 B 执行如下命令，就能把文件接收到
socat -u tcp:192.168.1.252:2000 open:demo.tar.gz,create
# 如果觉得太繁琐，也可以直接通过 stdout 重定向
socat -u tcp:192.168.1.252:2000 - > demo.tar.gz

# 用 netcat 也可以实现数据传输
# 先在接收方启动服务端
nc -l -p 8080 > demo.tar.gz
# 再在发送方启动客户端发送数据
nc 192.168.1.2 8080 < demo.tar.gz

# 担当临时的 web 服务器
# 将监听 8080 端口，并将数据流和 web.py 的 stdio 连接起来，可以直接使用浏览器访问 http://<ip>:8080 来查看效果
socat TCP-LISTEN:8080,reuseaddr,fork SYSTEM:"python3 web.py"

##  端口转发
# 监听 8080 端口，建立该端口与 baidu.com:80 之间的双向管道
socat TCP-LISTEN:8080,fork,reuseaddr  TCP:baidu.com:80

# 注意指定 Host
curl -v -H 'Host: baidu.com' localhost:8080
```

### [netperf](https://github.com/HewlettPackard/netperf)
 
* 一种网络性能的测量工具，主要针对基于 TCP 或 UDP 的传输
* 批量数据传输（bulk data transfer）模式
* 请求 / 应答（request/reponse）模式
* 参数
  - -H host  指定远端运行 netserver 的 server IP 地址
  - -l testlen  指定测试的时间长度 (秒)
  - -t testname   指定进行的测试类型 (TCP_STREAM，UDP_STREAM，TCP_RR，TCP_CRR，UDP_RR)
    + 缺省情况下进行 TCP 批量传输，即 - t TCP_STREAM
    + UDP_STREAM 测试分组的大小不得大于 socket 的发送与接收缓冲大小，否则 netperf 会报出错提示
    + TCP_RR 
    + TCP_CRR 为每次交易建立一个新的 TCP 连接
  - -s size   设置本地系统的 socket 发送与接收缓冲大小
  - -S size   设置远端系统的 socket 发送与接收缓冲大小
  - -m size   设置本地系统发送测试分组的大小
  - -M size   设置远端系统接收测试分组的大小
  - -D  对本地与远端系统的 socket 设置 TCP_NODELAY 选项
  - -r req,resp   设置 request 和 reponse 分组的大小

```sh
./netperf -H 192.168.0.28 -l 60

./netperf -t UDP_STREAM -H 192.168.0.28 -- -m 1024

./netperf -t TCP_RR -H 192.168.0.28 -- -r 32,1024

./netperf -t TCP_CRR -H 192.168.0.28
```

### [iperf](https://github.com/esnet/iperf)

* 测试最大 TCP 和 UDP 带宽性能，具有多种参数和 UDP 特性，可以根据需要调整，可以报告带宽、延迟抖动和数据包丢失。
* 共用选项
  - -u  –udp：使用 UDP 方式而不是 TCP 方式。需要客户端与服务器端同时使用此参数。
  - -p  –port : 设置端口，与服务器端的监听端口一致。默认是 5001 端口。
  - -l  –len : 设置读写缓冲区的长度。TCP 方式默认为 8KB，UDP 方式默认为 1470 字节。
  - -w  –window : 设置套接字缓冲区为指定大小。对于 TCP 方式，此设置为 TCP 窗口大小。对于 UDP 方式，此设置为接受 UDP 数据包的缓冲区大小，限制可以接受数据包的最大值。
  - -m  –print_mss : 输出 TCP MSS 值（通过 TCP_MAXSEG 支持）。MSS 值一般比 MTU 值小 40 字节。通常情况
* 服务器端专用选项
  - -s  –server : iperf 服务器模式
  - -c  –client host : 如果 iperf 运行在服务器模式，并且用 - c 参数指定一个主机，那么 iperf 将只接受指定主机的连接。此参数不能工作于 UDP 模式。
  - -P  –parallel： 服务器关闭之前保持的连接数。默认是 0，这意味着永远接受连接。
* 客户端端专用选项
  - -c  –client host ： 运行 iperf 的客户端模式，连接到指定的 iperf 服务器端。
  - -b  –bandwidth ：UDP 模式使用的带宽，必须配合 - u 参数，默认值是 1 Mbit/sec。
  - -d  –dualtest ： 运行双测试模式。这将使服务器端反向连接到客户端，使用 - L 参数中指定的端口（或默认使用客户端连接到服务器端的端口）。这些在操作的同时就立即完成了。如果你想要一个交互的测试，请尝试 - r 参数。
  - -r  –tradeoff ： 往复测试模式。当客户端到服务器端的测试结束时，服务器端通过 - l 选项指定的端口（或默认为客户端连接到服务器端的端口），反向连接至客户端。当客户端连接终止时，反向连接随即开始。如果需要同时进行双向测试，请尝试 - d 参数。
  - -L  –listenport ： 指指定服务端反向连接到客户端时使用的端口。默认使用客户端连接至服务端的端口。
  - -t  –time ： 设置传输的总时间。iperf 在指定的时间内，重复的发送指定长度的数据包。默认是 10 秒钟。
  - -P  –parallel： 线程数。指定客户端与服务端之间使用的线程数。默认是 1 线程。需要客户端与服务器端同时使用此参数。
  - -p：后接服务端监听的端口 
  - -i：设置带宽报告的时间间隔，单位为秒
  - -w：设置 tcp 窗口大小，一般可以不用设置，默认即可

```sh
# 服务器端
iperf -u -s

# 客户端：
# /* 在 udp 模式下，以 100Mbps 为数据发送速率，客户端到服务器 192.168.1.1 上传带宽测试，测试时间为 60 秒 */
iperf -u -c 192.168.1.1 -b 100M -t 60

# /* 客户端以 5Mbps 为数据发送速率, 同时向服务器端发起 30 个连接线程 */
iperf -u -c 192.168.1.1 -b 5M -P 30 -t 60

# /* 以 100M 为数据发送速率，进行上下行带宽测试,-L 参数指定本端双测试监听的端口 */
iperf -u -c 192.168.1.1 -b 100M -d -t 60 -L 30000

# TCP 模式
# 服务器端：
iperf -s

# 客户端：
# /* 在 tcp 模式下，客户端到服务器 192.168.1.1 上传带宽测试，测试时间为 60 秒 */
iperf -c 192.168.1.1 -t 60

# /* 进行上下行带宽测试 */
iperf -c 192.168.1.1 -d -t 60

# /* 测试单线程 TCP*/
iperf –c 192.168.1.1 –p 12345 –i 1 –t 10 –w 20K

 # 对应服务器端：
iperf –s –p 12345 –i 1 –t 10 –m -y

/* 测试多线程 TCP: 客户端同时向服务器端发起 30 个连接线程 */
iperf -c 192.168.1.1 -P 30 -t 60
```

## [Wireshark](https://www.wireshark.org)

* tcpdump 仅支持命令行格式使用，常用在 Linux 服务器中抓取和分析网络包。
* Wireshark 除了可以抓包外，还提供了可视化分析网络包的图形页面。
* <https://github.com/dafang/notebook/issues/114>
* CTRL 按钮: 捕获多个网卡
* save 捕获数据
* tcpdump + ssh + wireshark 在远程主机上使用 tcpdump 抓包，本地使用 wireshark 进行实时分析
  - 使用 tcpdump 在远程主机上抓包，保存为 pcap 文件。
  - 将 pcap 文件拷贝到本地，使用 wireshark 对其进行分析
* 《[WireShark网络分析就这么简单](https://www.amazon.cn/gp/product/B00PB5QQ84)》
* 《[WireShark网络分析的艺术](https://www.amazon.cn/gp/product/B01AS1OS8A)》

```sh
sudo apt install wireshark
# 是否允许非超级用户捕获数据包。选择“Yes”允许，选择“No”限制非超级用户捕获数据包
sudo dpkg-reconfigure wireshark-common
# 允许非超级用户捕获数据包，因此你必须将该用户添加到 wireshark 组
sudo usermod -aG wireshark $(whoami)
sudo wireshark

# 只看 tcp 流量
tcp
# 只看 http 流量
http

# 使用感叹号（或 not）进行反向过滤
!arp  # 过滤掉所有 arp 数据包

# 通过 ip 的源地址 src 或 dst 进行过滤
ip.src==192.168.1.33

# 通过 IP 地址（ip.addr）进行过滤（匹配 ip.src 或 ip.dst）
ip.addr==192.168.0.5
# 上一条过滤表达式等价于：
ip.src==192.168.0.5 or ip.dst==192.168.0.5

# 通过 tcp 端口号进行过滤
tcp.port==80
tcp.port>4000

# 通过 http 的 host 属性进行过滤
http.host != "xxx.baidu.com"
# 通过 http.referer 属性进行过滤
http.referer == "xxx.baidu.com"

# 多个过滤器之间用 and、or 进行组合
http.host != "xxx.baidu.com" and http.referer == "xxx.baidu.com"

# eth0 更换成你的机器 interface 名称，虚拟机可能是 ens33
ssh root@some.host "tcpdump -i eth0 -l -w -" | wireshark -k -i -
# 1. 远程主机抓包：将数据流通过 11111 端口暴露出去
tcpdump -i wlan0 -s0 -w - | nc -l -p 11111
# 2. 本地主机从远程主机的 11111 端口读取数据，提供给 wireshark
nc <remote-host> 11111 | wireshark -k -S -i -

# 方案一：root 手机后，将 arm 版的 tcpdump 拷贝到手机内进行抓包
# 1. 在 adb shell 里使用 tcpdump 抓 WiFi 的数据包，转发到 11111 端口
## 需要先获取到 root 权限，将 tcpdump 拷贝到 /system/bin/ 目录下
tcpdump -i wlan0 -s0 -w - | nc -l -p 11111

# 2. 在本机使用 adb forward 将手机的 11111 端口绑定到本机(PC)的 11111 端口
adb forward tcp:11111 tcp:11111

# 3. 直接从本机(PC)的 11111 端口读取数据，提供给 wireshark
nc localhost 11111 | wireshark -k -S -i -
## 通过数据转发，本机 11111 端口的数据，就是安卓手机内 tcmpdump 的 stdout 内容。

# 方案二：
# 如果手机不方便 root，推荐 PC 开启 WiFi 热点，手机连上这个热点访问网络。
# 这样手机的数据就一定会走 PC，直接在 PC 上通过 wireshark 抓包就行。
# 如果你只需要简单地抓 http/https 包，请使用 fiddler/mitmproxy
```

## 测速

* [speedtest](https://www.speedtest.net/zh-Hans/apps/cli)
* [BOCE](https://www.boce.com/):通过该工具可实时获取网站的当前响应状态，检测各种网站请求错误，记录整体响应时间
* [IPv6 连接测试](https://test-ipv6.com/)
* [Linux-NetSpeed](https://github.com/chiakge/Linux-NetSpeed):将Linux现常用的网络加速集成在一起

```sh
# Speedtest
sudo apt install speedtest-cli
sudo pip3 install speedtest-cli
speedtest

# fast
npm install --global fast-cli
fast -u

# iPerf
sudo apt install iperf
ip addr show | grep inet.*brd # Obtain the IP address of the server machine
iperf -s # incoming connections from clients
iperf -c 192.168.1.2 # substituting the IP address of your server machine for the sample one

yum install -y python-setuptools
easy_install pip
pip install speedtest-cli
speedtest-cli --list | grep China
```

## 调试

* 使用 gdb 调试Linux程序
* 使用 strace 跟踪进程的系统调用
* 使用 tcpdump 跟踪网络通信过程
* 其他Linux系统工具，如ps、lsof、top、vmstat、netstat、sar、ss等

## 图书

* 网络是怎样连接的
* 《Unix环境高级编程》Unix Network Programming
* 《UNIX网络编程 卷1：套接字联网API》
* 《UNIX网络编程 卷2：进程间通信》
* 《Linux多线程服务器端编程》
* 《Computer Networking: A Top Down Approach 计算机网络：自顶向下方法》
  - [PPT](https://gaia.cs.umass.edu/kurose_ross/ppt.htm)
  - [Stanford CS 144](https://www.youtube.com/playlist?list=PLvFG2xYBrYAQCyz4Wx3NPoYJOFjvU7g2Z)
  - [](https://www.bilibili.com/video/av41404195)
* 计算机网络 Computer Networks Andrew S. Tanenbaum / David J. Wetherall
* [Computer Networks: A Systems Approach](https://book.systemsapproach.org/)

## 课程

* [计算机网络微课堂](https://www.bilibili.com/video/BV1c4411d7jb)

## 工具

* [localtunnel](https://github.com/localtunnel/localtunnel):expose yourself <https://localtunnel.me>
* [joy](https://github.com/cisco/joy):A package for capturing and analyzing network flow data and intraflow data, for network research, forensics, and security monitoring.
* [Observium](http://www.observium.org/) Network observation and monitoring system
* [SolarWinds](http://www.solarwinds.com):管理大小企业网络上的网络流量。网络设备监控器可监控你网络上的任何一个设备，查找各种提示或错误
* [webtty](https://github.com/maxmcd/webtty):Share a terminal session over WebRTC <https://maxmcd.github.io/webtty/>
* [ibrenms](https://github.com/librenms/librenms):Community-based GPL-licensed network monitoring system <http://www.librenms.org/>
* [Zenmap](https://nmap.org/zenmap/):Nmap网络扫描器的官方前端程序
* [teleport](https://github.com/henrylee2cn/teleport):Teleport is a versatile, high-performance and flexible socket framework. It can be used for RPC, micro services, peer-peer, push services, game services and so on. <https://github.com/henrylee2cn/tpdoc>
* [tailscale](https://github.com/tailscale/tailscale):The easiest, most secure way to use WireGuard and 2FA.<https://tailscale.com/>
* [nps](https://github.com/ehang-io/nps):一款轻量级、高性能、功能强大的内网穿透代理服务器。支持tcp、udp、socks5、http等几乎所有流量转发，可用来访问内网网站、本地支付接口调试、ssh访问、远程桌面，内网dns解析、内网socks5代理等等……，并带有功能强大的web管理端。a lightweight, high-performance, powerful intranet penetration proxy server, with a powerful web management terminal.<https://ehang.io/nps/documents>
* [bettercap](https://github.com/bettercap/bettercap) The Swiss Army knife for 802.11, BLE and Ethernet networks reconnaissance and MITM attacks. https://www.bettercap.org/
* [muduo](https://github.com/chenshuo/)Event-driven network library for multi-threaded Linux server in C++11 
    - 《Muduo 网络编程示例之零：前言》

## 参考

* [book](https://github.com/SystemsApproach/book):Meta-data and Makefile needed to build the book. Main starting point.
* [RFC 文档](https://datatracker.ietf.org/doc/rfc1644/) https://tools.ietf.org/rfc/index
* [](https://www.cloudflare.com/zh-cn/learning/)
* [](https://www.geeksforgeeks.org/basics-computer-networking/)
* [](https://www.tutorialspoint.com/computer_fundamentals/computer_networking.htm)
* [](https://www.javatpoint.com/types-of-computer-network)
* [Latency Numbers Every Programmer Should Know](https://colin-scott.github.io/personal_website/research/interactive_latency.html)
* [submarine cable map](https://www.submarinecablemap.com/)
* <http://libevent.org/>
* [家庭网络知识整理](https://github.com/blanboom/awesome-home-networking-cn)<https://blanboom.org/2020/awesome-home-networking-cn/>

<http://blog.csdn.net/hguisu/article/details/7445768/>
<http://blog.csdn.net/hguisu/article/details/7444092>
<http://blog.csdn.net/hguisu/article/details/7448528>
<http://blog.csdn.net/tongdoudpj/article/details/1750045>
<https://www.zhihu.com/question/20215561>
<http://www.cnblogs.com/JohnTsai/p/5197646.html>
<http://blog.csdn.net/dragonyangang/article/details/77937042>
