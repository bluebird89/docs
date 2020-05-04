# [antirez/redis](https://github.com/antirez/redis)

Redis is an in-memory database that persists on disk. The data model is key-value, but many different kind of values are supported: Strings, Lists, Sets, Sorted Sets, Hashes, HyperLogLogs, Bitmaps. http://redis.io

## 原理

* 一种基于客户端-服务端模型以及请求/响应协议的TCP服务
    - 客户端向服务端发送一个查询请求，并监听Socket返回，通常是以阻塞模式，等待服务端响应
    - 服务端处理命令，并将结果返回给客户端
* 性能：纯内存操作，单线程操作，避免了线程切换和锁的性能消耗，10万次读写操作
    - 将数据都读到内存中，通过异步的方式将数据写入磁盘
    - 利用队列技术将并发访问变为串行访问，消除了传统数据库串行控制的开销
    - 单线程简化数据结构和算法的实现：要多核运行可以启动多个实例
* 单个value的最大限制是1GB(memcached 是1MB)
* 非阻塞I/O多路复用机制，单线程根据Socket的不同状态执行每个Socket(I/O流)：任务，采用的 I/O 多路复用函数：epoll/kqueue/evport/select
    - 用epoll作为IO多路复用技术的实现，再加上redis自身事件处理模型将epoll中的链接、读写、关闭都转换为事件，不在网络IO上浪费过多的事件
* 内部使用一个redisObject对象来表示所有的key和value,redisObject主要的信息
    - type代表一个value对象具体是何种数据类型
    - encoding是不同数据类型在redis内部的存储方式
* 虚拟内存：构建了VM 机制，因为调用系统函数的话，会浪费一定的时间去移动和请求
    - key很小而value很大时,使用VM的效果会比较好.因为这样节约的内存比较大
    - key不小时,可以考虑使用一些非常方法将很大的key变成很大的value,比如可以考虑将key,value组合成一个新的value
    - vm-max-threads参数,可以设置访问swap文件的线程数,设置最好不要超过机器的核数,如果设置为0,那么所有对swap文件的操作都是串行的.可能会造成比较长时间的延迟,但是对数据完整性有很好的保证
    - vm 字段，只有打开了Redis的虚拟内存功能，此字段才会真正的分配内存
* 支持Lua脚本
* 分布式
* 缺点：容量受到物理内存的限制，不能用作海量数据的高性能读写，局限在较小数据量的高性能操作和运算上

### 版本

* 3.2
    - 地理信息：新增了地理信息相关的命令，可以将用户给定的地理位置信息（经纬度）存储起来，并对这些信息进行操作
* 6.0
    - SSL
    - ACL: 更好，命令支持
    - RESP3
    - Client side caching:重新设计 `CLIENT TRACKING ON|OFF [REDIRECT client-id] [PREFIX prefix] [BCAST] [OPTIN] [OPTOUT] [NOLOOP]`
    - Threaded I/O
    - Diskless replication on replicas
    - Cluster support in Redis-benchmark and improved redis-cli cluster support
    - Disque in beta as a module of Redis: 开始侵入消息队列领域
    - Redis Cluster Proxy
    - 支持RDB不再使用时可立即删除，针对不落盘的场景
    - PSYNC2: 优化的复制协议
    - 超时设置支持更友好
    - 更快的RDB加载，20% ~ 30%的提升
    - STRALGO，新的字符串命令，目前只有一个实现LCS (longest common subsequence)

## 安装

* redis-server：redis服务器的daemon启动程序
* redis-cli：Redis命令操作工具。也可以telnet根据其纯文本协助来操作
* redis-benchmark：性能测试工具，测试读写性能
* redis-check-aof：更新日志检查
* redis-check-dump：本地数据库检查

```sh
# Mac
brew install redis
brew services start/stop/restart redis
redis-server /usr/local/etc/redis.conf

# ubuntu
sudo apt-get install redis-server php-redis

systemctl enable|status|stop redis-server
```

## 配置

```
openssl rand 60 | openssl base64 -A # 密码生成

# /etc/redis/redis.conf
daemonize no
pidfile /var/run/redis.pid
bind 127.0.0.1
timeout 300 # 客户端闲置多长时间后关闭连接

# 数据同步到数据文件 条件
save 900 1
save 300 10
save 60 10000
rdbcompression yes
dbfilename dump.rdb # 指定本地数据库文件名
dir ./ # 指定本地数据库存放目录
slaveof <masterip> <masterport> # 设置当本机为slav服务时，设置master服务的IP地址及端口，在Redis启动时，它会自动从master进行数据同步
masterauth <master-password> # master服务设置了密码保护时，slav服务连接master的密码
requirepass foobared # 配置了连接密码，客户端在连接Redis时需要通过AUTH <password>命令提供密码，默认关闭
appendonly no # 指定是否在每次更新操作后进行日志记录，Redis在默认情况下是异步的把数据写入磁盘，如果不开启，可能会在断电时导致一段时间内的数据丢失。因为 redis本身同步数据文件是按上面save条件来同步的，所以有的数据会在一段时间内只存在于内存中。默认为no
appendfilename appendonly.aof # 更新日志文件名，默认为appendonly.aof

rename-command FLUSHDB ""
rename-command FLUSHALL ""
rename-command DEBUG ""
rename-command SHUTDOWN SHUTDOWN_MENOT
rename-command CONFIG ASC12_CONFIG

CONFIG GET *
CONFIG set requirepass "shouce.ren" # 设置密码
CONFIG get requirepass

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

* 通过监听一个 TCP 端口或者 Unix socket 的方式来接收来自客户端的连接，当一个连接建立后，Redis 内部会进行以下一些操作：
    - 客户端 socket 会被设置为非阻塞模式，因为 Redis 在网络事件处理上采用的是非阻塞多路复用模型。
    - 为这个 socket 设置 TCP_NODELAY 属性，禁用 Nagle 算法
    - 创建一个可读的文件事件用于监听这个客户端 socket 的数据发送
* 长链接 短链接

```sh
# 设置最大连接数
redis-server --maxclients 100000
# 客户端使用
redis-cli -h localhost -p 6379 -a password
info # 功能统计
info memory|server|clients|Persistence|Stats|Replication|CPU|cluster|keyspace

type key # 获取类型
object encoding key # 查看编码
object idletime key # 查看空转时间
object refcount key # 查看引用次数

