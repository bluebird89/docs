# Elasticserach

全文搜索属于最常见的需求，开源的 Elasticsearch （以下简称 Elastic）是一个基于Lucene的实时的分布式搜索和分析全文搜索引擎的首选。设计用于云计算中，能够达到实时搜索，稳定，可靠，快速，安装使用方便。基于RESTful接口。普通请求是...get?a=1；rest请求....get/a/1 它可以快速地储存、搜索和分析海量数据。维基百科、Stack Overflow、Github 都采用它。Elastic 的底层是开源库 Lucene。但是，你没法直接用 Lucene，必须自己写代码去调用它的接口。Elastic 是 Lucene 的封装，提供了 REST API 的操作接口，开箱即用。

## ES VS Solr

– 接口

- 类似webservice的接口
- REST风格的访问接口

– 分布式存储

- solrCloud solr4.x才支持
- es是为分布式而生的

– 支持的格式

- solr xml json
- es json

– 近实时搜索

## 安装

安装Java8 环境

```sh
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.5.2.zip
unzip elasticsearch-5.5.2.zip
cd elasticsearch-5.5.2/
# 开启服务，默认的9200端口运行
./bin/elasticsearch
# 后台运行
./bin/elasticsearch -d -p pid
开启另一端开口,返回一个 JSON 对象，包含当前节点、集群、版本等信息
curl localhost:9200
```

- 问题： commit_memory(0x0000000085330000, 2060255232, 0) failed; error='Cannot allocate memory' (errno=12)

  ```
  # 调高虚拟机本身内存到1G
  # 修改 vim config/jvm.options
  -Xms512m
  -Xmx512m
  ```

### Mac

* Data:    /usr/local/var/elasticsearch/elasticsearch_henry/
* Logs:    /usr/local/var/log/elasticsearch/elasticsearch_henry.log
* Plugins: /usr/local/opt/elasticsearch/libexec/plugins/
* Config:  /usr/local/etc/elasticsearch/
* plugin script: /usr/local/opt/elasticsearch/libexec/bin/elasticsearch-plugin

## 权限

默认情况下，Elastic 只允许本机访问，如果需要远程访问，可以修改 Elastic 安装目录的config/elasticsearch.yml文件，去掉network.host的注释，将它的值改成0.0.0.0，然后重新启动 Elastic。(不要顶格写首字母前面加一空格，冒号后面要加一个空格)

## 概念

* node和cluster：Elastic 本质上是一个分布式数据库，允许多台服务器协同工作，每台服务器可以运行多个 Elastic 实例。 单个 Elastic 实例称为一个节点（node）。一组节点构成一个集群（cluster）。
* index：Elastic 会索引所有字段，经过处理后写入一个反向索引（Inverted Index）。查找数据的时候，直接查找该索引。 所以，Elastic 数据管理的顶层单位就叫做 Index（索引）。它是单个数据库的同义词。每个 Index （即数据库）的名字必须是小写。
* document：Index 里面单条的记录称为 Document（文档）。许多条 Document 构成了一个 Index。 Document 使用 JSON 格式表示，同一个 Index 里面的 Document，不要求有相同的结构（scheme），但是最好保持相同，这样有利于提高搜索效率。
* type：Document 可以分组，比如weather这个 Index 里面，可以按城市分组（北京和上海），也可以按气候分组（晴天和雨天）。这种分组就叫做 Type，它是虚拟的逻辑分组，用来过滤 Document。 不同的 Type 应该有相似的结构（schema），举例来说，id字段不能在这个组是字符串，在另一个组是数值。这是与关系型数据库的表的一个区别。性质完全不同的数据（比如products和logs）应该存成两个 Index，而不是一个 Index 里面的两个 Type（虽然可以做到）

```sh
  # 查看当前节点的所有 Index
  curl -X GET 'http://localhost:9200/_cat/indices?v'

  # 新建一个名叫weather的 Index
  curl -X PUT 'localhost:9200/weather'
  # 列出每个 Index 所包含的 Type。
  curl 'localhost:9200/_mapping?pretty=true'
  # 删除
  curl -X DELETE 'localhost:9200/weather'
```

### 中文分词设置

```
# 使用ik插件
./bin/elasticsearch-plugin install https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v5.5.1/elasticsearch-analysis-ik-5.5.1.zip
```

[](http://www.cnblogs.com/raphael5200/p/5335155.html)
