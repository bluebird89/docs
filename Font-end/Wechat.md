# 资源

- [littlecodersh/ItChat](https://github.com/littlecodersh/ItChat)
- [electronic-wechat](https://github.com/geeeeeeeeek/electronic-wechat)
- [awesome-wechat-weapp](https://github.com/justjavac/awesome-wechat-weapp)
- [vux](https://github.com/airyland/vux)
- [mars](https://github.com/Tencent/mars)
- [weui](https://github.com/Tencent/weui)
- [overtrue/wechat](https://github.com/overtrue/wechat):有overtrue/laravel-wechat 扩展
- [wechat-php-sdk](https://github.com/dodgepudding/wechat-php-sdk)
- [官方文档](https://open.weixin.qq.com/cgi-bin/showdocument?action=dir_list)

## git 服务器搭建

git密码：git8899

## 配置开发者模式

```
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
