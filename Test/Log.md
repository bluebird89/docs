# log

写日志  测试代码作为编码的一部分

## 原理

* 记录器 负责产生日志记录的原始信息，比如（原始信息，日志等级，时间，记录的位置）等信息
* 过滤器 负责按指定的过滤条件过滤掉我们不需要的日志（比如按日志等级过滤）
* 格式化器 :负责对原始日志信息按照我们想要的格式去格式化
* 输出器 负责将将要进行记录的日志（一般经过过滤器及格式化器的处理后）记录到日志目的地（例如：输出到文件中或者通过网络发送出去）

## 日志分析

* 使用数据库来进行日志分析，一个很重要的点就是如何将各种异构的日志文件导入到的数据库中，因为数据库首先需要按照固定格式创建表结构——这个过程通常称为 ETL。当数据导入后，可以采用大家熟悉的 SQL 进行日志的各种分析。
* 数据规模比较大的情况，一般会使用分布式技术
    - 采用 hadoop 存储日志数据，后续采用 MapReduce 的 job 或者 spark 等进行分析
    - 如果希望采用 SQL 的方案来分析，可以采用 Hive 这些类似数据库的系统。这类系统适合于批量的进行分析。如果需要实时分析则需要引入一些实时的处理系统。
* 问题
    - 日志分析最大的问题是字段抽取复杂:对所有日志进行字段抽取的工作量很大，其次日志会随着产品版本更新发生变化，而且日志入库时很难预知后续的分析对字段的需求。因此需要一个功能强大且易用的日志抽取功能，以及搜索时按需临时抽取字段的能力。
    - 需要灵活可配置的分析能力。 如果每次分析都需要写代码进行,工作量大而且使用的门槛比较高
    - 实时性和性能问题。随着日志数据量的增长，想要实时监控分析数据，就必然会影响系统性能。这二者的平衡与优化
* 日志分析中的搜索引擎主要用于数据的读写：即实时的接收最新产生的日志数据，并进行索引，以实时或者准实时的方式提供给用户进行搜索和统计分析。

## 工具

* [Graylog2/graylog2-server](https://github.com/Graylog2/graylog2-server):Free and open source log management https://www.graylog.org/
* [klaussinani/signale](https://github.com/klaussinani/signale):👋 Hackable console logger
* [Graylog](https://www.graylog.org/products/open-source)
* [Nagios](https://www.nagios.org/downloads/)
* [Elastic Stack](https://www.elastic.co/products)
    - *Elasticsearch* 旨在帮助用户使用多种查询语言和类型在数据集中找出匹配项。速度是这个工具的最大优势。它可以扩展成由数百个服务器节点组成的集群，轻松处理 PB 级的数据。
    - *Kibana* 是一个可视化工具，它与 Elasticsearch 一起运行，允许用户分析他们的数据并构建强大的报告。当你第一次在服务器集群上安装 Kibana 引擎时，你将获得一个显示数据统计、图形甚至动画的界面。
    - *Logstash*，它是作为一个纯粹的、进入 Elasticsearch 数据库的服务器端管道。你可以使用各种编码语言和 API 集成 Logstash。这样，你的网站和移动应用程序中的信息就可以直接输入到强大的 Elastic Stalk 搜索引擎中。
* [LOGalyze](http://www.logalyze.com)
* [Fluentd](https://www.fluentd.org)
* [GoAccess](https://goaccess.io/):an open source real-time web log analyzer and interactive viewer that runs in a terminal in *nix systems or through your browser.
* [rsyslog/rsyslog](https://github.com/rsyslog/rsyslog):a Rocket-fast SYStem for LOG processing http://www.rsyslog.com
