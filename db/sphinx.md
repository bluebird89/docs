# Sphinx

Full-text search engine

* 基于SQL的全文检索引擎，可以结合MySQL,PostgreSQL做全文搜索,提供比数据库本身更专业的搜索功能，使得应用程序更容易实现专业化的全文检索
* 为一些脚本语言设计搜索API接口，如PHP,Python,Perl,Ruby等，同时为MySQL也设计了一个存储引擎插件

## 概念

* 对应关系
  - Index   Table
  - Document    Row
  - Field or attribute  Column and/or a FULLTEXT index
  - Indexed field   Just a FULLTEXT index on a text column
  - Stored field    Text column and a FULLTEXT index on it
  - Attribute   Column
  - MVA Column with an INT_SET type
  - JSON attribute  Column with a JSON type
  - Attribute index Index
  - Document ID, docid  Column called “id”, with a BIGINT type
  - Row ID, rowid   Internal Sphinx row number
* Indexer：索引程序，从数据源中获取数据，并将数据生成全文索引。可以根据需求，定期运行Indexer达到定时更新索引的需求
* Searchd：Searchd直接与客户端程序进行对话，并使用Indexer程序构建好的索引来快速地处理搜索查询

## 安装

* [下载](http://sphinxsearch.com/downloads/current/)
* [php sphinx扩展](http://pecl.php.net/package/sphinx): 不支持PHP7

```sh
wget http://pecl.php.net/get/sphinx-1.3.3.tgz
tar zxf sphinx-1.3.3.tgz
cd sphinx-1.3.3
/usr/local/php/bin/phpize
./configure --with-php-config=/usr/local/php/bin/php-config --with-sphinx=/usr/local/sphinx/
make && make install
```

## 配置

* source 配置
  - sql_query_pre：前置sql操作，用户设置连接字符集，定义一些sql变量
  - sql_query：数据获取sql语句
  - sql_query_post：数据获取之后的sql操作，用于保存一些状态数据等
  - sql_query_killlist：屏蔽索引id数据源，用来告诉sphinx，哪些索引id要屏蔽,配合kbatch使用
* index 配置
  - source：使用数据配置名，对应source配置名称
  - path：索引数据保存路径
  - mlock：索引缓存设置，0不使用
  - min_word_len：索引的词的最小长度 设为1 既可以搜索单个字节搜索,越小 索引越精确,但建立索引花费的时间越长
  - ngram_len：对于非字母型数据的长度切割(默认已字符和数字切割,设置1为按没个字母切割)
  - ngram_chars：ngram 字符集，中文需要配置
  - kbatch：屏蔽索引的列表

```
# 搜索统计表
CREATE TABLE `sph_search_counter` (
  `counter_id` int(11) NOT NULL,
  `max_update_time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`counter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Minimal Sphinx configuration sample (clean, simple, functional)
#

source src1
{
        type                    = mysql
        sql_host                = localhost
        sql_user                = root
        sql_pass                = root
        sql_db                  = allchips_test
        sql_port                = 3306  # optional, default is 3306
        sql_query               = select * from products
        sql_query_pre = SET NAMES utf8

        # 文本字段，被全文索引
        #sql_attr_uint          = id

        #sql_attr_timestamp     = date_added

        # 自定义返回的字段
        sql_field_string        = product_id
        sql_field_string        = partNo
}

source src2
{
        type                    = mysql
        sql_host                = localhost
        sql_user                = root
        sql_pass                = root
        sql_db                  = allchips_test
        sql_port                = 3306  # optional, default is 3306
        sql_query               = select * from product_prices
}

source src3
{
        type                    = mysql
        sql_host                = localhost
        sql_user                = root
        sql_pass                = root
        sql_db                  = allchips_test
        sql_port                = 3306  # optional, default is 3306
        sql_query               = select * from product_attrs
}

index products
{
        source                  = src1
        path                    = /mnt/data/products
        # 分词长度
        min_infix_len = 1
        infix_fields = partNo,short_desc
}

index prices
{
        source                  = src2
        path                    = /mnt/data/prices
}

index attrs
{
        source                  = src3
        path                    = /mnt/data/attrs
}

indexer
{
        mem_limit               = 128M
}

searchd
{
        listen                  = 9312
        listen                  = 9306:mysql41
        log                     = /mnt/data/log/searchd.log
        query_log               = /mnt/data/log/query.log
        read_timeout            = 5
        max_children            = 30
        pid_file                = /mnt/data/log/searchd.pid
        seamless_rotate         = 1
        preopen_indexes         = 1
        unlink_old              = 1
        workers                 = threads # for RT to work
        binlog_path             = /mnt/data
}

#MySQL数据源配置，详情请查看：http://www.coreseek.cn/docs/coreseek_4.1-sphinx_2.0.1-beta.html#conf-reference

#源定义
source main
{
    type                    = mysql

    sql_host                = localhost
    sql_user                = root
    sql_pass                = 123456
    sql_db                  = coreseek_test
    sql_port                = 3306
    sql_query_pre           = SET NAMES utf8
    sql_query_pre        = REPLACE INTO sph_counter SELECT 1,MAX(id) FROM hr_spider_company;
    sql_query               = SELECT * FROM hr_spider_company WHERE id<=( SELECT max_doc_id FROM sph_counter WHERE counter_id=1 )
                                                         #sql_query第一列id需为整数
                                                         #title、content作为字符串/文本字段，被全文索引
    sql_attr_uint            = id                        #从SQL读取到的值必须为整数
    sql_attr_uint            = from_id                #从SQL读取到的值必须为整数，不支持全文检索
    sql_attr_uint            = link_id                #从SQL读取到的值必须为整数，不支持全文检索
    sql_attr_uint            = add_time                #从SQL读取到的值必须为整数，不支持全文检索
    sql_field_string         = link_url                 #字符串字段(可全文搜索，可返回原始文本信息)
    sql_field_string          = company_name          #字符串字段(可全文搜索，可返回原始文本信息)
    sql_field_string          = type_name             #字符串字段(可全文搜索，可返回原始文本信息)
    sql_field_string          = trade_name             #字符串字段(可全文搜索，可返回原始文本信息)
    sql_field_string          = email                 #字符串字段(可全文搜索，可返回原始文本信息)
    sql_field_string          = description             #字符串字段(可全文搜索，可返回原始文本信息)

    sql_query_info_pre      = SET NAMES utf8         #命令行查询时，设置正确的字符集
    # 添加全量统计最新时间
    sql_query_pre   = REPLACE INTO sph_search_counter SELECT 9312, MAX(update_time) FROM fm_search
    sql_query_info            = SELECT id,from_id,link_id,company_name,type_name,trade_name,address,description, FROM_UNIXTIME(add_time) AS add_time  FROM hr_spider_company  WHERE id=$id                     #命令行查询时，从数据库读取原始数据信息
}

source delta : main  
{  
    sql_query_pre           = SET NAMES utf8  
    sql_query               = SELECT * FROM hr_spider_company WHERE id>( SELECT max_doc_id FROM sph_counter WHERE counter_id=1 )
    sql_query_post_index    = REPLACE INTO sph_counter SELECT 1,MAX(id) FROM hr_spider_company
}  

#index定义
index main
{
    source                = main                         #对应的source名称
    path                  = /usr/local/coreseek/var/data/mysql     #请修改为实际使用的绝对路径，例如：/usr/local/coreseek/var/...
    docinfo               = extern
    mlock                 = 0
    morphology            = none
    min_word_len          = 1
    html_strip            = 0

    #中文分词配置，详情请查看：http://www.coreseek.cn/products-install/coreseek_mmseg/
    charset_dictpath     = /usr/local/mmseg3/etc/          #BSD、Linux环境下设置，/符号结尾
    charset_type        = zh_cn.utf-8
}

index delta : main  
{  
    source          = delta  
    path            = /usr/local/coreseek/var/data/delta
}


#全局index定义
indexer
{
    mem_limit            = 128M
}

#searchd服务定义
searchd
{
    listen              = 9312 # 查询服务监听端口，开启了才会工作
    read_timeout        = 5
    max_children        = 30
    max_matches         = 1000
    seamless_rotate     = 0
    preopen_indexes     = 0
    unlink_old          = 1
    pid_file         = /usr/local/coreseek/var/log/searchd_mysql.pid   #请修改为实际使用的绝对路径，例如：/usr/local/coreseek/var/...
    log             = /usr/local/coreseek/var/log/searchd_mysql.log        #请修改为实际使用的绝对路径，例如：/usr/local/coreseek/var/...
    query_log         = /usr/local/coreseek/var/log/query_mysql.log    #请修改为实际使用的绝对路径，例如：/usr/local/coreseek/var/...
    binlog_path     =                                              #关闭binlog日志
}
```

## 使用

* 启动服务: `/usr/local/sphinx/bin/searchd -c /usr/local/sphinx/etc/sphinx.conf`
* 创建全部|指定索引：`/usr/local/sphinx/bin/indexer -c /usr/local/sphinx/etc/sphinx.conf  --all|indexName --rotate`
* 更新索引： `/usr/local/sphinx/bin/indexer -c /usr/local/sphinx/etc/sphinx.conf  products --rotate`
* 停止服务：`/usr/local/sphinx/bin/searchd -c /usr/local/sphinx/etc/sphinx.conf --stop`
  - `netstat -tnl`:查看端口9312是否在监听
  - `lsof -i:9312`:查看9312端口信息,获得pid
  - kill {pid}
* 端口
  - 9312:php程序链接
  - 9306:本地数据库调试端口:`mysql -h127.0.0.1 -P9306`
* 返回

## CoreSeek

* 为应用提供全文检索功能，目前的版本(2.x 3.x)基于Sphinx，支持使用Python定义数据源，支持中文分词
* coreseek集合了sphinx的功能，支持更多的数据源，在字典，建立索引，分词更好的支持中文
* 支持中文的sphinx全文检索
* MMSeg
  - 蔡志浩（Chih-Hao Tsai）提出的基于字符串匹配（亦称基于词典）的中文分词算法
  - 基于词典的分词方案无法解决歧义问题,MMSeg在正向最大匹配的基础上设计了四个启发式规则, 参考[浅谈中文分词](http://www.isnowfy.com/introduction-to-chinese-segmentation/)
  - 字符串匹配算法分为两种
    + Simple，简单的正向最大匹配，即按能匹配上的最长词做切分；
    + Complex，在正向最大匹配的基础上，考虑相邻词的词长，设计了四个去歧义规则（Ambiguity Resolution Rules）指导分词。
      * MMSeg将切分的相邻三个词作为词块（chunk），应用如下四个消歧义规则：
        - 备选词块的长度最大（Maximum matching），即三个词的词长之和最大；
        - 备选词块的平均词长最大（Largest average word length），即要求词长分布尽可能均匀；
        - 备选词块的词长变化最小（Smallest variance of word lengths ）；
        - 备选词块中（若有）单字的出现词自由度最高（Largest sum of degree of morphemic freedom of one-character words）。
* 使用
  - 启动服务:`/usr/local/coreseek/bin/searchd -c /usr/local/coreseek/etc/csft_mysql.conf`
  - 构建索引:`/usr/local/coreseek/bin/indexer -c /usr/local/coreseek/etc/csft_mysql.conf --all --rotate`
  - 执行增量索引:`/usr/local/coreseek/bin/indexer -c /usr/local/coreseek/etc/csft_mysql.conf delta --rotate`
  - 合并索引:`/usr/local/coreseek/bin/indexer -c /usr/local/coreseek/etc/csft_mysql.conf --merge main delta --rotate --merge-dst-range deleted 0 0`
  - 命令行查询:`/usr/local/coreseek/bin/search -c /usr/local/coreseek/etc/sphinx_search.conf 花千骨`
  - 关闭搜索服务:`/usr/local/coreseek/bin/searchd -c /usr/local/coreseek/etc/sphinx_search.conf --stop`

```sh
# 安装mmseg3
cd /var/install
wget http://www.coreseek.cn/uploads/csft/4.0/coreseek-4.1-beta.tar.gz
tar zxvf coreseek-4.1-beta.tar.gz

cd coreseek-4.1-beta
cd mmseg-3.2.14
./bootstrap
./configure --prefix=/usr/local/mmseg3
make && make install

## 安装coreseek
cd csft-3.2.14 或者 cd csft-4.0.1 或者 cd csft-4.1
sh buildconf.sh                                         #输出的warning信息可以忽略，如果出现error则需要解决
./configure --prefix=/usr/local/coreseek  --without-unixodbc --with-mmseg --with-mmseg-includes=/usr/local/mmseg3/include/mmseg/ --with-mmseg-libs=/usr/local/mmseg3/lib/ --with-mysql
##如果提示mysql问题，可以查看MySQL数据源安装说明   http://www.coreseek.cn/product_install/install_on_bsd_linux/#mysql
make && make install

# 命令行测试mmseg分词，coreseek搜索（需要预先设置好字符集为zh_CN.UTF-8，确保正确显示中文）
cd testpack
cat var/test/test.xml    #此时应该正确显示中文
/usr/local/mmseg3/bin/mmseg -d /usr/local/mmseg3/etc var/test/test.xml
/usr/local/coreseek/bin/indexer -c etc/csft.conf --all
/usr/local/coreseek/bin/search -c etc/csft.conf 网络搜索

## 添加定时任务
*/1 * * * * /bin/sh /usr/local/coreseek/bin/indexer -c /usr/local/coreseek/etc/csft_mysql.conf delta --rotate
*/5 * * * * /bin/sh /usr/local/coreseek/bin/indexer -c /usr/local/coreseek/etc/csft_mysql.conf --merge main delta --rotate --merge-dst-range deleted 0 0
30 1 * * *  /bin/sh /usr/local/coreseek/bin/indexer -c /usr/local/coreseek/etc/csft_mysql.conf --all --rotate
```

## Demo

```php
<?php
$keywords = '花千骨';
$weight = array(
    'name' => 1000,
    'alias' => 500,
    'director' => 100,
    'actor' => 100,
    'tag' => 50,
);
$pagesize = 50;

$link = new SphinxClient();
//设置连接超时
$link->SetConnectTimeout(1);
$link->setServer('127.0.0.1',9312);
//设置返回结果集为数组
$link->SetArrayResult (true);
//查询超时时间
$link->setMaxQueryTime(5);
//设置分页
$page = $page > 0 ? $page : 1;
$link->SetLimits(($page-1)*$pagesize, $pagesize,1000);
//过滤条件
$link->SetFilter('disable', array(0));
//匹配模式和排序
$link->SetFieldWeights($weight); //权重数组
$link->SetSortMode(SPH_SORT_EXTENDED, "@weight DESC, score DESC");
$link->SetMatchMode(SPH_MATCH_EXTENDED2);
$link->SetRankingMode(SPH_RANK_MATCHANY);
//执行查询
$res = $link->query($keywords,'search_9312');
if (!$res)
{
    $error = $linkc->GetLastError();
    var_dump($error);
    exit;
}
//获取记录ID
$ids = array_keys($res['matches']);
//根据ID去实体表取对应数据展示
$info = $db->getInfoByIds($ids);
......
?>
```

## 过滤

* SetIDRange （设置查询ID范围） 原型： function SetIDRange($min, $max) 设置接受的文档ID范围
  - 参数必须是整数。默认是0和0，意思是不限制范围
  - 此调用执行后，只有ID在$min和$max（包括$min和$max）之间的文档会被匹配
* SetFilter （设置属性过滤） 原型： function SetFilter ( $attribute, $values, $exclude=false ) 增加整数值过滤器，此调用在已有的过滤器列表中添加新的过滤器
  - $attribute是属性名。$values是整数数组。$exclude是布尔值，它控制是接受匹配的文档（默认模式，即$exclude为false时）还是拒绝它们
  - 只有当索引中$attribute列的值与$values中的任一值匹配时文档才会被匹配（或者拒绝，如果$exclude值为true）
* SetFilterRange （设置属性范围） 原型： function SetFilterRange ( $attribute, $min, $max, $exclude=false ) 添加新的整数范围过滤器。 此调用在已有的过滤器列表中添加新的过滤器
  - $attribute是属性名,$min、$max定义了一个整数闭区间，$exclude布尔值，它控制是接受匹配的文档（默认模式，即$exclude为false时）还是拒绝它们
  - 只有当索引中$attribute列的值落在$min 和 $max之间（包括$min 和 $max），文档才会被匹配（或者拒绝，如果$exclude值为true）
* SetFilterFloatRange （设置浮点数范围） 原型： function SetFilterFloatRange ( $attribute, $min, $max, $exclude=false ) 增加新的浮点数范围过滤器。 此调用在已有的过滤器列表中添加新的过滤器
  - $attribute是属性名,$min,$max定义了一个浮点数闭区间，$exclude必须是布尔值，它控制是接受匹配的文档（默认模式，即$exclude为false时）还是拒绝它们
  - 只有当索引中$attribute列的值落在$min 和 $max之间（包括$min 和 $max），文档才会被匹配（或者拒绝，如果$exclude值为true）

## 匹配

* 关键词与或运算
  - (@name "花千骨")|(@alias "花千骨") 查询表达是用"|"组合表达或
  - @(name,alias) "花千骨" 与上等同
  - @name "花千骨" @actor "赵丽颖" 查询表达式空格表达与
* 关键词非运算
  - @name "花千骨" -"赵丽颖" 搜索包含花千骨，不包含赵丽颖的记录
  - @name "红高粱" @channel -("电视剧") 搜索非电视剧频道的红高粱, name和channel字段可以为逗号表达式的值
  - @body python -(php|perl) body字段必须含有词“python”，但既没有“php”也没有“perl”
* 全字段匹配
  - @* "花千骨" 任何字段出现花千骨都匹配
* 关键词严格匹配
  - @name "花千骨"~0 名称严格匹配"花千骨"三个字，只有这三个字都是出现的记录才会命中，等同SQL：name like '%花千骨%'
  - @name ="花千骨" 同上
* 关键词绝对匹配
  - @name "^花千骨$"~0 只匹配名称是"花千骨"三个字的记录，等同SQL：name = '花千骨'
* 关键词宽泛匹配
  - @name "花千骨传奇"/4 不考虑顺序，任意匹配"花千骨传奇"中四个字即可
* 严格有序搜索符（即"在前"搜索符）
  - @name '花' << '千' << '骨' name列出现'花','千','骨'三个字且要保持顺序，"花朵千万个骨朵"可命中，'千万个花骨朵'不可

## 工具

* [coreseek](https://github.com/zwxhenu/coreseek):Coreseek开源中文检索引擎-Sphinx中文版 <http://www.coreseek.cn>

## 参考

* [reference manual](http://sphinxsearch.com/docs/current.html)
* [sphinx](https://github.com/sphinx-doc/sphinx):Main repository for the Sphinx documentation builder <http://sphinx-doc.org>
