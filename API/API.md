# API

实现前后端分离

*   请求地址
*   请求类型
*   参数说明
*   返回结果说明

## API gateway

### [encode/apistar](https://github.com/encode/apistar)

A smart Web API framework, for Python 3. 🌟 https://docs.apistar.com

* pip3 install apistar
* Create a new project in app.py, python app.py
* Open http://127.0.0.1:5000/docs/ in your browser

```py
from apistar import App, Route


def welcome(name=None):
    if name is None:
        return {'message': 'Welcome to API Star!'}
    return {'message': 'Welcome to API Star, %s!' % name}


routes = [
    Route('/', method='GET', handler=welcome),
]

app = App(routes=routes)


if __name__ == '__main__':
    app.serve('127.0.0.1', 5000, debug=True)
```

## 加密

* [google/tink](https://github.com/google/tink):Tink is a multi-language, cross-platform library that provides cryptographic APIs that are secure, easy to use correctly, and hard(er) to misuse.

## 流程

* 前后端和产品一起开会讨论项目
* 后端根据需求，首先定义数据格式和 api
* mock api 生成好文档
* 我们前端才是对接接口的
* 这里推荐一个文档生成器 swagger
* mockjs + rap 或者 easy-mock

## 实例

* [雅虎天气](https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20%3D%202151330&format=json)
* [价格](http://api.money.126.net/data/feed/0000001,1399001?callback=refreshPrice)

## 测试

* [apiaryio/dredd](https://github.com/apiaryio/dredd):Language-agnostic HTTP API Testing Tool https://dredd.org

## 接口

* [douban](https://developers.douban.com/wiki/?title=guide)
* [jokermonn/-Api](https://github.com/jokermonn/-Api):📖「一个」、「Time 时光」、「开眼」、「一席」、「梨视频」、「微软必应词典」、「金山词典」、「豆瓣电影」、「中央天气」、「魅族天气」、「每日一文」、「12306」、「途牛」、「快递100」、「快递」应用 Api
* [toddmotto/public-apis](https://github.com/toddmotto/public-apis):A collective list of public JSON APIs for use in web development. https://toddmotto.com
* [pwxcoo/chinese-xinhua](https://github.com/pwxcoo/chinese-xinhua):📙 中华新华字典数据库。包括歇后语，成语，词语，汉字。提供新华字典API。

## Gateway

* [TykTechnologies/tyk](https://github.com/TykTechnologies/tyk)：Tyk Open Source API Gateway written in Go

## 工具

* [GoogleChrome/puppeteer](https://github.com/GoogleChrome/puppeteer):Headless Chrome Node API https://try-puppeteer.appspot.com/
* [thx/RAP](https://github.com/thx/RAP):Web接口管理工具，开源免费，接口自动化，MOCK数据自动生成，自动化测试，企业级管理。阿里妈妈MUX团队出品！阿里巴巴都在用！1000+公司的选择！RAP2已发布请移步至https://github.com/thx/rap2-delos http://rapapi.org
* [thx/rap2-delos](https://github.com/thx/rap2-delos):阿里妈妈前端团队出品的开源接口管理工具RAP第二代 http://rap2.taobao.org
* [encode/apistar](https://github.com/encode/apistar):A smart Web API framework, for Python 3. 🌟 https://docs.apistar.com
* [ruby-grape/grape](https://github.com/ruby-grape/grape):An opinionated framework for creating REST-like APIs in Ruby. http://www.ruby-grape.org
* [encode/django-rest-framework](https://github.com/encode/django-rest-framework):Web APIs for Django. ⚡️ https://www.django-rest-framework.org
* [paularmstrong/normalizr](https://github.com/paularmstrong/normalizr):Normalizes nested JSON according to a schema
* [swagger-api/swagger-ui](https://github.com/swagger-api/swagger-ui):Swagger UI is a collection of HTML, Javascript, and CSS assets that dynamically generate beautiful documentation from a Swagger-compliant API. http://swagger.io
* [dingo/api](https://github.com/dingo/api):A RESTful API package for the Laravel and Lumen frameworks.
* [parse-community/parse-server](https://github.com/parse-community/parse-server):Parse-compatible API server module for Node/Express http://parseplatform.org
* [interagent/http-api-design](https://github.com/interagent/http-api-design):HTTP API design guide extracted from work on the Heroku Platform API https://www.gitbook.com/read/book/gee…
* [typicode/json-server](https://github.com/typicode/json-server):Get a full fake REST API with zero coding in less than 30 seconds (seriously)
* [gongwalker/ApiManager](https://github.com/gongwalker/ApiManager):接口文档管理工具
* [tobscure/json-api](https://github.com/tobscure/json-api):JSON-API (http://jsonapi.org) responses in PHP.
* [hashicorp/vault](https://github.com/hashicorp/vault)：A tool for secrets management, encryption as a service, and privileged access management https://www.vaultproject.io/
* [nsf/termbox-go](https://github.com/nsf/termbox-go):Pure Go termbox implementation http://code.google.com/p/termbox
* [apiaryio/dredd](https://github.com/apiaryio/dredd):Language-agnostic HTTP API Testing Tool https://dredd.rtfd.io
* [hellofresh/janus](https://github.com/hellofresh/janus):An API Gateway written in Go https://hellofresh.gitbooks.io/janus

## 文档

* [jsdoc3/jsdoc](https://github.com/jsdoc3/jsdoc):An API documentation generator for JavaScript. http://usejsdoc.org
* [swagger](https://app.swaggerhub.com/home)Swagger UI is a collection of HTML, Javascript, and CSS assets that dynamically generate beautiful documentation from a Swagger-compliant API. http://swagger.io
* [freeCodeCamp/devdocs](https://github.com/freeCodeCamp/devdocs):API Documentation Browser https://devdocs.io
* [lord/slate](https://github.com/lord/slate):Beautiful static documentation for your API https://spectrum.chat/slate
