# [laravel/laravel](https://github.com/laravel/framework)

A PHP Framework For Web Artisans https://laravel.com

## 环境

### homestead

- 安装virtualbox and vagrant

```sh
brew install homebrew/php/php71  # 确保 ~/.composer/vendor/bin
sudo chown -R $USER .composer/
composer global require laravel/valet
export PATH=$PATH:~/.composer/vendor/bin

valet install  # 终端ping一下任意 *.dev 域名
valet domain app # # 修改域名

brew install mysql # 安装MySQL
brew services start mysql # 启动服务

composer global update # 升级

valet stop
valet uninstall
valet restart
```

- parallels `vagrant plugin install vagrant-parallels`

## 下载&&安装

- vagrant box add laravel/homestead（下不动）
- 下载软件 <https://atlas.hashicorp.com/laravel/boxes/homestead/versions/2.1.0/providers/virtualbox.box>

## 升级

通过composer升级:根据升级文档修改composer.json配置`composer update`

## 加载

- vagrant box add --name laravel\homestead virtualbox.box
- vagrant list
- git clone <https://github.com/laravel/homestead.git> Homestead
- 初始化配置文件 init.bat
- 修改scripts/homestead.rb Homestead.yaml文件 config.vm.box = "laravel/homestead" #box的名字（需与盒子列表中的一致） config.vm.box_version = "0" #box的版本号（需与盒子列表中的一致） config.vm.box_check_update = false #box是否检查更新 config.ssh.username = 'vagrant' config.ssh.password = 'vagrant'
- 文件路径配置 vagrant reload --provision

## Homestead

- vagrant box add laravel/homestead || vagrant box add laravel/homestead <https://atlas.hashicorp.com/laravel/boxes/homestead>
- git clone <https://github.com/laravel/homestead.git> Homestead
- bash init.sh
- 修改.homestread\Homestead.yaml
- vagrant provision
- vagrant init
- vagrant up
- 添加ip

```yaml
folders:
    * map: D:\Code    <!-- 项目地址 -->
      to: /home/vagrant/Code   <!-- 虚拟机的项目地址 -->
sites:
    * map: laravel.app  <!-- 添加的站点名称 -->
      to: /home/vagrant/Code/Laravel/public <<!-- 站点对应的虚拟机文件 -->
```

Homestead(vagrant up):The SSH command responded with a non-zero exit status.

Composer代理镜像

from @golaravel

"repositories": [ {"type": "composer", "url": "<http://packagist.phpcomposer.com"}>, {"packagist": false} ],

## valet

## 源文件安装

```
cd /var/www
git clone https://github.com/laravel/laravel.git
cd /var/www/laravel
sudo composer install

chown -R www-data.www-data /var/www/laravel
chmod -R 755 /var/www/laravel
chmod -R 777 /var/www/laravel/storage
```

## 框架本地化

```
cp .env.example .env
php artisan key:generate

mysql -u root -p

mysql> CREATE DATABASE laravel;
mysql> GRANT ALL ON laravel.* to 'laravel'@'localhost' IDENTIFIED BY 'secret_password';
mysql> FLUSH PRIVILEGES;
mysql> quit

# update the database settings in .env file
# Configuring Apache for Laravel
# sudo service apache2 restart
```

## Laragon

## [laradock](https://github.com/LaraDock/laradock.git)

## Artisan

* 列出所有可用命令:php artisan list
* 查看路由：php artisan route:list
* 显示目前的Laravel版本:php artisan --version
* 帮助命令：php artisan help migrate
* 使程序进入维护模式:php artisan down
* 使程序退出维护模式:php artisan up
* 显示当前框架环境:php artisan env
* 生成应用的key(APP_KEY)为一个随机字符串:php artisan key:generate
* 重新生成框架的自动加载文件:composer dump-autoload
* 进入tinker环境：php artisan tinker

```sh
composer create-project laravel/laravel
composer create-project laravel/laravel=5.2.* blog --prefer-dist    # 可以指定版本和项目名
php artisan serve
artisan serve --port=8010 --host=127.0.0.1
php artisan down
php artisan up
php artisan env # 显示当前框架环境
php artisan fresh 清除包含框架外的支架
php artisan help  显示命令行的帮助
php artisan list  列出命令
php artisan migrate 运行数据库迁移
php artisan env 显示当前框架环境
php artisan optimize  为了更好的框架去优化性能
php artisan serve 在php开发服务器中服务这个应用
php artisan tinker  在应用中交互
php artisan app:name #  设置应用程序命名空间

php artisan auth:clear-resets 清除过期的密码重置密钥 未使用过
php artisan cache:clear 清除应用程序缓存
php artisan cache:table 创建一个缓存数据库表的迁移

php artisan config:cache  创建一个加载配置的缓存文件
php artisan config:clear  删除配置的缓存文件
php artisan db:seed 数据库生成模拟数据
php artisan event:generate  生成event和listen  需要实现配置eventserviceprivoder

php artisan make:command #  创建一个新的命令处理程序类
php artisan make:console #  生成一个Artisan命令
php artisan key:generate  # 设置程序密钥   No supported encrypter found. The cipher and / or key length are invalid.
php artisan make:controller # 生成一个资源控制类
php artisan make:middleware # 生成一个中间件
php artisan make:migration #  生成一个迁移文件
php artisan make:model #  生成一个Eloquent 模型类
php artisan make:provider # 生成一个服务提供商的类
php artisan make:request #  生成一个表单消息类
php artisan migrate:install # 创建一个迁移库文件
php artisan make:migration #  生成一个迁移文件

php artisan migrate:refresh # 复位并重新运行所有的迁移
php artisan migrate:reset # 回滚全部数据库迁移
php artisan migrate:rollback #  回滚最后一个数据库迁移
php artisan migrate:status  # 显示列表的迁移

php artisan queue:failed  # 列出全部失败的队列工作
php artisan queue:failed-table # 创建一个迁移的失败的队列数据库工作表
php artisan queue:flush # 清除全部失败的队列工作
php artisan queue:forget #  删除一个失败的队列工作
php artisan queue:listen #  监听一个确定的队列工作
php artisan queue:restart # 重启现在正在运行的所有队列工作
php artisan queue:retry # 重试一个失败的队列工作
php artisan queue:subscribe # 订阅URL,放到队列上
php artisan queue:table # 创建一个迁移的队列数据库工作表
php artisan queue:work  # 进行下一个队列任务

php artisan route:cache # 为了更快的路由登记，创建一个路由缓存文件
php artisan route:clear # 清除路由缓存文件
php artisan route:list # 列出全部的注册路由

php artisan schedule:run # 运行预定命令

php artisan session:table # 创建一个迁移的SESSION数据库工作表

php artisan vendor:publish # 发表一些可以发布的有用的资源来自提供商的插件包

php artisan baum # Get Baum version notice.
php artisan baum:install # Scaffolds a new migration and model suitable for Baum
```

