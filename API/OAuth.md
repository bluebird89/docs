# OAuth

* OAuth 引入了一个授权层，用来分离两种不同的角色：客户端和资源所有者。资源所有者同意以后，资源服务器可以向客户端颁发令牌。客户端通过令牌，去请求数据。用来代替密码，供第三方应用使用。只要知道了令牌，就能进入系统。系统一般不会再次确认身份，所以令牌必须保密，泄漏令牌与泄漏密码的后果是一样的
* "客户端"不能直接登录"服务提供商"，只能登录授权层，以此将用户与客户端区分开来。"客户端"登录授权层所用的令牌（token），与用户的密码不同。用户可以在登录的时候，指定授权层令牌的权限范围和有效期

## 对象

* 用户(Resource Owner)
* HTTP service：HTTP服务提供商（微信）
* 客户端(Third-party application)
    - 第三方应用应用申请令牌之前，都必须先到系统备案，说明自己的身份，然后会拿到两个身份识别码：客户端 ID（client ID）和客户端密钥（client secret）
* 资源服务器（Resource server）
* 认证服务器（Authorization server）

## 流程

* 用户打开客户端以后，客户端要求用户给予授权
* 用户同意给予客户端授权
* 客户端使用上一步获得的授权，向认证服务器申请令牌
* 认证服务器对客户端进行认证以后，确认无误，同意发放令牌
* 客户端使用令牌，向资源服务器申请获取资源
* 资源服务器确认令牌无误，同意向客户端开放资源

## 授权方式

* 授权码模式（authorization code）：第三方应用先申请一个授权码，然后再用该码获取令牌.适用于那些有后端的 Web 应用。授权码通过前端传送，令牌则是储存在后端，而且所有与资源服务器的通信都在后端完成
    - 授权码的引入：同一个应用获取多个code,并生成器token的key。HTTP重定向没有body，只能通过url传参数，而url中的参数是不安全的，因为所有经过的路由器或服务器都能读取到url的信息，所谓的中间人攻击。
    - 用户访问客户端，客户端将用户导向认证服务器。客户端提供申请认证的URI，包含以下参数
        + response_type：表示授权类型，必选项，此处的值固定为"code"
        + client_id：表示客户端的ID，必选项
        + redirect_uri：表示重定向URI，选填项
            * 微信后台对 redirect_uri 域名设置的限制，难道开发调试就只能用外网的机器了吗？其实这事儿也好解决，如果你的开发环境就是本地 127.0.0.1，那么直接将 redirect_uri 的域名通过 hosts 文件直接指向内网就行
        + scope：表示申请的权限范围，可选项
        + state：表示客户端的当前状态，可以指定任意值，认证服务器会原封不动地返回这个值，state项不用动态数据的话会存在CSRF漏洞
    - 用户选择是否给予客户端授权
    - 假设用户给予授权，认证服务器将用户导向客户端事先指定的"重定向URI"（redirection URI），同时附上一个授权码
        + code返回
            * code：表示授权码，必选项。该码的有效期应该很短，通常设为10分钟，客户端只能使用该码一次，否则会被授权服务器拒绝。该码与客户端ID和重定向URI，是一一对应关系。
            * state：如果客户端的请求中包含这个参数，认证服务器的回应也必须一模一样包含这个参数。
        + 去请求设定的token申请地址
        + client_id参数和client_secret参数用来让 HTTP service确认客户端（client_secret参数是保密的，因此只能在后端发请求）
        + grant_type参数的值是AUTHORIZATION_CODE，表示采用的授权方式是授权码
        + code参数是上一步拿到的授权码
        + redirect_uri参数是令牌颁发后的回调网址，如果不验证 redirect_uri，只要有攻击者稍稍修改上面的地址，把 redirect_uri 替换），受害人访问此链接，确认登录，生成 code 之后再通过回调的方式，便把 code 传给了攻击者的网站
    - 客户端收到授权码，附上早先的"重定向URI"，向认证服务器申请令牌。这一步是在客户端的后台的服务器上完成的，对用户不可见
        + 含有secret
    - 认证服务器核对了授权码和重定向URI，确认无误后，向客户端发送访问令牌（access token）和更新令牌（refresh token），取一唯一的随机信息再做BASE64编码即可,它本身不包含任何有效信息的;服务端把它和用户受权关联以校验其受权的有效性.
