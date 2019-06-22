# [scrapy/scrapy](https://github.com/scrapy/scrapy)

Scrapy, a fast high-level web crawling & scraping framework for Python. https://scrapy.org

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
