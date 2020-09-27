# [elastic/elasticsearch](https://github.com/elastic/elasticsearch)

Open Source, Distributed, RESTful Search Engine，一个基于Lucene的实时的分布式搜索和分析全文搜索引擎

* 基于RESTful接口
* 面向文档型数据库，一条数据就是一个文档，用JSON作为文档序列化的格式
* 场景
  - 一个分布式的实时文档存储，每个字段可以被索引与搜索
  - Json文档数据库：相对于MongoDB，读写性能更佳，而且支持更丰富的地理位置查询以及数字、文本的混合查询等
  - 时序数据分析处理：日志处理、监控数据的存储、分析和可视化方面做得非常好
  - 一个分布式实时分析搜索引擎
  - 能胜任上百个服务节点的扩展，并支持 PB 级别的结构化或者非结构化数据
* 特点
  - 通过数据分片技术，分区存储数据。（水平分表）
  - 通过副本技术冗余保存数据，es副本可以提供查询（读写分离）
  - 分片有自我调配能力，主分片挂掉，副本选举为主分片，可以跨node存储。（分库分表、高性能弹性扩容）
  - 主分片和副本分片数据同步es内部提供机制。（可配置异步、同步）
  - 当节点变更或故障，带来主分片、副本分片的调配恢复，es主节点完成管理，节点恢复，自动恢复同步数据。（高可用、容错、恢复）

## 安装

* 安装 Java8 环境
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

# ubuntu
curl -L -O https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.5.1-amd64.deb
sudo dpkg -i elasticsearch-7.5.1-amd64.deb

wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt-get install apt-transport-https
sudo apt-get update && sudo apt-get install elasticsearch
sudo service elasticsearch start

brew install elasticsearch # http://localhost:9200

cd elasticsearch-5.5.2/
# 安装web集群管理插件,在plugin文件发现一个head
./plugin  -install mobz/elasticsearch-head

# 开启服务 默认9200端口运行
./bin/elasticsearch
./elasticsearch  -Des.insecure.allow.root=true  #加这个参数才可以root启动
./bin/elasticsearch -d -p pid # 后台运行
```

## 配置

* 默认情况下只允许本机访问,修改 elasticsearch.yml 文件，去掉network.host的注释，值改成 0.0.0.0，然后重启 Elastic

```sh
# /etc/elasticsearch/elasticsearch.yml
network.host: localhost