```php
//生成30条数据
factory(App\User::class,30)->create()
// tinker的使用
E:\opensource\blog>php artisan tinker
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
"insert into `users` (`name`, `email`, `password`, `updated_at`, `created_at`) v
alues (?, ?, ?, ?, ?)"
=> true
exit
```

### Cache

- 创建一个路由缓存文件:php artisan routes:cache
- 清除路由缓存文件:php artisan routes:clear
- 清除应用程序缓存:php artisan cache:clear
- php artisan clear-compiled  移除编译过的类文件
- php artisan optimize 编译过的类文件优化
- php artisan view:clear

### Controller && Model

```php
// 创建一个空控制器
php artisan make:controller BlogController
// 创建Rest风格资源控制器
php artisan make:controller PhotoController --resource
// 指定创建位置 在app目录下创建TestController
php artisan make:controller App\TestController
// 指定路径创建
php artisan make:Model App\\Models\\User(linux or macOs 加上转义符)

创建一个中间件:php artisan make:middleware
创建一个模型:php artisan make:model
创建一个命令类:php artisan make:command
创建一个Artisan命令:php artisan make:console
发布来自插件包的资源:php artisan vendor:publish
```

### 迁移与填充 Migration && Seeder

```php
// 数据迁移
php artisan migrate
// 创建迁移
php artisan make:migration create_users_table
// 指定路径
php artisan make:migration --path=app\providers create_users_table
// 一次性创建
// 下述命令会做两件事情：
// 在 app 目录下创建模型类 App\Post
// 创建用于创建 posts 表的迁移，该迁移文件位于 database/migrations 目录下。
// php artisan make:model --migration Post
// 运行数据库迁移
php artisan migrate
# 初始化迁移数据表:php artisan migrate:install
# 重置并重新执行所有的数据迁移:php artisan migrate:refresh
# 回滚所有的数据迁移:php artisan migrate:reset
# 回滚最近一次数据迁移:php artisan migrate:rollback
# 填充种子数据 测试用:php artisan db:seed
# 创建一个种子数据:php artisan make:seeder
# 创建一个数据迁移:php artisan make:migration name

  // 创建要填充的数据类
php artisan make:seeder UsersTableSeeder

use Illuminate\Database\Seeder;

class UsersTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        factory(\App\User::class)->times(300)->create();
    }
}

// DatabaseSeeder里面调用UserTableSeeder
public function run()
    {
         $this->call(UsersTableSeeder::class);
    }
// 数据填充（全部表）
php artisan db:seed
// 指定要填充的表
php artisan db:seed --class=UsersTableSeeder
```

### Command

```php
// 生成命令
php artisan make:command TopicMakeExcerptCommand --command=topics:excerpt
//在 app/Console/Kernel.php 文件里面, 添加以下
protected $commands = [
    \App\Console\Commands\TopicMakeExcerptCommand::class,
];
//在生成的TopicMakeExcerptCommand.php 文件, 修改以下区域
<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;

class TopicMakeExcerptCommand extends Command
{
    /**
     * 1\. 这里是命令行调用的名字, 如这里的: `topics:excerpt`,
     * 命令行调用的时候就是 `php artisan topics:excerpt`
     *
     * @var string
     */
    protected $signature = 'topics:excerpt';

    /**
     * 2\. 这里填写命令行的描述, 当执行 `php artisan` 时
     *   可以看得见.
     *
     * @var string
     */
    protected $description = '这里修改为命令行的描述';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * 3\. 这里是放要执行的代码, 如在我这个例子里面,
     *   生成摘要, 并保持.
     *
     * @return mixed
     */
    public function handle()
    {
        $topics = Topic::all();
        $transfer_count = 0;

        foreach ($topics as $topic) {
          if (empty($topic->excerpt))
          {
              $topic->excerpt = Topic::makeExcerpt($topic->body);
              $topic->save();
              $transfer_count++;
          }
        }
        $this->info("Transfer old data count: " . $transfer_count);
        $this->info("It's Done, have a good day.");
    }
}
// 命令行调用
php artisan topics:excerpt
```

### request 主要用于表单验证