AUTH PASSWORD # 密码校验
CLIENT LIST # 返回连接到 redis 服务的客户端列表
CLIENT SETNAME  # 设置当前连接的名称
CLIENT GETNAME  # 获取通过 CLIENT SETNAME 命令设置的服务名称
CLIENT PAUSE    # 挂起客户端连接，指定挂起的时间以毫秒计
CLIENT KILL # 关闭客户端连接
```

## 内存

* 内存统计: `info memeory`
    - used_memory：Redis分配器分配的内存总量（单位是字节），包括使用的虚拟内存（即swap）
    - used_memory_rss：Redis进程占据操作系统的内存（单位是字节），与top及ps命令看到的值是一致的；除了分配器分配的内存之外，used_memory_rss还包括进程运行本身需要的内存、内存碎片等，但是不包括虚拟内存。
    - 二者之所以有所不同，一方面是因为内存碎片和Redis进程运行需要占用内存，使得前者可能比后者小，另一方面虚拟内存的存在，使得前者可能比后者大。
    - 内存碎片比率 mem_fragmentation_ratio:used_memory_rss / used_memory，衡量Redis内存碎片率的参数.一般大于1，且该值越大，内存碎片比例越大. <1，说明Redis使用了虚拟内存，由于虚拟内存的媒介是磁盘，比内存速度要慢很多，当这种情况出现时，应该及时排查，如果内存不足应该及时处理，如增加Redis节点、增加Redis服务器的内存、优化应用等
        + 在1.03左右是比较健康的状态
    - mem_allocator：Redis使用的内存分配器，在编译时指定；可以是 libc 、jemalloc或者tcmalloc，默认是jemalloc
* 内存划分
    - 数据：对外提供5种数据类型。在内部，每种类型可能有2种或更多的内部编码实现；在存储对象时，并不是直接将数据扔进内存，而是会对对象进行各种包装
    - 除了主进程外，Redis创建的子进程运行也会占用内存，如Redis执行AOF、RDB重写时创建的子进程。当然，这部分内存不属于Redis进程，也不会统计在used_memory和used_memory_rss中
    - 缓冲内存
        + 客户端缓冲存储客户端连接的输入输出缓冲
        + 复制积压缓冲用于部分复制功能
        + AOF缓冲区用于在进行AOF重写时，保存最近的写入命令
    - 内存碎片：在分配、回收物理内存过程中产生。与对数据进行的操作、数据的特点等都有关；此外，与使用的内存分配器也有关系，jemalloc便在控制内存碎片方面做的很好
        -  可以通过安全重启的方式减小内存碎片：因为重启之后，Redis重新从备份文件中读取数据，在内存中进行重排，为每个数据重新选择合适的内存单元，减小内存碎片
* 概念
    - dictEntry：Redis是Key-Value数据库，因此对每个键值对都会有一个dictEntry，里面存储了指向Key和Value的指针；next指向下一个dictEntry，与本Key-Value无关。
    - Key：Key（”hello”）并不是直接以字符串存储，而是存储在SDS结构中
    - redisObject：Value(“world”)既不是直接以字符串存储，也不是像Key一样直接存储在SDS中，而是存储在redisObject中。实际上，不论Value是5种类型的哪一种，都是通过redisObject来存储的；而redisObject中的type字段指明了Value对象的类型，ptr字段则指向对象所在的地址。不过可以看出，字符串对象虽然经过了redisObject的包装，但仍然需要通过SDS存储。
        + type:表示对象的类型,REDIS_STRING(字符串)、REDIS_LIST (列表)、REDIS_HASH(哈希)、REDIS_SET(集合)、REDIS_ZSET(有序集合)
        + encoding表示对象的内部编码:每种类型，都有至少两种内部编码，例如对于字符串，有int、embstr、raw三种编码。通过encoding属性，Redis可以根据不同的使用场景来为对象设置不同的编码，大大提高了Redis的灵活性和效率。
            * 以对象为例，有压缩列表和双端链表两种编码方式；如果列表中的元素较少，倾向于使用压缩列表进行存储，因为压缩列表占用内存更少，而且比双端链表可以更快载入；当列表对象元素较多时，压缩列表就会转化为更适合存储大量元素的双端链表。
        + lru记录的是对象最后一次被命令程序访问的时间，占据的比特数不同的版本有所不同。通过对比lru时间与当前时间，可以计算某个对象的空转时间(单位是秒),一个特殊之处在于它不改变对象的lru值. 还与Redis的内存回收有关系：如果Redis打开了maxmemory选项，且内存回收算法选择的是volatile-lru或allkeys—lru，那么当Redis内存占用超过maxmemory指定的值时，Redis会优先选择空转时间最长的对象进行释放。
        + refcount记录的是该对象被引用的次数，类型为整型。refcount的作用，主要在于对象的引用计数和内存回收。当创建新对象时，refcount初始化为1；当有新程序使用该对象时，refcount加1；当对象不再被一个新程序使用时，refcount减1；当refcount变为0时，对象占用的内存会被释放。
            * 被多次使用的对象(refcount>1)，称为共享对象。Redis为了节省内存，当有一些对象重复出现时，新的程序不会创建新的对象，而是仍然使用原来的对象。这个被重复使用的对象，就是共享对象。目前共享对象仅支持整数值的字符串对象
                - 只支持整数值的字符串对象。之所以如此，实际上是对内存和CPU（时间）的平衡：共享对象虽然会降低内存消耗，但是判断两个对象是否相等却需要消耗额外的时间。对于整数值，判断操作复杂度为O(1)；对于普通字符串，判断复杂度为O(n)；而对于哈希、列表、集合和有序集合，判断的复杂度为O(n^2)。
            * 享对象只能是整数值的字符串对象，但是5种类型都可能使用共享对象。Redis服务器在初始化时，会创建10000个字符串对象，值分别是0~9999的整数值；当Redis需要使用值为0~9999的字符串对象时，可以直接使用这些共享对象。10000这个数字可以通过调整参数REDIS_SHARED_INTEGERS（4.0中是OBJ_SHARED_INTEGERS）的值进行改变。
        + ptr指针指向具体的数据
        + 一个redisObject对象的大小为16字节
        + vm:只有打开了Redis的虚拟内存功能，此字段才会真正的分配内存，该功能默认是关闭状态的
    - jemalloc：无论是DictEntry对象，还是redisObject、SDS对象，都需要内存分配器（如jemalloc）分配内存进行存储。以DictEntry对象为例，有3个指针组成，在64位机器下占24个字节，jemalloc会为它分配32字节大小的内存单元。
        + jemalloc在64位系统中，将内存空间划分为小、大、巨大三个范围；每个范围内又划分了许多小的内存块单位；当Redis存储数据时，会选择大小最合适的内存块进行存储。
    - SDS(Simple Dynamic String)
        + Redis没有直接使用C字符串(即以空字符’\0’结尾的字符数组)作为默认的字符串表示，而是使用了SDS
        + buf表示字节数组，用来存储字符串； buf数组的长度=free+len+1 buf 数组的长度=free+len+1,长度为9
        + len表示buf已使用的长度
        + free表示buf未使用的长度
        + SDS与C字符串的比较：加入了free和len字段，带来了很多好处
            * 获取字符串长度：SDS是O(1)，C字符串是O(n)
            * 缓冲区溢出：使用C字符串的API时，如果字符串长度增加（如strcat操作）而忘记重新分配内存，很容易造成缓冲区的溢出；而SDS由于记录了长度，相应的API在可能造成缓冲区溢出时会自动重新分配内存，杜绝了缓冲区溢出。
            * 修改字符串时内存的重分配：对于C字符串，如果要修改字符串，必须要重新分配内存（先释放再申请），因为如果没有重新分配，字符串长度增大时会造成内存缓冲区溢出，字符串长度减小时会造成内存泄露。而对于SDS，由于可以记录len和free，因此解除了字符串长度和空间数组长度之间的关联，可以在此基础上进行优化：空间预分配策略（即分配内存时比实际需要的多）使得字符串长度增大时重新分配内存的概率大大减小；惰性空间释放策略使得字符串长度减小时重新分配内存的概率大大减小。
            * 存取二进制数据：SDS可以，C字符串不可以。因为C字符串以空字符作为字符串结束的标识，而对于一些二进制文件（如图片等），内容可能包括空字符串，因此C字符串无法正确存取；而SDS以字符串长度len来作为字符串结束标识，因此没有这个问题。
* 编码：每种结构都有至少两种编码，优点：
    - 接口与实现分离，当需要增加或改变内部编码时，用户使用不受影响
    - 可以根据不同的应用场景切换内部编码，提高效率
* 估算Redis内存使用量：对redis的内存模型有比较全面的了解
    - 假设有90000个键值对，每个key的长度是7个字节，每个value的长度也是7个字节（且key和value都不是整数）。判定字符串类型使用的编码方式：embstr。内存空间主要可以分为两部分：一部分是90000个dictEntry占据的空间；一部分是键值对所需要的bucket空间。
    - 每个dictEntry占据的空间包括：
        + 一个dictEntry，24字节，jemalloc会分配32字节的内存块
        + 一个key，7字节，所以SDS(key)需要7+9=16个字节，jemalloc会分配16字节的内存块
        + 一个redisObject，16字节，jemalloc会分配16字节的内存块
        + 一个value，7字节，所以SDS(value)需要7+9=16个字节，jemalloc会分配16字节的内存块
        + 综上，一个dictEntry需要32+16+16+16=80个字节。
    - bucket数组的大小为大于90000的最小的2^n，是131072；每个bucket元素为8字节（因为64位系统中指针大小为8字节）
    - 这90000个键值对占据的内存大小为：90000*80 + 131072*8 = 8248576
* 优化内存占用
    - 利用jemalloc特性进行优化：由于jemalloc分配内存时数值是不连续的，因此key/value字符串变化一个字节，可能会引起占用内存很大的变动
    - 如果是整型/长整型，Redis会使用int类型（8字节）存储来代替字符串，可以节省更多空间。因此在可以使用长整型/整型代替字符串的场景下，尽量使用长整型/整型。
    - 利用共享对象，可以减少对象的创建（同时减少了redisObject的创建），节省内存空间。目前redis中的共享对象只包括10000个整数（0-9999）；可以通过调整REDIS_SHARED_INTEGERS参数提高共享对象的个数；例如将REDIS_SHARED_INTEGERS调整到20000，则0-19999之间的对象都可以共享。
    - 避免过度设计：考虑内存空间与设计复杂度的权衡；而设计复杂度会影响到代码的复杂度、可维护性。如果数据量较小，那么为了节省内存而使得代码的开发、维护变得更加困难并不划算；还是以前面讲到的90000个键值对为例，实际上节省的内存空间只有几MB。但是如果数据量有几千万甚至上亿，考虑内存的优化就比较必要了。
* 关注内存碎片率
    - 如果内存碎片率过高（jemalloc在1.03左右比较正常），说明内存碎片多，内存浪费严重；这时便可以考虑重启redis服务，在内存中对数据进行重排，减少内存碎片。
    - 如果内存碎片率小于1，说明redis内存不足，部分数据使用了虚拟内存（即swap）；由于虚拟内存的存取速度比物理内存差很多（2-3个数量级），此时redis的访问速度可能会变得很慢。因此必须设法增大物理内存（可以增加服务器节点数量，或提高单机内存），或减少redis中的数据。
    - 要减少redis中的数据，除了选用合适的数据类型、利用共享对象等，还有一点是要设置合理的数据回收策略（maxmemory-policy），当内存达到一定量后，根据不同的优先级对内存进行回收。

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

## 通用

* KEYS pattern：模糊查询key，通配符  *、?、[]
    - `keys user_token*`:遍历算法，复杂度是O(n),导致 Redis 服务卡顿，因为Redis 是单线程程序，顺序执行所有指令，其它指令必须等到当前的 keys 指令执行完了才可以继续
    - 遍历大数据量用基于游标的迭代器，需要基于上一次的游标延续之前的迭代过程 `SCAN cursor [MATCH pattern] [COUNT count]` cursor：游标 MATCH pattern：查询 Key 的条件 Count：返回的条数
        + SCAN 0 MATCH test* COUNT 10 //每次返回10条以test为前缀的key
        + 复杂度虽然也是 O(n)，但是它是通过游标分步进行的，不会阻塞线程,增量的循环，每次调用只会返回一小部分的元素
        + 提供 count 参数，不是结果数量，是redis单次遍历字典槽位数量(约等于)
        + 同 keys 一样，它也提供模式匹配功能;
        + 服务器不需要为游标保存状态，游标的唯一状态就是 scan 返回给客户端的游标整数;
        + 返回的结果可能会有重复，需要客户端去重复，这点非常重要;
        + 单次返回的结果是空的并不意味着遍历结束，而要看返回的游标值是否为零
        + `scan 0 match user_token* count 5`
* RANDOMKEY：返回随机key　　
* DUMP key: 序列化给定 key ，并返回被序列化的值
* TYPE key 返回 key 所储存的值的类型
* EXISTS key：判断某个key是否存在
* DEL key：删除key
* RENAME key newkey：改名
* RENAMENX key newkey：如果newkey不存在则修改成功,新建key
    - 修改成功时，返回 1。 如果 NEW_KEY_NAME 已经存在，返回 0
* 时效
    - TTL key：查询key的生命周期（秒）
    - PTTL key：查询key 的生命周期（毫秒）
    - EXPIRE key seconds：设置key的生命周期以秒为单位
    - PEXPIRE key milliseconds：设置key的生命周期以毫秒为单位
    - EXPIREAT key timestamp
    - PEXPIREAT key milliseconds-timestamp 设置 key 过期时间的时间戳(unix timestamp) 以毫秒计
    - PERSIST key：把指定key设置为永久有效
* 服务
    - PING：测定连接是否存活
    - info：获取服务器的信息和统计
    - monitor：实时转储收到的请求
    - time：显示服务器时间，时间戳（秒），微秒数
    - quit：退出连接
    - shutdown [save/nosave]
    - echo：在命令行打印一些内容
    - CLIENT LIST 获取连接到服务器的客户端连接列表
    - CLIENT KILL [ip:port] [ID client-id] :关闭客户端连接
    - SLAVEOF host port 将当前服务器转变为指定服务器的从属服务器(slave server)
* 配置
    - config get 配置项：获取服务器配置的信息
    - config set 配置项  值：设置配置项信息
* 数据
    - MOVE key db：将key移动到1数据库
    - dbsize：返回当前数据库中key的数目
    - SET db_number 0 :默认使用 0 号数据库
    - select index：选择数据库
    - flushdb：删除当前选择数据库中所有的key
    - flushall：删除所有数据库中的所有的key
        + 如果不小心运行了flushall，立即shutdown nosave，关闭服务器，然后手工编辑aof文件，去掉文件中的flushall相关行，然后开启服务器，就可以倒回原来是数据。如果flushall之后，系统恰好bgwriteaof了，那么aof就清空了，数据丢失。
* 持久化
    - BGREWRITEAOF : 异步执行一个 AOF（AppendOnly File） 文件重写操作
    - BGSAVE：在后台异步保存当前数据库的数据到磁盘
    - SAVE：创建当前数据库的备份
    - 恢复数据，只需将备份文件 (dump.rdb) 移动到 redis 安装目录并启动服务即可。获取 redis 目录可以使用 `CONFIG GET dir`
    - lastsave：上次保存时间
* showlog：显示慢查询
    - 多慢才叫慢 slowlog-log-slower-than 10000，来指定（单位为微秒）
    - 服务器存储多少条慢查询记录 由slowlog-max-len 128，来做限制

### String

* 简单的key-value类型，value可以是String或者数字。其它数据结构也是在字符串的基础上设计的
* 值可以是任何各种类的字符串（包括二进制数据），如：简单的字符串、JSON、XML、二进制等，注意：在 Redis 中字符串类型的值最大只能保存 512 MB
* 例如可以在一个键下保存一副jpeg图片.即可以完全实现目前 Memcached 的功能，并且效率更高。还可以享受Redis的定时持久化，操作日志及 Replication等功能
* 方法
    - 设置 `set key value [EX seconds] [PX milliseconds] [NX|XX]`
        + EX seconds：为键设置秒级过期时间
        + PX milliseconds：为键设置毫秒级过期时间
        + NX：键不存在，才可以设置成功，用于添加
            * 同一个 key 在执行 setnx 命令时，只能成功一次，并且由于 Redis 的单线程命令处理机制，即使多个客户端同时执行 setnx 命令，也只有一个客户端执行成功。
        + XX：键已存在，才可以设置成功，用于更新
            * 多次更新，跟原来值一样？
    - 获取 `get key`
    - 批量设置值  `mset key value [key value]`
    - 批量获取值 `mget key [key1 key2]`,键不存在，值将为 nil,并且返回结果的顺序与传入时相同
    - 对值做自增操作 `incr key`
        + 如果值不是整数，返回错误
        + 如果值是整数，返回自增结果
        + 如果键不存在，创建此键，然后按照值为 0 自增(1)
    - `decr key` 自减
    - `incrby kek increment` 自增指定数字
    - `decrby key decrement` 自减指定数字
    - `incrbyfloat key increment 0.7`
    - `strlen key` 获取字符串长度
        + 每个中文占用 3 个字节
    - `append key value` 往字符串append内容
    - `getset key value` 设置并返回原值
    - `getrange key start end` 获取字符串的某一段内容 O(n) n是字符长度,字符串的下标，左数从0开始，右数从-1开始
        + 当start>length，则返回空字符串
        + 当stop>=length，则截取至字符串尾
        + 如果start所处位置在stop右边，则返回空字符串
    - `setrange key offeset values`
    - 获取指定偏移量上的位 `GETBIT key offset`
    - 设置offset对应二进制上的值，返回该位上的旧值 `setbit key offset value`：如果offset过大，则会在中间填充0,offset最大到多少：2^32-1，即可推出最大的字符串为512M
    - bitop AND|OR|NOT|XOR destkey key1 [key2..] 对key1 key2做opecation并将结果保存在destkey上
    - setex key time value：设置key对应的值value，并设置有效期为time秒
    - MSET key value [key value ...] 批量设置一系列字符串的内容
* 编码：长度不能超过512MB
    - 内部存储默认就是一个字符串，被redisObject所引用，当遇到incr,decr等操作时会转成数值型进行计算，此时redisObject的encoding字段为int
    - int：8个字节的长整型。字符串值是整型时，这个值使用long整型表示，当int数据不再是整数，或大小超过了long的范围时，自动转化为raw。
    - embstr（动态字符串编码）：<=39字节的字符串：redisObject的长度是16字节，sds的长度是9+字符串长度；因此当字符串长度是39时，embstr的长度正好是16+9+39=64，jemalloc正好可以分配64字节的内存单元。
        + 由于其实现是只读的，因此在对embstr对象进行修改时，都会先转化为raw再进行修改，因此，只要是修改embstr对象，修改后的对象一定是raw的，无论是否达到了39个字节
    - raw（优化内存分配的字符串编码）：大于39个字节的字符串
    - embstr与raw都使用redisObject和sds保存数据，区别在于
        + embstr的使用只分配一次内存空间（因此redisObject和sds是连续的）
        + raw需要分配两次内存空间（分别为redisObject和sds分配空间）
        + 因此与raw相比，embstr的好处在于创建时少分配一次空间，删除时少释放一次空间，以及对象的所有数据连在一起，寻找方便。
        + embstr的坏处也很明显，如果字符串的长度增加需要重新分配内存时，整个redisObject和sds都需要重新分配空间，因此redis中的embstr实现为只读。
* 场景
    - 缓存
    - 分布式Session：存储用户token和用户uid `set token user_id`
    - 计数器：投票、计数 `incr vote:1`
    - 限流：对ip开启访问流量限制，假入ip为 211.101.111.111 ， 一秒钟内该ip最多允许访问三次
    - 分布式锁

```sh
exists name # 0
set name henry # OK
setnx name henry # (interger) 0,已存在，无法添加
setnx henry_lee henry # (interger) 1

setex key time value

set name henry_lee xx # OK 更新
set name2 henry_lee xx # (nil) 不存在，无法更新

set counter 100
INCR counter
DECRBY counter 10

# Beijing
setrange city 3 h # Beihing
getrange city 3 4 # hi
object encoding city

