# [PSR](http://www.php-fig.org/)

组织制定的PHP语言开发规范，约定了很多方面的规则，如命名空间、类名 规范、编码风格标准、Autoload、公共接口等

## PSR0 2014 年 10 月 21 日被标记为弃用

类自动加载

* 一个完全标准的命名空间(namespace)和类(class)的结构必须符合以下结构：\<Vendor Name>\(<Namespace>\)*<Class Name>
* 每个命名空间(namespace)都必须有一个顶级的空间名(namespace)("组织名(Vendor Name)")。
* 每个命名空间(namespace)中可以根据需要使用任意数量的子命名空间(sub-namespace)。
* 根据完整的命名空间名从文件系统中载入类文件时，空间名(namespace)中的分隔符将被转换为 DIRECTORY_SEPARATOR。
* 类名(class name)中的每个下划线_都将被转换为一个DIRECTORY_SEPARATOR。下划线_在空间名(namespace)中没有什么特殊的意义
* 完全标准的命名空间(namespace)和类(class)从文件系统加载源文件时将会加上.php后缀。
* 组织名(vendor name)，空间名(namespace)，类名(class name)都由大小写字母组合而成。
* 查找
  - /path/to/project/ 为 basedir `"\Doctrine\Common\\": "lib/vendor/"`
  - \Doctrine\Common\IsolatedClassLoader => /path/to/project/lib/vendor/Doctrine/Common/IsolatedClassLoader.php
  - \namespace\package_name\Class_Name => /path/to/project/lib/vendor/namespace/package_name/Class/Name.php
  - ClassName.php 中是这样的 class Acme_Util_ClassName{}

```php
function autoload($className)
{
    $className = ltrim($className, '\\');
    $fileName  = '';
    $namespace = '';
    if ($lastNsPos = strrpos($className, '\\')) {
        $namespace = substr($className, 0, $lastNsPos);
        $className = substr($className, $lastNsPos + 1);
        $fileName  = str_replace('\\', DIRECTORY_SEPARATOR, $namespace) . DIRECTORY_SEPARATOR;
    }
    $fileName .= str_replace('_', DIRECTORY_SEPARATOR, $className) . '.php';

    require $fileName;
}
spl_autoload_register('autoload');
```

## Basic Coding Standard   Paul M. Jones   N/A N/A

* 概览
  - PHP 代码文件 必须 以 <?php 或 <?= 标签开始；
  - PHP 代码文件 必须 以 不带 BOM 的 UTF-8 编码；
  - PHP 代码中 应该 声明任一标志（类、函数、常量等），或引起副作用（如果一个函数修改了自己范围之外的资源，那就叫做有副作用，如：生成输出以及修改 .ini 配置文件等），但是不应该二者都有；
  - 命名空间以及类 必须 符合 PSR 的自动加载规范： [PSR-0（已废弃）或 PSR-4] 中的一个。
  - 类的命名 必须 遵循 StudlyCaps 大写开头的驼峰命名规范；
  - 类中的常量所有字母都 必须 大写，单词间用下划线分隔；
  - 方法名称 必须 符合 camelCase 式的小写开头驼峰命名规范
* 文件
  - PHP 标签 PHP 代码 必须 使用 <?php ?> 长标签 或 <?= ?> 短输出标签；一定不可 使用其它自定义标签。
  * 字符集编码 PHP 代码 必须 且只可使用 不带 BOM 的 UTF-8 编码。
  - 副作用:一份 PHP 文件中应该要不就只定义新的声明，如类、函数或常量等不产生副作用的操作，要不就只书写会产生副作用 的逻辑操作，但不该同时具有两者。
    - 副作用」(side effects)一词的意思是，仅仅通过包含文件，不直接声明类、函数和常量等，而执行的逻辑操作
    - 副作用」包含却不仅限于：生成输出，明确使用 require 或 include，连接到外部服务，修改 ini 设置，发出错误或异常，修改全局或静态变量，读取或写入一个文件，等等
+ 命名空间和类名
  * 命名空间和类名 必须 遵循『自动加载』规范： [PSR-0， PSR-4]
  * 意味着每个类都独立为一个文件，并且至少在一个层次的命名空间内，那就是：顶级组织名（vendor name）。
  * 类名 必须 以类似 StudlyCaps 形式的大写开头的驼峰命名方式声明。
* 类的常量、属性和方法
  - 类的常量中所有字母都 必须 大写，词间以下划线分隔
  - 属性
    + 大写开头的驼峰式 ($StudlyCaps)
    + 小写开头的驼峰式 ($camelCase)
    + 下划线分隔式 ($under_score)
  - 方法名称 必须 符合 camelCase() 式的小写开头驼峰命名规范

## PSR3 Logger Interface    Jordi Boggiano  N/A N/A

