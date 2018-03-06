# 客户端


## 抓包

* fiddler

客户端与监测机处于同一网络

* 客户端wifi添加代理：监测机的IP与端口8888

## TOKEN

网站应用一般使用Session进行登录用户信息的存储及验证，而在移动端使用Token则更加普遍.Token比较像是一个更加精简的自定义的Session。Session的主要功能是保持会话信息，而Token则只用于登录用户的身份鉴权

* 客户端通过登录请求提交用户名和密码，服务端验证通过后生成一个Token与该用户进行关联，并将Token返回给客户端
* 客户端在接下来的请求中都会携带Token，服务端通过解析Token检查登录状态
* 当用户退出登录、其他终端登录同一账号（被顶号）、长时间未进行操作时Token会失效，这时用户需要重新登录

```
code
```

## 扩展

- [Tencent/VasSonic](https://github.com/Tencent/VasSonic)a lightweight and high-performance Hybrid framework developed by tencent VAS team, which is intended to speed up the first screen of websites working on Android and iOS platform.
- [Bilibili/ijkplayer](https://github.com/Bilibili/ijkplayer)Android/iOS video player based on FFmpeg n3.3, with MediaCodec, VideoToolbox support.
- [airbnb/lottie-android](https://github.com/airbnb/lottie-android):Render After Effects animations natively on Android and iOS, Web, and React Native http://airbnb.io/lottie/
- [airbnb/lottie-ios](https://github.com/airbnb/lottie-ios):An iOS library to natively render After Effects vector animations http://airbnb.io/lottie/