* 简化模式（implicit）：不通过第三方应用程序的服务器，直接在浏览器中向认证服务器申请令牌，跳过了"授权码"这个步骤，在浏览器中完成，令牌对访问者是可见的，且客户端不需要认证，用于一些安全要求不高的场景，并且令牌的有效期必须非常短，通常就是会话期间（session）有效，浏览器关掉，令牌就失效了
    - 客户端将用户导向认证服务器。
    - 用户决定是否给于客户端授权。
    - 假设用户给予授权，认证服务器将用户导向客户端指定的"重定向URI"，并在URI的Hash部分包含了访问令牌。
        + 令牌的位置是 URL 锚点（fragment），而不是查询字符串（querystring），这是因为 OAuth 2.0 允许跳转网址是 HTTP 协议，因此存在"中间人攻击"的风险，而浏览器跳转时，锚点不会发到服务器，就减少了泄漏令牌的风险。
    - 浏览器向资源服务器发出请求，其中不包括上一步收到的Hash值。
    - 资源服务器返回一个网页，其中包含的代码可以获取Hash值中的令牌。
    - 浏览器执行上一步获得的脚本，提取出令牌。
    - 浏览器将令牌发给客户端。
* 密码模式（resource owner password credentials）：用户把用户名和密码，直接告诉该应用。用户对客户端高度信任的情况下。该应用就使用密码，申请令牌
    - 认证服务器验证身份通过后，直接给出令牌。注意，这时不需要跳转，而是把令牌放在 JSON 数据里面，作为 HTTP 回应，A 因此拿到令牌。
* 客户端模式（client credentials）：适用于没有前端的命令行应用，即在命令行下请求令牌
    - 认证服务器验证通过以后，直接返回令牌

```sh
// authorization code
// 客户端申请code链接
https://b.com/oauth/authorize?
  response_type=code&
  client_id=CLIENT_ID&
  redirect_uri=https://a.com/callback&
  scope=read
GET /authorize?response_type=code&client_id=s6BhdRkqt3&state=xyz
        &redirect_uri=https%3A%2F%2Fclient%2Eexample%2Ecom%2Fcb HTTP/1.1
Host: server.example.com

// 认证服务器返回的链接
https://a.com/callback?code=AUTHORIZATION_CODE
HTTP/1.1 302 Found
Location: https://client.example.com/cb?code=SplxlOBeZQQYbYS6WxSbIA
          &state=xyz

// 请求token地址
https://b.com/oauth/token?
 client_id=CLIENT_ID&
 client_secret=CLIENT_SECRET&
 grant_type=authorization_code&
 code=AUTHORIZATION_CODE&
 redirect_uri=CALLBACK_URL
POST /token HTTP/1.1
Host: server.example.com
Authorization: Basic czZCaGRSa3F0MzpnWDFmQmF0M2JW
Content-Type: application/x-www-form-urlencoded

grant_type=authorization_code&code=SplxlOBeZQQYbYS6WxSbIA
&redirect_uri=https%3A%2F%2Fclient%2Eexample%2Ecom%2Fcb

HTTP/1.1 200 OK
    Content-Type: application/json;charset=UTF-8
    Cache-Control: no-store
    Pragma: no-cache
{
  "access_token":"ACCESS_TOKEN",
  "token_type":"bearer",
  "expires_in":2592000,
  "refresh_token":"REFRESH_TOKEN",
  "scope":"read",
  "uid":100101,
  "info":{...}
}

// implicit
https://b.com/oauth/authorize?
  response_type=token&
  client_id=CLIENT_ID&
  redirect_uri=CALLBACK_URL&
  scope=read

GET /authorize?response_type=token&client_id=s6BhdRkqt3&state=xyz
    &redirect_uri=https%3A%2F%2Fclient%2Eexample%2Ecom%2Fcb HTTP/1.1
Host: server.example.com

https://a.com/callback#token=ACCESS_TOKEN
HTTP/1.1 302 Found
Location: http://example.com/cb#access_token=2YotnFZFEjr1zCsicMWpAA
       &state=xyz&token_type=example&expires_in=3600

// Resource Owner Password Credentials Grant
https://oauth.b.com/token?
  grant_type=password&
  username=USERNAME&
  password=PASSWORD&
  client_id=CLIENT_ID
POST /token HTTP/1.1
Host: server.example.com
Authorization: Basic czZCaGRSa3F0MzpnWDFmQmF0M2JW
Content-Type: application/x-www-form-urlencoded

grant_type=password&username=johndoe&password=A3ddj3w

HTTP/1.1 200 OK
Content-Type: application/json;charset=UTF-8
Cache-Control: no-store
Pragma: no-cache

{
"access_token":"2YotnFZFEjr1zCsicMWpAA",
"token_type":"example",
"expires_in":3600,
"refresh_token":"tGzv3JOkF0XG5Qx2TlKWIA",
"example_parameter":"example_value"
}


// client credentials
https://oauth.b.com/token?
  grant_type=client_credentials&
  client_id=CLIENT_ID&
  client_secret=CLIENT_SECRET
POST /token HTTP/1.1
Host: server.example.com
Authorization: Basic czZCaGRSa3F0MzpnWDFmQmF0M2JW
Content-Type: application/x-www-form-urlencoded

grant_type=client_credentials

HTTP/1.1 200 OK
Content-Type: application/json;charset=UTF-8
Cache-Control: no-store
Pragma: no-cache

{
"access_token":"2YotnFZFEjr1zCsicMWpAA",
"token_type":"example",
"expires_in":3600,
"example_parameter":"example_value"
}
```

