# [JSON Web Token JWT](https://jwt.io/)

一个非常轻巧的规范。允许使用 JWT 在用户和服务器之间传递安全可靠的信息

* 默认是不加密，但也是可以加密的。生成原始 Token 以后，可以用密钥再加密一次
* 不加密的情况下，不能将秘密数据写入 JWT
* 不仅可以用于认证，也可以用于交换信息。有效使用 JWT，可以降低服务器查询数据库的次数
* 最大缺点，由于服务器不保存 session 状态，因此无法在使用过程中废止某个 token，或者更改 token 的权限。也就是说，一旦 JWT 签发了，在到期之前就会始终有效，除非服务器部署额外的逻辑。
* 本身包含了认证信息，一旦泄露，任何人都可以获得该令牌的所有权限。为了减少盗用，JWT 的有效期应该设置得比较短。对于一些比较重要的权限，使用时应该再次对用户进行认证
* 为了减少盗用，JWT 不应该使用 HTTP 协议明码传输，要使用 HTTPS 协议传输
* 目前最流行的跨域认证解决方案
* JWT 是为了在网络应用环境间传递声明而执行的一种基于 JSON 的开放标准（RFC 7519）。JWT 的声明一般被用来在身份提供者和服务提供者间传递被认证的用户身份信息，以便于从资源服务器获取资源。比如用在用户登录上。
* 可以使用 HMAC 算法或者是 RSA 的公/私秘钥对 JWT 进行签名。因为数字签名的存在，这些传递的信息是可信的
* 认证流程：
  - 用户输入用户名 / 密码登录，服务端认证成功后，会返回给客户端一个 JWT
  - 客户端将 token 保存到本地（通常使用 localstorage，也可以使用 cookie）
  - 当用户希望访问一个受保护的路由或者资源的时候，需要请求头的 Authorization 字段中使用 Bearer 模式添加 JWT
  - 服务端的保护路由将会检查请求头 Authorization 中的 JWT 信息，如果合法，则允许用户的行为
  - 因为 JWT 是自包含的（内部包含了一些会话信息），因此减少了需要查询数据库的需要
  - 因为 JWT 并不使用 Cookie 的，所以你可以使用任何域名提供你的 API 服务而不需要担心跨域资源共享问题（CORS）
  - 因为用户的状态不再存储在服务端的内存中，所以这是一种无状态的认证机制
* 使用方式
  + 放在 Cookie 里面自动发送，但是这样不能跨域，所以更好的做法是放在 HTTP 请求头信息的 Authorization 字段里，使用 Bearer 模式添加 JWT
  + 跨域的时候，可以把 JWT 放在 POST 请求的数据体里
  + 通过 URL 传输
* 一种自包含令牌，令牌签发后无需从服务器存储中检查是否合法，通过解析令牌就能获取令牌的过期、有效等信息
  + 令牌为一段点分3段式结构
    * header json 的 base64 编码为令牌第一部分
    * payload json 的 base64 编码为令牌第二部分
    * 拼装第一、第二部分编码后的 json 以及 secret 进行签名的令牌的第三部分
  + 只需要签名 secret key 就能校验 JWT 令牌，如果在消息体中加入用户 ID、过期信息就可以实现验证令牌是否有效、过期了，无需从数据库/缓存中读取信息
  + 第一、二部分只是 base64 编码，肉眼不可读，不应当存放敏感信息
  + 自包含特性，导致无法被撤回

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

## Token vs JWT

* 相同：
  + 都是访问资源的令牌
  + 都可以记录用户的信息
  + 都是使服务端无状态化
  + 都是只有验证成功后，客户端才能访问服务端上受保护的资源
* 区别：
  + Token：服务端验证客户端发送过来的 Token 时，还需要查询数据库获取用户信息，然后验证 Token 是否有效
  + JWT：将 Token 和 Payload 加密后存储于客户端，服务端只需要使用密钥解密进行校验（校验也是 JWT 自己实现的）即可，不需要查询或者减少查询数据库，因为 JWT 自包含了用户信息和加密的数据

## 参考

* [jwt-auth](https://github.com/tymondesigns/jwt-auth):🔐 JSON Web Token Authentication for Laravel & Lumen <http://jwt-auth.com>
* [jwt](https://github.com/lcobucci/jwt):A simple library to work with JSON Web Token and JSON Web Signature
* [learn-json-web-tokens](https://github.com/dwyl/learn-json-web-tokens):🔐 Learn how to use JSON Web Token (JWT) to secure your next Web App! (Tutorial/Example with Tests!!)
* [JSON Web Token 入门教程](http://www.ruanyifeng.com/blog/2018/07/json_web_token-tutorial.html)
