# [tc39/ecma262](https://github.com/tc39/ecma262)

Status, process, and documents for ECMA262 https://tc39.github.io/ecma262/

## 版本

* [ES6](https://github.com/lukehoban/es6features) ES2015
  - let, const（变量类型）：解决变量作用域泄露的问题
  - Class, extends, super（类、继承）：让对象原型的写法更加清晰、更像面向对象编程的语法，也更加通俗易懂
  - Arrow functions（箭头函数）：简洁，解决this绑定的问题（继承外面的this）
  - Template string（模板字符串）：解决传统写法非常麻烦的问题
  - Destructuring（解构）：避免让API使用者记住多个参数的使用顺序
  - Default, rest（默认值、参数）：简化，替代arguments，使代码更易于阅读
* ECMAScript 2016
  - Array.prototype.includes
* ECMAScript 2017
  - Object.values():返回 Object 所有属性的值
  - Object.entries():与 Object.keys 相关，不仅返回键，而是以数组的方式返回键和值。这使得在循环中使用对象或将对象转换为 Map 等操作变得非常简单
  - String.prototype.padStart 和 String.prototype.padEnd——允许将空字符串或其他字符串追加或前置到原始字符串的尾部或开头
  - Object.getOwnPropertyDescriptors:返回给定对象所有属性的详细信息（包括 get 和 set 方法）。添加它的主要动机是允许将一个对象浅复制 / 克隆到另一个对象，同时也复制 getter 和 setter 函数而不是 Object.assign
  - Object.assign 将浅复制除原始源对象的 getter 和 setter 函数之外的所有东西
  - 函数参数中添加尾逗号（trailing comma）
  - async/await:async 关键字告诉 JavaScript 编译器要以不同的方式处理这个函数。在遇到函数中的 await 关键字时，编译器就会暂停。它假定 await 之后的表达式会返回一个 promise 并等待，直到 promise 完成或被拒绝
* ECMAScript 2018
* ES2019

  - toString()方法返回函数代码本身，以前会省略注释和空格
  - 允许catch语句省略参数

### Modules

* CommonJS:Node.JS首先采用了js模块化的概念。Node.js服务器端通过exports、module.exports来输出模块，并使用require同步载入模块，而浏览器端的可以使用Browserify实现
* AMD:AMD规范用于异步加载模块，主要用于浏览器端，当然也支持其他js环境，主要应用有requireJS
* ImmutableJS:知道在JavaScript中有两种数据类型：基础数据类型和引用类型。在JavaScript中的对象数据是可以变的，由于使用了引用，所以修改了复制的值也会相应地修改原始值。通常用deepCopy来避免修改，但这样做法会产生资源浪费。而ImmutableJS的出现很好的解决了这一问题
* ES6 Module:ES6标准定义了JS的模块化方式，目的是取代CommonJS、AMD、CMD等规范，一统江湖，成为通用的模块化解决方案。但浏览器和Node端对ES6的支持度还不是很高，需要用Babel进行转译（Babel编译器可以将ES6、JSX等代码转换成浏览器可以看得懂的语法）

#### 优点

* 将代码分割成功能独立的更小的文件
* 有助于消除命名冲突
* 不再需要对象作为命名空间（比如Math对象），不会污染全局变量
* ES6 模块在编译时就能确定模块的依赖关系，以及输入和输出的变量，从而可以进行静态优化

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

## 解构

## 箭头函数

* 注意点
  - 函数体内的this对象，就是定义时所在的对象，而不是使用时所在的对象。
  - 不可以当作构造函数，也就是说，不可以使用new命令，否则会抛出一个错误。
  - 不可以使用arguments对象，该对象在函数体内不存在。如果要用，可以用 rest 参数代替。
  - 不可以使用yield命令，因此箭头函数不能用作 Generator 函数
* this指向的固定化，并不是因为箭头函数内部有绑定this的机制，实际原因是箭头函数根本没有自己的this，导致内部的this就是外层代码块的this。正是因为它没有this，所以也就不能用作构造函数
* 不应该使用箭头函数
  - 定义对象的方法，且该方法内部包括this
  - 需要动态this的时候，也不应使用箭头函数

## 尾调用优化（Tail call optimization）

* 尾调用（Tail Call）是函数式编程的一个重要概念，是指某个函数的最后一步是调用另一个函数
* 调用被调函数后，调用函数就结束了，执行到最后一步，完全可以删除调用函数的调用帧，只保留被调函数的调用帧
* 只保留内层函数的调用帧。如果所有函数都是尾调用，那么完全可以做到每次执行时，调用帧只有一项，这将大大节省内存
* 只有不再用到外层函数的内部变量，内层函数的调用帧才会取代外层函数的调用帧，否则就无法进行“尾调用优化”
* 函数调用自身，称为递归。如果尾调用自身，就称为尾递归。
* 递归非常耗费内存，因为需要同时保存成千上百个调用帧，很容易发生“栈溢出”错误（stack overflow）
* 对于尾递归来说，由于只存在一个调用帧，所以永远不会发生“栈溢出”错误
* 实现:需要改写递归函数，确保最后一步只调用自身。把所有用到的内部变量改写成函数的参数
  - 在尾递归函数之外，再提供一个正常形式的函数
  - 柯里化（currying）:将多参数的函数转换成单参数的形式
* 尾调用优化只在严格模式下开启，正常模式是无效的。这是因为在正常模式下，函数内部有两个变量，可以跟踪函数的调用栈。
  - func.arguments：返回调用时函数的参数。
  - func.caller：返回调用当前函数的那个函数
* 蹦床函数（trampoline）可以将递归执行转为循环执行

## Array

* 数组是复合的数据类型，直接复制的话，只是复制了指向底层数据结构的指针，而不是克隆一个全新的数组
* 数组的空位指，数组的某一个位置没有任何值.空位不是undefined，一个位置的值等于undefined，依然是有值的。空位是没有任何值。ES6 则是明确将空位转为undefined
* 扩展运算符（spread）是三个点（...）:好比 rest 参数的逆运算，将一个数组转为用逗号分隔的参数序列
  - 只有函数调用时，扩展运算符才可以放在圆括号中，否则会报错
  - 不再需要apply方法，将数组转为函数的参数了
  - 背后调用的是遍历器接口（Symbol.iterator），如果一个对象没有部署这个接口，就无法转换
  - 用于数组赋值，只能放在参数的最后一位，否则会报错
  - 任何定义了遍历器（Iterator）接口的对象，都可以用扩展运算符转为真正的数组
    + Map 结构
* Array.from方法用于将两类对象转为真正的数组
  - 类似数组的对象（array-like object）:本质特征只有一点，即必须有length属性
  - 可遍历（iterable）的对象（包括 ES6 新增的数据结构 Set 和 Map）
  - 可以接受第二个参数，作用类似于数组的map方法，用来对每个元素进行处理，将处理后的值放入返回的数组
* Array.of方法用于将一组值，转换为数组
  - 弥补数组构造函数Array()的不足。因为参数个数的不同，会导致Array()的行为有差异.只有当参数个数不少于 2 个时，Array()才会返回由参数组成的新数组。参数个数只有一个时，实际上是指定数组的长度。
* copyWithin():在当前数组内部，将指定位置的成员复制到其他位置（会覆盖原有成员），然后返回当前数组。也就是说，使用这个方法，会修改当前数组
* find方法，用于找出第一个符合条件的数组成员。参数是一个回调函数，所有数组成员依次执行该回调函数，直到找出第一个返回值为true的成员，然后返回该成员。如果没有符合条件的成员，则返回undefined
* findIndex方法的用法与find方法非常类似，返回第一个符合条件的数组成员的位置，如果所有成员都不符合条件，则返回-1
* fill:使用给定值，填充一个数组
* entries()，keys()和values()——用于遍历数组。都返回一个遍历器对象，可以用for...of循环进行遍历，唯一的区别是keys()是对键名的遍历、values()是对键值的遍历，entries()是对键值对的遍历
* includes 表示某个数组是否包含给定的值
  - 第二个参数表示搜索的起始位置，默认为0。如果第二个参数为负数，则表示倒数的位置，如果这时它大于数组长度（比如第二个参数为-4，但数组长度为3），则会重置为从0开始
  - indexOf方法有两个缺点
    + 不够语义化，它的含义是找到参数值的第一个出现位置，所以要去比较是否不等于-1，表达起来不够直观
    + 内部使用严格相等运算符（===）进行判断，这会导致对NaN的误判
* Array.prototype.flat()用于将嵌套的数组“拉平”，变成一维的数组。该方法返回一个新数组，对原数据没有影响
  - flat()默认只会“拉平”一层，如果想要“拉平”多层的嵌套数组，可以将flat()方法的参数写成一个整数，表示想要拉平的层数，默认为1
* flatMap()只能展开一层数组,然后对返回值组成的数组执行flat()方法。该方法返回一个新数组，不改变原数组
  - 可以接受三个参数，分别是当前数组成员、当前数组成员的位置（从零开始）、原数组
* Array.prototype.sort() 的排序稳定性
  - 排序稳定性（stable sorting）是排序算法的重要属性，指的是排序关键字相同的项目，排序前后的顺序不变
  - ES2019 明确规定，Array.prototype.sort()的默认排序算法必须稳定

## object

* 属性简洁表示法：在大括号里面，直接写入变量和函数，作为对象的属性和方法
  - 用于函数的返回值，将会非常方便，CommonJS 模块输出一组变量，就非常合适使用简洁写法
  - 属性的赋值器（setter）和取值器（getter），事实上也是采用这种写法
  - 不能用作构造函数
* 定义对象属性
  - 直接用标识符作为属性名
  - 用表达式作为属性名，这时要将表达式放在方括号之内，还可以用于定义方法名
  - 属性名表达式与简洁表示法，不能同时使用，会报错
  - 属性名表达式如果是一个对象，默认情况下会自动将对象转为字符串[object Object]
* 方法 name 属性：返回函数名
  - 如果对象的方法使用了取值函数（getter）和存值函数（setter），则name属性不是在该方法上面，而是该方法的属性的描述对象的get和set属性上面，返回值是方法名前加上get和set
  - bind方法创造的函数，name属性返回bound加上原函数的名字
  - Function构造函数创造的函数，name属性返回anonymous
* 可枚举性:对象的每个属性都有一个描述对象（Descriptor），用来控制该属性的行为。Object.getOwnPropertyDescriptor方法可以获取该属性的描述对象
  - 引入“可枚举”（enumerable）概念的最初目的:让某些属性可以规避掉for...in操作，不然所有内部属性和方法都会被遍历到
  - 描述对象的enumerable属性，称为“可枚举性”，如果该属性为false，就表示某些操作会忽略当前属性.有四个操作会忽略enumerable为false的属性
    + for...in循环：只遍历对象自身的和继承的可枚举的属性。
    + Object.keys()：返回对象自身的所有可枚举的属性的键名。
    + JSON.stringify()：只串行化对象自身的可枚举的属性。
    + Object.assign()： 忽略enumerable为false的属性，只拷贝对象自身的可枚举的属性
  - ES6 规定，所有 Class 的原型的方法都是不可枚举的
  - 尽量不要用for...in循环，而用Object.keys()代替
* 遍历对象属性
  - for...in循环遍历对象自身的和继承的可枚举属性（不含 Symbol 属性）。
  - Object.keys(obj):Object.keys返回一个数组，包括对象自身的（不含继承的）所有可枚举属性（不含 Symbol 属性）的键名。
  - Object.getOwnPropertyNames(obj):Object.getOwnPropertyNames返回一个数组，包含对象自身的所有属性（不含 Symbol 属性，但是包括不可枚举属性）的键名。
  - Object.getOwnPropertySymbols(obj):Object.getOwnPropertySymbols返回一个数组，包含对象自身的所有 Symbol 属性的键名。
  - Reflect.ownKeys(obj):Reflect.ownKeys返回一个数组，包含对象自身的（不含继承的）所有键名，不管键名是 Symbol 或字符串，也不管是否可枚举。
* 遍历的次序规则
  - 遍历所有数值键，按照数值升序排列。
  - 遍历所有字符串键，按照加入时间升序排列。
  - 遍历所有 Symbol 键，按照加入时间升序排列。
* 新增了另一个类似的关键字super，指向当前对象的原型对象
  - super关键字表示原型对象时，只能用在对象的方法之中，用在其他地方都会报错
* 对象的扩展运算符（...）用于取出参数对象的所有可遍历属性，拷贝到当前对象之中
* Object.is()：比较两个值是否严格相等，与严格比较运算符（===）的行为基本一致
  - 一是+0不等于-0
  - NaN等于自身
* Object.assign()方法用于对象的合并，将源对象（source）的所有可枚举属性，复制到目标对象（target）
  - 如果目标对象与源对象有同名属性，或多个源对象有同名属性，则后面的属性会覆盖前面的属性
  - 实行的是浅拷贝，而不是深拷贝。也就是说，如果源对象某个属性的值是对象，那么目标对象拷贝得到的是这个对象的引用
* Object.getOwnPropertyDescriptors()方法，返回指定对象所有自身属性（非继承属性）的描述对象

## Symbol

* 对象的属性名通过Symbol函数生成.属于 Symbol 类型，就都是独一无二的，可以保证不会与其他属性名产生冲突
* 参数只是表示对当前 Symbol 值的描述，因此相同参数的Symbol函数的返回值是不相等
* Symbol.prototype.description:创建 Symbol 的时候，可以添加一个描述
* 定义属性时，Symbol 值必须放在方括号之
  - 作为对象属性名时，不能用点运算符
* 可以用于定义一组常量，保证这组常量的值都是不相等
* Symbol.for():接受一个字符串作为参数，然后搜索有没有以该参数作为名称的 Symbol 值。如果有，就返回这个 Symbol 值，否则就新建一个以该字符串为名称的 Symbol 值，并将其注册到全局

## Map

* 类似于对象，也是键值对的集合，但是“键”的范围不限于字符串，各种类型的值（包括对象）都可以当作键
* Object 结构提供了“字符串—值”的对应，Map 结构提供了“值—值”的对应，是一种更完善的 Hash 结构实现
* 任何具有 Iterator 接口、且每个成员都是一个双元素的数组的数据结构都可以当作Map构造函数的参数
* 键实际上是跟内存地址绑定的，只要内存地址不一样，就视为两个键
* has:查找键名

## Set

* 类似于数组，成员的值都是唯一的，没有重复的值
* has:查找值
* keys方法和values方法的行为完全一致
* WeakSet 的成员只能是对象，而不能是其他类型的值

## proxy

* 用于修改某些操作的默认行为，等同于在语言层面做出修改，所以属于一种“元编程”（meta programming），即对编程语言进行编程
* 在目标对象之前架设一层“拦截”，外界对该对象的访问，都必须先通过这层拦截，因此提供了一种机制，可以对外界的访问进行过滤和改写
* 专术名词：
  - target是指代理的原对象，它是需要拦截访问的原始对象，它总是作为Proxy构造器的第一个方法，也可以传递到每个trap中。
  - handler是一个包含要进行拦截和处理的对象，也就是拦截了原始对象以后想干什么？主要的代理内容在这里，是作为Proxy构造器的第二个方法参数传统，它是实现Proxy API。
  - trap用来规定对于指定什么方法进行拦截处理，如果想拦截get方法的调用，那么要定义一个get trap。
* 支持拦截操作
  - get(target, propKey, receiver)：拦截对象属性的读取，比如proxy.foo和proxy['foo']
  - set(target, propKey, value, receiver)：拦截对象属性的设置，比如proxy.foo = v或proxy['foo'] = v，返回一个布尔值
  - has(target, propKey)：拦截propKey in proxy的操作，返回一个布尔值。
  - deleteProperty(target, propKey)：拦截delete proxy[propKey]的操作，返回一个布尔值。
  - ownKeys(target)：拦截Object.getOwnPropertyNames(proxy)、Object.getOwnPropertySymbols(proxy)、Object.keys(proxy)、for...in循环，返回一个数组。该方法返回目标对象所有自身的属性的属性名，而Object.keys()的返回结果仅包括目标对象自身的可遍历属性。
  - getOwnPropertyDescriptor(target, propKey)：拦截Object.getOwnPropertyDescriptor(proxy, propKey)，返回属性的描述对象。
  - defineProperty(target, propKey, propDesc)：拦截Object.defineProperty(proxy, propKey, propDesc）、Object.defineProperties(proxy, propDescs)，返回一个布尔值。
  - preventExtensions(target)：拦截Object.preventExtensions(proxy)，返回一个布尔值。
  - getPrototypeOf(target)：拦截Object.getPrototypeOf(proxy)，返回一个对象。
  - isExtensible(target)：拦截Object.isExtensible(proxy)，返回一个布尔值。
  - setPrototypeOf(target, proto)：拦截Object.setPrototypeOf(proxy, proto)，返回一个布尔值。如果目标对象是函数，那么还有两种额外操作可以拦截。
  - apply(target, object, args)：拦截 Proxy 实例作为函数调用的操作，比如proxy(...args)、proxy.call(object, ...args)、proxy.apply(...)。
  - construct(target, args)：拦截 Proxy 实例作为构造函数调用的操作，比如new proxy(...args)
* 用法模式
  - 剥离校验代码

## Reflect

* 目的
  - 将Object对象的一些明显属于语言内部的方法（比如Object.defineProperty），放到Reflect对象上。现阶段，某些方法同时在Object和Reflect对象上部署，未来的新方法将只部署在Reflect对象上。也就是说，从Reflect对象上可以拿到语言内部的方法
  - 修改某些Object方法的返回结果，让其变得更合理。比如，Object.defineProperty(obj, name, desc)在无法定义属性时，会抛出一个错误，而Reflect.defineProperty(obj, name, desc)则会返回false
  - 让Object操作都变成函数行为。某些Object操作是命令式，比如name in obj和delete obj[name]，而Reflect.has(obj, name)和Reflect.deleteProperty(obj, name)让它们变成了函数行为
  - Reflect对象的方法与Proxy对象的方法一一对应，只要是Proxy对象的方法，就能在Reflect对象上找到对应的方法。这就让Proxy对象可以方便地调用对应的Reflect方法，完成默认行为，作为修改行为的基础。也就是说，不管Proxy怎么修改默认行为，你总可以在Reflect上获取默认行为
* 静态方法
  - Reflect.apply(target, thisArg, args)
  - Reflect.construct(target, args)
  - Reflect.get(target, name, receiver)
  - Reflect.set(target, name, value, receiver)
  - Reflect.defineProperty(target, name, desc)
  - Reflect.deleteProperty(target, name)
  - Reflect.has(target, name)
  - Reflect.ownKeys(target)
  - Reflect.isExtensible(target)
  - Reflect.preventExtensions(target)
  - Reflect.getOwnPropertyDescriptor(target, name)
  - Reflect.getPrototypeOf(target)
  - Reflect.setPrototypeOf(target, prototype)

## Promise

* 异步编程的一种解决方案
* 简单说就是一个容器，里面保存着某个未来才会结束的事件（通常是一个异步操作）的结果。从语法上说，Promise 是一个对象，从它可以获取异步操作的消息
* Promise 提供统一的 API，各种异步操作都可以用同样的方法进行处理
* 构造函数接受一个函数作为参数，该函数的两个参数分别是resolve和reject函数
  - resolve函数的作用是，将Promise对象的状态从“未完成”变为“成功”（即从 pending 变为 resolved），在异步操作成功时调用，并将异步操作的结果，作为参数传递出去
  - reject函数的作用是，将Promise对象的状态从“未完成”变为“失败”（即从 pending 变为 rejected），在异步操作失败时调用，并将异步操作报出的错误，作为参数传递出去
* 特点
  - 对象的状态不受外界影响。Promise对象代表一个异步操作，有三种状态：pending（进行中）、fulfilled（已成功）和rejected（已失败）。只有异步操作的结果，可以决定当前是哪一种状态，任何其他操作都无法改变这个状态。这也是Promise这个名字的由来，它的英语意思就是“承诺”，表示其他手段无法改变。
  - 一旦状态改变，就不会再变，任何时候都可以得到这个结果。Promise对象的状态改变，只有两种可能：从pending变为fulfilled和从pending变为rejected。只要这两种情况发生，状态就凝固了，不会再变了，会一直保持这个结果，这时就称为 resolved（已定型）
    + 如果改变已经发生了，再对Promise对象添加回调函数，也会立即得到这个结果。
    + 与事件（Event）完全不同，事件的特点是，如果错过了它，再去监听，是得不到结果的
* 缺点
  - 无法取消Promise，一旦新建它就会立即执行，无法中途取消
  - 如果不设置回调函数，Promise内部抛出的错误，不会反应到外部
  - 当处于pending状态时，无法得知目前进展到哪一个阶段
* 实例生成以后，可以用then方法分别指定resolved状态和rejected状态的回调函数
  - 第一个回调函数是Promise对象的状态变为resolved时调用，第二个回调函数是Promise对象的状态变为rejected时调用。其中，第二个函数是可选的，不一定要提供。这两个函数都接受Promise对象传出的值作为参数
* 采用链式的then，可以指定一组按照次序调用的回调函数。这时，前一个回调函数，有可能返回的还是一个Promise对象（即有异步操作），这时后一个回调函数，就会等待该Promise对象的状态发生变化，才会被调用
* catch()方法是.then(null, rejection)或.then(undefined, rejection)的别名，用于指定发生错误时的回调函数
* Promise.all()方法用于将多个 Promise 实例，包装成一个新的 Promise 实例
  - 参数可以不是数组，但必须具有 Iterator 接口，且返回的每个成员都是 Promise 实例

## 遍历器（Iterator）

* 一种接口，为各种不同的数据结构提供统一的访问机制。任何数据结构只要部署 Iterator 接口，就可以完成遍历操作（即依次处理该数据结构的所有成员）
* 作用
  - 为各种数据结构提供一个统一的、简便的访问接口
  - 使得数据结构的成员能够按某种次序排列
  - ES6 创造了一种新的遍历命令for...of循环，Iterator 接口主要供for...of消费
* 遍历过程
  - 创建一个指针对象，指向当前数据结构的起始位置。也就是说，遍历器对象本质上，就是一个指针对象。
  - 第一次调用指针对象的next方法，可以将指针指向数据结构的第一个成员。
  - 第二次调用指针对象的next方法，指针就指向数据结构的第二个成员。
  - 不断调用指针对象的next方法，直到它指向数据结构的结束位置
* 调用next方法，都会返回数据结构的当前成员的信息。具体来说，就是返回一个包含value和done两个属性的对象。其中，value属性是当前成员的值，done属性是一个布尔值，表示遍历是否结束
* 原生具备 Iterator 接口的数据结构
  - Array
  - Map
  - Set
  - String
  - TypedArray
  - 函数的 arguments 对象
  - NodeList 对象

## Generator

* ES6 提供的一种异步编程解决方案,协程在 ES6 的实现，最大特点就是可以交出函数的执行权（即暂停执行）
* 执行 Generator 函数
  - 状态机,封装了多个内部状态
  - 返回一个遍历器对象,可以遍历 Generator 函数内部的每一个状态
* 特征
  - function关键字与函数名之间有一个星号
  - 函数体内部使用yield表达式，定义不同的内部状态
* next方法
  - 可以带一个参数，该参数就会被当作上一个yield表达式的返回值
  - 从上次yield表达式停下的地方，一直执行到下一个yield表达式
  - 返回的对象的value属性就是当前yield表达式的值world，done属性的值false，表示遍历还没有结束
* yield
  - 遇到yield表达式，暂停执行后面的操作，并将紧跟在yield后面的那个表达式的值，作为返回的对象的value属性值
  - 下一次调用next方法时，再继续往下执行，直到遇到下一个yield表达式

### async await

* 异步:一个任务不是连续完成的，可以理解成该任务被人为分成两段，先执行第一段，然后转而执行其他任务，等做好了准备，再回过头执行第二段
* 回调函数
  - 把任务的第二段单独写在一个函数里面，等到重新执行这个任务的时候，就直接调用这个函数。回调函数的英语名字callback
* 事件监听
* 发布/订阅
* Promise 对象
* Generator 函数的语法糖

## 参考

* [standard-things/esm](https://github.com/standard-things/esm)：Tomorrow's ECMAScript modules today!
* [tc39/proposals](https://github.com/tc39/proposals):Tracking ECMAScript Proposals https://tc39.github.io/process-document/
* [bevacqua/es6](https://github.com/bevacqua/es6):🌟 ES6 Overview in 350 Bullet Points https://ponyfoo.com/articles/es6
* [ericdouglas/ES6-Learning](https://github.com/ericdouglas/ES6-Learning):📋 List of resources to learn ECMAScript 6!
* [metagrover/ES6-for-humans](https://github.com/metagrover/ES6-for-humans):A kickstarter guide to writing ES6
* [DrkSephy/es6-cheatsheet](https://github.com/DrkSephy/es6-cheatsheet):ES2015 [ES6] cheatsheet containing tips, tricks, best practices and code snippets http://slides.com/drksephy/ecmascript-2015

## 工具

* code generator
  - [estools/escodegen](https://github.com/estools/escodegen):ECMAScript code generator
* [addyosmani/es6-tools](https://github.com/addyosmani/es6-tools):An aggregation of tooling for using ES6 today
