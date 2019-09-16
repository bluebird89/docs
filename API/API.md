# API（Application Programming Interface，应用程序编程接口

一些预先定义的函数或者接口，目的是提供应用程序与开发人员基于某软件或硬件得以访问一组例程的能力，而又无须访问源码，或理解内部工作机制的细节。

* 防止API被恶意调用
* API通信中数据加密的问题

## 文档格式

* 请求地址
* 请求类型
* 参数说明
* 返回结果说明

## 状态

* 前后端分离，业界广泛采用的方式就是采用token
    - 第一次来登记的时候，服务器根据用户出具信息，在核验完毕身份证后（验证密码）后，发放token
    - 客户端保存token,后面访问接口时带上token
    - token 加有效期
        + 通过抓包等方式得知了服务器API的地址，就意味着可以任意调用API了，API会被盗用。为了避免这种被盗用，引入签名机制
    - 验证签名：采取多少数据项、用md5或者sha1
        + 固定字符串，或有规律字符串。如果客户端被反编译了，签名机制就会被人得知。所以，在签名机制中引入另外一个新的重要元素：时间戳。
        + 时间戳
            * 判定API访问的时效性
            * 参与签名运算
        * 考虑
            * 可变性：每次的签名必须是不一样的
            * 时效性：每次请求的时效性，过期作废
            * 唯一性：每次的签名是唯一的
            * 完整性：能够对传入数据进行验证，防止篡改
        + 方法
            * 发送方和接收方约定一个加密的盐值，进行生成签名。 `/api/login?username=xxx&password=xxx&sign=xxx`
            * 单向散列加密：把任意长的输入串变化成固定长的输出串，并且由输出串难以得到输入串
                - 算法：MD5 SHA MAC CRC
                - 优点
                    + 方便存储：加密后都是固定大小（32位）的字符串，能够分配固定大小的空间存储。
                    + 损耗低：加密/加密对于性能的损耗微乎其微。
                    + 文件加密：只需要32位字符串就能对一个巨大的文件验证其完整性。
                    + 不可逆：大多数的情况下不可逆，具有良好的安全性
                - 缺点：存在暴力破解的可能性，最好通过加盐值的方式提高安全性。
                - 场景：用于敏感数据，比如用户密码，请求参数，文件加密等。
                - 推荐：password_hash（）
            * 对称加密:同一个密钥可以同时用作数据的加密和解密
                - 算法：DES（AES 是 DES 的升级版，密钥长度更长，选择更多，也更灵活，安全性更高，速度更快） AES
                - 优点：算法公开、计算量小、加密速度快、加密效率高。
                - 缺点：发送方和接收方必须商定好密钥，然后使双方都能保存好密钥，密钥管理成为双方的负担。
                - 应用场景 相对大一点的数据量或关键数据的加密。
                - mcrypt_encrypt 和 mcrypt_decrypt在 PHP7.2 版本中已经被弃用了，在新版本中使用 openssl_encrypt 和 openssl_decrypt 两个方法
            * 非对称加密:需要两个密钥来进行加密和解密，这两个秘钥分别是公钥（public key）和私钥（private key）
                - 算法
                    + RSA2  SHA256WithRSA   强制要求RSA密钥的长度至少为2048
                    + RSA SHA1WithRSA 对RSA密钥的长度不限制，推荐使用2048位以上
                - 优点 与对称加密相比，安全性更好，加解密需要不同的密钥，公钥和私钥都可进行相互的加解密。
                - 缺点 加密和解密花费时间长、速度慢，只适合对少量数据进行加密。
                - 应用场景:适合于对安全性要求很高的场景，适合加密少量数据，比如支付数据、登录数据等。
        + 密钥：
            * 将密钥设置到环境变量中，每次从环境变量中加载
            * 将密钥存放到配置中心，统一进行管理
            * 设置密钥有效期，比如一个月进行重置一次
    - 只要客户端被反编译了，加密方式和签名机制都会暴露出来，所以安全是需要双方配合的
    - token或者aes加解密密码:建议走POST方式，也可以将这些信息放到http header中，也可以放到http body中

