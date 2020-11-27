# Web workers

A web worker is a JavaScript program running on a different thread, in parallel with main thread.

## 场景

* Data and web page caching
* Image manipulation and encoding (base64 conversion)
* Canvas drawing and image filtering
* Network polling and web sockets
* Background I/O operations
* Video/Audio buffering and analysis
* Virtual DOM diffing
* Local database (indexedDB) operations
* Computationally intensive data operations

## 原理

* 在浏览器调试工具中sources中看到不同进程
* 同一main进程间子进程可以互相传递数据，相互通信：postmessage
  - 值传递
  - 引用传递

```js
worker.postMessage(payload, transferableObjects)
```

## 参考

* [Web Worker 使用教程](linhttp://www.ruanyifeng.com/blog/2018/07/web-worker.htmlk)

## 工具

* [developit/stockroom](https://github.com/developit/stockroom):🗃 Offload your store management to a worker easily. <https://stockroom.surge.sh>
