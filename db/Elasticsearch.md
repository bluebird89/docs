# [elastic/elasticsearch](https://github.com/elastic/elasticsearch)

Open Source, Distributed, RESTful Search Engine，一个基于Lucene的实时的分布式搜索和分析全文搜索引擎

* 基于RESTful接口
* 面向文档型数据库，一条数据就是一个文档，用JSON作为文档序列化的格式
* 场景
  - 搜索领域：相对于solr，真正的后起之秀，成为很多搜索系统的不二之选。
  - Json文档数据库：相对于MongoDB，读写性能更佳，而且支持更丰富的地理位置查询以及数字、文本的混合查询等
  - 时序数据分析处理：日志处理、监控数据的存储、分析和可视化方面做得非常好
* 底层 lucene,封装好的各种建立倒排索引的算法代码
* 特点
  - 通过数据分片技术，分区存储数据。（水平分表）
  - 通过副本技术冗余保存数据，es副本可以提供查询（读写分离）
  - 分片有自我调配能力，主分片挂掉，副本选举为主分片，可以跨node存储。（分库分表、高性能弹性扩容）
  - 主分片和副本分片数据同步es内部提供机制。（可配置异步、同步）
  - 当节点变更或故障，带来主分片、副本分片的调配恢复，es主节点完成管理，节点恢复，自动恢复同步数据。（高可用、容错、恢复）

## 安装

* 安装Java8 环境
* Mac
  - bin:
  - Data:    /usr/local/var/elasticsearch/elasticsearch_henry/
  - Logs:    /usr/local/var/log/elasticsearch/elasticsearch_henry.log
  - Plugins: /usr/local/opt/elasticsearch/libexec/plugins/
  - Config:  /usr/local/etc/elasticsearch/
  - plugin script: /usr/local/opt/elasticsearch/libexec/bin/elasticsearch-plugin

```sh
# JDK  放在路径/usr/local/java 编辑配置文件 /etc/profile
export JAVA_HOME=/usr/local/java/jdk1.8.0_77
export PATH=$JAVA_HOME/bin:$PATH
java -version

wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.5.2.zip
wget https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/2.1.0/elasticsearch-2.1.0.tar.gz
unzip elasticsearch-5.5.2.zip
tar xf elasticsearch-2.1.0.tar.gz

curl -L -O https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.5.1-amd64.deb
sudo dpkg -i elasticsearch-7.5.1-amd64.deb

# ubuntu
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt-get install apt-transport-https
sudo apt-get update && sudo apt-get install elasticsearch
sudo service elasticsearch start

brew install elasticsearch # http://localhost:9200

cd elasticsearch-5.5.2/
./plugin  -install mobz/elasticsearch-head  # web集群管理插件  安装好了以后可以在plugin文件发现多了一个head

# 开启服务，默认的9200端口运行
./bin/elasticsearch
./elasticsearch  -Des.insecure.allow.root=true  #加这个参数才可以root启动
./bin/elasticsearch -d -p pid # 后台运行
```

## 配置

* 默认情况下，Elastic 只允许本机访问
* 远程访问，可以修改 Elastic 安装目录的config/elasticsearch.yml文件，去掉network.host的注释，值改成0.0.0.0，然后重新启动 Elastic

```sh
# /etc/elasticsearch/elasticsearch.yml
network.host: localhost

sudo ufw allow from 198.51.100.0 to any port 9200
sudo ufw enable

# 开启另一端开口,返回一个 JSON 对象，包含当前节点、集群、版本等信息
curl -X GET 'http://localhost:9200'
curl -XGET 'http://localhost:9200/_nodes?pretty'

# add
curl -XPOST -H "Content-Type: application/json" 'http://localhost:9200/tutorial/helloworld/1' -d '{ "message": "Hello World!" }'

# retrieve
curl -X GET -H "Content-Type: application/json" 'http://localhost:9200/tutorial/helloworld/1' -d '{ "message": "Hello World!" }'

# modify
curl -X PUT -H "Content-Type: application/json"  'localhost:9200/tutorial/helloworld/1?pretty' -d '
{
  "message": "Hello, People!"
}'
curl -X GET -H "Content-Type: application/json" 'http://localhost:9200/tutorial/helloworld/1?pretty'

curl -XGET 'localhost:9200/_cat/health?v&pretty'
{
 "name" : "Reeva Payge",
 "cluster_name" : "elasticsearch",
 "version" : {
   "number" : "2.1.0",
   "build_hash" : "72cd1f1a3eee09505e036106146dc1949dc5dc87",
   "build_timestamp" : "2015-11-18T22:40:03Z",
   "build_snapshot" : false,
   "lucene_version" : "5.3.1"
 },
 "tagline" : "You Know, for Search"
}
# web地址  http://192.168.88.250:9200/_plugin/head/
```