incr ip:1517207868
if ( get( ip:1517207868 ) > 3 ) {
    printf " 超过限制了 ";
}
```

### Hash

* 在Memcached中，将一些结构化的信息打包成HashMap
    - 在客户端序列化后存储为一个字符串的值，比如用户的昵称、年龄、性别、积分等，需要修改其中某一项时，通常需要将所有值取出反序列化后，修改某一项的值，再序列化存储回去。这样不仅增大了开销，也不适用于一些可能并发操作的场合（比如两个并发的操作都需要修改积分）,引入CAS等复杂问题。而Redis的Hash结构可以使像在数据库中Update一个属性一样只修改某一项属性值。要存储一个用户信息对象数据:
    - 这个用户信息对象有多少成员就存成多少个key-value对儿，用用户ID+对应属性的名称作为唯一标识来取得对应属性的值，虽然省去了序列化开销和并发问题，但是用户ID为重复存储，如果存在大量这样的数据，内存浪费还是非常可观的
* Redis的Hash实际是内部存储的Value为一个HashMap，并提供了直接存取这个Map成员的接口
    - Key仍然是用户ID, value是一个Map，这个Map的key是成员的属性名，value是属性值，这样对数据的修改和存取都可以直接通过其内部Map的Key(Redis里称内部Map的key为field), 也就是通过 key(用户ID) + field(属性标签) 就可以操作对应属性数据了，既不需要重复存储数据，也不会带来序列化和并发修改控制的问题。
    - Redis提供了接口(hgetall)可以直接取到全部的属性数据,但是如果内部Map的成员很多，那么涉及到遍历整个内部Map的操作，由于Redis单线程模型的缘故，这个遍历操作可能会比较耗时，而另其它客户端的请求完全不响应
* HashMap有2种不同实现
    - 成员比较少时:为了节省内存会采用类似一维数组的方式来紧凑存储，而不会采用真正的HashMap结构，对应的value redisObject的encoding为zipmap
    - 当成员数量增大时会自动转成真正的HashMap,此时encoding为ht
* 方法
    - 判断 field 是否存在 `hexists key field`
    - 设置值 `hset key field value` 有返回值的。如果 hset 命令设置成功，则返回 1，否则返回 0
        + hsetnx:在 field 不存在的时候，才能设置成功
    - 获取值:`hget key field`
    - 删除 field `hdel key field [field ...]`,返回就是成功删除 field 的个数,field 不存在时，并不会报错，而是直接返回 0
    - 计算 field 个数 `hlen key`
    - 批量设置或获取 field-value
        + `hmget key field [field ...]`
        + `hmset key field value [field value ...]` 不存在返回 nil
    - 获取所有 field `hkeys key`
    - 获取所有 value `hvals key`
    - 获取所有的 field-value `hgetall key`
    - 计数:返回操作后结果，step 没有默认值
        + `hincrby key field step`
        + `hincrbyfloat key field step`
    - 计算 value 的字符串长度 `hstrlen key field`,没有 field 则返回 0
    - `setex mall : total : freq : ctrl : 860000000000001 3127 3`
* 编码
    - ziplist（压缩列表）：当哈希类型中元素个数小于 hash-max-ziplist-entries 配置（默认 512 个），同时所有值都小于 hash-max-ziplist-value 配置（默认 64 字节）时
        + 压缩列表用于元素个数少、元素长度小的场景；其优势在于集中存储，节省空间
        + 虽然对于元素的操作复杂度也由O(n)变为了O(1)，但由于哈希中元素数量较少，因此操作的时间并没有明显劣势
    - hashtable（哈希表）：当上述条件不满足时，Redis 则会采用 hashtable 作为哈希的内部实现,由1个dict结构、2个dictht结构、1个dictEntry指针数组（称为bucket）和多个dictEntry结构组成
        + dictEntry结构用于保存键值对，64位系统中，一个dictEntry对象占24字节（key/val/next各占8字节）
            * key：键值对中的键；
            * val：键值对中的值，使用union(即共用体)实现，存储的内容既可能是一个指向值的指针，也可能是64位整型，或无符号64位整型；
            * next：指向下一个dictEntry，用于解决哈希冲突问题
        + dictEntry*是一个数组，数组的每个元素都是指向dictEntry结构的指针。redis中bucket数组的大小计算规则如下：大于dictEntry的、最小的2^n；
            * table属性是一个指针，指向bucket；
            * size属性记录了哈希表的大小，即bucket的大小；
            * used记录了已使用的dictEntry的数量；
            * sizemask属性的值总是为size-1，这个属性和哈希值一起决定一个键在table中存储的位置。
        + dict
            * type属性和privdata属性是为了适应不同类型的键值对，用于创建多态字典
            * ht属性和trehashidx属性则用于rehash，即当哈希表需要扩展或收缩时使用。
            * ht是一个包含两个项的数组，每项都指向一个dictht结构，这也是Redis的哈希会有1个dict、2个dictht结构的原因。
            * 通常情况下，所有的数据都是存在放dict的ht[0]中，ht[1]只在rehash的时候使用。
            * dict进行rehash操作的时候，将ht[0]中的所有数据rehash到ht[1]中。然后将ht[1]赋值给ht[0]，并清空ht[1]。
            * 之所以在dictht和dictEntry结构之外还有一个dict结构，一方面是为了适应不同类型的键值对，另一方面是为了rehash。
        + dictht
* 场景
    - 存储结构化对象数据，构建 NoSQL 数据库
    - 用户信息 用户主页访问量、组合查询
    - 做单点登录的时候，就是用这种数据结构存储用户信息，以CookieId作为Key，设置30分钟为缓存过期时间，能很好地模拟出类似Session的效果

```sh
hexists 2007006018 name
hset 2007006018 name liboming # 1
hsetnx 2007006018 name liboming # 0
hget 2007006018 name # liboming
hdel 20017006018 name city # 0 city 不存在
hmset 2007006018 city Shanghai height 174 wight 68
hmget 2007006018 city name age

hvals 2007006018
hkeys 2007006018
hgetall 2007006018

hincrby 2007006018 height 1
hstrlen 2007006018 name

object encoding 2007006018

# - dictEntry
typedef struct dictEntry{
    void *key;
    union{
        void *val;
        uint64_tu64;
        int64_ts64;
    };
    struct dictEntry *next;
}dictEntry;

# dictEntry*

# dictht
typedef struct dictht{
    dictEntry **table;
    unsigned long size;
    unsigned long sizemask;
    unsigned long used;
}dictht;

# dict
typedef struct dict{
    dictType *type;
    void *privdata;
    dictht ht[2];
    int trehashidx;
} dict;
```

### List

* 用来存储多个有序的字符串，每个字符串称为元素；一个列表可以存储2^32-1个元素
    - 所有的元素都是有序的，可以通过索引获取的，也就是 lindex 命令。索引是从 0 开始的
    - 元素是可以重复
* 实现:一个双向链表，即可以支持反向查找和遍历，更方便操作，不过带来了部分额外的内存开销
* 用数组实现的List和Linked List实现的list，在属性方面大不相同
    - 基于Linked list实现。意味着即使在一个list中有数百万个元素，在头部或尾部添加一个元素的操作，其时间复杂度也是常数级别的。用LPUSH命令在十个元素的list头部添加新元素，和在千万元素的list头部添加新元素的速度相同
    - 用linked list实现的原因：对于数据库系统来说，重要的特性是：能非常快的在很大的列表上添加元素，lists能在常数时间取得常数长度
    - 数组实现的List中利用索引访问元素的速度极快，而同样的操作在linked list实现的list上没有那么快
* 方法
    - 查看元素 `lrange key 0 -1`,没有 rrange
    - 从右边插入元素 `rpush key value [value ...]`, 多个值依次操作,返回key中全部元素个数
    - 从左边插入元素 `lpush key value [value ...]`, 多个值依次操作,返回key中全部元素个数
    - 向某个元素前或者后插入元素 `linsert key BEFORE|AFTER pivot value`,返回key中全部元素个数
    - 插入位置在重复元素第二个的位置？
    - 获取指定范围内的元素列表 `lrange key start stop`
        + 索引下标从左到右分别是 0 到 N-1，从右到左是 -1 到 -N
        + stop 参数在执行时会包括当前元素，并不是所有的语言都是这样的
    - 获取列表中指定索引下标的元素 `lindex key index`
    - 获取列表长度 `llen key`
    - 从列表左侧弹出元素 `lpop key`
    - 从列表右侧弹出元素 `rpop key`
    - 删除指定元素 `lrem key count value`
        + count > 0 表示从左到右，最多删除 count 个值为value元素，返回成功删除元素的个数
        + count < 0：从右到左，最多删除 count 个值为value元素
        + count = 0：删除所有值为value元素
    - 按照索引范围修剪列表 `ltrim key start stop`: 直接保留 start 索引到 stop 索引的之间的元素，并包括当前元素，而之外的元素则都会删除掉,返回改命令是否成功的状态
    - 修改指定索引下标的元素 `lset key index value`
    - 阻塞操作：blpop 和 brpop 命令是 lpop 和 rpop 命令的阻塞版本，可以指定多个列表的键.如果 timeout=3，则表示客户端等待 3 秒后才能返回结果，如果 timeout=0，则表示客户端会一直等待，也就是会阻塞,取消不支持
        + 多个客户端都对同一个键执行 blpop 或者 brpop 命令，则最先执行该命令的客户端会获取到该键的元素。
        + blpop key [key ...] timeout
        + brpop key [key ...] timeout
    - rpoplpush source dest：把source 的末尾拿出，放到dest头部，并返回单元值
* 编码
    - ziplist（压缩列表）
        + 当列表中元素个数小于 512（默认）个，并且列表中每个元素的值都小于 64（默认）个字节时，当然上述默认值也可以通过相关参数修改：list-max-ziplist-entried（元素个数）、list-max-ziplist-value(元素值)。
        + 为了节约内存而开发的，是由一系列特殊编码的连续内存块(而不是像双端链表一样每个节点是指针)组成的顺序型数据结构
        + 与双端链表相比，压缩列表可以节省内存空间，但是进行修改或增删操作时，复杂度较高
        + 因此当节点数量较少时，可以使用压缩列表；但是节点数量多时，还是使用双端链表划算
    - linkedlist（链表）：当列表类型无法满足 ziplist 条件时，会选择用 linkedlist 作为列表的内部实现
        + 由一个list结构和多个listNode结构组成
        + list结构保存了表头指针、列表的长度和表尾指针，dup、free和match为节点值设置类型特定函数
        + 而链表中每个节点指向的是type为字符串的redisObject，每个节点都有指向前和指向后的指针
    - 编码转换
        + 单个字符串不能超过64字节，是为了便于统一分配每个节点的长度；这里的64字节是指字符串的长度，不包括SDS结构，因为压缩列表使用连续、定长内存块存储字符串，不需要SDS结构指明长度
* 场景
    - 消息队列：右侧当作队尾，将左侧当作队头，Rpush 生产消息，LPOP 消费消息
        + LPOP 不会等待队列中有值之后再消费，而是直接进行消费。可以通过在应用层引入 Sleep 机制去调用 LPOP 重试
        + BLPOP key [key …] timeout：阻塞直到队列有消息或者超时
    - 社交网络中获取关注人时间轴列表、帖子、评论系统
    - 新闻的分页列表
    - 并发限制

```sh
LPUSH list1 1 2 3 4 5 # 5 4 3 2 1
RPUSH list1 55 66 77 # 5 4 3 2 1 55 66 77
LRANGE list1 0 3    # 取范围值 1 2 3
LRANGE list1 0 -1    # 取全部

linsert set after 55 new
lrem set 5 new
lrem set -5 new
lrem set 0 new
```

### Set

* 存储一些无序的集合，不能通过索引来操作元素；元素不能重复。其元素是二进制安全的字符串，最多可以存储2^32-1个元素
* 通过哈希表实现（增删改查时间复杂度为 O(1)）
* 适用于集合所有元素都是整数且集合元素数量较小的时候，与哈希表相比，整数集合的优势在于集中存储，节省空间；同时，虽然对于元素的操作复杂度也由O(n)变为了O(1)，但由于集合数量较少，因此操作的时间并没有明显劣势
* set vs list
    - set 中的元素是不可以重复的，而 list 是可以保存重复元素的
    - set 中的元素是无序的，而 list 中的元素是有序的
    - set 中的元素不能通过索引下标获取元素，而 list 中的元素则可以通过索引下标获取元素
    - 除此之外 set 还支持更高级的功能，例如多个 set 取交集、并集、差集等
* 实现:一个 value永远为null的HashMap，实际就是通过计算hash的方式来快速排重的，这也是set能提供判断一个成员是否在集合内的原因
* 方法
    - 获取所有元素 `smembers key`
    - 添加元素:`sadd key member [member ...]` 返回值就是当前执行 sadd 命令成功添加元素的个数
    - 删除元素:`srem key member [member ...]` 返回值就是当前删除元素的个数
    - 计算元素个数:`scard key` 复杂度为O(1) 不会遍历 set 中的所有元素，而是直接使用 Redis 中的内部变量
    - 判读元素是否在集合中 `sismember key member` 复杂度为O(1) 回值为1则表示当前元素在当前 set 中，如果返回 0 则表示当前元素不在 set 中
    - spop key：返回并删除集合中1个随机元素（可以坐抽奖，不会重复抽到某人）
    - smove source dest value：把source的value移动到dest集合中
    - 随机从 set 中返回指定count个数元素 `srandmember key [count]`  复杂度为O(n) 可选参数 count
        + count 参数指的是返回元素的个数，如果当前 set 中的元素个数小于 count，则 srandmember 命令返回当前 set 中的所有元素
        + 如果 count 参数等于 0，则不返回任何数据
        + 如果 count 参数小于 0，则随机返回当前 count 个数的元素
    - 从集合中随机弹出元素 `spop key [count]`,也支持 count 可选参数, 和 srandmember 命令不同。spop 命令在随机弹出元素之后，会将弹出的元素从 set 中删除
    - 集合的交集 `sinter key [key ...]` 复杂度为O(m*k) k是多个集合中元素最少的个数，m是键个数
    - 集合的并集 `sunion key [key ...]` 复杂度为O(K) k是多个元素个数和
    - 集合的差集 `sdiff key [key ...]`
    - 集合的交集、并集、差集的结果保存,在进行上述比较时，会比较耗费时间，所以为了提高性能可以将交集、并集、差集的结果提前保存起来，在需要使用时可以直接通过 smembers 命令获取
        + sinterstore destination key [key ...]
        + sunionstore destination key [key ...]
        + sdiffstore destination key [key ...]
* 编码
    - intset(整数集合)：当集合中的元素都是整数，并且集合中的元素个数小于 512 个时
        + encoding代表contents中存储内容的类型
        + contents（存储集合中的元素）是int8_t类型，但实际上其存储的值是int16_t、int32_t或int64_t，具体的类型便是由encoding决定的；
        + length表示元素个数
    - hashtable(哈希表)：当上述条件不满足时，Redis 会采用 hashtable 作为底层实现。
* 场景
    - 自动去重
    - 标签
    - 粉丝/关注列表
    - 通过交集获取不同用户共同关注用户
    - 好友关系：共同喜好、二度好友
    - 赞、踩

```
SADD myset guan
SMEMBERS myset
SISMEMBER myset guan
spop
sunion