```php
php artisan make:request TagCreateRequest
\\创建的类存放在 app/Http/Requests 目录下
<?php

namespace App\Http\Requests;

use App\Http\Requests\Request;

class TagCreateRequest extends Request
{

    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'tag' => 'required|unique:tags,tag',
            'title' => 'required',
            'subtitle' => 'required',
            'layout' => 'required',
        ];
    }
}

//  应的Controller方法里引入 注意这里使用的是TagCreateRequest
public function store(TagCreateRequest $request)
{
    $tag = new Tag();
    foreach (array_keys($this->fields) as $field) {
        $tag->$field = $request->get($field);
    }
    $tag->save();
    return redirect('/admin/tag')
        ->withSuccess("The tag '$tag->tag' was created.");
}
```

## 概念

- markdown:在邮件中利用预置模板和邮件通知组件，由于消息使用Markdown格式编写，因此Laravel可以将这些消息渲染成美观、响应式的HTML模板的同时自动为其生成纯文本副本
- dusk: 提供了优雅的、易于使用的浏览器自动化测试API。默认情况下，Dusk不需要在机器上安装JDK或Selenium，取而代之的，Dusk使用一种独立的ChromeDriver安装方式。由于Dusk在操作过程中使用了真实的浏览器，所以可以很轻松地对那些重度使用JavaScript的应用进行测试和交互：
- Mix是Laravel Elixir的精神继承者，完全基于Webpack而不是Gulp。Laravel Mix为使用通用CSS和JavaScript预处理器定义Laravel应用的Webpack构建步骤提供了流式API。通过简单的方法链，你可以定义流式资源管道
- Blade组件和插槽为section和layout提供了类似的好处
- 目前支持高阶消息传递的集合方法有：contains、each、every、filter、first、 map、 partition、 reject、sortBy、 sortByDesc和 sum。
- Eloquent事件处理器现在可以被映射到事件对象上，这为我们处理Eloquent事件并让其变得易于测试提供了一种直观的方式
- Facades
- 中间件
- 路由
- 服务容器
- 服务提供者
- Contracts 契约模式
- CSRF保护
- guzzle
- 广播
- tinker：所有的 Laravel 应用都提供了 Tinker ---- 一个由 PsySH 扩展包驱动的REPL（Read-Eval-Print Loop，即终端命令行"读取-求值-输出"循环工具）。Tinker 允许你通过命令行与整个 Laravel 应用进行交互，包括 Eloquent ORM、任务、事件等等。
- Elixir

### 设计模式

* Facade模式（又称外观模式，门脸模式）
* 管道模式
* 单例模式
* 依赖注入
* 反转控制

## 数据操作

- facade
- 查询构造器
- Eloquent ORM

### collection

flat map

## 请求周期

Laravel 采用了单一入口模式，应用的所有请求入口都是 public/index.php 文件。

- 注册类文件自动加载器：Laravel通过composer进行依赖管理，并在bootstrap/autoload.php中注册了Composer Auto Loader (PSR-4)，应用中类的命名空间将被映射到类文件实际路径，不再需要开发者手动导入各种类文件，而由自动加载器自行导入。因此，Laravel允许你在应用中定义的类可以自由放置在Composer Auto Loader能自动加载的任何目录下，但大多数时候还是建议放置在app目录下或app的某个子目录下
- 创建服务容器：从 bootstrap/app.php 文件中取得 Laravel 应用实例 $app (服务容器)
- 创建 HTTP / Console 内核：传入的请求会被发送给 HTTP 内核或者 console 内核进行处理，HTTP 内核继承自 Illuminate\Foundation\Http\Kernel 类。它定义了一个 bootstrappers 数组，数组中的类在请求真正执行前进行前置执行，这些引导程序配置了错误处理，日志记录，检测应用程序环境，以及其他在请求被处理前需要完成的工作；HTTP 内核同时定义了一个 HTTP 中间件列表，所有的请求必须在处理前通过这些中间件处理 HTTP session 的读写，判断应用是否在维护模式， 验证 CSRF token 等等
- 载入服务提供者至容器：在内核引导启动的过程中最重要的动作之一就是载入服务提供者到你的应用，服务提供者负责引导启动框架的全部各种组件，例如数据库、队列、验证器以及路由组件。因为这些组件引导和配置了框架的各种功能，所以服务提供者是整个 Laravel 启动过程中最为重要的部分，所有的服务提供者都配置在 config/app.php 文件中的 providers 数组中。首先，所有提供者的 register 方法会被调用；一旦所有提供者注册完成，接下来，boot 方法将会被调用
- 分发请求：一旦应用完成引导和所有服务提供者都注册完成，Request 将会移交给路由进行分发。路由将分发请求给一个路由或控制器，同时运行路由指定的中间件

## 服务容器和服务提供者

服务容器是 Laravel 管理类依赖和运行依赖注入的有力工具，在类中可通过 $this->app 来访问容器，在类之外通过 $app 来访问容器；服务提供者是 Laravel 应用程序引导启动的中心，关系到服务提供者自身、事件监听器、路由以及中间件的启动运行。应用程序中注册的路由通过RouteServiceProvider实例来加载；事件监听器在EventServiceProvider类中进行注册；中间件又称路由中间件，在app/Http/Kernel.php类文件中注册，调用时与路由进行绑定。在新创建的应用中，AppServiceProvider 文件中方法实现都是空的，这个提供者是你添加应用专属的引导和服务的最佳位置，当然，对于大型应用你可能希望创建几个服务提供者，每个都具有粒度更精细的引导。服务提供者在 config/app.php 配置文件中的providers数组中进行注册

`php artisan make:provider HelperServiceProvider`