```
// 第一步请求
http.post( 'http://host.com/api/account/login', { "account":"zhengsan", "password":"123456" } ).signature( "api/account/login"+"timestamp" )
http.post( 'http://host.com/api/order/list', { "token" : "abcdefg" } ).signature( 'api/order/list' )

// 服务端验证密码并返回token
client_timestamp = get_post( 'timestamp' )
if( server_timestamp - cilent_timestamp > 30 ){
  return '过期API访问'
}
server_signature = md5( 'api/account/login' )
client_signature = http.get_post( 'signature' )
if ( server_signature != client_signature ) {
  return 'signature error';
}

password = get_post( 'password' )
account = get_post( 'account' )
server_password = get_password_by_account( 'account' )
if( password == server_password ){
  // 生成一个AES加密密码
  enc_password = "1a2b3c4d5f6g7h8i9j0k"
  // 生成原始的token
  token = "0k9j8h7i6g5f4c3b2c1az9y8x7"
  // 服务端记录token与uid对应关系
  set( token, uid )
  // 最后一步很重要，要将aes加密密码 和 token返回给客户端
  return enc_password,token
}

// 第三步，客户端收到登录后的数据：加解密密码 和 token，然后保存起来
token = get( 'token' )
enc_password = get('enc_password')
// 将这两项保存起来
save( token, enc_password )
// 先对银行卡号进行加密，然后再进行提交
bank_card = '666777888999'
enc_bank_card = encrypt( enc_password, bank_card )
http.post( "http://host.com/api/bankcard/create", { enc_bank_card, enc_password, token } ).signature( 'api/bankcard/create'+timestamp )

// 第四步，服务端收到数据后，验证API签名和timestamp时效性，最后解密数据，入库
// 验证signature和timestamp时效性伪代码略过...
// 获取客户端传来的token enc_bankcard enc_password
token = get_post( 'token' )
enc_bankcard = get( 'enc_bankcard' )
enc_password = get( 'enc_password' )
bankcard = decrypt( enc_password, enc_bankcard )
// 根据对应关系，用token找到uid
uid = get_uid_by_token( 'token' )
// 将uid和bankcard入库
save( uid, bankcard )

openssl genrsa - out private_key . pem 2048
openssl rsa - in private_key . pem - pubout - out public_key . pem
```

## 加密

* https:面对charles等抓包工具时，其实并没有什么卵用，只要配置一下根证书瞬间可以看到一切明文

```
// 加密密码
password = '123456'
// 需要加密的内容
message = 'Hello World!'
// 利用加密密码对内容进行加密
enc_message = encrypt( password, message )
// 解密
dec_message = decrypt ( password, enc_message )
print dec_message   // Hello World!
```

## 认证、授权和凭证

* API 是无状态的，不推荐使用 Cookie
    - 使用 cookie，例如 web 项目中 ajax 的方式
    - 使用 session ID 或 hash 作为 token，但将 token 放入 header 中传递
    - 将生成的 token （可能是JWT）放入 cookie 传递，利用 HTTPonly 和 Secure 标签保护 token
* 认证是 authentication，指的是当前用户的身份，当用户登陆过后系统便能追踪到他的身份做出符合相应业务逻辑的操作
    - 即使用户没有登录，大多数系统也会追踪他的身份，只是当做来宾或者匿名用户来处理
    - 认证技术解决的是 “我是谁？”的问题
    - HTTP Basic Authentication
        + 客户端
            * 将用户名和密码使用冒号连接，例如 username:abc123456
            * 为了防止用户名或者密码中存在超出 ASCII 码范围的字符，推荐使用UTF-8编码
            * 将上面的字符串使用 Base 64 编码，例如 dXNlcm5hbWU6YWJjMTIzNDU2
            * 在 HTTP 请求头中加入 “Basic + 编码后的字符串”，即：Authorization: Basic QWxhZGRpbjpPcGVuU2VzYW1l
            * 设置名称为 Authorization 的 header 头部
        + Base64 只能称为编码，而不是加密 (实际上无需配置密匙的客户端并没有任何可靠地加密方式，我们都依赖 TSL 协议)。这种方式的致命弱点是编码后的密码如果明文传输则容易在网络传输中泄露，在密码不会过期的情况下，密码一旦泄露，只能通过修改密码的方式
    - HMAC（AK/SK）认证：对接一些 PASS 平台和支付平台时，会要求我们预先生成一个 access key（AK） 和 secure key（SK），然后通过签名的方式完成认证请求，这种方式可以避免传输 secure key，且大多数情况下签名只允许使用一次，避免了重放攻击。
        + 利用散列的消息认证码 (Hash-based MessageAuthentication Code) 来实现的，因此有很多地方叫 HMAC 认证，实际上不是非常准确
        + HMAC 只是利用带有 key 值的哈希算法生成消息摘要，在设计 API 时有具体不同的实现
            * 客户端需要在认证服务器中预先设置 access key（AK 或叫 app ID） 和 secure key（SK）
            * 在调用 API 时，客户端需要对参数和 access key 进行自然排序后并使用 secure key 进行签名生成一个额外的参数 digest
            * 服务器根据预先设置的 secure key 进行同样的摘要计算，并要求结果完全一致
            * **注意 secure key 不能在网络中传输，以及在不受信任的位置存放（浏览器等）**
            * 每一次请求的签名变得独一无二，从而实现重放攻击，需要在签名时放入一些干扰信息
                - 质疑/应答算法（OCRA: OATH Challenge-Response Algorithm）
                    + 客户端先请求一次服务器，获得一个 401 未认证的返回，并得到一个随机字符串（nonce）
                    + 将 nonce 附加到按照上面说到的方法进行 HMAC 签名，服务器使用预先分配的 nonce 同样进行签名校验，这个 nonce 在服务器只会被使用一次，因此可以提供唯一的摘要。
                - 基于时间的一次性密码算法（TOTP：Time-based One-time Password Algorithm）：通过同步时间的方式协商到一致，在一定的时间窗口内有效（1分钟左右）
                    + 在两步验证中被大量使用：客户端服务器共享密钥然后根据时间窗口能通过 HMAC 算法计算出一个相同的验证码。TOTP HMAC-based One-time Password algorithm
