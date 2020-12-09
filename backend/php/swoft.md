# [swoft-cloud/framework](https://github.com/swoft-cloud/framework)

Modern High performance AOP and Coroutine PHP Framework, base on Swoole 2 <https://www.swoft.org>

* 基于 Swoole 扩展
* 内置协程网络服务器(Http/Websocket/RPC)
* 高性能路由
* 强大的 AOP (面向切面编程)
* 灵活的注解功能
* 全局的依赖注入容器
* 基于 PSR-7 的 HTTP 消息实现
* 基于 PSR-11 的容器规范实现
* 基于 PSR-14 的事件管理器
* 基于 PSR-15 的中间件
* 基于 PSR-16 的缓存设计
* 可扩展的高性能 RPC
* RESTful 支持
* 国际化(i18n)支持
* 快速灵活的参数验证器
* 配置中心
* 完善的服务治理，熔断、降级、限流负载、注册与发现
  - 服务注册与发现，需要用到 Swoft 官方提供的 swoft-consul 组件
    + 注册与取消服务:监听 SwooleEvent::START 事件，注册服务
* 通用连接池 Mysql、Redis、RPC
* 数据库 ORM
* 协程、异步任务投递
* 自定义用户进程
* 强大的日志系统

## 安装

```sh
composer create-project swoft/swoft swoft

cp .env.example .env
vim .env # 根据需要调整启动参数

php bin/swoft rpc|ws|http:start|restart|reload|stop
php bin/swoft rpc|ws|http:start -d # 守护进程启动

wget https://github.com/swoft-cloud/swoft-cli/releases/download/v0.2.1/swoftcli.phar
mv swoftcli.phar /usr/local/bin/swoftcli
chmod a+x /usr/local/bin/swoftcli
```

## Swoft CLI

Swoft CLI 是一个独立的命令行应用包，提供了一些内置的工具方便开发者使用。

* 监视用户swoft项目的文件更改并自动重新启动服务器
* 生成Swoft应用类文件，例如：http控制器，websocket模块类等等
* 快速创建新应用项目或新的组件
* 将一个swoft应用打包成 phar 包

## 禁止

* 禁止die()、exit()函数
* 禁止使用`$_GET`、`$_POST`、`$GLOBALS`、`$_SERVER`、`$_FILES`、`$_COOKIE`、`$_SESSION`、$_REQUEST、$_ENV等超全局变量
* 谨慎使用global、static关键字

## 注解

