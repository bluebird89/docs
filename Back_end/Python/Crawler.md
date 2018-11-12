# Crawler

## 知识点

数据解析
到数据存储
模拟登陆
验证码识别
代理IP使用
并发请求

### 爬虫协议

爬虫协议即网站根目录之下的robots.txt文件，用来告知爬虫者哪些可以拿哪些不能偷，其中Crawl-delay告知了网站期望的被访问的间隔。

### http请求分析

* 访问页面：https://movie.douban.com/subject/6390825/comments?sort=new_score&status=P
* 按下F12，进入network面板进行网络请求的分析，通过刷新网页重新获得请求，借助chrome浏览器对请求进行筛选、分析，找到元素，并分析url规律

### requests请求

* 模仿发送请求
* 判断是否获取请求成功

### Xpath语法

对网页内容进行解析，常用的工具有正则表达式、Beautiful Soup、Xpath等等；其中Xpath又快又方便。

http://www.runoob.com/xpath/xpath-tutorial.html

### Python基础语法

### Pandas数据处理

## 步骤

* 网络请求分析
* 网页内容解析
* 数据读取存储

## 工具

* [bupt1987/html-parser](https://github.com/bupt1987/html-parser):php html parser，类似与PHP Simple HTML DOM Parser，但是比它快好几倍
* [IonicaBizau/scrape-it](https://github.com/IonicaBizau/scrape-it):🔮 A Node.js scraper for humans.  https://ionicabizau.net/blog/30-how-to-write-a-web-scraper-in-nodejs
* [PuerkitoBio/gocrawl](https://github.com/PuerkitoBio/gocrawl):Polite, slim and concurrent web crawler.

## 实例

* [chinese-poetry/chinese-poetry](https://github.com/chinese-poetry/chinese-poetry):最全中华古诗词数据库, 唐宋两朝近一万四千古诗人, 接近5.5万首唐诗加26万宋诗. 两宋时期1564位词人，21050首词。 http://shici.store
* [waditu/tushare](https://github.com/waditu/tushare):TuShare is a utility for crawling historical data of China stocks
* [MontFerret/ferret](https://github.com/MontFerret/ferret):Declarative web scraping
* [modood/Administrative-divisions-of-China](https://github.com/modood/Administrative-divisions-of-China):中华人民共和国行政区划：省级（省份直辖市自治区）、 地级（城市）、 县级（区县）、 乡级（乡镇街道）、 村级（村委会居委会） ，中国省市区镇村二级三级四级五级联动地址数据 Node.js 爬虫。
