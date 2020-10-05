# 支付

## 付款码付款

* 支付金额有输入和确认两步，需要双方交互
* 客户扫描商家收款码
  - 输入金额（确认）
  - 支付
* 商家扫描客户付款码：支持离线
  - 商家端获取 付款码（「其实就是一串数字」），然后后台调用支付宝支付接口完成扣款
    + 客户端在线:可以通过服务端向客户端发送付款码
    + 客户端没网:通过客户端通过一定算法生成付款码，服务端收到经过相关校验，确认是哪个用户，确认码有效性，并且完成扣款
  - 商家输入金额（确认）
  - 付款码是否支持本地更新
  - 仅仅传递一个付款码(包含相应的用户信息)，就可以向相应的用户扣款
  - 劣势
    + 算法调整不灵活，如果相关算法较大的调整，可能需要升级客户端,并且这个期间服务端还需要兼容新老算法产生的付款码
    + 安全性问题，正常的情况相关密钥无法被普通用户获取，但是架不住有有心之人。他们可能通过获取手机用户 Root 权限或者越狱手机，利用恶意程序获取密钥，然后随意生成付款码
    + 数据碰撞问题

## 平台

* 支付宝
* 微信
* 运通
* 万事达
* VISA
* [Stripe](https://stripe.com/docs)

## 方案

* [invoiceninja](https://github.com/invoiceninja/invoiceninja):Invoices, Expenses and Tasks built with Laravel and Flutter https://invoiceninja.com/
* [ Exrick / xpay ](https://github.com/Exrick/xpay):XPay个人免签收款支付系统 完全免费 资金直接到达本人账号 支持 支付宝 微信 QQ 云闪付 无需备案 无需签约 无需挂机监控APP 无需插件 无需第三方支付SDK 无需营业执照身份证 只需收款码 搞定支付流程 现已支持移动端支付 http://xpay.exrick.cn/

## 参考

* [离线支付](https://mp.weixin.qq.com/s/tUbCNJeRebxP0ZwiSGknNg)
