# [PHP Hypertext Preprocessor](https://github.com/php/php-src)

The PHP Interpreter <http://www.php.net>

* 一门弱类型语言，变量在声明时不需要确定类型，运行时类型会发生显式或隐式的类型改变
* 一种解释型语言，即不需要编译。构建在 Zend 虚拟机之上
* 一种服务器端脚本语言，只能通过服务器访问，需要配置虚拟主机调试,结果以纯 HTML 形式返回给浏览器
* HTTP协议在Nginx等服务器的解析下,传送给相应的Handler（PHP等）来处理
* 后端渲染，默认html处理，模版文件以.php后缀
* 优点
  - 开发方便
  - 效率高
* 缺点
  - 性能差：密集运算场景下比 C 、C++ 相差很大
  - 不可以直接操作底层，需要依赖扩展库来提供 API 实现
  - **可控**：进程入口点和退出时机由额外的程序控制，执行PHP脚本时机仍然由外部驱动
  - 不可控：常驻内存运行环境缺失

## 版本

* 5.3
  - 支持了类似 Java 的 jar 包，名为 phar。可以像 Java 一样方便地实现应用程序打包和组件化，一个应用程序可以打成一个 Phar 包，直接放到 PHP-FPM 中运行
* 5.5
  - Opcache
    + PHP->Compiler->Opcodes->Zend VM
    + PHP->Opcodes Cache->Zend VM
* 7: zval 不再单独从堆上分配内存并且不自己存储引用计数
  - 变量标量类型声明：标量类型声明与返回类型声明
  - 短闭包
  - null合并运算符（??）的新空合并运算符被加入 用来与isset（）函数函数一起替换三元操作
  - 属性类型
  - JIT 编译器
  - FFI
  - 匿名类
  - Contemporary cryptography
  - Generators
  - 改进的性能 - PHPNG代码合并在PHP7中，比 PHP5快两倍
  - 降低内存消耗 - 优化后PHP7使用较少的资源
  - 标量类型声明:参数和返回值类型可以被强制执行
  - 一致性的64位支持 - 64位架构机器持续支持
  - 改进异常层次结构 - 异常层次结构得到改善
  - 许多致命错误转换成异常 - 异常的范围增大覆盖为许多致命的错误转化异常；
  - 安全随机数发生器 - 加入新的安全随机数生成器的API
  - 已过时的API和扩展删除 - 不同的旧的和不支持的应用程序和扩展，从最新的版本中删除
  - 零成本声明支持零成本加入断言
  - 飞船操作符：用于比较两个表达式。当第一个表达式较第二个表达式分别小于，等于或大于时它分别返回-1，0或1
  + 定义常量数组
  + Closure::call() 方法加入到临时绑定（bindTo）的对象范围
  + 需要使用 zval 指针的复杂类型（比如字符串、数组和对象）会自己存储引用计数。这样就可以有更少的内存分配操作、更少的间接指针使用以及更少的内存分配。在 PHP7 中的 zval, 已经变成了一个值指针，它要么保存着原始值，要么保存着指向一个保存原始值的指针。也就是说现在的 zval 相当于 PHP5 的时候的 zval . 只不过相比于 zval , 直接存储 zval, 我们可以省掉一次指针解引用，从而提高缓存友好性
  + 原因
    * 变量存储字节减小，减少内存占用，提升变量操作速度
    * 改善数组结构，数组元素和 hash 映射表被分配在同一块内存里，降低了内存占用、提升了 cpu 缓存命中率
    * 改进了函数的调用机制，通过优化参数传递的环节，减少了一些指令，提高执行效率
  + 引入过滤 unserialize（）函数以在反序列化不受信任的数据对象时提供更好的安全性。它可以防止可能的代码注入，使开发人员能够使用序列化白名单类
  + IntlChar类：这个类自身定义了许多静态方法用于操作多字符集的 unicode 字符。需要安装intl拓展
  + 两个新的函数引入以产生一个跨平台的方式加密安全整数和字符串
    + random_bytes() - 生成加密安全伪随机字节
    + random_int() - 生成加密安全伪随机整数
  + 期望是向后兼容的增强到旧 assert() 函数。期望允许在生产代码零成本的断言，并提供在断言失败时抛出自定义异常的能力。assert() 不是一种语言构建体，其中第一个参数是一个表达式的比较字符串或布尔用于测试
    + ssertion - 断言。在PHP5中，这必须是要计算一个字符串或要测试一个布尔值。在PHP中7，这也可能是一个返回值的表达式，将执行和使用的结果，以指示断言是成功还是失败
  + 生成器支持返回表达式：允许在生成器函数中通过使用 return 语法来返回一个表达式 （但是不允许返回引用值），可以通过调用 Generator::getReturn() 方法来获取生成器的返回值， 但是这个方法只能在生成器完成产生工作以后调用一次
  + 生成器委派：只需在最外层生成其中使用yield from，就可以把一个生成器自动委派给其他的生成器
  + 会话选项设置：session_start() 可以加入一个数组覆盖php.ini的配置
  + 单次使用 use 语句可以用来从同一个命名空间导入类，函数和常量(而不用多次使用 use 语句)
  + 错误处理：传统的错误报告机制的错误：通过抛出异常错误处理。类似于异常，这些错误异常会冒泡，直到它们到达第一个匹配的catch块。如果没有匹配的块，那么会使用 set_exception_handler() 安装一个默认的异常处理并被调用，并在情况下，如果没有默认的异常处理程序，那么该异常将被转换为一个致命的错误，并会像传统错误那样处理。
    + 由于 Error 层次结构不是从异常（Exception），代码扩展使用catch (Exception $e) { ... } 块来处理未捕获的异常，PHP5中将不会处理这样的错误。  catch (Error $e) { ... } 块或 set_exception_handler（）处理程序需要处理的致命错误
  + 引入了intdiv()的新函数，它执行操作数的整数除法并返回结果为 int 类型
  + Unicode codepoint 转译语法:接受一个以16进制形式的 Unicode codepoint，并打印出一个双引号或heredoc包围的 UTF-8 编码格式的字符串。 可以接受任何有效的 codepoint，并且开头的 0 是可以省略的
  + `preg_replace_callback_array`：可以使用一个关联数组来对每个正则表达式注册回调函数，正则表达式本身作为关联数组的键，而对应的回调函数就是关联数组的值
  - 改变了大多数错误的报告方式。不同于传统（PHP 5）的错误报告机制，大多数错误被作为 Error 异常抛出
  - list 会按照原来的顺序进行赋值。不再是逆序了.不再支持解开字符串
  - foreach不再改变内部数组指针
  - 十六进制字符串不再被认为是数字
  - $HTTP_RAW_POST_DATA 被移除，使用php://input代替
* 7.1 :2015.12.3
  - 减少内存分配次数
  - 多使用栈内存
  - 缓存数组的hash值
  - 字符串解析成桉树改为宏展开
  - 使用大块连续内存代替小块破碎内存
  - 空合并赋值操作符:第一个操作数是存在并且不为 NULL，则返回该操作数。否则返回第二个操作数
  - 参数以及返回值的类型现在可以通过在类型前加上一个问号使之允许为空。当启用这个特性时，传入的参数或者函数返回的结果要么是给定的类型，要么是null
  - 返回值声明为 void 类型的方法要么干脆省去 return 语句。对于 void来说，NULL 不是一个合法的返回值
  - 类常量可见性
  - iterable 伪类:可以被用在参数或者返回值类型中，它代表接受数组或者实现了Traversable接口的对象
  - 多异常捕获处理:一个catch语句块现在可以通过管道字符(|)来实现多个异常的捕获。 这对于需要同时处理来自不同类的不同异常时很有用
  - list支持键名
  - 字符串支持负向
  - 将callback 转闭包:Closure新增了一个静态方法，用于将callable快速地 转为一个Closure 对象
  - 对http2服务器推送的支持现在已经被加入到 CURL 扩展
  - 传递参数过少时将抛出错误:过去我们传递参数过少 会产生warning。php7.1开始会抛出error
  - 移除了ext/mcrypt拓展
* 7.2
  - 增加新类型object
  - 通过名称加载扩展:扩展文件不再需要通过文件加载 (Unix下以.so为文件扩展名，在Windows下以 .dll 为文件扩展名)进行指定。可以在php.ini配置文件进行启用
  - 允许重写抽象方法:当一个抽象类继承于另外一个抽象类的时候，继承后的抽象类可以重写被继承的抽象类的抽象方法
  - 使用Argon2算法生成密码散列:Argon2 已经被加入到密码散列（password hashing） API (这些函数以 password_ 开头), 以下是暴露出来的常量
  - 新增 PDO 字符串扩展类型,准备支持多语言字符集，PDO的字符串类型已经扩展支持国际化的字符集。以下是扩展的常量：
    + PDO::PARAM_STR_NATL
    + PDO::PARAM_STR_CHAR
    + PDO::ATTR_DEFAULT_STR_PARAM
  - 命名分组命名空间支持尾部逗号
  - number_format 返回值
  - get_class()不再允许null
  - count 作用在不是 Countable Types 将发生warning
  - 不带引号的字符串:在之前不带引号的字符串是不存在的全局常量，转化成他们自身的字符串。现在将会产生waring
  - __autoload 被废弃
  - each 被废弃:使用此函数遍历时，比普通的 foreach 更慢，并且给新语法的变化带来实现问题。因此被废弃了
  - is_object、gettype修正:is_object 作用在**__PHP_Incomplete_Class** 将反正 true;gettype作用在闭包在将正确返回resource
  - Convert Numeric Keys in Object/Array Casts:把数组转对象的时候，可以访问到整型键的值
* 7.3
  - 添加了 array_key_first() 和 array_key_last() 来获取数组的第一个和最后一个元素的键名
  - 添加了 fpm_get_status() 方法, 来获取FPM状态数组
  - 添加了几个FPM的配置项, 用来控制日志单行最大字符数, 日志缓冲等: log_limit, log_buffering, decorate_workers_output
  - libcurl >= 7.15.5 is now required
  - curl 添加了一堆常量
  - `json_decode `添加了一个常量`, JSON_THROW_ON_ERROR`,如果解析失败可以抛出异常,而不是通过之前的方法 `json_last_error()` 去获取
  - spl autoloader: 如果一个加载失败, 剩下的都不再执行
  - 说明了一些循环引用的情况会得到怎样的结果
  - heredoc/nowdoc 中如果遇到跟定界符相同的字符串就认为结束了,而最后真正的结束符则会被认为是语法错误
  - 在 循环+switch-case 语句的case 中使用continue 会报warning,说明了, 静态变量在被继承时,如果在子类里发生了循环引用,父类里的静态变量会跟着变
* 7.4
  - 短闭包函数
  - 预加载:框架启动时在内存中加载文件，而且在后续请求中永久有效,每次预加载的文件发生改变时，框架需要重新启动
  - 属性类型限定
  - 三元运算符 `$data['date'] ??= new DateTime();`
  - 预加载
    - 在服务器启动的时候，将某些文件永久读取到内存中，之后的请求即可直接从这内存中读取。利用这个功能，能够将框架，或者是类库预加载到内存中，以进一步提高性能，还能将php写的函数，当成内部函数使用（因为已经永久加载到内存，整个服务器共享）
    - 文件有所更新就得重新启动服务器
    - php.ini的 `opcache.preload` 指向一个启动文件，可以包含其他文件
  - 协变返回和逆变参数
    - 协变返回类型
  - 抛弃 array_merge ：在数组表达式中引入了扩展运算符
  - 箭头函数
  - 协变量返回和协变量参数
* 8 美国时间11月26日，PHP团队宣布PHP 8.0正式GA
  - 命名参数（named arguments）
    + 仅指定必需参数，跳过可选参数
    + 参数与顺序无关，且是自描述的
  - 联合类型（union types）
    + Type或null，使用特殊?Type语法
    + array或Traversable，使用特殊iterable类型
  - 属性（attributes）:使用基于 PHP 原生语法的结构化元数据来代替 PHPDoc 注解
    + 允许添加元数据到 PHP 函数、参数、类等，这些元数据随后可以通过可编程方式获取，通过注解可以直接访问深度集成到 PHP 自身的这些信息
  - 构造器属性提升（constructor property promotion）:将属性声明和构造函数属性初始化合并到一起
  - Match表达式
    + Match是一个表达式，表示其结果可以存储在变量中或返回。
    + Match分支仅支持单行表达式，不需要break; 语句。
    + Match执行严格比较
  - nullsafe运算符:当对链中一个元素的求值失败时，整个链的执行将中止，并且整个链的求值为 null
  - 字符串与数字的判断更合理:仅在字符串实际为数字时才使用数字比较，否则将数字转换为字符串，并执行字符串比较
  - 新的类、接口和函数
    + WeakMap 特性：创建对象到任意值的映射，同时也不会阻止作为键的对象被垃圾回收，如果某个对象键被垃圾回收，对应键值对将从集合中移除
  - 内部函数的类型错误一致
    + 新增 ValueError 异常类，继承自 Exception 基类
    + 如果参数验证失败，大多数内部函数将抛出 Error 异常
  - 重写方法时允许可变参数
  - 使用 static 关键字标识某个方法返回该方法当前所属的类，即使它是继承的（后期静态绑定）
  - $object::class 获取对象的类名，其返回结果和 get_class($object) 一样
  - new 和 instanceof 关键字现在可以被用于任意表达式
  - 引入了新的 Stringable 接口，只要某个类实现了 __toString 方法，即被视作自动实现了 Stringable 接口
  - Trait 可以定义抽象私有方法
  - throw 语句可以用在只允许表达式出现的地方，例如箭头函数、合并运算符和三元运算符等
  - 参数列表中允许出现可选的尾部逗号
  - 捕获异常而不存储到变量
  - JIT
    + Tracing JIT 的表现最出色
      * 在综合基准测试中的性能提高到大约 3 倍
      * 在某些特定的传统应用程序中提高到 1.5–2 倍
      * 典型的应用程序性能与 PHP 7.4 相当
    + 主要针对 CPU 密集型操作优化效果明显, IO 密集型操作的 Web 应用中，启用 JIT 与不启用相比，性能不但没有提升，反而有 10% 左右的损耗，至少在 Laravel 应用中是如此
    + 在 Opcache 之中提供,结合 Runtime 信息将字节码编译为机器码缓存起来
    + 在原来Opcache优化的优化基础之上进行优化
    + 只支持x86架构的CPU
    + JIT 不是对 Opcache 替代，而是增强，在启用 JIT 的情况下，如果 Zend 底层发现特定字节码已经编译为机器码，则可以绕过 Zend VM 直接让 CPU 执行机器码，从而提高代码性能
    + `opcache.jit_buffer_size`是定义分配多少内存给生成的机器码，这个看情况吧，一般测试就64M就行了
    + `opcache.jit`:配置由4个独立的数字组成，从左到右分别
      * 是否在生成机器码点时候使用AVX指令, 需要CPU支持
      * 寄存器分配策略： 0: 不使用寄存器分配 1: 局部(block)域分配 2: 全局(function)域分配
      * JIT触发策略: 0: PHP脚本载入的时候就JIT 1: 当函数第一次被执行时JIT 2: 在一次运行后，JIT调用次数最多的百分之(`opcache.prof_threshold` * 100)的函数 3: 当函数/方法执行超过N(N和opcache.jit_hot_func相关)次以后JIT 4: 当函数方法的注释中含有@jit的时候对它进行JIT 5: 当一个Trace执行超过N次（和`opcache.jit_hot_loop`, `jit_hot_return`等有关)以后JIT
      * JIT优化策略，数值越大优化力度越大: 0: 不JIT 1: 做opline之间的跳转部分的JIT 2: 内敛opcode handler调用 3: 基于类型推断做函数级别的JIT 4: 基于类型推断，过程调用图做函数级别JIT 5: 基于类型推断，过程调用图做脚本级别的JIT
    + 尽量使用12X5型的配置，此时应该是效果最优的
    + 对于上面的X，如果是脚本级别的，推荐使用0，如果是Web服务型的，可以根据测试结果选择3或5
    + @jit的形式，在有了attributes以后，可能变为<<jit>>
  - 类型系统和错误处理方面的改进
    + 对算术/按位运算符进行更严格的类型检查（https://wiki.php.net/rfc/arithmetic_operator_type_checks）
    + 抽象特征方法验证（https://wiki.php.net/rfc/abstract_trait_method_validation）
    + 魔术方法的正确签名（https://wiki.php.net/rfc/magic-methods-signature）
    + 重分类引擎警告（https://wiki.php.net/rfc/engine_warnings）
    + 不兼容方法签名的致命错误（https://wiki.php.net/rfc/lsp_errors）
    + @运算符不再使致命错误静默。
    + 用私有方法继承（https://wiki.php.net/rfc/inheritance_private_methods）
    + 混合类型（https://wiki.php.net/rfc/mixed_type_v2）
    + 静态返回类型（https://wiki.php.net/rfc/static_return_type）
    + 内部函数类型（https://externals.io/message/106522）
    + 不透明的对象代替Curl、Gd、Sockets、OpenSSL、XMLWriter和XML扩展的资源

```sh
php -d opcache.jit_buffer_size=0 Zend/bench.php
# 启用
php -d opcache.jit_buffer_size=64M -d opcache.jit=1205 Zend/bench.php
# 观测JIT后生成的汇编结果
php -d opcache.jit=1205 -dopcache.jit_debug=0x01
```

## 原理

* 以多进程模型设计
  - 子进程结束以后, 内核会负责回收资源
  - 请求之间互不干涉，子进程异常退出不会导致整个进程Thread退出. 父进程还有机会重建流程
* 实现了一个虚拟机 Zend VM，将可读脚本编译成虚拟机理解的指令，也就是操作码，这个执行阶段就是“编译时（Compile Time）”；在“运行时（Runtime）”执行阶段，虚拟机 Zend VM 会执行这些编译好的操作码
* PHP 代码 => Token => 抽象语法树 => Opcodes => 执行
  - 源代码通过词法分析得到 Token： Token 是 PHP 代码被切割成的有意义的标识。PHP7 一共有 137 种 Token，在 zend_language_parser.h 文件中做了定义
  - 基于语法分析器将 Token 转换成抽象语法树（AST）：Token 就是一个个的词块，但是单独的词块不能表达完整的语义，还需要借助一定的规则进行组织串联。所以就需要语法分析器根据语法匹配 Token，将 Token 进行串联。语法分析器串联完 Token 后的产物就是抽象语法树（AST，Abstract Syntax Tree）。 AST 是 PHP7 版本的新特性，之前版本的 PHP 代码的执行过程中是没有生成 AST 这一步的。它的作用主要是实现了 PHP 编译器和解释器的解耦，提升了可维护性。
  - 语法树转换成 Opcode
  - 执行 Opcodes： opcodes 是 opcode 的集合形式，是 PHP 执行过程中的中间代码
* 开启 opcache：指将 opcodes 进行缓存。通过省去从源码到 opcode 的阶段，引擎直接执行缓存好的 opacode，以提升性能
* 四层体系构成，从上到下依次
  - 上层应用:程序员编写的PHP程序，无论是 Web 应用还是 Cli 方式运行的应用
  - SAPI Server Application Programming Interface) 服务端应用编程接口：通过一系列钩子函数使得PHP可以和外围交换数据
    + SAPI 就是 PHP 和外部环境的代理器，它把外部环境抽象后，为内部的PHP提供一套固定的，统一的接口，使得 PHP 自身实现能够不受错综复杂的外部环境影响，保持一定的独立性
    + 通过 SAPI 的解耦，PHP 可以不再考虑如何针对不同应用进行兼容，而应用本身也可以针对自己的特点实现不同的处理方式
  - Extensions 扩展:常见的内置函数、标准库都是通过extension来实现的，这些叫做PHP的核心扩展，用户也可以根据自己的要求安装PHP的扩展
    + 常用 SAPI
      * apache2handler: Apache 扩展，编译后生成动态链接库，配置到 Apache 下。当有 http 请求到 Apache 时，根据配置会调用此动态链接库来执行 PHP 代码，完成与 PHP 的交互。
      * cgi-fcgi: 编译后生成支持 CGI 协议的可执行程序，webserver（如 NGINX）通过 CGI 协议把请求传给 CGI 进程，CGI 进程根据请求执行相应代码后将执行结果返回给 webserver。
      * fpm-fcgi: fpm 是 FastCGI 进程管理器。以 NGINX 服务器为例，当有请求发送到 NGINX 服务器，NGINX 按照 FastCGI 协议把请求交给 php-fpm 进程处理。
      * cli: PHP 的命令行交互接口
        - Zend 目录 Zend 目录是 PHP 的核心代码。PHP 中的内存管理，垃圾回收、进程管理、变量、数组实现等均在该目录的源码里。
        - main 目录 main 目录是 SAPI 层和 Zend 层的黏合剂。Zend 层实现了 PHP 脚本的编译和执行，sapi 层实现了输入和输出的抽象，main 目录则在它们中间起着承上启下的作用。承上，解析 SAPI 的请求，分析要执行的脚本文件和参数；启下，调用 zend 引擎之前，完成必要的模块初始化等工作
        - ext 目录 ext 是 PHP 扩展相关的目录，常用的 array、str、pdo 等系列函数都在这里定义
        - TSRM TSRM（Thread Safe Resource Manager）—— 线程安全资源管理器， 是用来保证资源共享的安全
  - Zend 引擎:PHP4 以后加入 PHP 的，是对原有PHP解释器的重写，整体使用 C 语言进行开发。作用是将PHP代码翻译为一种叫opcode的中间语言，它类似于JAVA的ByteCode（字节码）。引擎对PHP代码会执行四个步骤：
    + 词法分析 Scanning（Lexing），将 PHP 代码转换为语言片段（Tokens）
    + 解析 Parsing， 将 Tokens 转换成简单而有意义的表达式
    + 编译 Compilation， AST 将表达式编译成Opcode
    + 执行 Execution，虚拟机顺序执行Opcode，每次一条，以实现PHP代码所表达的功能
    + APC、Opchche 这些扩展可以将Opcode缓存以加速PHP应用的运行速度，使用它们就可以在请求再次来临时省略前三步
    + 引擎也实现了基本的数据结构、内存分配及管理，提供了相应的API方法供外部调用
* 请求
  - php_module_startup()
  - php_request_startup()
  - php_excute_script()
  - php_request_shutdown()
  - php_module_shutdown()
* 变量实现
* 自动回收
  - 引用计数 (reference counting) GC 机制
  - 每个对象都内含一个引用计数器 refcount，每个 reference 连接到对象，计数器加 1,共用value
  - 当 reference 离开生存空间或被设为 NULL，计数器减 1
  - 当某个对象的引用计数器为零时,释放其所占的内存空间
  - 引用计数大于0的value发生写操作时进行分离
* 语言特性
* 内存操作
* 线程安全

![PHP 架构](../../_static/php_construct.jpg "Optional title")

```sh
## 开启Opcache
zend_extension=opcache.so
opcache.enable=1
opcache.enable_cli=1
opcache.huge_code_pages=1
opcache.file_cache=/tmp

# 系统开启HugePages
cat /proc/meminfo  | grep Huge
AnonHugePages:    106496 kB
HugePages_Total:     512
HugePages_Free:      504
HugePages_Rsvd:       27
HugePages_Surp:        0
Hugepagesize:       2048 kB
```

## 安装

