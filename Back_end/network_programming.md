# 网络编程

## 用户空间与内核空间

* 现在操作系统都是采用虚拟存储器，那么对32位操作系统而言，它的寻址空间（虚拟存储空间）为4G（2的32次方）
* 操作系统的核心是内核，独立于普通的应用程序，可以访问受保护的内存空间，也有访问底层硬件设备的所有权限
* 为了保证用户进程不能直接操作内核（kernel），保证内核的安全，操心系统将虚拟空间划分为两部分，一部分为内核空间，一部分为用户空间
* 针对linux操作系统而言，将最高的1G字节（从虚拟地址0xC0000000到0xFFFFFFFF），供内核使用，称为内核空间，而将较低的3G字节（从虚拟地址0x00000000到0xBFFFFFFF），供各个进程使用，称为用户空间。

## 进程切换

* 进程切换（process switch）、任务切换（task switch）或上下文切换（content switch）：为了控制进程的执行，内核必须有能力挂起正在CPU上运行的进程，并恢复以前挂起的某个进程的执行
    - 尽管每个进程都有自己的地址空间，但所有进程必须共享CPU寄存器。因此，在恢复一个进程的执行之前，内核必须确保每个寄存器装载了挂起进程时所需要的值。
    - 进程恢复执行前必须装入寄存器的一组数据成为硬件上下文（hardware context）
        + 硬件上下文是进程可执行上下文的一个自己，因为可执行上下文包含进程执行时所需要的所有信息
        + 在Linux中，进程硬件上下文的一部分存放在TSS段，而剩余部分存放在内核态堆栈中
* 流程
    - 保存处理机上下文，包括程序计数器和其他寄存器。
    - 更新PCB信息。
    - 把进程的PCB移入相应的队列，如就绪、在某事件阻塞等队列。
    - 选择另一个进程执行，并更新其PCB。
    - 更新内存管理的数据结构。
    - 恢复处理机上下文
* 阻塞
    - 正在执行的进程，由于期待的某些事件未发生，如请求系统资源失败、等待某种操作的完成、新数据尚未到达或无新工作做等，则由系统自动执行阻塞原语(Block)，使自己由运行状态变为阻塞状态。
    - 进程自身的一种主动行为，也因此只有处于运行态的进程（获得CPU），才可能将其转为阻塞状态
    - 当进程进入阻塞状态，是不占用CPU资源的
* 文件描述符fd：用于表述指向文件的引用的抽象化概念
    - 形式上是一个非负整数
    - 实际上，它是一个索引值，指向内核为每一个进程所维护的该进程打开文件的记录表
    - 当程序打开一个现有文件或者创建一个新文件时，内核向进程返回一个文件描述符
* 缓存 I/O
    - 又被称作标准 I/O，大多数文件系统的默认 I/O 操作都是缓存 I/O
    - 在 Linux 的缓存 I/O 机制中，操作系统会将 I/O 的数据缓存在文件系统的页缓存（ page cache ）中，也就是说，数据会先被拷贝到操作系统内核的缓冲区中，然后才会从操作系统内核的缓冲区拷贝到应用程序的地址空间
    - 缺点
        + 数据在传输过程中需要在应用程序地址空间和内核进行多次数据拷贝操作，这些数据拷贝操作所带来的 CPU 以及内存开销是非常大的
* IO模式
    - 一个read操作发生时，它会经历两个阶段：
        + 等待内核数据准备 (Waiting for the data to be ready)
        + 将数据从内核拷贝到进程中 (Copying the data from the kernel to the process)
