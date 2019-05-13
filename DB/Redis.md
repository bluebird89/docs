# [antirez/redis](https://github.com/antirez/redis)

Redis is an in-memory database that persists on disk. The data model is key-value, but many different kind of values are supported: Strings, Lists, Sets, Sorted Sets, Hashes, HyperLogLogs, Bitmaps. http://redis.ioRedis是一个数据结构存储，可用作数据库、缓存和消息中间件。

## 优点

* 性能：在碰到需要执行耗时特别久、且结果不频繁变动的SQL时，就特别适合将运行结果放入缓存。这样，后面的请求就去缓存中读取，使得请求能够迅速响应。良好的用户体验
* 并发：使用Redis做一个缓冲操作，让请求先访问到Redis，而不是直接访问数据库。

## 原理

单线程的Redis为什么这么快，Redis是单线程工作模型。主要是以下三点：

* 纯内存操作
* 单线程操作，避免了频繁的上下文切换
* 采用了非阻塞I/O多路复用机制，单线程根据Socket的不同状态执行每个Socket(I/O流)：任务
* 还提供了Select、Epoll、Evport、Kqueue等多路复用函数库

Redis内部使用一个redisObject对象来表示所有的key和value,redisObject最主要的信息:type代表一个value对象具体是何种数据类型，encoding是不同数据类型在redis内部的存储方式，

vm字段，只有打开了Redis的虚拟内存功能，此字段才会真正的分配内存

## 特性

* 丰富的数据结构，支持二进制的String，List，Hash，Set及Ordered Set等数据类型操作。
* 数据存储在内存中,能支持超过100K+每秒的读写频率。提高了读写速度,实现网站高并发
* 单线程，避免了线程切换和锁的性能消耗
* 可持久化（RDB与AOF）,Redis 重启后数据不丢失
* 分布式锁
* 主从复制与高可用（Redis Sentinel）
* 集群
* 支持lua脚本
* 管道：Redis管道是指客户端可以将多个命令一次性发送到服务器，然后由服务器一次性返回所有结果。管道技术在批量执行命令的时候可以大大减少网络传输的开销，提高性能。
* 事务：Redis事务是一组命令的集合。一个事务中的命令要么都执行，要么都不执行。如果命令在运行期间出现错误，不会自动回滚。管道与事务的区别：管道主要是网络上的优化，客户端缓冲一组命令，一次性发送到服务器端执行，但是并不能保证命令是在同一个事务里面执行；而事务是原子性的，可以确保命令执行的时候不会有来自其他客户端的命令插入到命令序列中。
* 分布式锁：分布式锁是控制分布式系统之间同步访问共享资源的一种方式。在分布式系统中，常常需要协调他们的动作，如果不同的系统或是同一个系统的不同主机之间共享了一个或一组资源，那么访问这些资源的时候，往往需要互斥来防止彼此干扰来保证一致性，在这种情况下，便需要使用到分布式锁。
* 地理信息：从Redis 3.2版本开始，新增了地理信息相关的命令，可以将用户给定的地理位置信息（经纬度）存储起来，并对这些信息进行操作。

## 安装

* redis-server：redis服务器的daemon启动程序
* redis-cli：Redis命令操作工具。当然，也可以telnet根据其纯文本协助来操作。
* redis-benchmark：Redis性能测试工具，测试Redis在你的系统及你的配置下的读写性能。
* redis-check-aof：更新日志检查
* redis-check-dump：用于本地数据库检查

```sh
# Mac
brew install redis
brew services start/stop/restart redis
redis-server /usr/local/etc/redis.conf

# ubuntu
sudo apt-get install redis-server php-redis
```

## 配置

`/etc/redis/redis.conf`

```
<add key="RedisServerIP" value="redis:uuid845tylabc123@139.198.13.12:4125"/>
<!-- 提供的 Redis 环境是单机版配置。如果 Redis 是主从配置，则还需设置 RedisSlaveServerIP-->
<!--<add key="RedisSlaveServerIP" value="redis:uuid845tylabc123@139.198.13.13:4125"/>-->

<!--Redis 数据库。如果不需要指定 Redis 数据库，就配置默认值 0-->
<add key="RedisDefaultDb" value="0"/>

// 读取 Redis 主机 IP 配置信息
string[] redisMasterHosts = ConfigurationManager.ConnectionStrings["RedisServerIP"].ConnectionString.Split(',');

// 如果 Redis 服务器是主从配置，那么还需要读取 Redis Slave 机的 IP 配置信息
string[] redisSlaveHosts = null;
var slaveConnection = ConfigurationManager.ConnectionStrings["RedisSlaveServerIP"];
if (slaveConnection != null && !string.IsNullOrWhiteSpace(slaveConnection.ConnectionString))
{
    string redisSlaveHostConfig = slaveConnection.ConnectionString;
    redisSlaveHosts = redisSlaveHostConfig.Split(',');
}

// 读取 RedisDefaultDb 配置
int defaultDb = 0;
string defaultDbSetting = ConfigurationManager.AppSettings["RedisDefaultDb"];
if (!string.IsNullOrWhiteSpace(defaultDbSetting))
{
    int.TryParse(defaultDbSetting, out defaultDb);
}

var redisClientManagerConfig = new RedisClientManagerConfig
{
    MaxReadPoolSize = 50,
    MaxWritePoolSize = 50,
    DefaultDb = defaultDb
};

// 创建 Redis 连接池
Manager = new PooledRedisClientManager(redisMasterHosts, redisSlaveHosts, redisClientManagerConfig)
{
    PoolTimeout = 2000,
    ConnectTimeout = 500
};

# 集群配置 配置文件 redis.conf
slaveof 10.0.0.1 6379
redis-cli -h localhost -p 6379 monitor // 从库执行该命令会一直ping主库
```

