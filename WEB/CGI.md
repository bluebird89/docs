# CGI标准

## PATH_INFO

PATHINFO是一个CGI 1.1的标准，经常用来做为传参载体，
在Apache中, 当不加配置的时候, 对于PHP脚本, AcceptPathInfo是默认接受的，
对于Nginx下, 是不支持PATHINFO 的, 也就是需要设置才能使用PATHINFO模式.
可以使用PATH_INFO来代替Rewrite来实现伪静态页面, 很多PHP框架也使用PATHINFO模式来作为路由载体

php内置解析
PHP中cgi.fix_pathinfo配置项打开
PHP会去根据CGI规范来检查SCRIPT_FILENAME中那部分是访问脚本和PATH_INFO(ini配置解释)
并根据SCRIPT_NAME来修改PATH_INFO(和PATH_TRANSLATED)为正确的值然后, 就只要添加一个FASTCGI_PARAM项就好了
```
location ~ .php {
    fastcgi_index index.php;
    fastcgi_pass 127.0.0.1:9000;
    include fastcgi_params;
    fastcgi_param PATH_INFO $fastcgi_script_name;
}
```

nginx正则解析

```
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
