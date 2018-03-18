# 客户端

## TOKEN

网站应用一般使用Session进行登录用户信息的存储及验证，而在移动端使用Token则更加普遍.Token比较像是一个更加精简的自定义的Session。Session的主要功能是保持会话信息，而Token则只用于登录用户的身份鉴权

* Token 完全由应用管理，所以它可以避开同源策略
* Token 可以避免 CSRF 攻击
* Token 可以是无状态的，可以在多个服务间共享
* 从安全的角度考虑，还是从吊销的角度考虑，Token 都需要设有效期（坚持一周就好）：解决在操作过程不能让用户感到 Token 失效这个问题
    - Token 的过期时保存在缓存或者内存中
    - 一旦 Token 过期，就反馈给前端，前端使用 Refresh Token 申请一个全新 Token 继续使用


### 流程

* 客户端通过登录请求提交用户名和密码，服务端验证通过后生成一个Token与该用户进行关联，并将Token返回给客户端（Token 在服务端持久化比如存入数据库，那它就是一个永久的身份令牌）
* 客户端在接下来的请求中都会携带Token，服务端通过解析Token检查登录状态
* 服务器端采用filter过滤器校验。校验成功则返回请求数据，校验失败则返回错误码
* 当用户退出登录、其他终端登录同一账号（被顶号）、长时间未进行操作时Token会失效，这时用户需要重新登录

![登录](../_static/token_1.png "Optional title")
![业务请求](../_static/token_2.png "Optional title")
![Token 过期，刷新 Token](../_static/token_3.png "Optional title")

Redis是一个Key-Value结构的内存数据库，用它维护User Id和Token的映射表会比传统数据库速度更快

```
code
```

## 扩展

- [Tencent/VasSonic](https://github.com/Tencent/VasSonic)a lightweight and high-performance Hybrid framework developed by tencent VAS team, which is intended to speed up the first screen of websites working on Android and iOS platform.
- [Bilibili/ijkplayer](https://github.com/Bilibili/ijkplayer)Android/iOS video player based on FFmpeg n3.3, with MediaCodec, VideoToolbox support.
- [airbnb/lottie-android](https://github.com/airbnb/lottie-android):Render After Effects animations natively on Android and iOS, Web, and React Native http://airbnb.io/lottie/
- [airbnb/lottie-ios](https://github.com/airbnb/lottie-ios):An iOS library to natively render After Effects vector animations http://airbnb.io/lottie/
