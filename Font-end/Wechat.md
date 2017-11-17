# 资源

- [littlecodersh/ItChat](https://github.com/littlecodersh/ItChat)
- [awesome-wechat-weapp](https://github.com/justjavac/awesome-wechat-weapp)
- [vux](https://github.com/airyland/vux)
- [mars](https://github.com/Tencent/mars)
- [weui](https://github.com/Tencent/weui)
- [overtrue/wechat](https://github.com/overtrue/wechat): It is probably the best SDK in the world for developing WeChat App. <http://easywechat.org>
- [wechat-php-sdk](https://github.com/dodgepudding/wechat-php-sdk)
- [Eric-Guo/wechat](https://github.com/Eric-Guo/wechat):API, command and message handling for WeChat in Rails
- [官方文档](https://open.weixin.qq.com/cgi-bin/showdocument?action=dir_list)

## git 服务器搭建

git密码：git8899

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
