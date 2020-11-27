# Foobar ![CI status](https://img.shields.io/badge/build-passing-brightgreen.svg)

Foobar is a Python library for dealing with word pluralization.

## Installation

### Requirements

* Linux
* Python 3.3 and up

`$ pip install foobar`

## Usage

```python
import foobar

foobar.pluralize('word') # returns 'words'
foobar.pluralize('goose') # returns 'geese'
foobar.singularize('phenomena') # returns 'phenomenon'
```

## Development

```
virtualenv foobar
. foobar/bin/activate
pip install -e .
```

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License

[MIT](https://choosealicense.com/licenses/mit/)

## 原则

* 元素
  - 一句话简介。这个项目做什么？
  - 项目介绍。解决了什么问题
  - 特性。包含已完成和待办
  - 使用指南。如何一步步使用这个项目
  - 示例。hello, world 示例
  - 开源协议。

-

  README应该简明扼要，条理清晰，建议包含以下方面：

- 项目简介：用一两句话简单描述该项目所实现的业务功能；
- 技术选型：列出项目的技术栈，包括语言、框架和中间件等；
- 本地构建：列出本地开发过程中所用到的工具命令；
- 领域模型：核心的领域概念，比如对于示例电商系统来说有Order、Product等；
- 测试策略：自动化测试如何分类，哪些必须写测试，哪些没有必要写测试；
- 技术架构：技术架构图；
- 部署架构：部署架构图；
- 外部依赖：项目运行时所依赖的外部集成方，比如订单系统会依赖于会员系统；
- 环境信息：各个环境的访问方式，数据库连接等；
- 编码实践：统一的编码实践，比如异常处理原则、分页封装等；
- FAQ：开发过程中常见问题的解答。

## 参考

* [Make a README:Because no one can read your mind](https://github.com/dguo/make-a-readme)
