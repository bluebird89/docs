# 搜索

活在搜索与推荐中

* 评价标准
  - 精准性
  - 时效性
  - 响应速度
  - 权威性

## 搜索引擎

- 网络爬虫，采用分布式爬虫来实现
  + 基本流程
    * 将热门站点的优质URL作为种子，放到待抓取的URL队列中
    * 读取待抓取URL获取地址进行下载
    * 将下载的网页内容进行解析，将网页存储到hbase/hdfs等，并提取网页中存在的其他URL
    * 发掘到新的URL进行去重，如果是未抓取的则放到抓取队列中
    * 直到待抓取URL队列为空，完成本轮抓取
  + 抓取过程中会有多种遍历策略：深度优先遍历DFS、广度优先遍历BFS、部分PageRank策略、OPIC在线页面重要性计算策略、大站优先策略等。实践中需要根据自身情况和搜索引擎特点进行选择某种策略或者多种策略组合
  + 爬虫需要遵循Robots协议(网络爬虫排除标准)，这是网络爬虫和站点之间的君子协定，站点通过协议告诉网络爬虫哪些可以抓哪些不可以
  + 同时需要考虑抓取频率，防止给站点造成过重负担

* 内容处理：爬虫下载的页面进行内容解析、内容清洗、主体抽取、建立索引、链接分析、反作弊等环节
  + 数据清洗：将无用数据、标签清洗掉，为后续的分词做准备，每个网页进行唯一编号docid
  + 网页内容分词：提取关键词，提取了网页的主干，并且会对标题、摘要、正文等不同部分的内容做不同权重处理
    * 基于字符串匹配的分词算法
    * 基于概率统计的分词算法
    * 基于语义规则的分词算法
  + 建立正排索引：根据docid可以拿到属于该网页的所有内容
  + 建立倒排索引（反向索引）：建立检索词->网页的映射关系
  + 文档处理器
    * 将文档流规范化为预定义格式
    * 将文档流分解为所需的可检索单元
    * 隔离和元标记每个子文档块
    * 标识文档中潜在的可索引元素
    * 删除停用词、虚词
    * 词根化检索词
    * 提取索引条目
    * 计算权重
    * 创建并更新搜索引擎搜索的主要倒排索引文件，以便将查询与文档进行匹配
* 内容排序：排序的头部内容对于搜索结果至关重要
  - 结合用户模块解析的查询词和内容索引生成用户查询结果，并对页面进行排序，是搜索引擎比较核心的部分
  - 进行网页的排序，排序策略有很多，最终把优质的网页排在前面展示给用户
  - 用户看到相关结果之后，进行点击或者跳过，搜索引擎根据用户的相关动作进行调整，实现整个闭环过程
  - 策略
    + 基于词频和位置权重的排序：根据网页中关键词的出现频率以及出现位置作为排序依据，因为普遍认为：检索词出现次数越多、位置越重要，网页的关联性越好，排名越靠前。频并不是单纯的统计次数，需要有全局观念来判断关键词的相对次数，TF-IDF逆文档频率。字词的重要性随着它在文件中出现的次数成正比增加，但同时会随着它在语料库（词汇的普遍性）中出现的频率成反比下降
    + 基于链接分析的排序：网页被别的网页引用的次数越多或者越权威的网页引用，说明该网页质量越高。最有名的PageRank算法被谷歌广泛采用。有大V转载就相当于引用了，越多其他公众号转载，说明你的公众号内容质量越高。
      * 引用该网页其他网页个数
      * 引用该页面的其他页面的重要程度
      * 存在一定的问题，比如对新页面不友好，新页面暂时没有被大量引用，因此PageRank值很低，并且PageRank算法强调网页之间的引用关系，对网页本身的主题内容可能重视程度不够，也就是所谓的主题漂流问题
  - 网页反作弊和SEO
    + 头部的网页占据了大量的点击流量，也意味着巨大的商业价值
    + 网页反作弊是搜索引擎需要解决的重要问题，常见的有内容反作弊、链接分析反作弊等
    + 网页内容作弊： 比如在网页内容中增加大量重复热词、在标题/摘要等重要位置增加热度词、html标签作弊等等，比如在一篇主题无联系的网页中增加大量"隐秘的角落"热度词、增加<strong> 等强调性html标签
    + 链接分析作弊： 构建大量相互引用的页面集合、购买高排名友链等等，就是搞很多可以指向自己网页的其他网页，从而构成一个作弊引用链条
* 查询处理器
* 搜索和匹配功能
  - 进行检索词的意图理解、词条切分、同义词替换、语法纠错等处理，再根据这些检索词去获取数据，为用户找到心中所想的网页
  - 用户的查询词、分词、同义词转换、语义理解等等，去揣摩用户的真实意图、查询重点才能返回正确的结果

## 搜索引擎优化 SEO Search Engine Optimization

* 一种通过分析搜索引擎的排名规律，了解各种搜索引擎怎样进行搜索、怎样抓取互联网页面、怎样确定特定关键词的搜索结果排名的技术

## 反向索引

又叫倒排索引，根据内容中的关键字建立索引

## 技巧

* 站内搜索 keyword site:baidu.com site:.gov covid-19
* 标题搜索 intitle:keyword
* 替代词 理想*义
* Exact matches only “keyword”
* 文件类型 keyword filetype:pdf
* 排除不想要结果 Mercedes -Benz
* google
  - stopwatch|timer
  - color picker
  - 6 inches to cm
  - what is my ip|my ip
  - Japan time 5pm
  - @character

## 搜索和推荐

* 共同点:宏观上来说，搜索和推荐都是为了解决用户和信息之间的隔离问题，给用户有用的/需要的/喜欢的信息。
* 区别点
  - 搜索一般是用户主动触发，按照自己的意图进行检索
  - 推荐一般是系统主动推送，让用户看到可能感兴趣的信息。

## 工具

* 通用搜索引擎:谷歌、百度、搜狗、神马
* 垂直搜索引擎
* 引擎
  - [startpage](https://www.startpage.com/)
  - [Bing](https://cn.bing.com/)
  - [大圣盘](https://www.dashengpan.com/)
  - [Quickref](https://quickref.dev/): Experimental search engine for developers. Searches a curated subset of the web: official docs and community-driven sources. No JS, cookies, tracking, external requests or data collecting
* [sourcegraph](https://github.com/sourcegraph/sourcegraph):Code search and intelligence, self-hosted and scalable <https://sourcegraph.com>
* [LASER](https://github.com/facebookresearch/LASER):Language-Agnostic Sentence Representations
* [=searx](https://github.com/asciimoo/searx):Privacy-respecting metasearch engine <https://asciimoo.github.io/searx/>
* [OKlog](https://github.com/oklog/oklog)
* [searx.space](https://searx.space/)

## 参考

* [搜索引擎是如何工作的](https://mp.weixin.qq.com/s/BBGBnuYcoRAr8YNm-Yj_WQ)
* example
  - 网页分词在线工具：<http://www.78901.net/fenci/>
  - 抓取网页：<https://tech.huanqiu.com/article/3zMq4KbdTAA>
* [浅谈基于simhash的文本去重原理](https://mp.weixin.qq.com/s/hyXG1czry6_YOXFwqBTbdQ)
