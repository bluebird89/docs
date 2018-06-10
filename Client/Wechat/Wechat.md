# wechat

* [开放平台](https://open.weixin.qq.com/)
* [公众平台](https://mp.weixin.qq.com/):公众号、小程序

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

## 参考

- [littlecodersh/ItChat](https://github.com/littlecodersh/ItChat):A complete and graceful API for Wechat. 微信个人号接口、微信机器人及命令行微信，三十行即可自定义个人号机器人。 http://itchat.readthedocs.io
- [awesome-wechat-weapp](https://github.com/justjavac/awesome-wechat-weapp):微信小程序开发资源汇总 100 http://justjavac.com
- [vux](https://github.com/airyland/vux)
- [mars](https://github.com/Tencent/mars)
- [weui](https://github.com/Tencent/weui):A UI library by WeChat official design team, includes the most useful widgets/modules in mobile web applications. https://weui.io
- [overtrue/wechat](https://github.com/overtrue/wechat): It is probably the best SDK in the world for developing WeChat App. <http://easywechat.org>
- [wechat-php-sdk](https://github.com/dodgepudding/wechat-php-sdk)
- [Eric-Guo/wechat](https://github.com/Eric-Guo/wechat):API, command and message handling for WeChat in Rails
- [官方文档](https://open.weixin.qq.com/cgi-bin/showdocument?action=dir_list)
- [thenbsp/WeChat](https://github.com/thenbsp/wechat):微信公众平台第三方 SDK 开发包，优雅、健壮，可扩展，遵循 PSR 开发规范。
- [Urinx/WeixinBot](https://github.com/Urinx/WeixinBot):网页版微信API，包含终端版微信及微信机器人