* 基本规范
  - LoggerInterface 接口对外定义了八个方法，分别用来记录 RFC 5424 中定义的八个等级的日志：debug、 info、 notice、 warning、 error、 critical、 alert 以及 emergency 。
  - 第九个方法log，其第一个参数为记录的等级。可使用一个预先定义的等级常量作为参数来调用此方法，必须与直接调用以上八个方法具有相同的效果。如果传入的等级常量参数没有预先定义，则必须抛出Psr\Log\InvalidArgumentException 类型的异常。在不确定的情况下，使用者 不该 使用未支持的等级常量来调用此方法。
* 消息
  - 以上每个方法都接受一个字符串类型或者是有 __toString() 方法的对象作为记录信息参数，这样，实现者就能把它当成字符串来处理，否则实现者 必须 自己把它转换成字符串。
  - 记录信息参数 可以 携带占位符，实现者 可以 根据上下文将其它替换成相应的值。
  - 其中占位符 必须 与上下文数组中的键名保持一致。
  - 占位符的名称 必须 由一个左花括号 { 以及一个右括号 } 包含。但花括号与名称之间 一定不可有空格符。
  - 占位符的名称 应该 只由 A-Z、a-z、0-9、下划线 _、以及英文的句号 . 组成，其它字符作为将来占位符规范的保留。
  - 实现者 可以 通过对占位符采用不同的转义和转换策略，来生成最终的日志。而使用者在不知道上下文的前提下，不该 提前转义占位符
* 上下文
  - 每个记录函数都接受一个上下文数组参数，用来装载字符串类型无法表示的信息。它 可以 装载任何信息，所以实现者 必须 确保能正确处理其装载的信息，对于其装载的数据， 一定不可 抛出异常，或产生 PHP 出错、警告或提醒信息（error、warning、notice）。
  - 如需通过上下文参数传入了一个 Exception 对象，必须 以 exception 作为键名。记录异常信息是很普遍的，所以如果它能够在记录类库的底层实现，就能够让实现者从异常信息中抽丝剥茧。 当然，实现者在使用它时，必须 确保键名为 exception 的键值是否真的是一个 Exception，毕竟它 可以 装载任何信息。
* 助手类和接口
  - Psr\Log\AbstractLogger 类使得只需继承它和实现其中的 log 方法，就能够很轻易地实现 LoggerInterface 接口，而另外八个方法就能够把记录信息和上下文信息传给它。
  - 同样地，使用 Psr\Log\LoggerTrait 也只需实现其中的 log 方法。不过，需要特别注意的是，在 traits 可复用代码块还不能实现接口前，还需要 implement LoggerInterface。
  - 在没有可用的日志记录器时，Psr\Log\NullLogger 接口 可以 为使用者提供一个备用的日志「黑洞」。不过，当上下文的构建非常消耗资源时，带条件检查的日志记录或许是更好的办法。
  - Psr\Log\LoggerAwareInterface 接口仅包括一个 setLogger(LoggerInterface $logger) 方法，框架可以使用它实现自动连接任意的日志记录实例。
  - Psr\Log\LoggerAwareTrait trait 可复用代码块可以在任何的类里面使用，只需通过它提供的 $this->logger，就可以轻松地实现等同的接口。
  - Psr\Log\LogLevel 类装载了八个记录等级常量
* 包:接口和类的描述、相关的异常类以及用于验证你所写代码的测试套件都将作为 psr/log 包的一部分提供。
  - Psr\Log\LoggerInterface
  - Psr\Log\LoggerAwareInterface
  - Psr\Log\LogLevel

## PSR4 Autoloading Standard    Paul M. Jones   Phil Sturgeon   Larry Garfield

描述的是通过文件路径自动载入类的指南；它作为对 PSR-0 的补充；根据这个 指导如何规范存放文件来自动载入；

* 术语「类」是一个泛称；它包含类，接口，traits 以及其他类似的结构；
* **完全限定类名**应该类似如下范例：\<NamespaceName>(<SubNamespaceNames>)*<ClassName>
  - 完全限定类名必须有一个顶级命名空间（Vendor Name）
  - 完全限定类名可以有多个子命名空间
  - 完全限定类名应该有一个最终的类名
  - 下划线在完全限定类名中是没有特殊含义的
  - 字母在完全限定类名中可以是任何大小写的组合
  - 所有类名必须以大小写敏感方式引用
* 从完全限定类名载入文件时：
  - 在完全限定类名中，连续的一个或几个子命名空间构成的命名空间前缀（不包括顶级命名空间的分隔符），至少对应着至少一个基础目录。
  - 在「命名空间前缀」后的连续子命名空间名称对应一个「基础目录」下的子目录，其中的命名 空间分隔符表示目录分隔符。子目录名称必须和子命名空间名大小写匹配；
  - 终止类名对应一个以 .php 结尾的文件。文件名必须和终止类名大小写匹配；
