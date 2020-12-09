# Crawler

* 发起请求 通过 HTTP 库向目标站点发起请求，也就是发送一个 Request，请求可以包含额外的 header 等信息，等待服务器响应
* 获取响应内容 如果服务器能正常响应，会得到一个 Response，Response 的内容便是所要获取的页面内容，类型可能是 HTML,Json 字符串，二进制数据（图片或者视频）等类型
* 解析内容 得到的内容可能是 HTML, 可以用正则表达式，页面解析库进行解析，可能是 Json, 可以直接转换为 Json 对象解析，可能是二进制数据，可以做保存或者进一步的处理
* 保存数据 保存形式多样，可以存为文本，也可以保存到数据库，或者保存特定格式的文件

## 知识点

* 数据解析
* 到数据存储
* 模拟登陆
* 验证码识别
* 代理IP使用
* 并发请求

### 爬虫协议

爬虫协议即网站根目录之下的robots.txt文件，用来告知爬虫者哪些可以拿哪些不能偷，其中Crawl-delay告知了网站期望的被访问的间隔。

### http请求分析

* 访问页面：<https://movie.douban.com/subject/6390825/comments?sort=new_score&status=P>
* 按下F12，进入network面板进行网络请求的分析，通过刷新网页重新获得请求，借助chrome浏览器对请求进行筛选、分析，找到元素，并分析url规律

### requests请求

* 模仿发送请求
* 判断是否获取请求成功

### Xpath语法

对网页内容进行解析，常用的工具有正则表达式、Beautiful Soup、Xpath等等；其中Xpath又快又方便。

<http://www.runoob.com/xpath/xpath-tutorial.html>

### 基础语法

### Pandas数据处理

## 步骤

* 网络请求分析
* 网页内容解析
* 数据读取存储

## 反爬虫

* [luyishisi/Anti-Anti-Spider](https://github.com/luyishisi/Anti-Anti-Spider):越来越多的网站具有反爬虫特性，有的用图片隐藏关键数据，有的使用反人类的验证码，建立反反爬虫的代码仓库，通过与不同特性的网站做斗争（无恶意）提高技术。（欢迎提交难以采集的网站）（因工作原因，项目暂停） <https://www.urlteam.org>

## 图书

* 爬虫实战：从数据到产品

## 教程

* [Python-crawler-tutorial-starts-from-zero](https://github.com/Kr1s77/Python-crawler-tutorial-starts-from-zero):python爬虫教程，带你从零到一，包含js逆向，selenium, tesseract OCR识别,mongodb的使用，以及scrapy框架
* [Python-crawler](https://github.com/Ehco1996/Python-crawler):从头开始 系统化的 学习如何写Python爬虫。 Python版本 3.6

## 实例

* [chinese-poetry](https://github.com/chinese-poetry/chinese-poetry):最全中华古诗词数据库, 唐宋两朝近一万四千古诗人, 接近5.5万首唐诗加26万宋诗. 两宋时期1564位词人，21050首词。 <http://shici.store>
* [tushare](https://github.com/waditu/tushare):TuShare is a utility for crawling historical data of China stocks
* [erret](https://github.com/MontFerret/ferret):Declarative web scraping
* [modood/Administrative-divisions-of-China](https://github.com/modood/Administrative-divisions-of-China):中华人民共和国行政区划：省级（省份直辖市自治区）、 地级（城市）、 县级（区县）、 乡级（乡镇街道）、 村级（村委会居委会） ，中国省市区镇村二级三级四级五级联动地址数据 Node.js 爬虫。
* [weixin_crawler](https://github.com/wonderfulsuccess/weixin_crawler):高效微信公众号历史文章和阅读数据爬虫powered by scrapy
* [google-images-download](https://github.com/hardikvasa/google-images-download):Python Script to download hundreds of images from 'Google Images'. It is a ready-to-run code!
* [python-spider](https://github.com/Jack-Cherish/python-spider/tree/master/2020):
  rainbowPython3网络爬虫实战：淘宝、京东、网易云、B站、12306、抖音、笔趣阁、漫画小说下载、音乐电影下载等 <https://cuijiahua.com/blog/spider/>
* [lianjia-scrawler](https://github.com/XuefengHuang/lianjia-scrawler)

## 工具

* [html-parser](https://github.com/bupt1987/html-parser):php html parser，类似与PHP Simple HTML DOM Parser，但是比它快好几倍
* [scrape-it](https://github.com/IonicaBizau/scrape-it):🔮 A Node.js scraper for humans. <https://ionicabizau.net/blog/30-how-to-write-a-web-scraper-in-nodejs>
* [gocrawl](https://github.com/PuerkitoBio/gocrawl):Polite, slim and concurrent web crawler.
* [crawlab](https://github.com/crawlab-team/crawlab):Distributed web crawler admin platform for spiders management regardless of languages and frameworks.
* [pyspider](https://github.com/binux/pyspider) A Powerful Spider(Web Crawler) System in Python. <http://docs.pyspider.org/>
