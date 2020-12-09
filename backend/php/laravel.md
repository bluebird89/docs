# [laravel](https://github.com/laravel/framework)

A PHP Framework For Web Artisans <https://laravel.com>

* 8.0
  - `php artisan serve` 命令增强:更新 .env 文件后不再需要重新运行命令
  - 模型类目录:初始化项目后在代码骨架中提供了 app/Models 目录，并将新建的模型类默认存放到这个目录
  - 模型工厂类
  - [Laravel Jetstream](https://jetstream.laravel.com/):进行优化和全新设计的 Laravel UI 脚手架代码
    + 包含了登录、注册、邮箱验证、双因子认证（2FA）、会话管理、基于 Laravel Sanctum 的 API 支持、以及可选的团队管理等功能
    + 使用 Tailwind CSS 框架，提供了 [Livewire](https://laravel-livewire.com/) 和 [Inertia](https://inertiajs.com/) 脚手架选项
  - 迁移文件压缩
    + 将多个迁移文件压缩到单个 SQL 文件 php artisan schema:dump [--prune]
  - 频率限制优化
  - 时间测试辅助函数
  - 动态 Blade 组件
  - Route
    + removed default namespace form RouteServiceProvider.php file
      * define $namespace = 'App\Http\Controllers' in RouteServiceProvider.php
      * Route::get('event/test', 'OrderController@ship'); => Route::get('form/{id}', [RequestController::form, 'index']);

## 安装

* [homestead](https://github.com/laravel/homestead):an official, pre-packaged Vagrant box that provides you a wonderful development environment without requiring you to install PHP, a web server, and any other server software on your local machine
  - 安装 virtualbox vagrant
  - parallels `vagrant plugin install vagrant-parallels`
  - vagrant box add [--name] laravel\homestead [homestead.box]
    + <https://atlas.hashicorp.com/laravel/boxes/homestead/versions/2.1.0/providers/virtualbox.box>
    + <https://vagrantcloud.com/laravel/boxes/homestead/versions/10.0.0/providers/virtualbox.box>
  - vagrant up:The SSH command responded with a non-zero exit status.
  - 添加ip
  - 从主机的数据库客户端连接到 MySQL 或 Postgres，就连接到 127.0.0.1 和端口 33060 (MySQL) 或 54320 (Postgres)。账号密码分别是 homestead／secret
  - 命令 schedule:run，会检查定义在你 App\Console\Kernel 类中的调度任务，调度每分钟运行一次
  - 端口
    + SSH: 2222 → 发送到 22
    + HTTP: 8000 → 发送到 80
    + HTTPS: 44300 → 发送到 443
    + MySQL: 33060 → 发送到 3306
    + Postgres: 54320 → 发送到 5432
    + Mailhog: 8025 → 发送到 8025
    + 共享环境：Homestead 机器中并运行 share homestead.app。这会从 Homestead.yaml 配置文件中共享 homestead.app
* [valet](https://github.com/laravel/valet):Valet is a Laravel development environment for Mac minimalists.
  - [valet-plus](https://github.com/weprovide/valet-plus):Blazing fast macOS PHP development environment <https://medium.com/@timneutkens/intro>…
  - 为 Mac 设置了启动后始终在后台运行 Nginx
  - Valet 使用 DnsMasq 将所有指向安装在本地计算机的站点的请求代理到 *.test 域上
* 通过composer 安装:`composer create-project --prefer-dist laravel/laravel blog`
* [Laragon](https://sourceforge.net/projects/laragon/):适用于 Windows 的轻量级开发环境
* [laradock](https://github.com/laradock/laradock):Docker PHP development environment. <http://laradock.io>

```sh
yum install php-mbstring php-dom php-zip php-posix php-simplexml php-bcmath php-ctype php-json php-openssl php-pdo php-tokenizer

brew install php  # 确保 ~/.composer/vendor/bin
brew install mysql # 安装MySQL
brew services start mysql # 启动服务

vagrant list
git clone https://github.com/laravel/homestead.git
bash init.sh

# homestread\Homestead.yaml

# scripts/homestead.rb
config.vm.box = "laravel/homestead" #box的名字（需与盒子列表中的一致）
config.vm.box_version = "0" #box的版本号（需与盒子列表中的一致）
config.vm.box_check_update = false #box是否检查更新
config.ssh.username = 'vagrant'
config.ssh.password = 'vagrant'

vagrant provision
vagrant init

composer global require laravel/valet
export PATH=$PATH:~/.composer/vendor/bin

valet install  # 终端ping一下任意 *.dev 域名
valet domain app # 修改域名
valet park # 将当前的工作目录作为 Valet 搜索站点的路径
valet stop|uninstall|restart
valet links # 查看所有目录链接的列表
valet link|unlink app-name # 目录中提供单个站点 Valet 会在 ~/.valet/Sites 中创建一个符号链接指向当前的目录
valet secure|unsecure laravel # 用 HTTP/2 提供加密的 TLS 站点

composer global require laravel/installer
# $HOME/.config/composer/vendor/bin
laravel new blog # 访问 http://blog.test
#  99160 segmentation fault

composer create-project --prefer-dist laravel/laravel blog "5.5.*"

## 源文件安装
cd /var/www
git clone https://github.com/laravel/laravel.git
cd /var/www/laravel
sudo composer install

chown -R www-data.www-data /var/www/laravel
chmod -R 755 /var/www/laravel
chmod -R 777 /var/www/laravel/storage
chmod -R 777 /var/www/laravel/bootstrap/cache

mysql -u root -p
CREATE DATABASE laravel;
GRANT ALL ON laravel.* to 'laravel'@'localhost' IDENTIFIED BY 'secret_password';
FLUSH PRIVILEGES;
quit

# update the database settings in .env file
# Configuring Apache for Laravel
# sudo service apache2 restart
Options +FollowSymLinks
RewriteEngine On

RewriteCond %{REQUEST_FILENAME} !-d
RewriteCond %{REQUEST_FILENAME} !-f
RewriteRule ^ index.php [L]

cp env.example .env
php artisan key:generate  # 设置程序密钥 The only supported ciphers are AES-128-CBC and AES-256-CBC with the correct key lengths. 不正确 500 错误，nginx 没有日志记录
php artisan serve --port=8010 --host=127.0.0.1
dump-server：启动 dump server 收集 dump 信息


git clone https://github.com/Laradock/laradock.git
git submodule add https://github.com/Laradock/laradock.git # exist project

cp env-example .env
# . env
DB_HOST=mysql
REDIS_HOST=redis
QUEUE_HOST=beanstalkd
APP_CODE_PATH_HOST=../project-z/ #  exist project
docker-compose up -d nginx mysql phpmyadmin redis workspace
docker-compose up --build # 会构建所有容器：Service 'aws' failed to build: COPY failed: stat /var/lib/docker/tmp/docker-builder279203978/ssh_keys: no such file or directory

docker-compose exec workspace bash
docker-compose exec --user=laradock workspace bash
docker-compose ps|stop|down
docker-compose logs -f {container-name}

## 问题
> No such file or directory: u'./docker-compose.dev.yml'

.env->COMPOSE_FILE:COMPOSE_FILE=docker-compose.yml
```

## 配置

启动时会加载项目中的.env文件中变量,bootstrap过程中的LoadEnvironmentVariables.超级全局变量 `$_ENV` 中或者 `env` 函数检索变量值

* 开发、测试、生产三套环境:`.env.dev`、`.env.test`、`.env.prod`
  - nginx配置文件里设置APP_ENV环境变量fastcgi_param APP_ENV dev
  - 设置服务器上运行PHP的用户的环境变量，比如在www用户的/home/www/.bashrc中添加export APP_ENV dev
  - 在部署项目的持续集成任务或者部署脚本里执行`cp .env.dev .env`
* `APP_ENV` 通过 `App::environment` 方法来访问此值
* 使用全局 config 函数来访问配置值 `$value = config('app.timezone');`,临时设置配置值，传递一个数组给 config 函数
  - 需要config/app.php 配置
* 会话 config/session.php `'driver' => 'memcached'`
* 缓存 config/cache.php `'default' => 'redis'`

```php
'debug' => env('APP_DEBUG', false),

# 自定义env文件的路径与文件名
$app = new Illuminate\Foundation\Application(
    realpath(__DIR__.'/../')
);
$app->loadEnvironmentFrom('customer.env')

if (App::environment('local')) {
    // 环境为 local
}

if (App::environment(['local', 'staging'])) {
    // 环境为 local 或 staging
}

# 配置缓存
php artisan config:cache  # 所有配置信息合并到一个文件里，减少运行时文件的载入数量
php artisan config:clear  # 删除配置的缓存文件
```

## 概念

* MVC
  - 控制器：负责对 HTTP 请求进行路由，因为还有很多其他访问应用方式，比如 Artisan 命令、队列、调度任务等等，控制器并非唯一入口，所以不适合也不应该将所有业务逻辑封装于此，过度依赖控制器会对以后应用的扩展带来麻烦
    + 主要职责就是获取 HTTP 请求，进行一些简单处理（如验证）后将其传递给真正处理业务逻辑的职能部门，如 Service
* Event:通过 event:generate 或 event:make 时生成
  - Events 目录存放了事件类
  - 可以使用事件来提醒应用其他部分发生了特定的操作，为应用提供了大量的灵活性和解耦
* Listeners：通过 event:generate 或 make:listener 时生成，包含了用来处理事件的类。
  - 事件监听器接收事件实例并执行响应该事件被触发的逻辑。例如，UserRegistered 事件可能由 SendWelcomeEmail 监听器处理
* Exceptions:应用异常处理器，也是应用抛出异常的好地方。如果想自定义记录或者渲染异常的方式，就要修改此目录下的 Handler 类
* Job:通过 make:job 时生成
  - 存放了应用中队列任务。应用的任务可以被推送到队列或者在当前请求的生命周期内同步运行。
  - 在当前请求期间同步运行的任务可以看做是一个「命令」，因为它们是 命令模式 的实现
* Mail：通过make:mail 时生成。包含应用所有的邮件发送类。邮件对象允许你将构建邮件的逻辑封装在可以使用 Mail::send 方法来发送邮件的地方
  - markdown:在邮件中利用预置模板和邮件通知组件，由于消息使用Markdown格式编写，因此Laravel可以将这些消息渲染成美观、响应式的HTML模板的同时自动为其生成纯文本副本
* Notifications：命令 make:notification 时生成。Notifications 目录包含应用发送的所有「事务性」通知，比如关于在应用中发生的事件的简单通知。Laravel 的通知功能抽象了通知发送，可以通过各种驱动（例如邮件、Slack、短信）发送通知，或是存储在数据库中。
* Policies：命令 make:policy 来创建。Policies 目录包含了应用的授权策略类。策略可以用来决定一个用户是否有权限去操作指定资源
* Providers：服务提供器通过在服务容器中绑定服务、注册事件、以及执行其他任务来为即将到来的请求做准备来启动应用
* Rules：命令 make:rule 命令时被创建。Rules 目录包含应用自定义验证规则对象。这些规则意在将复杂的验证逻辑封装在一个简单的对象中
* Broadcast
* Blade组件和插槽为section和layout提供了类似的好处
* 高阶消息传递的集合方法有：contains、each、every、filter、first、 map、 partition、 reject、sortBy、 sortByDesc和 sum。
* Eloquent事件处理器现在可以被映射到事件对象上，这为处理Eloquent事件并让其变得易于测试提供了一种直观的方式
  - 门面仅仅是静态代理，底层调用的还是 $request->input 方法，语法糖而已，建议大家还是用 $request 来获取
* CSRF保护

## 请求周期

Laravel 采用了单一入口模式，应用的所有请求入口都是 public/index.php 文件

* 注册类文件自动加载器：Laravel通过composer进行依赖管理，并在bootstrap/autoload.php中注册了Composer Auto Loader (PSR-4)，应用中类的命名空间将被映射到类文件实际路径，不再需要开发者手动导入各种类文件，而由自动加载器自行导入。因此，Laravel允许你在应用中定义的类可以自由放置在Composer Auto Loader能自动加载的任何目录下，但大多数时候还是建议放置在app目录下或app的某个子目录下
* 创建服务容器：从 bootstrap/app.php 文件中取得 Laravel 应用实例 $app (服务容器)
* 创建 HTTP / Console 内核：传入的请求会被发送给 HTTP 内核或者 console 内核进行处理，HTTP 内核继承自 Illuminate\Foundation\Http\Kernel 类。它定义了一个 bootstrappers 数组，数组中的类在请求真正执行前进行前置执行，这些引导程序配置了错误处理，日志记录，检测应用程序环境，以及其他在请求被处理前需要完成的工作；HTTP 内核同时定义了一个 HTTP 中间件列表，所有的请求必须在处理前通过这些中间件处理 HTTP session 的读写，判断应用是否在维护模式， 验证 CSRF token 等等
* 载入服务提供者至容器：在内核引导启动的过程中最重要的动作之一就是载入服务提供者到你的应用，服务提供者负责引导启动框架的全部各种组件，例如数据库、队列、验证器以及路由组件。因为这些组件引导和配置了框架的各种功能，所以服务提供者是整个 Laravel 启动过程中最为重要的部分，所有的服务提供者都配置在 config/app.php 文件中的 providers 数组中。首先，所有提供者的 register 方法会被调用；一旦所有提供者注册完成，接下来，boot 方法将会被调用
* 分发请求：一旦应用完成引导和所有服务提供者都注册完成，Request 将会移交给路由进行分发。路由将分发请求给一个路由或控制器，同时运行路由指定的中间件

## 服务容器 Ioc Container

* 服务提供者主要用来进行注册服务容器绑定（即注册接口及其实现类的绑定）
* 一个服务提供者必须至少有一个 register 方法。你可以在这个方法里将类绑定到容器
* 用于管理类依赖和执行依赖注入的工具
* 依赖注入（DI）:应用程序依赖容器创建并注入它所需要的外部资源
  - 由内部生产（比如初始化、构造函数 __construct 中通过工厂方法、自行手动 new 的）
  - 由外部以参数或其他形式注入
* 简单绑定:在类中可通过 $this->app 来访问容器，在类之外通过 $app 来访问容器.通过 bind 方法注册绑定，传递想要注册的类或接口名称再返回类的实例的 Closure
  - 绑定一个单例:将类或接口绑定到只能解析一次的容器中。绑定的单例被解析后，相同的对象实例会在随后的调用中返回到容器中
  - 绑定实例:使用 instance 方法将现有对象实例绑定到容器中。给定的实例会始终在随后的调用中返回到容器中
  - 绑定初始数据:需要注入一个基本值
  - 绑定接口到实现:将接口绑定到给定实现
  - 上下文绑定:使用了相同的接口，但希望每个类都能注入不同的实现
  - 标记：解析某个「分类」下的所有绑定
  - 解析：使用 make 方法将容器中的类实例解析出来
  - 自动注入：使用「类型提示」的方式在由容器解析的类的构造函数中添加依赖项，包括 控制器、事件监听器、队列任务、中间件 等
    + 构造函数注入
    + 方法注入：在控制器方法中类型提示依赖项，常见的用法就是将 Illuminate\Http\Request 实例注入到控制器方法
  - 容器事件：当服务容器解析一个对象时触发一个事件。你可以使用 resolving 方法监听这个事件，被解析的对象会被传递给回调中，让你在对象被传递出去之前可以在对象上设置任何属性
  - 服务容器实现了 PSR-11 接口：可以对 PSR-11 容器接口类型提示来获取 Laravel 容器的实例
  - 用门面调用的方法肯定可以用依赖注入来实现，而可以通过依赖注入实现的功能不一定可以通过门面来调用，除非你自定义实现这个门面
* 控制反转（IoC）：依赖接口而非实现，由外部负责其依赖需求行为
  - 容器控制应用程序，由容器反向的向应用程序注入应用程序所需要的外部资源
* laravel 自动搜寻依赖需求的功能，是通过 反射（Reflection） 实现
* 服务提供者（ServiceProvider）
  - register（注册）：不要有对未知事物的依赖，如果有，就要移步至 boot 部分,不需要尝试在 register 方法中注册任何事件监听器、路由或任何其他功能
    + 永远不要在 register 方法里面使用任何服务。该方法只是用来将对象绑定到服务容器的地方。所有关于绑定类的解析、交互都要在 boot 方法（服务提供者的另一个方法）里进行
  - boot（引导、初始化）:此方法在所有其他服务提供器都注册之后才能调用，可以访问已经被框架注册的所有服务
* 引导方法依赖注入：可以为服务提供器的 boot 方法设置类型提示
  * 延迟提供器：提供器仅在服务容器中注册绑定，直到真正需要注册绑定，提高应用程序的性能，因为它不会在每次请求时都从文件系统中加载
* 服务提供者是 Laravel 应用程序引导启动的中心，所有核心服务都是通过服务提供器进行引导。注册服务容器绑定、事件监听器、中间件，甚至是路由的注册
  - `config/app.php` 中的providers数组中进行注册
  - 注册的路由:`RouteServiceProvider`实例来加载
  - 事件监听器:`EventServiceProvider`类中进行注册
  - 中间件（路由中间件）：在app/Http/Kernel.php类文件中注册，调用时与路由进行绑定
  - 在新创建的应用中，AppServiceProvider 文件中方法实现都是空的，这个提供者是你添加应用专属的引导和服务的最佳位置，当然，对于大型应用你可能希望创建几个服务提供者，每个都具有粒度更精细的引导
* 绑定
  - instance:将一个已存在对象绑定到服务容器里，随后通过名称解析该服务时，容器将总返回这个绑定的实例,把对象注册到服务容器的$instances属性
  - bind:把服务注册到服务容器的$bindings属性里
    + 绑定自身:bind方法内部会在绑定服务之前通过getClosure()为服务生成闭包
    + 绑定闭包
    + 绑定接口和实现
  - singleton:绑定一个只需要解析一次的类或接口到容器，然后接下来对于容器的调用该服务将会返回同一个实例
  - alias:把服务和服务别名注册到容器
* 解析
  - make:从服务容器中解析出服务对象，该方法接收想要解析的类名或接口名作为参数
  - build:职能是构建解析出来的服务的对象
* 所有服务提供者都注册以后（register 方法调用完），它们就进入了「启动」状态。这将会触发每个服务提供者执行各自的 boot 方法

```sh
php artisan make:provider HelperServiceProvider

## instance
api = new HelpSpot\API(new HttpClient);
$this->app->instance('HelpSpot\API', $api);

## bind
this->app->bind('HelpSpot\API', null);

# 闭包直接提供类实现方式
$this->app->bind('HelpSpot\API', function () {
  return new HelpSpot\API();
});
# 闭包直接提供类实现方式
$this->app->bind('HelpSpot\API', function ($app) {
  return new HelpSpot\API($app->make('HttpClient'));
});//闭包返回需要依赖注入的类

$this->app->bind('Illuminate\Tests\Container\IContainerContractStub', 'Illuminate\Tests\Container\ContainerImplementationStub');

$this->app->singleton('HelpSpot\API', function ($app) {
    return new HelpSpot\API($app->make('HttpClient'));
});

$this->app->when('App\Http\Controllers\UserController')
          ->needs('$variableName')
          ->give($value);

$this->app->when(PhotoController::class)
          ->needs(Filesystem::class)
          ->give(function () {
              return Storage::disk('local');
          });

$this->app->tag(['SpeedReport', 'MemoryReport'], 'reports');

$api = $this->app->make('HelpSpot\API');
$api = resolve('HelpSpot\API'); # 用全局的辅助函数 resolve
$api = $this->app->makeWith('HelpSpot\API', ['id' => 1]);

$this->app->resolving(function ($object, $app) {
    // 当容器解析任何类型的对象时调用...
});

$this->app->resolving(HelpSpot\API::class, function ($api, $app) {
    // 当容器解析类型为「HelpSpot\API」的对象时调用...
});
```

## 中间件 Middleware

提供了一种方便的机制来过滤进入应用的 HTTP 请求,中间件都位于 app/Http/Middleware 目录

* 内置中间件
  - 用户的身份认证
  - CORS 中间件可以负责为所有离开应用的响应添加合适的头部信息
  - 日志中间件可以记录所有传入应用的请求。
* 前置 & 后置中间件：中间件中定义执行
* 注册中间件
  - 全局中间件：应用的每个 HTTP 请求期间运行，只需在 app/Http/Kernel.php 类中的 $middleware 属性里列出这个中间件类
  - 特定的路由分配中间件
    + 在 app/Http/Kernel.php 文件内为该中间件指定一个键。默认情况下，Kernel 类的 $routeMiddleware 属性包含 Laravel 内置的中间件条目，加入自定义的，只需把它附加到列表后并为其分配一个自定义键即可
    + 使用 middleware 方法将中间件分配给路由
* 中间件组：使用 Kernel 类的 $middlewareGroups 属性来实现
  - 包含可以应用到 Web 和 API 路由的通用中间件
  - 中间件组使用和分配单个中间件同样的语法被分配给路由和控制器动作
* 可以接受额外参数
* Terminable 中间件：在 HTTP 响应发送到浏览器之后处理一些工作。内置的「session」中间件会在响应发送到浏览器之后将会话数据写入存储器中。如果在中间件中定义一个 terminate 方法，则会在响应发送到浏览器后自动调用
* 在Controller或Router中使⽤

```
php artisan make:middleware CheckAge

 $pipe_arr = [
        'VerfiyCsrfToekn',
        'VerfiyAuth',
        'SetCookie',
    ];

$callback = array_reduce($pipe_arr,function($stack,$pipe) {
    return function() use($stack,$pipe){
        return $pipe::handle($stack);
    };
},$handle);

call_user_func($callback);
```

## 门面 Facades

为应用程序的服务容器中可用的类提供了一个「静态」接口.是服务容器中底层类的「静态代理」，提供了简洁而富有表现力的语法，甚至比传统的静态方法更具可测试性和扩展性

* 原理
  - Facade 提前注入 Ioc 容器
  - 定义一个服务提供者的外观类继承自 Illuminate\Support\Facades\Facade，在该类定义一个类的变量，跟 ioc 容器绑定的 key 一样,通过静态魔术方法__callStatic 可以得到当前想要调用的方法
  - 实现 getFacadeAccessor 方法
    - 使用 Facade 进行的任何调用都将传递给 Laravel 缓存服务的底层实例。
* 缺点
  - 会引起类作用范围的膨胀：因为 Facades 使用起来非常简单而且不需要注入，就会使得我们在不经意间在单个类中使用许多 Facades，从而导致类变的越来越大。而使用依赖注入的时候，使用的类越多，构造方法就会越长，在视觉上就会引起注意，提醒你这个类有点庞大了。因此在使用 Facades 的时候，要特别注意控制好类的大小，让类的作用范围保持短小。
* Facades Vs 依赖注入
  - 依赖注入的主要优点之一是切换注入类的实现的能力。这在测试的时候很有用，因为你可以注入一个 mock 或者 stub ，并断言在 stub 上调用的各种方法。
  - Facades 使用动态方法来代理从服务容器解析的对象的方法调用，我们可以像测试注入的类实例一样来测试 Facades
* Facades Vs 辅助函数
  - 底层辅助函数实际是调用facade

## 契约 Contracts

一组定义框架提供的核心服务的接口,框架对每个契约都提供了相应的实现

* 契约规范:Illuminate\Contracts\**\Repository
* 契约 VS Facades
  - Facades，不需要你在类的构造函数中类型提示.契约则需要在类中明显地定义依赖项。
* 使用接口的原因：低耦合和简单性
  - 高耦合:依赖于一个扩展包的特定缓存类。一旦这个扩展包的 API 被更改了，我们的代码就必须跟着改变
  - 根据接口定义，就很容易判断给定服务提供的功能。 可以将契约视为说明框架功能的简洁文档。
* 使用：要获得一个契约的实现，只需要被解析的类的构造函数中添加「类型提示」即可

## 辅助函数

* 数组 & 对象
* Str
* trans

## Artisan

* 利用PHP的CLI构建了强大Console工具，创建想要的模板类以及管理配置应用
* 自定义的 Artisan 命令
  - 通过 make:command 来生成,包含了控制台内核，可以用来注册自定义 Artisan 命令和定义计划任务的地方
* 应用根目录有一个 artisan 文件,在 artisan 文件中，处理流程会像 Web 请求一样，注册类的自动加载器，初始化容器和异常处理器，获取用户输入，执行处理逻辑，最后发送响应，只不过这一切都是在控制台中完成
* 选项：有前缀 --，可以在没有值的情况下使用
  - -v、-vv、-vvv：命令执行输出的三个级别，分别代表正常、详细、调试
  - --no-interaction：不会问任何交互问题，所以适用于运行无人值守自动处理命令
  - --env：允许你指定命令运行的环境
  - --version：打印当前 Laravel 版本
* 参数：必须设值或默认值
  - 必须要设置选项值，可以加上一个 = `make:migration {name} {--table=}`
  - -q：禁止所有输出
  - 必填参数，需要用花括号将其包裹起来
  - 可选参数，可以在参数名称后面加一个问号 `make:migration {name?}`
  - 可选参数定义默认值，可以这么做：`make:migration {name=create_users_table}`
* 数组参数和数组选项:使用 * 通配符
  - `make:migration {name*} {--table=*}`
* 分组：
  - app：只包含 app:name 命令，用于替换应用默认命名空间 App\
  - auth：只包含 auth:clear-resets，用于从数据库清除已过期的密码 Token
  - cache：应用缓存相关命令
  - config：config:cache 用于缓存应用配置，config:clear 用于清除缓存配置
  - db：db:seed 用于通过填充器填充数据库（如果编写了填充器的话）
  - event：event:generate 用于根据注册信息生成未创建的事件类及监听器类
  - key：key:generate 用于手动设置应用的 APP_KEY
  - make：用于根据模板快速生成应用各种脚手架代码，如认证、模型、控制器、数据库迁移文件等等等，我们会将每个命令穿插在相应教程中介绍
  - migrate：数据库迁移相关命令（数据库教程中会详细介绍）
  - notifications：notifications:table 用于生成通知表
  - optimize：optimize:clear 用于清除缓存的启动文件
  - package：package:discover 用于重新构建缓存的扩展包 manifest
  - queue：队列相关命令（队列教程中会详细介绍）
  - route：路由相关命令，route:cache 和 route:clear 分别用于缓存路由信息和清除路由缓存，route:list 用于列出应用所有路由信息
  - schedule：调度任务相关命令（调度任务教程中会介绍）
  - session：对于数据库驱动的 Session，我们通过 session:table 生成 sessions 数据表
  - storage：storage:link 生成一个软链 public/storage 指向 storage/app/public
  - vendor：vendor:publish 用于发布扩展包中的公共资源
  - view：view:cache 用于编译应用所有 Blade 模板，view:clear 用于清除这些编译文件
* 通过 Artisan:call() 调用指定命令，也可以通过 Artisan:queue() 将命令推送到队列中执行

```sh
php artisan --version|-V
php artisan help [name]  # 显示命令行帮助
php artisan list  # 列出命令

php artisan env # 显示当前框架环境
php artisan down --message="Upgrading Database" --retry=60 # 进入维护模式
php artisan up # 退出维护模式

php artisan fresh # 清除包含框架外的支架
php artisan migrate # 运行数据库迁移
php artisan optimize # 为了更好的框架去优化性能
php artisan serve
php artisan app:name #  设置应用程序命名空间

php artisan auth:clear-resets # 清除过期的密码重置密钥 未使用过

php artisan cache:clear # 清除应用程序缓存
php artisan cache:table # 创建一个缓存数据库表的迁移

php artisan event:generate  # 生成event和listen  需要实现配置eventserviceprivoder

php artisan make:model Models/Blog -m
php artisan make:Model App\\Models\\User(linux or macOs 加上转义符) # 指定路径创建
php artisan make:provider # 生成一个服务提供商的类

php artisan vendor:publish # 发布插件包资源

php artisan schedule:run # 运行预定命令
php artisan optimize --force # 把常用加载的类合并到一个文件里，通过减少文件的加载.生成 bootstrap/cache/compiled.php 和 bootstrap/cache/services.json 两个文件。可以通过修改 config/compile.php 文件来添加要合并的类。在 production 环境中，参数 --force 不需要指定，文件就会自动生成
php artisan clear-compiled  # 清除类映射加载优化
php artisan view:clear
php artisan session:table # 创建一个迁移的SESSION数据库工作表

php artisan baum # Get Baum version notice.
php artisan baum:install # Scaffolds a new migration and model suitable for Baum
```

## Tinker 命令行交互式 Shell

* 原生 php -a
* 一个由 PsySH 扩展包驱动的REPL（Read-Eval-Print Loop，即终端命令行"读取-求值-输出"循环工具）,通过命令行与整个 Laravel 应用进行交互，包括 Eloquent ORM、任务、事件等等。
  - psysh `composer g require psy/psysh:@stable`
  - 添加一些命令到 Shell，这些命令定义在 Laravel\Tinker\Console\TinkerCommand 的 $commandWhitelist 属性中
* 测试 Laravel 代码
  - 可以使用控制台来创建一个新的模型，将其保存到数据库，然后查询这条记录

```
php artisan tinker
//生成30条数据
factory(App\User::class,30)->create()

// 交互 tinker使用
php artisan tinker
Psy Shell v0.7.2 (PHP 5.6.19 鈥?cli) by Justin Hileman
$user = new App\User;
=> App\User {#628}
$user->name = 'admin'
=> "admin"
$user->email = 'fation@126.com'
=> "fation@126.com"
$user->password = bcrypt('123456');
=> "$2y$10$kyCuwqSpzGTTZgAPMgCDgung9miGRygyCAIKHJhylYyW9osKKc3lu"
$user->save();
"insert into `users` (`name`, `email`, `password`, `updated_at`, `created_at`) values (?, ?, ?, ?, ?)"
=> true
exit

# 查看帮助文档
doc config
# 查看该函数的代码
show config
```

## Command

* 结构
  - signature
  - description
  - handle 命令执行时被调用

```sh
php artisan make:command SendEmails
```

## 路由 Routes

* 基本路由：需要一个 URI 与一个 闭包
* 默认路由：在 routes 目录中的路由文件中定义，这些文件都由框架自动加载
  - routes/web.php 文件用于定义 web 界面的路由。这里面的路由都会被分配给 web 中间件组，它提供了会话状态和 CSRF 保护等功能。
  - routes/api.php 中的路由都是无状态的，并且被分配了 api 中间件组。通过 RouteServiceProvider 被嵌套到一个路由组里面。在这个路由组中，会自动添加 URL 前缀 /api 到此文件中的每个路由，可以在 RouteServiceProvider 类中修改此前缀以及其他路由组选项
* CSRF 保护：指向 web 路由文件中定义的 POST、PUT 或 DELETE 路由的任何 HTML 表单都应该包含一个 CSRF 令牌字段，否则，这个请求将会被拒绝
* 视图路由：使用 Route::view 方法，有三个参数，其中前两个是必填参数，分别是 URL 和视图名称。第三个参数选填，可以传入一个数组，数组中的数据会被传递给视图。
* 路由参数
  - 必填参数：在路由中捕获一些 URL 片段,路由的参数通常都会被放在 {} 内，并且参数名只能为字母，同时路由参数不能包含 - 符号，如果需要可以用下划线 (_) 代替。路由参数会按顺序依次被注入到路由回调或者控制器中，而不受回调或者控制器的参数名称的影响。
  - 可选参数:需要指定一个路由参数，但你希望这个参数是可选的。你可以在参数后面加上 ? 标记来实现，但前提是要确保路由的相应变量有默认值
  - 正则表达式约束:使用路由实例上的 where 方法约束路由参数的格式。where 方法接受参数名称和定义参数应如何约束的正则表达式
* 全局约束：希望某个具体的路由参数都遵循同一个正则表达式的约束，就使用 pattern 方法在 RouteServiceProvider 的 boot 方法中定义这些模式
* 命名路由可以方便地为指定路由生成 URL 或者重定向。通过在路由定义上链式调用 name 方法指定路由名称
  - 可以使用全局辅助函数 route 来生成链接或者重定向到该路由
* 路由组允许在大量路由之间共享路由属性，例如中间件或命名空间，而不需要为每个路由单独定义这些属性。共享属性应该以数组的形式传入 Route::group 方法的第一个参数中
  - 给路由组中所有的路由分配中间件，可以在 group 之前调用 middleware 方法。中间件会依照它们在数组中列出的顺序来运行
  - 使用 namespace 方法将相同的 PHP 命名空间分配给路由组的中所有的控制器
  - 用来处理子域名。子域名可以像路由 URI 一样被分配路由参数，允许你获取一部分子域名作为参数给路由或控制器使用
  - 路由前缀：可以用 prefix 方法为路由组中给定的 URL 增加前缀
* 路由模型绑定：向路由或控制器行为注入模型 ID 时，就需要查询这个 ID 对应的模型
  - 隐式绑定：自动解析定义在路由或控制器行为中与类型提示的变量名匹配的路由段名称的 Eloquent 模型
    + 自定义键名：要模型绑定在检索给定的模型类时使用除 id 之外的数据库字段，可以在 Eloquent 模型上重写 getRouteKeyName 方法
  - 显式绑定：注册显式绑定，使用路由器的 model 方法来为给定参数指定类
* 自定义解析逻辑：使用 Route::bind 方法。传递到 bind 方法的闭包会接受 URI 中大括号对应的值，并且返回你想要在该路由中注入的类的实例
* 表单伪造：需要在表单中增加隐藏的 `_method` 输入标签。使用 `_method` 字段的值作为 HTTP 的请求方法；也可以使用辅助函数 `method_field` 来生成隐藏的 _method 输入标签
* 获取路由参数值:一般显式将其作为控制器方法参数或者定义路由的匿名函数参数传入，以便在代码中获取

```
php artisan route:list # 列出全部的注册路由
php artisan route:cache # 会生成 bootstrap/cache/routes.php 文件，注意，路由缓存不支持路由匿名函数编写逻辑
php artisan route:clear

# 生成 URL
$url = route('profile');
// 判断当前请求是否指向了某个路由
$request->route()->named('profile');

# 显式绑定
# 手动配置路由模型绑定，在 App\Providers\RouteServiceProvider 的 boot() 方法中新增
public function boot()
{
    parent::boot();

    Route::bind('user', function ($value) {
        return App\User::where('name', $value)->first();
    }
    Route::model('user', App\User::class);
});
# 隐式绑定
Route::get('profile/{user}', function (App\User $user) {}

<form action="/foo/bar" method="POST">
    <input type="hidden" name="_method" value="PUT">
    <input type="hidden" name="_token" value="{{ csrf_token() }}">
</form>

{{ method_field('PUT') }}

<a href="{{ url('/') }}">

## 当前路由
$route = Route::current();
$name = Route::currentRouteName();
$action = Route::currentRouteAction();
```

### URL

* 基础 URL echo url("/posts/{$post->id}")
* 当前 URL
  - 获取没有查询字符串的当前的 URL echo url()->current();
  - 获取包含查询字符串的当前的 URL echo url()->full();
  - 获取上一个请求的完整的 URL echo url()->previous();
  - use Illuminate\Support\Facades\URL; echo URL::current();
* 命名路由的 URL:辅助函数 route 可以用于为指定路由生成 URL。命名路由生成的 URL 不与路由上定义的 URL 相耦合。因此，就算路由的 URL 有任何更改，都不需要对 route 函数调用进行任何更改 命名路由生成的 URL  Route::get('/post/{post}', function () {// })->name('post.show'); echo route('post.show', ['post' => $post]);
* action 功能可以为给定的控制器行为生成 URL action('UserController@profile', ['id' => 1]);

## 控制器

* 继承了 Laravel 内置的基础控制器类
* 定义控制器路由时，不需要指定完整的控制器命名空间。因为 RouteServiceProvider 会在一个包含命名空间的路由器组中加载路由文件，所以只需要指定类名中 App\Http\Controllers 命名空间之后的部分就可以了
* 默认的命名空间是 App\Http\Controllers
* 获取用户输入
* 单个行为控制器:控制器中放置一个 __invoke 方法
* 控制器的构造方法中指定中间件会更方便
* 资源控制器
  - 生成：`php artisan make:controller PhotoController --resource --model=Photo`
  - 路由注册
    + `Route::resource('photos', 'PhotoController');`
    + `Route::resource('photo', 'PhotoController', ['only' => ['index', 'show']]);`
    + `Route::resource('photo', 'PhotoController', ['except' => ['create', 'store', 'update', 'destroy']]);`
    + 命名资源路由:`Route::resource('photo', 'PhotoController', ['names' => ['create' => 'photo.build']]);`
    + 命名资源路由参数:在选项数组中传入 parameters 参数来轻松地覆盖每个资源。parameters 数组应该是资源名称和参数名称的关联数组
  - 方法
    + GET /photos index photos.index
    + GET /photos/create  create  photos.create
    + POST  /photos store photos.store
    + GET /photos/{photo} show  photos.show
    + GET /photos/{photo}/edit  edit  photos.edit
    + PUT/PATCH /photos/{photo} update  photos.update
    + DELETE  /photos/{photo} destroy photos.destroy
  - 本地化资源 URI(多语言):默认情况下，Route::resource 将会用英文动词创建资源 URI,要本地化 create 和 edit 行为动作名，可以在 AppServiceProvider 的 boot 中使用 Route::resourceVerbs 方法实现
  - 在默认的资源路由中增加额外的路由，你应该在 Route::resource 之前定义这些路由
* API 资源路由:排除显示 HTML 模板的路由（如 create 和 edit ）。为了方便起见，你可以使用 apiResource 方法自动排除这两个路由
  - `Route::apiResource('photo', 'PhotoController');`
  - `Route::apiResources(['photos' => 'PhotoController', 'posts' => 'PostController']);`

```php
php artisan make:controller App\TestController # 指定创建位置 在app目录下创建TestController
php artisan make:controller PhotoController --resource # 创建Rest风格资源控制器
php artisan make:controller PhotoController --resource --model=Photo
```

## 请求 request

* 通过依赖注入的方式来获取当前 HTTP 请求的实例，应该在控制器方法中类型提示 Illuminate\Http\Request。传入的请求的实例将通过服务容器自动注入
* 路由参数
* 通过路由闭包获取请求:在路由闭包中类型提示 Illuminate\Http\Request 类。服务容器在执行时会自动将当前请求注入到闭包中
* 方法
  - 获取请求路径：$uri = $request->path(); ttp://domain.com/foo/bar，那么 path 将会返回 foo/bar
  - is 方法可以验证传入的请求路径和指定规则是否匹配。使用这个方法的时，你也可以传递一个 *字符作为通配符 $request->is('admin/*')
  - 获取请求的 URL
    + url 方法返回不带有查询字符串的 URL $url = $request->url();
    + fullUrl 方法的返回值包含查询字符串
  - 获取请求方法：method 方法将返回 HTTP 的请求方式 $request->method()
  - isMethod 方法去验证 HTTP 的请求方式与指定规则是否相配 $request->isMethod('post')
  - 获取所有输入数据：$request->all();
  - 获取指定输入值：$request->input('name'); 带上默认值 $request->input('name', 'Sally');
  - 传输表单数据中包含「数组」形式的数据，那么可以使用「点」语法来获取数组：$request->input('products.*.name');
  - 从查询字符串获取输入：$request->query('name'); 查询字符串数据不存在，则将返回这个方法的第二个参数 $request->query('name', 'Helen');
  - 以关联数组的形式检索所有查询字符串值 $request->query();
  - 动态属性获取输入：通过 Illuminate\Http\Request 实例的动态属性来获取用户输入，$request->name; 先在请求的数据中查找，如果没有，再到路由参数中查找
  - 请求的 Content-Type 标头正确设置为 application/json，就可以通过 Input 方法访问 JSON 数据。甚至可以使用 「点」语法来读取 JSON 数组 $name = $request->input('user.name');
  - 获取部分输入数据，接收 数组 或动态列表作为参数
    + $input = $request->only(['username', 'password']); $input = $request->only('username', 'password');
    + $input = $request->except(['credit_card']);$input = $request->except('credit_card');
  - 判断请求是否存在某个值，可以使用 has 方法， 返回值为bool
    + $request->has('name')
    + 确定是否存在数组中所有给定的值:$request->has(['name', 'email']
    + 确定请求中是否存在值并且不为空:$request->filled('name')
  - 将本次请求的数据保留到下一次请求发送前。如果第一次请求的表单不能通过验证，就可以使用这个功能重新填充表单,使用了 Laravel 的 验证功能，你就不需要在手动实现这些方法，因为 Laravel 内置的验证工具会自动调用他们
    + flashOnly 和 flashExcept 方法将请求数据的一部分闪存到 session。这些方法对敏感信息（例如密码）的保护非常有用
    + 把输入闪存到 session 然后重定向到上一页，这时只需要在重定向方法后加上 withInput
    + 要获取上一次请求中闪存的输入:$username = $request->old('username');
  - 请求中获取 Cookie: 每个 cookie 都会被加密并使用验证码进行签名，这意味着如果客户端更改了它们，便视为无效。 $request->cookie('name')
  - 使用 cookie 方法将 cookie 附加到传出的 Illuminate\Http\Response 实例
  - 上传文件
    + $request->file('photo'); $request->photo; 返回一个 Illuminate\Http\UploadedFile 类的实例
    + hasFile 方法确认请求中是否存在文件: $request->hasFile('photo')
    + isValid 方法验证上传的文件是否有效:$request->file('photo')->isValid()
    + 访问文件的完整路径:$request->photo->path();
    + extension 方法会根据文件内容判断文件的扩展名 $request->photo->extension();
    + 存储上传的文件，先配置好 文件系统
      * .store 方法接受相对于文件系统配置的存储文件根目录的路径。这个路径不能包含文件名，因为系统会自动生成唯一的 ID 作为文件名。
      * 不想自动生成文件名，那么可以使用 storeAs 方法，它接受路径、文件名和磁盘名作为其参数
* PSR-7 标准 规定的 HTTP 消息接口包含了请求和响应。如果你想使用一个 PSR-7 请求来代替一个 Laravel 请求实例
  - composer require symfony/psr-http-message-bridge
  - composer require zendframework/zend-diactoros
* 输入预处理 & 规范化：全局中间件堆栈中包含了 TrimStrings 和 ConvertEmptyStringsToNull 两个中间件。这些中间件由 App\Http\Kernel 类列在堆栈中。它们会自动处理请求上所有传入的字符串字段，并将空的字符串字段转变成 null 值
* 配置可信代理：应用程序有时不能生成 HTTPS 链接。通常这是因为你的应用程序正在从端口 80 上的负载平衡器转发流量，却不知道是否应该生成安全链接。
  - App\Http\Middleware\TrustProxies自定义应用程序信任的负载均衡器或代理。你信任的代理应该保存在这个中间件的 $proxies 数组中。使用 **来信任所有代理，protected $proxies = '**';
  - 可以配置代理发送包含原始请求信息的请求头
* 验证器 validator
* Illuminate\Support\Facades\Http

```php
$request->flash();
$request->flashOnly(['username', 'email']);
$request->flashExcept('password');

# 闪存输入后重定向
return redirect('form')->withInput(
    $request->except('password')
);
$username = $request->old('username');
<input type="text" name="username" value="{{ old('username') }}">

return response('Hello World')->cookie(
    'name', 'value', $minutes, $path, $domain, $secure, $httpOnly
);

$path = $request->photo->store('images');
$path = $request->photo->store('images', 's3');
$path = $request->photo->storeAs('images', 'filename.jpg', 's3');

namespace App\Http\Middleware;

use Illuminate\Http\Request;
use Fideloper\Proxy\TrustProxies as Middleware;

class TrustProxies extends Middleware
{
    /**
     * 这个应用程序的可信代理列表
     *
     * @var array
     */
    protected $proxies = [
        '192.168.1.1',
        '192.168.1.2',
    ];

    /**
     * 当前代理响应头映射关系
     *
     * @var array
     */
    protected $headers = [
        Request::HEADER_FORWARDED => 'FORWARDED',
        Request::HEADER_X_FORWARDED_FOR => 'X_FORWARDED_FOR',
        Request::HEADER_X_FORWARDED_HOST => 'X_FORWARDED_HOST',
        Request::HEADER_X_FORWARDED_PORT => 'X_FORWARDED_PORT',
        Request::HEADER_X_FORWARDED_PROTO => 'X_FORWARDED_PROTO',
    ];
}
```

## 表单

* 伪造跨站请求保护 CSRF
  - 保护应用程序免受 跨站请求伪造 (CSRF) 的攻击，自动为每个活跃用户的会话生成一个 CSRF「令牌」。该令牌用于验证经过身份验证的用户是否是向应用程序发出请求的用户。
  - 在应用程序中定义 HTML 表单时，都应该在表单中包含一个隐藏的 CSRF 令牌字段，以便 CSRF 保护中间件可以验证该请求
  - 包含在 web 中间件组里的 VerifyCsrfToken 中间件会自动验证请求里的令牌是否与存储在会话中令牌匹配。
  - resources/assets/js/bootstrap.js 文件会用 Axios HTTP 函数库注册的 csrf-token meta 标签中的值
  - 白名单
  - 会检查 X-CSRF-TOKEN 请求头:将令牌保存在 HTML meta 标签中
  - 当前的 CSRF 令牌存储在由框架生成的每个响应中包含的一个 XSRF-TOKEN cookie 中。为方便起见，你可以使用 cookie 值来设置 X-XSRF-TOKEN 请求头
* 表单验证:用 ValidatesRequests Trait，提供了一种方便的方法使用各种强大的验证规则来验证传入的 HTTP 请求
  - Laravel表单验证拥有标准且庞大的[规则集]( <<http://d.laravel-china.org/docs/5.4/validation>#可用的验证规则)，通过规则调用来完成数据验证
  - 多个规则组合调用须以"|"符号连接，一次验证required失败后将立即停止验证,自动回退并可自动绑定视图
  - "."语法符号在Laravel中通常表示嵌套包含关系，这个在其他语言或框架语法中也比较常见
  + 自定义FormRequest (须继承自 Illuminate\Foundation\Http\FormRequest )
  + Validator::make()手动创建validator实例
  + 创建validator实例验证后钩子
  + 按条件增加规则
  + 数组验证
  + 自定义验证规则

```
$this->validate($request, [
    'title' => 'bail|required|unique:posts|max:255',
    'author.name' => 'required',
    'author.description' => 'required',
]);
```

```php
php artisan storage:link
<form method="POST" action="/profile">
    {{ csrf_field() }}
    ...
</form>

class VerifyCsrfToken extends BaseVerifier
{
    /**
     * 这些 URI 将免受 CSRF 验证
     *
     * @var array
     */
    protected $except = [
        'stripe/*',
    ];
}

<meta name="csrf-token" content="{{ csrf_token() }}">
$.ajaxSetup({
    headers: {
        'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
    }
});
```

## 响应 Response

返回一个响应并发送给用户的浏览器

* 字符串 & 数组（框架会自动地将数组转为 JSON 响应）
* 响应对象:回完整的 Illuminate\Http\Response 实例或 视图
  - 自定义响应的 HTTP 状态码和响应头信息
  - 为响应增加头信息:可链式调用的，使得创建响应实例的过程更具可读性。使用 withHeaders 方法来指定要添加到响应的头信息数组
  - 为响应增加 Cookie
  - 部分Cookie 不被加密,在 app/Http/Middleware 目录中 App\Http\Middleware\EncryptCookies 中间件的 $except 属性,protected $except = ['cookie_name', ];
* 重定向响应是 Illuminate\Http\RedirectResponse 类的实例
  - Route::get('dashboard', function () {return redirect('home/dashboard'); });
  - 重定向到之前的位置 Route::post('user/profile', function () {// 验证请求... return back()->withInput(); });
  - 重定向至命名路由 return redirect()->route('profile', ['id' => 1]);
  - 通过 Eloquent 模型填充参数 从 Eloquent 模型填充「ID」参数的路由，可以简单地传递模型本身。ID 会被自动提取
  - 重定向至控制器行为 return redirect()->action('HomeController@index', ['id' => 1]);
  - 重定向并使用闪存的 Session 数据：成功执行将信息闪存到 Seesion 后才算完成此操作。用户重定向后，你可以从 session 中读取闪存的信息。
* 响应类型
  - 视图响应：使用 view 方法
  - JSON 响应：json 方法
  - JSONP 响应：使用 json 方法并与 withCallback 方法配合使用
* 存储
  - 下载：download 方法可以用来生成强制用户浏览器下载指定路径文件的响应。download 方法的第二个参数接受一个文件名，它将作为用户下载的时所看见的文件名。最后，你可以传递一个 HTTP 响应头数组作为该方法的第三个参数
  - 文件响应：file 方法可以直接在用户浏览器中显示文件（不是发起下载），例如图像或者 PDF
  - 响应宏：定义可以在各种路由和控制器中重复使用的自定义响应，可以在 Response Facade 上使用 macro 方法。

```php
Route::get('home', function () {
    return response('Hello World', 200)
                  ->header('Content-Type', 'text/plain')
                  ->header('X-Header-One', 'Header Value')
                  ->cookie('name', 'value', $minutes);
});
return response($content)
            ->withHeaders([
                'Content-Type' => $type,
                'X-Header-One' => 'Header Value',
                'X-Header-Two' => 'Header Value',
            ]);

// 对于此路由: profile/{id}
return redirect()->route('profile', [$user]);

Route::post('user/profile', function () {
    // 更新用户的信息...

    return redirect('dashboard')->with('status', 'Profile updated!');
});

@if (session('status'))
    <div class="alert alert-success">
        {{ session('status') }}
    </div>
@endif

return response()
            ->view('hello', $data, 200)
            ->header('Content-Type', $type);
return response()->json([
    'name' => 'Abigail',
    'state' => 'CA'
]);

return response()
            ->json(['name' => 'Abigail', 'state' => 'CA'])
            ->withCallback($request->input('callback'));
return response()->download($pathToFile);
return response()->download($pathToFile, $name, $headers);
return response()->download($pathToFile)->deleteFileAfterSend(true);

return response()->file($pathToFile);
return response()->file($pathToFile, $headers);
```

### 视图

* 基于Blade，存放于 resources/views 目录下
* 判断视图文件是否存在,View::exists('emails.customer')
* 与所有视图共享数据：AppServiceProvider服务提供器的 boot 方法中调用视图 Facade 的 share 方法。或者为它们生成一个单独的服务提供器
* 视图合成器：在渲染视图时调用的回调或者类方法。如果你每次渲染视图时都要绑定视图的数据，视图合成器可以帮你将这些逻辑整理到特定的位置。使用 View Facade 来访问底层的 Illuminate\Contracts\View\Factory 契约实现，建立目录App\Http\ViewComposers
* 视图构造器添加到多个视图：将一组视图作为第一个参数传入 composer 方法，creator 方法注册视图构造器
* 视图构造器在视图实例化之后立即执行，而视图合成器在视图即将渲染时执行。

```
# AppServiceProvider
public function boot()
{
    View::share('key', 'value');
}

# 视图合成器
namespace App\Providers;

use Illuminate\Support\Facades\View;
use Illuminate\Support\ServiceProvider;

class ComposerServiceProvider extends ServiceProvider
{
    /**
     * 在容器中注册绑定
     *
     * @return void
     */
    public function boot()
    {
        // 使用基于类的 composer...
        View::composer(
            'profile', 'App\Http\ViewComposers\ProfileComposer'
        );

        // 使用基于闭包的 composers...
        View::composer('dashboard', function ($view) {
            //
        });
    }
}

namespace App\Http\ViewComposers;

use Illuminate\View\View;
use App\Repositories\UserRepository;

class ProfileComposer
{
    /**
     * 用户 repository 实现
     *
     * @var UserRepository
     */
    protected $users;

    /**
     * 创建一个新的 profile composer
     *
     * @param  UserRepository  $users
     * @return void
     */
    public function __construct(UserRepository $users)
    {
        // 依赖关系由服务容器自动解析...
        $this->users = $users;
    }

    /**
     * 将数据绑定到视图。
     *
     * @param  View  $view
     * @return void
     */
    public function compose(View $view)
    {
        $view->with('count', $this->users->count());
    }
}

View::composer(
    ['profile', 'dashboard'],
    'App\Http\ViewComposers\MyViewComposer'
);

View::composer('*', function ($view) {
    //
});
View::creator('profile', 'App\Http\ViewCreators\ProfileCreator');

php artisan storage:link # public/storage（软连接） → storage/app/public
```

## UI

```sh
preset：切换应用前端框架脚手架代码，比如从 Vue 切换到 React
```

### session

* 配置文件存储在 config/session.php
* driver 的配置选项定义了每个请求存储 Session 数据的位置
  - file - 将 Session 保存在 storage/framework/sessions 中。
  - cookie - Session 保存在安全加密的 Cookie 中。
  - database - Session 保存在关系型数据库中。
  - memcached / redis - Sessions 保存在其中一个快速且基于缓存的存储系统中。Composer require predis/predis
  - array - Sessions 保存在 PHP 数组中，不会被持久化
  - 自定义 Session 驱动
    + 实现驱动
    + 在框架中注册该驱动,在 服务提供者 的 boot 方法内调用 Session Facade 的 extend 方法
* 获取数据
  - 全局辅助函数 session
    + 获取 Session 中的一条数 指定一个默认值 $value = session('key', 'value');
    + 在 Session 中存储一条数据 session(['key' => 'value']);
  - 通过一个 Request 实例  $request->session()->get('key', 'default'); 获取所有 Session 数据 $data = $request->session()->all();
* 判断 Session 中是否存在某个值
  - 该值存在且不为 null，那么 has 方法会返回 true $request->session()->has('users')
  - 即使其值为 null，也可以使用 exists 方法 $request->session()->exists('users')
* 存储数据到 Session
  - $request->session()->put('key', 'value');
  - session(['key' => 'value']);
  - 将一个新的值添加到 Session 数组内 $request->session()->push('user.teams', 'developers');
  - 从 Session 检索并且删除一个项目 $request->session()->pull('key', 'default');
  - 闪存数据:下一个请求之前在 Session 中存入数据，可以使用 flash 方法。
    + 使用这个方法保存在 session 中的数据，只会保留到下个 HTTP 请求到来之前，然后就会被删除。闪存数据主要用于短期的状态消息  $request->session()->flash('status', 'Task was successful!');
    + 保留闪存数据给更多请求，可以使用 reflash 方法，这将会将所有的闪存数据保留给其他请求。$request->session()->reflash();
    + 想保留特定的闪存数据，则可以使用 keep 方法 $request->session()->keep(['username', 'email']);
* 删除数据
  - 删除一条数据 $request->session()->forget('key');
  - 删除 Session 内所有数据 $request->session()->flush();
* 重新生成 Session ID $request->session()->regenerate();

```php
# DB
Schema::create('sessions', function ($table) {
    $table->string('id')->unique();
    $table->integer('user_id')->nullable();
    $table->string('ip_address', 45)->nullable();
    $table->text('user_agent')->nullable();
    $table->text('payload');
    $table->integer('last_activity');
});
php artisan session:table
php artisan migrate
```

## 数据库

* 配置 `./config/database.php`
  - 配置多个数据库连接
    + connections 配置项中新增一个 MySQL 连接 `mysql_old`
    + DB::connection('mysql_old')->select(...)
  - 读写分离连接
    + `mysql` 中加 read 和 write 字段
  - sticky 配置项
    + true 在同一个请求生命周期中，写入的数据会被立刻读取到，底层原理其实就是读操作也从写数据库读取，因为写数据库始终是最新数据，从而避免主从同步延迟导致的数据不一致
* 迁移 Migration
  - 数据表的每次变动（创建、修改、删除）都对应一个迁移文件，这些迁移文件位于 database/migrations 目录下，以日期时间为条件确定执行的先后顺序。
  - 每个迁移文件中包含一个迁移类，有两部分组成
    + 负责执行数据库迁移的 up 方法
    + 负责回滚此次迁移的 down 方法
    + 基于 Schema 门面来完成（底层对应的类是 Illuminate\Database\Schema\Builder）
  - 修改表字段
    + `composer require doctrine/dbal`
    + `$table->string('nickname', 50)->change();`
  - 外键
    + `$table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');`
    + `$table->foreign('user_id')->references('id')->on('users')->onUpdate('cascade');`
  - 回滚
    + `php artisan migrate:rollback --step=5`
  - 选项
    + --create= 用于指定要创建的数据表名称，在定义创建数据表迁移文件时使用
    + --table= 用于指定要修改的数据表名称，在定义更新数据表迁移文件时使用
  - `php artisan make:model --migration Post`
    + 在 app 目录下创建模型类 App\Post
    + 创建用于创建 posts 表的迁移，该迁移文件位于 database/migrations 目录下
* 填充 Seeder
  - 外键：数据类型一致 `unsignedInteger`
* 优化
  - 数据关联模型读取时使用 延迟预加载 和 预加载
  - 使用 Laravel Debugbar 或者 Clockwork 留意每一个页面的总数据库请求数量
  - 从数据库里面拿出来的数据集合进行缓存，减少数据库的压力，运行在内存上的专业缓存软件对数据的读取也远远快于数据库
* 查询
  - facade
  - 查询构造器
  - Eloquent ORM:对象关系映射(Object Relational Mapping)

```sh
php artisan make:migration create_users_table
php artisan make:migration create_users_table --create=users  # 创建数据表迁移
php artisan make:migration alter_users_add_nickname --table=users  # 更新数据表迁移
php artisan make:migration --path=app\providers create_users_table

php artisan migrate
# 初始化迁移数据表
php artisan migrate:install
# 重置并重新执行所有的数据迁移
php artisan migrate:refresh
# 回滚所有的数据迁移
php artisan migrate:reset
php artisan migrate:rollback #  回滚最后一个数据库迁移
php artisan migrate:status  # 显示列表的迁移

php artisan make:seeder UsersTableSeeder
php artisan db:seed
php artisan db:seed --class=UsersTableSeeder
php artisan migrate --seed

# 原生 Statement 语句
DB::statement('create table `users` (`id` int(10) unsigned NOT NULL AUTO_INCREMENT,`name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL)');
# 原生查询语句
DB::insert("insert into student(name,age) values(?,?)",['sandy',19]);
DB::delete('delete from student where name=?',['sandy']);
DB::update('update student set sex=? where name=?',['男','tory']);
DB::select('select * from student');
DB::select('select * from users where id = :id', ['id' => 1]);
DB::statement('drop table users');

# 查询构建器
$res=DB::table('student')->get();
$exists = DB::table('users')->where('name', $name)->exists();
DB::table('posts')->where('id', '<', 10)->where('views', '>', 0)->get();
DB::table('posts')->where([
    ['id', '<', 10],
    ['views', '>', 0]
])->get();
DB::table('posts')->where('id', '<', 10)->orWhere('views', '>', 0)->get();
DB::table('posts')->whereBetween('views', [10, 100])->get();
DB::table('posts')->whereNotBetween('views', [10, 100])->get();
DB::table('posts')->whereIn('user_id', [1, 3, 5, 7, 9])->get();
$res=DB::table('student')->where('id','1001')->first();
$res=DB::table('student')->where('id','1003')->value('name');
# 分割成多个的组块依次返回进行处理
DB::table('users')->where('id', '<', 10)->pluck('name', 'id');
$res=DB::table('student')->pluck(2,function ($res){
  foreach ($res as $user){
    var_dump($user);
    if ($user->id >=1003) return false;
  }
});
$flag = DB::table('users')->insert([
    'name' => str_random(10),
    'email' => str_random(8) . '@163.com',
    'password' => bcrypt('secret')
]);
$userId = DB::table('users')->insertGetId([
    'name' => str_random(10),
    'email' => str_random(8) . '@qq.com',
    'password' => bcrypt('secret')
]);
DB::table('users')->where('id', '>', $id)->update(['name' => str_random(8)]);
DB::table('users')->where('id', '>=', $id)->delete();
$affectedRows = DB::table('users')->truncate();

$num = DB::table('users')->count();
$sum = DB::table('users')->sum('id');
$avg = DB::table('users')->avg('id');
$min = DB::table('users')->min('id');
$max = DB::table('users')->max('id');

DB::table('posts')->whereDay('created_at', '28')->get();

DB::table('users')
    ->where('options->language', 'en')
    ->get();
DB::table('users')
    ->whereJsonContains('options->languages', ['en_US', 'zh_CN'])
    ->get();

# Eloquent
# 查询
$table=Student::all();
$row=Student::find(1002);
// 新建
$stu=new Student();
$stu->name='orm2';
$stu->save();
Student::create(['name'=>'orm3','age'=>13]); //create方法批量添加数据
// 删除
Student::destroy(1006,1007);
Student::where('id',1008)->delete(); //通过查询构建器删除
// 修改
$stu=Student::find(1005);
$stu->age=21;
$stu->save();
Student::where('id',1005)->update(['age'=>22]);//通过查询构建器修改

$posts = Cache::remember('index.posts', $minutes = 30, function()
{
    return Post::with('comments', 'tags', 'author', 'seo')->whereHidden(0)->get();
});
```

### collection

* 为处理数组数据提供了流式、方便的封装
* flat
* map

## 事件 Event

一种很好的应用解耦方式,一个事件可以拥有多个互不依赖的监听器

* 流程
  + **注册事件和监听器映射**
    * EventServiceProvider的 listen 属性数组用于事件（键）到对应的监听器（值）的注册,添加events 和 listerner
    * php artisan event:generate 将自动生成 EventServiceProvider中所注册的事件(类)模板和监听器模板
    * 在此基础之上进行修改来实现完整事件和监听器定义
    * 可以在 EventServiceProvider 类的 boot 方法中通过注册闭包事件来实现全局监听
  + **定义事件**(Event) ：一个包含与事件相关信息数据的容器，不包含其它逻辑
    * 传递到 listener 消息体
  + **定义监听器**(Listener) ：事件监听器在 handle 方法中接受了事件实例作为参数
    * 停止事件传播：监听器 handle 方法中返回 false 来停止事件传播到其他的监听器
  + **触发事件**：调用 event 辅助函数可触发事件，事件将被分发到已经注册监听器上
    * 模型 $events

- 观察者模式实现

* 事件订阅者
  + 订阅可以把很多处理器（handler）放到一个类里面，然后用一个 listner 把它们集合起来
  + EventServiceProvider 中 subscribe属性中声明
  + 允许在单个类中定义多个事件处理器，还应该定义一个 subscribe 方法，这个方法接受一个事件分发器的实例，通过调用事件分发器的 listen 方法来注册事件监听器，然后在 EventServiceProvider 类的 $subscribe 属性中注册订阅者
* 队列化事件监听器
  + 如果监听器中需要实现一些耗时的任务，比如发送邮件或者进行 HTTP 请求，那把它放到队列中处理是非常有用的
  + 在使用队列化监听器，须在服务器或者本地环境中配置队列并开启一个队列监听器，还要增加 ShouldQueue 接口到监听器类
  + 如果想要自定义队列的连接和名称，可以在监听器类中定义 $connection 和 $queue 属性
  + 如果队列监听器任务执行次数超过在工作队列中定义的最大尝试次数，监听器的 failed 方法将会被自动调用
* 事件是一种『钩子』，Fire 事件的位置就是放置钩子的地方。解耦，事件只定义发生了什么事
* 一种管理 + 实现的体现，首先有一个总的目录，可以宏观的看到所有事件，而不需要每次都要打开控制器的方法才能知道注册后会发生什么
* 事件订阅者是指那些在类本身中订阅多个事件的类，通过事件订阅者可以在单个类中定义多个事件处理器
  - 订阅者需要定义一个 subscribe 方法，该方法中传入一个事件分发器实例
* 场景

```php
// 服务类　去实现事件的创建和触发，不关心具体多少调用方需要监听
class DemoService
{
    public function demo()
    {
        //创建一个事件
        $event = new Event();

        ...

        //执行事件 通知旁观者
        $event->trigger();
    }
}

// 调用方，调用方仅仅需要知道服务类创建了哪些事件
class DoService
{
    public function do()
    {
        //为事件增加旁观者
        $event->add(new Observer1());
        $event->add(new Observer2());
    }
}

php artisan make:event // 创建事件
php artisan make:listener // 创建事件监听者，可以为多个
```

## Mail

```sh
php artisan make:mail OrderShipped

php artisan make:mail OrderShipped --markdown=emails.orders.shipped

php artisan vendor:publish --tag=laravel-mail
```

## Eloquent

Eloquent ORM 以ActiveRecord形式来和数据库进行交互，拥有全部的数据表操作定义，单个模型实例对应数据表中的一行

* config/database.php中包含了模型的相关配置项。Eloquent 模型约定：

  + 数据表名：模型以单数形式命名(CamelCase)，对应的数据表为蛇形复数名(snake_cases)，模型的$table属性也可用来指定自定义的数据表名称
  + 主键：模型默认以id为主键且假定id是一个递增的整数值，也可以通过primaryKey来自定义；如果主键非递增数字值，应设置primaryKey来自定义；如果主键非递增数字值，应设置incrementing = false
  + 时间戳：模型会默认在你的数据库表有 created_at 和 updated_at 字段，设置timestamps=false可关闭模型自动维护这两个字段；timestamps=false可关闭模型自动维护这两个字段；dateFormat 属性用于在模型中设置自己的时间戳格式
  + 数据库连接：模型默认会使用应用程序中配置的数据库连接，如果你想为模型指定不同的连接，可以使用 $connection 属性自定义
  + 批量赋值：当用户通过 HTTP 请求传入了非预期的参数，并借助这些参数 create 方法更改了数据库中你并不打算要更改的字段，这时就会出现批量赋值（Mass-Assignment）漏洞，所以你需要先在模型上定义一个 fillable(白名单，允许批量赋值字段名数组)或fillable(白名单，允许批量赋值字段名数组)或guarded(黑名单，禁止批量赋值字段名数组)

* 步骤

  - Article::find (1); 发现没有 find 方法就会调用 Model 的__callStatic
  - callStatic 方法又回去调用 call 方法，这时发现有 find 方法
  - find 方法会调用 where 拼装要查询的参数，然后调用 first ()
  - 因为 first () 只需要取 1 条，所以设置 $limit 1
  - 最后组装 sql
  - 交给 mysql 执行 返回结果。

- 模型软删除：如果模型有一个非空值 deleted_at，代表模型已经被软删除了。要在模型上启动软删除，则必须在模型上使用Illuminate\Database\Eloquent\SoftDeletes trait 并添加 deleted_at 字段到你的模型 $dates 属性上和数据表中，通过调用trashed方法可查询模型是否被软删除

- 查询作用域：Laravel允许对模型设定全局作用域和本地作用域(包括动态范围)，全局作用域允许我们为模型的所有查询添加条件约束(定义一个实现 Illuminate\Database\Eloquent\Scope 接口的类)，而本地作用域允许我们在模型中定义通用的约束集合(模型方法前加上一个 scope 前缀)。作用域总是返回查询构建器

- 隐藏和显示属性：模型 hidden属性用于隐藏属性和关联的输出，hidden属性用于隐藏属性和关联的输出，visible 属性用于显示属性和关联的输出，另外makeVisible()还可用来临时修改可见性。当你要对关联进行隐藏时，需使用关联的方法名称，而不是它的动态属性名称

  ```
  1 全局作用域定义：
  2 <?php
  3
  4 namespace App\Scopes;
  5
  6 use Illuminate\Database\Eloquent\Scope;
  7 use Illuminate\Database\Eloquent\Model;
  8 use Illuminate\Database\Eloquent\Builder;
  9
  10 class AgeScope implements Scope
  11 {
  12     /**
  13      * 应用作用域
  14      *
  15      * @param  \Illuminate\Database\Eloquent\Builder  $builder
  16      * @param  \Illuminate\Database\Eloquent\Model  $model
  17      * @return void
  18      */
  19     public function apply(Builder $builder, Model $model)
  20     {
  21         return $builder->where('age', '>', 200);
  22     }
  23 }
  24
  25 本地作用域：
  26 <?php
  27
  28 namespace App;
  29
  30 use Illuminate\Database\Eloquent\Model;
  31
  32 class User extends Model
  33 {
  34     /**
  35      * 限制查询只包括受欢迎的用户。
  36      *
  37      * @return \Illuminate\Database\Eloquent\Builder
  38      */
  39     public function scopePopular($query)
  40     {
  41         return $query->where('votes', '>', 100);
  42     }
  43
  44     /**
  45      * 限制查询只包括活跃的用户。
  46      *
  47      * @return \Illuminate\Database\Eloquent\Builder
  48      */
  49     public function scopeActive($query)
  50     {
  51         return $query->where('active', 1);
  52     }
  53 }
  54
  55 动态范围：
  56 <?php
  57
  58 namespace App;
  59
  60 use Illuminate\Database\Eloquent\Model;
  61
  62 class User extends Model
  63 {
  64     /**
  65      * 限制查询只包括指定类型的用户。
  66      *
  67      * @return \Illuminate\Database\Eloquent\Builder
  68      */
  69     public function scopeOfType($query, $type)
  70     {
  71         return $query->where('type', $type);
  72     }
  73 }
  ```

  1 <?php
  2
  3 namespace App;
  4
  5 use Illuminate\Database\Eloquent\Model;
  6 use Illuminate\Database\Eloquent\SoftDeletes;
  7
  8 class Flight extends Model
  9 {
  10     use SoftDeletes;
  11
  12     /**
  13      * 需要被转换成日期的属性。
  14      *
  15      * @var array
  16      */
  17     protected $dates = ['deleted_at'];
  18 }

1 // 用属性取回航班，当结果不存在时创建它...
2 $flight = App\Flight::firstOrCreate(['name' => 'Flight 10']);
3
4 // 用属性取回航班，当结果不存在时实例化一个新实例...
5 $flight = App\Flight::firstOrNew(['name' => 'Flight 10']);

```
  1 <?php
  2
  3 namespace App;
  4
  5 use Illuminate\Database\Eloquent\Model;
  6
  7 class User extends Model
  8 {
  9     /**
  10      * 在数组中可见的属性。
  11      *
  12      * @var array
  13      */
  14     protected $visible = ['first_name', 'last_name'];
  15 }
  16 ?>
  17
  18 //makeVisible()用来临时修改可见性
  19 return $user->makeVisible('attribute')->toArray();
```

- 访问器和修改器：访问器(getFooAttribute)和修改器(setFooAttribute)可以让你修改 Eloquent 模型中的属性或者设置它们的值，比如你想要使用 Laravel 加密器来加密一个被保存在数据库中的值，当你从 Eloquent 模型访问该属性时该值将被自动解密。访问器和修改器要遵循cameCase命名规范，修改器会设置值到 Eloquent 模型内部的 $attributes 属性上

```
 1 <?php
 2
 3 namespace App;
 4
 5 use Illuminate\Database\Eloquent\Model;
 6
 7 class User extends Model
 8 {
 9     /**
10      * 获取用户的名字。
11      *
12      * @param  string  $value
13      * @return string
14      */
15     public function getFirstNameAttribute($value)
16     {
17         return ucfirst($value);
18     }
19
20      /**
21      * 设定用户的名字。
22      *
23      * @param  string  $value
24      * @return void
25      */
26     public function setFirstNameAttribute($value)
27     {
28         $this->attributes['first_name'] = strtolower($value);
29     }
30 }
```

而对于访问器与修改器的调用将是模型对象自动进行的

```
1 $user = App\User::find(1);
2 $user->first_name = 'Sally';//将自动调用相应的修改器
3 $firstName = $user->first_name;//将自动调用相应的访问器
```

- 追加属性：在转换模型到数组或JSON时，你希望添加一个在数据库中没有对应字段的属性，首先你需要为这个值定义一个 访问器，然后添加该属性到改模型的 appends 属性中

  ```
  1 <?php
  2
  3 namespace App;
  4
  5 use Illuminate\Database\Eloquent\Model;
  6
  7 class User extends Model
  8 {
  9      /**
  10      * 访问器被附加到模型数组的形式。
  11      *
  12      * @var array
  13      */
  14     protected $appends = ['is_admin'];
  15
  16     /**
  17      * 为用户获取管理者的标记。
  18      *
  19      * @return bool
  20      */
  21     public function getIsAdminAttribute()
  22     {
  23         return $this->attributes['admin'] == 'yes';
  24     }
  25 }
  ```

- 属性类型转换：$casts 属性数组在模型中提供了将属性转换为常见的数据类型的方法，且键是那些需要被转换的属性名称，值则是代表字段要转换的类型。支持的转换的类型有：integer、real、float、double、string、boolean、object、array、collection、date、datetime、timestamp

  ```
  1 <?php
  2
  3 namespace App;
  4
  5 use Illuminate\Database\Eloquent\Model;
  6
  7 class User extends Model
  8 {
  9     /**
  10      * 应该被转换成原生类型的属性。
  11      *
  12      * @var array
  13      */
  14     protected $casts = [
  15         'is_admin' => 'boolean',//is_admin 属性以整数（0 或 1）被保存在我们的数据库中，把它转换为布尔值
  16     ];
  17 }
  ```

- 序列化： Laravel模型及关联可递归序列化成数组或JSON

```
 //单个模型实例序列化成数组
 $user = App\User::with('roles')->first();
 return $user->toArray();
 //集合序列化成数组
 5 $users = App\User::all();
 6 return $users->toArray();
 7
 8 //单个模型实例序列化成JSON
 9 $user = App\User::find(1);
10 return $user->toJson();
11 //直接进行string转换会将模型或集合序列化成JSON
12 $user = App\User::find(1);
13 return (string) $user;
14 //因此你可以直接从应用程序的路由或者控制器中返回 Eloquent 对象
15 Route::get('users', function () {
16     return App\User::all();
17 });
```

- 关联(方法)与动态属性：在 Eloquent 模型中，关联被定义成方法（methods），也可以作为强大的查询语句构造器

`$user->posts()->where('active', 1)->get();` Eloquent 模型支持多种类型的关联：一对一、一对多、多对多、远层一对多、多态关联、多态多对多关联,举个例子，一个 User 模型会关联一个 Phone 模型，一对一关联(hasOne)

```
 1 <?php
 2
 3 namespace App;
 4
 5 use Illuminate\Database\Eloquent\Model;
 6
 7 class User extends Model
 8 {
 9     /**
10      * 获取与用户关联的电话号码
11      */
12     public function phone()
13     {
14         return $this->hasOne('App\Phone');
15     }
16 }
```

动态属性允许你访问关联方法，使用 Eloquent 的动态属性来获取关联记录，如同他们是定义在模型中的属性

`$phone = User::find(1)->phone;`

Eloquent 会假设对应关联的外键名称是基于模型名称的。在这个例子里，它会自动假设 Phone 模型拥有 user_id 外键。如果你想要重写这个约定，则可以传入第二个参数到 hasOne 方法里

`return $this->hasOne('App\Phone', 'foreign_key');`

如果你想让关联使用 id 以外的值，则可以传递第三个参数至 hasOne 方法来指定你自定义的键

`return $this->hasOne('App\Phone', 'foreign_key', 'local_key');`

- 如果我们要在 Phone 模型上定义一个反向关联，此关联能够让我们访问拥有此电话的 User 模型。我们可以定义与 hasOne 关联相对应的 belongsTo 方法

```
 1 <?php
 2
 3 namespace App;
 4
 5 use Illuminate\Database\Eloquent\Model;
 6
 7 class Phone extends Model
 8 {
 9     /**
10      * 获取拥有该电话的用户模型。
11      */
12     public function user()
13     {
14         return $this->belongsTo('App\User');
15     }
16 }
```

- 模型事件： Laravel为模型定义的事件包括creating, created, updating, updated, saving, saved, deleting, deleted, restoring, restored。 模型上定义一个 $events 属性

  ```
  1 <?php
  2
  3 namespace App;
  4
  5 use App\Events\UserSaved;
  6 use App\Events\UserDeleted;
  7 use Illuminate\Notifications\Notifiable;
  8 use Illuminate\Foundation\Auth\User as Authenticatable;
  9
  10 class User extends Authenticatable
  11 {
  12     use Notifiable;
  13
  14     /**
  15      * 模型的时间映射。
  16      *
  17      * @var array
  18      */
  19     protected $events = [
  20         'saved' => UserSaved::class,
  21         'deleted' => UserDeleted::class,
  22     ];
  23 }
  ```

如果在一个给定的模型中监听许多事件，也可使用观察者将所有监听器变成一个类，类的一个方法就是一个事件监听器

```php
1 $flights = App\Flight::where('active', 1)
2                ->orderBy('name', 'desc')
3                ->take(10)
4                ->get();


# 定义观察者：
<?php
namespace App\Observers;
use App\User;
class UserObserver
{
    /**
     * 监听用户创建的事件。
     *
     * @param  User  $user
     * @return void
     */
    public function created(User $user)
    {
        //
    }
    /**
     * 监听用户删除事件。
     *
     * @param  User  $user
     * @return void
     */
    public function deleting(User $user)
    {
        //
    }
}
# 注册观察者
<?php
namespace App\Providers;
use App\User;
use App\Observers\UserObserver;
use Illuminate\Support\ServiceProvider;
class AppServiceProvider extends ServiceProvider
{
    /**
     * 运行所有应用.
     *
     * @return void
     */
    public function boot()
    {
        User::observe(UserObserver::class);
    }
    /**
     * 注册服务提供.
     *
     * @return void
     */
    public function register()
    {
        //
    }
}
```

## 广播 Broadcast

* service
  - [Pusher](https://pusher.com/)
  - [Laravel Websockets](https://github.com/beyondcode/laravel-websockets)
  - Redis 的功能 pub/sub
  - Socket.IO

## 通知

```sh
php artisan make:notification InvoicePaid
```

## [jetstream](https://jetstream.laravel.com/)

* Available Stacks
  - Livewire + Blade
  - Inertia.js + Vue
* [livewire](https://github.com/livewire/livewire):A full-stack framework for Laravel that takes the pain out of building dynamic UIs.
  - [](https://xueyuanjun.com/post/22042)

```sh
composer require laravel/jetstream
php artisan jetstream:install livewire

php artisan jetstream:install inertia --teams

npm install && npm run dev

php artisan migrate
```

## [Laravel Mix](https://github.com/JeffreyWay/laravel-mix )

* An elegant wrapper around Webpack for the 80% use case. The power of webpack, distilled for the rest of us. <https://laravel-mix.com/>
* Laravel Elixir的精神继承者，完全基于Webpack而不是Gulp。
* 使用通用CSS和JavaScript预处理器定义Laravel应用的Webpack构建步骤提供了流式API。通过简单的方法链定义流式资源管道
* css
  - less
  - sass
  - stylus
  - PossCSS
* 在 webpack.mix.js 文件中调用 mix.sourceMaps() 来激活  Source Map,在编译资源的时候可以提供额外的调试信息给浏览器的开发者工具
  - ES2015 语法
  - 模块
  - 编译 .vue 文件
  - 最小化生产环境

```js
mix.less('resources/assets/less/app.less', 'public/css', {
    strictMath: true
});

mix.sass('resources/assets/sass/app.sass', 'public/css', {
    precision: 5
});

mix.stylus('resources/assets/stylus/app.styl', 'public/css', {
    use: [
        require('rupture')()
    ]
});

mix.sass('resources/assets/sass/app.scss', 'public/css')
   .options({
        postCss: [
            require('postcss-css-variables')()
        ],
          processCssUrls: false
   });

// combine
mix.styles([
    'public/css/vendor/normalize.css',
    'public/css/vendor/videojs.css'
], 'public/css/all.css');

let productionSourceMaps = false;

mix.js('resources/js/app.js', 'public/js')
   .sourceMaps(productionSourceMaps, 'source-map') .version();

mix.webpackConfig({
    resolve: {
        modules: [
            path.resolve(__dirname, 'vendor/laravel/spark/resources/assets/js')
        ]
    }
});
```

## 认证 authentication

* 配置文件: config/auth.php
* 登录认证时做两件事，一个是从数据库存取用户数据，一个是把用户登录状态保存起来
* 认证组件由「guards」和「providers」组成
  - Guard 定义了用户在每个请求中如何实现认证,存储用户认证信息,主要和 Session 打交道（API 例外）
  - Provider 定义了如何从持久化存储中获取用户信息
    + 底层支持通过 Eloquent 和数据库查询构建器两种方式来获取用户
    + 可以定义额外的 Provider
* 浏览器认证服务
  - 通过 Auth 和 Session 门面提供了内置的认证和会话服务，这些功能提供了基于 Cookie 的浏览器请求认证，可以使用这些门面提供的方法验证用户登录凭证然后对用户进行认证操作
  - 这些服务还会自动存储相应的认证数据到用户 Session 并通过 HTTP 响应发送包含对应 Session ID 的 Cookie
* API 认证服务
  - 只会通过浏览器访问，使用 Laravel 内置的认证服务就好
  - 提供了 API 接口，可以在 Passport 和 Sanctum 扩展包中任选其一提供 API 令牌认证。一般来说，优先使用 Sanctum，因为它位 API 认证、SPA 认证以及移动端认证提供了简单但完整的解决方案，包括对「作用域」和「权限」的支持
  - Passport 可用于构建基于 OAuth2 规范的认证功能，比如我们要做开放平台，需要提供针对第三方应用的授权认证（比如微信、支付宝、QQ、微博之类的开发平台），则只能选择 Passport
  - 新安装的 Laravel 项目中快速搭建认证系统，推荐使用 Laravel Jetstream，其中包含了 Laravel 内置的认证服务（通过 Laravel Fortify 集成）和 Laravel Sanctum 提供完整的用户认证解决方案
* [Laravel Fortify](https://github.com/laravel/fortify) 是一个针对 Laravel 项目开发的开箱即用认证后端，实现了本文档介绍的大部分功能，包括基于 Cookie 的认证以及双因子认证和邮箱验证。

## 授权 authorization

* 一个简单的方式来管理授权逻辑以便控制对资源的访问权限,有两种方式，Gate 和 Policy 分别看作路由和控制器
* Gate 提供了简单的基于闭包的方式进行授权
  - 用于判断用户是否有权进行某项操作的闭包，通常使用 Gate 门面定义在 App\Providers\AuthServiceProvider 类中
  - Gate 总是接收用户实例作为第一个参数，还可以接收相关的 Eloquent 模型实例作为额外参数
  - 授权动作：使用 allows 或 denies 方法，需要注意的是可以不传用户实例到这些方法，Laravel 会自动将用户实例（当前用户）传递到 Gate 闭包
* Policy：对特定模型或资源上的复杂授权逻辑进行分组
  - 用于组织基于特定模型或资源的授权逻辑类

```sh
php artisan make:policy PostPolicy
```

## Passport

* 一个 OAuth2 认证服务商，提供了多个 OAuth2「授权类型」以便颁发不同类型的访问令牌。总体来说，它是一个健全且复杂的 API 认证扩展包
  + 大多数应用并不需要 OAuth2 规范提供的复杂特性，这会让开发者和用户都感到困惑
  + 开发者也一直对如何使用 Passport 认证 SPA 应用和移动应用感到困扰。

## Laravel Sanctum

* 更加简单、更加精练的认证扩展包用于处理来自浏览器的第一方 Web 请求和基于令牌的 API 请求
* 对于除了 API 接口之外还提供第一方 Web UI 的应用、或者前后端分离的单页面应用、以及带有移动客户端的 Laravel 应用，优先推荐使用 Sanctum 这个认证扩展包
* Laravel Sanctum 是一个混合了 Web/API 认证的扩展包，可用于管理应用的整个认证流程
* 工作原理
  - 对于一个基于 Sanctum 提供认证服务的应用，当服务端接收到请求时，Sanctum 会先判断请求是否包含引用了认证 Session 的会话 Cookie，
  - 如果没有通过会话 Cookie 认证，Sanctum 会继续检查请求是否包含 API 令牌，如果 API 令牌存在，则 Sanctum 会使用 API 令牌认证请求。想要了解更多关于这个处理流程的底层细节

## Laravel Jetstream

* 一个 UI 扩展包，基于 Tailwind CSS、Laravel Livewire 以及 Inertia.js 等前端技术栈为 Laravel Fortify 的后端认证服务提供了美观的、现代的 UI 界面。
* Laravel Jetstream 除了提供基于浏览器的 Cookie 认证外，还内置集成了 Laravel Sanctum 提供 API 令牌认证

```sh
laravel new blog --jet
```

## Mail

* `Swift_TransportException with message 'Expected response code 250 but got code "530", with message "530 5.7.1 Authentication required`

## Hash

* Hash 门面为存储用户密码提供了安全的 Bcrypt 和 Argon2 哈希算法

## Restful风格

一般认为Restful风格的资源定义不包含操作，但是在Laravel中操作(动词)也可作为一种资源来定义。下图是对Laravel中资源控制器操作原理的描述，可以看到，create、edit就直接出现在了URI中，它们是一种合法的资源。对于create和edit这两种资源的访问都采用GET方法来实现，第一眼看到顿感奇怪，后来尝试通过artisan console生成资源控制器，并注意到其对create、edit给出注释" Show the form for "字样，方知它们只是用来展现表单而非提交表单的。

## 扩展开发

* 最好的方式是使用 contracts ，而不是 facades，因为开发的包并不能访问所有 Laravel 提供的测试辅助函数，模拟 contracts 要比模拟 facade 简单很多

* 服务提供者：服务提供者是扩展包与 Laravel 连接的重点，须定义自己的服务提供者并继承自 Illuminate\Support\ServiceProvider 基类

* 路由：若要为扩展包定义路由，只需在包的服务提供者的 boot 方法中传递 routes 文件路径到 loadRoutesFrom 方法即可

- 配置文件：你可以选择性地将扩展包的配置文件发布(publishes)到应用程序本身的config目录上或者合并(mergeConfigFrom)到应用程序里的副本配置文件中，但不应在配置文件中定义闭包函数，当执行 config:cache Artisan命令时，它们将不能正确地序列化

  ```
  1 /**
  2  * 在注册后进行服务的启动。
  3  *
  4  * 用户使用 vendor:publish 命令可将扩展包的文件将会被复制到指定的位置上。
  5  *
  6  * @return void
  7  */
  8 public function boot()
  9 {
  10     $this->publishes([
  11         __DIR__.'/path/to/config/courier.php' => config_path('courier.php'),
  12     ]);
  13 }
  14
  15 $value = config('courier.option');//只要你的配置文件被发布，就可以如其它配置文件一样被访问
  16
  17 /**
  18  * 或者选择性在容器中注册绑定。
  19  *
  20  * 此方法仅合并配置数组的第一级。如果您的用户部分定义了多维配置数组，则不会合并缺失的选项
  21  *
  22  * @return void
  23  */
  24 public function register()
  25 {
  26     $this->mergeConfigFrom(
  27         __DIR__.'/path/to/config/courier.php', 'courier'
  28     );
  29 }
  ```

- 数据库迁移：如果你的扩展包包含数据库迁移，需要使用 loadMigrationsFrom 方法告知 Laravel 如何去加载它们。在运行 php artisan migrate 命令时，它们就会自动被执行，不需要把它们导出到应用程序的 database/migrations 目录

```php
/**
 * 在注册后进行服务的启动。
 *
 * @return void
 */
public function boot()
{
    $this->loadMigrationsFrom(__DIR__.'/path/to/migrations');
}
```

- 语言包：如果扩展包里面包含了本地化，则可以使用 loadTranslationsFrom 方法来告知 Laravel 该如何加载。下例假设你的包名称为courier

```php
/**
 * 在注册后进行服务的启动。
 *
 * @return void
 */
public function boot()
{
    $this->loadTranslationsFrom(__DIR__.'/path/to/translations', 'courier');
     //如果不想发布语言包至应用程序的 resources/lang/vendor 目录，请注销对$this->publishes()调用。运行 Laravel 的 vendor:publish Artisan 命令可将扩展包的语言包复制到指定的位置上
     $this->publishes([
         __DIR__.'/path/to/translations' => resource_path('lang/vendor/courier'),
     ]);
 }

echo trans('courier::messages.welcome');//扩展包翻译参照使用了双分号 package::file.line 语法
```

- 视图：若要在 Laravel 中注册扩展包 视图，则必须告诉 Laravel 你的视图位置，loadViewsFrom 方法允许传递视图模板路径与扩展包名称两个参数。需要特别指出的是，当你使用 loadViewsFrom 方法时，Laravel 实际上为你的视图注册了两个位置：一个是应用程序的 resources/views/vendor 目录，另一个是你所指定的目录。Laravel会先检查 resources/views/vendor 目录是否存在待加载视图，如果不存在，才会从指定的目录去加载，这个方法可以让用户很方便的自定义或重写扩展包视图。

```
 1 /**
 2  * 在注册后进行服务的启动。
 3  *
 4  * @return void
 5  */
 6 public function boot()
 7 {
 8     $this->loadViewsFrom(__DIR__.'/path/to/views', 'courier');
 9
10     //若要发布扩展包的视图至 resources/views/vendor 目录，则必须使用服务提供者的 publishes 方法。运行 Laravel 的 vendor:publish Artisan 命令时，扩展包的视图将会被复制到指定的位置上
11     $this->publishes([
12         __DIR__.'/path/to/views' => resource_path('views/vendor/courier'),
13     ]);
14 }
15
16 //扩展包视图参照使用了双分号 package::view 语法
17 Route::get('admin', function () {
18     return view('courier::admin');
19 });
```

- 命令：使用 commands 方法给扩展包注册 Artisan 命令，命令的定义要遵循Laravel Artisan 命令规范

```
 1 /**
 2  * 在注册后进行服务的启动。
 3  *
 4  * @return void
 5  */
 6 public function boot()
 7 {
 8     if ($this->app->runningInConsole()) {
 9         $this->commands([
10             FooCommand::class,
11             BarCommand::class,
12         ]);
13     }
14 }
```

- 公用 Assets：可以发布像 JavaScript、CSS 和图片这些资源文件到应用程序的 public 目录上。当用户执行 vendor:publish 命令时，您的 Assets 将被复制到指定的发布位置。由于每次更新包时通常都需要覆盖资源，因此您可以使用 --force 标志：php artisan vendor:publish --tag=public --force

```
 1 /**
 2  * 在注册后进行服务的启动。
 3  *
 4  * @return void
 5  */
 6 public function boot()
 7 {
 8     $this->publishes([
 9         __DIR__.'/path/to/assets' => public_path('vendor/courier'),
10     ], 'public');
11 }
```

- 发布群组文件：你可能想让用户不用发布扩展包的所有资源文件，只需要单独发布扩展包的配置文件即可，通过在调用 publishes 方法时使用标签来实现

```php
 /**
  * 在注册后进行服务的启动。
  *
  * @return void
  */
 public function boot()
 {
     $this->publishes([
         __DIR__.'/../config/package.php' => config_path('package.php')
     ], 'config');

     $this->publishes([
         __DIR__.'/../database/migrations/' => database_path('migrations')
     ], 'migrations');
 }
```

对于上例运行命令 php artisan vendor:publish --tag=config 时将忽略掉migrations部分

```php
// Laravel Migration Error: Syntax error or access violation: 1071 Specified key was too long; max key length is 767 bytes

# /app/Providers/AppServiceProvider.php
use Illuminate\Support\Facades\Schema; //Import Schema

function boot()
{
    Schema::defaultStringLength(191); //Solved by increasing StringLength
}
```

## 调试

* 配置:`APP_DEBUG`
* `storage/logs`中日志文件
* lavavel批量插入保证字段名称、数量一致，不要赛选数据

```sh
php artisan clear-compiled
php artisan cache:clear
php artisan route:clear
$arr[$key]['android_url'] = isset($val[6]) ? trim($val[6]) : '';
```

## 队列

```sh
php artisan queue:table # 创建一个迁移的队列数据库工作
php artisan migrate

php artisan make:job ProcessPodcast

php artisan queue:failed  # 列出全部失败的队列工作
php artisan queue:failed-table # 创建一个迁移的失败的队列数据库工作表
php artisan queue:flush # 清除全部失败的队列工作
php artisan queue:forget #  删除一个失败的队列工作
php artisan queue:listen #  监听一个确定的队列工作
php artisan queue:restart # 重启现在正在运行的所有队列工作
php artisan queue:retry # 重试一个失败的队列工作
php artisan queue:subscribe # 订阅URL,放到队列上
php artisan queue:work  # 进行下一个队列任务
```

## 任务调度 Task scheduler

```sh
php artisan schedule:run
```

## API 资源类

```sh
php artisan make:resource Users --collection
php artisan make:resource UserCollection
```

## [laravel/dusk](https://github.com/laravel/dusk)

* provides an expressive, easy-to-use browser automation and testing API.
* 提供了优雅的、易于使用的浏览器自动化测试API。默认情况下，Dusk不需要在机器上安装JDK或Selenium，取而代之的，Dusk使用一种独立的ChromeDriver安装方式。
* Dusk在操作过程中使用了真实的浏览器，所以可以很轻松地对那些重度使用JavaScript的应用进行测试和交互：

```sh
composer require --dev laravel/dusk
php artisan dusk:install
# .env 文件中设置 APP_URL 变量 与在浏览器中打开本应用的 URL 匹配
# 手动启动 chromedrive
php artisan dusk

php artisan dusk:make LoginTest
```

## 测试

```php
php artisan make:test UserTest --unit
```

## 日志

* 默认日志：storage/logs/laravel.log
* 有效通道驱动列表
  - stack 用于创建「多通道」通道的聚合器
  - single  基于单文件/路径的日志通道（StreamHandler）
  - daily 基于 RotatingFileHandler 的 Monolog 驱动，以天为维度对日志进行分隔
  - slack 基于 SlackWebhookHandler 的 Monolog 驱动
  - syslog  基于 SyslogHandler 的 Monolog 驱动
  - errorlog  基于 ErrorLogHandler 的 Monolog 驱动
  - monolog Monolog 改成驱动，可以使用所有支持的 Monolog 处理器
  - custom  调用指定改成创建通道的驱动
* 配置 Single 和 Daily 通道
  - bubble  表示消息在被处理后是否冒泡到其它通道  true
  - permission  日志文件权限  644
  - locking 在日志文件写入前尝试锁定它 false
* 模式
  - single 所有日志信息都会输出到storage/log/laravel.log文件中
  - daily 每天的日志信息都会输出到storage/log文件夹下的日志文件中，日志文件名会包含当天的年月日信息；
  - syslog 日志信息输出到系统的日志文件中；比如，笔者是centos系统，日志信息写到了/var/log/message文件中
  - errorlog 相当于调用PHP的error_log语句，没有写入到文件
* 级别
  - debug 代码引用为 "MonologLogger::DEBUG"  100 详细的调试信息
  - info  代码引用为 "MonologLogger::INFO" 200 感兴趣的事件，比如登录、退出
  - notice  代码引用为 "MonologLogger::NOTICE" 250 普通但值得注意的事件
  - warning 代码引用为 "MonologLogger::WARNING"  300 警告但不是错误，比如使用了被废弃的API
  - error 代码引用为 "MonologLogger::ERROR"  400 运行时错误，不需要立即处理但需要被记录和监控
  - critical  代码引用为 "MonologLogger::CRITICAL" 500 严重问题，如异常
  - alert 代码引用为 "MonologLogger::ALERT"  550 需要立即采取行动，如数据库异常等
  - emergency 代码引用为 "MonologLogger::EMERGENCY"  600

```php
# config/app.php  配置

// 日志模式，可选择参数有 "single", "daily", "syslog", "errorlog"
'log' => env('APP_LOG', 'single'),
// 错误等级，为 "RFC 5424" 中定义的八种日志级
'log_level' => env('APP_LOG_LEVEL', 'debug'),

use Illuminate\Support\Facades\Log;

Log::alert("数据库访问异常");
Log::critical("系统出现未知错误");
Log::error("指定变量不存在");
Log::warning("该方法已经被废弃");
Log::notice("用户在异地登录");
Log::info("用户xxx登录成功");
Log::debug("调试信息");
```

### [tymondesigns/jwt-auth](https://github.com/tymondesigns/jwt-auth)

🔐 JSON Web Token Authentication for Laravel & Lumen <http://jwt-auth.com>

```sh
composer require tymon/jwt-auth # 修改app.php 添加到providers

php artisan vendor:publish --provider="Tymon\JWTAuth\Providers\LaravelServiceProvider" # 生成配置文件
php artisan jwt:secret # 使用
```

## 前后端分离配置

* `npm install`
* 配置`webpack proxy`
* 运行`arstian serve`
  - 创建migration,并配置字段
  - migrate
  - 生成模型与控制器
  - 配置api路由
* `npm run watch`
* 配置单页首页
  - 引入app.css 和 app.js
  - 配置前端路由
  - 创建api请求
  - 页面创建

## 部署

* 步骤
  - 开发环境改成生产环境 (.env) `APP_ENV=local 改成 APP_ENV=production`
  - 关闭调试模式 (.env) `APP_DEBUG=true 改成 APP_DEBUG=false`
  - 缓存配置
    + `php artisan config:cache // 配置缓存，生成：bootstrap/cache/config.php`
    + `php artisan config:clear // 清除配置缓存`
  - 缓存路由
    + `php artisan route:cache // 路由缓存，生成：bootstrap/cache/routes.php`
    + `php artisan config:clear // 清除路由缓存`
  - 性能优化 `php artisan optimize // 优化，生成编译文件；`
  - 优化自动加载 `composer dump-autoload --optimize`
  - 禁止列出上传目录
* 工具
  - [envoyer](https://envoyer.io):Deployments you've only dreamed about. Zero downtime. Zero fuss

```
<Files *>
    Options -Indexes
</Files>
```

## [telescope](https://github.com/laravel/telescope)

* provides insight into the requests coming into your application, exceptions, log entries, database queries, queued jobs, mail, notifications, cache operations, scheduled tasks, variable dumps and more
* Telescope 可深入了解进入应用程序的请求、异常、日志条目、数据库查询、排队作业、邮件、通知、缓存操作、计划任务、变量转储等
* [uri](./telescope)

```sh
composer require laravel/telescope
php artisan telescope:install
php artisan migrate

php artisan telescope:publish # 更新
# 从 app 配置文件中删除 TelescopeServiceProvider 服务提供注册。相反，在 AppServiceProvider 的 register 方法中手动注册服务
php artisan vendor:publish --tag=telescope-migrations # 导出默认迁移
# 配置文件 config/telescope.php 监听配置
# app/Providers/TelescopeServiceProvider.php
# 过滤 授权
```

## [Algolia](https://www.algolia.com/doc/api-client/laravel/algolia-and-scout/)

Algolia is a hosted full-text, numerical, and faceted search engine capable of delivering realtime results from the first keystroke

```sh
composer require laravel/scout
php artisan vendor:publish --provider="Laravel\Scout\ScoutServiceProvider"
php artisan scout:import "App\Models\Post"
```

### [l5-repository](https://github.com/andersao/l5-repository)

Laravel 5 - Repositories to abstract the database layer <http://andersao.github.io/l5-repository>

* presenter，显示需求
* repository，存取需求
* validator，参数验证需求
* services，业务逻辑

## 优化

* PHP
  - 服务器启用 PHP OPcache 扩展缓存 PHP 字节码
  - 使用 CDN 访问静态资源（图片、JS、CSS 文件）减轻带宽负载
  - 对于所有高频业务 SQL 查询，合理优化索引字段，提升数据库查询性能
  - 合理使用缓存，减少与 MySQL 服务器的交互，降低磁盘 IO（Laravel 本身支持多种缓存驱动，可以非常方便地集成不同缓存系统，我这里使用的是 Redis 作为缓存驱动）
  - PHP 本身不支持并发编程，但是可以引入队列系统异步处理耗时任务，比如邮件发送、涉及数据库操作的数据统计和更新、事件监听和处理等，通过多个队列进程实现并发处理效果（Laravel 本身支持多种队列驱动，可以非常方便地集成不同队列系统，并且提供了 Horizon 这一队列系统解决方案，这里使用的是 Horizon + Redis + Supervisor 搭建小型队列系统）
  - 通过 composer install --optimize-autoloader --no-dev 初始化项目依赖，以便加速 Composer 定位指定类对应的加载文件，同时不安装开发环境使用的依赖。
* Laravel 项目通用优化手段(在线上生产环境执行这些优化命令，不要在开发环境执行，因为开发环境文件变动频繁，缓存没有意义，反而增加了清除缓存的麻烦)

- 路由缓存：通过 php artisan route:cache 命令可以缓存 Laravel 项目注册的所有路由，避免请求期间动态解析，如果应用包含很多路由，这个优化效果还是很不错的，对请求性能提升效果很显著；
- 视图缓存：通过 php artisan view:cache 命令可以提前将所有 Blade 视图模板编译，避免在请求期间动态编译视图，从而提升系统性能；
- 配置缓存：通过 php artisan config:cache 命令可以将项目配置文件缓存起来提升应用性能。

## 扩展

* 框架
  - [laravel](https://github.com/laravel/laravel) A PHP framework for web artisans
  - [bagisto](https://github.com/bagisto/bagisto):A Free and Opensource laravel eCommerce framework built for all to build and scale your business. <https://bagisto.com>
  - [blog](https://github.com/jcc/blog):PJ Blog is an open source blog built with Laravel and Vue.js.
  - [repository](https://github.com/bosnadev/repository):Laravel Repositories is a package for Laravel 5 which is used to abstract the database layer. This makes applications much easier to maintain. <https://bosnadev.com>
  - [lumen-framework](https://github.com/laravel/lumen-framework)
    + [lumen](https://github.com/laravel/lumen): a stunningly fast PHP micro-framework for building web applications with expressive, elegant syntax.
* API
  - [api](https://github.com/dingo/api)A RESTful API package for the Laravel and Lumen frameworks.
  - [elixir](https://github.com/laravel/elixir)Fluent API for Gulp
  - [wizard](https://github.com/mylxsw/wizard):Wizard是基于Laravel开发框架开发的一款开源项目（API）文档管理工具。 <https://mylxsw.github.io/wizard/>
  - [laravel-cors](https://github.com/barryvdh/laravel-cors):Adds CORS (Cross-Origin Resource Sharing) headers support in your Laravel application
* [laravel-swoole](https://github.com/swooletw/laravel-swoole):High performance HTTP server based on Swoole. Speed up your Laravel or Lumen applications.
* logger
  - [laravel-query-logger](https://github.com/overtrue/laravel-query-logger):📝 A dev tool to log all queries for laravel application.
  - [laravel-request-logger](https://github.com/andersao/laravel-request-logger):HTTP request logger middleware for Laravel
  - [tracker](https://github.com/antonioribeiro/tracker):Laravel Stats Tracker
* [livewire](https://github.com/livewire/livewire):A full-stack framework for Laravel that takes the pain out of building dynamic UIs.
* Oauth
  - [socialite](https://github.com/laravel/socialite):an expressive, fluent interface to OAuth authentication with Facebook, Twitter, Google, LinkedIn, GitHub, GitLab and Bitbucket
  - [socialite](https://github.com/overtrue/socialite)::octocat: Socialite is an OAuth2 Authentication tool. It is inspired by laravel/socialite, you can easily use it without Laravel.
  - [passport](https://github.com/laravel/passport):Laravel Passport is an OAuth2 server and API authentication package that is simple and enjoyable to use.
* websocket
  - [laravel-websockets](https://github.com/beyondcode/laravel-websockets):Websockets for Laravel. Done right.<https://docs.beyondco.de/laravel-websockets/>
  - [echo](https://github.com/laravel/echo):provides a more robust, efficient alternative to continually polling your application for websocket changes.
* admin
  - [laravel-admin](https://github.com/z-song/laravel-admin):Build a full-featured administrative interface in ten minutes <http://laravel-admin.org>
  - [voyager](https://github.com/the-control-group/voyager):Voyager - The Missing Laravel Admin <https://laravelvoyager.com>
  - [LaraAdmin](https://laraadmin.com/)
  - [Laravel Nova](https://nova.laravel.com):a beautifully designed administration panel for Laravel. Carefully crafted by the creators of Laravel to make you the most productive developer in the galaxy.
  - [dcat-admin](https://github.com/jqhph/dcat-admin):fire 使用很少的代码快速构建一个功能完善的高颜值后台系统，内置丰富的后台常用组件，开箱即用，让开发者告别冗杂的HTML代码。 <http://www.dcatadmin.com>
* pay
  - [cashier](https://github.com/laravel/cashier):provides an expressive, fluent interface to Stripe's subscription billing services.
* [browser-kit-testing](https://github.com/laravel/browser-kit-testing)This package provides a backwards compatibility layer for Laravel 5.3 style "BrowserKit" testing on Laravel 5.4.
* [envoy](https://github.com/laravel/envoy):Elegant SSH tasks for PHP. a clean, minimal syntax for defining common tasks you run on your remote servers
* [laravel-dompdf](https://github.com/barryvdh/laravel-dompdf):A DOMPDF Wrapper for Laravel
* RBAC
  - [entrust](https://github.com/Zizaco/entrust):Role-based Permissions for Laravel 5
  - [laravel-permission](https://github.com/spatie/laravel-permission):Associate users with roles and permissions
  - [Adldap2-Laravel](https://github.com/Adldap2/Adldap2-Laravel):LDAP Authentication & Management for Laravel
  - [Laravel-Administrator](https://github.com/FrozenNode/Laravel-Administrator):An administrative interface package for Laravel <http://administrator.frozennode.com/>
* [html](https://github.com/LaravelCollective/html):HTML and Form Builders for the Laravel Framework
* [mercurius](https://github.com/launcher-host/mercurius):Real-time Messenger for Laravel <http://mercurius.launcher.host/>
* DB
  - [CRUD](https://github.com/Laravel-Backpack/CRUD):Build a custom admin interface for your Eloquent models, using Laravel 5.2 to 5.7 <http://backpackforlaravel.com>
  - [database](https://github.com/illuminate/database):[READ ONLY] Subtree split of the Illuminate Database component (see laravel/framework)
  - [prequel](https://github.com/Protoqol/Prequel)
  - [laravel-mongodb](https://github.com/jenssegers/laravel-mongodb#installation):A MongoDB based Eloquent model and Query builder for Laravel (Moloquent) <https://jenssegers.com>
* [Laravel-Throttle](https://github.com/GrahamCampbell/Laravel-Throttle):A rate limiter for Laravel 5 <https://gjcampbell.co.uk/>
* debug
  - [laravel-debugbar](https://github.com/barryvdh/laravel-debugbar):Laravel Debugbar (Integrates PHP Debug Bar)
  - [laravel-stats](https://github.com/stefanzweifel/laravel-stats):📈 Get insights about your Laravel or Lumen Project
  - [laravel-debug-helper](https://github.com/wujunze/laravel-debug-helper):Laravel package to help debug
  - [laravel-dump-server](link)
  - [laravel-ide-helper](https://github.com/barryvdh/laravel-ide-helper):Laravel IDE Helper
* [codex](https://github.com/codex-project/codex):Extendable Documentation Platform written in Laravel 5. Generate easy and awesome documentation! <http://codex-project.ninja>
* [laravelshift](https://laravelshift.com/):laravel upgrade
* [Laravel Analyzer](link)
* MQ
  - [laravel-queue-rabbitmq](https://github.com/vyuldashev/laravel-queue-rabbitmq):RabbitMQ driver for Laravel Queue
  - [horizon](https://github.com/laravel/horizon):Horizon provides a beautiful dashboard and code-driven configuration for your Laravel powered Redis queues. <https://horizon.laravel.com>
* [laravel-generator](https://github.com/InfyOmLabs/laravel-generator):InfyOm Laravel Generator - API, Scaffold, CRUD Laravel Generator <http://labs.infyom.com/laravelgenerator/>
* [laravel-fractal](https://github.com/spatie/laravel-fractal):An easy to use Fractal wrapper built for Laravel and Lumen applications
* [laravel-snappy](https://github.com/barryvdh/laravel-snappy):Laravel Snappy PDF
* [health](https://github.com/antonioribeiro/health):Laravel Health Panel
* [laravel-backup](https://github.com/spatie/laravel-backup):A package to backup your Laravel app
* [Elasticquent](https://github.com/elasticquent/Elasticquent):Maps Laravel Eloquent models to Elasticsearch types
* [larecipe](https://github.com/saleem-hadad/larecipe):🍪 Write gorgeous documentations for your products using Markdown inside your Laravel app. <https://larecipe.binarytorch.com.my/>
* [laravel-zero](https://github.com/laravel-zero/laravel-zero):A PHP framework for console artisans <https://laravel-zero.com>
* [laravel-modules](https://github.com/nWidart/laravel-modules):Module Management In Laravel <https://nwidart.com/laravel-modules/>
* cron
  - [Forge](https://forge.laravel.com):Painless PHP Servers Provision and deploy unlimited PHP applications on DigitalOcean, Linode, AWS, and more.
* [Laravel Spark](https://spark.laravel.com):provides the perfect starting point for your next big idea. Forget all the boilerplate and focus on what matters: your application. <https://github.com/laravel/spark-docs>
* [laravel-wechat](https://github.com/overtrue/laravel-wechat):微信 SDK for Laravel, 基于 overtrue/wechat

```sh
# laravel-admin
composer require encore/laravel-admin
php artisan vendor:publish --provider="Encore\Admin\AdminServiceProvider"
# config/admin.php，修改安装的地址、数据库连接、以及表名
php artisan config:cache
php artisan admin:install
# 查看版本
composer show encore/laravel-admin
php artisan
# 强制发布静态资源文件
php artisan vendor:publish --tag=laravel-admin-assets --force
# 强制发布语言包文件
php artisan vendor:publish --tag=laravel-admin-lang --force
# 清理视图缓存
php artisan view:clear

## laravel-ide-helper
composer require --dev barryvdh/laravel-ide-helper
# config/app.php
Barryvdh\LaravelIdeHelper\IdeHelperServiceProvider::class,

php artisan ide-helper:generate # phpDoc generation for Laravel Facades

php artisan ide-helper:meta # PhpStorm Meta file
composer require --dev doctrine/dbal

php artisan ide-helper:models Post User # phpDocs for models
php artisan ide-helper:models --ignore="Post,User"
php artisan ide-helper:models --dir="path/to/models" --dir="app/src/Model"

## laravel-debugbar
composer require barryvdh/laravel-debugbar --dev # APP_DEBUG = true

Debugbar::info($object);
Debugbar::error('Error!');
Debugbar::warning('Watch out…');
Debugbar::addMessage('Another message', 'mylabel');

Debugbar::startMeasure('render','Time for rendering');
Debugbar::stopMeasure('render');
Debugbar::addMeasure('now', LARAVEL_START, microtime(true));
Debugbar::measure('My long operation', function() {
    // Do something…
});

# laravel/envoy
composer global require laravel/envoy
# / Envoy.blade.php
@servers(['web' => ['user@192.168.1.1']])
# 变量
@setup
    $now = new DateTime();
    $environment = isset($env) ? $env : "testing";
@endsetup
@include('vendor/autoload.php')
@story('deploy')
    git
    composer
@endstory
@task('git')
    git pull origin master
@endtask

@task('composer')
    composer install
@endtask
@task('deploy', ['on' => 'web'])
    cd site

    @if ($branch)
        git pull origin {{ $branch }}
    @endif

    php artisan migrate
@endtask
@finished
    @slack('webhook-url', '#bots')
    @discord('discord-webhook-url')
@endfinished

envoy run deploy --branch=master

# laravel/scout  为 Eloquent 模型 的全文搜索提供了基于驱动的简单的解决方案。通过使用模型观察者， Scout 会自动同步 Eloquent 记录的搜索索引
composer require laravel/scout
php artisan vendor:publish --provider="Laravel\Scout\ScoutServiceProvider"

# horizon
composer require laravel/horizon
php artisan horizon:install
php artisan queue:failed-table
php artisan migrate

php artisan horizon
php artisan horizon:pause|continue|terminate
```

## 项目

* [Laravel5.5 + Vue开发单页应用](http://www.laravel-vue.xyz/2018/03/22/laravel_vue_v2/)
* [code 好事源代码](https://github.com/Ucer/codehaoshi):记录日常开发的笔记，用 laravel 与 vue 构建。后台使用 ucer-admin 管理系统开发
* [https://github.com/summerblue/larabbs](A forum project base on Laravel 5.5)
* [bagisto/bagisto](https://github.com/bagisto/bagisto):A Free and Opensource laravel eCommerce framework built for all to build and scale your business. <https://bagisto.com>
* [qqphp-com/laravel-blog-poetry-all](https://github.com/qqphp-com/laravel-blog-poetry-all):Laravel诗词博客-匠心编程，热爱生活。喜欢就 Star 吧 <http://qqphp.com>

```sh
git clone git@github.com:summerblue/larabbs.git
# 修改 homestead.html,添加配置
vagrant provision
composer install
# 配置.env文件

php artisan migrate --seed
php artisan key:generate

yarn install

# 首页地址：http://larabbs.app/
# 管理后台：http://larabbs.app/admin

username: summer@yousails.com
password: password

# Non-static method Redis::hGet() cannot be called statically
```

## 参考

* [awesome-laravel](https://github.com/chiraggude/awesome-laravel)A curated list of bookmarks, packages, tutorials, videos and other cool resources from the Laravel ecosystem
* [Awesome-Laravel-Education](https://github.com/fukuball/Awesome-Laravel-Education)
* [artisan-road](https://github.com/samedreams/artisan-road):Programmers are artisans （This book is a guide for artisans）

* [Learning_Laravel_Kernel](https://github.com/kevinyan815/Learning_Laravel_Kernel):Laravel核心代码学习
* [原理机制篇](http://www.cnblogs.com/XiongMaoMengNan/p/6644892.html)
* [laravel-source-analysis](https://github.com/LeoYang90/laravel-source-analysis):详解 laravel 源码
* [深入 Laravel 核心](https://learnku.com/docs/laravel-core-concept/5.5)
* [Laravel 之道](https://learnku.com/docs/the-laravel-way/5.6)
* [xiaohuilam/laravel](https://github.com/xiaohuilam/laravel/wiki):Laravel 深入浅出指南 —— Laravel 5.7 源代码解析，新手进阶指南。
* [Learn-Laravel-5](https://github.com/johnlui/Learn-Laravel-5):Laravel 5 系列入门教程
* [quickstart-basic](https://github.com/laravel/quickstart-basic):A sample task list application. <http://laravel.com/docs/quickstart>
* [基于 Laravel 的 API 服务端架构代码](http://laravelacademy.org/post/5449.html)
* [laravel入门教程](https://d.laravel-china.org/docs/5.5)
* [基于 Laravel + Vue 构建 API 驱动的前后端分离应用系列](https://laravelacademy.org/category/api-app)
* [基于 Laravel 构建前后端分离应用系列教程](https://laravelacademy.org/api-driven-development-laravel-vue)
* [laravel blog](https://tn710617.github.io/zh-tw/page/2/)

## 问题

> Call to undefined function openssl_encrypt() # 开启OpenSSL扩展
> SQLSTATE[HY000]: General error: 1215 Cannot add foreign key constraint
> 关联表中类型不一致造成

<https://d.laravel-china.org/docs/5.3/facades#how-facades-work>
<https://d.laravel-china.org/docs/5.5/container>
<http://www.jb51.net/article/73462.htm>
<http://blog.csdn.net/u013474436/article/details/52847326>
<http://www.cnblogs.com/lyzg/p/6181055.html>
<http://www.cnblogs.com/XiongMaoMengNan/p/6644892.html>
<http://laravel-china.github.io/php-the-right-way/>