* 综合环境
  - [XAMPP](https://www.apachefriends.org/index.html)
  - [wampserver](https://www.wampserver.com/)
  - [mamp](https://www.mamp.info)
    + http://localhost:8888/MAMP/
    + /Applications/MAMP/htdocs
    + MySQL port：8889
  - [Wnmp](https://github.com/wnmp/wnmp):Version of nginx for Windows uses the native Win32 API (not the Cygwin emulation layer). Only the select() connection processing method is currently used, so high performance and scalability should not be expected.
    + `tasklist /fi "imagename eq nginx.exe" # 查看进程，没有查看error.log`
* php-dev
  - phpize
    + 有版本号，依赖安装指定目录
    + mac:`/usr/local/lib/php/pecl/`
    + 需要 php7.*-dev 支持
  - php-config
* php-cgi
* 程序 `/usr/local/Cellar/php`
* 配置 `/usr/local/etc/php/`
* php71 卸载后 php-fpm仍然运行
  - `brew services stop php`
* 准备
  - libpcre3-dev: Perl 5 Compatible Regular Expression Library
  - gettext
* 源码自带扩展模块
  - Date/Time Support(date),默认编译安装，不可禁止
  - 默认启用，编译时可通过下列选项禁用
    + −−disable-ctype
    + −−disable-dom DOM Document Object Model
    + −−disable-fileinfo fileinfo support
    + −−disable-hash  Disable hash support
    + −−without-iconv=DIR  Exclude iconv support
    + −−disable-json  Disable JavaScript Object Serialization support
    + −−disable-libxml  Disable LIBXML support
      * −−with-libxml-dir=DIR   LIBXML: libxml2 install prefix Debian/Ubuntu 需安装 libxml2, libxml2-dev 依赖包，Redhat/CentOS 需安装 libxml2, libxml2-devel 依赖包
    + −−disable-phar  Disable phar support
    + −−disable-pdo  Disable PHP Data Objects support
    + −−disable-posix  Disable POSIX-like functions
    + −−disable-session  Disable session support
    + −−disable-simplexml  Disable SimpleXML support
    + −−disable-tokenizer  Disable tokenizer support
    + −−disable-xml  Disable XML support
  - 开启扩展
    + −−enable-bcmath Enable bc style precision math functions
    + −−enable-calendar Enable support for calendar conversion
    + −−enable-dba Build DBA with bundled modules
      * 默认自带 3 个参数，−−with-cdb，−−enable-inifile，inifile-flatfile
      * 若要禁止，则需通过参数−−without-cdb=DIR，−−disable-inifile，−−disable-flatfile 实现
    + −−enable-exif Enable EXIF (metadata from images) support
    + −−enable-intl Enable internationalization support
    + −−enable-mbstring Enable multibyte string support
      * −disable-mbregex  MBSTRING: Disable multibyte regex support
      * −−disable-mbregex-backtrack  MBSTRING: Disable multibyte regex backtrack check
      * −−with-libmbfl=DIR  MBSTRING: Use external libmbfl.  DIR is the libmbfl base install directory BUNDLED
      * −−with-onig=DIR  MBSTRING: Use external oniguruma. DIR is the oniguruma install prefix. If DIR is not set, the bundled oniguruma will be used
    + −−enable-ftp Enable FTP support
      * 参数 −−with-openssl-dir=DIR  FTP: openssl install prefix，可不指定，则使用系统自带 openssl 库
    + DB-LIB (MS SQL, Sybase)(pdo_dblib)，Windows 专用扩展。用于连接 SQL Server 和 Sybase 数据库的 PDO 驱动扩展
    + −−enable-mysqlnd Enable mysqlnd explicitly, will be done implicitly when required by other extensions
    + -−enable-shmop  Enable shmop support
    + −−enable-soap Enable SOAP support
    + −−enable-sockets Enable sockets support
    + −−enable-zip  Include Zip read/write support
  - −−with-curl=DIR Include cURL support Debian/Ubuntu 需安装 libcurl4-gnutls-dev 依赖包。Redhat/CentOS 需安装 curl-devel 依赖包
  - −−with-bz2=DIR Include BZip2 support 安装 Debian/Ubuntu 需安装 libbz2-dev 依赖包,Redhat/CentOS 需安装 bzip2-devel 依赖包
  - −−with-enchant=DIR Debian/Ubuntu 需安装 libenchant-dev, libpspell-dev 依赖包，Redhat/CentOS 需安装 enchant-devel,aspell-devel 依赖包
  - GD imaging(gd) −−with-gd=DIR  Include GD support.  DIR is the GD library base install directory BUNDLED
    + −−with-webp-dir=DIR(PHP 7.0, 7.1 only)
    + −−with-jpeg-dir=DIR
    + −−with-png-dir=DIR
    + −−with-zlib-dir=DIR
    + −−with-xpm-dir=DIR
    + −−with-freetype-dir=DIR
    + −−enable-gd-native-ttf
    + −−enable-gd-jis-conv
    + Debian/Ubuntu 需安装 libwebp-dev, libjpeg-dev, libpng-dev, libxpm-dev, libfreetype6-dev, libvpx-dev 依赖包
    + Redhat/CentOS 需安装 libwebp-devel, libjpeg-devel, libpng-devel, libXpm-devel, freetype-devel, libvpx-devel
  - −−with-gettext=DIR  Include GNU gettext support
  - −−with-interbase=DIR Include Firebird support
  - −−with-pdo-firebird=DIR PDO: Firebird support
  - −−with-gmp=DIR Include GNU MP support
  - −−with-ldap=DIR         Include LDAP support
  - −−with-ldap-sasl=DIR    LDAP: Include Cyrus SASL support，Debian/Ubuntu 需安装 libldap-2.4-2, libldap2-dev 依赖包。Redhat/CentOS 需安装 openldap, openldap-devel 依赖包
  - IMAP
    + −−with-imap=DIR         Include IMAP support. DIR is the c-client install prefix
    + −−with-kerberos=DIR     IMAP: Include Kerberos support. DIR is the Kerberos install prefix
    + −−with-imap-ssl=DIR     IMAP: Include SSL support. DIR is the OpenSSL install prefix
  - −−with-mcrypt=DIR Include mcrypt support，Debian/Ubuntu 需安装 libmcrypt-dev 依赖包，Redhat/CentOS 需编译安装 libmcrypt 和 mcrypt 。如果安装了 EPEL 的话，则需安装 libmcrypt-devel 依赖包
  - −−with-mysql-sock=SOCKPATH  MySQLi/PDO_MYSQL: Location of the MySQL unix socket pointer
  - −−with-pdo-mysql=DIR  PDO: MySQL support. DIR is the MySQL base directory，若未指定，则默认安装 mysqlnd
  - −−with-mysqli=FILE  Include MySQLi support. FILE is the path to mysql_config
  - −−with-oci8=DIR  Include Oracle Database OCI8 support. DIR defaults to $ORACLE_HOME
  - −−with-pdo-odbc=flavour,dir
  - −−with-openssl=DIR      Include OpenSSL support (requires OpenSSL >= 1.0.1)
  - −−with-kerberos=DIR     OPENSSL: Include Kerberos support
  - −−with-system-ciphers   OPENSSL: Use system default cipher list instead of hardcoded value
  - −−enable-pcntl  Enable pcntl support (CLI/CGI only)
  - −−with-pcre-regex=DIR   Include Perl Compatible Regular Expressions support. DIR is the PCRE install prefix BUNDLED
  - −−with-pcre-jit  Enable PCRE JIT functionality
  - −−with-pdo-pgsql=DIR  PDO: PostgreSQL support.  DIR is the PostgreSQL base install directory or the path to pg_config
  - −−with-pgsql=DIR  Include PostgreSQL support.  DIR is the PostgreSQL base install directory or the path to pg_config
  - −−with-readline=DIR  Include readline support (CLI/CGI only)
* [ircmaxell/phpvm](https://github.com/ircmaxell/phpvm):A PHP version manager for CLI PHP
* −−with-tidy=DIR  Include TIDY support
* [philcook/brew-php-switcher](https://github.com/philcook/brew-php-switcher):Brew PHP switcher is a simple shell script to switch your apache and CLI quickly between major versions of PHP. If you support multiple products/projects that are built using either brand new or old legacy PHP functionality. For users of Homebrew (or brew for short) currently only
* [swisnl/php7-upgrade-tools](https://github.com/swisnl/php7-upgrade-tools):A set of tools for upgrading applications to PHP 7

```sh
/usr/local/apache2/bin/apachectl start|stop
service httpd restart

LoadModule php5_module modules/libphp5.so # httpd.conf中添加

extension_dir = "/usr/local/lib/php/pecl/20180731"

#  php.ini:如果文件不存在，则阻止 Nginx 将请求发送到后端的 PHP-FPM 模块， 以避免遭受恶意脚本注入的攻击
cgi.fix_pathinfo=0
# 确保 php-fpm 模块使用 www-data 用户和 www-data 用户组的身份运行
# This is an extremely insecure setting because it tells PHP to attempt to execute the closest file it can find if a PHP file does not match exactly. This basically would allow users to craft PHP requests in a way that would allow them to execute scripts that they shouldn't be allowed to execute.

### windows 下载PHP安装包，解压即可
./php.exe -f e:\www\test.php
php.exe -v
php.exe -i # 运行phpinfo()函数

# 进入命令行模式
php -a

### Mac
brew install --without-apache --with-fpm php

## 配置文件添加扩展
include=/usr/local/etc/php/7.1/conf.d/*.ini

mkdir -p ~/Library/LaunchAgents
cp /usr/local/opt/php71/homebrew.mxcl.php71.plist ~/Library/LaunchAgents/
launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.php71.plist

brew services start|stop|restart php71

PHP Startup: Unable to load dynamic library # 扩展重复加载

# 默认php-cli为/usr/bin/php，提升优先级
echo 'export PATH="/usr/local/opt/php@7.1/bin:$PATH"' >> ~/.zshrc
echo 'export PATH="/usr/local/opt/php@7.1/sbin:$PATH"' >> ~/.zshrc

### linux源码安装
lsb_release -a # 系统环境查看

vim /etc/httpd/httpd.conf
AddType application/x-httpd-php .php
AddType application/x-httpd-source .phps

vim  /usr/local/php/etc/php.ini
date.timezone = Asia/Shanghai

brew install brew-php-switcher
brew-php-switcher 5.6
brew unlink php
brew link php
# virtual memory exhausted: Cannot allocate memory
# 编译调整虚拟机内存大小

## ubuntu 安装
apt-get update && apt-get upgrade
apt-get install software-properties-common
sudo add-apt-repository ppa:ondrej/php
apt-get install php7.4 php7.4-{bz2,json,zip,mbstring,gd,curl,xml,common,opcache,imagick,fpm,mysqli,cli,bcmath,intl,soap,xdebug,xsl,xmlrpc,dev,pdo,sqlite3}  php-pear
    - fileinfo
    - OpenSSL

sudo systemctl start php7.0-fpm.service
sudo service php7.0-fpm start|stop|restart|reload

update-alternatives --config php

sudo apt install -y pkg-config build-essential autoconf bison re2c libxml2-dev \
libsqlite3-dev libssl-dev libcurl4-openssl-dev libpng-dev libonig-dev libzip-dev
./buildconf --force
./configure --prefix=/usr/local/php8 \
--with-config-file-path=/usr/local/php8 \
--enable-mbstring  \
--enable-ftp  \
--enable-gd   \
--enable-mysqlnd \
--enable-pdo   \
--enable-sockets   \
--enable-fpm   \
--enable-xml  \
--enable-soap  \
--enable-pcntl   \
--enable-cli   \
--enable-json  \
--enable-tokenizer \
--enable-ctype \
--enable-bcmath  \
--with-openssl  \
--with-pear   \
--with-zlib  \
--with-iconv  \
--with-curl  \
--with-zip

# 源码中提供了一个基准测试文件
/usr/local/php8/bin/php -d opcache.jit_buffer_size=0 Zend/bench.php
/usr/local/php8/bin/php -d opcache.jit_buffer_size=64M -d opcache.jit=1205 Zend/bench.php

## windows wsl
PhpStorm: Settings -> Language & Frameworks -> PHP->CLI Interpreter->From Docker, Vagrant, VM, WSL, Remote...
Composer
TestFramework -> PHPUnit

php -S localhost:8000 -c app/config/php.ini router.php
```

### Cli

* 一个常驻主进程,只负责任务分发
* 实现定时任务
* 开发桌面应用就是使用PHP-CLI和GTK包
* linux下用php编写shell脚本
* built-in web server 内置Web服务器不能在生成环境使用，只能在本地开发环境中使用
  - php_sapi_name() return cli-server:the current script is served with the PHP built-in server
  - performs suboptimally because it handles one request at a time, and each HTTP request is blocking
  - supports only a limited number of mimetypes
  - limited URL rewriting with router scripts.
  - 性能不佳:一次只能处理一个请求，其他请求会受到阻塞。如果某个进程耗时较长（数据库查询、远程API调用），则整个Web应用会陷入停顿状态。
  - 支持媒体类型较少（PHP 5.5.7以后有较大改进）
  - 路由脚本仅支持少量URL重写
* 配置
  - The configuration is loaded fresh each time you invoke PHP from the CLI.
  - 配置比较长的max_execution_time

```sh
# 查找PHP CLI ini文件位置
php --ini
# 调用PHP CLI解释器，并给脚本传递参数
php -f /path/to/yourfile.php

# 内置 web 服务器
php -S localhost:8000 -c app/config/php.ini

# 判断当前执行的php是什么模式下 R RUN
php -r "echo php_sapi_name();"

# if (php_sapi_name() == ‘cli-server') {
#     // PHP 内置 Web 服务器
# } else {
#     // 其他Web服务器
# }
```

## PHP-FPM PHP-FastCGI Process Manager

* 安装
  - bin: /usr/local/php/sbin/php-fpm
  - 配置
    + /usr/local/php/etc/php.ini
    + /usr/local/php/etc/php-fpm.conf
    + /private/etc/php-fpm.conf
    + /private/etc/php-fpm.d/www.conf.default
    + /usr/local/etc/php/7.3/php-fpm.d/www.conf
* PHP-FPM 是 FastCGI 的实现，提供了多进程 FastCGI 管理功能
  - master 进程负责与 Web 服务器进行通信，接收 HTTP 请求，再将请求转发给 worker 进程进行处理
  - worker 进程负责动态执行 PHP 代码，处理完成后，将处理结果返回给 Web 服务器，再由 Web 服务器将结果发送给客户端
  - 常驻内存启动一些 PHP 进程待命，请求进入时分配一个进程进行处理，进程处理完毕后回收进程，并不销毁进程，让PHP能应对高流量访问请求
  - Nginx 通过 FastCGI 协议将请求转发给 PHP-FPM 处理，PHP-FPM 的 Worker 进程会抢占式的获得 CGI 请求进行处理，整个的过程是阻塞等待的，也就意味着 PHP-FPM 的进程数有多少能处理的请求也就是多少
* 高并发场景下，异步非阻塞就显得优势明显
  - Worker 进程不再同步阻塞去处理一个请求，可以同时处理多个请求，无需 I/O 等待，并发能力极强，可以同时发起或维护大量的请求
  - 缺点：永无止境的回调
* 原理
  - nginx 一般根据请求类型，把请求加载对应 fast-cgi 模块，fascgi管理进程选择 cgi 子进程处理结果，并返回给nginx
  - socket 是 Nginx 与 PHP 的通信载体
    + fastcgi_pass 所配置内容告诉 Nginx 接收到用户请求以后该往哪里转发
    + fastcgi 是 webserver 协议的一种实现
  - 进程模型
    + 预派生子进程模式，Apache 就是采用该模式，程序启动后就会创建N个进程，每个子进程进入 Accept，等待新的连接进入
    + 当客户端连接到服务器时，其中一个子进程会被唤醒，开始处理客户端请求，并且不再接受新的TCP连接
    + 来一个请求就 fork 一个进程，进程的开销是非常大的，会大大降低吞吐率，并发数由进程数决定
    + 当此连接关闭时，子进程会释放，重新进入Accept，参与处理新的连接
  - 运作模式
    + Nginx 提供 HTTP 服务，所有客户端发起的请求最先抵达 Nginx
    + Nginx 通过 FastCGI 协议将请求转发给 PHP-FPM 处理
    + Master 进程为每个请求分配一个 Worker 进程来处理
    + 在启动阶段设置 HTTP 环境变量，然后通过 PHP 核心代码初始化所有已经启用的 PHP 模块（即扩展），并对此次请求上下文进行初始化，完成这些操作后再调用 Zend 引擎来编译并执行业务逻辑代码
    + 等待 PHP 脚本解析，业务处理的结果返回，完成后回收子进程，这整个的过程是阻塞等待的，也就意味着 PHP-FPM 的进程数有多少能处理的请求也就是多少，假设 PHP-FPM 有 200 个 Worker进程，一个请求将耗费 1 秒的时间，那么简单的来说整个服务器理论上最多可以处理的请求也就是 200 个，QPS 即为 200/s
    + Zend 引擎会检查 OpCode 缓存，如果代码片段已经缓存，则从缓存中读取并执行，否则编译成 OpCode 并缓存后执行
    + 代码执行完成后，会将处理结果打印或着发送 HTTP 响应给客户端，然后 PHP 底层代码会执行请求关闭及模块关闭函数进行后续清理工作，最后再回到 SAPI 层，调用 PHP-FPM 对应的关闭函数，从而完成此次请求的所有流程
    + 过程周而复始，每次用户有新请求过来都会从头执行一遍:所有的环境初始化、模块初始化、请求初始化以及框架应用启动过程，乃至后续请求关闭、模块关闭、PHP-FPM 关闭
  - 在 Nginx + PHP-Fpm 模式下开发非常简单,不用担心内存泄露
    + nginx 基于 epoll 事件模型，一个 worker 同时可处理多个请求, 但在同一时刻可处理一个请求
    + fpm-worker 每次处理请求前需要重新初始化mvc框架，然后再释放资源
    + 高并发请求时，fpm-worker不够用，nginx 直接响应 502
    + fpm-worker 进程间切换消耗大
  - php的fastcgi进程管理器php-fpm和nginx的配合已经运行得足够好，但是由于php-fpm本身是同步阻塞进程模型，在请求结束后释放所有的资源（包括框架初始化创建的一系列对象，导致PHP进程空转（创建<-->销毁<-->创建）消耗大量的CPU资源，从而导致单机的吞吐能力有限。请求夯住，会导致 CPU 不能释放资源， 大大浪费了 CPU 使用率
* 优点
  - 复用进程，不需要太多上下文切换
* 缺点
  - 严重依赖进程数量解决并发问题，一个客户端连接就需要占用一个进程，工作进程数量有多少，并发处理能力就有多少。操作系统可以创建的进程数量是有限的
  - PHP 框架初始化会占用大量的计算资源，每个请求都需要初始化
  - 启动大量进程会带来额外的进程调度消耗。数百个进程时可能进程上下文切换调度消耗占CPU不到1%可以忽略不计，如果启动数千甚至数万个进程，消耗就会直线上升。调度消耗可能占到 CPU 的百分之几十甚至 100%
  - 如果请求一个第三方请求非常慢，请求过程中会一直占用 CPU 硬件资源
  - 高并发的场景下，这样的性能是不够的，尽管可以利用 Nginx 作为负载均衡配合多台 PHP-FPM 服务器来提供服务，但由于 PHP-FPM 的阻塞等待工作模型，一个请求会占用至少一个 MySQL 连接，多节点高并发下会产生大量的 MySQL 连接，而 MySQL 最大连接数默认值为 100，尽管可以修改，但显而易见该模式没法很好的应对高并发的场景
* 解决
  - IO密集性业务：频繁上下文切换
    + 提高 IO 复用能力
    + 将php-fpm同步阻塞模式替换为异步非阻塞模式，异步开启模式比较复杂不易维护，当然不一定使用php-fpm
  - 线程模式开发太过复杂
    + 一个进程中能开的线程数也有限，线程太多也会增加 CPU 的负荷和内存资源，线程没有阻塞态，IO 阻塞也不能主动让出 CPU资源，属于抢占式调度模型。不太适合 php 开发
  - swoole 4.+ 开启了全协程模式，同步代码异步执行
* 配置
  - 静态：直接开启指定数量 php-fpm 进程，不再增加或者减少
  - 动态：开始时候开启一定数量php-fpm进程，当请求量变大时候，动态增加php-fpm进程数到上限，当空闲时候自动释放空闲的进程数到一个下限
  - 通信方式
    + Unix socket:又叫 IPC(inter-process communication 进程间通信) socket，用于实现同一主机上进程间通信，需要在 nginx 配置文件中填写 php-fpm 的 socket 文件位置
      * 与管道相比，Unix domain sockets 既可以使用字节流和数据队列，而管道通信则只能通过字节流
      * Unix domain socket 的功能是POSIX操作系统里的一种组件。Unix domain sockets 使用系统文件的地址来作为自己的身份。可以被系统进程引用。所以两个进程可以同时打开一个Unix domain sockets来进行通信。不过这种通信方式是发生在系统内核里而不会在网络里传播。压力比较满的时候，用套接字方式，效果确实比较好
      + Unix domain sockets的接口和Internet socket很像，但不使用网络底层协议来通信,不需要经过网络协议栈，不需要打包拆包、计算校验和、维护序号和应答等，只是将应用层数据从一个进程拷贝到另一个进程。所以其效率比 tcp socket 的方式要高，可减少不必要的 tcp 开销。
      + unix socket 高并发时不稳定，连接数爆发时，会产生大量的长时缓存，在没有面向连接协议的支撑下，大数据包可能会直接出错不返回异常。而 tcp 这样的面向连接的协议，可以更好的保证通信的正确性和完整性。
      + 由于 socket 文件本质上是一个文件，存在权限控制的问题，所以需要注意 nginx 进程的权限与 php-fpm 的权限问题，不然会提示无权限访问
    + TCP socket:使用TCP端口连接127.0.0.1:9000，可以跨服务器，当 nginx 和 php-fpm 不在同一台机器上时，只能使用这种方式
* 用到一些 PHP 第三方库，存在内存泄漏问题，如果不定期重启 PHP-CGI 进程，势必造成内存使用量不断增长。因此 PHP-FPM 作为 PHP-CGI 管理器提供了这么一项监控功能，对请求达到指定次数的 PHP-CGI 进程进行重启，保证内存使用量不增长
* 连接方式 与CPU 频率缩放问题一样？（CPUFreq governor）这些设置在类 Unix 系统和 Windows 上是有效的，可以通过修改 CPU governor，将其从 ondemand 修改为 performance 来提高性能并加快系统响应
  - Governor = ondemand：根据当前负荷动态调整 CPU 频率。先将 CPU 频率调整至最大，然后随着空闲时间增加而缩小频率
  - Governor = conservative：根据当前负荷动态调整频率。比设置成 ondemand 更加缓慢
  - Governor = performance：始终以最大频率运行 CPU。一个非常安全的性能提升方式，因为能完美的使用服务器 CPU 的全部性能。唯一需要考虑因素就是一些诸如散热、电池寿命（笔记本电脑）和一些由 CPU 始终保持 100% 所带来的一些副作用
* pm
  - static 设置取决于服务器有多少闲置内存 子进程的数量是由 pm.max_children 指令来确定的
    + 大多数情况下，如果服务器内存不足，那么 PM 设置成 ondemand 或 dynamic 将是更好选择
    + 一旦有可用的闲置内存，那么把 PM 设置成 static 最大值将减少许多 PHP 进程管理器（PM）所带来开销，应该在没有内存不足和缓存压力的情况下使用 pm.static 来设置 PHP-FPM 进程的最大数量。此外，也不能影响到 CUP 的使用和其他待处理的 PHP-FPM 操作
    + 当流量波动比较大的时候，，PHP-FPM 的 ondemand 和 dynamic 会因为固有开销而限制吞吐量。 您需要了解您的系统并设置 PHP-FPM 进程数，以匹配服务器的最大容量
    + 从 pm.max_children 开始，根据 pm dynamic 或 ondemand 的最大使用情况去设置
    + 子进程数量是根据以下指令来动态生成的：pm.max_children, pm.start_servers, pm.min_spare_servers, pm.max_spare_servers.
    + dynamic模式，可能会出现mysql连接数被占满的情况，这也跟mysql服务的连接超时时间有关
    + 在 pm static 模式下，因为您将所有内容都保存在内存中，所以随着时间的推移，流量峰值会对 CPU 造成比较小的峰值，并且您的服务器负载和 CPU 平均值将变得更加平滑。 每个需要手动调整的 PHP-FPM 进程数的平均大小会有所不同
  - pm = ondemand：在服务启动时候根据 pm.start_servers 指令生成进程，而非动态生成
* 短连接：应对并发消耗过多的资源开销
* 长连接：不同请求会使用同一个连接句柄
* 状态查看
  - 在server配置中添加
  - 开启缓存
* 问题
  - FPM's security.limit_extension setting is used to limit the extensions of the main script it will be allowed to parse. It prevents malicious code from being executed. The default value is simply .php It can be configured in /etc/php5/fpm/pool.d/www.conf
  - 解决：cgi.fix_pathinfo=1
  - 待测试： fastcgi_param PATH_TRANSLATED $document_root$fastcgi_path_info; 屏蔽掉

![php-fpm工作模式](../../_static/php-fpm-struct.png "[php-fpm工作模式")

```sh
brew install php --without-apache --with-fpm
brew services start php

# 测试php-fpm配置
/usr/local/php/sbin/php-fpm -c /usr/local/php/etc/php.ini -y /usr/local/php/etc/php-fpm.conf -t

# 启动
/usr/local/php/sbin/php-fpm -c /usr/local/php/etc/php.ini -y /usr/local/php/etc/php-fpm.conf
/usr/local/Cellar/php71/7.1.10_21/sbin/php-fpm --daemonize --fpm-config /usr/local/etc/php/7.1/php-fpm.conf --pid /usr/local/var/run/php-fpm.pid
php-fpm -D

# 查看 php-fpm
ps aux | grep -c php-fpm

## linux 进程管理
/etc/init.d/php7.2-fpm start
/usr/local/php/sbin/php-fpm
sudo service php7.0-fpm {start|stop|status|restart|reload|force-reload}
sudo systemctl status php7.3-fpm

kill -INT `cat /usr/local/php/var/run/php-fpm.pid`
kill -USR2 `cat /usr/local/php/var/run/php-fpm.pid` # 平滑重启
pkill php-fpm # 强制关闭
killall php-fpm # 关闭进程

location ~ ^/status$ {
    include fastcgi_params;
    fastcgi_split_path_info ^(.+\.php)(/.+)$; # NOTE: You should have "cgi.fix_pathinfo = 0;" in php.ini
    fastcgi_pass unix:/usr/local/var/run/php-fpm.sock;
    fastcgi_param SCRIPT_FILENAME $fastcgi_script_name;
}

pm.status_path = /status # php-fpm.conf里面打开选项
# 访问 http://域名/status

2018/09/02 23:26:10 [error] 37283#0: *69 FastCGI sent in stderr: "Access to the script '/Users/henry/Workspace/Code/PHP' has been denied (see security.limit_extensions)" while reading response header from upstream, client: 127.0.0.1, server: localhost, request: "GET / HTTP/1.1", upstream: "fastcgi://unix:/usr/local/var/run/php-fpm.sock:", host: "localhost:8080"

#  www.conf
security.limit_extensions = .php .php3 .php4 .php5

ERROR: failed to open error_log (/usr/var/log/php-fpm.log): No such file or directory

vim /usr/local/etc/php-fpm.conf
error_log = /usr/local/var/log/php-fpm.log
pid = /usr/local/var/run/php-fpm.pid
```

### 扩展

* `php-config --extension-dir`
* 安装
  - apt|yum 命令安装
  - [PECL](http://pecl.php.net/):PHP Extension Community Library，管理最底层PHP扩展。用 C 写的
  - [PEAR](http://pear.php.net/)：PHP Extension and Application Repository，管理项目环境扩展。用 PHP 写的
    + 编译好的依赖：/usr/lib/php
  - Composer：和PEAR都管理着项目环境的依赖，这些依赖也是用 PHP 写的，区别不大。但 composer 却比 PEAR 更受欢迎
* 扩展
  - vld:查看代码 opcache
  - intl
  - mcrypt
  - memeached
    + memcache 完全在PHP框架内开发的，提供了memcached的接口，memecached扩展是使用了libmemcached库提供的api与memcached服务端进行交互。 libmemcached 是 memcache 的 C 客户端，它具有低内存，线程安全等优点
      * memcache 提供了面向过程及面向对象的接口，memached只支持面向对象的接口。 memcached 实现了更多的 memcached 协议
    + memcached 支持 Binary Protocol，而 memcache 不支持，意味着 memcached 会有更高的性能。注意目前还不支持长连接
  - mongodb
  - Opcache
    + PHP 5.5.0开始，PHP内置了字节码缓存功能，名为Zend Opcache
    + PHP是解释型语言，构建在Zend 虚拟机之上，PHP解释器在执行PHP脚本时会解析PHP脚本代码，把PHP代码编译成一系列Zend操作码,每个操作码都是一个字节长，所以又叫字节码，字节码可以直接被Zend虚拟机执行），然后执行字节码
    + 通过将 PHP 脚本预编译的字节码存储到共享内存中来提升 PHP 的性能，省去了每次加载和解析 PHP 脚本的开销，对于I/O开销如读写磁盘文件、读写数据库等并无影响
    + 字节码(Byte Code)：一种包含执行程序比机器码更抽象的中间码，由一序列 op代码/数据对组成的二进制文件
    + HHVM(HipHop Virtual Machine，Facebook开源的PHP虚拟机)采用了JIT(Just In Time Just Compiling，即时编译)技术，在运行时编译字节码为机器码，让性能测试提升了一个数量级。 唯有C/C++编译生成的二进制文件可直接运行。
    + 机器码(Machine Code)：也被称为原生码(Native Code)，用二进制代码表示的计算机能直接识别和执行的一种机器指令的集合，它是计算机硬件结构赋予的操作功能
  - apc:op缓存
  - pdo-pgsql
  - phalcon
  - [redis](http://pecl.php.net/package/redis)
    + [predis](https://github.com/nrk/predis/):Flexible and feature-complete Redis client for PHP and HHVM https://github.com/nrk/predis/wiki 纯 php 实现，通过 socket 与 redis 服务器通信，通过 composer 加载依赖，无需额外安装扩展
    + [phpredis/phpredis](https://github.com/phpredis/phpredis): A PHP extension for Redis 基于 c 开发的 PHP 扩展，速度快、内存小.与 predis 功能上两者差不多，性能上略胜一筹，但由于与 redis 通信的主要瓶颈还是在网络 IO 上
  - sphinx
  - [swoole](./Swoole.md)
  - [defuse/php-encryption](https://github.com/defuse/php-encryption):Simple Encryption in PHP.
  - [jedisct1/libsodium](https://github.com/jedisct1/libsodium):A modern, portable, easy to use crypto library https://libsodium.org
  - PHPDoc
  - [PHP_CodeSniffer](https://github.com/squizlabs/PHP_CodeSniffer)：PHP_CodeSniffer tokenizes PHP, JavaScript and CSS files and detects violations of a defined set of coding standards. http://pear.php.net/package/PHP_CodeS…
  - [php-cs-fixer](https://github.com/FriendsOfPHP/PHP-CS-Fixer)：PHP Code Beautifier and Fixer(phpcbf) PHP代码规范与质量检查工具

```sh
# 查看添加扩展
php -m | grep mcrypt
php --ri xhprof
php --ini

sudo pecl channel-update pecl.php.net
sudo pecl update-channels
sudo pecl search|install|uninstall memcached｜mcrypt-snapshot|mcrypt-1.0.1
sudo pecl install mcrypt

sudo vim /etc/php/7.4/cli/php.ini
extension=mcrypt.so

mkdir -p /tmp/pear/cache
sudo apt install php-pear
curl -O https://pear.php.net/go-pear.phar
sudo php -d detect_unicode=0 go-pear.phar
#  1 Installation base /usr/local/pear
#  4 Binaries directory /usr/local/bin

pear config-set php_ini /usr/local/etc/php
pear config-set php_dir /usr/local/share/p
pear config-set doc_dir /usr/local/share/p
pear config-set ext_dir /usr/local/lib/php
pear config-set bin_dir /usr/local/opt/php
pear config-set data_dir /usr/local/share/
pear config-set cfg_dir /usr/local/share/p
pear config-set www_dir /usr/local/share/p
pear config-set man_dir /usr/local/share/m
pear config-set test_dir /usr/local/share/
pear config-set php_bin /usr/local/opt/php
pear update-channels
pear upgrade
pear install PHP_CodeSniffer｜channel://pecl.php.net/vld-0.16.0

brew tap homebrew/homebrew-php
brew install php71 --with-pear
brew install mcrypt|php71-mcrypt

yum install php-mcrypt|php5-mcrypt
apt-cache search memcached
sudo apt-get install php-mcrypt|php5-mcrypt｜php5-memcached php-xml php7.*-xml php-dev php7.*-dev
# Invalid argument supplied for foreach() in Command.php on line 249
sudo apt install php7.4-xml
# Trying to access array offset on value of type bool in PEAR/REST.php on line 187

composer global require "squizlabs/php_codesniffer=*"

# PHP_CodeSniffer
curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar
php phpcs.phar -h
curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar
php phpcbf.phar -h

phpcs --config-show
phpcs --config-set
/Users/henry/.composer/vendor/bin/phpcs # phpstrom 开启
# vscode
phpcs.enable true

phpcs /path/to/code/myfile.php
phpcs /path/to/code

# php-cs-fixer
wget http://cs.sensiolabs.org/download/php-cs-fixer-v2.phar -O php-cs-fixer
wget https://github.com/FriendsOfPHP/PHP-CS-Fixer/releases/download/v2.10.0/php-cs-fixer.phar -O php-cs-fixer
curl -L http://cs.sensiolabs.org/download/php-cs-fixer-v2.phar -o php-cs-fixer

sudo chmod a+x php-cs-fixer
sudo mv php-cs-fixer /usr/local/bin/php-cs-fixer

composer global require friendsofphp/php-cs-fixer
export PATH="$PATH:$HOME/.composer/vendor/bin"
brew install homebrew/php/php-cs-fixer

sudo php-cs-fixer self-update
brew upgrade php-cs-fixer

php php-cs-fixer.phar fix /path/to/dir
php php-cs-fixer.phar fix /path/to/file

composer global require phpmd/phpmd

ln -s /etc/php5/mods-available/redis.ini /etc/php5/cli/conf.d/10-redis.ini
ln -s /etc/php5/mods-available/redis.ini /etc/php5/apache2/conf.d/10-redis.ini

# 编译扩展安装
phpize -v # 需要安装php7.*-dev
cd extname
phpize
./configure
make
make install
# 配置文件添加扩展
extension="swoole.so"

php -dvld.active=1 -dvld.excute=0 at.php # excute =0 opcode在么 并不执行
```

## php.ini 配置

* `short_open_tag` 设为0，即永远使用PHP的长标签形式：`<?php echo "hello world"; ?>`，不用短标签形式<`?= "hello world" ?>`
* `asp_tags` 设为0，不使用ASP标签`<% echo "hello world"; %>`
* `magic_quotes_gpc`: 建议在脚本中包含一个全局文件，负责在读取`$_GET、$_POST、$_COOKIE`变量之前，首先检查这个设置是否打开，如果打开了，这对这些变量应用stripslashes函数
* `register_globals`: 不要依赖这个设置，永远通过全局变量`$_GET、$_POST、$_COOKIE`去读取GET、POST和COOKIE的值。为了方便起见，建议声明`$PHP_SELF = $_SERVER['PHP_SELF']`
* `file_uploads`:上传文件的最大大小，由下面的设置决定
  - `file_uploads`必须设为1（默认值），表示允许上传
  - `memory_limit`必须略大于`post_max_size`和`upload_max_filesize`
  - `post_max_size`和`upload_max_filesize`要足够大，能满足上传的需要
* memory_limit:设定单个 PHP 进程可以使用的系统内存最大值
  - PHP 操作 Redis Set 集合。修改配置
  - 如果项目中每页页面使用的内存不大，建议改成小一些，这样可以承载更多的并发处理
  - 命令行命令 top 或者 PHP 脚本中调用 memory_get_peak_usage() 函数多次运行同一个脚本，然后取内存消耗的平均
* Zend OPcache 扩展
  - PHP解释器在执行PHP脚本时会解析PHP脚本代码，把PHP代码编译成一系列[Zend操作码](http://php.net/manual/zh/internals2.opcodes.php)，由于每个操作码都是一个字节长，所以又叫字节码，字节码可以直接被Zend虚拟机执行
  - 每次请求PHP文件都是这样，这会消耗很多资源，如果每次HTTP请求都必须不断解析、编译和执行PHP脚本，消耗的资源更多
  - 如果PHP源码不变，相应的字节码也不会变化，显然没有必要每次都重新生成Opcode，结合在Web应用中无处不在的缓存机制，可以把首次生成的Opcode缓存起来,直接从内存中读取预先编译好的字节码
  - 在配置中开启扩展
* max_execution_time 设置单个 PHP 进程在终止之前最长可运行时间
* Session 会话
  - 放在 Redis 或者 Memcached 中，可以减少磁盘的 IO 操作频率，还可以方便业务服务器伸缩
* error_reporting
* cgi.fix_pathinfo:值由1改为0
  - nginx通过 fastcgi_param 指令将参数传递给 FastCGI Server
  - 访问URL：http://phpvim.net/foo.jpg/a.php/b.php/c.php
  - 传递给 FastCGI 的 SCRIPT_FILENAME：foo.jpg/a.php/b.php/c.php
  - cgi.fix_pathinfo = 1 时，PHP CGI 以 / 为分隔符号从后向前依次检查根目录下如下路径，直到找个某个存在的文件，如果这个文件是个非法的文件
    + foo.jpg/a.php/b.php
    + foo.jpg/a.php
    + foo.jpg
  - PHP 会把这个文件当成 cgi 脚本执行，并赋值路径给 CGI 环境变量——SCRIPT_FILENAME，也就是 `$_SERVER['SCRIPT_FILENAME']` 的值了。
    + PHP的cgi SAPI中的参数fix_pathinfo

```sh
# 查看
php-config
php-config --extension-dir # PHP扩展目录

# session 存储道memcache
session.save_handler = 'memcached'
session.save_path = '127.0.0.1:11211'

expose_php = Off # X-Powered-By的配置

php -r "echo ini_get('memory_limit').PHP_EOL;" # 获取php内存大小
```

## 基础

* 代码标记：`<?php …… ?>`
* 文件扩展名 `.php`
* 每行代码必须以英文分号`;`结束
* 区分大小写，但函数名和关键字不区分大小写
* 文件名及路径中不能包括中文或空格
* 单行注释：`//、#`
* 多行注释：`/* …… */`

### 变量：临时存储数据的容器，指向值的指针

* 变量复制用的是写时复制方式
  - 基础类型是值赋值
  - 复杂类型是引用赋值
* 引用计数,给变量引用的次数进行计算,当计数不等于0时,说明这个变量已经被引用,不能直接被回收,否则可以直接回收.xdebug_debug_zval
  - 当变量值为整型,浮点型时,在赋值变量时,php7底层将会直接把值存储(php7的结构体将会直接存储简单数据类型),refcount将为0
  - 当变量值为interned string字符串型(变量名,函数名,静态字符串,类名等)时,变量值存储在静态区,内存回收被系统全局接管,引用计数将一直为1
  - 当变量值为以上几种时,复制变量将会直接拷贝变量值,所以将不存在多次引用的情况
  - $b = &$a; 当引用时,被引用变量的value以及类型将会更改为引用类型,并将引用值指向原来的值内存地址中.之后引用变量的类型也会更改为引用类型,并将值指向原来的值内存地址,这个时候,值内存地址被引用了2次,所以refcount=2.
* 作用域
  - 包含了 include 和 require 引入的文件
  - 局部变量 local：函数内部声明的变量，仅在函数内部访问
  - 全局作用域 global：在所有函数外部定义的变量
    - 除了函数外，全局变量可以被脚本中的任何部分访问
    - 要在一个函数中访问一个全局变量，需要使用 global 关键字
    - 所有全局变量存储在一个名为 $GLOBALS[index] 的数组中。index 保存变量的名称,可以在函数内部访问，也可以直接用来更新全局变量
  - 静态变量（static variable）：仅在局部函数域中存在，当程序执行离开此作用域时，其值并不丢失
  - parameter：通过调用代码将值传递给函数的局部变量
* 本身没有类型(变量中存储的数据的类型)
* 命名
  - 可以包含：字母、数字、下划线，可以用中文。
  - 不能以数字和特殊符号开头，但可以以字母或下划线开头。如：$_ABC、$abc
* 变量名称前必须要带`$`符号。`$`不是变量名称一部分，只是对变量名称的一个引用或标识符
* 命名规则
  - “驼峰式”命名：$getUserName、$getUserPwd
  - “下划线”命名：$get_user_name、$set_user_pwd
* 赋值
  * 传值:$variablename指向value存储的地址 `$foo = 'Bob';`
  * 引用:新的变量简单的引用了原始变量,只有有名字的变量才可以引用赋值 `$bar = &$foo`
  * 对象赋值，浅拷贝,取了另一个名字而已，指向的内存空间还是一样 还是两份数据？
  * `$a = $b $b =56` $a 的值不变
  * clone函数在克隆对象时候，普通属性是深拷贝，原对象的对象属性还是引用赋值，浅拷贝
  * 魔术方法__clone实现真正深拷贝
* 可变变量：`$$var`是一个引用变量，用于存储$var的值
* PHP 之外变量
  - `$_GET $_POST $_REQUEST`
  - `$_SERVER`
  - `$_COOKIE`

### 常量

* 定义
  - 常量前面没有`$`
  - 只能用 `define()` 函数定义，而不能通过赋值语句
  - 可以不用理会变量的作用域而在任何地方定义和访问
  - 一旦定义就不能被重新定义或者取消定义
  - 常量的值只能是标量, PHP 7 中还允许是 array
* `define(name, value, case-insensitive = false)`: 区分大小写,成功时返回 TRUE， 或者在失败时返回 FALSE
* defined():检查某个名称的常量是否存在
* const关键字在编译时定义常量
  - 是一个语言构造不是一个函数
  - 比define()快一点，因为没有返回值
  - 区分大小写
* 魔术常量
  - `__LINE__` 表示当前行号
  - `__FILE__` 表示文件完整路径和文件名。如果在include中使用，则返回包含文件的名称
  - `__DIR__`表示文件完整目录路径。等同于dirname(__file__)。除非它是根目录，否则它没有尾部斜杠。还解析符号链接
  - `__FUNCTION__` 表示使用它的函数名称。如果它在任何函数之外使用，则它将返回空白
  - `__CLASS__` 表示使用它的函数名称。如果它在任何函数之外使用，则它将返回空白
  - `__TRAIT__` 表示使用它的特征名称。如果它在任何函数之外使用，则它将返回空白。 它包括它被声明的命名空间
  - `__METHOD__`  表示使用它的类方法的名称。方法名称在有声明时返回
  - `__NAMESPACE__` 表示当前命名空间名称
* 内存泄漏

### 数据类型

* 标量
  + Boolean 布尔型
    + 布尔值 FALSE 本身
    + 整型值 0（零）
    + 浮点型值 0.0（零）
    + 空字符串，以及字符串 "0"
    + 不包括任何元素的数组
    + 从空标记生成的 SimpleXML 对象
  + String 字符串
    * 单引号PHP字符串中，大多数转义序列和变量不会被解释。 可以使用单引号`\'`反斜杠和通过`\\`在单引号引用PHP字符串
    * 双引号的PHP字符串中存储多行文本，特殊字符和转义序列,对一些特殊的字符进行解析
      * `\n`  换行（ASCII 字符集中的 LF 或 0x0A (10)）
      * `\r`  回车（ASCII 字符集中的 CR 或 0x0D (13)）
      * `\t`  水平制表符（ASCII 字符集中的 HT 或 0x09 (9)）
      * `\v`  垂直制表符（ASCII 字符集中的 VT 或 0x0B (11)）（自 PHP 5.2.5 起）
      * `\e`  Escape（ASCII 字符集中的 ESC 或 0x1B (27)）（自 PHP 5.4.0 起）
      * `\f`  换页（ASCII 字符集中的 FF 或 0x0C (12)）（自 PHP 5.2.5 起）
      * `\`  反斜线
      * `\$`  美元标记
      * `\"`  双引号
    + heredoc 结构就象是没有使用双引号的双引号字符串，单引号不用被转义，但是上文中列出的转义序列还可以使用
    + Nowdoc 结构是类似于单引号字符串的。Nowdoc 结构很象 heredoc 结构，但是 nowdoc 中不进行解析操作
      * 这种结构很适合用于嵌入 PHP 代码或其它大段文本而无需对其中的特殊字符进行转义
    + 方法
      - `addslashes` 转义风险：对于URL参数arg = %df\'在经过addslashes转义后在GBK编码下arg = 運'
      - `urldecode` 解码风险：对于URL参数uid = 1%2527在调用urldecode函数解码(二次解码)后将变成uid = 1'
      - `ord ( string $string ) : int`:转换字符串第一个字节为 0-255 之间的值
    * printf
      - %b binary representation
      - %c print the ascii character, same as chr() function
      - %d standard integer representation
      - %e scientific notation
      - %u unsigned integer representation of a positive integer
      - %u unsigned integer representation of a negative integer
      - %f floating point representation
      - %o octal representation
      - %s string representation
      - %x hexadecimal representation (lower-case)
      - %X hexadecimal representation (upper-case)
      - %+d  sign specifier on a positive or negative integer
    * 多字节:多字节字符指的是不在传统的 128 个 ASCII 字符集中的字符，比如中文字符,使用这些 PHP 原生的字符串处理函数处理包含多字节字符的 Unicode 字符串，会得到意料之外的错误结果
      - 安装 mbstring 扩展
  + Integer（整型）
  + Float（浮点型）
    * NaN:代表着任何不同值，不应拿 NAN 去和其它值进行比较，包括其自身，应该用 is_nan() 来检查
- NULL（空值）
  + 尚未被赋值
  + 被赋值为 NULL
  + 被 unset()
    * 删除引用，触发相应变量容器refcount减一 引用计数器
    * 在函数中的行为会依赖于想要销毁的变量的类型而有所不同
      - 比如unset 一个全局变量，则只是局部变量被销毁，而在调用环境中的变量(包括函数参数引用传递的变量)将保持调用 unset 之前一样的值
    * unset 变量与给变量赋值NULL不同，变量赋值NULL直接对相应变量容器refcount = 0

### 复合

* Array（数组）:一个有序映射
  - 映射是一种把 values 关联到 keys 的类型。因此可以当成真正的数组，或列表（向量），散列表（是映射的一种实现），字典，集合，栈，队列以及更多可能性
  + key 会有如下的强制转换
    + 合法整型值的字符串会被转换为整型。例如键名 "8" 实际会被储存为 8。但是 "08" 则不会强制转换，因为其不是一个合法的十进制数值
    + 浮点数也会被转换为整型，意味着其小数部分会被舍去。例如键名 8.7 实际会被储存为 8
    + 布尔值也会被转换成整型。即键名 true 实际会被储存为 1 而键名 false 会被储存为 0
    + Null 会被转换为空字符串，即键名 null 实际会被储存为 ""
    + 数组和对象不能被用为键名。坚持这么做会导致警告：Illegal offset type
  - 类型
    * 索引数组
    * 关联数组
    * 多维数组
  + 方法
    * `+`:运算符把右边的数组元素附加到左边的数组后面，两个数组中都有的键名，则只用左边数组中的，右边的被忽略。
    * `in_array()`
    * `array_filter()` 过滤数组中的所有值为空的元素
    * `array_reduce($source, function(){}, $distination)`
    * `array_walk_recursive()`
    * `array_map()`:处理后的数组, 要得到处理后的元素值,需要return返回
    * `array_walk()`:返回true或者false,要得到处理后的元素值，需要在传入参数值加 & 引用符号
    * `array_column($array, cloumnName[, indexCloumn])`
  + 遍历
    * each — 返回数组中当前的键／值对并将数组指针向前移动一步
* Object（对象）
* callback:接受用户自定义的回调函数作为参数。回调函数不止可以是简单函数，还可以是对象的方法，包括静态类方法。
* Resource 资源
* 类型转换
  - 乘法运算符"*"。如果任何一个操作数是float，则所有的操作数都被当成float，结果也是float。否则操作数会被解释为integer，结果也是integer
    + 并没有改变这些操作数本身的类型；改变的仅是这些操作数如何被求值以及表达式本身的类型
* 类型判断
  - `gettype()`
  - `empty()`
  - `isset()`
  - `is_null()`
  - `boolean()`
  - `is_numeric()`

### 控制语句

* 表达式：任何有值东西
* echo：一个语言结构(语句）不是一个函数，所以不需要使用括号。要使用多个参数，则需要使用括号。打印字符串，多行字符串，转义字符，变量，数组等
* print
* print_r
* printf()
* 条件
  - if
  - if-else
  - elseif/else if
  - 嵌套if
  - switch
* 循环
  - for
  - foreach
  - while
  - do...while
* break:中断当前循环执行
  - 内循环中使用break，只中断了内循环的执行
  - 接受一个可选数字参数来决定跳出几重循环
* continue：在条件求值为真时，跳过本次循环中剩余代码并开始执行下一次循环
  - 接受一个可选数字参数来决定跳过几重循环到循环结尾
* include 加载优先级
  - 先按参数给出路径寻找
  - 如果没有给出目录（只有文件名）时则按照 include_path 指定目录寻找
  - 未找到调用脚本文件所在目录和当前工作目录下寻找
  - 仍未找到文件则 include 结构会发出一条警告
  - include_once 语句在脚本执行期间包含并运行指定文件。此行为和 include 语句类似，唯一区别是如果该文件中已经被包含过，则不会再次包含
* require 出错时产生 E_COMPILE_ERROR 级别的错误,include 没有找到对应路径脚本时发出警告（E_WARNING）
  - require_once 语句和 require 语句完全相同，唯一区别是 PHP 会检查该文件是否已经被包含过，如果是则不会再次包含
  - `include_once/require_once` 性能更好一些,至于使用 include_once 还是 require_once，取决于对指定路径 PHP 脚本不存在的预期处理
* goto 跳转到程序中另一位置
  - 声明目标标记：目标名称加上冒号
  - 跳转：goto 之后接上目标位置标记
* 替代语法
* 嵌套使用

### 运算符

* 算术运算符 `* / % + - **`
* 赋值运算符 `= += -= *= **= /= .= %= &= ^= <<= >>= =>`
* 位运算符 `&(位与) ^（异或） | ~ << >>`
  - &  转换为布尔 5&1 为1
  - |：合并集合 1101 | 1011 为 1111
* 比较运算符:`< <= > >= == != === !== <>`
  - $a <=> $b 太空船运算符 当$a小于、等于、大于$b时 分别返回一个小于、等于、大于0的integer 值
  - $a ?? $b ?? $c:NULL 合并操作符  从左往右第一个存在且不为 NULL 的操作数。如果都没有定义且不为 NULL，则返回 NULL
* 逻辑运算符:`&& and ||or xor  !`,有优先级
* 字符串运算符
  - 连接运算符（"."） 返回其左右参数连接后的字符串
  - 连接赋值运算符（".="） 将右边参数附加到左边的参数之后
* 递增/递减运算符
  - ++$a 前加  $a 值加一，然后返回 $a
  - $a++ 后加  返回 $a，然后将 $a 值加一
  - --$a 前减  $a 值减一， 然后返回 $a
  - $a-- 后减  返回 $a，然后将 $a 值减一
* 数组运算符
  - $a + $b 保留前面相同key
  - $a == $b $a 和 $b 具有相同键／值对 为 TRUE
  - $a <> $b 不等  如果 $a 不等于 $b 则为 TRUE
  - $a != $b 不等  如果 $a 不等于 $b 则为 TRUE
  - $a === $b $a 和 $b 具有相同的键／值对并且顺序和类型都相同 为 TRUE
  - $a !== $b 不全等 如果 $a 不全等于 $b 则为 TRUE
* 类型运算符:`instanceof (int) (float) (string) (array) (object) (bool)`
* 执行操作符 反引号（``）
  - 尝试将反引号中内容作为 shell 命令来执行，并将其输出信息返回
  - 激活了安全模式或者关闭了 shell_exec() 时无效
* 错误控制操作符 @ 当将其放置在一个 PHP 表达式之前，该表达式可能产生的任何错误信息都被忽略掉
* 三元运算符 `$first ? $second : $third`

## 函数 function

* 一段可以重复使用代码
* 参数
  - 值传递:传递给函数的值默认情况下不会修改实际值(通过值调用),传递给函数的值是通过值调用。作用域函数范围内
  - 引用调用:要传递值作为参考(引用)，需要在参数名称前使用＆符号(&)
  - 允许使用数组 array 、object、特殊类型 NULL 作为默认参数
  - 可以设置默认参数
  - 可变长度参数
  - 可变数量参数列表 `...`
* 可变函数：一个变量名后有圆括号，PHP 将寻找与变量的值同名的函数，并且尝试执行它。可变函数可以用来实现包括回调函数
* 返回值
* 递归函数
* 匿名函数 Anonymous functions ｜
  - 5.3.0中引入，和普通PHP函数很像：常用句法相同，也接受参数，而且能返回值。不过闭包没有函数名
  - 允许临时创建一个没有指定名称函数
  - 变量值是一个闭包对象
* 闭包 Closure
  - 实现了`__invoke()`魔术方法，变量名后有()，就会查找并调用__invoke方法
  - 在匿名函数的基础上增加了与外部环境的变量交互，不能直接访问闭包外的变量，通过 use 关键字把父作用域变量及状态附加到PHP闭包中
  - 在闭包中使用$this关键字获取闭包内部状态
  + bindTo:可以把闭包内部状态绑定到其他对象上
    * 第二个参数作用是指定绑定闭包的那个对象所属的PHP类.闭包就可以在其他地方访问邦定闭包的对象中受保护和私有的成员变量
    * 框架经常使用bindTo方法把路由URL映射到匿名回调函数上，框架会把匿名回调函数绑定到应用对象上，这样在匿名函数中就可以使用$this关键字引用重要的应用对象
  - 场景
    + 作回调函数（callback）
  - 闭包内所引用的变量不能被外部所访问
  - Lambda表达式(匿名函数)实现了一次执行且无污染的函数定义，是抛弃型函数并且不维护任何类型的状态

## 状态管理

* cookie 一个小段信息，存储在客户端浏览器中,用于识别用户
  - PHP 自动维护 cookie 机制：在服务器端创建 并发送给客户端，后面客户端向服务器发送请求时，cookie都会嵌入请求，服务器端能够识别
  - 设置
  - 获取
  - 删除
* 服务器端存储技术 session:用于临时存储 直到用户关闭网站
  - 从一个页面传递到另一个页面：广泛应用于购物网站(需要存储和传递购物车信息、用户名，产品代码，产品名称，产品价格等信息）
  - 会话为每个浏览器创建唯一的用户ID，以识别用户，并避免多个浏览器之间冲突
  - session_start() 启动会话，启动一个新的或恢复现有会话
    + 如果已创建会话，则返回现有会话
    + 如果会话不可用，创建并返回新会话
  - $_SESSION 一个包含所有会话变量的关联数组，用于设置和获取会话变量值
  - session_destroy()

```php
setcookie("CookieName", "CookieValue");/* defining name and value only*/
setcookie("CookieName", "CookieValue", time()+1*60*60);//using expiry in 1 hour(1*60*60 seconds or 3600 seconds)
setcookie("CookieName", "CookieValue", time()+1*60*60, "/mypath/", "yiibai.com", 1);

$value=$_COOKIE["CookieName"];//returns cookie value
```

## IO

* 本质上是 “流(stream)” ，通过流操作文件、命令行进程、网络连接、ZIP 或 TAR 压缩文件、临时内存、标准输入或输出，或者是通过 PHP 流封装协议实现的任何其他资源
* 流的作用是提供统一的公共函数来处理文件、网络和数据压缩等操作。简单而言，流是具有流式行为的资源对象，流可以线性读写，并且可以通过 fseek() 之类的函数定位到流中的任何位置
* 命令行输入和输出:`php_sapi_name`返回值为cli，标准输入输出均指向终端
  - STDIN: 标准输入，只读，等同于用fopen打开”php://stdin”;
  - STDOUT: 标准输出，只写，等同于用fopen打开”php://stdout”;
  - STDERR: 标准错误输出，只写，等同于fopen打开”php://stderr”
  - php://memory：从系统内存中读取数据，或者把数据写入系统内存。缺点是系统内存有限，所有使用 php://temp 更安全
  - php://temp：和 php://memory 类似，不过，没有可用内存时，PHP 会把数据写入这个临时文件。
* 流封装协议
  - 开始通信
  - 读取数据
  - 写入数据
  - 结束通信
* 流真正强大的地方在于过滤、转换、添加或删除流中传输的数据
  - `stream_filter_append()` 过滤器附加到现有的流上
  - 使用 php://filter 流封装协议把过滤器附加到流上
* 与远程网址交互:curl

### php://input

* Coentent-Type仅在取值为application/x-www-data-urlencoded和multipart/form-data两种情况下，PHP才会将http请求数据包中相应的数据填入全局变量$_POST
* PHP不能识别的Content-Type类型的时候，会将http请求包中相应的数据填入变量$HTTP_RAW_POST_DATA
* Coentent-Type为multipart/form-data的时候，PHP不会将http请求数据包中的相应数据填入php://input
* “php://input可以读取没有处理过的POST数据
* php://input读取不到`$_GET`数据。因为`$_GET`数据作为query_path写在http请求头部(header)的PATH字段，而不是写在http请求的body部分
* 只有Content-Type为application/x-www-data-urlencoded时，php://input数据才跟$_POST数据相一致
* 相较于$HTTP_RAW_POST_DATA而言，它给内存带来的压力较小，并且不需要特殊的php.ini设置

### 文件

* 创建
* 访问
  - 相对文件 `foo.txt => currentdirectory/foo.txt`
  - 相对路径 `subdirectory/foo.txt=> currentdirectory/subdirectory/foo.txt`
  - 绝对路径 `/main/foo.txt=> /main/foo.txt`
* 打开 `resource fopen ( string $filename , string $mode [, bool $use_include_path = false [, resource $context ]] )`
  - filename 是 "scheme://..." 的格式，则被当成一个 URL，PHP 将搜索协议处理器（也被称为封装协议）来处理此模式
  - 如果该协议尚未注册封装协议，PHP 将发出一条消息来帮助检查脚本中潜在的问题并将 filename 当成一个普通的文件名继续执行下去
  - 指定的是一个本地文件，将尝试在该文件上打开一个流。该文件必须是 PHP 可以访问的，因此需要确认文件访问权限允许该访问
  - 相对路径无法打开
  - 接受两个参数
    + $filename表示要被打开的文件
    + $mode表示文件模式
  - r 以只读模式打开文件。 将文件指针放在文件的开头。
  - r+  以读写模式打开文件。 将文件指针放在文件的开头。
  - w   以只写模式打开文件。 将文件指针放在文件的开头，并将文件截断为零长度。 如果找不到文件，则会自动创建一个新文件。
  - w+  以读写模式打开文件。 将文件指针放在文件的开头，并将文件截断为零长度。 如果找不到文件，则会自动创建一个新文件。
  - a   以只写模式打开文件。 将文件指针放在文件的末尾。 如果找不到文件，则会创建一个新文件。
  - a+  以读写模式打开文件。 将文件指针放在文件的末尾。 如果找不到文件，则会创建一个新文件。
  - x   以只写模式创建和打开文件。 将文件指针放在文件的开头。 如果找到文件，fopen()函数返回FALSE。
  - x+  与x相同，但以读写模式创建和打开文件。
  - c   以只写模式打开文件。 如果文件不存在，则会创建。 如果存在，不会被截断(与’w‘相反)，也不会调用此函数失败(如’x‘的情况)。 文件指针位于文件的开头
  - c+  与c相同，但它以读写模式打开文件。
* flock：获取文件锁，可用其实现进程互斥锁
  - LOCK_SH 要取得共享锁定（读取的程序）
  - LOCK_EX 要取得独占锁定（写入的程序）
  - LOCK_UN 要释放锁定（无论共享或独占）
  - LOCK_NB 如果不希望 flock () 在锁定时堵塞
  - 注意
    + 设置一个超时时间
  - 不使用 flock 函数，借用临时文件来解决读写冲突的问题，需要更新的文件考虑一份到我们的临时文件目录，将文件最后修改时间保存到一个变量，并为这个临时文件取一个随机的，不容易重复的文件名。当对这个临时文件进行更新后，再检测原文件的最后更新时间和先前所保存的时间是否一致。如果最后一次修改时间一致，就将所修改的临时文件重命名到原文件，为了确保文件状态同步更新，所以需要清除一下文件状态。
* 读取：`string fread (resource $handle , int $length )`函数用于读取文件的数据
  - 参数：文件资源($handle 由fopen()函数创建的文件指针)和文件大小($length 要读取的字节长度)
  - 逐行读取文件：`string fgets ( resource $handle [, int $length ] )`函数用于从文件中读取单行数据内容
  - 逐个字符读取文件：`string fgetc ( resource $handle )`函数用于从文件中读取单个字符
    + 要使用fgetc()函数获取所有数据，请在while循环中使用!feof()函数作为条件。
  - `file_get_contents`
* 写入：`int fwrite ( resource $handle , string $string [, int $length ] )`：用于将字符串的内容写入文件
  - 如果再次运行上面的代码，将擦除文件的前一个数据并写入新的数据。
  - 附加文件
  - fputs
* 删除 `bool unlink ( string $filename [, resource $context ] )`
* 关闭 `fclose($fd)`
* 上传 `bool move_uploaded_file ( string $filename , string $destination )`
  - `$_FILES['filename']['name']`   返回文件名称
  - `$_FILES['filename']['type']` 返回文件的MIME类型
  - `$_FILES['filename']['size']` 返回文件的大小(以字节为单位)
  - `$_FILES['filename']['tmp_name']` 返回存储在服务器上的文件的临时文件名。
  - `$_FILES['filename']['error']`    返回与此文件相关联的错误代码。
* 下载 `int readfile ( string $filename [, bool $use_include_path = false [, resource $context ]] )`
  - $filename：表示文件名
  - $use_include_path：它是可选参数。它默认为false。可以将其设置为true以搜索included_path中的文件
  - $context：表示上下文流资源
  - int：它返回从文件读取的字节数
* 方法
  - basename:返回路径中的文件名部分

### redirect

* `header ( string $header [, bool $replace = TRUE [, int $http_response_code ]] ) : void`
* `using ob_start() and ob_end_flush()`
* 通过 javascript

### MySQL

* mysql:PHP 5.5以后扩展已被弃用，建议使用以下替代
* mysqli
* PDO
  - fetch() 参数决定如何返回查询结果
    + PDO::FETCH_ASSOC：返回关联数组，数组的键是数据表的列名
    + PDO::FETCH_NUM：返回键为数字的数组
    + PDO::FETCH_BOTH：顾名思义，返回一个既有键为列名又有键为数字的数组
    + PDO::FETCH_OBJ：返回一个对象，对象的属性是数据表的列名
  - 预处理语句查询
    + 位置参数`$tis = $conn->prepare("INSERT INTO STUDENTS(name, age) values(?, ?)"); $tis->bindParam(1,$name); $tis->bindParam(2,$age);`
    + 命名参数 `$tis = $conn->prepare("INSERT INTO STUDENTS(name, age) values(:name, :age)"); $tis->bindParam(':name', $name); $tis->bindParam(':age', $age);`
  - 错误异常处理、灵活取得查询结果（返回数组、字符串、对象、回调函数）、字符过滤防止 SQL 攻击、事务处理、存储过程
    - errorCode errotInfo

## 面向对象 OOP

* 类
  - spl_autoload：__autoload()函数的默认实现
  - spl_autoload_register:注册给定的函数作为 __autoload（7.2之后废弃） 的实现，替代spl_autoload（）
  - 构造函数：创建新对象时先调用此方法，适合在使用对象之前做一些初始化工作
    + 子类中定义了构造函数则不会隐式调用其父类的构造函数
    + 要执行父类的构造函数，需要在子类的构造函数中调用 parent::__construct()
    + 如果子类没有定义构造函数则会如同一个普通的类方法一样从父类继
  - 析构函数
  - final
    + 父类中的方法被声明为 final，则子类无法覆盖该方法
    + 如果一个类被声明为 final，则不能被继承
* 对象
  - 对象是一堆属性组成
    + 在底层的实现,采取属性数组+方法数组来实现的。对象在zend中的定义是使用了一种zend_object_value结构体来存储的，这个结构体包含：
      * 一个指针L说明这个对象由哪个类实现出来的
      * 对象的属性
      * guards:阻止递归调用
    + 对象的方法不会存在对象里面，要使用对象的方法，实际上是通过指针找到这个类，再用这个类里面的方法来执行的。（通过类序列化检测）
  - static
    + 修饰函数或变量使其成为类函数和类变量
    + 修饰函数内变量延长生命周期至整个应用程序
    + 延迟绑定：子类重写父类方法，其它调用该方法时用static而非self
      * static:: 不再被解析为定义当前方法所在的类，而是在实际运行时计算的。也可以称之为"静态绑定"，因为它可以用于（但不限于）静态方法的调用
      * 当进行静态方法调用时，该类名即为明确指定的那个（通常在 :: 运算符左侧部分）
      * 当进行非静态方法调用时，即为该对象所属的类
    + self 只引用声明，static 执行当前对象.static 指的调用上下文，self 解析上下文
    + 静态方法可以在非静态上下文调用
  - 对象复制：对对象的所有属性执行一个浅复制（shallow copy）。所有的引用属性仍然会是一个指向原来的变量的引用
    + 赋值与传递通过引用进行
    + 获取副本用clone，只复制引用，不复制引用的对象
    + `__clone()` 在复制得到的对象上运行
  - 传递:默认情况下通过引用传递
    + 对象作为参数传递、作为结果返回或者赋值给另外一个变量
    + 另外一个变量跟原来的不是引用的关系，只是他们都保存着同一个标识符的拷贝，这个标识符指向同一个对象的真正内容
  - 场景
    * PHP异步调用
    * 正则匹配src标签
    * 处理回文字符
* 访问控制(可见性)
  - public:类成员在任何地方可见
  - protected:类成员在自身、子类和父类内可见
  - private:类成员只对自己可见。
  - private和protected有个特例:同一个类的对象即使不是同一个实例也可以互相访问对方的私有与受保护成员
* 范围解析符(::)：通常以self::、 parent::、 static:: 和 `<classname>::`形式来访问静态成员、类常量
  - static::、self:: 和 parent:: 可用来调用类中的非静态方法。类中实例或自己
  - self
    + 替代类名，引用当前类的静态成员变量和静态函数；
    + 抑制多态行为，引用当前类的函数而非子类中覆盖的实现；
  - self VS static
    + 在函数引用上
      * 对于静态成员函数，self指向代码当前类，static指向调用类
      * 对于非静态成员函数，self抑制多态，指向当前类的成员函数，static等同于this，动态指向调用类的函数
  - parent
  - this
    + this不能用在静态成员函数中，self可以；
    + 对静态成员函数/变量的访问，建议 用self，不要用$this::或$this->的形式；
    + 对非静态成员变量的访问，不能用self，只能用this;
    + this要在对象已经实例化的情况下使用，self没有此限制；
    + 在非静态成员函数内使用，self抑制多态行为，引用当前类的函数；而this引用调用类的重写(override)函数（如果有的话）
  - static:调用类里面的静态属性与静态方法
* 多态 相同操作或函数、过程可作用于多种类型对象上并获得不同的结果
  - 一个对外接口，多个内部实现方法
  - 允许每个对象以适合自身的方式去响应共同的消息
  - 增强了软件的灵活性和重用性
  - 面向对象编程并不只是将相关的方法与数据简单的结合起来，而是采用面向对象编程中的各种要素将现实生活中的各种情况清晰的描述出来
  - 主要在于可以将不同的子类对象都当作一个父类来处理，并且可以屏蔽不同子类对象之间所存在的差异，写出通用的代码，做出通用的编程，以适应需求的不断变化
  - 通常为了使项目能够在以后的时间里的轻松实现扩展与升级，需要通过继承实现可复用模块进行轻松升级
  - 在进行可复用模块设计时，就需要尽可能的减少使用流程控制语句。此时就可以采用多态实现该类设计
* 抽象类
  - abstract 的方法，继承类不必非要写那个方法
  - 抽象类定义要使用abstract关键字来声明，凡是用abstract关键字定义了抽象方法的类必须声明为抽象类
  - 子类实现抽象方法时访问控制必须和父类中一样（或者更为宽松），同时调用方式必须匹配，即类型和所需参数数量必须一致
  - 抽象类可用于对多个同构类的通用部分定义，用extends关键字继承(父子间存在"is a"关系)，属单继承。接口可用于多个异构类的通用部分定义，用implements关键字继承(父子间存在"like a"关系)，可多继承。如果子类不能实现父类或接口的全部抽象方法，则该子类只能被声明成抽象类
* 接口
  - 通过interface关键字来定义，定义所有的方法都是空的，访问控制必须是public
  - 可以如类一样定义常量，可以使用extends来继承其他接口
  - 每个方法，继承类里面都要去实现
  - 方法后面不要跟大口号{},因为接口只是定义函数，并不实现
  - 两个PHP对象之间契约（Contract）:将代码和依赖解耦，而且允许依赖任何实现了预期接口的第三方代码，不管第三方代码是如何实现接口的，只关心第三方代码是否实现了指定的接口
  - 不能实例化，抽象类中 abstract 的方法，强制要求子类定义这些方法，也可以理解成接口中的每个方法都是 abstract 方法
  - 接口比抽象更严格
* 重写vs重载
  - 重载 名字相同但参数不同函数在同一作用域并存的现象，多见于强类型语言，编译后函数在函数符号表的名称一般是函数名加参数类型
    + 参数个数不同
    + 参数类型不同
    + 参数顺序不同
    + php不支持：function_exists、 method_exists、is_callable、get_defined_functions、ReflectionMethod/ReflectionFunction类的getParameters/getNumberOfParameters/getNumberOfRequiredParameters
  - 重写出现在继承中，指子类重定义父类功能的现象，也被称为覆盖,即相同签名的成员函数在子类中重新定义（实现抽象函数或接口不是重写），是实现多态（polymorphism）的一种关键技术
* 继承：类分层、接口分层
* 实现：类实现接口
* 依赖：类作为另一个类方法的参数
* 关联：类属性
* 聚合：可以有
* 组合：必须有

### trait

* PHP 5.4 引入，突破语言单继承限制，在不同层次结构内独立类中复用 method
* 看做类部分实现，可以混入一个或多个现有PHP类中，作用：表明类可以做什么；提供模块化实现
* 和 Class 相似，但仅旨在用细粒度和一致的方式来组合功能
* 让两个无关PHP类具有类似行为:为传统继承增加了水平特性的组合；应用的Class 之间不需要继承
* 无法通过 trait 自身来实例化
* 优先级:当前类的成员 > trait 的方法 > 被继承的方法
* 命名冲突：使用insteadof关键字

### 匿名类

* 匿名类被嵌套进普通 Class 后，不能访问这个外部类（Outer class）的 private（私有）、protected（受保护）方法或者属性
* 访问外部类（Outer class）protected 属性或方法，匿名类可以 extend（扩展）此外部类
* 使用外部类（Outer class）private 属性，必须通过构造器传进来

```php
$util->setLogger(new class {
    public function log($msg)
    {
        echo $msg;
    }
});

class Outer
{
    private $prop = 1;
    protected $prop2 = 2;

    protected function func1()
    {
        return 3;
    }

    public function func2()
    {
        return new class($this->prop) extends Outer {
            private $prop3;

            public function __construct($prop)
            {
                $this->prop3 = $prop;
            }

            public function func3()
            {
                return $this->prop2 + $this->prop3 + $this->func1();
            }
        };
    }
}

echo (new Outer)->func2()->func3(); # 6
```

## AUTOLOAD

* PHP5中引入了类的自动装载(autoload)机制。可以使得PHP程序有可能在使用类时才自动包含类文件，而不是一开始就将所有的类文件include进来，这种机制也称为lazy loading
* 过程
  - 根据类名确定类文件名
  - 确定类文件所在的磁盘路径
  - 将类从磁盘文件中加载到系统中
* 机制实现
  - 检查执行器全局变量函数指针autoload_func是否为NULL
  - 如果autoload_func==NULL, 则查找系统中是否定义有__autoload()函数，如果没有，则报告错误并退出
  - 如果定义了__autoload()函数，则执行__autoload()尝试加载类，并返回加载结果
  - 如果autoload_func不为NULL，则直接执行autoload_func指针指向的函数用来加载类。注意此时并不检查__autoload()函数是否定义
  - 是一个魔术函数,当php文件中使用了new关键字实例化一个对象时，如果该类没有在本php文件中被定义，将会触发__autoload函数，此时，就可以引进定义该类的php文件，而后，就能实例化成功了
  - __autoload() 在php7中已经不建议使用了
* SPL Standard PHP Library(标准PHP库)
  - PHP5引入的一个扩展库，其主要功能包括autoload机制的实现及包括各种Iterator接口或类。
  - SPL autoload机制的实现是通过将函数指针autoload_func指向自己实现的具有自动装载功能的函数来实现的。
  - SPL有两个不同的函数 spl_autoload, spl_autoload_call，通过将autoload_func指向这两个不同的函数地址来实现不同的自动加载机制。
  - spl_autoload:SPL实现的默认自动加载函数，功能比较简单。可以接收两个参数，第一个参数是$class_name 表示类名，第二个参数$file_extensions是可选的.首先将$class_name变为小写，然后在所有的 include path中搜索$class_name.inc或$class_name.php文件(如果不指定$file_extensions参数的话)，如果找 到，就加载该类文件
  - spl_autoload_register 函数的功能就是把传入的函数（参数可以为回调函数或函数名称形式）注册到 SPL __autoload 函数队列中，并移除系统默认的 __autoload() 函数
  - 在PHP脚本中第一次调用spl_autoload_register()时不使用任何参数，就可以将autoload_func指向spl_autoload.将用户定义的自动加载函数注册到这个链表中，并将autoload_func函数指针指向spl_autoload_call函数。也可以通过spl_autoload_unregister函数将已经注册的函数从autoload_functions链表中删除
  - 在SPL模块内部，有一个全局变量autoload_functions，本质上是一个HashTable，不过可以将其简单的看作一个链表，链表中的每一个元素都是一个函数指针,指向一个具有自动加载类功能的函数
  - spl_autoload_call本身的实现很简单，只是简单的按顺序执行这个链表中每个函数，在每个函数执行完成后都判断一次需要的类是否已经加载， 如果加载成功就直接返回，不再继续执行链表中的其它函数。如果这个链表中所有的函数都执行完成后类还没有加载，spl_autoload_call就直接 退出，并不向用户报告错误
* 手动加载 `spl_autoload_register`
* 通过`Composer classmap`
* PSR-4自动加载标准，会把命名空间放到对应文件系统的子目录中
  - 必须要有一个顶级命名空间，它的意义在于表示某一个特殊的目录（文件基目录）

```php
spl_autoload_register(function ($class){
   $map = [
       'top\\School'=>'./School.php'
   ];

   $file = $map[$class];
    //查看对应的文件是否存在
   if (file_exists($file))
       include $file;
});
```

## 命名空间 namespace

* 出现之前，使用Zend风格的类名解决命名冲突问题:在PHP类名中使用下划线的方式表示文件系统的目录分隔符。这种约定有两个作用
  - 确保类名是唯一
  - 原生的自动加载器会把类名中的下划线替换成文件系统的目录分隔符，从而确定文件的路径。例如，`Zend_Cloud_DocumentService_Adapter_WindowsAzure_Query`类对应的文件是Zend/Cloud/DocumentService/Adapter/WindowsAzure/Query.php.类名特别长
* PHP5.3.0引入，作用是按照一种虚拟的层次结构组织PHP代码,现代的PHP组件框架代码都是放在各自全局唯一的厂商命名空间中，以免和其他厂商使用的常见类名冲突,可以和其他开发者使用相同的类名、接口名、函数或常量名
* 5.6 可以导入函数和常量
* 声明命名空间的代码始终应该放在`<?php` 标签后第一行 `namespace LaravelAcademy\ModernPHP;`
* 一个文件可以使用多个命名空间
* 导入和别名:`use Illuminate\Http\Response as Res;`，支持多重导入
* 借助 `spl_auto_register` 函数注册自动加载器，实现系统未定义类或接口的自动加载
  - 存在一个问题:不同库/组件类名冲突问题
* 分类
  - 完全限定命名空间 `new \成都\徐大帅();`
  - 限定命名空间 `new 成都\徐大帅();`
* 在当前命名空间没有声明的情况下，限定类名和完全限定类名是等价的。因为如果不指定空间，则默认为全局（\）
* 在命名空间下，使用限定类名和完全限定类名的区别,完全限定类名 = 当前命名空间 + 限定类名,如果引用的类、接口、函数和常量没有指定命名空间，PHP假定引用的类、接口、函数和常量在当前的命名空间中
* 要使用其他命名空间的类、接口、函数或常量，需要使用完全限定的PHP类名（命名空间+类名）

## 魔术方法

* __construct 构造函数
  - 功能：初始化赋值
  - 场景：实例化对象时候调用
* __destruct 析构方法
  - 对象被销毁前（即从内存中清除前）调用
* __get ($property) 调用一个未定义属性时，此方法会被触发，参数是被访问属性名
* __set ($property, $value)给一个未定义的属性赋值时，此方法会被触发
  - 参数是被设置的属性名和值这里的没有声明包括当使用对象调用时，访问控制为 proteced,private 的属性（即没有权限访问的属性）
* __isset ($property) 当在一个未定义的属性上调用 isset () 函数时调用
* __unset ($property) 当在一个未定义的属性上调用 unset () 函数时调用
* `_call ($method, $arg_array)` 调用一个未定义的方法时调用
* __autoload 函数，它会在试图使用尚未被定义的类时自动调用。通过调用此函数，脚本引擎在 PHP 出错失败前有了最后一个机会加载所需的类
* __clone 复制一个对象时自动调用 clone 方法，如果在对象复制需要执行某些初始化操作，可以在 clone 方法实现
* `__toString`  将一个对象转化成字符串时自动调用，比如使用 echo 打印对象时
* `__callStatic($funName, $arguments)` 当调用一个未定义或不可达的静态方法时， __callStatic () 方法将被调用
* `__sleep()` serialize() 函数会检查类中是否存在一个魔术方法 __sleep()。如果存在，该方法会先被调用，然后才执行序列化操作,可以用于清理对象，并返回一个包含对象中所有应被序列化的变量名称的数组,不能返回父类的私有成员的名字。这样做会产生一个 E_NOTICE 级别的错误.
* `__wakeup()` unserialize() 会检查是否存在一个 __wakeup() 方法。如果存在，则会先调用 __wakeup 方法，预先准备对象需要的资源
* `__invoke()` 以调用函数的方式访问一个对象时， __invoke () 方法将首先被调用
* `__set_state()` 当调用 var_export () 方法时，__set_state () 方法将被调用
* `__debugInfo()` 输出 debug 信息

## 反射

### 生成器 iterator

* PHP 5.5 引入
* 生成器不要求类实现Iterator接口，从而减轻了类的开销和负担。生成器会根据需求每次计算并产出需要迭代的值，对应用的性能有很大的影响：试想假如标准的PHP迭代器经常在内存中执行迭代操作，这要预先计算出数据集，性能低下；如果要使用特定方式计算大量数据，如操作Excel表数据，对性能影响更甚。使用生成器，即时计算并产出后续值，不占用宝贵的内存空间
* 使用生成器迭代流资源（文件、音频等）
* 生成器只是向前进的迭代器，这意味着不能使用生成器在数据集中执行后退、快进或查找操作，只能让生成器计算并产出下一个值
* 提供了一种更容易的方法来实现简单的对象迭代，性能开销和复杂性大大降低
* 一个生成器函数看起来像一个普通的函数，不同的是普通函数返回一个值，而一个生成器可以yield生成许多它所需要的值
* 一个简单的例子就是使用生成器来重新实现 range() 函数。 标准的 range() 函数需要在内存中生成一个数组包含每一个在它范围内的值，然后返回该数组, 结果就是会产生多个很大的数组。 比如，调用 range(0, 1000000) 将导致内存占用超过 100 MB
* 当一个生成器被调用的时候，返回一个可以被遍历的对象.当遍历这个对象的时候(例如通过一个foreach循环)，PHP 将会在每次需要值的时候调用生成器函数，并在产生一个值之后保存生成器的状态，这样它就可以在需要产生下一个值的时候恢复调用状态。
* 一旦不再需要产生更多的值，生成器函数可以简单退出，而调用生成器的代码还可以继续执行，就像一个数组已经被遍历完了
* 生成器函数核心是 yield 关键字。最简单的调用形式看起来像一个return申明，不同之处在于普通return会返回值并终止函数的执行，而yield会返回一个值给循环调用此生成器的代码并且只是暂停执行生成器函数。
* 在一个表达式上下文(例如在一个赋值表达式的右侧)中使用yield，你必须使用圆括号把yield申明包围起来
* 使用，函数yield返回，遍历获取值
* 支持关联键值对,制定键名
* 在没有参数传入的情况下被调用来生成一个 NULL值并配对一个自动的键名
* 方法
  - array iterator_to_array ( Traversable $iterator [, bool $use_keys = true ] )

## 调用外部命令

* 能执行linux系统的shell命令:可以获得命令执行的状态码
  - system() 输出并返回最后一行shell结果
    + 关掉 安全模式 safe_mode = off
    + 禁用函数列表 disable_functions = proc_open, popen, exec, system, shell_exec, passthru 把 exec 去掉
  - exec() 不输出结果，返回最后一行shell结果，所有结果可以保存到一个返回的数组里面。
  - passthru() 只调用命令，把命令的运行结果原样地直接输出到标准输出设备上

```sh
system("/usr/a.sh");
```

## 过滤

* 所有外部源都可能是攻击媒介，可能会（有意或无意）把恶意数据注入PHP脚本
* 过滤输入:转义或删除不安全的字符
  - HTML
    + 使用htmlentities函数过滤HTML，该函数会将所有HTML标签字符（&、<、>等）转化为对应的HTML实体，以便在应用存储层取出后安全渲染,htmlentities的第一个参数表示要处理的HTML字符串，第二个参数表示要转义单引号，第三个参数表示输入字符串的字符集编码
    + `html_entity_decode`:将所有HTML实体转化为对应的HTML标签
    + 强大的过滤HTML功能，可以使用HTML Purifier库，这是一个很强健且安全的PHP库，专门用于使用指定规则过滤HTML输入
  - SQL:SQL查询中一定不能使用未过滤的输入数据，如果要在SQL查询中使用输入数据，一定要使用PDO预处理语句
* 验证数据
  - 把`FILTER_VALIDATE_*`标识传递给filter_var函数，PHP提供了验证布尔值、电子邮件地址、浮点数、整数、IP、正则表达式和URL的标识
  - 框架中的数据验证

## 转义

* htmlentities 函数转义输出
  - 第二个参数一定要使用ENT_QUOTES，让这个函数转义单引号和双引号
  - 第三个参数中指定合适的字符编码（通常是UTF-8）

## 异常 Exception

* PHP 的错误处理系统向面向对象演进后的产物。异常要先实例化，然后抛出，最后再捕获
* 异常是 Exception 类的对象，在遇到无法修复的状况时抛出（例如，远程 API 无响应，数据库查询失败等），使用 try catch 代码块预测第三方代码可能抛出的异常
* 出现问题时,预期并处理问题更为灵活的方式
  - 可以主动出击，委托职责 抛出异常，把不知道怎么处理的特定情况交给上层开发者来处理
  - 用于防守，预测潜在的问题，减轻其影响
  - 可以就地处理，无需停止执行脚本
* 内置的异常类及其子类如下：
  - Exception
  - ErrorException
  - LogicException
    + BadFunctionCallException
    + BadMethodCallException
    + DomainException
    + InvalidArgumentException
    + LengthException
    + OutOfRangeException
  - RuntimeException
    + OutOfBoundsException
    + OverflowException
    + RangeException
    + UnderflowException
    + UnExpectedValueException
* 异常处理: 允许注册一个全局异常处理程序，捕获所有未被捕获的异常。一定要设置一个全局异常处理程序，它是最后的安全保障。如果没有成功捕获并处理异常，通过这个措施可以给 PHP 应用的用户显示合适的错误信息。一般会在开发环境显示调试信息，而在线上环境显示对用户友好的提示信息
* 使用自定义的异常处理程序替换现有的全局异常处理程序，代码执行完毕后，PHP 会礼貌性地建议你还原现有的异常处理程序，还原的方式是调用 `restore_exception_handler()` 函数

## 错误 Error

* 级别:致命错误、运行时错误、编译时错误、启动错误和用户触发的错误等,最常见错误是由语法错误或未捕获异常导致的错误
  - `E_ALL & ~E_NOTICE` # 除了提示级别
  - `E_ALL ^ E_NOTICE`
  - `E_ERROR | E_RECOVERABLE_ERROR` # 只显示错误和可恢复
* 使用 `error_reporting()` 函数或者在 php.ini 文件中使用` error_reporting` 指令
* 使用 trigger_error 函数自己触发错误，然后使用自定义的错误处理程序进行处理
* 编写运行在用户空间里的代码时最好使用异常。与错误不同的是，PHP 异常可以在 PHP 应用的任何层级抛出和捕获。异常提供的上下文信息比错误多，而且可以扩展最顶层的 Exception 类，创建自定义的异常子类。异常加上一个好的日志记录器（如 Monolog）比错误能解决更多的问题
* 开发环境中，让 PHP 显示并记录所有错误信息，而在生产环境中记录大部分错误信息，但不显示出来.规则：
  - 一定要让 PHP 报告错误
  - 在开发环境中要显示错误
  - 在生产环境中不能显示错误
  - 在开发环境和生成环境中都要记录错误
* 使用自定义错误处理程序时需要注意的是 PHP 会把所有错误都交给错误处理程序处理，甚至包括错误报告（php.ini 中 error_reporting 设置）中排除的错误，因此，要在检查错误代码之后进行处理
* 处理完成后，可以使用 `restore_error_handler()` 函数还原错误处理程序
* 工具
  - `composer require filp/whoops`

```
|- Exception implements Throwable
    |- ...
|- Error implements Throwable
    |- TypeError extends Error
    |- ParseError extends Error
    |- AssertionError extends Error
    |- ArithmeticError extends Error
        |- DivisionByZeroError extends ArithmeticError
```

## 序列化

* 作用
  - 方便传输
  - 方便存储
* 方案
  - 文本序列化,更好可读性
    + json
    + jsond:jsond_encode() jsond_decode()
    + serialize:serialize() unserialize()
    + xml
  - 二进制序列化,速度快
    + msgpack: msgpack_pack() msgpack_unpack()
    + protobuf
    + thrift
* 指标
  - 序列化的速度
  - 序列化后数据的大小
* JSON
  - `json_encode( mixed $value [, int $options = 0 [, int $depth = 512 ]] )` 函数返回值JSON的表示形式：它将PHP变量(包含数组)转换为JSON格式数据
    + 1:JSON_HEX_TAG:所有的 < 和 > 转换成 \u003C 和 \u003E
    + 2:JSON_HEX_AMP:所有的 & 转换成 \u0026
    + 4:JSON_HEX_APOS:所有的 ' 转换成 \u0027
    + 8:JSON_HEX_QUOT:所有的 " 转换成 \u0022
    + 16:JSON_FORCE_OBJECT:使一个非关联数组输出一个类（Object）而非数组。 在数组为空而接受者需要一个类（Object）的时候尤其有用
    + 32:JSON_NUMERIC_CHECK:将所有数字字符串编码成数字（numbers）
    + 64:JSON_UNESCAPED_SLASHES:不要编码 /： 已转义用htmlspecialchars_decode()处理
    + 128:JSON_PRETTY_PRINT:用空白字符格式化返回的数据
    + 256:JSON_UNESCAPED_UNICODE:以字面编码多字节 Unicode 字符（默认是编码成 \uXXXX）
    + 512:JSON_PARTIAL_OUTPUT_ON_ERROR:Substitute some unencodable values instead of failing
    + 1024:JSON_PRESERVE_ZERO_FRACTION:Ensures that float values are always encoded as a float value
  - json_decode()函数解码JSON字符串：将JSON字符串转换为PHP变量
    + 字符串要求
      * 使用UTF-8编码
      * 不能在最后元素有逗号
      * 不能使用单引号
      * 不能有\r,\t，如果有请替换
  - `int json_last_error ( void )`:返回json_encode() or json_decode() call的错误
    + JSON_ERROR_NONE   没有错误发生   
    + JSON_ERROR_DEPTH    到达了最大堆栈深度    
    + JSON_ERROR_STATE_MISMATCH   无效或异常的 JSON  
    + JSON_ERROR_CTRL_CHAR    控制字符错误，可能是编码不对   
    + JSON_ERROR_SYNTAX   语法错误     
    + JSON_ERROR_UTF8 异常的 UTF-8 字符，也许是因为不正确的编码。   PHP 5.3.3
    + JSON_ERROR_RECURSION    One or more recursive references in the value to be encoded PHP 5.5.0
    + JSON_ERROR_INF_OR_NAN   One or more NAN or INF values in the value to be encoded    PHP 5.5.0
    + JSON_ERROR_UNSUPPORTED_TYPE 指定的类型，值无法编码。    PHP 5.5.0
    + JSON_ERROR_INVALID_PROPERTY_NAME    指定的属性名无法编码。 PHP 7.0.0
    + JSON_ERROR_UTF16    畸形的 UTF-16 字符，可能因为字符编码不正确

## socket pcntl模块

## 杂项

* 数学函数
* 电子邮件
* 时间
  - `date.timezone = 'Asia/Shanghai';`
  - `date_default_timezone_set('Asia/Shanghai');`
* XML
  - simplexml_load_file
* 网络
  - gethostbyaddr()：获取指定的IP地址对应的主机名
  - gethostbynamel():获取互联网主机名对应的 IPv4 地址列表
* 密码散列算法函数
  - password_​get_​info
  - password_​hash
  - password_​needs_​rehash
  - password_​verify
* 性能
  - `$jRawData = file_get_contents( 'php://input' );`

```php
abs(-7)
abs(-7.2)
ceil(-4.8) # -4
floor(-4.8) # -5
sqrt(25)

decbin(10) # 1010
dechex(10) # a
decoct(22) # 26
bindec(1011) # 11
$n1=10;
echo (base_convert($n1,10,2)."<br/>");// 1010

require("menu.html");

ini_set("sendmail_from", "maxsujaiswal@yiibai.com");
$to = "maxsujaiswal1987@gmail.com";//change receiver address
$subject = "This is subject";
$message = "This is simple text message.";
$header = "From:maxsujaiswal@yiibai.com \r\n";

$result = mail ($to,$subject,$message,$header);

if( $result == true ){
  echo "Message sent successfully...";
}else{
  echo "Sorry, unable to send mail...";
}

$to = "abc@example.com";//发送HTML消息
$subject = "This is subject";
$message = "<h1>This is HTML heading</h1>";

$header = "From:xyz@example.com \r\n";
$header .= "MIME-Version: 1.0 \r\n";
$header .= "Content-type: text/html;charset=UTF-8 \r\n";

$result = mail($to,$subject,$message,$header);
if( $result == true ){
  echo "Message sent successfully...";
}else{
  echo "Sorry, unable to send mail...";
}

$to = "abc@example.com";  # 使用附件发送邮件
$subject = "This is subject";
$message = "This is a text message.";
# Open a file
$file = fopen("/tmp/test.txt", "r" );//change your file location
if( $file == false )
{
 echo "Error in opening file";
 exit();
}
# Read the file into a variable
$size = filesize("/tmp/test.txt");
$content = fread( $file, $size);

# encode the data for safe transit
# and insert \r\n after every 76 chars.
$encoded_content = chunk_split( base64_encode($content));

# Get a random 32 bit number using time() as seed.
$num = md5( time() );

# Define the main headers.
$header = "From:xyz@example.com\r\n";
$header .= "MIME-Version: 1.0\r\n";
$header .= "Content-Type: multipart/mixed; ";
$header .= "boundary=$num\r\n";
$header .= "--$num\r\n";

# Define the message section
$header .= "Content-Type: text/plain\r\n";
$header .= "Content-Transfer-Encoding:8bit\r\n\n";
$header .= "$message\r\n";
$header .= "--$num\r\n";

# Define the attachment section
$header .= "Content-Type:  multipart/mixed; ";
$header .= "name=\"test.txt\"\r\n";
$header .= "Content-Transfer-Encoding:base64\r\n";
$header .= "Content-Disposition:attachment; ";
$header .= "filename=\"test.txt\"\r\n\n";
$header .= "$encoded_content\r\n";
$header .= "--$num--";

# Send email now
$result = mail ( $to, $subject, "", $header );
if( $result == true ){
  echo "Message sent successfully...";
}else{
  echo "Sorry, unable to send mail...";
}
<?
//add() function with two parameter
function add($x,$y)
{
    $sum=$x+$y;
    echo "Sum = $sum <br><br>";
}
//sub() function with two parameter
function sub($x,$y)
{
    $sub=$x-$y;
    echo "Diff = $sub <br><br>";
}
//call function, get  two argument through input box and click on add or sub button
if(isset($_POST['add']))
{
    //call add() function
     add($_POST['first'],$_POST['second']);
}
if(isset($_POST['sub']))
{
    //call add() function
    sub($_POST['first'],$_POST['second']);
}
?>
<form method="post">
    Enter first number: <input type="number" name="first"/><br>
    Enter second number: <input type="number" name="second"/><br>
<input type="submit" name="add" value="ADDITION"/>
<input type="submit" name="sub" value="SUBTRACTION"/>
</form>

string http_build_query ( mixed $query_data [, string $numeric_prefix [, string $arg_separator [, int $enc_type = PHP_QUERY_RFC1738 ]]] )

header('Location:'.$url);  // 跳转页面 Location和":"之间无空格。
header('content-type:text/html;charset=utf-8'); // 声明content-type
header('HTTP/1.1 404 Not Found'); // 返回response状态码
header('Refresh: 10; url=http://www.baidu.com/');  //10s后跳转。

// 控制浏览器缓存
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");
header("Last-Modified: " . gmdate("D, d M Y H:i:s") . "GMT");
header("Cache-Control: no-cache, must-revalidate");
header("Pragma: no-cache");

// 执行http验证
header('HTTP/1.1 401 Unauthorized');
header('WWW-Authenticate: Basic realm="Top Secret"');

// 执行下载操作
header('Content-Type: application/octet-stream'); //设置内容类型
header('Content-Disposition: attachment; filename="example.zip"'); //设置MIME用户作为附件
header('Content-Transfer-Encoding: binary'); //设置传输方式
header('Content-Length: '.filesize('example.zip')); //设置内容长度

# 时间
var_dump(date("Y-m-d", strtotime("-1 month", strtotime("2017-03-31")))); # 输出2017-03-03
var_dump(date("Y-m-d", strtotime("last day of -1 month", strtotime("2017-03-31")))); # 输出2017-02-28
var_dump(date("Y-m-d", strtotime("first day of +1 month", strtotime("2017-08-31")))); # 输出2017-09-01

$hostname = gethostbyaddr($_SERVER['REMOTE_ADDR']);
```

## 安全

* 原则
  - 绝对不能知道用户的密码
  - 绝对不要约束用户的密码
  - 绝对不能通过电子邮件发送用户密码
* 存储算法
  - 最佳实践是计算密码的哈希值
  - 加密和哈希不是一回事，加密事双向算法，加密的数据可以解密，而哈希是单向算法，哈希后的数据不能再还原成原始值，而且相同的数据得到的哈希值始终相同
* 最安全的算法当属bcrypt，与md5和SHA1不同，bcrypt故意设计得很慢，bcrypt会自动加盐（salt），防止潜在的彩虹表攻击
  - bcrypt算法会花费大量时间反复处理数据，生成特别安全的哈希值。在这个过程中，处理数据的次数叫工作因子，工作因子的值越高，破解密码所需的时间越长，安全性越好。
  - bcrypt算法永不过时，如果计算机运算速度变快了，只需提高工作因子的值
* md5：一种信息摘要算法（其实就是哈希），不是加密算法，因为md5不可逆，但是加解密是一个可逆的过程
* 分类
  - 对称加密，常见算法 DES、3DES、AES等
    + 用同一个密钥对信息加解密
    + 欲要加密，必先加密密钥的矛盾
    + [gibberish-aes-php](https://github.com/ivantcholakov/gibberish-aes-php)
  - 非对称加密，RSA、DSA、ECDH等
    + 公钥和私钥是成双成对生成的，二者之间通过某种神秘的数学原理连接
    + 公钥加密的数据，只能通过相应的私钥解密；私钥加密的数据，只能通过对应的公钥解密
    + 发给谁信息用谁公钥加密,用自己公钥加密，只有自己私钥解密，利用自己私钥加密，所有有自己公钥的都可以解密
    + 私钥加密，公钥验签
    + 公钥可以颁发给任何人，私钥自己保留
    + [pikirasa](https://github.com/vlucas/pikirasa)
    + 加密周期长,耗资源
  - 混合
    + 随机生成一个AES对称加密用的密钥，然后用客户端的RSA公钥加密后传给客户端
    + 客户端再通过自己的RSA私钥解密得到这个AES对称密钥，然后再用这个AES对称密钥进行后续的加解密即可
    + 给这个AES密钥设定一个有效期，过期后，就再次利用上面的流程申请新的AES密钥即可
* 密钥协商\交换
  - 避免密钥在网络上的传输被劫持导致的安全问题
  - 利用RSA等非对称加密技术进行交换
  - 利用专门伺候密钥交换需求的交换算法，比如DH算法，全称叫做Diffie-Hellman密钥交换
    + 元首手里有的数据有100（基数）、9、300（加密），古德里安手里的数据有100、3、900（加密），然后两个人此时只需要默默地做下面这一步：元首：9 * 300 = 2700 古德里安：3 * 900 = 2700，就是2700
    + [diffie-hellman-php](https://github.com/jcink/diffie-hellman-php)
    + ECDH [ECDH-PHP](https://github.com/Querdos/ECDH-PHP)

```php
https://github.com/Querdos/ECDH-PHP

<?php
require_once './autoloader.php';
use Querdos\lib\ECDHCurve25519;
$xitele   = new ECDHCurve25519();
$gudelian = new ECDHCurve25519();
$xitele->computeSecret( $gudelian->getPublic() );
$gudelian->computeSecret( $xitele->getPublic() );
// shareKey1 和 shareKey2 就是协商出来的密钥
$shareKey1 = $xitele->getSecret();
echo $shareKey1.PHP_EOL;
$shareKey2 = $gudelian->getSecret();
echo $shareKey2.PHP_EOL;
// 我们用gmp cmp来对比是否为同一个密钥
if ( 0 == gmp_cmp( $shareKey1, $shareKey2 ) ) {
  echo "一样".PHP_EOL;
}
else {
  echo "不一样".PHP_EOL;
}
// 除此之外，ecdh比dh多了一个验证数据签名验证，也就是说ecdh可以检验数据是否被篡改！
$msg = "hello world";
$signature = $xitele->signMessage( $msg );
if ( $gudelian->verifySignature( $signature, $xitele->getPublic(), $msg ) ) {
  echo "验证数据签名成功".PHP_EOL;
}
else {
  echo "验证数据签名失败".PHP_EOL;
}
exit;
```

## 跨域请求

* Access-Control-Allow-Origin 设置方法
  - 设置*是最简单粗暴的，但是服务器出于安全考虑，肯定不会这么干，而且，如果是*的话，游览器将不会发送cookies，即使你的XHR设置了withCredentials
  - 指定域，如上图中的http://172.20.0.206，一般的系统中间都有一个nginx，所以推荐这种,例如：'Access-Control-Allow-Origin:http://172.20.0.206'
  - 动态设置为请求域，多人协作时，多个前端对接一个后台，这样很方便
  - withCredentials：表示XHR是否接收cookies和发送cookies，也就是说如果该值是false，响应头的Set-Cookie，浏览器也不会理，并且即使有目标站点的cookies，浏览器也不会发送。
* Access-Control-Allow-Credentials :是否允许后续请求携带认证信息（cookies）,该值只能是true,否则不返回
* option请求多了2个字段：
  - Access-Control-Request-Method：该次请求的请求方式
  - Access-Control-Request-Headers：该次请求的自定义请求头字段
  - Access-Control-Max-Age 预检结果缓存时间 表明该响应的有效时间为 86400 秒，也就是 24 小时。在有效时间内，浏览器无须为同一请求再次发起预检请求。浏览器自身维护了一个最大有效时间，如果该首部字段的值超过了最大有效时间，将不会生效

```php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Credentials: true');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS'); //允许的请求类型
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept"); // 允许的请求头字段

location / {
    add_header Access-Control-Allow-Origin *;
    add_header Access-Control-Allow-Methods 'GET, POST, OPTIONS';
    add_header Access-Control-Allow-Headers 'DNT,Keep-Alive,User-Agent,Cache-Control,Content-Type,Authorization';

    if ($request_method = 'OPTIONS') {
        return 204;
    }
}
```

## Docker

* [php](https://github.com/docker-library/php):Docker Official Image packaging for PHP https://php.net
* [dnmp](https://github.com/yeszao/dnmp):Docker LNMP (Nginx, PHP7/PHP5, MySQL, Redis) https://www.awaimai.com/2120.html

```
mkdir -p ~/php-fpm/logs ~/php-fpm/conf

# Dockerfile

FROM debian:jessie

# persistent / runtime deps

ENV PHPIZE_DEPS \ autoconf \ file \ g++ \ gcc \ libc-dev \ make \ pkg-config \ re2c RUN apt-get update && apt-get install -y \ $PHPIZE_DEPS \ ca-certificates \ curl \ libedit2 \ libsqlite3-0 \ libxml2 \ --no-install-recommends && rm -r /var/lib/apt/lists/*

ENV PHP_INI_DIR /usr/local/etc/php RUN mkdir -p $PHP_INI_DIR/conf.d

## <autogenerated>
</autogenerated>

ENV PHP_EXTRA_CONFIGURE_ARGS --enable-fpm --with-fpm-user=www-data --with-fpm-group=www-data

##

ENV GPG_KEYS 0BD78B5F97500D450838F95DFE857D9A90D90EC1 6E4F6AB321FDC07F2C332E3AC2BF0BC433CFC8B3

ENV PHP_VERSION 5.6.22 ENV PHP_FILENAME php-5.6.22.tar.xz ENV PHP_SHA256 c96980d7de1d66c821a4ee5809df0076f925b2fe0b8c362d234d92f2f0a178e2

RUN set -xe \ && buildDeps=" \ $PHP_EXTRA_BUILD_DEPS \ libcurl4-openssl-dev \ libedit-dev \ libsqlite3-dev \ libssl-dev \ libxml2-dev \ xz-utils \ " \ && apt-get update && apt-get install -y $buildDeps --no-install-recommends && rm -rf /var/lib/apt/lists/_ \ && curl -fSL "<http://php.net/get/$PHP_FILENAME/from/this/mirror>" -o "$PHP_FILENAME" \ && echo "$PHP_SHA256_ $PHP_FILENAME" | sha256sum -c - \ && curl -fSL "<http://php.net/get/$PHP_FILENAME.asc/from/this/mirror>" -o "$PHP_FILENAME.asc" \ && export GNUPGHOME="$(mktemp -d)" \ && for key in $GPG_KEYS; do \ gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \ done \ && gpg --batch --verify "$PHP_FILENAME.asc" "$PHP_FILENAME" \ && rm -r "$GNUPGHOME" "$PHP_FILENAME.asc" \ && mkdir -p /usr/src/php \ && tar -xf "$PHP_FILENAME" -C /usr/src/php --strip-components=1 \ && rm "$PHP_FILENAME" \ && cd /usr/src/php \ && ./configure \ --with-config-file-path="$PHP_INI_DIR" \ --with-config-file-scan-dir="$PHP_INI_DIR/conf.d" \ $PHP_EXTRA_CONFIGURE_ARGS \ --disable-cgi \

# --enable-mysqlnd is included here because it's harder to compile after the fact than extensions are (since it's a plugin for several extensions, not an extension in itself)

    --enable-mysqlnd \


# --enable-mbstring is included here because otherwise there's no way to get pecl to use it properly (see <https://github.com/docker-library/php/issues/195>)


    --enable-mbstring \
    --with-curl \
    --with-libedit \
    --with-openssl \
    --with-zlib \
&& make -j"$(nproc)" \
&& make install \
&& { find /usr/local/bin /usr/local/sbin -type f -executable -exec strip --strip-all '{}' + || true; } \
&& make clean \
&& apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false $buildDeps


COPY docker-php-ext-* /usr/local/bin/

## <autogenerated>
</autogenerated>

WORKDIR /var/www/html

RUN set -ex \ && cd /usr/local/etc \ && if [ -d php-fpm.d ]; then \


    # for some reason, upstream's php-fpm.conf.default has "include=NONE/etc/php-fpm.d/*.conf"
    sed 's!=NONE/!=!g' php-fpm.conf.default | tee php-fpm.conf > /dev/null; \
    cp php-fpm.d/www.conf.default php-fpm.d/www.conf; \
else \
    # PHP 5.x don't use "include=" by default, so we'll create our own simple config that mimics PHP 7+ for consistency
    mkdir php-fpm.d; \
    cp php-fpm.conf.default php-fpm.d/www.conf; \
    { \
        echo '[global]'; \
        echo 'include=etc/php-fpm.d/*.conf'; \
    } | tee php-fpm.conf; \
fi \
&& { \
    echo '[global]'; \
    echo 'error_log = /proc/self/fd/2'; \
    echo; \
    echo '[www]'; \
    echo '; if we send this to /proc/self/fd/1, it never appears'; \
    echo 'access.log = /proc/self/fd/2'; \
    echo; \
    echo 'clear_env = no'; \
    echo; \
    echo '; Ensure worker stdout and stderr are sent to the main error log.'; \
    echo 'catch_workers_output = yes'; \
} | tee php-fpm.d/docker.conf \
&& { \
    echo '[global]'; \
    echo 'daemonize = no'; \
    echo; \
    echo '[www]'; \
    echo 'listen = [::]:9000'; \
} | tee php-fpm.d/zz-docker.conf
EXPOSE 9000 CMD ["php-fpm"]

docker build -t php:5.6-fpm .
docker run -p 9000:9000 --name myphp-fpm -v ~/nginx/www:/www -v $PWD/conf:/usr/local/etc/php -v $PWD/logs:/phplogs -d php:5.6-fpm
```

## [xhprof](https://github.com/phacility/xhprof)

* 一个分层PHP性能分析工具。报告函数级别的请求次数和各种指标，包括阻塞时间，CPU时间和内存使用情况
* [longxinH/xhprof](https://github.com/longxinH/xhprof):PHP7 support
* 工具
  - [EvaEngine/xhprof.io](https://github.com/EvaEngine/xhprof.io):GUI to analyze the profiling data collected using XHProf – A Hierarchical Profiler for PHP. http://xhprof.io/
  - [perftools/xhgui](https://github.com/perftools/xhgui):A graphical interface for XHProf data built on MongoDB
* 方法
  - xhprof_disable — 停止 xhprof 分析器
  - xhprof_enable — 启动 xhprof 性能分析器
    + 如果xhprof_enable(XHPROF_FLAGS_CPU + XHPROF_FLAGS_MEMORY)可以输出更多指标
  - xhprof_sample_disable — 停止 xhprof 性能采样分析器
  - xhprof_sample_enable — 以采样模式启动 XHProf 性能分析
* 主要指标
  - Inclusive Time (或子树时间)：包括子函数所有执行时间
  - Exclusive Time/Self Time：函数执行本身花费的时间，不包括子树执行时间
  - Wall时间：花去了的时间或挂钟时间
  - CPU时间：用户耗的时间+内核耗的时间 
  - Function Name 函数名 
  - Calls 调用次数 
  - Calls% 调用百分比 
  - 消耗时间 
    + **Incl. Wall Time (microsec) ** 调用的包括子函数所有花费时间 以微秒算(一百万分之一秒)
    + IWall% 调用的包括子函数所有花费时间的百分比 
    + **Excl. Wall Time (microsec) ** 函数执行本身花费的时间，不包括子树执行时间,以微秒算(一百万分之一秒) 
    + EWall% 函数执行本身花费的时间的百分比，不包括子树执行时间 
      - 消耗CPU 
    + Incl. CPU(microsecs) 调用的包括子函数所有花费的cpu时间。减Incl. Wall Time即为等待cpu的时间 
    + ICpu% Incl. CPU(microsecs)的百分比 
    + Excl. CPU(microsec) 函数执行本身花费的cpu时间，不包括子树执行时间,以微秒算(一百万分之一秒)。 
    + ECPU% Excl. CPU(microsec)的百分比 
      - 消耗内存 
    + Incl.MemUse(bytes) 包括子函数执行使用的内存。 
    + IMemUse% Incl.MemUse(bytes)的百分比 
    + Excl.MemUse(bytes) 函数执行本身内存,以字节算 
    + EMemUse% Excl.MemUse(bytes)的百分比 
      - 消耗内存峰值 
    + Incl.PeakMemUse(bytes) Incl.MemUse的峰值 
    + IPeakMemUse% Incl.PeakMemUse(bytes) 的峰值百分比 
    + Excl.PeakMemUse(bytes) Excl.MemUse的峰值 
    + EPeakMemUse% EMemUse% 峰值百分比
* 黄色最耗时路径
* 红色是瓶颈

```
git clone https://github.com/longxinH/xhprof
cd xhprof/extension/
/usr/local/php/bin/phpize
./configure --with-php-config=/usr/local/Cellar/php/7.3.6/bin/php-config --enable-xhprof
make&&make install
# 配置
[xhprof]
extension=xhprof.so
xhprof.output_dir = /Users/henry/Workspace/www/xhprof # 该目录自由定义即可,用来保存xhprof生成的源文件

## 重启PHP服务
kill -USR2 `cat /opt/php-7.0.14/var/run/php-fpm.pid`

sudo pecl install channel://pecl.php.net/xhprof-0.9.4

yum install graphviz # 性能图渲染

# 使用
xhprof_enable(); # 需要分析的代码

##  Code
$xhprof_data = xhprof_disable();
include_once ROOT_PATH.'/xhprof_lib/utils/xhprof_lib.php';
include_once ROOT_PATH . '/xhprof_lib/utils/xhprof_runs.php';
$xhprof_runs = new XHProfRuns_Default();
$run_id = $xhprof_runs->save_run($xhprof_data, "xhprof_test"); # 将run_id保存起来或者随代码一起输出

# 查看结果
$host_url/xhpfrof_html/index.php?run=58d3b28b521f6&source=xhprof_test
```

## 性能

* 测试
  - 压测
    + ab `ab -n1000 -c10 https://www.baidu.com/`  -n请求数 -c并发数,结果参数
      * requests per second
      * time per request
  - `time php php-src/Zend/micro_bench.php`:查看 user 参数
  - XHPorf
* 语言级
  - 编译解析开销:zend逐行扫描分析成zend能识别的语法解析成opcode（内置方法生成opcode 少）执行
    + 用语言内置函数:已做优化，比自己实现的方法优化
    + 内置函数性能：知道方法的时间复杂度 比如：isset arrat_key_exists
    + 魔法函数性能不佳
    + 产生错误抑制符：代码前后改变错误等级 error_reporting 前面忽略 后面还原，通过vld:查看opcode
  - 合理使用内存：unset释放掉
    - unset注销不掉
  - 正则的回溯开销大
  - 避免循环内运算：for中 length 放在外面
  - 减少密集运算：开销比C大
  - 带引号字符串作为键值
* 周边：系统依赖，找到问题核心
  - php是串行执行
  - 文件操作性能：读写内存 << 读写数据库 << 读写磁盘 << 读写网络（网络延时）
  - 硬件
    + 运行环境linux
    + 硬盘 文件存储
    + 内存：memache 热数据
  - 软件
    + 数据库
  - 网络：减少网络请求
    + 对方接口不确定
    + 网络稳定性
    + 设置超时
      * 连接超时 800ms
      * 读超时 200ms
      * 写超时 500ms
    + 串行并行化
      * curl_multi依赖最长
      * swoole
  - 压缩PHP输出 Gzip
    + 快
    + 服务器、客户端：额外CPU开销
    + 大于100k使用,根据内容重复度压缩后
  - 缓存
    + 重复请求 内容不变
    + smarty: 开启caching
  - 重叠时间窗口
    + 前提是后任务不强依赖前一任务
    + 旁路方案
* 方法
  - memory_get_usage()
  - microtime()
  - APC：Opcache缓存
    + yac
  - 扩展实现高频逻辑
  - runtime优化:HHVM

## 编码

```php
<?php header("Content-type: text/html; charset=utf-8"); ?>
```

## curl

* 选项的值将被作为长整形使用(在option参数中指定)：
  - CURLOPT_INFILESIZE: 上传一个文件到远程站点，这个选项告诉PHP你上传文件的大小。
  - CURLOPT_VERBOSE: 想CURL报告每一件意外的事情，设置这个选项为一个非零值。
  - CURLOPT_HEADER: 想把一个头包含在输出中，设置这个选项为一个非零值。
  - CURLOPT_NOPROGRESS: 不会PHP为CURL传输显示一个进程条，设置这个选项为一个非零值。注意：PHP自动设置这个选项为非零值，e仅仅为了调试的目的来改变这个选项。
  - CURLOPT_NOBODY: 不想在输出中包含body部分，设置这个选项为一个非零值
  - CURLOPT_FAILONERROR: 想让PHP在发生错误(HTTP代码返回大于等于300)时，不显示，设置这个选项为一人非零值。默认行为是返回一个正常页，忽略代码。
  - CURLOPT_UPLOAD: 想让PHP为上传做准备，设置这个选项为一个非零值。
  - CURLOPT_POST: 想PHP去做一个正规的HTTP POST，设置这个选项为一个非零值。这个POST是普通的 application/x-www-from-urlencoded 类型，多数被HTML表单使用。
  - CURLOPT_FTPLISTONLY: 设置这个选项为非零值，PHP将列出FTP的目录名列表。
  - CURLOPT_FTPAPPEND: 设置这个选项为一个非零值，PHP将应用远程文件代替覆盖它。
  - CURLOPT_NETRC: 设置这个选项为一个非零值，PHP将在你的 ~./netrc 文件中查找你要建立连接的远程站点的用户名及密码。
  - CURLOPT_FOLLOWLOCATION: 设置这个选项为一个非零值(象 “Location: “)的头，服务器会把它当做HTTP头的一部分发送(注意是递归的，PHP将发送形如 “Location: “的头)。
  - CURLOPT_PUT: 设置这个选项为一个非零值去用HTTP上传一个文件。要上传这个文件必须设置CURLOPT_INFILE和CURLOPT_INFILESIZE选项.
  - CURLOPT_MUTE: 设置这个选项为一个非零值，PHP对于CURL函数将完全沉默。
  - CURLOPT_TIMEOUT: 设置一个长整形数，作为最大延续多少秒 告诉成功 PHP 从服务器接收缓冲完成前需要等待多长时间 **响应超时**
  - CURLOPT_LOW_SPEED_LIMIT: 设置一个长整形数，控制传送多少字节。
  - CURLOPT_LOW_SPEED_TIME: 设置一个长整形数，控制多少秒传送CURLOPT_LOW_SPEED_LIMIT规定的字节数。
  - CURLOPT_RESUME_FROM: 传递一个包含字节偏移地址的长整形参数，(你想转移到的开始表单)。
  - CURLOPT_SSLVERSION: 传递一个包含SSL版本的长参数。默认PHP将被它自己努力的确定，在更多的安全中你必须手工设置。
  - CURLOPT_TIMECONDITION: 传递一个长参数，指定怎么处理CURLOPT_TIMEVALUE参数。可以设置这个参数为TIMECOND_IFMODSINCE 或 TIMECOND_ISUNMODSINCE。这仅用于HTTP
  - CURLOPT_CONNECTTIMEOUT:告诉 PHP 在成功连接服务器前等待多久 **连接超时**
  - CURLOPT_TIMEVALUE: 传递一个从1970-1-1开始到现在的秒数。这个时间将被CURLOPT_TIMEVALUE选项作为指定值使用，或被默认TIMECOND_IFMODSINCE使用。
* 选项的值将被作为字符串：
  - CURLOPT_URL: 这是想用PHP取回的URL地址。也可以在用curl_init()函数初始化时设置这个选项
  - CURLOPT_USERPWD: 传递一个形如[username]:[password]风格的字符串,作用PHP去连接
  - CURLOPT_PROXYUSERPWD: 传递一个形如[username]:[password] 格式的字符串去连接HTTP代理
  - CURLOPT_RANGE: 传递一个想指定的范围。它应该是”X-Y”格式，X或Y是被除外的。HTTP传送同样支持几个间隔，用逗句来分隔(X-Y,N-M)
  - CURLOPT_POSTFIELDS: 传递一个作为HTTP “POST”操作的所有数据的字符串
  - CURLOPT_REFERER: 在HTTP请求中包含一个”referer”头的字符串
  - CURLOPT_USERAGENT: 在HTTP请求中包含一个”user-agent”头的字符串
  - CURLOPT_FTPPORT: 传递一个包含被ftp “POST”指令使用的IP地址。这个POST指令告诉远程服务器去连接我们指定的IP地址。这个字符串可以是一个IP地址，一个主机名，一个网络界面名(在UNIX下)，或是‘-'(使用系统默认IP地址)
  - CURLOPT_COOKIE: 传递一个包含HTTP cookie的头连接
  - CURLOPT_SSLCERT: 传递一个包含PEM格式证书的字符串
  - CURLOPT_SSLCERTPASSWD: 传递一个包含使用CURLOPT_SSLCERT证书必需的密码。
  - CURLOPT_COOKIEFILE: 传递一个包含cookie数据的文件的名字的字符串。这个cookie文件可以是Netscape格式，或是堆存在文件中的HTTP风格的头。
  - CURLOPT_CUSTOMREQUEST: 当进行HTTP请求时，传递一个字符被GET或HEAD使用。为进行DELETE或其它操作是有益的，更Pass a string to be used instead of GET or HEAD when doing an HTTP request. This is useful for doing or another, more obscure, HTTP request. 注意: 在确认的服务器支持命令先不要去这样做。下列的选项要求一个文件描述(通过使用fopen()函数获得)：　
  - CURLOPT_FILE: 这个文件将是放置传送的输出文件，默认是STDOUT
  - CURLOPT_INFILE: 这个文件是传送过来的输入文件
  - CURLOPT_WRITEHEADER: 这个文件写有输出的头部分
  - CURLOPT_STDERR: 这个文件写有错误而不是stderr。用来获取需要登录的页面的例子,当前做法是每次或许都登录一次,有需要的人再做改进了

## 正则表达式 PREG

* 元字符
  - .   匹配除换行符以外的任意字符
  - \w  匹配字母或数字或下划线或汉字
  - \s  匹配任意的空白符
  - \d  匹配数字
  - \b  匹配单词的开始或结束
  - ^   匹配字符串的开始
  - $   匹配字符串的结束
* 字符转义:要查找特殊意义字符`.`，或者`*`,使用\来取消。使用`\\.` `\\\*` `\\\`
* 重复
  - `*` 重复零次或更多次
  - `+` 重复一次或更多次
  - ?   重复零次或一次
  - {n} 重复n次
  - {n,}    重复n次或更多次
  - {n,m}   重复n到m次
* 字符类
  - [“your set”]：如[aeiou]，则匹配a，e，i，o和u中的任意一个，同理[.?!]匹配标点符号(.或?或!)
  - [0-9]：与\d就是完全一致，表示一位数字
  - [a-zA-Z]：表示一个字母，[a-z0-9A-Z]等同于\w(当然值考虑英文的话)
  - `\(?0\d{2}[)-]?\d{8}` # (010)88886666，或022-22334455，或02912345678等
  - \ 将下一个字符标记为一个特殊字符、或一个原义字符、或一个 向后引用、或一个八进制转义符。例如，'n' 匹配字符 "n"。'\n' 匹配一个换行符。序列 '\' 匹配 "" 而 "\(" 则匹配 "("。
  - ^   匹配输入字符串的开始位置。如果设置了 RegExp 对象的 Multiline 属性，^ 也匹配 '\n' 或 '\r' 之后的位置。
  - $   匹配输入字符串的结束位置。如果设置了RegExp 对象的 Multiline 属性，$ 也匹配 '\n' 或 '\r' 之前的位置。
    非贪婪模式尽可能少的匹配所搜索的字符串，而默认的贪婪模式则尽可能多的匹配所搜索的字符串。例如，对于字符串 "oooo"，'o+?'
  - [xyz]   字符集合。匹配所包含的任意一个字符。例如， '[abc]' 可以匹配 "plain" 中的 'a'
  - [^xyz]  负值字符集合。匹配未包含的任意字符。例如， '[^abc]' 可以匹配 "plain" 中的'p'、'l'、'i'、'n'。
  - [a-z]   字符范围。匹配指定范围内的任意字符。例如，'[a-z]' 可以匹配 'a' 到 'z' 范围内的任意小写字母字符。
  - [^a-z]  负值字符范围。匹配任何不在指定范围内的任意字符。例如，'[^a-z]' 可以匹配任何不在 'a' 到 'z' 范围内的任意字符。
  - \b  匹配一个单词边界，也就是指单词和空格间的位置。例如， 'er\b' 可以匹配"never" 中的 'er'，但不能匹配 "verb" 中的 'er'。
  - \B  匹配非单词边界。'er\B' 能匹配 "verb" 中的 'er'，但不能匹配 "never" 中的 'er'。
  - \cx 匹配由 x 指明的控制字符。例如， \cM 匹配一个 Control-M 或回车符。x 的值必须为 A-Z 或 a-z 之一。否则，将 c 视为一个原义的 'c' 字符。
  - \d  匹配一个数字字符。等价于 [0-9]。
  - \D  匹配一个非数字字符。等价于 [^0-9]。
  - \f  匹配一个换页符。等价于 \x0c 和 \cL。
  - \n  匹配一个换行符。等价于 \x0a 和 \cJ。
  - \r  匹配一个回车符。等价于 \x0d 和 \cM。
  - \s  匹配任何空白字符，包括空格、制表符、换页符等等。等价于 [ \f\n\r\t\v]。
  - \S  匹配任何非空白字符。等价于 [^ \f\n\r\t\v]。
  - \t  匹配一个制表符。等价于 \x09 和 \cI。
  - \v  匹配一个垂直制表符。等价于 \x0b 和 \cK。
  - \w  匹配包括下划线的任何单词字符。等价于'[A-Za-z0-9_]'。
  - \W  匹配任何非单词字符。等价于 '[^A-Za-z0-9_]'。
  - \xn 匹配 n，其中 n 为十六进制转义值。十六进制转义值必须为确定的两个数字长。例如，'\x41' 匹配 "A"。'\x041' 则等价于 '\x04' & "1"。正则表达式中可以使用 ASCII 编码。
  - \num    匹配 num，其中 num 是一个正整数。对所获取的匹配的引用。例如，'(.)\1' 匹配两个连续的相同字符。
  - \n  标识一个八进制转义值或一个向后引用。如果 \n 之前至少 n 个获取的子表达式，则 n 为向后引用。否则，如果 n 为八进制数字 (0-7)，则 n 为一个八进制转义值。
  - \nm 标识一个八进制转义值或一个向后引用。如果 \nm 之前至少有 nm 个获得子表达式，则 nm 为向后引用。如果 \nm 之前至少有 n 个获取，则 n 为一个后跟文字 m 的向后引用。如果前面的条件都不满足，若 n 和 m 均为八进制数字 (0-7)，则 \nm 将匹配八进制转义值 nm。
  - \nml    如果 n 为八进制数字 (0-3)，且 m 和 l 均为八进制数字 (0-7)，则匹配八进制转义值 nml。
  - \un 匹配 n，其中 n 是一个用四个十六进制数字表示的 Unicode 字符。例如， \u00A9 匹配版权符号 (?)。
  - \(pattern\) 匹配pattern 并获取这一匹配。所获取的匹配可以从产生的Matches集合得到，在VBScript 中使用SubMatches集合，在JScript 中则使用 $0…$9 属性。要匹配圆括号字符，请使用 '\(' 或 '\)'。        -
  - \(?:pattern\) 匹配pattern但不获取匹配结果，也就是说这是一个非获取匹配，不进行存储供以后使用。这在使用 "或" 字符“|”来组合一个模式的各个部分是很有用。
  - 例如，“industr\(?:y|ies\)”就是一个比 “industry|industries” 更简略的表达式。     -
  - \(?=pattern\) 正向预查，在任何匹配pattern的字符串开始处匹配查找字符串。这是一个非获取匹配，也就是说，该匹配不需要获取供以后使用。例如，'Windows (?=95|98|NT|2000)' 能匹配 "Windows 2000" 中的 "Windows" ，但不能匹配"Windows 3.1" 中的 "Windows"。预查不消耗字符，也就是说，在一个匹配发生后，在最后一次匹配之后立即开始下一次匹配的搜索，而不是从包含预查的字符之后开始。     -
  - (?!pattern) 负向预查，在任何不匹配 pattern 的字符串开始处匹配查找字符串。这是一个非获取匹配，也就是说，该匹配不需要获取供以后使用。例如'Windows (?!95|98|NT|2000)' 能匹配 "Windows 3.1" 中的 "Windows"，但不能匹配 "Windows 2000" 中的 "Windows"。预查不消耗字符，也就是说，在一个匹配发生后，在最后一次匹配之后立即开始下一次匹配的搜索，而不是从包含预查的字符之后开始。
  - x|y 匹配x或y。例如，'z|food' 能匹配 "z" 或 "food"。'(z|f)ood' 则匹配 "zood" 或 "food"。
* 常用分组语法
  - 捕获  (exp)   匹配exp,并捕获文本到自动命名的组里
  - (?<name>exp)    匹配exp,并捕获文本到名称为name的组里，也可以写成(?'name'exp)
  - (?:exp) 匹配exp,不捕获匹配的文本，也不给此分组分配组号
  - 零宽断言    (?=exp) 匹配exp前面的位置
  - (?<=exp)    匹配exp后面的位置
  - (?!exp) 匹配后面跟的不是exp的位置
  - `(?<!exp)`    匹配前面不是exp的位置
  - 注释  (?#comment) 这种类型的分组不对正则表达式的处理产生任何影响，用于提供注释让人阅读
* 贪婪与懒惰
    当正则表达式中包含能接受重复的限定符时，通常的行为是（在使整个表达式能得到匹配的前提下）匹配尽可能多的字符。以这个表达式为例：a.\*b，它将会匹配最长的以a开始，以b结束的字符串。如果用它来搜索aabab的话，它会匹配整个字符串aabab。这被称为贪婪匹配。
    有时，我们更需要懒惰匹配，也就是匹配尽可能少的字符。前面给出的限定符都可以被转化为懒惰匹配模式，只要在它后面加上一个问号?。这样.\*?就意味着匹配任意数量的重复，但是在能使整个匹配成功的前提下使用最少的重复。现在看看懒惰版的例子吧：
    a.*?b匹配最短的，以a开始，以b结束的字符串。如果把它应用于aabab的话，它会匹配aab（第一到第三个字符）和ab（第四到第五个字符）。注意：最先开始的匹配拥有最高的优先权
  - * 重复任意次，但尽可能少重复
  - + 重复1次或更多次，但尽可能少重复
  - ?  重复0次或1次，但尽可能少重复
  - {n,m}?  重复n到m次，但尽可能少重复
  - {n,}?   重复n次以上，但尽可能少重复
* 模式修正符
  - i：模式中的字符将同时匹配大小写字母。
  - m：“行起始”和“行结束”除了匹配整个字符串开头和结束外，还分别匹配其中的换行符的之后和之前。
  - s：模式中的圆点元字符（.）匹配所有的字符，包括换行符。没有此设定的话，则不包括换行符。
  - x：模式中的空白字符除了被转义的或在字符类中的以外完全被忽略，在未转义的字符类之外的 #以及下一个换行符之间的所有字符，包括两头，也都被忽略。
  - e：如果设定了此修正符，preg_replace() 在替换字符串中对逆向引用作正常的替换，
  - ?在 . + 和 * 之后 表示非贪婪匹配: *、+和?限定符都是贪婪的，因为它们会尽可能多的匹配文字，只有在它们的后面加上一个?就可以实现非贪婪或最小匹配。
* 参考
  - [五分钟，正则表达式不再是你的烦恼](https://www.jianshu.com/p/4f258d81ff4c)
  - https://www.w3cschool.cn/regexp/jhbv1pr1.html
  - https://www.cnblogs.com/yelons/p/6644579.html
  - https://www.cnblogs.com/longdaye/p/8001221.html
  - https://blog.csdn.net/kkobebryant/article/details/267527
  - http://www.jb51.net/article/77428.htm
  - https://www.cnblogs.com/hellohell/p/5718319.html

## SPL

* SplQueue
* SplHeap:一种有序的数据结构。数据总是按照最小在前或最大在前排序。新插入的数据会自动进行排序
  - SplHeap底层使用跳表数据结构，insert操作的时间复杂度为O(Log(n))

```php
$queue = new SplQueue;
//入队
$queue->push($data);
//出队
$data = $queue->shift();
//查询队列中的排队数量
$n = count($queue);

# 功能
$splq = new SplQueue;
for($i = 0; $i < 1000000; $i++)
{
    $data = "hello $i\n";
    $splq->push($data);

    if ($i % 100 == 99 and count($splq) > 100)
    {
        $popN = rand(10, 99);
        for ($j = 0; $j < $popN; $j++)
        {
            $splq->shift();
        }
    }
}

$popN = count($splq);
for ($j = 0; $j < $popN; $j++)
{
    $splq->pop();
}

//最大堆
class MaxHeap extends SplHeap
{
    protected function compare($a, $b)
    {
        return $a - $b;
    }
}

//最小堆
class MinHeap extends SplHeap
{
    protected function compare($a, $b)
    {
        return $b - $a;
    }
}

$list = new MaxHeap;
$list->insert(56);
$list->insert(22);
$list->insert(35);
$list->insert(11);
$list->insert(88);
$list->insert(36);
```

## 禁止

* 不要使用 `mysql_` 函数：从核心中全部移除了

## 能力

用工具来实现想法，不管是自己的想法还是他人的需求，学会转化

* 平静的心态：遇事不可急躁，不可轻言放弃，而是需要静静的思考
* 问题解决思路
  - 编码问题
  - PHP和SQL数据库执行效率问题
  - Session和Cookie域和加密解析问题
  - 程序的执行顺序问题
  - 程序编写的多环境适用问题
  - 分类的构建和结构设计问题
  - 字符串处理问题：正则表达式处理或简单PHP字符串处理函数来处理
  - 各种模板引擎的编写局限性问题
  - PHP和web端数据交互问题（如ajax，接口调用等）
* PHP基础知识
  - MYSQL各种sql语句的写法，增删改查基本的不说了,in(),union,left(),leftjoin,as,replace,alter table,where的字段排序,各种索引建立的方法要特别熟悉
* 综合的互联网应用及项目管理知识和素养
  - 见识广博，擅于学习：不要只顾着天天编程，学会抽点时间去看看一些大型开源系统的架构思路，以及大型商务网站的构建方式。向他们学习，补充自己的不足。比如至少该晓得不同类型的开源系统有哪些吧，比如Uchome,dede,phpcms,wordpress,discuz,帝国等等看多了，会总结发现一些常规性的思路，比如缓存的机制，比如模板机制，比如静态页面生成等等
  - 项目解决方案选型：不同需求，用不同的机构和选型。有些架构固然强大，但是用于小型项目也会很吃力，就是杀机不用牛刀。根据需求来选型很重要。选型不是随口就能定的，需要一个PHP程序员用于良好的储备，个人觉得至少需要以下储备，才具备选型能力：熟练应用至少一个PHP框架，两-三个PHP开源系统；拥有自己的一套应用系统
  - 项目管理素养：项目不是一直开发过程中，也会进入运营期，维护期，这样，具备良好的项目管理素养会使项目更加稳定，可控
    + 项目开发及维护习惯，记住：千万别为了一时的省力，造成后面多次的重复劳动。时时提醒自己将工作流程化，流程规划化，规范简单化
    + 多人合作管理意识：项目不是一个人的，是多人协作的产物，也是服务于大众的，因而，要提升协作意识，让相关人员一同来完善项目
  - 丰富的项目开发应用经验：学理论，去考试或考核是学校里面的事儿，没有项目经验，就像满肚子经文，吐也难吐出。这就需要实际的项目将自己的知识去学会转化为需求实现

## 开发规范

* 代码可读性强：对象，方法，函数的注释；一套成熟命名规范
* 代码冗余度底：程序和文件的重用性大，高内聚，低耦合
* 执行效率高：用最简单的程序流程实现应用需求，勿扰大弯子
* 代码安全性好：做一名警惕的程序员，任何有用户输入和上传文件的地方都得额外谨慎，也许一个程序员一时的疏忽就会导致一个系统顷刻间崩溃

```
> mysql_real_escape_string mysql_escape_string区别
mysql_real_escape_string需要预先连接数据库，并可在第二个参数传入数据库连接（不填则使用上一个连接）
两者都是对数据库插入数据进行转义，但是mysql_real_escape_string转义时，会考虑数据库连接的字符集。
它们的用处都是用来能让数据正常插入到数据库中，并防止sql注入，但是并不能做到100%防止sql注入。

> 内存泄漏
内存泄漏是因为一块被分配内存既不能被使用，也不能被回收，直到浏览器进程结束。
页面元素被删除，但是绑定在该元素上的事件未被删除；
闭包维持函数内局部变量（外部不可控），使其得不到释放；
意外的全局变量；
引用被删除，但是引用内的引用，还存在内存中。
外部调用类函数

> sql注入
ZEND引擎维护了一个栈zval，每个创建的变量和资源都会压入这个栈中，每个压入的数组结构都类似：[refcount => int, is_ref => 0|1, value => union, type => string]，变量被unset时，ref_count如果变成0，则被回收。

当遇到变量循环引用自身时，使用同步回收算法回收。

sapi是php封装的对外数据传递接口，通常有cgi/fastcgi/cli/apache2handler四种运行模式。

crc32

> 索引用b+树存储，而不是哈希表，数据库索引存储还有其他数据结构吗？
O(log(n))，O(1).因为哈希表是散列的，在遇到`key`>'12'这种查找条件时，不起作用，并且空间复杂度较高。
备注：b+数根据层数决定时间复杂度，数据量多的情况下一般4-5层，然后用二分法查找页中的数据，时间复杂度远小于log(n)。
```

## 大数据

* 查询上运行EXPLAIN，看看是不是缺少什么索引。曾经做过一个查询，通过增加了一个索引后效率提高了4个数量级
* 如果正在做SQL查询，然后获得结果，并把很多数字弄到一起，看看能不能使用像SUM（）和AVG（）之类的函数调用GROUP BY语句
  - 跟普遍的情况下，让数据库处理尽量多的计算。一点很重要的提示是：（至少在MySQL里是这样）布尔表达式的值为0或1，如果有创意的话，可以使用SUM（）和它的小伙伴们做些很让人惊讶的事情。
* 是不是把这些同样很耗费时间的数字计算了很多遍。例如，假设1000袋土豆的成本是昂贵的计算，但并不需要把这个成本计算500次，然后才把1000袋土豆的成本存储在一个数组或其他类似的地方，所以你不必把同样的东西翻来覆去的计算。这个技术叫做记忆术，在像你这样的报告中使用往往会带来奇迹般的效果

## [xdebug](git://github.com/xdebug/xdebug.git)

Xdebug — Step Debugger and Debugging Aid for PHP <https://xdebug.org>

* 浏览器扩展：xdebug helper(非必须)
* [原理](https://xdebug.org/docs/remote)
  - PHP Xdebug 插件起了9001端口（server）
    + 浏览器向服务器发送一个带有 XDEBUG_SESSION_START 参数的请求，服务器收到这个请求之后交给后端的 PHP（已开启 xdebug 模块）处理
    + Php 接受带了 XDEBUG_SESSION_START 参数的请求，Xdebug 会向来源 ip 客户端(IDE)的 9001 端口（默认是 9000 端口）发送一个 debug 请求，然后客户端的 9001 端口响应这个请求，那么 debug 就开始了
    + 客户端（IDE）收到 Xdebug 发送过来的执行情况，把这些信息展示给开发者
    + Php 知道 Xdebug 已经准备好了，那么就开始开始一行一行的执行代码，但是每执行一行都会让 Xdebug 过滤一下，Xdebug 在过滤每一行代码的时候，都会暂停代码的执行，然后向客户端的 9000 端口发送该行代码的执行情况，等待客户端的决策
      - IDE监听9001端口(client):集成了一个遵循 BGDp 的 Xdebug 插件
    + 启动插件:会启动一个 9000 的端口监听远程服务器发过来的 debug 信息
  - servers:实际服务起的端口号，脚本运行需要的地址
    - 通信协议 DBGp:端口意义不大,加了一层代理
* 配置php script：配置xdebug,指向测试文件
* 设置断点，运行
* 可以添加watches
* 添加表达式

```sh
brew install php71-xdebug

pecl install xdebug

##  Cannot accept external Xdebug connection: Cannot evaluate expression 'isset($_SERVER['PHP_IDE_CONFIG'])
```

## remote debug

```
brew install php71-xdebug
pecl install xdebug

# php.ini
zend_extension="xdebug.so"
xdebug.remote_enable = on
xdebug.remote_host = localhost
xdebug.remote_port = 9000
xdebug.remote_handler = dbgp
<!-- xdebug.remote_mode = "req" -->
xdebug.idekey = PHPSTORM
xdebug.remote_log = /tmp/xdebug.log

# PHPstrom setting
## debug
Debug port 9000

## DBGP
PHPSTORM
localhost
80

## Servers
localhost 80 Xdebug

# Script
URL # 实际URL

## start listening
```

## [steward](https://github.com/lmc-eu/steward)

* PHP libraries that makes Selenium WebDriver + PHPUnit functional testing easy and robust
* 准备
  - [geckodriver](https://github.com/mozilla/geckodriver/releases)

```sh
composer require lmc/steward

# Get Selenium Standalone Server
./vendor/bin/steward install
java -jar ./vendor/bin/selenium-server-standalone-3.4.0.jar
./vendor/bin/steward run staging firefox
```

## 问题

> 5096 segmentation fault (core dumped)  php http_server.php

> Warning: "continue" targeting switch is equivalent to "break". Did you mean to use "continue 2"?

## 最佳实践

* 配置文件（configuration file）:写在一个文件里,方便地适应开发环境的变化。配置文件通常包含以下信息：数据库参数、email地址、各类选项、debug和logging输出开关、应用程序常数
* 名称空间（namespace）: 选择类和函数名的时候，必须很小心，避免出现重名。尽可能不要在类以外，放置全局性函数，类对内部的属性和方法，相当于有一层名称空间保护。如果确实有必要声明全局性函数，那么使用一个前缀，比如dao_factory()、db_getConnection()、text_parseDate()等等
* 数据库抽象层:PHP不提供数据库操作的通用函数，每种数据库都有一套自己的函数,不应该直接使用这些函数.数据库抽象层通常比系统本身的数据库函数，更易用一些
* "值对象"（Value Object, VO）: 值对象（VO）在形式上，就像C语言的struct结构。它是一个只包含属性、不包含任何方法（或只包含很少方法）的类。一个值对象，就对应一个实体。它的属性，通常应该与数据库的字段名保持相同。此外，还应该有一个ID属性
* 数据访问对象（Data Access Object, DAO）: 数据访问对象（DAO）的作用，主要是将数据库访问与其他代码相隔离。DAO应该是可以叠加（stacked）的，这样就有利于将来你再添加数据库缓存。每一个值对象的类，都应该有自己的DAO
  - save：插入或更新一条记录
  - get：取出一条记录
  - delete：删除一条记录
* 自动生成代码: 99%的值对象和DAO代码，可以根据数据库模式（schema）自动生成，前提是你的表和列使用约定的方式进行命名。如果你修改数据库模式，一个自动生成代码的脚本将大大节省你的时间
* 业务逻辑直接反映使用者的需要。它们处理值对象，根据业务需要修改值对象的属性，使用DAO与数据库层交互
* 页逻辑（控制器）:当一个网页被请求时，页控制器（page controller）就会运行，然后产生输出。控制器的任务，就是将HTTP请求转化成业务对象（business object），然后调用相应的业务逻辑，最后生成一个"展示输出"的对象。页逻辑依次执行以下步骤（请参照后面的PageController类的代码）：
  - 假定页面请求之中，包含一个cmd参数。
  - 根据cmd参数的值，执行相应的动作。
  - 验证页面返回的值，生成一个值对象。
  - 针对值对象，执行业务逻辑。
  - 如果有必要，可以导向另一个页面。
  - 收集必要的数据，输出结果。
  - 可以编写一个工具函数（utility function），处理GET或POST值，当有的变量没有赋值时，提供一个默认值。页逻辑不包含HTML代码
* 表现层（Presentation Layer）: 最顶层的页面包含实际的HTML代码。这个页面需要的所有业务对象（business object），由页逻辑提供。这个页面先读取业务对象的属性，然后将它们转换成HTML格式
* 本地化（Localization）
  - 准备多重页面。
  - HTML页面中去除特定语言相关的内容
  - 保存用户语言
    + 将语言设定保存在一个session变量或cookie之中
    + 从HTTP头中读取locale值
    + 把语言设定作为一个参数，追加在每个URL后面
* 可以定义一个全局变量$ROOT，值就是程序的根目录，然后把它包含在每一个脚本文件中。那么，你要包含某个文件，就这样写require_once("$ROOT/lib/base.inc.php");
* 目录结构:每个类都应该有自己的独立文件，还必须有一套文件名的命名规则（naming convention）
  - 目录结构可以采用如下形式
      +　/ 根目录。浏览器从这个页面开始访问
      +　/lib/ 包含全局变量（base.inc.php）和配置文件（config.inc.php）
      +　/lib/common/ 包含其他项目也可以共用的库，比如数据库抽象层
      +　/lib/model/ 包含值对象类
      +　/lib/dao/ 包含数据访问对象（DAO）类，以及DAO工厂函数
      +　/lib/logic/ 包含业务逻辑类
      +　/parts/ 包含HTML模板文件
      +　/control/ 包含页逻辑。对于大型程序来说，这个目录下面可能还有子目录（比如admin/, /pub/）
  - base.inc.php文件中，应该按照以下顺序添加包含文件：
    + /lib/common之中经常使用的类（比如数据库层）
    + 配置文件
    + /lib/model之中所有类
    + /lib/dao的之中所有类

## 面试

* [PHPerInterviewGuide](https://github.com/todayqq/PHPerInterviewGuide)
* [php-interview-2018](https://github.com/sushengbuhuo/php-interview-2018)
* [PHP-Interview](https://github.com/xianyunyh/PHP-Interview)PHP面试整理的资料。包括PHP、MySQL、Linux、计算机网络等资料
* [金题](https://www.jintix.com/)
* [PHP-Interview-QA](https://github.com/colinlet/PHP-Interview-QA):PHP面试问答
* [](https://github.com/disxo/PHP-interview-myway)

## [yar](https://github.com/laruence/yar)

Light, concurrent RPC framework for PHP & C

## [yaf](https://github.com/laruence/yaf)

A fast php framework written in c, built in php-ext <http://pecl.php.net/package/yaf>

* [CZD_Yaf_Extension](https://github.com/sillydong/CZD_Yaf_Extension):建立在 yarf基础上，集成了Smarty引擎，加入了封装好的各种功能类
* [Yaf用户手册](http://www.laruence.com/manual/)

```sh
sudo pecl install yaf
```

## [Yac](https://github.com/laruence/yac)

A fast shared memory user data cache for PHP

* [yaconf](https://github.com/laruence/yaconf):A PHP Persistent Configurations Container
  - 主要目标是简化读取项目配置文件,使配置文件和项目代码分离，增强了配置文件的可读性和可维护性

## 包管理

* Composer包 Composer Repositories
  - [Firegento](http://packages.firegento.com):Magento Module Composer Repository
  - [Packagist](https://packagist.org):The PHP Package Repository
  - [PaketHub](https://pakethub.com):All-in-One PHP Package Repository
  - [Private Packagist](https://packagist.com):Composer package archive as a service for PHP
  - [WordPress Packagist](https://wpackagist.org):Manage your plugins with Composer
* 依赖管理 Dependency Management 依赖和包管理库
  - [Composer Installers](https://github.com/composer/installers): 一个多框架Composer库安装器
  - [Composer](https://getcomposer.org/)
  - [Melody](http://melody.sensiolabs.org/): 一个用于构建Composer脚本文件的工具
  - [Pickle](https://github.com/FriendsOfPHP/pickle): 一个PHP扩展安装器
* 其他的依赖管理 Dependency Management Extras
  - [Composed](https://github.com/joshdifabio/composed): 一个在运行时解析你项目Composer环境的库
  - [Composer Checker](https://github.com/silpion/composer-checker): 一个校验Composer配置的工具
  - [Composer Merge Plugin](https://github.com/wikimedia/composer-merge-plugin): 一个用于合并多个composer.json文件的Composer插件
  - [Composition](https://github.com/bamarni/composition): 一个在运行时检查Composer环境的库
  - [NameSpacer](https://github.com/ralphschindler/Namespacer): 一个转化下划线到命名空间的库
  - [Patch Installer](https://github.com/goatherd/patch-installer): 一个使用Composer安装补丁的库
  - [Prestissimo](https://github.com/hirak/prestissimo): 一个开启并行安装进程的Composer插件
  - [Satis](https://github.com/composer/satis): 一个静态Composer存储库的生成器
  - [tooly](https://github.com/tommy-muehle/tooly-composer-script): 一个在项目中使用Composer管理PHAR文件的库
  - [Toran Proxy](https://toranproxy.com): 一个静态Composer存储库和代理
  - [skeleton](https://github.com/thephpleague/skeleton):A skeleton repository for League Packages <http://thephpleague.com>
* 配置
  - [phpdotenv](https://github.com/vlucas/phpdotenv):Loads environment variables from `.env` to `getenv()`, `$_ENV` and `$_SERVER` automagically.

## 框架

* 框架
  - 面向Web而生的框架并不适合做API，因为API和Web是有很多不同的，Web框架里带着太多太多为解决Web而生组件和库，其实对于API来说都是压根用不到的
  - 做为API开发，主张使用快捷轻量级的方式，严格意义上来说只要能满足一个简单的路由分发功能和兼容composer即可！这方面的典范，可以选用惠新宸的Yaf或者fligt框架等，都是非常粗暴的解决方案
  - 做为个人偏好，从不推荐Lavarel（包括Lumen）这种玩意
* 优点
  - 提供了一个用以构建web应用的基本框架，从而简化了用PHP编写web应用程序的流程
  - 不但节省开发时间，有助于建立更稳定的应用，而且减少了重复编码的开发
  - 可以帮助初学者建立更稳定的应用服务，这可以让你花更多的时间去创建实际的Web应用程序，而不是花时间写重复的代码
* 通用
  - [Aura PHP](http://auraphp.com/): 一个独立的组件框架
  - [CakePHP](https://github.com/cakephp/cakephp)CakePHP: The Rapid Development Framework for PHP - Official Repository <http://cakephp.org>
    + [cakephp-setup](https://github.com/dereuromark/cakephp-setup):CakePHP Setup Plugin - containing useful management and debugging tools for CakePHP apps <http://www.dereuromark.de>
    + [docs](https://github.com/cakephp/docs):CakePHP CookBook <http://book.cakephp.org>
  - [CakePHP CRUD](https://github.com/friendsofcake/crud): CakePHP的快速应用程序（RAD）插件
  - [PPI Framework 2](http://www.ppi.io): 一个互操作性框架
  - [Zend Framework 2](https://framework.zend.com): 另一个由独立组件组成的框架 (ZF2)
  - [Radar](https://github.com/radarphp/Radar.Adr): 一个基于PHP的Action-Domain-Responder实现
  - [Ice](https://www.iceframework.org/): 另一个通过C扩展实现的简单快速的PHP框架
  - [Knp RAD Bundle](http://rad.knplabs.com/): Symfony 2的快速应用程序（RAD）包
  - [Symfony CMF](https://github.com/symfony-cmf/symfony-cmf):一个创建自定义CMS的内容管理框架
  - [lexin-fintech/dubbo-php-framework](https://github.com/lexin-fintech/dubbo-php-framework):dubbo php implementation
  - [pinguo/php-msf](https://github.com/pinguo/php-msf)PHP微服务框架即"Micro Service Framework For PHP"，是Camera360社区服务器端团队基于Swoole自主研发现代化的PHP协程服务框架，简称msf或者php-msf，是Swoole的工程级企业应用框架，经受了Camera360亿级用户高并发大流量的考验
  - [Youzan Zan Php Installer](https://github.com/youzan/zan-installer)Youzan Zan Php Installer
  - [tencent-php/tsf](https://github.com/tencent-php/tsf):coroutine and Swoole based php server framework in tencent
  - [nette/nette](https://github.com/nette/nette):METAPACKAGE for Nette Framework components <https://nette.org>
  - [Tencent/Biny](https://github.com/Tencent/Biny):Biny is a tiny, high-performance PHP framework for web applications
  - [amphp/amp](https://github.com/amphp/amp):A non-blocking concurrency framework for PHP applications. <https://amphp.org/amp>
  - [kakserpom/phpdaemon](https://github.com/kakserpom/phpdaemon):Asynchronous server-side framework for network applications implemented in PHP using libevent <http://daemon.io/>
  - [mnapoli/bref](https://github.com/mnapoli/bref):Serverless framework for PHP
  - [manaphp/manaphp](https://github.com/manaphp/manaphp):ManaPHP Framework
  - [Elgg](https://github.com/Elgg/Elgg ) <http://learn.elgg.org/en/stable/guides>
  - [TIGERB/easy-php](https://github.com/TIGERB/easy-php):A Faster Lightweight Full-Stack PHP Framework 🚀 <http://easy-php.tigerb.cn>
* 异步框架
  - Amp
  - [reactphp](https://github.com/reactphp/react):Event-driven, non-blocking I/O with PHP. <https://reactphp.org>
* 论坛
  - [flarum](https://github.com/flarum/flarum):Composer starter project for Flarum <https://flarum.org>
* 电商
  - [magento2](https://github.com/magento/magento2): a cutting edge, feature-rich eCommerce solution that gets results.
  - [drupal](https://github.com/drupal/drupal):Verbatim mirror of the git.drupal.org repository for Drupal core. Changes will not be pulled, and merge requests will not be accepted, if you want to contribute, go to Drupal.org: <https://drupal.org/project/drupal>
  - [Joolma](https://www.joomla.org/)
    + [文档](https://docs.joomla.org/Main_Page/zh-cn)
  - [Sylius](https://github.com/Sylius/Sylius): Open Source eCommerce Framework on top of Symfony <https://sylius.com>
    + [Documentation](https://sylius.readthedocs.io/en/latest/)
    + [Sylius-Standard](https://github.com/Sylius/Sylius-Standard)
* CMS
  - [bolt](https://github.com/bolt/bolt):Bolt is a simple CMS written in PHP. It is based on Silex and Symfony components, uses Twig and either SQLite, MySQL or PostgreSQL.
* Wiki
  - [MediaWiki](https://www.mediawiki.org/wiki/MediaWiki)
  - [dokuwiki](https://www.dokuwiki.org/)
  - [BookStack](https://www.bookstackapp.com/):a simple, self-hosted, easy-to-use platform for organising and storing information
* 框架组件
  - [CakePHP Plugins](https://plugins.cakephp.org/): CakePHP插件的目录
  - [Hoa Project](https://hoa-project.net/En/): 另一个PHP组件包
  - [League of Extraordinary Packages](https://thephpleague.com/): 一个PHP软件开发组
  - [Symfony Components](http://symfony.com/doc/master/components/index.html): Symfony组件
  - [Zend Framework 2 Components](https://packages.zendframework.com/): Zend Framework 2组件
* 微型框架 Micro Frameworks 微型框架和路由
  - [Bullet PHP](http://bulletphp.com/): 用于构建REST APIs的微型框架
  - [Proton](https://github.com/alexbilbie/Proton): 一个StackPHP兼容的微型框架
  - [Silex](http://silex.sensiolabs.org/): 基于Symfony2组件的微型框架
    + [Silex Skeleton](https://github.com/silexphp/Silex-Skeleton): Silex的项目架构
    + [Silex Web Profiler](https://github.com/silexphp/Silex-WebProfiler): 一个Silex web的调试工具
  - [Slim](https://github.com/slimphp/Slim):Slim is a PHP micro framework that helps you quickly write simple yet powerful web applications and APIs. <http://slimframework.com>
    + [Slim Skeleton](https://github.com/slimphp/Slim-Skeleton): Slim架构
    + [Slim View](https://github.com/slimphp/Slim-Views): Slim自定义视图的集合
  - [mikecao/flight](https://github.com/mikecao/flight):An extensible micro-framework for PHP <http://flightphp.com>
* 其他微型框架 Micro Framework Extras 其他相关的微型框架和路由
* 路由 Routers 处理应用路由的库
  - [nikic/FastRoute](https://github.com/nikic/FastRoute): 一个快速路由的库
  - [Klein](https://github.com/klein/klein.php): 一个灵活的路由的库
  - [Pux](https://github.com/c9s/Pux): 另一个快速路由的库
  - [Route](https://github.com/thephpleague/route): 一个基于Fast Route的路由的库
  - [YOURLS/YOURLS](https://github.com/YOURLS/YOURLS):🔗 Your Own URL Shortener <https://yourls.org>
  - [noahbuscher/macaw](https://github.com/NoahBuscher/Macaw):🐦 Simple PHP router
* 模板 Templating 模板化和词法分析的库和工具
  - [Foil](https://github.com/FoilPHP/Foil): 另一个原生PHP模板库
  - [Lex](https://github.com/pyrocms/lex): 一个轻量级模板解析器
  - [MtHaml](https://github.com/arnaud-lb/MtHaml): 一个HAML模板语言的PHP实现
  - [Mustache](https://github.com/bobthecow/mustache.php): 一个Mustache模板语言的PHP实现
  - [Phly Mustache](https://github.com/phly/phly_mustache): 另一个Mustache模板语言的PHP实现
  - [PHPTAL](http://phptal.org/): 一个模板语言的PHP实现
  - [Plates](http://platesphp.com/): 一个原生PHP模板库
  - [smarty](https://github.com/smarty-php/smarty):<http://www.smarty.net/>
  - [Twig](https://github.com/twigphp/Twig):Twig, the flexible, fast, and secure template language for PHP <http://twig.sensiolabs.org/>
  - [tale-jade](https://github.com/Talesoft/tale-jade):A complete and fully-functional implementation of the Jade template language for PHP <http://jade.talesoft.codes>
  - [doctrine2](https://github.com/doctrine/doctrine2):<http://docs.doctrine-project.org/projects/doctrine-orm/en/latest/index.html>
* 静态站点生成器 Static Site Generators 用来生成web页面的预处理内容的工具
  - [Couscous](http://couscous.io): 一个将Markdown转化为漂亮的网站的工具
  - [Phrozn](https://github.com/Pawka/phrozn): 另一个转换Textile，Markdown和Twig为HTML的工具
  - [Sculpin](https://sculpin.io): 转换Markdown和Twig为静态HTML的工具
  - [Spress](http://spress.yosymfony.com): 一个能够将Markdown和Twig转化为HTML的可扩展工具
* 超文本传输协议 HTTP
  - [Buzz](https://github.com/kriswallsmith/Buzz): 一个HTTP客户端
  - Saber
  - [guzzle](https://github.com/guzzle/guzzle):Guzzle, an extensible PHP HTTP client <http://guzzlephp.org/> <http://docs.guzzlephp.org/en/stable/index.html>
    + [promises](https://github.com/guzzle/promises):Promises/A+ library for PHP with synchronous support
  - [HTTPFul](https://github.com/nategood/httpful): 一个链式HTTP库
  - [PHP VCR](http://php-vcr.github.io/): 一个录制和重放HTTP请求的库
  - [Requests](https://github.com/rmccue/Requests):Requests for PHP is a humble HTTP request library. It simplifies how you interact with other sites and takes away all your worries. <http://requests.ryanmccue.info/>
  - [Retrofit](https://github.com/tebru/retrofit-php): 一个能轻松创建REST API客户端的库
  - [zend-diactoros](https://github.com/zendframework/zend-diactoros): PSR-7 HTTP消息实现
  - [zttp](https://github.com/kitetail/zttp):A developer-experience focused HTTP client, optimized for most common use cases.
  - [nikic/FastRoute](https://github.com/nikic/FastRoute):Fast request router for PHP
* 爬虫 Scraping 用于网站爬取的库
  - [Embed](https://github.com/oscarotero/Embed):  一个从web服务或网页中提取的信息的工具
  - [Goutte](https://github.com/FriendsOfPHP/Goutte): 一个简单的web爬取器
  - [PHP Spider](https://github.com/mvdbos/php-spider): 一个可配置和可扩展的PHP web爬虫
  - [phpspider](https://github.com/owner888/phpspider):《我用爬虫一天时间“偷了”知乎一百万用户，只为证明PHP是世界上最好的语言 》所使用的程序
* 中间件 Middlewares 使用中间件构建应用程序的库
  - [Expressive](https://zendframework.github.io/zend-expressive/): 基于PSR-7的Zend中间件
  - [PSR7-Middlewares](https://github.com/oscarotero/psr7-middlewares): 灵感来源于方便的中间件
  - [Relay](https://github.com/relayphp/Relay.Relay): 一个PHP 5.5 PSR-7的中间件调度器
  - [Stack](https://github.com/stackphp): 一个用于Silex/Symfony的可堆叠的中间件的库
  - [zend-stratigility](https://github.com/zendframework/zend-stratigility): 基于PHP PSR-7之上的中间件之上
* 网址 URL 解析URL的库
  - [PHP Domain Parser](https://github.com/jeremykendall/php-domain-parser): 一个本地前缀解析库
  - [Purl](https://github.com/jwage/purl): 一个URL处理库
  - [sabre/uri](https://github.com/fruux/sabre-uri): 一个URI操作库
  - [Uri](https://github.com/thephpleague/uri): 另一个URL处理库
  - [siler](https://github.com/leocavalcante/siler):⚡️ Flat-files and plain-old PHP functions rockin'on <https://siler.leocavalcante.com>
* 电子邮件 Email 发送和解析邮件的库
  - [CssToInlineStyles](https://github.com/tijsverkoyen/CssToInlineStyles): 一个在邮件模板中的内联CSS库
  - [Email Reply Parser](https://github.com/willdurand/EmailReplyParser): 一个邮件回复解析的库
  - [Email Validator](https://github.com/nojacko/email-validator): 一个较小的电子邮件验证库
  - [Fetch](https://github.com/tedious/Fetch): 一个IMAP库
  - [Mautic](https://github.com/mautic/mautic): 邮件营销自动化
  - [PHPMailer](https://github.com/PHPMailer/PHPMailer): The classic email sending library for PHP
  - [Stampie](https://github.com/henrikbjorn/Stampie): 一个邮件服务库，类似于[SendGrid](http://sendgrid.com)[PostMark](https://postmarkapp.com),[MailGun](http://www.mailgun.com)[Mandrill](http://www.mandrill.com)
  - [SwiftMailer](http://swiftmailer.org/): 一个邮件解决方案
  - [EmailValidator](https://github.com/egulias/EmailValidator):PHP Email validator library inspired in @dominicsayers isemail function <https://github.com/dominicsayers/isemail>
* 文件 Files 文件处理和MIME类型检测的库
  - [Apache MIME Types](https://github.com/dflydev/dflydev-apache-mime-types): 一个解析Apache MIME类型的库
  - [Canal](https://github.com/dflydev/dflydev-canal): 一个检测互联网媒体类型的库
  - [CSV](https://github.com/thephpleague/csv):CSV data manipulation made easy in PHP <https://csv.thephpleague.com>
  - [Ferret](https://github.com/versionable/Ferret): 一个MIME检测库
  - [Flysystem](https://github.com/thephpleague/flysystem):Abstraction for local and remote filesystems <https://flysystem.thephpleague.com>
  - [Gaufrette](https://github.com/KnpLabs/Gaufrette): 一个文件系统抽象层
  - [Hoa Mime](https://github.com/hoaproject/Mime): 另一个MIME检测库
  - [Lurker](https://github.com/henrikbjorn/Lurker): 一个资源跟踪库
  - [PHP FFmpeg](https://github.com/PHP-FFmpeg/PHP-FFmpeg/): 一个用于[FFmpeg](http://www.ffmpeg.org/)视频包装的库
  - [UnifiedArchive](https://github.com/wapmorgan/UnifiedArchive): 一个统一标准的压缩和解压的库
* 流 Streams 处理流的库
  - [Streamer](https://github.com/fzaninotto/Streamer): 一个简单的面向对象的流包装库
* 依赖注入 Dependency Injection 实现依赖注入设计模式的库
  - (<https://github.com/jeremeamia/acclimate-container)[Acclimate>]: 一个依赖注入容器和服务定位的通用接口
  - (<https://github.com/rdlowrey/Auryn)[Auryn>]: 一个递归的依赖注入容器
  - (<https://github.com/thephpleague/container)[Container>]: 另一个可伸缩的依赖注入容器
  - (<https://github.com/bitExpert/disco)[Disco>]: 一个兼容PSR-11基于annotation的依赖注入容器
  - [PHP-DI](https://github.com/PHP-DI/PHP-DI): 一个支持自动装配和PHP配置的依赖注入容器 <http://php-di.org/>
  - (<http://pimple.sensiolabs.org/)[Pimple>]: 一个小的依赖注入容器
  - (<https://github.com/symfony/dependency-injection)[Symfony> DI]: 一个依赖注入容器组件 (SF2)
* 图像 Imagery 处理图像的库
  - (<https://github.com/thephpleague/color-extractor)[Color> Extractor]: 一个从图像中提取颜色的库
  - (<https://github.com/Sybio/GifCreator)[GIF> Creator]: 一个通过多张图片创建GIF动画的库
  - (<https://github.com/Sybio/GifFrameExtractor)[GIF> Frame Extractor]: 一个提取GIF动画帧信息的库
  - (<https://github.com/jenssegers/imagehash)[Image> Hash]: 一个用于生成图像哈希感知的库
  - (<https://github.com/psliwa/image-optimizer)[Image> Optimizer]: 一个优化图像的库
  - (<https://github.com/nmcteam/image-with-text)[Image> With Text]: 一个在图像中嵌入文本的库
  - [Imagine](http://imagine.readthedocs.io/en/latest/index.html): 一个图像处理库
  - [Intervention Image](https://github.com/Intervention/image):PHP Image Manipulation <http://image.intervention.io>
  - [PHP Image Workshop](https://github.com/Sybio/ImageWorkshop): 另一个图像处理库
  - [Glide](https://github.com/thephpleague/glide):Wonderfully easy on-demand image manipulation library with an HTTP based API. <http://glide.thephpleague.com>
* 测试 Testing 测试代码和生成测试数据的库=
  - (<https://github.com/Codeception/AspectMock)[AspectMock>]: 一个PHPUnit/Codeception的模拟框架。
  - (<https://github.com/atoum/atoum)[Atoum>]: 一个简单的测试库
  - (<https://github.com/Codeception/Codeception)[Codeception>]: 一个全栈测试框架
  - (<https://github.com/sebastianbergmann/dbunit)[DBUnit>]: 一个PHPUnit的数据库测试库
  - [Faker](https://github.com/fzaninotto/Faker):Faker is a PHP library that generates fake data for you
  - [Alice](https://github.com/nelmio/alice):Expressive fixtures generator
  - (<https://github.com/InterNations/http-mock)[HTTP> Mock]: 一个在单元测试模拟HTTP请求的库
  - (<https://github.com/kahlan/kahlan)[Kahlan>]: 全栈Unit/BDD测试框架，内置stub，mock和代码覆盖率的支持
  - (<http://mink.behat.org/en/latest/)[Mink>]: Web验收测试
  - [Mockery](https://github.com/mockery/mockery):Mockery is a simple yet flexible PHP mock object framework for use in unit testing with PHPUnit, PHPSpec or any other testing framework. Its core goal is to offer a test double framework with a succinct API capable of clearly defining all possible object operations and interactions using a human readable Domain Specific Language (DSL). <http://docs.mockery.io/>
  - (<https://github.com/brianium/paratest)[ParaTest>]: 一个PHPUnit的并行测试库
  - (<https://github.com/peridot-php/peridot)[Peridot>]: 一个事件驱动开发的测试框架
  - (<https://github.com/mlively/Phake)[Phake>]: 另一个用于测试的模拟对象的库
  - (<https://github.com/danielstjules/pho)[Pho>]: 另一个行为驱动开发测试框架
  - (<https://github.com/php-mock/php-mock)[PHP-Mock>]: 一个基于PHP函数的模拟库
  - (<https://github.com/phpspec/phpspec)[PHPSpec>]: 一个基于功能点设计的单元测试库
  - (<https://qa.php.net/write-test.php)[PHPT>]: 一个使用PHP本身的测试工具
  - (<https://github.com/phpspec/prophecy)[Prophecy>]: 一个可选度很高的模拟框架
  - [Samsui](https://github.com/mauris/samsui): 另一个伪数据生成库
  - [VFS Stream](https://github.com/mikey179/vfsStream): 一个用于测试的虚拟文件系统流的包装器
  - [VFS](https://github.com/adlawson/php-vfs): 另一个用于测试虚拟的文件系统

```sh
composer create-project sylius/sylius-standard acme
cd acme
php bin/console sylius:install
yarn install
yarn run gulp
php bin/console server:start
open http://127.0.0.1:8000
```

## 持续集成 Continuous Integration

* [CircleCI](https://circleci.com): 一个持续集成平台
* [GitlabCi](https://about.gitlab.com/gitlab-ci/): 使用GitLab CI测试、构建、部署你的代码，像TravisCI
* [Jenkins](https://jenkins.io/index.html): 一个(<http://jenkins-php.org/index.html)[PHP>支持]的持续集成平台
* [JoliCi](https://github.com/jolicode/JoliCi): 一个用PHP编写的由Docker支持的持续集成的客户端
* [PHPCI](https://www.phptesting.org/): 一个PHP的开源的持续集成平台
* [SemaphoreCI](https://semaphoreci.com/): 一个开放源码和私人项目的持续集成平台
* [Shippable](https://app.shippable.com/): 一个基于开源和私人项目持续集成平台的docker
* [Sismo](http://sismo.sensiolabs.org/): 一个持续测试的服务库
* [Travis CI](https://travis-ci.org/): 一个持续集成平台
* [Wercker](http://www.wercker.com/): 一个持续集成平台

## 文档生成

* [APIGen](https://github.com/apigen/apigen): 另一个API文档生成器
* [daux.io](https://github.com/justinwalsh/daux.io): 一个使用Markdown文件的文档生成器
* [PHP Documentor 2](https://github.com/phpDocumentor/phpDocumentor2): 一个API文档生成器
* [phpDox](http://phpdox.de/): 一个PHP项目的文档生成器（不限于API文档）
* [Sami](https://github.com/FriendsOfPHP/Sami): 一个API文档生成器
* [swagger-php](https://github.com/zircote/swagger-php):A php swagger annotation and parsing library <http://zircote.com/swagger-php/>

## 安全

* 安全 Security 生成安全的随机数，加密数据，扫描漏洞的库
  - (<https://paragonie.com/project/halite)[Halite>]: 一个简单的使用[libsodium](https://github.com/jedisct1/libsodium)的加密库
  - (<https://github.com/ezyang/htmlpurifier)[HTML> Purifier]: 一个兼容标准的HTML过滤器
  - (<https://github.com/psecio/iniscan)[IniScan>]: 一个扫描PHP INI文件安全的库
  - (<https://github.com/jenssegers/optimus)[Optimus>]: 基于Knuth乘法散列方法的身份混淆工具
  - (<https://github.com/defuse/php-encryption)[PHP> Encryption]: 一个安全的PHP加密库
  - (<https://github.com/PHPIDS/PHPIDS)[PHP> IDS]: 一个结构化的PHP安全层
  - (<https://github.com/Herzult/php-ssh)[PHP> SSH]: 一个试验的面向对象的SSH包装库
  - [RandomLib](<https://github.com/ircmaxell/RandomLib): 一个生成随机数和字符串的库
  - [SecurityMultiTool](https://github.com/padraic/SecurityMultiTool): 一个PHP安全库
  - [SensioLabs Security Check](<https://security.sensiolabs.org/): 一个为检查Composer依赖提供安全建议的web工具
  - [TCrypto](https://github.com/timoh6/TCrypto): 一个简单的键值加密存储库
  - [True Random](https://github.com/pixeloution/true-random): 使用[www.random.org](https://www.random.org/)生成随机数的库
  - [VAddy](https://vaddy.net/): 一个持续安全的web应用测试平台
  - [Zed](https://www.owasp.org/index.php/OWASP_Zed_Attack_Proxy_Project): 一个集成的web应用渗透测试工具
  - [sensiolabs/security-checker](https://github.com/sensiolabs/security-checker):PHP frontend for security.sensiolabs.org <https://security.sensiolabs.org>
  - [phpseclib](https://github.com/phpseclib/phpseclib):PHP Secure Communications Library <http://phpseclib.sourceforge.net>
* 密码 Passwords 处理和存储密码的库和工具
  - (<https://github.com/timoh6/GenPhrase)[GenPhrase>]: 一个随机生成安全密码哈希的库
  - (<https://github.com/ircmaxell/password_compat)[Password> Compat]: 一个新的PHP5.5密码函数的兼容库
  - (<https://github.com/ircmaxell/password-policy)[Password> Policy]:  一个PHP和JavaScript的密码策略库
  - (<https://github.com/jeremykendall/password-validator)[Password> Validator]: 一个校验和升级密码哈希的库
  - (<https://github.com/hackzilla/password-generator)[Password-Generator>]: 一个生成随机密码的PHP库
  - (<https://github.com/ircmaxell/PHP-PasswordLib)[PHP> Password Lib]: 一个生成和校验密码的库
  - (<http://www.openwall.com/phpass/)[phpass>]: 一个便携式的密码哈希框架
  - [Zxcvbn PHP](https://github.com/bjeavons/zxcvbn-php): 一个基于Zxcvbn JS的现实的PHP密码强度估计库

## 性能

* 代码分析 Code Analysis 分析，解析和处理代码库的库和工具
  - (<https://github.com/polyfractal/athletic)[Athletic>]: 一个基于注释的基准检测库
  - (<https://github.com/Roave/BetterReflection)[Better> Reflection]: 基于AST的反射库，允许分析操作代码
  - (<https://codeclimate.com)[Code> Climate]: 一个自动代码审查工具
  - (<https://github.com/jakubledl/dissect)[Dissect>]: 一个词法和语法分析的工具集合
  - (<https://github.com/exakat/exakat)[Exakat>]: 一个PHP的静态分析引擎
  - (<https://github.com/phpro/grumphp)[GrumPHP>]: 一个用来保护代码质量的Composer插件
  - (<https://github.com/Trismegiste/Mondrian)[Mondrian>]: 使用图论的代码分析工具
  - (<https://github.com/scrutinizer-ci/php-analyzer)[PHP> Analyser]: 一个分析PHP代码查找缺陷和错误的库
  - (<https://github.com/squizlabs/PHP_CodeSniffer)[PHP> Code Sniffer]: 一个检测PHP、CSS和JS代码标准冲突的库
  - (<https://github.com/FriendsOfPHP/PHP-CS-Fixer)[PHP> CS Fixer]: 一个编码标准库
  - (<https://github.com/schmittjoh/php-manipulator)[PHP> Manipulator]: 一个分析和修改PHP源代码的库
  - (<https://phpmd.org/)[PHP> Mess Detector]: 一个扫描代码缺陷，次优代码，未使用的参数等等的库。
  - (<https://github.com/phpmetrics/PhpMetrics)[PHP> Metrics]: 一个静态测量库
  - (<https://github.com/monque/PHP-Migration)[PHP> Migration]: 一个PHP版本升级的静态分析库
  - [PHP Parser](https://github.com/nikic/PHP-Parser): A PHP parser written in PHP
  - (<https://github.com/QafooLabs/php-refactoring-browser)[PHP> Refactoring Browser]: 一个重构PHP代码的命令行工具集
  - (<https://github.com/tomzx/php-semver-checker)[PHP> Semantic Versioning Checker]: 一个比较两个源集和确定适当的应用语义版本的命令行实用程序
  - [Phan](https://github.com/etsy/phan): 一个基于PHP 7+和php-ast扩展的静态分析器
  - (<https://github.com/PHPCheckstyle/phpcheckstyle)[PHPCheckstyle>]: 一个帮助遵守特定的编码惯例的工具
  - (<https://github.com/sebastianbergmann/phpcpd)[PHPCPD>]: 一个检测复制和粘贴代码的库
  - (<https://github.com/mamuz/PhpDependencyAnalysis)[PhpDependencyAnalysis>]: 一个创建可定制依赖图的工具
  - (<https://github.com/sebastianbergmann/phploc)[PHPLOC>]: 一个快速测量PHP项目大小的工具
  - (<https://github.com/EdgedesignCZ/phpqa)[PHPQA>]: 一个用于运行质量保证工具的工具(phploc, phpcpd, phpcs, pdepend, phpmd, phpmetrics).
  - (<https://github.com/ircmaxell/PHPPHP)[PHPPHP>]: 一个PHP实现的PHP虚拟机
  - (<https://github.com/Corveda/PHPSandbox)[PHPSandbox>]: 一个PHP沙盒环境
  - (<https://github.com/Qafoo/QualityAnalyzer)[Qafoo> Quality Analyzer]: 一个可视化指标和源代码的工具
  - (<https://scrutinizer-ci.com/)[Scrutinizer>]: 一个审查PHP代码的web工具
  - (<https://github.com/devster/ubench)[UBench>]: 一个简单的微型基准检测库
  - [FrameworkBenchmarks](https://github.com/TechEmpower/FrameworkBenchmarks):Source for the TechEmpower Framework Benchmarks project <https://www.techempower.com/benchmarks/>
  - [php-static-analysis-tools](https://github.com/exakat/php-static-analysis-tools):A reviewed list of useful PHP static analysis tools
  - [phpAnalysis](https://github.com/dreamans/phpAnalysis):phpAnalysis - PHP应用性能分析系统
  - [psalm](https://github.com/vimeo/psalm):A static analysis tool for finding errors in PHP applications <https://psalm.dev>
  - [phpinsights](https://github.com/nunomaduro/phpinsights):💡Instant PHP quality checks from your console <https://phpinsights.com>
  - [PHPStan](https://github.com/phpstan/phpstan):PHP Static Analysis Tool - discover bugs in your code without running it! https://phpstan.org/
    + `composer require --dev phpstan/phpstan`
    + `vendor/bin/phpstan analyse src tests`
* Architectural 相关的设计模式库，组织代码编程的方法和途径
  - (<https://github.com/igorw/compose)[Compose>]: 一个功能组合库
  - (<https://github.com/domnikl/DesignPatternsPHP)[Design> Patterns PHP]: 一个使用PHP实现的设计模式存储库
  - (<http://yohan.giarel.li/Finite/)[Finite>]: 一个简单的PHP有限状态机
  - (<https://github.com/lstrojny/functional-php)[Functional> PHP]: 一个函数式编程库
  - (<https://github.com/endel/galapagos)[Galapagos>]: 语言转换进化
  - (<https://github.com/nikic/iter)[Iter>]: 一个使用生成器提供迭代原语的库
  - (<https://github.com/ircmaxell/monad-php)[Monad> PHP]: 一个简单Monad库
  - (<http://patchwork2.org/)[Patchwork>]: 一个重新定义用户的函数库
  - (<https://github.com/schmittjoh/php-option)[PHP> Option]: 一个可选的类型库
  - (<https://github.com/thephpleague/pipeline)[Pipeline>]: 一个管道模式的实现
  - (<https://github.com/bobthecow/Ruler)[Ruler>]: 一个简单的无状态的生产环境规则引擎
  - (<https://github.com/K-Phoen/rulerz)[RulerZ>]: 一个强大的规则引擎和规范模式的实现
* 调试和分析 Debugging and Profiling 调试和分析代码的库和工具
  - (<http://pecl.php.net/package/APM)[APM>]: 一个收集SQLite/MySQL/StatsD错误信息和统计信息的监控扩展
  - (<https://github.com/barbushin/php-console)[Barbushin> PHP Console]: 另一个使用Google Chrome的web调试控制台
  - [Blackfire.io](https://blackfire.io): 一个低开销的代码分析器
  - (<https://github.com/kint-php/kint)[Kint>]: 一个调试和分析工具
  - (<https://github.com/Seldaek/php-console)[PHP> Console]: 一个web调试控制台
  - [PHP Debug Bar](http://phpdebugbar.com/): 一个调试工具栏
  - (<https://github.com/phpbench/phpbench)[PHPBench>]: 一个基准测试框架
  - (<http://phpdbg.com/)[PHPDBG>]: 一个交互的PHP调试器
  - (<https://tideways.io/)[Tideways.io>]: Monitoring and profiling tool
  - (<https://github.com/nette/tracy)[Tracy>]: 一个简单的错误检测，写日志和时间测量库
  - [xDebug](https://github.com/xdebug/xdebug): 一个调试和分析PHP的工具
    + [jokkedk/webgrind](https://github.com/jokkedk/webgrind):Xdebug Profiling Web Frontend in PHP
  - [XHProf](https://github.com/phacility/xhprof): 一个最初由Facebook开发的分析工具
  - [Z-Ray](http://www.zend.com/en/products/server/z-ray): 一个调试和配置Zend服务器的工具
  - [didi/rdebug](https://github.com/didi/rdebug):Rdebug — Real Debugger
* 构建工具 Build Tools 项目构建和自动化工具
  - (<https://github.com/CHH/bob)[Bob>]: 一个简单的项目自动化工具
  - (<https://github.com/box-project/box2)[Box>]: 一个构建PHAR文件的工具
  - (<https://github.com/jonathantorres/construct)[Construct>]: 一个PHP项目的生成器
  - (<https://github.com/jaz303/phake)[Phake>]: 一个PHP克隆库
  - [Phing](https://github.com/phingofficial/phing) PHing Is Not GNU make; it's a PHP project build system or build tool based on Apache Ant. <https://www.phing.info>
* 任务运行器 Task Runners 自动运行任务的库
  - [Bldr](http://bldr.io/): 一个构建在Symfony组件上的PHP任务运行器
  - [Jobby](https://github.com/jobbyphp/jobby): 一个没有修改crontab的PHP定时任务管理器
  - [Robo](https://github.com/consolidation/Robo):Modern task runner for PHP <http://robo.li> 一个面向对象配置的PHP任务运行器
  - [Task](http://taskphp.github.io/): 一个灵感来源于Grunt和Gulp的纯PHP任务运行器
  - [roadrunner](https://github.com/spiral/roadrunner):High-performance PHP application server, load-balancer and process manager written in Golang
* 导航 Navigation 构建导航结构的工具
  - (<https://github.com/tackk/cartographer)[Cartographer>]: 一个站点地图生成库
  - (<https://github.com/KnpLabs/KnpMenu)[KnpMenu>]: 一个菜单库
* 资源管理 Asset Management 管理，压缩和最小化web站点资源的工具
  - (<https://github.com/tedious/JShrink)[JShrink>]: 一个JavaScript的最小化库
  - [minify](https://github.com/mrclay/minify):Combines. minifies, and serves CSS or Javascript files
  - (<https://github.com/meenie/munee)[Munee>]: 一个资源优化库
  - (<https://github.com/puli/repository)[Puli>]: 一个检测资源绝对路径的库
  - (<https://github.com/Bee-Lab/bowerphp)[BowerPHP>]: Bower的一个PHP实现，一个web包管理工具
* 地理位置 Geolocation 地理编码地址和使用纬度经度的库
  - [Geocoder](https://github.com/geocoder-php/Geocoder): The most featured Geocoder library written in PHP. <http://geocoder-php.org/Geocoder>
  - (<https://github.com/jmikola/geojson)[GeoJSON>]: 一个GeoJSON的实现
  - (<https://github.com/thephpleague/geotools)[GeoTools>]: 一个地理工具相关的库
  - [PHPGeo](https://github.com/mjaschen/phpgeo):Simple Geo Library for PHP
* 日期和时间 Date and Time 处理日期和时间的库
  - (<http://yohan.giarel.li/CalendR/)[CalendR>]: 一个日历管理库
  - [Carbon](https://github.com/briannesbitt/Carbon):A simple PHP API extension for DateTime. <http://carbon.nesbot.com/>
  - (<https://github.com/cakephp/chronos)[Chronos>]: 一个支持可变和不可变日期时间的DateTime API扩展
  - (<https://github.com/jasonlewis/expressive-date)[ExpressiveDate>]: 另一个日期时间API扩展
  - (<https://github.com/fightbulc/moment.php)[Moment.php>]: 灵感来源于Moment.js的PHP DateTime处理库，支持国际化
  - (<https://github.com/azuyalabs/yasumi)[Yasumi>]: 一个帮助你计算节日日期和名称的库
* 事件 Event 时间驱动或实现非阻塞事件循环的库
  - (<https://github.com/amphp/amp)[Amp>]: 一个事件驱动的不阻塞的I/O库
  - (<https://github.com/broadway/broadway)[Broadway>]: 一个事件源和CQRS(命令查询责任分离)库
  - (<https://github.com/cakephp/event)[Cake> Event]: 一个事件调度的库 (CP)
  - (<https://github.com/Wisembly/Elephant.io)[Elephant.io>]: 另一个web socket库
  - (<https://github.com/igorw/evenement)[Evenement>]: 一个事件调度的库
  - (<https://github.com/thephpleague/event)[Event>]: 一个专注于域名事件的库
  - (<https://github.com/hoaproject/Eventsource)[Hoa> EventSource]: 一个事件源库
  - (<https://github.com/hoaproject/Websocket)[Hoa> WebSocket]: 另一个web socket库
  - (<https://github.com/prooph/event-store)[Prooph> Event Store]: 一个持久化事件消息的事件源组件
  - (<https://github.com/ratchetphp/Ratchet)[Ratchet>]: 一个web socket库
  - [React](https://github.com/reactphp/react):Event-driven, non-blocking I/O with PHP. <https://reactphp.org>
  - (<https://github.com/asm89/Rx.PHP)[Rx.PHP>]: 一个reactive扩展库
  - [Workerman](https://github.com/walkor/Workerman): 一个事件驱动的不阻塞的I/O库
    + [phpsocket.io](https://github.com/walkor/phpsocket.io):A server side alternative implementation of socket.io in PHP based on workerman.
  - [OpenIBC/Ohsce](https://github.com/OpenIBC/Ohsce):PHP HI-REL SOCKET TCP/UDP/ICMP/Serial .高可靠性PHP通信&控制框架SOCKET-TCP/UDP/ICMP/硬件Serial-RS232/RS422/RS485 AND MORE! <http://www.ohsce.org>
* 日志 Logging 生成和处理日志文件的库
  - [Analog](https://github.com/jbroadway/analog): 一个基于闭包的微型日志包
  - [KLogger](https://github.com/katzgrau/KLogger): 一个易用的兼容PSR-3的日志类
  - [Monolog](https://github.com/Seldaek/monolog): Sends your logs to files, sockets, inboxes, databases and various web services <https://seldaek.github.io/monolog/>
  - [log4php](http://logging.apache.org/log4php/)
  - [easy-log-handler](https://github.com/EasyCorp/easy-log-handler):Human-friendly log files that make you more productive <https://easycorp.io/EasyLog>
  - [SeasLog](https://github.com/SeasX/SeasLog)：An effective,fast,stable log extension for PHP.<http://pecl.php.net/package/SeasLog> <http://neeke.github.io/SeasLog/>
* 电子商务 E-commerce 处理支付和构建在线电子商务商店的库和应用
  - [Money](https://github.com/moneyphp/money): 一个Fowler金钱模式的PHP实现
  - [omnipay](https://github.com/thephpleague/omnipay):A framework agnostic, multi-gateway payment processing library for PHP 5.3+ <http://omnipay.thephpleague.com/>
  - [Payum](https://github.com/payum/payum): 一个支付抽象库
  - [Shopware](https://github.com/shopware/shopware): 一个可高度定制的电子商务软件
  - [Swap](https://github.com/florianv/swap): 一个汇率库
  - [invoiceninja](https://github.com/invoiceninja/invoiceninja):Invoices, Expenses and Tasks built with Laravel and Flutter <https://invoiceninja.com>
  - [pay](https://github.com/yansongda/pay):优雅的 Alipay 和 WeChat 的支付 SDK 扩展包了
* PDF 处理PDF文件的库和软件
  - [Dompdf](https://github.com/dompdf/dompdf):HTML to PDF converter (PHP5) <http://dompdf.github.com/>
  - (<https://github.com/psliwa/PHPPdf)[PHPPdf>]: 一个将XML文件转换为PDF和图片的库
  - (<https://github.com/KnpLabs/snappy)[Snappy>]: 一个PDF和图像生成器库
  - (<https://github.com/wkhtmltopdf/wkhtmltopdf)[WKHTMLToPDF>]: 一个将HTML转换为PDF的工具
* 办公 Office Libraries for working with office suite documents.
  - (<https://github.com/Wisembly/ExcelAnt)[ExcelAnt>]: 一个操作Excel文档的库
  - (<https://github.com/PHPOffice/PHPPresentation)[PHPPowerPoint>]: 一个处理PPT文档的库
  - (<https://github.com/PHPOffice/PHPWord)[PHPWord>]: 一个处理Word文档的库
  - [PHPSpreadsheet](https://github.com/PHPOffice/PhpSpreadsheet): A pure PHP library for reading and writing spreadsheet files <https://phpspreadsheet.readthedocs.io>
* 数据库 Database 使用对象关系映射（ORM）或数据映射技术的数据库交互的库
  - (<https://github.com/etrepat/baum)[Baum>]: 一个Eloquent的嵌套集实现
  - (<https://github.com/cakephp/orm)[Cake> ORM]: 对象关系映射工具，利用DataMapper模式实现 (CP)
  - [Doctrine](http://www.doctrine-project.org/): 一个全面的DBAL和ORM
    + [lexer](https://github.com/doctrine/lexer):Base library for a lexer that can be used in Top-Down, Recursive Descent Parsers.
    + [inflector](https://github.com/doctrine/inflector):Doctrine Inflector is a small library that can perform string manipulations with regard to uppercase/lowercase and singular/plural forms of words.
    + [Atlantic18/DoctrineExtensions](https://github.com/Atlantic18/DoctrineExtensions):Doctrine2 behavioral extensions, Translatable, Sluggable, Tree-NestedSet, Timestampable, Loggable, Sortable
* 迁移 Migrations 帮助管理数据库模式和迁移的库
  - (<http://docs.doctrine-project.org/projects/doctrine-migrations/en/latest/toc.html)[Doctrine> Migrations]: 一个Doctrine的迁移库
  - (<https://github.com/illuminate/database)[Eloquent>]: 一个简单的ORM(L5)
  - (<https://github.com/corneltek/LazyRecord)[LazyRecord>]: 一个简单、可扩展、高性能的ORM
  - (<https://github.com/chanmix51/Pomm)[Pomm>]: 一个PostgreSQL对象模型管理器
  - (<http://propelorm.org/)[Propel>]: 一个快速的ORM，迁移库和查询构架器
  - (<https://github.com/Ocramius/ProxyManager)[ProxyManager>]: 一个为数据映射生成代理对象的工具集
  - (<http://redbeanphp.com/index.php)[RedBean>]: 一个轻量级，低配置的ORM
  - (<https://github.com/vlucas/spot2)[Spot2>]: 一个MySQL的ORM映射器
  - [Propel3](https://github.com/propelorm/Propel3):High performance data-mapper ORM with optional active-record traits for RAD and modern PHP 7.1+
  - (<https://github.com/icomefromthenet/Migrations)[Migrations>]: 一个迁移管理库
  - (<https://github.com/robmorgan/phinx)[Phinx>]: 另一个数据库迁移的管理库
  - (<https://github.com/davedevelopment/phpmig)[PHPMig>]: 另一个迁移管理库
  - (<https://github.com/ruckus/ruckusing-migrations)[Ruckusing>]: 基于PHP下ActiveRecord的数据库迁移，支持MySQL, Postgres, SQLite
* NoSQL NoSQL 处理NoSQL后端的库
  - (<https://github.com/thephpleague/monga)[Monga>]: 一个MongoDB抽象库
  - (<https://github.com/alexbilbie/MongoQB)[MongoQB>]: 一个MongoDB查询构建库
  - (<https://github.com/sokil/php-mongo)[PHPMongo>]: 一个MongoDB ORM.
  - (<https://github.com/nrk/predis)[Predis>]: 一个功能完整的Redis库
* 队列 Queue 处理事件和任务队列的库
  - [Bernard](https://github.com/bernardphp/bernard): 一个多后端抽象库
  - [BunnyPHP](https://github.com/jakubkulhan/bunny): 一个高性能的纯PHP AMQP(RabbitMQ)同步和异步(ReactPHP)库
  - [Pheanstalk](https://github.com/pda/pheanstalk): 一个Beanstalkd客户端库
  - [php-amqplib](https://github.com/php-amqplib/php-amqplib):The most widely used PHP client for RabbitMQ <http://www.rabbitmq.com/getstarted.html>
  - [Thumper](https://github.com/php-amqplib/Thumper): 一个RabbitMQ模式库
  - [Tarantool Queue](https://github.com/tarantool-php/queue): PHP绑定Tarantool队列
  - [php-resque](https://github.com/chrisboulton/php-resque):PHP port of resque (Workers and Queueing)
  - [php-delayqueue](https://github.com/chenlinzhong/php-delayqueue):基于redis实现高可用，易拓展，接入方便，生产环境稳定运行的延迟队列
* 搜索 Search 在数据上索引和执行查询的库和软件
  - [Elastica](https://github.com/ruflin/Elastica): ElasticSearch的客户端库
  - [ElasticSearch PHP](https://github.com/elastic/elasticsearch-php):Official PHP low-level client for Elasticsearch.
  - [Solarium](http://www.solarium-project.org/): (<http://lucene.apache.org/solr/)[Solr>]的客户端库
  - [Sphinx Search](https://github.com/ripaclub/sphinxsearch): Sphinx搜索库，提供SphinxQL索引和搜索的功能
  - [SphinxQL query builder](http://foolcode.github.io/SphinxQL-Query-Builder/): (<http://sphinxsearch.com/)[Sphinx>]搜索引擎的的查询库
* 命令行 Command Line 关于命令行工具的库
  - (<https://github.com/borisrepl/boris)[Boris>]: 一个微型PHP REPL
  - (<https://github.com/Cilex/Cilex)[Cilex>]: 一个构建命令行工具的微型框架
  - (<https://github.com/php-school/cli-menu)[CLI> Menu]: 一个构建CLI菜单的库
  - (<https://github.com/c9s/CLIFramework)[CLIFramework>]: 一个支持完全zsh／bash、子命令和选项约束的命令行框架，这也归功于phpbrew
  - [CLImate](https://github.com/thephpleague/climate):PHP's best friend for the terminal. <http://climate.thephpleague.com>
  - (<https://github.com/nategood/commando)[Commando>]: 另一个简单的命令行选择解析器
  - (<https://github.com/mtdowling/cron-expression)[Cron> Expression]: 一个计算cron运行日期的库
  - (<https://github.com/ulrichsg/getopt-php)[GetOpt>]: 一个命令行选择解析器
  - (<https://github.com/c9s/GetOptionKit)[GetOptionKit>]: 另一个命令行选择解析器
  - (<https://github.com/hoaproject/Console)[Hoa> Console]: 另一个命令行库
  - (<https://github.com/CHH/optparse)[OptParse>]: 另一个命令行选择解析器
  - (<https://github.com/mcrumm/pecan)[Pecan>]: 一个事件驱动和非阻塞的shell
  - [PsySH](https://github.com/bobthecow/psysh): A REPL for PHP <http://psysh.org>
  - (<https://github.com/MrRio/shellwrap)[ShellWrap>]: -一个简单的命令行包装库
  - [php-pm](https://github.com/php-pm/php-pm):PPM is a process manager, supercharger and load balancer for modern PHP applications.
* 身份验证和授权 Authentication and Authorization 实现身份验证和授权的库
  - (<https://github.com/dflydev/dflydev-hawk)[Hawk>]: 一个Hawk HTTP身份认证库
  - (<https://github.com/socialConnect/auth)[SocialConnect> Auth]: 一个开源的social sign (OAuth1\OAuth2\OpenID\OpenIDConnect)
  - [Json Web Token](https://github.com/lcobucci/jwt): 使用JSON Tokens进行身份验证和信息传输
  - (<https://github.com/BeatSwitch/lock)[Lock>]: 一种实现访问控制列表（ACL）系统的库
  - (<https://github.com/thephpleague/oauth1-client)[OAuth> 1.0 Client]: 一个OAuth 1.0客户端的库
  - [OAuth2 Server](http://oauth2.thephpleague.com/): 另一个OAuth2服务器实现
  - (<https://github.com/thephpleague/oauth2-client)[OAuth> 2.0 Client]: 一个OAuth 2.0客户端的库
  - (<http://bshaffer.github.io/oauth2-server-php-docs/)[OAuth2> Server]: 另一个OAuth2服务器实现
  - (<https://github.com/opauth/opauth)[Opauth>]: 一个多渠道的身份验证框架
  - (<https://github.com/Lusitanian/PHPoAuthLib)[PHP> oAuthLib]: 另一个OAuth库
  - (<https://cartalyst.com/manual/sentinel-social/2.0)[Sentinel> Social]: 一个社交网络身份验证库
  - (<https://cartalyst.com/manual/sentinel/2.0)[Sentinel>]: 一个混合的身份验证和授权的框架库
  - (<https://github.com/abraham/twitteroauth)[TwitterOAuth>]: 一个Twitter OAuth库
  - (<https://github.com/lyrixx/twitter-sdk)[TwitterSDK>]: 一个完全测试的Twitter SDK
* 标记 Markup 处理标记的库
  - (<https://github.com/cebe/markdown)[Cebe> Markdown]: 一个快速的可扩展的Markdown解析器
  - (<https://github.com/kzykhys/Ciconia)[Ciconia>]: 另一个支持Github Markdown风格的Markdown解析器
  - (<https://github.com/thephpleague/commonmark)[CommonMark> PHP]: 一个对[CommonMark spec](http://spec.commonmark.org/)全支持的Markdown解析器
  - (<https://github.com/milesj/decoda)[Decoda>]: 一个轻量级标记解析库
  - (<https://github.com/heyupdate/Emoji)[Emoji>]: 一个把Unicode字符和名称转换为表情符号图片的库
  - (<https://github.com/thephpleague/html-to-markdown)[HTML> to Markdown]: 将HTML转化为Markdown
  - (<https://github.com/Masterminds/html5-php)[HTML5> PHP]: 一个HTML5解析和序列化库
  - [Parsedown](https://github.com/erusev/parsedown):Markdown Parser in PHP <http://parsedown.org>
  - [PHP Markdown](https://github.com/michelf/php-markdown):Parser for Markdown and Markdown Extra derived from the original Markdown.pl by John Gruber. <http://michelf.ca/projects/php-markdown/>
  - [HyperDown](https://github.com/SegmentFault/HyperDown):一个结构清晰的，易于维护的，现代的PHP Markdown解析器
* 字符串 Strings 解析和处理字符串的库
  - (<https://github.com/jenssegers/agent)[Agent>]: 一个基于Mobiledetect的桌面／手机端user agent解析库
  - (<https://github.com/sensiolabs/ansi-to-html)[ANSI> to HTML5]: 一个将ANSI转化为HTML5的库
  - (<https://github.com/mikeemoo/ColorJizz-PHP)[Color> Jizz]: 处理和转换颜色的库
  - (<https://github.com/piwik/device-detector)[Device> Detector]: 另一个解析user agent字符串的库
  - (<https://github.com/hoaproject/Ustring)[Hoa> String]: 另一个UTF-8字符串库
  - [jieba-php](https://github.com/fukuball/jieba-php): "結巴"中文分詞：做最好的 PHP 中文分詞、中文斷詞組件。 / "Jieba" (Chinese for "to stutter") Chinese text segmentation: built to be the best PHP Chinese word segmentation module. <http://jieba-php.fukuball.com>
  - (<https://github.com/serbanghita/Mobile-Detect)[Mobile-Detect>]: 一个用于检测移动设备的轻量级PHP类(包括平板电脑)
  - (<https://github.com/nicolas-grekas/Patchwork-UTF8)[Patchwork> UTF-8]: 一个处理UTF-8字符串的便携库
  - (<https://github.com/cocur/slugify)[Slugify>]: 转换字符串到slug的库
  - (<https://github.com/jdorn/sql-formatter/)[SQL> Formatter]: 一个格式化SQL语句的库
  - (<https://github.com/danielstjules/Stringy)[Stringy>]: 一个多字节支持的字符串处理库
  - (<https://github.com/kzykhys/Text)[Text>]: 一个文本处理库
  - (<https://github.com/tobie/ua-parser/tree/master/php)[UA> Parser]: 一个解析user agent字符串的库
  - (<https://github.com/jbroadway/urlify)[URLify>]: 一个Django中URLify.js的PHP版本
  - (<https://github.com/ramsey/uuid)[UUID>]: 生成UUIDs的库
* 数字 Numbers 处理数字的库
  - (<https://github.com/gabrielelana/byte-units)[ByteUnits>]: 一个在二进制和度量系统中解析,格式化和转换字节单元的库
  - (<https://github.com/giggsey/libphonenumber-for-php)[LibPhoneNumber> for PHP]: 一个Google电话号码处理的PHP实现库
  - (<https://github.com/moontoast/math)[Math>]: 一个处理巨大数字的库
  - (<https://github.com/powder96/numbers.php)[Numbers> PHP]: 一个处理数字的库
  - [PHP Conversion](https://github.com/Crisu83/php-conversion): 另一个用于度量单位间转换的库
  - [PHP Units of Measure](https://github.com/triplepoint/php-units-of-measure): 一个计量单位转换的库
* 过滤和验证 Filtering and Validation 过滤和验证数据的库
  - [Cake Validation](https://github.com/cakephp/validation): 另一个验证库 (CP)
  - (<https://github.com/rdohms/DMS-Filter)[DMS> Filter]: 一个注释过滤库
  - (<https://github.com/ircmaxell/filterus)[Filterus>]: 一个简单的PHP过滤库
  - (<https://github.com/ronanguilloux/IsoCodes)[ISO-codes>]: 一个验证各种ISO和ZIP编码的库(IBAN, SWIFT/BIC, BBAN, VAT, SSN, UKNIN)
  - (<https://github.com/romaricdrigon/MetaYaml)[MetaYaml>]: 一个支持YAML,JSON和XML的模式验证库
  - [Respect Validation](https://github.com/Respect/Validation): The most awesome validation engine ever created for PHP <https://respect-validation.readthedocs.io/>
  - (<https://github.com/brandonsavage/Upload)[Upload>]: 一个处理文件上传和验证的库
  - (<https://github.com/vlucas/valitron)[Valitron>]: 另一个验证库
  - (<https://github.com/serkin/Volan)[Volan>]: 另一个简单的验证库
* 接口 API 开发REST-ful API的库和web工具
  - [API Platform](https://api-platform.com): 暴露出REST API的项目，包含JSON-LD, Hydra格式
  - [Apigility](https://github.com/zfcampus/zf-apigility-skeleton): 一个使用Zend Framework 2构建的API构建器
  - [Drest](https://github.com/leedavis81/drest): 一个将Doctrine实体暴露为REST资源节点的库
  - [HAL](https://github.com/blongden/hal): 一个超文本应用语言(HAL)构建库
  - [Hateoas](https://github.com/willdurand/Hateoas): 一个HOATEOAS REST web服务库
  - [Negotiation](https://github.com/willdurand/Negotiation): 一个内容协商库
  - [Restler](https://github.com/Luracast/Restler): 一个将PHP方法暴露为RESTful web API的轻量级框架
  - [wsdl2phpgenerator](https://github.com/wsdl2phpgenerator/wsdl2phpgenerator): 一个从SOAP WSDL文件生成PHP类的工具
* 缓存 Caching 缓存数据的库
  - [Alternative PHP Cache (APC)](http://php.net/manual/en/book.apc.php): 打开PHP操作码缓存
  - [APIx Cache](https://github.com/frqnck/apix-cache):  一个轻量级的PSR-6缓存
  - [CacheTool](https://github.com/gordalina/cachetool): 一个使用命令行清除apc/opcode缓存的工具
  - [Cake Cache](https://github.com/cakephp/cache): 一个缓存库 (CP)
  - [Doctrine Cache](https://github.com/doctrine/cache): 一个缓存库
  - [Metaphore](https://github.com/sobstel/metaphore): 一个缓存失效防范的库，使用信号标记阻止dogpile影响
  - [Stash](https://github.com/tedious/Stash): 另一个缓存库
  - [Zend Cache](https://github.com/zendframework/zend-cache): 另一个缓存库 (ZF2)
  - [symfony/cache](https://github.com/symfony/cache):The Cache component provides an extended PSR-6 implementation for adding cache to your applications. <https://symfony.com/cache>
  - [PeeHaa/OpCacheGUI](https://github.com/PeeHaa/OpCacheGUI):GUI for PHP's OpCache
  - [PHPSocialNetwork/phpfastcache](https://github.com/PHPSocialNetwork/phpfastcache):A PHP high-performance backend cache system. PhpFastCache is intended for use in speeding up dynamic web applications by alleviating database load. Well implemented, PhpFastCache can drops the database load to almost nothing, yielding faster page load times for users, better resource utilization. It is simple yet powerful. <https://www.phpfastcache.com>
* 数据结构和存储 Data Structure and Storage 实现数据结构和存储技术的库
  - (<https://github.com/morrisonlevi/Ardent)[Ardent>]: 一个数据结构库
  - (<https://github.com/cakephp/collection)[Cake> Collection]: 一个简单的集合库 (CP)
  - (<https://github.com/italolelis/collections)[Collections>]: 一个PHP的集合抽象库
  - [Fractal](https://github.com/thephpleague/fractal):Output complex, flexible, AJAX/RESTful data structures. <http://fractal.thephpleague.com>
  - (<https://github.com/akanehara/ginq)[Ginq>]: 另一个基于.NET实现的PHP的LINQ库
  - (<https://github.com/cweiske/jsonmapper)[JsonMapper>]: 一个将内嵌JSON结构映射为PHP类的库
  - (<https://github.com/DusanKasan/Knapsack)[Knapsack>]: 一个集合的库，灵感来自Clojure的相关库
  - (<https://github.com/schmittjoh/php-collection)[PHP> Collections]: 一个简单的集合库
  - (<https://github.com/TimeToogo/Pinq)[PINQ>]: 一个基于.NET实现的PHP的LINQ(Language Integrated Query)库
  - (<https://github.com/ScriptFUSION/Porter)[Porter>]: 数据导入的抽象框架
  - (<https://github.com/schmittjoh/serializer)[Serializer>]: 一个序列化和反序列化数据的库
  - (<https://github.com/Wisembly/Totem)[Totem>]: -一个管理和创建数据交换集的库
  - (<https://github.com/Athari/YaLinqo)[YaLinqo>]: 另一个PHP的LINQ库
  - (<https://github.com/zendframework/zend-serializer)[Zend> Serializer]: 另一个序列化和反序列化数据的库 (ZF2)
* 通知 Notifications 处理通知软件的库
  - (<https://github.com/jolicode/JoliNotif)[JoliNotif>]: 一个跨平台的桌面通知库(支持Growl, notify-send, toaster等)
  - (<https://github.com/filp/nod)[Nod>]: 一个通知库(Growl等)
  - (<https://github.com/Ph3nol/NotificationPusher)[Notification> Pusher]: 一个设备推送通知的独立库
  - (<https://github.com/mac-cain13/notificato)[Notificato>]: 一个处理推送通知的库
  - (<https://github.com/namshi/notificator)[Notificator>]: 一个轻量级的通知库
  - (<https://github.com/gomoob/php-pushwoosh)[Php-pushwoosh>]: 一个使用Pushwoosh REST Web服务轻松推送通知的PHP库
* 部署 Deployment 项目部署库
  - [Deployer](https://github.com/deployphp/deployer): 一个部署工具 <https://deployer.org/>
  - [Envoy](https://github.com/laravel/envoy): 一个用PHP运行SSH任务的工具
  - (<https://github.com/aerialls/Plum)[Plum>]: 一个部署库
  - (<https://github.com/tamagokun/pomander)[Pomander>]: 一个PHP应用部署工具
  - (<https://github.com/rocketeers/rocketeer)[Rocketeer>]: PHP世界里的一个快速简单的部署器
  - [Capistrano](link)
* 国际化和本地化 Internationalisation and Localisation 国际化(I18n)和本地化(L10n)的库
  - [Cake I18n](https://github.com/cakephp/i18n): 消息国际化和日期和数字的本地化 (CP)
* 第三方API Third Party APIs 访问第三方API的库
  - (<https://github.com/aws/aws-sdk-php)[Amazon> Web Service SDK]: PHP AWS SDK官方库
  - (<http://campaignmonitor.github.io/createsend-php/)[Campaign> Monitor]: Campaign Monitor官方PHP库
  - (<https://github.com/toin0u/DigitalOcean)[Digital> Ocean]: Digital Ocean API接口库
  - (<https://github.com/dropbox/dropbox-sdk-php)[Dropbox> SDK]: Dropbox SDK官方PHP库
  - (<https://github.com/dsyph3r/github-api3-php)[Github>]: 一个Github API交互库
  - [php-github-api](https://github.com/KnpLabs/php-github-api):A simple PHP GitHub API client, Object Oriented, tested and documented. For 5.5+.
  - (<https://github.com/gwkunze/S3StreamWrapper)[S3> Stream Wrapper]: Amazon S3流包装库
  - (<https://github.com/stripe/stripe-php)[Stripe>]: Stripe官方PHP库
  - (<https://github.com/twilio/twilio-php)[Twilio>]: Twilio官方PHP REST API
  - (<https://github.com/widop/twitter-oauth)[Twitter> OAuth]: 一个Twitter OAuth工作流交互库
  - (<https://github.com/widop/twitter-rest)[Twitter> REST]: 一个Twitter REST API交互库
* 扩展 Extensions 帮助构建PHP扩展的库
  - [PHP CPP](https://github.com/CopernicaMarketingSoftware/PHP-CPP):Library to build PHP extensions with C++ <http://www.php-cpp.com/>
  - [Zephir](https://github.com/phalcon/zephir):Zephir is a compiled high level language aimed to the creation of C-extensions for PHP <https://zephir-lang.com/>
* 机器学习
  - [PHP-ML](https://github.com/php-ai/php-ml): 一个机器学习的PHP库 PHP-ML - Machine Learning library for PHP
* 杂项 Miscellaneous 创建一个开发环境的软件
  - [Annotations](https://github.com/doctrine/annotations): 一个注释库(Doctrine的一部分)
  - [Cake Utility](https://github.com/cakephp/utility): 工具类如Inflector，字符串，哈希，安全和XML (CP)
  - [Chief](https://github.com/adamnicholson/Chief): 一个命令总线库
  - [ClassPreloader](https://github.com/ClassPreloader/ClassPreloader): 一个优化自动加载的库
  - [Country List](https://github.com/umpirsky/country-list): 所有带有名称和ISO 3166-1编码的国家列表
  - [countries](https://github.com/rinvex/countries)Rinvex Country is a simple and lightweight package for retrieving country details with flexibility. A whole bunch of data including name, demonym, capital, iso codes, dialling codes, geo data, currencies, flags, emoji, and other attributes for all 250 countries worldwide at your fingertips. https://rinvex.com/
  - (<https://github.com/mpratt/Embera)[Embera>]: 一个Oembed消费库
  - (<https://github.com/essence/essence)[Essence>]: 一个用于提取网络媒体的库
  - (<https://github.com/selvinortiz/flux)[Flux>]: 一个正则表达式构建库
  - (<https://github.com/alexandresalome/graphviz)[Graphviz>]: 一个图形库
  - (<https://github.com/Seldaek/jsonlint)[JSON> Lint]: 一个JSON lint工具
  - (<https://github.com/willdurand/JsonpCallbackValidator)[JSONPCallbackValidator>]: 验证JSONP回调的库
  - (<https://github.com/kakawait/Jumper)[Jumper>]: 一个远程服务执行库
  - (<https://github.com/raulfraile/Ladybug)[LadyBug>]: 一个dumper库
  - (<https://github.com/igorw/lambda-php)[Lambda> PHP]: 一个PHP中的Lambda计算解析器
  - (<https://github.com/beberlei/litecqrs-php)[LiteCQRS>]: 一个CQRS(命令查询责任分离)库
  - (<https://github.com/beberlei/metrics)[Metrics>]: 一个简单的度量API库
  - (<https://github.com/ARCANEDEV/noCAPTCHA)[noCAPTCHA>]: 一个帮助使用谷歌noCAPTCHA (reCAPTCHA)的工具
  - (<https://github.com/willdurand/nmap)[Nmap>]: 一个(<https://nmap.org/)[Nmap>] PHP包装器
  - (<https://github.com/euskadi31/Opengraph)[Opengraph>]: 一个开放图库
  - (<https://github.com/whiteoctober/Pagerfanta)[Pagerfanta>]: 一个分页库
  - (<https://github.com/Kitano/php-expression)[PHP> Expression]: 一个PHP表达式语言
  - (<https://github.com/eymengunay/php-passbook)[PHP> PassBook]: 一个iOS PassBook PHP库
  - (<https://github.com/ronanguilloux/php-gpio)[PHP-GPIO>]: 一个用于Raspberry PI的GPIO pin的库
  - (<https://github.com/phpcr/phpcr)[PHPCR>]: 一个Java内容存储库(JCR)的PHP实现
  - (<http://dunkels.com/adam/phpstack/)[PHPStack>]: 一个PHP编写的TCP/IP栈概念
  - (<https://github.com/koriym/print_o)[print_o>]: 一个对象图的可视化器
  - [Procrastinator](https://github.com/lstrojny/Procrastinator): 一个运行耗时任务的库
  - (<https://github.com/prooph/service-bus)[Prooph> Service Bus]: 轻量级的消息总线，支持CQRS和微服务
  - (<https://github.com/liip/RMT)[RMT>]: 一个编写版本和发布软件的库
  - [vobject>](https://github.com/fruux/sabre-vobject): 一个解析VCard和iCalendar对象的库
  - [Slimdump](https://github.com/webfactory/slimdump): 一个简单的MySQL dumper工具
  - [Spork](https://github.com/kriswallsmith/spork): 一个处理forking的库
  - [Sslurp](https://github.com/EvanDotPro/Sslurp): 一个使得SSL处理减少的库
  - [SuperClosure](https://github.com/jeremeamia/super_closure): 一个允许闭包序列化的库
  - [Underscore](http://anahkiasen.github.io/underscore-php/): 一个Undersccore JS库的PHP实现
  - [Whoops](https://github.com/filp/whoops):PHP errors for cool kids <http://filp.github.io/whoops/>

## RPC

* [Hprose-PHP](https://github.com/hprose/hprose-php)Hprose is a cross-language RPC
* [php-json-rpc](https://github.com/datto/php-json-rpc):Fully unit-tested JSON-RPC 2.0 for PHP
* [grpc-php](https://github.com/grpc/grpc-php):Repo for gRPC PHP

## 安装与环境

* PHP安装 PHP Installation 在你的电脑上帮助安装和管理PHP的工具
  - (<https://github.com/Homebrew/homebrew-php)[HomeBrew> PHP]: 一个HomeBrew的PHP通道
  - (<https://github.com/phpbrew/phpbrew)[PHP> Brew]: 一个PHP版本管理和安装器
  - (<https://github.com/php-build/php-build)[PHP> Build]: 另一个PHP版本安装器
  - (<https://github.com/CHH/phpenv)[PHP> Env]: 另一个PHP版本管理器
  - (<https://php-osx.liip.ch/)[PHP> OSX]: 一个OSX下的PHP安装器
  - (<https://github.com/jubianchi/phpswitch)[PHP> Switch]: 另一个PHP版本管理器
  - (<http://virtphp.org/)[VirtPHP>]: 一个创建和管理独立PHP环境的工具
* 开发环境 Development Environment 创建沙盒开发环境的软件和工具
  - (<https://www.ansible.com/)[Ansible>]: 一个非常简单的编制框架
  - (<http://phansible.com/)[Phansible>]: 一个用Ansible构建PHP开发虚拟机的web工具
  - (<http://getprotobox.com/)[Protobox>]: 另一个构建PHP开发虚拟机的web工具
  - (<https://puphpet.com/)[PuPHPet>]: 一个构建PHP开发虚拟机的web工具
  - (<https://puppet.com/)[Puppet>]: 一个服务器自动化框架和应用
  - (<https://www.vagrantup.com/)[Vagrant>]: 一个便携的开发环境工具
  - (<https://www.docker.com/)[Docker>]: 一个容器化的平台
* 虚拟机 Virtual Machines 相关的PHP虚拟机
  - [Hack](https://github.com/facebook/hhvm/tree/master/hphp/hack) Programming Productivity Without Breaking Things.<https://hacklang.org>
    + [Getting Started](https://docs.hhvm.com/hack/getting-started/getting-started)
    + [Tutorial](https://hacklang.org/tutorial.html)
  - [HHVM](https://github.com/facebook/hhvm):A virtual machine designed for executing programs written in  and PHP. <http://hhvm.com>
    + 用 Hack 开发 HHVM
    + HHVM 通过将 PHP 代码动态翻译成原生机器码而大幅提高速度。
    + HHVM 支持 PHP 和 PHP 方言 Hack 语言。
    + 开发团队宣布 HHVM v3.30 将是最后一个支持 PHP 的版本
    + [Docs](https://docs.hhvm.com/hhvm/getting-started/getting-started)
  - (<https://github.com/hippyvm/hippyvm)[HippyVM>]: 另一个PHP虚拟机
* 集成开发环境(IDE) Integrated Development Environment 支持PHP的集成开发环境
  - (<https://www.eclipse.org/downloads/)[Eclipse> for PHP Developers]: 一个基于Eclipse平台的PHP IDE
  - (<https://netbeans.org)[Netbeans>]: 一个支持PHP和HTML5的IDE
  - (<http://www.jetbrains.com/phpstorm/)[PhpStorm>]: 一个商业PHP IDE
* Web应用 Web Applications 基于Web的应用和工具
  - (<https://3v4l.org/)[3V4L>]: 一个在线的PHP和HHVM shell
  - (<https://dbv.vizuina.com/)[DBV>]: 一个数据库版本控制应用
  - (<https://github.com/CoderKungfu/php-queue)[PHP> Queue]: A一个管理后端队列的应用
  - (<https://github.com/sj26/mailcatcher)[MailCatcher>]: 一个抓取和查看邮件的web工具
  - (<https://github.com/cachethq/cachet)[Cachet>]: 开源状态页面系统
  - (<https://github.com/mnapoli/phpBeanstalkdAdmin)[phpBeanstalkdAdmin>]: 一个Beanstalkd的监控管理页面
  - (<https://github.com/ErikDubbelboer/phpRedisAdmin)[phpRedisAdmin>]: 一个用于管理[Redis](http://redis.io/)数据库的简单web界面
  - (<https://github.com/phppgadmin/phppgadmin)[phpPgAdmin>]: 一个PostgreSQL的web管理工具
  - (<https://github.com/phpmyadmin/phpmyadmin)[phpMyAdmin>]: 一个MySQL/MariaDB的web界面
  - (<https://www.adminer.org/)[Adminer>]: 一个数据库管理工具
  - (<https://github.com/getgrav/grav)[Grav>]: 一个现代的flat－file的CMS
  - [phpsysinfo](https://github.com/phpsysinfo/phpsysinfo):phpSysInfo: a customizable PHP script that displays information about your system nicely <http://phpsysinfo.github.com/phpsysinfo>
* 基础架构 Infrastructure 提供PHP应用和服务的基础架构
  - [appserver.io](http://appserver.io/): 一个用PHP写的多线程的PHP应用服务器
  - [php-pm](https://github.com/php-pm/php-pm): 一个PHP应用的进程管理器、修改器和负载平衡器
* PHP网站 PHP Websites PHP相关的有用的网站
  - [Nomad PHP](https://nomadphp.com/): 一个在线PHP学习资源
    + [Nomad PHP Lightning Talks](https://www.youtube.com/c/nomadphp): PHP社区成员10到15分钟的快速会谈
  - [PHP Best Practices](https://phpbestpractices.org/): 一个PHP最佳实践指南
  - [php-fig/fig-standards](https://github.com/php-fig/fig-standards):Standards either proposed or approved by the Framework Interop Group PHP框架交互组 <http://www.php-fig.org/>
  - [PHP Mentoring](https://php-mentoring.org/): 点对点PHP导师组织
  - [PHP Security](http://phpsecurity.readthedocs.io/en/latest/index.html): 一个PHP安全指南
  - [Securing PHP](http://securingphp.com/): 一个关于PHP安全和库的建议的简报
  - [PHP UG](http://php.ug): 一个帮助用户定位最近的PHP用户组(UG)的网站
  - [PHP Versions](http://phpversions.info/): 哪些版本的PHP可以用在哪几种流行的Web主机上的列表
  - [PHP Weekly](http://www.phpweekly.com/archive.html): 一个PHP新闻周刊
  - [PHPTrends](<https://phptrends.com/): 一个快速增长的PHP类库的概述
  - [Seven PHP](http://7php.com/): 一个PHP社区成员采访的网站
* 其他网站 Other Websites web开发相关的有用网站
  - [Semantic Versioning](http://semver.org/): 一个解析语义版本的网站
  - [Servers for Hackers](https://serversforhackers.com/): 一个关于服务器管理的新闻通讯
  - [The Open Web Application Security Project (OWASP)](https://www.owasp.org/index.php/Main_Page): 一个开放软件安全社区
  - [WebSec IO](https://websec.io/): 一个web安全社区资源
* PHP书籍 PHP Books
  - [Functional Programming in PHP](https://www.functionalphp.com/): 这本书将告诉你如何利用PHP5.3+的新功能的认识函数式编程的原则
  - [Grumpy PHPUnit](https://leanpub.com/grumpy-phpunit): 一本Chris Hartjes关于使用PHPUnit进行单元测试的书
  - [Mastering Object-Orientated PHP](http://www.brandonsavage.net): 一本Brandon Savage关于PHP面向对象的书
  - [Modern PHP New Features and Good Practices](http://shop.oreilly.com/product/0636920033868.do): 一本Josh Lockhart关于新的PHP功能和最佳做法的书
  - [Modernising Legacy Applications in PHP](https://leanpub.com/mlaphp): 一本Paul M.Jones关于遗留PHP应用进行现代化的书
  - [PHP 7 Upgrade Guide](https://leanpub.com/php7): 一本Colin O'Dell的包含所有PHP 7功能和改变的书
  - [PHP Pandas](https://daylerees.com/php-pandas/): 一本Dayle Rees关于如何学习写PHP的书
  - [Scaling PHP Applications](http://www.scalingphpbook.com): 一本Steve Corona关于扩展PHP应用程序的电子书
  - [Securing PHP: Core Concepts](https://leanpub.com/securingphp-coreconcepts): 一本Chris Cornutt关于PHP常见安全条款和实践的书
  - [Signaling PHP](https://leanpub.com/signalingphp): 一本Cal Evans关于在CLI脚本捕获PCNTL信号的书
  - [The Grumpy Programmer's Guide to Building Testable PHP Applications](https://leanpub.com/grumpy-testing): 一本Chris Hartjes关于构建PHP应用程序测试的书
  - [XML Parsing with PHP](https://www.phparch.com/books/xml-parsing-with-php/): 这本书涵盖的解析和验证XML文档，利用XPath表达式，使用命名空间，以及如何创建和修改XML文件的编程
  - [Domain-Driven Design in PHP](https://leanpub.com/ddd-in-php): 展示PHP DDD风格的实例
  - Morden php
  - [The Best PHP Books](https://github.com/manithchhuon/the-best-php-books)
  - [Head First PHP & MySQL](https://www.amazon.cn/gp/product/B004R1QIJU)
  - PHP and MySQL Web Development PHP 和 MySQL Web 开发
  - [Modern PHP](https://github.com/codeguy/modern-php)
  - 深入理解PHP:高级技巧、面向对象与核心技术
  - [深入PHP：面向对象、模式与实践 PHP Objects, Patterns, and Practice](https://www.amazon.cn/gp/product/B005D6IRRY)
    + [php-objects-patterns-practice-13](https://github.com/apress/php-objects-patterns-practice-13):Source code by Matt Zandstra
  - PHP 7: Real World Application Development
* 其他书籍 Other Books 与一般计算和web开发相关的书
  - [Understanding Computation](http://computationbook.com): Tom Stuart关于计算理论的一本书
* PHP视频 PHP Videos
  - [PHP UK Conference](https://www.youtube.com/user/phpukconference/videos): 一个PHP英国会议的视频集合
  - [Programming with Anthony](https://www.youtube.com/playlist?list=PLM-218uGSX3DQ3KsB5NJnuOqPqc5CW2kW): Anthony Ferrara的视频系列
  - [Taking PHP Seriously](https://www.infoq.com/presentations/php-history): 来自Facebook Keith Adams 讲述PHP优势
* https
  - [ca-bundle](https://github.com/composer/ca-bundle):Lets you find a path to the system CA bundle, and includes a fallback to the Mozilla CA bundle.

## 播客 PHP Podcasts

* [PHP Town Hall](https://phptownhall.com/): 一个随意的Ben Edmunds和Phil Sturgeon的PHP播客
* [PHP Roundtable](https://www.phproundtable.com/): PHP Roundtable是一个讨论PHP开发者关心话题的临时聚会

## 阅读

* [Composer Primer](https://daylerees.com/composer-primer/): Composer初级使用
* [Composer Stability Flags](https://igor.io/2013/02/07/composer-stability-flags.html): 一篇关于Composer稳定性标志的文章
* [Composer Versioning](https://igor.io/2013/01/07/composer-versioning.html): 一篇关于Composer版本的文章
* [Create Your Own PHP Framework](http://fabien.potencier.org/create-your-own-framework-on-top-of-the-symfony2-components-part-1.html): 一部Fabien Potencier的关于如何创建你自己的PHP框架的系列文章
* [Don't Worry About BREACH](http://blog.ircmaxell.com/2013/08/dont-worry-about-breach.html): 一篇关于BREACH攻击和CSRF令牌的文章
* [On PHP 5.3, Lambda Functions and Closures](http://fabien.potencier.org/on-php-5-3-lambda-functions-and-closures.html): 一篇关于lambda函数和闭包的文章
* [PHP Is Much Better Than You Think](http://fabien.potencier.org/php-is-much-better-than-you-think.html): 一篇关于PHP语言和生态圈的文章
* [PHP Package Checklist](http://phppackagechecklist.com/): 一个成功PHP包开发的清单
* [PHP Sucks! But I Like It!](http://blog.ircmaxell.com/2012/04/php-sucks-but-i-like-it.html): 一篇关于PHP利弊的文章
* [Preventing CSRF Attacks](http://blog.ircmaxell.com/2013/02/preventing-csrf-attacks.html): 一篇阻止CSRF攻击的文章
* [Seven Ways to Screw Up BCrypt](http://blog.ircmaxell.com/2012/12/seven-ways-to-screw-up-bcrypt.html): 一篇关于纠正BCrypt实现的文章
* [Use Env](https://seancoates.com/blogs/use-env/): 一篇关于使用unix环境帮助的文章
* [php-the-right-way](https://github.com/codeguy/php-the-right-way):An easy-to-read, quick reference for PHP best practices, accepted coding standards, and links to authoritative tutorials around the Web <https://www.phptherightway.com>
* [tipi](https://github.com/reeze/tipi):Thinking In PHP Internals, An open book on PHP Internals <http://www.php-internals.com/>
* [advanced-php](https://github.com/elarity/advanced-php):最近打算写一些php一些偏微妙的教程，比如关于多进程、socket等相关，都是自己的一些感悟心得
* [php architect Magazine](https://www.phparch.com/magazine/)
* [PHP Best Practices](https://phpbestpractices.org/)
* [PHP7-Data-Structures-and-Algorithms](https://github.com/PacktPublishing/PHP7-Data-Structures-and-Algorithms):PHP 7 Data Structures and Algorithm, published by Packt

## PHP内核

* [Disproving the Single Quotes Myth](http://nikic.github.io/2012/01/09/Disproving-the-Single-Quotes-Performance-Myth.html): 一篇关于单，双引号字符串性能的文章
* [How Big Are PHP Arrays (And Values) Really?](http://nikic.github.io/2011/12/12/How-big-are-PHP-arrays-really-Hint-BIG.html): 一篇关于数组原理的文章
* [How Foreach Works](http://stackoverflow.com/questions/10057671/how-does-php-foreach-actually-work/14854568#14854568): StackOverflow关于foreach回答的详情
* [How Long is a Piece of String](http://blog.golemon.com/2006/06/how-long-is-piece-of-string.html): 一篇关于字符串原理的文章
* [PHP Evaluation Order](https://gist.github.com/nikic/6699370): 一篇关于PHP评估顺序的文章
* [PHP Internals Book](http://www.phpinternalsbook.com): 一本由三名核心开发编写的关于PHP内核的在线书
* [PHP RFCs](https://wiki.php.net/rfc): PHP RFCs主页(请求注解)
* [Print vs Echo, Which One is Faster?](http://fabien.potencier.org/print-vs-echo-which-one-is-faster.html): 一篇关于打印和echo性能的文章
* [The PHP Ternary Operator. Fast or Not?](http://fabien.potencier.org/the-php-ternary-operator-fast-or-not.html): 一篇关于三元操作性能的文章
* [Understanding OpCodes](http://blog.golemon.com/2008/01/understanding-opcodes.html): 一篇关于opcodes的文章
* [When Does Foreach Copy?](http://nikic.github.io/2011/11/11/PHP-Internals-When-does-foreach-copy.html): 一篇关于foreach原理的文章
* [Why Objects (Usually) Use Less Memory Than Arrays](https://gist.github.com/nikic/5015323): 一篇关于对象和数组原理的文章
* [You're Being Lied To](http://blog.golemon.com/2007/01/youre-being-lied-to.html): 一篇关于内核ZVALs的文章
* [phpbook](https://github.com/walu/phpbook):PHP扩展开发及内核应用
* [read-php-src](https://github.com/hoohack/read-php-src)
* [php-langspec](https://github.com/php/php-langspec):PHP Language Specification <http://www.php.net>
* [php-ffi](https://github.com/dstogov/php-ffi):PHP Foreign Function Interface
* [php7-internal](https://github.com/laruence/php7-internal):Understanding PHP7 Internal articles
* [php7-internal](https://github.com/pangudashu/php7-internal):PHP7内核剖析
* [awesome-php](https://github.com/ziadoz/awesome-php):A curated list of amazingly awesome PHP libraries, resources and shiny things.
* [30-seconds-of-php-code](https://github.com/appzcoder/30-seconds-of-php-code):A curated collection of useful PHP snippets that you can understand in 30 seconds or less.

## 课程

* [dddinaction](https://github.com/fabwu/dddinaction):PHP implementation of the DDD in Practice Pluralsight course <https://www.pluralsight.com/courses/domain-driven-design-in-practice>

## trace

* [phptrace](https://github.com/Qihoo360/phptrace):A tracing and troubleshooting tool for PHP scripts.

## SMS

* [easy-sms](https://github.com/overtrue/easy-sms):📲 一款满足你的多种发送需求的短信发送组件

## network

* [spike](https://github.com/slince/spike):📣 A fast reverse proxy written in PHP that helps to expose local services to the internet

## graphql

* [graphql-php](https://webonyx.github.io/graphql-php/):A PHP port of GraphQL reference implementation <http://webonyx.github.io/graphql-php/>

## utilities

* [nette/utils](https://github.com/nette/utils):🛠 Lightweight utilities for string & array manipulation, image handling, safe JSON encoding/decoding, validation, slug or strong password generating etc. <https://doc.nette.org/utilspw>

## coding standard

* [EasyCodingStandard](https://github.com/Symplify/EasyCodingStandard):[READ-ONLY] Easiest way to start using PHP CS Fixer and PHP_CodeSniffer with 0-knowledge

```sh
# phpcs，phpcbf
composer global require "squizlabs/php_codesniffer=*"
~/.composer/vendor/bin/phpcs

# 安装phpmd
composer global require phpmd/phpmd
~/.composer/vendor/bin/phpmd

# 编写git pre-commit钩子
# .git/hooks/pre-commit，加入脚本内容：https://github.com/tangjun1990/php_tools/blob/master/pre-commit （注意修改脚本中的目录哟！）

# pre-commit
#!/usr/bin/env bash

PHP_CS="/Users/tangjun1/.composer/vendor/bin/phpcs"
PHP_MD="/Users/tangjun1/.composer/vendor/bin/phpmd"
HAS_PHP_CS=false
HAS_PHP_MD=false

if [ -x /Users/tangjun1/.composer/vendor/bin/phpcs ]; then
    HAS_PHP_CS=true
fi

if [ -x /Users/tangjun1/.composer/vendor/bin/phpmd ]; then
    HAS_PHP_MD=true
fi

if $HAS_PHP_CS; then
    git status --porcelain | grep -e '^[AM]\(.*\).php$' | cut -c 3- | while read line; do
        $PHP_CS "$line" --standard=PSR2;
        git add "$line";
    done
else
    echo ""
    echo "php-cs was not found, please run:"
    echo ""
    echo "  composer global require squizlabs/php_codesniffer=*"
    echo ""
fi

if $HAS_PHP_MD; then
    git status --porcelain | grep -e '^[AM]\(.*\).php$' | cut -c 3- | while read line; do
        $PHP_MD "$line" text codesize,unusedcode,naming;
        git add "$line";
    done
else
    echo ""
    echo "php-md was not found, please run:"
    echo ""
    echo "  composer global require phpmd/phpmd"
    echo ""
fi

chmod +x .git/hooks/pre-commit

# 手动执行命令来检查
~/.composer/vendor/bin/phpcs dirOrFile --standard=PSR2
~/.composer/vendor/bin/phpmd dirOrFile text codesize,unusedcode,naming
```

## 工具

* [PHAR](https://phar.io):The PHAR Installation and Verification Environment (PHIVE)
* [phpbu](https://github.com/sebastianfeldmann/phpbu):PHP Backup Utility - Creates and encrypts database and file backups, syncs your backups to other servers or cloud services and assists you monitor your backup process https://phpbu.de
* [rector](https://github.com/rectorphp/rector):Instant Upgrades for PHP Applications https://www.tomasvotruba.cz/blog/2018/02/19/rector-part-1-what-and-how/
* [expose](https://github.com/beyondcode/expose): A beautiful, fully open-source, tunneling service - written in pure PHP https://beyondco.de  expose features, like sharing your local sites, out of the box - without any additional setup required

* [docker-php-fpm-7.2](https://github.com/cytopia/docker-php-fpm-7.2):PHP-FPM 7.2 on CentOS 7 http://devilbox.org/
* [travis-ci-examples/php](https://github.com/travis-ci-examples/php):Example PHP project using Travis CI http://travis-ci.org
* [shlink](https://github.com/shlinkio/shlink):A self-hosted and PHP-based URL shortener with CLI and REST interfaces https://shlink.io

## 参考

* [Inversion of Control Containers and the Dependency Injection pattern](https://martinfowler.com/articles/injection.html)
* [clean-code-php](https://github.com/jupeter/clean-code-php):🛁 Clean Code concepts adapted for PHP
* [PHP7-Reference](tpunt/PHP7-Reference):An overview of the features, changes, and backward compatibility breakages in PHP 7
* [PHP 25周年纪事](https://www.jetbrains.com/lp/php-25/)

* [PHP 开发者如何做代码审查?](http://blog.csdn.net/gitchat/article/details/78050953)
