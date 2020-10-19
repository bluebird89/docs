# [Web API](https://developer.mozilla.org/zh-CN/docs/Web/API)

## Web storage

## [IndexedDB](http://www.ruanyifeng.com/blog/2018/07/indexeddb.html)

* 将大量数据储存在客户端，这样可以减少从服务器获取数据，直接从本地获取数据
* 浏览器提供的本地数据库，它可以被网页脚本创建和操作
* 允许储存大量数据，提供查找接口，还能建立索引
* 不属于关系型数据库（不支持 SQL 查询语句），更接近 NoSQL 数据库
* 浏览器数据储存方案
    - Cookie 的大小不超过4KB，且每次请求都会发送回服务器
    - LocalStorage 在 2.5MB 到 10MB 之间（各家浏览器不同），而且不提供搜索功能，不能建立自定义的索引
* 特点
    - 键值对储存。 IndexedDB 内部采用对象仓库（object store）存放数据。所有类型的数据都可以直接存入，包括 JavaScript 对象。对象仓库中，数据以"键值对"的形式保存，每一个数据记录都有对应的主键，主键是独一无二的，不能有重复，否则会抛出一个错误。
    - 异步。 IndexedDB 操作时不会锁死浏览器，用户依然可以进行其他操作，这与 LocalStorage 形成对比，后者的操作是同步的。异步设计是为了防止大量数据的读写，拖慢网页的表现。
    - 支持事务。 IndexedDB 支持事务（transaction），这意味着一系列操作步骤之中，只要有一步失败，整个事务就都取消，数据库回滚到事务发生之前的状态，不存在只改写一部分数据的情况。
    - 同源限制 IndexedDB 受到同源限制，每一个数据库对应创建它的域名。网页只能访问自身域名下的数据库，而不能访问跨域的数据库。
    - 储存空间大 IndexedDB 的储存空间比 LocalStorage 大得多，一般来说不少于 250MB，甚至没有上限。
    - 支持二进制储存。 IndexedDB 不仅可以储存字符串，还可以储存二进制数据（ArrayBuffer 对象和 Blob 对象）。
* 概念
    - 数据库：IDBDatabase 对象.一系列相关数据的容器。每个域名（严格的说，是协议 + 域名 + 端口）都可以新建任意多个数据库
        + 有版本的概念。同一个时刻，只能有一个版本的数据库存在。如果要修改数据库结构（新增或删除表、索引或者主键），只能通过升级数据库版本完成
        + 每个数据库包含若干个对象仓库（object store）
        + indexedDB.open():打开数据库
            * 第一个参数是字符串，表示数据库的名字。如果指定的数据库不存在，就会新建数据库
            * 第二个参数是整数，表示数据库的版本。如果省略，打开已有数据库时，默认为当前版本；新建数据库时，默认为1
        + 事件
            * error事件表示打开数据库失败
            * success事件表示成功打开数据库
            * upgradeneeded 事件:指定的版本号，大于数据库的实际版本号，就会发生数据库升级事件
    - 对象仓库：IDBObjectStore 对象,类似于关系型数据库的表格
        + 保存的是数据记录。每条记录类似于关系型数据库的行，但是只有主键和数据体两部分
        + 主键用来建立默认的索引，必须是不同的，否则会报错
        + 主键可以是数据记录里面的一个属性，也可以指定为一个递增的整数编号
        + createObjectStore
            * { keyPath: 'id' }
            * { autoIncrement: true }
    - 索引：IDBIndex 对象
        + 为了加速数据的检索，可以在对象仓库里面，为不同的属性建立索引
        + 创建
            * createIndex('name', 'name', { unique: false });
    - 事务： IDBTransaction 对象
        + 数据记录的读写和删改，都要通过事务完成。事务对象提供error、abort和complete三个事件，用来监听操作结果
    - 操作请求：IDBRequest 对象
    - 指针： IDBCursor 对象
    - 主键集合：IDBKeyRange 对象


* window​.request​Animation​Frame:告诉浏览器——你希望执行一个动画，并且要求浏览器在下次重绘之前调用指定的回调函数更新动画。该方法需要传入一个回调函数作为参数，该回调函数会在浏览器下一次重绘之前执行
  - 回调函数会被传入DOMHighResTimeStamp参数，DOMHighResTimeStamp指示由RequestAnimationFrame（）排队的回调开始触发的时间。指示当前被 requestAnimationFrame() 排序的回调函数被触发的时间。在同一个帧中的多个回调函数，它们每一个都会接受到一个相同的时间戳，即使在计算上一个回调函数的工作负载期间已经消耗了一些时间。该时间戳是一个十进制数，单位毫秒，最小精度为1ms(

```js
var start = null;
var element = document.getElementById('SomeElementYouWantToAnimate');
element.style.position = 'absolute';

function step(timestamp) {
  if (!start) start = timestamp;
  var progress = timestamp - start;
  element.style.left = Math.min(progress / 10, 200) + 'px';
  if (progress < 2000) {
    window.requestAnimationFrame(step);
  }
}

window.requestAnimationFrame(step);
```

## 参考

* [Web API 接口参考](https://developer.mozilla.org/zh-CN/docs/Web/API)