```php
namespace App\Providers;

use Riak\Connection;
use Illuminate\Support\ServiceProvider;

class RiakServiceProvider extends ServiceProvider
{
    /**
     * 在容器中注册绑定
     *
     * @return void
     */
    public function register()
    {
        $this->app->singleton(Connection::class, function ($app) {
            return new Connection(config('riak'));
        });
    }
}
```

## 依赖注入

Laravel 实现依赖注入方式有两种：自动注入和主动注册。自动注入通过参数类型提示由服务容器自动注入实现；主动注册则需开发人员通过绑定机制来实现，即绑定服务提供者或类（参考： <http://d.laravel-china.org/docs/5.4/container> ）。

- 绑定服务提供者或类：这种方式对依赖注入的实现可以非常灵活多样

```php
use Illuminate\Support\Facades\Storage;
use App\Http\Controllers\PhotoController;
use App\Http\Controllers\VideoController;
use Illuminate\Contracts\Filesystem\Filesystem;

$this->app->when(PhotoController::class)
          ->needs(Filesystem::class)
          ->give(function () {
              return Storage::disk('local');
          });

$this->app->when(VideoController::class)
          ->needs(Filesystem::class)
          ->give(function () {
              return Storage::disk('s3');
          });
```

- 参数类型声明：通过对类的构造器参数类型、类的方法参数类型、闭包的参数类型给出提示来实现

```php
<?php

namespace App\Http\Controllers;

use App\Users\Repository as UserRepository;

class UserController extends Controller
{
    /**
     * user repository 实例。
     */
    protected $users;

    /**
     * 控制器构造方法。
     *
     * @param  UserRepository  $users
     * @return void
     */
    public function __construct(UserRepository $users)
    {
        $this->users = $users;
    }

    /**
     * 储存一个新用户。
     *
     * @param  Request  $request
     * @return Response
     */
    public function store(Request $request)
    {
        $name = $request->input('name');

        //
    }
}
```

- 路由参数依赖：下边的示例使用 Illuminate\Http\Request 类型提示的同时还获取到路由参数id

```
// 你的路由可能是这样定义的：
Route::put('user/{id}', 'UserController@update');

// 而控制器对路由参数id的依赖却可能是这样实现的：
<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class UserController extends Controller
{
    /**
     * 更新指定的用户。
     *
     * @param  Request  $request
     * @param  string  $id
     * @return Response
     */
    public function update(Request $request, $id)
    {
        //
    }
}
```

## Artisan Console

Laravel利用PHP的CLI构建了强大的Console工具artisan，artisan几乎能够创建任何你想要的模板类以及管理配置你的应用，在开发和运维管理中扮演着极其重要的角色，artisan是Laravel开发不可或缺的工具。在Laravel根目录下运行：PHP artisan list可查看所有命令列表。用好artisan能极大地简化开发工作，并减少错误发生的可能；另外，还可以编写自己的命令。下面列举部分比较常用的命令：

- 启用维护模式：php artisan down --message='Upgrading Database' --retry=60
- 关闭维护模式：php artisan up
- 生成路由缓存：php artisan route:cache
- 清除路由缓存：php artisan route:clear
- 数据库迁移 Migrations：php artisan make:migration create_users_table --create=users
- 创建资源控制器：php artisan make:controller PhotoController --resource --model=Photo
- 创建模型及迁移：php artisan make:model User -m

## 表单验证机制

表单验证在web开发中是不可或缺的，其重要性也不言而喻，也算是每个web框架的标配部件了。Laravel表单验证拥有标准且庞大的规则集，通过规则调用来完成数据验证，多个规则组合调用须以"|"符号连接，一旦验证失败将自动回退并可自动绑定视图。

下例中，附加bail规则至title属性，在第一次验证required失败后将立即停止验证；"."语法符号在Laravel中通常表示嵌套包含关系，这个在其他语言或框架语法中也比较常见

```
$this->validate($request, [
    'title' => 'bail|required|unique:posts|max:255',
    'author.name' => 'required',
    'author.description' => 'required',
]);
```

Laravel验证规则参考 <http://d.laravel-china.org/docs/5.4/validation#可用的验证规则> ；另外，在Laravel开发中还可采用如下扩展规则：

- 自定义FormRequest (须继承自 Illuminate\Foundation\Http\FormRequest )
- Validator::make()手动创建validator实例
- 创建validator实例验证后钩子
- 按条件增加规则
- 数组验证
- 自定义验证规则

## 事件机制

Laravel事件机制是一种很好的应用解耦方式，因为一个事件可以拥有多个互不依赖的监听器。事件类 (Event) 类通常保存在 app/Events 目录下，而它们的监听类 (Listener) 类被保存在 app/Listeners 目录下，使用 Artisan 命令来生成事件和监听器时他们会被自动创建。

- 注册事件和监听器：EventServiceProvider的 listen 属性数组用于事件（键）到对应的监听器（值）的注册，然后运行 php artisan event:generate将自动生成EventServiceProvider中所注册的事件(类)模板和监听器模板，然后在此基础之上进行修改来实现完整事件和监听器定义；另外，你也可以在 EventServiceProvider 类的 boot 方法中通过注册闭包事件来实现
- 定义事件(类)：事件(类)就是一个包含与事件相关信息数据的容器，不包含其它逻辑

```
 1 <?php
 2
 3 namespace App\Events;
 4
 5 use App\Order;
 6 use Illuminate\Queue\SerializesModels;
 7
 8 class OrderShipped
 9 {
10     use SerializesModels;
11
12     public $order;
13
14     /**
15      * 创建一个事件实例。
16      *
17      * @param  Order  $order
18      * @return void
19      */
20     public function __construct(Order $order)
21     {
22         $this->order = $order;
23     }
24 }
```