* 自动载入器的实现不可抛出任何异常，不可引发任何等级的错误；也不应返回值；
* 自动生成的PSR4配置文件名称为autoload_psr4.php（PSR0的是autoload_namespace.php），配置文件返回一个关联数组，键是名称空间的前缀，值是名称空间前缀对应的路径。
* 只需要给类库正确定义所在的命名空间，并且命名空间的路径与类库文件的目录一致，那么就可以实现类的自动加载，从而实现真正的惰性加载
* "Acme\\Util\\": "src/":psr-4 就会默认所有的 src 下面的 class 都已经有了 Acme\Util 的 基本 namespace，而 psr-4 中不会将 _ 转义成 \

```php
<?php
/**
 * 一个具体项目实现的示例。
 *
 * 在注册自动加载函数后，下面这行代码将引发程序
 * 尝试从 /path/to/project/src/Baz/Qux.php
 * 加载 \Foo\Bar\Baz\Qux 类：
 *
 *      new \Foo\Bar\Baz\Qux;
 *
 * @param string $class 完全标准的类名。
 * @return void
 */
spl_autoload_register(function ($class) {

    // 具体项目的命名空间前缀
    $prefix = 'Foo\\Bar\\';

    // 命名空间前缀对应的基础目录
    $base_dir = __DIR__ . '/src/';

    // 该类使用了此命名空间前缀？
    $len = strlen($prefix);
    if (strncmp($prefix, $class, $len) !== 0) {
        // 否，交给下一个已注册的自动加载函数
        return;
    }

    // 获取相对类名
    $relative_class = substr($class, $len);

    // 命名空间前缀替换为基础目录，
    // 将相对类名中命名空间分隔符替换为目录分隔符，
    // 附加 .php
    $file = $base_dir . str_replace('\\', '/', $relative_class) . '.php';

    // 如果文件存在，加载它
    if (file_exists($file)) {
        require $file;
    }
});
```

## PSR6 Caching Interface   Larry Garfield  Paul Dragoonis  Robert Hafner

* 调用类库 (Calling Library) - 调用者，使用缓存服务的类库，这个类库调用缓存服务，调用的是此缓存接口规范的具体「实现类库」，调用者不需要知道任何「缓存服务」的具体实现。

* 实现类库 (Implementing Library) - 此类库是对「缓存接口规范」的具体实现，封装起来的缓存服务，供「调用类库」使用。实现类库 必须 提供 PHP 类来实现 Cache\CacheItemPoolInterface 和 Cache\CacheItemInterface 接口。实现类库 必须 支持最小的如下描述的 TTL 功能，秒级别的精准度。

* 生存时间值 (TTL - Time To Live) - 定义了缓存可以存活的时间，以秒为单位的整数值。

* 过期时间 (Expiration) - 定义准确的过期时间点，一般为缓存存储发生的时间点加上 TTL 时间值，也可以指定一个 DateTime 对象。假如一个缓存项的 TTL 设置为 300 秒，保存于 1:30:00 ，那么缓存项的过期时间为 1:35:00。实现类库 可以 让缓存项提前过期，但是 必须 在到达过期时间时立即把缓存项标示为过期。如果调用类库在保存一个缓存项的时候未设置「过期时间」、或者设置了 null 作为过期时间（或者 TTL 设置为 null），实现类库 可以 使用默认自行配置的一个时间。如果没有默认时间，实现类库 必须把存储时间当做 永久性 存储，或者按照底层驱动能支持的最长时间作为保持时间。

* 键 (KEY) - 长度大于 1 的字串，用作缓存项在缓存系统里的唯一标识符。实现类库 必须 支持「键」规则 A-Z, a-z, 0-9, _, 和 . 任何顺序的 UTF-8 编码，长度小于 64 位。实现类库 可以 支持更多的编码或者更长的长度，不过 必须 支持至少以上指定
  的编码和长度。实现类库可自行实现对「键」的转义，但是 必须 保证能够无损的返回「键」字串。以下的字串作为系统保留: {}()/\@:，一定不可 作为「键」的命名支持。

* 命中 (Hit):一个缓存的命中，指的是当调用类库使用「键」在请求一个缓存项的时候，在缓存池里能找到对应的缓存项，并且此缓存项还未过期，并且此数据不会因为任何原因出现错误。调用类库 应该 确保先验证下 isHit() 有命中后才调用 get() 获取数据。

* 未命中 (Miss):一个缓存未命中，是完全的上面描述的「命中」的相反。指的是当调用类库使用「键」在请求一个缓存项的时候，在缓存池里未能找到对应的缓存项，或者此缓存项已经过期，或者此数据因为任何原因出现错误。一个过期的缓存项，必须 被当做 未命中 来对待。