## 客户端

```sh
# 客户端使用
redis-cli -h localhost -p 6379
info # 功能统计
info memory|server|clients|Persistence|Stats|Replication|CPU|cluster|keyspace

type key # 获取类型
object encoding key # 查看编码
object idletime key # 查看空转时间
object refcount key # 查看引用次数
```

## 内存

* info memeory
    - used_memory：Redis分配器分配的内存总量（单位是字节），包括使用的虚拟内存（即swap）
    - used_memory_rss：Redis进程占据操作系统的内存（单位是字节），与top及ps命令看到的值是一致的；除了分配器分配的内存之外，used_memory_rss还包括进程运行本身需要的内存、内存碎片等，但是不包括虚拟内存。
    - 二者之所以有所不同，一方面是因为内存碎片和Redis进程运行需要占用内存，使得前者可能比后者小，另一方面虚拟内存的存在，使得前者可能比后者大。
    - 内存碎片比率 mem_fragmentation_ratio:used_memory_rss / used_memory，衡量Redis内存碎片率的参数.一般大于1，且该值越大，内存碎片比例越大. <1，说明Redis使用了虚拟内存，由于虚拟内存的媒介是磁盘，比内存速度要慢很多，当这种情况出现时，应该及时排查，如果内存不足应该及时处理，如增加Redis节点、增加Redis服务器的内存、优化应用等
        + 在1.03左右是比较健康的状态
    - mem_allocator：Redis使用的内存分配器，在编译时指定；可以是 libc 、jemalloc或者tcmalloc，默认是jemalloc
* 内存划分
    - 数据：对外提供5种数据类型。在内部，每种类型可能有2种或更多的内部编码实现；在存储对象时，并不是直接将数据扔进内存，而是会对对象进行各种包装
    - 进程本身运行需要：除了主进程外，Redis创建的子进程运行也会占用内存，如Redis执行AOF、RDB重写时创建的子进程。当然，这部分内存不属于Redis进程，也不会统计在used_memory和used_memory_rss中。
    - 缓冲内存
        + 客户端缓冲存储客户端连接的输入输出缓冲
        + 复制积压缓冲用于部分复制功能
        + AOF缓冲区用于在进行AOF重写时，保存最近的写入命令
    - 内存碎片：在分配、回收物理内存过程中产生。与对数据进行的操作、数据的特点等都有关；此外，与使用的内存分配器也有关系，jemalloc便在控制内存碎片方面做的很好。
        -  可以通过安全重启的方式减小内存碎片：因为重启之后，Redis重新从备份文件中读取数据，在内存中进行重排，为每个数据重新选择合适的内存单元，减小内存碎片。
* 数据存储
    - 概念
        + dictEntry：Redis是Key-Value数据库，因此对每个键值对都会有一个dictEntry，里面存储了指向Key和Value的指针；next指向下一个dictEntry，与本Key-Value无关。
        + Key：Key（”hello”）并不是直接以字符串存储，而是存储在SDS结构中。
        + redisObject：Value(“world”)既不是直接以字符串存储，也不是像Key一样直接存储在SDS中，而是存储在redisObject中。实际上，不论Value是5种类型的哪一种，都是通过redisObject来存储的；而redisObject中的type字段指明了Value对象的类型，ptr字段则指向对象所在的地址。不过可以看出，字符串对象虽然经过了redisObject的包装，但仍然需要通过SDS存储。
            * type字段表示对象的类型;目前包括REDIS_STRING(字符串)、REDIS_LIST (列表)、REDIS_HASH(哈希)、REDIS_SET(集合)、REDIS_ZSET(有序集合)
            * encoding表示对象的内部编码:每种类型，都有至少两种内部编码，例如对于字符串，有int、embstr、raw三种编码。通过encoding属性，Redis可以根据不同的使用场景来为对象设置不同的编码，大大提高了Redis的灵活性和效率。
                - 以对象为例，有压缩列表和双端链表两种编码方式；如果列表中的元素较少，倾向于使用压缩列表进行存储，因为压缩列表占用内存更少，而且比双端链表可以更快载入；当列表对象元素较多时，压缩列表就会转化为更适合存储大量元素的双端链表。
            * lru记录的是对象最后一次被命令程序访问的时间，占据的比特数不同的版本有所不同。通过对比lru时间与当前时间，可以计算某个对象的空转时间(单位是秒),一个特殊之处在于它不改变对象的lru值. 还与Redis的内存回收有关系：如果Redis打开了maxmemory选项，且内存回收算法选择的是volatile-lru或allkeys—lru，那么当Redis内存占用超过maxmemory指定的值时，Redis会优先选择空转时间最长的对象进行释放。
            * refcount记录的是该对象被引用的次数，类型为整型。refcount的作用，主要在于对象的引用计数和内存回收。当创建新对象时，refcount初始化为1；当有新程序使用该对象时，refcount加1；当对象不再被一个新程序使用时，refcount减1；当refcount变为0时，对象占用的内存会被释放。
                - 被多次使用的对象(refcount>1)，称为共享对象。Redis为了节省内存，当有一些对象重复出现时，新的程序不会创建新的对象，而是仍然使用原来的对象。这个被重复使用的对象，就是共享对象。目前共享对象仅支持整数值的字符串对象
                    + 只支持整数值的字符串对象。之所以如此，实际上是对内存和CPU（时间）的平衡：共享对象虽然会降低内存消耗，但是判断两个对象是否相等却需要消耗额外的时间。对于整数值，判断操作复杂度为O(1)；对于普通字符串，判断复杂度为O(n)；而对于哈希、列表、集合和有序集合，判断的复杂度为O(n^2)。
                - 享对象只能是整数值的字符串对象，但是5种类型都可能使用共享对象。Redis服务器在初始化时，会创建10000个字符串对象，值分别是0~9999的整数值；当Redis需要使用值为0~9999的字符串对象时，可以直接使用这些共享对象。10000这个数字可以通过调整参数REDIS_SHARED_INTEGERS（4.0中是OBJ_SHARED_INTEGERS）的值进行改变。
            * ptr指针指向具体的数据
            * 一个redisObject对象的大小为16字节
        + jemalloc：无论是DictEntry对象，还是redisObject、SDS对象，都需要内存分配器（如jemalloc）分配内存进行存储。以DictEntry对象为例，有3个指针组成，在64位机器下占24个字节，jemalloc会为它分配32字节大小的内存单元。
            * jemalloc在64位系统中，将内存空间划分为小、大、巨大三个范围；每个范围内又划分了许多小的内存块单位；当Redis存储数据时，会选择大小最合适的内存块进行存储。
        + SDS(Simple Dynamic String)
            * Redis没有直接使用C字符串(即以空字符’\0’结尾的字符数组)作为默认的字符串表示，而是使用了SDS
            * buf表示字节数组，用来存储字符串； buf数组的长度=free+len+1 buf数组的长度=free+len+1,长度为9
            * len表示buf已使用的长度，
            * free表示buf未使用的长度。

