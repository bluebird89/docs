# Wnmp

Version of nginx for Windows uses the native Win32 API (not the Cygwin emulation layer). Only the select() connection processing method is currently used, so high performance and scalability should not be expected. 

## 安装

* 下载nginx、php
* 配置nginx.conf

```sh
unzip nginx-1.13.10.zip
cd nginx-1.13.10
start nginx # 启动nginx
nginx -s reload # 修改配置后重新加载生效
nginx -s reopen # 重新打开日志文件
nginx -t -c /path/to/nginx.conf # 测试nginx配置文件是否正确
nginx -s stop  #快速停止nginx
nginx -s quit # 完整有序的停止nginx

tasklist /fi "imagename eq nginx.exe" # 查看进程，没有查看error.log
```

## 参考

* [nginx for Windows](http://nginx.org/en/docs/windows.html)
