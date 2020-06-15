# log

日志文件提供精确的系统记录，根据日志最终定位到错误详情和根源

* 特点:描述一些离散的（不连续的）事件

## 作用

* 打印调试：即可以用日志来记录变量或者某一段逻辑。记录程序运行的流程，即程序运行了哪些代码，方便排查逻辑问题
* 问题定位：程序出异常或者出故障时快速的定位问题，方便后期解决问题。因为线上生产环境无法 debug，在测试环境去模拟一套生产环境，费时费力。所以依靠日志记录的信息定位问题，这点非常重要。还可以记录流量，后期可以通过 ELK（包括 EFK 进行流量统计）
* 用户行为日志：记录用户的操作行为，用于大数据分析，比如监控、风控、推荐等等。这种日志，一般是给其他团队分析使用，而且可能是多个团队，因此一般会有一定的格式要求，开发者应该按照这个格式来记录，便于其他团队的使用。当然，要记录哪些行为、操作，一般也是约定好的，因此，开发者主要是执行的角色
* 根因分析：即在关键地方记录日志。方便在和各个终端定位问题时，别人说时你的程序问题，你可以理直气壮的拿出你的日志说，看，我这里运行了，状态也是对的。这样，对方就会乖乖去定位他的代码，而不是互相推脱

## 原理

* 记录器 负责产生日志记录的原始信息，比如（原始信息，日志等级，时间，记录的位置）等信息
* 过滤器 负责按指定的过滤条件过滤掉我们不需要的日志（比如按日志等级过滤）
* 格式化器 :负责对原始日志信息按照想要的格式去格式化
* 输出器 负责将将要进行记录的日志（一般经过过滤器及格式化器的处理后）记录到日志目的地（例如：输出到文件中或者通过网络发送出去）

## 记录日志时机

* 系统初始化：系统或者服务的启动参数。核心模块或者组件初始化过程中往往依赖一些关键配置，根据参数不同会提供不一样的服务。务必在这里记录 INFO 日志，打印出参数以及启动完成态服务表述。
* 编程语言提示异常：如今各类主流的编程语言都包括异常机制，业务相关的流行框架有完整的异常模块。这类捕获的异常是系统告知开发人员需要加以关注的，是质量非常高的报错。应当适当记录日志，根据实际结合业务的情况使用 WARN 或者 ERROR 级别。
* 业务流程预期不符：除开平台以及编程语言异常之外，项目代码中结果与期望不符时也是日志场景之一，简单来说所有流程分支都可以加入考虑。取决于开发人员判断能否容忍情形发生。常见的合适场景包括外部参数不正确，数据处理问题导致返回码不在合理范围内等等。
* 系统核心角色，组件关键动作：系统中核心角色触发的业务动作是需要多加关注的，是衡量系统正常运行的重要指标，建议记录 INFO 级别日志，比如电商系统用户从登录到下单的整个流程；微服务各服务节点交互；核心数据表增删改；核心组件运行等等，如果日志频度高或者打印量特别大，可以提炼关键点 INFO 记录，其余酌情考虑 DEBUG 级别。
* 第三方服务远程调用：微服务架构体系中有一个重要的点就是第三方永远不可信，对于第三方服务远程调用建议打印请求和响应的参数，方便在和各个终端定位问题，不会因为第三方服务日志的缺失变得手足无措

## 日志配置