```c
// redisObject的定义
typedef struct redisObject {
　　unsigned type:4;
　　unsigned encoding:4;
　　unsigned lru:REDIS_LRU_BITS; /* lru time (relative to server.lruclock) */
　　int refcount;
　　void *ptr;
} robj;

// sds
struct sdshdr {
    int len;
    int free;
    char buf[];
};
```

![Alt text](../_static/ "Optional title")

## 数据类型

Redis 没有像 MySQL 这类关系型数据库那样强大的查询功能，需要考虑如何把关系型数据库中的数据，合理的对应到缓存的 key-value 数据结构中。

### String

简单的key-value类型，value可以是String或者数字.值可以是任何各种类的字符串（包括二进制数据）例如你可以在一个键下保存一副jpeg图片.即可以完全实现目前 Memcached 的功能，并且效率更高。还可以享受Redis的定时持久化，操作日志及 Replication等功能

* 获取字符串长度
* 往字符串append内容
* 设置和获取字符串的某一段内容
* 设置及获取字符串的某一位（bit）
* 批量设置一系列字符串的内容

```
set counter 100
get counter
incr counter
incrby counter 10
DECR and DECRBY
```

一般做一些复杂的计数功能的缓存。计数器

### Hash

在Memcached中，我们经常将一些结构化的信息打包成HashMap，在客户端序列化后存储为一个字符串的值，比如用户的昵称、年龄、性别、积分等，这时候在需要修改其中某一项时，通常需要将所有值取出反序列化后，修改某一项的值，再序列化存储回去。这样不仅增大了开销，也不适用于一些可能并发操作的场合（比如两个并发的操作都需要修改积分）。而Redis的Hash结构可以使你像在数据库中Update一个属性一样只修改某一项属性值。

要存储一个用户信息对象数据:

* 将用户ID作为查找key,把其他信息封装成一个对象以序列化的方式存储，这种方式的缺点是，增加了序列化/反序列化的开销，并且在需要修改其中一项信息时，需要把整个对象取回，并且修改操作需要对并发进行保护，引入CAS等复杂问题。
* 这个用户信息对象有多少成员就存成多少个key-value对儿，用用户ID+对应属性的名称作为唯一标识来取得对应属性的值，虽然省去了序列化开销和并发问题，但是用户ID为重复存储，如果存在大量这样的数据，内存浪费还是非常可观的。

Redis的Hash实际是内部存储的Value为一个HashMap，并提供了直接存取这个Map成员的接口.Key仍然是用户ID, value是一个Map，这个Map的key是成员的属性名，value是属性值，这样对数据的修改和存取都可以直接通过其内部Map的Key(Redis里称内部Map的key为field), 也就是通过 key(用户ID) + field(属性标签) 就可以操作对应属性数据了，既不需要重复存储数据，也不会带来序列化和并发修改控制的问题。

Redis提供了接口(hgetall)可以直接取到全部的属性数据,但是如果内部Map的成员很多，那么涉及到遍历整个内部Map的操作，由于Redis单线程模型的缘故，这个遍历操作可能会比较耗时，而另其它客户端的请求完全不响应

HashMap，实际这里会有2种不同实现，这个Hash的成员比较少时Redis为了节省内存会采用类似一维数组的方式来紧凑存储，而不会采用真正的HashMap结构，对应的value redisObject的encoding为zipmap,当成员数量增大时会自动转成真正的HashMap,此时encoding为ht。

