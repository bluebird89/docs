# CGI(common gateway interface)

## PATH_INFO

* 每种动态语言（ PHP,Python 等）的代码文件需要通过对应的解析器才能被服务器识别，而 CGI 协议就是用来使解释器与服务器可以互相通信。通过标准输入（STDIN）和标准输出（STDOUT）和环境变量来与CGI程序间传递数据
* fork-and-execute:每当客户请求CGI的时候，WEB服务器就请求操作系统生成一个新的CGI解释器进程(如php-cgi.exe)，CGI 的一个进程则处理完一个请求后退出，下一个请求来时再创建新进程。
    - 有多少连接请求就会有多少cgi子进程，每个子进程都需要启动CGI解释器、加载配置等初始化工作，这是性能低下的原因。比如重新解析php.ini、重新载入全部扩展并重初始化全部数据结构
* 操作系统提供了许多环境变量，定义了程序的执行环境，应用程序可以存取它们
* Web服务器和CGI接口又另外设置了一些环境变量，PATHINFO是一个CGI 1.1的标准，经常用来做为传参载体，用来向CGI程序传递一些重要的参数 URL、查询字符串、POST数据、HTTP header
    - CONTENT_TYPE    这个环境变量的值指示所传递来的信息的MIME类型。目前，环境变量CONTENT_TYPE一般都是：application/x-www-form-urlencoded,他表示数据来自于HTML表单。
    - CONTENT_LENGTH  如果服务器与CGI程序信息的传递方式是POST，这个环境变量即使从标准输入STDIN中可以读到的有效数据的字节数。这个环境变量在读取所输入的数据时必须使用。
    - HTTP_COOKIE 客户机内的 COOKIE 内容。
    - HTTP_USER_AGENT 提供包含了版本数或其他专有数据的客户浏览器信息。
    - PATH_INFO   这个环境变量的值表示紧接在CGI程序名之后的其他路径信息。它常常作为CGI程序的参数出现。
    - QUERY_STRING    如果服务器与CGI程序信息的传递方式是GET，这个环境变量的值即使所传递的信息。这个信息经跟在CGI程序名的后面，两者中间用一个问号'?'分隔。
    - REMOTE_ADDR 这个环境变量的值是发送请求的客户机的IP地址，例如上面的192.168.1.67。这个值总是存在的。而且它是Web客户机需要提供给Web服务器的唯一标识，可以在CGI程序中用它来区分不同的Web客户机。
    - REMOTE_HOST 这个环境变量的值包含发送CGI请求的客户机的主机名。如果不支持你想查询，则无需定义此环境变量。
    - REQUEST_METHOD  提供脚本被调用的方法。对于使用 HTTP/1.0 协议的脚本，仅 GET 和 POST 有意义。
    - SCRIPT_FILENAME CGI脚本的完整路径
    - SCRIPT_NAME CGI脚本的的名称
    - SERVER_NAME 这是你的 WEB 服务器的主机名、别名或IP地址。
    - SERVER_SOFTWARE 这个环境变量的值包含了调用CGI程序的HTTP服务器的名称和版本号。例如，上面的值为Apache/2.2.14(Unix)
* PHP-CGI是PHP自带的FastCGI管理器
    - php-cgi变更php.ini配置后需重启php-cgi才能让新的php-ini生效，不可以平滑重启。
    - 直接杀死php-cgi进程，php就不能运行了。(PHP-FPM和Spawn-FCGI就没有这个问题，守护进程会平滑从新生成新的子进程）

## FastCGI

* 像是一个常驻(long-live)型的CGI，可以一直执行着，只要激活后，不会每次都要花费时间去fork一次，整个工作流程是这样：
    - Web Server启动时载入FastCGI进程管理器（IIS ISAPI或Apache Module)
    - FastCGI进程管理器自身初始化，启动多个CGI解释器进程(可见多个php-cgi)并等待来自Web Server的连接。
    - 当客户端请求到达Web Server时，FastCGI进程管理器选择并连接到一个CGI解释器。 Web server将CGI环境变量和标准输入发送到FastCGI子进程php-cgi。
    - FastCGI 子进程完成处理后将标准输出和错误信息从同一连接返回Web Server。当FastCGI子进程关闭连接时， 请求便告处理完成。FastCGI子进程接着等待并处理来自FastCGI进程管理器(运行在Web Server中)的下一个连接。 在CGI模式中，php-cgi在此便退出了。
    - 先启一个master，解析配置文件，初始化执行环境，然后再启动多个worker。当请求过来时，master会传递给一个worker，然后立即可以接受下一个请求
