# [nodejs/node](https://github.com/nodejs/node)

Node.js JavaScript runtime ✨🐢🚀✨ <https://nodejs.org>

* 因为JavaScript是单线程执行，根本不能进行同步IO操作，所以，JavaScript的这一“缺陷”导致了它只能使用异步IO。
* 在2009年，Ryan正式推出了基于JavaScript语言和V8引擎的开源Web服务器项目，命名为Node.js。借助JavaScript天生的事件驱动机制加V8高性能引擎，使编写高性能Web服务轻而易举。
* 其高性能并行I/O使得分布式开发更加高效，利用稳定接口可提升web渲染速度，也十分适合做实时应用开发。

## 场景

* 前端实践，脚手架，工程化，快速开发
* API Proxy 中间层实践，页面即服务概念
* 面向企业开发的 Web 框架
* Node 最新技术与性能调优

## [安装](https://github.com/nodesource/distributions)

* [tj/n](https://github.com/tj/n):Node version management
* [creationix/nvm](https://github.com/creationix/nvm):Node Version Manager - Simple bash script to manage multiple active node.js versions

```sh
# ubuntu
wget https://nodejs.org/dist/v8.11.1/node-v8.11.1.tar.gz
tar zxvf node-v8.11.1.tar.gz
cd node-v8.11.1
./configure
make && make install

# centos
wget https://nodejs.org/dist/v4.2.3/node-v4.2.3-linux-x64.tar.gz
mkdir node
tar xvf node-v*.tar.gz --strip-components=1 -C ./node
rm -rf node-v*
mkdir node/etc
echo 'prefix=/usr/local' > node/etc/npmrc
sudo mv node /opt/
sudo chown -R root: /opt/node
sudo ln -s /opt/node/bin/node /usr/local/bin/node
sudo ln -s /opt/node/bin/npm /usr/local/bin/npm
sudo visudo
Defaults    secure_path = /sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin

# install compiled package
VERSION=v10.15.0
DISTRO=linux-x64
sudo mkdir -p /usr/local/lib/nodejs
sudo tar -xJvf node-$VERSION-$DISTRO.tar.xz -C /usr/local/lib/nodejs
Set the environment variable ~/.profile, add below to the end
# Nodejs
VERSION=v10.15.0
DISTRO=linux-x64
export PATH=/usr/local/lib/nodejs/node-$VERSION-$DISTRO/bin:$PATH

sudo ln -s /usr/local/lib/nodejs/node-$VERSION-$DISTRO/bin/node /usr/bin/node
sudo ln -s /usr/local/lib/nodejs/node-$VERSION-$DISTRO/bin/npm /usr/bin/npm
sudo ln -s /usr/local/lib/nodejs/node-$VERSION-$DISTRO/bin/npx /usr/bin/npx

# Error: EACCES: permission denied, access '/usr/local/lib/node_modules' react
sudo chown -R henry:henry /usr/local/lib/nodejs/node-v12.16.1-linux-x64/lib/node_modules

## using PPA
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs

nodejs -v
npm -v

# Mac
brew install node
node -v

## nvm node verison management
brew install nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.1/install.sh | bash

nvm install 4.4.5
nvm use 4.4.5
command -v nvm          # check the nvm use message
nvm install node        # install most recent Node stable version
nvm ls                  # list installed Node version
nvm use node            # use stable as current version
nvm ls-remote           # list all the Node versions you can install
nvm alias default node # set the installed stable version as the default Node
```

# [npm (node package manager)](https://github.com/npm/npm)

a package manager for javascript <http://www.npmjs.com/>

* Node的包描述文件是一个JSON文件，用于描述非代码相关的信息。而NPM则是一个根据包规范来提供Node服务的Node包管理器。它解决了依赖包安装的问题，却面临着两个新的问题：
    - 安装的时候无法保证速度和一致性。
    - 安全问题，因为NPM安装时允许运行代码。
* 大家都把自己开发的模块打包后放到npm官网上，如果要使用，直接通过npm安装就可以直接用，不用管代码存在哪，应该从哪下载。
* npm可以根据依赖关系，把所有依赖的包都下载下来并管理起来。
* [ pnpm / pnpm ](https://github.com/pnpm/pnpm):packagerocket Fast, disk space efficient package manager https://pnpm.js.org
* Packages
    - [rlidwka/sinopia](https://github.com/rlidwka/sinopia):Private npm repository server
    - [request/request](https://github.com/request/request):🏊🏾 Simplified HTTP request client.
    - [ksky521/nodeppt](https://github.com/ksky521/nodePPT):This is probably the best web presentation tool so far! http://js8.in/nodeppt
    - [](https://github.com/lerna/lerna):🐉 A tool for managing JavaScript projects with multiple packages.https://lerna.js.org/
* 配置文件`package.json`
    - scripts：script会安装一定顺序寻找命令对应位置，本地的node_modules/.bin路径就在这个寻找清单中.`npm run {script name}`,将构建命令提到外部指令来

```sh
# 镜像加速设置
npm -v
npm config set registry https://registry.npm.taobao.org --global
npm config set registry "http://registry.npmjs.org/"

npm config set registry http://registry.cnpmjs.org # Unexpected end of JSON input while parsing near '...p":false,"directories'
npm root -g

npm config set disturl https://npm.taobao.org/dist --global

npm config set proxy null
npm config set proxy http://server:port
npm config set https-proxy http://server:port

# 镜像配置 NPM registry manager
nrm ls
    npm ---- https://registry.npmjs.org/
    cnpm --- http://r.cnpmjs.org/
    taobao - http://registry.npm.taobao.org/
    eu ----- http://registry.npmjs.eu/
    au ----- http://registry.npmjs.org.au/
    sl ----- http://npm.strongloop.com/
    nj ----- https://registry.nodejitsu.com/
    pt ----- http://registry.npmjs.pt/
nrm add <registry> <url> [home]
nrm del <registry>
nrm test
nrm use taobao

npm list moduleName               ##List all locally installed packages
npm list -a|g             ##List all globally installed packages
npm list oauth # ind the version of a specific package
npm list --depth=0

npm search express

npm outdated --depth=0             ##For locally installed packages
npm outdated -g --depth=0   ##For  globally installed packages

npm init  # 创建一个npm项目,配置项目信息，在package.json文件
npm ls

npm install <package> # Install locally
npm install|i -g <package> cnpm --registry=https://registry.npm.taobao.org # Install globally
nmp install -g --registery= https://registery.npm.taobao.org
npm install <package> --save # To install a package and save it in your project's package.json file
npm install npm@latest -g

sudo npm cache clean -f # 清除node.js的cache

npm install -g n  安装 n 工具，这个工具是专门用来管理node.js版本
n stable

npm audit fix

npm update [-g] [<package>]
npm uninstall [-g] <package>

# Error: EACCES: permission denied, access '/usr/lib/node_modules'
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
# ~/.profile
export PATH=~/.npm-global/bin:$PATH
source ~/.profile

npm install -g pnpm
curl -L https://raw.githubusercontent.com/pnpm/self-installer/master/install.js | node
# No write access to the found global executable directories
pnpm add -g pnpm

npm run dev
npm run watch
```

## [yarnpkg/yarn](https://github.com/yarnpkg/yarn)

Fast, reliable, and secure dependency management. <https://yarnpkg.com>

Facebook提供的替代npm的工具，可以加速node模块的下载 与react-native-cli（React Native的命令行工具用于执行创建、初始化、更新项目、运行打包服务（packager）等任务）。快速(缓存它下载的每个包，所以不需要重复下载)、可靠(每个安装包的代码执行前使用校验码验证包的完整性)、安全的依赖管理(用一个格式详尽但简洁的 lockfile 和一个精确的算法来安装)

* 开始新项目:yarn init 打开一个交互式表单天剑项目信息,生成package.json信息文件
* 添加依赖包: yarn add [package] yarn add [package]@[version] 1.2.3 ^1.0.0 yarn add [package]@[tag]
* 分别添加到 devDependencies、peerDependencies 和 optionalDependencies： yarn add [package] --dev yarn add [package] --peer yarn add [package] --optional
* 升级依赖包: yarn upgrade [package] yarn upgrade [package]@[version] yarn upgrade [package]@[tag]
* 移除依赖包: yarn remove [package]
* 安装项目的全部依赖:yarn || yarn install --flat 安装一个包的单一版本 --force 强制重新下载所有包 --production 只安装生产环境依赖
* [中文文档](https://yarnpkg.com/zh-Hans/) https://yarn.bootcss.com/docs/

```sh
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn

npm install -g yarn
brew install yarn

### 镜像源配置
yarn config set registry https://registry.npm.taobao.org --global
yarn config set disturl https://npm.taobao.org/dist --global

## The engine "node" is incompatible with this module. Expected version ">=4 <=9".
 yarn config set ignore-engines true
## Failed to fetch https://dl.yarnpkg.com/debian/dists/stable/InRelease  The following signatures couldn't be verified because the public key is not available: NO_PUBKEY E074D16EB6FF4DE3
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
## Yarn, node-gyp rebuild compile error, node_modules/fsevents: Command failed
sudo rm -r node_modules && rm yarn.lock && yarn install
```

## 环境

* 内置的export命令用来在当前进程中创建环境变量（自然也会被子进程继承）
* 在命令行中调用其他程序时，在前面添加类似上面的变量赋值，则会将该变量添加到子进程的环境变量中

```sh
API_URL=http://example.com/api node ./index.js # 通过process.env.API_URL取得传入的API地址
```

### 模块化

为了编写可维护的代码，我们把很多函数分组，分别放到不同的文件里，这样，每个文件包含的代码就相对较少，很多编程语言都采用这种组织代码的方式。在Node环境中，一个.js文件就称之为一个模块（module）。

* 大大提高了代码的可维护性
* 其次，编写代码不必从零开始
* 使用模块还可以避免函数名和变量名冲突。相同名字的函数和变量完全可以分别存在不同的模块中
* 这种模块加载机制被称为CommonJS规范。在这个规范下，每个.js文件都是一个模块，它们内部各自使用的变量名和函数名都互不冲突，
* 模块的名字就是文件名（去掉.js后缀）
* 封装模块导出 `module.exports = variable;`
* 引入模块：如果不加相对地址：Node会依次在内置模块、全局模块和当前模块下查找 `var foo = require('other_module');`
* 实现“模块”功能的奥妙就在于JavaScript是一种函数式编程语言，它支持闭包。如果我们把一段JavaScript代码用一个函数包装起来，这段代码的所有“全局”变量就变成了函数内部的局部变量。
* module.exports vs exports
    - Node会把整个待加载的hello.js文件放入一个包装函数load中执行。在执行这个load()函数前，Node准备好了module变量
    - load()函数最终返回module.exports
    - 默认情况下，Node准备的exports变量和module.exports变量实际上是同一个变量，并且初始化为空对象{}
    - 如果我们要输出的是一个函数或数组，那么，只能给module.exports赋值 `module.exports = function () { return 'foo'; };` 给exports赋值是无效的，因为赋值后，module.exports仍然是空对象{}
* 如果要输出一个键值对象{}，可以利用exports这个已存在的空对象{}，并继续在上面添加新的键值；
* 如果要输出一个函数或数组，必须直接对module.exports对象赋值。

```js
// hello.js
var s = 'Hello';
function greet(name) {
    console.log(s + ', ' + name + '!');
}
module.exports = greet;  //作为模块的输出暴露出去，这样其他模块就可以使用greet函数了。

// 引入hello模块:
var greet = require('./hello'); // 引入的模块作为变量保存在greet变量中,
var s = 'Michael';
greet(s);

// 模块代码
var s = 'Hello';
var name = 'world';
console.log(s + ' ' + name + '!');

// 封装后 原来的全局变量s现在变成了匿名函数内部的局部变量
(function () {
    // 读取的hello.js代码:
    var s = 'Hello';
    var name = 'world';

    console.log(s + ' ' + name + '!');
    // hello.js代码结束
})();

// module原理 准备module对象:
var module = {
    id: 'hello',
    exports: {}
};
var load = function (module) {
    // 读取的hello.js代码:
    function greet(name) {
        console.log('Hello, ' + name + '!');
    }

    module.exports = greet;
    // hello.js代码结束
    return module.exports;
};
var exported = load(module);
// 保存module:
save(module, exported);

function hello() {
    console.log('Hello, world!');
}
function greet(name) {
    console.log('Hello, ' + name + '!');
}
module.exports = {
    hello: hello,
    greet: greet
};
exports.hello = hello;
exports.greet = greet;

// 代码可以执行，但是模块并没有输出任何变量:
exports = {
    hello: hello,
    greet: greet
};

// Node会把整个待加载的hello.js文件放入一个包装函数load中执行。在执行这个load()函数前，Node准备好了module变量
var module = {
    id: 'hello',
    exports: {}
};

var load = function (exports, module) {
    // hello.js的文件内容
    ...
    // load函数返回:
    return module.exports;
};

var exported = load(module.exports, module);

exports.foo = function () { return 'foo'; };
exports.bar = function () { return 'bar'; };
module.exports.foo = function () { return 'foo'; };
module.exports.bar = function () { return 'bar'; };

// 只能这种写法
module.exports = function () { return 'foo'; };
```

#### 基本模块

* 在Node.js环境中，有唯一的全局对象，但不叫window，而叫global
* process也是Node.js提供的一个对象，它代表当前Node.js进程
    - Node.js不断执行响应事件的JavaScript函数，直到没有任何响应事件的函数可以执行时，Node.js就退出了。如果我们想要在下一次事件响应中执行代码，可以调用process.nextTick()
    - 响应exit事件，就可以在程序即将退出时执行某个回调函数
* fs:文件系统模块，负责读写文件,同时提供了异步和同步的方法
    - 异步读取：不用等待IO操作，但代码较麻烦。回调函数：第一个参数代表错误信息，第二个参数代表结果。
        + 当读取二进制文件时，不传入文件编码时，回调函数的data参数将返回一个Buffer对象。在Node.js中，Buffer对象就是一个包含零个或任意个字节的数组
    - 同步读取：`var data = getJSONSync('http://example.com/ajax');`同步操作的好处是代码简单，缺点是程序将等待IO操作，在等待时间内，无法响应其它任何事件。和异步函数相比，多了一个Sync后缀，并且不接收回调函数，函数直接返回结果。
    - 写文件
    - 要获取文件大小，创建时间等信息，可以使用fs.stat()
    - Node环境执行的JavaScript代码是服务器端代码，所以，绝大部分需要在服务器运行期反复执行业务逻辑的代码，必须使用异步代码，否则，同步代码在执行时期，服务器将停止响应，因为JavaScript只有一个执行线程。
* stream:一种抽象的数据结构,从输入到输出的动态一致，标准输入流（stdin）与标准输出流（stdout）。流的特点是数据是有序的，而且必须依次读取，或者依次写入。分写入流与读取流
    - 在Node.js中，流也是一个对象，只需要响应流的事件就可以了。所有可以读取数据的流都继承自stream.Readable，所有可以写入的流都继承自stream.Writable
    - data事件表示流的数据已经可以读取了，end事件表示这个流已经到末尾了，没有数据可以读取了，error事件表示出错了。data事件可能会有多次，每次传递的chunk是流的一部分数据
    - 只需要不断调用write()方法，最后以end()结束。
    - pipe：一个Readable流和一个Writable流串起来后，所有的数据自动从Readable流进入Writable流，这种操作叫pipe。实现文件复制.当Readable流的数据读取完毕，end事件触发后，将自动关闭Writable流。如果我们不希望自动关闭Writable流 `readable.pipe(writable, { end: false });`
* http:Node.js开发的目的就是为了用JavaScript编写Web服务器程序。Javascript实现全栈。
    - http服务器：request对象封装了HTTP请求，我们调用request对象的属性和方法就可以拿到所有HTTP请求的信息；response对象封装了HTTP响应，我们操作response对象的方法，就可以把HTTP响应返回给浏览器。
    - 文件服务器：没有必要手动读取文件内容。由于response对象本身是一个Writable Stream，直接用pipe()方法就实现了自动读取文件内容并输出到HTTP响应。`node file_server.js /path/to/dir`
* crypto模块的目的是为了提供通用的加密和哈希算法。通过cypto这个模块暴露为JavaScript接口
    - MD5是一种常用的哈希算法，用于给任意数据一个“签名”。这个签名通常用一个十六进制的字符串表示.update()方法默认字符串编码为UTF-8，也可以传入Buffer。如果要计算SHA1，只需要把'md5'改成'sha1'
    - Hmac算法也是一种哈希算法，它可以利用MD5或SHA1等哈希算法。不同的是，Hmac还需要一个密钥.用随机数“增强”的哈希算法
    - AES是一种常用的对称加密算法，加解密都用同一个密钥。crypto模块提供了AES支持，但是需要自己封装好函数，便于使用
    - Diffie-Hellman：DH算法是一种密钥交换协议，它可以让双方在不泄漏密钥的情况下协商出一个密钥来。
        + 小明先选一个素数和一个底数，例如，素数p=23，底数g=5（底数可以任选），再选择一个秘密整数a=6，计算A=g^a mod p=8，然后大声告诉小红：p=23，g=5，A=8；
        + 小红收到小明发来的p，g，A后，也选一个秘密整数b=15，然后计算B=g^b mod p=19，并大声告诉小明：B=19；
        + 小明自己计算出s=B^a mod p=2，小红也自己计算出s=A^b mod p=2，因此，最终协商的密钥s为2。
        + 在这个过程中，密钥2并不是小明告诉小红的，也不是小红告诉小明的，而是双方协商计算出来的。第三方只能知道p=23，g=5，A=8，B=19，由于不知道双方选的秘密整数a=6和b=15，因此无法计算出密钥2。

```js
global.console

process === global.process;
process.version;
process.platform;
process.arch;
process.cwd(); //返回当前工作目录
process.chdir('/private/tmp'); // 切换当前工作目录

process.nextTick(function () {
    console.log('nextTick callback!');
});
console.log('nextTick was set!');

// 程序即将退出时的回调函数:
process.on('exit', function (code) {
    console.log('about to exit with code: ' + code);
});

var fs = require('fs');  // 异步读文件
fs.readFile('sample.txt', 'utf-8', function (err, data) {
    if (err) {
        console.log(err);
    } else {
        console.log(data);
    }
});

// 同步读文件
var data = fs.readFileSync('sample.txt', 'utf-8');
console.log(data);

try {
    var data = fs.readFileSync('sample.txt', 'utf-8');
    console.log(data);
} catch (err) {
    // 出错了
}

var data = 'Hello, Node.js';
fs.writeFile('output.txt', data, function (err) {
    if (err) {
        console.log(err);
    } else {
        console.log('ok.');
    }
});
fs.writeFileSync('output.txt', data);

fs.stat('sample.txt', function (err, stat) {
    if (err) {
        console.log(err);
    } else {
        // 是否是文件:
        console.log('isFile: ' + stat.isFile());
        // 是否是目录:
        console.log('isDirectory: ' + stat.isDirectory());
        if (stat.isFile()) {
            // 文件大小:
            console.log('size: ' + stat.size);
            // 创建时间, Date对象:
            console.log('birth time: ' + stat.birthtime);
            // 修改时间, Date对象:
            console.log('modified time: ' + stat.mtime);
        }
    }
});

// 读取流:
var rs = fs.createReadStream('sample.txt', 'utf-8');
rs.on('data', function (chunk) {
    console.log('DATA:')
    console.log(chunk);
});
rs.on('end', function () {
    console.log('END');
});
rs.on('error', function (err) {
    console.log('ERROR: ' + err);
});

// 写入流
var ws1 = fs.createWriteStream('output1.txt', 'utf-8');
ws1.write('使用Stream写入文本数据...\n');
ws1.write('END.');
ws1.end();

var ws2 = fs.createWriteStream('output2.txt');
ws2.write(new Buffer('使用Stream写入二进制数据...\n', 'utf-8'));
ws2.write(new Buffer('END.', 'utf-8'));
ws2.end();

// pipe
var rs = fs.createReadStream('sample.txt');
var ws = fs.createWriteStream('copied.txt');
readable.pipe(writable, { end: false });
rs.pipe(ws);

// 导入http模块:
var http = require('http');

// 创建http server，并传入回调函数:
var server = http.createServer(function (request, response) {
    // 回调函数接收request和response对象,
    // 获得HTTP请求的method和url:
    console.log(request.method + ': ' + request.url);
    // 将HTTP响应200写入response, 同时设置Content-Type: text/html:
    response.writeHead(200, {'Content-Type': 'text/html'});
    // 将HTTP响应的HTML内容写入response:
    response.end('<h1>Hello world!</h1>');
});
// 让服务器监听8080端口:
server.listen(8080);
console.log('Server is running at http://127.0.0.1:8080/'); // 访问 http://localhost:8080

var url = require('url');
console.log(url.parse('http://user:pass@host.com:8080/path/to/file?query=string#hash'));
Url {
  protocol: 'http:',
  slashes: true,
  auth: 'user:pass',
  host: 'host.com:8080',
  port: '8080',
  hostname: 'host.com',
  hash: '#hash',
  search: '?query=string',
  query: 'query=string',
  pathname: '/path/to/file',
  path: '/path/to/file?query=string',
  href: 'http://user:pass@host.com:8080/path/to/file?query=string#hash' }

// 文件服务器
var
    fs = require('fs'),
    url = require('url'),
    path = require('path'),
    http = require('http');

// 从命令行参数获取root目录，默认是当前目录:
var root = path.resolve(process.argv[2] || '.');

console.log('Static root dir: ' + root);

// 创建服务器:
var server = http.createServer(function (request, response) {
    // 获得URL的path，类似 '/css/bootstrap.css':
    var pathname = url.parse(request.url).pathname;
    // 获得对应的本地文件路径，类似 '/srv/www/css/bootstrap.css':
    var filepath = path.join(root, pathname);
    // 获取文件状态:
    fs.stat(filepath, function (err, stats) {
        if (!err && stats.isFile()) {
            // 没有出错并且文件存在:
            console.log('200 ' + request.url);
            // 发送200响应:
            response.writeHead(200);
            // 将文件流导向response:
            fs.createReadStream(filepath).pipe(response);
        } else {
            // 出错了或者文件不存在:
            console.log('404 ' + request.url);
            // 发送404响应:
            response.writeHead(404);
            response.end('404 Not Found');
        }
    });
});
server.listen(8080);
console.log('Server is running at http://127.0.0.1:8080/');

const crypto = require('crypto');
const hash = crypto.createHash('md5');
// 可任意多次调用update():
hash.update('Hello, world!');
hash.update('Hello, nodejs!');
console.log(hash.digest('hex')); // 7e1977739c748beac0c0fd14fd26a544

const hmac = crypto.createHmac('sha256', 'secret-key');
hmac.update('Hello, world!');
hmac.update('Hello, nodejs!');
console.log(hmac.digest('hex'));

function aesEncrypt(data, key) {
    const cipher = crypto.createCipher('aes192', key);
    var crypted = cipher.update(data, 'utf8', 'hex');
    crypted += cipher.final('hex');
    return crypted;
}
function aesDecrypt(encrypted, key) {
    const decipher = crypto.createDecipher('aes192', key);
    var decrypted = decipher.update(encrypted, 'hex', 'utf8');
    decrypted += decipher.final('utf8');
    return decrypted;
}
var data = 'Hello, this is a secret message!';
var key = 'Password!';
var encrypted = aesEncrypt(data, key);
var decrypted = aesDecrypt(encrypted, key);
console.log('Plain text: ' + data);
console.log('Encrypted text: ' + encrypted);
console.log('Decrypted text: ' + decrypted);
```

## [mongodb](https://www.npmjs.com/package/mongodb)

```js
npm install mongodb --save
```

### nodejs多进程架构

cluster模块，nodejs是单线程，不能充分利用多核cpu资源，因此要启动多进程，每个进程利用一个CPU，实现多核CPU利用。

- 启多个进程，每个进程绑定不同的端口，主进程对外接受所有的网络请求，再将这些请求分别代理到不同的端口的进程上，通过代理可以避免端口不能重复监听的问题，甚至可以再代理进程上做适当的负载均衡，由于进程每接收到一个连接，将会用掉一个文件描述符，因此代理方案中客户端连接到代理进程，代理进程连接到工作进程的过程需要用掉两个文件描述符，操作系统的文件描述符是有限的，代理方案浪费掉一倍数量的文件描述符的做法影响了系统的扩展能力。
- 父进程创建socket，并且bind、listen后，通过fork创建多个子进程，通过send方法给每个子进程传递这个socket，子进程调用accpet开始监听等待网络连接。

```javascript
// master.js
var fork =require('child_process').fork;
var cpus =require('os').cpus();
var server =require('net').createServer()
server.listen(1337);
for(vari=0;i<cpus.length;i++){
  var worker = fork(.\/worker.js);
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

有多个进程同时等待网络的连接事件，当这个事件发生时，这些进程被同时唤醒，就会产生"惊群问题"。我们知道进程被唤醒，需要进行内核重新调度，这样每个进程同时去响应这一个事件，而最终只有一个进程能处理事件成功，其他的进程在处理该事件失败后重新休眠或其他，浪费性能。 而且这时采用的是操作系统的抢占式策略，谁抢到谁服务，一般而言这是公平的，各个进程可以根据自己的繁忙度来进行抢占，但对于node来说，需要分清他的繁忙度是由CPU，I/O两部分构成的，影响抢占的是CPU的繁忙度，对于不同的业务可能存在I/O繁忙，而CPU较为空闲的情况，这可能造成某个进程抢到较多请求，形成负载不均衡的情况。

- 为了解决负载均衡以及消除惊群效应，改进是在master调用accpet开始监听等待网络连接，master来控制请求的给予。将获得的连接均衡的传递给子进程。

```js
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
  var worker = fork(.\/worker.js);
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

但负责接收socket的master需要重新分配发送socket ，而且仅有一个进程去accept连接，效率会降低 node官方的cluster模块就是这么实现的，实质是采用了round－robin轮叫调度算法。

### 集群稳定

* 自动重启：我们在主进程上要加入一些子进程管理的机制，比如在一个子进程挂掉后，要重新启动一个子进程来继续服务.假设子进程中有未捕获异常发生；

```js
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
// 主进程中监听每个子进程的exit事件
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

上述代码中存在的问题是要等到已有的所有连接断开后进程才退出，在极端的情况下，所有工作进程都停止接收新链接，全处在等待退出状态。但在等到进程完全退出才重启的过程中，所有新来的请求可能存在没有工作进程为新用户服务的场景，这会丢掉大部分请求。 为此需要改进，在子进程停止接收新链接时，主进程就要fork新的子进程继续服务。为此在工作进程得知要退出时，向主进程主动发送一个自杀信号，然后才停止接收新连接。主进程在收到自杀信号后立即创建新的工作进程。

```js
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

工作进程不能无限制的被重启，如果启动的过程中就发生了错误或者启动后接到连接就收到错误，会导致工作进程被频繁重启。所以要加以限制，比如在单位时间内规定只能重启 多少次，超过限制就触发giveup事件，告知放弃重启工作进程这个重要事件。 我们引入一个队列来做标记，在每次重启工作进程之间打点判断重启是否过于频繁。

```js
// 在master.js加入如下代码

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

// 检查是否太过频繁
if (isTooFrequently()) {
  //触发giveup事件后，不再重启
  process.emit('giveup', length, duiring);
  return;
}
```

giveup事件是比uncaughtException更严重的异常事件，giveup事件表示集群中没有任何进程服务了，十分危险。为了健壮性考虑，我们应在giveup事件中添加重要日志，并让监控系统监视到这个严重错误，进而报警等

gisconnect事件表示父子进程用于通信的channel关闭了，此时父子进程之间失去了联系，自然是无法传递客户端接收到的连接了。失去联系不表示会退出，worker进程有可能仍然在运行，但此时已经无力接收请求了。所以当master进程收到某个worker disconnect的事件时，先需要kill掉worker，然后再fork一个worker。

```js
// 在createWorker中添加如下代码
worker.on('disconnect', function(){
  worker.kill();
  console.log('worker' + worker.pid + 'killed')
  createWorker();
})
```

## 代理服务器

```
location / {
    proxy_pass http://APP_PRIVATE_IP_ADDRESS:8080;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_set_header Host $host;
    proxy_cache_bypass $http_upgrade;
}
```

## Web开发

软件开始主要运行在桌面上，而数据库这样的软件运行在服务器端，这种Client/Server模式简称CS架构。

CS架构不适合Web，最大的原因是Web应用程序的修改和升级非常迅速，而CS架构需要每个客户端逐个升级桌面App，因此，Browser/Server模式开始流行，简称BS架构。

* 客户端只需要浏览器，应用程序的逻辑和数据都存储在服务器端。浏览器只需要请求服务器，获取Web页面，并把Web页面展示给用户即可。
* Web页面也具有极强的交互性。由于Web页面是用HTML编写的，而HTML具备超强的表现力，并且，服务器端升级后，客户端无需任何部署就可以使用到新的版本

### 发展阶段

* 静态Web页面：由文本编辑器直接编辑并生成静态的HTML页面，如果要修改Web页面的内容，就需要再次编辑HTML源文件，早期的互联网Web页面就是静态的；
* CGI：由于静态Web页面无法与用户交互，比如用户填写了一个注册表单，静态Web页面就无法处理。要处理用户发送的动态数据，出现了Common Gateway Interface，简称CGI，用C/C++编写。
* ASP/JSP/PHP：由于Web应用特点是修改频繁，用C/C++这样的低级语言非常不适合Web开发，而脚本语言由于开发效率高，与HTML结合紧密，因此，迅速取代了CGI模式。ASP是微软推出的用VBScript脚本编程的Web开发技术，而JSP用Java来编写脚本，PHP本身则是开源的脚本语言。
* MVC：为了解决直接用脚本语言嵌入HTML导致的可维护性差的问题，Web应用也引入了Model-View-Controller的模式，来简化Web开发。ASP发展为ASP.Net，JSP和PHP也有一大堆MVC框架。

常见的Web框架包括：Express，Sails.js，koa，Meteor，DerbyJS，Total.js，restify……
ORM框架比Web框架要少一些：Sequelize，ORM2，Bookshelf.js，Objection.js……
模版引擎PK：Jade，EJS，Swig，Nunjucks，doT.js……
测试框架包括：Mocha，Expresso，Unit.js，Karma……
构建工具有：Grunt，Gulp，Webpack……

### 实际服务器

* nginx作为反向代理服务器，拥有诸多优势，可以做负载均衡和静态资源服务器。
* 后面的两台机器就是我们的nodejs应用服务器集群。
* nginx 的负载均衡是用在多机器环境下的，单机的负载均衡还是要靠cluster 这类模块来做。
* nginx与node应用服务器的对比：
* nginx是一个高性能的反向代理服务器，要大量并且快速的转发请求，所以不能采用上面第三种方法，原因是仅有一个进程去accept，然后通过消息队列等同步方式使其他子进程处理这些新建的连接，效率会低一些。
* nginx采用第二种方法，那就依然可能会产生负载不完全均衡和惊群问题。nginx是怎么解决的呢：
* nginx中使用mutex互斥锁解决这个问题，具体措施有使用全局互斥锁，每个子进程在epoll_wait()之前先去申请锁，申请到则继续处理，获取不到则等待，并设置了一个负载均衡的算法（当某一个子进程的任务量达到总设置量的7/8时，则不会再尝试去申请锁）来均衡各个进程的任务量。具体的nginx如何解决惊群，看这篇文章: <http://blog.csdn.net/russell_tao/article/details/7204260>
* node应用服务器为什么可以采用方案三呢，我的理解是：node作为具体的应该服务器负责实际处理用户的请求，处理可能包含数据库等操作，不是必须快速的接收大量请求，而且转发到某具体的node单台服务器上的请求较之nginx也少了很多。

##  问题

> node-sass

```sh
npm install -g mirror-config-china --registry=http://registry.npm.taobao.org
npm install node-sass

SASS_BINARY_SITE=https://npm.taobao.org/mirrors/node-sass/ npm install node-sass

yarn install node-sass
```

## 面试

* [jimuyouyou/node-interview-questions](https://github.com/jimuyouyou/node-interview-questions)

## 教程

* [The Node Beginner Book](https://www.nodebeginner.org/index-zh-cn.html)
* [ElemeFE/node-practice](https://github.com/ElemeFE/node-practice):Node.js 实践教程
* [Chiara-yen/startLearningNodejs](https://github.com/Chiara-yen/startLearningNodejs):
* [scotch-io/node-todo](https://github.com/scotch-io/node-todo):A simple Node/MongoDB/Angular todo app https://scotch.io/tutorials/creating-…
* [i0natan/nodebestpractices](https://github.com/i0natan/nodebestpractices):The largest Node.JS best practices list. Curated from the top ranked articles and always updated
* [nodejs](https://www.runoob.com/nodejs)
* [alsotang/node-lessons](https://github.com/alsotang/node-lessons):📕《Node.js 包教不包会》 by alsotang
* [node-in-debugging](https://github.com/nswbmw/node-in-debugging):《Node.js 调试指南》
* [nodejs入门](https://leanpub.com/nodebeginner-chinese)
* [NodeJS的代码调试和性能调优](http://www.cnblogs.com/hustskyking/p/how-to-build-a-https-server.html)
* [swbmw/node-in-debugging](https://github.com/nswbmw/node-in-debugging):《Node.js 调试指南》
* [Node.js v8.x 中文文档](https://www.nodeapp.cn/)
* [i0natan/nodebestpractices](https://github.com/i0natan/nodebestpractices):The largest Node.JS best practices list (November 2018) https://twitter.com/nodepractices/

## 工具

* main
  - [nodesource/distributions](https://github.com/nodesource/distributions):NodeSource Node.js Binary Distributions
  - [Dist](http://nodejs.org/dist/)
  - [motdotla/dotenv](https://github.com/motdotla/dotenv):Loads environment variables from .env for nodejs projects.
* 框架
    - [fastify/fastify](https://github.com/fastify/fastify) Fast and low overhead web framework, for Node.js https://www.fastify.io/
    - [sahat/hackathon-starter](https://github.com/sahat/hackathon-starter):A boilerplate for Node.js web applications
    - [balderdashy/sails](https://github.com/balderdashy/sails):Realtime MVC Framework for Node.js https://sailsjs.com
    - [nestjs/nest](https://github.com/nestjs/nest):A progressive Node.js framework for building efficient, scalable, and enterprise-grade server-side applications on top of TypeScript & JavaScript (ES6, ES7, ES8) rocket https://nestjs.com/
    - [NodeBB/NodeBB](https://github.com/NodeBB/NodeBB):Node.js based forum software built for the modern web https://nodebb.org
* Compiler
  - [zeit/ncc](https://github.com/zeit/ncc):Node.js Compiler Collection
* Weibo
  - [node-modules/weibo](https://github.com/node-modules/weibo):weibo nodejs sdk http://github.com/fengmk2/node-weibo
* 缓存
  - [isaacs/node-lru-cache](https://github.com/isaacs/node-lru-cache)
* Error
  - [AriaMinaei/pretty-error](https://github.com/AriaMinaei/pretty-error):See node.js errors with less clutter
* Proxy
  - [OptimalBits/redbird](https://github.com/OptimalBits/redbird):A modern reverse proxy for node
  - [alibaba/anyproxy](https://github.com/alibaba/anyproxy):A fully configurable http/https proxy in NodeJS http://anyproxy.io
    - [chimurai/http-proxy-middleware](https://github.com/chimurai/http-proxy-middleware):⚡️ The one-liner node.js http-proxy middleware for connect, express and browser-sync
* db
  - [NodeRedis/node_redis](https://github.com/NodeRedis/node_redis):redis client for node http://redis.js.org/
  - [luin/ioredis](https://github.com/luin/ioredis):🚀A robust, performance-focused and full-featured Redis client for Node.js.
  - [typeorm/typeorm](https://github.com/typeorm/typeorm):ORM for TypeScript and JavaScript (ES7, ES6, ES5). Supports MySQL, PostgreSQL, MariaDB, SQLite, MS SQL Server, Oracle, WebSQL databases. Works in NodeJS, Browser, Ionic, Cordova and Electron platforms. http://typeorm.io
  - [sequelize/sequelize](https://github.com/sequelize/sequelize):An easy-to-use multi SQL dialect ORM for Node.js https://sequelize.org
* HTTP
    - [sindresorhus / got](https://github.com/sindresorhus/got):🌐 Human-friendly and powerful HTTP request library for Node.js
    - [tj/co](https://github.com/tj/co):The ultimate generator based flow-control goodness for nodejs (supports thunks, promises, etc)
* Logger
  - [winstonjs/winston](https://github.com/winstonjs/winston):A logger for just about everything. http://github.com/winstonjs/winston
  - [expressjs/morgan](https://github.com/expressjs/morgan):HTTP request logger middleware for node.js
* authenticate
  - [jaredhanson/passport](https://github.com/jaredhanson/passport)：Simple, unobtrusive authentication for Node.js. http://www.passportjs.org
* 监控
  - [lloyd/node-memwatch](https://github.com/lloyd/node-memwatch):A NodeJS library to keep an eye on your memory usage, and discover and isolate leaks.
  - [etsy/statsd](https://github.com/etsy/statsd):Daemon for easy but powerful stats aggregation
* cli
  - [yargs/yargs](https://github.com/yargs/yargs):yargs the modern, pirate-themed successor to optimist. http://yargs.js.org/
  - [tj/commander.js](https://github.com/tj/commander.js):node.js command-line interfaces made easy
* render
  - [GoogleChromeLabs/carlo](https://github.com/GoogleChromeLabs/carlo):Web rendering surface for Node applications
* Kafka
  - [SOHU-Co/kafka-node](https://github.com/SOHU-Co/kafka-node):Node.js client for Apache Kafka 0.8 and later.
* compression
  - [expressjs/compression](https://github.com/expressjs/compression):Node.js compression middleware
* hooks
  - [typicode/husky](https://github.com/typicode/husky):🐶 Git hooks made easy
* i18n
  - [i18next/i18next](https://github.com/i18next/i18next):i18next: learn once - translate everywhere http://i18next.com/
* REST
  - [restify/node-restify](https://github.com/restify/node-restify):The future of Node.js REST development http://restify.com
* package
  - [zeit/pkg](https://github.com/zeit/pkg):Package your Node.js project into an executable https://npmjs.com/pkg
* test
  - [GoogleChromeLabs/ndb](https://github.com/GoogleChromeLabs/ndb):ndb is an improved debugging experience for Node.js, enabled by Chrome DevTools
  - [DevExpress/testcafe](https://github.com/DevExpress/testcafe):A Node.js tool to automate end-to-end web testing. https://devexpress.github.io/testcafe/
  - [visionmedia/supertest](https://github.com/visionmedia/supertest):🕷Super-agent driven library for testing node.js HTTP servers using a fluent API
  - [ getgauge / taiko ](https://github.com/getgauge/taiko):A node.js library for testing modern web applications https://taiko.dev
  - [ mcollina / autocannon ](https://github.com/mcollina/autocannon):fast HTTP/1.1 benchmarking tool written in Node.js
  - [ octalmage / robotjs ](https://github.com/octalmage/robotjs):Node.js Desktop Automation. http://robotjs.io/
  - [Marak/faker.js](https://github.com/Marak/faker.js):generate massive amounts of realistic fake data in Node.js and the browser
* [Unitech / pm2](https://github.com/Unitech/pm2):Node.js Production Process Manager with a built-in Load Balancer. https://pm2.io
* date
    - [](https://github.com/date-fns/date-fns): hourglass_flowing_sand Modern JavaScript date utility library hourglass
* [GoogleChromeLabs/carlo](https://github.com/GoogleChromeLabs/carlo):Web rendering surface for Node applications
* [kamranahmedse/pennywise](https://github.com/kamranahmedse/pennywise):Cross-platform application to open anything in a floating window
* [noble/bleno](https://github.com/noble/bleno):A Node.js module for implementing BLE (Bluetooth Low Energy) peripherals
* [octalmage/robotjs](https://github.com/octalmage/robotjs):Node.js Desktop Automation. http://robotjs.io

## reference

* [Guides](https://nodejs.org/en/docs/guides/)
* [Node.js v11.6.0 Documentation](https://nodejs.org/api/)
* [goldbergyoni/nodebestpractices](https://github.com/goldbergyoni/nodebestpractices):white_check_mark The largest Node.js best practices list (September 2019) https://twitter.com/nodepractices/