```
hgetall
hget
hset
```

做单点登录的时候，就是用这种数据结构存储用户信息，以CookieId作为Key，设置30分钟为缓存过期时间，能很好地模拟出类似Session的效果。

### List

Redis list的实现为一个双向链表，即可以支持反向查找和遍历，更方便操作，不过带来了部分额外的内存开销，Redis内部的很多实现，包括发送缓冲队列等也都是用的这个数据结构。

一般意义上讲，列表就是有序元素的序列：10，20，1，2，3就是一个例表，但用数组实现的List和Linked List实现的list，在属性方面大不相同。
Redis lists基于Linked list实现。这意味着即使在一个list中有数百万个元素，在头部或尾部添加一个元素的操作，其时间复杂度也是常数级别的。用LPUSH命令在十个元素的list头部添加新元素，和在千万元素的list头部添加新元素的速度相同。

坏消息:在数组实现的List中利用索引访问元素的速度极快，而同样的操作在linked list实现的list上没有那么快。

Redis Lists用linked list实现的原因是：
* 对于数据库系统来说，到头重要的特性是：能非常快的在很大的列表上添加元素，
* 正如你将要看到的：Redis lists能在常数时间取得常数长度。

```
RPUSH list1 "Guanqinglin" // 返回索引
LRANGE list1 0 3    // 取范围值
lpush
lpop
rpop
```

* twitter的关注列表，粉丝列表等都可以用Redis的list结构来实现。
* 使用Lists结构，我们可以轻松地实现最新消息排行等功能。
* Lists的另一个应用就是消息队列，可以利用Lists的PUSH操作，将任务存在Lists中，然后工作线程再用POP操作将任务取出进行执行。
* 聊天系统、社交网络中获取用户最新发表的帖子、简单的消息队列、利用Lrange命令，做基于Redis的分页功能、博客的评论系统。

### Set

就是一堆不重复值的组合。可以存储一些集合性的数据

未排序的集合，其元素是二进制安全的字符串。对外提供的功能与list类似是一个列表的功能，特殊之处在于set是可以自动排重的，当你需要存储一个列表数据，又不希望出现重复数据时，set是一个很好的选择，并且set提供了判断某个成员是否在一个set集合内的重要接口

set 的内部实现是一个 value永远为null的HashMap，实际就是通过计算hash的方式来快速排重的，这也是set能提供判断一个成员是否在集合内的原因。

```
SADD myset guan
SMEMBERS myset
SISMEMBER myset guan
spop
sunion
```

当需要存储一个列表数据，而又不希望出现重复的时候
提供了判断某个成员是否在一个Set集合内的接口
比如在微博应用中，可以将一个用户所有的关注人存在一个集合中，将其所有粉丝存在一个集合
Redis还为集合提供了求交集、并集、差集等操作，可以非常方便的实现如共同关注、共同喜好、二度好友等功能，对上面的所有集合操作，你还可以使用不同的命令选择将结果返回给客户端还是存集到一个新的集合中。

### Sorted set

使用场景与set类似，区别是set不是自动有序的，而sorted set可以通过用户额外提供一个优先级(score)的参数来为成员排序，并且是插入有序的，即自动排序。

Redis sorted set的内部使用HashMap和跳跃表(SkipList)来保证数据的存储和有序，HashMap里放的是成员到score的映射，而跳跃表里存放的是所有的成员，排序依据是HashMap里存的score,使用跳跃表的结构可以获得比较高的查找效率，并且在实现上比较简单。

```
zadd
zrange
zrem
zcard
```

#### 场景

当你需要一个有序的并且不重复的集合列表，那么可以选择sorted set数据结构，比如twitter 的public timeline可以以发表时间作为score来存储，这样获取时就是自动按时间排好序的。
另外还可以用Sorted Sets来做带权重的队列，比如普通消息的score为1，重要消息的score为2，然后工作线程可以选择按score的倒序来获取工作任务。让重要的任务优先执行。
排行榜应用，取TOP N操作
做延时任务
最后一个应用就是可以做范围查找

### Pub/Sub

从字面上理解就是发布（Publish）与订阅（Subscribe），在Redis中，你可以设定对某一个key值进行消息发布及消息订阅，当一个key值上进行了消息发布后，所有订阅它的客户端都会收到相应的消息。这一功能最明显的用法就是用作实时消息系统，比如普通的即时聊天，群聊等功能。

### Transactions

Redis的Transactions提供的并不是严格的ACID的事务（比如一串用EXEC提交执行的命令，在执行中服务器宕机，那么会有一部分命令执行了，剩下的没执行），但是这个Transactions还是提供了基本的命令打包执行的功能（在服务器不出问题的情况下，可以保证一连串的命令是顺序在一起执行的，中间有会有其它客户端命令插进来执行）。Redis还提供了一个Watch功能，你可以对一个key进行Watch，然后再执行Transactions，在这过程中，如果这个Watched的值进行了修改，那么这个Transactions会发现并拒绝执行。

## 应用场景

Redis在很多方面与其他数据库解决方案不同：它使用内存提供主存储支持，而仅使用硬盘做持久性的存储；它的数据模型非常独特，用的是单线程。另一个大区别在于，你可以在开发环境中使用Redis的功能，但却不需要转到Redis。