* 分级记录
    - DEBUG：DEUBG 级别的主要输出调试性质的内容，该级别日志主要用于在开发、测试阶段输出。该级别的日志应尽可能地详尽，开发人员可以将各类详细信息记录到 DEBUG 里，起到调试的作用，包括参数信息，调试细节信息，返回值信息等等，便于在开发、测试阶段出现问题或者异常时，对其进行分析。
    - INFO：INFO 级别的主要记录系统关键信息，旨在保留系统正常工作期间关键运行指标，开发人员可以将初始化系统配置、业务状态变化信息，或者用户业务流程中的核心处理记录到INFO日志中，方便日常运维工作以及错误回溯时上下文场景复现。建议在项目完成后，在测试环境将日志级别调成 INFO，然后通过 INFO 级别的信息看看是否能了解这个应用的运用情况，如果出现问题后是否这些日志能否提供有用的排查问题的信息。
    - WARN：WARN 级别的主要输出警告性质的内容，这些内容是可以预知且是有规划的，比如，某个方法入参为空或者该参数的值不满足运行该方法的条件时。在 WARN 级别的时应输出较为详尽的信息，以便于事后对日志进行分析。
    - ERROR：ERROR 级别主要针对于一些不可预知的信息，诸如：错误、异常等，比如，在 catch 块中抓获的网络通信、数据库连接等异常，若异常对系统的整个流程影响不大，可以使用 WARN 级别日志输出。在输出 ERROR 级别的日志时，尽量多地输出方法入参数、方法执行过程中产生的对象等数据，在带有错误、异常对象的数据时，需要将该对象一并输出。
    - DEBUG / INFO 的选择
        + DEBUG 级别比 INFO 低，包含调试时更详细的了解系统运行状态的东西，比如变量的值等等，都可以输出到 DEBUG 日志里。
        + INFO 是在线日志默认的输出级别，反馈系统的当前状态给最终用户看的。输出的信息，应该对最终用户具有实际意义的。
        + 从功能角度上说，INFO 输出的信息可以看作是软件产品的一部分，所以需要谨慎对待，不可随便输出。如果这条日志会被频繁打印或者大部分时间对于纠错起不到作用，就应当考虑下调为 DEBUG 级别。
            * 由于 DEBUG 日志打印量远大于 INFO，出于前文日志性能的考虑，如果代码为核心代码，执行频率非常高，务必推敲日志设计是否合理，是否需要下调为 DEBUG 级别日志。
            * 注意日志的可读性，不妨在写完代码 review 这条日志是否通顺，能否提供真正有意义的信息。
            * 日志输出是多线程公用的，如果有另外一个线程正在输出日志，上面的记录就会被打断，最终显示输出和预想的就会不一致
    - WARN / ERROR 的选择
        + 常见问题处理方法包括：
            * 增加判断处理逻辑，尝试本地解决：增加逻辑判断吞掉报警永远是最优选择抛出异常，交给上层逻辑解决
            * 抛出异常，交给上层逻辑解决
            * 记录日志，报警提醒
            * 使用返回码包装错误做返回
        + WARN 级别不会短信报警，ERROR 级别则会短信报警甚至电话报警，ERROR 级别的日志意味着系统中发生了非常严重的问题，必须有人马上处理，比如数据库不可用，系统的关键业务流程走不下去等等。错误的使用反而带来严重的后果，不区分问题的重要程度，只要有问题就error记录下来，其实这样是非常不负责任的，因为对于成熟的系统，都会有一套完整的报错机制，那这个错误信息什么时候需要发出来，很多都是依据单位时间内 ERROR 日志的数量来确定的。
    - 强调ERROR报警:ERROR的报出应该伴随着业务功能受损，即上面提到的系统中发生了非常严重的问题，必须有人马上处理
        + ERROR日志目标
            * 给处理者直接准确的信息：ERROR 信息形成自身闭环。
        + 问题定位：
            * 发生了什么问题，哪些功能受到影响
            * 获取帮助信息：直接帮助信息或帮助信息的存储位置
            * 通过报警知道解决方案或者找何人解决
* 日志文件放置于固定的目录中，按照一定的模板进行命名，推荐的日志文件名称:
    - 当前正在写入的日志文件名：<应用名>[-<功能名>].log 如：`example-server-book-service-access.log`
    - 已经滚入历史的日志文件名：<应用名>[-<功能名>].yyyy-MM-dd-hh.[滚动号].log 如：`example-server-book-service-access.2019-12-01-10.1.log`
