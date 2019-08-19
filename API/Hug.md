# [timothycrosley/hug](https://github.com/timothycrosley/hug)

Embrace the APIs of the future. Hug aims to make developing APIs as simple as possible, but no simpler. http://www.hug.rest/

## 使用

* 热更新：bottle
* 测试

```python
import hug
import time
from bottle import run

@hug.get('/hello')

def hello(name):
    """Say Hello to the User"""
    ticks = time.time()
    return "Hello {name}! Now is {ticks}".format(**locals())
if __name__ == "__main__":
    app = __hug__.http.server()
    run(app=app, reloader=True, port=8000)

@hug.get('/', output=hug.output_format.json)
def root():
    return {'msg': "欢迎来到 HUG 指南"}
```

## 参考

* [The guiding thought behind the architecture](http://www.hug.rest/website/learn/)
