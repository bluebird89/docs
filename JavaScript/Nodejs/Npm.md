# npm

Node.js的包管理工具（package manager）。

Node的包描述文件是一个JSON文件，用于描述非代码相关的信息。而NPM则是一个根据包规范来提供Node服务的Node包管理器。它解决了依赖包安装的问题，却面临着两个新的问题：

- 安装的时候无法保证速度和一致性。
- 安全问题，因为NPM安装时允许运行代码。

## 使用

```
npm i -g npm
```

## 代码

- [npm/npm](https://github.com/npm/npm):a package manager for javascript <http://www.npmjs.com/>