* 支持分布式的运算，即 FastCGI 程序可以在网站服务器以外的主机上执行并且接受来自其它网站服务器来的请求。
* 语言无关的、可伸缩架构的CGI开放扩展，其主要行为是将CGI解释器进程保持在内存中并因此获得较高的性能。众所周知，CGI解释器的反复加载是CGI性能低下的主要原因，如果CGI解释器保持在内存中并接受FastCGI进程管理器调度，则可以提供良好的性能、伸缩性、Fail- Over特性等等。
* 独立于核心web服务器运行，提供了一个比API更安全的环境。APIs把应用程序的代码与核心的web服务器链接在一起，这意味着在一个错误的API的应用程序可能会损坏其他应用程序或核心服务器。 恶意的API的应用程序代码甚至可以窃取另一个应用程序或核心服务器的密钥。
* 不依赖于任何Web服务器的内部架构，因此即使服务器技术的变化, FastCGI依然稳定不变。
* 多进程，所以比CGI多线程消耗更多的服务器内存，PHP-CGI解释器每进程消耗7至25兆内存，将这个数字乘以50或100就是很大的内存数。
    - Nginx 0.8.46+PHP 5.2.14(FastCGI)服务器在3万并发连接下，开启的10个Nginx进程消耗150M内存（15M*10=150M），开启的64个php-cgi进程消耗1280M内存（20M*64=1280M），加上系统自身消耗的内存，总共消耗不到2GB内存。如果服务器内存较小，完全可以只开启25个php-cgi进程，这样php-cgi消耗的总内存数才500M。
* fastCGI是nginx和php之间的一个通信接口，该接口实际处理过程通过启动php-fpm进程来解析php脚本，即php-fpm相当于一个动态应用服务器，从而实现nginx动态解析php。因此，如果nginx服务器需要支持php解析
    - 需要在nginx.conf中增加php的配置：将php脚本转发到fastCGI进程监听的IP地址和端口（php-fpm.conf中指定）。
    - php安装的时候，需要开启支持fastCGI选项，并且编译安装php-fpm补丁/扩展，
    - 需要启动php-fpm进程，才可以解析nginx通过fastCGI转发过来的php脚本。

## PHP-FPM

* PHP-FPM是一个PHP FastCGI管理器，针对于PHP的Fastcgi的一种实现，负责管理一个进程池，来处理来自Web服务器的请求
* 提供了更好的PHP进程管理方式，可以有效控制内存和进程、可以平滑重载PHP配置
    - 配置都是在PHP-FPM.ini的文件内，而启动、重启都可以从php/sbin/PHP-FPM中进行。更方便的是修改php.ini后可以直接使用PHP-FPM reload进行加载，无需杀掉进程就可以完成php.ini的修改加载
    - 控制的进程cpu回收的速度比较慢,内存分配的很均匀。
* 当PHP需要在Apache服务器下运行时，一般来说，它可以模块的形式集成， 此时模块的作用是接收Apache传递过来的PHP文件请求，并处理这些请求， 然后将处理后的结果返回给Apache。如果在Apache启动前在其配置文件中配置好了PHP模块， PHP模块通过注册apache2的ap_hook_post_config挂钩，在Apache启动的时候启动此模块以接受PHP文件的请求。
* Apache的Hook机制
    - 把php作为apache的一个子模块来运行。php5_module通过sapi将数据传给php解析器来解析php代码
    - Apache 允许模块(包括内部模块和外部模块，例如mod_php5.so，mod_perl.so等)将自定义的函数注入到请求处理循环中。 换句话说，模块可以在Apache的任何一个处理阶段中挂接(Hook)上自己的处理函数，从而参与Apache的请求处理过程。
    - mod_php5.so/ php5apache2.dll就是将所包含的自定义函数，通过Hook机制注入到Apache中，在Apache处理流程的各个阶段负责处理php请 求。
* php-fpm是一个完全独立的程序,不依赖php-cgi,也不依赖php.因为php-fpm是一个内置了php解释器的FastCGI服务,启动时能够自行读取php.ini配置和php-fpm.conf配置.
    - 一个master进程,支持多个pool,每个pool由master进程监听不同的端口,pool中有多个worker进程.
        + 每个worker进程都内置PHP解释器,并且进程常驻后台,支持prefork动态增加.
        + 每个worker进程支持在运行时编译脚本并在内存中缓存生成的opcode来提升性能.
        + 每个worker进程支持配置响应指定请求数后自动重启,master进程会重启挂掉的worker进程.
        + 每个worker进程能保持一个到MySQL/Memcached/Redis的持久连接,实现"连接池",避免重复建立连接,对程序透明.
    - master进程采用epoll模型异步接收和分发请求,listen监听端口,epoll_wait等待连接,
        + 然后分发给对应pool里的worker进程,worker进程accpet请求后poll处理连接,
        + 如果worker进程不够用,master进程会prefork更多进程,
        + 如果prefork达到了pm.max_children上限,worker进程又全都繁忙,
        + 这时master进程会把请求挂起到连接队列backlog里(默认值是511).
* PHP中cgi.fix_pathinfo配置项打开
    - PHP会去根据CGI规范来检查SCRIPT_FILENAME中那部分是访问脚本和PATH_INFO(ini配置解释)
    - 并根据SCRIPT_NAME来修改PATH_INFO(和PATH_TRANSLATED)为正确的值然后, 就只要添加一个FASTCGI_PARAM项就好了

```
LoadModule php5_module C:/php/php5apache2_2.dll

location ~ \.php {
    fastcgi_pass   127.0.0.1:9000;
    fastcgi_index  index.php;
    #先加载默认后解析赋值
    include        fastcgi_params;
    #正则解析路径
    fastcgi_split_path_info ^((?U).+\.php)(/?.+)$;
    fastcgi_param  PATH_INFO        $fastcgi_path_info;
    fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
}
```
