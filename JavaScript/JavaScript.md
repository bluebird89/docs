# JavaScript

JavaScript是世界上最流行的脚本语言。运行在浏览器中的解释型的编程语言。

在上个世纪的1995年，当时的网景公司正凭借其Navigator浏览器成为Web时代开启时最著名的第一代互联网公司。由于网景公司希望能在静态HTML页面上添加一些动态效果，于是叫Brendan Eich这哥们在两周之内设计出了JavaScript语言。你没看错，这哥们只用了10天时间。为什么起名叫JavaScript？原因是当时Java语言非常红火，所以网景公司希望借Java的名气来推广，但事实上JavaScript除了语法上有点像Java，其他部分基本上没啥关系。

因为网景开发了JavaScript，一年后微软又模仿JavaScript开发了JScript，为了让JavaScript成为全球标准，几个公司联合ECMA（European Computer Manufacturers Association）组织定制了JavaScript语言的标准，被称为ECMAScript标准。所以简单说来就是，ECMAScript是一种语言标准，而JavaScript是网景公司对ECMAScript标准的一种实现。

最新版ECMAScript 6标准（简称ES6）已经在2015年6月正式发布了，所以，讲到JavaScript的版本，实际上就是说它实现了ECMAScript标准的哪个版本。

## 基础入门

### 引入方式
* 由`<script>...</script>`包含的代码就是JavaScript代码，它将直接被浏览器执行。JavaScript代码可以直接嵌在网页的任何地方，不过通常我们都把JavaScript代码放到`<head>`中。
* 把JavaScript代码放到一个单独的.js文件，然后在HTML中通过`<script src="..."></script>`引入这个文件。更利于维护代码，并且多个页面可以各自引用同一份.js文件。以在同一个页面中引入多个.js文件，还可以在页面中多次编写`<script> js代码... </script>`，浏览器按照顺序依次执行
```html
<head>
  <script>
    alert('Hello, world');
  </script>
</head>

<script src="/static/js/abc.js"></script>
```

默认的type就是JavaScript，所以不必显式地把type指定为JavaScript