转向Redis当然也是可取的，许多开发者从一开始就把Redis作为首选数据库；但设想如果你的开发环境已经搭建好，应用已经在上面运行了，那么更换数据库框架显然不那么容易。另外在一些需要大容量数据集的应用，Redis也并不适合，因为它的数据集不会超过系统可用的内存。所以如果你有大数据应用，而且主要是读取访问模式，那么Redis并不是正确的选择。
然而我喜欢Redis的一点就是你可以把它融入到你的系统中来，这就能够解决很多问题，比如那些你现有的数据库处理起来感到缓慢的任务。这些你就可以通过Redis来进行优化，或者为应用创建些新的功能。在本文中，我就想探讨一些怎样将Redis加入到现有的环境中，并利用它的原语命令等功能来解决 传统环境中碰到的一些常见问题。在这些例子中，Redis都不是作为首选数据库。

* 显示最新的项目列表：列出最新的回复
* 删除与过滤:用LREM来删除评论 或者 为每个不同的过滤器使用不同的Redis列表。毕竟每个列表只有5000条项目，但Redis却能够使用非常少的内存来处理几百万条项目。
* 排行榜相关：列出前100名高分选手 列出某用户当前的全球排名
* 按照用户投票和时间排序:`score = points / time^alpha`.每次新的新闻贴上来后，我们将ID添加到列表中，使用LPUSH + LTRIM，确保只取出最新的1000条项目。有一项后台任务获取这个列表，并且持续的计算这1000条新闻中每条新闻的最终得分。计算结果由ZADD命令按照新的顺序填充生成列表，老新闻则被清除。这里的关键思路是排序工作是由后台任务来完成的。
* Redis能够替代memcached，让你的缓存从只能存储数据变得能够更新数据，因此你不再需要每次都重新生成数据了。
* 队列：现代的互联网应用大量地使用了消息队列（Messaging）。消息队列不仅被用于系统内部组件之间的通信，同时也被用于系统跟其它服务之间的交互。消息队列的使用可以增加系统的可扩展性、灵活性和用户体验。非基于消息队列的系统，其运行速度取决于系统中最慢的组件的速度（注：短板效应）。而基于消息队列可以将系统中各组件解除耦合，这样系统就不再受最慢组件的束缚，各组件可以异步运行从而得以更快的速度完成各自的工作。此外，当服务器处在高并发操作的时候，比如频繁地写入日志文件。可以利用消息队列实现异步处理。从而实现高性能的并发操作。
* Pub/Sub非常非常简单，运行稳定并且快速。支持模式匹配，能够实时订阅与取消频道。
* 实时分析正在发生的情况，用于数据统计与防止垃圾邮件等
* 特定时间内的特定项目：统计在某段特点时间里有多少特定用户访问了某个特定资源
* 计数：

```
LPUSH latest.comments <ID>
LTRIM latest.comments 0 5000
FUNCTION get_latest_comments(start, num_items):
    id_list = redis.lrange("latest.comments",start,start+num_items - 1)
    IF id_list.length < num_items
        id_list = SQL_DB("SELECT ... ORDER BY time LIMIT ...")
    END
    RETURN id_list
END

ZADD leaderboard  <score>  <username>
ZREVRANGE leaderboard 0 99。
ZRANK leaderboard <username>

 SADD page:day1:<page_id> <user_id>
 SCARD page:day1:<page_id>
 SISMEMBER page:day1:<page_id> // 测试某个特定用户是否访问了这个页面

INCR user:<id> EXPIRE
user:<id> 60   // 计算出最近用户在页面间停顿不超过60秒的页面浏览量
```

## Redis vs memcache

* 数据都是缓存在内存中提供服务
* 使用redis
    - Redis最佳试用场景是*全部数据in-memory*
    - 复杂数据结构:当需要除key/value之外的更多数据类型支持时，使用Redis更合适。用户订单列表，用户消息，帖子评论列表
    - 持久化,周期性的把更新的数据写入到磁盘以及把修改的操作记录追加到文件里记录下来,千万不要把redis当作数据库用
        + redis的定期快照不能保证数据不丢失
        + redis的AOF会降低效率，并且不能支持太大的数据量
    - 天然高可用:需要负载均衡的场景（redis主从同步）,分布式系统支持，数据一致性保证，方便的集群节点添加/删除.支持集群功能，可以实现主动复制，读写分离
        + sentinel集群管理工具，能够实现主从服务监控，故障自动转移
    - 缓存场景，开启固化功能
        + redis挂了再重启，内存里能够快速恢复热数据，不会瞬时将压力压到数据库上，没有一个cache预热的过程。
        + 在redis挂了的过程中，如果数据库中有数据的修改，可能导致redis重启后，数据库与redis的数据不一致。
        - Redis支持数据的持久化，可以将内存中的数据保持在磁盘中，重启的时候可以再次加载进行使用。
    - memcache的value存储，最大为1M，如果存储的value很大，只能使用redis。一定程序上弥补了memcached这类key-value内存缓存服务的不足
    - 支持publish/subscribe，通知，key过期等等特性
* 使用memcache场景：纯KV，数据量非常大，并发量非常大的业务，或许更适合
    - 内存分配:memcache使用预分配内存池的方式管理内存，能够省去内存分配时间。redis则是临时申请空间，可能导致碎片。
    - 虚拟内存使用:memcache把所有的数据存储在物理内存里。redis有自己的VM机制，理论上能够存储比物理内存更多的数据，当数据超量时，会引发swap，把冷数据刷到磁盘上。
    - 网络模型:memcache使用非阻塞IO复用模型，redis也是使用非阻塞IO复用模型。但由于redis还提供一些非KV存储之外的排序，聚合功能，在执行这些功能时，复杂的CPU计算，会阻塞整个IO调度。
    - 线程模型:memcache使用多线程，主线程监听，worker子线程接受请求，执行读写，这个过程中，可能存在锁冲突。redis使用单线程，虽无锁冲突，但难以利用多核的特性提升整体吞吐量。