sudo ufw allow from 198.51.100.0 to any port 9200
sudo ufw enable
# web地址  http://192.168.88.250:9200/_plugin/head/
```

## Lucene

* 一个工具包，不是一个完整的全文检索引擎
* 目的:为软件开发人员提供一个简单易用的工具包，以方便的在目标系统中实现全文检索的功能，或者是以此为基础建立起完整的全文检索引擎
* 以 Lucene 为基础建立的开源可用全文搜索引擎主要是 Solr 和 Elasticsearch
* 倒排索引
  * 通过分词器将每个文档内容域拆分成单独的词（词条或 Term），创建一个包含所有不重复词条的排序列表，然后列出每个词条出现在哪个文档.由属性值来确定记录的位置的结构就是倒排索引
  - 关键词到文档 ID 的映射，每个关键词都对应着一系列文件，这些文件中都出现了关键词
  - 倒排索引中词项根据字典顺序升序排列
- 术语
  * 词条（Term）:索引里面最小的存储和查询单元，对于英文来说是一个单词，对于中文来说一般指分词后的一个词。
  - 词典（Term Dictionary）：或字典，是词条 Term 的集合。搜索引擎的通常索引单位是单词，单词词典是由文档集合中出现过的所有单词构成的字符串集合，单词词典内每条索引项记载单词本身的一些信息以及指向“倒排列表”的指针。
  - 倒排表（Post list）：一个文档通常由多个词组成，倒排表记录的是某个词在哪些文档里出现过以及出现的位置。每条记录称为一个倒排项（Posting）。倒排表记录的不单是文档编号，还存储了词频等信息。
  - **倒排文件（Inverted File）：**所有单词的倒排列表往往顺序地存储在磁盘的某个文件里，这个文件被称之为倒排文件，倒排文件是存储倒排索引的物理文件

## 概念

* 将非结构化数据中一部分信息提取出来，重新组织，使其变得有一定结构，然后对此有一定结构的数据进行搜索，从而达到搜索相对较快的目的
* ES 使用 Java 编写的一种开源搜索引擎，在内部使用 Lucene 做索引与搜索，通过对 Lucene 封装隐藏了 Lucene 的复杂性，取而代之的提供一套简单一致的 RESTful API
* 对应关系
  - 关系数据库：表 ⇒ 行 ⇒ 列(Columns) schema SQL
  - Elasticsearch：索引 ⇒ 类型 ⇒ 文档 ⇒ 字段(Fields) mapping DSL
  - 索引和文档偏向于逻辑概念，节点和分片偏向于物理上概念
* 文档（Document）：Index 里面单条的记录称为 Document（文档），所有可搜索数据的最小单位
  - 理解为关系型数据库中的一条记录
  - 在 ES 中文档会被序列化成 JSON 格式，保存在 ES 中，JSON 对象由字段组成，其中每个字段都有对应的字段类型（字符串/数组/布尔/日期/二进制/范围类型），ES 中数据还支持数组和嵌套
  - 每个文档都有一个 Unique ID，可以自己指定 ID 或者通过 ES 自动生成
  - 同一个 Index 里面的 Document，不要求有相同的结构（scheme），但是最好保持相同，这样有利于提高搜索效率
* 索引（Index）
  - 逻辑概念
  - 每一个索引都是自己的 Mapping 定义文件，用来去描述去包含文档字段的类型，保存在master主节点，可以去为它设置 Mapping 和 Setting
    + Mapping 定义的是索引当中所有文档字段的类型结构
    + Setting 主要是指定要用多少的分片以及数据是怎么样进行分布的。
  - Elastic 会索引所有字段，经过处理后写入一个反向索引（Inverted Index）,查找数据的时候，直接查找该索引
  - Elastic 数据管理的顶层单位就叫做 Index（索引）,它是单个数据库的同义词
  - 索引有一个名称，名字必须是小写
  - 相似结构文档的集合，每个文档都有一个对应的文档 ID，文档内容被表示为一系列关键词的集合。例如，文档 1 经过分词，提取了 20 个关键词，每个关键词都会记录它在文档中出现的次数和出现位置
* 节点 Node
  - 物理概念，一个运行的Elasticearch实例，本质上是一个 Java 进程，一般建议一台机器上只运行一个 ES 实例
  - 每一个节点都有自己的名字，通过配置文件进行配置，或者启动的时候 -E node.name=node1 指定。每一个节点在启动之后，会分配一个 UID，保存在 data 目录下
  - 默认节点会去加入一个名称为 elasticsearch 的集群，如果直接启动很多节点，那么它们会自动组成一个 elasticsearch 集群，当然一个节点也可以组成一个 elasticsearch 集群
  - 候选主节点 Master-eligible Node 每一个节点启动后，默认就是一个 Master-eligible 节点，可以通过在配置文件中设置 node.master: false 禁止，Master-eligible 节点可以参加选主流程，成为 Master 节点。当第一个节点启动时候，它会将自己选举成 Master 节点
  - 每个节点上都保存了集群的状态，只有 Master 节点才能修改集群的状态信息
  - 主节点（master node）:只参与元数据管理，整个集群只有一个唯一主节点，多个主节点会参与竞选为唯一主节点
    + 有多台保证高可用
    + 选举机制保证主节点只能有一台运行时管理集群
  - 数据节点（data node）:负责保存分片上存储的所有数据，当集群无法保存现有数据的时候，可以通过增加数据节点来解决存储上的问题，在数据扩展上有至关重要的作用，完成本节点数据查询的功能
  - 协调节点 Coordinating Node 或客户端节点（client node）：数据分片到不同datanode后，分布式查询分为：查询阶段+取回阶段。该节点接受客户端请求并路由到各datanode完成数据查询，在协调节点完成数据合并取回阶段的功能。每个节点默认都起到了 Coordinating Node 的职责
  - 冷热节点（Hot & Warm Node） ：热节点（Hot Node）就是配置高的节点，可以有更好的磁盘吞吐量和更好的 CPU，那冷节点（Warm Node）存储一些比较久的节点，这些节点的机器配置会比较低。不同硬件配置的 Data Node，用来实现 Hot & Warm 架构，降低集群部署的成本。
  - 机器学习节点（Machine Learning Node）：负责跑机器学习的工作，用来做异常检测。
  - 部落节点（Tribe Node）：连接到不同的 ES 集群，并且支持将这些集群当成一个单独的集群处理。
  - 预处理节点（Ingest Node）：预处理操作允许在索引文档之前，即写入数据之前，通过事先定义好的一系列的 processors（处理器）和 pipeline（管道），对数据进行某种转换、富化。
  - 配置节点类型：开发环境中一个节点可以承担多种角色。生产环境中，应该设置单一的角色的节点（dedicated node）
* 集群 Cluster
  - 不需要依赖第三方协调管理组件，自身内部就实现了集群的管理功能
  - 一个分布式系统，要满足高可用性
    + 高可用就是当集群中有节点服务停止响应的时候，整个服务还能正常工作，也就是服务可用性
    + 整个集群中有部分节点丢失的情况下，不会有数据丢失，即数据可用性。
  - 当用户的请求量越来越高，数据的增长越来越多的时候，系统需要把数据分散到其他节点上，最后来实现水平扩展。当集群中有节点出现问题的时候，整个集群的服务也不会受到影响。
  - 物理概念，一个集群由一个或多个 Elasticsearch 节点组成，每个节点配置相同的 cluster.name 即可加入集群，默认值为 “elasticsearch”，确保不同的环境中使用不同的集群名称，否则最终会导致节点加入错误的集群。
  - 发现机制：Zen Discovery，通过一个相同的设置 cluster.name 就能将不同的节点连接到同一个集群
    + Zen Discovery 是 Elasticsearch 的内置默认发现模块（发现模块的职责是发现集群中的节点以及选举 Master 节点）。提供单播和基于文件的发现，并且可以扩展为通过插件支持云环境和其他形式的发现
    + Zen Discovery 与其他模块集成，例如，节点之间的所有通信都使用 Transport 模块完成。节点使用发现机制通过 Ping 的方式查找其他节点
    + Elasticsearch 默认被配置为使用单播发现，以防止节点无意中加入集群。只有在同一台机器上运行的节点才会自动组成集群。
    + 如果集群的节点运行在不同的机器上，使用单播，可以为 Elasticsearch 提供一些它应该去尝试连接的节点列表。当一个节点联系到单播列表中的成员时，它就会得到整个集群所有节点的状态，然后它会联系 Master 节点，并加入集群
    + 意味着单播列表不需要包含集群中的所有节点， 它只是需要足够的节点，当一个新节点联系上其中一个并且说上话就可以了
    + 使用 Master 候选节点作为单播列表，只要列出三个就可以了。这个配置在 elasticsearch.yml 文件中：discovery.zen.ping.unicast.hosts: ["host1", "host2:port"].节点启动后先 Ping ，如果 discovery.zen.ping.unicast.hosts 有设置，则 Ping 设置中的 Host ，否则尝试 ping localhost 的几个端口
    + 支持同一个主机启动多个节点，Ping 的 Response 会包含该节点的基本信息以及该节点认为的 Master 节点。
  - 一个 Elasticsearch 服务启动实例就是一个节点（Node）。节点通过 node.name 来设置节点名称，如果不设置则在启动时给节点分配一个随机通用唯一标识符作为名称
  - 不同的集群是通过不同的名字来区分的，默认的名字为 elasticsearch，可以在配置文件中进行修改，或者在命令行中使用 -E cluster.name=wupx 进行设定。
  - 健康程度
    + Green：主分片与副本都正常分配
    + Yellow：主分片全部正常分配，有副本分片未能正常分配
    + Red：有主分片未能分配（例如，当服务器的磁盘容量超过 85% 时，去创建了一个新的索引）
  - 集群状态（Cluster State），维护一个集群中必要的信息，主要包括如下信息：
    + 所有的节点信息
    + 所有的索引和其相关的 Mapping 与 Setting 信息
    + 分片的路由信息
* 分片（Shard）
  - 物理空间的概念，索引中数据分散在分片上
  - 为了支持更大量的数据，索引一般会按某个维度分成多个部分，每个部分就是一个分片，分片被数据节点(dataNode)管理。
  - 一个节点(Node)一般会管理多个分片，这些分片可能是属于同一份索引，也有可能属于不同索引，但是为了可靠性和可用性，同一个索引的分片尽量会分布在不同节点(Node)上
  - 索引与分片的关系
    + 一个 ES 索引包含很多分片，一个分片是一个 Lucene 的索引，它本身就是一个完整的搜索引擎，可以独立执行建立索引和搜索任务。
    + Lucene 索引又由很多分段组成，每个分段都是一个倒排索引。
    + ES 每次 refresh 都会生成一个新的分段，其中包含若干文档的数据。
    + 在每个分段内部，文档的不同字段被单独建立索引。每个字段的值由若干词（Term）组成，Term 是原文本内容经过分词器处理和语言处理后的最终结果
  - 分片有两种
    + 主分片（Primary）：每个索引必须包含1个主分片，也可以多个主分片
      * 按照mysql概念理解的话，一个表=一个index， 这表水平拆分为能n个分表，相当于这个index有n个分片
      * 主分片可以在同一个物理datanode上，也可以在不同datanode，没有强制要求。为了性能，最好分散开来
      * 主要用以解决水平扩展的问题，通过主分片，就可以将数据分布到集群上的所有节点上，一个主分片就是一个运行的 Lucene 实例，当创建 ES 索引的时候，可以指定分片数，但是主**分片数在索引创建时指定，后续不允许修改，除非使用 Reindex 进行修改**，需要提前做好容量规划
    + 副本（Replica）
      * 同一个分片(Shard)的备份数据，一个分片可能会有0个或多个副本，这些副本中的数据保证强一致或最终一致（可配置）
      * **副本分片必须和相同数据的主分片不在同一个datanode，是强制要求**。如果datanode不够，副本分片将不工作。 副本分片不工作，不影响正常数据存储和读取，只是index状态为红色。
      * 用以解决数据高可用的问题，也就是说集群中有节点出现硬件故障的时候，通过副本的方式，也可以保证数据不会产生真正的丢失，因为副本分片是主分片的拷贝，在索引中副本分片数可以动态调整，通过增加副本数，可以在一定程度上提高服务查询的性能（读取的吞吐）
  - 分片设置过大的时候，也会带来副作用，一方面来说会影响搜索结果的打分，影响统计结果的准确性，另外，单个节点上过多的分片，也会导致资源浪费，同时也会影响性能。从 7.0 版本开始，ES 的默认主分片数设置从 5 改为了 1，从这个方面也可以解决 over-sharding 的问题。
* 服务
  - 分布式存储都支持数据分片存储，分片储存需要两阶段查询。查询阶段+结果合并阶段。
  - 分布式存储都支持分片的副本存储，数据写入主分片后，需要同步、异步机制同步数据到副本分片，冗余保存。
  - 数据分片需要有路由规则，内部叫route table，存储在主节点中，作为整个集群元数据一部分。
* type:相当于表结构描述
  - 在 7.0 开始，一个索引只能创建一个 Type，也就是 _doc
  - 每个索引里都可以有一个或多个 Type，Type 是索引中的一个逻辑数据分类，一个 Type 下的文档，都有相同的字段（Field），比如博客系统，有一个索引，可以定义用户数据 Type，博客数据 Type，评论数据 Type 等
  - Document 可以分组，比如weather这个 Index 里面，可以按城市分组（北京和上海），也可以按气候分组（晴天和雨天）。这种分组就叫做 Type，它是虚拟的逻辑分组，用来过滤 Document
  - 类型是通过mapping来定义每个字段的类型
  - 不同的 Type 应该有相似的结构（schema），举例来说，id字段不能在这个组是字符串，在另一个组是数值。这是与关系型数据库的表的一个区别。性质完全不同的数据（比如products和logs）应该存成两个 Index，而不是一个 Index 里面的两个 Type（虽然可以做到）

```sh
# 查看当前节点所有 Index
curl -X GET 'http://localhost:9200/_cat/indices?v'

