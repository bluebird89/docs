# wechat

* 浏览器为单窗口

同一个微信开放平台下的客户端（包括小程序），用户的unioId是唯一的，openId各不相同

## git 服务器搭建

git：git8899

## 配置开发者模式

```php
define("TOKEN", "weixin");
$timestamp=$_GET['timestamp'];
$nonce=$_GET['nonce'];
$token=TOKEN;
$signature=$_GET['signature'];
$array=array($timestamp,$nonce,$token);
sort($array);
$tmpstr=implode('', $array);
$tmpstr=sha1($tmpstr);

if ($tmpstr==$signature) {
    echo $_GET['echostr'];
    exit;
}
```

## 网页授权

* code:redirect
* accessToken openId:
* userInfo

## platform

微信生态的构建

* [开放平台](https://open.weixin.qq.com/)
* [公众平台](https://mp.weixin.qq.com/):公众号、小程序
* [测试号](https://mp.weixin.qq.com/debug/cgi-bin/sandbox?t=sandbox/login)
* [有赞](https://www.youzan.com/)

## UI

* [wepayui/wepayui](https://github.com/wepayui/wepayui):微信支付场景化组件 https://wepayui.github.io
* [wux-weapp/wux-weapp](https://github.com/wux-weapp/wux-weapp):🐶 微信小程序自定义 UI 组件 https://wux-weapp.github.io/wux-weapp
* [weui](https://github.com/Tencent/weui):A UI library by WeChat official design team, includes the most useful widgets/modules in mobile web applications. https://weui.io

## 客户端

* [trazyn/weweChat](https://github.com/trazyn/weweChat):💬 Unofficial WeChat client built with React, MobX and Electron.

## 工具

* [15921483570/wechat_spider](https://github.com/15921483570/wechat_spider):微信公众号爬虫 (只需设置代理, 一键可以爬取所有历史文章)
* [aiportal/wechat-proxy](https://github.com/aiportal/wechat-proxy):微信代理服务
* [TKkk-iOSer/WeChatPlugin-MacOS](https://github.com/TKkk-iOSer/WeChatPlugin-MacOS):一款功能强大的 macOS 版微信小助手 v1.7.1 / A powerful assistant for wechat macOS
* [TKkk-iOSer/WeChatPlugin-iOS](https://github.com/TKkk-iOSer/WeChatPlugin-iOS):iOS 版微信小助手(防撤回、修改微信运动、游戏作弊、群管理、好友请求管理)
* [Tencent/MMKV](https://github.com/Tencent/MMKV):An efficient, small mobile key-value storage framework developed by WeChat. Works on iOS and Android.
* [chanxuehong/wechat](https://github.com/chanxuehong/wechat):weixin/wechat/微信公众平台/微信企业号/微信商户平台/微信支付 go/golang sdk https://gopkg.in/chanxuehong/wechat.v2
* [jxtech/wechatpy](https://github.com/jxtech/wechatpy):WeChat SDK for Python http://docs.wechatpy.org
* [littlecodersh/ItChat](https://github.com/littlecodersh/ItChat):A complete and graceful API for Wechat. 微信个人号接口、微信机器人及命令行微信，三十行即可自定义个人号机器人。 http://itchat.readthedocs.io
* [mars](https://github.com/Tencent/mars):Mars is a cross-platform network component developed by WeChat.
* [overtrue/wechat](https://github.com/overtrue/wechat): It is probably the best SDK in the world for developing WeChat App. <http://easywechat.org>
* [wechat-php-sdk](https://github.com/dodgepudding/wechat-php-sdk)
* [Eric-Guo/wechat](https://github.com/Eric-Guo/wechat):API, command and message handling for WeChat in Rails
* [thenbsp/WeChat](https://github.com/thenbsp/wechat):微信公众平台第三方 SDK 开发包，优雅、健壮，可扩展，遵循 PSR 开发规范。
* [Urinx/WeixinBot](https://github.com/Urinx/WeixinBot):网页版微信API，包含终端版微信及微信机器人
* [littlecodersh/itchatmp](https://github.com/littlecodersh/itchatmp):A complete and graceful API for wechat mp. 完备优雅的微信公众号接口，原生支持同步、协程使用。 http://itchatmp.readthedocs.io

## 参考

* [官方文档](https://open.weixin.qq.com/cgi-bin/showdocument?action=dir_list)