## 注意

* Key命名规范：AppID:KeyName
* 缓存穿透处理：根据Redis key在缓存中查询后，不存在对应Value，就应该会在后端系统如DB中去查找，该Key的并发请求量一旦变大，那么就会对DB造成很大的压力
    - 前端风险控制，将恶意穿透情况排除在外；
    - 对查询结果为空的情况依然进行缓存，但缓存时间会设置得很短，一般是几分钟。
* 缓存雪崩处理：当缓存服务器重启或者大量缓存集中在某一个时间段失效，这样在失效的时候，也会给后端系统(比如DB)带来很大压力。
    - 后端连接数限制，错误阈值限制，超时处理，缓存失效时间均匀分布，前端永不失效及后端主动更新。
* 缓存时长：策略定位复杂，需要多维度的计算。
* 缓存失效：按时失效，事件失效，后端主动更新。
* 缓存Key：Hash、规则、前缀+Hash，异常情况可人工干预。
* Lua脚本：服务端批量处理及事务能力，有条件逻辑的可扩展脚本。使用它的好处有：减少网络开销、原子操作、可复用。
* Limit：可滑动时间窗口，如应用于Session，Memcached需每次传Key和Value。
* redis的定期快照不能保证数据不丢失
* redis的AOF会降低效率，并且不能支持太大的数据量

## 过期策略及内存淘汰机制

* 定时删除：用一个定时器来负责监视Key，过期则自动删除。虽然内存及时释放，但是十分消耗CPU资源。在大并发请求下，CPU要将时间应用在处理请求，而不是删除Key，因此没有采用这一策略。Redis默认每个100ms检查是否有过期的Key，有过期Key则删除。需要说明的是，Redis不是每个100ms将所有的Key检查一次，而是随机抽取进行检查（如果每隔100ms，全部Key进行检查，Redis岂不是卡死）。因此，如果只采用定期删除策略，会导致很多Key到时间没有删除。
* 惰性删除：在你获取某个Key的时候，Redis会检查一下，这个Key如果设置了过期时间，那么是否过期了？如果过期了此时就会删除。
* 内存淘汰机制：通过配置文件
    - Noeviction：当内存不足以容纳新写入数据时，新写入操作会报错。
    - Allkeys-lru：当内存不足以容纳新写入数据时，在键空间中，移除最近最少使用的Key。推荐使用，目前项目在用这种；
    - Allkeys-random：当内存不足以容纳新写入数据时，在键空间中，随机移除某个key，应该也没人使用吧；
    - Volatile-lru：当内存不足以容纳新写入数据时，在设置了过期时间的键空间中，移除最近最少使用的Key。这种情况一般是把Redis既当缓存又做持久化存储的时候才用。不推荐；
    - Volatile-random：当内存不足以容纳新写入数据时，在设置了过期时间的键空间中，随机移除某个Key。依然不推荐；
    - Volatile-ttl：当内存不足以容纳新写入数据时，在设置了过期时间的键空间中，有更早过期时间的Key优先移除。不推荐。
    - 如果没有设置Expire的Key，不满足先决条件（Prerequisites）；那么Volatile-lru、Volatile-random和Volatile-ttl策略的行为，和Noeviction（不删除）基本上一致。

```
maxmemory-policy volatile-lru
```

## 缺点

* 缓存和数据库双写一致性问题:一致性问题是分布式常见问题，还可以再分为最终一致性和强一致性,先明白一个前提：如果对数据有强一致性要求，就不能放缓存。我们所做的一切，只能保证最终一致性。
    - 采取正确更新策略，先更新数据库，再删缓存
    - 因为可能存在删除缓存失败的问题，提供一个补偿措施即可，例如利用消息队列。
* 缓存雪崩问题:缓存同一时间大面积的失效，这个时候又来了一波请求，结果请求都怼到数据库上，从而导致数据库连接异常
    - 给缓存的失效时间加上一个随机值，避免集体失效
    - 使用互斥锁，但是该方案吞吐量明显下降了
    - 双缓存。我们有两个缓存，缓存A和缓存B。缓存A的失效时间为20分钟，缓存B不设失效时间，自己做缓存预热操作。然后细分以下几个小点：
        + 从缓存A读数据库，有则直接返回；
        + A 没有数据，直接从B读数据，直接返回，并且异步启动一个更新线程；
        + 更新线程同时更新缓存A和缓存B。
* 缓存击穿问题:故意去请求缓存中不存在的数据，导致所有的请求都怼到数据库上，从而数据库连接异常
    - 利用互斥锁，缓存失效的时候，先去获得锁，得到锁了，再去请求数据库，没得到锁，则休眠一段时间重试；
    - 采用异步更新策略，无论Key是否取到值，都直接返回。Value值中维护一个缓存失效时间，缓存如果过期，异步起一个线程去读数据库，更新缓存，需要做缓存预热（项目启动前，先加载缓存）操作；
    - 提供一个能迅速判断请求是否有效的拦截机制，比如利用布隆过滤器，内部维护一系列合法有效的Key，迅速判断出，请求所携带的Key是否合法有效，如果不合法，则直接返回。