- 定义监听器：事件监听器在 handle 方法中接受了事件实例作为参数

  ```
  1 <?php
  2
  3 namespace App\Listeners;
  4
  5 use App\Events\OrderShipped;
  6
  7 class SendShipmentNotification
  8 {
  9     /**
  10      * 创建事件监听器。
  11      *
  12      * @return void
  13      */
  14     public function __construct()
  15     {
  16         //
  17     }
  18
  19     /**
  20      * 处理事件
  21      *
  22      * @param  OrderShipped  $event
  23      * @return void
  24      */
  25     public function handle(OrderShipped $event)
  26     {
  27         // 使用 $event->order 来访问 order ...
  28     }
  29 }
  ```

- 停止事件传播：在监听器的 handle 方法中返回 false 来停止事件传播到其他的监听器

- 触发事件：调用 event 辅助函数可触发事件，事件将被分发到它所有已经注册的监听器上

  ```
  1 <?php
  2
  3 namespace App\Http\Controllers;
  4
  5 use App\Order;
  6 use App\Events\OrderShipped;
  7 use App\Http\Controllers\Controller;
  8
  9 class OrderController extends Controller
  10 {
  11     /**
  12      * 将传递过来的订单发货。
  13      *
  14      * @param  int  $orderId
  15      * @return Response
  16      */
  17     public function ship($orderId)
  18     {
  19         $order = Order::findOrFail($orderId);
  20
  21         // 订单的发货逻辑...
  22
  23         event(new OrderShipped($order));
  24     }
  25 }
  ```

- 队列化事件监听器：如果监听器中需要实现一些耗时的任务，比如发送邮件或者进行 HTTP 请求，那把它放到队列中处理是非常有用的。在使用队列化监听器，须在服务器或者本地环境中配置队列并开启一个队列监听器，还要增加 ShouldQueue 接口到你的监听器类；如果你想要自定义队列的连接和名称，你可以在监听器类中定义 $connection 和 $queue 属性；如果队列监听器任务执行次数超过在工作队列中定义的最大尝试次数，监听器的 failed 方法将会被自动调用

  ```
  1 <?php
  2
  3 namespace App\Listeners;
  4
  5 use App\Events\OrderShipped;
  6 use Illuminate\Contracts\Queue\ShouldQueue;
  7
  8 class SendShipmentNotification implements ShouldQueue
  9 {
  10     /**
  11      * 队列化任务使用的连接名称。
  12      *
  13      * @var string|null
  14      */
  15     public $connection = 'sqs';
  16
  17     /**
  18      * 队列化任务使用的队列名称。
  19      *
  20      * @var string|null
  21      */
  22     public $queue = 'listeners';
  23
  24     public function failed(OrderShipped $event, $exception)
  25     {
  26         //
  27     }
  28 }
  ```

- 事件订阅者：事件订阅者允许在单个类中定义多个事件处理器，还应该定义一个 subscribe 方法，这个方法接受一个事件分发器的实例，通过调用事件分发器的 listen 方法来注册事件监听器，然后在 EventServiceProvider 类的 $subscribe 属性中注册订阅者

```
 1 <?php
 2
 3 namespace App\Listeners;
 4
 5 class UserEventSubscriber
 6 {
 7     /**
 8      * 处理用户登录事件。
 9      */
10     public function onUserLogin($event) {}
11
12     /**
13      * 处理用户注销事件。
14      */
15     public function onUserLogout($event) {}
16
17     /**
18      * 为订阅者注册监听器。
19      *
20      * @param  Illuminate\Events\Dispatcher  $events
21      */
22     public function subscribe($events)
23     {
24         $events->listen(
25             'Illuminate\Auth\Events\Login',
26             'App\Listeners\UserEventSubscriber@onUserLogin'
27         );
28
29         $events->listen(
30             'Illuminate\Auth\Events\Logout',
31             'App\Listeners\UserEventSubscriber@onUserLogout'
32         );
33     }
34
35 }
```

## Eloquent 模型

Eloquent ORM 以ActiveRecord形式来和数据库进行交互，拥有全部的数据表操作定义，单个模型实例对应数据表中的一行

```
1 $flights = App\Flight::where('active', 1)
2                ->orderBy('name', 'desc')
3                ->take(10)
4                ->get();
```

config/database.php中包含了模型的相关配置项。Eloquent 模型约定：

- 数据表名：模型以单数形式命名(CamelCase)，对应的数据表为蛇形复数名(snake_cases)，模型的$table属性也可用来指定自定义的数据表名称
- 主键：模型默认以id为主键且假定id是一个递增的整数值，也可以通过primaryKey来自定义；如果主键非递增数字值，应设置primaryKey来自定义；如果主键非递增数字值，应设置incrementing = false
- 时间戳：模型会默认在你的数据库表有 created_at 和 updated_at 字段，设置timestamps=false可关闭模型自动维护这两个字段；timestamps=false可关闭模型自动维护这两个字段；dateFormat 属性用于在模型中设置自己的时间戳格式
- 数据库连接：模型默认会使用应用程序中配置的数据库连接，如果你想为模型指定不同的连接，可以使用 $connection 属性自定义
- 批量赋值：当用户通过 HTTP 请求传入了非预期的参数，并借助这些参数 create 方法更改了数据库中你并不打算要更改的字段，这时就会出现批量赋值（Mass-Assignment）漏洞，所以你需要先在模型上定义一个 fillable(白名单，允许批量赋值字段名数组)或fillable(白名单，允许批量赋值字段名数组)或guarded(黑名单，禁止批量赋值字段名数组)