# 列出每个 Index 所包含的 Type
curl 'localhost:9200/_mapping?pretty=true'

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

* 本质上是一个分布式数据库，允许多台服务器协同工作，每台服务器可以运行多个 Elastic 实例
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
    + es 第一是准实时的，数据写入 1 秒后可以搜索到；可能会丢失数据的。有 5 秒的数据，停留在 buffer、translog os cache、segment file os cache 中，而不在磁盘上，此时如果宕机，会导致 5 秒的数据丢失。
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

## REST API

* 对索引的名字进行通配符查询:GET /_cat/indices/mov*?v&s=index
* GET /_cat/indices?v&s=docs.count:desc，可以按照文档个数排序。
* 使用 GET /_cat/indices?v&health=green，可以查看状态为 green 的索引。
* 使用 GET /_cat/indices?v&h=i,tm&s=tm:desc，可以查看每个索引占用的内存

```sh
# 查看_cat支持信息
kibana: GET /_cat
bash: curl -XGET -u elastic:26tBktGolYCyZD2pPISW 'http://192.168.31.215:9201/_cat'

# 查看集群的节点
http://localhost:9200/_cat/?v

# 查看集群所有节点
kibana: GET /_cat/nodes?v
bash: curl -XGET -u elastic:26tBktGolYCyZD2pPISW 'http://192.168.31.215:9201/_cat/nodes?v'

#  查看集群健康状态
kibana: GET /_cat/health?v
kibana: GET _cluster/health
bash: curl -XGET -u elastic:26tBktGolYCyZD2pPISW 'http://192.168.31.215:9201/_cat/health?v'
bash: curl -XGET -u elastic:26tBktGolYCyZD2pPISW 'http://192.168.31.215:9201/_cluster/health?pretty'

# 查看主节点信息
kibana: GET /_cat/master?v
bash: curl -XGET -u elastic:26tBktGolYCyZD2pPISW 'http://192.168.31.215:9201/_cat/master?v'

# 查看所有索引信息
kibana: GET /_cat/indices?v
bash: curl -XGET -u elastic:26tBktGolYCyZD2pPISW 'http://192.168.31.215:9201/_cat/indices?v'

# 创建一个名为 customer 的索引。pretty要求返回一个漂亮的json 结果
PUT /customer?pretty

# 查看单个索引信息
kibana: GET /_cat/indices/movies?v
bash: curl -XGET -u elastic:26tBktGolYCyZD2pPISW 'http://192.168.31.215:9201/_cat/indices/movies?v'

# 查询所有文档
GET /customer/_search?q=*&sort=name:asc&pretty

# 查看所有索引文档总数
kibana: GET _all/_count
bash: curl -XGET -u elastic:26tBktGolYCyZD2pPISW 'http://192.168.31.215:9201/_all/_count?pretty'

# 查看指定索引文档总数
kibana: GET movies/_count
bash: curl -XGET -u elastic:26tBktGolYCyZD2pPISW 'http://192.168.31.215:9201/movies/_count?pretty'

# 查看所有分片信息
kibana: GET /_cat/shards?v
bash: curl -XGET -u elastic:26tBktGolYCyZD2pPISW 'http://192.168.31.215:9201/_cat/shards?v'

# 查看单个索引分片信息
kibana: GET /_cat/shards/movies?v
bash: curl -XGET -u elastic:26tBktGolYCyZD2pPISW 'http://192.168.31.215:9201/_cat/shards/movies?v'

# 查看插件
kibana: GET /_cat/plugins?v
bash: curl -XGET -u elastic:26tBktGolYCyZD2pPISW 'http://192.168.31.215:9201/_cat/plugins?v'

# 查看所有模板
kibana: GET _cat/templates
bash: curl -XGET -u elastic:26tBktGolYCyZD2pPISW 'http://192.168.31.215:9201/_cat/templates?v'

# 查看状态为绿的索引
kibana: GET /_cat/indices?v&health=green
bash: curl -XGET -u elastic:26tBktGolYCyZD2pPISW 'http://192.168.31.215:9201/_cat/indices?v&health=green'

# 查看movies索引元数据
kibana: GET movies
bash: curl -XGET -u elastic:26tBktGolYCyZD2pPISW 'http://192.168.31.215:9201/movies?pretty'

# 按照文档数量排序索引
kibana: GET _cat/indices?v&s=docs.count:desc
bash: curl -XGET -u elastic:26tBktGolYCyZD2pPISW 'http://192.168.31.215:9201/_cat/indices?v&s=docs.count:desc'

# /查看各个索引占用内存大小并进行排序
kibana:
bash: curl -XGET -u elastic:26tBktGolYCyZD2pPISW 'http://192.168.31.215:9201/_cat/indices?v&h=i,tm&s=tm:desc'

# 索引一个文档到customer索引中
curl -X PUT "localhost:9200/customer/_doc/1?pretty" -H 'Content-Type: application/json' -d'
{
  "name": "John Doe"
}
'
# 从customer索引中获取指定id的文档
curl -X GET "localhost:9200/customer/_doc/1?pretty"
```

