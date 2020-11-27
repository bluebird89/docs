# [mocha](https://github.com/mochajs/mocha)

☕️ simple, flexible, fun javascript test framework for node.js & the browser https://mochajs.org
Mocha（发音"摩卡"）诞生于2011年，是现在最流行的JavaScript测试框架之一

## 安装

```sh
npm install -g mocha

devDependencies
    "babel-core": "~6.2.1",
    "babel-preset-es2015": "~6.1.18",
    "chai": "~3.4.1",
    "mocha": "~2.3.4",
    "mochawesome": "~1.2.1"
npm install
```

## 使用

* 测试脚本
  - 与所要测试的源码脚本同名，但是后缀名为.test.js（表示测试）或者.spec.js（表示规格）
  - describe块称为"测试套件"（test suite），表示一组相关的测试。它是一个函数
    + 第一个参数是测试套件的名称（"加法函数的测试"）
    + 第二个参数是一个实际执行的函数
  - it块称为"测试用例"（test case），表示一个单独的测试，是测试的最小单位。它也是一个函数
    + 第一个参数是测试用例的名称（"1 加 1 应该等于 2"）
    + 第二个参数是一个实际执行的函数
  - describe块和it块都允许调用only方法，表示只运行某个测试套件或测试用例
  - skip方法，表示跳过指定的测试套件或测试用例
  - 断言库：判断源码的实际执行结果与预期结果是否一致，如果不一致就抛出一个错误.头部是expect方法
    + 尾部是断言方法，比如equal、a/an、ok、match等。两者之间使用to或to.be连接
* 默认运行test子目录里面的测试脚本。所以，一般都会把测试脚本放在test目录里面，然后执行mocha就不需要参数了
* 配置：test目录下面放置配置文件mocha.opts，会成为mocha的默认参数,把命令行参数写在里面
  - 如果测试用例不是存放在test子目录，首行制定目录
* 命令行指定测试脚本时，可以使用通配
  - {my,awesome}.js
  - *.js
  - Node通配符:'test/**/*.@(js|jsx)' `test/{,**/}*.{js,jsx}`
* 命令行参数
  - --recursive
  - --reporter|-R 用来指定测试报告的格式，默认是spec格式
  - --reporters参数可以显示所有内置的报告格式
  - --growl|-G 将测试结果在桌面显示
  - --watch|-W 用来监视指定的测试脚本。只要测试脚本有变化，就会自动运行Mocha
  - -bail|-b 只要有一个测试用例没有通过，就停止执行后面的测试用例
  - --grep|-g 用于搜索测试用例的名称（即it块的第一个参数），然后只执行匹配的测试用例
- ES6测试：运行测试之前，需要先用Babel转码
  + mocha是node的构建工具，默认只支持commonJS的模块系统，即require，exports，如何兼容ES6的模块import，export呢
  + 使用babel进行转换:通过require钩子，即使用babel-register，babel-register的作用是在把自身的require和commonJS的require绑定，之后每次require进来的文件都会被自动编译
- 异步测试
  + 默认每个测试用例最多执行2000毫秒，指定-t或--timeout参数指定超时门槛
  + 默认会高亮显示超过75毫秒的测试用例 -s|--slow
- 支持Promise：允许直接返回Promise，等到状态改变，再执行断言，而不用显式调用done方法
- 浏览器测试 `mocha init`
- 生成规格文件 `npx mocha --require babel-register --recursive -R markdown > spec.md`
- mocha 和 _mocha 是两个不同的命令，前者会新建一个进程执行测试，而后者是在当前进程（即 istanbul 所在的进程）执行测试

```sh
mocha file1 (file2 file3)
mocha spec/{my,awesome}.js
mocha test/unit/*.js

# 运行 es6 测试
npx mocha --require babel-register

npm install babel-polyfill --save
import 'babel-polyfill'
```

## 钩子


## 参考
