# log

写日志  测试代码作为编码的一部分

## 原理

* 记录器 负责产生日志记录的原始信息，比如（原始信息，日志等级，时间，记录的位置）等信息
* 过滤器 负责按指定的过滤条件过滤掉我们不需要的日志（比如按日志等级过滤）
* 格式化器    负责对原始日志信息按照我们想要的格式去格式化
* 输出器 负责将将要进行记录的日志（一般经过过滤器及格式化器的处理后）记录到日志目的地（例如：输出到文件中或者通过网络发送出去）

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
