# Redis

Remote Dictionary Server(Redis)是一个基于key-value键值对的持久化数据库存储系统。Redis是一个数据结构存储，可用作数据库、缓存和消息中间件。

* 丰富的数据结构，支持二进制的String，List，Hash，Set及Ordered Set等数据类型操作。
* 与memchaed缓存服务一样，为了保证效率，数据都是缓存在内存中提供服务。
    - 而memcached不同的是，redis持久化存服务还会周期性的把更新的数据写入到磁盘以及把修改的操作记录追加到文件里记录下来，
    - 比memcached更有优势的是，redis还支持master-slave（主从）同步
    - 支持publish/subscribe，通知，key过期等等特性。，
    - 一定程序上弥补了memcached这类key-value内存缓存服务的不足
* 数据存储在内存中,能支持超过100K+每秒的读写频率。
* 单线程，避免了线程切换和锁的性能消耗
* 可持久化（RDB与AOF）,Redis 重启后数据不丢失
* 分布式锁
* 主从复制与高可用（Redis Sentinel）
* 集群
* 支持lua脚本

Redis内部使用一个redisObject对象来表示所有的key和value,redisObject最主要的信息:type代表一个value对象具体是何种数据类型，encoding是不同数据类型在redis内部的存储方式，

vm字段，只有打开了Redis的虚拟内存功能，此字段才会真正的分配内存

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

redis-cli -h localhost -p 6379 info # 功能统计
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

## 数据类型

Redis 没有像 MySQL 这类关系型数据库那样强大的查询功能，需要考虑如何把关系型数据库中的数据，合理的对应到缓存的 key-value 数据结构中。

### String

简单的key-value类型，value其实不仅是String，也可以是数字.值可以是任何各种类的字符串（包括二进制数据）例如你可以在一个键下保存一副jpeg图片.即可以完全实现目前 Memcached 的功能，并且效率更高。还可以享受Redis的定时持久化，操作日志及 Replication等功能

* 获取字符串长度
* 往字符串append内容
* 设置和获取字符串的某一段内容
* 设置及获取字符串的某一位（bit）
* 批量设置一系列字符串的内容

#### 操作

```
set counter 100
get counter
incr counter
incrby counter 10
DECR and DECRBY
```

#### 场景

### Hash

在Memcached中，我们经常将一些结构化的信息打包成HashMap，在客户端序列化后存储为一个字符串的值，比如用户的昵称、年龄、性别、积分等，这时候在需要修改其中某一项时，通常需要将所有值取出反序列化后，修改某一项的值，再序列化存储回去。这样不仅增大了开销，也不适用于一些可能并发操作的场合（比如两个并发的操作都需要修改积分）。而Redis的Hash结构可以使你像在数据库中Update一个属性一样只修改某一项属性值。

要存储一个用户信息对象数据:
* 将用户ID作为查找key,把其他信息封装成一个对象以序列化的方式存储，这种方式的缺点是，增加了序列化/反序列化的开销，并且在需要修改其中一项信息时，需要把整个对象取回，并且修改操作需要对并发进行保护，引入CAS等复杂问题。
* 这个用户信息对象有多少成员就存成多少个key-value对儿，用用户ID+对应属性的名称作为唯一标识来取得对应属性的值，虽然省去了序列化开销和并发问题，但是用户ID为重复存储，如果存在大量这样的数据，内存浪费还是非常可观的。

Redis的Hash实际是内部存储的Value为一个HashMap，并提供了直接存取这个Map成员的接口.Key仍然是用户ID, value是一个Map，这个Map的key是成员的属性名，value是属性值，这样对数据的修改和存取都可以直接通过其内部Map的Key(Redis里称内部Map的key为field), 也就是通过 key(用户ID) + field(属性标签) 就可以操作对应属性数据了，既不需要重复存储数据，也不会带来序列化和并发修改控制的问题。
Redis提供了接口(hgetall)可以直接取到全部的属性数据,但是如果内部Map的成员很多，那么涉及到遍历整个内部Map的操作，由于Redis单线程模型的缘故，这个遍历操作可能会比较耗时，而另其它客户端的请求完全不响应

HashMap，实际这里会有2种不同实现，这个Hash的成员比较少时Redis为了节省内存会采用类似一维数组的方式来紧凑存储，而不会采用真正的HashMap结构，对应的value redisObject的encoding为zipmap,当成员数量增大时会自动转成真正的HashMap,此时encoding为ht。

#### 操作

```
hgetall
hget
hset
```

#### 场景

### List

* twitter的关注列表，粉丝列表等都可以用Redis的list结构来实现。
* 使用Lists结构，我们可以轻松地实现最新消息排行等功能。
* Lists的另一个应用就是消息队列，可以利用Lists的PUSH操作，将任务存在Lists中，然后工作线程再用POP操作将任务取出进行执行。

Redis list的实现为一个双向链表，即可以支持反向查找和遍历，更方便操作，不过带来了部分额外的内存开销，Redis内部的很多实现，包括发送缓冲队列等也都是用的这个数据结构。

一般意义上讲，列表就是有序元素的序列：10，20，1，2，3就是一个例表，但用数组实现的List和Linked List实现的list，在属性方面大不相同。
Redis lists基于Linked list实现。这意味着即使在一个list中有数百万个元素，在头部或尾部添加一个元素的操作，其时间复杂度也是常数级别的。用LPUSH命令在十个元素的list头部添加新元素，和在千万元素的list头部添加新元素的速度相同。

坏消息:在数组实现的List中利用索引访问元素的速度极快，而同样的操作在linked list实现的list上没有那么快。

