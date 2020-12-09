# [yii2](https://github.com/yiisoft/yii2)

Yii 2: The Fast, Secure and Professional PHP Framework <http://www.yiiframework.com>

* [yiisoft / yii2-app-basic](https://github.com/yiisoft/yii2-app-basic):Yii 2.0 Basic Application Template <http://www.yiiframework.com>
* [yiisoft/yii2-app-advanced](https://github.com/yiisoft/yii2-app-advanced):Yii 2.0 Advanced Application Template

```sh
composer global require "fxp/composer-asset-plugin:^1.2.0"

composer create-project --prefer-dist yiisoft/yii2-app-basic yii2-basic
composer create-project --prefer-dist yiisoft/yii2-app-advanced yii2-advanced

composer install
php requirements.php
./init

php yii serve --docroot="@frontend/web" --port=8888
./yii serve
# common/config/main-local.php 本地配置
yii migrate # 生成数据
```

## 服务搭建

```sh
DocumentRoot "path/to/basic/web"

<Directory "path/to/basic/web">
    # 开启 mod_rewrite 用于美化 URL 功能的支持（译注：对应 pretty URL 选项）
    RewriteEngine on
    # 如果请求的是真实存在的文件或目录，直接访问
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteCond %{REQUEST_FILENAME} !-d
    # 如果请求的不是真实文件或目录，分发请求至 index.php
    RewriteRule . index.php

    # if $showScriptName is false in UrlManager, do not allow accessing URLs with script name
    RewriteRule ^index.php/ - [L,R=404]

    # ...其它设置...
</Directory>

server {
    charset utf-8;
    client_max_body_size 128M;

    listen 80; ## listen for ipv4
    #listen [::]:80 default_server ipv6only=on; ## listen for ipv6

    server_name mysite.test;
    root        /path/to/basic/web;
    index       index.php;

    access_log  /path/to/basic/log/access.log;
    error_log   /path/to/basic/log/error.log;

    location / {
        # Redirect everything that isn't a real file to index.php
        try_files $uri $uri/ /index.php$is_args$args;
    }

    # uncomment to avoid processing of calls to non-existing static files by Yii
    #location ~ \.(js|css|png|jpg|gif|swf|ico|pdf|mov|fla|zip|rar)$ {
    #    try_files $uri =404;
    #}
    #error_page 404 /404.html;

    # deny accessing php files for the /assets directory
    location ~ ^/assets/.*\.php$ {
        deny all;
    }

    location ~ \.php$ {
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_pass 127.0.0.1:9000;
        # fastcgi_param HTTPS on;
        #fastcgi_pass unix:/var/run/php5-fpm.sock;
        try_files $uri =404;
    }

    location ~* /\. {
        deny all;
    }
}
```

## 生命周期

* 用户提交 指向入口脚本 web/index.php(负责启动一个请求处理周期) 的请求
* 入口脚本会加载配置数组并创建一个 application (应用:能全局范围内访问的对象，管理协调组件来完成请求),实例用于处理该请求
* 应用会通过 request（请求） 应用组件解析被请求的路由
* 应用创建一个 controller（控制器） 实例具体处理请求
* 控制器会创建一个 action（动作） 实例并为该动作执行相关的 Filters（控制器在处理请求之前或之后 需要触发执行的代码）
* 如果任何一个过滤器验证失败，该动作会被取消,如果全部的过滤器都通过，该动作就会被执行
* 动作会加载一个数据模型，一般是从数据库中加载
* 动作会渲染一个 View（视图），并为其提供所需的数据模型
  - 小部件（可嵌入到视图中的对象， 可包含控制器逻辑，可被不同视图重复调用）
* 渲染得到的结果会返回给 response（响应） 应用组件
* 响应组件会把渲染结果发回给用户的浏览器

## 原理

* 入口脚本（Entry Scripts）
  - 定义全局常量
    + YII_DEBUG：标识应用是否运行在调试模式。当在调试模式下，应用会保留更多日志信息， 如果抛出异常，会显示详细的错误调用堆栈。 因此，调试模式主要适合在开发阶段使用，YII_DEBUG 默认值为 false
    + YII_ENV：标识应用运行的环境，详情请查阅 配置章节。 YII_ENV 默认值为 'prod'，表示应用运行在线上产品环境
    + YII_ENABLE_ERROR_HANDLER：标识是否启用 Yii 提供的错误处理， 默认为 true
  - 注册 Composer 自动加载器
  - 包含 Yii 类文件
  - 加载应用配置
  - 创建一个应用实例并配置 Bootstrapping

          * preInit()（预初始化）方法，配置一些高优先级的应用属性
          * 注册 errorHandler
          * 配置应用主体属性
          * 通过调用 yiibaseApplication::init()（初始化）方法，会顺次调用 yiibaseApplication::bootstrap() 从而运行引导组件
              - 加载扩展清单文件(extension manifest file) vendor/yiisoft/extensions.php
              - 创建并运行各个扩展声明的 引导组件（bootstrap components）
              - 创建并运行各个 应用组件 以及在应用的 Bootstrap 属性中声明的各个模块（modules 包含完整 MVC 结构的独立包， 一个应用可以由多个模块组建）、组件（在应用中注册的对象， 提供不同的功能来完成请求）
  - 调用 yii\base\Application::run() 来处理请求
    + 触发 EVENT_BEFORE_REQUEST 事件
    + 处理请求：解析请求 路由 和相关参数； 创建路由指定的模块、控制器和动作对应的类，并运行动作
    + 触发 EVENT_AFTER_REQUEST 事件
    + 发送响应到终端用户
  - 入口脚本接收应用主体传来的退出状态并完成请求的处理
* 应用（Applications）
  - 属性 指定应用主体的运行环境
    + id（必须）：用来区分其他应用的唯一标识 ID，主要给程序使用。 为了方便协作，最好使用数字作为应用主体ID， 但不强制要求为数字
    + basePath（必须）：应用的根目录，常用于派生一些其他重要路径（如 runtime 路径）， 因此，系统预定义 @app 代表这个路径
    + aliases:用一个数组定义多个别名
    + bootstrap:用数组指定启动阶段 bootstrapping process 需要运行的组件
      * 如果模块 ID 和应用组件 ID 同名，优先使用应用组件 ID，如果想用模块 ID，可以使用如下匿名函数返回模块 ID
      * 类名
      * 配置数组
      * 匿名函数
    + catchAll（仅 Web applications 网页应用支持）：要处理所有用户请求的 控制器方法，通常在维护模式下使用，同一个方法处理所有用户请求
    + components:注册应用组件
    + controllerMap:指定一个控制器 ID 到任意控制器类,打破默认的控制器对应规则
    + controllerNamespace:指定控制器类默认的命名空间，默认为app\controllers
    + sourceLanguage:指定应用代码的语言，默认为 'en-US' 标识英文（美国）
    + language：指定应用展示给终端用户的语言，默认为 en 标识英文
    + timeZone 提供一种方式修改 PHP 运行环境中的默认时区
    + name: 展示给终端用户的应用名称，不同于需要唯一性的 yiibaseApplication::id 属性，该属性可以不唯一，该属性用于显示应用的用途
    + modules:指定应用所包含的模块配置
    + params:一个数组，指定可以全局访问的参数 `\Yii::$app->params['thumbnail.size']`
    + version 指定应用的版本
    + charset 指定应用使用的字符集，默认值为 'UTF-8'
    + defaultRoute 未配置的请求的响应 路由 规则
      * web:site/index
      * console:help/index
    + extensions:用数组列表指定应用安装和使用的 扩展,默认使用 @vendor/yiisoft/extensions.php 文件返回的数组
    + layout: 指定渲染视图默认使用的布局名字， 默认值为 'main' 对应布局路径下的 main.php 文件
      * false:关闭默认main,在具体的结构中重新声明
    + layoutPath:指定查找布局文件的路径，默认值为视图路径下的 layouts 子目录，默认的布局路径别名为@app/views/layouts
    + runtimePath 指定临时文件如日志文件、缓存文件等保存路径
    + viewPath 指定视图文件的根目录
    + vendorPath 指定 Composer 管理的vendor路径
    + enableCoreCommands：仅 console applications 控制台应用支持， 用来指定是否启用 Yii 中的核心命令，默认值为 true
* 事件属性
  - `on beforeRequest\beforeRequest`
  - `on beforeRequest\afterRequest`
  - `on beforeAction\beforeAction`
  - `on beforeAction\afterAction`

```php
[
    // 一个应用组件只会在第一次访问时实例化，如果处理请求过程没有访问的话就不实例化
    'bootstrap' => [
        // 应用组件ID或模块ID
        'demo',

        // 类名
        'appcomponentsProfiler',

        // 配置数组
        [
            'class' => 'appcomponentsProfiler',
            'level' => 3,
        ],

        // 匿名函数
        function () {
            return new appcomponentsProfiler();
        },

        // function () {
        //     return Yii::$app->getModule('user');
        // },
        #  log 组件一直被加载
        'components' => [
            'log' => [
                    // "log" 组件的配置
                ],
         ],

        [
            'class' => ContentNegotiator::className(),
            'formats' => [
                'application/json' => Response::FORMAT_JSON,
                'application/xml' => Response::FORMAT_XML,
            ],
            'languages' => [
                'en-US',
                'de',
            ],
        ],
    ],

    'defaultRoute' => 'main',
    // 全拦截路由：第一项指定动作的路由，剩下的数组项(key-value 成对)指定传递给动作的参数
    'catchAll' => [
        'offline/notice',
        'param1' => 'value1',
        'param2' => 'value2',
    ],

    'components' => [
        // 使用类名注册 "cache" 组件
        'cache' => [
            'class' => 'yiicachingFileCache',
            // 'cache' => 'yiicachingApcCache',
        ],
        'user' => [
            'identityClass' => 'appmodelsUser',
            'enableAutoLogin' => true,
        ],

        // 使用配置数组注册 "db" 组件
        'db' => [
            'class' => 'yiidbConnection',
            'dsn' => 'mysql:host=localhost;dbname=demo',
            'username' => 'root',
            'password' => '',
        ],

        // 使用函数注册"search" 组件
        'search' => function () {
            return new appcomponentsSolrService;
        },
    ],

    'controllerMap' => [
        [
            'account' => 'app\controllers\UserController',
            'article' => [
                'class' => 'app\controllers\PostController',
                'enableCsrfValidation' => false,
            ],
        ],
    ],

    'modules' => [
        // "booking" 模块以及对应的类
        'booking' => 'app\modules\booking\BookingModule',

        // "comment" 模块以及对应的配置数组
        'comment' => [
            'class' => 'app\modules\comment\CommentModule',
            'db' => 'db',
        ],
    ],

    'timeZone' => 'America/Los_Angeles',
    'extensions' => [
        'name' => 'extension name',
        'version' => 'version number',
        'bootstrap' => 'BootstrapClassName',  // 可选配，可为配置数组
        'alias' => [  // 可选配
            '@alias1' => 'to/path1',
            '@alias2' => 'to/path2',
        ],
    ],

    // ... 更多像上面的扩展 ...
    'on beforeRequest' => function ($event) {
        // ...
    },
    'on beforeAction' => function ($event) {
        if (some condition) {
            $event->isValid = false;
        } else {
        }
    },
    #
    // \Yii::$app->on(\yii\base\Application::EVENT_BEFORE_REQUEST, function ($event) {
    //     // ...
    // });
]

    if (YII_ENV_DEV) {
        // configuration adjustments for 'dev' environment
        $config['bootstrap'][] = 'debug';
        $config['modules']['debug'] = 'yiidebugModule';

        $config['bootstrap'][] = 'gii';
        $config['modules']['gii'] = 'yiigiiModule';
    }
```

## Component

* Yii 的核心概念:注册 Component，实现一系列功能
  - 每一个应用组件指定一个 key-value 对的数组，key 代表组件 ID， value 代表组件类名或配置
  - 在应用中可以任意注册组件
  - 服务定位器，它部署一组提供各种不同功能的应用组件来处理请求,通过表达式 `\Yii::$app->ComponentID` 全局访问
  - 只会在第一次访问时实例化，如果处理请求过程没有访问的话就不实例化
  - 如果像在每个请求处理过程都实例化某个组件即便不会被访问，将该组件ID加入到应用主体的 bootstrap 属性中
* 三个用以区分它和其它类的主要功能有：比常规的对象（Object）稍微重量级一点，因为要使用额外的内存和 CPU 时间来处理 事件 和 行为 。 如果不需要这两项功能，可以继承 yii\base\Object
  - 属性（Property）
  - 事件（Event）将自定义代码“注入”到现有代码中的特定执行点
    + 事件处理器是一个PHP 回调函数，当所附加到的事件被触发时它就会执行
    + Triggering Events：通过调用 yii\base\Component::trigger() 方法触发，此方法须传递事件名
    + Class-Level Event Handlers：通过调用静态方法 yii\base\Event::on() 在类级别附加处理器
  - 行为（Behavior）
    + 无须改变类继承关系即可增强一个已有的 组件 类功能。 当行为附加到组件后，它将“注入”它的方法和属性到组件， 然后可以像访问组件内定义的方法和属性一样访问它们
    + 行为通过组件能响应被触发的事件，从而自定义或调整组件正常执行的代码
    + 将行为中的事件handler绑定到类中去
    + Behavior
      * 行为类像普通类支持继承。另一方面，traits 可以视为 PHP 语言支持的复制粘贴功能， 它不支持继承。
      * 行为无须修改组件类就可动态附加到组件或移除。 要使用 traits，必须修改使用它的类。
      * 行为是可配置的，而 traits 则不可行。
      * 行为可以通过响应事件来定制组件的代码执行。
      * 当附属于同一组件的不同行为之间可能存在名称冲突时， 通过优先考虑附加到该组件的行为， 自动解决冲突。由不同 traits 引起的名称冲突需要通过 重命名受影响的属性或方法进行手动解决。
    + Traits
      * Traits 比行为更有效，因为行为是既需要时间又需要内存的对象。
      * 因为 IDE 是一种本地语言结构，所以它们对 Traits 更友好。
* 核心应用组件
  - yii\i18n\Formatter: 格式化输出显示给终端用户的数据，例如数字可能要带分隔符， 日期使用长格式
  - yii\i18n\I18N: 支持信息翻译和格式化
  - yii\web\AssetManager: 管理资源包和资源发布
  - yii\db\Connection: 代表一个可以执行数据库操作的数据库连接，注意配置该组件时必须指定组件类名和其他相关组件属性，如 yiidbConnection::dsn
  - yii\web\ErrorHandler: 处理 PHP 错误和异常
  - yii\log\Dispatcher: 管理日志对象
  - yii\swiftmailer\Mailer: 支持生成邮件结构并发送
  - yii\web\Request: 代表从终端用户处接收到的请求
  - yii\web\Response: 代表发送给用户的响应
  - yii\web\Session: 代表会话信息，仅在 yii\web\Application 网页应用中可用
  - yii\web\UrlManager: 支持 URL 地址解析和创建
  - yii\web\User: 代表认证登录用户信息，仅在 yii\web\Application 网页应用中可用
  - yii\web\View: 支持渲染视图

## Model

* 代表业务数据、规则和逻辑的对象
* 属性: 代表可像普通类属性或数组一样被访问的业务数据，yii\base\Model支持 ArrayAccess 数组访问 和 ArrayIterator 数组迭代器
* 属性标签: 指定属性显示出来的标签
  - 默认情况下，属性标签通过yii\base\Model::generateAttributeLabel()方法自动从属性名生成. 它会自动将驼峰式大小写变量名转换为多个首字母大写的单词
  - 自定义标签 可以覆盖 yii\base\Model::attributeLabels() 方法明确指定属性标签
* 场景：模型支持的场景由模型中申明的 验证规则 来决定
* 块赋值:一步给许多属性赋值，只应用在模型当前scenario 场景yii\base\Model::scenarios()方法 列出的称之为 安全属性 的属性上
* 验证规则: 确保输入数据符合申明的验证规则
* 数据导出: 模型数据导出为自定义格式的数组

```php
namespace app/models;

use yiibaseModel;

class ContactForm extends Model
{
    public $name;
    public $email;
    public $subject;
    public $body;

    public function scenarios()
    {
        $scenarios = parent::scenarios();
        $scenarios['login'] = ['username', 'password'];
        $scenarios['register'] = ['username', 'email', 'password'];

        // 想验证一个属性但不想让他是安全的
        $scenarios['login'] => ['username', 'password', '!secret'],
        return $scenarios;
    }

    public function rules()
    {
        return [
            // 在"register" 场景下 username, email 和 password 必须有值
            [['username', 'email', 'password'], 'required', 'on' => 'register'],

            // 在 "login" 场景下 username 和 password 必须有值
            [['username', 'password'], 'required', 'on' => 'login'],
            // 来申明哪些属性是安全的不需要被验证
            [['title', 'description'], 'safe'],
        ];
    }

    public function attributeLabels()
    {
        return [
            'name' => Yii::t('app', 'Your name'),
            'email' => Yii::t('app', 'Your email address'),
            'subject' => Yii::t('app', 'Subject'),
            'body' => Yii::t('app', 'Content'),
        ];

        return [
            // 字段名和属性名相同
            'id',

            // 字段名为 "email"，对应属性名为 "email_address"
            'email' => 'email_address',

            // 字段名为 "name", 值通过PHP代码返回
            'name' => function () {
                return $this->first_name . ' ' . $this->last_name;
            },
        ];
    }
}

$model = new app/models/ContactForm;
$model->scenario = 'login';

// 场景通过构造初始化配置来设置
$model = new User(['scenario' => 'login']);

// 用户输入数据赋值到模型属性
$model->attributes = Yii::$app->request->post('ContactForm');

if ($model->validate()) {
    // 所有输入数据都有效 all inputs are valid
} else {
    // 验证失败：$errors 是一个包含错误信息的数组
    $errors = $model->errors;
}

# Data Transformation
1. model add function getNewAttribute()
2. use:$instance->newAttribute
```

## Controller

* 控制器:从应用主体接管控制后会分析请求数据并传送到模型， 传送模型结果到视图，最后生成输出响应信息.逻辑实现层与展示层的结合
  - post-comment:`app/controllers/PostCommentController`
  - adminPanels/post-comment:`app/controllers/adminPanels/PostCommentController`
* 路由 `ModuleID/ControllerID/ActionID`
* ActionID：总是被以小写处理，如果由多个单词组成，单词之间将由连字符连接（如 create-comment）
  - 操作 ID 映射为方法名时移除了连字符，将每个单词首字母大写，并加上 action 前缀。create-comment:actionCreateComment
  - 默认操作为 index，如果想修改默认操作，只需简单地在控制器类中覆盖这个属性
  - 参数类型限制路由中 id 数据类型
* actions:继承yii\base\Action或它的子类来定义 覆盖 actions()方法
* 过滤器: 控制器动作 执行之前或之后执行的对象. 在控制器类中覆盖它的 behaviors() 方法来声明过滤器
  - 预过滤:按顺序执行应用主体中 behaviors()->模块中 behaviors()->控制器中 behaviors()
  - 成功通过预过滤后执行动作
  - 后过滤:控制器中 behaviors() ->模块中 behaviors()->应用主体中 behaviors()
  - 构建过滤器：继承 `yii\base\ActionFilter` 类并覆盖 beforeAction() 或 afterAction() 方法来创建动作的过滤器
  - 常用过滤器
    + AccessControl 提供基于 rules 规则的访问控制
    + HTTP Basic Auth\OAuth 2 认证一个用户
    + ContentNegotiator 支持响应内容格式处理和语言处理
    + PageCache 实现服务器端整个页面的缓存
    + RateLimiter 根据 漏桶算法 来实现速率限制,主要用在实现 RESTful APIs
    + VerbFilter 检查请求动作的 HTTP 请求方式是否允许执行
    + 跨域资源共享 CORS 机制允许一个网页的许多资源（例如字体、JavaScript等）可以通过其他域名访问获取, Cors filter 应在授权/认证过滤器之前定义， 以保证 CORS 头部被发送
* 周期
  - 控制器创建和配置后，yii\base\Controller::init() 方法会被调用
  - 控制器根据请求操作ID创建一个操作对象
    + 如果操作ID没有指定，会使用default action ID默认操作ID
    + 如果在action map找到操作ID， 会创建一个独立操作
    + 如果操作ID对应操作方法，会创建一个内联操作
    + 否则会抛出yii\base\InvalidRouteException异常
  - 控制器按顺序调用应用主体、模块（如果控制器属于模块）、 控制器的 beforeAction() 方法
    + 如果任意一个调用返回false，后面未调用的beforeAction()会跳过并且操作执行会被取消
    + 默认情况下每个 beforeAction() 方法会触发一个 beforeAction 事件，在事件中你可以追加事件处理操作
  - 控制器执行操作: 请求数据解析和填入到操作参数
  - 控制器按顺序调用控制器、模块（如果控制器属于模块）、应用主体的 afterAction() 方法； 默认情况下每个 afterAction() 方法会触发一个 afterAction 事件， 在事件中可以追加事件处理操作
  - 应用主体获取操作结果并赋值给响应
* yiifiltersCors 应在 授权 / 认证 过滤器之前定义，以保证CORS头部被发送。

```php
namespace app/components;

use Yii;
use yii/baseAction/Filter;

class ActionTimeFilter extends ActionFilter
{
    public $enableCsrfValidation = false;

    // 开启csrf
    public function beforeAction($action){
        $currentAction = $action->id;
        $accessActions = ['vote','like','delete','download'];
        if(in_array($currentAction,$accessActions)) {
            $action->controller->enableCsrfValidation = true;
        }
        parent::beforeAction($action);
        return true;
    }

    // 应用 模块 控制器三级
    public function behaviors()
    {
        return [
            [
                'class' => 'yiifiltersHttpCache',
                'only' => ['index', 'view'],
                'except' => ['update', 'delete'],
                'lastModified' => function ($action, $params) {
                    $q = new yiidbQuery();
                    return $q->from('user')->max('updated_at');
                },
                'rules' => [
                    // 允许认证用户
                    [
                        'allow' => true,
                        'roles' => ['@'],
                    ],
                    // 默认禁止其他用户
                ],
                // 利用Last-Modified 和 Etag HTTP头实现客户端缓存
                'lastModified' => function ($action, $params) {
                    $q = new yiidbQuery();
                    return $q->from('user')->max('updated_at');
                },
                // 认证用户
                'basicAuth' => [
                    'class' => HttpBasicAuth::className(),
                ],
            ],
            // 支持响应内容格式处理和语言处理。 通过检查 GET 参数和 Accept HTTP头部来决定响应内容格式和语言
            [
                'class' => ContentNegotiator::className(),
                'formats' => [
                    'application/json' => Response::FORMAT_JSON,
                    'application/xml' => Response::FORMAT_XML,
                ],
                'languages' => [
                    'en-US',
                    'de',
                ],
            ],
        ];

        return ArrayHelper::merge([
            [
                'class' => Cors::className(),
                'cors' => [
                    'Origin' => ['http://www.myserver.net'],
                    'Access-Control-Request-Method' => ['GET', 'HEAD', 'OPTIONS'],
                ],
            ],
        ], parent::behaviors());
    }

    public function beforeAction($action)
    {
        $this->_startTime = microtime(true);
        return parent::beforeAction($action);
    }

    public function afterAction($action, $result)
    {
        $time = microtime(true) - $this->_startTime;
        Yii::trace("Action '{$action->uniqueId}' spent $time second.");
        return parent::afterAction($action, $result);
    }
}

$model = new Post;
if ($model->load(Yii::$app->request->post()) && $model->save()) {
    return $this->redirect([’view’, ’id’ => $model->id]);
} else {
    return $this->render(’create’, [
        ’model’ => $model,
    ]);
}
```

## View

* 通过 view 应用组件来管理 视图模板,配置
  - 主题
  - 片段缓存: 在Web页面中缓存片段；
  - 客户脚本处理: 支持CSS 和 JavaScript 注册和渲染
  - 资源包处理: 支持 资源包的注册和渲染
  - 模板引擎: 允许使用其他模板引擎，如 Twig, Smarty
* 组织：@app/views/ControllerID 目录下, 小部件 渲染的视图文件默认放在 WidgetPath/views 目录
* 控制器中渲染
  - yiibaseController::render(): 渲染一个 视图名 并使用一个 布局 返回到渲染结果
  - yiibaseController::renderPartial(): 渲染一个视图名并且不使用布局
  - yiiwebController::renderAjax(): 渲染一个 视图名 并且不使用布局， 并注入所有注册的 JS/CSS 脚本和文件，通常使用在响应 AJAX 网页请求的情况下
  - yiibaseController::renderFile(): 渲染一个视图文件目录或别名下的视图文件
* 视图中渲染
  - yiibaseView::render(): 渲染一个 视图名
  - yiiwebView::renderAjax(): 渲染一个 视图名 并注入所有注册的 JS/CSS 脚本和文件，通常使用在响应 AJAX 网页请求的情况下
  - yiibaseView::renderFile(): 渲染一个视图文件目录或别名下的视图文件。`<?= $this->render('_overview') ?>`
* 视图名
  - 视图名可省略文件扩展名，这种情况下使用 .php 作为扩展， 视图名 about 对应到 about.php 文件名
  - 视图名以双斜杠 // 开头，对应的视图文件路径为 @app/views/ViewName， 也就是说视图文件在 yiibaseApplication::viewPath 路径下找， 例如 //site/about 对应到 @app/views/site/about.php
  - 视图名以单斜杠/开始，视图文件路径以当前使用模块 的 yiibaseModule::viewPath 开始， 如果不存在模块，使用@app/views/ViewName 开始，例如，如果当前模块为 user， /user/create 对应成 @app/modules/user/views/user/create.php, 如果不在模块中，/user/create 对应@app/views/user/create.php
* 数据
  - 推送：通过视图渲染方法的第二个参数传递数据
  - 拉取：视图从 yiibaseView 视图组件或其他对象中主动获得数据(如 Yii::$app)， 在视图中使用如下表达式$this->context 可获取到控制器
  - 共享数据：视图组件提供 yiibaseView::params 参数属性来让不同视图共享数据
* 布局: $content 变量代表当 `yii\base\Controller::render()` 控制器渲染方法调用时传递到布局的内容视图渲染结果
  - 数据
    - $this 对应和普通视图类似的 yiibaseView 视图组件
    - $content：包含调用 yiibaseController::render()方法渲染内容视图的结果
  - 嵌套布局
  - layout 可在不同层级（控制器、模块，应用）配置
    + 如果控制器的 yii\base\Controller::$layout 属性不为空，使用它作为布局的值， 控制器的 module模块 作为上下文模块
    + 如果 layout 为空，从控制器的祖先模块（包括应用） 开始找 第一个layout 属性不为空的模块，使用该模块作为上下文模块， 并将它的layout 的值作为布局的值， 如果都没有找到，表示不使用布局
* 视图事件
  - yiibaseView::EVENT_BEFORE_RENDER: 在控制器渲染文件开始时触发， 该事件可设置 yiibaseViewEvent::isValid 为 false 取消视图渲染。
  - yiibaseView::EVENT_AFTER_RENDER: 在布局中调用 yiibaseView::beginPage() 时触发， 该事件可获取 yiibaseViewEvent::output 的渲染结果，可修改该属性来修改渲染结果。
  - yiibaseView::EVENT_BEGIN_PAGE: 在布局调用 yiibaseView::beginPage() 时触发；
  - yiibaseView::EVENT_END_PAGE: 在布局调用 yiibaseView::endPage() 是触发；
  - yiiwebView::EVENT_BEGIN_BODY: 在布局调用 yiiwebView::beginBody() 时触发；
  - yiiwebView::EVENT_END_BODY: 在布局调用 yiiwebView::endBody() 时触发。
* `yii\helpers\Html`
  - encode:参数中可能隐含的恶意 JavaScript 代码导致跨站脚本（XSS）攻击,在页面进行处理
  - 显示 HTML 内容，先调用 yiihelpersHtmlPurifier 过滤内容:保证输出数据安全上做的不错，但性能不佳，如果你的应用需要高性能可考虑 缓存 过滤后的结果
* EntryForm：从用户那请求的数据

```php
# 嵌套布局
<?php $this->beginContent('@app/views/layouts/base.php'); ?>

...child layout content here...

<?php $this->endContent(); ?>

<?php $this->beginBlock('block1'); ?>

...content of block1...

<?php $this->endBlock(); ?>

<?php if (isset($this->blocks['block2'])): ?>
    <?= $this->blocks['block2'] ?>
<?php else: ?>
    ... default content for block2 ...
<?php endif; ?>

# 注册Meta元标签
<?php
$this->registerMetaTag(['name' => 'keywords', 'content' => 'yii, framework, php']);
?>
# 注册链接标签
$this->registerLinkTag([
    'title' => 'Live News for Yii',
    'rel' => 'alternate',
    'type' => 'application/rss+xml',
    'href' => 'http://www.yiiframework.com/rss.xml/',
]);
```

## Widget

* 在 视图 中使用的可重用单元，使用面向对象方式创建复杂和可配置用户界面单元
* 在视图中可调用 yii\base\Widget::widget() 方法使用小部件，使用 配置 数组初始化小部件并返回小部件渲染后的结果
* 创建
  - 继承 yii\base\Widget 类并覆盖 yii\base\Widget::init() 和/或 yii\base\Widget::run() 方法可创建小部件
  - 通常 init() 方法处理小部件属性， run() 方法包含小部件生成渲染结果的代码
  - 需要遵循 MVC 模式，通常逻辑代码在小部件类，展示内容在视图中
* 需要外部资源如 CSS, JavaScript图片等会比较棘手幸运的时候 Yii 提供资源包来解决这个问题
* 小部件设计时应是独立的：可以直接丢弃它而不需要额外的处理
* `yii\widgets\ActiveForm`:能将在模型中声明的验证规则转化成客户端 JavaScript 脚本去执行验证

```php
<?php
use yiiwidgetsActiveForm;
use yiihelpersHtml;
?>

<?php $form = ActiveForm::begin(['id' => 'login-form']); ?>

    <?= $form->field($model, 'username') ?>

    <?= $form->field($model, 'password')->passwordInput() ?>

    <div class="form-group">
        <?= Html::submitButton('Login') ?>
    </div>

<?php ActiveForm::end(); ?>

// 另外一种实现：begin() 时会创建一个新的小部件实例并在构造结束时调用init()方法， 在end()时会调用run()方法并输出返回结果
class HelloWidget extends Widget
{
    public function init()
    {
        parent::init();
        ob_start();
    }

    public function run()
    {
        $content = ob_get_clean();
        return Html::encode($content);
    }
}
<?php
use appcomponentsHelloWidget;
?>
<?php HelloWidget::begin(); ?>

    content that may contain <tag>

<?php HelloWidget::end(); ?>
```

## 模块（Modules）

* 模块是独立的软件单元，由模型, 视图, 控制器和其他支持组件组成
* 终端用户可以访问在应用主体中已安装的模块的控制器
* 模块被当成小应用主体来看待，和应用主体不同的是， 模块不能单独部署，必须属于某个应用主体
* 模块中控制器的路由必须以模块ID开始，接下来为控制器ID和操作ID
* 特性可分组，每个组包含一些强相关的特性， 每个特性组可以做成一个模块由特定的开发人员和开发组来开发和维护
* 模块可无限级嵌套，也就是说，模块可以包含另一个包含模块的模块

```php
// 配置
'modules' => [
        'debug' => 'yiidebugModule',
    ],
]

$module = MyModuleClass::getInstance();
// 获取ID为 "forum" 的模块
$module = Yii::$app->getModule('forum');

// 获取处理当前请求控制器所属的模块
$module = Yii::$app->controller->module;
```

## 缓存

* HttpCache利用Last-Modified 和 Etag HTTP头实现客户端缓存
* PageCache实现服务器端整个页面的缓存

## Asset

* 前端资源管理：资源包指定为继承 `yii\web\AssetBundle` 的PHP类，要指定资源所在位置，包含哪些CSS和JavaScript文件以及和其他包的依赖关系
  - 源资源: 资源文件和PHP源代码放在一起，不能被Web直接访问
  - 发布资源: 资源文件放在可通过Web直接访问的Web目录中
  - 外部资源: 资源文件放在你的Web应用不同的Web服务器上
* sourcePath: 指定包包含资源文件的根目录， 当资源文件不能被Web访问时该属性应设置
*
* basePath: 指定包含资源包中资源文件并可Web访问的目录，当指定 sourcePath 属性， 资源管理器 会发布包的资源到一个可Web访问并覆盖该属性
* baseUrl: 指定对应到yiiwebAssetBundle::basePath目录的URL
* js: 一个包含该资源包JavaScript文件的数组
* css: 一个包含该资源包JavaScript文件的数组
* jsOptions: 当调用yiiwebView::registerJsFile()注册该包 每个 JavaScript文件时， 指定传递到该方法的选项。
* cssOptions: 当调用yiiwebView::registerCssFile()注册该包 每个 css文件时， 指定传递到该方法的选项。
  - 有一定的先后顺序以避免属性覆盖
* 发布资源:为了使用源资源，要拷贝到一个可Web访问的Web目录中 成为发布资源.发布该包资源文件到Web目录时 指定传递到该方法的选项，仅在指定了yiiwebAssetBundle::sourcePath属性时使用
* 使用包 Bower 和/或 NPM管理
  - composer.json 文件将包列入require，应使用bower-asset/PackageName (Bower包) 或 npm-asset/PackageName (NPM包)来对应库
  - 创建一个资源包类并将你的应用或扩展要使用的JavaScript/CSS 文件列入到类中， 应设置 sourcePath 属性为@bower/jquery/dist
* Composer asset 插件
* 自定义：assetManager的应用组件实现[[yiiwebAssetManager] 来管理应用组件
* 转换:对于 CSS 代码可使用 LESS 或 SCSS， 对于 JavaScript 可使用 TypeScript
* 合并与压缩
  - 找出应用中所有想要合并和压缩的资源包
  - 将这些包分成一个或几个组，注意每个包只能属于其中一个组
  - 合并/压缩每个组里CSS文件到一个文件，同样方式处理JavaScript文件，
  - 为每个组定义新的资源包
    - 设置yiiwebAssetBundle::css 和 yiiwebAssetBundle::js 属性分别为压缩后的CSS和JavaScript文件
    - 自定义设置每个组内的资源包，设置资源包的yiiwebAssetBundle::css 和 yiiwebAssetBundle::js 属性为空, 并设置它们的 yiiwebAssetBundle::depends 属性为每个组新创建的资源包
* 命令：`yii asset/template assets.php`

```php
// 自定义配置
'assetManager' => [
    'bundles' => [
        'yiiwebJqueryAsset' => [
            'sourcePath' => null,   // 一定不要发布该资源
            'js' => [
                '//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js',
                YII_ENV_DEV ? 'jquery.js' : 'jquery.min.js'
            ],
        ],
        'all' => [
            'class' => 'yiiwebAssetBundle',
            'basePath' => '@webroot/assets',
            'baseUrl' => '@web/assets',
            'css' => ['all-xyz.css'],
            'js' => ['all-xyz.js'],
        ],
    ],
    'A' => ['css' => [], 'js' => [], 'depends' => ['all']],
    'B' => ['css' => [], 'js' => [], 'depends' => ['all']],
    'C' => ['css' => [], 'js' => [], 'depends' => ['all']],
    'D' => ['css' => [], 'js' => [], 'depends' => ['all']],
    'assetMap' => [
        'jquery.js' => '//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js',
    ],
    'converter' => [
        'class' => 'yiiwebAssetConverter',
        'commands' => [
            'less' => ['css', 'lessc {from} {to} --no-color'],
            'ts' => ['js', 'tsc --out {to} {from}'],
        ],
    ],
],

<?php

namespace frontend\assets;

use yii\web\AssetBundle;

class FontAwesomeAsset extends AssetBundle
{
    public $sourcePath = '@bower/font-awesome';
    public $css = [
        'css/font-awesome.min.css',
    ];
    public $publishOptions = [
        'only' => [
            'fonts/',
            'css/',
        ]
    ];
}

// 使用
use app/assets/AppAsset;
AppAsset::register($this);  // $this 代表视图对象

# 使用 asset-packagist 库
#  composer.json
"repositories": [
    {
        "type": "composer",
        "url": "https://asset-packagist.org"
    }
]

$config = [
    ...
    'aliases' => [
        '@bower' => '@vendor/bower-asset',
        '@npm'   => '@vendor/npm-asset',
    ],
    ...
];
```

## RESTful

* route
  - GET /users: 逐页列出所有用户
  - HEAD /users: 显示用户列表的概要信息
  - POST /users: 创建一个新用户
  - GET /users/123: 返回用户 123 的详细信息
  - HEAD /users/123: 显示用户 123 的概述信息
  - PATCH /users/123 and PUT /users/123: 更新用户123
  - DELETE /users/123: 删除用户123
  - OPTIONS /users: 显示关于末端 /users 支持的动词
  - OPTIONS /users/123: 显示有关末端 /users/123 支持的动词
* Authentication:无状态的， 因此这意味着不能使用 sessions && cookies
  - HTTP Basic Auth:access token 作为一个用户名被传递。这种情况只适合“当access token可以安全的存储在API 接收端”的情况， 比如 调用 API 的是一个在服务器上运行的程序
  - Query parameter:access token 在 API URL 中作为一个查询参数被传递，比如 <https://example.com/users?access-token=123456789> 因为多数的 Web 服务器会保存 query 参数在服务器日志中， 这个方法应该主要是用于响应无法使用 HTTP 头部信息来发送 access token 的 JSONP 请求的。
  - OAuth 2:遵照 OAth2.0 协议， 调用者从一个 授权服务器 上获取 access token， 再通过 HTTP Bearer Tokens 发送给 Api 服务器

```php
// app\controllers\UserController
namespace app\controllers;

use yii\rest\ActiveController;

class UserController extends ActiveController
{
    public $modelClass = 'app\models\User';
}

// config/main.php
'urlManager' => [
    'enablePrettyUrl' => true,
    'enableStrictParsing' => true,
    'showScriptName' => false,
    'rules' => [
        ['class' => 'yii\rest\UrlRule', 'controller' => 'user'],
    ],
]
'request' => [
    'parsers' => [
        'application/json' => 'yii\web\JsonParser',
    ]
]

curl -i -H "Accept:application/json" "http://api.yii.com/users"
curl -i -H "Accept:application/xml" "http://api.yii.com/users"

curl -i -H "Accept:application/json" -H "Content-Type:application/json" -XPOST "http://api.yii.com/users" -d '{"username": "henry", "email": "user@example.com"}'

users?page=2
users?fields=id,email // 指定默认包含到展现数组的字段集合
users?expand=profile // 指定由于终端用户的请求包含 expand 参数哪些额外的字段应被包含到展现数组
```

## Console

* 创建网站后台处理的任务

```sh
yii <route> [--option1=value1 --option2=value2 ... argument1 argument2 ...]

curl -L https://raw.githubusercontent.com/yiisoft/yii2/master/contrib/completion/bash/yii -o /etc/bash_completion.d/yii

mkdir -p ~/.zsh/completion
curl -L https://raw.githubusercontent.com/yiisoft/yii2/master/contrib/completion/zsh/_yii -o ~/.zsh/completion/_yii

# config
fpath=(~/.zsh/completion $fpath)

autoload -Uz compinit && compinit -i
exec $SHELL -l
```

## DB

* ActiveRecord：提供了一个面向对象的接口， 用以访问和操作数据库中的数据
  - Active Record 类与数据库表关联， Active Record 实例对应于该表的一行， Active Record 实例的属性表示该行中特定列的值
  - 可以访问 Active Record 属性并调用 Active Record 方法来访问和操作存储在数据库表中的数据， 而不用编写原始 SQL 语句
  - Querying Data
    + yii\db\ActiveRecord::find() 方法创建一个新的查询生成器对象
    + 查询生成器的构建方法来 构建查询
    + 查询生成器的查询方法来取出数据到 Active Record 实例中
      * yii\db\ActiveRecord::findOne()：返回一个 Active Record 实例，填充于查询结果的第一行数据
      * yii\db\ActiveRecord::findAll()：返回一个 Active Record 实例的数据，填充于查询结果的全部数据
      * 传参
        - 标量值：当作主键去查询。 Yii 会通过读取数据库模式信息来识别主键列
        - 标量值的数组：数组里的值都当作要查询的主键的值
        - 关联数组：键值是表的列名，元素值是相应的要查询的条件值
    + yii\db\ActiveRecord::findBySql()
    + 批处理查询 来最小化内存使用
  - Accessing Data:查询结果的每一行对应于单个 Active Record 实例,属性以表的列名命名
    + Data Transformation：要输入或显示的数据是一种格式，而要将其存储在数据库中是另一种格式
  - Saving Data
  - Data Validation：因为 yii\db\ActiveRecord 继承于 yii\base\Model，共享相同的 输入验证 功能
    + 可以通过重写 rules() 方法声明验证规则并执行
    + 调用 save() 时，默认情况下会自动调用 validate()。 只有当验证通过时，它才会真正地保存数据; 否则将简单地返回 false， 您可以检查 errors 属性来获取验证过程的错误消息
  - Massive Assignment
  - updateCounters() 更新一个或多个计数列
  - Dirty Attributes：如果一个属性的值已被修改，则会被认为是 脏，调用 save() 保存 Active Record 实例时，只有 脏属性 被保存
* transaction
* 关联数据
  - 声明关联关系（Declaring Relations）：关联方法必须这样命名：getXyz。然后通过 xyz（首字母小写）调用这个关联名
  - 数组的值填的是主数据的列（当前要声明关联的 Active Record 类为主数据）， 而数组的键要填的是相关数据的列
* JOIN 查询

```php
self::find()
    ->select([ 'title', "DATE_FORMAT(raw_add_time,'%Y-%m-%d') as raw_add_time"])
    ->where(['type' => '0'])
    ->orderBy('`sort` asc, `raw_update_time` DESC')
    ->limit(6)
    ->asArray()
    ->all();

User::findOne(1);  # 返回 主键 id=1 的一条数据(举个例子)；
User::findAll([100, 101, 123, 124]);
User::findOne([
    'id' => 123,
    'status' => Customer::STATUS_ACTIVE,
]);

User::find()->count();  # 返回记录的数量；
User::find()->average();  # 返回指定列的平均值；
User::find()->min();  # 返回指定列的最小值 ；
User::find()->max();  # 返回指定列的最大值 ；
User::find()->scalar();  # 返回值的第一行第一列的查询结果；
User::find()->column();  # 返回查询结果中的第一列的值；
User::find()->exists();  # 返回一个值指示是否包含查询结果的数据行；

// 每次获取 10 条客户数据
foreach (Customer::find()->batch(10) as $customers) {
    // $customers 是个最多拥有 10 条数据的数组
}

// 每次获取 10 条客户数据，然后一条一条迭代它们
foreach (Customer::find()->each(10) as $customer) {
    // $customer 是个 `Customer` 对象
}

// 贪婪加载模式的批处理查询
foreach (Customer::find()->with('orders')->each() as $customer) {
    // $customer 是个 `Customer` 对象，并附带关联的 `'orders'`
}

User::find()->where(['name' => '小伙儿'])->one();  # 返回 ['name' => '小伙儿'] 的一条数据；
User::find()->where(['name' => '小伙儿'])->all();  # 返回 ['name' => '小伙儿'] 的所有数据；
User::find()->andWhere(['sex' => '男', 'age' => '24'])->count('id');  # 统计符合条件的总条数；
User::find()->andFilterWhere(['like', 'name', '小伙儿']);  # 用 like 查询 name 等于 小伙儿的 数据
User::find()->andFilterWhere(['>', 'id', 10]);  # 用 id > 10的 数据

User::find()->orderBy('id DESC')->all();  # 是排序查询；
User::find()->select('count(*)')->where(['user_id' => $userId, 'status' => 0])->scalar();

User::findBySql('SELECT * FROM user')->all();  # 是用 sql 语句查询 user 表里面的所有数据；
User::findBySql('SELECT * FROM customer WHERE status=:user', [':status' => Customer::STATUS_INACTIVE])->all();

$values = [
    'name' => 'James',
    'email' => 'james@example.com',
];
$customer = new Customer();
$customer->attributes = $values;
$customer->save();

save()
geterrors # return bool 获取错误信息

// UPDATE `post` SET `view_count` = `view_count` + 1 WHERE `id` = 100
$post->updateCounters(['view_count' => 1]);

$customer = Customer::findOne(123);
$customer->delete();


$customer = Customer::findOne(123);

Customer::getDb()->transaction(function($db) use ($customer) {
    $customer->id = 200;
    $customer->save();
    // ...其他 DB 操作...
});
// 或者
$transaction = $connection->beginTransaction();
try {
    $connection->createCommand($sql1)->execute();
    $connection->createCommand($sql2)->execute();
    //.... other SQL executions
    $transaction->commit();
} catch (\Exception $e) {
    $transaction->rollBack();
    throw $e;
} catch (\Throwable $e) {
    $transaction->rollBack();
    throw $e;
}
# rollback 会占id

# 一个客户可以有很多订单，而每个订单只有一个客户
class Customer extends ActiveRecord
{
    // ...

    public function getOrders()
    {
        return $this->hasMany(Order::className(), ['customer_id' => 'id']);
    }

    public function getBigOrders($threshold = 100) // 老司机的提醒：$threshold 参数一定一定要给个默认值
    {
        return $this->hasMany(Order::className(), ['customer_id' => 'id'])
            ->where('subtotal > :threshold', [':threshold' => $threshold])
            ->orderBy('id');
    }
}

class Order extends ActiveRecord
{
    // ...

    public function getCustomer()
    {
        return $this->hasOne(Customer::className(), ['id' => 'customer_id']);
    }
}

$customers = Customer::find()
    ->joinWith('orders')
    ->where(['order.status' => Order::STATUS_ACTIVE])
    ->all();
```

## 安全

### csrf

* request中生存token字段：获取一个32位的随机字符串，并存入cookie或session，生成token
* 加密替换操作，生成加密后_csrfToken，这个是传给浏览器的token. 先随机产生CSRF_MASK_LENGTH(Yii2里默认是8位)长度的字符串 mask：`str_replace('+', '.', base64_encode($mask . $this->xorTokens($token, $mask))); $this->xorTokens($arg1,$arg2)`
* 在controller.php里调用request.php里的validateCsrfToken
* 当页面整体被缓存后，token也被缓存导致验证失败，一种常见的解决思路是每次提交前重新获取token,这样就可以通过验证了。

### Cookie and Session

* Cookie通过\Yii::$app->response->getCookies()->add()添加Cookie，通过\Yii::$app->request->cookies读取Cookie.
* 通过\Yii::$app->session进行操作

```php
//第一种方法
$cookie = new \yii\web\Cookie();
$cookie -> name = 'smister';        //cookie的名称
$cookie -> expire = time() + 3600;     //存活的时间
$cookie -> httpOnly = true;        //无法通过js读取cookie
$cookie -> value = 'cookieValue';      //cookie的值
\Yii::$app->response->getCookies()->add($cookie);

//第二种方法
$cookie = new \yii\web\Cookie([
    ‘name’ => ‘smister’,
    ‘expire’ => time() + 3600,
    ‘httpOnly ’ => true,
    ‘value’ => ‘cookieValue’
]);
\Yii::$app->response->getCookies()->add($cookie);

$cookie = \Yii::$app->request->cookies;
//返回一个\yii\web\Cookie对象
$cookie->get(‘smister’);
//直接返回Cookie的值
$cookie->getValue(‘smister’); //$cookie[‘smister’] 其实这样也是可以读取的
//判断一个Cookie是否存在
$cookie->has(‘smister’);
//读取Cookie的总数
$cookie->count();//$cookie->getCount();跟count一样
//移除一个Cookie对象
\Yii::$app->response->getCookies()->remove($cookie);
//移除所有Cookie，目前好像不太好使
\Yii::$app->response->getCookies()->removeAll();

$session = \Yii::$app->session;
$session->set('smister_name' , 'myname');
$session->set('smister_array' ,[1,2,3]);

$session->get('smister_name');
//删除一个session
$session->remove(‘smister_name’);
//删除所有session
$session->removeAll();
?>
```

### Url

* base输出根目录
* home是输出首页
* current当前的Url
* to和toRoute都是生成Url , 后面加true都是生成带域名的Url.to和toRoute之间的区别, 传入string时 , to会直接把string当成url, toRoute则会解析

```php
// 以http://localhost:8080/yii2-demo/web/index.php?r=article/index为例
echo \yii\helpers\Url::base(); //输出/yii2-demo/web
echo \yii\helpers\Url::base(true); // 输出http://localhost:8080/yii2-demo/web

echo \yii\helpers\Url::home();//输出/yii2-demo/web/index.php
echo \yii\helpers\Url::home(true);//输出http://localhost:8080/yii2-demo/web/index.php

echo \yii\helpers\Url::current();//输出/yii2-demo/web/index.php?r=article/index

echo \yii\helpers\Url::to(['article/add']); //输出/yii2-demo/web/index.php?r=article/add
echo \yii\helpers\Url::to(['article/edit' , 'id' => 1]); //输出/yii2-demo/web/index.php?r=article/add&id=1
echo \yii\helpers\Url::to(['article/add'] , true); //输出http://localhost:8080/yii2-demo/web/index.php?r=article/add
echo \yii\helpers\Url::to(['article/edit' , 'id' => 1] , true); //输出http://localhost:8080/yii2-demo/web/index.php?r=article/add&id=1

echo \yii\helpers\Url::toRoute(['article/add']); //输出/yii2-demo/web/index.php?r=article/add
echo \yii\helpers\Url::toRoute(['article/edit' , 'id' => 1]); //输出/yii2-demo/web/index.php?r=article/add&id=1
echo \yii\helpers\Url::toRoute(['article/add'] , true); //输出http://localhost:8080/yii2-demo/web/index.php?r=article/add
echo \yii\helpers\Url::toRoute(['article/edit' , 'id' => 1] , true); //输出http://localhost:8080/yii2-demo/web/index.php?r=article/add&id=1

echo \yii\helpers\Url::to('article/add'); //输出article/add
echo \yii\helpers\Url::toRoute('article/add'); //输出/yii2-demo/web/index.php?r=article/add
```

UploadForm UploadedFile

## User login

## User role control

## session stay

browser reopen generate new cookie

## 源码

* yii\base\Object:轻量级基类。表示基本的数据结构：init()
* yii\base\Compontent：继承Object,进一步支持 事件与行为
* Path Alias:@开头
* \yii\web\View
* yii\base\Model:rules scenarios
* yii\web\Controller:return渲染内容，而非echo
* yii\base\ActionFilter:动作过滤器
* yii\base\Widget

```php
$event = new \yii\base\Event;$compontent->trigger($eventName, $event);

$compontent->on($eventName, $handler);
```

## RBAC

* add authManager
* `./yii migrate --migrationPath=@yii/rbac/migrations/`

```php
// console->config->main.php->compontent
// backend->config->main.php->compontent
'authManager' => [
    'class' => 'yii\rbac\DbManager',
    'itemTable' => '{{%auth_item}}',
    'itemChildTable' => '{{%auth_item_child}}',
    'assignmentTable' => '{{%auth_assignment}}',
    'ruleTable' => '{{%auth_rule}}'
],
```

## faker

* config
* use

## Extension

* 随时可拿来使用的， 并可重发布的软件包
* 创建
  - 按照 Composer package 的条款创建扩展
  - 包名 myname/yii2-mywidget
  - 包类型  yii2-extension
  - 依赖: 肯定有 yiisoft/yii2
* [yii2-gii](https://github.com/yiisoft/yii2-gii):Yii 2 Gii Extension
* [yii2-debug](https://github.com/yiisoft/yii2-debug):Debug Extension for Yii 2 <http://www.yiiframework.com>
* [yii2-httpclient](https://github.com/yiisoft/yii2-httpclient)
* [yii2-authclient](https://github.com/yiisoft/yii2-authclient)
* [yii2-queue](https://github.com/yiisoft/yii2-queue)
* [yii2-coding-standards](https://github.com/yiisoft/yii2-coding-standards)
* [yii2-collection](https://github.com/yiisoft/yii2-collection)
* [yii2-redis](https://github.com/yiisoft/yii2-redis)
* [yii2-bootstrap](https://github.com/yiisoft/yii2-bootstrap)
* [yii2-shell](https://github.com/yiisoft/yii2-shell)
* [yii2-bootstrap4](https://github.com/yiisoft/yii2-bootstrap4)
* [log](https://github.com/yiisoft/log)
* [yii2-elasticsearch](https://github.com/yiisoft/yii2-elasticsearch)
* [yii2-sphinx](https://github.com/yiisoft/yii2-sphinx):Yii 2 Sphinx extension. <http://www.yiiframework.com>
* [yii2-jui](https://github.com/yiisoft/yii2-jui):Yii 2 JQuery UI extension.
* [yii2-file-upload-widget](https://github.com/2amigos/yii2-file-upload-widget):BlueImp File Upload Widget for Yii2
* [yii2-ace-admin](https://github.com/myloveGy/yii2-ace-admin) `composer require dmstr/yii2-adminlte-asset`
* [yii2-docker](https://github.com/yiisoft/yii2-docker):Official Docker images suitable for Yii 2.0 <https://www.yiiframework.com/>

```sh
composer require --prefer-dist yiisoft/yii2-sphinx
```

## Yii1.1

* route
* cookie pass parameters
* front get back parameters

## Yii3

* [yii-dev-tool](https://github.com/yiisoft/yii-dev-tool):Development environment for Yii 3 packages <https://www.yiiframework.com/>
* [docs](https://github.com/yiisoft/docs):Various Yii 3.0 related documentation <http://www.yiiframework.com>

## 项目

* [rageframe2](https://github.com/jianyan74/rageframe2):一个基于Yii2高级框架的快速开发应用引擎 www.rageframe.com
* [yii2-app-basic](https://github.com/yiisoft/yii2-app-basic):Yii 2.0 Basic Application Template <http://www.yiiframework.com>
* [yii2-app-advanced](https://github.com/yiisoft/yii2-app-advanced):Yii 2.0 Advanced Application Template <http://www.yiiframework.com>
* [yii2_fecshop](https://github.com/fecshop/yii2_fecshop):yii2 ( PHP ) fecshop core code used for ecommerce shop 多语言多货币多入口的开源电商 B2C 商城，支持移动端vue, app, html5 <http://www.fecshop.com>
* [Shop-PHP-Yii2](https://github.com/EleTeam/Shop-PHP-Yii2):EleTeam开源项目-电商全套解决方案之PHP版-Shop-for-PHP-Yii2。一个类似京东/天猫/淘宝的商城，有对应的APP支持，由EleTeam团队维护！
* [yii2cms](https://github.com/changchang700/yii2cms):一款和layui搭配的后台管理cms，集成了权限、用户、配置等常用功能，你可以在这些基础上修改。
* [yii2-starter-kit](https://github.com/yii2-starter-kit/yii2-starter-kit):Yii2 Starter Kit <http://yii2-starter-kit.terentev.net>
* [vue-in-yii2](https://github.com/TIGERB/vue-in-yii2):a whole framework which use vuejs in frontend and light-yii2 in backend

## 参考

* [yii2-apidoc](https://github.com/yiisoft/yii2-apidoc)
* [深入理解 Yii2.0](http://www.digpage.com/index.html) <https://www.kancloud.cn/kancloud/yii-in-depth>
* [yii2-2.0.3-annotated](https://github.com/CraryPrimitiveMan/yii2-2.0.3-annotated):带有详细注释的 yii2 2.0.3 代码。
* [OnlineCourses](https://github.com/CraryPrimitiveMan/OnlineCourses):An online courses website based on yii2
* [awesome-yii2](https://github.com/forecho/awesome-yii2)

* [多语言版本切换](https://blog.csdn.net/u012979009/article/details/51697969)
* [RESTful API 快速搭建教程](https://www.yiichina.com/tutorial/1606)
* [RESTful API 认证教程](https://www.yiichina.com/tutorial/1770)
* [csrf 验证原理分析及 token 缓存解决方案](https://www.yiichina.com/code/1695)
* [Yii Tutorial](https://www.tutorialspoint.com/yii/index.htm)
* [Yii框架](https://blog.csdn.net/u012979009/article/category/6202463/2)