# intset
typedef struct intset{
    uint32_t encoding;
    uint32_t length;
    int8_t contents[];
} intset;
```

### Sorted set

* 可以通过用户额外提供一个优先级(score)的参数来为成员排序，并且是插入有序的，即自动排序
* 实现：内部使用HashMap和跳跃表(SkipList)来保证数据的存储和有序
    - HashMap里放的是成员到score的映射，而跳跃表里存放的是所有的成员
    - 排序依据是HashMap里存的score,使用跳跃表的结构可以获得比较高的查找效率，并且在实现上比较简单
* 方法
    - 添加元素 `zadd key [NX|XX] [CH] [INCR] score member [score member ...]` 返回值就是当前 zadd 命令成功添加元素的个数。zadd 命令有很多选填参数,时间复杂度为O(log(n))
        + nx: 元素必须不存在时，才可以设置成功。
        + xx: 元素必须存在时，才可以设置成功。
        + ch: 返回此命令执行完成后，有序集合元素和分数发生变化的个数
        + incr: 对 score 做增加
    - 成员个数 `zcard key`
    - 某个成员的分数 `zscore key member` 如果 key 不存在，或者元素不存在时，该命令返回的都是(nil)
    - 成员的排名
        + 从分数低到高排名:`zrank key member`
        + 从分数高到低排名:`zrevrank key member`
        + 增加元素分数 也可以指定负数，这样当前元素的分数，则会相减 `zincrby key increment member`
    - 返回指定排名范围的元素,添加了 WITHSCORES 可选参数，则返回数据时会返回当前元素的分数
        + 返回名次[start,stop]的元素  默认是升续排列 `zrange key start stop [WITHSCORES]`
        + `zrevrange key start stop [WITHSCORES]`
    - 返回指定分数范围的元素,可以用 -inf 和 +inf 参数代表无限小和无限大,min 和 max 参数还支持开区间(小括号)和闭区间(中括号 无效)
        + `zrangebyscore key min max [WITHSCORES] [LIMIT offset count]`
        + 集合（升序）排序后取score在[min, max]内的元素，并跳过offset个，取出N个 zrangebyscore key min max [withscores] limit offset N
        + 降序 0名开始 `zrevrangebyscore key max min [WITHSCORES] [LIMIT offset count]`
    - 返回指定分数范围元素个数 `zcount key min max`
    - 删除指定排名内的升序元素 `zremrangebyrank key start stop`
    - 删除指定分数范围元素 `zremrangebyscore key min max`
    - 交集 `zinterstore destination numkeys key [key ...] [WEIGHTS weight] [AGGREGATE SUM|MIN|MAX]`
        + destination：将交集的计算结果，保存到这个键中。
        + numkeys：需要做交集计算键的个数。
        + key [key …]：需要做交集计算的键。
        + WEIGHTS weight：每个键的权重，在做交集计算时，每个键中的分数值都会乘以这个权重，默认每个键的权重为 1。
        + AGGREGATE SUM|MIN|MAX：计算成员交集后，分值可以按照 sum(和)、min(最小值)、max(最大值)做汇总，默认值为  sum
    - 并集 `zunionstore destination numkeys key [key ...] [WEIGHTS weight] [AGGREGATE SUM|MIN|MAX]`
* 编码
    - ziplist(压缩列表)：当有序集合的元素个数小于 128 个(默认设置)，同时每个元素的值都小于 64 字节(默认设置)，Redis 会采用 ziplist 作为有序集合的内部实现。
    - skiplist(跳跃表)：当上述条件不满足时，Redis 会采用 skiplist 作为内部编码
        + 一种有序数据结构，通过在每个节点中维持多个指向其他节点的指针，从而达到快速访问节点的目的。
        + 除了跳跃表，实现有序数据结构的另一种典型实现是平衡树；大多数情况下，跳跃表的效率可以和平衡树媲美，且跳跃表实现比平衡树简单很多，因此redis中选用跳跃表代替平衡树。
        + 跳跃表支持平均O(logN)、最坏O(N)的复杂点进行节点查找，并支持顺序操作。
        + Redis的跳跃表实现由zskiplist和zskiplistNode两个结构组成：前者用于保存跳跃表信息（如头结点、尾节点、长度等），后者用于表示跳跃表节点。
* 场景：排序功能
    - 有序的且不重复的集合列表，比如twitter 的public timeline可以以发表时间作为score来存储，这样获取时就是自动按时间排好序的
    - 带权重的消息队列，比如普通消息的score为1，重要消息的score为2，然后工作线程可以选择按score的倒序来获取工作任务。让重要的任务优先执行
    - 排行榜：取TOP N操作
    - 延时任务
    - 范围查找

```
zadd zsetkey 1 a 2 b 3 c
zrank zsetkey a

zincrby zsetkey 5 a

