# [apache/zookeeper](https://github.com/apache/zookeeper)

ZooKeeper is a centralized service for maintaining configuration information, naming, providing distributed synchronization, and providing group services.

* 一个开放源代码的分布式协调服务。它具有高性能、高可用的特点，同时也具有严格的顺序访问控制能力（主要是写操作的严格顺序性)
* 基于对 ZAB 协议（ZooKeeper Atomic Broadcast，ZooKeeper 原子消息广播协议）的实现，能够很好地保证分布式环境中数据的一致性
    - 两种模式
        + 恢复模式（选主）：服务启动或者在领导者崩溃后。领导者被选举出来，且大多数Server完成了和 leader的状态同步以后，恢复模式就结束了
        + 广播模式（同步）
* 为了保证事务的顺序一致性，zookeeper采用了递增的事务id号（zxid）来标识事务。所有的提议（proposal）都在被提出的时候加上了zxid
    - 实现zxid是一个64位的数字，它高32位是epoch用来标识leader关系是否改变，每次一个leader被选出来，它都会有一个新的epoch，标识当前属于那个leader的统治时期。低32位用于递增计数。
* 目的
    - 最终一致性：client不论连接到哪个Server，展示给它都是同一个视图
    - 可靠性：具有简单、健壮、良好的性能，如果消息被到一台服务器接受，那么它将被所有的服务器接受。
    - 实时性：Zookeeper保证客户端将在一个时间间隔范围内获得服务器的更新信息，或者服务器失效的信息。但由于网络延时等原因，Zookeeper不能保证两个客户端能同时得到刚更新的数据，如果需要最新数据，应该在读数据之前调用sync()接口。
    - 等待无关（wait-free）：慢的或者失效的client不得干预快速的client的请求，使得每个client都能有效的等待。
    - 原子性：更新只能成功或者失败，没有中间状态。
    - 顺序性
        + 全局有序是指如果在一台服务器上消息a在消息b前发布，则在所有Server上消息a都将在消息b前被发布
        + 偏序是指如果一个消息b在消息a后被同一个发送者发布，a必将排在b前面
* 缺点
    - 不适合用作海量数据存储，取而代之的可以采用数据库或者分布式文件系统等

## 原理

* ZooKeeper 服务器采用集群形式
    - 只要集群中存在超过一半的、处于正常工作状态的服务器，那么整个集群就能够正常对外服务
    - 组成 ZooKeeper 集群的每台服务器都会在内存中维护当前的 ZooKeeeper 服务状态，并且每台服务器之间都互相保持着通信
    - 角色
        + 领导者LEADER
        + 跟随者FOLOWER：用于读、响应，参与选主投票
            * 向Leader发送请求（PING消息、REQUEST消息、ACK消息、REVALIDATE消息）
            * 接收Leader消息并进行处理；
            * 接收Client的请求，如果为写请求，发送给Leader进行投票
            * 返回Client结果
            * 消息类型
                - PING消息： 心跳消息
                - PROPOSAL消息：Leader发起的提案，要求Follower投票
                - COMMIT消息：服务器端最新一次提案的信息
                - UPTODATE消息：表明同步完成
                - REVALIDATE消息：根据Leader的REVALIDATE结果，关闭待revalidate的session还是允许其接受消息
                - SYNC消息：返回SYNC结果到客户端，这个消息最初由客户端发起，用来强制得到最新的更新。
        + 观察者OBSERVER：用户接受连接，写请求转发给leader,不参与投票，同步leader状态，用户扩展系统
    - Server在工作过程中有三种状态
        + LOOKING：当前Server不知道leader是谁，正在搜寻
        + LEADING：当前Server即为选举出来的leader
        + FOLLOWING：leader已经选举出来，当前Server与之同步
* 客户端
    - 客户端在连接 ZooKeeper 服务集群时，会按照一定的随机算法选择集群中的某台服务器，然后和它共同创建一个 TCP 连接，使客户端连上到那台服务器
    - 当那台服务器失效时，客户端自动会重新选择另一台服务器进行连接，从而保证服务的连续性
* 目录服务
    - ZooKeeper启动奇数个进程，来形成一个小的目录服务集群。这个集群会提供给所有其他进程，进行读写其巨大的"配置树"的能力
    - 这些数据不仅仅会存放在一个ZooKeeper进程中，而是会根据一套非常安全的算法，让多个进程来承载
    - 由于ZooKeeper的数据存储结构，是一个类似文件目录的树状系统，把每个进程都绑定到其中一个"分枝"上，然后通过检查这些"分支"，来进行服务器请求的转发，就能简单的解决请求路由（由谁去做）的问题
    - 在这些"分支"上标记进程的负载的状态，这样负载均衡也很容易做了
* 文件系统：每个子目录项如 NameService 都被称作为znode。和文件系统一样，能够自由的增加、删除znode，在一个znode下增加、删除子znode，唯一的不同在于znode是可以存储数据的。至少两级
    - 四种类型znode：
        + PERSISTENT-持久化目录节点：客户端与zookeeper断开连接后，该节点依旧存在
        + PERSISTENT_SEQUENTIAL-持久化顺序编号目录节点：客户端与zookeeper断开连接后，该节点依旧存在，只是Zookeeper给该节点名称进行顺序编号
        + EPHEMERAL-临时目录节点：客户端与zookeeper断开连接后，该节点被删除
        + EPHEMERAL_SEQUENTIAL-临时顺序编号目录节点：客户端与zookeeper断开连接后，该节点被删除，只是Zookeeper给该节点名称进行顺序编号
