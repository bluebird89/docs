# [antirez/redis](https://github.com/antirez/redis)

Redis is an in-memory database that persists on disk. The data model is key-value, but many different kind of values are supported: Strings, Lists, Sets, Sorted Sets, Hashes, HyperLogLogs, Bitmaps. http://redis.io

## 原理

* 一个Key-Value类型的内存数据库，很像memcached，整个数据库统统加载在内存当中进行操作，定期通过异步操作把数据库数据flush到硬盘上进行保存
* 丰富的数据结构，支持二进制的String，List，Hash，Set及Ordered Set等数据类型操作
* 性能：纯内存操作，单线程操作，避免了线程切换和锁的性能消耗，10万次读写操作
    - 为了达到最快的读写速度将数据都读到内存中，并通过异步的方式将数据写入磁盘
    - 利用队列技术将并发访问变为串行访问，消除了传统数据库串行控制的开销
    - 单线程简化数据结构和算法的实现
* 单个value的最大限制是1GB，不像 memcached只能保存1MB的数据
* 缓存：在碰到需要执行耗时特别久、且结果不频繁变动的SQL时，就特别适合将运行结果放入缓存。后面的请求就去缓存中读取，使得请求能够迅速响应
* 并发：让请求先访问到Redis，而不是直接访问数据库
* 一种基于客户端-服务端模型以及请求/响应协议的TCP服务。这意味着通常情况下一个请求会遵循以下步骤：
    - 客户端向服务端发送一个查询请求，并监听Socket返回，通常是以阻塞模式，等待服务端响应。
    - 服务端处理命令，并将结果返回给客户端。
* 采用了非阻塞I/O多路复用机制，单线程根据Socket的不同状态执行每个Socket(I/O流)：任务
    - 用epoll作为IO多路复用技术的实现，再加上redis自身事件处理模型将epoll中的链接、读写、关闭都转换为事件，不在网络IO上浪费过多的事件
* 提供了Select、Epoll、Evport、Kqueue等多路复用函数库
* 内部使用一个redisObject对象来表示所有的key和value,redisObject最主要的信息
    - type代表一个value对象具体是何种数据类型
    - encoding是不同数据类型在redis内部的存储方式
* 虚拟内存：直接自己构建了VM 机制 ，因为一般的系统调用系统函数的话，会浪费一定的时间去移动和请求
    - key很小而value很大时,使用VM的效果会比较好.因为这样节约的内存比较大
    - key不小时,可以考虑使用一些非常方法将很大的key变成很大的value,比如可以考虑将key,value组合成一个新的value
    - vm-max-threads参数,可以设置访问swap文件的线程数,设置最好不要超过机器的核数,如果设置为0,那么所有对swap文件的操作都是串行的.可能会造成比较长时间的延迟,但是对数据完整性有很好的保证
    - vm字段，只有打开了Redis的虚拟内存功能，此字段才会真正的分配内存
* 原子操作：对数据的更改要么全部执行，要么全部不执行
* 发布/订阅
* 支持Lua脚本
* 分布式：主从复制与高可用（Redis Sentinel）
    - Master会将数据同步到slave，而slave不会将数据同步到master。Slave启动时会连接master来同步数据
    - 利用master来插入数据，slave提供检索服务
* 读写分离模型：通过增加Slave DB的数量，读的性能可以线性增长
    - 为了避免Master DB的单点故障，集群一般都会采用两台Master DB做双机热备，所以整个集群的读和写的可用性都非常高
    - 缺陷在于，不管是Master还是Slave，每个节点都必须保存完整的数据，如果在数据量很大的情况下，集群的扩展能力还是受限于单个节点的存储能力，而且对于Write-intensive类型的应用，读写分离架构并不适合
    - 注意
        + Master最好不要做任何持久化工作，如RDB内存快照和AOF日志文件
        + 如果数据比较重要，某个Slave开启AOF备份数据，策略设置为每秒同步一次
        + 为了主从复制的速度和连接的稳定性，Master和Slave最好在同一个局域网内
        + 尽量避免在压力很大的主库上增加从库
        + 主从复制不要用图状结构，用单向链表结构更为稳定，即：Master <- Slave1 <- Slave2 <- Slave3... 这样的结构方便解决单点故障问题，实现Slave对Master的替换。如果Master挂了，可以立刻启用Slave1做Master，其他不变。
* 持久化（RDB与AOF）,Redis 重启后数据不丢失
* 数据分片模型：将每个节点看成都是独立的master，然后通过业务实现数据分片，将每个master设计成由一个master和多个slave组成的模型
* 管道：Redis管道是指客户端可以将多个命令一次性发送到服务器，然后由服务器一次性返回所有结果。管道技术在批量执行命令的时候可以大大减少网络传输的开销，提高性能。
* 事务：Redis事务是一组命令的集合。一个事务中的命令要么都执行，要么都不执行。如果命令在运行期间出现错误，不会自动回滚。管道与事务的区别：管道主要是网络上的优化，客户端缓冲一组命令，一次性发送到服务器端执行，但是并不能保证命令是在同一个事务里面执行；而事务是原子性的，可以确保命令执行的时候不会有来自其他客户端的命令插入到命令序列中。
* 分布式锁：分布式锁是控制分布式系统之间同步访问共享资源的一种方式。在分布式系统中，常常需要协调他们的动作，如果不同的系统或是同一个系统的不同主机之间共享了一个或一组资源，那么访问这些资源的时候，往往需要互斥来防止彼此干扰来保证一致性，在这种情况下，便需要使用到分布式锁。
* 地理信息：从Redis 3.2版本开始，新增了地理信息相关的命令，可以将用户给定的地理位置信息（经纬度）存储起来，并对这些信息进行操作。
* 缺点：数据库容量受到物理内存的限制，不能用作海量数据的高性能读写，因此Redis适合的场景主要局限在较小数据量的高性能操作和运算上。

