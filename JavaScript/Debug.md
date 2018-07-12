# 调试


## console

```javascript
console.log(‘Hello World!’);
console.info(‘Something happened…’);
console.warn(‘Something strange happened…’);
console.error(‘Something horrible happened…’);

console.trace()
console.time() && console.timeEnd() // console.time()开始计算时间，然后使用console.timeEnd()进行打印。
console.memory // （是属性，不是函数）来检查你的堆大小状态。
console.profile(‘profileName’) & console.profileEnd(‘profileName’) // 
console.count(“STUFF I COUNT”) // 函数或代码反复出现的情况下，您可以使用console.count('?')来计算您的代码被读取的次数
console.assert(condition, msg) // 在condition为假时记录某些内容。

console.group()
console.groupEnd() // 使用控制台组，将控制台日志组织在一起，每个分组在层次结构中创建另一个级别。 调用groupEnd()减少一个级别(回到上一个层级)。
console.table() // 打印一个非常漂亮的表格

console.clear() // 清空控制台
console.dir()   // 打印一条以三角形符号开头的语句，可以点击三角展开查看对象的属性。
```