* 通知机制：客户端注册监听它关心的目录节点，当目录节点发生变化（数据改变、被删除、子目录节点增加删除）时，zookeeper会通知客户端。
* 功能
    - 命名服务：在zookeeper的文件系统里创建一个目录，即有唯一的path。在使用tborg无法确定上游程序的部署机器时即可与下游程序约定好path，通过path即能互相探索发现
    - 配置管理：分布式的配置集中到zookeeper上去，保存在 Zookeeper 的某个目录节点中，然后所有相关应用程序对这个目录节点进行监听，一旦配置信息发生变化，每个应用程序就会收到 Zookeeper 的通知，然后从 Zookeeper 获取新的配置信息应用到系统中就好
    - 集群管理
        + 机器退出和加入
            * 通过心跳机制可以检测挂掉的机器
            * 所有机器约定在父目录GroupMembers下创建临时目录节点，然后监听父目录节点的子节点变化消息。一旦有机器挂掉，该机器与 zookeeper的连接断开，其所创建的临时目录节点被删除，所有其他机器都收到通知：某个兄弟目录被删除
            * 新机器加入也是类似，所有机器收到通知：新兄弟目录加入，highcount又有了
        + 选举master
            * 当leader崩溃或者leader失去大多数的follower，这时候zk进入恢复模式选举算法有两种，默认的选举算法为fast paxos
                - 基于basic paxos实现
                    + 选举线程由当前Server发起选举的线程担任，其主要功能是对投票结果进行统计，并选出推荐的Server；
                    + 选举线程首先向所有Server发起一次询问(包括自己)；
                    + 选举线程收到回复后，验证是否是自己发起的询问(验证zxid是否一致)，然后获取对方的id(myid)，并存储到当前询问对象列表中，最后获取对方提议的leader相关信息(id,zxid)，并将这些信息存储到当次选举的投票记录表中；
                    + 收到所有Server回复以后，就计算出zxid最大的那个Server，并将这个Server相关信息设置成下一次要投票的Server；
                    + 线程将当前zxid最大的Server设置为当前Server要推荐的Leader，如果此时获胜的Server获得n/2 + 1的Server票数，设置当前推荐的leader为获胜的Server，将根据获胜的Server相关信息设置自己的状态，否则，继续这个过程，直到leader被选举出来
                    + 通过流程分析我们可以得出：要使Leader获得多数Server的支持，则Server总数必须是奇数2n+1，且存活的Server的数目不得少于n+1
                    + 每个Server启动后都会重复以上流程。在恢复模式下，如果是刚从崩溃状态恢复的或者刚启动的server还会从磁盘快照中恢复数据和会话信息，zk会记录事务日志并定期进行快照，方便在恢复时进行状态恢复。
                - 基于fast paxos算法实现：某Server首先向所有Server提议自己要成为leader，当其它Server收到提议以后，解决epoch和 zxid的冲突，并接受对方的提议，然后向对方发送接受提议完成的消息，重复这个流程，最后一定能选举出Leader。
            * 所有机器创建临时顺序编号目录节点，每次选取编号最小的机器作为master就好
    - 分布式锁
        + 保持独占：将zookeeper上的一个znode看作是一把锁，通过createznode的方式来实现。所有客户端都去创建 /distribute_lock 节点，最终成功创建的那个客户端也即拥有了这把锁。用完删除掉自己创建的distribute_lock 节点就释放出锁。
        + 控制时序：/distribute_lock 已经预先存在，所有客户端在它下面创建临时顺序编号目录节点，和选master一样，编号最小的获得锁，用完删除，依次方便。
    - 队列管理
        + 同步队列，当一个队列的成员都聚齐时，这个队列才可用，否则一直等待所有成员到达。在约定目录下创建临时目录节点，监听节点数目是否是我们要求的数目
        + 队列按照 FIFO 方式进行入队和出队操作：和分布式锁服务中的控制时序场景基本原理一致，入列有编号，出列按编号
* 分布式与数据复制
    - 当其中一个客户端修改数据时，ZooKeeper 会将修改同步到集群中所有的服务器上，从而使连接到集群中其它服务器上的客户端也能立即看到修改后的数据
    - 数据复制的好处
        + 容错：一个节点出错，不致于让整个系统停止工作，别的节点可以接管它的工作
        + 提高系统的扩展能力 ：把负载分布到多个节点上，或者增加节点来提高系统的负载能力
    + 提高性能：让客户端本地访问就近的节点，提高用户访问速度
    - 方法
        + 写主(WriteMaster) ：对数据的修改提交给指定的节点。读无此限制，可以读取任何一个节点。这种情况下客户端需要对读与写进行区别，俗称读写分离；
        + 写任意(Write Any)：对数据的修改可提交给任意的节点，跟读一样。这种情况下，客户端对集群节点的角色与变化透明
        + 写，随着机器的增多吞吐能力肯定下降（这也是它建立observer的原因），而响应能力则取决于具体实现方式，是延迟复制保持最终一致性，还是立即复制快速响应
    - 流程
        + Leader等待server连接；
        + Follower连接leader，将最大的zxid发送给leader；
        + Leader根据follower的zxid确定同步点；
        + 完成同步后通知follower 已经成为uptodate状态；
        + Follower收到uptodate消息后，又可以重新接受client的请求进行服务了。

## API

## 图书

* Zookeeper: 分布式过程协同技术详解