## 操作

* URL: `/index_name/_action/document_id`

* 索引

  - PUT|POST   /index/_create/id 指定Document ID，创建文档，如果ID已存在，则失败
  - POST       /index/_doc       自动生成ID，不会重复，重复提交则创建多个文档，文档版本都为1
  - Delete     /index            删除索引，索引内的文档也会被随之而删除,索引不存在返回 "404"

* 文档

  - PUT|POST   /index/_doc/id    如果ID不存在,则创建新的文档,如果ID存在,则删除现有文档后创建新的文档,版本+1,ID相同
  - POST       /index/_update/id    文档必须存在,否则更新失败,只能增量修改字段,不能减少字段,字段值可以随意修改,版本加1（字段扩充）
  - GET        /index/_doc/id    查看Document ID为1的文档
  - Delete     /index/_doc/id 删除文档,否则返回"not_found"

* Bulk API 批量操作，每条语句都会进行返回结果

  - 支持在一次API调用中，对不同索引进行操作
  - 支持四种操作 Index、Create、Update、Delete
  - 可以在 URI 中指定 Index，也可以在请求的 Playoad 中进行
  - 操作中单条语句操作失败，不会影响后续操作
  - 返回结果包含了每一条的执行结果

* mget 批量读取的方式，批量操作，减少了网络连接所产生的开销。提高性能