* 使用参数化形式 {} 占位，[] 进行参数隔离，这样的好处是可读性更高，而且只有真正准备打印的时候才会处理参数。
* 日志时间 精确到毫秒 `yyyy-MM-dd HH:mm:ss.SSS`
* opentracing 标识:在分布式应用中，用户的一个请求会调用若干个服务完成，这些服务可能还是嵌套调用的，因此完成一个请求的日志并不在一个应用的日志文件，而是分散在不同服务器上不同应用节点的日志文件中。该标识是为了串联一个请求在整个系统中的调用日志。
    - 唯一字符串（trace id）
    - 调用层级（span id）
    - 通过搜索 trace id 就可以查到这个 trace id 标识的请求在整个系统中流转（处理）过程中产生的所有日志
* biz 标识:日志都是和业务相关联的，有时候是需要根据用户或者业务做聚类的，因此一次请求如果可以通过某项标识做聚类的时候，可以将聚类标识打印到日志中
    - 用户标识（user id）
    - 业务标识（biz id）
* 日志内容
   - 禁用 System.out.println 和 System.err.println
   - 变参替换日志拼接
   - 输出日志的对象，应在其类中实现快速的 toString 方法，以便于在日志输出时仅输出这个对象类名和 hashCode
   - 预防空指针:不要在日志中调用对象的方法获取值，除非确保该对象肯定不为 null，否则很有可能会因为日志的问题而导致应用产生空指针异常

```
// 正确示例，必须使用参数化信息的方式
log.debug("order is paying with userId:[{}] and orderId : [{}]",userId, orderId);
// 错误示例，不要进行字符串拼接,那样会产生很多 String 对象，占用空间，影响性能。及日志级别高于此级别也会进行字符串拼接逻辑。
log.debug("order is paying with userId: " + userId + " and orderId: " + orderId);

## 格式
2019-12-01 00:00:00.000|pid|log-level|[svc-name,trace-id,span-id,user-id,biz-id]|thread-name|package-name.class-name : log message
pid，pid
log-level，日志级别
svc-name，应用名称
trace-id，调用链标识
span-id，调用层级标识
user-id，用户标识
biz-id，业务标识
thread-name，线程名称
package-name.class-name，日志记录器名称
log message，日志消息体

2019-11-26 15:01:03.332|1543|INFO|[example-server-book-service,28f019d57b8336ab,630697c7f34ca4fa,105,45982043|XNIO-1 task-42]|c.p.f.w.pay.PayServiceImpl     : order is paying with userId: 105 and orderId: 45982043 # 固定分词索引，方便更快的查询分析
```

## 基础工具

* tail：Monitor Logs in Real Time `sudo tail -f /var/log/apache2/access.log` `sudo tailf /var/log/apache2/access.log`
    - -F 会监控是否创建了新日志(所谓新日志指的是同一个名字，但是 fd 不一样的日志文件)，并且会转而显示新日志的内容
    - 默认情况下 tail 命令只会显示文件最后 10 行的内容。如果只想在实时模式下查看最后两行的内容，那么可以连用 -n 和 -f 参数 `sudo tail -n2 -f /var/log/apache2/access.log`
* Multitail:Monitor Multiple Log Files in Real Time  `sudo multitail /var/log/apache2/access.log /var/log/apache2/error.log`
* lnav Command:Monitor Multiple Log Files in Real Time  `sudo lnav /var/log/apache2/access.log /var/log/apache2/error.log`
* less Command:Display Real Time Output of Log Files  `sudo less +F /var/log/apache2/access.log`

## 日志分析

* 如何将各种异构的日志文件导入到的数据库中，因为数据库首先需要按照固定格式创建表结构——这个过程通常称为 ETL。当数据导入后，可以采用大家熟悉的 SQL 进行日志的各种分析
* 数据规模比较大的情况，一般会使用分布式技术
    - 采用 hadoop 存储日志数据，后续采用 MapReduce 的 job 或者 spark 等进行分析
    - 如果希望采用 SQL 的方案来分析，可以采用 Hive 这些类似数据库的系统。这类系统适合于批量的进行分析。如果需要实时分析则需要引入一些实时的处理系统。
