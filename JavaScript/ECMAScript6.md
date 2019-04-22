# [tc39/ecma262](https://github.com/tc39/ecma262)

Status, process, and documents for ECMA262 https://tc39.github.io/ecma262/

## ES6


### Modules

#### 优点

* 将代码分割成功能独立的更小的文件。
* 有助于消除命名冲突。
* 不再需要对象作为命名空间（比如Math对象），不会污染全局变量。
* ES6 模块在编译时就能确定模块的依赖关系，以及输入和输出的变量，从而可以进行静态优化。

#### 基本用法

* export用于规定输出模块的对外接口
    - default用于指定模块输出的默认接口
* as用于重命名输出和输入接口

```js
// export 四种常规用法
// 用法1：直接输出一个变量声明、函数声明或者类声明
export var m = 1;
export function m() {};
export class M {};
// 用法2：输出内容为大括号包裹的一组变量，
// 注意不要被迷惑，export不能直接输出常规的对象，下面会给出错误示例。
var m1 = 1;
var m2 = 2;
export {m1, m2};
// 用法3：输出指定变量，并重命名，则外部引入时得到的是as后的名称。
var n = 1;
export {n as m};
// 用法4：使用default输出默认接口，default后可跟值或变量
export default 1;
var m = 1
export default m;

// 错误用法
// 用法1 必须输出一个接口，不能输出一个值（哪怕是对象也不行）或者一个已赋值的变量，已赋值的变量对应的也是一个值
export 1;
export {m: '1'};
// 用法2 必须输出一个接口，不能输出一个值（哪怕是对象也不行）或者一个已赋值的变量，已赋值的变量对应的也是一个值
var m = 1;
export m;
// 用法3 因为export只能出现在模块的顶层作用域，不能存在块级作用域中。如果出现在块级作用域的话，就没法做静态优化了
function foo() {
  export default 'bar' // SyntaxError
}
```

* import用于输入模块提供的接口
    - *表示输入模块的所有接口。
    - 如果多次重复执行同一句import语句，那么只会执行一次，而不会执行多次
    - import命令输入的变量都是只读的，加载后不能修改接口。

```js
// 用法1：仅执行 my_module 模块，不输入任何值（可能没啥用，但是是合法的）
import 'my_module';
// 用法2：输入 my_module 的默认接口, 默认接口重命名为 m
import m from 'my_module';
// 用法3：输入 my_module 的 m 接口
import { m } from 'my_module';
// 用法4：输入 my_module 的 m 接口，使用as重命名m接口
import { m as my_m} from 'my_module';
// 用法5：导入所有接口
import * as all from 'my_module';

// 用法1：不能使用表达式
import { 'm' + '1' } from 'my_module';
// 用法2：不能使用变量
let module = 'my_module';
import { m } from module;
// 用法3：不能用于条件表达式
if (x === 1) {
  import { m } from 'module1';
} else {
  import { m } from 'module2';
}
```

#### 使用问题

* 在浏览器中下快速使用import

```js

// myModule.js 在script标签上添加一个type="module"的属性来表示这个文件是以module的方式来运行
export default {
  name: 'my-module'
}
// script脚本引入
<script type="module">
  import myModule from './myModule.js'
  console.log(myModule.name) // my-module
</script>

// 在不支持的浏览器下，我们需要一些回退方案，可以通过nomodule属性来指定某脚本为回退方案.当浏览器支持type=module时，会忽略带有nomodule的script；如果不支持，则忽略带有type=module的脚本，执行带有nomodule的脚本
<script type="module">
  import myModule from './myModule.js'
</script>
<script nomodule>
  alert('你的浏览器不支持ES模块，请先升级！')
</script>
```

* 在Node下快速使用export/import:Node还没有原生支持ES模块
    - Node从9.0版本开始支持ES模块，可以在flag模式下使用ES模块，不过这还处于试验阶段（Stability: 1 - Experimental）。其用法也比较简单，执行脚本或者启动时加上--experimental-modules即可。不过这一用法要求import/export的文件后缀名必须为*.mjs。
* 借助babel-node执行包含ES模块代码的文件
    - 安装babel-cli和babel-preset-env，并将其保存为开发依赖。
    - 在根目录创建.babelrc文件，在其中添加如下配置。

