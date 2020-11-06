# [scrapy](https://github.com/scrapy/scrapy)

Scrapy, a fast high-level web crawling & scraping framework for Python. https://scrapy.org

* Scrapy Engine 引擎负责控制数据流在系统中所有组件中流动，并在相应动作发生时触发事件。 详细内容查看下面的数据流 (Data Flow) 部分。此组件相当于爬虫的 “大脑”，是整个爬虫的调度中心。
* 调度器 (Scheduler) 调度器从引擎接受 request 并将他们入队，以便之后引擎请求他们时提供给引擎。 初始的爬取 URL 和后续在页面中获取的待爬取的 URL 将放入调度器中，等待爬取。同时调度器会自动去除重复的 URL（如果特定的 URL 不需要去重也可以通过设置实现，如 post 请求的 URL）
* 下载器 (Downloader) 下载器负责获取页面数据并提供给引擎，而后提供给 spider。
* Spiders Spider 是 Scrapy 用户编写用于分析 response 并提取 item (即获取到的 item) 或额外跟进的 URL 的类。 每个 spider 负责处理一个特定 (或一些) 网站。
* Item Pipeline Item Pipeline 负责处理被 spider 提取出来的 item。典型的处理有清理、 验证及持久化 (例如存取到数据库中)。 当页面被爬虫解析所需的数据存入 Item 后，将被发送到项目管道 (Pipeline)，并经过几个特定的次序处理数据，最后存入本地文件或存入数据库。
* 下载器中间件 (Downloader middlewares) 下载器中间件是在引擎及下载器之间的特定钩子 (specific hook)，处理 Downloader 传递给引擎的 response。 其提供了一个简便的机制，通过插入自定义代码来扩展 Scrapy 功能。通过设置下载器中间件可以实现爬虫自动更换 user-agent、IP 等功能。
* Spider 中间件 (Spider middlewares) Spider 中间件是在引擎及 Spider 之间的特定钩子 (specific hook)，处理 spider 的输入 (response) 和输出 (items 及 requests)。 其提供了一个简便的机制，通过插入自定义代码来扩展 Scrapy 功能。
* 数据流 (Data flow)
  - 引擎打开一个网站 (open a domain)，找到处理该网站的 Spider 并向该 spider 请求第一个要爬取的 URL (s)。
  - 引擎从 Spider 中获取到第一个要爬取的 URL 并在调度器 (Scheduler) 以 Request 调度。
  - 引擎向调度器请求下一个要爬取的 URL。
  - 调度器返回下一个要爬取的 URL 给引擎，引擎将 URL 通过下载中间件 (请求 (request) 方向) 转发给下载器 (Downloader)
  - 一旦页面下载完毕，下载器生成一个该页面的 Response，并将其通过下载中间件 (返回 (response) 方向) 发送给引擎。
  - 引擎从下载器中接收到 Response 并通过 Spider 中间件 (输入方向) 发送给 Spider 处理。
  - Spider 处理 Response 并返回爬取到的 Item 及 (跟进的) 新的 Request 给引擎。
  - 引擎将 (Spider 返回的) 爬取到的 Item 给 Item Pipeline，将 (Spider 返回的) Request 给调度器。
  - (从第二步) 重复直到调度器中没有更多地 request，引擎关闭该网站。

## Xpath

```py
# 选取节点
xpath('//div') # 选取了div节点的所有子节点
xpath('/div') # 从根节点上选取div节点
xpath('//div') # 选取所有的div节点
xpath('./div') # 选取当前节点下的div节点
xpath('..') # 回到上一个节点
xpath（'//@calss'） # 选取所有的class属性
xpath('//div|//table') # 选取所有的div和table节点

## 谓语被嵌在方括号内，用来查找某个特定的节点或包含某个制定的值的节点
xpath('/body/div[1]') # 选取body下的第一个div节点
xpath('/body/div[last()]') # 选取body下最后一个div节点
xpath('/body/div[last()-1]') # 选取body下倒数第二个div节点
xpath('/body/div[positon()<3]') # 选取body下前两个div节点
xpath('/body/div[@class]') # 选取body下带有class属性的div节点
xpath('/body/div[@class="main"]') # 选取body下class属性为main的div节点
xpath('/body/div[price>35.00]') # 选取body下price元素值大于35的div节点

## 通配符
xpath（'/div/*'）# 选取div下的所有子节点
xpath('/div[@*]') # 选取所有带属性的div节点

# 轴可以定义相对于当前节点的节点集
path('./ancestor::*') # 选取当前节点的所有先辈节点（父、祖父）
xpath('./ancestor-or-self::*') # 选取当前节点的所有先辈节点以及节点本身
xpath('./attribute::*') # 选取当前节点的所有属性
xpath('./child::*') # 返回当前节点的所有子节点
xpath('./descendant::*') # 返回当前节点的所有后代节点（子节点、孙节点）
xpath('./following::*') # 选取文档中当前节点结束标签后的所有节点
xpath('./following-sibling::*') # 选取当前节点之后的兄弟节点
xpath('./parent::*') # 选取当前节点的父节点
xpath('./preceding::*') # 选取文档中当前节点开始标签前的所有节点
xpath('./preceding-sibling::*') # 选取当前节点之前的兄弟节点
xpath('./self::*') # 选取当前节点

## 功能函数
xpath('//div[starts-with(@id,"ma")]') # 选取id值以ma开头的div节点
xpath('//div[contains(@id,"ma")]') # 选取id值包含ma的div节点
xpath('//div[contains(@id,"ma") and contains(@id,"in")]') # 选取id值包含ma和in的div节点
xpath('//div[contains(text(),"ma")]') # 选取节点文本包含ma的div节点
```

## 参数

`scrapy shell "http://quotes.toscrape.com/page/1/"`

* module
  - crawler    <scrapy.crawler.Crawler object at 0x110f58a50>
  - item       {}
  - request    <GET http://quotes.toscrape.com/page/1/>
  - response   <200 http://quotes.toscrape.com/page/1/>
  - settings   <scrapy.settings.Settings object at 0x110f58ad0>
  - spider     <DefaultSpider 'default' at 0x1112eab50>
* shortcuts
  - fetch(url[, redirect=True]) Fetch URL and update local objects (by default, redirects are followed)
  - fetch(req)                  Fetch a scrapy.Request and update local objects
  - shelp()           Shell help (print this help)
  - view(response)    View response in a browser

## 工具

* [scrapy/quotesbot](https://github.com/scrapy/quotesbot):This is a sample Scrapy project for educational purposes
* admin UI
  - [DormyMo/SpiderKeeper](https://github.com/DormyMo/SpiderKeeper)：admin ui for scrapy/open source scrapinghub http://sk.7mdm.com:5000/

## 参考

* [CriseLYJ/awesome-python-login-model](https://github.com/CriseLYJ/awesome-python-login-model):😮python模拟登陆一些大型网站，还有一些简单的爬虫
* [Scrapy documentation](https://docs.scrapy.org/en/latest/)
