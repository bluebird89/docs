# [axios/axios](https://github.com/axios/axios)

Promise based HTTP client for the browser and node.js

* 参考
  - [教程](https://segmentfault.com/a/1190000008470355?utm_source=tuicool&utm_medium=referral)
  - [Axios 源码解读](https://juejin.im/post/5cb5d9bde51d456e62545abcpfront)

```js
npm install axios
bower install axios

import axios from 'axios';

<script src="https://unpkg.com/axios/dist/axios.min.js"></script>

axios.request(config)
axios.get(url[, config])
axios.delete(url[, config])
axios.head(url[, config])
axios.post(url[, data[, config]])
axios.put(url[, data[, config]])
axios.patch(url[, data[, config]])
axios.all(iterable)
axios.spread(callback)

// Make a request for a user with a given ID
axios.get('/user?ID=12345')
  .then(function (response) {
    console.log(response);
  })
  .catch(function (error) {
    console.log(error);
  });

// Optionally the request above could also be done as
axios.get('/user', {
    params: {
      ID: 12345
    }
  })
  .then(function (response) {
    console.log(response);
  })
  .catch(function (error) {
    console.log(error);
  });

// Want to use async/await? Add the `async` keyword to your outer function/method.
async function getUser() {
  try {
    const response = await axios.get('/user?ID=12345');
    console.log(response);
  } catch (error) {
    console.error(error);
  }
}

axios.post('/user', {
    firstName: 'Fred',
    lastName: 'Flintstone'
  })
  .then(function (response) {
    console.log(response);
  })
  .catch(function (error) {
    console.log(error);
  });

function getUserAccount() {
  return axios.get('/user/12345');
}

function getUserPermissions() {
  return axios.get('/user/12345/permissions');
}

axios.all([getUserAccount(), getUserPermissions()])
  .then(axios.spread(function (acct, perms) {
    // Both requests are now complete
  }));

axios({
  method: 'post',
  url: '/user/12345',
  data: {
    firstName: 'Fred',
    lastName: 'Flintstone'
  }
});

var instance = axios.create({
  baseURL: 'https://some-domain.com/api/',
  timeout: 1000,
  headers: {'X-Custom-Header': 'foobar'}
});

{ //`url`是请求的服务器地址
url:'/user',
//`method`是请求资源的方式
method:'get'//default
//如果`url`不是绝对地址，那么`baseURL`将会加到`url`的前面
//当`url`是相对地址的时候，设置`baseURL`会非常的方便
baseURL:'https://some-domain.com/api/',
//`transformRequest`选项允许我们在请求发送到服务器之前对请求的数据做出一些改动
//该选项只适用于以下请求方式：`put/post/patch`
//数组里面的最后一个函数必须返回一个字符串、-一个`ArrayBuffer`或者`Stream`
transformRequest:[function(data){
//在这里根据自己的需求改变数据
return data;
}],
//`transformResponse`选项允许我们在数据传送到`then/catch`方法之前对数据进行改动
transformResponse:[function(data){
//在这里根据自己的需求改变数据
return data;
}],
//`headers`选项是需要被发送的自定义请求头信息
headers: {'X-Requested-With':'XMLHttpRequest'},
//`params`选项是要随请求一起发送的请求参数----一般链接在URL后面 /
//他的类型必须是一个纯对象或者是URLSearchParams对象
params: { ID:12345 },
//`paramsSerializer`是一个可选的函数，起作用是让参数（params）序列化
//例如(https://www.npmjs.com/package/qs,http://api.jquery.com/jquery.param)
paramsSerializer: function(params){
return Qs.stringify(params,{arrayFormat:'brackets'})
},
//`data`选项是作为一个请求体而需要被发送的数据
//该选项只适用于方法：`put/post/patch`
//当没有设置`transformRequest`选项时dada必须是以下几种类型之一 string/plain/object/ArrayBuffer/ArrayBufferView/URLSearchParams
//仅仅浏览器：FormData/File/Bold
//仅node:Stream
data {
firstName:"Fred"
},
//`timeout`选项定义了请求发出的延迟毫秒数
//如果请求花费的时间超过延迟的时间，那么请求会被终止
timeout:1000,
//`withCredentails`选项表明了是否是跨域请求
withCredentials:false,//default
//`adapter`适配器选项允许自定义处理请求，这会使得测试变得方便
//返回一个promise,并提供验证返回
adapter: function(config){ /*..........*/ },
//`auth`表明HTTP基础的认证应该被使用，并提供证书
//这会设置一个authorization头（header）,并覆盖你在header设置的Authorization头信息
auth: { username:"zhangsan", password: "s00sdkf" },
//返回数据的格式
//其可选项是arraybuffer,blob,document,json,text,stream
responseType:'json',//default
xsrfCookieName: 'XSRF-TOKEN',//default
xsrfHeaderName:'X-XSRF-TOKEN',//default
//`onUploadProgress`上传进度事件
onUploadProgress:function(progressEvent){
//下载进度的事件
onDownloadProgress:function(progressEvent){ }
},
//相应内容的最大值
maxContentLength:2000,
//`validateStatus`定义了是否根据http相应状态码，来resolve或者reject promise
//如果`validateStatus`返回true(或者设置为`null`或者`undefined`),那么promise的状态将会是resolved,否则其状态就是rejected
validateStatus:function(status){
return status >= 200 && status <300;//default
},
//`maxRedirects`定义了在nodejs中重定向的最大数量
maxRedirects: 5,//default
//`httpAgent/httpsAgent`定义了当发送http/https请求要用到的自定义代理 //keeyAlive在选项中没有被默认激活
httpAgent: new http.Agent({keeyAlive:true}),
httpsAgent: new https.Agent({keeyAlive:true}),
//proxy定义了主机名字和端口号，
//`auth`表明http基本认证应该与proxy代理链接，并提供证书
//这将会设置一个`Proxy-Authorization` header,并且会覆盖掉已经存在的`Proxy-Authorization`
header proxy: {
    host:'127.0.0.1',
    port: 9000,
    auth: {
        username:'skda',
        password:'radsd'
    }
},
//`cancelToken`定义了一个用于取消请求的cancel token
//详见cancelation部分
cancelToken: new cancelToken(function(cancel){ }) }

### 拦截器
// Add a request interceptor
axios.interceptors.request.use(function (config) {
    // Do something before request is sent
    return config;
  }, function (error) {
    // Do something with request error
    return Promise.reject(error);
  });

// Add a response interceptor
axios.interceptors.response.use(function (response) {
    // Do something with response data
    return response;
  }, function (error) {
    // Do something with response error
    return Promise.reject(error);
  });
```

## [lodash/lodash](https://github.com/lodash/lodash)

为数组、字符串、object 和 argument 对象提供更一致的跨环境迭代支持，并已成为 Underscore 的超集 A modern JavaScript utility library delivering modularity, performance, & extras. https://lodash.com/

## [eslint/eslint](https://github.com/eslint/eslint)

A fully pluggable tool for identifying and reporting on patterns in JavaScript https://eslint.org

* 配置
  - 主目录（通常 ~/）有一个配置文件，ESLint 只有在无法找到其他配置文件时才使用它
  - package.json 文件里的 eslintConfig
  - 独立的 .eslintrc.* 配置文件
  - 允许指定想要支持的 JavaScript 语言选项。默认情况下支持 ECMAScript 5 语法，可以覆盖该设置，以启用对 ECMAScript 其它版本和 JSX 的支持
  - 属性
    + Environments - 指定脚本的运行环境。每种环境都有一组特定的预定义全局变量。
    + Globals - 脚本在执行期间访问的额外的全局变量。
    + Rules - 启用的规则及其各自的错误级别。
    + parserOptions
      * ecmaVersion - 默认设置为 3，5（默认）， 可以使用 6、7、8、9 或 10 来指定你想要使用的 ECMAScript 版本
      * sourceType - 设置为 "script" (默认) 或 "module"（如果代码是 ECMAScript 模块)
      * ecmaFeatures - 这是个对象，表示你想使用的额外的语言特性:
      * globalReturn - 允许在全局作用域下使用 return 语句
      * impliedStrict - 启用全局 strict mode (如果 ecmaVersion 是 5 或更高)
      * jsx - 启用 JSX
      * experimentalObjectRestSpread - 启用实验性的 object rest/spread properties 支持。(重要：这是一个实验性的功能,在未来可能会有明显改变。 建议写的规则 不要 依赖该功能，除非当它发生改变时你愿意承担维护成本。)
    + Specifying Parser:默认使用Espree作为其解析器，你可以在配置文件中指定一个不同的解析器，只要该解析器符合下列要求：
      * 它必须是一个 Node 模块，可以从它出现的配置文件中加载。通常，这意味着应该使用 npm 单独安装解析器包
      * 它必须符合 parser interface
      * Esprima
      * Babel-ESLint - 一个对Babel解析器的包装，使其能够与 ESLint 兼容。
      * @typescript-eslint/parser - 将 TypeScript 转换成与 estree 兼容的形式，以便在ESLint中使用
    + Specifying Processor:插件可以提供处理器。处理器可以从另一种文件中提取 JavaScript 代码，然后让 ESLint 检测 JavaScript 代码。或者处理器可以在预处理中转换 JavaScript 代码。
      * 为特定类型的文件指定处理器，请使用 overrides 键和 processor 键的组合
* 工具
  - [standard/eslint-config-standard](https://github.com/standard/eslint-config-standard):ESLint Config for JavaScript Standard Style https://standardjs.com
  - [eslint-plugin-react](https://github.com/yannickcr/eslint-plugin-react) React specific linting rules for ESLint

```json
// .eslintrc.json
{
    "parserOptions": {
        "ecmaVersion": 6, # 不自动启用es6全局变量
        "sourceType": "module",
        "ecmaFeatures": {
            "jsx": true
        }
    },
    "parser": "esprima",
    "rules": {
        "semi": "error"
    },
    "plugins": ["a-plugin"], // 启用插件 a-plugin 提供的处理器 a-processor
    "processor": "a-plugin/a-processor",
    "overrides": [
        {
            "files": ["*.md"],
            "processor": "a-plugin/markdown"
        },
        {
            "files": ["**/*.md/*.js"],
            "rules": {
                "strict": "off"
            }
        }
    ]
}

// 对于新的 ES6 全局变量，使用   { "env": { "es6": true } } 自动启用es6语法
{ "env":{ "es6": true } }
```
