
# [NervJS/taro](https://github.com/NervJS/taro)

多端统一开发框架，支持用 React 的开发方式编写一次代码，生成能运行在微信小程序、H5、React Native 等的应用。 https://taro.aotu.io

## 版本

* 1.2
    - 将已有微信小程序转换为多端应用

## 使用

```sh
npm install -g @tarojs/cli
yarn global add @tarojs/cli

taro init myApp

# 编译预览模式
npm run dev:weapp|h5
# 仅限全局安装
taro build --type weapp|h5 --watch
# npx 用户也可以使用
npx taro build --type weapp|h5 --watch

# 打包
npm build dev:weapp|h5
# 仅限全局安装
taro build --type weapp|h5
# npx 用户也可以使用
npx taro build --type weapp|h5
```
