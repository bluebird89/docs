# Node
其高性能并行I/O使得分布式开发更加高效，利用稳定接口可提升web渲染速度，也十分适合做实时应用开发。


- CommonJS:Node.JS首先采用了js模块化的概念。Node.js服务器端通过exports、module.exports来输出模块，并使用require同步载入模块，而浏览器端的可以使用Browserify实现。
- AMD:AMD规范用于异步加载模块，主要用于浏览器端，当然也支持其他js环境，主要应用有requireJS。
- ES6 Module:ES6标准定义了JS的模块化方式，目的是取代CommonJS、AMD、CMD等规范，一统江湖，成为通用的模块化解决方案。但浏览器和Node端对ES6的支持度还不是很高，需要用Babel进行转译（Babel编译器可以将ES6、JSX等代码转换成浏览器可以看得懂的语法）。
- Gulp/Grunt+Webpack/Browserify:在构建前端项目资源，使用自动化工具协助进行自动化程序码打包、转译等重复性工作，可以大幅提升开发效率。
    - Gulp:Gulp和Grunt一样是一种基于任务的构建工具，能够优化前端工作流程。
    - Webpack:webpack傻瓜式的项目构建方式解决了模块化开发和静态文件处理两大问题。但随着项目越来越大，特定需求的出现就使得webpack越来越难配置了。因此webpack在没太多特定需求的项目使用是没有问题的，当然，webpack的未来肯定是围绕ES的支持度、构建速度与产出代码的性能和用户体验来建设的。其未来的重要关注点：
        - 高性能的构建缓存
        - 提升初始化速度和增量构建效率
        - 更好的支持Type Script
        - 修订长期缓存
        - 支持WASM模块支持
        - 提升用户体验
    - Browserify:Browserify是基于Unix小工具协作的方式实现模块化方案的，轻便且配置容易，管道形式的组织则让开发者很容易插拔或修改其中某一环节的操作。
- ES2015/ES6:我们都知道ECMASCRIPT是组成JS的三要素之一，ES6其第6个版本，ES的历史确实也挺曲折的。通过ES6最常用的特性，我们来了解ES6到底解决了什么：
    - let, const（变量类型）：解决变量作用域泄露的问题。
    - Class, extends, super（类、继承）：让对象原型的写法更加清晰、更像面向对象编程的语法，也更加通俗易懂。
    - Arrow functions（箭头函数）：1.简洁、简洁、简洁，2.解决this绑定的问题（继承外面的this）。
    - Template string（模板字符串）：解决传统写法非常麻烦的问题。
    - Destructuring（解构）：避免让API使用者记住多个参数的使用顺序。
    - Default, rest（默认值、参数）：简化，替代arguments，使代码更易于阅读。
- ImmutableJS:我们知道在JavaScript中有两种数据类型：基础数据类型和引用类型。在JavaScript中的对象数据是可以变的，由于使用了引用，所以修改了复制的值也会相应地修改原始值。通常我们用deepCopy来避免修改，但这样做法会产生资源浪费。而ImmutableJS的出现很好的解决了这一问题。

## npm
Node的包描述文件是一个JSON文件，用于描述非代码相关的信息。而NPM则是一个根据包规范来提供Node服务的Node包管理器。它解决了依赖包安装的问题，却面临着两个新的问题：

- 安装的时候无法保证速度和一致性。
- 安全问题，因为NPM安装时允许运行代码。

于是Yarn就出现了

## 安装

```
# ubuntu
sudo git clone https://github.com/nodejs/node.git
sudo chmod -R 755 node
cd node
sudo ./configure
sudo make
sudo make install

curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs

curl http://npmjs.org/install.sh | sh

# Mac
brew install nvm
nvm install 4.4.5
nvm use 4.4.5

brew install node
```

### nodejs多进程架构

cluster模块，nodejs是单线程，不能充分利用多核cpu资源，因此要启动多进程，每个进程利用一个CPU，实现多核CPU利用。

- 启多个进程，每个进程绑定不同的端口，主进程对外接受所有的网络请求，再将这些请求分别代理到不同的端口的进程上，通过代理可以避免端口不能重复监听的问题，甚至可以再代理进程上做适当的负载均衡，由于进程每接收到一个连接，将会用掉一个文件描述符，因此代理方案中客户端连接到代理进程，代理进程连接到工作进程的过程需要用掉两个文件描述符，操作系统的文件描述符是有限的，代理方案浪费掉一倍数量的文件描述符的做法影响了系统的扩展能力。
- 父进程创建socket，并且bind、listen后，通过fork创建多个子进程，通过send方法给每个子进程传递这个socket，子进程调用accpet开始监听等待网络连接。

