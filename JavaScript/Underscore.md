# underscore

JavaScript是函数式编程语言，支持高阶函数和闭包.可是Object实现map()和filter()方法，underscore则提供了一套完善的函数式编程的接口，让我们更方便地在JavaScript中实现函数式编程。

在加载时，会把自身绑定到唯一的全局变量_上，这也是为啥它的名字叫underscore的原因。


## 使用

```js
_.map([1, 2, 3], (x) => x * x); // [1, 4, 9]
_.map({ a: 1, b: 2, c: 3 }, (v, k) => k + '=' + v); // ['a=1', 'b=2', 'c=3']
```

### Collections

underscore为集合类对象提供了一致的接口。集合类是指Array和Object，暂不支持Map和Set。
* map()操作的返回结果是Array
* mapObject()返回对象
* 当集合的所有元素都满足条件时，_.every()函数返回true，
* 当集合的至少一个元素满足条件时，_.some()函数返回true：
* max / min：这两个函数直接返回集合中最大和最小的数，如果集合是Object，max()和min()只作用于value，忽略掉key：
* groupBy()把集合的元素按照key归类，key由传入的函数返回
* shuffle()用洗牌算法随机打乱一个集合
* sample()则是随机选择一个或多个元素

```js
var obj = {
    name: 'bob',
    school: 'No.1 middle school',
    address: 'xueyuan road'
};
var upper = _.map(obj, function (value, key) {
    return value.toUpperCase();
});

alert(JSON.stringify(upper));

// 所有元素都大于0？
_.every([1, 4, 7, -3, -9], (x) => x > 0); // false
// 至少一个元素大于0？
_.some([1, 4, 7, -3, -9], (x) => x > 0); // true
function isLowerCase(text)
{
 return text.toString().toLowerCase()===text;
}
var r1 = _.every(obj, function (value, key) { // 判断是否全小写
    return isLowerCase(value)&&isLowerCase(key);
});
var r2 = _.some(obj, function (value, key) {
    return isLowerCase(value)&&isLowerCase(key);
});

var arr = [3, 5, 7, 9];
_.max(arr); // 9
_.min(arr); // 3

// 空集合会返回-Infinity和Infinity，所以要先判断集合不为空：
_.max([])
-Infinity
_.min([])
Infinity
_.max({ a: 1, b: 2, c: 3 }); // 3

var scores = [20, 81, 75, 40, 91, 59, 77, 66, 72, 88, 99];
var groups = _.groupBy(scores, function (x) {
    if (x < 60) {
        return 'C';
    } else if (x < 80) {
        return 'B';
    } else {
        return 'A';
    }
});
// 结果:
// {
//   A: [81, 91, 88, 99],
//   B: [75, 77, 66, 72],
//   C: [20, 40, 59]
// }

_.shuffle([1, 2, 3, 4, 5, 6]); // [3, 5, 4, 6, 2, 1]
_.sample([1, 2, 3, 4, 5, 6]); // 2
_.sample([1, 2, 3, 4, 5, 6], 3); // [6, 1, 4]
```

### Array

* first / last：这两个函数分别取第一个和最后一个元素：
* flatten()接收一个Array，无论这个Array里面嵌套了多少个Array，flatten()最后都把它们变成一个一维数组
* zip()把两个或多个数组的所有元素按索引对齐，然后按索引合并成新数组。例如，你有一个Array保存了名字，另一个Array保存了分数，现在，要把名字和分数给对上，用zip()轻松实现：unzip()则是反过来
* object()函数把名字和分数直接对应成Object
* range()让你快速生成一个序列

```js
var arr = [2, 4, 6, 8];
_.first(arr); // 2
_.last(arr); // 8

_.flatten([1, [2], [3, [[4], [5]]]]); // [1, 2, 3, 4, 5]

var names = ['Adam', 'Lisa', 'Bart'];
var scores = [85, 92, 59];
_.zip(names, scores);
// [['Adam', 85], ['Lisa', 92], ['Bart', 59]]
 
var namesAndScores = [['Adam', 85], ['Lisa', 92], ['Bart', 59]];
_.unzip(namesAndScores);
// [['Adam', 'Lisa', 'Bart'], [85, 92, 59]]
 
var names = ['Adam', 'Lisa', 'Bart'];
var scores = [85, 92, 59];
_.object(names, scores);
// {Adam: 85, Lisa: 92, Bart: 59}

// 从0开始小于10:
_.range(10); // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
// 从1开始小于11：
_.range(1, 11); // [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
// 从0开始小于30，步长5:
_.range(0, 30, 5); // [0, 5, 10, 15, 20, 25]
// 从0开始大于-10，步长-1:
_.range(0, -10, -1); // [0, -1, -2, -3, -4, -5, -6, -7, -8, -9]
```

### Functions