* 问题
    - 日志分析最大的问题是字段抽取复杂:对所有日志进行字段抽取的工作量很大，其次日志会随着产品版本更新发生变化，而且日志入库时很难预知后续的分析对字段的需求。因此需要一个功能强大且易用的日志抽取功能，以及搜索时按需临时抽取字段的能力。
    - 需要灵活可配置的分析能力。 如果每次分析都需要写代码进行,工作量大而且使用的门槛比较高
    - 实时性和性能问题。随着日志数据量的增长，想要实时监控分析数据，就必然会影响系统性能。这二者的平衡与优化
* 日志分析中的搜索引擎主要用于数据的读写：即实时的接收最新产生的日志数据，并进行索引，以实时或者准实时的方式提供给用户进行搜索和统计分析。

## Slf4j（Simple Logging Facade for Java ）

* Slf4j 为 Java 提供的简单日志门面
* Logback 是 Slf4j 的原生实现框架，同样也是出自 Log4j 一个人之手，但拥有比 Log4j 更多的优点、特性和更做强的性能，Logback 相对于 Log4j 拥有更快的执行速度

```xml
# 推荐使用 lombok（代码生成器） 注解 @lombok.extern.slf4j.Slf4j 来生成日志变量实例
<!-- https://mvnrepository.com/artifact/org.projectlombok/lombok -->
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <version>1.18.10</version>
    <scope>provided</scope>
</dependency>
```

## [allinurl / goaccess](https://github.com/allinurl/goaccess):GoAccess is a real-time web log analyzer and interactive viewer that runs in a terminal in *nix systems or through your browser. https://goaccess.io

* 完全实时 终端每200毫秒更新一次，HTML每秒更新一次。
* 需要最少的配置 直接接日志文件并运行，选择日志格式，然后让GoAccess解析访问日志并向您显示统计信息。
* 跟踪应用程序响应时间 跟踪服务请求所花费的时间。如果您要跟踪正在降低网站速度的页面，则非常有用。
* 几乎所有Web日志格式 GoAccess 允许使用任何自定义日志格式字符串。预定义的选项包括 Apache，Nginx，Amazon S3，Elastic Load Balancing，CloudFront等。
* 增量日志处理 需要数据持久性吗？GoAccess 能够通过磁盘 B + Tree 数据库增量处理日志。
* 仅一个依赖 GoAccess是用C语言编写的。要运行它，你只需要将 ncurses 作为依赖项
* 访问次数 按小时或日期来统计请求数，访问者，带宽等。
* 多个虚拟主机的指标 有多个虚拟主机？它具有一个面板，该面板显示哪个虚拟主机正在消耗大多数Web服务器资源。
* 颜色方案可定制的 Tailor GoAccess 可以适合您自己的颜色口味/方案。通过终端，或者简单地在HTML输出上应用样式表。
* 对大型数据集的支持 GoAccess 为大型数据集提供了一个磁盘B + Tree存储。
* Docker支持 能够从上游构建 GoAccess 的Docker映像。
* GoAccess允许任何自定义日志格式字符串。使用 -log-format 参数指定日志格式，预定义的选项包括但不限于：
    - COMBINED | 联合日志格式（Apache、Nginx等）
    - VCOMBINED | 支持虚拟主机的联合日志格式
    - COMMON | 通用日志格式
    - VCOMMON | 支持虚拟主机的通用日志格式
    - W3C | W3C 扩展日志格式
    - SQUID | Native Squid 日志格式
    - CLOUDFRONT | 亚马逊 CloudFront Web 分布式系统
    - CLOUDSTORAGE | 谷歌云存储
    - AWSELB | 亚马逊弹性负载均衡
    - AWSS3 | 亚马逊简单存储服务 (S3)
