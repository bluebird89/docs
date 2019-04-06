# [uni-app](https://github.com/dcloudio/uni-app)

使用 Vue.js 开发跨平台应用的前端框架 http://uniapp.dcloud.io

## 应用生命周期

onLaunch    当uni-app 初始化完成时触发（全局只触发一次)
onShow  当 uni-app 启动，或从后台进入前台显示
onHide  当 uni-app 从前台进入后台

## 页面生命周期

* onLoad 监听页面加载，其参数为上个页面传递的数据，参数类型为Object（用于页面传参
* onShow 监听页面显示
* onReady 监听页面初次渲染完成
* onHide 监听页面隐藏
* onUnload 监听页面卸载
* onPullDownRefresh 监听用户下拉动作 ，一般用于下拉刷新
* onReachBottom 页面上拉触底事件的处理函数
* onPageScroll 监听页面滚动 ，参数为 Object
* onTabItemTap 当前是 tab 页时，点击 tab 时触发。
* onShareAppMessage 用户点击右上角分享

## 编辑器

* [HbuilderX](http://www.dcloud.io/hbuilderx.html)