## 安装

* redis-server：redis服务器的daemon启动程序
* redis-cli：Redis命令操作工具。当然，也可以telnet根据其纯文本协助来操作
* redis-benchmark：Redis性能测试工具，测试系统Redis读写性能
* redis-check-aof：更新日志检查
* redis-check-dump：用于本地数据库检查

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
openssl rand 60 | openssl base64 -A # 生产密码

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
CLIENT LIST 返回连接到 redis 服务的客户端列表
CLIENT SETNAME  设置当前连接的名称
CLIENT GETNAME  获取通过 CLIENT SETNAME 命令设置的服务名称
CLIENT PAUSE    挂起客户端连接，指定挂起的时间以毫秒计
CLIENT KILL 关闭客户端连接
```

## 内存

* 内存统计: info memeory
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
            * buf表示字节数组，用来存储字符串； buf数组的长度=free+len+1 buf 数组的长度=free+len+1,长度为9
            * len表示buf已使用的长度
            * free表示buf未使用的长度
            * SDS与C字符串的比较：加入了free和len字段，带来了很多好处
                - 获取字符串长度：SDS是O(1)，C字符串是O(n)
                - 缓冲区溢出：使用C字符串的API时，如果字符串长度增加（如strcat操作）而忘记重新分配内存，很容易造成缓冲区的溢出；而SDS由于记录了长度，相应的API在可能造成缓冲区溢出时会自动重新分配内存，杜绝了缓冲区溢出。
                - 修改字符串时内存的重分配：对于C字符串，如果要修改字符串，必须要重新分配内存（先释放再申请），因为如果没有重新分配，字符串长度增大时会造成内存缓冲区溢出，字符串长度减小时会造成内存泄露。而对于SDS，由于可以记录len和free，因此解除了字符串长度和空间数组长度之间的关联，可以在此基础上进行优化：空间预分配策略（即分配内存时比实际需要的多）使得字符串长度增大时重新分配内存的概率大大减小；惰性空间释放策略使得字符串长度减小时重新分配内存的概率大大减小。
                - 存取二进制数据：SDS可以，C字符串不可以。因为C字符串以空字符作为字符串结束的标识，而对于一些二进制文件（如图片等），内容可能包括空字符串，因此C字符串无法正确存取；而SDS以字符串长度len来作为字符串结束标识，因此没有这个问题。
* 编码：每种结构都有至少两种编码；这样做的好处在于：
    - 接口与实现分离，当需要增加或改变内部编码时，用户使用不受影响
    - 可以根据不同的应用场景切换内部编码，提高效率

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

## 通用

* KEYS pattern：模糊查询key，通配符  *、?、[]
    - `keys user_token*`:遍历算法，复杂度是O(n),导致 Redis 服务卡顿，因为Redis 是单线程程序，顺序执行所有指令，其它指令必须等到当前的 keys 指令执行完了才可以继续
    - 遍历大数据量用 `SCAN cursor [MATCH pattern] [COUNT count]`
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

## 数据类型

Redis 没有像 MySQL 这类关系型数据库那样强大的查询功能，需要考虑如何把关系型数据库中的数据，合理的对应到缓存的 key-value 数据结构中。

### String

* 简单的key-value类型，value可以是String或者数字。其它数据结构也是在字符串的基础上设计的
* 值可以是任何各种类的字符串（包括二进制数据），如：简单的字符串、JSON、XML、二进制等，但有一点要特别注意：在 Redis 中字符串类型的值最大只能保存 512 MB。
* 例如你可以在一个键下保存一副jpeg图片.即可以完全实现目前 Memcached 的功能，并且效率更高。还可以享受Redis的定时持久化，操作日志及 Replication等功能
* 方法
    - 设置值:`set key value [EX seconds] [PX milliseconds] [NX|XX]`,有几个非必须的选项
        + EX seconds：为键设置秒级过期时间
        + PX milliseconds：为键设置毫秒级过期时间
        + NX：键必须不存在，才可以设置成功，用于添加
            * 同一个 key 在执行 setnx 命令时，只能成功一次，并且由于 Redis 的单线程命令处理机制，即使多个客户端同时执行 setnx 命令，也只有一个客户端执行成功。
            * 基于 setnx 这种特性，setnx 命令可以作为分布式锁的一种解决方案
        + XX：键必须存在，才可以设置成功，用于更新
            * 多次更新，跟原来值一样？
    - 获取值 `get key`
    - GETBIT key offset 对 key 所储存的字符串值，获取指定偏移量上的位
    - 批量设置值: `mset key value [key value]`
    - 批量获取值:`mget key [key1 key2]`,键不存在，那么它的值将为 nil,并且返回结果的顺序与传入时相同
    - incr 命令用于对值做自增操作，返回的结果分为 3 种情况:
        + 如果值不是整数，那么返回的一定是错误
        + 如果值是整数，那么返回自增后的结果
        + 如果键不存在，那么就会创建此键，然后按照值为 0 自增， 就是返回 1
    - decr key 自减
    - incrby kek increment 自增指定数字
    - decrby key decrement 自减指定数字
    - incrbyfloat key increment 0.7
    - `strlen key` 获取字符串长度
        + 每个中文占用 3 个字节
    - `append key value` 往字符串append内容
    - `getset key value` 设置并返回原值
    - 获取字符串的某一段内容 `getrange key start end` O(n) n是字符长度,字符串的下标，左数从0开始，右数从-1开始
        + 当start>length，则返回空字符串
        + 当stop>=length，则截取至字符串尾
        + 如果start所处位置在stop右边，则返回空字符串
    - `setrange key offeset values` 设置及获取字符串的某一位（bit）
    - setbit key offset value：设置offset对应二进制上的值，返回该位上的旧值。 如果offset过大，则会在中间填充0,offset最大到多少：2^32-1，即可推出最大的字符串为512M
    - bitop AND|OR|NOT|XOR destkey key1 [key2..] 对key1 key2做opecation并将结果保存在destkey上
    - setex key time value：设置key对应的值value，并设置有效期为time秒
    - MSET key value [key value ...] 批量设置一系列字符串的内容
* 编码：长度不能超过512MB
    - int：8个字节的长整型。字符串值是整型时，这个值使用long整型表示，当int数据不再是整数，或大小超过了long的范围时，自动转化为raw。
    - embstr：<=39字节的字符串：redisObject的长度是16字节，sds的长度是9+字符串长度；因此当字符串长度是39时，embstr的长度正好是16+9+39=64，jemalloc正好可以分配64字节的内存单元。
        + 由于其实现是只读的，因此在对embstr对象进行修改时，都会先转化为raw再进行修改，因此，只要是修改embstr对象，修改后的对象一定是raw的，无论是否达到了39个字节
    - raw：大于39个字节的字符串
    - embstr与raw都使用redisObject和sds保存数据，区别在于
        + embstr的使用只分配一次内存空间（因此redisObject和sds是连续的）
        + raw需要分配两次内存空间（分别为redisObject和sds分配空间）
        + 因此与raw相比，embstr的好处在于创建时少分配一次空间，删除时少释放一次空间，以及对象的所有数据连在一起，寻找方便。
        + embstr的坏处也很明显，如果字符串的长度增加需要重新分配内存时，整个redisObject和sds都需要重新分配空间，因此redis中的embstr实现为只读。
* 场景
    - 存储用户token和用户uid `set token user_id`
    - 投票 `incr vote:1`
    - 流量访问限制
        + 对ip开启访问流量限制，假入ip为 211.101.111.111 ， 一秒钟内该ip最多允许访问三次
    - 复杂的计数功能的缓存
    - 计数器

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
    - 在客户端序列化后存储为一个字符串的值，比如用户的昵称、年龄、性别、积分等，需要修改其中某一项时，通常需要将所有值取出反序列化后，修改某一项的值，再序列化存储回去。这样不仅增大了开销，也不适用于一些可能并发操作的场合（比如两个并发的操作都需要修改积分）,引入CAS等复杂问题。而Redis的Hash结构可以使你像在数据库中Update一个属性一样只修改某一项属性值。要存储一个用户信息对象数据:
    - 这个用户信息对象有多少成员就存成多少个key-value对儿，用用户ID+对应属性的名称作为唯一标识来取得对应属性的值，虽然省去了序列化开销和并发问题，但是用户ID为重复存储，如果存在大量这样的数据，内存浪费还是非常可观的。
* Redis的Hash实际是内部存储的Value为一个HashMap，并提供了直接存取这个Map成员的接口
    - Key仍然是用户ID, value是一个Map，这个Map的key是成员的属性名，value是属性值，这样对数据的修改和存取都可以直接通过其内部Map的Key(Redis里称内部Map的key为field), 也就是通过 key(用户ID) + field(属性标签) 就可以操作对应属性数据了，既不需要重复存储数据，也不会带来序列化和并发修改控制的问题。
    - Redis提供了接口(hgetall)可以直接取到全部的属性数据,但是如果内部Map的成员很多，那么涉及到遍历整个内部Map的操作，由于Redis单线程模型的缘故，这个遍历操作可能会比较耗时，而另其它客户端的请求完全不响应
* HashMap，实际这里会有2种不同实现
    - 这个Hash的成员比较少时Redis为了节省内存会采用类似一维数组的方式来紧凑存储，而不会采用真正的HashMap结构，对应的value redisObject的encoding为zipmap
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
    - 用户信息
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
    - 列表中所有的元素都是有序的，所以可以通过索引获取的，也就是 lindex 命令。索引是从 0 开始的
    - 列表中的元素是可以重复的，也就是说在 Redis 列表类型中，可以保存同名元素
* 实现为一个双向链表，即可以支持反向查找和遍历，更方便操作，不过带来了部分额外的内存开销
* 列表就是有序元素的序列：10，20，1，2，3就是一个例表，但用数组实现的List和Linked List实现的list，在属性方面大不相同。
    - 基于Linked list实现。意味着即使在一个list中有数百万个元素，在头部或尾部添加一个元素的操作，其时间复杂度也是常数级别的。用LPUSH命令在十个元素的list头部添加新元素，和在千万元素的list头部添加新元素的速度相同。
    - Redis Lists用linked list实现的原因是：
        + 对于数据库系统来说，到头重要的特性是：能非常快的在很大的列表上添加元素
        + 正如你将要看到的：Redis lists能在常数时间取得常数长度
* 缺点
    - 在数组实现的List中利用索引访问元素的速度极快，而同样的操作在linked list实现的list上没有那么快
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
    - 右侧当作队尾，将左侧当作队头
    - 消息队列，可以利用Lists的PUSH操作，将任务存在Lists中，然后工作线程再用POP操作将任务取出进行执行
    - 社交网络中获取用户最新发表的帖子
    - 新闻的分页列表
    - 博客的评论系统
    - 时间轴
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

* 存储一些无序的集合，不能通过索引来操作元素；集合中的元素不能有重复。其元素是二进制安全的字符串，最多可以存储2^32-1个元素
* 适用于集合所有元素都是整数且集合元素数量较小的时候，与哈希表相比，整数集合的优势在于集中存储，节省空间；同时，虽然对于元素的操作复杂度也由O(n)变为了O(1)，但由于集合数量较少，因此操作的时间并没有明显劣势。
* set vs list
    - set 中的元素是不可以重复的，而 list 是可以保存重复元素的。
    - set 中的元素是无序的，而 list 中的元素是有序的。
    - set 中的元素不能通过索引下标获取元素，而 list 中的元素则可以通过索引下标获取元素。
    - 除此之外 set 还支持更高级的功能，例如多个 set 取交集、并集、差集等。
* set 的内部实现是一个 value永远为null的HashMap，实际就是通过计算hash的方式来快速排重的，这也是set能提供判断一个成员是否在集合内的原因。
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
    - 将集合的交集、并集、差集的结果保存,在进行上述比较时，会比较耗费时间，所以为了提高性能可以将交集、并集、差集的结果提前保存起来，这样在需要使用时，可以直接通过 smembers 命令获取
        + sinterstore destination key [key ...]
        + sunionstore destination key [key ...]
        + sdiffstore destination key [key ...]
* 内部编码
    - intset(整数集合)：当集合中的元素都是整数，并且集合中的元素个数小于 512 个时
        + encoding代表contents中存储内容的类型
        + contents（存储集合中的元素）是int8_t类型，但实际上其存储的值是int16_t、int32_t或int64_t，具体的类型便是由encoding决定的；
        + length表示元素个数
    - hashtable(哈希表)：当上述条件不满足时，Redis 会采用 hashtable 作为底层实现。
* 场景
    - 自动去重
    - 当需要存储一个列表数据，而又不希望出现重复的时候
    - 提供了判断某个成员是否在一个Set集合内
    - 标签
    - 关注列表、粉丝列表
    - 共同关注、共同喜好、二度好友等功能

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

* sorted set可以通过用户额外提供一个优先级(score)的参数来为成员排序，并且是插入有序的，即自动排序
* 实现：内部使用HashMap和跳跃表(SkipList)来保证数据的存储和有序，HashMap里放的是成员到score的映射，而跳跃表里存放的是所有的成员，排序依据是HashMap里存的score,使用跳跃表的结构可以获得比较高的查找效率，并且在实现上比较简单
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
* 场景
    - 需要一个有序的并且不重复的集合列表，比如twitter 的public timeline可以以发表时间作为score来存储，这样获取时就是自动按时间排好序的。
    - 做带权重的队列，比如普通消息的score为1，重要消息的score为2，然后工作线程可以选择按score的倒序来获取工作任务。让重要的任务优先执行。
    - 排行榜应用，取TOP N操作
    - 做延时任务
    - 可以做范围查找

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
* 最明显的用法就是用作实时消息系统，比如普通的即时聊天，群聊等功能

```sh
SUBSCRIBE redisChat
PSUBSCRIBE redisChat # 订阅一个或多个符合给定模式 每个模式以 * 作为匹配符，比如 it* 匹配所有以 it 开头的频道( it.news 、 it.blog 、 it.tweets 等等)。 news.* 匹配所有以 news. 开头的频道

