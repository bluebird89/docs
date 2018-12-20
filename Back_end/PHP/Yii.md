# [yiisoft/yii2](https://github.com/yiisoft/yii2)

Yii 2: The Fast, Secure and Professional PHP Framework <http://www.yiiframework.com>

## [yiisoft/yii2-app-advanced](https://github.com/yiisoft/yii2-app-advanced)

Yii 2.0 Advanced Application Template

```sh
composer global require "fxp/composer-asset-plugin:^1.2.0"
composer create-project --prefer-dist yiisoft/yii2-app-basic basic
composer create-project --prefer-dist yiisoft/yii2-app-advanced yii-application

composer install
php requirements.php

vim common/config/main-local.php # components['db'] 配置
yii migrate # 生成数据表
# 断言测试
```

## 搭建服务

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

* 用户提交指向 入口脚本 web/index.php 的请求。
* 入口脚本会加载 配置数组 并创建一个 应用 实例用于处理该请求。
    - preInit()（预初始化）方法，配置一些高优先级的应用属性
    - 注册yiibaseApplication::errorHandler。
    - 通过给定的应用配置初始化应用的各属性。
    - 通过调用 yiibaseApplication::init()（初始化）方法，它会顺次调用 yiibaseApplication::bootstrap() 从而运行引导组件。
       - 加载扩展清单文件(extension manifest file) vendor/yiisoft/extensions.php。
       - 创建并运行各个扩展声明的 引导组件（bootstrap components）。
       - 创建并运行各个 应用组件 以及在应用的 Bootstrap 属性中声明的各个 模块（modules）组件（如果有）。
* 应用会通过 request（请求） 应用组件解析被请求的 路由。
* 应用创建一个 controller（控制器） 实例具体处理请求。
* 控制器会创建一个 action（动作） 实例并为该动作执行相关的 Filters（访问过滤器）。
* 如果任何一个过滤器验证失败，该动作会被取消。
* 如果全部的过滤器都通过，该动作就会被执行。
* 动作会加载一个数据模型，一般是从数据库中加载。
* 动作会渲染一个 View（视图），并为其提供所需的数据模型。
* 渲染得到的结果会返回给 response（响应） 应用组件。
* 响应组件会把渲染结果发回给用户的浏览器。

## 原理

-   入口文件
-   application:配置主体属性->init(bootstrap)->run
-   主体属性
    -   id：用来区分其他应用的唯一标识 ID
    -   basePath：该应用的根目录
    -   aliases:用一个数组定义多个 别名
    -   bootstrap:
        -   启动阶段组件或模块 ID,声明 module 的 key，modules 中声明详细加载的模块：如果模块 ID 和应用组件 ID 同名，优先使用应用组件 ID，如果你想用模块 ID，可以使用如下无名称函数返回模块 ID
        -   类名
        -   配置数组
        -   匿名函数
    -   catchAll：要处理所有用户请求的 控制器方法，通常在维护模式下使用，同一个方法处理所有用户请求。
    -   components:注册多个在其他地方使用的 应用组件,注册过程.部署一组提供各种不同功能的 应用组件 来处理请求
        -   每一个应用组件指定一个 key-value 对的数组，key 代表组件 ID， value 代表组件类名或 配置。
        -   在应用中可以任意注册组件，并可以通过表达式 \\Yii::$app->ComponentID 全局访问。
    -   controllerMap:指定一个控制器 ID 到任意控制器类,打破默认的控制器对应规则
    -   controllerNamespace:指定控制器类默认的命名空间
    -   sourceLanguage:该属性指定应用代码的语言
    -   language：指定应用展示给终端用户的语言，默认为 en 标识英文
    -   name:想展示给终端用户的应用名称，不同于需要唯一性的 yiibaseApplication::id 属性， 该属性可以不唯一，该属性用于显示应用的用途。
    -   modules:指定应用所包含的模块配置
    -   params:全局参数 \\Yii::$app->params['thumbnail.size']
    -   version
    -   charset
    -   defaultRoute
        -   web:site/index
        -   console:help/index
    -   extensions
    -   layout:false 关闭 默认 main
    -   layoutPath:默认的布局路径别名为@app/views/layouts
    -   runtimePath
    -   viewPath
    -   vendorPath
    -   enableCoreCommands