```js
node --experimental-modules test-my-module.mjs

// test-my-module.mjs
import myModule from './myModule.mjs'
console.log(myModule.name) // my-module

// .babelrc
{
     "presets": ["env"]
}
./node_modules/.bin/babel-node index.js
npx babel-node index.js
```

#### 不要修改export输出的对象

* export输出的值是动态绑定的，如果我们修改了其中的值，就会导致其他地方再次引入该值时会发生变化，此时的默认配置就不是我们所设想的默认配置了
* 有需求对输入的对象接口进行改变时，可以先对其进行深度复制，然后在进行修改

```js
// use-options.js

import _ from "./lodash.js";
import options from "./options.js";

const myOptions = _.cloneDeep(options);
console.log(myOptions); // { style: { color: 'green', fontSize: 14 } }
myOptions.style.color = "red";
```

## ECMAScript 2016

* Array.prototype.includes

```javascript
const arr = [1,2,3,4,NaN];
if(arr.indexof(3)>=0){
    console.log(true)
}
//instead
if (arr.includes(3)) {
    console.log(true)
}
arr.includes(NaN) // true
arr.indexof(NaN) // -1

7**2 # Math.pow(7,2)
```

## ECMAScript 2017

* Object.values():返回 Object 所有属性的值
* Object.entries():与 Object.keys 相关，但它不仅返回键，而是以数组的方式返回键和值。这使得在循环中使用对象或将对象转换为 Map 等操作变得非常简单。
* String.prototype.padStart 和 String.prototype.padEnd——允许将空字符串或其他字符串追加或前置到原始字符串的尾部或开头
* Object.getOwnPropertyDescriptors:返回给定对象所有属性的详细信息（包括 get 和 set 方法）。添加它的主要动机是允许将一个对象浅复制 / 克隆到另一个对象，同时也复制 getter 和 setter 函数而不是 Object.assign。
* Object.assign 将浅复制除原始源对象的 getter 和 setter 函数之外的所有东西。
* 函数参数中添加尾逗号
* async/await:async 关键字告诉 JavaScript 编译器要以不同的方式处理这个函数。在遇到函数中的 await 关键字时，编译器就会暂停。它假定 await 之后的表达式会返回一个 promise 并等待，直到 promise 完成或被拒绝。

```javascript
const cars ={BMW:3,Tesla:2,Toyota:1}
const vals = Object.keys(cars).map(key => cars[key]); // [3,2,1]
const values = Object.values(cars); // [3,2,1]

Object.keys(cars).forEach(function(key){
    console.log('key:' + key + ' value: ' + cars[key])
})
for(let [key, value] of Object.enteries(cars)){
    console.log('key: ${key} value: ${value}')
}

const map1 = new Map();
Object.keys(cars).forEach(key => {
    map1.set(key, cars[key]);
}) // {'BMW' => 3,'Tesla' => 2,'Toyota' => 1}
const map = new Map(Object.enteries(cars))

// 'someString'.padStart(numberOfCharcters [,stringForPadding]);
'5'.padStart(10, '=*')
'5'.padEnd(10, '=*')
// 补前置0
const formatted = [0,1,12,123,1234,12345].map(num =>{
    num.toSting().padStart(10, '0')
})
// 不同长度字符串对齐
Object.enteries(cars).map([name, count] =>{
    console.log(`${name.padEnd(20, ' -')} Count: ${count.padStart(3, '0')}`)
})

'heart'.padStart(10, "❤️"); // prints.. '❤️❤️❤heart' // ❤️占用 2 个码位（’\u2764\uFE0F’）！heart 本身是 5 个字符，所以我们只剩下 5 个字符来填充
```

## ECMAScript 2018

```javascript
code
```

## 参考

* [standard-things/esm](https://github.com/standard-things/esm)：Tomorrow's ECMAScript modules today!
* [tc39/proposals](https://github.com/tc39/proposals):Tracking ECMAScript Proposals https://tc39.github.io/process-document/

## 工具

* code generator
    - [estools/escodegen](https://github.com/estools/escodegen):ECMAScript code generator
