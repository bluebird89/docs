# 日志

## 用途

* 记录访问服务器的远程主机 IP 地址，可以得知浏览者来自何处
* 记录浏览者访问 web 资源，可以了解网站哪些部分最受欢迎
* 记录浏览者使用浏览器，可以根据大多数浏览者使用浏览器对站点进行优化
* 记录浏览者访问时间

## 位置

* Apache:在 httpd.conf 和引用的*.conf文件中查找 CustomLog "logs/access.log" combined
    - CustomLog 访问日志配置指令
    - logs/access.log 访问日志记录文件
    - combined 日志格式
* Nginx:在 nginx.conf 或引用的 *.conf 文件中查找 access_log logs/access.log main
    - access_log 访问日志配置指令
    - logs/access.log 访问日志记录文件
    - main 日志格式

## 格式

```
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
```

## 统计

```sh
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
