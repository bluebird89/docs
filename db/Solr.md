# [apache/lucene-solr](https://github.com/apache/lucene-solr)

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

```
wget https://mirrors.tuna.tsinghua.edu.cn/apache/lucene/solr/8.5.2/solr-8.5.2.tgz
tar xzf solr-8.4.1.tgz solr-8.4.1/bin/install_solr_service.sh --strip-components=2

sudo bash bin/install_solr_service.sh /opt/solr-8.5.2.tgz
sudo su - solr -c "/opt/solr/bin/solr create -c mycollection -n data_driven_schema_configs"
```

## 原理

* 创建
    - 分词：
        + 去除停词(Stop word)和标点符号，例如英文的this，that等， 中文的”的”,”一”等没有特殊含义的词
        + 会将所有的大写英文字母转换成小写，方便统一创建索引和搜索索引
        + 将复数形式转为单数形式，比如students转为student，也是方便统一创建索引和搜索索引
    - 经过分词器分词后得到的结果称为词元，solr会为分词后的结果（词典）创建索引，然后将索引和文档id列表对应起来，该词典在该文档中出现的频次，频次越多说明权重越大，权重越大搜索的结果就会排在前面
    - 每个字符串都指向包含此字符串的文档(Document)链表，此文档链表称为倒排表(Posting List)
* 查询
    - 用户输入搜索条件
    - 对搜索条件进行分词处理
    - 对分词后的结果创建索引
    - 根据索引找到文档ID列表
    - 根据文档ID列表找到具体的文档，根据出现的频次等计算权重，最后将文档列表按照权重排序返回

## 参考

* [solr cookbook]()
* [Solr Ref Guide](https://lucene.apache.org/solr/guide/8_4)