* 三种类型的存储方式
    - 默认哈希表 内存哈希表可以提供较好的性能，缺点是数据集的大小受限于物理内存的大小。GoAccess 默认使用内存哈希表。如果你的内存可以装下你的数据集，那么这种模式的表现非常棒。此模式具有非常好的内存利用率和性能表现。
    - Tokyo Cabinet 磁盘 B+ 树
使用这种模式来处理巨大的数据集，大到不可能在内存中完成任务。当数据提交到磁盘以后，B+树数据库比任何一种哈希数据库都要慢。但是，使用 SSD 可以极大的提高性能。往后您可能需要快速载入保存的数据，那么这种方式就可以被使用。
    - Tokyo Cabinet 内存哈希表 作为默认哈希表的替换方案。因为使用通用类型在内存表现以及速度方面都很平均
* 自定义 日志/日期 格式 配置文件位于：`%sysconfdir%/goaccess.conf` 或者 `~/.goaccessrc` `%sysconfdir%`` 可能是 `/etc/`, `/usr/etc/` 或者 `/usr/local/`etc/
    - time-format 参数 time-format 后跟随一个空格符，指定日志的时间格式，包含普通字符与特殊格式说明符的任意组合。他们都由百分号 (%)开始。参考 man strftime。%T 或者 %H:%M:%S 注意：如果给定的时间戳以微秒计算，则必须在 time-format 中使用参数 %f。
    - date-format 参数 date-format 后跟随一个空格符，指定日志的日期格式，包含普通字符与特殊格式说明符的任意组合。他们都由百分号 (%)开始。参考 man strftime。 注意：如果给定的时间戳以微秒计算，则必须在 date-format 中使用参数 %f 。
    - log-format 参数 log-format 后跟随一个空格符或者制表分隔符(\t)，用于指定日志字符串格式。
    - 特殊格式说明符
        + %x 匹配 time-format 和 date-format 变量的日期和时间字段。用于使用时间戳来代替日期和时间两个独立变量的场景。
        + %t 匹配 time-format 变量的时间字段。
        + %d 匹配 date-format 变量的日期字段。
        + %v 根据 canonical 名称设定的服务器名称(服务区或者虚拟主机)。
        + %e 请求文档时由 HTTP 验证决定的用户 ID。
        + %h 主机(客户端IP地址，IPv4 或者 IPv6)。
        + %r 客户端请求的行数。这些请求使用分隔符(单引号，双引号)引用的部分可以被解析。否则，需要使用由特殊格式说明符(例如：%m, - %U, %q 和 %H)组合格式去解析独立的字段。
        + 注意: 既可以使用 %r 获取完整的请求，也可以使用 %m, %U, %q and %H 去组合你的请求，但是不能同时使用。
        + %m 请求的方法。
        + %U 请求的 URL。
        + 注意: 如果查询字符串在 %U 中，则无需使用 %q。但是，如果 URL 路径中没有包含任何查询字符串，则你可以使用 %q 查询字符串将附加在请求后面。
        + %q 查询字符串。
        + %H 请求协议。
        + %s 服务器回传客户端的状态码。
        + %b 回传客户端的对象的大小。
        + %R HTTP 请求的 "Referer" 值。
        + %u HTTP 请求的 "UserAgent" 值。
        + %D 处理请求的时间消耗，使用微秒计算。
        + %T 处理请求的时间消耗，使用带秒和毫秒计算。
        + %L 处理请求的时间消耗，使用十进制数表示的毫秒计算。
        + %^ 忽略此字段。
        + %~ 继续解析日志字符串直到找到一个非空字符(!isspace)。
        + ~h 在 X-Forwarded-For (XFF) 字段中的主机(客户端 IP 地址，IPv4 或者 IPv6)。
* 参考
    - https://goaccess.cc/
    - https://github.com/allinurl/goaccess

```sh
# 源码安装
wget https://tar.goaccess.io/goaccess-1.3.tar.gz
tar -xzvf goaccess-1.3.tar.gz
cd goaccess-1.3/
./configure --enable-utf8 --enable-geoip=legacy
make
make install

