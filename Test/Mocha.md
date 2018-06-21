# [Mocha 实例教程](http://www.ruanyifeng.com/blog/2015/12/a-mocha-tutorial-of-examples.html)

Mocha（发音"摩卡"）诞生于2011年，是现在最流行的JavaScript测试框架之一.[代码仓库](git clone https://github.com/ruanyf/mocha-demos.git)

## 安装

```
npm install -g mocha
devDependencies
    "babel-core": "~6.2.1",
    "babel-preset-es2015": "~6.1.18",
    "chai": "~3.4.1",
    "mocha": "~2.3.4",
    "mochawesome": "~1.2.1"
npm install
```

- 代码

```
// add.js
function add(x, y) { return x + y; }
module.exports = add;
```

- 测试脚本

// add.test.js var add = require('./add.js'); var expect = require('chai').expect;

describe('加法函数的测试', function() { it('1 加 1 应该等于 2', function() { expect(add(1, 1)).to.be.equal(2); }); });


- 测试脚本与所要测试的源码脚本同名，但是后缀名为.test.js（表示测试）或者.spec.js（表示规格）
  - 包括一个或多个describe块(测试套件（test suite）),表示一组相关的测试。它是一个函数，第一个参数是测试套件的名称（"加法函数的测试"），第二个参数是一个实际执行的函数。每个describe块应该包括一个或多个it块。
  - it块称为"测试用例"（test case），表示一个单独的测试，是测试的最小单位。它也是一个函数，第一个参数是测试用例的名称（"1 加 1 应该等于 2"），第二个参数是一个实际执行的函数。
  - 引入断言库'var expect = require('chai').expect;'
  - 断言库：判断源码的实际执行结果与预期结果是否一致，如果不一致就抛出一个错误.头部是expect方法，尾部是断言方法，两者之间使用to或to.be连接。语法如下：


// 相等或不相等 expect(4 + 5).to.be.equal(9); expect(4 + 5).to.be.not.equal(10); expect(foo).to.be.deep.equal({ bar: 'baz' });

// 布尔值为true expect('everthing').to.be.ok; expect(false).to.not.be.ok;

// typeof expect('test').to.be.a('string'); expect({ foo: 'bar' }).to.be.an('object'); expect(foo).to.be.an.instanceof(Foo);

// include expect([1,2,3]).to.include(2); expect('foobar').to.contain('foo'); expect({ foo: 'bar', hello: 'universe' }).to.include.keys('foo');

// empty expect([]).to.be.empty; expect('').to.be.empty; expect({}).to.be.empty;

// match expect('foobar').to.match(/^foo/);


- 使用

```
mocha file1 (file2 file3) mocha --recursive:默认测试test目录里面的测试脚本 --recursive 递归执行 mocha spec/{my,awesome}.js // 支持shell 跟node通配符 mocha test/unit/_.js mocha 'test/**/_.@(js|jsx)' mocha test/{,_*/}_.{js,jsx} mocha --help, -h mocha --reporter, -R 指定测试报告的格式,默认是spec格式,其它tap mocha --reporters 显示所有内置的报告格式 mocha --watch，-w 监视指定的测试脚本。只要测试脚本有变化，就会自动运行Mocha mocha --bail, -b 只要有一个测试用例没有通过，就停止执行后面的测试用例 mocha --grep, -g 用于搜索测试用例的名称（即it块的第一个参数），然后只执行匹配的测试用例
```

- 配置文件：test目录下面，放置配置文件mocha.opts，会成为mocha的默认参数,第一行制定文件名

```
server-tests --recursive
```

- ES6测试：运行测试之前，需要先用Babel转码。
  - 安装
```
npm install babel-core babel-preset-es2015 --save-dev
```
  - 配置：项目目录新建文件.babelrc
```
{ "presets": [ "es2015" ] }
```
  - 使用：指定测试脚本的转码器,冒号左边是文件的后缀名，右边是用来处理这一类文件的模块名,比如:coffee:coffee-script/register.Babel默认不会对Iterator、Generator、Promise、Map、Set等全局对象，以及一些全局对象的方法（比如Object.assign）转码。如果你想要对这些对象转码，就要安装babel-polyfill
```
../node_modules/mocha/bin/mocha --compilers js:babel-core/register

npm install babel-polyfill --save
import 'babel-polyfill'
```

- 异步测试：默认每个测试用例最多执行2000毫秒，指定-t或--timeout参数指定超时门槛。
```
it('测试应该5000毫秒后结束', function(done) { var x = true; var f = function() { x = false; expect(x).to.be.not.ok; done(); // 通知Mocha测试结束,否则，Mocha就无法知道，测试是否结束 }; setTimeout(f, 4000); }); mocha -t 5000 timeout.test.js
```

- 支持Promise：允许直接返回Promise，等到它的状态改变，再执行断言，而不用显式调用done方法
```
it('异步请求应该返回一个对象', function() { return fetch('<https://api.github.com>') .then(function(res) { return res.json(); }).then(function(json) { expect(json).to.be.an('object'); }); }); ```
```

- 钩子