* msearch Multi Serach：一个可以进行条件匹配查询的语法 GET /<index>/_msearch

  - 从单个API中获取多个搜索结果，请求的格式类似于批量API格式，并使用换行符分隔的JSON（NDJSON）格式。最后一行数据必须以换行符 \n 结尾。每个换行符前面都可以有一个回车符 \r。向此端点发送请求时，Content-Type标头应设置为application/x-ndjson
  - 路径参数：（可选，字符串）索引名称的逗号分隔列表或通配符表达式，用于限制请求
  - 主体
    + aggregations聚合 （可选，对象）指定聚合。
    + from 来自 （可选，整数）起始文档偏移量。预设为0。
    + max_concurrent_searches同时最多查询 （可选，整数）指定多重搜索API将执行的并发搜索的最大数量,此默认值基于数据节点的数量和默认搜索线程池大小。
    + max_concurrent_shard_requests （可选，整数）指定每个子搜索请求将在每个节点上执行的并发分片请求的最大数量。此参数应用于保护单个请求，以防止集群过载（例如，默认请求将命中集群中的所有索引，如果每个节点的分片数量很高，则可能导致分片请求被拒绝）。默认为5。在某些情况下，并发请求无法实现并行性，因此这种保护将导致性能下降。例如，在仅期望很少数量的并发搜索请求的环境中，可能有助于将该值增加到更大的数目。
    + preference （可选，字符串）指定应该对其执行操作的节点或分片。默认为随机。
    + query （可选，查询对象）使用查询DSL定义搜索定义。
    + routing （可选，字符串）以指定的主分片为目标。
    + search_type （可选，字符串）搜索操作的类型。可用选项： `query_then_fetch` `dfs_query_then_fetch`
    + size （可选，整数）要返回的点击数。默认为10。