# Debian / Ubuntu
echo "deb https://deb.goaccess.io/ $(lsb_release -cs) main" | sudo tee -a /etc/apt/sources.list.d/    goaccess.list
wget -O - https://deb.goaccess.io/gnugpg.key | sudo apt-key add -
sudo apt-get update
sudo apt-get install goaccess
## 注意事项： 要获得磁盘上的支持（Trusty + 或 Wheezy +），请运行：
sudo apt-get install goaccess-tcb

# CentOS / RedHat
yum install goaccess -y

# OS X / Homebrew
brew install goaccess

# 要输出到终端并生成交互式报告
goaccess access.log

# 生成 HTML 报告
goaccess --log-format=COMBINED access.log -a > report.html
# 生成 JSON 报告
goaccess --log-format=COMBINED access.log -a -d -o json > report.json
# 生成 CSV 文件
goaccess --log-format=COMBINED access.log --no-csv-summary -o csv > report.csv
# GoAccess 还为实时过滤和解析提供了极大的灵活性。例如，要从goaccess启动以来通过监视日志来快速诊断问题：
tail -f access.log | goaccess -
# 更妙的是，进行筛选，同时保持打开的管道保持实时分析，我们可以利用的 tail -f 和匹配模式的工具，如grep，awk，sed，等：
tail -f access.log | grep -i --line-buffered 'firefox' | goaccess --log-format=COMBINED -
# 或从文件的开头进行解析，同时保持管道处于打开状态并应用过滤器
tail -f -n +0 access.log | grep -i --line-buffered 'firefox' | goaccess -o report.html    --real-time-html -
# 监示多个日志文件
goaccess access.log access.log.1
# 实时 HTML 输出 生成实时HTML报告的过程与创建静态报告的过程非常相似。只--real-time-html需要使其实时即可。
goaccess --log-format=COMBINED access.log -o /usr/share/nginx/html/your_s
```

## Web Log

* 作用
    - 记录访问服务器的远程主机 IP 地址，可以得知浏览者来自何处
    - 记录浏览者访问 web 资源，可以了解网站哪些部分最受欢迎
    - 记录浏览者使用浏览器，可以根据大多数浏览者使用浏览器对站点进行优化
    - 记录浏览者访问时间
* Apache:在 httpd.conf 和引用的*.conf文件中查找 CustomLog "logs/access.log" combined
    - CustomLog 访问日志配置指令
    - logs/access.log 访问日志记录文件
    - combined 日志格式
* Nginx:在 nginx.conf 或引用的 *.conf 文件中查找 access_log logs/access.log main
    - access_log 访问日志配置指令
    - logs/access.log 访问日志记录文件
    - main 日志格式

```sh
# Apache
LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined
LogFormat "%h %l %u %t \"%r\" %>s %b" common

# nginx
log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
              '$status $body_bytes_sent "$http_referer" '
              '"$http_user_agent" "$http_x_forwarded_for"';

# 通用日志格式 common
127.0.0.1 - - [14/May/2017:12:45:29 +0800] "GET /index.html HTTP/1.1" 200 4286
远程主机IP            请求时间         时区  方法    资源      协议     状态码 发送字节

# 组合日志格式 combined
127.0.0.1 - - [14/May/2017:12:51:13 +0800] "GET /index.html HTTP/1.1" 200 4286 "http://127.0.0.1/" "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.116 Safari/537.36"
远程主机IP            请求时间         时区  方法    资源      协议     状态码 发送字节    referer字符           浏览器信息

# 日志状态码
2XX:
200: 请求成功
201: 创建成功
202: 接受请求
204: 无内容