* 授权是 authorization，指的是什么样的身份被允许访问某些资源，在获取到用户身份后继续检查用户的权限
    - 单一的系统授权往往是伴随认证来完成的，但是在开放 API 的多系统结构下，授权可以由不同的系统来完成，例如 OAuth
    - 授权技术是解决“我能做什么？”的问题
    - OAuth（开放授权）是一个开放标准，允许用户授权第三方网站访问他们存储在另外的服务提供者上的信息，而不需要将用户名和密码提供给第三方网站或分享他们数据的所有内容。
        + OAuth 是一个授权标准，而不是认证标准。提供资源的服务器不需要知道确切的用户身份（session），只需要验证授权服务器授予的权限（token）即可。
        + 基本思路就是通过授权服务器获取 access token 和 refresh token（refresh token 用于重新刷新access token），然后通过 access token 从资源服务器获取数据
        + 验证 access token
            * 在完成授权流程后，资源服务器可以使用 OAuth 服务器提供的 Introspection 接口来验证access token，OAuth服务器会返回 access token 的状态以及过期时间。在OAuth标准中验证 token 的术语是 Introspection。同时也需要注意 access token 是用户和资源服务器之间的凭证，不是资源服务器和授权服务器之间的凭证。资源服务器和授权服务器之间应该使用额外的认证（例如 Basic 认证）。
            * 使用 JWT 验证。授权服务器使用私钥签发 JWT 形式的 access token，资源服务器需要使用预先配置的公钥校验 JWT token，并得到 token 状态和一些被包含在 access token 中信息。因此在 JWT 的方案下，资源服务器和授权服务器不再需要通信，在一些场景下带来巨大的优势。同时 JWT 也有一些弱点，我会在JWT 的部分解释。
        + access token 被设计用来客户端和资源服务器之间交互,过期时间（TTL）应该尽量短，从而避免用户的 access token 被嗅探攻击
        + refresh token 是被设计用来客户端和授权服务器之间交互。帮助用户维护一个较长时间的状态，避免频繁重新授权.客户端拿着 refresh token 去获取 access token 时同时需要预先配置的 secure key，客户端和授权服务器之前始终存在安全的认证。
        + OAuth 负责解决分布式系统之间的授权问题，即使有时候客户端和资源服务器或者认证服务器存在同一台机器上。OAuth 没有解决认证的问题，但提供了良好的设计利于和现有的认证系统对接。
        + Open ID 解决的问题是分布式系统之间身份认证问题，使用Open ID token 能在多个系统之间验证用户，以及返回用户信息，可以独立使用，与 OAuth 没有关联。
        + OpenID Connect 解决的是在 OAuth 这套体系下的用户认证问题，实现的基本原理是将用户的认证信息（ID token）当做资源处理。在 OAuth 框架下完成授权后，再通过 access token 获取用户的身份。
        + 如果系统中需要一套独立的认证系统，并不需要多系统之间的授权可以直接采用 Open ID。如果使用了 OAuth 作为授权标准，可以再通过 OpenID Connect 来完成用户的认证。
    - JWT （JSON Web Token）:一种自包含令牌，令牌签发后无需从服务器存储中检查是否合法，通过解析令牌就能获取令牌的过期、有效等信息
        + 令牌为一段点分3段式结构
            * header json 的 base64 编码为令牌第一部分
            * payload json 的 base64 编码为令牌第二部分
            * 拼装第一、第二部分编码后的 json 以及 secret 进行签名的令牌的第三部分
        + 只需要签名的 secret key 就能校验 JWT 令牌，如果在消息体中加入用户 ID、过期信息就可以实现验证令牌是否有效、过期了，无需从数据库/缓存中读取信息
        + 第一、二部分只是 base64 编码，肉眼不可读，不应当存放敏感信息
        + 自包含特性，导致了无法被撤回