-   事件属性
    -   on beforeRequest\\afterRequest
    -   on beforeAction\\afterAction

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

        // 无名称函数
        function () {
            return new appcomponentsProfiler();
        }，

        function () {
            return Yii::$app->getModule('user');
        },

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

        'defaultRoute' => 'main',
        // 全拦截路由
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
                'account' => 'appcontrollersUserController',
                'article' => [
                    'class' => 'appcontrollersPostController',
                    'enableCsrfValidation' => false,
                ],
            ],
        ],

        'modules' => [
            // "booking" 模块以及对应的类
            'booking' => 'appmodulesbookingBookingModule',

            // "comment" 模块以及对应的配置数组
            'comment' => [
                'class' => 'appmodulescommentCommentModule',
                'db' => 'db',
            ],
        ],

        'timeZone' => 'America/Los_Angeles',
        'extensions' => [
        [
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
        'on afterAction' => function ($event) {
            if (some condition) {
                // 修改 $event->result
            } else {
            }
        },
    ]

    if (YII_ENV_DEV) {
        // configuration adjustments for 'dev' environment
        $config['bootstrap'][] = 'debug';
        $config['modules']['debug'] = 'yiidebugModule';

        $config['bootstrap'][] = 'gii';
        $config['modules']['gii'] = 'yiigiiModule';
    }
```

## 模型

-   属性: 代表可像普通类属性或数组一样被访问的业务数据;yiibaseModel::attributes() 指定模型所拥有的属性。
    -   ContactForm 模型类有四个属性 name, email, subject and body， ContactForm 模型用来代表从 HTML 表单获取的输入数据
-   属性标签: 指定属性显示出来的标签; username 转换为 Username， firstNam 转换为 First Name
-   场景：模型支持的场景由模型中申明的 验证规则 来决定
-   块赋值: 只用一行代码将用户所有输入填充到一个模型，将输入数据对应填充到 yiibaseModel::attributes 属性
-   验证规则: 确保输入数据符合所申明的验证规则;
-   数据导出: 允许模型数据导出为自定义格式的数组
-   ActiveRecord

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

// 用户输入数据赋值到模型属性
$model->attributes = Yii::$app->request->post('ContactForm');

if ($model->validate()) {
    // 所有输入数据都有效 all inputs are valid
} else {
    // 验证失败：$errors 是一个包含错误信息的数组
    $errors = $model->errors;
}
```

## component

-   yiiwebAssetManager: 管理资源包和资源发布
-   yiidbConnection: 代表一个可以执行数据库操作的数据库连接， 注意配置该组件时必须指定组件类名和其他相关组件属性，如 yiidbConnection::dsn
-   yiibaseApplication::errorHandler: 处理 PHP 错误和异常
-   yiii18nFormatter: 格式化输出显示给终端用户的数据，例如数字可能要带分隔符， 日期使用长格式
-   yiii18nI18N: 支持信息翻译和格式化
-   yiilogDispatcher: 管理日志对象
-   yiiswiftmailerMailer: 支持生成邮件结构并发送
-   yiibaseApplication::request: 代表从终端用户处接收到的请求
-   yiibaseApplication::response: 代表发送给用户的响应
-   yiiwebSession: 代表会话信息，仅在 yiiwebApplication 网页应用中可用
-   yiiwebUrlManager: 支持 URL 地址解析和创建
-   yiiwebUser: 代表认证登录用户信息，仅在 yiiwebApplication 网页应用中可用
-   yiiwebView: 支持渲染视图

## 控制器

-   控制器：很精练，包含的操作代码简短
    -   article 对应 app/controllers/ArticleController;
    -   post-comment 对应 app/controllers/PostCommentController;
    -   admin/post-comment 对应 app/controllers/admin/PostCommentController;
    -   adminPanels/post-comment 对应 app/controllers/adminPanels/PostCommentController.
-   操作 ID：总是被以小写处理，如果一个操作 ID 由多个单词组成，单词之间将由连字符连接（如 create-comment）。
    -   操作 ID 映射为方法名时移除了连字符，将每个单词首字母大写，并加上 action 前缀。 例子：操作 ID create-comment 相当于方法名 actionCreateComment。
    -   默认操作默认为 index，如果想修改默认操作，只需简单地在控制器类中覆盖这个属性
-   内联操作:独立操作通过继承 yiibaseAction 或它的子类来定义。 例如 Yii 发布的 yiiwebViewAction 和 yiiwebErrorAction 都是独立操作
    -   通过控制器中覆盖 yiibaseController::actions()方法在 action map 中申明
-   过滤器
    -   beforeAction
    -   afterAction
- yiifiltersCors 应在 授权 / 认证 过滤器之前定义，以保证CORS头部被发送。

```php
namespace app/components;

use Yii;
use yiibaseActionFilter;

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
                rules' => [
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
```

## 视图

-   组织：@app/views/ControllerID 目录下
-   控制器中渲染
    -   yiibaseController::render(): 渲染一个 视图名 并使用一个 布局 返回到渲染结果。
    -   yiibaseController::renderPartial(): 渲染一个 视图名 并且不使用布局。
    -   yiiwebController::renderAjax(): 渲染一个 视图名 并且不使用布局， 并注入所有注册的 JS/CSS 脚本和文件，通常使用在响应 AJAX 网页请求的情况下。
    -   yiibaseController::renderFile(): 渲染一个视图文件目录或别名下的视图文件。
-   视图中渲染
    -   yiibaseView::render(): 渲染一个 视图名.
    -   yiiwebView::renderAjax(): 渲染一个 视图名 并注入所有注册的 JS/CSS 脚本和文件，通常使用在响应 AJAX 网页请求的情况下。
    -   yiibaseView::renderFile(): 渲染一个视图文件目录或别名下的视图文件。`<?= $this->render('_overview') ?>`
-   视图名
    -   视图名可省略文件扩展名，这种情况下使用 .php 作为扩展， 视图名 about 对应到 about.php 文件名
    -   视图名以双斜杠 // 开头，对应的视图文件路径为 @app/views/ViewName， 也就是说视图文件在 yiibaseApplication::viewPath 路径下找， 例如 //site/about 对应到 @app/views/site/about.php
    -   视图名以单斜杠/开始，视图文件路径以当前使用模块 的 yiibaseModule::viewPath 开始， 如果不存在模块，使用@app/views/ViewName 开始，例如，如果当前模块为 user， /user/create 对应成 @app/modules/user/views/user/create.php, 如果不在模块中，/user/create 对应@app/views/user/create.php
-   数据
    -   推送：渲染视图时传递参数
    -   拉取：视图从 yiibaseView 视图组件或其他对象中主动获得数据(如 Yii::$app)， 在视图中使用如下表达式$this->context 可获取到控制器
    -   共享数据：视图组件提供 yiibaseView::params 参数属性来让不同视图共享数据
-   布局
    -   数据：
        -   $this 对应和普通视图类似的 yiibaseView 视图组件
        -   $content：包含调用 yiibaseController::render()方法渲染内容视图的结果。
    -   嵌套布局
-   视图事件
    -   yiibaseView::EVENT_BEFORE_RENDER: 在控制器渲染文件开始时触发， 该事件可设置 yiibaseViewEvent::isValid 为 false 取消视图渲染。
    -   yiibaseView::EVENT_AFTER_RENDER: 在布局中调用 yiibaseView::beginPage() 时触发， 该事件可获取 yiibaseViewEvent::output 的渲染结果，可修改该属性来修改渲染结果。
    -   yiibaseView::EVENT_BEGIN_PAGE: 在布局调用 yiibaseView::beginPage() 时触发；
    -   yiibaseView::EVENT_END_PAGE: 在布局调用 yiibaseView::endPage() 是触发；
    -   yiiwebView::EVENT_BEGIN_BODY: 在布局调用 yiiwebView::beginBody() 时触发；
    -   yiiwebView::EVENT_END_BODY: 在布局调用 yiiwebView::endBody() 时触发。
-   视图组件：components 中配置
-   yiihelpersHtml
    -   encode:参数中可能隐含的恶意 JavaScript 代码导致跨站脚本（XSS）攻击,在页面进行处理
    -   显示 HTML 内容，先调用 yiihelpersHtmlPurifier 过滤内容:保证输出数据安全上做的不错，但性能不佳，如果你的应用需要高性能可考虑 缓存 过滤后的结果。
-   EntryForm：从用户那请求的数据

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

## 缓存

* HttpCache利用Last-Modified 和 Etag HTTP头实现客户端缓存
* PageCache实现服务器端整个页面的缓存

## widget

在 视图 中使用的可重用单元，使用面向对象方式创建复杂和可配置用户界面单元

ActiveForm
Menu

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

    content that may contain <tag>'s

<?php HelloWidget::end(); ?>
```

## Module

debug
gii

* 模块是独立的软件单元，由模型, 视图, 控制器和其他支持组件组成，
* 终端用户可以访问在应用主体中已安装的模块的控制器，
* 模块被当成小应用主体来看待，和应用主体不同的是， 模块不能单独部署，必须属于某个应用主体。
* 模块中控制器的路由必须以模块ID开始，接下来为控制器ID和操作ID
* 特性可分组，每个组包含一些强相关的特性， 每个特性组可以做成一个模块由特定的开发人员和开发组来开发和维护。

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

## Asset

前端资源管理：资源包指定为继承yiiwebAssetBundle的PHP类，要指定资源所在位置，包含哪些CSS和JavaScript文件以及和其他包的依赖关系。

源资源: 资源文件和PHP源代码放在一起，不能被Web直接访问.为了使用这些源资源，它们要拷贝到一个可Web访问的Web目录中 成为发布的资源,这个过程称为发布资源
发布资源: 资源文件放在可通过Web直接访问的Web目录中
外部资源: 资源文件放在你的Web应用不同的Web服务器上

* sourcePath: 指定包包含资源文件的根目录， 当资源文件不能被Web访问时该属性应设置
* basePath: 指定包含资源包中资源文件并可Web访问的目录，当指定sourcePath 属性， 资源管理器 会发布包的资源到一个可Web访问并覆盖该属性
* baseUrl: 指定对应到yiiwebAssetBundle::basePath目录的URL
* js: 一个包含该资源包JavaScript文件的数组
* css: 一个包含该资源包JavaScript文件的数组
* jsOptions: 当调用yiiwebView::registerJsFile()注册该包 每个 JavaScript文件时， 指定传递到该方法的选项。
* cssOptions: 当调用yiiwebView::registerCssFile()注册该包 每个 css文件时， 指定传递到该方法的选项。
    - 有一定的先后顺序以避免属性覆盖
* publish：发布该包资源文件到Web目录时 指定传递到该方法的选项，仅在指定了yiiwebAssetBundle::sourcePath属性时使用。
* 使用包Bower 和/或 NPM管理
    - composer.json 文件将包列入require，应使用bower-asset/PackageName (Bower包) 或 npm-asset/PackageName (NPM包)来对应库
    - 创建一个资源包类并将你的应用或扩展要使用的JavaScript/CSS 文件列入到类中， 应设置 sourcePath 属性为@bower/jquery/dist
* 自定义：assetManager的应用组件实现[[yiiwebAssetManager] 来管理应用组件
* 转换
* 合并与压缩
    - 找出应用中所有你想要合并和压缩的资源包，
    - 将这些包分成一个或几个组，注意每个包只能属于其中一个组，
    - 合并/压缩每个组里CSS文件到一个文件，同样方式处理JavaScript文件，
    - 为每个组定义新的资源包：
        - 设置yiiwebAssetBundle::css 和 yiiwebAssetBundle::js 属性分别为压缩后的CSS和JavaScript文件；
        - 自定义设置每个组内的资源包，设置资源包的yiiwebAssetBundle::css 和 yiiwebAssetBundle::js 属性为空, 并设置它们的 yiiwebAssetBundle::depends 属性为每个组新创建的资源包。
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

/**
 * Main frontend application asset bundle.
 */
class AppAsset extends AssetBundle
{
    public $basePath = '@webroot';
    public $baseUrl = '@web';
    public $css = [
        'css/site.css',
    ];
    public $js = [
        'js/jquery.cookie.js',
    ];
    public $depends = [
        'yii\web\YiiAsset',
        'yii\bootstrap\BootstrapAsset',
    ];
}

// 使用
use app/assets/AppAsset;
AppAsset::register($this);  // $this 代表视图对象
```

## RESTful

* GET /users: 逐页列出所有用户
* HEAD /users: 显示用户列表的概要信息
* POST /users: 创建一个新用户
* GET /users/123: 返回用户 123 的详细信息
* HEAD /users/123: 显示用户 123 的概述信息
* PATCH /users/123 and PUT /users/123: 更新用户123
* DELETE /users/123: 删除用户123
* OPTIONS /users: 显示关于末端 /users 支持的动词
* OPTIONS /users/123: 显示有关末端 /users/123 支持的动词

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

## 数据库

geterrors

```php
User::find()->one();  # 此方法返回一条数据；
User::find()->all();  # 此方法返回所有数据；
User::find()->count();  # 此方法返回记录的数量；
User::find()->average();  # 此方法返回指定列的平均值；
User::find()->min();  # 此方法返回指定列的最小值 ；
User::find()->max();  # 此方法返回指定列的最大值 ；
User::find()->scalar();  # 此方法返回值的第一行第一列的查询结果；
User::find()->column();  # 此方法返回查询结果中的第一列的值；
User::find()->exists();  # 此方法返回一个值指示是否包含查询结果的数据行；
User::find()->batch(10);  # 每次取 10 条数据
User::find()->each(10);  # 每次取 10 条数据， 迭代查询
User::findOne($id);  # 此方法返回 主键 id=1 的一条数据(举个例子)；

User::find()->where([‘name‘ => ‘小伙儿‘])->one();  # 此方法返回 [‘name‘ => ‘小伙儿‘] 的一条数据；
User::find()->where([‘name‘ => ‘小伙儿‘])->all();  # 此方法返回 [‘name‘ => ‘小伙儿‘] 的所有数据；
User::find()->andWhere([‘sex‘ => ‘男‘, ‘age‘ => ‘24‘])->count(‘id‘);  # 统计符合条件的总条数；
User::find()->andFilterWhere([‘like‘, ‘name‘, ‘小伙儿‘]);  # 此方法是用 like 查询 name 等于 小伙儿的 数据
User::find()->andFilterWhere(['>', 'id', 10]);  # 此方法是用 id > 10的 数据

User::find()->orderBy(‘id DESC‘)->all();  # 此方法是排序查询；
User::find()->select('count(*)')->where(['user_id' => $userId, 'status' => 0])->scalar();

User::findBySql(‘SELECT * FROM user‘)->all();  # 此方法是用 sql 语句查询 user 表里面的所有数据；
User::findBySql(‘SELECT * FROM user‘)->one();  # 此方法是用 sql 语句查询 user 表里面的一条数据；
```

## REST

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

## Yii1.1

* route
* cookie pass parameters
* front get back parameters

## 参考

* [深入理解 Yii2.0](http://www.digpage.com/index.html)
* [CraryPrimitiveMan/yii2-2.0.3-annotated](https://github.com/CraryPrimitiveMan/yii2-2.0.3-annotated):带有详细注释的 yii2 2.0.3 代码。
* [CraryPrimitiveMan/OnlineCourses](https://github.com/CraryPrimitiveMan/OnlineCourses):An online courses website based on yii2
* [多语言版本切换](https://blog.csdn.net/u012979009/article/details/51697969)
* [RESTful API 快速搭建教程](https://www.yiichina.com/tutorial/1606)
* [RESTful API 认证教程](https://www.yiichina.com/tutorial/1770)
* [csrf 验证原理分析及 token 缓存解决方案](https://www.yiichina.com/code/1695)
* [Yii Tutorial](https://www.tutorialspoint.com/yii/index.htm)
* [Yii框架](https://blog.csdn.net/u012979009/article/category/6202463/2)

## 扩展

-   [yii2-httpclient](https://github.com/yiisoft/yii2-httpclient)
-   [yii2-authclient](https://github.com/yiisoft/yii2-authclient)
-   [yii2-queue](https://github.com/yiisoft/yii2-queue)
-   [yii2-coding-standards](https://github.com/yiisoft/yii2-coding-standards)
-   [yiisoft/yii2-apidoc](https://github.com/yiisoft/yii2-apidoc)
-   [yii2-collection](https://github.com/yiisoft/yii2-collection)
-   [yii2-redis](https://github.com/yiisoft/yii2-redis)
-   [yii2-bootstrap](https://github.com/yiisoft/yii2-bootstrap)
-   [yii2-shell](https://github.com/yiisoft/yii2-shell)
-   [yii2-bootstrap4](https://github.com/yiisoft/yii2-bootstrap4)
-   [yiisoft/log](https://github.com/yiisoft/log)
-   [yii2-elasticsearch](https://github.com/yiisoft/yii2-elasticsearch)
-   [yiisoft/yii2-jui](https://github.com/yiisoft/yii2-jui):Yii 2 JQuery UI extension.
-   [2amigos/yii2-file-upload-widget](https://github.com/2amigos/yii2-file-upload-widget):BlueImp File Upload Widget for Yii2

## 项目

* [fecshop/yii2_fecshop](https://github.com/fecshop/yii2_fecshop):yii2 ( PHP ) fecshop core code used for ecommerce shop 多语言多货币多入口的开源电商 B2C 商城，支持移动端vue, app, html5 http://www.fecshop.com
* [EleTeam/Shop-PHP-Yii2](https://github.com/EleTeam/Shop-PHP-Yii2):EleTeam开源项目-电商全套解决方案之PHP版-Shop-for-PHP-Yii2。一个类似京东/天猫/淘宝的商城，有对应的APP支持，由EleTeam团队维护！
* [changchang700/yii2cms](https://github.com/changchang700/yii2cms):一款和layui搭配的后台管理cms，集成了权限、用户、配置等常用功能，你可以在这些基础上修改。
* [yii2-starter-kit/yii2-starter-kit](https://github.com/yii2-starter-kit/yii2-starter-kit):Yii2 Starter Kit http://yii2-starter-kit.terentev.net