```
### 创建
## POST|PUT 请求指定 Document ID,id 存在创建失败
POST|PUT /index/_create/1
curl -XPOST -u elastic:26tBktGolYCyZD2pPISW -H "Content-Type:application/json" 'http://192.168.31.215:9201/index/_create/1?pretty' -d '
{
  "name": "WeiLiang Xu",
  "Blogs": "abcops.cn",
  "Is male": true,
  "age": 25
}'

## 自动生成 Document ID
POST /index/_doc
curl -XPOST -u elastic:26tBktGolYCyZD2pPISW -H "Content-Type:application/json" 'http://192.168.31.215:9201/index/_doc?pretty' -d '
{
  "name": "WeiLiang Xu",
  "Blogs": "abcops.cn",
  "Is male": true,
  "age": 25
}‘

### 创建或更新
POST|PUT /index/_doc/6
curl -XPUT -u elastic:26tBktGolYCyZD2pPISW -H "Content-Type:application/json" 'http://192.168.31.215:9201/index/_doc/6?pretty' -d '
{
  "name": "WeiLiang Xu",
  "Blogs": "abcops.cn",
  "Is male": true,
  "age": 25
}'

GET /index/_doc/1                   #操作index索引中Document ID为1的文档
curl -XGET -u elastic:26tBktGolYCyZD2pPISW 'http://192.168.31.215:9201/index/_doc/1?pretty'

### 结构更新
POST /weiliang/_update/1
curl -XPOST -u elastic:26tBktGolYCyZD2pPISW -H "Content-Type:application/json" 'http://192.168.31.215:9201/weiliang/_update/1?pretty' -d '
{
  "doc": {
  "name": ["weiliang Xu","xueiliang"],
  "JobS": "Linux DevOps",
  "Age": 25,
  "gender": "man"
  }
}'

DELETE /weiliang/_doc/1         #删除指定文档
curl -XDELETE -u elastic:26tBktGolYCyZD2pPISW -H "Content-Type:application/json" 'http://192.168.31.215:9201/weiliang/_doc/1?pretty'
DELETE /weiliang                #删除索引
curl -XDELETE -u elastic:26tBktGolYCyZD2pPISW -H "Content-Type:application/json" 'http://192.168.31.215:9201/weiliang?pretty'

POST _bulk
{ "create" : { "_index" : "bulk_index", "_id" : "1" } }             //创建了索引为 bulk_index ，id为1的文档
{ "Job" : "Linux Ops" }                                             //文档内容为字段 "Job" 值 "Linux Ops"
{ "delete" : { "_index" : "bulk_index", "_id" : "2" } }             //删除索引为 bulk_index 中 id 为 2的文档，因为我们暂时还没有 id 为2的文档，所以此次执行返回 not_found，但是不影响后续语句执行
{ "update" : { "_id": "1", "_index" : "bulk_index"  } }             //增量更新了 bulk_index 中 id 为 1 的文档，注意这里的写法是 _id 在前，_index 在后
{ "doc" : {"name" : "xuweiliang"} }
{ "index" : {"_index" : "bulk_index", "_id" : "1" } }               //Index方式操作了 bulk_index 索引的 id 为 1 的文档，把文档内容改了如下
{ "name" : "xuweiliang" }
{ "create" : { "_index" : "bulk_index", "_id" : "2" } }             //在 bulk_index 索引中 创建了一个 id 为 2 的文档
{ "name" : "xuweiliang" , "Age" : 25 }
{ "delete" : { "_index" : "bulk_index", "_id" : "2" } }             //删除了 bulk_index 索引中 id 为 2的文档

GET _mget
{
  "docs":[                                  //docs为mget格式
    {
      "_index": "bulk_index",               //指定要读取文档的索引
      "_id" : 1                             //指定读取文档的ID
    },
    {
      "_index": "bulk_index",               //同一索引内的不同ID联合读取
      "_id" : 2
    },
    {
      "_index": "index",                    //不同索引中的不同ID联合读取
      "_id" : 1
    }
  ]
}

{"index" : "test", "index"}
{"query" : {"match_all" : {}}, "from" : 0, "size" : 10}

{"index" : "test", "search_type" : "dfs_query_then_fetch"}
{"query" : {"match_all" : {}}}

{}
{"query" : {"match_all" : {}}}

{"query" : {"match_all" : {}}}
{"search_type" : "dfs_query_then_fetch"}

{"query" : {"match_all" : {}}}
```

## 聚合 Aggregation

* 进行统计分析功能
* 特点
  - 实时性高:所有计算结果都是即时返回
  - 性能高:得到一个数据的概览，是分析和总结全套的数据
* 分类
  - Bucket Aggregation：分桶类型，按照一定的规则将文档分配到不同的桶中，达到分类分析的目的
    + 说相当于 SQL 中的 GROUP，可以根据条件，把结果分成一个一个的组
    + Terms：直接按照 term 来分桶，如果是 text 类型，则按照分词后的结果分桶
    + Range：指定数值的范围来设定分桶规则
    + Date Range：指定日期的范围来设定分桶规则
    + Histogram：直方图，以固定间隔的策略来分割数据
    + Date Histogram：针对日期的直方图或者柱状图，是时序数据分析中常用的聚合分析类型
  - Metric Aggregation：指标分析类型，一些数学运算，可以对文档字段进行统计分析，比如计算最大值、最小值、平均值等
    + 相当于 SQL 中的 COUNT，可以去执行一系列的统计方法
    + 单值分析
      * Min、Max、Avg、Sum
      * Cardinality：指不同数值的个数，相当于 SQL 中的 distinct
    + 多值分析
      * Stats 做多样的数据分析，可以一次性得到最大值、最小值、平均值、中值等数据
      * Extended Stats 对 Stats 的扩展，包含了更多的统计数据，比如方差、标准差等
      * Percentiles、Percentile Ranks：百分位数的一个统计
      * Top Hits：用于分桶后获取桶内最匹配的顶部文档列表，即详情数据
        +
  - Pipeline Aggregation：管道分析类型，对其他聚合结果进行二次聚合
  - Matrix Aggregation：矩阵分析类型，支持对多个字段的操作并提供一个结果矩阵

## Search API

* URI Search：用 HTTP GET 的方式在 URL 中使用查询参数已达到查询的目的
  - GET /users/_search?q=username:wupx
    + q 指定查询语句，语法为 Query String Syntax，是 KV 键值对的形式
    + df：默认字段，不指定时会对所有字段进行查询
    + sort：根据字段名排序
    + from：返回的索引匹配结果的开始值，默认为 0
    + size：搜索结果返回的条数，默认为 10
    + timeout：超时的时间设置
    + fields：只返回索引中指定的列，多个列中间用逗号分开
    + analyzer：当分析查询字符串的时候使用的分词器
    + analyze_wildcard：通配符或者前缀查询是否被分析，默认为 false
    + explain：在每个返回结果中，将包含评分机制的解释
    + _source：是否包含元数据，同时支持 _source_includes 和 _source_excludes
    + lenient：若设置为 true，字段类型转换失败的时候将被忽略，默认为 false
    + default_operator：默认多个条件的关系，AND 或者 OR，默认为 OR
    + search_type：搜索的类型，可以为 dfs_query_then_fetch 或 query_then_fetch，默认为 query_then_fetch
  - Term Query
    + GET /movies/_search?q=title:(Beautiful Mind)：查询 title 中包括 Beautiful 或者 Mind
    + Beautiful Mind 等效于 Beautiful OR Mind
    + "Beautiful Mind"等效于 Beautiful AND Mind，另外还要求前后顺序保存一致
  - Phrase Query
    + 用引号包起来，请求为 GET /movies/_search?q=title:"Beautiful Mind"
  - 布尔操作
    + GET /movies/_search?q=title:(Beautiful NOT Mind)，这个请求表示查询 title 中必须包括 Beautiful 不能包括 Mind 的文档
  - 范围查询和数学运算符号，比如指定电影的年份大于 1994：GET /movies/_search?q=year:>=1994
  - 通配符查询（查询效率低，占用内存大，不建议使用，特别是放在最前面），还支持正则表达式，以及模糊匹配和近似查询
  - URI Search 好处就是操作简单，只要写个 URI 就可以了，方便测试，但是 URI Search 只包含一部分查询语法，不能覆盖所有 ES 支持的查询语法