```
1 // 用属性取回航班，当结果不存在时创建它...
2 $flight = App\Flight::firstOrCreate(['name' => 'Flight 10']);
3
4 // 用属性取回航班，当结果不存在时实例化一个新实例...
5 $flight = App\Flight::firstOrNew(['name' => 'Flight 10']);
```

- 模型软删除：如果模型有一个非空值 deleted_at，代表模型已经被软删除了。要在模型上启动软删除，则必须在模型上使用Illuminate\Database\Eloquent\SoftDeletes trait 并添加 deleted_at 字段到你的模型 $dates 属性上和数据表中，通过调用trashed方法可查询模型是否被软删除

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
  ```

- 查询作用域：Laravel允许对模型设定全局作用域和本地作用域(包括动态范围)，全局作用域允许我们为模型的所有查询添加条件约束(定义一个实现 Illuminate\Database\Eloquent\Scope 接口的类)，而本地作用域允许我们在模型中定义通用的约束集合(模型方法前加上一个 scope 前缀)。作用域总是返回查询构建器

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

- 隐藏和显示属性：模型 hidden属性用于隐藏属性和关联的输出，hidden属性用于隐藏属性和关联的输出，visible 属性用于显示属性和关联的输出，另外makeVisible()还可用来临时修改可见性。当你要对关联进行隐藏时，需使用关联的方法名称，而不是它的动态属性名称

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

如果你在一个给定的模型中监听许多事件，也可使用观察者将所有监听器变成一个类，类的一个方法就是一个事件监听器

```
 1 定义观察者：
 2 <?php
 3
 4 namespace App\Observers;
 5
 6 use App\User;
 7
 8 class UserObserver
 9 {
10     /**
11      * 监听用户创建的事件。
12      *
13      * @param  User  $user
14      * @return void
15      */
16     public function created(User $user)
17     {
18         //
19     }
20
21     /**
22      * 监听用户删除事件。
23      *
24      * @param  User  $user
25      * @return void
26      */
27     public function deleting(User $user)
28     {
29         //
30     }
31 }
32
// 注册观察者：
34 <?php
35
36 namespace App\Providers;
37
38 use App\User;
39 use App\Observers\UserObserver;
40 use Illuminate\Support\ServiceProvider;
41
42 class AppServiceProvider extends ServiceProvider
43 {
44     /**
45      * 运行所有应用.
46      *
47      * @return void
48      */
49     public function boot()
50     {
51         User::observe(UserObserver::class);
52     }
53
54     /**
55      * 注册服务提供.
56      *
57      * @return void
58      */
59     public function register()
60     {
61         //
62     }
63 }
```

## Laravel的Restful风格

一般认为Restful风格的资源定义不包含操作，但是在Laravel中操作(动词)也可作为一种资源来定义。下图是对Laravel中资源控制器操作原理的描述，可以看到，create、edit就直接出现在了URI中，它们是一种合法的资源。对于create和edit这两种资源的访问都采用GET方法来实现，第一眼看到顿感奇怪，后来尝试通过artisan console生成资源控制器，并注意到其对create、edit给出注释" Show the form for "字样，方知它们只是用来展现表单而非提交表单的。

## 扩展开发

我们知道，Laravel本身是基于Composer管理的一个包，遵循Composer的相关规范，可以通过Composer来添加所依赖的其他Composer包，因此在做应用的扩展开发时，可以开发Composer包然后引入项目中即可；另外也可开发基于Laravel的专属扩展包。下面所讲的就是Laravel的专属扩展开发，最好的方式是使用 contracts ，而不是 facades，因为你开发的包并不能访问所有 Laravel 提供的测试辅助函数，模拟 contracts 要比模拟 facade 简单很多。

- 服务提供者：服务提供者是你的扩展包与 Laravel 连接的重点，须定义自己的服务提供者并继承自 Illuminate\Support\ServiceProvider 基类
- 路由：若要为你的扩展包定义路由，只需在包的服务提供者的 boot 方法中传递 routes 文件路径到 loadRoutesFrom 方法即可

```
1 /**
2  * 在注册后进行服务的启动。
3  *
4  * @return void
5  */
6 public function boot()
7 {
8     $this->loadRoutesFrom(__DIR__.'/path/to/routes.php');
9 }
```

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

  ```
  1 /**
  2  * 在注册后进行服务的启动。
  3  *
  4  * @return void
  5  */
  6 public function boot()
  7 {
  8     $this->loadMigrationsFrom(__DIR__.'/path/to/migrations');
  9 }
  ```

- 语言包：如果你的扩展包里面包含了本地化，则可以使用 loadTranslationsFrom 方法来告知 Laravel 该如何加载它们。下例假设你的包名称为courier

  ```
  1 /**
  2  * 在注册后进行服务的启动。
  3  *
  4  * @return void
  5  */
  6 public function boot()
  7 {
  8     $this->loadTranslationsFrom(__DIR__.'/path/to/translations', 'courier');
  9
  10     //如果不想发布语言包至应用程序的 resources/lang/vendor 目录，请注销对$this->publishes()调用。运行 Laravel 的 vendor:publish Artisan 命令可将扩展包的语言包复制到指定的位置上
  11     $this->publishes([
  12         __DIR__.'/path/to/translations' => resource_path('lang/vendor/courier'),
  13     ]);
  14 }
  15
  16 echo trans('courier::messages.welcome');//扩展包翻译参照使用了双分号 package::file.line 语法
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