* 实现认证和授权的基础是需要一种媒介（credentials）来标记访问者的身份或权利，在现实生活中每个人都需要一张身份证才能访问自己的银行账户、结婚和办理养老保险等，这就是认证的凭证
* 策略
    - 基于访问控制列表（ACL）
    - 基于用户角色的访问控制（RBAC）

## 文档和前后端协作

* 基于注释的 API 文档：通过代码中注释生成 API 文档的轻量级方案
    - 好处是简单易用，基本与编程语言无关
    - 因为基于注释，非常适合动态语言的文档输出，例如 Nodejs、PHP、Python。由于NPM包容易安装和使用，这里推荐 nodejs 平台下的 apidocjs
* 基于反射的 API 文档：使用 swagger 这类通过反射来解析代码，只需要定义好 Model，可以实现自动输出 API 文档。这种方案适合强类型语言例如 Java、.Net，尤其是生成一份稳定、能在团队外使用的 API 文档
    - swagger 实际上是一整套关于 API 文档、代码生成、测试、文档共享的工具包，包括 :
        + Swagger Editor 使用 swagger editor 编写文档定义 yml 文件，并生成 swagger 的 json 文件,提供线上版本，也可以本地使用
        + Swagger UI 解析 swagger 的 json 并生成 html 静态文档
        + Swagger Codegen 可以通过 json 文档生成 Java 等语言里面的模板文件（模型文件）
        + Swagger Inspector API 自动化测试
        + Swagger Hub 共享 swagger 文档
* 使用契约进行前后端协作：在团队内部，前后端协作本质上需要的不是一份 API 文档，而是一个可以供前后端共同遵守的契约
    - 前后端可以一起制定一份契约，使用这份契约共同开发，前端使用这份契约 mock API，后端则可以通过它简单的验证API是否正确输出
    - **契约测试**:消费者驱动的契约  Spring cloud contract
    - 后端根据需求，生成 API 定义文件，就可以进一步完成生成 HTML 静态文档、模拟 API 数据等操作
    - 前端对接接口,通过 swagger 的 node 版本 swagger-node 自带的 mock 模式启动一个 Mock server，然后根据约定模拟自己想要的数据, mockjs + rap 或者 easy-mock
    - 管理契约文件:单独增加了一个管理契约文件的 git仓库，并使用 git 的submodule 来引用到各个涉及到了的代码仓库中
        + 单独放置还有一个额外的好处:构建契约测试时，可以方便的发送到一台中间服务器。一旦 API 契约发生变化，可以触发 API提供的契约验证测试
* RAML RestFul API 统一建模语言 （RESTful API Modeling Language）,构建出 API 协作的工具链，设计、构建、测试、文档、共享。

## 动态令牌

* OTP：One-Time Password 一次性密码。
* HOTP：HMAC-based One-Time Password 基于HMAC算法加密的一次性密码。
* TOTP：Time-based One-Time Password 基于时间戳算法的一次性密码。

### [encode/apistar](https://github.com/encode/apistar)

A smart Web API framework, for Python 3. 🌟 https://docs.apistar.com

* pip3 install apistar
* Create a new project in app.py, python app.py
* Open http://127.0.0.1:5000/docs/ in your browser

```py
from apistar import App, Route

def welcome(name=None):
    if name is None:
        return {'message': 'Welcome to API Star!'}
    return {'message': 'Welcome to API Star, %s!' % name}


routes = [
    Route('/', method='GET', handler=welcome),
]

app = App(routes=routes)


if __name__ == '__main__':
    app.serve('127.0.0.1', 5000, debug=True)
```