* bind(): 当用一个变量fn指向一个对象的方法时，直接调用fn()是不行的，因为丢失了this对象的引用。用bind可以修复这个问题
* partial()就是为一个函数创建偏函数:将原函数的某些参数固定住，可以降低新函数调用的难度.中间的参数用_作占位符（传参数）,后面参数可以省略
* memoize()如果一个函数调用开销很大，我们就可能希望能把结果缓存下来，以便后续调用时直接获得结果。可以自动缓存函数计算的结果.对于相同的调用，比如连续两次调用factorial(10)，第二次调用并没有计算，而是直接返回上次计算后缓存的结果。不过，当你计算factorial(9)的时候，仍然会重新计算。
* once()保证某个函数执行且仅执行一次。如果你有一个方法叫register()，用户在页面上点两个按钮的任何一个都可以执行的话，就可以用once()保证函数仅调用一次，无论用户点击多少次
* delay()可以让一个函数延迟执行

```js
var s = ' Hello  ';
s.trim();
// 输出'Hello'
var fn = s.trim;
fn(); // Uncaught TypeError: String.prototype.trim called on null or undefined  直接调用fn()传入的this指针是undefined

var s = ' Hello  ';
var fn = s.trim;
// 调用call并传入s对象作为this:
fn.call(s)
// 输出Hello

var s = ' Hello  ';
var fn = _.bind(s.trim, s);
fn();

var pow2N = _.partial(Math.pow, 2);
pow2N(3); // 8
pow2N(5); // 32
pow2N(10); // 1024

var cube = _.partial(Math.pow, _, 3);
cube(3); // 27
cube(5); // 125
cube(10); // 1000

var factorial = _.memoize(function(n) {
    console.log('start calculate ' + n + '!...');
    if (n < 2) {
        return 1;
    }
    return n * factorial(n - 1);
});

factorial(10); // 3628800
// 输出结果说明factorial(1)~factorial(10)都已经缓存了:
// start calculate 10!...
// start calculate 9!...
// start calculate 8!...
// start calculate 7!...
// start calculate 6!...
// start calculate 5!...
// start calculate 4!...
// start calculate 3!...
// start calculate 2!...
// start calculate 1!...

factorial(9); // 362880
// console无输出

var register = _.once(function () {
    alert('Register ok!');
});
register(); 
register();
register(); // 直执行一次

var log = _.bind(console.log, console);
_.delay(log, 2000, 'Hello,', 'world!');
// 2秒后打印'Hello, world!':
```

### Objects

* keys()可以非常方便地返回一个object自身所有的key，但不包含从原型链继承下来的
* allKeys()除了object自身的key，还包含从原型链继承下来的
* values()返回object自身但不包含原型链继承的所有值
* 没有allValues()
* mapObject()就是针对object的map版本
* invert()把object的每个key-value来个交换，key变成value，value变成key
* extend()把多个object的key-value合并到第一个object并返回,如果有相同的key，后面的object的value将覆盖前面的object的value。
* extendOwn()和extend()类似，但获取属性时忽略从原型链继承下来的属性
* 复制一个object对象，就可以用clone()方法，它会把原有对象的所有属性都复制到新的对象中.所谓“浅复制”就是说，两个对象相同的key所引用的value其实是同一对象
* isEqual()对两个object进行深度比较，如果内容完全相同，则返回true。对Array也可以比较

```js
function Student(name, age) {
    this.name = name;
    this.age = age;
}

var xiaoming = new Student('小明', 20);

_.keys(xiaoming); // ['name', 'age']
_.allKeys(xiaoming); // ['name', 'age', 'school']
_.values(xiaoming);

var obj = { a: 1, b: 2, c: 3 };
// 注意传入的函数签名，value在前，key在后:
_.mapObject(obj, (v, k) => 100 + v); // { a: 101, b: 102, c: 103 }

var obj = {
    Adam: 90,
    Lisa: 85,
    Bart: 59
};
_.invert(obj); // { '59': 'Bart', '85': 'Lisa', '90': 'Adam' }

var a = {name: 'Bob', age: 20};
_.extend(a, {age: 15}, {age: 88, city: 'Beijing'}); // {name: 'Bob', age: 88, city: 'Beijing'}
// 变量a的内容也改变了：
a; // {name: 'Bob', age: 88, city: 'Beijing'}

var copied = _.clone(xiaoming);
alert(JSON.stringify(copied, null, '  '));
xiaoming.skills === copied.skills; // true

var o1 = { name: 'Bob', skills: { Java: 90, JavaScript: 99 }};
var o2 = { name: 'Bob', skills: { JavaScript: 99, Java: 90 }};
o1 === o2; // false
_.isEqual(o1, o2); // true

var o1 = ['Bob', { skills: ['Java', 'JavaScript'] }];
var o2 = ['Bob', { skills: ['Java', 'JavaScript'] }];
o1 === o2; // false
_.isEqual(o1, o2); // true
```

### Chaining

把对象包装成能进行链式调用的方法.最后一步的结果需要调用value()获得最终结果

```js
_.chain([1, 4, 9, 16, 25])
 .map(Math.sqrt)
 .filter(x => x % 2 === 1)
 .value();
// [1, 3, 5]
```