* 网络模式
    - 阻塞 I/O（blocking IO）
        + 数据被拷贝到操作系统内核的缓冲区中是需要一个过程，进程这边，整个进程会被阻塞
        + 等到数据准备好了，就会将数据从kernel中拷贝到用户内存，然后kernel返回结果，用户进程才解除block的状态，重新运行起来
        + 两阶段都阻塞
    - 非阻塞 I/O（nonblocking IO）
        + 如果kernel中的数据还没有准备好，那么它并不会block用户进程，而是立刻返回一个error
        + 当kernel中数据准备好的时候，recvfrom会将数据从kernel拷贝到用户内存中，这个时候进程是被block了，在这段时间内，进程是被block的
        + 特点是用户进程需要不断的主动询问kernel数据好了没有
    - I/O 多路复用（ IO multiplexing） event driven IO
        + 好处就在于单个process就可以同时处理多个网络连接的IO
        + 基本原理就是select，poll，epoll这个function会不断的轮询所负责的所有socket，当某个socket有数据到达了，就通知用户进程
            * 当用户进程调用了select，那么整个进程会被block，而同时，kernel会“监视”所有select负责的socket，当任何一个socket中的数据准备好了，select就会返回
            * 这个时候用户进程再调用read操作，将数据从kernel拷贝到用户进程。
            * 通过一种机制一个进程能同时等待多个文件描述符，而这些文件描述符（套接字描述符）其中的任意一个进入读就绪状态，select()函数就可以返回。
        + select/epoll的优势并不是对于单个连接能处理得更快(和blocking IO 对比，需要使用两个system call )，而是在于能处理更多的连接
        + select
            * 函数监视的文件描述符分3类，分别是writefds、readfds、和exceptfds
            * 调用后select函数会阻塞，直到有描述副就绪（有数据 可读、可写、或者有except），或者超时（timeout指定等待时间，如果立即返回设为null即可），函数返回
            * 当select函数返回后，可以 通过遍历fdset，来找到就绪的描述符
            * 优点：几乎在所有的平台上支持，其良好跨平台支持也是它的一个优点
            * 缺点
                - 单个进程能够监视的文件描述符的数量存在最大限制，在Linux上一般为1024，可以通过修改宏定义甚至重新编译内核的方式提升这一限制，但是这样也会造成效率的降低
                - 每次调用select，都需要把fd集合从用户态拷贝到内核态，这个开销在fd很多时会很大
                - 同时每次调用select都需要在内核遍历传递进来的所有fd，这个开销在fd很多时也很大
                - select返回的是含有整个句柄的数组，应用程序需要遍历整个数组才能发现哪些句柄发生了事件；
                - select的触发方式是水平触发，应用程序如果没有完成对一个已经就绪的文件描述符进行IO操作，那么之后每次select调用还是会将这些文件描述符通知进程。
        + poll
            * 使用一个 pollfd的指针(链表)实现
                - 要监视的event和发生的event，不再使用select“参数-值”传递的方式
            * 同时，pollfd并没有最大数量限制（但是数量过大后性能也是会下降）
            * 和select函数一样，poll返回后，需要轮询pollfd来获取就绪的描述符
        + select和poll都需要在返回后，通过遍历文件描述符来获取已经就绪的socket。事实上，同时连接的大量客户端在一时刻可能只有很少的处于就绪状态，因此随着监视的描述符数量的增长，其效率也会线性下降。
        + epoll:更加灵活，没有描述符限制
            * 使用一个文件描述符管理多个描述符，将用户关系的文件描述符的事件存放到内核的一个事件表中，这样在用户空间和内核空间的copy只需一次.操作过程需要三个接口
            * int epoll_create(int size);
                - 创建一个epoll的句柄，size用来告诉内核这个监听的数目一共有多大，这个参数不同于select()中的第一个参数，给出最大监听的fd+1的值，参数size并不是限制了epoll所能监听的描述符最大个数，只是对内核初始分配内部数据结构的一个建议。
                - 当创建好epoll句柄后，它就会占用一个fd值，在linux下如果查看/proc/进程id/fd/，是能够看到这个fd的，所以在使用完epoll后，必须调用close()关闭，否则可能导致fd被耗尽。
            *  int epoll_ctl(int epfd, int op, int fd, struct epoll_event *event)； 函数是对指定描述符fd执行op操作。
                + epfd：是epoll_create()的返回值。
                + op：表示op操作，用三个宏来表示：添加EPOLL_CTL_ADD，删除EPOLL_CTL_DEL，修改EPOLL_CTL_MOD。分别添加、删除和修改对fd的监听事件。
                + fd：是需要监听的fd（文件描述符）
                + epoll_event：是告诉内核需要监听什么事
            - int epoll_wait(int epfd, struct epoll_event * events, int maxevents, int timeout); 等待epfd上的io事件，最多返回maxevents个事件。
                + 参数events用来从内核得到事件的集合，maxevents告之内核这个events有多大，这个maxevents的值不能大于创建epoll_create()时的size，参数timeout是超时时间（毫秒，0会立即返回，-1将不确定，也有说法说是永久阻塞）。该函数返回需要处理的事件数目，如返回0表示已超时。
            - 工作模式
                + LT（level trigger）:当epoll_wait检测到描述符事件发生并将此事件通知应用程序，应用程序可以不立即处理该事件。下次调用epoll_wait时，会再次响应应用程序并通知此事件。
                + ET（edge trigger）:当epoll_wait检测到描述符事件发生并将此事件通知应用程序，应用程序必须立即处理该事件。如果不处理，下次调用epoll_wait时，不会再次响应应用程序并通知此事件。
                    * 很大程度上减少了epoll事件被重复触发的次数，因此效率要比LT模式高。epoll工作在ET模式的时候，必须使用非阻塞套接口，以避免由于一个文件句柄的阻塞读/阻塞写操作把处理多个文件描述符的任务饿死。
        * 在 select/poll中，进程只有在调用一定的方法后，内核才对所有监视的文件描述符进行扫描
        * epoll事先通过epoll_ctl()来注册一个文件描述符，一旦基于某个文件描述符就绪时，内核会采用类似callback的回调机制，迅速激活这个文件描述符，当进程调用epoll_wait() 时便得到通知。(此处去掉了遍历文件描述符，而是通过监听回调的的机制。这正是epoll的魅力所在)
    - 信号驱动 I/O（ signal driven IO）
    - 异步 I/O（asynchronous IO）
        + 用户进程发起read操作之后，立刻就可以开始去做其它的事
        + 而另一方面，从kernel的角度，当它受到一个asynchronous read之后，首先它会立刻返回，所以不会对用户进程产生任何block
        + 然后，kernel会等待数据准备完成，然后将数据拷贝到用户内存，当这一切都完成之后，kernel会给用户进程发送一个signal，告诉它read操作完成了。

