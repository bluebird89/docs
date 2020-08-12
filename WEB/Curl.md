# [curl/curl](https://github.com/curl/curl)

curl is used in command lines or scripts to transfer data.发出网络请求，然后得到和提取数据，显示在"标准输出"（stdout）上面.Curl 是一个命令行工具，用来通过 HTTP（s），FTP 等其它几十种你可能尚未听说过的协议来发起网络请求。

## 使用

* -A 指定客户端的用户代理标头，即User-Agent
* -X/--request [GET|POST|PUT|DELETE|…]  指定请求的 HTTP 方法
* -x参数指定 HTTP 请求的代理
* -H/--header                           指定请求的 HTTP Header
* -d/--data                             发送 POST 请求的数据体
* -v/--verbose                          输出详细的返回信息
* -u/--user                             指定账号、密码
* -b/--cookie                           读取 cookie
* -i:--include  打印出服务器回应的 HTTP 标头
* -I参数向服务器发出 HEAD 请求，然会将服务器返回的 HTTP 标头打印出来
* -v:--verbose   输出通信的整个过程，用于调试
* -e 用来设置 HTTP 的标头Referer，表示请求的来源
* -F 用来向服务器上传二进制文件
* -G 用来构造 URL 的查询字符串
* -k参数指定跳过 SSL 检测
* --limit-rate用来限制 HTTP 请求和回应的带宽，模拟慢网速的环境
* -o 将服务器的回应保存成文件，等同于wget命令
* -O 将服务器回应保存成文件，并将 URL 的最后部分当作文件名
* -s 将不输出错误和进度信息
* -u 用来设置服务器认证的用户名和密码

```sh
curl http://www.baidu.com
curl http://www.baidu.com > /tmp/baidu.html # save html
curl -o /tmp/baidu.html http://www.baidu.com # 保存文件

curl -A 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36' https://google.com

curl -b 'foo1=bar' -b 'foo2=baz' https://google.com # curl发送cookie，具体的cookie的值，可以从http response头信息的`Set-Cookie`字段中得到
curl -b cookies.txt http://example.com # 使用这个文件作为cookie信息，进行后续的请求
curl -c cookies http://example.com # 可以保存服务器返回的cookie到文件

curl -d'login=emma＆password=123'-X POST https://google.com/login
curl -d 'login=emma' -d 'password=123' -X POST  https://google.com/login
curl -d '@data.txt' https://google.com/login
curl -X POST--data-urlencode "date=April 1" example.com/form.cgi # 会自动将发送的数据进行 URL 编码
curl -X DELETE www.example.com

curl --header "Content-Type:application/json" http://example.com    # 增加一个头信息
curl -e 'https://google.com?q=example' https://www.example.com
curl -H 'Referer: https://google.com?q=example' https://www.example.com
curl -d '{"login": "emma", "pass": "123"}' -H 'Content-Type: application/json' https://google.com/login
curl -X POST \
  http://localhost:8080/ \
  -H 'cache-control: no-cache' \
  -H 'Accept-Language: en-US' \
  -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
  -F 'html=@/example'

curl -F 'file=@photo.png' https://google.com/profile #  MIME 类型设为application/octet-stream。
curl -F 'file=@photo.png;type=image/png' https://google.com/profile

curl -i  http://www.baidu.com  # 显示http response的头信息
curl -I https://www.example.com
curl -v www.baidu.com #  -v参数可以显示一次http通信的整个过程，包括端口连接和http request头信息
curl --trace output.txt www.baidu.com # 查看更详细的通信过程
curl --trace-ascii output.txt www.baidu.com

curl -G -d 'q=kitties' -d 'count=20' https://google.com/search # 实际请求的 URL 为https://google.com/search?q=kitties&count=20。如果省略--G，会发出一个 POST 请求

curl -L www.sina.com # 网址自动跳转的 跳转到新网址
curl -u 'bob:12345' https://google.com/login # 设置用户名为bob，密码为12345，然后将其转为 HTTP 标头Authorization: Basic Ym9iOjEyMzQ1

curl -x socks5://james:cats@myproxy.com:8080 https://www.example.com

brew reinstall curl --with-openssl --with-nghttp2
brew install nghttp2
brew install curl-openssl
echo ‘export PATH="/usr/local/opt/curl-openssl/bin:$PATH"’ >> ~/.bash_profile

curl --http2 -I https://nghttp2.org/

# application/x-www-form-urlencoded
curl localhost:3000/api/basic -X POST -d 'hello=world&xxx=yyy&a[]=ooo&a[]=mmm'

# multipart/form-data
curl localhost:3000/api/multipart -F raw=@raw.data -F hello=world

# application/json
curl localhost:3000/api/json -X POST -d '{"hello": "world"}' --header "Content-Type: application/json"
curl localhost:3000/api/json -X POST -d @data.json --header "Content-Type: application/json"
```

## Notice

* network
    - ping
    - network timeout

## 参考

* [文档](https://ec.haxx.se/)
* [Gitbook](https://www.gitbook.com/book/bagder/everything-curl/details)