zrange zsetkey 0 2 WITHSCORES
zrangebyscore zsetkey 4 8 WITHSCORES
zrangebyscore zsetkey -inf  +inf WITHSCORES
zrangebyscore zsetkey (3 6 WITHSCORES # <3 <6

zinterstore destination 2 zsetkey1 zsetkey2 WEIGHTS 1 0.5 AGGREGATE max # key1 权重 1 key2 权重 0.5 ，取大值
```

### 发布（Publish）与订阅（Subscribe）

* 设定对某一个key值进行消息发布及消息订阅，当一个key值上进行了消息发布后，所有订阅它的客户端都会收到相应的消息
* 缺点：消息的发布是无状态的，无法保证可达。对于发布者来说，消息是“即发即失”的
* 场景
    - 实时消息系统，比如普通的即时聊天，群聊等功能

```sh
SUBSCRIBE redisChat
PSUBSCRIBE redisChat # 订阅一个或多个符合给定模式 每个模式以 * 作为匹配符，比如 it* 匹配所有以 it 开头的频道( it.news 、 it.blog 、 it.tweets 等等)。 news.* 匹配所有以 news. 开头的频道

PUBLISH redisChat "Redis is a great caching technique"

PUBSUB CHANNELS # 查看订阅与发布系统状态
PUNSUBSCRIBE mychannel # 退订所有给定模式的频道
```

## HyperLogLog

* 来做基数统计的算法
* 优点：在输入元素的数量或者体积非常非常大时，计算基数所需的空间总是固定 的、并且是很小的
* *每个 HyperLogLog 键只需要花费 12 KB 内存，就可以计算接近 2^64 个不同元素的基数。这和计算基数时，元素越多耗费内存就越多的集合形成鲜明对比。 比如数据集 {1, 3, 5, 7, 5, 7, 8}， 那么这个数据集的基数集为 {1, 3, 5 ,7, 8}, 基数(不重复元素)为5。 基数估计就是在误差可接受的范围内，快速计算基数

```
PFADD runoobkey "redis"

PFCOUNT runoobkey
```

### 管道 Pineline

* 批量执行指令：客户端可以将多个命令一次性发送到服务器，然后由服务器一次性返回所有结果
* 基于请求/响应模型，单个请求处理需要一一应答。如果需要同时执行大量命令，则每条命令都需要等待上一条命令执行完毕后才能继续执行，中间不仅仅多了 RTT，还多次使用了系统 IO
* 批量执行命令的时候可以大大减少网络传输的开销 节省多次 IO 和请求响应往返的时间，提高性能
* 如果指令之间存在依赖关系，则建议分批发送指令
* 在RedisCluster中使用pipeline时必须满足pipeline打包的所有命令key在RedisCluster的同一个slot上

```sh
(echo -en "PING\r\n SET w3ckey redis\r\nGET w3ckey\r\nINCR visitor\r\nINCR visitor\r\nINCR visitor\r\n"; sleep 10) | nc localhost 6379
```

### 事务 Transactions

* 一组命令的集合,命令打包执行的功能
    - multi命令告诉Redis客户端要开始一个事物,然后Redis会返回一个OK，接下来所有的命令Redis都不会立即执行，只会返回QUEUED结果
        + 检测发送multi命令的client是否已经处于事务中，是则直接返回错误。从这里可以看到，Redis不支持事务嵌套执行
        + 给对应client的flags标志位中增加MULTI_CLIENT标志，表示已经进入事务中
        + 返回OK告诉客户端已经成功开启事务
    - exec命令才会去执行之前的所有的命令，事务中任意命令执行失败，其余的命令依然被执行。或者遇到了discard命令，会抛弃执行之前加入事务的命令
    - 在事务执行过程，其他客户端提交的命令请求不会插入到事务执行命令序列中
* 并不是严格的ACID的事务（比如一串用EXEC提交执行的命令，在执行中服务器宕机，那么会有一部分命令执行了，剩下的没执行）
* Watch功能:Redis提供的一个乐观锁
    - 在exec执行之前，监视任意数量的数据库key,在exec命令执行的时候，检测被监视的key是否至少有一个已经被修改，如果是的话，服务器将拒绝执行事务，并向客户端返回代表事务执行失败的空回复
    - exec 过程中，如果这个Watched的值进行了修改，那么这个Transactions会发现并拒绝执行
* pipeline vs multi
    - pipeline 只是把多个redis指令一起发出去（网络上的优化，客户端缓冲一组命令，一次性发送到服务器端执行），并没有保证这些指定的执行是原子的 在同一个事务里面执行
    - multi相当于一个redis的transaction的，保证整个操作的原子性，确保命令执行的时候不会有来自其他客户端的命令插入到命令序列中，避免由于中途出错而导致最后产生的数据不一致
    - pipeline方式执行效率要比其他方式高10倍左右的速度，启用multi写入要比没有开启慢一点

```
MULTI
SET book-name "Mastering C++ in 21 days"
GET book-name
SADD tag "C++" "Programming" "Mastering Series"
SMEMBERS tag
EXEC

Discard # 取消事务，放弃执行事务块内的所有命令

WATCH lock lock_times
UNWATCH
```

## 脚本

* 使用 Lua 解释器来执行脚本，执行脚本的常用命令为 EVAL
* 方法
    - `EVAL script numkeys key [key ...] arg [arg ...]`
        + script 参数是一段 Lua 5.1 脚本程序
        + numkeys： 用于指定键名参数的个数
    - `SCRIPT LOAD script` 将脚本 script 添加到脚本缓存中，但并不立即执行这个脚本
    - `EVALSHA sha1 numkeys key [key ...] arg [arg ...]` 根据给定的 sha1 校验码，执行缓存在服务器中的脚本
        + 根据给定的 sha1 校验码，执行缓存在服务器中的脚本
    - `SCRIPT EXISTS sha1` 命令用于校验指定的脚本是否已经被保存在缓存当中
    - `SCRIPT FLUSH` :清除所有 Lua 脚本缓存
    - `SCRIPT KILL`: 用于杀死当前正在运行的 Lua 脚本，当且仅当这个脚本没有执行过任何写操作时，这个命令才生效,用于终止运行时间过长的脚本

```sh
EVAL "return {KEYS[1],KEYS[2],ARGV[1],ARGV[2]}" 2 key1 key2 first second

EVALSHA "232fd51614574cf0867b83d384a5e898cfd24e5a" 0 "hello moto"
SCRIPT EXISTS 232fd51614574cf0867b83d384a5e898cfd24e5a

SCRIPT LOAD "return 1"
"e0e1f9fabfc9d4800c877a703b823ac0578ff8db"
```

## 锁

* 悲观锁(Pessimistic Lock)：每次去拿数据的时候都认为别人会修改，所以每次在拿数据的时候都会上锁。
    - 场景：如果项目中使用了缓存且对缓存设置了超时时间。
    - 当并发量比较大的时候，如果没有锁机制，那么缓存过期的瞬间，大量并发请求会穿透缓存直接查询数据库，造成雪崩效应。
* 乐观锁(Optimistic Lock), 每次去拿数据的时候都认为别人不会修改，所以不会上锁。
    - watch命令会监视给定的key，当exec时候如果监视的key从调用watch后发生过变化，则整个事务会失败。
    - 也可以调用watch多次监视多个key。这样就可以对指定的key加乐观锁了。
    - 注意watch的key是对整个连接有效的，事务也一样。
    - 如果连接断开，监视和事务都会被自动清除。当然了exec，discard，unwatch命令都会清除连接中的所有监视。
* 分布式锁
    - 控制分布式系统之间同步访问共享资源的一种方式，互斥来防止彼此干扰来保证一致性
        + 互斥性。在任意时刻，只有一个客户端能持有锁
        + 不会发生死锁。即使有一个客户端在持有锁的期间崩溃而没有主动解锁，也能保证后续其他客户端能加锁
        + 容错性。只要大部分的Redis节点正常运行，客户端就可以加锁和解锁
        + 解铃还须系铃人。加锁和解锁必须是同一个客户端，客户端自己不能把别人加的锁给解了
    - 实现
        + 使用 SETNX 实现，`SETNX key value`：如果 Key 不存在，则创建并赋值。时间复杂度为 O(1)，如果设置成功，则返回 1，否则返回 0
            * 因为 SETNX 是长久存在的，所以假设一个客户端正在访问资源，并且上锁，那么当这个客户端结束访问时，该锁依旧存在，后来者也无法成功获取锁，这个该如何解决呢？ 由于 SETNX 并不支持传入 EXPIRE 参数，所以使用 `EXPIRE testlock 0` 指令来对特定的 Key 来设置过期时间

## 分区

* 分片：将每个节点看成都是独立的master，然后通过业务实现数据分片，将每个master设计成由一个master和多个slave组成的模型
* 分割数据到多个Redis实例的处理过程，因此每个实例只保存key的一个子集
* 优势
    - 通过利用多台计算机内存的和值，构造更大的数据库
    - 通过多核和多台计算机，扩展计算与网络带宽
* 缺点
    - 涉及多个key（在不同实例）的操作通常是不被支持的
    - 涉及多个key的redis事务不能使用
    - 数据处理较为复杂
    - 增加或删除容量也比较复杂
* 分区类型
    - 按范围分区：映射一定范围的对象到特定的Redis实例
    - hash分区
        + 用一个hash函数将key转换为一个数字，比如使用crc32 hash函数
        + 对这个整数取模，将其转化为0-3之间的数字，就可以将这个整数映射到4个Redis实例中的一个了

## 主从同步

* 复制过程
    - 从节点执行 slaveof 命令
    - 从节点只是保存了 slaveof 命令中主节点的信息，并没有立即发起复制
    - 从节点内部的定时任务发现有主节点的信息，开始使用 socket 连接主节点
    - 连接建立成功后，发送 ping 命令，希望得到 pong 命令响应，否则会进行重连
    - 如果主节点设置了权限，那么就需要进行权限验证，如果验证失败，复制终止
    - 权限验证通过后，进行数据同步，这是耗时最长的操作，主节点将把所有的数据全部发送给从节点。
        + sync：redis 2.8 之前的同步命令
        + psync：redis 2.8 为了优化 sync 新设计的命令
        + 需要3个组件支持
            * 主从节点各自复制偏移量
                - 参与复制的主从节点都会维护自身的复制偏移量。
                - 主节点在处理完写入命令后，会把命令的字节长度做累加记录，统计信息在 info replication 中的 masterreploffset 指标中。
                - 从节点每秒钟上报自身的的复制偏移量给主节点，因此主节点也会保存从节点的复制偏移量。
                - 从节点在接收到主节点发送的命令后，也会累加自身的偏移量，统计信息在 info replication 中。
                - 通过对比主从节点的复制偏移量，可以判断主从节点数据是否一致。
            * 主节点复制积压缓冲区
                - 复制积压缓冲区是一个保存在主节点的一个固定长度的先进先出的队列，默认大小 1MB。
                - 这个队列在 slave 连接是创建。这时主节点响应写命令时，不但会把命令发送给从节点，也会写入复制缓冲区。
                - 他的作用就是用于部分复制和复制命令丢失的数据补救。通过 info replication 可以看到相关信息。
            * 主节点运行ID
                - 每个 redis 启动的时候，都会生成一个 40 位的运行 ID。
                - 运行 ID 的主要作用是用来识别 Redis 节点。如果使用 ip+port 的方式，那么如果主节点重启修改了 RDB/AOF 数据，从节点再基于偏移量进行复制将是不安全的。所以，当运行 id 变化后，从节点将进行全量复制。也就是说，redis 重启后，默认从节点会进行全量复制。
            * psync{runId}{offset}
                - runId：从节点所复制主节点的运行 id
                - offset：当前从节点已复制的数据偏移量
            * 响应
                - 如果回复 +FULLRESYNC {runId} {offset} ，那么从节点将触发全量复制流程
                - 如果回复 +CONTINUE，从节点将触发部分复制
                - 如果回复 +ERR，说明主节点不支持 2.8 的 psync 命令，将使用 sync 执行全量复制
    - 当主节点把当前的数据同步给从节点后，便完成了复制的建立流程。接下来，主节点就会持续的把写命令发送给从节点，保证主从数据一致性
* 全量复制
    - 从服务器连接主服务器，发送 psync 命令（spync ？-1）
    - 主节点根据命令返回 FULLRESYNC
    - 从节点记录主节点 ID 和 offset
    - 主节点 开始执行BGSAVE命令生成RDB文件并使用缓冲区记录此后执行的所有写命令
    - BGSAVE执行完后，向所有从服务器发送快照文件，并在发送期间继续记录被执行的写命令
    - 从服务器收到快照文件后丢弃所有旧数据，载入收到的快照.如果 RDB 文件很大，这一步操作仍然耗时，如果此时客户端访问，将导致数据不一致，可以使用配置slave-server-stale-data 关闭
    - 主节点在从节点接受数据的期间，将新数据保存到“复制客户端缓冲区”，当从节点加载 RDB 完毕，开始向从服务器发送缓冲区中的写命令。（如果从节点花费时间过长，将导致缓冲区溢出，最后全量同步失败）
    - 从服务器完成对快照的载入，开始接收命令请求，并执行来自主服务器缓冲区的写命令
    - 主服务器每执行一个写命令就会向从服务器发送相同的写命令，从服务器接收并执行收到的写命令
    - 从节点成功加载完 RBD 后，如果开启了 AOF，会立刻做 bgrewriteaof
* 部分复制:主节点只需要将复制缓冲区的数据发送到从节点就能够保证数据的一致性，相比较全量复制，成本小很多
    - 当从节点出现网络中断，超过了 repl-timeout 时间，主节点就会中断复制连接。
    - 主节点会将请求的数据写入到“复制积压缓冲区”，默认 1MB。
    - 当从节点恢复，重新连接上主节点，从节点会将 offset 和主节点 id 发送到主节点。
    - 主节点校验后，如果偏移量的数后的数据在缓冲区中，就发送 cuntinue 响应 —— 表示可以进行部分复制。
    - 主节点将缓冲区的数据发送到从节点，保证主从复制进行正常状态。
* 异步复制：主节点处理完写命令后立即返回客户度，并不等待从节点复制完成
    - 主节点接受处理命令
    - 主节点处理完后返回响应结果
    - 对于修改命令，异步发送给从节点，从节点在主线程中执行复制的命令
* 主从复制：使用一个 Master 节点来进行写操作，而若干个 Slave 节点进行读操作，Master 和 Slave 分别代表了一个个不同的 Redis Server 实例
    - 定期的数据备份操作是单独选择一个 Slave 去完成，可以最大程度发挥 Redis 的性能，为的是保证数据的弱一致性和最终一致性
    - Master 和 Slave 的数据不是一定要即时同步的，但是在一段时间后 Master 和 Slave 的数据是趋于同步的，这就是最终一致性
    - Master会将数据同步到slave，而slave不会将数据同步到master。Slave启动时会连接master来同步数据
    - 全同步过程：
        + Slave 发送 Sync 命令到 Master
        + Master 启动一个后台进程，将 Redis 中的数据快照保存到文件中
        + Master 将保存数据快照期间接收到的写命令缓存起来
        + Master 完成写文件操作后，将该文件发送给 Slave
        + 使用新的 AOF 文件替换掉旧的 AOF 文件
        + Master 将这期间收集的增量写命令发送给 Slave 端
    - 增量同步过程：
        + Master 接收到用户的操作指令，判断是否需要传播到 Slave
        + 将操作记录追加到 AOF 文件
        + 将操作传播到其他 Slave：对齐主从库；往响应缓存写入指令
        + 将缓存中的数据发送给 Slave
    - 心跳：主从节点在建立复制后，之间维护着长连接并彼此发送心跳命令
        + 主从都有心跳检测机制，各自模拟成对方的客户端进行通信，通过 client list 命令查看复制相关客户端信息，主节点的连接状态为 flags = M，从节点的连接状态是 flags = S。
        + 主节点默认每隔 10 秒对从节点发送 ping 命令，可修改配置 repl-ping-slave-period 控制发送频率。
        + 从节点在主线程每隔一秒发送 replconf ack{offset} 命令，给主节点上报自身当前的复制偏移量。
        + 主节点收到 replconf 信息后，判断从节点超时时间，如果超过 repl-timeout 60 秒，则判断节点下线。
* 优点：
    - 主机会自动将数据同步到从机，可以进行读写分离
    - 为了分载Master的读操作压力，Slave服务器可以为客户端提供只读操作的服务，写服务仍然必须由Master来完成
    - Slave同样可以接受其它Slaves的连接和同步请求，这样可以有效的分载Master的同步压力。
    - Master Server是以非阻塞的方式为Slaves提供服务。所以在Master-Slave同步期间，客户端仍然可以提交查询或修改请求。
    - Slave Server同样是以非阻塞的方式完成数据同步。在同步期间，如果有客户端提交查询请求，Redis则返回同步之前的数据
    - 为了避免Master DB的单点故障，集群一般都会采用两台Master DB做双机热备，整个集群的读和写的可用性都非常高
* 注意
    - Master最好不要做任何持久化工作，如RDB内存快照和AOF日志文件
    - 如果数据比较重要，某个Slave开启AOF备份数据，策略设置为每秒同步一次
    - 为了主从复制的速度和连接的稳定性，Master和Slave最好在同一个局域网内
    - 尽量避免在压力很大的主库上增加从库
    - 主从复制不要用图状结构，用单向链表结构更为稳定，即：Master <- Slave1 <- Slave2 <- Slave3... 这样的结构方便解决单点故障问题，实现Slave对Master的替换。如果Master挂了，可以立刻启用Slave1做Master，其他不变。
* 缺点：
    - Redis不具备自动容错和恢复功能，主机从机的宕机都会导致前端部分读写请求失败，需要等待机器重启或者手动切换前端的IP才能恢复。
    - 主机宕机，宕机前有部分数据未能及时同步到从机，切换IP后还会引入数据不一致的问题，降低了系统的可用性。
    - Redis较难支持在线扩容，在集群容量达到上限时在线扩容会变得很复杂。
    - 不管是Master还是Slave，每个节点都必须保存完整的数据，如果在数据量很大的情况下，集群的扩展能力还是受限于单个节点的存储能力，而且对于Write-intensive类型的应用，读写分离架构并不适合

## Redis Sentinel（哨兵）

* 主从模式弊端：当 Master 宕机后，Redis 集群将不能对外提供写入操作。Redis Sentinel 可解决这一问题,主节点奔溃之后，无需人工干预就能自动恢复 Redis 的正常使用
* 2.8中提供了哨兵工具来实现自动化的系统监控和故障恢复功能。作用就是监控Redis系统的运行状况。功能：
    - 监控主服务器和从服务器是否正常运行
    - 主服务器出现故障时自动将从服务器转换为主服务器
* 解决主从同步 Master 宕机后的主从切换问题：
    - 监控：检查主从服务器是否运行正常。
    - 提醒：通过 API 向管理员或者其它应用程序发送故障通知。
    - 自动故障迁移：主从切换（在 Master 宕机后，将其中一个 Slave 转为 Master，其他的 Slave 从该节点同步数据）。
* 由若干 Sentinel 节点组成的分布式集群，可以实现故障发现、故障自动转移、配置中心和客户端通知。Redis Sentinel 的节点数量要满足 2n+1(n>=1)的奇数个
* 工作方式
    - 每个Sentinel（哨兵）进程以每秒钟一次的频率向整个集群中的Master主服务器，Slave从服务器以及其他Sentinel（哨兵）进程发送一个 PING 命令。
    - 如果一个实例（instance）距离最后一次有效回复 PING 命令的时间超过 down-after-milliseconds 选项所指定的值， 则这个实例会被 Sentinel（哨兵）进程标记为主观下线（SDOWN）
    - 如果一个Master主服务器被标记为主观下线（SDOWN），则正在监视这个Master主服务器的所有 Sentinel（哨兵）进程要以每秒一次的频率确认Master主服务器的确进入了主观下线状态
    - 当有足够数量的 Sentinel（哨兵）进程（大于等于配置文件指定的值）在指定的时间范围内确认Master主服务器进入了主观下线状态（SDOWN）， 则Master主服务器会被标记为客观下线（ODOWN）
    - 在一般情况下， 每个 Sentinel（哨兵）进程会以每 10 秒一次的频率向集群中的所有Master主服务器、Slave从服务器发送 INFO 命令。
    - 当Master主服务器被 Sentinel（哨兵）进程标记为客观下线（ODOWN）时，Sentinel（哨兵）进程向下线的 Master主服务器的所有 Slave从服务器发送 INFO 命令的频率会从 10 秒一次改为每秒一次。
    - 若没有足够数量的 Sentinel（哨兵）进程同意 Master主服务器下线， Master主服务器的客观下线状态就会被移除。若 Master主服务器重新向 Sentinel（哨兵）进程发送 PING 命令返回有效回复，Master主服务器的主观下线状态就会被移除。
* 优点：
    - 哨兵模式是基于主从模式的，所有主从的优点，都具有
    - 主从可以自动切换，系统更健壮，可用性更高
    - 方便实现 Redis 数据节点的线形扩展，轻松突破 Redis 自身单线程瓶颈，可极大满足 Redis 大容量或高性能的业务需求
* 缺点：
    - 较难支持在线扩容，在集群容量达到上限时在线扩容会变得很复杂

## Redis 集群 redis-cluster

* Redis 3.0 正式推出的，Redis 集群是通过将数据库分散存储到多个节点上来平衡各个节点的负载压力
* 由多个主从节点群组成的分布式服务器群，具有复制、高可用和分片特性
* 特点
    - 所有的redis节点彼此互联(PING-PONG机制),内部使用二进制协议优化传输速度和带宽
    - 节点的fail是通过集群中超过半数的节点检测失效时才生效
    - 客户端与redis节点直连,不需要中间代理层.客户端不需要连接集群所有节点,连接集群中任何一个可用节点即可
    - 采用虚拟哈希槽分区，所有的键根据哈希函数映射到 0 ~ 16383 整数槽内，计算公式：slot = CRC16(key) & 16383，每一个节点负责维护一部分槽以及槽所映射的键值数据。这样 Redis 就可以把读写压力从一台服务器，分散给多台服务器了，因此性能会有很大的提升
* 分片：按照某种规则去划分数据，分散存储在多个节点上。通过将数据分到多个 Redis 服务器上，来减轻单个 Redis 服务器的压力
* 一致性 Hash 算法： 既然要将数据进行分片，那么通常的做法就是获取节点的 Hash 值，然后根据节点数求模
    - 有明显的弊端，当 Redis 节点数需要动态增加或减少的时候，会造成大量的 Key 无法被命中。所以 Redis 中引入了一致性 Hash 算法
    - 该算法对 2^32 取模，将 Hash 值空间组成虚拟的圆环，整个圆环按顺时针方向组织，每个节点依次为 0、1、2…2^32-1
    - 之后将每个服务器进行 Hash 运算，确定服务器在这个 Hash 环上的地址，确定了服务器地址后，对数据使用同样的 Hash 算法，将数据定位到特定的 Redis 服务器上
    - 如果定位到的地方没有 Redis 服务器实例，则继续顺时针寻找，找到的第一台服务器即该数据最终的服务器位置
    - Hash 环的数据倾斜问题：Hash 环在服务器节点很少的时候，容易遇到服务器节点不均匀的问题，这会造成数据倾斜，数据倾斜指的是被缓存的对象大部分集中在 Redis 集群的其中一台或几台服务器上
    - 引入虚拟节点解决。简单地说，就是为每一个服务器节点计算多个 Hash，每个计算结果位置都放置一个此服务器节点，称为虚拟节点，可以在服务器 IP 或者主机名后放置一个编号实现
* 工作方式：
    - 在redis的每一个节点上，都有这么两个东西，一个是插槽（slot），它的的取值范围是：0-16383。还有一个就是cluster，可以理解为是一个集群管理的插件。当存取的key到达的时候，redis会根据crc16的算法得出一个结果，然后把结果对 16384 求余数，这样每个 key 都会对应一个编号在 0-16383 之间的哈希槽，通过这个值，去找到对应的插槽所对应的节点，然后直接自动跳转到这个对应的节点上进行存取操作
    - 为了保证高可用，redis-cluster集群引入了主从模式，一个主节点对应一个或者多个从节点，当主节点宕机的时候，就会启用从节点。当其它主节点ping一个主节点A时，如果半数以上的主节点与A通信超时，那么认为主节点A宕机了。如果主节点A和它的从节点A1都宕机了，那么该集群就无法再提供服务了
* 需要至少三个节点（因为领导者选举需要至少一半加1个节点，奇数个节点可以在满足该条件的基础上节省一个节点):建三个主节点，每个主节点下面在提供一个从节点，共6个 redis 节点
* `CLUSTER INFO` 集群信息
    + cluster_state：集群的状态。ok表示集群是成功的，如果至少有一个solt坏了，就将处于error状态。
    + cluster_slots_assigned：有多少槽点被分配了，如果是16384，表示全部槽点已被分配。
    + cluster_slots_ok：多少槽点状态是OK的, 16384 表示都是好的。
    + cluster_slots_pfail：多少槽点处于暂时疑似下线[PFAIL]状态，这些槽点疑似出现故障，但并不表示是有问题，也会继续提供服务。
    + cluster_slots_fail：多少槽点处于暂时下线[FAIL]状态，这些槽点已经出现故障，下线了。等待修复解决。
    + cluster_known_nodes：已知节点的集群中的总数，包括在节点 握手的状态可能不是目前该集群的成员。这里总公有9个。
    + cluster_size：(The number of master nodes serving at least one hash slot in the cluster) 简单说就是集群中主节点［Master］的数量。
    + cluster_current_epoch：本地当前时期变量。这是使用，以创造独特的不断增加的版本号过程中失败接管
    + cluster_my_epoch：这是分配给该节点的当前配置版本
    + cluster_stats_messages_sent：通过群集节点到节点的二进制总线发送的消息数
    + cluster_stats_messages_received：通过群集节点到节点的二进制总线上接收报文的数量
* CLUSTER NODES 列出集群当前已知的所有节点（node），以及这些节点的相关信息。
* CLUSTER MEET <ip> <port> 将 ip 和 port 所指定的节点添加到集群当中，让它成为集群的一份子。
* CLUSTER FORGET <node_id> 从集群中移除 node_id 指定的节点。
* CLUSTER REPLICATE <node_id> 将当前节点设置为 node_id 指定的节点的从节点。
* CLUSTER SAVECONFIG 将节点的配置文件保存到硬盘里面。
* CLUSTER ADDSLOTS <slot> [slot ...] 将一个或多个槽（slot）指派（assign）给当前节点。
* CLUSTER DELSLOTS <slot> [slot ...] 移除一个或多个槽对当前节点的指派。
* CLUSTER FLUSHSLOTS 移除指派给当前节点的所有槽，让当前节点变成一个没有指派任何槽的节点。
* CLUSTER SETSLOT <slot> NODE <node_id> 将槽 slot 指派给 node_id 指定的节点。
* CLUSTER SETSLOT <slot> MIGRATING <node_id> 将本节点的槽 slot 迁移到 node_id 指定的节点中。
* CLUSTER SETSLOT <slot> IMPORTING <node_id> 从 node_id 指定的节点中导入槽 slot 到本节点。
* CLUSTER SETSLOT <slot> STABLE 取消对槽 slot 的导入（import）或者迁移（migrate）
* CLUSTER KEYSLOT <key> 计算键 key 应该被放置在哪个槽上。
* CLUSTER COUNTKEYSINSLOT <slot> 返回槽 slot 目前包含的键值对数量。
* CLUSTER GETKEYSINSLOT <slot> <count> 返回 count 个 slot 槽中的键。
* CLUSTER SLAVES node-id 返回一个master节点的slaves 列表
* hashtag

```
# redis.conf
aemonize yes
port 8001 #（分别对每个机器的端口号进行设置）
dir /usr/local/redis-cluster/8001/ #（指定数据文件存放位置，必须要指定不同的目录位置，不然会丢失数据）
cluster-enabled yes #（启动集群模式）
cluster-config-file nodes-8001.conf #（集群节点信息文件，这里800x最好和port对应上）
cluster-node-timeout 5000

bind 127.0.0.1 #（去掉bind绑定访问ip信息）

protected-mode no  #（关闭保护模式）
appendonly yes

redis-server /usr/local/redis-cluster/800*/redis.conf

./redis-trib.rb create --replicas 1 127.0.0.1:7000 127.0.0.1:7001 \
127.0.0.1:7002 127.0.0.1:7003 127.0.0.1:7004 127.0.0.1:7005

/usr/local/redis/redis-5.0.2/src/redis-cli -a xxx --cluster create --cluster-replicas 1 192.168.5.100:8001 192.168.5.100:8002 192.168.5.100:8003 192.168.5.100:8004 192.168.5.100:8005 192.168.5.100:8006
/usr/local/redis/src/redis-cli -a xxx -c -h 192.168.0.60 -p 8001 shutdown # 逐个进行关闭
```

## 场景

* 删除与过滤:用LREM来删除评论 或者 为每个不同的过滤器使用不同的Redis列表。毕竟每个列表只有5000条项目，但Redis却能够使用非常少的内存来处理几百万条项目。
* 按照用户投票和时间排序:`score = points / time^alpha`.每次新的新闻贴上来后，将ID添加到列表中，使用LPUSH + LTRIM，确保只取出最新的1000条项目。有一项后台任务获取这个列表，并且持续的计算这1000条新闻中每条新闻的最终得分。计算结果由ZADD命令按照新的顺序填充生成列表，老新闻则被清除。这里的关键思路是排序工作是由后台任务来完成的。
* 当服务器处在高并发操作的时候，比如频繁地写入日志文件。可以利用消息队列实现异步处理。从而实现高性能的并发操作
* 实时分析正在发生的情况，用于数据统计与防止垃圾邮件等
* 特定时间内的特定项目：统计在某段特点时间里有多少特定用户访问了某个特定资源

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

* 在内存中提供服务
* 对比
    - 数据类型丰富：memcached 只支持以 key-value 形式访问存取数据，在内存中维护一张巨大的哈希表，从而保证所有查询的时间复杂度是 O(1)；redis 则支持除 key-value 之外的其他数据类型，比如 list、set、hash、zset 等，用来实现队列、有序集合等更复杂的功能；
    - 性能：memcached  支持多线程，可以利用多核优势，不过也引入了锁，redis 是单线程，在操作大数据方面，memcached 更有优势，处理小数据的时候，redis 更优；
    - 数据磁盘持久化存储：redis 支持数据同步和持久化存储，memcached 不支持，意味着一旦机器重启所有存储数据将会丢失；
    - 数据一致性：memcached 提供了 cas 命令来保证，而 redis 提供了事务的功能，可以保证一串命令的原子性，中间不会被任何操作打断
    - 支持分片
    - 分布式：memcached 本身不支持分布式存储，只能在客户端通过一致性哈希算法实现，属于客户端实现；redis 更倾向于在服务端构建分布式存储，并且 redis 本身就对此提供了支持，即 redis cluster。
* redis
    - Redis最佳试用场景是*全部数据in-memory*
    - 丰富数据结构:当需要除key/value之外的更多数据类型支持时，使用Redis更合适。用户订单列表，用户消息，帖子评论列表
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
* memcache：纯KV，数据量非常大，并发量非常大的业务，或许更适合
    - 内存分配:memcache使用预分配内存池的方式管理内存，能够省去内存分配时间。redis则是临时申请空间，可能导致碎片。
    - 虚拟内存使用:memcache把所有的数据存储在物理内存里。redis有自己的VM机制，理论上能够存储比物理内存更多的数据，当数据超量时，会引发swap，把冷数据刷到磁盘上。
    - 网络模型:memcache使用非阻塞IO复用模型，redis也是使用非阻塞IO复用模型。但由于redis还提供一些非KV存储之外的排序，聚合功能，在执行这些功能时，复杂的CPU计算，会阻塞整个IO调度。
    - 线程模型:memcache使用多线程，主线程监听，worker子线程接受请求，执行读写，这个过程中，可能存在锁冲突。redis使用单线程，虽无锁冲突，但难以利用多核的特性提升整体吞吐量。
    - memcached 服务端并没有提供对分布式的支持，构建 memcached 分布式缓存需要借助客户端来实现，通常两种方式，一种是取模算法，一种是一致性哈希算法。
    - 所谓取模算法指的是将 key 转化为32位数字（一般通过md5即可实现），然后与memcached 缓存服务器总数进行取模运算，得到的余数就是对应的服务器节点，然后我们把对应的 key/value 保存到这个服务器节点，获取缓存的时候也是先取模，然后访问对应的服务器节点获取对应的 value。这种方式的优点是比较简单，适用于缓存总容量变动不大的小型分布式系统，缺点也很明显，那就是一旦缓存服务器扩容，部分缓存获取算法失效导致无法命中，而且原来机器越多，影响越大，瞬间会给数据库服务器带来巨大压力，甚至造成雪崩效应，也就不能做到动态扩容，此外，如果某台 memcached 服务器宕机，摘除该节点也一样存在这样的问题。
    - 一致性哈希算法就是针对取模算法的缺点进行优化，先构造一个长度为0~2^32（2的32次幂）的整数环（也叫做一致性Hash环），根据节点名称的Hash值将缓存服务器节点放置在这个Hash环中，如node1、node2等；根据需要缓存数据的 key 值计算得到其 Hash 值；在Hash 环上顺时针查找距离这个 key 的 Hash 值最近的缓存服务器节点，完成 key 到服务器的 Hash 映射查找。当缓存服务器集群需要扩容的时候，只需要将新加入节点名称的 Hash 值放入一致性 Hash 环中，由于key 总是顺时针查找距离其最近的节点，因此新加入的节点只影响整个环中的一小部分。
    - 我们来具体量化以下，比如原来有三台 memcached 服务器，新增一台机器，采用取模算法，缓存命中率变成25%，而使用一致性哈希算法，缓存命中率是75%，再极端一些，如果原来有100台机器，新增1台机器，采用取模算法，缓存命中率变成1%，而使用一致性哈希算法，缓存命中率仍然高达99%，所以相较之下，一致性算法显然更加时候大型系统，可以实现动态扩容/缩容，而相对的，也更加复杂，实现成本更高。
    - memcache 和 memcached 的区别主要是前者是基于 php 开发的，后者是基于 c 语言通过 libmemcached 与 memcached 服务器通信，因此性能更好（由于需要事先安装 libmemcached，因此 Windows 下不支持），并且支持的功能特性也更多，推荐使用后者

## 持久化

* 持久化：将数据持久存储，而不因断电或其他各种复杂外部环境影响数据的完整性
* RDB（Redis DataBase，快照方式）：将某一个时刻的内存数据，以二进制的方式写入磁盘
    - 定时触发
        + 根据 redis.conf 配置里的 SAVE m n 定时触发（实际上使用的是 BGSAVE）
        + 主从复制时，主节点自动触发
        + 执行 Debug Reload
        + 执行 Shutdown 且没有开启 AOF 持久化
    - `save` 手动触发，阻塞 Redis 的服务器进程，直到 RDB 文件被创建完毕，不会再响应客户端的其余任何请求
    - BGSAVE:主进程会fork出一个子进程来做快照持久化，而主进程可以继续相应客户端的任何请求
        + fork() 在 Linux 中创建子进程采用 Copy-On-Write（写时拷贝技术），即如果有多个调用者同时要求相同资源（如内存或磁盘上的数据存储）。 他们会共同获取相同的指针指向相同的资源，直到某个调用者试图修改资源的内容时，系统才会真正复制一份专用副本给调用者，而其他调用者所见到的最初的资源仍然保持不变
    - 缺点：
        + 内存数据全量同步，数据量大的状况下，会由于 I/O 而严重影响性能
        + 导致一定时间内的数据丢失:可能会因为 Redis 宕机而丢失从当前至最近一次快照期间的数据
* AOF（Append Only File，文件追加方式）：类似于mysql的二进制日志方案,默认是关闭的.需要修改配置文件中的 appendonly no 为 appendonly yes
    - 通过保存 Redis 的写状态来记录数据库的，文件中记录除了查询以外的所有变更数据库状态的指令，并不记录数据本身
    - 将命令以增量文本的形式追加保存到 AOF 文件中（fsync），是子线程来做的，主线程依然用来处理客户端的请求。
    - 同步策略，通过 CONFIG GET appendfsync 查看当前配置
        + appendfsync always，即时将缓冲区内容写入 AOF 文件当中，最低效最安全
        + appendfsync everysec，每隔一秒将缓冲区内容写入 AOF 文件（默认）
        + appendfsync no，不执行 fysnc 调用，让操作系统自动操作把缓存数据写到硬盘上，不可靠但最快。操作系统考虑效率问题，会等待缓冲区被填满再将缓冲区数据写入 AOF 文件中
    - 重写 rewrite 机制：手动或者自动重写，压缩 AOF 文件
        + 时间久了，AOF 文件会越来越大
        + 假如连续set了10000次，但是最后key又删除了，aof文件会记录20000条命令
        + 过程：
                * 调用 fork()，创建一个子进程
                * 子进程把新的 AOF 写到一个临时文件里，不依赖原来的 AOF 文件
                * 主进程持续将新的变动同时写到内存和原来的 AOF 里
                * 主进程获取子进程重写 AOF 的完成信号，往新 AOF 同步增量变动
                * 使用新的 AOF 文件替换掉旧的 AOF 文件
        + auto-aof-rewrite-percentage 和 auto-aof-rewrite-min-size。当 AOF 文件超过 auto-aof-rewrite-min-size 时，且超过上次重写后的大小百分之 auto-aof-rewrite-percentage 时，会触发自动重写
    - 缺点
        + 由于文件较大则会影响 Redis 的启动速度
* 对比
    - RDB 优点：全量数据快照，文件小，恢复快。
    - RDB 缺点：无法保存最近一次快照之后的数据。
    - AOF 优点：可读性高，适合保存增量数据，数据不易丢失。
    - AOF 缺点：文件体积大，恢复时间长。
    - rdb恢复速度快，aof恢复速度相对要慢一些。
    - 如果aof开启了，那么redis在启动时会选择根据aof文件恢复数据而不是rdb，所以一定要保存好rdb文件
    - rdb和aof可以同时开启，最大可能地保证数据完整性。如果redis中的数据都是缓存类数据，可以考虑只选择一样即可
    - 检测修复rdb文件的工具叫做redis-check-rdb，检测修复aof文件的工具叫做redis-check-aof
    - 如果你有1G的redis数据，那么理论上讲做一次bgsave操作最大需要2G内存，但实际上得益于Copy-On-Write（写时拷贝，COW机制），并不一定会需要2G内存，只有在当主进程将所有的key全部修改过的情况下，才会需要2G内存。
    - 建议redis内存使用量在30%-50%之间，超过50%这个限制就要留心注意下了
* RDB-AOF 混合持久化方式：4.0 之后推出了此种持久化方式，RDB 作为全量备份，AOF 作为增量备份，并且将此种方式作为默认方式使用
    - 写入的时候，先把当前的数据以 RDB 的形式写入文件的开头
    - 再将写入后新增的数据以 AOF 的方式追加在 RDB 数据的后面
    - 在下一次做 RDB 持久化的时候将 AOF 的数据重新以 RDB 的形式写入文件
    - 既可以提高读写和恢复效率，也可以减少文件大小，同时可以保证数据的完整性
    - 子进程会通过管道从父进程读取增量数据，在以 RDB 格式保存全量数据时，也会通过管道读取数据，同时不会造成管道阻塞
    - 前半段是 RDB 格式的全量数据，后半段是 AOF 格式的增量数据
    - 查询是否开启混合持久化可以使用 config get aof-use-rdb-preamble 命令。yes 表示已经开启混合持久化，no 表示关闭，Redis 5.0 默认值为 yes。如果是其他版本的 Redis 首先需要检查一下
    - 使用命令 `config set aof-use-rdb-preamble yes`
    - redis.conf 文件，把配置文件中的 aof-use-rdb-preamble no 改为 aof-use-rdb-preamble yes
* 数据恢复：Redis 启动时会先检查 AOF 是否存在，如果 AOF 存在则直接加载 AOF，如果不存在 AOF，则直接加载 RDB 文件

```
# redis.conf
# RDB
save 900 1 #在900s内如果有1条数据被写入，则产生一次快照
save 300 10 #在300s内如果有10条数据被写入，则产生一次快照
save 60 10000 #在60s内如果有10000条数据被写入，则产生一次快照

stop-writes-on-bgsave-error yes // 如果bgsave遇到错误时停止写入，为了保护持久化的数据一致性的问题
rdbcompression yes // 开启rdb文件压缩，可以有效减少rdb文件的体积。开启压缩需要付出的代价自然就是cpu点数了，如果你为了节省cpu资源，可以关闭压缩
rdbchecksum yes // 开启crc64校验可以让rdb文件具备更好的完整性，但是也是需要cpu点数的，可以选择关闭
dbfilename dump.rdb // rdb文件的名字
dir /var/lib/redis // redis的工作目录，上面的rdb文件就会保存在redis的工作目录中

# AOF
appendonly no // 是否开启aof
appendfilename "appendonly.aof" // aof文件名称
appendfsync everysec // fsync时间间隔
no-appendfsync-on-rewrite no // 当子进程在对aof文件进行rewrite的时候暂停主进程对fsync的append操作，避免产生冲突。因为aof的时候，是子进程来做的，此时如果主进程来append新的指令了，两个进程同时操作一个文件会产生冲突，所以此时主进程要append的指令会被缓存到内容中，当子进程rewrite完成后会向主进程发送一个信号来通知rewrite已完成，然后主进程再将放到内存中的append指令追加到aof文件尾部
auto-aof-rewrite-percentage 100 // 触发aof文件rewrite的条件 当前aof文件大小超过上次aof文件体积100%后，才会启动rewrite
auto-aof-rewrie-min-size 64mb // 开启rewrite的aof文件最小体积，也就说只有当aof文件超过了64mb后，才会可能产生rewrite。用程序语言表达就是 只有当aof文件体积大于64mb并且当前aof文件体积比上次变化超过了100% 才会产生rewrite。如果aof文件体积小于64mb，那么即便文件变化率超过了100%，也不会发生rewrite。
aof-load-truncated yes // 忽略aof文件中错误的不完整的日志，如果该选项为no，那么redis会加载aof失败。损坏的aof文件可以尝试用redis-check-aof来修复
aof-user-rdb-preamble no // 这是redis 4.0出现的新特性，集成了rdb和aof的优点的一个产物。在aof rewrite的时候还是要全量读取一次所有的数据，然后rewrite期间缓存下的命令。既然都要全量读取一次了，为何不在这次全量读取的时候就索性以rdb格式写入到文件呢？然后再追加rewrite期间产生的新aof指令。这样，数据不仅恢复快，还能保证数据完整性。默认情况下，该选项处于关闭状态。
```

## 缓存

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
* 失效
    - 主动过期: Redis对数据是惰性过期，当一个key到了过期时间，Redis也不会马上清理，但如果这个key过期后被再次访问，Redis就会主动将它清理掉。
    - 被动过期: 如果过期的Key一直没被访问，Redis也不会一直把它放那不管，它会每秒10次(默认配置)的执行以下的清理工作：
        + 随机从所有带有过期时间的Key里取出20个
        + 如果发现有过期的，就清理
        + 如果这里有25%的Key都是过期的，就继续回到第一步再来一次
        + 同时会判断这20个里过期Key的清理时间，是否超过25% CPU时间(默认25ms)，如果超过了，也不会再继续清理，这个可以保证Redis的CPU不会被占用过长的时间
* 缓存失效及内存淘汰机制
    - 定时删除：用一个定时器来负责监视Key，过期则自动删除。虽然内存及时释放，但是十分消耗CPU资源。在大并发请求下，CPU要将时间应用在处理请求，而不是删除Key，因此没有采用这一策略。Redis默认每个100ms检查是否有过期的Key，有过期Key则删除。需要说明的是，Redis不是每个100ms将所有的Key检查一次，而是随机抽取进行检查（如果每隔100ms，全部Key进行检查，Redis岂不是卡死）。因此，如果只采用定期删除策略，会导致很多Key到时间没有删除。
    - 惰性删除：在你获取某个Key的时候，Redis会检查一下，这个Key如果设置了过期时间，那么是否过期了？如果过期了此时就会删除。
    - 回收策略：通过配置文件
        + Noeviction（默认）：当内存不足以容纳新写入数据时，新写入操作会报错
        + Allkeys-lru：当内存不足以容纳新写入数据时，在键空间中，移除最久未使用的Key，推荐使用
        + Allkeys-random：当内存不足以容纳新写入数据时，在键空间中，随机淘汰任意键值
        + Volatile-lru：当内存不足以容纳新写入数据时，在设置了过期时间的键空间中，移除最近最少使用的Key。这种情况一般是把Redis既当缓存又做持久化存储的时候才用。不推荐；
        + Volatile-random：当内存不足以容纳新写入数据时，在设置了过期时间的键空间中，随机移除某个Key
        + Volatile-ttl：当内存不足以容纳新写入数据时，在设置了过期时间的键空间中优先淘汰更早过期的键值
        + volatile-lfu：淘汰所有设置了过期时间的键值中，最少使用的键值，Redis 4.0 版本中新增
        + allkeys-lfu：淘汰整个键值中最少使用的键值，Redis 4.0 版本中新增
        + 如果没有设置Expire的Key，不满足先决条件（Prerequisites）；那么Volatile-lru、Volatile-random和Volatile-ttl策略的行为，和Noeviction（不删除）基本上一致。

```
maxmemory-policy volatile-lru
```

## 长连接

* `pconnect(host, port, time_out, persistent_id, retry_interval)`:表示客户端闲置多少秒后，就断开连接。函数连接成功返回true，失败返回false
    - 连接不会在调用close方法之后关闭，只有在进程结束之后该连接才会被关闭。close的作用仅是使当前php不能再进行redis请求。只会在PHP-FPM进程结束之后结束，连接的生命周期就是PHP-FPM进程的生命周期
    - 相比较短连接而言，在每一个PHP-FPM调用过程中都会产生一个redis的连接，在服务器上的表性形式就是过多的time_out连接状态
    - 长连接的话，PHP-FPM调用的所有CGI都只会共用一个长连接，所以也就是只会产生固定数量的time_out
    - 参数
        + host: string. can be a host, or the path to a unix domain socket
        + port: int, optional
        + timeout: float, value in seconds (optional, default is 0 meaning unlimited)
        + persistent_id: string. identity for the requested persistent connection
        + retry_interval: int, value in milliseconds (optional)

## 慢查询

* 慢查询本身只记录了命令执行时间，不包括数据网络传输时间和命令排队时间
* `slowlog get {n}`  命令可以获取最近的 n 条慢查询命令
* slowlog的输出格式
    - 第一个字段表示该条记录在所有慢日志中的序号，最新的记录被展示在最前面
    - 第二个字段是这条记录被记录时的系统时间，可以用 date 命令来将其转换为友好的格式
    - 第三个字段表示这条命令的响应时间，单位为 us (微秒)
    - 第四个字段为对应的 Redis 操作
* 不合理的命令或者数据结构:数据量比较大且命令算法复杂度是 O(n) `redis-cli-h host -p 12345 --bigkeys` 发现大对象的工具
* 持久化阻塞
    - fork 阻塞:产生共享内存的子进程(内存占用量表现为与父进程相同), Linux 具有写时复制技术 (copy-on-write)，父子进程会共享相同的物理内存页，当父进程处理写请求时会对需要修改的页复制出一份副本完成写操作，而子进程依然读取 fork 时整个父进程的内存快照
    - AOF刷盘阻塞

```
# 超过 slowlog-log-slower-than 阈值的命令都会被记录到慢查询队列中

# 队列最大长度为 slowlog-max-len

slowlog-log-slower-than 10000
slowlog-max-len 128
```

## 性能

* 参数
    - -h  指定服务器主机名    127.0.0.1
    - -p  指定服务器端口 6379
    - -s  指定服务器 socket
    - -c  指定并发连接数 50
    - -n  指定请求数   10000
    - -d  以字节的形式指定 SET/GET 值的数据大小 2
    - -k  1=keep alive 0=reconnect    1
    - -r  SET/GET/INCR 使用随机 key, SADD 使用随机值
    - -P  通过管道传输 <numreq> 请求  1
    + -q  强制退出 redis。仅显示 query/sec 值
    +  --csv   以 CSV 格式输出
    +  -l  生成循环，永久执行测试
    +  -t  仅运行以逗号分隔的测试命令列表
    +  -I  Idle 模式。仅打开 N 个 idle 连接并等待。

```sh
redis-benchmark -h host -p port -k 0 -t get -n 100000  -c 8000
```

## 规范

* 键值设计:缩短键值对的存储长度，键值对的长度是和性能成反比的。在 key 不变的情况下，value 值越大操作效率越慢，因为 Redis 对于同一种数据类型会使用不同的内部编码进行存储，数据量越大使用的内部编码就越复杂，而越是复杂的内部编码存储的性能就越低
    - key 名设计:属于无 scheme 的 KV 数据库，靠约定来建立其 scheme 语义
        + 可读性和可管理性：带以下维度：业务、key 用途、变量等，各个维度使用 : 进行分隔， AppID:KeyName
        + 不要包含特殊字符
        + 能够根据某类 key 进行数据清理或者数据更新
        + 能够方便了解到某类 key 的归属方和应用场景
        + 为统一化、平台化做准备，减少技术变更
    - value 设计
        + 拒绝 bigkey(防止网卡流量、慢查询)：string 类型控制在 10KB 以内，hash、list、set、zset 元素个数不要超过 5000。
        + 非字符串的 bigkey，不要使用 del 删除，使用 hscan、sscan、zscan 方式渐进式删除，同时要注意防止 bigkey 过期时间自动删除问题 (例如一个 200 万的 zset 设置 1 小时过期，会触发 del 操作，造成阻塞，而且该操作不会不出现在慢查询中 (latency 可查))
        + 选择适合的数据类型。合理控制和使用数据结构内存编码优化配置，也要注意节省内存和性能之间的平衡
        + 控制 key 的生命周期：设置过期时间 (条件允许可以打散过期时间，防止集中过期)，不过期的数据重点关注 idletime
    - 内容较大时，还会带来另外几个问题：
        + 持久化时间就越长，需要挂起的时间越长，Redis 的性能就会越低
        + 网络上传输的内容就越多，需要的时间就越长，整体的运行速度就越低
        + 占用的内存就越多，就会更频繁的触发内存淘汰机制，从而给 Redis 带来了更多的运行负担
    - 必要时要对数据进行序列化和压缩再存储，以 Java 为例，序列化可以使用 protostuff 或 kryo，压缩可以使用 snappy
* 客户端使用
    - 避免多个应用使用一个 Redis 实例：不相干的业务拆分，公共数据做服务化
    - 使用带有连接池的数据库，可以有效控制连接，同时提高效率
    - 高并发下建议客户端添加熔断功能 (例如 netflix hystrix)
    - 设置合理的密码，如有必要可以使用 SSL 加密访问
* 规范
    - 冷热数据区分 虽然 Redis支持持久化，但将所有数据存储在 Redis 中，成本非常昂贵。建议将热数据 (如 QPS超过 5k) 的数据加载到 Redis 中。低频数据可存储在 Mysql、 ElasticSearch中。
    - 业务数据分离 不要将不相关的数据业务都放到一个 Redis中。一方面避免业务相互影响，另一方面避免单实例膨胀，并能在故障时降低影响面，快速恢复
    - 消息大小限制 由于 Redis 是单线程服务，消息过大会阻塞并拖慢其他操作。保持消息内容在 1KB 以下是个好的习惯。严禁超过 50KB 的单条记录。消息过大还会引起网络带宽的高占用，持久化到磁盘时的 IO 问题。
    - 连接数限制 连接的频繁创建和销毁，会浪费大量的系统资源，极限情况会造成宿主机当机。请确保使用了正确的 Redis 客户端连接池配置。
    - 缓存 Key 设置失效时间 作为缓存使用的 Key，必须要设置失效时间。失效时间并不是越长越好，请根据业务性质进行设置。注意，失效时间的单位有的是秒，有的是毫秒，这个很多同学不注意容易搞错。
    - 缓存不能有中间态 缓存应该仅作缓存用，去掉后业务逻辑不应发生改变，万不可切入到业务里。第一，缓存的高可用会影响业务；第二，产生深耦合会发生无法预料的效果；第三，会对维护行产生肤效果。
    - 扩展方式首选客户端 hash：如单 redis 集群并不能为你的数据服务，不要着急扩大你的 redis 集群（包括 M/S 和 Cluster)，集群越大，在状态同步和持久化方面的性能越差。 优先使用客户端 hash 进行集群拆分。如：根据用户 id 分 10 个集群，用户尾号为 0 的落在第一个集群。
* 操作限制
    - 严禁作为消息队列使用 如没有非常特殊的需求，严禁将 Redis 当作消息队列使用。Redis 当作消息队列使用，会有容量、网络、效率、功能方面的多种问题。如需要消息队列，可使用高吞吐的 Kafka 或者高可靠的 RocketMQ。
    - 严禁不设置范围的批量操作 redis 那么快，慢查询除了网络延迟，就属于这些批量操作函数。大多数线上问题都是由于这些函数引起。
        + [zset] 严禁对 zset 的不设范围操作 ZRANGE、 ZRANGEBYSCORE等多个操作 ZSET 的函数，严禁使用 ZRANGE myzset 0 -1 等这种不设置范围的操作。请指定范围，如 ZRANGE myzset 0 100。如不确定长度，可使用 ZCARD 判断长度
        + [hash] 严禁对大数据量 Key 使用 HGETALL HGETALL会取出相关 HASH 的所有数据，如果数据条数过大，同样会引起阻塞，请确保业务可控。如不确定长度，可使用 HLEN 先判断长度
        + [key] Redis Cluster 集群的 mget 操作 Redis Cluster 的 MGET 操作，会到各分片取数据聚合，相比传统的 M/S架构，性能会下降很多，请提前压测和评估
        + [其他] 严禁使用 sunion, sinter, sdiff等一些聚合操作
    - 禁用 select 函数 select函数用来切换 database，对于使用方来说，这是很容易发生问题的地方，cluster 模式也不支持多个 database，且没有任何收益，禁用
    - 禁用事务 redis 本身已经很快了，如无大的必要，建议捕获异常进行回滚，不要使用事务函数，很少有人这么干。
    - 禁用 lua 脚本扩展 lua 脚本虽然能做很多看起来很 cool 的事情，但它就像是 SQL 的存储过程，会引入性能和一些难以维护的问题，禁用。
    - 禁止长时间 monitor monitor函数可以快速看到当前 redis 正在执行的数据流，但是当心，高峰期长时间阻塞在 monitor 命令上，会严重影响 redis 的性能。此命令不禁止使用，但使用一定要特别特别注意。
* 使用 lazy free（延迟删除）特性
    - Redis 4.0 新增的一个非常使用的功能，它可以理解为惰性删除或延迟删除
    - 在删除的时候提供异步延时释放键值的功能，把键值释放操作放在 BIO(Background I/O) 单独的子线程处理中，以减少删除删除对 Redis 主线程的阻塞，可以有效地避免删除 big key 时带来的性能和可用性问题
    - 对应了 4 种场景，默认都是关闭的：
        + lazyfree-lazy-eviction no 表示当 Redis 运行内存超过 maxmeory 时，是否开启 lazy free 机制删除
        + lazyfree-lazy-expire no 表示设置了过期时间的键值，当过期之后是否开启 lazy free 机制删除
        + lazyfree-lazy-server-del no 有些指令在处理已存在的键时，会带有一个隐式的 del 键的操作，比如 rename 命令，当目标键已存在，Redis 会先删除目标键，如果这些目标键是一个 big key，就会造成阻塞删除的问题，此配置表示在这种场景中是否开启 lazy free 机制删除
        + slave-lazy-flush no 针对 slave(从节点) 进行全量数据同步，slave 在加载 master 的 RDB 文件前，会运行 flushall 来清理自己的数据，它表示此时是否开启 lazy free 机制删除
    - 建议开启其中的 lazyfree-lazy-eviction、lazyfree-lazy-expire、lazyfree-lazy-server-del 等配置，这样就可以有效的提高主线程的执行效率
* 设置键值的过期时间：根据自身业务类型，选好 maxmemory-policy(最大内存淘汰策略)，设置好过期时间。自动清除过期的键值对，以节约对内存的占用，以避免键值过多的堆积，频繁的触发内存淘汰策略
* 禁用长耗时的查询命令：绝大多数读写命令的时间复杂度都在 O(1) 到 O(N) 之间，O(1) 表示可以安全使用的，而 O(N) 就应该当心了，N 表示不确定，数据越大查询的速度可能会越慢，。因为 Redis 只用一个线程来做数据查询，如果这些指令耗时很长，就会阻塞 Redis，造成大量延时
    - O(N) 命令关注 N 的数量：例如 hgetall、lrange、smembers、zrange、sinter 等并非不能使用，但是需要明确 N 的值。有遍历的需求可以使用 hscan、sscan、zscan 代替
    - 禁止使用 keys 命令：效率极低，属于 O(N)操作，会阻塞其他正常命令，在 cluster 上，会是灾难性的操作。严禁使用，DBA 应该 rename 此命令，从根源禁用
    - 禁止线上使用 flushall、flushdb 等
    - 避免一次查询所有的成员：使用 scan 命令进行分批的，游标式的遍历
    - 通过机制严格控制 Hash、Set、Sorted Set 等结构的数据大小
    - 将排序、并集、交集等操作放在客户端执行，以减少 Redis 服务器运行压力
    - 删除 (del) 一个大数据的时候，可能会需要很长时间，所以建议用异步删除的方式 unlink，会启动一个新的线程来删除目标数据，而不阻塞 Redis 的主线程
    - 合理使用 select：redis 的多数据库较弱，使用数字进行区分，很多客户端支持较差，同时多业务用多数据库实际还是单线程处理，会有干扰
    - 使用批量操作（pipeline）提高效率：控制一次批量操作的元素个数(例如 500 以内，实际也和元素字节数有关)
        + 原生是原子操作，pipeline 是非原子操作。
        + pipeline 可以打包不同的命令，原生做不到
        + pipeline 需要客户端和服务端同时支持。
    - 事务功能较弱(不支持回滚)，不建议过多使用。集群版本 (自研和官方) 要求一次事务操作的 key 必须在一个 slot 上 (可以使用 hashtag 功能解决)
    - 集群版本在使用 Lua 上有特殊要求：
        + 所有 key 都应该由 KEYS 数组来传递，redis.call/pcall 里面调用的 redis 命令，key 的位置，必须是 KEYS array, 否则直接返回 error，"-ERR bad lua script for redis cluster, all the keys that the script uses should be passed using the KEYS array"
        + 所有 key，必须在 1 个 slot 上，否则直接返回 error, “-ERR eval/evalsha command keys must in same slot”
    - 必要情况下使用 monitor 命令时，要注意不要长时间使用
* 使用 slowlog 优化耗时命令：slowlog 功能找出最耗时的 Redis 命令进行相关的优化，慢查询有两个重要的配置项
    - slowlog-log-slower-than ：用于设置慢查询的评定时间，也就是说超过此配置项的命令，将会被当成慢操作记录在慢查询日志中，它执行单位是微秒 (1 秒等于 1000000 微秒)
    - slowlog-max-len ：用来配置慢查询日志的最大记录数
    - 按照插入的顺序倒序存入慢查询日志中，我们可以使用 slowlog get n 来获取相关的慢查询日志，再找到这些慢查询对应的业务进行相关的优化
* 使用 Pipeline 批量操作数据
* 避免大量数据同时失效：过期键值删除使用的是贪心策略，它每秒会进行 10 次过期扫描，此配置可在 redis.conf 进行配置，默认值是 hz 10，Redis 会随机抽取 20 个值，删除这 20 个键中过期的键，如果过期 key 的比例超过 25% ，重复执行此流程
    - 有大量缓存在同一时间同时过期，那么会导致 Redis 循环多次持续扫描删除过期字典，直到过期字典中过期键值被删除的比较稀疏为止，而在整个执行过程会导致 Redis 的读写出现明显的卡顿
    - 卡顿的另一种原因是内存管理器需要频繁回收内存页，因此也会消耗一定的 CPU
* 客户端使用优化
    - 尽量使用 Pipeline 的技术外
    - 尽量使用 Redis 连接池，而不是频繁创建销毁 Redis 连接，可以有效控制连接，同时提高效率，减少网络传输次数和减少了非必要调用指令
* 限制 Redis 内存大小
    - 64 位操作系统中 Redis 的内存大小是没有限制的，也就是配置项 maxmemory <bytes> 是被注释掉的，这样就会导致在物理内存不足时，使用 swap 空间既交换空间，而当操心系统将 Redis 所用的内存分页移至 swap 空间时，将会阻塞 Redis 进程，导致 Redis 出现延迟，从而影响 Redis 的整体性能
    - 需要限制 Redis 的内存大小为一个固定的值，当 Redis 的运行到达此值时会触发内存淘汰策略，内存淘汰策略在 Redis 4.0 之后有 8 种
* 使用物理机而非虚拟机安装 Redis 服务 `./redis-cli --intrinsic-latency 100` 命令查看延迟时间
* 检查数据持久化策略
* 禁用 THP 特性
    - Linux kernel 在 2.6.38 内核增加了 Transparent Huge Pages (THP) 特性 ，支持大内存页 2MB 分配，默认开启
    - 开启了 THP 时，fork 的速度会变慢，fork 之后每个内存页从原来 4KB 变为 2MB，会大幅增加重写期间父进程内存消耗。同时每次写命令引起的复制内存页单位放大了 512 倍，会拖慢写操作的执行时间，导致大量写操作慢查询。
    - 禁用:`echo never >  /sys/kernel/mm/transparent_hugepage/enabled`
    - 重启后 THP 配置依然生效 在 /etc/rc.local 中追加`echo never > /sys/kernel/mm/transparent_hugepage/enabled`
* 使用分布式架构来增加读写速度
    - 有三个重要的手段： 主从同步 哨兵模式 Redis Cluster 集群
    - 这三个功能中，只需要使用一个就行了，毫无疑问 Redis Cluster 应该是首选的实现方案，它可以把读写压力自动的分担给更多的服务器，并且拥有自动容灾的能力

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

user:sex 用户 10002232 的性别
msg:achi 201712 的用户发言数量排行榜

# /etc/redis/redis.conf
rename-command FLUSHDB ""
rename-command FLUSHALL ""
rename-command DEBUG ""
rename-command SHUTDOWN SHUTDOWN_MENOT
rename-command CONFIG ASC12_CONFIG
```

## 注意

* 根据需求合理的评估Redis的内存使用量，选择合适的机器配置，可以在满足需求的情况下节约成本
* 了解Redis内存模型可以选择更合适的数据类型和编码，更好的利用Redis内存
* 当Redis出现阻塞、内存占用等问题时，尽快发现导致问题的原因，便于分析解决问题
* Master写内存快照，save命令调度rdbSave函数，会阻塞主线程的工作，当快照比较大时对性能影响是非常大的，会间断性暂停服务，所以Master最好不要写内存快照。
* Master AOF持久化，如果不重写AOF文件，这个持久化方式对性能的影响是最小的，但是AOF文件会不断增大，AOF文件过大会影响Master重启的恢复速度。Master最好不要做任何持久化工作，包括内存快照和AOF日志文件，特别是不要启用内存快照做持久化,如果数据比较关键，某个Slave开启AOF备份数据，策略为每秒同步一次。
* Master调用BGREWRITEAOF重写AOF文件，AOF在重写的时候会占大量的CPU和内存资源，导致服务load过高，出现短暂服务暂停现象。
* Redis主从复制的性能问题，为了主从复制的速度和连接的稳定性，Slave和Master最好在同一个局域网内

## 面试

* 操作redis用到的是什么插件
* 使用的序列化方式
* 使用redis遇到过给印象较深的问题
* 所了解的几个http head头并描述其用途
* 如果前端提交成功，后端无法接受数据，这时候将如何排查问题
* 如果服务器返回cookie，存储在响应内容里面head头的字段叫做什么
* 当服务端返回Transer-Encoding：chunked 代表什么含义
* 是否了解分段加载并描述下其技术流程

## 图书

* [《Redis设计与实现》](http://redisbook.com/) <https://redisbook.readthedocs.io/en/latest/index.html>
* Redis 4.X Cookbook

## [rdr](https://github.com/xueqiu/rdr)

解析 redis rdbfile 工具。与redis-rdb-tools相比，RDR 是由golang 实现的，速度更快（5GB rdbfile 在我的PC上大约需要2分钟）

* 参数
    - show 网页显示 rdbfile 的统计信息
    - keys 从 rdbfile 获取所有 key
    - help 帮助
    - --version 显示版本信息

```sh
# Linux amd64
wget https://github.com/xueqiu/rdr/releases/download/v0.0.1/rdr-linux -O /usr/local/bin/rdr
chmod +x /usr/local/bin/rdr

# MacOS
curl https://github.com/xueqiu/rdr/releases/download/v0.0.1/rdr-darwin -o /usr/local/bin/rdr
chmod +x /usr/local/bin/rdr

# Windows 浏览器下载下面链接，在点击运行
https://github.com/xueqiu/rdr/releases/download/v0.0.1/rdr-windows.exe

./rdr show -p 8080 *.rdb
# 分析多个 Redis rdb
rdr keys FILE1 [FILE2] [FILE3]...
```

## 工具

* 客户端
    - [Redis Desktop Manager](https://github.com/uglide/RedisDesktopManager):🔧 Cross-platform GUI management tool for Redis http://redisdesktop.com
    - [luin/medis](https://github.com/luin/medis):💻 Medis is a beautiful, easy-to-use Mac database management application for Redis. http://getmedis.com
    - [mylxsw/redis-tui](https://github.com/mylxsw/redis-tui):A Redis Text-based UI client in CLI
* [sripathikrishnan/redis-rdb-tools](https://github.com/sripathikrishnan/redis-rdb-tools):Parse Redis dump.rdb files, Analyze Memory, and Export Data to JSON
* [twitter/twemproxy](https://github.com/twitter/twemproxy):A fast, light-weight proxy for memcached and redis
* [CodisLabs/codis](https://github.com/CodisLabs/codis):Proxy based Redis cluster solution supporting pipeline and scaling dynamically
* [erikdubbelboer/phpRedisAdmin](https://github.com/erikdubbelboer/phpRedisAdmin):Simple web interface to manage Redis databases. http://dubbelboer.com/phpRedisAdmin/
* [phpredis/phpredis](https://github.com/phpredis/phpredis):A PHP extension for Redis
* [redis-port](link):redis 间数据同步
* [laixintao / iredis](https://github.com/laixintao/iredis):Interactive Redis: A Terminal Client for Redis with AutoCompletion and Syntax Highlighting. https://iredis.io/show
* [redis-faina](https://github.com/facebookarchive/redis-faina):热点 key 寻找 (内部实现使用 monitor，所以建议短时间使用)
* Jedis
    - [Jedis 常见异常汇总](https://yq.aliyun.com/articles/236384)
    - [JedisPool 资源池优化](https://yq.aliyun.com/articles/236383)
* [KeyDB](link):从redis fork出来的分支,兼容redis API的情况下将redis改造成多线程

## 参考

* [Redis面试全攻略](https://mp.weixin.qq.com/s?__biz=MzI1MzYzMTI2Ng==&mid=2247484439&idx=1&sn=2b1199ccb150c99b4efea45e2a5f49d5&chksm=e9d0ca5adea7434cb5f525a53fe258180fe70a48c649cc2939bcc5a71d9e786c224a84ab5558)