```c
int select (int n, fd_set *readfds, fd_set *writefds, fd_set *exceptfds, struct timeval *timeout);

int poll (struct pollfd *fds, unsigned int nfds, int timeout);
struct pollfd {
    int fd; /* file descriptor */
    short events; /* requested events to watch */
    short revents; /* returned events witnessed */
};

int epoll_create(int size)；//创建一个epoll的句柄，size用来告诉内核这个监听的数目一共有多大
int epoll_ctl(int epfd, int op, int fd, struct epoll_event *event)；
int epoll_wait(int epfd, struct epoll_event * events, int maxevents, int timeout);

struct epoll_event {
  __uint32_t events;  /* Epoll events */
  epoll_data_t data;  /* User data variable */
};

//events可以是以下几个宏的集合：
EPOLLIN ：表示对应的文件描述符可以读（包括对端SOCKET正常关闭）；
EPOLLOUT：表示对应的文件描述符可以写；
EPOLLPRI：表示对应的文件描述符有紧急的数据可读（这里应该表示有带外数据到来）；
EPOLLERR：表示对应的文件描述符发生错误；
EPOLLHUP：表示对应的文件描述符被挂断；
EPOLLET： 将EPOLL设为边缘触发(Edge Triggered)模式，这是相对于水平触发(Level Triggered)来说的。
EPOLLONESHOT：只监听一次事件，当监听完这次事件之后，如果还需要继续监听这个socket的话，需要再次把这个socket加入到EPOLL队列里
```

## 阶段

* 原生php实现TCP Server -> 原生php实现http协议 -> 掌握tcpdump的使用 -> 深刻理解tcp连接过程
    - php解释器 能否处理tcp http,可以跳过之前的环节
    - client –(protocol:http)–> nginx –(protocol:fastcgi)–> php-fpm –(interface:sapi)–> php
* 原生php实现多进程webserver
    - 引入I/O多路复用
    - 引入php协程(yield)
    - 对比 I/O多路复用版本 和 协程版本的性能差异
* 实现简单的go web框架
* php c扩展实现简单的webserver

## 图书

* 深入Linux内核架构
* UNIX网络编程
* 《TCP/IP网络编程》
    - [chankeh/net-lenrning-reference](https://github.com/chankeh/net-lenrning-reference):TCP/IP网络编程笔记