* Request Body Search：用 ES 提供的基于 JSON 格式的格式更加完备的查询语言 Query DSL（Domain Specific Language）
  - 支持 GET 和 POST 方式对索引进行查询，需要指定操作的索引名称，同样也要通过 _search 来标明这个请求为搜索请求
  - 脚本字段可以使用 ES 中的 painless 的脚本去算出一个新的字段结果。
  - Match Query:在 query match 的方式把信息填在里面
    + 查询两者同时出现，可以通过加 "operator": "and" 来实现
  - Match Phrase 查询，但在 query 条件中的词必须顺序出现的，可以通过 slop 参数控制单词间的间隔，比如加上 "slop" :1，表示中间可以有一个其他的字符
  - Term Query:将查询语句作为整个单词进行查询
  - Query String 查询:指定默认查询的字段名 default_field 就和前面介绍的 df 是一样的，在 query 中也可以使用 AND 来实现一个与的操作
  - Simple Query String Query，它其实和 Query String 类似，但是会忽略错误的查询语法，同时只支持部分查询语法，不支持 AND OR NOT，会当作字符串处理，Term 之间默认的关系是 OR，可以指定 default_operator 来实现 AND 或者 OR，支持用 + 替代 AND，用 | 替代 OR，用 - 替代 NOT
* Response
  - 概念
    + 在搜索结果中，黄色的三角形起名为 False Positive（纳伪，简写 fp），通常称作误报，绿色的圆起名为 True Positive（纳真，简写 tp）
    + 在没有被搜索到的范围中，绿色的圆的起名为 False Negatives（去真，简写 fn），也常称作漏报，黄色的三角形起名为 True Negative（去伪，简写 tn）
  - 相关性（Relevance）:
    + 查准率（Precision），具体含义是尽可能返回较少的无关文档给用户 正确的搜索结果除以全部返回的结果，即 Precision = tp / ( tp + fp )
    + 查全率（Recall），也就是尽量返回较多的相关文档 正确的搜索结果除以所有应该返回的结果，即 Recall = tp / ( tp + fn )
    + 是否能够按照相关度进行排序（Ranking）

```
POST /movies/_search
{
  "from":10,
  "size":20,
  "_source":["title"],
  "sort":[{"year":"desc"}],
  "script_fields": {
    "new_field": {
      "script": {
        "lang": "painless",
        "source": "doc['year'].value+'_hello'"
      }
    }
  },
  "query":{
    "match_all": {}
  }
}

POST /users/_search
{
  "query": {
    "match": {
      "title": "wupx huxy"
      "operator": "and"
    }
  }
}

POST /movies/_search
{
  "query": {
    "match_phrase": {
      "title":{
        "query": "one love"
        "slop":1
      }
    }
  }
}

POST /users/_search
{
  "query": {
      "username": [
        "wupx",
        "huxy"
      ]
  }
}


POST users/_search
{
  "query": {
    "query_string": {
      "default_field": "username",
      "query": "wupx AND huxy"
    }
  }
}

{
  "query": {
    "simple_query_string": {
      "query": "wu px",
      "fields": ["username"],
      "default_operator": "AND"
    }
  }
}
```

## 性能

* filesystem cache:查询的时候，操作系统会将磁盘文件里的数据自动缓存到 filesystem cache 里面去
  - es 的搜索引擎严重依赖于底层的 filesystem cache，如果给 filesystem cache 更多的内存，尽量让内存可以容纳所有的 idx segment file 索引数据文件，那么搜索的时候就基本都是走内存的，性能会非常高

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

## [ElasticSearch Operator 工作原理浅析](https://mp.weixin.qq.com/s/0ydcQthxAE_yWnQAjnIIOA)

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

* 汉化
  - 7.0 版本之后，官方自带汉化资源文件（位于 Kibana 目录下的 node_modules/x-pack/plugins/translations/translations/）
  - 在 config 目录下修改 kibana.yml 文件，在文件中加上配置项 i18n.locale: "zh-CN"，然后重新启动 Kibana 就汉化完成