3XX:
301: 永远重定向
302: 临时重定向
303: 临时重定向(HTTP1.1 同302)
307: 临时重定向(HTTP1.1 POST方法)

4XX:
400: 错误请求
401: 访问拒绝
403: 访问禁止
404: 未找到
405: 请求方法错误

5XX:
500: 服务器内部错误
503: 服务不可用
505: 网关超时


## 统计
# 查看访问 IP 地址
cat access.log|awk '{print $1}'
cat access.log|awk '{print $1}'|sort

# 查看每个 IP 地址访问次数
cat access.log|awk '{print $1}'|sort|uniq -c
cat access.log|awk '{print $1}'|sort|uniq -c|sort -nr
cat access.log|awk '{print $1}'|sort|uniq -c|sort -nr|head -10

# 统计总访问 IP 数量
cat access.log|awk '{print $1}'|sort|uniq -c|wc -l

# 访问指定时间后的日志
cat access.log|awk '$4>"[23/Aug/2014:23:58:00"'
cat access.log|awk '($4>"[23/Aug/2014:23:58:00"){print $1}'
cat access.log|awk '($4>"[23/Aug/2014:23:58:00"){print $1}'|sort|uniq -c|sort -nr

# 访问指定资源的日志
cat access.log|awk '$7 ~/.html$/'
cat access.log|awk '($7 ~/.html$/){print $1 " " $7 " " $9}'
cat access.log|awk '($7 ~/.js$/){print $10 " " $7}'|sort|uniq -c|sort -nr|head -10
cat access.log|awk '($10 > 10000 && $7 ~/.js$/){print $10 " " $7}'|sort|uniq -c|sort -nr|head -10

# 统计总流量
cat access.log|awk '{sum+=$10}END{print sum}'
cat access.log|awk '($7 ~/.css$/){sum+=$10}END{print sum}'
grep "04/May/2017" access.log|awk '($7 ~/.css$/){sum+=$10}END{print sum}'

# 状态码统计
cat access.log|awk '{print $9}' |sort|uniq -c|sort -nr
cat access.log|awk '($9 ~/^400$/)' | wc -l
cat access.log | awk '($4 ~/^\[04\/May\/2017/){print $9}'|sort|uniq -c|sort -nr
cat access.log | awk '$9 ~/400/ && $4 ~/^\[04\/May\/2017/'|wc -l
grep "04/May/2017" access.log | awk '{print $9}'|sort|uniq -c|sort -nr
```

## 日志服务

* SLS 阿里云日志服务
* ELK 通用日志解决方案

## 工具

* [Graylog2/graylog2-server](https://github.com/Graylog2/graylog2-server):Free and open source log management https://www.graylog.org/
* [klaussinani/signale](https://github.com/klaussinani/signale):👋 Hackable console logger
* [Graylog](https://www.graylog.org/products/open-source)
* [Nagios](https://www.nagios.org/downloads/)
* [Elastic Stack](https://www.elastic.co/products)
    - *Elasticsearch* 旨在帮助用户使用多种查询语言和类型在数据集中找出匹配项。速度是这个工具的最大优势。它可以扩展成由数百个服务器节点组成的集群，轻松处理 PB 级的数据。
    - *Kibana* 是一个可视化工具，它与 Elasticsearch 一起运行，允许用户分析他们的数据并构建强大的报告。当你第一次在服务器集群上安装 Kibana 引擎时，你将获得一个显示数据统计、图形甚至动画的界面。
    - *Logstash*，它是作为一个纯粹的、进入 Elasticsearch 数据库的服务器端管道。你可以使用各种编码语言和 API 集成 Logstash。这样，你的网站和移动应用程序中的信息就可以直接输入到强大的 Elastic Stalk 搜索引擎中。
* [LOGalyze](http://www.logalyze.com)
* [Fluentd](https://www.fluentd.org)
* [rsyslog/rsyslog](https://github.com/rsyslog/rsyslog):a Rocket-fast SYStem for LOG processing http://www.rsyslog.com