Redis Lists用linked list实现的原因是：
* 对于数据库系统来说，到头重要的特性是：能非常快的在很大的列表上添加元素，
* 正如你将要看到的：Redis lists能在常数时间取得常数长度。

#### 操作

```
RPUSH list1 "Guanqinglin" // 返回索引
LRANGE list1 0 3    // 取范围值
lpush
lpop
rpop
```

#### 场景

聊天系统、社交网络中获取用户最新发表的帖子、简单的消息队列、新闻的分页列表、博客的评论系统。

### Set

就是一堆不重复值的组合。利用Redis提供的Sets数据结构，可以存储一些集合性的数据，比如在微博应用中，可以将一个用户所有的关注人存在一个集合中，将其所有粉丝存在一个集合。Redis还为集合提供了求交集、并集、差集等操作，可以非常方便的实现如共同关注、共同喜好、二度好友等功能，对上面的所有集合操作，你还可以使用不同的命令选择将结果返回给客户端还是存集到一个新的集合中。

未排序的集合，其元素是二进制安全的字符串。对外提供的功能与list类似是一个列表的功能，特殊之处在于set是可以自动排重的，当你需要存储一个列表数据，又不希望出现重复数据时，set是一个很好的选择，并且set提供了判断某个成员是否在一个set集合内的重要接口

set 的内部实现是一个 value永远为null的HashMap，实际就是通过计算hash的方式来快速排重的，这也是set能提供判断一个成员是否在集合内的原因。

#### 操作

```
SADD myset guan
SMEMBERS myset
SISMEMBER myset guan
spop
sunion
```

#### 场景

当需要存储一个列表数据，而又不希望出现重复的时候
提供了判断某个成员是否在一个Set集合内的接口

### Sorted set

使用场景与set类似，区别是set不是自动有序的，而sorted set可以通过用户额外提供一个优先级(score)的参数来为成员排序，并且是插入有序的，即自动排序。当你需要一个有序的并且不重复的集合列表，那么可以选择sorted set数据结构，比如twitter 的public timeline可以以发表时间作为score来存储，这样获取时就是自动按时间排好序的。

另外还可以用Sorted Sets来做带权重的队列，比如普通消息的score为1，重要消息的score为2，然后工作线程可以选择按score的倒序来获取工作任务。让重要的任务优先执行。

Redis sorted set的内部使用HashMap和跳跃表(SkipList)来保证数据的存储和有序，HashMap里放的是成员到score的映射，而跳跃表里存放的是所有的成员，排序依据是HashMap里存的score,使用跳跃表的结构可以获得比较高的查找效率，并且在实现上比较简单。

#### 操作

```
zadd
zrange
zrem
zcard
```

#### 场景

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

## 特性

* 管道：Redis管道是指客户端可以将多个命令一次性发送到服务器，然后由服务器一次性返回所有结果。管道技术在批量执行命令的时候可以大大减少网络传输的开销，提高性能。
* 事务：Redis事务是一组命令的集合。一个事务中的命令要么都执行，要么都不执行。如果命令在运行期间出现错误，不会自动回滚。管道与事务的区别：管道主要是网络上的优化，客户端缓冲一组命令，一次性发送到服务器端执行，但是并不能保证命令是在同一个事务里面执行；而事务是原子性的，可以确保命令执行的时候不会有来自其他客户端的命令插入到命令序列中。
* 分布式锁：分布式锁是控制分布式系统之间同步访问共享资源的一种方式。在分布式系统中，常常需要协调他们的动作，如果不同的系统或是同一个系统的不同主机之间共享了一个或一组资源，那么访问这些资源的时候，往往需要互斥来防止彼此干扰来保证一致性，在这种情况下，便需要使用到分布式锁。
* 地理信息：从Redis 3.2版本开始，新增了地理信息相关的命令，可以将用户给定的地理位置信息（经纬度）存储起来，并对这些信息进行操作。


## 对比memcache

* Redis最佳试用场景是*全部数据in-memory*
* Redis更多场景是作为Memcached的替代品来使用。
* 当需要除key/value之外的更多数据类型支持时，使用Redis更合适。
* 支持持久化。
* 需要负载均衡的场景（redis主从同步）,分布式系统支持，数据一致性保证，方便的集群节点添加/删除
* Redis支持数据的持久化，可以将内存中的数据保持在磁盘中，重启的时候可以再次加载进行使用。

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

## pipeline vs multi

* pipeline 只是把多个redis指令一起发出去，redis并没有保证这些指定的执行是原子的；
* multi相当于一个redis的transaction的，保证整个操作的原子性，避免由于中途出错而导致最后产生的数据不一致。
* pipeline方式执行效率要比其他方式高10倍左右的速度，启用multi写入要比没有开启慢一点。

## 工具

* [Redis Desktop Manager](https://github.com/uglide/RedisDesktopManager)

## 参考

* [erikdubbelboer/phpRedisAdmin](https://github.com/erikdubbelboer/phpRedisAdmin):Simple web interface to manage Redis databases. http://dubbelboer.com/phpRedisAdmin/
* [phpredis/phpredis](https://github.com/phpredis/phpredis):A PHP extension for Redis
* [redis 数据类型详解 以及 redis适用场景场合](http://www.cnblogs.com/mrhgw/p/6278619.html)
* [使用Redis实现分布式锁及其优化](https://juejin.im/entry/5a0280d551882546d71ec42e)
* [Redis快速入门及应用](https://juejin.im/entry/5a003862f265da430406042c)
