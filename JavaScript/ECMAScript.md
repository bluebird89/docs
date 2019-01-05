# [tc39/ecma262](https://github.com/tc39/ecma262)

Status, process, and documents for ECMA262 https://tc39.github.io/ecma262/

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
