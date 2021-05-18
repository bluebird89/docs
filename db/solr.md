# [solr](https://lucene.apache.org/solr/)

* Apache Solr is an enterprise search platform written using Apache Lucene. Major features include full-text search, index replication and sharding, and result faceting and highlighting.
* 一个独立的企业级搜索应用服务器
* 基于Lucene的全文搜索服务器
* Lucene是apache软件基金会4 jakarta项目组的一个子项目，是一个开放源代码的全文检索引擎工具包，即它不是一个完整的全文检索引擎，而是一个全文检索引擎的架构，提供了完整的查询引擎和索引引擎，部分文本分析引擎（英文与德文两种西方语言）
* 提供http请求接口
  - 提交一定格式的XML文件，生成索引
  - 客户端通过http请求获取json、xml等数据格式数据，并对数据进行解析显示
* 各种语言都会有封装好的客户端插件，如java的solrj、python的solrpy，php的php-solr-client，根据提供的api进行索引和查询

## 安装

* startup configuration in /etc/default/solr.in.sh
* localhost:8983
* 模式
  - core 单机
  - collection 集群
* web端 8983/solr/

```sh
wget https://mirrors.tuna.tsinghua.edu.cn/apache/lucene/solr/8.5.2/solr-8.5.2.tgz
tar xzf solr-8.4.1.tgz solr-8.4.1/bin/install_solr_service.sh --strip-components=2

sudo bash bin/install_solr_service.sh /opt/solr-8.5.2.tgz

solr start -p 8983
solr stop|restart|status|healthcheck|create|create_core|create_collection|delete|version|zk|auth|assert|config|autoscaling|export

/opt/solr/bin/solr create -c mycollection -n data_driven_schema_configs
./solr delete -c my_core
```

## 配置

* server\solr\test\conf\solrconfig.xml 请求处理和响应格式化相关的定义，核心特定配置，以及索引，配置，管理内存和提交
  - 新增一搜索建议组件 searchComponent
  - `8983/solr/core_name/suggest?indent=on&q=query_name`
* 添加中文分词
  - 配置分词jar包地址
  - managed-schema:整个模式以及字段和字段类型
  - web端 可以查看分词效果
  - 默认分词对内容做最小分割，一个词一个索引,搜索避免的

```xml
<!-- solrconfig.xml -->
 <searchComponent name="suggest" class="solr.SuggestComponent">
    <str name="queryAnalyzerFieldType">string</str>
    <lst name="suggester">
        <str name="name">suggest</str>

        <str name="lookupImpl">org.apache.solr.spelling.suggest.tst.TSTLookupFactory</str>
        <str name="field">title</str>
        <str name="buildOnOptimize">true</str>
        <str name="buildOnCommit">true</str>
    </lst>
  </searchComponent>

  <requestHandler name="/suggest" class="solr.SearchHandler"
                  startup="lazy" >
    <lst name="defaults">
       <str name="suggest">true</str>
        <str name="suggest.dictionary">suggest</str>
        <str name="suggest.count">10</str>
    </lst>
    <arr name="components">
        <str>suggest</str>
    </arr>
  </requestHandler>

<lib dir="${solr.install.dir:../../../..}/contrib/extraction/lib" regex=".*\.jar" />

<!-- managed-schema -->
<fieldType name="text_cn" class="solr.TextField" positionIncrementGap="100">
      <analyzer type="index">
        <tokenizer class="org.apache.lucene.analysis.cn.smart.HMMChineseTokenizerFactory"/>
      </analyzer>
      <analyzer type="query">
         <tokenizer class="org.apache.lucene.analysis.cn.smart.HMMChineseTokenizerFactory"/>
       </analyzer>
    </fieldType>
<field name="title" type="text_cn" indexed="true" stored="true" required="true" multiValued="true"/>
```

## 原理

* 一个实例可以有多个core或collection，如果不先停止，创建的core将会添加到启用的实例中
* 分词
  - 去除停词(Stop word)和标点符号，例如英文的this，that等， 中文的”的”,”一”等没有特殊含义的词
  - 会将所有的大写英文字母转换成小写，方便统一创建索引和搜索索引
  - 将复数形式转为单数形式，比如students转为student，也是方便统一创建索引和搜索索引
  - 经过分词器分词后得到的结果称为词元，solr会为分词后的结果（词典）创建索引，然后将索引和文档id列表对应起来，该词典在该文档中出现的频次，频次越多说明权重越大，权重越大搜索的结果就会排在前面
  - 每个字符串都指向包含此字符串的文档(Document)链表，此文档链表称为倒排表(Posting List)
* 查询
  - 用户输入搜索条件
  - 对搜索条件进行分词处理
  - 对分词后的结果创建索引
  - 根据索引找到文档ID列表
  - 根据文档ID列表找到具体的文档，根据出现的频次等计算权重，最后将文档列表按照权重排序返回

```sh
bin\solr -e techproducts
bin/post -c techproducts example/exampledocs/*
```

## 操作

* 通过Request-Handler指令操作文档的,配置：conf/solrconfig.xml 中 requestHandler

## PHP

* path:solr/core_name

## 参考

* [solr cookbook]()
* [Solr Ref Guide](https://lucene.apache.org/solr/guide/8_4)