- 公用 Assets：你可以发布像 JavaScript、CSS 和图片这些资源文件到应用程序的 public 目录上。当用户执行 vendor:publish 命令时，您的 Assets 将被复制到指定的发布位置。由于每次更新包时通常都需要覆盖资源，因此您可以使用 --force 标志：php artisan vendor:publish --tag=public --force

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

```
 1 /**
 2  * 在注册后进行服务的启动。
 3  *
 4  * @return void
 5  */
 6 public function boot()
 7 {
 8     $this->publishes([
 9         __DIR__.'/../config/package.php' => config_path('package.php')
10     ], 'config');
11
12     $this->publishes([
13         __DIR__.'/../database/migrations/' => database_path('migrations')
14     ], 'migrations');
15 }
```

对于上例运行命令 php artisan vendor:publish --tag=config 时将忽略掉migrations部分

<http://laravelacademy.org/post/6718.html>

<https://d.laravel-china.org/docs/5.3/facades#how-facades-work> <https://d.laravel-china.org/docs/5.5/container> <http://www.jb51.net/article/73462.htm> <http://blog.csdn.net/u013474436/article/details/52847326> <http://www.cnblogs.com/lyzg/p/6181055.html>

<http://www.cnblogs.com/XiongMaoMengNan/p/6644892.html>

<http://laravel-china.github.io/php-the-right-way/> <http://laravelacademy.org/post/6842.html>

```
//Laravel Migration Error: Syntax error or access violation: 1071 Specified key was too long; max key length is 767 bytes

\\ /app/Providers/AppServiceProvider.php
use Illuminate\Support\Facades\Schema; //Import Schema

function boot()
{
    Schema::defaultStringLength(191); //Solved by increasing StringLength
}
```

### traits



## 调试

* 配置文件中`APP_DEBUG`
* `storage/logs`中的日志文件
* lavavel批量插入保证字段名称、数量一致，不要赛选数据

$arr[$key]['android_url'] = isset($val[6]) ? trim($val[6]) : '';

## 扩展