PUBLISH redisChat "Redis is a great caching technique"

PUBSUB CHANNELS # 查看订阅与发布系统状态
PUNSUBSCRIBE mychannel # 退订所有给定模式的频道
```

## HyperLogLog

来做基数统计的算法，HyperLogLog 的优点是，在输入元素的数量或者体积非常非常大时，计算基数所需的空间总是固定 的、并且是很小的。
在 Redis 里面，每个 HyperLogLog 键只需要花费 12 KB 内存，就可以计算接近 2^64 个不同元素的基数。这和计算基数时，元素越多耗费内存就越多的集合形成鲜明对比。
比如数据集 {1, 3, 5, 7, 5, 7, 8}， 那么这个数据集的基数集为 {1, 3, 5 ,7, 8}, 基数(不重复元素)为5。 基数估计就是在误差可接受的范围内，快速计算基数。

```
PFADD runoobkey "redis"

PFCOUNT runoobkey
```

### 管道

* 客户端可以将多个命令一次性发送到服务器，然后由服务器一次性返回所有结果
* 管道技术在批量执行命令的时候可以大大减少网络传输的开销，提高性能

```sh
(echo -en "PING\r\n SET w3ckey redis\r\nGET w3ckey\r\nINCR visitor\r\nINCR visitor\r\nINCR visitor\r\n"; sleep 10) | nc localhost 6379
```

## pipeline vs multi

* pipeline 只是把多个redis指令一起发出去，redis并没有保证这些指定的执行是原子的；
* multi相当于一个redis的transaction的，保证整个操作的原子性，避免由于中途出错而导致最后产生的数据不一致。
* pipeline方式执行效率要比其他方式高10倍左右的速度，启用multi写入要比没有开启慢一点。

### Transactions 事务

* 一组命令的集合,命令打包执行的功能
    - 批量操作在发送 EXEC 命令前被放入队列缓存
    - 收到 EXEC 命令后进入事务执行，事务中任意命令执行失败，其余的命令依然被执行
    - 在事务执行过程，其他客户端提交的命令请求不会插入到事务执行命令序列中
* 并不是严格的ACID的事务（比如一串用EXEC提交执行的命令，在执行中服务器宕机，那么会有一部分命令执行了，剩下的没执行）
* Watch功能，可以对一个key进行Watch，然后再执行Transactions，在这过程中，如果这个Watched的值进行了修改，那么这个Transactions会发现并拒绝执行
* 管道与事务的区别
    - 管道主要是网络上的优化，客户端缓冲一组命令，一次性发送到服务器端执行，但是并不能保证命令是在同一个事务里面执行
    - 而事务是原子性的，可以确保命令执行的时候不会有来自其他客户端的命令插入到命令序列中

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
    - 分布式锁是控制分布式系统之间同步访问共享资源的一种方式
    - 在分布式系统中，常常需要协调他们的动作，如果不同的系统或是同一个系统的不同主机之间共享了一个或一组资源，那么访问这些资源的时候，往往需要互斥来防止彼此干扰来保证一致性，在这种情况下，便需要使用到分布式锁。

### 地理信息

从Redis 3.2版本开始，新增了地理信息相关的命令，可以将用户给定的地理位置信息（经纬度）存储起来，并对这些信息进行操作。

## 分区

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

## Cluster

* CLUSTER INFO 打印集群的信息
    - cluster_state：集群的状态。ok表示集群是成功的，如果至少有一个solt坏了，就将处于error状态。
    - cluster_slots_assigned：有多少槽点被分配了，如果是16384，表示全部槽点已被分配。
    - cluster_slots_ok：多少槽点状态是OK的, 16384 表示都是好的。
    - cluster_slots_pfail：多少槽点处于暂时疑似下线[PFAIL]状态，这些槽点疑似出现故障，但并不表示是有问题，也会继续提供服务。
    - cluster_slots_fail：多少槽点处于暂时下线[FAIL]状态，这些槽点已经出现故障，下线了。等待修复解决。
    - cluster_known_nodes：已知节点的集群中的总数，包括在节点 握手的状态可能不是目前该集群的成员。这里总公有9个。
    - cluster_size：(The number of master nodes serving at least one hash slot in the cluster) 简单说就是集群中主节点［Master］的数量。
    - cluster_current_epoch：本地当前时期变量。这是使用，以创造独特的不断增加的版本号过程中失败接管
    - cluster_my_epoch：这是分配给该节点的当前配置版本
    - cluster_stats_messages_sent：通过群集节点到节点的二进制总线发送的消息数
    - cluster_stats_messages_received：通过群集节点到节点的二进制总线上接收报文的数量
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

## 场景

* 一些需要大容量数据集的应用，Redis也并不适合，因为它的数据集不会超过系统可用的内存
* String：即常见的 key/value 存储
    - 缓存、限流、计数器、分布式锁、分布式Session
* List：列表
    - 常用于构建消息队列
    - 微博关注人时间轴列表、简单队列
* Set：集合，与列表类似，不过可以自动去重，
    - 可用于构建粉丝/关注列表，还可以通过交集获取不同用户共同关注用户
    - 赞、踩、标签、好友关系
* Sorted Set：有序集合，支持对集合数据进行自动排序
    - 用于构建积分/热门排行榜以及带权重的消息队列
    - 排行榜
* Hash：字典，可用于存储结构化对象数据，构建 NoSQL 数据库
    - 存储用户信息、用户主页访问量、组合查询

* 显示最新的项目列表：列出最新的回复
* 删除与过滤:用LREM来删除评论 或者 为每个不同的过滤器使用不同的Redis列表。毕竟每个列表只有5000条项目，但Redis却能够使用非常少的内存来处理几百万条项目。
* 排行榜相关：列出前100名高分选手 列出某用户当前的全球排名
* 按照用户投票和时间排序:`score = points / time^alpha`.每次新的新闻贴上来后，我们将ID添加到列表中，使用LPUSH + LTRIM，确保只取出最新的1000条项目。有一项后台任务获取这个列表，并且持续的计算这1000条新闻中每条新闻的最终得分。计算结果由ZADD命令按照新的顺序填充生成列表，老新闻则被清除。这里的关键思路是排序工作是由后台任务来完成的。
* Redis能够替代memcached，让你的缓存从只能存储数据变得能够更新数据，因此你不再需要每次都重新生成数据了。
* 队列：现代的互联网应用大量地使用了消息队列（Messaging）。消息队列不仅被用于系统内部组件之间的通信，同时也被用于系统跟其它服务之间的交互。消息队列的使用可以增加系统的可扩展性、灵活性和用户体验。非基于消息队列的系统，其运行速度取决于系统中最慢的组件的速度（注：短板效应）
* 而基于消息队列可以将系统中各组件解除耦合，这样系统就不再受最慢组件的束缚，各组件可以异步运行从而得以更快的速度完成各自的工作
* 当服务器处在高并发操作的时候，比如频繁地写入日志文件。可以利用消息队列实现异步处理。从而实现高性能的并发操作。
* Pub/Sub：运行稳定并且快速。支持模式匹配，能够实时订阅与取消频道。
* 实时分析正在发生的情况，用于数据统计与防止垃圾邮件等
* 特定时间内的特定项目：统计在某段特点时间里有多少特定用户访问了某个特定资源
* Magento提供一个插件来使用Redis作为全页缓存后端。对WordPress的用户来说，Pantheon有一个非常好的插件  wp-redis，这个插件能帮助你以最快速度加载你曾浏览过的页面。
* 排行榜/计数器

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
* 对比
    - 数据类型：memcached 只支持以 key-value 形式访问存取数据，在内存中维护一张巨大的哈希表，从而保证所有查询的时间复杂度是 O(1)；redis 则支持除 key-value 之外的其他数据类型，比如 list、set、hash、zset 等，用来实现队列、有序集合等更复杂的功能；
    - 性能：memcached  支持多线程，可以利用多核优势，不过也引入了锁，redis 是单线程，在操作大数据方面，memcached 更有优势，处理小数据的时候，redis 更优；
    - 数据持久化：redis 支持数据同步和持久化存储，memcached 不支持，意味着一旦机器重启所有存储数据将会丢失；
    - 数据一致性：memcached 提供了 cas 命令来保证，而 redis 提供了事务的功能，可以保证一串命令的原子性，中间不会被任何操作打断 。
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
    - predis/phpredis 和 memcache/memcached 有点类似，前者是纯 php 实现的，通过 socket 与 redis 服务器通信，使用时只需要通过 composer 加载依赖，无需额外安装扩展，后者是基于 c 语言开发的 PHP 扩展，因此需要安装对应的扩展才能使用，功能上两者差不多，性能上后者略胜一筹，但由于与 redis 通信的主要瓶颈还是在网络 IO 上，所以除非性能要求比较高的场景，否则两者都可以使用，使用 predis 的话不需要安装额外扩展，更简单一些

## 内存管理

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

## 持久化

* RDB：将内存数据全部快照然后存储到硬盘上
    - 定时触发然后将redis存储在内存中的数据以快照的方式全量持久化到硬盘上
    - redis-cli控制台下输入命令save就可以实时触发这个操作，此时redis将会被阻塞，不会再响应客户端的其余任何请求
    - 为了避免这种被阻塞，可以用bgsave来触发rdb备份:redis的主进程会fork出一个子进程来做快照持久化，而主进程可以继续相应客户端的任何请求
    - 出发机制需要配置条件：数据频率
* AOF（Append Only File）：类似于mysql的二进制日志方案
    - aof文件中记录都是在redis中执行过的命令，并不记录数据本身。
    - 假如连续set了10000次，但是最后这10000个key我又全部删除了，aof文件岂不是会记录20000条命令？所以为了解决这个问题，针对aof还有个很重要的rewrite机制
    - 将命令追加到aof这个过程redis官方称之为fsync，fsync这个过程是子线程来做的，主线程依然用来处理客户端的请求
* 对比
    - rdb恢复速度快，aof恢复速度相对要慢一些。
    - 如果aof开启了，那么redis在启动时会选择根据aof文件恢复数据而不是rdb，所以一定要保存好rdb文件。
    - rdb和aof可以同时开启，最大可能地保证数据完整性。如果redis中的数据都是缓存类数据，可以考虑只选择一样即可。
    - 检测修复rdb文件的工具叫做redis-check-rdb，检测修复aof文件的工具叫做redis-check-aof。
    - 如果你有1G的redis数据，那么理论上讲做一次bgsave操作最大需要2G内存，但实际上得益于Copy-On-Write（写时拷贝，COW机制），并不一定会需要2G内存，只有在当主进程将所有的key全部修改过的情况下，才会需要2G内存。
    - 建议redis内存使用量在30%-50%之间，超过50%这个限制就要留心注意下了。

```
# RDB 何时会触发持久化
// save 秒数 发生变化的key的数量:
60秒内如果至少10000个key发生了改变、300秒内至少10个key发生了改变、900秒内至少1一个key发生了改变，那么就会触发bgsave
save 900 1
save 300 10
save 60 10000