## 概念

* 本质上是一个分布式数据库，允许多台服务器协同工作，每台服务器可以运行多个 Elastic 实例
* 集群（Cluster）：物理概念，由多个节点组成Es集群
* 节点（Node)：物理概念，一个运行的Elasticearch实例，一般是一台机器上一个进程
  - 主节点（master node）:只参与元数据管理，整个集群只有一个唯一主节点，多个主节点会参与竞选为唯一主节点
    + 有多台保证高可用
    + 选举机制保证主节点只能有一台运行时管理集群
  - 数据节点（data node）:保存数据，完成本节点数据查询的功能
  - 协调节点或客户端节点（client node）：数据分片到不同datanode后，分布式查询分为：查询阶段+取回阶段。该节点接受客户端请求并路由到各datanode完成数据查询，在协调节点完成数据合并取回阶段的功能
* 对应关系
  - 关系数据库：数据库 ⇒ 表 ⇒ 行 ⇒ 列(Columns)
  - Elasticsearch：索引 ⇒ 类型 ⇒ 文档 ⇒ 字段(Fields)
* 索引（Index）：逻辑概念，包括配置信息mapping和倒排正排数据文件，一个索引的数据文件可能会分布于一台机器，也有可能分布于多台机器。索引的另外一层意思是倒排索引文件。索引中数据是保存在datanode，但是mapping等元数据是保存在master主节点
  - Elastic 会索引所有字段，经过处理后写入一个反向索引（Inverted Index）,查找数据的时候，直接查找该索引
  - Elastic 数据管理的顶层单位就叫做 Index（索引）,它是单个数据库的同义词
  - 每个 Index （即数据库）的名字必须是小写
* 分片（Shard）
  - 为了支持更大量的数据，索引一般会按某个维度分成多个部分，每个部分就是一个分片，分片被数据节点(dataNode)管理。
  - 一个节点(Node)一般会管理多个分片，这些分片可能是属于同一份索引，也有可能属于不同索引，但是为了可靠性和可用性，同一个索引的分片尽量会分布在不同节点(Node)上。
  - 分片有两种，主分片和副本分片。
    + 主分片（Primary）：每个索引必须包含1个主分片，也可以多个主分片。按照mysql概念理解的话，一个表=一个index， 这表水平拆分为能n个分表，相当于这个index有n个分片。 主分片可以在同一个物理datanode上，也可以在不同datanode，没有强制要求。为了性能，最好分散开来。
    + 副本（Replica）：同一个分片(Shard)的备份数据，一个分片可能会有0个或多个副本，这些副本中的数据保证强一致或最终一致（可配置）。**副本分片必须和相同数据的主分片不在同一个datanode，是强制要求**。如果datanode不够，副本分片将不工作。 副本分片不工作，不影响正常数据存储和读取，只是index状态为红色。
* 倒排索引
  - 每个文档都有一个对应的文档 ID，文档内容被表示为一系列关键词的集合。例如，文档 1 经过分词，提取了 20 个关键词，每个关键词都会记录它在文档中出现的次数和出现位置
  - 倒排索引就是关键词到文档 ID 的映射，每个关键词都对应着一系列的文件，这些文件中都出现了关键词
  - 所有词项对应一个或多个文档
  - 倒排索引中的词项根据字典顺序升序排列
* 服务
  - 分布式存储都支持数据分片存储，分片储存需要两阶段查询。查询阶段+结果合并阶段。
  - 分布式存储都支持分片的副本存储，数据写入主分片后，需要同步、异步机制同步数据到副本分片，冗余保存。
  - 数据分片需要有路由规则，内部叫route table，存储在主节点中，作为整个集群元数据一部分。
* type:相当于表结构描述
  - Document 可以分组，比如weather这个 Index 里面，可以按城市分组（北京和上海），也可以按气候分组（晴天和雨天）。这种分组就叫做 Type，它是虚拟的逻辑分组，用来过滤 Document
  - 类型是通过mapping来定义每个字段的类型
  - 不同的 Type 应该有相似的结构（schema），举例来说，id字段不能在这个组是字符串，在另一个组是数值。这是与关系型数据库的表的一个区别。性质完全不同的数据（比如products和logs）应该存成两个 Index，而不是一个 Index 里面的两个 Type（虽然可以做到）
