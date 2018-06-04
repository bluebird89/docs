# API

实现前后端分离

*   请求地址
*   请求类型
*   参数说明
*   返回结果说明

## API gateway

## [encode/apistar](https://github.com/encode/apistar)

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

## 工具

*   [GoogleChrome/puppeteer](https://github.com/GoogleChrome/puppeteer):Headless Chrome Node API https://try-puppeteer.appspot.com/
*   [swagger](https://app.swaggerhub.com/home)Swagger UI is a collection of HTML, Javascript, and CSS assets that dynamically generate beautiful documentation from a Swagger-compliant API. http://swagger.io

## 接口

*   [douban](https://developers.douban.com/wiki/?title=guide)

## 流程

*   前后端和产品一起开会讨论项目
*   后端根据需求，首先定义数据格式和 api
*   mock api 生成好文档
*   我们前端才是对接接口的
*   这里推荐一个文档生成器 swagger
*   mockjs + rap 或者 easy-mock

## 实例

https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20%3D%202151330&format=json
http://api.money.126.net/data/feed/0000001,1399001?callback=refreshPrice
