# 小程序

微信生态的构建

小程序前段负责内容的展示，如果我们开发的是纯静态页面，那么只需要掌握上面的就可以。但是，如果我们要做动态页面，也就是页面内容是跟数据库交互的，就需要服务端来提供数据的交互。在小程序中，服务端是以接口的方式实现的，结果以json数据格式返回。
前端通过组件wx.request调用接口，来实现跟服务端的交互

## 搭建

* 登陆[微信公众号平台](http://mp.weixin.qq.com)注册账号
* 下载[开发工具](https://mp.weixin.qq.com/debug/wxadoc/dev/devtools/devtools.html)
* 创建项目,在网站的「设置」-「开发者设置」中，查看到微信小程序的 AppID 了。

## 结构

项目文件

* app.json：配置文件，配置路由列表、程序信息等。对整个小程序的全局配置。我们可以在这个文件中配置小程序是由哪些页面组成，配置小程序的窗口  背景色，配置导航条样式，配置默认标题。注意该文件不可添加任何注释。
* app.js：公共入口文件，小程序启动时的 Init 逻辑。app.js 是小程序的脚本代码。我们可以在这个文件中监听并处理小程序的生命周期函数、声明全局变量。调用 MINA 提供的丰富的 API，如本例的同步存储及同步读取本地数据。
* app.wxss ：公共样式文件，公共样式用于每个视图 View 中。
* 生命周期：在index.js里面

每一个页面需要创建一个文件夹，包含下面四个文件

* js：主要负责调用后端接口做数据交互，页面逻辑处理
* json：主要用来存储数据内容，一般用的较少
* wxml：相当于html，主要用来展示页面信息
* wxss：相当于css，跟css语法基本一致

## 部署

* 必须通过HTTPS部署，在后台配置服务器域名：设置合法域名，也就是服务端接口的域名地址
* 提交审核

## 工具

* [Tencent/wepy](https://github.com/Tencent/wepy):小程序组件化开发框架 https://tencent.github.io/wepy/
* [youzan/zanui-weapp](https://github.com/youzan/zanui-weapp):高颜值、好用、易扩展的微信小程序 UI 库，Powered by 有赞
* [ecomfe/echarts-for-weixin](https://github.com/ecomfe/echarts-for-weixin):ECharts 的微信小程序版本
* [meili/minui](https://github.com/meili/minui):基于规范的小程序 UI 组件库，自定义标签组件，简洁、易用、工具化 https://meili.github.io/min/docs/minui/

## Project

* [skyvow/m-mall-admin](https://github.com/skyvow/m-mall-admin):dog 微信小程序-小商城后台（基于 Node.js、MongoDB、Redis 开发的系统...） 
* [yesifeng/wechat-weapp-movie](https://github.com/yesifeng/wechat-weapp-movie):电影推荐 - 微信小程序 https://sesine.com/mina/
* [tencentyun/wafer2-startup](https://github.com/tencentyun/wafer2-startup):Wafer - 腾讯云下一代小程序综合解决方案
* [tumobi/nideshop-mini-program](https://github.com/tumobi/nideshop-mini-program):NideShop：基于Node.js+MySQL开发的开源微信小程序商城（微信小程序） https://nideshop.com/

## 参考

* [组件文档](https://mp.weixin.qq.com/debug/wxadoc/dev/api/)
* [小程序快速上手：三步完成小程序从无到有的开发](http://blog.csdn.net/gitchat/article/details/77863478)
* [首个微信小程序开发教程](https://juejin.im/entry/57e34d6bd2030900691e9ad7)
* [小程序文档](https://developers.weixin.qq.com/miniprogram/dev/demo.html)
* http://www.cnblogs.com/luyucheng/p/6274561.html