* document：Index 里面单条的记录称为 Document（文档）
  - 多条 Document 构成了一个 Index
  - Document 使用 JSON 格式表示，同一个 Index 里面的 Document，不要求有相同的结构（scheme），但是最好保持相同，这样有利于提高搜索效率

```sh
# 查看当前节点的所有 Index
curl -X GET 'http://localhost:9200/_cat/indices?v'

# 列出每个 Index 所包含的 Type
curl 'localhost:9200/_mapping?pretty=true'

# 新建一个名叫weather的 Index
curl -X PUT 'localhost:9200/accounts/person/1' -d'
{
  "user": "张三",
  "title": "工程师",
  "desc": "数据库管理"
}'

curl 'localhost:9200/accounts/person/_search'

# 删除
curl -X DELETE 'localhost:9200/accounts/person/1'
```

## 原理

* 分布式实时文件存储，并将每一个字段都编入索引，使其可以被搜索
* 可以扩展到上百台服务器，处理PB级别的结构化或非结构化数据
* 为每个field都建立了一个倒排索引,数据结构：Posting list就是一个int的数组，存储了所有符合某个term的文档id, term =>Posting list, 比如 John => [1,2]
  - 所有的term排个序，二分法查找term，logN的查找效率，就像通过字典查找一样，这就是Term Dictionary
  - 接通过内存查找term，不读磁盘，但是如果term太多，term dictionary也会很大，放内存不现实，于是有了Term Index，就像字典里的索引页一样，A开头的有哪些term，分别在哪页，可以理解term index是一颗树
    + 这棵树不会包含所有的term，它包含的是term的一些前缀。通过term index可以快速地定位到term dictionary的某个offset，然后从这个位置再往后顺序查找
    + term index不需要存下所有的term，而仅仅是一些前缀与Term Dictionary的block之间的映射关系，再结合FST(Finite State Transducers)的压缩技术，可以使term index缓存到内存中
    + 从term index查到对应的term dictionary的block位置之后，再去磁盘上找term，大大减少了磁盘随机读的次数
    + [FST](https://cs.nyu.edu/~mohri/pub/fla.pdf):以字节的方式存储所有的term，这种压缩方式可以有效的缩减存储空间，使得term index足以放进内存，但这种方式也会导致查找时需要更多的CPU资源
  - posting list压缩:对同学的性别进行索引
    + 增量编码压缩，将大数变小数，按字节存储
      * posting list是有序的
      * 通过增量，将原来的大数变成小数仅存储增量值，再精打细算按bit排好队，最后通过字节存储，而不是大大咧咧的尽管是2也是用int(4个字节)来存储
    + Roaring bitmaps，必须先从bitmap说起
      * Bitmap是一种数据结构，假设有某个posting list： [1,3,4,7,10] 对应的bitmap就是：[1,0,1,1,0,0,1,0,0,1], 0/1表示某个位的值是否存在。一个字节就可以代表8个文档id。存储空间随着文档个数线性增长
      * 按照65535为界限分块，比如第一块所包含的文档id范围在0~65535之间，第二块的id范围是65536~131071，以此类推
        - 大于4096用bitset存节省点，小于用一个short[]存着，2个字节
      * 用<商，余数>的组合表示每一组id
    + 如果ID是顺序的，或者是有公共前缀等具有一定规律性的ID，压缩比会比较高
    + 通过Posting list里的ID到磁盘中查找Document信息的那步，因为Elasticsearch是分Segment存储的，根据ID这个大范围的Term定位到Segment的效率直接影响了最后查询的性能，如果ID是有规律的，可以快速跳过不包含该ID的Segment，从而减少不必要的磁盘读次数
* 联合索引
  - 利用跳表(Skip list)的数据结构快速做“与”运算
    + 将一个有序链表level0，挑出其中几个元素到level1及level2，每个level越往上，选出来的指针元素越少
    + 查找时依次从高level往低查找，比如55，先找到level2的31，再找到level1的47，最后找到55，一共3次查找
    + 查找效率和2叉树的效率相当，但也是用了一定的空间冗余来换取的
    + 有下面三个posting list需要联合索引
      * 使用跳表，对最短的posting list中的每个id，逐个在另外两个posting list中查找看是否存在，最后得到交集的结果。
  - 利用上面提到的bitset按位“与”
* 索引
  - 将磁盘里东西尽量搬进内存，减少磁盘随机读取次数(同时也利用磁盘顺序读特性)，结合各种压缩算法，用及其苛刻的态度使用内存
* 注意
  - 不需要索引的字段，一定要明确定义出来，因为默认是自动建索引的
  - 对于String类型的字段，不需要analysis的也需要明确定义出来，因为默认也是会analysis的
  - 选择有规律的ID很重要，随机性太大的ID(比如java的UUID)不利于查询

![FST(Finite State Transducers)](../../_static/fst.png "FST(Finite State Transducers)")

* ⭕️表示一种状态,–>表示状态的变化过程，上面的字母/数字表示状态变化和权重
* 将单词分成单个字母通过⭕️和–>表示出来，0权重不显示。如果⭕️后面出现分支，就标记权重，最后整条路径上的权重加起来就是这个单词对应的序号

![Frame Of Reference](../../_static/frameOfReference.png "Frame Of Reference")
![Roaringbitmaps](../../_static/Roaringbitmaps.png "Roaringbitmaps")
![skiplist](../../_static/skiplist.png "skiplist")
![combineIndex](../../_static/combineIndex.png "combineIndex")

## 操作

* 写请求是写入 primary shard，然后同步给所有的 replica shard；读请求可以从 primary shard 或 replica shard 读取，采用的是随机轮询算法
* 写数据
  - 客户端选择一个 node 发送请求过去，这个 node 就是 coordinating node （协调节点）。
  - coordinating node 对 document 进行路由，将请求转发给对应的 node（有 primary shard）。
  - 实际的 node 上的 primary shard 处理请求，然后将数据同步到 replica node 。
  - coordinating node 如果发现 primary node 和所有 replica node 都搞定之后，就返回响应结果给客户端
  - 底层原理:数据先写入内存 buffer，然后每隔 1s，将数据 refresh 到 os cache，到了 os cache 数据就能被搜索到。每隔 5s，将数据写入 translog 文件，translog 大到一定程度，或者默认每隔 30mins，会触发 commit 操作，将缓冲区的数据都 flush 到 segment file 磁盘文件中
    + 先写入内存 buffer，在 buffer 里的时候数据是搜索不到的；同时将数据写入 translog 日志文件
    + 如果 buffer 快满了，或者到一定时间，就会将内存 buffer 数据 refresh 到一个新的 segment file 中，但是此时数据不是直接进入 segment file 磁盘文件，而是先进入 os cache 。这个过程就是 refresh
    + 每隔 1 秒钟，es 将 buffer 中的数据写入一个新的 segment file ，每秒钟会产生一个新的磁盘文件 segment file ，这个 segment file 中就存储最近 1 秒内 buffer 中写入的数据
    + 如果 buffer 里面此时没有数据，那当然不会执行 refresh 操作，如果 buffer 里面有数据，默认 1 秒钟执行一次 refresh 操作，刷入一个新的 segment file 中
    + 操作系统里面，磁盘文件其实都有一个东西，叫做 os cache ，即操作系统缓存，就是说数据写入磁盘文件之前，会先进入 os cache ，先进入操作系统级别的一个内存缓存中去。只要 buffer 中的数据被 refresh 操作刷入 os cache 中，这个数据就可以被搜索到了
    + 准实时
      * NRT near real-time:默认是每隔 1 秒 refresh 一次的，所以 es 是准实时的，因为写入的数据 1 秒之后才能被看到
      * 可以通过 es 的 restful api 或者 java api ，手动执行一次 refresh 操作，就是手动将 buffer 中的数据刷入 os cache 中，让数据立马就可以被搜索到。
      * 只要数据被输入 os cache 中，buffer 就会被清空了，因为不需要保留 buffer 了，数据在 translog 里面已经持久化到磁盘去一份了
    + 新的数据不断进入 buffer 和 translog，不断将 buffer 数据写入一个又一个新的 segment file 中去，每次 refresh 完 buffer 清空，translog 保留。随着这个过程推进，translog 会变得越来越大。当 translog 达到一定长度的时候，就会触发 commit 操作
    + commit 操作发生第一步，就是将 buffer 中现有数据 refresh 到 os cache 中去，清空 buffer。然后，将一个 commit point 写入磁盘文件，里面标识着这个 commit point 对应的所有 segment file ，同时强行将 os cache 中目前所有的数据都 fsync 到磁盘文件中去。最后清空 现有 translog 日志文件，重启一个 translog，此时 commit 操作完成。
    + 这个 commit 操作叫做 flush 。默认 30 分钟自动执行一次 flush ，但如果 translog 过大，也会触发 flush 。flush 操作就对应着 commit 的全过程，可以通过 es api，手动执行 flush 操作，手动将 os cache 中的数据 fsync 强刷到磁盘上去。
    + translog 日志文件的作用是什么？你执行 commit 操作之前，数据要么是停留在 buffer 中，要么是停留在 os cache 中，无论是 buffer 还是 os cache 都是内存，一旦这台机器死了，内存中的数据就全丢了。所以需要将数据对应的操作写入一个专门的日志文件 translog 中，一旦此时机器宕机，再次重启的时候，es 会自动读取 translog 日志文件中的数据，恢复到内存 buffer 和 os cache 中去。
    + translog 其实也是先写入 os cache 的，默认每隔 5 秒刷一次到磁盘中去，所以默认情况下，可能有 5 秒的数据会仅仅停留在 buffer 或者 translog 文件的 os cache 中，如果此时机器挂了，会丢失 5 秒钟的数据。但是这样性能比较好，最多丢 5 秒的数据。也可以将 translog 设置成每次写操作必须是直接 fsync 到磁盘，但是性能会差很多。
    +  es 第一是准实时的，数据写入 1 秒后可以搜索到；可能会丢失数据的。有 5 秒的数据，停留在 buffer、translog os cache、segment file os cache 中，而不在磁盘上，此时如果宕机，会导致 5 秒的数据丢失。
* 读数据：通过 doc id 来查询，会根据 doc id 进行 hash，判断出来当时把 doc id 分配到了哪个 shard 上面去，从那个 shard 去查询
  - 客户端发送请求到任意一个 node，成为 coordinate node
  - coordinate node 对 doc id 进行哈希路由，将请求转发到对应的 node，此时会使用 round-robin 随机轮询算法，在 primary shard 以及其所有 replica 中随机选择一个，让读请求负载均衡。
  - 接收请求的 node 返回 document 给 coordinate node
  - coordinate node 返回 document 给客户端
* 删除/更新数据
  - 删除操作，commit 的时候会生成一个 .del 文件，里面将某个 doc 标识为 deleted 状态，那么搜索的时候根据 .del 文件就知道这个 doc 是否被删除了
  - 更新操作，就是将原来的 doc 标识为 deleted 状态，然后新写入一条数据
  - buffer 每 refresh 一次，就会产生一个 segment file ，所以默认情况下是 1 秒钟一个 segment file ，这样下来 segment file 会越来越多，此时会定期执行 merge。每次 merge 的时候，会将多个 segment file 合并成一个，同时这里会将标识为 deleted 的 doc 给物理删除掉，然后将新的 segment file 写入磁盘，这里会写一个 commit point ，标识所有新的 segment file ，然后打开 segment file 供搜索使用，同时删除旧的 segment file
* 搜索数据
  - 客户端发送请求到一个 coordinate node
  - 协调节点将搜索请求转发到所有的 shard 对应的 primary shard 或 replica shard ，都可以
  - query phase：每个 shard 将自己的搜索结果（其实就是一些 doc id ）返回给协调节点，由协调节点进行数据的合并、排序、分页等操作，产出最终结果。
  - fetch phase：接着由协调节点根据 doc id 去各个节点上拉取实际的 document 数据，最终返回给客户端

## 性能

* filesystem cache:查询的时候，操作系统会将磁盘文件里的数据自动缓存到 filesystem cache 里面去
  - es 的搜索引擎严重依赖于底层的 filesystem cache，你如果给 filesystem cache 更多的内存，尽量让内存可以容纳所有的 idx segment file 索引数据文件，那么你搜索的时候就基本都是走内存的，性能会非常高

## ELK

* 标准化:
    - 路径规划: /data/logs/,/data/logs/access,/data/logs/error,/data/logs/run
    - 格式要求: 严格要求使用json
    - 命名规则: access_log error_log runtime_log system_log
    - 日志切割: 按天，按小时。访问,错误，程序日志按小时，系统日志按天收集。
    - 原始文本: rsync推送NAS，后删除最近三天前。
    - 消息队列: 访问日志,写入Redis_DB6，错误日志Redis_DB7,程序日志Redis_DB8
* 工具化:
    - 访问日志  Apache、Nginx、Tomcat       (使用file插件)
    - 错误日志  java日志、异常日志          (使用mulitline多行插件)
    - 系统日志  /var/log/*、rsyslog         (使用syslog)
    - 运行日志  程序写入的日志文件          (可使用file插件或json插件)
    - 网络日志  防火墙、交换机、路由器      (syslog插件)
* 集群化:
    - 每台ES上面都启动一个Kibana
    - Kibana都连自己的ES
    - 前端Nginx负载均衡+验证,代理至后端Kibana
    - 通过消息队列来实现程序解耦以及高可用等扩展
* 监控化:
    - 对ES以及Kibana、进行监控。如果服务DOWN及时处理。
    - 使用Redis的list作为ELKstack消息队列。
    - Redis的List Key长度进行监控(llen key_name)。例:超过"10万"即报警(根据实际情况以及业务情况)
* 迭代化:
    - 开源日志分析平台:ELK、EFK、EHK
    - 数据收集处理:Flume、heka
    - 消息队列:Redis、Rabbitmq、Kafka、Hadoop、webhdfs

```
elasticsearch-plugin list
elasticsearch-plugin install analysis-icu

elasticsearch -E node.name=node1 -E cluster.name=geektime -E path.data=node1_data -d
elasticsearch -E node.name=node2 -E cluster.name=geektime -E path.data=node2_data -d
elasticsearch -E node.name=node3 -E cluster.name=geektime -E path.data=node3_data -d

http://localhost:9200/_cat/nodes
```

## Logstash

采集数据导入

```sh
## 搭建
wget https://download.elastic.co/logstash/logstash/logstash-2.1.1.tar.gz
tar xf logstash-2.1.1.tar.gz

brew install logstash # http://localhost:9600

cd /usr/local/logstash-2.1.1/bin
vim stdin.conf #编写配置文件
input{
       file {
               path => "/var/log/nginx/access.log_json"  #NGINX日志地址 json格式
              codec => "json"  # json编码
       }
}
filter {
       mutate {
               split => ["upstreamtime", ","]
       }
       mutate {
               convert => ["upstreamtime", "float"]
       }
}
output{
       elasticsearch {
               hosts => ["192.168.88.250:9200"]   #elasticsearch地址
               index => "logstash-%{type}-%{+YYYY.MM.dd}"   #索引
               document_type => "%{type}"
               workers => 1
               flush_size => 20000        #传输数量 默认500
               idle_flush_time => 10      #传输秒数  默认1秒
               template_overwrite => true
       }
}

# logstash-sample.conf
input { stdin { } }
output {
  elasticsearch { hosts => ["localhost:9200"]  index => "my_blog"
        user => "elastic"
        password => "json"
  }
  stdout { codec => rubydebug }
}

./bin/logstash -f logstash-sample.conf
./logstash -f stdin.conf &  #后台启动
# 启动成功以后 打开刚才搭建的web服务器  es就能看到数据
```

## [elastic/kibana](https://github.com/elastic/kibana)

📊 Kibana analytics and search dashboard for Elasticsearch https://www.elastic.co/products/kibana

```sh
# 搭建
wget https://artifacts.elastic.co/downloads/kibana/kibana-7.1.1-darwin-x86_64.tar.gz # http://localhost:5601
tar xf kibana-4.3.1-linux-x64.tar.gz
cd /usr/local/kibana-4.3.1-linux-x64/

# ./config/kibana.yml
elasticsearch.url: #   只需要修改URL为ElasticSearch的IP地址

./kibana& # 后台启动
# 启动成功以后 会监听 5601端口

# 可以用Kibana查看 地址 : 192.168.88.250:5601
# create灰色的 说明没有创建索引  打开你的nginx服务器 刷新几下 采集一下数据 然后  选择 左上角的 Discover
# 数据可能会出不来 那是因为 Kibana 是根据时间来匹配的 并且 因为 Logstash的采集时间使用的UTC  永远早8个小时 所以设置时间 要设置晚8个小时以后

echo "kibanaadmin:`openssl passwd -apr1`" | sudo tee -a /etc/nginx/htpasswd.users
kibanaadmin:$apr1$M2kx248q$TRbbkejn8bxFsdztudF6Z0

# nginx
# 搭建nginx之前需要安装 pcre
tar xf nginx-1.7.8.tar.gz
cd /usr/local/nginx
vim /usr/local/nginx/conf/nginx.conf

#user  nobody;
worker_processes  1;

#error_log  logs/error.log  notice;
#error_log  logs/error.log  info;

#pid        logs/nginx.pid;

events {
  worker_connections  1024;
}

http {
    upstream kibana4 {  #对Kibana做代理
           server 127.0.0.1:5601 fail_timeout=0;
    }
   include       mime.types;
   default_type  application/octet-stream;

   #log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
   #                  '$status $body_bytes_sent "$http_referer" '
   #                  '"$http_user_agent" "$http_x_forwarded_for"';

    log_format json '{"@timestamp":"$time_iso8601",'   #配置NGINX的日志格式 json
                       '"host":"$server_addr",'
                       '"clientip":"$remote_addr",'
                       '"size":$body_bytes_sent,'
                       '"responsetime":$request_time,'
                       '"upstreamtime":"$upstream_response_time",'
                       '"upstreamhost":"$upstream_addr",'
                       '"http_host":"$host",'
                       '"url":"$uri",'
                       '"xff":"$http_x_forwarded_for",'
                       '"referer":"$http_referer",'
                       '"agent":"$http_user_agent",'
                       '"status":"$status"}';
    access_log /var/log/nginx/access.log_json json;   #配置日志路径 json格式
    error_log /var/log/nginx/error.log;

   sendfile        on;
   #tcp_nopush     on;

   #keepalive_timeout  0;
   keepalive_timeout  65;

   #gzip  on;

server {
   listen               *:80;
   server_name          kibana_server;
   access_log           /var/log/nginx/kibana.srv-log-dev.log;
   error_log            /var/log/nginx/kibana.srv-log-dev.error.log;

   location / {
       root   /var/www/kibana;
       index  index.html  index.htm;
   }

   location ~ ^/kibana4/.* {
       proxy_pass           http://kibana4;
       rewrite             ^/kibana4/(.*)  /$1 break;
       proxy_set_header     X-Forwarded-For $proxy_add_x_forwarded_for;
       proxy_set_header     Host            $host;
       auth_basic           "Restricted";
       auth_basic_user_file /etc/nginx/conf.d/kibana.myhost.org.htpasswd;
   }

}
}
```

## BEATS

* `More than one namespace configured accessing ‘output’` 只能有一个输出 elasticsearch 或者看板
* 手动加载模板：`./filebeat setup --template -E output.logstash.enabled=false -E 'output.elasticsearch.hosts=["localhost:9200"]'`
* 设置Kibana dashboards `filebeat setup --dashboards`
* 启动Filebeat:`filebeat -e -c filebeat.yml -d "publish"`

```
# Error creating runner from config: Can only start an input when all related states are finished

curl -XGET 'http://localhost:9200/filebeat-*/_search?pretty'
```

## metrics

* logstash:日志收集、分析、过滤。部署在客户端比较重
* 轻量级的filebeat

```sh
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.1.1-darwin-x86_64.tar.gz
tar xzvf filebeat-7.1.1-darwin-x86_64.tar.gz
cd filebeat-7.1.1-darwin-x86_64/

curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.6.1-amd64.deb

# filebeat.yml
Copy snippet
output.elasticsearch:
  hosts: ["<es_url>"]
  username: "elastic"
  password: "<password>"
setup.kibana:
  host: "<kibana_url>"
./filebeat modules enable redis

./filebeat setup
./filebeat -e # ./filebeat -e -c /home/elk/filebeat/filebeat.yml
```

## X-Pack

keyword类型是不会分词的，直接根据字符串内容建立反向索引
text类型在存入elasticsearch的时候，会先分词，然后根据分词后的内容建立反向索引

## API

## 分布式

* 对数据进行切分，同时每一个分片会保存多个副本
* 节点是对等的，节点间会通过自己的一些规则选取集群的master，master会负责集群状态信息的改变，并同步给其他节点
* 只有建立索引和类型需要经过master，数据的写入有一个简单的routing规则，可以route到集群中的任意节点，所以数据写入压力是分散在整个集群的

## ES VS Solr

* 接口
  - 类似webservice的接口
  - REST风格的访问接口
* 分布式存储
  - solrCloud solr4.x才支持
  - es是为分布式而生的
* 支持的格式
  - solr xml json
  - es json
* 近实时搜索

## [deviantony/docker-elk](https://github.com/deviantony/docker-elk)

The ELK stack powered by Docker and Compose.

```sh
docker run -p 5601:5601 -p 9200:9200 -p 5044:5044 -it --name elk sebp/elk
```

## 问题

```
#  commit_memory(0x0000000085330000, 2060255232, 0) failed; error='Cannot allocate memory' (errno=12)
# 调高虚拟机本身内存到1G
# 修改 vim config/jvm.options
-Xms512m
-Xmx512m

Exiting: Couldn't connect to any of the configured Elasticsearch hosts. Errors: [Error connection to Elasticsearch http://localhost:9200: Connection marked as failed because the onConnect callback failed: cannot retrieve the elasticsearch license from the /_xpack endpoint, Filebeat requires the default distribution of Elasticsearch. Please make the endpoint accessible to Filebeat so it can verify the license.: could not retrieve the license information from the cluster: 503 Service Unavailable: {"error":{"root_cause":[{"type":"master_not_discovered_exception","reason":null}],"type":"master_not_discovered_exception","reason":null},"status":503}]

# [FORBIDDEN/12/index read-only / allow delete (api)] - read only elasticsearch indices
curl -XPUT -H "Content-Type: application/json" http://localhost:9200/_all/_settings -d '{"index.blocks.read_only_allow_delete": null}'
# free up disk space
curl -XPUT -H "Content-Type: application/json" http://[YOUR_ELASTICSEARCH_ENDPOINT]:9200/_all/_settings -d '{"index.blocks.read_only_allow_delete": null}'

# sudo filebeat setup   Overwriting ILM policy is disabled. Set `setup.ilm.overwrite:true` for enabling.

setup.ilm.enabled: false
setup.ilm.check_exists: false
setup.ilm.overwrite: true
```

## 图书

* [ELK Stack权威指南](http://product.china-pub.com/64005)

## 工具

* 分词
  - [medcl/elasticsearch-analysis-ik](https://github.com/medcl/elasticsearch-analysis-ik):The IK Analysis plugin integrates Lucene IK analyzer into elasticsearch, support customized dictionary.
    + `./bin/elasticsearch-plugin install https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v5.5.1/elasticsearch-analysis-ik-5.5.1.zip`
* client
  - [elastic/elasticsearch-js](https://github.com/elastic/elasticsearch-js):Official Elasticsearch client library for Node.js and the browser
* admin
  - [elastic/beats](https://github.com/elastic/beats):🐠 Beats - Lightweight shippers for Elasticsearch & Logstash https://www.elastic.co/products/beats
  - [elastic/kibana](https://github.com/elastic/kibana):📊 Kibana analytics and search dashboard for Elasticsearch https://www.elastic.co/products/kibana
  - [ElasticHQ / elasticsearch-HQ](https://github.com/ElasticHQ/elasticsearch-HQ):Monitoring and Management Web Application for ElasticSearch instances and clusters. http://www.elastichq.org
* sync
  - [siddontang/go-mysql-elasticsearch](https://github.com/siddontang/go-mysql-elasticsearch):Sync MySQL data into elasticsearch
* [Elasticsearch的开源分发包](https://opendistro.github.io/for-elasticsearch/)
* [Yelp/elastalert](https://github.com/Yelp/elastalert):Easy & Flexible Alerting With ElasticSearch https://elastalert.readthedocs.org
* UI
  - [appbaseio/dejavu](https://github.com/appbaseio/dejavu):The Missing Web UI for Elasticsearch: Import, browse and edit data with rich filters and query views, create search UIs visually. https://opensource.appbase.io/dejavu/
* [deviantony / docker-elk](https://github.com/deviantony/docker-elk):The Elastic stack (ELK) powered by Docker and Compose.

## 参考

* [Elasticsearch 5.4 中文文档](http://cwiki.apachecn.org/pages/viewpage.action?pageId=4260364)
* [elastic/elasticsearch-definitive-guide](https://github.com/elastic/elasticsearch-definitive-guide):The Definitive Guide to Elasticsearch https://www.elastic.co/guide/en/elasticsearch/guide/current/index.html
* [Elasticsearch 权威指南](https://fuxiaopang.gitbooks.io/learnelasticsearch/)
* [Kibana User Guide](https://www.elastic.co/guide/en/kibana/current/index.html)
