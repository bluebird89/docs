# JWT(JSON Web Token)

一个非常轻巧的规范。这个规范允许我们使用 JWT 在用户和服务器之间传递安全可靠的信息。

## 场景

* 授权、鉴权
* 一个 A 用户想要邀请某用户进入自己的群组 [原来](https://host/group/{group_id}/invite/{invite_user}) =》 [改后](https://host/group/invite/{token})

## 原理

* 实际上就是一个字符串，它由三部分组成,将包含的信息进行base64编码(不建议用 jwt 传输敏感信息，例如密码)，为各部分内容，最后拼接为完整的token
    * 头部 (Header)：用于描述关于该 JWT 的最基本的信息，例如其类型以及签名所用的算法等
    * 载荷(Payload）:将上面的邀请入群的操作描述成一个 JSON 对象
        - sub: 该 JWT 所面向的用户
        - iss: 该 JWT 的签发者
        - iat(issued at): 在什么时候签发的 token
        - exp(expires): token 什么时候过期
        - nbf(not before)：token 在此时间之前不能被接收处理
        - jti：JWT ID为web token 提供唯一标识
    * 签名(Signature)
        - 将头部和载荷使用 . 进行拼接(头部在前), 得到用于签名的字符串
        - 使用签名方法对用于签名的字符串进行签名，得到签名(Signature)
        - 此时的签名(Signature)并没有签发者特有的身份信息，所有数据都是明文的，所以这样签名是不安全的，应该加上 secret 进行签名。
        - 需要准备一个可以确认自己身份的字符串（secret），只需要将上面准备的 用于签名的字符串简单的与 secret 进行拼接，这时候得到的签名是受 secret 值影响的

```
# header
{
  "typ": "JWT",
  "alg": "md5"
}

# Payload
{
    "sub": "1",
    "iss": "http://host/group/invite",
    "iat": 1451888119,
    "exp": 1454516119,
    "nbf": 1451888119,
    "jti": "37c107e4609ddbcc9c096ea5ee76c667",
    "group_id": 1,
    "invite_user": "A"
}
```

## 参考

* [tymondesigns/jwt-auth](https://github.com/tymondesigns/jwt-auth):🔐 JSON Web Token Authentication for Laravel & Lumen http://jwt-auth.com