## VS 密码

* 令牌是短期的，到期会自动失效，用户自己无法修改。密码一般长期有效，用户不修改，就不会发生变化。
* 令牌可以被数据所有者撤销，会立即失效。以上例而言，屋主可以随时取消快递员的令牌。密码一般不允许被他人撤销。
* 令牌有权限范围（scope），比如只能进小区的二号门。对于网络服务来说，只读令牌就比读写令牌更安全。密码一般是完整权限。

## 令牌使用

* 客户端拿到令牌以后，就可以向资源方的 API 请求数据了。 每个发到 API 的请求，都必须带有令牌。具体做法是在请求的头信息，加上一个Authorization字段，令牌就放在这个字段里面,或者 放在cookie里
* 更新令牌
    - 颁发令牌的时候，一次性颁发两个令牌，一个用于获取数据，另一个用于获取新的令牌（refresh token 字段）。令牌到期前，用户使用 refresh token 发一个请求，去更新令牌

```
curl -H "Authorization: Bearer ACCESS_TOKEN" \
"https://api.b.com"

// 更新令牌
https://b.com/oauth/token?
  grant_type=refresh_token&
  client_id=CLIENT_ID&
  client_secret=CLIENT_SECRET&
  refresh_token=REFRESH_TOKEN
POST /token HTTP/1.1
Host: server.example.com
Authorization: Basic czZCaGRSa3F0MzpnWDFmQmF0M2JW
Content-Type: application/x-www-form-urlencoded

grant_type=refresh_token&refresh_token=tGzv3JOkF0XG5Qx2TlKWIA
```

## 问题

* 如何判断令牌失效:token查不到就判断失效

## Authorization vs Authentication

## 实例

* [7sDream/zhihu-oauth](https://github.com/7sDream/zhihu-oauth):尝试解析出知乎官方未开放的 OAuth2 接口，并提供优雅的使用方式，作为 zhihu-py3 项目的替代者，目前还在实验阶段

## 参考

* [The OAuth 2.0 Authorization Framework](https://tools.ietf.org/html/rfc6749)

## 工具

* [thephpleague/oauth2-server](https://github.com/thephpleague/oauth2-server):A spec compliant, secure by default PHP OAuth 2.0 Server https://oauth2.thephpleague.com
