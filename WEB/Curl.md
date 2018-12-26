# [curl/curl](https://github.com/curl/curl)

curl is used in command lines or scripts to transfer data.发出网络请求，然后得到和提取数据，显示在"标准输出"（stdout）上面.Curl 是一个命令行工具，用来通过 HTTP（s），FTP 等其它几十种你可能尚未听说过的协议来发起网络请求。

## 使用

* -i:--include Include protocol response headers in the output
* -v:--verbose       Make the operation more talkative

```sh
curl -X POST \
  http://localhost:8080/ \
  -H 'cache-control: no-cache' \
  -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
  -F 'html=@/example'

curl http://www.baidu.com
curl http://www.baidu.com > /tmp/baidu.html # save html

curl -o /tmp/baidu.html http://www.baidu.com # 保存文件
curl -d "name=test&page=1" http://www.baidu.com // -d 参数指定表单以POST的形式执行。
curl -I  http://www.baidu.com  # 只显示http response的头信息
curl -v www.baidu.com #  -v参数可以显示一次http通信的整个过程，包括端口连接和http request头信息
curl --trace output.txt www.baidu.com # 查看更详细的通信过程
curl --trace-ascii output.txt www.baidu.com
curl --referer http://www.example.com http://www.example.com # 在http request头信息中，提供一个referer字段，表示你是从哪里跳转过来的

curl example.com/form.cgi?data=xxx
curl -X POST --data "data=xxx" example.com/form.cgi
curl -X POST--data-urlencode "date=April 1" example.com/form.cgi
curl -X POST www.example.com  #  curl默认的HTTP方法是GET，使用-X参数可以支持其他动词。
curl -X DELETE www.example.com

# 上传文件
curl --header "Content-Type:application/json" http://example.com    # 增加一个头信息
curl --user-agent "[User Agent]" [URL] # User Agent字段:这个字段是用来表示客户端的设备信息。服务器有时会根据这个字段，针对不同设备，返回不同格式的网页
curl -i -X POST --url http://localhost:8001/apis/ --data 'upstream_url=http://camp.uats.cc' --data 'request_path=login' # i:显示http response的头信息，连同网页代码一起

curl -L www.sina.com # 网址自动跳转的 跳转到新网址
curl --user name:password example.com # http认证

curl --cookie "name=xxx" www.example.com # curl发送cookie，具体的cookie的值，可以从http response头信息的`Set-Cookie`字段中得到
curl -c cookies http://example.com # 可以保存服务器返回的cookie到文件
curl -b cookies http://example.com # 使用这个文件作为cookie信息，进行后续的请求
```

## Notice

* network
    - ping
    - network timeout

## tool

* [jakubroztocil/httpie](https://github.com/jakubroztocil/httpie)Modern command line HTTP client – user-friendly curl alternative with intuitive UI, JSON support, syntax highlighting, wget-like downloads, extensions, etc. <https://httpie.org> <https://twitter.com/clihttp>

## 参考

* [文档](https://ec.haxx.se/)
* [Gitbook](https://www.gitbook.com/book/bagder/everything-curl/details)