* 延迟 (Deferred) - 一个延迟的缓存，指的是这个缓存项可能不会立刻被存储到物理缓存池里。一个缓存池对象 可以 对一个指定延迟的缓存项进行延迟存储，这样做的好处是可以利用一些缓存服务器提供
  的批量插入功能。缓存池 必须 能对所有延迟缓存最终能持久化，并且不会丢失。可以 在调用类库还未发起保存请求之前就做持久化。当调用类库调用 commit() 方法时，所有的延迟缓存都 必须 做持久化。实现类库 可以 自行决定使用什么逻辑来触发数据持久化，如对象的 析构方法 (destructor) 内、调用 save() 时持久化、倒计时保存或者触及最大数量时保存等。当请求一个延迟缓存项时，必须 返回一个延迟，未持久化的缓存项对象。

* 数据：实现类库必须支持序列化 PHP 的所有数据类型，包含以下类型：

  - Strings - PHP 兼容编码中任意长度的字符串。
  - Integers - PHP 支持的所有大小的整数，最大为 64 位有符号整数。
  - Floats - 有符号的浮点值。
  - Boolean - True 和 False 。
  - Null - 实际的空值。
  - Arrays - 可索引，关联，任意深度的数组。
  - Object - 所有对象支持无损的序列化和反序列化，比如 $o == unserialize(serialize($o))。对象可以使用 PHP 的原生序列化接口， __sleep() 、 __wakeup() 等魔术方法，或者其他可用的类似语法。

* 概念

  - 缓存池 Pool 缓存池包含缓存系统里所有缓存数据的集合。缓存池逻辑上是所有缓存项存储的仓库，所有存储进去的数据，都能从缓存池里取出来，所有的对缓存的操作，都发生在缓存池子里。
  - 缓存项 Items 一条缓存项在缓存池里代表了一对「键 / 值」对应的数据，「键」被视为每一个缓存项主键，是缓存项的唯一标识符，必须 是不可变更的，当然，「值」可以 任意变更。
  - 错误处理 缓存对应用性能起着至关重要的作用，但是，无论在任何情况下，缓存 一定不可 作为应用程序不可或缺的核心功能。缓存系统里的错误 一定不可 导致应用程序故障，所以，实现类库 一定不可 抛出任何除了此接口规范定义的以外的异常，并且 必须 捕捉包括底层存储驱动抛出的异常，不让其冒泡至超出缓存系统内。
    - 实现类库 应该 对此类错误进行记录，或者以任何形式通知管理员。
    - 调用类库发起删除缓存项的请求，或者清空整个缓冲池子的请求，「键」不存在的话 必须 不能当成是有错误发生。后置条件是一样的，如果取数据时，「键」不存在的话 必须 不能当成是有错误发生。

* 接口

  - CacheItemInterface
    + CacheItemInterface 定义了缓存系统里的一个缓存项。每一个缓存项 必须 有一个「键」与之相关联，此「键」通常是通过 Cache\CacheItemPoolInterface 来设置。
    + Cache\CacheItemInterface 对象把缓存项的存储进行了封装，每一个 Cache\CacheItemInterface 由一个 Cache\CacheItemPoolInterface 对象生成，CacheItemPoolInterface 负责一些必须的设置，并且给对象设置具有 唯一性 的「键」。
    + Cache\CacheItemInterface 对象 必须 能够存储和取出任何类型的，在「数据」章节定义的 PHP 数值。
    + 调用类库 一定不可 擅自初始化「CacheItemInterface」对象，「缓存项」只能使用「CacheItemPoolInterface」对象的 getItem() 方法来获取。调用类库 一定不可 假设由一个实现类库创建的「缓存项」能被另一个实现类库完全兼容。
  - Cache\CacheItemPoolInterface 的主要目的是从调用类库接收「键」，然后返回对应的 Cache\CacheItemInterface 对象。此接口也是作为主要的，与整个缓存集合交互的方式。所有的配置和初始化由实现类库自行实现。
  - CacheException 异常接口用于严重错误发生的时候，包括但不限于缓存设置错误，例如：无法连接到缓存服务器、提供了无效的凭证。库抛出的任何异常都必须实现此接口。
  - InvalidArgumentException

## PSR7 HTTP Message Interface  Matthew Weier O’Phinney Beau Simensen   Paul M. Jones

描述了 RFC 7230 和 RFC 7231 HTTP 消息传递的接口，还有 RFC 3986 里对 HTTP 消息的 URIs 使用

* 消息:一个 HTTP 消息是指来自于客户端到服务端的请求或者服务端到客户端的响应
  - Psr\Http\Message\RequestInterface 和 Psr\Http\Message\ResponseInterface 继承于 Psr\Http\Message\MessageInterface 。
  - 当接口 Psr\Http\Message\MessageInterface 可能被直接实现的时候，实现者应该实现 Psr\Http\Message\RequestInterface 接口和 Psr\Http\Message\ResponseInterface 接口