### 基础语法
* 每个语句以`;`结束，浏览器中负责执行JavaScript代码的引擎会自动在每个语句的结尾补上;。
* 语句块用{`...}`
* 以`//`开头直到行末的字符被视为行注释，注释是给开发人员看到，JavaScript引擎会自动忽略
* 块注释是用`/*...*/`把多行字符包裹起来

### 数据类型和变量

* Number:不区分整数和浮点数，统一用Number表示.有时候用十六进制表示整数比较方便，十六进制用0x前缀和0-9，a-f表示,以及运算符.NaN这个特殊的Number与所有其他值都不相等，包括它自己.唯一能判断NaN的方法是通过isNaN()函数.注意浮点数的相等比较(浮点数在运算过程中会产生误差，因为计算机无法精确表示无限循环小数。要比较两个浮点数是否相等，只能计算它们之差的绝对值，看是否小于某个阈值)
```javascript
123; // 整数123
0.456; // 浮点数0.456
1.2345e3; // 科学计数法表示1.2345x1000，等同于1234.5
-99; // 负数
NaN; // NaN表示Not a Number，当无法计算结果时用NaN表示
Infinity; // Infinity表示无限大，当数值超过了JavaScript的Number所能表示的最大值时，就表示为Infinity

1 + 2; // 3
(1 + 2) * 5 / 2; // 7.5
2 / 0; // Infinity
0 / 0; // NaN
10 % 3; // 1
10.5 % 3; // 1.5

NaN === NaN; // false
isNaN(NaN); // true
1 / 3 === (1 - 2 / 3); // false
Math.abs(1 / 3 - (1 - 2 / 3)) < 0.0000001; // true
```
* 字符串：以单引号`'`或双引号`"`括起来的任意文本
    - 如果`'`本身也是一个字符，那就可以用""括起来，比如`"I'm OK"`包含的字符是I，`'`，m，空格，O，K这6个字符。
    - `'I\'m \"OK\"!';` 转义字符`\`可以转义很多字符，比如`\n`表示换行，`\t`表示制表符，字符`\`本身也要转义，所以`\\`表示的字符就是`\`
    - ASCII字符可以以`\x##`形式的十六进制表示 `'\x41'; // 完全等同于 'A'`
    - 用`\u####`表示一个Unicode字符:`'\u4e2d\u6587'; // 完全等同于 '中文'`
    - 多行字符串,串用`\n`写起来比较费事，所以最新的ES6标准新增了一种多行字符串的表示方法，用反引号 ` ... ` 表示
    - 模板字符串
    ```javascript
    `这是一个
    多行
    字符串`;

    var name = '小明';
    var age = 20;
    var message = '你好, ' + name + ', 你今年' + age + '岁了!';
    var message = `你好, ${name}, 你今年${age}岁了!`;
    ```
    - 字符串操作
    ```javascript
    var s = 'Hello, world!';
    s.length; // 13

    s[0]; // 'H'
    s[6]; // ' '
    s[7]; // 'w'
    s[12]; // '!'
    s[13]; // undefined 超出范围的索引不会报错，但一律返回undefined

    s[0] = 'X';
    alert(s); // s仍然为'Test'

    s.toUpperCase();
    s.toLowerCase();
    s.indexOf('world'); // 指定字符串出现的第一个字符位置 返回7
    s.indexOf('World'); // 没有找到指定的子串，返回-1

    s.substring(0, 5); // 从索引0开始到5（不包括5），返回'hello'
    s.substring(7); // 从索引7开始到结束，返回'world'
    ```
* 布尔值和布尔代数的表示完全一致，一个布尔值只有true、false两种值.常用在条件判断中.`&&` 与运算 `||`和运算 `!`非运算.把null、undefined、0、NaN和空字符串''视为false，其他值一概视为true
```javascript
true; // 这是一个true值
false; // 这是一个false值
2 > 1; // 这是一个true值
2 >= 3; // 这是一个false值

true && true; // 这个&&语句计算结果为true
true && false; // 这个&&语句计算结果为false
false && true && false; // 这个&&语句计算结果为false

false || false; // 这个||语句计算结果为false
true || false; // 这个||语句计算结果为true
false || true || false; // 这个||语句计算结果为true

! true; // 结果为false
! false; // 结果为true
! (2 > 5); // 结果为true
```
* 比较运算符：`> = >= == `
    - `==`比较，它会自动转换数据类型再比较
    - `===`比较，它不会自动转换数据类型，如果数据类型不一致，返回false，如果一致，再比较
* null表示一个“空”的值，它和0以及空字符串`''`不同，0是一个数值，`''`表示长度为0的字符串，而null表示“空”。
* undefined表示值未定义:仅仅在判断函数参数是否传递的情况下有用
* 数组是一组按顺序排列的集合，集合的每个值称为元素.可以包含任意数据类型
    * 用`[]`表示，元素之间用`,`分隔
    * 通过索引来访问每个元素。
    * 取得Array的长度，直接访问length属性
    * 改变长度填充undefined或者删除多余元素
    * 通过索引修改值
    * indexOf()来搜索一个指定的元素的位置
    * slice截取Array的部分元素，然后返回一个新的Array. slice()的起止参数包括开始索引，不包括结束索引。如果不给slice()传递任何参数，它就会从头到尾截取所有元素
    * push()向Array的**末尾**添加若干元素，pop()则把Array的最后一个元素删除掉：
    * 往Array的**头部**添加若干元素，使用unshift()方法，shift()方法则把Array的第一个元素删掉
    * sort()可以对当前Array进行排序，它会直接修改当前Array的元素位置，直接调用时，按照默认顺序排序。
    * reverse()把整个Array的元素给掉个个，也就是反转
    * splice()方法是修改Array的“万能方法”，它可以从指定的索引开始删除若干元素，然后再从该位置添加若干元素
    * concat()方法把当前的Array和另一个Array连接起来，并返回一个新的Array。并没有修改当前Array，而是返回了一个新的Array。可以接收任意个元素和Array，并且自动把Array拆开，然后全部添加到新的Array里
    * join()当前Array的每个元素都用指定的字符串连接起来，然后返回连接后的字符串
    ```javascript
    var arr = [1, 2, 3.14, 'Hello', null, true];
    arr.length; // 6
    arr[0]; // 返回索引为0的元素，即1
    arr[5]; // 返回索引为5的元素，即true
    arr[6]; // 索引超出了范围，返回undefined

    arr.length = 7;
    arr; // arr变为[1, 2, 3.14, 'Hello', null, true, undefined]
    arr.length = 2;
    arr; // arr变为[1, 2]

    arr[1] = 99;  // 修改值

    arr[5] = 'x';
    arr; // arr变为[1, 2, 3, undefined, undefined, 'x']

    arr.indexOf(30); // 元素30没有找到，返回-1
    arr.indexOf('30'); // 元素'30'的索引为2

    var arr = ['A', 'B', 'C', 'D', 'E', 'F', 'G']; 
    arr.slice(0, 3); // 从索引0开始，到索引3结束，但不包括索引3: ['A', 'B', 'C']
    arr.slice(3); // 从索引3开始到结束: ['D', 'E', 'F', 'G']
    var aCopy = arr.slice();

    var arr = [1, 2];
    arr.push('A', 'B'); // 返回Array新的长度: 4
    arr; // [1, 2, 'A', 'B']
    arr.pop(); // pop()返回'B'
    arr; // [1, 2, 'A']
    arr.pop(); arr.pop(); arr.pop(); // 连续pop 3次
    arr; // []
    arr.pop(); // 空数组继续pop不会报错，而是返回undefined
    arr; // []

    var arr = [1, 2];
    arr.unshift('A', 'B'); // 返回Array新的长度: 4
    arr; // ['A', 'B', 1, 2]
    arr.shift(); // 'A'
    arr; // ['B', 1, 2]
    arr.shift(); arr.shift(); arr.shift(); // 连续shift 3次
    arr; // []
    arr.shift(); // 空数组继续shift不会报错，而是返回undefined
    arr; // []

    ar arr = ['Microsoft', 'Apple', 'Yahoo', 'AOL', 'Excite', 'Oracle'];
    // 从索引2开始删除3个元素,然后再添加两个元素:
    arr.splice(2, 3, 'Google', 'Facebook'); // 返回删除的元素 ['Yahoo', 'AOL', 'Excite']
    arr; // ['Microsoft', 'Apple', 'Google', 'Facebook', 'Oracle']
    // 只删除,不添加:
    arr.splice(2, 2); // ['Google', 'Facebook']
    arr; // ['Microsoft', 'Apple', 'Oracle']
    // 只添加,不删除:
    arr.splice(2, 0, 'Google', 'Facebook'); // 返回[],因为没有删除任何元素
    arr; // ['Microsoft', 'Apple', 'Google', 'Facebook', 'Oracle']

    var arr = ['A', 'B', 'C'];
    var added = arr.concat([1, 2, 3]);
    added; // ['A', 'B', 'C', 1, 2, 3]
    arr; // ['A', 'B', 'C']
    var arr = ['A', 'B', 'C'];
    arr.concat(1, 2, [3, 4]); // ['A', 'B', 'C', 1, 2, 3, 4]

    var arr = ['A', 'B', 'C', 1, 2, 3];
    arr.join('-'); // 'A-B-C-1-2-3'
    ```
* 对象是一组由键-值组成的无序集合.对象的键都是字符串类型，值可以是任意数据类型。用于描述现实世界中的某个对象.视为其他语言中的Map或Dictionary的数据结构
    - 用一个{...}表示一个对象，键值对以xxx: xxx形式申明，用,隔开。注意，最后一个键值对不需要在末尾加,
    - 访问属性是通过.操作符完成的，但这要求属性名必须是一个有效的变量名。如果属性名包含特殊字符，就必须用''括起来.访问这个属性也无法使用.操作符，必须用['xxx']来访问：
    - 自由地给一个对象添加或删除属性
    - 检测xiaoming是否拥有某一属性，可以用in操作符(如果in判断一个属性存在，这个属性不一定是xiaoming的，它可能是xiaoming继承得到的)
    - 要判断一个属性是否是xiaoming自身拥有的，而不是继承得到的，可以用hasOwnProperty()方法
```javascript
var person = {
    name: 'Bob',
    age: 20,
    tags: ['js', 'web', 'mobile'],
    city: 'Beijing',
    hasCar: true,
    'middle-school': 'No.1 Middle School',
    zipcode: null
};
person.name; // 'Bob'
person.zipcode; // null
person.address; // undefined
xiaohong['middle-school'];
person.address = 'shanghai'
delete person.address
'name' in xiaoming;
toString in xiaoming; // true  因为toString定义在object对象中，而所有对象最终都会在原型链上指向object
xiaoming.hasOwnProperty('name'); // true
xiaoming.hasOwnProperty('toString'); // false
```
### 变量
变量不仅可以是数字，还可以是任意数据类型。
* 变量名是大小写英文、数字、$和_的组合，且不能用数字开头。变量名也不能是JavaScript的关键字，如if、while等。申明一个变量用var语句。变量名也可以用中文，但是，请不要给自己找麻烦。
* 使用等号=对变量进行赋值。可以把任意数据类型赋值给变量，同一个变量可以反复赋值，而且可以是不同类型的变量，但是要注意只能用var申明一次。
* 变量本身类型不固定的语言称之为动态语言，与之对应的是静态语言。静态语言在定义变量时必须指定变量类型，如果赋值的时候类型不匹配，就会报错。例如Java是静态语言
* ECMA在后续规范中推出了strict模式，在strict模式下运行的JavaScript代码，强制通过var申明变量，未使用var申明变量就使用的，将导致运行错误。在JavaScript代码的第一行写上：`'use strict';`

### strict模式

JavaScript在设计之初，为了方便初学者学习，并不强制要求用var申明变量。这个设计错误带来了严重的后果：如果一个变量没有通过var申明就被使用，那么该变量就自动被申明为全局变量。
* 同一个页面的不同的JavaScript文件中，如果都不用var申明，恰好都使用了变量i，将造成变量i互相影响，产生难以调试的错误结果。
* 使用var申明的变量则不是全局变量，它的范围被限制在该变量被申明的函数体内（函数的概念将稍后讲解），同名变量在不同的函数体内互不冲突。

### 控制语句

* 条件语句：使用`if () { ... } else { ... }`来进行条件判断其中else语句是可选的。如果语句块只包含一条语句，那么可以省略`{}`.在多个if...else...语句中，如果某个条件成立，则后续就不再继续判断了(注意先后顺序)
* 循环语句：重复运算.务必小心编写初始条件和判断条件，尤其是边界值。特别注意i < 100和i <= 100是不同的判断逻辑。
    * for循环最常用的地方是利用索引来遍历数组；for循环的3个条件都是可以省略的，如果没有退出循环的判断条件，就必须使用break语句退出循环，否则就是死循环；
    * `for ... in`循环，它可以把一个对象的所有属性依次循环出来
    * while循环只有一个判断条件，条件满足，就不断循环，条件不满足时则退出循环
    * `do { ... } while()`和while循环的唯一区别在于，不是在每次循环开始的时候判断条件，而是在每次循环完成的时候判断条件：
* 
```javascript
var age = 20;
if (age >= 18) { // 如果age >= 18为true，则执行if语句块
    alert('adult');
} else { // 否则执行else语句块
    alert('teenager');
}

var age = 3;
if (age >= 18) {
    alert('adult');
} else if (age >= 6) {
    alert('teenager');
} else {
    alert('kid');
}

var x = 0;
var i;
for (i=1; i<=10000; i++) {
    x = x + i;
}
x;

var arr = ['Apple', 'Google', 'Microsoft'];
var i, x;
for (i=0; i<arr.length; i++) {
    x = arr[i];
    alert(x);
}

var x = 0;
for (;;) { // 将无限循环下去
    if (x > 100) {
        break; // 通过if判断来退出循环
    }
    x ++;
}

var o = {
    name: 'Jack',
    age: 20,
    city: 'Beijing'
};
for (var key in o) {
    if (o.hasOwnProperty(key)) {
        alert(key); // 'name', 'age', 'city'
    }
}

var a = ['A', 'B', 'C'];
for (var i in a) {
    alert(i); // '0', '1', '2'
    alert(a[i]); // 'A', 'B', 'C'
}

var x = 0;
var n = 99;
while (n > 0) {
    x = x + n;
    n = n - 2;
}
x;

var n = 0;
do {
    n = n + 1;
} while (n < 100);
n;
```

### Map Set iterable(ES6标准新增的数据类型)
* map:一组键值对的结构，具有极快的查找速度.根据同学的名字查找对应的成绩,用Map实现，只需要一个“名字”-“成绩”的对照表，直接根据名字查找成绩，无论这个表有多大，查找速度都不会变慢。一个key只能对应一个value，所以，多次对一个key放入value，后面的值会把前面的值冲掉
* set:一组key的集合，但不存储value。由于key不能重复，所以，在Set中，没有重复的key.重复元素在Set中自动被过滤
* 为了统一集合类型,ES6标准引入了新的iterable类型，Array、Map和Set都属于iterable类型,具有iterable类型的集合可以通过新的for ... of循环来遍历.for ... in循环由于历史遗留问题，它遍历的实际上是对象的属性名称。一个Array数组实际上也是一个对象，它的每个元素的索引被视为一个属性。给数组添加`a.name = 'Hello';`后，`for ... in`可以遍历出来name，而length却没有。`for ... of`循环则完全修复了这些问题，它只循环集合本身的元素
```javascript
var m = new Map([['Michael', 95], ['Bob', 75], ['Tracy', 85]]);
m.get('Michael');

var m = new Map(); // 空Map
m.set('Adam', 67); // 添加新的key-value
m.set('Bob', 59);
m.has('Adam'); // 是否存在key 'Adam': true
m.get('Adam'); // 67
m.delete('Adam'); // 删除key 'Adam'
m.get('Adam'); // undefined

var s1 = new Set(); // 空Set
var s2 = new Set([1, 2, 3]); // 含1, 2, 3
s.add(4)
s.delete(3);

var a = ['A', 'B', 'C'];
var s = new Set(['A', 'B', 'C']);
var m = new Map([[1, 'x'], [2, 'y'], [3, 'z']]);
for (var x of a) { // 遍历Array
    alert(x);
}
for (var x of s) { // 遍历Set
    alert(x);
}
for (var x of m) { // 遍历Map
    alert(x[0] + '=' + x[1]);
}

var a = ['A', 'B', 'C'];
a.forEach(function (element, index, array) {
    // element: 指向当前元素的值
    // index: 指向当前索引
    // array: 指向Array对象本身
    alert(element);
});
var s = new Set(['A', 'B', 'C']);
s.forEach(function (element, sameElement, set) {
    alert(element);
});
var m = new Map([[1, 'x'], [2, 'y'], [3, 'z']]);
m.forEach(function (value, key, map) {
    alert(value);
});
```

## 函数

函数是“头等公民”，而且可以像变量一样使用，具有非常强大的抽象能力。函数就是最基本的一种代码抽象的方式。能不关心底层的具体计算过程，而直接在更高的层次上思考问题。

* function指出这是一个函数定义；
* abs是函数的名称；
* (x)括号内列出函数的参数，多个参数以,分隔；
* { ... }之间的代码是函数体，可以包含若干语句，甚至可以没有任何语句
* 会先扫描整个函数体的语句，把所有申明的变量（而非赋值）“提升”到函数顶部.严格遵守“在函数内部首先申明所有变量”这一规则
* 一旦执行到return时，函数就执行完毕，并将结果返回,如果没有return语句，函数执行完毕后也会返回结果，只是结果为undefined.
* 由于JavaScript的函数也是一个对象，定义的abs()函数实际上是一个函数对象，而函数名abs可以视为指向该函数的变量。
* 调用函数：顺序传入参数即可；允许传入任意个参数而不影响调用，因此传入的参数比定义的参数多也没有问题；
* 参数检测：类型判断
* 关键字arguments，它只在函数内部起作用，并且永远指向当前函数的调用者传入的所有参数。arguments类似Array但它不是一个Array。利用arguments，你可以获得调用者传入的所有参数。也就是说，即使函数不定义任何参数，还是可以拿到参数的值。实际上arguments最常用于判断传入参数的个数
* ES6标准引入了rest参数:rest参数只能写在最后，前面用...标识，从运行结果可知，传入的参数先绑定已声明参数，多余的参数以数组形式交给变量rest，所以，不再需要arguments我们就获取了全部参数。

```javascript
function abs(x) {
    if (x >= 0) {
        return x;
    } else {
        return -x;
    }
}

function foo() {
    var x = 'Hello, ' + y;
    alert(x);
    var y = 'Bob';
}
foo(); //  Hello, undefined

function foo() {
    var
        x = 1, // x初始化为1
        y = x + 1, // y初始化为2
        z, i; // z和i为undefined
    // 其他语句:
    for (i=0; i<100; i++) {
        ...
    }
}

var abs = function (x) {
    if (x >= 0) {
        return x;
    } else {
        return -x;
    }
};

function foo() {
    if (arguments.length === 0) {
        return 0;
    }
    var x = arguments[0];
    return x >= 0 ? x : -x;
}
foo(-9);

function foo(a, b, ...rest) {
    console.log('a = ' + a);
    console.log('b = ' + b);
    console.log(rest);
}

foo(1, 2, 3, 4, 5);
```
### 变量作用域

* 全局作用域：JavaScript默认有一个全局对象window，全局作用域的变量实际上被绑定到window的一个属性
* 局部作用域：如果一个变量在函数体内部申明，则该变量的作用域为整个函数体，在函数体外不可引用该变量。
* 不同函数内部的同名变量互相独立，互不影响
* 函数可以嵌套，此时，内部函数可以访问外部函数定义的变量，反过来则不行：函数在查找变量时从自身函数定义开始，从“内”向“外”查找。如果内部函数定义了与外部函数重名的变量，则内部函数的变量将“屏蔽”外部函数的变量。

```javascript
function foo() {
    alert('foo');
}

foo(); // 直接调用foo()
window.foo(); // 通过window.foo()调用

window.alert('调用window.alert()');
// 把alert保存到另一个变量:
var old_alert = window.alert;
// 给alert赋一个新函数:
window.alert = function () {

}
alert('无法用alert()显示了!');
window.alert = old_alert;
alert('又可以用alert()了!');

// 测试:
var i, args = [];
for (i=1; i<=100; i++) {
    args.push(i);
}
if (sum() !== 0) {
    alert('测试失败: sum() = ' + sum());
} else if (sum(1) !== 1) {
    alert('测试失败: sum(1) = ' + sum(1));
} else if (sum(2, 3) !== 5) {
    alert('测试失败: sum(2, 3) = ' + sum(2, 3));
} else if (sum.apply(null, args) !== 5050) {
    alert('测试失败: sum(1, 2, 3, ..., 100) = ' + sum.apply(null, args));
} else {
    alert('测试通过!');
}
```
### 名字空间

* 不同的JavaScript文件如果使用了相同的全局变量，或者定义了相同名字的顶层函数，都会造成命名冲突。
* 把自己的代码全部放入唯一的名字空间MYAPP中，会大大减少全局变量冲突的可能。许多著名的JavaScript库都是这么干的：jQuery，YUI，underscore等等
* JavaScript的变量作用域实际上是函数内部，我们在for循环等语句块中是无法定义具有局部作用域的变量的。为了解决块级作用域，ES6引入了新的关键字let，用let替代var可以申明一个块级作用域的变量
```javascript
function foo() {
    for (var i=0; i<100; i++) {
        //
    }
    i += 100; // 仍然可以引用变量i
}

function foo() {
    var sum = 0;
    for (let i=0; i<100; i++) {
        sum += i;
    }
    i += 1; // SyntaxError
}
```
### 常量

要申明一个常量，在ES6之前是不行的，我们通常用全部大写的变量来表示“这是一个常量，不要修改它的值”

```javascript
var PI = 3.14;

const PI = 3.14;
PI = 3; // 某些浏览器不报错，但是无效果！
PI; // 3.14
```

### 方法

在一个对象中绑定函数，称为这个对象的方法。调用方法，要确定对象
* 在一个方法内部，this是一个特殊变量，它始终指向当前对象，**要保证this指向正确，必须用obj.xxx()的形式调用**
* 这是一个巨大的设计错误，要想纠正可没那么简单。ECMA决定，在strict模式下让函数的this指向undefined，因此，在strict模式下，你会得到一个错误
* 修复方法：用一个that变量首先捕获this
* 要指定函数的this指向哪个对象，可以用函数本身的apply方法，它接收两个参数，第一个参数就是需要绑定的this变量，第二个参数是Array，表示函数本身的参数
* 与apply()类似的方法是call()，普通函数调用，通常把this绑定为null
    - apply()把参数打包成Array再传入；
    - call()把参数按顺序传入。
* 装饰器：动态改变函数的行为。
```javascript
var xiaoming = {
    name: '小明',
    birth: 1990,
    age: function () {
        var y = new Date().getFullYear();
        return y - this.birth;
    }
};

xiaoming.age; // function xiaoming.age()
xiaoming.age(); // 今年调用是25,明年调用就变成26了
var fn = xiaoming.age; // 先拿到xiaoming的age函数
fn(); // NaN // strict模式下 Uncaught TypeError: Cannot read property 'birth' of undefined

'use strict';

var xiaoming = {
    name: '小明',
    birth: 1990,
    age: function () {
        function getAgeFromBirth() {
            var y = new Date().getFullYear();
            return y - this.birth;
        }
        return getAgeFromBirth();
    }
};

xiaoming.age(); // Uncaught TypeError: Cannot read property 'birth' of undefined
// 报错了！原因是this指针只在age方法的函数内指向xiaoming，在函数内部定义的函数，this又指向undefined了！（在非strict模式下，它重新指向全局对象window！）
 
'use strict';

var xiaoming = {
    name: '小明',
    birth: 1990,
    age: function () {
        var that = this; // 在方法内部一开始就捕获this
        function getAgeFromBirth() {
            var y = new Date().getFullYear();
            return y - that.birth; // 用that而不是this
        }
        return getAgeFromBirth();
    }
};

xiaoming.age(); // 25

function getAge() {
    var y = new Date().getFullYear();
    return y - this.birth;
}

var xiaoming = {
    name: '小明',
    birth: 1990,
    age: getAge
};

xiaoming.age(); // 25
getAge.apply(xiaoming, []); // 25, this指向xiaoming, 参数为空

Math.max.apply(null, [3, 5, 4]); // 5
Math.max.call(null, 3, 5, 4); // 5

// 想统计一下代码一共调用了多少次parseInt()
var count = 0;
var oldParseInt = parseInt; // 保存原函数

window.parseInt = function () {
    count += 1;
    return oldParseInt.apply(null, arguments); // 调用原函数
};

// 测试:
parseInt('10');
parseInt('20');
parseInt('30');
count; // 3
```

## 高阶函数 Higher-order function

函数其实都指向某个变量。既然变量可以指向函数，函数的参数能接收变量，那么一个函数就可以接收另一个函数作为参数，这种函数就称之为高阶函数。

* map()方法定义在JavaScript的Array中，调用Array的map()方法，传入自己的函数，就得到了一个新的Array作为结果
* Array的reduce()把一个函数作用在这个Array的[x1, x2, x3...]上，这个函数必须接收两个参数，reduce()把结果继续和序列的下一个元素做累积计算
* filter()用于把Array的某些元素过滤掉，然后返回剩下的元素,接收一个函数.把传入的函数依次作用于每个元素，然后根据返回值是true还是false决定保留还是丢弃该元素。
* sort():不同数据类型比较的过程必须通过函数抽象出来。Array的sort()方法：默认把所有元素先转换为String再排序. 默认算法：根据比较大小换位或者不换位

```javascript
function pow(x) {
    return x * x;
}

var arr = [1, 2, 3, 4, 5, 6, 7, 8, 9];
arr.map(pow); // [1, 4, 9, 16, 25, 36, 49, 64, 81]
arr.map(String); // ['1', '2', '3', '4', '5', '6', '7', '8', '9']

var arr = [1, 3, 5, 7, 9];
arr.reduce(function (x, y) {
    return x * 10 + y;
}); // 25

var arr = ['A', '', 'B', null, undefined, 'C', '  '];
var r = arr.filter(function (s) {
    return s && s.trim(); // 注意：IE9以下的版本没有trim()方法
});
r; // ['A', 'B', 'C']

var arr = ['A', 'B', 'C'];
var r = arr.filter(function (element, index, self) {
    console.log(element); // 依次打印'A', 'B', 'C'
    console.log(index); // 依次打印0, 1, 2
    console.log(self); // self就是变量arr
    return true;
});

['Google', 'apple', 'Microsoft'].sort(); // ['Google', 'Microsoft", 'apple']

var arr = [10, 20, 1, 2];
arr.sort(function (x, y) {
    if (x < y) {
        return -1;
    }
    if (x > y) {
        return 1;
    }
    return 0;
}); // [1, 2, 10, 20]

var arr = ['Google', 'apple', 'Microsoft'];
arr.sort(function (s1, s2) {
    x1 = s1.toUpperCase();
    x2 = s2.toUpperCase();
    if (x1 < x2) {
        return -1;
    }
    if (x1 > x2) {
        return 1;
    }
    return 0;
}); // ['apple', 'Google', 'Microsoft']
```

## 闭包

高阶函数除了可以接受函数作为参数外，还可以把函数作为结果值返回
* 在函数lazy_sum中又定义了函数sum，并且，内部函数sum可以引用外部函数lazy_sum的参数和局部变量，当lazy_sum返回函数sum时，**相关参数和变量都保存在返回的函数中**，这种称为“闭包（Closure）”。* 
* 当我们调用lazy_sum()时，每次调用都会返回一个新的函数，即使传入相同的参数。f1()和f2()的调用结果互不影响。
* 注意到返回的函数在其定义内部引用了局部变量arr，所以，当一个函数返回了一个函数后，其内部的局部变量还被新函数引用，所以，闭包用起来简单，实现起来可不容易。
* 返回的函数并没有立刻执行，而是直到调用了f()才执行：
* 返回闭包时牢记的一点就是：返回函数不要引用任何循环变量，或者后续会发生变化的变量：方法是再创建一个函数，用该函数的参数绑定循环变量当前的值，无论该循环变量后续如何更改，已绑定到函数参数的值不变。立即执行的匿名函数
* 在没有class机制，只有函数的语言里，借助闭包，同样可以封装一个私有变量
* 闭包就是携带状态的函数，并且它的状态可以完全对外隐藏起来。
* 可以把多参数的函数变成单参数的函数。
* 需要用函数，就可以用计算机实现运算，而不需要0、1、2、3这些数字和+、-、*、/这些符号
```javascript
function sum(arr) {
    return arr.reduce(function (x, y) {
        return x + y;
    });
}
sum([1, 2, 3, 4, 5]); // 15

function lazy_sum(arr) {
    var sum = function () {
        return arr.reduce(function (x, y) {
            return x + y;
        });
    }
    return sum;
}
var f = lazy_sum([1, 2, 3, 4, 5]); // function sum()
f(); // 15

var f1 = lazy_sum([1, 2, 3, 4, 5]);
var f2 = lazy_sum([1, 2, 3, 4, 5]);
f1 === f2; // false

function count() {
    var arr = [];
    for (var i=1; i<=3; i++) {
        arr.push(function () {
            return i * i;
        });
    }
    return arr;
}

var results = count();
var f1 = results[0];
var f2 = results[1];
var f3 = results[2];

f1(); // 16
f2(); // 16
f3(); // 16

// 原因就在于返回的函数引用了变量i，但它并非立刻执行。等到3个函数都返回时，它们所引用的变量i已经变成了4，因此最终结果为16
// 用了一个“创建一个匿名函数并立刻执行”的语法
// (function (x) {
//    return x * x;
// })(3); 
function count() {
    var arr = [];
    for (var i=1; i<=3; i++) {
        arr.push((function (n) {
            return function () {
                return n * n;
            }
        })(i));
    }
    return arr;
}

var results = count();
var f1 = results[0];
var f2 = results[1];
var f3 = results[2];

f1(); // 1
f2(); // 4
f3(); // 9

function create_counter(initial) {
    var x = initial || 0;
    return {
        inc: function () {
            x += 1;
            return x;
        }
    }
}
var c2 = create_counter(10);
c2.inc(); // 11
c2.inc(); // 12
c2.inc(); // 13

function make_pow(n) {
    return function (x) {
        return Math.pow(x, n);
    }
}

// 创建两个新函数:
var pow2 = make_pow(2);
var pow3 = make_pow(3);

// 定义数字0:
var zero = function (f) {
    return function (x) {
        return x;
    }
};

// 定义数字1:
var one = function (f) {
    return function (x) {
        return f(x);
    }
};

// 定义加法:
function add(n, m) {
    return function (f) {
        return function (x) {
            return m(f)(n(f)(x));
        }
    }
}
```
### 箭头函数
ES6标准新增了一种新的函数：Arrow Function（箭头函数）相当于匿名函数，并且简化了函数定义。箭头函数有两种格式:
* 一种只包含一个表达式，连{ ... }和return都省略掉了
* 一种可以包含多条语句，这时候就不能省略{ ... }和return：
* 参数不是一个，就需要用括号()括起来
* 箭头函数和匿名函数有个明显的区别：箭头函数内部的this是词法作用域，由上下文确定。箭头函数完全修复了this的指向，this总是指向词法作用域，也就是外层调用者obj.由于this在箭头函数中已经按照词法作用域绑定了，所以，用call()或者apply()调用箭头函数时，无法对this进行绑定，即传入的第一个参数被忽略

```javascript
x => x * x 

function (x) {
    return x * x;
}

(x, y, ...rest) => {
    var i, sum = x + y;
    for (i=0; i<rest.length; i++) {
        sum += rest[i];
    }
    return sum;
}

x => ({ foo: x }):// 要返回一个对象

var obj = {
    birth: 1990,
    getAge: function () {
        var b = this.birth; // 1990
        var fn = function () {
            return new Date().getFullYear() - this.birth; // this指向window或undefined
        };
        return fn();
    }
};

var obj = {
    birth: 1990,
    getAge: function () {
        var b = this.birth; // 1990
        var fn = () => new Date().getFullYear() - this.birth; // this指向obj对象
        return fn();
    }
};
obj.getAge(); // 25

var obj = {
    birth: 1990,
    getAge: function (year) {
        var b = this.birth; // 1990
        var fn = (y) => y - this.birth; // this.birth仍是1990
        return fn.call({birth:2000}, year);
    }
};
obj.getAge(2015); // 25
```
### generator
ES6标准引入的新的数据类型。一个generator看上去像一个函数，但可以返回多次.一个可以记住执行状态的函数，利用这一点，写一个generator就可以实现需要用面向对象才能实现的功能
* 由function*定义（注意多出的*号）
* 除了return语句，还可以用yield返回多次
* 创建了一个generator对象，并没有去执行它
    - 不断地调用generator对象的next()方法：会执行generator的代码，然后，每次遇到yield x;就返回一个对象{value: x, done: true/false}，然后“暂停”。返回的value就是yield的返回值，done表示这个generator是否已经执行结束了。如果done为true，则value就是return的返回值
    - 直接用for ... of循环迭代generator对象，这种方式不需要我们自己判断done
* 巨大的好处，就是把异步回调代码变成“同步”代码。这个好处要等到后面学了AJAX以后才能体会到。 
```javascript
function* foo(x) {
    yield x + 1;
    yield x + 2;
    return x + 3;
}

function fib(max) {
    var
        t,
        a = 0,
        b = 1,
        arr = [0, 1];
    while (arr.length < max) {
        t = a + b;
        a = b;
        b = t;
        arr.push(t);
    }
    return arr;
}

// 测试:
fib(5); // [0, 1, 1, 2, 3]
fib(10); // [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]

// fib(5)仅仅是创建了一个generator对象，还没有去执行它。
// 调用generator对象有两个方法，一是不断地调用generator对象的next()方法
function* fib(max) {
    var
        t,
        a = 0,
        b = 1,
        n = 1;
    while (n < max) {
        yield a;
        t = a + b;
        a = b;
        b = t;
        n ++;
    }
    return a;
}

var f = fib(5);
f.next(); // {value: 0, done: false}
f.next(); // {value: 1, done: false}
f.next(); // {value: 1, done: false}
f.next(); // {value: 2, done: false}
f.next(); // {value: 3, done: true}

for (var x of fib(5)) {
    console.log(x); // 依次输出0, 1, 1, 2, 3
}

var fib = {
    a: 0,
    b: 1,
    n: 0,
    max: 5,
    next: function () {
        var
            r = this.a,
            t = this.a + this.b;
        this.a = this.b;
        this.b = t;
        if (this.n < this.max) {
            this.n ++;
            return r;
        } else {
            return undefined;
        }
    }
};

ajax('http://url-1', data1, function (err, result) {
    if (err) {
        return handle(err);
    }
    ajax('http://url-2', data2, function (err, result) {
        if (err) {
            return handle(err);
        }
        ajax('http://url-3', data3, function (err, result) {
            if (err) {
                return handle(err);
            }
            return success(result);
        });
    });
});

try {
    r1 = yield ajax('http://url-1', data1);
    r2 = yield ajax('http://url-2', data2);
    r3 = yield ajax('http://url-3', data3);
    success(r3);
}
catch (err) {
    handle(err);
}
```

## 标准对象

* 在JavaScript的世界里，一切都是对象，用typeof操作符获取对象的类型.用typeof将无法区分出null、Array和通常意义上的object
* 包装对象：包装对象用new创建。看上去和原来的值一模一样，显示出来也是一模一样，但他们的类型已经变为object了！所以，包装对象和原始值用===比较会返回false。 所以闲的蛋疼也不要使用包装对象！尤其是针对string类型
* 不写new情况下，Number()、Boolean和String()被当做普通函数，把任何类型的数据转换为number、boolean和string类型
* 不要使用new Number()、new Boolean()、new String()创建包装对象；
* 用parseInt()或parseFloat()来转换任意类型到number；
* 用String()来转换任意类型到string，或者直接调用某个对象的toString()方法；
* 通常不必把任意类型转换为boolean再判断，因为可以直接写if (myVar) {...}；
* typeof操作符可以判断出number、boolean、string、function和undefined；
* 判断Array要使用Array.isArray(arr)；
* 判断null请使用myVar === null；
* 判断某个全局变量是否存在用typeof window.myVar === 'undefined'；
* 函数内部判断某个变量是否存在用typeof myVar === 'undefined'。
* null和undefined就没有toString()
```javascript
typeof 123; // 'number'
typeof NaN; // 'number'
typeof 'str'; // 'string'
typeof true; // 'boolean'
typeof undefined; // 'undefined'
typeof Math.abs; // 'function'
typeof null; // 'object'
typeof []; // 'object'
typeof {}; // 'object'

typeof new Number(123); // 'object'
new Number(123) === 123; // false
typeof new Boolean(true); // 'object'
new Boolean(true) === true; // false
typeof new String('str'); // 'object'
new String('str') === 'str'; // false

123..toString(); // '123', 注意是两个点！
(123).toString(); // '123'
```

### Date 
* 要获取系统当前时间,浏览器从本机操作系统获取的时间，所以不一定准确
* 因为用户可以把当前时间设定为任何值,月份为0-11
* 既可以显示本地时间，也可以显示调整后的UTC时间，只要我们传递的是一个number类型的时间戳，我们就不用关心时区转换。任何浏览器都可以把一个时间戳正确转换为本地时间。
* 时间戳是一个自增的整数，它表示从1970年1月1日零时整的GMT时区开始的那一刻，到现在的毫秒数。假设浏览器所在电脑的时间是准确的，那么世界上无论哪个时区的电脑，它们此刻产生的时间戳数字都是一样的，所以，时间戳可以精确地表示一个时刻，并且与时区无关。我们只需要传递时间戳，或者把时间戳从数据库里读出来，再让JavaScript自动转换为当地时间就可以了
```javascript
var now = new Date();
now; // Wed Jun 24 2015 19:49:22 GMT+0800 (CST)
now.getFullYear(); // 2015, 年份
now.getMonth(); // 5, 月份，注意月份范围是0~11，5表示六月
now.getDate(); // 24, 表示24号
now.getDay(); // 3, 表示星期三
now.getHours(); // 19, 24小时制
now.getMinutes(); // 49, 分钟
now.getSeconds(); // 22, 秒
now.getMilliseconds(); // 875, 毫秒数
now.getTime(); // 1435146562875, 以number形式表示的时间戳

var d = new Date(2015, 5, 19, 20, 15, 30, 123);
d; // Fri Jun 19 2015 20:15:30 GMT+0800 (CST)

// 创建一个指定日期和时间的方法是解析一个符合ISO 8601格式的字符串
var d = Date.parse('2015-06-24T19:49:22.875+08:00');
d; // 1435146562875
var d = new Date(1435146562875);
d; // Wed Jun 24 2015 19:49:22 GMT+0800 (CST)
d.toLocaleString(); // '2015/6/24 下午7:49:22'，本地时间（北京时区+8:00），显示的字符串与操作系统设定的格式有关
d.toUTCString(); // 'Wed, 24 Jun 2015 11:49:22 GMT'，UTC时间，与本地时间相差8小时
```

### RegExp

正则表达式是一种用来匹配字符串的强有力的武器。它的设计思想是用一种描述性的语言来给字符串定义一个规则，凡是符合规则的字符串，我们就认为它“匹配”了

* `\d`可以匹配一个数字，
* `\w`可以匹配一个字母或数字
* `.`可以匹配任意字符
* `*`表示任意个字符（包括0个），
* 用`+`表示至少一个字符，
* 用`?`表示0个或1个字符，
* 用`{n}`表示n个字符，
* 用`{n,m}`表示n-m个字符
* `A|B`可以匹配A或B
* `^`表示行的开头，`^\d`表示必须以数字开头。
* `$`表示行的结束，`\d$`表示必须以数字结束。
* 直接通过/正则表达式/写出来
* 通过new RegExp('正则表达式')创建一个RegExp对象
* 用正则表达式切分字符串比用固定的字符更灵活
* 提取子串的强大功能:用()表示的就是要提取的分组（Group）.在RegExp对象上用exec()方法提取出子串来。exec()方法在匹配成功后，会返回一个Array，第一个元素是正则表达式匹配到的整个字符串，后面的字符串表示匹配成功的子串。exec()方法在匹配失败时返回null。
* 正则匹配默认是贪婪匹配，也就是匹配尽可能多的字符。举例，匹配出数字后面的0：由于\d+采用贪婪匹配，直接把后面的0全部匹配了，结果0*只能匹配空字符串了。必须让\d+采用非贪婪匹配（也就是尽可能少匹配），才能把后面的0匹配出来，加个?就可以让\d+采用非贪婪匹配
* 全局匹配：`g`:可以多次执行exec()方法来搜索一个匹配的字符串。当我们指定g标志后，每次运行exec()，正则表达式本身会更新lastIndex属性，表示上次匹配到的最后索引.全局匹配类似搜索，因此不能使用/^...$/，那样只会最多匹配一次
* 指定i标志，表示忽略大小写
* m标志，表示执行多行匹配
```javascript
'00\d' //可以匹配'007'，但无法匹配'00A'；
'\d\d\d' //可以匹配'010'；
'\w\w' // 可以匹配'js'；
'js.' // 可以匹配'jsp'、'jss'、'js!'

`\d{3}` //表示匹配3个数字，例如'010'；
`\s` // 可以匹配一个空格（也包括Tab等空白符），所以\s+表示至少有一个空格，例如匹配' '，'\t\t'等；
`\d{3,8}`// 表示3-8个数字，例如'1234567'。

`[0-9a-zA-Z\_]`// 可以匹配一个数字、字母或者下划线；
`[0-9a-zA-Z\_]+` // 可以匹配至少由一个数字、字母或者下划线组成的字符串，比如'a100'，'0_Z'，'js2015'等等；
`[a-zA-Z\_\$][0-9a-zA-Z\_\$]*`// 可以匹配由字母或下划线、$开头，后接任意个由一个数字、字母或者下划线、$组成的字符串，也就是JavaScript允许的变量名；
`[a-zA-Z\_\$][0-9a-zA-Z\_\$]{0, 19}`// 更精确地限制了变量的长度是1-20个字符（前面1个字符+后面最多19个字符）。
`(J|j)ava(S|s)cript`// 可以匹配'JavaScript'、'Javascript'、'javaScript'或者'javascript'。
`^js$` // 就变成了整行匹配，就只能匹配'js'了

var re = /^\d{3}\-\d{3,8}$/;
var re2 = new RegExp('/^\d{3}\-\d{3,8}$/');

re.test('010-12345'); // true
re.test('010-1234x'); // false
re.test('010 12345'); // false

'a b   c'.split(/\s+/); // ['a', 'b', 'c']
'a,b, c  d'.split(/[\s\,]+/); // ['a', 'b', 'c', 'd'
'a,b;; c  d'.split(/[\s\,\;]+/); // ['a', 'b', 'c', 'd']

var re = /^(\d{3})-(\d{3,8})$/;
re.exec('010-12345'); // ['010-12345', '010', '12345']
re.exec('010 12345'); // null

var re = /^(0[0-9]|1[0-9]|2[0-3]|[0-9])\:(0[0-9]|1[0-9]|2[0-9]|3[0-9]|4[0-9]|5[0-9]|[0-9])\:(0[0-9]|1[0-9]|2[0-9]|3[0-9]|4[0-9]|5[0-9]|[0-9])$/; // 首部的0是做什么用的
re.exec('19:05:30'); // ['19:05:30', '19', '05', '30']

var re = /^(\d+)(0*)$/;
re.exec('102300'); // ['102300', '102300', '']

var re = /^(\d+?)(0*)$/;
re.exec('102300'); // ['102300', '1023', '00']

var s = 'JavaScript, VBScript, JScript and ECMAScript';
var re=/[a-zA-Z]+Script/g;

// 使用全局匹配:
re.exec(s); // ['JavaScript']
re.lastIndex; // 10
re.exec(s); // ['VBScript']
re.lastIndex; // 20
re.exec(s); // ['JScript']
re.lastIndex; // 29
re.exec(s); // ['ECMAScript']
re.lastIndex; // 44
re.exec(s); // null，直到结束仍没有匹配到
```

### JSON JavaScript Object Notation
* 一种数据交换格式,一共就这么几种数据类型：
    - number：和JavaScript的number完全一致；
    - boolean：就是JavaScript的true或false；
    - string：就是JavaScript的string；
    - null：就是JavaScript的null；
    - array：就是JavaScript的Array表示方式——[]；
    - object：就是JavaScript的{ ... }表示方式。
* 字符集必须是UTF-8
* 字符串规定必须用双引号""，Object的键也必须用双引号""。
* 在JavaScript中，可以直接使用JSON，因为JavaScript内置了JSON的解析。
* 序列化：把这个对象序列化成一个JSON格式的字符串，这样才能够通过网络传递给其他计算机:`JSON.stringify(obj, null, '   '); ` 第一个参数是对象；第二个参数用于控制如何筛选对象的键值，如果我们只想输出指定的属性，可以传入Array或者处理函数；第三个参数是输出缩进。要精确控制如何序列化小明，可以给xiaoming定义一个toJSON()的方法，直接返回JSON应该序列化的数据
* 反序列化：收到一个JSON格式的字符串，只需要把它反序列化成一个JavaScript对象，就可以在JavaScript中直接使用这个对象了
```javascript
var xiaoming = {
    name: '小明',
    age: 14,
    gender: true,
    height: 1.65,
    grade: null,
    'middle-school': '\"W3C\" Middle School',
    skills: ['JavaScript', 'Java', 'Python', 'Lisp']
};

JSON.stringify(xiaoming); // '{"name":"小明","age":14,"gender":true,"height":1.65,"grade":null,"middle-school":"\"W3C\" Middle School","skills":["JavaScript","Java","Python","Lisp"]}'
JSON.stringify(xiaoming, null, '  '); //输出得好看一些，可以加上参数，按缩进输出
JSON.stringify(xiaoming, ['name', 'skills'], '  ');  // 输出指定属性
function convert(key, value) {
    if (typeof value === 'string') {
        return value.toUpperCase();
    }
    return value;
}

JSON.stringify(xiaoming, convert, '  ');

var xiaoming = {
    name: '小明',
    age: 14,
    gender: true,
    height: 1.65,
    grade: null,
    'middle-school': '\"W3C\" Middle School',
    skills: ['JavaScript', 'Java', 'Python', 'Lisp'],
    toJSON: function () {
        return { // 只输出name和age，并且改变了key：
            'Name': this.name,
            'Age': this.age
        };
    }
};

JSON.stringify(xiaoming); // '{"Name":"小明","Age":14}'

JSON.parse('[1,2,3,true]'); // [1, 2, 3, true]
JSON.parse('{"name":"小明","age":14}'); // Object {name: '小明', age: 14}
JSON.parse('true'); // true
JSON.parse('123.45'); // 123.45

JSON.parse('{"name":"小明","age":14}', function (key, value) {
    // 把number * 2:
    if (key === 'name') {
        return value + '同学';
    }
    return value;
}); // Object {name: '小明同学', age: 14}
```

## 面向对象编程（设计模式）

* 类：类是对象的类型模板，例如，定义Student类来表示学生，类本身是一种类型，Student表示学生类型，但不表示任何具体的某个学生；
* 实例：实例是根据类创建的对象，例如，根据Student类可以创建出xiaoming、xiaohong、xiaojun等多个实例，每个实例表示一个具体的学生，他们全都属于Student类型。
* JavaScript不区分类和实例的概念，而是通过原型（prototype）来实现面向对象编程。
* 对象模型是基于原型实现的，特点是简单，缺点是理解起来比传统的类－实例模型要困难，
* 最大的缺点是继承的实现需要编写大量代码，并且需要正确实现原型链。
```javascript
var Bird = {
    fly: function () {
        console.log(this.name + ' is flying...');
    }
};

xiaoming.__proto__ = Bird;

// 原型对象:
var Student = {
    name: 'Robot',
    height: 1.2,
    run: function () {
        console.log(this.name + ' is running...');
    }
};

function createStudent(name) {
    // 基于Student原型创建一个新对象:
    var s = Object.create(Student);
    // 初始化新对象:
    s.name = name;
    return s;
}

var xiaoming = createStudent('小明');
xiaoming.run(); // 小明 is running...
xiaoming.__proto__ === Student; // true
```

### 创建对象
JavaScript对每个创建的对象都会设置一个原型，指向它的原型对象。
* 当我们用obj.xxx访问一个对象的属性时，JavaScript引擎先在当前对象上查找该属性，如果没有找到，就到其原型对象上找，如果还没有找到，就一直上溯到Object.prototype对象，最后，如果还没有找到，就只能返回undefined。原型链比如：`arr ----> Array.prototype ----> Object.prototype ----> null`
* 访问一个对象的属性就会因为花更多的时间查找而变得更慢，因此要注意不要把原型链搞得太长。
* 声明函数，通过关键字new来调用这个函数（写了new，它就变成了一个构造函数，它绑定的this指向新创建的对象，并默认返回this，也就是说，不需要在最后写return this;），并返回一个对象
* 用new Student()创建的对象还从原型上获得了一个constructor属性，它指向函数Student本身。通过构造函数提升对象
* 对象的hello函数实际上只需要共享同一个函数就可以了，这样可以节省很多内存。只要把hello函数移动到xiaoming、xiaohong这些对象共同的原型上就可以了，也就是Student.prototype
* 调用构造函数千万不要忘记写new。为了区分普通函数和构造函数，按照约定，构造函数首字母应当大写，而普通函数首字母应当小写
* 一是不需要new来调用，二是参数非常灵活，可以不传，也可以这么传。如果创建的对象有很多属性，我们只需要传递需要的某些属性，剩下的属性可以用默认值。由于参数是一个Object，我们无需记忆参数的顺序。如果恰好从JSON拿到了一个对象，就可以直接创建出xiaoming。
![原型链](。。/_static/js-link.png "Optional title")
![通用方法升级到原型中去](。。/_static/js-link-1.png "Optional title")
```javascript
function Student(name) {
    this.name = name;
    this.hello = function () {
        alert('Hello, ' + this.name + '!');
    }
}

// 原型链：xiaoming ----> Student.prototype ----> Object.prototype ----> null
var xiaoming = new Student('小明');
xiaoming.name; // '小明'
xiaoming.hello(); // Hello, 小明!

xiaoming.constructor === Student.prototype.constructor; // true
Student.prototype.constructor === Student; // true
Object.getPrototypeOf(xiaoming) === Student.prototype; // true
xiaoming instanceof Student; // true

xiaoming.hello === xiaohong.hello; // false

function Student(name) {
    this.name = name;
}

Student.prototype.hello = function () {
    alert('Hello, ' + this.name + '!');
};

// 升级
function Student(props) {
    this.name = props.name || '匿名'; // 默认值为'匿名'
    this.grade = props.grade || 1; // 默认值为1
}

Student.prototype.hello = function () {
    alert('Hello, ' + this.name + '!');
};

function createStudent(props) {
    return new Student(props || {})
}
var xiaoming = createStudent({
    name: '小明'
});
xiaoming.grade;
```

### 原型继承
* 要基于Student扩展出PrimaryStudent，可以先定义出PrimaryStudent
* 原型链目标：`new PrimaryStudent() ----> PrimaryStudent.prototype ----> Student.prototype ----> Object.prototype ----> null`
* 函数F仅用于桥接，我们仅创建了一个new F()实例，而且，没有改变原有的Student定义的原型链。如果把继承这个动作用一个inherits()函数封装起来，还可以隐藏F的定义，并简化代码
* 定义新的构造函数，并在内部用call()调用希望“继承”的构造函数，并绑定this； 新的简化方法思路不一样，inherits中的构造与父类一级
* 借助中间函数F实现原型链继承，最好通过封装的inherits函数完成；
* 继续在新的构造函数的原型上定义新方法。
![原型链](../_static/js-link3png "Optional title")
```javascript
// PrimaryStudent构造函数:
function PrimaryStudent(props) {
    Student.call(this, props);
    this.grade = props.grade || 1;
}

// 空函数F:
function F() {
}

// 把F的原型指向Student.prototype:
F.prototype = Student.prototype;

// 把PrimaryStudent的原型指向一个新的F对象，F对象的原型正好指向Student.prototype:
PrimaryStudent.prototype = new F();

// 把PrimaryStudent原型的构造函数修复为PrimaryStudent:
PrimaryStudent.prototype.constructor = PrimaryStudent;

// 继续在PrimaryStudent原型（就是new F()对象）上定义方法：
PrimaryStudent.prototype.getGrade = function () {
    return this.grade;
};

// 创建xiaoming:
var xiaoming = new PrimaryStudent({
    name: '小明',
    grade: 2
});
xiaoming.name; // '小明'
xiaoming.grade; // 2

// 验证原型:
xiaoming.__proto__ === PrimaryStudent.prototype; // true
xiaoming.__proto__.__proto__ === Student.prototype; // true

// 验证继承关系:
xiaoming instanceof PrimaryStudent; // true
xiaoming instanceof Student; // true

function inherits(Child, Parent) {
    var F = function () {};
    F.prototype = Parent.prototype;
    Child.prototype = new F();
    Child.prototype.constructor = Child;
}
function Student(props) {
    this.name = props.name || 'Unnamed';
}

Student.prototype.hello = function () {
    alert('Hello, ' + this.name + '!');
}

function PrimaryStudent(props) {
    Student.call(this, props);
    this.grade = props.grade || 1;
}

// 实现原型继承链:
inherits(PrimaryStudent, Student);

// 绑定其他方法到PrimaryStudent原型:
PrimaryStudent.prototype.getGrade = function () {
    return this.grade;
};
```

### class继承

关键字class从ES6开始正式被引入到JavaScript中。class的目的就是让定义类更简单。
* class的作用就是让JavaScript引擎去实现原来需要我们自己编写的原型链代码。简而言之，用class的好处就是极大地简化了原型链代码
* class的定义包含了构造函数constructor与定义在原型对象上的函数hello()
* 继承 extends更方便。需要通过super(name)来调用父类的构造函数，否则父类的name属性无法正常初始化。
* 不是所有的主流浏览器都支持ES6的class。如果一定要现在就用上，就需要一个工具把class代码转换为传统的prototype代码，可以试试Babel这个工具
```javascript
class Student {
    constructor(name) {
        this.name = name;
    }

    hello() {
        alert('Hello, ' + this.name + '!');
    }
}
var xiaoming = new Student('小明');
xiaoming.hello();

class PrimaryStudent extends Student {
    constructor(name, grade) {
        super(name); // 记得用super调用父类的构造方法!
        this.grade = grade;
    }

    myGrade() {
        alert('I am at grade ' + this.grade);
    }
}
```

## 浏览器

* Google基于Webkit
* Safari Webkit内核
* Firefox自己研制的Gecko内核

### 浏览器对象

JavaScript可以获取浏览器提供的很多对象，并进行操作。
* window对象不但充当全局作用域，而且表示浏览器窗口：
    * `window.innerWidth`
    * `window.innerHeight`
    * `window.outerWidth`
    * `window.outerHeight`
* navigator对象表示浏览器的信息.navigator的信息可以很容易地被用户修改，所以JavaScript读取的值不一定是正确的
    - `navigator.appName`：浏览器名称；
    - `navigator.appVersion`：浏览器版本；
    - `navigator.language`：浏览器设置的语言；
    - `navigator.platfor`m：操作系统类型；
    - `navigator.userAgent`：浏览器设定的User-Agent字符串。
* screen对象表示屏幕的信息
    - screen.width：屏幕宽度，以像素为单位；
    - screen.height：屏幕高度，以像素为单位；
    - screen.colorDepth：返回颜色位数，如8、16、24
* location对象表示当前页面的URL信息
    - location.href: http://www.example.com:8080/path/index.html?a=1&b=2#TOP
    - location.protocol; // 'http'
    - location.host; // 'www.example.com'
    - location.port; // '8080'
    - location.pathname; // '/path/index.html'
    - location.search; // '?a=1&b=2'
    - location.hash; // 'TOP'
    - 要加载一个新页面，可以调用location.assign('/discuss')。如果要重新加载当前页面，调用location.reload();
* document对象表示当前页面。由于HTML在浏览器中以DOM形式表示为树形结构，document对象就是整个DOM树的根节点。
    - title赋值：document.title = '努力学习JavaScript!';
    - 要查找DOM树的某个节点，需要从document对象开始查找。最常用的查找是根据ID和Tag Name
    - document.getElementById('drink-menu')
    - document.getElementsByTagName('dt')
    - menu.tagName;
    - Cookie是由服务器发送的key-value标示符。因为HTTP协议是无状态的，但是服务器要区分到底是哪个用户发过来的请求，就可以用Cookie来区分。当一个用户成功登录后，服务器发送一个Cookie给浏览器，例如user=ABC123XYZ(加密的字符串)...，此后，浏览器访问该网站时，会在请求头附上这个Cookie，服务器根据Cookie即可区分出用户。 `document.cookie`
    - `<script src="http://www.foo.com/jquery.js"></script>`  引入的第三方的JavaScript中存在恶意代码，则www.foo.com网站将直接获取到www.example.com网站的用户登录信息.服务器在设置Cookie时可以使用httpOnly，`设定了httpOnly的Cookie将不能被JavaScript读取`
- history对象保存了浏览器的历史记录，JavaScript可以调用history对象的back()或forward ().

### 操作DOM

由于HTML文档被浏览器解析后就是一棵DOM树，要改变HTML的结构，就需要通过JavaScript来操作DOM.DOM节点是指Element，但是DOM节点实际上是Node，在HTML中，Node包括Element、Comment、CDATA_SECTION等很多种，以及根节点Document类型，但是，绝大多数时候我们只关心Element，也就是实际控制页面结构的Node，其他类型的Node忽略即可。根节点Document已经自动绑定为全局变量document。

* document.getElementById() 可以直接定位唯一的一个DOM节点
* document.getElementsByTagName() 总是返回一组DOM节点
* CSS选择器document.getElementsByClassName() 返回一组DOM节点
* 使用querySelector()和querySelectorAll()

- 更新：更新该DOM节点的内容，相当于更新了该DOM节点表示的HTML的内容
    + innerText不返回隐藏元素的文本，而textContent返回所有文本
    + 如果这个DOM节点是空的，例如，<div></div>，那么，直接使用innerHTML = '<span>child</span>'就可以修改DOM节点的内容，相当于“插入”了新的DOM节点。如果这个DOM节点不是空的，那就不能这么做，因为innerHTML会直接替换掉原来的所有子节点。
- 遍历：遍历该DOM节点下的子节点，以便进行进一步操作；
- 添加：在该DOM节点下新增一个子节点，相当于动态增加了一个HTML节点；
    + 使用appendChild，把一个子节点添加到父节点的最后一个子节点.插入的js节点已经存在于当前的文档树，因此这个节点首先会从原先的位置删除，再插入到新的位置。
    + 动态创建一个节点然后添加到DOM树中:从零创建一个新的节点，然后插入到指定位置
    + parentElement.insertBefore(newElement, referenceElement);，子节点会插入到referenceElement之前。
- 删除：将该节点从HTML中删除，相当于删掉了该DOM节点的内容以及它包含的所有子节点。
    + 要删除一个节点，首先要获得该节点本身以及它的父节点，然后，调用父节点的removeChild把自己删掉
    + 当<p>First</p>节点被删除后，parent.children的节点数量已经从2变为了1，索引[1]已经不存在了。

```html
<p id="js">JavaScript</p>
<div id="list">
    <p id="java">Java</p>
    <p id="python">Python</p>
    <p id="scheme">Scheme</p>
</div>

<div id="parent">
    <p>First</p>
    <p>Second</p>
</div>
```

```javascript
// 返回ID为'test'的节点：
var test = document.getElementById('test');

// 先定位ID为'test-table'的节点，再返回其内部所有tr节点：
var trs = document.getElementById('test-table').getElementsByTagName('tr');

// 先定位ID为'test-div'的节点，再返回其内部所有class包含red的节点：
var reds = document.getElementById('test-div').getElementsByClassName('red');

// 获取节点test下的所有直属子节点:
var cs = test.children;

// 获取节点test下第一个、最后一个子节点：
var first = test.firstElementChild;
var last = test.lastElementChild;

// 通过querySelector获取ID为q1的节点：
var q1 = document.querySelector('#q1');

// 通过querySelectorAll获取q1节点内的符合条件的所有节点：
var ps = q1.querySelectorAll('div.highlighted > p');

// 获取<p id="p-id">...</p>
var p = document.getElementById('p-id');
// 设置文本为abc:
p.innerHTML = 'ABC'; // <p id="p-id">ABC</p>
// 设置HTML:
p.innerHTML = 'ABC <span style="color:red">RED</span> XYZ'; // <p>...</p>的内部结构已修改

p.innerText = '<script>alert("Hi")</script>';
// HTML被自动编码，无法设置一个<script>节点:
// <p id="p-id">&lt;script&gt;alert("Hi")&lt;/script&gt;</p>
p.style.color = '#ff0000';
p.style.fontSize = '20px';
p.style.paddingTop = '2em';

var
    js = document.getElementById('js'),
    list = document.getElementById('list');
list.appendChild(js);

var haskell = document.createElement('p');
haskell.id = 'haskell';
haskell.innerText = 'Haskell';
list.appendChild(haskell);

var d = document.createElement('style');
d.setAttribute('type', 'text/css');
d.innerHTML = 'p { color: red }';
document.getElementsByTagName('head')[0].appendChild(d);

var ref = document.getElementById('python');
list.insertBefore(haskell, ref);

var
    i, c,
    list = document.getElementById('list');
for (i = 0; i < list.children.length; i++) {
    c = list.children[i]; // 拿到第i个子节点
}

var parent = document.getElementById('parent');
parent.removeChild(parent.children[0]);
parent.removeChild(parent.children[1]); // <-- 浏览器报错
```

### 操作表单



## 调试

* 可以直接在develop中的console中测试代码
* 根据需求写测试代码

## [框架](https://envato.com/blog/rising-trends-in-javascript/)

MVC

- Angular
- React
- [Marionette](https://marionettejs.com/)

MVVM

- Vue
- [Foundation](http://foundation.zurb.com/)
- Typescript
- ES6

Nodejs

- 框架：Sails.js

SPA

- [Meteor](https://www.meteor.com/)
- jQuery Mobile

Data Visualization

- [D3.js](https://d3js.org/)
- React Native
- jQuery
- [Underscore.js](http://underscorejs.org/)

# IDE：

- Sublime Text
- WebStorm
- Brackets
- Atom

# 代码整理工具：

- JSLint
- JSHint

# 构建与自动化工具

- NPM
- Grunt
- Gulp

## AJAX

同步：占对象，会降低并发，顺序执行 
异步：响应好，并发高，并行

# 其它

- [jquery-validation](https://github.com/jquery-validation/jquery-validation)

  - clone本地，grunt安装，编译
  - test中的index.html会有测试断言

## style guide

[airbnb/javascript](https://github.com/airbnb/javascript)

## 资源

- [JavaScript深入系列15篇](https://juejin.im/post/59278e312f301e006c2e1510)
- [sorrycc/awesome-javascript](https://github.com/sorrycc/awesome-javascript)
- [avajs/ava](https://github.com/avajs/ava)Futuristic JavaScript test runner
- [moon](http://moonjs.ga/docs/getting-started.html)
- [JavaScript文档](https://developer.mozilla.org/en-US/docs/Web/JavaScript)
- [mbeaudru/modern-js-cheatsheet](https://github.com/mbeaudru/modern-js-cheatsheet):Cheatsheet for the JavaScript knowledge you will frequently encounter in modern projects. https://mbeaudru.github.io/modern-js-…

## Web APIS

- [Web APIs](https://developer.mozilla.org/en-US/docs/Web/API)

## 教程

* [JavaScript全栈教程](https://www.liaoxuefeng.com/wiki/001434446689867b27157e896e74d51a89c25cc8b43bdb3000)

## 测试

* [facebook/jest](https://github.com/facebook/jest):Delightful JavaScript Testing. http://facebook.github.io/jest/

## 框架

* [ecomfe/echarts](https://github.com/ecomfe/echarts):A powerful, interactive charting and visualization library for browser http://echarts.baidu.com/

## 工具

* [t4t5/sweetalert](https://github.com/t4t5/sweetalert):A beautiful replacement for JavaScript's "alert" https://sweetalert.js.org
* [Modernizr/Modernizr](https://github.com/Modernizr/Modernizr):Modernizr is a JavaScript library that detects HTML5 and CSS3 features in the user’s browser. https://modernizr.com
* [mozilla/pdf.js](https://github.com/mozilla/pdf.js):PDF Reader in JavaScript
* [mozilla-neutrino/neutrino-dev](https://github.com/mozilla-neutrino/neutrino-dev):Create and build modern JavaScript applications with zero initial configuration. https://neutrino.js.org
* [facebook/immutable-js](https://github.com/facebook/immutable-js):Immutable persistent data collections for Javascript which increase efficiency and simplicity. http://facebook.github.io/immutable-js/

## 扩展

* [Microsoft/napajs](https://github.com/Microsoft/napajs):Napa.js: a multi-threaded JavaScript runtime
