# Curl

curl is used in command lines or scripts to transfer data.

```sh
curl -X POST \
  http://localhost:8080/ \
  -H 'cache-control: no-cache' \
  -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
  -F 'html=@/example'

curl http://www.baidu.com 
curl http://www.baidu.com > /tmp/baidu.html // save html 
curl -o /tmp/baidu.html http://www.baidu.com
curl -d "name=test&page=1" http://www.baidu.com // -d 参数指定表单以POST的形式执行。
curl -I  http://www.baidu.com  // 只展示Header
curl -v www.baidu.com //  -v参数可以显示一次http通信的整个过程，包括端口连接和http request头信息
curl --trace output.txt www.baidu.com
curl --trace-ascii output.txt www.baidu.com
curl -X POST www.example.com  //  curl默认的HTTP方法是GET，使用-X参数可以支持其他动词。
curl -X DELETE www.example.com
curl --referer http://www.example.com http://www.example.com  表示你是从哪里跳转过来的。
curl --header "Content-Type:application/json" http://example.com    // 增加一个头信息
User Agent字段:这个字段是用来表示客户端的设备信息。服务器有时会根据这个字段，针对不同设备，返回不同格式的网页
curl --user-agent "[User Agent]" [URL]

curl -i -X POST --url http://localhost:8001/apis/ --data 'upstream_url=http://camp.uats.cc' --data 'request_path=login'  
```

## 参考

* [文档](https://ec.haxx.se/)
* [Gitbook](https://www.gitbook.com/book/bagder/everything-curl/details)