* HTTP 请求头信息
  - 大小写不敏感的字段名字:HTTP 消息包含大小写不敏感头信息。使用 MessageInterface 接口来设置和获取头信息，大小写不敏感的定义在于，如果你设置了一个 Foo 的头信息，foo 的值会被重写，你也可以通过 foo 来拿到 FoO 头对应的值
  - 对应多条数组的头信息:使用字符串配合数组来实现，你可以从一个 MessageInterface 取出数组或字符串，使用 getHeaderLine($name) 方法可以获取通过逗号分割的不区分大小写的字符串形式的所有值。也可以通过 getHeader($name) 获取数组形式头信息的所有值
  - 主机信息:Host 头信息通常和 URI 的 host 信息，还有建立起 TCP 连接使用的 Host 信息一致。然而，HTTP 标准规范允许主机 host 信息与其他两个不一样
    + 在构建请求的时候，如果 host 头信息未提供的话，实现类库 必须 尝试着从 URI 中提取 host 信息。RequestInterface::withUri() 会默认的，从传参的 UriInterface 实例中提取 host ，并替代请求中原有的 host 信息
    + 可以提供传参第二个参数为 true 来保证返回的消息实例中，原有的 host 头信息不会被替代掉
  - 数据流:HTTP 的消息内容有时候可以很小，有时候确是非常巨大。尝试使用字符串的形式来展示消息内容，会消耗大量的内存，使用数据流的形式来读取消息 可以解决此问题。StreamInterface 接口用来隐藏具体的数据流读写实现。在一些情况下，消息类型的读取方式为字符串是能容许的，可以使用 php://memory 或者 php://temp
    + StreamInterface 暴露出来几个接口，这些接口允许你读取、写入，还有高效的遍历内容。
    + 数据流使用这个三个接口来阐明对他们的操作能力：isReadable()、isWritable() 和 isSeekable()。这些方法可以让数据流的操作者得知数据流能否能提供他们想要的功能。
    + 每一个数据流的实例，都会有多种功能：可以只读、可以只写、可以读和写，可以随机读取，可以按顺序读取等。最终，StreamInterface 定义了一个 __toString() 的方法，用来一次性以字符串的形式输出所有消息内容。
    + 与请求和响应的接口不同的是，StreamInterface 并不强调不可修改性。因为在 PHP 的实现内，基本上没有办法保证不可修改性，因为指针的指向，内容的变更等状态，都是不可控的。作为读取者，可以调用只读的方法来返回数据流，以最大程度上保证数据流的不可修改性。使用者要时刻明确的知道数据流的可修改性，建议把数据流附加到消息实例中，来强迫不可修改的特性。
  - 请求目标和 URI
    + 请求目标可以是以下形式之一：
      * 原始形式 ，由路径和查询字符串（如果存在）组成；这通常被称为相对 URL。通过 TCP 传输的消息通常是原始形式；scheme 和认证数据通常仅通过 CGI 变量存在。
      * 绝对形式 ，包括 scheme 、认证数据（「[user-info@] host [:port]」，其中括号中的项是可选的），路径（如果存在），查询字符串（如果存在）。这通常被称为绝对 URI，并且是 RFC 3986 中详细说明的唯一指定 URI 的形式。这个形式通常在向 HTTP 代理发出请求时使用。
      * 认证形式 ，只包含认证信息。通常仅用于从 HTTP 客户端和代理服务器之间建立连接请求时使用。
      * 星号形式 ，仅由字符串 * 组成，并与 OPTIONS 方法一起使用，以确定 Web 服务器的性能
    + 通常还有一个不同于请求目标的「有效 URL」。有效 URL 不在 HTTP 消息中传输，但它用于确定发出请求的协议（Http 或 Https）、端口和主机名
    + 有效 URL 由 UriInterface 接口表示。UriInterface 是 RFC 3986 （主要用例）中指定的 HTTP 和 HTTPS URI 的模型。该接口提供了与各种 URI 部分交互的方法，这将消除重复解析 URI 的需要。还定义了一个 __toString() 方法，用于将建模的 URI 转换为其字符串表示形式。
    + 当使用 getRequestTarget() 方法检索请求目标时，默认情况下此方法将使用 URI 对象并提取所有必要的组件来构建 原始形式。原始形式 是迄今为止最常见的请求目标。
    + 如果用户希望使用其他三种形式中，或者如果想要显式覆盖请求目标，则可以使用 withRequestTarget() 来实现。调用此方法不会影响 URI，因为 URI 是从 getUri() 返回的
    + RequestInterface 提供了检索请求目标或用提供的请求目标创建一个新实例的方法。默认情况下，如果实例中没有专门组合请求目标， getRequestTarget() 将会返回组合 URI 的原始形式（如果没有组成 URI 则返回「/」）。withRequestTarget($requestTarget) 使用指定的请求目标创建一个新实例，从而允许开发人员创建表示其他三个请求目标形式（绝对形式、认证形式和星号形式）。使用时，组合的 URI 实例仍然可以使用，特别是在客户端中，它可以用于创建与服务器的连接。
  - 服务端请求
    + RequestInterface 提供了 HTTP 请求消息的通常表示形式。但是，由于服务器端环境的性质，服务器端请求需要额外的处理。服务器端处理需要考虑通用网关接口（ CGI ），更具体地说，需要考虑 PHP 通过其服务器 API （ SAPI ）对 CGI 的抽象和扩展。PHP 通过超级全局变量提供了关于输入编组的简化
    + ServerRequestInterface 继承于 RequestInterface，提供围绕这些超全局变量的抽象访问。这种做法有助于减少开发人员对超全局的耦合，鼓励对代码的测试，并提升了测试人员对相应代码的测试能力。
    + 服务器请求提供了一个附加的属性，「attributes」，以便于开发人员可以根据应用程序的特定规则（例如路径匹配、scheme 匹配、主机匹配等）自检、分解和匹配请求。这样，服务器请求还可以在多段请求逻辑中进行消息传递
  - 文件上传:ServerRequestInterface 指定了一种在规范化结构中检索上传文件树的方法，每个叶子都是一个 UploadedFileInterface 的实例