### apidoc

* 配置
    - 每次导出接口文档都必须要让apidoc读取到apidoc.json文件(如果未添加配置文件，导出报错)，可以在项目的根目录下添加apidoc.json文件
    - 项目中使用了package.json文件(例如:node.js工程)，可以将apidoc.json文件中的所有配置信息放到package.json文件中的apidoc参数中
    - 参数
        + name
        + version
        + description
        + title
        + url
        + header.title
        + header.filename   页眉文件名(markdown)
        + footer.title    页脚导航标题
        + footer.filename     页脚文件名(markdown)
        + order   接口名称或接口组名称的排序列表,如果未定义，那么所有名称会自动排序 "Error", "Define", "PostTitleAndError", "PostError"

```
# 安装
npm install apidoc -g
apidoc -i myapp/ -o apidoc/ -t mytemplate/

# 支持中文title

# apidoc.json
{
  "name": "example",
  "version": "0.1.0",
  "description": "apiDoc basic example",
  "title": "Custom apiDoc browser title",
  "url" : "https://api.github.com/v1"
}

# package.json
{
  "name": "example",
  "version": "0.1.0",
  "description": "apiDoc basic example",
  "apidoc": {
    "title": "Custom apiDoc browser title",
    "url" : "https://api.github.com/v1"
  }
}

## 语法
# 注释模块: 通用可复用的注释模块(例如:接口错误响应模块),只需要在源代码中定义一次，便可以在其他注释模块中随便引用，最后在文档导出时会自动替换所引用的注释模块，定义之后您可以通过@apiUse来引入所定义的注释模块
/**
 * @apiDefine name [title]
                     [description]
 */
/**
 * @apiDefine MyError
 * @apiError [(group)] [{type}] field [description]
  * @apiError UserNotFound The <code>id</code> of the User was not found.
 */
/**
 * @apiDefine admin User access only
 * This optional description belong to to the group admin.
 */
/**
 * @apiDefine MySuccess
 * @apiSuccess {string} firstname The users firstname.
 * @apiSuccess {number} age The users age.
 */

# 标注一个接口已经被弃用
/**
 * @apiDeprecated use now (#Group:Name).
 *
 * Example: to set a link to the GetDetails method of your group User
 * write (#User:GetDetails)
 */

/**
 * @apiIgnore [hint]
 * @apiIgnore Not finished Method

 * @api {method} path [title]
 * @api {get} /user/:id

 * @apiVersion 1.6.2

 * @apiName name
 *
 * @apiDescription This is the Description.
 * It is multiline capable.
 *
 * Last line of Description.

 * @apiGroup User

 * @appUse MyError
 * @apiPermission admin|none
 * @apiUse MySuccess

 * # 定义为私有的接口，可以在生成接口文档的时候，通过在命令行中设置参数 --private false|true来决定导出的文档中是否包含私有接口
 * @apiPrivate
 *
 * 导出的html接口文档中会包含模拟接口请求的form表单；如果在配置文件apidoc.json中设置了参数sampleUrl,那么导出的文档中每一个接口都会包含模拟接口请求的form表单，如果既设置了sampleUrl参数，同时也不希望当前这个接口不包含模拟接口请求的form表单
 * @apiSampleRequest url
 * @apiSampleRequest off

 * @apiHeader [(group)] [{type}] [field=defaultValue] [description]
 * @apiHeader {String} access-key Users unique access-key.
 * @apiHeaderExample {json} Header-Example:
 *     {
 *       "Accept-Encoding": "Accept-Encoding: gzip, deflate"
 *     }
 *
 * @apiParam [(group)] [{type}] [field=defaultValue] [description]
 * @apiParam {Number} id Users unique ID.
 * @api {post} /user/
 * @apiParam {String} [firstname]  Optional Firstname of the User.
 * @apiParam {String} lastname     Mandatory Lastname.
 * @apiParam {String} country="DE" Mandatory with default value "DE".
 * @apiParam {Number} [age=18]     Optional Age with default 18.
 *
 * @apiParam (Login) {String} pass Only logged in users can post this.
 *                                 In generated documentation a separate
 *                                 "Login" Block will be generated.

 * @apiParamExample [{type}] [title]
                   example
 * @apiParamExample {json} Request-Example:
 *     {
 *       "id": 4711
 *     }
 *
 * @apiError UserNotFound The <code>id</code> of the User was not found.
 * @apiErrorExample [{type}] [title]
 *               example
 * @apiErrorExample {json} Error-Response:
 *     HTTP/1.1 404 Not Found
 *     {
 *       "error": "UserNotFound"
 *     }

 * @apiExample [{type}] title
            example
 * @apiExample {curl} Example usage:
 *     curl -i http://localhost/user/4711
 *
 * @apiSuccess [(group)] [{type}] field [description]
 * @apiSuccess (200) {String} lastname  Lastname of the User.
 * @apiSuccess {Boolean} active        Specify if the account is active.
 * @apiSuccess {Object}  profile       User profile information.
 * @apiSuccess {Number}  profile.age   Users age.
 * @apiSuccess {String}  profile.image Avatar-Image.
 *
 * @apiSuccessExample {json} Success-Response:
 *     HTTP/1.1 200 OK
 *     {
 *       "firstname": "John",
 *       "lastname": "Doe"
 *     }
 */

```