// 如果bgsave遇到错误时停止写入
stop-writes-on-bgsave-error yes
// 开启rdb文件压缩，可以有效减少rdb文件的体积。开启压缩需要付出的代价自然就是cpu点数了，如果你为了节省cpu资源，可以关闭压缩
rdbcompression yes
// 开启crc64校验可以让rdb文件具备更好的完整性，但是也是需要cpu点数的，可以选择关闭
rdbchecksum yes
// rdb文件的名字
dbfilename dump.rdb
// redis的工作目录，上面的rdb文件就会保存在redis的工作目录中
dir /var/lib/redis

# AOF
// 是否开启aof
appendonly no
// aof文件名称
appendfilename "appendonly.aof"
// fsync时间间隔
appendfsync everysec
// 当子进程在对aof文件进行rewrite的时候暂停主进程对fsync的append操作，避免产生冲突。因为aof的时候，是子进程来做的，此时如果主进程来append新的指令了，两个进程同时操作一个文件会产生冲突，所以此时主进程要append的指令会被缓存到内容中，当子进程rewrite完成后会向主进程发送一个信号来通知rewrite已完成，然后主进程再将放到内存中的append指令追加到aof文件尾部
no-appendfsync-on-rewrite no
// 触发aof文件rewrite的条件
// 当当前aof文件大小超过上次aof文件体积100%后，才会启动rewrite
auto-aof-rewrite-percentage 100
// 开启rewrite的aof文件最小体积，也就说只有当aof文件超过了64mb后，才会可能产生rewrite。用程序语言表达就是 只有当aof文件体积大于64mb并且当前aof文件体积比上次变化超过了100% 才会产生rewrite。如果aof文件体积小于64mb，那么即便文件变化率超过了100%，也不会发生rewrite。
auto-aof-rewrie-min-size 64mb
// 忽略aof文件中错误的不完整的日志，如果该选项为no，那么redis会加载aof失败。损坏的aof文件可以尝试用redis-check-aof来修复
aof-load-truncated yes
// 这是redis 4.0出现的新特性，集成了rdb和aof的优点的一个产物。大家知道在aof rewrite的时候还是要全量读取一次所有的数据，然后rewrite期间缓存下的命令。既然都要全量读取一次了，为何不在这次全量读取的时候就索性以rdb格式写入到文件呢？然后再追加rewrite期间产生的新aof指令。这样，数据不仅恢复快，还能保证数据完整性。默认情况下，该选项处于关闭状态。
aof-user-rdb-preamble no
```

## 复制

* 复制过程
    - 从节点执行 slaveof 命令。
    - 从节点只是保存了 slaveof 命令中主节点的信息，并没有立即发起复制。
    - 从节点内部的定时任务发现有主节点的信息，开始使用 socket 连接主节点。
    - 连接建立成功后，发送 ping 命令，希望得到 pong 命令响应，否则会进行重连。
    - 如果主节点设置了权限，那么就需要进行权限验证，如果验证失败，复制终止。
    - 权限验证通过后，进行数据同步，这是耗时最长的操作，主节点将把所有的数据全部发送给从节点。
        + sync：redis 2.8 之前的同步命令
        + psync：redis 2.8 为了优化 sync 新设计的命令
            * 需要3个组件支持
                - 主从节点各自复制偏移量
                - 主节点复制积压缓冲区
                - 主节点运行 ID
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
                - 如果回复 +FULLRESYNC {runId} {offset} ，那么从节点将触发全量复制流程。
                - 如果回复 +CONTINUE，从节点将触发部分复制。
                - 如果回复 +ERR，说明主节点不支持 2.8 的 psync 命令，将使用 sync 执行全量复制。
    - 当主节点把当前的数据同步给从节点后，便完成了复制的建立流程。接下来，主节点就会持续的把写命令发送给从节点，保证主从数据一致性
* 全量复制
    - 发送 psync 命令（spync ？-1）
    - 主节点根据命令返回 FULLRESYNC
    - 从节点记录主节点 ID 和 offset
    - 主节点 bgsave 并保存 RDB 到本地
    - 主节点发送 RBD 文件到从节点
    - 从节点收到 RDB 文件并加载到内存中
    - 主节点在从节点接受数据的期间，将新数据保存到“复制客户端缓冲区”，当从节点加载 RDB 完毕，再发送过去。（如果从节点花费时间过长，将导致缓冲区溢出，最后全量同步失败）
    - 从节点清空数据后加载 RDB 文件，如果 RDB 文件很大，这一步操作仍然耗时，如果此时客户端访问，将导致数据不一致，可以使用配置slave-server-stale-data 关闭.   
    - 从节点成功加载完 RBD 后，如果开启了 AOF，会立刻做 bgrewriteaof。
* 部分复制:主节点只需要将复制缓冲区的数据发送到从节点就能够保证数据的一致性，相比较全量复制，成本小很多
    - 当从节点出现网络中断，超过了 repl-timeout 时间，主节点就会中断复制连接。
    - 主节点会将请求的数据写入到“复制积压缓冲区”，默认 1MB。
    - 当从节点恢复，重新连接上主节点，从节点会将 offset 和主节点 id 发送到主节点。
    - 主节点校验后，如果偏移量的数后的数据在缓冲区中，就发送 cuntinue 响应 —— 表示可以进行部分复制。
    - 主节点将缓冲区的数据发送到从节点，保证主从复制进行正常状态。
* 异步复制：主节点处理完写命令后立即返回客户度，并不等待从节点复制完成
    - 主节点接受处理命令。
    - 主节点处理完后返回响应结果 。
    - 对于修改命令，异步发送给从节点，从节点在主线程中执行复制的命令。
* 主从复制
    - 心跳：主从节点在建立复制后，他们之间维护着长连接并彼此发送心跳命令
        + 主从都有心跳检测机制，各自模拟成对方的客户端进行通信，通过 client list 命令查看复制相关客户端信息，主节点的连接状态为 flags = M，从节点的连接状态是 flags = S。
        + 主节点默认每隔 10 秒对从节点发送 ping 命令，可修改配置 repl-ping-slave-period 控制发送频率。
        + 从节点在主线程每隔一秒发送 replconf ack{offset} 命令，给主节点上报自身当前的复制偏移量。
        + 主节点收到 replconf 信息后，判断从节点超时时间，如果超过 repl-timeout 60 秒，则判断节点下线。

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
        + Noeviction：当内存不足以容纳新写入数据时，新写入操作会报错。no-enviction（驱逐）：禁止驱逐数据
        + Allkeys-lru：当内存不足以容纳新写入数据时，在键空间中，移除最近最少使用的Key。推荐使用，目前项目在用这种；
        + Allkeys-random：当内存不足以容纳新写入数据时，在键空间中，随机移除某个key
        + Volatile-lru：当内存不足以容纳新写入数据时，在设置了过期时间的键空间中，移除最近最少使用的Key。这种情况一般是把Redis既当缓存又做持久化存储的时候才用。不推荐；
        + Volatile-random：当内存不足以容纳新写入数据时，在设置了过期时间的键空间中，随机移除某个Key
        + Volatile-ttl：当内存不足以容纳新写入数据时，在设置了过期时间的键空间中，有更早过期时间的Key优先移除
        + 如果没有设置Expire的Key，不满足先决条件（Prerequisites）；那么Volatile-lru、Volatile-random和Volatile-ttl策略的行为，和Noeviction（不删除）基本上一致。

```
maxmemory-policy volatile-lru
```

## 性能

* `redis-benchmark -n 100000`
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

## Culster

## 开发规范

* 键值设计
    - key 名设计
        + 可读性和可管理性：业务名 (或数据库名) 为前缀 (防止 key 冲突)，用冒号分隔 AppID:KeyName
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

## 注意

* 根据需求合理的评估Redis的内存使用量，选择合适的机器配置，可以在满足需求的情况下节约成本
* 了解Redis内存模型可以选择更合适的数据类型和编码，更好的利用Redis内存
* 当Redis出现阻塞、内存占用等问题时，尽快发现导致问题的原因，便于分析解决问题
* Master写内存快照，save命令调度rdbSave函数，会阻塞主线程的工作，当快照比较大时对性能影响是非常大的，会间断性暂停服务，所以Master最好不要写内存快照。
* Master AOF持久化，如果不重写AOF文件，这个持久化方式对性能的影响是最小的，但是AOF文件会不断增大，AOF文件过大会影响Master重启的恢复速度。Master最好不要做任何持久化工作，包括内存快照和AOF日志文件，特别是不要启用内存快照做持久化,如果数据比较关键，某个Slave开启AOF备份数据，策略为每秒同步一次。
* Master调用BGREWRITEAOF重写AOF文件，AOF在重写的时候会占大量的CPU和内存资源，导致服务load过高，出现短暂服务暂停现象。
* Redis主从复制的性能问题，为了主从复制的速度和连接的稳定性，Slave和Master最好在同一个局域网内

## 面试

* 介绍一下你使用过redis的哪些数据结构，并描述一下使用的业务场景；
* 介绍一下你操作redis用到的是什么插件；
* 介绍一下你们使用的序列化方式；
* 介绍一下你们使用redis遇到过给你印象较深的问题；
* 介绍一下你所了解的几个http head头并描述其用途；
* 如果前端提交成功，后端无法接受数据，这时候你将如何排查问题；
* 描述一下http基本报文结构;
* 如果服务器返回cookie，存储在响应内容里面head头的字段叫做什么;
* 当服务端返回Transer-Encoding：chunked 代表什么含义
* 是否了解分段加载并描述下其技术流程。

## 图书

* 《Redis设计与实现》
* Redis 4.X Cookbook

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

## 参考

* [Redis 教程](http://www.runoob.com/redis)
* [Redis参考手册](http://www.php.cn/manual/view/16063.html)
* [redis 数据类型详解 以及 redis适用场景场合](http://www.cnblogs.com/mrhgw/p/6278619.html)
* [使用Redis实现分布式锁及其优化](https://juejin.im/entry/5a0280d551882546d71ec42e)
* [Redis快速入门及应用](https://juejin.im/entry/5a003862f265da430406042c)