* 接口
  - Psr\Http\Message\MessageInterface
  - Psr\Http\Message\RequestInterface
  - Psr\Http\Message\ServerRequestInterface
  - Psr\Http\Message\ResponseInterface
  - Psr\Http\Message\StreamInterface
  - Psr\Http\Message\UriInterface
  - Psr\Http\Message\UploadedFileInterface

## PSR11 Container Interface Matthieu Napoli, David Négrier  Matthew Weier O’Phinney Korvin Szanto

* Psr\Container\ContainerInterface 接口提供了两个方法
  - get 方法有一个必传的参数：一个字符串格式的实体标识符。 get 方法可以返回任何类型的值，或者在容器没有标识符对应值的时候抛出一个 NotFoundExceptionInterface 接口实现类的异常。连续两次使用相同参数调用 get 方法得到的值应该是相同的，然而，这取决于 implementor 实现类的设计和 user 用户配置，可能也会返回不同的值。所以 user 用户不应该依赖在两次连续调用时可以获得相同的值。
  - has 方法需要一个唯一参数：一个字符串格式的实体标识符。如果容器内有标识符对应的内容时 has 方法返回 true 值；否则 has 方法返回 false 。如果调用 has($id) 返回了 false ，那么相同 $id 调用 get($id) 方法一定是抛出 NotFoundExceptionInterface 接口的异常。
* 异常 容器抛出的异常都需要实现 Psr\Container\ContainerExceptionInterface 接口。通过 get 方法获取一个容器中不存在实体标识符时必须抛出 Psr\Container\NotFoundExceptionInterface 接口的异常实现类
* psr/container 包中提供了上面提到的接口和相关异常类
  - Psr\Container\ContainerInterface
  - Psr\Container\ContainerExceptionInterface
  - Psr\Container\NotFoundExceptionInterface

## PSR12 Extended Coding Style Guide Korvin Szanto   Alexander Makarov   Chris Tankersley

* 文件
  - 所有 PHP 文件只能使用 Unix LF (换行符) 结尾。
  - 所有的 PHP 文件都必须以非空行结尾，以一个 LF 结尾。
  - 在仅包含 PHP 代码的文件中，必须省略结尾的 ?> 标记。
* 代码行
  - 行长度不得有硬限制。
  - 行长度的软限制必须为 120 个字符。
  - 行的长度不应超过 80 个字符；超过该长度的行应拆分为多个后续行，每个行的长度不应超过 80 个字符。
  - 行尾不能有尾随空格。
  - 可以添加空行以提高可读性并指示相关的代码块，除非明确禁止。
  - 每行不能有多个语句。
* 缩进 代码必须为每个缩进级别使用 4 个空格的缩进，并且不能使用缩进标签
* 关键词和类型
  - PHP 的所有关键字和类型 都必须使用小写。
  - PHP 未来版本中新加的所有关键字和类型也都必须使用小写。
  - 类型关键字必须使用缩写。使用 bool 而不是 boolean，使用 int 而不是 integer 等等
* 可能会包含多个块。如果包含多个块，则每个块都必须用空白行和其他块分隔，并且块内不能包含空白行.所有的块都必须按照下面的顺序排列，如果不存在该块则忽略
  - PHP 文件开始标签： <?php。
  - 文件级文档块。
  - 一个或多个声明语句。
  - 命名空间声明语句。
  - 一个或多个基于类的 use 声明语句。
  - 一个或多个基于方法的 use 声明语句。
  - 一个或多个基于常量的 use 声明语句。

## PSR13 Hypermedia Links    Larry Garfield  Matthew Weier O’Phinney Marc Alexander

## PSR14 Event Dispatcher    Larry Garfield  N/A Cees-Jan Kiewiet

