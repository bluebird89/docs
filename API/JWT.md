# [JWT JSON Web Token](https://jwt.io/)

一个非常轻巧的规范。允许使用 JWT 在用户和服务器之间传递安全可靠的信息

* JWT 默认是不加密，但也是可以加密的。生成原始 Token 以后，可以用密钥再加密一次
* JWT 不加密的情况下，不能将秘密数据写入 JWT
* JWT 不仅可以用于认证，也可以用于交换信息。有效使用 JWT，可以降低服务器查询数据库的次数
* JWT 的最大缺点是，由于服务器不保存 session 状态，因此无法在使用过程中废止某个 token，或者更改 token 的权限。也就是说，一旦 JWT 签发了，在到期之前就会始终有效，除非服务器部署额外的逻辑。
* JWT 本身包含了认证信息，一旦泄露，任何人都可以获得该令牌的所有权限。为了减少盗用，JWT 的有效期应该设置得比较短。对于一些比较重要的权限，使用时应该再次对用户进行认证
* 为了减少盗用，JWT 不应该使用 HTTP 协议明码传输，要使用 HTTPS 协议传输

## 场景

* 应对session共享复杂的解决方法，数据都保存在客户端，cookie加密版
* 授权、鉴权
* 一个 A 用户想要邀请某用户进入自己的群组 [原来](https://host/group/{group_id}/invite/{invite_user}) => [改后](https://host/group/invite/{token})

## 原理

* 服务器认证以后，生成一个 JSON 对象，发回给用户，实际上就是一个字符串，它由三部分组成,将包含的信息进行base64编码(不建议用 jwt 传输敏感信息，例如密码)，为各部分内容，最后拼接为完整的token
  * 头部 (Header)：一个 JSON 对象，描述 JWT 的元数据，例如其类型以及签名所用的算法等，使用 Base64URL 算法转成字符串
    - alg属性表示签名的算法（algorithm），默认是 HMAC SHA256（写成 HS256）
    - typ属性表示这个令牌（token）的类型（type），JWT 令牌统一写为JWT
  * 载荷(Payload）:一个 JSON 对象，存放实际需要传递的数据。JWT 规定了7个官方字段，供选用，还可以定义私有字段，默认是不加密的，任何人都可以读到，所以不要把秘密信息放在这个部分。使用 Base64URL 算法转成字符串
    + iss (issuer)：签发人
    + exp (expiration time)：过期时间
    + sub (subject)：主题
    + aud (audience)：受众
    + nbf (Not Before)：生效时间
    + iat (Issued At)：签发时间
    + jti (JWT ID)：编号
  * 签名(Signature)：对前两部分的签名，防止数据篡改
    - 将头部和载荷使用 . 进行拼接(头部在前), 得到用于签名的字符串
    - 使用签名方法对用于签名的字符串进行签名，得到签名(Signature)
    - 此时的签名(Signature)并没有签发者特有的身份信息，所有数据都是明文的，所以这样签名是不安全的，应该加上 secret 进行签名。
    - 需要准备一个可以确认自己身份的字符串（secret），只需要将上面准备的 用于签名的字符串简单的与 secret 进行拼接，这时候得到的签名是受 secret 值影响的,密钥只有服务器才知道，不能泄露给用户
  * 把 Header、Payload、Signature 三个部分拼成一个字符串，每个部分之间用"点"（.）分隔，就可以返回给用户

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

# signature
HMACSHA256(
  base64UrlEncode(header) + "." +
  base64UrlEncode(payload),
  secret)
```

## Base64URL

算法跟 Base64 算法基本类似，但有一些小的不同。JWT 作为一个令牌（token），有些场合可能会放到 URL（比如 api.example.com/?token=xxx）。Base64 有三个字符+、/和=，在 URL 里面有特殊含义，所以要被替换掉：=被省略、+替换成-，/替换成_ 。

## 使用

放在 Cookie 里面自动发送，但是这样不能跨域，所以更好的做法是放在 HTTP 请求的头信息Authorization字段里面

```
Authorization: Bearer <token>
```

## 参考

* [tymondesigns/jwt-auth](https://github.com/tymondesigns/jwt-auth):🔐 JSON Web Token Authentication for Laravel & Lumen <http://jwt-auth.com>
* [lcobucci/jwt](https://github.com/lcobucci/jwt):A simple library to work with JSON Web Token and JSON Web Signature
* [dwyl/learn-json-web-tokens](https://github.com/dwyl/learn-json-web-tokens):🔐 Learn how to use JSON Web Token (JWT) to secure your next Web App! (Tutorial/Example with Tests!!)
* [JSON Web Token 入门教程](http://www.ruanyifeng.com/blog/2018/07/json_web_token-tutorial.html)