## 接口

* [public-apis/public-apis](https://github.com/public-apis/public-apis):A collective list of free APIs for use in software and web development. https://ultimatecourses.com
* [雅虎天气](https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20%3D%202151330&format=json)
* [价格](http://api.money.126.net/data/feed/0000001,1399001?callback=refreshPrice)
* [Vespa314/bilibili-api](https://github.com/Vespa314/bilibili-api):B站API收集整理及开发
* [jokermonn/-Api](https://github.com/jokermonn/-Api):📖「一个」、「Time 时光」、「开眼」、「一席」、「梨视频」、「微软必应词典」、「金山词典」、「豆瓣电影」、「中央天气」、「魅族天气」、「每日一文」、「12306」、「途牛」、「快递100」、「快递」应用 Api
* [toddmotto/public-apis](https://github.com/toddmotto/public-apis):A collective list of public JSON APIs for use in web development. https://toddmotto.com
* [pwxcoo/chinese-xinhua](https://github.com/pwxcoo/chinese-xinhua):📙 中华新华字典数据库。包括歇后语，成语，词语，汉字。提供新华字典API。
* [Binaryify/NeteaseCloudMusicApi](https://github.com/Binaryify/NeteaseCloudMusicApi):网易云音乐 Node.js API service https://binaryify.github.io/NeteaseCloudMusicApi/#/
* 豆瓣
    - [douban](https://developers.douban.com/wiki/?title=guide)
    - [获取正在热映的电影](https://api.douban.com/v2/movie/in_theaters?city=广州&start=0&count=10)
    - [获取电影Top250](https://api.douban.com/v2/movie/top250?start=0&count=10)
    - [电影搜索](https://api.douban.com/v2/movie/search?q=神秘巨星&start=0&count=10)
    - [电影详情](https://api.douban.com/v2/movie/subject/26942674)

## 工具

* Gateway
    - [TykTechnologies/tyk](https://github.com/TykTechnologies/tyk)：Tyk Open Source API Gateway written in Go
* [GoogleChrome/puppeteer](https://github.com/GoogleChrome/puppeteer):Headless Chrome Node API https://try-puppeteer.appspot.com/
* [thx/RAP](https://github.com/thx/RAP):Web接口管理工具，开源免费，接口自动化，MOCK数据自动生成，自动化测试，企业级管理。阿里妈妈MUX团队出品！阿里巴巴都在用！1000+公司的选择！RAP2已发布请移步至https://github.com/thx/rap2-delos http://rapapi.org
* [thx/rap2-delos](https://github.com/thx/rap2-delos):阿里妈妈前端团队出品的开源接口管理工具RAP第二代 http://rap2.taobao.org
* [encode/apistar](https://github.com/encode/apistar):A smart Web API framework, for Python 3. 🌟 https://docs.apistar.com
* [ruby-grape/grape](https://github.com/ruby-grape/grape):An opinionated framework for creating REST-like APIs in Ruby. http://www.ruby-grape.org
* [encode/django-rest-framework](https://github.com/encode/django-rest-framework):Web APIs for Django. ⚡️ https://www.django-rest-framework.org
* [paularmstrong/normalizr](https://github.com/paularmstrong/normalizr):Normalizes nested JSON according to a schema
* [dingo/api](https://github.com/dingo/api):A RESTful API package for the Laravel and Lumen frameworks.
* [parse-community/parse-server](https://github.com/parse-community/parse-server):Parse-compatible API server module for Node/Express http://parseplatform.org
* [interagent/http-api-design](https://github.com/interagent/http-api-design):HTTP API design guide extracted from work on the Heroku Platform API https://www.gitbook.com/read/book/gee…
* [typicode/json-server](https://github.com/typicode/json-server):Get a full fake REST API with zero coding in less than 30 seconds (seriously)
* [tobscure/json-api](https://github.com/tobscure/json-api):JSON-API (http://jsonapi.org) responses in PHP.
* [hashicorp/vault](https://github.com/hashicorp/vault)：A tool for secrets management, encryption as a service, and privileged access management https://www.vaultproject.io/
* [nsf/termbox-go](https://github.com/nsf/termbox-go):Pure Go termbox implementation http://code.google.com/p/termbox
* [apiaryio/dredd](https://github.com/apiaryio/dredd):Language-agnostic HTTP API Testing Tool https://dredd.rtfd.io
* [hellofresh/janus](https://github.com/hellofresh/janus):An API Gateway written in Go https://hellofresh.gitbooks.io/janus
* [SocketLog](https://github.com/luofei614/SocketLog)
* 加密
    - [google/tink](https://github.com/google/tink):Tink is a multi-language, cross-platform library that provides cryptographic APIs that are secure, easy to use correctly, and hard(er) to misuse.
    - [JSEncrypt](https://github.com/travist/jsencrypt):用于执行OpenSSL RSA加密、解密和密钥生成的Javascript库。WEB 的登录功能时一般是通过 Form 提交或 Ajax 方式提交到服务器进行验证的。为了防止抓包，登录密码肯定要先进行一次加密（RSA），再提交到服务器进行验证
* 测试
    - postman
    - [apiaryio/dredd](https://github.com/apiaryio/dredd):Language-agnostic HTTP API Testing Tool https://dredd.org
    - [airbnb/hypernova](https://github.com/airbnb/hypernova):A service for server-side rendering your JavaScript views
* 文档
    - [swagger-api/swagger-ui](https://github.com/swagger-api/swagger-ui):Swagger UI is a collection of HTML, Javascript, and CSS assets that dynamically generate beautiful documentation from a Swagger-compliant API. http://swagger.io
    - [YMFE/yapi](https://github.com/YMFE/yapi):YApi 是一个可本地部署的、打通前后端及QA的、可视化的接口管理平台 http://yapi.demo.qunar.com/
    * [gongwalker/ApiManager](https://github.com/gongwalker/ApiManager):接口文档管理工具
    - [jsdoc3/jsdoc](https://github.com/jsdoc3/jsdoc):An API documentation generator for JavaScript. http://usejsdoc.org
    - [swagger](https://app.swaggerhub.com/home)Swagger UI is a collection of HTML, Javascript, and CSS assets that dynamically generate beautiful documentation from a Swagger-compliant API. http://swagger.io
    - [freeCodeCamp/devdocs](https://github.com/freeCodeCamp/devdocs):API Documentation Browser https://devdocs.io
    - [lord/slate](https://github.com/lord/slate):Beautiful static documentation for your API https://spectrum.chat/slate
    - YUI doc
    - eolinker
    - Apizza
    - Yapi
    - [RAP2](http://rap2.taobao.org)
    - DOClever
* 抓包
    - Charles
    - fiddler
    - [Wireshark](https://www.wireshark.org)
* API 文档/契约生成工具
    - apidoc
    - swagger
    - blue sprint
    - RAML
* mock 工具清单
    - wiremock
    - json-server
    - node-mock-server
    - node-mocks-http
    - [nuysoft/Mock](https://github.com/nuysoft/Mock):A simulation data generator http://mockjs.com
* HTTP 请求拦截器
    - axios-mock-adapter
    - jquery-mockjax
* 契约/API 测试工具
    - Spring Cloud Contract
    - Pact
    - Rest-Assured

## 参考

* [OAI/OpenAPI-Specification](https://github.com/OAI/OpenAPI-Specification):The OpenAPI Specification Repository https://openapis.org
* [jsonapi](https://jsonapi.org/format/)
* [shieldfy/API-Security-Checklist](https://github.com/shieldfy/API-Security-Checklist):Checklist of the most important security countermeasures when designing, testing, and releasing your API