* 事件 - 事件是发射器生成的消息。可以是任意的 PHP 对象
  - 充当发射器和适当的监听器之间的通信单元的对象
  - 如果用例要求监听器提供信息给发射器，那事件对象可能是可变的。然而，如果没有这种双向通信要求，那么建议事件对象定义成不可变的。即，不给对象定义改变对象的方法。
  - 实现者必须假设相同的对象将被传递到所有的监听器。
  - 建议，但不要求事件对象实现无丢失的序列化与反序列化；$event == unserialize(serialize($event))应该为真。如果合适的话，事件对象可以利用 PHP 的 Serializable 接口，__sleep() 或__wakeup() 魔术方法或类似的语言的功能。
  - 可终止的事件:事件的特殊案例，它包含了一些额外的方法，这些方法阻止后继监听器被调用。它是通过实现 StoppableEventInterface 来表示的
    + 当事件被完成时，实现了 StoppableEventInterface 的事件必须从 isPropagationStopped() 返回真。具体由类的实现者自己决定
* 监听器 - 一个监听器是任意的可调用的 PHP 类或函数，它期待着事件的传递。相同的事件可以传递给零个或多个监听器。如果有必要，一个监听器可以入队一些其他的异步行为。
  - 必须仅有一个参数，即它响应的事件。监听器应该根据相关用例约束参数类型。就是说，一个监听器可能使用某接口的类型约束，表示它与任何实现了该接口的事件类型兼容，或与该接口的特定实现兼容。
  - 一个监听器应该返回 void，且应该显示约束它。分发器必须忽略从监听器返回的值。
  - 一个监听器可能将操作委托给其他代码。其中包含一个监听器，这个监听器是运行实际业务逻辑对象的浅包装。
  - 一个监听器可能入队来自事件对象的信息，由调度器、队列服务器或者类似的辅助处理程序进行后续处理。它也可能将序列化的事件对象入队。但是，也要考虑到并不是所有的事件对象都可以被安全的序列化。辅助处理程序必须假设对事件对象的任何改变都不会传递给监听器。
  - 有监听器触发异常或者错误必须阻塞后续监听器的执行。监听器触发的异常或错误必须允许回传到发射器。分发器可能会记录捕获的异常或错误，及其他操作，但是操作完后必须将重新抛回原始的异常或错误。
* 发射器 - 发射器是期待分发事件的任何 PHP 代码，也叫调用代码。它不是由任何特定的数据结构表示的，而是指用例。
* 分发器 - 分发器是一个服务对象，它的事件对象由发射器提供。分发器负责将事件传递给所有相关的监听器，但是必须把确定哪些监听器应该响应事件这一步骤委托给监听器提供者去做。
  - 实现了 EventDispatcherInterface 的服务对象。它负责为已分发的事件从监听器提供者中获取监听器，并调用与该事件相关的每一个监听器
  - 分发器必须同步按序调用从监听器提供者获得的监听器。
  - 调用完监听器后，必须返回相同的事件对象。
  - 在所有的监听器执行完之前，必不能返回给发射器
  - 如果传递了可终止的事件，分发器：必须在每个监听器调用之前调用事件中的方法 isPropagationStopped()。if 过返回为真，必须立刻将事件返回给发射器，且必不能继续调用监听器。这就意味着如果传递给分发器的事件在调用 isPropagationStopped() 后总是返回真，将不会有监听器被调用。
  - 分发器应该假设从监听器提供者获取的监听器都是类型安全的。就是说，分发器应该假设调用 $listener($event) 不会产生 TypeError
  - 分发器应该组成一个监听器提供者来确定相关的监听器。建议将监听器实现为与分发器不同的对象，但这不是要求的。
* 监听器提供者 负责确定哪些监听器是与给定事件相关的，但是它不能调用监听器。一个监听器提供者可能会指定零个或多个相关的监听器。它可能既要决定哪些监听器是相关的也要根据给定的意义按序返回监听器。可能包括
  - 允许某种形式的注册机制，以便实现者可以按固定顺序将监听器分配给事件。
  - 根据事件的类型和实现的接口，通过反射派生出一个适用的监听器列表。
  - 提前生成可能在运行时查询的已编译的监听器列表。
  - 实现某种形式的访问控制，以便只有当前用户具有特定权限时才会调用某些监听器。
  - 从事件引用的对象（如实体）中提取某些信息，并对该对象调用预定义的生命周期方法。
  - 使用某些任意逻辑将其职责委托给一个或多个其他监听器提供程序。
  - 监听器提供者应该根据事件的类名来区分事件。也可能视情况根据事件的其他信息来区分。
* 接口
  - EventDispatcherInterface
  - ListenerProviderInterface
  - StoppableEventInterface

## PSR15 HTTP Handlers   Woody Gilk  N/A Matthew Weier O’Phinney

描述了 HTTP 服务器的请求处理程序（“请求处理器”）和 HTTP 服务器的中间组件（“中间件”）的常用接口