* [laravel/lumen-framework](https://github.com/laravel/lumen-framework)
* [laravel/lumen](https://github.com/laravel/lumen): a stunningly fast PHP micro-framework for building web applications with expressive, elegant syntax.
* [laravel/framework](https://github.com/laravel/framework):
* [octobercms/october](https://github.com/octobercms/october):Free, open-source, self-hosted CMS platform based on the Laravel PHP Framework
* [dingo/api](https://github.com/dingo/api)A RESTful API package for the Laravel and Lumen frameworks.
* [laravel/elixir](https://github.com/laravel/elixir)Fluent API for Gulp.
* [laravel/cashier](https://github.com/laravel/cashier)
* [laravel/passport](https://github.com/laravel/passport):Laravel Passport is an OAuth2 server and API authentication package that is simple and enjoyable to use.
* [laravel/horizon](https://github.com/laravel/horizon):Horizon provides a beautiful dashboard and code-driven configuration for your Laravel powered Redis queues.
* [laravel/echo](https://github.com/laravel/echo):provides a more robust, efficient alternative to continually polling your application for websocket changes.
* [laravel/socialite](https://github.com/laravel/socialite):Laravel Socialite provides an expressive, fluent interface to OAuth authentication with Facebook, Twitter, Google, LinkedIn, GitHub and Bitbucket.
* [laravel/browser-kit-testing](https://github.com/laravel/browser-kit-testing)This package provides a backwards compatibility layer for Laravel 5.3 style "BrowserKit" testing on Laravel 5.4.
* [laravel/dusk](https://github.com/laravel/dusk):Laravel Dusk provides an expressive, easy-to-use browser automation and testing API.
* [laravel/envoy](https://github.com/laravel/envoy):Elegant SSH tasks for PHP.
* [barryvdh/laravel-cors](https://github.com/barryvdh/laravel-cors):Adds CORS (Cross-Origin Resource Sharing) headers support in your Laravel application
* [barryvdh/laravel-dompdf](https://github.com/barryvdh/laravel-dompdf):A DOMPDF Wrapper for Laravel
* [Zizaco/entrust](https://github.com/Zizaco/entrust):Role-based Permissions for Laravel 5
* [bosnadev/repository](https://github.com/bosnadev/repository):Laravel Repositories is a package for Laravel 5 which is used to abstract the database layer. This makes applications much easier to maintain. https://bosnadev.com
* [LaravelCollective/html](https://github.com/LaravelCollective/html):HTML and Form Builders for the Laravel Framework
* [code 好事源代码](https://github.com/Ucer/codehaoshi)
* [Ucer/ucer-admin](https://github.com/Ucer/ucer-admin)
* [Algolia](https://www.algolia.com/doc/api-client/laravel/algolia-and-scout/):Algolia is a hosted full-text, numerical, and faceted search engine capable of delivering realtime results from the first keystroke
* [tymondesigns/jwt-auth](https://github.com/tymondesigns/jwt-auth):🔐 JSON Web Token Authentication for Laravel & Lumen http://jwt-auth.com
* [swooletw/laravel-swoole](https://github.com/swooletw/laravel-swoole):High performance HTTP server based on Swoole. Speed up your Laravel or Lumen applications.

## 参考

* [jcc/blog](https://github.com/jcc/blog):PJ Blog is an open source blog built with Laravel and Vue.js.
* [快速入门 —— 使用 Laragon 在 Windows 中搭建 Laravel 开发环境](http://laravelacademy.org/post/7754.html)
* [基于 Laravel 的 API 服务端架构代码](http://laravelacademy.org/post/5449.html)
* [chiraggude/awesome-laravel](https://github.com/chiraggude/awesome-laravel)A curated list of bookmarks, packages, tutorials, videos and other cool resources from the Laravel ecosystem
* [nonfu/awesome-laravel](https://github.com/nonfu/awesome-laravel)来自Laravel生态系统的精选资源大全，包括书签、包、教程、视频以及其它诸多很酷的资源。 http://laravelacademy.org
* [laravel入门教程](https://d.laravel-china.org/docs/5.5)
* [Laravel 5.1 LTS 中文文档](https://docs.golaravel.com/docs/5.4/installation/)
* [Laravel 5.4 中文文档](http://laravelacademy.org/laravel-docs-5_4)
* [原理机制篇](http://www.cnblogs.com/XiongMaoMengNan/p/6644892.html)
* [Laravel5.5 + Vue开发单页应用](http://www.laravel-vue.xyz/2018/03/22/laravel_vue_v2/)
* [kevinyan815/Learning_Laravel_Kernel](https://github.com/kevinyan815/Learning_Laravel_Kernel):Laravel核心代码学习
<https://laravel-china.org/articles/2020/ten-laravel-5-program-optimization-techniques> <https://blog.tanteng.me/2016/06/laravel-optimize/>

## 文档

* [laravel/docs](https://github.com/laravel/docs)
* [laravel/spark-docs](https://github.com/laravel/spark-docs)
* [summerblue/laravel5-cheatsheet](https://github.com/summerblue/laravel5-cheatsheet):A quick reference guide (cheat sheet) for Laravel 5.1 LTS, listing artisan, composer, routes and other useful bits of information. https://cs.laravel-china.org/
* [Laravel Cheat Sheet](http://cheats.jesse-obrien.ca/)
* [laravel-china/laravel-docs](https://github.com/laravel-china/laravel-docs):Laravel 中文文档 https://d.laravel-china.org
* [samedreams/artisan-road](https://github.com/samedreams/artisan-road):Programmers are artisans （This book is a guide for artisans）

## 工具

* [laravel/homestead](https://github.com/laravel/homestead)
* [laravel/valet](https://github.com/laravel/valet):Valet is a Laravel development environment for Mac minimalists.
* [weprovide/valet-plus](https://github.com/weprovide/valet-plus):Blazing fast macOS PHP development environment https://medium.com/@timneutkens/intro…
* [barryvdh/laravel-debugbar](https://github.com/barryvdh/laravel-debugbar):Laravel Debugbar (Integrates PHP Debug Bar)
* [z-song/laravel-admin](https://github.com/z-song/laravel-admin):Build a full-featured administrative interface in ten minutes http://laravel-admin.org
* [laravel-ide-helper](https://github.com/barryvdh/laravel-ide-helper):Laravel IDE Helper
* [the-control-group/voyager](https://github.com/the-control-group/voyager):Voyager - The Missing Laravel Admin https://laravelvoyager.com
* [codex-project/codex](https://github.com/codex-project/codex):Extendable Documentation Platform written in Laravel 5. Generate easy and awesome documentation! http://codex-project.ninja
* [spatie/laravel-permission](https://github.com/spatie/laravel-permission):Associate users with roles and permissions
* [FrozenNode/Laravel-Administrator](https://github.com/FrozenNode/Laravel-Administrator):An administrative interface package for Laravel http://administrator.frozennode.com/
* [stefanzweifel/laravel-stats](https://github.com/stefanzweifel/laravel-stats):📈 Get insights about your Laravel or Lumen Project
* [andersao/laravel-request-logger](https://github.com/andersao/laravel-request-logger):HTTP request logger middleware for Laravel
* [laravelshift](https://laravelshift.com/):laravel upgrade
* [Laravel Analyzer](link)
* [vyuldashev/laravel-queue-rabbitmq](https://github.com/vyuldashev/laravel-queue-rabbitmq):RabbitMQ driver for Laravel Queue

## 教程

* [laravel/quickstart-basic](https://github.com/laravel/quickstart-basic):A sample task list application. http://laravel.com/docs/quickstart

## 工程

项目的搭建，以 [https://github.com/summerblue/larabbs](A forum project base on Laravel 5.5)

```sh
git clone git@github.com:summerblue/larabbs.git
// 修改 homestead.html,添加配置
vagrant provision
composer install
// 配置.env文件

php artisan migrate --seed
php artisan key:generate

yarn install

首页地址：http://larabbs.app/
管理后台：http://larabbs.app/admin

username: summer@yousails.com
password: password

// Non-static method Redis::hGet() cannot be called statically
```

### [barryvdh/laravel-debugbar](https://github.com/barryvdh/laravel-debugbar)

Laravel Debugbar (Integrates PHP Debug Bar)

```php
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
```

### [tymondesigns/jwt-auth](https://github.com/tymondesigns/jwt-auth)

🔐 JSON Web Token Authentication for Laravel & Lumen http://jwt-auth.com

```sh
composer require tymon/jwt-auth # 修改app.php 添加到providers

php artisan vendor:publish --provider="Tymon\JWTAuth\Providers\LaravelServiceProvider" # 生成配置文件
php artisan jwt:secret # 使用
```

## 前后端分离

* npm install
* 配置webpack proxy
* 运行arstian serve
  - 创建migration,并配置字段
  - migrate
  - 生成模型与控制器
  - 配置api路由
* npm run watch
* 配置单页首页
  - 引入app.css 和 app.js
  - 配置前端路由
  - 创建api请求
  - 页面创建

## 问题

Call to undefined function openssl_encrypt() # 开启OpenSSL扩展
