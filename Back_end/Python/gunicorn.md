# [benoitc/gunicorn](https://github.com/benoitc/gunicorn)

gunicorn 'Green Unicorn' is a WSGI HTTP Server for UNIX, fast clients and sleepy applications. http://www.gunicorn.org

## 原理

pre-fork模型中

* master（gunicorn 中Arbiter）会fork出指定数量的worker进程
* worker进程在同样的端口上监听，谁先监听到网络连接请求，谁就提供服务，这也是worker进程之间的负载均衡。