* HTTP 请求处理器是任何一个 web 项目中的基本部分，服务器端的代码接受请求消息，然后处理它，并且生成一个响应信息。
  - 请求处理器必须是独立的组件来处理请求和创建由 PSR-7 定义的结果响应。
  - 如果请求的条件组织请求处理器产生相应，那么请求处理器 应该 抛出一个异常。这个异常的类型是没有定义的。
  - 使用该标准的中间件 必须 实现以下接口：`Psr\Http\Server\RequestHandlerInterface`
* HTTP 中间件就是一种将处理请求和响应过程从应用层分离出来的方法。
  - 一个独立组件，通常与其他中间件组件一起参与处理传入请求并创建由 PSR-7 定义的结果响应
  - 如果条件充分，中间件组件 应该 创建并返回响应而不委托给请求处理程序。
  - 使用该标准的中间件 必须 实现以下接口： `Psr\Http\Server\MiddlewareInterface`
* 生成响应:议任何生成响应的中间件或请求处理程序将组成 PSR-7 ResponseInterface 的原型或能够生成 ResponseInterface 实例的工厂，以防止依赖于特定的 HTTP 消息实现。
* 异常处理: 建议任何使用中间件的应用程序都包含捕获异常并将其转换为响应的组件。这个中间件应该是第一个被执行的组件，并且包含所有进一步的处理以确保始终生成响应

## PSR16 Simple Cache    Paul Dragoonis  Jordi Boggiano  Fabien Potencier

* CacheInterface 接口
  - 定义了基于缓存实体的最基本的操作，其包括读写和删除单个缓存项目。
  - 还定义了处理多个缓存项目的方法，如：一次性写入，读取，删除多个项目的操作。当你需要执行大量的读 / 写操作时很有用，仅仅一个单次访问缓存服务器便可执行操作多个项目，从而显著的减少延迟时间。
  - 一个 CacheInterface 实例对应一个拥有单个键命令空间的缓存集合，其等价于在 PSR-6 中的 “Pool”，不同的 CacheInterface 实例可以被相同的 datastore 支持，但必须有在逻辑上是独立的。
* CacheException
* InvalidArgumentException

## PSR17 HTTP Factories  Woody Gilk  N/A Matthew Weier O’Phinney

* 创建符合 PSR-7 规范的 HTTP 对象的工厂通用标准.可以创建由 PSR-7 定义的 HTTP 对象的方法。HTTP 工厂 必须 实现包中提供的所有对象类型
* 描述了可以实例化 PSR-7 对象的方法
* 接口
  - Psr\Http\Message\RequestFactoryInterface
  - Psr\Http\Message\ResponseFactoryInterface
  - Psr\Http\Message\ServerRequestFactoryInterface
  - Psr\Http\Message\StreamFactoryInterface
  - Psr\Http\Message\UploadedFileFactoryInterface
  - Psr\Http\Message\UriFactoryInterface

## PSR18 HTTP Client Tobias Nyholm   N/A Sara Golemon

* 客户端是实现了客户端接口 ClientInterface 的对象。客户端 可能 实现了以下功能：
  - 从提供的 HTTP 请求中发送更改过的那个。例如，将消息体压缩后再发出去。
  - 在 HTTP 响应返回到调用库之前改变它。例如，将请求的消息体解压缩。
* 错误处理
  - 客户端一定不能将正确格式的 HTTP 请求或 HTTP 响应当做错误条件。 例如，400 和 500 范围内的响应状态代码不能触发异常，必须正常返回到调用库。
  - 当且仅当客户端完全无法发送 HTTP 请求或者无法将 HTTP 响应解析为 PSR-7 格式响应对象时，客户端才必须抛出 Psr\Http\Client\ClientExceptionInterface 实例。
  - 如果由于请求体不是正常的 HTTP 请求或缺失某些关键信息（例如主机地址或方法名称）而无法发送请求，客户端必须抛出 Psr\Http\Client\RequestExceptionInterface 实例。
  - 如果由于任何类型的网络故障（包括超时）而无法发送请求，则客户端必须抛出一个 Psr\Http\Client\NetworkExceptionInterface 实例。
  - 在按照上面定义去实现适当的接口前提下，客户端可能抛出比这里定义更具体的异常（例如超时异常 TimeOutException 或主机不存在异常 HostNotFoundException）
* 接口
  - Psr\Http\Client\ClientInterface
  - Psr\Http\Client\ClientExceptionInterface
  - Psr\Http\Client\RequestExceptionInterface
  - Psr\Http\Client\NetworkExceptionInterface

## 实践

* 通过配置实现根命名空间与指定目录的映射，进而在创建 PHP 类时通过 PSR-4 自动载入标准根据类所在的目录路径生成对应的命名空间
* 通过外部 PHP Code Sniffer 工具对代码进行自动修复从而使其遵循 PSR-2 编码风格，提升工作效率