* 缓存的并发竞争问题:同时有多个子系统去Set一个Key,很多推荐用Redis事务机制，不推荐因为基本都是Redis集群环境，做了数据分片操作。你一个事务中有涉及到多个Key操作的时候，这多个Key不一定都存储在同一个Redis-Server上。
    - 对这个Key操作不要求顺序：这种情况下，准备一个分布式锁，大家去抢锁，抢到锁就做Set操作即可
    - 对这个Key操作要求顺序：数据写入数据库的时候，需要保存一个时间戳

## 锁

* 悲观锁(Pessimistic Lock)：每次去拿数据的时候都认为别人会修改，所以每次在拿数据的时候都会上锁。
    - 场景：如果项目中使用了缓存且对缓存设置了超时时间。
    - 当并发量比较大的时候，如果没有锁机制，那么缓存过期的瞬间，大量并发请求会穿透缓存直接查询数据库，造成雪崩效应。

* 乐观锁(Optimistic Lock), 每次去拿数据的时候都认为别人不会修改，所以不会上锁。
    - watch命令会监视给定的key，当exec时候如果监视的key从调用watch后发生过变化，则整个事务会失败。
    - 也可以调用watch多次监视多个key。这样就可以对指定的key加乐观锁了。
    - 注意watch的key是对整个连接有效的，事务也一样。
    - 如果连接断开，监视和事务都会被自动清除。当然了exec，discard，unwatch命令都会清除连接中的所有监视。

## pipeline vs multi

* pipeline 只是把多个redis指令一起发出去，redis并没有保证这些指定的执行是原子的；
* multi相当于一个redis的transaction的，保证整个操作的原子性，避免由于中途出错而导致最后产生的数据不一致。
* pipeline方式执行效率要比其他方式高10倍左右的速度，启用multi写入要比没有开启慢一点。

## 注意

* 估算Redis内存使用量。目前为止，内存的使用成本仍然相对较高，使用内存不能无所顾忌；根据需求合理的评估Redis的内存使用量，选择合适的机器配置，可以在满足需求的情况下节约成本。
* 优化内存占用。了解Redis内存模型可以选择更合适的数据类型和编码，更好的利用Redis内存。
* 分析解决问题。当Redis出现阻塞、内存占用等问题时，尽快发现导致问题的原因，便于分析解决问题。

## 开发规范

* 键值设计
    - key 名设计
        + 可读性和可管理性：业务名 (或数据库名) 为前缀 (防止 key 冲突)，用冒号分隔
        + 业务名 (或数据库名) 为前缀 (防止 key 冲突)，用冒号分隔，简化单词
        + 不要包含特殊字符
    - value 设计
        + 拒绝 bigkey(防止网卡流量、慢查询)：string 类型控制在 10KB 以内，hash、list、set、zset 元素个数不要超过 5000。
        + 非字符串的 bigkey，不要使用 del 删除，使用 hscan、sscan、zscan 方式渐进式删除，同时要注意防止 bigkey 过期时间自动删除问题 (例如一个 200 万的 zset 设置 1 小时过期，会触发 del 操作，造成阻塞，而且该操作不会不出现在慢查询中 (latency 可查))
        + 选择适合的数据类型。合理控制和使用数据结构内存编码优化配置，也要注意节省内存和性能之间的平衡
        + 控制 key 的生命周期：设置过期时间 (条件允许可以打散过期时间，防止集中过期)，不过期的数据重点关注 idletime。
* 命令使用
    - O(N) 命令关注 N 的数量：例如 hgetall、lrange、smembers、zrange、sinter 等并非不能使用，但是需要明确 N 的值。有遍历的需求可以使用 hscan、sscan、zscan 代替。
    - 禁用命令：禁止线上使用 keys、flushall、flushdb 等，通过 redis 的 rename 机制禁掉命令，或者使用 scan 的方式渐进式处理。
    - 合理使用 select：redis 的多数据库较弱，使用数字进行区分，很多客户端支持较差，同时多业务用多数据库实际还是单线程处理，会有干扰。
    - 使用批量操作（pipeline）提高效率：控制一次批量操作的元素个数(例如 500 以内，实际也和元素字节数有关)
        + 原生是原子操作，pipeline 是非原子操作。
        + pipeline 可以打包不同的命令，原生做不到
        + pipeline 需要客户端和服务端同时支持。
    - Redis 事务功能较弱(不支持回滚)，不建议过多使用。集群版本 (自研和官方) 要求一次事务操作的 key 必须在一个 slot 上 (可以使用 hashtag 功能解决)
    - Redis 集群版本在使用 Lua 上有特殊要求：
        + 所有 key 都应该由 KEYS 数组来传递，redis.call/pcall 里面调用的 redis 命令，key 的位置，必须是 KEYS array, 否则直接返回 error，"-ERR bad lua script for redis cluster, all the keys that the script uses should be passed using the KEYS array"
        + 所有 key，必须在 1 个 slot 上，否则直接返回 error, “-ERR eval/evalsha command keys must in same slot”
    - 必要情况下使用 monitor 命令时，要注意不要长时间使用。
