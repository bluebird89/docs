# [meteor/meteor](https://github.com/meteor/meteor)

Meteor, the JavaScript App Platform https://www.meteor.com

* 优势
    - 全栈通用、统一的单一语言 JavaScript；
    - 内置响应式支持；
    - 代码高度重用，提供一大堆基础Packages；
    - 提供强大构建工具，帮助快速构建JavaScript Apps；
    - 拥有近13000个软件包的生态系统。

## 安装

```sh
curl https://install.meteor.com/ | sh
meteor create try-meteor
cd try-meteor
meteor
```

## 原则

* Data on the Wire. Meteor 不发送 HTML，服务器端只负责发送数据，由客户端渲染；
* One Language. 前后端都是 JavaScript 语言；
* Database Everywhere. 前后端都可以直接创建存取修改数据库里的数据，且数据安全；
* Latency Compensation. Meteor 在前端提前获取数据并模拟数据模型，使其看起来像是从服务器端立即返回了数据；
* Full Stack Reactivity. 实时响应是 Meteor 的缺省配置。在所有层次，从数据库到模板，都会在需要时自动更新；
* Embrace the Ecosystem. Meteor 完全开源并集成了很多现有的开源工具和框架。如 Angular，React。Meteor 有自己的 AtmosphereJS 包下载管理平台，也可使用 NPM；
* Simplicity Equals Productivity. Meteor 简单易上手，API 简洁优雅。

## 参考

* [TUTORIALS](https://www.meteor.com/tutorials)
* [guide](https://guide.meteor.com/)
