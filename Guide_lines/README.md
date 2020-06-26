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
$ virtualenv foobar
$ . foobar/bin/activate
$ pip install -e .
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

## 参考

* [Make a README:Because no one can read your mind](https://github.com/dguo/make-a-readme)
