# WEB服务

收用户请求，然后处理请求，最后将处理结果返回给用户

- Apache拥有丰富的模块组件支持，稳定性强，BUG少，动态内容处理强。
- Nginx轻量级，占用资源少，负载均衡，高并发处理强，静态内容处理高效。

## 两者区别

### 对连接的处理方式
- Apache提供一系列多重处理模块，通过这些多重处理模块来使用操作系统的资源，对进程和线程池进行管理，控制处理用户请求。三种多重处理模块：mpm_prefork、mpm_worker、mpm_envent，
    + mpm_prefork：模块产生众多子进程，每个子进程是单线程的，每个线程链接一个请求，如此一对一的关系。所以如果请求数大于进程数时，服务器的性能就表现得差强人意了。
    + mpm_worker：worker中子进程是多线程的，每个线程管理一个用户连接。线程数要多于进程数量，这也就意味着新的连接能立刻得到一个空闲的线程，而不用等待进程空闲。
    + mpm_event：该模块与worker相似，区别在于event可以处理长连接(keep-alive)，以避免线程被请求长期占用而造成资源浪费，同时也增强了高并发场景下的请求处理能力。 

- Nginx是通过异步的、非阻塞的、事件驱动的方式在实现的。Nginx的工作进程是单线程的，每个线程可以异步的处理大量的用户请求。下面是Nginx的工作原理图：
![Nginx的工作原理](..\_static\nginx.png)

### 静态与动态内容的处理
- Apache具有内置的解析和执行各种动态脚本语言（包括PHP，Python和Perl）的功能，无需借助外部处理器。
- Nginx处理动态内容的效率并不高,且需借助外部的处理器。


##  安装

```sh
brew install nginx
brew services start nginx # default port 8080  
/usr/local/etc/nginx/nginx.conf
// /usr/local/etc/nginx/servers/
// Docroot 
/usr/local/var/www
```

域名购买：GoDaddy

"L2TP" 或者 "Shadowsocks" anyconnnect

nginx 提供php python
