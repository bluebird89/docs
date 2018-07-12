# 小程序

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

## [tencentyun/wafer2-quickstart-php](https://github.com/tencentyun/wafer2-quickstart-php)

Wafer2 PHP 简化版 Demo，建议配合腾讯云微信小程序开发者工具解决方案一起使用。适用于想要使用 Wafer SDK 开发的开发者，Demo 对 SDK 进行了详细的使用和介绍，降低开发者的学习成本。

### 腾讯云一站式部署开通指引

* 通过微信公众平台授权登录腾讯云，打开[微信公众平台](https://mp.weixin.qq.com)注册并登录小程序，按如下步骤操作：
    - 单击左侧菜单栏中的【设置】。
    - 单击右侧 Tab 栏中的【开发者工具】。
    - 单击【腾讯云】，进入腾讯云工具页面，单击【开通】。
    - 使用小程序绑定的微信扫码即可将小程序授权给腾讯云，开通之后会自动进去腾讯云微信小程序控制台，显示开发环境已开通，此时可以进行后续操作。
    - **注意：** 此时通过小程序开发者工具查看腾讯云状态并不会显示已开通，已开通状态会在第一次部署开发环境之后才会同步到微信开发者工具上。
* 安装开发工具：下载并安装最新版本的[微信开发者工具](https://mp.weixin.qq.com/debug/wxadoc/dev/devtools/download.html)，使用小程序绑定的微信号扫码登录开发者工具。
* 初始化 Demo
    - 打开第二步安装的微信开发者工具，点击【小程序项目】按钮。
    - 输入小程序 AppID，项目目录选择一个**空的目录**，接着选择【建立腾讯云 PHP 启动模板】，点击确定创建小程序项目。
    - 再次点击【确定】进入开发者工具。
    - 后端上传：点击界面右上角的【腾讯云】图标，在下拉的菜单栏中选择【上传测试代码】。数据库密码与appId一致
    - 选择【模块上传】并勾选全部选项，然后勾选【部署后自动安装依赖】，点击【确定】开始上传代码。**不一致**：选择普通上传
    - 上传代码完成之后，点击右上角的【详情】按钮，接着选择【腾讯云状态】即可看到腾讯云自动分配给你的开发环境域名：
    - 完整复制（包括 `https://`）开发环境 request 域名，然后在编辑器中打开 `client/config.js` 文件，将复制的域名填入 `host` 中并保存，保存之后编辑器会自动编译小程序，左边的模拟器窗口即可实时显示出客户端的 Demo：
    - 在模拟器中点击【登录】，看到显示“登录成功”，即为开通完成，可以开始你的其他开发了。
* 测试

## UI组件

* [weui-wxss](https://github.com/weui/weui-wxss) ★1873 - 同微信原生视觉体验一致的基础样式库
* [youzan/zanui-weapp](https://github.com/youzan/zanui-weapp):高颜值、好用、易扩展的微信小程序 UI 库，Powered by 有赞
* [wx-charts](https://github.com/xiaolin3303/wx-charts) ★449 - 微信小程序图表工具
* [Wa-UI](https://github.com/liujians/Wa-UI) ★164 - 针对微信小程序整合的一套UI库
* [wux](https://github.com/skyvow/wux) ★163 - 微信小程序自定义组件
* [wemark](https://github.com/TooBug/wemark) ★161 - 微信小程序Markdown渲染库
* [wxapp](https://github.com/youzouzou/wxapp) ★131 - 微信小程序组件
* [wx-scrollable-tab-view](https://github.com/zhongjie-chen/wx-scrollable-tab-view) ★116 - 小程序可滑动得tabview
* [wxapp-img-loader](https://github.com/o2team/wxapp-img-loader) ★101 - 微信小程序的图片预加载组件
* [WeZRender](https://github.com/guyoung/WeZRender) ★96 - 微信小程序Canvas增强组件
* [wetoast](https://github.com/kiinlam/wetoast) ★77 - 仿照微信小程序提供的showToast功能
* [wx-alphabetical-listview](https://github.com/zhongjie-chen/wx-alphabetical-listview) ★71 - 带字母可滑动的列表小程序
* [wx-drawer](https://github.com/zhongjie-chen/wx-drawer) ★70 - 小程序模仿QQ6侧滑菜单
* [wxSearch](https://github.com/icindy/wxSearch) ★70 - 微信小程序优雅的搜索框
* [wx_calendar](https://github.com/treadpit/wx_calendar) ★65 - 小程序日历
* [wxapp-charts](https://github.com/hawx1993/wxapp-charts) ★52 - 微信小程序图表charts组件
* [chartjs-wechat-mini-app](https://github.com/xiabingwu/chartjs-wechat-mini-app) ★42 - chartjs微信小程序适配
* [citySelect](https://github.com/chenjinxinlove/citySelect) ★42 - 微信小程序城市选择器
* [WeiXinProject](https://github.com/lidong1665/WeiXinProject) ★36 - 列表的上拉刷新和上拉加载
* [wepy-com-charts](https://github.com/CalvinHong/wepy-com-charts) ★20 - 微信小程序wepyjs图表控件
* [WechatLoading](https://github.com/qq273681448/WechatLoading) ★14 - 加载框布局LoadingView
* [wxTabs](https://github.com/hss01248/wxTabs) ★13 - 微信小程序的多tab实现
* [wxapp-lock](https://github.com/demi520/wxapp-lock) ★12 - 微信小程序手势解锁
* [meili/minui](https://github.com/meili/minui):基于规范的小程序 UI 组件库，自定义标签组件，简洁、易用、工具化 https://meili.github.io/min/docs/minui/

## 开发框架

* [Tencent/wepy](https://github.com/Tencent/wepy):小程序组件化开发框架 https://tencent.github.io/wepy/
* [Labrador](https://github.com/maichong/labrador) ★785 - 微信小程序模块化开发框架
* [Meituan-Dianping/mpvue](https://github.com/Meituan-Dianping/mpvue):基于 Vue.js 的小程序开发框架，从底层支持 Vue.js 语法和构建工具体系。 http://mpvue.com

### 实用库

- [wxParse](https://github.com/icindy/wxParse) ★1107 - 微信小程序富文本解析自定义组件
- [wechat-weapp-redux](https://github.com/charleyw/wechat-weapp-redux) ★189 - 微信小程序Redux绑定
- [wxapp-socket-io](https://github.com/fanweixiao/wxapp-socket-io) ★123 - 微信小程序的SocketIO客户端
- [wafer-client-sdk](https://github.com/tencentyun/weapp-client-sdk) ★94 - 微信小程序客户端腾讯云增强 SDK
- [WxNotificationCenter](https://github.com/icindy/WxNotificationCenter) ★86 - 微信小程序通知广播模式类
- [wilddog-weapp](https://github.com/WildDogTeam/wilddog-weapp) ★67 - 野狗微信小程序客户SDK
- [wx-query](https://github.com/stephenml/wx-query) ★62 - 微信小程序仿jQuery插件
- [wxapp-google-analytics](https://github.com/rchunping/wxapp-google-analytics) ★59 - 让微信小程序支持谷歌统计
- [wxapp-jsapi](https://github.com/baidumapapi/wxapp-jsapi) ★49 - 百度地图微信小程序
- [wxstream](https://github.com/wpcfan/wxstream) ★19 - 微信小程序的响应式编程类库封装
- [upyun-wxapp-sdk](https://github.com/upyun/upyun-wxapp-sdk) ★16 - 又拍云微信小程序
* [ecomfe/echarts-for-weixin](https://github.com/ecomfe/echarts-for-weixin):ECharts 的微信小程序版本
* [skyvow/wux](https://github.com/skyvow/wux):dog wux - 微信小程序自定义组件（对话框、指示器、五星评分...）
* [wxParse](https://github.com/icindy/wxParse) ★1107 - 微信小程序富文本解析自定义组件

## 开发工具

* [开发工具](https://developers.weixin.qq.com/miniprogram/dev/devtools/download.html)
* [wept](https://github.com/chemzqm/wept) ★1097 - 实时微信小程序开发工具
* [weapp-quick](https://github.com/phodal/weapp-quick) ★320 - “微信Web开发者”拷贝工具
* [Wxapp.vim](https://github.com/chemzqm/wxapp.vim) ★213 - 微信小程序开发 Vim 插件
* [wechat_web_devtools](https://github.com/yuan1994/wechat_web_devtools) ★179 - 微信开发者工具Linux版  not maintained
* [miniapps](https://github.com/DDFE/miniapps) ★131 - 小程序项目脚手架工具
* [Matchmaker](https://github.com/lypeer/Matchmaker) ★107 - 专为微信小程序开发的插件
* [wecos](https://github.com/tencentyun/wecos) ★64 - 微信小程序 COS 瘦身解决方案
* [Meituan-Dianping/mpvue](https://github.com/Meituan-Dianping/mpvue):基于 Vue.js 的小程序开发框架，从底层支持 Vue.js 语法和构建工具体系。 http://mpvue.com

## 项目

- [wecqupt](https://github.com/lanshan-studio/wecqupt) ★255 - 在微信内被便捷地获取和传播
- [豆瓣电影项目](https://github.com/songhaoreact/豆瓣电影项目) ★118 - 微信小程序豆瓣电影项目
* [xwartz/wechat-app-demo](https://github.com/xwartz/wechat-app-demo):微信小程序 demo
* [skyvow/m-mall-admin](https://github.com/skyvow/m-mall-admin):dog 微信小程序-小商城后台（基于 Node.js、MongoDB、Redis 开发的系统...）
* [liuxuanqiang/wechat-weapp-mall](https://github.com/liuxuanqiang/wechat-weapp-mall):微信小程序-移动端商城
* [yesifeng/wechat-weapp-movie](https://github.com/yesifeng/wechat-weapp-movie):电影推荐 - 微信小程序 https://sesine.com/mina/
* [tencentyun/wafer2-startup](https://github.com/tencentyun/wafer2-startup):Wafer - 腾讯云下一代小程序综合解决方案
* [tumobi/nideshop-mini-program](https://github.com/tumobi/nideshop-mini-program):NideShop：基于Node.js+MySQL开发的开源微信小程序商城（微信小程序） https://nideshop.com/
* [tumobi/nideshop](https://github.com/tumobi/nideshop):NideShop 开源微信小程序商城服务端（Node.js + ThinkJS） https://nideshop.com/
* [EastWorld/wechat-app-mall](https://github.com/EastWorld/wechat-app-mall): 微信小程序商城，微信小程序微店
- [weapp-demo](https://github.com/zce/weapp-demo) ★1086 - 仿豆瓣电影微信小程序
- [wechat-weapp-gank](https://github.com/lypeer/wechat-weapp-gank) ★604 - Gank微信小程序
- [SmallAppForQQ](https://github.com/xiehui999/SmallAppForQQ) ★561 - 微信小程序高仿QQ应用
- [weapp-wechat-zhihu](https://github.com/RebeccaHanjw/weapp-wechat-zhihu) ★518 - 微信中的知乎
- [仿芒果TV](https://github.com/web-Marker/wechat-Development) ★326 - 微信小程序demo
- [weChatApp-Run](https://github.com/alanwangmodify/weChatApp-Run) ★265 - 跑步微信小程序Demo
- [wechat-v2ex](https://github.com/jectychen/wechat-v2ex) ★235 - 简单的v2ex微信小程序
- [腾讯云微信小程序](https://github.com/tencentyun/weapp-client-demo) ★234 - 一站式解决方案客户端示例
- [weapp-weipiao](https://github.com/wangmingjob/weapp-weipiao) ★234 - 微信小程序-微票
- [wechat-weapp-taobao](https://github.com/ChangQing666/wechat-weapp-taobao) ★227 - 微信小程序demo 仿手机淘宝
- [weapp-boilerplate](https://github.com/zce/weapp-boilerplate) ★220 - 一个为微信小程序开发准备的基础骨架
- [wechat_mall_applet](https://github.com/bayetech/wechat_mall_applet) ★201 - 巴爷微信商城的简单版本
- [wechat-weapp-movie](https://github.com/yesifeng/wechat-weapp-movie) ★182 - 微信小程序 - 电影推荐
- [wechat-app-zhihudaily](https://github.com/myronliu347/wechat-app-zhihudaily) ★173 - 微信小程序-知乎日报
- [wechat-app-music](https://github.com/eyasliu/wechat-app-music) ★153 - 微信小程序： 音乐播放器
- [fenda-mock](https://github.com/davedavehong/fenda-mock) ★153 - 使用微信小程序实现分答这款APP的基础功能
- [wechat-weapp-mapdemo](https://github.com/giscafer/wechat-weapp-mapdemo) ★152 - 微信小程序开发demo-地图定位
- [Artand](https://github.com/SuperKieran/weapp-artand) ★123 - 微信小程序
- [weapp-douban-film](https://github.com/hingsir/weapp-douban-film) ★112 - 微信小程序 - 豆瓣电影
- [wepy-wechat-demo](https://github.com/wepyjs/wepy-wechat-demo) ★105 - wepy仿微信聊天界面
- [weapp-one](https://github.com/ahonn/weapp-one) ★104 - 仿 「ONE · 一个」 的微信小程序
- [wechat-weapp-redux-todos](https://github.com/charleyw/wechat-weapp-redux-todos) ★102 - 微信小程序集成Redux实现的Todo list
- [weapp-zhihulive](https://github.com/dongweiming/weapp-zhihulive) ★98 - 基于Zhihu Live数据的微信小程序
- [BearDiary](https://github.com/harveyqing/BearDiary) ★97 - 微信小程序之小熊の日记
- [netmusic-app](https://github.com/sqaiyan/netmusic-app) ★95 - 仿网易云音乐APP的微信小程序
- [wxflex](https://github.com/icindy/wxflex) ★75 - 微信小程序的Flex布局demo
- [番茄时钟](https://github.com/kraaas/timer) ★75 - 番茄时钟微信小程序版
- [weapp-node-server-demo](https://github.com/tencentyun/weapp-node-server-demo) ★72 - Wafer 服务端 Demo
- [wechat-chat](https://github.com/ericzyh/wechat-chat) ★71 - 微信小程序版聊天室
- [wxapp-sCalc](https://github.com/dunizb/wxapp-sCalc) ★66 - 微信小程序版简易计算器，适合入门练手
- [weapp-demo-session](https://github.com/CFETeam/weapp-demo-session) ★66 - 微信小程序示例一笔到底
- [weapp-demo-breadtrip](https://github.com/romoo/weapp-demo-breadtrip) ★62 - 基于面包旅行 API 制作的微信小程序示例
- [wechatapp-news-reader](https://github.com/vace/wechatapp-news-reader) ★59 - 新闻阅读器
- [wechat-weapp-demo](https://github.com/SeptemberMaples/wechat-weapp-demo) ★58 - 一个简单的微信小程序购物车DEMO
- [weapp-newsapp](https://github.com/hijiangtao/weapp-newsapp) ★57 - 微信小程序-公众号热门文章信息流
- [weapp-girls](https://github.com/litt1e-p/weapp-girls) ★56 - 通过Node.js实现的妹子照片爬虫微信小程序
- [wechat-app-flexlayout](https://github.com/hardog/wechat-app-flexlayout) ★55 - 从FlexLayout布局开始学习微信小程序
- [wxapp-hiapp](https://github.com/BelinChung/wxapp-hiapp) ★52 - HiApp 微信小程序版
- [weapp-github](https://github.com/zhengxiaowai/weapp-github) ★50 - 微信小程序的简单尝试
- [bookbox-wxapp](https://github.com/ToadWoo/bookbox-wxapp) ★37 - 集美大学图书馆的便捷工具
- [WeChatMeiZhi](https://github.com/brucevanfdm/WeChatMeiZhi) ★36 - 微信小程序版妹纸图
- [weapp-V2ex](https://github.com/bestony/weapp-V2ex) ★36 - V2ex 微信小程序版
- [WXBaiSi](https://github.com/SureZhangHW/WXBaiSi) ★34 - 微信小程序仿百思不得姐
- [wx-audio](https://github.com/xingbofeng/wx-audio) ★33 - 微信小程序音乐播放器应用
- [wxapp-2048](https://github.com/natee/wxapp-2048) ★32 - 微信小程序2048
- [weapp-500px](https://github.com/fluency03/weapp-500px) ★32 - 微信小程序
- [yiyaowang-wx](https://github.com/jiabinxu/yiyaowang-wx) ★31 - 医药网原生APP的微信小程序DEMO
- [wxreading](https://github.com/gxmzjxk/wxreading) ★28 - 微信小程序跟读
- [WxMasonry](https://github.com/icindy/WxMasonry) ★27 - 微信小程序瀑布流布局模式
- [weapp](https://github.com/kunkun12/weapp) ★26 - 小程序 hello world 尝鲜
- [WechatApp-BaisiSister](https://github.com/Symous/WechatApp-BaisiSister) ★26 - 微信小程序版百思不得姐
- [wechat-app-xiaoyima](https://github.com/iamjs1/wechat-app-xiaoyima) ★26 - 仿大姨妈的微信小程序
- [WeChat_ayibang](https://github.com/Sukura7/WeChat_ayibang) ★25 - 微信小程序仿阿姨帮
- [hotapp-notepad](https://github.com/hotapp888/hotapp-notepad) ★25 - 微信小程序HotApp云笔记
- [wechatApp-netease_cloudmusic](https://github.com/MengZhaoFly/wechatApp-netease_cloudmusic) ★22 - 小程序模仿——网易云音乐
- [wxapp-mall](https://github.com/lin-xin/wxapp-mall) ★22 - 微信小程序商城demo
- [wx-mime](https://github.com/jsongo/wx-mime) ★20 - 微信小程序版的扫雷
- [PigRaising](https://github.com/SeaHub/PigRaising) ★20 - 专注管理时间的微信小程序
- [GankCamp-WechatAPP](https://github.com/iwgang/GankCamp-WechatAPP) ★19 - 微信小程序版干货集中营
- [weapp-lolgame](https://github.com/xiaowenxia/weapp-lolgame) ★18 - 英雄联盟(LOL)战绩查询
- [wxSortPickerView](https://github.com/icindy/wxSortPickerView) ★17 - 微信小程序首字母排序选择表
- [weapp-douban-movie](https://github.com/David-Guo/weapp-douban-movie) ★17 - 微信小程序版豆瓣电影
- [WexinApp_1024](https://github.com/RedLove/WexinApp_1024) ★16 - 简单的实现了1024的游戏规则
- [wechat-app-githubfeed](https://github.com/uniquexiaobai/wechat-app-githubfeed) ★14 - 微信小程序试玩
- [doule](https://github.com/mkxiansheng/doule) ★14 - 微信小程序逗乐
- [wxApp](https://github.com/Gavin-YYC/wxApp) ★14 - 一步步开发微信小程序
- [wx-mina-meteor](https://github.com/leijing7/wx-mina-meteor) ★14 - 一个 meteor 的 React todo list 例子
- [caipu_weixin](https://github.com/bestTao/caipu_weixin) ★12 - 微信小程序健康菜谱
- [jspapa-wx](https://github.com/biggerV/jspapa-wx) ★12 - jspapa微信小程序版本
- [CNodeJs-WXAPP](https://github.com/Shaman05/CNodeJs-WXAPP) ★12 - 微信小程序版的CNodeJs中文社区
- [weapp-LeanCloud](https://github.com/bestony/weapp-LeanCloud) ★12 - LeanCloud 的微信小程序用户登陆Demo
- [wejoke](https://github.com/zszdevelop/wejoke) ★11 - 微笑话微信小程序
- [liwushuoapp](https://github.com/chongbenben/liwushuoapp) ★11 - 微信小程序开发的App
- [tencentyun/wafer-client-sdk](https://github.com/tencentyun/wafer-client-sdk):Wafer - 快速构建具备弹性能力的微信小程序 https://github.com/tencentyun/wafer
* [b3log/symphony-weapp](https://github.com/b3log/symphony-weapp):📚 『书单』小程序 https://hacpai.com/tag/book_share

## 服务端

- [m-mall-admin](https://github.com/skyvow/m-mall-admin) ★137 - 创建REST API的样板应用
- [NAMI](https://github.com/wodenwang/nami) ★79 - 专为小程序而生的服务端开发容器
- [weapp-node-server-demo](https://github.com/tencentyun/weapp-node-server-demo) ★72 - Wafer 服务端 Demo
- [Wafer 服务端 SDK - Java](https://github.com/tencentyun/weapp-java-server-sdk) ★67 - 企业级微信小程序全栈方案
- [xpmjs](https://github.com/XpmJS/xpmjs) ★67 - 小程序云端增强 SDK
- [weapp-php-server-sdk](https://github.com/tencentyun/weapp-php-server-sdk) ★42 - 腾讯云微信小程序云端解决方案
- [tencentyun/wafer-php-server-demo](https://github.com/tencentyun/wafer-php-server-demo) Wafer - 企业级微信小程序全栈方案 https://github.com/tencentyun/wafer
* [tencentyun/wafer2-quickstart-nodejs](https://github.com/tencentyun/wafer2-quickstart-nodejs):Wafer2 Node.js 简化版 Demo

## 参考

* [微信小程序开发文档](https://developers.weixin.qq.com/miniprogram/dev/)
* [小程序开发文档](https://developers.weixin.qq.com/miniprogram/dev/index.html)
* [小程序快速上手：三步完成小程序从无到有的开发](http://blog.csdn.net/gitchat/article/details/77863478)
* [首个微信小程序开发教程](https://juejin.im/entry/57e34d6bd2030900691e9ad7)
* http://www.infoq.com/cn/articles/5-steps-build-your-first-mini-program
* http://www.cnblogs.com/luyucheng/p/6274561.html
