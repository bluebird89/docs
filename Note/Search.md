# 搜索

活在搜索与推荐中

## 反向索引

又叫倒排索引，根据内容中的关键字建立索引

## 搜索引擎

* 一个文档处理器
	- 将文档流规范化为预定义格式。
	- 将文档流分解为所需的可检索单元。
	- 隔离和元标记每个子文档块。
	- 标识文档中潜在的可索引元素。
	- 删除停用词。
	- 词根化检索词。
	- 提取索引条目。
	- 计算权重。
	- 创建并更新搜索引擎搜索的主要倒排索引文件，以便将查询与文档进行匹配。
* 一个查询处理器
* 一个搜索和匹配功能
* 一个排名能力
* 爬取内容
* 进行分词
* 建立反向索引

## 技巧

* 站内搜索 keyword site:baidu.com
* 标题搜索 intitle：keyword
* 替代词 理想*义
* 关键词不打散,按照关键词的先后顺序查找网页内容 “keyword”
* 文件类型 keyword filetype:pdf
* 短横（-）：排除你不想要的结果

## 工具

* 引擎
    - [startpage](https://www.startpage.com/)
    - [Bing](https://cn.bing.com/)
    - [大圣盘](https://www.dashengpan.com/)
    - [Quickref ](https://quickref.dev/): Experimental search engine for developers. Searches a curated subset of the web: official docs and community-driven sources. No JS, cookies, tracking, external requests or data collecting
* [sourcegraph/sourcegraph](https://github.com/sourcegraph/sourcegraph):Code search and intelligence, self-hosted and scalable https://sourcegraph.com
* [facebookresearch/LASER](https://github.com/facebookresearch/LASER):Language-Agnostic SEntence Representations
* [asciimoo/searx](https://github.com/asciimoo/searx):Privacy-respecting metasearch engine https://asciimoo.github.io/searx/
* [OKlog](https://github.com/oklog/oklog)

## 参考

* [搜索引擎是如何工作的](https://mp.weixin.qq.com/s/BBGBnuYcoRAr8YNm-Yj_WQ)