```
// master.js  
var fork =require('child_process').fork;  
var cpus =require('os').cpus();  
var server =require('net').createServer()  
server.listen(1337);  
for(vari=0;i<cpus.length;i++){  
  var worker = fork(./worker.js);  
  worker.send('server', server);  
}  

// worker.js  
var http =require('http')  
var server =http.createServer(function(req,res){  
  res.writeHead(200, {'Content-Type':'text/plain'});  
  res.end('handled by child, pid is ' +process.pid +'\n')  
})  
process.on('message',function(m,tcp){  
  if(m ==='server') {  
    tcp.on('connection',function(socket){  
      server.emit('connection',socket);  
    })  
  }  
})  
```
有多个进程同时等待网络的连接事件，当这个事件发生时，这些进程被同时唤醒，就会产生“惊群问题”。我们知道进程被唤醒，需要进行内核重新调度，这样每个进程同时去响应这一个事件，而最终只有一个进程能处理事件成功，其他的进程在处理该事件失败后重新休眠或其他，浪费性能。
而且这时采用的是操作系统的抢占式策略，谁抢到谁服务，一般而言这是公平的，各个进程可以根据自己的繁忙度来进行抢占，但对于node来说，需要分清他的繁忙度是由CPU，I/O两部分构成的，影响抢占的是CPU的繁忙度，对于不同的业务可能存在I/O繁忙，而CPU较为空闲的情况，这可能造成某个进程抢到较多请求，形成负载不均衡的情况。

- 为了解决负载均衡以及消除惊群效应，改进是在master调用accpet开始监听等待网络连接，master来控制请求的给予。将获得的连接均衡的传递给子进程。

```
// master.js  
var fork =require('child_process').fork;  
var cpus =require('os').cpus();  
var server =require('net').createServer()  
var workers = []  
server.listen(1337);  
server.on('connection',function(socket){  
  var one_worker =workers.pop();//取出一个worker  
  one_worker.send('server',socket);  
  workers.unshift(one_worker);//再放回取出的worker  
})  
for(vari=0;i<cpus.length;i++){  
  var worker = fork(./worker.js);  
  workers.push(worker);  
}  
[javascript] view plain copy
// worker.js  
var http =require('http')  
var server =http.createServer(function(req,res){  
  res.writeHead(200, {'Content-Type':'text/plain'});  
  res.end('handled by child, pid is ' +process.pid +'\n')  
})  
process.on('message', function(socket){  
  if(m === 'server') {  
    server.emit('connection', socket)  
  }  
})  
```
但负责接收socket的master需要重新分配发送socket ，而且仅有一个进程去accept连接，效率会降低
node官方的cluster模块就是这么实现的，实质是采用了round－robin轮叫调度算法。

### 集群稳定之路
- 自动重启：我们在主进程上要加入一些子进程管理的机制，比如在一个子进程挂掉后，要重新启动一个子进程来继续服务.假设子进程中有未捕获异常发生；
```
// worker.js  
process.on('uncaughtException',function(err){  
  console.error(err);  
  //停止接收新的连接  
  worker.close(function(){  
  //所有已有连接断开后，退出进程  
    process.exit(1)  
  })  
  //如果存在长连接，断开可能需要较久的时间，要强制退出，  
  setTimeout(function(){  
    process.exit(1)  
  }, 5000);  
})  
主进程中监听每个子进程的exit事件
[javascript] view plain copy
// master.js  
var other_work = {};  
var createWorker = function() {  
  var worker = fork('./worker.js')  
  // 退出时启动新的进程  
  worker.on('exit',function(){  
    console.log('worker ' +worker.pid +' exited.');  
    delete other_work[worker.pid]  
    createWorker();  
  })  
  other_work[worker.pid] = worker;  
  console.log('create worker pid: ' +worker.pid)  
}  
```

上述代码中存在的问题是要等到已有的所有连接断开后进程才退出，在极端的情况下，所有工作进程都停止接收新链接，全处在等待退出状态。但在等到进程完全退出才重启的过程中，所有新来的请求可能存在没有工作进程为新用户服务的场景，这会丢掉大部分请求。
为此需要改进，在子进程停止接收新链接时，主进程就要fork新的子进程继续服务。为此在工作进程得知要退出时，向主进程主动发送一个自杀信号，然后才停止接收新连接。主进程在收到自杀信号后立即创建新的工作进程。

```
// worker.js  
process.on('uncaughtException',function(err){  
  console.error(err);  
  process.send({act: 'suicide'})／／自杀信号  
  worker.close(function(){  
    process.exit(1)  
  })  
  //如果存在长连接，断开可能需要较久的时间，要强制退出，  
  setTimeout(function(){  
    process.exit(1)  
  }, 5000);  
})  
主进程将重启工作进程的任务，从exit事件的处理函数中转移到message事件的处理函数中
[javascript] view plain copy
// master.js  
var other_work = {};  
var createWorker = function() {  
  var worker = fork('./worker.js')  
  worker.on('message', function(){   
    if(message.act === 'suicide'){  
      createWorker();  
    }   
  })  
  worker.on('exit',function(){  
    console.log('worker ' +worker.pid +' exited.');  
    delete other_work[worker.pid]  
  })  
  other_work[worker.pid] =worker;  
  console.log('create worker pid: ' +worker.pid)  
}  
```

