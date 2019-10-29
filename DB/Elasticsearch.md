# [elastic/elasticsearch](https://github.com/elastic/elasticsearch)

Open Source, Distributed, RESTful Search Engine，一个基于Lucene的实时的分布式搜索和分析全文搜索引擎

* 设计用于云计算中，能够达到实时搜索，稳定，可靠，快速，安装使用方便
* 基于RESTful接口。普通请求是...get?a=1；rest请求....get/a/1 可以快速地储存、搜索和分析海量数据
* 面向文档型数据库，一条数据在这里就是一个文档，用JSON作为文档序列化的格式

## 安装

* 安装Java8 环境
* Mac
  - Data:    /usr/local/var/elasticsearch/elasticsearch_henry/
  - Logs:    /usr/local/var/log/elasticsearch/elasticsearch_henry.log
  - Plugins: /usr/local/opt/elasticsearch/libexec/plugins/
  - Config:  /usr/local/etc/elasticsearch/
  - plugin script: /usr/local/opt/elasticsearch/libexec/bin/elasticsearch-plugin

```sh
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.5.2.zip
unzip elasticsearch-5.5.2.zip
cd elasticsearch-5.5.2/
# 开启服务，默认的9200端口运行
./bin/elasticsearch
# 后台运行
./bin/elasticsearch -d -p pid
# 开启另一端开口,返回一个 JSON 对象，包含当前节点、集群、版本等信息
curl localhost:9200

# ubuntu
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt-get install apt-transport-https
sudo apt-get update && sudo apt-get install elasticsearch
sudo service elasticsearch start

curl -XGET 'localhost:9200/_cat/health?v&pretty'
```

## 原理

* 分布式实时文件存储，并将每一个字段都编入索引，使其可以被搜索
* 实时分析的分布式搜索引擎
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
  - 将磁盘里的东西尽量搬进内存，减少磁盘随机读取次数(同时也利用磁盘顺序读特性)，结合各种压缩算法，用及其苛刻的态度使用内存
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

## 概念

* node和cluster
  - Elastic 本质上是一个分布式数据库，允许多台服务器协同工作，每台服务器可以运行多个 Elastic 实例
  - 单个 Elastic 实例称为一个节点（node）
  - 一组节点构成一个集群（cluster）
* 对应关系
  - 关系数据库 ⇒ 数据库 ⇒ 表 ⇒ 行 ⇒ 列(Columns)
  - Elasticsearch ⇒ 索引 ⇒ 类型 ⇒ 文档 ⇒ 字段(Fields)
* index
  - Elastic 会索引所有字段，经过处理后写入一个反向索引（Inverted Index）,查找数据的时候，直接查找该索引
  - Elastic 数据管理的顶层单位就叫做 Index（索引）,它是单个数据库的同义词
  - 每个 Index （即数据库）的名字必须是小写
* type
  - Document 可以分组，比如weather这个 Index 里面，可以按城市分组（北京和上海），也可以按气候分组（晴天和雨天）。这种分组就叫做 Type，它是虚拟的逻辑分组，用来过滤 Document
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

## 配置

* 默认情况下，Elastic 只允许本机访问，如果需要远程访问，可以修改 Elastic 安装目录的config/elasticsearch.yml文件，去掉network.host的注释，将它的值改成0.0.0.0，然后重新启动 Elastic

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

## 问题

```
#  commit_memory(0x0000000085330000, 2060255232, 0) failed; error='Cannot allocate memory' (errno=12)
# 调高虚拟机本身内存到1G
# 修改 vim config/jvm.options
-Xms512m
-Xmx512m
```

## 工具

* 分词
  - [medcl/elasticsearch-analysis-ik](https://github.com/medcl/elasticsearch-analysis-ik):The IK Analysis plugin integrates Lucene IK analyzer into elasticsearch, support customized dictionary.
    + `./bin/elasticsearch-plugin install https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v5.5.1/elasticsearch-analysis-ik-5.5.1.zip`
* client
  - [elastic/elasticsearch-js](https://github.com/elastic/elasticsearch-js):Official Elasticsearch client library for Node.js and the browser
* admin
  - [elastic/beats](https://github.com/elastic/beats):🐠 Beats - Lightweight shippers for Elasticsearch & Logstash https://www.elastic.co/products/beats
  - [elastic/kibana](https://github.com/elastic/kibana):📊 Kibana analytics and search dashboard for Elasticsearch https://www.elastic.co/products/kibana
* sync
  - [siddontang/go-mysql-elasticsearch](https://github.com/siddontang/go-mysql-elasticsearch):Sync MySQL data into elasticsearch
* [Elasticsearch的开源分发包](https://opendistro.github.io/for-elasticsearch/)
* [Yelp/elastalert](https://github.com/Yelp/elastalert):Easy & Flexible Alerting With ElasticSearch https://elastalert.readthedocs.org
* UI
  - [appbaseio/dejavu](https://github.com/appbaseio/dejavu):The Missing Web UI for Elasticsearch: Import, browse and edit data with rich filters and query views, create search UIs visually. https://opensource.appbase.io/dejavu/

## 参考

* [Elasticsearch 5.4 中文文档](http://cwiki.apachecn.org/pages/viewpage.action?pageId=4260364)
* [elastic/elasticsearch-definitive-guide](https://github.com/elastic/elasticsearch-definitive-guide):The Definitive Guide to Elasticsearch https://www.elastic.co/guide/en/elasticsearch/guide/current/index.html
* [Elasticsearch 权威指南](https://fuxiaopang.gitbooks.io/learnelasticsearch/)