* 有功能含义,简洁、灵活
  - 通过 PHP 反射获取类里面是所有注解(<https://www.php.net/manual/zh/book.reflection.php>)
  - 通过 PHP 组件(<https://github.com/doctrine/annotations>) 使其实现特殊功能
* 类注解，所有类注释后面
* 属性注解，属性描述之后，其它注释之前
* 方法注解，方法描述之后，其它注释之前

## 配置

* env:配置一些和环境相关的一些参数，比如运行模式、资源地址 `.env`
* config:配置应用级别的配置以及业务级别的配置 `app/bean.php`
  - 可配置项
    + path 自定配置文件路径
    + base 主文件名称，默认 base (其他文件的数据都会按文件名为key合并到主文件数据中)
    + type 配置文件类型，默认 php 同时也支持 yaml 格式
    + parser 配置解析器，默认已经配置 php/yaml 解析器。
    + env 配置当前环境比如 dev/test/pre/pro,切换不同环境配置
  - 配置目录所有配置文件会解析成一个数组，但是不会递归合并数据，只会合并当前目录文件数据，以它的文件名称为数组 key 进行合并数组

```sh
composer require swoft/config
```

## 容器

* Swoft 基于 PSR-11 规范设计了自己容器，并基于 注解 增强了它的功能。
* 容器是 Swoft 最重要的一个设计，可以说是 Swoft 的核心精髓，也是 Swoft 各种模块的实现基础
* IOC容器可以看成是一个Beans关系的集合,用于存放和管理 Bean 生命周期
* Bean 是由 IOC 容器管理的实例,就是一个类的对象实例，只不过它是由 IOC 容器 实例化、组装和管理的对象
* Bean的定义要有BeanDefinition描述：当配置文件/注解被解析后就会在内部转化成一个BeanDefinition对象
* 创建
  - 直接定义注解 [@Bean](#@Bean()) 的方式
  - 通过在bean.php中配置,优先级最高因为它是最后执行的，如果配置的已经是一个 Bean ，config的 配置的将会覆盖它
  - 在AutoLoader.php 中定义
* scope
  - Bean::SINGLETON 单例Bean(默认):全局只有一个共享的实例
    + 在框架启动时被初始化，并且只会初始化一次。 对singleton的 bean 进行写入操作是不安全的。如果同时读写singleton的 bean，会造成上下文切换导致bean数据不一致，这种往往是业务交叉造成的
    + 用于只读，不要当做共享内存的方式
    + 只会在 主进程关闭 才会被销毁
  - Bean::PROTOTYPE 原型Bean
    + 原型模式, 会被框架启动时会被自动初始化
    + 获取 scope为prototype类型的bean每次都是克隆初始化好的bean(clone 比 new 快，拷贝操作)
    + 使用: 定义一个 new 方法，替代new关键字
  - Bean::REQUEST 请求Bean
    + 框架初始化的时候并不会初始化，而是在 onRequest 事件触发后 采用懒加载方式
    + 在当前请求中保持单例，请求结束后会被自动销毁。作用域始终在于一个请求当中
    + 只能通过获取 BeanFactory::getRequestBean 获取
    + 在所有协程执行完毕后，在SwoftEvent::COROUTINE_COMPLETE事件中，会自动销毁与顶级协程ID绑定的request bean
* 初始化:会自动检查init()这个方法是否存在
* 获取
  - scope为 Bean::SINGLETON 级别的 bean 可以通过 @Inject 属性注入(必须有 类注解)，底层会通过反射自动注入属性中
  - BeanFactory 获取scope为Bean::SINGLETON，Bean::PROTOTYPE
* 接口注入：根据接口类名，注入接口实际实现的对象
  - @Primary
如果一个接口有多个实现，此标记就是制定接口注入时使用的对象，且同一个接口的多个实现类中只能有一个此注解标记，不然启动会提示错误

## 事件

* swoole server的回调事件
* swoft server的事件，基于swoole的回调处理，扩展了一些可用事件以增强自定义性
* 应用级别内的自定义事件管理和使用
* 事件分组 推荐将相关的事件，在名称设计上进行分组
  - 支持使用事件通配符 * 对一组相关的事件进行监听,
    + 全局的事件通配符。直接对 *添加监听器(@Listener("*")), 此时所有触发的事件都会被此监听器接收到。
    + {prefix}.* 指定分组事件的监听

## 面向切面的程序设计（Aspect-oriented programming，AOP

* 将横切关注点与业务主体进行进一步分离，以提高程序代码的模块化程度
* OOP 的补充和延伸，可以更方便的对业务代码进行解耦，提高代码质量，增加代码的可重用性
* 作用就是在不侵入原有功能代码的情况下，给原有的功能添加新的功能
* 术语
  - 通知（Advice）:就是想要的功能，用方法实现的功能，也就是上说的安全、事务、日志等。你先把功能用方法给先定义好，然后再想用的地方用一下。
  - 连接点（JoinPoint） 就是允许你把通知（Advice）放在的地方，基本每个方法的前、后（两者都有也行），或抛出异常是时都可以是连接点，Swoft 只支持方法级的连接点。只要记住，和方法有关的前前后后都是连接点。
  - 切入点（Pointcut）这个就是定义要切入的具体的方法，为什么呢，假设一下，一个类中有10个方法，每个方法都有好多个连接点(JoinPoint),但是你并不想在所有方法都使用通知（织入），你只想织入其中的某几个方法，那么就是用这个切入点来定义具体的方法。
  - 切面（Aspect） 是通知（Advice）和切入点 （Pointcut）的结合。通知说明了干什么，切入点说明了在哪里干，一般情况下连接点是在指定切入点的时候就指定好了的，上面单独吧连接点写出来只是为了让其更好理解。
  - 引入（introduction） 就是将我们新的类和方法，用到目标类中。
  - 目标（target）引入中所提到的目标类，也就是要被通知的对象，也就是真正的业务逻辑，他可以在毫不知情的情况下，被织入切面。
  - 代理（proxy） 整套AOP机制的，都是通过代理，Swoft 使用了 PHP-Parse 类库来更方便的实现AOP
  - 织入（weaving） 把切面应用到目标对象来创建新的代理对象的过程
* @Aspect 定义一个类为切面类
  - order 优先级，多个切面，越小预先执行
* 声明切入点:实体名称(类名)必须指定 namespace 完整路径 例如 'App\Controller\HomeController' 或者先用 use 将目标类 use 进来
  - @PointBean 定义bean切入点, 这个bean类里的所有public方法执行都会经过此切面类的代理
    + include 定义需要切入的实体名称集合
    + exclude 定义需要排除的实体名称集合
  - @PointAnnotation 定义注解类切入点, 所有包含使用了对应注解的方法都会经过此切面类的代理
    + include 定义需要切入的注解类名集合
    + exclude 定义需要排除的注解类名集合
  - @PointExecution 定义匹配切入点, 指明要代理目标类的哪些方法
    + include 定义需要切入的匹配集合，匹配的类方法，支持正则表达式
    + exclude 定义需要排序的匹配集合，匹配的类方法，支持正则表达式
* 只拦截 public 和 protected 方法，不拦截private方法
* 如果切入了多个方法，此时在某一个方法内调用了另一个被切入的方法，此时AOP 也会织入通知
* 顺序
  - 多个切面执行是按照 order 值越小越先执行，一个切面多个通知点，也是按照一定的顺序执行的
  - 单切面正常顺序
    + @Around 通知的 before around 业务
    + @Before 通知
    + method 方法
    + @Around 通知的 after around 业务
    + @After 通知
    + 执行 @AfterReturn 通知
  - 异常顺序
    + @Around 通知的 before around 业务
    + @Before 通知
    + method 方法
    + @Around 通知的 after around 业务
    + @After 通知
    + 执行 @AfterThrowning 通知
  - 多切面已正常情况：
    + Aspect1 @Around 通知的 before around 业务
    + Aspect1 @Before 通知
    + Aspect2 @Around 通知的 before around 业务
    + Aspect2 @Before 通知
    + method 方法
    + Aspect2 @Around 通知的 after around 业务
    + Aspect2 @After 通知
    + Aspect2 执行 @AfterReturn 通知
    + Aspect1 @Around 通知的 after around 业务
    + Aspect1 @After 通知
    + Aspect1 执行 @AfterReturn 通知

## 命令行

* 没有 - 开头的都认为是参数
* 以 - 开头的则是选项数据
  - -- 开头的是长选项(long-option)
    - - 开头的是短选项(short-option)
* @Command 定义命令组名称
  - name string 定义命令组名称，如果缺省，根据类名称自动解析
  - alias string 命令组别名，通过别名仍然可以访问它。允许多个，以逗号隔开即可
  - desc string 命令组描述信息说明，支持颜色标签
  - coroutine bool 定义是否为协程下运行，默认 true, 框架会启动一个协程运行此组里面的命令
* @CommandMapping 定义操作命令的映射关系
  - name string 定义命令组名称，如果缺省，会执行使用方法名称
  - alias string 命令别名，通过别名仍然可以访问它。允许多个，以逗号隔开即可
  - desc string 命令的描述信息说明，支持颜色标签
* CommandArgument  定义一个命令的参数。作用域：method
  - name string 必填项 定义命令参数名称。eg: opt
  - default mixed 命令参数的默认值
  - desc string 命令参数的描述信息说明，支持颜色标签
  - type string 命令参数的值类型
  - mode int 命令参数的值输入限定：必须，可选 等

```
php bin/swoft demo:test status=2 name=john arg0 -s=test --page 23 --id=154 -e dev -v vvv -d -rf --debug --test=false
```

## Http Server

* 显式指定路由前缀: @Controller(prefix="/index") 或 @Controller("/index")
* 隐式指定路由前缀: @Controller() 默认自动解析 controller class 的名称，并且使用小驼峰格式
* 一个完整的路由规则是通过 @Controller + @RequestMapping 注解实现，通常前者定义前缀，后者定义后缀

```sh
composer require swoft/http-server

php swoftcli.phar gen:http-ctrl user --prefix /users
```

## 参考

* [docs](http://doc.swoft.org/)
* [wujunze/awesome-swoft](https://github.com/wujunze/awesome-swoft):A curated list of bookmarks, packages, tutorials, videos and other cool resources from the Swoft ecosystem