* 客户端使用
    - 避免多个应用使用一个 Redis 实例：不相干的业务拆分，公共数据做服务化。
    - 使用带有连接池的数据库，可以有效控制连接，同时提高效率
    - 高并发下建议客户端添加熔断功能 (例如 netflix hystrix)
    - 设置合理的密码，如有必要可以使用 SSL 加密访问
    - 根据自身业务类型，选好 maxmemory-policy(最大内存淘汰策略)，设置好过期时间。


```sh
# big key 搜索
import sys
import redis

def check_big_key(r, k):
  bigKey = False
  length = 0
  try:
    type = r.type(k)
    if type == "string":
      length = r.strlen(k)
    elif type == "hash":
      length = r.hlen(k)
    elif type == "list":
      length = r.llen(k)
    elif type == "set":
      length = r.scard(k)
    elif type == "zset":
      length = r.zcard(k)
  except:
    return
  if length > 10240:
    bigKey = True
  if bigKey :
    print db,k,type,length

def find_big_key_normal(db_host, db_port, db_password, db_num):
  r = redis.StrictRedis(host=db_host, port=db_port, password=db_password, db=db_num)
  for k in r.scan_iter(count=1000):
    check_big_key(r, k)

def find_big_key_sharding(db_host, db_port, db_password, db_num, nodecount):
  r = redis.StrictRedis(host=db_host, port=db_port, password=db_password, db=db_num)
  cursor = 0
  for node in range(0, nodecount) :
    while True:
      iscan = r.execute_command("iscan",str(node), str(cursor), "count", "1000")
      for k in iscan[1]:
        check_big_key(r, k)
      cursor = iscan[0]
      print cursor, db, node, len(iscan[1])
      if cursor == "0":
        break;

if \__name__\ == '__main__':
  if len(sys.argv) != 4:
     print 'Usage: python ', sys.argv[0], ' host port password '
     exit(1)
  db_host = sys.argv[1]
  db_port = sys.argv[2]
  db_password = sys.argv[3]
  r = redis.StrictRedis(host=db_host, port=int(db_port), password=db_password)
  nodecount = r.info()['nodecount']
  keyspace_info = r.info("keyspace")
  for db in keyspace_info:
    print 'check ', db, ' ', keyspace_info[db]
    if nodecount > 1:
      find_big_key_sharding(db_host, db_port, db_password, db.replace("db",""), nodecount)
    else:
      find_big_key_normal(db_host, db_port, db_password, db.replace("db", ""))
```

```java
// 删除 bigkey
// Hash 删除: hscan + hdel
public void delBigHash(String host, int port, String password, String bigHashKey) {
    Jedis jedis = new Jedis(host, port);
    if (password != null && !"".equals(password)) {
        jedis.auth(password);
    }
    ScanParams scanParams = new ScanParams().count(100);
    String cursor = "0";
    do {
        ScanResult<Entry<String, String>> scanResult = jedis.hscan(bigHashKey, cursor, scanParams);
        List<Entry<String, String>> entryList = scanResult.getResult();
        if (entryList != null && !entryList.isEmpty()) {
            for (Entry<String, String> entry : entryList) {
                jedis.hdel(bigHashKey, entry.getKey());
            }
        }
        cursor = scanResult.getStringCursor();
    } while (!"0".equals(cursor));

    // 删除 bigkey
    jedis.del(bigHashKey);
}

// List 删除: ltrim
public void delBigList(String host, int port, String password, String bigListKey) {
    Jedis jedis = new Jedis(host, port);
    if (password != null && !"".equals(password)) {
        jedis.auth(password);
    }
    long llen = jedis.llen(bigListKey);
    int counter = 0;
    int left = 100;
    while (counter < llen) {
        // 每次从左侧截掉 100 个
        jedis.ltrim(bigListKey, left, llen);
        counter += left;
    }
    // 最终删除 key
    jedis.del(bigListKey);
}
```

## 工具

* [Redis Desktop Manager](https://github.com/uglide/RedisDesktopManager):🔧 Cross-platform GUI management tool for Redis http://redisdesktop.com
* [sripathikrishnan/redis-rdb-tools](https://github.com/sripathikrishnan/redis-rdb-tools):Parse Redis dump.rdb files, Analyze Memory, and Export Data to JSON
* [twitter/twemproxy](https://github.com/twitter/twemproxy):A fast, light-weight proxy for memcached and redis
* [CodisLabs/codis](https://github.com/CodisLabs/codis):Proxy based Redis cluster solution supporting pipeline and scaling dynamically
* [erikdubbelboer/phpRedisAdmin](https://github.com/erikdubbelboer/phpRedisAdmin):Simple web interface to manage Redis databases. http://dubbelboer.com/phpRedisAdmin/
* [phpredis/phpredis](https://github.com/phpredis/phpredis):A PHP extension for Redis
* [redis-port](link):redis 间数据同步
* big key 搜索:参考上面
* [redis-faina](https://github.com/facebookarchive/redis-faina):热点 key 寻找 (内部实现使用 monitor，所以建议短时间使用)
* Jedis
    - [Jedis 常见异常汇总](https://yq.aliyun.com/articles/236384)
    - [JedisPool 资源池优化](https://yq.aliyun.com/articles/236383)

## 参考

* [redis 数据类型详解 以及 redis适用场景场合](http://www.cnblogs.com/mrhgw/p/6278619.html)
* [使用Redis实现分布式锁及其优化](https://juejin.im/entry/5a0280d551882546d71ec42e)
* [Redis快速入门及应用](https://juejin.im/entry/5a003862f265da430406042c)