### 限量重启
工作进程不能无限制的被重启，如果启动的过程中就发生了错误或者启动后接到连接就收到错误，会导致工作进程被频繁重启。所以要加以限制，比如在单位时间内规定只能重启
多少次，超过限制就触发giveup事件，告知放弃重启工作进程这个重要事件。
我们引入一个队列来做标记，在每次重启工作进程之间打点判断重启是否过于频繁。
```
在master.js加入如下代码
[javascript] view plain copy
//重启次数  
var limit =10;  
//时间单位  
var during =60000;  
var restart = [];  
var isTooFrequently =function() {  
  //纪录重启时间  
  var time =Date.now()  
  var length =restart.push(time);  
  if (length >limit) {  
    //取出最后10个纪录  
    restart = restart.slice(limit * -1)  
  }  
  return restart.length >=limit &&restart[restart.length -1] -restart[0] <during;  
}  
在createWorker方法最开始部分加入判断
[javascript] view plain copy
// 检查是否太过频繁  
if (isTooFrequently()) {  
  //触发giveup事件后，不再重启  
  process.emit('giveup', length, duiring);  
  return;  
}  
```
giveup事件是比uncaughtException更严重的异常事件，giveup事件表示集群中没有任何进程服务了，十分危险。为了健壮性考虑，我们应在giveup事件中添加重要日志，并让监控系统监视到这个严重错误，进而报警等

gisconnect事件表示父子进程用于通信的channel关闭了，此时父子进程之间失去了联系，自然是无法传递客户端接收到的连接了。失去联系不表示会退出，worker进程有可能仍然在运行，但此时已经无力接收请求了。所以当master进程收到某个worker disconnect的事件时，先需要kill掉worker，然后再fork一个worker。
```
// 在createWorker中添加如下代码  
worker.on('disconnect', function(){  
  worker.kill();  
  console.log('worker' + worker.pid + 'killed')  
  createWorker();  
})  
[javascript] view plain copy
<pre></pre>  
<pre></pre>  
<pre></pre>  
<pre></pre>  
```

### 实际服务器

nginx就是图中的反向代理服务器，拥有诸多优势，可以做负载均衡和静态资源服务器。后面的两台机器就是我们的nodejs应用服务器集群。
nginx 的负载均衡是用在多机器环境下的，单机的负载均衡还是要靠cluster 这类模块来做。
nginx与node应用服务器的对比：nginx是一个高性能的反向代理服务器，要大量并且快速的转发请求，所以不能采用上面第三种方法，原因是仅有一个进程去accept，然后通过消息队列等同步方式使其他子进程处理这些新建的连接，效率会低一些。nginx采用第二种方法，那就依然可能会产生负载不完全均衡和惊群问题。nginx是怎么解决的呢：nginx中使用mutex互斥锁解决这个问题，具体措施有使用全局互斥锁，每个子进程在epoll_wait()之前先去申请锁，申请到则继续处理，获取不到则等待，并设置了一个负载均衡的算法（当某一个子进程的任务量达到总设置量的7/8时，则不会再尝试去申请锁）来均衡各个进程的任务量。具体的nginx如何解决惊群，看这篇文章: http://blog.csdn.net/russell_tao/article/details/7204260
那么，node应用服务器为什么可以采用方案三呢，我的理解是：node作为具体的应该服务器负责实际处理用户的请求，处理可能包含数据库等操作，不是必须快速的接收大量请求，而且转发到某具体的node单台服务器上的请求较之nginx也少了很多。

## 资料

- [开发命令行工具](https://juejin.im/post/59b73c9df265da06670c5868)

## 扩展

- [youzan/zan-tool](https://github.com/youzan/zan-tool):Zan Node Web 框架的配套开发工具，例如初始化一个新项目、新建一个 NPM 包、本地开发等。
- [NodeOS](https://github.com/NodeOS/NodeOS)
- [sindresorhus/awesome-electron](https://github.com/sindresorhus/awesome-electron)Useful resources for creating apps with Electron
- [sindresorhus/awesome-nodejs](https://github.com/sindresorhus/awesome-nodejs)Delightful Node.js packages and resources
- [sequelize/sequelize](https://github.com/sequelize/sequelize)An easy-to-use multi SQL dialect ORM for Node.js <http://docs.sequelizejs.com>
- [thinkjs/thinkjs](https://github.com/thinkjs/thinkjs)Use full ES2015+ features to develop Node.js applications, Support TypeScript 

## 教程

* [N-blog](https://maninboat.gitbooks.io/n-blog/content/):使用 Express + MongoDB 搭建多人博客
* [ElemeFE/node-practice](https://github.com/ElemeFE/node-practice):Node.js 实践教程

## 参考

- [nodejs入门](https://leanpub.com/nodebeginner-chinese)


## 面试

* [ElemeFE/node-interview](https://github.com/ElemeFE/node-interview):How to pass the Node.js interview of ElemeFE. https://elemefe.github.io/node-interv…

## 工具

* [koajs/koa](https://github.com/koajs/koa):Expressive middleware for node.js using ES2017 async functions http://koajs.com
* [tj/n](https://github.com/tj/n):Node version management
* [sequelize/sequelize](https://github.com/sequelize/sequelize):An easy-to-use multi SQL dialect ORM for Node.js http://docs.sequelizejs.com