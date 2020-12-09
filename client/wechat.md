# wechat

* 浏览器为单窗口
* 同一个微信开放平台下的客户端（包括小程序），用户的unioId是唯一的，openId各不相同

## git 服务器搭建

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

```php

# 把access_token缓存到本地或者内存中，在项目中取缓存中的access_token来调用在2小时内都可以随便调用，没有调用次数的
# 2小时后过期了，请求access_token生成接口，生成新的access_token
<?php
//缓存access_token
function getToken(){
    $appid='填写你的APPID';//APPID
    $appsecret='填写你的APPSECRET';//APPSECRET
    $file = file_get_contents("access_token.json",true);//读取access_token.json里面的数据
    $result = json_decode($file,true);
    //判断access_token是否在有效期内，如果在有效期则获取缓存的access_token
    //如果过期了则请求接口生成新的access_token并且缓存access_token.json
    if (time() > $result['expires']){
        $data = array();
        $data['access_token'] = getNewToken($appid,$appsecret);
        $data['expires']=time()+7000;
        $jsonStr =  json_encode($data);
        $fp = fopen("access_token.json", "w");
        fwrite($fp, $jsonStr);
        fclose($fp);
        return $data['access_token'];
    }else{
        return $result['access_token'];
    }
}

//获取新的access_token
function getNewToken($appid,$appsecret){
    $url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid={$appid}&secret={$appsecret}";
    $access_token_Arr =  https_request($url);

    return $access_token_Arr['access_token'];
}

//向获取access_token接口发起请求
function https_request ($url){
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch,CURLOPT_RETURNTRANSFER,1);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        $out = curl_exec($ch);
        curl_close($ch);
        return  json_decode($out,true);
}

//调用函数
getToken();

//输出当前缓存文件有效期内的access_token
$jsondata = file_get_contents('access_token.json');
$access_token_data = json_decode($jsondata);
echo $access_token_data->access_token;
?>
```

## 平台

```
{"base_resp":{"ret":-2}}
```

## platform

* [开放平台](https://open.weixin.qq.com/)
* [公众平台](https://mp.weixin.qq.com/):公众号、小程序
  - [微信公众平台技术文档](https://mp.weixin.qq.com/wiki?t=resource/res_main&id=mp1472017492_58YV5)
* [测试号](https://mp.weixin.qq.com/debug/cgi-bin/sandbox?t=sandbox/login)
* [支付](https://pay.weixin.qq.com/wiki/doc/api/index.html)

## UI

* [wepayui](https://github.com/wepayui/wepayui):微信支付场景化组件 <https://wepayui.github.io>
* [wux-weapp](https://github.com/wux-weapp/wux-weapp):🐶 微信小程序自定义 UI 组件 <https://wux-weapp.github.io/wux-weapp>
* [weui](https://github.com/Tencent/weui):A UI library by WeChat official design team, includes the most useful widgets/modules in mobile web applications. <https://weui.io>
* [weui-wxss](https://github.com/Tencent/weui-wxss):A UI library by WeChat official design team, includes the most useful widgets/modules.

## 工具

* [wechat_spider](https://github.com/15921483570/wechat_spider):微信公众号爬虫 (只需设置代理, 一键可以爬取所有历史文章)
* [electronic-wechat](https://github.com/geeeeeeeeek/electronic-wechat):A better WeChat on macOS and Linux. Built with Electron by Zhongyi Tong.
* [wechat-proxy](https://github.com/aiportal/wechat-proxy):微信代理服务
* [WeChatPlugin-MacOS](https://github.com/TKkk-iOSer/WeChatPlugin-MacOS):一款功能强大的 macOS 版微信小助手 v1.7.1 / A powerful assistant for wechat macOS
* [WeChatPlugin-iOS](https://github.com/TKkk-iOSer/WeChatPlugin-iOS):iOS 版微信小助手(防撤回、修改微信运动、游戏作弊、群管理、好友请求管理)
* [MMKV](https://github.com/Tencent/MMKV):An efficient, small mobile key-value storage framework developed by WeChat. Works on iOS and Android.
* [wechat](https://github.com/chanxuehong/wechat):weixin/wechat/微信公众平台/微信企业号/微信商户平台/微信支付 go/golang sdk <https://gopkg.in/chanxuehong/wechat.v2>
* [wechatpy](https://github.com/jxtech/wechatpy):WeChat SDK for Python <http://docs.wechatpy.org>
* [ItChat](https://github.com/littlecodersh/ItChat):A complete and graceful API for Wechat. 微信个人号接口、微信机器人及命令行微信，三十行即可自定义个人号机器人。 <http://itchat.readthedocs.io>
* [mars](https://github.com/Tencent/mars):Mars is a cross-platform network component developed by WeChat.
* [wechat](https://github.com/overtrue/wechat): It is probably the best SDK in the world for developing WeChat App. <http://easywechat.org>
* [wechat-php-sdk](https://github.com/dodgepudding/wechat-php-sdk)
* [wechat](https://github.com/Eric-Guo/wechat):API, command and message handling for WeChat in Rails
* [WeChat](https://github.com/thenbsp/wechat):微信公众平台第三方 SDK 开发包，优雅、健壮，可扩展，遵循 PSR 开发规范。
* [WeixinBot](https://github.com/Urinx/WeixinBot):网页版微信API，包含终端版微信及微信机器人
* [itchatmp](https://github.com/littlecodersh/itchatmp):A complete and graceful API for wechat mp. 完备优雅的微信公众号接口，原生支持同步、协程使用。 <http://itchatmp.readthedocs.io>
* [WePush](https://gitee.com/zhoubochina/WePush):专注批量推送的小而美的工具，目前支持的类型：模板消息-公众号、模板消息-小程序、微信客服消息、阿里云短信、阿里大于模板短信 、腾讯云短信、云片网短信。<https://gitee.com/zhoubochina/WePush>
* [wechaty](https://github.com/Chatie/wechaty):WeChat Bot SDK for Personal Account, Powered by TypeScript, Docker, and 💖 <https://blog.chatie.io>
* 机器人
  - [wxpy](https://github.com/youfou/wxpy):微信机器人 / 可能是最优雅的微信个人号 API ✨✨ <http://wxpy.readthedocs.io>
  - [vbot](https://github.com/hanson/vbot):💬The best wechat robot base on web api! <http://create.hanc.cc/vbot/>
  - [WeRoBot](https://github.com/offu/WeRoBot):WeRoBot 是一个微信公众号开发框架 <https://werobot.readthedocs.io/zh_CN/latest/>
* [wechat-format](https://github.com/lyricat/wechat-format):微信公众号排版编辑器，转换 Markdown 到微信特制的 HTML <https://lab.lyric.im/wxformat>
* [weweChat](https://github.com/trazyn/weweChat):💬 Unofficial WeChat client built with React, MobX and Electron.
* [md](https://github.com/doocs/md):✍ 一款高度简洁的微信 Markdown 编辑器：支持 Markdown 所有基础语法、色盘取色、一键复制并粘贴到公众号后台、多图上传、一键下载文档、自定义 CSS 样式、一键重置等特性 <https://doocs.github.io/md>
* [Wetool](https://www.wxb.com/wetool)

## 参考

* [官方文档](https://open.weixin.qq.com/cgi-bin/showdocument?action=dir_list)
* [awesome-wechat-weapp](https://github.com/justjavac/awesome-wechat-weapp)