```
# 搭建
wget https://artifacts.elastic.co/downloads/kibana/kibana-7.1.1-darwin-x86_64.tar.gz # http://localhost:5601
tar xf kibana-4.3.1-linux-x64.tar.gz
cd /usr/local/kibana-4.3.1-linux-x64/

# ./config/kibana.yml
elasticsearch.url: #   只需要修改URL为ElasticSearch的IP地址

./kibana&
# 启动成功以后 会监听 5601端口

# 可以用Kibana查看 地址 : 192.168.88.250:5601
# create灰色的 说明没有创建索引  打开你的nginx服务器 刷新几下 采集一下数据 然后  选择 左上角的 Discover
# 数据可能会出不来 那是因为 Kibana 是根据时间来匹配的 并且 因为 Logstash的采集时间使用的UTC  永远早8个小时 所以设置时间 要设置晚8个小时以后

echo "kibanaadmin:`openssl passwd -apr1`" | sudo tee -a /etc/nginx/htpasswd.users
kibanaadmin:$apr1$M2kx248q$TRbbkejn8bxFsdztudF6Z0
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

* keyword类型是不会分词的，直接根据字符串内容建立反向索引
* text类型在存入elasticsearch的时候，会先分词，然后根据分词后的内容建立反向索引

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

## 优化

* 磁盘 I/O
  - 使用 SSD，比机械磁盘优秀多了
  - 使用 RAID 0。条带化 RAID 会提高磁盘 I/O，代价显然就是当一块硬盘故障时整个就故障了。不要使用镜像或者奇偶校验 RAID 因为副本已经提供了这个功能。
  - 使用多块硬盘，并允许 Elasticsearch 通过多个 path.data 目录配置把数据条带化分配到它们上面。
  - 不要使用远程挂载的存储，比如 NFS 或者 SMB/CIFS。这个引入的延迟对性能来说完全是背道而驰的。
  - 如果用的是 EC2，当心 EBS。即便是基于 SSD 的 EBS，通常也比本地实例的存储要慢。
* 内部索引
  - Term 太多，有了 Term Index。包含的是 Term 的一些前缀。通过 Term Index 可以快速地定位到 Term Dictionary 的某个 Offset，然后从这个位置再往后顺序查找
  - 包含的是 Term 的一些前缀。通过 Term Index 可以快速地定位到 Term Dictionary 的某个 Offset，然后从这个位置再往后顺序查找
* 调整配置参数
  - 给每个文档指定有序的具有压缩良好的序列模式 ID，避免随机的 UUID-4 这样的 ID，这样的 ID 压缩比很低，会明显拖慢 Lucene。
  - 对于那些不需要聚合和排序的索引字段禁用 Doc values。Doc Values 是有序的基于 document=>field value 的映射列表。
  - 不需要做模糊检索的字段使用 Keyword 类型代替 Text 类型，这样可以避免在建立索引前对这些文本进行分词。
  - 如果搜索结果不需要近实时的准确度，考虑把每个索引的 index.refresh_interval 改到 30s 。
  - 如果在做大批量导入，导入期间可以通过设置这个值为 -1 关掉刷新，还可以通过设置 index.number_of_replicas: 0 关闭副本。别忘记在完工的时候重新开启它。
  - 避免深度分页查询建议使用 Scroll 进行分页查询。普通分页查询时，会创建一个 from+size 的空优先队列，每个分片会返回 from+size 条数据，默认只包含文档 ID 和得分 Score 给协调节点。
  - 如果有 N 个分片，则协调节点再对（from+size）×n 条数据进行二次排序，然后选择需要被取回的文档。当 from 很大时，排序过程会变得很沉重，占用 CPU 资源严重。
  - 减少映射字段，只提供需要检索，聚合或排序的字段。其他字段可存在其他存储设备上，例如 Hbase，在 ES 中得到结果后再去 Hbase 查询这些字段。创建索引和查询时指定路由 Routing 值，这样可以精确到具体的分片查询，提升查询效率。路由的选择需要注意数据的分布均衡。
* JVM 调优
  - 确保堆内存最小值（ Xms ）与最大值（ Xmx ）的大小是相同的，防止程序在运行时改变堆内存大小。Elasticsearch 默认安装后设置的堆内存是 1GB。可通过 ../config/jvm.option 文件进行配置，但是最好不要超过物理内存的50%和超过 32GB。
  - GC 默认采用 CMS 的方式，并发但是有 STW 的问题，可以考虑使用 G1 收集器。
  - ES 非常依赖文件系统缓存（Filesystem Cache），快速搜索。一般来说，应该至少确保物理上有一半的可用内存分配到文件系统缓存

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
  - [ElasticHD](https://github.com/360EntSecGroup-Skylar/ElasticHDv):支持 ES监控、实时搜索、Index template快捷替换修改、索引列表信息查看， SQL converts to DSL工具
  - [elasticsearch-head](https://github.com/mobz/elasticsearch-head):用于监控 Elasticsearch 状态的客户端插件，包括数据可视化、执行增删改查操作等
* [deviantony / docker-elk](https://github.com/deviantony/docker-elk):The Elastic stack (ELK) powered by Docker and Compose.

## 参考

* [Elasticsearch 5.4 中文文档](http://cwiki.apachecn.org/pages/viewpage.action?pageId=4260364)
* [elastic/elasticsearch-definitive-guide](https://github.com/elastic/elasticsearch-definitive-guide):The Definitive Guide to Elasticsearch https://www.elastic.co/guide/en/elasticsearch/guide/current/index.html
* [Elasticsearch 权威指南](https://fuxiaopang.gitbooks.io/learnelasticsearch/)
* [Kibana User Guide](https://www.elastic.co/guide/en/kibana/current/index.html)
* [SpringBoot 操作 ElasticSearch 详解](https://mp.weixin.qq.com/s/qDbaDDDIJ81u8JY8CQJCTQ)
